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
    //printf(1,"making space %d\n",((uint)(lst[i])));
    *lst[i]=i;
  }
  int freePages_beforeChild = getNumberOfFreePages();
  //sleep(10);
  int pid = fork();

  int freePages_beforeReadingFromParent = getNumberOfFreePages();
  sleep(10);
  if(pid==0){
    for(i = 0; i < 3; i++){
      if(*lst[i]!=i){
        printf(1," FAILED");
        exit();
        //return -1;
      }
    }
    sleep(50);
    int freePages_beforeCloning = getNumberOfFreePages();

    if(freePages_beforeReadingFromParent != freePages_beforeCloning){
      printf(1,"Err : num of free pages after reading only has changed");
      printf(1," FAILED");
      exit();
      //return -1;
    }
    *lst[1] = 66;
    sleep(50);

    if(freePages_beforeCloning != getNumberOfFreePages()+1){
      printf(1,"Err : num of free pages after cloning");
      printf(1," FAILED");
      exit();
      //return -1;
    }
    sleep(10);
    exit();
  }
  wait();
  //if(*lst[1]);
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
  //sleep(50);
  //printf(1,"fater finish\n");
  int pid = fork();
  if(pid==0){
    for(i = 0; i < 20; i++){
      //printf(1,"%d ",i);
      if(*lst[i]!=i){
        printf(1,"\nchild fail %d %d\n",*lst[i], i);
        printf(1," FAILED");
        //return -1;
      }
    }
    //printf(1,"sleeping\n");
    //sleep(500000);
    exit();
  }
  //sleep(500000);
  int j;
  for(j = 0; j < 20; j++){
      //printf(1,"%d ",j);
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
  //printProcDump(0);
  int freePages = getNumberOfFreePages();
  printf(1,"1  free pages: %d\n",freePages);
  printf(1,"cowSwapFile_maxPhyInChildTest :");
  int* lst[20];
  int i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    *lst[i]=i;
  }

  //printProcDump(0);
  if(freePages != getNumberOfFreePages()+16){
    printf(1," FAILED 1(Free Memory error) %d\n",getNumberOfFreePages());
    //ERROR
  }
  int pid = fork();
  if(pid==0){

    printf(1,"2  free pages: %d\n",getNumberOfFreePages());
    if(freePages != getNumberOfFreePages()+84){
    printf(1," FAILED 2(Free Memory error)\n");
    //ERROR 
    }

    for(i = 0; i < 20; i++){
      
      //printf(1,"%d ",i);
      *lst[i]= i + 50;
    }
    //printProcDump(0);
    if(freePages != getNumberOfFreePages()+100){
      printf(1," FAILED 3(Free Memory error)%d\n",getNumberOfFreePages());
    //ERROR
    }
    printf(1,"3  free pages: %d\n",getNumberOfFreePages());
      //sleep(10000);
    exit();
  }
  wait();
  int j;
  printf(1,"4  free pages: %d\n",getNumberOfFreePages());
  for(j = 0; j < 20; j++){
      //printf(1,"%d ",j);
      if(*lst[j]!=j){
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
        printf(1," FAILED");
        return -1;
      }
    }
    printf(1,"5  free pages: %d\n",getNumberOfFreePages());

    if(freePages != getNumberOfFreePages()+16){
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
      //printf(1,"%d ",i);
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
      //printf(1,"%d ",j);
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
    //printf(1,"making space %d\n",((uint)(lst[i])));
    *lst[i]=i;
  }
  for(i = 0; i < 5; i++){
    if(*lst[i]!=i){
      printf(1," FAILED");
      return -1;
    }
    //printf(1,"%d ",i);
  }
  return 0;
}

int
SwapFileTest(){
  int pid = getpid();
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
  
//makeTest(cowSwapFile_maxPhyInChildTest);
//makeTest(cowPhysicalTest);
//makeTest(SwapFileTest);

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


