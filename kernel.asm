
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc c0 d5 10 80       	mov    $0x8010d5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 37 10 80       	mov    $0x80103730,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 d5 10 80       	mov    $0x8010d5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 8a 10 80       	push   $0x80108a00
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 05 51 00 00       	call   80105160 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 1d 11 80 bc 	movl   $0x80111cbc,0x80111d0c
80100062:	1c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 1d 11 80 bc 	movl   $0x80111cbc,0x80111d10
8010006c:	1c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 1c 11 80       	mov    $0x80111cbc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 bc 1c 11 80 	movl   $0x80111cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 8a 10 80       	push   $0x80108a07
80100097:	50                   	push   %eax
80100098:	e8 93 4f 00 00       	call   80105030 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 1d 11 80       	mov    0x80111d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 1d 11 80    	mov    %ebx,0x80111d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 1c 11 80       	cmp    $0x80111cbc,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 c0 d5 10 80       	push   $0x8010d5c0
801000e4:	e8 b7 51 00 00       	call   801052a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 1d 11 80    	mov    0x80111d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c 1d 11 80    	mov    0x80111d0c,%ebx
80100126:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 1c 11 80    	cmp    $0x80111cbc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 c0 d5 10 80       	push   $0x8010d5c0
80100162:	e8 f9 51 00 00       	call   80105360 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 fe 4e 00 00       	call   80105070 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 3d 25 00 00       	call   801026c0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 8a 10 80       	push   $0x80108a0e
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 5d 4f 00 00       	call   80105110 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 f7 24 00 00       	jmp    801026c0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 8a 10 80       	push   $0x80108a1f
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 1c 4f 00 00       	call   80105110 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 cc 4e 00 00       	call   801050d0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 90 50 00 00       	call   801052a0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 10 1d 11 80       	mov    0x80111d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 1c 11 80 	movl   $0x80111cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 1d 11 80       	mov    0x80111d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 1d 11 80    	mov    %ebx,0x80111d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 d5 10 80 	movl   $0x8010d5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 ff 50 00 00       	jmp    80105360 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 8a 10 80       	push   $0x80108a26
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 16 00 00       	call   80101970 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 0f 50 00 00       	call   801052a0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002a7:	39 15 a4 1f 11 80    	cmp    %edx,0x80111fa4
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 20 c5 10 80       	push   $0x8010c520
801002c0:	68 a0 1f 11 80       	push   $0x80111fa0
801002c5:	e8 a6 44 00 00       	call   80104770 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 40 3e 00 00       	call   80104120 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 6c 50 00 00       	call   80105360 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 15 00 00       	call   80101890 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 a0 1f 11 80       	mov    %eax,0x80111fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 1f 11 80 	movsbl -0x7feee0e0(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 20 c5 10 80       	push   $0x8010c520
8010034d:	e8 0e 50 00 00       	call   80105360 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 15 00 00       	call   80101890 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 a0 1f 11 80    	mov    %edx,0x80111fa0
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 54 c5 10 80 00 	movl   $0x0,0x8010c554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 12 2c 00 00       	call   80102fc0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 2d 8a 10 80       	push   $0x80108a2d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 74 95 10 80 	movl   $0x80109574,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 a3 4d 00 00       	call   80105180 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 8a 10 80       	push   $0x80108a41
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 c5 10 80 01 	movl   $0x1,0x8010c558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 c5 10 80    	mov    0x8010c558,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 31 68 00 00       	call   80106c70 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 7f 67 00 00       	call   80106c70 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 73 67 00 00       	call   80106c70 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 67 67 00 00       	call   80106c70 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 37 4f 00 00       	call   80105460 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 6a 4e 00 00       	call   801053b0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 8a 10 80       	push   $0x80108a45
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 70 8a 10 80 	movzbl -0x7fef7590(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 5c 13 00 00       	call   80101970 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 80 4c 00 00       	call   801052a0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 c5 10 80       	push   $0x8010c520
80100647:	e8 14 4d 00 00       	call   80105360 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 12 00 00       	call   80101890 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 54 c5 10 80       	mov    0x8010c554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 20 c5 10 80       	push   $0x8010c520
8010071f:	e8 3c 4c 00 00       	call   80105360 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 58 8a 10 80       	mov    $0x80108a58,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 ab 4a 00 00       	call   801052a0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 8a 10 80       	push   $0x80108a5f
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 20 c5 10 80       	push   $0x8010c520
80100823:	e8 78 4a 00 00       	call   801052a0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
80100856:	3b 05 a4 1f 11 80    	cmp    0x80111fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 1f 11 80       	mov    %eax,0x80111fa8
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 20 c5 10 80       	push   $0x8010c520
80100888:	e8 d3 4a 00 00       	call   80105360 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 1f 11 80    	sub    0x80111fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 1f 11 80    	mov    %edx,0x80111fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 1f 11 80    	mov    %cl,-0x7feee0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 1f 11 80       	mov    0x80111fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 1f 11 80    	cmp    %eax,0x80111fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 1f 11 80       	mov    %eax,0x80111fa4
          wakeup(&input.r);
80100911:	68 a0 1f 11 80       	push   $0x80111fa0
80100916:	e8 75 40 00 00       	call   80104990 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
8010093d:	39 05 a4 1f 11 80    	cmp    %eax,0x80111fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 1f 11 80       	mov    %eax,0x80111fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
80100964:	3b 05 a4 1f 11 80    	cmp    0x80111fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 1f 11 80 0a 	cmpb   $0xa,-0x7feee0e0(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 d4 40 00 00       	jmp    80104a70 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 1f 11 80 0a 	movb   $0xa,-0x7feee0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 1f 11 80       	mov    0x80111fa8,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 68 8a 10 80       	push   $0x80108a68
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 8b 47 00 00       	call   80105160 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 29 11 80 00 	movl   $0x80100600,0x8011296c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 29 11 80 70 	movl   $0x80100270,0x80112968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 c5 10 80 01 	movl   $0x1,0x8010c554
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 72 1e 00 00       	call   80102870 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a16:	31 ff                	xor    %edi,%edi
{
80100a18:	81 ec 9c 03 00 00    	sub    $0x39c,%esp
  struct proc *curproc = myproc();
80100a1e:	e8 fd 36 00 00       	call   80104120 <myproc>
80100a23:	8d 98 98 00 00 00    	lea    0x98(%eax),%ebx
80100a29:	89 85 74 fc ff ff    	mov    %eax,-0x38c(%ebp)
80100a2f:	89 de                	mov    %ebx,%esi
80100a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct swappedPG swappedPGs[MAX_PSYC_PAGES];
  struct procPG physicalPGs[MAX_PSYC_PAGES];

  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){

    resetRefCounter((uint)curproc->physicalPGs[i].va);
80100a38:	83 ec 0c             	sub    $0xc,%esp
80100a3b:	ff b6 40 01 00 00    	pushl  0x140(%esi)
80100a41:	83 c6 14             	add    $0x14,%esi
80100a44:	e8 e7 21 00 00       	call   80102c30 <resetRefCounter>
    physicalPGs[i].next = curproc->physicalPGs[i].next;
80100a49:	8b 86 38 01 00 00    	mov    0x138(%esi),%eax
    #ifdef LAPA
        p->physicalPGs[i].age = 0xffffffff;
    #endif
    curproc->physicalPGs[i].alloceted = 0;
    curproc->swappedPGs[i].va = (char*)0xffffffff;
    swappedPGs[i].offset = 0;
80100a4f:	c7 84 2f 68 fd ff ff 	movl   $0x0,-0x298(%edi,%ebp,1)
80100a56:	00 00 00 00 
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100a5a:	83 c4 10             	add    $0x10,%esp
    curproc->physicalPGs[i].next = 0;
80100a5d:	c7 86 38 01 00 00 00 	movl   $0x0,0x138(%esi)
80100a64:	00 00 00 
    physicalPGs[i].next = curproc->physicalPGs[i].next;
80100a67:	89 84 3d b4 fe ff ff 	mov    %eax,-0x14c(%ebp,%edi,1)
    physicalPGs[i].prev =  curproc->physicalPGs[i].prev ;
80100a6e:	8b 86 3c 01 00 00    	mov    0x13c(%esi),%eax
    curproc->physicalPGs[i].prev = 0;
80100a74:	c7 86 3c 01 00 00 00 	movl   $0x0,0x13c(%esi)
80100a7b:	00 00 00 
    physicalPGs[i].prev =  curproc->physicalPGs[i].prev ;
80100a7e:	89 84 3d b8 fe ff ff 	mov    %eax,-0x148(%ebp,%edi,1)
    physicalPGs[i].va = curproc->physicalPGs[i].va;
80100a85:	8b 86 2c 01 00 00    	mov    0x12c(%esi),%eax
    curproc->physicalPGs[i].va = (char*)0xffffffff;
80100a8b:	c7 86 2c 01 00 00 ff 	movl   $0xffffffff,0x12c(%esi)
80100a92:	ff ff ff 
    physicalPGs[i].va = curproc->physicalPGs[i].va;
80100a95:	89 84 2f a8 fe ff ff 	mov    %eax,-0x158(%edi,%ebp,1)
    physicalPGs[i].age = curproc->physicalPGs[i].age;
80100a9c:	8b 86 30 01 00 00    	mov    0x130(%esi),%eax
    curproc->physicalPGs[i].age = 0;
80100aa2:	c7 86 30 01 00 00 00 	movl   $0x0,0x130(%esi)
80100aa9:	00 00 00 
    physicalPGs[i].age = curproc->physicalPGs[i].age;
80100aac:	89 84 3d ac fe ff ff 	mov    %eax,-0x154(%ebp,%edi,1)
    physicalPGs[i].alloceted = curproc->physicalPGs[i].alloceted;
80100ab3:	8b 86 34 01 00 00    	mov    0x134(%esi),%eax
    curproc->physicalPGs[i].alloceted = 0;
80100ab9:	c7 86 34 01 00 00 00 	movl   $0x0,0x134(%esi)
80100ac0:	00 00 00 
    physicalPGs[i].alloceted = curproc->physicalPGs[i].alloceted;
80100ac3:	89 84 3d b0 fe ff ff 	mov    %eax,-0x150(%ebp,%edi,1)
    swappedPGs[i] = curproc->swappedPGs[i];
80100aca:	8b 46 f0             	mov    -0x10(%esi),%eax
80100acd:	83 c7 14             	add    $0x14,%edi
80100ad0:	89 84 2f 58 fd ff ff 	mov    %eax,-0x2a8(%edi,%ebp,1)
80100ad7:	8b 46 f4             	mov    -0xc(%esi),%eax
80100ada:	89 84 2f 5c fd ff ff 	mov    %eax,-0x2a4(%edi,%ebp,1)
80100ae1:	8b 46 f8             	mov    -0x8(%esi),%eax
80100ae4:	89 84 2f 60 fd ff ff 	mov    %eax,-0x2a0(%edi,%ebp,1)
80100aeb:	8b 46 fc             	mov    -0x4(%esi),%eax
    curproc->swappedPGs[i].va = (char*)0xffffffff;
80100aee:	c7 46 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%esi)
    swappedPGs[i] = curproc->swappedPGs[i];
80100af5:	89 84 2f 64 fd ff ff 	mov    %eax,-0x29c(%edi,%ebp,1)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100afc:	81 ff 40 01 00 00    	cmp    $0x140,%edi
80100b02:	0f 85 30 ff ff ff    	jne    80100a38 <exec+0x28>
  }

  int nPgsPhysical = curproc->nPgsPhysical;
80100b08:	8b 85 74 fc ff ff    	mov    -0x38c(%ebp),%eax
80100b0e:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
  curproc->nPgsPhysical = 0;
80100b14:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80100b1b:	00 00 00 
  int nPgsPhysical = curproc->nPgsPhysical;
80100b1e:	89 8d 6c fc ff ff    	mov    %ecx,-0x394(%ebp)
  int nPgsSwap =curproc->nPgsSwap ;
80100b24:	8b 88 84 00 00 00    	mov    0x84(%eax),%ecx
  curproc->nPgsSwap = 0;
80100b2a:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80100b31:	00 00 00 
  int nPgsSwap =curproc->nPgsSwap ;
80100b34:	89 8d 68 fc ff ff    	mov    %ecx,-0x398(%ebp)
  int headPG =curproc->headPG;
80100b3a:	8b 88 94 00 00 00    	mov    0x94(%eax),%ecx
  curproc->headPG = -1;
80100b40:	c7 80 94 00 00 00 ff 	movl   $0xffffffff,0x94(%eax)
80100b47:	ff ff ff 
  int headPG =curproc->headPG;
80100b4a:	89 8d 64 fc ff ff    	mov    %ecx,-0x39c(%ebp)
  #endif

  begin_op();
80100b50:	e8 db 28 00 00       	call   80103430 <begin_op>

  if((ip = namei(path)) == 0){
80100b55:	83 ec 0c             	sub    $0xc,%esp
80100b58:	ff 75 08             	pushl  0x8(%ebp)
80100b5b:	e8 90 15 00 00       	call   801020f0 <namei>
80100b60:	83 c4 10             	add    $0x10,%esp
80100b63:	85 c0                	test   %eax,%eax
80100b65:	89 c6                	mov    %eax,%esi
80100b67:	0f 84 eb 02 00 00    	je     80100e58 <exec+0x448>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b6d:	83 ec 0c             	sub    $0xc,%esp
80100b70:	50                   	push   %eax
80100b71:	e8 1a 0d 00 00       	call   80101890 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b76:	8d 85 a4 fc ff ff    	lea    -0x35c(%ebp),%eax
80100b7c:	6a 34                	push   $0x34
80100b7e:	6a 00                	push   $0x0
80100b80:	50                   	push   %eax
80100b81:	56                   	push   %esi
80100b82:	e8 e9 0f 00 00       	call   80101b70 <readi>
80100b87:	83 c4 20             	add    $0x20,%esp
80100b8a:	83 f8 34             	cmp    $0x34,%eax
  pgdir = 0;
80100b8d:	c7 85 70 fc ff ff 00 	movl   $0x0,-0x390(%ebp)
80100b94:	00 00 00 
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b97:	0f 84 d3 00 00 00    	je     80100c70 <exec+0x260>
80100b9d:	8d 8d a8 fe ff ff    	lea    -0x158(%ebp),%ecx
80100ba3:	8d 85 68 fd ff ff    	lea    -0x298(%ebp),%eax
80100ba9:	8d 7d e8             	lea    -0x18(%ebp),%edi
80100bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  #ifndef NONE
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
      // if(physicalPGs[i].va!=EMPTY_VA){
      //   setReferenceCount((uint)curproc->physicalPGs[i].va,buRefs[i]);
      // }
      curproc->physicalPGs[i].next = physicalPGs[i].next;
80100bb0:	8b 51 0c             	mov    0xc(%ecx),%edx
80100bb3:	83 c1 14             	add    $0x14,%ecx
80100bb6:	83 c3 14             	add    $0x14,%ebx
80100bb9:	83 c0 14             	add    $0x14,%eax
80100bbc:	89 93 38 01 00 00    	mov    %edx,0x138(%ebx)
      curproc->physicalPGs[i].prev =  physicalPGs[i].prev;
80100bc2:	8b 51 fc             	mov    -0x4(%ecx),%edx
80100bc5:	89 93 3c 01 00 00    	mov    %edx,0x13c(%ebx)
      curproc->physicalPGs[i].va = physicalPGs[i].va;
80100bcb:	8b 51 ec             	mov    -0x14(%ecx),%edx
80100bce:	89 93 2c 01 00 00    	mov    %edx,0x12c(%ebx)
      curproc->physicalPGs[i].age = physicalPGs[i].age;
80100bd4:	8b 51 f0             	mov    -0x10(%ecx),%edx
80100bd7:	89 93 30 01 00 00    	mov    %edx,0x130(%ebx)
      curproc->physicalPGs[i].alloceted = physicalPGs[i].alloceted;
80100bdd:	8b 51 f4             	mov    -0xc(%ecx),%edx
80100be0:	89 93 34 01 00 00    	mov    %edx,0x134(%ebx)

      curproc->swappedPGs[i] = swappedPGs[i];
80100be6:	8b 50 ec             	mov    -0x14(%eax),%edx
80100be9:	89 53 ec             	mov    %edx,-0x14(%ebx)
80100bec:	8b 50 f0             	mov    -0x10(%eax),%edx
80100bef:	89 53 f0             	mov    %edx,-0x10(%ebx)
80100bf2:	8b 50 f4             	mov    -0xc(%eax),%edx
80100bf5:	89 53 f4             	mov    %edx,-0xc(%ebx)
80100bf8:	8b 50 f8             	mov    -0x8(%eax),%edx
80100bfb:	89 53 f8             	mov    %edx,-0x8(%ebx)
80100bfe:	8b 50 fc             	mov    -0x4(%eax),%edx
80100c01:	89 53 fc             	mov    %edx,-0x4(%ebx)
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80100c04:	39 f9                	cmp    %edi,%ecx
80100c06:	75 a8                	jne    80100bb0 <exec+0x1a0>
      curproc->swappedPGs[i].offset = swappedPGs[i].offset;

  }
  curproc->nPgsSwap =nPgsSwap ;
80100c08:	8b 85 74 fc ff ff    	mov    -0x38c(%ebp),%eax
80100c0e:	8b 8d 68 fc ff ff    	mov    -0x398(%ebp),%ecx
80100c14:	89 88 84 00 00 00    	mov    %ecx,0x84(%eax)
  curproc->headPG =headPG;
80100c1a:	8b 8d 64 fc ff ff    	mov    -0x39c(%ebp),%ecx
80100c20:	89 88 94 00 00 00    	mov    %ecx,0x94(%eax)
  curproc->nPgsPhysical = nPgsPhysical;
80100c26:	8b 8d 6c fc ff ff    	mov    -0x394(%ebp),%ecx
80100c2c:	89 88 80 00 00 00    	mov    %ecx,0x80(%eax)
  #endif

  if(pgdir)
80100c32:	8b 85 70 fc ff ff    	mov    -0x390(%ebp),%eax
80100c38:	85 c0                	test   %eax,%eax
80100c3a:	74 0c                	je     80100c48 <exec+0x238>
    freevm(pgdir);
80100c3c:	83 ec 0c             	sub    $0xc,%esp
80100c3f:	50                   	push   %eax
80100c40:	e8 4b 77 00 00       	call   80108390 <freevm>
80100c45:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100c48:	85 f6                	test   %esi,%esi
    iunlockput(ip);
    end_op();
  }
  return -1;
80100c4a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(ip){
80100c4f:	74 11                	je     80100c62 <exec+0x252>
    iunlockput(ip);
80100c51:	83 ec 0c             	sub    $0xc,%esp
80100c54:	56                   	push   %esi
80100c55:	e8 c6 0e 00 00       	call   80101b20 <iunlockput>
    end_op();
80100c5a:	e8 41 28 00 00       	call   801034a0 <end_op>
80100c5f:	83 c4 10             	add    $0x10,%esp
}
80100c62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c65:	89 d8                	mov    %ebx,%eax
80100c67:	5b                   	pop    %ebx
80100c68:	5e                   	pop    %esi
80100c69:	5f                   	pop    %edi
80100c6a:	5d                   	pop    %ebp
80100c6b:	c3                   	ret    
80100c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100c70:	81 bd a4 fc ff ff 7f 	cmpl   $0x464c457f,-0x35c(%ebp)
80100c77:	45 4c 46 
80100c7a:	0f 85 1d ff ff ff    	jne    80100b9d <exec+0x18d>
  if((pgdir = setupkvm()) == 0)
80100c80:	e8 8b 77 00 00       	call   80108410 <setupkvm>
80100c85:	85 c0                	test   %eax,%eax
80100c87:	89 85 70 fc ff ff    	mov    %eax,-0x390(%ebp)
80100c8d:	0f 84 0a ff ff ff    	je     80100b9d <exec+0x18d>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c93:	66 83 bd d0 fc ff ff 	cmpw   $0x0,-0x330(%ebp)
80100c9a:	00 
80100c9b:	8b 85 c0 fc ff ff    	mov    -0x340(%ebp),%eax
80100ca1:	89 85 60 fc ff ff    	mov    %eax,-0x3a0(%ebp)
80100ca7:	0f 84 ca 01 00 00    	je     80100e77 <exec+0x467>
  sz = 0;
80100cad:	31 c0                	xor    %eax,%eax
80100caf:	89 9d 5c fc ff ff    	mov    %ebx,-0x3a4(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cb5:	31 ff                	xor    %edi,%edi
80100cb7:	89 c3                	mov    %eax,%ebx
80100cb9:	eb 7f                	jmp    80100d3a <exec+0x32a>
80100cbb:	90                   	nop
80100cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100cc0:	83 bd 84 fc ff ff 01 	cmpl   $0x1,-0x37c(%ebp)
80100cc7:	75 63                	jne    80100d2c <exec+0x31c>
    if(ph.memsz < ph.filesz)
80100cc9:	8b 85 98 fc ff ff    	mov    -0x368(%ebp),%eax
80100ccf:	3b 85 94 fc ff ff    	cmp    -0x36c(%ebp),%eax
80100cd5:	0f 82 86 00 00 00    	jb     80100d61 <exec+0x351>
80100cdb:	03 85 8c fc ff ff    	add    -0x374(%ebp),%eax
80100ce1:	72 7e                	jb     80100d61 <exec+0x351>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ce3:	83 ec 04             	sub    $0x4,%esp
80100ce6:	50                   	push   %eax
80100ce7:	53                   	push   %ebx
80100ce8:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100cee:	e8 8d 7a 00 00       	call   80108780 <allocuvm>
80100cf3:	83 c4 10             	add    $0x10,%esp
80100cf6:	85 c0                	test   %eax,%eax
80100cf8:	89 c3                	mov    %eax,%ebx
80100cfa:	74 65                	je     80100d61 <exec+0x351>
    if(ph.vaddr % PGSIZE != 0)
80100cfc:	8b 85 8c fc ff ff    	mov    -0x374(%ebp),%eax
80100d02:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d07:	75 58                	jne    80100d61 <exec+0x351>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d09:	83 ec 0c             	sub    $0xc,%esp
80100d0c:	ff b5 94 fc ff ff    	pushl  -0x36c(%ebp)
80100d12:	ff b5 88 fc ff ff    	pushl  -0x378(%ebp)
80100d18:	56                   	push   %esi
80100d19:	50                   	push   %eax
80100d1a:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100d20:	e8 6b 6d 00 00       	call   80107a90 <loaduvm>
80100d25:	83 c4 20             	add    $0x20,%esp
80100d28:	85 c0                	test   %eax,%eax
80100d2a:	78 35                	js     80100d61 <exec+0x351>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d2c:	0f b7 85 d0 fc ff ff 	movzwl -0x330(%ebp),%eax
80100d33:	83 c7 01             	add    $0x1,%edi
80100d36:	39 f8                	cmp    %edi,%eax
80100d38:	7e 32                	jle    80100d6c <exec+0x35c>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d3a:	89 f8                	mov    %edi,%eax
80100d3c:	6a 20                	push   $0x20
80100d3e:	c1 e0 05             	shl    $0x5,%eax
80100d41:	03 85 60 fc ff ff    	add    -0x3a0(%ebp),%eax
80100d47:	50                   	push   %eax
80100d48:	8d 85 84 fc ff ff    	lea    -0x37c(%ebp),%eax
80100d4e:	50                   	push   %eax
80100d4f:	56                   	push   %esi
80100d50:	e8 1b 0e 00 00       	call   80101b70 <readi>
80100d55:	83 c4 10             	add    $0x10,%esp
80100d58:	83 f8 20             	cmp    $0x20,%eax
80100d5b:	0f 84 5f ff ff ff    	je     80100cc0 <exec+0x2b0>
80100d61:	8b 9d 5c fc ff ff    	mov    -0x3a4(%ebp),%ebx
80100d67:	e9 31 fe ff ff       	jmp    80100b9d <exec+0x18d>
80100d6c:	89 d8                	mov    %ebx,%eax
80100d6e:	8b 9d 5c fc ff ff    	mov    -0x3a4(%ebp),%ebx
80100d74:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d79:	89 c7                	mov    %eax,%edi
80100d7b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100d81:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100d87:	83 ec 0c             	sub    $0xc,%esp
80100d8a:	89 85 60 fc ff ff    	mov    %eax,-0x3a0(%ebp)
80100d90:	56                   	push   %esi
  ip = 0;
80100d91:	31 f6                	xor    %esi,%esi
  iunlockput(ip);
80100d93:	e8 88 0d 00 00       	call   80101b20 <iunlockput>
  end_op();
80100d98:	e8 03 27 00 00       	call   801034a0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d9d:	8b 85 60 fc ff ff    	mov    -0x3a0(%ebp),%eax
80100da3:	83 c4 0c             	add    $0xc,%esp
80100da6:	50                   	push   %eax
80100da7:	57                   	push   %edi
80100da8:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100dae:	e8 cd 79 00 00       	call   80108780 <allocuvm>
80100db3:	83 c4 10             	add    $0x10,%esp
80100db6:	85 c0                	test   %eax,%eax
80100db8:	89 85 60 fc ff ff    	mov    %eax,-0x3a0(%ebp)
80100dbe:	0f 84 d9 fd ff ff    	je     80100b9d <exec+0x18d>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100dc4:	89 c7                	mov    %eax,%edi
80100dc6:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100dcc:	83 ec 08             	sub    $0x8,%esp
80100dcf:	50                   	push   %eax
80100dd0:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100dd6:	e8 75 6d 00 00       	call   80107b50 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ddb:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dde:	83 c4 10             	add    $0x10,%esp
80100de1:	89 fa                	mov    %edi,%edx
80100de3:	31 ff                	xor    %edi,%edi
80100de5:	8b 00                	mov    (%eax),%eax
80100de7:	85 c0                	test   %eax,%eax
80100de9:	0f 84 65 01 00 00    	je     80100f54 <exec+0x544>
80100def:	89 de                	mov    %ebx,%esi
80100df1:	89 d3                	mov    %edx,%ebx
80100df3:	eb 1f                	jmp    80100e14 <exec+0x404>
80100df5:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100df8:	89 9c bd e4 fc ff ff 	mov    %ebx,-0x31c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dff:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100e02:	8d 95 d8 fc ff ff    	lea    -0x328(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100e08:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100e0b:	85 c0                	test   %eax,%eax
80100e0d:	74 74                	je     80100e83 <exec+0x473>
    if(argc >= MAXARG)
80100e0f:	83 ff 20             	cmp    $0x20,%edi
80100e12:	74 3b                	je     80100e4f <exec+0x43f>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e14:	83 ec 0c             	sub    $0xc,%esp
80100e17:	50                   	push   %eax
80100e18:	e8 b3 47 00 00       	call   801055d0 <strlen>
80100e1d:	f7 d0                	not    %eax
80100e1f:	01 d8                	add    %ebx,%eax
80100e21:	83 e0 fc             	and    $0xfffffffc,%eax
80100e24:	89 c3                	mov    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e26:	58                   	pop    %eax
80100e27:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e2a:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e2d:	e8 9e 47 00 00       	call   801055d0 <strlen>
80100e32:	83 c0 01             	add    $0x1,%eax
80100e35:	50                   	push   %eax
80100e36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e39:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e3c:	53                   	push   %ebx
80100e3d:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100e43:	e8 78 6d 00 00       	call   80107bc0 <copyout>
80100e48:	83 c4 20             	add    $0x20,%esp
80100e4b:	85 c0                	test   %eax,%eax
80100e4d:	79 a6                	jns    80100df5 <exec+0x3e5>
80100e4f:	89 f3                	mov    %esi,%ebx
  ip = 0;
80100e51:	31 f6                	xor    %esi,%esi
80100e53:	e9 45 fd ff ff       	jmp    80100b9d <exec+0x18d>
    end_op();
80100e58:	e8 43 26 00 00       	call   801034a0 <end_op>
    cprintf("exec: fail\n");
80100e5d:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80100e60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    cprintf("exec: fail\n");
80100e65:	68 81 8a 10 80       	push   $0x80108a81
80100e6a:	e8 f1 f7 ff ff       	call   80100660 <cprintf>
    return -1;
80100e6f:	83 c4 10             	add    $0x10,%esp
80100e72:	e9 eb fd ff ff       	jmp    80100c62 <exec+0x252>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e77:	31 ff                	xor    %edi,%edi
80100e79:	b8 00 20 00 00       	mov    $0x2000,%eax
80100e7e:	e9 04 ff ff ff       	jmp    80100d87 <exec+0x377>
80100e83:	89 d0                	mov    %edx,%eax
80100e85:	89 da                	mov    %ebx,%edx
80100e87:	89 f3                	mov    %esi,%ebx
80100e89:	89 c6                	mov    %eax,%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e8b:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100e92:	89 d1                	mov    %edx,%ecx
  ustack[3+argc] = 0;
80100e94:	c7 84 bd e4 fc ff ff 	movl   $0x0,-0x31c(%ebp,%edi,4)
80100e9b:	00 00 00 00 
  ustack[1] = argc;
80100e9f:	89 bd dc fc ff ff    	mov    %edi,-0x324(%ebp)
  sp -= (3+argc+1) * 4;
80100ea5:	89 d7                	mov    %edx,%edi
  ustack[0] = 0xffffffff;  // fake return PC
80100ea7:	c7 85 d8 fc ff ff ff 	movl   $0xffffffff,-0x328(%ebp)
80100eae:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100eb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100eb3:	83 c0 0c             	add    $0xc,%eax
80100eb6:	29 c7                	sub    %eax,%edi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100eb8:	50                   	push   %eax
80100eb9:	56                   	push   %esi
80100eba:	57                   	push   %edi
80100ebb:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ec1:	89 8d e0 fc ff ff    	mov    %ecx,-0x320(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ec7:	e8 f4 6c 00 00       	call   80107bc0 <copyout>
80100ecc:	83 c4 10             	add    $0x10,%esp
80100ecf:	85 c0                	test   %eax,%eax
80100ed1:	78 7a                	js     80100f4d <exec+0x53d>
  for(last=s=path; *s; s++)
80100ed3:	8b 45 08             	mov    0x8(%ebp),%eax
80100ed6:	0f b6 00             	movzbl (%eax),%eax
80100ed9:	84 c0                	test   %al,%al
80100edb:	74 17                	je     80100ef4 <exec+0x4e4>
80100edd:	8b 55 08             	mov    0x8(%ebp),%edx
80100ee0:	89 d1                	mov    %edx,%ecx
80100ee2:	83 c1 01             	add    $0x1,%ecx
80100ee5:	3c 2f                	cmp    $0x2f,%al
80100ee7:	0f b6 01             	movzbl (%ecx),%eax
80100eea:	0f 44 d1             	cmove  %ecx,%edx
80100eed:	84 c0                	test   %al,%al
80100eef:	75 f1                	jne    80100ee2 <exec+0x4d2>
80100ef1:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100ef4:	8b 9d 74 fc ff ff    	mov    -0x38c(%ebp),%ebx
80100efa:	83 ec 04             	sub    $0x4,%esp
80100efd:	6a 10                	push   $0x10
80100eff:	ff 75 08             	pushl  0x8(%ebp)
80100f02:	89 d8                	mov    %ebx,%eax
80100f04:	83 c0 6c             	add    $0x6c,%eax
80100f07:	50                   	push   %eax
80100f08:	e8 83 46 00 00       	call   80105590 <safestrcpy>
  curproc->pgdir = pgdir;
80100f0d:	8b 8d 70 fc ff ff    	mov    -0x390(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100f13:	8b 73 04             	mov    0x4(%ebx),%esi
  curproc->tf->eip = elf.entry;  // main
80100f16:	8b 43 18             	mov    0x18(%ebx),%eax
  curproc->pgdir = pgdir;
80100f19:	89 4b 04             	mov    %ecx,0x4(%ebx)
  curproc->sz = sz;
80100f1c:	8b 8d 60 fc ff ff    	mov    -0x3a0(%ebp),%ecx
80100f22:	89 0b                	mov    %ecx,(%ebx)
  curproc->tf->eip = elf.entry;  // main
80100f24:	8b 95 bc fc ff ff    	mov    -0x344(%ebp),%edx
80100f2a:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f2d:	8b 43 18             	mov    0x18(%ebx),%eax
80100f30:	89 78 44             	mov    %edi,0x44(%eax)
  switchuvm(curproc);
80100f33:	89 1c 24             	mov    %ebx,(%esp)
  return 0;
80100f36:	31 db                	xor    %ebx,%ebx
  switchuvm(curproc);
80100f38:	e8 c3 69 00 00       	call   80107900 <switchuvm>
  freevm(oldpgdir);
80100f3d:	89 34 24             	mov    %esi,(%esp)
80100f40:	e8 4b 74 00 00       	call   80108390 <freevm>
  return 0;
80100f45:	83 c4 10             	add    $0x10,%esp
80100f48:	e9 15 fd ff ff       	jmp    80100c62 <exec+0x252>
  ip = 0;
80100f4d:	31 f6                	xor    %esi,%esi
80100f4f:	e9 49 fc ff ff       	jmp    80100b9d <exec+0x18d>
  for(argc = 0; argv[argc]; argc++) {
80100f54:	8b 95 60 fc ff ff    	mov    -0x3a0(%ebp),%edx
80100f5a:	8d b5 d8 fc ff ff    	lea    -0x328(%ebp),%esi
80100f60:	e9 26 ff ff ff       	jmp    80100e8b <exec+0x47b>
80100f65:	66 90                	xchg   %ax,%ax
80100f67:	66 90                	xchg   %ax,%ax
80100f69:	66 90                	xchg   %ax,%ax
80100f6b:	66 90                	xchg   %ax,%ax
80100f6d:	66 90                	xchg   %ax,%ax
80100f6f:	90                   	nop

80100f70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f76:	68 8d 8a 10 80       	push   $0x80108a8d
80100f7b:	68 c0 1f 11 80       	push   $0x80111fc0
80100f80:	e8 db 41 00 00       	call   80105160 <initlock>
}
80100f85:	83 c4 10             	add    $0x10,%esp
80100f88:	c9                   	leave  
80100f89:	c3                   	ret    
80100f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f94:	bb f4 1f 11 80       	mov    $0x80111ff4,%ebx
{
80100f99:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f9c:	68 c0 1f 11 80       	push   $0x80111fc0
80100fa1:	e8 fa 42 00 00       	call   801052a0 <acquire>
80100fa6:	83 c4 10             	add    $0x10,%esp
80100fa9:	eb 10                	jmp    80100fbb <filealloc+0x2b>
80100fab:	90                   	nop
80100fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fb0:	83 c3 18             	add    $0x18,%ebx
80100fb3:	81 fb 54 29 11 80    	cmp    $0x80112954,%ebx
80100fb9:	73 25                	jae    80100fe0 <filealloc+0x50>
    if(f->ref == 0){
80100fbb:	8b 43 04             	mov    0x4(%ebx),%eax
80100fbe:	85 c0                	test   %eax,%eax
80100fc0:	75 ee                	jne    80100fb0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100fc2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100fc5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100fcc:	68 c0 1f 11 80       	push   $0x80111fc0
80100fd1:	e8 8a 43 00 00       	call   80105360 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100fd6:	89 d8                	mov    %ebx,%eax
      return f;
80100fd8:	83 c4 10             	add    $0x10,%esp
}
80100fdb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fde:	c9                   	leave  
80100fdf:	c3                   	ret    
  release(&ftable.lock);
80100fe0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100fe3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100fe5:	68 c0 1f 11 80       	push   $0x80111fc0
80100fea:	e8 71 43 00 00       	call   80105360 <release>
}
80100fef:	89 d8                	mov    %ebx,%eax
  return 0;
80100ff1:	83 c4 10             	add    $0x10,%esp
}
80100ff4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ff7:	c9                   	leave  
80100ff8:	c3                   	ret    
80100ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101000 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	53                   	push   %ebx
80101004:	83 ec 10             	sub    $0x10,%esp
80101007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010100a:	68 c0 1f 11 80       	push   $0x80111fc0
8010100f:	e8 8c 42 00 00       	call   801052a0 <acquire>
  if(f->ref < 1)
80101014:	8b 43 04             	mov    0x4(%ebx),%eax
80101017:	83 c4 10             	add    $0x10,%esp
8010101a:	85 c0                	test   %eax,%eax
8010101c:	7e 1a                	jle    80101038 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010101e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101021:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101024:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101027:	68 c0 1f 11 80       	push   $0x80111fc0
8010102c:	e8 2f 43 00 00       	call   80105360 <release>
  return f;
}
80101031:	89 d8                	mov    %ebx,%eax
80101033:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101036:	c9                   	leave  
80101037:	c3                   	ret    
    panic("filedup");
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	68 94 8a 10 80       	push   $0x80108a94
80101040:	e8 4b f3 ff ff       	call   80100390 <panic>
80101045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101050 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	57                   	push   %edi
80101054:	56                   	push   %esi
80101055:	53                   	push   %ebx
80101056:	83 ec 28             	sub    $0x28,%esp
80101059:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010105c:	68 c0 1f 11 80       	push   $0x80111fc0
80101061:	e8 3a 42 00 00       	call   801052a0 <acquire>
  if(f->ref < 1)
80101066:	8b 43 04             	mov    0x4(%ebx),%eax
80101069:	83 c4 10             	add    $0x10,%esp
8010106c:	85 c0                	test   %eax,%eax
8010106e:	0f 8e 9b 00 00 00    	jle    8010110f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101074:	83 e8 01             	sub    $0x1,%eax
80101077:	85 c0                	test   %eax,%eax
80101079:	89 43 04             	mov    %eax,0x4(%ebx)
8010107c:	74 1a                	je     80101098 <fileclose+0x48>
    release(&ftable.lock);
8010107e:	c7 45 08 c0 1f 11 80 	movl   $0x80111fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101085:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101088:	5b                   	pop    %ebx
80101089:	5e                   	pop    %esi
8010108a:	5f                   	pop    %edi
8010108b:	5d                   	pop    %ebp
    release(&ftable.lock);
8010108c:	e9 cf 42 00 00       	jmp    80105360 <release>
80101091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80101098:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
8010109c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
8010109e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801010a1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
801010a4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801010aa:	88 45 e7             	mov    %al,-0x19(%ebp)
801010ad:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801010b0:	68 c0 1f 11 80       	push   $0x80111fc0
  ff = *f;
801010b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801010b8:	e8 a3 42 00 00       	call   80105360 <release>
  if(ff.type == FD_PIPE)
801010bd:	83 c4 10             	add    $0x10,%esp
801010c0:	83 ff 01             	cmp    $0x1,%edi
801010c3:	74 13                	je     801010d8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
801010c5:	83 ff 02             	cmp    $0x2,%edi
801010c8:	74 26                	je     801010f0 <fileclose+0xa0>
}
801010ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010cd:	5b                   	pop    %ebx
801010ce:	5e                   	pop    %esi
801010cf:	5f                   	pop    %edi
801010d0:	5d                   	pop    %ebp
801010d1:	c3                   	ret    
801010d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
801010d8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801010dc:	83 ec 08             	sub    $0x8,%esp
801010df:	53                   	push   %ebx
801010e0:	56                   	push   %esi
801010e1:	e8 fa 2a 00 00       	call   80103be0 <pipeclose>
801010e6:	83 c4 10             	add    $0x10,%esp
801010e9:	eb df                	jmp    801010ca <fileclose+0x7a>
801010eb:	90                   	nop
801010ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
801010f0:	e8 3b 23 00 00       	call   80103430 <begin_op>
    iput(ff.ip);
801010f5:	83 ec 0c             	sub    $0xc,%esp
801010f8:	ff 75 e0             	pushl  -0x20(%ebp)
801010fb:	e8 c0 08 00 00       	call   801019c0 <iput>
    end_op();
80101100:	83 c4 10             	add    $0x10,%esp
}
80101103:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101106:	5b                   	pop    %ebx
80101107:	5e                   	pop    %esi
80101108:	5f                   	pop    %edi
80101109:	5d                   	pop    %ebp
    end_op();
8010110a:	e9 91 23 00 00       	jmp    801034a0 <end_op>
    panic("fileclose");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 9c 8a 10 80       	push   $0x80108a9c
80101117:	e8 74 f2 ff ff       	call   80100390 <panic>
8010111c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101120 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	53                   	push   %ebx
80101124:	83 ec 04             	sub    $0x4,%esp
80101127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010112a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010112d:	75 31                	jne    80101160 <filestat+0x40>
    ilock(f->ip);
8010112f:	83 ec 0c             	sub    $0xc,%esp
80101132:	ff 73 10             	pushl  0x10(%ebx)
80101135:	e8 56 07 00 00       	call   80101890 <ilock>
    stati(f->ip, st);
8010113a:	58                   	pop    %eax
8010113b:	5a                   	pop    %edx
8010113c:	ff 75 0c             	pushl  0xc(%ebp)
8010113f:	ff 73 10             	pushl  0x10(%ebx)
80101142:	e8 f9 09 00 00       	call   80101b40 <stati>
    iunlock(f->ip);
80101147:	59                   	pop    %ecx
80101148:	ff 73 10             	pushl  0x10(%ebx)
8010114b:	e8 20 08 00 00       	call   80101970 <iunlock>
    return 0;
80101150:	83 c4 10             	add    $0x10,%esp
80101153:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101158:	c9                   	leave  
80101159:	c3                   	ret    
8010115a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101165:	eb ee                	jmp    80101155 <filestat+0x35>
80101167:	89 f6                	mov    %esi,%esi
80101169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101170 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101170:	55                   	push   %ebp
80101171:	89 e5                	mov    %esp,%ebp
80101173:	57                   	push   %edi
80101174:	56                   	push   %esi
80101175:	53                   	push   %ebx
80101176:	83 ec 0c             	sub    $0xc,%esp
80101179:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010117c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010117f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101182:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101186:	74 60                	je     801011e8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101188:	8b 03                	mov    (%ebx),%eax
8010118a:	83 f8 01             	cmp    $0x1,%eax
8010118d:	74 41                	je     801011d0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010118f:	83 f8 02             	cmp    $0x2,%eax
80101192:	75 5b                	jne    801011ef <fileread+0x7f>
    ilock(f->ip);
80101194:	83 ec 0c             	sub    $0xc,%esp
80101197:	ff 73 10             	pushl  0x10(%ebx)
8010119a:	e8 f1 06 00 00       	call   80101890 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010119f:	57                   	push   %edi
801011a0:	ff 73 14             	pushl  0x14(%ebx)
801011a3:	56                   	push   %esi
801011a4:	ff 73 10             	pushl  0x10(%ebx)
801011a7:	e8 c4 09 00 00       	call   80101b70 <readi>
801011ac:	83 c4 20             	add    $0x20,%esp
801011af:	85 c0                	test   %eax,%eax
801011b1:	89 c6                	mov    %eax,%esi
801011b3:	7e 03                	jle    801011b8 <fileread+0x48>
      f->off += r;
801011b5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801011b8:	83 ec 0c             	sub    $0xc,%esp
801011bb:	ff 73 10             	pushl  0x10(%ebx)
801011be:	e8 ad 07 00 00       	call   80101970 <iunlock>
    return r;
801011c3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801011c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011c9:	89 f0                	mov    %esi,%eax
801011cb:	5b                   	pop    %ebx
801011cc:	5e                   	pop    %esi
801011cd:	5f                   	pop    %edi
801011ce:	5d                   	pop    %ebp
801011cf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
801011d0:	8b 43 0c             	mov    0xc(%ebx),%eax
801011d3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011d9:	5b                   	pop    %ebx
801011da:	5e                   	pop    %esi
801011db:	5f                   	pop    %edi
801011dc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801011dd:	e9 ae 2b 00 00       	jmp    80103d90 <piperead>
801011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011e8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011ed:	eb d7                	jmp    801011c6 <fileread+0x56>
  panic("fileread");
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	68 a6 8a 10 80       	push   $0x80108aa6
801011f7:	e8 94 f1 ff ff       	call   80100390 <panic>
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101200 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	83 ec 1c             	sub    $0x1c,%esp
80101209:	8b 75 08             	mov    0x8(%ebp),%esi
8010120c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010120f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101213:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101216:	8b 45 10             	mov    0x10(%ebp),%eax
80101219:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010121c:	0f 84 aa 00 00 00    	je     801012cc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101222:	8b 06                	mov    (%esi),%eax
80101224:	83 f8 01             	cmp    $0x1,%eax
80101227:	0f 84 c3 00 00 00    	je     801012f0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010122d:	83 f8 02             	cmp    $0x2,%eax
80101230:	0f 85 d9 00 00 00    	jne    8010130f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101236:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101239:	31 ff                	xor    %edi,%edi
    while(i < n){
8010123b:	85 c0                	test   %eax,%eax
8010123d:	7f 34                	jg     80101273 <filewrite+0x73>
8010123f:	e9 9c 00 00 00       	jmp    801012e0 <filewrite+0xe0>
80101244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101248:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010124b:	83 ec 0c             	sub    $0xc,%esp
8010124e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101251:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101254:	e8 17 07 00 00       	call   80101970 <iunlock>
      end_op();
80101259:	e8 42 22 00 00       	call   801034a0 <end_op>
8010125e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101261:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101264:	39 c3                	cmp    %eax,%ebx
80101266:	0f 85 96 00 00 00    	jne    80101302 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010126c:	01 df                	add    %ebx,%edi
    while(i < n){
8010126e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101271:	7e 6d                	jle    801012e0 <filewrite+0xe0>
      int n1 = n - i;
80101273:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101276:	b8 00 06 00 00       	mov    $0x600,%eax
8010127b:	29 fb                	sub    %edi,%ebx
8010127d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101283:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101286:	e8 a5 21 00 00       	call   80103430 <begin_op>
      ilock(f->ip);
8010128b:	83 ec 0c             	sub    $0xc,%esp
8010128e:	ff 76 10             	pushl  0x10(%esi)
80101291:	e8 fa 05 00 00       	call   80101890 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101296:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101299:	53                   	push   %ebx
8010129a:	ff 76 14             	pushl  0x14(%esi)
8010129d:	01 f8                	add    %edi,%eax
8010129f:	50                   	push   %eax
801012a0:	ff 76 10             	pushl  0x10(%esi)
801012a3:	e8 c8 09 00 00       	call   80101c70 <writei>
801012a8:	83 c4 20             	add    $0x20,%esp
801012ab:	85 c0                	test   %eax,%eax
801012ad:	7f 99                	jg     80101248 <filewrite+0x48>
      iunlock(f->ip);
801012af:	83 ec 0c             	sub    $0xc,%esp
801012b2:	ff 76 10             	pushl  0x10(%esi)
801012b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012b8:	e8 b3 06 00 00       	call   80101970 <iunlock>
      end_op();
801012bd:	e8 de 21 00 00       	call   801034a0 <end_op>
      if(r < 0)
801012c2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801012c5:	83 c4 10             	add    $0x10,%esp
801012c8:	85 c0                	test   %eax,%eax
801012ca:	74 98                	je     80101264 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801012cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801012cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801012d4:	89 f8                	mov    %edi,%eax
801012d6:	5b                   	pop    %ebx
801012d7:	5e                   	pop    %esi
801012d8:	5f                   	pop    %edi
801012d9:	5d                   	pop    %ebp
801012da:	c3                   	ret    
801012db:	90                   	nop
801012dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801012e0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801012e3:	75 e7                	jne    801012cc <filewrite+0xcc>
}
801012e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e8:	89 f8                	mov    %edi,%eax
801012ea:	5b                   	pop    %ebx
801012eb:	5e                   	pop    %esi
801012ec:	5f                   	pop    %edi
801012ed:	5d                   	pop    %ebp
801012ee:	c3                   	ret    
801012ef:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801012f0:	8b 46 0c             	mov    0xc(%esi),%eax
801012f3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801012f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012f9:	5b                   	pop    %ebx
801012fa:	5e                   	pop    %esi
801012fb:	5f                   	pop    %edi
801012fc:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801012fd:	e9 7e 29 00 00       	jmp    80103c80 <pipewrite>
        panic("short filewrite");
80101302:	83 ec 0c             	sub    $0xc,%esp
80101305:	68 af 8a 10 80       	push   $0x80108aaf
8010130a:	e8 81 f0 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010130f:	83 ec 0c             	sub    $0xc,%esp
80101312:	68 b5 8a 10 80       	push   $0x80108ab5
80101317:	e8 74 f0 ff ff       	call   80100390 <panic>
8010131c:	66 90                	xchg   %ax,%ax
8010131e:	66 90                	xchg   %ax,%ax

80101320 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101320:	55                   	push   %ebp
80101321:	89 e5                	mov    %esp,%ebp
80101323:	56                   	push   %esi
80101324:	53                   	push   %ebx
80101325:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101327:	c1 ea 0c             	shr    $0xc,%edx
8010132a:	03 15 d8 29 11 80    	add    0x801129d8,%edx
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010133a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010133c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010133f:	ba 01 00 00 00       	mov    $0x1,%edx
80101344:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101347:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010134d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101350:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101352:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101357:	85 d1                	test   %edx,%ecx
80101359:	74 25                	je     80101380 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010135b:	f7 d2                	not    %edx
8010135d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010135f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101362:	21 ca                	and    %ecx,%edx
80101364:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101368:	56                   	push   %esi
80101369:	e8 92 22 00 00       	call   80103600 <log_write>
  brelse(bp);
8010136e:	89 34 24             	mov    %esi,(%esp)
80101371:	e8 6a ee ff ff       	call   801001e0 <brelse>
}
80101376:	83 c4 10             	add    $0x10,%esp
80101379:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010137c:	5b                   	pop    %ebx
8010137d:	5e                   	pop    %esi
8010137e:	5d                   	pop    %ebp
8010137f:	c3                   	ret    
    panic("freeing free block");
80101380:	83 ec 0c             	sub    $0xc,%esp
80101383:	68 bf 8a 10 80       	push   $0x80108abf
80101388:	e8 03 f0 ff ff       	call   80100390 <panic>
8010138d:	8d 76 00             	lea    0x0(%esi),%esi

80101390 <balloc>:
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	57                   	push   %edi
80101394:	56                   	push   %esi
80101395:	53                   	push   %ebx
80101396:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101399:	8b 0d c0 29 11 80    	mov    0x801129c0,%ecx
{
8010139f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013a2:	85 c9                	test   %ecx,%ecx
801013a4:	0f 84 87 00 00 00    	je     80101431 <balloc+0xa1>
801013aa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801013b1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801013b4:	83 ec 08             	sub    $0x8,%esp
801013b7:	89 f0                	mov    %esi,%eax
801013b9:	c1 f8 0c             	sar    $0xc,%eax
801013bc:	03 05 d8 29 11 80    	add    0x801129d8,%eax
801013c2:	50                   	push   %eax
801013c3:	ff 75 d8             	pushl  -0x28(%ebp)
801013c6:	e8 05 ed ff ff       	call   801000d0 <bread>
801013cb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013ce:	a1 c0 29 11 80       	mov    0x801129c0,%eax
801013d3:	83 c4 10             	add    $0x10,%esp
801013d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013d9:	31 c0                	xor    %eax,%eax
801013db:	eb 2f                	jmp    8010140c <balloc+0x7c>
801013dd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801013e0:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013e2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
801013e5:	bb 01 00 00 00       	mov    $0x1,%ebx
801013ea:	83 e1 07             	and    $0x7,%ecx
801013ed:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801013ef:	89 c1                	mov    %eax,%ecx
801013f1:	c1 f9 03             	sar    $0x3,%ecx
801013f4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801013f9:	85 df                	test   %ebx,%edi
801013fb:	89 fa                	mov    %edi,%edx
801013fd:	74 41                	je     80101440 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013ff:	83 c0 01             	add    $0x1,%eax
80101402:	83 c6 01             	add    $0x1,%esi
80101405:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010140a:	74 05                	je     80101411 <balloc+0x81>
8010140c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010140f:	77 cf                	ja     801013e0 <balloc+0x50>
    brelse(bp);
80101411:	83 ec 0c             	sub    $0xc,%esp
80101414:	ff 75 e4             	pushl  -0x1c(%ebp)
80101417:	e8 c4 ed ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010141c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101423:	83 c4 10             	add    $0x10,%esp
80101426:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101429:	39 05 c0 29 11 80    	cmp    %eax,0x801129c0
8010142f:	77 80                	ja     801013b1 <balloc+0x21>
  panic("balloc: out of blocks");
80101431:	83 ec 0c             	sub    $0xc,%esp
80101434:	68 d2 8a 10 80       	push   $0x80108ad2
80101439:	e8 52 ef ff ff       	call   80100390 <panic>
8010143e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101440:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101443:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101446:	09 da                	or     %ebx,%edx
80101448:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010144c:	57                   	push   %edi
8010144d:	e8 ae 21 00 00       	call   80103600 <log_write>
        brelse(bp);
80101452:	89 3c 24             	mov    %edi,(%esp)
80101455:	e8 86 ed ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010145a:	58                   	pop    %eax
8010145b:	5a                   	pop    %edx
8010145c:	56                   	push   %esi
8010145d:	ff 75 d8             	pushl  -0x28(%ebp)
80101460:	e8 6b ec ff ff       	call   801000d0 <bread>
80101465:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101467:	8d 40 5c             	lea    0x5c(%eax),%eax
8010146a:	83 c4 0c             	add    $0xc,%esp
8010146d:	68 00 02 00 00       	push   $0x200
80101472:	6a 00                	push   $0x0
80101474:	50                   	push   %eax
80101475:	e8 36 3f 00 00       	call   801053b0 <memset>
  log_write(bp);
8010147a:	89 1c 24             	mov    %ebx,(%esp)
8010147d:	e8 7e 21 00 00       	call   80103600 <log_write>
  brelse(bp);
80101482:	89 1c 24             	mov    %ebx,(%esp)
80101485:	e8 56 ed ff ff       	call   801001e0 <brelse>
}
8010148a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010148d:	89 f0                	mov    %esi,%eax
8010148f:	5b                   	pop    %ebx
80101490:	5e                   	pop    %esi
80101491:	5f                   	pop    %edi
80101492:	5d                   	pop    %ebp
80101493:	c3                   	ret    
80101494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010149a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801014a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	57                   	push   %edi
801014a4:	56                   	push   %esi
801014a5:	53                   	push   %ebx
801014a6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801014a8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014aa:	bb 14 2a 11 80       	mov    $0x80112a14,%ebx
{
801014af:	83 ec 28             	sub    $0x28,%esp
801014b2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801014b5:	68 e0 29 11 80       	push   $0x801129e0
801014ba:	e8 e1 3d 00 00       	call   801052a0 <acquire>
801014bf:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014c2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014c5:	eb 17                	jmp    801014de <iget+0x3e>
801014c7:	89 f6                	mov    %esi,%esi
801014c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801014d0:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014d6:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
801014dc:	73 22                	jae    80101500 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014de:	8b 4b 08             	mov    0x8(%ebx),%ecx
801014e1:	85 c9                	test   %ecx,%ecx
801014e3:	7e 04                	jle    801014e9 <iget+0x49>
801014e5:	39 3b                	cmp    %edi,(%ebx)
801014e7:	74 4f                	je     80101538 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801014e9:	85 f6                	test   %esi,%esi
801014eb:	75 e3                	jne    801014d0 <iget+0x30>
801014ed:	85 c9                	test   %ecx,%ecx
801014ef:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014f2:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014f8:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
801014fe:	72 de                	jb     801014de <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101500:	85 f6                	test   %esi,%esi
80101502:	74 5b                	je     8010155f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101504:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101507:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101509:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010150c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101513:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010151a:	68 e0 29 11 80       	push   $0x801129e0
8010151f:	e8 3c 3e 00 00       	call   80105360 <release>

  return ip;
80101524:	83 c4 10             	add    $0x10,%esp
}
80101527:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010152a:	89 f0                	mov    %esi,%eax
8010152c:	5b                   	pop    %ebx
8010152d:	5e                   	pop    %esi
8010152e:	5f                   	pop    %edi
8010152f:	5d                   	pop    %ebp
80101530:	c3                   	ret    
80101531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101538:	39 53 04             	cmp    %edx,0x4(%ebx)
8010153b:	75 ac                	jne    801014e9 <iget+0x49>
      release(&icache.lock);
8010153d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101540:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101543:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101545:	68 e0 29 11 80       	push   $0x801129e0
      ip->ref++;
8010154a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010154d:	e8 0e 3e 00 00       	call   80105360 <release>
      return ip;
80101552:	83 c4 10             	add    $0x10,%esp
}
80101555:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101558:	89 f0                	mov    %esi,%eax
8010155a:	5b                   	pop    %ebx
8010155b:	5e                   	pop    %esi
8010155c:	5f                   	pop    %edi
8010155d:	5d                   	pop    %ebp
8010155e:	c3                   	ret    
    panic("iget: no inodes");
8010155f:	83 ec 0c             	sub    $0xc,%esp
80101562:	68 e8 8a 10 80       	push   $0x80108ae8
80101567:	e8 24 ee ff ff       	call   80100390 <panic>
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101570 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	89 c6                	mov    %eax,%esi
80101578:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010157b:	83 fa 0b             	cmp    $0xb,%edx
8010157e:	77 18                	ja     80101598 <bmap+0x28>
80101580:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101583:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101586:	85 db                	test   %ebx,%ebx
80101588:	74 76                	je     80101600 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010158a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010158d:	89 d8                	mov    %ebx,%eax
8010158f:	5b                   	pop    %ebx
80101590:	5e                   	pop    %esi
80101591:	5f                   	pop    %edi
80101592:	5d                   	pop    %ebp
80101593:	c3                   	ret    
80101594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101598:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010159b:	83 fb 7f             	cmp    $0x7f,%ebx
8010159e:	0f 87 90 00 00 00    	ja     80101634 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801015a4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801015aa:	8b 00                	mov    (%eax),%eax
801015ac:	85 d2                	test   %edx,%edx
801015ae:	74 70                	je     80101620 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801015b0:	83 ec 08             	sub    $0x8,%esp
801015b3:	52                   	push   %edx
801015b4:	50                   	push   %eax
801015b5:	e8 16 eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801015ba:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801015be:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801015c1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801015c3:	8b 1a                	mov    (%edx),%ebx
801015c5:	85 db                	test   %ebx,%ebx
801015c7:	75 1d                	jne    801015e6 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801015c9:	8b 06                	mov    (%esi),%eax
801015cb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801015ce:	e8 bd fd ff ff       	call   80101390 <balloc>
801015d3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
801015d6:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801015d9:	89 c3                	mov    %eax,%ebx
801015db:	89 02                	mov    %eax,(%edx)
      log_write(bp);
801015dd:	57                   	push   %edi
801015de:	e8 1d 20 00 00       	call   80103600 <log_write>
801015e3:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801015e6:	83 ec 0c             	sub    $0xc,%esp
801015e9:	57                   	push   %edi
801015ea:	e8 f1 eb ff ff       	call   801001e0 <brelse>
801015ef:	83 c4 10             	add    $0x10,%esp
}
801015f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015f5:	89 d8                	mov    %ebx,%eax
801015f7:	5b                   	pop    %ebx
801015f8:	5e                   	pop    %esi
801015f9:	5f                   	pop    %edi
801015fa:	5d                   	pop    %ebp
801015fb:	c3                   	ret    
801015fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101600:	8b 00                	mov    (%eax),%eax
80101602:	e8 89 fd ff ff       	call   80101390 <balloc>
80101607:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010160a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010160d:	89 c3                	mov    %eax,%ebx
}
8010160f:	89 d8                	mov    %ebx,%eax
80101611:	5b                   	pop    %ebx
80101612:	5e                   	pop    %esi
80101613:	5f                   	pop    %edi
80101614:	5d                   	pop    %ebp
80101615:	c3                   	ret    
80101616:	8d 76 00             	lea    0x0(%esi),%esi
80101619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101620:	e8 6b fd ff ff       	call   80101390 <balloc>
80101625:	89 c2                	mov    %eax,%edx
80101627:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010162d:	8b 06                	mov    (%esi),%eax
8010162f:	e9 7c ff ff ff       	jmp    801015b0 <bmap+0x40>
  panic("bmap: out of range");
80101634:	83 ec 0c             	sub    $0xc,%esp
80101637:	68 f8 8a 10 80       	push   $0x80108af8
8010163c:	e8 4f ed ff ff       	call   80100390 <panic>
80101641:	eb 0d                	jmp    80101650 <readsb>
80101643:	90                   	nop
80101644:	90                   	nop
80101645:	90                   	nop
80101646:	90                   	nop
80101647:	90                   	nop
80101648:	90                   	nop
80101649:	90                   	nop
8010164a:	90                   	nop
8010164b:	90                   	nop
8010164c:	90                   	nop
8010164d:	90                   	nop
8010164e:	90                   	nop
8010164f:	90                   	nop

80101650 <readsb>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	56                   	push   %esi
80101654:	53                   	push   %ebx
80101655:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101658:	83 ec 08             	sub    $0x8,%esp
8010165b:	6a 01                	push   $0x1
8010165d:	ff 75 08             	pushl  0x8(%ebp)
80101660:	e8 6b ea ff ff       	call   801000d0 <bread>
80101665:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101667:	8d 40 5c             	lea    0x5c(%eax),%eax
8010166a:	83 c4 0c             	add    $0xc,%esp
8010166d:	6a 1c                	push   $0x1c
8010166f:	50                   	push   %eax
80101670:	56                   	push   %esi
80101671:	e8 ea 3d 00 00       	call   80105460 <memmove>
  brelse(bp);
80101676:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101679:	83 c4 10             	add    $0x10,%esp
}
8010167c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010167f:	5b                   	pop    %ebx
80101680:	5e                   	pop    %esi
80101681:	5d                   	pop    %ebp
  brelse(bp);
80101682:	e9 59 eb ff ff       	jmp    801001e0 <brelse>
80101687:	89 f6                	mov    %esi,%esi
80101689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101690 <iinit>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	53                   	push   %ebx
80101694:	bb 20 2a 11 80       	mov    $0x80112a20,%ebx
80101699:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010169c:	68 0b 8b 10 80       	push   $0x80108b0b
801016a1:	68 e0 29 11 80       	push   $0x801129e0
801016a6:	e8 b5 3a 00 00       	call   80105160 <initlock>
801016ab:	83 c4 10             	add    $0x10,%esp
801016ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016b0:	83 ec 08             	sub    $0x8,%esp
801016b3:	68 12 8b 10 80       	push   $0x80108b12
801016b8:	53                   	push   %ebx
801016b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016bf:	e8 6c 39 00 00       	call   80105030 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801016c4:	83 c4 10             	add    $0x10,%esp
801016c7:	81 fb 40 46 11 80    	cmp    $0x80114640,%ebx
801016cd:	75 e1                	jne    801016b0 <iinit+0x20>
  readsb(dev, &sb);
801016cf:	83 ec 08             	sub    $0x8,%esp
801016d2:	68 c0 29 11 80       	push   $0x801129c0
801016d7:	ff 75 08             	pushl  0x8(%ebp)
801016da:	e8 71 ff ff ff       	call   80101650 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016df:	ff 35 d8 29 11 80    	pushl  0x801129d8
801016e5:	ff 35 d4 29 11 80    	pushl  0x801129d4
801016eb:	ff 35 d0 29 11 80    	pushl  0x801129d0
801016f1:	ff 35 cc 29 11 80    	pushl  0x801129cc
801016f7:	ff 35 c8 29 11 80    	pushl  0x801129c8
801016fd:	ff 35 c4 29 11 80    	pushl  0x801129c4
80101703:	ff 35 c0 29 11 80    	pushl  0x801129c0
80101709:	68 bc 8b 10 80       	push   $0x80108bbc
8010170e:	e8 4d ef ff ff       	call   80100660 <cprintf>
}
80101713:	83 c4 30             	add    $0x30,%esp
80101716:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101719:	c9                   	leave  
8010171a:	c3                   	ret    
8010171b:	90                   	nop
8010171c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101720 <ialloc>:
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	57                   	push   %edi
80101724:	56                   	push   %esi
80101725:	53                   	push   %ebx
80101726:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101729:	83 3d c8 29 11 80 01 	cmpl   $0x1,0x801129c8
{
80101730:	8b 45 0c             	mov    0xc(%ebp),%eax
80101733:	8b 75 08             	mov    0x8(%ebp),%esi
80101736:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101739:	0f 86 91 00 00 00    	jbe    801017d0 <ialloc+0xb0>
8010173f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101744:	eb 21                	jmp    80101767 <ialloc+0x47>
80101746:	8d 76 00             	lea    0x0(%esi),%esi
80101749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101750:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101753:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101756:	57                   	push   %edi
80101757:	e8 84 ea ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010175c:	83 c4 10             	add    $0x10,%esp
8010175f:	39 1d c8 29 11 80    	cmp    %ebx,0x801129c8
80101765:	76 69                	jbe    801017d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101767:	89 d8                	mov    %ebx,%eax
80101769:	83 ec 08             	sub    $0x8,%esp
8010176c:	c1 e8 03             	shr    $0x3,%eax
8010176f:	03 05 d4 29 11 80    	add    0x801129d4,%eax
80101775:	50                   	push   %eax
80101776:	56                   	push   %esi
80101777:	e8 54 e9 ff ff       	call   801000d0 <bread>
8010177c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010177e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101780:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101783:	83 e0 07             	and    $0x7,%eax
80101786:	c1 e0 06             	shl    $0x6,%eax
80101789:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010178d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101791:	75 bd                	jne    80101750 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101793:	83 ec 04             	sub    $0x4,%esp
80101796:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101799:	6a 40                	push   $0x40
8010179b:	6a 00                	push   $0x0
8010179d:	51                   	push   %ecx
8010179e:	e8 0d 3c 00 00       	call   801053b0 <memset>
      dip->type = type;
801017a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017ad:	89 3c 24             	mov    %edi,(%esp)
801017b0:	e8 4b 1e 00 00       	call   80103600 <log_write>
      brelse(bp);
801017b5:	89 3c 24             	mov    %edi,(%esp)
801017b8:	e8 23 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801017bd:	83 c4 10             	add    $0x10,%esp
}
801017c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017c3:	89 da                	mov    %ebx,%edx
801017c5:	89 f0                	mov    %esi,%eax
}
801017c7:	5b                   	pop    %ebx
801017c8:	5e                   	pop    %esi
801017c9:	5f                   	pop    %edi
801017ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801017cb:	e9 d0 fc ff ff       	jmp    801014a0 <iget>
  panic("ialloc: no inodes");
801017d0:	83 ec 0c             	sub    $0xc,%esp
801017d3:	68 18 8b 10 80       	push   $0x80108b18
801017d8:	e8 b3 eb ff ff       	call   80100390 <panic>
801017dd:	8d 76 00             	lea    0x0(%esi),%esi

801017e0 <iupdate>:
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	56                   	push   %esi
801017e4:	53                   	push   %ebx
801017e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017e8:	83 ec 08             	sub    $0x8,%esp
801017eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017f1:	c1 e8 03             	shr    $0x3,%eax
801017f4:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801017fa:	50                   	push   %eax
801017fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801017fe:	e8 cd e8 ff ff       	call   801000d0 <bread>
80101803:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101805:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101808:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010180c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010180f:	83 e0 07             	and    $0x7,%eax
80101812:	c1 e0 06             	shl    $0x6,%eax
80101815:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101819:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010181c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101820:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101823:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101827:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010182b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010182f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101833:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101837:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010183a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010183d:	6a 34                	push   $0x34
8010183f:	53                   	push   %ebx
80101840:	50                   	push   %eax
80101841:	e8 1a 3c 00 00       	call   80105460 <memmove>
  log_write(bp);
80101846:	89 34 24             	mov    %esi,(%esp)
80101849:	e8 b2 1d 00 00       	call   80103600 <log_write>
  brelse(bp);
8010184e:	89 75 08             	mov    %esi,0x8(%ebp)
80101851:	83 c4 10             	add    $0x10,%esp
}
80101854:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101857:	5b                   	pop    %ebx
80101858:	5e                   	pop    %esi
80101859:	5d                   	pop    %ebp
  brelse(bp);
8010185a:	e9 81 e9 ff ff       	jmp    801001e0 <brelse>
8010185f:	90                   	nop

80101860 <idup>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	53                   	push   %ebx
80101864:	83 ec 10             	sub    $0x10,%esp
80101867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010186a:	68 e0 29 11 80       	push   $0x801129e0
8010186f:	e8 2c 3a 00 00       	call   801052a0 <acquire>
  ip->ref++;
80101874:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101878:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010187f:	e8 dc 3a 00 00       	call   80105360 <release>
}
80101884:	89 d8                	mov    %ebx,%eax
80101886:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101889:	c9                   	leave  
8010188a:	c3                   	ret    
8010188b:	90                   	nop
8010188c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101890 <ilock>:
{
80101890:	55                   	push   %ebp
80101891:	89 e5                	mov    %esp,%ebp
80101893:	56                   	push   %esi
80101894:	53                   	push   %ebx
80101895:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101898:	85 db                	test   %ebx,%ebx
8010189a:	0f 84 b7 00 00 00    	je     80101957 <ilock+0xc7>
801018a0:	8b 53 08             	mov    0x8(%ebx),%edx
801018a3:	85 d2                	test   %edx,%edx
801018a5:	0f 8e ac 00 00 00    	jle    80101957 <ilock+0xc7>
  acquiresleep(&ip->lock);
801018ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801018ae:	83 ec 0c             	sub    $0xc,%esp
801018b1:	50                   	push   %eax
801018b2:	e8 b9 37 00 00       	call   80105070 <acquiresleep>
  if(ip->valid == 0){
801018b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	85 c0                	test   %eax,%eax
801018bf:	74 0f                	je     801018d0 <ilock+0x40>
}
801018c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018c4:	5b                   	pop    %ebx
801018c5:	5e                   	pop    %esi
801018c6:	5d                   	pop    %ebp
801018c7:	c3                   	ret    
801018c8:	90                   	nop
801018c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018d0:	8b 43 04             	mov    0x4(%ebx),%eax
801018d3:	83 ec 08             	sub    $0x8,%esp
801018d6:	c1 e8 03             	shr    $0x3,%eax
801018d9:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801018df:	50                   	push   %eax
801018e0:	ff 33                	pushl  (%ebx)
801018e2:	e8 e9 e7 ff ff       	call   801000d0 <bread>
801018e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018ef:	83 e0 07             	and    $0x7,%eax
801018f2:	c1 e0 06             	shl    $0x6,%eax
801018f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101903:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101907:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010190b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010190f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101913:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101917:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010191b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010191e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101921:	6a 34                	push   $0x34
80101923:	50                   	push   %eax
80101924:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101927:	50                   	push   %eax
80101928:	e8 33 3b 00 00       	call   80105460 <memmove>
    brelse(bp);
8010192d:	89 34 24             	mov    %esi,(%esp)
80101930:	e8 ab e8 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101935:	83 c4 10             	add    $0x10,%esp
80101938:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010193d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101944:	0f 85 77 ff ff ff    	jne    801018c1 <ilock+0x31>
      panic("ilock: no type");
8010194a:	83 ec 0c             	sub    $0xc,%esp
8010194d:	68 30 8b 10 80       	push   $0x80108b30
80101952:	e8 39 ea ff ff       	call   80100390 <panic>
    panic("ilock");
80101957:	83 ec 0c             	sub    $0xc,%esp
8010195a:	68 2a 8b 10 80       	push   $0x80108b2a
8010195f:	e8 2c ea ff ff       	call   80100390 <panic>
80101964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010196a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101970 <iunlock>:
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	56                   	push   %esi
80101974:	53                   	push   %ebx
80101975:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101978:	85 db                	test   %ebx,%ebx
8010197a:	74 28                	je     801019a4 <iunlock+0x34>
8010197c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010197f:	83 ec 0c             	sub    $0xc,%esp
80101982:	56                   	push   %esi
80101983:	e8 88 37 00 00       	call   80105110 <holdingsleep>
80101988:	83 c4 10             	add    $0x10,%esp
8010198b:	85 c0                	test   %eax,%eax
8010198d:	74 15                	je     801019a4 <iunlock+0x34>
8010198f:	8b 43 08             	mov    0x8(%ebx),%eax
80101992:	85 c0                	test   %eax,%eax
80101994:	7e 0e                	jle    801019a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101996:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101999:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010199c:	5b                   	pop    %ebx
8010199d:	5e                   	pop    %esi
8010199e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010199f:	e9 2c 37 00 00       	jmp    801050d0 <releasesleep>
    panic("iunlock");
801019a4:	83 ec 0c             	sub    $0xc,%esp
801019a7:	68 3f 8b 10 80       	push   $0x80108b3f
801019ac:	e8 df e9 ff ff       	call   80100390 <panic>
801019b1:	eb 0d                	jmp    801019c0 <iput>
801019b3:	90                   	nop
801019b4:	90                   	nop
801019b5:	90                   	nop
801019b6:	90                   	nop
801019b7:	90                   	nop
801019b8:	90                   	nop
801019b9:	90                   	nop
801019ba:	90                   	nop
801019bb:	90                   	nop
801019bc:	90                   	nop
801019bd:	90                   	nop
801019be:	90                   	nop
801019bf:	90                   	nop

801019c0 <iput>:
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	57                   	push   %edi
801019c4:	56                   	push   %esi
801019c5:	53                   	push   %ebx
801019c6:	83 ec 28             	sub    $0x28,%esp
801019c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801019cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801019cf:	57                   	push   %edi
801019d0:	e8 9b 36 00 00       	call   80105070 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019d8:	83 c4 10             	add    $0x10,%esp
801019db:	85 d2                	test   %edx,%edx
801019dd:	74 07                	je     801019e6 <iput+0x26>
801019df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019e4:	74 32                	je     80101a18 <iput+0x58>
  releasesleep(&ip->lock);
801019e6:	83 ec 0c             	sub    $0xc,%esp
801019e9:	57                   	push   %edi
801019ea:	e8 e1 36 00 00       	call   801050d0 <releasesleep>
  acquire(&icache.lock);
801019ef:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801019f6:	e8 a5 38 00 00       	call   801052a0 <acquire>
  ip->ref--;
801019fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019ff:	83 c4 10             	add    $0x10,%esp
80101a02:	c7 45 08 e0 29 11 80 	movl   $0x801129e0,0x8(%ebp)
}
80101a09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a0c:	5b                   	pop    %ebx
80101a0d:	5e                   	pop    %esi
80101a0e:	5f                   	pop    %edi
80101a0f:	5d                   	pop    %ebp
  release(&icache.lock);
80101a10:	e9 4b 39 00 00       	jmp    80105360 <release>
80101a15:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a18:	83 ec 0c             	sub    $0xc,%esp
80101a1b:	68 e0 29 11 80       	push   $0x801129e0
80101a20:	e8 7b 38 00 00       	call   801052a0 <acquire>
    int r = ip->ref;
80101a25:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a28:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101a2f:	e8 2c 39 00 00       	call   80105360 <release>
    if(r == 1){
80101a34:	83 c4 10             	add    $0x10,%esp
80101a37:	83 fe 01             	cmp    $0x1,%esi
80101a3a:	75 aa                	jne    801019e6 <iput+0x26>
80101a3c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a42:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a45:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a48:	89 cf                	mov    %ecx,%edi
80101a4a:	eb 0b                	jmp    80101a57 <iput+0x97>
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a50:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a53:	39 fe                	cmp    %edi,%esi
80101a55:	74 19                	je     80101a70 <iput+0xb0>
    if(ip->addrs[i]){
80101a57:	8b 16                	mov    (%esi),%edx
80101a59:	85 d2                	test   %edx,%edx
80101a5b:	74 f3                	je     80101a50 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a5d:	8b 03                	mov    (%ebx),%eax
80101a5f:	e8 bc f8 ff ff       	call   80101320 <bfree>
      ip->addrs[i] = 0;
80101a64:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a6a:	eb e4                	jmp    80101a50 <iput+0x90>
80101a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a70:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a76:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a79:	85 c0                	test   %eax,%eax
80101a7b:	75 33                	jne    80101ab0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a7d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a80:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a87:	53                   	push   %ebx
80101a88:	e8 53 fd ff ff       	call   801017e0 <iupdate>
      ip->type = 0;
80101a8d:	31 c0                	xor    %eax,%eax
80101a8f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101a93:	89 1c 24             	mov    %ebx,(%esp)
80101a96:	e8 45 fd ff ff       	call   801017e0 <iupdate>
      ip->valid = 0;
80101a9b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101aa2:	83 c4 10             	add    $0x10,%esp
80101aa5:	e9 3c ff ff ff       	jmp    801019e6 <iput+0x26>
80101aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101ab0:	83 ec 08             	sub    $0x8,%esp
80101ab3:	50                   	push   %eax
80101ab4:	ff 33                	pushl  (%ebx)
80101ab6:	e8 15 e6 ff ff       	call   801000d0 <bread>
80101abb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101ac1:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101ac4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101ac7:	8d 70 5c             	lea    0x5c(%eax),%esi
80101aca:	83 c4 10             	add    $0x10,%esp
80101acd:	89 cf                	mov    %ecx,%edi
80101acf:	eb 0e                	jmp    80101adf <iput+0x11f>
80101ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ad8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101adb:	39 fe                	cmp    %edi,%esi
80101add:	74 0f                	je     80101aee <iput+0x12e>
      if(a[j])
80101adf:	8b 16                	mov    (%esi),%edx
80101ae1:	85 d2                	test   %edx,%edx
80101ae3:	74 f3                	je     80101ad8 <iput+0x118>
        bfree(ip->dev, a[j]);
80101ae5:	8b 03                	mov    (%ebx),%eax
80101ae7:	e8 34 f8 ff ff       	call   80101320 <bfree>
80101aec:	eb ea                	jmp    80101ad8 <iput+0x118>
    brelse(bp);
80101aee:	83 ec 0c             	sub    $0xc,%esp
80101af1:	ff 75 e4             	pushl  -0x1c(%ebp)
80101af4:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101af7:	e8 e4 e6 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101afc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101b02:	8b 03                	mov    (%ebx),%eax
80101b04:	e8 17 f8 ff ff       	call   80101320 <bfree>
    ip->addrs[NDIRECT] = 0;
80101b09:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101b10:	00 00 00 
80101b13:	83 c4 10             	add    $0x10,%esp
80101b16:	e9 62 ff ff ff       	jmp    80101a7d <iput+0xbd>
80101b1b:	90                   	nop
80101b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b20 <iunlockput>:
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	53                   	push   %ebx
80101b24:	83 ec 10             	sub    $0x10,%esp
80101b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101b2a:	53                   	push   %ebx
80101b2b:	e8 40 fe ff ff       	call   80101970 <iunlock>
  iput(ip);
80101b30:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101b33:	83 c4 10             	add    $0x10,%esp
}
80101b36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b39:	c9                   	leave  
  iput(ip);
80101b3a:	e9 81 fe ff ff       	jmp    801019c0 <iput>
80101b3f:	90                   	nop

80101b40 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	8b 55 08             	mov    0x8(%ebp),%edx
80101b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b49:	8b 0a                	mov    (%edx),%ecx
80101b4b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b4e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b51:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b54:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b58:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b5b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b5f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b63:	8b 52 58             	mov    0x58(%edx),%edx
80101b66:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b69:	5d                   	pop    %ebp
80101b6a:	c3                   	ret    
80101b6b:	90                   	nop
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b70 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	56                   	push   %esi
80101b75:	53                   	push   %ebx
80101b76:	83 ec 1c             	sub    $0x1c,%esp
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101b87:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101b8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101b8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101b90:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101b93:	0f 84 a7 00 00 00    	je     80101c40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9c:	8b 40 58             	mov    0x58(%eax),%eax
80101b9f:	39 c6                	cmp    %eax,%esi
80101ba1:	0f 87 ba 00 00 00    	ja     80101c61 <readi+0xf1>
80101ba7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101baa:	89 f9                	mov    %edi,%ecx
80101bac:	01 f1                	add    %esi,%ecx
80101bae:	0f 82 ad 00 00 00    	jb     80101c61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bb4:	89 c2                	mov    %eax,%edx
80101bb6:	29 f2                	sub    %esi,%edx
80101bb8:	39 c8                	cmp    %ecx,%eax
80101bba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bbd:	31 ff                	xor    %edi,%edi
80101bbf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101bc1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bc4:	74 6c                	je     80101c32 <readi+0xc2>
80101bc6:	8d 76 00             	lea    0x0(%esi),%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bd0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101bd3:	89 f2                	mov    %esi,%edx
80101bd5:	c1 ea 09             	shr    $0x9,%edx
80101bd8:	89 d8                	mov    %ebx,%eax
80101bda:	e8 91 f9 ff ff       	call   80101570 <bmap>
80101bdf:	83 ec 08             	sub    $0x8,%esp
80101be2:	50                   	push   %eax
80101be3:	ff 33                	pushl  (%ebx)
80101be5:	e8 e6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bef:	89 f0                	mov    %esi,%eax
80101bf1:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bf6:	b9 00 02 00 00       	mov    $0x200,%ecx
80101bfb:	83 c4 0c             	add    $0xc,%esp
80101bfe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101c04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101c07:	29 fb                	sub    %edi,%ebx
80101c09:	39 d9                	cmp    %ebx,%ecx
80101c0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c0e:	53                   	push   %ebx
80101c0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101c12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101c17:	e8 44 38 00 00       	call   80105460 <memmove>
    brelse(bp);
80101c1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c1f:	89 14 24             	mov    %edx,(%esp)
80101c22:	e8 b9 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101c30:	77 9e                	ja     80101bd0 <readi+0x60>
  }
  return n;
80101c32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101c35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c38:	5b                   	pop    %ebx
80101c39:	5e                   	pop    %esi
80101c3a:	5f                   	pop    %edi
80101c3b:	5d                   	pop    %ebp
80101c3c:	c3                   	ret    
80101c3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c44:	66 83 f8 09          	cmp    $0x9,%ax
80101c48:	77 17                	ja     80101c61 <readi+0xf1>
80101c4a:	8b 04 c5 60 29 11 80 	mov    -0x7feed6a0(,%eax,8),%eax
80101c51:	85 c0                	test   %eax,%eax
80101c53:	74 0c                	je     80101c61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101c55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5b:	5b                   	pop    %ebx
80101c5c:	5e                   	pop    %esi
80101c5d:	5f                   	pop    %edi
80101c5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c5f:	ff e0                	jmp    *%eax
      return -1;
80101c61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c66:	eb cd                	jmp    80101c35 <readi+0xc5>
80101c68:	90                   	nop
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	83 ec 1c             	sub    $0x1c,%esp
80101c79:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101c7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;
  if(ip->type == T_DEV){
80101c82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101c8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101c90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101c93:	0f 84 b7 00 00 00    	je     80101d50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101c9f:	0f 82 eb 00 00 00    	jb     80101d90 <writei+0x120>
80101ca5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ca8:	31 d2                	xor    %edx,%edx
80101caa:	89 f8                	mov    %edi,%eax
80101cac:	01 f0                	add    %esi,%eax
80101cae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101cb1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101cb6:	0f 87 d4 00 00 00    	ja     80101d90 <writei+0x120>
80101cbc:	85 d2                	test   %edx,%edx
80101cbe:	0f 85 cc 00 00 00    	jne    80101d90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc4:	85 ff                	test   %edi,%edi
80101cc6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ccd:	74 72                	je     80101d41 <writei+0xd1>
80101ccf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cd0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101cd3:	89 f2                	mov    %esi,%edx
80101cd5:	c1 ea 09             	shr    $0x9,%edx
80101cd8:	89 f8                	mov    %edi,%eax
80101cda:	e8 91 f8 ff ff       	call   80101570 <bmap>
80101cdf:	83 ec 08             	sub    $0x8,%esp
80101ce2:	50                   	push   %eax
80101ce3:	ff 37                	pushl  (%edi)
80101ce5:	e8 e6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101ced:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cf0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101cf2:	89 f0                	mov    %esi,%eax
80101cf4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101cf9:	83 c4 0c             	add    $0xc,%esp
80101cfc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d07:	39 d9                	cmp    %ebx,%ecx
80101d09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d0c:	53                   	push   %ebx
80101d0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101d12:	50                   	push   %eax
80101d13:	e8 48 37 00 00       	call   80105460 <memmove>
    log_write(bp);
80101d18:	89 3c 24             	mov    %edi,(%esp)
80101d1b:	e8 e0 18 00 00       	call   80103600 <log_write>
    brelse(bp);
80101d20:	89 3c 24             	mov    %edi,(%esp)
80101d23:	e8 b8 e4 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d2e:	83 c4 10             	add    $0x10,%esp
80101d31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101d37:	77 97                	ja     80101cd0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101d3f:	77 37                	ja     80101d78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d47:	5b                   	pop    %ebx
80101d48:	5e                   	pop    %esi
80101d49:	5f                   	pop    %edi
80101d4a:	5d                   	pop    %ebp
80101d4b:	c3                   	ret    
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d54:	66 83 f8 09          	cmp    $0x9,%ax
80101d58:	77 36                	ja     80101d90 <writei+0x120>
80101d5a:	8b 04 c5 64 29 11 80 	mov    -0x7feed69c(,%eax,8),%eax
80101d61:	85 c0                	test   %eax,%eax
80101d63:	74 2b                	je     80101d90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101d65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6b:	5b                   	pop    %ebx
80101d6c:	5e                   	pop    %esi
80101d6d:	5f                   	pop    %edi
80101d6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d6f:	ff e0                	jmp    *%eax
80101d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101d78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101d7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101d81:	50                   	push   %eax
80101d82:	e8 59 fa ff ff       	call   801017e0 <iupdate>
80101d87:	83 c4 10             	add    $0x10,%esp
80101d8a:	eb b5                	jmp    80101d41 <writei+0xd1>
80101d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d95:	eb ad                	jmp    80101d44 <writei+0xd4>
80101d97:	89 f6                	mov    %esi,%esi
80101d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101da0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101da6:	6a 0e                	push   $0xe
80101da8:	ff 75 0c             	pushl  0xc(%ebp)
80101dab:	ff 75 08             	pushl  0x8(%ebp)
80101dae:	e8 1d 37 00 00       	call   801054d0 <strncmp>
}
80101db3:	c9                   	leave  
80101db4:	c3                   	ret    
80101db5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101dc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101dc0:	55                   	push   %ebp
80101dc1:	89 e5                	mov    %esp,%ebp
80101dc3:	57                   	push   %edi
80101dc4:	56                   	push   %esi
80101dc5:	53                   	push   %ebx
80101dc6:	83 ec 1c             	sub    $0x1c,%esp
80101dc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101dd1:	0f 85 85 00 00 00    	jne    80101e5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101dd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101dda:	31 ff                	xor    %edi,%edi
80101ddc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ddf:	85 d2                	test   %edx,%edx
80101de1:	74 3e                	je     80101e21 <dirlookup+0x61>
80101de3:	90                   	nop
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101de8:	6a 10                	push   $0x10
80101dea:	57                   	push   %edi
80101deb:	56                   	push   %esi
80101dec:	53                   	push   %ebx
80101ded:	e8 7e fd ff ff       	call   80101b70 <readi>
80101df2:	83 c4 10             	add    $0x10,%esp
80101df5:	83 f8 10             	cmp    $0x10,%eax
80101df8:	75 55                	jne    80101e4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101dfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101dff:	74 18                	je     80101e19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e04:	83 ec 04             	sub    $0x4,%esp
80101e07:	6a 0e                	push   $0xe
80101e09:	50                   	push   %eax
80101e0a:	ff 75 0c             	pushl  0xc(%ebp)
80101e0d:	e8 be 36 00 00       	call   801054d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	85 c0                	test   %eax,%eax
80101e17:	74 17                	je     80101e30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e19:	83 c7 10             	add    $0x10,%edi
80101e1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e1f:	72 c7                	jb     80101de8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e24:	31 c0                	xor    %eax,%eax
}
80101e26:	5b                   	pop    %ebx
80101e27:	5e                   	pop    %esi
80101e28:	5f                   	pop    %edi
80101e29:	5d                   	pop    %ebp
80101e2a:	c3                   	ret    
80101e2b:	90                   	nop
80101e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101e30:	8b 45 10             	mov    0x10(%ebp),%eax
80101e33:	85 c0                	test   %eax,%eax
80101e35:	74 05                	je     80101e3c <dirlookup+0x7c>
        *poff = off;
80101e37:	8b 45 10             	mov    0x10(%ebp),%eax
80101e3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e40:	8b 03                	mov    (%ebx),%eax
80101e42:	e8 59 f6 ff ff       	call   801014a0 <iget>
}
80101e47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e4a:	5b                   	pop    %ebx
80101e4b:	5e                   	pop    %esi
80101e4c:	5f                   	pop    %edi
80101e4d:	5d                   	pop    %ebp
80101e4e:	c3                   	ret    
      panic("dirlookup read");
80101e4f:	83 ec 0c             	sub    $0xc,%esp
80101e52:	68 59 8b 10 80       	push   $0x80108b59
80101e57:	e8 34 e5 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101e5c:	83 ec 0c             	sub    $0xc,%esp
80101e5f:	68 47 8b 10 80       	push   $0x80108b47
80101e64:	e8 27 e5 ff ff       	call   80100390 <panic>
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e70:	55                   	push   %ebp
80101e71:	89 e5                	mov    %esp,%ebp
80101e73:	57                   	push   %edi
80101e74:	56                   	push   %esi
80101e75:	53                   	push   %ebx
80101e76:	89 cf                	mov    %ecx,%edi
80101e78:	89 c3                	mov    %eax,%ebx
80101e7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101e83:	0f 84 67 01 00 00    	je     80101ff0 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e89:	e8 92 22 00 00       	call   80104120 <myproc>
  acquire(&icache.lock);
80101e8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e94:	68 e0 29 11 80       	push   $0x801129e0
80101e99:	e8 02 34 00 00       	call   801052a0 <acquire>
  ip->ref++;
80101e9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ea2:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101ea9:	e8 b2 34 00 00       	call   80105360 <release>
80101eae:	83 c4 10             	add    $0x10,%esp
80101eb1:	eb 08                	jmp    80101ebb <namex+0x4b>
80101eb3:	90                   	nop
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101eb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ebb:	0f b6 03             	movzbl (%ebx),%eax
80101ebe:	3c 2f                	cmp    $0x2f,%al
80101ec0:	74 f6                	je     80101eb8 <namex+0x48>
  if(*path == 0)
80101ec2:	84 c0                	test   %al,%al
80101ec4:	0f 84 ee 00 00 00    	je     80101fb8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101eca:	0f b6 03             	movzbl (%ebx),%eax
80101ecd:	3c 2f                	cmp    $0x2f,%al
80101ecf:	0f 84 b3 00 00 00    	je     80101f88 <namex+0x118>
80101ed5:	84 c0                	test   %al,%al
80101ed7:	89 da                	mov    %ebx,%edx
80101ed9:	75 09                	jne    80101ee4 <namex+0x74>
80101edb:	e9 a8 00 00 00       	jmp    80101f88 <namex+0x118>
80101ee0:	84 c0                	test   %al,%al
80101ee2:	74 0a                	je     80101eee <namex+0x7e>
    path++;
80101ee4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101ee7:	0f b6 02             	movzbl (%edx),%eax
80101eea:	3c 2f                	cmp    $0x2f,%al
80101eec:	75 f2                	jne    80101ee0 <namex+0x70>
80101eee:	89 d1                	mov    %edx,%ecx
80101ef0:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101ef2:	83 f9 0d             	cmp    $0xd,%ecx
80101ef5:	0f 8e 91 00 00 00    	jle    80101f8c <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101efb:	83 ec 04             	sub    $0x4,%esp
80101efe:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f01:	6a 0e                	push   $0xe
80101f03:	53                   	push   %ebx
80101f04:	57                   	push   %edi
80101f05:	e8 56 35 00 00       	call   80105460 <memmove>
    path++;
80101f0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101f0d:	83 c4 10             	add    $0x10,%esp
    path++;
80101f10:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101f12:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101f15:	75 11                	jne    80101f28 <namex+0xb8>
80101f17:	89 f6                	mov    %esi,%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101f20:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f23:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f26:	74 f8                	je     80101f20 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f28:	83 ec 0c             	sub    $0xc,%esp
80101f2b:	56                   	push   %esi
80101f2c:	e8 5f f9 ff ff       	call   80101890 <ilock>
    if(ip->type != T_DIR){
80101f31:	83 c4 10             	add    $0x10,%esp
80101f34:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f39:	0f 85 91 00 00 00    	jne    80101fd0 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f3f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f42:	85 d2                	test   %edx,%edx
80101f44:	74 09                	je     80101f4f <namex+0xdf>
80101f46:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f49:	0f 84 b7 00 00 00    	je     80102006 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f4f:	83 ec 04             	sub    $0x4,%esp
80101f52:	6a 00                	push   $0x0
80101f54:	57                   	push   %edi
80101f55:	56                   	push   %esi
80101f56:	e8 65 fe ff ff       	call   80101dc0 <dirlookup>
80101f5b:	83 c4 10             	add    $0x10,%esp
80101f5e:	85 c0                	test   %eax,%eax
80101f60:	74 6e                	je     80101fd0 <namex+0x160>
  iunlock(ip);
80101f62:	83 ec 0c             	sub    $0xc,%esp
80101f65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f68:	56                   	push   %esi
80101f69:	e8 02 fa ff ff       	call   80101970 <iunlock>
  iput(ip);
80101f6e:	89 34 24             	mov    %esi,(%esp)
80101f71:	e8 4a fa ff ff       	call   801019c0 <iput>
80101f76:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101f79:	83 c4 10             	add    $0x10,%esp
80101f7c:	89 c6                	mov    %eax,%esi
80101f7e:	e9 38 ff ff ff       	jmp    80101ebb <namex+0x4b>
80101f83:	90                   	nop
80101f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101f88:	89 da                	mov    %ebx,%edx
80101f8a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101f8c:	83 ec 04             	sub    $0x4,%esp
80101f8f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f92:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f95:	51                   	push   %ecx
80101f96:	53                   	push   %ebx
80101f97:	57                   	push   %edi
80101f98:	e8 c3 34 00 00       	call   80105460 <memmove>
    name[len] = 0;
80101f9d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101fa0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fa3:	83 c4 10             	add    $0x10,%esp
80101fa6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101faa:	89 d3                	mov    %edx,%ebx
80101fac:	e9 61 ff ff ff       	jmp    80101f12 <namex+0xa2>
80101fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101fb8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101fbb:	85 c0                	test   %eax,%eax
80101fbd:	75 5d                	jne    8010201c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101fbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fc2:	89 f0                	mov    %esi,%eax
80101fc4:	5b                   	pop    %ebx
80101fc5:	5e                   	pop    %esi
80101fc6:	5f                   	pop    %edi
80101fc7:	5d                   	pop    %ebp
80101fc8:	c3                   	ret    
80101fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101fd0:	83 ec 0c             	sub    $0xc,%esp
80101fd3:	56                   	push   %esi
80101fd4:	e8 97 f9 ff ff       	call   80101970 <iunlock>
  iput(ip);
80101fd9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fdc:	31 f6                	xor    %esi,%esi
  iput(ip);
80101fde:	e8 dd f9 ff ff       	call   801019c0 <iput>
      return 0;
80101fe3:	83 c4 10             	add    $0x10,%esp
}
80101fe6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe9:	89 f0                	mov    %esi,%eax
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5f                   	pop    %edi
80101fee:	5d                   	pop    %ebp
80101fef:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101ff0:	ba 01 00 00 00       	mov    $0x1,%edx
80101ff5:	b8 01 00 00 00       	mov    $0x1,%eax
80101ffa:	e8 a1 f4 ff ff       	call   801014a0 <iget>
80101fff:	89 c6                	mov    %eax,%esi
80102001:	e9 b5 fe ff ff       	jmp    80101ebb <namex+0x4b>
      iunlock(ip);
80102006:	83 ec 0c             	sub    $0xc,%esp
80102009:	56                   	push   %esi
8010200a:	e8 61 f9 ff ff       	call   80101970 <iunlock>
      return ip;
8010200f:	83 c4 10             	add    $0x10,%esp
}
80102012:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102015:	89 f0                	mov    %esi,%eax
80102017:	5b                   	pop    %ebx
80102018:	5e                   	pop    %esi
80102019:	5f                   	pop    %edi
8010201a:	5d                   	pop    %ebp
8010201b:	c3                   	ret    
    iput(ip);
8010201c:	83 ec 0c             	sub    $0xc,%esp
8010201f:	56                   	push   %esi
    return 0;
80102020:	31 f6                	xor    %esi,%esi
    iput(ip);
80102022:	e8 99 f9 ff ff       	call   801019c0 <iput>
    return 0;
80102027:	83 c4 10             	add    $0x10,%esp
8010202a:	eb 93                	jmp    80101fbf <namex+0x14f>
8010202c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102030 <dirlink>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	57                   	push   %edi
80102034:	56                   	push   %esi
80102035:	53                   	push   %ebx
80102036:	83 ec 20             	sub    $0x20,%esp
80102039:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010203c:	6a 00                	push   $0x0
8010203e:	ff 75 0c             	pushl  0xc(%ebp)
80102041:	53                   	push   %ebx
80102042:	e8 79 fd ff ff       	call   80101dc0 <dirlookup>
80102047:	83 c4 10             	add    $0x10,%esp
8010204a:	85 c0                	test   %eax,%eax
8010204c:	75 67                	jne    801020b5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010204e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102051:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102054:	85 ff                	test   %edi,%edi
80102056:	74 29                	je     80102081 <dirlink+0x51>
80102058:	31 ff                	xor    %edi,%edi
8010205a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010205d:	eb 09                	jmp    80102068 <dirlink+0x38>
8010205f:	90                   	nop
80102060:	83 c7 10             	add    $0x10,%edi
80102063:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102066:	73 19                	jae    80102081 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102068:	6a 10                	push   $0x10
8010206a:	57                   	push   %edi
8010206b:	56                   	push   %esi
8010206c:	53                   	push   %ebx
8010206d:	e8 fe fa ff ff       	call   80101b70 <readi>
80102072:	83 c4 10             	add    $0x10,%esp
80102075:	83 f8 10             	cmp    $0x10,%eax
80102078:	75 4e                	jne    801020c8 <dirlink+0x98>
    if(de.inum == 0)
8010207a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010207f:	75 df                	jne    80102060 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102081:	8d 45 da             	lea    -0x26(%ebp),%eax
80102084:	83 ec 04             	sub    $0x4,%esp
80102087:	6a 0e                	push   $0xe
80102089:	ff 75 0c             	pushl  0xc(%ebp)
8010208c:	50                   	push   %eax
8010208d:	e8 9e 34 00 00       	call   80105530 <strncpy>
  de.inum = inum;
80102092:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102095:	6a 10                	push   $0x10
80102097:	57                   	push   %edi
80102098:	56                   	push   %esi
80102099:	53                   	push   %ebx
  de.inum = inum;
8010209a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010209e:	e8 cd fb ff ff       	call   80101c70 <writei>
801020a3:	83 c4 20             	add    $0x20,%esp
801020a6:	83 f8 10             	cmp    $0x10,%eax
801020a9:	75 2a                	jne    801020d5 <dirlink+0xa5>
  return 0;
801020ab:	31 c0                	xor    %eax,%eax
}
801020ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020b0:	5b                   	pop    %ebx
801020b1:	5e                   	pop    %esi
801020b2:	5f                   	pop    %edi
801020b3:	5d                   	pop    %ebp
801020b4:	c3                   	ret    
    iput(ip);
801020b5:	83 ec 0c             	sub    $0xc,%esp
801020b8:	50                   	push   %eax
801020b9:	e8 02 f9 ff ff       	call   801019c0 <iput>
    return -1;
801020be:	83 c4 10             	add    $0x10,%esp
801020c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020c6:	eb e5                	jmp    801020ad <dirlink+0x7d>
      panic("dirlink read");
801020c8:	83 ec 0c             	sub    $0xc,%esp
801020cb:	68 68 8b 10 80       	push   $0x80108b68
801020d0:	e8 bb e2 ff ff       	call   80100390 <panic>
    panic("dirlink");
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	68 95 92 10 80       	push   $0x80109295
801020dd:	e8 ae e2 ff ff       	call   80100390 <panic>
801020e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801020f0 <namei>:

struct inode*
namei(char *path)
{
801020f0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020f1:	31 d2                	xor    %edx,%edx
{
801020f3:	89 e5                	mov    %esp,%ebp
801020f5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020f8:	8b 45 08             	mov    0x8(%ebp),%eax
801020fb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020fe:	e8 6d fd ff ff       	call   80101e70 <namex>
}
80102103:	c9                   	leave  
80102104:	c3                   	ret    
80102105:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102110 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102110:	55                   	push   %ebp
  return namex(path, 1, name);
80102111:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102116:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102118:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010211b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010211e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010211f:	e9 4c fd ff ff       	jmp    80101e70 <namex>
80102124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010212a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102130 <itoa>:

#include "fcntl.h"
#define DIGITS 14

char* itoa(int i, char b[]){
80102130:	55                   	push   %ebp
    char const digit[] = "0123456789";
80102131:	b8 38 39 00 00       	mov    $0x3938,%eax
char* itoa(int i, char b[]){
80102136:	89 e5                	mov    %esp,%ebp
80102138:	57                   	push   %edi
80102139:	56                   	push   %esi
8010213a:	53                   	push   %ebx
8010213b:	83 ec 10             	sub    $0x10,%esp
8010213e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80102141:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80102148:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
8010214f:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80102153:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
80102157:	8b 75 0c             	mov    0xc(%ebp),%esi
    char* p = b;
    if(i<0){
8010215a:	85 c9                	test   %ecx,%ecx
8010215c:	79 0a                	jns    80102168 <itoa+0x38>
8010215e:	89 f0                	mov    %esi,%eax
80102160:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
80102163:	f7 d9                	neg    %ecx
        *p++ = '-';
80102165:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
80102168:	89 cb                	mov    %ecx,%ebx
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
8010216a:	bf 67 66 66 66       	mov    $0x66666667,%edi
8010216f:	90                   	nop
80102170:	89 d8                	mov    %ebx,%eax
80102172:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
80102175:	83 c6 01             	add    $0x1,%esi
        shifter = shifter/10;
80102178:	f7 ef                	imul   %edi
8010217a:	c1 fa 02             	sar    $0x2,%edx
    }while(shifter);
8010217d:	29 da                	sub    %ebx,%edx
8010217f:	89 d3                	mov    %edx,%ebx
80102181:	75 ed                	jne    80102170 <itoa+0x40>
    *p = '\0';
80102183:	c6 06 00             	movb   $0x0,(%esi)
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
80102186:	bb 67 66 66 66       	mov    $0x66666667,%ebx
8010218b:	90                   	nop
8010218c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102190:	89 c8                	mov    %ecx,%eax
80102192:	83 ee 01             	sub    $0x1,%esi
80102195:	f7 eb                	imul   %ebx
80102197:	89 c8                	mov    %ecx,%eax
80102199:	c1 f8 1f             	sar    $0x1f,%eax
8010219c:	c1 fa 02             	sar    $0x2,%edx
8010219f:	29 c2                	sub    %eax,%edx
801021a1:	8d 04 92             	lea    (%edx,%edx,4),%eax
801021a4:	01 c0                	add    %eax,%eax
801021a6:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
801021a8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801021aa:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
801021af:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
801021b1:	88 06                	mov    %al,(%esi)
    }while(i);
801021b3:	75 db                	jne    80102190 <itoa+0x60>
    return b;
}
801021b5:	8b 45 0c             	mov    0xc(%ebp),%eax
801021b8:	83 c4 10             	add    $0x10,%esp
801021bb:	5b                   	pop    %ebx
801021bc:	5e                   	pop    %esi
801021bd:	5f                   	pop    %edi
801021be:	5d                   	pop    %ebp
801021bf:	c3                   	ret    

801021c0 <removeSwapFile>:
//remove swap file of proc p;
int
removeSwapFile(struct proc* p)
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	57                   	push   %edi
801021c4:	56                   	push   %esi
801021c5:	53                   	push   %ebx
  //path of proccess
  char path[DIGITS];
  memmove(path,"/.swap", 6);
801021c6:	8d 75 bc             	lea    -0x44(%ebp),%esi
{
801021c9:	83 ec 40             	sub    $0x40,%esp
801021cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
801021cf:	6a 06                	push   $0x6
801021d1:	68 75 8b 10 80       	push   $0x80108b75
801021d6:	56                   	push   %esi
801021d7:	e8 84 32 00 00       	call   80105460 <memmove>
  itoa(p->pid, path+ 6);
801021dc:	58                   	pop    %eax
801021dd:	8d 45 c2             	lea    -0x3e(%ebp),%eax
801021e0:	5a                   	pop    %edx
801021e1:	50                   	push   %eax
801021e2:	ff 73 10             	pushl  0x10(%ebx)
801021e5:	e8 46 ff ff ff       	call   80102130 <itoa>
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ];
  uint off;

  if(0 == p->swapFile)
801021ea:	8b 43 7c             	mov    0x7c(%ebx),%eax
801021ed:	83 c4 10             	add    $0x10,%esp
801021f0:	85 c0                	test   %eax,%eax
801021f2:	0f 84 88 01 00 00    	je     80102380 <removeSwapFile+0x1c0>
  {
    return -1;
  }
  fileclose(p->swapFile);
801021f8:	83 ec 0c             	sub    $0xc,%esp
  return namex(path, 1, name);
801021fb:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  fileclose(p->swapFile);
801021fe:	50                   	push   %eax
801021ff:	e8 4c ee ff ff       	call   80101050 <fileclose>

  begin_op();
80102204:	e8 27 12 00 00       	call   80103430 <begin_op>
  return namex(path, 1, name);
80102209:	89 f0                	mov    %esi,%eax
8010220b:	89 d9                	mov    %ebx,%ecx
8010220d:	ba 01 00 00 00       	mov    $0x1,%edx
80102212:	e8 59 fc ff ff       	call   80101e70 <namex>
  if((dp = nameiparent(path, name)) == 0)
80102217:	83 c4 10             	add    $0x10,%esp
8010221a:	85 c0                	test   %eax,%eax
  return namex(path, 1, name);
8010221c:	89 c6                	mov    %eax,%esi
  if((dp = nameiparent(path, name)) == 0)
8010221e:	0f 84 66 01 00 00    	je     8010238a <removeSwapFile+0x1ca>
  {
    end_op();
    return -1;
  }

  ilock(dp);
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	50                   	push   %eax
80102228:	e8 63 f6 ff ff       	call   80101890 <ilock>
  return strncmp(s, t, DIRSIZ);
8010222d:	83 c4 0c             	add    $0xc,%esp
80102230:	6a 0e                	push   $0xe
80102232:	68 7d 8b 10 80       	push   $0x80108b7d
80102237:	53                   	push   %ebx
80102238:	e8 93 32 00 00       	call   801054d0 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010223d:	83 c4 10             	add    $0x10,%esp
80102240:	85 c0                	test   %eax,%eax
80102242:	0f 84 f8 00 00 00    	je     80102340 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
80102248:	83 ec 04             	sub    $0x4,%esp
8010224b:	6a 0e                	push   $0xe
8010224d:	68 7c 8b 10 80       	push   $0x80108b7c
80102252:	53                   	push   %ebx
80102253:	e8 78 32 00 00       	call   801054d0 <strncmp>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80102258:	83 c4 10             	add    $0x10,%esp
8010225b:	85 c0                	test   %eax,%eax
8010225d:	0f 84 dd 00 00 00    	je     80102340 <removeSwapFile+0x180>
     goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80102263:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102266:	83 ec 04             	sub    $0x4,%esp
80102269:	50                   	push   %eax
8010226a:	53                   	push   %ebx
8010226b:	56                   	push   %esi
8010226c:	e8 4f fb ff ff       	call   80101dc0 <dirlookup>
80102271:	83 c4 10             	add    $0x10,%esp
80102274:	85 c0                	test   %eax,%eax
80102276:	89 c3                	mov    %eax,%ebx
80102278:	0f 84 c2 00 00 00    	je     80102340 <removeSwapFile+0x180>
    goto bad;
  ilock(ip);
8010227e:	83 ec 0c             	sub    $0xc,%esp
80102281:	50                   	push   %eax
80102282:	e8 09 f6 ff ff       	call   80101890 <ilock>

  if(ip->nlink < 1)
80102287:	83 c4 10             	add    $0x10,%esp
8010228a:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010228f:	0f 8e 11 01 00 00    	jle    801023a6 <removeSwapFile+0x1e6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80102295:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010229a:	74 74                	je     80102310 <removeSwapFile+0x150>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010229c:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010229f:	83 ec 04             	sub    $0x4,%esp
801022a2:	6a 10                	push   $0x10
801022a4:	6a 00                	push   $0x0
801022a6:	57                   	push   %edi
801022a7:	e8 04 31 00 00       	call   801053b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022ac:	6a 10                	push   $0x10
801022ae:	ff 75 b8             	pushl  -0x48(%ebp)
801022b1:	57                   	push   %edi
801022b2:	56                   	push   %esi
801022b3:	e8 b8 f9 ff ff       	call   80101c70 <writei>
801022b8:	83 c4 20             	add    $0x20,%esp
801022bb:	83 f8 10             	cmp    $0x10,%eax
801022be:	0f 85 d5 00 00 00    	jne    80102399 <removeSwapFile+0x1d9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801022c4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801022c9:	0f 84 91 00 00 00    	je     80102360 <removeSwapFile+0x1a0>
  iunlock(ip);
801022cf:	83 ec 0c             	sub    $0xc,%esp
801022d2:	56                   	push   %esi
801022d3:	e8 98 f6 ff ff       	call   80101970 <iunlock>
  iput(ip);
801022d8:	89 34 24             	mov    %esi,(%esp)
801022db:	e8 e0 f6 ff ff       	call   801019c0 <iput>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
801022e0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801022e5:	89 1c 24             	mov    %ebx,(%esp)
801022e8:	e8 f3 f4 ff ff       	call   801017e0 <iupdate>
  iunlock(ip);
801022ed:	89 1c 24             	mov    %ebx,(%esp)
801022f0:	e8 7b f6 ff ff       	call   80101970 <iunlock>
  iput(ip);
801022f5:	89 1c 24             	mov    %ebx,(%esp)
801022f8:	e8 c3 f6 ff ff       	call   801019c0 <iput>
  iunlockput(ip);

  end_op();
801022fd:	e8 9e 11 00 00       	call   801034a0 <end_op>

  return 0;
80102302:	83 c4 10             	add    $0x10,%esp
80102305:	31 c0                	xor    %eax,%eax
  bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102307:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010230a:	5b                   	pop    %ebx
8010230b:	5e                   	pop    %esi
8010230c:	5f                   	pop    %edi
8010230d:	5d                   	pop    %ebp
8010230e:	c3                   	ret    
8010230f:	90                   	nop
  if(ip->type == T_DIR && !isdirempty(ip)){
80102310:	83 ec 0c             	sub    $0xc,%esp
80102313:	53                   	push   %ebx
80102314:	e8 77 38 00 00       	call   80105b90 <isdirempty>
80102319:	83 c4 10             	add    $0x10,%esp
8010231c:	85 c0                	test   %eax,%eax
8010231e:	0f 85 78 ff ff ff    	jne    8010229c <removeSwapFile+0xdc>
  iunlock(ip);
80102324:	83 ec 0c             	sub    $0xc,%esp
80102327:	53                   	push   %ebx
80102328:	e8 43 f6 ff ff       	call   80101970 <iunlock>
  iput(ip);
8010232d:	89 1c 24             	mov    %ebx,(%esp)
80102330:	e8 8b f6 ff ff       	call   801019c0 <iput>
80102335:	83 c4 10             	add    $0x10,%esp
80102338:	90                   	nop
80102339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102340:	83 ec 0c             	sub    $0xc,%esp
80102343:	56                   	push   %esi
80102344:	e8 27 f6 ff ff       	call   80101970 <iunlock>
  iput(ip);
80102349:	89 34 24             	mov    %esi,(%esp)
8010234c:	e8 6f f6 ff ff       	call   801019c0 <iput>
    end_op();
80102351:	e8 4a 11 00 00       	call   801034a0 <end_op>
    return -1;
80102356:	83 c4 10             	add    $0x10,%esp
80102359:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010235e:	eb a7                	jmp    80102307 <removeSwapFile+0x147>
    dp->nlink--;
80102360:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80102365:	83 ec 0c             	sub    $0xc,%esp
80102368:	56                   	push   %esi
80102369:	e8 72 f4 ff ff       	call   801017e0 <iupdate>
8010236e:	83 c4 10             	add    $0x10,%esp
80102371:	e9 59 ff ff ff       	jmp    801022cf <removeSwapFile+0x10f>
80102376:	8d 76 00             	lea    0x0(%esi),%esi
80102379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102385:	e9 7d ff ff ff       	jmp    80102307 <removeSwapFile+0x147>
    end_op();
8010238a:	e8 11 11 00 00       	call   801034a0 <end_op>
    return -1;
8010238f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102394:	e9 6e ff ff ff       	jmp    80102307 <removeSwapFile+0x147>
    panic("unlink: writei");
80102399:	83 ec 0c             	sub    $0xc,%esp
8010239c:	68 91 8b 10 80       	push   $0x80108b91
801023a1:	e8 ea df ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801023a6:	83 ec 0c             	sub    $0xc,%esp
801023a9:	68 7f 8b 10 80       	push   $0x80108b7f
801023ae:	e8 dd df ff ff       	call   80100390 <panic>
801023b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023c0 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc* p)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx

  char path[DIGITS];
  memmove(path,"/.swap", 6);
801023c5:	8d 75 ea             	lea    -0x16(%ebp),%esi
{
801023c8:	83 ec 14             	sub    $0x14,%esp
801023cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
801023ce:	6a 06                	push   $0x6
801023d0:	68 75 8b 10 80       	push   $0x80108b75
801023d5:	56                   	push   %esi
801023d6:	e8 85 30 00 00       	call   80105460 <memmove>
  itoa(p->pid, path+ 6);
801023db:	58                   	pop    %eax
801023dc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801023df:	5a                   	pop    %edx
801023e0:	50                   	push   %eax
801023e1:	ff 73 10             	pushl  0x10(%ebx)
801023e4:	e8 47 fd ff ff       	call   80102130 <itoa>

    begin_op();
801023e9:	e8 42 10 00 00       	call   80103430 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
801023ee:	6a 00                	push   $0x0
801023f0:	6a 00                	push   $0x0
801023f2:	6a 02                	push   $0x2
801023f4:	56                   	push   %esi
801023f5:	e8 a6 39 00 00       	call   80105da0 <create>
  iunlock(in);
801023fa:	83 c4 14             	add    $0x14,%esp
    struct inode * in = create(path, T_FILE, 0, 0);
801023fd:	89 c6                	mov    %eax,%esi
  iunlock(in);
801023ff:	50                   	push   %eax
80102400:	e8 6b f5 ff ff       	call   80101970 <iunlock>

  p->swapFile = filealloc();
80102405:	e8 86 eb ff ff       	call   80100f90 <filealloc>
  if (p->swapFile == 0)
8010240a:	83 c4 10             	add    $0x10,%esp
8010240d:	85 c0                	test   %eax,%eax
  p->swapFile = filealloc();
8010240f:	89 43 7c             	mov    %eax,0x7c(%ebx)
  if (p->swapFile == 0)
80102412:	74 32                	je     80102446 <createSwapFile+0x86>
    panic("no slot for files on /store");

  p->swapFile->ip = in;
80102414:	89 70 10             	mov    %esi,0x10(%eax)
  p->swapFile->type = FD_INODE;
80102417:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010241a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  p->swapFile->off = 0;
80102420:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102423:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  p->swapFile->readable = O_WRONLY;
8010242a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010242d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->swapFile->writable = O_RDWR;
80102431:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102434:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
80102438:	e8 63 10 00 00       	call   801034a0 <end_op>

    return 0;
}
8010243d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102440:	31 c0                	xor    %eax,%eax
80102442:	5b                   	pop    %ebx
80102443:	5e                   	pop    %esi
80102444:	5d                   	pop    %ebp
80102445:	c3                   	ret    
    panic("no slot for files on /store");
80102446:	83 ec 0c             	sub    $0xc,%esp
80102449:	68 a0 8b 10 80       	push   $0x80108ba0
8010244e:	e8 3d df ff ff       	call   80100390 <panic>
80102453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102460 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
80102466:	8b 4d 10             	mov    0x10(%ebp),%ecx
80102469:	8b 50 7c             	mov    0x7c(%eax),%edx
8010246c:	89 4a 14             	mov    %ecx,0x14(%edx)

  return filewrite(p->swapFile, buffer, size);
8010246f:	8b 55 14             	mov    0x14(%ebp),%edx
80102472:	89 55 10             	mov    %edx,0x10(%ebp)
80102475:	8b 40 7c             	mov    0x7c(%eax),%eax
80102478:	89 45 08             	mov    %eax,0x8(%ebp)

}
8010247b:	5d                   	pop    %ebp
  return filewrite(p->swapFile, buffer, size);
8010247c:	e9 7f ed ff ff       	jmp    80101200 <filewrite>
80102481:	eb 0d                	jmp    80102490 <readFromSwapFile>
80102483:	90                   	nop
80102484:	90                   	nop
80102485:	90                   	nop
80102486:	90                   	nop
80102487:	90                   	nop
80102488:	90                   	nop
80102489:	90                   	nop
8010248a:	90                   	nop
8010248b:	90                   	nop
8010248c:	90                   	nop
8010248d:	90                   	nop
8010248e:	90                   	nop
8010248f:	90                   	nop

80102490 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
80102496:	8b 4d 10             	mov    0x10(%ebp),%ecx
80102499:	8b 50 7c             	mov    0x7c(%eax),%edx
8010249c:	89 4a 14             	mov    %ecx,0x14(%edx)

  return fileread(p->swapFile, buffer,  size);
8010249f:	8b 55 14             	mov    0x14(%ebp),%edx
801024a2:	89 55 10             	mov    %edx,0x10(%ebp)
801024a5:	8b 40 7c             	mov    0x7c(%eax),%eax
801024a8:	89 45 08             	mov    %eax,0x8(%ebp)
}
801024ab:	5d                   	pop    %ebp
  return fileread(p->swapFile, buffer,  size);
801024ac:	e9 bf ec ff ff       	jmp    80101170 <fileread>
801024b1:	66 90                	xchg   %ax,%ax
801024b3:	66 90                	xchg   %ax,%ax
801024b5:	66 90                	xchg   %ax,%ax
801024b7:	66 90                	xchg   %ax,%ax
801024b9:	66 90                	xchg   %ax,%ax
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	57                   	push   %edi
801024c4:	56                   	push   %esi
801024c5:	53                   	push   %ebx
801024c6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801024c9:	85 c0                	test   %eax,%eax
801024cb:	0f 84 b4 00 00 00    	je     80102585 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801024d1:	8b 58 08             	mov    0x8(%eax),%ebx
801024d4:	89 c6                	mov    %eax,%esi
801024d6:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
801024dc:	0f 87 96 00 00 00    	ja     80102578 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024e2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801024e7:	89 f6                	mov    %esi,%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801024f0:	89 ca                	mov    %ecx,%edx
801024f2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801024f3:	83 e0 c0             	and    $0xffffffc0,%eax
801024f6:	3c 40                	cmp    $0x40,%al
801024f8:	75 f6                	jne    801024f0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024fa:	31 ff                	xor    %edi,%edi
801024fc:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102501:	89 f8                	mov    %edi,%eax
80102503:	ee                   	out    %al,(%dx)
80102504:	b8 01 00 00 00       	mov    $0x1,%eax
80102509:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010250e:	ee                   	out    %al,(%dx)
8010250f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102514:	89 d8                	mov    %ebx,%eax
80102516:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102517:	89 d8                	mov    %ebx,%eax
80102519:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010251e:	c1 f8 08             	sar    $0x8,%eax
80102521:	ee                   	out    %al,(%dx)
80102522:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102527:	89 f8                	mov    %edi,%eax
80102529:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010252a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010252e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102533:	c1 e0 04             	shl    $0x4,%eax
80102536:	83 e0 10             	and    $0x10,%eax
80102539:	83 c8 e0             	or     $0xffffffe0,%eax
8010253c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010253d:	f6 06 04             	testb  $0x4,(%esi)
80102540:	75 16                	jne    80102558 <idestart+0x98>
80102542:	b8 20 00 00 00       	mov    $0x20,%eax
80102547:	89 ca                	mov    %ecx,%edx
80102549:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010254a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010254d:	5b                   	pop    %ebx
8010254e:	5e                   	pop    %esi
8010254f:	5f                   	pop    %edi
80102550:	5d                   	pop    %ebp
80102551:	c3                   	ret    
80102552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102558:	b8 30 00 00 00       	mov    $0x30,%eax
8010255d:	89 ca                	mov    %ecx,%edx
8010255f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102560:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102565:	83 c6 5c             	add    $0x5c,%esi
80102568:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010256d:	fc                   	cld    
8010256e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102570:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102573:	5b                   	pop    %ebx
80102574:	5e                   	pop    %esi
80102575:	5f                   	pop    %edi
80102576:	5d                   	pop    %ebp
80102577:	c3                   	ret    
    panic("incorrect blockno");
80102578:	83 ec 0c             	sub    $0xc,%esp
8010257b:	68 18 8c 10 80       	push   $0x80108c18
80102580:	e8 0b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102585:	83 ec 0c             	sub    $0xc,%esp
80102588:	68 0f 8c 10 80       	push   $0x80108c0f
8010258d:	e8 fe dd ff ff       	call   80100390 <panic>
80102592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025a0 <ideinit>:
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801025a6:	68 2a 8c 10 80       	push   $0x80108c2a
801025ab:	68 80 c5 10 80       	push   $0x8010c580
801025b0:	e8 ab 2b 00 00       	call   80105160 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801025b5:	58                   	pop    %eax
801025b6:	a1 20 cd 14 80       	mov    0x8014cd20,%eax
801025bb:	5a                   	pop    %edx
801025bc:	83 e8 01             	sub    $0x1,%eax
801025bf:	50                   	push   %eax
801025c0:	6a 0e                	push   $0xe
801025c2:	e8 a9 02 00 00       	call   80102870 <ioapicenable>
801025c7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025ca:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025cf:	90                   	nop
801025d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025d1:	83 e0 c0             	and    $0xffffffc0,%eax
801025d4:	3c 40                	cmp    $0x40,%al
801025d6:	75 f8                	jne    801025d0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025d8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801025dd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025e2:	ee                   	out    %al,(%dx)
801025e3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025ed:	eb 06                	jmp    801025f5 <ideinit+0x55>
801025ef:	90                   	nop
  for(i=0; i<1000; i++){
801025f0:	83 e9 01             	sub    $0x1,%ecx
801025f3:	74 0f                	je     80102604 <ideinit+0x64>
801025f5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801025f6:	84 c0                	test   %al,%al
801025f8:	74 f6                	je     801025f0 <ideinit+0x50>
      havedisk1 = 1;
801025fa:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80102601:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102604:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102609:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010260e:	ee                   	out    %al,(%dx)
}
8010260f:	c9                   	leave  
80102610:	c3                   	ret    
80102611:	eb 0d                	jmp    80102620 <ideintr>
80102613:	90                   	nop
80102614:	90                   	nop
80102615:	90                   	nop
80102616:	90                   	nop
80102617:	90                   	nop
80102618:	90                   	nop
80102619:	90                   	nop
8010261a:	90                   	nop
8010261b:	90                   	nop
8010261c:	90                   	nop
8010261d:	90                   	nop
8010261e:	90                   	nop
8010261f:	90                   	nop

80102620 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	57                   	push   %edi
80102624:	56                   	push   %esi
80102625:	53                   	push   %ebx
80102626:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102629:	68 80 c5 10 80       	push   $0x8010c580
8010262e:	e8 6d 2c 00 00       	call   801052a0 <acquire>

  if((b = idequeue) == 0){
80102633:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102639:	83 c4 10             	add    $0x10,%esp
8010263c:	85 db                	test   %ebx,%ebx
8010263e:	74 67                	je     801026a7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102640:	8b 43 58             	mov    0x58(%ebx),%eax
80102643:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102648:	8b 3b                	mov    (%ebx),%edi
8010264a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102650:	75 31                	jne    80102683 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102652:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102657:	89 f6                	mov    %esi,%esi
80102659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102660:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102661:	89 c6                	mov    %eax,%esi
80102663:	83 e6 c0             	and    $0xffffffc0,%esi
80102666:	89 f1                	mov    %esi,%ecx
80102668:	80 f9 40             	cmp    $0x40,%cl
8010266b:	75 f3                	jne    80102660 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010266d:	a8 21                	test   $0x21,%al
8010266f:	75 12                	jne    80102683 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
80102671:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102674:	b9 80 00 00 00       	mov    $0x80,%ecx
80102679:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010267e:	fc                   	cld    
8010267f:	f3 6d                	rep insl (%dx),%es:(%edi)
80102681:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102683:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102686:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102689:	89 f9                	mov    %edi,%ecx
8010268b:	83 c9 02             	or     $0x2,%ecx
8010268e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102690:	53                   	push   %ebx
80102691:	e8 fa 22 00 00       	call   80104990 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102696:	a1 64 c5 10 80       	mov    0x8010c564,%eax
8010269b:	83 c4 10             	add    $0x10,%esp
8010269e:	85 c0                	test   %eax,%eax
801026a0:	74 05                	je     801026a7 <ideintr+0x87>
    idestart(idequeue);
801026a2:	e8 19 fe ff ff       	call   801024c0 <idestart>
    release(&idelock);
801026a7:	83 ec 0c             	sub    $0xc,%esp
801026aa:	68 80 c5 10 80       	push   $0x8010c580
801026af:	e8 ac 2c 00 00       	call   80105360 <release>

  release(&idelock);
}
801026b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026b7:	5b                   	pop    %ebx
801026b8:	5e                   	pop    %esi
801026b9:	5f                   	pop    %edi
801026ba:	5d                   	pop    %ebp
801026bb:	c3                   	ret    
801026bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	53                   	push   %ebx
801026c4:	83 ec 10             	sub    $0x10,%esp
801026c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801026ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801026cd:	50                   	push   %eax
801026ce:	e8 3d 2a 00 00       	call   80105110 <holdingsleep>
801026d3:	83 c4 10             	add    $0x10,%esp
801026d6:	85 c0                	test   %eax,%eax
801026d8:	0f 84 c6 00 00 00    	je     801027a4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801026de:	8b 03                	mov    (%ebx),%eax
801026e0:	83 e0 06             	and    $0x6,%eax
801026e3:	83 f8 02             	cmp    $0x2,%eax
801026e6:	0f 84 ab 00 00 00    	je     80102797 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801026ec:	8b 53 04             	mov    0x4(%ebx),%edx
801026ef:	85 d2                	test   %edx,%edx
801026f1:	74 0d                	je     80102700 <iderw+0x40>
801026f3:	a1 60 c5 10 80       	mov    0x8010c560,%eax
801026f8:	85 c0                	test   %eax,%eax
801026fa:	0f 84 b1 00 00 00    	je     801027b1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102700:	83 ec 0c             	sub    $0xc,%esp
80102703:	68 80 c5 10 80       	push   $0x8010c580
80102708:	e8 93 2b 00 00       	call   801052a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010270d:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102713:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102716:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010271d:	85 d2                	test   %edx,%edx
8010271f:	75 09                	jne    8010272a <iderw+0x6a>
80102721:	eb 6d                	jmp    80102790 <iderw+0xd0>
80102723:	90                   	nop
80102724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102728:	89 c2                	mov    %eax,%edx
8010272a:	8b 42 58             	mov    0x58(%edx),%eax
8010272d:	85 c0                	test   %eax,%eax
8010272f:	75 f7                	jne    80102728 <iderw+0x68>
80102731:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102734:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102736:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
8010273c:	74 42                	je     80102780 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010273e:	8b 03                	mov    (%ebx),%eax
80102740:	83 e0 06             	and    $0x6,%eax
80102743:	83 f8 02             	cmp    $0x2,%eax
80102746:	74 23                	je     8010276b <iderw+0xab>
80102748:	90                   	nop
80102749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102750:	83 ec 08             	sub    $0x8,%esp
80102753:	68 80 c5 10 80       	push   $0x8010c580
80102758:	53                   	push   %ebx
80102759:	e8 12 20 00 00       	call   80104770 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010275e:	8b 03                	mov    (%ebx),%eax
80102760:	83 c4 10             	add    $0x10,%esp
80102763:	83 e0 06             	and    $0x6,%eax
80102766:	83 f8 02             	cmp    $0x2,%eax
80102769:	75 e5                	jne    80102750 <iderw+0x90>
  }


  release(&idelock);
8010276b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
80102772:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102775:	c9                   	leave  
  release(&idelock);
80102776:	e9 e5 2b 00 00       	jmp    80105360 <release>
8010277b:	90                   	nop
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102780:	89 d8                	mov    %ebx,%eax
80102782:	e8 39 fd ff ff       	call   801024c0 <idestart>
80102787:	eb b5                	jmp    8010273e <iderw+0x7e>
80102789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102790:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102795:	eb 9d                	jmp    80102734 <iderw+0x74>
    panic("iderw: nothing to do");
80102797:	83 ec 0c             	sub    $0xc,%esp
8010279a:	68 44 8c 10 80       	push   $0x80108c44
8010279f:	e8 ec db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 2e 8c 10 80       	push   $0x80108c2e
801027ac:	e8 df db ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801027b1:	83 ec 0c             	sub    $0xc,%esp
801027b4:	68 59 8c 10 80       	push   $0x80108c59
801027b9:	e8 d2 db ff ff       	call   80100390 <panic>
801027be:	66 90                	xchg   %ax,%ax

801027c0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801027c0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801027c1:	c7 05 34 46 11 80 00 	movl   $0xfec00000,0x80114634
801027c8:	00 c0 fe 
{
801027cb:	89 e5                	mov    %esp,%ebp
801027cd:	56                   	push   %esi
801027ce:	53                   	push   %ebx
  ioapic->reg = reg;
801027cf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801027d6:	00 00 00 
  return ioapic->data;
801027d9:	a1 34 46 11 80       	mov    0x80114634,%eax
801027de:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
801027e1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
801027e7:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801027ed:	0f b6 15 80 c7 14 80 	movzbl 0x8014c780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801027f4:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
801027f7:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801027fa:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
801027fd:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102800:	39 c2                	cmp    %eax,%edx
80102802:	74 16                	je     8010281a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102804:	83 ec 0c             	sub    $0xc,%esp
80102807:	68 78 8c 10 80       	push   $0x80108c78
8010280c:	e8 4f de ff ff       	call   80100660 <cprintf>
80102811:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102817:	83 c4 10             	add    $0x10,%esp
8010281a:	83 c3 21             	add    $0x21,%ebx
{
8010281d:	ba 10 00 00 00       	mov    $0x10,%edx
80102822:	b8 20 00 00 00       	mov    $0x20,%eax
80102827:	89 f6                	mov    %esi,%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102830:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102832:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102838:	89 c6                	mov    %eax,%esi
8010283a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102840:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102843:	89 71 10             	mov    %esi,0x10(%ecx)
80102846:	8d 72 01             	lea    0x1(%edx),%esi
80102849:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010284c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010284e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102850:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102856:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010285d:	75 d1                	jne    80102830 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010285f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102862:	5b                   	pop    %ebx
80102863:	5e                   	pop    %esi
80102864:	5d                   	pop    %ebp
80102865:	c3                   	ret    
80102866:	8d 76 00             	lea    0x0(%esi),%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102870 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102870:	55                   	push   %ebp
  ioapic->reg = reg;
80102871:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
{
80102877:	89 e5                	mov    %esp,%ebp
80102879:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010287c:	8d 50 20             	lea    0x20(%eax),%edx
8010287f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102883:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102885:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010288b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010288e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102891:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102894:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102896:	a1 34 46 11 80       	mov    0x80114634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010289b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010289e:	89 50 10             	mov    %edx,0x10(%eax)
}
801028a1:	5d                   	pop    %ebp
801028a2:	c3                   	ret    
801028a3:	66 90                	xchg   %ax,%ax
801028a5:	66 90                	xchg   %ax,%ax
801028a7:	66 90                	xchg   %ax,%ax
801028a9:	66 90                	xchg   %ax,%ax
801028ab:	66 90                	xchg   %ax,%ax
801028ad:	66 90                	xchg   %ax,%ax
801028af:	90                   	nop

801028b0 <recordTotalFreePages>:
  }
}

void
recordTotalFreePages(){
  if(kmem.use_lock)
801028b0:	8b 15 74 46 11 80    	mov    0x80114674,%edx
801028b6:	85 d2                	test   %edx,%edx
801028b8:	75 0e                	jne    801028c8 <recordTotalFreePages+0x18>
    acquire(&kmem.lock);
  kmem.totalFreePGs =  kmem.free_pages;
801028ba:	a1 7c 46 11 80       	mov    0x8011467c,%eax
801028bf:	a3 80 46 11 80       	mov    %eax,0x80114680
801028c4:	c3                   	ret    
801028c5:	8d 76 00             	lea    0x0(%esi),%esi
recordTotalFreePages(){
801028c8:	55                   	push   %ebp
801028c9:	89 e5                	mov    %esp,%ebp
801028cb:	83 ec 14             	sub    $0x14,%esp
    acquire(&kmem.lock);
801028ce:	68 40 46 11 80       	push   $0x80114640
801028d3:	e8 c8 29 00 00       	call   801052a0 <acquire>
  kmem.totalFreePGs =  kmem.free_pages;
801028d8:	a1 7c 46 11 80       	mov    0x8011467c,%eax
  if(kmem.use_lock)
801028dd:	83 c4 10             	add    $0x10,%esp
  kmem.totalFreePGs =  kmem.free_pages;
801028e0:	a3 80 46 11 80       	mov    %eax,0x80114680
  if(kmem.use_lock)
801028e5:	a1 74 46 11 80       	mov    0x80114674,%eax
801028ea:	85 c0                	test   %eax,%eax
801028ec:	74 10                	je     801028fe <recordTotalFreePages+0x4e>
    release(&kmem.lock);
801028ee:	83 ec 0c             	sub    $0xc,%esp
801028f1:	68 40 46 11 80       	push   $0x80114640
801028f6:	e8 65 2a 00 00       	call   80105360 <release>
801028fb:	83 c4 10             	add    $0x10,%esp
}
801028fe:	c9                   	leave  
801028ff:	c3                   	ret    

80102900 <getTotalFreePages>:

int
getTotalFreePages(){
  uint result;
  if(kmem.use_lock)
80102900:	8b 0d 74 46 11 80    	mov    0x80114674,%ecx
    acquire(&kmem.lock);
  result =  kmem.totalFreePGs;
80102906:	a1 80 46 11 80       	mov    0x80114680,%eax
  if(kmem.use_lock)
8010290b:	85 c9                	test   %ecx,%ecx
8010290d:	75 09                	jne    80102918 <getTotalFreePages+0x18>
  if(kmem.use_lock)
    release(&kmem.lock);
  return result;
}
8010290f:	f3 c3                	repz ret 
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
getTotalFreePages(){
80102918:	55                   	push   %ebp
80102919:	89 e5                	mov    %esp,%ebp
8010291b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010291e:	68 40 46 11 80       	push   $0x80114640
80102923:	e8 78 29 00 00       	call   801052a0 <acquire>
  if(kmem.use_lock)
80102928:	8b 15 74 46 11 80    	mov    0x80114674,%edx
8010292e:	83 c4 10             	add    $0x10,%esp
  result =  kmem.totalFreePGs;
80102931:	a1 80 46 11 80       	mov    0x80114680,%eax
  if(kmem.use_lock)
80102936:	85 d2                	test   %edx,%edx
80102938:	74 16                	je     80102950 <getTotalFreePages+0x50>
    release(&kmem.lock);
8010293a:	83 ec 0c             	sub    $0xc,%esp
8010293d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102940:	68 40 46 11 80       	push   $0x80114640
80102945:	e8 16 2a 00 00       	call   80105360 <release>
8010294a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010294d:	83 c4 10             	add    $0x10,%esp
}
80102950:	c9                   	leave  
80102951:	c3                   	ret    
80102952:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102960 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	56                   	push   %esi
80102964:	53                   	push   %ebx
80102965:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102968:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
8010296e:	0f 85 b9 00 00 00    	jne    80102a2d <kfree+0xcd>
80102974:	81 fe c8 9b 15 80    	cmp    $0x80159bc8,%esi
8010297a:	0f 82 ad 00 00 00    	jb     80102a2d <kfree+0xcd>
80102980:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102986:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010298c:	0f 87 9b 00 00 00    	ja     80102a2d <kfree+0xcd>
    panic("kfree1");

  if(kmem.use_lock)
80102992:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102998:	85 d2                	test   %edx,%edx
8010299a:	75 7c                	jne    80102a18 <kfree+0xb8>
    acquire(&kmem.lock);
  
  r = (struct run*)v;

  #ifndef NONE
  if(kmem.pg_refcount[index(V2P(v))] > 0){
8010299c:	c1 eb 0c             	shr    $0xc,%ebx
8010299f:	83 c3 10             	add    $0x10,%ebx
801029a2:	8b 04 9d 44 46 11 80 	mov    -0x7feeb9bc(,%ebx,4),%eax
801029a9:	85 c0                	test   %eax,%eax
801029ab:	75 3b                	jne    801029e8 <kfree+0x88>
    --kmem.pg_refcount[index(V2P(v))];
  }
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
801029ad:	83 ec 04             	sub    $0x4,%esp
801029b0:	68 00 10 00 00       	push   $0x1000
801029b5:	6a 01                	push   $0x1
801029b7:	56                   	push   %esi
801029b8:	e8 f3 29 00 00       	call   801053b0 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
801029bd:	a1 78 46 11 80       	mov    0x80114678,%eax
    kmem.free_pages++;
801029c2:	83 05 7c 46 11 80 01 	addl   $0x1,0x8011467c
    kmem.freelist = r;
801029c9:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
801029cc:	89 06                	mov    %eax,(%esi)
  r->next = kmem.freelist;
  kmem.freelist = r;

  #endif

  if(kmem.use_lock)
801029ce:	a1 74 46 11 80       	mov    0x80114674,%eax
    kmem.freelist = r;
801029d3:	89 35 78 46 11 80    	mov    %esi,0x80114678
  if(kmem.use_lock)
801029d9:	85 c0                	test   %eax,%eax
801029db:	75 22                	jne    801029ff <kfree+0x9f>
    release(&kmem.lock);
}
801029dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029e0:	5b                   	pop    %ebx
801029e1:	5e                   	pop    %esi
801029e2:	5d                   	pop    %ebp
801029e3:	c3                   	ret    
801029e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    --kmem.pg_refcount[index(V2P(v))];
801029e8:	83 e8 01             	sub    $0x1,%eax
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
801029eb:	85 c0                	test   %eax,%eax
    --kmem.pg_refcount[index(V2P(v))];
801029ed:	89 04 9d 44 46 11 80 	mov    %eax,-0x7feeb9bc(,%ebx,4)
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
801029f4:	74 b7                	je     801029ad <kfree+0x4d>
  if(kmem.use_lock)
801029f6:	a1 74 46 11 80       	mov    0x80114674,%eax
801029fb:	85 c0                	test   %eax,%eax
801029fd:	74 de                	je     801029dd <kfree+0x7d>
    release(&kmem.lock);
801029ff:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102a06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a09:	5b                   	pop    %ebx
80102a0a:	5e                   	pop    %esi
80102a0b:	5d                   	pop    %ebp
    release(&kmem.lock);
80102a0c:	e9 4f 29 00 00       	jmp    80105360 <release>
80102a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102a18:	83 ec 0c             	sub    $0xc,%esp
80102a1b:	68 40 46 11 80       	push   $0x80114640
80102a20:	e8 7b 28 00 00       	call   801052a0 <acquire>
80102a25:	83 c4 10             	add    $0x10,%esp
80102a28:	e9 6f ff ff ff       	jmp    8010299c <kfree+0x3c>
    panic("kfree1");
80102a2d:	83 ec 0c             	sub    $0xc,%esp
80102a30:	68 aa 8c 10 80       	push   $0x80108caa
80102a35:	e8 56 d9 ff ff       	call   80100390 <panic>
80102a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a40 <freerange>:
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	56                   	push   %esi
80102a44:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a45:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a48:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a4b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a51:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a57:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a5d:	39 de                	cmp    %ebx,%esi
80102a5f:	72 23                	jb     80102a84 <freerange+0x44>
80102a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a68:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a6e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a71:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a77:	50                   	push   %eax
80102a78:	e8 e3 fe ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a7d:	83 c4 10             	add    $0x10,%esp
80102a80:	39 f3                	cmp    %esi,%ebx
80102a82:	76 e4                	jbe    80102a68 <freerange+0x28>
}
80102a84:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a87:	5b                   	pop    %ebx
80102a88:	5e                   	pop    %esi
80102a89:	5d                   	pop    %ebp
80102a8a:	c3                   	ret    
80102a8b:	90                   	nop
80102a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a90 <kinit1>:
{
80102a90:	55                   	push   %ebp
80102a91:	89 e5                	mov    %esp,%ebp
80102a93:	56                   	push   %esi
80102a94:	53                   	push   %ebx
80102a95:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102a98:	83 ec 08             	sub    $0x8,%esp
80102a9b:	68 b1 8c 10 80       	push   $0x80108cb1
80102aa0:	68 40 46 11 80       	push   $0x80114640
80102aa5:	e8 b6 26 00 00       	call   80105160 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102aad:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102ab0:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102ab7:	00 00 00 
  kmem.free_pages = 0;
80102aba:	c7 05 7c 46 11 80 00 	movl   $0x0,0x8011467c
80102ac1:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102ac4:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102aca:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102ad0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ad6:	39 de                	cmp    %ebx,%esi
80102ad8:	72 22                	jb     80102afc <kinit1+0x6c>
80102ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kfree(p);
80102ae0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102ae6:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102ae9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102aef:	50                   	push   %eax
80102af0:	e8 6b fe ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102af5:	83 c4 10             	add    $0x10,%esp
80102af8:	39 de                	cmp    %ebx,%esi
80102afa:	73 e4                	jae    80102ae0 <kinit1+0x50>
}
80102afc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102aff:	5b                   	pop    %ebx
80102b00:	5e                   	pop    %esi
80102b01:	5d                   	pop    %ebp
80102b02:	c3                   	ret    
80102b03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b10 <kinit2>:
{
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	56                   	push   %esi
80102b14:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102b15:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102b18:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102b1b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b21:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102b27:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b2d:	39 de                	cmp    %ebx,%esi
80102b2f:	72 23                	jb     80102b54 <kinit2+0x44>
80102b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102b38:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102b3e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102b41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b47:	50                   	push   %eax
80102b48:	e8 13 fe ff ff       	call   80102960 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102b4d:	83 c4 10             	add    $0x10,%esp
80102b50:	39 de                	cmp    %ebx,%esi
80102b52:	73 e4                	jae    80102b38 <kinit2+0x28>
  kmem.use_lock = 1;
80102b54:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
80102b5b:	00 00 00 
}
80102b5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b61:	5b                   	pop    %ebx
80102b62:	5e                   	pop    %esi
80102b63:	5d                   	pop    %ebp
80102b64:	c3                   	ret    
80102b65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b70 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b70:	55                   	push   %ebp
80102b71:	89 e5                	mov    %esp,%ebp
80102b73:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102b76:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102b7c:	85 d2                	test   %edx,%edx
80102b7e:	75 50                	jne    80102bd0 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b80:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102b85:	85 c0                	test   %eax,%eax
80102b87:	74 27                	je     80102bb0 <kalloc+0x40>
    kmem.freelist = r->next;
80102b89:	8b 08                	mov    (%eax),%ecx
    #ifndef NONE
    kmem.free_pages--;
80102b8b:	83 2d 7c 46 11 80 01 	subl   $0x1,0x8011467c
    kmem.freelist = r->next;
80102b92:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
    kmem.pg_refcount[index(V2P((char*)r))] = 1;
80102b98:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80102b9e:	c1 e9 0c             	shr    $0xc,%ecx
80102ba1:	c7 04 8d 84 46 11 80 	movl   $0x1,-0x7feeb97c(,%ecx,4)
80102ba8:	01 00 00 00 
    #endif
  }

  if(kmem.use_lock)
80102bac:	85 d2                	test   %edx,%edx
80102bae:	75 08                	jne    80102bb8 <kalloc+0x48>
    release(&kmem.lock);
  return (char*)r;
}
80102bb0:	c9                   	leave  
80102bb1:	c3                   	ret    
80102bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102bb8:	83 ec 0c             	sub    $0xc,%esp
80102bbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102bbe:	68 40 46 11 80       	push   $0x80114640
80102bc3:	e8 98 27 00 00       	call   80105360 <release>
  return (char*)r;
80102bc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102bcb:	83 c4 10             	add    $0x10,%esp
}
80102bce:	c9                   	leave  
80102bcf:	c3                   	ret    
    acquire(&kmem.lock);
80102bd0:	83 ec 0c             	sub    $0xc,%esp
80102bd3:	68 40 46 11 80       	push   $0x80114640
80102bd8:	e8 c3 26 00 00       	call   801052a0 <acquire>
  r = kmem.freelist;
80102bdd:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102be2:	83 c4 10             	add    $0x10,%esp
80102be5:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102beb:	85 c0                	test   %eax,%eax
80102bed:	75 9a                	jne    80102b89 <kalloc+0x19>
80102bef:	eb bb                	jmp    80102bac <kalloc+0x3c>
80102bf1:	eb 0d                	jmp    80102c00 <numFreePages>
80102bf3:	90                   	nop
80102bf4:	90                   	nop
80102bf5:	90                   	nop
80102bf6:	90                   	nop
80102bf7:	90                   	nop
80102bf8:	90                   	nop
80102bf9:	90                   	nop
80102bfa:	90                   	nop
80102bfb:	90                   	nop
80102bfc:	90                   	nop
80102bfd:	90                   	nop
80102bfe:	90                   	nop
80102bff:	90                   	nop

80102c00 <numFreePages>:

uint numFreePages(){
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	53                   	push   %ebx
80102c04:	83 ec 10             	sub    $0x10,%esp
  acquire(&kmem.lock);
80102c07:	68 40 46 11 80       	push   $0x80114640
80102c0c:	e8 8f 26 00 00       	call   801052a0 <acquire>
  uint free_pages = kmem.free_pages;
80102c11:	8b 1d 7c 46 11 80    	mov    0x8011467c,%ebx
  release(&kmem.lock);
80102c17:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102c1e:	e8 3d 27 00 00       	call   80105360 <release>
  return free_pages;
}
80102c23:	89 d8                	mov    %ebx,%eax
80102c25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c28:	c9                   	leave  
80102c29:	c3                   	ret    
80102c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102c30 <resetRefCounter>:

void resetRefCounter(uint pa){
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
  kmem.pg_refcount[index(pa)] = 1;
80102c33:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102c36:	5d                   	pop    %ebp
  kmem.pg_refcount[index(pa)] = 1;
80102c37:	c1 e8 0c             	shr    $0xc,%eax
80102c3a:	c7 04 85 84 46 11 80 	movl   $0x1,-0x7feeb97c(,%eax,4)
80102c41:	01 00 00 00 
}
80102c45:	c3                   	ret    
80102c46:	8d 76 00             	lea    0x0(%esi),%esi
80102c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c50 <decrementReferenceCount>:

void decrementReferenceCount(uint pa)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	53                   	push   %ebx
80102c54:	83 ec 04             	sub    $0x4,%esp
80102c57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("3");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102c5a:	81 fb c8 9b 15 00    	cmp    $0x159bc8,%ebx
80102c60:	72 33                	jb     80102c95 <decrementReferenceCount+0x45>
80102c62:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102c68:	77 2b                	ja     80102c95 <decrementReferenceCount+0x45>
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
80102c6a:	83 ec 0c             	sub    $0xc,%esp
  --kmem.pg_refcount[index(pa)];
80102c6d:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102c70:	68 40 46 11 80       	push   $0x80114640
80102c75:	e8 26 26 00 00       	call   801052a0 <acquire>
  --kmem.pg_refcount[index(pa)];
80102c7a:	83 2c 9d 84 46 11 80 	subl   $0x1,-0x7feeb97c(,%ebx,4)
80102c81:	01 
  release(&kmem.lock);
80102c82:	83 c4 10             	add    $0x10,%esp
80102c85:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)

}
80102c8c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c8f:	c9                   	leave  
  release(&kmem.lock);
80102c90:	e9 cb 26 00 00       	jmp    80105360 <release>
    panic("decrementReferenceCount");
80102c95:	83 ec 0c             	sub    $0xc,%esp
80102c98:	68 b6 8c 10 80       	push   $0x80108cb6
80102c9d:	e8 ee d6 ff ff       	call   80100390 <panic>
80102ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cb0 <incrementReferenceCount>:

void incrementReferenceCount(uint pa)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 04             	sub    $0x4,%esp
80102cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("2");
  // }
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102cba:	81 fb c8 9b 15 00    	cmp    $0x159bc8,%ebx
80102cc0:	72 33                	jb     80102cf5 <incrementReferenceCount+0x45>
80102cc2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102cc8:	77 2b                	ja     80102cf5 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102cca:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[index(pa)];
80102ccd:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102cd0:	68 40 46 11 80       	push   $0x80114640
80102cd5:	e8 c6 25 00 00       	call   801052a0 <acquire>
  ++kmem.pg_refcount[index(pa)];
80102cda:	83 04 9d 84 46 11 80 	addl   $0x1,-0x7feeb97c(,%ebx,4)
80102ce1:	01 
  release(&kmem.lock);
80102ce2:	83 c4 10             	add    $0x10,%esp
80102ce5:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102cec:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cef:	c9                   	leave  
  release(&kmem.lock);
80102cf0:	e9 6b 26 00 00       	jmp    80105360 <release>
    panic("incrementReferenceCount");
80102cf5:	83 ec 0c             	sub    $0xc,%esp
80102cf8:	68 ce 8c 10 80       	push   $0x80108cce
80102cfd:	e8 8e d6 ff ff       	call   80100390 <panic>
80102d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <setReferenceCount>:

void setReferenceCount(uint pa,int n)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	56                   	push   %esi
80102d14:	53                   	push   %ebx
80102d15:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d18:	8b 75 0c             	mov    0xc(%ebp),%esi

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102d1b:	81 fb c8 9b 15 00    	cmp    $0x159bc8,%ebx
80102d21:	72 34                	jb     80102d57 <setReferenceCount+0x47>
80102d23:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102d29:	77 2c                	ja     80102d57 <setReferenceCount+0x47>
    panic("setReferenceCount");

  acquire(&kmem.lock);
80102d2b:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[index(pa)]= n;
80102d2e:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102d31:	68 40 46 11 80       	push   $0x80114640
80102d36:	e8 65 25 00 00       	call   801052a0 <acquire>
  kmem.pg_refcount[index(pa)]= n;
80102d3b:	89 34 9d 84 46 11 80 	mov    %esi,-0x7feeb97c(,%ebx,4)
  release(&kmem.lock);
80102d42:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
80102d49:	83 c4 10             	add    $0x10,%esp
}
80102d4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d4f:	5b                   	pop    %ebx
80102d50:	5e                   	pop    %esi
80102d51:	5d                   	pop    %ebp
  release(&kmem.lock);
80102d52:	e9 09 26 00 00       	jmp    80105360 <release>
    panic("setReferenceCount");
80102d57:	83 ec 0c             	sub    $0xc,%esp
80102d5a:	68 e6 8c 10 80       	push   $0x80108ce6
80102d5f:	e8 2c d6 ff ff       	call   80100390 <panic>
80102d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102d70 <getReferenceCount>:

uint getReferenceCount(uint pa)
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 04             	sub    $0x4,%esp
80102d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("1");
  // }

  if( pa >= PHYSTOP)
80102d7a:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102d80:	77 2a                	ja     80102dac <getReferenceCount+0x3c>
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
80102d82:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pg_refcount[index(pa)];
80102d85:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102d88:	68 40 46 11 80       	push   $0x80114640
80102d8d:	e8 0e 25 00 00       	call   801052a0 <acquire>
  count = kmem.pg_refcount[index(pa)];
80102d92:	8b 1c 9d 84 46 11 80 	mov    -0x7feeb97c(,%ebx,4),%ebx
  release(&kmem.lock);
80102d99:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102da0:	e8 bb 25 00 00       	call   80105360 <release>

  return count;
}
80102da5:	89 d8                	mov    %ebx,%eax
80102da7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102daa:	c9                   	leave  
80102dab:	c3                   	ret    
    panic("getReferenceCount");
80102dac:	83 ec 0c             	sub    $0xc,%esp
80102daf:	68 f8 8c 10 80       	push   $0x80108cf8
80102db4:	e8 d7 d5 ff ff       	call   80100390 <panic>
80102db9:	66 90                	xchg   %ax,%ax
80102dbb:	66 90                	xchg   %ax,%ax
80102dbd:	66 90                	xchg   %ax,%ax
80102dbf:	90                   	nop

80102dc0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dc0:	ba 64 00 00 00       	mov    $0x64,%edx
80102dc5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102dc6:	a8 01                	test   $0x1,%al
80102dc8:	0f 84 c2 00 00 00    	je     80102e90 <kbdgetc+0xd0>
80102dce:	ba 60 00 00 00       	mov    $0x60,%edx
80102dd3:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102dd4:	0f b6 d0             	movzbl %al,%edx
80102dd7:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102ddd:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102de3:	0f 84 7f 00 00 00    	je     80102e68 <kbdgetc+0xa8>
{
80102de9:	55                   	push   %ebp
80102dea:	89 e5                	mov    %esp,%ebp
80102dec:	53                   	push   %ebx
80102ded:	89 cb                	mov    %ecx,%ebx
80102def:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102df2:	84 c0                	test   %al,%al
80102df4:	78 4a                	js     80102e40 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102df6:	85 db                	test   %ebx,%ebx
80102df8:	74 09                	je     80102e03 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102dfa:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102dfd:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102e00:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102e03:	0f b6 82 40 8e 10 80 	movzbl -0x7fef71c0(%edx),%eax
80102e0a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102e0c:	0f b6 82 40 8d 10 80 	movzbl -0x7fef72c0(%edx),%eax
80102e13:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102e15:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102e17:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102e1d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102e20:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102e23:	8b 04 85 20 8d 10 80 	mov    -0x7fef72e0(,%eax,4),%eax
80102e2a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102e2e:	74 31                	je     80102e61 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102e30:	8d 50 9f             	lea    -0x61(%eax),%edx
80102e33:	83 fa 19             	cmp    $0x19,%edx
80102e36:	77 40                	ja     80102e78 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102e38:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102e3b:	5b                   	pop    %ebx
80102e3c:	5d                   	pop    %ebp
80102e3d:	c3                   	ret    
80102e3e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102e40:	83 e0 7f             	and    $0x7f,%eax
80102e43:	85 db                	test   %ebx,%ebx
80102e45:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102e48:	0f b6 82 40 8e 10 80 	movzbl -0x7fef71c0(%edx),%eax
80102e4f:	83 c8 40             	or     $0x40,%eax
80102e52:	0f b6 c0             	movzbl %al,%eax
80102e55:	f7 d0                	not    %eax
80102e57:	21 c1                	and    %eax,%ecx
    return 0;
80102e59:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102e5b:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102e61:	5b                   	pop    %ebx
80102e62:	5d                   	pop    %ebp
80102e63:	c3                   	ret    
80102e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102e68:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102e6b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102e6d:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102e73:	c3                   	ret    
80102e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102e78:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102e7b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102e7e:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102e7f:	83 f9 1a             	cmp    $0x1a,%ecx
80102e82:	0f 42 c2             	cmovb  %edx,%eax
}
80102e85:	5d                   	pop    %ebp
80102e86:	c3                   	ret    
80102e87:	89 f6                	mov    %esi,%esi
80102e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102e90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102e95:	c3                   	ret    
80102e96:	8d 76 00             	lea    0x0(%esi),%esi
80102e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ea0 <kbdintr>:

void
kbdintr(void)
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102ea6:	68 c0 2d 10 80       	push   $0x80102dc0
80102eab:	e8 60 d9 ff ff       	call   80100810 <consoleintr>
}
80102eb0:	83 c4 10             	add    $0x10,%esp
80102eb3:	c9                   	leave  
80102eb4:	c3                   	ret    
80102eb5:	66 90                	xchg   %ax,%ax
80102eb7:	66 90                	xchg   %ax,%ax
80102eb9:	66 90                	xchg   %ax,%ax
80102ebb:	66 90                	xchg   %ax,%ax
80102ebd:	66 90                	xchg   %ax,%ax
80102ebf:	90                   	nop

80102ec0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102ec0:	a1 84 c6 14 80       	mov    0x8014c684,%eax
{
80102ec5:	55                   	push   %ebp
80102ec6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102ec8:	85 c0                	test   %eax,%eax
80102eca:	0f 84 c8 00 00 00    	je     80102f98 <lapicinit+0xd8>
  lapic[index] = value;
80102ed0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102ed7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102eda:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102edd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ee4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ee7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102eea:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102ef1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102ef4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ef7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102efe:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102f01:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f04:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102f0b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102f0e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f11:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102f18:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102f1b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f1e:	8b 50 30             	mov    0x30(%eax),%edx
80102f21:	c1 ea 10             	shr    $0x10,%edx
80102f24:	80 fa 03             	cmp    $0x3,%dl
80102f27:	77 77                	ja     80102fa0 <lapicinit+0xe0>
  lapic[index] = value;
80102f29:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102f30:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f33:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f36:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102f3d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f40:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f43:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102f4a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f4d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f50:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102f57:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f5a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f5d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102f64:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f67:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f6a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102f71:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102f74:	8b 50 20             	mov    0x20(%eax),%edx
80102f77:	89 f6                	mov    %esi,%esi
80102f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102f80:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102f86:	80 e6 10             	and    $0x10,%dh
80102f89:	75 f5                	jne    80102f80 <lapicinit+0xc0>
  lapic[index] = value;
80102f8b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102f92:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f95:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102f98:	5d                   	pop    %ebp
80102f99:	c3                   	ret    
80102f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102fa0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102fa7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102faa:	8b 50 20             	mov    0x20(%eax),%edx
80102fad:	e9 77 ff ff ff       	jmp    80102f29 <lapicinit+0x69>
80102fb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fc0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102fc0:	8b 15 84 c6 14 80    	mov    0x8014c684,%edx
{
80102fc6:	55                   	push   %ebp
80102fc7:	31 c0                	xor    %eax,%eax
80102fc9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102fcb:	85 d2                	test   %edx,%edx
80102fcd:	74 06                	je     80102fd5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102fcf:	8b 42 20             	mov    0x20(%edx),%eax
80102fd2:	c1 e8 18             	shr    $0x18,%eax
}
80102fd5:	5d                   	pop    %ebp
80102fd6:	c3                   	ret    
80102fd7:	89 f6                	mov    %esi,%esi
80102fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fe0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102fe0:	a1 84 c6 14 80       	mov    0x8014c684,%eax
{
80102fe5:	55                   	push   %ebp
80102fe6:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102fe8:	85 c0                	test   %eax,%eax
80102fea:	74 0d                	je     80102ff9 <lapiceoi+0x19>
  lapic[index] = value;
80102fec:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ff3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ff6:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ff9:	5d                   	pop    %ebp
80102ffa:	c3                   	ret    
80102ffb:	90                   	nop
80102ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103000 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
}
80103003:	5d                   	pop    %ebp
80103004:	c3                   	ret    
80103005:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103010 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103010:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103011:	b8 0f 00 00 00       	mov    $0xf,%eax
80103016:	ba 70 00 00 00       	mov    $0x70,%edx
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103021:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103024:	ee                   	out    %al,(%dx)
80103025:	b8 0a 00 00 00       	mov    $0xa,%eax
8010302a:	ba 71 00 00 00       	mov    $0x71,%edx
8010302f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103030:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103032:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103035:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010303b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010303d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80103040:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80103043:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80103045:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103048:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010304e:	a1 84 c6 14 80       	mov    0x8014c684,%eax
80103053:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103059:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010305c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103063:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103066:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103069:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103070:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103073:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103076:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010307c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010307f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103085:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103088:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010308e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103091:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103097:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010309a:	5b                   	pop    %ebx
8010309b:	5d                   	pop    %ebp
8010309c:	c3                   	ret    
8010309d:	8d 76 00             	lea    0x0(%esi),%esi

801030a0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801030a0:	55                   	push   %ebp
801030a1:	b8 0b 00 00 00       	mov    $0xb,%eax
801030a6:	ba 70 00 00 00       	mov    $0x70,%edx
801030ab:	89 e5                	mov    %esp,%ebp
801030ad:	57                   	push   %edi
801030ae:	56                   	push   %esi
801030af:	53                   	push   %ebx
801030b0:	83 ec 4c             	sub    $0x4c,%esp
801030b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030b4:	ba 71 00 00 00       	mov    $0x71,%edx
801030b9:	ec                   	in     (%dx),%al
801030ba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030bd:	bb 70 00 00 00       	mov    $0x70,%ebx
801030c2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801030c5:	8d 76 00             	lea    0x0(%esi),%esi
801030c8:	31 c0                	xor    %eax,%eax
801030ca:	89 da                	mov    %ebx,%edx
801030cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030cd:	b9 71 00 00 00       	mov    $0x71,%ecx
801030d2:	89 ca                	mov    %ecx,%edx
801030d4:	ec                   	in     (%dx),%al
801030d5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030d8:	89 da                	mov    %ebx,%edx
801030da:	b8 02 00 00 00       	mov    $0x2,%eax
801030df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030e0:	89 ca                	mov    %ecx,%edx
801030e2:	ec                   	in     (%dx),%al
801030e3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030e6:	89 da                	mov    %ebx,%edx
801030e8:	b8 04 00 00 00       	mov    $0x4,%eax
801030ed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030ee:	89 ca                	mov    %ecx,%edx
801030f0:	ec                   	in     (%dx),%al
801030f1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030f4:	89 da                	mov    %ebx,%edx
801030f6:	b8 07 00 00 00       	mov    $0x7,%eax
801030fb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030fc:	89 ca                	mov    %ecx,%edx
801030fe:	ec                   	in     (%dx),%al
801030ff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103102:	89 da                	mov    %ebx,%edx
80103104:	b8 08 00 00 00       	mov    $0x8,%eax
80103109:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010310a:	89 ca                	mov    %ecx,%edx
8010310c:	ec                   	in     (%dx),%al
8010310d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010310f:	89 da                	mov    %ebx,%edx
80103111:	b8 09 00 00 00       	mov    $0x9,%eax
80103116:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103117:	89 ca                	mov    %ecx,%edx
80103119:	ec                   	in     (%dx),%al
8010311a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010311c:	89 da                	mov    %ebx,%edx
8010311e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103123:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103124:	89 ca                	mov    %ecx,%edx
80103126:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103127:	84 c0                	test   %al,%al
80103129:	78 9d                	js     801030c8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010312b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010312f:	89 fa                	mov    %edi,%edx
80103131:	0f b6 fa             	movzbl %dl,%edi
80103134:	89 f2                	mov    %esi,%edx
80103136:	0f b6 f2             	movzbl %dl,%esi
80103139:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010313c:	89 da                	mov    %ebx,%edx
8010313e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103141:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103144:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103148:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010314b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010314f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103152:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103156:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103159:	31 c0                	xor    %eax,%eax
8010315b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010315c:	89 ca                	mov    %ecx,%edx
8010315e:	ec                   	in     (%dx),%al
8010315f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103162:	89 da                	mov    %ebx,%edx
80103164:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103167:	b8 02 00 00 00       	mov    $0x2,%eax
8010316c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010316d:	89 ca                	mov    %ecx,%edx
8010316f:	ec                   	in     (%dx),%al
80103170:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103173:	89 da                	mov    %ebx,%edx
80103175:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103178:	b8 04 00 00 00       	mov    $0x4,%eax
8010317d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010317e:	89 ca                	mov    %ecx,%edx
80103180:	ec                   	in     (%dx),%al
80103181:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103184:	89 da                	mov    %ebx,%edx
80103186:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103189:	b8 07 00 00 00       	mov    $0x7,%eax
8010318e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010318f:	89 ca                	mov    %ecx,%edx
80103191:	ec                   	in     (%dx),%al
80103192:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103195:	89 da                	mov    %ebx,%edx
80103197:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010319a:	b8 08 00 00 00       	mov    $0x8,%eax
8010319f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031a0:	89 ca                	mov    %ecx,%edx
801031a2:	ec                   	in     (%dx),%al
801031a3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031a6:	89 da                	mov    %ebx,%edx
801031a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801031ab:	b8 09 00 00 00       	mov    $0x9,%eax
801031b0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031b1:	89 ca                	mov    %ecx,%edx
801031b3:	ec                   	in     (%dx),%al
801031b4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801031b7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801031ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801031bd:	8d 45 d0             	lea    -0x30(%ebp),%eax
801031c0:	6a 18                	push   $0x18
801031c2:	50                   	push   %eax
801031c3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801031c6:	50                   	push   %eax
801031c7:	e8 34 22 00 00       	call   80105400 <memcmp>
801031cc:	83 c4 10             	add    $0x10,%esp
801031cf:	85 c0                	test   %eax,%eax
801031d1:	0f 85 f1 fe ff ff    	jne    801030c8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801031d7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
801031db:	75 78                	jne    80103255 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801031dd:	8b 45 b8             	mov    -0x48(%ebp),%eax
801031e0:	89 c2                	mov    %eax,%edx
801031e2:	83 e0 0f             	and    $0xf,%eax
801031e5:	c1 ea 04             	shr    $0x4,%edx
801031e8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801031eb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801031ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801031f1:	8b 45 bc             	mov    -0x44(%ebp),%eax
801031f4:	89 c2                	mov    %eax,%edx
801031f6:	83 e0 0f             	and    $0xf,%eax
801031f9:	c1 ea 04             	shr    $0x4,%edx
801031fc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801031ff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103202:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103205:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103208:	89 c2                	mov    %eax,%edx
8010320a:	83 e0 0f             	and    $0xf,%eax
8010320d:	c1 ea 04             	shr    $0x4,%edx
80103210:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103213:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103216:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103219:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010321c:	89 c2                	mov    %eax,%edx
8010321e:	83 e0 0f             	and    $0xf,%eax
80103221:	c1 ea 04             	shr    $0x4,%edx
80103224:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103227:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010322a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010322d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103230:	89 c2                	mov    %eax,%edx
80103232:	83 e0 0f             	and    $0xf,%eax
80103235:	c1 ea 04             	shr    $0x4,%edx
80103238:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010323b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010323e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103241:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103244:	89 c2                	mov    %eax,%edx
80103246:	83 e0 0f             	and    $0xf,%eax
80103249:	c1 ea 04             	shr    $0x4,%edx
8010324c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010324f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103252:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103255:	8b 75 08             	mov    0x8(%ebp),%esi
80103258:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010325b:	89 06                	mov    %eax,(%esi)
8010325d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103260:	89 46 04             	mov    %eax,0x4(%esi)
80103263:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103266:	89 46 08             	mov    %eax,0x8(%esi)
80103269:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010326c:	89 46 0c             	mov    %eax,0xc(%esi)
8010326f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103272:	89 46 10             	mov    %eax,0x10(%esi)
80103275:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103278:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010327b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103282:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103285:	5b                   	pop    %ebx
80103286:	5e                   	pop    %esi
80103287:	5f                   	pop    %edi
80103288:	5d                   	pop    %ebp
80103289:	c3                   	ret    
8010328a:	66 90                	xchg   %ax,%ax
8010328c:	66 90                	xchg   %ax,%ax
8010328e:	66 90                	xchg   %ax,%ax

80103290 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103290:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103296:	85 c9                	test   %ecx,%ecx
80103298:	0f 8e 8a 00 00 00    	jle    80103328 <install_trans+0x98>
{
8010329e:	55                   	push   %ebp
8010329f:	89 e5                	mov    %esp,%ebp
801032a1:	57                   	push   %edi
801032a2:	56                   	push   %esi
801032a3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
801032a4:	31 db                	xor    %ebx,%ebx
{
801032a6:	83 ec 0c             	sub    $0xc,%esp
801032a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801032b0:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
801032b5:	83 ec 08             	sub    $0x8,%esp
801032b8:	01 d8                	add    %ebx,%eax
801032ba:	83 c0 01             	add    $0x1,%eax
801032bd:	50                   	push   %eax
801032be:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
801032c4:	e8 07 ce ff ff       	call   801000d0 <bread>
801032c9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032cb:	58                   	pop    %eax
801032cc:	5a                   	pop    %edx
801032cd:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
801032d4:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
801032da:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801032dd:	e8 ee cd ff ff       	call   801000d0 <bread>
801032e2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801032e4:	8d 47 5c             	lea    0x5c(%edi),%eax
801032e7:	83 c4 0c             	add    $0xc,%esp
801032ea:	68 00 02 00 00       	push   $0x200
801032ef:	50                   	push   %eax
801032f0:	8d 46 5c             	lea    0x5c(%esi),%eax
801032f3:	50                   	push   %eax
801032f4:	e8 67 21 00 00       	call   80105460 <memmove>
    bwrite(dbuf);  // write dst to disk
801032f9:	89 34 24             	mov    %esi,(%esp)
801032fc:	e8 9f ce ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103301:	89 3c 24             	mov    %edi,(%esp)
80103304:	e8 d7 ce ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103309:	89 34 24             	mov    %esi,(%esp)
8010330c:	e8 cf ce ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103311:	83 c4 10             	add    $0x10,%esp
80103314:	39 1d e8 c6 14 80    	cmp    %ebx,0x8014c6e8
8010331a:	7f 94                	jg     801032b0 <install_trans+0x20>
  }
}
8010331c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010331f:	5b                   	pop    %ebx
80103320:	5e                   	pop    %esi
80103321:	5f                   	pop    %edi
80103322:	5d                   	pop    %ebp
80103323:	c3                   	ret    
80103324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103328:	f3 c3                	repz ret 
8010332a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103330 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	56                   	push   %esi
80103334:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80103335:	83 ec 08             	sub    $0x8,%esp
80103338:	ff 35 d4 c6 14 80    	pushl  0x8014c6d4
8010333e:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103344:	e8 87 cd ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103349:	8b 1d e8 c6 14 80    	mov    0x8014c6e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
8010334f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103352:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80103354:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80103356:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103359:	7e 16                	jle    80103371 <write_head+0x41>
8010335b:	c1 e3 02             	shl    $0x2,%ebx
8010335e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80103360:	8b 8a ec c6 14 80    	mov    -0x7feb3914(%edx),%ecx
80103366:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
8010336a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
8010336d:	39 da                	cmp    %ebx,%edx
8010336f:	75 ef                	jne    80103360 <write_head+0x30>
  }
  bwrite(buf);
80103371:	83 ec 0c             	sub    $0xc,%esp
80103374:	56                   	push   %esi
80103375:	e8 26 ce ff ff       	call   801001a0 <bwrite>
  brelse(buf);
8010337a:	89 34 24             	mov    %esi,(%esp)
8010337d:	e8 5e ce ff ff       	call   801001e0 <brelse>
}
80103382:	83 c4 10             	add    $0x10,%esp
80103385:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103388:	5b                   	pop    %ebx
80103389:	5e                   	pop    %esi
8010338a:	5d                   	pop    %ebp
8010338b:	c3                   	ret    
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103390 <initlog>:
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	53                   	push   %ebx
80103394:	83 ec 2c             	sub    $0x2c,%esp
80103397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010339a:	68 40 8f 10 80       	push   $0x80108f40
8010339f:	68 a0 c6 14 80       	push   $0x8014c6a0
801033a4:	e8 b7 1d 00 00       	call   80105160 <initlock>
  readsb(dev, &sb);
801033a9:	58                   	pop    %eax
801033aa:	8d 45 dc             	lea    -0x24(%ebp),%eax
801033ad:	5a                   	pop    %edx
801033ae:	50                   	push   %eax
801033af:	53                   	push   %ebx
801033b0:	e8 9b e2 ff ff       	call   80101650 <readsb>
  log.size = sb.nlog;
801033b5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801033b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801033bb:	59                   	pop    %ecx
  log.dev = dev;
801033bc:	89 1d e4 c6 14 80    	mov    %ebx,0x8014c6e4
  log.size = sb.nlog;
801033c2:	89 15 d8 c6 14 80    	mov    %edx,0x8014c6d8
  log.start = sb.logstart;
801033c8:	a3 d4 c6 14 80       	mov    %eax,0x8014c6d4
  struct buf *buf = bread(log.dev, log.start);
801033cd:	5a                   	pop    %edx
801033ce:	50                   	push   %eax
801033cf:	53                   	push   %ebx
801033d0:	e8 fb cc ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
801033d5:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
801033d8:	83 c4 10             	add    $0x10,%esp
801033db:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
801033dd:	89 1d e8 c6 14 80    	mov    %ebx,0x8014c6e8
  for (i = 0; i < log.lh.n; i++) {
801033e3:	7e 1c                	jle    80103401 <initlog+0x71>
801033e5:	c1 e3 02             	shl    $0x2,%ebx
801033e8:	31 d2                	xor    %edx,%edx
801033ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
801033f0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
801033f4:	83 c2 04             	add    $0x4,%edx
801033f7:	89 8a e8 c6 14 80    	mov    %ecx,-0x7feb3918(%edx)
  for (i = 0; i < log.lh.n; i++) {
801033fd:	39 d3                	cmp    %edx,%ebx
801033ff:	75 ef                	jne    801033f0 <initlog+0x60>
  brelse(buf);
80103401:	83 ec 0c             	sub    $0xc,%esp
80103404:	50                   	push   %eax
80103405:	e8 d6 cd ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010340a:	e8 81 fe ff ff       	call   80103290 <install_trans>
  log.lh.n = 0;
8010340f:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
80103416:	00 00 00 
  write_head(); // clear the log
80103419:	e8 12 ff ff ff       	call   80103330 <write_head>
}
8010341e:	83 c4 10             	add    $0x10,%esp
80103421:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103424:	c9                   	leave  
80103425:	c3                   	ret    
80103426:	8d 76 00             	lea    0x0(%esi),%esi
80103429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103430 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103436:	68 a0 c6 14 80       	push   $0x8014c6a0
8010343b:	e8 60 1e 00 00       	call   801052a0 <acquire>
80103440:	83 c4 10             	add    $0x10,%esp
80103443:	eb 18                	jmp    8010345d <begin_op+0x2d>
80103445:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103448:	83 ec 08             	sub    $0x8,%esp
8010344b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103450:	68 a0 c6 14 80       	push   $0x8014c6a0
80103455:	e8 16 13 00 00       	call   80104770 <sleep>
8010345a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010345d:	a1 e0 c6 14 80       	mov    0x8014c6e0,%eax
80103462:	85 c0                	test   %eax,%eax
80103464:	75 e2                	jne    80103448 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103466:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010346b:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
80103471:	83 c0 01             	add    $0x1,%eax
80103474:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103477:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010347a:	83 fa 1e             	cmp    $0x1e,%edx
8010347d:	7f c9                	jg     80103448 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010347f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103482:	a3 dc c6 14 80       	mov    %eax,0x8014c6dc
      release(&log.lock);
80103487:	68 a0 c6 14 80       	push   $0x8014c6a0
8010348c:	e8 cf 1e 00 00       	call   80105360 <release>
      break;
    }
  }
}
80103491:	83 c4 10             	add    $0x10,%esp
80103494:	c9                   	leave  
80103495:	c3                   	ret    
80103496:	8d 76 00             	lea    0x0(%esi),%esi
80103499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	57                   	push   %edi
801034a4:	56                   	push   %esi
801034a5:	53                   	push   %ebx
801034a6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801034a9:	68 a0 c6 14 80       	push   $0x8014c6a0
801034ae:	e8 ed 1d 00 00       	call   801052a0 <acquire>
  log.outstanding -= 1;
801034b3:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
  if(log.committing)
801034b8:	8b 35 e0 c6 14 80    	mov    0x8014c6e0,%esi
801034be:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801034c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
801034c4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
801034c6:	89 1d dc c6 14 80    	mov    %ebx,0x8014c6dc
  if(log.committing)
801034cc:	0f 85 1a 01 00 00    	jne    801035ec <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
801034d2:	85 db                	test   %ebx,%ebx
801034d4:	0f 85 ee 00 00 00    	jne    801035c8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801034da:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
801034dd:	c7 05 e0 c6 14 80 01 	movl   $0x1,0x8014c6e0
801034e4:	00 00 00 
  release(&log.lock);
801034e7:	68 a0 c6 14 80       	push   $0x8014c6a0
801034ec:	e8 6f 1e 00 00       	call   80105360 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801034f1:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
801034f7:	83 c4 10             	add    $0x10,%esp
801034fa:	85 c9                	test   %ecx,%ecx
801034fc:	0f 8e 85 00 00 00    	jle    80103587 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103502:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103507:	83 ec 08             	sub    $0x8,%esp
8010350a:	01 d8                	add    %ebx,%eax
8010350c:	83 c0 01             	add    $0x1,%eax
8010350f:	50                   	push   %eax
80103510:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103516:	e8 b5 cb ff ff       	call   801000d0 <bread>
8010351b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010351d:	58                   	pop    %eax
8010351e:	5a                   	pop    %edx
8010351f:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103526:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010352c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010352f:	e8 9c cb ff ff       	call   801000d0 <bread>
80103534:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103536:	8d 40 5c             	lea    0x5c(%eax),%eax
80103539:	83 c4 0c             	add    $0xc,%esp
8010353c:	68 00 02 00 00       	push   $0x200
80103541:	50                   	push   %eax
80103542:	8d 46 5c             	lea    0x5c(%esi),%eax
80103545:	50                   	push   %eax
80103546:	e8 15 1f 00 00       	call   80105460 <memmove>
    bwrite(to);  // write the log
8010354b:	89 34 24             	mov    %esi,(%esp)
8010354e:	e8 4d cc ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103553:	89 3c 24             	mov    %edi,(%esp)
80103556:	e8 85 cc ff ff       	call   801001e0 <brelse>
    brelse(to);
8010355b:	89 34 24             	mov    %esi,(%esp)
8010355e:	e8 7d cc ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103563:	83 c4 10             	add    $0x10,%esp
80103566:	3b 1d e8 c6 14 80    	cmp    0x8014c6e8,%ebx
8010356c:	7c 94                	jl     80103502 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010356e:	e8 bd fd ff ff       	call   80103330 <write_head>
    install_trans(); // Now install writes to home locations
80103573:	e8 18 fd ff ff       	call   80103290 <install_trans>
    log.lh.n = 0;
80103578:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
8010357f:	00 00 00 
    write_head();    // Erase the transaction from the log
80103582:	e8 a9 fd ff ff       	call   80103330 <write_head>
    acquire(&log.lock);
80103587:	83 ec 0c             	sub    $0xc,%esp
8010358a:	68 a0 c6 14 80       	push   $0x8014c6a0
8010358f:	e8 0c 1d 00 00       	call   801052a0 <acquire>
    wakeup(&log);
80103594:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
    log.committing = 0;
8010359b:	c7 05 e0 c6 14 80 00 	movl   $0x0,0x8014c6e0
801035a2:	00 00 00 
    wakeup(&log);
801035a5:	e8 e6 13 00 00       	call   80104990 <wakeup>
    release(&log.lock);
801035aa:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
801035b1:	e8 aa 1d 00 00       	call   80105360 <release>
801035b6:	83 c4 10             	add    $0x10,%esp
}
801035b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035bc:	5b                   	pop    %ebx
801035bd:	5e                   	pop    %esi
801035be:	5f                   	pop    %edi
801035bf:	5d                   	pop    %ebp
801035c0:	c3                   	ret    
801035c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
801035c8:	83 ec 0c             	sub    $0xc,%esp
801035cb:	68 a0 c6 14 80       	push   $0x8014c6a0
801035d0:	e8 bb 13 00 00       	call   80104990 <wakeup>
  release(&log.lock);
801035d5:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
801035dc:	e8 7f 1d 00 00       	call   80105360 <release>
801035e1:	83 c4 10             	add    $0x10,%esp
}
801035e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035e7:	5b                   	pop    %ebx
801035e8:	5e                   	pop    %esi
801035e9:	5f                   	pop    %edi
801035ea:	5d                   	pop    %ebp
801035eb:	c3                   	ret    
    panic("log.committing");
801035ec:	83 ec 0c             	sub    $0xc,%esp
801035ef:	68 44 8f 10 80       	push   $0x80108f44
801035f4:	e8 97 cd ff ff       	call   80100390 <panic>
801035f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103600 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
80103604:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103607:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
{
8010360d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103610:	83 fa 1d             	cmp    $0x1d,%edx
80103613:	0f 8f 9d 00 00 00    	jg     801036b6 <log_write+0xb6>
80103619:	a1 d8 c6 14 80       	mov    0x8014c6d8,%eax
8010361e:	83 e8 01             	sub    $0x1,%eax
80103621:	39 c2                	cmp    %eax,%edx
80103623:	0f 8d 8d 00 00 00    	jge    801036b6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103629:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010362e:	85 c0                	test   %eax,%eax
80103630:	0f 8e 8d 00 00 00    	jle    801036c3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103636:	83 ec 0c             	sub    $0xc,%esp
80103639:	68 a0 c6 14 80       	push   $0x8014c6a0
8010363e:	e8 5d 1c 00 00       	call   801052a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103643:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103649:	83 c4 10             	add    $0x10,%esp
8010364c:	83 f9 00             	cmp    $0x0,%ecx
8010364f:	7e 57                	jle    801036a8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103651:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80103654:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103656:	3b 15 ec c6 14 80    	cmp    0x8014c6ec,%edx
8010365c:	75 0b                	jne    80103669 <log_write+0x69>
8010365e:	eb 38                	jmp    80103698 <log_write+0x98>
80103660:	39 14 85 ec c6 14 80 	cmp    %edx,-0x7feb3914(,%eax,4)
80103667:	74 2f                	je     80103698 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103669:	83 c0 01             	add    $0x1,%eax
8010366c:	39 c1                	cmp    %eax,%ecx
8010366e:	75 f0                	jne    80103660 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103670:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80103677:	83 c0 01             	add    $0x1,%eax
8010367a:	a3 e8 c6 14 80       	mov    %eax,0x8014c6e8
  b->flags |= B_DIRTY; // prevent eviction
8010367f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103682:	c7 45 08 a0 c6 14 80 	movl   $0x8014c6a0,0x8(%ebp)
}
80103689:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010368c:	c9                   	leave  
  release(&log.lock);
8010368d:	e9 ce 1c 00 00       	jmp    80105360 <release>
80103692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103698:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
8010369f:	eb de                	jmp    8010367f <log_write+0x7f>
801036a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036a8:	8b 43 08             	mov    0x8(%ebx),%eax
801036ab:	a3 ec c6 14 80       	mov    %eax,0x8014c6ec
  if (i == log.lh.n)
801036b0:	75 cd                	jne    8010367f <log_write+0x7f>
801036b2:	31 c0                	xor    %eax,%eax
801036b4:	eb c1                	jmp    80103677 <log_write+0x77>
    panic("too big a transaction");
801036b6:	83 ec 0c             	sub    $0xc,%esp
801036b9:	68 53 8f 10 80       	push   $0x80108f53
801036be:	e8 cd cc ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801036c3:	83 ec 0c             	sub    $0xc,%esp
801036c6:	68 69 8f 10 80       	push   $0x80108f69
801036cb:	e8 c0 cc ff ff       	call   80100390 <panic>

801036d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	53                   	push   %ebx
801036d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801036d7:	e8 24 0a 00 00       	call   80104100 <cpuid>
801036dc:	89 c3                	mov    %eax,%ebx
801036de:	e8 1d 0a 00 00       	call   80104100 <cpuid>
801036e3:	83 ec 04             	sub    $0x4,%esp
801036e6:	53                   	push   %ebx
801036e7:	50                   	push   %eax
801036e8:	68 84 8f 10 80       	push   $0x80108f84
801036ed:	e8 6e cf ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
801036f2:	e8 e9 2f 00 00       	call   801066e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801036f7:	e8 84 09 00 00       	call   80104080 <mycpu>
801036fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801036fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103703:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010370a:	e8 b1 0e 00 00       	call   801045c0 <scheduler>
8010370f:	90                   	nop

80103710 <mpenter>:
{
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103716:	e8 c5 41 00 00       	call   801078e0 <switchkvm>
  seginit();
8010371b:	e8 10 40 00 00       	call   80107730 <seginit>
  lapicinit();
80103720:	e8 9b f7 ff ff       	call   80102ec0 <lapicinit>
  mpmain();
80103725:	e8 a6 ff ff ff       	call   801036d0 <mpmain>
8010372a:	66 90                	xchg   %ax,%ax
8010372c:	66 90                	xchg   %ax,%ax
8010372e:	66 90                	xchg   %ax,%ax

80103730 <main>:
{
80103730:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103734:	83 e4 f0             	and    $0xfffffff0,%esp
80103737:	ff 71 fc             	pushl  -0x4(%ecx)
8010373a:	55                   	push   %ebp
8010373b:	89 e5                	mov    %esp,%ebp
8010373d:	53                   	push   %ebx
8010373e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010373f:	83 ec 08             	sub    $0x8,%esp
80103742:	68 00 00 40 80       	push   $0x80400000
80103747:	68 c8 9b 15 80       	push   $0x80159bc8
8010374c:	e8 3f f3 ff ff       	call   80102a90 <kinit1>
  kvmalloc();      // kernel page table
80103751:	e8 3a 4d 00 00       	call   80108490 <kvmalloc>
  mpinit();        // detect other processors
80103756:	e8 75 01 00 00       	call   801038d0 <mpinit>
  lapicinit();     // interrupt controller
8010375b:	e8 60 f7 ff ff       	call   80102ec0 <lapicinit>
  seginit();       // segment descriptors
80103760:	e8 cb 3f 00 00       	call   80107730 <seginit>
  picinit();       // disable pic
80103765:	e8 46 03 00 00       	call   80103ab0 <picinit>
  ioapicinit();    // another interrupt controller
8010376a:	e8 51 f0 ff ff       	call   801027c0 <ioapicinit>
  consoleinit();   // console hardware
8010376f:	e8 4c d2 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80103774:	e8 37 34 00 00       	call   80106bb0 <uartinit>
  pinit();         // process table
80103779:	e8 e2 08 00 00       	call   80104060 <pinit>
  tvinit();        // trap vectors
8010377e:	e8 dd 2e 00 00       	call   80106660 <tvinit>
  binit();         // buffer cache
80103783:	e8 b8 c8 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103788:	e8 e3 d7 ff ff       	call   80100f70 <fileinit>
  ideinit();       // disk 
8010378d:	e8 0e ee ff ff       	call   801025a0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103792:	83 c4 0c             	add    $0xc,%esp
80103795:	68 8a 00 00 00       	push   $0x8a
8010379a:	68 8c c4 10 80       	push   $0x8010c48c
8010379f:	68 00 70 00 80       	push   $0x80007000
801037a4:	e8 b7 1c 00 00       	call   80105460 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801037a9:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
801037b0:	00 00 00 
801037b3:	83 c4 10             	add    $0x10,%esp
801037b6:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
801037bb:	3d a0 c7 14 80       	cmp    $0x8014c7a0,%eax
801037c0:	76 71                	jbe    80103833 <main+0x103>
801037c2:	bb a0 c7 14 80       	mov    $0x8014c7a0,%ebx
801037c7:	89 f6                	mov    %esi,%esi
801037c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
801037d0:	e8 ab 08 00 00       	call   80104080 <mycpu>
801037d5:	39 d8                	cmp    %ebx,%eax
801037d7:	74 41                	je     8010381a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801037d9:	e8 92 f3 ff ff       	call   80102b70 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
801037de:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
801037e3:	c7 05 f8 6f 00 80 10 	movl   $0x80103710,0x80006ff8
801037ea:	37 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801037ed:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
801037f4:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801037f7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
801037fc:	0f b6 03             	movzbl (%ebx),%eax
801037ff:	83 ec 08             	sub    $0x8,%esp
80103802:	68 00 70 00 00       	push   $0x7000
80103807:	50                   	push   %eax
80103808:	e8 03 f8 ff ff       	call   80103010 <lapicstartap>
8010380d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103810:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103816:	85 c0                	test   %eax,%eax
80103818:	74 f6                	je     80103810 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010381a:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103821:	00 00 00 
80103824:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010382a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010382f:	39 c3                	cmp    %eax,%ebx
80103831:	72 9d                	jb     801037d0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103833:	83 ec 08             	sub    $0x8,%esp
80103836:	68 00 00 00 8e       	push   $0x8e000000
8010383b:	68 00 00 40 80       	push   $0x80400000
80103840:	e8 cb f2 ff ff       	call   80102b10 <kinit2>
  userinit();      // first user process
80103845:	e8 06 09 00 00       	call   80104150 <userinit>
  mpmain();        // finish this processor's setup
8010384a:	e8 81 fe ff ff       	call   801036d0 <mpmain>
8010384f:	90                   	nop

80103850 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	57                   	push   %edi
80103854:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103855:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010385b:	53                   	push   %ebx
  e = addr+len;
8010385c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010385f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103862:	39 de                	cmp    %ebx,%esi
80103864:	72 10                	jb     80103876 <mpsearch1+0x26>
80103866:	eb 50                	jmp    801038b8 <mpsearch1+0x68>
80103868:	90                   	nop
80103869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103870:	39 fb                	cmp    %edi,%ebx
80103872:	89 fe                	mov    %edi,%esi
80103874:	76 42                	jbe    801038b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103876:	83 ec 04             	sub    $0x4,%esp
80103879:	8d 7e 10             	lea    0x10(%esi),%edi
8010387c:	6a 04                	push   $0x4
8010387e:	68 98 8f 10 80       	push   $0x80108f98
80103883:	56                   	push   %esi
80103884:	e8 77 1b 00 00       	call   80105400 <memcmp>
80103889:	83 c4 10             	add    $0x10,%esp
8010388c:	85 c0                	test   %eax,%eax
8010388e:	75 e0                	jne    80103870 <mpsearch1+0x20>
80103890:	89 f1                	mov    %esi,%ecx
80103892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103898:	0f b6 11             	movzbl (%ecx),%edx
8010389b:	83 c1 01             	add    $0x1,%ecx
8010389e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801038a0:	39 f9                	cmp    %edi,%ecx
801038a2:	75 f4                	jne    80103898 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801038a4:	84 c0                	test   %al,%al
801038a6:	75 c8                	jne    80103870 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801038a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038ab:	89 f0                	mov    %esi,%eax
801038ad:	5b                   	pop    %ebx
801038ae:	5e                   	pop    %esi
801038af:	5f                   	pop    %edi
801038b0:	5d                   	pop    %ebp
801038b1:	c3                   	ret    
801038b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801038bb:	31 f6                	xor    %esi,%esi
}
801038bd:	89 f0                	mov    %esi,%eax
801038bf:	5b                   	pop    %ebx
801038c0:	5e                   	pop    %esi
801038c1:	5f                   	pop    %edi
801038c2:	5d                   	pop    %ebp
801038c3:	c3                   	ret    
801038c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	57                   	push   %edi
801038d4:	56                   	push   %esi
801038d5:	53                   	push   %ebx
801038d6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801038d9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801038e0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801038e7:	c1 e0 08             	shl    $0x8,%eax
801038ea:	09 d0                	or     %edx,%eax
801038ec:	c1 e0 04             	shl    $0x4,%eax
801038ef:	85 c0                	test   %eax,%eax
801038f1:	75 1b                	jne    8010390e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801038f3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801038fa:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103901:	c1 e0 08             	shl    $0x8,%eax
80103904:	09 d0                	or     %edx,%eax
80103906:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103909:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010390e:	ba 00 04 00 00       	mov    $0x400,%edx
80103913:	e8 38 ff ff ff       	call   80103850 <mpsearch1>
80103918:	85 c0                	test   %eax,%eax
8010391a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010391d:	0f 84 3d 01 00 00    	je     80103a60 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103923:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103926:	8b 58 04             	mov    0x4(%eax),%ebx
80103929:	85 db                	test   %ebx,%ebx
8010392b:	0f 84 4f 01 00 00    	je     80103a80 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103931:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103937:	83 ec 04             	sub    $0x4,%esp
8010393a:	6a 04                	push   $0x4
8010393c:	68 b5 8f 10 80       	push   $0x80108fb5
80103941:	56                   	push   %esi
80103942:	e8 b9 1a 00 00       	call   80105400 <memcmp>
80103947:	83 c4 10             	add    $0x10,%esp
8010394a:	85 c0                	test   %eax,%eax
8010394c:	0f 85 2e 01 00 00    	jne    80103a80 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103952:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103959:	3c 01                	cmp    $0x1,%al
8010395b:	0f 95 c2             	setne  %dl
8010395e:	3c 04                	cmp    $0x4,%al
80103960:	0f 95 c0             	setne  %al
80103963:	20 c2                	and    %al,%dl
80103965:	0f 85 15 01 00 00    	jne    80103a80 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010396b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103972:	66 85 ff             	test   %di,%di
80103975:	74 1a                	je     80103991 <mpinit+0xc1>
80103977:	89 f0                	mov    %esi,%eax
80103979:	01 f7                	add    %esi,%edi
  sum = 0;
8010397b:	31 d2                	xor    %edx,%edx
8010397d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103980:	0f b6 08             	movzbl (%eax),%ecx
80103983:	83 c0 01             	add    $0x1,%eax
80103986:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103988:	39 c7                	cmp    %eax,%edi
8010398a:	75 f4                	jne    80103980 <mpinit+0xb0>
8010398c:	84 d2                	test   %dl,%dl
8010398e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103991:	85 f6                	test   %esi,%esi
80103993:	0f 84 e7 00 00 00    	je     80103a80 <mpinit+0x1b0>
80103999:	84 d2                	test   %dl,%dl
8010399b:	0f 85 df 00 00 00    	jne    80103a80 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801039a1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801039a7:	a3 84 c6 14 80       	mov    %eax,0x8014c684
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039ac:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801039b3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801039b9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039be:	01 d6                	add    %edx,%esi
801039c0:	39 c6                	cmp    %eax,%esi
801039c2:	76 23                	jbe    801039e7 <mpinit+0x117>
    switch(*p){
801039c4:	0f b6 10             	movzbl (%eax),%edx
801039c7:	80 fa 04             	cmp    $0x4,%dl
801039ca:	0f 87 ca 00 00 00    	ja     80103a9a <mpinit+0x1ca>
801039d0:	ff 24 95 dc 8f 10 80 	jmp    *-0x7fef7024(,%edx,4)
801039d7:	89 f6                	mov    %esi,%esi
801039d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801039e0:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039e3:	39 c6                	cmp    %eax,%esi
801039e5:	77 dd                	ja     801039c4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801039e7:	85 db                	test   %ebx,%ebx
801039e9:	0f 84 9e 00 00 00    	je     80103a8d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801039ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801039f2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
801039f6:	74 15                	je     80103a0d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801039f8:	b8 70 00 00 00       	mov    $0x70,%eax
801039fd:	ba 22 00 00 00       	mov    $0x22,%edx
80103a02:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a03:	ba 23 00 00 00       	mov    $0x23,%edx
80103a08:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103a09:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a0c:	ee                   	out    %al,(%dx)
  }
}
80103a0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a10:	5b                   	pop    %ebx
80103a11:	5e                   	pop    %esi
80103a12:	5f                   	pop    %edi
80103a13:	5d                   	pop    %ebp
80103a14:	c3                   	ret    
80103a15:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103a18:	8b 0d 20 cd 14 80    	mov    0x8014cd20,%ecx
80103a1e:	83 f9 07             	cmp    $0x7,%ecx
80103a21:	7f 19                	jg     80103a3c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103a23:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103a27:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
80103a2d:	83 c1 01             	add    $0x1,%ecx
80103a30:	89 0d 20 cd 14 80    	mov    %ecx,0x8014cd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103a36:	88 97 a0 c7 14 80    	mov    %dl,-0x7feb3860(%edi)
      p += sizeof(struct mpproc);
80103a3c:	83 c0 14             	add    $0x14,%eax
      continue;
80103a3f:	e9 7c ff ff ff       	jmp    801039c0 <mpinit+0xf0>
80103a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103a48:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103a4c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103a4f:	88 15 80 c7 14 80    	mov    %dl,0x8014c780
      continue;
80103a55:	e9 66 ff ff ff       	jmp    801039c0 <mpinit+0xf0>
80103a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103a60:	ba 00 00 01 00       	mov    $0x10000,%edx
80103a65:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103a6a:	e8 e1 fd ff ff       	call   80103850 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103a6f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103a71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103a74:	0f 85 a9 fe ff ff    	jne    80103923 <mpinit+0x53>
80103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103a80:	83 ec 0c             	sub    $0xc,%esp
80103a83:	68 9d 8f 10 80       	push   $0x80108f9d
80103a88:	e8 03 c9 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
80103a8d:	83 ec 0c             	sub    $0xc,%esp
80103a90:	68 bc 8f 10 80       	push   $0x80108fbc
80103a95:	e8 f6 c8 ff ff       	call   80100390 <panic>
      ismp = 0;
80103a9a:	31 db                	xor    %ebx,%ebx
80103a9c:	e9 26 ff ff ff       	jmp    801039c7 <mpinit+0xf7>
80103aa1:	66 90                	xchg   %ax,%ax
80103aa3:	66 90                	xchg   %ax,%ax
80103aa5:	66 90                	xchg   %ax,%ax
80103aa7:	66 90                	xchg   %ax,%ax
80103aa9:	66 90                	xchg   %ax,%ax
80103aab:	66 90                	xchg   %ax,%ax
80103aad:	66 90                	xchg   %ax,%ax
80103aaf:	90                   	nop

80103ab0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103ab0:	55                   	push   %ebp
80103ab1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ab6:	ba 21 00 00 00       	mov    $0x21,%edx
80103abb:	89 e5                	mov    %esp,%ebp
80103abd:	ee                   	out    %al,(%dx)
80103abe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103ac3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103ac4:	5d                   	pop    %ebp
80103ac5:	c3                   	ret    
80103ac6:	66 90                	xchg   %ax,%ax
80103ac8:	66 90                	xchg   %ax,%ax
80103aca:	66 90                	xchg   %ax,%ax
80103acc:	66 90                	xchg   %ax,%ax
80103ace:	66 90                	xchg   %ax,%ax

80103ad0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 0c             	sub    $0xc,%esp
80103ad9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103adc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103adf:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103ae5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103aeb:	e8 a0 d4 ff ff       	call   80100f90 <filealloc>
80103af0:	85 c0                	test   %eax,%eax
80103af2:	89 03                	mov    %eax,(%ebx)
80103af4:	74 22                	je     80103b18 <pipealloc+0x48>
80103af6:	e8 95 d4 ff ff       	call   80100f90 <filealloc>
80103afb:	85 c0                	test   %eax,%eax
80103afd:	89 06                	mov    %eax,(%esi)
80103aff:	74 3f                	je     80103b40 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103b01:	e8 6a f0 ff ff       	call   80102b70 <kalloc>
80103b06:	85 c0                	test   %eax,%eax
80103b08:	89 c7                	mov    %eax,%edi
80103b0a:	75 54                	jne    80103b60 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103b0c:	8b 03                	mov    (%ebx),%eax
80103b0e:	85 c0                	test   %eax,%eax
80103b10:	75 34                	jne    80103b46 <pipealloc+0x76>
80103b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103b18:	8b 06                	mov    (%esi),%eax
80103b1a:	85 c0                	test   %eax,%eax
80103b1c:	74 0c                	je     80103b2a <pipealloc+0x5a>
    fileclose(*f1);
80103b1e:	83 ec 0c             	sub    $0xc,%esp
80103b21:	50                   	push   %eax
80103b22:	e8 29 d5 ff ff       	call   80101050 <fileclose>
80103b27:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103b2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103b2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103b32:	5b                   	pop    %ebx
80103b33:	5e                   	pop    %esi
80103b34:	5f                   	pop    %edi
80103b35:	5d                   	pop    %ebp
80103b36:	c3                   	ret    
80103b37:	89 f6                	mov    %esi,%esi
80103b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103b40:	8b 03                	mov    (%ebx),%eax
80103b42:	85 c0                	test   %eax,%eax
80103b44:	74 e4                	je     80103b2a <pipealloc+0x5a>
    fileclose(*f0);
80103b46:	83 ec 0c             	sub    $0xc,%esp
80103b49:	50                   	push   %eax
80103b4a:	e8 01 d5 ff ff       	call   80101050 <fileclose>
  if(*f1)
80103b4f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103b51:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103b54:	85 c0                	test   %eax,%eax
80103b56:	75 c6                	jne    80103b1e <pipealloc+0x4e>
80103b58:	eb d0                	jmp    80103b2a <pipealloc+0x5a>
80103b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103b60:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103b63:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103b6a:	00 00 00 
  p->writeopen = 1;
80103b6d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103b74:	00 00 00 
  p->nwrite = 0;
80103b77:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103b7e:	00 00 00 
  p->nread = 0;
80103b81:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103b88:	00 00 00 
  initlock(&p->lock, "pipe");
80103b8b:	68 f0 8f 10 80       	push   $0x80108ff0
80103b90:	50                   	push   %eax
80103b91:	e8 ca 15 00 00       	call   80105160 <initlock>
  (*f0)->type = FD_PIPE;
80103b96:	8b 03                	mov    (%ebx),%eax
  return 0;
80103b98:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103b9b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103ba1:	8b 03                	mov    (%ebx),%eax
80103ba3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ba7:	8b 03                	mov    (%ebx),%eax
80103ba9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103bad:	8b 03                	mov    (%ebx),%eax
80103baf:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103bb2:	8b 06                	mov    (%esi),%eax
80103bb4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103bba:	8b 06                	mov    (%esi),%eax
80103bbc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103bc0:	8b 06                	mov    (%esi),%eax
80103bc2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103bc6:	8b 06                	mov    (%esi),%eax
80103bc8:	89 78 0c             	mov    %edi,0xc(%eax)
}
80103bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103bce:	31 c0                	xor    %eax,%eax
}
80103bd0:	5b                   	pop    %ebx
80103bd1:	5e                   	pop    %esi
80103bd2:	5f                   	pop    %edi
80103bd3:	5d                   	pop    %ebp
80103bd4:	c3                   	ret    
80103bd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103be0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
80103be5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103be8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103beb:	83 ec 0c             	sub    $0xc,%esp
80103bee:	53                   	push   %ebx
80103bef:	e8 ac 16 00 00       	call   801052a0 <acquire>
  if(writable){
80103bf4:	83 c4 10             	add    $0x10,%esp
80103bf7:	85 f6                	test   %esi,%esi
80103bf9:	74 45                	je     80103c40 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103bfb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103c01:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103c04:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103c0b:	00 00 00 
    wakeup(&p->nread);
80103c0e:	50                   	push   %eax
80103c0f:	e8 7c 0d 00 00       	call   80104990 <wakeup>
80103c14:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103c17:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103c1d:	85 d2                	test   %edx,%edx
80103c1f:	75 0a                	jne    80103c2b <pipeclose+0x4b>
80103c21:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103c27:	85 c0                	test   %eax,%eax
80103c29:	74 35                	je     80103c60 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103c2b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103c2e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c31:	5b                   	pop    %ebx
80103c32:	5e                   	pop    %esi
80103c33:	5d                   	pop    %ebp
    release(&p->lock);
80103c34:	e9 27 17 00 00       	jmp    80105360 <release>
80103c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103c40:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103c46:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103c49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103c50:	00 00 00 
    wakeup(&p->nwrite);
80103c53:	50                   	push   %eax
80103c54:	e8 37 0d 00 00       	call   80104990 <wakeup>
80103c59:	83 c4 10             	add    $0x10,%esp
80103c5c:	eb b9                	jmp    80103c17 <pipeclose+0x37>
80103c5e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103c60:	83 ec 0c             	sub    $0xc,%esp
80103c63:	53                   	push   %ebx
80103c64:	e8 f7 16 00 00       	call   80105360 <release>
    kfree((char*)p);
80103c69:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103c6c:	83 c4 10             	add    $0x10,%esp
}
80103c6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c72:	5b                   	pop    %ebx
80103c73:	5e                   	pop    %esi
80103c74:	5d                   	pop    %ebp
    kfree((char*)p);
80103c75:	e9 e6 ec ff ff       	jmp    80102960 <kfree>
80103c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103c80 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	57                   	push   %edi
80103c84:	56                   	push   %esi
80103c85:	53                   	push   %ebx
80103c86:	83 ec 28             	sub    $0x28,%esp
80103c89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103c8c:	53                   	push   %ebx
80103c8d:	e8 0e 16 00 00       	call   801052a0 <acquire>
  for(i = 0; i < n; i++){
80103c92:	8b 45 10             	mov    0x10(%ebp),%eax
80103c95:	83 c4 10             	add    $0x10,%esp
80103c98:	85 c0                	test   %eax,%eax
80103c9a:	0f 8e c9 00 00 00    	jle    80103d69 <pipewrite+0xe9>
80103ca0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103ca3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103ca9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103caf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103cb2:	03 4d 10             	add    0x10(%ebp),%ecx
80103cb5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103cb8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103cbe:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103cc4:	39 d0                	cmp    %edx,%eax
80103cc6:	75 71                	jne    80103d39 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103cc8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103cce:	85 c0                	test   %eax,%eax
80103cd0:	74 4e                	je     80103d20 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103cd2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103cd8:	eb 3a                	jmp    80103d14 <pipewrite+0x94>
80103cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103ce0:	83 ec 0c             	sub    $0xc,%esp
80103ce3:	57                   	push   %edi
80103ce4:	e8 a7 0c 00 00       	call   80104990 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103ce9:	5a                   	pop    %edx
80103cea:	59                   	pop    %ecx
80103ceb:	53                   	push   %ebx
80103cec:	56                   	push   %esi
80103ced:	e8 7e 0a 00 00       	call   80104770 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103cf2:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103cf8:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103cfe:	83 c4 10             	add    $0x10,%esp
80103d01:	05 00 02 00 00       	add    $0x200,%eax
80103d06:	39 c2                	cmp    %eax,%edx
80103d08:	75 36                	jne    80103d40 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103d0a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103d10:	85 c0                	test   %eax,%eax
80103d12:	74 0c                	je     80103d20 <pipewrite+0xa0>
80103d14:	e8 07 04 00 00       	call   80104120 <myproc>
80103d19:	8b 40 24             	mov    0x24(%eax),%eax
80103d1c:	85 c0                	test   %eax,%eax
80103d1e:	74 c0                	je     80103ce0 <pipewrite+0x60>
        release(&p->lock);
80103d20:	83 ec 0c             	sub    $0xc,%esp
80103d23:	53                   	push   %ebx
80103d24:	e8 37 16 00 00       	call   80105360 <release>
        return -1;
80103d29:	83 c4 10             	add    $0x10,%esp
80103d2c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103d31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d34:	5b                   	pop    %ebx
80103d35:	5e                   	pop    %esi
80103d36:	5f                   	pop    %edi
80103d37:	5d                   	pop    %ebp
80103d38:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103d39:	89 c2                	mov    %eax,%edx
80103d3b:	90                   	nop
80103d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103d40:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103d43:	8d 42 01             	lea    0x1(%edx),%eax
80103d46:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103d4c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103d52:	83 c6 01             	add    $0x1,%esi
80103d55:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103d59:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103d5c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103d5f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103d63:	0f 85 4f ff ff ff    	jne    80103cb8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103d69:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103d6f:	83 ec 0c             	sub    $0xc,%esp
80103d72:	50                   	push   %eax
80103d73:	e8 18 0c 00 00       	call   80104990 <wakeup>
  release(&p->lock);
80103d78:	89 1c 24             	mov    %ebx,(%esp)
80103d7b:	e8 e0 15 00 00       	call   80105360 <release>
  return n;
80103d80:	83 c4 10             	add    $0x10,%esp
80103d83:	8b 45 10             	mov    0x10(%ebp),%eax
80103d86:	eb a9                	jmp    80103d31 <pipewrite+0xb1>
80103d88:	90                   	nop
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d90 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	57                   	push   %edi
80103d94:	56                   	push   %esi
80103d95:	53                   	push   %ebx
80103d96:	83 ec 18             	sub    $0x18,%esp
80103d99:	8b 75 08             	mov    0x8(%ebp),%esi
80103d9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103d9f:	56                   	push   %esi
80103da0:	e8 fb 14 00 00       	call   801052a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103da5:	83 c4 10             	add    $0x10,%esp
80103da8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103dae:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103db4:	75 6a                	jne    80103e20 <piperead+0x90>
80103db6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103dbc:	85 db                	test   %ebx,%ebx
80103dbe:	0f 84 c4 00 00 00    	je     80103e88 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103dc4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103dca:	eb 2d                	jmp    80103df9 <piperead+0x69>
80103dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dd0:	83 ec 08             	sub    $0x8,%esp
80103dd3:	56                   	push   %esi
80103dd4:	53                   	push   %ebx
80103dd5:	e8 96 09 00 00       	call   80104770 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103dda:	83 c4 10             	add    $0x10,%esp
80103ddd:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103de3:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103de9:	75 35                	jne    80103e20 <piperead+0x90>
80103deb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103df1:	85 d2                	test   %edx,%edx
80103df3:	0f 84 8f 00 00 00    	je     80103e88 <piperead+0xf8>
    if(myproc()->killed){
80103df9:	e8 22 03 00 00       	call   80104120 <myproc>
80103dfe:	8b 48 24             	mov    0x24(%eax),%ecx
80103e01:	85 c9                	test   %ecx,%ecx
80103e03:	74 cb                	je     80103dd0 <piperead+0x40>
      release(&p->lock);
80103e05:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103e08:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103e0d:	56                   	push   %esi
80103e0e:	e8 4d 15 00 00       	call   80105360 <release>
      return -1;
80103e13:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103e16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e19:	89 d8                	mov    %ebx,%eax
80103e1b:	5b                   	pop    %ebx
80103e1c:	5e                   	pop    %esi
80103e1d:	5f                   	pop    %edi
80103e1e:	5d                   	pop    %ebp
80103e1f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103e20:	8b 45 10             	mov    0x10(%ebp),%eax
80103e23:	85 c0                	test   %eax,%eax
80103e25:	7e 61                	jle    80103e88 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103e27:	31 db                	xor    %ebx,%ebx
80103e29:	eb 13                	jmp    80103e3e <piperead+0xae>
80103e2b:	90                   	nop
80103e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e30:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103e36:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103e3c:	74 1f                	je     80103e5d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103e3e:	8d 41 01             	lea    0x1(%ecx),%eax
80103e41:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103e47:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103e4d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103e52:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103e55:	83 c3 01             	add    $0x1,%ebx
80103e58:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103e5b:	75 d3                	jne    80103e30 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103e5d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103e63:	83 ec 0c             	sub    $0xc,%esp
80103e66:	50                   	push   %eax
80103e67:	e8 24 0b 00 00       	call   80104990 <wakeup>
  release(&p->lock);
80103e6c:	89 34 24             	mov    %esi,(%esp)
80103e6f:	e8 ec 14 00 00       	call   80105360 <release>
  return i;
80103e74:	83 c4 10             	add    $0x10,%esp
}
80103e77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e7a:	89 d8                	mov    %ebx,%eax
80103e7c:	5b                   	pop    %ebx
80103e7d:	5e                   	pop    %esi
80103e7e:	5f                   	pop    %edi
80103e7f:	5d                   	pop    %ebp
80103e80:	c3                   	ret    
80103e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e88:	31 db                	xor    %ebx,%ebx
80103e8a:	eb d1                	jmp    80103e5d <piperead+0xcd>
80103e8c:	66 90                	xchg   %ax,%ax
80103e8e:	66 90                	xchg   %ax,%ax

80103e90 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e94:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80103e99:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103e9c:	68 40 cd 14 80       	push   $0x8014cd40
80103ea1:	e8 fa 13 00 00       	call   801052a0 <acquire>
80103ea6:	83 c4 10             	add    $0x10,%esp
80103ea9:	eb 17                	jmp    80103ec2 <allocproc+0x32>
80103eab:	90                   	nop
80103eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eb0:	81 c3 18 03 00 00    	add    $0x318,%ebx
80103eb6:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80103ebc:	0f 83 26 01 00 00    	jae    80103fe8 <allocproc+0x158>
    if(p->state == UNUSED)
80103ec2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ec5:	85 c0                	test   %eax,%eax
80103ec7:	75 e7                	jne    80103eb0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103ec9:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80103ece:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103ed1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103ed8:	8d 50 01             	lea    0x1(%eax),%edx
80103edb:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103ede:	68 40 cd 14 80       	push   $0x8014cd40
  p->pid = nextpid++;
80103ee3:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103ee9:	e8 72 14 00 00       	call   80105360 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103eee:	e8 7d ec ff ff       	call   80102b70 <kalloc>
80103ef3:	83 c4 10             	add    $0x10,%esp
80103ef6:	85 c0                	test   %eax,%eax
80103ef8:	89 43 08             	mov    %eax,0x8(%ebx)
80103efb:	0f 84 00 01 00 00    	je     80104001 <allocproc+0x171>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103f01:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103f07:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103f0a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103f0f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103f12:	c7 40 14 47 66 10 80 	movl   $0x80106647,0x14(%eax)
  p->context = (struct context*)sp;
80103f19:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103f1c:	6a 14                	push   $0x14
80103f1e:	6a 00                	push   $0x0
80103f20:	50                   	push   %eax
80103f21:	e8 8a 14 00 00       	call   801053b0 <memset>
  p->context->eip = (uint)forkret;
80103f26:	8b 43 1c             	mov    0x1c(%ebx),%eax

  #ifndef NONE
  p->headPG = -1;
  // Task 1
  if(p->pid>2){
80103f29:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103f2c:	c7 40 10 10 40 10 80 	movl   $0x80104010,0x10(%eax)
  if(p->pid>2){
80103f33:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  p->headPG = -1;
80103f37:	c7 83 94 00 00 00 ff 	movl   $0xffffffff,0x94(%ebx)
80103f3e:	ff ff ff 
  if(p->pid>2){
80103f41:	0f 8f 89 00 00 00    	jg     80103fd0 <allocproc+0x140>
80103f47:	8d 83 a4 00 00 00    	lea    0xa4(%ebx),%eax
80103f4d:	8d 93 e4 01 00 00    	lea    0x1e4(%ebx),%edx
80103f53:	90                   	nop
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  }

  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103f58:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    p->swappedPGs[i].changeCounter = 0;
80103f5f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103f65:	83 c0 14             	add    $0x14,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103f68:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
80103f6f:	ff ff ff 
    p->physicalPGs[i].prev = 0;
80103f72:	c7 80 30 01 00 00 00 	movl   $0x0,0x130(%eax)
80103f79:	00 00 00 
    p->physicalPGs[i].next = 0;
80103f7c:	c7 80 2c 01 00 00 00 	movl   $0x0,0x12c(%eax)
80103f83:	00 00 00 
    p->physicalPGs[i].age = 0;
80103f86:	c7 80 24 01 00 00 00 	movl   $0x0,0x124(%eax)
80103f8d:	00 00 00 
    #ifdef LAPA
        p->physicalPGs[i].age = 0xffffffff;
    #endif
    p->physicalPGs[i].alloceted = 0;
80103f90:	c7 80 28 01 00 00 00 	movl   $0x0,0x128(%eax)
80103f97:	00 00 00 
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103f9a:	39 d0                	cmp    %edx,%eax
80103f9c:	75 ba                	jne    80103f58 <allocproc+0xc8>
  }
  p->nTotalPGout = 0;
80103f9e:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103fa5:	00 00 00 
  p->allocatedInPhys = 0;
80103fa8:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103faf:	00 00 00 
  p->nPgsSwap = 0;
80103fb2:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103fb9:	00 00 00 
  p->nPgsPhysical = 0;
80103fbc:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103fc3:	00 00 00 
  #endif

  return p;
}
80103fc6:	89 d8                	mov    %ebx,%eax
80103fc8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fcb:	c9                   	leave  
80103fcc:	c3                   	ret    
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi
    createSwapFile(p);
80103fd0:	83 ec 0c             	sub    $0xc,%esp
80103fd3:	53                   	push   %ebx
80103fd4:	e8 e7 e3 ff ff       	call   801023c0 <createSwapFile>
80103fd9:	83 c4 10             	add    $0x10,%esp
80103fdc:	e9 66 ff ff ff       	jmp    80103f47 <allocproc+0xb7>
80103fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103fe8:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103feb:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103fed:	68 40 cd 14 80       	push   $0x8014cd40
80103ff2:	e8 69 13 00 00       	call   80105360 <release>
}
80103ff7:	89 d8                	mov    %ebx,%eax
  return 0;
80103ff9:	83 c4 10             	add    $0x10,%esp
}
80103ffc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fff:	c9                   	leave  
80104000:	c3                   	ret    
    p->state = UNUSED;
80104001:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80104008:	31 db                	xor    %ebx,%ebx
8010400a:	eb ba                	jmp    80103fc6 <allocproc+0x136>
8010400c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104010 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104016:	68 40 cd 14 80       	push   $0x8014cd40
8010401b:	e8 40 13 00 00       	call   80105360 <release>

  if (first) {
80104020:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80104025:	83 c4 10             	add    $0x10,%esp
80104028:	85 c0                	test   %eax,%eax
8010402a:	75 04                	jne    80104030 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010402c:	c9                   	leave  
8010402d:	c3                   	ret    
8010402e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80104030:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80104033:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
8010403a:	00 00 00 
    iinit(ROOTDEV);
8010403d:	6a 01                	push   $0x1
8010403f:	e8 4c d6 ff ff       	call   80101690 <iinit>
    initlog(ROOTDEV);
80104044:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010404b:	e8 40 f3 ff ff       	call   80103390 <initlog>
80104050:	83 c4 10             	add    $0x10,%esp
}
80104053:	c9                   	leave  
80104054:	c3                   	ret    
80104055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104060 <pinit>:
{
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104066:	68 f5 8f 10 80       	push   $0x80108ff5
8010406b:	68 40 cd 14 80       	push   $0x8014cd40
80104070:	e8 eb 10 00 00       	call   80105160 <initlock>
}
80104075:	83 c4 10             	add    $0x10,%esp
80104078:	c9                   	leave  
80104079:	c3                   	ret    
8010407a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104080 <mycpu>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	56                   	push   %esi
80104084:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104085:	9c                   	pushf  
80104086:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104087:	f6 c4 02             	test   $0x2,%ah
8010408a:	75 5e                	jne    801040ea <mycpu+0x6a>
  apicid = lapicid();
8010408c:	e8 2f ef ff ff       	call   80102fc0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104091:	8b 35 20 cd 14 80    	mov    0x8014cd20,%esi
80104097:	85 f6                	test   %esi,%esi
80104099:	7e 42                	jle    801040dd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010409b:	0f b6 15 a0 c7 14 80 	movzbl 0x8014c7a0,%edx
801040a2:	39 d0                	cmp    %edx,%eax
801040a4:	74 30                	je     801040d6 <mycpu+0x56>
801040a6:	b9 50 c8 14 80       	mov    $0x8014c850,%ecx
  for (i = 0; i < ncpu; ++i) {
801040ab:	31 d2                	xor    %edx,%edx
801040ad:	8d 76 00             	lea    0x0(%esi),%esi
801040b0:	83 c2 01             	add    $0x1,%edx
801040b3:	39 f2                	cmp    %esi,%edx
801040b5:	74 26                	je     801040dd <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
801040b7:	0f b6 19             	movzbl (%ecx),%ebx
801040ba:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801040c0:	39 c3                	cmp    %eax,%ebx
801040c2:	75 ec                	jne    801040b0 <mycpu+0x30>
801040c4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
801040ca:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
}
801040cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040d2:	5b                   	pop    %ebx
801040d3:	5e                   	pop    %esi
801040d4:	5d                   	pop    %ebp
801040d5:	c3                   	ret    
    if (cpus[i].apicid == apicid)
801040d6:	b8 a0 c7 14 80       	mov    $0x8014c7a0,%eax
      return &cpus[i];
801040db:	eb f2                	jmp    801040cf <mycpu+0x4f>
  panic("unknown apicid\n");
801040dd:	83 ec 0c             	sub    $0xc,%esp
801040e0:	68 fc 8f 10 80       	push   $0x80108ffc
801040e5:	e8 a6 c2 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
801040ea:	83 ec 0c             	sub    $0xc,%esp
801040ed:	68 60 91 10 80       	push   $0x80109160
801040f2:	e8 99 c2 ff ff       	call   80100390 <panic>
801040f7:	89 f6                	mov    %esi,%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104100 <cpuid>:
cpuid() {
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104106:	e8 75 ff ff ff       	call   80104080 <mycpu>
8010410b:	2d a0 c7 14 80       	sub    $0x8014c7a0,%eax
}
80104110:	c9                   	leave  
  return mycpu()-cpus;
80104111:	c1 f8 04             	sar    $0x4,%eax
80104114:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010411a:	c3                   	ret    
8010411b:	90                   	nop
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104120 <myproc>:
myproc(void) {
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	53                   	push   %ebx
80104124:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104127:	e8 a4 10 00 00       	call   801051d0 <pushcli>
  c = mycpu();
8010412c:	e8 4f ff ff ff       	call   80104080 <mycpu>
  p = c->proc;
80104131:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104137:	e8 d4 10 00 00       	call   80105210 <popcli>
}
8010413c:	83 c4 04             	add    $0x4,%esp
8010413f:	89 d8                	mov    %ebx,%eax
80104141:	5b                   	pop    %ebx
80104142:	5d                   	pop    %ebp
80104143:	c3                   	ret    
80104144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010414a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104150 <userinit>:
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	53                   	push   %ebx
80104154:	83 ec 04             	sub    $0x4,%esp
  recordTotalFreePages();
80104157:	e8 54 e7 ff ff       	call   801028b0 <recordTotalFreePages>
  p = allocproc();
8010415c:	e8 2f fd ff ff       	call   80103e90 <allocproc>
80104161:	89 c3                	mov    %eax,%ebx
  initproc = p;
80104163:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  if((p->pgdir = setupkvm()) == 0)
80104168:	e8 a3 42 00 00       	call   80108410 <setupkvm>
8010416d:	85 c0                	test   %eax,%eax
8010416f:	89 43 04             	mov    %eax,0x4(%ebx)
80104172:	0f 84 da 00 00 00    	je     80104252 <userinit+0x102>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104178:	83 ec 04             	sub    $0x4,%esp
8010417b:	68 2c 00 00 00       	push   $0x2c
80104180:	68 60 c4 10 80       	push   $0x8010c460
80104185:	50                   	push   %eax
80104186:	e8 85 38 00 00       	call   80107a10 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
8010418b:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
8010418e:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80104194:	6a 4c                	push   $0x4c
80104196:	6a 00                	push   $0x0
80104198:	ff 73 18             	pushl  0x18(%ebx)
8010419b:	e8 10 12 00 00       	call   801053b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041a0:	8b 43 18             	mov    0x18(%ebx),%eax
801041a3:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041a8:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801041ad:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041b0:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041b4:	8b 43 18             	mov    0x18(%ebx),%eax
801041b7:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801041bb:	8b 43 18             	mov    0x18(%ebx),%eax
801041be:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801041c2:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801041c6:	8b 43 18             	mov    0x18(%ebx),%eax
801041c9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801041cd:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801041d1:	8b 43 18             	mov    0x18(%ebx),%eax
801041d4:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801041db:	8b 43 18             	mov    0x18(%ebx),%eax
801041de:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801041e5:	8b 43 18             	mov    0x18(%ebx),%eax
801041e8:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801041ef:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041f2:	6a 10                	push   $0x10
801041f4:	68 25 90 10 80       	push   $0x80109025
801041f9:	50                   	push   %eax
801041fa:	e8 91 13 00 00       	call   80105590 <safestrcpy>
  p->cwd = namei("/");
801041ff:	c7 04 24 2e 90 10 80 	movl   $0x8010902e,(%esp)
80104206:	e8 e5 de ff ff       	call   801020f0 <namei>
8010420b:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
8010420e:	c7 04 24 30 90 10 80 	movl   $0x80109030,(%esp)
80104215:	e8 46 c4 ff ff       	call   80100660 <cprintf>
8010421a:	58                   	pop    %eax
8010421b:	5a                   	pop    %edx
8010421c:	68 00 e0 00 00       	push   $0xe000
80104221:	68 38 90 10 80       	push   $0x80109038
80104226:	e8 35 c4 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
8010422b:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104232:	e8 69 10 00 00       	call   801052a0 <acquire>
  p->state = RUNNABLE;
80104237:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010423e:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104245:	e8 16 11 00 00       	call   80105360 <release>
}
8010424a:	83 c4 10             	add    $0x10,%esp
8010424d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104250:	c9                   	leave  
80104251:	c3                   	ret    
    panic("userinit: out of memory?");
80104252:	83 ec 0c             	sub    $0xc,%esp
80104255:	68 0c 90 10 80       	push   $0x8010900c
8010425a:	e8 31 c1 ff ff       	call   80100390 <panic>
8010425f:	90                   	nop

80104260 <growproc>:
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
80104264:	53                   	push   %ebx
80104265:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80104268:	e8 63 0f 00 00       	call   801051d0 <pushcli>
  c = mycpu();
8010426d:	e8 0e fe ff ff       	call   80104080 <mycpu>
  p = c->proc;
80104272:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104278:	e8 93 0f 00 00       	call   80105210 <popcli>
  if(n > 0){
8010427d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80104280:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104282:	7f 1c                	jg     801042a0 <growproc+0x40>
  } else if(n < 0){
80104284:	75 3a                	jne    801042c0 <growproc+0x60>
  switchuvm(curproc);
80104286:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80104289:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010428b:	53                   	push   %ebx
8010428c:	e8 6f 36 00 00       	call   80107900 <switchuvm>
  return 0;
80104291:	83 c4 10             	add    $0x10,%esp
80104294:	31 c0                	xor    %eax,%eax
}
80104296:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104299:	5b                   	pop    %ebx
8010429a:	5e                   	pop    %esi
8010429b:	5d                   	pop    %ebp
8010429c:	c3                   	ret    
8010429d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801042a0:	83 ec 04             	sub    $0x4,%esp
801042a3:	01 c6                	add    %eax,%esi
801042a5:	56                   	push   %esi
801042a6:	50                   	push   %eax
801042a7:	ff 73 04             	pushl  0x4(%ebx)
801042aa:	e8 d1 44 00 00       	call   80108780 <allocuvm>
801042af:	83 c4 10             	add    $0x10,%esp
801042b2:	85 c0                	test   %eax,%eax
801042b4:	75 d0                	jne    80104286 <growproc+0x26>
      return -1;
801042b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042bb:	eb d9                	jmp    80104296 <growproc+0x36>
801042bd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801042c0:	83 ec 04             	sub    $0x4,%esp
801042c3:	01 c6                	add    %eax,%esi
801042c5:	56                   	push   %esi
801042c6:	50                   	push   %eax
801042c7:	ff 73 04             	pushl  0x4(%ebx)
801042ca:	e8 91 40 00 00       	call   80108360 <deallocuvm>
801042cf:	83 c4 10             	add    $0x10,%esp
801042d2:	85 c0                	test   %eax,%eax
801042d4:	75 b0                	jne    80104286 <growproc+0x26>
801042d6:	eb de                	jmp    801042b6 <growproc+0x56>
801042d8:	90                   	nop
801042d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801042e0 <fork>:
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801042e9:	e8 e2 0e 00 00       	call   801051d0 <pushcli>
  c = mycpu();
801042ee:	e8 8d fd ff ff       	call   80104080 <mycpu>
  p = c->proc;
801042f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042f9:	e8 12 0f 00 00       	call   80105210 <popcli>
  if((np = allocproc()) == 0){
801042fe:	e8 8d fb ff ff       	call   80103e90 <allocproc>
80104303:	85 c0                	test   %eax,%eax
80104305:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104308:	0f 84 75 02 00 00    	je     80104583 <fork+0x2a3>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010430e:	83 ec 08             	sub    $0x8,%esp
80104311:	ff 33                	pushl  (%ebx)
80104313:	ff 73 04             	pushl  0x4(%ebx)
80104316:	e8 95 41 00 00       	call   801084b0 <copyuvm>
8010431b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010431e:	83 c4 10             	add    $0x10,%esp
80104321:	85 c0                	test   %eax,%eax
80104323:	89 42 04             	mov    %eax,0x4(%edx)
80104326:	0f 84 60 02 00 00    	je     8010458c <fork+0x2ac>
  np->sz = curproc->sz;
8010432c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
8010432e:	8b 7a 18             	mov    0x18(%edx),%edi
80104331:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80104336:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80104339:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
8010433b:	8b 73 18             	mov    0x18(%ebx),%esi
8010433e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104340:	31 f6                	xor    %esi,%esi
80104342:	89 d7                	mov    %edx,%edi
  np->tf->eax = 0;
80104344:	8b 42 18             	mov    0x18(%edx),%eax
80104347:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
8010434e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[i])
80104350:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104354:	85 c0                	test   %eax,%eax
80104356:	74 10                	je     80104368 <fork+0x88>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104358:	83 ec 0c             	sub    $0xc,%esp
8010435b:	50                   	push   %eax
8010435c:	e8 9f cc ff ff       	call   80101000 <filedup>
80104361:	83 c4 10             	add    $0x10,%esp
80104364:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104368:	83 c6 01             	add    $0x1,%esi
8010436b:	83 fe 10             	cmp    $0x10,%esi
8010436e:	75 e0                	jne    80104350 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104370:	83 ec 0c             	sub    $0xc,%esp
80104373:	ff 73 68             	pushl  0x68(%ebx)
80104376:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80104379:	e8 e2 d4 ff ff       	call   80101860 <idup>
8010437e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104381:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104384:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104387:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010438a:	6a 10                	push   $0x10
8010438c:	50                   	push   %eax
8010438d:	8d 42 6c             	lea    0x6c(%edx),%eax
80104390:	50                   	push   %eax
80104391:	e8 fa 11 00 00       	call   80105590 <safestrcpy>
  pid = np->pid;
80104396:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  if(curproc->pid>2){
80104399:	83 c4 10             	add    $0x10,%esp
8010439c:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  pid = np->pid;
801043a0:	8b 42 10             	mov    0x10(%edx),%eax
801043a3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(curproc->pid>2){
801043a6:	0f 8e a3 01 00 00    	jle    8010454f <fork+0x26f>
    np->nTotalPGout = 0;
801043ac:	c7 82 88 00 00 00 00 	movl   $0x0,0x88(%edx)
801043b3:	00 00 00 
    np->nPGFLT = 0;
801043b6:	c7 82 8c 00 00 00 00 	movl   $0x0,0x8c(%edx)
801043bd:	00 00 00 
801043c0:	8d 8b 98 00 00 00    	lea    0x98(%ebx),%ecx
    np->nPgsSwap = curproc->nPgsSwap;
801043c6:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801043cc:	8d b2 d8 01 00 00    	lea    0x1d8(%edx),%esi
801043d2:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
    np->headPG = curproc->headPG;
801043d8:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
801043de:	89 82 94 00 00 00    	mov    %eax,0x94(%edx)
801043e4:	8d 82 98 00 00 00    	lea    0x98(%edx),%eax
801043ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      np->physicalPGs[i].alloceted = 0;
801043f0:	c7 80 48 01 00 00 00 	movl   $0x0,0x148(%eax)
801043f7:	00 00 00 
      np->physicalPGs[i].next = 0;
801043fa:	c7 80 4c 01 00 00 00 	movl   $0x0,0x14c(%eax)
80104401:	00 00 00 
      np->physicalPGs[i].prev =  0 ;
80104404:	c7 80 50 01 00 00 00 	movl   $0x0,0x150(%eax)
8010440b:	00 00 00 
      np->physicalPGs[i].va = curproc->physicalPGs[i].va;
8010440e:	8b b9 40 01 00 00    	mov    0x140(%ecx),%edi
80104414:	89 b8 40 01 00 00    	mov    %edi,0x140(%eax)
      np->physicalPGs[i].age = curproc->physicalPGs[i].age;
8010441a:	8b b9 44 01 00 00    	mov    0x144(%ecx),%edi
80104420:	89 b8 44 01 00 00    	mov    %edi,0x144(%eax)
      np->physicalPGs[i].alloceted = curproc->physicalPGs[i].alloceted;
80104426:	8b b9 48 01 00 00    	mov    0x148(%ecx),%edi
8010442c:	89 b8 48 01 00 00    	mov    %edi,0x148(%eax)
      np->swappedPGs[i] = curproc->swappedPGs[i];
80104432:	8b 39                	mov    (%ecx),%edi
80104434:	89 38                	mov    %edi,(%eax)
80104436:	8b 79 04             	mov    0x4(%ecx),%edi
80104439:	89 78 04             	mov    %edi,0x4(%eax)
8010443c:	8b 79 08             	mov    0x8(%ecx),%edi
8010443f:	89 78 08             	mov    %edi,0x8(%eax)
80104442:	8b 79 0c             	mov    0xc(%ecx),%edi
80104445:	89 78 0c             	mov    %edi,0xc(%eax)
80104448:	8b 79 10             	mov    0x10(%ecx),%edi
8010444b:	89 78 10             	mov    %edi,0x10(%eax)
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
8010444e:	83 b9 40 01 00 00 ff 	cmpl   $0xffffffff,0x140(%ecx)
80104455:	74 07                	je     8010445e <fork+0x17e>
        np->nPgsPhysical++;
80104457:	83 82 80 00 00 00 01 	addl   $0x1,0x80(%edx)
8010445e:	83 c0 14             	add    $0x14,%eax
80104461:	83 c1 14             	add    $0x14,%ecx
    for(int i = 0; i < MAX_PSYC_PAGES ; i++){
80104464:	39 f0                	cmp    %esi,%eax
80104466:	75 88                	jne    801043f0 <fork+0x110>
80104468:	31 f6                	xor    %esi,%esi
    for(int i = 0; i < MAX_PSYC_PAGES; i++){
8010446a:	31 ff                	xor    %edi,%edi
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
80104470:	83 bc 33 d8 01 00 00 	cmpl   $0xffffffff,0x1d8(%ebx,%esi,1)
80104477:	ff 
80104478:	74 5b                	je     801044d5 <fork+0x1f5>
        int next = indexInPhysicalMem((uint)curproc->physicalPGs[i].next->va);
8010447a:	8b 84 33 e4 01 00 00 	mov    0x1e4(%ebx,%esi,1),%eax
80104481:	83 ec 0c             	sub    $0xc,%esp
80104484:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104487:	ff 30                	pushl  (%eax)
80104489:	e8 12 3b 00 00       	call   80107fa0 <indexInPhysicalMem>
        np->physicalPGs[i].next = &np->physicalPGs[next];
8010448e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104491:	8d 04 80             	lea    (%eax,%eax,4),%eax
        if(i!=curproc->headPG){
80104494:	83 c4 10             	add    $0x10,%esp
        np->physicalPGs[i].next = &np->physicalPGs[next];
80104497:	8d 84 82 d8 01 00 00 	lea    0x1d8(%edx,%eax,4),%eax
8010449e:	89 84 32 e4 01 00 00 	mov    %eax,0x1e4(%edx,%esi,1)
        if(i!=curproc->headPG){
801044a5:	39 bb 94 00 00 00    	cmp    %edi,0x94(%ebx)
801044ab:	74 28                	je     801044d5 <fork+0x1f5>
          int prev = indexInPhysicalMem((uint)curproc->physicalPGs[i].prev->va);
801044ad:	8b 84 33 e8 01 00 00 	mov    0x1e8(%ebx,%esi,1),%eax
801044b4:	83 ec 0c             	sub    $0xc,%esp
801044b7:	ff 30                	pushl  (%eax)
801044b9:	e8 e2 3a 00 00       	call   80107fa0 <indexInPhysicalMem>
          np->physicalPGs[i].prev = &np->physicalPGs[prev];
801044be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044c1:	8d 04 80             	lea    (%eax,%eax,4),%eax
801044c4:	83 c4 10             	add    $0x10,%esp
801044c7:	8d 84 82 d8 01 00 00 	lea    0x1d8(%edx,%eax,4),%eax
801044ce:	89 84 32 e8 01 00 00 	mov    %eax,0x1e8(%edx,%esi,1)
    for(int i = 0; i < MAX_PSYC_PAGES; i++){
801044d5:	83 c7 01             	add    $0x1,%edi
801044d8:	83 c6 14             	add    $0x14,%esi
801044db:	83 ff 10             	cmp    $0x10,%edi
801044de:	75 90                	jne    80104470 <fork+0x190>
801044e0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    char* newPage = kalloc();
801044e3:	e8 88 e6 ff ff       	call   80102b70 <kalloc>
801044e8:	89 c7                	mov    %eax,%edi
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801044ea:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801044f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044f3:	85 c0                	test   %eax,%eax
801044f5:	7e 46                	jle    8010453d <fork+0x25d>
801044f7:	31 f6                	xor    %esi,%esi
801044f9:	89 55 e0             	mov    %edx,-0x20(%ebp)
801044fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104500:	89 f1                	mov    %esi,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
80104502:	68 00 10 00 00       	push   $0x1000
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
80104507:	83 c6 01             	add    $0x1,%esi
8010450a:	c1 e1 0c             	shl    $0xc,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
8010450d:	51                   	push   %ecx
8010450e:	57                   	push   %edi
8010450f:	53                   	push   %ebx
80104510:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104513:	e8 78 df ff ff       	call   80102490 <readFromSwapFile>
      writeToSwapFile(np,newPage,i*PGSIZE,PGSIZE);
80104518:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010451b:	68 00 10 00 00       	push   $0x1000
80104520:	51                   	push   %ecx
80104521:	57                   	push   %edi
80104522:	ff 75 e0             	pushl  -0x20(%ebp)
80104525:	e8 36 df ff ff       	call   80102460 <writeToSwapFile>
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
8010452a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104530:	83 c4 20             	add    $0x20,%esp
80104533:	c1 e0 0c             	shl    $0xc,%eax
80104536:	39 f0                	cmp    %esi,%eax
80104538:	7f c6                	jg     80104500 <fork+0x220>
8010453a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    kfree(newPage);
8010453d:	83 ec 0c             	sub    $0xc,%esp
80104540:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104543:	57                   	push   %edi
80104544:	e8 17 e4 ff ff       	call   80102960 <kfree>
80104549:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010454c:	83 c4 10             	add    $0x10,%esp
  acquire(&ptable.lock);
8010454f:	83 ec 0c             	sub    $0xc,%esp
80104552:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104555:	68 40 cd 14 80       	push   $0x8014cd40
8010455a:	e8 41 0d 00 00       	call   801052a0 <acquire>
  np->state = RUNNABLE;
8010455f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104562:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
80104569:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104570:	e8 eb 0d 00 00       	call   80105360 <release>
  return pid;
80104575:	83 c4 10             	add    $0x10,%esp
}
80104578:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010457b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010457e:	5b                   	pop    %ebx
8010457f:	5e                   	pop    %esi
80104580:	5f                   	pop    %edi
80104581:	5d                   	pop    %ebp
80104582:	c3                   	ret    
    return -1;
80104583:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
8010458a:	eb ec                	jmp    80104578 <fork+0x298>
    kfree(np->kstack);
8010458c:	83 ec 0c             	sub    $0xc,%esp
8010458f:	ff 72 08             	pushl  0x8(%edx)
80104592:	e8 c9 e3 ff ff       	call   80102960 <kfree>
    np->kstack = 0;
80104597:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
8010459a:	83 c4 10             	add    $0x10,%esp
8010459d:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
    np->kstack = 0;
801045a4:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
801045ab:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
801045b2:	eb c4                	jmp    80104578 <fork+0x298>
801045b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801045c0 <scheduler>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801045c9:	e8 b2 fa ff ff       	call   80104080 <mycpu>
801045ce:	8d 78 04             	lea    0x4(%eax),%edi
801045d1:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801045d3:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801045da:	00 00 00 
801045dd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
801045e0:	fb                   	sti    
    acquire(&ptable.lock);
801045e1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e4:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
    acquire(&ptable.lock);
801045e9:	68 40 cd 14 80       	push   $0x8014cd40
801045ee:	e8 ad 0c 00 00       	call   801052a0 <acquire>
801045f3:	83 c4 10             	add    $0x10,%esp
801045f6:	8d 76 00             	lea    0x0(%esi),%esi
801045f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80104600:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104604:	75 33                	jne    80104639 <scheduler+0x79>
      switchuvm(p);
80104606:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104609:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010460f:	53                   	push   %ebx
80104610:	e8 eb 32 00 00       	call   80107900 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104615:	58                   	pop    %eax
80104616:	5a                   	pop    %edx
80104617:	ff 73 1c             	pushl  0x1c(%ebx)
8010461a:	57                   	push   %edi
      p->state = RUNNING;
8010461b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104622:	e8 c4 0f 00 00       	call   801055eb <swtch>
      switchkvm();
80104627:	e8 b4 32 00 00       	call   801078e0 <switchkvm>
      c->proc = 0;
8010462c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104633:	00 00 00 
80104636:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104639:	81 c3 18 03 00 00    	add    $0x318,%ebx
8010463f:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104645:	72 b9                	jb     80104600 <scheduler+0x40>
    release(&ptable.lock);
80104647:	83 ec 0c             	sub    $0xc,%esp
8010464a:	68 40 cd 14 80       	push   $0x8014cd40
8010464f:	e8 0c 0d 00 00       	call   80105360 <release>
    sti();
80104654:	83 c4 10             	add    $0x10,%esp
80104657:	eb 87                	jmp    801045e0 <scheduler+0x20>
80104659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104660 <sched>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
  pushcli();
80104665:	e8 66 0b 00 00       	call   801051d0 <pushcli>
  c = mycpu();
8010466a:	e8 11 fa ff ff       	call   80104080 <mycpu>
  p = c->proc;
8010466f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104675:	e8 96 0b 00 00       	call   80105210 <popcli>
  if(!holding(&ptable.lock))
8010467a:	83 ec 0c             	sub    $0xc,%esp
8010467d:	68 40 cd 14 80       	push   $0x8014cd40
80104682:	e8 e9 0b 00 00       	call   80105270 <holding>
80104687:	83 c4 10             	add    $0x10,%esp
8010468a:	85 c0                	test   %eax,%eax
8010468c:	74 4f                	je     801046dd <sched+0x7d>
  if(mycpu()->ncli != 1)
8010468e:	e8 ed f9 ff ff       	call   80104080 <mycpu>
80104693:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010469a:	75 68                	jne    80104704 <sched+0xa4>
  if(p->state == RUNNING)
8010469c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801046a0:	74 55                	je     801046f7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046a2:	9c                   	pushf  
801046a3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046a4:	f6 c4 02             	test   $0x2,%ah
801046a7:	75 41                	jne    801046ea <sched+0x8a>
  intena = mycpu()->intena;
801046a9:	e8 d2 f9 ff ff       	call   80104080 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801046ae:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801046b1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801046b7:	e8 c4 f9 ff ff       	call   80104080 <mycpu>
801046bc:	83 ec 08             	sub    $0x8,%esp
801046bf:	ff 70 04             	pushl  0x4(%eax)
801046c2:	53                   	push   %ebx
801046c3:	e8 23 0f 00 00       	call   801055eb <swtch>
  mycpu()->intena = intena;
801046c8:	e8 b3 f9 ff ff       	call   80104080 <mycpu>
}
801046cd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801046d0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801046d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046d9:	5b                   	pop    %ebx
801046da:	5e                   	pop    %esi
801046db:	5d                   	pop    %ebp
801046dc:	c3                   	ret    
    panic("sched ptable.lock");
801046dd:	83 ec 0c             	sub    $0xc,%esp
801046e0:	68 3b 90 10 80       	push   $0x8010903b
801046e5:	e8 a6 bc ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801046ea:	83 ec 0c             	sub    $0xc,%esp
801046ed:	68 67 90 10 80       	push   $0x80109067
801046f2:	e8 99 bc ff ff       	call   80100390 <panic>
    panic("sched running");
801046f7:	83 ec 0c             	sub    $0xc,%esp
801046fa:	68 59 90 10 80       	push   $0x80109059
801046ff:	e8 8c bc ff ff       	call   80100390 <panic>
    panic("sched locks");
80104704:	83 ec 0c             	sub    $0xc,%esp
80104707:	68 4d 90 10 80       	push   $0x8010904d
8010470c:	e8 7f bc ff ff       	call   80100390 <panic>
80104711:	eb 0d                	jmp    80104720 <yield>
80104713:	90                   	nop
80104714:	90                   	nop
80104715:	90                   	nop
80104716:	90                   	nop
80104717:	90                   	nop
80104718:	90                   	nop
80104719:	90                   	nop
8010471a:	90                   	nop
8010471b:	90                   	nop
8010471c:	90                   	nop
8010471d:	90                   	nop
8010471e:	90                   	nop
8010471f:	90                   	nop

80104720 <yield>:
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	53                   	push   %ebx
80104724:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104727:	68 40 cd 14 80       	push   $0x8014cd40
8010472c:	e8 6f 0b 00 00       	call   801052a0 <acquire>
  pushcli();
80104731:	e8 9a 0a 00 00       	call   801051d0 <pushcli>
  c = mycpu();
80104736:	e8 45 f9 ff ff       	call   80104080 <mycpu>
  p = c->proc;
8010473b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104741:	e8 ca 0a 00 00       	call   80105210 <popcli>
  myproc()->state = RUNNABLE;
80104746:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010474d:	e8 0e ff ff ff       	call   80104660 <sched>
  release(&ptable.lock);
80104752:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104759:	e8 02 0c 00 00       	call   80105360 <release>
}
8010475e:	83 c4 10             	add    $0x10,%esp
80104761:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104764:	c9                   	leave  
80104765:	c3                   	ret    
80104766:	8d 76 00             	lea    0x0(%esi),%esi
80104769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104770 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	56                   	push   %esi
80104775:	53                   	push   %ebx
80104776:	83 ec 0c             	sub    $0xc,%esp
80104779:	8b 7d 08             	mov    0x8(%ebp),%edi
8010477c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010477f:	e8 4c 0a 00 00       	call   801051d0 <pushcli>
  c = mycpu();
80104784:	e8 f7 f8 ff ff       	call   80104080 <mycpu>
  p = c->proc;
80104789:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010478f:	e8 7c 0a 00 00       	call   80105210 <popcli>
  struct proc *p = myproc();
  
  if(p == 0)
80104794:	85 db                	test   %ebx,%ebx
80104796:	0f 84 87 00 00 00    	je     80104823 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
8010479c:	85 f6                	test   %esi,%esi
8010479e:	74 76                	je     80104816 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801047a0:	81 fe 40 cd 14 80    	cmp    $0x8014cd40,%esi
801047a6:	74 50                	je     801047f8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801047a8:	83 ec 0c             	sub    $0xc,%esp
801047ab:	68 40 cd 14 80       	push   $0x8014cd40
801047b0:	e8 eb 0a 00 00       	call   801052a0 <acquire>
    release(lk);
801047b5:	89 34 24             	mov    %esi,(%esp)
801047b8:	e8 a3 0b 00 00       	call   80105360 <release>
  }
  // Go to sleep.
  p->chan = chan;
801047bd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801047c0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
801047c7:	e8 94 fe ff ff       	call   80104660 <sched>

  // Tidy up.
  p->chan = 0;
801047cc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
801047d3:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801047da:	e8 81 0b 00 00       	call   80105360 <release>
    acquire(lk);
801047df:	89 75 08             	mov    %esi,0x8(%ebp)
801047e2:	83 c4 10             	add    $0x10,%esp
  }
}
801047e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047e8:	5b                   	pop    %ebx
801047e9:	5e                   	pop    %esi
801047ea:	5f                   	pop    %edi
801047eb:	5d                   	pop    %ebp
    acquire(lk);
801047ec:	e9 af 0a 00 00       	jmp    801052a0 <acquire>
801047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801047f8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801047fb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104802:	e8 59 fe ff ff       	call   80104660 <sched>
  p->chan = 0;
80104807:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010480e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104811:	5b                   	pop    %ebx
80104812:	5e                   	pop    %esi
80104813:	5f                   	pop    %edi
80104814:	5d                   	pop    %ebp
80104815:	c3                   	ret    
    panic("sleep without lk");
80104816:	83 ec 0c             	sub    $0xc,%esp
80104819:	68 81 90 10 80       	push   $0x80109081
8010481e:	e8 6d bb ff ff       	call   80100390 <panic>
    panic("sleep");
80104823:	83 ec 0c             	sub    $0xc,%esp
80104826:	68 7b 90 10 80       	push   $0x8010907b
8010482b:	e8 60 bb ff ff       	call   80100390 <panic>

80104830 <wait>:
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	56                   	push   %esi
80104834:	53                   	push   %ebx
  pushcli();
80104835:	e8 96 09 00 00       	call   801051d0 <pushcli>
  c = mycpu();
8010483a:	e8 41 f8 ff ff       	call   80104080 <mycpu>
  p = c->proc;
8010483f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104845:	e8 c6 09 00 00       	call   80105210 <popcli>
  acquire(&ptable.lock);
8010484a:	83 ec 0c             	sub    $0xc,%esp
8010484d:	68 40 cd 14 80       	push   $0x8014cd40
80104852:	e8 49 0a 00 00       	call   801052a0 <acquire>
80104857:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010485a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010485c:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
80104861:	eb 13                	jmp    80104876 <wait+0x46>
80104863:	90                   	nop
80104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104868:	81 c3 18 03 00 00    	add    $0x318,%ebx
8010486e:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104874:	73 1e                	jae    80104894 <wait+0x64>
      if(p->parent != curproc)
80104876:	39 73 14             	cmp    %esi,0x14(%ebx)
80104879:	75 ed                	jne    80104868 <wait+0x38>
      if(p->state == ZOMBIE){
8010487b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010487f:	74 3f                	je     801048c0 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104881:	81 c3 18 03 00 00    	add    $0x318,%ebx
      havekids = 1;
80104887:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010488c:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104892:	72 e2                	jb     80104876 <wait+0x46>
    if(!havekids || curproc->killed){
80104894:	85 c0                	test   %eax,%eax
80104896:	0f 84 d0 00 00 00    	je     8010496c <wait+0x13c>
8010489c:	8b 46 24             	mov    0x24(%esi),%eax
8010489f:	85 c0                	test   %eax,%eax
801048a1:	0f 85 c5 00 00 00    	jne    8010496c <wait+0x13c>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801048a7:	83 ec 08             	sub    $0x8,%esp
801048aa:	68 40 cd 14 80       	push   $0x8014cd40
801048af:	56                   	push   %esi
801048b0:	e8 bb fe ff ff       	call   80104770 <sleep>
    havekids = 0;
801048b5:	83 c4 10             	add    $0x10,%esp
801048b8:	eb a0                	jmp    8010485a <wait+0x2a>
801048ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048c0:	8d 83 a4 00 00 00    	lea    0xa4(%ebx),%eax
801048c6:	8d 93 e4 01 00 00    	lea    0x1e4(%ebx),%edx
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
              p->swappedPGs[i].va = (char*)0xffffffff;
801048d0:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
              p->swappedPGs[i].changeCounter = 0;
801048d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801048dd:	83 c0 14             	add    $0x14,%eax
              p->physicalPGs[i].va = (char*)0xffffffff;
801048e0:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
801048e7:	ff ff ff 
              p->physicalPGs[i].prev = 0;
801048ea:	c7 80 30 01 00 00 00 	movl   $0x0,0x130(%eax)
801048f1:	00 00 00 
              p->physicalPGs[i].next = 0;
801048f4:	c7 80 2c 01 00 00 00 	movl   $0x0,0x12c(%eax)
801048fb:	00 00 00 
              p->physicalPGs[i].age = 0;
801048fe:	c7 80 24 01 00 00 00 	movl   $0x0,0x124(%eax)
80104905:	00 00 00 
              p->physicalPGs[i].alloceted = 0;
80104908:	c7 80 28 01 00 00 00 	movl   $0x0,0x128(%eax)
8010490f:	00 00 00 
        for(i = 0; i < MAX_PSYC_PAGES; i++){
80104912:	39 d0                	cmp    %edx,%eax
80104914:	75 ba                	jne    801048d0 <wait+0xa0>
        kfree(p->kstack);
80104916:	83 ec 0c             	sub    $0xc,%esp
80104919:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010491c:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
8010491f:	e8 3c e0 ff ff       	call   80102960 <kfree>
        freevm(p->pgdir);
80104924:	5a                   	pop    %edx
80104925:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104928:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
8010492f:	e8 5c 3a 00 00       	call   80108390 <freevm>
        release(&ptable.lock);
80104934:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
        p->pid = 0;
8010493b:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104942:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104949:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010494d:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104954:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010495b:	e8 00 0a 00 00       	call   80105360 <release>
        return pid;
80104960:	83 c4 10             	add    $0x10,%esp
}
80104963:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104966:	89 f0                	mov    %esi,%eax
80104968:	5b                   	pop    %ebx
80104969:	5e                   	pop    %esi
8010496a:	5d                   	pop    %ebp
8010496b:	c3                   	ret    
      release(&ptable.lock);
8010496c:	83 ec 0c             	sub    $0xc,%esp
      return -1;
8010496f:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104974:	68 40 cd 14 80       	push   $0x8014cd40
80104979:	e8 e2 09 00 00       	call   80105360 <release>
      return -1;
8010497e:	83 c4 10             	add    $0x10,%esp
80104981:	eb e0                	jmp    80104963 <wait+0x133>
80104983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104990 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 10             	sub    $0x10,%esp
80104997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010499a:	68 40 cd 14 80       	push   $0x8014cd40
8010499f:	e8 fc 08 00 00       	call   801052a0 <acquire>
801049a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049a7:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801049ac:	eb 0e                	jmp    801049bc <wakeup+0x2c>
801049ae:	66 90                	xchg   %ax,%ax
801049b0:	05 18 03 00 00       	add    $0x318,%eax
801049b5:	3d 74 93 15 80       	cmp    $0x80159374,%eax
801049ba:	73 1e                	jae    801049da <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801049bc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801049c0:	75 ee                	jne    801049b0 <wakeup+0x20>
801049c2:	3b 58 20             	cmp    0x20(%eax),%ebx
801049c5:	75 e9                	jne    801049b0 <wakeup+0x20>
      p->state = RUNNABLE;
801049c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049ce:	05 18 03 00 00       	add    $0x318,%eax
801049d3:	3d 74 93 15 80       	cmp    $0x80159374,%eax
801049d8:	72 e2                	jb     801049bc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801049da:	c7 45 08 40 cd 14 80 	movl   $0x8014cd40,0x8(%ebp)
}
801049e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049e4:	c9                   	leave  
  release(&ptable.lock);
801049e5:	e9 76 09 00 00       	jmp    80105360 <release>
801049ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049f0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	53                   	push   %ebx
801049f4:	83 ec 10             	sub    $0x10,%esp
801049f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801049fa:	68 40 cd 14 80       	push   $0x8014cd40
801049ff:	e8 9c 08 00 00       	call   801052a0 <acquire>
80104a04:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a07:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104a0c:	eb 0e                	jmp    80104a1c <kill+0x2c>
80104a0e:	66 90                	xchg   %ax,%ax
80104a10:	05 18 03 00 00       	add    $0x318,%eax
80104a15:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104a1a:	73 34                	jae    80104a50 <kill+0x60>
    if(p->pid == pid){
80104a1c:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a1f:	75 ef                	jne    80104a10 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a21:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a25:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104a2c:	75 07                	jne    80104a35 <kill+0x45>
        p->state = RUNNABLE;
80104a2e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a35:	83 ec 0c             	sub    $0xc,%esp
80104a38:	68 40 cd 14 80       	push   $0x8014cd40
80104a3d:	e8 1e 09 00 00       	call   80105360 <release>
      return 0;
80104a42:	83 c4 10             	add    $0x10,%esp
80104a45:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104a47:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a4a:	c9                   	leave  
80104a4b:	c3                   	ret    
80104a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104a50:	83 ec 0c             	sub    $0xc,%esp
80104a53:	68 40 cd 14 80       	push   $0x8014cd40
80104a58:	e8 03 09 00 00       	call   80105360 <release>
  return -1;
80104a5d:	83 c4 10             	add    $0x10,%esp
80104a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a68:	c9                   	leave  
80104a69:	c3                   	ret    
80104a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a70 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
80104a76:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a79:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80104a7e:	83 ec 3c             	sub    $0x3c,%esp
80104a81:	eb 27                	jmp    80104aaa <procdump+0x3a>
80104a83:	90                   	nop
80104a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104a88:	83 ec 0c             	sub    $0xc,%esp
80104a8b:	68 74 95 10 80       	push   $0x80109574
80104a90:	e8 cb bb ff ff       	call   80100660 <cprintf>
80104a95:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a98:	81 c3 18 03 00 00    	add    $0x318,%ebx
80104a9e:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104aa4:	0f 83 a6 00 00 00    	jae    80104b50 <procdump+0xe0>
    if(p->state == UNUSED)
80104aaa:	8b 43 0c             	mov    0xc(%ebx),%eax
80104aad:	85 c0                	test   %eax,%eax
80104aaf:	74 e7                	je     80104a98 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104ab1:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104ab4:	ba 92 90 10 80       	mov    $0x80109092,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104ab9:	77 11                	ja     80104acc <procdump+0x5c>
80104abb:	8b 14 85 88 91 10 80 	mov    -0x7fef6e78(,%eax,4),%edx
      state = "???";
80104ac2:	b8 92 90 10 80       	mov    $0x80109092,%eax
80104ac7:	85 d2                	test   %edx,%edx
80104ac9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %d %d %d %d %s", p->pid, state, p->nPgsPhysical + p->nPgsSwap, p->nPgsSwap, p->nPGFLT, p->nTotalPGout, p->name);
80104acc:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104ad2:	8d 4b 6c             	lea    0x6c(%ebx),%ecx
80104ad5:	51                   	push   %ecx
80104ad6:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104adc:	ff b3 8c 00 00 00    	pushl  0x8c(%ebx)
80104ae2:	50                   	push   %eax
80104ae3:	03 83 80 00 00 00    	add    0x80(%ebx),%eax
80104ae9:	50                   	push   %eax
80104aea:	52                   	push   %edx
80104aeb:	ff 73 10             	pushl  0x10(%ebx)
80104aee:	68 96 90 10 80       	push   $0x80109096
80104af3:	e8 68 bb ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104af8:	83 c4 20             	add    $0x20,%esp
80104afb:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104aff:	75 87                	jne    80104a88 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104b01:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104b04:	83 ec 08             	sub    $0x8,%esp
80104b07:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104b0a:	50                   	push   %eax
80104b0b:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104b0e:	8b 40 0c             	mov    0xc(%eax),%eax
80104b11:	83 c0 08             	add    $0x8,%eax
80104b14:	50                   	push   %eax
80104b15:	e8 66 06 00 00       	call   80105180 <getcallerpcs>
80104b1a:	83 c4 10             	add    $0x10,%esp
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104b20:	8b 17                	mov    (%edi),%edx
80104b22:	85 d2                	test   %edx,%edx
80104b24:	0f 84 5e ff ff ff    	je     80104a88 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104b2a:	83 ec 08             	sub    $0x8,%esp
80104b2d:	83 c7 04             	add    $0x4,%edi
80104b30:	52                   	push   %edx
80104b31:	68 41 8a 10 80       	push   $0x80108a41
80104b36:	e8 25 bb ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b3b:	83 c4 10             	add    $0x10,%esp
80104b3e:	39 fe                	cmp    %edi,%esi
80104b40:	75 de                	jne    80104b20 <procdump+0xb0>
80104b42:	e9 41 ff ff ff       	jmp    80104a88 <procdump+0x18>
80104b47:	89 f6                	mov    %esi,%esi
80104b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
  #ifndef NONE
    cprintf("%d / %d\n",numFreePages() ,getTotalFreePages());
80104b50:	e8 ab dd ff ff       	call   80102900 <getTotalFreePages>
80104b55:	89 c3                	mov    %eax,%ebx
80104b57:	e8 a4 e0 ff ff       	call   80102c00 <numFreePages>
80104b5c:	83 ec 04             	sub    $0x4,%esp
80104b5f:	53                   	push   %ebx
80104b60:	50                   	push   %eax
80104b61:	68 ab 90 10 80       	push   $0x801090ab
80104b66:	e8 f5 ba ff ff       	call   80100660 <cprintf>
  #endif
}
80104b6b:	83 c4 10             	add    $0x10,%esp
80104b6e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b71:	5b                   	pop    %ebx
80104b72:	5e                   	pop    %esi
80104b73:	5f                   	pop    %edi
80104b74:	5d                   	pop    %ebp
80104b75:	c3                   	ret    
80104b76:	8d 76 00             	lea    0x0(%esi),%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b80 <ageTickUpdate>:

//update aging mechanisem of nfua algo each tick form trap.c
void
ageTickUpdate(){
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	57                   	push   %edi
80104b84:	56                   	push   %esi
80104b85:	53                   	push   %ebx
  struct proc *p;
  pte_t *pte,*pde,*pgtab;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b86:	be 74 cd 14 80       	mov    $0x8014cd74,%esi
ageTickUpdate(){
80104b8b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104b8e:	68 40 cd 14 80       	push   $0x8014cd40
80104b93:	e8 08 07 00 00       	call   801052a0 <acquire>
80104b98:	83 c4 10             	add    $0x10,%esp
80104b9b:	90                   	nop
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid<=2)
80104ba0:	83 7e 10 02          	cmpl   $0x2,0x10(%esi)
80104ba4:	0f 8e 86 00 00 00    	jle    80104c30 <ageTickUpdate+0xb0>
      continue;
    if(!((p->state == RUNNING) || (p->state == RUNNABLE) || (p->state == SLEEPING)))
80104baa:	8b 46 0c             	mov    0xc(%esi),%eax
80104bad:	83 e8 02             	sub    $0x2,%eax
80104bb0:	83 f8 02             	cmp    $0x2,%eax
80104bb3:	77 7b                	ja     80104c30 <ageTickUpdate+0xb0>
80104bb5:	8d 9e dc 01 00 00    	lea    0x1dc(%esi),%ebx
80104bbb:	8d be 1c 03 00 00    	lea    0x31c(%esi),%edi
80104bc1:	eb 37                	jmp    80104bfa <ageTickUpdate+0x7a>
80104bc3:	90                   	nop
80104bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        continue;
      
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
      if(*pde & PTE_P){
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104bc8:	c1 e8 0a             	shr    $0xa,%eax
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80104bcb:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104bd1:	25 fc 0f 00 00       	and    $0xffc,%eax
80104bd6:	8d 94 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edx
      } else {
        cprintf("nfuaUpdate: pte is not PTE_P\n");
        continue;
      }
      if(!pte){
80104bdd:	85 d2                	test   %edx,%edx
80104bdf:	74 7f                	je     80104c60 <ageTickUpdate+0xe0>
        cprintf("nfuaUpdate : !pte\n");
        continue;
      }

      p->physicalPGs[i].age = ((p->physicalPGs[i].age) >> 1); // shift right
80104be1:	8b 03                	mov    (%ebx),%eax
80104be3:	d1 e8                	shr    %eax
80104be5:	89 03                	mov    %eax,(%ebx)
      if(*pte & PTE_A){                                       // set MSB if accessed
80104be7:	f6 02 20             	testb  $0x20,(%edx)
80104bea:	74 07                	je     80104bf3 <ageTickUpdate+0x73>
        uint newBit = 1 << ((sizeof(uint)*8) - 1);
        p->physicalPGs[i].age |= newBit;
80104bec:	0d 00 00 00 80       	or     $0x80000000,%eax
80104bf1:	89 03                	mov    %eax,(%ebx)
80104bf3:	83 c3 14             	add    $0x14,%ebx
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104bf6:	39 df                	cmp    %ebx,%edi
80104bf8:	74 36                	je     80104c30 <ageTickUpdate+0xb0>
      if(p->physicalPGs[i].va == (char*)0xffffffff)
80104bfa:	8b 43 fc             	mov    -0x4(%ebx),%eax
80104bfd:	83 f8 ff             	cmp    $0xffffffff,%eax
80104c00:	74 f1                	je     80104bf3 <ageTickUpdate+0x73>
      if(*pde & PTE_P){
80104c02:	8b 56 04             	mov    0x4(%esi),%edx
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
80104c05:	89 c1                	mov    %eax,%ecx
80104c07:	c1 e9 16             	shr    $0x16,%ecx
      if(*pde & PTE_P){
80104c0a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80104c0d:	f6 c2 01             	test   $0x1,%dl
80104c10:	75 b6                	jne    80104bc8 <ageTickUpdate+0x48>
        cprintf("nfuaUpdate: pte is not PTE_P\n");
80104c12:	83 ec 0c             	sub    $0xc,%esp
80104c15:	83 c3 14             	add    $0x14,%ebx
80104c18:	68 b4 90 10 80       	push   $0x801090b4
80104c1d:	e8 3e ba ff ff       	call   80100660 <cprintf>
        continue;
80104c22:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104c25:	39 df                	cmp    %ebx,%edi
80104c27:	75 d1                	jne    80104bfa <ageTickUpdate+0x7a>
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c30:	81 c6 18 03 00 00    	add    $0x318,%esi
80104c36:	81 fe 74 93 15 80    	cmp    $0x80159374,%esi
80104c3c:	0f 82 5e ff ff ff    	jb     80104ba0 <ageTickUpdate+0x20>
      }
    }
  }
  release(&ptable.lock);
80104c42:	83 ec 0c             	sub    $0xc,%esp
80104c45:	68 40 cd 14 80       	push   $0x8014cd40
80104c4a:	e8 11 07 00 00       	call   80105360 <release>
}
80104c4f:	83 c4 10             	add    $0x10,%esp
80104c52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c55:	5b                   	pop    %ebx
80104c56:	5e                   	pop    %esi
80104c57:	5f                   	pop    %edi
80104c58:	5d                   	pop    %ebp
80104c59:	c3                   	ret    
80104c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate : !pte\n");
80104c60:	83 ec 0c             	sub    $0xc,%esp
80104c63:	68 d2 90 10 80       	push   $0x801090d2
80104c68:	e8 f3 b9 ff ff       	call   80100660 <cprintf>
        continue;
80104c6d:	83 c4 10             	add    $0x10,%esp
80104c70:	eb 81                	jmp    80104bf3 <ageTickUpdate+0x73>
80104c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c80 <advQueueTickUpdate>:

void
advQueueTickUpdate(){
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	57                   	push   %edi
80104c84:	56                   	push   %esi
80104c85:	53                   	push   %ebx
80104c86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104c89:	e8 42 05 00 00       	call   801051d0 <pushcli>
  c = mycpu();
80104c8e:	e8 ed f3 ff ff       	call   80104080 <mycpu>
  p = c->proc;
80104c93:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104c99:	e8 72 05 00 00       	call   80105210 <popcli>
  struct proc *p = myproc();
  struct procPG *prevPG,*page = &p->physicalPGs[p->headPG];
80104c9e:	8b 87 94 00 00 00    	mov    0x94(%edi),%eax
80104ca4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80104ca7:	c1 e1 02             	shl    $0x2,%ecx
80104caa:	8d 9c 0f d8 01 00 00 	lea    0x1d8(%edi,%ecx,1),%ebx
  char* headVa = page->va;
80104cb1:	01 f9                	add    %edi,%ecx
80104cb3:	8b 81 d8 01 00 00    	mov    0x1d8(%ecx),%eax
80104cb9:	89 45 e0             	mov    %eax,-0x20(%ebp)

  if(!page->next){
80104cbc:	8b 81 e4 01 00 00    	mov    0x1e4(%ecx),%eax
80104cc2:	85 c0                	test   %eax,%eax
80104cc4:	0f 84 ce 00 00 00    	je     80104d98 <advQueueTickUpdate+0x118>
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80104cca:	83 bf 80 00 00 00 01 	cmpl   $0x1,0x80(%edi)
80104cd1:	be 01 00 00 00       	mov    $0x1,%esi
80104cd6:	7f 0f                	jg     80104ce7 <advQueueTickUpdate+0x67>
80104cd8:	e9 b3 00 00 00       	jmp    80104d90 <advQueueTickUpdate+0x110>
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
80104ce0:	8b 43 0c             	mov    0xc(%ebx),%eax
80104ce3:	85 c0                	test   %eax,%eax
80104ce5:	74 11                	je     80104cf8 <advQueueTickUpdate+0x78>
  {
      page->next->prev = page;
80104ce7:	89 58 10             	mov    %ebx,0x10(%eax)
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80104cea:	83 c6 01             	add    $0x1,%esi
80104ced:	39 b7 80 00 00 00    	cmp    %esi,0x80(%edi)
      page = page->next;
80104cf3:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80104cf6:	7f e8                	jg     80104ce0 <advQueueTickUpdate+0x60>
  }

  p->physicalPGs[p->headPG].prev = page;
80104cf8:	8b 87 94 00 00 00    	mov    0x94(%edi),%eax
80104cfe:	8d 04 80             	lea    (%eax,%eax,4),%eax
80104d01:	89 9c 87 e8 01 00 00 	mov    %ebx,0x1e8(%edi,%eax,4)
80104d08:	eb 10                	jmp    80104d1a <advQueueTickUpdate+0x9a>
80104d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  pte_t *pte1, *pte2;
  for(;i > 1; i--){
80104d10:	83 ee 01             	sub    $0x1,%esi
    pte1 = nonStaticWalkpgdir(p->pgdir,(void*)page->va,0);
    prevPG = page->prev;
80104d13:	89 cb                	mov    %ecx,%ebx
  for(;i > 1; i--){
80104d15:	83 fe 01             	cmp    $0x1,%esi
80104d18:	7e 6b                	jle    80104d85 <advQueueTickUpdate+0x105>
    pte1 = nonStaticWalkpgdir(p->pgdir,(void*)page->va,0);
80104d1a:	83 ec 04             	sub    $0x4,%esp
80104d1d:	6a 00                	push   $0x0
80104d1f:	ff 33                	pushl  (%ebx)
80104d21:	ff 77 04             	pushl  0x4(%edi)
80104d24:	e8 97 2a 00 00       	call   801077c0 <nonStaticWalkpgdir>
    if(*pte1 & PTE_A){
80104d29:	83 c4 10             	add    $0x10,%esp
80104d2c:	f6 00 20             	testb  $0x20,(%eax)
    prevPG = page->prev;
80104d2f:	8b 4b 10             	mov    0x10(%ebx),%ecx
    if(*pte1 & PTE_A){
80104d32:	74 dc                	je     80104d10 <advQueueTickUpdate+0x90>
      pte2 = nonStaticWalkpgdir(p->pgdir,(void*)prevPG->va,0);
80104d34:	83 ec 04             	sub    $0x4,%esp
80104d37:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104d3a:	6a 00                	push   $0x0
80104d3c:	ff 31                	pushl  (%ecx)
80104d3e:	ff 77 04             	pushl  0x4(%edi)
80104d41:	e8 7a 2a 00 00       	call   801077c0 <nonStaticWalkpgdir>
      if((*pte2 & PTE_A)==0){
80104d46:	83 c4 10             	add    $0x10,%esp
80104d49:	f6 00 20             	testb  $0x20,(%eax)
80104d4c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104d4f:	75 bf                	jne    80104d10 <advQueueTickUpdate+0x90>
        if(prevPG->va != headVa){
80104d51:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104d54:	39 01                	cmp    %eax,(%ecx)
80104d56:	74 0c                	je     80104d64 <advQueueTickUpdate+0xe4>
          prevPG->prev->next = page;
80104d58:	8b 41 10             	mov    0x10(%ecx),%eax
80104d5b:	89 58 0c             	mov    %ebx,0xc(%eax)
          page->prev = prevPG->prev;
80104d5e:	8b 41 10             	mov    0x10(%ecx),%eax
80104d61:	89 43 10             	mov    %eax,0x10(%ebx)
        }
        
        if(i!=p->nPgsPhysical){
80104d64:	39 b7 80 00 00 00    	cmp    %esi,0x80(%edi)
80104d6a:	74 06                	je     80104d72 <advQueueTickUpdate+0xf2>
          prevPG->next = page->next;// only need next becouse of the reverse initialization when traversing the queue
80104d6c:	8b 43 0c             	mov    0xc(%ebx),%eax
80104d6f:	89 41 0c             	mov    %eax,0xc(%ecx)
        }
        
        page->next = prevPG;
        prevPG ->prev = page;
        page = prevPG->prev;
        i--;
80104d72:	83 ee 01             	sub    $0x1,%esi
        page->next = prevPG;
80104d75:	89 4b 0c             	mov    %ecx,0xc(%ebx)
        prevPG ->prev = page;
80104d78:	89 59 10             	mov    %ebx,0x10(%ecx)
  for(;i > 1; i--){
80104d7b:	83 ee 01             	sub    $0x1,%esi
    prevPG = page->prev;
80104d7e:	89 cb                	mov    %ecx,%ebx
  for(;i > 1; i--){
80104d80:	83 fe 01             	cmp    $0x1,%esi
80104d83:	7f 95                	jg     80104d1a <advQueueTickUpdate+0x9a>
      }
    }
    page = prevPG;
  }
}
80104d85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d88:	5b                   	pop    %ebx
80104d89:	5e                   	pop    %esi
80104d8a:	5f                   	pop    %edi
80104d8b:	5d                   	pop    %ebp
80104d8c:	c3                   	ret    
80104d8d:	8d 76 00             	lea    0x0(%esi),%esi
  p->physicalPGs[p->headPG].prev = page;
80104d90:	89 99 e8 01 00 00    	mov    %ebx,0x1e8(%ecx)
80104d96:	eb ed                	jmp    80104d85 <advQueueTickUpdate+0x105>
    panic("getLastPG: empty headPG list");
80104d98:	83 ec 0c             	sub    $0xc,%esp
80104d9b:	68 e5 90 10 80       	push   $0x801090e5
80104da0:	e8 eb b5 ff ff       	call   80100390 <panic>
80104da5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <singleProcDump>:
void
singleProcDump(int pid)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104db5:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80104dba:	83 ec 30             	sub    $0x30,%esp
80104dbd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if(p->pid != pid)
80104dc0:	8b 43 10             	mov    0x10(%ebx),%eax
80104dc3:	39 c8                	cmp    %ecx,%eax
80104dc5:	0f 85 85 00 00 00    	jne    80104e50 <singleProcDump+0xa0>
      continue;
    if(p->state == UNUSED)
80104dcb:	8b 53 0c             	mov    0xc(%ebx),%edx
80104dce:	85 d2                	test   %edx,%edx
80104dd0:	74 7e                	je     80104e50 <singleProcDump+0xa0>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dd2:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
80104dd5:	b9 92 90 10 80       	mov    $0x80109092,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dda:	0f 86 88 00 00 00    	jbe    80104e68 <singleProcDump+0xb8>
    #ifndef NONE
    cprintf("%d %s %d %d %d %d %s", p->pid, state, p->nPgsPhysical + p->nPgsSwap, p->nPgsSwap, p->nPGFLT, p->nTotalPGout, p->name);
80104de0:	8b 93 84 00 00 00    	mov    0x84(%ebx),%edx
80104de6:	8d 73 6c             	lea    0x6c(%ebx),%esi
80104de9:	56                   	push   %esi
80104dea:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104df0:	ff b3 8c 00 00 00    	pushl  0x8c(%ebx)
80104df6:	52                   	push   %edx
80104df7:	03 93 80 00 00 00    	add    0x80(%ebx),%edx
80104dfd:	52                   	push   %edx
80104dfe:	51                   	push   %ecx
80104dff:	50                   	push   %eax
80104e00:	68 96 90 10 80       	push   $0x80109096
80104e05:	e8 56 b8 ff ff       	call   80100660 <cprintf>
    #else
    cprintf("%d %s %s", p->pid, state, p->name);
    #endif
    if(p->state == SLEEPING){
80104e0a:	83 c4 20             	add    $0x20,%esp
80104e0d:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104e11:	74 6d                	je     80104e80 <singleProcDump+0xd0>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104e13:	83 ec 0c             	sub    $0xc,%esp
80104e16:	68 74 95 10 80       	push   $0x80109574
80104e1b:	e8 40 b8 ff ff       	call   80100660 <cprintf>
    break;
80104e20:	83 c4 10             	add    $0x10,%esp
  }
  #ifndef NONE
    cprintf("%d / %d\n",numFreePages() ,getTotalFreePages());
80104e23:	e8 d8 da ff ff       	call   80102900 <getTotalFreePages>
80104e28:	89 c3                	mov    %eax,%ebx
80104e2a:	e8 d1 dd ff ff       	call   80102c00 <numFreePages>
80104e2f:	83 ec 04             	sub    $0x4,%esp
80104e32:	53                   	push   %ebx
80104e33:	50                   	push   %eax
80104e34:	68 ab 90 10 80       	push   $0x801090ab
80104e39:	e8 22 b8 ff ff       	call   80100660 <cprintf>
  #endif
80104e3e:	83 c4 10             	add    $0x10,%esp
80104e41:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e44:	5b                   	pop    %ebx
80104e45:	5e                   	pop    %esi
80104e46:	5d                   	pop    %ebp
80104e47:	c3                   	ret    
80104e48:	90                   	nop
80104e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e50:	81 c3 18 03 00 00    	add    $0x318,%ebx
80104e56:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104e5c:	0f 82 5e ff ff ff    	jb     80104dc0 <singleProcDump+0x10>
80104e62:	eb bf                	jmp    80104e23 <singleProcDump+0x73>
80104e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e68:	8b 0c 95 88 91 10 80 	mov    -0x7fef6e78(,%edx,4),%ecx
      state = "???";
80104e6f:	ba 92 90 10 80       	mov    $0x80109092,%edx
80104e74:	85 c9                	test   %ecx,%ecx
80104e76:	0f 44 ca             	cmove  %edx,%ecx
80104e79:	e9 62 ff ff ff       	jmp    80104de0 <singleProcDump+0x30>
80104e7e:	66 90                	xchg   %ax,%ax
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e80:	8d 75 d0             	lea    -0x30(%ebp),%esi
80104e83:	83 ec 08             	sub    $0x8,%esp
80104e86:	56                   	push   %esi
80104e87:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104e8a:	89 f3                	mov    %esi,%ebx
80104e8c:	8d 75 f8             	lea    -0x8(%ebp),%esi
80104e8f:	8b 40 0c             	mov    0xc(%eax),%eax
80104e92:	83 c0 08             	add    $0x8,%eax
80104e95:	50                   	push   %eax
80104e96:	e8 e5 02 00 00       	call   80105180 <getcallerpcs>
80104e9b:	83 c4 10             	add    $0x10,%esp
80104e9e:	66 90                	xchg   %ax,%ax
      for(i=0; i<10 && pc[i] != 0; i++)
80104ea0:	8b 03                	mov    (%ebx),%eax
80104ea2:	85 c0                	test   %eax,%eax
80104ea4:	0f 84 69 ff ff ff    	je     80104e13 <singleProcDump+0x63>
        cprintf(" %p", pc[i]);
80104eaa:	83 ec 08             	sub    $0x8,%esp
80104ead:	83 c3 04             	add    $0x4,%ebx
80104eb0:	50                   	push   %eax
80104eb1:	68 41 8a 10 80       	push   $0x80108a41
80104eb6:	e8 a5 b7 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104ebb:	83 c4 10             	add    $0x10,%esp
80104ebe:	39 de                	cmp    %ebx,%esi
80104ec0:	75 de                	jne    80104ea0 <singleProcDump+0xf0>
80104ec2:	e9 4c ff ff ff       	jmp    80104e13 <singleProcDump+0x63>
80104ec7:	89 f6                	mov    %esi,%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <exit>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	57                   	push   %edi
80104ed4:	56                   	push   %esi
80104ed5:	53                   	push   %ebx
80104ed6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104ed9:	e8 f2 02 00 00       	call   801051d0 <pushcli>
  c = mycpu();
80104ede:	e8 9d f1 ff ff       	call   80104080 <mycpu>
  p = c->proc;
80104ee3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104ee9:	e8 22 03 00 00       	call   80105210 <popcli>
  if(curproc == initproc)
80104eee:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
80104ef4:	8d 5e 28             	lea    0x28(%esi),%ebx
80104ef7:	8d 7e 68             	lea    0x68(%esi),%edi
80104efa:	0f 84 1e 01 00 00    	je     8010501e <exit+0x14e>
    if(curproc->ofile[fd]){
80104f00:	8b 03                	mov    (%ebx),%eax
80104f02:	85 c0                	test   %eax,%eax
80104f04:	74 12                	je     80104f18 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104f06:	83 ec 0c             	sub    $0xc,%esp
80104f09:	50                   	push   %eax
80104f0a:	e8 41 c1 ff ff       	call   80101050 <fileclose>
      curproc->ofile[fd] = 0;
80104f0f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104f15:	83 c4 10             	add    $0x10,%esp
80104f18:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80104f1b:	39 fb                	cmp    %edi,%ebx
80104f1d:	75 e1                	jne    80104f00 <exit+0x30>
    singleProcDump(curproc->pid);
80104f1f:	83 ec 0c             	sub    $0xc,%esp
80104f22:	ff 76 10             	pushl  0x10(%esi)
80104f25:	e8 86 fe ff ff       	call   80104db0 <singleProcDump>
  if(removeSwapFile(curproc) != 0){
80104f2a:	89 34 24             	mov    %esi,(%esp)
80104f2d:	e8 8e d2 ff ff       	call   801021c0 <removeSwapFile>
80104f32:	83 c4 10             	add    $0x10,%esp
80104f35:	85 c0                	test   %eax,%eax
80104f37:	0f 85 bb 00 00 00    	jne    80104ff8 <exit+0x128>
  begin_op();
80104f3d:	e8 ee e4 ff ff       	call   80103430 <begin_op>
  iput(curproc->cwd);
80104f42:	83 ec 0c             	sub    $0xc,%esp
80104f45:	ff 76 68             	pushl  0x68(%esi)
80104f48:	e8 73 ca ff ff       	call   801019c0 <iput>
  end_op();
80104f4d:	e8 4e e5 ff ff       	call   801034a0 <end_op>
  curproc->cwd = 0;
80104f52:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104f59:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104f60:	e8 3b 03 00 00       	call   801052a0 <acquire>
  wakeup1(curproc->parent);
80104f65:	8b 56 14             	mov    0x14(%esi),%edx
80104f68:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f6b:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104f70:	eb 12                	jmp    80104f84 <exit+0xb4>
80104f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f78:	05 18 03 00 00       	add    $0x318,%eax
80104f7d:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104f82:	73 1e                	jae    80104fa2 <exit+0xd2>
    if(p->state == SLEEPING && p->chan == chan)
80104f84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f88:	75 ee                	jne    80104f78 <exit+0xa8>
80104f8a:	3b 50 20             	cmp    0x20(%eax),%edx
80104f8d:	75 e9                	jne    80104f78 <exit+0xa8>
      p->state = RUNNABLE;
80104f8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f96:	05 18 03 00 00       	add    $0x318,%eax
80104f9b:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104fa0:	72 e2                	jb     80104f84 <exit+0xb4>
      p->parent = initproc;
80104fa2:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104fa8:	ba 74 cd 14 80       	mov    $0x8014cd74,%edx
80104fad:	eb 0f                	jmp    80104fbe <exit+0xee>
80104faf:	90                   	nop
80104fb0:	81 c2 18 03 00 00    	add    $0x318,%edx
80104fb6:	81 fa 74 93 15 80    	cmp    $0x80159374,%edx
80104fbc:	73 47                	jae    80105005 <exit+0x135>
    if(p->parent == curproc){
80104fbe:	39 72 14             	cmp    %esi,0x14(%edx)
80104fc1:	75 ed                	jne    80104fb0 <exit+0xe0>
      if(p->state == ZOMBIE)
80104fc3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104fc7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104fca:	75 e4                	jne    80104fb0 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fcc:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104fd1:	eb 11                	jmp    80104fe4 <exit+0x114>
80104fd3:	90                   	nop
80104fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fd8:	05 18 03 00 00       	add    $0x318,%eax
80104fdd:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104fe2:	73 cc                	jae    80104fb0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80104fe4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104fe8:	75 ee                	jne    80104fd8 <exit+0x108>
80104fea:	3b 48 20             	cmp    0x20(%eax),%ecx
80104fed:	75 e9                	jne    80104fd8 <exit+0x108>
      p->state = RUNNABLE;
80104fef:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104ff6:	eb e0                	jmp    80104fd8 <exit+0x108>
    panic("exit: cant remove swapfile");
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	68 0f 91 10 80       	push   $0x8010910f
80105000:	e8 8b b3 ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
80105005:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010500c:	e8 4f f6 ff ff       	call   80104660 <sched>
  panic("zombie exit");
80105011:	83 ec 0c             	sub    $0xc,%esp
80105014:	68 2a 91 10 80       	push   $0x8010912a
80105019:	e8 72 b3 ff ff       	call   80100390 <panic>
    panic("init exiting");
8010501e:	83 ec 0c             	sub    $0xc,%esp
80105021:	68 02 91 10 80       	push   $0x80109102
80105026:	e8 65 b3 ff ff       	call   80100390 <panic>
8010502b:	66 90                	xchg   %ax,%ax
8010502d:	66 90                	xchg   %ax,%ax
8010502f:	90                   	nop

80105030 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
80105034:	83 ec 0c             	sub    $0xc,%esp
80105037:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010503a:	68 a0 91 10 80       	push   $0x801091a0
8010503f:	8d 43 04             	lea    0x4(%ebx),%eax
80105042:	50                   	push   %eax
80105043:	e8 18 01 00 00       	call   80105160 <initlock>
  lk->name = name;
80105048:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010504b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80105051:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80105054:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010505b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010505e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105061:	c9                   	leave  
80105062:	c3                   	ret    
80105063:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105070 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	56                   	push   %esi
80105074:	53                   	push   %ebx
80105075:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105078:	83 ec 0c             	sub    $0xc,%esp
8010507b:	8d 73 04             	lea    0x4(%ebx),%esi
8010507e:	56                   	push   %esi
8010507f:	e8 1c 02 00 00       	call   801052a0 <acquire>
  while (lk->locked) {
80105084:	8b 13                	mov    (%ebx),%edx
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	85 d2                	test   %edx,%edx
8010508b:	74 16                	je     801050a3 <acquiresleep+0x33>
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105090:	83 ec 08             	sub    $0x8,%esp
80105093:	56                   	push   %esi
80105094:	53                   	push   %ebx
80105095:	e8 d6 f6 ff ff       	call   80104770 <sleep>
  while (lk->locked) {
8010509a:	8b 03                	mov    (%ebx),%eax
8010509c:	83 c4 10             	add    $0x10,%esp
8010509f:	85 c0                	test   %eax,%eax
801050a1:	75 ed                	jne    80105090 <acquiresleep+0x20>
  }
  lk->locked = 1;
801050a3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801050a9:	e8 72 f0 ff ff       	call   80104120 <myproc>
801050ae:	8b 40 10             	mov    0x10(%eax),%eax
801050b1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801050b4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801050b7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050ba:	5b                   	pop    %ebx
801050bb:	5e                   	pop    %esi
801050bc:	5d                   	pop    %ebp
  release(&lk->lk);
801050bd:	e9 9e 02 00 00       	jmp    80105360 <release>
801050c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050d0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	56                   	push   %esi
801050d4:	53                   	push   %ebx
801050d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801050d8:	83 ec 0c             	sub    $0xc,%esp
801050db:	8d 73 04             	lea    0x4(%ebx),%esi
801050de:	56                   	push   %esi
801050df:	e8 bc 01 00 00       	call   801052a0 <acquire>
  lk->locked = 0;
801050e4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801050ea:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801050f1:	89 1c 24             	mov    %ebx,(%esp)
801050f4:	e8 97 f8 ff ff       	call   80104990 <wakeup>
  release(&lk->lk);
801050f9:	89 75 08             	mov    %esi,0x8(%ebp)
801050fc:	83 c4 10             	add    $0x10,%esp
}
801050ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105102:	5b                   	pop    %ebx
80105103:	5e                   	pop    %esi
80105104:	5d                   	pop    %ebp
  release(&lk->lk);
80105105:	e9 56 02 00 00       	jmp    80105360 <release>
8010510a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105110 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	57                   	push   %edi
80105114:	56                   	push   %esi
80105115:	53                   	push   %ebx
80105116:	31 ff                	xor    %edi,%edi
80105118:	83 ec 18             	sub    $0x18,%esp
8010511b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010511e:	8d 73 04             	lea    0x4(%ebx),%esi
80105121:	56                   	push   %esi
80105122:	e8 79 01 00 00       	call   801052a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105127:	8b 03                	mov    (%ebx),%eax
80105129:	83 c4 10             	add    $0x10,%esp
8010512c:	85 c0                	test   %eax,%eax
8010512e:	74 13                	je     80105143 <holdingsleep+0x33>
80105130:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105133:	e8 e8 ef ff ff       	call   80104120 <myproc>
80105138:	39 58 10             	cmp    %ebx,0x10(%eax)
8010513b:	0f 94 c0             	sete   %al
8010513e:	0f b6 c0             	movzbl %al,%eax
80105141:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80105143:	83 ec 0c             	sub    $0xc,%esp
80105146:	56                   	push   %esi
80105147:	e8 14 02 00 00       	call   80105360 <release>
  return r;
}
8010514c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010514f:	89 f8                	mov    %edi,%eax
80105151:	5b                   	pop    %ebx
80105152:	5e                   	pop    %esi
80105153:	5f                   	pop    %edi
80105154:	5d                   	pop    %ebp
80105155:	c3                   	ret    
80105156:	66 90                	xchg   %ax,%ax
80105158:	66 90                	xchg   %ax,%ax
8010515a:	66 90                	xchg   %ax,%ax
8010515c:	66 90                	xchg   %ax,%ax
8010515e:	66 90                	xchg   %ax,%ax

80105160 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105166:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105169:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010516f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105172:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105179:	5d                   	pop    %ebp
8010517a:	c3                   	ret    
8010517b:	90                   	nop
8010517c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105180 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105180:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105181:	31 d2                	xor    %edx,%edx
{
80105183:	89 e5                	mov    %esp,%ebp
80105185:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80105186:	8b 45 08             	mov    0x8(%ebp),%eax
{
80105189:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
8010518c:	83 e8 08             	sub    $0x8,%eax
8010518f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105190:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105196:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010519c:	77 1a                	ja     801051b8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010519e:	8b 58 04             	mov    0x4(%eax),%ebx
801051a1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801051a4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801051a7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801051a9:	83 fa 0a             	cmp    $0xa,%edx
801051ac:	75 e2                	jne    80105190 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801051ae:	5b                   	pop    %ebx
801051af:	5d                   	pop    %ebp
801051b0:	c3                   	ret    
801051b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051b8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801051bb:	83 c1 28             	add    $0x28,%ecx
801051be:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
801051c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801051c6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
801051c9:	39 c1                	cmp    %eax,%ecx
801051cb:	75 f3                	jne    801051c0 <getcallerpcs+0x40>
}
801051cd:	5b                   	pop    %ebx
801051ce:	5d                   	pop    %ebp
801051cf:	c3                   	ret    

801051d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	53                   	push   %ebx
801051d4:	83 ec 04             	sub    $0x4,%esp
801051d7:	9c                   	pushf  
801051d8:	5b                   	pop    %ebx
  asm volatile("cli");
801051d9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801051da:	e8 a1 ee ff ff       	call   80104080 <mycpu>
801051df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801051e5:	85 c0                	test   %eax,%eax
801051e7:	75 11                	jne    801051fa <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801051e9:	81 e3 00 02 00 00    	and    $0x200,%ebx
801051ef:	e8 8c ee ff ff       	call   80104080 <mycpu>
801051f4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801051fa:	e8 81 ee ff ff       	call   80104080 <mycpu>
801051ff:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105206:	83 c4 04             	add    $0x4,%esp
80105209:	5b                   	pop    %ebx
8010520a:	5d                   	pop    %ebp
8010520b:	c3                   	ret    
8010520c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105210 <popcli>:

void
popcli(void)
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105216:	9c                   	pushf  
80105217:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105218:	f6 c4 02             	test   $0x2,%ah
8010521b:	75 35                	jne    80105252 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010521d:	e8 5e ee ff ff       	call   80104080 <mycpu>
80105222:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80105229:	78 34                	js     8010525f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010522b:	e8 50 ee ff ff       	call   80104080 <mycpu>
80105230:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105236:	85 d2                	test   %edx,%edx
80105238:	74 06                	je     80105240 <popcli+0x30>
    sti();
}
8010523a:	c9                   	leave  
8010523b:	c3                   	ret    
8010523c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105240:	e8 3b ee ff ff       	call   80104080 <mycpu>
80105245:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010524b:	85 c0                	test   %eax,%eax
8010524d:	74 eb                	je     8010523a <popcli+0x2a>
  asm volatile("sti");
8010524f:	fb                   	sti    
}
80105250:	c9                   	leave  
80105251:	c3                   	ret    
    panic("popcli - interruptible");
80105252:	83 ec 0c             	sub    $0xc,%esp
80105255:	68 ab 91 10 80       	push   $0x801091ab
8010525a:	e8 31 b1 ff ff       	call   80100390 <panic>
    panic("popcli");
8010525f:	83 ec 0c             	sub    $0xc,%esp
80105262:	68 c2 91 10 80       	push   $0x801091c2
80105267:	e8 24 b1 ff ff       	call   80100390 <panic>
8010526c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105270 <holding>:
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	56                   	push   %esi
80105274:	53                   	push   %ebx
80105275:	8b 75 08             	mov    0x8(%ebp),%esi
80105278:	31 db                	xor    %ebx,%ebx
  pushcli();
8010527a:	e8 51 ff ff ff       	call   801051d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010527f:	8b 06                	mov    (%esi),%eax
80105281:	85 c0                	test   %eax,%eax
80105283:	74 10                	je     80105295 <holding+0x25>
80105285:	8b 5e 08             	mov    0x8(%esi),%ebx
80105288:	e8 f3 ed ff ff       	call   80104080 <mycpu>
8010528d:	39 c3                	cmp    %eax,%ebx
8010528f:	0f 94 c3             	sete   %bl
80105292:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105295:	e8 76 ff ff ff       	call   80105210 <popcli>
}
8010529a:	89 d8                	mov    %ebx,%eax
8010529c:	5b                   	pop    %ebx
8010529d:	5e                   	pop    %esi
8010529e:	5d                   	pop    %ebp
8010529f:	c3                   	ret    

801052a0 <acquire>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801052a5:	e8 26 ff ff ff       	call   801051d0 <pushcli>
  if(holding(lk))
801052aa:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052ad:	83 ec 0c             	sub    $0xc,%esp
801052b0:	53                   	push   %ebx
801052b1:	e8 ba ff ff ff       	call   80105270 <holding>
801052b6:	83 c4 10             	add    $0x10,%esp
801052b9:	85 c0                	test   %eax,%eax
801052bb:	0f 85 83 00 00 00    	jne    80105344 <acquire+0xa4>
801052c1:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801052c3:	ba 01 00 00 00       	mov    $0x1,%edx
801052c8:	eb 09                	jmp    801052d3 <acquire+0x33>
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052d3:	89 d0                	mov    %edx,%eax
801052d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801052d8:	85 c0                	test   %eax,%eax
801052da:	75 f4                	jne    801052d0 <acquire+0x30>
  __sync_synchronize();
801052dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801052e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801052e4:	e8 97 ed ff ff       	call   80104080 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801052e9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801052ec:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801052ef:	89 e8                	mov    %ebp,%eax
801052f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801052f8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801052fe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80105304:	77 1a                	ja     80105320 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80105306:	8b 48 04             	mov    0x4(%eax),%ecx
80105309:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010530c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010530f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105311:	83 fe 0a             	cmp    $0xa,%esi
80105314:	75 e2                	jne    801052f8 <acquire+0x58>
}
80105316:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105319:	5b                   	pop    %ebx
8010531a:	5e                   	pop    %esi
8010531b:	5d                   	pop    %ebp
8010531c:	c3                   	ret    
8010531d:	8d 76 00             	lea    0x0(%esi),%esi
80105320:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80105323:	83 c2 28             	add    $0x28,%edx
80105326:	8d 76 00             	lea    0x0(%esi),%esi
80105329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105330:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105336:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105339:	39 d0                	cmp    %edx,%eax
8010533b:	75 f3                	jne    80105330 <acquire+0x90>
}
8010533d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105340:	5b                   	pop    %ebx
80105341:	5e                   	pop    %esi
80105342:	5d                   	pop    %ebp
80105343:	c3                   	ret    
    panic("acquire");
80105344:	83 ec 0c             	sub    $0xc,%esp
80105347:	68 c9 91 10 80       	push   $0x801091c9
8010534c:	e8 3f b0 ff ff       	call   80100390 <panic>
80105351:	eb 0d                	jmp    80105360 <release>
80105353:	90                   	nop
80105354:	90                   	nop
80105355:	90                   	nop
80105356:	90                   	nop
80105357:	90                   	nop
80105358:	90                   	nop
80105359:	90                   	nop
8010535a:	90                   	nop
8010535b:	90                   	nop
8010535c:	90                   	nop
8010535d:	90                   	nop
8010535e:	90                   	nop
8010535f:	90                   	nop

80105360 <release>:
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	53                   	push   %ebx
80105364:	83 ec 10             	sub    $0x10,%esp
80105367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010536a:	53                   	push   %ebx
8010536b:	e8 00 ff ff ff       	call   80105270 <holding>
80105370:	83 c4 10             	add    $0x10,%esp
80105373:	85 c0                	test   %eax,%eax
80105375:	74 22                	je     80105399 <release+0x39>
  lk->pcs[0] = 0;
80105377:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010537e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105385:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010538a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105390:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105393:	c9                   	leave  
  popcli();
80105394:	e9 77 fe ff ff       	jmp    80105210 <popcli>
    panic("release");
80105399:	83 ec 0c             	sub    $0xc,%esp
8010539c:	68 d1 91 10 80       	push   $0x801091d1
801053a1:	e8 ea af ff ff       	call   80100390 <panic>
801053a6:	66 90                	xchg   %ax,%ax
801053a8:	66 90                	xchg   %ax,%ax
801053aa:	66 90                	xchg   %ax,%ax
801053ac:	66 90                	xchg   %ax,%ax
801053ae:	66 90                	xchg   %ax,%ax

801053b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	57                   	push   %edi
801053b4:	53                   	push   %ebx
801053b5:	8b 55 08             	mov    0x8(%ebp),%edx
801053b8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801053bb:	f6 c2 03             	test   $0x3,%dl
801053be:	75 05                	jne    801053c5 <memset+0x15>
801053c0:	f6 c1 03             	test   $0x3,%cl
801053c3:	74 13                	je     801053d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801053c5:	89 d7                	mov    %edx,%edi
801053c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ca:	fc                   	cld    
801053cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801053cd:	5b                   	pop    %ebx
801053ce:	89 d0                	mov    %edx,%eax
801053d0:	5f                   	pop    %edi
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret    
801053d3:	90                   	nop
801053d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801053d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801053dc:	c1 e9 02             	shr    $0x2,%ecx
801053df:	89 f8                	mov    %edi,%eax
801053e1:	89 fb                	mov    %edi,%ebx
801053e3:	c1 e0 18             	shl    $0x18,%eax
801053e6:	c1 e3 10             	shl    $0x10,%ebx
801053e9:	09 d8                	or     %ebx,%eax
801053eb:	09 f8                	or     %edi,%eax
801053ed:	c1 e7 08             	shl    $0x8,%edi
801053f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801053f2:	89 d7                	mov    %edx,%edi
801053f4:	fc                   	cld    
801053f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801053f7:	5b                   	pop    %ebx
801053f8:	89 d0                	mov    %edx,%eax
801053fa:	5f                   	pop    %edi
801053fb:	5d                   	pop    %ebp
801053fc:	c3                   	ret    
801053fd:	8d 76 00             	lea    0x0(%esi),%esi

80105400 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
80105406:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105409:	8b 75 08             	mov    0x8(%ebp),%esi
8010540c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010540f:	85 db                	test   %ebx,%ebx
80105411:	74 29                	je     8010543c <memcmp+0x3c>
    if(*s1 != *s2)
80105413:	0f b6 16             	movzbl (%esi),%edx
80105416:	0f b6 0f             	movzbl (%edi),%ecx
80105419:	38 d1                	cmp    %dl,%cl
8010541b:	75 2b                	jne    80105448 <memcmp+0x48>
8010541d:	b8 01 00 00 00       	mov    $0x1,%eax
80105422:	eb 14                	jmp    80105438 <memcmp+0x38>
80105424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105428:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
8010542c:	83 c0 01             	add    $0x1,%eax
8010542f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105434:	38 ca                	cmp    %cl,%dl
80105436:	75 10                	jne    80105448 <memcmp+0x48>
  while(n-- > 0){
80105438:	39 d8                	cmp    %ebx,%eax
8010543a:	75 ec                	jne    80105428 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010543c:	5b                   	pop    %ebx
  return 0;
8010543d:	31 c0                	xor    %eax,%eax
}
8010543f:	5e                   	pop    %esi
80105440:	5f                   	pop    %edi
80105441:	5d                   	pop    %ebp
80105442:	c3                   	ret    
80105443:	90                   	nop
80105444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80105448:	0f b6 c2             	movzbl %dl,%eax
}
8010544b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010544c:	29 c8                	sub    %ecx,%eax
}
8010544e:	5e                   	pop    %esi
8010544f:	5f                   	pop    %edi
80105450:	5d                   	pop    %ebp
80105451:	c3                   	ret    
80105452:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105460 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	56                   	push   %esi
80105464:	53                   	push   %ebx
80105465:	8b 45 08             	mov    0x8(%ebp),%eax
80105468:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010546b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010546e:	39 c3                	cmp    %eax,%ebx
80105470:	73 26                	jae    80105498 <memmove+0x38>
80105472:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105475:	39 c8                	cmp    %ecx,%eax
80105477:	73 1f                	jae    80105498 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105479:	85 f6                	test   %esi,%esi
8010547b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010547e:	74 0f                	je     8010548f <memmove+0x2f>
      *--d = *--s;
80105480:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105484:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105487:	83 ea 01             	sub    $0x1,%edx
8010548a:	83 fa ff             	cmp    $0xffffffff,%edx
8010548d:	75 f1                	jne    80105480 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010548f:	5b                   	pop    %ebx
80105490:	5e                   	pop    %esi
80105491:	5d                   	pop    %ebp
80105492:	c3                   	ret    
80105493:	90                   	nop
80105494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105498:	31 d2                	xor    %edx,%edx
8010549a:	85 f6                	test   %esi,%esi
8010549c:	74 f1                	je     8010548f <memmove+0x2f>
8010549e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801054a0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801054a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801054a7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801054aa:	39 d6                	cmp    %edx,%esi
801054ac:	75 f2                	jne    801054a0 <memmove+0x40>
}
801054ae:	5b                   	pop    %ebx
801054af:	5e                   	pop    %esi
801054b0:	5d                   	pop    %ebp
801054b1:	c3                   	ret    
801054b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801054c3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801054c4:	eb 9a                	jmp    80105460 <memmove>
801054c6:	8d 76 00             	lea    0x0(%esi),%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054d0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	57                   	push   %edi
801054d4:	56                   	push   %esi
801054d5:	8b 7d 10             	mov    0x10(%ebp),%edi
801054d8:	53                   	push   %ebx
801054d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801054dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801054df:	85 ff                	test   %edi,%edi
801054e1:	74 2f                	je     80105512 <strncmp+0x42>
801054e3:	0f b6 01             	movzbl (%ecx),%eax
801054e6:	0f b6 1e             	movzbl (%esi),%ebx
801054e9:	84 c0                	test   %al,%al
801054eb:	74 37                	je     80105524 <strncmp+0x54>
801054ed:	38 c3                	cmp    %al,%bl
801054ef:	75 33                	jne    80105524 <strncmp+0x54>
801054f1:	01 f7                	add    %esi,%edi
801054f3:	eb 13                	jmp    80105508 <strncmp+0x38>
801054f5:	8d 76 00             	lea    0x0(%esi),%esi
801054f8:	0f b6 01             	movzbl (%ecx),%eax
801054fb:	84 c0                	test   %al,%al
801054fd:	74 21                	je     80105520 <strncmp+0x50>
801054ff:	0f b6 1a             	movzbl (%edx),%ebx
80105502:	89 d6                	mov    %edx,%esi
80105504:	38 d8                	cmp    %bl,%al
80105506:	75 1c                	jne    80105524 <strncmp+0x54>
    n--, p++, q++;
80105508:	8d 56 01             	lea    0x1(%esi),%edx
8010550b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
8010550e:	39 fa                	cmp    %edi,%edx
80105510:	75 e6                	jne    801054f8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105512:	5b                   	pop    %ebx
    return 0;
80105513:	31 c0                	xor    %eax,%eax
}
80105515:	5e                   	pop    %esi
80105516:	5f                   	pop    %edi
80105517:	5d                   	pop    %ebp
80105518:	c3                   	ret    
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105520:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80105524:	29 d8                	sub    %ebx,%eax
}
80105526:	5b                   	pop    %ebx
80105527:	5e                   	pop    %esi
80105528:	5f                   	pop    %edi
80105529:	5d                   	pop    %ebp
8010552a:	c3                   	ret    
8010552b:	90                   	nop
8010552c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105530 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	56                   	push   %esi
80105534:	53                   	push   %ebx
80105535:	8b 45 08             	mov    0x8(%ebp),%eax
80105538:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010553b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010553e:	89 c2                	mov    %eax,%edx
80105540:	eb 19                	jmp    8010555b <strncpy+0x2b>
80105542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105548:	83 c3 01             	add    $0x1,%ebx
8010554b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010554f:	83 c2 01             	add    $0x1,%edx
80105552:	84 c9                	test   %cl,%cl
80105554:	88 4a ff             	mov    %cl,-0x1(%edx)
80105557:	74 09                	je     80105562 <strncpy+0x32>
80105559:	89 f1                	mov    %esi,%ecx
8010555b:	85 c9                	test   %ecx,%ecx
8010555d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105560:	7f e6                	jg     80105548 <strncpy+0x18>
    ;
  while(n-- > 0)
80105562:	31 c9                	xor    %ecx,%ecx
80105564:	85 f6                	test   %esi,%esi
80105566:	7e 17                	jle    8010557f <strncpy+0x4f>
80105568:	90                   	nop
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105570:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105574:	89 f3                	mov    %esi,%ebx
80105576:	83 c1 01             	add    $0x1,%ecx
80105579:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010557b:	85 db                	test   %ebx,%ebx
8010557d:	7f f1                	jg     80105570 <strncpy+0x40>
  return os;
}
8010557f:	5b                   	pop    %ebx
80105580:	5e                   	pop    %esi
80105581:	5d                   	pop    %ebp
80105582:	c3                   	ret    
80105583:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105590 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	56                   	push   %esi
80105594:	53                   	push   %ebx
80105595:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105598:	8b 45 08             	mov    0x8(%ebp),%eax
8010559b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010559e:	85 c9                	test   %ecx,%ecx
801055a0:	7e 26                	jle    801055c8 <safestrcpy+0x38>
801055a2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801055a6:	89 c1                	mov    %eax,%ecx
801055a8:	eb 17                	jmp    801055c1 <safestrcpy+0x31>
801055aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801055b0:	83 c2 01             	add    $0x1,%edx
801055b3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801055b7:	83 c1 01             	add    $0x1,%ecx
801055ba:	84 db                	test   %bl,%bl
801055bc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801055bf:	74 04                	je     801055c5 <safestrcpy+0x35>
801055c1:	39 f2                	cmp    %esi,%edx
801055c3:	75 eb                	jne    801055b0 <safestrcpy+0x20>
    ;
  *s = 0;
801055c5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
801055c8:	5b                   	pop    %ebx
801055c9:	5e                   	pop    %esi
801055ca:	5d                   	pop    %ebp
801055cb:	c3                   	ret    
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <strlen>:

int
strlen(const char *s)
{
801055d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801055d1:	31 c0                	xor    %eax,%eax
{
801055d3:	89 e5                	mov    %esp,%ebp
801055d5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801055d8:	80 3a 00             	cmpb   $0x0,(%edx)
801055db:	74 0c                	je     801055e9 <strlen+0x19>
801055dd:	8d 76 00             	lea    0x0(%esi),%esi
801055e0:	83 c0 01             	add    $0x1,%eax
801055e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801055e7:	75 f7                	jne    801055e0 <strlen+0x10>
    ;
  return n;
}
801055e9:	5d                   	pop    %ebp
801055ea:	c3                   	ret    

801055eb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801055eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801055ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801055f3:	55                   	push   %ebp
  pushl %ebx
801055f4:	53                   	push   %ebx
  pushl %esi
801055f5:	56                   	push   %esi
  pushl %edi
801055f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801055f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801055f9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801055fb:	5f                   	pop    %edi
  popl %esi
801055fc:	5e                   	pop    %esi
  popl %ebx
801055fd:	5b                   	pop    %ebx
  popl %ebp
801055fe:	5d                   	pop    %ebp
  ret
801055ff:	c3                   	ret    

80105600 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	53                   	push   %ebx
80105604:	83 ec 04             	sub    $0x4,%esp
80105607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010560a:	e8 11 eb ff ff       	call   80104120 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010560f:	8b 00                	mov    (%eax),%eax
80105611:	39 d8                	cmp    %ebx,%eax
80105613:	76 1b                	jbe    80105630 <fetchint+0x30>
80105615:	8d 53 04             	lea    0x4(%ebx),%edx
80105618:	39 d0                	cmp    %edx,%eax
8010561a:	72 14                	jb     80105630 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010561c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010561f:	8b 13                	mov    (%ebx),%edx
80105621:	89 10                	mov    %edx,(%eax)
  return 0;
80105623:	31 c0                	xor    %eax,%eax
}
80105625:	83 c4 04             	add    $0x4,%esp
80105628:	5b                   	pop    %ebx
80105629:	5d                   	pop    %ebp
8010562a:	c3                   	ret    
8010562b:	90                   	nop
8010562c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105630:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105635:	eb ee                	jmp    80105625 <fetchint+0x25>
80105637:	89 f6                	mov    %esi,%esi
80105639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105640 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105640:	55                   	push   %ebp
80105641:	89 e5                	mov    %esp,%ebp
80105643:	53                   	push   %ebx
80105644:	83 ec 04             	sub    $0x4,%esp
80105647:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010564a:	e8 d1 ea ff ff       	call   80104120 <myproc>

  if(addr >= curproc->sz)
8010564f:	39 18                	cmp    %ebx,(%eax)
80105651:	76 29                	jbe    8010567c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105653:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105656:	89 da                	mov    %ebx,%edx
80105658:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010565a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010565c:	39 c3                	cmp    %eax,%ebx
8010565e:	73 1c                	jae    8010567c <fetchstr+0x3c>
    if(*s == 0)
80105660:	80 3b 00             	cmpb   $0x0,(%ebx)
80105663:	75 10                	jne    80105675 <fetchstr+0x35>
80105665:	eb 39                	jmp    801056a0 <fetchstr+0x60>
80105667:	89 f6                	mov    %esi,%esi
80105669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105670:	80 3a 00             	cmpb   $0x0,(%edx)
80105673:	74 1b                	je     80105690 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105675:	83 c2 01             	add    $0x1,%edx
80105678:	39 d0                	cmp    %edx,%eax
8010567a:	77 f4                	ja     80105670 <fetchstr+0x30>
    return -1;
8010567c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105681:	83 c4 04             	add    $0x4,%esp
80105684:	5b                   	pop    %ebx
80105685:	5d                   	pop    %ebp
80105686:	c3                   	ret    
80105687:	89 f6                	mov    %esi,%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105690:	83 c4 04             	add    $0x4,%esp
80105693:	89 d0                	mov    %edx,%eax
80105695:	29 d8                	sub    %ebx,%eax
80105697:	5b                   	pop    %ebx
80105698:	5d                   	pop    %ebp
80105699:	c3                   	ret    
8010569a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
801056a0:	31 c0                	xor    %eax,%eax
      return s - *pp;
801056a2:	eb dd                	jmp    80105681 <fetchstr+0x41>
801056a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801056b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801056b0:	55                   	push   %ebp
801056b1:	89 e5                	mov    %esp,%ebp
801056b3:	56                   	push   %esi
801056b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056b5:	e8 66 ea ff ff       	call   80104120 <myproc>
801056ba:	8b 40 18             	mov    0x18(%eax),%eax
801056bd:	8b 55 08             	mov    0x8(%ebp),%edx
801056c0:	8b 40 44             	mov    0x44(%eax),%eax
801056c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801056c6:	e8 55 ea ff ff       	call   80104120 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801056cb:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056cd:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801056d0:	39 c6                	cmp    %eax,%esi
801056d2:	73 1c                	jae    801056f0 <argint+0x40>
801056d4:	8d 53 08             	lea    0x8(%ebx),%edx
801056d7:	39 d0                	cmp    %edx,%eax
801056d9:	72 15                	jb     801056f0 <argint+0x40>
  *ip = *(int*)(addr);
801056db:	8b 45 0c             	mov    0xc(%ebp),%eax
801056de:	8b 53 04             	mov    0x4(%ebx),%edx
801056e1:	89 10                	mov    %edx,(%eax)
  return 0;
801056e3:	31 c0                	xor    %eax,%eax
}
801056e5:	5b                   	pop    %ebx
801056e6:	5e                   	pop    %esi
801056e7:	5d                   	pop    %ebp
801056e8:	c3                   	ret    
801056e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801056f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801056f5:	eb ee                	jmp    801056e5 <argint+0x35>
801056f7:	89 f6                	mov    %esi,%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105700 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	56                   	push   %esi
80105704:	53                   	push   %ebx
80105705:	83 ec 10             	sub    $0x10,%esp
80105708:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010570b:	e8 10 ea ff ff       	call   80104120 <myproc>
80105710:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105712:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105715:	83 ec 08             	sub    $0x8,%esp
80105718:	50                   	push   %eax
80105719:	ff 75 08             	pushl  0x8(%ebp)
8010571c:	e8 8f ff ff ff       	call   801056b0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105721:	83 c4 10             	add    $0x10,%esp
80105724:	85 c0                	test   %eax,%eax
80105726:	78 28                	js     80105750 <argptr+0x50>
80105728:	85 db                	test   %ebx,%ebx
8010572a:	78 24                	js     80105750 <argptr+0x50>
8010572c:	8b 16                	mov    (%esi),%edx
8010572e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105731:	39 c2                	cmp    %eax,%edx
80105733:	76 1b                	jbe    80105750 <argptr+0x50>
80105735:	01 c3                	add    %eax,%ebx
80105737:	39 da                	cmp    %ebx,%edx
80105739:	72 15                	jb     80105750 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010573b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010573e:	89 02                	mov    %eax,(%edx)
  return 0;
80105740:	31 c0                	xor    %eax,%eax
}
80105742:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105745:	5b                   	pop    %ebx
80105746:	5e                   	pop    %esi
80105747:	5d                   	pop    %ebp
80105748:	c3                   	ret    
80105749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105755:	eb eb                	jmp    80105742 <argptr+0x42>
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105760 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105766:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105769:	50                   	push   %eax
8010576a:	ff 75 08             	pushl  0x8(%ebp)
8010576d:	e8 3e ff ff ff       	call   801056b0 <argint>
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	85 c0                	test   %eax,%eax
80105777:	78 17                	js     80105790 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105779:	83 ec 08             	sub    $0x8,%esp
8010577c:	ff 75 0c             	pushl  0xc(%ebp)
8010577f:	ff 75 f4             	pushl  -0xc(%ebp)
80105782:	e8 b9 fe ff ff       	call   80105640 <fetchstr>
80105787:	83 c4 10             	add    $0x10,%esp
}
8010578a:	c9                   	leave  
8010578b:	c3                   	ret    
8010578c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105795:	c9                   	leave  
80105796:	c3                   	ret    
80105797:	89 f6                	mov    %esi,%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <syscall>:
[SYS_printProcDump] sys_printProcDump,
};

void
syscall(void)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	53                   	push   %ebx
801057a4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801057a7:	e8 74 e9 ff ff       	call   80104120 <myproc>
801057ac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801057ae:	8b 40 18             	mov    0x18(%eax),%eax
801057b1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801057b4:	8d 50 ff             	lea    -0x1(%eax),%edx
801057b7:	83 fa 16             	cmp    $0x16,%edx
801057ba:	77 1c                	ja     801057d8 <syscall+0x38>
801057bc:	8b 14 85 00 92 10 80 	mov    -0x7fef6e00(,%eax,4),%edx
801057c3:	85 d2                	test   %edx,%edx
801057c5:	74 11                	je     801057d8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801057c7:	ff d2                	call   *%edx
801057c9:	8b 53 18             	mov    0x18(%ebx),%edx
801057cc:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801057cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057d2:	c9                   	leave  
801057d3:	c3                   	ret    
801057d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801057d8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801057d9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801057dc:	50                   	push   %eax
801057dd:	ff 73 10             	pushl  0x10(%ebx)
801057e0:	68 d9 91 10 80       	push   $0x801091d9
801057e5:	e8 76 ae ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801057ea:	8b 43 18             	mov    0x18(%ebx),%eax
801057ed:	83 c4 10             	add    $0x10,%esp
801057f0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801057f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057fa:	c9                   	leave  
801057fb:	c3                   	ret    
801057fc:	66 90                	xchg   %ax,%ax
801057fe:	66 90                	xchg   %ax,%ax

80105800 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
80105805:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105807:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010580a:	89 d6                	mov    %edx,%esi
8010580c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010580f:	50                   	push   %eax
80105810:	6a 00                	push   $0x0
80105812:	e8 99 fe ff ff       	call   801056b0 <argint>
80105817:	83 c4 10             	add    $0x10,%esp
8010581a:	85 c0                	test   %eax,%eax
8010581c:	78 2a                	js     80105848 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010581e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105822:	77 24                	ja     80105848 <argfd.constprop.0+0x48>
80105824:	e8 f7 e8 ff ff       	call   80104120 <myproc>
80105829:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010582c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105830:	85 c0                	test   %eax,%eax
80105832:	74 14                	je     80105848 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80105834:	85 db                	test   %ebx,%ebx
80105836:	74 02                	je     8010583a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105838:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
8010583a:	89 06                	mov    %eax,(%esi)
  return 0;
8010583c:	31 c0                	xor    %eax,%eax
}
8010583e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105841:	5b                   	pop    %ebx
80105842:	5e                   	pop    %esi
80105843:	5d                   	pop    %ebp
80105844:	c3                   	ret    
80105845:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010584d:	eb ef                	jmp    8010583e <argfd.constprop.0+0x3e>
8010584f:	90                   	nop

80105850 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105850:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105851:	31 c0                	xor    %eax,%eax
{
80105853:	89 e5                	mov    %esp,%ebp
80105855:	56                   	push   %esi
80105856:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105857:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010585a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010585d:	e8 9e ff ff ff       	call   80105800 <argfd.constprop.0>
80105862:	85 c0                	test   %eax,%eax
80105864:	78 42                	js     801058a8 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105866:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105869:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010586b:	e8 b0 e8 ff ff       	call   80104120 <myproc>
80105870:	eb 0e                	jmp    80105880 <sys_dup+0x30>
80105872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105878:	83 c3 01             	add    $0x1,%ebx
8010587b:	83 fb 10             	cmp    $0x10,%ebx
8010587e:	74 28                	je     801058a8 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105880:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105884:	85 d2                	test   %edx,%edx
80105886:	75 f0                	jne    80105878 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105888:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010588c:	83 ec 0c             	sub    $0xc,%esp
8010588f:	ff 75 f4             	pushl  -0xc(%ebp)
80105892:	e8 69 b7 ff ff       	call   80101000 <filedup>
  return fd;
80105897:	83 c4 10             	add    $0x10,%esp
}
8010589a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010589d:	89 d8                	mov    %ebx,%eax
8010589f:	5b                   	pop    %ebx
801058a0:	5e                   	pop    %esi
801058a1:	5d                   	pop    %ebp
801058a2:	c3                   	ret    
801058a3:	90                   	nop
801058a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801058ab:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801058b0:	89 d8                	mov    %ebx,%eax
801058b2:	5b                   	pop    %ebx
801058b3:	5e                   	pop    %esi
801058b4:	5d                   	pop    %ebp
801058b5:	c3                   	ret    
801058b6:	8d 76 00             	lea    0x0(%esi),%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058c0 <sys_read>:

int
sys_read(void)
{
801058c0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058c1:	31 c0                	xor    %eax,%eax
{
801058c3:	89 e5                	mov    %esp,%ebp
801058c5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058c8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801058cb:	e8 30 ff ff ff       	call   80105800 <argfd.constprop.0>
801058d0:	85 c0                	test   %eax,%eax
801058d2:	78 4c                	js     80105920 <sys_read+0x60>
801058d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058d7:	83 ec 08             	sub    $0x8,%esp
801058da:	50                   	push   %eax
801058db:	6a 02                	push   $0x2
801058dd:	e8 ce fd ff ff       	call   801056b0 <argint>
801058e2:	83 c4 10             	add    $0x10,%esp
801058e5:	85 c0                	test   %eax,%eax
801058e7:	78 37                	js     80105920 <sys_read+0x60>
801058e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058ec:	83 ec 04             	sub    $0x4,%esp
801058ef:	ff 75 f0             	pushl  -0x10(%ebp)
801058f2:	50                   	push   %eax
801058f3:	6a 01                	push   $0x1
801058f5:	e8 06 fe ff ff       	call   80105700 <argptr>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	85 c0                	test   %eax,%eax
801058ff:	78 1f                	js     80105920 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105901:	83 ec 04             	sub    $0x4,%esp
80105904:	ff 75 f0             	pushl  -0x10(%ebp)
80105907:	ff 75 f4             	pushl  -0xc(%ebp)
8010590a:	ff 75 ec             	pushl  -0x14(%ebp)
8010590d:	e8 5e b8 ff ff       	call   80101170 <fileread>
80105912:	83 c4 10             	add    $0x10,%esp
}
80105915:	c9                   	leave  
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105920:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105925:	c9                   	leave  
80105926:	c3                   	ret    
80105927:	89 f6                	mov    %esi,%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105930 <sys_write>:

int
sys_write(void)
{
80105930:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105931:	31 c0                	xor    %eax,%eax
{
80105933:	89 e5                	mov    %esp,%ebp
80105935:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105938:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010593b:	e8 c0 fe ff ff       	call   80105800 <argfd.constprop.0>
80105940:	85 c0                	test   %eax,%eax
80105942:	78 4c                	js     80105990 <sys_write+0x60>
80105944:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105947:	83 ec 08             	sub    $0x8,%esp
8010594a:	50                   	push   %eax
8010594b:	6a 02                	push   $0x2
8010594d:	e8 5e fd ff ff       	call   801056b0 <argint>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	78 37                	js     80105990 <sys_write+0x60>
80105959:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010595c:	83 ec 04             	sub    $0x4,%esp
8010595f:	ff 75 f0             	pushl  -0x10(%ebp)
80105962:	50                   	push   %eax
80105963:	6a 01                	push   $0x1
80105965:	e8 96 fd ff ff       	call   80105700 <argptr>
8010596a:	83 c4 10             	add    $0x10,%esp
8010596d:	85 c0                	test   %eax,%eax
8010596f:	78 1f                	js     80105990 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105971:	83 ec 04             	sub    $0x4,%esp
80105974:	ff 75 f0             	pushl  -0x10(%ebp)
80105977:	ff 75 f4             	pushl  -0xc(%ebp)
8010597a:	ff 75 ec             	pushl  -0x14(%ebp)
8010597d:	e8 7e b8 ff ff       	call   80101200 <filewrite>
80105982:	83 c4 10             	add    $0x10,%esp
}
80105985:	c9                   	leave  
80105986:	c3                   	ret    
80105987:	89 f6                	mov    %esi,%esi
80105989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105995:	c9                   	leave  
80105996:	c3                   	ret    
80105997:	89 f6                	mov    %esi,%esi
80105999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059a0 <sys_close>:

int
sys_close(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801059a6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801059a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059ac:	e8 4f fe ff ff       	call   80105800 <argfd.constprop.0>
801059b1:	85 c0                	test   %eax,%eax
801059b3:	78 2b                	js     801059e0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
801059b5:	e8 66 e7 ff ff       	call   80104120 <myproc>
801059ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801059bd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801059c0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801059c7:	00 
  fileclose(f);
801059c8:	ff 75 f4             	pushl  -0xc(%ebp)
801059cb:	e8 80 b6 ff ff       	call   80101050 <fileclose>
  return 0;
801059d0:	83 c4 10             	add    $0x10,%esp
801059d3:	31 c0                	xor    %eax,%eax
}
801059d5:	c9                   	leave  
801059d6:	c3                   	ret    
801059d7:	89 f6                	mov    %esi,%esi
801059d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801059e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059e5:	c9                   	leave  
801059e6:	c3                   	ret    
801059e7:	89 f6                	mov    %esi,%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059f0 <sys_fstat>:

int
sys_fstat(void)
{
801059f0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059f1:	31 c0                	xor    %eax,%eax
{
801059f3:	89 e5                	mov    %esp,%ebp
801059f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801059f8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801059fb:	e8 00 fe ff ff       	call   80105800 <argfd.constprop.0>
80105a00:	85 c0                	test   %eax,%eax
80105a02:	78 2c                	js     80105a30 <sys_fstat+0x40>
80105a04:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a07:	83 ec 04             	sub    $0x4,%esp
80105a0a:	6a 14                	push   $0x14
80105a0c:	50                   	push   %eax
80105a0d:	6a 01                	push   $0x1
80105a0f:	e8 ec fc ff ff       	call   80105700 <argptr>
80105a14:	83 c4 10             	add    $0x10,%esp
80105a17:	85 c0                	test   %eax,%eax
80105a19:	78 15                	js     80105a30 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80105a1b:	83 ec 08             	sub    $0x8,%esp
80105a1e:	ff 75 f4             	pushl  -0xc(%ebp)
80105a21:	ff 75 f0             	pushl  -0x10(%ebp)
80105a24:	e8 f7 b6 ff ff       	call   80101120 <filestat>
80105a29:	83 c4 10             	add    $0x10,%esp
}
80105a2c:	c9                   	leave  
80105a2d:	c3                   	ret    
80105a2e:	66 90                	xchg   %ax,%ax
    return -1;
80105a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a35:	c9                   	leave  
80105a36:	c3                   	ret    
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a40 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a46:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105a49:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105a4c:	50                   	push   %eax
80105a4d:	6a 00                	push   $0x0
80105a4f:	e8 0c fd ff ff       	call   80105760 <argstr>
80105a54:	83 c4 10             	add    $0x10,%esp
80105a57:	85 c0                	test   %eax,%eax
80105a59:	0f 88 fb 00 00 00    	js     80105b5a <sys_link+0x11a>
80105a5f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105a62:	83 ec 08             	sub    $0x8,%esp
80105a65:	50                   	push   %eax
80105a66:	6a 01                	push   $0x1
80105a68:	e8 f3 fc ff ff       	call   80105760 <argstr>
80105a6d:	83 c4 10             	add    $0x10,%esp
80105a70:	85 c0                	test   %eax,%eax
80105a72:	0f 88 e2 00 00 00    	js     80105b5a <sys_link+0x11a>
    return -1;

  begin_op();
80105a78:	e8 b3 d9 ff ff       	call   80103430 <begin_op>
  if((ip = namei(old)) == 0){
80105a7d:	83 ec 0c             	sub    $0xc,%esp
80105a80:	ff 75 d4             	pushl  -0x2c(%ebp)
80105a83:	e8 68 c6 ff ff       	call   801020f0 <namei>
80105a88:	83 c4 10             	add    $0x10,%esp
80105a8b:	85 c0                	test   %eax,%eax
80105a8d:	89 c3                	mov    %eax,%ebx
80105a8f:	0f 84 ea 00 00 00    	je     80105b7f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105a95:	83 ec 0c             	sub    $0xc,%esp
80105a98:	50                   	push   %eax
80105a99:	e8 f2 bd ff ff       	call   80101890 <ilock>
  if(ip->type == T_DIR){
80105a9e:	83 c4 10             	add    $0x10,%esp
80105aa1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105aa6:	0f 84 bb 00 00 00    	je     80105b67 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80105aac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ab1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105ab4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105ab7:	53                   	push   %ebx
80105ab8:	e8 23 bd ff ff       	call   801017e0 <iupdate>
  iunlock(ip);
80105abd:	89 1c 24             	mov    %ebx,(%esp)
80105ac0:	e8 ab be ff ff       	call   80101970 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105ac5:	58                   	pop    %eax
80105ac6:	5a                   	pop    %edx
80105ac7:	57                   	push   %edi
80105ac8:	ff 75 d0             	pushl  -0x30(%ebp)
80105acb:	e8 40 c6 ff ff       	call   80102110 <nameiparent>
80105ad0:	83 c4 10             	add    $0x10,%esp
80105ad3:	85 c0                	test   %eax,%eax
80105ad5:	89 c6                	mov    %eax,%esi
80105ad7:	74 5b                	je     80105b34 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105ad9:	83 ec 0c             	sub    $0xc,%esp
80105adc:	50                   	push   %eax
80105add:	e8 ae bd ff ff       	call   80101890 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105ae2:	83 c4 10             	add    $0x10,%esp
80105ae5:	8b 03                	mov    (%ebx),%eax
80105ae7:	39 06                	cmp    %eax,(%esi)
80105ae9:	75 3d                	jne    80105b28 <sys_link+0xe8>
80105aeb:	83 ec 04             	sub    $0x4,%esp
80105aee:	ff 73 04             	pushl  0x4(%ebx)
80105af1:	57                   	push   %edi
80105af2:	56                   	push   %esi
80105af3:	e8 38 c5 ff ff       	call   80102030 <dirlink>
80105af8:	83 c4 10             	add    $0x10,%esp
80105afb:	85 c0                	test   %eax,%eax
80105afd:	78 29                	js     80105b28 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80105aff:	83 ec 0c             	sub    $0xc,%esp
80105b02:	56                   	push   %esi
80105b03:	e8 18 c0 ff ff       	call   80101b20 <iunlockput>
  iput(ip);
80105b08:	89 1c 24             	mov    %ebx,(%esp)
80105b0b:	e8 b0 be ff ff       	call   801019c0 <iput>

  end_op();
80105b10:	e8 8b d9 ff ff       	call   801034a0 <end_op>

  return 0;
80105b15:	83 c4 10             	add    $0x10,%esp
80105b18:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80105b1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b1d:	5b                   	pop    %ebx
80105b1e:	5e                   	pop    %esi
80105b1f:	5f                   	pop    %edi
80105b20:	5d                   	pop    %ebp
80105b21:	c3                   	ret    
80105b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	56                   	push   %esi
80105b2c:	e8 ef bf ff ff       	call   80101b20 <iunlockput>
    goto bad;
80105b31:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105b34:	83 ec 0c             	sub    $0xc,%esp
80105b37:	53                   	push   %ebx
80105b38:	e8 53 bd ff ff       	call   80101890 <ilock>
  ip->nlink--;
80105b3d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b42:	89 1c 24             	mov    %ebx,(%esp)
80105b45:	e8 96 bc ff ff       	call   801017e0 <iupdate>
  iunlockput(ip);
80105b4a:	89 1c 24             	mov    %ebx,(%esp)
80105b4d:	e8 ce bf ff ff       	call   80101b20 <iunlockput>
  end_op();
80105b52:	e8 49 d9 ff ff       	call   801034a0 <end_op>
  return -1;
80105b57:	83 c4 10             	add    $0x10,%esp
}
80105b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80105b5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b62:	5b                   	pop    %ebx
80105b63:	5e                   	pop    %esi
80105b64:	5f                   	pop    %edi
80105b65:	5d                   	pop    %ebp
80105b66:	c3                   	ret    
    iunlockput(ip);
80105b67:	83 ec 0c             	sub    $0xc,%esp
80105b6a:	53                   	push   %ebx
80105b6b:	e8 b0 bf ff ff       	call   80101b20 <iunlockput>
    end_op();
80105b70:	e8 2b d9 ff ff       	call   801034a0 <end_op>
    return -1;
80105b75:	83 c4 10             	add    $0x10,%esp
80105b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7d:	eb 9b                	jmp    80105b1a <sys_link+0xda>
    end_op();
80105b7f:	e8 1c d9 ff ff       	call   801034a0 <end_op>
    return -1;
80105b84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b89:	eb 8f                	jmp    80105b1a <sys_link+0xda>
80105b8b:	90                   	nop
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b90 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	83 ec 1c             	sub    $0x1c,%esp
80105b99:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105b9c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105ba0:	76 3e                	jbe    80105be0 <isdirempty+0x50>
80105ba2:	bb 20 00 00 00       	mov    $0x20,%ebx
80105ba7:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105baa:	eb 0c                	jmp    80105bb8 <isdirempty+0x28>
80105bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bb0:	83 c3 10             	add    $0x10,%ebx
80105bb3:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105bb6:	73 28                	jae    80105be0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105bb8:	6a 10                	push   $0x10
80105bba:	53                   	push   %ebx
80105bbb:	57                   	push   %edi
80105bbc:	56                   	push   %esi
80105bbd:	e8 ae bf ff ff       	call   80101b70 <readi>
80105bc2:	83 c4 10             	add    $0x10,%esp
80105bc5:	83 f8 10             	cmp    $0x10,%eax
80105bc8:	75 23                	jne    80105bed <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
80105bca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105bcf:	74 df                	je     80105bb0 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105bd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105bd4:	31 c0                	xor    %eax,%eax
}
80105bd6:	5b                   	pop    %ebx
80105bd7:	5e                   	pop    %esi
80105bd8:	5f                   	pop    %edi
80105bd9:	5d                   	pop    %ebp
80105bda:	c3                   	ret    
80105bdb:	90                   	nop
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105be0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
80105be3:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105be8:	5b                   	pop    %ebx
80105be9:	5e                   	pop    %esi
80105bea:	5f                   	pop    %edi
80105beb:	5d                   	pop    %ebp
80105bec:	c3                   	ret    
      panic("isdirempty: readi");
80105bed:	83 ec 0c             	sub    $0xc,%esp
80105bf0:	68 60 92 10 80       	push   $0x80109260
80105bf5:	e8 96 a7 ff ff       	call   80100390 <panic>
80105bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c00 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	57                   	push   %edi
80105c04:	56                   	push   %esi
80105c05:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c06:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105c09:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
80105c0c:	50                   	push   %eax
80105c0d:	6a 00                	push   $0x0
80105c0f:	e8 4c fb ff ff       	call   80105760 <argstr>
80105c14:	83 c4 10             	add    $0x10,%esp
80105c17:	85 c0                	test   %eax,%eax
80105c19:	0f 88 51 01 00 00    	js     80105d70 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80105c1f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105c22:	e8 09 d8 ff ff       	call   80103430 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105c27:	83 ec 08             	sub    $0x8,%esp
80105c2a:	53                   	push   %ebx
80105c2b:	ff 75 c0             	pushl  -0x40(%ebp)
80105c2e:	e8 dd c4 ff ff       	call   80102110 <nameiparent>
80105c33:	83 c4 10             	add    $0x10,%esp
80105c36:	85 c0                	test   %eax,%eax
80105c38:	89 c6                	mov    %eax,%esi
80105c3a:	0f 84 37 01 00 00    	je     80105d77 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105c40:	83 ec 0c             	sub    $0xc,%esp
80105c43:	50                   	push   %eax
80105c44:	e8 47 bc ff ff       	call   80101890 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105c49:	58                   	pop    %eax
80105c4a:	5a                   	pop    %edx
80105c4b:	68 7d 8b 10 80       	push   $0x80108b7d
80105c50:	53                   	push   %ebx
80105c51:	e8 4a c1 ff ff       	call   80101da0 <namecmp>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	0f 84 d7 00 00 00    	je     80105d38 <sys_unlink+0x138>
80105c61:	83 ec 08             	sub    $0x8,%esp
80105c64:	68 7c 8b 10 80       	push   $0x80108b7c
80105c69:	53                   	push   %ebx
80105c6a:	e8 31 c1 ff ff       	call   80101da0 <namecmp>
80105c6f:	83 c4 10             	add    $0x10,%esp
80105c72:	85 c0                	test   %eax,%eax
80105c74:	0f 84 be 00 00 00    	je     80105d38 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105c7a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105c7d:	83 ec 04             	sub    $0x4,%esp
80105c80:	50                   	push   %eax
80105c81:	53                   	push   %ebx
80105c82:	56                   	push   %esi
80105c83:	e8 38 c1 ff ff       	call   80101dc0 <dirlookup>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	89 c3                	mov    %eax,%ebx
80105c8f:	0f 84 a3 00 00 00    	je     80105d38 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105c95:	83 ec 0c             	sub    $0xc,%esp
80105c98:	50                   	push   %eax
80105c99:	e8 f2 bb ff ff       	call   80101890 <ilock>

  if(ip->nlink < 1)
80105c9e:	83 c4 10             	add    $0x10,%esp
80105ca1:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105ca6:	0f 8e e4 00 00 00    	jle    80105d90 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105cac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cb1:	74 65                	je     80105d18 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105cb3:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105cb6:	83 ec 04             	sub    $0x4,%esp
80105cb9:	6a 10                	push   $0x10
80105cbb:	6a 00                	push   $0x0
80105cbd:	57                   	push   %edi
80105cbe:	e8 ed f6 ff ff       	call   801053b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105cc3:	6a 10                	push   $0x10
80105cc5:	ff 75 c4             	pushl  -0x3c(%ebp)
80105cc8:	57                   	push   %edi
80105cc9:	56                   	push   %esi
80105cca:	e8 a1 bf ff ff       	call   80101c70 <writei>
80105ccf:	83 c4 20             	add    $0x20,%esp
80105cd2:	83 f8 10             	cmp    $0x10,%eax
80105cd5:	0f 85 a8 00 00 00    	jne    80105d83 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105cdb:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ce0:	74 6e                	je     80105d50 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105ce2:	83 ec 0c             	sub    $0xc,%esp
80105ce5:	56                   	push   %esi
80105ce6:	e8 35 be ff ff       	call   80101b20 <iunlockput>

  ip->nlink--;
80105ceb:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105cf0:	89 1c 24             	mov    %ebx,(%esp)
80105cf3:	e8 e8 ba ff ff       	call   801017e0 <iupdate>
  iunlockput(ip);
80105cf8:	89 1c 24             	mov    %ebx,(%esp)
80105cfb:	e8 20 be ff ff       	call   80101b20 <iunlockput>

  end_op();
80105d00:	e8 9b d7 ff ff       	call   801034a0 <end_op>

  return 0;
80105d05:	83 c4 10             	add    $0x10,%esp
80105d08:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105d0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d0d:	5b                   	pop    %ebx
80105d0e:	5e                   	pop    %esi
80105d0f:	5f                   	pop    %edi
80105d10:	5d                   	pop    %ebp
80105d11:	c3                   	ret    
80105d12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
80105d18:	83 ec 0c             	sub    $0xc,%esp
80105d1b:	53                   	push   %ebx
80105d1c:	e8 6f fe ff ff       	call   80105b90 <isdirempty>
80105d21:	83 c4 10             	add    $0x10,%esp
80105d24:	85 c0                	test   %eax,%eax
80105d26:	75 8b                	jne    80105cb3 <sys_unlink+0xb3>
    iunlockput(ip);
80105d28:	83 ec 0c             	sub    $0xc,%esp
80105d2b:	53                   	push   %ebx
80105d2c:	e8 ef bd ff ff       	call   80101b20 <iunlockput>
    goto bad;
80105d31:	83 c4 10             	add    $0x10,%esp
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105d38:	83 ec 0c             	sub    $0xc,%esp
80105d3b:	56                   	push   %esi
80105d3c:	e8 df bd ff ff       	call   80101b20 <iunlockput>
  end_op();
80105d41:	e8 5a d7 ff ff       	call   801034a0 <end_op>
  return -1;
80105d46:	83 c4 10             	add    $0x10,%esp
80105d49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d4e:	eb ba                	jmp    80105d0a <sys_unlink+0x10a>
    dp->nlink--;
80105d50:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105d55:	83 ec 0c             	sub    $0xc,%esp
80105d58:	56                   	push   %esi
80105d59:	e8 82 ba ff ff       	call   801017e0 <iupdate>
80105d5e:	83 c4 10             	add    $0x10,%esp
80105d61:	e9 7c ff ff ff       	jmp    80105ce2 <sys_unlink+0xe2>
80105d66:	8d 76 00             	lea    0x0(%esi),%esi
80105d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d75:	eb 93                	jmp    80105d0a <sys_unlink+0x10a>
    end_op();
80105d77:	e8 24 d7 ff ff       	call   801034a0 <end_op>
    return -1;
80105d7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d81:	eb 87                	jmp    80105d0a <sys_unlink+0x10a>
    panic("unlink: writei");
80105d83:	83 ec 0c             	sub    $0xc,%esp
80105d86:	68 91 8b 10 80       	push   $0x80108b91
80105d8b:	e8 00 a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	68 7f 8b 10 80       	push   $0x80108b7f
80105d98:	e8 f3 a5 ff ff       	call   80100390 <panic>
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi

80105da0 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	57                   	push   %edi
80105da4:	56                   	push   %esi
80105da5:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105da6:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105da9:	83 ec 34             	sub    $0x34,%esp
80105dac:	8b 45 0c             	mov    0xc(%ebp),%eax
80105daf:	8b 55 10             	mov    0x10(%ebp),%edx
80105db2:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105db5:	56                   	push   %esi
80105db6:	ff 75 08             	pushl  0x8(%ebp)
{
80105db9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105dbc:	89 55 d0             	mov    %edx,-0x30(%ebp)
80105dbf:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105dc2:	e8 49 c3 ff ff       	call   80102110 <nameiparent>
80105dc7:	83 c4 10             	add    $0x10,%esp
80105dca:	85 c0                	test   %eax,%eax
80105dcc:	0f 84 4e 01 00 00    	je     80105f20 <create+0x180>
    return 0;
  ilock(dp);
80105dd2:	83 ec 0c             	sub    $0xc,%esp
80105dd5:	89 c3                	mov    %eax,%ebx
80105dd7:	50                   	push   %eax
80105dd8:	e8 b3 ba ff ff       	call   80101890 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105ddd:	83 c4 0c             	add    $0xc,%esp
80105de0:	6a 00                	push   $0x0
80105de2:	56                   	push   %esi
80105de3:	53                   	push   %ebx
80105de4:	e8 d7 bf ff ff       	call   80101dc0 <dirlookup>
80105de9:	83 c4 10             	add    $0x10,%esp
80105dec:	85 c0                	test   %eax,%eax
80105dee:	89 c7                	mov    %eax,%edi
80105df0:	74 3e                	je     80105e30 <create+0x90>
    iunlockput(dp);
80105df2:	83 ec 0c             	sub    $0xc,%esp
80105df5:	53                   	push   %ebx
80105df6:	e8 25 bd ff ff       	call   80101b20 <iunlockput>
    ilock(ip);
80105dfb:	89 3c 24             	mov    %edi,(%esp)
80105dfe:	e8 8d ba ff ff       	call   80101890 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105e03:	83 c4 10             	add    $0x10,%esp
80105e06:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105e0b:	0f 85 9f 00 00 00    	jne    80105eb0 <create+0x110>
80105e11:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105e16:	0f 85 94 00 00 00    	jne    80105eb0 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105e1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e1f:	89 f8                	mov    %edi,%eax
80105e21:	5b                   	pop    %ebx
80105e22:	5e                   	pop    %esi
80105e23:	5f                   	pop    %edi
80105e24:	5d                   	pop    %ebp
80105e25:	c3                   	ret    
80105e26:	8d 76 00             	lea    0x0(%esi),%esi
80105e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
80105e30:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105e34:	83 ec 08             	sub    $0x8,%esp
80105e37:	50                   	push   %eax
80105e38:	ff 33                	pushl  (%ebx)
80105e3a:	e8 e1 b8 ff ff       	call   80101720 <ialloc>
80105e3f:	83 c4 10             	add    $0x10,%esp
80105e42:	85 c0                	test   %eax,%eax
80105e44:	89 c7                	mov    %eax,%edi
80105e46:	0f 84 e8 00 00 00    	je     80105f34 <create+0x194>
  ilock(ip);
80105e4c:	83 ec 0c             	sub    $0xc,%esp
80105e4f:	50                   	push   %eax
80105e50:	e8 3b ba ff ff       	call   80101890 <ilock>
  ip->major = major;
80105e55:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105e59:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80105e5d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105e61:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105e65:	b8 01 00 00 00       	mov    $0x1,%eax
80105e6a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80105e6e:	89 3c 24             	mov    %edi,(%esp)
80105e71:	e8 6a b9 ff ff       	call   801017e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105e76:	83 c4 10             	add    $0x10,%esp
80105e79:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105e7e:	74 50                	je     80105ed0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105e80:	83 ec 04             	sub    $0x4,%esp
80105e83:	ff 77 04             	pushl  0x4(%edi)
80105e86:	56                   	push   %esi
80105e87:	53                   	push   %ebx
80105e88:	e8 a3 c1 ff ff       	call   80102030 <dirlink>
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	85 c0                	test   %eax,%eax
80105e92:	0f 88 8f 00 00 00    	js     80105f27 <create+0x187>
  iunlockput(dp);
80105e98:	83 ec 0c             	sub    $0xc,%esp
80105e9b:	53                   	push   %ebx
80105e9c:	e8 7f bc ff ff       	call   80101b20 <iunlockput>
  return ip;
80105ea1:	83 c4 10             	add    $0x10,%esp
}
80105ea4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ea7:	89 f8                	mov    %edi,%eax
80105ea9:	5b                   	pop    %ebx
80105eaa:	5e                   	pop    %esi
80105eab:	5f                   	pop    %edi
80105eac:	5d                   	pop    %ebp
80105ead:	c3                   	ret    
80105eae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105eb0:	83 ec 0c             	sub    $0xc,%esp
80105eb3:	57                   	push   %edi
    return 0;
80105eb4:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105eb6:	e8 65 bc ff ff       	call   80101b20 <iunlockput>
    return 0;
80105ebb:	83 c4 10             	add    $0x10,%esp
}
80105ebe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ec1:	89 f8                	mov    %edi,%eax
80105ec3:	5b                   	pop    %ebx
80105ec4:	5e                   	pop    %esi
80105ec5:	5f                   	pop    %edi
80105ec6:	5d                   	pop    %ebp
80105ec7:	c3                   	ret    
80105ec8:	90                   	nop
80105ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105ed0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105ed5:	83 ec 0c             	sub    $0xc,%esp
80105ed8:	53                   	push   %ebx
80105ed9:	e8 02 b9 ff ff       	call   801017e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105ede:	83 c4 0c             	add    $0xc,%esp
80105ee1:	ff 77 04             	pushl  0x4(%edi)
80105ee4:	68 7d 8b 10 80       	push   $0x80108b7d
80105ee9:	57                   	push   %edi
80105eea:	e8 41 c1 ff ff       	call   80102030 <dirlink>
80105eef:	83 c4 10             	add    $0x10,%esp
80105ef2:	85 c0                	test   %eax,%eax
80105ef4:	78 1c                	js     80105f12 <create+0x172>
80105ef6:	83 ec 04             	sub    $0x4,%esp
80105ef9:	ff 73 04             	pushl  0x4(%ebx)
80105efc:	68 7c 8b 10 80       	push   $0x80108b7c
80105f01:	57                   	push   %edi
80105f02:	e8 29 c1 ff ff       	call   80102030 <dirlink>
80105f07:	83 c4 10             	add    $0x10,%esp
80105f0a:	85 c0                	test   %eax,%eax
80105f0c:	0f 89 6e ff ff ff    	jns    80105e80 <create+0xe0>
      panic("create dots");
80105f12:	83 ec 0c             	sub    $0xc,%esp
80105f15:	68 81 92 10 80       	push   $0x80109281
80105f1a:	e8 71 a4 ff ff       	call   80100390 <panic>
80105f1f:	90                   	nop
    return 0;
80105f20:	31 ff                	xor    %edi,%edi
80105f22:	e9 f5 fe ff ff       	jmp    80105e1c <create+0x7c>
    panic("create: dirlink");
80105f27:	83 ec 0c             	sub    $0xc,%esp
80105f2a:	68 8d 92 10 80       	push   $0x8010928d
80105f2f:	e8 5c a4 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105f34:	83 ec 0c             	sub    $0xc,%esp
80105f37:	68 72 92 10 80       	push   $0x80109272
80105f3c:	e8 4f a4 ff ff       	call   80100390 <panic>
80105f41:	eb 0d                	jmp    80105f50 <sys_open>
80105f43:	90                   	nop
80105f44:	90                   	nop
80105f45:	90                   	nop
80105f46:	90                   	nop
80105f47:	90                   	nop
80105f48:	90                   	nop
80105f49:	90                   	nop
80105f4a:	90                   	nop
80105f4b:	90                   	nop
80105f4c:	90                   	nop
80105f4d:	90                   	nop
80105f4e:	90                   	nop
80105f4f:	90                   	nop

80105f50 <sys_open>:

int
sys_open(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	57                   	push   %edi
80105f54:	56                   	push   %esi
80105f55:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f56:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105f59:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105f5c:	50                   	push   %eax
80105f5d:	6a 00                	push   $0x0
80105f5f:	e8 fc f7 ff ff       	call   80105760 <argstr>
80105f64:	83 c4 10             	add    $0x10,%esp
80105f67:	85 c0                	test   %eax,%eax
80105f69:	0f 88 1d 01 00 00    	js     8010608c <sys_open+0x13c>
80105f6f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f72:	83 ec 08             	sub    $0x8,%esp
80105f75:	50                   	push   %eax
80105f76:	6a 01                	push   $0x1
80105f78:	e8 33 f7 ff ff       	call   801056b0 <argint>
80105f7d:	83 c4 10             	add    $0x10,%esp
80105f80:	85 c0                	test   %eax,%eax
80105f82:	0f 88 04 01 00 00    	js     8010608c <sys_open+0x13c>
    return -1;

  begin_op();
80105f88:	e8 a3 d4 ff ff       	call   80103430 <begin_op>

  if(omode & O_CREATE){
80105f8d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105f91:	0f 85 a9 00 00 00    	jne    80106040 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105f97:	83 ec 0c             	sub    $0xc,%esp
80105f9a:	ff 75 e0             	pushl  -0x20(%ebp)
80105f9d:	e8 4e c1 ff ff       	call   801020f0 <namei>
80105fa2:	83 c4 10             	add    $0x10,%esp
80105fa5:	85 c0                	test   %eax,%eax
80105fa7:	89 c6                	mov    %eax,%esi
80105fa9:	0f 84 ac 00 00 00    	je     8010605b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
80105faf:	83 ec 0c             	sub    $0xc,%esp
80105fb2:	50                   	push   %eax
80105fb3:	e8 d8 b8 ff ff       	call   80101890 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fb8:	83 c4 10             	add    $0x10,%esp
80105fbb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105fc0:	0f 84 aa 00 00 00    	je     80106070 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105fc6:	e8 c5 af ff ff       	call   80100f90 <filealloc>
80105fcb:	85 c0                	test   %eax,%eax
80105fcd:	89 c7                	mov    %eax,%edi
80105fcf:	0f 84 a6 00 00 00    	je     8010607b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105fd5:	e8 46 e1 ff ff       	call   80104120 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105fda:	31 db                	xor    %ebx,%ebx
80105fdc:	eb 0e                	jmp    80105fec <sys_open+0x9c>
80105fde:	66 90                	xchg   %ax,%ax
80105fe0:	83 c3 01             	add    $0x1,%ebx
80105fe3:	83 fb 10             	cmp    $0x10,%ebx
80105fe6:	0f 84 ac 00 00 00    	je     80106098 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105fec:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105ff0:	85 d2                	test   %edx,%edx
80105ff2:	75 ec                	jne    80105fe0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ff4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105ff7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105ffb:	56                   	push   %esi
80105ffc:	e8 6f b9 ff ff       	call   80101970 <iunlock>
  end_op();
80106001:	e8 9a d4 ff ff       	call   801034a0 <end_op>

  f->type = FD_INODE;
80106006:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010600c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010600f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80106012:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80106015:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010601c:	89 d0                	mov    %edx,%eax
8010601e:	f7 d0                	not    %eax
80106020:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106023:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106026:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106029:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010602d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106030:	89 d8                	mov    %ebx,%eax
80106032:	5b                   	pop    %ebx
80106033:	5e                   	pop    %esi
80106034:	5f                   	pop    %edi
80106035:	5d                   	pop    %ebp
80106036:	c3                   	ret    
80106037:	89 f6                	mov    %esi,%esi
80106039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80106040:	6a 00                	push   $0x0
80106042:	6a 00                	push   $0x0
80106044:	6a 02                	push   $0x2
80106046:	ff 75 e0             	pushl  -0x20(%ebp)
80106049:	e8 52 fd ff ff       	call   80105da0 <create>
    if(ip == 0){
8010604e:	83 c4 10             	add    $0x10,%esp
80106051:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80106053:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106055:	0f 85 6b ff ff ff    	jne    80105fc6 <sys_open+0x76>
      end_op();
8010605b:	e8 40 d4 ff ff       	call   801034a0 <end_op>
      return -1;
80106060:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106065:	eb c6                	jmp    8010602d <sys_open+0xdd>
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106070:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106073:	85 c9                	test   %ecx,%ecx
80106075:	0f 84 4b ff ff ff    	je     80105fc6 <sys_open+0x76>
    iunlockput(ip);
8010607b:	83 ec 0c             	sub    $0xc,%esp
8010607e:	56                   	push   %esi
8010607f:	e8 9c ba ff ff       	call   80101b20 <iunlockput>
    end_op();
80106084:	e8 17 d4 ff ff       	call   801034a0 <end_op>
    return -1;
80106089:	83 c4 10             	add    $0x10,%esp
8010608c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106091:	eb 9a                	jmp    8010602d <sys_open+0xdd>
80106093:	90                   	nop
80106094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80106098:	83 ec 0c             	sub    $0xc,%esp
8010609b:	57                   	push   %edi
8010609c:	e8 af af ff ff       	call   80101050 <fileclose>
801060a1:	83 c4 10             	add    $0x10,%esp
801060a4:	eb d5                	jmp    8010607b <sys_open+0x12b>
801060a6:	8d 76 00             	lea    0x0(%esi),%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801060b6:	e8 75 d3 ff ff       	call   80103430 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801060bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060be:	83 ec 08             	sub    $0x8,%esp
801060c1:	50                   	push   %eax
801060c2:	6a 00                	push   $0x0
801060c4:	e8 97 f6 ff ff       	call   80105760 <argstr>
801060c9:	83 c4 10             	add    $0x10,%esp
801060cc:	85 c0                	test   %eax,%eax
801060ce:	78 30                	js     80106100 <sys_mkdir+0x50>
801060d0:	6a 00                	push   $0x0
801060d2:	6a 00                	push   $0x0
801060d4:	6a 01                	push   $0x1
801060d6:	ff 75 f4             	pushl  -0xc(%ebp)
801060d9:	e8 c2 fc ff ff       	call   80105da0 <create>
801060de:	83 c4 10             	add    $0x10,%esp
801060e1:	85 c0                	test   %eax,%eax
801060e3:	74 1b                	je     80106100 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801060e5:	83 ec 0c             	sub    $0xc,%esp
801060e8:	50                   	push   %eax
801060e9:	e8 32 ba ff ff       	call   80101b20 <iunlockput>
  end_op();
801060ee:	e8 ad d3 ff ff       	call   801034a0 <end_op>
  return 0;
801060f3:	83 c4 10             	add    $0x10,%esp
801060f6:	31 c0                	xor    %eax,%eax
}
801060f8:	c9                   	leave  
801060f9:	c3                   	ret    
801060fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80106100:	e8 9b d3 ff ff       	call   801034a0 <end_op>
    return -1;
80106105:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010610a:	c9                   	leave  
8010610b:	c3                   	ret    
8010610c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106110 <sys_mknod>:

int
sys_mknod(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106116:	e8 15 d3 ff ff       	call   80103430 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010611b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010611e:	83 ec 08             	sub    $0x8,%esp
80106121:	50                   	push   %eax
80106122:	6a 00                	push   $0x0
80106124:	e8 37 f6 ff ff       	call   80105760 <argstr>
80106129:	83 c4 10             	add    $0x10,%esp
8010612c:	85 c0                	test   %eax,%eax
8010612e:	78 60                	js     80106190 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106130:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106133:	83 ec 08             	sub    $0x8,%esp
80106136:	50                   	push   %eax
80106137:	6a 01                	push   $0x1
80106139:	e8 72 f5 ff ff       	call   801056b0 <argint>
  if((argstr(0, &path)) < 0 ||
8010613e:	83 c4 10             	add    $0x10,%esp
80106141:	85 c0                	test   %eax,%eax
80106143:	78 4b                	js     80106190 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106145:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106148:	83 ec 08             	sub    $0x8,%esp
8010614b:	50                   	push   %eax
8010614c:	6a 02                	push   $0x2
8010614e:	e8 5d f5 ff ff       	call   801056b0 <argint>
     argint(1, &major) < 0 ||
80106153:	83 c4 10             	add    $0x10,%esp
80106156:	85 c0                	test   %eax,%eax
80106158:	78 36                	js     80106190 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010615a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010615e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
8010615f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80106163:	50                   	push   %eax
80106164:	6a 03                	push   $0x3
80106166:	ff 75 ec             	pushl  -0x14(%ebp)
80106169:	e8 32 fc ff ff       	call   80105da0 <create>
8010616e:	83 c4 10             	add    $0x10,%esp
80106171:	85 c0                	test   %eax,%eax
80106173:	74 1b                	je     80106190 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80106175:	83 ec 0c             	sub    $0xc,%esp
80106178:	50                   	push   %eax
80106179:	e8 a2 b9 ff ff       	call   80101b20 <iunlockput>
  end_op();
8010617e:	e8 1d d3 ff ff       	call   801034a0 <end_op>
  return 0;
80106183:	83 c4 10             	add    $0x10,%esp
80106186:	31 c0                	xor    %eax,%eax
}
80106188:	c9                   	leave  
80106189:	c3                   	ret    
8010618a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80106190:	e8 0b d3 ff ff       	call   801034a0 <end_op>
    return -1;
80106195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010619a:	c9                   	leave  
8010619b:	c3                   	ret    
8010619c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061a0 <sys_chdir>:

int
sys_chdir(void)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	56                   	push   %esi
801061a4:	53                   	push   %ebx
801061a5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801061a8:	e8 73 df ff ff       	call   80104120 <myproc>
801061ad:	89 c6                	mov    %eax,%esi
  
  begin_op();
801061af:	e8 7c d2 ff ff       	call   80103430 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801061b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061b7:	83 ec 08             	sub    $0x8,%esp
801061ba:	50                   	push   %eax
801061bb:	6a 00                	push   $0x0
801061bd:	e8 9e f5 ff ff       	call   80105760 <argstr>
801061c2:	83 c4 10             	add    $0x10,%esp
801061c5:	85 c0                	test   %eax,%eax
801061c7:	78 77                	js     80106240 <sys_chdir+0xa0>
801061c9:	83 ec 0c             	sub    $0xc,%esp
801061cc:	ff 75 f4             	pushl  -0xc(%ebp)
801061cf:	e8 1c bf ff ff       	call   801020f0 <namei>
801061d4:	83 c4 10             	add    $0x10,%esp
801061d7:	85 c0                	test   %eax,%eax
801061d9:	89 c3                	mov    %eax,%ebx
801061db:	74 63                	je     80106240 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801061dd:	83 ec 0c             	sub    $0xc,%esp
801061e0:	50                   	push   %eax
801061e1:	e8 aa b6 ff ff       	call   80101890 <ilock>
  if(ip->type != T_DIR){
801061e6:	83 c4 10             	add    $0x10,%esp
801061e9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801061ee:	75 30                	jne    80106220 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801061f0:	83 ec 0c             	sub    $0xc,%esp
801061f3:	53                   	push   %ebx
801061f4:	e8 77 b7 ff ff       	call   80101970 <iunlock>
  iput(curproc->cwd);
801061f9:	58                   	pop    %eax
801061fa:	ff 76 68             	pushl  0x68(%esi)
801061fd:	e8 be b7 ff ff       	call   801019c0 <iput>
  end_op();
80106202:	e8 99 d2 ff ff       	call   801034a0 <end_op>
  curproc->cwd = ip;
80106207:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010620a:	83 c4 10             	add    $0x10,%esp
8010620d:	31 c0                	xor    %eax,%eax
}
8010620f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106212:	5b                   	pop    %ebx
80106213:	5e                   	pop    %esi
80106214:	5d                   	pop    %ebp
80106215:	c3                   	ret    
80106216:	8d 76 00             	lea    0x0(%esi),%esi
80106219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80106220:	83 ec 0c             	sub    $0xc,%esp
80106223:	53                   	push   %ebx
80106224:	e8 f7 b8 ff ff       	call   80101b20 <iunlockput>
    end_op();
80106229:	e8 72 d2 ff ff       	call   801034a0 <end_op>
    return -1;
8010622e:	83 c4 10             	add    $0x10,%esp
80106231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106236:	eb d7                	jmp    8010620f <sys_chdir+0x6f>
80106238:	90                   	nop
80106239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106240:	e8 5b d2 ff ff       	call   801034a0 <end_op>
    return -1;
80106245:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010624a:	eb c3                	jmp    8010620f <sys_chdir+0x6f>
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106250 <sys_exec>:

int
sys_exec(void)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
80106253:	57                   	push   %edi
80106254:	56                   	push   %esi
80106255:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106256:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010625c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106262:	50                   	push   %eax
80106263:	6a 00                	push   $0x0
80106265:	e8 f6 f4 ff ff       	call   80105760 <argstr>
8010626a:	83 c4 10             	add    $0x10,%esp
8010626d:	85 c0                	test   %eax,%eax
8010626f:	0f 88 87 00 00 00    	js     801062fc <sys_exec+0xac>
80106275:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010627b:	83 ec 08             	sub    $0x8,%esp
8010627e:	50                   	push   %eax
8010627f:	6a 01                	push   $0x1
80106281:	e8 2a f4 ff ff       	call   801056b0 <argint>
80106286:	83 c4 10             	add    $0x10,%esp
80106289:	85 c0                	test   %eax,%eax
8010628b:	78 6f                	js     801062fc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010628d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106293:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106296:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106298:	68 80 00 00 00       	push   $0x80
8010629d:	6a 00                	push   $0x0
8010629f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801062a5:	50                   	push   %eax
801062a6:	e8 05 f1 ff ff       	call   801053b0 <memset>
801062ab:	83 c4 10             	add    $0x10,%esp
801062ae:	eb 2c                	jmp    801062dc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801062b0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801062b6:	85 c0                	test   %eax,%eax
801062b8:	74 56                	je     80106310 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801062ba:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801062c0:	83 ec 08             	sub    $0x8,%esp
801062c3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801062c6:	52                   	push   %edx
801062c7:	50                   	push   %eax
801062c8:	e8 73 f3 ff ff       	call   80105640 <fetchstr>
801062cd:	83 c4 10             	add    $0x10,%esp
801062d0:	85 c0                	test   %eax,%eax
801062d2:	78 28                	js     801062fc <sys_exec+0xac>
  for(i=0;; i++){
801062d4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801062d7:	83 fb 20             	cmp    $0x20,%ebx
801062da:	74 20                	je     801062fc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801062dc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801062e2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801062e9:	83 ec 08             	sub    $0x8,%esp
801062ec:	57                   	push   %edi
801062ed:	01 f0                	add    %esi,%eax
801062ef:	50                   	push   %eax
801062f0:	e8 0b f3 ff ff       	call   80105600 <fetchint>
801062f5:	83 c4 10             	add    $0x10,%esp
801062f8:	85 c0                	test   %eax,%eax
801062fa:	79 b4                	jns    801062b0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801062fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801062ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106304:	5b                   	pop    %ebx
80106305:	5e                   	pop    %esi
80106306:	5f                   	pop    %edi
80106307:	5d                   	pop    %ebp
80106308:	c3                   	ret    
80106309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80106310:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106316:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80106319:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106320:	00 00 00 00 
  return exec(path, argv);
80106324:	50                   	push   %eax
80106325:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010632b:	e8 e0 a6 ff ff       	call   80100a10 <exec>
80106330:	83 c4 10             	add    $0x10,%esp
}
80106333:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106336:	5b                   	pop    %ebx
80106337:	5e                   	pop    %esi
80106338:	5f                   	pop    %edi
80106339:	5d                   	pop    %ebp
8010633a:	c3                   	ret    
8010633b:	90                   	nop
8010633c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106340 <sys_pipe>:

int
sys_pipe(void)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	57                   	push   %edi
80106344:	56                   	push   %esi
80106345:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106346:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106349:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010634c:	6a 08                	push   $0x8
8010634e:	50                   	push   %eax
8010634f:	6a 00                	push   $0x0
80106351:	e8 aa f3 ff ff       	call   80105700 <argptr>
80106356:	83 c4 10             	add    $0x10,%esp
80106359:	85 c0                	test   %eax,%eax
8010635b:	0f 88 ae 00 00 00    	js     8010640f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106361:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106364:	83 ec 08             	sub    $0x8,%esp
80106367:	50                   	push   %eax
80106368:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010636b:	50                   	push   %eax
8010636c:	e8 5f d7 ff ff       	call   80103ad0 <pipealloc>
80106371:	83 c4 10             	add    $0x10,%esp
80106374:	85 c0                	test   %eax,%eax
80106376:	0f 88 93 00 00 00    	js     8010640f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010637c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010637f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106381:	e8 9a dd ff ff       	call   80104120 <myproc>
80106386:	eb 10                	jmp    80106398 <sys_pipe+0x58>
80106388:	90                   	nop
80106389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106390:	83 c3 01             	add    $0x1,%ebx
80106393:	83 fb 10             	cmp    $0x10,%ebx
80106396:	74 60                	je     801063f8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80106398:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010639c:	85 f6                	test   %esi,%esi
8010639e:	75 f0                	jne    80106390 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801063a0:	8d 73 08             	lea    0x8(%ebx),%esi
801063a3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801063aa:	e8 71 dd ff ff       	call   80104120 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801063af:	31 d2                	xor    %edx,%edx
801063b1:	eb 0d                	jmp    801063c0 <sys_pipe+0x80>
801063b3:	90                   	nop
801063b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063b8:	83 c2 01             	add    $0x1,%edx
801063bb:	83 fa 10             	cmp    $0x10,%edx
801063be:	74 28                	je     801063e8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
801063c0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801063c4:	85 c9                	test   %ecx,%ecx
801063c6:	75 f0                	jne    801063b8 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
801063c8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801063cc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801063cf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801063d1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801063d4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801063d7:	31 c0                	xor    %eax,%eax
}
801063d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063dc:	5b                   	pop    %ebx
801063dd:	5e                   	pop    %esi
801063de:	5f                   	pop    %edi
801063df:	5d                   	pop    %ebp
801063e0:	c3                   	ret    
801063e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801063e8:	e8 33 dd ff ff       	call   80104120 <myproc>
801063ed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801063f4:	00 
801063f5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801063f8:	83 ec 0c             	sub    $0xc,%esp
801063fb:	ff 75 e0             	pushl  -0x20(%ebp)
801063fe:	e8 4d ac ff ff       	call   80101050 <fileclose>
    fileclose(wf);
80106403:	58                   	pop    %eax
80106404:	ff 75 e4             	pushl  -0x1c(%ebp)
80106407:	e8 44 ac ff ff       	call   80101050 <fileclose>
    return -1;
8010640c:	83 c4 10             	add    $0x10,%esp
8010640f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106414:	eb c3                	jmp    801063d9 <sys_pipe+0x99>
80106416:	66 90                	xchg   %ax,%ax
80106418:	66 90                	xchg   %ax,%ax
8010641a:	66 90                	xchg   %ax,%ax
8010641c:	66 90                	xchg   %ax,%ax
8010641e:	66 90                	xchg   %ax,%ax

80106420 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106423:	5d                   	pop    %ebp
  return fork();
80106424:	e9 b7 de ff ff       	jmp    801042e0 <fork>
80106429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106430 <sys_exit>:

int
sys_exit(void)
{
80106430:	55                   	push   %ebp
80106431:	89 e5                	mov    %esp,%ebp
80106433:	83 ec 08             	sub    $0x8,%esp
  exit();
80106436:	e8 95 ea ff ff       	call   80104ed0 <exit>
  return 0;  // not reached
}
8010643b:	31 c0                	xor    %eax,%eax
8010643d:	c9                   	leave  
8010643e:	c3                   	ret    
8010643f:	90                   	nop

80106440 <sys_wait>:

int
sys_wait(void)
{
80106440:	55                   	push   %ebp
80106441:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106443:	5d                   	pop    %ebp
  return wait();
80106444:	e9 e7 e3 ff ff       	jmp    80104830 <wait>
80106449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106450 <sys_kill>:

int
sys_kill(void)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106456:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106459:	50                   	push   %eax
8010645a:	6a 00                	push   $0x0
8010645c:	e8 4f f2 ff ff       	call   801056b0 <argint>
80106461:	83 c4 10             	add    $0x10,%esp
80106464:	85 c0                	test   %eax,%eax
80106466:	78 18                	js     80106480 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106468:	83 ec 0c             	sub    $0xc,%esp
8010646b:	ff 75 f4             	pushl  -0xc(%ebp)
8010646e:	e8 7d e5 ff ff       	call   801049f0 <kill>
80106473:	83 c4 10             	add    $0x10,%esp
}
80106476:	c9                   	leave  
80106477:	c3                   	ret    
80106478:	90                   	nop
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106485:	c9                   	leave  
80106486:	c3                   	ret    
80106487:	89 f6                	mov    %esi,%esi
80106489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106490 <sys_getpid>:

int
sys_getpid(void)
{
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
80106493:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106496:	e8 85 dc ff ff       	call   80104120 <myproc>
8010649b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010649e:	c9                   	leave  
8010649f:	c3                   	ret    

801064a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
801064a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801064a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801064aa:	50                   	push   %eax
801064ab:	6a 00                	push   $0x0
801064ad:	e8 fe f1 ff ff       	call   801056b0 <argint>
801064b2:	83 c4 10             	add    $0x10,%esp
801064b5:	85 c0                	test   %eax,%eax
801064b7:	78 27                	js     801064e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801064b9:	e8 62 dc ff ff       	call   80104120 <myproc>
  if(growproc(n) < 0)
801064be:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801064c1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801064c3:	ff 75 f4             	pushl  -0xc(%ebp)
801064c6:	e8 95 dd ff ff       	call   80104260 <growproc>
801064cb:	83 c4 10             	add    $0x10,%esp
801064ce:	85 c0                	test   %eax,%eax
801064d0:	78 0e                	js     801064e0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801064d2:	89 d8                	mov    %ebx,%eax
801064d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064d7:	c9                   	leave  
801064d8:	c3                   	ret    
801064d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801064e0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801064e5:	eb eb                	jmp    801064d2 <sys_sbrk+0x32>
801064e7:	89 f6                	mov    %esi,%esi
801064e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064f0 <sys_sleep>:

int
sys_sleep(void)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801064f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801064f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801064fa:	50                   	push   %eax
801064fb:	6a 00                	push   $0x0
801064fd:	e8 ae f1 ff ff       	call   801056b0 <argint>
80106502:	83 c4 10             	add    $0x10,%esp
80106505:	85 c0                	test   %eax,%eax
80106507:	0f 88 8a 00 00 00    	js     80106597 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010650d:	83 ec 0c             	sub    $0xc,%esp
80106510:	68 80 93 15 80       	push   $0x80159380
80106515:	e8 86 ed ff ff       	call   801052a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010651a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010651d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80106520:	8b 1d c0 9b 15 80    	mov    0x80159bc0,%ebx
  while(ticks - ticks0 < n){
80106526:	85 d2                	test   %edx,%edx
80106528:	75 27                	jne    80106551 <sys_sleep+0x61>
8010652a:	eb 54                	jmp    80106580 <sys_sleep+0x90>
8010652c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106530:	83 ec 08             	sub    $0x8,%esp
80106533:	68 80 93 15 80       	push   $0x80159380
80106538:	68 c0 9b 15 80       	push   $0x80159bc0
8010653d:	e8 2e e2 ff ff       	call   80104770 <sleep>
  while(ticks - ticks0 < n){
80106542:	a1 c0 9b 15 80       	mov    0x80159bc0,%eax
80106547:	83 c4 10             	add    $0x10,%esp
8010654a:	29 d8                	sub    %ebx,%eax
8010654c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010654f:	73 2f                	jae    80106580 <sys_sleep+0x90>
    if(myproc()->killed){
80106551:	e8 ca db ff ff       	call   80104120 <myproc>
80106556:	8b 40 24             	mov    0x24(%eax),%eax
80106559:	85 c0                	test   %eax,%eax
8010655b:	74 d3                	je     80106530 <sys_sleep+0x40>
      release(&tickslock);
8010655d:	83 ec 0c             	sub    $0xc,%esp
80106560:	68 80 93 15 80       	push   $0x80159380
80106565:	e8 f6 ed ff ff       	call   80105360 <release>
      return -1;
8010656a:	83 c4 10             	add    $0x10,%esp
8010656d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106572:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106575:	c9                   	leave  
80106576:	c3                   	ret    
80106577:	89 f6                	mov    %esi,%esi
80106579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106580:	83 ec 0c             	sub    $0xc,%esp
80106583:	68 80 93 15 80       	push   $0x80159380
80106588:	e8 d3 ed ff ff       	call   80105360 <release>
  return 0;
8010658d:	83 c4 10             	add    $0x10,%esp
80106590:	31 c0                	xor    %eax,%eax
}
80106592:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106595:	c9                   	leave  
80106596:	c3                   	ret    
    return -1;
80106597:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010659c:	eb f4                	jmp    80106592 <sys_sleep+0xa2>
8010659e:	66 90                	xchg   %ax,%ax

801065a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	53                   	push   %ebx
801065a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801065a7:	68 80 93 15 80       	push   $0x80159380
801065ac:	e8 ef ec ff ff       	call   801052a0 <acquire>
  xticks = ticks;
801065b1:	8b 1d c0 9b 15 80    	mov    0x80159bc0,%ebx
  release(&tickslock);
801065b7:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
801065be:	e8 9d ed ff ff       	call   80105360 <release>
  return xticks;
}
801065c3:	89 d8                	mov    %ebx,%eax
801065c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065c8:	c9                   	leave  
801065c9:	c3                   	ret    
801065ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801065d0 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
801065d0:	55                   	push   %ebp
801065d1:	89 e5                	mov    %esp,%ebp
  return numFreePages();
}
801065d3:	5d                   	pop    %ebp
  return numFreePages();
801065d4:	e9 27 c6 ff ff       	jmp    80102c00 <numFreePages>
801065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065e0 <sys_printProcDump>:

int
sys_printProcDump(void){
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	53                   	push   %ebx
  int pid;
  if(argint(0, &pid) < 0)
801065e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_printProcDump(void){
801065e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &pid) < 0)
801065ea:	50                   	push   %eax
801065eb:	6a 00                	push   $0x0
801065ed:	e8 be f0 ff ff       	call   801056b0 <argint>
801065f2:	83 c4 10             	add    $0x10,%esp
801065f5:	85 c0                	test   %eax,%eax
801065f7:	78 2f                	js     80106628 <sys_printProcDump+0x48>
    return -1;
  if(pid == 0){
801065f9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801065fc:	85 db                	test   %ebx,%ebx
801065fe:	74 18                	je     80106618 <sys_printProcDump+0x38>
    procdump();
  }else{
    singleProcDump(pid);
80106600:	83 ec 0c             	sub    $0xc,%esp
80106603:	53                   	push   %ebx
  }
  return 0;
80106604:	31 db                	xor    %ebx,%ebx
    singleProcDump(pid);
80106606:	e8 a5 e7 ff ff       	call   80104db0 <singleProcDump>
8010660b:	83 c4 10             	add    $0x10,%esp
8010660e:	89 d8                	mov    %ebx,%eax
80106610:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106613:	c9                   	leave  
80106614:	c3                   	ret    
80106615:	8d 76 00             	lea    0x0(%esi),%esi
    procdump();
80106618:	e8 53 e4 ff ff       	call   80104a70 <procdump>
8010661d:	89 d8                	mov    %ebx,%eax
8010661f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106622:	c9                   	leave  
80106623:	c3                   	ret    
80106624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106628:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010662d:	eb df                	jmp    8010660e <sys_printProcDump+0x2e>

8010662f <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010662f:	1e                   	push   %ds
  pushl %es
80106630:	06                   	push   %es
  pushl %fs
80106631:	0f a0                	push   %fs
  pushl %gs
80106633:	0f a8                	push   %gs
  pushal
80106635:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106636:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010663a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010663c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010663e:	54                   	push   %esp
  call trap
8010663f:	e8 cc 00 00 00       	call   80106710 <trap>
  addl $4, %esp
80106644:	83 c4 04             	add    $0x4,%esp

80106647 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106647:	61                   	popa   
  popl %gs
80106648:	0f a9                	pop    %gs
  popl %fs
8010664a:	0f a1                	pop    %fs
  popl %es
8010664c:	07                   	pop    %es
  popl %ds
8010664d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010664e:	83 c4 08             	add    $0x8,%esp
  iret
80106651:	cf                   	iret   
80106652:	66 90                	xchg   %ax,%ax
80106654:	66 90                	xchg   %ax,%ax
80106656:	66 90                	xchg   %ax,%ax
80106658:	66 90                	xchg   %ax,%ax
8010665a:	66 90                	xchg   %ax,%ax
8010665c:	66 90                	xchg   %ax,%ax
8010665e:	66 90                	xchg   %ax,%ax

80106660 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106660:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106661:	31 c0                	xor    %eax,%eax
{
80106663:	89 e5                	mov    %esp,%ebp
80106665:	83 ec 08             	sub    $0x8,%esp
80106668:	90                   	nop
80106669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106670:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106677:	c7 04 c5 c2 93 15 80 	movl   $0x8e000008,-0x7fea6c3e(,%eax,8)
8010667e:	08 00 00 8e 
80106682:	66 89 14 c5 c0 93 15 	mov    %dx,-0x7fea6c40(,%eax,8)
80106689:	80 
8010668a:	c1 ea 10             	shr    $0x10,%edx
8010668d:	66 89 14 c5 c6 93 15 	mov    %dx,-0x7fea6c3a(,%eax,8)
80106694:	80 
  for(i = 0; i < 256; i++)
80106695:	83 c0 01             	add    $0x1,%eax
80106698:	3d 00 01 00 00       	cmp    $0x100,%eax
8010669d:	75 d1                	jne    80106670 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010669f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
801066a4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066a7:	c7 05 c2 95 15 80 08 	movl   $0xef000008,0x801595c2
801066ae:	00 00 ef 
  initlock(&tickslock, "time");
801066b1:	68 9d 92 10 80       	push   $0x8010929d
801066b6:	68 80 93 15 80       	push   $0x80159380
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066bb:	66 a3 c0 95 15 80    	mov    %ax,0x801595c0
801066c1:	c1 e8 10             	shr    $0x10,%eax
801066c4:	66 a3 c6 95 15 80    	mov    %ax,0x801595c6
  initlock(&tickslock, "time");
801066ca:	e8 91 ea ff ff       	call   80105160 <initlock>
}
801066cf:	83 c4 10             	add    $0x10,%esp
801066d2:	c9                   	leave  
801066d3:	c3                   	ret    
801066d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801066da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801066e0 <idtinit>:

void
idtinit(void)
{
801066e0:	55                   	push   %ebp
  pd[0] = size-1;
801066e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801066e6:	89 e5                	mov    %esp,%ebp
801066e8:	83 ec 10             	sub    $0x10,%esp
801066eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801066ef:	b8 c0 93 15 80       	mov    $0x801593c0,%eax
801066f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801066f8:	c1 e8 10             	shr    $0x10,%eax
801066fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801066ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106702:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106705:	c9                   	leave  
80106706:	c3                   	ret    
80106707:	89 f6                	mov    %esi,%esi
80106709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106710 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106710:	55                   	push   %ebp
80106711:	89 e5                	mov    %esp,%ebp
80106713:	57                   	push   %edi
80106714:	56                   	push   %esi
80106715:	53                   	push   %ebx
80106716:	83 ec 1c             	sub    $0x1c,%esp
80106719:	8b 7d 08             	mov    0x8(%ebp),%edi
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
8010671c:	8b 47 30             	mov    0x30(%edi),%eax
8010671f:	83 f8 40             	cmp    $0x40,%eax
80106722:	0f 84 b8 01 00 00    	je     801068e0 <trap+0x1d0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106728:	83 e8 0e             	sub    $0xe,%eax
8010672b:	83 f8 31             	cmp    $0x31,%eax
8010672e:	0f 87 d4 00 00 00    	ja     80106808 <trap+0xf8>
80106734:	ff 24 85 78 93 10 80 	jmp    *-0x7fef6c88(,%eax,4)
8010673b:	90                   	nop
8010673c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106740:	0f 20 d3             	mov    %cr2,%ebx
        lapiceoi();
        break;
      }*/

      addr = rcr2();
      pte_t *pte = nonStaticWalkpgdir(myproc()->pgdir,(char*)addr,0);
80106743:	e8 d8 d9 ff ff       	call   80104120 <myproc>
80106748:	83 ec 04             	sub    $0x4,%esp
8010674b:	6a 00                	push   $0x0
8010674d:	53                   	push   %ebx
8010674e:	ff 70 04             	pushl  0x4(%eax)
80106751:	e8 6a 10 00 00       	call   801077c0 <nonStaticWalkpgdir>
80106756:	89 c6                	mov    %eax,%esi
      uint pa = PTE_ADDR(*pte);
80106758:	8b 00                	mov    (%eax),%eax

      //int inSwapFile = (((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG);
      //cprintf("first %x %x\n",pa,addr);
      

      if((*pte & PTE_U ) == 0){
8010675a:	83 c4 10             	add    $0x10,%esp
8010675d:	a8 04                	test   $0x4,%al
8010675f:	0f 84 11 01 00 00    	je     80106876 <trap+0x166>
      uint pa = PTE_ADDR(*pte);
80106765:	89 c1                	mov    %eax,%ecx
80106767:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
      }

      //cprintf("trap!\n");

      //cprintf("PGFLT: ");
      if(*pte & PTE_PG){
8010676d:	f6 c4 02             	test   $0x2,%ah
      uint pa = PTE_ADDR(*pte);
80106770:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      if(*pte & PTE_PG){
80106773:	0f 85 8f 02 00 00    	jne    80106a08 <trap+0x2f8>
        //cprintf("swapping: %x\n",PGROUNDDOWN(addr));
        myproc()->nPGFLT++;
        swapPage(addr);
        lcr3(V2P(myproc()->pgdir));
      }
      else if((*pte & PTE_W) == 0) {
80106779:	a8 02                	test   $0x2,%al
8010677b:	75 6b                	jne    801067e8 <trap+0xd8>
8010677d:	89 d8                	mov    %ebx,%eax
        int k = 0;
        for(k = 0 ; k <  MAX_PSYC_PAGES; k++){
8010677f:	31 db                	xor    %ebx,%ebx
80106781:	89 75 e0             	mov    %esi,-0x20(%ebp)
80106784:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106789:	89 de                	mov    %ebx,%esi
8010678b:	89 c3                	mov    %eax,%ebx
8010678d:	eb 0d                	jmp    8010679c <trap+0x8c>
8010678f:	90                   	nop
80106790:	83 c6 01             	add    $0x1,%esi
80106793:	83 fe 10             	cmp    $0x10,%esi
80106796:	0f 84 99 02 00 00    	je     80106a35 <trap+0x325>
          
          if(myproc()->physicalPGs[k].va == (char*)PGROUNDDOWN(addr)){
8010679c:	e8 7f d9 ff ff       	call   80104120 <myproc>
801067a1:	8d 0c b6             	lea    (%esi,%esi,4),%ecx
801067a4:	c1 e1 02             	shl    $0x2,%ecx
801067a7:	39 9c 08 d8 01 00 00 	cmp    %ebx,0x1d8(%eax,%ecx,1)
801067ae:	75 e0                	jne    80106790 <trap+0x80>
801067b0:	8b 75 e0             	mov    -0x20(%ebp),%esi
801067b3:	89 4d e0             	mov    %ecx,-0x20(%ebp)
            myproc()->physicalPGs[k].alloceted = 1;
801067b6:	e8 65 d9 ff ff       	call   80104120 <myproc>
801067bb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801067be:	c7 84 08 e0 01 00 00 	movl   $0x1,0x1e0(%eax,%ecx,1)
801067c5:	01 00 00 00 
            myproc()->physicalPGs[k].age = 0;
801067c9:	e8 52 d9 ff ff       	call   80104120 <myproc>
801067ce:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801067d1:	c7 84 08 dc 01 00 00 	movl   $0x0,0x1dc(%eax,%ecx,1)
801067d8:	00 00 00 00 
              myproc()->physicalPGs[k].age = 0xffffffff;
            #endif
            break;
          }
        }
        if((*pte & PTE_COW) != 0){
801067dc:	f7 06 00 08 00 00    	testl  $0x800,(%esi)
801067e2:	0f 85 55 02 00 00    	jne    80106a3d <trap+0x32d>
            lcr3(V2P(myproc()->pgdir));
          }
      }
        
    }
    lcr3(V2P(myproc()->pgdir));
801067e8:	e8 33 d9 ff ff       	call   80104120 <myproc>
801067ed:	8b 40 04             	mov    0x4(%eax),%eax
801067f0:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801067f5:	0f 22 d8             	mov    %eax,%cr3
    if(pa < PHYSTOP){
801067f8:	81 7d e4 ff ff ff 0d 	cmpl   $0xdffffff,-0x1c(%ebp)
801067ff:	76 75                	jbe    80106876 <trap+0x166>
80106801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi



  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106808:	e8 13 d9 ff ff       	call   80104120 <myproc>
8010680d:	85 c0                	test   %eax,%eax
8010680f:	8b 5f 38             	mov    0x38(%edi),%ebx
80106812:	0f 84 e2 02 00 00    	je     80106afa <trap+0x3ea>
80106818:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
8010681c:	0f 84 d8 02 00 00    	je     80106afa <trap+0x3ea>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106822:	0f 20 d1             	mov    %cr2,%ecx
80106825:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106828:	e8 d3 d8 ff ff       	call   80104100 <cpuid>
8010682d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106830:	8b 47 34             	mov    0x34(%edi),%eax
80106833:	8b 77 30             	mov    0x30(%edi),%esi
80106836:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106839:	e8 e2 d8 ff ff       	call   80104120 <myproc>
8010683e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106841:	e8 da d8 ff ff       	call   80104120 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106846:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106849:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010684c:	51                   	push   %ecx
8010684d:	53                   	push   %ebx
8010684e:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
8010684f:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106852:	ff 75 e4             	pushl  -0x1c(%ebp)
80106855:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106856:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106859:	52                   	push   %edx
8010685a:	ff 70 10             	pushl  0x10(%eax)
8010685d:	68 34 93 10 80       	push   $0x80109334
80106862:	e8 f9 9d ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106867:	83 c4 20             	add    $0x20,%esp
8010686a:	e8 b1 d8 ff ff       	call   80104120 <myproc>
8010686f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106876:	e8 a5 d8 ff ff       	call   80104120 <myproc>
8010687b:	85 c0                	test   %eax,%eax
8010687d:	74 1d                	je     8010689c <trap+0x18c>
8010687f:	e8 9c d8 ff ff       	call   80104120 <myproc>
80106884:	8b 50 24             	mov    0x24(%eax),%edx
80106887:	85 d2                	test   %edx,%edx
80106889:	74 11                	je     8010689c <trap+0x18c>
8010688b:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010688f:	83 e0 03             	and    $0x3,%eax
80106892:	66 83 f8 03          	cmp    $0x3,%ax
80106896:	0f 84 24 01 00 00    	je     801069c0 <trap+0x2b0>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010689c:	e8 7f d8 ff ff       	call   80104120 <myproc>
801068a1:	85 c0                	test   %eax,%eax
801068a3:	74 0b                	je     801068b0 <trap+0x1a0>
801068a5:	e8 76 d8 ff ff       	call   80104120 <myproc>
801068aa:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801068ae:	74 68                	je     80106918 <trap+0x208>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068b0:	e8 6b d8 ff ff       	call   80104120 <myproc>
801068b5:	85 c0                	test   %eax,%eax
801068b7:	74 19                	je     801068d2 <trap+0x1c2>
801068b9:	e8 62 d8 ff ff       	call   80104120 <myproc>
801068be:	8b 40 24             	mov    0x24(%eax),%eax
801068c1:	85 c0                	test   %eax,%eax
801068c3:	74 0d                	je     801068d2 <trap+0x1c2>
801068c5:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801068c9:	83 e0 03             	and    $0x3,%eax
801068cc:	66 83 f8 03          	cmp    $0x3,%ax
801068d0:	74 37                	je     80106909 <trap+0x1f9>
    exit();
}
801068d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068d5:	5b                   	pop    %ebx
801068d6:	5e                   	pop    %esi
801068d7:	5f                   	pop    %edi
801068d8:	5d                   	pop    %ebp
801068d9:	c3                   	ret    
801068da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed)
801068e0:	e8 3b d8 ff ff       	call   80104120 <myproc>
801068e5:	8b 40 24             	mov    0x24(%eax),%eax
801068e8:	85 c0                	test   %eax,%eax
801068ea:	0f 85 c0 00 00 00    	jne    801069b0 <trap+0x2a0>
    myproc()->tf = tf;
801068f0:	e8 2b d8 ff ff       	call   80104120 <myproc>
801068f5:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801068f8:	e8 a3 ee ff ff       	call   801057a0 <syscall>
    if(myproc()->killed)
801068fd:	e8 1e d8 ff ff       	call   80104120 <myproc>
80106902:	8b 78 24             	mov    0x24(%eax),%edi
80106905:	85 ff                	test   %edi,%edi
80106907:	74 c9                	je     801068d2 <trap+0x1c2>
}
80106909:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010690c:	5b                   	pop    %ebx
8010690d:	5e                   	pop    %esi
8010690e:	5f                   	pop    %edi
8010690f:	5d                   	pop    %ebp
      exit();
80106910:	e9 bb e5 ff ff       	jmp    80104ed0 <exit>
80106915:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106918:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
8010691c:	75 92                	jne    801068b0 <trap+0x1a0>
    yield();
8010691e:	e8 fd dd ff ff       	call   80104720 <yield>
80106923:	eb 8b                	jmp    801068b0 <trap+0x1a0>
80106925:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106928:	e8 d3 d7 ff ff       	call   80104100 <cpuid>
8010692d:	85 c0                	test   %eax,%eax
8010692f:	0f 84 9b 00 00 00    	je     801069d0 <trap+0x2c0>
    lapiceoi();
80106935:	e8 a6 c6 ff ff       	call   80102fe0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010693a:	e8 e1 d7 ff ff       	call   80104120 <myproc>
8010693f:	85 c0                	test   %eax,%eax
80106941:	0f 85 38 ff ff ff    	jne    8010687f <trap+0x16f>
80106947:	e9 50 ff ff ff       	jmp    8010689c <trap+0x18c>
8010694c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106950:	e8 4b c5 ff ff       	call   80102ea0 <kbdintr>
    lapiceoi();
80106955:	e8 86 c6 ff ff       	call   80102fe0 <lapiceoi>
    break;
8010695a:	e9 17 ff ff ff       	jmp    80106876 <trap+0x166>
8010695f:	90                   	nop
    uartintr();
80106960:	e8 3b 03 00 00       	call   80106ca0 <uartintr>
    lapiceoi();
80106965:	e8 76 c6 ff ff       	call   80102fe0 <lapiceoi>
    break;
8010696a:	e9 07 ff ff ff       	jmp    80106876 <trap+0x166>
8010696f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106970:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106974:	8b 77 38             	mov    0x38(%edi),%esi
80106977:	e8 84 d7 ff ff       	call   80104100 <cpuid>
8010697c:	56                   	push   %esi
8010697d:	53                   	push   %ebx
8010697e:	50                   	push   %eax
8010697f:	68 a8 92 10 80       	push   $0x801092a8
80106984:	e8 d7 9c ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106989:	e8 52 c6 ff ff       	call   80102fe0 <lapiceoi>
    break;
8010698e:	83 c4 10             	add    $0x10,%esp
80106991:	e9 e0 fe ff ff       	jmp    80106876 <trap+0x166>
80106996:	8d 76 00             	lea    0x0(%esi),%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
801069a0:	e8 7b bc ff ff       	call   80102620 <ideintr>
801069a5:	eb 8e                	jmp    80106935 <trap+0x225>
801069a7:	89 f6                	mov    %esi,%esi
801069a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
801069b0:	e8 1b e5 ff ff       	call   80104ed0 <exit>
801069b5:	e9 36 ff ff ff       	jmp    801068f0 <trap+0x1e0>
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801069c0:	e8 0b e5 ff ff       	call   80104ed0 <exit>
801069c5:	e9 d2 fe ff ff       	jmp    8010689c <trap+0x18c>
801069ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801069d0:	83 ec 0c             	sub    $0xc,%esp
801069d3:	68 80 93 15 80       	push   $0x80159380
801069d8:	e8 c3 e8 ff ff       	call   801052a0 <acquire>
      wakeup(&ticks);
801069dd:	c7 04 24 c0 9b 15 80 	movl   $0x80159bc0,(%esp)
      ticks++;
801069e4:	83 05 c0 9b 15 80 01 	addl   $0x1,0x80159bc0
      wakeup(&ticks);
801069eb:	e8 a0 df ff ff       	call   80104990 <wakeup>
      release(&tickslock);
801069f0:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
801069f7:	e8 64 e9 ff ff       	call   80105360 <release>
801069fc:	83 c4 10             	add    $0x10,%esp
801069ff:	e9 31 ff ff ff       	jmp    80106935 <trap+0x225>
80106a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        myproc()->nPGFLT++;
80106a08:	e8 13 d7 ff ff       	call   80104120 <myproc>
80106a0d:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
        swapPage(addr);
80106a14:	83 ec 0c             	sub    $0xc,%esp
80106a17:	53                   	push   %ebx
80106a18:	e8 b3 1e 00 00       	call   801088d0 <swapPage>
        lcr3(V2P(myproc()->pgdir));
80106a1d:	e8 fe d6 ff ff       	call   80104120 <myproc>
80106a22:	8b 40 04             	mov    0x4(%eax),%eax
80106a25:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106a2a:	0f 22 d8             	mov    %eax,%cr3
80106a2d:	83 c4 10             	add    $0x10,%esp
80106a30:	e9 b3 fd ff ff       	jmp    801067e8 <trap+0xd8>
80106a35:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106a38:	e9 9f fd ff ff       	jmp    801067dc <trap+0xcc>
          uint refCount = getReferenceCount(pa);
80106a3d:	83 ec 0c             	sub    $0xc,%esp
80106a40:	ff 75 e4             	pushl  -0x1c(%ebp)
80106a43:	e8 28 c3 ff ff       	call   80102d70 <getReferenceCount>
          if(refCount > 1) {
80106a48:	83 c4 10             	add    $0x10,%esp
80106a4b:	83 f8 01             	cmp    $0x1,%eax
80106a4e:	76 5a                	jbe    80106aaa <trap+0x39a>
            if((mem = kalloc()) == 0) {
80106a50:	e8 1b c1 ff ff       	call   80102b70 <kalloc>
80106a55:	85 c0                	test   %eax,%eax
80106a57:	89 c3                	mov    %eax,%ebx
80106a59:	74 6e                	je     80106ac9 <trap+0x3b9>
            memmove(mem, (char*)P2V(pa), PGSIZE);
80106a5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a5e:	83 ec 04             	sub    $0x4,%esp
80106a61:	68 00 10 00 00       	push   $0x1000
80106a66:	05 00 00 00 80       	add    $0x80000000,%eax
80106a6b:	50                   	push   %eax
80106a6c:	53                   	push   %ebx
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
80106a6d:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
            memmove(mem, (char*)P2V(pa), PGSIZE);
80106a73:	e8 e8 e9 ff ff       	call   80105460 <memmove>
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
80106a78:	8b 06                	mov    (%esi),%eax
80106a7a:	25 ff 0f 00 00       	and    $0xfff,%eax
80106a7f:	09 d8                	or     %ebx,%eax
            *pte &= ~PTE_COW;
80106a81:	80 e4 f7             	and    $0xf7,%ah
80106a84:	83 c8 03             	or     $0x3,%eax
80106a87:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
80106a89:	e8 92 d6 ff ff       	call   80104120 <myproc>
80106a8e:	8b 40 04             	mov    0x4(%eax),%eax
80106a91:	05 00 00 00 80       	add    $0x80000000,%eax
80106a96:	0f 22 d8             	mov    %eax,%cr3
            decrementReferenceCount(pa);
80106a99:	59                   	pop    %ecx
80106a9a:	ff 75 e4             	pushl  -0x1c(%ebp)
80106a9d:	e8 ae c1 ff ff       	call   80102c50 <decrementReferenceCount>
80106aa2:	83 c4 10             	add    $0x10,%esp
80106aa5:	e9 3e fd ff ff       	jmp    801067e8 <trap+0xd8>
            *pte &= ~PTE_COW;
80106aaa:	8b 06                	mov    (%esi),%eax
80106aac:	80 e4 f7             	and    $0xf7,%ah
80106aaf:	83 c8 02             	or     $0x2,%eax
80106ab2:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
80106ab4:	e8 67 d6 ff ff       	call   80104120 <myproc>
80106ab9:	8b 40 04             	mov    0x4(%eax),%eax
80106abc:	05 00 00 00 80       	add    $0x80000000,%eax
80106ac1:	0f 22 d8             	mov    %eax,%cr3
80106ac4:	e9 1f fd ff ff       	jmp    801067e8 <trap+0xd8>
              cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
80106ac9:	e8 52 d6 ff ff       	call   80104120 <myproc>
80106ace:	8b 58 10             	mov    0x10(%eax),%ebx
80106ad1:	e8 4a d6 ff ff       	call   80104120 <myproc>
80106ad6:	83 c0 6c             	add    $0x6c,%eax
80106ad9:	56                   	push   %esi
80106ada:	53                   	push   %ebx
80106adb:	50                   	push   %eax
80106adc:	68 cc 92 10 80       	push   $0x801092cc
80106ae1:	e8 7a 9b ff ff       	call   80100660 <cprintf>
              myproc()->killed = 1;
80106ae6:	e8 35 d6 ff ff       	call   80104120 <myproc>
              return;
80106aeb:	83 c4 10             	add    $0x10,%esp
              myproc()->killed = 1;
80106aee:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
              return;
80106af5:	e9 d8 fd ff ff       	jmp    801068d2 <trap+0x1c2>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106afa:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106afd:	e8 fe d5 ff ff       	call   80104100 <cpuid>
80106b02:	83 ec 0c             	sub    $0xc,%esp
80106b05:	56                   	push   %esi
80106b06:	53                   	push   %ebx
80106b07:	50                   	push   %eax
80106b08:	ff 77 30             	pushl  0x30(%edi)
80106b0b:	68 00 93 10 80       	push   $0x80109300
80106b10:	e8 4b 9b ff ff       	call   80100660 <cprintf>
      panic("trap");
80106b15:	83 c4 14             	add    $0x14,%esp
80106b18:	68 a2 92 10 80       	push   $0x801092a2
80106b1d:	e8 6e 98 ff ff       	call   80100390 <panic>
80106b22:	66 90                	xchg   %ax,%ax
80106b24:	66 90                	xchg   %ax,%ax
80106b26:	66 90                	xchg   %ax,%ax
80106b28:	66 90                	xchg   %ax,%ax
80106b2a:	66 90                	xchg   %ax,%ax
80106b2c:	66 90                	xchg   %ax,%ax
80106b2e:	66 90                	xchg   %ax,%ax

80106b30 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106b30:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
80106b35:	55                   	push   %ebp
80106b36:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106b38:	85 c0                	test   %eax,%eax
80106b3a:	74 1c                	je     80106b58 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b3c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106b41:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106b42:	a8 01                	test   $0x1,%al
80106b44:	74 12                	je     80106b58 <uartgetc+0x28>
80106b46:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b4b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106b4c:	0f b6 c0             	movzbl %al,%eax
}
80106b4f:	5d                   	pop    %ebp
80106b50:	c3                   	ret    
80106b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b5d:	5d                   	pop    %ebp
80106b5e:	c3                   	ret    
80106b5f:	90                   	nop

80106b60 <uartputc.part.0>:
uartputc(int c)
80106b60:	55                   	push   %ebp
80106b61:	89 e5                	mov    %esp,%ebp
80106b63:	57                   	push   %edi
80106b64:	56                   	push   %esi
80106b65:	53                   	push   %ebx
80106b66:	89 c7                	mov    %eax,%edi
80106b68:	bb 80 00 00 00       	mov    $0x80,%ebx
80106b6d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106b72:	83 ec 0c             	sub    $0xc,%esp
80106b75:	eb 1b                	jmp    80106b92 <uartputc.part.0+0x32>
80106b77:	89 f6                	mov    %esi,%esi
80106b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106b80:	83 ec 0c             	sub    $0xc,%esp
80106b83:	6a 0a                	push   $0xa
80106b85:	e8 76 c4 ff ff       	call   80103000 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106b8a:	83 c4 10             	add    $0x10,%esp
80106b8d:	83 eb 01             	sub    $0x1,%ebx
80106b90:	74 07                	je     80106b99 <uartputc.part.0+0x39>
80106b92:	89 f2                	mov    %esi,%edx
80106b94:	ec                   	in     (%dx),%al
80106b95:	a8 20                	test   $0x20,%al
80106b97:	74 e7                	je     80106b80 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b99:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106b9e:	89 f8                	mov    %edi,%eax
80106ba0:	ee                   	out    %al,(%dx)
}
80106ba1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ba4:	5b                   	pop    %ebx
80106ba5:	5e                   	pop    %esi
80106ba6:	5f                   	pop    %edi
80106ba7:	5d                   	pop    %ebp
80106ba8:	c3                   	ret    
80106ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bb0 <uartinit>:
{
80106bb0:	55                   	push   %ebp
80106bb1:	31 c9                	xor    %ecx,%ecx
80106bb3:	89 c8                	mov    %ecx,%eax
80106bb5:	89 e5                	mov    %esp,%ebp
80106bb7:	57                   	push   %edi
80106bb8:	56                   	push   %esi
80106bb9:	53                   	push   %ebx
80106bba:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106bbf:	89 da                	mov    %ebx,%edx
80106bc1:	83 ec 0c             	sub    $0xc,%esp
80106bc4:	ee                   	out    %al,(%dx)
80106bc5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80106bca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106bcf:	89 fa                	mov    %edi,%edx
80106bd1:	ee                   	out    %al,(%dx)
80106bd2:	b8 0c 00 00 00       	mov    $0xc,%eax
80106bd7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106bdc:	ee                   	out    %al,(%dx)
80106bdd:	be f9 03 00 00       	mov    $0x3f9,%esi
80106be2:	89 c8                	mov    %ecx,%eax
80106be4:	89 f2                	mov    %esi,%edx
80106be6:	ee                   	out    %al,(%dx)
80106be7:	b8 03 00 00 00       	mov    $0x3,%eax
80106bec:	89 fa                	mov    %edi,%edx
80106bee:	ee                   	out    %al,(%dx)
80106bef:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106bf4:	89 c8                	mov    %ecx,%eax
80106bf6:	ee                   	out    %al,(%dx)
80106bf7:	b8 01 00 00 00       	mov    $0x1,%eax
80106bfc:	89 f2                	mov    %esi,%edx
80106bfe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106bff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106c04:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106c05:	3c ff                	cmp    $0xff,%al
80106c07:	74 5a                	je     80106c63 <uartinit+0xb3>
  uart = 1;
80106c09:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
80106c10:	00 00 00 
80106c13:	89 da                	mov    %ebx,%edx
80106c15:	ec                   	in     (%dx),%al
80106c16:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106c1b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106c1c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106c1f:	bb 40 94 10 80       	mov    $0x80109440,%ebx
  ioapicenable(IRQ_COM1, 0);
80106c24:	6a 00                	push   $0x0
80106c26:	6a 04                	push   $0x4
80106c28:	e8 43 bc ff ff       	call   80102870 <ioapicenable>
80106c2d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106c30:	b8 78 00 00 00       	mov    $0x78,%eax
80106c35:	eb 13                	jmp    80106c4a <uartinit+0x9a>
80106c37:	89 f6                	mov    %esi,%esi
80106c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c40:	83 c3 01             	add    $0x1,%ebx
80106c43:	0f be 03             	movsbl (%ebx),%eax
80106c46:	84 c0                	test   %al,%al
80106c48:	74 19                	je     80106c63 <uartinit+0xb3>
  if(!uart)
80106c4a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80106c50:	85 d2                	test   %edx,%edx
80106c52:	74 ec                	je     80106c40 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106c54:	83 c3 01             	add    $0x1,%ebx
80106c57:	e8 04 ff ff ff       	call   80106b60 <uartputc.part.0>
80106c5c:	0f be 03             	movsbl (%ebx),%eax
80106c5f:	84 c0                	test   %al,%al
80106c61:	75 e7                	jne    80106c4a <uartinit+0x9a>
}
80106c63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c66:	5b                   	pop    %ebx
80106c67:	5e                   	pop    %esi
80106c68:	5f                   	pop    %edi
80106c69:	5d                   	pop    %ebp
80106c6a:	c3                   	ret    
80106c6b:	90                   	nop
80106c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106c70 <uartputc>:
  if(!uart)
80106c70:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
{
80106c76:	55                   	push   %ebp
80106c77:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106c79:	85 d2                	test   %edx,%edx
{
80106c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106c7e:	74 10                	je     80106c90 <uartputc+0x20>
}
80106c80:	5d                   	pop    %ebp
80106c81:	e9 da fe ff ff       	jmp    80106b60 <uartputc.part.0>
80106c86:	8d 76 00             	lea    0x0(%esi),%esi
80106c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106c90:	5d                   	pop    %ebp
80106c91:	c3                   	ret    
80106c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ca0 <uartintr>:

void
uartintr(void)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106ca6:	68 30 6b 10 80       	push   $0x80106b30
80106cab:	e8 60 9b ff ff       	call   80100810 <consoleintr>
}
80106cb0:	83 c4 10             	add    $0x10,%esp
80106cb3:	c9                   	leave  
80106cb4:	c3                   	ret    

80106cb5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106cb5:	6a 00                	push   $0x0
  pushl $0
80106cb7:	6a 00                	push   $0x0
  jmp alltraps
80106cb9:	e9 71 f9 ff ff       	jmp    8010662f <alltraps>

80106cbe <vector1>:
.globl vector1
vector1:
  pushl $0
80106cbe:	6a 00                	push   $0x0
  pushl $1
80106cc0:	6a 01                	push   $0x1
  jmp alltraps
80106cc2:	e9 68 f9 ff ff       	jmp    8010662f <alltraps>

80106cc7 <vector2>:
.globl vector2
vector2:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $2
80106cc9:	6a 02                	push   $0x2
  jmp alltraps
80106ccb:	e9 5f f9 ff ff       	jmp    8010662f <alltraps>

80106cd0 <vector3>:
.globl vector3
vector3:
  pushl $0
80106cd0:	6a 00                	push   $0x0
  pushl $3
80106cd2:	6a 03                	push   $0x3
  jmp alltraps
80106cd4:	e9 56 f9 ff ff       	jmp    8010662f <alltraps>

80106cd9 <vector4>:
.globl vector4
vector4:
  pushl $0
80106cd9:	6a 00                	push   $0x0
  pushl $4
80106cdb:	6a 04                	push   $0x4
  jmp alltraps
80106cdd:	e9 4d f9 ff ff       	jmp    8010662f <alltraps>

80106ce2 <vector5>:
.globl vector5
vector5:
  pushl $0
80106ce2:	6a 00                	push   $0x0
  pushl $5
80106ce4:	6a 05                	push   $0x5
  jmp alltraps
80106ce6:	e9 44 f9 ff ff       	jmp    8010662f <alltraps>

80106ceb <vector6>:
.globl vector6
vector6:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $6
80106ced:	6a 06                	push   $0x6
  jmp alltraps
80106cef:	e9 3b f9 ff ff       	jmp    8010662f <alltraps>

80106cf4 <vector7>:
.globl vector7
vector7:
  pushl $0
80106cf4:	6a 00                	push   $0x0
  pushl $7
80106cf6:	6a 07                	push   $0x7
  jmp alltraps
80106cf8:	e9 32 f9 ff ff       	jmp    8010662f <alltraps>

80106cfd <vector8>:
.globl vector8
vector8:
  pushl $8
80106cfd:	6a 08                	push   $0x8
  jmp alltraps
80106cff:	e9 2b f9 ff ff       	jmp    8010662f <alltraps>

80106d04 <vector9>:
.globl vector9
vector9:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $9
80106d06:	6a 09                	push   $0x9
  jmp alltraps
80106d08:	e9 22 f9 ff ff       	jmp    8010662f <alltraps>

80106d0d <vector10>:
.globl vector10
vector10:
  pushl $10
80106d0d:	6a 0a                	push   $0xa
  jmp alltraps
80106d0f:	e9 1b f9 ff ff       	jmp    8010662f <alltraps>

80106d14 <vector11>:
.globl vector11
vector11:
  pushl $11
80106d14:	6a 0b                	push   $0xb
  jmp alltraps
80106d16:	e9 14 f9 ff ff       	jmp    8010662f <alltraps>

80106d1b <vector12>:
.globl vector12
vector12:
  pushl $12
80106d1b:	6a 0c                	push   $0xc
  jmp alltraps
80106d1d:	e9 0d f9 ff ff       	jmp    8010662f <alltraps>

80106d22 <vector13>:
.globl vector13
vector13:
  pushl $13
80106d22:	6a 0d                	push   $0xd
  jmp alltraps
80106d24:	e9 06 f9 ff ff       	jmp    8010662f <alltraps>

80106d29 <vector14>:
.globl vector14
vector14:
  pushl $14
80106d29:	6a 0e                	push   $0xe
  jmp alltraps
80106d2b:	e9 ff f8 ff ff       	jmp    8010662f <alltraps>

80106d30 <vector15>:
.globl vector15
vector15:
  pushl $0
80106d30:	6a 00                	push   $0x0
  pushl $15
80106d32:	6a 0f                	push   $0xf
  jmp alltraps
80106d34:	e9 f6 f8 ff ff       	jmp    8010662f <alltraps>

80106d39 <vector16>:
.globl vector16
vector16:
  pushl $0
80106d39:	6a 00                	push   $0x0
  pushl $16
80106d3b:	6a 10                	push   $0x10
  jmp alltraps
80106d3d:	e9 ed f8 ff ff       	jmp    8010662f <alltraps>

80106d42 <vector17>:
.globl vector17
vector17:
  pushl $17
80106d42:	6a 11                	push   $0x11
  jmp alltraps
80106d44:	e9 e6 f8 ff ff       	jmp    8010662f <alltraps>

80106d49 <vector18>:
.globl vector18
vector18:
  pushl $0
80106d49:	6a 00                	push   $0x0
  pushl $18
80106d4b:	6a 12                	push   $0x12
  jmp alltraps
80106d4d:	e9 dd f8 ff ff       	jmp    8010662f <alltraps>

80106d52 <vector19>:
.globl vector19
vector19:
  pushl $0
80106d52:	6a 00                	push   $0x0
  pushl $19
80106d54:	6a 13                	push   $0x13
  jmp alltraps
80106d56:	e9 d4 f8 ff ff       	jmp    8010662f <alltraps>

80106d5b <vector20>:
.globl vector20
vector20:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $20
80106d5d:	6a 14                	push   $0x14
  jmp alltraps
80106d5f:	e9 cb f8 ff ff       	jmp    8010662f <alltraps>

80106d64 <vector21>:
.globl vector21
vector21:
  pushl $0
80106d64:	6a 00                	push   $0x0
  pushl $21
80106d66:	6a 15                	push   $0x15
  jmp alltraps
80106d68:	e9 c2 f8 ff ff       	jmp    8010662f <alltraps>

80106d6d <vector22>:
.globl vector22
vector22:
  pushl $0
80106d6d:	6a 00                	push   $0x0
  pushl $22
80106d6f:	6a 16                	push   $0x16
  jmp alltraps
80106d71:	e9 b9 f8 ff ff       	jmp    8010662f <alltraps>

80106d76 <vector23>:
.globl vector23
vector23:
  pushl $0
80106d76:	6a 00                	push   $0x0
  pushl $23
80106d78:	6a 17                	push   $0x17
  jmp alltraps
80106d7a:	e9 b0 f8 ff ff       	jmp    8010662f <alltraps>

80106d7f <vector24>:
.globl vector24
vector24:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $24
80106d81:	6a 18                	push   $0x18
  jmp alltraps
80106d83:	e9 a7 f8 ff ff       	jmp    8010662f <alltraps>

80106d88 <vector25>:
.globl vector25
vector25:
  pushl $0
80106d88:	6a 00                	push   $0x0
  pushl $25
80106d8a:	6a 19                	push   $0x19
  jmp alltraps
80106d8c:	e9 9e f8 ff ff       	jmp    8010662f <alltraps>

80106d91 <vector26>:
.globl vector26
vector26:
  pushl $0
80106d91:	6a 00                	push   $0x0
  pushl $26
80106d93:	6a 1a                	push   $0x1a
  jmp alltraps
80106d95:	e9 95 f8 ff ff       	jmp    8010662f <alltraps>

80106d9a <vector27>:
.globl vector27
vector27:
  pushl $0
80106d9a:	6a 00                	push   $0x0
  pushl $27
80106d9c:	6a 1b                	push   $0x1b
  jmp alltraps
80106d9e:	e9 8c f8 ff ff       	jmp    8010662f <alltraps>

80106da3 <vector28>:
.globl vector28
vector28:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $28
80106da5:	6a 1c                	push   $0x1c
  jmp alltraps
80106da7:	e9 83 f8 ff ff       	jmp    8010662f <alltraps>

80106dac <vector29>:
.globl vector29
vector29:
  pushl $0
80106dac:	6a 00                	push   $0x0
  pushl $29
80106dae:	6a 1d                	push   $0x1d
  jmp alltraps
80106db0:	e9 7a f8 ff ff       	jmp    8010662f <alltraps>

80106db5 <vector30>:
.globl vector30
vector30:
  pushl $0
80106db5:	6a 00                	push   $0x0
  pushl $30
80106db7:	6a 1e                	push   $0x1e
  jmp alltraps
80106db9:	e9 71 f8 ff ff       	jmp    8010662f <alltraps>

80106dbe <vector31>:
.globl vector31
vector31:
  pushl $0
80106dbe:	6a 00                	push   $0x0
  pushl $31
80106dc0:	6a 1f                	push   $0x1f
  jmp alltraps
80106dc2:	e9 68 f8 ff ff       	jmp    8010662f <alltraps>

80106dc7 <vector32>:
.globl vector32
vector32:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $32
80106dc9:	6a 20                	push   $0x20
  jmp alltraps
80106dcb:	e9 5f f8 ff ff       	jmp    8010662f <alltraps>

80106dd0 <vector33>:
.globl vector33
vector33:
  pushl $0
80106dd0:	6a 00                	push   $0x0
  pushl $33
80106dd2:	6a 21                	push   $0x21
  jmp alltraps
80106dd4:	e9 56 f8 ff ff       	jmp    8010662f <alltraps>

80106dd9 <vector34>:
.globl vector34
vector34:
  pushl $0
80106dd9:	6a 00                	push   $0x0
  pushl $34
80106ddb:	6a 22                	push   $0x22
  jmp alltraps
80106ddd:	e9 4d f8 ff ff       	jmp    8010662f <alltraps>

80106de2 <vector35>:
.globl vector35
vector35:
  pushl $0
80106de2:	6a 00                	push   $0x0
  pushl $35
80106de4:	6a 23                	push   $0x23
  jmp alltraps
80106de6:	e9 44 f8 ff ff       	jmp    8010662f <alltraps>

80106deb <vector36>:
.globl vector36
vector36:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $36
80106ded:	6a 24                	push   $0x24
  jmp alltraps
80106def:	e9 3b f8 ff ff       	jmp    8010662f <alltraps>

80106df4 <vector37>:
.globl vector37
vector37:
  pushl $0
80106df4:	6a 00                	push   $0x0
  pushl $37
80106df6:	6a 25                	push   $0x25
  jmp alltraps
80106df8:	e9 32 f8 ff ff       	jmp    8010662f <alltraps>

80106dfd <vector38>:
.globl vector38
vector38:
  pushl $0
80106dfd:	6a 00                	push   $0x0
  pushl $38
80106dff:	6a 26                	push   $0x26
  jmp alltraps
80106e01:	e9 29 f8 ff ff       	jmp    8010662f <alltraps>

80106e06 <vector39>:
.globl vector39
vector39:
  pushl $0
80106e06:	6a 00                	push   $0x0
  pushl $39
80106e08:	6a 27                	push   $0x27
  jmp alltraps
80106e0a:	e9 20 f8 ff ff       	jmp    8010662f <alltraps>

80106e0f <vector40>:
.globl vector40
vector40:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $40
80106e11:	6a 28                	push   $0x28
  jmp alltraps
80106e13:	e9 17 f8 ff ff       	jmp    8010662f <alltraps>

80106e18 <vector41>:
.globl vector41
vector41:
  pushl $0
80106e18:	6a 00                	push   $0x0
  pushl $41
80106e1a:	6a 29                	push   $0x29
  jmp alltraps
80106e1c:	e9 0e f8 ff ff       	jmp    8010662f <alltraps>

80106e21 <vector42>:
.globl vector42
vector42:
  pushl $0
80106e21:	6a 00                	push   $0x0
  pushl $42
80106e23:	6a 2a                	push   $0x2a
  jmp alltraps
80106e25:	e9 05 f8 ff ff       	jmp    8010662f <alltraps>

80106e2a <vector43>:
.globl vector43
vector43:
  pushl $0
80106e2a:	6a 00                	push   $0x0
  pushl $43
80106e2c:	6a 2b                	push   $0x2b
  jmp alltraps
80106e2e:	e9 fc f7 ff ff       	jmp    8010662f <alltraps>

80106e33 <vector44>:
.globl vector44
vector44:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $44
80106e35:	6a 2c                	push   $0x2c
  jmp alltraps
80106e37:	e9 f3 f7 ff ff       	jmp    8010662f <alltraps>

80106e3c <vector45>:
.globl vector45
vector45:
  pushl $0
80106e3c:	6a 00                	push   $0x0
  pushl $45
80106e3e:	6a 2d                	push   $0x2d
  jmp alltraps
80106e40:	e9 ea f7 ff ff       	jmp    8010662f <alltraps>

80106e45 <vector46>:
.globl vector46
vector46:
  pushl $0
80106e45:	6a 00                	push   $0x0
  pushl $46
80106e47:	6a 2e                	push   $0x2e
  jmp alltraps
80106e49:	e9 e1 f7 ff ff       	jmp    8010662f <alltraps>

80106e4e <vector47>:
.globl vector47
vector47:
  pushl $0
80106e4e:	6a 00                	push   $0x0
  pushl $47
80106e50:	6a 2f                	push   $0x2f
  jmp alltraps
80106e52:	e9 d8 f7 ff ff       	jmp    8010662f <alltraps>

80106e57 <vector48>:
.globl vector48
vector48:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $48
80106e59:	6a 30                	push   $0x30
  jmp alltraps
80106e5b:	e9 cf f7 ff ff       	jmp    8010662f <alltraps>

80106e60 <vector49>:
.globl vector49
vector49:
  pushl $0
80106e60:	6a 00                	push   $0x0
  pushl $49
80106e62:	6a 31                	push   $0x31
  jmp alltraps
80106e64:	e9 c6 f7 ff ff       	jmp    8010662f <alltraps>

80106e69 <vector50>:
.globl vector50
vector50:
  pushl $0
80106e69:	6a 00                	push   $0x0
  pushl $50
80106e6b:	6a 32                	push   $0x32
  jmp alltraps
80106e6d:	e9 bd f7 ff ff       	jmp    8010662f <alltraps>

80106e72 <vector51>:
.globl vector51
vector51:
  pushl $0
80106e72:	6a 00                	push   $0x0
  pushl $51
80106e74:	6a 33                	push   $0x33
  jmp alltraps
80106e76:	e9 b4 f7 ff ff       	jmp    8010662f <alltraps>

80106e7b <vector52>:
.globl vector52
vector52:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $52
80106e7d:	6a 34                	push   $0x34
  jmp alltraps
80106e7f:	e9 ab f7 ff ff       	jmp    8010662f <alltraps>

80106e84 <vector53>:
.globl vector53
vector53:
  pushl $0
80106e84:	6a 00                	push   $0x0
  pushl $53
80106e86:	6a 35                	push   $0x35
  jmp alltraps
80106e88:	e9 a2 f7 ff ff       	jmp    8010662f <alltraps>

80106e8d <vector54>:
.globl vector54
vector54:
  pushl $0
80106e8d:	6a 00                	push   $0x0
  pushl $54
80106e8f:	6a 36                	push   $0x36
  jmp alltraps
80106e91:	e9 99 f7 ff ff       	jmp    8010662f <alltraps>

80106e96 <vector55>:
.globl vector55
vector55:
  pushl $0
80106e96:	6a 00                	push   $0x0
  pushl $55
80106e98:	6a 37                	push   $0x37
  jmp alltraps
80106e9a:	e9 90 f7 ff ff       	jmp    8010662f <alltraps>

80106e9f <vector56>:
.globl vector56
vector56:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $56
80106ea1:	6a 38                	push   $0x38
  jmp alltraps
80106ea3:	e9 87 f7 ff ff       	jmp    8010662f <alltraps>

80106ea8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ea8:	6a 00                	push   $0x0
  pushl $57
80106eaa:	6a 39                	push   $0x39
  jmp alltraps
80106eac:	e9 7e f7 ff ff       	jmp    8010662f <alltraps>

80106eb1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106eb1:	6a 00                	push   $0x0
  pushl $58
80106eb3:	6a 3a                	push   $0x3a
  jmp alltraps
80106eb5:	e9 75 f7 ff ff       	jmp    8010662f <alltraps>

80106eba <vector59>:
.globl vector59
vector59:
  pushl $0
80106eba:	6a 00                	push   $0x0
  pushl $59
80106ebc:	6a 3b                	push   $0x3b
  jmp alltraps
80106ebe:	e9 6c f7 ff ff       	jmp    8010662f <alltraps>

80106ec3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $60
80106ec5:	6a 3c                	push   $0x3c
  jmp alltraps
80106ec7:	e9 63 f7 ff ff       	jmp    8010662f <alltraps>

80106ecc <vector61>:
.globl vector61
vector61:
  pushl $0
80106ecc:	6a 00                	push   $0x0
  pushl $61
80106ece:	6a 3d                	push   $0x3d
  jmp alltraps
80106ed0:	e9 5a f7 ff ff       	jmp    8010662f <alltraps>

80106ed5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106ed5:	6a 00                	push   $0x0
  pushl $62
80106ed7:	6a 3e                	push   $0x3e
  jmp alltraps
80106ed9:	e9 51 f7 ff ff       	jmp    8010662f <alltraps>

80106ede <vector63>:
.globl vector63
vector63:
  pushl $0
80106ede:	6a 00                	push   $0x0
  pushl $63
80106ee0:	6a 3f                	push   $0x3f
  jmp alltraps
80106ee2:	e9 48 f7 ff ff       	jmp    8010662f <alltraps>

80106ee7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $64
80106ee9:	6a 40                	push   $0x40
  jmp alltraps
80106eeb:	e9 3f f7 ff ff       	jmp    8010662f <alltraps>

80106ef0 <vector65>:
.globl vector65
vector65:
  pushl $0
80106ef0:	6a 00                	push   $0x0
  pushl $65
80106ef2:	6a 41                	push   $0x41
  jmp alltraps
80106ef4:	e9 36 f7 ff ff       	jmp    8010662f <alltraps>

80106ef9 <vector66>:
.globl vector66
vector66:
  pushl $0
80106ef9:	6a 00                	push   $0x0
  pushl $66
80106efb:	6a 42                	push   $0x42
  jmp alltraps
80106efd:	e9 2d f7 ff ff       	jmp    8010662f <alltraps>

80106f02 <vector67>:
.globl vector67
vector67:
  pushl $0
80106f02:	6a 00                	push   $0x0
  pushl $67
80106f04:	6a 43                	push   $0x43
  jmp alltraps
80106f06:	e9 24 f7 ff ff       	jmp    8010662f <alltraps>

80106f0b <vector68>:
.globl vector68
vector68:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $68
80106f0d:	6a 44                	push   $0x44
  jmp alltraps
80106f0f:	e9 1b f7 ff ff       	jmp    8010662f <alltraps>

80106f14 <vector69>:
.globl vector69
vector69:
  pushl $0
80106f14:	6a 00                	push   $0x0
  pushl $69
80106f16:	6a 45                	push   $0x45
  jmp alltraps
80106f18:	e9 12 f7 ff ff       	jmp    8010662f <alltraps>

80106f1d <vector70>:
.globl vector70
vector70:
  pushl $0
80106f1d:	6a 00                	push   $0x0
  pushl $70
80106f1f:	6a 46                	push   $0x46
  jmp alltraps
80106f21:	e9 09 f7 ff ff       	jmp    8010662f <alltraps>

80106f26 <vector71>:
.globl vector71
vector71:
  pushl $0
80106f26:	6a 00                	push   $0x0
  pushl $71
80106f28:	6a 47                	push   $0x47
  jmp alltraps
80106f2a:	e9 00 f7 ff ff       	jmp    8010662f <alltraps>

80106f2f <vector72>:
.globl vector72
vector72:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $72
80106f31:	6a 48                	push   $0x48
  jmp alltraps
80106f33:	e9 f7 f6 ff ff       	jmp    8010662f <alltraps>

80106f38 <vector73>:
.globl vector73
vector73:
  pushl $0
80106f38:	6a 00                	push   $0x0
  pushl $73
80106f3a:	6a 49                	push   $0x49
  jmp alltraps
80106f3c:	e9 ee f6 ff ff       	jmp    8010662f <alltraps>

80106f41 <vector74>:
.globl vector74
vector74:
  pushl $0
80106f41:	6a 00                	push   $0x0
  pushl $74
80106f43:	6a 4a                	push   $0x4a
  jmp alltraps
80106f45:	e9 e5 f6 ff ff       	jmp    8010662f <alltraps>

80106f4a <vector75>:
.globl vector75
vector75:
  pushl $0
80106f4a:	6a 00                	push   $0x0
  pushl $75
80106f4c:	6a 4b                	push   $0x4b
  jmp alltraps
80106f4e:	e9 dc f6 ff ff       	jmp    8010662f <alltraps>

80106f53 <vector76>:
.globl vector76
vector76:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $76
80106f55:	6a 4c                	push   $0x4c
  jmp alltraps
80106f57:	e9 d3 f6 ff ff       	jmp    8010662f <alltraps>

80106f5c <vector77>:
.globl vector77
vector77:
  pushl $0
80106f5c:	6a 00                	push   $0x0
  pushl $77
80106f5e:	6a 4d                	push   $0x4d
  jmp alltraps
80106f60:	e9 ca f6 ff ff       	jmp    8010662f <alltraps>

80106f65 <vector78>:
.globl vector78
vector78:
  pushl $0
80106f65:	6a 00                	push   $0x0
  pushl $78
80106f67:	6a 4e                	push   $0x4e
  jmp alltraps
80106f69:	e9 c1 f6 ff ff       	jmp    8010662f <alltraps>

80106f6e <vector79>:
.globl vector79
vector79:
  pushl $0
80106f6e:	6a 00                	push   $0x0
  pushl $79
80106f70:	6a 4f                	push   $0x4f
  jmp alltraps
80106f72:	e9 b8 f6 ff ff       	jmp    8010662f <alltraps>

80106f77 <vector80>:
.globl vector80
vector80:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $80
80106f79:	6a 50                	push   $0x50
  jmp alltraps
80106f7b:	e9 af f6 ff ff       	jmp    8010662f <alltraps>

80106f80 <vector81>:
.globl vector81
vector81:
  pushl $0
80106f80:	6a 00                	push   $0x0
  pushl $81
80106f82:	6a 51                	push   $0x51
  jmp alltraps
80106f84:	e9 a6 f6 ff ff       	jmp    8010662f <alltraps>

80106f89 <vector82>:
.globl vector82
vector82:
  pushl $0
80106f89:	6a 00                	push   $0x0
  pushl $82
80106f8b:	6a 52                	push   $0x52
  jmp alltraps
80106f8d:	e9 9d f6 ff ff       	jmp    8010662f <alltraps>

80106f92 <vector83>:
.globl vector83
vector83:
  pushl $0
80106f92:	6a 00                	push   $0x0
  pushl $83
80106f94:	6a 53                	push   $0x53
  jmp alltraps
80106f96:	e9 94 f6 ff ff       	jmp    8010662f <alltraps>

80106f9b <vector84>:
.globl vector84
vector84:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $84
80106f9d:	6a 54                	push   $0x54
  jmp alltraps
80106f9f:	e9 8b f6 ff ff       	jmp    8010662f <alltraps>

80106fa4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106fa4:	6a 00                	push   $0x0
  pushl $85
80106fa6:	6a 55                	push   $0x55
  jmp alltraps
80106fa8:	e9 82 f6 ff ff       	jmp    8010662f <alltraps>

80106fad <vector86>:
.globl vector86
vector86:
  pushl $0
80106fad:	6a 00                	push   $0x0
  pushl $86
80106faf:	6a 56                	push   $0x56
  jmp alltraps
80106fb1:	e9 79 f6 ff ff       	jmp    8010662f <alltraps>

80106fb6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106fb6:	6a 00                	push   $0x0
  pushl $87
80106fb8:	6a 57                	push   $0x57
  jmp alltraps
80106fba:	e9 70 f6 ff ff       	jmp    8010662f <alltraps>

80106fbf <vector88>:
.globl vector88
vector88:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $88
80106fc1:	6a 58                	push   $0x58
  jmp alltraps
80106fc3:	e9 67 f6 ff ff       	jmp    8010662f <alltraps>

80106fc8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106fc8:	6a 00                	push   $0x0
  pushl $89
80106fca:	6a 59                	push   $0x59
  jmp alltraps
80106fcc:	e9 5e f6 ff ff       	jmp    8010662f <alltraps>

80106fd1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106fd1:	6a 00                	push   $0x0
  pushl $90
80106fd3:	6a 5a                	push   $0x5a
  jmp alltraps
80106fd5:	e9 55 f6 ff ff       	jmp    8010662f <alltraps>

80106fda <vector91>:
.globl vector91
vector91:
  pushl $0
80106fda:	6a 00                	push   $0x0
  pushl $91
80106fdc:	6a 5b                	push   $0x5b
  jmp alltraps
80106fde:	e9 4c f6 ff ff       	jmp    8010662f <alltraps>

80106fe3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $92
80106fe5:	6a 5c                	push   $0x5c
  jmp alltraps
80106fe7:	e9 43 f6 ff ff       	jmp    8010662f <alltraps>

80106fec <vector93>:
.globl vector93
vector93:
  pushl $0
80106fec:	6a 00                	push   $0x0
  pushl $93
80106fee:	6a 5d                	push   $0x5d
  jmp alltraps
80106ff0:	e9 3a f6 ff ff       	jmp    8010662f <alltraps>

80106ff5 <vector94>:
.globl vector94
vector94:
  pushl $0
80106ff5:	6a 00                	push   $0x0
  pushl $94
80106ff7:	6a 5e                	push   $0x5e
  jmp alltraps
80106ff9:	e9 31 f6 ff ff       	jmp    8010662f <alltraps>

80106ffe <vector95>:
.globl vector95
vector95:
  pushl $0
80106ffe:	6a 00                	push   $0x0
  pushl $95
80107000:	6a 5f                	push   $0x5f
  jmp alltraps
80107002:	e9 28 f6 ff ff       	jmp    8010662f <alltraps>

80107007 <vector96>:
.globl vector96
vector96:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $96
80107009:	6a 60                	push   $0x60
  jmp alltraps
8010700b:	e9 1f f6 ff ff       	jmp    8010662f <alltraps>

80107010 <vector97>:
.globl vector97
vector97:
  pushl $0
80107010:	6a 00                	push   $0x0
  pushl $97
80107012:	6a 61                	push   $0x61
  jmp alltraps
80107014:	e9 16 f6 ff ff       	jmp    8010662f <alltraps>

80107019 <vector98>:
.globl vector98
vector98:
  pushl $0
80107019:	6a 00                	push   $0x0
  pushl $98
8010701b:	6a 62                	push   $0x62
  jmp alltraps
8010701d:	e9 0d f6 ff ff       	jmp    8010662f <alltraps>

80107022 <vector99>:
.globl vector99
vector99:
  pushl $0
80107022:	6a 00                	push   $0x0
  pushl $99
80107024:	6a 63                	push   $0x63
  jmp alltraps
80107026:	e9 04 f6 ff ff       	jmp    8010662f <alltraps>

8010702b <vector100>:
.globl vector100
vector100:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $100
8010702d:	6a 64                	push   $0x64
  jmp alltraps
8010702f:	e9 fb f5 ff ff       	jmp    8010662f <alltraps>

80107034 <vector101>:
.globl vector101
vector101:
  pushl $0
80107034:	6a 00                	push   $0x0
  pushl $101
80107036:	6a 65                	push   $0x65
  jmp alltraps
80107038:	e9 f2 f5 ff ff       	jmp    8010662f <alltraps>

8010703d <vector102>:
.globl vector102
vector102:
  pushl $0
8010703d:	6a 00                	push   $0x0
  pushl $102
8010703f:	6a 66                	push   $0x66
  jmp alltraps
80107041:	e9 e9 f5 ff ff       	jmp    8010662f <alltraps>

80107046 <vector103>:
.globl vector103
vector103:
  pushl $0
80107046:	6a 00                	push   $0x0
  pushl $103
80107048:	6a 67                	push   $0x67
  jmp alltraps
8010704a:	e9 e0 f5 ff ff       	jmp    8010662f <alltraps>

8010704f <vector104>:
.globl vector104
vector104:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $104
80107051:	6a 68                	push   $0x68
  jmp alltraps
80107053:	e9 d7 f5 ff ff       	jmp    8010662f <alltraps>

80107058 <vector105>:
.globl vector105
vector105:
  pushl $0
80107058:	6a 00                	push   $0x0
  pushl $105
8010705a:	6a 69                	push   $0x69
  jmp alltraps
8010705c:	e9 ce f5 ff ff       	jmp    8010662f <alltraps>

80107061 <vector106>:
.globl vector106
vector106:
  pushl $0
80107061:	6a 00                	push   $0x0
  pushl $106
80107063:	6a 6a                	push   $0x6a
  jmp alltraps
80107065:	e9 c5 f5 ff ff       	jmp    8010662f <alltraps>

8010706a <vector107>:
.globl vector107
vector107:
  pushl $0
8010706a:	6a 00                	push   $0x0
  pushl $107
8010706c:	6a 6b                	push   $0x6b
  jmp alltraps
8010706e:	e9 bc f5 ff ff       	jmp    8010662f <alltraps>

80107073 <vector108>:
.globl vector108
vector108:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $108
80107075:	6a 6c                	push   $0x6c
  jmp alltraps
80107077:	e9 b3 f5 ff ff       	jmp    8010662f <alltraps>

8010707c <vector109>:
.globl vector109
vector109:
  pushl $0
8010707c:	6a 00                	push   $0x0
  pushl $109
8010707e:	6a 6d                	push   $0x6d
  jmp alltraps
80107080:	e9 aa f5 ff ff       	jmp    8010662f <alltraps>

80107085 <vector110>:
.globl vector110
vector110:
  pushl $0
80107085:	6a 00                	push   $0x0
  pushl $110
80107087:	6a 6e                	push   $0x6e
  jmp alltraps
80107089:	e9 a1 f5 ff ff       	jmp    8010662f <alltraps>

8010708e <vector111>:
.globl vector111
vector111:
  pushl $0
8010708e:	6a 00                	push   $0x0
  pushl $111
80107090:	6a 6f                	push   $0x6f
  jmp alltraps
80107092:	e9 98 f5 ff ff       	jmp    8010662f <alltraps>

80107097 <vector112>:
.globl vector112
vector112:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $112
80107099:	6a 70                	push   $0x70
  jmp alltraps
8010709b:	e9 8f f5 ff ff       	jmp    8010662f <alltraps>

801070a0 <vector113>:
.globl vector113
vector113:
  pushl $0
801070a0:	6a 00                	push   $0x0
  pushl $113
801070a2:	6a 71                	push   $0x71
  jmp alltraps
801070a4:	e9 86 f5 ff ff       	jmp    8010662f <alltraps>

801070a9 <vector114>:
.globl vector114
vector114:
  pushl $0
801070a9:	6a 00                	push   $0x0
  pushl $114
801070ab:	6a 72                	push   $0x72
  jmp alltraps
801070ad:	e9 7d f5 ff ff       	jmp    8010662f <alltraps>

801070b2 <vector115>:
.globl vector115
vector115:
  pushl $0
801070b2:	6a 00                	push   $0x0
  pushl $115
801070b4:	6a 73                	push   $0x73
  jmp alltraps
801070b6:	e9 74 f5 ff ff       	jmp    8010662f <alltraps>

801070bb <vector116>:
.globl vector116
vector116:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $116
801070bd:	6a 74                	push   $0x74
  jmp alltraps
801070bf:	e9 6b f5 ff ff       	jmp    8010662f <alltraps>

801070c4 <vector117>:
.globl vector117
vector117:
  pushl $0
801070c4:	6a 00                	push   $0x0
  pushl $117
801070c6:	6a 75                	push   $0x75
  jmp alltraps
801070c8:	e9 62 f5 ff ff       	jmp    8010662f <alltraps>

801070cd <vector118>:
.globl vector118
vector118:
  pushl $0
801070cd:	6a 00                	push   $0x0
  pushl $118
801070cf:	6a 76                	push   $0x76
  jmp alltraps
801070d1:	e9 59 f5 ff ff       	jmp    8010662f <alltraps>

801070d6 <vector119>:
.globl vector119
vector119:
  pushl $0
801070d6:	6a 00                	push   $0x0
  pushl $119
801070d8:	6a 77                	push   $0x77
  jmp alltraps
801070da:	e9 50 f5 ff ff       	jmp    8010662f <alltraps>

801070df <vector120>:
.globl vector120
vector120:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $120
801070e1:	6a 78                	push   $0x78
  jmp alltraps
801070e3:	e9 47 f5 ff ff       	jmp    8010662f <alltraps>

801070e8 <vector121>:
.globl vector121
vector121:
  pushl $0
801070e8:	6a 00                	push   $0x0
  pushl $121
801070ea:	6a 79                	push   $0x79
  jmp alltraps
801070ec:	e9 3e f5 ff ff       	jmp    8010662f <alltraps>

801070f1 <vector122>:
.globl vector122
vector122:
  pushl $0
801070f1:	6a 00                	push   $0x0
  pushl $122
801070f3:	6a 7a                	push   $0x7a
  jmp alltraps
801070f5:	e9 35 f5 ff ff       	jmp    8010662f <alltraps>

801070fa <vector123>:
.globl vector123
vector123:
  pushl $0
801070fa:	6a 00                	push   $0x0
  pushl $123
801070fc:	6a 7b                	push   $0x7b
  jmp alltraps
801070fe:	e9 2c f5 ff ff       	jmp    8010662f <alltraps>

80107103 <vector124>:
.globl vector124
vector124:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $124
80107105:	6a 7c                	push   $0x7c
  jmp alltraps
80107107:	e9 23 f5 ff ff       	jmp    8010662f <alltraps>

8010710c <vector125>:
.globl vector125
vector125:
  pushl $0
8010710c:	6a 00                	push   $0x0
  pushl $125
8010710e:	6a 7d                	push   $0x7d
  jmp alltraps
80107110:	e9 1a f5 ff ff       	jmp    8010662f <alltraps>

80107115 <vector126>:
.globl vector126
vector126:
  pushl $0
80107115:	6a 00                	push   $0x0
  pushl $126
80107117:	6a 7e                	push   $0x7e
  jmp alltraps
80107119:	e9 11 f5 ff ff       	jmp    8010662f <alltraps>

8010711e <vector127>:
.globl vector127
vector127:
  pushl $0
8010711e:	6a 00                	push   $0x0
  pushl $127
80107120:	6a 7f                	push   $0x7f
  jmp alltraps
80107122:	e9 08 f5 ff ff       	jmp    8010662f <alltraps>

80107127 <vector128>:
.globl vector128
vector128:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $128
80107129:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010712e:	e9 fc f4 ff ff       	jmp    8010662f <alltraps>

80107133 <vector129>:
.globl vector129
vector129:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $129
80107135:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010713a:	e9 f0 f4 ff ff       	jmp    8010662f <alltraps>

8010713f <vector130>:
.globl vector130
vector130:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $130
80107141:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107146:	e9 e4 f4 ff ff       	jmp    8010662f <alltraps>

8010714b <vector131>:
.globl vector131
vector131:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $131
8010714d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107152:	e9 d8 f4 ff ff       	jmp    8010662f <alltraps>

80107157 <vector132>:
.globl vector132
vector132:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $132
80107159:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010715e:	e9 cc f4 ff ff       	jmp    8010662f <alltraps>

80107163 <vector133>:
.globl vector133
vector133:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $133
80107165:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010716a:	e9 c0 f4 ff ff       	jmp    8010662f <alltraps>

8010716f <vector134>:
.globl vector134
vector134:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $134
80107171:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107176:	e9 b4 f4 ff ff       	jmp    8010662f <alltraps>

8010717b <vector135>:
.globl vector135
vector135:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $135
8010717d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107182:	e9 a8 f4 ff ff       	jmp    8010662f <alltraps>

80107187 <vector136>:
.globl vector136
vector136:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $136
80107189:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010718e:	e9 9c f4 ff ff       	jmp    8010662f <alltraps>

80107193 <vector137>:
.globl vector137
vector137:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $137
80107195:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010719a:	e9 90 f4 ff ff       	jmp    8010662f <alltraps>

8010719f <vector138>:
.globl vector138
vector138:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $138
801071a1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801071a6:	e9 84 f4 ff ff       	jmp    8010662f <alltraps>

801071ab <vector139>:
.globl vector139
vector139:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $139
801071ad:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801071b2:	e9 78 f4 ff ff       	jmp    8010662f <alltraps>

801071b7 <vector140>:
.globl vector140
vector140:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $140
801071b9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801071be:	e9 6c f4 ff ff       	jmp    8010662f <alltraps>

801071c3 <vector141>:
.globl vector141
vector141:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $141
801071c5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801071ca:	e9 60 f4 ff ff       	jmp    8010662f <alltraps>

801071cf <vector142>:
.globl vector142
vector142:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $142
801071d1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801071d6:	e9 54 f4 ff ff       	jmp    8010662f <alltraps>

801071db <vector143>:
.globl vector143
vector143:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $143
801071dd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801071e2:	e9 48 f4 ff ff       	jmp    8010662f <alltraps>

801071e7 <vector144>:
.globl vector144
vector144:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $144
801071e9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801071ee:	e9 3c f4 ff ff       	jmp    8010662f <alltraps>

801071f3 <vector145>:
.globl vector145
vector145:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $145
801071f5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801071fa:	e9 30 f4 ff ff       	jmp    8010662f <alltraps>

801071ff <vector146>:
.globl vector146
vector146:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $146
80107201:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107206:	e9 24 f4 ff ff       	jmp    8010662f <alltraps>

8010720b <vector147>:
.globl vector147
vector147:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $147
8010720d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107212:	e9 18 f4 ff ff       	jmp    8010662f <alltraps>

80107217 <vector148>:
.globl vector148
vector148:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $148
80107219:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010721e:	e9 0c f4 ff ff       	jmp    8010662f <alltraps>

80107223 <vector149>:
.globl vector149
vector149:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $149
80107225:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010722a:	e9 00 f4 ff ff       	jmp    8010662f <alltraps>

8010722f <vector150>:
.globl vector150
vector150:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $150
80107231:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107236:	e9 f4 f3 ff ff       	jmp    8010662f <alltraps>

8010723b <vector151>:
.globl vector151
vector151:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $151
8010723d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107242:	e9 e8 f3 ff ff       	jmp    8010662f <alltraps>

80107247 <vector152>:
.globl vector152
vector152:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $152
80107249:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010724e:	e9 dc f3 ff ff       	jmp    8010662f <alltraps>

80107253 <vector153>:
.globl vector153
vector153:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $153
80107255:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010725a:	e9 d0 f3 ff ff       	jmp    8010662f <alltraps>

8010725f <vector154>:
.globl vector154
vector154:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $154
80107261:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107266:	e9 c4 f3 ff ff       	jmp    8010662f <alltraps>

8010726b <vector155>:
.globl vector155
vector155:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $155
8010726d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107272:	e9 b8 f3 ff ff       	jmp    8010662f <alltraps>

80107277 <vector156>:
.globl vector156
vector156:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $156
80107279:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010727e:	e9 ac f3 ff ff       	jmp    8010662f <alltraps>

80107283 <vector157>:
.globl vector157
vector157:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $157
80107285:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010728a:	e9 a0 f3 ff ff       	jmp    8010662f <alltraps>

8010728f <vector158>:
.globl vector158
vector158:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $158
80107291:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107296:	e9 94 f3 ff ff       	jmp    8010662f <alltraps>

8010729b <vector159>:
.globl vector159
vector159:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $159
8010729d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801072a2:	e9 88 f3 ff ff       	jmp    8010662f <alltraps>

801072a7 <vector160>:
.globl vector160
vector160:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $160
801072a9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801072ae:	e9 7c f3 ff ff       	jmp    8010662f <alltraps>

801072b3 <vector161>:
.globl vector161
vector161:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $161
801072b5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801072ba:	e9 70 f3 ff ff       	jmp    8010662f <alltraps>

801072bf <vector162>:
.globl vector162
vector162:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $162
801072c1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801072c6:	e9 64 f3 ff ff       	jmp    8010662f <alltraps>

801072cb <vector163>:
.globl vector163
vector163:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $163
801072cd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801072d2:	e9 58 f3 ff ff       	jmp    8010662f <alltraps>

801072d7 <vector164>:
.globl vector164
vector164:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $164
801072d9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801072de:	e9 4c f3 ff ff       	jmp    8010662f <alltraps>

801072e3 <vector165>:
.globl vector165
vector165:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $165
801072e5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801072ea:	e9 40 f3 ff ff       	jmp    8010662f <alltraps>

801072ef <vector166>:
.globl vector166
vector166:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $166
801072f1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801072f6:	e9 34 f3 ff ff       	jmp    8010662f <alltraps>

801072fb <vector167>:
.globl vector167
vector167:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $167
801072fd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107302:	e9 28 f3 ff ff       	jmp    8010662f <alltraps>

80107307 <vector168>:
.globl vector168
vector168:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $168
80107309:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010730e:	e9 1c f3 ff ff       	jmp    8010662f <alltraps>

80107313 <vector169>:
.globl vector169
vector169:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $169
80107315:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010731a:	e9 10 f3 ff ff       	jmp    8010662f <alltraps>

8010731f <vector170>:
.globl vector170
vector170:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $170
80107321:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107326:	e9 04 f3 ff ff       	jmp    8010662f <alltraps>

8010732b <vector171>:
.globl vector171
vector171:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $171
8010732d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107332:	e9 f8 f2 ff ff       	jmp    8010662f <alltraps>

80107337 <vector172>:
.globl vector172
vector172:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $172
80107339:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010733e:	e9 ec f2 ff ff       	jmp    8010662f <alltraps>

80107343 <vector173>:
.globl vector173
vector173:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $173
80107345:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010734a:	e9 e0 f2 ff ff       	jmp    8010662f <alltraps>

8010734f <vector174>:
.globl vector174
vector174:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $174
80107351:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107356:	e9 d4 f2 ff ff       	jmp    8010662f <alltraps>

8010735b <vector175>:
.globl vector175
vector175:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $175
8010735d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107362:	e9 c8 f2 ff ff       	jmp    8010662f <alltraps>

80107367 <vector176>:
.globl vector176
vector176:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $176
80107369:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010736e:	e9 bc f2 ff ff       	jmp    8010662f <alltraps>

80107373 <vector177>:
.globl vector177
vector177:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $177
80107375:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010737a:	e9 b0 f2 ff ff       	jmp    8010662f <alltraps>

8010737f <vector178>:
.globl vector178
vector178:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $178
80107381:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107386:	e9 a4 f2 ff ff       	jmp    8010662f <alltraps>

8010738b <vector179>:
.globl vector179
vector179:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $179
8010738d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107392:	e9 98 f2 ff ff       	jmp    8010662f <alltraps>

80107397 <vector180>:
.globl vector180
vector180:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $180
80107399:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010739e:	e9 8c f2 ff ff       	jmp    8010662f <alltraps>

801073a3 <vector181>:
.globl vector181
vector181:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $181
801073a5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801073aa:	e9 80 f2 ff ff       	jmp    8010662f <alltraps>

801073af <vector182>:
.globl vector182
vector182:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $182
801073b1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801073b6:	e9 74 f2 ff ff       	jmp    8010662f <alltraps>

801073bb <vector183>:
.globl vector183
vector183:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $183
801073bd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801073c2:	e9 68 f2 ff ff       	jmp    8010662f <alltraps>

801073c7 <vector184>:
.globl vector184
vector184:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $184
801073c9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801073ce:	e9 5c f2 ff ff       	jmp    8010662f <alltraps>

801073d3 <vector185>:
.globl vector185
vector185:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $185
801073d5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801073da:	e9 50 f2 ff ff       	jmp    8010662f <alltraps>

801073df <vector186>:
.globl vector186
vector186:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $186
801073e1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801073e6:	e9 44 f2 ff ff       	jmp    8010662f <alltraps>

801073eb <vector187>:
.globl vector187
vector187:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $187
801073ed:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801073f2:	e9 38 f2 ff ff       	jmp    8010662f <alltraps>

801073f7 <vector188>:
.globl vector188
vector188:
  pushl $0
801073f7:	6a 00                	push   $0x0
  pushl $188
801073f9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801073fe:	e9 2c f2 ff ff       	jmp    8010662f <alltraps>

80107403 <vector189>:
.globl vector189
vector189:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $189
80107405:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010740a:	e9 20 f2 ff ff       	jmp    8010662f <alltraps>

8010740f <vector190>:
.globl vector190
vector190:
  pushl $0
8010740f:	6a 00                	push   $0x0
  pushl $190
80107411:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107416:	e9 14 f2 ff ff       	jmp    8010662f <alltraps>

8010741b <vector191>:
.globl vector191
vector191:
  pushl $0
8010741b:	6a 00                	push   $0x0
  pushl $191
8010741d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107422:	e9 08 f2 ff ff       	jmp    8010662f <alltraps>

80107427 <vector192>:
.globl vector192
vector192:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $192
80107429:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010742e:	e9 fc f1 ff ff       	jmp    8010662f <alltraps>

80107433 <vector193>:
.globl vector193
vector193:
  pushl $0
80107433:	6a 00                	push   $0x0
  pushl $193
80107435:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010743a:	e9 f0 f1 ff ff       	jmp    8010662f <alltraps>

8010743f <vector194>:
.globl vector194
vector194:
  pushl $0
8010743f:	6a 00                	push   $0x0
  pushl $194
80107441:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107446:	e9 e4 f1 ff ff       	jmp    8010662f <alltraps>

8010744b <vector195>:
.globl vector195
vector195:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $195
8010744d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107452:	e9 d8 f1 ff ff       	jmp    8010662f <alltraps>

80107457 <vector196>:
.globl vector196
vector196:
  pushl $0
80107457:	6a 00                	push   $0x0
  pushl $196
80107459:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010745e:	e9 cc f1 ff ff       	jmp    8010662f <alltraps>

80107463 <vector197>:
.globl vector197
vector197:
  pushl $0
80107463:	6a 00                	push   $0x0
  pushl $197
80107465:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010746a:	e9 c0 f1 ff ff       	jmp    8010662f <alltraps>

8010746f <vector198>:
.globl vector198
vector198:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $198
80107471:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107476:	e9 b4 f1 ff ff       	jmp    8010662f <alltraps>

8010747b <vector199>:
.globl vector199
vector199:
  pushl $0
8010747b:	6a 00                	push   $0x0
  pushl $199
8010747d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107482:	e9 a8 f1 ff ff       	jmp    8010662f <alltraps>

80107487 <vector200>:
.globl vector200
vector200:
  pushl $0
80107487:	6a 00                	push   $0x0
  pushl $200
80107489:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010748e:	e9 9c f1 ff ff       	jmp    8010662f <alltraps>

80107493 <vector201>:
.globl vector201
vector201:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $201
80107495:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010749a:	e9 90 f1 ff ff       	jmp    8010662f <alltraps>

8010749f <vector202>:
.globl vector202
vector202:
  pushl $0
8010749f:	6a 00                	push   $0x0
  pushl $202
801074a1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801074a6:	e9 84 f1 ff ff       	jmp    8010662f <alltraps>

801074ab <vector203>:
.globl vector203
vector203:
  pushl $0
801074ab:	6a 00                	push   $0x0
  pushl $203
801074ad:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801074b2:	e9 78 f1 ff ff       	jmp    8010662f <alltraps>

801074b7 <vector204>:
.globl vector204
vector204:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $204
801074b9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801074be:	e9 6c f1 ff ff       	jmp    8010662f <alltraps>

801074c3 <vector205>:
.globl vector205
vector205:
  pushl $0
801074c3:	6a 00                	push   $0x0
  pushl $205
801074c5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801074ca:	e9 60 f1 ff ff       	jmp    8010662f <alltraps>

801074cf <vector206>:
.globl vector206
vector206:
  pushl $0
801074cf:	6a 00                	push   $0x0
  pushl $206
801074d1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801074d6:	e9 54 f1 ff ff       	jmp    8010662f <alltraps>

801074db <vector207>:
.globl vector207
vector207:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $207
801074dd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801074e2:	e9 48 f1 ff ff       	jmp    8010662f <alltraps>

801074e7 <vector208>:
.globl vector208
vector208:
  pushl $0
801074e7:	6a 00                	push   $0x0
  pushl $208
801074e9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801074ee:	e9 3c f1 ff ff       	jmp    8010662f <alltraps>

801074f3 <vector209>:
.globl vector209
vector209:
  pushl $0
801074f3:	6a 00                	push   $0x0
  pushl $209
801074f5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801074fa:	e9 30 f1 ff ff       	jmp    8010662f <alltraps>

801074ff <vector210>:
.globl vector210
vector210:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $210
80107501:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107506:	e9 24 f1 ff ff       	jmp    8010662f <alltraps>

8010750b <vector211>:
.globl vector211
vector211:
  pushl $0
8010750b:	6a 00                	push   $0x0
  pushl $211
8010750d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107512:	e9 18 f1 ff ff       	jmp    8010662f <alltraps>

80107517 <vector212>:
.globl vector212
vector212:
  pushl $0
80107517:	6a 00                	push   $0x0
  pushl $212
80107519:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010751e:	e9 0c f1 ff ff       	jmp    8010662f <alltraps>

80107523 <vector213>:
.globl vector213
vector213:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $213
80107525:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010752a:	e9 00 f1 ff ff       	jmp    8010662f <alltraps>

8010752f <vector214>:
.globl vector214
vector214:
  pushl $0
8010752f:	6a 00                	push   $0x0
  pushl $214
80107531:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107536:	e9 f4 f0 ff ff       	jmp    8010662f <alltraps>

8010753b <vector215>:
.globl vector215
vector215:
  pushl $0
8010753b:	6a 00                	push   $0x0
  pushl $215
8010753d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107542:	e9 e8 f0 ff ff       	jmp    8010662f <alltraps>

80107547 <vector216>:
.globl vector216
vector216:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $216
80107549:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010754e:	e9 dc f0 ff ff       	jmp    8010662f <alltraps>

80107553 <vector217>:
.globl vector217
vector217:
  pushl $0
80107553:	6a 00                	push   $0x0
  pushl $217
80107555:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010755a:	e9 d0 f0 ff ff       	jmp    8010662f <alltraps>

8010755f <vector218>:
.globl vector218
vector218:
  pushl $0
8010755f:	6a 00                	push   $0x0
  pushl $218
80107561:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107566:	e9 c4 f0 ff ff       	jmp    8010662f <alltraps>

8010756b <vector219>:
.globl vector219
vector219:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $219
8010756d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107572:	e9 b8 f0 ff ff       	jmp    8010662f <alltraps>

80107577 <vector220>:
.globl vector220
vector220:
  pushl $0
80107577:	6a 00                	push   $0x0
  pushl $220
80107579:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010757e:	e9 ac f0 ff ff       	jmp    8010662f <alltraps>

80107583 <vector221>:
.globl vector221
vector221:
  pushl $0
80107583:	6a 00                	push   $0x0
  pushl $221
80107585:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010758a:	e9 a0 f0 ff ff       	jmp    8010662f <alltraps>

8010758f <vector222>:
.globl vector222
vector222:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $222
80107591:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107596:	e9 94 f0 ff ff       	jmp    8010662f <alltraps>

8010759b <vector223>:
.globl vector223
vector223:
  pushl $0
8010759b:	6a 00                	push   $0x0
  pushl $223
8010759d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801075a2:	e9 88 f0 ff ff       	jmp    8010662f <alltraps>

801075a7 <vector224>:
.globl vector224
vector224:
  pushl $0
801075a7:	6a 00                	push   $0x0
  pushl $224
801075a9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801075ae:	e9 7c f0 ff ff       	jmp    8010662f <alltraps>

801075b3 <vector225>:
.globl vector225
vector225:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $225
801075b5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801075ba:	e9 70 f0 ff ff       	jmp    8010662f <alltraps>

801075bf <vector226>:
.globl vector226
vector226:
  pushl $0
801075bf:	6a 00                	push   $0x0
  pushl $226
801075c1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801075c6:	e9 64 f0 ff ff       	jmp    8010662f <alltraps>

801075cb <vector227>:
.globl vector227
vector227:
  pushl $0
801075cb:	6a 00                	push   $0x0
  pushl $227
801075cd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801075d2:	e9 58 f0 ff ff       	jmp    8010662f <alltraps>

801075d7 <vector228>:
.globl vector228
vector228:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $228
801075d9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801075de:	e9 4c f0 ff ff       	jmp    8010662f <alltraps>

801075e3 <vector229>:
.globl vector229
vector229:
  pushl $0
801075e3:	6a 00                	push   $0x0
  pushl $229
801075e5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801075ea:	e9 40 f0 ff ff       	jmp    8010662f <alltraps>

801075ef <vector230>:
.globl vector230
vector230:
  pushl $0
801075ef:	6a 00                	push   $0x0
  pushl $230
801075f1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801075f6:	e9 34 f0 ff ff       	jmp    8010662f <alltraps>

801075fb <vector231>:
.globl vector231
vector231:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $231
801075fd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107602:	e9 28 f0 ff ff       	jmp    8010662f <alltraps>

80107607 <vector232>:
.globl vector232
vector232:
  pushl $0
80107607:	6a 00                	push   $0x0
  pushl $232
80107609:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010760e:	e9 1c f0 ff ff       	jmp    8010662f <alltraps>

80107613 <vector233>:
.globl vector233
vector233:
  pushl $0
80107613:	6a 00                	push   $0x0
  pushl $233
80107615:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010761a:	e9 10 f0 ff ff       	jmp    8010662f <alltraps>

8010761f <vector234>:
.globl vector234
vector234:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $234
80107621:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107626:	e9 04 f0 ff ff       	jmp    8010662f <alltraps>

8010762b <vector235>:
.globl vector235
vector235:
  pushl $0
8010762b:	6a 00                	push   $0x0
  pushl $235
8010762d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107632:	e9 f8 ef ff ff       	jmp    8010662f <alltraps>

80107637 <vector236>:
.globl vector236
vector236:
  pushl $0
80107637:	6a 00                	push   $0x0
  pushl $236
80107639:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010763e:	e9 ec ef ff ff       	jmp    8010662f <alltraps>

80107643 <vector237>:
.globl vector237
vector237:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $237
80107645:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010764a:	e9 e0 ef ff ff       	jmp    8010662f <alltraps>

8010764f <vector238>:
.globl vector238
vector238:
  pushl $0
8010764f:	6a 00                	push   $0x0
  pushl $238
80107651:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107656:	e9 d4 ef ff ff       	jmp    8010662f <alltraps>

8010765b <vector239>:
.globl vector239
vector239:
  pushl $0
8010765b:	6a 00                	push   $0x0
  pushl $239
8010765d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107662:	e9 c8 ef ff ff       	jmp    8010662f <alltraps>

80107667 <vector240>:
.globl vector240
vector240:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $240
80107669:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010766e:	e9 bc ef ff ff       	jmp    8010662f <alltraps>

80107673 <vector241>:
.globl vector241
vector241:
  pushl $0
80107673:	6a 00                	push   $0x0
  pushl $241
80107675:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010767a:	e9 b0 ef ff ff       	jmp    8010662f <alltraps>

8010767f <vector242>:
.globl vector242
vector242:
  pushl $0
8010767f:	6a 00                	push   $0x0
  pushl $242
80107681:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107686:	e9 a4 ef ff ff       	jmp    8010662f <alltraps>

8010768b <vector243>:
.globl vector243
vector243:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $243
8010768d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107692:	e9 98 ef ff ff       	jmp    8010662f <alltraps>

80107697 <vector244>:
.globl vector244
vector244:
  pushl $0
80107697:	6a 00                	push   $0x0
  pushl $244
80107699:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010769e:	e9 8c ef ff ff       	jmp    8010662f <alltraps>

801076a3 <vector245>:
.globl vector245
vector245:
  pushl $0
801076a3:	6a 00                	push   $0x0
  pushl $245
801076a5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801076aa:	e9 80 ef ff ff       	jmp    8010662f <alltraps>

801076af <vector246>:
.globl vector246
vector246:
  pushl $0
801076af:	6a 00                	push   $0x0
  pushl $246
801076b1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801076b6:	e9 74 ef ff ff       	jmp    8010662f <alltraps>

801076bb <vector247>:
.globl vector247
vector247:
  pushl $0
801076bb:	6a 00                	push   $0x0
  pushl $247
801076bd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801076c2:	e9 68 ef ff ff       	jmp    8010662f <alltraps>

801076c7 <vector248>:
.globl vector248
vector248:
  pushl $0
801076c7:	6a 00                	push   $0x0
  pushl $248
801076c9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801076ce:	e9 5c ef ff ff       	jmp    8010662f <alltraps>

801076d3 <vector249>:
.globl vector249
vector249:
  pushl $0
801076d3:	6a 00                	push   $0x0
  pushl $249
801076d5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801076da:	e9 50 ef ff ff       	jmp    8010662f <alltraps>

801076df <vector250>:
.globl vector250
vector250:
  pushl $0
801076df:	6a 00                	push   $0x0
  pushl $250
801076e1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801076e6:	e9 44 ef ff ff       	jmp    8010662f <alltraps>

801076eb <vector251>:
.globl vector251
vector251:
  pushl $0
801076eb:	6a 00                	push   $0x0
  pushl $251
801076ed:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801076f2:	e9 38 ef ff ff       	jmp    8010662f <alltraps>

801076f7 <vector252>:
.globl vector252
vector252:
  pushl $0
801076f7:	6a 00                	push   $0x0
  pushl $252
801076f9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801076fe:	e9 2c ef ff ff       	jmp    8010662f <alltraps>

80107703 <vector253>:
.globl vector253
vector253:
  pushl $0
80107703:	6a 00                	push   $0x0
  pushl $253
80107705:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010770a:	e9 20 ef ff ff       	jmp    8010662f <alltraps>

8010770f <vector254>:
.globl vector254
vector254:
  pushl $0
8010770f:	6a 00                	push   $0x0
  pushl $254
80107711:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107716:	e9 14 ef ff ff       	jmp    8010662f <alltraps>

8010771b <vector255>:
.globl vector255
vector255:
  pushl $0
8010771b:	6a 00                	push   $0x0
  pushl $255
8010771d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107722:	e9 08 ef ff ff       	jmp    8010662f <alltraps>
80107727:	66 90                	xchg   %ax,%ax
80107729:	66 90                	xchg   %ax,%ax
8010772b:	66 90                	xchg   %ax,%ax
8010772d:	66 90                	xchg   %ax,%ax
8010772f:	90                   	nop

80107730 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107730:	55                   	push   %ebp
80107731:	89 e5                	mov    %esp,%ebp
80107733:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107736:	e8 c5 c9 ff ff       	call   80104100 <cpuid>
8010773b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107741:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107746:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010774a:	c7 80 18 c8 14 80 ff 	movl   $0xffff,-0x7feb37e8(%eax)
80107751:	ff 00 00 
80107754:	c7 80 1c c8 14 80 00 	movl   $0xcf9a00,-0x7feb37e4(%eax)
8010775b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010775e:	c7 80 20 c8 14 80 ff 	movl   $0xffff,-0x7feb37e0(%eax)
80107765:	ff 00 00 
80107768:	c7 80 24 c8 14 80 00 	movl   $0xcf9200,-0x7feb37dc(%eax)
8010776f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107772:	c7 80 28 c8 14 80 ff 	movl   $0xffff,-0x7feb37d8(%eax)
80107779:	ff 00 00 
8010777c:	c7 80 2c c8 14 80 00 	movl   $0xcffa00,-0x7feb37d4(%eax)
80107783:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107786:	c7 80 30 c8 14 80 ff 	movl   $0xffff,-0x7feb37d0(%eax)
8010778d:	ff 00 00 
80107790:	c7 80 34 c8 14 80 00 	movl   $0xcff200,-0x7feb37cc(%eax)
80107797:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010779a:	05 10 c8 14 80       	add    $0x8014c810,%eax
  pd[1] = (uint)p;
8010779f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801077a3:	c1 e8 10             	shr    $0x10,%eax
801077a6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801077aa:	8d 45 f2             	lea    -0xe(%ebp),%eax
801077ad:	0f 01 10             	lgdtl  (%eax)
}
801077b0:	c9                   	leave  
801077b1:	c3                   	ret    
801077b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077c0 <nonStaticWalkpgdir>:

#ifndef NONE
pte_t*
nonStaticWalkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801077c0:	55                   	push   %ebp
801077c1:	89 e5                	mov    %esp,%ebp
801077c3:	57                   	push   %edi
801077c4:	56                   	push   %esi
801077c5:	53                   	push   %ebx
801077c6:	83 ec 0c             	sub    $0xc,%esp
801077c9:	8b 7d 0c             	mov    0xc(%ebp),%edi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801077cc:	8b 55 08             	mov    0x8(%ebp),%edx
801077cf:	89 fe                	mov    %edi,%esi
801077d1:	c1 ee 16             	shr    $0x16,%esi
801077d4:	8d 34 b2             	lea    (%edx,%esi,4),%esi
  if(*pde & PTE_P){
801077d7:	8b 1e                	mov    (%esi),%ebx
801077d9:	f6 c3 01             	test   $0x1,%bl
801077dc:	74 22                	je     80107800 <nonStaticWalkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077de:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801077e4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801077ea:	89 f8                	mov    %edi,%eax
}
801077ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801077ef:	c1 e8 0a             	shr    $0xa,%eax
801077f2:	25 fc 0f 00 00       	and    $0xffc,%eax
801077f7:	01 d8                	add    %ebx,%eax
}
801077f9:	5b                   	pop    %ebx
801077fa:	5e                   	pop    %esi
801077fb:	5f                   	pop    %edi
801077fc:	5d                   	pop    %ebp
801077fd:	c3                   	ret    
801077fe:	66 90                	xchg   %ax,%ax
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107800:	8b 45 10             	mov    0x10(%ebp),%eax
80107803:	85 c0                	test   %eax,%eax
80107805:	74 31                	je     80107838 <nonStaticWalkpgdir+0x78>
80107807:	e8 64 b3 ff ff       	call   80102b70 <kalloc>
8010780c:	85 c0                	test   %eax,%eax
8010780e:	89 c3                	mov    %eax,%ebx
80107810:	74 26                	je     80107838 <nonStaticWalkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80107812:	83 ec 04             	sub    $0x4,%esp
80107815:	68 00 10 00 00       	push   $0x1000
8010781a:	6a 00                	push   $0x0
8010781c:	50                   	push   %eax
8010781d:	e8 8e db ff ff       	call   801053b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107822:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107828:	83 c4 10             	add    $0x10,%esp
8010782b:	83 c8 07             	or     $0x7,%eax
8010782e:	89 06                	mov    %eax,(%esi)
80107830:	eb b8                	jmp    801077ea <nonStaticWalkpgdir+0x2a>
80107832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80107838:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
8010783b:	31 c0                	xor    %eax,%eax
}
8010783d:	5b                   	pop    %ebx
8010783e:	5e                   	pop    %esi
8010783f:	5f                   	pop    %edi
80107840:	5d                   	pop    %ebp
80107841:	c3                   	ret    
80107842:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107850 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107850:	55                   	push   %ebp
80107851:	89 e5                	mov    %esp,%ebp
80107853:	57                   	push   %edi
80107854:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107856:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010785a:	56                   	push   %esi
8010785b:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
8010785c:	89 d6                	mov    %edx,%esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010785e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
{
80107863:	83 ec 1c             	sub    $0x1c,%esp
  a = (char*)PGROUNDDOWN((uint)va);
80107866:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010786c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010786f:	8b 45 08             	mov    0x8(%ebp),%eax
80107872:	29 f0                	sub    %esi,%eax
80107874:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107877:	8b 45 0c             	mov    0xc(%ebp),%eax
8010787a:	83 c8 01             	or     $0x1,%eax
8010787d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107880:	eb 1b                	jmp    8010789d <mappages+0x4d>
80107882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
80107888:	f6 00 01             	testb  $0x1,(%eax)
8010788b:	75 45                	jne    801078d2 <mappages+0x82>
    *pte = pa | perm | PTE_P;
8010788d:	0b 5d dc             	or     -0x24(%ebp),%ebx
    if(a == last)
80107890:	3b 75 e0             	cmp    -0x20(%ebp),%esi
    *pte = pa | perm | PTE_P;
80107893:	89 18                	mov    %ebx,(%eax)
    if(a == last)
80107895:	74 31                	je     801078c8 <mappages+0x78>
      break;
    a += PGSIZE;
80107897:	81 c6 00 10 00 00    	add    $0x1000,%esi
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010789d:	83 ec 04             	sub    $0x4,%esp
801078a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078a3:	6a 01                	push   $0x1
801078a5:	56                   	push   %esi
801078a6:	57                   	push   %edi
801078a7:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
801078aa:	e8 11 ff ff ff       	call   801077c0 <nonStaticWalkpgdir>
801078af:	83 c4 10             	add    $0x10,%esp
801078b2:	85 c0                	test   %eax,%eax
801078b4:	75 d2                	jne    80107888 <mappages+0x38>
    pa += PGSIZE;
  }
  return 0;
}
801078b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078be:	5b                   	pop    %ebx
801078bf:	5e                   	pop    %esi
801078c0:	5f                   	pop    %edi
801078c1:	5d                   	pop    %ebp
801078c2:	c3                   	ret    
801078c3:	90                   	nop
801078c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801078c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078cb:	31 c0                	xor    %eax,%eax
}
801078cd:	5b                   	pop    %ebx
801078ce:	5e                   	pop    %esi
801078cf:	5f                   	pop    %edi
801078d0:	5d                   	pop    %ebp
801078d1:	c3                   	ret    
      panic("remap");
801078d2:	83 ec 0c             	sub    $0xc,%esp
801078d5:	68 48 94 10 80       	push   $0x80109448
801078da:	e8 b1 8a ff ff       	call   80100390 <panic>
801078df:	90                   	nop

801078e0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801078e0:	a1 c4 9b 15 80       	mov    0x80159bc4,%eax
{
801078e5:	55                   	push   %ebp
801078e6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801078e8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801078ed:	0f 22 d8             	mov    %eax,%cr3
}
801078f0:	5d                   	pop    %ebp
801078f1:	c3                   	ret    
801078f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107900 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107900:	55                   	push   %ebp
80107901:	89 e5                	mov    %esp,%ebp
80107903:	57                   	push   %edi
80107904:	56                   	push   %esi
80107905:	53                   	push   %ebx
80107906:	83 ec 1c             	sub    $0x1c,%esp
80107909:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010790c:	85 db                	test   %ebx,%ebx
8010790e:	0f 84 cb 00 00 00    	je     801079df <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107914:	8b 43 08             	mov    0x8(%ebx),%eax
80107917:	85 c0                	test   %eax,%eax
80107919:	0f 84 da 00 00 00    	je     801079f9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010791f:	8b 43 04             	mov    0x4(%ebx),%eax
80107922:	85 c0                	test   %eax,%eax
80107924:	0f 84 c2 00 00 00    	je     801079ec <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
8010792a:	e8 a1 d8 ff ff       	call   801051d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010792f:	e8 4c c7 ff ff       	call   80104080 <mycpu>
80107934:	89 c6                	mov    %eax,%esi
80107936:	e8 45 c7 ff ff       	call   80104080 <mycpu>
8010793b:	89 c7                	mov    %eax,%edi
8010793d:	e8 3e c7 ff ff       	call   80104080 <mycpu>
80107942:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107945:	83 c7 08             	add    $0x8,%edi
80107948:	e8 33 c7 ff ff       	call   80104080 <mycpu>
8010794d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107950:	83 c0 08             	add    $0x8,%eax
80107953:	ba 67 00 00 00       	mov    $0x67,%edx
80107958:	c1 e8 18             	shr    $0x18,%eax
8010795b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107962:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107969:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010796f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107974:	83 c1 08             	add    $0x8,%ecx
80107977:	c1 e9 10             	shr    $0x10,%ecx
8010797a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107980:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107985:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010798c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107991:	e8 ea c6 ff ff       	call   80104080 <mycpu>
80107996:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010799d:	e8 de c6 ff ff       	call   80104080 <mycpu>
801079a2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801079a6:	8b 73 08             	mov    0x8(%ebx),%esi
801079a9:	e8 d2 c6 ff ff       	call   80104080 <mycpu>
801079ae:	81 c6 00 10 00 00    	add    $0x1000,%esi
801079b4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801079b7:	e8 c4 c6 ff ff       	call   80104080 <mycpu>
801079bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801079c0:	b8 28 00 00 00       	mov    $0x28,%eax
801079c5:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801079c8:	8b 43 04             	mov    0x4(%ebx),%eax
801079cb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801079d0:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801079d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d6:	5b                   	pop    %ebx
801079d7:	5e                   	pop    %esi
801079d8:	5f                   	pop    %edi
801079d9:	5d                   	pop    %ebp
  popcli();
801079da:	e9 31 d8 ff ff       	jmp    80105210 <popcli>
    panic("switchuvm: no process");
801079df:	83 ec 0c             	sub    $0xc,%esp
801079e2:	68 4e 94 10 80       	push   $0x8010944e
801079e7:	e8 a4 89 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801079ec:	83 ec 0c             	sub    $0xc,%esp
801079ef:	68 79 94 10 80       	push   $0x80109479
801079f4:	e8 97 89 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801079f9:	83 ec 0c             	sub    $0xc,%esp
801079fc:	68 64 94 10 80       	push   $0x80109464
80107a01:	e8 8a 89 ff ff       	call   80100390 <panic>
80107a06:	8d 76 00             	lea    0x0(%esi),%esi
80107a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a10 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107a10:	55                   	push   %ebp
80107a11:	89 e5                	mov    %esp,%ebp
80107a13:	57                   	push   %edi
80107a14:	56                   	push   %esi
80107a15:	53                   	push   %ebx
80107a16:	83 ec 1c             	sub    $0x1c,%esp
80107a19:	8b 75 10             	mov    0x10(%ebp),%esi
80107a1c:	8b 45 08             	mov    0x8(%ebp),%eax
80107a1f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107a22:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107a28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107a2b:	77 49                	ja     80107a76 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80107a2d:	e8 3e b1 ff ff       	call   80102b70 <kalloc>
  memset(mem, 0, PGSIZE);
80107a32:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107a35:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107a37:	68 00 10 00 00       	push   $0x1000
80107a3c:	6a 00                	push   $0x0
80107a3e:	50                   	push   %eax
80107a3f:	e8 6c d9 ff ff       	call   801053b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107a44:	58                   	pop    %eax
80107a45:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a4b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a50:	5a                   	pop    %edx
80107a51:	6a 06                	push   $0x6
80107a53:	50                   	push   %eax
80107a54:	31 d2                	xor    %edx,%edx
80107a56:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a59:	e8 f2 fd ff ff       	call   80107850 <mappages>
  memmove(mem, init, sz);
80107a5e:	89 75 10             	mov    %esi,0x10(%ebp)
80107a61:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107a64:	83 c4 10             	add    $0x10,%esp
80107a67:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107a6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a6d:	5b                   	pop    %ebx
80107a6e:	5e                   	pop    %esi
80107a6f:	5f                   	pop    %edi
80107a70:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107a71:	e9 ea d9 ff ff       	jmp    80105460 <memmove>
    panic("inituvm: more than a page");
80107a76:	83 ec 0c             	sub    $0xc,%esp
80107a79:	68 8d 94 10 80       	push   $0x8010948d
80107a7e:	e8 0d 89 ff ff       	call   80100390 <panic>
80107a83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a90 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107a90:	55                   	push   %ebp
80107a91:	89 e5                	mov    %esp,%ebp
80107a93:	57                   	push   %edi
80107a94:	56                   	push   %esi
80107a95:	53                   	push   %ebx
80107a96:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107a99:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107aa0:	0f 85 99 00 00 00    	jne    80107b3f <loaduvm+0xaf>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107aa6:	8b 5d 18             	mov    0x18(%ebp),%ebx
80107aa9:	31 ff                	xor    %edi,%edi
80107aab:	85 db                	test   %ebx,%ebx
80107aad:	75 1a                	jne    80107ac9 <loaduvm+0x39>
80107aaf:	eb 77                	jmp    80107b28 <loaduvm+0x98>
80107ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ab8:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107abe:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107ac4:	39 7d 18             	cmp    %edi,0x18(%ebp)
80107ac7:	76 5f                	jbe    80107b28 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107ac9:	8b 45 0c             	mov    0xc(%ebp),%eax
80107acc:	83 ec 04             	sub    $0x4,%esp
80107acf:	6a 00                	push   $0x0
80107ad1:	01 f8                	add    %edi,%eax
80107ad3:	50                   	push   %eax
80107ad4:	ff 75 08             	pushl  0x8(%ebp)
80107ad7:	e8 e4 fc ff ff       	call   801077c0 <nonStaticWalkpgdir>
80107adc:	83 c4 10             	add    $0x10,%esp
80107adf:	85 c0                	test   %eax,%eax
80107ae1:	74 4f                	je     80107b32 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80107ae3:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107ae5:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107ae8:	be 00 10 00 00       	mov    $0x1000,%esi
    pa = PTE_ADDR(*pte);
80107aed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107af2:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107af8:	0f 46 f3             	cmovbe %ebx,%esi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107afb:	01 f9                	add    %edi,%ecx
80107afd:	05 00 00 00 80       	add    $0x80000000,%eax
80107b02:	56                   	push   %esi
80107b03:	51                   	push   %ecx
80107b04:	50                   	push   %eax
80107b05:	ff 75 10             	pushl  0x10(%ebp)
80107b08:	e8 63 a0 ff ff       	call   80101b70 <readi>
80107b0d:	83 c4 10             	add    $0x10,%esp
80107b10:	39 f0                	cmp    %esi,%eax
80107b12:	74 a4                	je     80107ab8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80107b14:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107b17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107b1c:	5b                   	pop    %ebx
80107b1d:	5e                   	pop    %esi
80107b1e:	5f                   	pop    %edi
80107b1f:	5d                   	pop    %ebp
80107b20:	c3                   	ret    
80107b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107b2b:	31 c0                	xor    %eax,%eax
}
80107b2d:	5b                   	pop    %ebx
80107b2e:	5e                   	pop    %esi
80107b2f:	5f                   	pop    %edi
80107b30:	5d                   	pop    %ebp
80107b31:	c3                   	ret    
      panic("loaduvm: address should exist");
80107b32:	83 ec 0c             	sub    $0xc,%esp
80107b35:	68 a7 94 10 80       	push   $0x801094a7
80107b3a:	e8 51 88 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107b3f:	83 ec 0c             	sub    $0xc,%esp
80107b42:	68 90 95 10 80       	push   $0x80109590
80107b47:	e8 44 88 ff ff       	call   80100390 <panic>
80107b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107b50 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b56:	6a 00                	push   $0x0
80107b58:	ff 75 0c             	pushl  0xc(%ebp)
80107b5b:	ff 75 08             	pushl  0x8(%ebp)
80107b5e:	e8 5d fc ff ff       	call   801077c0 <nonStaticWalkpgdir>
  if(pte == 0)
80107b63:	83 c4 10             	add    $0x10,%esp
80107b66:	85 c0                	test   %eax,%eax
80107b68:	74 05                	je     80107b6f <clearpteu+0x1f>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107b6a:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107b6d:	c9                   	leave  
80107b6e:	c3                   	ret    
    panic("clearpteu");
80107b6f:	83 ec 0c             	sub    $0xc,%esp
80107b72:	68 c5 94 10 80       	push   $0x801094c5
80107b77:	e8 14 88 ff ff       	call   80100390 <panic>
80107b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107b80 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107b80:	55                   	push   %ebp
80107b81:	89 e5                	mov    %esp,%ebp
80107b83:	83 ec 0c             	sub    $0xc,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b86:	6a 00                	push   $0x0
80107b88:	ff 75 0c             	pushl  0xc(%ebp)
80107b8b:	ff 75 08             	pushl  0x8(%ebp)
80107b8e:	e8 2d fc ff ff       	call   801077c0 <nonStaticWalkpgdir>
  if((*pte & PTE_P) == 0)
80107b93:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107b95:	83 c4 10             	add    $0x10,%esp
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b98:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107b99:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107ba0:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ba3:	05 00 00 00 80       	add    $0x80000000,%eax
80107ba8:	83 fa 05             	cmp    $0x5,%edx
80107bab:	ba 00 00 00 00       	mov    $0x0,%edx
80107bb0:	0f 45 c2             	cmovne %edx,%eax
}
80107bb3:	c3                   	ret    
80107bb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107bba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107bc0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	57                   	push   %edi
80107bc4:	56                   	push   %esi
80107bc5:	53                   	push   %ebx
80107bc6:	83 ec 1c             	sub    $0x1c,%esp
80107bc9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107bcc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bcf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107bd2:	85 db                	test   %ebx,%ebx
80107bd4:	75 40                	jne    80107c16 <copyout+0x56>
80107bd6:	eb 70                	jmp    80107c48 <copyout+0x88>
80107bd8:	90                   	nop
80107bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107be0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107be3:	89 f1                	mov    %esi,%ecx
80107be5:	29 d1                	sub    %edx,%ecx
80107be7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107bed:	39 d9                	cmp    %ebx,%ecx
80107bef:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107bf2:	29 f2                	sub    %esi,%edx
80107bf4:	83 ec 04             	sub    $0x4,%esp
80107bf7:	01 d0                	add    %edx,%eax
80107bf9:	51                   	push   %ecx
80107bfa:	57                   	push   %edi
80107bfb:	50                   	push   %eax
80107bfc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107bff:	e8 5c d8 ff ff       	call   80105460 <memmove>
    len -= n;
    buf += n;
80107c04:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107c07:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107c0a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107c10:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107c12:	29 cb                	sub    %ecx,%ebx
80107c14:	74 32                	je     80107c48 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107c16:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c18:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107c1b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107c1e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107c24:	56                   	push   %esi
80107c25:	ff 75 08             	pushl  0x8(%ebp)
80107c28:	e8 53 ff ff ff       	call   80107b80 <uva2ka>
    if(pa0 == 0)
80107c2d:	83 c4 10             	add    $0x10,%esp
80107c30:	85 c0                	test   %eax,%eax
80107c32:	75 ac                	jne    80107be0 <copyout+0x20>
  }
  return 0;
}
80107c34:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107c3c:	5b                   	pop    %ebx
80107c3d:	5e                   	pop    %esi
80107c3e:	5f                   	pop    %edi
80107c3f:	5d                   	pop    %ebp
80107c40:	c3                   	ret    
80107c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c48:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107c4b:	31 c0                	xor    %eax,%eax
}
80107c4d:	5b                   	pop    %ebx
80107c4e:	5e                   	pop    %esi
80107c4f:	5f                   	pop    %edi
80107c50:	5d                   	pop    %ebp
80107c51:	c3                   	ret    
80107c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c60 <nfuaLeastAgeIndex>:
  }
  return indexInPhysicalMem((uint)page->va);
}

int
nfuaLeastAgeIndex(){/**********************************************************************************      NFUA       *********/
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	57                   	push   %edi
80107c64:	56                   	push   %esi
80107c65:	53                   	push   %ebx
80107c66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107c69:	e8 b2 c4 ff ff       	call   80104120 <myproc>
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
80107c6e:	8b b8 80 00 00 00    	mov    0x80(%eax),%edi
80107c74:	85 ff                	test   %edi,%edi
80107c76:	7e 3f                	jle    80107cb7 <nfuaLeastAgeIndex+0x57>
80107c78:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
80107c7e:	31 c9                	xor    %ecx,%ecx
  int leastIndex = -1;
80107c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint leastAge = __UINT32_MAX__;
80107c85:	be ff ff ff ff       	mov    $0xffffffff,%esi
80107c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
80107c90:	8b 5a 04             	mov    0x4(%edx),%ebx
80107c93:	39 f3                	cmp    %esi,%ebx
80107c95:	77 09                	ja     80107ca0 <nfuaLeastAgeIndex+0x40>
80107c97:	83 3a ff             	cmpl   $0xffffffff,(%edx)
80107c9a:	0f 45 c1             	cmovne %ecx,%eax
80107c9d:	0f 45 f3             	cmovne %ebx,%esi
  for(i = 0; i < p->nPgsPhysical ; i++){
80107ca0:	83 c1 01             	add    $0x1,%ecx
80107ca3:	83 c2 14             	add    $0x14,%edx
80107ca6:	39 f9                	cmp    %edi,%ecx
80107ca8:	75 e6                	jne    80107c90 <nfuaLeastAgeIndex+0x30>
      leastIndex = i;
      leastAge = p->physicalPGs[i].age;
    }
  }
  if(leastIndex == -1){
80107caa:	83 f8 ff             	cmp    $0xffffffff,%eax
80107cad:	74 08                	je     80107cb7 <nfuaLeastAgeIndex+0x57>
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;
}
80107caf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cb2:	5b                   	pop    %ebx
80107cb3:	5e                   	pop    %esi
80107cb4:	5f                   	pop    %edi
80107cb5:	5d                   	pop    %ebp
80107cb6:	c3                   	ret    
    panic("IndexMaxAgePG : could not find age >= 0");
80107cb7:	83 ec 0c             	sub    $0xc,%esp
80107cba:	68 b4 95 10 80       	push   $0x801095b4
80107cbf:	e8 cc 86 ff ff       	call   80100390 <panic>
80107cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107cd0 <lapaLeastAgeIndex>:

int
lapaLeastAgeIndex(){/**********************************************************************************      LAPA       *********/
80107cd0:	55                   	push   %ebp
80107cd1:	89 e5                	mov    %esp,%ebp
80107cd3:	57                   	push   %edi
80107cd4:	56                   	push   %esi
80107cd5:	53                   	push   %ebx
80107cd6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107cd9:	e8 42 c4 ff ff       	call   80104120 <myproc>
  int leastIndex = -1;
  uint count;
  uint tempAge;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
80107cde:	8b b0 80 00 00 00    	mov    0x80(%eax),%esi
80107ce4:	85 f6                	test   %esi,%esi
80107ce6:	89 75 e0             	mov    %esi,-0x20(%ebp)
80107ce9:	7e 75                	jle    80107d60 <lapaLeastAgeIndex+0x90>
80107ceb:	8d 98 d8 01 00 00    	lea    0x1d8(%eax),%ebx
80107cf1:	31 f6                	xor    %esi,%esi
  int leastIndex = -1;
80107cf3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  uint leastAge = __UINT32_MAX__;
80107cfa:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
80107d01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->physicalPGs[i].va != (char*)0xffffffff){
80107d08:	83 3b ff             	cmpl   $0xffffffff,(%ebx)
80107d0b:	74 37                	je     80107d44 <lapaLeastAgeIndex+0x74>
      tempAge = p->physicalPGs[i].age;
80107d0d:	8b 7b 04             	mov    0x4(%ebx),%edi
      count = 0; 
      while (tempAge) { 
80107d10:	85 ff                	test   %edi,%edi
80107d12:	74 30                	je     80107d44 <lapaLeastAgeIndex+0x74>
80107d14:	89 f8                	mov    %edi,%eax
      count = 0; 
80107d16:	31 d2                	xor    %edx,%edx
80107d18:	90                   	nop
80107d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
          count += tempAge & 1; 
80107d20:	89 c1                	mov    %eax,%ecx
80107d22:	83 e1 01             	and    $0x1,%ecx
80107d25:	01 ca                	add    %ecx,%edx
      while (tempAge) { 
80107d27:	d1 e8                	shr    %eax
80107d29:	75 f5                	jne    80107d20 <lapaLeastAgeIndex+0x50>
          tempAge >>= 1; 
      } 
      if(count<=leastAgeSetCount){
        if(count == leastAgeSetCount &&  p->physicalPGs[i].age <= leastAge){
80107d2b:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107d2e:	39 c7                	cmp    %eax,%edi
80107d30:	77 12                	ja     80107d44 <lapaLeastAgeIndex+0x74>
80107d32:	83 fa 20             	cmp    $0x20,%edx
80107d35:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107d38:	0f 45 f8             	cmovne %eax,%edi
80107d3b:	89 7d dc             	mov    %edi,-0x24(%ebp)
80107d3e:	0f 44 d6             	cmove  %esi,%edx
80107d41:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(i = 0; i < p->nPgsPhysical ; i++){
80107d44:	83 c6 01             	add    $0x1,%esi
80107d47:	83 c3 14             	add    $0x14,%ebx
80107d4a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107d4d:	75 b9                	jne    80107d08 <lapaLeastAgeIndex+0x38>
        }
        
      }
    }
  }
  if(leastIndex == -1){
80107d4f:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
80107d53:	74 0b                	je     80107d60 <lapaLeastAgeIndex+0x90>
    panic("lapaLeastAge : could not find age >= 0");
  }
  return leastIndex;
}
80107d55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d5b:	5b                   	pop    %ebx
80107d5c:	5e                   	pop    %esi
80107d5d:	5f                   	pop    %edi
80107d5e:	5d                   	pop    %ebp
80107d5f:	c3                   	ret    
    panic("lapaLeastAge : could not find age >= 0");
80107d60:	83 ec 0c             	sub    $0xc,%esp
80107d63:	68 dc 95 10 80       	push   $0x801095dc
80107d68:	e8 23 86 ff ff       	call   80100390 <panic>
80107d6d:	8d 76 00             	lea    0x0(%esi),%esi

80107d70 <addSwappedNode>:
/***************************************************************************************************************************************************************/
/****************************************************************************    Nodes    **********************************************************************/
/***************************************************************************************************************************************************************/

void
addSwappedNode(char* addr){
80107d70:	55                   	push   %ebp
80107d71:	89 e5                	mov    %esp,%ebp
80107d73:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc();
80107d76:	e8 a5 c3 ff ff       	call   80104120 <myproc>
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107d7b:	31 d2                	xor    %edx,%edx
80107d7d:	8d 88 a8 00 00 00    	lea    0xa8(%eax),%ecx
80107d83:	eb 0e                	jmp    80107d93 <addSwappedNode+0x23>
80107d85:	8d 76 00             	lea    0x0(%esi),%esi
80107d88:	83 c2 01             	add    $0x1,%edx
80107d8b:	83 c1 14             	add    $0x14,%ecx
    if(i== MAX_PSYC_PAGES){
80107d8e:	83 fa 10             	cmp    $0x10,%edx
80107d91:	74 2d                	je     80107dc0 <addSwappedNode+0x50>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == EMPTY_VA){
80107d93:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107d96:	75 f0                	jne    80107d88 <addSwappedNode+0x18>
      p->swappedPGs[i].offset = i*PGSIZE;
80107d98:	8d 0c 92             	lea    (%edx,%edx,4),%ecx
80107d9b:	c1 e2 0c             	shl    $0xc,%edx
80107d9e:	8d 0c 88             	lea    (%eax,%ecx,4),%ecx
      p->swappedPGs[i].va =(char*)PGROUNDDOWN((uint)addr);
80107da1:	8b 45 08             	mov    0x8(%ebp),%eax
      p->swappedPGs[i].offset = i*PGSIZE;
80107da4:	89 91 98 00 00 00    	mov    %edx,0x98(%ecx)
      p->swappedPGs[i].va =(char*)PGROUNDDOWN((uint)addr);
80107daa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107daf:	89 81 a8 00 00 00    	mov    %eax,0xa8(%ecx)
      return;
    }
  }
}
80107db5:	c9                   	leave  
80107db6:	c3                   	ret    
80107db7:	89 f6                	mov    %esi,%esi
80107db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107dc0:	83 ec 0c             	sub    $0xc,%esp
80107dc3:	68 04 96 10 80       	push   $0x80109604
80107dc8:	e8 c3 85 ff ff       	call   80100390 <panic>
80107dcd:	8d 76 00             	lea    0x0(%esi),%esi

80107dd0 <addPhysicalNode>:
  }
}


void
addPhysicalNode(uint addr){
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	57                   	push   %edi
80107dd4:	56                   	push   %esi
80107dd5:	53                   	push   %ebx
80107dd6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107dd9:	e8 42 c3 ff ff       	call   80104120 <myproc>
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107dde:	31 d2                	xor    %edx,%edx
80107de0:	8d 88 d8 01 00 00    	lea    0x1d8(%eax),%ecx
80107de6:	eb 17                	jmp    80107dff <addPhysicalNode+0x2f>
80107de8:	90                   	nop
80107de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107df0:	83 c2 01             	add    $0x1,%edx
80107df3:	83 c1 14             	add    $0x14,%ecx
    if(i==MAX_PSYC_PAGES){
80107df6:	83 fa 10             	cmp    $0x10,%edx
80107df9:	0f 84 b1 00 00 00    	je     80107eb0 <addPhysicalNode+0xe0>
      panic("addPhysicalNode: cannot allocate phy page");
    }
    if(p->physicalPGs[i].va == EMPTY_VA){
80107dff:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107e02:	75 ec                	jne    80107df0 <addPhysicalNode+0x20>
      p->physicalPGs[i].va = (char*)PGROUNDDOWN(addr);
80107e04:	8d 0c 92             	lea    (%edx,%edx,4),%ecx
80107e07:	8d 1c 88             	lea    (%eax,%ecx,4),%ebx
80107e0a:	8b 4d 08             	mov    0x8(%ebp),%ecx
      p->physicalPGs[i].age = 0;
80107e0d:	c7 83 dc 01 00 00 00 	movl   $0x0,0x1dc(%ebx)
80107e14:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80107e17:	c7 83 e0 01 00 00 01 	movl   $0x1,0x1e0(%ebx)
80107e1e:	00 00 00 
      p->physicalPGs[i].va = (char*)PGROUNDDOWN(addr);
80107e21:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107e27:	89 8b d8 01 00 00    	mov    %ecx,0x1d8(%ebx)

      #ifdef LAPA
        p->physicalPGs[i].age = 0xffffffff;
      #endif
      #if defined(SCFIFO) || defined(AQ)
        if(p->headPG == -1){
80107e2d:	8b 88 94 00 00 00    	mov    0x94(%eax),%ecx
80107e33:	83 f9 ff             	cmp    $0xffffffff,%ecx
80107e36:	0f 84 84 00 00 00    	je     80107ec0 <addPhysicalNode+0xf0>
          p->physicalPGs[i].prev = 0;
          p->physicalPGs[i].next = 0;
        }
        if(p->physicalPGs[i].prev){
80107e3c:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
80107e3f:	8d 34 98             	lea    (%eax,%ebx,4),%esi
80107e42:	8b 9e e8 01 00 00    	mov    0x1e8(%esi),%ebx
80107e48:	85 db                	test   %ebx,%ebx
80107e4a:	74 0f                	je     80107e5b <addPhysicalNode+0x8b>
          p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
80107e4c:	8b 8e e4 01 00 00    	mov    0x1e4(%esi),%ecx
80107e52:	89 4b 0c             	mov    %ecx,0xc(%ebx)
80107e55:	8b 88 94 00 00 00    	mov    0x94(%eax),%ecx
        }
        p->physicalPGs[i].next = &p->physicalPGs[p->headPG];
80107e5b:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
80107e5e:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
80107e61:	c1 e3 02             	shl    $0x2,%ebx
80107e64:	c1 e1 02             	shl    $0x2,%ecx
80107e67:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107e6a:	8d bc 08 d8 01 00 00 	lea    0x1d8(%eax,%ecx,1),%edi
        p->physicalPGs[p->headPG].prev = &p->physicalPGs[i];
80107e71:	8d 9c 18 d8 01 00 00 	lea    0x1d8(%eax,%ebx,1),%ebx
        p->physicalPGs[i].next = &p->physicalPGs[p->headPG];
80107e78:	89 be e4 01 00 00    	mov    %edi,0x1e4(%esi)
        p->physicalPGs[p->headPG].prev = &p->physicalPGs[i];
80107e7e:	89 9c 08 e8 01 00 00 	mov    %ebx,0x1e8(%eax,%ecx,1)
        p->physicalPGs[i].prev = 0;
80107e85:	c7 86 e8 01 00 00 00 	movl   $0x0,0x1e8(%esi)
80107e8c:	00 00 00 
        p->headPG = i;
80107e8f:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
      #endif
      myproc()->nPgsPhysical++;
80107e95:	e8 86 c2 ff ff       	call   80104120 <myproc>
80107e9a:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
      return;
    }
  }
}
80107ea1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ea4:	5b                   	pop    %ebx
80107ea5:	5e                   	pop    %esi
80107ea6:	5f                   	pop    %edi
80107ea7:	5d                   	pop    %ebp
80107ea8:	c3                   	ret    
80107ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("addPhysicalNode: cannot allocate phy page");
80107eb0:	83 ec 0c             	sub    $0xc,%esp
80107eb3:	68 38 96 10 80       	push   $0x80109638
80107eb8:	e8 d3 84 ff ff       	call   80100390 <panic>
80107ebd:	8d 76 00             	lea    0x0(%esi),%esi
          p->physicalPGs[i].prev = 0;
80107ec0:	c7 83 e8 01 00 00 00 	movl   $0x0,0x1e8(%ebx)
80107ec7:	00 00 00 
          p->physicalPGs[i].next = 0;
80107eca:	c7 83 e4 01 00 00 00 	movl   $0x0,0x1e4(%ebx)
80107ed1:	00 00 00 
        if(p->physicalPGs[i].prev){
80107ed4:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
80107ed7:	8d 34 98             	lea    (%eax,%ebx,4),%esi
80107eda:	8b 9e e8 01 00 00    	mov    0x1e8(%esi),%ebx
80107ee0:	85 db                	test   %ebx,%ebx
80107ee2:	0f 85 64 ff ff ff    	jne    80107e4c <addPhysicalNode+0x7c>
80107ee8:	e9 6e ff ff ff       	jmp    80107e5b <addPhysicalNode+0x8b>
80107eed:	8d 76 00             	lea    0x0(%esi),%esi

80107ef0 <clearSwapPage>:


void
clearSwapPage(int index){
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	53                   	push   %ebx
80107ef4:	83 ec 04             	sub    $0x4,%esp
80107ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107efa:	e8 21 c2 ff ff       	call   80104120 <myproc>
  p->nPgsSwap--;
80107eff:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
  p->swappedPGs[index].va = EMPTY_VA;
80107f06:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
80107f09:	c7 84 90 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%edx,4)
80107f10:	ff ff ff ff 
}
80107f14:	83 c4 04             	add    $0x4,%esp
80107f17:	5b                   	pop    %ebx
80107f18:	5d                   	pop    %ebp
80107f19:	c3                   	ret    
80107f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f20 <indexInSwapFile>:
/***************************************************************************************************************************************************************/
/**************************************************************************    Indexing    *********************************************************************/
/***************************************************************************************************************************************************************/

int
indexInSwapFile(uint addr){
80107f20:	55                   	push   %ebp
80107f21:	89 e5                	mov    %esp,%ebp
80107f23:	57                   	push   %edi
80107f24:	56                   	push   %esi
80107f25:	53                   	push   %ebx
80107f26:	83 ec 0c             	sub    $0xc,%esp
  
  struct proc *p =myproc();
80107f29:	e8 f2 c1 ff ff       	call   80104120 <myproc>
80107f2e:	8b 75 08             	mov    0x8(%ebp),%esi
80107f31:	8d 90 a8 00 00 00    	lea    0xa8(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107f37:	31 c9                	xor    %ecx,%ecx
80107f39:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107f3f:	eb 12                	jmp    80107f53 <indexInSwapFile+0x33>
80107f41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f48:	83 c1 01             	add    $0x1,%ecx
80107f4b:	83 c2 14             	add    $0x14,%edx
80107f4e:	83 f9 10             	cmp    $0x10,%ecx
80107f51:	74 15                	je     80107f68 <indexInSwapFile+0x48>
    if(p->swappedPGs[i].va == (char*) PGROUNDDOWN(addr)){
80107f53:	39 32                	cmp    %esi,(%edx)
80107f55:	75 f1                	jne    80107f48 <indexInSwapFile+0x28>

    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107f57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f5a:	89 c8                	mov    %ecx,%eax
80107f5c:	5b                   	pop    %ebx
80107f5d:	5e                   	pop    %esi
80107f5e:	5f                   	pop    %edi
80107f5f:	5d                   	pop    %ebp
80107f60:	c3                   	ret    
80107f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f68:	8d 98 d8 01 00 00    	lea    0x1d8(%eax),%ebx
80107f6e:	8d b8 18 03 00 00    	lea    0x318(%eax),%edi
80107f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
80107f78:	83 ec 04             	sub    $0x4,%esp
80107f7b:	83 c3 14             	add    $0x14,%ebx
80107f7e:	56                   	push   %esi
80107f7f:	ff 73 ec             	pushl  -0x14(%ebx)
80107f82:	68 cf 94 10 80       	push   $0x801094cf
80107f87:	e8 d4 86 ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107f8c:	83 c4 10             	add    $0x10,%esp
80107f8f:	39 fb                	cmp    %edi,%ebx
80107f91:	75 e5                	jne    80107f78 <indexInSwapFile+0x58>
  panic("scfifoSwap: could not find page in swap file");
80107f93:	83 ec 0c             	sub    $0xc,%esp
80107f96:	68 64 96 10 80       	push   $0x80109664
80107f9b:	e8 f0 83 ff ff       	call   80100390 <panic>

80107fa0 <indexInPhysicalMem>:

int
indexInPhysicalMem(uint addr){
80107fa0:	55                   	push   %ebp
80107fa1:	89 e5                	mov    %esp,%ebp
80107fa3:	53                   	push   %ebx
80107fa4:	83 ec 04             	sub    $0x4,%esp
80107fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p =myproc();
80107faa:	e8 71 c1 ff ff       	call   80104120 <myproc>
80107faf:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107fb5:	31 c0                	xor    %eax,%eax
80107fb7:	89 d9                	mov    %ebx,%ecx
80107fb9:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107fbf:	eb 12                	jmp    80107fd3 <indexInPhysicalMem+0x33>
80107fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107fc8:	83 c0 01             	add    $0x1,%eax
80107fcb:	83 c2 14             	add    $0x14,%edx
80107fce:	83 f8 10             	cmp    $0x10,%eax
80107fd1:	74 0d                	je     80107fe0 <indexInPhysicalMem+0x40>
    if(p->physicalPGs[i].va == (char*) PGROUNDDOWN(addr)){
80107fd3:	39 0a                	cmp    %ecx,(%edx)
80107fd5:	75 f1                	jne    80107fc8 <indexInPhysicalMem+0x28>
    }
  }
  cprintf("tried find : %x\n",addr);
  panic("scfifoSwap: could not find page in physical mem");
  return -1;
}
80107fd7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107fda:	c9                   	leave  
80107fdb:	c3                   	ret    
80107fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  cprintf("tried find : %x\n",addr);
80107fe0:	83 ec 08             	sub    $0x8,%esp
80107fe3:	53                   	push   %ebx
80107fe4:	68 e6 94 10 80       	push   $0x801094e6
80107fe9:	e8 72 86 ff ff       	call   80100660 <cprintf>
  panic("scfifoSwap: could not find page in physical mem");
80107fee:	c7 04 24 94 96 10 80 	movl   $0x80109694,(%esp)
80107ff5:	e8 96 83 ff ff       	call   80100390 <panic>
80107ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108000 <scfifoLastPageIndex>:
scfifoLastPageIndex(){/****************************************************************************     SCFIFO      *********/
80108000:	55                   	push   %ebp
80108001:	89 e5                	mov    %esp,%ebp
80108003:	57                   	push   %edi
80108004:	56                   	push   %esi
80108005:	53                   	push   %ebx
80108006:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80108009:	e8 12 c1 ff ff       	call   80104120 <myproc>
  struct procPG *page = &p->physicalPGs[p->headPG];
8010800e:	8b 88 94 00 00 00    	mov    0x94(%eax),%ecx
  struct proc *p = myproc();
80108014:	89 c7                	mov    %eax,%edi
  struct procPG *page = &p->physicalPGs[p->headPG];
80108016:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80108019:	c1 e0 02             	shl    $0x2,%eax
8010801c:	8d 9c 07 d8 01 00 00 	lea    0x1d8(%edi,%eax,1),%ebx
  if(!page->next){
80108023:	8b 84 07 e4 01 00 00 	mov    0x1e4(%edi,%eax,1),%eax
8010802a:	85 c0                	test   %eax,%eax
8010802c:	0f 84 a2 00 00 00    	je     801080d4 <scfifoLastPageIndex+0xd4>
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80108032:	83 bf 80 00 00 00 01 	cmpl   $0x1,0x80(%edi)
80108039:	ba 01 00 00 00       	mov    $0x1,%edx
8010803e:	7f 0f                	jg     8010804f <scfifoLastPageIndex+0x4f>
80108040:	eb 24                	jmp    80108066 <scfifoLastPageIndex+0x66>
80108042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108048:	8b 43 0c             	mov    0xc(%ebx),%eax
8010804b:	85 c0                	test   %eax,%eax
8010804d:	74 11                	je     80108060 <scfifoLastPageIndex+0x60>
      page->next->prev = page;
8010804f:	89 58 10             	mov    %ebx,0x10(%eax)
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80108052:	83 c2 01             	add    $0x1,%edx
80108055:	39 97 80 00 00 00    	cmp    %edx,0x80(%edi)
      page = page->next;
8010805b:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
8010805e:	7f e8                	jg     80108048 <scfifoLastPageIndex+0x48>
80108060:	8b 8f 94 00 00 00    	mov    0x94(%edi),%ecx
  p->physicalPGs[p->headPG].prev = page;
80108066:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80108069:	89 9c 87 e8 01 00 00 	mov    %ebx,0x1e8(%edi,%eax,4)
  uint tailVa = (uint) page->va;
80108070:	8b 03                	mov    (%ebx),%eax
80108072:	89 c6                	mov    %eax,%esi
80108074:	eb 18                	jmp    8010808e <scfifoLastPageIndex+0x8e>
80108076:	8d 76 00             	lea    0x0(%esi),%esi
80108079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *pte &= ~PTE_A;
80108080:	83 e2 df             	and    $0xffffffdf,%edx
80108083:	89 10                	mov    %edx,(%eax)
    page = page->prev;
80108085:	8b 5b 10             	mov    0x10(%ebx),%ebx
  }while ((uint)page->va != tailVa);
80108088:	8b 03                	mov    (%ebx),%eax
8010808a:	39 f0                	cmp    %esi,%eax
8010808c:	74 32                	je     801080c0 <scfifoLastPageIndex+0xc0>
    pte = walkpgdir(p->pgdir,(void*)page->va,0);
8010808e:	83 ec 04             	sub    $0x4,%esp
80108091:	6a 00                	push   $0x0
80108093:	50                   	push   %eax
80108094:	ff 77 04             	pushl  0x4(%edi)
80108097:	e8 24 f7 ff ff       	call   801077c0 <nonStaticWalkpgdir>
    if(*pte & PTE_A){
8010809c:	8b 10                	mov    (%eax),%edx
8010809e:	83 c4 10             	add    $0x10,%esp
801080a1:	f6 c2 20             	test   $0x20,%dl
801080a4:	75 da                	jne    80108080 <scfifoLastPageIndex+0x80>
      return indexInPhysicalMem((uint)page->va);
801080a6:	83 ec 0c             	sub    $0xc,%esp
801080a9:	ff 33                	pushl  (%ebx)
801080ab:	e8 f0 fe ff ff       	call   80107fa0 <indexInPhysicalMem>
801080b0:	83 c4 10             	add    $0x10,%esp
}
801080b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080b6:	5b                   	pop    %ebx
801080b7:	5e                   	pop    %esi
801080b8:	5f                   	pop    %edi
801080b9:	5d                   	pop    %ebp
801080ba:	c3                   	ret    
801080bb:	90                   	nop
801080bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return indexInPhysicalMem((uint)page->va);
801080c0:	83 ec 0c             	sub    $0xc,%esp
801080c3:	50                   	push   %eax
801080c4:	e8 d7 fe ff ff       	call   80107fa0 <indexInPhysicalMem>
801080c9:	83 c4 10             	add    $0x10,%esp
}
801080cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080cf:	5b                   	pop    %ebx
801080d0:	5e                   	pop    %esi
801080d1:	5f                   	pop    %edi
801080d2:	5d                   	pop    %ebp
801080d3:	c3                   	ret    
    panic("getLastPG: empty headPG list");
801080d4:	83 ec 0c             	sub    $0xc,%esp
801080d7:	68 e5 90 10 80       	push   $0x801090e5
801080dc:	e8 af 82 ff ff       	call   80100390 <panic>
801080e1:	eb 0d                	jmp    801080f0 <pageIndexToWrite>
801080e3:	90                   	nop
801080e4:	90                   	nop
801080e5:	90                   	nop
801080e6:	90                   	nop
801080e7:	90                   	nop
801080e8:	90                   	nop
801080e9:	90                   	nop
801080ea:	90                   	nop
801080eb:	90                   	nop
801080ec:	90                   	nop
801080ed:	90                   	nop
801080ee:	90                   	nop
801080ef:	90                   	nop

801080f0 <pageIndexToWrite>:
pageIndexToWrite(){
801080f0:	55                   	push   %ebp
801080f1:	89 e5                	mov    %esp,%ebp
}
801080f3:	5d                   	pop    %ebp
    return scfifoLastPageIndex();
801080f4:	e9 07 ff ff ff       	jmp    80108000 <scfifoLastPageIndex>
801080f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108100 <aqLeastAgeIndex>:
aqLeastAgeIndex(){/****************************************************************************        AQ        *********/
80108100:	55                   	push   %ebp
80108101:	89 e5                	mov    %esp,%ebp
80108103:	56                   	push   %esi
80108104:	53                   	push   %ebx
  struct proc *p = myproc();
80108105:	e8 16 c0 ff ff       	call   80104120 <myproc>
  struct procPG *page = &p->physicalPGs[p->headPG];
8010810a:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
  if(!page->next){
80108110:	8d 34 92             	lea    (%edx,%edx,4),%esi
80108113:	c1 e6 02             	shl    $0x2,%esi
80108116:	8b 8c 30 e4 01 00 00 	mov    0x1e4(%eax,%esi,1),%ecx
8010811d:	85 c9                	test   %ecx,%ecx
8010811f:	74 48                	je     80108169 <aqLeastAgeIndex+0x69>
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80108121:	8b 98 80 00 00 00    	mov    0x80(%eax),%ebx
80108127:	ba 01 00 00 00       	mov    $0x1,%edx
8010812c:	83 fb 01             	cmp    $0x1,%ebx
8010812f:	7f 10                	jg     80108141 <aqLeastAgeIndex+0x41>
80108131:	eb 2d                	jmp    80108160 <aqLeastAgeIndex+0x60>
80108133:	90                   	nop
80108134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108138:	8b 41 0c             	mov    0xc(%ecx),%eax
8010813b:	85 c0                	test   %eax,%eax
8010813d:	74 09                	je     80108148 <aqLeastAgeIndex+0x48>
8010813f:	89 c1                	mov    %eax,%ecx
80108141:	83 c2 01             	add    $0x1,%edx
80108144:	39 da                	cmp    %ebx,%edx
80108146:	75 f0                	jne    80108138 <aqLeastAgeIndex+0x38>
  return indexInPhysicalMem((uint)page->va);
80108148:	83 ec 0c             	sub    $0xc,%esp
8010814b:	ff 31                	pushl  (%ecx)
8010814d:	e8 4e fe ff ff       	call   80107fa0 <indexInPhysicalMem>
}
80108152:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108155:	5b                   	pop    %ebx
80108156:	5e                   	pop    %esi
80108157:	5d                   	pop    %ebp
80108158:	c3                   	ret    
80108159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct procPG *page = &p->physicalPGs[p->headPG];
80108160:	8d 8c 30 d8 01 00 00 	lea    0x1d8(%eax,%esi,1),%ecx
80108167:	eb df                	jmp    80108148 <aqLeastAgeIndex+0x48>
    panic("getLastPG: empty headPG list");
80108169:	83 ec 0c             	sub    $0xc,%esp
8010816c:	68 e5 90 10 80       	push   $0x801090e5
80108171:	e8 1a 82 ff ff       	call   80100390 <panic>
80108176:	8d 76 00             	lea    0x0(%esi),%esi
80108179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108180 <removePhysicalNode>:
removePhysicalNode(char* va){
80108180:	55                   	push   %ebp
80108181:	89 e5                	mov    %esp,%ebp
80108183:	56                   	push   %esi
80108184:	53                   	push   %ebx
  struct proc *p = myproc();
80108185:	e8 96 bf ff ff       	call   80104120 <myproc>
8010818a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010818d:	89 c3                	mov    %eax,%ebx
8010818f:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80108195:	31 c0                	xor    %eax,%eax
80108197:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
8010819d:	eb 0c                	jmp    801081ab <removePhysicalNode+0x2b>
8010819f:	90                   	nop
801081a0:	83 c0 01             	add    $0x1,%eax
801081a3:	83 c2 14             	add    $0x14,%edx
    if(i==MAX_PSYC_PAGES){
801081a6:	83 f8 10             	cmp    $0x10,%eax
801081a9:	74 4d                	je     801081f8 <removePhysicalNode+0x78>
    if(p->physicalPGs[i].va ==(char*) PGROUNDDOWN((uint)va)){
801081ab:	39 0a                	cmp    %ecx,(%edx)
801081ad:	75 f1                	jne    801081a0 <removePhysicalNode+0x20>
      p->physicalPGs[i].va = EMPTY_VA;
801081af:	8d 14 80             	lea    (%eax,%eax,4),%edx
801081b2:	8d 34 93             	lea    (%ebx,%edx,4),%esi
801081b5:	c7 86 d8 01 00 00 ff 	movl   $0xffffffff,0x1d8(%esi)
801081bc:	ff ff ff 
      p->physicalPGs[i].age = 0;
801081bf:	c7 86 dc 01 00 00 00 	movl   $0x0,0x1dc(%esi)
801081c6:	00 00 00 
      p->physicalPGs[i].alloceted = 0;
801081c9:	c7 86 e0 01 00 00 00 	movl   $0x0,0x1e0(%esi)
801081d0:	00 00 00 
      if(p->headPG == i){
801081d3:	39 83 94 00 00 00    	cmp    %eax,0x94(%ebx)
801081d9:	74 2d                	je     80108208 <removePhysicalNode+0x88>
      if(p->physicalPGs[i].prev){
801081db:	8b 86 e8 01 00 00    	mov    0x1e8(%esi),%eax
801081e1:	85 c0                	test   %eax,%eax
801081e3:	74 09                	je     801081ee <removePhysicalNode+0x6e>
        p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
801081e5:	8b 96 e4 01 00 00    	mov    0x1e4(%esi),%edx
801081eb:	89 50 0c             	mov    %edx,0xc(%eax)
}
801081ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801081f1:	5b                   	pop    %ebx
801081f2:	5e                   	pop    %esi
801081f3:	5d                   	pop    %ebp
801081f4:	c3                   	ret    
801081f5:	8d 76 00             	lea    0x0(%esi),%esi
      panic("removePhysicalNode: cannot find phy page");
801081f8:	83 ec 0c             	sub    $0xc,%esp
801081fb:	68 c4 96 10 80       	push   $0x801096c4
80108200:	e8 8b 81 ff ff       	call   80100390 <panic>
80108205:	8d 76 00             	lea    0x0(%esi),%esi
        p->headPG = indexInPhysicalMem((uint)p->physicalPGs[i].next->va);
80108208:	8b 86 e4 01 00 00    	mov    0x1e4(%esi),%eax
8010820e:	83 ec 0c             	sub    $0xc,%esp
80108211:	ff 30                	pushl  (%eax)
80108213:	e8 88 fd ff ff       	call   80107fa0 <indexInPhysicalMem>
80108218:	89 83 94 00 00 00    	mov    %eax,0x94(%ebx)
        p->physicalPGs[i].next->prev = (void*)0;
8010821e:	8b 86 e4 01 00 00    	mov    0x1e4(%esi),%eax
        return;
80108224:	83 c4 10             	add    $0x10,%esp
        p->physicalPGs[i].next->prev = (void*)0;
80108227:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        return;
8010822e:	eb be                	jmp    801081ee <removePhysicalNode+0x6e>

80108230 <deallocuvm.part.1>:
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108230:	55                   	push   %ebp
80108231:	89 e5                	mov    %esp,%ebp
80108233:	57                   	push   %edi
80108234:	56                   	push   %esi
  a = PGROUNDUP(newsz);
80108235:	8d b1 ff 0f 00 00    	lea    0xfff(%ecx),%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010823b:	53                   	push   %ebx
  a = PGROUNDUP(newsz);
8010823c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80108242:	83 ec 1c             	sub    $0x1c,%esp
80108245:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108248:	39 d6                	cmp    %edx,%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010824a:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010824d:	73 45                	jae    80108294 <deallocuvm.part.1+0x64>
8010824f:	89 c7                	mov    %eax,%edi
80108251:	eb 17                	jmp    8010826a <deallocuvm.part.1+0x3a>
80108253:	90                   	nop
80108254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if((*pte & PTE_P) != 0){
80108258:	8b 18                	mov    (%eax),%ebx
8010825a:	f6 c3 01             	test   $0x1,%bl
8010825d:	75 41                	jne    801082a0 <deallocuvm.part.1+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010825f:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108265:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80108268:	73 2a                	jae    80108294 <deallocuvm.part.1+0x64>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010826a:	83 ec 04             	sub    $0x4,%esp
8010826d:	6a 00                	push   $0x0
8010826f:	56                   	push   %esi
80108270:	57                   	push   %edi
80108271:	e8 4a f5 ff ff       	call   801077c0 <nonStaticWalkpgdir>
    if(!pte)
80108276:	83 c4 10             	add    $0x10,%esp
80108279:	85 c0                	test   %eax,%eax
8010827b:	75 db                	jne    80108258 <deallocuvm.part.1+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010827d:	81 e6 00 00 c0 ff    	and    $0xffc00000,%esi
80108283:	81 c6 00 f0 3f 00    	add    $0x3ff000,%esi
  for(; a  < oldsz; a += PGSIZE){
80108289:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010828f:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
80108292:	72 d6                	jb     8010826a <deallocuvm.part.1+0x3a>
}
80108294:	8b 45 d8             	mov    -0x28(%ebp),%eax
80108297:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010829a:	5b                   	pop    %ebx
8010829b:	5e                   	pop    %esi
8010829c:	5f                   	pop    %edi
8010829d:	5d                   	pop    %ebp
8010829e:	c3                   	ret    
8010829f:	90                   	nop
      if(pa == 0)
801082a0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801082a6:	0f 84 9c 00 00 00    	je     80108348 <deallocuvm.part.1+0x118>
      kfree(v);
801082ac:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801082af:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
801082b5:	89 45 e0             	mov    %eax,-0x20(%ebp)
      kfree(v);
801082b8:	53                   	push   %ebx
801082b9:	e8 a2 a6 ff ff       	call   80102960 <kfree>
      struct proc *p = myproc();
801082be:	e8 5d be ff ff       	call   80104120 <myproc>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
801082c3:	8b 55 e0             	mov    -0x20(%ebp),%edx
      struct proc *p = myproc();
801082c6:	89 45 dc             	mov    %eax,-0x24(%ebp)
801082c9:	83 c4 10             	add    $0x10,%esp
801082cc:	05 a8 00 00 00       	add    $0xa8,%eax
      for(i = 0; i < MAX_PSYC_PAGES; i++){
801082d1:	31 c9                	xor    %ecx,%ecx
801082d3:	90                   	nop
801082d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          if(p->physicalPGs[i].va == (char*)v){
801082d8:	3b 98 30 01 00 00    	cmp    0x130(%eax),%ebx
801082de:	74 20                	je     80108300 <deallocuvm.part.1+0xd0>
          }if(p->swappedPGs[i].va == (char*)v){
801082e0:	3b 18                	cmp    (%eax),%ebx
801082e2:	74 3c                	je     80108320 <deallocuvm.part.1+0xf0>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
801082e4:	83 c1 01             	add    $0x1,%ecx
801082e7:	83 c0 14             	add    $0x14,%eax
801082ea:	83 f9 10             	cmp    $0x10,%ecx
801082ed:	75 e9                	jne    801082d8 <deallocuvm.part.1+0xa8>
      *pte = 0;
801082ef:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
801082f5:	e9 65 ff ff ff       	jmp    8010825f <deallocuvm.part.1+0x2f>
801082fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            removePhysicalNode(v);
80108300:	83 ec 0c             	sub    $0xc,%esp
80108303:	89 55 e0             	mov    %edx,-0x20(%ebp)
80108306:	53                   	push   %ebx
80108307:	e8 74 fe ff ff       	call   80108180 <removePhysicalNode>
8010830c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010830f:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80108312:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80108318:	e9 42 ff ff ff       	jmp    8010825f <deallocuvm.part.1+0x2f>
8010831d:	8d 76 00             	lea    0x0(%esi),%esi
            p->swappedPGs[i].va = (char*) 0xffffffff;
80108320:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80108323:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80108326:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80108329:	c7 80 a8 00 00 00 ff 	movl   $0xffffffff,0xa8(%eax)
80108330:	ff ff ff 
            p->swappedPGs[i].offset = -1;
80108333:	c7 80 98 00 00 00 ff 	movl   $0xffffffff,0x98(%eax)
8010833a:	ff ff ff 
      *pte = 0;
8010833d:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80108343:	e9 17 ff ff ff       	jmp    8010825f <deallocuvm.part.1+0x2f>
        panic("kfree");
80108348:	83 ec 0c             	sub    $0xc,%esp
8010834b:	68 f7 94 10 80       	push   $0x801094f7
80108350:	e8 3b 80 ff ff       	call   80100390 <panic>
80108355:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108360 <deallocuvm>:
{
80108360:	55                   	push   %ebp
80108361:	89 e5                	mov    %esp,%ebp
80108363:	8b 55 0c             	mov    0xc(%ebp),%edx
80108366:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108369:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz){
8010836c:	39 d1                	cmp    %edx,%ecx
8010836e:	73 10                	jae    80108380 <deallocuvm+0x20>
}
80108370:	5d                   	pop    %ebp
80108371:	e9 ba fe ff ff       	jmp    80108230 <deallocuvm.part.1>
80108376:	8d 76 00             	lea    0x0(%esi),%esi
80108379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108380:	89 d0                	mov    %edx,%eax
80108382:	5d                   	pop    %ebp
80108383:	c3                   	ret    
80108384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010838a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108390 <freevm>:
{
80108390:	55                   	push   %ebp
80108391:	89 e5                	mov    %esp,%ebp
80108393:	57                   	push   %edi
80108394:	56                   	push   %esi
80108395:	53                   	push   %ebx
80108396:	83 ec 0c             	sub    $0xc,%esp
80108399:	8b 75 08             	mov    0x8(%ebp),%esi
  if(pgdir == 0)
8010839c:	85 f6                	test   %esi,%esi
8010839e:	74 59                	je     801083f9 <freevm+0x69>
801083a0:	31 c9                	xor    %ecx,%ecx
801083a2:	ba 00 00 00 80       	mov    $0x80000000,%edx
801083a7:	89 f0                	mov    %esi,%eax
801083a9:	e8 82 fe ff ff       	call   80108230 <deallocuvm.part.1>
801083ae:	89 f3                	mov    %esi,%ebx
801083b0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801083b6:	eb 0f                	jmp    801083c7 <freevm+0x37>
801083b8:	90                   	nop
801083b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801083c0:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
801083c3:	39 fb                	cmp    %edi,%ebx
801083c5:	74 23                	je     801083ea <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801083c7:	8b 03                	mov    (%ebx),%eax
801083c9:	a8 01                	test   $0x1,%al
801083cb:	74 f3                	je     801083c0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801083cd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801083d2:	83 ec 0c             	sub    $0xc,%esp
801083d5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801083d8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801083dd:	50                   	push   %eax
801083de:	e8 7d a5 ff ff       	call   80102960 <kfree>
801083e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801083e6:	39 fb                	cmp    %edi,%ebx
801083e8:	75 dd                	jne    801083c7 <freevm+0x37>
  kfree((char*)pgdir);
801083ea:	89 75 08             	mov    %esi,0x8(%ebp)
}
801083ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083f0:	5b                   	pop    %ebx
801083f1:	5e                   	pop    %esi
801083f2:	5f                   	pop    %edi
801083f3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801083f4:	e9 67 a5 ff ff       	jmp    80102960 <kfree>
    panic("freevm: no pgdir");
801083f9:	83 ec 0c             	sub    $0xc,%esp
801083fc:	68 fd 94 10 80       	push   $0x801094fd
80108401:	e8 8a 7f ff ff       	call   80100390 <panic>
80108406:	8d 76 00             	lea    0x0(%esi),%esi
80108409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108410 <setupkvm>:
{
80108410:	55                   	push   %ebp
80108411:	89 e5                	mov    %esp,%ebp
80108413:	56                   	push   %esi
80108414:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80108415:	e8 56 a7 ff ff       	call   80102b70 <kalloc>
8010841a:	85 c0                	test   %eax,%eax
8010841c:	89 c6                	mov    %eax,%esi
8010841e:	74 42                	je     80108462 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108420:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108423:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108428:	68 00 10 00 00       	push   $0x1000
8010842d:	6a 00                	push   $0x0
8010842f:	50                   	push   %eax
80108430:	e8 7b cf ff ff       	call   801053b0 <memset>
80108435:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108438:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010843b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010843e:	83 ec 08             	sub    $0x8,%esp
80108441:	8b 13                	mov    (%ebx),%edx
80108443:	ff 73 0c             	pushl  0xc(%ebx)
80108446:	50                   	push   %eax
80108447:	29 c1                	sub    %eax,%ecx
80108449:	89 f0                	mov    %esi,%eax
8010844b:	e8 00 f4 ff ff       	call   80107850 <mappages>
80108450:	83 c4 10             	add    $0x10,%esp
80108453:	85 c0                	test   %eax,%eax
80108455:	78 19                	js     80108470 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108457:	83 c3 10             	add    $0x10,%ebx
8010845a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108460:	75 d6                	jne    80108438 <setupkvm+0x28>
}
80108462:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108465:	89 f0                	mov    %esi,%eax
80108467:	5b                   	pop    %ebx
80108468:	5e                   	pop    %esi
80108469:	5d                   	pop    %ebp
8010846a:	c3                   	ret    
8010846b:	90                   	nop
8010846c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108470:	83 ec 0c             	sub    $0xc,%esp
80108473:	56                   	push   %esi
      return 0;
80108474:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108476:	e8 15 ff ff ff       	call   80108390 <freevm>
      return 0;
8010847b:	83 c4 10             	add    $0x10,%esp
}
8010847e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108481:	89 f0                	mov    %esi,%eax
80108483:	5b                   	pop    %ebx
80108484:	5e                   	pop    %esi
80108485:	5d                   	pop    %ebp
80108486:	c3                   	ret    
80108487:	89 f6                	mov    %esi,%esi
80108489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108490 <kvmalloc>:
{
80108490:	55                   	push   %ebp
80108491:	89 e5                	mov    %esp,%ebp
80108493:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108496:	e8 75 ff ff ff       	call   80108410 <setupkvm>
8010849b:	a3 c4 9b 15 80       	mov    %eax,0x80159bc4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801084a0:	05 00 00 00 80       	add    $0x80000000,%eax
801084a5:	0f 22 d8             	mov    %eax,%cr3
}
801084a8:	c9                   	leave  
801084a9:	c3                   	ret    
801084aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801084b0 <copyuvm>:
{
801084b0:	55                   	push   %ebp
801084b1:	89 e5                	mov    %esp,%ebp
801084b3:	57                   	push   %edi
801084b4:	56                   	push   %esi
801084b5:	53                   	push   %ebx
801084b6:	83 ec 1c             	sub    $0x1c,%esp
  if((d = setupkvm()) == 0)
801084b9:	e8 52 ff ff ff       	call   80108410 <setupkvm>
801084be:	85 c0                	test   %eax,%eax
801084c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801084c3:	0f 84 2e 01 00 00    	je     801085f7 <copyuvm+0x147>
  for(i = 0; i < sz; i += PGSIZE){
801084c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801084cc:	85 c9                	test   %ecx,%ecx
801084ce:	0f 84 5a 01 00 00    	je     8010862e <copyuvm+0x17e>
801084d4:	31 db                	xor    %ebx,%ebx
801084d6:	eb 65                	jmp    8010853d <copyuvm+0x8d>
801084d8:	90                   	nop
801084d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(*pte & PTE_PG){
801084e0:	f6 c4 02             	test   $0x2,%ah
801084e3:	0f 85 1f 01 00 00    	jne    80108608 <copyuvm+0x158>
      *pte = *pte & ~PTE_W;
801084e9:	89 c2                	mov    %eax,%edx
      if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801084eb:	83 ec 08             	sub    $0x8,%esp
801084ee:	b9 00 10 00 00       	mov    $0x1000,%ecx
      *pte = *pte & ~PTE_W;
801084f3:	83 e2 fd             	and    $0xfffffffd,%edx
      *pte = *pte | PTE_COW;
801084f6:	80 ce 08             	or     $0x8,%dh
801084f9:	89 16                	mov    %edx,(%esi)
801084fb:	89 c6                	mov    %eax,%esi
      flags = PTE_FLAGS(*pte);
801084fd:	25 fd 0f 00 00       	and    $0xffd,%eax
80108502:	80 cc 08             	or     $0x8,%ah
80108505:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
      if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
8010850b:	89 da                	mov    %ebx,%edx
8010850d:	50                   	push   %eax
8010850e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108511:	56                   	push   %esi
80108512:	e8 39 f3 ff ff       	call   80107850 <mappages>
80108517:	83 c4 10             	add    $0x10,%esp
8010851a:	85 c0                	test   %eax,%eax
8010851c:	0f 88 b5 00 00 00    	js     801085d7 <copyuvm+0x127>
      incrementReferenceCount(pa);
80108522:	83 ec 0c             	sub    $0xc,%esp
80108525:	56                   	push   %esi
80108526:	e8 85 a7 ff ff       	call   80102cb0 <incrementReferenceCount>
8010852b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
8010852e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108534:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80108537:	0f 86 f1 00 00 00    	jbe    8010862e <copyuvm+0x17e>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010853d:	83 ec 04             	sub    $0x4,%esp
80108540:	6a 00                	push   $0x0
80108542:	53                   	push   %ebx
80108543:	ff 75 08             	pushl  0x8(%ebp)
80108546:	e8 75 f2 ff ff       	call   801077c0 <nonStaticWalkpgdir>
8010854b:	83 c4 10             	add    $0x10,%esp
8010854e:	85 c0                	test   %eax,%eax
80108550:	89 c6                	mov    %eax,%esi
80108552:	0f 84 ec 00 00 00    	je     80108644 <copyuvm+0x194>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
80108558:	f7 00 01 02 00 00    	testl  $0x201,(%eax)
8010855e:	0f 84 ed 00 00 00    	je     80108651 <copyuvm+0x1a1>
    if(myproc()->pid>2){
80108564:	e8 b7 bb ff ff       	call   80104120 <myproc>
80108569:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
      if(*pte & PTE_PG){
8010856d:	8b 06                	mov    (%esi),%eax
    if(myproc()->pid>2){
8010856f:	0f 8f 6b ff ff ff    	jg     801084e0 <copyuvm+0x30>
      pa = PTE_ADDR(*pte);
80108575:	89 c7                	mov    %eax,%edi
      flags = PTE_FLAGS(*pte);
80108577:	25 ff 0f 00 00       	and    $0xfff,%eax
      pa = PTE_ADDR(*pte);
8010857c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
      flags = PTE_FLAGS(*pte);
80108582:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if((mem = kalloc()) == 0)
80108585:	e8 e6 a5 ff ff       	call   80102b70 <kalloc>
8010858a:	85 c0                	test   %eax,%eax
8010858c:	89 c6                	mov    %eax,%esi
8010858e:	74 47                	je     801085d7 <copyuvm+0x127>
      memmove(mem, (char*)P2V(pa), PGSIZE);
80108590:	83 ec 04             	sub    $0x4,%esp
80108593:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108599:	68 00 10 00 00       	push   $0x1000
8010859e:	57                   	push   %edi
8010859f:	50                   	push   %eax
801085a0:	e8 bb ce ff ff       	call   80105460 <memmove>
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801085a5:	58                   	pop    %eax
801085a6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801085ac:	b9 00 10 00 00       	mov    $0x1000,%ecx
801085b1:	5a                   	pop    %edx
801085b2:	ff 75 e0             	pushl  -0x20(%ebp)
801085b5:	50                   	push   %eax
801085b6:	89 da                	mov    %ebx,%edx
801085b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801085bb:	e8 90 f2 ff ff       	call   80107850 <mappages>
801085c0:	83 c4 10             	add    $0x10,%esp
801085c3:	85 c0                	test   %eax,%eax
801085c5:	0f 89 63 ff ff ff    	jns    8010852e <copyuvm+0x7e>
      kfree(mem);
801085cb:	83 ec 0c             	sub    $0xc,%esp
801085ce:	56                   	push   %esi
801085cf:	e8 8c a3 ff ff       	call   80102960 <kfree>
      goto bad;
801085d4:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801085d7:	83 ec 0c             	sub    $0xc,%esp
801085da:	ff 75 e4             	pushl  -0x1c(%ebp)
801085dd:	e8 ae fd ff ff       	call   80108390 <freevm>
  lcr3(V2P(pgdir));
801085e2:	8b 45 08             	mov    0x8(%ebp),%eax
801085e5:	05 00 00 00 80       	add    $0x80000000,%eax
801085ea:	0f 22 d8             	mov    %eax,%cr3
  return 0;
801085ed:	83 c4 10             	add    $0x10,%esp
801085f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801085f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801085fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801085fd:	5b                   	pop    %ebx
801085fe:	5e                   	pop    %esi
801085ff:	5f                   	pop    %edi
80108600:	5d                   	pop    %ebp
80108601:	c3                   	ret    
80108602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        pte = walkpgdir(d,(void*)i,1);
80108608:	83 ec 04             	sub    $0x4,%esp
8010860b:	6a 01                	push   $0x1
8010860d:	53                   	push   %ebx
  for(i = 0; i < sz; i += PGSIZE){
8010860e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
        pte = walkpgdir(d,(void*)i,1);
80108614:	ff 75 e4             	pushl  -0x1c(%ebp)
80108617:	e8 a4 f1 ff ff       	call   801077c0 <nonStaticWalkpgdir>
        continue;
8010861c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
8010861f:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
        *pte= PTE_U | PTE_W | PTE_PG;
80108622:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  for(i = 0; i < sz; i += PGSIZE){
80108628:	0f 87 0f ff ff ff    	ja     8010853d <copyuvm+0x8d>
  lcr3(V2P(pgdir));
8010862e:	8b 45 08             	mov    0x8(%ebp),%eax
80108631:	05 00 00 00 80       	add    $0x80000000,%eax
80108636:	0f 22 d8             	mov    %eax,%cr3
}
80108639:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010863c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010863f:	5b                   	pop    %ebx
80108640:	5e                   	pop    %esi
80108641:	5f                   	pop    %edi
80108642:	5d                   	pop    %ebp
80108643:	c3                   	ret    
      panic("copyuvm: pte should exist");
80108644:	83 ec 0c             	sub    $0xc,%esp
80108647:	68 0e 95 10 80       	push   $0x8010950e
8010864c:	e8 3f 7d ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80108651:	83 ec 0c             	sub    $0xc,%esp
80108654:	68 28 95 10 80       	push   $0x80109528
80108659:	e8 32 7d ff ff       	call   80100390 <panic>
8010865e:	66 90                	xchg   %ax,%ax

80108660 <writePageToSwapFile>:
/*********************************************************************   Paging Operations     *****************************************************************/
/***************************************************************************************************************************************************************/

// swaps out a page
void
writePageToSwapFile(){
80108660:	55                   	push   %ebp
80108661:	89 e5                	mov    %esp,%ebp
80108663:	57                   	push   %edi
80108664:	56                   	push   %esi
80108665:	53                   	push   %ebx
80108666:	83 ec 1c             	sub    $0x1c,%esp
  //cprintf("write %x\n",va);
  struct proc *p = myproc();
80108669:	e8 b2 ba ff ff       	call   80104120 <myproc>
8010866e:	89 c3                	mov    %eax,%ebx
    return scfifoLastPageIndex();
80108670:	e8 8b f9 ff ff       	call   80108000 <scfifoLastPageIndex>
80108675:	89 c6                	mov    %eax,%esi
  struct procPG *pageToWrite = &p->physicalPGs[pageIndexToWrite()];

  pte_t *pte = walkpgdir(p->pgdir, (void*)pageToWrite->va, 0);
80108677:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010867a:	83 ec 04             	sub    $0x4,%esp
8010867d:	6a 00                	push   $0x0
8010867f:	8d 14 83             	lea    (%ebx,%eax,4),%edx
80108682:	ff b2 d8 01 00 00    	pushl  0x1d8(%edx)
80108688:	ff 73 04             	pushl  0x4(%ebx)
8010868b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010868e:	e8 2d f1 ff ff       	call   801077c0 <nonStaticWalkpgdir>

  addSwappedNode(pageToWrite->va);
80108693:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  pte_t *pte = walkpgdir(p->pgdir, (void*)pageToWrite->va, 0);
80108696:	89 c7                	mov    %eax,%edi
  addSwappedNode(pageToWrite->va);
80108698:	59                   	pop    %ecx
80108699:	ff b2 d8 01 00 00    	pushl  0x1d8(%edx)
8010869f:	e8 cc f6 ff ff       	call   80107d70 <addSwappedNode>

  acquire(&tickslock);
801086a4:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
801086ab:	e8 f0 cb ff ff       	call   801052a0 <acquire>
  if(*pte & PTE_A){
801086b0:	8b 07                	mov    (%edi),%eax
801086b2:	83 c4 10             	add    $0x10,%esp
801086b5:	a8 20                	test   $0x20,%al
801086b7:	74 05                	je     801086be <writePageToSwapFile+0x5e>
    *pte &= ~PTE_A;
801086b9:	83 e0 df             	and    $0xffffffdf,%eax
801086bc:	89 07                	mov    %eax,(%edi)
  }
  release(&tickslock);
801086be:	83 ec 0c             	sub    $0xc,%esp
801086c1:	68 80 93 15 80       	push   $0x80159380
801086c6:	e8 95 cc ff ff       	call   80105360 <release>


  int offset = p->swappedPGs[indexInSwapFile((uint)pageToWrite->va)].offset;
801086cb:	8d 04 b6             	lea    (%esi,%esi,4),%eax
801086ce:	5a                   	pop    %edx
801086cf:	8d 34 83             	lea    (%ebx,%eax,4),%esi
801086d2:	ff b6 d8 01 00 00    	pushl  0x1d8(%esi)
801086d8:	e8 43 f8 ff ff       	call   80107f20 <indexInSwapFile>
801086dd:	8d 04 80             	lea    (%eax,%eax,4),%eax


  if(writeToSwapFile(p,(char*)PTE_ADDR(pageToWrite->va),offset, PGSIZE)<=0){
801086e0:	68 00 10 00 00       	push   $0x1000
801086e5:	ff b4 83 98 00 00 00 	pushl  0x98(%ebx,%eax,4)
801086ec:	8b 86 d8 01 00 00    	mov    0x1d8(%esi),%eax
801086f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801086f7:	50                   	push   %eax
801086f8:	53                   	push   %ebx
801086f9:	e8 62 9d ff ff       	call   80102460 <writeToSwapFile>
801086fe:	83 c4 20             	add    $0x20,%esp
80108701:	85 c0                	test   %eax,%eax
80108703:	7e 65                	jle    8010876a <writePageToSwapFile+0x10a>
    panic("scfifoWriteToSwap: writeToSwapFile");
  }

  kfree((char*)(P2V(PTE_ADDR(*pte))));
80108705:	8b 07                	mov    (%edi),%eax
80108707:	83 ec 0c             	sub    $0xc,%esp
8010870a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010870f:	05 00 00 00 80       	add    $0x80000000,%eax
80108714:	50                   	push   %eax
80108715:	e8 46 a2 ff ff       	call   80102960 <kfree>


  //}
  *pte |= PTE_PG;
  *pte &= ~PTE_P;
8010871a:	8b 07                	mov    (%edi),%eax
8010871c:	83 e0 fe             	and    $0xfffffffe,%eax
8010871f:	80 cc 02             	or     $0x2,%ah
80108722:	89 07                	mov    %eax,(%edi)
  //*pte &= ~PTE_COW;

  removePhysicalNode(pageToWrite->va);
80108724:	58                   	pop    %eax
80108725:	ff b6 d8 01 00 00    	pushl  0x1d8(%esi)
8010872b:	e8 50 fa ff ff       	call   80108180 <removePhysicalNode>

  lcr3(V2P(p->pgdir));  // switch to process's address space
80108730:	8b 43 04             	mov    0x4(%ebx),%eax
80108733:	05 00 00 00 80       	add    $0x80000000,%eax
80108738:	0f 22 d8             	mov    %eax,%cr3
  

 
  myproc()->nPgsPhysical--;
8010873b:	e8 e0 b9 ff ff       	call   80104120 <myproc>
80108740:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
  myproc()->nTotalPGout++;
80108747:	e8 d4 b9 ff ff       	call   80104120 <myproc>
8010874c:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
  myproc()->nPgsSwap++;
80108753:	e8 c8 b9 ff ff       	call   80104120 <myproc>
}
80108758:	83 c4 10             	add    $0x10,%esp
  myproc()->nPgsSwap++;
8010875b:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
}
80108762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108765:	5b                   	pop    %ebx
80108766:	5e                   	pop    %esi
80108767:	5f                   	pop    %edi
80108768:	5d                   	pop    %ebp
80108769:	c3                   	ret    
    panic("scfifoWriteToSwap: writeToSwapFile");
8010876a:	83 ec 0c             	sub    $0xc,%esp
8010876d:	68 f0 96 10 80       	push   $0x801096f0
80108772:	e8 19 7c ff ff       	call   80100390 <panic>
80108777:	89 f6                	mov    %esi,%esi
80108779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108780 <allocuvm>:
{
80108780:	55                   	push   %ebp
80108781:	89 e5                	mov    %esp,%ebp
80108783:	57                   	push   %edi
80108784:	56                   	push   %esi
80108785:	53                   	push   %ebx
80108786:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108789:	8b 7d 10             	mov    0x10(%ebp),%edi
8010878c:	85 ff                	test   %edi,%edi
8010878e:	0f 88 b5 00 00 00    	js     80108849 <allocuvm+0xc9>
  if(newsz < oldsz)
80108794:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108797:	0f 82 bb 00 00 00    	jb     80108858 <allocuvm+0xd8>
  a = PGROUNDUP(oldsz);
8010879d:	8b 45 0c             	mov    0xc(%ebp),%eax
801087a0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801087a6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801087ac:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801087af:	0f 86 a6 00 00 00    	jbe    8010885b <allocuvm+0xdb>
801087b5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801087b8:	8b 7d 08             	mov    0x8(%ebp),%edi
801087bb:	eb 56                	jmp    80108813 <allocuvm+0x93>
801087bd:	8d 76 00             	lea    0x0(%esi),%esi
    mem = kalloc();
801087c0:	e8 ab a3 ff ff       	call   80102b70 <kalloc>
    if(mem == 0){
801087c5:	85 c0                	test   %eax,%eax
    mem = kalloc();
801087c7:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801087c9:	74 66                	je     80108831 <allocuvm+0xb1>
  lcr3(V2P(p->pgdir));
}

int
initPhysicalPage(char *va){
  addPhysicalNode((uint) va);
801087cb:	83 ec 0c             	sub    $0xc,%esp
801087ce:	53                   	push   %ebx
801087cf:	e8 fc f5 ff ff       	call   80107dd0 <addPhysicalNode>
    memset(mem, 0, PGSIZE);
801087d4:	83 c4 0c             	add    $0xc,%esp
801087d7:	68 00 10 00 00       	push   $0x1000
801087dc:	6a 00                	push   $0x0
801087de:	56                   	push   %esi
801087df:	e8 cc cb ff ff       	call   801053b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801087e4:	58                   	pop    %eax
801087e5:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801087eb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801087f0:	5a                   	pop    %edx
801087f1:	6a 06                	push   $0x6
801087f3:	50                   	push   %eax
801087f4:	89 da                	mov    %ebx,%edx
801087f6:	89 f8                	mov    %edi,%eax
801087f8:	e8 53 f0 ff ff       	call   80107850 <mappages>
801087fd:	83 c4 10             	add    $0x10,%esp
80108800:	85 c0                	test   %eax,%eax
80108802:	78 64                	js     80108868 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80108804:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010880a:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010880d:	0f 86 95 00 00 00    	jbe    801088a8 <allocuvm+0x128>
      if(myproc()->nPgsPhysical >= MAX_PSYC_PAGES){
80108813:	e8 08 b9 ff ff       	call   80104120 <myproc>
80108818:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
8010881f:	7e 9f                	jle    801087c0 <allocuvm+0x40>
        writePageToSwapFile();
80108821:	e8 3a fe ff ff       	call   80108660 <writePageToSwapFile>
    mem = kalloc();
80108826:	e8 45 a3 ff ff       	call   80102b70 <kalloc>
    if(mem == 0){
8010882b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010882d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010882f:	75 9a                	jne    801087cb <allocuvm+0x4b>
      cprintf("allocuvm out of memory\n");
80108831:	83 ec 0c             	sub    $0xc,%esp
80108834:	68 42 95 10 80       	push   $0x80109542
80108839:	e8 22 7e ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz){
8010883e:	83 c4 10             	add    $0x10,%esp
80108841:	8b 45 0c             	mov    0xc(%ebp),%eax
80108844:	39 45 10             	cmp    %eax,0x10(%ebp)
80108847:	77 6f                	ja     801088b8 <allocuvm+0x138>
}
80108849:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
8010884c:	31 ff                	xor    %edi,%edi
}
8010884e:	89 f8                	mov    %edi,%eax
80108850:	5b                   	pop    %ebx
80108851:	5e                   	pop    %esi
80108852:	5f                   	pop    %edi
80108853:	5d                   	pop    %ebp
80108854:	c3                   	ret    
80108855:	8d 76 00             	lea    0x0(%esi),%esi
    return oldsz;
80108858:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010885b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010885e:	89 f8                	mov    %edi,%eax
80108860:	5b                   	pop    %ebx
80108861:	5e                   	pop    %esi
80108862:	5f                   	pop    %edi
80108863:	5d                   	pop    %ebp
80108864:	c3                   	ret    
80108865:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108868:	83 ec 0c             	sub    $0xc,%esp
8010886b:	68 5a 95 10 80       	push   $0x8010955a
80108870:	e8 eb 7d ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz){
80108875:	83 c4 10             	add    $0x10,%esp
80108878:	8b 45 0c             	mov    0xc(%ebp),%eax
8010887b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010887e:	76 0d                	jbe    8010888d <allocuvm+0x10d>
80108880:	89 c1                	mov    %eax,%ecx
80108882:	8b 55 10             	mov    0x10(%ebp),%edx
80108885:	8b 45 08             	mov    0x8(%ebp),%eax
80108888:	e8 a3 f9 ff ff       	call   80108230 <deallocuvm.part.1>
      kfree(mem);
8010888d:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108890:	31 ff                	xor    %edi,%edi
      kfree(mem);
80108892:	56                   	push   %esi
80108893:	e8 c8 a0 ff ff       	call   80102960 <kfree>
      return 0;
80108898:	83 c4 10             	add    $0x10,%esp
}
8010889b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010889e:	89 f8                	mov    %edi,%eax
801088a0:	5b                   	pop    %ebx
801088a1:	5e                   	pop    %esi
801088a2:	5f                   	pop    %edi
801088a3:	5d                   	pop    %ebp
801088a4:	c3                   	ret    
801088a5:	8d 76 00             	lea    0x0(%esi),%esi
801088a8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801088ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801088ae:	5b                   	pop    %ebx
801088af:	89 f8                	mov    %edi,%eax
801088b1:	5e                   	pop    %esi
801088b2:	5f                   	pop    %edi
801088b3:	5d                   	pop    %ebp
801088b4:	c3                   	ret    
801088b5:	8d 76 00             	lea    0x0(%esi),%esi
801088b8:	89 c1                	mov    %eax,%ecx
801088ba:	8b 55 10             	mov    0x10(%ebp),%edx
801088bd:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801088c0:	31 ff                	xor    %edi,%edi
801088c2:	e8 69 f9 ff ff       	call   80108230 <deallocuvm.part.1>
801088c7:	eb 92                	jmp    8010885b <allocuvm+0xdb>
801088c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801088d0 <swapPage>:
swapPage(uint addr){
801088d0:	55                   	push   %ebp
801088d1:	89 e5                	mov    %esp,%ebp
801088d3:	57                   	push   %edi
801088d4:	56                   	push   %esi
801088d5:	53                   	push   %ebx
801088d6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
801088d9:	e8 42 b8 ff ff       	call   80104120 <myproc>
  int swapIndex = indexInSwapFile(addr);
801088de:	83 ec 0c             	sub    $0xc,%esp
801088e1:	ff 75 08             	pushl  0x8(%ebp)
  struct proc *p = myproc();
801088e4:	89 c3                	mov    %eax,%ebx
  int swapIndex = indexInSwapFile(addr);
801088e6:	e8 35 f6 ff ff       	call   80107f20 <indexInSwapFile>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
801088eb:	83 c4 10             	add    $0x10,%esp
801088ee:	83 bb 80 00 00 00 0f 	cmpl   $0xf,0x80(%ebx)
  int swapIndex = indexInSwapFile(addr);
801088f5:	89 c7                	mov    %eax,%edi
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
801088f7:	0f 8f bb 00 00 00    	jg     801089b8 <swapPage+0xe8>
  if((buf = kalloc()) == 0){
801088fd:	e8 6e a2 ff ff       	call   80102b70 <kalloc>
80108902:	85 c0                	test   %eax,%eax
80108904:	89 c6                	mov    %eax,%esi
80108906:	0f 84 c3 00 00 00    	je     801089cf <swapPage+0xff>
  memset(buf, 0, PGSIZE );
8010890c:	83 ec 04             	sub    $0x4,%esp
8010890f:	68 00 10 00 00       	push   $0x1000
80108914:	6a 00                	push   $0x0
80108916:	50                   	push   %eax
80108917:	e8 94 ca ff ff       	call   801053b0 <memset>
  if(readFromSwapFile(p, buf, swapIndex*PGSIZE, PGSIZE) <= 0){
8010891c:	89 f8                	mov    %edi,%eax
8010891e:	68 00 10 00 00       	push   $0x1000
80108923:	c1 e0 0c             	shl    $0xc,%eax
80108926:	50                   	push   %eax
80108927:	56                   	push   %esi
80108928:	53                   	push   %ebx
80108929:	e8 62 9b ff ff       	call   80102490 <readFromSwapFile>
8010892e:	83 c4 20             	add    $0x20,%esp
80108931:	85 c0                	test   %eax,%eax
80108933:	0f 8e 89 00 00 00    	jle    801089c2 <swapPage+0xf2>
  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
80108939:	8b 45 08             	mov    0x8(%ebp),%eax
8010893c:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
80108942:	83 ec 08             	sub    $0x8,%esp
80108945:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010894a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010894f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108952:	8b 43 04             	mov    0x4(%ebx),%eax
80108955:	6a 06                	push   $0x6
80108957:	52                   	push   %edx
80108958:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010895b:	e8 f0 ee ff ff       	call   80107850 <mappages>
  struct proc *p = myproc();
80108960:	e8 bb b7 ff ff       	call   80104120 <myproc>
  p->swappedPGs[index].va = EMPTY_VA;
80108965:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  p->nPgsSwap--;
80108968:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
  pte = walkpgdir(p->pgdir,(void*)addr, 0);
8010896f:	83 c4 0c             	add    $0xc,%esp
  p->swappedPGs[index].va = EMPTY_VA;
80108972:	c7 84 90 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%edx,4)
80108979:	ff ff ff ff 
  pte = walkpgdir(p->pgdir,(void*)addr, 0);
8010897d:	6a 00                	push   $0x0
8010897f:	ff 75 08             	pushl  0x8(%ebp)
80108982:	ff 73 04             	pushl  0x4(%ebx)
80108985:	e8 36 ee ff ff       	call   801077c0 <nonStaticWalkpgdir>
  *pte &= ~PTE_PG;
8010898a:	8b 10                	mov    (%eax),%edx
8010898c:	80 e6 f5             	and    $0xf5,%dh
8010898f:	83 ca 03             	or     $0x3,%edx
80108992:	89 10                	mov    %edx,(%eax)
  addPhysicalNode(addr);
80108994:	58                   	pop    %eax
80108995:	ff 75 08             	pushl  0x8(%ebp)
80108998:	e8 33 f4 ff ff       	call   80107dd0 <addPhysicalNode>
  lcr3(V2P(p->pgdir));
8010899d:	8b 43 04             	mov    0x4(%ebx),%eax
801089a0:	05 00 00 00 80       	add    $0x80000000,%eax
801089a5:	0f 22 d8             	mov    %eax,%cr3
}
801089a8:	83 c4 10             	add    $0x10,%esp
801089ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801089ae:	5b                   	pop    %ebx
801089af:	5e                   	pop    %esi
801089b0:	5f                   	pop    %edi
801089b1:	5d                   	pop    %ebp
801089b2:	c3                   	ret    
801089b3:	90                   	nop
801089b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    writePageToSwapFile();
801089b8:	e8 a3 fc ff ff       	call   80108660 <writePageToSwapFile>
801089bd:	e9 3b ff ff ff       	jmp    801088fd <swapPage+0x2d>
      panic("scfifoSwap: read from swapfile");
801089c2:	83 ec 0c             	sub    $0xc,%esp
801089c5:	68 14 97 10 80       	push   $0x80109714
801089ca:	e8 c1 79 ff ff       	call   80100390 <panic>
    panic("nfuaSwap : allocating buf");
801089cf:	83 ec 0c             	sub    $0xc,%esp
801089d2:	68 76 95 10 80       	push   $0x80109576
801089d7:	e8 b4 79 ff ff       	call   80100390 <panic>
801089dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801089e0 <initPhysicalPage>:
initPhysicalPage(char *va){
801089e0:	55                   	push   %ebp
801089e1:	89 e5                	mov    %esp,%ebp
801089e3:	83 ec 14             	sub    $0x14,%esp
  addPhysicalNode((uint) va);
801089e6:	ff 75 08             	pushl  0x8(%ebp)
801089e9:	e8 e2 f3 ff ff       	call   80107dd0 <addPhysicalNode>
  return 0;
}
801089ee:	31 c0                	xor    %eax,%eax
801089f0:	c9                   	leave  
801089f1:	c3                   	ret    
