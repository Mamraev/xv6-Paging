
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
   f:	e8 4e 0b 00 00       	call   b62 <getNumberOfFreePages>
  
  //  Cow Tests:
  makeTest(cowPhysicalTest);
  14:	83 ec 0c             	sub    $0xc,%esp
  int freeMem = getNumberOfFreePages();
  17:	89 c3                	mov    %eax,%ebx
  makeTest(cowPhysicalTest);
  19:	68 00 01 00 00       	push   $0x100
  1e:	e8 0d 08 00 00       	call   830 <makeTest>
  makeTest(cowSwapFile_pageSeperationTest);
  23:	c7 04 24 c0 02 00 00 	movl   $0x2c0,(%esp)
  2a:	e8 01 08 00 00       	call   830 <makeTest>
  makeTest(cowSwapFile_killedChiledTest);
  2f:	c7 04 24 a0 05 00 00 	movl   $0x5a0,(%esp)
  36:	e8 f5 07 00 00       	call   830 <makeTest>
  makeTest(cowSwapFile_maxPhyInChildTest);
  3b:	c7 04 24 e0 03 00 00 	movl   $0x3e0,(%esp)
  42:	e8 e9 07 00 00       	call   830 <makeTest>
  
  // General Page Tests:
  makeTest(PhysicalMemTest);
  47:	c7 04 24 10 07 00 00 	movl   $0x710,(%esp)
  4e:	e8 dd 07 00 00       	call   830 <makeTest>
  makeTest(SwapFileTest);
  53:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
  5a:	e8 d1 07 00 00       	call   830 <makeTest>
  memLeakTest(freeMem);
  5f:	89 1c 24             	mov    %ebx,(%esp)
  62:	e8 69 07 00 00       	call   7d0 <memLeakTest>
  exit();
  67:	e8 56 0a 00 00       	call   ac2 <exit>
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
  79:	68 78 0f 00 00       	push   $0xf78
  7e:	6a 01                	push   $0x1
  80:	e8 9b 0b 00 00       	call   c20 <printf>
  85:	83 c4 10             	add    $0x10,%esp
  88:	90                   	nop
  89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lst[i] = (int*)sbrk(PGSIZE);
  90:	83 ec 0c             	sub    $0xc,%esp
  93:	68 00 10 00 00       	push   $0x1000
  98:	e8 ad 0a 00 00       	call   b4a <sbrk>
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
  b3:	e8 9a 0a 00 00       	call   b52 <sleep>
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
  d4:	68 87 0f 00 00       	push   $0xf87
  d9:	6a 01                	push   $0x1
  db:	e8 40 0b 00 00       	call   c20 <printf>
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
 109:	68 95 0f 00 00       	push   $0xf95
 10e:	6a 01                	push   $0x1
 110:	e8 0b 0b 00 00       	call   c20 <printf>
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
 13b:	e8 0a 0a 00 00       	call   b4a <sbrk>
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
 164:	e8 f9 09 00 00       	call   b62 <getNumberOfFreePages>
 169:	89 c7                	mov    %eax,%edi
  int pid = fork();
 16b:	e8 4a 09 00 00       	call   aba <fork>
 170:	89 c6                	mov    %eax,%esi
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 172:	e8 eb 09 00 00       	call   b62 <getNumberOfFreePages>
  sleep(10);
 177:	83 ec 0c             	sub    $0xc,%esp
  int freePages_beforeReadingFromParent = getNumberOfFreePages();
 17a:	89 c3                	mov    %eax,%ebx
  sleep(10);
 17c:	6a 0a                	push   $0xa
 17e:	e8 cf 09 00 00       	call   b52 <sleep>
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
 1c8:	e8 85 09 00 00       	call   b52 <sleep>
    int freePages_beforeCloning = getNumberOfFreePages();
 1cd:	e8 90 09 00 00       	call   b62 <getNumberOfFreePages>
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
 1eb:	e8 62 09 00 00       	call   b52 <sleep>
    if(freePages_beforeCloning != getNumberOfFreePages()+1){
 1f0:	e8 6d 09 00 00       	call   b62 <getNumberOfFreePages>
 1f5:	83 c0 01             	add    $0x1,%eax
 1f8:	83 c4 10             	add    $0x10,%esp
 1fb:	39 d8                	cmp    %ebx,%eax
 1fd:	74 29                	je     228 <cowPhysicalTest+0x128>
      printf(1,"Err : num of free pages after cloning");
 1ff:	83 ec 08             	sub    $0x8,%esp
 202:	68 ec 10 00 00       	push   $0x10ec
 207:	6a 01                	push   $0x1
 209:	e8 12 0a 00 00       	call   c20 <printf>
      printf(1," FAILED");
 20e:	5e                   	pop    %esi
 20f:	5f                   	pop    %edi
 210:	68 a7 0f 00 00       	push   $0xfa7
 215:	6a 01                	push   $0x1
 217:	e8 04 0a 00 00       	call   c20 <printf>
      exit();
 21c:	e8 a1 08 00 00       	call   ac2 <exit>
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(10);
 228:	83 ec 0c             	sub    $0xc,%esp
 22b:	6a 0a                	push   $0xa
 22d:	e8 20 09 00 00       	call   b52 <sleep>
    exit();
 232:	e8 8b 08 00 00       	call   ac2 <exit>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 240:	e8 85 08 00 00       	call   aca <wait>
  if(freePages_beforeChild != getNumberOfFreePages()){
 245:	e8 18 09 00 00       	call   b62 <getNumberOfFreePages>
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
 258:	e8 05 09 00 00       	call   b62 <getNumberOfFreePages>
 25d:	50                   	push   %eax
 25e:	57                   	push   %edi
 25f:	68 af 0f 00 00       	push   $0xfaf
 264:	6a 01                	push   $0x1
 266:	e8 b5 09 00 00       	call   c20 <printf>
    printf(1,"Err : num of free pages after child exit");
 26b:	58                   	pop    %eax
 26c:	5a                   	pop    %edx
 26d:	68 14 11 00 00       	push   $0x1114
 272:	6a 01                	push   $0x1
 274:	e8 a7 09 00 00       	call   c20 <printf>
    printf(1," FAILED");
 279:	59                   	pop    %ecx
 27a:	5b                   	pop    %ebx
 27b:	68 a7 0f 00 00       	push   $0xfa7
 280:	6a 01                	push   $0x1
 282:	e8 99 09 00 00       	call   c20 <printf>
    sleep(50000);
 287:	c7 04 24 50 c3 00 00 	movl   $0xc350,(%esp)
 28e:	e8 bf 08 00 00       	call   b52 <sleep>
    return -1;
 293:	83 c4 10             	add    $0x10,%esp
 296:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29b:	eb b3                	jmp    250 <cowPhysicalTest+0x150>
        printf(1," FAILED");
 29d:	83 ec 08             	sub    $0x8,%esp
 2a0:	68 a7 0f 00 00       	push   $0xfa7
 2a5:	6a 01                	push   $0x1
 2a7:	e8 74 09 00 00       	call   c20 <printf>
        exit();
 2ac:	e8 11 08 00 00       	call   ac2 <exit>
      printf(1,"Err : num of free pages after reading only has changed");
 2b1:	50                   	push   %eax
 2b2:	50                   	push   %eax
 2b3:	68 b4 10 00 00       	push   $0x10b4
 2b8:	e9 4a ff ff ff       	jmp    207 <cowPhysicalTest+0x107>
 2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <cowSwapFile_pageSeperationTest>:
cowSwapFile_pageSeperationTest(){
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_pageSeperationTest :");
 2c7:	68 40 11 00 00       	push   $0x1140
 2cc:	6a 01                	push   $0x1
 2ce:	e8 4d 09 00 00       	call   c20 <printf>
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
 2f3:	e8 52 08 00 00       	call   b4a <sbrk>
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
 31c:	e8 99 07 00 00       	call   aba <fork>
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
 344:	68 da 0f 00 00       	push   $0xfda
 349:	6a 01                	push   $0x1
 34b:	e8 d0 08 00 00       	call   c20 <printf>
        printf(1," FAILED");
 350:	58                   	pop    %eax
 351:	5a                   	pop    %edx
 352:	68 a7 0f 00 00       	push   $0xfa7
 357:	6a 01                	push   $0x1
 359:	e8 c2 08 00 00       	call   c20 <printf>
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
 370:	e8 55 07 00 00       	call   aca <wait>
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
 3a6:	68 c7 0f 00 00       	push   $0xfc7
 3ab:	6a 01                	push   $0x1
 3ad:	e8 6e 08 00 00       	call   c20 <printf>
        printf(1," FAILED");
 3b2:	59                   	pop    %ecx
 3b3:	5b                   	pop    %ebx
 3b4:	68 a7 0f 00 00       	push   $0xfa7
 3b9:	6a 01                	push   $0x1
 3bb:	e8 60 08 00 00       	call   c20 <printf>
 3c0:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 20; i++){
 3c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3c6:	83 c0 01             	add    $0x1,%eax
 3c9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 3cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3cf:	83 f8 13             	cmp    $0x13,%eax
 3d2:	7e b7                	jle    38b <cowSwapFile_pageSeperationTest+0xcb>
    exit();
 3d4:	e8 e9 06 00 00       	call   ac2 <exit>
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
 3e5:	83 ec 60             	sub    $0x60,%esp
  int freePages = getNumberOfFreePages();
 3e8:	e8 75 07 00 00       	call   b62 <getNumberOfFreePages>
  printf(1,"1  free pages: %d\n",freePages);
 3ed:	83 ec 04             	sub    $0x4,%esp
  int freePages = getNumberOfFreePages();
 3f0:	89 c6                	mov    %eax,%esi
  printf(1,"1  free pages: %d\n",freePages);
 3f2:	50                   	push   %eax
 3f3:	68 ee 0f 00 00       	push   $0xfee
 3f8:	6a 01                	push   $0x1
 3fa:	e8 21 08 00 00       	call   c20 <printf>
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 3ff:	59                   	pop    %ecx
 400:	5b                   	pop    %ebx
 401:	68 64 11 00 00       	push   $0x1164
 406:	6a 01                	push   $0x1
  for(i = 0; i < 20; i++){
 408:	31 db                	xor    %ebx,%ebx
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 40a:	e8 11 08 00 00       	call   c20 <printf>
 40f:	83 c4 10             	add    $0x10,%esp
 412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	68 00 10 00 00       	push   $0x1000
 420:	e8 25 07 00 00       	call   b4a <sbrk>
 425:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 429:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
 42b:	83 c3 01             	add    $0x1,%ebx
 42e:	83 c4 10             	add    $0x10,%esp
 431:	83 fb 14             	cmp    $0x14,%ebx
 434:	75 e2                	jne    418 <cowSwapFile_maxPhyInChildTest+0x38>
  if(freePages != getNumberOfFreePages()+16){
 436:	e8 27 07 00 00       	call   b62 <getNumberOfFreePages>
 43b:	83 c0 10             	add    $0x10,%eax
 43e:	39 f0                	cmp    %esi,%eax
 440:	74 18                	je     45a <cowSwapFile_maxPhyInChildTest+0x7a>
    printf(1," FAILED 1(Free Memory error) %d\n",getNumberOfFreePages());
 442:	e8 1b 07 00 00       	call   b62 <getNumberOfFreePages>
 447:	83 ec 04             	sub    $0x4,%esp
 44a:	50                   	push   %eax
 44b:	68 84 11 00 00       	push   $0x1184
 450:	6a 01                	push   $0x1
 452:	e8 c9 07 00 00       	call   c20 <printf>
 457:	83 c4 10             	add    $0x10,%esp
  int pid = fork();
 45a:	e8 5b 06 00 00       	call   aba <fork>
  if(pid==0){
 45f:	85 c0                	test   %eax,%eax
 461:	0f 84 ae 00 00 00    	je     515 <cowSwapFile_maxPhyInChildTest+0x135>
  wait();
 467:	e8 5e 06 00 00       	call   aca <wait>
  printf(1,"4  free pages: %d\n",getNumberOfFreePages());
 46c:	e8 f1 06 00 00       	call   b62 <getNumberOfFreePages>
 471:	83 ec 04             	sub    $0x4,%esp
 474:	50                   	push   %eax
 475:	68 45 10 00 00       	push   $0x1045
 47a:	6a 01                	push   $0x1
 47c:	e8 9f 07 00 00       	call   c20 <printf>
 481:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++){
 484:	31 c0                	xor    %eax,%eax
 486:	eb 10                	jmp    498 <cowSwapFile_maxPhyInChildTest+0xb8>
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 490:	83 c0 01             	add    $0x1,%eax
 493:	83 f8 14             	cmp    $0x14,%eax
 496:	74 38                	je     4d0 <cowSwapFile_maxPhyInChildTest+0xf0>
      if(*lst[i]!=i){
 498:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 49c:	39 02                	cmp    %eax,(%edx)
 49e:	74 f0                	je     490 <cowSwapFile_maxPhyInChildTest+0xb0>
        printf(1,"\nparent fail %d %d\n",*lst[i]!=i);
 4a0:	83 ec 04             	sub    $0x4,%esp
 4a3:	6a 01                	push   $0x1
 4a5:	68 da 0f 00 00       	push   $0xfda
 4aa:	6a 01                	push   $0x1
 4ac:	e8 6f 07 00 00       	call   c20 <printf>
        printf(1," FAILED");
 4b1:	58                   	pop    %eax
 4b2:	5a                   	pop    %edx
 4b3:	68 a7 0f 00 00       	push   $0xfa7
 4b8:	6a 01                	push   $0x1
 4ba:	e8 61 07 00 00       	call   c20 <printf>
        return -1;
 4bf:	83 c4 10             	add    $0x10,%esp
 4c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 4c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4ca:	5b                   	pop    %ebx
 4cb:	5e                   	pop    %esi
 4cc:	5d                   	pop    %ebp
 4cd:	c3                   	ret    
 4ce:	66 90                	xchg   %ax,%ax
    printf(1,"5  free pages: %d\n",getNumberOfFreePages());
 4d0:	e8 8d 06 00 00       	call   b62 <getNumberOfFreePages>
 4d5:	83 ec 04             	sub    $0x4,%esp
 4d8:	50                   	push   %eax
 4d9:	68 58 10 00 00       	push   $0x1058
 4de:	6a 01                	push   $0x1
 4e0:	e8 3b 07 00 00       	call   c20 <printf>
    if(freePages != getNumberOfFreePages()+16){
 4e5:	e8 78 06 00 00       	call   b62 <getNumberOfFreePages>
 4ea:	8d 50 10             	lea    0x10(%eax),%edx
 4ed:	83 c4 10             	add    $0x10,%esp
  return 0;
 4f0:	31 c0                	xor    %eax,%eax
    if(freePages != getNumberOfFreePages()+16){
 4f2:	39 f2                	cmp    %esi,%edx
 4f4:	74 d1                	je     4c7 <cowSwapFile_maxPhyInChildTest+0xe7>
      printf(1," FAILED 4(Free Memory error)\n");
 4f6:	83 ec 08             	sub    $0x8,%esp
 4f9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 4fc:	68 6b 10 00 00       	push   $0x106b
 501:	6a 01                	push   $0x1
 503:	e8 18 07 00 00       	call   c20 <printf>
 508:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 50b:	83 c4 10             	add    $0x10,%esp
}
 50e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 511:	5b                   	pop    %ebx
 512:	5e                   	pop    %esi
 513:	5d                   	pop    %ebp
 514:	c3                   	ret    
    printf(1,"2  free pages: %d\n",getNumberOfFreePages());
 515:	e8 48 06 00 00       	call   b62 <getNumberOfFreePages>
 51a:	52                   	push   %edx
 51b:	50                   	push   %eax
 51c:	68 01 10 00 00       	push   $0x1001
 521:	6a 01                	push   $0x1
 523:	e8 f8 06 00 00       	call   c20 <printf>
    if(freePages != getNumberOfFreePages()+84){
 528:	e8 35 06 00 00       	call   b62 <getNumberOfFreePages>
 52d:	83 c0 54             	add    $0x54,%eax
 530:	83 c4 10             	add    $0x10,%esp
 533:	39 f0                	cmp    %esi,%eax
 535:	74 11                	je     548 <cowSwapFile_maxPhyInChildTest+0x168>
    printf(1," FAILED 2(Free Memory error)\n");
 537:	50                   	push   %eax
 538:	50                   	push   %eax
 539:	68 14 10 00 00       	push   $0x1014
 53e:	6a 01                	push   $0x1
 540:	e8 db 06 00 00       	call   c20 <printf>
 545:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++){
 548:	b8 32 00 00 00       	mov    $0x32,%eax
      *lst[i]= i + 50;
 54d:	8b 94 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%edx
 554:	89 02                	mov    %eax,(%edx)
 556:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < 20; i++){
 559:	83 f8 46             	cmp    $0x46,%eax
 55c:	75 ef                	jne    54d <cowSwapFile_maxPhyInChildTest+0x16d>
    if(freePages != getNumberOfFreePages()+100){
 55e:	e8 ff 05 00 00       	call   b62 <getNumberOfFreePages>
 563:	83 c0 64             	add    $0x64,%eax
 566:	39 f0                	cmp    %esi,%eax
 568:	74 16                	je     580 <cowSwapFile_maxPhyInChildTest+0x1a0>
      printf(1," FAILED 3(Free Memory error)%d\n",getNumberOfFreePages());
 56a:	e8 f3 05 00 00       	call   b62 <getNumberOfFreePages>
 56f:	53                   	push   %ebx
 570:	50                   	push   %eax
 571:	68 a8 11 00 00       	push   $0x11a8
 576:	6a 01                	push   $0x1
 578:	e8 a3 06 00 00       	call   c20 <printf>
 57d:	83 c4 10             	add    $0x10,%esp
    printf(1,"3  free pages: %d\n",getNumberOfFreePages());
 580:	e8 dd 05 00 00       	call   b62 <getNumberOfFreePages>
 585:	51                   	push   %ecx
 586:	50                   	push   %eax
 587:	68 32 10 00 00       	push   $0x1032
 58c:	6a 01                	push   $0x1
 58e:	e8 8d 06 00 00       	call   c20 <printf>
    exit();
 593:	e8 2a 05 00 00       	call   ac2 <exit>
 598:	90                   	nop
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005a0 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_killedChiledTest :");
 5a7:	68 c8 11 00 00       	push   $0x11c8
 5ac:	6a 01                	push   $0x1
 5ae:	e8 6d 06 00 00       	call   c20 <printf>
  for(i = 0; i < 20; i++){
 5b3:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 5ba:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	83 f8 13             	cmp    $0x13,%eax
 5c3:	7f 37                	jg     5fc <cowSwapFile_killedChiledTest+0x5c>
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 5c8:	83 ec 0c             	sub    $0xc,%esp
 5cb:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 5ce:	68 00 10 00 00       	push   $0x1000
 5d3:	e8 72 05 00 00       	call   b4a <sbrk>
 5d8:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 5dc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 5df:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 5e2:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 5e5:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 5e9:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 5eb:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5ee:	83 c0 01             	add    $0x1,%eax
 5f1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 5f4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5f7:	83 f8 13             	cmp    $0x13,%eax
 5fa:	7e cc                	jle    5c8 <cowSwapFile_killedChiledTest+0x28>
  int pid = fork();
 5fc:	e8 b9 04 00 00       	call   aba <fork>
  if(pid==0){
 601:	85 c0                	test   %eax,%eax
 603:	0f 85 c7 00 00 00    	jne    6d0 <cowSwapFile_killedChiledTest+0x130>
    for(i = 0; i < 20; i++){
 609:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 610:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 613:	83 f8 13             	cmp    $0x13,%eax
 616:	7e 19                	jle    631 <cowSwapFile_killedChiledTest+0x91>
 618:	eb 66                	jmp    680 <cowSwapFile_killedChiledTest+0xe0>
 61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 620:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 623:	83 c0 01             	add    $0x1,%eax
 626:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 629:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 62c:	83 f8 13             	cmp    $0x13,%eax
 62f:	7f 4f                	jg     680 <cowSwapFile_killedChiledTest+0xe0>
      if(*lst[i]!=i){
 631:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 634:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 637:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 63b:	39 02                	cmp    %eax,(%edx)
 63d:	74 e1                	je     620 <cowSwapFile_killedChiledTest+0x80>
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
 63f:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 642:	83 ec 04             	sub    $0x4,%esp
 645:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 648:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 64c:	39 02                	cmp    %eax,(%edx)
 64e:	0f 95 c0             	setne  %al
 651:	0f b6 c0             	movzbl %al,%eax
 654:	50                   	push   %eax
 655:	68 c7 0f 00 00       	push   $0xfc7
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 65a:	6a 01                	push   $0x1
 65c:	e8 bf 05 00 00       	call   c20 <printf>
        printf(1," FAILED");
 661:	58                   	pop    %eax
 662:	5a                   	pop    %edx
 663:	68 a7 0f 00 00       	push   $0xfa7
 668:	6a 01                	push   $0x1
 66a:	e8 b1 05 00 00       	call   c20 <printf>
        return -1;
 66f:	83 c4 10             	add    $0x10,%esp
 672:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 677:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 67a:	c9                   	leave  
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 20; i++){
 680:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 687:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 68a:	83 f8 13             	cmp    $0x13,%eax
 68d:	7e 1a                	jle    6a9 <cowSwapFile_killedChiledTest+0x109>
 68f:	eb 76                	jmp    707 <cowSwapFile_killedChiledTest+0x167>
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 698:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 69b:	83 c0 01             	add    $0x1,%eax
 69e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 6a1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6a4:	83 f8 13             	cmp    $0x13,%eax
 6a7:	7f 5e                	jg     707 <cowSwapFile_killedChiledTest+0x167>
      *lst[i] = 66;
 6a9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6ac:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 6b0:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(*lst[i]!=66){
 6b6:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 6b9:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 6bd:	83 38 42             	cmpl   $0x42,(%eax)
 6c0:	74 d6                	je     698 <cowSwapFile_killedChiledTest+0xf8>
 6c2:	e9 78 ff ff ff       	jmp    63f <cowSwapFile_killedChiledTest+0x9f>
 6c7:	89 f6                	mov    %esi,%esi
 6c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 6d0:	e8 f5 03 00 00       	call   aca <wait>
  for(j = 0; j < 20; j++){
 6d5:	31 c0                	xor    %eax,%eax
 6d7:	eb 0f                	jmp    6e8 <cowSwapFile_killedChiledTest+0x148>
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6e0:	83 c0 01             	add    $0x1,%eax
 6e3:	83 f8 14             	cmp    $0x14,%eax
 6e6:	74 18                	je     700 <cowSwapFile_killedChiledTest+0x160>
      if(*lst[j]!=j){
 6e8:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 6ec:	39 02                	cmp    %eax,(%edx)
 6ee:	74 f0                	je     6e0 <cowSwapFile_killedChiledTest+0x140>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 6f0:	83 ec 04             	sub    $0x4,%esp
 6f3:	6a 01                	push   $0x1
 6f5:	68 da 0f 00 00       	push   $0xfda
 6fa:	e9 5b ff ff ff       	jmp    65a <cowSwapFile_killedChiledTest+0xba>
 6ff:	90                   	nop
  return 0;
 700:	31 c0                	xor    %eax,%eax
}
 702:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 705:	c9                   	leave  
 706:	c3                   	ret    
    exit();
 707:	e8 b6 03 00 00       	call   ac2 <exit>
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <PhysicalMemTest>:
PhysicalMemTest(){
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	53                   	push   %ebx
 714:	83 ec 2c             	sub    $0x2c,%esp
  printf(1,"PhysicalMemTest :");
 717:	68 89 10 00 00       	push   $0x1089
 71c:	6a 01                	push   $0x1
 71e:	e8 fd 04 00 00       	call   c20 <printf>
  for(i = 0; i < 5; i++){
 723:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 72a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 72d:	83 c4 10             	add    $0x10,%esp
 730:	83 f8 04             	cmp    $0x4,%eax
 733:	7f 37                	jg     76c <PhysicalMemTest+0x5c>
 735:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 738:	83 ec 0c             	sub    $0xc,%esp
 73b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 73e:	68 00 10 00 00       	push   $0x1000
 743:	e8 02 04 00 00       	call   b4a <sbrk>
 748:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
    *lst[i]=i;
 74c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  for(i = 0; i < 5; i++){
 74f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 752:	8b 55 e0             	mov    -0x20(%ebp),%edx
 755:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
 759:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 5; i++){
 75b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 75e:	83 c0 01             	add    $0x1,%eax
 761:	89 45 e0             	mov    %eax,-0x20(%ebp)
 764:	8b 45 e0             	mov    -0x20(%ebp),%eax
 767:	83 f8 04             	cmp    $0x4,%eax
 76a:	7e cc                	jle    738 <PhysicalMemTest+0x28>
  for(i = 0; i < 5; i++){
 76c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 773:	8b 45 e0             	mov    -0x20(%ebp),%eax
 776:	83 f8 04             	cmp    $0x4,%eax
 779:	7e 16                	jle    791 <PhysicalMemTest+0x81>
 77b:	eb 43                	jmp    7c0 <PhysicalMemTest+0xb0>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
 780:	8b 45 e0             	mov    -0x20(%ebp),%eax
 783:	83 c0 01             	add    $0x1,%eax
 786:	89 45 e0             	mov    %eax,-0x20(%ebp)
 789:	8b 45 e0             	mov    -0x20(%ebp),%eax
 78c:	83 f8 04             	cmp    $0x4,%eax
 78f:	7f 2f                	jg     7c0 <PhysicalMemTest+0xb0>
    if(*lst[i]!=i){
 791:	8b 55 e0             	mov    -0x20(%ebp),%edx
 794:	8b 45 e0             	mov    -0x20(%ebp),%eax
 797:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
 79b:	39 02                	cmp    %eax,(%edx)
 79d:	74 e1                	je     780 <PhysicalMemTest+0x70>
      printf(1," FAILED");
 79f:	83 ec 08             	sub    $0x8,%esp
 7a2:	68 a7 0f 00 00       	push   $0xfa7
 7a7:	6a 01                	push   $0x1
 7a9:	e8 72 04 00 00       	call   c20 <printf>
 7ae:	83 c4 10             	add    $0x10,%esp
 7b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 7b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7b9:	c9                   	leave  
 7ba:	c3                   	ret    
 7bb:	90                   	nop
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 7c0:	31 c0                	xor    %eax,%eax
}
 7c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 7c5:	c9                   	leave  
 7c6:	c3                   	ret    
 7c7:	89 f6                	mov    %esi,%esi
 7c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007d0 <memLeakTest>:
memLeakTest(int freeMem){
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	53                   	push   %ebx
 7d4:	83 ec 0c             	sub    $0xc,%esp
 7d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(1,"memLeakTest :");
 7da:	68 9b 10 00 00       	push   $0x109b
 7df:	6a 01                	push   $0x1
 7e1:	e8 3a 04 00 00       	call   c20 <printf>
  if(freeMem != getNumberOfFreePages()){
 7e6:	e8 77 03 00 00       	call   b62 <getNumberOfFreePages>
 7eb:	83 c4 10             	add    $0x10,%esp
 7ee:	39 d8                	cmp    %ebx,%eax
 7f0:	74 1e                	je     810 <memLeakTest+0x40>
      printf(1, "FAILED    expected: %d     got : %d\n",freeMem,getNumberOfFreePages());
 7f2:	e8 6b 03 00 00       	call   b62 <getNumberOfFreePages>
 7f7:	50                   	push   %eax
 7f8:	53                   	push   %ebx
 7f9:	68 e8 11 00 00       	push   $0x11e8
 7fe:	6a 01                	push   $0x1
 800:	e8 1b 04 00 00       	call   c20 <printf>
 805:	83 c4 10             	add    $0x10,%esp
}
 808:	31 c0                	xor    %eax,%eax
 80a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 80d:	c9                   	leave  
 80e:	c3                   	ret    
 80f:	90                   	nop
    printf(1, "PASSED\n");
 810:	83 ec 08             	sub    $0x8,%esp
 813:	68 aa 10 00 00       	push   $0x10aa
 818:	6a 01                	push   $0x1
 81a:	e8 01 04 00 00       	call   c20 <printf>
 81f:	83 c4 10             	add    $0x10,%esp
}
 822:	31 c0                	xor    %eax,%eax
 824:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 827:	c9                   	leave  
 828:	c3                   	ret    
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000830 <makeTest>:
makeTest(int (*test)()){
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	53                   	push   %ebx
 834:	83 ec 04             	sub    $0x4,%esp
 837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int testerPid = fork();
 83a:	e8 7b 02 00 00       	call   aba <fork>
  if(testerPid==0){
 83f:	85 c0                	test   %eax,%eax
 841:	74 09                	je     84c <makeTest+0x1c>
} 
 843:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 846:	c9                   	leave  
  wait();
 847:	e9 7e 02 00 00       	jmp    aca <wait>
    if(test()==0){
 84c:	ff d3                	call   *%ebx
 84e:	85 c0                	test   %eax,%eax
 850:	74 05                	je     857 <makeTest+0x27>
    exit();
 852:	e8 6b 02 00 00       	call   ac2 <exit>
      printf(1," PASSED\n");
 857:	50                   	push   %eax
 858:	50                   	push   %eax
 859:	68 a9 10 00 00       	push   $0x10a9
 85e:	6a 01                	push   $0x1
 860:	e8 bb 03 00 00       	call   c20 <printf>
 865:	83 c4 10             	add    $0x10,%esp
 868:	eb e8                	jmp    852 <makeTest+0x22>
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax

00000870 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	53                   	push   %ebx
 874:	8b 45 08             	mov    0x8(%ebp),%eax
 877:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 87a:	89 c2                	mov    %eax,%edx
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 880:	83 c1 01             	add    $0x1,%ecx
 883:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 887:	83 c2 01             	add    $0x1,%edx
 88a:	84 db                	test   %bl,%bl
 88c:	88 5a ff             	mov    %bl,-0x1(%edx)
 88f:	75 ef                	jne    880 <strcpy+0x10>
    ;
  return os;
}
 891:	5b                   	pop    %ebx
 892:	5d                   	pop    %ebp
 893:	c3                   	ret    
 894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 89a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	53                   	push   %ebx
 8a4:	8b 55 08             	mov    0x8(%ebp),%edx
 8a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 8aa:	0f b6 02             	movzbl (%edx),%eax
 8ad:	0f b6 19             	movzbl (%ecx),%ebx
 8b0:	84 c0                	test   %al,%al
 8b2:	75 1c                	jne    8d0 <strcmp+0x30>
 8b4:	eb 2a                	jmp    8e0 <strcmp+0x40>
 8b6:	8d 76 00             	lea    0x0(%esi),%esi
 8b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 8c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 8c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 8c6:	83 c1 01             	add    $0x1,%ecx
 8c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 8cc:	84 c0                	test   %al,%al
 8ce:	74 10                	je     8e0 <strcmp+0x40>
 8d0:	38 d8                	cmp    %bl,%al
 8d2:	74 ec                	je     8c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 8d4:	29 d8                	sub    %ebx,%eax
}
 8d6:	5b                   	pop    %ebx
 8d7:	5d                   	pop    %ebp
 8d8:	c3                   	ret    
 8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 8e2:	29 d8                	sub    %ebx,%eax
}
 8e4:	5b                   	pop    %ebx
 8e5:	5d                   	pop    %ebp
 8e6:	c3                   	ret    
 8e7:	89 f6                	mov    %esi,%esi
 8e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008f0 <strlen>:

uint
strlen(const char *s)
{
 8f0:	55                   	push   %ebp
 8f1:	89 e5                	mov    %esp,%ebp
 8f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 8f6:	80 39 00             	cmpb   $0x0,(%ecx)
 8f9:	74 15                	je     910 <strlen+0x20>
 8fb:	31 d2                	xor    %edx,%edx
 8fd:	8d 76 00             	lea    0x0(%esi),%esi
 900:	83 c2 01             	add    $0x1,%edx
 903:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 907:	89 d0                	mov    %edx,%eax
 909:	75 f5                	jne    900 <strlen+0x10>
    ;
  return n;
}
 90b:	5d                   	pop    %ebp
 90c:	c3                   	ret    
 90d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 910:	31 c0                	xor    %eax,%eax
}
 912:	5d                   	pop    %ebp
 913:	c3                   	ret    
 914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 91a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000920 <memset>:

void*
memset(void *dst, int c, uint n)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 927:	8b 4d 10             	mov    0x10(%ebp),%ecx
 92a:	8b 45 0c             	mov    0xc(%ebp),%eax
 92d:	89 d7                	mov    %edx,%edi
 92f:	fc                   	cld    
 930:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 932:	89 d0                	mov    %edx,%eax
 934:	5f                   	pop    %edi
 935:	5d                   	pop    %ebp
 936:	c3                   	ret    
 937:	89 f6                	mov    %esi,%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000940 <strchr>:

char*
strchr(const char *s, char c)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
 943:	53                   	push   %ebx
 944:	8b 45 08             	mov    0x8(%ebp),%eax
 947:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 94a:	0f b6 10             	movzbl (%eax),%edx
 94d:	84 d2                	test   %dl,%dl
 94f:	74 1d                	je     96e <strchr+0x2e>
    if(*s == c)
 951:	38 d3                	cmp    %dl,%bl
 953:	89 d9                	mov    %ebx,%ecx
 955:	75 0d                	jne    964 <strchr+0x24>
 957:	eb 17                	jmp    970 <strchr+0x30>
 959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 960:	38 ca                	cmp    %cl,%dl
 962:	74 0c                	je     970 <strchr+0x30>
  for(; *s; s++)
 964:	83 c0 01             	add    $0x1,%eax
 967:	0f b6 10             	movzbl (%eax),%edx
 96a:	84 d2                	test   %dl,%dl
 96c:	75 f2                	jne    960 <strchr+0x20>
      return (char*)s;
  return 0;
 96e:	31 c0                	xor    %eax,%eax
}
 970:	5b                   	pop    %ebx
 971:	5d                   	pop    %ebp
 972:	c3                   	ret    
 973:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000980 <gets>:

char*
gets(char *buf, int max)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	57                   	push   %edi
 984:	56                   	push   %esi
 985:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 986:	31 f6                	xor    %esi,%esi
 988:	89 f3                	mov    %esi,%ebx
{
 98a:	83 ec 1c             	sub    $0x1c,%esp
 98d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 990:	eb 2f                	jmp    9c1 <gets+0x41>
 992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 998:	8d 45 e7             	lea    -0x19(%ebp),%eax
 99b:	83 ec 04             	sub    $0x4,%esp
 99e:	6a 01                	push   $0x1
 9a0:	50                   	push   %eax
 9a1:	6a 00                	push   $0x0
 9a3:	e8 32 01 00 00       	call   ada <read>
    if(cc < 1)
 9a8:	83 c4 10             	add    $0x10,%esp
 9ab:	85 c0                	test   %eax,%eax
 9ad:	7e 1c                	jle    9cb <gets+0x4b>
      break;
    buf[i++] = c;
 9af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 9b3:	83 c7 01             	add    $0x1,%edi
 9b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 9b9:	3c 0a                	cmp    $0xa,%al
 9bb:	74 23                	je     9e0 <gets+0x60>
 9bd:	3c 0d                	cmp    $0xd,%al
 9bf:	74 1f                	je     9e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 9c1:	83 c3 01             	add    $0x1,%ebx
 9c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 9c7:	89 fe                	mov    %edi,%esi
 9c9:	7c cd                	jl     998 <gets+0x18>
 9cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 9cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 9d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 9d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9d6:	5b                   	pop    %ebx
 9d7:	5e                   	pop    %esi
 9d8:	5f                   	pop    %edi
 9d9:	5d                   	pop    %ebp
 9da:	c3                   	ret    
 9db:	90                   	nop
 9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9e0:	8b 75 08             	mov    0x8(%ebp),%esi
 9e3:	8b 45 08             	mov    0x8(%ebp),%eax
 9e6:	01 de                	add    %ebx,%esi
 9e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 9ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 9ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9f0:	5b                   	pop    %ebx
 9f1:	5e                   	pop    %esi
 9f2:	5f                   	pop    %edi
 9f3:	5d                   	pop    %ebp
 9f4:	c3                   	ret    
 9f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <stat>:

int
stat(const char *n, struct stat *st)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	56                   	push   %esi
 a04:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 a05:	83 ec 08             	sub    $0x8,%esp
 a08:	6a 00                	push   $0x0
 a0a:	ff 75 08             	pushl  0x8(%ebp)
 a0d:	e8 f0 00 00 00       	call   b02 <open>
  if(fd < 0)
 a12:	83 c4 10             	add    $0x10,%esp
 a15:	85 c0                	test   %eax,%eax
 a17:	78 27                	js     a40 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 a19:	83 ec 08             	sub    $0x8,%esp
 a1c:	ff 75 0c             	pushl  0xc(%ebp)
 a1f:	89 c3                	mov    %eax,%ebx
 a21:	50                   	push   %eax
 a22:	e8 f3 00 00 00       	call   b1a <fstat>
  close(fd);
 a27:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 a2a:	89 c6                	mov    %eax,%esi
  close(fd);
 a2c:	e8 b9 00 00 00       	call   aea <close>
  return r;
 a31:	83 c4 10             	add    $0x10,%esp
}
 a34:	8d 65 f8             	lea    -0x8(%ebp),%esp
 a37:	89 f0                	mov    %esi,%eax
 a39:	5b                   	pop    %ebx
 a3a:	5e                   	pop    %esi
 a3b:	5d                   	pop    %ebp
 a3c:	c3                   	ret    
 a3d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 a40:	be ff ff ff ff       	mov    $0xffffffff,%esi
 a45:	eb ed                	jmp    a34 <stat+0x34>
 a47:	89 f6                	mov    %esi,%esi
 a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a50 <atoi>:

int
atoi(const char *s)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	53                   	push   %ebx
 a54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 a57:	0f be 11             	movsbl (%ecx),%edx
 a5a:	8d 42 d0             	lea    -0x30(%edx),%eax
 a5d:	3c 09                	cmp    $0x9,%al
  n = 0;
 a5f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 a64:	77 1f                	ja     a85 <atoi+0x35>
 a66:	8d 76 00             	lea    0x0(%esi),%esi
 a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 a70:	8d 04 80             	lea    (%eax,%eax,4),%eax
 a73:	83 c1 01             	add    $0x1,%ecx
 a76:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 a7a:	0f be 11             	movsbl (%ecx),%edx
 a7d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 a80:	80 fb 09             	cmp    $0x9,%bl
 a83:	76 eb                	jbe    a70 <atoi+0x20>
  return n;
}
 a85:	5b                   	pop    %ebx
 a86:	5d                   	pop    %ebp
 a87:	c3                   	ret    
 a88:	90                   	nop
 a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	56                   	push   %esi
 a94:	53                   	push   %ebx
 a95:	8b 5d 10             	mov    0x10(%ebp),%ebx
 a98:	8b 45 08             	mov    0x8(%ebp),%eax
 a9b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a9e:	85 db                	test   %ebx,%ebx
 aa0:	7e 14                	jle    ab6 <memmove+0x26>
 aa2:	31 d2                	xor    %edx,%edx
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 aa8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 aac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 aaf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 ab2:	39 d3                	cmp    %edx,%ebx
 ab4:	75 f2                	jne    aa8 <memmove+0x18>
  return vdst;
}
 ab6:	5b                   	pop    %ebx
 ab7:	5e                   	pop    %esi
 ab8:	5d                   	pop    %ebp
 ab9:	c3                   	ret    

00000aba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 aba:	b8 01 00 00 00       	mov    $0x1,%eax
 abf:	cd 40                	int    $0x40
 ac1:	c3                   	ret    

00000ac2 <exit>:
SYSCALL(exit)
 ac2:	b8 02 00 00 00       	mov    $0x2,%eax
 ac7:	cd 40                	int    $0x40
 ac9:	c3                   	ret    

00000aca <wait>:
SYSCALL(wait)
 aca:	b8 03 00 00 00       	mov    $0x3,%eax
 acf:	cd 40                	int    $0x40
 ad1:	c3                   	ret    

00000ad2 <pipe>:
SYSCALL(pipe)
 ad2:	b8 04 00 00 00       	mov    $0x4,%eax
 ad7:	cd 40                	int    $0x40
 ad9:	c3                   	ret    

00000ada <read>:
SYSCALL(read)
 ada:	b8 05 00 00 00       	mov    $0x5,%eax
 adf:	cd 40                	int    $0x40
 ae1:	c3                   	ret    

00000ae2 <write>:
SYSCALL(write)
 ae2:	b8 10 00 00 00       	mov    $0x10,%eax
 ae7:	cd 40                	int    $0x40
 ae9:	c3                   	ret    

00000aea <close>:
SYSCALL(close)
 aea:	b8 15 00 00 00       	mov    $0x15,%eax
 aef:	cd 40                	int    $0x40
 af1:	c3                   	ret    

00000af2 <kill>:
SYSCALL(kill)
 af2:	b8 06 00 00 00       	mov    $0x6,%eax
 af7:	cd 40                	int    $0x40
 af9:	c3                   	ret    

00000afa <exec>:
SYSCALL(exec)
 afa:	b8 07 00 00 00       	mov    $0x7,%eax
 aff:	cd 40                	int    $0x40
 b01:	c3                   	ret    

00000b02 <open>:
SYSCALL(open)
 b02:	b8 0f 00 00 00       	mov    $0xf,%eax
 b07:	cd 40                	int    $0x40
 b09:	c3                   	ret    

00000b0a <mknod>:
SYSCALL(mknod)
 b0a:	b8 11 00 00 00       	mov    $0x11,%eax
 b0f:	cd 40                	int    $0x40
 b11:	c3                   	ret    

00000b12 <unlink>:
SYSCALL(unlink)
 b12:	b8 12 00 00 00       	mov    $0x12,%eax
 b17:	cd 40                	int    $0x40
 b19:	c3                   	ret    

00000b1a <fstat>:
SYSCALL(fstat)
 b1a:	b8 08 00 00 00       	mov    $0x8,%eax
 b1f:	cd 40                	int    $0x40
 b21:	c3                   	ret    

00000b22 <link>:
SYSCALL(link)
 b22:	b8 13 00 00 00       	mov    $0x13,%eax
 b27:	cd 40                	int    $0x40
 b29:	c3                   	ret    

00000b2a <mkdir>:
SYSCALL(mkdir)
 b2a:	b8 14 00 00 00       	mov    $0x14,%eax
 b2f:	cd 40                	int    $0x40
 b31:	c3                   	ret    

00000b32 <chdir>:
SYSCALL(chdir)
 b32:	b8 09 00 00 00       	mov    $0x9,%eax
 b37:	cd 40                	int    $0x40
 b39:	c3                   	ret    

00000b3a <dup>:
SYSCALL(dup)
 b3a:	b8 0a 00 00 00       	mov    $0xa,%eax
 b3f:	cd 40                	int    $0x40
 b41:	c3                   	ret    

00000b42 <getpid>:
SYSCALL(getpid)
 b42:	b8 0b 00 00 00       	mov    $0xb,%eax
 b47:	cd 40                	int    $0x40
 b49:	c3                   	ret    

00000b4a <sbrk>:
SYSCALL(sbrk)
 b4a:	b8 0c 00 00 00       	mov    $0xc,%eax
 b4f:	cd 40                	int    $0x40
 b51:	c3                   	ret    

00000b52 <sleep>:
SYSCALL(sleep)
 b52:	b8 0d 00 00 00       	mov    $0xd,%eax
 b57:	cd 40                	int    $0x40
 b59:	c3                   	ret    

00000b5a <uptime>:
SYSCALL(uptime)
 b5a:	b8 0e 00 00 00       	mov    $0xe,%eax
 b5f:	cd 40                	int    $0x40
 b61:	c3                   	ret    

00000b62 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
 b62:	b8 16 00 00 00       	mov    $0x16,%eax
 b67:	cd 40                	int    $0x40
 b69:	c3                   	ret    

00000b6a <printProcDump>:
SYSCALL(printProcDump)
 b6a:	b8 17 00 00 00       	mov    $0x17,%eax
 b6f:	cd 40                	int    $0x40
 b71:	c3                   	ret    
 b72:	66 90                	xchg   %ax,%ax
 b74:	66 90                	xchg   %ax,%ax
 b76:	66 90                	xchg   %ax,%ax
 b78:	66 90                	xchg   %ax,%ax
 b7a:	66 90                	xchg   %ax,%ax
 b7c:	66 90                	xchg   %ax,%ax
 b7e:	66 90                	xchg   %ax,%ax

00000b80 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b89:	85 d2                	test   %edx,%edx
{
 b8b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 b8e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 b90:	79 76                	jns    c08 <printint+0x88>
 b92:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 b96:	74 70                	je     c08 <printint+0x88>
    x = -xx;
 b98:	f7 d8                	neg    %eax
    neg = 1;
 b9a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 ba1:	31 f6                	xor    %esi,%esi
 ba3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 ba6:	eb 0a                	jmp    bb2 <printint+0x32>
 ba8:	90                   	nop
 ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 bb0:	89 fe                	mov    %edi,%esi
 bb2:	31 d2                	xor    %edx,%edx
 bb4:	8d 7e 01             	lea    0x1(%esi),%edi
 bb7:	f7 f1                	div    %ecx
 bb9:	0f b6 92 18 12 00 00 	movzbl 0x1218(%edx),%edx
  }while((x /= base) != 0);
 bc0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 bc2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 bc5:	75 e9                	jne    bb0 <printint+0x30>
  if(neg)
 bc7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 bca:	85 c0                	test   %eax,%eax
 bcc:	74 08                	je     bd6 <printint+0x56>
    buf[i++] = '-';
 bce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 bd3:	8d 7e 02             	lea    0x2(%esi),%edi
 bd6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 bda:	8b 7d c0             	mov    -0x40(%ebp),%edi
 bdd:	8d 76 00             	lea    0x0(%esi),%esi
 be0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 be3:	83 ec 04             	sub    $0x4,%esp
 be6:	83 ee 01             	sub    $0x1,%esi
 be9:	6a 01                	push   $0x1
 beb:	53                   	push   %ebx
 bec:	57                   	push   %edi
 bed:	88 45 d7             	mov    %al,-0x29(%ebp)
 bf0:	e8 ed fe ff ff       	call   ae2 <write>

  while(--i >= 0)
 bf5:	83 c4 10             	add    $0x10,%esp
 bf8:	39 de                	cmp    %ebx,%esi
 bfa:	75 e4                	jne    be0 <printint+0x60>
    putc(fd, buf[i]);
}
 bfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 bff:	5b                   	pop    %ebx
 c00:	5e                   	pop    %esi
 c01:	5f                   	pop    %edi
 c02:	5d                   	pop    %ebp
 c03:	c3                   	ret    
 c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 c08:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 c0f:	eb 90                	jmp    ba1 <printint+0x21>
 c11:	eb 0d                	jmp    c20 <printf>
 c13:	90                   	nop
 c14:	90                   	nop
 c15:	90                   	nop
 c16:	90                   	nop
 c17:	90                   	nop
 c18:	90                   	nop
 c19:	90                   	nop
 c1a:	90                   	nop
 c1b:	90                   	nop
 c1c:	90                   	nop
 c1d:	90                   	nop
 c1e:	90                   	nop
 c1f:	90                   	nop

00000c20 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 c20:	55                   	push   %ebp
 c21:	89 e5                	mov    %esp,%ebp
 c23:	57                   	push   %edi
 c24:	56                   	push   %esi
 c25:	53                   	push   %ebx
 c26:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c29:	8b 75 0c             	mov    0xc(%ebp),%esi
 c2c:	0f b6 1e             	movzbl (%esi),%ebx
 c2f:	84 db                	test   %bl,%bl
 c31:	0f 84 b3 00 00 00    	je     cea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 c37:	8d 45 10             	lea    0x10(%ebp),%eax
 c3a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 c3d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 c3f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 c42:	eb 2f                	jmp    c73 <printf+0x53>
 c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 c48:	83 f8 25             	cmp    $0x25,%eax
 c4b:	0f 84 a7 00 00 00    	je     cf8 <printf+0xd8>
  write(fd, &c, 1);
 c51:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 c54:	83 ec 04             	sub    $0x4,%esp
 c57:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 c5a:	6a 01                	push   $0x1
 c5c:	50                   	push   %eax
 c5d:	ff 75 08             	pushl  0x8(%ebp)
 c60:	e8 7d fe ff ff       	call   ae2 <write>
 c65:	83 c4 10             	add    $0x10,%esp
 c68:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 c6b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 c6f:	84 db                	test   %bl,%bl
 c71:	74 77                	je     cea <printf+0xca>
    if(state == 0){
 c73:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 c75:	0f be cb             	movsbl %bl,%ecx
 c78:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c7b:	74 cb                	je     c48 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c7d:	83 ff 25             	cmp    $0x25,%edi
 c80:	75 e6                	jne    c68 <printf+0x48>
      if(c == 'd'){
 c82:	83 f8 64             	cmp    $0x64,%eax
 c85:	0f 84 05 01 00 00    	je     d90 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c8b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c91:	83 f9 70             	cmp    $0x70,%ecx
 c94:	74 72                	je     d08 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c96:	83 f8 73             	cmp    $0x73,%eax
 c99:	0f 84 99 00 00 00    	je     d38 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c9f:	83 f8 63             	cmp    $0x63,%eax
 ca2:	0f 84 08 01 00 00    	je     db0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ca8:	83 f8 25             	cmp    $0x25,%eax
 cab:	0f 84 ef 00 00 00    	je     da0 <printf+0x180>
  write(fd, &c, 1);
 cb1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 cb4:	83 ec 04             	sub    $0x4,%esp
 cb7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 cbb:	6a 01                	push   $0x1
 cbd:	50                   	push   %eax
 cbe:	ff 75 08             	pushl  0x8(%ebp)
 cc1:	e8 1c fe ff ff       	call   ae2 <write>
 cc6:	83 c4 0c             	add    $0xc,%esp
 cc9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 ccc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 ccf:	6a 01                	push   $0x1
 cd1:	50                   	push   %eax
 cd2:	ff 75 08             	pushl  0x8(%ebp)
 cd5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 cd8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 cda:	e8 03 fe ff ff       	call   ae2 <write>
  for(i = 0; fmt[i]; i++){
 cdf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 ce3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 ce6:	84 db                	test   %bl,%bl
 ce8:	75 89                	jne    c73 <printf+0x53>
    }
  }
}
 cea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 ced:	5b                   	pop    %ebx
 cee:	5e                   	pop    %esi
 cef:	5f                   	pop    %edi
 cf0:	5d                   	pop    %ebp
 cf1:	c3                   	ret    
 cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 cf8:	bf 25 00 00 00       	mov    $0x25,%edi
 cfd:	e9 66 ff ff ff       	jmp    c68 <printf+0x48>
 d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 d08:	83 ec 0c             	sub    $0xc,%esp
 d0b:	b9 10 00 00 00       	mov    $0x10,%ecx
 d10:	6a 00                	push   $0x0
 d12:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 d15:	8b 45 08             	mov    0x8(%ebp),%eax
 d18:	8b 17                	mov    (%edi),%edx
 d1a:	e8 61 fe ff ff       	call   b80 <printint>
        ap++;
 d1f:	89 f8                	mov    %edi,%eax
 d21:	83 c4 10             	add    $0x10,%esp
      state = 0;
 d24:	31 ff                	xor    %edi,%edi
        ap++;
 d26:	83 c0 04             	add    $0x4,%eax
 d29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 d2c:	e9 37 ff ff ff       	jmp    c68 <printf+0x48>
 d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 d38:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 d3b:	8b 08                	mov    (%eax),%ecx
        ap++;
 d3d:	83 c0 04             	add    $0x4,%eax
 d40:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 d43:	85 c9                	test   %ecx,%ecx
 d45:	0f 84 8e 00 00 00    	je     dd9 <printf+0x1b9>
        while(*s != 0){
 d4b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 d4e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 d50:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 d52:	84 c0                	test   %al,%al
 d54:	0f 84 0e ff ff ff    	je     c68 <printf+0x48>
 d5a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 d5d:	89 de                	mov    %ebx,%esi
 d5f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 d62:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 d65:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 d68:	83 ec 04             	sub    $0x4,%esp
          s++;
 d6b:	83 c6 01             	add    $0x1,%esi
 d6e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 d71:	6a 01                	push   $0x1
 d73:	57                   	push   %edi
 d74:	53                   	push   %ebx
 d75:	e8 68 fd ff ff       	call   ae2 <write>
        while(*s != 0){
 d7a:	0f b6 06             	movzbl (%esi),%eax
 d7d:	83 c4 10             	add    $0x10,%esp
 d80:	84 c0                	test   %al,%al
 d82:	75 e4                	jne    d68 <printf+0x148>
 d84:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 d87:	31 ff                	xor    %edi,%edi
 d89:	e9 da fe ff ff       	jmp    c68 <printf+0x48>
 d8e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 d90:	83 ec 0c             	sub    $0xc,%esp
 d93:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d98:	6a 01                	push   $0x1
 d9a:	e9 73 ff ff ff       	jmp    d12 <printf+0xf2>
 d9f:	90                   	nop
  write(fd, &c, 1);
 da0:	83 ec 04             	sub    $0x4,%esp
 da3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 da6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 da9:	6a 01                	push   $0x1
 dab:	e9 21 ff ff ff       	jmp    cd1 <printf+0xb1>
        putc(fd, *ap);
 db0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 db3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 db6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 db8:	6a 01                	push   $0x1
        ap++;
 dba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 dbd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 dc0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 dc3:	50                   	push   %eax
 dc4:	ff 75 08             	pushl  0x8(%ebp)
 dc7:	e8 16 fd ff ff       	call   ae2 <write>
        ap++;
 dcc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 dcf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 dd2:	31 ff                	xor    %edi,%edi
 dd4:	e9 8f fe ff ff       	jmp    c68 <printf+0x48>
          s = "(null)";
 dd9:	bb 10 12 00 00       	mov    $0x1210,%ebx
        while(*s != 0){
 dde:	b8 28 00 00 00       	mov    $0x28,%eax
 de3:	e9 72 ff ff ff       	jmp    d5a <printf+0x13a>
 de8:	66 90                	xchg   %ax,%ax
 dea:	66 90                	xchg   %ax,%ax
 dec:	66 90                	xchg   %ax,%ax
 dee:	66 90                	xchg   %ax,%ax

00000df0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 df0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 df1:	a1 34 16 00 00       	mov    0x1634,%eax
{
 df6:	89 e5                	mov    %esp,%ebp
 df8:	57                   	push   %edi
 df9:	56                   	push   %esi
 dfa:	53                   	push   %ebx
 dfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 dfe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 e08:	39 c8                	cmp    %ecx,%eax
 e0a:	8b 10                	mov    (%eax),%edx
 e0c:	73 32                	jae    e40 <free+0x50>
 e0e:	39 d1                	cmp    %edx,%ecx
 e10:	72 04                	jb     e16 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e12:	39 d0                	cmp    %edx,%eax
 e14:	72 32                	jb     e48 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 e16:	8b 73 fc             	mov    -0x4(%ebx),%esi
 e19:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 e1c:	39 fa                	cmp    %edi,%edx
 e1e:	74 30                	je     e50 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 e20:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e23:	8b 50 04             	mov    0x4(%eax),%edx
 e26:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e29:	39 f1                	cmp    %esi,%ecx
 e2b:	74 3a                	je     e67 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 e2d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 e2f:	a3 34 16 00 00       	mov    %eax,0x1634
}
 e34:	5b                   	pop    %ebx
 e35:	5e                   	pop    %esi
 e36:	5f                   	pop    %edi
 e37:	5d                   	pop    %ebp
 e38:	c3                   	ret    
 e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 e40:	39 d0                	cmp    %edx,%eax
 e42:	72 04                	jb     e48 <free+0x58>
 e44:	39 d1                	cmp    %edx,%ecx
 e46:	72 ce                	jb     e16 <free+0x26>
{
 e48:	89 d0                	mov    %edx,%eax
 e4a:	eb bc                	jmp    e08 <free+0x18>
 e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 e50:	03 72 04             	add    0x4(%edx),%esi
 e53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 e56:	8b 10                	mov    (%eax),%edx
 e58:	8b 12                	mov    (%edx),%edx
 e5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 e5d:	8b 50 04             	mov    0x4(%eax),%edx
 e60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 e63:	39 f1                	cmp    %esi,%ecx
 e65:	75 c6                	jne    e2d <free+0x3d>
    p->s.size += bp->s.size;
 e67:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 e6a:	a3 34 16 00 00       	mov    %eax,0x1634
    p->s.size += bp->s.size;
 e6f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 e72:	8b 53 f8             	mov    -0x8(%ebx),%edx
 e75:	89 10                	mov    %edx,(%eax)
}
 e77:	5b                   	pop    %ebx
 e78:	5e                   	pop    %esi
 e79:	5f                   	pop    %edi
 e7a:	5d                   	pop    %ebp
 e7b:	c3                   	ret    
 e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000e80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 e80:	55                   	push   %ebp
 e81:	89 e5                	mov    %esp,%ebp
 e83:	57                   	push   %edi
 e84:	56                   	push   %esi
 e85:	53                   	push   %ebx
 e86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 e8c:	8b 15 34 16 00 00    	mov    0x1634,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e92:	8d 78 07             	lea    0x7(%eax),%edi
 e95:	c1 ef 03             	shr    $0x3,%edi
 e98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 e9b:	85 d2                	test   %edx,%edx
 e9d:	0f 84 9d 00 00 00    	je     f40 <malloc+0xc0>
 ea3:	8b 02                	mov    (%edx),%eax
 ea5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ea8:	39 cf                	cmp    %ecx,%edi
 eaa:	76 6c                	jbe    f18 <malloc+0x98>
 eac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 eb2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 eb7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 eba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ec1:	eb 0e                	jmp    ed1 <malloc+0x51>
 ec3:	90                   	nop
 ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ec8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 eca:	8b 48 04             	mov    0x4(%eax),%ecx
 ecd:	39 f9                	cmp    %edi,%ecx
 ecf:	73 47                	jae    f18 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ed1:	39 05 34 16 00 00    	cmp    %eax,0x1634
 ed7:	89 c2                	mov    %eax,%edx
 ed9:	75 ed                	jne    ec8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 edb:	83 ec 0c             	sub    $0xc,%esp
 ede:	56                   	push   %esi
 edf:	e8 66 fc ff ff       	call   b4a <sbrk>
  if(p == (char*)-1)
 ee4:	83 c4 10             	add    $0x10,%esp
 ee7:	83 f8 ff             	cmp    $0xffffffff,%eax
 eea:	74 1c                	je     f08 <malloc+0x88>
  hp->s.size = nu;
 eec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 eef:	83 ec 0c             	sub    $0xc,%esp
 ef2:	83 c0 08             	add    $0x8,%eax
 ef5:	50                   	push   %eax
 ef6:	e8 f5 fe ff ff       	call   df0 <free>
  return freep;
 efb:	8b 15 34 16 00 00    	mov    0x1634,%edx
      if((p = morecore(nunits)) == 0)
 f01:	83 c4 10             	add    $0x10,%esp
 f04:	85 d2                	test   %edx,%edx
 f06:	75 c0                	jne    ec8 <malloc+0x48>
        return 0;
  }
}
 f08:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 f0b:	31 c0                	xor    %eax,%eax
}
 f0d:	5b                   	pop    %ebx
 f0e:	5e                   	pop    %esi
 f0f:	5f                   	pop    %edi
 f10:	5d                   	pop    %ebp
 f11:	c3                   	ret    
 f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 f18:	39 cf                	cmp    %ecx,%edi
 f1a:	74 54                	je     f70 <malloc+0xf0>
        p->s.size -= nunits;
 f1c:	29 f9                	sub    %edi,%ecx
 f1e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 f21:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 f24:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 f27:	89 15 34 16 00 00    	mov    %edx,0x1634
}
 f2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 f30:	83 c0 08             	add    $0x8,%eax
}
 f33:	5b                   	pop    %ebx
 f34:	5e                   	pop    %esi
 f35:	5f                   	pop    %edi
 f36:	5d                   	pop    %ebp
 f37:	c3                   	ret    
 f38:	90                   	nop
 f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 f40:	c7 05 34 16 00 00 38 	movl   $0x1638,0x1634
 f47:	16 00 00 
 f4a:	c7 05 38 16 00 00 38 	movl   $0x1638,0x1638
 f51:	16 00 00 
    base.s.size = 0;
 f54:	b8 38 16 00 00       	mov    $0x1638,%eax
 f59:	c7 05 3c 16 00 00 00 	movl   $0x0,0x163c
 f60:	00 00 00 
 f63:	e9 44 ff ff ff       	jmp    eac <malloc+0x2c>
 f68:	90                   	nop
 f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 f70:	8b 08                	mov    (%eax),%ecx
 f72:	89 0a                	mov    %ecx,(%edx)
 f74:	eb b1                	jmp    f27 <malloc+0xa7>
