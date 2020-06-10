#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

#ifdef NONE
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;

    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
#endif
// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      /*#ifdef NFUA
        ageTickUpdate();
      #endif
      #ifdef LAPA
        ageTickUpdate();
      #endif*/
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  case T_PGFLT:
    #ifndef NONE
    // TODO: Chek for illigal addr
    
      #ifdef NFUA
        ageTickUpdate();
      #endif
      #ifdef LAPA
        ageTickUpdate();
      #endif
      
      /*if(myproc()->pid<=2){

        lapiceoi();
        break;
      }*/

      addr = rcr2();
      //pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
      //pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
      //pte_t *pte = &pgtab[PTX(addr)];
      pte_t *pte = walkpgdir(myproc()->pgdir,(char*)addr,0);
      uint pa = PTE_ADDR(*pte);

      //int inSwapFile = (((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG);
      //cprintf("first %x %x\n",pa,addr);
      

      if((*pte & PTE_U ) == 0){
        break;
      }

      //cprintf("trap!\n");

      //cprintf("PGFLT: ");
      if(*pte & PTE_PG){
        //cprintf("swapping: %x\n",PGROUNDDOWN(addr));
        myproc()->nPGFLT++;
        swapPage(addr);
        lcr3(V2P(myproc()->pgdir));
      }
      else if((*pte & PTE_W) == 0) {
        int k = 0;
        for(k = 0 ; k <  MAX_PSYC_PAGES; k++){
          
          if(myproc()->physicalPGs[k].va == (char*)PGROUNDDOWN(addr)){
            myproc()->physicalPGs[k].alloceted = 1;
            myproc()->physicalPGs[k].age = 0;
            #ifdef LAPA
              myproc()->physicalPGs[k].age = 0xffffffff;
            #endif
            break;
          }
        }
        if((*pte & PTE_COW) != 0){
          //cprintf("write %x\n",PGROUNDDOWN(addr));
          uint refCount = getReferenceCount(pa);
          char *mem;
          if(refCount > 1) {

          
            
            if((mem = kalloc()) == 0) {
              cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
              myproc()->killed = 1;
              return;
            }

            memmove(mem, (char*)P2V(pa), PGSIZE);
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
            *pte &= ~PTE_COW;

            lcr3(V2P(myproc()->pgdir));
            decrementReferenceCount(pa);

          }
          // Current process is the last one that tries to write to this page
          // No need to allocate new page as all other process has their copies already
          else {
            //myproc()->allocatedInPhys++;

            // remove the read-only restriction on the trapping page
            //cprintf("noder pid: %d\n",myproc()->pid);
            *pte |= PTE_W;
            *pte &= ~PTE_COW;
            lcr3(V2P(myproc()->pgdir));
          }
      }
        
      }/*else{
        cprintf("pid: %d\n",myproc()->pid);
        panic("trap: PF fault");
      }*/
      
      lcr3(V2P(myproc()->pgdir));



    #endif

    break;



  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
