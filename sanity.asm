
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
   f:	e8 ce 0b 00 00       	call   be2 <getNumberOfFreePages>
  
  //  Cow Tests:
  makeTest(cowPhysicalTest);
  14:	83 ec 0c             	sub    $0xc,%esp
  int freeMem = getNumberOfFreePages();
  17:	89 c3                	mov    %eax,%ebx
  makeTest(cowPhysicalTest);
  19:	68 40 01 00 00       	push   $0x140
  1e:	e8 8d 08 00 00       	call   8b0 <makeTest>
  makeTest(cowSwapFile_pageSeperationTest);
  23:	c7 04 24 40 03 00 00 	movl   $0x340,(%esp)
  2a:	e8 81 08 00 00       	call   8b0 <makeTest>
  makeTest(cowSwapFile_killedChiledTest);
  2f:	c7 04 24 20 06 00 00 	movl   $0x620,(%esp)
  36:	e8 75 08 00 00       	call   8b0 <makeTest>
  makeTest(cowSwapFile_maxPhyInChildTest);
  3b:	c7 04 24 60 04 00 00 	movl   $0x460,(%esp)
  42:	e8 69 08 00 00       	call   8b0 <makeTest>
  
  // General Page Tests:
  makeTest(PhysicalMemTest);
  47:	c7 04 24 90 07 00 00 	movl   $0x790,(%esp)
  4e:	e8 5d 08 00 00       	call   8b0 <makeTest>
  makeTest(SwapFileTest);
  53:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  5a:	e8 51 08 00 00       	call   8b0 <makeTest>
  memLeakTest(freeMem);
  5f:	89 1c 24             	mov    %ebx,(%esp)
  62:	e8 e9 07 00 00       	call   850 <memLeakTest>
  exit();
  67:	e8 d6 0a 00 00       	call   b42 <exit>
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <SwapFileTest>:
SwapFileTest(){
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	56                   	push   %esi
  74:	53                   	push   %ebx
  for(i = 0; i < 20; i++){
  75:	31 db                	xor    %ebx,%ebx
SwapFileTest(){
  77:	83 ec 50             	sub    $0x50,%esp
  int pid = getpid();
  7a:	e8 43 0b 00 00       	call   bc2 <getpid>
  printf(1,"SwapFileTest :");
  7f:	83 ec 08             	sub    $0x8,%esp
  int pid = getpid();
  82:	89 c6                	mov    %eax,%esi
  printf(1,"SwapFileTest :");
  84:	68 f8 0f 00 00       	push   $0xff8
  89:	6a 01                	push   $0x1
  8b:	e8 10 0c 00 00       	call   ca0 <printf>
  printProcDump(pid);
  90:	89 34 24             	mov    %esi,(%esp)
  93:	e8 52 0b 00 00       	call   bea <printProcDump>
  printProcDump(pid);
  98:	89 34 24             	mov    %esi,(%esp)
  9b:	e8 4a 0b 00 00       	call   bea <printProcDump>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	90                   	nop
  a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    lst[i] = (int*)sbrk(PGSIZE);
  a8:	83 ec 0c             	sub    $0xc,%esp
  ab:	68 00 10 00 00       	push   $0x1000
  b0:	e8 15 0b 00 00       	call   bca <sbrk>
  b5:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
  b9:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
  bb:	83 c3 01             	add    $0x1,%ebx
  be:	83 c4 10             	add    $0x10,%esp
  c1:	83 fb 14             	cmp    $0x14,%ebx
  c4:	75 e2                	jne    a8 <SwapFileTest+0x38>
  printProcDump(pid);
  c6:	83 ec 0c             	sub    $0xc,%esp
  c9:	56                   	push   %esi
  ca:	e8 1b 0b 00 00       	call   bea <printProcDump>
  sleep(50);
  cf:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
  d6:	e8 f7 0a 00 00       	call   bd2 <sleep>
  db:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++){
  de:	31 c0                	xor    %eax,%eax
  e0:	eb 0e                	jmp    f0 <SwapFileTest+0x80>
  e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  e8:	83 c0 01             	add    $0x1,%eax
  eb:	83 f8 14             	cmp    $0x14,%eax
  ee:	74 30                	je     120 <SwapFileTest+0xb0>
    if(*lst[i]!=i){
  f0:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
  f4:	8b 12                	mov    (%edx),%edx
  f6:	39 c2                	cmp    %eax,%edx
  f8:	74 ee                	je     e8 <SwapFileTest+0x78>
      printf(1," FAILED %d %d",*lst[i],i);
  fa:	50                   	push   %eax
  fb:	52                   	push   %edx
  fc:	68 07 10 00 00       	push   $0x1007
 101:	6a 01                	push   $0x1
 103:	e8 98 0b 00 00       	call   ca0 <printf>
      return -1;
 108:	83 c4 10             	add    $0x10,%esp
}
 10b:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return -1;
 10e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 113:	5b                   	pop    %ebx
 114:	5e                   	pop    %esi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  printProcDump(pid);
 120:	83 ec 0c             	sub    $0xc,%esp
 123:	56                   	push   %esi
 124:	e8 c1 0a 00 00       	call   bea <printProcDump>
  return 0;
 129:	83 c4 10             	add    $0x10,%esp
}
 12c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
 12f:	31 c0                	xor    %eax,%eax
}
 131:	5b                   	pop    %ebx
 132:	5e                   	pop    %esi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    
 135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <cowPhysicalTest>:
cowPhysicalTest(){
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
 146:	83 ec 24             	sub    $0x24,%esp
  printf(1,"cowPhysicalTest :");
 149:	68 15 10 00 00       	push   $0x1015
 14e:	6a 01                	push   $0x1
 150:	e8 4b 0b 00 00       	call   ca0 <printf>
  for(i = 0; i < 3; i++){
 155:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 15c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 15f:	83 c4 10             	add    $0x10,%esp
 162:	83 f8 02             	cmp    $0x2,%eax
 165:	7f 3d                	jg     1a4 <cowPhysicalTest+0x64>
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lst[i] = (int*)sbrk(PGSIZE);
 170:	83 ec 0c             	sub    $0xc,%esp
 173:	8b 5d d8             	mov    -0x28(%ebp),%ebx
 176:	68 00 10 00 00       	push   $0x1000
 17b:	e8 4a 0a 00 00       	call   bca <sbrk>
 180:	89 44 9d dc          	mov    %eax,-0x24(%ebp,%ebx,4)
    *lst[i]=i;
 184:	8b 45 d8             	mov    -0x28(%ebp),%eax
  for(i = 0; i < 3; i++){
 187:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 18a:	8b 55 d8             	mov    -0x28(%ebp),%edx
 18d:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
 191:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 3; i++){
 193:	8b 45 d8             	mov    -0x28(%ebp),%eax
 196:	83 c0 01             	add    $0x1,%eax
 199:	89 45 d8             	mov    %eax,-0x28(%ebp)
 19c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 19f:	83 f8 02             	cmp    $0x2,%eax
 1a2:	7e cc                	jle    170 <cowPhysicalTest+0x30>
  int freePages_beforeChild = getNumberOfFreePages();
 1a4:	e8 39 0a 00 00       	call   be2 <getNumberOfFreePages>
 1a9:	89 c7                	mov    %eax,%edi
  int pid = fork();
 1ab:	e8 8a 09 00 00       	call   b3a <fork>
 1b0:	89 c6                	mov    %eax,%esi
  printProcDump(getpid());
 1b2:	e8 0b 0a 00 00       	call   bc2 <getpid>
 1b7:	83 ec 0c             	sub    $0xc,%esp
 1ba:	50                   	push   %eax
 1bb:	e8 2a 0a 00 00       	call   bea <printProcDump>
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 1c0:	e8 1d 0a 00 00       	call   be2 <getNumberOfFreePages>
  sleep(10);
 1c5:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 1cc:	89 c3                	mov    %eax,%ebx
  sleep(10);
 1ce:	e8 ff 09 00 00       	call   bd2 <sleep>
  if(pid==0){
 1d3:	83 c4 10             	add    $0x10,%esp
 1d6:	85 f6                	test   %esi,%esi
 1d8:	0f 85 c2 00 00 00    	jne    2a0 <cowPhysicalTest+0x160>
    for(i = 0; i < 3; i++){
 1de:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 1e5:	8b 45 d8             	mov    -0x28(%ebp),%eax
 1e8:	83 f8 02             	cmp    $0x2,%eax
 1eb:	7f 26                	jg     213 <cowPhysicalTest+0xd3>
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
      if(*lst[i]!=i){
 1f0:	8b 55 d8             	mov    -0x28(%ebp),%edx
 1f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
 1f6:	8b 54 95 dc          	mov    -0x24(%ebp,%edx,4),%edx
 1fa:	39 02                	cmp    %eax,(%edx)
 1fc:	0f 85 19 01 00 00    	jne    31b <cowPhysicalTest+0x1db>
    for(i = 0; i < 3; i++){
 202:	8b 45 d8             	mov    -0x28(%ebp),%eax
 205:	83 c0 01             	add    $0x1,%eax
 208:	89 45 d8             	mov    %eax,-0x28(%ebp)
 20b:	8b 45 d8             	mov    -0x28(%ebp),%eax
 20e:	83 f8 02             	cmp    $0x2,%eax
 211:	7e dd                	jle    1f0 <cowPhysicalTest+0xb0>
    printProcDump(getpid());
 213:	e8 aa 09 00 00       	call   bc2 <getpid>
 218:	83 ec 0c             	sub    $0xc,%esp
 21b:	50                   	push   %eax
 21c:	e8 c9 09 00 00       	call   bea <printProcDump>
    sleep(50);
 221:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
 228:	e8 a5 09 00 00       	call   bd2 <sleep>
    int freePages_beforeCloning = getNumberOfFreePages();
 22d:	e8 b0 09 00 00       	call   be2 <getNumberOfFreePages>
    if(freePages_beforeReadingFromParent != freePages_beforeCloning){
 232:	83 c4 10             	add    $0x10,%esp
 235:	39 c3                	cmp    %eax,%ebx
 237:	0f 85 f2 00 00 00    	jne    32f <cowPhysicalTest+0x1ef>
    *lst[1] = 66;
 23d:	8b 45 e0             	mov    -0x20(%ebp),%eax
    sleep(50);
 240:	83 ec 0c             	sub    $0xc,%esp
    *lst[1] = 66;
 243:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
    sleep(50);
 249:	6a 32                	push   $0x32
 24b:	e8 82 09 00 00       	call   bd2 <sleep>
    printProcDump(getpid());
 250:	e8 6d 09 00 00       	call   bc2 <getpid>
 255:	89 04 24             	mov    %eax,(%esp)
 258:	e8 8d 09 00 00       	call   bea <printProcDump>
    if(freePages_beforeCloning != getNumberOfFreePages()+1){
 25d:	e8 80 09 00 00       	call   be2 <getNumberOfFreePages>
 262:	83 c0 01             	add    $0x1,%eax
 265:	83 c4 10             	add    $0x10,%esp
 268:	39 d8                	cmp    %ebx,%eax
 26a:	74 24                	je     290 <cowPhysicalTest+0x150>
      printf(1,"Err : num of free pages after cloning");
 26c:	83 ec 08             	sub    $0x8,%esp
 26f:	68 6c 11 00 00       	push   $0x116c
 274:	6a 01                	push   $0x1
 276:	e8 25 0a 00 00       	call   ca0 <printf>
      printf(1," FAILED");
 27b:	5e                   	pop    %esi
 27c:	5f                   	pop    %edi
 27d:	68 27 10 00 00       	push   $0x1027
 282:	6a 01                	push   $0x1
 284:	e8 17 0a 00 00       	call   ca0 <printf>
      exit();
 289:	e8 b4 08 00 00       	call   b42 <exit>
 28e:	66 90                	xchg   %ax,%ax
    sleep(10);
 290:	83 ec 0c             	sub    $0xc,%esp
 293:	6a 0a                	push   $0xa
 295:	e8 38 09 00 00       	call   bd2 <sleep>
    exit();
 29a:	e8 a3 08 00 00       	call   b42 <exit>
 29f:	90                   	nop
  printProcDump(getpid());
 2a0:	e8 1d 09 00 00       	call   bc2 <getpid>
 2a5:	83 ec 0c             	sub    $0xc,%esp
 2a8:	50                   	push   %eax
 2a9:	e8 3c 09 00 00       	call   bea <printProcDump>
  wait();
 2ae:	e8 97 08 00 00       	call   b4a <wait>
  printProcDump(getpid());
 2b3:	e8 0a 09 00 00       	call   bc2 <getpid>
 2b8:	89 04 24             	mov    %eax,(%esp)
 2bb:	e8 2a 09 00 00       	call   bea <printProcDump>
  if(freePages_beforeChild != getNumberOfFreePages()){
 2c0:	e8 1d 09 00 00       	call   be2 <getNumberOfFreePages>
 2c5:	83 c4 10             	add    $0x10,%esp
 2c8:	39 f8                	cmp    %edi,%eax
 2ca:	75 0a                	jne    2d6 <cowPhysicalTest+0x196>
  return 0;
 2cc:	31 c0                	xor    %eax,%eax
}
 2ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2d1:	5b                   	pop    %ebx
 2d2:	5e                   	pop    %esi
 2d3:	5f                   	pop    %edi
 2d4:	5d                   	pop    %ebp
 2d5:	c3                   	ret    
    printf(1,"before: %d    after: %d",freePages_beforeChild,getNumberOfFreePages());
 2d6:	e8 07 09 00 00       	call   be2 <getNumberOfFreePages>
 2db:	50                   	push   %eax
 2dc:	57                   	push   %edi
 2dd:	68 2f 10 00 00       	push   $0x102f
 2e2:	6a 01                	push   $0x1
 2e4:	e8 b7 09 00 00       	call   ca0 <printf>
    printf(1,"Err : num of free pages after child exit");
 2e9:	58                   	pop    %eax
 2ea:	5a                   	pop    %edx
 2eb:	68 94 11 00 00       	push   $0x1194
 2f0:	6a 01                	push   $0x1
 2f2:	e8 a9 09 00 00       	call   ca0 <printf>
    printf(1," FAILED");
 2f7:	59                   	pop    %ecx
 2f8:	5b                   	pop    %ebx
 2f9:	68 27 10 00 00       	push   $0x1027
 2fe:	6a 01                	push   $0x1
 300:	e8 9b 09 00 00       	call   ca0 <printf>
    sleep(50000);
 305:	c7 04 24 50 c3 00 00 	movl   $0xc350,(%esp)
 30c:	e8 c1 08 00 00       	call   bd2 <sleep>
    return -1;
 311:	83 c4 10             	add    $0x10,%esp
 314:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 319:	eb b3                	jmp    2ce <cowPhysicalTest+0x18e>
        printf(1," FAILED");
 31b:	83 ec 08             	sub    $0x8,%esp
 31e:	68 27 10 00 00       	push   $0x1027
 323:	6a 01                	push   $0x1
 325:	e8 76 09 00 00       	call   ca0 <printf>
        exit();
 32a:	e8 13 08 00 00       	call   b42 <exit>
      printf(1,"Err : num of free pages after reading only has changed");
 32f:	50                   	push   %eax
 330:	50                   	push   %eax
 331:	68 34 11 00 00       	push   $0x1134
 336:	e9 39 ff ff ff       	jmp    274 <cowPhysicalTest+0x134>
 33b:	90                   	nop
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000340 <cowSwapFile_pageSeperationTest>:
cowSwapFile_pageSeperationTest(){
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	53                   	push   %ebx
 344:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_pageSeperationTest :");
 347:	68 c0 11 00 00       	push   $0x11c0
 34c:	6a 01                	push   $0x1
 34e:	e8 4d 09 00 00       	call   ca0 <printf>
  for(i = 0; i < 20; i++){
 353:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 35a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 35d:	83 c4 10             	add    $0x10,%esp
 360:	83 f8 13             	cmp    $0x13,%eax
 363:	7f 37                	jg     39c <cowSwapFile_pageSeperationTest+0x5c>
 365:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 368:	83 ec 0c             	sub    $0xc,%esp
 36b:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 36e:	68 00 10 00 00       	push   $0x1000
 373:	e8 52 08 00 00       	call   bca <sbrk>
 378:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 37c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 37f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 382:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 385:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 389:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 38b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 38e:	83 c0 01             	add    $0x1,%eax
 391:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 394:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 397:	83 f8 13             	cmp    $0x13,%eax
 39a:	7e cc                	jle    368 <cowSwapFile_pageSeperationTest+0x28>
  int pid = fork();
 39c:	e8 99 07 00 00       	call   b3a <fork>
  if(pid==0){
 3a1:	85 c0                	test   %eax,%eax
 3a3:	74 57                	je     3fc <cowSwapFile_pageSeperationTest+0xbc>
  for(j = 0; j < 20; j++){
 3a5:	31 c0                	xor    %eax,%eax
 3a7:	eb 0f                	jmp    3b8 <cowSwapFile_pageSeperationTest+0x78>
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b0:	83 c0 01             	add    $0x1,%eax
 3b3:	83 f8 14             	cmp    $0x14,%eax
 3b6:	74 38                	je     3f0 <cowSwapFile_pageSeperationTest+0xb0>
      if(*lst[j]!=j){
 3b8:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 3bc:	8b 12                	mov    (%edx),%edx
 3be:	39 c2                	cmp    %eax,%edx
 3c0:	74 ee                	je     3b0 <cowSwapFile_pageSeperationTest+0x70>
        printf(1,"\nparent fail %d %d\n",*lst[j], j);
 3c2:	50                   	push   %eax
 3c3:	52                   	push   %edx
 3c4:	68 5a 10 00 00       	push   $0x105a
 3c9:	6a 01                	push   $0x1
 3cb:	e8 d0 08 00 00       	call   ca0 <printf>
        printf(1," FAILED");
 3d0:	58                   	pop    %eax
 3d1:	5a                   	pop    %edx
 3d2:	68 27 10 00 00       	push   $0x1027
 3d7:	6a 01                	push   $0x1
 3d9:	e8 c2 08 00 00       	call   ca0 <printf>
        return -1;
 3de:	83 c4 10             	add    $0x10,%esp
 3e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 3e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e9:	c9                   	leave  
 3ea:	c3                   	ret    
 3eb:	90                   	nop
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
 3f0:	e8 55 07 00 00       	call   b4a <wait>
  return 0;
 3f5:	31 c0                	xor    %eax,%eax
}
 3f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    
    for(i = 0; i < 20; i++){
 3fc:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 403:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 406:	83 f8 13             	cmp    $0x13,%eax
 409:	7f 49                	jg     454 <cowSwapFile_pageSeperationTest+0x114>
      if(*lst[i]!=i){
 40b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 40e:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 411:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 415:	39 02                	cmp    %eax,(%edx)
 417:	74 2a                	je     443 <cowSwapFile_pageSeperationTest+0x103>
        printf(1,"\nchild fail %d %d\n",*lst[i], i);
 419:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 41c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 41f:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 423:	52                   	push   %edx
 424:	ff 30                	pushl  (%eax)
 426:	68 47 10 00 00       	push   $0x1047
 42b:	6a 01                	push   $0x1
 42d:	e8 6e 08 00 00       	call   ca0 <printf>
        printf(1," FAILED");
 432:	59                   	pop    %ecx
 433:	5b                   	pop    %ebx
 434:	68 27 10 00 00       	push   $0x1027
 439:	6a 01                	push   $0x1
 43b:	e8 60 08 00 00       	call   ca0 <printf>
 440:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 20; i++){
 443:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 446:	83 c0 01             	add    $0x1,%eax
 449:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 44c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 44f:	83 f8 13             	cmp    $0x13,%eax
 452:	7e b7                	jle    40b <cowSwapFile_pageSeperationTest+0xcb>
    exit();
 454:	e8 e9 06 00 00       	call   b42 <exit>
 459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000460 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	56                   	push   %esi
 464:	53                   	push   %ebx
 465:	83 ec 60             	sub    $0x60,%esp
  int freePages = getNumberOfFreePages();
 468:	e8 75 07 00 00       	call   be2 <getNumberOfFreePages>
  printf(1,"1  free pages: %d\n",freePages);
 46d:	83 ec 04             	sub    $0x4,%esp
  int freePages = getNumberOfFreePages();
 470:	89 c6                	mov    %eax,%esi
  printf(1,"1  free pages: %d\n",freePages);
 472:	50                   	push   %eax
 473:	68 6e 10 00 00       	push   $0x106e
 478:	6a 01                	push   $0x1
 47a:	e8 21 08 00 00       	call   ca0 <printf>
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 47f:	59                   	pop    %ecx
 480:	5b                   	pop    %ebx
 481:	68 e4 11 00 00       	push   $0x11e4
 486:	6a 01                	push   $0x1
  for(i = 0; i < 20; i++){
 488:	31 db                	xor    %ebx,%ebx
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 48a:	e8 11 08 00 00       	call   ca0 <printf>
 48f:	83 c4 10             	add    $0x10,%esp
 492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 498:	83 ec 0c             	sub    $0xc,%esp
 49b:	68 00 10 00 00       	push   $0x1000
 4a0:	e8 25 07 00 00       	call   bca <sbrk>
 4a5:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 4a9:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
 4ab:	83 c3 01             	add    $0x1,%ebx
 4ae:	83 c4 10             	add    $0x10,%esp
 4b1:	83 fb 14             	cmp    $0x14,%ebx
 4b4:	75 e2                	jne    498 <cowSwapFile_maxPhyInChildTest+0x38>
  if(freePages != getNumberOfFreePages()+16){
 4b6:	e8 27 07 00 00       	call   be2 <getNumberOfFreePages>
 4bb:	83 c0 10             	add    $0x10,%eax
 4be:	39 f0                	cmp    %esi,%eax
 4c0:	74 18                	je     4da <cowSwapFile_maxPhyInChildTest+0x7a>
    printf(1," FAILED 1(Free Memory error) %d\n",getNumberOfFreePages());
 4c2:	e8 1b 07 00 00       	call   be2 <getNumberOfFreePages>
 4c7:	83 ec 04             	sub    $0x4,%esp
 4ca:	50                   	push   %eax
 4cb:	68 04 12 00 00       	push   $0x1204
 4d0:	6a 01                	push   $0x1
 4d2:	e8 c9 07 00 00       	call   ca0 <printf>
 4d7:	83 c4 10             	add    $0x10,%esp
  int pid = fork();
 4da:	e8 5b 06 00 00       	call   b3a <fork>
  if(pid==0){
 4df:	85 c0                	test   %eax,%eax
 4e1:	0f 84 ae 00 00 00    	je     595 <cowSwapFile_maxPhyInChildTest+0x135>
  wait();
 4e7:	e8 5e 06 00 00       	call   b4a <wait>
  printf(1,"4  free pages: %d\n",getNumberOfFreePages());
 4ec:	e8 f1 06 00 00       	call   be2 <getNumberOfFreePages>
 4f1:	83 ec 04             	sub    $0x4,%esp
 4f4:	50                   	push   %eax
 4f5:	68 c5 10 00 00       	push   $0x10c5
 4fa:	6a 01                	push   $0x1
 4fc:	e8 9f 07 00 00       	call   ca0 <printf>
 501:	83 c4 10             	add    $0x10,%esp
  for(j = 0; j < 20; j++){
 504:	31 c0                	xor    %eax,%eax
 506:	eb 10                	jmp    518 <cowSwapFile_maxPhyInChildTest+0xb8>
 508:	90                   	nop
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 510:	83 c0 01             	add    $0x1,%eax
 513:	83 f8 14             	cmp    $0x14,%eax
 516:	74 38                	je     550 <cowSwapFile_maxPhyInChildTest+0xf0>
      if(*lst[j]!=j){
 518:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 51c:	39 02                	cmp    %eax,(%edx)
 51e:	74 f0                	je     510 <cowSwapFile_maxPhyInChildTest+0xb0>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	6a 01                	push   $0x1
 525:	68 5a 10 00 00       	push   $0x105a
 52a:	6a 01                	push   $0x1
 52c:	e8 6f 07 00 00       	call   ca0 <printf>
        printf(1," FAILED");
 531:	58                   	pop    %eax
 532:	5a                   	pop    %edx
 533:	68 27 10 00 00       	push   $0x1027
 538:	6a 01                	push   $0x1
 53a:	e8 61 07 00 00       	call   ca0 <printf>
        return -1;
 53f:	83 c4 10             	add    $0x10,%esp
 542:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 547:	8d 65 f8             	lea    -0x8(%ebp),%esp
 54a:	5b                   	pop    %ebx
 54b:	5e                   	pop    %esi
 54c:	5d                   	pop    %ebp
 54d:	c3                   	ret    
 54e:	66 90                	xchg   %ax,%ax
    printf(1,"5  free pages: %d\n",getNumberOfFreePages());
 550:	e8 8d 06 00 00       	call   be2 <getNumberOfFreePages>
 555:	83 ec 04             	sub    $0x4,%esp
 558:	50                   	push   %eax
 559:	68 d8 10 00 00       	push   $0x10d8
 55e:	6a 01                	push   $0x1
 560:	e8 3b 07 00 00       	call   ca0 <printf>
    if(freePages != getNumberOfFreePages()+16){
 565:	e8 78 06 00 00       	call   be2 <getNumberOfFreePages>
 56a:	8d 50 10             	lea    0x10(%eax),%edx
 56d:	83 c4 10             	add    $0x10,%esp
  return 0;
 570:	31 c0                	xor    %eax,%eax
    if(freePages != getNumberOfFreePages()+16){
 572:	39 f2                	cmp    %esi,%edx
 574:	74 d1                	je     547 <cowSwapFile_maxPhyInChildTest+0xe7>
      printf(1," FAILED 4(Free Memory error)\n");
 576:	83 ec 08             	sub    $0x8,%esp
 579:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 57c:	68 eb 10 00 00       	push   $0x10eb
 581:	6a 01                	push   $0x1
 583:	e8 18 07 00 00       	call   ca0 <printf>
 588:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 58b:	83 c4 10             	add    $0x10,%esp
}
 58e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 591:	5b                   	pop    %ebx
 592:	5e                   	pop    %esi
 593:	5d                   	pop    %ebp
 594:	c3                   	ret    
    printf(1,"2  free pages: %d\n",getNumberOfFreePages());
 595:	e8 48 06 00 00       	call   be2 <getNumberOfFreePages>
 59a:	52                   	push   %edx
 59b:	50                   	push   %eax
 59c:	68 81 10 00 00       	push   $0x1081
 5a1:	6a 01                	push   $0x1
 5a3:	e8 f8 06 00 00       	call   ca0 <printf>
    if(freePages != getNumberOfFreePages()+84){
 5a8:	e8 35 06 00 00       	call   be2 <getNumberOfFreePages>
 5ad:	83 c0 54             	add    $0x54,%eax
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	39 f0                	cmp    %esi,%eax
 5b5:	74 11                	je     5c8 <cowSwapFile_maxPhyInChildTest+0x168>
    printf(1," FAILED 2(Free Memory error)\n");
 5b7:	50                   	push   %eax
 5b8:	50                   	push   %eax
 5b9:	68 94 10 00 00       	push   $0x1094
 5be:	6a 01                	push   $0x1
 5c0:	e8 db 06 00 00       	call   ca0 <printf>
 5c5:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++){
 5c8:	b8 32 00 00 00       	mov    $0x32,%eax
      *lst[i]= i + 50;
 5cd:	8b 94 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%edx
 5d4:	89 02                	mov    %eax,(%edx)
 5d6:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < 20; i++){
 5d9:	83 f8 46             	cmp    $0x46,%eax
 5dc:	75 ef                	jne    5cd <cowSwapFile_maxPhyInChildTest+0x16d>
    if(freePages != getNumberOfFreePages()+100){
 5de:	e8 ff 05 00 00       	call   be2 <getNumberOfFreePages>
 5e3:	83 c0 64             	add    $0x64,%eax
 5e6:	39 f0                	cmp    %esi,%eax
 5e8:	74 16                	je     600 <cowSwapFile_maxPhyInChildTest+0x1a0>
      printf(1," FAILED 3(Free Memory error)%d\n",getNumberOfFreePages());
 5ea:	e8 f3 05 00 00       	call   be2 <getNumberOfFreePages>
 5ef:	53                   	push   %ebx
 5f0:	50                   	push   %eax
 5f1:	68 28 12 00 00       	push   $0x1228
 5f6:	6a 01                	push   $0x1
 5f8:	e8 a3 06 00 00       	call   ca0 <printf>
 5fd:	83 c4 10             	add    $0x10,%esp
    printf(1,"3  free pages: %d\n",getNumberOfFreePages());
 600:	e8 dd 05 00 00       	call   be2 <getNumberOfFreePages>
 605:	51                   	push   %ecx
 606:	50                   	push   %eax
 607:	68 b2 10 00 00       	push   $0x10b2
 60c:	6a 01                	push   $0x1
 60e:	e8 8d 06 00 00       	call   ca0 <printf>
    exit();
 613:	e8 2a 05 00 00       	call   b42 <exit>
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	53                   	push   %ebx
 624:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_killedChiledTest :");
 627:	68 48 12 00 00       	push   $0x1248
 62c:	6a 01                	push   $0x1
 62e:	e8 6d 06 00 00       	call   ca0 <printf>
  for(i = 0; i < 20; i++){
 633:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 63a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 63d:	83 c4 10             	add    $0x10,%esp
 640:	83 f8 13             	cmp    $0x13,%eax
 643:	7f 37                	jg     67c <cowSwapFile_killedChiledTest+0x5c>
 645:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 648:	83 ec 0c             	sub    $0xc,%esp
 64b:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 64e:	68 00 10 00 00       	push   $0x1000
 653:	e8 72 05 00 00       	call   bca <sbrk>
 658:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 65c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 65f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 662:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 665:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 669:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 66b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 66e:	83 c0 01             	add    $0x1,%eax
 671:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 674:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 677:	83 f8 13             	cmp    $0x13,%eax
 67a:	7e cc                	jle    648 <cowSwapFile_killedChiledTest+0x28>
  int pid = fork();
 67c:	e8 b9 04 00 00       	call   b3a <fork>
  if(pid==0){
 681:	85 c0                	test   %eax,%eax
 683:	0f 85 c7 00 00 00    	jne    750 <cowSwapFile_killedChiledTest+0x130>
    for(i = 0; i < 20; i++){
 689:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 690:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 693:	83 f8 13             	cmp    $0x13,%eax
 696:	7e 19                	jle    6b1 <cowSwapFile_killedChiledTest+0x91>
 698:	eb 66                	jmp    700 <cowSwapFile_killedChiledTest+0xe0>
 69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6a0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6a3:	83 c0 01             	add    $0x1,%eax
 6a6:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 6a9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6ac:	83 f8 13             	cmp    $0x13,%eax
 6af:	7f 4f                	jg     700 <cowSwapFile_killedChiledTest+0xe0>
      if(*lst[i]!=i){
 6b1:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 6b4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6b7:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 6bb:	39 02                	cmp    %eax,(%edx)
 6bd:	74 e1                	je     6a0 <cowSwapFile_killedChiledTest+0x80>
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
 6bf:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 6c2:	83 ec 04             	sub    $0x4,%esp
 6c5:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6c8:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 6cc:	39 02                	cmp    %eax,(%edx)
 6ce:	0f 95 c0             	setne  %al
 6d1:	0f b6 c0             	movzbl %al,%eax
 6d4:	50                   	push   %eax
 6d5:	68 47 10 00 00       	push   $0x1047
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 6da:	6a 01                	push   $0x1
 6dc:	e8 bf 05 00 00       	call   ca0 <printf>
        printf(1," FAILED");
 6e1:	58                   	pop    %eax
 6e2:	5a                   	pop    %edx
 6e3:	68 27 10 00 00       	push   $0x1027
 6e8:	6a 01                	push   $0x1
 6ea:	e8 b1 05 00 00       	call   ca0 <printf>
        return -1;
 6ef:	83 c4 10             	add    $0x10,%esp
 6f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 6f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6fa:	c9                   	leave  
 6fb:	c3                   	ret    
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 20; i++){
 700:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 707:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 70a:	83 f8 13             	cmp    $0x13,%eax
 70d:	7e 1a                	jle    729 <cowSwapFile_killedChiledTest+0x109>
 70f:	eb 76                	jmp    787 <cowSwapFile_killedChiledTest+0x167>
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 71b:	83 c0 01             	add    $0x1,%eax
 71e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 721:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 724:	83 f8 13             	cmp    $0x13,%eax
 727:	7f 5e                	jg     787 <cowSwapFile_killedChiledTest+0x167>
      *lst[i] = 66;
 729:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 72c:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 730:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(*lst[i]!=66){
 736:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 739:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 73d:	83 38 42             	cmpl   $0x42,(%eax)
 740:	74 d6                	je     718 <cowSwapFile_killedChiledTest+0xf8>
 742:	e9 78 ff ff ff       	jmp    6bf <cowSwapFile_killedChiledTest+0x9f>
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 750:	e8 f5 03 00 00       	call   b4a <wait>
  for(j = 0; j < 20; j++){
 755:	31 c0                	xor    %eax,%eax
 757:	eb 0f                	jmp    768 <cowSwapFile_killedChiledTest+0x148>
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 760:	83 c0 01             	add    $0x1,%eax
 763:	83 f8 14             	cmp    $0x14,%eax
 766:	74 18                	je     780 <cowSwapFile_killedChiledTest+0x160>
      if(*lst[j]!=j){
 768:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 76c:	39 02                	cmp    %eax,(%edx)
 76e:	74 f0                	je     760 <cowSwapFile_killedChiledTest+0x140>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 770:	83 ec 04             	sub    $0x4,%esp
 773:	6a 01                	push   $0x1
 775:	68 5a 10 00 00       	push   $0x105a
 77a:	e9 5b ff ff ff       	jmp    6da <cowSwapFile_killedChiledTest+0xba>
 77f:	90                   	nop
  return 0;
 780:	31 c0                	xor    %eax,%eax
}
 782:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 785:	c9                   	leave  
 786:	c3                   	ret    
    exit();
 787:	e8 b6 03 00 00       	call   b42 <exit>
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000790 <PhysicalMemTest>:
PhysicalMemTest(){
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	53                   	push   %ebx
 794:	83 ec 2c             	sub    $0x2c,%esp
  printf(1,"PhysicalMemTest :");
 797:	68 09 11 00 00       	push   $0x1109
 79c:	6a 01                	push   $0x1
 79e:	e8 fd 04 00 00       	call   ca0 <printf>
  for(i = 0; i < 5; i++){
 7a3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 7aa:	8b 45 e0             	mov    -0x20(%ebp),%eax
 7ad:	83 c4 10             	add    $0x10,%esp
 7b0:	83 f8 04             	cmp    $0x4,%eax
 7b3:	7f 37                	jg     7ec <PhysicalMemTest+0x5c>
 7b5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 7b8:	83 ec 0c             	sub    $0xc,%esp
 7bb:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 7be:	68 00 10 00 00       	push   $0x1000
 7c3:	e8 02 04 00 00       	call   bca <sbrk>
 7c8:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
    *lst[i]=i;
 7cc:	8b 45 e0             	mov    -0x20(%ebp),%eax
  for(i = 0; i < 5; i++){
 7cf:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 7d2:	8b 55 e0             	mov    -0x20(%ebp),%edx
 7d5:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
 7d9:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 5; i++){
 7db:	8b 45 e0             	mov    -0x20(%ebp),%eax
 7de:	83 c0 01             	add    $0x1,%eax
 7e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
 7e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
 7e7:	83 f8 04             	cmp    $0x4,%eax
 7ea:	7e cc                	jle    7b8 <PhysicalMemTest+0x28>
  for(i = 0; i < 5; i++){
 7ec:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 7f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
 7f6:	83 f8 04             	cmp    $0x4,%eax
 7f9:	7e 16                	jle    811 <PhysicalMemTest+0x81>
 7fb:	eb 43                	jmp    840 <PhysicalMemTest+0xb0>
 7fd:	8d 76 00             	lea    0x0(%esi),%esi
 800:	8b 45 e0             	mov    -0x20(%ebp),%eax
 803:	83 c0 01             	add    $0x1,%eax
 806:	89 45 e0             	mov    %eax,-0x20(%ebp)
 809:	8b 45 e0             	mov    -0x20(%ebp),%eax
 80c:	83 f8 04             	cmp    $0x4,%eax
 80f:	7f 2f                	jg     840 <PhysicalMemTest+0xb0>
    if(*lst[i]!=i){
 811:	8b 55 e0             	mov    -0x20(%ebp),%edx
 814:	8b 45 e0             	mov    -0x20(%ebp),%eax
 817:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
 81b:	39 02                	cmp    %eax,(%edx)
 81d:	74 e1                	je     800 <PhysicalMemTest+0x70>
      printf(1," FAILED");
 81f:	83 ec 08             	sub    $0x8,%esp
 822:	68 27 10 00 00       	push   $0x1027
 827:	6a 01                	push   $0x1
 829:	e8 72 04 00 00       	call   ca0 <printf>
 82e:	83 c4 10             	add    $0x10,%esp
 831:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 836:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 839:	c9                   	leave  
 83a:	c3                   	ret    
 83b:	90                   	nop
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 840:	31 c0                	xor    %eax,%eax
}
 842:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 845:	c9                   	leave  
 846:	c3                   	ret    
 847:	89 f6                	mov    %esi,%esi
 849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000850 <memLeakTest>:
memLeakTest(int freeMem){
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	53                   	push   %ebx
 854:	83 ec 0c             	sub    $0xc,%esp
 857:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(1,"memLeakTest :");
 85a:	68 1b 11 00 00       	push   $0x111b
 85f:	6a 01                	push   $0x1
 861:	e8 3a 04 00 00       	call   ca0 <printf>
  if(freeMem != getNumberOfFreePages()){
 866:	e8 77 03 00 00       	call   be2 <getNumberOfFreePages>
 86b:	83 c4 10             	add    $0x10,%esp
 86e:	39 d8                	cmp    %ebx,%eax
 870:	74 1e                	je     890 <memLeakTest+0x40>
      printf(1, "FAILED    expected: %d     got : %d\n",freeMem,getNumberOfFreePages());
 872:	e8 6b 03 00 00       	call   be2 <getNumberOfFreePages>
 877:	50                   	push   %eax
 878:	53                   	push   %ebx
 879:	68 68 12 00 00       	push   $0x1268
 87e:	6a 01                	push   $0x1
 880:	e8 1b 04 00 00       	call   ca0 <printf>
 885:	83 c4 10             	add    $0x10,%esp
}
 888:	31 c0                	xor    %eax,%eax
 88a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 88d:	c9                   	leave  
 88e:	c3                   	ret    
 88f:	90                   	nop
    printf(1, "PASSED\n");
 890:	83 ec 08             	sub    $0x8,%esp
 893:	68 2a 11 00 00       	push   $0x112a
 898:	6a 01                	push   $0x1
 89a:	e8 01 04 00 00       	call   ca0 <printf>
 89f:	83 c4 10             	add    $0x10,%esp
}
 8a2:	31 c0                	xor    %eax,%eax
 8a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8a7:	c9                   	leave  
 8a8:	c3                   	ret    
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008b0 <makeTest>:
makeTest(int (*test)()){
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	53                   	push   %ebx
 8b4:	83 ec 04             	sub    $0x4,%esp
 8b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int testerPid = fork();
 8ba:	e8 7b 02 00 00       	call   b3a <fork>
  if(testerPid==0){
 8bf:	85 c0                	test   %eax,%eax
 8c1:	74 09                	je     8cc <makeTest+0x1c>
} 
 8c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 8c6:	c9                   	leave  
  wait();
 8c7:	e9 7e 02 00 00       	jmp    b4a <wait>
    if(test()==0){
 8cc:	ff d3                	call   *%ebx
 8ce:	85 c0                	test   %eax,%eax
 8d0:	74 05                	je     8d7 <makeTest+0x27>
    exit();
 8d2:	e8 6b 02 00 00       	call   b42 <exit>
      printf(1," PASSED\n");
 8d7:	50                   	push   %eax
 8d8:	50                   	push   %eax
 8d9:	68 29 11 00 00       	push   $0x1129
 8de:	6a 01                	push   $0x1
 8e0:	e8 bb 03 00 00       	call   ca0 <printf>
 8e5:	83 c4 10             	add    $0x10,%esp
 8e8:	eb e8                	jmp    8d2 <makeTest+0x22>
 8ea:	66 90                	xchg   %ax,%ax
 8ec:	66 90                	xchg   %ax,%ax
 8ee:	66 90                	xchg   %ax,%ax

000008f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	53                   	push   %ebx
 8f4:	8b 45 08             	mov    0x8(%ebp),%eax
 8f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 8fa:	89 c2                	mov    %eax,%edx
 8fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 900:	83 c1 01             	add    $0x1,%ecx
 903:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 907:	83 c2 01             	add    $0x1,%edx
 90a:	84 db                	test   %bl,%bl
 90c:	88 5a ff             	mov    %bl,-0x1(%edx)
 90f:	75 ef                	jne    900 <strcpy+0x10>
    ;
  return os;
}
 911:	5b                   	pop    %ebx
 912:	5d                   	pop    %ebp
 913:	c3                   	ret    
 914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 91a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000920 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	53                   	push   %ebx
 924:	8b 55 08             	mov    0x8(%ebp),%edx
 927:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 92a:	0f b6 02             	movzbl (%edx),%eax
 92d:	0f b6 19             	movzbl (%ecx),%ebx
 930:	84 c0                	test   %al,%al
 932:	75 1c                	jne    950 <strcmp+0x30>
 934:	eb 2a                	jmp    960 <strcmp+0x40>
 936:	8d 76 00             	lea    0x0(%esi),%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 940:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 943:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 946:	83 c1 01             	add    $0x1,%ecx
 949:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 94c:	84 c0                	test   %al,%al
 94e:	74 10                	je     960 <strcmp+0x40>
 950:	38 d8                	cmp    %bl,%al
 952:	74 ec                	je     940 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 954:	29 d8                	sub    %ebx,%eax
}
 956:	5b                   	pop    %ebx
 957:	5d                   	pop    %ebp
 958:	c3                   	ret    
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 960:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 962:	29 d8                	sub    %ebx,%eax
}
 964:	5b                   	pop    %ebx
 965:	5d                   	pop    %ebp
 966:	c3                   	ret    
 967:	89 f6                	mov    %esi,%esi
 969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000970 <strlen>:

uint
strlen(const char *s)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 976:	80 39 00             	cmpb   $0x0,(%ecx)
 979:	74 15                	je     990 <strlen+0x20>
 97b:	31 d2                	xor    %edx,%edx
 97d:	8d 76 00             	lea    0x0(%esi),%esi
 980:	83 c2 01             	add    $0x1,%edx
 983:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 987:	89 d0                	mov    %edx,%eax
 989:	75 f5                	jne    980 <strlen+0x10>
    ;
  return n;
}
 98b:	5d                   	pop    %ebp
 98c:	c3                   	ret    
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 990:	31 c0                	xor    %eax,%eax
}
 992:	5d                   	pop    %ebp
 993:	c3                   	ret    
 994:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 99a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000009a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	57                   	push   %edi
 9a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 9a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 9aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 9ad:	89 d7                	mov    %edx,%edi
 9af:	fc                   	cld    
 9b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 9b2:	89 d0                	mov    %edx,%eax
 9b4:	5f                   	pop    %edi
 9b5:	5d                   	pop    %ebp
 9b6:	c3                   	ret    
 9b7:	89 f6                	mov    %esi,%esi
 9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <strchr>:

char*
strchr(const char *s, char c)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	53                   	push   %ebx
 9c4:	8b 45 08             	mov    0x8(%ebp),%eax
 9c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 9ca:	0f b6 10             	movzbl (%eax),%edx
 9cd:	84 d2                	test   %dl,%dl
 9cf:	74 1d                	je     9ee <strchr+0x2e>
    if(*s == c)
 9d1:	38 d3                	cmp    %dl,%bl
 9d3:	89 d9                	mov    %ebx,%ecx
 9d5:	75 0d                	jne    9e4 <strchr+0x24>
 9d7:	eb 17                	jmp    9f0 <strchr+0x30>
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9e0:	38 ca                	cmp    %cl,%dl
 9e2:	74 0c                	je     9f0 <strchr+0x30>
  for(; *s; s++)
 9e4:	83 c0 01             	add    $0x1,%eax
 9e7:	0f b6 10             	movzbl (%eax),%edx
 9ea:	84 d2                	test   %dl,%dl
 9ec:	75 f2                	jne    9e0 <strchr+0x20>
      return (char*)s;
  return 0;
 9ee:	31 c0                	xor    %eax,%eax
}
 9f0:	5b                   	pop    %ebx
 9f1:	5d                   	pop    %ebp
 9f2:	c3                   	ret    
 9f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <gets>:

char*
gets(char *buf, int max)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	57                   	push   %edi
 a04:	56                   	push   %esi
 a05:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 a06:	31 f6                	xor    %esi,%esi
 a08:	89 f3                	mov    %esi,%ebx
{
 a0a:	83 ec 1c             	sub    $0x1c,%esp
 a0d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 a10:	eb 2f                	jmp    a41 <gets+0x41>
 a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 a18:	8d 45 e7             	lea    -0x19(%ebp),%eax
 a1b:	83 ec 04             	sub    $0x4,%esp
 a1e:	6a 01                	push   $0x1
 a20:	50                   	push   %eax
 a21:	6a 00                	push   $0x0
 a23:	e8 32 01 00 00       	call   b5a <read>
    if(cc < 1)
 a28:	83 c4 10             	add    $0x10,%esp
 a2b:	85 c0                	test   %eax,%eax
 a2d:	7e 1c                	jle    a4b <gets+0x4b>
      break;
    buf[i++] = c;
 a2f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 a33:	83 c7 01             	add    $0x1,%edi
 a36:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 a39:	3c 0a                	cmp    $0xa,%al
 a3b:	74 23                	je     a60 <gets+0x60>
 a3d:	3c 0d                	cmp    $0xd,%al
 a3f:	74 1f                	je     a60 <gets+0x60>
  for(i=0; i+1 < max; ){
 a41:	83 c3 01             	add    $0x1,%ebx
 a44:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 a47:	89 fe                	mov    %edi,%esi
 a49:	7c cd                	jl     a18 <gets+0x18>
 a4b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 a4d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 a50:	c6 03 00             	movb   $0x0,(%ebx)
}
 a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a56:	5b                   	pop    %ebx
 a57:	5e                   	pop    %esi
 a58:	5f                   	pop    %edi
 a59:	5d                   	pop    %ebp
 a5a:	c3                   	ret    
 a5b:	90                   	nop
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a60:	8b 75 08             	mov    0x8(%ebp),%esi
 a63:	8b 45 08             	mov    0x8(%ebp),%eax
 a66:	01 de                	add    %ebx,%esi
 a68:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 a6a:	c6 03 00             	movb   $0x0,(%ebx)
}
 a6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a70:	5b                   	pop    %ebx
 a71:	5e                   	pop    %esi
 a72:	5f                   	pop    %edi
 a73:	5d                   	pop    %ebp
 a74:	c3                   	ret    
 a75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a80 <stat>:

int
stat(const char *n, struct stat *st)
{
 a80:	55                   	push   %ebp
 a81:	89 e5                	mov    %esp,%ebp
 a83:	56                   	push   %esi
 a84:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a85:	83 ec 08             	sub    $0x8,%esp
 a88:	6a 00                	push   $0x0
 a8a:	ff 75 08             	pushl  0x8(%ebp)
 a8d:	e8 f0 00 00 00       	call   b82 <open>
  if(fd < 0)
 a92:	83 c4 10             	add    $0x10,%esp
 a95:	85 c0                	test   %eax,%eax
 a97:	78 27                	js     ac0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 a99:	83 ec 08             	sub    $0x8,%esp
 a9c:	ff 75 0c             	pushl  0xc(%ebp)
 a9f:	89 c3                	mov    %eax,%ebx
 aa1:	50                   	push   %eax
 aa2:	e8 f3 00 00 00       	call   b9a <fstat>
  close(fd);
 aa7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 aaa:	89 c6                	mov    %eax,%esi
  close(fd);
 aac:	e8 b9 00 00 00       	call   b6a <close>
  return r;
 ab1:	83 c4 10             	add    $0x10,%esp
}
 ab4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 ab7:	89 f0                	mov    %esi,%eax
 ab9:	5b                   	pop    %ebx
 aba:	5e                   	pop    %esi
 abb:	5d                   	pop    %ebp
 abc:	c3                   	ret    
 abd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 ac0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 ac5:	eb ed                	jmp    ab4 <stat+0x34>
 ac7:	89 f6                	mov    %esi,%esi
 ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <atoi>:

int
atoi(const char *s)
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	53                   	push   %ebx
 ad4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 ad7:	0f be 11             	movsbl (%ecx),%edx
 ada:	8d 42 d0             	lea    -0x30(%edx),%eax
 add:	3c 09                	cmp    $0x9,%al
  n = 0;
 adf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 ae4:	77 1f                	ja     b05 <atoi+0x35>
 ae6:	8d 76 00             	lea    0x0(%esi),%esi
 ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 af0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 af3:	83 c1 01             	add    $0x1,%ecx
 af6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 afa:	0f be 11             	movsbl (%ecx),%edx
 afd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 b00:	80 fb 09             	cmp    $0x9,%bl
 b03:	76 eb                	jbe    af0 <atoi+0x20>
  return n;
}
 b05:	5b                   	pop    %ebx
 b06:	5d                   	pop    %ebp
 b07:	c3                   	ret    
 b08:	90                   	nop
 b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000b10 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 b10:	55                   	push   %ebp
 b11:	89 e5                	mov    %esp,%ebp
 b13:	56                   	push   %esi
 b14:	53                   	push   %ebx
 b15:	8b 5d 10             	mov    0x10(%ebp),%ebx
 b18:	8b 45 08             	mov    0x8(%ebp),%eax
 b1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 b1e:	85 db                	test   %ebx,%ebx
 b20:	7e 14                	jle    b36 <memmove+0x26>
 b22:	31 d2                	xor    %edx,%edx
 b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 b28:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 b2c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 b2f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 b32:	39 d3                	cmp    %edx,%ebx
 b34:	75 f2                	jne    b28 <memmove+0x18>
  return vdst;
}
 b36:	5b                   	pop    %ebx
 b37:	5e                   	pop    %esi
 b38:	5d                   	pop    %ebp
 b39:	c3                   	ret    

00000b3a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 b3a:	b8 01 00 00 00       	mov    $0x1,%eax
 b3f:	cd 40                	int    $0x40
 b41:	c3                   	ret    

00000b42 <exit>:
SYSCALL(exit)
 b42:	b8 02 00 00 00       	mov    $0x2,%eax
 b47:	cd 40                	int    $0x40
 b49:	c3                   	ret    

00000b4a <wait>:
SYSCALL(wait)
 b4a:	b8 03 00 00 00       	mov    $0x3,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <pipe>:
SYSCALL(pipe)
 b52:	b8 04 00 00 00       	mov    $0x4,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <read>:
SYSCALL(read)
 b5a:	b8 05 00 00 00       	mov    $0x5,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <write>:
SYSCALL(write)
 b62:	b8 10 00 00 00       	mov    $0x10,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <close>:
SYSCALL(close)
 b6a:	b8 15 00 00 00       	mov    $0x15,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    

00000b72 <kill>:
SYSCALL(kill)
 b72:	b8 06 00 00 00       	mov    $0x6,%eax
 b77:	cd 40                	int    $0x40
 b79:	c3                   	ret    

00000b7a <exec>:
SYSCALL(exec)
 b7a:	b8 07 00 00 00       	mov    $0x7,%eax
 b7f:	cd 40                	int    $0x40
 b81:	c3                   	ret    

00000b82 <open>:
SYSCALL(open)
 b82:	b8 0f 00 00 00       	mov    $0xf,%eax
 b87:	cd 40                	int    $0x40
 b89:	c3                   	ret    

00000b8a <mknod>:
SYSCALL(mknod)
 b8a:	b8 11 00 00 00       	mov    $0x11,%eax
 b8f:	cd 40                	int    $0x40
 b91:	c3                   	ret    

00000b92 <unlink>:
SYSCALL(unlink)
 b92:	b8 12 00 00 00       	mov    $0x12,%eax
 b97:	cd 40                	int    $0x40
 b99:	c3                   	ret    

00000b9a <fstat>:
SYSCALL(fstat)
 b9a:	b8 08 00 00 00       	mov    $0x8,%eax
 b9f:	cd 40                	int    $0x40
 ba1:	c3                   	ret    

00000ba2 <link>:
SYSCALL(link)
 ba2:	b8 13 00 00 00       	mov    $0x13,%eax
 ba7:	cd 40                	int    $0x40
 ba9:	c3                   	ret    

00000baa <mkdir>:
SYSCALL(mkdir)
 baa:	b8 14 00 00 00       	mov    $0x14,%eax
 baf:	cd 40                	int    $0x40
 bb1:	c3                   	ret    

00000bb2 <chdir>:
SYSCALL(chdir)
 bb2:	b8 09 00 00 00       	mov    $0x9,%eax
 bb7:	cd 40                	int    $0x40
 bb9:	c3                   	ret    

00000bba <dup>:
SYSCALL(dup)
 bba:	b8 0a 00 00 00       	mov    $0xa,%eax
 bbf:	cd 40                	int    $0x40
 bc1:	c3                   	ret    

00000bc2 <getpid>:
SYSCALL(getpid)
 bc2:	b8 0b 00 00 00       	mov    $0xb,%eax
 bc7:	cd 40                	int    $0x40
 bc9:	c3                   	ret    

00000bca <sbrk>:
SYSCALL(sbrk)
 bca:	b8 0c 00 00 00       	mov    $0xc,%eax
 bcf:	cd 40                	int    $0x40
 bd1:	c3                   	ret    

00000bd2 <sleep>:
SYSCALL(sleep)
 bd2:	b8 0d 00 00 00       	mov    $0xd,%eax
 bd7:	cd 40                	int    $0x40
 bd9:	c3                   	ret    

00000bda <uptime>:
SYSCALL(uptime)
 bda:	b8 0e 00 00 00       	mov    $0xe,%eax
 bdf:	cd 40                	int    $0x40
 be1:	c3                   	ret    

00000be2 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
 be2:	b8 16 00 00 00       	mov    $0x16,%eax
 be7:	cd 40                	int    $0x40
 be9:	c3                   	ret    

00000bea <printProcDump>:
SYSCALL(printProcDump)
 bea:	b8 17 00 00 00       	mov    $0x17,%eax
 bef:	cd 40                	int    $0x40
 bf1:	c3                   	ret    
 bf2:	66 90                	xchg   %ax,%ax
 bf4:	66 90                	xchg   %ax,%ax
 bf6:	66 90                	xchg   %ax,%ax
 bf8:	66 90                	xchg   %ax,%ax
 bfa:	66 90                	xchg   %ax,%ax
 bfc:	66 90                	xchg   %ax,%ax
 bfe:	66 90                	xchg   %ax,%ax

00000c00 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 c00:	55                   	push   %ebp
 c01:	89 e5                	mov    %esp,%ebp
 c03:	57                   	push   %edi
 c04:	56                   	push   %esi
 c05:	53                   	push   %ebx
 c06:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 c09:	85 d2                	test   %edx,%edx
{
 c0b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 c0e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 c10:	79 76                	jns    c88 <printint+0x88>
 c12:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 c16:	74 70                	je     c88 <printint+0x88>
    x = -xx;
 c18:	f7 d8                	neg    %eax
    neg = 1;
 c1a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 c21:	31 f6                	xor    %esi,%esi
 c23:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 c26:	eb 0a                	jmp    c32 <printint+0x32>
 c28:	90                   	nop
 c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 c30:	89 fe                	mov    %edi,%esi
 c32:	31 d2                	xor    %edx,%edx
 c34:	8d 7e 01             	lea    0x1(%esi),%edi
 c37:	f7 f1                	div    %ecx
 c39:	0f b6 92 98 12 00 00 	movzbl 0x1298(%edx),%edx
  }while((x /= base) != 0);
 c40:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 c42:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 c45:	75 e9                	jne    c30 <printint+0x30>
  if(neg)
 c47:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 c4a:	85 c0                	test   %eax,%eax
 c4c:	74 08                	je     c56 <printint+0x56>
    buf[i++] = '-';
 c4e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 c53:	8d 7e 02             	lea    0x2(%esi),%edi
 c56:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 c5a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 c5d:	8d 76 00             	lea    0x0(%esi),%esi
 c60:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 c63:	83 ec 04             	sub    $0x4,%esp
 c66:	83 ee 01             	sub    $0x1,%esi
 c69:	6a 01                	push   $0x1
 c6b:	53                   	push   %ebx
 c6c:	57                   	push   %edi
 c6d:	88 45 d7             	mov    %al,-0x29(%ebp)
 c70:	e8 ed fe ff ff       	call   b62 <write>

  while(--i >= 0)
 c75:	83 c4 10             	add    $0x10,%esp
 c78:	39 de                	cmp    %ebx,%esi
 c7a:	75 e4                	jne    c60 <printint+0x60>
    putc(fd, buf[i]);
}
 c7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c7f:	5b                   	pop    %ebx
 c80:	5e                   	pop    %esi
 c81:	5f                   	pop    %edi
 c82:	5d                   	pop    %ebp
 c83:	c3                   	ret    
 c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c88:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c8f:	eb 90                	jmp    c21 <printint+0x21>
 c91:	eb 0d                	jmp    ca0 <printf>
 c93:	90                   	nop
 c94:	90                   	nop
 c95:	90                   	nop
 c96:	90                   	nop
 c97:	90                   	nop
 c98:	90                   	nop
 c99:	90                   	nop
 c9a:	90                   	nop
 c9b:	90                   	nop
 c9c:	90                   	nop
 c9d:	90                   	nop
 c9e:	90                   	nop
 c9f:	90                   	nop

00000ca0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 ca0:	55                   	push   %ebp
 ca1:	89 e5                	mov    %esp,%ebp
 ca3:	57                   	push   %edi
 ca4:	56                   	push   %esi
 ca5:	53                   	push   %ebx
 ca6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ca9:	8b 75 0c             	mov    0xc(%ebp),%esi
 cac:	0f b6 1e             	movzbl (%esi),%ebx
 caf:	84 db                	test   %bl,%bl
 cb1:	0f 84 b3 00 00 00    	je     d6a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 cb7:	8d 45 10             	lea    0x10(%ebp),%eax
 cba:	83 c6 01             	add    $0x1,%esi
  state = 0;
 cbd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 cbf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 cc2:	eb 2f                	jmp    cf3 <printf+0x53>
 cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 cc8:	83 f8 25             	cmp    $0x25,%eax
 ccb:	0f 84 a7 00 00 00    	je     d78 <printf+0xd8>
  write(fd, &c, 1);
 cd1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 cd4:	83 ec 04             	sub    $0x4,%esp
 cd7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 cda:	6a 01                	push   $0x1
 cdc:	50                   	push   %eax
 cdd:	ff 75 08             	pushl  0x8(%ebp)
 ce0:	e8 7d fe ff ff       	call   b62 <write>
 ce5:	83 c4 10             	add    $0x10,%esp
 ce8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 ceb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 cef:	84 db                	test   %bl,%bl
 cf1:	74 77                	je     d6a <printf+0xca>
    if(state == 0){
 cf3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 cf5:	0f be cb             	movsbl %bl,%ecx
 cf8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 cfb:	74 cb                	je     cc8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 cfd:	83 ff 25             	cmp    $0x25,%edi
 d00:	75 e6                	jne    ce8 <printf+0x48>
      if(c == 'd'){
 d02:	83 f8 64             	cmp    $0x64,%eax
 d05:	0f 84 05 01 00 00    	je     e10 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 d0b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 d11:	83 f9 70             	cmp    $0x70,%ecx
 d14:	74 72                	je     d88 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 d16:	83 f8 73             	cmp    $0x73,%eax
 d19:	0f 84 99 00 00 00    	je     db8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 d1f:	83 f8 63             	cmp    $0x63,%eax
 d22:	0f 84 08 01 00 00    	je     e30 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 d28:	83 f8 25             	cmp    $0x25,%eax
 d2b:	0f 84 ef 00 00 00    	je     e20 <printf+0x180>
  write(fd, &c, 1);
 d31:	8d 45 e7             	lea    -0x19(%ebp),%eax
 d34:	83 ec 04             	sub    $0x4,%esp
 d37:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 d3b:	6a 01                	push   $0x1
 d3d:	50                   	push   %eax
 d3e:	ff 75 08             	pushl  0x8(%ebp)
 d41:	e8 1c fe ff ff       	call   b62 <write>
 d46:	83 c4 0c             	add    $0xc,%esp
 d49:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 d4c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 d4f:	6a 01                	push   $0x1
 d51:	50                   	push   %eax
 d52:	ff 75 08             	pushl  0x8(%ebp)
 d55:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 d58:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 d5a:	e8 03 fe ff ff       	call   b62 <write>
  for(i = 0; fmt[i]; i++){
 d5f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 d63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 d66:	84 db                	test   %bl,%bl
 d68:	75 89                	jne    cf3 <printf+0x53>
    }
  }
}
 d6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 d6d:	5b                   	pop    %ebx
 d6e:	5e                   	pop    %esi
 d6f:	5f                   	pop    %edi
 d70:	5d                   	pop    %ebp
 d71:	c3                   	ret    
 d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 d78:	bf 25 00 00 00       	mov    $0x25,%edi
 d7d:	e9 66 ff ff ff       	jmp    ce8 <printf+0x48>
 d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 d88:	83 ec 0c             	sub    $0xc,%esp
 d8b:	b9 10 00 00 00       	mov    $0x10,%ecx
 d90:	6a 00                	push   $0x0
 d92:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 d95:	8b 45 08             	mov    0x8(%ebp),%eax
 d98:	8b 17                	mov    (%edi),%edx
 d9a:	e8 61 fe ff ff       	call   c00 <printint>
        ap++;
 d9f:	89 f8                	mov    %edi,%eax
 da1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 da4:	31 ff                	xor    %edi,%edi
        ap++;
 da6:	83 c0 04             	add    $0x4,%eax
 da9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 dac:	e9 37 ff ff ff       	jmp    ce8 <printf+0x48>
 db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 db8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 dbb:	8b 08                	mov    (%eax),%ecx
        ap++;
 dbd:	83 c0 04             	add    $0x4,%eax
 dc0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 dc3:	85 c9                	test   %ecx,%ecx
 dc5:	0f 84 8e 00 00 00    	je     e59 <printf+0x1b9>
        while(*s != 0){
 dcb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 dce:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 dd0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 dd2:	84 c0                	test   %al,%al
 dd4:	0f 84 0e ff ff ff    	je     ce8 <printf+0x48>
 dda:	89 75 d0             	mov    %esi,-0x30(%ebp)
 ddd:	89 de                	mov    %ebx,%esi
 ddf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 de2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 de5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 de8:	83 ec 04             	sub    $0x4,%esp
          s++;
 deb:	83 c6 01             	add    $0x1,%esi
 dee:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 df1:	6a 01                	push   $0x1
 df3:	57                   	push   %edi
 df4:	53                   	push   %ebx
 df5:	e8 68 fd ff ff       	call   b62 <write>
        while(*s != 0){
 dfa:	0f b6 06             	movzbl (%esi),%eax
 dfd:	83 c4 10             	add    $0x10,%esp
 e00:	84 c0                	test   %al,%al
 e02:	75 e4                	jne    de8 <printf+0x148>
 e04:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 e07:	31 ff                	xor    %edi,%edi
 e09:	e9 da fe ff ff       	jmp    ce8 <printf+0x48>
 e0e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 e10:	83 ec 0c             	sub    $0xc,%esp
 e13:	b9 0a 00 00 00       	mov    $0xa,%ecx
 e18:	6a 01                	push   $0x1
 e1a:	e9 73 ff ff ff       	jmp    d92 <printf+0xf2>
 e1f:	90                   	nop
  write(fd, &c, 1);
 e20:	83 ec 04             	sub    $0x4,%esp
 e23:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 e26:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 e29:	6a 01                	push   $0x1
 e2b:	e9 21 ff ff ff       	jmp    d51 <printf+0xb1>
        putc(fd, *ap);
 e30:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 e33:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 e36:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 e38:	6a 01                	push   $0x1
        ap++;
 e3a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 e3d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 e40:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 e43:	50                   	push   %eax
 e44:	ff 75 08             	pushl  0x8(%ebp)
 e47:	e8 16 fd ff ff       	call   b62 <write>
        ap++;
 e4c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 e4f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 e52:	31 ff                	xor    %edi,%edi
 e54:	e9 8f fe ff ff       	jmp    ce8 <printf+0x48>
          s = "(null)";
 e59:	bb 90 12 00 00       	mov    $0x1290,%ebx
        while(*s != 0){
 e5e:	b8 28 00 00 00       	mov    $0x28,%eax
 e63:	e9 72 ff ff ff       	jmp    dda <printf+0x13a>
 e68:	66 90                	xchg   %ax,%ax
 e6a:	66 90                	xchg   %ax,%ax
 e6c:	66 90                	xchg   %ax,%ax
 e6e:	66 90                	xchg   %ax,%ax

00000e70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 e70:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e71:	a1 bc 16 00 00       	mov    0x16bc,%eax
{
 e76:	89 e5                	mov    %esp,%ebp
 e78:	57                   	push   %edi
 e79:	56                   	push   %esi
 e7a:	53                   	push   %ebx
 e7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 e7e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e88:	39 c8                	cmp    %ecx,%eax
 e8a:	8b 10                	mov    (%eax),%edx
 e8c:	73 32                	jae    ec0 <free+0x50>
 e8e:	39 d1                	cmp    %edx,%ecx
 e90:	72 04                	jb     e96 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e92:	39 d0                	cmp    %edx,%eax
 e94:	72 32                	jb     ec8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e96:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e99:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e9c:	39 fa                	cmp    %edi,%edx
 e9e:	74 30                	je     ed0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ea0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ea3:	8b 50 04             	mov    0x4(%eax),%edx
 ea6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ea9:	39 f1                	cmp    %esi,%ecx
 eab:	74 3a                	je     ee7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 ead:	89 08                	mov    %ecx,(%eax)
  freep = p;
 eaf:	a3 bc 16 00 00       	mov    %eax,0x16bc
}
 eb4:	5b                   	pop    %ebx
 eb5:	5e                   	pop    %esi
 eb6:	5f                   	pop    %edi
 eb7:	5d                   	pop    %ebp
 eb8:	c3                   	ret    
 eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ec0:	39 d0                	cmp    %edx,%eax
 ec2:	72 04                	jb     ec8 <free+0x58>
 ec4:	39 d1                	cmp    %edx,%ecx
 ec6:	72 ce                	jb     e96 <free+0x26>
{
 ec8:	89 d0                	mov    %edx,%eax
 eca:	eb bc                	jmp    e88 <free+0x18>
 ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ed0:	03 72 04             	add    0x4(%edx),%esi
 ed3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ed6:	8b 10                	mov    (%eax),%edx
 ed8:	8b 12                	mov    (%edx),%edx
 eda:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 edd:	8b 50 04             	mov    0x4(%eax),%edx
 ee0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ee3:	39 f1                	cmp    %esi,%ecx
 ee5:	75 c6                	jne    ead <free+0x3d>
    p->s.size += bp->s.size;
 ee7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 eea:	a3 bc 16 00 00       	mov    %eax,0x16bc
    p->s.size += bp->s.size;
 eef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ef2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ef5:	89 10                	mov    %edx,(%eax)
}
 ef7:	5b                   	pop    %ebx
 ef8:	5e                   	pop    %esi
 ef9:	5f                   	pop    %edi
 efa:	5d                   	pop    %ebp
 efb:	c3                   	ret    
 efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 f00:	55                   	push   %ebp
 f01:	89 e5                	mov    %esp,%ebp
 f03:	57                   	push   %edi
 f04:	56                   	push   %esi
 f05:	53                   	push   %ebx
 f06:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 f09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 f0c:	8b 15 bc 16 00 00    	mov    0x16bc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 f12:	8d 78 07             	lea    0x7(%eax),%edi
 f15:	c1 ef 03             	shr    $0x3,%edi
 f18:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 f1b:	85 d2                	test   %edx,%edx
 f1d:	0f 84 9d 00 00 00    	je     fc0 <malloc+0xc0>
 f23:	8b 02                	mov    (%edx),%eax
 f25:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 f28:	39 cf                	cmp    %ecx,%edi
 f2a:	76 6c                	jbe    f98 <malloc+0x98>
 f2c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 f32:	bb 00 10 00 00       	mov    $0x1000,%ebx
 f37:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 f3a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 f41:	eb 0e                	jmp    f51 <malloc+0x51>
 f43:	90                   	nop
 f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 f4a:	8b 48 04             	mov    0x4(%eax),%ecx
 f4d:	39 f9                	cmp    %edi,%ecx
 f4f:	73 47                	jae    f98 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 f51:	39 05 bc 16 00 00    	cmp    %eax,0x16bc
 f57:	89 c2                	mov    %eax,%edx
 f59:	75 ed                	jne    f48 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 f5b:	83 ec 0c             	sub    $0xc,%esp
 f5e:	56                   	push   %esi
 f5f:	e8 66 fc ff ff       	call   bca <sbrk>
  if(p == (char*)-1)
 f64:	83 c4 10             	add    $0x10,%esp
 f67:	83 f8 ff             	cmp    $0xffffffff,%eax
 f6a:	74 1c                	je     f88 <malloc+0x88>
  hp->s.size = nu;
 f6c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 f6f:	83 ec 0c             	sub    $0xc,%esp
 f72:	83 c0 08             	add    $0x8,%eax
 f75:	50                   	push   %eax
 f76:	e8 f5 fe ff ff       	call   e70 <free>
  return freep;
 f7b:	8b 15 bc 16 00 00    	mov    0x16bc,%edx
      if((p = morecore(nunits)) == 0)
 f81:	83 c4 10             	add    $0x10,%esp
 f84:	85 d2                	test   %edx,%edx
 f86:	75 c0                	jne    f48 <malloc+0x48>
        return 0;
  }
}
 f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 f8b:	31 c0                	xor    %eax,%eax
}
 f8d:	5b                   	pop    %ebx
 f8e:	5e                   	pop    %esi
 f8f:	5f                   	pop    %edi
 f90:	5d                   	pop    %ebp
 f91:	c3                   	ret    
 f92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f98:	39 cf                	cmp    %ecx,%edi
 f9a:	74 54                	je     ff0 <malloc+0xf0>
        p->s.size -= nunits;
 f9c:	29 f9                	sub    %edi,%ecx
 f9e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 fa1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 fa4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 fa7:	89 15 bc 16 00 00    	mov    %edx,0x16bc
}
 fad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 fb0:	83 c0 08             	add    $0x8,%eax
}
 fb3:	5b                   	pop    %ebx
 fb4:	5e                   	pop    %esi
 fb5:	5f                   	pop    %edi
 fb6:	5d                   	pop    %ebp
 fb7:	c3                   	ret    
 fb8:	90                   	nop
 fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 fc0:	c7 05 bc 16 00 00 c0 	movl   $0x16c0,0x16bc
 fc7:	16 00 00 
 fca:	c7 05 c0 16 00 00 c0 	movl   $0x16c0,0x16c0
 fd1:	16 00 00 
    base.s.size = 0;
 fd4:	b8 c0 16 00 00       	mov    $0x16c0,%eax
 fd9:	c7 05 c4 16 00 00 00 	movl   $0x0,0x16c4
 fe0:	00 00 00 
 fe3:	e9 44 ff ff ff       	jmp    f2c <malloc+0x2c>
 fe8:	90                   	nop
 fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 ff0:	8b 08                	mov    (%eax),%ecx
 ff2:	89 0a                	mov    %ecx,(%edx)
 ff4:	eb b1                	jmp    fa7 <malloc+0xa7>
