#include "types.h"
#include "stat.h"
#include "user.h"
#define PGSIZE          4096

int
cowPhysicalTest(){
  int testerPid = fork();
  if(testerPid==0){
    printf(1,"cowPhysicalTest :");
    int* lst[3];
    int volatile i;
    for(i = 0; i < 3; i++){
      lst[i] = (int*)sbrk(PGSIZE);
      //printf(1,"making space %d\n",((uint)(lst[i])));
      *lst[i]=i;
    }
    int freePages_beforeChild = getNumberOfFreePages();
    sleep(10);

    int pid = fork();
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
    sleep(10);

    if(pid==0){
      for(i = 0; i < 3; i++){
        if(*lst[i]!=i){
          printf(1," FAILED");
          return -1;
        }
      }
      int freePages_beforeCloning = getNumberOfFreePages();

      if(freePages_beforeReadingFromParent != freePages_beforeCloning){
        printf(1,"Err : num of free pages after reading only has changed");
        printf(1," FAILED");
        return -1;
      }
      *lst[1] = 66;

      if(freePages_beforeCloning != getNumberOfFreePages()+1){
        printf(1,"Err : num of free pages after cloning");
        printf(1," FAILED");
        return -1;
      }
      sleep(10);

      exit();
    }
    wait();
    if(*lst[1]);
    if(freePages_beforeChild != getNumberOfFreePages()){
      printf(1,"Err : num of free pages after child exit");
      printf(1," FAILED");
      return -1;
    }


    exit();
  }else{
    wait();
    return 0;
  }


  
}


int 
cowSwapFileTest(){
  int testerPid = fork();
  if(testerPid==0){
    printf(1,"cowSwapFileTest :");
    int* lst[20];
    int volatile i;
    for(i = 0; i < 15; i++){
      lst[i] = (int*)sbrk(PGSIZE);
      *lst[i]=i;
    }

    int pid = fork();

    if(pid==0){
      for(i = 0; i < 15; i++){
        //printf(1,"%d ",i);

        if(*lst[i]!=i){
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);

          printf(1," FAILED");
          return -1;
        }
      }
      exit();
    }
    int j;
    for(j = 0; j < 15; j++){
        //printf(1,"%d ",j);

        if(*lst[j]!=j){
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
  
          printf(1," FAILED");
          return -1;
        }
      }
    wait();

    //printf(1,"parent exit now\n");

    exit();
  }else{
    wait();
    return 0;
  }
}

int
PhysicalMemTest(){
  int testerPid = fork();
  if(testerPid==0){
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
    exit();
  }else{
    wait();
    return 0;
  }
}

int
SwapFileTest(){
  printf(1,"SwapFileTest :");
  int* lst[20];
  int volatile i;
  for(i = 0; i < 20; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    //printf(1,"making space %d\n",((uint)(lst[i])));
    *lst[i]=i;
  }
  for(i = 0; i < 20; i++){
    if(*lst[i]!=i){
      printf(1," FAILED");
      return -1;
    }
    //printf(1,"%d ",i);
  }
  return 0;
}

void
printResult(int res){
  if(res == -1){
    printf(1," FAILED\n");
  }else{
    printf(1," PASSED\n");
  }
}

int
main(int argc, char *argv[]){
  printResult(cowPhysicalTest());
  printResult(cowSwapFileTest());
  //printf(1,"yes2\n");

  printResult(PhysicalMemTest ());
  printResult(SwapFileTest());
  exit();
}


