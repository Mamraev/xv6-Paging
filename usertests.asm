
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "usertests starting\n");
      11:	68 36 4d 00 00       	push   $0x4d36
      16:	6a 01                	push   $0x1
      18:	e8 d3 39 00 00       	call   39f0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 4a 4d 00 00       	push   $0x4d4a
      26:	e8 a7 38 00 00       	call   38d2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 b4 54 00 00       	push   $0x54b4
      39:	6a 01                	push   $0x1
      3b:	e8 b0 39 00 00       	call   39f0 <printf>
    exit();
      40:	e8 4d 38 00 00       	call   3892 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 4a 4d 00 00       	push   $0x4d4a
      51:	e8 7c 38 00 00       	call   38d2 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 5c 38 00 00       	call   38ba <close>

  argptest();
      5e:	e8 4d 35 00 00       	call   35b0 <argptest>
  createdelete();
      63:	e8 98 11 00 00       	call   1200 <createdelete>
  linkunlink();
      68:	e8 53 1a 00 00       	call   1ac0 <linkunlink>
  concreate();
      6d:	e8 4e 17 00 00       	call   17c0 <concreate>
  fourfiles();
      72:	e8 89 0f 00 00       	call   1000 <fourfiles>
  sharedfd();
      77:	e8 c4 0d 00 00       	call   e40 <sharedfd>

  bigargtest();
      7c:	e8 ef 31 00 00       	call   3270 <bigargtest>
  bigwrite();
      81:	e8 5a 23 00 00       	call   23e0 <bigwrite>
  bigargtest();
      86:	e8 e5 31 00 00       	call   3270 <bigargtest>
  bsstest();
      8b:	e8 60 31 00 00       	call   31f0 <bsstest>
  //sbrktest();
  validatetest();
      90:	e8 ab 30 00 00       	call   3140 <validatetest>

  opentest();
      95:	e8 46 03 00 00       	call   3e0 <opentest>
  writetest();
      9a:	e8 d1 03 00 00       	call   470 <writetest>
  writetest1();
      9f:	e8 ac 05 00 00       	call   650 <writetest1>
  createtest();
      a4:	e8 77 07 00 00       	call   820 <createtest>

  openiputtest();
      a9:	e8 32 02 00 00       	call   2e0 <openiputtest>
  exitiputtest();
      ae:	e8 3d 01 00 00       	call   1f0 <exitiputtest>
  iputtest();
      b3:	e8 58 00 00 00       	call   110 <iputtest>

  //mem();
  pipe1();
      b8:	e8 43 09 00 00       	call   a00 <pipe1>
  preempt();
      bd:	e8 de 0a 00 00       	call   ba0 <preempt>
  exitwait();
      c2:	e8 19 0c 00 00       	call   ce0 <exitwait>

  rmdot();
      c7:	e8 04 27 00 00       	call   27d0 <rmdot>
  fourteen();
      cc:	e8 bf 25 00 00       	call   2690 <fourteen>
  bigfile();
      d1:	e8 ea 23 00 00       	call   24c0 <bigfile>
  subdir();
      d6:	e8 25 1c 00 00       	call   1d00 <subdir>
  linktest();
      db:	e8 d0 14 00 00       	call   15b0 <linktest>
  unlinkread();
      e0:	e8 3b 13 00 00       	call   1420 <unlinkread>
  dirfile();
      e5:	e8 66 28 00 00       	call   2950 <dirfile>
  iref();
      ea:	e8 61 2a 00 00       	call   2b50 <iref>
  forktest();
      ef:	e8 7c 2b 00 00       	call   2c70 <forktest>
  bigdir(); // slow
      f4:	e8 d7 1a 00 00       	call   1bd0 <bigdir>

  uio();
      f9:	e8 42 34 00 00       	call   3540 <uio>

  exectest();
      fe:	e8 ad 08 00 00       	call   9b0 <exectest>

  exit();
     103:	e8 8a 37 00 00       	call   3892 <exit>
     108:	66 90                	xchg   %ax,%ax
     10a:	66 90                	xchg   %ax,%ax
     10c:	66 90                	xchg   %ax,%ax
     10e:	66 90                	xchg   %ax,%ax

