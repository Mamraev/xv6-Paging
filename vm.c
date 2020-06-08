#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"

//TODOS : 
//  kill a proc if it attemts to write to memory, but there is insufficient memory to allocate a COW page.

extern char data[];  // defined by kernel.ld
pde_t *kpgdir;  // for use in scheduler()

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
  struct cpu *c;

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
  lgdt(c->gdt, sizeof(c->gdt));
}

// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
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

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}

// There is one page table per process, plus one that's used when
// a CPU is not running any process (kpgdir). The kernel uses the
// current process's page table during system calls and interrupts;
// page protection bits prevent user code from using the kernel's
// mappings.
//
// setupkvm() and exec() set up every page table like this:
//
//   0..KERNBASE: user memory (text+data+stack+heap), mapped to
//                phys memory allocated by the kernel
//   KERNBASE..KERNBASE+EXTMEM: mapped to 0..EXTMEM (for I/O space)
//   KERNBASE+EXTMEM..data: mapped to EXTMEM..V2P(data)
//                for the kernel's instructions and r/o data
//   data..KERNBASE+PHYSTOP: mapped to V2P(data)..PHYSTOP,
//                                  rw data + free physical memory
//   0xfe000000..0: mapped direct (devices such as ioapic)
//
// The kernel allocates physical memory for its heap and for user memory
// between V2P(end) and the end of physical memory (PHYSTOP)
// (directly addressable from end..P2V(PHYSTOP)).

// This table defines the kernel's mappings, which are present in
// every process's page table.
static struct kmap {
  void *virt;
  uint phys_start;
  uint phys_end;
  int perm;
} kmap[] = {
 { (void*)KERNBASE, 0,             EXTMEM,    PTE_W}, // I/O space
 { (void*)KERNLINK, V2P(KERNLINK), V2P(data), 0},     // kern text+rodata
 { (void*)data,     V2P(data),     PHYSTOP,   PTE_W}, // kern data+memory
 { (void*)DEVSPACE, DEVSPACE,      0,         PTE_W}, // more devices
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
}

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  char *mem;
  uint a;  
  
  #ifndef NONE
    struct procPG *pg;
    //int    newPage = 1;
  #endif

  if(newsz >= KERNBASE)
    return 0;

  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){

    #ifndef NONE
      if(myproc()->allocatedInPhys >= MAX_PSYC_PAGES){
        if( (pg = writePageToSwapFile((char*)a)) == 0){
          panic("allocuvm: swapOutPage");
        }
      }
    #endif //ndef NONE
 
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }

    #ifndef NONE
      initPhysicalPage((char*)a);
    #endif

    
    

    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}

// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  #ifndef NONE
    struct proc *p = myproc();
  #endif

  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
    cprintf("\n%d  %d\n",oldsz,newsz);
    return oldsz;
  }

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");

      //
      
      //if(myproc()->pgdir == pgdir){

      //}
      
      
      p->nPgsPhysical--;
      p->allocatedInPhys--;
      char *v = P2V(pa);
      kfree(v);

      #ifndef NONE
      int i;
      for(i = 0; i < MAX_PSYC_PAGES; i++){
          if(i==MAX_PSYC_PAGES){
            cprintf("%d\n",a);
            panic("deallocuvm: cant find page1");
          }
          if(myproc()->physicalPGs[i].va == (char*)v){
            myproc()->physicalPGs[i].va = (char*) 0xffffffff;
            myproc()->physicalPGs[i].alloceted = 0;
            break;
          }
      }
      #endif
      *pte = 0;
  
    }
  }
  return newsz;
}

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));

      kfree(v);
    }
  }
  kfree((char*)pgdir);
}

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
  *pte &= ~PTE_U;
}

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
      panic("copyuvm: page not present");
    
    #ifndef NONE

    if(*pte & PTE_PG){
      pte = walkpgdir(d,(void*)i,1);
      *pte = PTE_U | PTE_W | PTE_PG;
      continue;
    }
    // Task 1
    *pte = *pte & ~PTE_W;
    *pte = *pte | PTE_COW;
  
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
      goto bad;
    }
    incrementReferenceCount(pa);
    #endif

    #ifdef NONE
      char *mem;
      pa = PTE_ADDR(*pte);
      flags = PTE_FLAGS(*pte);

      if((mem = kalloc()) == 0)
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
        kfree(mem);
        goto bad;
      }
    #endif
    //cprintf("increased to: %d\n",getReferenceCount(pa));
  }
  //panic("shit");
  lcr3(V2P(pgdir));
  return d;

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}

