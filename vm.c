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


pte_t*
nonStaticWalkpgdir(pde_t *pgdir, const void *va, int alloc)
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
// betfen V2P(end) and the end of physical memory (PHYSTOP)
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

  if(newsz >= KERNBASE)
    return 0;

  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){

    #ifndef NONE
      if(myproc()->nPgsPhysical >= MAX_PSYC_PAGES){
        writePageToSwapFile();
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
  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
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
      char *v = P2V(pa);
      kfree(v);


      #ifndef NONE
      struct proc *p = myproc();
      int i;
      for(i = 0; i < MAX_PSYC_PAGES; i++){
          if(i==MAX_PSYC_PAGES){
            cprintf("%d\n",a);
            panic("deallocuvm: cant find page1");
          }
          if(p->physicalPGs[i].va == (char*)v){
            removePhysicalNode(v);
            break;
          }if(p->swappedPGs[i].va == (char*)v){
            p->swappedPGs[i].va = (char*) 0xffffffff;
            p->swappedPGs[i].offset = -1;

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
    if(myproc()->pid>2){
      if(*pte & PTE_PG){
        pte = walkpgdir(d,(void*)i,1);
        *pte= PTE_U | PTE_W | PTE_PG;
      /* if(mappages(d, (void*)i, PGSIZE, pa, PTE_W | PTE_U | PTE_PG) < 0) {
          goto bad;
        }*/
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
    }else{
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
    }
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
  }
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
/************************************************************************   Algorithems Utils    ***************************************************************/
/***************************************************************************************************************************************************************/
int 
scfifoLastPageIndex(){/****************************************************************************     SCFIFO      *********/
  struct proc *p = myproc();
  struct procPG *page = &p->physicalPGs[p->headPG];

  if(!page->next){
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
  {
      page->next->prev = page;
      page = page->next;
  }
  p->physicalPGs[p->headPG].prev = page;
  uint tailVa = (uint) page->va;

  pte_t *pte;
  do{ 
    pte = walkpgdir(p->pgdir,(void*)page->va,0);
    if(*pte & PTE_A){
      *pte &= ~PTE_A;
    }else{
      return indexInPhysicalMem((uint)page->va);
    }
    page = page->prev;
    i--;
  }while ((uint)page->va != tailVa);

  return indexInPhysicalMem((uint)page->va);
}

int 
aqLeastAgeIndex(){/****************************************************************************        AQ        *********/
  struct proc *p = myproc();
  struct procPG *page = &p->physicalPGs[p->headPG];

  if(!page->next){
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
  {
      page = page->next;
  }
  return indexInPhysicalMem((uint)page->va);
}

int
nfuaLeastAgeIndex(){/**********************************************************************************      NFUA       *********/
  struct proc *p = myproc();
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
      leastIndex = i;
      leastAge = p->physicalPGs[i].age;
    }
  }
  if(leastIndex == -1){
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;
}

int
lapaLeastAgeIndex(){/**********************************************************************************      LAPA       *********/
  struct proc *p = myproc();
  uint leastAge = __UINT32_MAX__;
  uint leastAgeSetCount = 32;
  int leastIndex = -1;
  uint count;
  uint tempAge;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
    if(p->physicalPGs[i].va != (char*)0xffffffff){
      tempAge = p->physicalPGs[i].age;
      count = 0; 
      while (tempAge) { 
          count += tempAge & 1; 
          tempAge >>= 1; 
      } 
      if(count<=leastAgeSetCount){
        if(count == leastAgeSetCount &&  p->physicalPGs[i].age <= leastAge){
          leastIndex = i;
          leastAge = p->physicalPGs[i].age;
          leastAgeSetCount = count;
        }
        
      }
    }
  }
  if(leastIndex == -1){
    panic("lapaLeastAge : could not find age >= 0");
  }
  return leastIndex;
}


int
pageIndexToWrite(){
  #ifdef NFUA
    return nfuaLeastAgeIndex();
  #endif
  #ifdef SCFIFO
    return scfifoLastPageIndex();
  #endif
  #ifdef LAPA
    return lapaLeastAgeIndex();
  #endif
  #ifdef AQ
    return aqLeastAgeIndex();
  #endif
  panic("no def in pageIndexToWrite");
}

/***************************************************************************************************************************************************************/
/****************************************************************************    Nodes    **********************************************************************/
/***************************************************************************************************************************************************************/

void
addSwappedNode(char* addr){
  struct proc *p = myproc();
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i== MAX_PSYC_PAGES){
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == EMPTY_VA){
      p->swappedPGs[i].offset = i*PGSIZE;
      p->swappedPGs[i].va =(char*)PGROUNDDOWN((uint)addr);
      return;
    }
  }
}

void
removePhysicalNode(char* va){
  struct proc *p = myproc();
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i==MAX_PSYC_PAGES){
      //cprintf("addres was: %x\n",(uint)va);
      panic("removePhysicalNode: cannot find phy page");
    }
    if(p->physicalPGs[i].va ==(char*) PGROUNDDOWN((uint)va)){
      p->physicalPGs[i].va = EMPTY_VA;
      p->physicalPGs[i].age = 0;
      p->physicalPGs[i].alloceted = 0;
      #ifdef LAPA
        p->physicalPGs[i].age = 0xffffffff;
      #endif
      #if defined(SCFIFO) || defined(AQ)
      if(p->headPG == i){
        p->headPG = indexInPhysicalMem((uint)p->physicalPGs[i].next->va);
        p->physicalPGs[i].next->prev = (void*)0;
        return;
      }
      if(p->physicalPGs[i].prev){
        p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
      }
      #endif
      return;
    }
  }
}