00000110 <iputtest>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
     116:	68 dc 3d 00 00       	push   $0x3ddc
     11b:	ff 35 f8 5d 00 00    	pushl  0x5df8
     121:	e8 ca 38 00 00       	call   39f0 <printf>
  if(mkdir("iputdir") < 0){
     126:	c7 04 24 6f 3d 00 00 	movl   $0x3d6f,(%esp)
     12d:	e8 c8 37 00 00       	call   38fa <mkdir>
     132:	83 c4 10             	add    $0x10,%esp
     135:	85 c0                	test   %eax,%eax
     137:	78 58                	js     191 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     139:	83 ec 0c             	sub    $0xc,%esp
     13c:	68 6f 3d 00 00       	push   $0x3d6f
     141:	e8 bc 37 00 00       	call   3902 <chdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	0f 88 85 00 00 00    	js     1d6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     151:	83 ec 0c             	sub    $0xc,%esp
     154:	68 6c 3d 00 00       	push   $0x3d6c
     159:	e8 84 37 00 00       	call   38e2 <unlink>
     15e:	83 c4 10             	add    $0x10,%esp
     161:	85 c0                	test   %eax,%eax
     163:	78 5a                	js     1bf <iputtest+0xaf>
  if(chdir("/") < 0){
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	68 91 3d 00 00       	push   $0x3d91
     16d:	e8 90 37 00 00       	call   3902 <chdir>
     172:	83 c4 10             	add    $0x10,%esp
     175:	85 c0                	test   %eax,%eax
     177:	78 2f                	js     1a8 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     179:	83 ec 08             	sub    $0x8,%esp
     17c:	68 14 3e 00 00       	push   $0x3e14
     181:	ff 35 f8 5d 00 00    	pushl  0x5df8
     187:	e8 64 38 00 00       	call   39f0 <printf>
}
     18c:	83 c4 10             	add    $0x10,%esp
     18f:	c9                   	leave  
     190:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     191:	50                   	push   %eax
     192:	50                   	push   %eax
     193:	68 48 3d 00 00       	push   $0x3d48
     198:	ff 35 f8 5d 00 00    	pushl  0x5df8
     19e:	e8 4d 38 00 00       	call   39f0 <printf>
    exit();
     1a3:	e8 ea 36 00 00       	call   3892 <exit>
    printf(stdout, "chdir / failed\n");
     1a8:	50                   	push   %eax
     1a9:	50                   	push   %eax
     1aa:	68 93 3d 00 00       	push   $0x3d93
     1af:	ff 35 f8 5d 00 00    	pushl  0x5df8
     1b5:	e8 36 38 00 00       	call   39f0 <printf>
    exit();
     1ba:	e8 d3 36 00 00       	call   3892 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     1bf:	52                   	push   %edx
     1c0:	52                   	push   %edx
     1c1:	68 77 3d 00 00       	push   $0x3d77
     1c6:	ff 35 f8 5d 00 00    	pushl  0x5df8
     1cc:	e8 1f 38 00 00       	call   39f0 <printf>
    exit();
     1d1:	e8 bc 36 00 00       	call   3892 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1d6:	51                   	push   %ecx
     1d7:	51                   	push   %ecx
     1d8:	68 56 3d 00 00       	push   $0x3d56
     1dd:	ff 35 f8 5d 00 00    	pushl  0x5df8
     1e3:	e8 08 38 00 00       	call   39f0 <printf>
    exit();
     1e8:	e8 a5 36 00 00       	call   3892 <exit>
     1ed:	8d 76 00             	lea    0x0(%esi),%esi

000001f0 <exitiputtest>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     1f6:	68 a3 3d 00 00       	push   $0x3da3
     1fb:	ff 35 f8 5d 00 00    	pushl  0x5df8
     201:	e8 ea 37 00 00       	call   39f0 <printf>
  pid = fork();
     206:	e8 7f 36 00 00       	call   388a <fork>
  if(pid < 0){
     20b:	83 c4 10             	add    $0x10,%esp
     20e:	85 c0                	test   %eax,%eax
     210:	0f 88 82 00 00 00    	js     298 <exitiputtest+0xa8>
  if(pid == 0){
     216:	75 48                	jne    260 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     218:	83 ec 0c             	sub    $0xc,%esp
     21b:	68 6f 3d 00 00       	push   $0x3d6f
     220:	e8 d5 36 00 00       	call   38fa <mkdir>
     225:	83 c4 10             	add    $0x10,%esp
     228:	85 c0                	test   %eax,%eax
     22a:	0f 88 96 00 00 00    	js     2c6 <exitiputtest+0xd6>
    if(chdir("iputdir") < 0){
     230:	83 ec 0c             	sub    $0xc,%esp
     233:	68 6f 3d 00 00       	push   $0x3d6f
     238:	e8 c5 36 00 00       	call   3902 <chdir>
     23d:	83 c4 10             	add    $0x10,%esp
     240:	85 c0                	test   %eax,%eax
     242:	78 6b                	js     2af <exitiputtest+0xbf>
    if(unlink("../iputdir") < 0){
     244:	83 ec 0c             	sub    $0xc,%esp
     247:	68 6c 3d 00 00       	push   $0x3d6c
     24c:	e8 91 36 00 00       	call   38e2 <unlink>
     251:	83 c4 10             	add    $0x10,%esp
     254:	85 c0                	test   %eax,%eax
     256:	78 28                	js     280 <exitiputtest+0x90>
    exit();
     258:	e8 35 36 00 00       	call   3892 <exit>
     25d:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     260:	e8 35 36 00 00       	call   389a <wait>
  printf(stdout, "exitiput test ok\n");
     265:	83 ec 08             	sub    $0x8,%esp
     268:	68 c6 3d 00 00       	push   $0x3dc6
     26d:	ff 35 f8 5d 00 00    	pushl  0x5df8
     273:	e8 78 37 00 00       	call   39f0 <printf>
}
     278:	83 c4 10             	add    $0x10,%esp
     27b:	c9                   	leave  
     27c:	c3                   	ret    
     27d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     280:	83 ec 08             	sub    $0x8,%esp
     283:	68 77 3d 00 00       	push   $0x3d77
     288:	ff 35 f8 5d 00 00    	pushl  0x5df8
     28e:	e8 5d 37 00 00       	call   39f0 <printf>
      exit();
     293:	e8 fa 35 00 00       	call   3892 <exit>
    printf(stdout, "fork failed\n");
     298:	51                   	push   %ecx
     299:	51                   	push   %ecx
     29a:	68 89 4c 00 00       	push   $0x4c89
     29f:	ff 35 f8 5d 00 00    	pushl  0x5df8
     2a5:	e8 46 37 00 00       	call   39f0 <printf>
    exit();
     2aa:	e8 e3 35 00 00       	call   3892 <exit>
      printf(stdout, "child chdir failed\n");
     2af:	50                   	push   %eax
     2b0:	50                   	push   %eax
     2b1:	68 b2 3d 00 00       	push   $0x3db2
     2b6:	ff 35 f8 5d 00 00    	pushl  0x5df8
     2bc:	e8 2f 37 00 00       	call   39f0 <printf>
      exit();
     2c1:	e8 cc 35 00 00       	call   3892 <exit>
      printf(stdout, "mkdir failed\n");
     2c6:	52                   	push   %edx
     2c7:	52                   	push   %edx
     2c8:	68 48 3d 00 00       	push   $0x3d48
     2cd:	ff 35 f8 5d 00 00    	pushl  0x5df8
     2d3:	e8 18 37 00 00       	call   39f0 <printf>
      exit();
     2d8:	e8 b5 35 00 00       	call   3892 <exit>
     2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <openiputtest>:
{
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     2e6:	68 d8 3d 00 00       	push   $0x3dd8
     2eb:	ff 35 f8 5d 00 00    	pushl  0x5df8
     2f1:	e8 fa 36 00 00       	call   39f0 <printf>
  if(mkdir("oidir") < 0){
     2f6:	c7 04 24 e7 3d 00 00 	movl   $0x3de7,(%esp)
     2fd:	e8 f8 35 00 00       	call   38fa <mkdir>
     302:	83 c4 10             	add    $0x10,%esp
     305:	85 c0                	test   %eax,%eax
     307:	0f 88 88 00 00 00    	js     395 <openiputtest+0xb5>
  pid = fork();
     30d:	e8 78 35 00 00       	call   388a <fork>
  if(pid < 0){
     312:	85 c0                	test   %eax,%eax
     314:	0f 88 92 00 00 00    	js     3ac <openiputtest+0xcc>
  if(pid == 0){
     31a:	75 34                	jne    350 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     31c:	83 ec 08             	sub    $0x8,%esp
     31f:	6a 02                	push   $0x2
     321:	68 e7 3d 00 00       	push   $0x3de7
     326:	e8 a7 35 00 00       	call   38d2 <open>
    if(fd >= 0){
     32b:	83 c4 10             	add    $0x10,%esp
     32e:	85 c0                	test   %eax,%eax
     330:	78 5e                	js     390 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     332:	83 ec 08             	sub    $0x8,%esp
     335:	68 6c 4d 00 00       	push   $0x4d6c
     33a:	ff 35 f8 5d 00 00    	pushl  0x5df8
     340:	e8 ab 36 00 00       	call   39f0 <printf>
      exit();
     345:	e8 48 35 00 00       	call   3892 <exit>
     34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sleep(1);
     350:	83 ec 0c             	sub    $0xc,%esp
     353:	6a 01                	push   $0x1
     355:	e8 c8 35 00 00       	call   3922 <sleep>
  if(unlink("oidir") != 0){
     35a:	c7 04 24 e7 3d 00 00 	movl   $0x3de7,(%esp)
     361:	e8 7c 35 00 00       	call   38e2 <unlink>
     366:	83 c4 10             	add    $0x10,%esp
     369:	85 c0                	test   %eax,%eax
     36b:	75 56                	jne    3c3 <openiputtest+0xe3>
  wait();
     36d:	e8 28 35 00 00       	call   389a <wait>
  printf(stdout, "openiput test ok\n");
     372:	83 ec 08             	sub    $0x8,%esp
     375:	68 10 3e 00 00       	push   $0x3e10
     37a:	ff 35 f8 5d 00 00    	pushl  0x5df8
     380:	e8 6b 36 00 00       	call   39f0 <printf>
     385:	83 c4 10             	add    $0x10,%esp
}
     388:	c9                   	leave  
     389:	c3                   	ret    
     38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     390:	e8 fd 34 00 00       	call   3892 <exit>
    printf(stdout, "mkdir oidir failed\n");
     395:	51                   	push   %ecx
     396:	51                   	push   %ecx
     397:	68 ed 3d 00 00       	push   $0x3ded
     39c:	ff 35 f8 5d 00 00    	pushl  0x5df8
     3a2:	e8 49 36 00 00       	call   39f0 <printf>
    exit();
     3a7:	e8 e6 34 00 00       	call   3892 <exit>
    printf(stdout, "fork failed\n");
     3ac:	52                   	push   %edx
     3ad:	52                   	push   %edx
     3ae:	68 89 4c 00 00       	push   $0x4c89
     3b3:	ff 35 f8 5d 00 00    	pushl  0x5df8
     3b9:	e8 32 36 00 00       	call   39f0 <printf>
    exit();
     3be:	e8 cf 34 00 00       	call   3892 <exit>
    printf(stdout, "unlink failed\n");
     3c3:	50                   	push   %eax
     3c4:	50                   	push   %eax
     3c5:	68 01 3e 00 00       	push   $0x3e01
     3ca:	ff 35 f8 5d 00 00    	pushl  0x5df8
     3d0:	e8 1b 36 00 00       	call   39f0 <printf>
    exit();
     3d5:	e8 b8 34 00 00       	call   3892 <exit>
     3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003e0 <opentest>:
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     3e6:	68 22 3e 00 00       	push   $0x3e22
     3eb:	ff 35 f8 5d 00 00    	pushl  0x5df8
     3f1:	e8 fa 35 00 00       	call   39f0 <printf>
  fd = open("echo", 0);
     3f6:	58                   	pop    %eax
     3f7:	5a                   	pop    %edx
     3f8:	6a 00                	push   $0x0
     3fa:	68 2d 3e 00 00       	push   $0x3e2d
     3ff:	e8 ce 34 00 00       	call   38d2 <open>
  if(fd < 0){
     404:	83 c4 10             	add    $0x10,%esp
     407:	85 c0                	test   %eax,%eax
     409:	78 36                	js     441 <opentest+0x61>
  close(fd);
     40b:	83 ec 0c             	sub    $0xc,%esp
     40e:	50                   	push   %eax
     40f:	e8 a6 34 00 00       	call   38ba <close>
  fd = open("doesnotexist", 0);
     414:	5a                   	pop    %edx
     415:	59                   	pop    %ecx
     416:	6a 00                	push   $0x0
     418:	68 45 3e 00 00       	push   $0x3e45
     41d:	e8 b0 34 00 00       	call   38d2 <open>
  if(fd >= 0){
     422:	83 c4 10             	add    $0x10,%esp
     425:	85 c0                	test   %eax,%eax
     427:	79 2f                	jns    458 <opentest+0x78>
  printf(stdout, "open test ok\n");
     429:	83 ec 08             	sub    $0x8,%esp
     42c:	68 70 3e 00 00       	push   $0x3e70
     431:	ff 35 f8 5d 00 00    	pushl  0x5df8
     437:	e8 b4 35 00 00       	call   39f0 <printf>
}
     43c:	83 c4 10             	add    $0x10,%esp
     43f:	c9                   	leave  
     440:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     441:	50                   	push   %eax
     442:	50                   	push   %eax
     443:	68 32 3e 00 00       	push   $0x3e32
     448:	ff 35 f8 5d 00 00    	pushl  0x5df8
     44e:	e8 9d 35 00 00       	call   39f0 <printf>
    exit();
     453:	e8 3a 34 00 00       	call   3892 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     458:	50                   	push   %eax
     459:	50                   	push   %eax
     45a:	68 52 3e 00 00       	push   $0x3e52
     45f:	ff 35 f8 5d 00 00    	pushl  0x5df8
     465:	e8 86 35 00 00       	call   39f0 <printf>
    exit();
     46a:	e8 23 34 00 00       	call   3892 <exit>
     46f:	90                   	nop

00000470 <writetest>:
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	56                   	push   %esi
     474:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     475:	83 ec 08             	sub    $0x8,%esp
     478:	68 7e 3e 00 00       	push   $0x3e7e
     47d:	ff 35 f8 5d 00 00    	pushl  0x5df8
     483:	e8 68 35 00 00       	call   39f0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     488:	58                   	pop    %eax
     489:	5a                   	pop    %edx
     48a:	68 02 02 00 00       	push   $0x202
     48f:	68 8f 3e 00 00       	push   $0x3e8f
     494:	e8 39 34 00 00       	call   38d2 <open>
  if(fd >= 0){
     499:	83 c4 10             	add    $0x10,%esp
     49c:	85 c0                	test   %eax,%eax
     49e:	0f 88 88 01 00 00    	js     62c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     4a4:	83 ec 08             	sub    $0x8,%esp
     4a7:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     4a9:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     4ab:	68 95 3e 00 00       	push   $0x3e95
     4b0:	ff 35 f8 5d 00 00    	pushl  0x5df8
     4b6:	e8 35 35 00 00       	call   39f0 <printf>
     4bb:	83 c4 10             	add    $0x10,%esp
     4be:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4c0:	83 ec 04             	sub    $0x4,%esp
     4c3:	6a 0a                	push   $0xa
     4c5:	68 cc 3e 00 00       	push   $0x3ecc
     4ca:	56                   	push   %esi
     4cb:	e8 e2 33 00 00       	call   38b2 <write>
     4d0:	83 c4 10             	add    $0x10,%esp
     4d3:	83 f8 0a             	cmp    $0xa,%eax
     4d6:	0f 85 d9 00 00 00    	jne    5b5 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4dc:	83 ec 04             	sub    $0x4,%esp
     4df:	6a 0a                	push   $0xa
     4e1:	68 d7 3e 00 00       	push   $0x3ed7
     4e6:	56                   	push   %esi
     4e7:	e8 c6 33 00 00       	call   38b2 <write>
     4ec:	83 c4 10             	add    $0x10,%esp
     4ef:	83 f8 0a             	cmp    $0xa,%eax
     4f2:	0f 85 d6 00 00 00    	jne    5ce <writetest+0x15e>
  for(i = 0; i < 100; i++){
     4f8:	83 c3 01             	add    $0x1,%ebx
     4fb:	83 fb 64             	cmp    $0x64,%ebx
     4fe:	75 c0                	jne    4c0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     500:	83 ec 08             	sub    $0x8,%esp
     503:	68 e2 3e 00 00       	push   $0x3ee2
     508:	ff 35 f8 5d 00 00    	pushl  0x5df8
     50e:	e8 dd 34 00 00       	call   39f0 <printf>
  close(fd);
     513:	89 34 24             	mov    %esi,(%esp)
     516:	e8 9f 33 00 00       	call   38ba <close>
  fd = open("small", O_RDONLY);
     51b:	5b                   	pop    %ebx
     51c:	5e                   	pop    %esi
     51d:	6a 00                	push   $0x0
     51f:	68 8f 3e 00 00       	push   $0x3e8f
     524:	e8 a9 33 00 00       	call   38d2 <open>
  if(fd >= 0){
     529:	83 c4 10             	add    $0x10,%esp
     52c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     52e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     530:	0f 88 b1 00 00 00    	js     5e7 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     536:	83 ec 08             	sub    $0x8,%esp
     539:	68 ed 3e 00 00       	push   $0x3eed
     53e:	ff 35 f8 5d 00 00    	pushl  0x5df8
     544:	e8 a7 34 00 00       	call   39f0 <printf>
  i = read(fd, buf, 2000);
     549:	83 c4 0c             	add    $0xc,%esp
     54c:	68 d0 07 00 00       	push   $0x7d0
     551:	68 e0 85 00 00       	push   $0x85e0
     556:	53                   	push   %ebx
     557:	e8 4e 33 00 00       	call   38aa <read>
  if(i == 2000){
     55c:	83 c4 10             	add    $0x10,%esp
     55f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     564:	0f 85 94 00 00 00    	jne    5fe <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	68 21 3f 00 00       	push   $0x3f21
     572:	ff 35 f8 5d 00 00    	pushl  0x5df8
     578:	e8 73 34 00 00       	call   39f0 <printf>
  close(fd);
     57d:	89 1c 24             	mov    %ebx,(%esp)
     580:	e8 35 33 00 00       	call   38ba <close>
  if(unlink("small") < 0){
     585:	c7 04 24 8f 3e 00 00 	movl   $0x3e8f,(%esp)
     58c:	e8 51 33 00 00       	call   38e2 <unlink>
     591:	83 c4 10             	add    $0x10,%esp
     594:	85 c0                	test   %eax,%eax
     596:	78 7d                	js     615 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     598:	83 ec 08             	sub    $0x8,%esp
     59b:	68 49 3f 00 00       	push   $0x3f49
     5a0:	ff 35 f8 5d 00 00    	pushl  0x5df8
     5a6:	e8 45 34 00 00       	call   39f0 <printf>
}
     5ab:	83 c4 10             	add    $0x10,%esp
     5ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5b1:	5b                   	pop    %ebx
     5b2:	5e                   	pop    %esi
     5b3:	5d                   	pop    %ebp
     5b4:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     5b5:	83 ec 04             	sub    $0x4,%esp
     5b8:	53                   	push   %ebx
     5b9:	68 90 4d 00 00       	push   $0x4d90
     5be:	ff 35 f8 5d 00 00    	pushl  0x5df8
     5c4:	e8 27 34 00 00       	call   39f0 <printf>
      exit();
     5c9:	e8 c4 32 00 00       	call   3892 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ce:	83 ec 04             	sub    $0x4,%esp
     5d1:	53                   	push   %ebx
     5d2:	68 b4 4d 00 00       	push   $0x4db4
     5d7:	ff 35 f8 5d 00 00    	pushl  0x5df8
     5dd:	e8 0e 34 00 00       	call   39f0 <printf>
      exit();
     5e2:	e8 ab 32 00 00       	call   3892 <exit>
    printf(stdout, "error: open small failed!\n");
     5e7:	51                   	push   %ecx
     5e8:	51                   	push   %ecx
     5e9:	68 06 3f 00 00       	push   $0x3f06
     5ee:	ff 35 f8 5d 00 00    	pushl  0x5df8
     5f4:	e8 f7 33 00 00       	call   39f0 <printf>
    exit();
     5f9:	e8 94 32 00 00       	call   3892 <exit>
    printf(stdout, "read failed\n");
     5fe:	52                   	push   %edx
     5ff:	52                   	push   %edx
     600:	68 4d 42 00 00       	push   $0x424d
     605:	ff 35 f8 5d 00 00    	pushl  0x5df8
     60b:	e8 e0 33 00 00       	call   39f0 <printf>
    exit();
     610:	e8 7d 32 00 00       	call   3892 <exit>
    printf(stdout, "unlink small failed\n");
     615:	50                   	push   %eax
     616:	50                   	push   %eax
     617:	68 34 3f 00 00       	push   $0x3f34
     61c:	ff 35 f8 5d 00 00    	pushl  0x5df8
     622:	e8 c9 33 00 00       	call   39f0 <printf>
    exit();
     627:	e8 66 32 00 00       	call   3892 <exit>
    printf(stdout, "error: creat small failed!\n");
     62c:	50                   	push   %eax
     62d:	50                   	push   %eax
     62e:	68 b0 3e 00 00       	push   $0x3eb0
     633:	ff 35 f8 5d 00 00    	pushl  0x5df8
     639:	e8 b2 33 00 00       	call   39f0 <printf>
    exit();
     63e:	e8 4f 32 00 00       	call   3892 <exit>
     643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000650 <writetest1>:
{
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	56                   	push   %esi
     654:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     655:	83 ec 08             	sub    $0x8,%esp
     658:	68 5d 3f 00 00       	push   $0x3f5d
     65d:	ff 35 f8 5d 00 00    	pushl  0x5df8
     663:	e8 88 33 00 00       	call   39f0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     668:	58                   	pop    %eax
     669:	5a                   	pop    %edx
     66a:	68 02 02 00 00       	push   $0x202
     66f:	68 d7 3f 00 00       	push   $0x3fd7
     674:	e8 59 32 00 00       	call   38d2 <open>
  if(fd < 0){
     679:	83 c4 10             	add    $0x10,%esp
     67c:	85 c0                	test   %eax,%eax
     67e:	0f 88 61 01 00 00    	js     7e5 <writetest1+0x195>
     684:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     686:	31 db                	xor    %ebx,%ebx
     688:	90                   	nop
     689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, buf, 512) != 512){
     690:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     693:	89 1d e0 85 00 00    	mov    %ebx,0x85e0
    if(write(fd, buf, 512) != 512){
     699:	68 00 02 00 00       	push   $0x200
     69e:	68 e0 85 00 00       	push   $0x85e0
     6a3:	56                   	push   %esi
     6a4:	e8 09 32 00 00       	call   38b2 <write>
     6a9:	83 c4 10             	add    $0x10,%esp
     6ac:	3d 00 02 00 00       	cmp    $0x200,%eax
     6b1:	0f 85 b3 00 00 00    	jne    76a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     6b7:	83 c3 01             	add    $0x1,%ebx
     6ba:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6c0:	75 ce                	jne    690 <writetest1+0x40>
  close(fd);
     6c2:	83 ec 0c             	sub    $0xc,%esp
     6c5:	56                   	push   %esi
     6c6:	e8 ef 31 00 00       	call   38ba <close>
  fd = open("big", O_RDONLY);
     6cb:	5b                   	pop    %ebx
     6cc:	5e                   	pop    %esi
     6cd:	6a 00                	push   $0x0
     6cf:	68 d7 3f 00 00       	push   $0x3fd7
     6d4:	e8 f9 31 00 00       	call   38d2 <open>
  if(fd < 0){
     6d9:	83 c4 10             	add    $0x10,%esp
     6dc:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     6de:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6e0:	0f 88 e8 00 00 00    	js     7ce <writetest1+0x17e>
  n = 0;
     6e6:	31 db                	xor    %ebx,%ebx
     6e8:	eb 1d                	jmp    707 <writetest1+0xb7>
     6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     6f0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f5:	0f 85 9f 00 00 00    	jne    79a <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     6fb:	a1 e0 85 00 00       	mov    0x85e0,%eax
     700:	39 d8                	cmp    %ebx,%eax
     702:	75 7f                	jne    783 <writetest1+0x133>
    n++;
     704:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
     707:	83 ec 04             	sub    $0x4,%esp
     70a:	68 00 02 00 00       	push   $0x200
     70f:	68 e0 85 00 00       	push   $0x85e0
     714:	56                   	push   %esi
     715:	e8 90 31 00 00       	call   38aa <read>
    if(i == 0){
     71a:	83 c4 10             	add    $0x10,%esp
     71d:	85 c0                	test   %eax,%eax
     71f:	75 cf                	jne    6f0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     721:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     727:	0f 84 86 00 00 00    	je     7b3 <writetest1+0x163>
  close(fd);
     72d:	83 ec 0c             	sub    $0xc,%esp
     730:	56                   	push   %esi
     731:	e8 84 31 00 00       	call   38ba <close>
  if(unlink("big") < 0){
     736:	c7 04 24 d7 3f 00 00 	movl   $0x3fd7,(%esp)
     73d:	e8 a0 31 00 00       	call   38e2 <unlink>
     742:	83 c4 10             	add    $0x10,%esp
     745:	85 c0                	test   %eax,%eax
     747:	0f 88 af 00 00 00    	js     7fc <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     74d:	83 ec 08             	sub    $0x8,%esp
     750:	68 fe 3f 00 00       	push   $0x3ffe
     755:	ff 35 f8 5d 00 00    	pushl  0x5df8
     75b:	e8 90 32 00 00       	call   39f0 <printf>
}
     760:	83 c4 10             	add    $0x10,%esp
     763:	8d 65 f8             	lea    -0x8(%ebp),%esp
     766:	5b                   	pop    %ebx
     767:	5e                   	pop    %esi
     768:	5d                   	pop    %ebp
     769:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     76a:	83 ec 04             	sub    $0x4,%esp
     76d:	53                   	push   %ebx
     76e:	68 87 3f 00 00       	push   $0x3f87
     773:	ff 35 f8 5d 00 00    	pushl  0x5df8
     779:	e8 72 32 00 00       	call   39f0 <printf>
      exit();
     77e:	e8 0f 31 00 00       	call   3892 <exit>
      printf(stdout, "read content of block %d is %d\n",
     783:	50                   	push   %eax
     784:	53                   	push   %ebx
     785:	68 d8 4d 00 00       	push   $0x4dd8
     78a:	ff 35 f8 5d 00 00    	pushl  0x5df8
     790:	e8 5b 32 00 00       	call   39f0 <printf>
      exit();
     795:	e8 f8 30 00 00       	call   3892 <exit>
      printf(stdout, "read failed %d\n", i);
     79a:	83 ec 04             	sub    $0x4,%esp
     79d:	50                   	push   %eax
     79e:	68 db 3f 00 00       	push   $0x3fdb
     7a3:	ff 35 f8 5d 00 00    	pushl  0x5df8
     7a9:	e8 42 32 00 00       	call   39f0 <printf>
      exit();
     7ae:	e8 df 30 00 00       	call   3892 <exit>
        printf(stdout, "read only %d blocks from big", n);
     7b3:	52                   	push   %edx
     7b4:	68 8b 00 00 00       	push   $0x8b
     7b9:	68 be 3f 00 00       	push   $0x3fbe
     7be:	ff 35 f8 5d 00 00    	pushl  0x5df8
     7c4:	e8 27 32 00 00       	call   39f0 <printf>
        exit();
     7c9:	e8 c4 30 00 00       	call   3892 <exit>
    printf(stdout, "error: open big failed!\n");
     7ce:	51                   	push   %ecx
     7cf:	51                   	push   %ecx
     7d0:	68 a5 3f 00 00       	push   $0x3fa5
     7d5:	ff 35 f8 5d 00 00    	pushl  0x5df8
     7db:	e8 10 32 00 00       	call   39f0 <printf>
    exit();
     7e0:	e8 ad 30 00 00       	call   3892 <exit>
    printf(stdout, "error: creat big failed!\n");
     7e5:	50                   	push   %eax
     7e6:	50                   	push   %eax
     7e7:	68 6d 3f 00 00       	push   $0x3f6d
     7ec:	ff 35 f8 5d 00 00    	pushl  0x5df8
     7f2:	e8 f9 31 00 00       	call   39f0 <printf>
    exit();
     7f7:	e8 96 30 00 00       	call   3892 <exit>
    printf(stdout, "unlink big failed\n");
     7fc:	50                   	push   %eax
     7fd:	50                   	push   %eax
     7fe:	68 eb 3f 00 00       	push   $0x3feb
     803:	ff 35 f8 5d 00 00    	pushl  0x5df8
     809:	e8 e2 31 00 00       	call   39f0 <printf>
    exit();
     80e:	e8 7f 30 00 00       	call   3892 <exit>
     813:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000820 <createtest>:
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	53                   	push   %ebx
  name[2] = '\0';
     824:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     829:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     82c:	68 f8 4d 00 00       	push   $0x4df8
     831:	ff 35 f8 5d 00 00    	pushl  0x5df8
     837:	e8 b4 31 00 00       	call   39f0 <printf>
  name[0] = 'a';
     83c:	c6 05 e0 a5 00 00 61 	movb   $0x61,0xa5e0
  name[2] = '\0';
     843:	c6 05 e2 a5 00 00 00 	movb   $0x0,0xa5e2
     84a:	83 c4 10             	add    $0x10,%esp
     84d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     850:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     853:	88 1d e1 a5 00 00    	mov    %bl,0xa5e1
     859:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     85c:	68 02 02 00 00       	push   $0x202
     861:	68 e0 a5 00 00       	push   $0xa5e0
     866:	e8 67 30 00 00       	call   38d2 <open>
    close(fd);
     86b:	89 04 24             	mov    %eax,(%esp)
     86e:	e8 47 30 00 00       	call   38ba <close>
  for(i = 0; i < 52; i++){
     873:	83 c4 10             	add    $0x10,%esp
     876:	80 fb 64             	cmp    $0x64,%bl
     879:	75 d5                	jne    850 <createtest+0x30>
  name[0] = 'a';
     87b:	c6 05 e0 a5 00 00 61 	movb   $0x61,0xa5e0
  name[2] = '\0';
     882:	c6 05 e2 a5 00 00 00 	movb   $0x0,0xa5e2
     889:	bb 30 00 00 00       	mov    $0x30,%ebx
     88e:	66 90                	xchg   %ax,%ax
    unlink(name);
     890:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     893:	88 1d e1 a5 00 00    	mov    %bl,0xa5e1
     899:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     89c:	68 e0 a5 00 00       	push   $0xa5e0
     8a1:	e8 3c 30 00 00       	call   38e2 <unlink>
  for(i = 0; i < 52; i++){
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	80 fb 64             	cmp    $0x64,%bl
     8ac:	75 e2                	jne    890 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     8ae:	83 ec 08             	sub    $0x8,%esp
     8b1:	68 20 4e 00 00       	push   $0x4e20
     8b6:	ff 35 f8 5d 00 00    	pushl  0x5df8
     8bc:	e8 2f 31 00 00       	call   39f0 <printf>
}
     8c1:	83 c4 10             	add    $0x10,%esp
     8c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8c7:	c9                   	leave  
     8c8:	c3                   	ret    
     8c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008d0 <dirtest>:
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8d6:	68 0c 40 00 00       	push   $0x400c
     8db:	ff 35 f8 5d 00 00    	pushl  0x5df8
     8e1:	e8 0a 31 00 00       	call   39f0 <printf>
  if(mkdir("dir0") < 0){
     8e6:	c7 04 24 18 40 00 00 	movl   $0x4018,(%esp)
     8ed:	e8 08 30 00 00       	call   38fa <mkdir>
     8f2:	83 c4 10             	add    $0x10,%esp
     8f5:	85 c0                	test   %eax,%eax
     8f7:	78 58                	js     951 <dirtest+0x81>
  if(chdir("dir0") < 0){
     8f9:	83 ec 0c             	sub    $0xc,%esp
     8fc:	68 18 40 00 00       	push   $0x4018
     901:	e8 fc 2f 00 00       	call   3902 <chdir>
     906:	83 c4 10             	add    $0x10,%esp
     909:	85 c0                	test   %eax,%eax
     90b:	0f 88 85 00 00 00    	js     996 <dirtest+0xc6>
  if(chdir("..") < 0){
     911:	83 ec 0c             	sub    $0xc,%esp
     914:	68 bd 45 00 00       	push   $0x45bd
     919:	e8 e4 2f 00 00       	call   3902 <chdir>
     91e:	83 c4 10             	add    $0x10,%esp
     921:	85 c0                	test   %eax,%eax
     923:	78 5a                	js     97f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     925:	83 ec 0c             	sub    $0xc,%esp
     928:	68 18 40 00 00       	push   $0x4018
     92d:	e8 b0 2f 00 00       	call   38e2 <unlink>
     932:	83 c4 10             	add    $0x10,%esp
     935:	85 c0                	test   %eax,%eax
     937:	78 2f                	js     968 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     939:	83 ec 08             	sub    $0x8,%esp
     93c:	68 55 40 00 00       	push   $0x4055
     941:	ff 35 f8 5d 00 00    	pushl  0x5df8
     947:	e8 a4 30 00 00       	call   39f0 <printf>
}
     94c:	83 c4 10             	add    $0x10,%esp
     94f:	c9                   	leave  
     950:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     951:	50                   	push   %eax
     952:	50                   	push   %eax
     953:	68 48 3d 00 00       	push   $0x3d48
     958:	ff 35 f8 5d 00 00    	pushl  0x5df8
     95e:	e8 8d 30 00 00       	call   39f0 <printf>
    exit();
     963:	e8 2a 2f 00 00       	call   3892 <exit>
    printf(stdout, "unlink dir0 failed\n");
     968:	50                   	push   %eax
     969:	50                   	push   %eax
     96a:	68 41 40 00 00       	push   $0x4041
     96f:	ff 35 f8 5d 00 00    	pushl  0x5df8
     975:	e8 76 30 00 00       	call   39f0 <printf>
    exit();
     97a:	e8 13 2f 00 00       	call   3892 <exit>
    printf(stdout, "chdir .. failed\n");
     97f:	52                   	push   %edx
     980:	52                   	push   %edx
     981:	68 30 40 00 00       	push   $0x4030
     986:	ff 35 f8 5d 00 00    	pushl  0x5df8
     98c:	e8 5f 30 00 00       	call   39f0 <printf>
    exit();
     991:	e8 fc 2e 00 00       	call   3892 <exit>
    printf(stdout, "chdir dir0 failed\n");
     996:	51                   	push   %ecx
     997:	51                   	push   %ecx
     998:	68 1d 40 00 00       	push   $0x401d
     99d:	ff 35 f8 5d 00 00    	pushl  0x5df8
     9a3:	e8 48 30 00 00       	call   39f0 <printf>
    exit();
     9a8:	e8 e5 2e 00 00       	call   3892 <exit>
     9ad:	8d 76 00             	lea    0x0(%esi),%esi

000009b0 <exectest>:
{
     9b0:	55                   	push   %ebp
     9b1:	89 e5                	mov    %esp,%ebp
     9b3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     9b6:	68 64 40 00 00       	push   $0x4064
     9bb:	ff 35 f8 5d 00 00    	pushl  0x5df8
     9c1:	e8 2a 30 00 00       	call   39f0 <printf>
  if(exec("echo", echoargv) < 0){
     9c6:	5a                   	pop    %edx
     9c7:	59                   	pop    %ecx
     9c8:	68 fc 5d 00 00       	push   $0x5dfc
     9cd:	68 2d 3e 00 00       	push   $0x3e2d
     9d2:	e8 f3 2e 00 00       	call   38ca <exec>
     9d7:	83 c4 10             	add    $0x10,%esp
     9da:	85 c0                	test   %eax,%eax
     9dc:	78 02                	js     9e0 <exectest+0x30>
}
     9de:	c9                   	leave  
     9df:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     9e0:	50                   	push   %eax
     9e1:	50                   	push   %eax
     9e2:	68 6f 40 00 00       	push   $0x406f
     9e7:	ff 35 f8 5d 00 00    	pushl  0x5df8
     9ed:	e8 fe 2f 00 00       	call   39f0 <printf>
    exit();
     9f2:	e8 9b 2e 00 00       	call   3892 <exit>
     9f7:	89 f6                	mov    %esi,%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000a00 <pipe1>:
{
     a00:	55                   	push   %ebp
     a01:	89 e5                	mov    %esp,%ebp
     a03:	57                   	push   %edi
     a04:	56                   	push   %esi
     a05:	53                   	push   %ebx
  if(pipe(fds) != 0){
     a06:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     a09:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     a0c:	50                   	push   %eax
     a0d:	e8 90 2e 00 00       	call   38a2 <pipe>
     a12:	83 c4 10             	add    $0x10,%esp
     a15:	85 c0                	test   %eax,%eax
     a17:	0f 85 3e 01 00 00    	jne    b5b <pipe1+0x15b>
     a1d:	89 c3                	mov    %eax,%ebx
  pid = fork();
     a1f:	e8 66 2e 00 00       	call   388a <fork>
  if(pid == 0){
     a24:	83 f8 00             	cmp    $0x0,%eax
     a27:	0f 84 84 00 00 00    	je     ab1 <pipe1+0xb1>
  } else if(pid > 0){
     a2d:	0f 8e 3b 01 00 00    	jle    b6e <pipe1+0x16e>
    close(fds[1]);
     a33:	83 ec 0c             	sub    $0xc,%esp
     a36:	ff 75 e4             	pushl  -0x1c(%ebp)
    cc = 1;
     a39:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a3e:	e8 77 2e 00 00       	call   38ba <close>
    while((n = read(fds[0], buf, cc)) > 0){
     a43:	83 c4 10             	add    $0x10,%esp
    total = 0;
     a46:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a4d:	83 ec 04             	sub    $0x4,%esp
     a50:	57                   	push   %edi
     a51:	68 e0 85 00 00       	push   $0x85e0
     a56:	ff 75 e0             	pushl  -0x20(%ebp)
     a59:	e8 4c 2e 00 00       	call   38aa <read>
     a5e:	83 c4 10             	add    $0x10,%esp
     a61:	85 c0                	test   %eax,%eax
     a63:	0f 8e ab 00 00 00    	jle    b14 <pipe1+0x114>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a69:	89 d9                	mov    %ebx,%ecx
     a6b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a6e:	f7 d9                	neg    %ecx
     a70:	38 9c 0b e0 85 00 00 	cmp    %bl,0x85e0(%ebx,%ecx,1)
     a77:	8d 53 01             	lea    0x1(%ebx),%edx
     a7a:	75 1b                	jne    a97 <pipe1+0x97>
      for(i = 0; i < n; i++){
     a7c:	39 f2                	cmp    %esi,%edx
     a7e:	89 d3                	mov    %edx,%ebx
     a80:	75 ee                	jne    a70 <pipe1+0x70>
      cc = cc * 2;
     a82:	01 ff                	add    %edi,%edi
      total += n;
     a84:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a87:	b8 00 20 00 00       	mov    $0x2000,%eax
     a8c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a92:	0f 4f f8             	cmovg  %eax,%edi
     a95:	eb b6                	jmp    a4d <pipe1+0x4d>
          printf(1, "pipe1 oops 2\n");
     a97:	83 ec 08             	sub    $0x8,%esp
     a9a:	68 9e 40 00 00       	push   $0x409e
     a9f:	6a 01                	push   $0x1
     aa1:	e8 4a 2f 00 00       	call   39f0 <printf>
          return;
     aa6:	83 c4 10             	add    $0x10,%esp
}
     aa9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     aac:	5b                   	pop    %ebx
     aad:	5e                   	pop    %esi
     aae:	5f                   	pop    %edi
     aaf:	5d                   	pop    %ebp
     ab0:	c3                   	ret    
    close(fds[0]);
     ab1:	83 ec 0c             	sub    $0xc,%esp
     ab4:	ff 75 e0             	pushl  -0x20(%ebp)
     ab7:	31 db                	xor    %ebx,%ebx
     ab9:	be 09 04 00 00       	mov    $0x409,%esi
     abe:	e8 f7 2d 00 00       	call   38ba <close>
     ac3:	83 c4 10             	add    $0x10,%esp
     ac6:	89 d8                	mov    %ebx,%eax
     ac8:	89 f2                	mov    %esi,%edx
     aca:	f7 d8                	neg    %eax
     acc:	29 da                	sub    %ebx,%edx
     ace:	66 90                	xchg   %ax,%ax
        buf[i] = seq++;
     ad0:	88 84 03 e0 85 00 00 	mov    %al,0x85e0(%ebx,%eax,1)
     ad7:	83 c0 01             	add    $0x1,%eax
      for(i = 0; i < 1033; i++)
     ada:	39 d0                	cmp    %edx,%eax
     adc:	75 f2                	jne    ad0 <pipe1+0xd0>
      if(write(fds[1], buf, 1033) != 1033){
     ade:	83 ec 04             	sub    $0x4,%esp
     ae1:	68 09 04 00 00       	push   $0x409
     ae6:	68 e0 85 00 00       	push   $0x85e0
     aeb:	ff 75 e4             	pushl  -0x1c(%ebp)
     aee:	e8 bf 2d 00 00       	call   38b2 <write>
     af3:	83 c4 10             	add    $0x10,%esp
     af6:	3d 09 04 00 00       	cmp    $0x409,%eax
     afb:	0f 85 80 00 00 00    	jne    b81 <pipe1+0x181>
     b01:	81 eb 09 04 00 00    	sub    $0x409,%ebx
    for(n = 0; n < 5; n++){
     b07:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     b0d:	75 b7                	jne    ac6 <pipe1+0xc6>
    exit();
     b0f:	e8 7e 2d 00 00       	call   3892 <exit>
    if(total != 5 * 1033){
     b14:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b1b:	75 29                	jne    b46 <pipe1+0x146>
    close(fds[0]);
     b1d:	83 ec 0c             	sub    $0xc,%esp
     b20:	ff 75 e0             	pushl  -0x20(%ebp)
     b23:	e8 92 2d 00 00       	call   38ba <close>
    wait();
     b28:	e8 6d 2d 00 00       	call   389a <wait>
  printf(1, "pipe1 ok\n");
     b2d:	5a                   	pop    %edx
     b2e:	59                   	pop    %ecx
     b2f:	68 c3 40 00 00       	push   $0x40c3
     b34:	6a 01                	push   $0x1
     b36:	e8 b5 2e 00 00       	call   39f0 <printf>
     b3b:	83 c4 10             	add    $0x10,%esp
}
     b3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b41:	5b                   	pop    %ebx
     b42:	5e                   	pop    %esi
     b43:	5f                   	pop    %edi
     b44:	5d                   	pop    %ebp
     b45:	c3                   	ret    
      printf(1, "pipe1 oops 3 total %d\n", total);
     b46:	53                   	push   %ebx
     b47:	ff 75 d4             	pushl  -0x2c(%ebp)
     b4a:	68 ac 40 00 00       	push   $0x40ac
     b4f:	6a 01                	push   $0x1
     b51:	e8 9a 2e 00 00       	call   39f0 <printf>
      exit();
     b56:	e8 37 2d 00 00       	call   3892 <exit>
    printf(1, "pipe() failed\n");
     b5b:	57                   	push   %edi
     b5c:	57                   	push   %edi
     b5d:	68 81 40 00 00       	push   $0x4081
     b62:	6a 01                	push   $0x1
     b64:	e8 87 2e 00 00       	call   39f0 <printf>
    exit();
     b69:	e8 24 2d 00 00       	call   3892 <exit>
    printf(1, "fork() failed\n");
     b6e:	50                   	push   %eax
     b6f:	50                   	push   %eax
     b70:	68 cd 40 00 00       	push   $0x40cd
     b75:	6a 01                	push   $0x1
     b77:	e8 74 2e 00 00       	call   39f0 <printf>
    exit();
     b7c:	e8 11 2d 00 00       	call   3892 <exit>
        printf(1, "pipe1 oops 1\n");
     b81:	56                   	push   %esi
     b82:	56                   	push   %esi
     b83:	68 90 40 00 00       	push   $0x4090
     b88:	6a 01                	push   $0x1
     b8a:	e8 61 2e 00 00       	call   39f0 <printf>
        exit();
     b8f:	e8 fe 2c 00 00       	call   3892 <exit>
     b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ba0 <preempt>:
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	57                   	push   %edi
     ba4:	56                   	push   %esi
     ba5:	53                   	push   %ebx
     ba6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     ba9:	68 dc 40 00 00       	push   $0x40dc
     bae:	6a 01                	push   $0x1
     bb0:	e8 3b 2e 00 00       	call   39f0 <printf>
  pid1 = fork();
     bb5:	e8 d0 2c 00 00       	call   388a <fork>
  if(pid1 == 0)
     bba:	83 c4 10             	add    $0x10,%esp
     bbd:	85 c0                	test   %eax,%eax
     bbf:	75 02                	jne    bc3 <preempt+0x23>
     bc1:	eb fe                	jmp    bc1 <preempt+0x21>
     bc3:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     bc5:	e8 c0 2c 00 00       	call   388a <fork>
  if(pid2 == 0)
     bca:	85 c0                	test   %eax,%eax
  pid2 = fork();
     bcc:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bce:	75 02                	jne    bd2 <preempt+0x32>
     bd0:	eb fe                	jmp    bd0 <preempt+0x30>
  pipe(pfds);
     bd2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bd5:	83 ec 0c             	sub    $0xc,%esp
     bd8:	50                   	push   %eax
     bd9:	e8 c4 2c 00 00       	call   38a2 <pipe>
  pid3 = fork();
     bde:	e8 a7 2c 00 00       	call   388a <fork>
  if(pid3 == 0){
     be3:	83 c4 10             	add    $0x10,%esp
     be6:	85 c0                	test   %eax,%eax
  pid3 = fork();
     be8:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     bea:	75 46                	jne    c32 <preempt+0x92>
    close(pfds[0]);
     bec:	83 ec 0c             	sub    $0xc,%esp
     bef:	ff 75 e0             	pushl  -0x20(%ebp)
     bf2:	e8 c3 2c 00 00       	call   38ba <close>
    if(write(pfds[1], "x", 1) != 1)
     bf7:	83 c4 0c             	add    $0xc,%esp
     bfa:	6a 01                	push   $0x1
     bfc:	68 a1 46 00 00       	push   $0x46a1
     c01:	ff 75 e4             	pushl  -0x1c(%ebp)
     c04:	e8 a9 2c 00 00       	call   38b2 <write>
     c09:	83 c4 10             	add    $0x10,%esp
     c0c:	83 e8 01             	sub    $0x1,%eax
     c0f:	74 11                	je     c22 <preempt+0x82>
      printf(1, "preempt write error");
     c11:	50                   	push   %eax
     c12:	50                   	push   %eax
     c13:	68 e6 40 00 00       	push   $0x40e6
     c18:	6a 01                	push   $0x1
     c1a:	e8 d1 2d 00 00       	call   39f0 <printf>
     c1f:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c22:	83 ec 0c             	sub    $0xc,%esp
     c25:	ff 75 e4             	pushl  -0x1c(%ebp)
     c28:	e8 8d 2c 00 00       	call   38ba <close>
     c2d:	83 c4 10             	add    $0x10,%esp
     c30:	eb fe                	jmp    c30 <preempt+0x90>
  close(pfds[1]);
     c32:	83 ec 0c             	sub    $0xc,%esp
     c35:	ff 75 e4             	pushl  -0x1c(%ebp)
     c38:	e8 7d 2c 00 00       	call   38ba <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c3d:	83 c4 0c             	add    $0xc,%esp
     c40:	68 00 20 00 00       	push   $0x2000
     c45:	68 e0 85 00 00       	push   $0x85e0
     c4a:	ff 75 e0             	pushl  -0x20(%ebp)
     c4d:	e8 58 2c 00 00       	call   38aa <read>
     c52:	83 c4 10             	add    $0x10,%esp
     c55:	83 e8 01             	sub    $0x1,%eax
     c58:	74 19                	je     c73 <preempt+0xd3>
    printf(1, "preempt read error");
     c5a:	50                   	push   %eax
     c5b:	50                   	push   %eax
     c5c:	68 fa 40 00 00       	push   $0x40fa
     c61:	6a 01                	push   $0x1
     c63:	e8 88 2d 00 00       	call   39f0 <printf>
    return;
     c68:	83 c4 10             	add    $0x10,%esp
}
     c6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c6e:	5b                   	pop    %ebx
     c6f:	5e                   	pop    %esi
     c70:	5f                   	pop    %edi
     c71:	5d                   	pop    %ebp
     c72:	c3                   	ret    
  close(pfds[0]);
     c73:	83 ec 0c             	sub    $0xc,%esp
     c76:	ff 75 e0             	pushl  -0x20(%ebp)
     c79:	e8 3c 2c 00 00       	call   38ba <close>
  printf(1, "kill... ");
     c7e:	58                   	pop    %eax
     c7f:	5a                   	pop    %edx
     c80:	68 0d 41 00 00       	push   $0x410d
     c85:	6a 01                	push   $0x1
     c87:	e8 64 2d 00 00       	call   39f0 <printf>
  kill(pid1);
     c8c:	89 3c 24             	mov    %edi,(%esp)
     c8f:	e8 2e 2c 00 00       	call   38c2 <kill>
  kill(pid2);
     c94:	89 34 24             	mov    %esi,(%esp)
     c97:	e8 26 2c 00 00       	call   38c2 <kill>
  kill(pid3);
     c9c:	89 1c 24             	mov    %ebx,(%esp)
     c9f:	e8 1e 2c 00 00       	call   38c2 <kill>
  printf(1, "wait... ");
     ca4:	59                   	pop    %ecx
     ca5:	5b                   	pop    %ebx
     ca6:	68 16 41 00 00       	push   $0x4116
     cab:	6a 01                	push   $0x1
     cad:	e8 3e 2d 00 00       	call   39f0 <printf>
  wait();
     cb2:	e8 e3 2b 00 00       	call   389a <wait>
  wait();
     cb7:	e8 de 2b 00 00       	call   389a <wait>
  wait();
     cbc:	e8 d9 2b 00 00       	call   389a <wait>
  printf(1, "preempt ok\n");
     cc1:	5e                   	pop    %esi
     cc2:	5f                   	pop    %edi
     cc3:	68 1f 41 00 00       	push   $0x411f
     cc8:	6a 01                	push   $0x1
     cca:	e8 21 2d 00 00       	call   39f0 <printf>
     ccf:	83 c4 10             	add    $0x10,%esp
     cd2:	eb 97                	jmp    c6b <preempt+0xcb>
     cd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000ce0 <exitwait>:
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	be 64 00 00 00       	mov    $0x64,%esi
     ce9:	53                   	push   %ebx
     cea:	eb 14                	jmp    d00 <exitwait+0x20>
     cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     cf0:	74 6f                	je     d61 <exitwait+0x81>
      if(wait() != pid){
     cf2:	e8 a3 2b 00 00       	call   389a <wait>
     cf7:	39 d8                	cmp    %ebx,%eax
     cf9:	75 2d                	jne    d28 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     cfb:	83 ee 01             	sub    $0x1,%esi
     cfe:	74 48                	je     d48 <exitwait+0x68>
    pid = fork();
     d00:	e8 85 2b 00 00       	call   388a <fork>
    if(pid < 0){
     d05:	85 c0                	test   %eax,%eax
    pid = fork();
     d07:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d09:	79 e5                	jns    cf0 <exitwait+0x10>
      printf(1, "fork failed\n");
     d0b:	83 ec 08             	sub    $0x8,%esp
     d0e:	68 89 4c 00 00       	push   $0x4c89
     d13:	6a 01                	push   $0x1
     d15:	e8 d6 2c 00 00       	call   39f0 <printf>
      return;
     d1a:	83 c4 10             	add    $0x10,%esp
}
     d1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d20:	5b                   	pop    %ebx
     d21:	5e                   	pop    %esi
     d22:	5d                   	pop    %ebp
     d23:	c3                   	ret    
     d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d28:	83 ec 08             	sub    $0x8,%esp
     d2b:	68 2b 41 00 00       	push   $0x412b
     d30:	6a 01                	push   $0x1
     d32:	e8 b9 2c 00 00       	call   39f0 <printf>
        return;
     d37:	83 c4 10             	add    $0x10,%esp
}
     d3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5d                   	pop    %ebp
     d40:	c3                   	ret    
     d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "exitwait ok\n");
     d48:	83 ec 08             	sub    $0x8,%esp
     d4b:	68 3b 41 00 00       	push   $0x413b
     d50:	6a 01                	push   $0x1
     d52:	e8 99 2c 00 00       	call   39f0 <printf>
     d57:	83 c4 10             	add    $0x10,%esp
}
     d5a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d5d:	5b                   	pop    %ebx
     d5e:	5e                   	pop    %esi
     d5f:	5d                   	pop    %ebp
     d60:	c3                   	ret    
      exit();
     d61:	e8 2c 2b 00 00       	call   3892 <exit>
     d66:	8d 76 00             	lea    0x0(%esi),%esi
     d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d70 <mem>:
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	57                   	push   %edi
     d74:	56                   	push   %esi
     d75:	53                   	push   %ebx
     d76:	31 db                	xor    %ebx,%ebx
     d78:	83 ec 14             	sub    $0x14,%esp
  printf(1, "mem test\n");
     d7b:	68 48 41 00 00       	push   $0x4148
     d80:	6a 01                	push   $0x1
     d82:	e8 69 2c 00 00       	call   39f0 <printf>
  ppid = getpid();
     d87:	e8 86 2b 00 00       	call   3912 <getpid>
     d8c:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d8e:	e8 f7 2a 00 00       	call   388a <fork>
     d93:	83 c4 10             	add    $0x10,%esp
     d96:	85 c0                	test   %eax,%eax
     d98:	74 0a                	je     da4 <mem+0x34>
     d9a:	e9 89 00 00 00       	jmp    e28 <mem+0xb8>
     d9f:	90                   	nop
      *(char**)m2 = m1;
     da0:	89 18                	mov    %ebx,(%eax)
     da2:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     da4:	83 ec 0c             	sub    $0xc,%esp
     da7:	68 11 27 00 00       	push   $0x2711
     dac:	e8 9f 2e 00 00       	call   3c50 <malloc>
     db1:	83 c4 10             	add    $0x10,%esp
     db4:	85 c0                	test   %eax,%eax
     db6:	75 e8                	jne    da0 <mem+0x30>
    while(m1){
     db8:	85 db                	test   %ebx,%ebx
     dba:	74 18                	je     dd4 <mem+0x64>
     dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     dc0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     dc2:	83 ec 0c             	sub    $0xc,%esp
     dc5:	53                   	push   %ebx
     dc6:	89 fb                	mov    %edi,%ebx
     dc8:	e8 f3 2d 00 00       	call   3bc0 <free>
    while(m1){
     dcd:	83 c4 10             	add    $0x10,%esp
     dd0:	85 db                	test   %ebx,%ebx
     dd2:	75 ec                	jne    dc0 <mem+0x50>
    m1 = malloc(1024*20);
     dd4:	83 ec 0c             	sub    $0xc,%esp
     dd7:	68 00 50 00 00       	push   $0x5000
     ddc:	e8 6f 2e 00 00       	call   3c50 <malloc>
    if(m1 == 0){
     de1:	83 c4 10             	add    $0x10,%esp
     de4:	85 c0                	test   %eax,%eax
     de6:	74 20                	je     e08 <mem+0x98>
    free(m1);
     de8:	83 ec 0c             	sub    $0xc,%esp
     deb:	50                   	push   %eax
     dec:	e8 cf 2d 00 00       	call   3bc0 <free>
    printf(1, "mem ok\n");
     df1:	58                   	pop    %eax
     df2:	5a                   	pop    %edx
     df3:	68 6c 41 00 00       	push   $0x416c
     df8:	6a 01                	push   $0x1
     dfa:	e8 f1 2b 00 00       	call   39f0 <printf>
    exit();
     dff:	e8 8e 2a 00 00       	call   3892 <exit>
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     e08:	83 ec 08             	sub    $0x8,%esp
     e0b:	68 52 41 00 00       	push   $0x4152
     e10:	6a 01                	push   $0x1
     e12:	e8 d9 2b 00 00       	call   39f0 <printf>
      kill(ppid);
     e17:	89 34 24             	mov    %esi,(%esp)
     e1a:	e8 a3 2a 00 00       	call   38c2 <kill>
      exit();
     e1f:	e8 6e 2a 00 00       	call   3892 <exit>
     e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e28:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e2b:	5b                   	pop    %ebx
     e2c:	5e                   	pop    %esi
     e2d:	5f                   	pop    %edi
     e2e:	5d                   	pop    %ebp
    wait();
     e2f:	e9 66 2a 00 00       	jmp    389a <wait>
     e34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e40 <sharedfd>:
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	56                   	push   %esi
     e45:	53                   	push   %ebx
     e46:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e49:	68 74 41 00 00       	push   $0x4174
     e4e:	6a 01                	push   $0x1
     e50:	e8 9b 2b 00 00       	call   39f0 <printf>
  unlink("sharedfd");
     e55:	c7 04 24 83 41 00 00 	movl   $0x4183,(%esp)
     e5c:	e8 81 2a 00 00       	call   38e2 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e61:	59                   	pop    %ecx
     e62:	5b                   	pop    %ebx
     e63:	68 02 02 00 00       	push   $0x202
     e68:	68 83 41 00 00       	push   $0x4183
     e6d:	e8 60 2a 00 00       	call   38d2 <open>
  if(fd < 0){
     e72:	83 c4 10             	add    $0x10,%esp
     e75:	85 c0                	test   %eax,%eax
     e77:	0f 88 33 01 00 00    	js     fb0 <sharedfd+0x170>
     e7d:	89 c6                	mov    %eax,%esi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e7f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     e84:	e8 01 2a 00 00       	call   388a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e89:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     e8c:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e8e:	19 c0                	sbb    %eax,%eax
     e90:	83 ec 04             	sub    $0x4,%esp
     e93:	83 e0 f3             	and    $0xfffffff3,%eax
     e96:	6a 0a                	push   $0xa
     e98:	83 c0 70             	add    $0x70,%eax
     e9b:	50                   	push   %eax
     e9c:	8d 45 de             	lea    -0x22(%ebp),%eax
     e9f:	50                   	push   %eax
     ea0:	e8 4b 28 00 00       	call   36f0 <memset>
     ea5:	83 c4 10             	add    $0x10,%esp
     ea8:	eb 0b                	jmp    eb5 <sharedfd+0x75>
     eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     eb0:	83 eb 01             	sub    $0x1,%ebx
     eb3:	74 29                	je     ede <sharedfd+0x9e>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     eb5:	8d 45 de             	lea    -0x22(%ebp),%eax
     eb8:	83 ec 04             	sub    $0x4,%esp
     ebb:	6a 0a                	push   $0xa
     ebd:	50                   	push   %eax
     ebe:	56                   	push   %esi
     ebf:	e8 ee 29 00 00       	call   38b2 <write>
     ec4:	83 c4 10             	add    $0x10,%esp
     ec7:	83 f8 0a             	cmp    $0xa,%eax
     eca:	74 e4                	je     eb0 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     ecc:	83 ec 08             	sub    $0x8,%esp
     ecf:	68 74 4e 00 00       	push   $0x4e74
     ed4:	6a 01                	push   $0x1
     ed6:	e8 15 2b 00 00       	call   39f0 <printf>
      break;
     edb:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     ede:	85 ff                	test   %edi,%edi
     ee0:	0f 84 fe 00 00 00    	je     fe4 <sharedfd+0x1a4>
    wait();
     ee6:	e8 af 29 00 00       	call   389a <wait>
  close(fd);
     eeb:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     eee:	31 db                	xor    %ebx,%ebx
     ef0:	31 ff                	xor    %edi,%edi
  close(fd);
     ef2:	56                   	push   %esi
     ef3:	8d 75 e8             	lea    -0x18(%ebp),%esi
     ef6:	e8 bf 29 00 00       	call   38ba <close>
  fd = open("sharedfd", 0);
     efb:	58                   	pop    %eax
     efc:	5a                   	pop    %edx
     efd:	6a 00                	push   $0x0
     eff:	68 83 41 00 00       	push   $0x4183
     f04:	e8 c9 29 00 00       	call   38d2 <open>
  if(fd < 0){
     f09:	83 c4 10             	add    $0x10,%esp
     f0c:	85 c0                	test   %eax,%eax
  fd = open("sharedfd", 0);
     f0e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
     f11:	0f 88 b3 00 00 00    	js     fca <sharedfd+0x18a>
     f17:	89 f8                	mov    %edi,%eax
     f19:	89 df                	mov    %ebx,%edi
     f1b:	89 c3                	mov    %eax,%ebx
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f20:	8d 45 de             	lea    -0x22(%ebp),%eax
     f23:	83 ec 04             	sub    $0x4,%esp
     f26:	6a 0a                	push   $0xa
     f28:	50                   	push   %eax
     f29:	ff 75 d4             	pushl  -0x2c(%ebp)
     f2c:	e8 79 29 00 00       	call   38aa <read>
     f31:	83 c4 10             	add    $0x10,%esp
     f34:	85 c0                	test   %eax,%eax
     f36:	7e 28                	jle    f60 <sharedfd+0x120>
     f38:	8d 45 de             	lea    -0x22(%ebp),%eax
     f3b:	eb 15                	jmp    f52 <sharedfd+0x112>
     f3d:	8d 76 00             	lea    0x0(%esi),%esi
        np++;
     f40:	80 fa 70             	cmp    $0x70,%dl
     f43:	0f 94 c2             	sete   %dl
     f46:	0f b6 d2             	movzbl %dl,%edx
     f49:	01 d7                	add    %edx,%edi
     f4b:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < sizeof(buf); i++){
     f4e:	39 f0                	cmp    %esi,%eax
     f50:	74 ce                	je     f20 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f52:	0f b6 10             	movzbl (%eax),%edx
     f55:	80 fa 63             	cmp    $0x63,%dl
     f58:	75 e6                	jne    f40 <sharedfd+0x100>
        nc++;
     f5a:	83 c3 01             	add    $0x1,%ebx
     f5d:	eb ec                	jmp    f4b <sharedfd+0x10b>
     f5f:	90                   	nop
  close(fd);
     f60:	83 ec 0c             	sub    $0xc,%esp
     f63:	89 d8                	mov    %ebx,%eax
     f65:	ff 75 d4             	pushl  -0x2c(%ebp)
     f68:	89 fb                	mov    %edi,%ebx
     f6a:	89 c7                	mov    %eax,%edi
     f6c:	e8 49 29 00 00       	call   38ba <close>
  unlink("sharedfd");
     f71:	c7 04 24 83 41 00 00 	movl   $0x4183,(%esp)
     f78:	e8 65 29 00 00       	call   38e2 <unlink>
  if(nc == 10000 && np == 10000){
     f7d:	83 c4 10             	add    $0x10,%esp
     f80:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     f86:	75 61                	jne    fe9 <sharedfd+0x1a9>
     f88:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f8e:	75 59                	jne    fe9 <sharedfd+0x1a9>
    printf(1, "sharedfd ok\n");
     f90:	83 ec 08             	sub    $0x8,%esp
     f93:	68 8c 41 00 00       	push   $0x418c
     f98:	6a 01                	push   $0x1
     f9a:	e8 51 2a 00 00       	call   39f0 <printf>
     f9f:	83 c4 10             	add    $0x10,%esp
}
     fa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa5:	5b                   	pop    %ebx
     fa6:	5e                   	pop    %esi
     fa7:	5f                   	pop    %edi
     fa8:	5d                   	pop    %ebp
     fa9:	c3                   	ret    
     faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for writing");
     fb0:	83 ec 08             	sub    $0x8,%esp
     fb3:	68 48 4e 00 00       	push   $0x4e48
     fb8:	6a 01                	push   $0x1
     fba:	e8 31 2a 00 00       	call   39f0 <printf>
    return;
     fbf:	83 c4 10             	add    $0x10,%esp
}
     fc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fc5:	5b                   	pop    %ebx
     fc6:	5e                   	pop    %esi
     fc7:	5f                   	pop    %edi
     fc8:	5d                   	pop    %ebp
     fc9:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     fca:	83 ec 08             	sub    $0x8,%esp
     fcd:	68 94 4e 00 00       	push   $0x4e94
     fd2:	6a 01                	push   $0x1
     fd4:	e8 17 2a 00 00       	call   39f0 <printf>
    return;
     fd9:	83 c4 10             	add    $0x10,%esp
}
     fdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fdf:	5b                   	pop    %ebx
     fe0:	5e                   	pop    %esi
     fe1:	5f                   	pop    %edi
     fe2:	5d                   	pop    %ebp
     fe3:	c3                   	ret    
    exit();
     fe4:	e8 a9 28 00 00       	call   3892 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
     fe9:	53                   	push   %ebx
     fea:	57                   	push   %edi
     feb:	68 99 41 00 00       	push   $0x4199
     ff0:	6a 01                	push   $0x1
     ff2:	e8 f9 29 00 00       	call   39f0 <printf>
    exit();
     ff7:	e8 96 28 00 00       	call   3892 <exit>
     ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001000 <fourfiles>:
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	57                   	push   %edi
    1004:	56                   	push   %esi
    1005:	53                   	push   %ebx
  printf(1, "fourfiles test\n");
    1006:	be ae 41 00 00       	mov    $0x41ae,%esi
  for(pi = 0; pi < 4; pi++){
    100b:	31 db                	xor    %ebx,%ebx
{
    100d:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
    1010:	c7 45 d8 ae 41 00 00 	movl   $0x41ae,-0x28(%ebp)
    1017:	c7 45 dc f7 42 00 00 	movl   $0x42f7,-0x24(%ebp)
  printf(1, "fourfiles test\n");
    101e:	68 b4 41 00 00       	push   $0x41b4
    1023:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    1025:	c7 45 e0 fb 42 00 00 	movl   $0x42fb,-0x20(%ebp)
    102c:	c7 45 e4 b1 41 00 00 	movl   $0x41b1,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1033:	e8 b8 29 00 00       	call   39f0 <printf>
    1038:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    103b:	83 ec 0c             	sub    $0xc,%esp
    103e:	56                   	push   %esi
    103f:	e8 9e 28 00 00       	call   38e2 <unlink>
    pid = fork();
    1044:	e8 41 28 00 00       	call   388a <fork>
    if(pid < 0){
    1049:	83 c4 10             	add    $0x10,%esp
    104c:	85 c0                	test   %eax,%eax
    104e:	0f 88 68 01 00 00    	js     11bc <fourfiles+0x1bc>
    if(pid == 0){
    1054:	0f 84 df 00 00 00    	je     1139 <fourfiles+0x139>
  for(pi = 0; pi < 4; pi++){
    105a:	83 c3 01             	add    $0x1,%ebx
    105d:	83 fb 04             	cmp    $0x4,%ebx
    1060:	74 06                	je     1068 <fourfiles+0x68>
    1062:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1066:	eb d3                	jmp    103b <fourfiles+0x3b>
    wait();
    1068:	e8 2d 28 00 00       	call   389a <wait>
  for(i = 0; i < 2; i++){
    106d:	31 ff                	xor    %edi,%edi
    wait();
    106f:	e8 26 28 00 00       	call   389a <wait>
    1074:	e8 21 28 00 00       	call   389a <wait>
    1079:	e8 1c 28 00 00       	call   389a <wait>
    107e:	c7 45 d0 ae 41 00 00 	movl   $0x41ae,-0x30(%ebp)
    fd = open(fname, 0);
    1085:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    1088:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    108a:	6a 00                	push   $0x0
    108c:	ff 75 d0             	pushl  -0x30(%ebp)
    108f:	e8 3e 28 00 00       	call   38d2 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1094:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    1097:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    109a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10a0:	83 ec 04             	sub    $0x4,%esp
    10a3:	68 00 20 00 00       	push   $0x2000
    10a8:	68 e0 85 00 00       	push   $0x85e0
    10ad:	ff 75 d4             	pushl  -0x2c(%ebp)
    10b0:	e8 f5 27 00 00       	call   38aa <read>
    10b5:	83 c4 10             	add    $0x10,%esp
    10b8:	85 c0                	test   %eax,%eax
    10ba:	7e 26                	jle    10e2 <fourfiles+0xe2>
      for(j = 0; j < n; j++){
    10bc:	31 d2                	xor    %edx,%edx
    10be:	66 90                	xchg   %ax,%ax
        if(buf[j] != '0'+i){
    10c0:	0f be b2 e0 85 00 00 	movsbl 0x85e0(%edx),%esi
    10c7:	83 ff 01             	cmp    $0x1,%edi
    10ca:	19 c9                	sbb    %ecx,%ecx
    10cc:	83 c1 31             	add    $0x31,%ecx
    10cf:	39 ce                	cmp    %ecx,%esi
    10d1:	0f 85 be 00 00 00    	jne    1195 <fourfiles+0x195>
      for(j = 0; j < n; j++){
    10d7:	83 c2 01             	add    $0x1,%edx
    10da:	39 d0                	cmp    %edx,%eax
    10dc:	75 e2                	jne    10c0 <fourfiles+0xc0>
      total += n;
    10de:	01 c3                	add    %eax,%ebx
    10e0:	eb be                	jmp    10a0 <fourfiles+0xa0>
    close(fd);
    10e2:	83 ec 0c             	sub    $0xc,%esp
    10e5:	ff 75 d4             	pushl  -0x2c(%ebp)
    10e8:	e8 cd 27 00 00       	call   38ba <close>
    if(total != 12*500){
    10ed:	83 c4 10             	add    $0x10,%esp
    10f0:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    10f6:	0f 85 d3 00 00 00    	jne    11cf <fourfiles+0x1cf>
    unlink(fname);
    10fc:	83 ec 0c             	sub    $0xc,%esp
    10ff:	ff 75 d0             	pushl  -0x30(%ebp)
    1102:	e8 db 27 00 00       	call   38e2 <unlink>
  for(i = 0; i < 2; i++){
    1107:	83 c4 10             	add    $0x10,%esp
    110a:	83 ff 01             	cmp    $0x1,%edi
    110d:	75 1a                	jne    1129 <fourfiles+0x129>
  printf(1, "fourfiles ok\n");
    110f:	83 ec 08             	sub    $0x8,%esp
    1112:	68 f2 41 00 00       	push   $0x41f2
    1117:	6a 01                	push   $0x1
    1119:	e8 d2 28 00 00       	call   39f0 <printf>
}
    111e:	83 c4 10             	add    $0x10,%esp
    1121:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1124:	5b                   	pop    %ebx
    1125:	5e                   	pop    %esi
    1126:	5f                   	pop    %edi
    1127:	5d                   	pop    %ebp
    1128:	c3                   	ret    
    1129:	8b 45 dc             	mov    -0x24(%ebp),%eax
    112c:	bf 01 00 00 00       	mov    $0x1,%edi
    1131:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1134:	e9 4c ff ff ff       	jmp    1085 <fourfiles+0x85>
      fd = open(fname, O_CREATE | O_RDWR);
    1139:	83 ec 08             	sub    $0x8,%esp
    113c:	68 02 02 00 00       	push   $0x202
    1141:	56                   	push   %esi
    1142:	e8 8b 27 00 00       	call   38d2 <open>
      if(fd < 0){
    1147:	83 c4 10             	add    $0x10,%esp
    114a:	85 c0                	test   %eax,%eax
      fd = open(fname, O_CREATE | O_RDWR);
    114c:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    114e:	78 59                	js     11a9 <fourfiles+0x1a9>
      memset(buf, '0'+pi, 512);
    1150:	83 ec 04             	sub    $0x4,%esp
    1153:	83 c3 30             	add    $0x30,%ebx
    1156:	68 00 02 00 00       	push   $0x200
    115b:	53                   	push   %ebx
    115c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1161:	68 e0 85 00 00       	push   $0x85e0
    1166:	e8 85 25 00 00       	call   36f0 <memset>
    116b:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    116e:	83 ec 04             	sub    $0x4,%esp
    1171:	68 f4 01 00 00       	push   $0x1f4
    1176:	68 e0 85 00 00       	push   $0x85e0
    117b:	56                   	push   %esi
    117c:	e8 31 27 00 00       	call   38b2 <write>
    1181:	83 c4 10             	add    $0x10,%esp
    1184:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1189:	75 57                	jne    11e2 <fourfiles+0x1e2>
      for(i = 0; i < 12; i++){
    118b:	83 eb 01             	sub    $0x1,%ebx
    118e:	75 de                	jne    116e <fourfiles+0x16e>
      exit();
    1190:	e8 fd 26 00 00       	call   3892 <exit>
          printf(1, "wrong char\n");
    1195:	83 ec 08             	sub    $0x8,%esp
    1198:	68 d5 41 00 00       	push   $0x41d5
    119d:	6a 01                	push   $0x1
    119f:	e8 4c 28 00 00       	call   39f0 <printf>
          exit();
    11a4:	e8 e9 26 00 00       	call   3892 <exit>
        printf(1, "create failed\n");
    11a9:	51                   	push   %ecx
    11aa:	51                   	push   %ecx
    11ab:	68 4f 44 00 00       	push   $0x444f
    11b0:	6a 01                	push   $0x1
    11b2:	e8 39 28 00 00       	call   39f0 <printf>
        exit();
    11b7:	e8 d6 26 00 00       	call   3892 <exit>
      printf(1, "fork failed\n");
    11bc:	53                   	push   %ebx
    11bd:	53                   	push   %ebx
    11be:	68 89 4c 00 00       	push   $0x4c89
    11c3:	6a 01                	push   $0x1
    11c5:	e8 26 28 00 00       	call   39f0 <printf>
      exit();
    11ca:	e8 c3 26 00 00       	call   3892 <exit>
      printf(1, "wrong length %d\n", total);
    11cf:	50                   	push   %eax
    11d0:	53                   	push   %ebx
    11d1:	68 e1 41 00 00       	push   $0x41e1
    11d6:	6a 01                	push   $0x1
    11d8:	e8 13 28 00 00       	call   39f0 <printf>
      exit();
    11dd:	e8 b0 26 00 00       	call   3892 <exit>
          printf(1, "write failed %d\n", n);
    11e2:	52                   	push   %edx
    11e3:	50                   	push   %eax
    11e4:	68 c4 41 00 00       	push   $0x41c4
    11e9:	6a 01                	push   $0x1
    11eb:	e8 00 28 00 00       	call   39f0 <printf>
          exit();
    11f0:	e8 9d 26 00 00       	call   3892 <exit>
    11f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <createdelete>:
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	57                   	push   %edi
    1204:	56                   	push   %esi
    1205:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    1206:	31 db                	xor    %ebx,%ebx
{
    1208:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    120b:	68 00 42 00 00       	push   $0x4200
    1210:	6a 01                	push   $0x1
    1212:	e8 d9 27 00 00       	call   39f0 <printf>
    1217:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    121a:	e8 6b 26 00 00       	call   388a <fork>
    if(pid < 0){
    121f:	85 c0                	test   %eax,%eax
    1221:	0f 88 be 01 00 00    	js     13e5 <createdelete+0x1e5>
    if(pid == 0){
    1227:	0f 84 0b 01 00 00    	je     1338 <createdelete+0x138>
  for(pi = 0; pi < 4; pi++){
    122d:	83 c3 01             	add    $0x1,%ebx
    1230:	83 fb 04             	cmp    $0x4,%ebx
    1233:	75 e5                	jne    121a <createdelete+0x1a>
    1235:	8d 7d c8             	lea    -0x38(%ebp),%edi
  name[0] = name[1] = name[2] = 0;
    1238:	be ff ff ff ff       	mov    $0xffffffff,%esi
    wait();
    123d:	e8 58 26 00 00       	call   389a <wait>
    1242:	e8 53 26 00 00       	call   389a <wait>
    1247:	e8 4e 26 00 00       	call   389a <wait>
    124c:	e8 49 26 00 00       	call   389a <wait>
  name[0] = name[1] = name[2] = 0;
    1251:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1255:	8d 76 00             	lea    0x0(%esi),%esi
    1258:	8d 46 31             	lea    0x31(%esi),%eax
    125b:	88 45 c7             	mov    %al,-0x39(%ebp)
    125e:	8d 46 01             	lea    0x1(%esi),%eax
    1261:	83 f8 09             	cmp    $0x9,%eax
    1264:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1267:	0f 9f c3             	setg   %bl
    126a:	85 c0                	test   %eax,%eax
    126c:	0f 94 c0             	sete   %al
    126f:	09 c3                	or     %eax,%ebx
    1271:	88 5d c6             	mov    %bl,-0x3a(%ebp)
      name[2] = '\0';
    1274:	bb 70 00 00 00       	mov    $0x70,%ebx
      name[1] = '0' + i;
    1279:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    127d:	83 ec 08             	sub    $0x8,%esp
      name[0] = 'p' + pi;
    1280:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    1283:	6a 00                	push   $0x0
    1285:	57                   	push   %edi
      name[1] = '0' + i;
    1286:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1289:	e8 44 26 00 00       	call   38d2 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    128e:	83 c4 10             	add    $0x10,%esp
    1291:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1295:	0f 84 85 00 00 00    	je     1320 <createdelete+0x120>
    129b:	85 c0                	test   %eax,%eax
    129d:	0f 88 1a 01 00 00    	js     13bd <createdelete+0x1bd>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12a3:	83 fe 08             	cmp    $0x8,%esi
    12a6:	0f 86 54 01 00 00    	jbe    1400 <createdelete+0x200>
        close(fd);
    12ac:	83 ec 0c             	sub    $0xc,%esp
    12af:	50                   	push   %eax
    12b0:	e8 05 26 00 00       	call   38ba <close>
    12b5:	83 c4 10             	add    $0x10,%esp
    12b8:	83 c3 01             	add    $0x1,%ebx
    for(pi = 0; pi < 4; pi++){
    12bb:	80 fb 74             	cmp    $0x74,%bl
    12be:	75 b9                	jne    1279 <createdelete+0x79>
    12c0:	8b 75 c0             	mov    -0x40(%ebp),%esi
  for(i = 0; i < N; i++){
    12c3:	83 fe 13             	cmp    $0x13,%esi
    12c6:	75 90                	jne    1258 <createdelete+0x58>
    12c8:	be 70 00 00 00       	mov    $0x70,%esi
    12cd:	8d 76 00             	lea    0x0(%esi),%esi
    12d0:	8d 46 c0             	lea    -0x40(%esi),%eax
  name[0] = name[1] = name[2] = 0;
    12d3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12d8:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    12db:	89 f0                	mov    %esi,%eax
      unlink(name);
    12dd:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    12e0:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    12e3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    12e7:	57                   	push   %edi
      name[1] = '0' + i;
    12e8:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    12eb:	e8 f2 25 00 00       	call   38e2 <unlink>
    for(pi = 0; pi < 4; pi++){
    12f0:	83 c4 10             	add    $0x10,%esp
    12f3:	83 eb 01             	sub    $0x1,%ebx
    12f6:	75 e3                	jne    12db <createdelete+0xdb>
    12f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; i < N; i++){
    12fb:	89 f0                	mov    %esi,%eax
    12fd:	3c 84                	cmp    $0x84,%al
    12ff:	75 cf                	jne    12d0 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    1301:	83 ec 08             	sub    $0x8,%esp
    1304:	68 13 42 00 00       	push   $0x4213
    1309:	6a 01                	push   $0x1
    130b:	e8 e0 26 00 00       	call   39f0 <printf>
}
    1310:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1313:	5b                   	pop    %ebx
    1314:	5e                   	pop    %esi
    1315:	5f                   	pop    %edi
    1316:	5d                   	pop    %ebp
    1317:	c3                   	ret    
    1318:	90                   	nop
    1319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1320:	83 fe 08             	cmp    $0x8,%esi
    1323:	0f 86 cf 00 00 00    	jbe    13f8 <createdelete+0x1f8>
      if(fd >= 0)
    1329:	85 c0                	test   %eax,%eax
    132b:	78 8b                	js     12b8 <createdelete+0xb8>
    132d:	e9 7a ff ff ff       	jmp    12ac <createdelete+0xac>
    1332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    1338:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    133b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    133f:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    1342:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1345:	31 db                	xor    %ebx,%ebx
    1347:	eb 0f                	jmp    1358 <createdelete+0x158>
    1349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1350:	83 fb 13             	cmp    $0x13,%ebx
    1353:	74 63                	je     13b8 <createdelete+0x1b8>
    1355:	83 c3 01             	add    $0x1,%ebx
        fd = open(name, O_CREATE | O_RDWR);
    1358:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    135b:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    135e:	68 02 02 00 00       	push   $0x202
    1363:	57                   	push   %edi
        name[1] = '0' + i;
    1364:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1367:	e8 66 25 00 00       	call   38d2 <open>
        if(fd < 0){
    136c:	83 c4 10             	add    $0x10,%esp
    136f:	85 c0                	test   %eax,%eax
    1371:	78 5f                	js     13d2 <createdelete+0x1d2>
        close(fd);
    1373:	83 ec 0c             	sub    $0xc,%esp
    1376:	50                   	push   %eax
    1377:	e8 3e 25 00 00       	call   38ba <close>
        if(i > 0 && (i % 2 ) == 0){
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	85 db                	test   %ebx,%ebx
    1381:	74 d2                	je     1355 <createdelete+0x155>
    1383:	f6 c3 01             	test   $0x1,%bl
    1386:	75 c8                	jne    1350 <createdelete+0x150>
          if(unlink(name) < 0){
    1388:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    138b:	89 d8                	mov    %ebx,%eax
    138d:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    138f:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    1390:	83 c0 30             	add    $0x30,%eax
    1393:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1396:	e8 47 25 00 00       	call   38e2 <unlink>
    139b:	83 c4 10             	add    $0x10,%esp
    139e:	85 c0                	test   %eax,%eax
    13a0:	79 ae                	jns    1350 <createdelete+0x150>
            printf(1, "unlink failed\n");
    13a2:	52                   	push   %edx
    13a3:	52                   	push   %edx
    13a4:	68 01 3e 00 00       	push   $0x3e01
    13a9:	6a 01                	push   $0x1
    13ab:	e8 40 26 00 00       	call   39f0 <printf>
            exit();
    13b0:	e8 dd 24 00 00       	call   3892 <exit>
    13b5:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    13b8:	e8 d5 24 00 00       	call   3892 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    13bd:	83 ec 04             	sub    $0x4,%esp
    13c0:	57                   	push   %edi
    13c1:	68 c0 4e 00 00       	push   $0x4ec0
    13c6:	6a 01                	push   $0x1
    13c8:	e8 23 26 00 00       	call   39f0 <printf>
        exit();
    13cd:	e8 c0 24 00 00       	call   3892 <exit>
          printf(1, "create failed\n");
    13d2:	51                   	push   %ecx
    13d3:	51                   	push   %ecx
    13d4:	68 4f 44 00 00       	push   $0x444f
    13d9:	6a 01                	push   $0x1
    13db:	e8 10 26 00 00       	call   39f0 <printf>
          exit();
    13e0:	e8 ad 24 00 00       	call   3892 <exit>
      printf(1, "fork failed\n");
    13e5:	53                   	push   %ebx
    13e6:	53                   	push   %ebx
    13e7:	68 89 4c 00 00       	push   $0x4c89
    13ec:	6a 01                	push   $0x1
    13ee:	e8 fd 25 00 00       	call   39f0 <printf>
      exit();
    13f3:	e8 9a 24 00 00       	call   3892 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    13f8:	85 c0                	test   %eax,%eax
    13fa:	0f 88 b8 fe ff ff    	js     12b8 <createdelete+0xb8>
        printf(1, "oops createdelete %s did exist\n", name);
    1400:	50                   	push   %eax
    1401:	57                   	push   %edi
    1402:	68 e4 4e 00 00       	push   $0x4ee4
    1407:	6a 01                	push   $0x1
    1409:	e8 e2 25 00 00       	call   39f0 <printf>
        exit();
    140e:	e8 7f 24 00 00       	call   3892 <exit>
    1413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001420 <unlinkread>:
{
    1420:	55                   	push   %ebp
    1421:	89 e5                	mov    %esp,%ebp
    1423:	56                   	push   %esi
    1424:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1425:	83 ec 08             	sub    $0x8,%esp
    1428:	68 24 42 00 00       	push   $0x4224
    142d:	6a 01                	push   $0x1
    142f:	e8 bc 25 00 00       	call   39f0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1434:	5b                   	pop    %ebx
    1435:	5e                   	pop    %esi
    1436:	68 02 02 00 00       	push   $0x202
    143b:	68 35 42 00 00       	push   $0x4235
    1440:	e8 8d 24 00 00       	call   38d2 <open>
  if(fd < 0){
    1445:	83 c4 10             	add    $0x10,%esp
    1448:	85 c0                	test   %eax,%eax
    144a:	0f 88 e6 00 00 00    	js     1536 <unlinkread+0x116>
  write(fd, "hello", 5);
    1450:	83 ec 04             	sub    $0x4,%esp
    1453:	89 c3                	mov    %eax,%ebx
    1455:	6a 05                	push   $0x5
    1457:	68 5a 42 00 00       	push   $0x425a
    145c:	50                   	push   %eax
    145d:	e8 50 24 00 00       	call   38b2 <write>
  close(fd);
    1462:	89 1c 24             	mov    %ebx,(%esp)
    1465:	e8 50 24 00 00       	call   38ba <close>
  fd = open("unlinkread", O_RDWR);
    146a:	58                   	pop    %eax
    146b:	5a                   	pop    %edx
    146c:	6a 02                	push   $0x2
    146e:	68 35 42 00 00       	push   $0x4235
    1473:	e8 5a 24 00 00       	call   38d2 <open>
  if(fd < 0){
    1478:	83 c4 10             	add    $0x10,%esp
    147b:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    147d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    147f:	0f 88 10 01 00 00    	js     1595 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    1485:	83 ec 0c             	sub    $0xc,%esp
    1488:	68 35 42 00 00       	push   $0x4235
    148d:	e8 50 24 00 00       	call   38e2 <unlink>
    1492:	83 c4 10             	add    $0x10,%esp
    1495:	85 c0                	test   %eax,%eax
    1497:	0f 85 e5 00 00 00    	jne    1582 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    149d:	83 ec 08             	sub    $0x8,%esp
    14a0:	68 02 02 00 00       	push   $0x202
    14a5:	68 35 42 00 00       	push   $0x4235
    14aa:	e8 23 24 00 00       	call   38d2 <open>
  write(fd1, "yyy", 3);
    14af:	83 c4 0c             	add    $0xc,%esp
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14b2:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14b4:	6a 03                	push   $0x3
    14b6:	68 92 42 00 00       	push   $0x4292
    14bb:	50                   	push   %eax
    14bc:	e8 f1 23 00 00       	call   38b2 <write>
  close(fd1);
    14c1:	89 34 24             	mov    %esi,(%esp)
    14c4:	e8 f1 23 00 00       	call   38ba <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14c9:	83 c4 0c             	add    $0xc,%esp
    14cc:	68 00 20 00 00       	push   $0x2000
    14d1:	68 e0 85 00 00       	push   $0x85e0
    14d6:	53                   	push   %ebx
    14d7:	e8 ce 23 00 00       	call   38aa <read>
    14dc:	83 c4 10             	add    $0x10,%esp
    14df:	83 f8 05             	cmp    $0x5,%eax
    14e2:	0f 85 87 00 00 00    	jne    156f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    14e8:	80 3d e0 85 00 00 68 	cmpb   $0x68,0x85e0
    14ef:	75 6b                	jne    155c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    14f1:	83 ec 04             	sub    $0x4,%esp
    14f4:	6a 0a                	push   $0xa
    14f6:	68 e0 85 00 00       	push   $0x85e0
    14fb:	53                   	push   %ebx
    14fc:	e8 b1 23 00 00       	call   38b2 <write>
    1501:	83 c4 10             	add    $0x10,%esp
    1504:	83 f8 0a             	cmp    $0xa,%eax
    1507:	75 40                	jne    1549 <unlinkread+0x129>
  close(fd);
    1509:	83 ec 0c             	sub    $0xc,%esp
    150c:	53                   	push   %ebx
    150d:	e8 a8 23 00 00       	call   38ba <close>
  unlink("unlinkread");
    1512:	c7 04 24 35 42 00 00 	movl   $0x4235,(%esp)
    1519:	e8 c4 23 00 00       	call   38e2 <unlink>
  printf(1, "unlinkread ok\n");
    151e:	58                   	pop    %eax
    151f:	5a                   	pop    %edx
    1520:	68 dd 42 00 00       	push   $0x42dd
    1525:	6a 01                	push   $0x1
    1527:	e8 c4 24 00 00       	call   39f0 <printf>
}
    152c:	83 c4 10             	add    $0x10,%esp
    152f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1532:	5b                   	pop    %ebx
    1533:	5e                   	pop    %esi
    1534:	5d                   	pop    %ebp
    1535:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1536:	51                   	push   %ecx
    1537:	51                   	push   %ecx
    1538:	68 40 42 00 00       	push   $0x4240
    153d:	6a 01                	push   $0x1
    153f:	e8 ac 24 00 00       	call   39f0 <printf>
    exit();
    1544:	e8 49 23 00 00       	call   3892 <exit>
    printf(1, "unlinkread write failed\n");
    1549:	51                   	push   %ecx
    154a:	51                   	push   %ecx
    154b:	68 c4 42 00 00       	push   $0x42c4
    1550:	6a 01                	push   $0x1
    1552:	e8 99 24 00 00       	call   39f0 <printf>
    exit();
    1557:	e8 36 23 00 00       	call   3892 <exit>
    printf(1, "unlinkread wrong data\n");
    155c:	53                   	push   %ebx
    155d:	53                   	push   %ebx
    155e:	68 ad 42 00 00       	push   $0x42ad
    1563:	6a 01                	push   $0x1
    1565:	e8 86 24 00 00       	call   39f0 <printf>
    exit();
    156a:	e8 23 23 00 00       	call   3892 <exit>
    printf(1, "unlinkread read failed");
    156f:	56                   	push   %esi
    1570:	56                   	push   %esi
    1571:	68 96 42 00 00       	push   $0x4296
    1576:	6a 01                	push   $0x1
    1578:	e8 73 24 00 00       	call   39f0 <printf>
    exit();
    157d:	e8 10 23 00 00       	call   3892 <exit>
    printf(1, "unlink unlinkread failed\n");
    1582:	50                   	push   %eax
    1583:	50                   	push   %eax
    1584:	68 78 42 00 00       	push   $0x4278
    1589:	6a 01                	push   $0x1
    158b:	e8 60 24 00 00       	call   39f0 <printf>
    exit();
    1590:	e8 fd 22 00 00       	call   3892 <exit>
    printf(1, "open unlinkread failed\n");
    1595:	50                   	push   %eax
    1596:	50                   	push   %eax
    1597:	68 60 42 00 00       	push   $0x4260
    159c:	6a 01                	push   $0x1
    159e:	e8 4d 24 00 00       	call   39f0 <printf>
    exit();
    15a3:	e8 ea 22 00 00       	call   3892 <exit>
    15a8:	90                   	nop
    15a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000015b0 <linktest>:
{
    15b0:	55                   	push   %ebp
    15b1:	89 e5                	mov    %esp,%ebp
    15b3:	53                   	push   %ebx
    15b4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    15b7:	68 ec 42 00 00       	push   $0x42ec
    15bc:	6a 01                	push   $0x1
    15be:	e8 2d 24 00 00       	call   39f0 <printf>
  unlink("lf1");
    15c3:	c7 04 24 f6 42 00 00 	movl   $0x42f6,(%esp)
    15ca:	e8 13 23 00 00       	call   38e2 <unlink>
  unlink("lf2");
    15cf:	c7 04 24 fa 42 00 00 	movl   $0x42fa,(%esp)
    15d6:	e8 07 23 00 00       	call   38e2 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15db:	58                   	pop    %eax
    15dc:	5a                   	pop    %edx
    15dd:	68 02 02 00 00       	push   $0x202
    15e2:	68 f6 42 00 00       	push   $0x42f6
    15e7:	e8 e6 22 00 00       	call   38d2 <open>
  if(fd < 0){
    15ec:	83 c4 10             	add    $0x10,%esp
    15ef:	85 c0                	test   %eax,%eax
    15f1:	0f 88 1e 01 00 00    	js     1715 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    15f7:	83 ec 04             	sub    $0x4,%esp
    15fa:	89 c3                	mov    %eax,%ebx
    15fc:	6a 05                	push   $0x5
    15fe:	68 5a 42 00 00       	push   $0x425a
    1603:	50                   	push   %eax
    1604:	e8 a9 22 00 00       	call   38b2 <write>
    1609:	83 c4 10             	add    $0x10,%esp
    160c:	83 f8 05             	cmp    $0x5,%eax
    160f:	0f 85 98 01 00 00    	jne    17ad <linktest+0x1fd>
  close(fd);
    1615:	83 ec 0c             	sub    $0xc,%esp
    1618:	53                   	push   %ebx
    1619:	e8 9c 22 00 00       	call   38ba <close>
  if(link("lf1", "lf2") < 0){
    161e:	5b                   	pop    %ebx
    161f:	58                   	pop    %eax
    1620:	68 fa 42 00 00       	push   $0x42fa
    1625:	68 f6 42 00 00       	push   $0x42f6
    162a:	e8 c3 22 00 00       	call   38f2 <link>
    162f:	83 c4 10             	add    $0x10,%esp
    1632:	85 c0                	test   %eax,%eax
    1634:	0f 88 60 01 00 00    	js     179a <linktest+0x1ea>
  unlink("lf1");
    163a:	83 ec 0c             	sub    $0xc,%esp
    163d:	68 f6 42 00 00       	push   $0x42f6
    1642:	e8 9b 22 00 00       	call   38e2 <unlink>
  if(open("lf1", 0) >= 0){
    1647:	58                   	pop    %eax
    1648:	5a                   	pop    %edx
    1649:	6a 00                	push   $0x0
    164b:	68 f6 42 00 00       	push   $0x42f6
    1650:	e8 7d 22 00 00       	call   38d2 <open>
    1655:	83 c4 10             	add    $0x10,%esp
    1658:	85 c0                	test   %eax,%eax
    165a:	0f 89 27 01 00 00    	jns    1787 <linktest+0x1d7>
  fd = open("lf2", 0);
    1660:	83 ec 08             	sub    $0x8,%esp
    1663:	6a 00                	push   $0x0
    1665:	68 fa 42 00 00       	push   $0x42fa
    166a:	e8 63 22 00 00       	call   38d2 <open>
  if(fd < 0){
    166f:	83 c4 10             	add    $0x10,%esp
    1672:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    1674:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1676:	0f 88 f8 00 00 00    	js     1774 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    167c:	83 ec 04             	sub    $0x4,%esp
    167f:	68 00 20 00 00       	push   $0x2000
    1684:	68 e0 85 00 00       	push   $0x85e0
    1689:	50                   	push   %eax
    168a:	e8 1b 22 00 00       	call   38aa <read>
    168f:	83 c4 10             	add    $0x10,%esp
    1692:	83 f8 05             	cmp    $0x5,%eax
    1695:	0f 85 c6 00 00 00    	jne    1761 <linktest+0x1b1>
  close(fd);
    169b:	83 ec 0c             	sub    $0xc,%esp
    169e:	53                   	push   %ebx
    169f:	e8 16 22 00 00       	call   38ba <close>
  if(link("lf2", "lf2") >= 0){
    16a4:	58                   	pop    %eax
    16a5:	5a                   	pop    %edx
    16a6:	68 fa 42 00 00       	push   $0x42fa
    16ab:	68 fa 42 00 00       	push   $0x42fa
    16b0:	e8 3d 22 00 00       	call   38f2 <link>
    16b5:	83 c4 10             	add    $0x10,%esp
    16b8:	85 c0                	test   %eax,%eax
    16ba:	0f 89 8e 00 00 00    	jns    174e <linktest+0x19e>
  unlink("lf2");
    16c0:	83 ec 0c             	sub    $0xc,%esp
    16c3:	68 fa 42 00 00       	push   $0x42fa
    16c8:	e8 15 22 00 00       	call   38e2 <unlink>
  if(link("lf2", "lf1") >= 0){
    16cd:	59                   	pop    %ecx
    16ce:	5b                   	pop    %ebx
    16cf:	68 f6 42 00 00       	push   $0x42f6
    16d4:	68 fa 42 00 00       	push   $0x42fa
    16d9:	e8 14 22 00 00       	call   38f2 <link>
    16de:	83 c4 10             	add    $0x10,%esp
    16e1:	85 c0                	test   %eax,%eax
    16e3:	79 56                	jns    173b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    16e5:	83 ec 08             	sub    $0x8,%esp
    16e8:	68 f6 42 00 00       	push   $0x42f6
    16ed:	68 be 45 00 00       	push   $0x45be
    16f2:	e8 fb 21 00 00       	call   38f2 <link>
    16f7:	83 c4 10             	add    $0x10,%esp
    16fa:	85 c0                	test   %eax,%eax
    16fc:	79 2a                	jns    1728 <linktest+0x178>
  printf(1, "linktest ok\n");
    16fe:	83 ec 08             	sub    $0x8,%esp
    1701:	68 94 43 00 00       	push   $0x4394
    1706:	6a 01                	push   $0x1
    1708:	e8 e3 22 00 00       	call   39f0 <printf>
}
    170d:	83 c4 10             	add    $0x10,%esp
    1710:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1713:	c9                   	leave  
    1714:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    1715:	50                   	push   %eax
    1716:	50                   	push   %eax
    1717:	68 fe 42 00 00       	push   $0x42fe
    171c:	6a 01                	push   $0x1
    171e:	e8 cd 22 00 00       	call   39f0 <printf>
    exit();
    1723:	e8 6a 21 00 00       	call   3892 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1728:	50                   	push   %eax
    1729:	50                   	push   %eax
    172a:	68 78 43 00 00       	push   $0x4378
    172f:	6a 01                	push   $0x1
    1731:	e8 ba 22 00 00       	call   39f0 <printf>
    exit();
    1736:	e8 57 21 00 00       	call   3892 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    173b:	52                   	push   %edx
    173c:	52                   	push   %edx
    173d:	68 2c 4f 00 00       	push   $0x4f2c
    1742:	6a 01                	push   $0x1
    1744:	e8 a7 22 00 00       	call   39f0 <printf>
    exit();
    1749:	e8 44 21 00 00       	call   3892 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    174e:	50                   	push   %eax
    174f:	50                   	push   %eax
    1750:	68 5a 43 00 00       	push   $0x435a
    1755:	6a 01                	push   $0x1
    1757:	e8 94 22 00 00       	call   39f0 <printf>
    exit();
    175c:	e8 31 21 00 00       	call   3892 <exit>
    printf(1, "read lf2 failed\n");
    1761:	51                   	push   %ecx
    1762:	51                   	push   %ecx
    1763:	68 49 43 00 00       	push   $0x4349
    1768:	6a 01                	push   $0x1
    176a:	e8 81 22 00 00       	call   39f0 <printf>
    exit();
    176f:	e8 1e 21 00 00       	call   3892 <exit>
    printf(1, "open lf2 failed\n");
    1774:	53                   	push   %ebx
    1775:	53                   	push   %ebx
    1776:	68 38 43 00 00       	push   $0x4338
    177b:	6a 01                	push   $0x1
    177d:	e8 6e 22 00 00       	call   39f0 <printf>
    exit();
    1782:	e8 0b 21 00 00       	call   3892 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1787:	50                   	push   %eax
    1788:	50                   	push   %eax
    1789:	68 04 4f 00 00       	push   $0x4f04
    178e:	6a 01                	push   $0x1
    1790:	e8 5b 22 00 00       	call   39f0 <printf>
    exit();
    1795:	e8 f8 20 00 00       	call   3892 <exit>
    printf(1, "link lf1 lf2 failed\n");
    179a:	51                   	push   %ecx
    179b:	51                   	push   %ecx
    179c:	68 23 43 00 00       	push   $0x4323
    17a1:	6a 01                	push   $0x1
    17a3:	e8 48 22 00 00       	call   39f0 <printf>
    exit();
    17a8:	e8 e5 20 00 00       	call   3892 <exit>
    printf(1, "write lf1 failed\n");
    17ad:	50                   	push   %eax
    17ae:	50                   	push   %eax
    17af:	68 11 43 00 00       	push   $0x4311
    17b4:	6a 01                	push   $0x1
    17b6:	e8 35 22 00 00       	call   39f0 <printf>
    exit();
    17bb:	e8 d2 20 00 00       	call   3892 <exit>

000017c0 <concreate>:
{
    17c0:	55                   	push   %ebp
    17c1:	89 e5                	mov    %esp,%ebp
    17c3:	57                   	push   %edi
    17c4:	56                   	push   %esi
    17c5:	53                   	push   %ebx
  for(i = 0; i < 40; i++){
    17c6:	31 f6                	xor    %esi,%esi
    17c8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    if(pid && (i % 3) == 1){
    17cb:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
{
    17d0:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17d3:	68 a1 43 00 00       	push   $0x43a1
    17d8:	6a 01                	push   $0x1
    17da:	e8 11 22 00 00       	call   39f0 <printf>
  file[0] = 'C';
    17df:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17e3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17e7:	83 c4 10             	add    $0x10,%esp
    17ea:	eb 4c                	jmp    1838 <concreate+0x78>
    17ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid && (i % 3) == 1){
    17f0:	89 f0                	mov    %esi,%eax
    17f2:	89 f1                	mov    %esi,%ecx
    17f4:	f7 e7                	mul    %edi
    17f6:	d1 ea                	shr    %edx
    17f8:	8d 04 52             	lea    (%edx,%edx,2),%eax
    17fb:	29 c1                	sub    %eax,%ecx
    17fd:	83 f9 01             	cmp    $0x1,%ecx
    1800:	0f 84 ba 00 00 00    	je     18c0 <concreate+0x100>
      fd = open(file, O_CREATE | O_RDWR);
    1806:	83 ec 08             	sub    $0x8,%esp
    1809:	68 02 02 00 00       	push   $0x202
    180e:	53                   	push   %ebx
    180f:	e8 be 20 00 00       	call   38d2 <open>
      if(fd < 0){
    1814:	83 c4 10             	add    $0x10,%esp
    1817:	85 c0                	test   %eax,%eax
    1819:	78 67                	js     1882 <concreate+0xc2>
      close(fd);
    181b:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    181e:	83 c6 01             	add    $0x1,%esi
      close(fd);
    1821:	50                   	push   %eax
    1822:	e8 93 20 00 00       	call   38ba <close>
    1827:	83 c4 10             	add    $0x10,%esp
      wait();
    182a:	e8 6b 20 00 00       	call   389a <wait>
  for(i = 0; i < 40; i++){
    182f:	83 fe 28             	cmp    $0x28,%esi
    1832:	0f 84 aa 00 00 00    	je     18e2 <concreate+0x122>
    unlink(file);
    1838:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    183b:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    183e:	53                   	push   %ebx
    file[1] = '0' + i;
    183f:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1842:	e8 9b 20 00 00       	call   38e2 <unlink>
    pid = fork();
    1847:	e8 3e 20 00 00       	call   388a <fork>
    if(pid && (i % 3) == 1){
    184c:	83 c4 10             	add    $0x10,%esp
    184f:	85 c0                	test   %eax,%eax
    1851:	75 9d                	jne    17f0 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1853:	89 f0                	mov    %esi,%eax
    1855:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    185a:	f7 e2                	mul    %edx
    185c:	c1 ea 02             	shr    $0x2,%edx
    185f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1862:	29 c6                	sub    %eax,%esi
    1864:	83 fe 01             	cmp    $0x1,%esi
    1867:	74 37                	je     18a0 <concreate+0xe0>
      fd = open(file, O_CREATE | O_RDWR);
    1869:	83 ec 08             	sub    $0x8,%esp
    186c:	68 02 02 00 00       	push   $0x202
    1871:	53                   	push   %ebx
    1872:	e8 5b 20 00 00       	call   38d2 <open>
      if(fd < 0){
    1877:	83 c4 10             	add    $0x10,%esp
    187a:	85 c0                	test   %eax,%eax
    187c:	0f 89 28 02 00 00    	jns    1aaa <concreate+0x2ea>
        printf(1, "concreate create %s failed\n", file);
    1882:	83 ec 04             	sub    $0x4,%esp
    1885:	53                   	push   %ebx
    1886:	68 b4 43 00 00       	push   $0x43b4
    188b:	6a 01                	push   $0x1
    188d:	e8 5e 21 00 00       	call   39f0 <printf>
        exit();
    1892:	e8 fb 1f 00 00       	call   3892 <exit>
    1897:	89 f6                	mov    %esi,%esi
    1899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18a0:	83 ec 08             	sub    $0x8,%esp
    18a3:	53                   	push   %ebx
    18a4:	68 b1 43 00 00       	push   $0x43b1
    18a9:	e8 44 20 00 00       	call   38f2 <link>
    18ae:	83 c4 10             	add    $0x10,%esp
      exit();
    18b1:	e8 dc 1f 00 00       	call   3892 <exit>
    18b6:	8d 76 00             	lea    0x0(%esi),%esi
    18b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18c0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18c3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18c6:	53                   	push   %ebx
    18c7:	68 b1 43 00 00       	push   $0x43b1
    18cc:	e8 21 20 00 00       	call   38f2 <link>
    18d1:	83 c4 10             	add    $0x10,%esp
      wait();
    18d4:	e8 c1 1f 00 00       	call   389a <wait>
  for(i = 0; i < 40; i++){
    18d9:	83 fe 28             	cmp    $0x28,%esi
    18dc:	0f 85 56 ff ff ff    	jne    1838 <concreate+0x78>
  memset(fa, 0, sizeof(fa));
    18e2:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18e5:	83 ec 04             	sub    $0x4,%esp
    18e8:	6a 28                	push   $0x28
    18ea:	6a 00                	push   $0x0
    18ec:	50                   	push   %eax
    18ed:	e8 fe 1d 00 00       	call   36f0 <memset>
  fd = open(".", 0);
    18f2:	5f                   	pop    %edi
    18f3:	58                   	pop    %eax
    18f4:	6a 00                	push   $0x0
    18f6:	68 be 45 00 00       	push   $0x45be
    18fb:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18fe:	e8 cf 1f 00 00       	call   38d2 <open>
  while(read(fd, &de, sizeof(de)) > 0){
    1903:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1906:	89 c6                	mov    %eax,%esi
  n = 0;
    1908:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    190f:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1910:	83 ec 04             	sub    $0x4,%esp
    1913:	6a 10                	push   $0x10
    1915:	57                   	push   %edi
    1916:	56                   	push   %esi
    1917:	e8 8e 1f 00 00       	call   38aa <read>
    191c:	83 c4 10             	add    $0x10,%esp
    191f:	85 c0                	test   %eax,%eax
    1921:	7e 3d                	jle    1960 <concreate+0x1a0>
    if(de.inum == 0)
    1923:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1928:	74 e6                	je     1910 <concreate+0x150>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    192a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    192e:	75 e0                	jne    1910 <concreate+0x150>
    1930:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1934:	75 da                	jne    1910 <concreate+0x150>
      i = de.name[1] - '0';
    1936:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    193a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    193d:	83 f8 27             	cmp    $0x27,%eax
    1940:	0f 87 4e 01 00 00    	ja     1a94 <concreate+0x2d4>
      if(fa[i]){
    1946:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    194b:	0f 85 2d 01 00 00    	jne    1a7e <concreate+0x2be>
      fa[i] = 1;
    1951:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1956:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    195a:	eb b4                	jmp    1910 <concreate+0x150>
    195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1960:	83 ec 0c             	sub    $0xc,%esp
    1963:	56                   	push   %esi
    1964:	e8 51 1f 00 00       	call   38ba <close>
  if(n != 40){
    1969:	83 c4 10             	add    $0x10,%esp
    196c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1970:	0f 85 f5 00 00 00    	jne    1a6b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1976:	31 f6                	xor    %esi,%esi
    1978:	eb 48                	jmp    19c2 <concreate+0x202>
    197a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    1980:	85 ff                	test   %edi,%edi
    1982:	74 05                	je     1989 <concreate+0x1c9>
    1984:	83 fa 01             	cmp    $0x1,%edx
    1987:	74 64                	je     19ed <concreate+0x22d>
      unlink(file);
    1989:	83 ec 0c             	sub    $0xc,%esp
    198c:	53                   	push   %ebx
    198d:	e8 50 1f 00 00       	call   38e2 <unlink>
      unlink(file);
    1992:	89 1c 24             	mov    %ebx,(%esp)
    1995:	e8 48 1f 00 00       	call   38e2 <unlink>
      unlink(file);
    199a:	89 1c 24             	mov    %ebx,(%esp)
    199d:	e8 40 1f 00 00       	call   38e2 <unlink>
      unlink(file);
    19a2:	89 1c 24             	mov    %ebx,(%esp)
    19a5:	e8 38 1f 00 00       	call   38e2 <unlink>
    19aa:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    19ad:	85 ff                	test   %edi,%edi
    19af:	0f 84 fc fe ff ff    	je     18b1 <concreate+0xf1>
  for(i = 0; i < 40; i++){
    19b5:	83 c6 01             	add    $0x1,%esi
      wait();
    19b8:	e8 dd 1e 00 00       	call   389a <wait>
  for(i = 0; i < 40; i++){
    19bd:	83 fe 28             	cmp    $0x28,%esi
    19c0:	74 7e                	je     1a40 <concreate+0x280>
    file[1] = '0' + i;
    19c2:	8d 46 30             	lea    0x30(%esi),%eax
    19c5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19c8:	e8 bd 1e 00 00       	call   388a <fork>
    if(pid < 0){
    19cd:	85 c0                	test   %eax,%eax
    pid = fork();
    19cf:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19d1:	0f 88 80 00 00 00    	js     1a57 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19d7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19dc:	f7 e6                	mul    %esi
    19de:	d1 ea                	shr    %edx
    19e0:	8d 04 52             	lea    (%edx,%edx,2),%eax
    19e3:	89 f2                	mov    %esi,%edx
    19e5:	29 c2                	sub    %eax,%edx
    19e7:	89 d0                	mov    %edx,%eax
    19e9:	09 f8                	or     %edi,%eax
    19eb:	75 93                	jne    1980 <concreate+0x1c0>
      close(open(file, 0));
    19ed:	83 ec 08             	sub    $0x8,%esp
    19f0:	6a 00                	push   $0x0
    19f2:	53                   	push   %ebx
    19f3:	e8 da 1e 00 00       	call   38d2 <open>
    19f8:	89 04 24             	mov    %eax,(%esp)
    19fb:	e8 ba 1e 00 00       	call   38ba <close>
      close(open(file, 0));
    1a00:	58                   	pop    %eax
    1a01:	5a                   	pop    %edx
    1a02:	6a 00                	push   $0x0
    1a04:	53                   	push   %ebx
    1a05:	e8 c8 1e 00 00       	call   38d2 <open>
    1a0a:	89 04 24             	mov    %eax,(%esp)
    1a0d:	e8 a8 1e 00 00       	call   38ba <close>
      close(open(file, 0));
    1a12:	59                   	pop    %ecx
    1a13:	58                   	pop    %eax
    1a14:	6a 00                	push   $0x0
    1a16:	53                   	push   %ebx
    1a17:	e8 b6 1e 00 00       	call   38d2 <open>
    1a1c:	89 04 24             	mov    %eax,(%esp)
    1a1f:	e8 96 1e 00 00       	call   38ba <close>
      close(open(file, 0));
    1a24:	58                   	pop    %eax
    1a25:	5a                   	pop    %edx
    1a26:	6a 00                	push   $0x0
    1a28:	53                   	push   %ebx
    1a29:	e8 a4 1e 00 00       	call   38d2 <open>
    1a2e:	89 04 24             	mov    %eax,(%esp)
    1a31:	e8 84 1e 00 00       	call   38ba <close>
    1a36:	83 c4 10             	add    $0x10,%esp
    1a39:	e9 6f ff ff ff       	jmp    19ad <concreate+0x1ed>
    1a3e:	66 90                	xchg   %ax,%ax
  printf(1, "concreate ok\n");
    1a40:	83 ec 08             	sub    $0x8,%esp
    1a43:	68 06 44 00 00       	push   $0x4406
    1a48:	6a 01                	push   $0x1
    1a4a:	e8 a1 1f 00 00       	call   39f0 <printf>
}
    1a4f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a52:	5b                   	pop    %ebx
    1a53:	5e                   	pop    %esi
    1a54:	5f                   	pop    %edi
    1a55:	5d                   	pop    %ebp
    1a56:	c3                   	ret    
      printf(1, "fork failed\n");
    1a57:	83 ec 08             	sub    $0x8,%esp
    1a5a:	68 89 4c 00 00       	push   $0x4c89
    1a5f:	6a 01                	push   $0x1
    1a61:	e8 8a 1f 00 00       	call   39f0 <printf>
      exit();
    1a66:	e8 27 1e 00 00       	call   3892 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a6b:	51                   	push   %ecx
    1a6c:	51                   	push   %ecx
    1a6d:	68 50 4f 00 00       	push   $0x4f50
    1a72:	6a 01                	push   $0x1
    1a74:	e8 77 1f 00 00       	call   39f0 <printf>
    exit();
    1a79:	e8 14 1e 00 00       	call   3892 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a7e:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a81:	53                   	push   %ebx
    1a82:	50                   	push   %eax
    1a83:	68 e9 43 00 00       	push   $0x43e9
    1a88:	6a 01                	push   $0x1
    1a8a:	e8 61 1f 00 00       	call   39f0 <printf>
        exit();
    1a8f:	e8 fe 1d 00 00       	call   3892 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1a94:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a97:	56                   	push   %esi
    1a98:	50                   	push   %eax
    1a99:	68 d0 43 00 00       	push   $0x43d0
    1a9e:	6a 01                	push   $0x1
    1aa0:	e8 4b 1f 00 00       	call   39f0 <printf>
        exit();
    1aa5:	e8 e8 1d 00 00       	call   3892 <exit>
      close(fd);
    1aaa:	83 ec 0c             	sub    $0xc,%esp
    1aad:	50                   	push   %eax
    1aae:	e8 07 1e 00 00       	call   38ba <close>
    1ab3:	83 c4 10             	add    $0x10,%esp
    1ab6:	e9 f6 fd ff ff       	jmp    18b1 <concreate+0xf1>
    1abb:	90                   	nop
    1abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001ac0 <linkunlink>:
{
    1ac0:	55                   	push   %ebp
    1ac1:	89 e5                	mov    %esp,%ebp
    1ac3:	57                   	push   %edi
    1ac4:	56                   	push   %esi
    1ac5:	53                   	push   %ebx
    1ac6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1ac9:	68 14 44 00 00       	push   $0x4414
    1ace:	6a 01                	push   $0x1
    1ad0:	e8 1b 1f 00 00       	call   39f0 <printf>
  unlink("x");
    1ad5:	c7 04 24 a1 46 00 00 	movl   $0x46a1,(%esp)
    1adc:	e8 01 1e 00 00       	call   38e2 <unlink>
  pid = fork();
    1ae1:	e8 a4 1d 00 00       	call   388a <fork>
  if(pid < 0){
    1ae6:	83 c4 10             	add    $0x10,%esp
    1ae9:	85 c0                	test   %eax,%eax
  pid = fork();
    1aeb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1aee:	0f 88 b6 00 00 00    	js     1baa <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1af4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1af8:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1afd:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1b02:	19 ff                	sbb    %edi,%edi
    1b04:	83 e7 60             	and    $0x60,%edi
    1b07:	83 c7 01             	add    $0x1,%edi
    1b0a:	eb 1e                	jmp    1b2a <linkunlink+0x6a>
    1b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1b10:	83 fa 01             	cmp    $0x1,%edx
    1b13:	74 7b                	je     1b90 <linkunlink+0xd0>
      unlink("x");
    1b15:	83 ec 0c             	sub    $0xc,%esp
    1b18:	68 a1 46 00 00       	push   $0x46a1
    1b1d:	e8 c0 1d 00 00       	call   38e2 <unlink>
    1b22:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b25:	83 eb 01             	sub    $0x1,%ebx
    1b28:	74 3d                	je     1b67 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1b2a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b30:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b36:	89 f8                	mov    %edi,%eax
    1b38:	f7 e6                	mul    %esi
    1b3a:	d1 ea                	shr    %edx
    1b3c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b3f:	89 fa                	mov    %edi,%edx
    1b41:	29 c2                	sub    %eax,%edx
    1b43:	75 cb                	jne    1b10 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b45:	83 ec 08             	sub    $0x8,%esp
    1b48:	68 02 02 00 00       	push   $0x202
    1b4d:	68 a1 46 00 00       	push   $0x46a1
    1b52:	e8 7b 1d 00 00       	call   38d2 <open>
    1b57:	89 04 24             	mov    %eax,(%esp)
    1b5a:	e8 5b 1d 00 00       	call   38ba <close>
    1b5f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b62:	83 eb 01             	sub    $0x1,%ebx
    1b65:	75 c3                	jne    1b2a <linkunlink+0x6a>
  if(pid)
    1b67:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b6a:	85 c0                	test   %eax,%eax
    1b6c:	74 4f                	je     1bbd <linkunlink+0xfd>
    wait();
    1b6e:	e8 27 1d 00 00       	call   389a <wait>
  printf(1, "linkunlink ok\n");
    1b73:	83 ec 08             	sub    $0x8,%esp
    1b76:	68 29 44 00 00       	push   $0x4429
    1b7b:	6a 01                	push   $0x1
    1b7d:	e8 6e 1e 00 00       	call   39f0 <printf>
}
    1b82:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b85:	5b                   	pop    %ebx
    1b86:	5e                   	pop    %esi
    1b87:	5f                   	pop    %edi
    1b88:	5d                   	pop    %ebp
    1b89:	c3                   	ret    
    1b8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("cat", "x");
    1b90:	83 ec 08             	sub    $0x8,%esp
    1b93:	68 a1 46 00 00       	push   $0x46a1
    1b98:	68 25 44 00 00       	push   $0x4425
    1b9d:	e8 50 1d 00 00       	call   38f2 <link>
    1ba2:	83 c4 10             	add    $0x10,%esp
    1ba5:	e9 7b ff ff ff       	jmp    1b25 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1baa:	52                   	push   %edx
    1bab:	52                   	push   %edx
    1bac:	68 89 4c 00 00       	push   $0x4c89
    1bb1:	6a 01                	push   $0x1
    1bb3:	e8 38 1e 00 00       	call   39f0 <printf>
    exit();
    1bb8:	e8 d5 1c 00 00       	call   3892 <exit>
    exit();
    1bbd:	e8 d0 1c 00 00       	call   3892 <exit>
    1bc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bd0 <bigdir>:
{
    1bd0:	55                   	push   %ebp
    1bd1:	89 e5                	mov    %esp,%ebp
    1bd3:	57                   	push   %edi
    1bd4:	56                   	push   %esi
    1bd5:	53                   	push   %ebx
    1bd6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1bd9:	68 38 44 00 00       	push   $0x4438
    1bde:	6a 01                	push   $0x1
    1be0:	e8 0b 1e 00 00       	call   39f0 <printf>
  unlink("bd");
    1be5:	c7 04 24 45 44 00 00 	movl   $0x4445,(%esp)
    1bec:	e8 f1 1c 00 00       	call   38e2 <unlink>
  fd = open("bd", O_CREATE);
    1bf1:	5a                   	pop    %edx
    1bf2:	59                   	pop    %ecx
    1bf3:	68 00 02 00 00       	push   $0x200
    1bf8:	68 45 44 00 00       	push   $0x4445
    1bfd:	e8 d0 1c 00 00       	call   38d2 <open>
  if(fd < 0){
    1c02:	83 c4 10             	add    $0x10,%esp
    1c05:	85 c0                	test   %eax,%eax
    1c07:	0f 88 de 00 00 00    	js     1ceb <bigdir+0x11b>
  close(fd);
    1c0d:	83 ec 0c             	sub    $0xc,%esp
    1c10:	8d 7d de             	lea    -0x22(%ebp),%edi
  for(i = 0; i < 500; i++){
    1c13:	31 f6                	xor    %esi,%esi
  close(fd);
    1c15:	50                   	push   %eax
    1c16:	e8 9f 1c 00 00       	call   38ba <close>
    1c1b:	83 c4 10             	add    $0x10,%esp
    1c1e:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c20:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c22:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c25:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c29:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c2c:	57                   	push   %edi
    1c2d:	68 45 44 00 00       	push   $0x4445
    name[1] = '0' + (i / 64);
    1c32:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1c35:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c39:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c3c:	89 f0                	mov    %esi,%eax
    1c3e:	83 e0 3f             	and    $0x3f,%eax
    1c41:	83 c0 30             	add    $0x30,%eax
    1c44:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c47:	e8 a6 1c 00 00       	call   38f2 <link>
    1c4c:	83 c4 10             	add    $0x10,%esp
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	89 c3                	mov    %eax,%ebx
    1c53:	75 6e                	jne    1cc3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c55:	83 c6 01             	add    $0x1,%esi
    1c58:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c5e:	75 c0                	jne    1c20 <bigdir+0x50>
  unlink("bd");
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	68 45 44 00 00       	push   $0x4445
    1c68:	e8 75 1c 00 00       	call   38e2 <unlink>
    1c6d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1c70:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c72:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c75:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c79:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1c7c:	57                   	push   %edi
    name[3] = '\0';
    1c7d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c81:	83 c0 30             	add    $0x30,%eax
    1c84:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c87:	89 d8                	mov    %ebx,%eax
    1c89:	83 e0 3f             	and    $0x3f,%eax
    1c8c:	83 c0 30             	add    $0x30,%eax
    1c8f:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1c92:	e8 4b 1c 00 00       	call   38e2 <unlink>
    1c97:	83 c4 10             	add    $0x10,%esp
    1c9a:	85 c0                	test   %eax,%eax
    1c9c:	75 39                	jne    1cd7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1c9e:	83 c3 01             	add    $0x1,%ebx
    1ca1:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1ca7:	75 c7                	jne    1c70 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1ca9:	83 ec 08             	sub    $0x8,%esp
    1cac:	68 87 44 00 00       	push   $0x4487
    1cb1:	6a 01                	push   $0x1
    1cb3:	e8 38 1d 00 00       	call   39f0 <printf>
}
    1cb8:	83 c4 10             	add    $0x10,%esp
    1cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1cbe:	5b                   	pop    %ebx
    1cbf:	5e                   	pop    %esi
    1cc0:	5f                   	pop    %edi
    1cc1:	5d                   	pop    %ebp
    1cc2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1cc3:	83 ec 08             	sub    $0x8,%esp
    1cc6:	68 5e 44 00 00       	push   $0x445e
    1ccb:	6a 01                	push   $0x1
    1ccd:	e8 1e 1d 00 00       	call   39f0 <printf>
      exit();
    1cd2:	e8 bb 1b 00 00       	call   3892 <exit>
      printf(1, "bigdir unlink failed");
    1cd7:	83 ec 08             	sub    $0x8,%esp
    1cda:	68 72 44 00 00       	push   $0x4472
    1cdf:	6a 01                	push   $0x1
    1ce1:	e8 0a 1d 00 00       	call   39f0 <printf>
      exit();
    1ce6:	e8 a7 1b 00 00       	call   3892 <exit>
    printf(1, "bigdir create failed\n");
    1ceb:	50                   	push   %eax
    1cec:	50                   	push   %eax
    1ced:	68 48 44 00 00       	push   $0x4448
    1cf2:	6a 01                	push   $0x1
    1cf4:	e8 f7 1c 00 00       	call   39f0 <printf>
    exit();
    1cf9:	e8 94 1b 00 00       	call   3892 <exit>
    1cfe:	66 90                	xchg   %ax,%ax

00001d00 <subdir>:
{
    1d00:	55                   	push   %ebp
    1d01:	89 e5                	mov    %esp,%ebp
    1d03:	53                   	push   %ebx
    1d04:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1d07:	68 92 44 00 00       	push   $0x4492
    1d0c:	6a 01                	push   $0x1
    1d0e:	e8 dd 1c 00 00       	call   39f0 <printf>
  unlink("ff");
    1d13:	c7 04 24 1b 45 00 00 	movl   $0x451b,(%esp)
    1d1a:	e8 c3 1b 00 00       	call   38e2 <unlink>
  if(mkdir("dd") != 0){
    1d1f:	c7 04 24 b8 45 00 00 	movl   $0x45b8,(%esp)
    1d26:	e8 cf 1b 00 00       	call   38fa <mkdir>
    1d2b:	83 c4 10             	add    $0x10,%esp
    1d2e:	85 c0                	test   %eax,%eax
    1d30:	0f 85 b3 05 00 00    	jne    22e9 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d36:	83 ec 08             	sub    $0x8,%esp
    1d39:	68 02 02 00 00       	push   $0x202
    1d3e:	68 f1 44 00 00       	push   $0x44f1
    1d43:	e8 8a 1b 00 00       	call   38d2 <open>
  if(fd < 0){
    1d48:	83 c4 10             	add    $0x10,%esp
    1d4b:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d4d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d4f:	0f 88 81 05 00 00    	js     22d6 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d55:	83 ec 04             	sub    $0x4,%esp
    1d58:	6a 02                	push   $0x2
    1d5a:	68 1b 45 00 00       	push   $0x451b
    1d5f:	50                   	push   %eax
    1d60:	e8 4d 1b 00 00       	call   38b2 <write>
  close(fd);
    1d65:	89 1c 24             	mov    %ebx,(%esp)
    1d68:	e8 4d 1b 00 00       	call   38ba <close>
  if(unlink("dd") >= 0){
    1d6d:	c7 04 24 b8 45 00 00 	movl   $0x45b8,(%esp)
    1d74:	e8 69 1b 00 00       	call   38e2 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	0f 89 3f 05 00 00    	jns    22c3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1d84:	83 ec 0c             	sub    $0xc,%esp
    1d87:	68 cc 44 00 00       	push   $0x44cc
    1d8c:	e8 69 1b 00 00       	call   38fa <mkdir>
    1d91:	83 c4 10             	add    $0x10,%esp
    1d94:	85 c0                	test   %eax,%eax
    1d96:	0f 85 14 05 00 00    	jne    22b0 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1d9c:	83 ec 08             	sub    $0x8,%esp
    1d9f:	68 02 02 00 00       	push   $0x202
    1da4:	68 ee 44 00 00       	push   $0x44ee
    1da9:	e8 24 1b 00 00       	call   38d2 <open>
  if(fd < 0){
    1dae:	83 c4 10             	add    $0x10,%esp
    1db1:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1db3:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1db5:	0f 88 24 04 00 00    	js     21df <subdir+0x4df>
  write(fd, "FF", 2);
    1dbb:	83 ec 04             	sub    $0x4,%esp
    1dbe:	6a 02                	push   $0x2
    1dc0:	68 0f 45 00 00       	push   $0x450f
    1dc5:	50                   	push   %eax
    1dc6:	e8 e7 1a 00 00       	call   38b2 <write>
  close(fd);
    1dcb:	89 1c 24             	mov    %ebx,(%esp)
    1dce:	e8 e7 1a 00 00       	call   38ba <close>
  fd = open("dd/dd/../ff", 0);
    1dd3:	58                   	pop    %eax
    1dd4:	5a                   	pop    %edx
    1dd5:	6a 00                	push   $0x0
    1dd7:	68 12 45 00 00       	push   $0x4512
    1ddc:	e8 f1 1a 00 00       	call   38d2 <open>
  if(fd < 0){
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    1de6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1de8:	0f 88 de 03 00 00    	js     21cc <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1dee:	83 ec 04             	sub    $0x4,%esp
    1df1:	68 00 20 00 00       	push   $0x2000
    1df6:	68 e0 85 00 00       	push   $0x85e0
    1dfb:	50                   	push   %eax
    1dfc:	e8 a9 1a 00 00       	call   38aa <read>
  if(cc != 2 || buf[0] != 'f'){
    1e01:	83 c4 10             	add    $0x10,%esp
    1e04:	83 f8 02             	cmp    $0x2,%eax
    1e07:	0f 85 3a 03 00 00    	jne    2147 <subdir+0x447>
    1e0d:	80 3d e0 85 00 00 66 	cmpb   $0x66,0x85e0
    1e14:	0f 85 2d 03 00 00    	jne    2147 <subdir+0x447>
  close(fd);
    1e1a:	83 ec 0c             	sub    $0xc,%esp
    1e1d:	53                   	push   %ebx
    1e1e:	e8 97 1a 00 00       	call   38ba <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e23:	5b                   	pop    %ebx
    1e24:	58                   	pop    %eax
    1e25:	68 52 45 00 00       	push   $0x4552
    1e2a:	68 ee 44 00 00       	push   $0x44ee
    1e2f:	e8 be 1a 00 00       	call   38f2 <link>
    1e34:	83 c4 10             	add    $0x10,%esp
    1e37:	85 c0                	test   %eax,%eax
    1e39:	0f 85 c6 03 00 00    	jne    2205 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e3f:	83 ec 0c             	sub    $0xc,%esp
    1e42:	68 ee 44 00 00       	push   $0x44ee
    1e47:	e8 96 1a 00 00       	call   38e2 <unlink>
    1e4c:	83 c4 10             	add    $0x10,%esp
    1e4f:	85 c0                	test   %eax,%eax
    1e51:	0f 85 16 03 00 00    	jne    216d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e57:	83 ec 08             	sub    $0x8,%esp
    1e5a:	6a 00                	push   $0x0
    1e5c:	68 ee 44 00 00       	push   $0x44ee
    1e61:	e8 6c 1a 00 00       	call   38d2 <open>
    1e66:	83 c4 10             	add    $0x10,%esp
    1e69:	85 c0                	test   %eax,%eax
    1e6b:	0f 89 2c 04 00 00    	jns    229d <subdir+0x59d>
  if(chdir("dd") != 0){
    1e71:	83 ec 0c             	sub    $0xc,%esp
    1e74:	68 b8 45 00 00       	push   $0x45b8
    1e79:	e8 84 1a 00 00       	call   3902 <chdir>
    1e7e:	83 c4 10             	add    $0x10,%esp
    1e81:	85 c0                	test   %eax,%eax
    1e83:	0f 85 01 04 00 00    	jne    228a <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1e89:	83 ec 0c             	sub    $0xc,%esp
    1e8c:	68 86 45 00 00       	push   $0x4586
    1e91:	e8 6c 1a 00 00       	call   3902 <chdir>
    1e96:	83 c4 10             	add    $0x10,%esp
    1e99:	85 c0                	test   %eax,%eax
    1e9b:	0f 85 b9 02 00 00    	jne    215a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1ea1:	83 ec 0c             	sub    $0xc,%esp
    1ea4:	68 ac 45 00 00       	push   $0x45ac
    1ea9:	e8 54 1a 00 00       	call   3902 <chdir>
    1eae:	83 c4 10             	add    $0x10,%esp
    1eb1:	85 c0                	test   %eax,%eax
    1eb3:	0f 85 a1 02 00 00    	jne    215a <subdir+0x45a>
  if(chdir("./..") != 0){
    1eb9:	83 ec 0c             	sub    $0xc,%esp
    1ebc:	68 bb 45 00 00       	push   $0x45bb
    1ec1:	e8 3c 1a 00 00       	call   3902 <chdir>
    1ec6:	83 c4 10             	add    $0x10,%esp
    1ec9:	85 c0                	test   %eax,%eax
    1ecb:	0f 85 21 03 00 00    	jne    21f2 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	6a 00                	push   $0x0
    1ed6:	68 52 45 00 00       	push   $0x4552
    1edb:	e8 f2 19 00 00       	call   38d2 <open>
  if(fd < 0){
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    1ee5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ee7:	0f 88 e0 04 00 00    	js     23cd <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1eed:	83 ec 04             	sub    $0x4,%esp
    1ef0:	68 00 20 00 00       	push   $0x2000
    1ef5:	68 e0 85 00 00       	push   $0x85e0
    1efa:	50                   	push   %eax
    1efb:	e8 aa 19 00 00       	call   38aa <read>
    1f00:	83 c4 10             	add    $0x10,%esp
    1f03:	83 f8 02             	cmp    $0x2,%eax
    1f06:	0f 85 ae 04 00 00    	jne    23ba <subdir+0x6ba>
  close(fd);
    1f0c:	83 ec 0c             	sub    $0xc,%esp
    1f0f:	53                   	push   %ebx
    1f10:	e8 a5 19 00 00       	call   38ba <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f15:	59                   	pop    %ecx
    1f16:	5b                   	pop    %ebx
    1f17:	6a 00                	push   $0x0
    1f19:	68 ee 44 00 00       	push   $0x44ee
    1f1e:	e8 af 19 00 00       	call   38d2 <open>
    1f23:	83 c4 10             	add    $0x10,%esp
    1f26:	85 c0                	test   %eax,%eax
    1f28:	0f 89 65 02 00 00    	jns    2193 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f2e:	83 ec 08             	sub    $0x8,%esp
    1f31:	68 02 02 00 00       	push   $0x202
    1f36:	68 06 46 00 00       	push   $0x4606
    1f3b:	e8 92 19 00 00       	call   38d2 <open>
    1f40:	83 c4 10             	add    $0x10,%esp
    1f43:	85 c0                	test   %eax,%eax
    1f45:	0f 89 35 02 00 00    	jns    2180 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f4b:	83 ec 08             	sub    $0x8,%esp
    1f4e:	68 02 02 00 00       	push   $0x202
    1f53:	68 2b 46 00 00       	push   $0x462b
    1f58:	e8 75 19 00 00       	call   38d2 <open>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	0f 89 0f 03 00 00    	jns    2277 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f68:	83 ec 08             	sub    $0x8,%esp
    1f6b:	68 00 02 00 00       	push   $0x200
    1f70:	68 b8 45 00 00       	push   $0x45b8
    1f75:	e8 58 19 00 00       	call   38d2 <open>
    1f7a:	83 c4 10             	add    $0x10,%esp
    1f7d:	85 c0                	test   %eax,%eax
    1f7f:	0f 89 df 02 00 00    	jns    2264 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1f85:	83 ec 08             	sub    $0x8,%esp
    1f88:	6a 02                	push   $0x2
    1f8a:	68 b8 45 00 00       	push   $0x45b8
    1f8f:	e8 3e 19 00 00       	call   38d2 <open>
    1f94:	83 c4 10             	add    $0x10,%esp
    1f97:	85 c0                	test   %eax,%eax
    1f99:	0f 89 b2 02 00 00    	jns    2251 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1f9f:	83 ec 08             	sub    $0x8,%esp
    1fa2:	6a 01                	push   $0x1
    1fa4:	68 b8 45 00 00       	push   $0x45b8
    1fa9:	e8 24 19 00 00       	call   38d2 <open>
    1fae:	83 c4 10             	add    $0x10,%esp
    1fb1:	85 c0                	test   %eax,%eax
    1fb3:	0f 89 85 02 00 00    	jns    223e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1fb9:	83 ec 08             	sub    $0x8,%esp
    1fbc:	68 9a 46 00 00       	push   $0x469a
    1fc1:	68 06 46 00 00       	push   $0x4606
    1fc6:	e8 27 19 00 00       	call   38f2 <link>
    1fcb:	83 c4 10             	add    $0x10,%esp
    1fce:	85 c0                	test   %eax,%eax
    1fd0:	0f 84 55 02 00 00    	je     222b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1fd6:	83 ec 08             	sub    $0x8,%esp
    1fd9:	68 9a 46 00 00       	push   $0x469a
    1fde:	68 2b 46 00 00       	push   $0x462b
    1fe3:	e8 0a 19 00 00       	call   38f2 <link>
    1fe8:	83 c4 10             	add    $0x10,%esp
    1feb:	85 c0                	test   %eax,%eax
    1fed:	0f 84 25 02 00 00    	je     2218 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1ff3:	83 ec 08             	sub    $0x8,%esp
    1ff6:	68 52 45 00 00       	push   $0x4552
    1ffb:	68 f1 44 00 00       	push   $0x44f1
    2000:	e8 ed 18 00 00       	call   38f2 <link>
    2005:	83 c4 10             	add    $0x10,%esp
    2008:	85 c0                	test   %eax,%eax
    200a:	0f 84 a9 01 00 00    	je     21b9 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    2010:	83 ec 0c             	sub    $0xc,%esp
    2013:	68 06 46 00 00       	push   $0x4606
    2018:	e8 dd 18 00 00       	call   38fa <mkdir>
    201d:	83 c4 10             	add    $0x10,%esp
    2020:	85 c0                	test   %eax,%eax
    2022:	0f 84 7e 01 00 00    	je     21a6 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2028:	83 ec 0c             	sub    $0xc,%esp
    202b:	68 2b 46 00 00       	push   $0x462b
    2030:	e8 c5 18 00 00       	call   38fa <mkdir>
    2035:	83 c4 10             	add    $0x10,%esp
    2038:	85 c0                	test   %eax,%eax
    203a:	0f 84 67 03 00 00    	je     23a7 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2040:	83 ec 0c             	sub    $0xc,%esp
    2043:	68 52 45 00 00       	push   $0x4552
    2048:	e8 ad 18 00 00       	call   38fa <mkdir>
    204d:	83 c4 10             	add    $0x10,%esp
    2050:	85 c0                	test   %eax,%eax
    2052:	0f 84 3c 03 00 00    	je     2394 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2058:	83 ec 0c             	sub    $0xc,%esp
    205b:	68 2b 46 00 00       	push   $0x462b
    2060:	e8 7d 18 00 00       	call   38e2 <unlink>
    2065:	83 c4 10             	add    $0x10,%esp
    2068:	85 c0                	test   %eax,%eax
    206a:	0f 84 11 03 00 00    	je     2381 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2070:	83 ec 0c             	sub    $0xc,%esp
    2073:	68 06 46 00 00       	push   $0x4606
    2078:	e8 65 18 00 00       	call   38e2 <unlink>
    207d:	83 c4 10             	add    $0x10,%esp
    2080:	85 c0                	test   %eax,%eax
    2082:	0f 84 e6 02 00 00    	je     236e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    2088:	83 ec 0c             	sub    $0xc,%esp
    208b:	68 f1 44 00 00       	push   $0x44f1
    2090:	e8 6d 18 00 00       	call   3902 <chdir>
    2095:	83 c4 10             	add    $0x10,%esp
    2098:	85 c0                	test   %eax,%eax
    209a:	0f 84 bb 02 00 00    	je     235b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    20a0:	83 ec 0c             	sub    $0xc,%esp
    20a3:	68 9d 46 00 00       	push   $0x469d
    20a8:	e8 55 18 00 00       	call   3902 <chdir>
    20ad:	83 c4 10             	add    $0x10,%esp
    20b0:	85 c0                	test   %eax,%eax
    20b2:	0f 84 90 02 00 00    	je     2348 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    20b8:	83 ec 0c             	sub    $0xc,%esp
    20bb:	68 52 45 00 00       	push   $0x4552
    20c0:	e8 1d 18 00 00       	call   38e2 <unlink>
    20c5:	83 c4 10             	add    $0x10,%esp
    20c8:	85 c0                	test   %eax,%eax
    20ca:	0f 85 9d 00 00 00    	jne    216d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20d0:	83 ec 0c             	sub    $0xc,%esp
    20d3:	68 f1 44 00 00       	push   $0x44f1
    20d8:	e8 05 18 00 00       	call   38e2 <unlink>
    20dd:	83 c4 10             	add    $0x10,%esp
    20e0:	85 c0                	test   %eax,%eax
    20e2:	0f 85 4d 02 00 00    	jne    2335 <subdir+0x635>
  if(unlink("dd") == 0){
    20e8:	83 ec 0c             	sub    $0xc,%esp
    20eb:	68 b8 45 00 00       	push   $0x45b8
    20f0:	e8 ed 17 00 00       	call   38e2 <unlink>
    20f5:	83 c4 10             	add    $0x10,%esp
    20f8:	85 c0                	test   %eax,%eax
    20fa:	0f 84 22 02 00 00    	je     2322 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    2100:	83 ec 0c             	sub    $0xc,%esp
    2103:	68 cd 44 00 00       	push   $0x44cd
    2108:	e8 d5 17 00 00       	call   38e2 <unlink>
    210d:	83 c4 10             	add    $0x10,%esp
    2110:	85 c0                	test   %eax,%eax
    2112:	0f 88 f7 01 00 00    	js     230f <subdir+0x60f>
  if(unlink("dd") < 0){
    2118:	83 ec 0c             	sub    $0xc,%esp
    211b:	68 b8 45 00 00       	push   $0x45b8
    2120:	e8 bd 17 00 00       	call   38e2 <unlink>
    2125:	83 c4 10             	add    $0x10,%esp
    2128:	85 c0                	test   %eax,%eax
    212a:	0f 88 cc 01 00 00    	js     22fc <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2130:	83 ec 08             	sub    $0x8,%esp
    2133:	68 9a 47 00 00       	push   $0x479a
    2138:	6a 01                	push   $0x1
    213a:	e8 b1 18 00 00       	call   39f0 <printf>
}
    213f:	83 c4 10             	add    $0x10,%esp
    2142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2145:	c9                   	leave  
    2146:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2147:	50                   	push   %eax
    2148:	50                   	push   %eax
    2149:	68 37 45 00 00       	push   $0x4537
    214e:	6a 01                	push   $0x1
    2150:	e8 9b 18 00 00       	call   39f0 <printf>
    exit();
    2155:	e8 38 17 00 00       	call   3892 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    215a:	50                   	push   %eax
    215b:	50                   	push   %eax
    215c:	68 92 45 00 00       	push   $0x4592
    2161:	6a 01                	push   $0x1
    2163:	e8 88 18 00 00       	call   39f0 <printf>
    exit();
    2168:	e8 25 17 00 00       	call   3892 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    216d:	52                   	push   %edx
    216e:	52                   	push   %edx
    216f:	68 5d 45 00 00       	push   $0x455d
    2174:	6a 01                	push   $0x1
    2176:	e8 75 18 00 00       	call   39f0 <printf>
    exit();
    217b:	e8 12 17 00 00       	call   3892 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2180:	50                   	push   %eax
    2181:	50                   	push   %eax
    2182:	68 0f 46 00 00       	push   $0x460f
    2187:	6a 01                	push   $0x1
    2189:	e8 62 18 00 00       	call   39f0 <printf>
    exit();
    218e:	e8 ff 16 00 00       	call   3892 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2193:	52                   	push   %edx
    2194:	52                   	push   %edx
    2195:	68 f4 4f 00 00       	push   $0x4ff4
    219a:	6a 01                	push   $0x1
    219c:	e8 4f 18 00 00       	call   39f0 <printf>
    exit();
    21a1:	e8 ec 16 00 00       	call   3892 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    21a6:	52                   	push   %edx
    21a7:	52                   	push   %edx
    21a8:	68 a3 46 00 00       	push   $0x46a3
    21ad:	6a 01                	push   $0x1
    21af:	e8 3c 18 00 00       	call   39f0 <printf>
    exit();
    21b4:	e8 d9 16 00 00       	call   3892 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21b9:	51                   	push   %ecx
    21ba:	51                   	push   %ecx
    21bb:	68 64 50 00 00       	push   $0x5064
    21c0:	6a 01                	push   $0x1
    21c2:	e8 29 18 00 00       	call   39f0 <printf>
    exit();
    21c7:	e8 c6 16 00 00       	call   3892 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21cc:	50                   	push   %eax
    21cd:	50                   	push   %eax
    21ce:	68 1e 45 00 00       	push   $0x451e
    21d3:	6a 01                	push   $0x1
    21d5:	e8 16 18 00 00       	call   39f0 <printf>
    exit();
    21da:	e8 b3 16 00 00       	call   3892 <exit>
    printf(1, "create dd/dd/ff failed\n");
    21df:	51                   	push   %ecx
    21e0:	51                   	push   %ecx
    21e1:	68 f7 44 00 00       	push   $0x44f7
    21e6:	6a 01                	push   $0x1
    21e8:	e8 03 18 00 00       	call   39f0 <printf>
    exit();
    21ed:	e8 a0 16 00 00       	call   3892 <exit>
    printf(1, "chdir ./.. failed\n");
    21f2:	50                   	push   %eax
    21f3:	50                   	push   %eax
    21f4:	68 c0 45 00 00       	push   $0x45c0
    21f9:	6a 01                	push   $0x1
    21fb:	e8 f0 17 00 00       	call   39f0 <printf>
    exit();
    2200:	e8 8d 16 00 00       	call   3892 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2205:	51                   	push   %ecx
    2206:	51                   	push   %ecx
    2207:	68 ac 4f 00 00       	push   $0x4fac
    220c:	6a 01                	push   $0x1
    220e:	e8 dd 17 00 00       	call   39f0 <printf>
    exit();
    2213:	e8 7a 16 00 00       	call   3892 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2218:	53                   	push   %ebx
    2219:	53                   	push   %ebx
    221a:	68 40 50 00 00       	push   $0x5040
    221f:	6a 01                	push   $0x1
    2221:	e8 ca 17 00 00       	call   39f0 <printf>
    exit();
    2226:	e8 67 16 00 00       	call   3892 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    222b:	50                   	push   %eax
    222c:	50                   	push   %eax
    222d:	68 1c 50 00 00       	push   $0x501c
    2232:	6a 01                	push   $0x1
    2234:	e8 b7 17 00 00       	call   39f0 <printf>
    exit();
    2239:	e8 54 16 00 00       	call   3892 <exit>
    printf(1, "open dd wronly succeeded!\n");
    223e:	50                   	push   %eax
    223f:	50                   	push   %eax
    2240:	68 7f 46 00 00       	push   $0x467f
    2245:	6a 01                	push   $0x1
    2247:	e8 a4 17 00 00       	call   39f0 <printf>
    exit();
    224c:	e8 41 16 00 00       	call   3892 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2251:	50                   	push   %eax
    2252:	50                   	push   %eax
    2253:	68 66 46 00 00       	push   $0x4666
    2258:	6a 01                	push   $0x1
    225a:	e8 91 17 00 00       	call   39f0 <printf>
    exit();
    225f:	e8 2e 16 00 00       	call   3892 <exit>
    printf(1, "create dd succeeded!\n");
    2264:	50                   	push   %eax
    2265:	50                   	push   %eax
    2266:	68 50 46 00 00       	push   $0x4650
    226b:	6a 01                	push   $0x1
    226d:	e8 7e 17 00 00       	call   39f0 <printf>
    exit();
    2272:	e8 1b 16 00 00       	call   3892 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2277:	50                   	push   %eax
    2278:	50                   	push   %eax
    2279:	68 34 46 00 00       	push   $0x4634
    227e:	6a 01                	push   $0x1
    2280:	e8 6b 17 00 00       	call   39f0 <printf>
    exit();
    2285:	e8 08 16 00 00       	call   3892 <exit>
    printf(1, "chdir dd failed\n");
    228a:	50                   	push   %eax
    228b:	50                   	push   %eax
    228c:	68 75 45 00 00       	push   $0x4575
    2291:	6a 01                	push   $0x1
    2293:	e8 58 17 00 00       	call   39f0 <printf>
    exit();
    2298:	e8 f5 15 00 00       	call   3892 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    229d:	50                   	push   %eax
    229e:	50                   	push   %eax
    229f:	68 d0 4f 00 00       	push   $0x4fd0
    22a4:	6a 01                	push   $0x1
    22a6:	e8 45 17 00 00       	call   39f0 <printf>
    exit();
    22ab:	e8 e2 15 00 00       	call   3892 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    22b0:	53                   	push   %ebx
    22b1:	53                   	push   %ebx
    22b2:	68 d3 44 00 00       	push   $0x44d3
    22b7:	6a 01                	push   $0x1
    22b9:	e8 32 17 00 00       	call   39f0 <printf>
    exit();
    22be:	e8 cf 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22c3:	50                   	push   %eax
    22c4:	50                   	push   %eax
    22c5:	68 84 4f 00 00       	push   $0x4f84
    22ca:	6a 01                	push   $0x1
    22cc:	e8 1f 17 00 00       	call   39f0 <printf>
    exit();
    22d1:	e8 bc 15 00 00       	call   3892 <exit>
    printf(1, "create dd/ff failed\n");
    22d6:	50                   	push   %eax
    22d7:	50                   	push   %eax
    22d8:	68 b7 44 00 00       	push   $0x44b7
    22dd:	6a 01                	push   $0x1
    22df:	e8 0c 17 00 00       	call   39f0 <printf>
    exit();
    22e4:	e8 a9 15 00 00       	call   3892 <exit>
    printf(1, "subdir mkdir dd failed\n");
    22e9:	50                   	push   %eax
    22ea:	50                   	push   %eax
    22eb:	68 9f 44 00 00       	push   $0x449f
    22f0:	6a 01                	push   $0x1
    22f2:	e8 f9 16 00 00       	call   39f0 <printf>
    exit();
    22f7:	e8 96 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd failed\n");
    22fc:	50                   	push   %eax
    22fd:	50                   	push   %eax
    22fe:	68 88 47 00 00       	push   $0x4788
    2303:	6a 01                	push   $0x1
    2305:	e8 e6 16 00 00       	call   39f0 <printf>
    exit();
    230a:	e8 83 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd/dd failed\n");
    230f:	52                   	push   %edx
    2310:	52                   	push   %edx
    2311:	68 73 47 00 00       	push   $0x4773
    2316:	6a 01                	push   $0x1
    2318:	e8 d3 16 00 00       	call   39f0 <printf>
    exit();
    231d:	e8 70 15 00 00       	call   3892 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2322:	51                   	push   %ecx
    2323:	51                   	push   %ecx
    2324:	68 88 50 00 00       	push   $0x5088
    2329:	6a 01                	push   $0x1
    232b:	e8 c0 16 00 00       	call   39f0 <printf>
    exit();
    2330:	e8 5d 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd/ff failed\n");
    2335:	53                   	push   %ebx
    2336:	53                   	push   %ebx
    2337:	68 5e 47 00 00       	push   $0x475e
    233c:	6a 01                	push   $0x1
    233e:	e8 ad 16 00 00       	call   39f0 <printf>
    exit();
    2343:	e8 4a 15 00 00       	call   3892 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2348:	50                   	push   %eax
    2349:	50                   	push   %eax
    234a:	68 46 47 00 00       	push   $0x4746
    234f:	6a 01                	push   $0x1
    2351:	e8 9a 16 00 00       	call   39f0 <printf>
    exit();
    2356:	e8 37 15 00 00       	call   3892 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    235b:	50                   	push   %eax
    235c:	50                   	push   %eax
    235d:	68 2e 47 00 00       	push   $0x472e
    2362:	6a 01                	push   $0x1
    2364:	e8 87 16 00 00       	call   39f0 <printf>
    exit();
    2369:	e8 24 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    236e:	50                   	push   %eax
    236f:	50                   	push   %eax
    2370:	68 12 47 00 00       	push   $0x4712
    2375:	6a 01                	push   $0x1
    2377:	e8 74 16 00 00       	call   39f0 <printf>
    exit();
    237c:	e8 11 15 00 00       	call   3892 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2381:	50                   	push   %eax
    2382:	50                   	push   %eax
    2383:	68 f6 46 00 00       	push   $0x46f6
    2388:	6a 01                	push   $0x1
    238a:	e8 61 16 00 00       	call   39f0 <printf>
    exit();
    238f:	e8 fe 14 00 00       	call   3892 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2394:	50                   	push   %eax
    2395:	50                   	push   %eax
    2396:	68 d9 46 00 00       	push   $0x46d9
    239b:	6a 01                	push   $0x1
    239d:	e8 4e 16 00 00       	call   39f0 <printf>
    exit();
    23a2:	e8 eb 14 00 00       	call   3892 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    23a7:	50                   	push   %eax
    23a8:	50                   	push   %eax
    23a9:	68 be 46 00 00       	push   $0x46be
    23ae:	6a 01                	push   $0x1
    23b0:	e8 3b 16 00 00       	call   39f0 <printf>
    exit();
    23b5:	e8 d8 14 00 00       	call   3892 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    23ba:	50                   	push   %eax
    23bb:	50                   	push   %eax
    23bc:	68 eb 45 00 00       	push   $0x45eb
    23c1:	6a 01                	push   $0x1
    23c3:	e8 28 16 00 00       	call   39f0 <printf>
    exit();
    23c8:	e8 c5 14 00 00       	call   3892 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23cd:	50                   	push   %eax
    23ce:	50                   	push   %eax
    23cf:	68 d3 45 00 00       	push   $0x45d3
    23d4:	6a 01                	push   $0x1
    23d6:	e8 15 16 00 00       	call   39f0 <printf>
    exit();
    23db:	e8 b2 14 00 00       	call   3892 <exit>

000023e0 <bigwrite>:
{
    23e0:	55                   	push   %ebp
    23e1:	89 e5                	mov    %esp,%ebp
    23e3:	56                   	push   %esi
    23e4:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    23e5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    23ea:	83 ec 08             	sub    $0x8,%esp
    23ed:	68 a5 47 00 00       	push   $0x47a5
    23f2:	6a 01                	push   $0x1
    23f4:	e8 f7 15 00 00       	call   39f0 <printf>
  unlink("bigwrite");
    23f9:	c7 04 24 b4 47 00 00 	movl   $0x47b4,(%esp)
    2400:	e8 dd 14 00 00       	call   38e2 <unlink>
    2405:	83 c4 10             	add    $0x10,%esp
    2408:	90                   	nop
    2409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2410:	83 ec 08             	sub    $0x8,%esp
    2413:	68 02 02 00 00       	push   $0x202
    2418:	68 b4 47 00 00       	push   $0x47b4
    241d:	e8 b0 14 00 00       	call   38d2 <open>
    if(fd < 0){
    2422:	83 c4 10             	add    $0x10,%esp
    2425:	85 c0                	test   %eax,%eax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2427:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2429:	78 7e                	js     24a9 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    242b:	83 ec 04             	sub    $0x4,%esp
    242e:	53                   	push   %ebx
    242f:	68 e0 85 00 00       	push   $0x85e0
    2434:	50                   	push   %eax
    2435:	e8 78 14 00 00       	call   38b2 <write>
      if(cc != sz){
    243a:	83 c4 10             	add    $0x10,%esp
    243d:	39 d8                	cmp    %ebx,%eax
    243f:	75 55                	jne    2496 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2441:	83 ec 04             	sub    $0x4,%esp
    2444:	53                   	push   %ebx
    2445:	68 e0 85 00 00       	push   $0x85e0
    244a:	56                   	push   %esi
    244b:	e8 62 14 00 00       	call   38b2 <write>
      if(cc != sz){
    2450:	83 c4 10             	add    $0x10,%esp
    2453:	39 d8                	cmp    %ebx,%eax
    2455:	75 3f                	jne    2496 <bigwrite+0xb6>
    close(fd);
    2457:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    245a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2460:	56                   	push   %esi
    2461:	e8 54 14 00 00       	call   38ba <close>
    unlink("bigwrite");
    2466:	c7 04 24 b4 47 00 00 	movl   $0x47b4,(%esp)
    246d:	e8 70 14 00 00       	call   38e2 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2472:	83 c4 10             	add    $0x10,%esp
    2475:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    247b:	75 93                	jne    2410 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    247d:	83 ec 08             	sub    $0x8,%esp
    2480:	68 e7 47 00 00       	push   $0x47e7
    2485:	6a 01                	push   $0x1
    2487:	e8 64 15 00 00       	call   39f0 <printf>
}
    248c:	83 c4 10             	add    $0x10,%esp
    248f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2492:	5b                   	pop    %ebx
    2493:	5e                   	pop    %esi
    2494:	5d                   	pop    %ebp
    2495:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    2496:	50                   	push   %eax
    2497:	53                   	push   %ebx
    2498:	68 d5 47 00 00       	push   $0x47d5
    249d:	6a 01                	push   $0x1
    249f:	e8 4c 15 00 00       	call   39f0 <printf>
        exit();
    24a4:	e8 e9 13 00 00       	call   3892 <exit>
      printf(1, "cannot create bigwrite\n");
    24a9:	83 ec 08             	sub    $0x8,%esp
    24ac:	68 bd 47 00 00       	push   $0x47bd
    24b1:	6a 01                	push   $0x1
    24b3:	e8 38 15 00 00       	call   39f0 <printf>
      exit();
    24b8:	e8 d5 13 00 00       	call   3892 <exit>
    24bd:	8d 76 00             	lea    0x0(%esi),%esi

000024c0 <bigfile>:
{
    24c0:	55                   	push   %ebp
    24c1:	89 e5                	mov    %esp,%ebp
    24c3:	57                   	push   %edi
    24c4:	56                   	push   %esi
    24c5:	53                   	push   %ebx
    24c6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24c9:	68 f4 47 00 00       	push   $0x47f4
    24ce:	6a 01                	push   $0x1
    24d0:	e8 1b 15 00 00       	call   39f0 <printf>
  unlink("bigfile");
    24d5:	c7 04 24 10 48 00 00 	movl   $0x4810,(%esp)
    24dc:	e8 01 14 00 00       	call   38e2 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    24e1:	58                   	pop    %eax
    24e2:	5a                   	pop    %edx
    24e3:	68 02 02 00 00       	push   $0x202
    24e8:	68 10 48 00 00       	push   $0x4810
    24ed:	e8 e0 13 00 00       	call   38d2 <open>
  if(fd < 0){
    24f2:	83 c4 10             	add    $0x10,%esp
    24f5:	85 c0                	test   %eax,%eax
    24f7:	0f 88 5e 01 00 00    	js     265b <bigfile+0x19b>
    24fd:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    24ff:	31 db                	xor    %ebx,%ebx
    2501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    2508:	83 ec 04             	sub    $0x4,%esp
    250b:	68 58 02 00 00       	push   $0x258
    2510:	53                   	push   %ebx
    2511:	68 e0 85 00 00       	push   $0x85e0
    2516:	e8 d5 11 00 00       	call   36f0 <memset>
    if(write(fd, buf, 600) != 600){
    251b:	83 c4 0c             	add    $0xc,%esp
    251e:	68 58 02 00 00       	push   $0x258
    2523:	68 e0 85 00 00       	push   $0x85e0
    2528:	56                   	push   %esi
    2529:	e8 84 13 00 00       	call   38b2 <write>
    252e:	83 c4 10             	add    $0x10,%esp
    2531:	3d 58 02 00 00       	cmp    $0x258,%eax
    2536:	0f 85 f8 00 00 00    	jne    2634 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    253c:	83 c3 01             	add    $0x1,%ebx
    253f:	83 fb 14             	cmp    $0x14,%ebx
    2542:	75 c4                	jne    2508 <bigfile+0x48>
  close(fd);
    2544:	83 ec 0c             	sub    $0xc,%esp
    2547:	56                   	push   %esi
    2548:	e8 6d 13 00 00       	call   38ba <close>
  fd = open("bigfile", 0);
    254d:	5e                   	pop    %esi
    254e:	5f                   	pop    %edi
    254f:	6a 00                	push   $0x0
    2551:	68 10 48 00 00       	push   $0x4810
    2556:	e8 77 13 00 00       	call   38d2 <open>
  if(fd < 0){
    255b:	83 c4 10             	add    $0x10,%esp
    255e:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2560:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2562:	0f 88 e0 00 00 00    	js     2648 <bigfile+0x188>
  total = 0;
    2568:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    256a:	31 ff                	xor    %edi,%edi
    256c:	eb 30                	jmp    259e <bigfile+0xde>
    256e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2570:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2575:	0f 85 91 00 00 00    	jne    260c <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    257b:	0f be 05 e0 85 00 00 	movsbl 0x85e0,%eax
    2582:	89 fa                	mov    %edi,%edx
    2584:	d1 fa                	sar    %edx
    2586:	39 d0                	cmp    %edx,%eax
    2588:	75 6e                	jne    25f8 <bigfile+0x138>
    258a:	0f be 15 0b 87 00 00 	movsbl 0x870b,%edx
    2591:	39 d0                	cmp    %edx,%eax
    2593:	75 63                	jne    25f8 <bigfile+0x138>
    total += cc;
    2595:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    259b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    259e:	83 ec 04             	sub    $0x4,%esp
    25a1:	68 2c 01 00 00       	push   $0x12c
    25a6:	68 e0 85 00 00       	push   $0x85e0
    25ab:	56                   	push   %esi
    25ac:	e8 f9 12 00 00       	call   38aa <read>
    if(cc < 0){
    25b1:	83 c4 10             	add    $0x10,%esp
    25b4:	85 c0                	test   %eax,%eax
    25b6:	78 68                	js     2620 <bigfile+0x160>
    if(cc == 0)
    25b8:	75 b6                	jne    2570 <bigfile+0xb0>
  close(fd);
    25ba:	83 ec 0c             	sub    $0xc,%esp
    25bd:	56                   	push   %esi
    25be:	e8 f7 12 00 00       	call   38ba <close>
  if(total != 20*600){
    25c3:	83 c4 10             	add    $0x10,%esp
    25c6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25cc:	0f 85 9c 00 00 00    	jne    266e <bigfile+0x1ae>
  unlink("bigfile");
    25d2:	83 ec 0c             	sub    $0xc,%esp
    25d5:	68 10 48 00 00       	push   $0x4810
    25da:	e8 03 13 00 00       	call   38e2 <unlink>
  printf(1, "bigfile test ok\n");
    25df:	58                   	pop    %eax
    25e0:	5a                   	pop    %edx
    25e1:	68 9f 48 00 00       	push   $0x489f
    25e6:	6a 01                	push   $0x1
    25e8:	e8 03 14 00 00       	call   39f0 <printf>
}
    25ed:	83 c4 10             	add    $0x10,%esp
    25f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    25f3:	5b                   	pop    %ebx
    25f4:	5e                   	pop    %esi
    25f5:	5f                   	pop    %edi
    25f6:	5d                   	pop    %ebp
    25f7:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    25f8:	83 ec 08             	sub    $0x8,%esp
    25fb:	68 6c 48 00 00       	push   $0x486c
    2600:	6a 01                	push   $0x1
    2602:	e8 e9 13 00 00       	call   39f0 <printf>
      exit();
    2607:	e8 86 12 00 00       	call   3892 <exit>
      printf(1, "short read bigfile\n");
    260c:	83 ec 08             	sub    $0x8,%esp
    260f:	68 58 48 00 00       	push   $0x4858
    2614:	6a 01                	push   $0x1
    2616:	e8 d5 13 00 00       	call   39f0 <printf>
      exit();
    261b:	e8 72 12 00 00       	call   3892 <exit>
      printf(1, "read bigfile failed\n");
    2620:	83 ec 08             	sub    $0x8,%esp
    2623:	68 43 48 00 00       	push   $0x4843
    2628:	6a 01                	push   $0x1
    262a:	e8 c1 13 00 00       	call   39f0 <printf>
      exit();
    262f:	e8 5e 12 00 00       	call   3892 <exit>
      printf(1, "write bigfile failed\n");
    2634:	83 ec 08             	sub    $0x8,%esp
    2637:	68 18 48 00 00       	push   $0x4818
    263c:	6a 01                	push   $0x1
    263e:	e8 ad 13 00 00       	call   39f0 <printf>
      exit();
    2643:	e8 4a 12 00 00       	call   3892 <exit>
    printf(1, "cannot open bigfile\n");
    2648:	53                   	push   %ebx
    2649:	53                   	push   %ebx
    264a:	68 2e 48 00 00       	push   $0x482e
    264f:	6a 01                	push   $0x1
    2651:	e8 9a 13 00 00       	call   39f0 <printf>
    exit();
    2656:	e8 37 12 00 00       	call   3892 <exit>
    printf(1, "cannot create bigfile");
    265b:	50                   	push   %eax
    265c:	50                   	push   %eax
    265d:	68 02 48 00 00       	push   $0x4802
    2662:	6a 01                	push   $0x1
    2664:	e8 87 13 00 00       	call   39f0 <printf>
    exit();
    2669:	e8 24 12 00 00       	call   3892 <exit>
    printf(1, "read bigfile wrong total\n");
    266e:	51                   	push   %ecx
    266f:	51                   	push   %ecx
    2670:	68 85 48 00 00       	push   $0x4885
    2675:	6a 01                	push   $0x1
    2677:	e8 74 13 00 00       	call   39f0 <printf>
    exit();
    267c:	e8 11 12 00 00       	call   3892 <exit>
    2681:	eb 0d                	jmp    2690 <fourteen>
    2683:	90                   	nop
    2684:	90                   	nop
    2685:	90                   	nop
    2686:	90                   	nop
    2687:	90                   	nop
    2688:	90                   	nop
    2689:	90                   	nop
    268a:	90                   	nop
    268b:	90                   	nop
    268c:	90                   	nop
    268d:	90                   	nop
    268e:	90                   	nop
    268f:	90                   	nop

00002690 <fourteen>:
{
    2690:	55                   	push   %ebp
    2691:	89 e5                	mov    %esp,%ebp
    2693:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    2696:	68 b0 48 00 00       	push   $0x48b0
    269b:	6a 01                	push   $0x1
    269d:	e8 4e 13 00 00       	call   39f0 <printf>
  if(mkdir("12345678901234") != 0){
    26a2:	c7 04 24 eb 48 00 00 	movl   $0x48eb,(%esp)
    26a9:	e8 4c 12 00 00       	call   38fa <mkdir>
    26ae:	83 c4 10             	add    $0x10,%esp
    26b1:	85 c0                	test   %eax,%eax
    26b3:	0f 85 97 00 00 00    	jne    2750 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    26b9:	83 ec 0c             	sub    $0xc,%esp
    26bc:	68 a8 50 00 00       	push   $0x50a8
    26c1:	e8 34 12 00 00       	call   38fa <mkdir>
    26c6:	83 c4 10             	add    $0x10,%esp
    26c9:	85 c0                	test   %eax,%eax
    26cb:	0f 85 de 00 00 00    	jne    27af <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26d1:	83 ec 08             	sub    $0x8,%esp
    26d4:	68 00 02 00 00       	push   $0x200
    26d9:	68 f8 50 00 00       	push   $0x50f8
    26de:	e8 ef 11 00 00       	call   38d2 <open>
  if(fd < 0){
    26e3:	83 c4 10             	add    $0x10,%esp
    26e6:	85 c0                	test   %eax,%eax
    26e8:	0f 88 ae 00 00 00    	js     279c <fourteen+0x10c>
  close(fd);
    26ee:	83 ec 0c             	sub    $0xc,%esp
    26f1:	50                   	push   %eax
    26f2:	e8 c3 11 00 00       	call   38ba <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    26f7:	58                   	pop    %eax
    26f8:	5a                   	pop    %edx
    26f9:	6a 00                	push   $0x0
    26fb:	68 68 51 00 00       	push   $0x5168
    2700:	e8 cd 11 00 00       	call   38d2 <open>
  if(fd < 0){
    2705:	83 c4 10             	add    $0x10,%esp
    2708:	85 c0                	test   %eax,%eax
    270a:	78 7d                	js     2789 <fourteen+0xf9>
  close(fd);
    270c:	83 ec 0c             	sub    $0xc,%esp
    270f:	50                   	push   %eax
    2710:	e8 a5 11 00 00       	call   38ba <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2715:	c7 04 24 dc 48 00 00 	movl   $0x48dc,(%esp)
    271c:	e8 d9 11 00 00       	call   38fa <mkdir>
    2721:	83 c4 10             	add    $0x10,%esp
    2724:	85 c0                	test   %eax,%eax
    2726:	74 4e                	je     2776 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2728:	83 ec 0c             	sub    $0xc,%esp
    272b:	68 04 52 00 00       	push   $0x5204
    2730:	e8 c5 11 00 00       	call   38fa <mkdir>
    2735:	83 c4 10             	add    $0x10,%esp
    2738:	85 c0                	test   %eax,%eax
    273a:	74 27                	je     2763 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    273c:	83 ec 08             	sub    $0x8,%esp
    273f:	68 fa 48 00 00       	push   $0x48fa
    2744:	6a 01                	push   $0x1
    2746:	e8 a5 12 00 00       	call   39f0 <printf>
}
    274b:	83 c4 10             	add    $0x10,%esp
    274e:	c9                   	leave  
    274f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2750:	50                   	push   %eax
    2751:	50                   	push   %eax
    2752:	68 bf 48 00 00       	push   $0x48bf
    2757:	6a 01                	push   $0x1
    2759:	e8 92 12 00 00       	call   39f0 <printf>
    exit();
    275e:	e8 2f 11 00 00       	call   3892 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2763:	50                   	push   %eax
    2764:	50                   	push   %eax
    2765:	68 24 52 00 00       	push   $0x5224
    276a:	6a 01                	push   $0x1
    276c:	e8 7f 12 00 00       	call   39f0 <printf>
    exit();
    2771:	e8 1c 11 00 00       	call   3892 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2776:	52                   	push   %edx
    2777:	52                   	push   %edx
    2778:	68 d4 51 00 00       	push   $0x51d4
    277d:	6a 01                	push   $0x1
    277f:	e8 6c 12 00 00       	call   39f0 <printf>
    exit();
    2784:	e8 09 11 00 00       	call   3892 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2789:	51                   	push   %ecx
    278a:	51                   	push   %ecx
    278b:	68 98 51 00 00       	push   $0x5198
    2790:	6a 01                	push   $0x1
    2792:	e8 59 12 00 00       	call   39f0 <printf>
    exit();
    2797:	e8 f6 10 00 00       	call   3892 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    279c:	51                   	push   %ecx
    279d:	51                   	push   %ecx
    279e:	68 28 51 00 00       	push   $0x5128
    27a3:	6a 01                	push   $0x1
    27a5:	e8 46 12 00 00       	call   39f0 <printf>
    exit();
    27aa:	e8 e3 10 00 00       	call   3892 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    27af:	50                   	push   %eax
    27b0:	50                   	push   %eax
    27b1:	68 c8 50 00 00       	push   $0x50c8
    27b6:	6a 01                	push   $0x1
    27b8:	e8 33 12 00 00       	call   39f0 <printf>
    exit();
    27bd:	e8 d0 10 00 00       	call   3892 <exit>
    27c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027d0 <rmdot>:
{
    27d0:	55                   	push   %ebp
    27d1:	89 e5                	mov    %esp,%ebp
    27d3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27d6:	68 07 49 00 00       	push   $0x4907
    27db:	6a 01                	push   $0x1
    27dd:	e8 0e 12 00 00       	call   39f0 <printf>
  if(mkdir("dots") != 0){
    27e2:	c7 04 24 13 49 00 00 	movl   $0x4913,(%esp)
    27e9:	e8 0c 11 00 00       	call   38fa <mkdir>
    27ee:	83 c4 10             	add    $0x10,%esp
    27f1:	85 c0                	test   %eax,%eax
    27f3:	0f 85 b0 00 00 00    	jne    28a9 <rmdot+0xd9>
  if(chdir("dots") != 0){
    27f9:	83 ec 0c             	sub    $0xc,%esp
    27fc:	68 13 49 00 00       	push   $0x4913
    2801:	e8 fc 10 00 00       	call   3902 <chdir>
    2806:	83 c4 10             	add    $0x10,%esp
    2809:	85 c0                	test   %eax,%eax
    280b:	0f 85 1d 01 00 00    	jne    292e <rmdot+0x15e>
  if(unlink(".") == 0){
    2811:	83 ec 0c             	sub    $0xc,%esp
    2814:	68 be 45 00 00       	push   $0x45be
    2819:	e8 c4 10 00 00       	call   38e2 <unlink>
    281e:	83 c4 10             	add    $0x10,%esp
    2821:	85 c0                	test   %eax,%eax
    2823:	0f 84 f2 00 00 00    	je     291b <rmdot+0x14b>
  if(unlink("..") == 0){
    2829:	83 ec 0c             	sub    $0xc,%esp
    282c:	68 bd 45 00 00       	push   $0x45bd
    2831:	e8 ac 10 00 00       	call   38e2 <unlink>
    2836:	83 c4 10             	add    $0x10,%esp
    2839:	85 c0                	test   %eax,%eax
    283b:	0f 84 c7 00 00 00    	je     2908 <rmdot+0x138>
  if(chdir("/") != 0){
    2841:	83 ec 0c             	sub    $0xc,%esp
    2844:	68 91 3d 00 00       	push   $0x3d91
    2849:	e8 b4 10 00 00       	call   3902 <chdir>
    284e:	83 c4 10             	add    $0x10,%esp
    2851:	85 c0                	test   %eax,%eax
    2853:	0f 85 9c 00 00 00    	jne    28f5 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2859:	83 ec 0c             	sub    $0xc,%esp
    285c:	68 5b 49 00 00       	push   $0x495b
    2861:	e8 7c 10 00 00       	call   38e2 <unlink>
    2866:	83 c4 10             	add    $0x10,%esp
    2869:	85 c0                	test   %eax,%eax
    286b:	74 75                	je     28e2 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    286d:	83 ec 0c             	sub    $0xc,%esp
    2870:	68 79 49 00 00       	push   $0x4979
    2875:	e8 68 10 00 00       	call   38e2 <unlink>
    287a:	83 c4 10             	add    $0x10,%esp
    287d:	85 c0                	test   %eax,%eax
    287f:	74 4e                	je     28cf <rmdot+0xff>
  if(unlink("dots") != 0){
    2881:	83 ec 0c             	sub    $0xc,%esp
    2884:	68 13 49 00 00       	push   $0x4913
    2889:	e8 54 10 00 00       	call   38e2 <unlink>
    288e:	83 c4 10             	add    $0x10,%esp
    2891:	85 c0                	test   %eax,%eax
    2893:	75 27                	jne    28bc <rmdot+0xec>
  printf(1, "rmdot ok\n");
    2895:	83 ec 08             	sub    $0x8,%esp
    2898:	68 ae 49 00 00       	push   $0x49ae
    289d:	6a 01                	push   $0x1
    289f:	e8 4c 11 00 00       	call   39f0 <printf>
}
    28a4:	83 c4 10             	add    $0x10,%esp
    28a7:	c9                   	leave  
    28a8:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    28a9:	50                   	push   %eax
    28aa:	50                   	push   %eax
    28ab:	68 18 49 00 00       	push   $0x4918
    28b0:	6a 01                	push   $0x1
    28b2:	e8 39 11 00 00       	call   39f0 <printf>
    exit();
    28b7:	e8 d6 0f 00 00       	call   3892 <exit>
    printf(1, "unlink dots failed!\n");
    28bc:	50                   	push   %eax
    28bd:	50                   	push   %eax
    28be:	68 99 49 00 00       	push   $0x4999
    28c3:	6a 01                	push   $0x1
    28c5:	e8 26 11 00 00       	call   39f0 <printf>
    exit();
    28ca:	e8 c3 0f 00 00       	call   3892 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28cf:	52                   	push   %edx
    28d0:	52                   	push   %edx
    28d1:	68 81 49 00 00       	push   $0x4981
    28d6:	6a 01                	push   $0x1
    28d8:	e8 13 11 00 00       	call   39f0 <printf>
    exit();
    28dd:	e8 b0 0f 00 00       	call   3892 <exit>
    printf(1, "unlink dots/. worked!\n");
    28e2:	51                   	push   %ecx
    28e3:	51                   	push   %ecx
    28e4:	68 62 49 00 00       	push   $0x4962
    28e9:	6a 01                	push   $0x1
    28eb:	e8 00 11 00 00       	call   39f0 <printf>
    exit();
    28f0:	e8 9d 0f 00 00       	call   3892 <exit>
    printf(1, "chdir / failed\n");
    28f5:	50                   	push   %eax
    28f6:	50                   	push   %eax
    28f7:	68 93 3d 00 00       	push   $0x3d93
    28fc:	6a 01                	push   $0x1
    28fe:	e8 ed 10 00 00       	call   39f0 <printf>
    exit();
    2903:	e8 8a 0f 00 00       	call   3892 <exit>
    printf(1, "rm .. worked!\n");
    2908:	50                   	push   %eax
    2909:	50                   	push   %eax
    290a:	68 4c 49 00 00       	push   $0x494c
    290f:	6a 01                	push   $0x1
    2911:	e8 da 10 00 00       	call   39f0 <printf>
    exit();
    2916:	e8 77 0f 00 00       	call   3892 <exit>
    printf(1, "rm . worked!\n");
    291b:	50                   	push   %eax
    291c:	50                   	push   %eax
    291d:	68 3e 49 00 00       	push   $0x493e
    2922:	6a 01                	push   $0x1
    2924:	e8 c7 10 00 00       	call   39f0 <printf>
    exit();
    2929:	e8 64 0f 00 00       	call   3892 <exit>
    printf(1, "chdir dots failed\n");
    292e:	50                   	push   %eax
    292f:	50                   	push   %eax
    2930:	68 2b 49 00 00       	push   $0x492b
    2935:	6a 01                	push   $0x1
    2937:	e8 b4 10 00 00       	call   39f0 <printf>
    exit();
    293c:	e8 51 0f 00 00       	call   3892 <exit>
    2941:	eb 0d                	jmp    2950 <dirfile>
    2943:	90                   	nop
    2944:	90                   	nop
    2945:	90                   	nop
    2946:	90                   	nop
    2947:	90                   	nop
    2948:	90                   	nop
    2949:	90                   	nop
    294a:	90                   	nop
    294b:	90                   	nop
    294c:	90                   	nop
    294d:	90                   	nop
    294e:	90                   	nop
    294f:	90                   	nop

00002950 <dirfile>:
{
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	53                   	push   %ebx
    2954:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2957:	68 b8 49 00 00       	push   $0x49b8
    295c:	6a 01                	push   $0x1
    295e:	e8 8d 10 00 00       	call   39f0 <printf>
  fd = open("dirfile", O_CREATE);
    2963:	59                   	pop    %ecx
    2964:	5b                   	pop    %ebx
    2965:	68 00 02 00 00       	push   $0x200
    296a:	68 c5 49 00 00       	push   $0x49c5
    296f:	e8 5e 0f 00 00       	call   38d2 <open>
  if(fd < 0){
    2974:	83 c4 10             	add    $0x10,%esp
    2977:	85 c0                	test   %eax,%eax
    2979:	0f 88 43 01 00 00    	js     2ac2 <dirfile+0x172>
  close(fd);
    297f:	83 ec 0c             	sub    $0xc,%esp
    2982:	50                   	push   %eax
    2983:	e8 32 0f 00 00       	call   38ba <close>
  if(chdir("dirfile") == 0){
    2988:	c7 04 24 c5 49 00 00 	movl   $0x49c5,(%esp)
    298f:	e8 6e 0f 00 00       	call   3902 <chdir>
    2994:	83 c4 10             	add    $0x10,%esp
    2997:	85 c0                	test   %eax,%eax
    2999:	0f 84 10 01 00 00    	je     2aaf <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    299f:	83 ec 08             	sub    $0x8,%esp
    29a2:	6a 00                	push   $0x0
    29a4:	68 fe 49 00 00       	push   $0x49fe
    29a9:	e8 24 0f 00 00       	call   38d2 <open>
  if(fd >= 0){
    29ae:	83 c4 10             	add    $0x10,%esp
    29b1:	85 c0                	test   %eax,%eax
    29b3:	0f 89 e3 00 00 00    	jns    2a9c <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    29b9:	83 ec 08             	sub    $0x8,%esp
    29bc:	68 00 02 00 00       	push   $0x200
    29c1:	68 fe 49 00 00       	push   $0x49fe
    29c6:	e8 07 0f 00 00       	call   38d2 <open>
  if(fd >= 0){
    29cb:	83 c4 10             	add    $0x10,%esp
    29ce:	85 c0                	test   %eax,%eax
    29d0:	0f 89 c6 00 00 00    	jns    2a9c <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    29d6:	83 ec 0c             	sub    $0xc,%esp
    29d9:	68 fe 49 00 00       	push   $0x49fe
    29de:	e8 17 0f 00 00       	call   38fa <mkdir>
    29e3:	83 c4 10             	add    $0x10,%esp
    29e6:	85 c0                	test   %eax,%eax
    29e8:	0f 84 46 01 00 00    	je     2b34 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    29ee:	83 ec 0c             	sub    $0xc,%esp
    29f1:	68 fe 49 00 00       	push   $0x49fe
    29f6:	e8 e7 0e 00 00       	call   38e2 <unlink>
    29fb:	83 c4 10             	add    $0x10,%esp
    29fe:	85 c0                	test   %eax,%eax
    2a00:	0f 84 1b 01 00 00    	je     2b21 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    2a06:	83 ec 08             	sub    $0x8,%esp
    2a09:	68 fe 49 00 00       	push   $0x49fe
    2a0e:	68 62 4a 00 00       	push   $0x4a62
    2a13:	e8 da 0e 00 00       	call   38f2 <link>
    2a18:	83 c4 10             	add    $0x10,%esp
    2a1b:	85 c0                	test   %eax,%eax
    2a1d:	0f 84 eb 00 00 00    	je     2b0e <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a23:	83 ec 0c             	sub    $0xc,%esp
    2a26:	68 c5 49 00 00       	push   $0x49c5
    2a2b:	e8 b2 0e 00 00       	call   38e2 <unlink>
    2a30:	83 c4 10             	add    $0x10,%esp
    2a33:	85 c0                	test   %eax,%eax
    2a35:	0f 85 c0 00 00 00    	jne    2afb <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	6a 02                	push   $0x2
    2a40:	68 be 45 00 00       	push   $0x45be
    2a45:	e8 88 0e 00 00       	call   38d2 <open>
  if(fd >= 0){
    2a4a:	83 c4 10             	add    $0x10,%esp
    2a4d:	85 c0                	test   %eax,%eax
    2a4f:	0f 89 93 00 00 00    	jns    2ae8 <dirfile+0x198>
  fd = open(".", 0);
    2a55:	83 ec 08             	sub    $0x8,%esp
    2a58:	6a 00                	push   $0x0
    2a5a:	68 be 45 00 00       	push   $0x45be
    2a5f:	e8 6e 0e 00 00       	call   38d2 <open>
  if(write(fd, "x", 1) > 0){
    2a64:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", 0);
    2a67:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a69:	6a 01                	push   $0x1
    2a6b:	68 a1 46 00 00       	push   $0x46a1
    2a70:	50                   	push   %eax
    2a71:	e8 3c 0e 00 00       	call   38b2 <write>
    2a76:	83 c4 10             	add    $0x10,%esp
    2a79:	85 c0                	test   %eax,%eax
    2a7b:	7f 58                	jg     2ad5 <dirfile+0x185>
  close(fd);
    2a7d:	83 ec 0c             	sub    $0xc,%esp
    2a80:	53                   	push   %ebx
    2a81:	e8 34 0e 00 00       	call   38ba <close>
  printf(1, "dir vs file OK\n");
    2a86:	58                   	pop    %eax
    2a87:	5a                   	pop    %edx
    2a88:	68 95 4a 00 00       	push   $0x4a95
    2a8d:	6a 01                	push   $0x1
    2a8f:	e8 5c 0f 00 00       	call   39f0 <printf>
}
    2a94:	83 c4 10             	add    $0x10,%esp
    2a97:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a9a:	c9                   	leave  
    2a9b:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2a9c:	50                   	push   %eax
    2a9d:	50                   	push   %eax
    2a9e:	68 09 4a 00 00       	push   $0x4a09
    2aa3:	6a 01                	push   $0x1
    2aa5:	e8 46 0f 00 00       	call   39f0 <printf>
    exit();
    2aaa:	e8 e3 0d 00 00       	call   3892 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2aaf:	50                   	push   %eax
    2ab0:	50                   	push   %eax
    2ab1:	68 e4 49 00 00       	push   $0x49e4
    2ab6:	6a 01                	push   $0x1
    2ab8:	e8 33 0f 00 00       	call   39f0 <printf>
    exit();
    2abd:	e8 d0 0d 00 00       	call   3892 <exit>
    printf(1, "create dirfile failed\n");
    2ac2:	52                   	push   %edx
    2ac3:	52                   	push   %edx
    2ac4:	68 cd 49 00 00       	push   $0x49cd
    2ac9:	6a 01                	push   $0x1
    2acb:	e8 20 0f 00 00       	call   39f0 <printf>
    exit();
    2ad0:	e8 bd 0d 00 00       	call   3892 <exit>
    printf(1, "write . succeeded!\n");
    2ad5:	51                   	push   %ecx
    2ad6:	51                   	push   %ecx
    2ad7:	68 81 4a 00 00       	push   $0x4a81
    2adc:	6a 01                	push   $0x1
    2ade:	e8 0d 0f 00 00       	call   39f0 <printf>
    exit();
    2ae3:	e8 aa 0d 00 00       	call   3892 <exit>
    printf(1, "open . for writing succeeded!\n");
    2ae8:	53                   	push   %ebx
    2ae9:	53                   	push   %ebx
    2aea:	68 78 52 00 00       	push   $0x5278
    2aef:	6a 01                	push   $0x1
    2af1:	e8 fa 0e 00 00       	call   39f0 <printf>
    exit();
    2af6:	e8 97 0d 00 00       	call   3892 <exit>
    printf(1, "unlink dirfile failed!\n");
    2afb:	50                   	push   %eax
    2afc:	50                   	push   %eax
    2afd:	68 69 4a 00 00       	push   $0x4a69
    2b02:	6a 01                	push   $0x1
    2b04:	e8 e7 0e 00 00       	call   39f0 <printf>
    exit();
    2b09:	e8 84 0d 00 00       	call   3892 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b0e:	50                   	push   %eax
    2b0f:	50                   	push   %eax
    2b10:	68 58 52 00 00       	push   $0x5258
    2b15:	6a 01                	push   $0x1
    2b17:	e8 d4 0e 00 00       	call   39f0 <printf>
    exit();
    2b1c:	e8 71 0d 00 00       	call   3892 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b21:	50                   	push   %eax
    2b22:	50                   	push   %eax
    2b23:	68 44 4a 00 00       	push   $0x4a44
    2b28:	6a 01                	push   $0x1
    2b2a:	e8 c1 0e 00 00       	call   39f0 <printf>
    exit();
    2b2f:	e8 5e 0d 00 00       	call   3892 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b34:	50                   	push   %eax
    2b35:	50                   	push   %eax
    2b36:	68 27 4a 00 00       	push   $0x4a27
    2b3b:	6a 01                	push   $0x1
    2b3d:	e8 ae 0e 00 00       	call   39f0 <printf>
    exit();
    2b42:	e8 4b 0d 00 00       	call   3892 <exit>
    2b47:	89 f6                	mov    %esi,%esi
    2b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b50 <iref>:
{
    2b50:	55                   	push   %ebp
    2b51:	89 e5                	mov    %esp,%ebp
    2b53:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b54:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b59:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b5c:	68 a5 4a 00 00       	push   $0x4aa5
    2b61:	6a 01                	push   $0x1
    2b63:	e8 88 0e 00 00       	call   39f0 <printf>
    2b68:	83 c4 10             	add    $0x10,%esp
    2b6b:	90                   	nop
    2b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2b70:	83 ec 0c             	sub    $0xc,%esp
    2b73:	68 b6 4a 00 00       	push   $0x4ab6
    2b78:	e8 7d 0d 00 00       	call   38fa <mkdir>
    2b7d:	83 c4 10             	add    $0x10,%esp
    2b80:	85 c0                	test   %eax,%eax
    2b82:	0f 85 bb 00 00 00    	jne    2c43 <iref+0xf3>
    if(chdir("irefd") != 0){
    2b88:	83 ec 0c             	sub    $0xc,%esp
    2b8b:	68 b6 4a 00 00       	push   $0x4ab6
    2b90:	e8 6d 0d 00 00       	call   3902 <chdir>
    2b95:	83 c4 10             	add    $0x10,%esp
    2b98:	85 c0                	test   %eax,%eax
    2b9a:	0f 85 b7 00 00 00    	jne    2c57 <iref+0x107>
    mkdir("");
    2ba0:	83 ec 0c             	sub    $0xc,%esp
    2ba3:	68 6b 41 00 00       	push   $0x416b
    2ba8:	e8 4d 0d 00 00       	call   38fa <mkdir>
    link("README", "");
    2bad:	59                   	pop    %ecx
    2bae:	58                   	pop    %eax
    2baf:	68 6b 41 00 00       	push   $0x416b
    2bb4:	68 62 4a 00 00       	push   $0x4a62
    2bb9:	e8 34 0d 00 00       	call   38f2 <link>
    fd = open("", O_CREATE);
    2bbe:	58                   	pop    %eax
    2bbf:	5a                   	pop    %edx
    2bc0:	68 00 02 00 00       	push   $0x200
    2bc5:	68 6b 41 00 00       	push   $0x416b
    2bca:	e8 03 0d 00 00       	call   38d2 <open>
    if(fd >= 0)
    2bcf:	83 c4 10             	add    $0x10,%esp
    2bd2:	85 c0                	test   %eax,%eax
    2bd4:	78 0c                	js     2be2 <iref+0x92>
      close(fd);
    2bd6:	83 ec 0c             	sub    $0xc,%esp
    2bd9:	50                   	push   %eax
    2bda:	e8 db 0c 00 00       	call   38ba <close>
    2bdf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2be2:	83 ec 08             	sub    $0x8,%esp
    2be5:	68 00 02 00 00       	push   $0x200
    2bea:	68 a0 46 00 00       	push   $0x46a0
    2bef:	e8 de 0c 00 00       	call   38d2 <open>
    if(fd >= 0)
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	85 c0                	test   %eax,%eax
    2bf9:	78 0c                	js     2c07 <iref+0xb7>
      close(fd);
    2bfb:	83 ec 0c             	sub    $0xc,%esp
    2bfe:	50                   	push   %eax
    2bff:	e8 b6 0c 00 00       	call   38ba <close>
    2c04:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2c07:	83 ec 0c             	sub    $0xc,%esp
    2c0a:	68 a0 46 00 00       	push   $0x46a0
    2c0f:	e8 ce 0c 00 00       	call   38e2 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2c14:	83 c4 10             	add    $0x10,%esp
    2c17:	83 eb 01             	sub    $0x1,%ebx
    2c1a:	0f 85 50 ff ff ff    	jne    2b70 <iref+0x20>
  chdir("/");
    2c20:	83 ec 0c             	sub    $0xc,%esp
    2c23:	68 91 3d 00 00       	push   $0x3d91
    2c28:	e8 d5 0c 00 00       	call   3902 <chdir>
  printf(1, "empty file name OK\n");
    2c2d:	58                   	pop    %eax
    2c2e:	5a                   	pop    %edx
    2c2f:	68 e4 4a 00 00       	push   $0x4ae4
    2c34:	6a 01                	push   $0x1
    2c36:	e8 b5 0d 00 00       	call   39f0 <printf>
}
    2c3b:	83 c4 10             	add    $0x10,%esp
    2c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c41:	c9                   	leave  
    2c42:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c43:	83 ec 08             	sub    $0x8,%esp
    2c46:	68 bc 4a 00 00       	push   $0x4abc
    2c4b:	6a 01                	push   $0x1
    2c4d:	e8 9e 0d 00 00       	call   39f0 <printf>
      exit();
    2c52:	e8 3b 0c 00 00       	call   3892 <exit>
      printf(1, "chdir irefd failed\n");
    2c57:	83 ec 08             	sub    $0x8,%esp
    2c5a:	68 d0 4a 00 00       	push   $0x4ad0
    2c5f:	6a 01                	push   $0x1
    2c61:	e8 8a 0d 00 00       	call   39f0 <printf>
      exit();
    2c66:	e8 27 0c 00 00       	call   3892 <exit>
    2c6b:	90                   	nop
    2c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c70 <forktest>:
{
    2c70:	55                   	push   %ebp
    2c71:	89 e5                	mov    %esp,%ebp
    2c73:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2c74:	31 db                	xor    %ebx,%ebx
{
    2c76:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2c79:	68 f8 4a 00 00       	push   $0x4af8
    2c7e:	6a 01                	push   $0x1
    2c80:	e8 6b 0d 00 00       	call   39f0 <printf>
    2c85:	83 c4 10             	add    $0x10,%esp
    2c88:	eb 13                	jmp    2c9d <forktest+0x2d>
    2c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2c90:	74 62                	je     2cf4 <forktest+0x84>
  for(n=0; n<1000; n++){
    2c92:	83 c3 01             	add    $0x1,%ebx
    2c95:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2c9b:	74 43                	je     2ce0 <forktest+0x70>
    pid = fork();
    2c9d:	e8 e8 0b 00 00       	call   388a <fork>
    if(pid < 0)
    2ca2:	85 c0                	test   %eax,%eax
    2ca4:	79 ea                	jns    2c90 <forktest+0x20>
  for(; n > 0; n--){
    2ca6:	85 db                	test   %ebx,%ebx
    2ca8:	74 14                	je     2cbe <forktest+0x4e>
    2caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2cb0:	e8 e5 0b 00 00       	call   389a <wait>
    2cb5:	85 c0                	test   %eax,%eax
    2cb7:	78 40                	js     2cf9 <forktest+0x89>
  for(; n > 0; n--){
    2cb9:	83 eb 01             	sub    $0x1,%ebx
    2cbc:	75 f2                	jne    2cb0 <forktest+0x40>
  if(wait() != -1){
    2cbe:	e8 d7 0b 00 00       	call   389a <wait>
    2cc3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2cc6:	75 45                	jne    2d0d <forktest+0x9d>
  printf(1, "fork test OK\n");
    2cc8:	83 ec 08             	sub    $0x8,%esp
    2ccb:	68 2a 4b 00 00       	push   $0x4b2a
    2cd0:	6a 01                	push   $0x1
    2cd2:	e8 19 0d 00 00       	call   39f0 <printf>
}
    2cd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cda:	c9                   	leave  
    2cdb:	c3                   	ret    
    2cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fork claimed to work 1000 times!\n");
    2ce0:	83 ec 08             	sub    $0x8,%esp
    2ce3:	68 98 52 00 00       	push   $0x5298
    2ce8:	6a 01                	push   $0x1
    2cea:	e8 01 0d 00 00       	call   39f0 <printf>
    exit();
    2cef:	e8 9e 0b 00 00       	call   3892 <exit>
      exit();
    2cf4:	e8 99 0b 00 00       	call   3892 <exit>
      printf(1, "wait stopped early\n");
    2cf9:	83 ec 08             	sub    $0x8,%esp
    2cfc:	68 03 4b 00 00       	push   $0x4b03
    2d01:	6a 01                	push   $0x1
    2d03:	e8 e8 0c 00 00       	call   39f0 <printf>
      exit();
    2d08:	e8 85 0b 00 00       	call   3892 <exit>
    printf(1, "wait got too many\n");
    2d0d:	50                   	push   %eax
    2d0e:	50                   	push   %eax
    2d0f:	68 17 4b 00 00       	push   $0x4b17
    2d14:	6a 01                	push   $0x1
    2d16:	e8 d5 0c 00 00       	call   39f0 <printf>
    exit();
    2d1b:	e8 72 0b 00 00       	call   3892 <exit>

00002d20 <sbrktest>:
{
    2d20:	55                   	push   %ebp
    2d21:	89 e5                	mov    %esp,%ebp
    2d23:	57                   	push   %edi
    2d24:	56                   	push   %esi
    2d25:	53                   	push   %ebx
  for(i = 0; i < 5000; i++){
    2d26:	31 ff                	xor    %edi,%edi
{
    2d28:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2d2b:	68 38 4b 00 00       	push   $0x4b38
    2d30:	ff 35 f8 5d 00 00    	pushl  0x5df8
    2d36:	e8 b5 0c 00 00       	call   39f0 <printf>
  oldbrk = sbrk(0);
    2d3b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d42:	e8 d3 0b 00 00       	call   391a <sbrk>
  a = sbrk(0);
    2d47:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d4e:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    2d50:	e8 c5 0b 00 00       	call   391a <sbrk>
    2d55:	83 c4 10             	add    $0x10,%esp
    2d58:	89 c6                	mov    %eax,%esi
    2d5a:	eb 06                	jmp    2d62 <sbrktest+0x42>
    2d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    2d60:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    2d62:	83 ec 0c             	sub    $0xc,%esp
    2d65:	6a 01                	push   $0x1
    2d67:	e8 ae 0b 00 00       	call   391a <sbrk>
    if(b != a){
    2d6c:	83 c4 10             	add    $0x10,%esp
    2d6f:	39 f0                	cmp    %esi,%eax
    2d71:	0f 85 62 02 00 00    	jne    2fd9 <sbrktest+0x2b9>
  for(i = 0; i < 5000; i++){
    2d77:	83 c7 01             	add    $0x1,%edi
    *b = 1;
    2d7a:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    2d7d:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    2d80:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2d86:	75 d8                	jne    2d60 <sbrktest+0x40>
  pid = fork();
    2d88:	e8 fd 0a 00 00       	call   388a <fork>
  if(pid < 0){
    2d8d:	85 c0                	test   %eax,%eax
  pid = fork();
    2d8f:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2d91:	0f 88 82 03 00 00    	js     3119 <sbrktest+0x3f9>
  c = sbrk(1);
    2d97:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2d9a:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    2d9d:	6a 01                	push   $0x1
    2d9f:	e8 76 0b 00 00       	call   391a <sbrk>
  c = sbrk(1);
    2da4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dab:	e8 6a 0b 00 00       	call   391a <sbrk>
  if(c != a + 1){
    2db0:	83 c4 10             	add    $0x10,%esp
    2db3:	39 f0                	cmp    %esi,%eax
    2db5:	0f 85 47 03 00 00    	jne    3102 <sbrktest+0x3e2>
  if(pid == 0)
    2dbb:	85 ff                	test   %edi,%edi
    2dbd:	0f 84 3a 03 00 00    	je     30fd <sbrktest+0x3dd>
  wait();
    2dc3:	e8 d2 0a 00 00       	call   389a <wait>
  a = sbrk(0);
    2dc8:	83 ec 0c             	sub    $0xc,%esp
    2dcb:	6a 00                	push   $0x0
    2dcd:	e8 48 0b 00 00       	call   391a <sbrk>
    2dd2:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    2dd4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2dd9:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    2ddb:	89 04 24             	mov    %eax,(%esp)
    2dde:	e8 37 0b 00 00       	call   391a <sbrk>
  if (p != a) {
    2de3:	83 c4 10             	add    $0x10,%esp
    2de6:	39 c6                	cmp    %eax,%esi
    2de8:	0f 85 f8 02 00 00    	jne    30e6 <sbrktest+0x3c6>
  a = sbrk(0);
    2dee:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2df1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2df8:	6a 00                	push   $0x0
    2dfa:	e8 1b 0b 00 00       	call   391a <sbrk>
  c = sbrk(-4096);
    2dff:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2e06:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    2e08:	e8 0d 0b 00 00       	call   391a <sbrk>
  if(c == (char*)0xffffffff){
    2e0d:	83 c4 10             	add    $0x10,%esp
    2e10:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e13:	0f 84 b6 02 00 00    	je     30cf <sbrktest+0x3af>
  c = sbrk(0);
    2e19:	83 ec 0c             	sub    $0xc,%esp
    2e1c:	6a 00                	push   $0x0
    2e1e:	e8 f7 0a 00 00       	call   391a <sbrk>
  if(c != a - 4096){
    2e23:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e29:	83 c4 10             	add    $0x10,%esp
    2e2c:	39 d0                	cmp    %edx,%eax
    2e2e:	0f 85 84 02 00 00    	jne    30b8 <sbrktest+0x398>
  a = sbrk(0);
    2e34:	83 ec 0c             	sub    $0xc,%esp
    2e37:	6a 00                	push   $0x0
    2e39:	e8 dc 0a 00 00       	call   391a <sbrk>
    2e3e:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    2e40:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e47:	e8 ce 0a 00 00       	call   391a <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e4c:	83 c4 10             	add    $0x10,%esp
    2e4f:	39 c6                	cmp    %eax,%esi
  c = sbrk(4096);
    2e51:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2e53:	0f 85 48 02 00 00    	jne    30a1 <sbrktest+0x381>
    2e59:	83 ec 0c             	sub    $0xc,%esp
    2e5c:	6a 00                	push   $0x0
    2e5e:	e8 b7 0a 00 00       	call   391a <sbrk>
    2e63:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e69:	83 c4 10             	add    $0x10,%esp
    2e6c:	39 d0                	cmp    %edx,%eax
    2e6e:	0f 85 2d 02 00 00    	jne    30a1 <sbrktest+0x381>
  if(*lastaddr == 99){
    2e74:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e7b:	0f 84 09 02 00 00    	je     308a <sbrktest+0x36a>
  a = sbrk(0);
    2e81:	83 ec 0c             	sub    $0xc,%esp
    2e84:	6a 00                	push   $0x0
    2e86:	e8 8f 0a 00 00       	call   391a <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e8b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2e92:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    2e94:	e8 81 0a 00 00       	call   391a <sbrk>
    2e99:	89 d9                	mov    %ebx,%ecx
    2e9b:	29 c1                	sub    %eax,%ecx
    2e9d:	89 0c 24             	mov    %ecx,(%esp)
    2ea0:	e8 75 0a 00 00       	call   391a <sbrk>
  if(c != a){
    2ea5:	83 c4 10             	add    $0x10,%esp
    2ea8:	39 c6                	cmp    %eax,%esi
    2eaa:	0f 85 c3 01 00 00    	jne    3073 <sbrktest+0x353>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eb0:	be 00 00 00 80       	mov    $0x80000000,%esi
    ppid = getpid();
    2eb5:	e8 58 0a 00 00       	call   3912 <getpid>
    2eba:	89 c7                	mov    %eax,%edi
    pid = fork();
    2ebc:	e8 c9 09 00 00       	call   388a <fork>
    if(pid < 0){
    2ec1:	85 c0                	test   %eax,%eax
    2ec3:	0f 88 93 01 00 00    	js     305c <sbrktest+0x33c>
    if(pid == 0){
    2ec9:	0f 84 6b 01 00 00    	je     303a <sbrktest+0x31a>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2ecf:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    wait();
    2ed5:	e8 c0 09 00 00       	call   389a <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eda:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2ee0:	75 d3                	jne    2eb5 <sbrktest+0x195>
  if(pipe(fds) != 0){
    2ee2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ee5:	83 ec 0c             	sub    $0xc,%esp
    2ee8:	50                   	push   %eax
    2ee9:	e8 b4 09 00 00       	call   38a2 <pipe>
    2eee:	83 c4 10             	add    $0x10,%esp
    2ef1:	85 c0                	test   %eax,%eax
    2ef3:	0f 85 2e 01 00 00    	jne    3027 <sbrktest+0x307>
    2ef9:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2efc:	89 fe                	mov    %edi,%esi
    2efe:	eb 23                	jmp    2f23 <sbrktest+0x203>
    if(pids[i] != -1)
    2f00:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f03:	74 14                	je     2f19 <sbrktest+0x1f9>
      read(fds[0], &scratch, 1);
    2f05:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2f08:	83 ec 04             	sub    $0x4,%esp
    2f0b:	6a 01                	push   $0x1
    2f0d:	50                   	push   %eax
    2f0e:	ff 75 b8             	pushl  -0x48(%ebp)
    2f11:	e8 94 09 00 00       	call   38aa <read>
    2f16:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f19:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2f1c:	83 c6 04             	add    $0x4,%esi
    2f1f:	39 c6                	cmp    %eax,%esi
    2f21:	74 4f                	je     2f72 <sbrktest+0x252>
    if((pids[i] = fork()) == 0){
    2f23:	e8 62 09 00 00       	call   388a <fork>
    2f28:	85 c0                	test   %eax,%eax
    2f2a:	89 06                	mov    %eax,(%esi)
    2f2c:	75 d2                	jne    2f00 <sbrktest+0x1e0>
      sbrk(BIG - (uint)sbrk(0));
    2f2e:	83 ec 0c             	sub    $0xc,%esp
    2f31:	6a 00                	push   $0x0
    2f33:	e8 e2 09 00 00       	call   391a <sbrk>
    2f38:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f3d:	29 c2                	sub    %eax,%edx
    2f3f:	89 14 24             	mov    %edx,(%esp)
    2f42:	e8 d3 09 00 00       	call   391a <sbrk>
      write(fds[1], "x", 1);
    2f47:	83 c4 0c             	add    $0xc,%esp
    2f4a:	6a 01                	push   $0x1
    2f4c:	68 a1 46 00 00       	push   $0x46a1
    2f51:	ff 75 bc             	pushl  -0x44(%ebp)
    2f54:	e8 59 09 00 00       	call   38b2 <write>
    2f59:	83 c4 10             	add    $0x10,%esp
    2f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(;;) sleep(1000);
    2f60:	83 ec 0c             	sub    $0xc,%esp
    2f63:	68 e8 03 00 00       	push   $0x3e8
    2f68:	e8 b5 09 00 00       	call   3922 <sleep>
    2f6d:	83 c4 10             	add    $0x10,%esp
    2f70:	eb ee                	jmp    2f60 <sbrktest+0x240>
  c = sbrk(4096);
    2f72:	83 ec 0c             	sub    $0xc,%esp
    2f75:	68 00 10 00 00       	push   $0x1000
    2f7a:	e8 9b 09 00 00       	call   391a <sbrk>
    2f7f:	83 c4 10             	add    $0x10,%esp
    2f82:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    if(pids[i] == -1)
    2f85:	8b 07                	mov    (%edi),%eax
    2f87:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f8a:	74 11                	je     2f9d <sbrktest+0x27d>
    kill(pids[i]);
    2f8c:	83 ec 0c             	sub    $0xc,%esp
    2f8f:	50                   	push   %eax
    2f90:	e8 2d 09 00 00       	call   38c2 <kill>
    wait();
    2f95:	e8 00 09 00 00       	call   389a <wait>
    2f9a:	83 c4 10             	add    $0x10,%esp
    2f9d:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2fa0:	39 fe                	cmp    %edi,%esi
    2fa2:	75 e1                	jne    2f85 <sbrktest+0x265>
  if(c == (char*)0xffffffff){
    2fa4:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2fa8:	74 66                	je     3010 <sbrktest+0x2f0>
  if(sbrk(0) > oldbrk)
    2faa:	83 ec 0c             	sub    $0xc,%esp
    2fad:	6a 00                	push   $0x0
    2faf:	e8 66 09 00 00       	call   391a <sbrk>
    2fb4:	83 c4 10             	add    $0x10,%esp
    2fb7:	39 d8                	cmp    %ebx,%eax
    2fb9:	77 3c                	ja     2ff7 <sbrktest+0x2d7>
  printf(stdout, "sbrk test OK\n");
    2fbb:	83 ec 08             	sub    $0x8,%esp
    2fbe:	68 e0 4b 00 00       	push   $0x4be0
    2fc3:	ff 35 f8 5d 00 00    	pushl  0x5df8
    2fc9:	e8 22 0a 00 00       	call   39f0 <printf>
}
    2fce:	83 c4 10             	add    $0x10,%esp
    2fd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fd4:	5b                   	pop    %ebx
    2fd5:	5e                   	pop    %esi
    2fd6:	5f                   	pop    %edi
    2fd7:	5d                   	pop    %ebp
    2fd8:	c3                   	ret    
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2fd9:	83 ec 0c             	sub    $0xc,%esp
    2fdc:	50                   	push   %eax
    2fdd:	56                   	push   %esi
    2fde:	57                   	push   %edi
    2fdf:	68 43 4b 00 00       	push   $0x4b43
    2fe4:	ff 35 f8 5d 00 00    	pushl  0x5df8
    2fea:	e8 01 0a 00 00       	call   39f0 <printf>
      exit();
    2fef:	83 c4 20             	add    $0x20,%esp
    2ff2:	e8 9b 08 00 00       	call   3892 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    2ff7:	83 ec 0c             	sub    $0xc,%esp
    2ffa:	6a 00                	push   $0x0
    2ffc:	e8 19 09 00 00       	call   391a <sbrk>
    3001:	29 c3                	sub    %eax,%ebx
    3003:	89 1c 24             	mov    %ebx,(%esp)
    3006:	e8 0f 09 00 00       	call   391a <sbrk>
    300b:	83 c4 10             	add    $0x10,%esp
    300e:	eb ab                	jmp    2fbb <sbrktest+0x29b>
    printf(stdout, "failed sbrk leaked memory\n");
    3010:	50                   	push   %eax
    3011:	50                   	push   %eax
    3012:	68 c5 4b 00 00       	push   $0x4bc5
    3017:	ff 35 f8 5d 00 00    	pushl  0x5df8
    301d:	e8 ce 09 00 00       	call   39f0 <printf>
    exit();
    3022:	e8 6b 08 00 00       	call   3892 <exit>
    printf(1, "pipe() failed\n");
    3027:	52                   	push   %edx
    3028:	52                   	push   %edx
    3029:	68 81 40 00 00       	push   $0x4081
    302e:	6a 01                	push   $0x1
    3030:	e8 bb 09 00 00       	call   39f0 <printf>
    exit();
    3035:	e8 58 08 00 00       	call   3892 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    303a:	0f be 06             	movsbl (%esi),%eax
    303d:	50                   	push   %eax
    303e:	56                   	push   %esi
    303f:	68 ac 4b 00 00       	push   $0x4bac
    3044:	ff 35 f8 5d 00 00    	pushl  0x5df8
    304a:	e8 a1 09 00 00       	call   39f0 <printf>
      kill(ppid);
    304f:	89 3c 24             	mov    %edi,(%esp)
    3052:	e8 6b 08 00 00       	call   38c2 <kill>
      exit();
    3057:	e8 36 08 00 00       	call   3892 <exit>
      printf(stdout, "fork failed\n");
    305c:	51                   	push   %ecx
    305d:	51                   	push   %ecx
    305e:	68 89 4c 00 00       	push   $0x4c89
    3063:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3069:	e8 82 09 00 00       	call   39f0 <printf>
      exit();
    306e:	e8 1f 08 00 00       	call   3892 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3073:	50                   	push   %eax
    3074:	56                   	push   %esi
    3075:	68 8c 53 00 00       	push   $0x538c
    307a:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3080:	e8 6b 09 00 00       	call   39f0 <printf>
    exit();
    3085:	e8 08 08 00 00       	call   3892 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    308a:	53                   	push   %ebx
    308b:	53                   	push   %ebx
    308c:	68 5c 53 00 00       	push   $0x535c
    3091:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3097:	e8 54 09 00 00       	call   39f0 <printf>
    exit();
    309c:	e8 f1 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    30a1:	57                   	push   %edi
    30a2:	56                   	push   %esi
    30a3:	68 34 53 00 00       	push   $0x5334
    30a8:	ff 35 f8 5d 00 00    	pushl  0x5df8
    30ae:	e8 3d 09 00 00       	call   39f0 <printf>
    exit();
    30b3:	e8 da 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    30b8:	50                   	push   %eax
    30b9:	56                   	push   %esi
    30ba:	68 fc 52 00 00       	push   $0x52fc
    30bf:	ff 35 f8 5d 00 00    	pushl  0x5df8
    30c5:	e8 26 09 00 00       	call   39f0 <printf>
    exit();
    30ca:	e8 c3 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    30cf:	56                   	push   %esi
    30d0:	56                   	push   %esi
    30d1:	68 91 4b 00 00       	push   $0x4b91
    30d6:	ff 35 f8 5d 00 00    	pushl  0x5df8
    30dc:	e8 0f 09 00 00       	call   39f0 <printf>
    exit();
    30e1:	e8 ac 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    30e6:	57                   	push   %edi
    30e7:	57                   	push   %edi
    30e8:	68 bc 52 00 00       	push   $0x52bc
    30ed:	ff 35 f8 5d 00 00    	pushl  0x5df8
    30f3:	e8 f8 08 00 00       	call   39f0 <printf>
    exit();
    30f8:	e8 95 07 00 00       	call   3892 <exit>
    exit();
    30fd:	e8 90 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    3102:	50                   	push   %eax
    3103:	50                   	push   %eax
    3104:	68 75 4b 00 00       	push   $0x4b75
    3109:	ff 35 f8 5d 00 00    	pushl  0x5df8
    310f:	e8 dc 08 00 00       	call   39f0 <printf>
    exit();
    3114:	e8 79 07 00 00       	call   3892 <exit>
    printf(stdout, "sbrk test fork failed\n");
    3119:	50                   	push   %eax
    311a:	50                   	push   %eax
    311b:	68 5e 4b 00 00       	push   $0x4b5e
    3120:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3126:	e8 c5 08 00 00       	call   39f0 <printf>
    exit();
    312b:	e8 62 07 00 00       	call   3892 <exit>

00003130 <validateint>:
{
    3130:	55                   	push   %ebp
    3131:	89 e5                	mov    %esp,%ebp
}
    3133:	5d                   	pop    %ebp
    3134:	c3                   	ret    
    3135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003140 <validatetest>:
{
    3140:	55                   	push   %ebp
    3141:	89 e5                	mov    %esp,%ebp
    3143:	56                   	push   %esi
    3144:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    3145:	31 db                	xor    %ebx,%ebx
  printf(stdout, "validate test\n");
    3147:	83 ec 08             	sub    $0x8,%esp
    314a:	68 ee 4b 00 00       	push   $0x4bee
    314f:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3155:	e8 96 08 00 00       	call   39f0 <printf>
    315a:	83 c4 10             	add    $0x10,%esp
    315d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3160:	e8 25 07 00 00       	call   388a <fork>
    3165:	85 c0                	test   %eax,%eax
    3167:	89 c6                	mov    %eax,%esi
    3169:	74 63                	je     31ce <validatetest+0x8e>
    sleep(0);
    316b:	83 ec 0c             	sub    $0xc,%esp
    316e:	6a 00                	push   $0x0
    3170:	e8 ad 07 00 00       	call   3922 <sleep>
    sleep(0);
    3175:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    317c:	e8 a1 07 00 00       	call   3922 <sleep>
    kill(pid);
    3181:	89 34 24             	mov    %esi,(%esp)
    3184:	e8 39 07 00 00       	call   38c2 <kill>
    wait();
    3189:	e8 0c 07 00 00       	call   389a <wait>
    if(link("nosuchfile", (char*)p) != -1){
    318e:	58                   	pop    %eax
    318f:	5a                   	pop    %edx
    3190:	53                   	push   %ebx
    3191:	68 fd 4b 00 00       	push   $0x4bfd
    3196:	e8 57 07 00 00       	call   38f2 <link>
    319b:	83 c4 10             	add    $0x10,%esp
    319e:	83 f8 ff             	cmp    $0xffffffff,%eax
    31a1:	75 30                	jne    31d3 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    31a3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    31a9:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    31af:	75 af                	jne    3160 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    31b1:	83 ec 08             	sub    $0x8,%esp
    31b4:	68 21 4c 00 00       	push   $0x4c21
    31b9:	ff 35 f8 5d 00 00    	pushl  0x5df8
    31bf:	e8 2c 08 00 00       	call   39f0 <printf>
}
    31c4:	83 c4 10             	add    $0x10,%esp
    31c7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31ca:	5b                   	pop    %ebx
    31cb:	5e                   	pop    %esi
    31cc:	5d                   	pop    %ebp
    31cd:	c3                   	ret    
      exit();
    31ce:	e8 bf 06 00 00       	call   3892 <exit>
      printf(stdout, "link should not succeed\n");
    31d3:	83 ec 08             	sub    $0x8,%esp
    31d6:	68 08 4c 00 00       	push   $0x4c08
    31db:	ff 35 f8 5d 00 00    	pushl  0x5df8
    31e1:	e8 0a 08 00 00       	call   39f0 <printf>
      exit();
    31e6:	e8 a7 06 00 00       	call   3892 <exit>
    31eb:	90                   	nop
    31ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000031f0 <bsstest>:
{
    31f0:	55                   	push   %ebp
    31f1:	89 e5                	mov    %esp,%ebp
    31f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    31f6:	68 2e 4c 00 00       	push   $0x4c2e
    31fb:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3201:	e8 ea 07 00 00       	call   39f0 <printf>
    if(uninit[i] != '\0'){
    3206:	83 c4 10             	add    $0x10,%esp
    3209:	80 3d c0 5e 00 00 00 	cmpb   $0x0,0x5ec0
    3210:	75 39                	jne    324b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3212:	b8 01 00 00 00       	mov    $0x1,%eax
    3217:	89 f6                	mov    %esi,%esi
    3219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(uninit[i] != '\0'){
    3220:	80 b8 c0 5e 00 00 00 	cmpb   $0x0,0x5ec0(%eax)
    3227:	75 22                	jne    324b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3229:	83 c0 01             	add    $0x1,%eax
    322c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3231:	75 ed                	jne    3220 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    3233:	83 ec 08             	sub    $0x8,%esp
    3236:	68 49 4c 00 00       	push   $0x4c49
    323b:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3241:	e8 aa 07 00 00       	call   39f0 <printf>
}
    3246:	83 c4 10             	add    $0x10,%esp
    3249:	c9                   	leave  
    324a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    324b:	83 ec 08             	sub    $0x8,%esp
    324e:	68 38 4c 00 00       	push   $0x4c38
    3253:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3259:	e8 92 07 00 00       	call   39f0 <printf>
      exit();
    325e:	e8 2f 06 00 00       	call   3892 <exit>
    3263:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003270 <bigargtest>:
{
    3270:	55                   	push   %ebp
    3271:	89 e5                	mov    %esp,%ebp
    3273:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3276:	68 56 4c 00 00       	push   $0x4c56
    327b:	e8 62 06 00 00       	call   38e2 <unlink>
  pid = fork();
    3280:	e8 05 06 00 00       	call   388a <fork>
  if(pid == 0){
    3285:	83 c4 10             	add    $0x10,%esp
    3288:	85 c0                	test   %eax,%eax
    328a:	74 3f                	je     32cb <bigargtest+0x5b>
  } else if(pid < 0){
    328c:	0f 88 c2 00 00 00    	js     3354 <bigargtest+0xe4>
  wait();
    3292:	e8 03 06 00 00       	call   389a <wait>
  fd = open("bigarg-ok", 0);
    3297:	83 ec 08             	sub    $0x8,%esp
    329a:	6a 00                	push   $0x0
    329c:	68 56 4c 00 00       	push   $0x4c56
    32a1:	e8 2c 06 00 00       	call   38d2 <open>
  if(fd < 0){
    32a6:	83 c4 10             	add    $0x10,%esp
    32a9:	85 c0                	test   %eax,%eax
    32ab:	0f 88 8c 00 00 00    	js     333d <bigargtest+0xcd>
  close(fd);
    32b1:	83 ec 0c             	sub    $0xc,%esp
    32b4:	50                   	push   %eax
    32b5:	e8 00 06 00 00       	call   38ba <close>
  unlink("bigarg-ok");
    32ba:	c7 04 24 56 4c 00 00 	movl   $0x4c56,(%esp)
    32c1:	e8 1c 06 00 00       	call   38e2 <unlink>
}
    32c6:	83 c4 10             	add    $0x10,%esp
    32c9:	c9                   	leave  
    32ca:	c3                   	ret    
    32cb:	b8 20 5e 00 00       	mov    $0x5e20,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    32d0:	c7 00 b0 53 00 00    	movl   $0x53b0,(%eax)
    32d6:	83 c0 04             	add    $0x4,%eax
    for(i = 0; i < MAXARG-1; i++)
    32d9:	3d 9c 5e 00 00       	cmp    $0x5e9c,%eax
    32de:	75 f0                	jne    32d0 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    32e0:	51                   	push   %ecx
    32e1:	51                   	push   %ecx
    32e2:	68 60 4c 00 00       	push   $0x4c60
    32e7:	ff 35 f8 5d 00 00    	pushl  0x5df8
    args[MAXARG-1] = 0;
    32ed:	c7 05 9c 5e 00 00 00 	movl   $0x0,0x5e9c
    32f4:	00 00 00 
    printf(stdout, "bigarg test\n");
    32f7:	e8 f4 06 00 00       	call   39f0 <printf>
    exec("echo", args);
    32fc:	58                   	pop    %eax
    32fd:	5a                   	pop    %edx
    32fe:	68 20 5e 00 00       	push   $0x5e20
    3303:	68 2d 3e 00 00       	push   $0x3e2d
    3308:	e8 bd 05 00 00       	call   38ca <exec>
    printf(stdout, "bigarg test ok\n");
    330d:	59                   	pop    %ecx
    330e:	58                   	pop    %eax
    330f:	68 6d 4c 00 00       	push   $0x4c6d
    3314:	ff 35 f8 5d 00 00    	pushl  0x5df8
    331a:	e8 d1 06 00 00       	call   39f0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    331f:	58                   	pop    %eax
    3320:	5a                   	pop    %edx
    3321:	68 00 02 00 00       	push   $0x200
    3326:	68 56 4c 00 00       	push   $0x4c56
    332b:	e8 a2 05 00 00       	call   38d2 <open>
    close(fd);
    3330:	89 04 24             	mov    %eax,(%esp)
    3333:	e8 82 05 00 00       	call   38ba <close>
    exit();
    3338:	e8 55 05 00 00       	call   3892 <exit>
    printf(stdout, "bigarg test failed!\n");
    333d:	50                   	push   %eax
    333e:	50                   	push   %eax
    333f:	68 96 4c 00 00       	push   $0x4c96
    3344:	ff 35 f8 5d 00 00    	pushl  0x5df8
    334a:	e8 a1 06 00 00       	call   39f0 <printf>
    exit();
    334f:	e8 3e 05 00 00       	call   3892 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3354:	52                   	push   %edx
    3355:	52                   	push   %edx
    3356:	68 7d 4c 00 00       	push   $0x4c7d
    335b:	ff 35 f8 5d 00 00    	pushl  0x5df8
    3361:	e8 8a 06 00 00       	call   39f0 <printf>
    exit();
    3366:	e8 27 05 00 00       	call   3892 <exit>
    336b:	90                   	nop
    336c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003370 <fsfull>:
{
    3370:	55                   	push   %ebp
    3371:	89 e5                	mov    %esp,%ebp
    3373:	57                   	push   %edi
    3374:	56                   	push   %esi
    3375:	53                   	push   %ebx
  for(nfiles = 0; ; nfiles++){
    3376:	31 db                	xor    %ebx,%ebx
{
    3378:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    337b:	68 ab 4c 00 00       	push   $0x4cab
    3380:	6a 01                	push   $0x1
    3382:	e8 69 06 00 00       	call   39f0 <printf>
    3387:	83 c4 10             	add    $0x10,%esp
    338a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    3390:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3395:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    339a:	83 ec 04             	sub    $0x4,%esp
    name[1] = '0' + nfiles / 1000;
    339d:	f7 e3                	mul    %ebx
    name[0] = 'f';
    339f:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    33a3:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    33a7:	c1 ea 06             	shr    $0x6,%edx
    33aa:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33ad:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    33b3:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    33b6:	89 d8                	mov    %ebx,%eax
    33b8:	29 d0                	sub    %edx,%eax
    33ba:	89 c2                	mov    %eax,%edx
    33bc:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33c1:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33c3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33c8:	c1 ea 05             	shr    $0x5,%edx
    33cb:	83 c2 30             	add    $0x30,%edx
    33ce:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    33d1:	f7 e3                	mul    %ebx
    33d3:	89 d8                	mov    %ebx,%eax
    33d5:	c1 ea 05             	shr    $0x5,%edx
    33d8:	6b d2 64             	imul   $0x64,%edx,%edx
    33db:	29 d0                	sub    %edx,%eax
    33dd:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    33df:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33e1:	c1 ea 03             	shr    $0x3,%edx
    33e4:	83 c2 30             	add    $0x30,%edx
    33e7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    33ea:	f7 e1                	mul    %ecx
    33ec:	89 d9                	mov    %ebx,%ecx
    33ee:	c1 ea 03             	shr    $0x3,%edx
    33f1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    33f4:	01 c0                	add    %eax,%eax
    33f6:	29 c1                	sub    %eax,%ecx
    33f8:	89 c8                	mov    %ecx,%eax
    33fa:	83 c0 30             	add    $0x30,%eax
    33fd:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    3400:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3403:	50                   	push   %eax
    3404:	68 b8 4c 00 00       	push   $0x4cb8
    3409:	6a 01                	push   $0x1
    340b:	e8 e0 05 00 00       	call   39f0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    3410:	58                   	pop    %eax
    3411:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3414:	5a                   	pop    %edx
    3415:	68 02 02 00 00       	push   $0x202
    341a:	50                   	push   %eax
    341b:	e8 b2 04 00 00       	call   38d2 <open>
    if(fd < 0){
    3420:	83 c4 10             	add    $0x10,%esp
    3423:	85 c0                	test   %eax,%eax
    int fd = open(name, O_CREATE|O_RDWR);
    3425:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3427:	78 57                	js     3480 <fsfull+0x110>
    int total = 0;
    3429:	31 f6                	xor    %esi,%esi
    342b:	eb 05                	jmp    3432 <fsfull+0xc2>
    342d:	8d 76 00             	lea    0x0(%esi),%esi
      total += cc;
    3430:	01 c6                	add    %eax,%esi
      int cc = write(fd, buf, 512);
    3432:	83 ec 04             	sub    $0x4,%esp
    3435:	68 00 02 00 00       	push   $0x200
    343a:	68 e0 85 00 00       	push   $0x85e0
    343f:	57                   	push   %edi
    3440:	e8 6d 04 00 00       	call   38b2 <write>
      if(cc < 512)
    3445:	83 c4 10             	add    $0x10,%esp
    3448:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    344d:	7f e1                	jg     3430 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    344f:	83 ec 04             	sub    $0x4,%esp
    3452:	56                   	push   %esi
    3453:	68 d4 4c 00 00       	push   $0x4cd4
    3458:	6a 01                	push   $0x1
    345a:	e8 91 05 00 00       	call   39f0 <printf>
    close(fd);
    345f:	89 3c 24             	mov    %edi,(%esp)
    3462:	e8 53 04 00 00       	call   38ba <close>
    if(total == 0)
    3467:	83 c4 10             	add    $0x10,%esp
    346a:	85 f6                	test   %esi,%esi
    346c:	74 28                	je     3496 <fsfull+0x126>
  for(nfiles = 0; ; nfiles++){
    346e:	83 c3 01             	add    $0x1,%ebx
    3471:	e9 1a ff ff ff       	jmp    3390 <fsfull+0x20>
    3476:	8d 76 00             	lea    0x0(%esi),%esi
    3479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "open %s failed\n", name);
    3480:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3483:	83 ec 04             	sub    $0x4,%esp
    3486:	50                   	push   %eax
    3487:	68 c4 4c 00 00       	push   $0x4cc4
    348c:	6a 01                	push   $0x1
    348e:	e8 5d 05 00 00       	call   39f0 <printf>
      break;
    3493:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    3496:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    349b:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    name[1] = '0' + nfiles / 1000;
    34a0:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34a2:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    34a7:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + nfiles / 1000;
    34aa:	f7 e7                	mul    %edi
    name[0] = 'f';
    34ac:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    34b0:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    34b4:	c1 ea 06             	shr    $0x6,%edx
    34b7:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34ba:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    34c0:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34c3:	89 d8                	mov    %ebx,%eax
    34c5:	29 d0                	sub    %edx,%eax
    34c7:	f7 e6                	mul    %esi
    name[3] = '0' + (nfiles % 100) / 10;
    34c9:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34cb:	c1 ea 05             	shr    $0x5,%edx
    34ce:	83 c2 30             	add    $0x30,%edx
    34d1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    34d4:	f7 e6                	mul    %esi
    34d6:	89 d8                	mov    %ebx,%eax
    34d8:	c1 ea 05             	shr    $0x5,%edx
    34db:	6b d2 64             	imul   $0x64,%edx,%edx
    34de:	29 d0                	sub    %edx,%eax
    34e0:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    34e2:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34e4:	c1 ea 03             	shr    $0x3,%edx
    34e7:	83 c2 30             	add    $0x30,%edx
    34ea:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    34ed:	f7 e1                	mul    %ecx
    34ef:	89 d9                	mov    %ebx,%ecx
    nfiles--;
    34f1:	83 eb 01             	sub    $0x1,%ebx
    name[4] = '0' + (nfiles % 10);
    34f4:	c1 ea 03             	shr    $0x3,%edx
    34f7:	8d 04 92             	lea    (%edx,%edx,4),%eax
    34fa:	01 c0                	add    %eax,%eax
    34fc:	29 c1                	sub    %eax,%ecx
    34fe:	89 c8                	mov    %ecx,%eax
    3500:	83 c0 30             	add    $0x30,%eax
    3503:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    3506:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3509:	50                   	push   %eax
    350a:	e8 d3 03 00 00       	call   38e2 <unlink>
  while(nfiles >= 0){
    350f:	83 c4 10             	add    $0x10,%esp
    3512:	83 fb ff             	cmp    $0xffffffff,%ebx
    3515:	75 89                	jne    34a0 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    3517:	83 ec 08             	sub    $0x8,%esp
    351a:	68 e4 4c 00 00       	push   $0x4ce4
    351f:	6a 01                	push   $0x1
    3521:	e8 ca 04 00 00       	call   39f0 <printf>
}
    3526:	83 c4 10             	add    $0x10,%esp
    3529:	8d 65 f4             	lea    -0xc(%ebp),%esp
    352c:	5b                   	pop    %ebx
    352d:	5e                   	pop    %esi
    352e:	5f                   	pop    %edi
    352f:	5d                   	pop    %ebp
    3530:	c3                   	ret    
    3531:	eb 0d                	jmp    3540 <uio>
    3533:	90                   	nop
    3534:	90                   	nop
    3535:	90                   	nop
    3536:	90                   	nop
    3537:	90                   	nop
    3538:	90                   	nop
    3539:	90                   	nop
    353a:	90                   	nop
    353b:	90                   	nop
    353c:	90                   	nop
    353d:	90                   	nop
    353e:	90                   	nop
    353f:	90                   	nop

00003540 <uio>:
{
    3540:	55                   	push   %ebp
    3541:	89 e5                	mov    %esp,%ebp
    3543:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3546:	68 fa 4c 00 00       	push   $0x4cfa
    354b:	6a 01                	push   $0x1
    354d:	e8 9e 04 00 00       	call   39f0 <printf>
  pid = fork();
    3552:	e8 33 03 00 00       	call   388a <fork>
  if(pid == 0){
    3557:	83 c4 10             	add    $0x10,%esp
    355a:	85 c0                	test   %eax,%eax
    355c:	74 1b                	je     3579 <uio+0x39>
  } else if(pid < 0){
    355e:	78 3d                	js     359d <uio+0x5d>
  wait();
    3560:	e8 35 03 00 00       	call   389a <wait>
  printf(1, "uio test done\n");
    3565:	83 ec 08             	sub    $0x8,%esp
    3568:	68 04 4d 00 00       	push   $0x4d04
    356d:	6a 01                	push   $0x1
    356f:	e8 7c 04 00 00       	call   39f0 <printf>
}
    3574:	83 c4 10             	add    $0x10,%esp
    3577:	c9                   	leave  
    3578:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3579:	b8 09 00 00 00       	mov    $0x9,%eax
    357e:	ba 70 00 00 00       	mov    $0x70,%edx
    3583:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3584:	ba 71 00 00 00       	mov    $0x71,%edx
    3589:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    358a:	52                   	push   %edx
    358b:	52                   	push   %edx
    358c:	68 90 54 00 00       	push   $0x5490
    3591:	6a 01                	push   $0x1
    3593:	e8 58 04 00 00       	call   39f0 <printf>
    exit();
    3598:	e8 f5 02 00 00       	call   3892 <exit>
    printf (1, "fork failed\n");
    359d:	50                   	push   %eax
    359e:	50                   	push   %eax
    359f:	68 89 4c 00 00       	push   $0x4c89
    35a4:	6a 01                	push   $0x1
    35a6:	e8 45 04 00 00       	call   39f0 <printf>
    exit();
    35ab:	e8 e2 02 00 00       	call   3892 <exit>

000035b0 <argptest>:
{
    35b0:	55                   	push   %ebp
    35b1:	89 e5                	mov    %esp,%ebp
    35b3:	53                   	push   %ebx
    35b4:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    35b7:	6a 00                	push   $0x0
    35b9:	68 13 4d 00 00       	push   $0x4d13
    35be:	e8 0f 03 00 00       	call   38d2 <open>
  if (fd < 0) {
    35c3:	83 c4 10             	add    $0x10,%esp
    35c6:	85 c0                	test   %eax,%eax
    35c8:	78 39                	js     3603 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    35ca:	83 ec 0c             	sub    $0xc,%esp
    35cd:	89 c3                	mov    %eax,%ebx
    35cf:	6a 00                	push   $0x0
    35d1:	e8 44 03 00 00       	call   391a <sbrk>
    35d6:	83 c4 0c             	add    $0xc,%esp
    35d9:	83 e8 01             	sub    $0x1,%eax
    35dc:	6a ff                	push   $0xffffffff
    35de:	50                   	push   %eax
    35df:	53                   	push   %ebx
    35e0:	e8 c5 02 00 00       	call   38aa <read>
  close(fd);
    35e5:	89 1c 24             	mov    %ebx,(%esp)
    35e8:	e8 cd 02 00 00       	call   38ba <close>
  printf(1, "arg test passed\n");
    35ed:	58                   	pop    %eax
    35ee:	5a                   	pop    %edx
    35ef:	68 25 4d 00 00       	push   $0x4d25
    35f4:	6a 01                	push   $0x1
    35f6:	e8 f5 03 00 00       	call   39f0 <printf>
}
    35fb:	83 c4 10             	add    $0x10,%esp
    35fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3601:	c9                   	leave  
    3602:	c3                   	ret    
    printf(2, "open failed\n");
    3603:	51                   	push   %ecx
    3604:	51                   	push   %ecx
    3605:	68 18 4d 00 00       	push   $0x4d18
    360a:	6a 02                	push   $0x2
    360c:	e8 df 03 00 00       	call   39f0 <printf>
    exit();
    3611:	e8 7c 02 00 00       	call   3892 <exit>
    3616:	8d 76 00             	lea    0x0(%esi),%esi
    3619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003620 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3620:	69 05 f4 5d 00 00 0d 	imul   $0x19660d,0x5df4,%eax
    3627:	66 19 00 
{
    362a:	55                   	push   %ebp
    362b:	89 e5                	mov    %esp,%ebp
}
    362d:	5d                   	pop    %ebp
  randstate = randstate * 1664525 + 1013904223;
    362e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3633:	a3 f4 5d 00 00       	mov    %eax,0x5df4
}
    3638:	c3                   	ret    
    3639:	66 90                	xchg   %ax,%ax
    363b:	66 90                	xchg   %ax,%ax
    363d:	66 90                	xchg   %ax,%ax
    363f:	90                   	nop

00003640 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3640:	55                   	push   %ebp
    3641:	89 e5                	mov    %esp,%ebp
    3643:	53                   	push   %ebx
    3644:	8b 45 08             	mov    0x8(%ebp),%eax
    3647:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    364a:	89 c2                	mov    %eax,%edx
    364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3650:	83 c1 01             	add    $0x1,%ecx
    3653:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3657:	83 c2 01             	add    $0x1,%edx
    365a:	84 db                	test   %bl,%bl
    365c:	88 5a ff             	mov    %bl,-0x1(%edx)
    365f:	75 ef                	jne    3650 <strcpy+0x10>
    ;
  return os;
}
    3661:	5b                   	pop    %ebx
    3662:	5d                   	pop    %ebp
    3663:	c3                   	ret    
    3664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    366a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003670 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3670:	55                   	push   %ebp
    3671:	89 e5                	mov    %esp,%ebp
    3673:	53                   	push   %ebx
    3674:	8b 55 08             	mov    0x8(%ebp),%edx
    3677:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    367a:	0f b6 02             	movzbl (%edx),%eax
    367d:	0f b6 19             	movzbl (%ecx),%ebx
    3680:	84 c0                	test   %al,%al
    3682:	75 1c                	jne    36a0 <strcmp+0x30>
    3684:	eb 2a                	jmp    36b0 <strcmp+0x40>
    3686:	8d 76 00             	lea    0x0(%esi),%esi
    3689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    3690:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    3693:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    3696:	83 c1 01             	add    $0x1,%ecx
    3699:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    369c:	84 c0                	test   %al,%al
    369e:	74 10                	je     36b0 <strcmp+0x40>
    36a0:	38 d8                	cmp    %bl,%al
    36a2:	74 ec                	je     3690 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    36a4:	29 d8                	sub    %ebx,%eax
}
    36a6:	5b                   	pop    %ebx
    36a7:	5d                   	pop    %ebp
    36a8:	c3                   	ret    
    36a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    36b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    36b2:	29 d8                	sub    %ebx,%eax
}
    36b4:	5b                   	pop    %ebx
    36b5:	5d                   	pop    %ebp
    36b6:	c3                   	ret    
    36b7:	89 f6                	mov    %esi,%esi
    36b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036c0 <strlen>:

uint
strlen(const char *s)
{
    36c0:	55                   	push   %ebp
    36c1:	89 e5                	mov    %esp,%ebp
    36c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    36c6:	80 39 00             	cmpb   $0x0,(%ecx)
    36c9:	74 15                	je     36e0 <strlen+0x20>
    36cb:	31 d2                	xor    %edx,%edx
    36cd:	8d 76 00             	lea    0x0(%esi),%esi
    36d0:	83 c2 01             	add    $0x1,%edx
    36d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    36d7:	89 d0                	mov    %edx,%eax
    36d9:	75 f5                	jne    36d0 <strlen+0x10>
    ;
  return n;
}
    36db:	5d                   	pop    %ebp
    36dc:	c3                   	ret    
    36dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    36e0:	31 c0                	xor    %eax,%eax
}
    36e2:	5d                   	pop    %ebp
    36e3:	c3                   	ret    
    36e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000036f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    36f0:	55                   	push   %ebp
    36f1:	89 e5                	mov    %esp,%ebp
    36f3:	57                   	push   %edi
    36f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    36f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    36fa:	8b 45 0c             	mov    0xc(%ebp),%eax
    36fd:	89 d7                	mov    %edx,%edi
    36ff:	fc                   	cld    
    3700:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3702:	89 d0                	mov    %edx,%eax
    3704:	5f                   	pop    %edi
    3705:	5d                   	pop    %ebp
    3706:	c3                   	ret    
    3707:	89 f6                	mov    %esi,%esi
    3709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003710 <strchr>:

char*
strchr(const char *s, char c)
{
    3710:	55                   	push   %ebp
    3711:	89 e5                	mov    %esp,%ebp
    3713:	53                   	push   %ebx
    3714:	8b 45 08             	mov    0x8(%ebp),%eax
    3717:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    371a:	0f b6 10             	movzbl (%eax),%edx
    371d:	84 d2                	test   %dl,%dl
    371f:	74 1d                	je     373e <strchr+0x2e>
    if(*s == c)
    3721:	38 d3                	cmp    %dl,%bl
    3723:	89 d9                	mov    %ebx,%ecx
    3725:	75 0d                	jne    3734 <strchr+0x24>
    3727:	eb 17                	jmp    3740 <strchr+0x30>
    3729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3730:	38 ca                	cmp    %cl,%dl
    3732:	74 0c                	je     3740 <strchr+0x30>
  for(; *s; s++)
    3734:	83 c0 01             	add    $0x1,%eax
    3737:	0f b6 10             	movzbl (%eax),%edx
    373a:	84 d2                	test   %dl,%dl
    373c:	75 f2                	jne    3730 <strchr+0x20>
      return (char*)s;
  return 0;
    373e:	31 c0                	xor    %eax,%eax
}
    3740:	5b                   	pop    %ebx
    3741:	5d                   	pop    %ebp
    3742:	c3                   	ret    
    3743:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003750 <gets>:

char*
gets(char *buf, int max)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	57                   	push   %edi
    3754:	56                   	push   %esi
    3755:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3756:	31 f6                	xor    %esi,%esi
    3758:	89 f3                	mov    %esi,%ebx
{
    375a:	83 ec 1c             	sub    $0x1c,%esp
    375d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    3760:	eb 2f                	jmp    3791 <gets+0x41>
    3762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    3768:	8d 45 e7             	lea    -0x19(%ebp),%eax
    376b:	83 ec 04             	sub    $0x4,%esp
    376e:	6a 01                	push   $0x1
    3770:	50                   	push   %eax
    3771:	6a 00                	push   $0x0
    3773:	e8 32 01 00 00       	call   38aa <read>
    if(cc < 1)
    3778:	83 c4 10             	add    $0x10,%esp
    377b:	85 c0                	test   %eax,%eax
    377d:	7e 1c                	jle    379b <gets+0x4b>
      break;
    buf[i++] = c;
    377f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3783:	83 c7 01             	add    $0x1,%edi
    3786:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    3789:	3c 0a                	cmp    $0xa,%al
    378b:	74 23                	je     37b0 <gets+0x60>
    378d:	3c 0d                	cmp    $0xd,%al
    378f:	74 1f                	je     37b0 <gets+0x60>
  for(i=0; i+1 < max; ){
    3791:	83 c3 01             	add    $0x1,%ebx
    3794:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3797:	89 fe                	mov    %edi,%esi
    3799:	7c cd                	jl     3768 <gets+0x18>
    379b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    379d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    37a0:	c6 03 00             	movb   $0x0,(%ebx)
}
    37a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37a6:	5b                   	pop    %ebx
    37a7:	5e                   	pop    %esi
    37a8:	5f                   	pop    %edi
    37a9:	5d                   	pop    %ebp
    37aa:	c3                   	ret    
    37ab:	90                   	nop
    37ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37b0:	8b 75 08             	mov    0x8(%ebp),%esi
    37b3:	8b 45 08             	mov    0x8(%ebp),%eax
    37b6:	01 de                	add    %ebx,%esi
    37b8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    37ba:	c6 03 00             	movb   $0x0,(%ebx)
}
    37bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37c0:	5b                   	pop    %ebx
    37c1:	5e                   	pop    %esi
    37c2:	5f                   	pop    %edi
    37c3:	5d                   	pop    %ebp
    37c4:	c3                   	ret    
    37c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037d0 <stat>:

int
stat(const char *n, struct stat *st)
{
    37d0:	55                   	push   %ebp
    37d1:	89 e5                	mov    %esp,%ebp
    37d3:	56                   	push   %esi
    37d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37d5:	83 ec 08             	sub    $0x8,%esp
    37d8:	6a 00                	push   $0x0
    37da:	ff 75 08             	pushl  0x8(%ebp)
    37dd:	e8 f0 00 00 00       	call   38d2 <open>
  if(fd < 0)
    37e2:	83 c4 10             	add    $0x10,%esp
    37e5:	85 c0                	test   %eax,%eax
    37e7:	78 27                	js     3810 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    37e9:	83 ec 08             	sub    $0x8,%esp
    37ec:	ff 75 0c             	pushl  0xc(%ebp)
    37ef:	89 c3                	mov    %eax,%ebx
    37f1:	50                   	push   %eax
    37f2:	e8 f3 00 00 00       	call   38ea <fstat>
  close(fd);
    37f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    37fa:	89 c6                	mov    %eax,%esi
  close(fd);
    37fc:	e8 b9 00 00 00       	call   38ba <close>
  return r;
    3801:	83 c4 10             	add    $0x10,%esp
}
    3804:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3807:	89 f0                	mov    %esi,%eax
    3809:	5b                   	pop    %ebx
    380a:	5e                   	pop    %esi
    380b:	5d                   	pop    %ebp
    380c:	c3                   	ret    
    380d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    3810:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3815:	eb ed                	jmp    3804 <stat+0x34>
    3817:	89 f6                	mov    %esi,%esi
    3819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003820 <atoi>:

int
atoi(const char *s)
{
    3820:	55                   	push   %ebp
    3821:	89 e5                	mov    %esp,%ebp
    3823:	53                   	push   %ebx
    3824:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3827:	0f be 11             	movsbl (%ecx),%edx
    382a:	8d 42 d0             	lea    -0x30(%edx),%eax
    382d:	3c 09                	cmp    $0x9,%al
  n = 0;
    382f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3834:	77 1f                	ja     3855 <atoi+0x35>
    3836:	8d 76 00             	lea    0x0(%esi),%esi
    3839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3840:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3843:	83 c1 01             	add    $0x1,%ecx
    3846:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    384a:	0f be 11             	movsbl (%ecx),%edx
    384d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3850:	80 fb 09             	cmp    $0x9,%bl
    3853:	76 eb                	jbe    3840 <atoi+0x20>
  return n;
}
    3855:	5b                   	pop    %ebx
    3856:	5d                   	pop    %ebp
    3857:	c3                   	ret    
    3858:	90                   	nop
    3859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003860 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3860:	55                   	push   %ebp
    3861:	89 e5                	mov    %esp,%ebp
    3863:	56                   	push   %esi
    3864:	53                   	push   %ebx
    3865:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3868:	8b 45 08             	mov    0x8(%ebp),%eax
    386b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    386e:	85 db                	test   %ebx,%ebx
    3870:	7e 14                	jle    3886 <memmove+0x26>
    3872:	31 d2                	xor    %edx,%edx
    3874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3878:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    387c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    387f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    3882:	39 d3                	cmp    %edx,%ebx
    3884:	75 f2                	jne    3878 <memmove+0x18>
  return vdst;
}
    3886:	5b                   	pop    %ebx
    3887:	5e                   	pop    %esi
    3888:	5d                   	pop    %ebp
    3889:	c3                   	ret    

0000388a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    388a:	b8 01 00 00 00       	mov    $0x1,%eax
    388f:	cd 40                	int    $0x40
    3891:	c3                   	ret    

00003892 <exit>:
SYSCALL(exit)
    3892:	b8 02 00 00 00       	mov    $0x2,%eax
    3897:	cd 40                	int    $0x40
    3899:	c3                   	ret    

0000389a <wait>:
SYSCALL(wait)
    389a:	b8 03 00 00 00       	mov    $0x3,%eax
    389f:	cd 40                	int    $0x40
    38a1:	c3                   	ret    

000038a2 <pipe>:
SYSCALL(pipe)
    38a2:	b8 04 00 00 00       	mov    $0x4,%eax
    38a7:	cd 40                	int    $0x40
    38a9:	c3                   	ret    

000038aa <read>:
SYSCALL(read)
    38aa:	b8 05 00 00 00       	mov    $0x5,%eax
    38af:	cd 40                	int    $0x40
    38b1:	c3                   	ret    

000038b2 <write>:
SYSCALL(write)
    38b2:	b8 10 00 00 00       	mov    $0x10,%eax
    38b7:	cd 40                	int    $0x40
    38b9:	c3                   	ret    

000038ba <close>:
SYSCALL(close)
    38ba:	b8 15 00 00 00       	mov    $0x15,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <kill>:
SYSCALL(kill)
    38c2:	b8 06 00 00 00       	mov    $0x6,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <exec>:
SYSCALL(exec)
    38ca:	b8 07 00 00 00       	mov    $0x7,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <open>:
SYSCALL(open)
    38d2:	b8 0f 00 00 00       	mov    $0xf,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <mknod>:
SYSCALL(mknod)
    38da:	b8 11 00 00 00       	mov    $0x11,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <unlink>:
SYSCALL(unlink)
    38e2:	b8 12 00 00 00       	mov    $0x12,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <fstat>:
SYSCALL(fstat)
    38ea:	b8 08 00 00 00       	mov    $0x8,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <link>:
SYSCALL(link)
    38f2:	b8 13 00 00 00       	mov    $0x13,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <mkdir>:
SYSCALL(mkdir)
    38fa:	b8 14 00 00 00       	mov    $0x14,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <chdir>:
SYSCALL(chdir)
    3902:	b8 09 00 00 00       	mov    $0x9,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <dup>:
SYSCALL(dup)
    390a:	b8 0a 00 00 00       	mov    $0xa,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    

00003912 <getpid>:
SYSCALL(getpid)
    3912:	b8 0b 00 00 00       	mov    $0xb,%eax
    3917:	cd 40                	int    $0x40
    3919:	c3                   	ret    

0000391a <sbrk>:
SYSCALL(sbrk)
    391a:	b8 0c 00 00 00       	mov    $0xc,%eax
    391f:	cd 40                	int    $0x40
    3921:	c3                   	ret    

00003922 <sleep>:
SYSCALL(sleep)
    3922:	b8 0d 00 00 00       	mov    $0xd,%eax
    3927:	cd 40                	int    $0x40
    3929:	c3                   	ret    

0000392a <uptime>:
SYSCALL(uptime)
    392a:	b8 0e 00 00 00       	mov    $0xe,%eax
    392f:	cd 40                	int    $0x40
    3931:	c3                   	ret    

00003932 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
    3932:	b8 16 00 00 00       	mov    $0x16,%eax
    3937:	cd 40                	int    $0x40
    3939:	c3                   	ret    

0000393a <printProcDump>:
SYSCALL(printProcDump)
    393a:	b8 17 00 00 00       	mov    $0x17,%eax
    393f:	cd 40                	int    $0x40
    3941:	c3                   	ret    
    3942:	66 90                	xchg   %ax,%ax
    3944:	66 90                	xchg   %ax,%ax
    3946:	66 90                	xchg   %ax,%ax
    3948:	66 90                	xchg   %ax,%ax
    394a:	66 90                	xchg   %ax,%ax
    394c:	66 90                	xchg   %ax,%ax
    394e:	66 90                	xchg   %ax,%ax

00003950 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3950:	55                   	push   %ebp
    3951:	89 e5                	mov    %esp,%ebp
    3953:	57                   	push   %edi
    3954:	56                   	push   %esi
    3955:	53                   	push   %ebx
    3956:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3959:	85 d2                	test   %edx,%edx
{
    395b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    395e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    3960:	79 76                	jns    39d8 <printint+0x88>
    3962:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3966:	74 70                	je     39d8 <printint+0x88>
    x = -xx;
    3968:	f7 d8                	neg    %eax
    neg = 1;
    396a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3971:	31 f6                	xor    %esi,%esi
    3973:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3976:	eb 0a                	jmp    3982 <printint+0x32>
    3978:	90                   	nop
    3979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    3980:	89 fe                	mov    %edi,%esi
    3982:	31 d2                	xor    %edx,%edx
    3984:	8d 7e 01             	lea    0x1(%esi),%edi
    3987:	f7 f1                	div    %ecx
    3989:	0f b6 92 e8 54 00 00 	movzbl 0x54e8(%edx),%edx
  }while((x /= base) != 0);
    3990:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    3992:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    3995:	75 e9                	jne    3980 <printint+0x30>
  if(neg)
    3997:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    399a:	85 c0                	test   %eax,%eax
    399c:	74 08                	je     39a6 <printint+0x56>
    buf[i++] = '-';
    399e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    39a3:	8d 7e 02             	lea    0x2(%esi),%edi
    39a6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    39aa:	8b 7d c0             	mov    -0x40(%ebp),%edi
    39ad:	8d 76 00             	lea    0x0(%esi),%esi
    39b0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    39b3:	83 ec 04             	sub    $0x4,%esp
    39b6:	83 ee 01             	sub    $0x1,%esi
    39b9:	6a 01                	push   $0x1
    39bb:	53                   	push   %ebx
    39bc:	57                   	push   %edi
    39bd:	88 45 d7             	mov    %al,-0x29(%ebp)
    39c0:	e8 ed fe ff ff       	call   38b2 <write>

  while(--i >= 0)
    39c5:	83 c4 10             	add    $0x10,%esp
    39c8:	39 de                	cmp    %ebx,%esi
    39ca:	75 e4                	jne    39b0 <printint+0x60>
    putc(fd, buf[i]);
}
    39cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    39cf:	5b                   	pop    %ebx
    39d0:	5e                   	pop    %esi
    39d1:	5f                   	pop    %edi
    39d2:	5d                   	pop    %ebp
    39d3:	c3                   	ret    
    39d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    39d8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    39df:	eb 90                	jmp    3971 <printint+0x21>
    39e1:	eb 0d                	jmp    39f0 <printf>
    39e3:	90                   	nop
    39e4:	90                   	nop
    39e5:	90                   	nop
    39e6:	90                   	nop
    39e7:	90                   	nop
    39e8:	90                   	nop
    39e9:	90                   	nop
    39ea:	90                   	nop
    39eb:	90                   	nop
    39ec:	90                   	nop
    39ed:	90                   	nop
    39ee:	90                   	nop
    39ef:	90                   	nop

000039f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39f0:	55                   	push   %ebp
    39f1:	89 e5                	mov    %esp,%ebp
    39f3:	57                   	push   %edi
    39f4:	56                   	push   %esi
    39f5:	53                   	push   %ebx
    39f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39f9:	8b 75 0c             	mov    0xc(%ebp),%esi
    39fc:	0f b6 1e             	movzbl (%esi),%ebx
    39ff:	84 db                	test   %bl,%bl
    3a01:	0f 84 b3 00 00 00    	je     3aba <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    3a07:	8d 45 10             	lea    0x10(%ebp),%eax
    3a0a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    3a0d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    3a0f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3a12:	eb 2f                	jmp    3a43 <printf+0x53>
    3a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3a18:	83 f8 25             	cmp    $0x25,%eax
    3a1b:	0f 84 a7 00 00 00    	je     3ac8 <printf+0xd8>
  write(fd, &c, 1);
    3a21:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3a24:	83 ec 04             	sub    $0x4,%esp
    3a27:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    3a2a:	6a 01                	push   $0x1
    3a2c:	50                   	push   %eax
    3a2d:	ff 75 08             	pushl  0x8(%ebp)
    3a30:	e8 7d fe ff ff       	call   38b2 <write>
    3a35:	83 c4 10             	add    $0x10,%esp
    3a38:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    3a3b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3a3f:	84 db                	test   %bl,%bl
    3a41:	74 77                	je     3aba <printf+0xca>
    if(state == 0){
    3a43:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    3a45:	0f be cb             	movsbl %bl,%ecx
    3a48:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a4b:	74 cb                	je     3a18 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a4d:	83 ff 25             	cmp    $0x25,%edi
    3a50:	75 e6                	jne    3a38 <printf+0x48>
      if(c == 'd'){
    3a52:	83 f8 64             	cmp    $0x64,%eax
    3a55:	0f 84 05 01 00 00    	je     3b60 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a5b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3a61:	83 f9 70             	cmp    $0x70,%ecx
    3a64:	74 72                	je     3ad8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a66:	83 f8 73             	cmp    $0x73,%eax
    3a69:	0f 84 99 00 00 00    	je     3b08 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a6f:	83 f8 63             	cmp    $0x63,%eax
    3a72:	0f 84 08 01 00 00    	je     3b80 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a78:	83 f8 25             	cmp    $0x25,%eax
    3a7b:	0f 84 ef 00 00 00    	je     3b70 <printf+0x180>
  write(fd, &c, 1);
    3a81:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3a84:	83 ec 04             	sub    $0x4,%esp
    3a87:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3a8b:	6a 01                	push   $0x1
    3a8d:	50                   	push   %eax
    3a8e:	ff 75 08             	pushl  0x8(%ebp)
    3a91:	e8 1c fe ff ff       	call   38b2 <write>
    3a96:	83 c4 0c             	add    $0xc,%esp
    3a99:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3a9c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3a9f:	6a 01                	push   $0x1
    3aa1:	50                   	push   %eax
    3aa2:	ff 75 08             	pushl  0x8(%ebp)
    3aa5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3aa8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    3aaa:	e8 03 fe ff ff       	call   38b2 <write>
  for(i = 0; fmt[i]; i++){
    3aaf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    3ab3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3ab6:	84 db                	test   %bl,%bl
    3ab8:	75 89                	jne    3a43 <printf+0x53>
    }
  }
}
    3aba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3abd:	5b                   	pop    %ebx
    3abe:	5e                   	pop    %esi
    3abf:	5f                   	pop    %edi
    3ac0:	5d                   	pop    %ebp
    3ac1:	c3                   	ret    
    3ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    3ac8:	bf 25 00 00 00       	mov    $0x25,%edi
    3acd:	e9 66 ff ff ff       	jmp    3a38 <printf+0x48>
    3ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3ad8:	83 ec 0c             	sub    $0xc,%esp
    3adb:	b9 10 00 00 00       	mov    $0x10,%ecx
    3ae0:	6a 00                	push   $0x0
    3ae2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    3ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ae8:	8b 17                	mov    (%edi),%edx
    3aea:	e8 61 fe ff ff       	call   3950 <printint>
        ap++;
    3aef:	89 f8                	mov    %edi,%eax
    3af1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3af4:	31 ff                	xor    %edi,%edi
        ap++;
    3af6:	83 c0 04             	add    $0x4,%eax
    3af9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3afc:	e9 37 ff ff ff       	jmp    3a38 <printf+0x48>
    3b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3b08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3b0b:	8b 08                	mov    (%eax),%ecx
        ap++;
    3b0d:	83 c0 04             	add    $0x4,%eax
    3b10:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    3b13:	85 c9                	test   %ecx,%ecx
    3b15:	0f 84 8e 00 00 00    	je     3ba9 <printf+0x1b9>
        while(*s != 0){
    3b1b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    3b1e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    3b20:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    3b22:	84 c0                	test   %al,%al
    3b24:	0f 84 0e ff ff ff    	je     3a38 <printf+0x48>
    3b2a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    3b2d:	89 de                	mov    %ebx,%esi
    3b2f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b32:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    3b35:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b38:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b3b:	83 c6 01             	add    $0x1,%esi
    3b3e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    3b41:	6a 01                	push   $0x1
    3b43:	57                   	push   %edi
    3b44:	53                   	push   %ebx
    3b45:	e8 68 fd ff ff       	call   38b2 <write>
        while(*s != 0){
    3b4a:	0f b6 06             	movzbl (%esi),%eax
    3b4d:	83 c4 10             	add    $0x10,%esp
    3b50:	84 c0                	test   %al,%al
    3b52:	75 e4                	jne    3b38 <printf+0x148>
    3b54:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    3b57:	31 ff                	xor    %edi,%edi
    3b59:	e9 da fe ff ff       	jmp    3a38 <printf+0x48>
    3b5e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    3b60:	83 ec 0c             	sub    $0xc,%esp
    3b63:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b68:	6a 01                	push   $0x1
    3b6a:	e9 73 ff ff ff       	jmp    3ae2 <printf+0xf2>
    3b6f:	90                   	nop
  write(fd, &c, 1);
    3b70:	83 ec 04             	sub    $0x4,%esp
    3b73:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3b76:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3b79:	6a 01                	push   $0x1
    3b7b:	e9 21 ff ff ff       	jmp    3aa1 <printf+0xb1>
        putc(fd, *ap);
    3b80:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    3b83:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b86:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    3b88:	6a 01                	push   $0x1
        ap++;
    3b8a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    3b8d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    3b90:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3b93:	50                   	push   %eax
    3b94:	ff 75 08             	pushl  0x8(%ebp)
    3b97:	e8 16 fd ff ff       	call   38b2 <write>
        ap++;
    3b9c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    3b9f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3ba2:	31 ff                	xor    %edi,%edi
    3ba4:	e9 8f fe ff ff       	jmp    3a38 <printf+0x48>
          s = "(null)";
    3ba9:	bb e0 54 00 00       	mov    $0x54e0,%ebx
        while(*s != 0){
    3bae:	b8 28 00 00 00       	mov    $0x28,%eax
    3bb3:	e9 72 ff ff ff       	jmp    3b2a <printf+0x13a>
    3bb8:	66 90                	xchg   %ax,%ax
    3bba:	66 90                	xchg   %ax,%ax
    3bbc:	66 90                	xchg   %ax,%ax
    3bbe:	66 90                	xchg   %ax,%ax

00003bc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3bc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bc1:	a1 a0 5e 00 00       	mov    0x5ea0,%eax
{
    3bc6:	89 e5                	mov    %esp,%ebp
    3bc8:	57                   	push   %edi
    3bc9:	56                   	push   %esi
    3bca:	53                   	push   %ebx
    3bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bd8:	39 c8                	cmp    %ecx,%eax
    3bda:	8b 10                	mov    (%eax),%edx
    3bdc:	73 32                	jae    3c10 <free+0x50>
    3bde:	39 d1                	cmp    %edx,%ecx
    3be0:	72 04                	jb     3be6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3be2:	39 d0                	cmp    %edx,%eax
    3be4:	72 32                	jb     3c18 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3be6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3be9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bec:	39 fa                	cmp    %edi,%edx
    3bee:	74 30                	je     3c20 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3bf0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3bf3:	8b 50 04             	mov    0x4(%eax),%edx
    3bf6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3bf9:	39 f1                	cmp    %esi,%ecx
    3bfb:	74 3a                	je     3c37 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3bfd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3bff:	a3 a0 5e 00 00       	mov    %eax,0x5ea0
}
    3c04:	5b                   	pop    %ebx
    3c05:	5e                   	pop    %esi
    3c06:	5f                   	pop    %edi
    3c07:	5d                   	pop    %ebp
    3c08:	c3                   	ret    
    3c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3c10:	39 d0                	cmp    %edx,%eax
    3c12:	72 04                	jb     3c18 <free+0x58>
    3c14:	39 d1                	cmp    %edx,%ecx
    3c16:	72 ce                	jb     3be6 <free+0x26>
{
    3c18:	89 d0                	mov    %edx,%eax
    3c1a:	eb bc                	jmp    3bd8 <free+0x18>
    3c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    3c20:	03 72 04             	add    0x4(%edx),%esi
    3c23:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c26:	8b 10                	mov    (%eax),%edx
    3c28:	8b 12                	mov    (%edx),%edx
    3c2a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c2d:	8b 50 04             	mov    0x4(%eax),%edx
    3c30:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c33:	39 f1                	cmp    %esi,%ecx
    3c35:	75 c6                	jne    3bfd <free+0x3d>
    p->s.size += bp->s.size;
    3c37:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3c3a:	a3 a0 5e 00 00       	mov    %eax,0x5ea0
    p->s.size += bp->s.size;
    3c3f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3c42:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c45:	89 10                	mov    %edx,(%eax)
}
    3c47:	5b                   	pop    %ebx
    3c48:	5e                   	pop    %esi
    3c49:	5f                   	pop    %edi
    3c4a:	5d                   	pop    %ebp
    3c4b:	c3                   	ret    
    3c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c50 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c50:	55                   	push   %ebp
    3c51:	89 e5                	mov    %esp,%ebp
    3c53:	57                   	push   %edi
    3c54:	56                   	push   %esi
    3c55:	53                   	push   %ebx
    3c56:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c59:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c5c:	8b 15 a0 5e 00 00    	mov    0x5ea0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c62:	8d 78 07             	lea    0x7(%eax),%edi
    3c65:	c1 ef 03             	shr    $0x3,%edi
    3c68:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3c6b:	85 d2                	test   %edx,%edx
    3c6d:	0f 84 9d 00 00 00    	je     3d10 <malloc+0xc0>
    3c73:	8b 02                	mov    (%edx),%eax
    3c75:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3c78:	39 cf                	cmp    %ecx,%edi
    3c7a:	76 6c                	jbe    3ce8 <malloc+0x98>
    3c7c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3c82:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c87:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    3c8a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3c91:	eb 0e                	jmp    3ca1 <malloc+0x51>
    3c93:	90                   	nop
    3c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c98:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3c9a:	8b 48 04             	mov    0x4(%eax),%ecx
    3c9d:	39 f9                	cmp    %edi,%ecx
    3c9f:	73 47                	jae    3ce8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3ca1:	39 05 a0 5e 00 00    	cmp    %eax,0x5ea0
    3ca7:	89 c2                	mov    %eax,%edx
    3ca9:	75 ed                	jne    3c98 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3cab:	83 ec 0c             	sub    $0xc,%esp
    3cae:	56                   	push   %esi
    3caf:	e8 66 fc ff ff       	call   391a <sbrk>
  if(p == (char*)-1)
    3cb4:	83 c4 10             	add    $0x10,%esp
    3cb7:	83 f8 ff             	cmp    $0xffffffff,%eax
    3cba:	74 1c                	je     3cd8 <malloc+0x88>
  hp->s.size = nu;
    3cbc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3cbf:	83 ec 0c             	sub    $0xc,%esp
    3cc2:	83 c0 08             	add    $0x8,%eax
    3cc5:	50                   	push   %eax
    3cc6:	e8 f5 fe ff ff       	call   3bc0 <free>
  return freep;
    3ccb:	8b 15 a0 5e 00 00    	mov    0x5ea0,%edx
      if((p = morecore(nunits)) == 0)
    3cd1:	83 c4 10             	add    $0x10,%esp
    3cd4:	85 d2                	test   %edx,%edx
    3cd6:	75 c0                	jne    3c98 <malloc+0x48>
        return 0;
  }
}
    3cd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3cdb:	31 c0                	xor    %eax,%eax
}
    3cdd:	5b                   	pop    %ebx
    3cde:	5e                   	pop    %esi
    3cdf:	5f                   	pop    %edi
    3ce0:	5d                   	pop    %ebp
    3ce1:	c3                   	ret    
    3ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3ce8:	39 cf                	cmp    %ecx,%edi
    3cea:	74 54                	je     3d40 <malloc+0xf0>
        p->s.size -= nunits;
    3cec:	29 f9                	sub    %edi,%ecx
    3cee:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3cf1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3cf4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3cf7:	89 15 a0 5e 00 00    	mov    %edx,0x5ea0
}
    3cfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3d00:	83 c0 08             	add    $0x8,%eax
}
    3d03:	5b                   	pop    %ebx
    3d04:	5e                   	pop    %esi
    3d05:	5f                   	pop    %edi
    3d06:	5d                   	pop    %ebp
    3d07:	c3                   	ret    
    3d08:	90                   	nop
    3d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    3d10:	c7 05 a0 5e 00 00 a4 	movl   $0x5ea4,0x5ea0
    3d17:	5e 00 00 
    3d1a:	c7 05 a4 5e 00 00 a4 	movl   $0x5ea4,0x5ea4
    3d21:	5e 00 00 
    base.s.size = 0;
    3d24:	b8 a4 5e 00 00       	mov    $0x5ea4,%eax
    3d29:	c7 05 a8 5e 00 00 00 	movl   $0x0,0x5ea8
    3d30:	00 00 00 
    3d33:	e9 44 ff ff ff       	jmp    3c7c <malloc+0x2c>
    3d38:	90                   	nop
    3d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    3d40:	8b 08                	mov    (%eax),%ecx
    3d42:	89 0a                	mov    %ecx,(%edx)
    3d44:	eb b1                	jmp    3cf7 <malloc+0xa7>
