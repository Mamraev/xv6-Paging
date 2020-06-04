#include "types.h"
#include "stat.h"
#include "user.h"
#define PGSIZE          4096

void  printResult(int);

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
cowSwapFile_pageSeperationTest(){
  int testerPid = fork();
  if(testerPid==0){
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
    for(j = 0; j < 20; j++){
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
cowSwapFile_maxPhyInChildTest(){
  int testerPid = fork();
  if(testerPid==0){
    int freePages = getNumberOfFreePages();
    //printf(1,"1  free pages: %d\n",getNumberOfFreePages());
    printf(1,"cowSwapFile_maxPhyInChildTest :");
    int* lst[20];
    int i;
    for(i = 0; i < 20; i++){
      lst[i] = (int*)sbrk(PGSIZE);
      *lst[i]=i;
    }
    if(freePages != getNumberOfFreePages()+16){
      printf(1," FAILED (Free Memory error)\n");
      //ERROR
    }
    int pid = fork();
    if(pid==0){
      if(freePages != getNumberOfFreePages()+84){
      printf(1," FAILED (Free Memory error)\n");
      //ERROR
      }
      //printf(1,"2  free pages: %d\n",getNumberOfFreePages());
      for(i = 0; i < 20; i++){

        //printf(1,"%d ",i);
        *lst[i]= i + 50;
      }
      if(freePages != getNumberOfFreePages()+100){
        printf(1," FAILED (Free Memory error)\n");
      //ERROR
      }
      //printf(1,"3  free pages: %d\n",getNumberOfFreePages());
      exit();
    }

    wait();
    int j;
    //printf(1,"4  free pages: %d\n",getNumberOfFreePages());
    for(j = 0; j < 20; j++){
        //printf(1,"%d ",j);
        if(*lst[j]!=j){
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
  
          printf(1," FAILED");
          return -1;
        }
      }

      if(freePages != getNumberOfFreePages()+16){
        printf(1," FAILED (Free Memory error)\n");
      //ERROR
      }
    //printf(1,"5  free pages: %d\n",getNumberOfFreePages());
    //printf(1,"parent exit now\n");

    exit();
  }else{
    wait();
    //printf(1,"6  free pages: %d\n",getNumberOfFreePages());

    return 0;
  }
}

int 
cowSwapFile_killedChiledTest(){
  int testerPid = fork();
  if(testerPid==0){
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
  int testerPid = fork();
  if(testerPid==0){
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
    exit();
  }else{
    wait();
    return 0;
  }
}

int
memLeakTest(int freeMem){
  printf(1,"memLeakTest :");

  if(freeMem != getNumberOfFreePages()){
      printf(1, "FAILED\n");
  }
  return 0;
}

int
test(){
  int testerPid = fork();
  if(testerPid==0){
    printf(1,"cowSwapFileTest :");
    int* lst[15];
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
      //printf(1,"child exit now\n");

      exit();
    }
    wait();
    int j;
    for(j = 0; j < 15; j++){
        //printf(1,"%d ",j);

        if(*lst[j]!=j){
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
  
          printf(1," FAILED");
          return -1;
        }
      }

    printf(1,"parent exit now\n");

    exit();
  }else{
    wait();
    return 0;
  }
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


  int freeMem = getNumberOfFreePages();
  printResult(cowPhysicalTest());
  printResult(cowSwapFile_pageSeperationTest());
  printResult(cowSwapFile_killedChiledTest());
  printResult(cowSwapFile_maxPhyInChildTest());
  
  printResult(PhysicalMemTest ());
  printResult(SwapFileTest());
  printResult(memLeakTest(freeMem));

  exit();
}


