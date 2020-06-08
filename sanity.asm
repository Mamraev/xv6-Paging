
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


  int freeMem = getNumberOfFreePages();
   f:	e8 8e 09 00 00       	call   9a2 <getNumberOfFreePages>
  
  //  Cow Tests:
  makeTest(cowPhysicalTest);
  14:	83 ec 0c             	sub    $0xc,%esp
  int freeMem = getNumberOfFreePages();
  17:	89 c3                	mov    %eax,%ebx
  makeTest(cowPhysicalTest);
  19:	68 50 00 00 00       	push   $0x50
  1e:	e8 4d 06 00 00       	call   670 <makeTest>
  //makeTest(cowSwapFile_pageSeperationTest);
  //makeTest(cowSwapFile_killedChiledTest);
  //makeTest(cowSwapFile_maxPhyInChildTest);
  
  // General Page Tests:
  makeTest(PhysicalMemTest);
  23:	c7 04 24 40 01 00 00 	movl   $0x140,(%esp)
  2a:	e8 41 06 00 00       	call   670 <makeTest>
  makeTest(SwapFileTest);
  2f:	c7 04 24 00 02 00 00 	movl   $0x200,(%esp)
  36:	e8 35 06 00 00       	call   670 <makeTest>
  memLeakTest(freeMem);
  3b:	89 1c 24             	mov    %ebx,(%esp)
  3e:	e8 cd 05 00 00       	call   610 <memLeakTest>
  exit();
  43:	e8 ba 08 00 00       	call   902 <exit>
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <cowPhysicalTest>:
cowPhysicalTest(){
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  54:	83 ec 1c             	sub    $0x1c,%esp
  printf(1,"cowPhysicalTest :");
  57:	68 a8 0d 00 00       	push   $0xda8
  5c:	6a 01                	push   $0x1
  5e:	e8 ed 09 00 00       	call   a50 <printf>
  for(i = 0; i < 3; i++){
  63:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  6a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  6d:	83 c4 10             	add    $0x10,%esp
  70:	83 f8 02             	cmp    $0x2,%eax
  73:	7f 37                	jg     ac <cowPhysicalTest+0x5c>
  75:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
  78:	83 ec 0c             	sub    $0xc,%esp
  7b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  7e:	68 00 10 00 00       	push   $0x1000
  83:	e8 02 09 00 00       	call   98a <sbrk>
  88:	89 44 9d ec          	mov    %eax,-0x14(%ebp,%ebx,4)
    *lst[i]=i;
  8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  for(i = 0; i < 3; i++){
  8f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
  92:	8b 55 e8             	mov    -0x18(%ebp),%edx
  95:	8b 44 85 ec          	mov    -0x14(%ebp,%eax,4),%eax
  99:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 3; i++){
  9b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  9e:	83 c0 01             	add    $0x1,%eax
  a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  a7:	83 f8 02             	cmp    $0x2,%eax
  aa:	7e cc                	jle    78 <cowPhysicalTest+0x28>
  int pid = fork();
  ac:	e8 49 08 00 00       	call   8fa <fork>
  sleep(10);
  b1:	83 ec 0c             	sub    $0xc,%esp
  int pid = fork();
  b4:	89 c3                	mov    %eax,%ebx
  sleep(10);
  b6:	6a 0a                	push   $0xa
  b8:	e8 d5 08 00 00       	call   992 <sleep>
  if(pid==0){
  bd:	83 c4 10             	add    $0x10,%esp
  c0:	85 db                	test   %ebx,%ebx
  c2:	75 54                	jne    118 <cowPhysicalTest+0xc8>
    for(i = 0; i < 3; i++){
  c4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  ce:	83 f8 02             	cmp    $0x2,%eax
  d1:	7e 16                	jle    e9 <cowPhysicalTest+0x99>
  d3:	eb 4f                	jmp    124 <cowPhysicalTest+0xd4>
  d5:	8d 76 00             	lea    0x0(%esi),%esi
  d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  db:	83 c0 01             	add    $0x1,%eax
  de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  e4:	83 f8 02             	cmp    $0x2,%eax
  e7:	7f 3b                	jg     124 <cowPhysicalTest+0xd4>
      if(*lst[i]!=i){
  e9:	8b 55 e8             	mov    -0x18(%ebp),%edx
  ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  ef:	8b 54 95 ec          	mov    -0x14(%ebp,%edx,4),%edx
  f3:	39 02                	cmp    %eax,(%edx)
  f5:	74 e1                	je     d8 <cowPhysicalTest+0x88>
        printf(1," FAILED");
  f7:	83 ec 08             	sub    $0x8,%esp
  fa:	68 ba 0d 00 00       	push   $0xdba
  ff:	6a 01                	push   $0x1
 101:	e8 4a 09 00 00       	call   a50 <printf>
        return -1;
 106:	83 c4 10             	add    $0x10,%esp
 109:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 10e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 111:	c9                   	leave  
 112:	c3                   	ret    
 113:	90                   	nop
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
 118:	e8 ed 07 00 00       	call   90a <wait>
  return 0;
 11d:	31 c0                	xor    %eax,%eax
}
 11f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 122:	c9                   	leave  
 123:	c3                   	ret    
    *lst[1] = 66;
 124:	8b 45 f0             	mov    -0x10(%ebp),%eax
    sleep(10);
 127:	83 ec 0c             	sub    $0xc,%esp
    *lst[1] = 66;
 12a:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
    sleep(10);
 130:	6a 0a                	push   $0xa
 132:	e8 5b 08 00 00       	call   992 <sleep>
    exit();
 137:	e8 c6 07 00 00       	call   902 <exit>
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <PhysicalMemTest>:
PhysicalMemTest(){
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	83 ec 2c             	sub    $0x2c,%esp
  printf(1,"PhysicalMemTest :");
 147:	68 c2 0d 00 00       	push   $0xdc2
 14c:	6a 01                	push   $0x1
 14e:	e8 fd 08 00 00       	call   a50 <printf>
  for(i = 0; i < 5; i++){
 153:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 15a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15d:	83 c4 10             	add    $0x10,%esp
 160:	83 f8 04             	cmp    $0x4,%eax
 163:	7f 37                	jg     19c <PhysicalMemTest+0x5c>
 165:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 168:	83 ec 0c             	sub    $0xc,%esp
 16b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 16e:	68 00 10 00 00       	push   $0x1000
 173:	e8 12 08 00 00       	call   98a <sbrk>
 178:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
    *lst[i]=i;
 17c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  for(i = 0; i < 5; i++){
 17f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 182:	8b 55 e0             	mov    -0x20(%ebp),%edx
 185:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
 189:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 5; i++){
 18b:	8b 45 e0             	mov    -0x20(%ebp),%eax
 18e:	83 c0 01             	add    $0x1,%eax
 191:	89 45 e0             	mov    %eax,-0x20(%ebp)
 194:	8b 45 e0             	mov    -0x20(%ebp),%eax
 197:	83 f8 04             	cmp    $0x4,%eax
 19a:	7e cc                	jle    168 <PhysicalMemTest+0x28>
  for(i = 0; i < 5; i++){
 19c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 1a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1a6:	83 f8 04             	cmp    $0x4,%eax
 1a9:	7e 16                	jle    1c1 <PhysicalMemTest+0x81>
 1ab:	eb 43                	jmp    1f0 <PhysicalMemTest+0xb0>
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1b3:	83 c0 01             	add    $0x1,%eax
 1b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
 1b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1bc:	83 f8 04             	cmp    $0x4,%eax
 1bf:	7f 2f                	jg     1f0 <PhysicalMemTest+0xb0>
    if(*lst[i]!=i){
 1c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
 1c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1c7:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
 1cb:	39 02                	cmp    %eax,(%edx)
 1cd:	74 e1                	je     1b0 <PhysicalMemTest+0x70>
      printf(1," FAILED");
 1cf:	83 ec 08             	sub    $0x8,%esp
 1d2:	68 ba 0d 00 00       	push   $0xdba
 1d7:	6a 01                	push   $0x1
 1d9:	e8 72 08 00 00       	call   a50 <printf>
 1de:	83 c4 10             	add    $0x10,%esp
 1e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 1e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e9:	c9                   	leave  
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1f0:	31 c0                	xor    %eax,%eax
}
 1f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <SwapFileTest>:
SwapFileTest(){
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"SwapFileTest :");
 207:	68 d4 0d 00 00       	push   $0xdd4
 20c:	6a 01                	push   $0x1
 20e:	e8 3d 08 00 00       	call   a50 <printf>
  for(i = 0; i < 20; i++){
 213:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 21a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 21d:	83 c4 10             	add    $0x10,%esp
 220:	83 f8 13             	cmp    $0x13,%eax
 223:	7f 37                	jg     25c <SwapFileTest+0x5c>
 225:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 228:	83 ec 0c             	sub    $0xc,%esp
 22b:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 22e:	68 00 10 00 00       	push   $0x1000
 233:	e8 52 07 00 00       	call   98a <sbrk>
 238:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 23c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 23f:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 242:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 245:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 249:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 24b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 24e:	83 c0 01             	add    $0x1,%eax
 251:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 254:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 257:	83 f8 13             	cmp    $0x13,%eax
 25a:	7e cc                	jle    228 <SwapFileTest+0x28>
  for(i = 0; i < 20; i++){
 25c:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 263:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 266:	83 f8 13             	cmp    $0x13,%eax
 269:	7e 16                	jle    281 <SwapFileTest+0x81>
 26b:	eb 43                	jmp    2b0 <SwapFileTest+0xb0>
 26d:	8d 76 00             	lea    0x0(%esi),%esi
 270:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 273:	83 c0 01             	add    $0x1,%eax
 276:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 279:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 27c:	83 f8 13             	cmp    $0x13,%eax
 27f:	7f 2f                	jg     2b0 <SwapFileTest+0xb0>
    if(*lst[i]!=i){
 281:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 284:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 287:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 28b:	39 02                	cmp    %eax,(%edx)
 28d:	74 e1                	je     270 <SwapFileTest+0x70>
      printf(1," FAILED");
 28f:	83 ec 08             	sub    $0x8,%esp
 292:	68 ba 0d 00 00       	push   $0xdba
 297:	6a 01                	push   $0x1
 299:	e8 b2 07 00 00       	call   a50 <printf>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 2a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2a9:	c9                   	leave  
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2b0:	31 c0                	xor    %eax,%eax
}
 2b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2b5:	c9                   	leave  
 2b6:	c3                   	ret    
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <cowSwapFile_pageSeperationTest>:
cowSwapFile_pageSeperationTest(){
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	53                   	push   %ebx
 2c4:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_pageSeperationTest :");
 2c7:	68 24 0e 00 00       	push   $0xe24
 2cc:	6a 01                	push   $0x1
 2ce:	e8 7d 07 00 00       	call   a50 <printf>
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
 2f3:	e8 92 06 00 00       	call   98a <sbrk>
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
 31c:	e8 d9 05 00 00       	call   8fa <fork>
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
 344:	68 f6 0d 00 00       	push   $0xdf6
 349:	6a 01                	push   $0x1
 34b:	e8 00 07 00 00       	call   a50 <printf>
        printf(1," FAILED");
 350:	58                   	pop    %eax
 351:	5a                   	pop    %edx
 352:	68 ba 0d 00 00       	push   $0xdba
 357:	6a 01                	push   $0x1
 359:	e8 f2 06 00 00       	call   a50 <printf>
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
 370:	e8 95 05 00 00       	call   90a <wait>
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
 3a6:	68 e3 0d 00 00       	push   $0xde3
 3ab:	6a 01                	push   $0x1
 3ad:	e8 9e 06 00 00       	call   a50 <printf>
        printf(1," FAILED");
 3b2:	59                   	pop    %ecx
 3b3:	5b                   	pop    %ebx
 3b4:	68 ba 0d 00 00       	push   $0xdba
 3b9:	6a 01                	push   $0x1
 3bb:	e8 90 06 00 00       	call   a50 <printf>
 3c0:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 20; i++){
 3c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3c6:	83 c0 01             	add    $0x1,%eax
 3c9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 3cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 3cf:	83 f8 13             	cmp    $0x13,%eax
 3d2:	7e b7                	jle    38b <cowSwapFile_pageSeperationTest+0xcb>
    exit();
 3d4:	e8 29 05 00 00       	call   902 <exit>
 3d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003e0 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
  for(i = 0; i < 20; i++){
 3e4:	31 db                	xor    %ebx,%ebx
cowSwapFile_maxPhyInChildTest(){
 3e6:	83 ec 5c             	sub    $0x5c,%esp
  printf(1,"cowSwapFile_maxPhyInChildTest :");
 3e9:	68 48 0e 00 00       	push   $0xe48
 3ee:	6a 01                	push   $0x1
 3f0:	e8 5b 06 00 00       	call   a50 <printf>
 3f5:	83 c4 10             	add    $0x10,%esp
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 400:	83 ec 0c             	sub    $0xc,%esp
 403:	68 00 10 00 00       	push   $0x1000
 408:	e8 7d 05 00 00       	call   98a <sbrk>
 40d:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 411:	89 18                	mov    %ebx,(%eax)
  for(i = 0; i < 20; i++){
 413:	83 c3 01             	add    $0x1,%ebx
 416:	83 c4 10             	add    $0x10,%esp
 419:	83 fb 14             	cmp    $0x14,%ebx
 41c:	75 e2                	jne    400 <cowSwapFile_maxPhyInChildTest+0x20>
  int pid = fork();
 41e:	e8 d7 04 00 00       	call   8fa <fork>
  if(pid==0){
 423:	85 c0                	test   %eax,%eax
 425:	74 50                	je     477 <cowSwapFile_maxPhyInChildTest+0x97>
  wait();
 427:	e8 de 04 00 00       	call   90a <wait>
  for(j = 0; j < 20; j++){
 42c:	31 c0                	xor    %eax,%eax
 42e:	eb 08                	jmp    438 <cowSwapFile_maxPhyInChildTest+0x58>
 430:	83 c0 01             	add    $0x1,%eax
 433:	83 f8 14             	cmp    $0x14,%eax
 436:	74 38                	je     470 <cowSwapFile_maxPhyInChildTest+0x90>
      if(*lst[j]!=j){
 438:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 43c:	39 02                	cmp    %eax,(%edx)
 43e:	74 f0                	je     430 <cowSwapFile_maxPhyInChildTest+0x50>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 440:	83 ec 04             	sub    $0x4,%esp
 443:	6a 01                	push   $0x1
 445:	68 f6 0d 00 00       	push   $0xdf6
 44a:	6a 01                	push   $0x1
 44c:	e8 ff 05 00 00       	call   a50 <printf>
        printf(1," FAILED");
 451:	58                   	pop    %eax
 452:	5a                   	pop    %edx
 453:	68 ba 0d 00 00       	push   $0xdba
 458:	6a 01                	push   $0x1
 45a:	e8 f1 05 00 00       	call   a50 <printf>
        return -1;
 45f:	83 c4 10             	add    $0x10,%esp
 462:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 46a:	c9                   	leave  
 46b:	c3                   	ret    
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 470:	31 c0                	xor    %eax,%eax
}
 472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 475:	c9                   	leave  
 476:	c3                   	ret    
 477:	b8 46 00 00 00       	mov    $0x46,%eax
      *lst[i]= i + 50;
 47c:	8b 94 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%edx
 483:	89 02                	mov    %eax,(%edx)
 485:	83 e8 01             	sub    $0x1,%eax
    for(i = 20; i >= 0; i--){
 488:	83 f8 31             	cmp    $0x31,%eax
 48b:	75 ef                	jne    47c <cowSwapFile_maxPhyInChildTest+0x9c>
    exit();
 48d:	e8 70 04 00 00       	call   902 <exit>
 492:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	53                   	push   %ebx
 4a4:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"cowSwapFile_killedChiledTest :");
 4a7:	68 68 0e 00 00       	push   $0xe68
 4ac:	6a 01                	push   $0x1
 4ae:	e8 9d 05 00 00       	call   a50 <printf>
  for(i = 0; i < 20; i++){
 4b3:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 4ba:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4bd:	83 c4 10             	add    $0x10,%esp
 4c0:	83 f8 13             	cmp    $0x13,%eax
 4c3:	7f 37                	jg     4fc <cowSwapFile_killedChiledTest+0x5c>
 4c5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 4c8:	83 ec 0c             	sub    $0xc,%esp
 4cb:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 4ce:	68 00 10 00 00       	push   $0x1000
 4d3:	e8 b2 04 00 00       	call   98a <sbrk>
 4d8:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 4dc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 4df:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 4e2:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 4e5:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 4e9:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 4eb:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4ee:	83 c0 01             	add    $0x1,%eax
 4f1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 4f4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4f7:	83 f8 13             	cmp    $0x13,%eax
 4fa:	7e cc                	jle    4c8 <cowSwapFile_killedChiledTest+0x28>
  int pid = fork();
 4fc:	e8 f9 03 00 00       	call   8fa <fork>
  if(pid==0){
 501:	85 c0                	test   %eax,%eax
 503:	0f 85 c7 00 00 00    	jne    5d0 <cowSwapFile_killedChiledTest+0x130>
    for(i = 0; i < 20; i++){
 509:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 510:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 513:	83 f8 13             	cmp    $0x13,%eax
 516:	7e 19                	jle    531 <cowSwapFile_killedChiledTest+0x91>
 518:	eb 66                	jmp    580 <cowSwapFile_killedChiledTest+0xe0>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 520:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 523:	83 c0 01             	add    $0x1,%eax
 526:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 529:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 52c:	83 f8 13             	cmp    $0x13,%eax
 52f:	7f 4f                	jg     580 <cowSwapFile_killedChiledTest+0xe0>
      if(*lst[i]!=i){
 531:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 534:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 537:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 53b:	39 02                	cmp    %eax,(%edx)
 53d:	74 e1                	je     520 <cowSwapFile_killedChiledTest+0x80>
        printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
 53f:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 542:	83 ec 04             	sub    $0x4,%esp
 545:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 548:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 54c:	39 02                	cmp    %eax,(%edx)
 54e:	0f 95 c0             	setne  %al
 551:	0f b6 c0             	movzbl %al,%eax
 554:	50                   	push   %eax
 555:	68 e3 0d 00 00       	push   $0xde3
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 55a:	6a 01                	push   $0x1
 55c:	e8 ef 04 00 00       	call   a50 <printf>
        printf(1," FAILED");
 561:	58                   	pop    %eax
 562:	5a                   	pop    %edx
 563:	68 ba 0d 00 00       	push   $0xdba
 568:	6a 01                	push   $0x1
 56a:	e8 e1 04 00 00       	call   a50 <printf>
        return -1;
 56f:	83 c4 10             	add    $0x10,%esp
 572:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 577:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 57a:	c9                   	leave  
 57b:	c3                   	ret    
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < 20; i++){
 580:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 587:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 58a:	83 f8 13             	cmp    $0x13,%eax
 58d:	7e 1a                	jle    5a9 <cowSwapFile_killedChiledTest+0x109>
 58f:	eb 76                	jmp    607 <cowSwapFile_killedChiledTest+0x167>
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 598:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 59b:	83 c0 01             	add    $0x1,%eax
 59e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 5a1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5a4:	83 f8 13             	cmp    $0x13,%eax
 5a7:	7f 5e                	jg     607 <cowSwapFile_killedChiledTest+0x167>
      *lst[i] = 66;
 5a9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5ac:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 5b0:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(*lst[i]!=66){
 5b6:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 5b9:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 5bd:	83 38 42             	cmpl   $0x42,(%eax)
 5c0:	74 d6                	je     598 <cowSwapFile_killedChiledTest+0xf8>
 5c2:	e9 78 ff ff ff       	jmp    53f <cowSwapFile_killedChiledTest+0x9f>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  wait();
 5d0:	e8 35 03 00 00       	call   90a <wait>
  for(j = 0; j < 20; j++){
 5d5:	31 c0                	xor    %eax,%eax
 5d7:	eb 0f                	jmp    5e8 <cowSwapFile_killedChiledTest+0x148>
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e0:	83 c0 01             	add    $0x1,%eax
 5e3:	83 f8 14             	cmp    $0x14,%eax
 5e6:	74 18                	je     600 <cowSwapFile_killedChiledTest+0x160>
      if(*lst[j]!=j){
 5e8:	8b 54 85 a8          	mov    -0x58(%ebp,%eax,4),%edx
 5ec:	39 02                	cmp    %eax,(%edx)
 5ee:	74 f0                	je     5e0 <cowSwapFile_killedChiledTest+0x140>
        printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	6a 01                	push   $0x1
 5f5:	68 f6 0d 00 00       	push   $0xdf6
 5fa:	e9 5b ff ff ff       	jmp    55a <cowSwapFile_killedChiledTest+0xba>
 5ff:	90                   	nop
  return 0;
 600:	31 c0                	xor    %eax,%eax
}
 602:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 605:	c9                   	leave  
 606:	c3                   	ret    
    exit();
 607:	e8 f6 02 00 00       	call   902 <exit>
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000610 <memLeakTest>:
memLeakTest(int freeMem){
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	53                   	push   %ebx
 614:	83 ec 0c             	sub    $0xc,%esp
 617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(1,"memLeakTest :");
 61a:	68 0a 0e 00 00       	push   $0xe0a
 61f:	6a 01                	push   $0x1
 621:	e8 2a 04 00 00       	call   a50 <printf>
  if(freeMem != getNumberOfFreePages()){
 626:	e8 77 03 00 00       	call   9a2 <getNumberOfFreePages>
 62b:	83 c4 10             	add    $0x10,%esp
 62e:	39 d8                	cmp    %ebx,%eax
 630:	74 1e                	je     650 <memLeakTest+0x40>
      printf(1, "FAILED    expected: %d     got : %d\n",freeMem,getNumberOfFreePages());
 632:	e8 6b 03 00 00       	call   9a2 <getNumberOfFreePages>
 637:	50                   	push   %eax
 638:	53                   	push   %ebx
 639:	68 88 0e 00 00       	push   $0xe88
 63e:	6a 01                	push   $0x1
 640:	e8 0b 04 00 00       	call   a50 <printf>
 645:	83 c4 10             	add    $0x10,%esp
}
 648:	31 c0                	xor    %eax,%eax
 64a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 64d:	c9                   	leave  
 64e:	c3                   	ret    
 64f:	90                   	nop
    printf(1, "PASSED\n");
 650:	83 ec 08             	sub    $0x8,%esp
 653:	68 19 0e 00 00       	push   $0xe19
 658:	6a 01                	push   $0x1
 65a:	e8 f1 03 00 00       	call   a50 <printf>
 65f:	83 c4 10             	add    $0x10,%esp
}
 662:	31 c0                	xor    %eax,%eax
 664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 667:	c9                   	leave  
 668:	c3                   	ret    
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000670 <makeTest>:
makeTest(int (*test)()){
 670:	55                   	push   %ebp
 671:	89 e5                	mov    %esp,%ebp
 673:	53                   	push   %ebx
 674:	83 ec 04             	sub    $0x4,%esp
 677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int testerPid = fork();
 67a:	e8 7b 02 00 00       	call   8fa <fork>
  if(testerPid==0){
 67f:	85 c0                	test   %eax,%eax
 681:	74 09                	je     68c <makeTest+0x1c>
} 
 683:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 686:	c9                   	leave  
  wait();
 687:	e9 7e 02 00 00       	jmp    90a <wait>
    if(test()==0){
 68c:	ff d3                	call   *%ebx
 68e:	85 c0                	test   %eax,%eax
 690:	74 05                	je     697 <makeTest+0x27>
    exit();
 692:	e8 6b 02 00 00       	call   902 <exit>
      printf(1," PASSED\n");
 697:	50                   	push   %eax
 698:	50                   	push   %eax
 699:	68 18 0e 00 00       	push   $0xe18
 69e:	6a 01                	push   $0x1
 6a0:	e8 ab 03 00 00       	call   a50 <printf>
 6a5:	83 c4 10             	add    $0x10,%esp
 6a8:	eb e8                	jmp    692 <makeTest+0x22>
 6aa:	66 90                	xchg   %ax,%ax
 6ac:	66 90                	xchg   %ax,%ax
 6ae:	66 90                	xchg   %ax,%ax

000006b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	53                   	push   %ebx
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 6ba:	89 c2                	mov    %eax,%edx
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6c0:	83 c1 01             	add    $0x1,%ecx
 6c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 6c7:	83 c2 01             	add    $0x1,%edx
 6ca:	84 db                	test   %bl,%bl
 6cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 6cf:	75 ef                	jne    6c0 <strcpy+0x10>
    ;
  return os;
}
 6d1:	5b                   	pop    %ebx
 6d2:	5d                   	pop    %ebp
 6d3:	c3                   	ret    
 6d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	53                   	push   %ebx
 6e4:	8b 55 08             	mov    0x8(%ebp),%edx
 6e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 6ea:	0f b6 02             	movzbl (%edx),%eax
 6ed:	0f b6 19             	movzbl (%ecx),%ebx
 6f0:	84 c0                	test   %al,%al
 6f2:	75 1c                	jne    710 <strcmp+0x30>
 6f4:	eb 2a                	jmp    720 <strcmp+0x40>
 6f6:	8d 76 00             	lea    0x0(%esi),%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 700:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 703:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 706:	83 c1 01             	add    $0x1,%ecx
 709:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 70c:	84 c0                	test   %al,%al
 70e:	74 10                	je     720 <strcmp+0x40>
 710:	38 d8                	cmp    %bl,%al
 712:	74 ec                	je     700 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 714:	29 d8                	sub    %ebx,%eax
}
 716:	5b                   	pop    %ebx
 717:	5d                   	pop    %ebp
 718:	c3                   	ret    
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 720:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 722:	29 d8                	sub    %ebx,%eax
}
 724:	5b                   	pop    %ebx
 725:	5d                   	pop    %ebp
 726:	c3                   	ret    
 727:	89 f6                	mov    %esi,%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <strlen>:

uint
strlen(const char *s)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 736:	80 39 00             	cmpb   $0x0,(%ecx)
 739:	74 15                	je     750 <strlen+0x20>
 73b:	31 d2                	xor    %edx,%edx
 73d:	8d 76 00             	lea    0x0(%esi),%esi
 740:	83 c2 01             	add    $0x1,%edx
 743:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 747:	89 d0                	mov    %edx,%eax
 749:	75 f5                	jne    740 <strlen+0x10>
    ;
  return n;
}
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 750:	31 c0                	xor    %eax,%eax
}
 752:	5d                   	pop    %ebp
 753:	c3                   	ret    
 754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 75a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000760 <memset>:

void*
memset(void *dst, int c, uint n)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 767:	8b 4d 10             	mov    0x10(%ebp),%ecx
 76a:	8b 45 0c             	mov    0xc(%ebp),%eax
 76d:	89 d7                	mov    %edx,%edi
 76f:	fc                   	cld    
 770:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 772:	89 d0                	mov    %edx,%eax
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	89 f6                	mov    %esi,%esi
 779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000780 <strchr>:

char*
strchr(const char *s, char c)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	53                   	push   %ebx
 784:	8b 45 08             	mov    0x8(%ebp),%eax
 787:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 78a:	0f b6 10             	movzbl (%eax),%edx
 78d:	84 d2                	test   %dl,%dl
 78f:	74 1d                	je     7ae <strchr+0x2e>
    if(*s == c)
 791:	38 d3                	cmp    %dl,%bl
 793:	89 d9                	mov    %ebx,%ecx
 795:	75 0d                	jne    7a4 <strchr+0x24>
 797:	eb 17                	jmp    7b0 <strchr+0x30>
 799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7a0:	38 ca                	cmp    %cl,%dl
 7a2:	74 0c                	je     7b0 <strchr+0x30>
  for(; *s; s++)
 7a4:	83 c0 01             	add    $0x1,%eax
 7a7:	0f b6 10             	movzbl (%eax),%edx
 7aa:	84 d2                	test   %dl,%dl
 7ac:	75 f2                	jne    7a0 <strchr+0x20>
      return (char*)s;
  return 0;
 7ae:	31 c0                	xor    %eax,%eax
}
 7b0:	5b                   	pop    %ebx
 7b1:	5d                   	pop    %ebp
 7b2:	c3                   	ret    
 7b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007c0 <gets>:

char*
gets(char *buf, int max)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 7c6:	31 f6                	xor    %esi,%esi
 7c8:	89 f3                	mov    %esi,%ebx
{
 7ca:	83 ec 1c             	sub    $0x1c,%esp
 7cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 7d0:	eb 2f                	jmp    801 <gets+0x41>
 7d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 7d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7db:	83 ec 04             	sub    $0x4,%esp
 7de:	6a 01                	push   $0x1
 7e0:	50                   	push   %eax
 7e1:	6a 00                	push   $0x0
 7e3:	e8 32 01 00 00       	call   91a <read>
    if(cc < 1)
 7e8:	83 c4 10             	add    $0x10,%esp
 7eb:	85 c0                	test   %eax,%eax
 7ed:	7e 1c                	jle    80b <gets+0x4b>
      break;
    buf[i++] = c;
 7ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 7f3:	83 c7 01             	add    $0x1,%edi
 7f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 7f9:	3c 0a                	cmp    $0xa,%al
 7fb:	74 23                	je     820 <gets+0x60>
 7fd:	3c 0d                	cmp    $0xd,%al
 7ff:	74 1f                	je     820 <gets+0x60>
  for(i=0; i+1 < max; ){
 801:	83 c3 01             	add    $0x1,%ebx
 804:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 807:	89 fe                	mov    %edi,%esi
 809:	7c cd                	jl     7d8 <gets+0x18>
 80b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 80d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 810:	c6 03 00             	movb   $0x0,(%ebx)
}
 813:	8d 65 f4             	lea    -0xc(%ebp),%esp
 816:	5b                   	pop    %ebx
 817:	5e                   	pop    %esi
 818:	5f                   	pop    %edi
 819:	5d                   	pop    %ebp
 81a:	c3                   	ret    
 81b:	90                   	nop
 81c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 820:	8b 75 08             	mov    0x8(%ebp),%esi
 823:	8b 45 08             	mov    0x8(%ebp),%eax
 826:	01 de                	add    %ebx,%esi
 828:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 82a:	c6 03 00             	movb   $0x0,(%ebx)
}
 82d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 830:	5b                   	pop    %ebx
 831:	5e                   	pop    %esi
 832:	5f                   	pop    %edi
 833:	5d                   	pop    %ebp
 834:	c3                   	ret    
 835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000840 <stat>:

int
stat(const char *n, struct stat *st)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	56                   	push   %esi
 844:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 845:	83 ec 08             	sub    $0x8,%esp
 848:	6a 00                	push   $0x0
 84a:	ff 75 08             	pushl  0x8(%ebp)
 84d:	e8 f0 00 00 00       	call   942 <open>
  if(fd < 0)
 852:	83 c4 10             	add    $0x10,%esp
 855:	85 c0                	test   %eax,%eax
 857:	78 27                	js     880 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 859:	83 ec 08             	sub    $0x8,%esp
 85c:	ff 75 0c             	pushl  0xc(%ebp)
 85f:	89 c3                	mov    %eax,%ebx
 861:	50                   	push   %eax
 862:	e8 f3 00 00 00       	call   95a <fstat>
  close(fd);
 867:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 86a:	89 c6                	mov    %eax,%esi
  close(fd);
 86c:	e8 b9 00 00 00       	call   92a <close>
  return r;
 871:	83 c4 10             	add    $0x10,%esp
}
 874:	8d 65 f8             	lea    -0x8(%ebp),%esp
 877:	89 f0                	mov    %esi,%eax
 879:	5b                   	pop    %ebx
 87a:	5e                   	pop    %esi
 87b:	5d                   	pop    %ebp
 87c:	c3                   	ret    
 87d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 880:	be ff ff ff ff       	mov    $0xffffffff,%esi
 885:	eb ed                	jmp    874 <stat+0x34>
 887:	89 f6                	mov    %esi,%esi
 889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000890 <atoi>:

int
atoi(const char *s)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	53                   	push   %ebx
 894:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 897:	0f be 11             	movsbl (%ecx),%edx
 89a:	8d 42 d0             	lea    -0x30(%edx),%eax
 89d:	3c 09                	cmp    $0x9,%al
  n = 0;
 89f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 8a4:	77 1f                	ja     8c5 <atoi+0x35>
 8a6:	8d 76 00             	lea    0x0(%esi),%esi
 8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 8b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 8b3:	83 c1 01             	add    $0x1,%ecx
 8b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 8ba:	0f be 11             	movsbl (%ecx),%edx
 8bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 8c0:	80 fb 09             	cmp    $0x9,%bl
 8c3:	76 eb                	jbe    8b0 <atoi+0x20>
  return n;
}
 8c5:	5b                   	pop    %ebx
 8c6:	5d                   	pop    %ebp
 8c7:	c3                   	ret    
 8c8:	90                   	nop
 8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	56                   	push   %esi
 8d4:	53                   	push   %ebx
 8d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 8d8:	8b 45 08             	mov    0x8(%ebp),%eax
 8db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 8de:	85 db                	test   %ebx,%ebx
 8e0:	7e 14                	jle    8f6 <memmove+0x26>
 8e2:	31 d2                	xor    %edx,%edx
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 8e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 8ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 8ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 8f2:	39 d3                	cmp    %edx,%ebx
 8f4:	75 f2                	jne    8e8 <memmove+0x18>
  return vdst;
}
 8f6:	5b                   	pop    %ebx
 8f7:	5e                   	pop    %esi
 8f8:	5d                   	pop    %ebp
 8f9:	c3                   	ret    

000008fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 8fa:	b8 01 00 00 00       	mov    $0x1,%eax
 8ff:	cd 40                	int    $0x40
 901:	c3                   	ret    

00000902 <exit>:
SYSCALL(exit)
 902:	b8 02 00 00 00       	mov    $0x2,%eax
 907:	cd 40                	int    $0x40
 909:	c3                   	ret    

0000090a <wait>:
SYSCALL(wait)
 90a:	b8 03 00 00 00       	mov    $0x3,%eax
 90f:	cd 40                	int    $0x40
 911:	c3                   	ret    

00000912 <pipe>:
SYSCALL(pipe)
 912:	b8 04 00 00 00       	mov    $0x4,%eax
 917:	cd 40                	int    $0x40
 919:	c3                   	ret    

0000091a <read>:
SYSCALL(read)
 91a:	b8 05 00 00 00       	mov    $0x5,%eax
 91f:	cd 40                	int    $0x40
 921:	c3                   	ret    

00000922 <write>:
SYSCALL(write)
 922:	b8 10 00 00 00       	mov    $0x10,%eax
 927:	cd 40                	int    $0x40
 929:	c3                   	ret    

0000092a <close>:
SYSCALL(close)
 92a:	b8 15 00 00 00       	mov    $0x15,%eax
 92f:	cd 40                	int    $0x40
 931:	c3                   	ret    

00000932 <kill>:
SYSCALL(kill)
 932:	b8 06 00 00 00       	mov    $0x6,%eax
 937:	cd 40                	int    $0x40
 939:	c3                   	ret    

0000093a <exec>:
SYSCALL(exec)
 93a:	b8 07 00 00 00       	mov    $0x7,%eax
 93f:	cd 40                	int    $0x40
 941:	c3                   	ret    

00000942 <open>:
SYSCALL(open)
 942:	b8 0f 00 00 00       	mov    $0xf,%eax
 947:	cd 40                	int    $0x40
 949:	c3                   	ret    

0000094a <mknod>:
SYSCALL(mknod)
 94a:	b8 11 00 00 00       	mov    $0x11,%eax
 94f:	cd 40                	int    $0x40
 951:	c3                   	ret    

00000952 <unlink>:
SYSCALL(unlink)
 952:	b8 12 00 00 00       	mov    $0x12,%eax
 957:	cd 40                	int    $0x40
 959:	c3                   	ret    

0000095a <fstat>:
SYSCALL(fstat)
 95a:	b8 08 00 00 00       	mov    $0x8,%eax
 95f:	cd 40                	int    $0x40
 961:	c3                   	ret    

00000962 <link>:
SYSCALL(link)
 962:	b8 13 00 00 00       	mov    $0x13,%eax
 967:	cd 40                	int    $0x40
 969:	c3                   	ret    

0000096a <mkdir>:
SYSCALL(mkdir)
 96a:	b8 14 00 00 00       	mov    $0x14,%eax
 96f:	cd 40                	int    $0x40
 971:	c3                   	ret    

00000972 <chdir>:
SYSCALL(chdir)
 972:	b8 09 00 00 00       	mov    $0x9,%eax
 977:	cd 40                	int    $0x40
 979:	c3                   	ret    

0000097a <dup>:
SYSCALL(dup)
 97a:	b8 0a 00 00 00       	mov    $0xa,%eax
 97f:	cd 40                	int    $0x40
 981:	c3                   	ret    

00000982 <getpid>:
SYSCALL(getpid)
 982:	b8 0b 00 00 00       	mov    $0xb,%eax
 987:	cd 40                	int    $0x40
 989:	c3                   	ret    

0000098a <sbrk>:
SYSCALL(sbrk)
 98a:	b8 0c 00 00 00       	mov    $0xc,%eax
 98f:	cd 40                	int    $0x40
 991:	c3                   	ret    

00000992 <sleep>:
SYSCALL(sleep)
 992:	b8 0d 00 00 00       	mov    $0xd,%eax
 997:	cd 40                	int    $0x40
 999:	c3                   	ret    

0000099a <uptime>:
SYSCALL(uptime)
 99a:	b8 0e 00 00 00       	mov    $0xe,%eax
 99f:	cd 40                	int    $0x40
 9a1:	c3                   	ret    

000009a2 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
 9a2:	b8 16 00 00 00       	mov    $0x16,%eax
 9a7:	cd 40                	int    $0x40
 9a9:	c3                   	ret    
 9aa:	66 90                	xchg   %ax,%ax
 9ac:	66 90                	xchg   %ax,%ax
 9ae:	66 90                	xchg   %ax,%ax

000009b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 9b0:	55                   	push   %ebp
 9b1:	89 e5                	mov    %esp,%ebp
 9b3:	57                   	push   %edi
 9b4:	56                   	push   %esi
 9b5:	53                   	push   %ebx
 9b6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 9b9:	85 d2                	test   %edx,%edx
{
 9bb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 9be:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 9c0:	79 76                	jns    a38 <printint+0x88>
 9c2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 9c6:	74 70                	je     a38 <printint+0x88>
    x = -xx;
 9c8:	f7 d8                	neg    %eax
    neg = 1;
 9ca:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 9d1:	31 f6                	xor    %esi,%esi
 9d3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 9d6:	eb 0a                	jmp    9e2 <printint+0x32>
 9d8:	90                   	nop
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 9e0:	89 fe                	mov    %edi,%esi
 9e2:	31 d2                	xor    %edx,%edx
 9e4:	8d 7e 01             	lea    0x1(%esi),%edi
 9e7:	f7 f1                	div    %ecx
 9e9:	0f b6 92 b8 0e 00 00 	movzbl 0xeb8(%edx),%edx
  }while((x /= base) != 0);
 9f0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 9f2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 9f5:	75 e9                	jne    9e0 <printint+0x30>
  if(neg)
 9f7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 9fa:	85 c0                	test   %eax,%eax
 9fc:	74 08                	je     a06 <printint+0x56>
    buf[i++] = '-';
 9fe:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 a03:	8d 7e 02             	lea    0x2(%esi),%edi
 a06:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 a0a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 a0d:	8d 76 00             	lea    0x0(%esi),%esi
 a10:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 a13:	83 ec 04             	sub    $0x4,%esp
 a16:	83 ee 01             	sub    $0x1,%esi
 a19:	6a 01                	push   $0x1
 a1b:	53                   	push   %ebx
 a1c:	57                   	push   %edi
 a1d:	88 45 d7             	mov    %al,-0x29(%ebp)
 a20:	e8 fd fe ff ff       	call   922 <write>

  while(--i >= 0)
 a25:	83 c4 10             	add    $0x10,%esp
 a28:	39 de                	cmp    %ebx,%esi
 a2a:	75 e4                	jne    a10 <printint+0x60>
    putc(fd, buf[i]);
}
 a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 a2f:	5b                   	pop    %ebx
 a30:	5e                   	pop    %esi
 a31:	5f                   	pop    %edi
 a32:	5d                   	pop    %ebp
 a33:	c3                   	ret    
 a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 a38:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 a3f:	eb 90                	jmp    9d1 <printint+0x21>
 a41:	eb 0d                	jmp    a50 <printf>
 a43:	90                   	nop
 a44:	90                   	nop
 a45:	90                   	nop
 a46:	90                   	nop
 a47:	90                   	nop
 a48:	90                   	nop
 a49:	90                   	nop
 a4a:	90                   	nop
 a4b:	90                   	nop
 a4c:	90                   	nop
 a4d:	90                   	nop
 a4e:	90                   	nop
 a4f:	90                   	nop

00000a50 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 a50:	55                   	push   %ebp
 a51:	89 e5                	mov    %esp,%ebp
 a53:	57                   	push   %edi
 a54:	56                   	push   %esi
 a55:	53                   	push   %ebx
 a56:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 a59:	8b 75 0c             	mov    0xc(%ebp),%esi
 a5c:	0f b6 1e             	movzbl (%esi),%ebx
 a5f:	84 db                	test   %bl,%bl
 a61:	0f 84 b3 00 00 00    	je     b1a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 a67:	8d 45 10             	lea    0x10(%ebp),%eax
 a6a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 a6d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 a6f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 a72:	eb 2f                	jmp    aa3 <printf+0x53>
 a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 a78:	83 f8 25             	cmp    $0x25,%eax
 a7b:	0f 84 a7 00 00 00    	je     b28 <printf+0xd8>
  write(fd, &c, 1);
 a81:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 a84:	83 ec 04             	sub    $0x4,%esp
 a87:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 a8a:	6a 01                	push   $0x1
 a8c:	50                   	push   %eax
 a8d:	ff 75 08             	pushl  0x8(%ebp)
 a90:	e8 8d fe ff ff       	call   922 <write>
 a95:	83 c4 10             	add    $0x10,%esp
 a98:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 a9b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 a9f:	84 db                	test   %bl,%bl
 aa1:	74 77                	je     b1a <printf+0xca>
    if(state == 0){
 aa3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 aa5:	0f be cb             	movsbl %bl,%ecx
 aa8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 aab:	74 cb                	je     a78 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 aad:	83 ff 25             	cmp    $0x25,%edi
 ab0:	75 e6                	jne    a98 <printf+0x48>
      if(c == 'd'){
 ab2:	83 f8 64             	cmp    $0x64,%eax
 ab5:	0f 84 05 01 00 00    	je     bc0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 abb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 ac1:	83 f9 70             	cmp    $0x70,%ecx
 ac4:	74 72                	je     b38 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 ac6:	83 f8 73             	cmp    $0x73,%eax
 ac9:	0f 84 99 00 00 00    	je     b68 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 acf:	83 f8 63             	cmp    $0x63,%eax
 ad2:	0f 84 08 01 00 00    	je     be0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 ad8:	83 f8 25             	cmp    $0x25,%eax
 adb:	0f 84 ef 00 00 00    	je     bd0 <printf+0x180>
  write(fd, &c, 1);
 ae1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 ae4:	83 ec 04             	sub    $0x4,%esp
 ae7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 aeb:	6a 01                	push   $0x1
 aed:	50                   	push   %eax
 aee:	ff 75 08             	pushl  0x8(%ebp)
 af1:	e8 2c fe ff ff       	call   922 <write>
 af6:	83 c4 0c             	add    $0xc,%esp
 af9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 afc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 aff:	6a 01                	push   $0x1
 b01:	50                   	push   %eax
 b02:	ff 75 08             	pushl  0x8(%ebp)
 b05:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 b08:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 b0a:	e8 13 fe ff ff       	call   922 <write>
  for(i = 0; fmt[i]; i++){
 b0f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 b13:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 b16:	84 db                	test   %bl,%bl
 b18:	75 89                	jne    aa3 <printf+0x53>
    }
  }
}
 b1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b1d:	5b                   	pop    %ebx
 b1e:	5e                   	pop    %esi
 b1f:	5f                   	pop    %edi
 b20:	5d                   	pop    %ebp
 b21:	c3                   	ret    
 b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 b28:	bf 25 00 00 00       	mov    $0x25,%edi
 b2d:	e9 66 ff ff ff       	jmp    a98 <printf+0x48>
 b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 b38:	83 ec 0c             	sub    $0xc,%esp
 b3b:	b9 10 00 00 00       	mov    $0x10,%ecx
 b40:	6a 00                	push   $0x0
 b42:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 b45:	8b 45 08             	mov    0x8(%ebp),%eax
 b48:	8b 17                	mov    (%edi),%edx
 b4a:	e8 61 fe ff ff       	call   9b0 <printint>
        ap++;
 b4f:	89 f8                	mov    %edi,%eax
 b51:	83 c4 10             	add    $0x10,%esp
      state = 0;
 b54:	31 ff                	xor    %edi,%edi
        ap++;
 b56:	83 c0 04             	add    $0x4,%eax
 b59:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 b5c:	e9 37 ff ff ff       	jmp    a98 <printf+0x48>
 b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 b68:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 b6b:	8b 08                	mov    (%eax),%ecx
        ap++;
 b6d:	83 c0 04             	add    $0x4,%eax
 b70:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 b73:	85 c9                	test   %ecx,%ecx
 b75:	0f 84 8e 00 00 00    	je     c09 <printf+0x1b9>
        while(*s != 0){
 b7b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 b7e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 b80:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 b82:	84 c0                	test   %al,%al
 b84:	0f 84 0e ff ff ff    	je     a98 <printf+0x48>
 b8a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 b8d:	89 de                	mov    %ebx,%esi
 b8f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 b92:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 b95:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b98:	83 ec 04             	sub    $0x4,%esp
          s++;
 b9b:	83 c6 01             	add    $0x1,%esi
 b9e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 ba1:	6a 01                	push   $0x1
 ba3:	57                   	push   %edi
 ba4:	53                   	push   %ebx
 ba5:	e8 78 fd ff ff       	call   922 <write>
        while(*s != 0){
 baa:	0f b6 06             	movzbl (%esi),%eax
 bad:	83 c4 10             	add    $0x10,%esp
 bb0:	84 c0                	test   %al,%al
 bb2:	75 e4                	jne    b98 <printf+0x148>
 bb4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 bb7:	31 ff                	xor    %edi,%edi
 bb9:	e9 da fe ff ff       	jmp    a98 <printf+0x48>
 bbe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 bc0:	83 ec 0c             	sub    $0xc,%esp
 bc3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 bc8:	6a 01                	push   $0x1
 bca:	e9 73 ff ff ff       	jmp    b42 <printf+0xf2>
 bcf:	90                   	nop
  write(fd, &c, 1);
 bd0:	83 ec 04             	sub    $0x4,%esp
 bd3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 bd6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 bd9:	6a 01                	push   $0x1
 bdb:	e9 21 ff ff ff       	jmp    b01 <printf+0xb1>
        putc(fd, *ap);
 be0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 be3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 be6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 be8:	6a 01                	push   $0x1
        ap++;
 bea:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 bed:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 bf0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 bf3:	50                   	push   %eax
 bf4:	ff 75 08             	pushl  0x8(%ebp)
 bf7:	e8 26 fd ff ff       	call   922 <write>
        ap++;
 bfc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 bff:	83 c4 10             	add    $0x10,%esp
      state = 0;
 c02:	31 ff                	xor    %edi,%edi
 c04:	e9 8f fe ff ff       	jmp    a98 <printf+0x48>
          s = "(null)";
 c09:	bb b0 0e 00 00       	mov    $0xeb0,%ebx
        while(*s != 0){
 c0e:	b8 28 00 00 00       	mov    $0x28,%eax
 c13:	e9 72 ff ff ff       	jmp    b8a <printf+0x13a>
 c18:	66 90                	xchg   %ax,%ax
 c1a:	66 90                	xchg   %ax,%ax
 c1c:	66 90                	xchg   %ax,%ax
 c1e:	66 90                	xchg   %ax,%ax

00000c20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c21:	a1 cc 12 00 00       	mov    0x12cc,%eax
{
 c26:	89 e5                	mov    %esp,%ebp
 c28:	57                   	push   %edi
 c29:	56                   	push   %esi
 c2a:	53                   	push   %ebx
 c2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 c2e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c38:	39 c8                	cmp    %ecx,%eax
 c3a:	8b 10                	mov    (%eax),%edx
 c3c:	73 32                	jae    c70 <free+0x50>
 c3e:	39 d1                	cmp    %edx,%ecx
 c40:	72 04                	jb     c46 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c42:	39 d0                	cmp    %edx,%eax
 c44:	72 32                	jb     c78 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 c46:	8b 73 fc             	mov    -0x4(%ebx),%esi
 c49:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 c4c:	39 fa                	cmp    %edi,%edx
 c4e:	74 30                	je     c80 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 c50:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 c53:	8b 50 04             	mov    0x4(%eax),%edx
 c56:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c59:	39 f1                	cmp    %esi,%ecx
 c5b:	74 3a                	je     c97 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 c5d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 c5f:	a3 cc 12 00 00       	mov    %eax,0x12cc
}
 c64:	5b                   	pop    %ebx
 c65:	5e                   	pop    %esi
 c66:	5f                   	pop    %edi
 c67:	5d                   	pop    %ebp
 c68:	c3                   	ret    
 c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c70:	39 d0                	cmp    %edx,%eax
 c72:	72 04                	jb     c78 <free+0x58>
 c74:	39 d1                	cmp    %edx,%ecx
 c76:	72 ce                	jb     c46 <free+0x26>
{
 c78:	89 d0                	mov    %edx,%eax
 c7a:	eb bc                	jmp    c38 <free+0x18>
 c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 c80:	03 72 04             	add    0x4(%edx),%esi
 c83:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 c86:	8b 10                	mov    (%eax),%edx
 c88:	8b 12                	mov    (%edx),%edx
 c8a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 c8d:	8b 50 04             	mov    0x4(%eax),%edx
 c90:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 c93:	39 f1                	cmp    %esi,%ecx
 c95:	75 c6                	jne    c5d <free+0x3d>
    p->s.size += bp->s.size;
 c97:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 c9a:	a3 cc 12 00 00       	mov    %eax,0x12cc
    p->s.size += bp->s.size;
 c9f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ca2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ca5:	89 10                	mov    %edx,(%eax)
}
 ca7:	5b                   	pop    %ebx
 ca8:	5e                   	pop    %esi
 ca9:	5f                   	pop    %edi
 caa:	5d                   	pop    %ebp
 cab:	c3                   	ret    
 cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 cb0:	55                   	push   %ebp
 cb1:	89 e5                	mov    %esp,%ebp
 cb3:	57                   	push   %edi
 cb4:	56                   	push   %esi
 cb5:	53                   	push   %ebx
 cb6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 cbc:	8b 15 cc 12 00 00    	mov    0x12cc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 cc2:	8d 78 07             	lea    0x7(%eax),%edi
 cc5:	c1 ef 03             	shr    $0x3,%edi
 cc8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 ccb:	85 d2                	test   %edx,%edx
 ccd:	0f 84 9d 00 00 00    	je     d70 <malloc+0xc0>
 cd3:	8b 02                	mov    (%edx),%eax
 cd5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 cd8:	39 cf                	cmp    %ecx,%edi
 cda:	76 6c                	jbe    d48 <malloc+0x98>
 cdc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ce2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ce7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 cea:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 cf1:	eb 0e                	jmp    d01 <malloc+0x51>
 cf3:	90                   	nop
 cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 cf8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 cfa:	8b 48 04             	mov    0x4(%eax),%ecx
 cfd:	39 f9                	cmp    %edi,%ecx
 cff:	73 47                	jae    d48 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 d01:	39 05 cc 12 00 00    	cmp    %eax,0x12cc
 d07:	89 c2                	mov    %eax,%edx
 d09:	75 ed                	jne    cf8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 d0b:	83 ec 0c             	sub    $0xc,%esp
 d0e:	56                   	push   %esi
 d0f:	e8 76 fc ff ff       	call   98a <sbrk>
  if(p == (char*)-1)
 d14:	83 c4 10             	add    $0x10,%esp
 d17:	83 f8 ff             	cmp    $0xffffffff,%eax
 d1a:	74 1c                	je     d38 <malloc+0x88>
  hp->s.size = nu;
 d1c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 d1f:	83 ec 0c             	sub    $0xc,%esp
 d22:	83 c0 08             	add    $0x8,%eax
 d25:	50                   	push   %eax
 d26:	e8 f5 fe ff ff       	call   c20 <free>
  return freep;
 d2b:	8b 15 cc 12 00 00    	mov    0x12cc,%edx
      if((p = morecore(nunits)) == 0)
 d31:	83 c4 10             	add    $0x10,%esp
 d34:	85 d2                	test   %edx,%edx
 d36:	75 c0                	jne    cf8 <malloc+0x48>
        return 0;
  }
}
 d38:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 d3b:	31 c0                	xor    %eax,%eax
}
 d3d:	5b                   	pop    %ebx
 d3e:	5e                   	pop    %esi
 d3f:	5f                   	pop    %edi
 d40:	5d                   	pop    %ebp
 d41:	c3                   	ret    
 d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 d48:	39 cf                	cmp    %ecx,%edi
 d4a:	74 54                	je     da0 <malloc+0xf0>
        p->s.size -= nunits;
 d4c:	29 f9                	sub    %edi,%ecx
 d4e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 d51:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 d54:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 d57:	89 15 cc 12 00 00    	mov    %edx,0x12cc
}
 d5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 d60:	83 c0 08             	add    $0x8,%eax
}
 d63:	5b                   	pop    %ebx
 d64:	5e                   	pop    %esi
 d65:	5f                   	pop    %edi
 d66:	5d                   	pop    %ebp
 d67:	c3                   	ret    
 d68:	90                   	nop
 d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 d70:	c7 05 cc 12 00 00 d0 	movl   $0x12d0,0x12cc
 d77:	12 00 00 
 d7a:	c7 05 d0 12 00 00 d0 	movl   $0x12d0,0x12d0
 d81:	12 00 00 
    base.s.size = 0;
 d84:	b8 d0 12 00 00       	mov    $0x12d0,%eax
 d89:	c7 05 d4 12 00 00 00 	movl   $0x0,0x12d4
 d90:	00 00 00 
 d93:	e9 44 ff ff ff       	jmp    cdc <malloc+0x2c>
 d98:	90                   	nop
 d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 da0:	8b 08                	mov    (%eax),%ecx
 da2:	89 0a                	mov    %ecx,(%edx)
 da4:	eb b1                	jmp    d57 <malloc+0xa7>
