#include "types.h"
#include "stat.h"
#include "user.h"
#define PGSIZE          4096

void  printResult(int);

int
cowPhysicalTest(){
  printf(1,"cowPhysicalTest :");
  int* lst[3];
  int volatile i;
  for(i = 0; i < 3; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }
  int freePages_beforeChild = getNumberOfFreePages();
  int pid = fork();

  int freePages_beforeReadingFromParent = getNumberOfFreePages();
  sleep(10);
  if(pid==0){
    for(i = 0; i < 3; i++){
      if(*lst[i]!=i){
        printf(1," FAILED");
        exit();
      }
    }
    sleep(50);
    int freePages_beforeCloning = getNumberOfFreePages();

    if(freePages_beforeReadingFromParent != freePages_beforeCloning){
      printf(1,"Err : num of free pages after reading only has changed");
      printf(1," FAILED");
      exit();
    }
    *lst[1] = 66;
    sleep(50);

    if(freePages_beforeCloning != getNumberOfFreePages()+1){
      printf(1,"Err : num of free pages after cloning");
      printf(1," FAILED");
      exit();
    }
    sleep(10);
    exit();
  }
  wait();
  if(freePages_beforeChild != getNumberOfFreePages()){
    printf(1,"before: %d    after: %d",freePages_beforeChild,getNumberOfFreePages());
    printf(1,"Err : num of free pages after child exit");
    printf(1," FAILED");
    sleep(50000);
    return -1;
  }
  return 0;
}


int 
cowSwapFile_pageSeperationTest(){
  printf(1,"cowSwapFile_pageSeperationTest :");
  int* lst[20];
  int volatile i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }
  int pid = fork();
  if(pid==0){
    for(i = 0; i < 20; i++){
      if(*lst[i]!=i){
        printf(1,"\nchild fail %d %d\n",*lst[i], i);
        printf(1," FAILED");
      }
    }
    exit();
  }
  int j;
  for(j = 0; j < 20; j++){
      if(*lst[j]!=j){
        printf(1,"\nparent fail %d %d\n",*lst[j], j);

        printf(1," FAILED");
        return -1;
      } 
    }
  wait();
  return 0;
}

int 
cowSwapFile_maxPhyInChildTest(){
  int freePages = getNumberOfFreePages();
  printf(1,"cowSwapFile_maxPhyInChildTest :");
  int* lst[20];
  int i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }

  int freePagesAfterSBRK = getNumberOfFreePages();
  if(freePages > getNumberOfFreePages()+16){
    printf(1," FAILED 1(Free Memory error) %d\n",getNumberOfFreePages());
    exit();
  }
  int pid = fork();
  if(pid==0){
    int freePagesAfterFork = getNumberOfFreePages();
    if(freePagesAfterFork  + 68 != freePagesAfterSBRK){
    printf(1," FAILED 2(Free Memory error) %d %d\n",freePagesAfterFork,freePagesAfterSBRK);
    exit();
    }

    for(i = 0; i < 20; i++){
      *lst[i]= i + 50;
    }
    if(freePagesAfterFork > getNumberOfFreePages()+16){
      printf(1," FAILED 3(Free Memory error)%d\n",getNumberOfFreePages());
      exit();
    }
    exit();
  }
  wait();
  for(i = 0; i < 20; i++){
      if(*lst[i]!=i){
        printf(1,"\nparent fail %d %d\n",*lst[i]!=i);
        printf(1," FAILED");
        return -1;
      }
    }

    if(freePages >getNumberOfFreePages()+16){
      printf(1," FAILED 4(Free Memory error)\n");
    }
  return 0;
}


// Test if pages that has been changed by child remain the same in its parent memory.
int 
cowSwapFile_killedChiledTest(){
  printf(1,"cowSwapFile_killedChiledTest :");
  int* lst[20];
  int volatile i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }
  int pid = fork();
  if(pid==0){

    for(i = 0; i < 20; i++){
      if(*lst[i]!=i){
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
        printf(1," FAILED");
        return -1;
      }
    }
    for(i = 0; i < 20; i++){
      *lst[i] = 66;
      if(*lst[i]!=66){
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
        printf(1," FAILED");
        return -1;
      }
    }
    exit();
  }
  wait();
  int j;
  for(j = 0; j < 20; j++){
      if(*lst[j]!=j){
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
        printf(1," FAILED");
        return -1;
      }
  }
  return 0;
}


int
PhysicalMemTest(){
  printf(1,"PhysicalMemTest :");
  int* lst[5];
  int volatile i;
  for(i = 0; i < 5; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }
  for(i = 0; i < 5; i++){
    if(*lst[i]!=i){
      printf(1," FAILED");
      return -1;
    }
  }
  return 0;
}

int
SwapFileTest(){
  printf(1,"SwapFileTest :");
  int* lst[20];
  int i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }
  sleep(50);
  for(i = 0; i < 20; i++){
    if(*lst[i]!=i){
      printf(1," FAILED %d %d",*lst[i],i);
      return -1;
    }
  }
  return 0;
}

int
memLeakTest(int freeMem){
  printf(1,"memLeakTest :");

  if(freeMem != getNumberOfFreePages()){
      printf(1, "FAILED    expected: %d     got : %d\n",freeMem,getNumberOfFreePages());
  }else{
    printf(1, "PASSED\n");
  }
  return 0;
}


void
makeTest(int (*test)()){
  int testerPid = fork();
  
  if(testerPid==0){
    if(test()==0){
      printf(1," PASSED\n");
    }
    exit();
  }
  wait();
  
} 



int
main(int argc, char *argv[]){
  
  int freeMem = getNumberOfFreePages();
  
  //  Cow Tests:
  makeTest(cowPhysicalTest);
  makeTest(cowSwapFile_pageSeperationTest);
  makeTest(cowSwapFile_killedChiledTest);
  makeTest(cowSwapFile_maxPhyInChildTest);
  
  // General Page Tests:
  makeTest(PhysicalMemTest);
  makeTest(SwapFileTest);
  memLeakTest(freeMem);
  exit();
}