/***************************************************************************************************************************************************************/
/******************************************************************************   SCFIFO    ********************************************************************/
/***************************************************************************************************************************************************************/



struct procPG*
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
  struct proc *p = myproc();
  //struct procPG *tempPG;
  pte_t *pte;

  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i== MAX_PSYC_PAGES){
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == (char*)0xffffffff){
      break;
    }
  }

  if(p->headPG==-1){
    panic("scfifoWriteToSwap: empty headPG list");
  }

  struct procPG *lastpg = getLastPageSCFIFO();
 

  p->swappedPGs[i].va = lastpg->va;
  //p->swappedPGs[i].creator = p;

  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
    panic("scfifoWriteToSwap: writeToSwapFile");
  }

  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
  if(!pte){
    panic("scfifoWrite: !pte");
  }


  //decrementReferenceCount(PTE_ADDR(*pte));
  kfree((char*)PTE_ADDR(P2V(*pte)));
  *pte = PTE_W | PTE_U | PTE_PG;

  //sets the empty page to the head of the proc page list
  lastpg->va = (char*)addr;




  movePageToHead(lastpg);

  lcr3(V2P(p->pgdir));  // switch to process's address space

  return lastpg;
}


void
scfifoSwap(uint addr){/******************************************************************************** SCFIFO :  swap *****************************************/
  pte_t *pte1, *pte2;
  char buf[PGSIZE / 4];
  struct proc *p = myproc();

  struct procPG *lastpg = getLastPageSCFIFO();

  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);

  int i = indexInSwapFile(addr);

  p->swappedPGs[i].va = lastpg->va;
  //p->swappedPGs[i].creator = p;

  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
  if(!*pte2){
    panic("scfifoSwap: pte2 empty");
  } 
  
  *pte2 = PTE_ADDR(*pte1) | PTE_U  | PTE_W| PTE_P;

  int j;
  for (j = 0; j < 4; j++) {
    int loc = (i * PGSIZE) + ((PGSIZE / 4) * j);
    int addroffset = ((PGSIZE / 4) * j);

    memset(buf, 0, PGSIZE / 4);
    if(readFromSwapFile(p, buf, loc, PGSIZE / 4) <= 0){
      panic("scfifoSwap: read from swapfile");
    }
    if(writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1)) + addroffset), loc, PGSIZE / 4)<= 0){
      panic("scfifoSwap: read from swapfile");
    }
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
}
  
  *pte1 |= PTE_W | PTE_PG;
  *pte1 &= ~PTE_PG;
  /*if(p->allocatedInPhys>=MAX_PSYC_PAGES){
    *pte1 &= ~PTE_W;
  }*/
  

  lastpg->va = (char*)PTE_ADDR(addr);
  movePageToHead(lastpg);

  lcr3(V2P(p->pgdir));
}

void
initSCFIFO(char *va){/******************************************************************************* SCFIFO :  init *******************************************/
  struct proc *p = myproc();
  int i;
  char* addrToOverwrite = (char*)0xffffffff;
  if(p->allocatedInPhys == 16){
    panic("initSCFIFO");
  }
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
    
      myproc()->nPgsPhysical--;

      addrToOverwrite = getLastPageSCFIFO()->va;
    //p->allocatedInPhys++;
  }
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){

    if(p->physicalPGs[i].va == addrToOverwrite){
      p->physicalPGs[i].va = va;
      p->physicalPGs[i].refs = 1;

      if(p->headPG == -1){
        p->headPG = i;
        return;
      }
      p->headPG = i;
      movePageToHead(&p->physicalPGs[i]);
      return;
    }
  }
}

