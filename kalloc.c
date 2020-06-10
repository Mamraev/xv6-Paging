// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"

#define index(page_addr) (page_addr/PGSIZE)

void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
  uint free_pages; 
  uint totalFreePGs;
  uint pg_refcount[PHYSTOP/PGSIZE];
} kmem;

// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  kmem.free_pages = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{

  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
    //kmem.pg_refcount[index(V2P(p))] = 0;
    kfree(p);
  }
}

void
recordTotalFreePages(){
  if(kmem.use_lock)
    acquire(&kmem.lock);
  kmem.totalFreePGs =  kmem.free_pages;
  if(kmem.use_lock)
    release(&kmem.lock);
}

int
getTotalFreePages(){
  uint result;
  if(kmem.use_lock)
    acquire(&kmem.lock);
  result =  kmem.totalFreePGs;
  if(kmem.use_lock)
    release(&kmem.lock);
  return result;
}
//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree1");

  if(kmem.use_lock)
    acquire(&kmem.lock);
  
  r = (struct run*)v;

  #ifndef NONE
  if(kmem.pg_refcount[index(V2P(v))] > 0){
    --kmem.pg_refcount[index(V2P(v))];
  }
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
    kmem.free_pages++;
    r->next = kmem.freelist;
    kmem.freelist = r;
  }
  #endif
  
  #ifdef NONE
  memset(v, 1, PGSIZE);
  
  r->next = kmem.freelist;
  kmem.freelist = r;

  #endif

  if(kmem.use_lock)
    release(&kmem.lock);
}
  

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r){
    kmem.freelist = r->next;
    #ifndef NONE
    kmem.free_pages--;
    kmem.pg_refcount[index(V2P((char*)r))] = 1;
    #endif
  }

  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

uint numFreePages(){
  acquire(&kmem.lock);
  uint free_pages = kmem.free_pages;
  release(&kmem.lock);
  return free_pages;
}

void resetRefCounter(uint pa){
  kmem.pg_refcount[index(pa)] = 1;
}

void decrementReferenceCount(uint pa)
{
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("3");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
  --kmem.pg_refcount[index(pa)];
  release(&kmem.lock);

}

void incrementReferenceCount(uint pa)
{
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("2");
  // }
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
  ++kmem.pg_refcount[index(pa)];
  release(&kmem.lock);
}

void setReferenceCount(uint pa,int n)
{

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
    panic("setReferenceCount");

  acquire(&kmem.lock);
  kmem.pg_refcount[index(pa)]= n;
  release(&kmem.lock);
}

uint getReferenceCount(uint pa)
{
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("1");
  // }

  if( pa >= PHYSTOP)
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
  count = kmem.pg_refcount[index(pa)];
  release(&kmem.lock);

  return count;
}

