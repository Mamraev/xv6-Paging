#include "param.h"
#include "types.h"
#include "defs.h"
#include "x86.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
int
indexInPhysicalMem(struct procPG *pg){
  struct proc *p =myproc();
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){

    if(p->physicalPGs[i].va == pg->va){
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}


void 
movePageToHead(struct procPG *pg){
  
  struct proc *p = myproc();

  if(p->headPG==-1){
    panic("aaa");
  }
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

void 
movePageToTail(struct procPG *pg){
  
  struct proc *p = myproc();

  if(p->headPG==-1){
    panic("aaa");
  }
  if(pg->prev){
    pg->prev->next = pg->next;
  }
  if(pg->next){
    pg->next->prev = pg->prev;
  }

  struct procPG *tempPG = &p->physicalPGs[p->headPG];
  while (tempPG->next && tempPG->next->va !=(char*)0xffffffff)
  {
    tempPG = tempPG->next;
  }
  
  tempPG->next = pg;
  pg->prev = tempPG;
  

}

void freePageFromList(struct procPG *pg){
  struct proc *p = myproc();
  if(p->physicalPGs[p->headPG].va == pg->va){
    int i = 0;
    for(i = 0; i < MAX_PSYC_PAGES ; i++){
      if(p->physicalPGs[i].va == pg->next->va){
        pg->va = (char*)0xffffffff;
        pg->next = 0;
        pg->prev = 0;
        p->headPG = i;
        p->physicalPGs[i].prev = 0;
        
        return;
      }
    }
  }
  if(pg->prev){
    pg->prev->next = pg->next;
  }
  if(pg->next){
    pg->next->prev = pg->prev;
  }

  pg->va = (char*)0xffffffff;
  pg->next = 0;
  pg->prev = 0;
  
  return;
}

