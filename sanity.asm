
_sanity:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    printf(1," PASSED\n");
  }
}

int
main(int argc, char *argv[]){
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  printResult(cowPhysicalTest());
  11:	e8 aa 00 00 00       	call   c0 <cowPhysicalTest>
  if(res == -1){
  16:	83 f8 ff             	cmp    $0xffffffff,%eax
  19:	74 67                	je     82 <main+0x82>
    printf(1," PASSED\n");
  1b:	50                   	push   %eax
  1c:	50                   	push   %eax
  1d:	68 d6 0c 00 00       	push   $0xcd6
  22:	6a 01                	push   $0x1
  24:	e8 e7 08 00 00       	call   910 <printf>
  29:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFileTest());
  2c:	e8 2f 02 00 00       	call   260 <cowSwapFileTest>
  if(res == -1){
  31:	83 f8 ff             	cmp    $0xffffffff,%eax
  34:	74 61                	je     97 <main+0x97>
    printf(1," PASSED\n");
  36:	51                   	push   %ecx
  37:	51                   	push   %ecx
  38:	68 d6 0c 00 00       	push   $0xcd6
  3d:	6a 01                	push   $0x1
  3f:	e8 cc 08 00 00       	call   910 <printf>
  44:	83 c4 10             	add    $0x10,%esp
  //printf(1,"yes2\n");

  printResult(PhysicalMemTest ());
  47:	e8 54 03 00 00       	call   3a0 <PhysicalMemTest>
  if(res == -1){
  4c:	83 f8 ff             	cmp    $0xffffffff,%eax
  4f:	74 3f                	je     90 <main+0x90>
    printf(1," PASSED\n");
  51:	52                   	push   %edx
  52:	52                   	push   %edx
  53:	68 d6 0c 00 00       	push   $0xcd6
  58:	6a 01                	push   $0x1
  5a:	e8 b1 08 00 00       	call   910 <printf>
  5f:	83 c4 10             	add    $0x10,%esp
  printResult(SwapFileTest());
  62:	e8 19 04 00 00       	call   480 <SwapFileTest>
  if(res == -1){
  67:	83 f8 ff             	cmp    $0xffffffff,%eax
  6a:	74 1d                	je     89 <main+0x89>
    printf(1," PASSED\n");
  6c:	50                   	push   %eax
  6d:	50                   	push   %eax
  6e:	68 d6 0c 00 00       	push   $0xcd6
  73:	6a 01                	push   $0x1
  75:	e8 96 08 00 00       	call   910 <printf>
  7a:	83 c4 10             	add    $0x10,%esp
  exit();
  7d:	e8 40 07 00 00       	call   7c2 <exit>
  82:	e8 19 00 00 00       	call   a0 <printResult.part.4>
  87:	eb a3                	jmp    2c <main+0x2c>
  89:	e8 12 00 00 00       	call   a0 <printResult.part.4>
  8e:	eb ed                	jmp    7d <main+0x7d>
  90:	e8 0b 00 00 00       	call   a0 <printResult.part.4>
  95:	eb cb                	jmp    62 <main+0x62>
  97:	e8 04 00 00 00       	call   a0 <printResult.part.4>
  9c:	eb a9                	jmp    47 <main+0x47>
  9e:	66 90                	xchg   %ax,%ax

000000a0 <printResult.part.4>:
printResult(int res){
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 ec 10             	sub    $0x10,%esp
    printf(1," FAILED\n");
  a6:	68 68 0c 00 00       	push   $0xc68
  ab:	6a 01                	push   $0x1
  ad:	e8 5e 08 00 00       	call   910 <printf>
  b2:	83 c4 10             	add    $0x10,%esp
}
  b5:	c9                   	leave  
  b6:	c3                   	ret    
  b7:	89 f6                	mov    %esi,%esi
  b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000c0 <cowPhysicalTest>:
cowPhysicalTest(){
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  int testerPid = fork();
  c9:	e8 ec 06 00 00       	call   7ba <fork>
  if(testerPid==0){
  ce:	85 c0                	test   %eax,%eax
  d0:	0f 85 e2 00 00 00    	jne    1b8 <cowPhysicalTest+0xf8>
    printf(1,"cowPhysicalTest :");
  d6:	83 ec 08             	sub    $0x8,%esp
  d9:	68 71 0c 00 00       	push   $0xc71
  de:	6a 01                	push   $0x1
  e0:	e8 2b 08 00 00       	call   910 <printf>
    for(i = 0; i < 3; i++){
  e5:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  ec:	8b 45 d8             	mov    -0x28(%ebp),%eax
  ef:	83 c4 10             	add    $0x10,%esp
  f2:	83 f8 02             	cmp    $0x2,%eax
  f5:	7f 3d                	jg     134 <cowPhysicalTest+0x74>
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      lst[i] = (int*)sbrk(PGSIZE);
 100:	83 ec 0c             	sub    $0xc,%esp
 103:	8b 5d d8             	mov    -0x28(%ebp),%ebx
 106:	68 00 10 00 00       	push   $0x1000
 10b:	e8 3a 07 00 00       	call   84a <sbrk>
 110:	89 44 9d dc          	mov    %eax,-0x24(%ebp,%ebx,4)
      *lst[i]=i;
 114:	8b 45 d8             	mov    -0x28(%ebp),%eax
    for(i = 0; i < 3; i++){
 117:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
 11a:	8b 55 d8             	mov    -0x28(%ebp),%edx
 11d:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
 121:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 3; i++){
 123:	8b 45 d8             	mov    -0x28(%ebp),%eax
 126:	83 c0 01             	add    $0x1,%eax
 129:	89 45 d8             	mov    %eax,-0x28(%ebp)
 12c:	8b 45 d8             	mov    -0x28(%ebp),%eax
 12f:	83 f8 02             	cmp    $0x2,%eax
 132:	7e cc                	jle    100 <cowPhysicalTest+0x40>
    int freePages_beforeChild = getNumberOfFreePages();
 134:	e8 29 07 00 00       	call   862 <getNumberOfFreePages>
    sleep(10);
 139:	83 ec 0c             	sub    $0xc,%esp
    int freePages_beforeChild = getNumberOfFreePages();
 13c:	89 c7                	mov    %eax,%edi
    sleep(10);
 13e:	6a 0a                	push   $0xa
 140:	e8 0d 07 00 00       	call   852 <sleep>
    int pid = fork();
 145:	e8 70 06 00 00       	call   7ba <fork>
 14a:	89 c6                	mov    %eax,%esi
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
 14c:	e8 11 07 00 00       	call   862 <getNumberOfFreePages>
    sleep(10);
 151:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
 158:	89 c3                	mov    %eax,%ebx
    sleep(10);
 15a:	e8 f3 06 00 00       	call   852 <sleep>
    if(pid==0){
 15f:	83 c4 10             	add    $0x10,%esp
 162:	85 f6                	test   %esi,%esi
 164:	75 6a                	jne    1d0 <cowPhysicalTest+0x110>
      for(i = 0; i < 3; i++){
 166:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 16d:	8b 45 d8             	mov    -0x28(%ebp),%eax
 170:	83 f8 02             	cmp    $0x2,%eax
 173:	7e 1c                	jle    191 <cowPhysicalTest+0xd1>
 175:	e9 96 00 00 00       	jmp    210 <cowPhysicalTest+0x150>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	8b 45 d8             	mov    -0x28(%ebp),%eax
 183:	83 c0 01             	add    $0x1,%eax
 186:	89 45 d8             	mov    %eax,-0x28(%ebp)
 189:	8b 45 d8             	mov    -0x28(%ebp),%eax
 18c:	83 f8 02             	cmp    $0x2,%eax
 18f:	7f 7f                	jg     210 <cowPhysicalTest+0x150>
        if(*lst[i]!=i){
 191:	8b 55 d8             	mov    -0x28(%ebp),%edx
 194:	8b 45 d8             	mov    -0x28(%ebp),%eax
 197:	8b 54 95 dc          	mov    -0x24(%ebp,%edx,4),%edx
 19b:	39 02                	cmp    %eax,(%edx)
 19d:	74 e1                	je     180 <cowPhysicalTest+0xc0>
          printf(1," FAILED");
 19f:	83 ec 08             	sub    $0x8,%esp
 1a2:	68 83 0c 00 00       	push   $0xc83
 1a7:	6a 01                	push   $0x1
 1a9:	e8 62 07 00 00       	call   910 <printf>
 1ae:	83 c4 10             	add    $0x10,%esp
 1b1:	eb 4b                	jmp    1fe <cowPhysicalTest+0x13e>
 1b3:	90                   	nop
 1b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
 1b8:	e8 0d 06 00 00       	call   7ca <wait>
}
 1bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
 1c0:	31 c0                	xor    %eax,%eax
}
 1c2:	5b                   	pop    %ebx
 1c3:	5e                   	pop    %esi
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    wait();
 1d0:	e8 f5 05 00 00       	call   7ca <wait>
    if(freePages_beforeChild != getNumberOfFreePages()){
 1d5:	e8 88 06 00 00       	call   862 <getNumberOfFreePages>
 1da:	39 c7                	cmp    %eax,%edi
 1dc:	74 64                	je     242 <cowPhysicalTest+0x182>
      printf(1,"Err : num of free pages after child exit");
 1de:	83 ec 08             	sub    $0x8,%esp
 1e1:	68 40 0d 00 00       	push   $0xd40
 1e6:	6a 01                	push   $0x1
 1e8:	e8 23 07 00 00       	call   910 <printf>
      printf(1," FAILED");
 1ed:	58                   	pop    %eax
 1ee:	5a                   	pop    %edx
 1ef:	68 83 0c 00 00       	push   $0xc83
 1f4:	6a 01                	push   $0x1
 1f6:	e8 15 07 00 00       	call   910 <printf>
 1fb:	83 c4 10             	add    $0x10,%esp
}
 1fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
 201:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 206:	5b                   	pop    %ebx
 207:	5e                   	pop    %esi
 208:	5f                   	pop    %edi
 209:	5d                   	pop    %ebp
 20a:	c3                   	ret    
 20b:	90                   	nop
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      int freePages_beforeCloning = getNumberOfFreePages();
 210:	e8 4d 06 00 00       	call   862 <getNumberOfFreePages>
      if(freePages_beforeReadingFromParent != freePages_beforeCloning){
 215:	39 c3                	cmp    %eax,%ebx
 217:	75 1f                	jne    238 <cowPhysicalTest+0x178>
      *lst[1] = 66;
 219:	8b 45 e0             	mov    -0x20(%ebp),%eax
 21c:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(freePages_beforeCloning != getNumberOfFreePages()+1){
 222:	e8 3b 06 00 00       	call   862 <getNumberOfFreePages>
 227:	83 c0 01             	add    $0x1,%eax
 22a:	39 c3                	cmp    %eax,%ebx
 22c:	74 19                	je     247 <cowPhysicalTest+0x187>
        printf(1,"Err : num of free pages after cloning");
 22e:	83 ec 08             	sub    $0x8,%esp
 231:	68 18 0d 00 00       	push   $0xd18
 236:	eb ae                	jmp    1e6 <cowPhysicalTest+0x126>
        printf(1,"Err : num of free pages after reading only has changed");
 238:	83 ec 08             	sub    $0x8,%esp
 23b:	68 e0 0c 00 00       	push   $0xce0
 240:	eb a4                	jmp    1e6 <cowPhysicalTest+0x126>
    exit();
 242:	e8 7b 05 00 00       	call   7c2 <exit>
      sleep(10);
 247:	83 ec 0c             	sub    $0xc,%esp
 24a:	6a 0a                	push   $0xa
 24c:	e8 01 06 00 00       	call   852 <sleep>
      exit();
 251:	e8 6c 05 00 00       	call   7c2 <exit>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <cowSwapFileTest>:
cowSwapFileTest(){
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
 265:	83 ec 60             	sub    $0x60,%esp
  int testerPid = fork();
 268:	e8 4d 05 00 00       	call   7ba <fork>
  if(testerPid==0){
 26d:	85 c0                	test   %eax,%eax
 26f:	0f 85 0b 01 00 00    	jne    380 <cowSwapFileTest+0x120>
    printf(1,"cowSwapFileTest :");
 275:	83 ec 08             	sub    $0x8,%esp
 278:	89 c3                	mov    %eax,%ebx
 27a:	68 8b 0c 00 00       	push   $0xc8b
 27f:	6a 01                	push   $0x1
 281:	e8 8a 06 00 00       	call   910 <printf>
    for(i = 0; i < 15; i++){
 286:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 28d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 290:	83 c4 10             	add    $0x10,%esp
 293:	83 f8 0e             	cmp    $0xe,%eax
 296:	7f 3c                	jg     2d4 <cowSwapFileTest+0x74>
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
 2a0:	83 ec 0c             	sub    $0xc,%esp
 2a3:	8b 75 a4             	mov    -0x5c(%ebp),%esi
 2a6:	68 00 10 00 00       	push   $0x1000
 2ab:	e8 9a 05 00 00       	call   84a <sbrk>
 2b0:	89 44 b5 a8          	mov    %eax,-0x58(%ebp,%esi,4)
      *lst[i]=i;
 2b4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 15; i++){
 2b7:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
 2ba:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 2bd:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 2c1:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 15; i++){
 2c3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 2c6:	83 c0 01             	add    $0x1,%eax
 2c9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 2cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 2cf:	83 f8 0e             	cmp    $0xe,%eax
 2d2:	7e cc                	jle    2a0 <cowSwapFileTest+0x40>
    int pid = fork();
 2d4:	e8 e1 04 00 00       	call   7ba <fork>
    if(pid==0){
 2d9:	85 c0                	test   %eax,%eax
 2db:	0f 85 87 00 00 00    	jne    368 <cowSwapFileTest+0x108>
      for(i = 0; i < 15; i++){
 2e1:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 2e8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 2eb:	83 f8 0e             	cmp    $0xe,%eax
 2ee:	7e 1d                	jle    30d <cowSwapFileTest+0xad>
 2f0:	e9 a0 00 00 00       	jmp    395 <cowSwapFileTest+0x135>
 2f5:	8d 76 00             	lea    0x0(%esi),%esi
 2f8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 2fb:	83 c0 01             	add    $0x1,%eax
 2fe:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 301:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 304:	83 f8 0e             	cmp    $0xe,%eax
 307:	0f 8f 88 00 00 00    	jg     395 <cowSwapFileTest+0x135>
        if(*lst[i]!=i){
 30d:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 310:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 313:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 317:	39 02                	cmp    %eax,(%edx)
 319:	74 dd                	je     2f8 <cowSwapFileTest+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
 31b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 31e:	83 ec 04             	sub    $0x4,%esp
 321:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 324:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 328:	39 02                	cmp    %eax,(%edx)
 32a:	0f 95 c0             	setne  %al
 32d:	0f b6 c0             	movzbl %al,%eax
 330:	50                   	push   %eax
 331:	68 9d 0c 00 00       	push   $0xc9d
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 336:	6a 01                	push   $0x1
 338:	e8 d3 05 00 00       	call   910 <printf>
          printf(1," FAILED");
 33d:	58                   	pop    %eax
 33e:	5a                   	pop    %edx
 33f:	68 83 0c 00 00       	push   $0xc83
 344:	6a 01                	push   $0x1
 346:	e8 c5 05 00 00       	call   910 <printf>
 34b:	83 c4 10             	add    $0x10,%esp
}
 34e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 351:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(j = 0; j < 15; j++){
 360:	83 c3 01             	add    $0x1,%ebx
 363:	83 fb 0f             	cmp    $0xf,%ebx
 366:	74 28                	je     390 <cowSwapFileTest+0x130>
        if(*lst[j]!=j){
 368:	8b 44 9d a8          	mov    -0x58(%ebp,%ebx,4),%eax
 36c:	3b 18                	cmp    (%eax),%ebx
 36e:	74 f0                	je     360 <cowSwapFileTest+0x100>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
 370:	83 ec 04             	sub    $0x4,%esp
 373:	6a 01                	push   $0x1
 375:	68 b0 0c 00 00       	push   $0xcb0
 37a:	eb ba                	jmp    336 <cowSwapFileTest+0xd6>
 37c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
 380:	e8 45 04 00 00       	call   7ca <wait>
}
 385:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
 388:	31 c0                	xor    %eax,%eax
}
 38a:	5b                   	pop    %ebx
 38b:	5e                   	pop    %esi
 38c:	5d                   	pop    %ebp
 38d:	c3                   	ret    
 38e:	66 90                	xchg   %ax,%ax
    wait();
 390:	e8 35 04 00 00       	call   7ca <wait>
    exit();
 395:	e8 28 04 00 00       	call   7c2 <exit>
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <PhysicalMemTest>:
PhysicalMemTest(){
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	53                   	push   %ebx
 3a4:	83 ec 24             	sub    $0x24,%esp
  int testerPid = fork();
 3a7:	e8 0e 04 00 00       	call   7ba <fork>
  if(testerPid==0){
 3ac:	85 c0                	test   %eax,%eax
 3ae:	0f 85 ac 00 00 00    	jne    460 <PhysicalMemTest+0xc0>
    printf(1,"PhysicalMemTest :");
 3b4:	83 ec 08             	sub    $0x8,%esp
 3b7:	68 c4 0c 00 00       	push   $0xcc4
 3bc:	6a 01                	push   $0x1
 3be:	e8 4d 05 00 00       	call   910 <printf>
    for(i = 0; i < 5; i++){
 3c3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 3ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	83 f8 04             	cmp    $0x4,%eax
 3d3:	7f 37                	jg     40c <PhysicalMemTest+0x6c>
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
      lst[i] = (int*)sbrk(PGSIZE);
 3d8:	83 ec 0c             	sub    $0xc,%esp
 3db:	8b 5d e0             	mov    -0x20(%ebp),%ebx
 3de:	68 00 10 00 00       	push   $0x1000
 3e3:	e8 62 04 00 00       	call   84a <sbrk>
 3e8:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
      *lst[i]=i;
 3ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
    for(i = 0; i < 5; i++){
 3ef:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
 3f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
 3f5:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
 3f9:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 5; i++){
 3fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3fe:	83 c0 01             	add    $0x1,%eax
 401:	89 45 e0             	mov    %eax,-0x20(%ebp)
 404:	8b 45 e0             	mov    -0x20(%ebp),%eax
 407:	83 f8 04             	cmp    $0x4,%eax
 40a:	7e cc                	jle    3d8 <PhysicalMemTest+0x38>
    for(i = 0; i < 5; i++){
 40c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
 413:	8b 45 e0             	mov    -0x20(%ebp),%eax
 416:	83 f8 04             	cmp    $0x4,%eax
 419:	7e 16                	jle    431 <PhysicalMemTest+0x91>
 41b:	eb 4f                	jmp    46c <PhysicalMemTest+0xcc>
 41d:	8d 76 00             	lea    0x0(%esi),%esi
 420:	8b 45 e0             	mov    -0x20(%ebp),%eax
 423:	83 c0 01             	add    $0x1,%eax
 426:	89 45 e0             	mov    %eax,-0x20(%ebp)
 429:	8b 45 e0             	mov    -0x20(%ebp),%eax
 42c:	83 f8 04             	cmp    $0x4,%eax
 42f:	7f 3b                	jg     46c <PhysicalMemTest+0xcc>
      if(*lst[i]!=i){
 431:	8b 55 e0             	mov    -0x20(%ebp),%edx
 434:	8b 45 e0             	mov    -0x20(%ebp),%eax
 437:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
 43b:	39 02                	cmp    %eax,(%edx)
 43d:	74 e1                	je     420 <PhysicalMemTest+0x80>
        printf(1," FAILED");
 43f:	83 ec 08             	sub    $0x8,%esp
 442:	68 83 0c 00 00       	push   $0xc83
 447:	6a 01                	push   $0x1
 449:	e8 c2 04 00 00       	call   910 <printf>
 44e:	83 c4 10             	add    $0x10,%esp
 451:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 456:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 459:	c9                   	leave  
 45a:	c3                   	ret    
 45b:	90                   	nop
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
 460:	e8 65 03 00 00       	call   7ca <wait>
    return 0;
 465:	31 c0                	xor    %eax,%eax
}
 467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 46a:	c9                   	leave  
 46b:	c3                   	ret    
    exit();
 46c:	e8 51 03 00 00       	call   7c2 <exit>
 471:	eb 0d                	jmp    480 <SwapFileTest>
 473:	90                   	nop
 474:	90                   	nop
 475:	90                   	nop
 476:	90                   	nop
 477:	90                   	nop
 478:	90                   	nop
 479:	90                   	nop
 47a:	90                   	nop
 47b:	90                   	nop
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <SwapFileTest>:
SwapFileTest(){
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	83 ec 6c             	sub    $0x6c,%esp
  printf(1,"SwapFileTest :");
 487:	68 8e 0c 00 00       	push   $0xc8e
 48c:	6a 01                	push   $0x1
 48e:	e8 7d 04 00 00       	call   910 <printf>
  for(i = 0; i < 20; i++){
 493:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 49a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 49d:	83 c4 10             	add    $0x10,%esp
 4a0:	83 f8 13             	cmp    $0x13,%eax
 4a3:	7f 37                	jg     4dc <SwapFileTest+0x5c>
 4a5:	8d 76 00             	lea    0x0(%esi),%esi
    lst[i] = (int*)sbrk(PGSIZE);
 4a8:	83 ec 0c             	sub    $0xc,%esp
 4ab:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
 4ae:	68 00 10 00 00       	push   $0x1000
 4b3:	e8 92 03 00 00       	call   84a <sbrk>
 4b8:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
    *lst[i]=i;
 4bc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  for(i = 0; i < 20; i++){
 4bf:	83 c4 10             	add    $0x10,%esp
    *lst[i]=i;
 4c2:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 4c5:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
 4c9:	89 10                	mov    %edx,(%eax)
  for(i = 0; i < 20; i++){
 4cb:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4ce:	83 c0 01             	add    $0x1,%eax
 4d1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 4d4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4d7:	83 f8 13             	cmp    $0x13,%eax
 4da:	7e cc                	jle    4a8 <SwapFileTest+0x28>
  for(i = 0; i < 20; i++){
 4dc:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
 4e3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4e6:	83 f8 13             	cmp    $0x13,%eax
 4e9:	7e 16                	jle    501 <SwapFileTest+0x81>
 4eb:	eb 43                	jmp    530 <SwapFileTest+0xb0>
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
 4f0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4f3:	83 c0 01             	add    $0x1,%eax
 4f6:	89 45 a4             	mov    %eax,-0x5c(%ebp)
 4f9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 4fc:	83 f8 13             	cmp    $0x13,%eax
 4ff:	7f 2f                	jg     530 <SwapFileTest+0xb0>
    if(*lst[i]!=i){
 501:	8b 55 a4             	mov    -0x5c(%ebp),%edx
 504:	8b 45 a4             	mov    -0x5c(%ebp),%eax
 507:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
 50b:	39 02                	cmp    %eax,(%edx)
 50d:	74 e1                	je     4f0 <SwapFileTest+0x70>
      printf(1," FAILED");
 50f:	83 ec 08             	sub    $0x8,%esp
 512:	68 83 0c 00 00       	push   $0xc83
 517:	6a 01                	push   $0x1
 519:	e8 f2 03 00 00       	call   910 <printf>
 51e:	83 c4 10             	add    $0x10,%esp
 521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 526:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 529:	c9                   	leave  
 52a:	c3                   	ret    
 52b:	90                   	nop
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 530:	31 c0                	xor    %eax,%eax
}
 532:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 535:	c9                   	leave  
 536:	c3                   	ret    
 537:	89 f6                	mov    %esi,%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <printResult>:
printResult(int res){
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	83 ec 08             	sub    $0x8,%esp
  if(res == -1){
 546:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
 54a:	74 14                	je     560 <printResult+0x20>
    printf(1," PASSED\n");
 54c:	83 ec 08             	sub    $0x8,%esp
 54f:	68 d6 0c 00 00       	push   $0xcd6
 554:	6a 01                	push   $0x1
 556:	e8 b5 03 00 00       	call   910 <printf>
 55b:	83 c4 10             	add    $0x10,%esp
}
 55e:	c9                   	leave  
 55f:	c3                   	ret    
 560:	c9                   	leave  
 561:	e9 3a fb ff ff       	jmp    a0 <printResult.part.4>
 566:	66 90                	xchg   %ax,%ax
 568:	66 90                	xchg   %ax,%ax
 56a:	66 90                	xchg   %ax,%ax
 56c:	66 90                	xchg   %ax,%ax
 56e:	66 90                	xchg   %ax,%ax

00000570 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 570:	55                   	push   %ebp
 571:	89 e5                	mov    %esp,%ebp
 573:	53                   	push   %ebx
 574:	8b 45 08             	mov    0x8(%ebp),%eax
 577:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 57a:	89 c2                	mov    %eax,%edx
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 580:	83 c1 01             	add    $0x1,%ecx
 583:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 587:	83 c2 01             	add    $0x1,%edx
 58a:	84 db                	test   %bl,%bl
 58c:	88 5a ff             	mov    %bl,-0x1(%edx)
 58f:	75 ef                	jne    580 <strcpy+0x10>
    ;
  return os;
}
 591:	5b                   	pop    %ebx
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    
 594:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 59a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	53                   	push   %ebx
 5a4:	8b 55 08             	mov    0x8(%ebp),%edx
 5a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5aa:	0f b6 02             	movzbl (%edx),%eax
 5ad:	0f b6 19             	movzbl (%ecx),%ebx
 5b0:	84 c0                	test   %al,%al
 5b2:	75 1c                	jne    5d0 <strcmp+0x30>
 5b4:	eb 2a                	jmp    5e0 <strcmp+0x40>
 5b6:	8d 76 00             	lea    0x0(%esi),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 5c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 5c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5c6:	83 c1 01             	add    $0x1,%ecx
 5c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 5cc:	84 c0                	test   %al,%al
 5ce:	74 10                	je     5e0 <strcmp+0x40>
 5d0:	38 d8                	cmp    %bl,%al
 5d2:	74 ec                	je     5c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 5d4:	29 d8                	sub    %ebx,%eax
}
 5d6:	5b                   	pop    %ebx
 5d7:	5d                   	pop    %ebp
 5d8:	c3                   	ret    
 5d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 5e2:	29 d8                	sub    %ebx,%eax
}
 5e4:	5b                   	pop    %ebx
 5e5:	5d                   	pop    %ebp
 5e6:	c3                   	ret    
 5e7:	89 f6                	mov    %esi,%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <strlen>:

uint
strlen(const char *s)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 5f6:	80 39 00             	cmpb   $0x0,(%ecx)
 5f9:	74 15                	je     610 <strlen+0x20>
 5fb:	31 d2                	xor    %edx,%edx
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	83 c2 01             	add    $0x1,%edx
 603:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 607:	89 d0                	mov    %edx,%eax
 609:	75 f5                	jne    600 <strlen+0x10>
    ;
  return n;
}
 60b:	5d                   	pop    %ebp
 60c:	c3                   	ret    
 60d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 610:	31 c0                	xor    %eax,%eax
}
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 61a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000620 <memset>:

void*
memset(void *dst, int c, uint n)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 627:	8b 4d 10             	mov    0x10(%ebp),%ecx
 62a:	8b 45 0c             	mov    0xc(%ebp),%eax
 62d:	89 d7                	mov    %edx,%edi
 62f:	fc                   	cld    
 630:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 632:	89 d0                	mov    %edx,%eax
 634:	5f                   	pop    %edi
 635:	5d                   	pop    %ebp
 636:	c3                   	ret    
 637:	89 f6                	mov    %esi,%esi
 639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000640 <strchr>:

char*
strchr(const char *s, char c)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	53                   	push   %ebx
 644:	8b 45 08             	mov    0x8(%ebp),%eax
 647:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 64a:	0f b6 10             	movzbl (%eax),%edx
 64d:	84 d2                	test   %dl,%dl
 64f:	74 1d                	je     66e <strchr+0x2e>
    if(*s == c)
 651:	38 d3                	cmp    %dl,%bl
 653:	89 d9                	mov    %ebx,%ecx
 655:	75 0d                	jne    664 <strchr+0x24>
 657:	eb 17                	jmp    670 <strchr+0x30>
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 660:	38 ca                	cmp    %cl,%dl
 662:	74 0c                	je     670 <strchr+0x30>
  for(; *s; s++)
 664:	83 c0 01             	add    $0x1,%eax
 667:	0f b6 10             	movzbl (%eax),%edx
 66a:	84 d2                	test   %dl,%dl
 66c:	75 f2                	jne    660 <strchr+0x20>
      return (char*)s;
  return 0;
 66e:	31 c0                	xor    %eax,%eax
}
 670:	5b                   	pop    %ebx
 671:	5d                   	pop    %ebp
 672:	c3                   	ret    
 673:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000680 <gets>:

char*
gets(char *buf, int max)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 686:	31 f6                	xor    %esi,%esi
 688:	89 f3                	mov    %esi,%ebx
{
 68a:	83 ec 1c             	sub    $0x1c,%esp
 68d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 690:	eb 2f                	jmp    6c1 <gets+0x41>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 698:	8d 45 e7             	lea    -0x19(%ebp),%eax
 69b:	83 ec 04             	sub    $0x4,%esp
 69e:	6a 01                	push   $0x1
 6a0:	50                   	push   %eax
 6a1:	6a 00                	push   $0x0
 6a3:	e8 32 01 00 00       	call   7da <read>
    if(cc < 1)
 6a8:	83 c4 10             	add    $0x10,%esp
 6ab:	85 c0                	test   %eax,%eax
 6ad:	7e 1c                	jle    6cb <gets+0x4b>
      break;
    buf[i++] = c;
 6af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 6b3:	83 c7 01             	add    $0x1,%edi
 6b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 6b9:	3c 0a                	cmp    $0xa,%al
 6bb:	74 23                	je     6e0 <gets+0x60>
 6bd:	3c 0d                	cmp    $0xd,%al
 6bf:	74 1f                	je     6e0 <gets+0x60>
  for(i=0; i+1 < max; ){
 6c1:	83 c3 01             	add    $0x1,%ebx
 6c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6c7:	89 fe                	mov    %edi,%esi
 6c9:	7c cd                	jl     698 <gets+0x18>
 6cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 6cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 6d0:	c6 03 00             	movb   $0x0,(%ebx)
}
 6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d6:	5b                   	pop    %ebx
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6e0:	8b 75 08             	mov    0x8(%ebp),%esi
 6e3:	8b 45 08             	mov    0x8(%ebp),%eax
 6e6:	01 de                	add    %ebx,%esi
 6e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 6ea:	c6 03 00             	movb   $0x0,(%ebx)
}
 6ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6f0:	5b                   	pop    %ebx
 6f1:	5e                   	pop    %esi
 6f2:	5f                   	pop    %edi
 6f3:	5d                   	pop    %ebp
 6f4:	c3                   	ret    
 6f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000700 <stat>:

int
stat(const char *n, struct stat *st)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 705:	83 ec 08             	sub    $0x8,%esp
 708:	6a 00                	push   $0x0
 70a:	ff 75 08             	pushl  0x8(%ebp)
 70d:	e8 f0 00 00 00       	call   802 <open>
  if(fd < 0)
 712:	83 c4 10             	add    $0x10,%esp
 715:	85 c0                	test   %eax,%eax
 717:	78 27                	js     740 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 719:	83 ec 08             	sub    $0x8,%esp
 71c:	ff 75 0c             	pushl  0xc(%ebp)
 71f:	89 c3                	mov    %eax,%ebx
 721:	50                   	push   %eax
 722:	e8 f3 00 00 00       	call   81a <fstat>
  close(fd);
 727:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 72a:	89 c6                	mov    %eax,%esi
  close(fd);
 72c:	e8 b9 00 00 00       	call   7ea <close>
  return r;
 731:	83 c4 10             	add    $0x10,%esp
}
 734:	8d 65 f8             	lea    -0x8(%ebp),%esp
 737:	89 f0                	mov    %esi,%eax
 739:	5b                   	pop    %ebx
 73a:	5e                   	pop    %esi
 73b:	5d                   	pop    %ebp
 73c:	c3                   	ret    
 73d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 740:	be ff ff ff ff       	mov    $0xffffffff,%esi
 745:	eb ed                	jmp    734 <stat+0x34>
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <atoi>:

int
atoi(const char *s)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	53                   	push   %ebx
 754:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 757:	0f be 11             	movsbl (%ecx),%edx
 75a:	8d 42 d0             	lea    -0x30(%edx),%eax
 75d:	3c 09                	cmp    $0x9,%al
  n = 0;
 75f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 764:	77 1f                	ja     785 <atoi+0x35>
 766:	8d 76 00             	lea    0x0(%esi),%esi
 769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 770:	8d 04 80             	lea    (%eax,%eax,4),%eax
 773:	83 c1 01             	add    $0x1,%ecx
 776:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 77a:	0f be 11             	movsbl (%ecx),%edx
 77d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 780:	80 fb 09             	cmp    $0x9,%bl
 783:	76 eb                	jbe    770 <atoi+0x20>
  return n;
}
 785:	5b                   	pop    %ebx
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000790 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	56                   	push   %esi
 794:	53                   	push   %ebx
 795:	8b 5d 10             	mov    0x10(%ebp),%ebx
 798:	8b 45 08             	mov    0x8(%ebp),%eax
 79b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 79e:	85 db                	test   %ebx,%ebx
 7a0:	7e 14                	jle    7b6 <memmove+0x26>
 7a2:	31 d2                	xor    %edx,%edx
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 7a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 7ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 7af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7b2:	39 d3                	cmp    %edx,%ebx
 7b4:	75 f2                	jne    7a8 <memmove+0x18>
  return vdst;
}
 7b6:	5b                   	pop    %ebx
 7b7:	5e                   	pop    %esi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret    

000007ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7ba:	b8 01 00 00 00       	mov    $0x1,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <exit>:
SYSCALL(exit)
 7c2:	b8 02 00 00 00       	mov    $0x2,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <wait>:
SYSCALL(wait)
 7ca:	b8 03 00 00 00       	mov    $0x3,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <pipe>:
SYSCALL(pipe)
 7d2:	b8 04 00 00 00       	mov    $0x4,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <read>:
SYSCALL(read)
 7da:	b8 05 00 00 00       	mov    $0x5,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <write>:
SYSCALL(write)
 7e2:	b8 10 00 00 00       	mov    $0x10,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <close>:
SYSCALL(close)
 7ea:	b8 15 00 00 00       	mov    $0x15,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <kill>:
SYSCALL(kill)
 7f2:	b8 06 00 00 00       	mov    $0x6,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <exec>:
SYSCALL(exec)
 7fa:	b8 07 00 00 00       	mov    $0x7,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <open>:
SYSCALL(open)
 802:	b8 0f 00 00 00       	mov    $0xf,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <mknod>:
SYSCALL(mknod)
 80a:	b8 11 00 00 00       	mov    $0x11,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <unlink>:
SYSCALL(unlink)
 812:	b8 12 00 00 00       	mov    $0x12,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <fstat>:
SYSCALL(fstat)
 81a:	b8 08 00 00 00       	mov    $0x8,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <link>:
SYSCALL(link)
 822:	b8 13 00 00 00       	mov    $0x13,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <mkdir>:
SYSCALL(mkdir)
 82a:	b8 14 00 00 00       	mov    $0x14,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <chdir>:
SYSCALL(chdir)
 832:	b8 09 00 00 00       	mov    $0x9,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <dup>:
SYSCALL(dup)
 83a:	b8 0a 00 00 00       	mov    $0xa,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <getpid>:
SYSCALL(getpid)
 842:	b8 0b 00 00 00       	mov    $0xb,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <sbrk>:
SYSCALL(sbrk)
 84a:	b8 0c 00 00 00       	mov    $0xc,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <sleep>:
SYSCALL(sleep)
 852:	b8 0d 00 00 00       	mov    $0xd,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <uptime>:
SYSCALL(uptime)
 85a:	b8 0e 00 00 00       	mov    $0xe,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
 862:	b8 16 00 00 00       	mov    $0x16,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    
 86a:	66 90                	xchg   %ax,%ax
 86c:	66 90                	xchg   %ax,%ax
 86e:	66 90                	xchg   %ax,%ax

00000870 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 879:	85 d2                	test   %edx,%edx
{
 87b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 87e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 880:	79 76                	jns    8f8 <printint+0x88>
 882:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 886:	74 70                	je     8f8 <printint+0x88>
    x = -xx;
 888:	f7 d8                	neg    %eax
    neg = 1;
 88a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 891:	31 f6                	xor    %esi,%esi
 893:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 896:	eb 0a                	jmp    8a2 <printint+0x32>
 898:	90                   	nop
 899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 8a0:	89 fe                	mov    %edi,%esi
 8a2:	31 d2                	xor    %edx,%edx
 8a4:	8d 7e 01             	lea    0x1(%esi),%edi
 8a7:	f7 f1                	div    %ecx
 8a9:	0f b6 92 74 0d 00 00 	movzbl 0xd74(%edx),%edx
  }while((x /= base) != 0);
 8b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8b2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 8b5:	75 e9                	jne    8a0 <printint+0x30>
  if(neg)
 8b7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8ba:	85 c0                	test   %eax,%eax
 8bc:	74 08                	je     8c6 <printint+0x56>
    buf[i++] = '-';
 8be:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 8c3:	8d 7e 02             	lea    0x2(%esi),%edi
 8c6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 8ca:	8b 7d c0             	mov    -0x40(%ebp),%edi
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
 8d0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 8d3:	83 ec 04             	sub    $0x4,%esp
 8d6:	83 ee 01             	sub    $0x1,%esi
 8d9:	6a 01                	push   $0x1
 8db:	53                   	push   %ebx
 8dc:	57                   	push   %edi
 8dd:	88 45 d7             	mov    %al,-0x29(%ebp)
 8e0:	e8 fd fe ff ff       	call   7e2 <write>

  while(--i >= 0)
 8e5:	83 c4 10             	add    $0x10,%esp
 8e8:	39 de                	cmp    %ebx,%esi
 8ea:	75 e4                	jne    8d0 <printint+0x60>
    putc(fd, buf[i]);
}
 8ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ef:	5b                   	pop    %ebx
 8f0:	5e                   	pop    %esi
 8f1:	5f                   	pop    %edi
 8f2:	5d                   	pop    %ebp
 8f3:	c3                   	ret    
 8f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8f8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8ff:	eb 90                	jmp    891 <printint+0x21>
 901:	eb 0d                	jmp    910 <printf>
 903:	90                   	nop
 904:	90                   	nop
 905:	90                   	nop
 906:	90                   	nop
 907:	90                   	nop
 908:	90                   	nop
 909:	90                   	nop
 90a:	90                   	nop
 90b:	90                   	nop
 90c:	90                   	nop
 90d:	90                   	nop
 90e:	90                   	nop
 90f:	90                   	nop

00000910 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 910:	55                   	push   %ebp
 911:	89 e5                	mov    %esp,%ebp
 913:	57                   	push   %edi
 914:	56                   	push   %esi
 915:	53                   	push   %ebx
 916:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 919:	8b 75 0c             	mov    0xc(%ebp),%esi
 91c:	0f b6 1e             	movzbl (%esi),%ebx
 91f:	84 db                	test   %bl,%bl
 921:	0f 84 b3 00 00 00    	je     9da <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 927:	8d 45 10             	lea    0x10(%ebp),%eax
 92a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 92d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 92f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 932:	eb 2f                	jmp    963 <printf+0x53>
 934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 938:	83 f8 25             	cmp    $0x25,%eax
 93b:	0f 84 a7 00 00 00    	je     9e8 <printf+0xd8>
  write(fd, &c, 1);
 941:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 944:	83 ec 04             	sub    $0x4,%esp
 947:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 94a:	6a 01                	push   $0x1
 94c:	50                   	push   %eax
 94d:	ff 75 08             	pushl  0x8(%ebp)
 950:	e8 8d fe ff ff       	call   7e2 <write>
 955:	83 c4 10             	add    $0x10,%esp
 958:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 95b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 95f:	84 db                	test   %bl,%bl
 961:	74 77                	je     9da <printf+0xca>
    if(state == 0){
 963:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 965:	0f be cb             	movsbl %bl,%ecx
 968:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 96b:	74 cb                	je     938 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 96d:	83 ff 25             	cmp    $0x25,%edi
 970:	75 e6                	jne    958 <printf+0x48>
      if(c == 'd'){
 972:	83 f8 64             	cmp    $0x64,%eax
 975:	0f 84 05 01 00 00    	je     a80 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 97b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 981:	83 f9 70             	cmp    $0x70,%ecx
 984:	74 72                	je     9f8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 986:	83 f8 73             	cmp    $0x73,%eax
 989:	0f 84 99 00 00 00    	je     a28 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 98f:	83 f8 63             	cmp    $0x63,%eax
 992:	0f 84 08 01 00 00    	je     aa0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 998:	83 f8 25             	cmp    $0x25,%eax
 99b:	0f 84 ef 00 00 00    	je     a90 <printf+0x180>
  write(fd, &c, 1);
 9a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9a4:	83 ec 04             	sub    $0x4,%esp
 9a7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9ab:	6a 01                	push   $0x1
 9ad:	50                   	push   %eax
 9ae:	ff 75 08             	pushl  0x8(%ebp)
 9b1:	e8 2c fe ff ff       	call   7e2 <write>
 9b6:	83 c4 0c             	add    $0xc,%esp
 9b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9bc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9bf:	6a 01                	push   $0x1
 9c1:	50                   	push   %eax
 9c2:	ff 75 08             	pushl  0x8(%ebp)
 9c5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9c8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9ca:	e8 13 fe ff ff       	call   7e2 <write>
  for(i = 0; fmt[i]; i++){
 9cf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 9d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 9d6:	84 db                	test   %bl,%bl
 9d8:	75 89                	jne    963 <printf+0x53>
    }
  }
}
 9da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9dd:	5b                   	pop    %ebx
 9de:	5e                   	pop    %esi
 9df:	5f                   	pop    %edi
 9e0:	5d                   	pop    %ebp
 9e1:	c3                   	ret    
 9e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9e8:	bf 25 00 00 00       	mov    $0x25,%edi
 9ed:	e9 66 ff ff ff       	jmp    958 <printf+0x48>
 9f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9f8:	83 ec 0c             	sub    $0xc,%esp
 9fb:	b9 10 00 00 00       	mov    $0x10,%ecx
 a00:	6a 00                	push   $0x0
 a02:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 a05:	8b 45 08             	mov    0x8(%ebp),%eax
 a08:	8b 17                	mov    (%edi),%edx
 a0a:	e8 61 fe ff ff       	call   870 <printint>
        ap++;
 a0f:	89 f8                	mov    %edi,%eax
 a11:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a14:	31 ff                	xor    %edi,%edi
        ap++;
 a16:	83 c0 04             	add    $0x4,%eax
 a19:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 a1c:	e9 37 ff ff ff       	jmp    958 <printf+0x48>
 a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a28:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a2b:	8b 08                	mov    (%eax),%ecx
        ap++;
 a2d:	83 c0 04             	add    $0x4,%eax
 a30:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 a33:	85 c9                	test   %ecx,%ecx
 a35:	0f 84 8e 00 00 00    	je     ac9 <printf+0x1b9>
        while(*s != 0){
 a3b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 a3e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a40:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a42:	84 c0                	test   %al,%al
 a44:	0f 84 0e ff ff ff    	je     958 <printf+0x48>
 a4a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a4d:	89 de                	mov    %ebx,%esi
 a4f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a52:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a55:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a58:	83 ec 04             	sub    $0x4,%esp
          s++;
 a5b:	83 c6 01             	add    $0x1,%esi
 a5e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a61:	6a 01                	push   $0x1
 a63:	57                   	push   %edi
 a64:	53                   	push   %ebx
 a65:	e8 78 fd ff ff       	call   7e2 <write>
        while(*s != 0){
 a6a:	0f b6 06             	movzbl (%esi),%eax
 a6d:	83 c4 10             	add    $0x10,%esp
 a70:	84 c0                	test   %al,%al
 a72:	75 e4                	jne    a58 <printf+0x148>
 a74:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a77:	31 ff                	xor    %edi,%edi
 a79:	e9 da fe ff ff       	jmp    958 <printf+0x48>
 a7e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a80:	83 ec 0c             	sub    $0xc,%esp
 a83:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a88:	6a 01                	push   $0x1
 a8a:	e9 73 ff ff ff       	jmp    a02 <printf+0xf2>
 a8f:	90                   	nop
  write(fd, &c, 1);
 a90:	83 ec 04             	sub    $0x4,%esp
 a93:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a96:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a99:	6a 01                	push   $0x1
 a9b:	e9 21 ff ff ff       	jmp    9c1 <printf+0xb1>
        putc(fd, *ap);
 aa0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 aa3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 aa6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 aa8:	6a 01                	push   $0x1
        ap++;
 aaa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 aad:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 ab0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 ab3:	50                   	push   %eax
 ab4:	ff 75 08             	pushl  0x8(%ebp)
 ab7:	e8 26 fd ff ff       	call   7e2 <write>
        ap++;
 abc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 abf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 ac2:	31 ff                	xor    %edi,%edi
 ac4:	e9 8f fe ff ff       	jmp    958 <printf+0x48>
          s = "(null)";
 ac9:	bb 6c 0d 00 00       	mov    $0xd6c,%ebx
        while(*s != 0){
 ace:	b8 28 00 00 00       	mov    $0x28,%eax
 ad3:	e9 72 ff ff ff       	jmp    a4a <printf+0x13a>
 ad8:	66 90                	xchg   %ax,%ax
 ada:	66 90                	xchg   %ax,%ax
 adc:	66 90                	xchg   %ax,%ax
 ade:	66 90                	xchg   %ax,%ax

00000ae0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ae0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ae1:	a1 34 11 00 00       	mov    0x1134,%eax
{
 ae6:	89 e5                	mov    %esp,%ebp
 ae8:	57                   	push   %edi
 ae9:	56                   	push   %esi
 aea:	53                   	push   %ebx
 aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 aee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af8:	39 c8                	cmp    %ecx,%eax
 afa:	8b 10                	mov    (%eax),%edx
 afc:	73 32                	jae    b30 <free+0x50>
 afe:	39 d1                	cmp    %edx,%ecx
 b00:	72 04                	jb     b06 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b02:	39 d0                	cmp    %edx,%eax
 b04:	72 32                	jb     b38 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b06:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b09:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b0c:	39 fa                	cmp    %edi,%edx
 b0e:	74 30                	je     b40 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b10:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b13:	8b 50 04             	mov    0x4(%eax),%edx
 b16:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b19:	39 f1                	cmp    %esi,%ecx
 b1b:	74 3a                	je     b57 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b1d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b1f:	a3 34 11 00 00       	mov    %eax,0x1134
}
 b24:	5b                   	pop    %ebx
 b25:	5e                   	pop    %esi
 b26:	5f                   	pop    %edi
 b27:	5d                   	pop    %ebp
 b28:	c3                   	ret    
 b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b30:	39 d0                	cmp    %edx,%eax
 b32:	72 04                	jb     b38 <free+0x58>
 b34:	39 d1                	cmp    %edx,%ecx
 b36:	72 ce                	jb     b06 <free+0x26>
{
 b38:	89 d0                	mov    %edx,%eax
 b3a:	eb bc                	jmp    af8 <free+0x18>
 b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b40:	03 72 04             	add    0x4(%edx),%esi
 b43:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b46:	8b 10                	mov    (%eax),%edx
 b48:	8b 12                	mov    (%edx),%edx
 b4a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b4d:	8b 50 04             	mov    0x4(%eax),%edx
 b50:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b53:	39 f1                	cmp    %esi,%ecx
 b55:	75 c6                	jne    b1d <free+0x3d>
    p->s.size += bp->s.size;
 b57:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b5a:	a3 34 11 00 00       	mov    %eax,0x1134
    p->s.size += bp->s.size;
 b5f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b62:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b65:	89 10                	mov    %edx,(%eax)
}
 b67:	5b                   	pop    %ebx
 b68:	5e                   	pop    %esi
 b69:	5f                   	pop    %edi
 b6a:	5d                   	pop    %ebp
 b6b:	c3                   	ret    
 b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b70 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b70:	55                   	push   %ebp
 b71:	89 e5                	mov    %esp,%ebp
 b73:	57                   	push   %edi
 b74:	56                   	push   %esi
 b75:	53                   	push   %ebx
 b76:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b79:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b7c:	8b 15 34 11 00 00    	mov    0x1134,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b82:	8d 78 07             	lea    0x7(%eax),%edi
 b85:	c1 ef 03             	shr    $0x3,%edi
 b88:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b8b:	85 d2                	test   %edx,%edx
 b8d:	0f 84 9d 00 00 00    	je     c30 <malloc+0xc0>
 b93:	8b 02                	mov    (%edx),%eax
 b95:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b98:	39 cf                	cmp    %ecx,%edi
 b9a:	76 6c                	jbe    c08 <malloc+0x98>
 b9c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ba2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ba7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 baa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bb1:	eb 0e                	jmp    bc1 <malloc+0x51>
 bb3:	90                   	nop
 bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bb8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bba:	8b 48 04             	mov    0x4(%eax),%ecx
 bbd:	39 f9                	cmp    %edi,%ecx
 bbf:	73 47                	jae    c08 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bc1:	39 05 34 11 00 00    	cmp    %eax,0x1134
 bc7:	89 c2                	mov    %eax,%edx
 bc9:	75 ed                	jne    bb8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bcb:	83 ec 0c             	sub    $0xc,%esp
 bce:	56                   	push   %esi
 bcf:	e8 76 fc ff ff       	call   84a <sbrk>
  if(p == (char*)-1)
 bd4:	83 c4 10             	add    $0x10,%esp
 bd7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bda:	74 1c                	je     bf8 <malloc+0x88>
  hp->s.size = nu;
 bdc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bdf:	83 ec 0c             	sub    $0xc,%esp
 be2:	83 c0 08             	add    $0x8,%eax
 be5:	50                   	push   %eax
 be6:	e8 f5 fe ff ff       	call   ae0 <free>
  return freep;
 beb:	8b 15 34 11 00 00    	mov    0x1134,%edx
      if((p = morecore(nunits)) == 0)
 bf1:	83 c4 10             	add    $0x10,%esp
 bf4:	85 d2                	test   %edx,%edx
 bf6:	75 c0                	jne    bb8 <malloc+0x48>
        return 0;
  }
}
 bf8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bfb:	31 c0                	xor    %eax,%eax
}
 bfd:	5b                   	pop    %ebx
 bfe:	5e                   	pop    %esi
 bff:	5f                   	pop    %edi
 c00:	5d                   	pop    %ebp
 c01:	c3                   	ret    
 c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c08:	39 cf                	cmp    %ecx,%edi
 c0a:	74 54                	je     c60 <malloc+0xf0>
        p->s.size -= nunits;
 c0c:	29 f9                	sub    %edi,%ecx
 c0e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c11:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c14:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c17:	89 15 34 11 00 00    	mov    %edx,0x1134
}
 c1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c20:	83 c0 08             	add    $0x8,%eax
}
 c23:	5b                   	pop    %ebx
 c24:	5e                   	pop    %esi
 c25:	5f                   	pop    %edi
 c26:	5d                   	pop    %ebp
 c27:	c3                   	ret    
 c28:	90                   	nop
 c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c30:	c7 05 34 11 00 00 38 	movl   $0x1138,0x1134
 c37:	11 00 00 
 c3a:	c7 05 38 11 00 00 38 	movl   $0x1138,0x1138
 c41:	11 00 00 
    base.s.size = 0;
 c44:	b8 38 11 00 00       	mov    $0x1138,%eax
 c49:	c7 05 3c 11 00 00 00 	movl   $0x0,0x113c
 c50:	00 00 00 
 c53:	e9 44 ff ff ff       	jmp    b9c <malloc+0x2c>
 c58:	90                   	nop
 c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c60:	8b 08                	mov    (%eax),%ecx
 c62:	89 0a                	mov    %ecx,(%edx)
 c64:	eb b1                	jmp    c17 <malloc+0xa7>
