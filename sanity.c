#include "types.h"
#include "stat.h"
#include "user.h"
#define PGSIZE          4096

int
SwapFileTest(){
  printf(1,"SwapFile :");
  int* lst[25];
  int volatile i;
  for(i = 0; i < 25; i++){
    lst[i] = (int*)sbrk(PGSIZE);
    //printf(1,"making space %d\n",((uint)(lst[i])));
    *lst[i]=i;
  }
  for(i = 0; i < 25; i++){
    if(*lst[i]!=i){
      return -1;
    }
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
  printResult(SwapFileTest());
  exit();
}


