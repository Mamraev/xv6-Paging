
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
       f:	e8 0e 0d 00 00       	call   d22 <getNumberOfFreePages>
      14:	89 c3                	mov    %eax,%ebx
  printResult(cowPhysicalTest());
      16:	e8 35 01 00 00       	call   150 <cowPhysicalTest>
  if(res == -1){
      1b:	83 f8 ff             	cmp    $0xffffffff,%eax
      1e:	0f 84 cb 00 00 00    	je     ef <main+0xef>
    printf(1," PASSED\n");
      24:	50                   	push   %eax
      25:	50                   	push   %eax
      26:	68 b5 11 00 00       	push   $0x11b5
      2b:	6a 01                	push   $0x1
      2d:	e8 9e 0d 00 00       	call   dd0 <printf>
      32:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_pageSeperationTest());
      35:	e8 b6 02 00 00       	call   2f0 <cowSwapFile_pageSeperationTest>
  if(res == -1){
      3a:	83 f8 ff             	cmp    $0xffffffff,%eax
      3d:	0f 84 df 00 00 00    	je     122 <main+0x122>
    printf(1," PASSED\n");
      43:	50                   	push   %eax
      44:	50                   	push   %eax
      45:	68 b5 11 00 00       	push   $0x11b5
      4a:	6a 01                	push   $0x1
      4c:	e8 7f 0d 00 00       	call   dd0 <printf>
      51:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_killedChiledTest());
      54:	e8 a7 04 00 00       	call   500 <cowSwapFile_killedChiledTest>
  if(res == -1){
      59:	83 f8 ff             	cmp    $0xffffffff,%eax
      5c:	0f 84 b6 00 00 00    	je     118 <main+0x118>
    printf(1," PASSED\n");
      62:	50                   	push   %eax
      63:	50                   	push   %eax
      64:	68 b5 11 00 00       	push   $0x11b5
      69:	6a 01                	push   $0x1
      6b:	e8 60 0d 00 00       	call   dd0 <printf>
      70:	83 c4 10             	add    $0x10,%esp
  printResult(cowSwapFile_maxPhyInChildTest());
      73:	e8 b8 03 00 00       	call   430 <cowSwapFile_maxPhyInChildTest>
  if(res == -1){
      78:	83 f8 ff             	cmp    $0xffffffff,%eax
      7b:	0f 84 8d 00 00 00    	je     10e <main+0x10e>
    printf(1," PASSED\n");
      81:	50                   	push   %eax
      82:	50                   	push   %eax
      83:	68 b5 11 00 00       	push   $0x11b5
      88:	6a 01                	push   $0x1
      8a:	e8 41 0d 00 00       	call   dd0 <printf>
      8f:	83 c4 10             	add    $0x10,%esp
  
  printResult(PhysicalMemTest ());
      92:	e8 09 06 00 00       	call   6a0 <PhysicalMemTest>
  if(res == -1){
      97:	83 f8 ff             	cmp    $0xffffffff,%eax
      9a:	74 6b                	je     107 <main+0x107>
    printf(1," PASSED\n");
      9c:	51                   	push   %ecx
      9d:	51                   	push   %ecx
      9e:	68 b5 11 00 00       	push   $0x11b5
      a3:	6a 01                	push   $0x1
      a5:	e8 26 0d 00 00       	call   dd0 <printf>
      aa:	83 c4 10             	add    $0x10,%esp
  printResult(SwapFileTest());
      ad:	e8 ce 06 00 00       	call   780 <SwapFileTest>
  if(res == -1){
      b2:	83 f8 ff             	cmp    $0xffffffff,%eax
      b5:	74 49                	je     100 <main+0x100>
    printf(1," PASSED\n");
      b7:	52                   	push   %edx
      b8:	52                   	push   %edx
      b9:	68 b5 11 00 00       	push   $0x11b5
      be:	6a 01                	push   $0x1
      c0:	e8 0b 0d 00 00       	call   dd0 <printf>
      c5:	83 c4 10             	add    $0x10,%esp
  printResult(memLeakTest(freeMem));
      c8:	83 ec 0c             	sub    $0xc,%esp
      cb:	53                   	push   %ebx
      cc:	e8 8f 07 00 00       	call   860 <memLeakTest>
  if(res == -1){
      d1:	83 c4 10             	add    $0x10,%esp
      d4:	83 f8 ff             	cmp    $0xffffffff,%eax
      d7:	74 20                	je     f9 <main+0xf9>
    printf(1," PASSED\n");
      d9:	50                   	push   %eax
      da:	50                   	push   %eax
      db:	68 b5 11 00 00       	push   $0x11b5
      e0:	6a 01                	push   $0x1
      e2:	e8 e9 0c 00 00       	call   dd0 <printf>
      e7:	83 c4 10             	add    $0x10,%esp

  exit();
      ea:	e8 93 0b 00 00       	call   c82 <exit>
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
     136:	68 28 11 00 00       	push   $0x1128
     13b:	6a 01                	push   $0x1
     13d:	e8 8e 0c 00 00       	call   dd0 <printf>
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
     159:	e8 1c 0b 00 00       	call   c7a <fork>
  if(testerPid==0){
     15e:	85 c0                	test   %eax,%eax
     160:	0f 85 e2 00 00 00    	jne    248 <cowPhysicalTest+0xf8>
    printf(1,"cowPhysicalTest :");
     166:	83 ec 08             	sub    $0x8,%esp
     169:	68 31 11 00 00       	push   $0x1131
     16e:	6a 01                	push   $0x1
     170:	e8 5b 0c 00 00       	call   dd0 <printf>
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
     19b:	e8 6a 0b 00 00       	call   d0a <sbrk>
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
     1c4:	e8 59 0b 00 00       	call   d22 <getNumberOfFreePages>
    sleep(10);
     1c9:	83 ec 0c             	sub    $0xc,%esp
    int freePages_beforeChild = getNumberOfFreePages();
     1cc:	89 c7                	mov    %eax,%edi
    sleep(10);
     1ce:	6a 0a                	push   $0xa
     1d0:	e8 3d 0b 00 00       	call   d12 <sleep>
    int pid = fork();
     1d5:	e8 a0 0a 00 00       	call   c7a <fork>
     1da:	89 c6                	mov    %eax,%esi
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
     1dc:	e8 41 0b 00 00       	call   d22 <getNumberOfFreePages>
    sleep(10);
     1e1:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
    int freePages_beforeReadingFromParent = getNumberOfFreePages();
     1e8:	89 c3                	mov    %eax,%ebx
    sleep(10);
     1ea:	e8 23 0b 00 00       	call   d12 <sleep>
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
     232:	68 43 11 00 00       	push   $0x1143
     237:	6a 01                	push   $0x1
     239:	e8 92 0b 00 00       	call   dd0 <printf>
     23e:	83 c4 10             	add    $0x10,%esp
     241:	eb 4b                	jmp    28e <cowPhysicalTest+0x13e>
     243:	90                   	nop
     244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     248:	e8 3d 0a 00 00       	call   c8a <wait>
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
     260:	e8 25 0a 00 00       	call   c8a <wait>
    if(freePages_beforeChild != getNumberOfFreePages()){
     265:	e8 b8 0a 00 00       	call   d22 <getNumberOfFreePages>
     26a:	39 c7                	cmp    %eax,%edi
     26c:	74 64                	je     2d2 <cowPhysicalTest+0x182>
      printf(1,"Err : num of free pages after child exit");
     26e:	83 ec 08             	sub    $0x8,%esp
     271:	68 20 12 00 00       	push   $0x1220
     276:	6a 01                	push   $0x1
     278:	e8 53 0b 00 00       	call   dd0 <printf>
      printf(1," FAILED");
     27d:	58                   	pop    %eax
     27e:	5a                   	pop    %edx
     27f:	68 43 11 00 00       	push   $0x1143
     284:	6a 01                	push   $0x1
     286:	e8 45 0b 00 00       	call   dd0 <printf>
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
     2a0:	e8 7d 0a 00 00       	call   d22 <getNumberOfFreePages>
      if(freePages_beforeReadingFromParent != freePages_beforeCloning){
     2a5:	39 c3                	cmp    %eax,%ebx
     2a7:	75 1f                	jne    2c8 <cowPhysicalTest+0x178>
      *lst[1] = 66;
     2a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     2ac:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
      if(freePages_beforeCloning != getNumberOfFreePages()+1){
     2b2:	e8 6b 0a 00 00       	call   d22 <getNumberOfFreePages>
     2b7:	83 c0 01             	add    $0x1,%eax
     2ba:	39 c3                	cmp    %eax,%ebx
     2bc:	74 19                	je     2d7 <cowPhysicalTest+0x187>
        printf(1,"Err : num of free pages after cloning");
     2be:	83 ec 08             	sub    $0x8,%esp
     2c1:	68 f8 11 00 00       	push   $0x11f8
     2c6:	eb ae                	jmp    276 <cowPhysicalTest+0x126>
        printf(1,"Err : num of free pages after reading only has changed");
     2c8:	83 ec 08             	sub    $0x8,%esp
     2cb:	68 c0 11 00 00       	push   $0x11c0
     2d0:	eb a4                	jmp    276 <cowPhysicalTest+0x126>
    exit();
     2d2:	e8 ab 09 00 00       	call   c82 <exit>
      sleep(10);
     2d7:	83 ec 0c             	sub    $0xc,%esp
     2da:	6a 0a                	push   $0xa
     2dc:	e8 31 0a 00 00       	call   d12 <sleep>
      exit();
     2e1:	e8 9c 09 00 00       	call   c82 <exit>
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
     2f8:	e8 7d 09 00 00       	call   c7a <fork>
  if(testerPid==0){
     2fd:	85 c0                	test   %eax,%eax
     2ff:	0f 85 0b 01 00 00    	jne    410 <cowSwapFile_pageSeperationTest+0x120>
    printf(1,"cowSwapFile_pageSeperationTest :");
     305:	83 ec 08             	sub    $0x8,%esp
     308:	89 c3                	mov    %eax,%ebx
     30a:	68 4c 12 00 00       	push   $0x124c
     30f:	6a 01                	push   $0x1
     311:	e8 ba 0a 00 00       	call   dd0 <printf>
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
     33b:	e8 ca 09 00 00       	call   d0a <sbrk>
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
     364:	e8 11 09 00 00       	call   c7a <fork>
    if(pid==0){
     369:	85 c0                	test   %eax,%eax
     36b:	0f 85 87 00 00 00    	jne    3f8 <cowSwapFile_pageSeperationTest+0x108>
      for(i = 0; i < 20; i++){
     371:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     378:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     37b:	83 f8 13             	cmp    $0x13,%eax
     37e:	7e 1d                	jle    39d <cowSwapFile_pageSeperationTest+0xad>
     380:	e9 a0 00 00 00       	jmp    425 <cowSwapFile_pageSeperationTest+0x135>
     385:	8d 76 00             	lea    0x0(%esi),%esi
     388:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     38b:	83 c0 01             	add    $0x1,%eax
     38e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     391:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     394:	83 f8 13             	cmp    $0x13,%eax
     397:	0f 8f 88 00 00 00    	jg     425 <cowSwapFile_pageSeperationTest+0x135>
        if(*lst[i]!=i){
     39d:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     3a0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     3a3:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     3a7:	39 02                	cmp    %eax,(%edx)
     3a9:	74 dd                	je     388 <cowSwapFile_pageSeperationTest+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     3ab:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     3ae:	83 ec 04             	sub    $0x4,%esp
     3b1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     3b4:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     3b8:	39 02                	cmp    %eax,(%edx)
     3ba:	0f 95 c0             	setne  %al
     3bd:	0f b6 c0             	movzbl %al,%eax
     3c0:	50                   	push   %eax
     3c1:	68 4b 11 00 00       	push   $0x114b
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     3c6:	6a 01                	push   $0x1
     3c8:	e8 03 0a 00 00       	call   dd0 <printf>
          printf(1," FAILED");
     3cd:	58                   	pop    %eax
     3ce:	5a                   	pop    %edx
     3cf:	68 43 11 00 00       	push   $0x1143
     3d4:	6a 01                	push   $0x1
     3d6:	e8 f5 09 00 00       	call   dd0 <printf>
     3db:	83 c4 10             	add    $0x10,%esp
}
     3de:	8d 65 f8             	lea    -0x8(%ebp),%esp
     3e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     3e6:	5b                   	pop    %ebx
     3e7:	5e                   	pop    %esi
     3e8:	5d                   	pop    %ebp
     3e9:	c3                   	ret    
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
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
     405:	68 5e 11 00 00       	push   $0x115e
     40a:	eb ba                	jmp    3c6 <cowSwapFile_pageSeperationTest+0xd6>
     40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     410:	e8 75 08 00 00       	call   c8a <wait>
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
     420:	e8 65 08 00 00       	call   c8a <wait>
    exit();
     425:	e8 58 08 00 00       	call   c82 <exit>
     42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000430 <cowSwapFile_maxPhyInChildTest>:
cowSwapFile_maxPhyInChildTest(){
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	56                   	push   %esi
     434:	53                   	push   %ebx
     435:	83 ec 50             	sub    $0x50,%esp
  int testerPid = fork();
     438:	e8 3d 08 00 00       	call   c7a <fork>
  if(testerPid==0){
     43d:	85 c0                	test   %eax,%eax
     43f:	0f 85 8b 00 00 00    	jne    4d0 <cowSwapFile_maxPhyInChildTest+0xa0>
    printf(1,"cowSwapFile_maxPhyInChildTest :");
     445:	83 ec 08             	sub    $0x8,%esp
     448:	89 c6                	mov    %eax,%esi
    for(i = 0; i < 20; i++){
     44a:	31 db                	xor    %ebx,%ebx
    printf(1,"cowSwapFile_maxPhyInChildTest :");
     44c:	68 70 12 00 00       	push   $0x1270
     451:	6a 01                	push   $0x1
     453:	e8 78 09 00 00       	call   dd0 <printf>
     458:	83 c4 10             	add    $0x10,%esp
     45b:	90                   	nop
     45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     460:	83 ec 0c             	sub    $0xc,%esp
     463:	68 00 10 00 00       	push   $0x1000
     468:	e8 9d 08 00 00       	call   d0a <sbrk>
     46d:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
      *lst[i]=i;
     471:	89 18                	mov    %ebx,(%eax)
    for(i = 0; i < 20; i++){
     473:	83 c3 01             	add    $0x1,%ebx
     476:	83 c4 10             	add    $0x10,%esp
     479:	83 fb 14             	cmp    $0x14,%ebx
     47c:	75 e2                	jne    460 <cowSwapFile_maxPhyInChildTest+0x30>
    int pid = fork();
     47e:	e8 f7 07 00 00       	call   c7a <fork>
    if(pid==0){
     483:	85 c0                	test   %eax,%eax
     485:	74 57                	je     4de <cowSwapFile_maxPhyInChildTest+0xae>
    wait();
     487:	e8 fe 07 00 00       	call   c8a <wait>
     48c:	eb 0a                	jmp    498 <cowSwapFile_maxPhyInChildTest+0x68>
     48e:	66 90                	xchg   %ax,%ax
    for(j = 0; j < 20; j++){
     490:	83 c6 01             	add    $0x1,%esi
     493:	83 fe 14             	cmp    $0x14,%esi
     496:	74 60                	je     4f8 <cowSwapFile_maxPhyInChildTest+0xc8>
        if(*lst[j]!=j){
     498:	8b 44 b5 a8          	mov    -0x58(%ebp,%esi,4),%eax
     49c:	39 30                	cmp    %esi,(%eax)
     49e:	74 f0                	je     490 <cowSwapFile_maxPhyInChildTest+0x60>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     4a0:	83 ec 04             	sub    $0x4,%esp
     4a3:	6a 01                	push   $0x1
     4a5:	68 5e 11 00 00       	push   $0x115e
     4aa:	6a 01                	push   $0x1
     4ac:	e8 1f 09 00 00       	call   dd0 <printf>
          printf(1," FAILED");
     4b1:	58                   	pop    %eax
     4b2:	5a                   	pop    %edx
     4b3:	68 43 11 00 00       	push   $0x1143
     4b8:	6a 01                	push   $0x1
     4ba:	e8 11 09 00 00       	call   dd0 <printf>
     4bf:	83 c4 10             	add    $0x10,%esp
}
     4c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
          printf(1," FAILED");
     4c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     4ca:	5b                   	pop    %ebx
     4cb:	5e                   	pop    %esi
     4cc:	5d                   	pop    %ebp
     4cd:	c3                   	ret    
     4ce:	66 90                	xchg   %ax,%ax
    wait();
     4d0:	e8 b5 07 00 00       	call   c8a <wait>
}
     4d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     4d8:	31 c0                	xor    %eax,%eax
}
     4da:	5b                   	pop    %ebx
     4db:	5e                   	pop    %esi
     4dc:	5d                   	pop    %ebp
     4dd:	c3                   	ret    
     4de:	b8 32 00 00 00       	mov    $0x32,%eax
        *lst[i]= i + 50;
     4e3:	8b 94 85 e0 fe ff ff 	mov    -0x120(%ebp,%eax,4),%edx
     4ea:	89 02                	mov    %eax,(%edx)
     4ec:	83 c0 01             	add    $0x1,%eax
      for(i = 0; i < 20; i++){
     4ef:	83 f8 46             	cmp    $0x46,%eax
     4f2:	75 ef                	jne    4e3 <cowSwapFile_maxPhyInChildTest+0xb3>
     4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      exit();
     4f8:	e8 85 07 00 00       	call   c82 <exit>
     4fd:	8d 76 00             	lea    0x0(%esi),%esi

00000500 <cowSwapFile_killedChiledTest>:
cowSwapFile_killedChiledTest(){
     500:	55                   	push   %ebp
     501:	89 e5                	mov    %esp,%ebp
     503:	56                   	push   %esi
     504:	53                   	push   %ebx
     505:	83 ec 60             	sub    $0x60,%esp
  int testerPid = fork();
     508:	e8 6d 07 00 00       	call   c7a <fork>
  if(testerPid==0){
     50d:	85 c0                	test   %eax,%eax
     50f:	0f 85 eb 00 00 00    	jne    600 <cowSwapFile_killedChiledTest+0x100>
    printf(1,"cowSwapFile_killedChiledTest :");
     515:	83 ec 08             	sub    $0x8,%esp
     518:	89 c3                	mov    %eax,%ebx
     51a:	68 90 12 00 00       	push   $0x1290
     51f:	6a 01                	push   $0x1
     521:	e8 aa 08 00 00       	call   dd0 <printf>
    for(i = 0; i < 20; i++){
     526:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     52d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     530:	83 c4 10             	add    $0x10,%esp
     533:	83 f8 13             	cmp    $0x13,%eax
     536:	7f 3c                	jg     574 <cowSwapFile_killedChiledTest+0x74>
     538:	90                   	nop
     539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     540:	83 ec 0c             	sub    $0xc,%esp
     543:	8b 75 a4             	mov    -0x5c(%ebp),%esi
     546:	68 00 10 00 00       	push   $0x1000
     54b:	e8 ba 07 00 00       	call   d0a <sbrk>
     550:	89 44 b5 a8          	mov    %eax,-0x58(%ebp,%esi,4)
      *lst[i]=i;
     554:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 20; i++){
     557:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     55a:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     55d:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     561:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 20; i++){
     563:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     566:	83 c0 01             	add    $0x1,%eax
     569:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     56c:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     56f:	83 f8 13             	cmp    $0x13,%eax
     572:	7e cc                	jle    540 <cowSwapFile_killedChiledTest+0x40>
    int pid = fork();
     574:	e8 01 07 00 00       	call   c7a <fork>
    if(pid==0){
     579:	85 c0                	test   %eax,%eax
     57b:	0f 85 8f 00 00 00    	jne    610 <cowSwapFile_killedChiledTest+0x110>
      for(i = 0; i < 20; i++){
     581:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     588:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     58b:	83 f8 13             	cmp    $0x13,%eax
     58e:	7e 1d                	jle    5ad <cowSwapFile_killedChiledTest+0xad>
     590:	e9 ab 00 00 00       	jmp    640 <cowSwapFile_killedChiledTest+0x140>
     595:	8d 76 00             	lea    0x0(%esi),%esi
     598:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     59b:	83 c0 01             	add    $0x1,%eax
     59e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     5a1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5a4:	83 f8 13             	cmp    $0x13,%eax
     5a7:	0f 8f 93 00 00 00    	jg     640 <cowSwapFile_killedChiledTest+0x140>
        if(*lst[i]!=i){
     5ad:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     5b0:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5b3:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     5b7:	39 02                	cmp    %eax,(%edx)
     5b9:	74 dd                	je     598 <cowSwapFile_killedChiledTest+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     5bb:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     5be:	83 ec 04             	sub    $0x4,%esp
     5c1:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     5c4:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     5c8:	39 02                	cmp    %eax,(%edx)
     5ca:	0f 95 c0             	setne  %al
     5cd:	0f b6 c0             	movzbl %al,%eax
     5d0:	50                   	push   %eax
     5d1:	68 4b 11 00 00       	push   $0x114b
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     5d6:	6a 01                	push   $0x1
     5d8:	e8 f3 07 00 00       	call   dd0 <printf>
          printf(1," FAILED");
     5dd:	58                   	pop    %eax
     5de:	5a                   	pop    %edx
     5df:	68 43 11 00 00       	push   $0x1143
     5e4:	6a 01                	push   $0x1
     5e6:	e8 e5 07 00 00       	call   dd0 <printf>
     5eb:	83 c4 10             	add    $0x10,%esp
}
     5ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5f6:	5b                   	pop    %ebx
     5f7:	5e                   	pop    %esi
     5f8:	5d                   	pop    %ebp
     5f9:	c3                   	ret    
     5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wait();
     600:	e8 85 06 00 00       	call   c8a <wait>
}
     605:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     608:	31 c0                	xor    %eax,%eax
}
     60a:	5b                   	pop    %ebx
     60b:	5e                   	pop    %esi
     60c:	5d                   	pop    %ebp
     60d:	c3                   	ret    
     60e:	66 90                	xchg   %ax,%ax
    wait();
     610:	e8 75 06 00 00       	call   c8a <wait>
     615:	eb 11                	jmp    628 <cowSwapFile_killedChiledTest+0x128>
     617:	89 f6                	mov    %esi,%esi
     619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(j = 0; j < 20; j++){
     620:	83 c3 01             	add    $0x1,%ebx
     623:	83 fb 14             	cmp    $0x14,%ebx
     626:	74 68                	je     690 <cowSwapFile_killedChiledTest+0x190>
        if(*lst[j]!=j){
     628:	8b 44 9d a8          	mov    -0x58(%ebp,%ebx,4),%eax
     62c:	3b 18                	cmp    (%eax),%ebx
     62e:	74 f0                	je     620 <cowSwapFile_killedChiledTest+0x120>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     630:	83 ec 04             	sub    $0x4,%esp
     633:	6a 01                	push   $0x1
     635:	68 5e 11 00 00       	push   $0x115e
     63a:	eb 9a                	jmp    5d6 <cowSwapFile_killedChiledTest+0xd6>
     63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < 20; i++){
     640:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     647:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     64a:	83 f8 13             	cmp    $0x13,%eax
     64d:	7e 1a                	jle    669 <cowSwapFile_killedChiledTest+0x169>
     64f:	eb 3f                	jmp    690 <cowSwapFile_killedChiledTest+0x190>
     651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     658:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     65b:	83 c0 01             	add    $0x1,%eax
     65e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     661:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     664:	83 f8 13             	cmp    $0x13,%eax
     667:	7f 27                	jg     690 <cowSwapFile_killedChiledTest+0x190>
        *lst[i] = 66;
     669:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     66c:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     670:	c7 00 42 00 00 00    	movl   $0x42,(%eax)
        if(*lst[i]!=66){
     676:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     679:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     67d:	83 38 42             	cmpl   $0x42,(%eax)
     680:	74 d6                	je     658 <cowSwapFile_killedChiledTest+0x158>
     682:	e9 34 ff ff ff       	jmp    5bb <cowSwapFile_killedChiledTest+0xbb>
     687:	89 f6                	mov    %esi,%esi
     689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
     690:	e8 ed 05 00 00       	call   c82 <exit>
     695:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <PhysicalMemTest>:
PhysicalMemTest(){
     6a0:	55                   	push   %ebp
     6a1:	89 e5                	mov    %esp,%ebp
     6a3:	53                   	push   %ebx
     6a4:	83 ec 24             	sub    $0x24,%esp
  int testerPid = fork();
     6a7:	e8 ce 05 00 00       	call   c7a <fork>
  if(testerPid==0){
     6ac:	85 c0                	test   %eax,%eax
     6ae:	0f 85 ac 00 00 00    	jne    760 <PhysicalMemTest+0xc0>
    printf(1,"PhysicalMemTest :");
     6b4:	83 ec 08             	sub    $0x8,%esp
     6b7:	68 72 11 00 00       	push   $0x1172
     6bc:	6a 01                	push   $0x1
     6be:	e8 0d 07 00 00       	call   dd0 <printf>
    for(i = 0; i < 5; i++){
     6c3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     6ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6cd:	83 c4 10             	add    $0x10,%esp
     6d0:	83 f8 04             	cmp    $0x4,%eax
     6d3:	7f 37                	jg     70c <PhysicalMemTest+0x6c>
     6d5:	8d 76 00             	lea    0x0(%esi),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     6d8:	83 ec 0c             	sub    $0xc,%esp
     6db:	8b 5d e0             	mov    -0x20(%ebp),%ebx
     6de:	68 00 10 00 00       	push   $0x1000
     6e3:	e8 22 06 00 00       	call   d0a <sbrk>
     6e8:	89 44 9d e4          	mov    %eax,-0x1c(%ebp,%ebx,4)
      *lst[i]=i;
     6ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
    for(i = 0; i < 5; i++){
     6ef:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     6f2:	8b 55 e0             	mov    -0x20(%ebp),%edx
     6f5:	8b 44 85 e4          	mov    -0x1c(%ebp,%eax,4),%eax
     6f9:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 5; i++){
     6fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6fe:	83 c0 01             	add    $0x1,%eax
     701:	89 45 e0             	mov    %eax,-0x20(%ebp)
     704:	8b 45 e0             	mov    -0x20(%ebp),%eax
     707:	83 f8 04             	cmp    $0x4,%eax
     70a:	7e cc                	jle    6d8 <PhysicalMemTest+0x38>
    for(i = 0; i < 5; i++){
     70c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
     713:	8b 45 e0             	mov    -0x20(%ebp),%eax
     716:	83 f8 04             	cmp    $0x4,%eax
     719:	7e 16                	jle    731 <PhysicalMemTest+0x91>
     71b:	eb 4f                	jmp    76c <PhysicalMemTest+0xcc>
     71d:	8d 76 00             	lea    0x0(%esi),%esi
     720:	8b 45 e0             	mov    -0x20(%ebp),%eax
     723:	83 c0 01             	add    $0x1,%eax
     726:	89 45 e0             	mov    %eax,-0x20(%ebp)
     729:	8b 45 e0             	mov    -0x20(%ebp),%eax
     72c:	83 f8 04             	cmp    $0x4,%eax
     72f:	7f 3b                	jg     76c <PhysicalMemTest+0xcc>
      if(*lst[i]!=i){
     731:	8b 55 e0             	mov    -0x20(%ebp),%edx
     734:	8b 45 e0             	mov    -0x20(%ebp),%eax
     737:	8b 54 95 e4          	mov    -0x1c(%ebp,%edx,4),%edx
     73b:	39 02                	cmp    %eax,(%edx)
     73d:	74 e1                	je     720 <PhysicalMemTest+0x80>
        printf(1," FAILED");
     73f:	83 ec 08             	sub    $0x8,%esp
     742:	68 43 11 00 00       	push   $0x1143
     747:	6a 01                	push   $0x1
     749:	e8 82 06 00 00       	call   dd0 <printf>
     74e:	83 c4 10             	add    $0x10,%esp
     751:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     759:	c9                   	leave  
     75a:	c3                   	ret    
     75b:	90                   	nop
     75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     760:	e8 25 05 00 00       	call   c8a <wait>
    return 0;
     765:	31 c0                	xor    %eax,%eax
}
     767:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     76a:	c9                   	leave  
     76b:	c3                   	ret    
    exit();
     76c:	e8 11 05 00 00       	call   c82 <exit>
     771:	eb 0d                	jmp    780 <SwapFileTest>
     773:	90                   	nop
     774:	90                   	nop
     775:	90                   	nop
     776:	90                   	nop
     777:	90                   	nop
     778:	90                   	nop
     779:	90                   	nop
     77a:	90                   	nop
     77b:	90                   	nop
     77c:	90                   	nop
     77d:	90                   	nop
     77e:	90                   	nop
     77f:	90                   	nop

00000780 <SwapFileTest>:
SwapFileTest(){
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	53                   	push   %ebx
     784:	83 ec 64             	sub    $0x64,%esp
  int testerPid = fork();
     787:	e8 ee 04 00 00       	call   c7a <fork>
  if(testerPid==0){
     78c:	85 c0                	test   %eax,%eax
     78e:	0f 85 ac 00 00 00    	jne    840 <SwapFileTest+0xc0>
    printf(1,"SwapFileTest :");
     794:	83 ec 08             	sub    $0x8,%esp
     797:	68 95 11 00 00       	push   $0x1195
     79c:	6a 01                	push   $0x1
     79e:	e8 2d 06 00 00       	call   dd0 <printf>
    for(i = 0; i < 20; i++){
     7a3:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     7aa:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     7ad:	83 c4 10             	add    $0x10,%esp
     7b0:	83 f8 13             	cmp    $0x13,%eax
     7b3:	7f 37                	jg     7ec <SwapFileTest+0x6c>
     7b5:	8d 76 00             	lea    0x0(%esi),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     7b8:	83 ec 0c             	sub    $0xc,%esp
     7bb:	8b 5d a4             	mov    -0x5c(%ebp),%ebx
     7be:	68 00 10 00 00       	push   $0x1000
     7c3:	e8 42 05 00 00       	call   d0a <sbrk>
     7c8:	89 44 9d a8          	mov    %eax,-0x58(%ebp,%ebx,4)
      *lst[i]=i;
     7cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
    for(i = 0; i < 20; i++){
     7cf:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     7d2:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     7d5:	8b 44 85 a8          	mov    -0x58(%ebp,%eax,4),%eax
     7d9:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 20; i++){
     7db:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     7de:	83 c0 01             	add    $0x1,%eax
     7e1:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     7e4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     7e7:	83 f8 13             	cmp    $0x13,%eax
     7ea:	7e cc                	jle    7b8 <SwapFileTest+0x38>
    for(i = 0; i < 20; i++){
     7ec:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
     7f3:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     7f6:	83 f8 13             	cmp    $0x13,%eax
     7f9:	7e 16                	jle    811 <SwapFileTest+0x91>
     7fb:	eb 4f                	jmp    84c <SwapFileTest+0xcc>
     7fd:	8d 76 00             	lea    0x0(%esi),%esi
     800:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     803:	83 c0 01             	add    $0x1,%eax
     806:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     809:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     80c:	83 f8 13             	cmp    $0x13,%eax
     80f:	7f 3b                	jg     84c <SwapFileTest+0xcc>
      if(*lst[i]!=i){
     811:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     814:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     817:	8b 54 95 a8          	mov    -0x58(%ebp,%edx,4),%edx
     81b:	39 02                	cmp    %eax,(%edx)
     81d:	74 e1                	je     800 <SwapFileTest+0x80>
        printf(1," FAILED");
     81f:	83 ec 08             	sub    $0x8,%esp
     822:	68 43 11 00 00       	push   $0x1143
     827:	6a 01                	push   $0x1
     829:	e8 a2 05 00 00       	call   dd0 <printf>
     82e:	83 c4 10             	add    $0x10,%esp
     831:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
     836:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     839:	c9                   	leave  
     83a:	c3                   	ret    
     83b:	90                   	nop
     83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wait();
     840:	e8 45 04 00 00       	call   c8a <wait>
    return 0;
     845:	31 c0                	xor    %eax,%eax
}
     847:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     84a:	c9                   	leave  
     84b:	c3                   	ret    
    exit();
     84c:	e8 31 04 00 00       	call   c82 <exit>
     851:	eb 0d                	jmp    860 <memLeakTest>
     853:	90                   	nop
     854:	90                   	nop
     855:	90                   	nop
     856:	90                   	nop
     857:	90                   	nop
     858:	90                   	nop
     859:	90                   	nop
     85a:	90                   	nop
     85b:	90                   	nop
     85c:	90                   	nop
     85d:	90                   	nop
     85e:	90                   	nop
     85f:	90                   	nop

00000860 <memLeakTest>:
memLeakTest(int freeMem){
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	83 ec 10             	sub    $0x10,%esp
  printf(1,"memLeakTest :");
     866:	68 84 11 00 00       	push   $0x1184
     86b:	6a 01                	push   $0x1
     86d:	e8 5e 05 00 00       	call   dd0 <printf>
  if(freeMem != getNumberOfFreePages()){
     872:	e8 ab 04 00 00       	call   d22 <getNumberOfFreePages>
     877:	83 c4 10             	add    $0x10,%esp
     87a:	3b 45 08             	cmp    0x8(%ebp),%eax
     87d:	74 12                	je     891 <memLeakTest+0x31>
      printf(1, "FAILED\n");
     87f:	83 ec 08             	sub    $0x8,%esp
     882:	68 29 11 00 00       	push   $0x1129
     887:	6a 01                	push   $0x1
     889:	e8 42 05 00 00       	call   dd0 <printf>
     88e:	83 c4 10             	add    $0x10,%esp
}
     891:	31 c0                	xor    %eax,%eax
     893:	c9                   	leave  
     894:	c3                   	ret    
     895:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <test>:
test(){
     8a0:	55                   	push   %ebp
     8a1:	89 e5                	mov    %esp,%ebp
     8a3:	56                   	push   %esi
     8a4:	53                   	push   %ebx
     8a5:	83 ec 40             	sub    $0x40,%esp
  int testerPid = fork();
     8a8:	e8 cd 03 00 00       	call   c7a <fork>
  if(testerPid==0){
     8ad:	85 c0                	test   %eax,%eax
     8af:	0f 85 eb 00 00 00    	jne    9a0 <test+0x100>
    printf(1,"cowSwapFileTest :");
     8b5:	83 ec 08             	sub    $0x8,%esp
     8b8:	89 c3                	mov    %eax,%ebx
     8ba:	68 92 11 00 00       	push   $0x1192
     8bf:	6a 01                	push   $0x1
     8c1:	e8 0a 05 00 00       	call   dd0 <printf>
    for(i = 0; i < 15; i++){
     8c6:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
     8cd:	8b 45 b8             	mov    -0x48(%ebp),%eax
     8d0:	83 c4 10             	add    $0x10,%esp
     8d3:	83 f8 0e             	cmp    $0xe,%eax
     8d6:	7f 3c                	jg     914 <test+0x74>
     8d8:	90                   	nop
     8d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      lst[i] = (int*)sbrk(PGSIZE);
     8e0:	83 ec 0c             	sub    $0xc,%esp
     8e3:	8b 75 b8             	mov    -0x48(%ebp),%esi
     8e6:	68 00 10 00 00       	push   $0x1000
     8eb:	e8 1a 04 00 00       	call   d0a <sbrk>
     8f0:	89 44 b5 bc          	mov    %eax,-0x44(%ebp,%esi,4)
      *lst[i]=i;
     8f4:	8b 45 b8             	mov    -0x48(%ebp),%eax
    for(i = 0; i < 15; i++){
     8f7:	83 c4 10             	add    $0x10,%esp
      *lst[i]=i;
     8fa:	8b 55 b8             	mov    -0x48(%ebp),%edx
     8fd:	8b 44 85 bc          	mov    -0x44(%ebp,%eax,4),%eax
     901:	89 10                	mov    %edx,(%eax)
    for(i = 0; i < 15; i++){
     903:	8b 45 b8             	mov    -0x48(%ebp),%eax
     906:	83 c0 01             	add    $0x1,%eax
     909:	89 45 b8             	mov    %eax,-0x48(%ebp)
     90c:	8b 45 b8             	mov    -0x48(%ebp),%eax
     90f:	83 f8 0e             	cmp    $0xe,%eax
     912:	7e cc                	jle    8e0 <test+0x40>
    int pid = fork();
     914:	e8 61 03 00 00       	call   c7a <fork>
    if(pid==0){
     919:	85 c0                	test   %eax,%eax
     91b:	0f 85 8f 00 00 00    	jne    9b0 <test+0x110>
      for(i = 0; i < 15; i++){
     921:	c7 45 b8 00 00 00 00 	movl   $0x0,-0x48(%ebp)
     928:	8b 45 b8             	mov    -0x48(%ebp),%eax
     92b:	83 f8 0e             	cmp    $0xe,%eax
     92e:	7e 1d                	jle    94d <test+0xad>
     930:	e9 bf 00 00 00       	jmp    9f4 <test+0x154>
     935:	8d 76 00             	lea    0x0(%esi),%esi
     938:	8b 45 b8             	mov    -0x48(%ebp),%eax
     93b:	83 c0 01             	add    $0x1,%eax
     93e:	89 45 b8             	mov    %eax,-0x48(%ebp)
     941:	8b 45 b8             	mov    -0x48(%ebp),%eax
     944:	83 f8 0e             	cmp    $0xe,%eax
     947:	0f 8f a7 00 00 00    	jg     9f4 <test+0x154>
        if(*lst[i]!=i){
     94d:	8b 55 b8             	mov    -0x48(%ebp),%edx
     950:	8b 45 b8             	mov    -0x48(%ebp),%eax
     953:	8b 54 95 bc          	mov    -0x44(%ebp,%edx,4),%edx
     957:	39 02                	cmp    %eax,(%edx)
     959:	74 dd                	je     938 <test+0x98>
          printf(1,"\nchild fail %d %d\n",*lst[i]!=i);
     95b:	8b 55 b8             	mov    -0x48(%ebp),%edx
     95e:	83 ec 04             	sub    $0x4,%esp
     961:	8b 45 b8             	mov    -0x48(%ebp),%eax
     964:	8b 54 95 bc          	mov    -0x44(%ebp,%edx,4),%edx
     968:	39 02                	cmp    %eax,(%edx)
     96a:	0f 95 c0             	setne  %al
     96d:	0f b6 c0             	movzbl %al,%eax
     970:	50                   	push   %eax
     971:	68 4b 11 00 00       	push   $0x114b
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     976:	6a 01                	push   $0x1
     978:	e8 53 04 00 00       	call   dd0 <printf>
          printf(1," FAILED");
     97d:	58                   	pop    %eax
     97e:	5a                   	pop    %edx
     97f:	68 43 11 00 00       	push   $0x1143
     984:	6a 01                	push   $0x1
     986:	e8 45 04 00 00       	call   dd0 <printf>
          return -1;
     98b:	83 c4 10             	add    $0x10,%esp
}
     98e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     996:	5b                   	pop    %ebx
     997:	5e                   	pop    %esi
     998:	5d                   	pop    %ebp
     999:	c3                   	ret    
     99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wait();
     9a0:	e8 e5 02 00 00       	call   c8a <wait>
}
     9a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
     9a8:	31 c0                	xor    %eax,%eax
}
     9aa:	5b                   	pop    %ebx
     9ab:	5e                   	pop    %esi
     9ac:	5d                   	pop    %ebp
     9ad:	c3                   	ret    
     9ae:	66 90                	xchg   %ax,%ax
    wait();
     9b0:	e8 d5 02 00 00       	call   c8a <wait>
     9b5:	eb 11                	jmp    9c8 <test+0x128>
     9b7:	89 f6                	mov    %esi,%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(j = 0; j < 15; j++){
     9c0:	83 c3 01             	add    $0x1,%ebx
     9c3:	83 fb 0f             	cmp    $0xf,%ebx
     9c6:	74 18                	je     9e0 <test+0x140>
        if(*lst[j]!=j){
     9c8:	8b 44 9d bc          	mov    -0x44(%ebp,%ebx,4),%eax
     9cc:	39 18                	cmp    %ebx,(%eax)
     9ce:	74 f0                	je     9c0 <test+0x120>
          printf(1,"\nparent fail %d %d\n",*lst[j]!=j);
     9d0:	83 ec 04             	sub    $0x4,%esp
     9d3:	6a 01                	push   $0x1
     9d5:	68 5e 11 00 00       	push   $0x115e
     9da:	eb 9a                	jmp    976 <test+0xd6>
     9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1,"parent exit now\n");
     9e0:	83 ec 08             	sub    $0x8,%esp
     9e3:	68 a4 11 00 00       	push   $0x11a4
     9e8:	6a 01                	push   $0x1
     9ea:	e8 e1 03 00 00       	call   dd0 <printf>
    exit();
     9ef:	e8 8e 02 00 00       	call   c82 <exit>
      exit();
     9f4:	e8 89 02 00 00       	call   c82 <exit>
     9f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a00 <printResult>:
printResult(int res){
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	83 ec 08             	sub    $0x8,%esp
  if(res == -1){
     a06:	83 7d 08 ff          	cmpl   $0xffffffff,0x8(%ebp)
     a0a:	74 14                	je     a20 <printResult+0x20>
    printf(1," PASSED\n");
     a0c:	83 ec 08             	sub    $0x8,%esp
     a0f:	68 b5 11 00 00       	push   $0x11b5
     a14:	6a 01                	push   $0x1
     a16:	e8 b5 03 00 00       	call   dd0 <printf>
     a1b:	83 c4 10             	add    $0x10,%esp
}
     a1e:	c9                   	leave  
     a1f:	c3                   	ret    
     a20:	c9                   	leave  
     a21:	e9 0a f7 ff ff       	jmp    130 <printResult.part.7>
     a26:	66 90                	xchg   %ax,%ax
     a28:	66 90                	xchg   %ax,%ax
     a2a:	66 90                	xchg   %ax,%ax
     a2c:	66 90                	xchg   %ax,%ax
     a2e:	66 90                	xchg   %ax,%ax

00000a30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	53                   	push   %ebx
     a34:	8b 45 08             	mov    0x8(%ebp),%eax
     a37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a3a:	89 c2                	mov    %eax,%edx
     a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a40:	83 c1 01             	add    $0x1,%ecx
     a43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     a47:	83 c2 01             	add    $0x1,%edx
     a4a:	84 db                	test   %bl,%bl
     a4c:	88 5a ff             	mov    %bl,-0x1(%edx)
     a4f:	75 ef                	jne    a40 <strcpy+0x10>
    ;
  return os;
}
     a51:	5b                   	pop    %ebx
     a52:	5d                   	pop    %ebp
     a53:	c3                   	ret    
     a54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     a5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000a60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a60:	55                   	push   %ebp
     a61:	89 e5                	mov    %esp,%ebp
     a63:	53                   	push   %ebx
     a64:	8b 55 08             	mov    0x8(%ebp),%edx
     a67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     a6a:	0f b6 02             	movzbl (%edx),%eax
     a6d:	0f b6 19             	movzbl (%ecx),%ebx
     a70:	84 c0                	test   %al,%al
     a72:	75 1c                	jne    a90 <strcmp+0x30>
     a74:	eb 2a                	jmp    aa0 <strcmp+0x40>
     a76:	8d 76 00             	lea    0x0(%esi),%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     a80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     a83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     a86:	83 c1 01             	add    $0x1,%ecx
     a89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     a8c:	84 c0                	test   %al,%al
     a8e:	74 10                	je     aa0 <strcmp+0x40>
     a90:	38 d8                	cmp    %bl,%al
     a92:	74 ec                	je     a80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     a94:	29 d8                	sub    %ebx,%eax
}
     a96:	5b                   	pop    %ebx
     a97:	5d                   	pop    %ebp
     a98:	c3                   	ret    
     a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     aa0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     aa2:	29 d8                	sub    %ebx,%eax
}
     aa4:	5b                   	pop    %ebx
     aa5:	5d                   	pop    %ebp
     aa6:	c3                   	ret    
     aa7:	89 f6                	mov    %esi,%esi
     aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ab0 <strlen>:

uint
strlen(const char *s)
{
     ab0:	55                   	push   %ebp
     ab1:	89 e5                	mov    %esp,%ebp
     ab3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     ab6:	80 39 00             	cmpb   $0x0,(%ecx)
     ab9:	74 15                	je     ad0 <strlen+0x20>
     abb:	31 d2                	xor    %edx,%edx
     abd:	8d 76 00             	lea    0x0(%esi),%esi
     ac0:	83 c2 01             	add    $0x1,%edx
     ac3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     ac7:	89 d0                	mov    %edx,%eax
     ac9:	75 f5                	jne    ac0 <strlen+0x10>
    ;
  return n;
}
     acb:	5d                   	pop    %ebp
     acc:	c3                   	ret    
     acd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     ad0:	31 c0                	xor    %eax,%eax
}
     ad2:	5d                   	pop    %ebp
     ad3:	c3                   	ret    
     ad4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     ada:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ae0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	57                   	push   %edi
     ae4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ae7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     aea:	8b 45 0c             	mov    0xc(%ebp),%eax
     aed:	89 d7                	mov    %edx,%edi
     aef:	fc                   	cld    
     af0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     af2:	89 d0                	mov    %edx,%eax
     af4:	5f                   	pop    %edi
     af5:	5d                   	pop    %ebp
     af6:	c3                   	ret    
     af7:	89 f6                	mov    %esi,%esi
     af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b00 <strchr>:

char*
strchr(const char *s, char c)
{
     b00:	55                   	push   %ebp
     b01:	89 e5                	mov    %esp,%ebp
     b03:	53                   	push   %ebx
     b04:	8b 45 08             	mov    0x8(%ebp),%eax
     b07:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     b0a:	0f b6 10             	movzbl (%eax),%edx
     b0d:	84 d2                	test   %dl,%dl
     b0f:	74 1d                	je     b2e <strchr+0x2e>
    if(*s == c)
     b11:	38 d3                	cmp    %dl,%bl
     b13:	89 d9                	mov    %ebx,%ecx
     b15:	75 0d                	jne    b24 <strchr+0x24>
     b17:	eb 17                	jmp    b30 <strchr+0x30>
     b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b20:	38 ca                	cmp    %cl,%dl
     b22:	74 0c                	je     b30 <strchr+0x30>
  for(; *s; s++)
     b24:	83 c0 01             	add    $0x1,%eax
     b27:	0f b6 10             	movzbl (%eax),%edx
     b2a:	84 d2                	test   %dl,%dl
     b2c:	75 f2                	jne    b20 <strchr+0x20>
      return (char*)s;
  return 0;
     b2e:	31 c0                	xor    %eax,%eax
}
     b30:	5b                   	pop    %ebx
     b31:	5d                   	pop    %ebp
     b32:	c3                   	ret    
     b33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <gets>:

char*
gets(char *buf, int max)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	57                   	push   %edi
     b44:	56                   	push   %esi
     b45:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b46:	31 f6                	xor    %esi,%esi
     b48:	89 f3                	mov    %esi,%ebx
{
     b4a:	83 ec 1c             	sub    $0x1c,%esp
     b4d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     b50:	eb 2f                	jmp    b81 <gets+0x41>
     b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     b58:	8d 45 e7             	lea    -0x19(%ebp),%eax
     b5b:	83 ec 04             	sub    $0x4,%esp
     b5e:	6a 01                	push   $0x1
     b60:	50                   	push   %eax
     b61:	6a 00                	push   $0x0
     b63:	e8 32 01 00 00       	call   c9a <read>
    if(cc < 1)
     b68:	83 c4 10             	add    $0x10,%esp
     b6b:	85 c0                	test   %eax,%eax
     b6d:	7e 1c                	jle    b8b <gets+0x4b>
      break;
    buf[i++] = c;
     b6f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     b73:	83 c7 01             	add    $0x1,%edi
     b76:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     b79:	3c 0a                	cmp    $0xa,%al
     b7b:	74 23                	je     ba0 <gets+0x60>
     b7d:	3c 0d                	cmp    $0xd,%al
     b7f:	74 1f                	je     ba0 <gets+0x60>
  for(i=0; i+1 < max; ){
     b81:	83 c3 01             	add    $0x1,%ebx
     b84:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     b87:	89 fe                	mov    %edi,%esi
     b89:	7c cd                	jl     b58 <gets+0x18>
     b8b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     b90:	c6 03 00             	movb   $0x0,(%ebx)
}
     b93:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b96:	5b                   	pop    %ebx
     b97:	5e                   	pop    %esi
     b98:	5f                   	pop    %edi
     b99:	5d                   	pop    %ebp
     b9a:	c3                   	ret    
     b9b:	90                   	nop
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ba0:	8b 75 08             	mov    0x8(%ebp),%esi
     ba3:	8b 45 08             	mov    0x8(%ebp),%eax
     ba6:	01 de                	add    %ebx,%esi
     ba8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     baa:	c6 03 00             	movb   $0x0,(%ebx)
}
     bad:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bb0:	5b                   	pop    %ebx
     bb1:	5e                   	pop    %esi
     bb2:	5f                   	pop    %edi
     bb3:	5d                   	pop    %ebp
     bb4:	c3                   	ret    
     bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bc0 <stat>:

int
stat(const char *n, struct stat *st)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	56                   	push   %esi
     bc4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     bc5:	83 ec 08             	sub    $0x8,%esp
     bc8:	6a 00                	push   $0x0
     bca:	ff 75 08             	pushl  0x8(%ebp)
     bcd:	e8 f0 00 00 00       	call   cc2 <open>
  if(fd < 0)
     bd2:	83 c4 10             	add    $0x10,%esp
     bd5:	85 c0                	test   %eax,%eax
     bd7:	78 27                	js     c00 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     bd9:	83 ec 08             	sub    $0x8,%esp
     bdc:	ff 75 0c             	pushl  0xc(%ebp)
     bdf:	89 c3                	mov    %eax,%ebx
     be1:	50                   	push   %eax
     be2:	e8 f3 00 00 00       	call   cda <fstat>
  close(fd);
     be7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     bea:	89 c6                	mov    %eax,%esi
  close(fd);
     bec:	e8 b9 00 00 00       	call   caa <close>
  return r;
     bf1:	83 c4 10             	add    $0x10,%esp
}
     bf4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bf7:	89 f0                	mov    %esi,%eax
     bf9:	5b                   	pop    %ebx
     bfa:	5e                   	pop    %esi
     bfb:	5d                   	pop    %ebp
     bfc:	c3                   	ret    
     bfd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c00:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c05:	eb ed                	jmp    bf4 <stat+0x34>
     c07:	89 f6                	mov    %esi,%esi
     c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c10 <atoi>:

int
atoi(const char *s)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	53                   	push   %ebx
     c14:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c17:	0f be 11             	movsbl (%ecx),%edx
     c1a:	8d 42 d0             	lea    -0x30(%edx),%eax
     c1d:	3c 09                	cmp    $0x9,%al
  n = 0;
     c1f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     c24:	77 1f                	ja     c45 <atoi+0x35>
     c26:	8d 76 00             	lea    0x0(%esi),%esi
     c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     c30:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c33:	83 c1 01             	add    $0x1,%ecx
     c36:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     c3a:	0f be 11             	movsbl (%ecx),%edx
     c3d:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c40:	80 fb 09             	cmp    $0x9,%bl
     c43:	76 eb                	jbe    c30 <atoi+0x20>
  return n;
}
     c45:	5b                   	pop    %ebx
     c46:	5d                   	pop    %ebp
     c47:	c3                   	ret    
     c48:	90                   	nop
     c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c50 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	56                   	push   %esi
     c54:	53                   	push   %ebx
     c55:	8b 5d 10             	mov    0x10(%ebp),%ebx
     c58:	8b 45 08             	mov    0x8(%ebp),%eax
     c5b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c5e:	85 db                	test   %ebx,%ebx
     c60:	7e 14                	jle    c76 <memmove+0x26>
     c62:	31 d2                	xor    %edx,%edx
     c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     c68:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     c6c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     c6f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     c72:	39 d3                	cmp    %edx,%ebx
     c74:	75 f2                	jne    c68 <memmove+0x18>
  return vdst;
}
     c76:	5b                   	pop    %ebx
     c77:	5e                   	pop    %esi
     c78:	5d                   	pop    %ebp
     c79:	c3                   	ret    

00000c7a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c7a:	b8 01 00 00 00       	mov    $0x1,%eax
     c7f:	cd 40                	int    $0x40
     c81:	c3                   	ret    

00000c82 <exit>:
SYSCALL(exit)
     c82:	b8 02 00 00 00       	mov    $0x2,%eax
     c87:	cd 40                	int    $0x40
     c89:	c3                   	ret    

00000c8a <wait>:
SYSCALL(wait)
     c8a:	b8 03 00 00 00       	mov    $0x3,%eax
     c8f:	cd 40                	int    $0x40
     c91:	c3                   	ret    

00000c92 <pipe>:
SYSCALL(pipe)
     c92:	b8 04 00 00 00       	mov    $0x4,%eax
     c97:	cd 40                	int    $0x40
     c99:	c3                   	ret    

00000c9a <read>:
SYSCALL(read)
     c9a:	b8 05 00 00 00       	mov    $0x5,%eax
     c9f:	cd 40                	int    $0x40
     ca1:	c3                   	ret    

00000ca2 <write>:
SYSCALL(write)
     ca2:	b8 10 00 00 00       	mov    $0x10,%eax
     ca7:	cd 40                	int    $0x40
     ca9:	c3                   	ret    

00000caa <close>:
SYSCALL(close)
     caa:	b8 15 00 00 00       	mov    $0x15,%eax
     caf:	cd 40                	int    $0x40
     cb1:	c3                   	ret    

00000cb2 <kill>:
SYSCALL(kill)
     cb2:	b8 06 00 00 00       	mov    $0x6,%eax
     cb7:	cd 40                	int    $0x40
     cb9:	c3                   	ret    

00000cba <exec>:
SYSCALL(exec)
     cba:	b8 07 00 00 00       	mov    $0x7,%eax
     cbf:	cd 40                	int    $0x40
     cc1:	c3                   	ret    

00000cc2 <open>:
SYSCALL(open)
     cc2:	b8 0f 00 00 00       	mov    $0xf,%eax
     cc7:	cd 40                	int    $0x40
     cc9:	c3                   	ret    

00000cca <mknod>:
SYSCALL(mknod)
     cca:	b8 11 00 00 00       	mov    $0x11,%eax
     ccf:	cd 40                	int    $0x40
     cd1:	c3                   	ret    

00000cd2 <unlink>:
SYSCALL(unlink)
     cd2:	b8 12 00 00 00       	mov    $0x12,%eax
     cd7:	cd 40                	int    $0x40
     cd9:	c3                   	ret    

00000cda <fstat>:
SYSCALL(fstat)
     cda:	b8 08 00 00 00       	mov    $0x8,%eax
     cdf:	cd 40                	int    $0x40
     ce1:	c3                   	ret    

00000ce2 <link>:
SYSCALL(link)
     ce2:	b8 13 00 00 00       	mov    $0x13,%eax
     ce7:	cd 40                	int    $0x40
     ce9:	c3                   	ret    

00000cea <mkdir>:
SYSCALL(mkdir)
     cea:	b8 14 00 00 00       	mov    $0x14,%eax
     cef:	cd 40                	int    $0x40
     cf1:	c3                   	ret    

00000cf2 <chdir>:
SYSCALL(chdir)
     cf2:	b8 09 00 00 00       	mov    $0x9,%eax
     cf7:	cd 40                	int    $0x40
     cf9:	c3                   	ret    

00000cfa <dup>:
SYSCALL(dup)
     cfa:	b8 0a 00 00 00       	mov    $0xa,%eax
     cff:	cd 40                	int    $0x40
     d01:	c3                   	ret    

00000d02 <getpid>:
SYSCALL(getpid)
     d02:	b8 0b 00 00 00       	mov    $0xb,%eax
     d07:	cd 40                	int    $0x40
     d09:	c3                   	ret    

00000d0a <sbrk>:
SYSCALL(sbrk)
     d0a:	b8 0c 00 00 00       	mov    $0xc,%eax
     d0f:	cd 40                	int    $0x40
     d11:	c3                   	ret    

00000d12 <sleep>:
SYSCALL(sleep)
     d12:	b8 0d 00 00 00       	mov    $0xd,%eax
     d17:	cd 40                	int    $0x40
     d19:	c3                   	ret    

00000d1a <uptime>:
SYSCALL(uptime)
     d1a:	b8 0e 00 00 00       	mov    $0xe,%eax
     d1f:	cd 40                	int    $0x40
     d21:	c3                   	ret    

00000d22 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
     d22:	b8 16 00 00 00       	mov    $0x16,%eax
     d27:	cd 40                	int    $0x40
     d29:	c3                   	ret    
     d2a:	66 90                	xchg   %ax,%ax
     d2c:	66 90                	xchg   %ax,%ax
     d2e:	66 90                	xchg   %ax,%ax

00000d30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	57                   	push   %edi
     d34:	56                   	push   %esi
     d35:	53                   	push   %ebx
     d36:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d39:	85 d2                	test   %edx,%edx
{
     d3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     d3e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     d40:	79 76                	jns    db8 <printint+0x88>
     d42:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     d46:	74 70                	je     db8 <printint+0x88>
    x = -xx;
     d48:	f7 d8                	neg    %eax
    neg = 1;
     d4a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     d51:	31 f6                	xor    %esi,%esi
     d53:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     d56:	eb 0a                	jmp    d62 <printint+0x32>
     d58:	90                   	nop
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     d60:	89 fe                	mov    %edi,%esi
     d62:	31 d2                	xor    %edx,%edx
     d64:	8d 7e 01             	lea    0x1(%esi),%edi
     d67:	f7 f1                	div    %ecx
     d69:	0f b6 92 b8 12 00 00 	movzbl 0x12b8(%edx),%edx
  }while((x /= base) != 0);
     d70:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     d72:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     d75:	75 e9                	jne    d60 <printint+0x30>
  if(neg)
     d77:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     d7a:	85 c0                	test   %eax,%eax
     d7c:	74 08                	je     d86 <printint+0x56>
    buf[i++] = '-';
     d7e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     d83:	8d 7e 02             	lea    0x2(%esi),%edi
     d86:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     d8a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     d8d:	8d 76 00             	lea    0x0(%esi),%esi
     d90:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     d93:	83 ec 04             	sub    $0x4,%esp
     d96:	83 ee 01             	sub    $0x1,%esi
     d99:	6a 01                	push   $0x1
     d9b:	53                   	push   %ebx
     d9c:	57                   	push   %edi
     d9d:	88 45 d7             	mov    %al,-0x29(%ebp)
     da0:	e8 fd fe ff ff       	call   ca2 <write>

  while(--i >= 0)
     da5:	83 c4 10             	add    $0x10,%esp
     da8:	39 de                	cmp    %ebx,%esi
     daa:	75 e4                	jne    d90 <printint+0x60>
    putc(fd, buf[i]);
}
     dac:	8d 65 f4             	lea    -0xc(%ebp),%esp
     daf:	5b                   	pop    %ebx
     db0:	5e                   	pop    %esi
     db1:	5f                   	pop    %edi
     db2:	5d                   	pop    %ebp
     db3:	c3                   	ret    
     db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     db8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     dbf:	eb 90                	jmp    d51 <printint+0x21>
     dc1:	eb 0d                	jmp    dd0 <printf>
     dc3:	90                   	nop
     dc4:	90                   	nop
     dc5:	90                   	nop
     dc6:	90                   	nop
     dc7:	90                   	nop
     dc8:	90                   	nop
     dc9:	90                   	nop
     dca:	90                   	nop
     dcb:	90                   	nop
     dcc:	90                   	nop
     dcd:	90                   	nop
     dce:	90                   	nop
     dcf:	90                   	nop

00000dd0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     dd0:	55                   	push   %ebp
     dd1:	89 e5                	mov    %esp,%ebp
     dd3:	57                   	push   %edi
     dd4:	56                   	push   %esi
     dd5:	53                   	push   %ebx
     dd6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     dd9:	8b 75 0c             	mov    0xc(%ebp),%esi
     ddc:	0f b6 1e             	movzbl (%esi),%ebx
     ddf:	84 db                	test   %bl,%bl
     de1:	0f 84 b3 00 00 00    	je     e9a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     de7:	8d 45 10             	lea    0x10(%ebp),%eax
     dea:	83 c6 01             	add    $0x1,%esi
  state = 0;
     ded:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     def:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     df2:	eb 2f                	jmp    e23 <printf+0x53>
     df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     df8:	83 f8 25             	cmp    $0x25,%eax
     dfb:	0f 84 a7 00 00 00    	je     ea8 <printf+0xd8>
  write(fd, &c, 1);
     e01:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e04:	83 ec 04             	sub    $0x4,%esp
     e07:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     e0a:	6a 01                	push   $0x1
     e0c:	50                   	push   %eax
     e0d:	ff 75 08             	pushl  0x8(%ebp)
     e10:	e8 8d fe ff ff       	call   ca2 <write>
     e15:	83 c4 10             	add    $0x10,%esp
     e18:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     e1b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     e1f:	84 db                	test   %bl,%bl
     e21:	74 77                	je     e9a <printf+0xca>
    if(state == 0){
     e23:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     e25:	0f be cb             	movsbl %bl,%ecx
     e28:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e2b:	74 cb                	je     df8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e2d:	83 ff 25             	cmp    $0x25,%edi
     e30:	75 e6                	jne    e18 <printf+0x48>
      if(c == 'd'){
     e32:	83 f8 64             	cmp    $0x64,%eax
     e35:	0f 84 05 01 00 00    	je     f40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e3b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e41:	83 f9 70             	cmp    $0x70,%ecx
     e44:	74 72                	je     eb8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e46:	83 f8 73             	cmp    $0x73,%eax
     e49:	0f 84 99 00 00 00    	je     ee8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e4f:	83 f8 63             	cmp    $0x63,%eax
     e52:	0f 84 08 01 00 00    	je     f60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     e58:	83 f8 25             	cmp    $0x25,%eax
     e5b:	0f 84 ef 00 00 00    	je     f50 <printf+0x180>
  write(fd, &c, 1);
     e61:	8d 45 e7             	lea    -0x19(%ebp),%eax
     e64:	83 ec 04             	sub    $0x4,%esp
     e67:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     e6b:	6a 01                	push   $0x1
     e6d:	50                   	push   %eax
     e6e:	ff 75 08             	pushl  0x8(%ebp)
     e71:	e8 2c fe ff ff       	call   ca2 <write>
     e76:	83 c4 0c             	add    $0xc,%esp
     e79:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     e7c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     e7f:	6a 01                	push   $0x1
     e81:	50                   	push   %eax
     e82:	ff 75 08             	pushl  0x8(%ebp)
     e85:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     e88:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     e8a:	e8 13 fe ff ff       	call   ca2 <write>
  for(i = 0; fmt[i]; i++){
     e8f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     e93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     e96:	84 db                	test   %bl,%bl
     e98:	75 89                	jne    e23 <printf+0x53>
    }
  }
}
     e9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e9d:	5b                   	pop    %ebx
     e9e:	5e                   	pop    %esi
     e9f:	5f                   	pop    %edi
     ea0:	5d                   	pop    %ebp
     ea1:	c3                   	ret    
     ea2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     ea8:	bf 25 00 00 00       	mov    $0x25,%edi
     ead:	e9 66 ff ff ff       	jmp    e18 <printf+0x48>
     eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     eb8:	83 ec 0c             	sub    $0xc,%esp
     ebb:	b9 10 00 00 00       	mov    $0x10,%ecx
     ec0:	6a 00                	push   $0x0
     ec2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     ec5:	8b 45 08             	mov    0x8(%ebp),%eax
     ec8:	8b 17                	mov    (%edi),%edx
     eca:	e8 61 fe ff ff       	call   d30 <printint>
        ap++;
     ecf:	89 f8                	mov    %edi,%eax
     ed1:	83 c4 10             	add    $0x10,%esp
      state = 0;
     ed4:	31 ff                	xor    %edi,%edi
        ap++;
     ed6:	83 c0 04             	add    $0x4,%eax
     ed9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     edc:	e9 37 ff ff ff       	jmp    e18 <printf+0x48>
     ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     ee8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     eeb:	8b 08                	mov    (%eax),%ecx
        ap++;
     eed:	83 c0 04             	add    $0x4,%eax
     ef0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
     ef3:	85 c9                	test   %ecx,%ecx
     ef5:	0f 84 8e 00 00 00    	je     f89 <printf+0x1b9>
        while(*s != 0){
     efb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
     efe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
     f00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
     f02:	84 c0                	test   %al,%al
     f04:	0f 84 0e ff ff ff    	je     e18 <printf+0x48>
     f0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
     f0d:	89 de                	mov    %ebx,%esi
     f0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
     f12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
     f15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     f18:	83 ec 04             	sub    $0x4,%esp
          s++;
     f1b:	83 c6 01             	add    $0x1,%esi
     f1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
     f21:	6a 01                	push   $0x1
     f23:	57                   	push   %edi
     f24:	53                   	push   %ebx
     f25:	e8 78 fd ff ff       	call   ca2 <write>
        while(*s != 0){
     f2a:	0f b6 06             	movzbl (%esi),%eax
     f2d:	83 c4 10             	add    $0x10,%esp
     f30:	84 c0                	test   %al,%al
     f32:	75 e4                	jne    f18 <printf+0x148>
     f34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
     f37:	31 ff                	xor    %edi,%edi
     f39:	e9 da fe ff ff       	jmp    e18 <printf+0x48>
     f3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
     f40:	83 ec 0c             	sub    $0xc,%esp
     f43:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f48:	6a 01                	push   $0x1
     f4a:	e9 73 ff ff ff       	jmp    ec2 <printf+0xf2>
     f4f:	90                   	nop
  write(fd, &c, 1);
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
     f56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     f59:	6a 01                	push   $0x1
     f5b:	e9 21 ff ff ff       	jmp    e81 <printf+0xb1>
        putc(fd, *ap);
     f60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
     f63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     f66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
     f68:	6a 01                	push   $0x1
        ap++;
     f6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
     f6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
     f70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f73:	50                   	push   %eax
     f74:	ff 75 08             	pushl  0x8(%ebp)
     f77:	e8 26 fd ff ff       	call   ca2 <write>
        ap++;
     f7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     f7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f82:	31 ff                	xor    %edi,%edi
     f84:	e9 8f fe ff ff       	jmp    e18 <printf+0x48>
          s = "(null)";
     f89:	bb b0 12 00 00       	mov    $0x12b0,%ebx
        while(*s != 0){
     f8e:	b8 28 00 00 00       	mov    $0x28,%eax
     f93:	e9 72 ff ff ff       	jmp    f0a <printf+0x13a>
     f98:	66 90                	xchg   %ax,%ax
     f9a:	66 90                	xchg   %ax,%ax
     f9c:	66 90                	xchg   %ax,%ax
     f9e:	66 90                	xchg   %ax,%ax

00000fa0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fa0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fa1:	a1 48 17 00 00       	mov    0x1748,%eax
{
     fa6:	89 e5                	mov    %esp,%ebp
     fa8:	57                   	push   %edi
     fa9:	56                   	push   %esi
     faa:	53                   	push   %ebx
     fab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     fae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
     fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fb8:	39 c8                	cmp    %ecx,%eax
     fba:	8b 10                	mov    (%eax),%edx
     fbc:	73 32                	jae    ff0 <free+0x50>
     fbe:	39 d1                	cmp    %edx,%ecx
     fc0:	72 04                	jb     fc6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fc2:	39 d0                	cmp    %edx,%eax
     fc4:	72 32                	jb     ff8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
     fc6:	8b 73 fc             	mov    -0x4(%ebx),%esi
     fc9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     fcc:	39 fa                	cmp    %edi,%edx
     fce:	74 30                	je     1000 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     fd0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
     fd3:	8b 50 04             	mov    0x4(%eax),%edx
     fd6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
     fd9:	39 f1                	cmp    %esi,%ecx
     fdb:	74 3a                	je     1017 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     fdd:	89 08                	mov    %ecx,(%eax)
  freep = p;
     fdf:	a3 48 17 00 00       	mov    %eax,0x1748
}
     fe4:	5b                   	pop    %ebx
     fe5:	5e                   	pop    %esi
     fe6:	5f                   	pop    %edi
     fe7:	5d                   	pop    %ebp
     fe8:	c3                   	ret    
     fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ff0:	39 d0                	cmp    %edx,%eax
     ff2:	72 04                	jb     ff8 <free+0x58>
     ff4:	39 d1                	cmp    %edx,%ecx
     ff6:	72 ce                	jb     fc6 <free+0x26>
{
     ff8:	89 d0                	mov    %edx,%eax
     ffa:	eb bc                	jmp    fb8 <free+0x18>
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1000:	03 72 04             	add    0x4(%edx),%esi
    1003:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1006:	8b 10                	mov    (%eax),%edx
    1008:	8b 12                	mov    (%edx),%edx
    100a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    100d:	8b 50 04             	mov    0x4(%eax),%edx
    1010:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1013:	39 f1                	cmp    %esi,%ecx
    1015:	75 c6                	jne    fdd <free+0x3d>
    p->s.size += bp->s.size;
    1017:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    101a:	a3 48 17 00 00       	mov    %eax,0x1748
    p->s.size += bp->s.size;
    101f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1022:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1025:	89 10                	mov    %edx,(%eax)
}
    1027:	5b                   	pop    %ebx
    1028:	5e                   	pop    %esi
    1029:	5f                   	pop    %edi
    102a:	5d                   	pop    %ebp
    102b:	c3                   	ret    
    102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001030 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
    1036:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1039:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    103c:	8b 15 48 17 00 00    	mov    0x1748,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1042:	8d 78 07             	lea    0x7(%eax),%edi
    1045:	c1 ef 03             	shr    $0x3,%edi
    1048:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    104b:	85 d2                	test   %edx,%edx
    104d:	0f 84 9d 00 00 00    	je     10f0 <malloc+0xc0>
    1053:	8b 02                	mov    (%edx),%eax
    1055:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1058:	39 cf                	cmp    %ecx,%edi
    105a:	76 6c                	jbe    10c8 <malloc+0x98>
    105c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1062:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1067:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    106a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1071:	eb 0e                	jmp    1081 <malloc+0x51>
    1073:	90                   	nop
    1074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1078:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    107a:	8b 48 04             	mov    0x4(%eax),%ecx
    107d:	39 f9                	cmp    %edi,%ecx
    107f:	73 47                	jae    10c8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1081:	39 05 48 17 00 00    	cmp    %eax,0x1748
    1087:	89 c2                	mov    %eax,%edx
    1089:	75 ed                	jne    1078 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    108b:	83 ec 0c             	sub    $0xc,%esp
    108e:	56                   	push   %esi
    108f:	e8 76 fc ff ff       	call   d0a <sbrk>
  if(p == (char*)-1)
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	83 f8 ff             	cmp    $0xffffffff,%eax
    109a:	74 1c                	je     10b8 <malloc+0x88>
  hp->s.size = nu;
    109c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    109f:	83 ec 0c             	sub    $0xc,%esp
    10a2:	83 c0 08             	add    $0x8,%eax
    10a5:	50                   	push   %eax
    10a6:	e8 f5 fe ff ff       	call   fa0 <free>
  return freep;
    10ab:	8b 15 48 17 00 00    	mov    0x1748,%edx
      if((p = morecore(nunits)) == 0)
    10b1:	83 c4 10             	add    $0x10,%esp
    10b4:	85 d2                	test   %edx,%edx
    10b6:	75 c0                	jne    1078 <malloc+0x48>
        return 0;
  }
}
    10b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    10bb:	31 c0                	xor    %eax,%eax
}
    10bd:	5b                   	pop    %ebx
    10be:	5e                   	pop    %esi
    10bf:	5f                   	pop    %edi
    10c0:	5d                   	pop    %ebp
    10c1:	c3                   	ret    
    10c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    10c8:	39 cf                	cmp    %ecx,%edi
    10ca:	74 54                	je     1120 <malloc+0xf0>
        p->s.size -= nunits;
    10cc:	29 f9                	sub    %edi,%ecx
    10ce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10d1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10d4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    10d7:	89 15 48 17 00 00    	mov    %edx,0x1748
}
    10dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    10e0:	83 c0 08             	add    $0x8,%eax
}
    10e3:	5b                   	pop    %ebx
    10e4:	5e                   	pop    %esi
    10e5:	5f                   	pop    %edi
    10e6:	5d                   	pop    %ebp
    10e7:	c3                   	ret    
    10e8:	90                   	nop
    10e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    10f0:	c7 05 48 17 00 00 4c 	movl   $0x174c,0x1748
    10f7:	17 00 00 
    10fa:	c7 05 4c 17 00 00 4c 	movl   $0x174c,0x174c
    1101:	17 00 00 
    base.s.size = 0;
    1104:	b8 4c 17 00 00       	mov    $0x174c,%eax
    1109:	c7 05 50 17 00 00 00 	movl   $0x0,0x1750
    1110:	00 00 00 
    1113:	e9 44 ff ff ff       	jmp    105c <malloc+0x2c>
    1118:	90                   	nop
    1119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1120:	8b 08                	mov    (%eax),%ecx
    1122:	89 0a                	mov    %ecx,(%edx)
    1124:	eb b1                	jmp    10d7 <malloc+0xa7>
