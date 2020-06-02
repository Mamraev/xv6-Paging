#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

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
  uint addr;
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
  // TODO: Chek for illigal addr
    addr = rcr2();
    pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
    pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
    pte_t *pte = &pgtab[PTX(addr)];
    uint pa = PTE_ADDR(*pte);

    //int inSwapFile = (((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG);
    uint refCount = getReferenceCount(pa);



    //cprintf("PGFLT: ");
    if((*pte & PTE_PG ) != 0){
      //cprintf("OK\n");
      swapPage(PTE_ADDR(addr));
      break;
    }else if(((*pte & PTE_W) == 0) && ((*pte & PTE_U) != 0)){
      
      // get the reference count of the current page
      //uint refCount = getReferenceCount(pa);
        //cprintf("NOT OK %d\n",refCount);

      char *mem;

      // Current process is the first one that tries to write to this page
      if(refCount > 1) {
        //DEBUG_PRINT("trap refCount>1");
        //cprintf("couple of refs\n");

        // allocate a new memory page for the process
        if((mem = kalloc()) == 0) {
          cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
          myproc()->killed = 1;
          return;
        }

        // copy the contents from the original memory page pointed the virtual address
        memmove(mem, (char*)P2V(pa), PGSIZE);
        // point the given page table entry to the new page
        *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;

        // Since the current process now doesn't point to original page,
        // decrement the reference count by 1
        decrementReferenceCount(pa);
        lcr3(V2P(myproc()->pgdir));
      }
      // Current process is the last one that tries to write to this page
      // No need to allocate new page as all other process has their copies already
      else if(refCount == 1){
        // remove the read-only restriction on the trapping page
        //cprintf("noder pid: %d\n",myproc()->pid);
        *pte |= PTE_W;
      }else{
        cprintf("count: %d\n",refCount);
        //panic("trap PTE_W : recCount<1");
      }
    }else{
      cprintf("pid: %d\n",myproc()->pid);
      panic("trap: PF fault");
    }
    lcr3(V2P(myproc()->pgdir));

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