struct procPG*
getLastPageSCFIFO(){/******************************************************************************** SCFIFO :  getLastPage ***********************************/
  struct proc *p = myproc();

  //#pragma GCC diagnostic ignored "-Wmaybe-uninitialized";
  struct procPG *page = &p->physicalPGs[p->headPG];
  struct procPG *headHolder = &p->physicalPGs[p->headPG];

  if(!page->next){
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical; i++)
  {
      page = page->next;
  }
  pte_t *pte;
  struct procPG *tailHolder = &p->physicalPGs[p->headPG];
  while ((*(pte = walkpgdir(p->pgdir,(void*)page->va,0)) & PTE_A) != 0)
  {
    *pte &= ~PTE_A;
    if(page->va == headHolder->va){
      page = tailHolder; //in case all pages had PTE_A bit, return the last one as fifo
      return page;
    }
    page = page->prev;
  }
  return page;
}

/***************************************************************************************************************************************************************/
/******************************************************************************   NFUA     *********************************************************************/
/***************************************************************************************************************************************************************/

int
leastAgeIndex(){
  struct proc *p = myproc();
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
      leastIndex = i;
      leastAge = p->physicalPGs[i].age;
    }
  }
  if(i == -1){
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;

}

struct procPG*
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
  struct proc *p = myproc();
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);

  p->nPgsPhysical--;
  if(leastAgePG->alloceted){
    p->allocatedInPhys--;
  }

  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i== MAX_PSYC_PAGES){
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == (char*)0xffffffff){
      p->swappedPGs[i].offset = i*PGSIZE;
      p->swappedPGs[i].va = (char*)PTE_ADDR(leastAgePG->va);
      break;
    }
  }


  acquire(&tickslock);
  if(*pte & PTE_A){
    *pte &= ~PTE_A;
  }
  release(&tickslock);

  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
    panic("scfifoWriteToSwap: writeToSwapFile");
  }


  //if(p->allocatedInPhys>MAX_PSYC_PAGES){
  //decrementReferenceCount(PTE_ADDR(*pte));
  kfree((char*)PTE_ADDR(P2V(*pte)));



  //}
  *pte |= PTE_PG;
  *pte &= ~PTE_P;
  //*pte &= ~PTE_COW;

  //sets the empty page to the head of the proc page list
  leastAgePG->va = (char*) 0xffffffff;
  leastAgePG->age = 0 ;
  leastAgePG->alloceted = 0 ;

  //movePageToHead(leastAgePG);

  lcr3(V2P(p->pgdir));  // switch to process's address space

  return leastAgePG;
}