void
addPhysicalNode(uint addr){
  struct proc *p = myproc();
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
    if(i==MAX_PSYC_PAGES){
      panic("addPhysicalNode: cannot allocate phy page");
    }
    if(p->physicalPGs[i].va == EMPTY_VA){
      p->physicalPGs[i].va = (char*)PGROUNDDOWN(addr);
      p->physicalPGs[i].age = 0;
      p->physicalPGs[i].alloceted = 1;

      #ifdef LAPA
        p->physicalPGs[i].age = 0xffffffff;
      #endif
      #if defined(SCFIFO) || defined(AQ)
        if(p->headPG == -1){
          p->physicalPGs[i].prev = 0;
          p->physicalPGs[i].next = 0;
        }
        if(p->physicalPGs[i].prev){
          p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
        }
        p->physicalPGs[i].next = &p->physicalPGs[p->headPG];
        p->physicalPGs[p->headPG].prev = &p->physicalPGs[i];
        p->physicalPGs[i].prev = 0;
        p->headPG = i;
      #endif
      myproc()->nPgsPhysical++;
      return;
    }
  }
}


void
clearSwapPage(int index){
  struct proc *p = myproc();
  p->nPgsSwap--;
  p->swappedPGs[index].va = EMPTY_VA;
}

/***************************************************************************************************************************************************************/
/**************************************************************************    Indexing    *********************************************************************/
/***************************************************************************************************************************************************************/

int
indexInSwapFile(uint addr){
  
  struct proc *p =myproc();
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
    if(p->swappedPGs[i].va == (char*) PGROUNDDOWN(addr)){
      return i;
    }
  }
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){

    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}

int
indexInPhysicalMem(uint addr){
  struct proc *p =myproc();
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
    if(p->physicalPGs[i].va == (char*) PGROUNDDOWN(addr)){
      return i;
    }else{
      //cprintf("addr : %x\n",p->physicalPGs[i].va);
    }
  }
  cprintf("tried find : %x\n",addr);
  panic("scfifoSwap: could not find page in physical mem");
  return -1;
}


/***************************************************************************************************************************************************************/
/*********************************************************************   Paging Operations     *****************************************************************/
/***************************************************************************************************************************************************************/

// swaps out a page
void
writePageToSwapFile(){
  //cprintf("write %x\n",va);
  struct proc *p = myproc();
  struct procPG *pageToWrite = &p->physicalPGs[pageIndexToWrite()];

  pte_t *pte = walkpgdir(p->pgdir, (void*)pageToWrite->va, 0);

  addSwappedNode(pageToWrite->va);

  acquire(&tickslock);
  if(*pte & PTE_A){
    *pte &= ~PTE_A;
  }
  release(&tickslock);


  int offset = p->swappedPGs[indexInSwapFile((uint)pageToWrite->va)].offset;


  if(writeToSwapFile(p,(char*)PTE_ADDR(pageToWrite->va),offset, PGSIZE)<=0){
    panic("scfifoWriteToSwap: writeToSwapFile");
  }

  kfree((char*)(P2V(PTE_ADDR(*pte))));


  //}
  *pte |= PTE_PG;
  *pte &= ~PTE_P;
  //*pte &= ~PTE_COW;

  removePhysicalNode(pageToWrite->va);

  lcr3(V2P(p->pgdir));  // switch to process's address space
  

 
  myproc()->nPgsPhysical--;
  myproc()->nTotalPGout++;
  myproc()->nPgsSwap++;
}

void 
swapPage(uint addr){
  pte_t *pte;
  char* buf;
  struct proc *p = myproc();
  int swapIndex = indexInSwapFile(addr);

  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
    writePageToSwapFile();
  }

  if((buf = kalloc()) == 0){
    panic("nfuaSwap : allocating buf");
  }

  memset(buf, 0, PGSIZE );
  
  if(readFromSwapFile(p, buf, swapIndex*PGSIZE, PGSIZE) <= 0){
      panic("scfifoSwap: read from swapfile");
  }

  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
  
  clearSwapPage(swapIndex);

  pte = walkpgdir(p->pgdir,(void*)addr, 0);
  *pte |= PTE_P | PTE_W;
  *pte &= ~PTE_COW;
  *pte &= ~PTE_PG;

  
  addPhysicalNode(addr);
  
  lcr3(V2P(p->pgdir));
}

int
initPhysicalPage(char *va){
  addPhysicalNode((uint) va);
  return 0;
}



//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.
//PAGEBREAK!
// Blank page.