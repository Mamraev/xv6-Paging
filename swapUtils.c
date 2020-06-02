#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"

void 
movePageToHead(struct procPG *pg){
  struct proc *p = myproc();
  if(pg->prev){
    pg->prev->next = pg->next;
  }
  if(pg->next){
    pg->next->prev = pg->prev;
  }

  pg->next = &p->physicalPGs[p->headPG];
  pg->prev = 0;
  p->physicalPGs[p->headPG].prev = pg;
}

