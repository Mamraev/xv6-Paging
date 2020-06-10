
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
} 



int
main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  
//makeTest(cowSwapFile_maxPhyInChildTest);
//makeTest(cowPhysicalTest);
//makeTest(SwapFileTest);
  int freeMem = getNumberOfFreePages();
   f:	e8 fe 0a 00 00       	call   b12 <getNumberOfFreePages>
  
  //  Cow Tests:
  makeTest(cowPhysicalTest);
  14:	83 ec 0c             	sub    $0xc,%esp
  int freeMem = getNumberOfFreePages();
  17:	89 c3                	mov    %eax,%ebx
  makeTest(cowPhysicalTest);
  19:	68 00 01 00 00       	push   $0x100
  1e:	e8 bd 07 00 00       	call   7e0 <makeTest>
  makeTest(cowSwapFile_pageSeperationTest);
  23:	c7 04 24 c0 02 00 00 	movl   $0x2c0,(%esp)
  2a:	e8 b1 07 00 00       	call   7e0 <makeTest>
  makeTest(cowSwapFile_killedChiledTest);
  2f:	c7 04 24 50 05 00 00 	movl   $0x550,(%esp)
  36:	e8 a5 07 00 00       	call   7e0 <makeTest>
  makeTest(cowSwapFile_maxPhyInChildTest);
  3b:	c7 04 24 e0 03 00 00 	movl   $0x3e0,(%esp)
  42:	e8 99 07 00 00       	call   7e0 <makeTest>
  
  // General Page Tests:
  makeTest(PhysicalMemTest);
  47:	c7 04 24 c0 06 00 00 	movl   $0x6c0,(%esp)
  4e:	e8 8d 07 00 00       	call   7e0 <makeTest>
  makeTest(SwapFileTest);
  53:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  5a:	e8 81 07 00 00       	call   7e0 <makeTest>
  memLeakTest(freeMem);
  5f:	89 1c 24             	mov    %ebx,(%esp)
  62:	e8 19 07 00 00       	call   780 <memLeakTest>
  exit();
  67:	e8 06 0a 00 00       	call   a72 <exit>
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <SwapFileTest>:
SwapFileTest(){
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  for(i = 0; i < 20; i++){
  74:	31 db                	xor    %ebx,%ebx
SwapFileTest(){
  76:	83 ec 5c             	sub    $0x5c,%esp
  printf(1,"SwapFileTest :");
  79:	68 28 0f 00 00       	push   $0xf28
  7e:	6a 01                	push   $0x1
  80:	e8 4b 0b 00 00       	call   bd0 <printf>
  85:	83 c4 10             	add    $0x10,%esp
  88:	90                   	nop
  89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lst[i] = (int*)sbrk(PGSIZE);
  90:	83 ec 0c             	sub    $0xc,%esp
  93:	68 00 10 00 00       	push   $0x1000
  98:	e8 5d 0a 00 00       	call   afa <sbrk>
  9d:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
  a1:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
  a3:	83 c3 01             	add    $0x1,%ebx
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	83 fb 14             	cmp    $0x14,%ebx
  ac:	75 e2                	jne    90 <SwapFileTest+0x20>
  sleep(50);
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	6a 32                	push   $0x32
  b3:	e8 4a 0a 00 00       	call   b02 <sleep>
  b8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++){
  bb:	31 c0                	xor    %eax,%eax
  bd:	eb 09                	jmp    c8 <SwapFileTest+0x58>
  bf:	90                   	nop
  c0:	83 c0 01             	add    $0x1,%eax
  c3:	83 f8 14             	cmp    $0x14,%eax
  c6:	74 28                	je     f0 <SwapFileTest+0x80>
    if(*lst[i]!=i){
  c8:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
  cc:	8b 12                	mov    (%edx),%edx
  ce:	39 c2                	cmp    %eax,%edx
  d0:	74 ee                	je     c0 <SwapFileTest+0x50>
      printf(1," FAILED %d %d",*lst[i],i);
  d2:	50                   	push   %eax
  d3:	52                   	push   %edx
  d4:	68 37 0f 00 00       	push   $0xf37
  d9:	6a 01                	push   $0x1
  db:	e8 f0 0a 00 00       	call   bd0 <printf>
      return -1;
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
  e8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  eb:	c9                   	leave  
  ec:	c3                   	ret    
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  return 0;
  f0:	31 c0                	xor    %eax,%eax
}
  f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  f5:	c9                   	leave  
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <cowPhysicalTest>:
cowPhysicalTest(){
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	56                   	push   %esi
 105:	53                   	push   %ebx
 106:	83 ec 24             	sub    $0x24,%esp
  printf(1,"cowPhysicalTest :");
 109:	68 45 0f 00 00       	push   $0xf45
 10e:	6a 01                	push   $0x1
 110:	e8 bb 0a 00 00       	call   bd0 <printf>
  for(i = 0; i < 3; i++){
 115:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 11c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 11f:	83 c4 10             	add    $0x10,%esp
 122:	83 f8 02             	cmp    $0x2,%eax
 125:	7f 3d                	jg     164 <cowPhysicalTest+0x64>
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lst[i] = (int*)sbrk(PGSIZE);
 130:	83 ec 0c             	sub    $0xc,%esp
 133:	8b 5d d8             	mov    -0x28(%ebp),%ebx
 136:	68 00 10 00 00       	push   $0x1000
 13b:	e8 ba 09 00 00       	call   afa <sbrk>
 140:	89 44 9d dc          	mov    %eax,-0x24(%ebp,%ebx,4)
    *lst[i]=i;
 144:	8b 45 d8             	mov    -0x28(%ebp),%eax
  for(i = 0; i < 3; i++){
 147:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 14a:	8b 55 d8             	mov    -0x28(%ebp),%edx
 14d:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
 151:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 3; i++){
 153:	8b 45 d8             	mov    -0x28(%ebp),%eax
 156:	83 c0 01             	add    $0x1,%eax
 159:	89 45 d8             	mov    %eax,-0x28(%ebp)
 15c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 15f:	83 f8 02             	cmp    $0x2,%eax
 162:	7e cc                	jle    130 <cowPhysicalTest+0x30>
  int freePages_beforeChild = getNumberOfFreePages();
 164:	e8 a9 09 00 00       	call   b12 <getNumberOfFreePages>
 169:	89 c7                	mov    %eax,%edi
  int pid = fork();
 16b:	e8 fa 08 00 00       	call   a6a <fork>
 170:	89 c6                	mov    %eax,%esi
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 172:	e8 9b 09 00 00       	call   b12 <getNumberOfFreePages>
  sleep(10);
 177:	83 ec 0c             	sub    $0xc,%esp
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 17a:	89 c3                	mov    %eax,%ebx
  sleep(10);
 17c:	6a 0a                	push   $0xa
 17e:	e8 7f 09 00 00       	call   b02 <sleep>
  if(pid==0){
 183:	83 c4 10             	add    $0x10,%esp
 186:	85 f6                	test   %esi,%esi
 188:	0f 85 b2 00 00 00    	jne    240 <cowPhysicalTest+0x140>
    for(i = 0; i < 3; i++){
 18e:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 195:	8b 45 d8             	mov    -0x28(%ebp),%eax
 198:	83 f8 02             	cmp    $0x2,%eax
 19b:	7f 26                	jg     1c3 <cowPhysicalTest+0xc3>
 19d:	8d 76 00             	lea    0x0(%esi),%esi
      if(*lst[i]!=i){
 1a0:	8b 55 d8             	mov    -0x28(%ebp),%edx
 1a3:	8b 45 d8             	mov    -0x28(%ebp),%eax
 1a6:	8b 54 95 dc          	mov    -0x24(%ebp,%edx,4),%edx
 1aa:	39 02                	cmp    %eax,(%edx)
 1ac:	0f 85 eb 00 00 00    	jne    29d <cowPhysicalTest+0x19d>
    for(i = 0; i < 3; i++){
 1b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
 1b5:	83 c0 01             	add    $0x1,%eax
 1b8:	89 45 d8             	mov    %eax,-0x28(%ebp)
 1bb:	8b 45 d8             	mov    -0x28(%ebp),%eax
 1be:	83 f8 02             	cmp    $0x2,%eax
 1c1:	7e dd                	jle    1a0 <cowPhysicalTest+0xa0>
    sleep(50);
 1c3:	83 ec 0c             	sub    $0xc,%esp
 1c6:	6a 32                	push   $0x32
 1c8:	e8 35 09 00 00       	call   b02 <sleep>
    int freePages_beforeCloning = getNumberOfFreePages();
 1cd:	e8 40 09 00 00       	call   b12 <getNumberOfFreePages>
    if(freePages_beforeReadingFromParent != freePages_beforeCloning){
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	39 c3                	cmp    %eax,%ebx
 1d7:	0f 85 d4 00 00 00    	jne    2b1 <cowPhysicalTest+0x1b1>
    *lst[1] = 66;
 1dd:	8b 45 e0             	mov    -0x20(%ebp),%eax
    sleep(50);
 1e0:	83 ec 0c             	sub    $0xc,%esp
    *lst[1] = 66;
 1e3:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
    sleep(50);
 1e9:	6a 32                	push   $0x32
 1eb:	e8 12 09 00 00       	call   b02 <sleep>
    if(freePages_beforeCloning != getNumberOfFreePages()+1){
 1f0:	e8 1d 09 00 00       	call   b12 <getNumberOfFreePages>
 1f5:	83 c0 01             	add    $0x1,%eax
 1f8:	83 c4 10             	add    $0x10,%esp
 1fb:	39 d8                	cmp    %ebx,%eax
 1fd:	74 29                	je     228 <cowPhysicalTest+0x128>
      printf(1,"Err : num of free pages after cloning");
 1ff:	83 ec 08             	sub    $0x8,%esp
 202:	68 20 10 00 00       	push   $0x1020
 207:	6a 01                	push   $0x1
 209:	e8 c2 09 00 00       	call   bd0 <printf>
      printf(1," FAILED");
 20e:	5e                   	pop    %esi
 20f:	5f                   	pop    %edi
 210:	68 57 0f 00 00       	push   $0xf57
 215:	6a 01                	push   $0x1
 217:	e8 b4 09 00 00       	call   bd0 <printf>
      exit();
 21c:	e8 51 08 00 00       	call   a72 <exit>
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(10);
 228:	83 ec 0c             	sub    $0xc,%esp
 22b:	6a 0a                	push   $0xa
 22d:	e8 d0 08 00 00       	call   b02 <sleep>
    exit();
 232:	e8 3b 08 00 00       	call   a72 <exit>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 240:	e8 35 08 00 00       	call   a7a <wait>
  if(freePages_beforeChild != getNumberOfFreePages()){
 245:	e8 c8 08 00 00       	call   b12 <getNumberOfFreePages>
 24a:	39 f8                	cmp    %edi,%eax
 24c:	75 0a                	jne    258 <cowPhysicalTest+0x158>
  return 0;
 24e:	31 c0                	xor    %eax,%eax
}
 250:	8d 65 f4             	lea    -0xc(%ebp),%esp
 253:	5b                   	pop    %ebx
 254:	5e                   	pop    %esi
 255:	5f                   	pop    %edi
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    
    printf(1,"before: %d    after: %d",freePages_beforeChild,getNumberOfFreePages());
 258:	e8 b5 08 00 00       	call   b12 <getNumberOfFreePages>
 25d:	50                   	push   %eax
 25e:	57                   	push   %edi
 25f:	68 5f 0f 00 00       	push   $0xf5f
 264:	6a 01                	push   $0x1
 266:	e8 65 09 00 00       	call   bd0 <printf>
    printf(1,"Err : num of free pages after child exit");
 26b:	58                   	pop    %eax
 26c:	5a                   	pop    %edx
 26d:	68 48 10 00 00       	push   $0x1048
 272:	6a 01                	push   $0x1
 274:	e8 57 09 00 00       	call   bd0 <printf>
    printf(1," FAILED");
 279:	59                   	pop    %ecx
 27a:	5b                   	pop    %ebx
 27b:	68 57 0f 00 00       	push   $0xf57
 280:	6a 01                	push   $0x1
 282:	e8 49 09 00 00       	call   bd0 <printf>
    sleep(50000);
 287:	c7 04 24 50 c3 00 00 	movl   $0xc350,(%esp)
 28e:	e8 6f 08 00 00       	call   b02 <sleep>
    return -1;
 293:	83 c4 10             	add    $0x10,%esp
 296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29b:	eb b3                	jmp    250 <cowPhysicalTest+0x150>
        printf(1," FAILED");
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	68 57 0f 00 00       	push   $0xf57
 2a5:	6a 01                	push   $0x1
 2a7:	e8 24 09 00 00       	call   bd0 <printf>
        exit();
 2ac:	e8 c1 07 00 00       	call   a72 <exit>
      printf(1,"Err : num of free pages after reading only has changed");
 2b1:	50                   	push   %eax
 2b2:	50                   	push   %eax
 2b3:	68 e8 0f 00 00       	push   $0xfe8
 2b8:	e9 4a ff ff ff       	jmp    207 <cowPhysicalTest+0x107>
 2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <cowSwapFile_pageSeperationTest>:
cowSwapFile_pageSeperationTest(){
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_pageSeperationTest :");
 2c7:	68 74 10 00 00       	push   $0x1074
 2cc:	6a 01                	push   $0x1
 2ce:	e8 fd 08 00 00       	call   bd0 <printf>
  for(i = 0; i < 20; i++){
 2d3:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 2da:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	83 f8 13             	cmp    $0x13,%eax
 2e3:	7f 37                	jg     31c <cowSwapFile_pageSeperationTest+0x5c>
 2e5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 2e8:	83 ec 0c             	sub    $0xc,%esp
 2eb:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 2ee:	68 00 10 00 00       	push   $0x1000
 2f3:	e8 02 08 00 00       	call   afa <sbrk>
 2f8:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 2fc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 2ff:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 302:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 305:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 309:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 30b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 30e:	83 c0 01             	add    $0x1,%eax
 311:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 314:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 317:	83 f8 13             	cmp    $0x13,%eax
 31a:	7e cc                	jle    2e8 <cowSwapFile_pageSeperationTest+0x28>
  int pid = fork();
 31c:	e8 49 07 00 00       	call   a6a <fork>
  if(pid==0){
 321:	85 c0                	test   %eax,%eax
 323:	74 57                	je     37c <cowSwapFile_pageSeperationTest+0xbc>
  for(j = 0; j < 20; j++){
 325:	31 c0                	xor    %eax,%eax
 327:	eb 0f                	jmp    338 <cowSwapFile_pageSeperationTest+0x78>
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 330:	83 c0 01             	add    $0x1,%eax
 333:	83 f8 14             	cmp    $0x14,%eax
 336:	74 38                	je     370 <cowSwapFile_pageSeperationTest+0xb0>
      if(*lst[j]!=j){
 338:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 33c:	8b 12                	mov    (%edx),%edx
 33e:	39 c2                	cmp    %eax,%edx
 340:	74 ee                	je     330 <cowSwapFile_pageSeperationTest+0x70>
        printf(1,"\nparent fail %d %d\n",*lst[j], j);
 342:	50                   	push   %eax
 343:	52                   	push   %edx
 344:	68 8a 0f 00 00       	push   $0xf8a
 349:	6a 01                	push   $0x1
 34b:	e8 80 08 00 00       	call   bd0 <printf>
        printf(1," FAILED");
 350:	58                   	pop    %eax
 351:	5a                   	pop    %edx
 352:	68 57 0f 00 00       	push   $0xf57
 357:	6a 01                	push   $0x1
 359:	e8 72 08 00 00       	call   bd0 <printf>
        return -1;
 35e:	83 c4 10             	add    $0x10,%esp
 361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 366:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 369:	c9                   	leave  
 36a:	c3                   	ret    
 36b:	90                   	nop
 36c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
 370:	e8 05 07 00 00       	call   a7a <wait>
  return 0;
 375:	31 c0                	xor    %eax,%eax
}
 377:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 37a:	c9                   	leave  
 37b:	c3                   	ret    
    for(i = 0; i < 20; i++){
 37c:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 383:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 386:	83 f8 13             	cmp    $0x13,%eax
 389:	7f 49                	jg     3d4 <cowSwapFile_pageSeperationTest+0x114>
      if(*lst[i]!=i){
 38b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 38e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 391:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 395:	39 02                	cmp    %eax,(%edx)
 397:	74 2a                	je     3c3 <cowSwapFile_pageSeperationTest+0x103>
        printf(1,"\nchild fail %d %d\n",*lst[i], i);
 399:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 39c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 39f:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 3a3:	52                   	push   %edx
 3a4:	ff 30                	pushl  (%eax)
 3a6:	68 77 0f 00 00       	push   $0xf77
 3ab:	6a 01                	push   $0x1
 3ad:	e8 1e 08 00 00       	call   bd0 <printf>
        printf(1," FAILED");
 3b2:	59                   	pop    %ecx
 3b3:	5b                   	pop    %ebx
 3b4:	68 57 0f 00 00       	push   $0xf57
 3b9:	6a 01                	push   $0x1
 3bb:	e8 10 08 00 00       	call   bd0 <printf>
 3c0:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 20; i++){
 3c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3c6:	83 c0 01             	add    $0x1,%eax
 3c9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 3cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3cf:	83 f8 13             	cmp    $0x13,%eax
 3d2:	7e b7                	jle    38b <cowSwapFile_pageSeperationTest+0xcb>
    exit();
 3d4:	e8 99 06 00 00       	call   a72 <exit>
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
  for(i = 0; i < 20; i++){
 3e5:	31 db                	xor    %ebx,%ebx
cowSwapFile_maxPhyInChildTest(){
 3e7:	83 ec 60             	sub    $0x60,%esp
  int freePages = getNumberOfFreePages();
 3ea:	e8 23 07 00 00       	call   b12 <getNumberOfFreePages>
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 3ef:	83 ec 08             	sub    $0x8,%esp
  int freePages = getNumberOfFreePages();
 3f2:	89 c6                	mov    %eax,%esi
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 3f4:	68 98 10 00 00       	push   $0x1098
 3f9:	6a 01                	push   $0x1
 3fb:	e8 d0 07 00 00       	call   bd0 <printf>
 400:	83 c4 10             	add    $0x10,%esp
 403:	90                   	nop
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 408:	83 ec 0c             	sub    $0xc,%esp
 40b:	68 00 10 00 00       	push   $0x1000
 410:	e8 e5 06 00 00       	call   afa <sbrk>
 415:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 419:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
 41b:	83 c3 01             	add    $0x1,%ebx
 41e:	83 c4 10             	add    $0x10,%esp
 421:	83 fb 14             	cmp    $0x14,%ebx
 424:	75 e2                	jne    408 <cowSwapFile_maxPhyInChildTest+0x28>
  int freePagesAfterSBRK = getNumberOfFreePages();
 426:	e8 e7 06 00 00       	call   b12 <getNumberOfFreePages>
 42b:	89 c3                	mov    %eax,%ebx
  if(freePages > getNumberOfFreePages()+16){
 42d:	e8 e0 06 00 00       	call   b12 <getNumberOfFreePages>
 432:	83 c0 10             	add    $0x10,%eax
 435:	39 f0                	cmp    %esi,%eax
 437:	0f 8c fb 00 00 00    	jl     538 <cowSwapFile_maxPhyInChildTest+0x158>
  int pid = fork();
 43d:	e8 28 06 00 00       	call   a6a <fork>
  if(pid==0){
 442:	85 c0                	test   %eax,%eax
 444:	75 4a                	jne    490 <cowSwapFile_maxPhyInChildTest+0xb0>
    int freePagesAfterFork = getNumberOfFreePages();
 446:	e8 c7 06 00 00       	call   b12 <getNumberOfFreePages>
    if(freePagesAfterFork  + 68 != freePagesAfterSBRK){
 44b:	8d 50 44             	lea    0x44(%eax),%edx
    int freePagesAfterFork = getNumberOfFreePages();
 44e:	89 c6                	mov    %eax,%esi
 450:	b8 32 00 00 00       	mov    $0x32,%eax
    if(freePagesAfterFork  + 68 != freePagesAfterSBRK){
 455:	39 da                	cmp    %ebx,%edx
 457:	0f 85 83 00 00 00    	jne    4e0 <cowSwapFile_maxPhyInChildTest+0x100>
 45d:	8d 76 00             	lea    0x0(%esi),%esi
      *lst[i]= i + 50;
 460:	8b 94 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%edx
 467:	89 02                	mov    %eax,(%edx)
 469:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < 20; i++){
 46c:	83 f8 46             	cmp    $0x46,%eax
 46f:	75 ef                	jne    460 <cowSwapFile_maxPhyInChildTest+0x80>
    if(freePagesAfterFork > getNumberOfFreePages()+16){
 471:	e8 9c 06 00 00       	call   b12 <getNumberOfFreePages>
 476:	83 c0 10             	add    $0x10,%eax
 479:	39 f0                	cmp    %esi,%eax
 47b:	0f 8c 9a 00 00 00    	jl     51b <cowSwapFile_maxPhyInChildTest+0x13b>
    exit();
 481:	e8 ec 05 00 00       	call   a72 <exit>
 486:	8d 76 00             	lea    0x0(%esi),%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 490:	e8 e5 05 00 00       	call   a7a <wait>
  for(i = 0; i < 20; i++){
 495:	31 c0                	xor    %eax,%eax
 497:	eb 0f                	jmp    4a8 <cowSwapFile_maxPhyInChildTest+0xc8>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	83 c0 01             	add    $0x1,%eax
 4a3:	83 f8 14             	cmp    $0x14,%eax
 4a6:	74 4b                	je     4f3 <cowSwapFile_maxPhyInChildTest+0x113>
      if(*lst[i]!=i){
 4a8:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 4ac:	39 02                	cmp    %eax,(%edx)
 4ae:	74 f0                	je     4a0 <cowSwapFile_maxPhyInChildTest+0xc0>
        printf(1,"\nparent fail %d %d\n",*lst[i]!=i);
 4b0:	83 ec 04             	sub    $0x4,%esp
 4b3:	6a 01                	push   $0x1
 4b5:	68 8a 0f 00 00       	push   $0xf8a
 4ba:	6a 01                	push   $0x1
 4bc:	e8 0f 07 00 00       	call   bd0 <printf>
        printf(1," FAILED");
 4c1:	58                   	pop    %eax
 4c2:	5a                   	pop    %edx
 4c3:	68 57 0f 00 00       	push   $0xf57
 4c8:	6a 01                	push   $0x1
 4ca:	e8 01 07 00 00       	call   bd0 <printf>
        return -1;
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 4d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4da:	5b                   	pop    %ebx
 4db:	5e                   	pop    %esi
 4dc:	5d                   	pop    %ebp
 4dd:	c3                   	ret    
 4de:	66 90                	xchg   %ax,%ax
    printf(1," FAILED 2(Free Memory error) %d %d\n",freePagesAfterFork,freePagesAfterSBRK);
 4e0:	53                   	push   %ebx
 4e1:	56                   	push   %esi
 4e2:	68 dc 10 00 00       	push   $0x10dc
 4e7:	6a 01                	push   $0x1
 4e9:	e8 e2 06 00 00       	call   bd0 <printf>
    exit();
 4ee:	e8 7f 05 00 00       	call   a72 <exit>
    if(freePages >getNumberOfFreePages()+16){
 4f3:	e8 1a 06 00 00       	call   b12 <getNumberOfFreePages>
 4f8:	8d 50 10             	lea    0x10(%eax),%edx
  return 0;
 4fb:	31 c0                	xor    %eax,%eax
    if(freePages >getNumberOfFreePages()+16){
 4fd:	39 f2                	cmp    %esi,%edx
 4ff:	7d d6                	jge    4d7 <cowSwapFile_maxPhyInChildTest+0xf7>
      printf(1," FAILED 4(Free Memory error)\n");
 501:	83 ec 08             	sub    $0x8,%esp
 504:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 507:	68 9e 0f 00 00       	push   $0xf9e
 50c:	6a 01                	push   $0x1
 50e:	e8 bd 06 00 00       	call   bd0 <printf>
 513:	83 c4 10             	add    $0x10,%esp
 516:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 519:	eb bc                	jmp    4d7 <cowSwapFile_maxPhyInChildTest+0xf7>
      printf(1," FAILED 3(Free Memory error)%d\n",getNumberOfFreePages());
 51b:	e8 f2 05 00 00       	call   b12 <getNumberOfFreePages>
 520:	83 ec 04             	sub    $0x4,%esp
 523:	50                   	push   %eax
 524:	68 00 11 00 00       	push   $0x1100
 529:	6a 01                	push   $0x1
 52b:	e8 a0 06 00 00       	call   bd0 <printf>
 530:	83 c4 10             	add    $0x10,%esp
 533:	e9 49 ff ff ff       	jmp    481 <cowSwapFile_maxPhyInChildTest+0xa1>
    printf(1," FAILED 1(Free Memory error) %d\n",getNumberOfFreePages());
 538:	e8 d5 05 00 00       	call   b12 <getNumberOfFreePages>
 53d:	51                   	push   %ecx
 53e:	50                   	push   %eax
 53f:	68 b8 10 00 00       	push   $0x10b8
 544:	6a 01                	push   $0x1
 546:	e8 85 06 00 00       	call   bd0 <printf>
    exit();
 54b:	e8 22 05 00 00       	call   a72 <exit>

00000550 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	53                   	push   %ebx
 554:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_killedChiledTest :");
 557:	68 20 11 00 00       	push   $0x1120
 55c:	6a 01                	push   $0x1
 55e:	e8 6d 06 00 00       	call   bd0 <printf>
  for(i = 0; i < 20; i++){
 563:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 56a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 56d:	83 c4 10             	add    $0x10,%esp
 570:	83 f8 13             	cmp    $0x13,%eax
 573:	7f 37                	jg     5ac <cowSwapFile_killedChiledTest+0x5c>
 575:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 578:	83 ec 0c             	sub    $0xc,%esp
 57b:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 57e:	68 00 10 00 00       	push   $0x1000
 583:	e8 72 05 00 00       	call   afa <sbrk>
 588:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 58c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 58f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 592:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 595:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 599:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 59b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 59e:	83 c0 01             	add    $0x1,%eax
 5a1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 5a4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5a7:	83 f8 13             	cmp    $0x13,%eax
 5aa:	7e cc                	jle    578 <cowSwapFile_killedChiledTest+0x28>
  int pid = fork();
 5ac:	e8 b9 04 00 00       	call   a6a <fork>
  if(pid==0){
 5b1:	85 c0                	test   %eax,%eax
 5b3:	0f 85 c7 00 00 00    	jne    680 <cowSwapFile_killedChiledTest+0x130>
    for(i = 0; i < 20; i++){
 5b9:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 5c0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5c3:	83 f8 13             	cmp    $0x13,%eax
 5c6:	7e 19                	jle    5e1 <cowSwapFile_killedChiledTest+0x91>
 5c8:	eb 66                	jmp    630 <cowSwapFile_killedChiledTest+0xe0>
 5ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5d3:	83 c0 01             	add    $0x1,%eax
 5d6:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 5d9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5dc:	83 f8 13             	cmp    $0x13,%eax
 5df:	7f 4f                	jg     630 <cowSwapFile_killedChiledTest+0xe0>
      if(*lst[i]!=i){
 5e1:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 5e4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5e7:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 5eb:	39 02                	cmp    %eax,(%edx)
 5ed:	74 e1                	je     5d0 <cowSwapFile_killedChiledTest+0x80>
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
 5ef:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 5f2:	83 ec 04             	sub    $0x4,%esp
 5f5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5f8:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 5fc:	39 02                	cmp    %eax,(%edx)
 5fe:	0f 95 c0             	setne  %al
 601:	0f b6 c0             	movzbl %al,%eax
 604:	50                   	push   %eax
 605:	68 77 0f 00 00       	push   $0xf77
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 60a:	6a 01                	push   $0x1
 60c:	e8 bf 05 00 00       	call   bd0 <printf>
        printf(1," FAILED");
 611:	58                   	pop    %eax
 612:	5a                   	pop    %edx
 613:	68 57 0f 00 00       	push   $0xf57
 618:	6a 01                	push   $0x1
 61a:	e8 b1 05 00 00       	call   bd0 <printf>
        return -1;
 61f:	83 c4 10             	add    $0x10,%esp
 622:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 627:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 62a:	c9                   	leave  
 62b:	c3                   	ret    
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 20; i++){
 630:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 637:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 63a:	83 f8 13             	cmp    $0x13,%eax
 63d:	7e 1a                	jle    659 <cowSwapFile_killedChiledTest+0x109>
 63f:	eb 76                	jmp    6b7 <cowSwapFile_killedChiledTest+0x167>
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 64b:	83 c0 01             	add    $0x1,%eax
 64e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 651:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 654:	83 f8 13             	cmp    $0x13,%eax
 657:	7f 5e                	jg     6b7 <cowSwapFile_killedChiledTest+0x167>
      *lst[i] = 66;
 659:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 65c:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 660:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(*lst[i]!=66){
 666:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 669:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 66d:	83 38 42             	cmpl   $0x42,(%eax)
 670:	74 d6                	je     648 <cowSwapFile_killedChiledTest+0xf8>
 672:	e9 78 ff ff ff       	jmp    5ef <cowSwapFile_killedChiledTest+0x9f>
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 680:	e8 f5 03 00 00       	call   a7a <wait>
  for(j = 0; j < 20; j++){
 685:	31 c0                	xor    %eax,%eax
 687:	eb 0f                	jmp    698 <cowSwapFile_killedChiledTest+0x148>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 690:	83 c0 01             	add    $0x1,%eax
 693:	83 f8 14             	cmp    $0x14,%eax
 696:	74 18                	je     6b0 <cowSwapFile_killedChiledTest+0x160>
      if(*lst[j]!=j){
 698:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 69c:	39 02                	cmp    %eax,(%edx)
 69e:	74 f0                	je     690 <cowSwapFile_killedChiledTest+0x140>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 6a0:	83 ec 04             	sub    $0x4,%esp
 6a3:	6a 01                	push   $0x1
 6a5:	68 8a 0f 00 00       	push   $0xf8a
 6aa:	e9 5b ff ff ff       	jmp    60a <cowSwapFile_killedChiledTest+0xba>
 6af:	90                   	nop
  return 0;
 6b0:	31 c0                	xor    %eax,%eax
}
 6b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6b5:	c9                   	leave  
 6b6:	c3                   	ret    
    exit();
 6b7:	e8 b6 03 00 00       	call   a72 <exit>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006c0 <PhysicalMemTest>:
PhysicalMemTest(){
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	53                   	push   %ebx
 6c4:	83 ec 2c             	sub    $0x2c,%esp
  printf(1,"PhysicalMemTest :");
 6c7:	68 bc 0f 00 00       	push   $0xfbc
 6cc:	6a 01                	push   $0x1
 6ce:	e8 fd 04 00 00       	call   bd0 <printf>
  for(i = 0; i < 5; i++){
 6d3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 6da:	8b 45 e0             	mov    -0x20(%ebp),%eax
 6dd:	83 c4 10             	add    $0x10,%esp
 6e0:	83 f8 04             	cmp    $0x4,%eax
 6e3:	7f 37                	jg     71c <PhysicalMemTest+0x5c>
 6e5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 6e8:	83 ec 0c             	sub    $0xc,%esp
 6eb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 6ee:	68 00 10 00 00       	push   $0x1000
 6f3:	e8 02 04 00 00       	call   afa <sbrk>
 6f8:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
    *lst[i]=i;
 6fc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  for(i = 0; i < 5; i++){
 6ff:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 702:	8b 55 e0             	mov    -0x20(%ebp),%edx
 705:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
 709:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 5; i++){
 70b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 70e:	83 c0 01             	add    $0x1,%eax
 711:	89 45 e0             	mov    %eax,-0x20(%ebp)
 714:	8b 45 e0             	mov    -0x20(%ebp),%eax
 717:	83 f8 04             	cmp    $0x4,%eax
 71a:	7e cc                	jle    6e8 <PhysicalMemTest+0x28>
  for(i = 0; i < 5; i++){
 71c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 723:	8b 45 e0             	mov    -0x20(%ebp),%eax
 726:	83 f8 04             	cmp    $0x4,%eax
 729:	7e 16                	jle    741 <PhysicalMemTest+0x81>
 72b:	eb 43                	jmp    770 <PhysicalMemTest+0xb0>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
 730:	8b 45 e0             	mov    -0x20(%ebp),%eax
 733:	83 c0 01             	add    $0x1,%eax
 736:	89 45 e0             	mov    %eax,-0x20(%ebp)
 739:	8b 45 e0             	mov    -0x20(%ebp),%eax
 73c:	83 f8 04             	cmp    $0x4,%eax
 73f:	7f 2f                	jg     770 <PhysicalMemTest+0xb0>
    if(*lst[i]!=i){
 741:	8b 55 e0             	mov    -0x20(%ebp),%edx
 744:	8b 45 e0             	mov    -0x20(%ebp),%eax
 747:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
 74b:	39 02                	cmp    %eax,(%edx)
 74d:	74 e1                	je     730 <PhysicalMemTest+0x70>
      printf(1," FAILED");
 74f:	83 ec 08             	sub    $0x8,%esp
 752:	68 57 0f 00 00       	push   $0xf57
 757:	6a 01                	push   $0x1
 759:	e8 72 04 00 00       	call   bd0 <printf>
 75e:	83 c4 10             	add    $0x10,%esp
 761:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 766:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 769:	c9                   	leave  
 76a:	c3                   	ret    
 76b:	90                   	nop
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 770:	31 c0                	xor    %eax,%eax
}
 772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 775:	c9                   	leave  
 776:	c3                   	ret    
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000780 <memLeakTest>:
memLeakTest(int freeMem){
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	53                   	push   %ebx
 784:	83 ec 0c             	sub    $0xc,%esp
 787:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(1,"memLeakTest :");
 78a:	68 ce 0f 00 00       	push   $0xfce
 78f:	6a 01                	push   $0x1
 791:	e8 3a 04 00 00       	call   bd0 <printf>
  if(freeMem != getNumberOfFreePages()){
 796:	e8 77 03 00 00       	call   b12 <getNumberOfFreePages>
 79b:	83 c4 10             	add    $0x10,%esp
 79e:	39 d8                	cmp    %ebx,%eax
 7a0:	74 1e                	je     7c0 <memLeakTest+0x40>
      printf(1, "FAILED    expected: %d     got : %d\n",freeMem,getNumberOfFreePages());
 7a2:	e8 6b 03 00 00       	call   b12 <getNumberOfFreePages>
 7a7:	50                   	push   %eax
 7a8:	53                   	push   %ebx
 7a9:	68 40 11 00 00       	push   $0x1140
 7ae:	6a 01                	push   $0x1
 7b0:	e8 1b 04 00 00       	call   bd0 <printf>
 7b5:	83 c4 10             	add    $0x10,%esp
}
 7b8:	31 c0                	xor    %eax,%eax
 7ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7bd:	c9                   	leave  
 7be:	c3                   	ret    
 7bf:	90                   	nop
    printf(1, "PASSED\n");
 7c0:	83 ec 08             	sub    $0x8,%esp
 7c3:	68 dd 0f 00 00       	push   $0xfdd
 7c8:	6a 01                	push   $0x1
 7ca:	e8 01 04 00 00       	call   bd0 <printf>
 7cf:	83 c4 10             	add    $0x10,%esp
}
 7d2:	31 c0                	xor    %eax,%eax
 7d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7d7:	c9                   	leave  
 7d8:	c3                   	ret    
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000007e0 <makeTest>:
makeTest(int (*test)()){
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	53                   	push   %ebx
 7e4:	83 ec 04             	sub    $0x4,%esp
 7e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int testerPid = fork();
 7ea:	e8 7b 02 00 00       	call   a6a <fork>
  if(testerPid==0){
 7ef:	85 c0                	test   %eax,%eax
 7f1:	74 09                	je     7fc <makeTest+0x1c>
} 
 7f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7f6:	c9                   	leave  
  wait();
 7f7:	e9 7e 02 00 00       	jmp    a7a <wait>
    if(test()==0){
 7fc:	ff d3                	call   *%ebx
 7fe:	85 c0                	test   %eax,%eax
 800:	74 05                	je     807 <makeTest+0x27>
    exit();
 802:	e8 6b 02 00 00       	call   a72 <exit>
      printf(1," PASSED\n");
 807:	50                   	push   %eax
 808:	50                   	push   %eax
 809:	68 dc 0f 00 00       	push   $0xfdc
 80e:	6a 01                	push   $0x1
 810:	e8 bb 03 00 00       	call   bd0 <printf>
 815:	83 c4 10             	add    $0x10,%esp
 818:	eb e8                	jmp    802 <makeTest+0x22>
 81a:	66 90                	xchg   %ax,%ax
 81c:	66 90                	xchg   %ax,%ax
 81e:	66 90                	xchg   %ax,%ax

00000820 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	53                   	push   %ebx
 824:	8b 45 08             	mov    0x8(%ebp),%eax
 827:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 82a:	89 c2                	mov    %eax,%edx
 82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 830:	83 c1 01             	add    $0x1,%ecx
 833:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 837:	83 c2 01             	add    $0x1,%edx
 83a:	84 db                	test   %bl,%bl
 83c:	88 5a ff             	mov    %bl,-0x1(%edx)
 83f:	75 ef                	jne    830 <strcpy+0x10>
    ;
  return os;
}
 841:	5b                   	pop    %ebx
 842:	5d                   	pop    %ebp
 843:	c3                   	ret    
 844:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 84a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000850 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	53                   	push   %ebx
 854:	8b 55 08             	mov    0x8(%ebp),%edx
 857:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 85a:	0f b6 02             	movzbl (%edx),%eax
 85d:	0f b6 19             	movzbl (%ecx),%ebx
 860:	84 c0                	test   %al,%al
 862:	75 1c                	jne    880 <strcmp+0x30>
 864:	eb 2a                	jmp    890 <strcmp+0x40>
 866:	8d 76 00             	lea    0x0(%esi),%esi
 869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 870:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 873:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 876:	83 c1 01             	add    $0x1,%ecx
 879:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 87c:	84 c0                	test   %al,%al
 87e:	74 10                	je     890 <strcmp+0x40>
 880:	38 d8                	cmp    %bl,%al
 882:	74 ec                	je     870 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 884:	29 d8                	sub    %ebx,%eax
}
 886:	5b                   	pop    %ebx
 887:	5d                   	pop    %ebp
 888:	c3                   	ret    
 889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 890:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 892:	29 d8                	sub    %ebx,%eax
}
 894:	5b                   	pop    %ebx
 895:	5d                   	pop    %ebp
 896:	c3                   	ret    
 897:	89 f6                	mov    %esi,%esi
 899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <strlen>:

uint
strlen(const char *s)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8a6:	80 39 00             	cmpb   $0x0,(%ecx)
 8a9:	74 15                	je     8c0 <strlen+0x20>
 8ab:	31 d2                	xor    %edx,%edx
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
 8b0:	83 c2 01             	add    $0x1,%edx
 8b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 8b7:	89 d0                	mov    %edx,%eax
 8b9:	75 f5                	jne    8b0 <strlen+0x10>
    ;
  return n;
}
 8bb:	5d                   	pop    %ebp
 8bc:	c3                   	ret    
 8bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 8c0:	31 c0                	xor    %eax,%eax
}
 8c2:	5d                   	pop    %ebp
 8c3:	c3                   	ret    
 8c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	57                   	push   %edi
 8d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 8d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 8da:	8b 45 0c             	mov    0xc(%ebp),%eax
 8dd:	89 d7                	mov    %edx,%edi
 8df:	fc                   	cld    
 8e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 8e2:	89 d0                	mov    %edx,%eax
 8e4:	5f                   	pop    %edi
 8e5:	5d                   	pop    %ebp
 8e6:	c3                   	ret    
 8e7:	89 f6                	mov    %esi,%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <strchr>:

char*
strchr(const char *s, char c)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	8b 45 08             	mov    0x8(%ebp),%eax
 8f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 8fa:	0f b6 10             	movzbl (%eax),%edx
 8fd:	84 d2                	test   %dl,%dl
 8ff:	74 1d                	je     91e <strchr+0x2e>
    if(*s == c)
 901:	38 d3                	cmp    %dl,%bl
 903:	89 d9                	mov    %ebx,%ecx
 905:	75 0d                	jne    914 <strchr+0x24>
 907:	eb 17                	jmp    920 <strchr+0x30>
 909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 910:	38 ca                	cmp    %cl,%dl
 912:	74 0c                	je     920 <strchr+0x30>
  for(; *s; s++)
 914:	83 c0 01             	add    $0x1,%eax
 917:	0f b6 10             	movzbl (%eax),%edx
 91a:	84 d2                	test   %dl,%dl
 91c:	75 f2                	jne    910 <strchr+0x20>
      return (char*)s;
  return 0;
 91e:	31 c0                	xor    %eax,%eax
}
 920:	5b                   	pop    %ebx
 921:	5d                   	pop    %ebp
 922:	c3                   	ret    
 923:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <gets>:

char*
gets(char *buf, int max)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
 934:	56                   	push   %esi
 935:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 936:	31 f6                	xor    %esi,%esi
 938:	89 f3                	mov    %esi,%ebx
{
 93a:	83 ec 1c             	sub    $0x1c,%esp
 93d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 940:	eb 2f                	jmp    971 <gets+0x41>
 942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 948:	8d 45 e7             	lea    -0x19(%ebp),%eax
 94b:	83 ec 04             	sub    $0x4,%esp
 94e:	6a 01                	push   $0x1
 950:	50                   	push   %eax
 951:	6a 00                	push   $0x0
 953:	e8 32 01 00 00       	call   a8a <read>
    if(cc < 1)
 958:	83 c4 10             	add    $0x10,%esp
 95b:	85 c0                	test   %eax,%eax
 95d:	7e 1c                	jle    97b <gets+0x4b>
      break;
    buf[i++] = c;
 95f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 963:	83 c7 01             	add    $0x1,%edi
 966:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 969:	3c 0a                	cmp    $0xa,%al
 96b:	74 23                	je     990 <gets+0x60>
 96d:	3c 0d                	cmp    $0xd,%al
 96f:	74 1f                	je     990 <gets+0x60>
  for(i=0; i+1 < max; ){
 971:	83 c3 01             	add    $0x1,%ebx
 974:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 977:	89 fe                	mov    %edi,%esi
 979:	7c cd                	jl     948 <gets+0x18>
 97b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 97d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 980:	c6 03 00             	movb   $0x0,(%ebx)
}
 983:	8d 65 f4             	lea    -0xc(%ebp),%esp
 986:	5b                   	pop    %ebx
 987:	5e                   	pop    %esi
 988:	5f                   	pop    %edi
 989:	5d                   	pop    %ebp
 98a:	c3                   	ret    
 98b:	90                   	nop
 98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 990:	8b 75 08             	mov    0x8(%ebp),%esi
 993:	8b 45 08             	mov    0x8(%ebp),%eax
 996:	01 de                	add    %ebx,%esi
 998:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 99a:	c6 03 00             	movb   $0x0,(%ebx)
}
 99d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9a0:	5b                   	pop    %ebx
 9a1:	5e                   	pop    %esi
 9a2:	5f                   	pop    %edi
 9a3:	5d                   	pop    %ebp
 9a4:	c3                   	ret    
 9a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	56                   	push   %esi
 9b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 9b5:	83 ec 08             	sub    $0x8,%esp
 9b8:	6a 00                	push   $0x0
 9ba:	ff 75 08             	pushl  0x8(%ebp)
 9bd:	e8 f0 00 00 00       	call   ab2 <open>
  if(fd < 0)
 9c2:	83 c4 10             	add    $0x10,%esp
 9c5:	85 c0                	test   %eax,%eax
 9c7:	78 27                	js     9f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 9c9:	83 ec 08             	sub    $0x8,%esp
 9cc:	ff 75 0c             	pushl  0xc(%ebp)
 9cf:	89 c3                	mov    %eax,%ebx
 9d1:	50                   	push   %eax
 9d2:	e8 f3 00 00 00       	call   aca <fstat>
  close(fd);
 9d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 9da:	89 c6                	mov    %eax,%esi
  close(fd);
 9dc:	e8 b9 00 00 00       	call   a9a <close>
  return r;
 9e1:	83 c4 10             	add    $0x10,%esp
}
 9e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 9e7:	89 f0                	mov    %esi,%eax
 9e9:	5b                   	pop    %ebx
 9ea:	5e                   	pop    %esi
 9eb:	5d                   	pop    %ebp
 9ec:	c3                   	ret    
 9ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 9f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 9f5:	eb ed                	jmp    9e4 <stat+0x34>
 9f7:	89 f6                	mov    %esi,%esi
 9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <atoi>:

int
atoi(const char *s)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	53                   	push   %ebx
 a04:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a07:	0f be 11             	movsbl (%ecx),%edx
 a0a:	8d 42 d0             	lea    -0x30(%edx),%eax
 a0d:	3c 09                	cmp    $0x9,%al
  n = 0;
 a0f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 a14:	77 1f                	ja     a35 <atoi+0x35>
 a16:	8d 76 00             	lea    0x0(%esi),%esi
 a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a20:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a23:	83 c1 01             	add    $0x1,%ecx
 a26:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 a2a:	0f be 11             	movsbl (%ecx),%edx
 a2d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 a30:	80 fb 09             	cmp    $0x9,%bl
 a33:	76 eb                	jbe    a20 <atoi+0x20>
  return n;
}
 a35:	5b                   	pop    %ebx
 a36:	5d                   	pop    %ebp
 a37:	c3                   	ret    
 a38:	90                   	nop
 a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a40 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	56                   	push   %esi
 a44:	53                   	push   %ebx
 a45:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a48:	8b 45 08             	mov    0x8(%ebp),%eax
 a4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a4e:	85 db                	test   %ebx,%ebx
 a50:	7e 14                	jle    a66 <memmove+0x26>
 a52:	31 d2                	xor    %edx,%edx
 a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 a58:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 a5c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 a5f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 a62:	39 d3                	cmp    %edx,%ebx
 a64:	75 f2                	jne    a58 <memmove+0x18>
  return vdst;
}
 a66:	5b                   	pop    %ebx
 a67:	5e                   	pop    %esi
 a68:	5d                   	pop    %ebp
 a69:	c3                   	ret    

00000a6a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 a6a:	b8 01 00 00 00       	mov    $0x1,%eax
 a6f:	cd 40                	int    $0x40
 a71:	c3                   	ret    

00000a72 <exit>:
SYSCALL(exit)
 a72:	b8 02 00 00 00       	mov    $0x2,%eax
 a77:	cd 40                	int    $0x40
 a79:	c3                   	ret    

00000a7a <wait>:
SYSCALL(wait)
 a7a:	b8 03 00 00 00       	mov    $0x3,%eax
 a7f:	cd 40                	int    $0x40
 a81:	c3                   	ret    

00000a82 <pipe>:
SYSCALL(pipe)
 a82:	b8 04 00 00 00       	mov    $0x4,%eax
 a87:	cd 40                	int    $0x40
 a89:	c3                   	ret    

00000a8a <read>:
SYSCALL(read)
 a8a:	b8 05 00 00 00       	mov    $0x5,%eax
 a8f:	cd 40                	int    $0x40
 a91:	c3                   	ret    

00000a92 <write>:
SYSCALL(write)
 a92:	b8 10 00 00 00       	mov    $0x10,%eax
 a97:	cd 40                	int    $0x40
 a99:	c3                   	ret    

00000a9a <close>:
SYSCALL(close)
 a9a:	b8 15 00 00 00       	mov    $0x15,%eax
 a9f:	cd 40                	int    $0x40
 aa1:	c3                   	ret    

00000aa2 <kill>:
SYSCALL(kill)
 aa2:	b8 06 00 00 00       	mov    $0x6,%eax
 aa7:	cd 40                	int    $0x40
 aa9:	c3                   	ret    

00000aaa <exec>:
SYSCALL(exec)
 aaa:	b8 07 00 00 00       	mov    $0x7,%eax
 aaf:	cd 40                	int    $0x40
 ab1:	c3                   	ret    

00000ab2 <open>:
SYSCALL(open)
 ab2:	b8 0f 00 00 00       	mov    $0xf,%eax
 ab7:	cd 40                	int    $0x40
 ab9:	c3                   	ret    

00000aba <mknod>:
SYSCALL(mknod)
 aba:	b8 11 00 00 00       	mov    $0x11,%eax
 abf:	cd 40                	int    $0x40
 ac1:	c3                   	ret    

00000ac2 <unlink>:
SYSCALL(unlink)
 ac2:	b8 12 00 00 00       	mov    $0x12,%eax
 ac7:	cd 40                	int    $0x40
 ac9:	c3                   	ret    

00000aca <fstat>:
SYSCALL(fstat)
 aca:	b8 08 00 00 00       	mov    $0x8,%eax
 acf:	cd 40                	int    $0x40
 ad1:	c3                   	ret    

00000ad2 <link>:
SYSCALL(link)
 ad2:	b8 13 00 00 00       	mov    $0x13,%eax
 ad7:	cd 40                	int    $0x40
 ad9:	c3                   	ret    

00000ada <mkdir>:
SYSCALL(mkdir)
 ada:	b8 14 00 00 00       	mov    $0x14,%eax
 adf:	cd 40                	int    $0x40
 ae1:	c3                   	ret    

00000ae2 <chdir>:
SYSCALL(chdir)
 ae2:	b8 09 00 00 00       	mov    $0x9,%eax
 ae7:	cd 40                	int    $0x40
 ae9:	c3                   	ret    

00000aea <dup>:
SYSCALL(dup)
 aea:	b8 0a 00 00 00       	mov    $0xa,%eax
 aef:	cd 40                	int    $0x40
 af1:	c3                   	ret    

00000af2 <getpid>:
SYSCALL(getpid)
 af2:	b8 0b 00 00 00       	mov    $0xb,%eax
 af7:	cd 40                	int    $0x40
 af9:	c3                   	ret    

00000afa <sbrk>:
SYSCALL(sbrk)
 afa:	b8 0c 00 00 00       	mov    $0xc,%eax
 aff:	cd 40                	int    $0x40
 b01:	c3                   	ret    

00000b02 <sleep>:
SYSCALL(sleep)
 b02:	b8 0d 00 00 00       	mov    $0xd,%eax
 b07:	cd 40                	int    $0x40
 b09:	c3                   	ret    

00000b0a <uptime>:
SYSCALL(uptime)
 b0a:	b8 0e 00 00 00       	mov    $0xe,%eax
 b0f:	cd 40                	int    $0x40
 b11:	c3                   	ret    

00000b12 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
 b12:	b8 16 00 00 00       	mov    $0x16,%eax
 b17:	cd 40                	int    $0x40
 b19:	c3                   	ret    

00000b1a <printProcDump>:
SYSCALL(printProcDump)
 b1a:	b8 17 00 00 00       	mov    $0x17,%eax
 b1f:	cd 40                	int    $0x40
 b21:	c3                   	ret    
 b22:	66 90                	xchg   %ax,%ax
 b24:	66 90                	xchg   %ax,%ax
 b26:	66 90                	xchg   %ax,%ax
 b28:	66 90                	xchg   %ax,%ax
 b2a:	66 90                	xchg   %ax,%ax
 b2c:	66 90                	xchg   %ax,%ax
 b2e:	66 90                	xchg   %ax,%ax

00000b30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b30:	55                   	push   %ebp
 b31:	89 e5                	mov    %esp,%ebp
 b33:	57                   	push   %edi
 b34:	56                   	push   %esi
 b35:	53                   	push   %ebx
 b36:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b39:	85 d2                	test   %edx,%edx
{
 b3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 b3e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b40:	79 76                	jns    bb8 <printint+0x88>
 b42:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b46:	74 70                	je     bb8 <printint+0x88>
    x = -xx;
 b48:	f7 d8                	neg    %eax
    neg = 1;
 b4a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 b51:	31 f6                	xor    %esi,%esi
 b53:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b56:	eb 0a                	jmp    b62 <printint+0x32>
 b58:	90                   	nop
 b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 b60:	89 fe                	mov    %edi,%esi
 b62:	31 d2                	xor    %edx,%edx
 b64:	8d 7e 01             	lea    0x1(%esi),%edi
 b67:	f7 f1                	div    %ecx
 b69:	0f b6 92 70 11 00 00 	movzbl 0x1170(%edx),%edx
  }while((x /= base) != 0);
 b70:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 b72:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 b75:	75 e9                	jne    b60 <printint+0x30>
  if(neg)
 b77:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 b7a:	85 c0                	test   %eax,%eax
 b7c:	74 08                	je     b86 <printint+0x56>
    buf[i++] = '-';
 b7e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 b83:	8d 7e 02             	lea    0x2(%esi),%edi
 b86:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 b8a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 b8d:	8d 76 00             	lea    0x0(%esi),%esi
 b90:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 b93:	83 ec 04             	sub    $0x4,%esp
 b96:	83 ee 01             	sub    $0x1,%esi
 b99:	6a 01                	push   $0x1
 b9b:	53                   	push   %ebx
 b9c:	57                   	push   %edi
 b9d:	88 45 d7             	mov    %al,-0x29(%ebp)
 ba0:	e8 ed fe ff ff       	call   a92 <write>

  while(--i >= 0)
 ba5:	83 c4 10             	add    $0x10,%esp
 ba8:	39 de                	cmp    %ebx,%esi
 baa:	75 e4                	jne    b90 <printint+0x60>
    putc(fd, buf[i]);
}
 bac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 baf:	5b                   	pop    %ebx
 bb0:	5e                   	pop    %esi
 bb1:	5f                   	pop    %edi
 bb2:	5d                   	pop    %ebp
 bb3:	c3                   	ret    
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 bb8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 bbf:	eb 90                	jmp    b51 <printint+0x21>
 bc1:	eb 0d                	jmp    bd0 <printf>
 bc3:	90                   	nop
 bc4:	90                   	nop
 bc5:	90                   	nop
 bc6:	90                   	nop
 bc7:	90                   	nop
 bc8:	90                   	nop
 bc9:	90                   	nop
 bca:	90                   	nop
 bcb:	90                   	nop
 bcc:	90                   	nop
 bcd:	90                   	nop
 bce:	90                   	nop
 bcf:	90                   	nop

00000bd0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 bd0:	55                   	push   %ebp
 bd1:	89 e5                	mov    %esp,%ebp
 bd3:	57                   	push   %edi
 bd4:	56                   	push   %esi
 bd5:	53                   	push   %ebx
 bd6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bd9:	8b 75 0c             	mov    0xc(%ebp),%esi
 bdc:	0f b6 1e             	movzbl (%esi),%ebx
 bdf:	84 db                	test   %bl,%bl
 be1:	0f 84 b3 00 00 00    	je     c9a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 be7:	8d 45 10             	lea    0x10(%ebp),%eax
 bea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 bed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 bef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 bf2:	eb 2f                	jmp    c23 <printf+0x53>
 bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 bf8:	83 f8 25             	cmp    $0x25,%eax
 bfb:	0f 84 a7 00 00 00    	je     ca8 <printf+0xd8>
  write(fd, &c, 1);
 c01:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c04:	83 ec 04             	sub    $0x4,%esp
 c07:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c0a:	6a 01                	push   $0x1
 c0c:	50                   	push   %eax
 c0d:	ff 75 08             	pushl  0x8(%ebp)
 c10:	e8 7d fe ff ff       	call   a92 <write>
 c15:	83 c4 10             	add    $0x10,%esp
 c18:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 c1b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c1f:	84 db                	test   %bl,%bl
 c21:	74 77                	je     c9a <printf+0xca>
    if(state == 0){
 c23:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 c25:	0f be cb             	movsbl %bl,%ecx
 c28:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c2b:	74 cb                	je     bf8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c2d:	83 ff 25             	cmp    $0x25,%edi
 c30:	75 e6                	jne    c18 <printf+0x48>
      if(c == 'd'){
 c32:	83 f8 64             	cmp    $0x64,%eax
 c35:	0f 84 05 01 00 00    	je     d40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c3b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c41:	83 f9 70             	cmp    $0x70,%ecx
 c44:	74 72                	je     cb8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c46:	83 f8 73             	cmp    $0x73,%eax
 c49:	0f 84 99 00 00 00    	je     ce8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c4f:	83 f8 63             	cmp    $0x63,%eax
 c52:	0f 84 08 01 00 00    	je     d60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 c58:	83 f8 25             	cmp    $0x25,%eax
 c5b:	0f 84 ef 00 00 00    	je     d50 <printf+0x180>
  write(fd, &c, 1);
 c61:	8d 45 e7             	lea    -0x19(%ebp),%eax
 c64:	83 ec 04             	sub    $0x4,%esp
 c67:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c6b:	6a 01                	push   $0x1
 c6d:	50                   	push   %eax
 c6e:	ff 75 08             	pushl  0x8(%ebp)
 c71:	e8 1c fe ff ff       	call   a92 <write>
 c76:	83 c4 0c             	add    $0xc,%esp
 c79:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 c7c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 c7f:	6a 01                	push   $0x1
 c81:	50                   	push   %eax
 c82:	ff 75 08             	pushl  0x8(%ebp)
 c85:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c88:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 c8a:	e8 03 fe ff ff       	call   a92 <write>
  for(i = 0; fmt[i]; i++){
 c8f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 c93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 c96:	84 db                	test   %bl,%bl
 c98:	75 89                	jne    c23 <printf+0x53>
    }
  }
}
 c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c9d:	5b                   	pop    %ebx
 c9e:	5e                   	pop    %esi
 c9f:	5f                   	pop    %edi
 ca0:	5d                   	pop    %ebp
 ca1:	c3                   	ret    
 ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 ca8:	bf 25 00 00 00       	mov    $0x25,%edi
 cad:	e9 66 ff ff ff       	jmp    c18 <printf+0x48>
 cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 cb8:	83 ec 0c             	sub    $0xc,%esp
 cbb:	b9 10 00 00 00       	mov    $0x10,%ecx
 cc0:	6a 00                	push   $0x0
 cc2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 cc5:	8b 45 08             	mov    0x8(%ebp),%eax
 cc8:	8b 17                	mov    (%edi),%edx
 cca:	e8 61 fe ff ff       	call   b30 <printint>
        ap++;
 ccf:	89 f8                	mov    %edi,%eax
 cd1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 cd4:	31 ff                	xor    %edi,%edi
        ap++;
 cd6:	83 c0 04             	add    $0x4,%eax
 cd9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 cdc:	e9 37 ff ff ff       	jmp    c18 <printf+0x48>
 ce1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 ce8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 ceb:	8b 08                	mov    (%eax),%ecx
        ap++;
 ced:	83 c0 04             	add    $0x4,%eax
 cf0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 cf3:	85 c9                	test   %ecx,%ecx
 cf5:	0f 84 8e 00 00 00    	je     d89 <printf+0x1b9>
        while(*s != 0){
 cfb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 cfe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 d00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 d02:	84 c0                	test   %al,%al
 d04:	0f 84 0e ff ff ff    	je     c18 <printf+0x48>
 d0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 d0d:	89 de                	mov    %ebx,%esi
 d0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 d15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 d18:	83 ec 04             	sub    $0x4,%esp
          s++;
 d1b:	83 c6 01             	add    $0x1,%esi
 d1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d21:	6a 01                	push   $0x1
 d23:	57                   	push   %edi
 d24:	53                   	push   %ebx
 d25:	e8 68 fd ff ff       	call   a92 <write>
        while(*s != 0){
 d2a:	0f b6 06             	movzbl (%esi),%eax
 d2d:	83 c4 10             	add    $0x10,%esp
 d30:	84 c0                	test   %al,%al
 d32:	75 e4                	jne    d18 <printf+0x148>
 d34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 d37:	31 ff                	xor    %edi,%edi
 d39:	e9 da fe ff ff       	jmp    c18 <printf+0x48>
 d3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 d40:	83 ec 0c             	sub    $0xc,%esp
 d43:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d48:	6a 01                	push   $0x1
 d4a:	e9 73 ff ff ff       	jmp    cc2 <printf+0xf2>
 d4f:	90                   	nop
  write(fd, &c, 1);
 d50:	83 ec 04             	sub    $0x4,%esp
 d53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 d56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 d59:	6a 01                	push   $0x1
 d5b:	e9 21 ff ff ff       	jmp    c81 <printf+0xb1>
        putc(fd, *ap);
 d60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 d63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 d66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 d68:	6a 01                	push   $0x1
        ap++;
 d6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 d6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 d70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 d73:	50                   	push   %eax
 d74:	ff 75 08             	pushl  0x8(%ebp)
 d77:	e8 16 fd ff ff       	call   a92 <write>
        ap++;
 d7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 d7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d82:	31 ff                	xor    %edi,%edi
 d84:	e9 8f fe ff ff       	jmp    c18 <printf+0x48>
          s = "(null)";
 d89:	bb 68 11 00 00       	mov    $0x1168,%ebx
        while(*s != 0){
 d8e:	b8 28 00 00 00       	mov    $0x28,%eax
 d93:	e9 72 ff ff ff       	jmp    d0a <printf+0x13a>
 d98:	66 90                	xchg   %ax,%ax
 d9a:	66 90                	xchg   %ax,%ax
 d9c:	66 90                	xchg   %ax,%ax
 d9e:	66 90                	xchg   %ax,%ax

00000da0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 da0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 da1:	a1 80 15 00 00       	mov    0x1580,%eax
{
 da6:	89 e5                	mov    %esp,%ebp
 da8:	57                   	push   %edi
 da9:	56                   	push   %esi
 daa:	53                   	push   %ebx
 dab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 dae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 db8:	39 c8                	cmp    %ecx,%eax
 dba:	8b 10                	mov    (%eax),%edx
 dbc:	73 32                	jae    df0 <free+0x50>
 dbe:	39 d1                	cmp    %edx,%ecx
 dc0:	72 04                	jb     dc6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 dc2:	39 d0                	cmp    %edx,%eax
 dc4:	72 32                	jb     df8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 dc6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 dc9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 dcc:	39 fa                	cmp    %edi,%edx
 dce:	74 30                	je     e00 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 dd0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 dd3:	8b 50 04             	mov    0x4(%eax),%edx
 dd6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 dd9:	39 f1                	cmp    %esi,%ecx
 ddb:	74 3a                	je     e17 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 ddd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 ddf:	a3 80 15 00 00       	mov    %eax,0x1580
}
 de4:	5b                   	pop    %ebx
 de5:	5e                   	pop    %esi
 de6:	5f                   	pop    %edi
 de7:	5d                   	pop    %ebp
 de8:	c3                   	ret    
 de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 df0:	39 d0                	cmp    %edx,%eax
 df2:	72 04                	jb     df8 <free+0x58>
 df4:	39 d1                	cmp    %edx,%ecx
 df6:	72 ce                	jb     dc6 <free+0x26>
{
 df8:	89 d0                	mov    %edx,%eax
 dfa:	eb bc                	jmp    db8 <free+0x18>
 dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 e00:	03 72 04             	add    0x4(%edx),%esi
 e03:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e06:	8b 10                	mov    (%eax),%edx
 e08:	8b 12                	mov    (%edx),%edx
 e0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e0d:	8b 50 04             	mov    0x4(%eax),%edx
 e10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e13:	39 f1                	cmp    %esi,%ecx
 e15:	75 c6                	jne    ddd <free+0x3d>
    p->s.size += bp->s.size;
 e17:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 e1a:	a3 80 15 00 00       	mov    %eax,0x1580
    p->s.size += bp->s.size;
 e1f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e22:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e25:	89 10                	mov    %edx,(%eax)
}
 e27:	5b                   	pop    %ebx
 e28:	5e                   	pop    %esi
 e29:	5f                   	pop    %edi
 e2a:	5d                   	pop    %ebp
 e2b:	c3                   	ret    
 e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e30:	55                   	push   %ebp
 e31:	89 e5                	mov    %esp,%ebp
 e33:	57                   	push   %edi
 e34:	56                   	push   %esi
 e35:	53                   	push   %ebx
 e36:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e3c:	8b 15 80 15 00 00    	mov    0x1580,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e42:	8d 78 07             	lea    0x7(%eax),%edi
 e45:	c1 ef 03             	shr    $0x3,%edi
 e48:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 e4b:	85 d2                	test   %edx,%edx
 e4d:	0f 84 9d 00 00 00    	je     ef0 <malloc+0xc0>
 e53:	8b 02                	mov    (%edx),%eax
 e55:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 e58:	39 cf                	cmp    %ecx,%edi
 e5a:	76 6c                	jbe    ec8 <malloc+0x98>
 e5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 e62:	bb 00 10 00 00       	mov    $0x1000,%ebx
 e67:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 e6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 e71:	eb 0e                	jmp    e81 <malloc+0x51>
 e73:	90                   	nop
 e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e7a:	8b 48 04             	mov    0x4(%eax),%ecx
 e7d:	39 f9                	cmp    %edi,%ecx
 e7f:	73 47                	jae    ec8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e81:	39 05 80 15 00 00    	cmp    %eax,0x1580
 e87:	89 c2                	mov    %eax,%edx
 e89:	75 ed                	jne    e78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 e8b:	83 ec 0c             	sub    $0xc,%esp
 e8e:	56                   	push   %esi
 e8f:	e8 66 fc ff ff       	call   afa <sbrk>
  if(p == (char*)-1)
 e94:	83 c4 10             	add    $0x10,%esp
 e97:	83 f8 ff             	cmp    $0xffffffff,%eax
 e9a:	74 1c                	je     eb8 <malloc+0x88>
  hp->s.size = nu;
 e9c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 e9f:	83 ec 0c             	sub    $0xc,%esp
 ea2:	83 c0 08             	add    $0x8,%eax
 ea5:	50                   	push   %eax
 ea6:	e8 f5 fe ff ff       	call   da0 <free>
  return freep;
 eab:	8b 15 80 15 00 00    	mov    0x1580,%edx
      if((p = morecore(nunits)) == 0)
 eb1:	83 c4 10             	add    $0x10,%esp
 eb4:	85 d2                	test   %edx,%edx
 eb6:	75 c0                	jne    e78 <malloc+0x48>
        return 0;
  }
}
 eb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 ebb:	31 c0                	xor    %eax,%eax
}
 ebd:	5b                   	pop    %ebx
 ebe:	5e                   	pop    %esi
 ebf:	5f                   	pop    %edi
 ec0:	5d                   	pop    %ebp
 ec1:	c3                   	ret    
 ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ec8:	39 cf                	cmp    %ecx,%edi
 eca:	74 54                	je     f20 <malloc+0xf0>
        p->s.size -= nunits;
 ecc:	29 f9                	sub    %edi,%ecx
 ece:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ed1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ed4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ed7:	89 15 80 15 00 00    	mov    %edx,0x1580
}
 edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ee0:	83 c0 08             	add    $0x8,%eax
}
 ee3:	5b                   	pop    %ebx
 ee4:	5e                   	pop    %esi
 ee5:	5f                   	pop    %edi
 ee6:	5d                   	pop    %ebp
 ee7:	c3                   	ret    
 ee8:	90                   	nop
 ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 ef0:	c7 05 80 15 00 00 84 	movl   $0x1584,0x1580
 ef7:	15 00 00 
 efa:	c7 05 84 15 00 00 84 	movl   $0x1584,0x1584
 f01:	15 00 00 
    base.s.size = 0;
 f04:	b8 84 15 00 00       	mov    $0x1584,%eax
 f09:	c7 05 88 15 00 00 00 	movl   $0x0,0x1588
 f10:	00 00 00 
 f13:	e9 44 ff ff ff       	jmp    e5c <malloc+0x2c>
 f18:	90                   	nop
 f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 f20:	8b 08                	mov    (%eax),%ecx
 f22:	89 0a                	mov    %ecx,(%edx)
 f24:	eb b1                	jmp    ed7 <malloc+0xa7>