void
nfuaSwap(uint addr){/******************************************************************************** NFUA :  swap *********************************************/
  pte_t *pte2;

  char* buf;

  struct proc *p = myproc();

    

  int i = indexInSwapFile(PTE_ADDR(addr));
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);



          if(p->allocatedInPhys>=MAX_PSYC_PAGES ) {
            if(getReferenceCount(PTE_ADDR(*pte2)) > 1){
              char* newVa = kalloc();
              char* va = (char*)P2V(PTE_ADDR(*pte2));

              memmove((char*)newVa,va, PGSIZE);
              *pte2 = V2P(newVa) | PTE_FLAGS(*pte2) |PTE_P | PTE_W;
              lcr3(V2P(myproc()->pgdir));
              decrementReferenceCount(PTE_ADDR(*pte2));
            }

            *pte2 &= PTE_COW;
            *pte2 |= PTE_W;
            lcr3(V2P(myproc()->pgdir));
          }
  writePageToSwapFile((char*)addr);

  // p->nPgsPhysical++;
  // p->allocatedInPhys++;

  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);



  if((buf = kalloc()) == 0){
    panic("nfuaSwap : allocating buf");
  }
  memset(buf, 0, PGSIZE );
  
  //cprintf("%d swap read from : %d",p->pid,i*PGSIZE);
  if(readFromSwapFile(p, buf, i*PGSIZE, PGSIZE) <= 0){
      panic("scfifoSwap: read from swapfile");
  }

  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
  *pte2 &= ~PTE_P;
  *pte2 |= PTE_PG;

  mappages(p->pgdir,(char*)PTE_ADDR(addr) , PGSIZE , V2P(buf), PTE_W | PTE_U);
  //memmove((void*)(PTE_ADDR(*pte2)),buf,PGSIZE);
  
  //p->swappedPGs[i].va = (char*)0xffffffff;
  
  
  

  *pte2 |= PTE_P;
  //*pte2 &= ~PTE_COW;
  *pte2 &= ~PTE_PG;
  
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i==MAX_PSYC_PAGES){
      panic("cannot allocate phy page nfuaSwap");
    }
    if(p->physicalPGs[i].va == (char*)0xffffffff){
      p->physicalPGs[i].va = (char*)PTE_ADDR(addr);
      p->physicalPGs[i].age = 0;
      p->physicalPGs[i].alloceted = 1;
      break;
    }
  }

  p->nPgsPhysical++;
  if(p->physicalPGs[i].alloceted){
    p->allocatedInPhys++;
  }

  lcr3(V2P(p->pgdir));
}

void
initNFUA(char *va){/******************************************************************************* NFUA :  init ***********************************************/
  struct proc *p = myproc();
  int i;
  char* addrToOverwrite = (char*)0xffffffff;
  if(p->allocatedInPhys == 16){
    cprintf("initNFUA\n");
  }
 /* if(p->nPgsPhysical>=MAX_PSYC_PAGES){

      myproc()->nPgsPhysical--;

      addrToOverwrite = p->physicalPGs[leastAgeIndex()].va;
    //p->allocatedInPhys++;
  }*/
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){

    if(p->physicalPGs[i].va == addrToOverwrite){
      p->physicalPGs[i].va = va;
      p->physicalPGs[i].age = 0;
      p->physicalPGs[i].alloceted = 1;
      //p->headPG = i;
      //movePageToHead(&p->physicalPGs[i]);
      return;
    }
  }
}
/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/
int
indexInSwapFile(uint addr){
  struct proc *p =myproc();
  int i;
  for(i = 0 ; i < p->nPgsSwap; i++){

    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}


// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
  //cprintf("write\n");
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap(PGROUNDDOWN((uint)va));
  #endif
  #ifdef NFUA
    retPG=nfuaWriteToSwap((uint)va);
  #endif
  myproc()->nPgsSwap++;


  

  //new page for the current proc only, set its ref to 1
  /*pte_t *pte = walkpgdir(myproc()->pgdir,va,0);
  uint pa = PTE_ADDR(*pte);
  uint refCount = getReferenceCount(pa);
  while (refCount>1)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}

void 
swapPage(uint addr){
  //cprintf("swap\n");

  #ifdef SCFIFO
    return scfifoSwap(PGROUNDDOWN((uint)addr));
  #endif

  #ifdef NFUA
    return nfuaSwap(addr);
  #endif

}

int
initPhysicalPage(char *va){

  #ifdef SCFIFO
    initSCFIFO(va);
  #endif
  #ifdef NFUA
    initNFUA(va);
  #endif

  myproc()->nPgsPhysical++;
  myproc()->allocatedInPhys++;
  //cprintf("%d chikd : %d\n",myproc()->pid,myproc()->allocatedInPhys);


  return 0;
}



//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.