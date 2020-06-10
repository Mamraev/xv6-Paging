
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
      11:	68 16 4d 00 00       	push   $0x4d16
      16:	6a 01                	push   $0x1
      18:	e8 b3 39 00 00       	call   39d0 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	59                   	pop    %ecx
      1e:	58                   	pop    %eax
      1f:	6a 00                	push   $0x0
      21:	68 2a 4d 00 00       	push   $0x4d2a
      26:	e8 87 38 00 00       	call   38b2 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	85 c0                	test   %eax,%eax
      30:	78 13                	js     45 <main+0x45>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      32:	52                   	push   %edx
      33:	52                   	push   %edx
      34:	68 94 54 00 00       	push   $0x5494
      39:	6a 01                	push   $0x1
      3b:	e8 90 39 00 00       	call   39d0 <printf>
    exit();
      40:	e8 2d 38 00 00       	call   3872 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      45:	50                   	push   %eax
      46:	50                   	push   %eax
      47:	68 00 02 00 00       	push   $0x200
      4c:	68 2a 4d 00 00       	push   $0x4d2a
      51:	e8 5c 38 00 00       	call   38b2 <open>
      56:	89 04 24             	mov    %eax,(%esp)
      59:	e8 3c 38 00 00       	call   389a <close>
  fourfiles();
  sharedfd();

  bigargtest();
  bigwrite();*/
  bigargtest();
      5e:	e8 ed 31 00 00       	call   3250 <bigargtest>
  bsstest();
      63:	e8 68 31 00 00       	call   31d0 <bsstest>
  //  sbrktest();
  validatetest();
      68:	e8 b3 30 00 00       	call   3120 <validatetest>

  opentest();
      6d:	e8 4e 03 00 00       	call   3c0 <opentest>
  writetest();
      72:	e8 d9 03 00 00       	call   450 <writetest>
  writetest1();
      77:	e8 b4 05 00 00       	call   630 <writetest1>
  createtest();
      7c:	e8 7f 07 00 00       	call   800 <createtest>

  openiputtest();
      81:	e8 3a 02 00 00       	call   2c0 <openiputtest>
  exitiputtest();
      86:	e8 45 01 00 00       	call   1d0 <exitiputtest>
  iputtest();
      8b:	e8 60 00 00 00       	call   f0 <iputtest>

  mem();
      90:	e8 bb 0c 00 00       	call   d50 <mem>
  pipe1();
      95:	e8 46 09 00 00       	call   9e0 <pipe1>
  preempt();
      9a:	e8 e1 0a 00 00       	call   b80 <preempt>
  exitwait();
      9f:	e8 1c 0c 00 00       	call   cc0 <exitwait>

  rmdot();
      a4:	e8 07 27 00 00       	call   27b0 <rmdot>
  fourteen();
      a9:	e8 c2 25 00 00       	call   2670 <fourteen>
  bigfile();
      ae:	e8 ed 23 00 00       	call   24a0 <bigfile>
  subdir();
      b3:	e8 28 1c 00 00       	call   1ce0 <subdir>
  linktest();
      b8:	e8 d3 14 00 00       	call   1590 <linktest>
  unlinkread();
      bd:	e8 3e 13 00 00       	call   1400 <unlinkread>
  dirfile();
      c2:	e8 69 28 00 00       	call   2930 <dirfile>
  iref();
      c7:	e8 64 2a 00 00       	call   2b30 <iref>
  forktest();
      cc:	e8 7f 2b 00 00       	call   2c50 <forktest>
  bigdir(); // slow
      d1:	e8 da 1a 00 00       	call   1bb0 <bigdir>

  uio();
      d6:	e8 45 34 00 00       	call   3520 <uio>

  exectest();
      db:	e8 b0 08 00 00       	call   990 <exectest>

  exit();
      e0:	e8 8d 37 00 00       	call   3872 <exit>
      e5:	66 90                	xchg   %ax,%ax
      e7:	66 90                	xchg   %ax,%ax
      e9:	66 90                	xchg   %ax,%ax
      eb:	66 90                	xchg   %ax,%ax
      ed:	66 90                	xchg   %ax,%ax
      ef:	90                   	nop

