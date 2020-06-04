
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
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx


  int freeMem = getNumberOfFreePages();
       f:	e8 9e 0d 00 00       	call   db2 <getNumberOfFreePages>
      14:	89 c3                	mov    %eax,%ebx
  printResult(cowPhysicalTest());
      16:	e8 35 01 00 00       	call   150 <cowPhysicalTest>
  if(res == -1){
      1b:	83 f8 ff             	cmp    $0xffffffff,%eax
      1e:	0f 84 cb 00 00 00    	je     ef <main+0xef>
    printf(1," PASSED\n");
      24:	50                   	push   %eax
      25:	50                   	push   %eax
      26:	68 62 12 00 00       	push   $0x1262
      2b:	6a 01                	push   $0x1
      2d:	e8 2e 0e 00 00       	call   e60 <printf>
      32:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_pageSeperationTest());
      35:	e8 b6 02 00 00       	call   2f0 <cowSwapFile_pageSeperationTest>
  if(res == -1){
      3a:	83 f8 ff             	cmp    $0xffffffff,%eax
      3d:	0f 84 df 00 00 00    	je     122 <main+0x122>
    printf(1," PASSED\n");
      43:	50                   	push   %eax
      44:	50                   	push   %eax
      45:	68 62 12 00 00       	push   $0x1262
      4a:	6a 01                	push   $0x1
      4c:	e8 0f 0e 00 00       	call   e60 <printf>
      51:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_killedChiledTest());
      54:	e8 37 05 00 00       	call   590 <cowSwapFile_killedChiledTest>
  if(res == -1){
      59:	83 f8 ff             	cmp    $0xffffffff,%eax
      5c:	0f 84 b6 00 00 00    	je     118 <main+0x118>
    printf(1," PASSED\n");
      62:	50                   	push   %eax
      63:	50                   	push   %eax
      64:	68 62 12 00 00       	push   $0x1262
      69:	6a 01                	push   $0x1
      6b:	e8 f0 0d 00 00       	call   e60 <printf>
      70:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_maxPhyInChildTest());
      73:	e8 b8 03 00 00       	call   430 <cowSwapFile_maxPhyInChildTest>
  if(res == -1){
      78:	83 f8 ff             	cmp    $0xffffffff,%eax
      7b:	0f 84 8d 00 00 00    	je     10e <main+0x10e>
    printf(1," PASSED\n");
      81:	50                   	push   %eax
      82:	50                   	push   %eax
      83:	68 62 12 00 00       	push   $0x1262
      88:	6a 01                	push   $0x1
      8a:	e8 d1 0d 00 00       	call   e60 <printf>
      8f:	83 c4 10             	add    $0x10,%esp
  
  printResult(PhysicalMemTest ());
      92:	e8 99 06 00 00       	call   730 <PhysicalMemTest>
  if(res == -1){
      97:	83 f8 ff             	cmp    $0xffffffff,%eax
      9a:	74 6b                	je     107 <main+0x107>
    printf(1," PASSED\n");
      9c:	51                   	push   %ecx
      9d:	51                   	push   %ecx
      9e:	68 62 12 00 00       	push   $0x1262
      a3:	6a 01                	push   $0x1
      a5:	e8 b6 0d 00 00       	call   e60 <printf>
      aa:	83 c4 10             	add    $0x10,%esp
  printResult(SwapFileTest());
      ad:	e8 5e 07 00 00       	call   810 <SwapFileTest>
  if(res == -1){
      b2:	83 f8 ff             	cmp    $0xffffffff,%eax
      b5:	74 49                	je     100 <main+0x100>
    printf(1," PASSED\n");
      b7:	52                   	push   %edx
      b8:	52                   	push   %edx
      b9:	68 62 12 00 00       	push   $0x1262
      be:	6a 01                	push   $0x1
      c0:	e8 9b 0d 00 00       	call   e60 <printf>
      c5:	83 c4 10             	add    $0x10,%esp
  printResult(memLeakTest(freeMem));
      c8:	83 ec 0c             	sub    $0xc,%esp
      cb:	53                   	push   %ebx
      cc:	e8 1f 08 00 00       	call   8f0 <memLeakTest>
  if(res == -1){
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	83 f8 ff             	cmp    $0xffffffff,%eax
      d7:	74 20                	je     f9 <main+0xf9>
    printf(1," PASSED\n");
      d9:	50                   	push   %eax
      da:	50                   	push   %eax
      db:	68 62 12 00 00       	push   $0x1262
      e0:	6a 01                	push   $0x1
      e2:	e8 79 0d 00 00       	call   e60 <printf>
      e7:	83 c4 10             	add    $0x10,%esp

  exit();
      ea:	e8 23 0c 00 00       	call   d12 <exit>
      ef:	e8 3c 00 00 00       	call   130 <printResult.part.7>
      f4:	e9 3c ff ff ff       	jmp    35 <main+0x35>
      f9:	e8 32 00 00 00       	call   130 <printResult.part.7>
      fe:	eb ea                	jmp    ea <main+0xea>
     100:	e8 2b 00 00 00       	call   130 <printResult.part.7>
     105:	eb c1                	jmp    c8 <main+0xc8>
     107:	e8 24 00 00 00       	call   130 <printResult.part.7>
     10c:	eb 9f                	jmp    ad <main+0xad>
     10e:	e8 1d 00 00 00       	call   130 <printResult.part.7>
     113:	e9 7a ff ff ff       	jmp    92 <main+0x92>
     118:	e8 13 00 00 00       	call   130 <printResult.part.7>
     11d:	e9 51 ff ff ff       	jmp    73 <main+0x73>
     122:	e8 09 00 00 00       	call   130 <printResult.part.7>
     127:	e9 28 ff ff ff       	jmp    54 <main+0x54>
     12c:	66 90                	xchg   %ax,%ax
     12e:	66 90                	xchg   %ax,%ax

00000130 <printResult.part.7>:
printResult(int res){
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 10             	sub    $0x10,%esp
    printf(1," FAILED\n");
     136:	68 b8 11 00 00       	push   $0x11b8
     13b:	6a 01                	push   $0x1
     13d:	e8 1e 0d 00 00       	call   e60 <printf>
     142:	83 c4 10             	add    $0x10,%esp
}
     145:	c9                   	leave  
     146:	c3                   	ret    
     147:	89 f6                	mov    %esi,%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <cowPhysicalTest>:
cowPhysicalTest(){
     150:	55                   	push   %ebp
     151:	89 e5                	mov    %esp,%ebp
     153:	57                   	push   %edi
     154:	56                   	push   %esi
     155:	53                   	push   %ebx
     156:	83 ec 1c             	sub    $0x1c,%esp
  int testerPid = fork();
     159:	e8 ac 0b 00 00       	call   d0a <fork>
  if(testerPid==0){
     15e:	85 c0                	test   %eax,%eax
     160:	0f 85 e2 00 00 00    	jne    248 <cowPhysicalTest+0xf8>
    printf(1,"cowPhysicalTest :");
     166:	83 ec 08             	sub    $0x8,%esp
     169:	68 c1 11 00 00       	push   $0x11c1
     16e:	6a 01                	push   $0x1
     170:	e8 eb 0c 00 00       	call   e60 <printf>
    for(i = 0; i < 3; i++){
     175:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
     17c:	8b 45 d8             	mov    -0x28(%ebp),%eax
     17f:	83 c4 10             	add    $0x10,%esp
     182:	83 f8 02             	cmp    $0x2,%eax
     185:	7f 3d                	jg     1c4 <cowPhysicalTest+0x74>
     187:	89 f6                	mov    %esi,%esi
     189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      lst[i] = (int*)sbrk(PGSIZE);
     190:	83 ec 0c             	sub    $0xc,%esp
     193:	8b 5d d8             	mov    -0x28(%ebp),%ebx
     196:	68 00 10 00 00       	push   $0x1000
     19b:	e8 fa 0b 00 00       	call   d9a <sbrk>
     1a0:	89 44 9d dc          	mov    %eax,-0x24(%ebp,%ebx,4)
      *lst[i]=i;
     1a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
    for(i = 0; i < 3; i++){
     1a7:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     1aa:	8b 55 d8             	mov    -0x28(%ebp),%edx
     1ad:	8b 44 85 dc          	mov    -0x24(%ebp,%eax,4),%eax
     1b1:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 3; i++){
     1b3:	8b 45 d8             	mov    -0x28(%ebp),%eax
     1b6:	83 c0 01             	add    $0x1,%eax
     1b9:	89 45 d8             	mov    %eax,-0x28(%ebp)
     1bc:	8b 45 d8             	mov    -0x28(%ebp),%eax
     1bf:	83 f8 02             	cmp    $0x2,%eax
     1c2:	7e cc                	jle    190 <cowPhysicalTest+0x40>
    int freePages_beforeChild = getNumberOfFreePages();
     1c4:	e8 e9 0b 00 00       	call   db2 <getNumberOfFreePages>
    sleep(10);
     1c9:	83 ec 0c             	sub    $0xc,%esp
    int freePages_beforeChild = getNumberOfFreePages();
     1cc:	89 c7                	mov    %eax,%edi
    sleep(10);
     1ce:	6a 0a                	push   $0xa
     1d0:	e8 cd 0b 00 00       	call   da2 <sleep>
    int pid = fork();
     1d5:	e8 30 0b 00 00       	call   d0a <fork>
     1da:	89 c6                	mov    %eax,%esi
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
     1dc:	e8 d1 0b 00 00       	call   db2 <getNumberOfFreePages>
    sleep(10);
     1e1:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
     1e8:	89 c3                	mov    %eax,%ebx
    sleep(10);
     1ea:	e8 b3 0b 00 00       	call   da2 <sleep>
    if(pid==0){
     1ef:	83 c4 10             	add    $0x10,%esp
     1f2:	85 f6                	test   %esi,%esi
     1f4:	75 6a                	jne    260 <cowPhysicalTest+0x110>
      for(i = 0; i < 3; i++){
     1f6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
     1fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
     200:	83 f8 02             	cmp    $0x2,%eax
     203:	7e 1c                	jle    221 <cowPhysicalTest+0xd1>
     205:	e9 96 00 00 00       	jmp    2a0 <cowPhysicalTest+0x150>
     20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     210:	8b 45 d8             	mov    -0x28(%ebp),%eax
     213:	83 c0 01             	add    $0x1,%eax
     216:	89 45 d8             	mov    %eax,-0x28(%ebp)
     219:	8b 45 d8             	mov    -0x28(%ebp),%eax
     21c:	83 f8 02             	cmp    $0x2,%eax
     21f:	7f 7f                	jg     2a0 <cowPhysicalTest+0x150>
        if(*lst[i]!=i){
     221:	8b 55 d8             	mov    -0x28(%ebp),%edx
     224:	8b 45 d8             	mov    -0x28(%ebp),%eax
     227:	8b 54 95 dc          	mov    -0x24(%ebp,%edx,4),%edx
     22b:	39 02                	cmp    %eax,(%edx)
     22d:	74 e1                	je     210 <cowPhysicalTest+0xc0>
          printf(1," FAILED");
     22f:	83 ec 08             	sub    $0x8,%esp
     232:	68 d3 11 00 00       	push   $0x11d3
     237:	6a 01                	push   $0x1
     239:	e8 22 0c 00 00       	call   e60 <printf>
     23e:	83 c4 10             	add    $0x10,%esp
     241:	eb 4b                	jmp    28e <cowPhysicalTest+0x13e>
     243:	90                   	nop
     244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     248:	e8 cd 0a 00 00       	call   d1a <wait>
}
     24d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
     250:	31 c0                	xor    %eax,%eax
}
     252:	5b                   	pop    %ebx
     253:	5e                   	pop    %esi
     254:	5f                   	pop    %edi
     255:	5d                   	pop    %ebp
     256:	c3                   	ret    
     257:	89 f6                	mov    %esi,%esi
     259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    wait();
     260:	e8 b5 0a 00 00       	call   d1a <wait>
    if(freePages_beforeChild != getNumberOfFreePages()){
     265:	e8 48 0b 00 00       	call   db2 <getNumberOfFreePages>
     26a:	39 c7                	cmp    %eax,%edi
     26c:	74 64                	je     2d2 <cowPhysicalTest+0x182>
      printf(1,"Err : num of free pages after child exit");
     26e:	83 ec 08             	sub    $0x8,%esp
     271:	68 cc 12 00 00       	push   $0x12cc
     276:	6a 01                	push   $0x1
     278:	e8 e3 0b 00 00       	call   e60 <printf>
      printf(1," FAILED");
     27d:	58                   	pop    %eax
     27e:	5a                   	pop    %edx
     27f:	68 d3 11 00 00       	push   $0x11d3
     284:	6a 01                	push   $0x1
     286:	e8 d5 0b 00 00       	call   e60 <printf>
     28b:	83 c4 10             	add    $0x10,%esp
}
     28e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     291:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     296:	5b                   	pop    %ebx
     297:	5e                   	pop    %esi
     298:	5f                   	pop    %edi
     299:	5d                   	pop    %ebp
     29a:	c3                   	ret    
     29b:	90                   	nop
     29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      int freePages_beforeCloning = getNumberOfFreePages();
     2a0:	e8 0d 0b 00 00       	call   db2 <getNumberOfFreePages>
      if(freePages_beforeReadingFromParent != freePages_beforeCloning){
     2a5:	39 c3                	cmp    %eax,%ebx
     2a7:	75 1f                	jne    2c8 <cowPhysicalTest+0x178>
      *lst[1] = 66;
     2a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     2ac:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(freePages_beforeCloning != getNumberOfFreePages()+1){
     2b2:	e8 fb 0a 00 00       	call   db2 <getNumberOfFreePages>
     2b7:	83 c0 01             	add    $0x1,%eax
     2ba:	39 c3                	cmp    %eax,%ebx
     2bc:	74 19                	je     2d7 <cowPhysicalTest+0x187>
        printf(1,"Err : num of free pages after cloning");
     2be:	83 ec 08             	sub    $0x8,%esp
     2c1:	68 a4 12 00 00       	push   $0x12a4
     2c6:	eb ae                	jmp    276 <cowPhysicalTest+0x126>
        printf(1,"Err : num of free pages after reading only has changed");
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	68 6c 12 00 00       	push   $0x126c
     2d0:	eb a4                	jmp    276 <cowPhysicalTest+0x126>
    exit();
     2d2:	e8 3b 0a 00 00       	call   d12 <exit>
      sleep(10);
     2d7:	83 ec 0c             	sub    $0xc,%esp
     2da:	6a 0a                	push   $0xa
     2dc:	e8 c1 0a 00 00       	call   da2 <sleep>
      exit();
     2e1:	e8 2c 0a 00 00       	call   d12 <exit>
     2e6:	8d 76 00             	lea    0x0(%esi),%esi
     2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <cowSwapFile_pageSeperationTest>:
cowSwapFile_pageSeperationTest(){
     2f0:	55                   	push   %ebp
     2f1:	89 e5                	mov    %esp,%ebp
     2f3:	56                   	push   %esi
     2f4:	53                   	push   %ebx
     2f5:	83 ec 60             	sub    $0x60,%esp
  int testerPid = fork();
     2f8:	e8 0d 0a 00 00       	call   d0a <fork>
  if(testerPid==0){
     2fd:	85 c0                	test   %eax,%eax
     2ff:	0f 85 0b 01 00 00    	jne    410 <cowSwapFile_pageSeperationTest+0x120>
    printf(1,"cowSwapFile_pageSeperationTest :");
     305:	83 ec 08             	sub    $0x8,%esp
     308:	89 c3                	mov    %eax,%ebx
     30a:	68 f8 12 00 00       	push   $0x12f8
     30f:	6a 01                	push   $0x1
     311:	e8 4a 0b 00 00       	call   e60 <printf>
    for(i = 0; i < 20; i++){
     316:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     31d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     320:	83 c4 10             	add    $0x10,%esp
     323:	83 f8 13             	cmp    $0x13,%eax
     326:	7f 3c                	jg     364 <cowSwapFile_pageSeperationTest+0x74>
     328:	90                   	nop
     329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     330:	83 ec 0c             	sub    $0xc,%esp
     333:	8b 75 a4             	mov    -0x5c(%ebp),%esi
     336:	68 00 10 00 00       	push   $0x1000
     33b:	e8 5a 0a 00 00       	call   d9a <sbrk>
     340:	89 44 b5 a8          	mov    %eax,-0x58(%ebp,%esi,4)
      *lst[i]=i;
     344:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 20; i++){
     347:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     34a:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     34d:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     351:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 20; i++){
     353:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     356:	83 c0 01             	add    $0x1,%eax
     359:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     35c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     35f:	83 f8 13             	cmp    $0x13,%eax
     362:	7e cc                	jle    330 <cowSwapFile_pageSeperationTest+0x40>
    int pid = fork();
     364:	e8 a1 09 00 00       	call   d0a <fork>
    if(pid==0){
     369:	85 c0                	test   %eax,%eax
     36b:	0f 85 87 00 00 00    	jne    3f8 <cowSwapFile_pageSeperationTest+0x108>
      for(i = 19; i >= 0; i--){
     371:	c7 45 a4 13 00 00 00 	movl   $0x13,-0x5c(%ebp)
     378:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     37b:	85 c0                	test   %eax,%eax
     37d:	79 1d                	jns    39c <cowSwapFile_pageSeperationTest+0xac>
     37f:	e9 a1 00 00 00       	jmp    425 <cowSwapFile_pageSeperationTest+0x135>
     384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     388:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     38b:	83 e8 01             	sub    $0x1,%eax
     38e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     391:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     394:	85 c0                	test   %eax,%eax
     396:	0f 88 89 00 00 00    	js     425 <cowSwapFile_pageSeperationTest+0x135>
        if(*lst[i]!=i){
     39c:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     39f:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     3a2:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     3a6:	39 02                	cmp    %eax,(%edx)
     3a8:	74 de                	je     388 <cowSwapFile_pageSeperationTest+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     3aa:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     3ad:	83 ec 04             	sub    $0x4,%esp
     3b0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     3b3:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     3b7:	39 02                	cmp    %eax,(%edx)
     3b9:	0f 95 c0             	setne  %al
     3bc:	0f b6 c0             	movzbl %al,%eax
     3bf:	50                   	push   %eax
     3c0:	68 db 11 00 00       	push   $0x11db
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     3c5:	6a 01                	push   $0x1
     3c7:	e8 94 0a 00 00       	call   e60 <printf>
          printf(1," FAILED");
     3cc:	58                   	pop    %eax
     3cd:	5a                   	pop    %edx
     3ce:	68 d3 11 00 00       	push   $0x11d3
     3d3:	6a 01                	push   $0x1
     3d5:	e8 86 0a 00 00       	call   e60 <printf>
     3da:	83 c4 10             	add    $0x10,%esp
}
     3dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
     3e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3e5:	5b                   	pop    %ebx
     3e6:	5e                   	pop    %esi
     3e7:	5d                   	pop    %ebp
     3e8:	c3                   	ret    
     3e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(j = 0; j < 20; j++){
     3f0:	83 c3 01             	add    $0x1,%ebx
     3f3:	83 fb 14             	cmp    $0x14,%ebx
     3f6:	74 28                	je     420 <cowSwapFile_pageSeperationTest+0x130>
        if(*lst[j]!=j){
     3f8:	8b 44 9d a8          	mov    -0x58(%ebp,%ebx,4),%eax
     3fc:	3b 18                	cmp    (%eax),%ebx
     3fe:	74 f0                	je     3f0 <cowSwapFile_pageSeperationTest+0x100>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     400:	83 ec 04             	sub    $0x4,%esp
     403:	6a 01                	push   $0x1
     405:	68 ee 11 00 00       	push   $0x11ee
     40a:	eb b9                	jmp    3c5 <cowSwapFile_pageSeperationTest+0xd5>
     40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     410:	e8 05 09 00 00       	call   d1a <wait>
}
     415:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     418:	31 c0                	xor    %eax,%eax
}
     41a:	5b                   	pop    %ebx
     41b:	5e                   	pop    %esi
     41c:	5d                   	pop    %ebp
     41d:	c3                   	ret    
     41e:	66 90                	xchg   %ax,%ax
    wait();
     420:	e8 f5 08 00 00       	call   d1a <wait>
    exit();
     425:	e8 e8 08 00 00       	call   d12 <exit>
     42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	57                   	push   %edi
     434:	56                   	push   %esi
     435:	53                   	push   %ebx
     436:	83 ec 5c             	sub    $0x5c,%esp
  int testerPid = fork();
     439:	e8 cc 08 00 00       	call   d0a <fork>
  if(testerPid==0){
     43e:	85 c0                	test   %eax,%eax
     440:	0f 85 aa 00 00 00    	jne    4f0 <cowSwapFile_maxPhyInChildTest+0xc0>
     446:	89 c6                	mov    %eax,%esi
    for(i = 0; i < 20; i++){
     448:	31 db                	xor    %ebx,%ebx
    int freePages = getNumberOfFreePages();
     44a:	e8 63 09 00 00       	call   db2 <getNumberOfFreePages>
    printf(1,"cowSwapFile_maxPhyInChildTest :");
     44f:	83 ec 08             	sub    $0x8,%esp
    int freePages = getNumberOfFreePages();
     452:	89 c7                	mov    %eax,%edi
    printf(1,"cowSwapFile_maxPhyInChildTest :");
     454:	68 1c 13 00 00       	push   $0x131c
     459:	6a 01                	push   $0x1
     45b:	e8 00 0a 00 00       	call   e60 <printf>
     460:	83 c4 10             	add    $0x10,%esp
     463:	90                   	nop
     464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     468:	83 ec 0c             	sub    $0xc,%esp
     46b:	68 00 10 00 00       	push   $0x1000
     470:	e8 25 09 00 00       	call   d9a <sbrk>
     475:	89 44 9d 98          	mov    %eax,-0x68(%ebp,%ebx,4)
      *lst[i]=i;
     479:	89 18                	mov    %ebx,(%eax)
    for(i = 0; i < 20; i++){
     47b:	83 c3 01             	add    $0x1,%ebx
     47e:	83 c4 10             	add    $0x10,%esp
     481:	83 fb 14             	cmp    $0x14,%ebx
     484:	75 e2                	jne    468 <cowSwapFile_maxPhyInChildTest+0x38>
    if(freePages != getNumberOfFreePages()+16){
     486:	e8 27 09 00 00       	call   db2 <getNumberOfFreePages>
     48b:	83 c0 10             	add    $0x10,%eax
     48e:	39 c7                	cmp    %eax,%edi
     490:	75 6e                	jne    500 <cowSwapFile_maxPhyInChildTest+0xd0>
    int pid = fork();
     492:	e8 73 08 00 00       	call   d0a <fork>
    if(pid==0){
     497:	85 c0                	test   %eax,%eax
     499:	0f 84 92 00 00 00    	je     531 <cowSwapFile_maxPhyInChildTest+0x101>
    wait();
     49f:	e8 76 08 00 00       	call   d1a <wait>
     4a4:	eb 12                	jmp    4b8 <cowSwapFile_maxPhyInChildTest+0x88>
     4a6:	8d 76 00             	lea    0x0(%esi),%esi
     4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(j = 0; j < 20; j++){
     4b0:	83 c6 01             	add    $0x1,%esi
     4b3:	83 fe 14             	cmp    $0x14,%esi
     4b6:	74 68                	je     520 <cowSwapFile_maxPhyInChildTest+0xf0>
        if(*lst[j]!=j){
     4b8:	8b 44 b5 98          	mov    -0x68(%ebp,%esi,4),%eax
     4bc:	39 30                	cmp    %esi,(%eax)
     4be:	74 f0                	je     4b0 <cowSwapFile_maxPhyInChildTest+0x80>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	6a 01                	push   $0x1
     4c5:	68 ee 11 00 00       	push   $0x11ee
     4ca:	6a 01                	push   $0x1
     4cc:	e8 8f 09 00 00       	call   e60 <printf>
          printf(1," FAILED");
     4d1:	58                   	pop    %eax
     4d2:	5a                   	pop    %edx
     4d3:	68 d3 11 00 00       	push   $0x11d3
     4d8:	6a 01                	push   $0x1
     4da:	e8 81 09 00 00       	call   e60 <printf>
     4df:	83 c4 10             	add    $0x10,%esp
}
     4e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     4ea:	5b                   	pop    %ebx
     4eb:	5e                   	pop    %esi
     4ec:	5f                   	pop    %edi
     4ed:	5d                   	pop    %ebp
     4ee:	c3                   	ret    
     4ef:	90                   	nop
    wait();
     4f0:	e8 25 08 00 00       	call   d1a <wait>
}
     4f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
     4f8:	31 c0                	xor    %eax,%eax
}
     4fa:	5b                   	pop    %ebx
     4fb:	5e                   	pop    %esi
     4fc:	5f                   	pop    %edi
     4fd:	5d                   	pop    %ebp
     4fe:	c3                   	ret    
     4ff:	90                   	nop
      printf(1," FAILED (Free Memory error)\n");
     500:	83 ec 08             	sub    $0x8,%esp
     503:	68 02 12 00 00       	push   $0x1202
     508:	6a 01                	push   $0x1
     50a:	e8 51 09 00 00       	call   e60 <printf>
     50f:	83 c4 10             	add    $0x10,%esp
     512:	e9 7b ff ff ff       	jmp    492 <cowSwapFile_maxPhyInChildTest+0x62>
     517:	89 f6                	mov    %esi,%esi
     519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(freePages != getNumberOfFreePages()+16){
     520:	e8 8d 08 00 00       	call   db2 <getNumberOfFreePages>
     525:	83 c0 10             	add    $0x10,%eax
     528:	39 c7                	cmp    %eax,%edi
     52a:	75 44                	jne    570 <cowSwapFile_maxPhyInChildTest+0x140>
      exit();
     52c:	e8 e1 07 00 00       	call   d12 <exit>
      if(freePages != getNumberOfFreePages()+84){
     531:	e8 7c 08 00 00       	call   db2 <getNumberOfFreePages>
     536:	83 c0 54             	add    $0x54,%eax
     539:	39 c7                	cmp    %eax,%edi
     53b:	74 11                	je     54e <cowSwapFile_maxPhyInChildTest+0x11e>
      printf(1," FAILED (Free Memory error)\n");
     53d:	51                   	push   %ecx
     53e:	51                   	push   %ecx
     53f:	68 02 12 00 00       	push   $0x1202
     544:	6a 01                	push   $0x1
     546:	e8 15 09 00 00       	call   e60 <printf>
     54b:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < 20; i++){
     54e:	b8 32 00 00 00       	mov    $0x32,%eax
        *lst[i]= i + 50;
     553:	8b 94 85 d0 fe ff ff 	mov    -0x130(%ebp,%eax,4),%edx
     55a:	89 02                	mov    %eax,(%edx)
     55c:	83 c0 01             	add    $0x1,%eax
      for(i = 0; i < 20; i++){
     55f:	83 f8 46             	cmp    $0x46,%eax
     562:	75 ef                	jne    553 <cowSwapFile_maxPhyInChildTest+0x123>
      if(freePages != getNumberOfFreePages()+100){
     564:	e8 49 08 00 00       	call   db2 <getNumberOfFreePages>
     569:	83 c0 64             	add    $0x64,%eax
     56c:	39 c7                	cmp    %eax,%edi
     56e:	74 bc                	je     52c <cowSwapFile_maxPhyInChildTest+0xfc>
        printf(1," FAILED (Free Memory error)\n");
     570:	83 ec 08             	sub    $0x8,%esp
     573:	68 02 12 00 00       	push   $0x1202
     578:	6a 01                	push   $0x1
     57a:	e8 e1 08 00 00       	call   e60 <printf>
     57f:	83 c4 10             	add    $0x10,%esp
     582:	eb a8                	jmp    52c <cowSwapFile_maxPhyInChildTest+0xfc>
     584:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     58a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000590 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	56                   	push   %esi
     594:	53                   	push   %ebx
     595:	83 ec 60             	sub    $0x60,%esp
  int testerPid = fork();
     598:	e8 6d 07 00 00       	call   d0a <fork>
  if(testerPid==0){
     59d:	85 c0                	test   %eax,%eax
     59f:	0f 85 eb 00 00 00    	jne    690 <cowSwapFile_killedChiledTest+0x100>
    printf(1,"cowSwapFile_killedChiledTest :");
     5a5:	83 ec 08             	sub    $0x8,%esp
     5a8:	89 c3                	mov    %eax,%ebx
     5aa:	68 3c 13 00 00       	push   $0x133c
     5af:	6a 01                	push   $0x1
     5b1:	e8 aa 08 00 00       	call   e60 <printf>
    for(i = 0; i < 20; i++){
     5b6:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     5bd:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5c0:	83 c4 10             	add    $0x10,%esp
     5c3:	83 f8 13             	cmp    $0x13,%eax
     5c6:	7f 3c                	jg     604 <cowSwapFile_killedChiledTest+0x74>
     5c8:	90                   	nop
     5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     5d0:	83 ec 0c             	sub    $0xc,%esp
     5d3:	8b 75 a4             	mov    -0x5c(%ebp),%esi
     5d6:	68 00 10 00 00       	push   $0x1000
     5db:	e8 ba 07 00 00       	call   d9a <sbrk>
     5e0:	89 44 b5 a8          	mov    %eax,-0x58(%ebp,%esi,4)
      *lst[i]=i;
     5e4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 20; i++){
     5e7:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     5ea:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     5ed:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     5f1:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 20; i++){
     5f3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5f6:	83 c0 01             	add    $0x1,%eax
     5f9:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     5fc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5ff:	83 f8 13             	cmp    $0x13,%eax
     602:	7e cc                	jle    5d0 <cowSwapFile_killedChiledTest+0x40>
    int pid = fork();
     604:	e8 01 07 00 00       	call   d0a <fork>
    if(pid==0){
     609:	85 c0                	test   %eax,%eax
     60b:	0f 85 8f 00 00 00    	jne    6a0 <cowSwapFile_killedChiledTest+0x110>
      for(i = 0; i < 20; i++){
     611:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     618:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     61b:	83 f8 13             	cmp    $0x13,%eax
     61e:	7e 1d                	jle    63d <cowSwapFile_killedChiledTest+0xad>
     620:	e9 ab 00 00 00       	jmp    6d0 <cowSwapFile_killedChiledTest+0x140>
     625:	8d 76 00             	lea    0x0(%esi),%esi
     628:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     62b:	83 c0 01             	add    $0x1,%eax
     62e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     631:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     634:	83 f8 13             	cmp    $0x13,%eax
     637:	0f 8f 93 00 00 00    	jg     6d0 <cowSwapFile_killedChiledTest+0x140>
        if(*lst[i]!=i){
     63d:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     640:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     643:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     647:	39 02                	cmp    %eax,(%edx)
     649:	74 dd                	je     628 <cowSwapFile_killedChiledTest+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     64b:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     64e:	83 ec 04             	sub    $0x4,%esp
     651:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     654:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     658:	39 02                	cmp    %eax,(%edx)
     65a:	0f 95 c0             	setne  %al
     65d:	0f b6 c0             	movzbl %al,%eax
     660:	50                   	push   %eax
     661:	68 db 11 00 00       	push   $0x11db
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     666:	6a 01                	push   $0x1
     668:	e8 f3 07 00 00       	call   e60 <printf>
          printf(1," FAILED");
     66d:	58                   	pop    %eax
     66e:	5a                   	pop    %edx
     66f:	68 d3 11 00 00       	push   $0x11d3
     674:	6a 01                	push   $0x1
     676:	e8 e5 07 00 00       	call   e60 <printf>
     67b:	83 c4 10             	add    $0x10,%esp
}
     67e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     686:	5b                   	pop    %ebx
     687:	5e                   	pop    %esi
     688:	5d                   	pop    %ebp
     689:	c3                   	ret    
     68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wait();
     690:	e8 85 06 00 00       	call   d1a <wait>
}
     695:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     698:	31 c0                	xor    %eax,%eax
}
     69a:	5b                   	pop    %ebx
     69b:	5e                   	pop    %esi
     69c:	5d                   	pop    %ebp
     69d:	c3                   	ret    
     69e:	66 90                	xchg   %ax,%ax
    wait();
     6a0:	e8 75 06 00 00       	call   d1a <wait>
     6a5:	eb 11                	jmp    6b8 <cowSwapFile_killedChiledTest+0x128>
     6a7:	89 f6                	mov    %esi,%esi
     6a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(j = 0; j < 20; j++){
     6b0:	83 c3 01             	add    $0x1,%ebx
     6b3:	83 fb 14             	cmp    $0x14,%ebx
     6b6:	74 68                	je     720 <cowSwapFile_killedChiledTest+0x190>
        if(*lst[j]!=j){
     6b8:	8b 44 9d a8          	mov    -0x58(%ebp,%ebx,4),%eax
     6bc:	3b 18                	cmp    (%eax),%ebx
     6be:	74 f0                	je     6b0 <cowSwapFile_killedChiledTest+0x120>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     6c0:	83 ec 04             	sub    $0x4,%esp
     6c3:	6a 01                	push   $0x1
     6c5:	68 ee 11 00 00       	push   $0x11ee
     6ca:	eb 9a                	jmp    666 <cowSwapFile_killedChiledTest+0xd6>
     6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < 20; i++){
     6d0:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     6d7:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     6da:	83 f8 13             	cmp    $0x13,%eax
     6dd:	7e 1a                	jle    6f9 <cowSwapFile_killedChiledTest+0x169>
     6df:	eb 3f                	jmp    720 <cowSwapFile_killedChiledTest+0x190>
     6e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6e8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     6eb:	83 c0 01             	add    $0x1,%eax
     6ee:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     6f1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     6f4:	83 f8 13             	cmp    $0x13,%eax
     6f7:	7f 27                	jg     720 <cowSwapFile_killedChiledTest+0x190>
        *lst[i] = 66;
     6f9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     6fc:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     700:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
        if(*lst[i]!=66){
     706:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     709:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     70d:	83 38 42             	cmpl   $0x42,(%eax)
     710:	74 d6                	je     6e8 <cowSwapFile_killedChiledTest+0x158>
     712:	e9 34 ff ff ff       	jmp    64b <cowSwapFile_killedChiledTest+0xbb>
     717:	89 f6                	mov    %esi,%esi
     719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
     720:	e8 ed 05 00 00       	call   d12 <exit>
     725:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000730 <PhysicalMemTest>:
PhysicalMemTest(){
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	53                   	push   %ebx
     734:	83 ec 24             	sub    $0x24,%esp
  int testerPid = fork();
     737:	e8 ce 05 00 00       	call   d0a <fork>
  if(testerPid==0){
     73c:	85 c0                	test   %eax,%eax
     73e:	0f 85 ac 00 00 00    	jne    7f0 <PhysicalMemTest+0xc0>
    printf(1,"PhysicalMemTest :");
     744:	83 ec 08             	sub    $0x8,%esp
     747:	68 1f 12 00 00       	push   $0x121f
     74c:	6a 01                	push   $0x1
     74e:	e8 0d 07 00 00       	call   e60 <printf>
    for(i = 0; i < 5; i++){
     753:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     75a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     75d:	83 c4 10             	add    $0x10,%esp
     760:	83 f8 04             	cmp    $0x4,%eax
     763:	7f 37                	jg     79c <PhysicalMemTest+0x6c>
     765:	8d 76 00             	lea    0x0(%esi),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     768:	83 ec 0c             	sub    $0xc,%esp
     76b:	8b 5d e0             	mov    -0x20(%ebp),%ebx
     76e:	68 00 10 00 00       	push   $0x1000
     773:	e8 22 06 00 00       	call   d9a <sbrk>
     778:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
      *lst[i]=i;
     77c:	8b 45 e0             	mov    -0x20(%ebp),%eax
    for(i = 0; i < 5; i++){
     77f:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     782:	8b 55 e0             	mov    -0x20(%ebp),%edx
     785:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
     789:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 5; i++){
     78b:	8b 45 e0             	mov    -0x20(%ebp),%eax
     78e:	83 c0 01             	add    $0x1,%eax
     791:	89 45 e0             	mov    %eax,-0x20(%ebp)
     794:	8b 45 e0             	mov    -0x20(%ebp),%eax
     797:	83 f8 04             	cmp    $0x4,%eax
     79a:	7e cc                	jle    768 <PhysicalMemTest+0x38>
    for(i = 0; i < 5; i++){
     79c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     7a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7a6:	83 f8 04             	cmp    $0x4,%eax
     7a9:	7e 16                	jle    7c1 <PhysicalMemTest+0x91>
     7ab:	eb 4f                	jmp    7fc <PhysicalMemTest+0xcc>
     7ad:	8d 76 00             	lea    0x0(%esi),%esi
     7b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7b3:	83 c0 01             	add    $0x1,%eax
     7b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
     7b9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7bc:	83 f8 04             	cmp    $0x4,%eax
     7bf:	7f 3b                	jg     7fc <PhysicalMemTest+0xcc>
      if(*lst[i]!=i){
     7c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
     7c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7c7:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
     7cb:	39 02                	cmp    %eax,(%edx)
     7cd:	74 e1                	je     7b0 <PhysicalMemTest+0x80>
        printf(1," FAILED");
     7cf:	83 ec 08             	sub    $0x8,%esp
     7d2:	68 d3 11 00 00       	push   $0x11d3
     7d7:	6a 01                	push   $0x1
     7d9:	e8 82 06 00 00       	call   e60 <printf>
     7de:	83 c4 10             	add    $0x10,%esp
     7e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     7e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7e9:	c9                   	leave  
     7ea:	c3                   	ret    
     7eb:	90                   	nop
     7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     7f0:	e8 25 05 00 00       	call   d1a <wait>
    return 0;
     7f5:	31 c0                	xor    %eax,%eax
}
     7f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     7fa:	c9                   	leave  
     7fb:	c3                   	ret    
    exit();
     7fc:	e8 11 05 00 00       	call   d12 <exit>
     801:	eb 0d                	jmp    810 <SwapFileTest>
     803:	90                   	nop
     804:	90                   	nop
     805:	90                   	nop
     806:	90                   	nop
     807:	90                   	nop
     808:	90                   	nop
     809:	90                   	nop
     80a:	90                   	nop
     80b:	90                   	nop
     80c:	90                   	nop
     80d:	90                   	nop
     80e:	90                   	nop
     80f:	90                   	nop

00000810 <SwapFileTest>:
SwapFileTest(){
     810:	55                   	push   %ebp
     811:	89 e5                	mov    %esp,%ebp
     813:	53                   	push   %ebx
     814:	83 ec 64             	sub    $0x64,%esp
  int testerPid = fork();
     817:	e8 ee 04 00 00       	call   d0a <fork>
  if(testerPid==0){
     81c:	85 c0                	test   %eax,%eax
     81e:	0f 85 ac 00 00 00    	jne    8d0 <SwapFileTest+0xc0>
    printf(1,"SwapFileTest :");
     824:	83 ec 08             	sub    $0x8,%esp
     827:	68 42 12 00 00       	push   $0x1242
     82c:	6a 01                	push   $0x1
     82e:	e8 2d 06 00 00       	call   e60 <printf>
    for(i = 0; i < 20; i++){
     833:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     83a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     83d:	83 c4 10             	add    $0x10,%esp
     840:	83 f8 13             	cmp    $0x13,%eax
     843:	7f 37                	jg     87c <SwapFileTest+0x6c>
     845:	8d 76 00             	lea    0x0(%esi),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     848:	83 ec 0c             	sub    $0xc,%esp
     84b:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
     84e:	68 00 10 00 00       	push   $0x1000
     853:	e8 42 05 00 00       	call   d9a <sbrk>
     858:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
      *lst[i]=i;
     85c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 20; i++){
     85f:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     862:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     865:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     869:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 20; i++){
     86b:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     86e:	83 c0 01             	add    $0x1,%eax
     871:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     874:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     877:	83 f8 13             	cmp    $0x13,%eax
     87a:	7e cc                	jle    848 <SwapFileTest+0x38>
    for(i = 0; i < 20; i++){
     87c:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     883:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     886:	83 f8 13             	cmp    $0x13,%eax
     889:	7e 16                	jle    8a1 <SwapFileTest+0x91>
     88b:	eb 4f                	jmp    8dc <SwapFileTest+0xcc>
     88d:	8d 76 00             	lea    0x0(%esi),%esi
     890:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     893:	83 c0 01             	add    $0x1,%eax
     896:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     899:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     89c:	83 f8 13             	cmp    $0x13,%eax
     89f:	7f 3b                	jg     8dc <SwapFileTest+0xcc>
      if(*lst[i]!=i){
     8a1:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     8a4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     8a7:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     8ab:	39 02                	cmp    %eax,(%edx)
     8ad:	74 e1                	je     890 <SwapFileTest+0x80>
        printf(1," FAILED");
     8af:	83 ec 08             	sub    $0x8,%esp
     8b2:	68 d3 11 00 00       	push   $0x11d3
     8b7:	6a 01                	push   $0x1
     8b9:	e8 a2 05 00 00       	call   e60 <printf>
     8be:	83 c4 10             	add    $0x10,%esp
     8c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     8c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8c9:	c9                   	leave  
     8ca:	c3                   	ret    
     8cb:	90                   	nop
     8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     8d0:	e8 45 04 00 00       	call   d1a <wait>
    return 0;
     8d5:	31 c0                	xor    %eax,%eax
}
     8d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8da:	c9                   	leave  
     8db:	c3                   	ret    
    exit();
     8dc:	e8 31 04 00 00       	call   d12 <exit>
     8e1:	eb 0d                	jmp    8f0 <memLeakTest>
     8e3:	90                   	nop
     8e4:	90                   	nop
     8e5:	90                   	nop
     8e6:	90                   	nop
     8e7:	90                   	nop
     8e8:	90                   	nop
     8e9:	90                   	nop
     8ea:	90                   	nop
     8eb:	90                   	nop
     8ec:	90                   	nop
     8ed:	90                   	nop
     8ee:	90                   	nop
     8ef:	90                   	nop

000008f0 <memLeakTest>:
memLeakTest(int freeMem){
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	83 ec 10             	sub    $0x10,%esp
  printf(1,"memLeakTest :");
     8f6:	68 31 12 00 00       	push   $0x1231
     8fb:	6a 01                	push   $0x1
     8fd:	e8 5e 05 00 00       	call   e60 <printf>
  if(freeMem != getNumberOfFreePages()){
     902:	e8 ab 04 00 00       	call   db2 <getNumberOfFreePages>
     907:	83 c4 10             	add    $0x10,%esp
     90a:	3b 45 08             	cmp    0x8(%ebp),%eax
     90d:	74 12                	je     921 <memLeakTest+0x31>
      printf(1, "FAILED\n");
     90f:	83 ec 08             	sub    $0x8,%esp
     912:	68 b9 11 00 00       	push   $0x11b9
     917:	6a 01                	push   $0x1
     919:	e8 42 05 00 00       	call   e60 <printf>
     91e:	83 c4 10             	add    $0x10,%esp
}
     921:	31 c0                	xor    %eax,%eax
     923:	c9                   	leave  
     924:	c3                   	ret    
     925:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000930 <test>:
test(){
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	56                   	push   %esi
     934:	53                   	push   %ebx
     935:	83 ec 40             	sub    $0x40,%esp
  int testerPid = fork();
     938:	e8 cd 03 00 00       	call   d0a <fork>
  if(testerPid==0){
     93d:	85 c0                	test   %eax,%eax
     93f:	0f 85 eb 00 00 00    	jne    a30 <test+0x100>
    printf(1,"cowSwapFileTest :");
     945:	83 ec 08             	sub    $0x8,%esp
     948:	89 c3                	mov    %eax,%ebx
     94a:	68 3f 12 00 00       	push   $0x123f
     94f:	6a 01                	push   $0x1
     951:	e8 0a 05 00 00       	call   e60 <printf>
    for(i = 0; i < 15; i++){
     956:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
     95d:	8b 45 b8             	mov    -0x48(%ebp),%eax
     960:	83 c4 10             	add    $0x10,%esp
     963:	83 f8 0e             	cmp    $0xe,%eax
     966:	7f 3c                	jg     9a4 <test+0x74>
     968:	90                   	nop
     969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     970:	83 ec 0c             	sub    $0xc,%esp
     973:	8b 75 b8             	mov    -0x48(%ebp),%esi
     976:	68 00 10 00 00       	push   $0x1000
     97b:	e8 1a 04 00 00       	call   d9a <sbrk>
     980:	89 44 b5 bc          	mov    %eax,-0x44(%ebp,%esi,4)
      *lst[i]=i;
     984:	8b 45 b8             	mov    -0x48(%ebp),%eax
    for(i = 0; i < 15; i++){
     987:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     98a:	8b 55 b8             	mov    -0x48(%ebp),%edx
     98d:	8b 44 85 bc          	mov    -0x44(%ebp,%eax,4),%eax
     991:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 15; i++){
     993:	8b 45 b8             	mov    -0x48(%ebp),%eax
     996:	83 c0 01             	add    $0x1,%eax
     999:	89 45 b8             	mov    %eax,-0x48(%ebp)
     99c:	8b 45 b8             	mov    -0x48(%ebp),%eax
     99f:	83 f8 0e             	cmp    $0xe,%eax
     9a2:	7e cc                	jle    970 <test+0x40>
    int pid = fork();
     9a4:	e8 61 03 00 00       	call   d0a <fork>
    if(pid==0){
     9a9:	85 c0                	test   %eax,%eax
     9ab:	0f 85 8f 00 00 00    	jne    a40 <test+0x110>
      for(i = 0; i < 15; i++){
     9b1:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
     9b8:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9bb:	83 f8 0e             	cmp    $0xe,%eax
     9be:	7e 1d                	jle    9dd <test+0xad>
     9c0:	e9 bf 00 00 00       	jmp    a84 <test+0x154>
     9c5:	8d 76 00             	lea    0x0(%esi),%esi
     9c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9cb:	83 c0 01             	add    $0x1,%eax
     9ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
     9d1:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9d4:	83 f8 0e             	cmp    $0xe,%eax
     9d7:	0f 8f a7 00 00 00    	jg     a84 <test+0x154>
        if(*lst[i]!=i){
     9dd:	8b 55 b8             	mov    -0x48(%ebp),%edx
     9e0:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9e3:	8b 54 95 bc          	mov    -0x44(%ebp,%edx,4),%edx
     9e7:	39 02                	cmp    %eax,(%edx)
     9e9:	74 dd                	je     9c8 <test+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     9eb:	8b 55 b8             	mov    -0x48(%ebp),%edx
     9ee:	83 ec 04             	sub    $0x4,%esp
     9f1:	8b 45 b8             	mov    -0x48(%ebp),%eax
     9f4:	8b 54 95 bc          	mov    -0x44(%ebp,%edx,4),%edx
     9f8:	39 02                	cmp    %eax,(%edx)
     9fa:	0f 95 c0             	setne  %al
     9fd:	0f b6 c0             	movzbl %al,%eax
     a00:	50                   	push   %eax
     a01:	68 db 11 00 00       	push   $0x11db
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     a06:	6a 01                	push   $0x1
     a08:	e8 53 04 00 00       	call   e60 <printf>
          printf(1," FAILED");
     a0d:	58                   	pop    %eax
     a0e:	5a                   	pop    %edx
     a0f:	68 d3 11 00 00       	push   $0x11d3
     a14:	6a 01                	push   $0x1
     a16:	e8 45 04 00 00       	call   e60 <printf>
          return -1;
     a1b:	83 c4 10             	add    $0x10,%esp
}
     a1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     a26:	5b                   	pop    %ebx
     a27:	5e                   	pop    %esi
     a28:	5d                   	pop    %ebp
     a29:	c3                   	ret    
     a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wait();
     a30:	e8 e5 02 00 00       	call   d1a <wait>
}
     a35:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     a38:	31 c0                	xor    %eax,%eax
}
     a3a:	5b                   	pop    %ebx
     a3b:	5e                   	pop    %esi
     a3c:	5d                   	pop    %ebp
     a3d:	c3                   	ret    
     a3e:	66 90                	xchg   %ax,%ax
    wait();
     a40:	e8 d5 02 00 00       	call   d1a <wait>
     a45:	eb 11                	jmp    a58 <test+0x128>
     a47:	89 f6                	mov    %esi,%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(j = 0; j < 15; j++){
     a50:	83 c3 01             	add    $0x1,%ebx
     a53:	83 fb 0f             	cmp    $0xf,%ebx
     a56:	74 18                	je     a70 <test+0x140>
        if(*lst[j]!=j){
     a58:	8b 44 9d bc          	mov    -0x44(%ebp,%ebx,4),%eax
     a5c:	39 18                	cmp    %ebx,(%eax)
     a5e:	74 f0                	je     a50 <test+0x120>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     a60:	83 ec 04             	sub    $0x4,%esp
     a63:	6a 01                	push   $0x1
     a65:	68 ee 11 00 00       	push   $0x11ee
     a6a:	eb 9a                	jmp    a06 <test+0xd6>
     a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1,"parent exit now\n");
     a70:	83 ec 08             	sub    $0x8,%esp
     a73:	68 51 12 00 00       	push   $0x1251
     a78:	6a 01                	push   $0x1
     a7a:	e8 e1 03 00 00       	call   e60 <printf>
    exit();
     a7f:	e8 8e 02 00 00       	call   d12 <exit>
      exit();
     a84:	e8 89 02 00 00       	call   d12 <exit>
     a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <printResult>:
printResult(int res){
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	83 ec 08             	sub    $0x8,%esp
  if(res == -1){
     a96:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
     a9a:	74 14                	je     ab0 <printResult+0x20>
    printf(1," PASSED\n");
     a9c:	83 ec 08             	sub    $0x8,%esp
     a9f:	68 62 12 00 00       	push   $0x1262
     aa4:	6a 01                	push   $0x1
     aa6:	e8 b5 03 00 00       	call   e60 <printf>
     aab:	83 c4 10             	add    $0x10,%esp
}
     aae:	c9                   	leave  
     aaf:	c3                   	ret    
     ab0:	c9                   	leave  
     ab1:	e9 7a f6 ff ff       	jmp    130 <printResult.part.7>
     ab6:	66 90                	xchg   %ax,%ax
     ab8:	66 90                	xchg   %ax,%ax
     aba:	66 90                	xchg   %ax,%ax
     abc:	66 90                	xchg   %ax,%ax
     abe:	66 90                	xchg   %ax,%ax

00000ac0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aca:	89 c2                	mov    %eax,%edx
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad0:	83 c1 01             	add    $0x1,%ecx
     ad3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ad7:	83 c2 01             	add    $0x1,%edx
     ada:	84 db                	test   %bl,%bl
     adc:	88 5a ff             	mov    %bl,-0x1(%edx)
     adf:	75 ef                	jne    ad0 <strcpy+0x10>
    ;
  return os;
}
     ae1:	5b                   	pop    %ebx
     ae2:	5d                   	pop    %ebp
     ae3:	c3                   	ret    
     ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000af0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
     af7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     afa:	0f b6 02             	movzbl (%edx),%eax
     afd:	0f b6 19             	movzbl (%ecx),%ebx
     b00:	84 c0                	test   %al,%al
     b02:	75 1c                	jne    b20 <strcmp+0x30>
     b04:	eb 2a                	jmp    b30 <strcmp+0x40>
     b06:	8d 76 00             	lea    0x0(%esi),%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b10:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b13:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b16:	83 c1 01             	add    $0x1,%ecx
     b19:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b1c:	84 c0                	test   %al,%al
     b1e:	74 10                	je     b30 <strcmp+0x40>
     b20:	38 d8                	cmp    %bl,%al
     b22:	74 ec                	je     b10 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b24:	29 d8                	sub    %ebx,%eax
}
     b26:	5b                   	pop    %ebx
     b27:	5d                   	pop    %ebp
     b28:	c3                   	ret    
     b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b30:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b32:	29 d8                	sub    %ebx,%eax
}
     b34:	5b                   	pop    %ebx
     b35:	5d                   	pop    %ebp
     b36:	c3                   	ret    
     b37:	89 f6                	mov    %esi,%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <strlen>:

uint
strlen(const char *s)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b46:	80 39 00             	cmpb   $0x0,(%ecx)
     b49:	74 15                	je     b60 <strlen+0x20>
     b4b:	31 d2                	xor    %edx,%edx
     b4d:	8d 76 00             	lea    0x0(%esi),%esi
     b50:	83 c2 01             	add    $0x1,%edx
     b53:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b57:	89 d0                	mov    %edx,%eax
     b59:	75 f5                	jne    b50 <strlen+0x10>
    ;
  return n;
}
     b5b:	5d                   	pop    %ebp
     b5c:	c3                   	ret    
     b5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b60:	31 c0                	xor    %eax,%eax
}
     b62:	5d                   	pop    %ebp
     b63:	c3                   	ret    
     b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7d:	89 d7                	mov    %edx,%edi
     b7f:	fc                   	cld    
     b80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b82:	89 d0                	mov    %edx,%eax
     b84:	5f                   	pop    %edi
     b85:	5d                   	pop    %ebp
     b86:	c3                   	ret    
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <strchr>:

char*
strchr(const char *s, char c)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	8b 45 08             	mov    0x8(%ebp),%eax
     b97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     b9a:	0f b6 10             	movzbl (%eax),%edx
     b9d:	84 d2                	test   %dl,%dl
     b9f:	74 1d                	je     bbe <strchr+0x2e>
    if(*s == c)
     ba1:	38 d3                	cmp    %dl,%bl
     ba3:	89 d9                	mov    %ebx,%ecx
     ba5:	75 0d                	jne    bb4 <strchr+0x24>
     ba7:	eb 17                	jmp    bc0 <strchr+0x30>
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb0:	38 ca                	cmp    %cl,%dl
     bb2:	74 0c                	je     bc0 <strchr+0x30>
  for(; *s; s++)
     bb4:	83 c0 01             	add    $0x1,%eax
     bb7:	0f b6 10             	movzbl (%eax),%edx
     bba:	84 d2                	test   %dl,%dl
     bbc:	75 f2                	jne    bb0 <strchr+0x20>
      return (char*)s;
  return 0;
     bbe:	31 c0                	xor    %eax,%eax
}
     bc0:	5b                   	pop    %ebx
     bc1:	5d                   	pop    %ebp
     bc2:	c3                   	ret    
     bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <gets>:

char*
gets(char *buf, int max)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bd6:	31 f6                	xor    %esi,%esi
     bd8:	89 f3                	mov    %esi,%ebx
{
     bda:	83 ec 1c             	sub    $0x1c,%esp
     bdd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     be0:	eb 2f                	jmp    c11 <gets+0x41>
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     be8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     beb:	83 ec 04             	sub    $0x4,%esp
     bee:	6a 01                	push   $0x1
     bf0:	50                   	push   %eax
     bf1:	6a 00                	push   $0x0
     bf3:	e8 32 01 00 00       	call   d2a <read>
    if(cc < 1)
     bf8:	83 c4 10             	add    $0x10,%esp
     bfb:	85 c0                	test   %eax,%eax
     bfd:	7e 1c                	jle    c1b <gets+0x4b>
      break;
    buf[i++] = c;
     bff:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c03:	83 c7 01             	add    $0x1,%edi
     c06:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c09:	3c 0a                	cmp    $0xa,%al
     c0b:	74 23                	je     c30 <gets+0x60>
     c0d:	3c 0d                	cmp    $0xd,%al
     c0f:	74 1f                	je     c30 <gets+0x60>
  for(i=0; i+1 < max; ){
     c11:	83 c3 01             	add    $0x1,%ebx
     c14:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c17:	89 fe                	mov    %edi,%esi
     c19:	7c cd                	jl     be8 <gets+0x18>
     c1b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c20:	c6 03 00             	movb   $0x0,(%ebx)
}
     c23:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c26:	5b                   	pop    %ebx
     c27:	5e                   	pop    %esi
     c28:	5f                   	pop    %edi
     c29:	5d                   	pop    %ebp
     c2a:	c3                   	ret    
     c2b:	90                   	nop
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c30:	8b 75 08             	mov    0x8(%ebp),%esi
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	01 de                	add    %ebx,%esi
     c38:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c3a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c40:	5b                   	pop    %ebx
     c41:	5e                   	pop    %esi
     c42:	5f                   	pop    %edi
     c43:	5d                   	pop    %ebp
     c44:	c3                   	ret    
     c45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <stat>:

int
stat(const char *n, struct stat *st)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	56                   	push   %esi
     c54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c55:	83 ec 08             	sub    $0x8,%esp
     c58:	6a 00                	push   $0x0
     c5a:	ff 75 08             	pushl  0x8(%ebp)
     c5d:	e8 f0 00 00 00       	call   d52 <open>
  if(fd < 0)
     c62:	83 c4 10             	add    $0x10,%esp
     c65:	85 c0                	test   %eax,%eax
     c67:	78 27                	js     c90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c69:	83 ec 08             	sub    $0x8,%esp
     c6c:	ff 75 0c             	pushl  0xc(%ebp)
     c6f:	89 c3                	mov    %eax,%ebx
     c71:	50                   	push   %eax
     c72:	e8 f3 00 00 00       	call   d6a <fstat>
  close(fd);
     c77:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c7a:	89 c6                	mov    %eax,%esi
  close(fd);
     c7c:	e8 b9 00 00 00       	call   d3a <close>
  return r;
     c81:	83 c4 10             	add    $0x10,%esp
}
     c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c87:	89 f0                	mov    %esi,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5d                   	pop    %ebp
     c8c:	c3                   	ret    
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c95:	eb ed                	jmp    c84 <stat+0x34>
     c97:	89 f6                	mov    %esi,%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <atoi>:

int
atoi(const char *s)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	53                   	push   %ebx
     ca4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ca7:	0f be 11             	movsbl (%ecx),%edx
     caa:	8d 42 d0             	lea    -0x30(%edx),%eax
     cad:	3c 09                	cmp    $0x9,%al
  n = 0;
     caf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cb4:	77 1f                	ja     cd5 <atoi+0x35>
     cb6:	8d 76 00             	lea    0x0(%esi),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     cc0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cc3:	83 c1 01             	add    $0x1,%ecx
     cc6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cca:	0f be 11             	movsbl (%ecx),%edx
     ccd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cd0:	80 fb 09             	cmp    $0x9,%bl
     cd3:	76 eb                	jbe    cc0 <atoi+0x20>
  return n;
}
     cd5:	5b                   	pop    %ebx
     cd6:	5d                   	pop    %ebp
     cd7:	c3                   	ret    
     cd8:	90                   	nop
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	53                   	push   %ebx
     ce5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cee:	85 db                	test   %ebx,%ebx
     cf0:	7e 14                	jle    d06 <memmove+0x26>
     cf2:	31 d2                	xor    %edx,%edx
     cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     cf8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d02:	39 d3                	cmp    %edx,%ebx
     d04:	75 f2                	jne    cf8 <memmove+0x18>
  return vdst;
}
     d06:	5b                   	pop    %ebx
     d07:	5e                   	pop    %esi
     d08:	5d                   	pop    %ebp
     d09:	c3                   	ret    

00000d0a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d0a:	b8 01 00 00 00       	mov    $0x1,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <exit>:
SYSCALL(exit)
     d12:	b8 02 00 00 00       	mov    $0x2,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <wait>:
SYSCALL(wait)
     d1a:	b8 03 00 00 00       	mov    $0x3,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <pipe>:
SYSCALL(pipe)
     d22:	b8 04 00 00 00       	mov    $0x4,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    

00000d2a <read>:
SYSCALL(read)
     d2a:	b8 05 00 00 00       	mov    $0x5,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <write>:
SYSCALL(write)
     d32:	b8 10 00 00 00       	mov    $0x10,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <close>:
SYSCALL(close)
     d3a:	b8 15 00 00 00       	mov    $0x15,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <kill>:
SYSCALL(kill)
     d42:	b8 06 00 00 00       	mov    $0x6,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <exec>:
SYSCALL(exec)
     d4a:	b8 07 00 00 00       	mov    $0x7,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <open>:
SYSCALL(open)
     d52:	b8 0f 00 00 00       	mov    $0xf,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <mknod>:
SYSCALL(mknod)
     d5a:	b8 11 00 00 00       	mov    $0x11,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <unlink>:
SYSCALL(unlink)
     d62:	b8 12 00 00 00       	mov    $0x12,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <fstat>:
SYSCALL(fstat)
     d6a:	b8 08 00 00 00       	mov    $0x8,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <link>:
SYSCALL(link)
     d72:	b8 13 00 00 00       	mov    $0x13,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <mkdir>:
SYSCALL(mkdir)
     d7a:	b8 14 00 00 00       	mov    $0x14,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <chdir>:
SYSCALL(chdir)
     d82:	b8 09 00 00 00       	mov    $0x9,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <dup>:
SYSCALL(dup)
     d8a:	b8 0a 00 00 00       	mov    $0xa,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <getpid>:
SYSCALL(getpid)
     d92:	b8 0b 00 00 00       	mov    $0xb,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <sbrk>:
SYSCALL(sbrk)
     d9a:	b8 0c 00 00 00       	mov    $0xc,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <sleep>:
SYSCALL(sleep)
     da2:	b8 0d 00 00 00       	mov    $0xd,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <uptime>:
SYSCALL(uptime)
     daa:	b8 0e 00 00 00       	mov    $0xe,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
     db2:	b8 16 00 00 00       	mov    $0x16,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    
     dba:	66 90                	xchg   %ax,%ax
     dbc:	66 90                	xchg   %ax,%ax
     dbe:	66 90                	xchg   %ax,%ax

00000dc0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	57                   	push   %edi
     dc4:	56                   	push   %esi
     dc5:	53                   	push   %ebx
     dc6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     dc9:	85 d2                	test   %edx,%edx
{
     dcb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     dce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     dd0:	79 76                	jns    e48 <printint+0x88>
     dd2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     dd6:	74 70                	je     e48 <printint+0x88>
    x = -xx;
     dd8:	f7 d8                	neg    %eax
    neg = 1;
     dda:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     de1:	31 f6                	xor    %esi,%esi
     de3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     de6:	eb 0a                	jmp    df2 <printint+0x32>
     de8:	90                   	nop
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     df0:	89 fe                	mov    %edi,%esi
     df2:	31 d2                	xor    %edx,%edx
     df4:	8d 7e 01             	lea    0x1(%esi),%edi
     df7:	f7 f1                	div    %ecx
     df9:	0f b6 92 64 13 00 00 	movzbl 0x1364(%edx),%edx
  }while((x /= base) != 0);
     e00:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e02:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     e05:	75 e9                	jne    df0 <printint+0x30>
  if(neg)
     e07:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e0a:	85 c0                	test   %eax,%eax
     e0c:	74 08                	je     e16 <printint+0x56>
    buf[i++] = '-';
     e0e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     e13:	8d 7e 02             	lea    0x2(%esi),%edi
     e16:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     e1a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
     e20:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     e23:	83 ec 04             	sub    $0x4,%esp
     e26:	83 ee 01             	sub    $0x1,%esi
     e29:	6a 01                	push   $0x1
     e2b:	53                   	push   %ebx
     e2c:	57                   	push   %edi
     e2d:	88 45 d7             	mov    %al,-0x29(%ebp)
     e30:	e8 fd fe ff ff       	call   d32 <write>

  while(--i >= 0)
     e35:	83 c4 10             	add    $0x10,%esp
     e38:	39 de                	cmp    %ebx,%esi
     e3a:	75 e4                	jne    e20 <printint+0x60>
    putc(fd, buf[i]);
}
     e3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e3f:	5b                   	pop    %ebx
     e40:	5e                   	pop    %esi
     e41:	5f                   	pop    %edi
     e42:	5d                   	pop    %ebp
     e43:	c3                   	ret    
     e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     e48:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     e4f:	eb 90                	jmp    de1 <printint+0x21>
     e51:	eb 0d                	jmp    e60 <printf>
     e53:	90                   	nop
     e54:	90                   	nop
     e55:	90                   	nop
     e56:	90                   	nop
     e57:	90                   	nop
     e58:	90                   	nop
     e59:	90                   	nop
     e5a:	90                   	nop
     e5b:	90                   	nop
     e5c:	90                   	nop
     e5d:	90                   	nop
     e5e:	90                   	nop
     e5f:	90                   	nop

00000e60 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     e60:	55                   	push   %ebp
     e61:	89 e5                	mov    %esp,%ebp
     e63:	57                   	push   %edi
     e64:	56                   	push   %esi
     e65:	53                   	push   %ebx
     e66:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e69:	8b 75 0c             	mov    0xc(%ebp),%esi
     e6c:	0f b6 1e             	movzbl (%esi),%ebx
     e6f:	84 db                	test   %bl,%bl
     e71:	0f 84 b3 00 00 00    	je     f2a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     e77:	8d 45 10             	lea    0x10(%ebp),%eax
     e7a:	83 c6 01             	add    $0x1,%esi
  state = 0;
     e7d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     e7f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e82:	eb 2f                	jmp    eb3 <printf+0x53>
     e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e88:	83 f8 25             	cmp    $0x25,%eax
     e8b:	0f 84 a7 00 00 00    	je     f38 <printf+0xd8>
  write(fd, &c, 1);
     e91:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e94:	83 ec 04             	sub    $0x4,%esp
     e97:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     e9a:	6a 01                	push   $0x1
     e9c:	50                   	push   %eax
     e9d:	ff 75 08             	pushl  0x8(%ebp)
     ea0:	e8 8d fe ff ff       	call   d32 <write>
     ea5:	83 c4 10             	add    $0x10,%esp
     ea8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     eab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     eaf:	84 db                	test   %bl,%bl
     eb1:	74 77                	je     f2a <printf+0xca>
    if(state == 0){
     eb3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     eb5:	0f be cb             	movsbl %bl,%ecx
     eb8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     ebb:	74 cb                	je     e88 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     ebd:	83 ff 25             	cmp    $0x25,%edi
     ec0:	75 e6                	jne    ea8 <printf+0x48>
      if(c == 'd'){
     ec2:	83 f8 64             	cmp    $0x64,%eax
     ec5:	0f 84 05 01 00 00    	je     fd0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     ecb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     ed1:	83 f9 70             	cmp    $0x70,%ecx
     ed4:	74 72                	je     f48 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     ed6:	83 f8 73             	cmp    $0x73,%eax
     ed9:	0f 84 99 00 00 00    	je     f78 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     edf:	83 f8 63             	cmp    $0x63,%eax
     ee2:	0f 84 08 01 00 00    	je     ff0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     ee8:	83 f8 25             	cmp    $0x25,%eax
     eeb:	0f 84 ef 00 00 00    	je     fe0 <printf+0x180>
  write(fd, &c, 1);
     ef1:	8d 45 e7             	lea    -0x19(%ebp),%eax
     ef4:	83 ec 04             	sub    $0x4,%esp
     ef7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     efb:	6a 01                	push   $0x1
     efd:	50                   	push   %eax
     efe:	ff 75 08             	pushl  0x8(%ebp)
     f01:	e8 2c fe ff ff       	call   d32 <write>
     f06:	83 c4 0c             	add    $0xc,%esp
     f09:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f0c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f0f:	6a 01                	push   $0x1
     f11:	50                   	push   %eax
     f12:	ff 75 08             	pushl  0x8(%ebp)
     f15:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f18:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     f1a:	e8 13 fe ff ff       	call   d32 <write>
  for(i = 0; fmt[i]; i++){
     f1f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     f23:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     f26:	84 db                	test   %bl,%bl
     f28:	75 89                	jne    eb3 <printf+0x53>
    }
  }
}
     f2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f2d:	5b                   	pop    %ebx
     f2e:	5e                   	pop    %esi
     f2f:	5f                   	pop    %edi
     f30:	5d                   	pop    %ebp
     f31:	c3                   	ret    
     f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     f38:	bf 25 00 00 00       	mov    $0x25,%edi
     f3d:	e9 66 ff ff ff       	jmp    ea8 <printf+0x48>
     f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     f48:	83 ec 0c             	sub    $0xc,%esp
     f4b:	b9 10 00 00 00       	mov    $0x10,%ecx
     f50:	6a 00                	push   $0x0
     f52:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     f55:	8b 45 08             	mov    0x8(%ebp),%eax
     f58:	8b 17                	mov    (%edi),%edx
     f5a:	e8 61 fe ff ff       	call   dc0 <printint>
        ap++;
     f5f:	89 f8                	mov    %edi,%eax
     f61:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f64:	31 ff                	xor    %edi,%edi
        ap++;
     f66:	83 c0 04             	add    $0x4,%eax
     f69:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f6c:	e9 37 ff ff ff       	jmp    ea8 <printf+0x48>
     f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     f78:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f7b:	8b 08                	mov    (%eax),%ecx
        ap++;
     f7d:	83 c0 04             	add    $0x4,%eax
     f80:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     f83:	85 c9                	test   %ecx,%ecx
     f85:	0f 84 8e 00 00 00    	je     1019 <printf+0x1b9>
        while(*s != 0){
     f8b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     f8e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     f90:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     f92:	84 c0                	test   %al,%al
     f94:	0f 84 0e ff ff ff    	je     ea8 <printf+0x48>
     f9a:	89 75 d0             	mov    %esi,-0x30(%ebp)
     f9d:	89 de                	mov    %ebx,%esi
     f9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fa2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     fa5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     fa8:	83 ec 04             	sub    $0x4,%esp
          s++;
     fab:	83 c6 01             	add    $0x1,%esi
     fae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     fb1:	6a 01                	push   $0x1
     fb3:	57                   	push   %edi
     fb4:	53                   	push   %ebx
     fb5:	e8 78 fd ff ff       	call   d32 <write>
        while(*s != 0){
     fba:	0f b6 06             	movzbl (%esi),%eax
     fbd:	83 c4 10             	add    $0x10,%esp
     fc0:	84 c0                	test   %al,%al
     fc2:	75 e4                	jne    fa8 <printf+0x148>
     fc4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
     fc7:	31 ff                	xor    %edi,%edi
     fc9:	e9 da fe ff ff       	jmp    ea8 <printf+0x48>
     fce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     fd0:	83 ec 0c             	sub    $0xc,%esp
     fd3:	b9 0a 00 00 00       	mov    $0xa,%ecx
     fd8:	6a 01                	push   $0x1
     fda:	e9 73 ff ff ff       	jmp    f52 <printf+0xf2>
     fdf:	90                   	nop
  write(fd, &c, 1);
     fe0:	83 ec 04             	sub    $0x4,%esp
     fe3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     fe6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     fe9:	6a 01                	push   $0x1
     feb:	e9 21 ff ff ff       	jmp    f11 <printf+0xb1>
        putc(fd, *ap);
     ff0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
     ff3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     ff6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
     ff8:	6a 01                	push   $0x1
        ap++;
     ffa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
     ffd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1000:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1003:	50                   	push   %eax
    1004:	ff 75 08             	pushl  0x8(%ebp)
    1007:	e8 26 fd ff ff       	call   d32 <write>
        ap++;
    100c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    100f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1012:	31 ff                	xor    %edi,%edi
    1014:	e9 8f fe ff ff       	jmp    ea8 <printf+0x48>
          s = "(null)";
    1019:	bb 5c 13 00 00       	mov    $0x135c,%ebx
        while(*s != 0){
    101e:	b8 28 00 00 00       	mov    $0x28,%eax
    1023:	e9 72 ff ff ff       	jmp    f9a <printf+0x13a>
    1028:	66 90                	xchg   %ax,%ax
    102a:	66 90                	xchg   %ax,%ax
    102c:	66 90                	xchg   %ax,%ax
    102e:	66 90                	xchg   %ax,%ax

00001030 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1030:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1031:	a1 fc 17 00 00       	mov    0x17fc,%eax
{
    1036:	89 e5                	mov    %esp,%ebp
    1038:	57                   	push   %edi
    1039:	56                   	push   %esi
    103a:	53                   	push   %ebx
    103b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    103e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1048:	39 c8                	cmp    %ecx,%eax
    104a:	8b 10                	mov    (%eax),%edx
    104c:	73 32                	jae    1080 <free+0x50>
    104e:	39 d1                	cmp    %edx,%ecx
    1050:	72 04                	jb     1056 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1052:	39 d0                	cmp    %edx,%eax
    1054:	72 32                	jb     1088 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1056:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1059:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    105c:	39 fa                	cmp    %edi,%edx
    105e:	74 30                	je     1090 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1060:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1063:	8b 50 04             	mov    0x4(%eax),%edx
    1066:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1069:	39 f1                	cmp    %esi,%ecx
    106b:	74 3a                	je     10a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    106d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    106f:	a3 fc 17 00 00       	mov    %eax,0x17fc
}
    1074:	5b                   	pop    %ebx
    1075:	5e                   	pop    %esi
    1076:	5f                   	pop    %edi
    1077:	5d                   	pop    %ebp
    1078:	c3                   	ret    
    1079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1080:	39 d0                	cmp    %edx,%eax
    1082:	72 04                	jb     1088 <free+0x58>
    1084:	39 d1                	cmp    %edx,%ecx
    1086:	72 ce                	jb     1056 <free+0x26>
{
    1088:	89 d0                	mov    %edx,%eax
    108a:	eb bc                	jmp    1048 <free+0x18>
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1090:	03 72 04             	add    0x4(%edx),%esi
    1093:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1096:	8b 10                	mov    (%eax),%edx
    1098:	8b 12                	mov    (%edx),%edx
    109a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    109d:	8b 50 04             	mov    0x4(%eax),%edx
    10a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10a3:	39 f1                	cmp    %esi,%ecx
    10a5:	75 c6                	jne    106d <free+0x3d>
    p->s.size += bp->s.size;
    10a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    10aa:	a3 fc 17 00 00       	mov    %eax,0x17fc
    p->s.size += bp->s.size;
    10af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    10b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    10b5:	89 10                	mov    %edx,(%eax)
}
    10b7:	5b                   	pop    %ebx
    10b8:	5e                   	pop    %esi
    10b9:	5f                   	pop    %edi
    10ba:	5d                   	pop    %ebp
    10bb:	c3                   	ret    
    10bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000010c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    10c0:	55                   	push   %ebp
    10c1:	89 e5                	mov    %esp,%ebp
    10c3:	57                   	push   %edi
    10c4:	56                   	push   %esi
    10c5:	53                   	push   %ebx
    10c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    10cc:	8b 15 fc 17 00 00    	mov    0x17fc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    10d2:	8d 78 07             	lea    0x7(%eax),%edi
    10d5:	c1 ef 03             	shr    $0x3,%edi
    10d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    10db:	85 d2                	test   %edx,%edx
    10dd:	0f 84 9d 00 00 00    	je     1180 <malloc+0xc0>
    10e3:	8b 02                	mov    (%edx),%eax
    10e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10e8:	39 cf                	cmp    %ecx,%edi
    10ea:	76 6c                	jbe    1158 <malloc+0x98>
    10ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    10f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    10f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    10fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1101:	eb 0e                	jmp    1111 <malloc+0x51>
    1103:	90                   	nop
    1104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1108:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    110a:	8b 48 04             	mov    0x4(%eax),%ecx
    110d:	39 f9                	cmp    %edi,%ecx
    110f:	73 47                	jae    1158 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1111:	39 05 fc 17 00 00    	cmp    %eax,0x17fc
    1117:	89 c2                	mov    %eax,%edx
    1119:	75 ed                	jne    1108 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    111b:	83 ec 0c             	sub    $0xc,%esp
    111e:	56                   	push   %esi
    111f:	e8 76 fc ff ff       	call   d9a <sbrk>
  if(p == (char*)-1)
    1124:	83 c4 10             	add    $0x10,%esp
    1127:	83 f8 ff             	cmp    $0xffffffff,%eax
    112a:	74 1c                	je     1148 <malloc+0x88>
  hp->s.size = nu;
    112c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    112f:	83 ec 0c             	sub    $0xc,%esp
    1132:	83 c0 08             	add    $0x8,%eax
    1135:	50                   	push   %eax
    1136:	e8 f5 fe ff ff       	call   1030 <free>
  return freep;
    113b:	8b 15 fc 17 00 00    	mov    0x17fc,%edx
      if((p = morecore(nunits)) == 0)
    1141:	83 c4 10             	add    $0x10,%esp
    1144:	85 d2                	test   %edx,%edx
    1146:	75 c0                	jne    1108 <malloc+0x48>
        return 0;
  }
}
    1148:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    114b:	31 c0                	xor    %eax,%eax
}
    114d:	5b                   	pop    %ebx
    114e:	5e                   	pop    %esi
    114f:	5f                   	pop    %edi
    1150:	5d                   	pop    %ebp
    1151:	c3                   	ret    
    1152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1158:	39 cf                	cmp    %ecx,%edi
    115a:	74 54                	je     11b0 <malloc+0xf0>
        p->s.size -= nunits;
    115c:	29 f9                	sub    %edi,%ecx
    115e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1161:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1164:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1167:	89 15 fc 17 00 00    	mov    %edx,0x17fc
}
    116d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1170:	83 c0 08             	add    $0x8,%eax
}
    1173:	5b                   	pop    %ebx
    1174:	5e                   	pop    %esi
    1175:	5f                   	pop    %edi
    1176:	5d                   	pop    %ebp
    1177:	c3                   	ret    
    1178:	90                   	nop
    1179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1180:	c7 05 fc 17 00 00 00 	movl   $0x1800,0x17fc
    1187:	18 00 00 
    118a:	c7 05 00 18 00 00 00 	movl   $0x1800,0x1800
    1191:	18 00 00 
    base.s.size = 0;
    1194:	b8 00 18 00 00       	mov    $0x1800,%eax
    1199:	c7 05 04 18 00 00 00 	movl   $0x0,0x1804
    11a0:	00 00 00 
    11a3:	e9 44 ff ff ff       	jmp    10ec <malloc+0x2c>
    11a8:	90                   	nop
    11a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    11b0:	8b 08                	mov    (%eax),%ecx
    11b2:	89 0a                	mov    %ecx,(%edx)
    11b4:	eb b1                	jmp    1167 <malloc+0xa7>