000000f0 <iputtest>:
{
      f0:	55                   	push   %ebp
      f1:	89 e5                	mov    %esp,%ebp
      f3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "iput test\n");
      f6:	68 bc 3d 00 00       	push   $0x3dbc
      fb:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     101:	e8 ca 38 00 00       	call   39d0 <printf>
  if(mkdir("iputdir") < 0){
     106:	c7 04 24 4f 3d 00 00 	movl   $0x3d4f,(%esp)
     10d:	e8 c8 37 00 00       	call   38da <mkdir>
     112:	83 c4 10             	add    $0x10,%esp
     115:	85 c0                	test   %eax,%eax
     117:	78 58                	js     171 <iputtest+0x81>
  if(chdir("iputdir") < 0){
     119:	83 ec 0c             	sub    $0xc,%esp
     11c:	68 4f 3d 00 00       	push   $0x3d4f
     121:	e8 bc 37 00 00       	call   38e2 <chdir>
     126:	83 c4 10             	add    $0x10,%esp
     129:	85 c0                	test   %eax,%eax
     12b:	0f 88 85 00 00 00    	js     1b6 <iputtest+0xc6>
  if(unlink("../iputdir") < 0){
     131:	83 ec 0c             	sub    $0xc,%esp
     134:	68 4c 3d 00 00       	push   $0x3d4c
     139:	e8 84 37 00 00       	call   38c2 <unlink>
     13e:	83 c4 10             	add    $0x10,%esp
     141:	85 c0                	test   %eax,%eax
     143:	78 5a                	js     19f <iputtest+0xaf>
  if(chdir("/") < 0){
     145:	83 ec 0c             	sub    $0xc,%esp
     148:	68 71 3d 00 00       	push   $0x3d71
     14d:	e8 90 37 00 00       	call   38e2 <chdir>
     152:	83 c4 10             	add    $0x10,%esp
     155:	85 c0                	test   %eax,%eax
     157:	78 2f                	js     188 <iputtest+0x98>
  printf(stdout, "iput test ok\n");
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	68 f4 3d 00 00       	push   $0x3df4
     161:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     167:	e8 64 38 00 00       	call   39d0 <printf>
}
     16c:	83 c4 10             	add    $0x10,%esp
     16f:	c9                   	leave  
     170:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     171:	50                   	push   %eax
     172:	50                   	push   %eax
     173:	68 28 3d 00 00       	push   $0x3d28
     178:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     17e:	e8 4d 38 00 00       	call   39d0 <printf>
    exit();
     183:	e8 ea 36 00 00       	call   3872 <exit>
    printf(stdout, "chdir / failed\n");
     188:	50                   	push   %eax
     189:	50                   	push   %eax
     18a:	68 73 3d 00 00       	push   $0x3d73
     18f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     195:	e8 36 38 00 00       	call   39d0 <printf>
    exit();
     19a:	e8 d3 36 00 00       	call   3872 <exit>
    printf(stdout, "unlink ../iputdir failed\n");
     19f:	52                   	push   %edx
     1a0:	52                   	push   %edx
     1a1:	68 57 3d 00 00       	push   $0x3d57
     1a6:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     1ac:	e8 1f 38 00 00       	call   39d0 <printf>
    exit();
     1b1:	e8 bc 36 00 00       	call   3872 <exit>
    printf(stdout, "chdir iputdir failed\n");
     1b6:	51                   	push   %ecx
     1b7:	51                   	push   %ecx
     1b8:	68 36 3d 00 00       	push   $0x3d36
     1bd:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     1c3:	e8 08 38 00 00       	call   39d0 <printf>
    exit();
     1c8:	e8 a5 36 00 00       	call   3872 <exit>
     1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <exitiputtest>:
{
     1d0:	55                   	push   %ebp
     1d1:	89 e5                	mov    %esp,%ebp
     1d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exitiput test\n");
     1d6:	68 83 3d 00 00       	push   $0x3d83
     1db:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     1e1:	e8 ea 37 00 00       	call   39d0 <printf>
  pid = fork();
     1e6:	e8 7f 36 00 00       	call   386a <fork>
  if(pid < 0){
     1eb:	83 c4 10             	add    $0x10,%esp
     1ee:	85 c0                	test   %eax,%eax
     1f0:	0f 88 82 00 00 00    	js     278 <exitiputtest+0xa8>
  if(pid == 0){
     1f6:	75 48                	jne    240 <exitiputtest+0x70>
    if(mkdir("iputdir") < 0){
     1f8:	83 ec 0c             	sub    $0xc,%esp
     1fb:	68 4f 3d 00 00       	push   $0x3d4f
     200:	e8 d5 36 00 00       	call   38da <mkdir>
     205:	83 c4 10             	add    $0x10,%esp
     208:	85 c0                	test   %eax,%eax
     20a:	0f 88 96 00 00 00    	js     2a6 <exitiputtest+0xd6>
    if(chdir("iputdir") < 0){
     210:	83 ec 0c             	sub    $0xc,%esp
     213:	68 4f 3d 00 00       	push   $0x3d4f
     218:	e8 c5 36 00 00       	call   38e2 <chdir>
     21d:	83 c4 10             	add    $0x10,%esp
     220:	85 c0                	test   %eax,%eax
     222:	78 6b                	js     28f <exitiputtest+0xbf>
    if(unlink("../iputdir") < 0){
     224:	83 ec 0c             	sub    $0xc,%esp
     227:	68 4c 3d 00 00       	push   $0x3d4c
     22c:	e8 91 36 00 00       	call   38c2 <unlink>
     231:	83 c4 10             	add    $0x10,%esp
     234:	85 c0                	test   %eax,%eax
     236:	78 28                	js     260 <exitiputtest+0x90>
    exit();
     238:	e8 35 36 00 00       	call   3872 <exit>
     23d:	8d 76 00             	lea    0x0(%esi),%esi
  wait();
     240:	e8 35 36 00 00       	call   387a <wait>
  printf(stdout, "exitiput test ok\n");
     245:	83 ec 08             	sub    $0x8,%esp
     248:	68 a6 3d 00 00       	push   $0x3da6
     24d:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     253:	e8 78 37 00 00       	call   39d0 <printf>
}
     258:	83 c4 10             	add    $0x10,%esp
     25b:	c9                   	leave  
     25c:	c3                   	ret    
     25d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(stdout, "unlink ../iputdir failed\n");
     260:	83 ec 08             	sub    $0x8,%esp
     263:	68 57 3d 00 00       	push   $0x3d57
     268:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     26e:	e8 5d 37 00 00       	call   39d0 <printf>
      exit();
     273:	e8 fa 35 00 00       	call   3872 <exit>
    printf(stdout, "fork failed\n");
     278:	51                   	push   %ecx
     279:	51                   	push   %ecx
     27a:	68 69 4c 00 00       	push   $0x4c69
     27f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     285:	e8 46 37 00 00       	call   39d0 <printf>
    exit();
     28a:	e8 e3 35 00 00       	call   3872 <exit>
      printf(stdout, "child chdir failed\n");
     28f:	50                   	push   %eax
     290:	50                   	push   %eax
     291:	68 92 3d 00 00       	push   $0x3d92
     296:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     29c:	e8 2f 37 00 00       	call   39d0 <printf>
      exit();
     2a1:	e8 cc 35 00 00       	call   3872 <exit>
      printf(stdout, "mkdir failed\n");
     2a6:	52                   	push   %edx
     2a7:	52                   	push   %edx
     2a8:	68 28 3d 00 00       	push   $0x3d28
     2ad:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     2b3:	e8 18 37 00 00       	call   39d0 <printf>
      exit();
     2b8:	e8 b5 35 00 00       	call   3872 <exit>
     2bd:	8d 76 00             	lea    0x0(%esi),%esi

000002c0 <openiputtest>:
{
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "openiput test\n");
     2c6:	68 b8 3d 00 00       	push   $0x3db8
     2cb:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     2d1:	e8 fa 36 00 00       	call   39d0 <printf>
  if(mkdir("oidir") < 0){
     2d6:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
     2dd:	e8 f8 35 00 00       	call   38da <mkdir>
     2e2:	83 c4 10             	add    $0x10,%esp
     2e5:	85 c0                	test   %eax,%eax
     2e7:	0f 88 88 00 00 00    	js     375 <openiputtest+0xb5>
  pid = fork();
     2ed:	e8 78 35 00 00       	call   386a <fork>
  if(pid < 0){
     2f2:	85 c0                	test   %eax,%eax
     2f4:	0f 88 92 00 00 00    	js     38c <openiputtest+0xcc>
  if(pid == 0){
     2fa:	75 34                	jne    330 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     2fc:	83 ec 08             	sub    $0x8,%esp
     2ff:	6a 02                	push   $0x2
     301:	68 c7 3d 00 00       	push   $0x3dc7
     306:	e8 a7 35 00 00       	call   38b2 <open>
    if(fd >= 0){
     30b:	83 c4 10             	add    $0x10,%esp
     30e:	85 c0                	test   %eax,%eax
     310:	78 5e                	js     370 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     312:	83 ec 08             	sub    $0x8,%esp
     315:	68 4c 4d 00 00       	push   $0x4d4c
     31a:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     320:	e8 ab 36 00 00       	call   39d0 <printf>
      exit();
     325:	e8 48 35 00 00       	call   3872 <exit>
     32a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  sleep(1);
     330:	83 ec 0c             	sub    $0xc,%esp
     333:	6a 01                	push   $0x1
     335:	e8 c8 35 00 00       	call   3902 <sleep>
  if(unlink("oidir") != 0){
     33a:	c7 04 24 c7 3d 00 00 	movl   $0x3dc7,(%esp)
     341:	e8 7c 35 00 00       	call   38c2 <unlink>
     346:	83 c4 10             	add    $0x10,%esp
     349:	85 c0                	test   %eax,%eax
     34b:	75 56                	jne    3a3 <openiputtest+0xe3>
  wait();
     34d:	e8 28 35 00 00       	call   387a <wait>
  printf(stdout, "openiput test ok\n");
     352:	83 ec 08             	sub    $0x8,%esp
     355:	68 f0 3d 00 00       	push   $0x3df0
     35a:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     360:	e8 6b 36 00 00       	call   39d0 <printf>
     365:	83 c4 10             	add    $0x10,%esp
}
     368:	c9                   	leave  
     369:	c3                   	ret    
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
     370:	e8 fd 34 00 00       	call   3872 <exit>
    printf(stdout, "mkdir oidir failed\n");
     375:	51                   	push   %ecx
     376:	51                   	push   %ecx
     377:	68 cd 3d 00 00       	push   $0x3dcd
     37c:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     382:	e8 49 36 00 00       	call   39d0 <printf>
    exit();
     387:	e8 e6 34 00 00       	call   3872 <exit>
    printf(stdout, "fork failed\n");
     38c:	52                   	push   %edx
     38d:	52                   	push   %edx
     38e:	68 69 4c 00 00       	push   $0x4c69
     393:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     399:	e8 32 36 00 00       	call   39d0 <printf>
    exit();
     39e:	e8 cf 34 00 00       	call   3872 <exit>
    printf(stdout, "unlink failed\n");
     3a3:	50                   	push   %eax
     3a4:	50                   	push   %eax
     3a5:	68 e1 3d 00 00       	push   $0x3de1
     3aa:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     3b0:	e8 1b 36 00 00       	call   39d0 <printf>
    exit();
     3b5:	e8 b8 34 00 00       	call   3872 <exit>
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <opentest>:
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "open test\n");
     3c6:	68 02 3e 00 00       	push   $0x3e02
     3cb:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     3d1:	e8 fa 35 00 00       	call   39d0 <printf>
  fd = open("echo", 0);
     3d6:	58                   	pop    %eax
     3d7:	5a                   	pop    %edx
     3d8:	6a 00                	push   $0x0
     3da:	68 0d 3e 00 00       	push   $0x3e0d
     3df:	e8 ce 34 00 00       	call   38b2 <open>
  if(fd < 0){
     3e4:	83 c4 10             	add    $0x10,%esp
     3e7:	85 c0                	test   %eax,%eax
     3e9:	78 36                	js     421 <opentest+0x61>
  close(fd);
     3eb:	83 ec 0c             	sub    $0xc,%esp
     3ee:	50                   	push   %eax
     3ef:	e8 a6 34 00 00       	call   389a <close>
  fd = open("doesnotexist", 0);
     3f4:	5a                   	pop    %edx
     3f5:	59                   	pop    %ecx
     3f6:	6a 00                	push   $0x0
     3f8:	68 25 3e 00 00       	push   $0x3e25
     3fd:	e8 b0 34 00 00       	call   38b2 <open>
  if(fd >= 0){
     402:	83 c4 10             	add    $0x10,%esp
     405:	85 c0                	test   %eax,%eax
     407:	79 2f                	jns    438 <opentest+0x78>
  printf(stdout, "open test ok\n");
     409:	83 ec 08             	sub    $0x8,%esp
     40c:	68 50 3e 00 00       	push   $0x3e50
     411:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     417:	e8 b4 35 00 00       	call   39d0 <printf>
}
     41c:	83 c4 10             	add    $0x10,%esp
     41f:	c9                   	leave  
     420:	c3                   	ret    
    printf(stdout, "open echo failed!\n");
     421:	50                   	push   %eax
     422:	50                   	push   %eax
     423:	68 12 3e 00 00       	push   $0x3e12
     428:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     42e:	e8 9d 35 00 00       	call   39d0 <printf>
    exit();
     433:	e8 3a 34 00 00       	call   3872 <exit>
    printf(stdout, "open doesnotexist succeeded!\n");
     438:	50                   	push   %eax
     439:	50                   	push   %eax
     43a:	68 32 3e 00 00       	push   $0x3e32
     43f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     445:	e8 86 35 00 00       	call   39d0 <printf>
    exit();
     44a:	e8 23 34 00 00       	call   3872 <exit>
     44f:	90                   	nop

00000450 <writetest>:
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	56                   	push   %esi
     454:	53                   	push   %ebx
  printf(stdout, "small file test\n");
     455:	83 ec 08             	sub    $0x8,%esp
     458:	68 5e 3e 00 00       	push   $0x3e5e
     45d:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     463:	e8 68 35 00 00       	call   39d0 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     468:	58                   	pop    %eax
     469:	5a                   	pop    %edx
     46a:	68 02 02 00 00       	push   $0x202
     46f:	68 6f 3e 00 00       	push   $0x3e6f
     474:	e8 39 34 00 00       	call   38b2 <open>
  if(fd >= 0){
     479:	83 c4 10             	add    $0x10,%esp
     47c:	85 c0                	test   %eax,%eax
     47e:	0f 88 88 01 00 00    	js     60c <writetest+0x1bc>
    printf(stdout, "creat small succeeded; ok\n");
     484:	83 ec 08             	sub    $0x8,%esp
     487:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 100; i++){
     489:	31 db                	xor    %ebx,%ebx
    printf(stdout, "creat small succeeded; ok\n");
     48b:	68 75 3e 00 00       	push   $0x3e75
     490:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     496:	e8 35 35 00 00       	call   39d0 <printf>
     49b:	83 c4 10             	add    $0x10,%esp
     49e:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4a0:	83 ec 04             	sub    $0x4,%esp
     4a3:	6a 0a                	push   $0xa
     4a5:	68 ac 3e 00 00       	push   $0x3eac
     4aa:	56                   	push   %esi
     4ab:	e8 e2 33 00 00       	call   3892 <write>
     4b0:	83 c4 10             	add    $0x10,%esp
     4b3:	83 f8 0a             	cmp    $0xa,%eax
     4b6:	0f 85 d9 00 00 00    	jne    595 <writetest+0x145>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4bc:	83 ec 04             	sub    $0x4,%esp
     4bf:	6a 0a                	push   $0xa
     4c1:	68 b7 3e 00 00       	push   $0x3eb7
     4c6:	56                   	push   %esi
     4c7:	e8 c6 33 00 00       	call   3892 <write>
     4cc:	83 c4 10             	add    $0x10,%esp
     4cf:	83 f8 0a             	cmp    $0xa,%eax
     4d2:	0f 85 d6 00 00 00    	jne    5ae <writetest+0x15e>
  for(i = 0; i < 100; i++){
     4d8:	83 c3 01             	add    $0x1,%ebx
     4db:	83 fb 64             	cmp    $0x64,%ebx
     4de:	75 c0                	jne    4a0 <writetest+0x50>
  printf(stdout, "writes ok\n");
     4e0:	83 ec 08             	sub    $0x8,%esp
     4e3:	68 c2 3e 00 00       	push   $0x3ec2
     4e8:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     4ee:	e8 dd 34 00 00       	call   39d0 <printf>
  close(fd);
     4f3:	89 34 24             	mov    %esi,(%esp)
     4f6:	e8 9f 33 00 00       	call   389a <close>
  fd = open("small", O_RDONLY);
     4fb:	5b                   	pop    %ebx
     4fc:	5e                   	pop    %esi
     4fd:	6a 00                	push   $0x0
     4ff:	68 6f 3e 00 00       	push   $0x3e6f
     504:	e8 a9 33 00 00       	call   38b2 <open>
  if(fd >= 0){
     509:	83 c4 10             	add    $0x10,%esp
     50c:	85 c0                	test   %eax,%eax
  fd = open("small", O_RDONLY);
     50e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     510:	0f 88 b1 00 00 00    	js     5c7 <writetest+0x177>
    printf(stdout, "open small succeeded ok\n");
     516:	83 ec 08             	sub    $0x8,%esp
     519:	68 cd 3e 00 00       	push   $0x3ecd
     51e:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     524:	e8 a7 34 00 00       	call   39d0 <printf>
  i = read(fd, buf, 2000);
     529:	83 c4 0c             	add    $0xc,%esp
     52c:	68 d0 07 00 00       	push   $0x7d0
     531:	68 c0 85 00 00       	push   $0x85c0
     536:	53                   	push   %ebx
     537:	e8 4e 33 00 00       	call   388a <read>
  if(i == 2000){
     53c:	83 c4 10             	add    $0x10,%esp
     53f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     544:	0f 85 94 00 00 00    	jne    5de <writetest+0x18e>
    printf(stdout, "read succeeded ok\n");
     54a:	83 ec 08             	sub    $0x8,%esp
     54d:	68 01 3f 00 00       	push   $0x3f01
     552:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     558:	e8 73 34 00 00       	call   39d0 <printf>
  close(fd);
     55d:	89 1c 24             	mov    %ebx,(%esp)
     560:	e8 35 33 00 00       	call   389a <close>
  if(unlink("small") < 0){
     565:	c7 04 24 6f 3e 00 00 	movl   $0x3e6f,(%esp)
     56c:	e8 51 33 00 00       	call   38c2 <unlink>
     571:	83 c4 10             	add    $0x10,%esp
     574:	85 c0                	test   %eax,%eax
     576:	78 7d                	js     5f5 <writetest+0x1a5>
  printf(stdout, "small file test ok\n");
     578:	83 ec 08             	sub    $0x8,%esp
     57b:	68 29 3f 00 00       	push   $0x3f29
     580:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     586:	e8 45 34 00 00       	call   39d0 <printf>
}
     58b:	83 c4 10             	add    $0x10,%esp
     58e:	8d 65 f8             	lea    -0x8(%ebp),%esp
     591:	5b                   	pop    %ebx
     592:	5e                   	pop    %esi
     593:	5d                   	pop    %ebp
     594:	c3                   	ret    
      printf(stdout, "error: write aa %d new file failed\n", i);
     595:	83 ec 04             	sub    $0x4,%esp
     598:	53                   	push   %ebx
     599:	68 70 4d 00 00       	push   $0x4d70
     59e:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     5a4:	e8 27 34 00 00       	call   39d0 <printf>
      exit();
     5a9:	e8 c4 32 00 00       	call   3872 <exit>
      printf(stdout, "error: write bb %d new file failed\n", i);
     5ae:	83 ec 04             	sub    $0x4,%esp
     5b1:	53                   	push   %ebx
     5b2:	68 94 4d 00 00       	push   $0x4d94
     5b7:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     5bd:	e8 0e 34 00 00       	call   39d0 <printf>
      exit();
     5c2:	e8 ab 32 00 00       	call   3872 <exit>
    printf(stdout, "error: open small failed!\n");
     5c7:	51                   	push   %ecx
     5c8:	51                   	push   %ecx
     5c9:	68 e6 3e 00 00       	push   $0x3ee6
     5ce:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     5d4:	e8 f7 33 00 00       	call   39d0 <printf>
    exit();
     5d9:	e8 94 32 00 00       	call   3872 <exit>
    printf(stdout, "read failed\n");
     5de:	52                   	push   %edx
     5df:	52                   	push   %edx
     5e0:	68 2d 42 00 00       	push   $0x422d
     5e5:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     5eb:	e8 e0 33 00 00       	call   39d0 <printf>
    exit();
     5f0:	e8 7d 32 00 00       	call   3872 <exit>
    printf(stdout, "unlink small failed\n");
     5f5:	50                   	push   %eax
     5f6:	50                   	push   %eax
     5f7:	68 14 3f 00 00       	push   $0x3f14
     5fc:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     602:	e8 c9 33 00 00       	call   39d0 <printf>
    exit();
     607:	e8 66 32 00 00       	call   3872 <exit>
    printf(stdout, "error: creat small failed!\n");
     60c:	50                   	push   %eax
     60d:	50                   	push   %eax
     60e:	68 90 3e 00 00       	push   $0x3e90
     613:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     619:	e8 b2 33 00 00       	call   39d0 <printf>
    exit();
     61e:	e8 4f 32 00 00       	call   3872 <exit>
     623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <writetest1>:
{
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	56                   	push   %esi
     634:	53                   	push   %ebx
  printf(stdout, "big files test\n");
     635:	83 ec 08             	sub    $0x8,%esp
     638:	68 3d 3f 00 00       	push   $0x3f3d
     63d:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     643:	e8 88 33 00 00       	call   39d0 <printf>
  fd = open("big", O_CREATE|O_RDWR);
     648:	58                   	pop    %eax
     649:	5a                   	pop    %edx
     64a:	68 02 02 00 00       	push   $0x202
     64f:	68 b7 3f 00 00       	push   $0x3fb7
     654:	e8 59 32 00 00       	call   38b2 <open>
  if(fd < 0){
     659:	83 c4 10             	add    $0x10,%esp
     65c:	85 c0                	test   %eax,%eax
     65e:	0f 88 61 01 00 00    	js     7c5 <writetest1+0x195>
     664:	89 c6                	mov    %eax,%esi
  for(i = 0; i < MAXFILE; i++){
     666:	31 db                	xor    %ebx,%ebx
     668:	90                   	nop
     669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(write(fd, buf, 512) != 512){
     670:	83 ec 04             	sub    $0x4,%esp
    ((int*)buf)[0] = i;
     673:	89 1d c0 85 00 00    	mov    %ebx,0x85c0
    if(write(fd, buf, 512) != 512){
     679:	68 00 02 00 00       	push   $0x200
     67e:	68 c0 85 00 00       	push   $0x85c0
     683:	56                   	push   %esi
     684:	e8 09 32 00 00       	call   3892 <write>
     689:	83 c4 10             	add    $0x10,%esp
     68c:	3d 00 02 00 00       	cmp    $0x200,%eax
     691:	0f 85 b3 00 00 00    	jne    74a <writetest1+0x11a>
  for(i = 0; i < MAXFILE; i++){
     697:	83 c3 01             	add    $0x1,%ebx
     69a:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6a0:	75 ce                	jne    670 <writetest1+0x40>
  close(fd);
     6a2:	83 ec 0c             	sub    $0xc,%esp
     6a5:	56                   	push   %esi
     6a6:	e8 ef 31 00 00       	call   389a <close>
  fd = open("big", O_RDONLY);
     6ab:	5b                   	pop    %ebx
     6ac:	5e                   	pop    %esi
     6ad:	6a 00                	push   $0x0
     6af:	68 b7 3f 00 00       	push   $0x3fb7
     6b4:	e8 f9 31 00 00       	call   38b2 <open>
  if(fd < 0){
     6b9:	83 c4 10             	add    $0x10,%esp
     6bc:	85 c0                	test   %eax,%eax
  fd = open("big", O_RDONLY);
     6be:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6c0:	0f 88 e8 00 00 00    	js     7ae <writetest1+0x17e>
  n = 0;
     6c6:	31 db                	xor    %ebx,%ebx
     6c8:	eb 1d                	jmp    6e7 <writetest1+0xb7>
     6ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(i != 512){
     6d0:	3d 00 02 00 00       	cmp    $0x200,%eax
     6d5:	0f 85 9f 00 00 00    	jne    77a <writetest1+0x14a>
    if(((int*)buf)[0] != n){
     6db:	a1 c0 85 00 00       	mov    0x85c0,%eax
     6e0:	39 d8                	cmp    %ebx,%eax
     6e2:	75 7f                	jne    763 <writetest1+0x133>
    n++;
     6e4:	83 c3 01             	add    $0x1,%ebx
    i = read(fd, buf, 512);
     6e7:	83 ec 04             	sub    $0x4,%esp
     6ea:	68 00 02 00 00       	push   $0x200
     6ef:	68 c0 85 00 00       	push   $0x85c0
     6f4:	56                   	push   %esi
     6f5:	e8 90 31 00 00       	call   388a <read>
    if(i == 0){
     6fa:	83 c4 10             	add    $0x10,%esp
     6fd:	85 c0                	test   %eax,%eax
     6ff:	75 cf                	jne    6d0 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     701:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     707:	0f 84 86 00 00 00    	je     793 <writetest1+0x163>
  close(fd);
     70d:	83 ec 0c             	sub    $0xc,%esp
     710:	56                   	push   %esi
     711:	e8 84 31 00 00       	call   389a <close>
  if(unlink("big") < 0){
     716:	c7 04 24 b7 3f 00 00 	movl   $0x3fb7,(%esp)
     71d:	e8 a0 31 00 00       	call   38c2 <unlink>
     722:	83 c4 10             	add    $0x10,%esp
     725:	85 c0                	test   %eax,%eax
     727:	0f 88 af 00 00 00    	js     7dc <writetest1+0x1ac>
  printf(stdout, "big files ok\n");
     72d:	83 ec 08             	sub    $0x8,%esp
     730:	68 de 3f 00 00       	push   $0x3fde
     735:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     73b:	e8 90 32 00 00       	call   39d0 <printf>
}
     740:	83 c4 10             	add    $0x10,%esp
     743:	8d 65 f8             	lea    -0x8(%ebp),%esp
     746:	5b                   	pop    %ebx
     747:	5e                   	pop    %esi
     748:	5d                   	pop    %ebp
     749:	c3                   	ret    
      printf(stdout, "error: write big file failed\n", i);
     74a:	83 ec 04             	sub    $0x4,%esp
     74d:	53                   	push   %ebx
     74e:	68 67 3f 00 00       	push   $0x3f67
     753:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     759:	e8 72 32 00 00       	call   39d0 <printf>
      exit();
     75e:	e8 0f 31 00 00       	call   3872 <exit>
      printf(stdout, "read content of block %d is %d\n",
     763:	50                   	push   %eax
     764:	53                   	push   %ebx
     765:	68 b8 4d 00 00       	push   $0x4db8
     76a:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     770:	e8 5b 32 00 00       	call   39d0 <printf>
      exit();
     775:	e8 f8 30 00 00       	call   3872 <exit>
      printf(stdout, "read failed %d\n", i);
     77a:	83 ec 04             	sub    $0x4,%esp
     77d:	50                   	push   %eax
     77e:	68 bb 3f 00 00       	push   $0x3fbb
     783:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     789:	e8 42 32 00 00       	call   39d0 <printf>
      exit();
     78e:	e8 df 30 00 00       	call   3872 <exit>
        printf(stdout, "read only %d blocks from big", n);
     793:	52                   	push   %edx
     794:	68 8b 00 00 00       	push   $0x8b
     799:	68 9e 3f 00 00       	push   $0x3f9e
     79e:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     7a4:	e8 27 32 00 00       	call   39d0 <printf>
        exit();
     7a9:	e8 c4 30 00 00       	call   3872 <exit>
    printf(stdout, "error: open big failed!\n");
     7ae:	51                   	push   %ecx
     7af:	51                   	push   %ecx
     7b0:	68 85 3f 00 00       	push   $0x3f85
     7b5:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     7bb:	e8 10 32 00 00       	call   39d0 <printf>
    exit();
     7c0:	e8 ad 30 00 00       	call   3872 <exit>
    printf(stdout, "error: creat big failed!\n");
     7c5:	50                   	push   %eax
     7c6:	50                   	push   %eax
     7c7:	68 4d 3f 00 00       	push   $0x3f4d
     7cc:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     7d2:	e8 f9 31 00 00       	call   39d0 <printf>
    exit();
     7d7:	e8 96 30 00 00       	call   3872 <exit>
    printf(stdout, "unlink big failed\n");
     7dc:	50                   	push   %eax
     7dd:	50                   	push   %eax
     7de:	68 cb 3f 00 00       	push   $0x3fcb
     7e3:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     7e9:	e8 e2 31 00 00       	call   39d0 <printf>
    exit();
     7ee:	e8 7f 30 00 00       	call   3872 <exit>
     7f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000800 <createtest>:
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	53                   	push   %ebx
  name[2] = '\0';
     804:	bb 30 00 00 00       	mov    $0x30,%ebx
{
     809:	83 ec 0c             	sub    $0xc,%esp
  printf(stdout, "many creates, followed by unlink test\n");
     80c:	68 d8 4d 00 00       	push   $0x4dd8
     811:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     817:	e8 b4 31 00 00       	call   39d0 <printf>
  name[0] = 'a';
     81c:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
  name[2] = '\0';
     823:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     82a:	83 c4 10             	add    $0x10,%esp
     82d:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open(name, O_CREATE|O_RDWR);
     830:	83 ec 08             	sub    $0x8,%esp
    name[1] = '0' + i;
     833:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     839:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     83c:	68 02 02 00 00       	push   $0x202
     841:	68 c0 a5 00 00       	push   $0xa5c0
     846:	e8 67 30 00 00       	call   38b2 <open>
    close(fd);
     84b:	89 04 24             	mov    %eax,(%esp)
     84e:	e8 47 30 00 00       	call   389a <close>
  for(i = 0; i < 52; i++){
     853:	83 c4 10             	add    $0x10,%esp
     856:	80 fb 64             	cmp    $0x64,%bl
     859:	75 d5                	jne    830 <createtest+0x30>
  name[0] = 'a';
     85b:	c6 05 c0 a5 00 00 61 	movb   $0x61,0xa5c0
  name[2] = '\0';
     862:	c6 05 c2 a5 00 00 00 	movb   $0x0,0xa5c2
     869:	bb 30 00 00 00       	mov    $0x30,%ebx
     86e:	66 90                	xchg   %ax,%ax
    unlink(name);
     870:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + i;
     873:	88 1d c1 a5 00 00    	mov    %bl,0xa5c1
     879:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     87c:	68 c0 a5 00 00       	push   $0xa5c0
     881:	e8 3c 30 00 00       	call   38c2 <unlink>
  for(i = 0; i < 52; i++){
     886:	83 c4 10             	add    $0x10,%esp
     889:	80 fb 64             	cmp    $0x64,%bl
     88c:	75 e2                	jne    870 <createtest+0x70>
  printf(stdout, "many creates, followed by unlink; ok\n");
     88e:	83 ec 08             	sub    $0x8,%esp
     891:	68 00 4e 00 00       	push   $0x4e00
     896:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     89c:	e8 2f 31 00 00       	call   39d0 <printf>
}
     8a1:	83 c4 10             	add    $0x10,%esp
     8a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     8a7:	c9                   	leave  
     8a8:	c3                   	ret    
     8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008b0 <dirtest>:
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "mkdir test\n");
     8b6:	68 ec 3f 00 00       	push   $0x3fec
     8bb:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     8c1:	e8 0a 31 00 00       	call   39d0 <printf>
  if(mkdir("dir0") < 0){
     8c6:	c7 04 24 f8 3f 00 00 	movl   $0x3ff8,(%esp)
     8cd:	e8 08 30 00 00       	call   38da <mkdir>
     8d2:	83 c4 10             	add    $0x10,%esp
     8d5:	85 c0                	test   %eax,%eax
     8d7:	78 58                	js     931 <dirtest+0x81>
  if(chdir("dir0") < 0){
     8d9:	83 ec 0c             	sub    $0xc,%esp
     8dc:	68 f8 3f 00 00       	push   $0x3ff8
     8e1:	e8 fc 2f 00 00       	call   38e2 <chdir>
     8e6:	83 c4 10             	add    $0x10,%esp
     8e9:	85 c0                	test   %eax,%eax
     8eb:	0f 88 85 00 00 00    	js     976 <dirtest+0xc6>
  if(chdir("..") < 0){
     8f1:	83 ec 0c             	sub    $0xc,%esp
     8f4:	68 9d 45 00 00       	push   $0x459d
     8f9:	e8 e4 2f 00 00       	call   38e2 <chdir>
     8fe:	83 c4 10             	add    $0x10,%esp
     901:	85 c0                	test   %eax,%eax
     903:	78 5a                	js     95f <dirtest+0xaf>
  if(unlink("dir0") < 0){
     905:	83 ec 0c             	sub    $0xc,%esp
     908:	68 f8 3f 00 00       	push   $0x3ff8
     90d:	e8 b0 2f 00 00       	call   38c2 <unlink>
     912:	83 c4 10             	add    $0x10,%esp
     915:	85 c0                	test   %eax,%eax
     917:	78 2f                	js     948 <dirtest+0x98>
  printf(stdout, "mkdir test ok\n");
     919:	83 ec 08             	sub    $0x8,%esp
     91c:	68 35 40 00 00       	push   $0x4035
     921:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     927:	e8 a4 30 00 00       	call   39d0 <printf>
}
     92c:	83 c4 10             	add    $0x10,%esp
     92f:	c9                   	leave  
     930:	c3                   	ret    
    printf(stdout, "mkdir failed\n");
     931:	50                   	push   %eax
     932:	50                   	push   %eax
     933:	68 28 3d 00 00       	push   $0x3d28
     938:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     93e:	e8 8d 30 00 00       	call   39d0 <printf>
    exit();
     943:	e8 2a 2f 00 00       	call   3872 <exit>
    printf(stdout, "unlink dir0 failed\n");
     948:	50                   	push   %eax
     949:	50                   	push   %eax
     94a:	68 21 40 00 00       	push   $0x4021
     94f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     955:	e8 76 30 00 00       	call   39d0 <printf>
    exit();
     95a:	e8 13 2f 00 00       	call   3872 <exit>
    printf(stdout, "chdir .. failed\n");
     95f:	52                   	push   %edx
     960:	52                   	push   %edx
     961:	68 10 40 00 00       	push   $0x4010
     966:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     96c:	e8 5f 30 00 00       	call   39d0 <printf>
    exit();
     971:	e8 fc 2e 00 00       	call   3872 <exit>
    printf(stdout, "chdir dir0 failed\n");
     976:	51                   	push   %ecx
     977:	51                   	push   %ecx
     978:	68 fd 3f 00 00       	push   $0x3ffd
     97d:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     983:	e8 48 30 00 00       	call   39d0 <printf>
    exit();
     988:	e8 e5 2e 00 00       	call   3872 <exit>
     98d:	8d 76 00             	lea    0x0(%esi),%esi

00000990 <exectest>:
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "exec test\n");
     996:	68 44 40 00 00       	push   $0x4044
     99b:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     9a1:	e8 2a 30 00 00       	call   39d0 <printf>
  if(exec("echo", echoargv) < 0){
     9a6:	5a                   	pop    %edx
     9a7:	59                   	pop    %ecx
     9a8:	68 dc 5d 00 00       	push   $0x5ddc
     9ad:	68 0d 3e 00 00       	push   $0x3e0d
     9b2:	e8 f3 2e 00 00       	call   38aa <exec>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	78 02                	js     9c0 <exectest+0x30>
}
     9be:	c9                   	leave  
     9bf:	c3                   	ret    
    printf(stdout, "exec echo failed\n");
     9c0:	50                   	push   %eax
     9c1:	50                   	push   %eax
     9c2:	68 4f 40 00 00       	push   $0x404f
     9c7:	ff 35 d8 5d 00 00    	pushl  0x5dd8
     9cd:	e8 fe 2f 00 00       	call   39d0 <printf>
    exit();
     9d2:	e8 9b 2e 00 00       	call   3872 <exit>
     9d7:	89 f6                	mov    %esi,%esi
     9d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009e0 <pipe1>:
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	57                   	push   %edi
     9e4:	56                   	push   %esi
     9e5:	53                   	push   %ebx
  if(pipe(fds) != 0){
     9e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
     9e9:	83 ec 38             	sub    $0x38,%esp
  if(pipe(fds) != 0){
     9ec:	50                   	push   %eax
     9ed:	e8 90 2e 00 00       	call   3882 <pipe>
     9f2:	83 c4 10             	add    $0x10,%esp
     9f5:	85 c0                	test   %eax,%eax
     9f7:	0f 85 3e 01 00 00    	jne    b3b <pipe1+0x15b>
     9fd:	89 c3                	mov    %eax,%ebx
  pid = fork();
     9ff:	e8 66 2e 00 00       	call   386a <fork>
  if(pid == 0){
     a04:	83 f8 00             	cmp    $0x0,%eax
     a07:	0f 84 84 00 00 00    	je     a91 <pipe1+0xb1>
  } else if(pid > 0){
     a0d:	0f 8e 3b 01 00 00    	jle    b4e <pipe1+0x16e>
    close(fds[1]);
     a13:	83 ec 0c             	sub    $0xc,%esp
     a16:	ff 75 e4             	pushl  -0x1c(%ebp)
    cc = 1;
     a19:	bf 01 00 00 00       	mov    $0x1,%edi
    close(fds[1]);
     a1e:	e8 77 2e 00 00       	call   389a <close>
    while((n = read(fds[0], buf, cc)) > 0){
     a23:	83 c4 10             	add    $0x10,%esp
    total = 0;
     a26:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     a2d:	83 ec 04             	sub    $0x4,%esp
     a30:	57                   	push   %edi
     a31:	68 c0 85 00 00       	push   $0x85c0
     a36:	ff 75 e0             	pushl  -0x20(%ebp)
     a39:	e8 4c 2e 00 00       	call   388a <read>
     a3e:	83 c4 10             	add    $0x10,%esp
     a41:	85 c0                	test   %eax,%eax
     a43:	0f 8e ab 00 00 00    	jle    af4 <pipe1+0x114>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a49:	89 d9                	mov    %ebx,%ecx
     a4b:	8d 34 18             	lea    (%eax,%ebx,1),%esi
     a4e:	f7 d9                	neg    %ecx
     a50:	38 9c 0b c0 85 00 00 	cmp    %bl,0x85c0(%ebx,%ecx,1)
     a57:	8d 53 01             	lea    0x1(%ebx),%edx
     a5a:	75 1b                	jne    a77 <pipe1+0x97>
      for(i = 0; i < n; i++){
     a5c:	39 f2                	cmp    %esi,%edx
     a5e:	89 d3                	mov    %edx,%ebx
     a60:	75 ee                	jne    a50 <pipe1+0x70>
      cc = cc * 2;
     a62:	01 ff                	add    %edi,%edi
      total += n;
     a64:	01 45 d4             	add    %eax,-0x2c(%ebp)
     a67:	b8 00 20 00 00       	mov    $0x2000,%eax
     a6c:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     a72:	0f 4f f8             	cmovg  %eax,%edi
     a75:	eb b6                	jmp    a2d <pipe1+0x4d>
          printf(1, "pipe1 oops 2\n");
     a77:	83 ec 08             	sub    $0x8,%esp
     a7a:	68 7e 40 00 00       	push   $0x407e
     a7f:	6a 01                	push   $0x1
     a81:	e8 4a 2f 00 00       	call   39d0 <printf>
          return;
     a86:	83 c4 10             	add    $0x10,%esp
}
     a89:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a8c:	5b                   	pop    %ebx
     a8d:	5e                   	pop    %esi
     a8e:	5f                   	pop    %edi
     a8f:	5d                   	pop    %ebp
     a90:	c3                   	ret    
    close(fds[0]);
     a91:	83 ec 0c             	sub    $0xc,%esp
     a94:	ff 75 e0             	pushl  -0x20(%ebp)
     a97:	31 db                	xor    %ebx,%ebx
     a99:	be 09 04 00 00       	mov    $0x409,%esi
     a9e:	e8 f7 2d 00 00       	call   389a <close>
     aa3:	83 c4 10             	add    $0x10,%esp
     aa6:	89 d8                	mov    %ebx,%eax
     aa8:	89 f2                	mov    %esi,%edx
     aaa:	f7 d8                	neg    %eax
     aac:	29 da                	sub    %ebx,%edx
     aae:	66 90                	xchg   %ax,%ax
        buf[i] = seq++;
     ab0:	88 84 03 c0 85 00 00 	mov    %al,0x85c0(%ebx,%eax,1)
     ab7:	83 c0 01             	add    $0x1,%eax
      for(i = 0; i < 1033; i++)
     aba:	39 d0                	cmp    %edx,%eax
     abc:	75 f2                	jne    ab0 <pipe1+0xd0>
      if(write(fds[1], buf, 1033) != 1033){
     abe:	83 ec 04             	sub    $0x4,%esp
     ac1:	68 09 04 00 00       	push   $0x409
     ac6:	68 c0 85 00 00       	push   $0x85c0
     acb:	ff 75 e4             	pushl  -0x1c(%ebp)
     ace:	e8 bf 2d 00 00       	call   3892 <write>
     ad3:	83 c4 10             	add    $0x10,%esp
     ad6:	3d 09 04 00 00       	cmp    $0x409,%eax
     adb:	0f 85 80 00 00 00    	jne    b61 <pipe1+0x181>
     ae1:	81 eb 09 04 00 00    	sub    $0x409,%ebx
    for(n = 0; n < 5; n++){
     ae7:	81 fb d3 eb ff ff    	cmp    $0xffffebd3,%ebx
     aed:	75 b7                	jne    aa6 <pipe1+0xc6>
    exit();
     aef:	e8 7e 2d 00 00       	call   3872 <exit>
    if(total != 5 * 1033){
     af4:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     afb:	75 29                	jne    b26 <pipe1+0x146>
    close(fds[0]);
     afd:	83 ec 0c             	sub    $0xc,%esp
     b00:	ff 75 e0             	pushl  -0x20(%ebp)
     b03:	e8 92 2d 00 00       	call   389a <close>
    wait();
     b08:	e8 6d 2d 00 00       	call   387a <wait>
  printf(1, "pipe1 ok\n");
     b0d:	5a                   	pop    %edx
     b0e:	59                   	pop    %ecx
     b0f:	68 a3 40 00 00       	push   $0x40a3
     b14:	6a 01                	push   $0x1
     b16:	e8 b5 2e 00 00       	call   39d0 <printf>
     b1b:	83 c4 10             	add    $0x10,%esp
}
     b1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b21:	5b                   	pop    %ebx
     b22:	5e                   	pop    %esi
     b23:	5f                   	pop    %edi
     b24:	5d                   	pop    %ebp
     b25:	c3                   	ret    
      printf(1, "pipe1 oops 3 total %d\n", total);
     b26:	53                   	push   %ebx
     b27:	ff 75 d4             	pushl  -0x2c(%ebp)
     b2a:	68 8c 40 00 00       	push   $0x408c
     b2f:	6a 01                	push   $0x1
     b31:	e8 9a 2e 00 00       	call   39d0 <printf>
      exit();
     b36:	e8 37 2d 00 00       	call   3872 <exit>
    printf(1, "pipe() failed\n");
     b3b:	57                   	push   %edi
     b3c:	57                   	push   %edi
     b3d:	68 61 40 00 00       	push   $0x4061
     b42:	6a 01                	push   $0x1
     b44:	e8 87 2e 00 00       	call   39d0 <printf>
    exit();
     b49:	e8 24 2d 00 00       	call   3872 <exit>
    printf(1, "fork() failed\n");
     b4e:	50                   	push   %eax
     b4f:	50                   	push   %eax
     b50:	68 ad 40 00 00       	push   $0x40ad
     b55:	6a 01                	push   $0x1
     b57:	e8 74 2e 00 00       	call   39d0 <printf>
    exit();
     b5c:	e8 11 2d 00 00       	call   3872 <exit>
        printf(1, "pipe1 oops 1\n");
     b61:	56                   	push   %esi
     b62:	56                   	push   %esi
     b63:	68 70 40 00 00       	push   $0x4070
     b68:	6a 01                	push   $0x1
     b6a:	e8 61 2e 00 00       	call   39d0 <printf>
        exit();
     b6f:	e8 fe 2c 00 00       	call   3872 <exit>
     b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b80 <preempt>:
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	57                   	push   %edi
     b84:	56                   	push   %esi
     b85:	53                   	push   %ebx
     b86:	83 ec 24             	sub    $0x24,%esp
  printf(1, "preempt: ");
     b89:	68 bc 40 00 00       	push   $0x40bc
     b8e:	6a 01                	push   $0x1
     b90:	e8 3b 2e 00 00       	call   39d0 <printf>
  pid1 = fork();
     b95:	e8 d0 2c 00 00       	call   386a <fork>
  if(pid1 == 0)
     b9a:	83 c4 10             	add    $0x10,%esp
     b9d:	85 c0                	test   %eax,%eax
     b9f:	75 02                	jne    ba3 <preempt+0x23>
     ba1:	eb fe                	jmp    ba1 <preempt+0x21>
     ba3:	89 c7                	mov    %eax,%edi
  pid2 = fork();
     ba5:	e8 c0 2c 00 00       	call   386a <fork>
  if(pid2 == 0)
     baa:	85 c0                	test   %eax,%eax
  pid2 = fork();
     bac:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     bae:	75 02                	jne    bb2 <preempt+0x32>
     bb0:	eb fe                	jmp    bb0 <preempt+0x30>
  pipe(pfds);
     bb2:	8d 45 e0             	lea    -0x20(%ebp),%eax
     bb5:	83 ec 0c             	sub    $0xc,%esp
     bb8:	50                   	push   %eax
     bb9:	e8 c4 2c 00 00       	call   3882 <pipe>
  pid3 = fork();
     bbe:	e8 a7 2c 00 00       	call   386a <fork>
  if(pid3 == 0){
     bc3:	83 c4 10             	add    $0x10,%esp
     bc6:	85 c0                	test   %eax,%eax
  pid3 = fork();
     bc8:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     bca:	75 46                	jne    c12 <preempt+0x92>
    close(pfds[0]);
     bcc:	83 ec 0c             	sub    $0xc,%esp
     bcf:	ff 75 e0             	pushl  -0x20(%ebp)
     bd2:	e8 c3 2c 00 00       	call   389a <close>
    if(write(pfds[1], "x", 1) != 1)
     bd7:	83 c4 0c             	add    $0xc,%esp
     bda:	6a 01                	push   $0x1
     bdc:	68 81 46 00 00       	push   $0x4681
     be1:	ff 75 e4             	pushl  -0x1c(%ebp)
     be4:	e8 a9 2c 00 00       	call   3892 <write>
     be9:	83 c4 10             	add    $0x10,%esp
     bec:	83 e8 01             	sub    $0x1,%eax
     bef:	74 11                	je     c02 <preempt+0x82>
      printf(1, "preempt write error");
     bf1:	50                   	push   %eax
     bf2:	50                   	push   %eax
     bf3:	68 c6 40 00 00       	push   $0x40c6
     bf8:	6a 01                	push   $0x1
     bfa:	e8 d1 2d 00 00       	call   39d0 <printf>
     bff:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c02:	83 ec 0c             	sub    $0xc,%esp
     c05:	ff 75 e4             	pushl  -0x1c(%ebp)
     c08:	e8 8d 2c 00 00       	call   389a <close>
     c0d:	83 c4 10             	add    $0x10,%esp
     c10:	eb fe                	jmp    c10 <preempt+0x90>
  close(pfds[1]);
     c12:	83 ec 0c             	sub    $0xc,%esp
     c15:	ff 75 e4             	pushl  -0x1c(%ebp)
     c18:	e8 7d 2c 00 00       	call   389a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c1d:	83 c4 0c             	add    $0xc,%esp
     c20:	68 00 20 00 00       	push   $0x2000
     c25:	68 c0 85 00 00       	push   $0x85c0
     c2a:	ff 75 e0             	pushl  -0x20(%ebp)
     c2d:	e8 58 2c 00 00       	call   388a <read>
     c32:	83 c4 10             	add    $0x10,%esp
     c35:	83 e8 01             	sub    $0x1,%eax
     c38:	74 19                	je     c53 <preempt+0xd3>
    printf(1, "preempt read error");
     c3a:	50                   	push   %eax
     c3b:	50                   	push   %eax
     c3c:	68 da 40 00 00       	push   $0x40da
     c41:	6a 01                	push   $0x1
     c43:	e8 88 2d 00 00       	call   39d0 <printf>
    return;
     c48:	83 c4 10             	add    $0x10,%esp
}
     c4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c4e:	5b                   	pop    %ebx
     c4f:	5e                   	pop    %esi
     c50:	5f                   	pop    %edi
     c51:	5d                   	pop    %ebp
     c52:	c3                   	ret    
  close(pfds[0]);
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	ff 75 e0             	pushl  -0x20(%ebp)
     c59:	e8 3c 2c 00 00       	call   389a <close>
  printf(1, "kill... ");
     c5e:	58                   	pop    %eax
     c5f:	5a                   	pop    %edx
     c60:	68 ed 40 00 00       	push   $0x40ed
     c65:	6a 01                	push   $0x1
     c67:	e8 64 2d 00 00       	call   39d0 <printf>
  kill(pid1);
     c6c:	89 3c 24             	mov    %edi,(%esp)
     c6f:	e8 2e 2c 00 00       	call   38a2 <kill>
  kill(pid2);
     c74:	89 34 24             	mov    %esi,(%esp)
     c77:	e8 26 2c 00 00       	call   38a2 <kill>
  kill(pid3);
     c7c:	89 1c 24             	mov    %ebx,(%esp)
     c7f:	e8 1e 2c 00 00       	call   38a2 <kill>
  printf(1, "wait... ");
     c84:	59                   	pop    %ecx
     c85:	5b                   	pop    %ebx
     c86:	68 f6 40 00 00       	push   $0x40f6
     c8b:	6a 01                	push   $0x1
     c8d:	e8 3e 2d 00 00       	call   39d0 <printf>
  wait();
     c92:	e8 e3 2b 00 00       	call   387a <wait>
  wait();
     c97:	e8 de 2b 00 00       	call   387a <wait>
  wait();
     c9c:	e8 d9 2b 00 00       	call   387a <wait>
  printf(1, "preempt ok\n");
     ca1:	5e                   	pop    %esi
     ca2:	5f                   	pop    %edi
     ca3:	68 ff 40 00 00       	push   $0x40ff
     ca8:	6a 01                	push   $0x1
     caa:	e8 21 2d 00 00       	call   39d0 <printf>
     caf:	83 c4 10             	add    $0x10,%esp
     cb2:	eb 97                	jmp    c4b <preempt+0xcb>
     cb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     cba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000cc0 <exitwait>:
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	56                   	push   %esi
     cc4:	be 64 00 00 00       	mov    $0x64,%esi
     cc9:	53                   	push   %ebx
     cca:	eb 14                	jmp    ce0 <exitwait+0x20>
     ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid){
     cd0:	74 6f                	je     d41 <exitwait+0x81>
      if(wait() != pid){
     cd2:	e8 a3 2b 00 00       	call   387a <wait>
     cd7:	39 d8                	cmp    %ebx,%eax
     cd9:	75 2d                	jne    d08 <exitwait+0x48>
  for(i = 0; i < 100; i++){
     cdb:	83 ee 01             	sub    $0x1,%esi
     cde:	74 48                	je     d28 <exitwait+0x68>
    pid = fork();
     ce0:	e8 85 2b 00 00       	call   386a <fork>
    if(pid < 0){
     ce5:	85 c0                	test   %eax,%eax
    pid = fork();
     ce7:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     ce9:	79 e5                	jns    cd0 <exitwait+0x10>
      printf(1, "fork failed\n");
     ceb:	83 ec 08             	sub    $0x8,%esp
     cee:	68 69 4c 00 00       	push   $0x4c69
     cf3:	6a 01                	push   $0x1
     cf5:	e8 d6 2c 00 00       	call   39d0 <printf>
      return;
     cfa:	83 c4 10             	add    $0x10,%esp
}
     cfd:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d00:	5b                   	pop    %ebx
     d01:	5e                   	pop    %esi
     d02:	5d                   	pop    %ebp
     d03:	c3                   	ret    
     d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "wait wrong pid\n");
     d08:	83 ec 08             	sub    $0x8,%esp
     d0b:	68 0b 41 00 00       	push   $0x410b
     d10:	6a 01                	push   $0x1
     d12:	e8 b9 2c 00 00       	call   39d0 <printf>
        return;
     d17:	83 c4 10             	add    $0x10,%esp
}
     d1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d1d:	5b                   	pop    %ebx
     d1e:	5e                   	pop    %esi
     d1f:	5d                   	pop    %ebp
     d20:	c3                   	ret    
     d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  printf(1, "exitwait ok\n");
     d28:	83 ec 08             	sub    $0x8,%esp
     d2b:	68 1b 41 00 00       	push   $0x411b
     d30:	6a 01                	push   $0x1
     d32:	e8 99 2c 00 00       	call   39d0 <printf>
     d37:	83 c4 10             	add    $0x10,%esp
}
     d3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5d                   	pop    %ebp
     d40:	c3                   	ret    
      exit();
     d41:	e8 2c 2b 00 00       	call   3872 <exit>
     d46:	8d 76 00             	lea    0x0(%esi),%esi
     d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d50 <mem>:
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	57                   	push   %edi
     d54:	56                   	push   %esi
     d55:	53                   	push   %ebx
     d56:	31 db                	xor    %ebx,%ebx
     d58:	83 ec 14             	sub    $0x14,%esp
  printf(1, "mem test\n");
     d5b:	68 28 41 00 00       	push   $0x4128
     d60:	6a 01                	push   $0x1
     d62:	e8 69 2c 00 00       	call   39d0 <printf>
  ppid = getpid();
     d67:	e8 86 2b 00 00       	call   38f2 <getpid>
     d6c:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     d6e:	e8 f7 2a 00 00       	call   386a <fork>
     d73:	83 c4 10             	add    $0x10,%esp
     d76:	85 c0                	test   %eax,%eax
     d78:	74 0a                	je     d84 <mem+0x34>
     d7a:	e9 89 00 00 00       	jmp    e08 <mem+0xb8>
     d7f:	90                   	nop
      *(char**)m2 = m1;
     d80:	89 18                	mov    %ebx,(%eax)
     d82:	89 c3                	mov    %eax,%ebx
    while((m2 = malloc(10001)) != 0){
     d84:	83 ec 0c             	sub    $0xc,%esp
     d87:	68 11 27 00 00       	push   $0x2711
     d8c:	e8 9f 2e 00 00       	call   3c30 <malloc>
     d91:	83 c4 10             	add    $0x10,%esp
     d94:	85 c0                	test   %eax,%eax
     d96:	75 e8                	jne    d80 <mem+0x30>
    while(m1){
     d98:	85 db                	test   %ebx,%ebx
     d9a:	74 18                	je     db4 <mem+0x64>
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m2 = *(char**)m1;
     da0:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     da2:	83 ec 0c             	sub    $0xc,%esp
     da5:	53                   	push   %ebx
     da6:	89 fb                	mov    %edi,%ebx
     da8:	e8 f3 2d 00 00       	call   3ba0 <free>
    while(m1){
     dad:	83 c4 10             	add    $0x10,%esp
     db0:	85 db                	test   %ebx,%ebx
     db2:	75 ec                	jne    da0 <mem+0x50>
    m1 = malloc(1024*20);
     db4:	83 ec 0c             	sub    $0xc,%esp
     db7:	68 00 50 00 00       	push   $0x5000
     dbc:	e8 6f 2e 00 00       	call   3c30 <malloc>
    if(m1 == 0){
     dc1:	83 c4 10             	add    $0x10,%esp
     dc4:	85 c0                	test   %eax,%eax
     dc6:	74 20                	je     de8 <mem+0x98>
    free(m1);
     dc8:	83 ec 0c             	sub    $0xc,%esp
     dcb:	50                   	push   %eax
     dcc:	e8 cf 2d 00 00       	call   3ba0 <free>
    printf(1, "mem ok\n");
     dd1:	58                   	pop    %eax
     dd2:	5a                   	pop    %edx
     dd3:	68 4c 41 00 00       	push   $0x414c
     dd8:	6a 01                	push   $0x1
     dda:	e8 f1 2b 00 00       	call   39d0 <printf>
    exit();
     ddf:	e8 8e 2a 00 00       	call   3872 <exit>
     de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "couldn't allocate mem?!!\n");
     de8:	83 ec 08             	sub    $0x8,%esp
     deb:	68 32 41 00 00       	push   $0x4132
     df0:	6a 01                	push   $0x1
     df2:	e8 d9 2b 00 00       	call   39d0 <printf>
      kill(ppid);
     df7:	89 34 24             	mov    %esi,(%esp)
     dfa:	e8 a3 2a 00 00       	call   38a2 <kill>
      exit();
     dff:	e8 6e 2a 00 00       	call   3872 <exit>
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
     e08:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e0b:	5b                   	pop    %ebx
     e0c:	5e                   	pop    %esi
     e0d:	5f                   	pop    %edi
     e0e:	5d                   	pop    %ebp
    wait();
     e0f:	e9 66 2a 00 00       	jmp    387a <wait>
     e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000e20 <sharedfd>:
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
     e25:	53                   	push   %ebx
     e26:	83 ec 34             	sub    $0x34,%esp
  printf(1, "sharedfd test\n");
     e29:	68 54 41 00 00       	push   $0x4154
     e2e:	6a 01                	push   $0x1
     e30:	e8 9b 2b 00 00       	call   39d0 <printf>
  unlink("sharedfd");
     e35:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     e3c:	e8 81 2a 00 00       	call   38c2 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e41:	59                   	pop    %ecx
     e42:	5b                   	pop    %ebx
     e43:	68 02 02 00 00       	push   $0x202
     e48:	68 63 41 00 00       	push   $0x4163
     e4d:	e8 60 2a 00 00       	call   38b2 <open>
  if(fd < 0){
     e52:	83 c4 10             	add    $0x10,%esp
     e55:	85 c0                	test   %eax,%eax
     e57:	0f 88 33 01 00 00    	js     f90 <sharedfd+0x170>
     e5d:	89 c6                	mov    %eax,%esi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e5f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
  pid = fork();
     e64:	e8 01 2a 00 00       	call   386a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e69:	83 f8 01             	cmp    $0x1,%eax
  pid = fork();
     e6c:	89 c7                	mov    %eax,%edi
  memset(buf, pid==0?'c':'p', sizeof(buf));
     e6e:	19 c0                	sbb    %eax,%eax
     e70:	83 ec 04             	sub    $0x4,%esp
     e73:	83 e0 f3             	and    $0xfffffff3,%eax
     e76:	6a 0a                	push   $0xa
     e78:	83 c0 70             	add    $0x70,%eax
     e7b:	50                   	push   %eax
     e7c:	8d 45 de             	lea    -0x22(%ebp),%eax
     e7f:	50                   	push   %eax
     e80:	e8 4b 28 00 00       	call   36d0 <memset>
     e85:	83 c4 10             	add    $0x10,%esp
     e88:	eb 0b                	jmp    e95 <sharedfd+0x75>
     e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 1000; i++){
     e90:	83 eb 01             	sub    $0x1,%ebx
     e93:	74 29                	je     ebe <sharedfd+0x9e>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     e95:	8d 45 de             	lea    -0x22(%ebp),%eax
     e98:	83 ec 04             	sub    $0x4,%esp
     e9b:	6a 0a                	push   $0xa
     e9d:	50                   	push   %eax
     e9e:	56                   	push   %esi
     e9f:	e8 ee 29 00 00       	call   3892 <write>
     ea4:	83 c4 10             	add    $0x10,%esp
     ea7:	83 f8 0a             	cmp    $0xa,%eax
     eaa:	74 e4                	je     e90 <sharedfd+0x70>
      printf(1, "fstests: write sharedfd failed\n");
     eac:	83 ec 08             	sub    $0x8,%esp
     eaf:	68 54 4e 00 00       	push   $0x4e54
     eb4:	6a 01                	push   $0x1
     eb6:	e8 15 2b 00 00       	call   39d0 <printf>
      break;
     ebb:	83 c4 10             	add    $0x10,%esp
  if(pid == 0)
     ebe:	85 ff                	test   %edi,%edi
     ec0:	0f 84 fe 00 00 00    	je     fc4 <sharedfd+0x1a4>
    wait();
     ec6:	e8 af 29 00 00       	call   387a <wait>
  close(fd);
     ecb:	83 ec 0c             	sub    $0xc,%esp
  nc = np = 0;
     ece:	31 db                	xor    %ebx,%ebx
     ed0:	31 ff                	xor    %edi,%edi
  close(fd);
     ed2:	56                   	push   %esi
     ed3:	8d 75 e8             	lea    -0x18(%ebp),%esi
     ed6:	e8 bf 29 00 00       	call   389a <close>
  fd = open("sharedfd", 0);
     edb:	58                   	pop    %eax
     edc:	5a                   	pop    %edx
     edd:	6a 00                	push   $0x0
     edf:	68 63 41 00 00       	push   $0x4163
     ee4:	e8 c9 29 00 00       	call   38b2 <open>
  if(fd < 0){
     ee9:	83 c4 10             	add    $0x10,%esp
     eec:	85 c0                	test   %eax,%eax
  fd = open("sharedfd", 0);
     eee:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
     ef1:	0f 88 b3 00 00 00    	js     faa <sharedfd+0x18a>
     ef7:	89 f8                	mov    %edi,%eax
     ef9:	89 df                	mov    %ebx,%edi
     efb:	89 c3                	mov    %eax,%ebx
     efd:	8d 76 00             	lea    0x0(%esi),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f00:	8d 45 de             	lea    -0x22(%ebp),%eax
     f03:	83 ec 04             	sub    $0x4,%esp
     f06:	6a 0a                	push   $0xa
     f08:	50                   	push   %eax
     f09:	ff 75 d4             	pushl  -0x2c(%ebp)
     f0c:	e8 79 29 00 00       	call   388a <read>
     f11:	83 c4 10             	add    $0x10,%esp
     f14:	85 c0                	test   %eax,%eax
     f16:	7e 28                	jle    f40 <sharedfd+0x120>
     f18:	8d 45 de             	lea    -0x22(%ebp),%eax
     f1b:	eb 15                	jmp    f32 <sharedfd+0x112>
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
        np++;
     f20:	80 fa 70             	cmp    $0x70,%dl
     f23:	0f 94 c2             	sete   %dl
     f26:	0f b6 d2             	movzbl %dl,%edx
     f29:	01 d7                	add    %edx,%edi
     f2b:	83 c0 01             	add    $0x1,%eax
    for(i = 0; i < sizeof(buf); i++){
     f2e:	39 f0                	cmp    %esi,%eax
     f30:	74 ce                	je     f00 <sharedfd+0xe0>
      if(buf[i] == 'c')
     f32:	0f b6 10             	movzbl (%eax),%edx
     f35:	80 fa 63             	cmp    $0x63,%dl
     f38:	75 e6                	jne    f20 <sharedfd+0x100>
        nc++;
     f3a:	83 c3 01             	add    $0x1,%ebx
     f3d:	eb ec                	jmp    f2b <sharedfd+0x10b>
     f3f:	90                   	nop
  close(fd);
     f40:	83 ec 0c             	sub    $0xc,%esp
     f43:	89 d8                	mov    %ebx,%eax
     f45:	ff 75 d4             	pushl  -0x2c(%ebp)
     f48:	89 fb                	mov    %edi,%ebx
     f4a:	89 c7                	mov    %eax,%edi
     f4c:	e8 49 29 00 00       	call   389a <close>
  unlink("sharedfd");
     f51:	c7 04 24 63 41 00 00 	movl   $0x4163,(%esp)
     f58:	e8 65 29 00 00       	call   38c2 <unlink>
  if(nc == 10000 && np == 10000){
     f5d:	83 c4 10             	add    $0x10,%esp
     f60:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     f66:	75 61                	jne    fc9 <sharedfd+0x1a9>
     f68:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     f6e:	75 59                	jne    fc9 <sharedfd+0x1a9>
    printf(1, "sharedfd ok\n");
     f70:	83 ec 08             	sub    $0x8,%esp
     f73:	68 6c 41 00 00       	push   $0x416c
     f78:	6a 01                	push   $0x1
     f7a:	e8 51 2a 00 00       	call   39d0 <printf>
     f7f:	83 c4 10             	add    $0x10,%esp
}
     f82:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f85:	5b                   	pop    %ebx
     f86:	5e                   	pop    %esi
     f87:	5f                   	pop    %edi
     f88:	5d                   	pop    %ebp
     f89:	c3                   	ret    
     f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    printf(1, "fstests: cannot open sharedfd for writing");
     f90:	83 ec 08             	sub    $0x8,%esp
     f93:	68 28 4e 00 00       	push   $0x4e28
     f98:	6a 01                	push   $0x1
     f9a:	e8 31 2a 00 00       	call   39d0 <printf>
    return;
     f9f:	83 c4 10             	add    $0x10,%esp
}
     fa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fa5:	5b                   	pop    %ebx
     fa6:	5e                   	pop    %esi
     fa7:	5f                   	pop    %edi
     fa8:	5d                   	pop    %ebp
     fa9:	c3                   	ret    
    printf(1, "fstests: cannot open sharedfd for reading\n");
     faa:	83 ec 08             	sub    $0x8,%esp
     fad:	68 74 4e 00 00       	push   $0x4e74
     fb2:	6a 01                	push   $0x1
     fb4:	e8 17 2a 00 00       	call   39d0 <printf>
    return;
     fb9:	83 c4 10             	add    $0x10,%esp
}
     fbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fbf:	5b                   	pop    %ebx
     fc0:	5e                   	pop    %esi
     fc1:	5f                   	pop    %edi
     fc2:	5d                   	pop    %ebp
     fc3:	c3                   	ret    
    exit();
     fc4:	e8 a9 28 00 00       	call   3872 <exit>
    printf(1, "sharedfd oops %d %d\n", nc, np);
     fc9:	53                   	push   %ebx
     fca:	57                   	push   %edi
     fcb:	68 79 41 00 00       	push   $0x4179
     fd0:	6a 01                	push   $0x1
     fd2:	e8 f9 29 00 00       	call   39d0 <printf>
    exit();
     fd7:	e8 96 28 00 00       	call   3872 <exit>
     fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fe0 <fourfiles>:
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	57                   	push   %edi
     fe4:	56                   	push   %esi
     fe5:	53                   	push   %ebx
  printf(1, "fourfiles test\n");
     fe6:	be 8e 41 00 00       	mov    $0x418e,%esi
  for(pi = 0; pi < 4; pi++){
     feb:	31 db                	xor    %ebx,%ebx
{
     fed:	83 ec 34             	sub    $0x34,%esp
  char *names[] = { "f0", "f1", "f2", "f3" };
     ff0:	c7 45 d8 8e 41 00 00 	movl   $0x418e,-0x28(%ebp)
     ff7:	c7 45 dc d7 42 00 00 	movl   $0x42d7,-0x24(%ebp)
  printf(1, "fourfiles test\n");
     ffe:	68 94 41 00 00       	push   $0x4194
    1003:	6a 01                	push   $0x1
  char *names[] = { "f0", "f1", "f2", "f3" };
    1005:	c7 45 e0 db 42 00 00 	movl   $0x42db,-0x20(%ebp)
    100c:	c7 45 e4 91 41 00 00 	movl   $0x4191,-0x1c(%ebp)
  printf(1, "fourfiles test\n");
    1013:	e8 b8 29 00 00       	call   39d0 <printf>
    1018:	83 c4 10             	add    $0x10,%esp
    unlink(fname);
    101b:	83 ec 0c             	sub    $0xc,%esp
    101e:	56                   	push   %esi
    101f:	e8 9e 28 00 00       	call   38c2 <unlink>
    pid = fork();
    1024:	e8 41 28 00 00       	call   386a <fork>
    if(pid < 0){
    1029:	83 c4 10             	add    $0x10,%esp
    102c:	85 c0                	test   %eax,%eax
    102e:	0f 88 68 01 00 00    	js     119c <fourfiles+0x1bc>
    if(pid == 0){
    1034:	0f 84 df 00 00 00    	je     1119 <fourfiles+0x139>
  for(pi = 0; pi < 4; pi++){
    103a:	83 c3 01             	add    $0x1,%ebx
    103d:	83 fb 04             	cmp    $0x4,%ebx
    1040:	74 06                	je     1048 <fourfiles+0x68>
    1042:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1046:	eb d3                	jmp    101b <fourfiles+0x3b>
    wait();
    1048:	e8 2d 28 00 00       	call   387a <wait>
  for(i = 0; i < 2; i++){
    104d:	31 ff                	xor    %edi,%edi
    wait();
    104f:	e8 26 28 00 00       	call   387a <wait>
    1054:	e8 21 28 00 00       	call   387a <wait>
    1059:	e8 1c 28 00 00       	call   387a <wait>
    105e:	c7 45 d0 8e 41 00 00 	movl   $0x418e,-0x30(%ebp)
    fd = open(fname, 0);
    1065:	83 ec 08             	sub    $0x8,%esp
    total = 0;
    1068:	31 db                	xor    %ebx,%ebx
    fd = open(fname, 0);
    106a:	6a 00                	push   $0x0
    106c:	ff 75 d0             	pushl  -0x30(%ebp)
    106f:	e8 3e 28 00 00       	call   38b2 <open>
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1074:	83 c4 10             	add    $0x10,%esp
    fd = open(fname, 0);
    1077:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    107a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1080:	83 ec 04             	sub    $0x4,%esp
    1083:	68 00 20 00 00       	push   $0x2000
    1088:	68 c0 85 00 00       	push   $0x85c0
    108d:	ff 75 d4             	pushl  -0x2c(%ebp)
    1090:	e8 f5 27 00 00       	call   388a <read>
    1095:	83 c4 10             	add    $0x10,%esp
    1098:	85 c0                	test   %eax,%eax
    109a:	7e 26                	jle    10c2 <fourfiles+0xe2>
      for(j = 0; j < n; j++){
    109c:	31 d2                	xor    %edx,%edx
    109e:	66 90                	xchg   %ax,%ax
        if(buf[j] != '0'+i){
    10a0:	0f be b2 c0 85 00 00 	movsbl 0x85c0(%edx),%esi
    10a7:	83 ff 01             	cmp    $0x1,%edi
    10aa:	19 c9                	sbb    %ecx,%ecx
    10ac:	83 c1 31             	add    $0x31,%ecx
    10af:	39 ce                	cmp    %ecx,%esi
    10b1:	0f 85 be 00 00 00    	jne    1175 <fourfiles+0x195>
      for(j = 0; j < n; j++){
    10b7:	83 c2 01             	add    $0x1,%edx
    10ba:	39 d0                	cmp    %edx,%eax
    10bc:	75 e2                	jne    10a0 <fourfiles+0xc0>
      total += n;
    10be:	01 c3                	add    %eax,%ebx
    10c0:	eb be                	jmp    1080 <fourfiles+0xa0>
    close(fd);
    10c2:	83 ec 0c             	sub    $0xc,%esp
    10c5:	ff 75 d4             	pushl  -0x2c(%ebp)
    10c8:	e8 cd 27 00 00       	call   389a <close>
    if(total != 12*500){
    10cd:	83 c4 10             	add    $0x10,%esp
    10d0:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    10d6:	0f 85 d3 00 00 00    	jne    11af <fourfiles+0x1cf>
    unlink(fname);
    10dc:	83 ec 0c             	sub    $0xc,%esp
    10df:	ff 75 d0             	pushl  -0x30(%ebp)
    10e2:	e8 db 27 00 00       	call   38c2 <unlink>
  for(i = 0; i < 2; i++){
    10e7:	83 c4 10             	add    $0x10,%esp
    10ea:	83 ff 01             	cmp    $0x1,%edi
    10ed:	75 1a                	jne    1109 <fourfiles+0x129>
  printf(1, "fourfiles ok\n");
    10ef:	83 ec 08             	sub    $0x8,%esp
    10f2:	68 d2 41 00 00       	push   $0x41d2
    10f7:	6a 01                	push   $0x1
    10f9:	e8 d2 28 00 00       	call   39d0 <printf>
}
    10fe:	83 c4 10             	add    $0x10,%esp
    1101:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1104:	5b                   	pop    %ebx
    1105:	5e                   	pop    %esi
    1106:	5f                   	pop    %edi
    1107:	5d                   	pop    %ebp
    1108:	c3                   	ret    
    1109:	8b 45 dc             	mov    -0x24(%ebp),%eax
    110c:	bf 01 00 00 00       	mov    $0x1,%edi
    1111:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1114:	e9 4c ff ff ff       	jmp    1065 <fourfiles+0x85>
      fd = open(fname, O_CREATE | O_RDWR);
    1119:	83 ec 08             	sub    $0x8,%esp
    111c:	68 02 02 00 00       	push   $0x202
    1121:	56                   	push   %esi
    1122:	e8 8b 27 00 00       	call   38b2 <open>
      if(fd < 0){
    1127:	83 c4 10             	add    $0x10,%esp
    112a:	85 c0                	test   %eax,%eax
      fd = open(fname, O_CREATE | O_RDWR);
    112c:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    112e:	78 59                	js     1189 <fourfiles+0x1a9>
      memset(buf, '0'+pi, 512);
    1130:	83 ec 04             	sub    $0x4,%esp
    1133:	83 c3 30             	add    $0x30,%ebx
    1136:	68 00 02 00 00       	push   $0x200
    113b:	53                   	push   %ebx
    113c:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1141:	68 c0 85 00 00       	push   $0x85c0
    1146:	e8 85 25 00 00       	call   36d0 <memset>
    114b:	83 c4 10             	add    $0x10,%esp
        if((n = write(fd, buf, 500)) != 500){
    114e:	83 ec 04             	sub    $0x4,%esp
    1151:	68 f4 01 00 00       	push   $0x1f4
    1156:	68 c0 85 00 00       	push   $0x85c0
    115b:	56                   	push   %esi
    115c:	e8 31 27 00 00       	call   3892 <write>
    1161:	83 c4 10             	add    $0x10,%esp
    1164:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1169:	75 57                	jne    11c2 <fourfiles+0x1e2>
      for(i = 0; i < 12; i++){
    116b:	83 eb 01             	sub    $0x1,%ebx
    116e:	75 de                	jne    114e <fourfiles+0x16e>
      exit();
    1170:	e8 fd 26 00 00       	call   3872 <exit>
          printf(1, "wrong char\n");
    1175:	83 ec 08             	sub    $0x8,%esp
    1178:	68 b5 41 00 00       	push   $0x41b5
    117d:	6a 01                	push   $0x1
    117f:	e8 4c 28 00 00       	call   39d0 <printf>
          exit();
    1184:	e8 e9 26 00 00       	call   3872 <exit>
        printf(1, "create failed\n");
    1189:	51                   	push   %ecx
    118a:	51                   	push   %ecx
    118b:	68 2f 44 00 00       	push   $0x442f
    1190:	6a 01                	push   $0x1
    1192:	e8 39 28 00 00       	call   39d0 <printf>
        exit();
    1197:	e8 d6 26 00 00       	call   3872 <exit>
      printf(1, "fork failed\n");
    119c:	53                   	push   %ebx
    119d:	53                   	push   %ebx
    119e:	68 69 4c 00 00       	push   $0x4c69
    11a3:	6a 01                	push   $0x1
    11a5:	e8 26 28 00 00       	call   39d0 <printf>
      exit();
    11aa:	e8 c3 26 00 00       	call   3872 <exit>
      printf(1, "wrong length %d\n", total);
    11af:	50                   	push   %eax
    11b0:	53                   	push   %ebx
    11b1:	68 c1 41 00 00       	push   $0x41c1
    11b6:	6a 01                	push   $0x1
    11b8:	e8 13 28 00 00       	call   39d0 <printf>
      exit();
    11bd:	e8 b0 26 00 00       	call   3872 <exit>
          printf(1, "write failed %d\n", n);
    11c2:	52                   	push   %edx
    11c3:	50                   	push   %eax
    11c4:	68 a4 41 00 00       	push   $0x41a4
    11c9:	6a 01                	push   $0x1
    11cb:	e8 00 28 00 00       	call   39d0 <printf>
          exit();
    11d0:	e8 9d 26 00 00       	call   3872 <exit>
    11d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011e0 <createdelete>:
{
    11e0:	55                   	push   %ebp
    11e1:	89 e5                	mov    %esp,%ebp
    11e3:	57                   	push   %edi
    11e4:	56                   	push   %esi
    11e5:	53                   	push   %ebx
  for(pi = 0; pi < 4; pi++){
    11e6:	31 db                	xor    %ebx,%ebx
{
    11e8:	83 ec 44             	sub    $0x44,%esp
  printf(1, "createdelete test\n");
    11eb:	68 e0 41 00 00       	push   $0x41e0
    11f0:	6a 01                	push   $0x1
    11f2:	e8 d9 27 00 00       	call   39d0 <printf>
    11f7:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    11fa:	e8 6b 26 00 00       	call   386a <fork>
    if(pid < 0){
    11ff:	85 c0                	test   %eax,%eax
    1201:	0f 88 be 01 00 00    	js     13c5 <createdelete+0x1e5>
    if(pid == 0){
    1207:	0f 84 0b 01 00 00    	je     1318 <createdelete+0x138>
  for(pi = 0; pi < 4; pi++){
    120d:	83 c3 01             	add    $0x1,%ebx
    1210:	83 fb 04             	cmp    $0x4,%ebx
    1213:	75 e5                	jne    11fa <createdelete+0x1a>
    1215:	8d 7d c8             	lea    -0x38(%ebp),%edi
  name[0] = name[1] = name[2] = 0;
    1218:	be ff ff ff ff       	mov    $0xffffffff,%esi
    wait();
    121d:	e8 58 26 00 00       	call   387a <wait>
    1222:	e8 53 26 00 00       	call   387a <wait>
    1227:	e8 4e 26 00 00       	call   387a <wait>
    122c:	e8 49 26 00 00       	call   387a <wait>
  name[0] = name[1] = name[2] = 0;
    1231:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1235:	8d 76 00             	lea    0x0(%esi),%esi
    1238:	8d 46 31             	lea    0x31(%esi),%eax
    123b:	88 45 c7             	mov    %al,-0x39(%ebp)
    123e:	8d 46 01             	lea    0x1(%esi),%eax
    1241:	83 f8 09             	cmp    $0x9,%eax
    1244:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1247:	0f 9f c3             	setg   %bl
    124a:	85 c0                	test   %eax,%eax
    124c:	0f 94 c0             	sete   %al
    124f:	09 c3                	or     %eax,%ebx
    1251:	88 5d c6             	mov    %bl,-0x3a(%ebp)
      name[2] = '\0';
    1254:	bb 70 00 00 00       	mov    $0x70,%ebx
      name[1] = '0' + i;
    1259:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      fd = open(name, 0);
    125d:	83 ec 08             	sub    $0x8,%esp
      name[0] = 'p' + pi;
    1260:	88 5d c8             	mov    %bl,-0x38(%ebp)
      fd = open(name, 0);
    1263:	6a 00                	push   $0x0
    1265:	57                   	push   %edi
      name[1] = '0' + i;
    1266:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1269:	e8 44 26 00 00       	call   38b2 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    126e:	83 c4 10             	add    $0x10,%esp
    1271:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    1275:	0f 84 85 00 00 00    	je     1300 <createdelete+0x120>
    127b:	85 c0                	test   %eax,%eax
    127d:	0f 88 1a 01 00 00    	js     139d <createdelete+0x1bd>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1283:	83 fe 08             	cmp    $0x8,%esi
    1286:	0f 86 54 01 00 00    	jbe    13e0 <createdelete+0x200>
        close(fd);
    128c:	83 ec 0c             	sub    $0xc,%esp
    128f:	50                   	push   %eax
    1290:	e8 05 26 00 00       	call   389a <close>
    1295:	83 c4 10             	add    $0x10,%esp
    1298:	83 c3 01             	add    $0x1,%ebx
    for(pi = 0; pi < 4; pi++){
    129b:	80 fb 74             	cmp    $0x74,%bl
    129e:	75 b9                	jne    1259 <createdelete+0x79>
    12a0:	8b 75 c0             	mov    -0x40(%ebp),%esi
  for(i = 0; i < N; i++){
    12a3:	83 fe 13             	cmp    $0x13,%esi
    12a6:	75 90                	jne    1238 <createdelete+0x58>
    12a8:	be 70 00 00 00       	mov    $0x70,%esi
    12ad:	8d 76 00             	lea    0x0(%esi),%esi
    12b0:	8d 46 c0             	lea    -0x40(%esi),%eax
  name[0] = name[1] = name[2] = 0;
    12b3:	bb 04 00 00 00       	mov    $0x4,%ebx
    12b8:	88 45 c7             	mov    %al,-0x39(%ebp)
      name[0] = 'p' + i;
    12bb:	89 f0                	mov    %esi,%eax
      unlink(name);
    12bd:	83 ec 0c             	sub    $0xc,%esp
      name[0] = 'p' + i;
    12c0:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    12c3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    12c7:	57                   	push   %edi
      name[1] = '0' + i;
    12c8:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    12cb:	e8 f2 25 00 00       	call   38c2 <unlink>
    for(pi = 0; pi < 4; pi++){
    12d0:	83 c4 10             	add    $0x10,%esp
    12d3:	83 eb 01             	sub    $0x1,%ebx
    12d6:	75 e3                	jne    12bb <createdelete+0xdb>
    12d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; i < N; i++){
    12db:	89 f0                	mov    %esi,%eax
    12dd:	3c 84                	cmp    $0x84,%al
    12df:	75 cf                	jne    12b0 <createdelete+0xd0>
  printf(1, "createdelete ok\n");
    12e1:	83 ec 08             	sub    $0x8,%esp
    12e4:	68 f3 41 00 00       	push   $0x41f3
    12e9:	6a 01                	push   $0x1
    12eb:	e8 e0 26 00 00       	call   39d0 <printf>
}
    12f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12f3:	5b                   	pop    %ebx
    12f4:	5e                   	pop    %esi
    12f5:	5f                   	pop    %edi
    12f6:	5d                   	pop    %ebp
    12f7:	c3                   	ret    
    12f8:	90                   	nop
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1300:	83 fe 08             	cmp    $0x8,%esi
    1303:	0f 86 cf 00 00 00    	jbe    13d8 <createdelete+0x1f8>
      if(fd >= 0)
    1309:	85 c0                	test   %eax,%eax
    130b:	78 8b                	js     1298 <createdelete+0xb8>
    130d:	e9 7a ff ff ff       	jmp    128c <createdelete+0xac>
    1312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      name[0] = 'p' + pi;
    1318:	83 c3 70             	add    $0x70,%ebx
      name[2] = '\0';
    131b:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    131f:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[0] = 'p' + pi;
    1322:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1325:	31 db                	xor    %ebx,%ebx
    1327:	eb 0f                	jmp    1338 <createdelete+0x158>
    1329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < N; i++){
    1330:	83 fb 13             	cmp    $0x13,%ebx
    1333:	74 63                	je     1398 <createdelete+0x1b8>
    1335:	83 c3 01             	add    $0x1,%ebx
        fd = open(name, O_CREATE | O_RDWR);
    1338:	83 ec 08             	sub    $0x8,%esp
        name[1] = '0' + i;
    133b:	8d 43 30             	lea    0x30(%ebx),%eax
        fd = open(name, O_CREATE | O_RDWR);
    133e:	68 02 02 00 00       	push   $0x202
    1343:	57                   	push   %edi
        name[1] = '0' + i;
    1344:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    1347:	e8 66 25 00 00       	call   38b2 <open>
        if(fd < 0){
    134c:	83 c4 10             	add    $0x10,%esp
    134f:	85 c0                	test   %eax,%eax
    1351:	78 5f                	js     13b2 <createdelete+0x1d2>
        close(fd);
    1353:	83 ec 0c             	sub    $0xc,%esp
    1356:	50                   	push   %eax
    1357:	e8 3e 25 00 00       	call   389a <close>
        if(i > 0 && (i % 2 ) == 0){
    135c:	83 c4 10             	add    $0x10,%esp
    135f:	85 db                	test   %ebx,%ebx
    1361:	74 d2                	je     1335 <createdelete+0x155>
    1363:	f6 c3 01             	test   $0x1,%bl
    1366:	75 c8                	jne    1330 <createdelete+0x150>
          if(unlink(name) < 0){
    1368:	83 ec 0c             	sub    $0xc,%esp
          name[1] = '0' + (i / 2);
    136b:	89 d8                	mov    %ebx,%eax
    136d:	d1 f8                	sar    %eax
          if(unlink(name) < 0){
    136f:	57                   	push   %edi
          name[1] = '0' + (i / 2);
    1370:	83 c0 30             	add    $0x30,%eax
    1373:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1376:	e8 47 25 00 00       	call   38c2 <unlink>
    137b:	83 c4 10             	add    $0x10,%esp
    137e:	85 c0                	test   %eax,%eax
    1380:	79 ae                	jns    1330 <createdelete+0x150>
            printf(1, "unlink failed\n");
    1382:	52                   	push   %edx
    1383:	52                   	push   %edx
    1384:	68 e1 3d 00 00       	push   $0x3de1
    1389:	6a 01                	push   $0x1
    138b:	e8 40 26 00 00       	call   39d0 <printf>
            exit();
    1390:	e8 dd 24 00 00       	call   3872 <exit>
    1395:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    1398:	e8 d5 24 00 00       	call   3872 <exit>
        printf(1, "oops createdelete %s didn't exist\n", name);
    139d:	83 ec 04             	sub    $0x4,%esp
    13a0:	57                   	push   %edi
    13a1:	68 a0 4e 00 00       	push   $0x4ea0
    13a6:	6a 01                	push   $0x1
    13a8:	e8 23 26 00 00       	call   39d0 <printf>
        exit();
    13ad:	e8 c0 24 00 00       	call   3872 <exit>
          printf(1, "create failed\n");
    13b2:	51                   	push   %ecx
    13b3:	51                   	push   %ecx
    13b4:	68 2f 44 00 00       	push   $0x442f
    13b9:	6a 01                	push   $0x1
    13bb:	e8 10 26 00 00       	call   39d0 <printf>
          exit();
    13c0:	e8 ad 24 00 00       	call   3872 <exit>
      printf(1, "fork failed\n");
    13c5:	53                   	push   %ebx
    13c6:	53                   	push   %ebx
    13c7:	68 69 4c 00 00       	push   $0x4c69
    13cc:	6a 01                	push   $0x1
    13ce:	e8 fd 25 00 00       	call   39d0 <printf>
      exit();
    13d3:	e8 9a 24 00 00       	call   3872 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    13d8:	85 c0                	test   %eax,%eax
    13da:	0f 88 b8 fe ff ff    	js     1298 <createdelete+0xb8>
        printf(1, "oops createdelete %s did exist\n", name);
    13e0:	50                   	push   %eax
    13e1:	57                   	push   %edi
    13e2:	68 c4 4e 00 00       	push   $0x4ec4
    13e7:	6a 01                	push   $0x1
    13e9:	e8 e2 25 00 00       	call   39d0 <printf>
        exit();
    13ee:	e8 7f 24 00 00       	call   3872 <exit>
    13f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001400 <unlinkread>:
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    1403:	56                   	push   %esi
    1404:	53                   	push   %ebx
  printf(1, "unlinkread test\n");
    1405:	83 ec 08             	sub    $0x8,%esp
    1408:	68 04 42 00 00       	push   $0x4204
    140d:	6a 01                	push   $0x1
    140f:	e8 bc 25 00 00       	call   39d0 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1414:	5b                   	pop    %ebx
    1415:	5e                   	pop    %esi
    1416:	68 02 02 00 00       	push   $0x202
    141b:	68 15 42 00 00       	push   $0x4215
    1420:	e8 8d 24 00 00       	call   38b2 <open>
  if(fd < 0){
    1425:	83 c4 10             	add    $0x10,%esp
    1428:	85 c0                	test   %eax,%eax
    142a:	0f 88 e6 00 00 00    	js     1516 <unlinkread+0x116>
  write(fd, "hello", 5);
    1430:	83 ec 04             	sub    $0x4,%esp
    1433:	89 c3                	mov    %eax,%ebx
    1435:	6a 05                	push   $0x5
    1437:	68 3a 42 00 00       	push   $0x423a
    143c:	50                   	push   %eax
    143d:	e8 50 24 00 00       	call   3892 <write>
  close(fd);
    1442:	89 1c 24             	mov    %ebx,(%esp)
    1445:	e8 50 24 00 00       	call   389a <close>
  fd = open("unlinkread", O_RDWR);
    144a:	58                   	pop    %eax
    144b:	5a                   	pop    %edx
    144c:	6a 02                	push   $0x2
    144e:	68 15 42 00 00       	push   $0x4215
    1453:	e8 5a 24 00 00       	call   38b2 <open>
  if(fd < 0){
    1458:	83 c4 10             	add    $0x10,%esp
    145b:	85 c0                	test   %eax,%eax
  fd = open("unlinkread", O_RDWR);
    145d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    145f:	0f 88 10 01 00 00    	js     1575 <unlinkread+0x175>
  if(unlink("unlinkread") != 0){
    1465:	83 ec 0c             	sub    $0xc,%esp
    1468:	68 15 42 00 00       	push   $0x4215
    146d:	e8 50 24 00 00       	call   38c2 <unlink>
    1472:	83 c4 10             	add    $0x10,%esp
    1475:	85 c0                	test   %eax,%eax
    1477:	0f 85 e5 00 00 00    	jne    1562 <unlinkread+0x162>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    147d:	83 ec 08             	sub    $0x8,%esp
    1480:	68 02 02 00 00       	push   $0x202
    1485:	68 15 42 00 00       	push   $0x4215
    148a:	e8 23 24 00 00       	call   38b2 <open>
  write(fd1, "yyy", 3);
    148f:	83 c4 0c             	add    $0xc,%esp
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1492:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    1494:	6a 03                	push   $0x3
    1496:	68 72 42 00 00       	push   $0x4272
    149b:	50                   	push   %eax
    149c:	e8 f1 23 00 00       	call   3892 <write>
  close(fd1);
    14a1:	89 34 24             	mov    %esi,(%esp)
    14a4:	e8 f1 23 00 00       	call   389a <close>
  if(read(fd, buf, sizeof(buf)) != 5){
    14a9:	83 c4 0c             	add    $0xc,%esp
    14ac:	68 00 20 00 00       	push   $0x2000
    14b1:	68 c0 85 00 00       	push   $0x85c0
    14b6:	53                   	push   %ebx
    14b7:	e8 ce 23 00 00       	call   388a <read>
    14bc:	83 c4 10             	add    $0x10,%esp
    14bf:	83 f8 05             	cmp    $0x5,%eax
    14c2:	0f 85 87 00 00 00    	jne    154f <unlinkread+0x14f>
  if(buf[0] != 'h'){
    14c8:	80 3d c0 85 00 00 68 	cmpb   $0x68,0x85c0
    14cf:	75 6b                	jne    153c <unlinkread+0x13c>
  if(write(fd, buf, 10) != 10){
    14d1:	83 ec 04             	sub    $0x4,%esp
    14d4:	6a 0a                	push   $0xa
    14d6:	68 c0 85 00 00       	push   $0x85c0
    14db:	53                   	push   %ebx
    14dc:	e8 b1 23 00 00       	call   3892 <write>
    14e1:	83 c4 10             	add    $0x10,%esp
    14e4:	83 f8 0a             	cmp    $0xa,%eax
    14e7:	75 40                	jne    1529 <unlinkread+0x129>
  close(fd);
    14e9:	83 ec 0c             	sub    $0xc,%esp
    14ec:	53                   	push   %ebx
    14ed:	e8 a8 23 00 00       	call   389a <close>
  unlink("unlinkread");
    14f2:	c7 04 24 15 42 00 00 	movl   $0x4215,(%esp)
    14f9:	e8 c4 23 00 00       	call   38c2 <unlink>
  printf(1, "unlinkread ok\n");
    14fe:	58                   	pop    %eax
    14ff:	5a                   	pop    %edx
    1500:	68 bd 42 00 00       	push   $0x42bd
    1505:	6a 01                	push   $0x1
    1507:	e8 c4 24 00 00       	call   39d0 <printf>
}
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1512:	5b                   	pop    %ebx
    1513:	5e                   	pop    %esi
    1514:	5d                   	pop    %ebp
    1515:	c3                   	ret    
    printf(1, "create unlinkread failed\n");
    1516:	51                   	push   %ecx
    1517:	51                   	push   %ecx
    1518:	68 20 42 00 00       	push   $0x4220
    151d:	6a 01                	push   $0x1
    151f:	e8 ac 24 00 00       	call   39d0 <printf>
    exit();
    1524:	e8 49 23 00 00       	call   3872 <exit>
    printf(1, "unlinkread write failed\n");
    1529:	51                   	push   %ecx
    152a:	51                   	push   %ecx
    152b:	68 a4 42 00 00       	push   $0x42a4
    1530:	6a 01                	push   $0x1
    1532:	e8 99 24 00 00       	call   39d0 <printf>
    exit();
    1537:	e8 36 23 00 00       	call   3872 <exit>
    printf(1, "unlinkread wrong data\n");
    153c:	53                   	push   %ebx
    153d:	53                   	push   %ebx
    153e:	68 8d 42 00 00       	push   $0x428d
    1543:	6a 01                	push   $0x1
    1545:	e8 86 24 00 00       	call   39d0 <printf>
    exit();
    154a:	e8 23 23 00 00       	call   3872 <exit>
    printf(1, "unlinkread read failed");
    154f:	56                   	push   %esi
    1550:	56                   	push   %esi
    1551:	68 76 42 00 00       	push   $0x4276
    1556:	6a 01                	push   $0x1
    1558:	e8 73 24 00 00       	call   39d0 <printf>
    exit();
    155d:	e8 10 23 00 00       	call   3872 <exit>
    printf(1, "unlink unlinkread failed\n");
    1562:	50                   	push   %eax
    1563:	50                   	push   %eax
    1564:	68 58 42 00 00       	push   $0x4258
    1569:	6a 01                	push   $0x1
    156b:	e8 60 24 00 00       	call   39d0 <printf>
    exit();
    1570:	e8 fd 22 00 00       	call   3872 <exit>
    printf(1, "open unlinkread failed\n");
    1575:	50                   	push   %eax
    1576:	50                   	push   %eax
    1577:	68 40 42 00 00       	push   $0x4240
    157c:	6a 01                	push   $0x1
    157e:	e8 4d 24 00 00       	call   39d0 <printf>
    exit();
    1583:	e8 ea 22 00 00       	call   3872 <exit>
    1588:	90                   	nop
    1589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001590 <linktest>:
{
    1590:	55                   	push   %ebp
    1591:	89 e5                	mov    %esp,%ebp
    1593:	53                   	push   %ebx
    1594:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "linktest\n");
    1597:	68 cc 42 00 00       	push   $0x42cc
    159c:	6a 01                	push   $0x1
    159e:	e8 2d 24 00 00       	call   39d0 <printf>
  unlink("lf1");
    15a3:	c7 04 24 d6 42 00 00 	movl   $0x42d6,(%esp)
    15aa:	e8 13 23 00 00       	call   38c2 <unlink>
  unlink("lf2");
    15af:	c7 04 24 da 42 00 00 	movl   $0x42da,(%esp)
    15b6:	e8 07 23 00 00       	call   38c2 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
    15bb:	58                   	pop    %eax
    15bc:	5a                   	pop    %edx
    15bd:	68 02 02 00 00       	push   $0x202
    15c2:	68 d6 42 00 00       	push   $0x42d6
    15c7:	e8 e6 22 00 00       	call   38b2 <open>
  if(fd < 0){
    15cc:	83 c4 10             	add    $0x10,%esp
    15cf:	85 c0                	test   %eax,%eax
    15d1:	0f 88 1e 01 00 00    	js     16f5 <linktest+0x165>
  if(write(fd, "hello", 5) != 5){
    15d7:	83 ec 04             	sub    $0x4,%esp
    15da:	89 c3                	mov    %eax,%ebx
    15dc:	6a 05                	push   $0x5
    15de:	68 3a 42 00 00       	push   $0x423a
    15e3:	50                   	push   %eax
    15e4:	e8 a9 22 00 00       	call   3892 <write>
    15e9:	83 c4 10             	add    $0x10,%esp
    15ec:	83 f8 05             	cmp    $0x5,%eax
    15ef:	0f 85 98 01 00 00    	jne    178d <linktest+0x1fd>
  close(fd);
    15f5:	83 ec 0c             	sub    $0xc,%esp
    15f8:	53                   	push   %ebx
    15f9:	e8 9c 22 00 00       	call   389a <close>
  if(link("lf1", "lf2") < 0){
    15fe:	5b                   	pop    %ebx
    15ff:	58                   	pop    %eax
    1600:	68 da 42 00 00       	push   $0x42da
    1605:	68 d6 42 00 00       	push   $0x42d6
    160a:	e8 c3 22 00 00       	call   38d2 <link>
    160f:	83 c4 10             	add    $0x10,%esp
    1612:	85 c0                	test   %eax,%eax
    1614:	0f 88 60 01 00 00    	js     177a <linktest+0x1ea>
  unlink("lf1");
    161a:	83 ec 0c             	sub    $0xc,%esp
    161d:	68 d6 42 00 00       	push   $0x42d6
    1622:	e8 9b 22 00 00       	call   38c2 <unlink>
  if(open("lf1", 0) >= 0){
    1627:	58                   	pop    %eax
    1628:	5a                   	pop    %edx
    1629:	6a 00                	push   $0x0
    162b:	68 d6 42 00 00       	push   $0x42d6
    1630:	e8 7d 22 00 00       	call   38b2 <open>
    1635:	83 c4 10             	add    $0x10,%esp
    1638:	85 c0                	test   %eax,%eax
    163a:	0f 89 27 01 00 00    	jns    1767 <linktest+0x1d7>
  fd = open("lf2", 0);
    1640:	83 ec 08             	sub    $0x8,%esp
    1643:	6a 00                	push   $0x0
    1645:	68 da 42 00 00       	push   $0x42da
    164a:	e8 63 22 00 00       	call   38b2 <open>
  if(fd < 0){
    164f:	83 c4 10             	add    $0x10,%esp
    1652:	85 c0                	test   %eax,%eax
  fd = open("lf2", 0);
    1654:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1656:	0f 88 f8 00 00 00    	js     1754 <linktest+0x1c4>
  if(read(fd, buf, sizeof(buf)) != 5){
    165c:	83 ec 04             	sub    $0x4,%esp
    165f:	68 00 20 00 00       	push   $0x2000
    1664:	68 c0 85 00 00       	push   $0x85c0
    1669:	50                   	push   %eax
    166a:	e8 1b 22 00 00       	call   388a <read>
    166f:	83 c4 10             	add    $0x10,%esp
    1672:	83 f8 05             	cmp    $0x5,%eax
    1675:	0f 85 c6 00 00 00    	jne    1741 <linktest+0x1b1>
  close(fd);
    167b:	83 ec 0c             	sub    $0xc,%esp
    167e:	53                   	push   %ebx
    167f:	e8 16 22 00 00       	call   389a <close>
  if(link("lf2", "lf2") >= 0){
    1684:	58                   	pop    %eax
    1685:	5a                   	pop    %edx
    1686:	68 da 42 00 00       	push   $0x42da
    168b:	68 da 42 00 00       	push   $0x42da
    1690:	e8 3d 22 00 00       	call   38d2 <link>
    1695:	83 c4 10             	add    $0x10,%esp
    1698:	85 c0                	test   %eax,%eax
    169a:	0f 89 8e 00 00 00    	jns    172e <linktest+0x19e>
  unlink("lf2");
    16a0:	83 ec 0c             	sub    $0xc,%esp
    16a3:	68 da 42 00 00       	push   $0x42da
    16a8:	e8 15 22 00 00       	call   38c2 <unlink>
  if(link("lf2", "lf1") >= 0){
    16ad:	59                   	pop    %ecx
    16ae:	5b                   	pop    %ebx
    16af:	68 d6 42 00 00       	push   $0x42d6
    16b4:	68 da 42 00 00       	push   $0x42da
    16b9:	e8 14 22 00 00       	call   38d2 <link>
    16be:	83 c4 10             	add    $0x10,%esp
    16c1:	85 c0                	test   %eax,%eax
    16c3:	79 56                	jns    171b <linktest+0x18b>
  if(link(".", "lf1") >= 0){
    16c5:	83 ec 08             	sub    $0x8,%esp
    16c8:	68 d6 42 00 00       	push   $0x42d6
    16cd:	68 9e 45 00 00       	push   $0x459e
    16d2:	e8 fb 21 00 00       	call   38d2 <link>
    16d7:	83 c4 10             	add    $0x10,%esp
    16da:	85 c0                	test   %eax,%eax
    16dc:	79 2a                	jns    1708 <linktest+0x178>
  printf(1, "linktest ok\n");
    16de:	83 ec 08             	sub    $0x8,%esp
    16e1:	68 74 43 00 00       	push   $0x4374
    16e6:	6a 01                	push   $0x1
    16e8:	e8 e3 22 00 00       	call   39d0 <printf>
}
    16ed:	83 c4 10             	add    $0x10,%esp
    16f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    16f3:	c9                   	leave  
    16f4:	c3                   	ret    
    printf(1, "create lf1 failed\n");
    16f5:	50                   	push   %eax
    16f6:	50                   	push   %eax
    16f7:	68 de 42 00 00       	push   $0x42de
    16fc:	6a 01                	push   $0x1
    16fe:	e8 cd 22 00 00       	call   39d0 <printf>
    exit();
    1703:	e8 6a 21 00 00       	call   3872 <exit>
    printf(1, "link . lf1 succeeded! oops\n");
    1708:	50                   	push   %eax
    1709:	50                   	push   %eax
    170a:	68 58 43 00 00       	push   $0x4358
    170f:	6a 01                	push   $0x1
    1711:	e8 ba 22 00 00       	call   39d0 <printf>
    exit();
    1716:	e8 57 21 00 00       	call   3872 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    171b:	52                   	push   %edx
    171c:	52                   	push   %edx
    171d:	68 0c 4f 00 00       	push   $0x4f0c
    1722:	6a 01                	push   $0x1
    1724:	e8 a7 22 00 00       	call   39d0 <printf>
    exit();
    1729:	e8 44 21 00 00       	call   3872 <exit>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    172e:	50                   	push   %eax
    172f:	50                   	push   %eax
    1730:	68 3a 43 00 00       	push   $0x433a
    1735:	6a 01                	push   $0x1
    1737:	e8 94 22 00 00       	call   39d0 <printf>
    exit();
    173c:	e8 31 21 00 00       	call   3872 <exit>
    printf(1, "read lf2 failed\n");
    1741:	51                   	push   %ecx
    1742:	51                   	push   %ecx
    1743:	68 29 43 00 00       	push   $0x4329
    1748:	6a 01                	push   $0x1
    174a:	e8 81 22 00 00       	call   39d0 <printf>
    exit();
    174f:	e8 1e 21 00 00       	call   3872 <exit>
    printf(1, "open lf2 failed\n");
    1754:	53                   	push   %ebx
    1755:	53                   	push   %ebx
    1756:	68 18 43 00 00       	push   $0x4318
    175b:	6a 01                	push   $0x1
    175d:	e8 6e 22 00 00       	call   39d0 <printf>
    exit();
    1762:	e8 0b 21 00 00       	call   3872 <exit>
    printf(1, "unlinked lf1 but it is still there!\n");
    1767:	50                   	push   %eax
    1768:	50                   	push   %eax
    1769:	68 e4 4e 00 00       	push   $0x4ee4
    176e:	6a 01                	push   $0x1
    1770:	e8 5b 22 00 00       	call   39d0 <printf>
    exit();
    1775:	e8 f8 20 00 00       	call   3872 <exit>
    printf(1, "link lf1 lf2 failed\n");
    177a:	51                   	push   %ecx
    177b:	51                   	push   %ecx
    177c:	68 03 43 00 00       	push   $0x4303
    1781:	6a 01                	push   $0x1
    1783:	e8 48 22 00 00       	call   39d0 <printf>
    exit();
    1788:	e8 e5 20 00 00       	call   3872 <exit>
    printf(1, "write lf1 failed\n");
    178d:	50                   	push   %eax
    178e:	50                   	push   %eax
    178f:	68 f1 42 00 00       	push   $0x42f1
    1794:	6a 01                	push   $0x1
    1796:	e8 35 22 00 00       	call   39d0 <printf>
    exit();
    179b:	e8 d2 20 00 00       	call   3872 <exit>

000017a0 <concreate>:
{
    17a0:	55                   	push   %ebp
    17a1:	89 e5                	mov    %esp,%ebp
    17a3:	57                   	push   %edi
    17a4:	56                   	push   %esi
    17a5:	53                   	push   %ebx
  for(i = 0; i < 40; i++){
    17a6:	31 f6                	xor    %esi,%esi
    17a8:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    if(pid && (i % 3) == 1){
    17ab:	bf ab aa aa aa       	mov    $0xaaaaaaab,%edi
{
    17b0:	83 ec 64             	sub    $0x64,%esp
  printf(1, "concreate test\n");
    17b3:	68 81 43 00 00       	push   $0x4381
    17b8:	6a 01                	push   $0x1
    17ba:	e8 11 22 00 00       	call   39d0 <printf>
  file[0] = 'C';
    17bf:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    17c3:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    17c7:	83 c4 10             	add    $0x10,%esp
    17ca:	eb 4c                	jmp    1818 <concreate+0x78>
    17cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid && (i % 3) == 1){
    17d0:	89 f0                	mov    %esi,%eax
    17d2:	89 f1                	mov    %esi,%ecx
    17d4:	f7 e7                	mul    %edi
    17d6:	d1 ea                	shr    %edx
    17d8:	8d 04 52             	lea    (%edx,%edx,2),%eax
    17db:	29 c1                	sub    %eax,%ecx
    17dd:	83 f9 01             	cmp    $0x1,%ecx
    17e0:	0f 84 ba 00 00 00    	je     18a0 <concreate+0x100>
      fd = open(file, O_CREATE | O_RDWR);
    17e6:	83 ec 08             	sub    $0x8,%esp
    17e9:	68 02 02 00 00       	push   $0x202
    17ee:	53                   	push   %ebx
    17ef:	e8 be 20 00 00       	call   38b2 <open>
      if(fd < 0){
    17f4:	83 c4 10             	add    $0x10,%esp
    17f7:	85 c0                	test   %eax,%eax
    17f9:	78 67                	js     1862 <concreate+0xc2>
      close(fd);
    17fb:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < 40; i++){
    17fe:	83 c6 01             	add    $0x1,%esi
      close(fd);
    1801:	50                   	push   %eax
    1802:	e8 93 20 00 00       	call   389a <close>
    1807:	83 c4 10             	add    $0x10,%esp
      wait();
    180a:	e8 6b 20 00 00       	call   387a <wait>
  for(i = 0; i < 40; i++){
    180f:	83 fe 28             	cmp    $0x28,%esi
    1812:	0f 84 aa 00 00 00    	je     18c2 <concreate+0x122>
    unlink(file);
    1818:	83 ec 0c             	sub    $0xc,%esp
    file[1] = '0' + i;
    181b:	8d 46 30             	lea    0x30(%esi),%eax
    unlink(file);
    181e:	53                   	push   %ebx
    file[1] = '0' + i;
    181f:	88 45 ae             	mov    %al,-0x52(%ebp)
    unlink(file);
    1822:	e8 9b 20 00 00       	call   38c2 <unlink>
    pid = fork();
    1827:	e8 3e 20 00 00       	call   386a <fork>
    if(pid && (i % 3) == 1){
    182c:	83 c4 10             	add    $0x10,%esp
    182f:	85 c0                	test   %eax,%eax
    1831:	75 9d                	jne    17d0 <concreate+0x30>
    } else if(pid == 0 && (i % 5) == 1){
    1833:	89 f0                	mov    %esi,%eax
    1835:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    183a:	f7 e2                	mul    %edx
    183c:	c1 ea 02             	shr    $0x2,%edx
    183f:	8d 04 92             	lea    (%edx,%edx,4),%eax
    1842:	29 c6                	sub    %eax,%esi
    1844:	83 fe 01             	cmp    $0x1,%esi
    1847:	74 37                	je     1880 <concreate+0xe0>
      fd = open(file, O_CREATE | O_RDWR);
    1849:	83 ec 08             	sub    $0x8,%esp
    184c:	68 02 02 00 00       	push   $0x202
    1851:	53                   	push   %ebx
    1852:	e8 5b 20 00 00       	call   38b2 <open>
      if(fd < 0){
    1857:	83 c4 10             	add    $0x10,%esp
    185a:	85 c0                	test   %eax,%eax
    185c:	0f 89 28 02 00 00    	jns    1a8a <concreate+0x2ea>
        printf(1, "concreate create %s failed\n", file);
    1862:	83 ec 04             	sub    $0x4,%esp
    1865:	53                   	push   %ebx
    1866:	68 94 43 00 00       	push   $0x4394
    186b:	6a 01                	push   $0x1
    186d:	e8 5e 21 00 00       	call   39d0 <printf>
        exit();
    1872:	e8 fb 1f 00 00       	call   3872 <exit>
    1877:	89 f6                	mov    %esi,%esi
    1879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    1880:	83 ec 08             	sub    $0x8,%esp
    1883:	53                   	push   %ebx
    1884:	68 91 43 00 00       	push   $0x4391
    1889:	e8 44 20 00 00       	call   38d2 <link>
    188e:	83 c4 10             	add    $0x10,%esp
      exit();
    1891:	e8 dc 1f 00 00       	call   3872 <exit>
    1896:	8d 76 00             	lea    0x0(%esi),%esi
    1899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      link("C0", file);
    18a0:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 40; i++){
    18a3:	83 c6 01             	add    $0x1,%esi
      link("C0", file);
    18a6:	53                   	push   %ebx
    18a7:	68 91 43 00 00       	push   $0x4391
    18ac:	e8 21 20 00 00       	call   38d2 <link>
    18b1:	83 c4 10             	add    $0x10,%esp
      wait();
    18b4:	e8 c1 1f 00 00       	call   387a <wait>
  for(i = 0; i < 40; i++){
    18b9:	83 fe 28             	cmp    $0x28,%esi
    18bc:	0f 85 56 ff ff ff    	jne    1818 <concreate+0x78>
  memset(fa, 0, sizeof(fa));
    18c2:	8d 45 c0             	lea    -0x40(%ebp),%eax
    18c5:	83 ec 04             	sub    $0x4,%esp
    18c8:	6a 28                	push   $0x28
    18ca:	6a 00                	push   $0x0
    18cc:	50                   	push   %eax
    18cd:	e8 fe 1d 00 00       	call   36d0 <memset>
  fd = open(".", 0);
    18d2:	5f                   	pop    %edi
    18d3:	58                   	pop    %eax
    18d4:	6a 00                	push   $0x0
    18d6:	68 9e 45 00 00       	push   $0x459e
    18db:	8d 7d b0             	lea    -0x50(%ebp),%edi
    18de:	e8 cf 1f 00 00       	call   38b2 <open>
  while(read(fd, &de, sizeof(de)) > 0){
    18e3:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    18e6:	89 c6                	mov    %eax,%esi
  n = 0;
    18e8:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    18ef:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    18f0:	83 ec 04             	sub    $0x4,%esp
    18f3:	6a 10                	push   $0x10
    18f5:	57                   	push   %edi
    18f6:	56                   	push   %esi
    18f7:	e8 8e 1f 00 00       	call   388a <read>
    18fc:	83 c4 10             	add    $0x10,%esp
    18ff:	85 c0                	test   %eax,%eax
    1901:	7e 3d                	jle    1940 <concreate+0x1a0>
    if(de.inum == 0)
    1903:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1908:	74 e6                	je     18f0 <concreate+0x150>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    190a:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    190e:	75 e0                	jne    18f0 <concreate+0x150>
    1910:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1914:	75 da                	jne    18f0 <concreate+0x150>
      i = de.name[1] - '0';
    1916:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    191a:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    191d:	83 f8 27             	cmp    $0x27,%eax
    1920:	0f 87 4e 01 00 00    	ja     1a74 <concreate+0x2d4>
      if(fa[i]){
    1926:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    192b:	0f 85 2d 01 00 00    	jne    1a5e <concreate+0x2be>
      fa[i] = 1;
    1931:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1936:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    193a:	eb b4                	jmp    18f0 <concreate+0x150>
    193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  close(fd);
    1940:	83 ec 0c             	sub    $0xc,%esp
    1943:	56                   	push   %esi
    1944:	e8 51 1f 00 00       	call   389a <close>
  if(n != 40){
    1949:	83 c4 10             	add    $0x10,%esp
    194c:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1950:	0f 85 f5 00 00 00    	jne    1a4b <concreate+0x2ab>
  for(i = 0; i < 40; i++){
    1956:	31 f6                	xor    %esi,%esi
    1958:	eb 48                	jmp    19a2 <concreate+0x202>
    195a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
       ((i % 3) == 1 && pid != 0)){
    1960:	85 ff                	test   %edi,%edi
    1962:	74 05                	je     1969 <concreate+0x1c9>
    1964:	83 fa 01             	cmp    $0x1,%edx
    1967:	74 64                	je     19cd <concreate+0x22d>
      unlink(file);
    1969:	83 ec 0c             	sub    $0xc,%esp
    196c:	53                   	push   %ebx
    196d:	e8 50 1f 00 00       	call   38c2 <unlink>
      unlink(file);
    1972:	89 1c 24             	mov    %ebx,(%esp)
    1975:	e8 48 1f 00 00       	call   38c2 <unlink>
      unlink(file);
    197a:	89 1c 24             	mov    %ebx,(%esp)
    197d:	e8 40 1f 00 00       	call   38c2 <unlink>
      unlink(file);
    1982:	89 1c 24             	mov    %ebx,(%esp)
    1985:	e8 38 1f 00 00       	call   38c2 <unlink>
    198a:	83 c4 10             	add    $0x10,%esp
    if(pid == 0)
    198d:	85 ff                	test   %edi,%edi
    198f:	0f 84 fc fe ff ff    	je     1891 <concreate+0xf1>
  for(i = 0; i < 40; i++){
    1995:	83 c6 01             	add    $0x1,%esi
      wait();
    1998:	e8 dd 1e 00 00       	call   387a <wait>
  for(i = 0; i < 40; i++){
    199d:	83 fe 28             	cmp    $0x28,%esi
    19a0:	74 7e                	je     1a20 <concreate+0x280>
    file[1] = '0' + i;
    19a2:	8d 46 30             	lea    0x30(%esi),%eax
    19a5:	88 45 ae             	mov    %al,-0x52(%ebp)
    pid = fork();
    19a8:	e8 bd 1e 00 00       	call   386a <fork>
    if(pid < 0){
    19ad:	85 c0                	test   %eax,%eax
    pid = fork();
    19af:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    19b1:	0f 88 80 00 00 00    	js     1a37 <concreate+0x297>
    if(((i % 3) == 0 && pid == 0) ||
    19b7:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    19bc:	f7 e6                	mul    %esi
    19be:	d1 ea                	shr    %edx
    19c0:	8d 04 52             	lea    (%edx,%edx,2),%eax
    19c3:	89 f2                	mov    %esi,%edx
    19c5:	29 c2                	sub    %eax,%edx
    19c7:	89 d0                	mov    %edx,%eax
    19c9:	09 f8                	or     %edi,%eax
    19cb:	75 93                	jne    1960 <concreate+0x1c0>
      close(open(file, 0));
    19cd:	83 ec 08             	sub    $0x8,%esp
    19d0:	6a 00                	push   $0x0
    19d2:	53                   	push   %ebx
    19d3:	e8 da 1e 00 00       	call   38b2 <open>
    19d8:	89 04 24             	mov    %eax,(%esp)
    19db:	e8 ba 1e 00 00       	call   389a <close>
      close(open(file, 0));
    19e0:	58                   	pop    %eax
    19e1:	5a                   	pop    %edx
    19e2:	6a 00                	push   $0x0
    19e4:	53                   	push   %ebx
    19e5:	e8 c8 1e 00 00       	call   38b2 <open>
    19ea:	89 04 24             	mov    %eax,(%esp)
    19ed:	e8 a8 1e 00 00       	call   389a <close>
      close(open(file, 0));
    19f2:	59                   	pop    %ecx
    19f3:	58                   	pop    %eax
    19f4:	6a 00                	push   $0x0
    19f6:	53                   	push   %ebx
    19f7:	e8 b6 1e 00 00       	call   38b2 <open>
    19fc:	89 04 24             	mov    %eax,(%esp)
    19ff:	e8 96 1e 00 00       	call   389a <close>
      close(open(file, 0));
    1a04:	58                   	pop    %eax
    1a05:	5a                   	pop    %edx
    1a06:	6a 00                	push   $0x0
    1a08:	53                   	push   %ebx
    1a09:	e8 a4 1e 00 00       	call   38b2 <open>
    1a0e:	89 04 24             	mov    %eax,(%esp)
    1a11:	e8 84 1e 00 00       	call   389a <close>
    1a16:	83 c4 10             	add    $0x10,%esp
    1a19:	e9 6f ff ff ff       	jmp    198d <concreate+0x1ed>
    1a1e:	66 90                	xchg   %ax,%ax
  printf(1, "concreate ok\n");
    1a20:	83 ec 08             	sub    $0x8,%esp
    1a23:	68 e6 43 00 00       	push   $0x43e6
    1a28:	6a 01                	push   $0x1
    1a2a:	e8 a1 1f 00 00       	call   39d0 <printf>
}
    1a2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1a32:	5b                   	pop    %ebx
    1a33:	5e                   	pop    %esi
    1a34:	5f                   	pop    %edi
    1a35:	5d                   	pop    %ebp
    1a36:	c3                   	ret    
      printf(1, "fork failed\n");
    1a37:	83 ec 08             	sub    $0x8,%esp
    1a3a:	68 69 4c 00 00       	push   $0x4c69
    1a3f:	6a 01                	push   $0x1
    1a41:	e8 8a 1f 00 00       	call   39d0 <printf>
      exit();
    1a46:	e8 27 1e 00 00       	call   3872 <exit>
    printf(1, "concreate not enough files in directory listing\n");
    1a4b:	51                   	push   %ecx
    1a4c:	51                   	push   %ecx
    1a4d:	68 30 4f 00 00       	push   $0x4f30
    1a52:	6a 01                	push   $0x1
    1a54:	e8 77 1f 00 00       	call   39d0 <printf>
    exit();
    1a59:	e8 14 1e 00 00       	call   3872 <exit>
        printf(1, "concreate duplicate file %s\n", de.name);
    1a5e:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a61:	53                   	push   %ebx
    1a62:	50                   	push   %eax
    1a63:	68 c9 43 00 00       	push   $0x43c9
    1a68:	6a 01                	push   $0x1
    1a6a:	e8 61 1f 00 00       	call   39d0 <printf>
        exit();
    1a6f:	e8 fe 1d 00 00       	call   3872 <exit>
        printf(1, "concreate weird file %s\n", de.name);
    1a74:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1a77:	56                   	push   %esi
    1a78:	50                   	push   %eax
    1a79:	68 b0 43 00 00       	push   $0x43b0
    1a7e:	6a 01                	push   $0x1
    1a80:	e8 4b 1f 00 00       	call   39d0 <printf>
        exit();
    1a85:	e8 e8 1d 00 00       	call   3872 <exit>
      close(fd);
    1a8a:	83 ec 0c             	sub    $0xc,%esp
    1a8d:	50                   	push   %eax
    1a8e:	e8 07 1e 00 00       	call   389a <close>
    1a93:	83 c4 10             	add    $0x10,%esp
    1a96:	e9 f6 fd ff ff       	jmp    1891 <concreate+0xf1>
    1a9b:	90                   	nop
    1a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001aa0 <linkunlink>:
{
    1aa0:	55                   	push   %ebp
    1aa1:	89 e5                	mov    %esp,%ebp
    1aa3:	57                   	push   %edi
    1aa4:	56                   	push   %esi
    1aa5:	53                   	push   %ebx
    1aa6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "linkunlink test\n");
    1aa9:	68 f4 43 00 00       	push   $0x43f4
    1aae:	6a 01                	push   $0x1
    1ab0:	e8 1b 1f 00 00       	call   39d0 <printf>
  unlink("x");
    1ab5:	c7 04 24 81 46 00 00 	movl   $0x4681,(%esp)
    1abc:	e8 01 1e 00 00       	call   38c2 <unlink>
  pid = fork();
    1ac1:	e8 a4 1d 00 00       	call   386a <fork>
  if(pid < 0){
    1ac6:	83 c4 10             	add    $0x10,%esp
    1ac9:	85 c0                	test   %eax,%eax
  pid = fork();
    1acb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1ace:	0f 88 b6 00 00 00    	js     1b8a <linkunlink+0xea>
  unsigned int x = (pid ? 1 : 97);
    1ad4:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1ad8:	bb 64 00 00 00       	mov    $0x64,%ebx
    if((x % 3) == 0){
    1add:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  unsigned int x = (pid ? 1 : 97);
    1ae2:	19 ff                	sbb    %edi,%edi
    1ae4:	83 e7 60             	and    $0x60,%edi
    1ae7:	83 c7 01             	add    $0x1,%edi
    1aea:	eb 1e                	jmp    1b0a <linkunlink+0x6a>
    1aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if((x % 3) == 1){
    1af0:	83 fa 01             	cmp    $0x1,%edx
    1af3:	74 7b                	je     1b70 <linkunlink+0xd0>
      unlink("x");
    1af5:	83 ec 0c             	sub    $0xc,%esp
    1af8:	68 81 46 00 00       	push   $0x4681
    1afd:	e8 c0 1d 00 00       	call   38c2 <unlink>
    1b02:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b05:	83 eb 01             	sub    $0x1,%ebx
    1b08:	74 3d                	je     1b47 <linkunlink+0xa7>
    x = x * 1103515245 + 12345;
    1b0a:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1b10:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1b16:	89 f8                	mov    %edi,%eax
    1b18:	f7 e6                	mul    %esi
    1b1a:	d1 ea                	shr    %edx
    1b1c:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b1f:	89 fa                	mov    %edi,%edx
    1b21:	29 c2                	sub    %eax,%edx
    1b23:	75 cb                	jne    1af0 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1b25:	83 ec 08             	sub    $0x8,%esp
    1b28:	68 02 02 00 00       	push   $0x202
    1b2d:	68 81 46 00 00       	push   $0x4681
    1b32:	e8 7b 1d 00 00       	call   38b2 <open>
    1b37:	89 04 24             	mov    %eax,(%esp)
    1b3a:	e8 5b 1d 00 00       	call   389a <close>
    1b3f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1b42:	83 eb 01             	sub    $0x1,%ebx
    1b45:	75 c3                	jne    1b0a <linkunlink+0x6a>
  if(pid)
    1b47:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b4a:	85 c0                	test   %eax,%eax
    1b4c:	74 4f                	je     1b9d <linkunlink+0xfd>
    wait();
    1b4e:	e8 27 1d 00 00       	call   387a <wait>
  printf(1, "linkunlink ok\n");
    1b53:	83 ec 08             	sub    $0x8,%esp
    1b56:	68 09 44 00 00       	push   $0x4409
    1b5b:	6a 01                	push   $0x1
    1b5d:	e8 6e 1e 00 00       	call   39d0 <printf>
}
    1b62:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b65:	5b                   	pop    %ebx
    1b66:	5e                   	pop    %esi
    1b67:	5f                   	pop    %edi
    1b68:	5d                   	pop    %ebp
    1b69:	c3                   	ret    
    1b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      link("cat", "x");
    1b70:	83 ec 08             	sub    $0x8,%esp
    1b73:	68 81 46 00 00       	push   $0x4681
    1b78:	68 05 44 00 00       	push   $0x4405
    1b7d:	e8 50 1d 00 00       	call   38d2 <link>
    1b82:	83 c4 10             	add    $0x10,%esp
    1b85:	e9 7b ff ff ff       	jmp    1b05 <linkunlink+0x65>
    printf(1, "fork failed\n");
    1b8a:	52                   	push   %edx
    1b8b:	52                   	push   %edx
    1b8c:	68 69 4c 00 00       	push   $0x4c69
    1b91:	6a 01                	push   $0x1
    1b93:	e8 38 1e 00 00       	call   39d0 <printf>
    exit();
    1b98:	e8 d5 1c 00 00       	call   3872 <exit>
    exit();
    1b9d:	e8 d0 1c 00 00       	call   3872 <exit>
    1ba2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001bb0 <bigdir>:
{
    1bb0:	55                   	push   %ebp
    1bb1:	89 e5                	mov    %esp,%ebp
    1bb3:	57                   	push   %edi
    1bb4:	56                   	push   %esi
    1bb5:	53                   	push   %ebx
    1bb6:	83 ec 24             	sub    $0x24,%esp
  printf(1, "bigdir test\n");
    1bb9:	68 18 44 00 00       	push   $0x4418
    1bbe:	6a 01                	push   $0x1
    1bc0:	e8 0b 1e 00 00       	call   39d0 <printf>
  unlink("bd");
    1bc5:	c7 04 24 25 44 00 00 	movl   $0x4425,(%esp)
    1bcc:	e8 f1 1c 00 00       	call   38c2 <unlink>
  fd = open("bd", O_CREATE);
    1bd1:	5a                   	pop    %edx
    1bd2:	59                   	pop    %ecx
    1bd3:	68 00 02 00 00       	push   $0x200
    1bd8:	68 25 44 00 00       	push   $0x4425
    1bdd:	e8 d0 1c 00 00       	call   38b2 <open>
  if(fd < 0){
    1be2:	83 c4 10             	add    $0x10,%esp
    1be5:	85 c0                	test   %eax,%eax
    1be7:	0f 88 de 00 00 00    	js     1ccb <bigdir+0x11b>
  close(fd);
    1bed:	83 ec 0c             	sub    $0xc,%esp
    1bf0:	8d 7d de             	lea    -0x22(%ebp),%edi
  for(i = 0; i < 500; i++){
    1bf3:	31 f6                	xor    %esi,%esi
  close(fd);
    1bf5:	50                   	push   %eax
    1bf6:	e8 9f 1c 00 00       	call   389a <close>
    1bfb:	83 c4 10             	add    $0x10,%esp
    1bfe:	66 90                	xchg   %ax,%ax
    name[1] = '0' + (i / 64);
    1c00:	89 f0                	mov    %esi,%eax
    if(link("bd", name) != 0){
    1c02:	83 ec 08             	sub    $0x8,%esp
    name[0] = 'x';
    1c05:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c09:	c1 f8 06             	sar    $0x6,%eax
    if(link("bd", name) != 0){
    1c0c:	57                   	push   %edi
    1c0d:	68 25 44 00 00       	push   $0x4425
    name[1] = '0' + (i / 64);
    1c12:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    1c15:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c19:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c1c:	89 f0                	mov    %esi,%eax
    1c1e:	83 e0 3f             	and    $0x3f,%eax
    1c21:	83 c0 30             	add    $0x30,%eax
    1c24:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(link("bd", name) != 0){
    1c27:	e8 a6 1c 00 00       	call   38d2 <link>
    1c2c:	83 c4 10             	add    $0x10,%esp
    1c2f:	85 c0                	test   %eax,%eax
    1c31:	89 c3                	mov    %eax,%ebx
    1c33:	75 6e                	jne    1ca3 <bigdir+0xf3>
  for(i = 0; i < 500; i++){
    1c35:	83 c6 01             	add    $0x1,%esi
    1c38:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1c3e:	75 c0                	jne    1c00 <bigdir+0x50>
  unlink("bd");
    1c40:	83 ec 0c             	sub    $0xc,%esp
    1c43:	68 25 44 00 00       	push   $0x4425
    1c48:	e8 75 1c 00 00       	call   38c2 <unlink>
    1c4d:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + (i / 64);
    1c50:	89 d8                	mov    %ebx,%eax
    if(unlink(name) != 0){
    1c52:	83 ec 0c             	sub    $0xc,%esp
    name[0] = 'x';
    1c55:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    name[1] = '0' + (i / 64);
    1c59:	c1 f8 06             	sar    $0x6,%eax
    if(unlink(name) != 0){
    1c5c:	57                   	push   %edi
    name[3] = '\0';
    1c5d:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    name[1] = '0' + (i / 64);
    1c61:	83 c0 30             	add    $0x30,%eax
    1c64:	88 45 df             	mov    %al,-0x21(%ebp)
    name[2] = '0' + (i % 64);
    1c67:	89 d8                	mov    %ebx,%eax
    1c69:	83 e0 3f             	and    $0x3f,%eax
    1c6c:	83 c0 30             	add    $0x30,%eax
    1c6f:	88 45 e0             	mov    %al,-0x20(%ebp)
    if(unlink(name) != 0){
    1c72:	e8 4b 1c 00 00       	call   38c2 <unlink>
    1c77:	83 c4 10             	add    $0x10,%esp
    1c7a:	85 c0                	test   %eax,%eax
    1c7c:	75 39                	jne    1cb7 <bigdir+0x107>
  for(i = 0; i < 500; i++){
    1c7e:	83 c3 01             	add    $0x1,%ebx
    1c81:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1c87:	75 c7                	jne    1c50 <bigdir+0xa0>
  printf(1, "bigdir ok\n");
    1c89:	83 ec 08             	sub    $0x8,%esp
    1c8c:	68 67 44 00 00       	push   $0x4467
    1c91:	6a 01                	push   $0x1
    1c93:	e8 38 1d 00 00       	call   39d0 <printf>
}
    1c98:	83 c4 10             	add    $0x10,%esp
    1c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c9e:	5b                   	pop    %ebx
    1c9f:	5e                   	pop    %esi
    1ca0:	5f                   	pop    %edi
    1ca1:	5d                   	pop    %ebp
    1ca2:	c3                   	ret    
      printf(1, "bigdir link failed\n");
    1ca3:	83 ec 08             	sub    $0x8,%esp
    1ca6:	68 3e 44 00 00       	push   $0x443e
    1cab:	6a 01                	push   $0x1
    1cad:	e8 1e 1d 00 00       	call   39d0 <printf>
      exit();
    1cb2:	e8 bb 1b 00 00       	call   3872 <exit>
      printf(1, "bigdir unlink failed");
    1cb7:	83 ec 08             	sub    $0x8,%esp
    1cba:	68 52 44 00 00       	push   $0x4452
    1cbf:	6a 01                	push   $0x1
    1cc1:	e8 0a 1d 00 00       	call   39d0 <printf>
      exit();
    1cc6:	e8 a7 1b 00 00       	call   3872 <exit>
    printf(1, "bigdir create failed\n");
    1ccb:	50                   	push   %eax
    1ccc:	50                   	push   %eax
    1ccd:	68 28 44 00 00       	push   $0x4428
    1cd2:	6a 01                	push   $0x1
    1cd4:	e8 f7 1c 00 00       	call   39d0 <printf>
    exit();
    1cd9:	e8 94 1b 00 00       	call   3872 <exit>
    1cde:	66 90                	xchg   %ax,%ax

00001ce0 <subdir>:
{
    1ce0:	55                   	push   %ebp
    1ce1:	89 e5                	mov    %esp,%ebp
    1ce3:	53                   	push   %ebx
    1ce4:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "subdir test\n");
    1ce7:	68 72 44 00 00       	push   $0x4472
    1cec:	6a 01                	push   $0x1
    1cee:	e8 dd 1c 00 00       	call   39d0 <printf>
  unlink("ff");
    1cf3:	c7 04 24 fb 44 00 00 	movl   $0x44fb,(%esp)
    1cfa:	e8 c3 1b 00 00       	call   38c2 <unlink>
  if(mkdir("dd") != 0){
    1cff:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d06:	e8 cf 1b 00 00       	call   38da <mkdir>
    1d0b:	83 c4 10             	add    $0x10,%esp
    1d0e:	85 c0                	test   %eax,%eax
    1d10:	0f 85 b3 05 00 00    	jne    22c9 <subdir+0x5e9>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d16:	83 ec 08             	sub    $0x8,%esp
    1d19:	68 02 02 00 00       	push   $0x202
    1d1e:	68 d1 44 00 00       	push   $0x44d1
    1d23:	e8 8a 1b 00 00       	call   38b2 <open>
  if(fd < 0){
    1d28:	83 c4 10             	add    $0x10,%esp
    1d2b:	85 c0                	test   %eax,%eax
  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d2d:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d2f:	0f 88 81 05 00 00    	js     22b6 <subdir+0x5d6>
  write(fd, "ff", 2);
    1d35:	83 ec 04             	sub    $0x4,%esp
    1d38:	6a 02                	push   $0x2
    1d3a:	68 fb 44 00 00       	push   $0x44fb
    1d3f:	50                   	push   %eax
    1d40:	e8 4d 1b 00 00       	call   3892 <write>
  close(fd);
    1d45:	89 1c 24             	mov    %ebx,(%esp)
    1d48:	e8 4d 1b 00 00       	call   389a <close>
  if(unlink("dd") >= 0){
    1d4d:	c7 04 24 98 45 00 00 	movl   $0x4598,(%esp)
    1d54:	e8 69 1b 00 00       	call   38c2 <unlink>
    1d59:	83 c4 10             	add    $0x10,%esp
    1d5c:	85 c0                	test   %eax,%eax
    1d5e:	0f 89 3f 05 00 00    	jns    22a3 <subdir+0x5c3>
  if(mkdir("/dd/dd") != 0){
    1d64:	83 ec 0c             	sub    $0xc,%esp
    1d67:	68 ac 44 00 00       	push   $0x44ac
    1d6c:	e8 69 1b 00 00       	call   38da <mkdir>
    1d71:	83 c4 10             	add    $0x10,%esp
    1d74:	85 c0                	test   %eax,%eax
    1d76:	0f 85 14 05 00 00    	jne    2290 <subdir+0x5b0>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1d7c:	83 ec 08             	sub    $0x8,%esp
    1d7f:	68 02 02 00 00       	push   $0x202
    1d84:	68 ce 44 00 00       	push   $0x44ce
    1d89:	e8 24 1b 00 00       	call   38b2 <open>
  if(fd < 0){
    1d8e:	83 c4 10             	add    $0x10,%esp
    1d91:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1d93:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1d95:	0f 88 24 04 00 00    	js     21bf <subdir+0x4df>
  write(fd, "FF", 2);
    1d9b:	83 ec 04             	sub    $0x4,%esp
    1d9e:	6a 02                	push   $0x2
    1da0:	68 ef 44 00 00       	push   $0x44ef
    1da5:	50                   	push   %eax
    1da6:	e8 e7 1a 00 00       	call   3892 <write>
  close(fd);
    1dab:	89 1c 24             	mov    %ebx,(%esp)
    1dae:	e8 e7 1a 00 00       	call   389a <close>
  fd = open("dd/dd/../ff", 0);
    1db3:	58                   	pop    %eax
    1db4:	5a                   	pop    %edx
    1db5:	6a 00                	push   $0x0
    1db7:	68 f2 44 00 00       	push   $0x44f2
    1dbc:	e8 f1 1a 00 00       	call   38b2 <open>
  if(fd < 0){
    1dc1:	83 c4 10             	add    $0x10,%esp
    1dc4:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/../ff", 0);
    1dc6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dc8:	0f 88 de 03 00 00    	js     21ac <subdir+0x4cc>
  cc = read(fd, buf, sizeof(buf));
    1dce:	83 ec 04             	sub    $0x4,%esp
    1dd1:	68 00 20 00 00       	push   $0x2000
    1dd6:	68 c0 85 00 00       	push   $0x85c0
    1ddb:	50                   	push   %eax
    1ddc:	e8 a9 1a 00 00       	call   388a <read>
  if(cc != 2 || buf[0] != 'f'){
    1de1:	83 c4 10             	add    $0x10,%esp
    1de4:	83 f8 02             	cmp    $0x2,%eax
    1de7:	0f 85 3a 03 00 00    	jne    2127 <subdir+0x447>
    1ded:	80 3d c0 85 00 00 66 	cmpb   $0x66,0x85c0
    1df4:	0f 85 2d 03 00 00    	jne    2127 <subdir+0x447>
  close(fd);
    1dfa:	83 ec 0c             	sub    $0xc,%esp
    1dfd:	53                   	push   %ebx
    1dfe:	e8 97 1a 00 00       	call   389a <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e03:	5b                   	pop    %ebx
    1e04:	58                   	pop    %eax
    1e05:	68 32 45 00 00       	push   $0x4532
    1e0a:	68 ce 44 00 00       	push   $0x44ce
    1e0f:	e8 be 1a 00 00       	call   38d2 <link>
    1e14:	83 c4 10             	add    $0x10,%esp
    1e17:	85 c0                	test   %eax,%eax
    1e19:	0f 85 c6 03 00 00    	jne    21e5 <subdir+0x505>
  if(unlink("dd/dd/ff") != 0){
    1e1f:	83 ec 0c             	sub    $0xc,%esp
    1e22:	68 ce 44 00 00       	push   $0x44ce
    1e27:	e8 96 1a 00 00       	call   38c2 <unlink>
    1e2c:	83 c4 10             	add    $0x10,%esp
    1e2f:	85 c0                	test   %eax,%eax
    1e31:	0f 85 16 03 00 00    	jne    214d <subdir+0x46d>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1e37:	83 ec 08             	sub    $0x8,%esp
    1e3a:	6a 00                	push   $0x0
    1e3c:	68 ce 44 00 00       	push   $0x44ce
    1e41:	e8 6c 1a 00 00       	call   38b2 <open>
    1e46:	83 c4 10             	add    $0x10,%esp
    1e49:	85 c0                	test   %eax,%eax
    1e4b:	0f 89 2c 04 00 00    	jns    227d <subdir+0x59d>
  if(chdir("dd") != 0){
    1e51:	83 ec 0c             	sub    $0xc,%esp
    1e54:	68 98 45 00 00       	push   $0x4598
    1e59:	e8 84 1a 00 00       	call   38e2 <chdir>
    1e5e:	83 c4 10             	add    $0x10,%esp
    1e61:	85 c0                	test   %eax,%eax
    1e63:	0f 85 01 04 00 00    	jne    226a <subdir+0x58a>
  if(chdir("dd/../../dd") != 0){
    1e69:	83 ec 0c             	sub    $0xc,%esp
    1e6c:	68 66 45 00 00       	push   $0x4566
    1e71:	e8 6c 1a 00 00       	call   38e2 <chdir>
    1e76:	83 c4 10             	add    $0x10,%esp
    1e79:	85 c0                	test   %eax,%eax
    1e7b:	0f 85 b9 02 00 00    	jne    213a <subdir+0x45a>
  if(chdir("dd/../../../dd") != 0){
    1e81:	83 ec 0c             	sub    $0xc,%esp
    1e84:	68 8c 45 00 00       	push   $0x458c
    1e89:	e8 54 1a 00 00       	call   38e2 <chdir>
    1e8e:	83 c4 10             	add    $0x10,%esp
    1e91:	85 c0                	test   %eax,%eax
    1e93:	0f 85 a1 02 00 00    	jne    213a <subdir+0x45a>
  if(chdir("./..") != 0){
    1e99:	83 ec 0c             	sub    $0xc,%esp
    1e9c:	68 9b 45 00 00       	push   $0x459b
    1ea1:	e8 3c 1a 00 00       	call   38e2 <chdir>
    1ea6:	83 c4 10             	add    $0x10,%esp
    1ea9:	85 c0                	test   %eax,%eax
    1eab:	0f 85 21 03 00 00    	jne    21d2 <subdir+0x4f2>
  fd = open("dd/dd/ffff", 0);
    1eb1:	83 ec 08             	sub    $0x8,%esp
    1eb4:	6a 00                	push   $0x0
    1eb6:	68 32 45 00 00       	push   $0x4532
    1ebb:	e8 f2 19 00 00       	call   38b2 <open>
  if(fd < 0){
    1ec0:	83 c4 10             	add    $0x10,%esp
    1ec3:	85 c0                	test   %eax,%eax
  fd = open("dd/dd/ffff", 0);
    1ec5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1ec7:	0f 88 e0 04 00 00    	js     23ad <subdir+0x6cd>
  if(read(fd, buf, sizeof(buf)) != 2){
    1ecd:	83 ec 04             	sub    $0x4,%esp
    1ed0:	68 00 20 00 00       	push   $0x2000
    1ed5:	68 c0 85 00 00       	push   $0x85c0
    1eda:	50                   	push   %eax
    1edb:	e8 aa 19 00 00       	call   388a <read>
    1ee0:	83 c4 10             	add    $0x10,%esp
    1ee3:	83 f8 02             	cmp    $0x2,%eax
    1ee6:	0f 85 ae 04 00 00    	jne    239a <subdir+0x6ba>
  close(fd);
    1eec:	83 ec 0c             	sub    $0xc,%esp
    1eef:	53                   	push   %ebx
    1ef0:	e8 a5 19 00 00       	call   389a <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ef5:	59                   	pop    %ecx
    1ef6:	5b                   	pop    %ebx
    1ef7:	6a 00                	push   $0x0
    1ef9:	68 ce 44 00 00       	push   $0x44ce
    1efe:	e8 af 19 00 00       	call   38b2 <open>
    1f03:	83 c4 10             	add    $0x10,%esp
    1f06:	85 c0                	test   %eax,%eax
    1f08:	0f 89 65 02 00 00    	jns    2173 <subdir+0x493>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f0e:	83 ec 08             	sub    $0x8,%esp
    1f11:	68 02 02 00 00       	push   $0x202
    1f16:	68 e6 45 00 00       	push   $0x45e6
    1f1b:	e8 92 19 00 00       	call   38b2 <open>
    1f20:	83 c4 10             	add    $0x10,%esp
    1f23:	85 c0                	test   %eax,%eax
    1f25:	0f 89 35 02 00 00    	jns    2160 <subdir+0x480>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1f2b:	83 ec 08             	sub    $0x8,%esp
    1f2e:	68 02 02 00 00       	push   $0x202
    1f33:	68 0b 46 00 00       	push   $0x460b
    1f38:	e8 75 19 00 00       	call   38b2 <open>
    1f3d:	83 c4 10             	add    $0x10,%esp
    1f40:	85 c0                	test   %eax,%eax
    1f42:	0f 89 0f 03 00 00    	jns    2257 <subdir+0x577>
  if(open("dd", O_CREATE) >= 0){
    1f48:	83 ec 08             	sub    $0x8,%esp
    1f4b:	68 00 02 00 00       	push   $0x200
    1f50:	68 98 45 00 00       	push   $0x4598
    1f55:	e8 58 19 00 00       	call   38b2 <open>
    1f5a:	83 c4 10             	add    $0x10,%esp
    1f5d:	85 c0                	test   %eax,%eax
    1f5f:	0f 89 df 02 00 00    	jns    2244 <subdir+0x564>
  if(open("dd", O_RDWR) >= 0){
    1f65:	83 ec 08             	sub    $0x8,%esp
    1f68:	6a 02                	push   $0x2
    1f6a:	68 98 45 00 00       	push   $0x4598
    1f6f:	e8 3e 19 00 00       	call   38b2 <open>
    1f74:	83 c4 10             	add    $0x10,%esp
    1f77:	85 c0                	test   %eax,%eax
    1f79:	0f 89 b2 02 00 00    	jns    2231 <subdir+0x551>
  if(open("dd", O_WRONLY) >= 0){
    1f7f:	83 ec 08             	sub    $0x8,%esp
    1f82:	6a 01                	push   $0x1
    1f84:	68 98 45 00 00       	push   $0x4598
    1f89:	e8 24 19 00 00       	call   38b2 <open>
    1f8e:	83 c4 10             	add    $0x10,%esp
    1f91:	85 c0                	test   %eax,%eax
    1f93:	0f 89 85 02 00 00    	jns    221e <subdir+0x53e>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    1f99:	83 ec 08             	sub    $0x8,%esp
    1f9c:	68 7a 46 00 00       	push   $0x467a
    1fa1:	68 e6 45 00 00       	push   $0x45e6
    1fa6:	e8 27 19 00 00       	call   38d2 <link>
    1fab:	83 c4 10             	add    $0x10,%esp
    1fae:	85 c0                	test   %eax,%eax
    1fb0:	0f 84 55 02 00 00    	je     220b <subdir+0x52b>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    1fb6:	83 ec 08             	sub    $0x8,%esp
    1fb9:	68 7a 46 00 00       	push   $0x467a
    1fbe:	68 0b 46 00 00       	push   $0x460b
    1fc3:	e8 0a 19 00 00       	call   38d2 <link>
    1fc8:	83 c4 10             	add    $0x10,%esp
    1fcb:	85 c0                	test   %eax,%eax
    1fcd:	0f 84 25 02 00 00    	je     21f8 <subdir+0x518>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    1fd3:	83 ec 08             	sub    $0x8,%esp
    1fd6:	68 32 45 00 00       	push   $0x4532
    1fdb:	68 d1 44 00 00       	push   $0x44d1
    1fe0:	e8 ed 18 00 00       	call   38d2 <link>
    1fe5:	83 c4 10             	add    $0x10,%esp
    1fe8:	85 c0                	test   %eax,%eax
    1fea:	0f 84 a9 01 00 00    	je     2199 <subdir+0x4b9>
  if(mkdir("dd/ff/ff") == 0){
    1ff0:	83 ec 0c             	sub    $0xc,%esp
    1ff3:	68 e6 45 00 00       	push   $0x45e6
    1ff8:	e8 dd 18 00 00       	call   38da <mkdir>
    1ffd:	83 c4 10             	add    $0x10,%esp
    2000:	85 c0                	test   %eax,%eax
    2002:	0f 84 7e 01 00 00    	je     2186 <subdir+0x4a6>
  if(mkdir("dd/xx/ff") == 0){
    2008:	83 ec 0c             	sub    $0xc,%esp
    200b:	68 0b 46 00 00       	push   $0x460b
    2010:	e8 c5 18 00 00       	call   38da <mkdir>
    2015:	83 c4 10             	add    $0x10,%esp
    2018:	85 c0                	test   %eax,%eax
    201a:	0f 84 67 03 00 00    	je     2387 <subdir+0x6a7>
  if(mkdir("dd/dd/ffff") == 0){
    2020:	83 ec 0c             	sub    $0xc,%esp
    2023:	68 32 45 00 00       	push   $0x4532
    2028:	e8 ad 18 00 00       	call   38da <mkdir>
    202d:	83 c4 10             	add    $0x10,%esp
    2030:	85 c0                	test   %eax,%eax
    2032:	0f 84 3c 03 00 00    	je     2374 <subdir+0x694>
  if(unlink("dd/xx/ff") == 0){
    2038:	83 ec 0c             	sub    $0xc,%esp
    203b:	68 0b 46 00 00       	push   $0x460b
    2040:	e8 7d 18 00 00       	call   38c2 <unlink>
    2045:	83 c4 10             	add    $0x10,%esp
    2048:	85 c0                	test   %eax,%eax
    204a:	0f 84 11 03 00 00    	je     2361 <subdir+0x681>
  if(unlink("dd/ff/ff") == 0){
    2050:	83 ec 0c             	sub    $0xc,%esp
    2053:	68 e6 45 00 00       	push   $0x45e6
    2058:	e8 65 18 00 00       	call   38c2 <unlink>
    205d:	83 c4 10             	add    $0x10,%esp
    2060:	85 c0                	test   %eax,%eax
    2062:	0f 84 e6 02 00 00    	je     234e <subdir+0x66e>
  if(chdir("dd/ff") == 0){
    2068:	83 ec 0c             	sub    $0xc,%esp
    206b:	68 d1 44 00 00       	push   $0x44d1
    2070:	e8 6d 18 00 00       	call   38e2 <chdir>
    2075:	83 c4 10             	add    $0x10,%esp
    2078:	85 c0                	test   %eax,%eax
    207a:	0f 84 bb 02 00 00    	je     233b <subdir+0x65b>
  if(chdir("dd/xx") == 0){
    2080:	83 ec 0c             	sub    $0xc,%esp
    2083:	68 7d 46 00 00       	push   $0x467d
    2088:	e8 55 18 00 00       	call   38e2 <chdir>
    208d:	83 c4 10             	add    $0x10,%esp
    2090:	85 c0                	test   %eax,%eax
    2092:	0f 84 90 02 00 00    	je     2328 <subdir+0x648>
  if(unlink("dd/dd/ffff") != 0){
    2098:	83 ec 0c             	sub    $0xc,%esp
    209b:	68 32 45 00 00       	push   $0x4532
    20a0:	e8 1d 18 00 00       	call   38c2 <unlink>
    20a5:	83 c4 10             	add    $0x10,%esp
    20a8:	85 c0                	test   %eax,%eax
    20aa:	0f 85 9d 00 00 00    	jne    214d <subdir+0x46d>
  if(unlink("dd/ff") != 0){
    20b0:	83 ec 0c             	sub    $0xc,%esp
    20b3:	68 d1 44 00 00       	push   $0x44d1
    20b8:	e8 05 18 00 00       	call   38c2 <unlink>
    20bd:	83 c4 10             	add    $0x10,%esp
    20c0:	85 c0                	test   %eax,%eax
    20c2:	0f 85 4d 02 00 00    	jne    2315 <subdir+0x635>
  if(unlink("dd") == 0){
    20c8:	83 ec 0c             	sub    $0xc,%esp
    20cb:	68 98 45 00 00       	push   $0x4598
    20d0:	e8 ed 17 00 00       	call   38c2 <unlink>
    20d5:	83 c4 10             	add    $0x10,%esp
    20d8:	85 c0                	test   %eax,%eax
    20da:	0f 84 22 02 00 00    	je     2302 <subdir+0x622>
  if(unlink("dd/dd") < 0){
    20e0:	83 ec 0c             	sub    $0xc,%esp
    20e3:	68 ad 44 00 00       	push   $0x44ad
    20e8:	e8 d5 17 00 00       	call   38c2 <unlink>
    20ed:	83 c4 10             	add    $0x10,%esp
    20f0:	85 c0                	test   %eax,%eax
    20f2:	0f 88 f7 01 00 00    	js     22ef <subdir+0x60f>
  if(unlink("dd") < 0){
    20f8:	83 ec 0c             	sub    $0xc,%esp
    20fb:	68 98 45 00 00       	push   $0x4598
    2100:	e8 bd 17 00 00       	call   38c2 <unlink>
    2105:	83 c4 10             	add    $0x10,%esp
    2108:	85 c0                	test   %eax,%eax
    210a:	0f 88 cc 01 00 00    	js     22dc <subdir+0x5fc>
  printf(1, "subdir ok\n");
    2110:	83 ec 08             	sub    $0x8,%esp
    2113:	68 7a 47 00 00       	push   $0x477a
    2118:	6a 01                	push   $0x1
    211a:	e8 b1 18 00 00       	call   39d0 <printf>
}
    211f:	83 c4 10             	add    $0x10,%esp
    2122:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2125:	c9                   	leave  
    2126:	c3                   	ret    
    printf(1, "dd/dd/../ff wrong content\n");
    2127:	50                   	push   %eax
    2128:	50                   	push   %eax
    2129:	68 17 45 00 00       	push   $0x4517
    212e:	6a 01                	push   $0x1
    2130:	e8 9b 18 00 00       	call   39d0 <printf>
    exit();
    2135:	e8 38 17 00 00       	call   3872 <exit>
    printf(1, "chdir dd/../../dd failed\n");
    213a:	50                   	push   %eax
    213b:	50                   	push   %eax
    213c:	68 72 45 00 00       	push   $0x4572
    2141:	6a 01                	push   $0x1
    2143:	e8 88 18 00 00       	call   39d0 <printf>
    exit();
    2148:	e8 25 17 00 00       	call   3872 <exit>
    printf(1, "unlink dd/dd/ff failed\n");
    214d:	52                   	push   %edx
    214e:	52                   	push   %edx
    214f:	68 3d 45 00 00       	push   $0x453d
    2154:	6a 01                	push   $0x1
    2156:	e8 75 18 00 00       	call   39d0 <printf>
    exit();
    215b:	e8 12 17 00 00       	call   3872 <exit>
    printf(1, "create dd/ff/ff succeeded!\n");
    2160:	50                   	push   %eax
    2161:	50                   	push   %eax
    2162:	68 ef 45 00 00       	push   $0x45ef
    2167:	6a 01                	push   $0x1
    2169:	e8 62 18 00 00       	call   39d0 <printf>
    exit();
    216e:	e8 ff 16 00 00       	call   3872 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2173:	52                   	push   %edx
    2174:	52                   	push   %edx
    2175:	68 d4 4f 00 00       	push   $0x4fd4
    217a:	6a 01                	push   $0x1
    217c:	e8 4f 18 00 00       	call   39d0 <printf>
    exit();
    2181:	e8 ec 16 00 00       	call   3872 <exit>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2186:	52                   	push   %edx
    2187:	52                   	push   %edx
    2188:	68 83 46 00 00       	push   $0x4683
    218d:	6a 01                	push   $0x1
    218f:	e8 3c 18 00 00       	call   39d0 <printf>
    exit();
    2194:	e8 d9 16 00 00       	call   3872 <exit>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2199:	51                   	push   %ecx
    219a:	51                   	push   %ecx
    219b:	68 44 50 00 00       	push   $0x5044
    21a0:	6a 01                	push   $0x1
    21a2:	e8 29 18 00 00       	call   39d0 <printf>
    exit();
    21a7:	e8 c6 16 00 00       	call   3872 <exit>
    printf(1, "open dd/dd/../ff failed\n");
    21ac:	50                   	push   %eax
    21ad:	50                   	push   %eax
    21ae:	68 fe 44 00 00       	push   $0x44fe
    21b3:	6a 01                	push   $0x1
    21b5:	e8 16 18 00 00       	call   39d0 <printf>
    exit();
    21ba:	e8 b3 16 00 00       	call   3872 <exit>
    printf(1, "create dd/dd/ff failed\n");
    21bf:	51                   	push   %ecx
    21c0:	51                   	push   %ecx
    21c1:	68 d7 44 00 00       	push   $0x44d7
    21c6:	6a 01                	push   $0x1
    21c8:	e8 03 18 00 00       	call   39d0 <printf>
    exit();
    21cd:	e8 a0 16 00 00       	call   3872 <exit>
    printf(1, "chdir ./.. failed\n");
    21d2:	50                   	push   %eax
    21d3:	50                   	push   %eax
    21d4:	68 a0 45 00 00       	push   $0x45a0
    21d9:	6a 01                	push   $0x1
    21db:	e8 f0 17 00 00       	call   39d0 <printf>
    exit();
    21e0:	e8 8d 16 00 00       	call   3872 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    21e5:	51                   	push   %ecx
    21e6:	51                   	push   %ecx
    21e7:	68 8c 4f 00 00       	push   $0x4f8c
    21ec:	6a 01                	push   $0x1
    21ee:	e8 dd 17 00 00       	call   39d0 <printf>
    exit();
    21f3:	e8 7a 16 00 00       	call   3872 <exit>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    21f8:	53                   	push   %ebx
    21f9:	53                   	push   %ebx
    21fa:	68 20 50 00 00       	push   $0x5020
    21ff:	6a 01                	push   $0x1
    2201:	e8 ca 17 00 00       	call   39d0 <printf>
    exit();
    2206:	e8 67 16 00 00       	call   3872 <exit>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    220b:	50                   	push   %eax
    220c:	50                   	push   %eax
    220d:	68 fc 4f 00 00       	push   $0x4ffc
    2212:	6a 01                	push   $0x1
    2214:	e8 b7 17 00 00       	call   39d0 <printf>
    exit();
    2219:	e8 54 16 00 00       	call   3872 <exit>
    printf(1, "open dd wronly succeeded!\n");
    221e:	50                   	push   %eax
    221f:	50                   	push   %eax
    2220:	68 5f 46 00 00       	push   $0x465f
    2225:	6a 01                	push   $0x1
    2227:	e8 a4 17 00 00       	call   39d0 <printf>
    exit();
    222c:	e8 41 16 00 00       	call   3872 <exit>
    printf(1, "open dd rdwr succeeded!\n");
    2231:	50                   	push   %eax
    2232:	50                   	push   %eax
    2233:	68 46 46 00 00       	push   $0x4646
    2238:	6a 01                	push   $0x1
    223a:	e8 91 17 00 00       	call   39d0 <printf>
    exit();
    223f:	e8 2e 16 00 00       	call   3872 <exit>
    printf(1, "create dd succeeded!\n");
    2244:	50                   	push   %eax
    2245:	50                   	push   %eax
    2246:	68 30 46 00 00       	push   $0x4630
    224b:	6a 01                	push   $0x1
    224d:	e8 7e 17 00 00       	call   39d0 <printf>
    exit();
    2252:	e8 1b 16 00 00       	call   3872 <exit>
    printf(1, "create dd/xx/ff succeeded!\n");
    2257:	50                   	push   %eax
    2258:	50                   	push   %eax
    2259:	68 14 46 00 00       	push   $0x4614
    225e:	6a 01                	push   $0x1
    2260:	e8 6b 17 00 00       	call   39d0 <printf>
    exit();
    2265:	e8 08 16 00 00       	call   3872 <exit>
    printf(1, "chdir dd failed\n");
    226a:	50                   	push   %eax
    226b:	50                   	push   %eax
    226c:	68 55 45 00 00       	push   $0x4555
    2271:	6a 01                	push   $0x1
    2273:	e8 58 17 00 00       	call   39d0 <printf>
    exit();
    2278:	e8 f5 15 00 00       	call   3872 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    227d:	50                   	push   %eax
    227e:	50                   	push   %eax
    227f:	68 b0 4f 00 00       	push   $0x4fb0
    2284:	6a 01                	push   $0x1
    2286:	e8 45 17 00 00       	call   39d0 <printf>
    exit();
    228b:	e8 e2 15 00 00       	call   3872 <exit>
    printf(1, "subdir mkdir dd/dd failed\n");
    2290:	53                   	push   %ebx
    2291:	53                   	push   %ebx
    2292:	68 b3 44 00 00       	push   $0x44b3
    2297:	6a 01                	push   $0x1
    2299:	e8 32 17 00 00       	call   39d0 <printf>
    exit();
    229e:	e8 cf 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    22a3:	50                   	push   %eax
    22a4:	50                   	push   %eax
    22a5:	68 64 4f 00 00       	push   $0x4f64
    22aa:	6a 01                	push   $0x1
    22ac:	e8 1f 17 00 00       	call   39d0 <printf>
    exit();
    22b1:	e8 bc 15 00 00       	call   3872 <exit>
    printf(1, "create dd/ff failed\n");
    22b6:	50                   	push   %eax
    22b7:	50                   	push   %eax
    22b8:	68 97 44 00 00       	push   $0x4497
    22bd:	6a 01                	push   $0x1
    22bf:	e8 0c 17 00 00       	call   39d0 <printf>
    exit();
    22c4:	e8 a9 15 00 00       	call   3872 <exit>
    printf(1, "subdir mkdir dd failed\n");
    22c9:	50                   	push   %eax
    22ca:	50                   	push   %eax
    22cb:	68 7f 44 00 00       	push   $0x447f
    22d0:	6a 01                	push   $0x1
    22d2:	e8 f9 16 00 00       	call   39d0 <printf>
    exit();
    22d7:	e8 96 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd failed\n");
    22dc:	50                   	push   %eax
    22dd:	50                   	push   %eax
    22de:	68 68 47 00 00       	push   $0x4768
    22e3:	6a 01                	push   $0x1
    22e5:	e8 e6 16 00 00       	call   39d0 <printf>
    exit();
    22ea:	e8 83 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd/dd failed\n");
    22ef:	52                   	push   %edx
    22f0:	52                   	push   %edx
    22f1:	68 53 47 00 00       	push   $0x4753
    22f6:	6a 01                	push   $0x1
    22f8:	e8 d3 16 00 00       	call   39d0 <printf>
    exit();
    22fd:	e8 70 15 00 00       	call   3872 <exit>
    printf(1, "unlink non-empty dd succeeded!\n");
    2302:	51                   	push   %ecx
    2303:	51                   	push   %ecx
    2304:	68 68 50 00 00       	push   $0x5068
    2309:	6a 01                	push   $0x1
    230b:	e8 c0 16 00 00       	call   39d0 <printf>
    exit();
    2310:	e8 5d 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd/ff failed\n");
    2315:	53                   	push   %ebx
    2316:	53                   	push   %ebx
    2317:	68 3e 47 00 00       	push   $0x473e
    231c:	6a 01                	push   $0x1
    231e:	e8 ad 16 00 00       	call   39d0 <printf>
    exit();
    2323:	e8 4a 15 00 00       	call   3872 <exit>
    printf(1, "chdir dd/xx succeeded!\n");
    2328:	50                   	push   %eax
    2329:	50                   	push   %eax
    232a:	68 26 47 00 00       	push   $0x4726
    232f:	6a 01                	push   $0x1
    2331:	e8 9a 16 00 00       	call   39d0 <printf>
    exit();
    2336:	e8 37 15 00 00       	call   3872 <exit>
    printf(1, "chdir dd/ff succeeded!\n");
    233b:	50                   	push   %eax
    233c:	50                   	push   %eax
    233d:	68 0e 47 00 00       	push   $0x470e
    2342:	6a 01                	push   $0x1
    2344:	e8 87 16 00 00       	call   39d0 <printf>
    exit();
    2349:	e8 24 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    234e:	50                   	push   %eax
    234f:	50                   	push   %eax
    2350:	68 f2 46 00 00       	push   $0x46f2
    2355:	6a 01                	push   $0x1
    2357:	e8 74 16 00 00       	call   39d0 <printf>
    exit();
    235c:	e8 11 15 00 00       	call   3872 <exit>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2361:	50                   	push   %eax
    2362:	50                   	push   %eax
    2363:	68 d6 46 00 00       	push   $0x46d6
    2368:	6a 01                	push   $0x1
    236a:	e8 61 16 00 00       	call   39d0 <printf>
    exit();
    236f:	e8 fe 14 00 00       	call   3872 <exit>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2374:	50                   	push   %eax
    2375:	50                   	push   %eax
    2376:	68 b9 46 00 00       	push   $0x46b9
    237b:	6a 01                	push   $0x1
    237d:	e8 4e 16 00 00       	call   39d0 <printf>
    exit();
    2382:	e8 eb 14 00 00       	call   3872 <exit>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    2387:	50                   	push   %eax
    2388:	50                   	push   %eax
    2389:	68 9e 46 00 00       	push   $0x469e
    238e:	6a 01                	push   $0x1
    2390:	e8 3b 16 00 00       	call   39d0 <printf>
    exit();
    2395:	e8 d8 14 00 00       	call   3872 <exit>
    printf(1, "read dd/dd/ffff wrong len\n");
    239a:	50                   	push   %eax
    239b:	50                   	push   %eax
    239c:	68 cb 45 00 00       	push   $0x45cb
    23a1:	6a 01                	push   $0x1
    23a3:	e8 28 16 00 00       	call   39d0 <printf>
    exit();
    23a8:	e8 c5 14 00 00       	call   3872 <exit>
    printf(1, "open dd/dd/ffff failed\n");
    23ad:	50                   	push   %eax
    23ae:	50                   	push   %eax
    23af:	68 b3 45 00 00       	push   $0x45b3
    23b4:	6a 01                	push   $0x1
    23b6:	e8 15 16 00 00       	call   39d0 <printf>
    exit();
    23bb:	e8 b2 14 00 00       	call   3872 <exit>

000023c0 <bigwrite>:
{
    23c0:	55                   	push   %ebp
    23c1:	89 e5                	mov    %esp,%ebp
    23c3:	56                   	push   %esi
    23c4:	53                   	push   %ebx
  for(sz = 499; sz < 12*512; sz += 471){
    23c5:	bb f3 01 00 00       	mov    $0x1f3,%ebx
  printf(1, "bigwrite test\n");
    23ca:	83 ec 08             	sub    $0x8,%esp
    23cd:	68 85 47 00 00       	push   $0x4785
    23d2:	6a 01                	push   $0x1
    23d4:	e8 f7 15 00 00       	call   39d0 <printf>
  unlink("bigwrite");
    23d9:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    23e0:	e8 dd 14 00 00       	call   38c2 <unlink>
    23e5:	83 c4 10             	add    $0x10,%esp
    23e8:	90                   	nop
    23e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    23f0:	83 ec 08             	sub    $0x8,%esp
    23f3:	68 02 02 00 00       	push   $0x202
    23f8:	68 94 47 00 00       	push   $0x4794
    23fd:	e8 b0 14 00 00       	call   38b2 <open>
    if(fd < 0){
    2402:	83 c4 10             	add    $0x10,%esp
    2405:	85 c0                	test   %eax,%eax
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2407:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2409:	78 7e                	js     2489 <bigwrite+0xc9>
      int cc = write(fd, buf, sz);
    240b:	83 ec 04             	sub    $0x4,%esp
    240e:	53                   	push   %ebx
    240f:	68 c0 85 00 00       	push   $0x85c0
    2414:	50                   	push   %eax
    2415:	e8 78 14 00 00       	call   3892 <write>
      if(cc != sz){
    241a:	83 c4 10             	add    $0x10,%esp
    241d:	39 d8                	cmp    %ebx,%eax
    241f:	75 55                	jne    2476 <bigwrite+0xb6>
      int cc = write(fd, buf, sz);
    2421:	83 ec 04             	sub    $0x4,%esp
    2424:	53                   	push   %ebx
    2425:	68 c0 85 00 00       	push   $0x85c0
    242a:	56                   	push   %esi
    242b:	e8 62 14 00 00       	call   3892 <write>
      if(cc != sz){
    2430:	83 c4 10             	add    $0x10,%esp
    2433:	39 d8                	cmp    %ebx,%eax
    2435:	75 3f                	jne    2476 <bigwrite+0xb6>
    close(fd);
    2437:	83 ec 0c             	sub    $0xc,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    243a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    close(fd);
    2440:	56                   	push   %esi
    2441:	e8 54 14 00 00       	call   389a <close>
    unlink("bigwrite");
    2446:	c7 04 24 94 47 00 00 	movl   $0x4794,(%esp)
    244d:	e8 70 14 00 00       	call   38c2 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    2452:	83 c4 10             	add    $0x10,%esp
    2455:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    245b:	75 93                	jne    23f0 <bigwrite+0x30>
  printf(1, "bigwrite ok\n");
    245d:	83 ec 08             	sub    $0x8,%esp
    2460:	68 c7 47 00 00       	push   $0x47c7
    2465:	6a 01                	push   $0x1
    2467:	e8 64 15 00 00       	call   39d0 <printf>
}
    246c:	83 c4 10             	add    $0x10,%esp
    246f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2472:	5b                   	pop    %ebx
    2473:	5e                   	pop    %esi
    2474:	5d                   	pop    %ebp
    2475:	c3                   	ret    
        printf(1, "write(%d) ret %d\n", sz, cc);
    2476:	50                   	push   %eax
    2477:	53                   	push   %ebx
    2478:	68 b5 47 00 00       	push   $0x47b5
    247d:	6a 01                	push   $0x1
    247f:	e8 4c 15 00 00       	call   39d0 <printf>
        exit();
    2484:	e8 e9 13 00 00       	call   3872 <exit>
      printf(1, "cannot create bigwrite\n");
    2489:	83 ec 08             	sub    $0x8,%esp
    248c:	68 9d 47 00 00       	push   $0x479d
    2491:	6a 01                	push   $0x1
    2493:	e8 38 15 00 00       	call   39d0 <printf>
      exit();
    2498:	e8 d5 13 00 00       	call   3872 <exit>
    249d:	8d 76 00             	lea    0x0(%esi),%esi

000024a0 <bigfile>:
{
    24a0:	55                   	push   %ebp
    24a1:	89 e5                	mov    %esp,%ebp
    24a3:	57                   	push   %edi
    24a4:	56                   	push   %esi
    24a5:	53                   	push   %ebx
    24a6:	83 ec 14             	sub    $0x14,%esp
  printf(1, "bigfile test\n");
    24a9:	68 d4 47 00 00       	push   $0x47d4
    24ae:	6a 01                	push   $0x1
    24b0:	e8 1b 15 00 00       	call   39d0 <printf>
  unlink("bigfile");
    24b5:	c7 04 24 f0 47 00 00 	movl   $0x47f0,(%esp)
    24bc:	e8 01 14 00 00       	call   38c2 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    24c1:	58                   	pop    %eax
    24c2:	5a                   	pop    %edx
    24c3:	68 02 02 00 00       	push   $0x202
    24c8:	68 f0 47 00 00       	push   $0x47f0
    24cd:	e8 e0 13 00 00       	call   38b2 <open>
  if(fd < 0){
    24d2:	83 c4 10             	add    $0x10,%esp
    24d5:	85 c0                	test   %eax,%eax
    24d7:	0f 88 5e 01 00 00    	js     263b <bigfile+0x19b>
    24dd:	89 c6                	mov    %eax,%esi
  for(i = 0; i < 20; i++){
    24df:	31 db                	xor    %ebx,%ebx
    24e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(buf, i, 600);
    24e8:	83 ec 04             	sub    $0x4,%esp
    24eb:	68 58 02 00 00       	push   $0x258
    24f0:	53                   	push   %ebx
    24f1:	68 c0 85 00 00       	push   $0x85c0
    24f6:	e8 d5 11 00 00       	call   36d0 <memset>
    if(write(fd, buf, 600) != 600){
    24fb:	83 c4 0c             	add    $0xc,%esp
    24fe:	68 58 02 00 00       	push   $0x258
    2503:	68 c0 85 00 00       	push   $0x85c0
    2508:	56                   	push   %esi
    2509:	e8 84 13 00 00       	call   3892 <write>
    250e:	83 c4 10             	add    $0x10,%esp
    2511:	3d 58 02 00 00       	cmp    $0x258,%eax
    2516:	0f 85 f8 00 00 00    	jne    2614 <bigfile+0x174>
  for(i = 0; i < 20; i++){
    251c:	83 c3 01             	add    $0x1,%ebx
    251f:	83 fb 14             	cmp    $0x14,%ebx
    2522:	75 c4                	jne    24e8 <bigfile+0x48>
  close(fd);
    2524:	83 ec 0c             	sub    $0xc,%esp
    2527:	56                   	push   %esi
    2528:	e8 6d 13 00 00       	call   389a <close>
  fd = open("bigfile", 0);
    252d:	5e                   	pop    %esi
    252e:	5f                   	pop    %edi
    252f:	6a 00                	push   $0x0
    2531:	68 f0 47 00 00       	push   $0x47f0
    2536:	e8 77 13 00 00       	call   38b2 <open>
  if(fd < 0){
    253b:	83 c4 10             	add    $0x10,%esp
    253e:	85 c0                	test   %eax,%eax
  fd = open("bigfile", 0);
    2540:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2542:	0f 88 e0 00 00 00    	js     2628 <bigfile+0x188>
  total = 0;
    2548:	31 db                	xor    %ebx,%ebx
  for(i = 0; ; i++){
    254a:	31 ff                	xor    %edi,%edi
    254c:	eb 30                	jmp    257e <bigfile+0xde>
    254e:	66 90                	xchg   %ax,%ax
    if(cc != 300){
    2550:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2555:	0f 85 91 00 00 00    	jne    25ec <bigfile+0x14c>
    if(buf[0] != i/2 || buf[299] != i/2){
    255b:	0f be 05 c0 85 00 00 	movsbl 0x85c0,%eax
    2562:	89 fa                	mov    %edi,%edx
    2564:	d1 fa                	sar    %edx
    2566:	39 d0                	cmp    %edx,%eax
    2568:	75 6e                	jne    25d8 <bigfile+0x138>
    256a:	0f be 15 eb 86 00 00 	movsbl 0x86eb,%edx
    2571:	39 d0                	cmp    %edx,%eax
    2573:	75 63                	jne    25d8 <bigfile+0x138>
    total += cc;
    2575:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
  for(i = 0; ; i++){
    257b:	83 c7 01             	add    $0x1,%edi
    cc = read(fd, buf, 300);
    257e:	83 ec 04             	sub    $0x4,%esp
    2581:	68 2c 01 00 00       	push   $0x12c
    2586:	68 c0 85 00 00       	push   $0x85c0
    258b:	56                   	push   %esi
    258c:	e8 f9 12 00 00       	call   388a <read>
    if(cc < 0){
    2591:	83 c4 10             	add    $0x10,%esp
    2594:	85 c0                	test   %eax,%eax
    2596:	78 68                	js     2600 <bigfile+0x160>
    if(cc == 0)
    2598:	75 b6                	jne    2550 <bigfile+0xb0>
  close(fd);
    259a:	83 ec 0c             	sub    $0xc,%esp
    259d:	56                   	push   %esi
    259e:	e8 f7 12 00 00       	call   389a <close>
  if(total != 20*600){
    25a3:	83 c4 10             	add    $0x10,%esp
    25a6:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    25ac:	0f 85 9c 00 00 00    	jne    264e <bigfile+0x1ae>
  unlink("bigfile");
    25b2:	83 ec 0c             	sub    $0xc,%esp
    25b5:	68 f0 47 00 00       	push   $0x47f0
    25ba:	e8 03 13 00 00       	call   38c2 <unlink>
  printf(1, "bigfile test ok\n");
    25bf:	58                   	pop    %eax
    25c0:	5a                   	pop    %edx
    25c1:	68 7f 48 00 00       	push   $0x487f
    25c6:	6a 01                	push   $0x1
    25c8:	e8 03 14 00 00       	call   39d0 <printf>
}
    25cd:	83 c4 10             	add    $0x10,%esp
    25d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    25d3:	5b                   	pop    %ebx
    25d4:	5e                   	pop    %esi
    25d5:	5f                   	pop    %edi
    25d6:	5d                   	pop    %ebp
    25d7:	c3                   	ret    
      printf(1, "read bigfile wrong data\n");
    25d8:	83 ec 08             	sub    $0x8,%esp
    25db:	68 4c 48 00 00       	push   $0x484c
    25e0:	6a 01                	push   $0x1
    25e2:	e8 e9 13 00 00       	call   39d0 <printf>
      exit();
    25e7:	e8 86 12 00 00       	call   3872 <exit>
      printf(1, "short read bigfile\n");
    25ec:	83 ec 08             	sub    $0x8,%esp
    25ef:	68 38 48 00 00       	push   $0x4838
    25f4:	6a 01                	push   $0x1
    25f6:	e8 d5 13 00 00       	call   39d0 <printf>
      exit();
    25fb:	e8 72 12 00 00       	call   3872 <exit>
      printf(1, "read bigfile failed\n");
    2600:	83 ec 08             	sub    $0x8,%esp
    2603:	68 23 48 00 00       	push   $0x4823
    2608:	6a 01                	push   $0x1
    260a:	e8 c1 13 00 00       	call   39d0 <printf>
      exit();
    260f:	e8 5e 12 00 00       	call   3872 <exit>
      printf(1, "write bigfile failed\n");
    2614:	83 ec 08             	sub    $0x8,%esp
    2617:	68 f8 47 00 00       	push   $0x47f8
    261c:	6a 01                	push   $0x1
    261e:	e8 ad 13 00 00       	call   39d0 <printf>
      exit();
    2623:	e8 4a 12 00 00       	call   3872 <exit>
    printf(1, "cannot open bigfile\n");
    2628:	53                   	push   %ebx
    2629:	53                   	push   %ebx
    262a:	68 0e 48 00 00       	push   $0x480e
    262f:	6a 01                	push   $0x1
    2631:	e8 9a 13 00 00       	call   39d0 <printf>
    exit();
    2636:	e8 37 12 00 00       	call   3872 <exit>
    printf(1, "cannot create bigfile");
    263b:	50                   	push   %eax
    263c:	50                   	push   %eax
    263d:	68 e2 47 00 00       	push   $0x47e2
    2642:	6a 01                	push   $0x1
    2644:	e8 87 13 00 00       	call   39d0 <printf>
    exit();
    2649:	e8 24 12 00 00       	call   3872 <exit>
    printf(1, "read bigfile wrong total\n");
    264e:	51                   	push   %ecx
    264f:	51                   	push   %ecx
    2650:	68 65 48 00 00       	push   $0x4865
    2655:	6a 01                	push   $0x1
    2657:	e8 74 13 00 00       	call   39d0 <printf>
    exit();
    265c:	e8 11 12 00 00       	call   3872 <exit>
    2661:	eb 0d                	jmp    2670 <fourteen>
    2663:	90                   	nop
    2664:	90                   	nop
    2665:	90                   	nop
    2666:	90                   	nop
    2667:	90                   	nop
    2668:	90                   	nop
    2669:	90                   	nop
    266a:	90                   	nop
    266b:	90                   	nop
    266c:	90                   	nop
    266d:	90                   	nop
    266e:	90                   	nop
    266f:	90                   	nop

00002670 <fourteen>:
{
    2670:	55                   	push   %ebp
    2671:	89 e5                	mov    %esp,%ebp
    2673:	83 ec 10             	sub    $0x10,%esp
  printf(1, "fourteen test\n");
    2676:	68 90 48 00 00       	push   $0x4890
    267b:	6a 01                	push   $0x1
    267d:	e8 4e 13 00 00       	call   39d0 <printf>
  if(mkdir("12345678901234") != 0){
    2682:	c7 04 24 cb 48 00 00 	movl   $0x48cb,(%esp)
    2689:	e8 4c 12 00 00       	call   38da <mkdir>
    268e:	83 c4 10             	add    $0x10,%esp
    2691:	85 c0                	test   %eax,%eax
    2693:	0f 85 97 00 00 00    	jne    2730 <fourteen+0xc0>
  if(mkdir("12345678901234/123456789012345") != 0){
    2699:	83 ec 0c             	sub    $0xc,%esp
    269c:	68 88 50 00 00       	push   $0x5088
    26a1:	e8 34 12 00 00       	call   38da <mkdir>
    26a6:	83 c4 10             	add    $0x10,%esp
    26a9:	85 c0                	test   %eax,%eax
    26ab:	0f 85 de 00 00 00    	jne    278f <fourteen+0x11f>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    26b1:	83 ec 08             	sub    $0x8,%esp
    26b4:	68 00 02 00 00       	push   $0x200
    26b9:	68 d8 50 00 00       	push   $0x50d8
    26be:	e8 ef 11 00 00       	call   38b2 <open>
  if(fd < 0){
    26c3:	83 c4 10             	add    $0x10,%esp
    26c6:	85 c0                	test   %eax,%eax
    26c8:	0f 88 ae 00 00 00    	js     277c <fourteen+0x10c>
  close(fd);
    26ce:	83 ec 0c             	sub    $0xc,%esp
    26d1:	50                   	push   %eax
    26d2:	e8 c3 11 00 00       	call   389a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    26d7:	58                   	pop    %eax
    26d8:	5a                   	pop    %edx
    26d9:	6a 00                	push   $0x0
    26db:	68 48 51 00 00       	push   $0x5148
    26e0:	e8 cd 11 00 00       	call   38b2 <open>
  if(fd < 0){
    26e5:	83 c4 10             	add    $0x10,%esp
    26e8:	85 c0                	test   %eax,%eax
    26ea:	78 7d                	js     2769 <fourteen+0xf9>
  close(fd);
    26ec:	83 ec 0c             	sub    $0xc,%esp
    26ef:	50                   	push   %eax
    26f0:	e8 a5 11 00 00       	call   389a <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    26f5:	c7 04 24 bc 48 00 00 	movl   $0x48bc,(%esp)
    26fc:	e8 d9 11 00 00       	call   38da <mkdir>
    2701:	83 c4 10             	add    $0x10,%esp
    2704:	85 c0                	test   %eax,%eax
    2706:	74 4e                	je     2756 <fourteen+0xe6>
  if(mkdir("123456789012345/12345678901234") == 0){
    2708:	83 ec 0c             	sub    $0xc,%esp
    270b:	68 e4 51 00 00       	push   $0x51e4
    2710:	e8 c5 11 00 00       	call   38da <mkdir>
    2715:	83 c4 10             	add    $0x10,%esp
    2718:	85 c0                	test   %eax,%eax
    271a:	74 27                	je     2743 <fourteen+0xd3>
  printf(1, "fourteen ok\n");
    271c:	83 ec 08             	sub    $0x8,%esp
    271f:	68 da 48 00 00       	push   $0x48da
    2724:	6a 01                	push   $0x1
    2726:	e8 a5 12 00 00       	call   39d0 <printf>
}
    272b:	83 c4 10             	add    $0x10,%esp
    272e:	c9                   	leave  
    272f:	c3                   	ret    
    printf(1, "mkdir 12345678901234 failed\n");
    2730:	50                   	push   %eax
    2731:	50                   	push   %eax
    2732:	68 9f 48 00 00       	push   $0x489f
    2737:	6a 01                	push   $0x1
    2739:	e8 92 12 00 00       	call   39d0 <printf>
    exit();
    273e:	e8 2f 11 00 00       	call   3872 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2743:	50                   	push   %eax
    2744:	50                   	push   %eax
    2745:	68 04 52 00 00       	push   $0x5204
    274a:	6a 01                	push   $0x1
    274c:	e8 7f 12 00 00       	call   39d0 <printf>
    exit();
    2751:	e8 1c 11 00 00       	call   3872 <exit>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2756:	52                   	push   %edx
    2757:	52                   	push   %edx
    2758:	68 b4 51 00 00       	push   $0x51b4
    275d:	6a 01                	push   $0x1
    275f:	e8 6c 12 00 00       	call   39d0 <printf>
    exit();
    2764:	e8 09 11 00 00       	call   3872 <exit>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2769:	51                   	push   %ecx
    276a:	51                   	push   %ecx
    276b:	68 78 51 00 00       	push   $0x5178
    2770:	6a 01                	push   $0x1
    2772:	e8 59 12 00 00       	call   39d0 <printf>
    exit();
    2777:	e8 f6 10 00 00       	call   3872 <exit>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    277c:	51                   	push   %ecx
    277d:	51                   	push   %ecx
    277e:	68 08 51 00 00       	push   $0x5108
    2783:	6a 01                	push   $0x1
    2785:	e8 46 12 00 00       	call   39d0 <printf>
    exit();
    278a:	e8 e3 10 00 00       	call   3872 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    278f:	50                   	push   %eax
    2790:	50                   	push   %eax
    2791:	68 a8 50 00 00       	push   $0x50a8
    2796:	6a 01                	push   $0x1
    2798:	e8 33 12 00 00       	call   39d0 <printf>
    exit();
    279d:	e8 d0 10 00 00       	call   3872 <exit>
    27a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    27a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000027b0 <rmdot>:
{
    27b0:	55                   	push   %ebp
    27b1:	89 e5                	mov    %esp,%ebp
    27b3:	83 ec 10             	sub    $0x10,%esp
  printf(1, "rmdot test\n");
    27b6:	68 e7 48 00 00       	push   $0x48e7
    27bb:	6a 01                	push   $0x1
    27bd:	e8 0e 12 00 00       	call   39d0 <printf>
  if(mkdir("dots") != 0){
    27c2:	c7 04 24 f3 48 00 00 	movl   $0x48f3,(%esp)
    27c9:	e8 0c 11 00 00       	call   38da <mkdir>
    27ce:	83 c4 10             	add    $0x10,%esp
    27d1:	85 c0                	test   %eax,%eax
    27d3:	0f 85 b0 00 00 00    	jne    2889 <rmdot+0xd9>
  if(chdir("dots") != 0){
    27d9:	83 ec 0c             	sub    $0xc,%esp
    27dc:	68 f3 48 00 00       	push   $0x48f3
    27e1:	e8 fc 10 00 00       	call   38e2 <chdir>
    27e6:	83 c4 10             	add    $0x10,%esp
    27e9:	85 c0                	test   %eax,%eax
    27eb:	0f 85 1d 01 00 00    	jne    290e <rmdot+0x15e>
  if(unlink(".") == 0){
    27f1:	83 ec 0c             	sub    $0xc,%esp
    27f4:	68 9e 45 00 00       	push   $0x459e
    27f9:	e8 c4 10 00 00       	call   38c2 <unlink>
    27fe:	83 c4 10             	add    $0x10,%esp
    2801:	85 c0                	test   %eax,%eax
    2803:	0f 84 f2 00 00 00    	je     28fb <rmdot+0x14b>
  if(unlink("..") == 0){
    2809:	83 ec 0c             	sub    $0xc,%esp
    280c:	68 9d 45 00 00       	push   $0x459d
    2811:	e8 ac 10 00 00       	call   38c2 <unlink>
    2816:	83 c4 10             	add    $0x10,%esp
    2819:	85 c0                	test   %eax,%eax
    281b:	0f 84 c7 00 00 00    	je     28e8 <rmdot+0x138>
  if(chdir("/") != 0){
    2821:	83 ec 0c             	sub    $0xc,%esp
    2824:	68 71 3d 00 00       	push   $0x3d71
    2829:	e8 b4 10 00 00       	call   38e2 <chdir>
    282e:	83 c4 10             	add    $0x10,%esp
    2831:	85 c0                	test   %eax,%eax
    2833:	0f 85 9c 00 00 00    	jne    28d5 <rmdot+0x125>
  if(unlink("dots/.") == 0){
    2839:	83 ec 0c             	sub    $0xc,%esp
    283c:	68 3b 49 00 00       	push   $0x493b
    2841:	e8 7c 10 00 00       	call   38c2 <unlink>
    2846:	83 c4 10             	add    $0x10,%esp
    2849:	85 c0                	test   %eax,%eax
    284b:	74 75                	je     28c2 <rmdot+0x112>
  if(unlink("dots/..") == 0){
    284d:	83 ec 0c             	sub    $0xc,%esp
    2850:	68 59 49 00 00       	push   $0x4959
    2855:	e8 68 10 00 00       	call   38c2 <unlink>
    285a:	83 c4 10             	add    $0x10,%esp
    285d:	85 c0                	test   %eax,%eax
    285f:	74 4e                	je     28af <rmdot+0xff>
  if(unlink("dots") != 0){
    2861:	83 ec 0c             	sub    $0xc,%esp
    2864:	68 f3 48 00 00       	push   $0x48f3
    2869:	e8 54 10 00 00       	call   38c2 <unlink>
    286e:	83 c4 10             	add    $0x10,%esp
    2871:	85 c0                	test   %eax,%eax
    2873:	75 27                	jne    289c <rmdot+0xec>
  printf(1, "rmdot ok\n");
    2875:	83 ec 08             	sub    $0x8,%esp
    2878:	68 8e 49 00 00       	push   $0x498e
    287d:	6a 01                	push   $0x1
    287f:	e8 4c 11 00 00       	call   39d0 <printf>
}
    2884:	83 c4 10             	add    $0x10,%esp
    2887:	c9                   	leave  
    2888:	c3                   	ret    
    printf(1, "mkdir dots failed\n");
    2889:	50                   	push   %eax
    288a:	50                   	push   %eax
    288b:	68 f8 48 00 00       	push   $0x48f8
    2890:	6a 01                	push   $0x1
    2892:	e8 39 11 00 00       	call   39d0 <printf>
    exit();
    2897:	e8 d6 0f 00 00       	call   3872 <exit>
    printf(1, "unlink dots failed!\n");
    289c:	50                   	push   %eax
    289d:	50                   	push   %eax
    289e:	68 79 49 00 00       	push   $0x4979
    28a3:	6a 01                	push   $0x1
    28a5:	e8 26 11 00 00       	call   39d0 <printf>
    exit();
    28aa:	e8 c3 0f 00 00       	call   3872 <exit>
    printf(1, "unlink dots/.. worked!\n");
    28af:	52                   	push   %edx
    28b0:	52                   	push   %edx
    28b1:	68 61 49 00 00       	push   $0x4961
    28b6:	6a 01                	push   $0x1
    28b8:	e8 13 11 00 00       	call   39d0 <printf>
    exit();
    28bd:	e8 b0 0f 00 00       	call   3872 <exit>
    printf(1, "unlink dots/. worked!\n");
    28c2:	51                   	push   %ecx
    28c3:	51                   	push   %ecx
    28c4:	68 42 49 00 00       	push   $0x4942
    28c9:	6a 01                	push   $0x1
    28cb:	e8 00 11 00 00       	call   39d0 <printf>
    exit();
    28d0:	e8 9d 0f 00 00       	call   3872 <exit>
    printf(1, "chdir / failed\n");
    28d5:	50                   	push   %eax
    28d6:	50                   	push   %eax
    28d7:	68 73 3d 00 00       	push   $0x3d73
    28dc:	6a 01                	push   $0x1
    28de:	e8 ed 10 00 00       	call   39d0 <printf>
    exit();
    28e3:	e8 8a 0f 00 00       	call   3872 <exit>
    printf(1, "rm .. worked!\n");
    28e8:	50                   	push   %eax
    28e9:	50                   	push   %eax
    28ea:	68 2c 49 00 00       	push   $0x492c
    28ef:	6a 01                	push   $0x1
    28f1:	e8 da 10 00 00       	call   39d0 <printf>
    exit();
    28f6:	e8 77 0f 00 00       	call   3872 <exit>
    printf(1, "rm . worked!\n");
    28fb:	50                   	push   %eax
    28fc:	50                   	push   %eax
    28fd:	68 1e 49 00 00       	push   $0x491e
    2902:	6a 01                	push   $0x1
    2904:	e8 c7 10 00 00       	call   39d0 <printf>
    exit();
    2909:	e8 64 0f 00 00       	call   3872 <exit>
    printf(1, "chdir dots failed\n");
    290e:	50                   	push   %eax
    290f:	50                   	push   %eax
    2910:	68 0b 49 00 00       	push   $0x490b
    2915:	6a 01                	push   $0x1
    2917:	e8 b4 10 00 00       	call   39d0 <printf>
    exit();
    291c:	e8 51 0f 00 00       	call   3872 <exit>
    2921:	eb 0d                	jmp    2930 <dirfile>
    2923:	90                   	nop
    2924:	90                   	nop
    2925:	90                   	nop
    2926:	90                   	nop
    2927:	90                   	nop
    2928:	90                   	nop
    2929:	90                   	nop
    292a:	90                   	nop
    292b:	90                   	nop
    292c:	90                   	nop
    292d:	90                   	nop
    292e:	90                   	nop
    292f:	90                   	nop

00002930 <dirfile>:
{
    2930:	55                   	push   %ebp
    2931:	89 e5                	mov    %esp,%ebp
    2933:	53                   	push   %ebx
    2934:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "dir vs file\n");
    2937:	68 98 49 00 00       	push   $0x4998
    293c:	6a 01                	push   $0x1
    293e:	e8 8d 10 00 00       	call   39d0 <printf>
  fd = open("dirfile", O_CREATE);
    2943:	59                   	pop    %ecx
    2944:	5b                   	pop    %ebx
    2945:	68 00 02 00 00       	push   $0x200
    294a:	68 a5 49 00 00       	push   $0x49a5
    294f:	e8 5e 0f 00 00       	call   38b2 <open>
  if(fd < 0){
    2954:	83 c4 10             	add    $0x10,%esp
    2957:	85 c0                	test   %eax,%eax
    2959:	0f 88 43 01 00 00    	js     2aa2 <dirfile+0x172>
  close(fd);
    295f:	83 ec 0c             	sub    $0xc,%esp
    2962:	50                   	push   %eax
    2963:	e8 32 0f 00 00       	call   389a <close>
  if(chdir("dirfile") == 0){
    2968:	c7 04 24 a5 49 00 00 	movl   $0x49a5,(%esp)
    296f:	e8 6e 0f 00 00       	call   38e2 <chdir>
    2974:	83 c4 10             	add    $0x10,%esp
    2977:	85 c0                	test   %eax,%eax
    2979:	0f 84 10 01 00 00    	je     2a8f <dirfile+0x15f>
  fd = open("dirfile/xx", 0);
    297f:	83 ec 08             	sub    $0x8,%esp
    2982:	6a 00                	push   $0x0
    2984:	68 de 49 00 00       	push   $0x49de
    2989:	e8 24 0f 00 00       	call   38b2 <open>
  if(fd >= 0){
    298e:	83 c4 10             	add    $0x10,%esp
    2991:	85 c0                	test   %eax,%eax
    2993:	0f 89 e3 00 00 00    	jns    2a7c <dirfile+0x14c>
  fd = open("dirfile/xx", O_CREATE);
    2999:	83 ec 08             	sub    $0x8,%esp
    299c:	68 00 02 00 00       	push   $0x200
    29a1:	68 de 49 00 00       	push   $0x49de
    29a6:	e8 07 0f 00 00       	call   38b2 <open>
  if(fd >= 0){
    29ab:	83 c4 10             	add    $0x10,%esp
    29ae:	85 c0                	test   %eax,%eax
    29b0:	0f 89 c6 00 00 00    	jns    2a7c <dirfile+0x14c>
  if(mkdir("dirfile/xx") == 0){
    29b6:	83 ec 0c             	sub    $0xc,%esp
    29b9:	68 de 49 00 00       	push   $0x49de
    29be:	e8 17 0f 00 00       	call   38da <mkdir>
    29c3:	83 c4 10             	add    $0x10,%esp
    29c6:	85 c0                	test   %eax,%eax
    29c8:	0f 84 46 01 00 00    	je     2b14 <dirfile+0x1e4>
  if(unlink("dirfile/xx") == 0){
    29ce:	83 ec 0c             	sub    $0xc,%esp
    29d1:	68 de 49 00 00       	push   $0x49de
    29d6:	e8 e7 0e 00 00       	call   38c2 <unlink>
    29db:	83 c4 10             	add    $0x10,%esp
    29de:	85 c0                	test   %eax,%eax
    29e0:	0f 84 1b 01 00 00    	je     2b01 <dirfile+0x1d1>
  if(link("README", "dirfile/xx") == 0){
    29e6:	83 ec 08             	sub    $0x8,%esp
    29e9:	68 de 49 00 00       	push   $0x49de
    29ee:	68 42 4a 00 00       	push   $0x4a42
    29f3:	e8 da 0e 00 00       	call   38d2 <link>
    29f8:	83 c4 10             	add    $0x10,%esp
    29fb:	85 c0                	test   %eax,%eax
    29fd:	0f 84 eb 00 00 00    	je     2aee <dirfile+0x1be>
  if(unlink("dirfile") != 0){
    2a03:	83 ec 0c             	sub    $0xc,%esp
    2a06:	68 a5 49 00 00       	push   $0x49a5
    2a0b:	e8 b2 0e 00 00       	call   38c2 <unlink>
    2a10:	83 c4 10             	add    $0x10,%esp
    2a13:	85 c0                	test   %eax,%eax
    2a15:	0f 85 c0 00 00 00    	jne    2adb <dirfile+0x1ab>
  fd = open(".", O_RDWR);
    2a1b:	83 ec 08             	sub    $0x8,%esp
    2a1e:	6a 02                	push   $0x2
    2a20:	68 9e 45 00 00       	push   $0x459e
    2a25:	e8 88 0e 00 00       	call   38b2 <open>
  if(fd >= 0){
    2a2a:	83 c4 10             	add    $0x10,%esp
    2a2d:	85 c0                	test   %eax,%eax
    2a2f:	0f 89 93 00 00 00    	jns    2ac8 <dirfile+0x198>
  fd = open(".", 0);
    2a35:	83 ec 08             	sub    $0x8,%esp
    2a38:	6a 00                	push   $0x0
    2a3a:	68 9e 45 00 00       	push   $0x459e
    2a3f:	e8 6e 0e 00 00       	call   38b2 <open>
  if(write(fd, "x", 1) > 0){
    2a44:	83 c4 0c             	add    $0xc,%esp
  fd = open(".", 0);
    2a47:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2a49:	6a 01                	push   $0x1
    2a4b:	68 81 46 00 00       	push   $0x4681
    2a50:	50                   	push   %eax
    2a51:	e8 3c 0e 00 00       	call   3892 <write>
    2a56:	83 c4 10             	add    $0x10,%esp
    2a59:	85 c0                	test   %eax,%eax
    2a5b:	7f 58                	jg     2ab5 <dirfile+0x185>
  close(fd);
    2a5d:	83 ec 0c             	sub    $0xc,%esp
    2a60:	53                   	push   %ebx
    2a61:	e8 34 0e 00 00       	call   389a <close>
  printf(1, "dir vs file OK\n");
    2a66:	58                   	pop    %eax
    2a67:	5a                   	pop    %edx
    2a68:	68 75 4a 00 00       	push   $0x4a75
    2a6d:	6a 01                	push   $0x1
    2a6f:	e8 5c 0f 00 00       	call   39d0 <printf>
}
    2a74:	83 c4 10             	add    $0x10,%esp
    2a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2a7a:	c9                   	leave  
    2a7b:	c3                   	ret    
    printf(1, "create dirfile/xx succeeded!\n");
    2a7c:	50                   	push   %eax
    2a7d:	50                   	push   %eax
    2a7e:	68 e9 49 00 00       	push   $0x49e9
    2a83:	6a 01                	push   $0x1
    2a85:	e8 46 0f 00 00       	call   39d0 <printf>
    exit();
    2a8a:	e8 e3 0d 00 00       	call   3872 <exit>
    printf(1, "chdir dirfile succeeded!\n");
    2a8f:	50                   	push   %eax
    2a90:	50                   	push   %eax
    2a91:	68 c4 49 00 00       	push   $0x49c4
    2a96:	6a 01                	push   $0x1
    2a98:	e8 33 0f 00 00       	call   39d0 <printf>
    exit();
    2a9d:	e8 d0 0d 00 00       	call   3872 <exit>
    printf(1, "create dirfile failed\n");
    2aa2:	52                   	push   %edx
    2aa3:	52                   	push   %edx
    2aa4:	68 ad 49 00 00       	push   $0x49ad
    2aa9:	6a 01                	push   $0x1
    2aab:	e8 20 0f 00 00       	call   39d0 <printf>
    exit();
    2ab0:	e8 bd 0d 00 00       	call   3872 <exit>
    printf(1, "write . succeeded!\n");
    2ab5:	51                   	push   %ecx
    2ab6:	51                   	push   %ecx
    2ab7:	68 61 4a 00 00       	push   $0x4a61
    2abc:	6a 01                	push   $0x1
    2abe:	e8 0d 0f 00 00       	call   39d0 <printf>
    exit();
    2ac3:	e8 aa 0d 00 00       	call   3872 <exit>
    printf(1, "open . for writing succeeded!\n");
    2ac8:	53                   	push   %ebx
    2ac9:	53                   	push   %ebx
    2aca:	68 58 52 00 00       	push   $0x5258
    2acf:	6a 01                	push   $0x1
    2ad1:	e8 fa 0e 00 00       	call   39d0 <printf>
    exit();
    2ad6:	e8 97 0d 00 00       	call   3872 <exit>
    printf(1, "unlink dirfile failed!\n");
    2adb:	50                   	push   %eax
    2adc:	50                   	push   %eax
    2add:	68 49 4a 00 00       	push   $0x4a49
    2ae2:	6a 01                	push   $0x1
    2ae4:	e8 e7 0e 00 00       	call   39d0 <printf>
    exit();
    2ae9:	e8 84 0d 00 00       	call   3872 <exit>
    printf(1, "link to dirfile/xx succeeded!\n");
    2aee:	50                   	push   %eax
    2aef:	50                   	push   %eax
    2af0:	68 38 52 00 00       	push   $0x5238
    2af5:	6a 01                	push   $0x1
    2af7:	e8 d4 0e 00 00       	call   39d0 <printf>
    exit();
    2afc:	e8 71 0d 00 00       	call   3872 <exit>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b01:	50                   	push   %eax
    2b02:	50                   	push   %eax
    2b03:	68 24 4a 00 00       	push   $0x4a24
    2b08:	6a 01                	push   $0x1
    2b0a:	e8 c1 0e 00 00       	call   39d0 <printf>
    exit();
    2b0f:	e8 5e 0d 00 00       	call   3872 <exit>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2b14:	50                   	push   %eax
    2b15:	50                   	push   %eax
    2b16:	68 07 4a 00 00       	push   $0x4a07
    2b1b:	6a 01                	push   $0x1
    2b1d:	e8 ae 0e 00 00       	call   39d0 <printf>
    exit();
    2b22:	e8 4b 0d 00 00       	call   3872 <exit>
    2b27:	89 f6                	mov    %esi,%esi
    2b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002b30 <iref>:
{
    2b30:	55                   	push   %ebp
    2b31:	89 e5                	mov    %esp,%ebp
    2b33:	53                   	push   %ebx
  printf(1, "empty file name\n");
    2b34:	bb 33 00 00 00       	mov    $0x33,%ebx
{
    2b39:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "empty file name\n");
    2b3c:	68 85 4a 00 00       	push   $0x4a85
    2b41:	6a 01                	push   $0x1
    2b43:	e8 88 0e 00 00       	call   39d0 <printf>
    2b48:	83 c4 10             	add    $0x10,%esp
    2b4b:	90                   	nop
    2b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(mkdir("irefd") != 0){
    2b50:	83 ec 0c             	sub    $0xc,%esp
    2b53:	68 96 4a 00 00       	push   $0x4a96
    2b58:	e8 7d 0d 00 00       	call   38da <mkdir>
    2b5d:	83 c4 10             	add    $0x10,%esp
    2b60:	85 c0                	test   %eax,%eax
    2b62:	0f 85 bb 00 00 00    	jne    2c23 <iref+0xf3>
    if(chdir("irefd") != 0){
    2b68:	83 ec 0c             	sub    $0xc,%esp
    2b6b:	68 96 4a 00 00       	push   $0x4a96
    2b70:	e8 6d 0d 00 00       	call   38e2 <chdir>
    2b75:	83 c4 10             	add    $0x10,%esp
    2b78:	85 c0                	test   %eax,%eax
    2b7a:	0f 85 b7 00 00 00    	jne    2c37 <iref+0x107>
    mkdir("");
    2b80:	83 ec 0c             	sub    $0xc,%esp
    2b83:	68 4b 41 00 00       	push   $0x414b
    2b88:	e8 4d 0d 00 00       	call   38da <mkdir>
    link("README", "");
    2b8d:	59                   	pop    %ecx
    2b8e:	58                   	pop    %eax
    2b8f:	68 4b 41 00 00       	push   $0x414b
    2b94:	68 42 4a 00 00       	push   $0x4a42
    2b99:	e8 34 0d 00 00       	call   38d2 <link>
    fd = open("", O_CREATE);
    2b9e:	58                   	pop    %eax
    2b9f:	5a                   	pop    %edx
    2ba0:	68 00 02 00 00       	push   $0x200
    2ba5:	68 4b 41 00 00       	push   $0x414b
    2baa:	e8 03 0d 00 00       	call   38b2 <open>
    if(fd >= 0)
    2baf:	83 c4 10             	add    $0x10,%esp
    2bb2:	85 c0                	test   %eax,%eax
    2bb4:	78 0c                	js     2bc2 <iref+0x92>
      close(fd);
    2bb6:	83 ec 0c             	sub    $0xc,%esp
    2bb9:	50                   	push   %eax
    2bba:	e8 db 0c 00 00       	call   389a <close>
    2bbf:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2bc2:	83 ec 08             	sub    $0x8,%esp
    2bc5:	68 00 02 00 00       	push   $0x200
    2bca:	68 80 46 00 00       	push   $0x4680
    2bcf:	e8 de 0c 00 00       	call   38b2 <open>
    if(fd >= 0)
    2bd4:	83 c4 10             	add    $0x10,%esp
    2bd7:	85 c0                	test   %eax,%eax
    2bd9:	78 0c                	js     2be7 <iref+0xb7>
      close(fd);
    2bdb:	83 ec 0c             	sub    $0xc,%esp
    2bde:	50                   	push   %eax
    2bdf:	e8 b6 0c 00 00       	call   389a <close>
    2be4:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2be7:	83 ec 0c             	sub    $0xc,%esp
    2bea:	68 80 46 00 00       	push   $0x4680
    2bef:	e8 ce 0c 00 00       	call   38c2 <unlink>
  for(i = 0; i < 50 + 1; i++){
    2bf4:	83 c4 10             	add    $0x10,%esp
    2bf7:	83 eb 01             	sub    $0x1,%ebx
    2bfa:	0f 85 50 ff ff ff    	jne    2b50 <iref+0x20>
  chdir("/");
    2c00:	83 ec 0c             	sub    $0xc,%esp
    2c03:	68 71 3d 00 00       	push   $0x3d71
    2c08:	e8 d5 0c 00 00       	call   38e2 <chdir>
  printf(1, "empty file name OK\n");
    2c0d:	58                   	pop    %eax
    2c0e:	5a                   	pop    %edx
    2c0f:	68 c4 4a 00 00       	push   $0x4ac4
    2c14:	6a 01                	push   $0x1
    2c16:	e8 b5 0d 00 00       	call   39d0 <printf>
}
    2c1b:	83 c4 10             	add    $0x10,%esp
    2c1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2c21:	c9                   	leave  
    2c22:	c3                   	ret    
      printf(1, "mkdir irefd failed\n");
    2c23:	83 ec 08             	sub    $0x8,%esp
    2c26:	68 9c 4a 00 00       	push   $0x4a9c
    2c2b:	6a 01                	push   $0x1
    2c2d:	e8 9e 0d 00 00       	call   39d0 <printf>
      exit();
    2c32:	e8 3b 0c 00 00       	call   3872 <exit>
      printf(1, "chdir irefd failed\n");
    2c37:	83 ec 08             	sub    $0x8,%esp
    2c3a:	68 b0 4a 00 00       	push   $0x4ab0
    2c3f:	6a 01                	push   $0x1
    2c41:	e8 8a 0d 00 00       	call   39d0 <printf>
      exit();
    2c46:	e8 27 0c 00 00       	call   3872 <exit>
    2c4b:	90                   	nop
    2c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002c50 <forktest>:
{
    2c50:	55                   	push   %ebp
    2c51:	89 e5                	mov    %esp,%ebp
    2c53:	53                   	push   %ebx
  for(n=0; n<1000; n++){
    2c54:	31 db                	xor    %ebx,%ebx
{
    2c56:	83 ec 0c             	sub    $0xc,%esp
  printf(1, "fork test\n");
    2c59:	68 d8 4a 00 00       	push   $0x4ad8
    2c5e:	6a 01                	push   $0x1
    2c60:	e8 6b 0d 00 00       	call   39d0 <printf>
    2c65:	83 c4 10             	add    $0x10,%esp
    2c68:	eb 13                	jmp    2c7d <forktest+0x2d>
    2c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(pid == 0)
    2c70:	74 62                	je     2cd4 <forktest+0x84>
  for(n=0; n<1000; n++){
    2c72:	83 c3 01             	add    $0x1,%ebx
    2c75:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2c7b:	74 43                	je     2cc0 <forktest+0x70>
    pid = fork();
    2c7d:	e8 e8 0b 00 00       	call   386a <fork>
    if(pid < 0)
    2c82:	85 c0                	test   %eax,%eax
    2c84:	79 ea                	jns    2c70 <forktest+0x20>
  for(; n > 0; n--){
    2c86:	85 db                	test   %ebx,%ebx
    2c88:	74 14                	je     2c9e <forktest+0x4e>
    2c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2c90:	e8 e5 0b 00 00       	call   387a <wait>
    2c95:	85 c0                	test   %eax,%eax
    2c97:	78 40                	js     2cd9 <forktest+0x89>
  for(; n > 0; n--){
    2c99:	83 eb 01             	sub    $0x1,%ebx
    2c9c:	75 f2                	jne    2c90 <forktest+0x40>
  if(wait() != -1){
    2c9e:	e8 d7 0b 00 00       	call   387a <wait>
    2ca3:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ca6:	75 45                	jne    2ced <forktest+0x9d>
  printf(1, "fork test OK\n");
    2ca8:	83 ec 08             	sub    $0x8,%esp
    2cab:	68 0a 4b 00 00       	push   $0x4b0a
    2cb0:	6a 01                	push   $0x1
    2cb2:	e8 19 0d 00 00       	call   39d0 <printf>
}
    2cb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cba:	c9                   	leave  
    2cbb:	c3                   	ret    
    2cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "fork claimed to work 1000 times!\n");
    2cc0:	83 ec 08             	sub    $0x8,%esp
    2cc3:	68 78 52 00 00       	push   $0x5278
    2cc8:	6a 01                	push   $0x1
    2cca:	e8 01 0d 00 00       	call   39d0 <printf>
    exit();
    2ccf:	e8 9e 0b 00 00       	call   3872 <exit>
      exit();
    2cd4:	e8 99 0b 00 00       	call   3872 <exit>
      printf(1, "wait stopped early\n");
    2cd9:	83 ec 08             	sub    $0x8,%esp
    2cdc:	68 e3 4a 00 00       	push   $0x4ae3
    2ce1:	6a 01                	push   $0x1
    2ce3:	e8 e8 0c 00 00       	call   39d0 <printf>
      exit();
    2ce8:	e8 85 0b 00 00       	call   3872 <exit>
    printf(1, "wait got too many\n");
    2ced:	50                   	push   %eax
    2cee:	50                   	push   %eax
    2cef:	68 f7 4a 00 00       	push   $0x4af7
    2cf4:	6a 01                	push   $0x1
    2cf6:	e8 d5 0c 00 00       	call   39d0 <printf>
    exit();
    2cfb:	e8 72 0b 00 00       	call   3872 <exit>

00002d00 <sbrktest>:
{
    2d00:	55                   	push   %ebp
    2d01:	89 e5                	mov    %esp,%ebp
    2d03:	57                   	push   %edi
    2d04:	56                   	push   %esi
    2d05:	53                   	push   %ebx
  for(i = 0; i < 5000; i++){
    2d06:	31 ff                	xor    %edi,%edi
{
    2d08:	83 ec 64             	sub    $0x64,%esp
  printf(stdout, "sbrk test\n");
    2d0b:	68 18 4b 00 00       	push   $0x4b18
    2d10:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    2d16:	e8 b5 0c 00 00       	call   39d0 <printf>
  oldbrk = sbrk(0);
    2d1b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2d22:	e8 d3 0b 00 00       	call   38fa <sbrk>
  a = sbrk(0);
    2d27:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  oldbrk = sbrk(0);
    2d2e:	89 c3                	mov    %eax,%ebx
  a = sbrk(0);
    2d30:	e8 c5 0b 00 00       	call   38fa <sbrk>
    2d35:	83 c4 10             	add    $0x10,%esp
    2d38:	89 c6                	mov    %eax,%esi
    2d3a:	eb 06                	jmp    2d42 <sbrktest+0x42>
    2d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    a = b + 1;
    2d40:	89 c6                	mov    %eax,%esi
    b = sbrk(1);
    2d42:	83 ec 0c             	sub    $0xc,%esp
    2d45:	6a 01                	push   $0x1
    2d47:	e8 ae 0b 00 00       	call   38fa <sbrk>
    if(b != a){
    2d4c:	83 c4 10             	add    $0x10,%esp
    2d4f:	39 f0                	cmp    %esi,%eax
    2d51:	0f 85 62 02 00 00    	jne    2fb9 <sbrktest+0x2b9>
  for(i = 0; i < 5000; i++){
    2d57:	83 c7 01             	add    $0x1,%edi
    *b = 1;
    2d5a:	c6 06 01             	movb   $0x1,(%esi)
    a = b + 1;
    2d5d:	8d 46 01             	lea    0x1(%esi),%eax
  for(i = 0; i < 5000; i++){
    2d60:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2d66:	75 d8                	jne    2d40 <sbrktest+0x40>
  pid = fork();
    2d68:	e8 fd 0a 00 00       	call   386a <fork>
  if(pid < 0){
    2d6d:	85 c0                	test   %eax,%eax
  pid = fork();
    2d6f:	89 c7                	mov    %eax,%edi
  if(pid < 0){
    2d71:	0f 88 82 03 00 00    	js     30f9 <sbrktest+0x3f9>
  c = sbrk(1);
    2d77:	83 ec 0c             	sub    $0xc,%esp
  if(c != a + 1){
    2d7a:	83 c6 02             	add    $0x2,%esi
  c = sbrk(1);
    2d7d:	6a 01                	push   $0x1
    2d7f:	e8 76 0b 00 00       	call   38fa <sbrk>
  c = sbrk(1);
    2d84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d8b:	e8 6a 0b 00 00       	call   38fa <sbrk>
  if(c != a + 1){
    2d90:	83 c4 10             	add    $0x10,%esp
    2d93:	39 f0                	cmp    %esi,%eax
    2d95:	0f 85 47 03 00 00    	jne    30e2 <sbrktest+0x3e2>
  if(pid == 0)
    2d9b:	85 ff                	test   %edi,%edi
    2d9d:	0f 84 3a 03 00 00    	je     30dd <sbrktest+0x3dd>
  wait();
    2da3:	e8 d2 0a 00 00       	call   387a <wait>
  a = sbrk(0);
    2da8:	83 ec 0c             	sub    $0xc,%esp
    2dab:	6a 00                	push   $0x0
    2dad:	e8 48 0b 00 00       	call   38fa <sbrk>
    2db2:	89 c6                	mov    %eax,%esi
  amt = (BIG) - (uint)a;
    2db4:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2db9:	29 f0                	sub    %esi,%eax
  p = sbrk(amt);
    2dbb:	89 04 24             	mov    %eax,(%esp)
    2dbe:	e8 37 0b 00 00       	call   38fa <sbrk>
  if (p != a) {
    2dc3:	83 c4 10             	add    $0x10,%esp
    2dc6:	39 c6                	cmp    %eax,%esi
    2dc8:	0f 85 f8 02 00 00    	jne    30c6 <sbrktest+0x3c6>
  a = sbrk(0);
    2dce:	83 ec 0c             	sub    $0xc,%esp
  *lastaddr = 99;
    2dd1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
  a = sbrk(0);
    2dd8:	6a 00                	push   $0x0
    2dda:	e8 1b 0b 00 00       	call   38fa <sbrk>
  c = sbrk(-4096);
    2ddf:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  a = sbrk(0);
    2de6:	89 c6                	mov    %eax,%esi
  c = sbrk(-4096);
    2de8:	e8 0d 0b 00 00       	call   38fa <sbrk>
  if(c == (char*)0xffffffff){
    2ded:	83 c4 10             	add    $0x10,%esp
    2df0:	83 f8 ff             	cmp    $0xffffffff,%eax
    2df3:	0f 84 b6 02 00 00    	je     30af <sbrktest+0x3af>
  c = sbrk(0);
    2df9:	83 ec 0c             	sub    $0xc,%esp
    2dfc:	6a 00                	push   $0x0
    2dfe:	e8 f7 0a 00 00       	call   38fa <sbrk>
  if(c != a - 4096){
    2e03:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2e09:	83 c4 10             	add    $0x10,%esp
    2e0c:	39 d0                	cmp    %edx,%eax
    2e0e:	0f 85 84 02 00 00    	jne    3098 <sbrktest+0x398>
  a = sbrk(0);
    2e14:	83 ec 0c             	sub    $0xc,%esp
    2e17:	6a 00                	push   $0x0
    2e19:	e8 dc 0a 00 00       	call   38fa <sbrk>
    2e1e:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    2e20:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2e27:	e8 ce 0a 00 00       	call   38fa <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    2e2c:	83 c4 10             	add    $0x10,%esp
    2e2f:	39 c6                	cmp    %eax,%esi
  c = sbrk(4096);
    2e31:	89 c7                	mov    %eax,%edi
  if(c != a || sbrk(0) != a + 4096){
    2e33:	0f 85 48 02 00 00    	jne    3081 <sbrktest+0x381>
    2e39:	83 ec 0c             	sub    $0xc,%esp
    2e3c:	6a 00                	push   $0x0
    2e3e:	e8 b7 0a 00 00       	call   38fa <sbrk>
    2e43:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2e49:	83 c4 10             	add    $0x10,%esp
    2e4c:	39 d0                	cmp    %edx,%eax
    2e4e:	0f 85 2d 02 00 00    	jne    3081 <sbrktest+0x381>
  if(*lastaddr == 99){
    2e54:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2e5b:	0f 84 09 02 00 00    	je     306a <sbrktest+0x36a>
  a = sbrk(0);
    2e61:	83 ec 0c             	sub    $0xc,%esp
    2e64:	6a 00                	push   $0x0
    2e66:	e8 8f 0a 00 00       	call   38fa <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    2e6b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  a = sbrk(0);
    2e72:	89 c6                	mov    %eax,%esi
  c = sbrk(-(sbrk(0) - oldbrk));
    2e74:	e8 81 0a 00 00       	call   38fa <sbrk>
    2e79:	89 d9                	mov    %ebx,%ecx
    2e7b:	29 c1                	sub    %eax,%ecx
    2e7d:	89 0c 24             	mov    %ecx,(%esp)
    2e80:	e8 75 0a 00 00       	call   38fa <sbrk>
  if(c != a){
    2e85:	83 c4 10             	add    $0x10,%esp
    2e88:	39 c6                	cmp    %eax,%esi
    2e8a:	0f 85 c3 01 00 00    	jne    3053 <sbrktest+0x353>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2e90:	be 00 00 00 80       	mov    $0x80000000,%esi
    ppid = getpid();
    2e95:	e8 58 0a 00 00       	call   38f2 <getpid>
    2e9a:	89 c7                	mov    %eax,%edi
    pid = fork();
    2e9c:	e8 c9 09 00 00       	call   386a <fork>
    if(pid < 0){
    2ea1:	85 c0                	test   %eax,%eax
    2ea3:	0f 88 93 01 00 00    	js     303c <sbrktest+0x33c>
    if(pid == 0){
    2ea9:	0f 84 6b 01 00 00    	je     301a <sbrktest+0x31a>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eaf:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    wait();
    2eb5:	e8 c0 09 00 00       	call   387a <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2eba:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2ec0:	75 d3                	jne    2e95 <sbrktest+0x195>
  if(pipe(fds) != 0){
    2ec2:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2ec5:	83 ec 0c             	sub    $0xc,%esp
    2ec8:	50                   	push   %eax
    2ec9:	e8 b4 09 00 00       	call   3882 <pipe>
    2ece:	83 c4 10             	add    $0x10,%esp
    2ed1:	85 c0                	test   %eax,%eax
    2ed3:	0f 85 2e 01 00 00    	jne    3007 <sbrktest+0x307>
    2ed9:	8d 7d c0             	lea    -0x40(%ebp),%edi
    2edc:	89 fe                	mov    %edi,%esi
    2ede:	eb 23                	jmp    2f03 <sbrktest+0x203>
    if(pids[i] != -1)
    2ee0:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ee3:	74 14                	je     2ef9 <sbrktest+0x1f9>
      read(fds[0], &scratch, 1);
    2ee5:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2ee8:	83 ec 04             	sub    $0x4,%esp
    2eeb:	6a 01                	push   $0x1
    2eed:	50                   	push   %eax
    2eee:	ff 75 b8             	pushl  -0x48(%ebp)
    2ef1:	e8 94 09 00 00       	call   388a <read>
    2ef6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2ef9:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2efc:	83 c6 04             	add    $0x4,%esi
    2eff:	39 c6                	cmp    %eax,%esi
    2f01:	74 4f                	je     2f52 <sbrktest+0x252>
    if((pids[i] = fork()) == 0){
    2f03:	e8 62 09 00 00       	call   386a <fork>
    2f08:	85 c0                	test   %eax,%eax
    2f0a:	89 06                	mov    %eax,(%esi)
    2f0c:	75 d2                	jne    2ee0 <sbrktest+0x1e0>
      sbrk(BIG - (uint)sbrk(0));
    2f0e:	83 ec 0c             	sub    $0xc,%esp
    2f11:	6a 00                	push   $0x0
    2f13:	e8 e2 09 00 00       	call   38fa <sbrk>
    2f18:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f1d:	29 c2                	sub    %eax,%edx
    2f1f:	89 14 24             	mov    %edx,(%esp)
    2f22:	e8 d3 09 00 00       	call   38fa <sbrk>
      write(fds[1], "x", 1);
    2f27:	83 c4 0c             	add    $0xc,%esp
    2f2a:	6a 01                	push   $0x1
    2f2c:	68 81 46 00 00       	push   $0x4681
    2f31:	ff 75 bc             	pushl  -0x44(%ebp)
    2f34:	e8 59 09 00 00       	call   3892 <write>
    2f39:	83 c4 10             	add    $0x10,%esp
    2f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(;;) sleep(1000);
    2f40:	83 ec 0c             	sub    $0xc,%esp
    2f43:	68 e8 03 00 00       	push   $0x3e8
    2f48:	e8 b5 09 00 00       	call   3902 <sleep>
    2f4d:	83 c4 10             	add    $0x10,%esp
    2f50:	eb ee                	jmp    2f40 <sbrktest+0x240>
  c = sbrk(4096);
    2f52:	83 ec 0c             	sub    $0xc,%esp
    2f55:	68 00 10 00 00       	push   $0x1000
    2f5a:	e8 9b 09 00 00       	call   38fa <sbrk>
    2f5f:	83 c4 10             	add    $0x10,%esp
    2f62:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    if(pids[i] == -1)
    2f65:	8b 07                	mov    (%edi),%eax
    2f67:	83 f8 ff             	cmp    $0xffffffff,%eax
    2f6a:	74 11                	je     2f7d <sbrktest+0x27d>
    kill(pids[i]);
    2f6c:	83 ec 0c             	sub    $0xc,%esp
    2f6f:	50                   	push   %eax
    2f70:	e8 2d 09 00 00       	call   38a2 <kill>
    wait();
    2f75:	e8 00 09 00 00       	call   387a <wait>
    2f7a:	83 c4 10             	add    $0x10,%esp
    2f7d:	83 c7 04             	add    $0x4,%edi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    2f80:	39 fe                	cmp    %edi,%esi
    2f82:	75 e1                	jne    2f65 <sbrktest+0x265>
  if(c == (char*)0xffffffff){
    2f84:	83 7d a4 ff          	cmpl   $0xffffffff,-0x5c(%ebp)
    2f88:	74 66                	je     2ff0 <sbrktest+0x2f0>
  if(sbrk(0) > oldbrk)
    2f8a:	83 ec 0c             	sub    $0xc,%esp
    2f8d:	6a 00                	push   $0x0
    2f8f:	e8 66 09 00 00       	call   38fa <sbrk>
    2f94:	83 c4 10             	add    $0x10,%esp
    2f97:	39 d8                	cmp    %ebx,%eax
    2f99:	77 3c                	ja     2fd7 <sbrktest+0x2d7>
  printf(stdout, "sbrk test OK\n");
    2f9b:	83 ec 08             	sub    $0x8,%esp
    2f9e:	68 c0 4b 00 00       	push   $0x4bc0
    2fa3:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    2fa9:	e8 22 0a 00 00       	call   39d0 <printf>
}
    2fae:	83 c4 10             	add    $0x10,%esp
    2fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
    2fb4:	5b                   	pop    %ebx
    2fb5:	5e                   	pop    %esi
    2fb6:	5f                   	pop    %edi
    2fb7:	5d                   	pop    %ebp
    2fb8:	c3                   	ret    
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2fb9:	83 ec 0c             	sub    $0xc,%esp
    2fbc:	50                   	push   %eax
    2fbd:	56                   	push   %esi
    2fbe:	57                   	push   %edi
    2fbf:	68 23 4b 00 00       	push   $0x4b23
    2fc4:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    2fca:	e8 01 0a 00 00       	call   39d0 <printf>
      exit();
    2fcf:	83 c4 20             	add    $0x20,%esp
    2fd2:	e8 9b 08 00 00       	call   3872 <exit>
    sbrk(-(sbrk(0) - oldbrk));
    2fd7:	83 ec 0c             	sub    $0xc,%esp
    2fda:	6a 00                	push   $0x0
    2fdc:	e8 19 09 00 00       	call   38fa <sbrk>
    2fe1:	29 c3                	sub    %eax,%ebx
    2fe3:	89 1c 24             	mov    %ebx,(%esp)
    2fe6:	e8 0f 09 00 00       	call   38fa <sbrk>
    2feb:	83 c4 10             	add    $0x10,%esp
    2fee:	eb ab                	jmp    2f9b <sbrktest+0x29b>
    printf(stdout, "failed sbrk leaked memory\n");
    2ff0:	50                   	push   %eax
    2ff1:	50                   	push   %eax
    2ff2:	68 a5 4b 00 00       	push   $0x4ba5
    2ff7:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    2ffd:	e8 ce 09 00 00       	call   39d0 <printf>
    exit();
    3002:	e8 6b 08 00 00       	call   3872 <exit>
    printf(1, "pipe() failed\n");
    3007:	52                   	push   %edx
    3008:	52                   	push   %edx
    3009:	68 61 40 00 00       	push   $0x4061
    300e:	6a 01                	push   $0x1
    3010:	e8 bb 09 00 00       	call   39d0 <printf>
    exit();
    3015:	e8 58 08 00 00       	call   3872 <exit>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    301a:	0f be 06             	movsbl (%esi),%eax
    301d:	50                   	push   %eax
    301e:	56                   	push   %esi
    301f:	68 8c 4b 00 00       	push   $0x4b8c
    3024:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    302a:	e8 a1 09 00 00       	call   39d0 <printf>
      kill(ppid);
    302f:	89 3c 24             	mov    %edi,(%esp)
    3032:	e8 6b 08 00 00       	call   38a2 <kill>
      exit();
    3037:	e8 36 08 00 00       	call   3872 <exit>
      printf(stdout, "fork failed\n");
    303c:	51                   	push   %ecx
    303d:	51                   	push   %ecx
    303e:	68 69 4c 00 00       	push   $0x4c69
    3043:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3049:	e8 82 09 00 00       	call   39d0 <printf>
      exit();
    304e:	e8 1f 08 00 00       	call   3872 <exit>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3053:	50                   	push   %eax
    3054:	56                   	push   %esi
    3055:	68 6c 53 00 00       	push   $0x536c
    305a:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3060:	e8 6b 09 00 00       	call   39d0 <printf>
    exit();
    3065:	e8 08 08 00 00       	call   3872 <exit>
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    306a:	53                   	push   %ebx
    306b:	53                   	push   %ebx
    306c:	68 3c 53 00 00       	push   $0x533c
    3071:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3077:	e8 54 09 00 00       	call   39d0 <printf>
    exit();
    307c:	e8 f1 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3081:	57                   	push   %edi
    3082:	56                   	push   %esi
    3083:	68 14 53 00 00       	push   $0x5314
    3088:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    308e:	e8 3d 09 00 00       	call   39d0 <printf>
    exit();
    3093:	e8 da 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3098:	50                   	push   %eax
    3099:	56                   	push   %esi
    309a:	68 dc 52 00 00       	push   $0x52dc
    309f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    30a5:	e8 26 09 00 00       	call   39d0 <printf>
    exit();
    30aa:	e8 c3 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    30af:	56                   	push   %esi
    30b0:	56                   	push   %esi
    30b1:	68 71 4b 00 00       	push   $0x4b71
    30b6:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    30bc:	e8 0f 09 00 00       	call   39d0 <printf>
    exit();
    30c1:	e8 ac 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    30c6:	57                   	push   %edi
    30c7:	57                   	push   %edi
    30c8:	68 9c 52 00 00       	push   $0x529c
    30cd:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    30d3:	e8 f8 08 00 00       	call   39d0 <printf>
    exit();
    30d8:	e8 95 07 00 00       	call   3872 <exit>
    exit();
    30dd:	e8 90 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk test failed post-fork\n");
    30e2:	50                   	push   %eax
    30e3:	50                   	push   %eax
    30e4:	68 55 4b 00 00       	push   $0x4b55
    30e9:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    30ef:	e8 dc 08 00 00       	call   39d0 <printf>
    exit();
    30f4:	e8 79 07 00 00       	call   3872 <exit>
    printf(stdout, "sbrk test fork failed\n");
    30f9:	50                   	push   %eax
    30fa:	50                   	push   %eax
    30fb:	68 3e 4b 00 00       	push   $0x4b3e
    3100:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3106:	e8 c5 08 00 00       	call   39d0 <printf>
    exit();
    310b:	e8 62 07 00 00       	call   3872 <exit>

00003110 <validateint>:
{
    3110:	55                   	push   %ebp
    3111:	89 e5                	mov    %esp,%ebp
}
    3113:	5d                   	pop    %ebp
    3114:	c3                   	ret    
    3115:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003120 <validatetest>:
{
    3120:	55                   	push   %ebp
    3121:	89 e5                	mov    %esp,%ebp
    3123:	56                   	push   %esi
    3124:	53                   	push   %ebx
  for(p = 0; p <= (uint)hi; p += 4096){
    3125:	31 db                	xor    %ebx,%ebx
  printf(stdout, "validate test\n");
    3127:	83 ec 08             	sub    $0x8,%esp
    312a:	68 ce 4b 00 00       	push   $0x4bce
    312f:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3135:	e8 96 08 00 00       	call   39d0 <printf>
    313a:	83 c4 10             	add    $0x10,%esp
    313d:	8d 76 00             	lea    0x0(%esi),%esi
    if((pid = fork()) == 0){
    3140:	e8 25 07 00 00       	call   386a <fork>
    3145:	85 c0                	test   %eax,%eax
    3147:	89 c6                	mov    %eax,%esi
    3149:	74 63                	je     31ae <validatetest+0x8e>
    sleep(0);
    314b:	83 ec 0c             	sub    $0xc,%esp
    314e:	6a 00                	push   $0x0
    3150:	e8 ad 07 00 00       	call   3902 <sleep>
    sleep(0);
    3155:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    315c:	e8 a1 07 00 00       	call   3902 <sleep>
    kill(pid);
    3161:	89 34 24             	mov    %esi,(%esp)
    3164:	e8 39 07 00 00       	call   38a2 <kill>
    wait();
    3169:	e8 0c 07 00 00       	call   387a <wait>
    if(link("nosuchfile", (char*)p) != -1){
    316e:	58                   	pop    %eax
    316f:	5a                   	pop    %edx
    3170:	53                   	push   %ebx
    3171:	68 dd 4b 00 00       	push   $0x4bdd
    3176:	e8 57 07 00 00       	call   38d2 <link>
    317b:	83 c4 10             	add    $0x10,%esp
    317e:	83 f8 ff             	cmp    $0xffffffff,%eax
    3181:	75 30                	jne    31b3 <validatetest+0x93>
  for(p = 0; p <= (uint)hi; p += 4096){
    3183:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3189:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    318f:	75 af                	jne    3140 <validatetest+0x20>
  printf(stdout, "validate ok\n");
    3191:	83 ec 08             	sub    $0x8,%esp
    3194:	68 01 4c 00 00       	push   $0x4c01
    3199:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    319f:	e8 2c 08 00 00       	call   39d0 <printf>
}
    31a4:	83 c4 10             	add    $0x10,%esp
    31a7:	8d 65 f8             	lea    -0x8(%ebp),%esp
    31aa:	5b                   	pop    %ebx
    31ab:	5e                   	pop    %esi
    31ac:	5d                   	pop    %ebp
    31ad:	c3                   	ret    
      exit();
    31ae:	e8 bf 06 00 00       	call   3872 <exit>
      printf(stdout, "link should not succeed\n");
    31b3:	83 ec 08             	sub    $0x8,%esp
    31b6:	68 e8 4b 00 00       	push   $0x4be8
    31bb:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    31c1:	e8 0a 08 00 00       	call   39d0 <printf>
      exit();
    31c6:	e8 a7 06 00 00       	call   3872 <exit>
    31cb:	90                   	nop
    31cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000031d0 <bsstest>:
{
    31d0:	55                   	push   %ebp
    31d1:	89 e5                	mov    %esp,%ebp
    31d3:	83 ec 10             	sub    $0x10,%esp
  printf(stdout, "bss test\n");
    31d6:	68 0e 4c 00 00       	push   $0x4c0e
    31db:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    31e1:	e8 ea 07 00 00       	call   39d0 <printf>
    if(uninit[i] != '\0'){
    31e6:	83 c4 10             	add    $0x10,%esp
    31e9:	80 3d a0 5e 00 00 00 	cmpb   $0x0,0x5ea0
    31f0:	75 39                	jne    322b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    31f2:	b8 01 00 00 00       	mov    $0x1,%eax
    31f7:	89 f6                	mov    %esi,%esi
    31f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(uninit[i] != '\0'){
    3200:	80 b8 a0 5e 00 00 00 	cmpb   $0x0,0x5ea0(%eax)
    3207:	75 22                	jne    322b <bsstest+0x5b>
  for(i = 0; i < sizeof(uninit); i++){
    3209:	83 c0 01             	add    $0x1,%eax
    320c:	3d 10 27 00 00       	cmp    $0x2710,%eax
    3211:	75 ed                	jne    3200 <bsstest+0x30>
  printf(stdout, "bss test ok\n");
    3213:	83 ec 08             	sub    $0x8,%esp
    3216:	68 29 4c 00 00       	push   $0x4c29
    321b:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3221:	e8 aa 07 00 00       	call   39d0 <printf>
}
    3226:	83 c4 10             	add    $0x10,%esp
    3229:	c9                   	leave  
    322a:	c3                   	ret    
      printf(stdout, "bss test failed\n");
    322b:	83 ec 08             	sub    $0x8,%esp
    322e:	68 18 4c 00 00       	push   $0x4c18
    3233:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3239:	e8 92 07 00 00       	call   39d0 <printf>
      exit();
    323e:	e8 2f 06 00 00       	call   3872 <exit>
    3243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003250 <bigargtest>:
{
    3250:	55                   	push   %ebp
    3251:	89 e5                	mov    %esp,%ebp
    3253:	83 ec 14             	sub    $0x14,%esp
  unlink("bigarg-ok");
    3256:	68 36 4c 00 00       	push   $0x4c36
    325b:	e8 62 06 00 00       	call   38c2 <unlink>
  pid = fork();
    3260:	e8 05 06 00 00       	call   386a <fork>
  if(pid == 0){
    3265:	83 c4 10             	add    $0x10,%esp
    3268:	85 c0                	test   %eax,%eax
    326a:	74 3f                	je     32ab <bigargtest+0x5b>
  } else if(pid < 0){
    326c:	0f 88 c2 00 00 00    	js     3334 <bigargtest+0xe4>
  wait();
    3272:	e8 03 06 00 00       	call   387a <wait>
  fd = open("bigarg-ok", 0);
    3277:	83 ec 08             	sub    $0x8,%esp
    327a:	6a 00                	push   $0x0
    327c:	68 36 4c 00 00       	push   $0x4c36
    3281:	e8 2c 06 00 00       	call   38b2 <open>
  if(fd < 0){
    3286:	83 c4 10             	add    $0x10,%esp
    3289:	85 c0                	test   %eax,%eax
    328b:	0f 88 8c 00 00 00    	js     331d <bigargtest+0xcd>
  close(fd);
    3291:	83 ec 0c             	sub    $0xc,%esp
    3294:	50                   	push   %eax
    3295:	e8 00 06 00 00       	call   389a <close>
  unlink("bigarg-ok");
    329a:	c7 04 24 36 4c 00 00 	movl   $0x4c36,(%esp)
    32a1:	e8 1c 06 00 00       	call   38c2 <unlink>
}
    32a6:	83 c4 10             	add    $0x10,%esp
    32a9:	c9                   	leave  
    32aa:	c3                   	ret    
    32ab:	b8 00 5e 00 00       	mov    $0x5e00,%eax
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    32b0:	c7 00 90 53 00 00    	movl   $0x5390,(%eax)
    32b6:	83 c0 04             	add    $0x4,%eax
    for(i = 0; i < MAXARG-1; i++)
    32b9:	3d 7c 5e 00 00       	cmp    $0x5e7c,%eax
    32be:	75 f0                	jne    32b0 <bigargtest+0x60>
    printf(stdout, "bigarg test\n");
    32c0:	51                   	push   %ecx
    32c1:	51                   	push   %ecx
    32c2:	68 40 4c 00 00       	push   $0x4c40
    32c7:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    args[MAXARG-1] = 0;
    32cd:	c7 05 7c 5e 00 00 00 	movl   $0x0,0x5e7c
    32d4:	00 00 00 
    printf(stdout, "bigarg test\n");
    32d7:	e8 f4 06 00 00       	call   39d0 <printf>
    exec("echo", args);
    32dc:	58                   	pop    %eax
    32dd:	5a                   	pop    %edx
    32de:	68 00 5e 00 00       	push   $0x5e00
    32e3:	68 0d 3e 00 00       	push   $0x3e0d
    32e8:	e8 bd 05 00 00       	call   38aa <exec>
    printf(stdout, "bigarg test ok\n");
    32ed:	59                   	pop    %ecx
    32ee:	58                   	pop    %eax
    32ef:	68 4d 4c 00 00       	push   $0x4c4d
    32f4:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    32fa:	e8 d1 06 00 00       	call   39d0 <printf>
    fd = open("bigarg-ok", O_CREATE);
    32ff:	58                   	pop    %eax
    3300:	5a                   	pop    %edx
    3301:	68 00 02 00 00       	push   $0x200
    3306:	68 36 4c 00 00       	push   $0x4c36
    330b:	e8 a2 05 00 00       	call   38b2 <open>
    close(fd);
    3310:	89 04 24             	mov    %eax,(%esp)
    3313:	e8 82 05 00 00       	call   389a <close>
    exit();
    3318:	e8 55 05 00 00       	call   3872 <exit>
    printf(stdout, "bigarg test failed!\n");
    331d:	50                   	push   %eax
    331e:	50                   	push   %eax
    331f:	68 76 4c 00 00       	push   $0x4c76
    3324:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    332a:	e8 a1 06 00 00       	call   39d0 <printf>
    exit();
    332f:	e8 3e 05 00 00       	call   3872 <exit>
    printf(stdout, "bigargtest: fork failed\n");
    3334:	52                   	push   %edx
    3335:	52                   	push   %edx
    3336:	68 5d 4c 00 00       	push   $0x4c5d
    333b:	ff 35 d8 5d 00 00    	pushl  0x5dd8
    3341:	e8 8a 06 00 00       	call   39d0 <printf>
    exit();
    3346:	e8 27 05 00 00       	call   3872 <exit>
    334b:	90                   	nop
    334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003350 <fsfull>:
{
    3350:	55                   	push   %ebp
    3351:	89 e5                	mov    %esp,%ebp
    3353:	57                   	push   %edi
    3354:	56                   	push   %esi
    3355:	53                   	push   %ebx
  for(nfiles = 0; ; nfiles++){
    3356:	31 db                	xor    %ebx,%ebx
{
    3358:	83 ec 54             	sub    $0x54,%esp
  printf(1, "fsfull test\n");
    335b:	68 8b 4c 00 00       	push   $0x4c8b
    3360:	6a 01                	push   $0x1
    3362:	e8 69 06 00 00       	call   39d0 <printf>
    3367:	83 c4 10             	add    $0x10,%esp
    336a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    name[1] = '0' + nfiles / 1000;
    3370:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3375:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    printf(1, "writing %s\n", name);
    337a:	83 ec 04             	sub    $0x4,%esp
    name[1] = '0' + nfiles / 1000;
    337d:	f7 e3                	mul    %ebx
    name[0] = 'f';
    337f:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3383:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3387:	c1 ea 06             	shr    $0x6,%edx
    338a:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    338d:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    3393:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3396:	89 d8                	mov    %ebx,%eax
    3398:	29 d0                	sub    %edx,%eax
    339a:	89 c2                	mov    %eax,%edx
    339c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    33a1:	f7 e2                	mul    %edx
    name[3] = '0' + (nfiles % 100) / 10;
    33a3:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    33a8:	c1 ea 05             	shr    $0x5,%edx
    33ab:	83 c2 30             	add    $0x30,%edx
    33ae:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    33b1:	f7 e3                	mul    %ebx
    33b3:	89 d8                	mov    %ebx,%eax
    33b5:	c1 ea 05             	shr    $0x5,%edx
    33b8:	6b d2 64             	imul   $0x64,%edx,%edx
    33bb:	29 d0                	sub    %edx,%eax
    33bd:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    33bf:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    33c1:	c1 ea 03             	shr    $0x3,%edx
    33c4:	83 c2 30             	add    $0x30,%edx
    33c7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    33ca:	f7 e1                	mul    %ecx
    33cc:	89 d9                	mov    %ebx,%ecx
    33ce:	c1 ea 03             	shr    $0x3,%edx
    33d1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    33d4:	01 c0                	add    %eax,%eax
    33d6:	29 c1                	sub    %eax,%ecx
    33d8:	89 c8                	mov    %ecx,%eax
    33da:	83 c0 30             	add    $0x30,%eax
    33dd:	88 45 ac             	mov    %al,-0x54(%ebp)
    printf(1, "writing %s\n", name);
    33e0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    33e3:	50                   	push   %eax
    33e4:	68 98 4c 00 00       	push   $0x4c98
    33e9:	6a 01                	push   $0x1
    33eb:	e8 e0 05 00 00       	call   39d0 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    33f0:	58                   	pop    %eax
    33f1:	8d 45 a8             	lea    -0x58(%ebp),%eax
    33f4:	5a                   	pop    %edx
    33f5:	68 02 02 00 00       	push   $0x202
    33fa:	50                   	push   %eax
    33fb:	e8 b2 04 00 00       	call   38b2 <open>
    if(fd < 0){
    3400:	83 c4 10             	add    $0x10,%esp
    3403:	85 c0                	test   %eax,%eax
    int fd = open(name, O_CREATE|O_RDWR);
    3405:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3407:	78 57                	js     3460 <fsfull+0x110>
    int total = 0;
    3409:	31 f6                	xor    %esi,%esi
    340b:	eb 05                	jmp    3412 <fsfull+0xc2>
    340d:	8d 76 00             	lea    0x0(%esi),%esi
      total += cc;
    3410:	01 c6                	add    %eax,%esi
      int cc = write(fd, buf, 512);
    3412:	83 ec 04             	sub    $0x4,%esp
    3415:	68 00 02 00 00       	push   $0x200
    341a:	68 c0 85 00 00       	push   $0x85c0
    341f:	57                   	push   %edi
    3420:	e8 6d 04 00 00       	call   3892 <write>
      if(cc < 512)
    3425:	83 c4 10             	add    $0x10,%esp
    3428:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    342d:	7f e1                	jg     3410 <fsfull+0xc0>
    printf(1, "wrote %d bytes\n", total);
    342f:	83 ec 04             	sub    $0x4,%esp
    3432:	56                   	push   %esi
    3433:	68 b4 4c 00 00       	push   $0x4cb4
    3438:	6a 01                	push   $0x1
    343a:	e8 91 05 00 00       	call   39d0 <printf>
    close(fd);
    343f:	89 3c 24             	mov    %edi,(%esp)
    3442:	e8 53 04 00 00       	call   389a <close>
    if(total == 0)
    3447:	83 c4 10             	add    $0x10,%esp
    344a:	85 f6                	test   %esi,%esi
    344c:	74 28                	je     3476 <fsfull+0x126>
  for(nfiles = 0; ; nfiles++){
    344e:	83 c3 01             	add    $0x1,%ebx
    3451:	e9 1a ff ff ff       	jmp    3370 <fsfull+0x20>
    3456:	8d 76 00             	lea    0x0(%esi),%esi
    3459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      printf(1, "open %s failed\n", name);
    3460:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3463:	83 ec 04             	sub    $0x4,%esp
    3466:	50                   	push   %eax
    3467:	68 a4 4c 00 00       	push   $0x4ca4
    346c:	6a 01                	push   $0x1
    346e:	e8 5d 05 00 00       	call   39d0 <printf>
      break;
    3473:	83 c4 10             	add    $0x10,%esp
    name[1] = '0' + nfiles / 1000;
    3476:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    name[2] = '0' + (nfiles % 1000) / 100;
    347b:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    name[1] = '0' + nfiles / 1000;
    3480:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    3482:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    unlink(name);
    3487:	83 ec 0c             	sub    $0xc,%esp
    name[1] = '0' + nfiles / 1000;
    348a:	f7 e7                	mul    %edi
    name[0] = 'f';
    348c:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[5] = '\0';
    3490:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    name[1] = '0' + nfiles / 1000;
    3494:	c1 ea 06             	shr    $0x6,%edx
    3497:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    349a:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    name[1] = '0' + nfiles / 1000;
    34a0:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    34a3:	89 d8                	mov    %ebx,%eax
    34a5:	29 d0                	sub    %edx,%eax
    34a7:	f7 e6                	mul    %esi
    name[3] = '0' + (nfiles % 100) / 10;
    34a9:	89 d8                	mov    %ebx,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    34ab:	c1 ea 05             	shr    $0x5,%edx
    34ae:	83 c2 30             	add    $0x30,%edx
    34b1:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    34b4:	f7 e6                	mul    %esi
    34b6:	89 d8                	mov    %ebx,%eax
    34b8:	c1 ea 05             	shr    $0x5,%edx
    34bb:	6b d2 64             	imul   $0x64,%edx,%edx
    34be:	29 d0                	sub    %edx,%eax
    34c0:	f7 e1                	mul    %ecx
    name[4] = '0' + (nfiles % 10);
    34c2:	89 d8                	mov    %ebx,%eax
    name[3] = '0' + (nfiles % 100) / 10;
    34c4:	c1 ea 03             	shr    $0x3,%edx
    34c7:	83 c2 30             	add    $0x30,%edx
    34ca:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    34cd:	f7 e1                	mul    %ecx
    34cf:	89 d9                	mov    %ebx,%ecx
    nfiles--;
    34d1:	83 eb 01             	sub    $0x1,%ebx
    name[4] = '0' + (nfiles % 10);
    34d4:	c1 ea 03             	shr    $0x3,%edx
    34d7:	8d 04 92             	lea    (%edx,%edx,4),%eax
    34da:	01 c0                	add    %eax,%eax
    34dc:	29 c1                	sub    %eax,%ecx
    34de:	89 c8                	mov    %ecx,%eax
    34e0:	83 c0 30             	add    $0x30,%eax
    34e3:	88 45 ac             	mov    %al,-0x54(%ebp)
    unlink(name);
    34e6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34e9:	50                   	push   %eax
    34ea:	e8 d3 03 00 00       	call   38c2 <unlink>
  while(nfiles >= 0){
    34ef:	83 c4 10             	add    $0x10,%esp
    34f2:	83 fb ff             	cmp    $0xffffffff,%ebx
    34f5:	75 89                	jne    3480 <fsfull+0x130>
  printf(1, "fsfull test finished\n");
    34f7:	83 ec 08             	sub    $0x8,%esp
    34fa:	68 c4 4c 00 00       	push   $0x4cc4
    34ff:	6a 01                	push   $0x1
    3501:	e8 ca 04 00 00       	call   39d0 <printf>
}
    3506:	83 c4 10             	add    $0x10,%esp
    3509:	8d 65 f4             	lea    -0xc(%ebp),%esp
    350c:	5b                   	pop    %ebx
    350d:	5e                   	pop    %esi
    350e:	5f                   	pop    %edi
    350f:	5d                   	pop    %ebp
    3510:	c3                   	ret    
    3511:	eb 0d                	jmp    3520 <uio>
    3513:	90                   	nop
    3514:	90                   	nop
    3515:	90                   	nop
    3516:	90                   	nop
    3517:	90                   	nop
    3518:	90                   	nop
    3519:	90                   	nop
    351a:	90                   	nop
    351b:	90                   	nop
    351c:	90                   	nop
    351d:	90                   	nop
    351e:	90                   	nop
    351f:	90                   	nop

00003520 <uio>:
{
    3520:	55                   	push   %ebp
    3521:	89 e5                	mov    %esp,%ebp
    3523:	83 ec 10             	sub    $0x10,%esp
  printf(1, "uio test\n");
    3526:	68 da 4c 00 00       	push   $0x4cda
    352b:	6a 01                	push   $0x1
    352d:	e8 9e 04 00 00       	call   39d0 <printf>
  pid = fork();
    3532:	e8 33 03 00 00       	call   386a <fork>
  if(pid == 0){
    3537:	83 c4 10             	add    $0x10,%esp
    353a:	85 c0                	test   %eax,%eax
    353c:	74 1b                	je     3559 <uio+0x39>
  } else if(pid < 0){
    353e:	78 3d                	js     357d <uio+0x5d>
  wait();
    3540:	e8 35 03 00 00       	call   387a <wait>
  printf(1, "uio test done\n");
    3545:	83 ec 08             	sub    $0x8,%esp
    3548:	68 e4 4c 00 00       	push   $0x4ce4
    354d:	6a 01                	push   $0x1
    354f:	e8 7c 04 00 00       	call   39d0 <printf>
}
    3554:	83 c4 10             	add    $0x10,%esp
    3557:	c9                   	leave  
    3558:	c3                   	ret    
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3559:	b8 09 00 00 00       	mov    $0x9,%eax
    355e:	ba 70 00 00 00       	mov    $0x70,%edx
    3563:	ee                   	out    %al,(%dx)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3564:	ba 71 00 00 00       	mov    $0x71,%edx
    3569:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    356a:	52                   	push   %edx
    356b:	52                   	push   %edx
    356c:	68 70 54 00 00       	push   $0x5470
    3571:	6a 01                	push   $0x1
    3573:	e8 58 04 00 00       	call   39d0 <printf>
    exit();
    3578:	e8 f5 02 00 00       	call   3872 <exit>
    printf (1, "fork failed\n");
    357d:	50                   	push   %eax
    357e:	50                   	push   %eax
    357f:	68 69 4c 00 00       	push   $0x4c69
    3584:	6a 01                	push   $0x1
    3586:	e8 45 04 00 00       	call   39d0 <printf>
    exit();
    358b:	e8 e2 02 00 00       	call   3872 <exit>

00003590 <argptest>:
{
    3590:	55                   	push   %ebp
    3591:	89 e5                	mov    %esp,%ebp
    3593:	53                   	push   %ebx
    3594:	83 ec 0c             	sub    $0xc,%esp
  fd = open("init", O_RDONLY);
    3597:	6a 00                	push   $0x0
    3599:	68 f3 4c 00 00       	push   $0x4cf3
    359e:	e8 0f 03 00 00       	call   38b2 <open>
  if (fd < 0) {
    35a3:	83 c4 10             	add    $0x10,%esp
    35a6:	85 c0                	test   %eax,%eax
    35a8:	78 39                	js     35e3 <argptest+0x53>
  read(fd, sbrk(0) - 1, -1);
    35aa:	83 ec 0c             	sub    $0xc,%esp
    35ad:	89 c3                	mov    %eax,%ebx
    35af:	6a 00                	push   $0x0
    35b1:	e8 44 03 00 00       	call   38fa <sbrk>
    35b6:	83 c4 0c             	add    $0xc,%esp
    35b9:	83 e8 01             	sub    $0x1,%eax
    35bc:	6a ff                	push   $0xffffffff
    35be:	50                   	push   %eax
    35bf:	53                   	push   %ebx
    35c0:	e8 c5 02 00 00       	call   388a <read>
  close(fd);
    35c5:	89 1c 24             	mov    %ebx,(%esp)
    35c8:	e8 cd 02 00 00       	call   389a <close>
  printf(1, "arg test passed\n");
    35cd:	58                   	pop    %eax
    35ce:	5a                   	pop    %edx
    35cf:	68 05 4d 00 00       	push   $0x4d05
    35d4:	6a 01                	push   $0x1
    35d6:	e8 f5 03 00 00       	call   39d0 <printf>
}
    35db:	83 c4 10             	add    $0x10,%esp
    35de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    35e1:	c9                   	leave  
    35e2:	c3                   	ret    
    printf(2, "open failed\n");
    35e3:	51                   	push   %ecx
    35e4:	51                   	push   %ecx
    35e5:	68 f8 4c 00 00       	push   $0x4cf8
    35ea:	6a 02                	push   $0x2
    35ec:	e8 df 03 00 00       	call   39d0 <printf>
    exit();
    35f1:	e8 7c 02 00 00       	call   3872 <exit>
    35f6:	8d 76 00             	lea    0x0(%esi),%esi
    35f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003600 <rand>:
  randstate = randstate * 1664525 + 1013904223;
    3600:	69 05 d4 5d 00 00 0d 	imul   $0x19660d,0x5dd4,%eax
    3607:	66 19 00 
{
    360a:	55                   	push   %ebp
    360b:	89 e5                	mov    %esp,%ebp
}
    360d:	5d                   	pop    %ebp
  randstate = randstate * 1664525 + 1013904223;
    360e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3613:	a3 d4 5d 00 00       	mov    %eax,0x5dd4
}
    3618:	c3                   	ret    
    3619:	66 90                	xchg   %ax,%ax
    361b:	66 90                	xchg   %ax,%ax
    361d:	66 90                	xchg   %ax,%ax
    361f:	90                   	nop

00003620 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3620:	55                   	push   %ebp
    3621:	89 e5                	mov    %esp,%ebp
    3623:	53                   	push   %ebx
    3624:	8b 45 08             	mov    0x8(%ebp),%eax
    3627:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    362a:	89 c2                	mov    %eax,%edx
    362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3630:	83 c1 01             	add    $0x1,%ecx
    3633:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    3637:	83 c2 01             	add    $0x1,%edx
    363a:	84 db                	test   %bl,%bl
    363c:	88 5a ff             	mov    %bl,-0x1(%edx)
    363f:	75 ef                	jne    3630 <strcpy+0x10>
    ;
  return os;
}
    3641:	5b                   	pop    %ebx
    3642:	5d                   	pop    %ebp
    3643:	c3                   	ret    
    3644:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    364a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003650 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3650:	55                   	push   %ebp
    3651:	89 e5                	mov    %esp,%ebp
    3653:	53                   	push   %ebx
    3654:	8b 55 08             	mov    0x8(%ebp),%edx
    3657:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    365a:	0f b6 02             	movzbl (%edx),%eax
    365d:	0f b6 19             	movzbl (%ecx),%ebx
    3660:	84 c0                	test   %al,%al
    3662:	75 1c                	jne    3680 <strcmp+0x30>
    3664:	eb 2a                	jmp    3690 <strcmp+0x40>
    3666:	8d 76 00             	lea    0x0(%esi),%esi
    3669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    3670:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    3673:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    3676:	83 c1 01             	add    $0x1,%ecx
    3679:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    367c:	84 c0                	test   %al,%al
    367e:	74 10                	je     3690 <strcmp+0x40>
    3680:	38 d8                	cmp    %bl,%al
    3682:	74 ec                	je     3670 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    3684:	29 d8                	sub    %ebx,%eax
}
    3686:	5b                   	pop    %ebx
    3687:	5d                   	pop    %ebp
    3688:	c3                   	ret    
    3689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3690:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    3692:	29 d8                	sub    %ebx,%eax
}
    3694:	5b                   	pop    %ebx
    3695:	5d                   	pop    %ebp
    3696:	c3                   	ret    
    3697:	89 f6                	mov    %esi,%esi
    3699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036a0 <strlen>:

uint
strlen(const char *s)
{
    36a0:	55                   	push   %ebp
    36a1:	89 e5                	mov    %esp,%ebp
    36a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    36a6:	80 39 00             	cmpb   $0x0,(%ecx)
    36a9:	74 15                	je     36c0 <strlen+0x20>
    36ab:	31 d2                	xor    %edx,%edx
    36ad:	8d 76 00             	lea    0x0(%esi),%esi
    36b0:	83 c2 01             	add    $0x1,%edx
    36b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    36b7:	89 d0                	mov    %edx,%eax
    36b9:	75 f5                	jne    36b0 <strlen+0x10>
    ;
  return n;
}
    36bb:	5d                   	pop    %ebp
    36bc:	c3                   	ret    
    36bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    36c0:	31 c0                	xor    %eax,%eax
}
    36c2:	5d                   	pop    %ebp
    36c3:	c3                   	ret    
    36c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    36ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000036d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    36d0:	55                   	push   %ebp
    36d1:	89 e5                	mov    %esp,%ebp
    36d3:	57                   	push   %edi
    36d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    36d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    36da:	8b 45 0c             	mov    0xc(%ebp),%eax
    36dd:	89 d7                	mov    %edx,%edi
    36df:	fc                   	cld    
    36e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    36e2:	89 d0                	mov    %edx,%eax
    36e4:	5f                   	pop    %edi
    36e5:	5d                   	pop    %ebp
    36e6:	c3                   	ret    
    36e7:	89 f6                	mov    %esi,%esi
    36e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000036f0 <strchr>:

char*
strchr(const char *s, char c)
{
    36f0:	55                   	push   %ebp
    36f1:	89 e5                	mov    %esp,%ebp
    36f3:	53                   	push   %ebx
    36f4:	8b 45 08             	mov    0x8(%ebp),%eax
    36f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    36fa:	0f b6 10             	movzbl (%eax),%edx
    36fd:	84 d2                	test   %dl,%dl
    36ff:	74 1d                	je     371e <strchr+0x2e>
    if(*s == c)
    3701:	38 d3                	cmp    %dl,%bl
    3703:	89 d9                	mov    %ebx,%ecx
    3705:	75 0d                	jne    3714 <strchr+0x24>
    3707:	eb 17                	jmp    3720 <strchr+0x30>
    3709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3710:	38 ca                	cmp    %cl,%dl
    3712:	74 0c                	je     3720 <strchr+0x30>
  for(; *s; s++)
    3714:	83 c0 01             	add    $0x1,%eax
    3717:	0f b6 10             	movzbl (%eax),%edx
    371a:	84 d2                	test   %dl,%dl
    371c:	75 f2                	jne    3710 <strchr+0x20>
      return (char*)s;
  return 0;
    371e:	31 c0                	xor    %eax,%eax
}
    3720:	5b                   	pop    %ebx
    3721:	5d                   	pop    %ebp
    3722:	c3                   	ret    
    3723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003730 <gets>:

char*
gets(char *buf, int max)
{
    3730:	55                   	push   %ebp
    3731:	89 e5                	mov    %esp,%ebp
    3733:	57                   	push   %edi
    3734:	56                   	push   %esi
    3735:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3736:	31 f6                	xor    %esi,%esi
    3738:	89 f3                	mov    %esi,%ebx
{
    373a:	83 ec 1c             	sub    $0x1c,%esp
    373d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    3740:	eb 2f                	jmp    3771 <gets+0x41>
    3742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    3748:	8d 45 e7             	lea    -0x19(%ebp),%eax
    374b:	83 ec 04             	sub    $0x4,%esp
    374e:	6a 01                	push   $0x1
    3750:	50                   	push   %eax
    3751:	6a 00                	push   $0x0
    3753:	e8 32 01 00 00       	call   388a <read>
    if(cc < 1)
    3758:	83 c4 10             	add    $0x10,%esp
    375b:	85 c0                	test   %eax,%eax
    375d:	7e 1c                	jle    377b <gets+0x4b>
      break;
    buf[i++] = c;
    375f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3763:	83 c7 01             	add    $0x1,%edi
    3766:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    3769:	3c 0a                	cmp    $0xa,%al
    376b:	74 23                	je     3790 <gets+0x60>
    376d:	3c 0d                	cmp    $0xd,%al
    376f:	74 1f                	je     3790 <gets+0x60>
  for(i=0; i+1 < max; ){
    3771:	83 c3 01             	add    $0x1,%ebx
    3774:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    3777:	89 fe                	mov    %edi,%esi
    3779:	7c cd                	jl     3748 <gets+0x18>
    377b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    377d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    3780:	c6 03 00             	movb   $0x0,(%ebx)
}
    3783:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3786:	5b                   	pop    %ebx
    3787:	5e                   	pop    %esi
    3788:	5f                   	pop    %edi
    3789:	5d                   	pop    %ebp
    378a:	c3                   	ret    
    378b:	90                   	nop
    378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3790:	8b 75 08             	mov    0x8(%ebp),%esi
    3793:	8b 45 08             	mov    0x8(%ebp),%eax
    3796:	01 de                	add    %ebx,%esi
    3798:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    379a:	c6 03 00             	movb   $0x0,(%ebx)
}
    379d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    37a0:	5b                   	pop    %ebx
    37a1:	5e                   	pop    %esi
    37a2:	5f                   	pop    %edi
    37a3:	5d                   	pop    %ebp
    37a4:	c3                   	ret    
    37a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000037b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    37b0:	55                   	push   %ebp
    37b1:	89 e5                	mov    %esp,%ebp
    37b3:	56                   	push   %esi
    37b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    37b5:	83 ec 08             	sub    $0x8,%esp
    37b8:	6a 00                	push   $0x0
    37ba:	ff 75 08             	pushl  0x8(%ebp)
    37bd:	e8 f0 00 00 00       	call   38b2 <open>
  if(fd < 0)
    37c2:	83 c4 10             	add    $0x10,%esp
    37c5:	85 c0                	test   %eax,%eax
    37c7:	78 27                	js     37f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    37c9:	83 ec 08             	sub    $0x8,%esp
    37cc:	ff 75 0c             	pushl  0xc(%ebp)
    37cf:	89 c3                	mov    %eax,%ebx
    37d1:	50                   	push   %eax
    37d2:	e8 f3 00 00 00       	call   38ca <fstat>
  close(fd);
    37d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    37da:	89 c6                	mov    %eax,%esi
  close(fd);
    37dc:	e8 b9 00 00 00       	call   389a <close>
  return r;
    37e1:	83 c4 10             	add    $0x10,%esp
}
    37e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    37e7:	89 f0                	mov    %esi,%eax
    37e9:	5b                   	pop    %ebx
    37ea:	5e                   	pop    %esi
    37eb:	5d                   	pop    %ebp
    37ec:	c3                   	ret    
    37ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    37f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    37f5:	eb ed                	jmp    37e4 <stat+0x34>
    37f7:	89 f6                	mov    %esi,%esi
    37f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003800 <atoi>:

int
atoi(const char *s)
{
    3800:	55                   	push   %ebp
    3801:	89 e5                	mov    %esp,%ebp
    3803:	53                   	push   %ebx
    3804:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3807:	0f be 11             	movsbl (%ecx),%edx
    380a:	8d 42 d0             	lea    -0x30(%edx),%eax
    380d:	3c 09                	cmp    $0x9,%al
  n = 0;
    380f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3814:	77 1f                	ja     3835 <atoi+0x35>
    3816:	8d 76 00             	lea    0x0(%esi),%esi
    3819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    3820:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3823:	83 c1 01             	add    $0x1,%ecx
    3826:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    382a:	0f be 11             	movsbl (%ecx),%edx
    382d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3830:	80 fb 09             	cmp    $0x9,%bl
    3833:	76 eb                	jbe    3820 <atoi+0x20>
  return n;
}
    3835:	5b                   	pop    %ebx
    3836:	5d                   	pop    %ebp
    3837:	c3                   	ret    
    3838:	90                   	nop
    3839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003840 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3840:	55                   	push   %ebp
    3841:	89 e5                	mov    %esp,%ebp
    3843:	56                   	push   %esi
    3844:	53                   	push   %ebx
    3845:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3848:	8b 45 08             	mov    0x8(%ebp),%eax
    384b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    384e:	85 db                	test   %ebx,%ebx
    3850:	7e 14                	jle    3866 <memmove+0x26>
    3852:	31 d2                	xor    %edx,%edx
    3854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3858:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    385c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    385f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    3862:	39 d3                	cmp    %edx,%ebx
    3864:	75 f2                	jne    3858 <memmove+0x18>
  return vdst;
}
    3866:	5b                   	pop    %ebx
    3867:	5e                   	pop    %esi
    3868:	5d                   	pop    %ebp
    3869:	c3                   	ret    

0000386a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    386a:	b8 01 00 00 00       	mov    $0x1,%eax
    386f:	cd 40                	int    $0x40
    3871:	c3                   	ret    

00003872 <exit>:
SYSCALL(exit)
    3872:	b8 02 00 00 00       	mov    $0x2,%eax
    3877:	cd 40                	int    $0x40
    3879:	c3                   	ret    

0000387a <wait>:
SYSCALL(wait)
    387a:	b8 03 00 00 00       	mov    $0x3,%eax
    387f:	cd 40                	int    $0x40
    3881:	c3                   	ret    

00003882 <pipe>:
SYSCALL(pipe)
    3882:	b8 04 00 00 00       	mov    $0x4,%eax
    3887:	cd 40                	int    $0x40
    3889:	c3                   	ret    

0000388a <read>:
SYSCALL(read)
    388a:	b8 05 00 00 00       	mov    $0x5,%eax
    388f:	cd 40                	int    $0x40
    3891:	c3                   	ret    

00003892 <write>:
SYSCALL(write)
    3892:	b8 10 00 00 00       	mov    $0x10,%eax
    3897:	cd 40                	int    $0x40
    3899:	c3                   	ret    

0000389a <close>:
SYSCALL(close)
    389a:	b8 15 00 00 00       	mov    $0x15,%eax
    389f:	cd 40                	int    $0x40
    38a1:	c3                   	ret    

000038a2 <kill>:
SYSCALL(kill)
    38a2:	b8 06 00 00 00       	mov    $0x6,%eax
    38a7:	cd 40                	int    $0x40
    38a9:	c3                   	ret    

000038aa <exec>:
SYSCALL(exec)
    38aa:	b8 07 00 00 00       	mov    $0x7,%eax
    38af:	cd 40                	int    $0x40
    38b1:	c3                   	ret    

000038b2 <open>:
SYSCALL(open)
    38b2:	b8 0f 00 00 00       	mov    $0xf,%eax
    38b7:	cd 40                	int    $0x40
    38b9:	c3                   	ret    

000038ba <mknod>:
SYSCALL(mknod)
    38ba:	b8 11 00 00 00       	mov    $0x11,%eax
    38bf:	cd 40                	int    $0x40
    38c1:	c3                   	ret    

000038c2 <unlink>:
SYSCALL(unlink)
    38c2:	b8 12 00 00 00       	mov    $0x12,%eax
    38c7:	cd 40                	int    $0x40
    38c9:	c3                   	ret    

000038ca <fstat>:
SYSCALL(fstat)
    38ca:	b8 08 00 00 00       	mov    $0x8,%eax
    38cf:	cd 40                	int    $0x40
    38d1:	c3                   	ret    

000038d2 <link>:
SYSCALL(link)
    38d2:	b8 13 00 00 00       	mov    $0x13,%eax
    38d7:	cd 40                	int    $0x40
    38d9:	c3                   	ret    

000038da <mkdir>:
SYSCALL(mkdir)
    38da:	b8 14 00 00 00       	mov    $0x14,%eax
    38df:	cd 40                	int    $0x40
    38e1:	c3                   	ret    

000038e2 <chdir>:
SYSCALL(chdir)
    38e2:	b8 09 00 00 00       	mov    $0x9,%eax
    38e7:	cd 40                	int    $0x40
    38e9:	c3                   	ret    

000038ea <dup>:
SYSCALL(dup)
    38ea:	b8 0a 00 00 00       	mov    $0xa,%eax
    38ef:	cd 40                	int    $0x40
    38f1:	c3                   	ret    

000038f2 <getpid>:
SYSCALL(getpid)
    38f2:	b8 0b 00 00 00       	mov    $0xb,%eax
    38f7:	cd 40                	int    $0x40
    38f9:	c3                   	ret    

000038fa <sbrk>:
SYSCALL(sbrk)
    38fa:	b8 0c 00 00 00       	mov    $0xc,%eax
    38ff:	cd 40                	int    $0x40
    3901:	c3                   	ret    

00003902 <sleep>:
SYSCALL(sleep)
    3902:	b8 0d 00 00 00       	mov    $0xd,%eax
    3907:	cd 40                	int    $0x40
    3909:	c3                   	ret    

0000390a <uptime>:
SYSCALL(uptime)
    390a:	b8 0e 00 00 00       	mov    $0xe,%eax
    390f:	cd 40                	int    $0x40
    3911:	c3                   	ret    

00003912 <getNumberOfFreePages>:
SYSCALL(getNumberOfFreePages)
    3912:	b8 16 00 00 00       	mov    $0x16,%eax
    3917:	cd 40                	int    $0x40
    3919:	c3                   	ret    

0000391a <printProcDump>:
SYSCALL(printProcDump)
    391a:	b8 17 00 00 00       	mov    $0x17,%eax
    391f:	cd 40                	int    $0x40
    3921:	c3                   	ret    
    3922:	66 90                	xchg   %ax,%ax
    3924:	66 90                	xchg   %ax,%ax
    3926:	66 90                	xchg   %ax,%ax
    3928:	66 90                	xchg   %ax,%ax
    392a:	66 90                	xchg   %ax,%ax
    392c:	66 90                	xchg   %ax,%ax
    392e:	66 90                	xchg   %ax,%ax

00003930 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3930:	55                   	push   %ebp
    3931:	89 e5                	mov    %esp,%ebp
    3933:	57                   	push   %edi
    3934:	56                   	push   %esi
    3935:	53                   	push   %ebx
    3936:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3939:	85 d2                	test   %edx,%edx
{
    393b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    393e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    3940:	79 76                	jns    39b8 <printint+0x88>
    3942:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3946:	74 70                	je     39b8 <printint+0x88>
    x = -xx;
    3948:	f7 d8                	neg    %eax
    neg = 1;
    394a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    3951:	31 f6                	xor    %esi,%esi
    3953:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3956:	eb 0a                	jmp    3962 <printint+0x32>
    3958:	90                   	nop
    3959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    3960:	89 fe                	mov    %edi,%esi
    3962:	31 d2                	xor    %edx,%edx
    3964:	8d 7e 01             	lea    0x1(%esi),%edi
    3967:	f7 f1                	div    %ecx
    3969:	0f b6 92 c8 54 00 00 	movzbl 0x54c8(%edx),%edx
  }while((x /= base) != 0);
    3970:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    3972:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    3975:	75 e9                	jne    3960 <printint+0x30>
  if(neg)
    3977:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    397a:	85 c0                	test   %eax,%eax
    397c:	74 08                	je     3986 <printint+0x56>
    buf[i++] = '-';
    397e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    3983:	8d 7e 02             	lea    0x2(%esi),%edi
    3986:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    398a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    398d:	8d 76 00             	lea    0x0(%esi),%esi
    3990:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    3993:	83 ec 04             	sub    $0x4,%esp
    3996:	83 ee 01             	sub    $0x1,%esi
    3999:	6a 01                	push   $0x1
    399b:	53                   	push   %ebx
    399c:	57                   	push   %edi
    399d:	88 45 d7             	mov    %al,-0x29(%ebp)
    39a0:	e8 ed fe ff ff       	call   3892 <write>

  while(--i >= 0)
    39a5:	83 c4 10             	add    $0x10,%esp
    39a8:	39 de                	cmp    %ebx,%esi
    39aa:	75 e4                	jne    3990 <printint+0x60>
    putc(fd, buf[i]);
}
    39ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
    39af:	5b                   	pop    %ebx
    39b0:	5e                   	pop    %esi
    39b1:	5f                   	pop    %edi
    39b2:	5d                   	pop    %ebp
    39b3:	c3                   	ret    
    39b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    39b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    39bf:	eb 90                	jmp    3951 <printint+0x21>
    39c1:	eb 0d                	jmp    39d0 <printf>
    39c3:	90                   	nop
    39c4:	90                   	nop
    39c5:	90                   	nop
    39c6:	90                   	nop
    39c7:	90                   	nop
    39c8:	90                   	nop
    39c9:	90                   	nop
    39ca:	90                   	nop
    39cb:	90                   	nop
    39cc:	90                   	nop
    39cd:	90                   	nop
    39ce:	90                   	nop
    39cf:	90                   	nop

000039d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    39d0:	55                   	push   %ebp
    39d1:	89 e5                	mov    %esp,%ebp
    39d3:	57                   	push   %edi
    39d4:	56                   	push   %esi
    39d5:	53                   	push   %ebx
    39d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    39d9:	8b 75 0c             	mov    0xc(%ebp),%esi
    39dc:	0f b6 1e             	movzbl (%esi),%ebx
    39df:	84 db                	test   %bl,%bl
    39e1:	0f 84 b3 00 00 00    	je     3a9a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    39e7:	8d 45 10             	lea    0x10(%ebp),%eax
    39ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
    39ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    39ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    39f2:	eb 2f                	jmp    3a23 <printf+0x53>
    39f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    39f8:	83 f8 25             	cmp    $0x25,%eax
    39fb:	0f 84 a7 00 00 00    	je     3aa8 <printf+0xd8>
  write(fd, &c, 1);
    3a01:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3a04:	83 ec 04             	sub    $0x4,%esp
    3a07:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    3a0a:	6a 01                	push   $0x1
    3a0c:	50                   	push   %eax
    3a0d:	ff 75 08             	pushl  0x8(%ebp)
    3a10:	e8 7d fe ff ff       	call   3892 <write>
    3a15:	83 c4 10             	add    $0x10,%esp
    3a18:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    3a1b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    3a1f:	84 db                	test   %bl,%bl
    3a21:	74 77                	je     3a9a <printf+0xca>
    if(state == 0){
    3a23:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    3a25:	0f be cb             	movsbl %bl,%ecx
    3a28:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    3a2b:	74 cb                	je     39f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3a2d:	83 ff 25             	cmp    $0x25,%edi
    3a30:	75 e6                	jne    3a18 <printf+0x48>
      if(c == 'd'){
    3a32:	83 f8 64             	cmp    $0x64,%eax
    3a35:	0f 84 05 01 00 00    	je     3b40 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3a3b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    3a41:	83 f9 70             	cmp    $0x70,%ecx
    3a44:	74 72                	je     3ab8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3a46:	83 f8 73             	cmp    $0x73,%eax
    3a49:	0f 84 99 00 00 00    	je     3ae8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3a4f:	83 f8 63             	cmp    $0x63,%eax
    3a52:	0f 84 08 01 00 00    	je     3b60 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3a58:	83 f8 25             	cmp    $0x25,%eax
    3a5b:	0f 84 ef 00 00 00    	je     3b50 <printf+0x180>
  write(fd, &c, 1);
    3a61:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3a64:	83 ec 04             	sub    $0x4,%esp
    3a67:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3a6b:	6a 01                	push   $0x1
    3a6d:	50                   	push   %eax
    3a6e:	ff 75 08             	pushl  0x8(%ebp)
    3a71:	e8 1c fe ff ff       	call   3892 <write>
    3a76:	83 c4 0c             	add    $0xc,%esp
    3a79:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3a7c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    3a7f:	6a 01                	push   $0x1
    3a81:	50                   	push   %eax
    3a82:	ff 75 08             	pushl  0x8(%ebp)
    3a85:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3a88:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    3a8a:	e8 03 fe ff ff       	call   3892 <write>
  for(i = 0; fmt[i]; i++){
    3a8f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    3a93:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3a96:	84 db                	test   %bl,%bl
    3a98:	75 89                	jne    3a23 <printf+0x53>
    }
  }
}
    3a9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3a9d:	5b                   	pop    %ebx
    3a9e:	5e                   	pop    %esi
    3a9f:	5f                   	pop    %edi
    3aa0:	5d                   	pop    %ebp
    3aa1:	c3                   	ret    
    3aa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    3aa8:	bf 25 00 00 00       	mov    $0x25,%edi
    3aad:	e9 66 ff ff ff       	jmp    3a18 <printf+0x48>
    3ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3ab8:	83 ec 0c             	sub    $0xc,%esp
    3abb:	b9 10 00 00 00       	mov    $0x10,%ecx
    3ac0:	6a 00                	push   $0x0
    3ac2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    3ac5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ac8:	8b 17                	mov    (%edi),%edx
    3aca:	e8 61 fe ff ff       	call   3930 <printint>
        ap++;
    3acf:	89 f8                	mov    %edi,%eax
    3ad1:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3ad4:	31 ff                	xor    %edi,%edi
        ap++;
    3ad6:	83 c0 04             	add    $0x4,%eax
    3ad9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    3adc:	e9 37 ff ff ff       	jmp    3a18 <printf+0x48>
    3ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3ae8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3aeb:	8b 08                	mov    (%eax),%ecx
        ap++;
    3aed:	83 c0 04             	add    $0x4,%eax
    3af0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    3af3:	85 c9                	test   %ecx,%ecx
    3af5:	0f 84 8e 00 00 00    	je     3b89 <printf+0x1b9>
        while(*s != 0){
    3afb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    3afe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    3b00:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    3b02:	84 c0                	test   %al,%al
    3b04:	0f 84 0e ff ff ff    	je     3a18 <printf+0x48>
    3b0a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    3b0d:	89 de                	mov    %ebx,%esi
    3b0f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3b12:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    3b15:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3b18:	83 ec 04             	sub    $0x4,%esp
          s++;
    3b1b:	83 c6 01             	add    $0x1,%esi
    3b1e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    3b21:	6a 01                	push   $0x1
    3b23:	57                   	push   %edi
    3b24:	53                   	push   %ebx
    3b25:	e8 68 fd ff ff       	call   3892 <write>
        while(*s != 0){
    3b2a:	0f b6 06             	movzbl (%esi),%eax
    3b2d:	83 c4 10             	add    $0x10,%esp
    3b30:	84 c0                	test   %al,%al
    3b32:	75 e4                	jne    3b18 <printf+0x148>
    3b34:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    3b37:	31 ff                	xor    %edi,%edi
    3b39:	e9 da fe ff ff       	jmp    3a18 <printf+0x48>
    3b3e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    3b40:	83 ec 0c             	sub    $0xc,%esp
    3b43:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3b48:	6a 01                	push   $0x1
    3b4a:	e9 73 ff ff ff       	jmp    3ac2 <printf+0xf2>
    3b4f:	90                   	nop
  write(fd, &c, 1);
    3b50:	83 ec 04             	sub    $0x4,%esp
    3b53:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    3b56:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3b59:	6a 01                	push   $0x1
    3b5b:	e9 21 ff ff ff       	jmp    3a81 <printf+0xb1>
        putc(fd, *ap);
    3b60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    3b63:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3b66:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    3b68:	6a 01                	push   $0x1
        ap++;
    3b6a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    3b6d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    3b70:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3b73:	50                   	push   %eax
    3b74:	ff 75 08             	pushl  0x8(%ebp)
    3b77:	e8 16 fd ff ff       	call   3892 <write>
        ap++;
    3b7c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    3b7f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3b82:	31 ff                	xor    %edi,%edi
    3b84:	e9 8f fe ff ff       	jmp    3a18 <printf+0x48>
          s = "(null)";
    3b89:	bb c0 54 00 00       	mov    $0x54c0,%ebx
        while(*s != 0){
    3b8e:	b8 28 00 00 00       	mov    $0x28,%eax
    3b93:	e9 72 ff ff ff       	jmp    3b0a <printf+0x13a>
    3b98:	66 90                	xchg   %ax,%ax
    3b9a:	66 90                	xchg   %ax,%ax
    3b9c:	66 90                	xchg   %ax,%ax
    3b9e:	66 90                	xchg   %ax,%ax

00003ba0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3ba0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3ba1:	a1 80 5e 00 00       	mov    0x5e80,%eax
{
    3ba6:	89 e5                	mov    %esp,%ebp
    3ba8:	57                   	push   %edi
    3ba9:	56                   	push   %esi
    3baa:	53                   	push   %ebx
    3bab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3bae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    3bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3bb8:	39 c8                	cmp    %ecx,%eax
    3bba:	8b 10                	mov    (%eax),%edx
    3bbc:	73 32                	jae    3bf0 <free+0x50>
    3bbe:	39 d1                	cmp    %edx,%ecx
    3bc0:	72 04                	jb     3bc6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bc2:	39 d0                	cmp    %edx,%eax
    3bc4:	72 32                	jb     3bf8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3bc6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3bc9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3bcc:	39 fa                	cmp    %edi,%edx
    3bce:	74 30                	je     3c00 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3bd0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3bd3:	8b 50 04             	mov    0x4(%eax),%edx
    3bd6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3bd9:	39 f1                	cmp    %esi,%ecx
    3bdb:	74 3a                	je     3c17 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3bdd:	89 08                	mov    %ecx,(%eax)
  freep = p;
    3bdf:	a3 80 5e 00 00       	mov    %eax,0x5e80
}
    3be4:	5b                   	pop    %ebx
    3be5:	5e                   	pop    %esi
    3be6:	5f                   	pop    %edi
    3be7:	5d                   	pop    %ebp
    3be8:	c3                   	ret    
    3be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3bf0:	39 d0                	cmp    %edx,%eax
    3bf2:	72 04                	jb     3bf8 <free+0x58>
    3bf4:	39 d1                	cmp    %edx,%ecx
    3bf6:	72 ce                	jb     3bc6 <free+0x26>
{
    3bf8:	89 d0                	mov    %edx,%eax
    3bfa:	eb bc                	jmp    3bb8 <free+0x18>
    3bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    3c00:	03 72 04             	add    0x4(%edx),%esi
    3c03:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3c06:	8b 10                	mov    (%eax),%edx
    3c08:	8b 12                	mov    (%edx),%edx
    3c0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3c0d:	8b 50 04             	mov    0x4(%eax),%edx
    3c10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    3c13:	39 f1                	cmp    %esi,%ecx
    3c15:	75 c6                	jne    3bdd <free+0x3d>
    p->s.size += bp->s.size;
    3c17:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    3c1a:	a3 80 5e 00 00       	mov    %eax,0x5e80
    p->s.size += bp->s.size;
    3c1f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3c22:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3c25:	89 10                	mov    %edx,(%eax)
}
    3c27:	5b                   	pop    %ebx
    3c28:	5e                   	pop    %esi
    3c29:	5f                   	pop    %edi
    3c2a:	5d                   	pop    %ebp
    3c2b:	c3                   	ret    
    3c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003c30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3c30:	55                   	push   %ebp
    3c31:	89 e5                	mov    %esp,%ebp
    3c33:	57                   	push   %edi
    3c34:	56                   	push   %esi
    3c35:	53                   	push   %ebx
    3c36:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3c3c:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3c42:	8d 78 07             	lea    0x7(%eax),%edi
    3c45:	c1 ef 03             	shr    $0x3,%edi
    3c48:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    3c4b:	85 d2                	test   %edx,%edx
    3c4d:	0f 84 9d 00 00 00    	je     3cf0 <malloc+0xc0>
    3c53:	8b 02                	mov    (%edx),%eax
    3c55:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3c58:	39 cf                	cmp    %ecx,%edi
    3c5a:	76 6c                	jbe    3cc8 <malloc+0x98>
    3c5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    3c62:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3c67:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    3c6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    3c71:	eb 0e                	jmp    3c81 <malloc+0x51>
    3c73:	90                   	nop
    3c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3c7a:	8b 48 04             	mov    0x4(%eax),%ecx
    3c7d:	39 f9                	cmp    %edi,%ecx
    3c7f:	73 47                	jae    3cc8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3c81:	39 05 80 5e 00 00    	cmp    %eax,0x5e80
    3c87:	89 c2                	mov    %eax,%edx
    3c89:	75 ed                	jne    3c78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3c8b:	83 ec 0c             	sub    $0xc,%esp
    3c8e:	56                   	push   %esi
    3c8f:	e8 66 fc ff ff       	call   38fa <sbrk>
  if(p == (char*)-1)
    3c94:	83 c4 10             	add    $0x10,%esp
    3c97:	83 f8 ff             	cmp    $0xffffffff,%eax
    3c9a:	74 1c                	je     3cb8 <malloc+0x88>
  hp->s.size = nu;
    3c9c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3c9f:	83 ec 0c             	sub    $0xc,%esp
    3ca2:	83 c0 08             	add    $0x8,%eax
    3ca5:	50                   	push   %eax
    3ca6:	e8 f5 fe ff ff       	call   3ba0 <free>
  return freep;
    3cab:	8b 15 80 5e 00 00    	mov    0x5e80,%edx
      if((p = morecore(nunits)) == 0)
    3cb1:	83 c4 10             	add    $0x10,%esp
    3cb4:	85 d2                	test   %edx,%edx
    3cb6:	75 c0                	jne    3c78 <malloc+0x48>
        return 0;
  }
}
    3cb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3cbb:	31 c0                	xor    %eax,%eax
}
    3cbd:	5b                   	pop    %ebx
    3cbe:	5e                   	pop    %esi
    3cbf:	5f                   	pop    %edi
    3cc0:	5d                   	pop    %ebp
    3cc1:	c3                   	ret    
    3cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3cc8:	39 cf                	cmp    %ecx,%edi
    3cca:	74 54                	je     3d20 <malloc+0xf0>
        p->s.size -= nunits;
    3ccc:	29 f9                	sub    %edi,%ecx
    3cce:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3cd1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3cd4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    3cd7:	89 15 80 5e 00 00    	mov    %edx,0x5e80
}
    3cdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3ce0:	83 c0 08             	add    $0x8,%eax
}
    3ce3:	5b                   	pop    %ebx
    3ce4:	5e                   	pop    %esi
    3ce5:	5f                   	pop    %edi
    3ce6:	5d                   	pop    %ebp
    3ce7:	c3                   	ret    
    3ce8:	90                   	nop
    3ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    3cf0:	c7 05 80 5e 00 00 84 	movl   $0x5e84,0x5e80
    3cf7:	5e 00 00 
    3cfa:	c7 05 84 5e 00 00 84 	movl   $0x5e84,0x5e84
    3d01:	5e 00 00 
    base.s.size = 0;
    3d04:	b8 84 5e 00 00       	mov    $0x5e84,%eax
    3d09:	c7 05 88 5e 00 00 00 	movl   $0x0,0x5e88
    3d10:	00 00 00 
    3d13:	e9 44 ff ff ff       	jmp    3c5c <malloc+0x2c>
    3d18:	90                   	nop
    3d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    3d20:	8b 08                	mov    (%eax),%ecx
    3d22:	89 0a                	mov    %ecx,(%edx)
    3d24:	eb b1                	jmp    3cd7 <malloc+0xa7>
