
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
8010002d:	b8 70 36 10 80       	mov    $0x80103670,%eax
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
8010004c:	68 00 88 10 80       	push   $0x80108800
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 d5 4e 00 00       	call   80104f30 <initlock>
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
80100092:	68 07 88 10 80       	push   $0x80108807
80100097:	50                   	push   %eax
80100098:	e8 63 4d 00 00       	call   80104e00 <initsleeplock>
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
801000e4:	e8 87 4f 00 00       	call   80105070 <acquire>
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
80100162:	e8 c9 4f 00 00       	call   80105130 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 4c 00 00       	call   80104e40 <acquiresleep>
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
80100193:	68 0e 88 10 80       	push   $0x8010880e
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
801001ae:	e8 2d 4d 00 00       	call   80104ee0 <holdingsleep>
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
801001cc:	68 1f 88 10 80       	push   $0x8010881f
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
801001ef:	e8 ec 4c 00 00       	call   80104ee0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 4c 00 00       	call   80104ea0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 60 4e 00 00       	call   80105070 <acquire>
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
8010025c:	e9 cf 4e 00 00       	jmp    80105130 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 88 10 80       	push   $0x80108826
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
8010028c:	e8 df 4d 00 00       	call   80105070 <acquire>
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
801002c5:	e8 46 45 00 00       	call   80104810 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 80 3d 00 00       	call   80104060 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 3c 4e 00 00       	call   80105130 <release>
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
8010034d:	e8 de 4d 00 00       	call   80105130 <release>
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
801003a9:	e8 52 2b 00 00       	call   80102f00 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 2d 88 10 80       	push   $0x8010882d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 0c 94 10 80 	movl   $0x8010940c,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 73 4b 00 00       	call   80104f50 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 41 88 10 80       	push   $0x80108841
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
8010043a:	e8 11 66 00 00       	call   80106a50 <uartputc>
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
801004ec:	e8 5f 65 00 00       	call   80106a50 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 53 65 00 00       	call   80106a50 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 47 65 00 00       	call   80106a50 <uartputc>
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
80100524:	e8 07 4d 00 00       	call   80105230 <memmove>
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
80100541:	e8 3a 4c 00 00       	call   80105180 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 45 88 10 80       	push   $0x80108845
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
801005b1:	0f b6 92 70 88 10 80 	movzbl -0x7fef7790(%edx),%edx
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
8010061b:	e8 50 4a 00 00       	call   80105070 <acquire>
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
80100647:	e8 e4 4a 00 00       	call   80105130 <release>
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
8010071f:	e8 0c 4a 00 00       	call   80105130 <release>
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
801007d0:	ba 58 88 10 80       	mov    $0x80108858,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 7b 48 00 00       	call   80105070 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 5f 88 10 80       	push   $0x8010885f
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
80100823:	e8 48 48 00 00       	call   80105070 <acquire>
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
80100888:	e8 a3 48 00 00       	call   80105130 <release>
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
80100916:	e8 15 41 00 00       	call   80104a30 <wakeup>
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
80100997:	e9 74 41 00 00       	jmp    80104b10 <procdump>
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
801009c6:	68 68 88 10 80       	push   $0x80108868
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 5b 45 00 00       	call   80104f30 <initlock>

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
80100a1e:	e8 3d 36 00 00       	call   80104060 <myproc>
80100a23:	8d 98 98 00 00 00    	lea    0x98(%eax),%ebx
80100a29:	89 85 74 fc ff ff    	mov    %eax,-0x38c(%ebp)
80100a2f:	89 de                	mov    %ebx,%esi
80100a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  //memmove(physicalPGs,curproc->physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
    // if(curproc->physicalPGs[i].va!=EMPTY_VA){
    //   buRefs[i] = getReferenceCount((uint)curproc->physicalPGs[i].va);
    // }
    resetRefCounter((uint)curproc->physicalPGs[i].va);
80100a38:	83 ec 0c             	sub    $0xc,%esp
80100a3b:	ff b6 40 01 00 00    	pushl  0x140(%esi)
80100a41:	83 c6 14             	add    $0x14,%esi
80100a44:	e8 37 21 00 00       	call   80102b80 <resetRefCounter>
    physicalPGs[i].next = curproc->physicalPGs[i].next;
80100a49:	8b 86 38 01 00 00    	mov    0x138(%esi),%eax
    curproc->physicalPGs[i].next = 0;
    curproc->physicalPGs[i].prev = 0;
    curproc->physicalPGs[i].age = 0;
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
80100b50:	e8 1b 28 00 00       	call   80103370 <begin_op>

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

  if(pgdir)
80100c32:	8b 85 70 fc ff ff    	mov    -0x390(%ebp),%eax
80100c38:	85 c0                	test   %eax,%eax
80100c3a:	74 0c                	je     80100c48 <exec+0x238>
    freevm(pgdir);
80100c3c:	83 ec 0c             	sub    $0xc,%esp
80100c3f:	50                   	push   %eax
80100c40:	e8 2b 74 00 00       	call   80108070 <freevm>
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
80100c5a:	e8 81 27 00 00       	call   801033e0 <end_op>
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
80100c80:	e8 6b 74 00 00       	call   801080f0 <setupkvm>
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
80100cee:	e8 7d 79 00 00       	call   80108670 <allocuvm>
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
80100d20:	e8 3b 6b 00 00       	call   80107860 <loaduvm>
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
80100d98:	e8 43 26 00 00       	call   801033e0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d9d:	8b 85 60 fc ff ff    	mov    -0x3a0(%ebp),%eax
80100da3:	83 c4 0c             	add    $0xc,%esp
80100da6:	50                   	push   %eax
80100da7:	57                   	push   %edi
80100da8:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100dae:	e8 bd 78 00 00       	call   80108670 <allocuvm>
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
80100dd6:	e8 45 6b 00 00       	call   80107920 <clearpteu>
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
80100e18:	e8 83 45 00 00       	call   801053a0 <strlen>
80100e1d:	f7 d0                	not    %eax
80100e1f:	01 d8                	add    %ebx,%eax
80100e21:	83 e0 fc             	and    $0xfffffffc,%eax
80100e24:	89 c3                	mov    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e26:	58                   	pop    %eax
80100e27:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e2a:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e2d:	e8 6e 45 00 00       	call   801053a0 <strlen>
80100e32:	83 c0 01             	add    $0x1,%eax
80100e35:	50                   	push   %eax
80100e36:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e39:	ff 34 b8             	pushl  (%eax,%edi,4)
80100e3c:	53                   	push   %ebx
80100e3d:	ff b5 70 fc ff ff    	pushl  -0x390(%ebp)
80100e43:	e8 48 6b 00 00       	call   80107990 <copyout>
80100e48:	83 c4 20             	add    $0x20,%esp
80100e4b:	85 c0                	test   %eax,%eax
80100e4d:	79 a6                	jns    80100df5 <exec+0x3e5>
80100e4f:	89 f3                	mov    %esi,%ebx
  ip = 0;
80100e51:	31 f6                	xor    %esi,%esi
80100e53:	e9 45 fd ff ff       	jmp    80100b9d <exec+0x18d>
    end_op();
80100e58:	e8 83 25 00 00       	call   801033e0 <end_op>
    cprintf("exec: fail\n");
80100e5d:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80100e60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    cprintf("exec: fail\n");
80100e65:	68 81 88 10 80       	push   $0x80108881
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
80100ec7:	e8 c4 6a 00 00       	call   80107990 <copyout>
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
80100f08:	e8 53 44 00 00       	call   80105360 <safestrcpy>
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
80100f38:	e8 93 67 00 00       	call   801076d0 <switchuvm>
  freevm(oldpgdir);
80100f3d:	89 34 24             	mov    %esi,(%esp)
80100f40:	e8 2b 71 00 00       	call   80108070 <freevm>
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
80100f76:	68 8d 88 10 80       	push   $0x8010888d
80100f7b:	68 c0 1f 11 80       	push   $0x80111fc0
80100f80:	e8 ab 3f 00 00       	call   80104f30 <initlock>
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
80100fa1:	e8 ca 40 00 00       	call   80105070 <acquire>
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
80100fd1:	e8 5a 41 00 00       	call   80105130 <release>
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
80100fea:	e8 41 41 00 00       	call   80105130 <release>
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
8010100f:	e8 5c 40 00 00       	call   80105070 <acquire>
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
8010102c:	e8 ff 40 00 00       	call   80105130 <release>
  return f;
}
80101031:	89 d8                	mov    %ebx,%eax
80101033:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101036:	c9                   	leave  
80101037:	c3                   	ret    
    panic("filedup");
80101038:	83 ec 0c             	sub    $0xc,%esp
8010103b:	68 94 88 10 80       	push   $0x80108894
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
80101061:	e8 0a 40 00 00       	call   80105070 <acquire>
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
8010108c:	e9 9f 40 00 00       	jmp    80105130 <release>
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
801010b8:	e8 73 40 00 00       	call   80105130 <release>
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
801010e1:	e8 3a 2a 00 00       	call   80103b20 <pipeclose>
801010e6:	83 c4 10             	add    $0x10,%esp
801010e9:	eb df                	jmp    801010ca <fileclose+0x7a>
801010eb:	90                   	nop
801010ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
801010f0:	e8 7b 22 00 00       	call   80103370 <begin_op>
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
8010110a:	e9 d1 22 00 00       	jmp    801033e0 <end_op>
    panic("fileclose");
8010110f:	83 ec 0c             	sub    $0xc,%esp
80101112:	68 9c 88 10 80       	push   $0x8010889c
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
801011dd:	e9 ee 2a 00 00       	jmp    80103cd0 <piperead>
801011e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801011e8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801011ed:	eb d7                	jmp    801011c6 <fileread+0x56>
  panic("fileread");
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	68 a6 88 10 80       	push   $0x801088a6
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
80101259:	e8 82 21 00 00       	call   801033e0 <end_op>
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
80101286:	e8 e5 20 00 00       	call   80103370 <begin_op>
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
801012bd:	e8 1e 21 00 00       	call   801033e0 <end_op>
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
801012fd:	e9 be 28 00 00       	jmp    80103bc0 <pipewrite>
        panic("short filewrite");
80101302:	83 ec 0c             	sub    $0xc,%esp
80101305:	68 af 88 10 80       	push   $0x801088af
8010130a:	e8 81 f0 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010130f:	83 ec 0c             	sub    $0xc,%esp
80101312:	68 b5 88 10 80       	push   $0x801088b5
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
80101369:	e8 d2 21 00 00       	call   80103540 <log_write>
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
80101383:	68 bf 88 10 80       	push   $0x801088bf
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
80101434:	68 d2 88 10 80       	push   $0x801088d2
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
8010144d:	e8 ee 20 00 00       	call   80103540 <log_write>
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
80101475:	e8 06 3d 00 00       	call   80105180 <memset>
  log_write(bp);
8010147a:	89 1c 24             	mov    %ebx,(%esp)
8010147d:	e8 be 20 00 00       	call   80103540 <log_write>
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
801014ba:	e8 b1 3b 00 00       	call   80105070 <acquire>
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
8010151f:	e8 0c 3c 00 00       	call   80105130 <release>

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
8010154d:	e8 de 3b 00 00       	call   80105130 <release>
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
80101562:	68 e8 88 10 80       	push   $0x801088e8
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
801015de:	e8 5d 1f 00 00       	call   80103540 <log_write>
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
80101637:	68 f8 88 10 80       	push   $0x801088f8
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
80101671:	e8 ba 3b 00 00       	call   80105230 <memmove>
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
8010169c:	68 0b 89 10 80       	push   $0x8010890b
801016a1:	68 e0 29 11 80       	push   $0x801129e0
801016a6:	e8 85 38 00 00       	call   80104f30 <initlock>
801016ab:	83 c4 10             	add    $0x10,%esp
801016ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801016b0:	83 ec 08             	sub    $0x8,%esp
801016b3:	68 12 89 10 80       	push   $0x80108912
801016b8:	53                   	push   %ebx
801016b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801016bf:	e8 3c 37 00 00       	call   80104e00 <initsleeplock>
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
80101709:	68 bc 89 10 80       	push   $0x801089bc
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
8010179e:	e8 dd 39 00 00       	call   80105180 <memset>
      dip->type = type;
801017a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801017a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801017aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801017ad:	89 3c 24             	mov    %edi,(%esp)
801017b0:	e8 8b 1d 00 00       	call   80103540 <log_write>
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
801017d3:	68 18 89 10 80       	push   $0x80108918
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
80101841:	e8 ea 39 00 00       	call   80105230 <memmove>
  log_write(bp);
80101846:	89 34 24             	mov    %esi,(%esp)
80101849:	e8 f2 1c 00 00       	call   80103540 <log_write>
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
8010186f:	e8 fc 37 00 00       	call   80105070 <acquire>
  ip->ref++;
80101874:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101878:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010187f:	e8 ac 38 00 00       	call   80105130 <release>
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
801018b2:	e8 89 35 00 00       	call   80104e40 <acquiresleep>
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
80101928:	e8 03 39 00 00       	call   80105230 <memmove>
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
8010194d:	68 30 89 10 80       	push   $0x80108930
80101952:	e8 39 ea ff ff       	call   80100390 <panic>
    panic("ilock");
80101957:	83 ec 0c             	sub    $0xc,%esp
8010195a:	68 2a 89 10 80       	push   $0x8010892a
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
80101983:	e8 58 35 00 00       	call   80104ee0 <holdingsleep>
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
8010199f:	e9 fc 34 00 00       	jmp    80104ea0 <releasesleep>
    panic("iunlock");
801019a4:	83 ec 0c             	sub    $0xc,%esp
801019a7:	68 3f 89 10 80       	push   $0x8010893f
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
801019d0:	e8 6b 34 00 00       	call   80104e40 <acquiresleep>
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
801019ea:	e8 b1 34 00 00       	call   80104ea0 <releasesleep>
  acquire(&icache.lock);
801019ef:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801019f6:	e8 75 36 00 00       	call   80105070 <acquire>
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
80101a10:	e9 1b 37 00 00       	jmp    80105130 <release>
80101a15:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101a18:	83 ec 0c             	sub    $0xc,%esp
80101a1b:	68 e0 29 11 80       	push   $0x801129e0
80101a20:	e8 4b 36 00 00       	call   80105070 <acquire>
    int r = ip->ref;
80101a25:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a28:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101a2f:	e8 fc 36 00 00       	call   80105130 <release>
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
80101c17:	e8 14 36 00 00       	call   80105230 <memmove>
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
80101d13:	e8 18 35 00 00       	call   80105230 <memmove>
    log_write(bp);
80101d18:	89 3c 24             	mov    %edi,(%esp)
80101d1b:	e8 20 18 00 00       	call   80103540 <log_write>
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
80101dae:	e8 ed 34 00 00       	call   801052a0 <strncmp>
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
80101e0d:	e8 8e 34 00 00       	call   801052a0 <strncmp>
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
80101e52:	68 59 89 10 80       	push   $0x80108959
80101e57:	e8 34 e5 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101e5c:	83 ec 0c             	sub    $0xc,%esp
80101e5f:	68 47 89 10 80       	push   $0x80108947
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
80101e89:	e8 d2 21 00 00       	call   80104060 <myproc>
  acquire(&icache.lock);
80101e8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e91:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e94:	68 e0 29 11 80       	push   $0x801129e0
80101e99:	e8 d2 31 00 00       	call   80105070 <acquire>
  ip->ref++;
80101e9e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ea2:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101ea9:	e8 82 32 00 00       	call   80105130 <release>
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
80101f05:	e8 26 33 00 00       	call   80105230 <memmove>
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
80101f98:	e8 93 32 00 00       	call   80105230 <memmove>
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
8010208d:	e8 6e 32 00 00       	call   80105300 <strncpy>
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
801020cb:	68 68 89 10 80       	push   $0x80108968
801020d0:	e8 bb e2 ff ff       	call   80100390 <panic>
    panic("dirlink");
801020d5:	83 ec 0c             	sub    $0xc,%esp
801020d8:	68 d5 90 10 80       	push   $0x801090d5
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
801021d1:	68 75 89 10 80       	push   $0x80108975
801021d6:	56                   	push   %esi
801021d7:	e8 54 30 00 00       	call   80105230 <memmove>
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
80102204:	e8 67 11 00 00       	call   80103370 <begin_op>
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
80102232:	68 7d 89 10 80       	push   $0x8010897d
80102237:	53                   	push   %ebx
80102238:	e8 63 30 00 00       	call   801052a0 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010223d:	83 c4 10             	add    $0x10,%esp
80102240:	85 c0                	test   %eax,%eax
80102242:	0f 84 f8 00 00 00    	je     80102340 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
80102248:	83 ec 04             	sub    $0x4,%esp
8010224b:	6a 0e                	push   $0xe
8010224d:	68 7c 89 10 80       	push   $0x8010897c
80102252:	53                   	push   %ebx
80102253:	e8 48 30 00 00       	call   801052a0 <strncmp>
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
801022a7:	e8 d4 2e 00 00       	call   80105180 <memset>
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
801022fd:	e8 de 10 00 00       	call   801033e0 <end_op>

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
80102314:	e8 47 36 00 00       	call   80105960 <isdirempty>
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
80102351:	e8 8a 10 00 00       	call   801033e0 <end_op>
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
8010238a:	e8 51 10 00 00       	call   801033e0 <end_op>
    return -1;
8010238f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102394:	e9 6e ff ff ff       	jmp    80102307 <removeSwapFile+0x147>
    panic("unlink: writei");
80102399:	83 ec 0c             	sub    $0xc,%esp
8010239c:	68 91 89 10 80       	push   $0x80108991
801023a1:	e8 ea df ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801023a6:	83 ec 0c             	sub    $0xc,%esp
801023a9:	68 7f 89 10 80       	push   $0x8010897f
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
801023d0:	68 75 89 10 80       	push   $0x80108975
801023d5:	56                   	push   %esi
801023d6:	e8 55 2e 00 00       	call   80105230 <memmove>
  itoa(p->pid, path+ 6);
801023db:	58                   	pop    %eax
801023dc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801023df:	5a                   	pop    %edx
801023e0:	50                   	push   %eax
801023e1:	ff 73 10             	pushl  0x10(%ebx)
801023e4:	e8 47 fd ff ff       	call   80102130 <itoa>

    begin_op();
801023e9:	e8 82 0f 00 00       	call   80103370 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
801023ee:	6a 00                	push   $0x0
801023f0:	6a 00                	push   $0x0
801023f2:	6a 02                	push   $0x2
801023f4:	56                   	push   %esi
801023f5:	e8 76 37 00 00       	call   80105b70 <create>
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
80102438:	e8 a3 0f 00 00       	call   801033e0 <end_op>

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
80102449:	68 a0 89 10 80       	push   $0x801089a0
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
8010257b:	68 18 8a 10 80       	push   $0x80108a18
80102580:	e8 0b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102585:	83 ec 0c             	sub    $0xc,%esp
80102588:	68 0f 8a 10 80       	push   $0x80108a0f
8010258d:	e8 fe dd ff ff       	call   80100390 <panic>
80102592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801025a0 <ideinit>:
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801025a6:	68 2a 8a 10 80       	push   $0x80108a2a
801025ab:	68 80 c5 10 80       	push   $0x8010c580
801025b0:	e8 7b 29 00 00       	call   80104f30 <initlock>
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
8010262e:	e8 3d 2a 00 00       	call   80105070 <acquire>

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
80102691:	e8 9a 23 00 00       	call   80104a30 <wakeup>

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
801026af:	e8 7c 2a 00 00       	call   80105130 <release>

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
801026ce:	e8 0d 28 00 00       	call   80104ee0 <holdingsleep>
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
80102708:	e8 63 29 00 00       	call   80105070 <acquire>

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
80102759:	e8 b2 20 00 00       	call   80104810 <sleep>
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
80102776:	e9 b5 29 00 00       	jmp    80105130 <release>
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
8010279a:	68 44 8a 10 80       	push   $0x80108a44
8010279f:	e8 ec db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 2e 8a 10 80       	push   $0x80108a2e
801027ac:	e8 df db ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801027b1:	83 ec 0c             	sub    $0xc,%esp
801027b4:	68 59 8a 10 80       	push   $0x80108a59
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
80102807:	68 78 8a 10 80       	push   $0x80108a78
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

801028b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801028b0:	55                   	push   %ebp
801028b1:	89 e5                	mov    %esp,%ebp
801028b3:	56                   	push   %esi
801028b4:	53                   	push   %ebx
801028b5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801028b8:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
801028be:	0f 85 b9 00 00 00    	jne    8010297d <kfree+0xcd>
801028c4:	81 fe c8 9b 15 80    	cmp    $0x80159bc8,%esi
801028ca:	0f 82 ad 00 00 00    	jb     8010297d <kfree+0xcd>
801028d0:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
801028d6:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
801028dc:	0f 87 9b 00 00 00    	ja     8010297d <kfree+0xcd>
    panic("kfree1");

  if(kmem.use_lock)
801028e2:	8b 15 74 46 11 80    	mov    0x80114674,%edx
801028e8:	85 d2                	test   %edx,%edx
801028ea:	75 7c                	jne    80102968 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;

  if(kmem.pg_refcount[index(V2P(v))] > 0){
801028ec:	c1 eb 0c             	shr    $0xc,%ebx
801028ef:	83 c3 10             	add    $0x10,%ebx
801028f2:	8b 04 9d 40 46 11 80 	mov    -0x7feeb9c0(,%ebx,4),%eax
801028f9:	85 c0                	test   %eax,%eax
801028fb:	75 3b                	jne    80102938 <kfree+0x88>
    --kmem.pg_refcount[index(V2P(v))];
  }
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
801028fd:	83 ec 04             	sub    $0x4,%esp
80102900:	68 00 10 00 00       	push   $0x1000
80102905:	6a 01                	push   $0x1
80102907:	56                   	push   %esi
80102908:	e8 73 28 00 00       	call   80105180 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
8010290d:	a1 78 46 11 80       	mov    0x80114678,%eax
    kmem.free_pages++;
80102912:	83 05 7c 46 11 80 01 	addl   $0x1,0x8011467c
    kmem.freelist = r;
80102919:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
8010291c:	89 06                	mov    %eax,(%esi)
  }

  if(kmem.use_lock)
8010291e:	a1 74 46 11 80       	mov    0x80114674,%eax
    kmem.freelist = r;
80102923:	89 35 78 46 11 80    	mov    %esi,0x80114678
  if(kmem.use_lock)
80102929:	85 c0                	test   %eax,%eax
8010292b:	75 22                	jne    8010294f <kfree+0x9f>
    release(&kmem.lock);
}
8010292d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102930:	5b                   	pop    %ebx
80102931:	5e                   	pop    %esi
80102932:	5d                   	pop    %ebp
80102933:	c3                   	ret    
80102934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    --kmem.pg_refcount[index(V2P(v))];
80102938:	83 e8 01             	sub    $0x1,%eax
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
8010293b:	85 c0                	test   %eax,%eax
    --kmem.pg_refcount[index(V2P(v))];
8010293d:	89 04 9d 40 46 11 80 	mov    %eax,-0x7feeb9c0(,%ebx,4)
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
80102944:	74 b7                	je     801028fd <kfree+0x4d>
  if(kmem.use_lock)
80102946:	a1 74 46 11 80       	mov    0x80114674,%eax
8010294b:	85 c0                	test   %eax,%eax
8010294d:	74 de                	je     8010292d <kfree+0x7d>
    release(&kmem.lock);
8010294f:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102956:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102959:	5b                   	pop    %ebx
8010295a:	5e                   	pop    %esi
8010295b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010295c:	e9 cf 27 00 00       	jmp    80105130 <release>
80102961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102968:	83 ec 0c             	sub    $0xc,%esp
8010296b:	68 40 46 11 80       	push   $0x80114640
80102970:	e8 fb 26 00 00       	call   80105070 <acquire>
80102975:	83 c4 10             	add    $0x10,%esp
80102978:	e9 6f ff ff ff       	jmp    801028ec <kfree+0x3c>
    panic("kfree1");
8010297d:	83 ec 0c             	sub    $0xc,%esp
80102980:	68 aa 8a 10 80       	push   $0x80108aaa
80102985:	e8 06 da ff ff       	call   80100390 <panic>
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102990 <freerange>:
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	56                   	push   %esi
80102994:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102995:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102998:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010299b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801029a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029ad:	39 de                	cmp    %ebx,%esi
801029af:	72 23                	jb     801029d4 <freerange+0x44>
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801029b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801029be:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801029c7:	50                   	push   %eax
801029c8:	e8 e3 fe ff ff       	call   801028b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029cd:	83 c4 10             	add    $0x10,%esp
801029d0:	39 f3                	cmp    %esi,%ebx
801029d2:	76 e4                	jbe    801029b8 <freerange+0x28>
}
801029d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029d7:	5b                   	pop    %ebx
801029d8:	5e                   	pop    %esi
801029d9:	5d                   	pop    %ebp
801029da:	c3                   	ret    
801029db:	90                   	nop
801029dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801029e0 <kinit1>:
{
801029e0:	55                   	push   %ebp
801029e1:	89 e5                	mov    %esp,%ebp
801029e3:	56                   	push   %esi
801029e4:	53                   	push   %ebx
801029e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801029e8:	83 ec 08             	sub    $0x8,%esp
801029eb:	68 b1 8a 10 80       	push   $0x80108ab1
801029f0:	68 40 46 11 80       	push   $0x80114640
801029f5:	e8 36 25 00 00       	call   80104f30 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801029fa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029fd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a00:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102a07:	00 00 00 
  kmem.free_pages = 0;
80102a0a:	c7 05 7c 46 11 80 00 	movl   $0x0,0x8011467c
80102a11:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102a14:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a1a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a20:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a26:	39 de                	cmp    %ebx,%esi
80102a28:	72 22                	jb     80102a4c <kinit1+0x6c>
80102a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kfree(p);
80102a30:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a36:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a39:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a3f:	50                   	push   %eax
80102a40:	e8 6b fe ff ff       	call   801028b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a45:	83 c4 10             	add    $0x10,%esp
80102a48:	39 de                	cmp    %ebx,%esi
80102a4a:	73 e4                	jae    80102a30 <kinit1+0x50>
}
80102a4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a4f:	5b                   	pop    %ebx
80102a50:	5e                   	pop    %esi
80102a51:	5d                   	pop    %ebp
80102a52:	c3                   	ret    
80102a53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a60 <kinit2>:
{
80102a60:	55                   	push   %ebp
80102a61:	89 e5                	mov    %esp,%ebp
80102a63:	56                   	push   %esi
80102a64:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a65:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a68:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a6b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a71:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a77:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a7d:	39 de                	cmp    %ebx,%esi
80102a7f:	72 23                	jb     80102aa4 <kinit2+0x44>
80102a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a88:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a8e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a97:	50                   	push   %eax
80102a98:	e8 13 fe ff ff       	call   801028b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a9d:	83 c4 10             	add    $0x10,%esp
80102aa0:	39 de                	cmp    %ebx,%esi
80102aa2:	73 e4                	jae    80102a88 <kinit2+0x28>
  kmem.use_lock = 1;
80102aa4:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
80102aab:	00 00 00 
}
80102aae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ab1:	5b                   	pop    %ebx
80102ab2:	5e                   	pop    %esi
80102ab3:	5d                   	pop    %ebp
80102ab4:	c3                   	ret    
80102ab5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ac0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102ac6:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102acc:	85 d2                	test   %edx,%edx
80102ace:	75 50                	jne    80102b20 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102ad0:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102ad5:	85 c0                	test   %eax,%eax
80102ad7:	74 27                	je     80102b00 <kalloc+0x40>
    kmem.freelist = r->next;
80102ad9:	8b 08                	mov    (%eax),%ecx
    kmem.free_pages--;
80102adb:	83 2d 7c 46 11 80 01 	subl   $0x1,0x8011467c
    kmem.freelist = r->next;
80102ae2:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
    kmem.pg_refcount[index(V2P((char*)r))] = 1;
80102ae8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80102aee:	c1 e9 0c             	shr    $0xc,%ecx
80102af1:	c7 04 8d 80 46 11 80 	movl   $0x1,-0x7feeb980(,%ecx,4)
80102af8:	01 00 00 00 
  }

  if(kmem.use_lock)
80102afc:	85 d2                	test   %edx,%edx
80102afe:	75 08                	jne    80102b08 <kalloc+0x48>
    release(&kmem.lock);
  return (char*)r;
}
80102b00:	c9                   	leave  
80102b01:	c3                   	ret    
80102b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102b08:	83 ec 0c             	sub    $0xc,%esp
80102b0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b0e:	68 40 46 11 80       	push   $0x80114640
80102b13:	e8 18 26 00 00       	call   80105130 <release>
  return (char*)r;
80102b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102b1b:	83 c4 10             	add    $0x10,%esp
}
80102b1e:	c9                   	leave  
80102b1f:	c3                   	ret    
    acquire(&kmem.lock);
80102b20:	83 ec 0c             	sub    $0xc,%esp
80102b23:	68 40 46 11 80       	push   $0x80114640
80102b28:	e8 43 25 00 00       	call   80105070 <acquire>
  r = kmem.freelist;
80102b2d:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102b32:	83 c4 10             	add    $0x10,%esp
80102b35:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102b3b:	85 c0                	test   %eax,%eax
80102b3d:	75 9a                	jne    80102ad9 <kalloc+0x19>
80102b3f:	eb bb                	jmp    80102afc <kalloc+0x3c>
80102b41:	eb 0d                	jmp    80102b50 <numFreePages>
80102b43:	90                   	nop
80102b44:	90                   	nop
80102b45:	90                   	nop
80102b46:	90                   	nop
80102b47:	90                   	nop
80102b48:	90                   	nop
80102b49:	90                   	nop
80102b4a:	90                   	nop
80102b4b:	90                   	nop
80102b4c:	90                   	nop
80102b4d:	90                   	nop
80102b4e:	90                   	nop
80102b4f:	90                   	nop

80102b50 <numFreePages>:

uint numFreePages(){
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	53                   	push   %ebx
80102b54:	83 ec 10             	sub    $0x10,%esp
  acquire(&kmem.lock);
80102b57:	68 40 46 11 80       	push   $0x80114640
80102b5c:	e8 0f 25 00 00       	call   80105070 <acquire>
  uint free_pages = kmem.free_pages;
80102b61:	8b 1d 7c 46 11 80    	mov    0x8011467c,%ebx
  release(&kmem.lock);
80102b67:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102b6e:	e8 bd 25 00 00       	call   80105130 <release>
  return free_pages;
}
80102b73:	89 d8                	mov    %ebx,%eax
80102b75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b78:	c9                   	leave  
80102b79:	c3                   	ret    
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b80 <resetRefCounter>:

void resetRefCounter(uint pa){
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
  kmem.pg_refcount[index(pa)] = 1;
80102b83:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102b86:	5d                   	pop    %ebp
  kmem.pg_refcount[index(pa)] = 1;
80102b87:	c1 e8 0c             	shr    $0xc,%eax
80102b8a:	c7 04 85 80 46 11 80 	movl   $0x1,-0x7feeb980(,%eax,4)
80102b91:	01 00 00 00 
}
80102b95:	c3                   	ret    
80102b96:	8d 76 00             	lea    0x0(%esi),%esi
80102b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ba0 <decrementReferenceCount>:

void decrementReferenceCount(uint pa)
{
80102ba0:	55                   	push   %ebp
80102ba1:	89 e5                	mov    %esp,%ebp
80102ba3:	53                   	push   %ebx
80102ba4:	83 ec 04             	sub    $0x4,%esp
80102ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("3");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102baa:	81 fb c8 9b 15 00    	cmp    $0x159bc8,%ebx
80102bb0:	72 33                	jb     80102be5 <decrementReferenceCount+0x45>
80102bb2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102bb8:	77 2b                	ja     80102be5 <decrementReferenceCount+0x45>
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
80102bba:	83 ec 0c             	sub    $0xc,%esp
  --kmem.pg_refcount[index(pa)];
80102bbd:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102bc0:	68 40 46 11 80       	push   $0x80114640
80102bc5:	e8 a6 24 00 00       	call   80105070 <acquire>
  --kmem.pg_refcount[index(pa)];
80102bca:	83 2c 9d 80 46 11 80 	subl   $0x1,-0x7feeb980(,%ebx,4)
80102bd1:	01 
  release(&kmem.lock);
80102bd2:	83 c4 10             	add    $0x10,%esp
80102bd5:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)

}
80102bdc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bdf:	c9                   	leave  
  release(&kmem.lock);
80102be0:	e9 4b 25 00 00       	jmp    80105130 <release>
    panic("decrementReferenceCount");
80102be5:	83 ec 0c             	sub    $0xc,%esp
80102be8:	68 b6 8a 10 80       	push   $0x80108ab6
80102bed:	e8 9e d7 ff ff       	call   80100390 <panic>
80102bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c00 <incrementReferenceCount>:

void incrementReferenceCount(uint pa)
{
80102c00:	55                   	push   %ebp
80102c01:	89 e5                	mov    %esp,%ebp
80102c03:	53                   	push   %ebx
80102c04:	83 ec 04             	sub    $0x4,%esp
80102c07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("2");
  // }
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102c0a:	81 fb c8 9b 15 00    	cmp    $0x159bc8,%ebx
80102c10:	72 33                	jb     80102c45 <incrementReferenceCount+0x45>
80102c12:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102c18:	77 2b                	ja     80102c45 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102c1a:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[index(pa)];
80102c1d:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102c20:	68 40 46 11 80       	push   $0x80114640
80102c25:	e8 46 24 00 00       	call   80105070 <acquire>
  ++kmem.pg_refcount[index(pa)];
80102c2a:	83 04 9d 80 46 11 80 	addl   $0x1,-0x7feeb980(,%ebx,4)
80102c31:	01 
  release(&kmem.lock);
80102c32:	83 c4 10             	add    $0x10,%esp
80102c35:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102c3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c3f:	c9                   	leave  
  release(&kmem.lock);
80102c40:	e9 eb 24 00 00       	jmp    80105130 <release>
    panic("incrementReferenceCount");
80102c45:	83 ec 0c             	sub    $0xc,%esp
80102c48:	68 ce 8a 10 80       	push   $0x80108ace
80102c4d:	e8 3e d7 ff ff       	call   80100390 <panic>
80102c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c60 <setReferenceCount>:

void setReferenceCount(uint pa,int n)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	56                   	push   %esi
80102c64:	53                   	push   %ebx
80102c65:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102c68:	8b 75 0c             	mov    0xc(%ebp),%esi

  if( pa >= PHYSTOP)
80102c6b:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102c71:	77 2c                	ja     80102c9f <setReferenceCount+0x3f>
    panic("setReferenceCount");

  acquire(&kmem.lock);
80102c73:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[index(pa)]= n;
80102c76:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102c79:	68 40 46 11 80       	push   $0x80114640
80102c7e:	e8 ed 23 00 00       	call   80105070 <acquire>
  kmem.pg_refcount[index(pa)]= n;
80102c83:	89 34 9d 80 46 11 80 	mov    %esi,-0x7feeb980(,%ebx,4)
  release(&kmem.lock);
80102c8a:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
80102c91:	83 c4 10             	add    $0x10,%esp
}
80102c94:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102c97:	5b                   	pop    %ebx
80102c98:	5e                   	pop    %esi
80102c99:	5d                   	pop    %ebp
  release(&kmem.lock);
80102c9a:	e9 91 24 00 00       	jmp    80105130 <release>
    panic("setReferenceCount");
80102c9f:	83 ec 0c             	sub    $0xc,%esp
80102ca2:	68 e6 8a 10 80       	push   $0x80108ae6
80102ca7:	e8 e4 d6 ff ff       	call   80100390 <panic>
80102cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cb0 <getReferenceCount>:

uint getReferenceCount(uint pa)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 04             	sub    $0x4,%esp
80102cb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("1");
  // }

  if( pa >= PHYSTOP)
80102cba:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102cc0:	77 2a                	ja     80102cec <getReferenceCount+0x3c>
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
80102cc2:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pg_refcount[index(pa)];
80102cc5:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102cc8:	68 40 46 11 80       	push   $0x80114640
80102ccd:	e8 9e 23 00 00       	call   80105070 <acquire>
  count = kmem.pg_refcount[index(pa)];
80102cd2:	8b 1c 9d 80 46 11 80 	mov    -0x7feeb980(,%ebx,4),%ebx
  release(&kmem.lock);
80102cd9:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102ce0:	e8 4b 24 00 00       	call   80105130 <release>

  return count;
}
80102ce5:	89 d8                	mov    %ebx,%eax
80102ce7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cea:	c9                   	leave  
80102ceb:	c3                   	ret    
    panic("getReferenceCount");
80102cec:	83 ec 0c             	sub    $0xc,%esp
80102cef:	68 f8 8a 10 80       	push   $0x80108af8
80102cf4:	e8 97 d6 ff ff       	call   80100390 <panic>
80102cf9:	66 90                	xchg   %ax,%ax
80102cfb:	66 90                	xchg   %ax,%ax
80102cfd:	66 90                	xchg   %ax,%ax
80102cff:	90                   	nop

80102d00 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d00:	ba 64 00 00 00       	mov    $0x64,%edx
80102d05:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102d06:	a8 01                	test   $0x1,%al
80102d08:	0f 84 c2 00 00 00    	je     80102dd0 <kbdgetc+0xd0>
80102d0e:	ba 60 00 00 00       	mov    $0x60,%edx
80102d13:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102d14:	0f b6 d0             	movzbl %al,%edx
80102d17:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102d1d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102d23:	0f 84 7f 00 00 00    	je     80102da8 <kbdgetc+0xa8>
{
80102d29:	55                   	push   %ebp
80102d2a:	89 e5                	mov    %esp,%ebp
80102d2c:	53                   	push   %ebx
80102d2d:	89 cb                	mov    %ecx,%ebx
80102d2f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102d32:	84 c0                	test   %al,%al
80102d34:	78 4a                	js     80102d80 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102d36:	85 db                	test   %ebx,%ebx
80102d38:	74 09                	je     80102d43 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102d3a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102d3d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102d40:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102d43:	0f b6 82 40 8c 10 80 	movzbl -0x7fef73c0(%edx),%eax
80102d4a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102d4c:	0f b6 82 40 8b 10 80 	movzbl -0x7fef74c0(%edx),%eax
80102d53:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102d55:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102d57:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102d5d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102d60:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102d63:	8b 04 85 20 8b 10 80 	mov    -0x7fef74e0(,%eax,4),%eax
80102d6a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102d6e:	74 31                	je     80102da1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102d70:	8d 50 9f             	lea    -0x61(%eax),%edx
80102d73:	83 fa 19             	cmp    $0x19,%edx
80102d76:	77 40                	ja     80102db8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102d78:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102d7b:	5b                   	pop    %ebx
80102d7c:	5d                   	pop    %ebp
80102d7d:	c3                   	ret    
80102d7e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102d80:	83 e0 7f             	and    $0x7f,%eax
80102d83:	85 db                	test   %ebx,%ebx
80102d85:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102d88:	0f b6 82 40 8c 10 80 	movzbl -0x7fef73c0(%edx),%eax
80102d8f:	83 c8 40             	or     $0x40,%eax
80102d92:	0f b6 c0             	movzbl %al,%eax
80102d95:	f7 d0                	not    %eax
80102d97:	21 c1                	and    %eax,%ecx
    return 0;
80102d99:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102d9b:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102da1:	5b                   	pop    %ebx
80102da2:	5d                   	pop    %ebp
80102da3:	c3                   	ret    
80102da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102da8:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102dab:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102dad:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102db3:	c3                   	ret    
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102db8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102dbb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102dbe:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102dbf:	83 f9 1a             	cmp    $0x1a,%ecx
80102dc2:	0f 42 c2             	cmovb  %edx,%eax
}
80102dc5:	5d                   	pop    %ebp
80102dc6:	c3                   	ret    
80102dc7:	89 f6                	mov    %esi,%esi
80102dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102dd5:	c3                   	ret    
80102dd6:	8d 76 00             	lea    0x0(%esi),%esi
80102dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102de0 <kbdintr>:

void
kbdintr(void)
{
80102de0:	55                   	push   %ebp
80102de1:	89 e5                	mov    %esp,%ebp
80102de3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102de6:	68 00 2d 10 80       	push   $0x80102d00
80102deb:	e8 20 da ff ff       	call   80100810 <consoleintr>
}
80102df0:	83 c4 10             	add    $0x10,%esp
80102df3:	c9                   	leave  
80102df4:	c3                   	ret    
80102df5:	66 90                	xchg   %ax,%ax
80102df7:	66 90                	xchg   %ax,%ax
80102df9:	66 90                	xchg   %ax,%ax
80102dfb:	66 90                	xchg   %ax,%ax
80102dfd:	66 90                	xchg   %ax,%ax
80102dff:	90                   	nop

80102e00 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102e00:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102e05:	55                   	push   %ebp
80102e06:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102e08:	85 c0                	test   %eax,%eax
80102e0a:	0f 84 c8 00 00 00    	je     80102ed8 <lapicinit+0xd8>
  lapic[index] = value;
80102e10:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102e17:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e1a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e1d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102e24:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e27:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e2a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102e31:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102e34:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e37:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102e3e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102e41:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e44:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102e4b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e4e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e51:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102e58:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e5b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e5e:	8b 50 30             	mov    0x30(%eax),%edx
80102e61:	c1 ea 10             	shr    $0x10,%edx
80102e64:	80 fa 03             	cmp    $0x3,%dl
80102e67:	77 77                	ja     80102ee0 <lapicinit+0xe0>
  lapic[index] = value;
80102e69:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102e70:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e73:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e76:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102e7d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e80:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e83:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102e8a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e8d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e90:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e97:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e9a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e9d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ea4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ea7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102eaa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102eb1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102eb4:	8b 50 20             	mov    0x20(%eax),%edx
80102eb7:	89 f6                	mov    %esi,%esi
80102eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102ec0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102ec6:	80 e6 10             	and    $0x10,%dh
80102ec9:	75 f5                	jne    80102ec0 <lapicinit+0xc0>
  lapic[index] = value;
80102ecb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102ed2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ed5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102ed8:	5d                   	pop    %ebp
80102ed9:	c3                   	ret    
80102eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102ee0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102ee7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102eea:	8b 50 20             	mov    0x20(%eax),%edx
80102eed:	e9 77 ff ff ff       	jmp    80102e69 <lapicinit+0x69>
80102ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f00 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102f00:	8b 15 80 c6 14 80    	mov    0x8014c680,%edx
{
80102f06:	55                   	push   %ebp
80102f07:	31 c0                	xor    %eax,%eax
80102f09:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102f0b:	85 d2                	test   %edx,%edx
80102f0d:	74 06                	je     80102f15 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102f0f:	8b 42 20             	mov    0x20(%edx),%eax
80102f12:	c1 e8 18             	shr    $0x18,%eax
}
80102f15:	5d                   	pop    %ebp
80102f16:	c3                   	ret    
80102f17:	89 f6                	mov    %esi,%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102f20:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102f25:	55                   	push   %ebp
80102f26:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102f28:	85 c0                	test   %eax,%eax
80102f2a:	74 0d                	je     80102f39 <lapiceoi+0x19>
  lapic[index] = value;
80102f2c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102f33:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102f36:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102f39:	5d                   	pop    %ebp
80102f3a:	c3                   	ret    
80102f3b:	90                   	nop
80102f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102f40 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
}
80102f43:	5d                   	pop    %ebp
80102f44:	c3                   	ret    
80102f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f50 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f50:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f51:	b8 0f 00 00 00       	mov    $0xf,%eax
80102f56:	ba 70 00 00 00       	mov    $0x70,%edx
80102f5b:	89 e5                	mov    %esp,%ebp
80102f5d:	53                   	push   %ebx
80102f5e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102f61:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102f64:	ee                   	out    %al,(%dx)
80102f65:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f6a:	ba 71 00 00 00       	mov    $0x71,%edx
80102f6f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102f70:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f72:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102f75:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102f7b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102f7d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102f80:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102f83:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102f85:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102f88:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102f8e:	a1 80 c6 14 80       	mov    0x8014c680,%eax
80102f93:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f99:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102f9c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102fa3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102fa6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fa9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102fb0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102fb3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fb6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fbc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fbf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fc5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102fc8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fce:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102fd1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102fd7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102fda:	5b                   	pop    %ebx
80102fdb:	5d                   	pop    %ebp
80102fdc:	c3                   	ret    
80102fdd:	8d 76 00             	lea    0x0(%esi),%esi

80102fe0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102fe0:	55                   	push   %ebp
80102fe1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102fe6:	ba 70 00 00 00       	mov    $0x70,%edx
80102feb:	89 e5                	mov    %esp,%ebp
80102fed:	57                   	push   %edi
80102fee:	56                   	push   %esi
80102fef:	53                   	push   %ebx
80102ff0:	83 ec 4c             	sub    $0x4c,%esp
80102ff3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ff4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ff9:	ec                   	in     (%dx),%al
80102ffa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ffd:	bb 70 00 00 00       	mov    $0x70,%ebx
80103002:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103005:	8d 76 00             	lea    0x0(%esi),%esi
80103008:	31 c0                	xor    %eax,%eax
8010300a:	89 da                	mov    %ebx,%edx
8010300c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010300d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103012:	89 ca                	mov    %ecx,%edx
80103014:	ec                   	in     (%dx),%al
80103015:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103018:	89 da                	mov    %ebx,%edx
8010301a:	b8 02 00 00 00       	mov    $0x2,%eax
8010301f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103020:	89 ca                	mov    %ecx,%edx
80103022:	ec                   	in     (%dx),%al
80103023:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103026:	89 da                	mov    %ebx,%edx
80103028:	b8 04 00 00 00       	mov    $0x4,%eax
8010302d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010302e:	89 ca                	mov    %ecx,%edx
80103030:	ec                   	in     (%dx),%al
80103031:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103034:	89 da                	mov    %ebx,%edx
80103036:	b8 07 00 00 00       	mov    $0x7,%eax
8010303b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010303c:	89 ca                	mov    %ecx,%edx
8010303e:	ec                   	in     (%dx),%al
8010303f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103042:	89 da                	mov    %ebx,%edx
80103044:	b8 08 00 00 00       	mov    $0x8,%eax
80103049:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010304a:	89 ca                	mov    %ecx,%edx
8010304c:	ec                   	in     (%dx),%al
8010304d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010304f:	89 da                	mov    %ebx,%edx
80103051:	b8 09 00 00 00       	mov    $0x9,%eax
80103056:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103057:	89 ca                	mov    %ecx,%edx
80103059:	ec                   	in     (%dx),%al
8010305a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010305c:	89 da                	mov    %ebx,%edx
8010305e:	b8 0a 00 00 00       	mov    $0xa,%eax
80103063:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103064:	89 ca                	mov    %ecx,%edx
80103066:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103067:	84 c0                	test   %al,%al
80103069:	78 9d                	js     80103008 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010306b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
8010306f:	89 fa                	mov    %edi,%edx
80103071:	0f b6 fa             	movzbl %dl,%edi
80103074:	89 f2                	mov    %esi,%edx
80103076:	0f b6 f2             	movzbl %dl,%esi
80103079:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010307c:	89 da                	mov    %ebx,%edx
8010307e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80103081:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103084:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103088:	89 45 bc             	mov    %eax,-0x44(%ebp)
8010308b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010308f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103092:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103096:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103099:	31 c0                	xor    %eax,%eax
8010309b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010309c:	89 ca                	mov    %ecx,%edx
8010309e:	ec                   	in     (%dx),%al
8010309f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030a2:	89 da                	mov    %ebx,%edx
801030a4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801030a7:	b8 02 00 00 00       	mov    $0x2,%eax
801030ac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030ad:	89 ca                	mov    %ecx,%edx
801030af:	ec                   	in     (%dx),%al
801030b0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030b3:	89 da                	mov    %ebx,%edx
801030b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801030b8:	b8 04 00 00 00       	mov    $0x4,%eax
801030bd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030be:	89 ca                	mov    %ecx,%edx
801030c0:	ec                   	in     (%dx),%al
801030c1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030c4:	89 da                	mov    %ebx,%edx
801030c6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801030c9:	b8 07 00 00 00       	mov    $0x7,%eax
801030ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030cf:	89 ca                	mov    %ecx,%edx
801030d1:	ec                   	in     (%dx),%al
801030d2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030d5:	89 da                	mov    %ebx,%edx
801030d7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801030da:	b8 08 00 00 00       	mov    $0x8,%eax
801030df:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030e0:	89 ca                	mov    %ecx,%edx
801030e2:	ec                   	in     (%dx),%al
801030e3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030e6:	89 da                	mov    %ebx,%edx
801030e8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801030eb:	b8 09 00 00 00       	mov    $0x9,%eax
801030f0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030f1:	89 ca                	mov    %ecx,%edx
801030f3:	ec                   	in     (%dx),%al
801030f4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801030f7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801030fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801030fd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103100:	6a 18                	push   $0x18
80103102:	50                   	push   %eax
80103103:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103106:	50                   	push   %eax
80103107:	e8 c4 20 00 00       	call   801051d0 <memcmp>
8010310c:	83 c4 10             	add    $0x10,%esp
8010310f:	85 c0                	test   %eax,%eax
80103111:	0f 85 f1 fe ff ff    	jne    80103008 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103117:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010311b:	75 78                	jne    80103195 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010311d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103120:	89 c2                	mov    %eax,%edx
80103122:	83 e0 0f             	and    $0xf,%eax
80103125:	c1 ea 04             	shr    $0x4,%edx
80103128:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010312b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010312e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103131:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103134:	89 c2                	mov    %eax,%edx
80103136:	83 e0 0f             	and    $0xf,%eax
80103139:	c1 ea 04             	shr    $0x4,%edx
8010313c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010313f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103142:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103145:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103148:	89 c2                	mov    %eax,%edx
8010314a:	83 e0 0f             	and    $0xf,%eax
8010314d:	c1 ea 04             	shr    $0x4,%edx
80103150:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103153:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103156:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103159:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010315c:	89 c2                	mov    %eax,%edx
8010315e:	83 e0 0f             	and    $0xf,%eax
80103161:	c1 ea 04             	shr    $0x4,%edx
80103164:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103167:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010316a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010316d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103170:	89 c2                	mov    %eax,%edx
80103172:	83 e0 0f             	and    $0xf,%eax
80103175:	c1 ea 04             	shr    $0x4,%edx
80103178:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010317b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010317e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103181:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103184:	89 c2                	mov    %eax,%edx
80103186:	83 e0 0f             	and    $0xf,%eax
80103189:	c1 ea 04             	shr    $0x4,%edx
8010318c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010318f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103192:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103195:	8b 75 08             	mov    0x8(%ebp),%esi
80103198:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010319b:	89 06                	mov    %eax,(%esi)
8010319d:	8b 45 bc             	mov    -0x44(%ebp),%eax
801031a0:	89 46 04             	mov    %eax,0x4(%esi)
801031a3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801031a6:	89 46 08             	mov    %eax,0x8(%esi)
801031a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801031ac:	89 46 0c             	mov    %eax,0xc(%esi)
801031af:	8b 45 c8             	mov    -0x38(%ebp),%eax
801031b2:	89 46 10             	mov    %eax,0x10(%esi)
801031b5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801031b8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801031bb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801031c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031c5:	5b                   	pop    %ebx
801031c6:	5e                   	pop    %esi
801031c7:	5f                   	pop    %edi
801031c8:	5d                   	pop    %ebp
801031c9:	c3                   	ret    
801031ca:	66 90                	xchg   %ax,%ax
801031cc:	66 90                	xchg   %ax,%ax
801031ce:	66 90                	xchg   %ax,%ax

801031d0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801031d0:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
801031d6:	85 c9                	test   %ecx,%ecx
801031d8:	0f 8e 8a 00 00 00    	jle    80103268 <install_trans+0x98>
{
801031de:	55                   	push   %ebp
801031df:	89 e5                	mov    %esp,%ebp
801031e1:	57                   	push   %edi
801031e2:	56                   	push   %esi
801031e3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
801031e4:	31 db                	xor    %ebx,%ebx
{
801031e6:	83 ec 0c             	sub    $0xc,%esp
801031e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801031f0:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
801031f5:	83 ec 08             	sub    $0x8,%esp
801031f8:	01 d8                	add    %ebx,%eax
801031fa:	83 c0 01             	add    $0x1,%eax
801031fd:	50                   	push   %eax
801031fe:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103204:	e8 c7 ce ff ff       	call   801000d0 <bread>
80103209:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010320b:	58                   	pop    %eax
8010320c:	5a                   	pop    %edx
8010320d:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103214:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010321a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010321d:	e8 ae ce ff ff       	call   801000d0 <bread>
80103222:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103224:	8d 47 5c             	lea    0x5c(%edi),%eax
80103227:	83 c4 0c             	add    $0xc,%esp
8010322a:	68 00 02 00 00       	push   $0x200
8010322f:	50                   	push   %eax
80103230:	8d 46 5c             	lea    0x5c(%esi),%eax
80103233:	50                   	push   %eax
80103234:	e8 f7 1f 00 00       	call   80105230 <memmove>
    bwrite(dbuf);  // write dst to disk
80103239:	89 34 24             	mov    %esi,(%esp)
8010323c:	e8 5f cf ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103241:	89 3c 24             	mov    %edi,(%esp)
80103244:	e8 97 cf ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103249:	89 34 24             	mov    %esi,(%esp)
8010324c:	e8 8f cf ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103251:	83 c4 10             	add    $0x10,%esp
80103254:	39 1d e8 c6 14 80    	cmp    %ebx,0x8014c6e8
8010325a:	7f 94                	jg     801031f0 <install_trans+0x20>
  }
}
8010325c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010325f:	5b                   	pop    %ebx
80103260:	5e                   	pop    %esi
80103261:	5f                   	pop    %edi
80103262:	5d                   	pop    %ebp
80103263:	c3                   	ret    
80103264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103268:	f3 c3                	repz ret 
8010326a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103270 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103270:	55                   	push   %ebp
80103271:	89 e5                	mov    %esp,%ebp
80103273:	56                   	push   %esi
80103274:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80103275:	83 ec 08             	sub    $0x8,%esp
80103278:	ff 35 d4 c6 14 80    	pushl  0x8014c6d4
8010327e:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103284:	e8 47 ce ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103289:	8b 1d e8 c6 14 80    	mov    0x8014c6e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
8010328f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103292:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80103294:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80103296:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103299:	7e 16                	jle    801032b1 <write_head+0x41>
8010329b:	c1 e3 02             	shl    $0x2,%ebx
8010329e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
801032a0:	8b 8a ec c6 14 80    	mov    -0x7feb3914(%edx),%ecx
801032a6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
801032aa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
801032ad:	39 da                	cmp    %ebx,%edx
801032af:	75 ef                	jne    801032a0 <write_head+0x30>
  }
  bwrite(buf);
801032b1:	83 ec 0c             	sub    $0xc,%esp
801032b4:	56                   	push   %esi
801032b5:	e8 e6 ce ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801032ba:	89 34 24             	mov    %esi,(%esp)
801032bd:	e8 1e cf ff ff       	call   801001e0 <brelse>
}
801032c2:	83 c4 10             	add    $0x10,%esp
801032c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032c8:	5b                   	pop    %ebx
801032c9:	5e                   	pop    %esi
801032ca:	5d                   	pop    %ebp
801032cb:	c3                   	ret    
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032d0 <initlog>:
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	53                   	push   %ebx
801032d4:	83 ec 2c             	sub    $0x2c,%esp
801032d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801032da:	68 40 8d 10 80       	push   $0x80108d40
801032df:	68 a0 c6 14 80       	push   $0x8014c6a0
801032e4:	e8 47 1c 00 00       	call   80104f30 <initlock>
  readsb(dev, &sb);
801032e9:	58                   	pop    %eax
801032ea:	8d 45 dc             	lea    -0x24(%ebp),%eax
801032ed:	5a                   	pop    %edx
801032ee:	50                   	push   %eax
801032ef:	53                   	push   %ebx
801032f0:	e8 5b e3 ff ff       	call   80101650 <readsb>
  log.size = sb.nlog;
801032f5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801032f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801032fb:	59                   	pop    %ecx
  log.dev = dev;
801032fc:	89 1d e4 c6 14 80    	mov    %ebx,0x8014c6e4
  log.size = sb.nlog;
80103302:	89 15 d8 c6 14 80    	mov    %edx,0x8014c6d8
  log.start = sb.logstart;
80103308:	a3 d4 c6 14 80       	mov    %eax,0x8014c6d4
  struct buf *buf = bread(log.dev, log.start);
8010330d:	5a                   	pop    %edx
8010330e:	50                   	push   %eax
8010330f:	53                   	push   %ebx
80103310:	e8 bb cd ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103315:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80103318:	83 c4 10             	add    $0x10,%esp
8010331b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
8010331d:	89 1d e8 c6 14 80    	mov    %ebx,0x8014c6e8
  for (i = 0; i < log.lh.n; i++) {
80103323:	7e 1c                	jle    80103341 <initlog+0x71>
80103325:	c1 e3 02             	shl    $0x2,%ebx
80103328:	31 d2                	xor    %edx,%edx
8010332a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103330:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103334:	83 c2 04             	add    $0x4,%edx
80103337:	89 8a e8 c6 14 80    	mov    %ecx,-0x7feb3918(%edx)
  for (i = 0; i < log.lh.n; i++) {
8010333d:	39 d3                	cmp    %edx,%ebx
8010333f:	75 ef                	jne    80103330 <initlog+0x60>
  brelse(buf);
80103341:	83 ec 0c             	sub    $0xc,%esp
80103344:	50                   	push   %eax
80103345:	e8 96 ce ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010334a:	e8 81 fe ff ff       	call   801031d0 <install_trans>
  log.lh.n = 0;
8010334f:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
80103356:	00 00 00 
  write_head(); // clear the log
80103359:	e8 12 ff ff ff       	call   80103270 <write_head>
}
8010335e:	83 c4 10             	add    $0x10,%esp
80103361:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103364:	c9                   	leave  
80103365:	c3                   	ret    
80103366:	8d 76 00             	lea    0x0(%esi),%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103370 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103376:	68 a0 c6 14 80       	push   $0x8014c6a0
8010337b:	e8 f0 1c 00 00       	call   80105070 <acquire>
80103380:	83 c4 10             	add    $0x10,%esp
80103383:	eb 18                	jmp    8010339d <begin_op+0x2d>
80103385:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103388:	83 ec 08             	sub    $0x8,%esp
8010338b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103390:	68 a0 c6 14 80       	push   $0x8014c6a0
80103395:	e8 76 14 00 00       	call   80104810 <sleep>
8010339a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010339d:	a1 e0 c6 14 80       	mov    0x8014c6e0,%eax
801033a2:	85 c0                	test   %eax,%eax
801033a4:	75 e2                	jne    80103388 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801033a6:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
801033ab:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
801033b1:	83 c0 01             	add    $0x1,%eax
801033b4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801033b7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801033ba:	83 fa 1e             	cmp    $0x1e,%edx
801033bd:	7f c9                	jg     80103388 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801033bf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801033c2:	a3 dc c6 14 80       	mov    %eax,0x8014c6dc
      release(&log.lock);
801033c7:	68 a0 c6 14 80       	push   $0x8014c6a0
801033cc:	e8 5f 1d 00 00       	call   80105130 <release>
      break;
    }
  }
}
801033d1:	83 c4 10             	add    $0x10,%esp
801033d4:	c9                   	leave  
801033d5:	c3                   	ret    
801033d6:	8d 76 00             	lea    0x0(%esi),%esi
801033d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801033e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801033e9:	68 a0 c6 14 80       	push   $0x8014c6a0
801033ee:	e8 7d 1c 00 00       	call   80105070 <acquire>
  log.outstanding -= 1;
801033f3:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
  if(log.committing)
801033f8:	8b 35 e0 c6 14 80    	mov    0x8014c6e0,%esi
801033fe:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103401:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103404:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103406:	89 1d dc c6 14 80    	mov    %ebx,0x8014c6dc
  if(log.committing)
8010340c:	0f 85 1a 01 00 00    	jne    8010352c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103412:	85 db                	test   %ebx,%ebx
80103414:	0f 85 ee 00 00 00    	jne    80103508 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010341a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010341d:	c7 05 e0 c6 14 80 01 	movl   $0x1,0x8014c6e0
80103424:	00 00 00 
  release(&log.lock);
80103427:	68 a0 c6 14 80       	push   $0x8014c6a0
8010342c:	e8 ff 1c 00 00       	call   80105130 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103431:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103437:	83 c4 10             	add    $0x10,%esp
8010343a:	85 c9                	test   %ecx,%ecx
8010343c:	0f 8e 85 00 00 00    	jle    801034c7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103442:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103447:	83 ec 08             	sub    $0x8,%esp
8010344a:	01 d8                	add    %ebx,%eax
8010344c:	83 c0 01             	add    $0x1,%eax
8010344f:	50                   	push   %eax
80103450:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103456:	e8 75 cc ff ff       	call   801000d0 <bread>
8010345b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010345d:	58                   	pop    %eax
8010345e:	5a                   	pop    %edx
8010345f:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103466:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010346c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010346f:	e8 5c cc ff ff       	call   801000d0 <bread>
80103474:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103476:	8d 40 5c             	lea    0x5c(%eax),%eax
80103479:	83 c4 0c             	add    $0xc,%esp
8010347c:	68 00 02 00 00       	push   $0x200
80103481:	50                   	push   %eax
80103482:	8d 46 5c             	lea    0x5c(%esi),%eax
80103485:	50                   	push   %eax
80103486:	e8 a5 1d 00 00       	call   80105230 <memmove>
    bwrite(to);  // write the log
8010348b:	89 34 24             	mov    %esi,(%esp)
8010348e:	e8 0d cd ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103493:	89 3c 24             	mov    %edi,(%esp)
80103496:	e8 45 cd ff ff       	call   801001e0 <brelse>
    brelse(to);
8010349b:	89 34 24             	mov    %esi,(%esp)
8010349e:	e8 3d cd ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801034a3:	83 c4 10             	add    $0x10,%esp
801034a6:	3b 1d e8 c6 14 80    	cmp    0x8014c6e8,%ebx
801034ac:	7c 94                	jl     80103442 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801034ae:	e8 bd fd ff ff       	call   80103270 <write_head>
    install_trans(); // Now install writes to home locations
801034b3:	e8 18 fd ff ff       	call   801031d0 <install_trans>
    log.lh.n = 0;
801034b8:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
801034bf:	00 00 00 
    write_head();    // Erase the transaction from the log
801034c2:	e8 a9 fd ff ff       	call   80103270 <write_head>
    acquire(&log.lock);
801034c7:	83 ec 0c             	sub    $0xc,%esp
801034ca:	68 a0 c6 14 80       	push   $0x8014c6a0
801034cf:	e8 9c 1b 00 00       	call   80105070 <acquire>
    wakeup(&log);
801034d4:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
    log.committing = 0;
801034db:	c7 05 e0 c6 14 80 00 	movl   $0x0,0x8014c6e0
801034e2:	00 00 00 
    wakeup(&log);
801034e5:	e8 46 15 00 00       	call   80104a30 <wakeup>
    release(&log.lock);
801034ea:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
801034f1:	e8 3a 1c 00 00       	call   80105130 <release>
801034f6:	83 c4 10             	add    $0x10,%esp
}
801034f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034fc:	5b                   	pop    %ebx
801034fd:	5e                   	pop    %esi
801034fe:	5f                   	pop    %edi
801034ff:	5d                   	pop    %ebp
80103500:	c3                   	ret    
80103501:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103508:	83 ec 0c             	sub    $0xc,%esp
8010350b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103510:	e8 1b 15 00 00       	call   80104a30 <wakeup>
  release(&log.lock);
80103515:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
8010351c:	e8 0f 1c 00 00       	call   80105130 <release>
80103521:	83 c4 10             	add    $0x10,%esp
}
80103524:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103527:	5b                   	pop    %ebx
80103528:	5e                   	pop    %esi
80103529:	5f                   	pop    %edi
8010352a:	5d                   	pop    %ebp
8010352b:	c3                   	ret    
    panic("log.committing");
8010352c:	83 ec 0c             	sub    $0xc,%esp
8010352f:	68 44 8d 10 80       	push   $0x80108d44
80103534:	e8 57 ce ff ff       	call   80100390 <panic>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103540 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	53                   	push   %ebx
80103544:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103547:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
{
8010354d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103550:	83 fa 1d             	cmp    $0x1d,%edx
80103553:	0f 8f 9d 00 00 00    	jg     801035f6 <log_write+0xb6>
80103559:	a1 d8 c6 14 80       	mov    0x8014c6d8,%eax
8010355e:	83 e8 01             	sub    $0x1,%eax
80103561:	39 c2                	cmp    %eax,%edx
80103563:	0f 8d 8d 00 00 00    	jge    801035f6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103569:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010356e:	85 c0                	test   %eax,%eax
80103570:	0f 8e 8d 00 00 00    	jle    80103603 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103576:	83 ec 0c             	sub    $0xc,%esp
80103579:	68 a0 c6 14 80       	push   $0x8014c6a0
8010357e:	e8 ed 1a 00 00       	call   80105070 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103583:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103589:	83 c4 10             	add    $0x10,%esp
8010358c:	83 f9 00             	cmp    $0x0,%ecx
8010358f:	7e 57                	jle    801035e8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103591:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80103594:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103596:	3b 15 ec c6 14 80    	cmp    0x8014c6ec,%edx
8010359c:	75 0b                	jne    801035a9 <log_write+0x69>
8010359e:	eb 38                	jmp    801035d8 <log_write+0x98>
801035a0:	39 14 85 ec c6 14 80 	cmp    %edx,-0x7feb3914(,%eax,4)
801035a7:	74 2f                	je     801035d8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801035a9:	83 c0 01             	add    $0x1,%eax
801035ac:	39 c1                	cmp    %eax,%ecx
801035ae:	75 f0                	jne    801035a0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801035b0:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801035b7:	83 c0 01             	add    $0x1,%eax
801035ba:	a3 e8 c6 14 80       	mov    %eax,0x8014c6e8
  b->flags |= B_DIRTY; // prevent eviction
801035bf:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801035c2:	c7 45 08 a0 c6 14 80 	movl   $0x8014c6a0,0x8(%ebp)
}
801035c9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035cc:	c9                   	leave  
  release(&log.lock);
801035cd:	e9 5e 1b 00 00       	jmp    80105130 <release>
801035d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801035d8:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
801035df:	eb de                	jmp    801035bf <log_write+0x7f>
801035e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035e8:	8b 43 08             	mov    0x8(%ebx),%eax
801035eb:	a3 ec c6 14 80       	mov    %eax,0x8014c6ec
  if (i == log.lh.n)
801035f0:	75 cd                	jne    801035bf <log_write+0x7f>
801035f2:	31 c0                	xor    %eax,%eax
801035f4:	eb c1                	jmp    801035b7 <log_write+0x77>
    panic("too big a transaction");
801035f6:	83 ec 0c             	sub    $0xc,%esp
801035f9:	68 53 8d 10 80       	push   $0x80108d53
801035fe:	e8 8d cd ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	68 69 8d 10 80       	push   $0x80108d69
8010360b:	e8 80 cd ff ff       	call   80100390 <panic>

80103610 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103610:	55                   	push   %ebp
80103611:	89 e5                	mov    %esp,%ebp
80103613:	53                   	push   %ebx
80103614:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103617:	e8 24 0a 00 00       	call   80104040 <cpuid>
8010361c:	89 c3                	mov    %eax,%ebx
8010361e:	e8 1d 0a 00 00       	call   80104040 <cpuid>
80103623:	83 ec 04             	sub    $0x4,%esp
80103626:	53                   	push   %ebx
80103627:	50                   	push   %eax
80103628:	68 84 8d 10 80       	push   $0x80108d84
8010362d:	e8 2e d0 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103632:	e8 79 2e 00 00       	call   801064b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103637:	e8 84 09 00 00       	call   80103fc0 <mycpu>
8010363c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010363e:	b8 01 00 00 00       	mov    $0x1,%eax
80103643:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010364a:	e8 b1 0e 00 00       	call   80104500 <scheduler>
8010364f:	90                   	nop

80103650 <mpenter>:
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103656:	e8 55 40 00 00       	call   801076b0 <switchkvm>
  seginit();
8010365b:	e8 c0 3f 00 00       	call   80107620 <seginit>
  lapicinit();
80103660:	e8 9b f7 ff ff       	call   80102e00 <lapicinit>
  mpmain();
80103665:	e8 a6 ff ff ff       	call   80103610 <mpmain>
8010366a:	66 90                	xchg   %ax,%ax
8010366c:	66 90                	xchg   %ax,%ax
8010366e:	66 90                	xchg   %ax,%ax

80103670 <main>:
{
80103670:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103674:	83 e4 f0             	and    $0xfffffff0,%esp
80103677:	ff 71 fc             	pushl  -0x4(%ecx)
8010367a:	55                   	push   %ebp
8010367b:	89 e5                	mov    %esp,%ebp
8010367d:	53                   	push   %ebx
8010367e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010367f:	83 ec 08             	sub    $0x8,%esp
80103682:	68 00 00 40 80       	push   $0x80400000
80103687:	68 c8 9b 15 80       	push   $0x80159bc8
8010368c:	e8 4f f3 ff ff       	call   801029e0 <kinit1>
  kvmalloc();      // kernel page table
80103691:	e8 da 4a 00 00       	call   80108170 <kvmalloc>
  mpinit();        // detect other processors
80103696:	e8 75 01 00 00       	call   80103810 <mpinit>
  lapicinit();     // interrupt controller
8010369b:	e8 60 f7 ff ff       	call   80102e00 <lapicinit>
  seginit();       // segment descriptors
801036a0:	e8 7b 3f 00 00       	call   80107620 <seginit>
  picinit();       // disable pic
801036a5:	e8 46 03 00 00       	call   801039f0 <picinit>
  ioapicinit();    // another interrupt controller
801036aa:	e8 11 f1 ff ff       	call   801027c0 <ioapicinit>
  consoleinit();   // console hardware
801036af:	e8 0c d3 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801036b4:	e8 d7 32 00 00       	call   80106990 <uartinit>
  pinit();         // process table
801036b9:	e8 e2 08 00 00       	call   80103fa0 <pinit>
  tvinit();        // trap vectors
801036be:	e8 6d 2d 00 00       	call   80106430 <tvinit>
  binit();         // buffer cache
801036c3:	e8 78 c9 ff ff       	call   80100040 <binit>
  fileinit();      // file table
801036c8:	e8 a3 d8 ff ff       	call   80100f70 <fileinit>
  ideinit();       // disk 
801036cd:	e8 ce ee ff ff       	call   801025a0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801036d2:	83 c4 0c             	add    $0xc,%esp
801036d5:	68 8a 00 00 00       	push   $0x8a
801036da:	68 8c c4 10 80       	push   $0x8010c48c
801036df:	68 00 70 00 80       	push   $0x80007000
801036e4:	e8 47 1b 00 00       	call   80105230 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801036e9:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
801036f0:	00 00 00 
801036f3:	83 c4 10             	add    $0x10,%esp
801036f6:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
801036fb:	3d a0 c7 14 80       	cmp    $0x8014c7a0,%eax
80103700:	76 71                	jbe    80103773 <main+0x103>
80103702:	bb a0 c7 14 80       	mov    $0x8014c7a0,%ebx
80103707:	89 f6                	mov    %esi,%esi
80103709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103710:	e8 ab 08 00 00       	call   80103fc0 <mycpu>
80103715:	39 d8                	cmp    %ebx,%eax
80103717:	74 41                	je     8010375a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103719:	e8 a2 f3 ff ff       	call   80102ac0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010371e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103723:	c7 05 f8 6f 00 80 50 	movl   $0x80103650,0x80006ff8
8010372a:	36 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010372d:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103734:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103737:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010373c:	0f b6 03             	movzbl (%ebx),%eax
8010373f:	83 ec 08             	sub    $0x8,%esp
80103742:	68 00 70 00 00       	push   $0x7000
80103747:	50                   	push   %eax
80103748:	e8 03 f8 ff ff       	call   80102f50 <lapicstartap>
8010374d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103750:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103756:	85 c0                	test   %eax,%eax
80103758:	74 f6                	je     80103750 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010375a:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103761:	00 00 00 
80103764:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010376a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010376f:	39 c3                	cmp    %eax,%ebx
80103771:	72 9d                	jb     80103710 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103773:	83 ec 08             	sub    $0x8,%esp
80103776:	68 00 00 00 8e       	push   $0x8e000000
8010377b:	68 00 00 40 80       	push   $0x80400000
80103780:	e8 db f2 ff ff       	call   80102a60 <kinit2>
  userinit();      // first user process
80103785:	e8 06 09 00 00       	call   80104090 <userinit>
  mpmain();        // finish this processor's setup
8010378a:	e8 81 fe ff ff       	call   80103610 <mpmain>
8010378f:	90                   	nop

80103790 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	57                   	push   %edi
80103794:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103795:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010379b:	53                   	push   %ebx
  e = addr+len;
8010379c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010379f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801037a2:	39 de                	cmp    %ebx,%esi
801037a4:	72 10                	jb     801037b6 <mpsearch1+0x26>
801037a6:	eb 50                	jmp    801037f8 <mpsearch1+0x68>
801037a8:	90                   	nop
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037b0:	39 fb                	cmp    %edi,%ebx
801037b2:	89 fe                	mov    %edi,%esi
801037b4:	76 42                	jbe    801037f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801037b6:	83 ec 04             	sub    $0x4,%esp
801037b9:	8d 7e 10             	lea    0x10(%esi),%edi
801037bc:	6a 04                	push   $0x4
801037be:	68 98 8d 10 80       	push   $0x80108d98
801037c3:	56                   	push   %esi
801037c4:	e8 07 1a 00 00       	call   801051d0 <memcmp>
801037c9:	83 c4 10             	add    $0x10,%esp
801037cc:	85 c0                	test   %eax,%eax
801037ce:	75 e0                	jne    801037b0 <mpsearch1+0x20>
801037d0:	89 f1                	mov    %esi,%ecx
801037d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801037d8:	0f b6 11             	movzbl (%ecx),%edx
801037db:	83 c1 01             	add    $0x1,%ecx
801037de:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801037e0:	39 f9                	cmp    %edi,%ecx
801037e2:	75 f4                	jne    801037d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801037e4:	84 c0                	test   %al,%al
801037e6:	75 c8                	jne    801037b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801037e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037eb:	89 f0                	mov    %esi,%eax
801037ed:	5b                   	pop    %ebx
801037ee:	5e                   	pop    %esi
801037ef:	5f                   	pop    %edi
801037f0:	5d                   	pop    %ebp
801037f1:	c3                   	ret    
801037f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801037f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801037fb:	31 f6                	xor    %esi,%esi
}
801037fd:	89 f0                	mov    %esi,%eax
801037ff:	5b                   	pop    %ebx
80103800:	5e                   	pop    %esi
80103801:	5f                   	pop    %edi
80103802:	5d                   	pop    %ebp
80103803:	c3                   	ret    
80103804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010380a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103810 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	57                   	push   %edi
80103814:	56                   	push   %esi
80103815:	53                   	push   %ebx
80103816:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103819:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103820:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103827:	c1 e0 08             	shl    $0x8,%eax
8010382a:	09 d0                	or     %edx,%eax
8010382c:	c1 e0 04             	shl    $0x4,%eax
8010382f:	85 c0                	test   %eax,%eax
80103831:	75 1b                	jne    8010384e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103833:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010383a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103841:	c1 e0 08             	shl    $0x8,%eax
80103844:	09 d0                	or     %edx,%eax
80103846:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103849:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010384e:	ba 00 04 00 00       	mov    $0x400,%edx
80103853:	e8 38 ff ff ff       	call   80103790 <mpsearch1>
80103858:	85 c0                	test   %eax,%eax
8010385a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010385d:	0f 84 3d 01 00 00    	je     801039a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103863:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103866:	8b 58 04             	mov    0x4(%eax),%ebx
80103869:	85 db                	test   %ebx,%ebx
8010386b:	0f 84 4f 01 00 00    	je     801039c0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103871:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103877:	83 ec 04             	sub    $0x4,%esp
8010387a:	6a 04                	push   $0x4
8010387c:	68 b5 8d 10 80       	push   $0x80108db5
80103881:	56                   	push   %esi
80103882:	e8 49 19 00 00       	call   801051d0 <memcmp>
80103887:	83 c4 10             	add    $0x10,%esp
8010388a:	85 c0                	test   %eax,%eax
8010388c:	0f 85 2e 01 00 00    	jne    801039c0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103892:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103899:	3c 01                	cmp    $0x1,%al
8010389b:	0f 95 c2             	setne  %dl
8010389e:	3c 04                	cmp    $0x4,%al
801038a0:	0f 95 c0             	setne  %al
801038a3:	20 c2                	and    %al,%dl
801038a5:	0f 85 15 01 00 00    	jne    801039c0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801038ab:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801038b2:	66 85 ff             	test   %di,%di
801038b5:	74 1a                	je     801038d1 <mpinit+0xc1>
801038b7:	89 f0                	mov    %esi,%eax
801038b9:	01 f7                	add    %esi,%edi
  sum = 0;
801038bb:	31 d2                	xor    %edx,%edx
801038bd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801038c0:	0f b6 08             	movzbl (%eax),%ecx
801038c3:	83 c0 01             	add    $0x1,%eax
801038c6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801038c8:	39 c7                	cmp    %eax,%edi
801038ca:	75 f4                	jne    801038c0 <mpinit+0xb0>
801038cc:	84 d2                	test   %dl,%dl
801038ce:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801038d1:	85 f6                	test   %esi,%esi
801038d3:	0f 84 e7 00 00 00    	je     801039c0 <mpinit+0x1b0>
801038d9:	84 d2                	test   %dl,%dl
801038db:	0f 85 df 00 00 00    	jne    801039c0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801038e1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801038e7:	a3 80 c6 14 80       	mov    %eax,0x8014c680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801038ec:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801038f3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801038f9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801038fe:	01 d6                	add    %edx,%esi
80103900:	39 c6                	cmp    %eax,%esi
80103902:	76 23                	jbe    80103927 <mpinit+0x117>
    switch(*p){
80103904:	0f b6 10             	movzbl (%eax),%edx
80103907:	80 fa 04             	cmp    $0x4,%dl
8010390a:	0f 87 ca 00 00 00    	ja     801039da <mpinit+0x1ca>
80103910:	ff 24 95 dc 8d 10 80 	jmp    *-0x7fef7224(,%edx,4)
80103917:	89 f6                	mov    %esi,%esi
80103919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103920:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103923:	39 c6                	cmp    %eax,%esi
80103925:	77 dd                	ja     80103904 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103927:	85 db                	test   %ebx,%ebx
80103929:	0f 84 9e 00 00 00    	je     801039cd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010392f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103932:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103936:	74 15                	je     8010394d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103938:	b8 70 00 00 00       	mov    $0x70,%eax
8010393d:	ba 22 00 00 00       	mov    $0x22,%edx
80103942:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103943:	ba 23 00 00 00       	mov    $0x23,%edx
80103948:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103949:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010394c:	ee                   	out    %al,(%dx)
  }
}
8010394d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103950:	5b                   	pop    %ebx
80103951:	5e                   	pop    %esi
80103952:	5f                   	pop    %edi
80103953:	5d                   	pop    %ebp
80103954:	c3                   	ret    
80103955:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103958:	8b 0d 20 cd 14 80    	mov    0x8014cd20,%ecx
8010395e:	83 f9 07             	cmp    $0x7,%ecx
80103961:	7f 19                	jg     8010397c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103963:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103967:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010396d:	83 c1 01             	add    $0x1,%ecx
80103970:	89 0d 20 cd 14 80    	mov    %ecx,0x8014cd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103976:	88 97 a0 c7 14 80    	mov    %dl,-0x7feb3860(%edi)
      p += sizeof(struct mpproc);
8010397c:	83 c0 14             	add    $0x14,%eax
      continue;
8010397f:	e9 7c ff ff ff       	jmp    80103900 <mpinit+0xf0>
80103984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103988:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010398c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010398f:	88 15 80 c7 14 80    	mov    %dl,0x8014c780
      continue;
80103995:	e9 66 ff ff ff       	jmp    80103900 <mpinit+0xf0>
8010399a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801039a0:	ba 00 00 01 00       	mov    $0x10000,%edx
801039a5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801039aa:	e8 e1 fd ff ff       	call   80103790 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801039af:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801039b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801039b4:	0f 85 a9 fe ff ff    	jne    80103863 <mpinit+0x53>
801039ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801039c0:	83 ec 0c             	sub    $0xc,%esp
801039c3:	68 9d 8d 10 80       	push   $0x80108d9d
801039c8:	e8 c3 c9 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801039cd:	83 ec 0c             	sub    $0xc,%esp
801039d0:	68 bc 8d 10 80       	push   $0x80108dbc
801039d5:	e8 b6 c9 ff ff       	call   80100390 <panic>
      ismp = 0;
801039da:	31 db                	xor    %ebx,%ebx
801039dc:	e9 26 ff ff ff       	jmp    80103907 <mpinit+0xf7>
801039e1:	66 90                	xchg   %ax,%ax
801039e3:	66 90                	xchg   %ax,%ax
801039e5:	66 90                	xchg   %ax,%ax
801039e7:	66 90                	xchg   %ax,%ax
801039e9:	66 90                	xchg   %ax,%ax
801039eb:	66 90                	xchg   %ax,%ax
801039ed:	66 90                	xchg   %ax,%ax
801039ef:	90                   	nop

801039f0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801039f0:	55                   	push   %ebp
801039f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039f6:	ba 21 00 00 00       	mov    $0x21,%edx
801039fb:	89 e5                	mov    %esp,%ebp
801039fd:	ee                   	out    %al,(%dx)
801039fe:	ba a1 00 00 00       	mov    $0xa1,%edx
80103a03:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103a04:	5d                   	pop    %ebp
80103a05:	c3                   	ret    
80103a06:	66 90                	xchg   %ax,%ax
80103a08:	66 90                	xchg   %ax,%ax
80103a0a:	66 90                	xchg   %ax,%ax
80103a0c:	66 90                	xchg   %ax,%ax
80103a0e:	66 90                	xchg   %ax,%ax

80103a10 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	57                   	push   %edi
80103a14:	56                   	push   %esi
80103a15:	53                   	push   %ebx
80103a16:	83 ec 0c             	sub    $0xc,%esp
80103a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103a1f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103a25:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103a2b:	e8 60 d5 ff ff       	call   80100f90 <filealloc>
80103a30:	85 c0                	test   %eax,%eax
80103a32:	89 03                	mov    %eax,(%ebx)
80103a34:	74 22                	je     80103a58 <pipealloc+0x48>
80103a36:	e8 55 d5 ff ff       	call   80100f90 <filealloc>
80103a3b:	85 c0                	test   %eax,%eax
80103a3d:	89 06                	mov    %eax,(%esi)
80103a3f:	74 3f                	je     80103a80 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103a41:	e8 7a f0 ff ff       	call   80102ac0 <kalloc>
80103a46:	85 c0                	test   %eax,%eax
80103a48:	89 c7                	mov    %eax,%edi
80103a4a:	75 54                	jne    80103aa0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103a4c:	8b 03                	mov    (%ebx),%eax
80103a4e:	85 c0                	test   %eax,%eax
80103a50:	75 34                	jne    80103a86 <pipealloc+0x76>
80103a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103a58:	8b 06                	mov    (%esi),%eax
80103a5a:	85 c0                	test   %eax,%eax
80103a5c:	74 0c                	je     80103a6a <pipealloc+0x5a>
    fileclose(*f1);
80103a5e:	83 ec 0c             	sub    $0xc,%esp
80103a61:	50                   	push   %eax
80103a62:	e8 e9 d5 ff ff       	call   80101050 <fileclose>
80103a67:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80103a6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103a72:	5b                   	pop    %ebx
80103a73:	5e                   	pop    %esi
80103a74:	5f                   	pop    %edi
80103a75:	5d                   	pop    %ebp
80103a76:	c3                   	ret    
80103a77:	89 f6                	mov    %esi,%esi
80103a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103a80:	8b 03                	mov    (%ebx),%eax
80103a82:	85 c0                	test   %eax,%eax
80103a84:	74 e4                	je     80103a6a <pipealloc+0x5a>
    fileclose(*f0);
80103a86:	83 ec 0c             	sub    $0xc,%esp
80103a89:	50                   	push   %eax
80103a8a:	e8 c1 d5 ff ff       	call   80101050 <fileclose>
  if(*f1)
80103a8f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103a91:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103a94:	85 c0                	test   %eax,%eax
80103a96:	75 c6                	jne    80103a5e <pipealloc+0x4e>
80103a98:	eb d0                	jmp    80103a6a <pipealloc+0x5a>
80103a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103aa0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103aa3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103aaa:	00 00 00 
  p->writeopen = 1;
80103aad:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103ab4:	00 00 00 
  p->nwrite = 0;
80103ab7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103abe:	00 00 00 
  p->nread = 0;
80103ac1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103ac8:	00 00 00 
  initlock(&p->lock, "pipe");
80103acb:	68 f0 8d 10 80       	push   $0x80108df0
80103ad0:	50                   	push   %eax
80103ad1:	e8 5a 14 00 00       	call   80104f30 <initlock>
  (*f0)->type = FD_PIPE;
80103ad6:	8b 03                	mov    (%ebx),%eax
  return 0;
80103ad8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103adb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103ae1:	8b 03                	mov    (%ebx),%eax
80103ae3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103ae7:	8b 03                	mov    (%ebx),%eax
80103ae9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103aed:	8b 03                	mov    (%ebx),%eax
80103aef:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103af2:	8b 06                	mov    (%esi),%eax
80103af4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103afa:	8b 06                	mov    (%esi),%eax
80103afc:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103b00:	8b 06                	mov    (%esi),%eax
80103b02:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103b06:	8b 06                	mov    (%esi),%eax
80103b08:	89 78 0c             	mov    %edi,0xc(%eax)
}
80103b0b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103b0e:	31 c0                	xor    %eax,%eax
}
80103b10:	5b                   	pop    %ebx
80103b11:	5e                   	pop    %esi
80103b12:	5f                   	pop    %edi
80103b13:	5d                   	pop    %ebp
80103b14:	c3                   	ret    
80103b15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b20 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	56                   	push   %esi
80103b24:	53                   	push   %ebx
80103b25:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b28:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103b2b:	83 ec 0c             	sub    $0xc,%esp
80103b2e:	53                   	push   %ebx
80103b2f:	e8 3c 15 00 00       	call   80105070 <acquire>
  if(writable){
80103b34:	83 c4 10             	add    $0x10,%esp
80103b37:	85 f6                	test   %esi,%esi
80103b39:	74 45                	je     80103b80 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103b3b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b41:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103b44:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103b4b:	00 00 00 
    wakeup(&p->nread);
80103b4e:	50                   	push   %eax
80103b4f:	e8 dc 0e 00 00       	call   80104a30 <wakeup>
80103b54:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103b57:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103b5d:	85 d2                	test   %edx,%edx
80103b5f:	75 0a                	jne    80103b6b <pipeclose+0x4b>
80103b61:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103b67:	85 c0                	test   %eax,%eax
80103b69:	74 35                	je     80103ba0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103b6b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103b6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b71:	5b                   	pop    %ebx
80103b72:	5e                   	pop    %esi
80103b73:	5d                   	pop    %ebp
    release(&p->lock);
80103b74:	e9 b7 15 00 00       	jmp    80105130 <release>
80103b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103b80:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103b86:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103b89:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103b90:	00 00 00 
    wakeup(&p->nwrite);
80103b93:	50                   	push   %eax
80103b94:	e8 97 0e 00 00       	call   80104a30 <wakeup>
80103b99:	83 c4 10             	add    $0x10,%esp
80103b9c:	eb b9                	jmp    80103b57 <pipeclose+0x37>
80103b9e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103ba0:	83 ec 0c             	sub    $0xc,%esp
80103ba3:	53                   	push   %ebx
80103ba4:	e8 87 15 00 00       	call   80105130 <release>
    kfree((char*)p);
80103ba9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103bac:	83 c4 10             	add    $0x10,%esp
}
80103baf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103bb2:	5b                   	pop    %ebx
80103bb3:	5e                   	pop    %esi
80103bb4:	5d                   	pop    %ebp
    kfree((char*)p);
80103bb5:	e9 f6 ec ff ff       	jmp    801028b0 <kfree>
80103bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103bc0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	57                   	push   %edi
80103bc4:	56                   	push   %esi
80103bc5:	53                   	push   %ebx
80103bc6:	83 ec 28             	sub    $0x28,%esp
80103bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103bcc:	53                   	push   %ebx
80103bcd:	e8 9e 14 00 00       	call   80105070 <acquire>
  for(i = 0; i < n; i++){
80103bd2:	8b 45 10             	mov    0x10(%ebp),%eax
80103bd5:	83 c4 10             	add    $0x10,%esp
80103bd8:	85 c0                	test   %eax,%eax
80103bda:	0f 8e c9 00 00 00    	jle    80103ca9 <pipewrite+0xe9>
80103be0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103be3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103be9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103bef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103bf2:	03 4d 10             	add    0x10(%ebp),%ecx
80103bf5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103bf8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103bfe:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103c04:	39 d0                	cmp    %edx,%eax
80103c06:	75 71                	jne    80103c79 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103c08:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103c0e:	85 c0                	test   %eax,%eax
80103c10:	74 4e                	je     80103c60 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103c12:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103c18:	eb 3a                	jmp    80103c54 <pipewrite+0x94>
80103c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	57                   	push   %edi
80103c24:	e8 07 0e 00 00       	call   80104a30 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103c29:	5a                   	pop    %edx
80103c2a:	59                   	pop    %ecx
80103c2b:	53                   	push   %ebx
80103c2c:	56                   	push   %esi
80103c2d:	e8 de 0b 00 00       	call   80104810 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c32:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103c38:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103c3e:	83 c4 10             	add    $0x10,%esp
80103c41:	05 00 02 00 00       	add    $0x200,%eax
80103c46:	39 c2                	cmp    %eax,%edx
80103c48:	75 36                	jne    80103c80 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103c4a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103c50:	85 c0                	test   %eax,%eax
80103c52:	74 0c                	je     80103c60 <pipewrite+0xa0>
80103c54:	e8 07 04 00 00       	call   80104060 <myproc>
80103c59:	8b 40 24             	mov    0x24(%eax),%eax
80103c5c:	85 c0                	test   %eax,%eax
80103c5e:	74 c0                	je     80103c20 <pipewrite+0x60>
        release(&p->lock);
80103c60:	83 ec 0c             	sub    $0xc,%esp
80103c63:	53                   	push   %ebx
80103c64:	e8 c7 14 00 00       	call   80105130 <release>
        return -1;
80103c69:	83 c4 10             	add    $0x10,%esp
80103c6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c74:	5b                   	pop    %ebx
80103c75:	5e                   	pop    %esi
80103c76:	5f                   	pop    %edi
80103c77:	5d                   	pop    %ebp
80103c78:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c79:	89 c2                	mov    %eax,%edx
80103c7b:	90                   	nop
80103c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c80:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103c83:	8d 42 01             	lea    0x1(%edx),%eax
80103c86:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103c8c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103c92:	83 c6 01             	add    $0x1,%esi
80103c95:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103c99:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103c9c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c9f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103ca3:	0f 85 4f ff ff ff    	jne    80103bf8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103ca9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103caf:	83 ec 0c             	sub    $0xc,%esp
80103cb2:	50                   	push   %eax
80103cb3:	e8 78 0d 00 00       	call   80104a30 <wakeup>
  release(&p->lock);
80103cb8:	89 1c 24             	mov    %ebx,(%esp)
80103cbb:	e8 70 14 00 00       	call   80105130 <release>
  return n;
80103cc0:	83 c4 10             	add    $0x10,%esp
80103cc3:	8b 45 10             	mov    0x10(%ebp),%eax
80103cc6:	eb a9                	jmp    80103c71 <pipewrite+0xb1>
80103cc8:	90                   	nop
80103cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103cd0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103cd0:	55                   	push   %ebp
80103cd1:	89 e5                	mov    %esp,%ebp
80103cd3:	57                   	push   %edi
80103cd4:	56                   	push   %esi
80103cd5:	53                   	push   %ebx
80103cd6:	83 ec 18             	sub    $0x18,%esp
80103cd9:	8b 75 08             	mov    0x8(%ebp),%esi
80103cdc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103cdf:	56                   	push   %esi
80103ce0:	e8 8b 13 00 00       	call   80105070 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103ce5:	83 c4 10             	add    $0x10,%esp
80103ce8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103cee:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103cf4:	75 6a                	jne    80103d60 <piperead+0x90>
80103cf6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103cfc:	85 db                	test   %ebx,%ebx
80103cfe:	0f 84 c4 00 00 00    	je     80103dc8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103d04:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103d0a:	eb 2d                	jmp    80103d39 <piperead+0x69>
80103d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d10:	83 ec 08             	sub    $0x8,%esp
80103d13:	56                   	push   %esi
80103d14:	53                   	push   %ebx
80103d15:	e8 f6 0a 00 00       	call   80104810 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103d1a:	83 c4 10             	add    $0x10,%esp
80103d1d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103d23:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103d29:	75 35                	jne    80103d60 <piperead+0x90>
80103d2b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103d31:	85 d2                	test   %edx,%edx
80103d33:	0f 84 8f 00 00 00    	je     80103dc8 <piperead+0xf8>
    if(myproc()->killed){
80103d39:	e8 22 03 00 00       	call   80104060 <myproc>
80103d3e:	8b 48 24             	mov    0x24(%eax),%ecx
80103d41:	85 c9                	test   %ecx,%ecx
80103d43:	74 cb                	je     80103d10 <piperead+0x40>
      release(&p->lock);
80103d45:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103d48:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103d4d:	56                   	push   %esi
80103d4e:	e8 dd 13 00 00       	call   80105130 <release>
      return -1;
80103d53:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103d56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d59:	89 d8                	mov    %ebx,%eax
80103d5b:	5b                   	pop    %ebx
80103d5c:	5e                   	pop    %esi
80103d5d:	5f                   	pop    %edi
80103d5e:	5d                   	pop    %ebp
80103d5f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103d60:	8b 45 10             	mov    0x10(%ebp),%eax
80103d63:	85 c0                	test   %eax,%eax
80103d65:	7e 61                	jle    80103dc8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103d67:	31 db                	xor    %ebx,%ebx
80103d69:	eb 13                	jmp    80103d7e <piperead+0xae>
80103d6b:	90                   	nop
80103d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d70:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103d76:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103d7c:	74 1f                	je     80103d9d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103d7e:	8d 41 01             	lea    0x1(%ecx),%eax
80103d81:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103d87:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103d8d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103d92:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103d95:	83 c3 01             	add    $0x1,%ebx
80103d98:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103d9b:	75 d3                	jne    80103d70 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103d9d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103da3:	83 ec 0c             	sub    $0xc,%esp
80103da6:	50                   	push   %eax
80103da7:	e8 84 0c 00 00       	call   80104a30 <wakeup>
  release(&p->lock);
80103dac:	89 34 24             	mov    %esi,(%esp)
80103daf:	e8 7c 13 00 00       	call   80105130 <release>
  return i;
80103db4:	83 c4 10             	add    $0x10,%esp
}
80103db7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dba:	89 d8                	mov    %ebx,%eax
80103dbc:	5b                   	pop    %ebx
80103dbd:	5e                   	pop    %esi
80103dbe:	5f                   	pop    %edi
80103dbf:	5d                   	pop    %ebp
80103dc0:	c3                   	ret    
80103dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dc8:	31 db                	xor    %ebx,%ebx
80103dca:	eb d1                	jmp    80103d9d <piperead+0xcd>
80103dcc:	66 90                	xchg   %ax,%ax
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dd4:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80103dd9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103ddc:	68 40 cd 14 80       	push   $0x8014cd40
80103de1:	e8 8a 12 00 00       	call   80105070 <acquire>
80103de6:	83 c4 10             	add    $0x10,%esp
80103de9:	eb 17                	jmp    80103e02 <allocproc+0x32>
80103deb:	90                   	nop
80103dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103df0:	81 c3 18 03 00 00    	add    $0x318,%ebx
80103df6:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80103dfc:	0f 83 26 01 00 00    	jae    80103f28 <allocproc+0x158>
    if(p->state == UNUSED)
80103e02:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e05:	85 c0                	test   %eax,%eax
80103e07:	75 e7                	jne    80103df0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103e09:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80103e0e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103e11:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103e18:	8d 50 01             	lea    0x1(%eax),%edx
80103e1b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103e1e:	68 40 cd 14 80       	push   $0x8014cd40
  p->pid = nextpid++;
80103e23:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103e29:	e8 02 13 00 00       	call   80105130 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103e2e:	e8 8d ec ff ff       	call   80102ac0 <kalloc>
80103e33:	83 c4 10             	add    $0x10,%esp
80103e36:	85 c0                	test   %eax,%eax
80103e38:	89 43 08             	mov    %eax,0x8(%ebx)
80103e3b:	0f 84 00 01 00 00    	je     80103f41 <allocproc+0x171>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103e41:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103e47:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103e4a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103e4f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103e52:	c7 40 14 17 64 10 80 	movl   $0x80106417,0x14(%eax)
  p->context = (struct context*)sp;
80103e59:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103e5c:	6a 14                	push   $0x14
80103e5e:	6a 00                	push   $0x0
80103e60:	50                   	push   %eax
80103e61:	e8 1a 13 00 00       	call   80105180 <memset>
  p->context->eip = (uint)forkret;
80103e66:	8b 43 1c             	mov    0x1c(%ebx),%eax

  p->headPG = -1;
  // Task 1
  if(p->pid>2){
80103e69:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103e6c:	c7 40 10 50 3f 10 80 	movl   $0x80103f50,0x10(%eax)
  if(p->pid>2){
80103e73:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  p->headPG = -1;
80103e77:	c7 83 94 00 00 00 ff 	movl   $0xffffffff,0x94(%ebx)
80103e7e:	ff ff ff 
  if(p->pid>2){
80103e81:	0f 8f 89 00 00 00    	jg     80103f10 <allocproc+0x140>
80103e87:	8d 83 a4 00 00 00    	lea    0xa4(%ebx),%eax
80103e8d:	8d 93 e4 01 00 00    	lea    0x1e4(%ebx),%edx
80103e93:	90                   	nop
80103e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  }

  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103e98:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    p->swappedPGs[i].changeCounter = 0;
80103e9f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103ea5:	83 c0 14             	add    $0x14,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103ea8:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
80103eaf:	ff ff ff 
    p->physicalPGs[i].prev = 0;
80103eb2:	c7 80 30 01 00 00 00 	movl   $0x0,0x130(%eax)
80103eb9:	00 00 00 
    p->physicalPGs[i].next = 0;
80103ebc:	c7 80 2c 01 00 00 00 	movl   $0x0,0x12c(%eax)
80103ec3:	00 00 00 
    p->physicalPGs[i].age = 0;
80103ec6:	c7 80 24 01 00 00 00 	movl   $0x0,0x124(%eax)
80103ecd:	00 00 00 
    p->physicalPGs[i].alloceted = 0;
80103ed0:	c7 80 28 01 00 00 00 	movl   $0x0,0x128(%eax)
80103ed7:	00 00 00 
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103eda:	39 d0                	cmp    %edx,%eax
80103edc:	75 ba                	jne    80103e98 <allocproc+0xc8>
  }
  p->nTotalPGout = 0;
80103ede:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103ee5:	00 00 00 
  p->allocatedInPhys = 0;
80103ee8:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103eef:	00 00 00 
  p->nPgsSwap = 0;
80103ef2:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103ef9:	00 00 00 
  p->nPgsPhysical = 0;
80103efc:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103f03:	00 00 00 

  return p;
}
80103f06:	89 d8                	mov    %ebx,%eax
80103f08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f0b:	c9                   	leave  
80103f0c:	c3                   	ret    
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi
    createSwapFile(p);
80103f10:	83 ec 0c             	sub    $0xc,%esp
80103f13:	53                   	push   %ebx
80103f14:	e8 a7 e4 ff ff       	call   801023c0 <createSwapFile>
80103f19:	83 c4 10             	add    $0x10,%esp
80103f1c:	e9 66 ff ff ff       	jmp    80103e87 <allocproc+0xb7>
80103f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103f28:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103f2b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103f2d:	68 40 cd 14 80       	push   $0x8014cd40
80103f32:	e8 f9 11 00 00       	call   80105130 <release>
}
80103f37:	89 d8                	mov    %ebx,%eax
  return 0;
80103f39:	83 c4 10             	add    $0x10,%esp
}
80103f3c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f3f:	c9                   	leave  
80103f40:	c3                   	ret    
    p->state = UNUSED;
80103f41:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103f48:	31 db                	xor    %ebx,%ebx
80103f4a:	eb ba                	jmp    80103f06 <allocproc+0x136>
80103f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f50 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103f56:	68 40 cd 14 80       	push   $0x8014cd40
80103f5b:	e8 d0 11 00 00       	call   80105130 <release>

  if (first) {
80103f60:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103f65:	83 c4 10             	add    $0x10,%esp
80103f68:	85 c0                	test   %eax,%eax
80103f6a:	75 04                	jne    80103f70 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103f6c:	c9                   	leave  
80103f6d:	c3                   	ret    
80103f6e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103f70:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103f73:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103f7a:	00 00 00 
    iinit(ROOTDEV);
80103f7d:	6a 01                	push   $0x1
80103f7f:	e8 0c d7 ff ff       	call   80101690 <iinit>
    initlog(ROOTDEV);
80103f84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103f8b:	e8 40 f3 ff ff       	call   801032d0 <initlog>
80103f90:	83 c4 10             	add    $0x10,%esp
}
80103f93:	c9                   	leave  
80103f94:	c3                   	ret    
80103f95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103fa0 <pinit>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103fa6:	68 f5 8d 10 80       	push   $0x80108df5
80103fab:	68 40 cd 14 80       	push   $0x8014cd40
80103fb0:	e8 7b 0f 00 00       	call   80104f30 <initlock>
}
80103fb5:	83 c4 10             	add    $0x10,%esp
80103fb8:	c9                   	leave  
80103fb9:	c3                   	ret    
80103fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fc0 <mycpu>:
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	56                   	push   %esi
80103fc4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fc5:	9c                   	pushf  
80103fc6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103fc7:	f6 c4 02             	test   $0x2,%ah
80103fca:	75 5e                	jne    8010402a <mycpu+0x6a>
  apicid = lapicid();
80103fcc:	e8 2f ef ff ff       	call   80102f00 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103fd1:	8b 35 20 cd 14 80    	mov    0x8014cd20,%esi
80103fd7:	85 f6                	test   %esi,%esi
80103fd9:	7e 42                	jle    8010401d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103fdb:	0f b6 15 a0 c7 14 80 	movzbl 0x8014c7a0,%edx
80103fe2:	39 d0                	cmp    %edx,%eax
80103fe4:	74 30                	je     80104016 <mycpu+0x56>
80103fe6:	b9 50 c8 14 80       	mov    $0x8014c850,%ecx
  for (i = 0; i < ncpu; ++i) {
80103feb:	31 d2                	xor    %edx,%edx
80103fed:	8d 76 00             	lea    0x0(%esi),%esi
80103ff0:	83 c2 01             	add    $0x1,%edx
80103ff3:	39 f2                	cmp    %esi,%edx
80103ff5:	74 26                	je     8010401d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103ff7:	0f b6 19             	movzbl (%ecx),%ebx
80103ffa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80104000:	39 c3                	cmp    %eax,%ebx
80104002:	75 ec                	jne    80103ff0 <mycpu+0x30>
80104004:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010400a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
}
8010400f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104012:	5b                   	pop    %ebx
80104013:	5e                   	pop    %esi
80104014:	5d                   	pop    %ebp
80104015:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80104016:	b8 a0 c7 14 80       	mov    $0x8014c7a0,%eax
      return &cpus[i];
8010401b:	eb f2                	jmp    8010400f <mycpu+0x4f>
  panic("unknown apicid\n");
8010401d:	83 ec 0c             	sub    $0xc,%esp
80104020:	68 fc 8d 10 80       	push   $0x80108dfc
80104025:	e8 66 c3 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010402a:	83 ec 0c             	sub    $0xc,%esp
8010402d:	68 28 8f 10 80       	push   $0x80108f28
80104032:	e8 59 c3 ff ff       	call   80100390 <panic>
80104037:	89 f6                	mov    %esi,%esi
80104039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104040 <cpuid>:
cpuid() {
80104040:	55                   	push   %ebp
80104041:	89 e5                	mov    %esp,%ebp
80104043:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104046:	e8 75 ff ff ff       	call   80103fc0 <mycpu>
8010404b:	2d a0 c7 14 80       	sub    $0x8014c7a0,%eax
}
80104050:	c9                   	leave  
  return mycpu()-cpus;
80104051:	c1 f8 04             	sar    $0x4,%eax
80104054:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010405a:	c3                   	ret    
8010405b:	90                   	nop
8010405c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104060 <myproc>:
myproc(void) {
80104060:	55                   	push   %ebp
80104061:	89 e5                	mov    %esp,%ebp
80104063:	53                   	push   %ebx
80104064:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104067:	e8 34 0f 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
8010406c:	e8 4f ff ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
80104071:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104077:	e8 64 0f 00 00       	call   80104fe0 <popcli>
}
8010407c:	83 c4 04             	add    $0x4,%esp
8010407f:	89 d8                	mov    %ebx,%eax
80104081:	5b                   	pop    %ebx
80104082:	5d                   	pop    %ebp
80104083:	c3                   	ret    
80104084:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010408a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104090 <userinit>:
{
80104090:	55                   	push   %ebp
80104091:	89 e5                	mov    %esp,%ebp
80104093:	53                   	push   %ebx
80104094:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80104097:	e8 34 fd ff ff       	call   80103dd0 <allocproc>
8010409c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010409e:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  if((p->pgdir = setupkvm()) == 0)
801040a3:	e8 48 40 00 00       	call   801080f0 <setupkvm>
801040a8:	85 c0                	test   %eax,%eax
801040aa:	89 43 04             	mov    %eax,0x4(%ebx)
801040ad:	0f 84 da 00 00 00    	je     8010418d <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801040b3:	83 ec 04             	sub    $0x4,%esp
801040b6:	68 2c 00 00 00       	push   $0x2c
801040bb:	68 60 c4 10 80       	push   $0x8010c460
801040c0:	50                   	push   %eax
801040c1:	e8 1a 37 00 00       	call   801077e0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801040c6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801040c9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801040cf:	6a 4c                	push   $0x4c
801040d1:	6a 00                	push   $0x0
801040d3:	ff 73 18             	pushl  0x18(%ebx)
801040d6:	e8 a5 10 00 00       	call   80105180 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801040db:	8b 43 18             	mov    0x18(%ebx),%eax
801040de:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801040e3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801040e8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801040eb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801040ef:	8b 43 18             	mov    0x18(%ebx),%eax
801040f2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801040f6:	8b 43 18             	mov    0x18(%ebx),%eax
801040f9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801040fd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104101:	8b 43 18             	mov    0x18(%ebx),%eax
80104104:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104108:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010410c:	8b 43 18             	mov    0x18(%ebx),%eax
8010410f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104116:	8b 43 18             	mov    0x18(%ebx),%eax
80104119:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104120:	8b 43 18             	mov    0x18(%ebx),%eax
80104123:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010412a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010412d:	6a 10                	push   $0x10
8010412f:	68 25 8e 10 80       	push   $0x80108e25
80104134:	50                   	push   %eax
80104135:	e8 26 12 00 00       	call   80105360 <safestrcpy>
  p->cwd = namei("/");
8010413a:	c7 04 24 2e 8e 10 80 	movl   $0x80108e2e,(%esp)
80104141:	e8 aa df ff ff       	call   801020f0 <namei>
80104146:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
80104149:	c7 04 24 30 8e 10 80 	movl   $0x80108e30,(%esp)
80104150:	e8 0b c5 ff ff       	call   80100660 <cprintf>
80104155:	58                   	pop    %eax
80104156:	5a                   	pop    %edx
80104157:	68 00 e0 00 00       	push   $0xe000
8010415c:	68 38 8e 10 80       	push   $0x80108e38
80104161:	e8 fa c4 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
80104166:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
8010416d:	e8 fe 0e 00 00       	call   80105070 <acquire>
  p->state = RUNNABLE;
80104172:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104179:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104180:	e8 ab 0f 00 00       	call   80105130 <release>
}
80104185:	83 c4 10             	add    $0x10,%esp
80104188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010418b:	c9                   	leave  
8010418c:	c3                   	ret    
    panic("userinit: out of memory?");
8010418d:	83 ec 0c             	sub    $0xc,%esp
80104190:	68 0c 8e 10 80       	push   $0x80108e0c
80104195:	e8 f6 c1 ff ff       	call   80100390 <panic>
8010419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041a0 <growproc>:
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	56                   	push   %esi
801041a4:	53                   	push   %ebx
801041a5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801041a8:	e8 f3 0d 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801041ad:	e8 0e fe ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
801041b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041b8:	e8 23 0e 00 00       	call   80104fe0 <popcli>
  if(n > 0){
801041bd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801041c0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801041c2:	7f 1c                	jg     801041e0 <growproc+0x40>
  } else if(n < 0){
801041c4:	75 3a                	jne    80104200 <growproc+0x60>
  switchuvm(curproc);
801041c6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801041c9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801041cb:	53                   	push   %ebx
801041cc:	e8 ff 34 00 00       	call   801076d0 <switchuvm>
  return 0;
801041d1:	83 c4 10             	add    $0x10,%esp
801041d4:	31 c0                	xor    %eax,%eax
}
801041d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041d9:	5b                   	pop    %ebx
801041da:	5e                   	pop    %esi
801041db:	5d                   	pop    %ebp
801041dc:	c3                   	ret    
801041dd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801041e0:	83 ec 04             	sub    $0x4,%esp
801041e3:	01 c6                	add    %eax,%esi
801041e5:	56                   	push   %esi
801041e6:	50                   	push   %eax
801041e7:	ff 73 04             	pushl  0x4(%ebx)
801041ea:	e8 81 44 00 00       	call   80108670 <allocuvm>
801041ef:	83 c4 10             	add    $0x10,%esp
801041f2:	85 c0                	test   %eax,%eax
801041f4:	75 d0                	jne    801041c6 <growproc+0x26>
      return -1;
801041f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041fb:	eb d9                	jmp    801041d6 <growproc+0x36>
801041fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104200:	83 ec 04             	sub    $0x4,%esp
80104203:	01 c6                	add    %eax,%esi
80104205:	56                   	push   %esi
80104206:	50                   	push   %eax
80104207:	ff 73 04             	pushl  0x4(%ebx)
8010420a:	e8 31 3e 00 00       	call   80108040 <deallocuvm>
8010420f:	83 c4 10             	add    $0x10,%esp
80104212:	85 c0                	test   %eax,%eax
80104214:	75 b0                	jne    801041c6 <growproc+0x26>
80104216:	eb de                	jmp    801041f6 <growproc+0x56>
80104218:	90                   	nop
80104219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104220 <fork>:
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	57                   	push   %edi
80104224:	56                   	push   %esi
80104225:	53                   	push   %ebx
80104226:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104229:	e8 72 0d 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
8010422e:	e8 8d fd ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
80104233:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104239:	e8 a2 0d 00 00       	call   80104fe0 <popcli>
  if((np = allocproc()) == 0){
8010423e:	e8 8d fb ff ff       	call   80103dd0 <allocproc>
80104243:	85 c0                	test   %eax,%eax
80104245:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104248:	0f 84 75 02 00 00    	je     801044c3 <fork+0x2a3>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010424e:	83 ec 08             	sub    $0x8,%esp
80104251:	ff 33                	pushl  (%ebx)
80104253:	ff 73 04             	pushl  0x4(%ebx)
80104256:	e8 35 3f 00 00       	call   80108190 <copyuvm>
8010425b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010425e:	83 c4 10             	add    $0x10,%esp
80104261:	85 c0                	test   %eax,%eax
80104263:	89 42 04             	mov    %eax,0x4(%edx)
80104266:	0f 84 60 02 00 00    	je     801044cc <fork+0x2ac>
  np->sz = curproc->sz;
8010426c:	8b 03                	mov    (%ebx),%eax
  *np->tf = *curproc->tf;
8010426e:	8b 7a 18             	mov    0x18(%edx),%edi
80104271:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->parent = curproc;
80104276:	89 5a 14             	mov    %ebx,0x14(%edx)
  np->sz = curproc->sz;
80104279:	89 02                	mov    %eax,(%edx)
  *np->tf = *curproc->tf;
8010427b:	8b 73 18             	mov    0x18(%ebx),%esi
8010427e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104280:	31 f6                	xor    %esi,%esi
80104282:	89 d7                	mov    %edx,%edi
  np->tf->eax = 0;
80104284:	8b 42 18             	mov    0x18(%edx),%eax
80104287:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
8010428e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[i])
80104290:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104294:	85 c0                	test   %eax,%eax
80104296:	74 10                	je     801042a8 <fork+0x88>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	50                   	push   %eax
8010429c:	e8 5f cd ff ff       	call   80101000 <filedup>
801042a1:	83 c4 10             	add    $0x10,%esp
801042a4:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
801042a8:	83 c6 01             	add    $0x1,%esi
801042ab:	83 fe 10             	cmp    $0x10,%esi
801042ae:	75 e0                	jne    80104290 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801042b0:	83 ec 0c             	sub    $0xc,%esp
801042b3:	ff 73 68             	pushl  0x68(%ebx)
801042b6:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801042b9:	e8 a2 d5 ff ff       	call   80101860 <idup>
801042be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801042c1:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801042c4:	89 42 68             	mov    %eax,0x68(%edx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801042c7:	8d 43 6c             	lea    0x6c(%ebx),%eax
801042ca:	6a 10                	push   $0x10
801042cc:	50                   	push   %eax
801042cd:	8d 42 6c             	lea    0x6c(%edx),%eax
801042d0:	50                   	push   %eax
801042d1:	e8 8a 10 00 00       	call   80105360 <safestrcpy>
  pid = np->pid;
801042d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  if(curproc->pid>2){
801042d9:	83 c4 10             	add    $0x10,%esp
801042dc:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  pid = np->pid;
801042e0:	8b 42 10             	mov    0x10(%edx),%eax
801042e3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(curproc->pid>2){
801042e6:	0f 8e a3 01 00 00    	jle    8010448f <fork+0x26f>
    np->nTotalPGout = 0;
801042ec:	c7 82 88 00 00 00 00 	movl   $0x0,0x88(%edx)
801042f3:	00 00 00 
    np->nPGFLT = 0;
801042f6:	c7 82 8c 00 00 00 00 	movl   $0x0,0x8c(%edx)
801042fd:	00 00 00 
80104300:	8d 8b 98 00 00 00    	lea    0x98(%ebx),%ecx
    np->nPgsSwap = curproc->nPgsSwap;
80104306:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010430c:	8d b2 d8 01 00 00    	lea    0x1d8(%edx),%esi
80104312:	89 82 84 00 00 00    	mov    %eax,0x84(%edx)
    np->headPG = curproc->headPG;
80104318:	8b 83 94 00 00 00    	mov    0x94(%ebx),%eax
8010431e:	89 82 94 00 00 00    	mov    %eax,0x94(%edx)
80104324:	8d 82 98 00 00 00    	lea    0x98(%edx),%eax
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      np->physicalPGs[i].alloceted = 0;
80104330:	c7 80 48 01 00 00 00 	movl   $0x0,0x148(%eax)
80104337:	00 00 00 
      np->physicalPGs[i].next = 0;
8010433a:	c7 80 4c 01 00 00 00 	movl   $0x0,0x14c(%eax)
80104341:	00 00 00 
      np->physicalPGs[i].prev =  0 ;
80104344:	c7 80 50 01 00 00 00 	movl   $0x0,0x150(%eax)
8010434b:	00 00 00 
      np->physicalPGs[i].va = curproc->physicalPGs[i].va;
8010434e:	8b b9 40 01 00 00    	mov    0x140(%ecx),%edi
80104354:	89 b8 40 01 00 00    	mov    %edi,0x140(%eax)
      np->physicalPGs[i].age = curproc->physicalPGs[i].age;
8010435a:	8b b9 44 01 00 00    	mov    0x144(%ecx),%edi
80104360:	89 b8 44 01 00 00    	mov    %edi,0x144(%eax)
      np->physicalPGs[i].alloceted = curproc->physicalPGs[i].alloceted;
80104366:	8b b9 48 01 00 00    	mov    0x148(%ecx),%edi
8010436c:	89 b8 48 01 00 00    	mov    %edi,0x148(%eax)
      np->swappedPGs[i] = curproc->swappedPGs[i];
80104372:	8b 39                	mov    (%ecx),%edi
80104374:	89 38                	mov    %edi,(%eax)
80104376:	8b 79 04             	mov    0x4(%ecx),%edi
80104379:	89 78 04             	mov    %edi,0x4(%eax)
8010437c:	8b 79 08             	mov    0x8(%ecx),%edi
8010437f:	89 78 08             	mov    %edi,0x8(%eax)
80104382:	8b 79 0c             	mov    0xc(%ecx),%edi
80104385:	89 78 0c             	mov    %edi,0xc(%eax)
80104388:	8b 79 10             	mov    0x10(%ecx),%edi
8010438b:	89 78 10             	mov    %edi,0x10(%eax)
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
8010438e:	83 b9 40 01 00 00 ff 	cmpl   $0xffffffff,0x140(%ecx)
80104395:	74 07                	je     8010439e <fork+0x17e>
        np->nPgsPhysical++;
80104397:	83 82 80 00 00 00 01 	addl   $0x1,0x80(%edx)
8010439e:	83 c0 14             	add    $0x14,%eax
801043a1:	83 c1 14             	add    $0x14,%ecx
    for(int i = 0; i < MAX_PSYC_PAGES ; i++){
801043a4:	39 f0                	cmp    %esi,%eax
801043a6:	75 88                	jne    80104330 <fork+0x110>
801043a8:	31 f6                	xor    %esi,%esi
    for(int i = 0; i < MAX_PSYC_PAGES; i++){
801043aa:	31 ff                	xor    %edi,%edi
801043ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
801043b0:	83 bc 33 d8 01 00 00 	cmpl   $0xffffffff,0x1d8(%ebx,%esi,1)
801043b7:	ff 
801043b8:	74 5b                	je     80104415 <fork+0x1f5>
        int next = indexInPhysicalMem((uint)curproc->physicalPGs[i].next->va);
801043ba:	8b 84 33 e4 01 00 00 	mov    0x1e4(%ebx,%esi,1),%eax
801043c1:	83 ec 0c             	sub    $0xc,%esp
801043c4:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801043c7:	ff 30                	pushl  (%eax)
801043c9:	e8 22 39 00 00       	call   80107cf0 <indexInPhysicalMem>
        np->physicalPGs[i].next = &np->physicalPGs[next];
801043ce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801043d1:	8d 04 80             	lea    (%eax,%eax,4),%eax
        if(i!=curproc->headPG){
801043d4:	83 c4 10             	add    $0x10,%esp
        np->physicalPGs[i].next = &np->physicalPGs[next];
801043d7:	8d 84 82 d8 01 00 00 	lea    0x1d8(%edx,%eax,4),%eax
801043de:	89 84 32 e4 01 00 00 	mov    %eax,0x1e4(%edx,%esi,1)
        if(i!=curproc->headPG){
801043e5:	39 bb 94 00 00 00    	cmp    %edi,0x94(%ebx)
801043eb:	74 28                	je     80104415 <fork+0x1f5>
          int prev = indexInPhysicalMem((uint)curproc->physicalPGs[i].prev->va);
801043ed:	8b 84 33 e8 01 00 00 	mov    0x1e8(%ebx,%esi,1),%eax
801043f4:	83 ec 0c             	sub    $0xc,%esp
801043f7:	ff 30                	pushl  (%eax)
801043f9:	e8 f2 38 00 00       	call   80107cf0 <indexInPhysicalMem>
          np->physicalPGs[i].prev = &np->physicalPGs[prev];
801043fe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104401:	8d 04 80             	lea    (%eax,%eax,4),%eax
80104404:	83 c4 10             	add    $0x10,%esp
80104407:	8d 84 82 d8 01 00 00 	lea    0x1d8(%edx,%eax,4),%eax
8010440e:	89 84 32 e8 01 00 00 	mov    %eax,0x1e8(%edx,%esi,1)
    for(int i = 0; i < MAX_PSYC_PAGES; i++){
80104415:	83 c7 01             	add    $0x1,%edi
80104418:	83 c6 14             	add    $0x14,%esi
8010441b:	83 ff 10             	cmp    $0x10,%edi
8010441e:	75 90                	jne    801043b0 <fork+0x190>
80104420:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    char* newPage = kalloc();
80104423:	e8 98 e6 ff ff       	call   80102ac0 <kalloc>
80104428:	89 c7                	mov    %eax,%edi
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
8010442a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104430:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104433:	85 c0                	test   %eax,%eax
80104435:	7e 46                	jle    8010447d <fork+0x25d>
80104437:	31 f6                	xor    %esi,%esi
80104439:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010443c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104440:	89 f1                	mov    %esi,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
80104442:	68 00 10 00 00       	push   $0x1000
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
80104447:	83 c6 01             	add    $0x1,%esi
8010444a:	c1 e1 0c             	shl    $0xc,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
8010444d:	51                   	push   %ecx
8010444e:	57                   	push   %edi
8010444f:	53                   	push   %ebx
80104450:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104453:	e8 38 e0 ff ff       	call   80102490 <readFromSwapFile>
      writeToSwapFile(np,newPage,i*PGSIZE,PGSIZE);
80104458:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010445b:	68 00 10 00 00       	push   $0x1000
80104460:	51                   	push   %ecx
80104461:	57                   	push   %edi
80104462:	ff 75 e0             	pushl  -0x20(%ebp)
80104465:	e8 f6 df ff ff       	call   80102460 <writeToSwapFile>
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
8010446a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104470:	83 c4 20             	add    $0x20,%esp
80104473:	c1 e0 0c             	shl    $0xc,%eax
80104476:	39 f0                	cmp    %esi,%eax
80104478:	7f c6                	jg     80104440 <fork+0x220>
8010447a:	8b 55 e0             	mov    -0x20(%ebp),%edx
    kfree(newPage);
8010447d:	83 ec 0c             	sub    $0xc,%esp
80104480:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104483:	57                   	push   %edi
80104484:	e8 27 e4 ff ff       	call   801028b0 <kfree>
80104489:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010448c:	83 c4 10             	add    $0x10,%esp
  acquire(&ptable.lock);
8010448f:	83 ec 0c             	sub    $0xc,%esp
80104492:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104495:	68 40 cd 14 80       	push   $0x8014cd40
8010449a:	e8 d1 0b 00 00       	call   80105070 <acquire>
  np->state = RUNNABLE;
8010449f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044a2:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  release(&ptable.lock);
801044a9:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801044b0:	e8 7b 0c 00 00       	call   80105130 <release>
  return pid;
801044b5:	83 c4 10             	add    $0x10,%esp
}
801044b8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044be:	5b                   	pop    %ebx
801044bf:	5e                   	pop    %esi
801044c0:	5f                   	pop    %edi
801044c1:	5d                   	pop    %ebp
801044c2:	c3                   	ret    
    return -1;
801044c3:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
801044ca:	eb ec                	jmp    801044b8 <fork+0x298>
    kfree(np->kstack);
801044cc:	83 ec 0c             	sub    $0xc,%esp
801044cf:	ff 72 08             	pushl  0x8(%edx)
801044d2:	e8 d9 e3 ff ff       	call   801028b0 <kfree>
    np->kstack = 0;
801044d7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;
801044da:	83 c4 10             	add    $0x10,%esp
801044dd:	c7 45 dc ff ff ff ff 	movl   $0xffffffff,-0x24(%ebp)
    np->kstack = 0;
801044e4:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
    np->state = UNUSED;
801044eb:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
    return -1;
801044f2:	eb c4                	jmp    801044b8 <fork+0x298>
801044f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104500 <scheduler>:
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	57                   	push   %edi
80104504:	56                   	push   %esi
80104505:	53                   	push   %ebx
80104506:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104509:	e8 b2 fa ff ff       	call   80103fc0 <mycpu>
8010450e:	8d 78 04             	lea    0x4(%eax),%edi
80104511:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104513:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010451a:	00 00 00 
8010451d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104520:	fb                   	sti    
    acquire(&ptable.lock);
80104521:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104524:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
    acquire(&ptable.lock);
80104529:	68 40 cd 14 80       	push   $0x8014cd40
8010452e:	e8 3d 0b 00 00       	call   80105070 <acquire>
80104533:	83 c4 10             	add    $0x10,%esp
80104536:	8d 76 00             	lea    0x0(%esi),%esi
80104539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80104540:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104544:	75 33                	jne    80104579 <scheduler+0x79>
      switchuvm(p);
80104546:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104549:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010454f:	53                   	push   %ebx
80104550:	e8 7b 31 00 00       	call   801076d0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104555:	58                   	pop    %eax
80104556:	5a                   	pop    %edx
80104557:	ff 73 1c             	pushl  0x1c(%ebx)
8010455a:	57                   	push   %edi
      p->state = RUNNING;
8010455b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104562:	e8 54 0e 00 00       	call   801053bb <swtch>
      switchkvm();
80104567:	e8 44 31 00 00       	call   801076b0 <switchkvm>
      c->proc = 0;
8010456c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104573:	00 00 00 
80104576:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104579:	81 c3 18 03 00 00    	add    $0x318,%ebx
8010457f:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104585:	72 b9                	jb     80104540 <scheduler+0x40>
    release(&ptable.lock);
80104587:	83 ec 0c             	sub    $0xc,%esp
8010458a:	68 40 cd 14 80       	push   $0x8014cd40
8010458f:	e8 9c 0b 00 00       	call   80105130 <release>
    sti();
80104594:	83 c4 10             	add    $0x10,%esp
80104597:	eb 87                	jmp    80104520 <scheduler+0x20>
80104599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045a0 <sched>:
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
  pushcli();
801045a5:	e8 f6 09 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801045aa:	e8 11 fa ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
801045af:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045b5:	e8 26 0a 00 00       	call   80104fe0 <popcli>
  if(!holding(&ptable.lock))
801045ba:	83 ec 0c             	sub    $0xc,%esp
801045bd:	68 40 cd 14 80       	push   $0x8014cd40
801045c2:	e8 79 0a 00 00       	call   80105040 <holding>
801045c7:	83 c4 10             	add    $0x10,%esp
801045ca:	85 c0                	test   %eax,%eax
801045cc:	74 4f                	je     8010461d <sched+0x7d>
  if(mycpu()->ncli != 1)
801045ce:	e8 ed f9 ff ff       	call   80103fc0 <mycpu>
801045d3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801045da:	75 68                	jne    80104644 <sched+0xa4>
  if(p->state == RUNNING)
801045dc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801045e0:	74 55                	je     80104637 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045e2:	9c                   	pushf  
801045e3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045e4:	f6 c4 02             	test   $0x2,%ah
801045e7:	75 41                	jne    8010462a <sched+0x8a>
  intena = mycpu()->intena;
801045e9:	e8 d2 f9 ff ff       	call   80103fc0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801045ee:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801045f1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801045f7:	e8 c4 f9 ff ff       	call   80103fc0 <mycpu>
801045fc:	83 ec 08             	sub    $0x8,%esp
801045ff:	ff 70 04             	pushl  0x4(%eax)
80104602:	53                   	push   %ebx
80104603:	e8 b3 0d 00 00       	call   801053bb <swtch>
  mycpu()->intena = intena;
80104608:	e8 b3 f9 ff ff       	call   80103fc0 <mycpu>
}
8010460d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104610:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104616:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104619:	5b                   	pop    %ebx
8010461a:	5e                   	pop    %esi
8010461b:	5d                   	pop    %ebp
8010461c:	c3                   	ret    
    panic("sched ptable.lock");
8010461d:	83 ec 0c             	sub    $0xc,%esp
80104620:	68 3b 8e 10 80       	push   $0x80108e3b
80104625:	e8 66 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010462a:	83 ec 0c             	sub    $0xc,%esp
8010462d:	68 67 8e 10 80       	push   $0x80108e67
80104632:	e8 59 bd ff ff       	call   80100390 <panic>
    panic("sched running");
80104637:	83 ec 0c             	sub    $0xc,%esp
8010463a:	68 59 8e 10 80       	push   $0x80108e59
8010463f:	e8 4c bd ff ff       	call   80100390 <panic>
    panic("sched locks");
80104644:	83 ec 0c             	sub    $0xc,%esp
80104647:	68 4d 8e 10 80       	push   $0x80108e4d
8010464c:	e8 3f bd ff ff       	call   80100390 <panic>
80104651:	eb 0d                	jmp    80104660 <exit>
80104653:	90                   	nop
80104654:	90                   	nop
80104655:	90                   	nop
80104656:	90                   	nop
80104657:	90                   	nop
80104658:	90                   	nop
80104659:	90                   	nop
8010465a:	90                   	nop
8010465b:	90                   	nop
8010465c:	90                   	nop
8010465d:	90                   	nop
8010465e:	90                   	nop
8010465f:	90                   	nop

80104660 <exit>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	53                   	push   %ebx
80104666:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104669:	e8 32 09 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
8010466e:	e8 4d f9 ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
80104673:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104679:	e8 62 09 00 00       	call   80104fe0 <popcli>
  if(curproc == initproc)
8010467e:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
80104684:	8d 5e 28             	lea    0x28(%esi),%ebx
80104687:	8d 7e 68             	lea    0x68(%esi),%edi
8010468a:	0f 84 1e 01 00 00    	je     801047ae <exit+0x14e>
    if(curproc->ofile[fd]){
80104690:	8b 03                	mov    (%ebx),%eax
80104692:	85 c0                	test   %eax,%eax
80104694:	74 12                	je     801046a8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104696:	83 ec 0c             	sub    $0xc,%esp
80104699:	50                   	push   %eax
8010469a:	e8 b1 c9 ff ff       	call   80101050 <fileclose>
      curproc->ofile[fd] = 0;
8010469f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046a5:	83 c4 10             	add    $0x10,%esp
801046a8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801046ab:	39 fb                	cmp    %edi,%ebx
801046ad:	75 e1                	jne    80104690 <exit+0x30>
  if(removeSwapFile(curproc) != 0){
801046af:	83 ec 0c             	sub    $0xc,%esp
801046b2:	56                   	push   %esi
801046b3:	e8 08 db ff ff       	call   801021c0 <removeSwapFile>
801046b8:	83 c4 10             	add    $0x10,%esp
801046bb:	85 c0                	test   %eax,%eax
801046bd:	0f 85 c5 00 00 00    	jne    80104788 <exit+0x128>
  begin_op();
801046c3:	e8 a8 ec ff ff       	call   80103370 <begin_op>
  iput(curproc->cwd);
801046c8:	83 ec 0c             	sub    $0xc,%esp
801046cb:	ff 76 68             	pushl  0x68(%esi)
801046ce:	e8 ed d2 ff ff       	call   801019c0 <iput>
  end_op();
801046d3:	e8 08 ed ff ff       	call   801033e0 <end_op>
  curproc->cwd = 0;
801046d8:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801046df:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801046e6:	e8 85 09 00 00       	call   80105070 <acquire>
  wakeup1(curproc->parent);
801046eb:	8b 56 14             	mov    0x14(%esi),%edx
801046ee:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046f1:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801046f6:	eb 14                	jmp    8010470c <exit+0xac>
801046f8:	90                   	nop
801046f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104700:	05 18 03 00 00       	add    $0x318,%eax
80104705:	3d 74 93 15 80       	cmp    $0x80159374,%eax
8010470a:	73 1e                	jae    8010472a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010470c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104710:	75 ee                	jne    80104700 <exit+0xa0>
80104712:	3b 50 20             	cmp    0x20(%eax),%edx
80104715:	75 e9                	jne    80104700 <exit+0xa0>
      p->state = RUNNABLE;
80104717:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010471e:	05 18 03 00 00       	add    $0x318,%eax
80104723:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104728:	72 e2                	jb     8010470c <exit+0xac>
      p->parent = initproc;
8010472a:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104730:	ba 74 cd 14 80       	mov    $0x8014cd74,%edx
80104735:	eb 17                	jmp    8010474e <exit+0xee>
80104737:	89 f6                	mov    %esi,%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104740:	81 c2 18 03 00 00    	add    $0x318,%edx
80104746:	81 fa 74 93 15 80    	cmp    $0x80159374,%edx
8010474c:	73 47                	jae    80104795 <exit+0x135>
    if(p->parent == curproc){
8010474e:	39 72 14             	cmp    %esi,0x14(%edx)
80104751:	75 ed                	jne    80104740 <exit+0xe0>
      if(p->state == ZOMBIE)
80104753:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104757:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010475a:	75 e4                	jne    80104740 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010475c:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104761:	eb 11                	jmp    80104774 <exit+0x114>
80104763:	90                   	nop
80104764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104768:	05 18 03 00 00       	add    $0x318,%eax
8010476d:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104772:	73 cc                	jae    80104740 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80104774:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104778:	75 ee                	jne    80104768 <exit+0x108>
8010477a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010477d:	75 e9                	jne    80104768 <exit+0x108>
      p->state = RUNNABLE;
8010477f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104786:	eb e0                	jmp    80104768 <exit+0x108>
    panic("exit: cant remove swapfile");
80104788:	83 ec 0c             	sub    $0xc,%esp
8010478b:	68 88 8e 10 80       	push   $0x80108e88
80104790:	e8 fb bb ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
80104795:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010479c:	e8 ff fd ff ff       	call   801045a0 <sched>
  panic("zombie exit");
801047a1:	83 ec 0c             	sub    $0xc,%esp
801047a4:	68 a3 8e 10 80       	push   $0x80108ea3
801047a9:	e8 e2 bb ff ff       	call   80100390 <panic>
    panic("init exiting");
801047ae:	83 ec 0c             	sub    $0xc,%esp
801047b1:	68 7b 8e 10 80       	push   $0x80108e7b
801047b6:	e8 d5 bb ff ff       	call   80100390 <panic>
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047c0 <yield>:
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	53                   	push   %ebx
801047c4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801047c7:	68 40 cd 14 80       	push   $0x8014cd40
801047cc:	e8 9f 08 00 00       	call   80105070 <acquire>
  pushcli();
801047d1:	e8 ca 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801047d6:	e8 e5 f7 ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
801047db:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047e1:	e8 fa 07 00 00       	call   80104fe0 <popcli>
  myproc()->state = RUNNABLE;
801047e6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801047ed:	e8 ae fd ff ff       	call   801045a0 <sched>
  release(&ptable.lock);
801047f2:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801047f9:	e8 32 09 00 00       	call   80105130 <release>
}
801047fe:	83 c4 10             	add    $0x10,%esp
80104801:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104804:	c9                   	leave  
80104805:	c3                   	ret    
80104806:	8d 76 00             	lea    0x0(%esi),%esi
80104809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104810 <sleep>:
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	57                   	push   %edi
80104814:	56                   	push   %esi
80104815:	53                   	push   %ebx
80104816:	83 ec 0c             	sub    $0xc,%esp
80104819:	8b 7d 08             	mov    0x8(%ebp),%edi
8010481c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010481f:	e8 7c 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104824:	e8 97 f7 ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
80104829:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010482f:	e8 ac 07 00 00       	call   80104fe0 <popcli>
  if(p == 0)
80104834:	85 db                	test   %ebx,%ebx
80104836:	0f 84 87 00 00 00    	je     801048c3 <sleep+0xb3>
  if(lk == 0)
8010483c:	85 f6                	test   %esi,%esi
8010483e:	74 76                	je     801048b6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104840:	81 fe 40 cd 14 80    	cmp    $0x8014cd40,%esi
80104846:	74 50                	je     80104898 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104848:	83 ec 0c             	sub    $0xc,%esp
8010484b:	68 40 cd 14 80       	push   $0x8014cd40
80104850:	e8 1b 08 00 00       	call   80105070 <acquire>
    release(lk);
80104855:	89 34 24             	mov    %esi,(%esp)
80104858:	e8 d3 08 00 00       	call   80105130 <release>
  p->chan = chan;
8010485d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104860:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104867:	e8 34 fd ff ff       	call   801045a0 <sched>
  p->chan = 0;
8010486c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104873:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
8010487a:	e8 b1 08 00 00       	call   80105130 <release>
    acquire(lk);
8010487f:	89 75 08             	mov    %esi,0x8(%ebp)
80104882:	83 c4 10             	add    $0x10,%esp
}
80104885:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104888:	5b                   	pop    %ebx
80104889:	5e                   	pop    %esi
8010488a:	5f                   	pop    %edi
8010488b:	5d                   	pop    %ebp
    acquire(lk);
8010488c:	e9 df 07 00 00       	jmp    80105070 <acquire>
80104891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104898:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010489b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801048a2:	e8 f9 fc ff ff       	call   801045a0 <sched>
  p->chan = 0;
801048a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801048ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048b1:	5b                   	pop    %ebx
801048b2:	5e                   	pop    %esi
801048b3:	5f                   	pop    %edi
801048b4:	5d                   	pop    %ebp
801048b5:	c3                   	ret    
    panic("sleep without lk");
801048b6:	83 ec 0c             	sub    $0xc,%esp
801048b9:	68 b5 8e 10 80       	push   $0x80108eb5
801048be:	e8 cd ba ff ff       	call   80100390 <panic>
    panic("sleep");
801048c3:	83 ec 0c             	sub    $0xc,%esp
801048c6:	68 af 8e 10 80       	push   $0x80108eaf
801048cb:	e8 c0 ba ff ff       	call   80100390 <panic>

801048d0 <wait>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
  pushcli();
801048d5:	e8 c6 06 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801048da:	e8 e1 f6 ff ff       	call   80103fc0 <mycpu>
  p = c->proc;
801048df:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048e5:	e8 f6 06 00 00       	call   80104fe0 <popcli>
  acquire(&ptable.lock);
801048ea:	83 ec 0c             	sub    $0xc,%esp
801048ed:	68 40 cd 14 80       	push   $0x8014cd40
801048f2:	e8 79 07 00 00       	call   80105070 <acquire>
801048f7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801048fa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048fc:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
80104901:	eb 13                	jmp    80104916 <wait+0x46>
80104903:	90                   	nop
80104904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104908:	81 c3 18 03 00 00    	add    $0x318,%ebx
8010490e:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104914:	73 1e                	jae    80104934 <wait+0x64>
      if(p->parent != curproc)
80104916:	39 73 14             	cmp    %esi,0x14(%ebx)
80104919:	75 ed                	jne    80104908 <wait+0x38>
      if(p->state == ZOMBIE){
8010491b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010491f:	74 3f                	je     80104960 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104921:	81 c3 18 03 00 00    	add    $0x318,%ebx
      havekids = 1;
80104927:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010492c:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104932:	72 e2                	jb     80104916 <wait+0x46>
    if(!havekids || curproc->killed){
80104934:	85 c0                	test   %eax,%eax
80104936:	0f 84 d0 00 00 00    	je     80104a0c <wait+0x13c>
8010493c:	8b 46 24             	mov    0x24(%esi),%eax
8010493f:	85 c0                	test   %eax,%eax
80104941:	0f 85 c5 00 00 00    	jne    80104a0c <wait+0x13c>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104947:	83 ec 08             	sub    $0x8,%esp
8010494a:	68 40 cd 14 80       	push   $0x8014cd40
8010494f:	56                   	push   %esi
80104950:	e8 bb fe ff ff       	call   80104810 <sleep>
    havekids = 0;
80104955:	83 c4 10             	add    $0x10,%esp
80104958:	eb a0                	jmp    801048fa <wait+0x2a>
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104960:	8d 83 a4 00 00 00    	lea    0xa4(%ebx),%eax
80104966:	8d 93 e4 01 00 00    	lea    0x1e4(%ebx),%edx
8010496c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
              p->swappedPGs[i].va = (char*)0xffffffff;
80104970:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
              p->swappedPGs[i].changeCounter = 0;
80104977:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010497d:	83 c0 14             	add    $0x14,%eax
              p->physicalPGs[i].va = (char*)0xffffffff;
80104980:	c7 80 20 01 00 00 ff 	movl   $0xffffffff,0x120(%eax)
80104987:	ff ff ff 
              p->physicalPGs[i].prev = 0;
8010498a:	c7 80 30 01 00 00 00 	movl   $0x0,0x130(%eax)
80104991:	00 00 00 
              p->physicalPGs[i].next = 0;
80104994:	c7 80 2c 01 00 00 00 	movl   $0x0,0x12c(%eax)
8010499b:	00 00 00 
              p->physicalPGs[i].age = 0;
8010499e:	c7 80 24 01 00 00 00 	movl   $0x0,0x124(%eax)
801049a5:	00 00 00 
              p->physicalPGs[i].alloceted = 0;
801049a8:	c7 80 28 01 00 00 00 	movl   $0x0,0x128(%eax)
801049af:	00 00 00 
        for(i = 0; i < MAX_PSYC_PAGES; i++){
801049b2:	39 d0                	cmp    %edx,%eax
801049b4:	75 ba                	jne    80104970 <wait+0xa0>
        kfree(p->kstack);
801049b6:	83 ec 0c             	sub    $0xc,%esp
801049b9:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801049bc:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801049bf:	e8 ec de ff ff       	call   801028b0 <kfree>
        freevm(p->pgdir);
801049c4:	5a                   	pop    %edx
801049c5:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801049c8:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801049cf:	e8 9c 36 00 00       	call   80108070 <freevm>
        release(&ptable.lock);
801049d4:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
        p->pid = 0;
801049db:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801049e2:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801049e9:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801049ed:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801049f4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801049fb:	e8 30 07 00 00       	call   80105130 <release>
        return pid;
80104a00:	83 c4 10             	add    $0x10,%esp
}
80104a03:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a06:	89 f0                	mov    %esi,%eax
80104a08:	5b                   	pop    %ebx
80104a09:	5e                   	pop    %esi
80104a0a:	5d                   	pop    %ebp
80104a0b:	c3                   	ret    
      release(&ptable.lock);
80104a0c:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104a0f:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104a14:	68 40 cd 14 80       	push   $0x8014cd40
80104a19:	e8 12 07 00 00       	call   80105130 <release>
      return -1;
80104a1e:	83 c4 10             	add    $0x10,%esp
80104a21:	eb e0                	jmp    80104a03 <wait+0x133>
80104a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a30 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	53                   	push   %ebx
80104a34:	83 ec 10             	sub    $0x10,%esp
80104a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104a3a:	68 40 cd 14 80       	push   $0x8014cd40
80104a3f:	e8 2c 06 00 00       	call   80105070 <acquire>
80104a44:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a47:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104a4c:	eb 0e                	jmp    80104a5c <wakeup+0x2c>
80104a4e:	66 90                	xchg   %ax,%ax
80104a50:	05 18 03 00 00       	add    $0x318,%eax
80104a55:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104a5a:	73 1e                	jae    80104a7a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
80104a5c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a60:	75 ee                	jne    80104a50 <wakeup+0x20>
80104a62:	3b 58 20             	cmp    0x20(%eax),%ebx
80104a65:	75 e9                	jne    80104a50 <wakeup+0x20>
      p->state = RUNNABLE;
80104a67:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a6e:	05 18 03 00 00       	add    $0x318,%eax
80104a73:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104a78:	72 e2                	jb     80104a5c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
80104a7a:	c7 45 08 40 cd 14 80 	movl   $0x8014cd40,0x8(%ebp)
}
80104a81:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a84:	c9                   	leave  
  release(&ptable.lock);
80104a85:	e9 a6 06 00 00       	jmp    80105130 <release>
80104a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a90 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 10             	sub    $0x10,%esp
80104a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104a9a:	68 40 cd 14 80       	push   $0x8014cd40
80104a9f:	e8 cc 05 00 00       	call   80105070 <acquire>
80104aa4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa7:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104aac:	eb 0e                	jmp    80104abc <kill+0x2c>
80104aae:	66 90                	xchg   %ax,%ax
80104ab0:	05 18 03 00 00       	add    $0x318,%eax
80104ab5:	3d 74 93 15 80       	cmp    $0x80159374,%eax
80104aba:	73 34                	jae    80104af0 <kill+0x60>
    if(p->pid == pid){
80104abc:	39 58 10             	cmp    %ebx,0x10(%eax)
80104abf:	75 ef                	jne    80104ab0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104ac1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104ac5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104acc:	75 07                	jne    80104ad5 <kill+0x45>
        p->state = RUNNABLE;
80104ace:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104ad5:	83 ec 0c             	sub    $0xc,%esp
80104ad8:	68 40 cd 14 80       	push   $0x8014cd40
80104add:	e8 4e 06 00 00       	call   80105130 <release>
      return 0;
80104ae2:	83 c4 10             	add    $0x10,%esp
80104ae5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104ae7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aea:	c9                   	leave  
80104aeb:	c3                   	ret    
80104aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104af0:	83 ec 0c             	sub    $0xc,%esp
80104af3:	68 40 cd 14 80       	push   $0x8014cd40
80104af8:	e8 33 06 00 00       	call   80105130 <release>
  return -1;
80104afd:	83 c4 10             	add    $0x10,%esp
80104b00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b08:	c9                   	leave  
80104b09:	c3                   	ret    
80104b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b10 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	53                   	push   %ebx
80104b16:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b19:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80104b1e:	83 ec 3c             	sub    $0x3c,%esp
80104b21:	eb 27                	jmp    80104b4a <procdump+0x3a>
80104b23:	90                   	nop
80104b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b28:	83 ec 0c             	sub    $0xc,%esp
80104b2b:	68 0c 94 10 80       	push   $0x8010940c
80104b30:	e8 2b bb ff ff       	call   80100660 <cprintf>
80104b35:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b38:	81 c3 18 03 00 00    	add    $0x318,%ebx
80104b3e:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104b44:	0f 83 a6 00 00 00    	jae    80104bf0 <procdump+0xe0>
    if(p->state == UNUSED)
80104b4a:	8b 43 0c             	mov    0xc(%ebx),%eax
80104b4d:	85 c0                	test   %eax,%eax
80104b4f:	74 e7                	je     80104b38 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b51:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104b54:	ba c6 8e 10 80       	mov    $0x80108ec6,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b59:	77 11                	ja     80104b6c <procdump+0x5c>
80104b5b:	8b 14 85 c4 8f 10 80 	mov    -0x7fef703c(,%eax,4),%edx
      state = "???";
80104b62:	b8 c6 8e 10 80       	mov    $0x80108ec6,%eax
80104b67:	85 d2                	test   %edx,%edx
80104b69:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d allocated: %d   inPhysical: %d   swapped: %d   swappedOut: %d   %s %s", p->pid, p->allocatedInPhys, p->nPgsPhysical, p->nPgsSwap,p->nTotalPGout, state, p->name);
80104b6c:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104b6f:	50                   	push   %eax
80104b70:	52                   	push   %edx
80104b71:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104b77:	ff b3 84 00 00 00    	pushl  0x84(%ebx)
80104b7d:	ff b3 80 00 00 00    	pushl  0x80(%ebx)
80104b83:	ff b3 90 00 00 00    	pushl  0x90(%ebx)
80104b89:	ff 73 10             	pushl  0x10(%ebx)
80104b8c:	68 50 8f 10 80       	push   $0x80108f50
80104b91:	e8 ca ba ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104b96:	83 c4 20             	add    $0x20,%esp
80104b99:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104b9d:	75 89                	jne    80104b28 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104b9f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104ba2:	83 ec 08             	sub    $0x8,%esp
80104ba5:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104ba8:	50                   	push   %eax
80104ba9:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104bac:	8b 40 0c             	mov    0xc(%eax),%eax
80104baf:	83 c0 08             	add    $0x8,%eax
80104bb2:	50                   	push   %eax
80104bb3:	e8 98 03 00 00       	call   80104f50 <getcallerpcs>
80104bb8:	83 c4 10             	add    $0x10,%esp
80104bbb:	90                   	nop
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104bc0:	8b 17                	mov    (%edi),%edx
80104bc2:	85 d2                	test   %edx,%edx
80104bc4:	0f 84 5e ff ff ff    	je     80104b28 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104bca:	83 ec 08             	sub    $0x8,%esp
80104bcd:	83 c7 04             	add    $0x4,%edi
80104bd0:	52                   	push   %edx
80104bd1:	68 41 88 10 80       	push   $0x80108841
80104bd6:	e8 85 ba ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104bdb:	83 c4 10             	add    $0x10,%esp
80104bde:	39 fe                	cmp    %edi,%esi
80104be0:	75 de                	jne    80104bc0 <procdump+0xb0>
80104be2:	e9 41 ff ff ff       	jmp    80104b28 <procdump+0x18>
80104be7:	89 f6                	mov    %esi,%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
80104bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bf3:	5b                   	pop    %ebx
80104bf4:	5e                   	pop    %esi
80104bf5:	5f                   	pop    %edi
80104bf6:	5d                   	pop    %ebp
80104bf7:	c3                   	ret    
80104bf8:	90                   	nop
80104bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c00 <nfuaTickUpdate>:

//update aging mechanisem of nfua algo each tick form trap.c
void
nfuaTickUpdate(){
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	57                   	push   %edi
80104c04:	56                   	push   %esi
80104c05:	53                   	push   %ebx
  struct proc *p;
  pte_t *pte,*pde,*pgtab;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c06:	be 74 cd 14 80       	mov    $0x8014cd74,%esi
nfuaTickUpdate(){
80104c0b:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
80104c0e:	68 40 cd 14 80       	push   $0x8014cd40
80104c13:	e8 58 04 00 00       	call   80105070 <acquire>
80104c18:	83 c4 10             	add    $0x10,%esp
80104c1b:	90                   	nop
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid<=2)
80104c20:	83 7e 10 02          	cmpl   $0x2,0x10(%esi)
80104c24:	0f 8e 86 00 00 00    	jle    80104cb0 <nfuaTickUpdate+0xb0>
      continue;
    if(!((p->state == RUNNING) || (p->state == RUNNABLE) || (p->state == SLEEPING)))
80104c2a:	8b 46 0c             	mov    0xc(%esi),%eax
80104c2d:	83 e8 02             	sub    $0x2,%eax
80104c30:	83 f8 02             	cmp    $0x2,%eax
80104c33:	77 7b                	ja     80104cb0 <nfuaTickUpdate+0xb0>
80104c35:	8d 9e dc 01 00 00    	lea    0x1dc(%esi),%ebx
80104c3b:	8d be 1c 03 00 00    	lea    0x31c(%esi),%edi
80104c41:	eb 37                	jmp    80104c7a <nfuaTickUpdate+0x7a>
80104c43:	90                   	nop
80104c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        continue;
      
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
      if(*pde & PTE_P){
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104c48:	c1 e8 0a             	shr    $0xa,%eax
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80104c4b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104c51:	25 fc 0f 00 00       	and    $0xffc,%eax
80104c56:	8d 94 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edx
      } else {
        cprintf("nfuaUpdate: pte is not PTE_P\n");
        continue;
      }
      if(!pte){
80104c5d:	85 d2                	test   %edx,%edx
80104c5f:	74 7f                	je     80104ce0 <nfuaTickUpdate+0xe0>
        cprintf("nfuaUpdate : !pte\n");
        continue;
      }

      p->physicalPGs[i].age = ((p->physicalPGs[i].age) >> 1); // shift right
80104c61:	8b 03                	mov    (%ebx),%eax
80104c63:	d1 e8                	shr    %eax
80104c65:	89 03                	mov    %eax,(%ebx)
      //cprintf("shifted: %x\n",p->physicalPGs[i].age);

      if(*pte & PTE_A){                                       // set MSB if accessed
80104c67:	f6 02 20             	testb  $0x20,(%edx)
80104c6a:	74 07                	je     80104c73 <nfuaTickUpdate+0x73>
        uint newBit = 1 << ((sizeof(uint)*8) - 1);
        p->physicalPGs[i].age |= newBit;
80104c6c:	0d 00 00 00 80       	or     $0x80000000,%eax
80104c71:	89 03                	mov    %eax,(%ebx)
80104c73:	83 c3 14             	add    $0x14,%ebx
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104c76:	39 df                	cmp    %ebx,%edi
80104c78:	74 36                	je     80104cb0 <nfuaTickUpdate+0xb0>
      if(p->physicalPGs[i].va == (char*)0xffffffff)
80104c7a:	8b 43 fc             	mov    -0x4(%ebx),%eax
80104c7d:	83 f8 ff             	cmp    $0xffffffff,%eax
80104c80:	74 f1                	je     80104c73 <nfuaTickUpdate+0x73>
      if(*pde & PTE_P){
80104c82:	8b 56 04             	mov    0x4(%esi),%edx
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
80104c85:	89 c1                	mov    %eax,%ecx
80104c87:	c1 e9 16             	shr    $0x16,%ecx
      if(*pde & PTE_P){
80104c8a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80104c8d:	f6 c2 01             	test   $0x1,%dl
80104c90:	75 b6                	jne    80104c48 <nfuaTickUpdate+0x48>
        cprintf("nfuaUpdate: pte is not PTE_P\n");
80104c92:	83 ec 0c             	sub    $0xc,%esp
80104c95:	83 c3 14             	add    $0x14,%ebx
80104c98:	68 ca 8e 10 80       	push   $0x80108eca
80104c9d:	e8 be b9 ff ff       	call   80100660 <cprintf>
        continue;
80104ca2:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104ca5:	39 df                	cmp    %ebx,%edi
80104ca7:	75 d1                	jne    80104c7a <nfuaTickUpdate+0x7a>
80104ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cb0:	81 c6 18 03 00 00    	add    $0x318,%esi
80104cb6:	81 fe 74 93 15 80    	cmp    $0x80159374,%esi
80104cbc:	0f 82 5e ff ff ff    	jb     80104c20 <nfuaTickUpdate+0x20>
      }
    }
  }
  release(&ptable.lock);
80104cc2:	83 ec 0c             	sub    $0xc,%esp
80104cc5:	68 40 cd 14 80       	push   $0x8014cd40
80104cca:	e8 61 04 00 00       	call   80105130 <release>
}
80104ccf:	83 c4 10             	add    $0x10,%esp
80104cd2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cd5:	5b                   	pop    %ebx
80104cd6:	5e                   	pop    %esi
80104cd7:	5f                   	pop    %edi
80104cd8:	5d                   	pop    %ebp
80104cd9:	c3                   	ret    
80104cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate : !pte\n");
80104ce0:	83 ec 0c             	sub    $0xc,%esp
80104ce3:	68 e8 8e 10 80       	push   $0x80108ee8
80104ce8:	e8 73 b9 ff ff       	call   80100660 <cprintf>
        continue;
80104ced:	83 c4 10             	add    $0x10,%esp
80104cf0:	eb 81                	jmp    80104c73 <nfuaTickUpdate+0x73>
80104cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <singleProcDump>:

void
singleProcDump(int pid)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d05:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80104d0a:	83 ec 30             	sub    $0x30,%esp
80104d0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if(p->pid != pid)
80104d10:	8b 43 10             	mov    0x10(%ebx),%eax
80104d13:	39 c8                	cmp    %ecx,%eax
80104d15:	75 59                	jne    80104d70 <singleProcDump+0x70>
      continue;
    if(p->state == UNUSED)
80104d17:	8b 53 0c             	mov    0xc(%ebx),%edx
80104d1a:	85 d2                	test   %edx,%edx
80104d1c:	74 52                	je     80104d70 <singleProcDump+0x70>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d1e:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
80104d21:	b9 c6 8e 10 80       	mov    $0x80108ec6,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d26:	76 70                	jbe    80104d98 <singleProcDump+0x98>
    cprintf("%d allocated: %d   inPhysical: %d   swapped: %d   swappedOut: %d   %s %s", p->pid, p->allocatedInPhys, p->nPgsPhysical, p->nPgsSwap,p->nTotalPGout, state, p->name);
80104d28:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104d2b:	52                   	push   %edx
80104d2c:	51                   	push   %ecx
80104d2d:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104d33:	ff b3 84 00 00 00    	pushl  0x84(%ebx)
80104d39:	ff b3 80 00 00 00    	pushl  0x80(%ebx)
80104d3f:	ff b3 90 00 00 00    	pushl  0x90(%ebx)
80104d45:	50                   	push   %eax
80104d46:	68 50 8f 10 80       	push   $0x80108f50
80104d4b:	e8 10 b9 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104d50:	83 c4 20             	add    $0x20,%esp
80104d53:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104d57:	74 57                	je     80104db0 <singleProcDump+0xb0>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104d59:	83 ec 0c             	sub    $0xc,%esp
80104d5c:	68 0c 94 10 80       	push   $0x8010940c
80104d61:	e8 fa b8 ff ff       	call   80100660 <cprintf>
    return;
80104d66:	83 c4 10             	add    $0x10,%esp
  }
  cprintf("Error: ProcDump could not find pid %d\n",pid);
80104d69:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d6c:	5b                   	pop    %ebx
80104d6d:	5e                   	pop    %esi
80104d6e:	5d                   	pop    %ebp
80104d6f:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d70:	81 c3 18 03 00 00    	add    $0x318,%ebx
80104d76:	81 fb 74 93 15 80    	cmp    $0x80159374,%ebx
80104d7c:	72 92                	jb     80104d10 <singleProcDump+0x10>
  cprintf("Error: ProcDump could not find pid %d\n",pid);
80104d7e:	83 ec 08             	sub    $0x8,%esp
80104d81:	51                   	push   %ecx
80104d82:	68 9c 8f 10 80       	push   $0x80108f9c
80104d87:	e8 d4 b8 ff ff       	call   80100660 <cprintf>
80104d8c:	83 c4 10             	add    $0x10,%esp
80104d8f:	eb d8                	jmp    80104d69 <singleProcDump+0x69>
80104d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104d98:	8b 0c 95 c4 8f 10 80 	mov    -0x7fef703c(,%edx,4),%ecx
      state = "???";
80104d9f:	ba c6 8e 10 80       	mov    $0x80108ec6,%edx
80104da4:	85 c9                	test   %ecx,%ecx
80104da6:	0f 44 ca             	cmove  %edx,%ecx
80104da9:	e9 7a ff ff ff       	jmp    80104d28 <singleProcDump+0x28>
80104dae:	66 90                	xchg   %ax,%ax
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104db0:	8d 75 d0             	lea    -0x30(%ebp),%esi
80104db3:	83 ec 08             	sub    $0x8,%esp
80104db6:	56                   	push   %esi
80104db7:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104dba:	89 f3                	mov    %esi,%ebx
80104dbc:	8d 75 f8             	lea    -0x8(%ebp),%esi
80104dbf:	8b 40 0c             	mov    0xc(%eax),%eax
80104dc2:	83 c0 08             	add    $0x8,%eax
80104dc5:	50                   	push   %eax
80104dc6:	e8 85 01 00 00       	call   80104f50 <getcallerpcs>
80104dcb:	83 c4 10             	add    $0x10,%esp
80104dce:	66 90                	xchg   %ax,%ax
      for(i=0; i<10 && pc[i] != 0; i++)
80104dd0:	8b 03                	mov    (%ebx),%eax
80104dd2:	85 c0                	test   %eax,%eax
80104dd4:	74 83                	je     80104d59 <singleProcDump+0x59>
        cprintf(" %p", pc[i]);
80104dd6:	83 ec 08             	sub    $0x8,%esp
80104dd9:	83 c3 04             	add    $0x4,%ebx
80104ddc:	50                   	push   %eax
80104ddd:	68 41 88 10 80       	push   $0x80108841
80104de2:	e8 79 b8 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104de7:	83 c4 10             	add    $0x10,%esp
80104dea:	39 de                	cmp    %ebx,%esi
80104dec:	75 e2                	jne    80104dd0 <singleProcDump+0xd0>
80104dee:	e9 66 ff ff ff       	jmp    80104d59 <singleProcDump+0x59>
80104df3:	66 90                	xchg   %ax,%ax
80104df5:	66 90                	xchg   %ax,%ax
80104df7:	66 90                	xchg   %ax,%ax
80104df9:	66 90                	xchg   %ax,%ax
80104dfb:	66 90                	xchg   %ax,%ax
80104dfd:	66 90                	xchg   %ax,%ax
80104dff:	90                   	nop

80104e00 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	83 ec 0c             	sub    $0xc,%esp
80104e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e0a:	68 dc 8f 10 80       	push   $0x80108fdc
80104e0f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e12:	50                   	push   %eax
80104e13:	e8 18 01 00 00       	call   80104f30 <initlock>
  lk->name = name;
80104e18:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e1b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e21:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e24:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e2b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e31:	c9                   	leave  
80104e32:	c3                   	ret    
80104e33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e40 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	56                   	push   %esi
80104e44:	53                   	push   %ebx
80104e45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e48:	83 ec 0c             	sub    $0xc,%esp
80104e4b:	8d 73 04             	lea    0x4(%ebx),%esi
80104e4e:	56                   	push   %esi
80104e4f:	e8 1c 02 00 00       	call   80105070 <acquire>
  while (lk->locked) {
80104e54:	8b 13                	mov    (%ebx),%edx
80104e56:	83 c4 10             	add    $0x10,%esp
80104e59:	85 d2                	test   %edx,%edx
80104e5b:	74 16                	je     80104e73 <acquiresleep+0x33>
80104e5d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104e60:	83 ec 08             	sub    $0x8,%esp
80104e63:	56                   	push   %esi
80104e64:	53                   	push   %ebx
80104e65:	e8 a6 f9 ff ff       	call   80104810 <sleep>
  while (lk->locked) {
80104e6a:	8b 03                	mov    (%ebx),%eax
80104e6c:	83 c4 10             	add    $0x10,%esp
80104e6f:	85 c0                	test   %eax,%eax
80104e71:	75 ed                	jne    80104e60 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104e73:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e79:	e8 e2 f1 ff ff       	call   80104060 <myproc>
80104e7e:	8b 40 10             	mov    0x10(%eax),%eax
80104e81:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e84:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e87:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e8a:	5b                   	pop    %ebx
80104e8b:	5e                   	pop    %esi
80104e8c:	5d                   	pop    %ebp
  release(&lk->lk);
80104e8d:	e9 9e 02 00 00       	jmp    80105130 <release>
80104e92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	56                   	push   %esi
80104ea4:	53                   	push   %ebx
80104ea5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ea8:	83 ec 0c             	sub    $0xc,%esp
80104eab:	8d 73 04             	lea    0x4(%ebx),%esi
80104eae:	56                   	push   %esi
80104eaf:	e8 bc 01 00 00       	call   80105070 <acquire>
  lk->locked = 0;
80104eb4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104eba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ec1:	89 1c 24             	mov    %ebx,(%esp)
80104ec4:	e8 67 fb ff ff       	call   80104a30 <wakeup>
  release(&lk->lk);
80104ec9:	89 75 08             	mov    %esi,0x8(%ebp)
80104ecc:	83 c4 10             	add    $0x10,%esp
}
80104ecf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ed2:	5b                   	pop    %ebx
80104ed3:	5e                   	pop    %esi
80104ed4:	5d                   	pop    %ebp
  release(&lk->lk);
80104ed5:	e9 56 02 00 00       	jmp    80105130 <release>
80104eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ee0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	57                   	push   %edi
80104ee4:	56                   	push   %esi
80104ee5:	53                   	push   %ebx
80104ee6:	31 ff                	xor    %edi,%edi
80104ee8:	83 ec 18             	sub    $0x18,%esp
80104eeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104eee:	8d 73 04             	lea    0x4(%ebx),%esi
80104ef1:	56                   	push   %esi
80104ef2:	e8 79 01 00 00       	call   80105070 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ef7:	8b 03                	mov    (%ebx),%eax
80104ef9:	83 c4 10             	add    $0x10,%esp
80104efc:	85 c0                	test   %eax,%eax
80104efe:	74 13                	je     80104f13 <holdingsleep+0x33>
80104f00:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f03:	e8 58 f1 ff ff       	call   80104060 <myproc>
80104f08:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f0b:	0f 94 c0             	sete   %al
80104f0e:	0f b6 c0             	movzbl %al,%eax
80104f11:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104f13:	83 ec 0c             	sub    $0xc,%esp
80104f16:	56                   	push   %esi
80104f17:	e8 14 02 00 00       	call   80105130 <release>
  return r;
}
80104f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f1f:	89 f8                	mov    %edi,%eax
80104f21:	5b                   	pop    %ebx
80104f22:	5e                   	pop    %esi
80104f23:	5f                   	pop    %edi
80104f24:	5d                   	pop    %ebp
80104f25:	c3                   	ret    
80104f26:	66 90                	xchg   %ax,%ax
80104f28:	66 90                	xchg   %ax,%ax
80104f2a:	66 90                	xchg   %ax,%ax
80104f2c:	66 90                	xchg   %ax,%ax
80104f2e:	66 90                	xchg   %ax,%ax

80104f30 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f36:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f3f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f42:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f49:	5d                   	pop    %ebp
80104f4a:	c3                   	ret    
80104f4b:	90                   	nop
80104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f50 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f50:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f51:	31 d2                	xor    %edx,%edx
{
80104f53:	89 e5                	mov    %esp,%ebp
80104f55:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104f56:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104f59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104f5c:	83 e8 08             	sub    $0x8,%eax
80104f5f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f60:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104f66:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f6c:	77 1a                	ja     80104f88 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f6e:	8b 58 04             	mov    0x4(%eax),%ebx
80104f71:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104f74:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104f77:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f79:	83 fa 0a             	cmp    $0xa,%edx
80104f7c:	75 e2                	jne    80104f60 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f7e:	5b                   	pop    %ebx
80104f7f:	5d                   	pop    %ebp
80104f80:	c3                   	ret    
80104f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f88:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104f8b:	83 c1 28             	add    $0x28,%ecx
80104f8e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104f90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104f96:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104f99:	39 c1                	cmp    %eax,%ecx
80104f9b:	75 f3                	jne    80104f90 <getcallerpcs+0x40>
}
80104f9d:	5b                   	pop    %ebx
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    

80104fa0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	53                   	push   %ebx
80104fa4:	83 ec 04             	sub    $0x4,%esp
80104fa7:	9c                   	pushf  
80104fa8:	5b                   	pop    %ebx
  asm volatile("cli");
80104fa9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104faa:	e8 11 f0 ff ff       	call   80103fc0 <mycpu>
80104faf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104fb5:	85 c0                	test   %eax,%eax
80104fb7:	75 11                	jne    80104fca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104fb9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104fbf:	e8 fc ef ff ff       	call   80103fc0 <mycpu>
80104fc4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104fca:	e8 f1 ef ff ff       	call   80103fc0 <mycpu>
80104fcf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fd6:	83 c4 04             	add    $0x4,%esp
80104fd9:	5b                   	pop    %ebx
80104fda:	5d                   	pop    %ebp
80104fdb:	c3                   	ret    
80104fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fe0 <popcli>:

void
popcli(void)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fe6:	9c                   	pushf  
80104fe7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104fe8:	f6 c4 02             	test   $0x2,%ah
80104feb:	75 35                	jne    80105022 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104fed:	e8 ce ef ff ff       	call   80103fc0 <mycpu>
80104ff2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ff9:	78 34                	js     8010502f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104ffb:	e8 c0 ef ff ff       	call   80103fc0 <mycpu>
80105000:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105006:	85 d2                	test   %edx,%edx
80105008:	74 06                	je     80105010 <popcli+0x30>
    sti();
}
8010500a:	c9                   	leave  
8010500b:	c3                   	ret    
8010500c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105010:	e8 ab ef ff ff       	call   80103fc0 <mycpu>
80105015:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010501b:	85 c0                	test   %eax,%eax
8010501d:	74 eb                	je     8010500a <popcli+0x2a>
  asm volatile("sti");
8010501f:	fb                   	sti    
}
80105020:	c9                   	leave  
80105021:	c3                   	ret    
    panic("popcli - interruptible");
80105022:	83 ec 0c             	sub    $0xc,%esp
80105025:	68 e7 8f 10 80       	push   $0x80108fe7
8010502a:	e8 61 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
8010502f:	83 ec 0c             	sub    $0xc,%esp
80105032:	68 fe 8f 10 80       	push   $0x80108ffe
80105037:	e8 54 b3 ff ff       	call   80100390 <panic>
8010503c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105040 <holding>:
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	56                   	push   %esi
80105044:	53                   	push   %ebx
80105045:	8b 75 08             	mov    0x8(%ebp),%esi
80105048:	31 db                	xor    %ebx,%ebx
  pushcli();
8010504a:	e8 51 ff ff ff       	call   80104fa0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010504f:	8b 06                	mov    (%esi),%eax
80105051:	85 c0                	test   %eax,%eax
80105053:	74 10                	je     80105065 <holding+0x25>
80105055:	8b 5e 08             	mov    0x8(%esi),%ebx
80105058:	e8 63 ef ff ff       	call   80103fc0 <mycpu>
8010505d:	39 c3                	cmp    %eax,%ebx
8010505f:	0f 94 c3             	sete   %bl
80105062:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80105065:	e8 76 ff ff ff       	call   80104fe0 <popcli>
}
8010506a:	89 d8                	mov    %ebx,%eax
8010506c:	5b                   	pop    %ebx
8010506d:	5e                   	pop    %esi
8010506e:	5d                   	pop    %ebp
8010506f:	c3                   	ret    

80105070 <acquire>:
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	56                   	push   %esi
80105074:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105075:	e8 26 ff ff ff       	call   80104fa0 <pushcli>
  if(holding(lk))
8010507a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010507d:	83 ec 0c             	sub    $0xc,%esp
80105080:	53                   	push   %ebx
80105081:	e8 ba ff ff ff       	call   80105040 <holding>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	85 c0                	test   %eax,%eax
8010508b:	0f 85 83 00 00 00    	jne    80105114 <acquire+0xa4>
80105091:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80105093:	ba 01 00 00 00       	mov    $0x1,%edx
80105098:	eb 09                	jmp    801050a3 <acquire+0x33>
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050a0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050a3:	89 d0                	mov    %edx,%eax
801050a5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801050a8:	85 c0                	test   %eax,%eax
801050aa:	75 f4                	jne    801050a0 <acquire+0x30>
  __sync_synchronize();
801050ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801050b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050b4:	e8 07 ef ff ff       	call   80103fc0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801050b9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
801050bc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801050bf:	89 e8                	mov    %ebp,%eax
801050c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050c8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801050ce:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801050d4:	77 1a                	ja     801050f0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801050d6:	8b 48 04             	mov    0x4(%eax),%ecx
801050d9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
801050dc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801050df:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801050e1:	83 fe 0a             	cmp    $0xa,%esi
801050e4:	75 e2                	jne    801050c8 <acquire+0x58>
}
801050e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050e9:	5b                   	pop    %ebx
801050ea:	5e                   	pop    %esi
801050eb:	5d                   	pop    %ebp
801050ec:	c3                   	ret    
801050ed:	8d 76 00             	lea    0x0(%esi),%esi
801050f0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
801050f3:	83 c2 28             	add    $0x28,%edx
801050f6:	8d 76 00             	lea    0x0(%esi),%esi
801050f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80105100:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105106:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80105109:	39 d0                	cmp    %edx,%eax
8010510b:	75 f3                	jne    80105100 <acquire+0x90>
}
8010510d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105110:	5b                   	pop    %ebx
80105111:	5e                   	pop    %esi
80105112:	5d                   	pop    %ebp
80105113:	c3                   	ret    
    panic("acquire");
80105114:	83 ec 0c             	sub    $0xc,%esp
80105117:	68 05 90 10 80       	push   $0x80109005
8010511c:	e8 6f b2 ff ff       	call   80100390 <panic>
80105121:	eb 0d                	jmp    80105130 <release>
80105123:	90                   	nop
80105124:	90                   	nop
80105125:	90                   	nop
80105126:	90                   	nop
80105127:	90                   	nop
80105128:	90                   	nop
80105129:	90                   	nop
8010512a:	90                   	nop
8010512b:	90                   	nop
8010512c:	90                   	nop
8010512d:	90                   	nop
8010512e:	90                   	nop
8010512f:	90                   	nop

80105130 <release>:
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	53                   	push   %ebx
80105134:	83 ec 10             	sub    $0x10,%esp
80105137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010513a:	53                   	push   %ebx
8010513b:	e8 00 ff ff ff       	call   80105040 <holding>
80105140:	83 c4 10             	add    $0x10,%esp
80105143:	85 c0                	test   %eax,%eax
80105145:	74 22                	je     80105169 <release+0x39>
  lk->pcs[0] = 0;
80105147:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010514e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105155:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010515a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105160:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105163:	c9                   	leave  
  popcli();
80105164:	e9 77 fe ff ff       	jmp    80104fe0 <popcli>
    panic("release");
80105169:	83 ec 0c             	sub    $0xc,%esp
8010516c:	68 0d 90 10 80       	push   $0x8010900d
80105171:	e8 1a b2 ff ff       	call   80100390 <panic>
80105176:	66 90                	xchg   %ax,%ax
80105178:	66 90                	xchg   %ax,%ax
8010517a:	66 90                	xchg   %ax,%ax
8010517c:	66 90                	xchg   %ax,%ax
8010517e:	66 90                	xchg   %ax,%ax

80105180 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	53                   	push   %ebx
80105185:	8b 55 08             	mov    0x8(%ebp),%edx
80105188:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010518b:	f6 c2 03             	test   $0x3,%dl
8010518e:	75 05                	jne    80105195 <memset+0x15>
80105190:	f6 c1 03             	test   $0x3,%cl
80105193:	74 13                	je     801051a8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80105195:	89 d7                	mov    %edx,%edi
80105197:	8b 45 0c             	mov    0xc(%ebp),%eax
8010519a:	fc                   	cld    
8010519b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010519d:	5b                   	pop    %ebx
8010519e:	89 d0                	mov    %edx,%eax
801051a0:	5f                   	pop    %edi
801051a1:	5d                   	pop    %ebp
801051a2:	c3                   	ret    
801051a3:	90                   	nop
801051a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801051a8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051ac:	c1 e9 02             	shr    $0x2,%ecx
801051af:	89 f8                	mov    %edi,%eax
801051b1:	89 fb                	mov    %edi,%ebx
801051b3:	c1 e0 18             	shl    $0x18,%eax
801051b6:	c1 e3 10             	shl    $0x10,%ebx
801051b9:	09 d8                	or     %ebx,%eax
801051bb:	09 f8                	or     %edi,%eax
801051bd:	c1 e7 08             	shl    $0x8,%edi
801051c0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801051c2:	89 d7                	mov    %edx,%edi
801051c4:	fc                   	cld    
801051c5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801051c7:	5b                   	pop    %ebx
801051c8:	89 d0                	mov    %edx,%eax
801051ca:	5f                   	pop    %edi
801051cb:	5d                   	pop    %ebp
801051cc:	c3                   	ret    
801051cd:	8d 76 00             	lea    0x0(%esi),%esi

801051d0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	53                   	push   %ebx
801051d6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801051d9:	8b 75 08             	mov    0x8(%ebp),%esi
801051dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801051df:	85 db                	test   %ebx,%ebx
801051e1:	74 29                	je     8010520c <memcmp+0x3c>
    if(*s1 != *s2)
801051e3:	0f b6 16             	movzbl (%esi),%edx
801051e6:	0f b6 0f             	movzbl (%edi),%ecx
801051e9:	38 d1                	cmp    %dl,%cl
801051eb:	75 2b                	jne    80105218 <memcmp+0x48>
801051ed:	b8 01 00 00 00       	mov    $0x1,%eax
801051f2:	eb 14                	jmp    80105208 <memcmp+0x38>
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051f8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
801051fc:	83 c0 01             	add    $0x1,%eax
801051ff:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80105204:	38 ca                	cmp    %cl,%dl
80105206:	75 10                	jne    80105218 <memcmp+0x48>
  while(n-- > 0){
80105208:	39 d8                	cmp    %ebx,%eax
8010520a:	75 ec                	jne    801051f8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010520c:	5b                   	pop    %ebx
  return 0;
8010520d:	31 c0                	xor    %eax,%eax
}
8010520f:	5e                   	pop    %esi
80105210:	5f                   	pop    %edi
80105211:	5d                   	pop    %ebp
80105212:	c3                   	ret    
80105213:	90                   	nop
80105214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80105218:	0f b6 c2             	movzbl %dl,%eax
}
8010521b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010521c:	29 c8                	sub    %ecx,%eax
}
8010521e:	5e                   	pop    %esi
8010521f:	5f                   	pop    %edi
80105220:	5d                   	pop    %ebp
80105221:	c3                   	ret    
80105222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105230 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	56                   	push   %esi
80105234:	53                   	push   %ebx
80105235:	8b 45 08             	mov    0x8(%ebp),%eax
80105238:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010523b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010523e:	39 c3                	cmp    %eax,%ebx
80105240:	73 26                	jae    80105268 <memmove+0x38>
80105242:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105245:	39 c8                	cmp    %ecx,%eax
80105247:	73 1f                	jae    80105268 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105249:	85 f6                	test   %esi,%esi
8010524b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010524e:	74 0f                	je     8010525f <memmove+0x2f>
      *--d = *--s;
80105250:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105254:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105257:	83 ea 01             	sub    $0x1,%edx
8010525a:	83 fa ff             	cmp    $0xffffffff,%edx
8010525d:	75 f1                	jne    80105250 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010525f:	5b                   	pop    %ebx
80105260:	5e                   	pop    %esi
80105261:	5d                   	pop    %ebp
80105262:	c3                   	ret    
80105263:	90                   	nop
80105264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105268:	31 d2                	xor    %edx,%edx
8010526a:	85 f6                	test   %esi,%esi
8010526c:	74 f1                	je     8010525f <memmove+0x2f>
8010526e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105270:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105274:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105277:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010527a:	39 d6                	cmp    %edx,%esi
8010527c:	75 f2                	jne    80105270 <memmove+0x40>
}
8010527e:	5b                   	pop    %ebx
8010527f:	5e                   	pop    %esi
80105280:	5d                   	pop    %ebp
80105281:	c3                   	ret    
80105282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105293:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105294:	eb 9a                	jmp    80105230 <memmove>
80105296:	8d 76 00             	lea    0x0(%esi),%esi
80105299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052a0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	57                   	push   %edi
801052a4:	56                   	push   %esi
801052a5:	8b 7d 10             	mov    0x10(%ebp),%edi
801052a8:	53                   	push   %ebx
801052a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
801052af:	85 ff                	test   %edi,%edi
801052b1:	74 2f                	je     801052e2 <strncmp+0x42>
801052b3:	0f b6 01             	movzbl (%ecx),%eax
801052b6:	0f b6 1e             	movzbl (%esi),%ebx
801052b9:	84 c0                	test   %al,%al
801052bb:	74 37                	je     801052f4 <strncmp+0x54>
801052bd:	38 c3                	cmp    %al,%bl
801052bf:	75 33                	jne    801052f4 <strncmp+0x54>
801052c1:	01 f7                	add    %esi,%edi
801052c3:	eb 13                	jmp    801052d8 <strncmp+0x38>
801052c5:	8d 76 00             	lea    0x0(%esi),%esi
801052c8:	0f b6 01             	movzbl (%ecx),%eax
801052cb:	84 c0                	test   %al,%al
801052cd:	74 21                	je     801052f0 <strncmp+0x50>
801052cf:	0f b6 1a             	movzbl (%edx),%ebx
801052d2:	89 d6                	mov    %edx,%esi
801052d4:	38 d8                	cmp    %bl,%al
801052d6:	75 1c                	jne    801052f4 <strncmp+0x54>
    n--, p++, q++;
801052d8:	8d 56 01             	lea    0x1(%esi),%edx
801052db:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801052de:	39 fa                	cmp    %edi,%edx
801052e0:	75 e6                	jne    801052c8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801052e2:	5b                   	pop    %ebx
    return 0;
801052e3:	31 c0                	xor    %eax,%eax
}
801052e5:	5e                   	pop    %esi
801052e6:	5f                   	pop    %edi
801052e7:	5d                   	pop    %ebp
801052e8:	c3                   	ret    
801052e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052f0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801052f4:	29 d8                	sub    %ebx,%eax
}
801052f6:	5b                   	pop    %ebx
801052f7:	5e                   	pop    %esi
801052f8:	5f                   	pop    %edi
801052f9:	5d                   	pop    %ebp
801052fa:	c3                   	ret    
801052fb:	90                   	nop
801052fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105300 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	56                   	push   %esi
80105304:	53                   	push   %ebx
80105305:	8b 45 08             	mov    0x8(%ebp),%eax
80105308:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010530b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010530e:	89 c2                	mov    %eax,%edx
80105310:	eb 19                	jmp    8010532b <strncpy+0x2b>
80105312:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105318:	83 c3 01             	add    $0x1,%ebx
8010531b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010531f:	83 c2 01             	add    $0x1,%edx
80105322:	84 c9                	test   %cl,%cl
80105324:	88 4a ff             	mov    %cl,-0x1(%edx)
80105327:	74 09                	je     80105332 <strncpy+0x32>
80105329:	89 f1                	mov    %esi,%ecx
8010532b:	85 c9                	test   %ecx,%ecx
8010532d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105330:	7f e6                	jg     80105318 <strncpy+0x18>
    ;
  while(n-- > 0)
80105332:	31 c9                	xor    %ecx,%ecx
80105334:	85 f6                	test   %esi,%esi
80105336:	7e 17                	jle    8010534f <strncpy+0x4f>
80105338:	90                   	nop
80105339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105340:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105344:	89 f3                	mov    %esi,%ebx
80105346:	83 c1 01             	add    $0x1,%ecx
80105349:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010534b:	85 db                	test   %ebx,%ebx
8010534d:	7f f1                	jg     80105340 <strncpy+0x40>
  return os;
}
8010534f:	5b                   	pop    %ebx
80105350:	5e                   	pop    %esi
80105351:	5d                   	pop    %ebp
80105352:	c3                   	ret    
80105353:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	56                   	push   %esi
80105364:	53                   	push   %ebx
80105365:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105368:	8b 45 08             	mov    0x8(%ebp),%eax
8010536b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010536e:	85 c9                	test   %ecx,%ecx
80105370:	7e 26                	jle    80105398 <safestrcpy+0x38>
80105372:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105376:	89 c1                	mov    %eax,%ecx
80105378:	eb 17                	jmp    80105391 <safestrcpy+0x31>
8010537a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105380:	83 c2 01             	add    $0x1,%edx
80105383:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105387:	83 c1 01             	add    $0x1,%ecx
8010538a:	84 db                	test   %bl,%bl
8010538c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010538f:	74 04                	je     80105395 <safestrcpy+0x35>
80105391:	39 f2                	cmp    %esi,%edx
80105393:	75 eb                	jne    80105380 <safestrcpy+0x20>
    ;
  *s = 0;
80105395:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105398:	5b                   	pop    %ebx
80105399:	5e                   	pop    %esi
8010539a:	5d                   	pop    %ebp
8010539b:	c3                   	ret    
8010539c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053a0 <strlen>:

int
strlen(const char *s)
{
801053a0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801053a1:	31 c0                	xor    %eax,%eax
{
801053a3:	89 e5                	mov    %esp,%ebp
801053a5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801053a8:	80 3a 00             	cmpb   $0x0,(%edx)
801053ab:	74 0c                	je     801053b9 <strlen+0x19>
801053ad:	8d 76 00             	lea    0x0(%esi),%esi
801053b0:	83 c0 01             	add    $0x1,%eax
801053b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801053b7:	75 f7                	jne    801053b0 <strlen+0x10>
    ;
  return n;
}
801053b9:	5d                   	pop    %ebp
801053ba:	c3                   	ret    

801053bb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801053bb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801053bf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801053c3:	55                   	push   %ebp
  pushl %ebx
801053c4:	53                   	push   %ebx
  pushl %esi
801053c5:	56                   	push   %esi
  pushl %edi
801053c6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801053c7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801053c9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801053cb:	5f                   	pop    %edi
  popl %esi
801053cc:	5e                   	pop    %esi
  popl %ebx
801053cd:	5b                   	pop    %ebx
  popl %ebp
801053ce:	5d                   	pop    %ebp
  ret
801053cf:	c3                   	ret    

801053d0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	53                   	push   %ebx
801053d4:	83 ec 04             	sub    $0x4,%esp
801053d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053da:	e8 81 ec ff ff       	call   80104060 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053df:	8b 00                	mov    (%eax),%eax
801053e1:	39 d8                	cmp    %ebx,%eax
801053e3:	76 1b                	jbe    80105400 <fetchint+0x30>
801053e5:	8d 53 04             	lea    0x4(%ebx),%edx
801053e8:	39 d0                	cmp    %edx,%eax
801053ea:	72 14                	jb     80105400 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801053ec:	8b 45 0c             	mov    0xc(%ebp),%eax
801053ef:	8b 13                	mov    (%ebx),%edx
801053f1:	89 10                	mov    %edx,(%eax)
  return 0;
801053f3:	31 c0                	xor    %eax,%eax
}
801053f5:	83 c4 04             	add    $0x4,%esp
801053f8:	5b                   	pop    %ebx
801053f9:	5d                   	pop    %ebp
801053fa:	c3                   	ret    
801053fb:	90                   	nop
801053fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105405:	eb ee                	jmp    801053f5 <fetchint+0x25>
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	53                   	push   %ebx
80105414:	83 ec 04             	sub    $0x4,%esp
80105417:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010541a:	e8 41 ec ff ff       	call   80104060 <myproc>

  if(addr >= curproc->sz)
8010541f:	39 18                	cmp    %ebx,(%eax)
80105421:	76 29                	jbe    8010544c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105423:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105426:	89 da                	mov    %ebx,%edx
80105428:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010542a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010542c:	39 c3                	cmp    %eax,%ebx
8010542e:	73 1c                	jae    8010544c <fetchstr+0x3c>
    if(*s == 0)
80105430:	80 3b 00             	cmpb   $0x0,(%ebx)
80105433:	75 10                	jne    80105445 <fetchstr+0x35>
80105435:	eb 39                	jmp    80105470 <fetchstr+0x60>
80105437:	89 f6                	mov    %esi,%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105440:	80 3a 00             	cmpb   $0x0,(%edx)
80105443:	74 1b                	je     80105460 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105445:	83 c2 01             	add    $0x1,%edx
80105448:	39 d0                	cmp    %edx,%eax
8010544a:	77 f4                	ja     80105440 <fetchstr+0x30>
    return -1;
8010544c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105451:	83 c4 04             	add    $0x4,%esp
80105454:	5b                   	pop    %ebx
80105455:	5d                   	pop    %ebp
80105456:	c3                   	ret    
80105457:	89 f6                	mov    %esi,%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105460:	83 c4 04             	add    $0x4,%esp
80105463:	89 d0                	mov    %edx,%eax
80105465:	29 d8                	sub    %ebx,%eax
80105467:	5b                   	pop    %ebx
80105468:	5d                   	pop    %ebp
80105469:	c3                   	ret    
8010546a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105470:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105472:	eb dd                	jmp    80105451 <fetchstr+0x41>
80105474:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010547a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105480 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105485:	e8 d6 eb ff ff       	call   80104060 <myproc>
8010548a:	8b 40 18             	mov    0x18(%eax),%eax
8010548d:	8b 55 08             	mov    0x8(%ebp),%edx
80105490:	8b 40 44             	mov    0x44(%eax),%eax
80105493:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105496:	e8 c5 eb ff ff       	call   80104060 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010549b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010549d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054a0:	39 c6                	cmp    %eax,%esi
801054a2:	73 1c                	jae    801054c0 <argint+0x40>
801054a4:	8d 53 08             	lea    0x8(%ebx),%edx
801054a7:	39 d0                	cmp    %edx,%eax
801054a9:	72 15                	jb     801054c0 <argint+0x40>
  *ip = *(int*)(addr);
801054ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801054ae:	8b 53 04             	mov    0x4(%ebx),%edx
801054b1:	89 10                	mov    %edx,(%eax)
  return 0;
801054b3:	31 c0                	xor    %eax,%eax
}
801054b5:	5b                   	pop    %ebx
801054b6:	5e                   	pop    %esi
801054b7:	5d                   	pop    %ebp
801054b8:	c3                   	ret    
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801054c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054c5:	eb ee                	jmp    801054b5 <argint+0x35>
801054c7:	89 f6                	mov    %esi,%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054d0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	56                   	push   %esi
801054d4:	53                   	push   %ebx
801054d5:	83 ec 10             	sub    $0x10,%esp
801054d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801054db:	e8 80 eb ff ff       	call   80104060 <myproc>
801054e0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801054e2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054e5:	83 ec 08             	sub    $0x8,%esp
801054e8:	50                   	push   %eax
801054e9:	ff 75 08             	pushl  0x8(%ebp)
801054ec:	e8 8f ff ff ff       	call   80105480 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801054f1:	83 c4 10             	add    $0x10,%esp
801054f4:	85 c0                	test   %eax,%eax
801054f6:	78 28                	js     80105520 <argptr+0x50>
801054f8:	85 db                	test   %ebx,%ebx
801054fa:	78 24                	js     80105520 <argptr+0x50>
801054fc:	8b 16                	mov    (%esi),%edx
801054fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105501:	39 c2                	cmp    %eax,%edx
80105503:	76 1b                	jbe    80105520 <argptr+0x50>
80105505:	01 c3                	add    %eax,%ebx
80105507:	39 da                	cmp    %ebx,%edx
80105509:	72 15                	jb     80105520 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010550b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010550e:	89 02                	mov    %eax,(%edx)
  return 0;
80105510:	31 c0                	xor    %eax,%eax
}
80105512:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105515:	5b                   	pop    %ebx
80105516:	5e                   	pop    %esi
80105517:	5d                   	pop    %ebp
80105518:	c3                   	ret    
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105525:	eb eb                	jmp    80105512 <argptr+0x42>
80105527:	89 f6                	mov    %esi,%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105536:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105539:	50                   	push   %eax
8010553a:	ff 75 08             	pushl  0x8(%ebp)
8010553d:	e8 3e ff ff ff       	call   80105480 <argint>
80105542:	83 c4 10             	add    $0x10,%esp
80105545:	85 c0                	test   %eax,%eax
80105547:	78 17                	js     80105560 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105549:	83 ec 08             	sub    $0x8,%esp
8010554c:	ff 75 0c             	pushl  0xc(%ebp)
8010554f:	ff 75 f4             	pushl  -0xc(%ebp)
80105552:	e8 b9 fe ff ff       	call   80105410 <fetchstr>
80105557:	83 c4 10             	add    $0x10,%esp
}
8010555a:	c9                   	leave  
8010555b:	c3                   	ret    
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105560:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105565:	c9                   	leave  
80105566:	c3                   	ret    
80105567:	89 f6                	mov    %esi,%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <syscall>:
[SYS_printProcDump] sys_printProcDump,
};

void
syscall(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	53                   	push   %ebx
80105574:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105577:	e8 e4 ea ff ff       	call   80104060 <myproc>
8010557c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010557e:	8b 40 18             	mov    0x18(%eax),%eax
80105581:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105584:	8d 50 ff             	lea    -0x1(%eax),%edx
80105587:	83 fa 16             	cmp    $0x16,%edx
8010558a:	77 1c                	ja     801055a8 <syscall+0x38>
8010558c:	8b 14 85 40 90 10 80 	mov    -0x7fef6fc0(,%eax,4),%edx
80105593:	85 d2                	test   %edx,%edx
80105595:	74 11                	je     801055a8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105597:	ff d2                	call   *%edx
80105599:	8b 53 18             	mov    0x18(%ebx),%edx
8010559c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010559f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055a2:	c9                   	leave  
801055a3:	c3                   	ret    
801055a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801055a8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801055a9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801055ac:	50                   	push   %eax
801055ad:	ff 73 10             	pushl  0x10(%ebx)
801055b0:	68 15 90 10 80       	push   $0x80109015
801055b5:	e8 a6 b0 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801055ba:	8b 43 18             	mov    0x18(%ebx),%eax
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801055c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055ca:	c9                   	leave  
801055cb:	c3                   	ret    
801055cc:	66 90                	xchg   %ax,%ax
801055ce:	66 90                	xchg   %ax,%ax

801055d0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
801055d5:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801055d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801055da:	89 d6                	mov    %edx,%esi
801055dc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801055df:	50                   	push   %eax
801055e0:	6a 00                	push   $0x0
801055e2:	e8 99 fe ff ff       	call   80105480 <argint>
801055e7:	83 c4 10             	add    $0x10,%esp
801055ea:	85 c0                	test   %eax,%eax
801055ec:	78 2a                	js     80105618 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801055ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055f2:	77 24                	ja     80105618 <argfd.constprop.0+0x48>
801055f4:	e8 67 ea ff ff       	call   80104060 <myproc>
801055f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055fc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105600:	85 c0                	test   %eax,%eax
80105602:	74 14                	je     80105618 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80105604:	85 db                	test   %ebx,%ebx
80105606:	74 02                	je     8010560a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105608:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
8010560a:	89 06                	mov    %eax,(%esi)
  return 0;
8010560c:	31 c0                	xor    %eax,%eax
}
8010560e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105611:	5b                   	pop    %ebx
80105612:	5e                   	pop    %esi
80105613:	5d                   	pop    %ebp
80105614:	c3                   	ret    
80105615:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105618:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561d:	eb ef                	jmp    8010560e <argfd.constprop.0+0x3e>
8010561f:	90                   	nop

80105620 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105620:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105621:	31 c0                	xor    %eax,%eax
{
80105623:	89 e5                	mov    %esp,%ebp
80105625:	56                   	push   %esi
80105626:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105627:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010562a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010562d:	e8 9e ff ff ff       	call   801055d0 <argfd.constprop.0>
80105632:	85 c0                	test   %eax,%eax
80105634:	78 42                	js     80105678 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105636:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105639:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010563b:	e8 20 ea ff ff       	call   80104060 <myproc>
80105640:	eb 0e                	jmp    80105650 <sys_dup+0x30>
80105642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105648:	83 c3 01             	add    $0x1,%ebx
8010564b:	83 fb 10             	cmp    $0x10,%ebx
8010564e:	74 28                	je     80105678 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105650:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105654:	85 d2                	test   %edx,%edx
80105656:	75 f0                	jne    80105648 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105658:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010565c:	83 ec 0c             	sub    $0xc,%esp
8010565f:	ff 75 f4             	pushl  -0xc(%ebp)
80105662:	e8 99 b9 ff ff       	call   80101000 <filedup>
  return fd;
80105667:	83 c4 10             	add    $0x10,%esp
}
8010566a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010566d:	89 d8                	mov    %ebx,%eax
8010566f:	5b                   	pop    %ebx
80105670:	5e                   	pop    %esi
80105671:	5d                   	pop    %ebp
80105672:	c3                   	ret    
80105673:	90                   	nop
80105674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105678:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010567b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105680:	89 d8                	mov    %ebx,%eax
80105682:	5b                   	pop    %ebx
80105683:	5e                   	pop    %esi
80105684:	5d                   	pop    %ebp
80105685:	c3                   	ret    
80105686:	8d 76 00             	lea    0x0(%esi),%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105690 <sys_read>:

int
sys_read(void)
{
80105690:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105691:	31 c0                	xor    %eax,%eax
{
80105693:	89 e5                	mov    %esp,%ebp
80105695:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105698:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010569b:	e8 30 ff ff ff       	call   801055d0 <argfd.constprop.0>
801056a0:	85 c0                	test   %eax,%eax
801056a2:	78 4c                	js     801056f0 <sys_read+0x60>
801056a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056a7:	83 ec 08             	sub    $0x8,%esp
801056aa:	50                   	push   %eax
801056ab:	6a 02                	push   $0x2
801056ad:	e8 ce fd ff ff       	call   80105480 <argint>
801056b2:	83 c4 10             	add    $0x10,%esp
801056b5:	85 c0                	test   %eax,%eax
801056b7:	78 37                	js     801056f0 <sys_read+0x60>
801056b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056bc:	83 ec 04             	sub    $0x4,%esp
801056bf:	ff 75 f0             	pushl  -0x10(%ebp)
801056c2:	50                   	push   %eax
801056c3:	6a 01                	push   $0x1
801056c5:	e8 06 fe ff ff       	call   801054d0 <argptr>
801056ca:	83 c4 10             	add    $0x10,%esp
801056cd:	85 c0                	test   %eax,%eax
801056cf:	78 1f                	js     801056f0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801056d1:	83 ec 04             	sub    $0x4,%esp
801056d4:	ff 75 f0             	pushl  -0x10(%ebp)
801056d7:	ff 75 f4             	pushl  -0xc(%ebp)
801056da:	ff 75 ec             	pushl  -0x14(%ebp)
801056dd:	e8 8e ba ff ff       	call   80101170 <fileread>
801056e2:	83 c4 10             	add    $0x10,%esp
}
801056e5:	c9                   	leave  
801056e6:	c3                   	ret    
801056e7:	89 f6                	mov    %esi,%esi
801056e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801056f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056f5:	c9                   	leave  
801056f6:	c3                   	ret    
801056f7:	89 f6                	mov    %esi,%esi
801056f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105700 <sys_write>:

int
sys_write(void)
{
80105700:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105701:	31 c0                	xor    %eax,%eax
{
80105703:	89 e5                	mov    %esp,%ebp
80105705:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105708:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010570b:	e8 c0 fe ff ff       	call   801055d0 <argfd.constprop.0>
80105710:	85 c0                	test   %eax,%eax
80105712:	78 4c                	js     80105760 <sys_write+0x60>
80105714:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105717:	83 ec 08             	sub    $0x8,%esp
8010571a:	50                   	push   %eax
8010571b:	6a 02                	push   $0x2
8010571d:	e8 5e fd ff ff       	call   80105480 <argint>
80105722:	83 c4 10             	add    $0x10,%esp
80105725:	85 c0                	test   %eax,%eax
80105727:	78 37                	js     80105760 <sys_write+0x60>
80105729:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010572c:	83 ec 04             	sub    $0x4,%esp
8010572f:	ff 75 f0             	pushl  -0x10(%ebp)
80105732:	50                   	push   %eax
80105733:	6a 01                	push   $0x1
80105735:	e8 96 fd ff ff       	call   801054d0 <argptr>
8010573a:	83 c4 10             	add    $0x10,%esp
8010573d:	85 c0                	test   %eax,%eax
8010573f:	78 1f                	js     80105760 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105741:	83 ec 04             	sub    $0x4,%esp
80105744:	ff 75 f0             	pushl  -0x10(%ebp)
80105747:	ff 75 f4             	pushl  -0xc(%ebp)
8010574a:	ff 75 ec             	pushl  -0x14(%ebp)
8010574d:	e8 ae ba ff ff       	call   80101200 <filewrite>
80105752:	83 c4 10             	add    $0x10,%esp
}
80105755:	c9                   	leave  
80105756:	c3                   	ret    
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105760:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105765:	c9                   	leave  
80105766:	c3                   	ret    
80105767:	89 f6                	mov    %esi,%esi
80105769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105770 <sys_close>:

int
sys_close(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105776:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105779:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010577c:	e8 4f fe ff ff       	call   801055d0 <argfd.constprop.0>
80105781:	85 c0                	test   %eax,%eax
80105783:	78 2b                	js     801057b0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105785:	e8 d6 e8 ff ff       	call   80104060 <myproc>
8010578a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010578d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105790:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105797:	00 
  fileclose(f);
80105798:	ff 75 f4             	pushl  -0xc(%ebp)
8010579b:	e8 b0 b8 ff ff       	call   80101050 <fileclose>
  return 0;
801057a0:	83 c4 10             	add    $0x10,%esp
801057a3:	31 c0                	xor    %eax,%eax
}
801057a5:	c9                   	leave  
801057a6:	c3                   	ret    
801057a7:	89 f6                	mov    %esi,%esi
801057a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801057b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057b5:	c9                   	leave  
801057b6:	c3                   	ret    
801057b7:	89 f6                	mov    %esi,%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <sys_fstat>:

int
sys_fstat(void)
{
801057c0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057c1:	31 c0                	xor    %eax,%eax
{
801057c3:	89 e5                	mov    %esp,%ebp
801057c5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801057c8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801057cb:	e8 00 fe ff ff       	call   801055d0 <argfd.constprop.0>
801057d0:	85 c0                	test   %eax,%eax
801057d2:	78 2c                	js     80105800 <sys_fstat+0x40>
801057d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d7:	83 ec 04             	sub    $0x4,%esp
801057da:	6a 14                	push   $0x14
801057dc:	50                   	push   %eax
801057dd:	6a 01                	push   $0x1
801057df:	e8 ec fc ff ff       	call   801054d0 <argptr>
801057e4:	83 c4 10             	add    $0x10,%esp
801057e7:	85 c0                	test   %eax,%eax
801057e9:	78 15                	js     80105800 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801057eb:	83 ec 08             	sub    $0x8,%esp
801057ee:	ff 75 f4             	pushl  -0xc(%ebp)
801057f1:	ff 75 f0             	pushl  -0x10(%ebp)
801057f4:	e8 27 b9 ff ff       	call   80101120 <filestat>
801057f9:	83 c4 10             	add    $0x10,%esp
}
801057fc:	c9                   	leave  
801057fd:	c3                   	ret    
801057fe:	66 90                	xchg   %ax,%ax
    return -1;
80105800:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105805:	c9                   	leave  
80105806:	c3                   	ret    
80105807:	89 f6                	mov    %esi,%esi
80105809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105810 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	57                   	push   %edi
80105814:	56                   	push   %esi
80105815:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105816:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105819:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010581c:	50                   	push   %eax
8010581d:	6a 00                	push   $0x0
8010581f:	e8 0c fd ff ff       	call   80105530 <argstr>
80105824:	83 c4 10             	add    $0x10,%esp
80105827:	85 c0                	test   %eax,%eax
80105829:	0f 88 fb 00 00 00    	js     8010592a <sys_link+0x11a>
8010582f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105832:	83 ec 08             	sub    $0x8,%esp
80105835:	50                   	push   %eax
80105836:	6a 01                	push   $0x1
80105838:	e8 f3 fc ff ff       	call   80105530 <argstr>
8010583d:	83 c4 10             	add    $0x10,%esp
80105840:	85 c0                	test   %eax,%eax
80105842:	0f 88 e2 00 00 00    	js     8010592a <sys_link+0x11a>
    return -1;

  begin_op();
80105848:	e8 23 db ff ff       	call   80103370 <begin_op>
  if((ip = namei(old)) == 0){
8010584d:	83 ec 0c             	sub    $0xc,%esp
80105850:	ff 75 d4             	pushl  -0x2c(%ebp)
80105853:	e8 98 c8 ff ff       	call   801020f0 <namei>
80105858:	83 c4 10             	add    $0x10,%esp
8010585b:	85 c0                	test   %eax,%eax
8010585d:	89 c3                	mov    %eax,%ebx
8010585f:	0f 84 ea 00 00 00    	je     8010594f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105865:	83 ec 0c             	sub    $0xc,%esp
80105868:	50                   	push   %eax
80105869:	e8 22 c0 ff ff       	call   80101890 <ilock>
  if(ip->type == T_DIR){
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105876:	0f 84 bb 00 00 00    	je     80105937 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010587c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105881:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105884:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105887:	53                   	push   %ebx
80105888:	e8 53 bf ff ff       	call   801017e0 <iupdate>
  iunlock(ip);
8010588d:	89 1c 24             	mov    %ebx,(%esp)
80105890:	e8 db c0 ff ff       	call   80101970 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105895:	58                   	pop    %eax
80105896:	5a                   	pop    %edx
80105897:	57                   	push   %edi
80105898:	ff 75 d0             	pushl  -0x30(%ebp)
8010589b:	e8 70 c8 ff ff       	call   80102110 <nameiparent>
801058a0:	83 c4 10             	add    $0x10,%esp
801058a3:	85 c0                	test   %eax,%eax
801058a5:	89 c6                	mov    %eax,%esi
801058a7:	74 5b                	je     80105904 <sys_link+0xf4>
    goto bad;
  ilock(dp);
801058a9:	83 ec 0c             	sub    $0xc,%esp
801058ac:	50                   	push   %eax
801058ad:	e8 de bf ff ff       	call   80101890 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	8b 03                	mov    (%ebx),%eax
801058b7:	39 06                	cmp    %eax,(%esi)
801058b9:	75 3d                	jne    801058f8 <sys_link+0xe8>
801058bb:	83 ec 04             	sub    $0x4,%esp
801058be:	ff 73 04             	pushl  0x4(%ebx)
801058c1:	57                   	push   %edi
801058c2:	56                   	push   %esi
801058c3:	e8 68 c7 ff ff       	call   80102030 <dirlink>
801058c8:	83 c4 10             	add    $0x10,%esp
801058cb:	85 c0                	test   %eax,%eax
801058cd:	78 29                	js     801058f8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801058cf:	83 ec 0c             	sub    $0xc,%esp
801058d2:	56                   	push   %esi
801058d3:	e8 48 c2 ff ff       	call   80101b20 <iunlockput>
  iput(ip);
801058d8:	89 1c 24             	mov    %ebx,(%esp)
801058db:	e8 e0 c0 ff ff       	call   801019c0 <iput>

  end_op();
801058e0:	e8 fb da ff ff       	call   801033e0 <end_op>

  return 0;
801058e5:	83 c4 10             	add    $0x10,%esp
801058e8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801058ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058ed:	5b                   	pop    %ebx
801058ee:	5e                   	pop    %esi
801058ef:	5f                   	pop    %edi
801058f0:	5d                   	pop    %ebp
801058f1:	c3                   	ret    
801058f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	56                   	push   %esi
801058fc:	e8 1f c2 ff ff       	call   80101b20 <iunlockput>
    goto bad;
80105901:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105904:	83 ec 0c             	sub    $0xc,%esp
80105907:	53                   	push   %ebx
80105908:	e8 83 bf ff ff       	call   80101890 <ilock>
  ip->nlink--;
8010590d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105912:	89 1c 24             	mov    %ebx,(%esp)
80105915:	e8 c6 be ff ff       	call   801017e0 <iupdate>
  iunlockput(ip);
8010591a:	89 1c 24             	mov    %ebx,(%esp)
8010591d:	e8 fe c1 ff ff       	call   80101b20 <iunlockput>
  end_op();
80105922:	e8 b9 da ff ff       	call   801033e0 <end_op>
  return -1;
80105927:	83 c4 10             	add    $0x10,%esp
}
8010592a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010592d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105932:	5b                   	pop    %ebx
80105933:	5e                   	pop    %esi
80105934:	5f                   	pop    %edi
80105935:	5d                   	pop    %ebp
80105936:	c3                   	ret    
    iunlockput(ip);
80105937:	83 ec 0c             	sub    $0xc,%esp
8010593a:	53                   	push   %ebx
8010593b:	e8 e0 c1 ff ff       	call   80101b20 <iunlockput>
    end_op();
80105940:	e8 9b da ff ff       	call   801033e0 <end_op>
    return -1;
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	eb 9b                	jmp    801058ea <sys_link+0xda>
    end_op();
8010594f:	e8 8c da ff ff       	call   801033e0 <end_op>
    return -1;
80105954:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105959:	eb 8f                	jmp    801058ea <sys_link+0xda>
8010595b:	90                   	nop
8010595c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105960 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	57                   	push   %edi
80105964:	56                   	push   %esi
80105965:	53                   	push   %ebx
80105966:	83 ec 1c             	sub    $0x1c,%esp
80105969:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010596c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105970:	76 3e                	jbe    801059b0 <isdirempty+0x50>
80105972:	bb 20 00 00 00       	mov    $0x20,%ebx
80105977:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010597a:	eb 0c                	jmp    80105988 <isdirempty+0x28>
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105980:	83 c3 10             	add    $0x10,%ebx
80105983:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105986:	73 28                	jae    801059b0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105988:	6a 10                	push   $0x10
8010598a:	53                   	push   %ebx
8010598b:	57                   	push   %edi
8010598c:	56                   	push   %esi
8010598d:	e8 de c1 ff ff       	call   80101b70 <readi>
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	83 f8 10             	cmp    $0x10,%eax
80105998:	75 23                	jne    801059bd <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010599a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010599f:	74 df                	je     80105980 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
801059a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801059a4:	31 c0                	xor    %eax,%eax
}
801059a6:	5b                   	pop    %ebx
801059a7:	5e                   	pop    %esi
801059a8:	5f                   	pop    %edi
801059a9:	5d                   	pop    %ebp
801059aa:	c3                   	ret    
801059ab:	90                   	nop
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801059b3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801059b8:	5b                   	pop    %ebx
801059b9:	5e                   	pop    %esi
801059ba:	5f                   	pop    %edi
801059bb:	5d                   	pop    %ebp
801059bc:	c3                   	ret    
      panic("isdirempty: readi");
801059bd:	83 ec 0c             	sub    $0xc,%esp
801059c0:	68 a0 90 10 80       	push   $0x801090a0
801059c5:	e8 c6 a9 ff ff       	call   80100390 <panic>
801059ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801059d0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	57                   	push   %edi
801059d4:	56                   	push   %esi
801059d5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801059d6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801059d9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801059dc:	50                   	push   %eax
801059dd:	6a 00                	push   $0x0
801059df:	e8 4c fb ff ff       	call   80105530 <argstr>
801059e4:	83 c4 10             	add    $0x10,%esp
801059e7:	85 c0                	test   %eax,%eax
801059e9:	0f 88 51 01 00 00    	js     80105b40 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801059ef:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801059f2:	e8 79 d9 ff ff       	call   80103370 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801059f7:	83 ec 08             	sub    $0x8,%esp
801059fa:	53                   	push   %ebx
801059fb:	ff 75 c0             	pushl  -0x40(%ebp)
801059fe:	e8 0d c7 ff ff       	call   80102110 <nameiparent>
80105a03:	83 c4 10             	add    $0x10,%esp
80105a06:	85 c0                	test   %eax,%eax
80105a08:	89 c6                	mov    %eax,%esi
80105a0a:	0f 84 37 01 00 00    	je     80105b47 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105a10:	83 ec 0c             	sub    $0xc,%esp
80105a13:	50                   	push   %eax
80105a14:	e8 77 be ff ff       	call   80101890 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105a19:	58                   	pop    %eax
80105a1a:	5a                   	pop    %edx
80105a1b:	68 7d 89 10 80       	push   $0x8010897d
80105a20:	53                   	push   %ebx
80105a21:	e8 7a c3 ff ff       	call   80101da0 <namecmp>
80105a26:	83 c4 10             	add    $0x10,%esp
80105a29:	85 c0                	test   %eax,%eax
80105a2b:	0f 84 d7 00 00 00    	je     80105b08 <sys_unlink+0x138>
80105a31:	83 ec 08             	sub    $0x8,%esp
80105a34:	68 7c 89 10 80       	push   $0x8010897c
80105a39:	53                   	push   %ebx
80105a3a:	e8 61 c3 ff ff       	call   80101da0 <namecmp>
80105a3f:	83 c4 10             	add    $0x10,%esp
80105a42:	85 c0                	test   %eax,%eax
80105a44:	0f 84 be 00 00 00    	je     80105b08 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105a4a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105a4d:	83 ec 04             	sub    $0x4,%esp
80105a50:	50                   	push   %eax
80105a51:	53                   	push   %ebx
80105a52:	56                   	push   %esi
80105a53:	e8 68 c3 ff ff       	call   80101dc0 <dirlookup>
80105a58:	83 c4 10             	add    $0x10,%esp
80105a5b:	85 c0                	test   %eax,%eax
80105a5d:	89 c3                	mov    %eax,%ebx
80105a5f:	0f 84 a3 00 00 00    	je     80105b08 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105a65:	83 ec 0c             	sub    $0xc,%esp
80105a68:	50                   	push   %eax
80105a69:	e8 22 be ff ff       	call   80101890 <ilock>

  if(ip->nlink < 1)
80105a6e:	83 c4 10             	add    $0x10,%esp
80105a71:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105a76:	0f 8e e4 00 00 00    	jle    80105b60 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105a7c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a81:	74 65                	je     80105ae8 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105a83:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105a86:	83 ec 04             	sub    $0x4,%esp
80105a89:	6a 10                	push   $0x10
80105a8b:	6a 00                	push   $0x0
80105a8d:	57                   	push   %edi
80105a8e:	e8 ed f6 ff ff       	call   80105180 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a93:	6a 10                	push   $0x10
80105a95:	ff 75 c4             	pushl  -0x3c(%ebp)
80105a98:	57                   	push   %edi
80105a99:	56                   	push   %esi
80105a9a:	e8 d1 c1 ff ff       	call   80101c70 <writei>
80105a9f:	83 c4 20             	add    $0x20,%esp
80105aa2:	83 f8 10             	cmp    $0x10,%eax
80105aa5:	0f 85 a8 00 00 00    	jne    80105b53 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105aab:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ab0:	74 6e                	je     80105b20 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105ab2:	83 ec 0c             	sub    $0xc,%esp
80105ab5:	56                   	push   %esi
80105ab6:	e8 65 c0 ff ff       	call   80101b20 <iunlockput>

  ip->nlink--;
80105abb:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ac0:	89 1c 24             	mov    %ebx,(%esp)
80105ac3:	e8 18 bd ff ff       	call   801017e0 <iupdate>
  iunlockput(ip);
80105ac8:	89 1c 24             	mov    %ebx,(%esp)
80105acb:	e8 50 c0 ff ff       	call   80101b20 <iunlockput>

  end_op();
80105ad0:	e8 0b d9 ff ff       	call   801033e0 <end_op>

  return 0;
80105ad5:	83 c4 10             	add    $0x10,%esp
80105ad8:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105ada:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105add:	5b                   	pop    %ebx
80105ade:	5e                   	pop    %esi
80105adf:	5f                   	pop    %edi
80105ae0:	5d                   	pop    %ebp
80105ae1:	c3                   	ret    
80105ae2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
80105ae8:	83 ec 0c             	sub    $0xc,%esp
80105aeb:	53                   	push   %ebx
80105aec:	e8 6f fe ff ff       	call   80105960 <isdirempty>
80105af1:	83 c4 10             	add    $0x10,%esp
80105af4:	85 c0                	test   %eax,%eax
80105af6:	75 8b                	jne    80105a83 <sys_unlink+0xb3>
    iunlockput(ip);
80105af8:	83 ec 0c             	sub    $0xc,%esp
80105afb:	53                   	push   %ebx
80105afc:	e8 1f c0 ff ff       	call   80101b20 <iunlockput>
    goto bad;
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105b08:	83 ec 0c             	sub    $0xc,%esp
80105b0b:	56                   	push   %esi
80105b0c:	e8 0f c0 ff ff       	call   80101b20 <iunlockput>
  end_op();
80105b11:	e8 ca d8 ff ff       	call   801033e0 <end_op>
  return -1;
80105b16:	83 c4 10             	add    $0x10,%esp
80105b19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1e:	eb ba                	jmp    80105ada <sys_unlink+0x10a>
    dp->nlink--;
80105b20:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105b25:	83 ec 0c             	sub    $0xc,%esp
80105b28:	56                   	push   %esi
80105b29:	e8 b2 bc ff ff       	call   801017e0 <iupdate>
80105b2e:	83 c4 10             	add    $0x10,%esp
80105b31:	e9 7c ff ff ff       	jmp    80105ab2 <sys_unlink+0xe2>
80105b36:	8d 76 00             	lea    0x0(%esi),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b45:	eb 93                	jmp    80105ada <sys_unlink+0x10a>
    end_op();
80105b47:	e8 94 d8 ff ff       	call   801033e0 <end_op>
    return -1;
80105b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b51:	eb 87                	jmp    80105ada <sys_unlink+0x10a>
    panic("unlink: writei");
80105b53:	83 ec 0c             	sub    $0xc,%esp
80105b56:	68 91 89 10 80       	push   $0x80108991
80105b5b:	e8 30 a8 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105b60:	83 ec 0c             	sub    $0xc,%esp
80105b63:	68 7f 89 10 80       	push   $0x8010897f
80105b68:	e8 23 a8 ff ff       	call   80100390 <panic>
80105b6d:	8d 76 00             	lea    0x0(%esi),%esi

80105b70 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	57                   	push   %edi
80105b74:	56                   	push   %esi
80105b75:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105b76:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105b79:	83 ec 34             	sub    $0x34,%esp
80105b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105b7f:	8b 55 10             	mov    0x10(%ebp),%edx
80105b82:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105b85:	56                   	push   %esi
80105b86:	ff 75 08             	pushl  0x8(%ebp)
{
80105b89:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105b8c:	89 55 d0             	mov    %edx,-0x30(%ebp)
80105b8f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105b92:	e8 79 c5 ff ff       	call   80102110 <nameiparent>
80105b97:	83 c4 10             	add    $0x10,%esp
80105b9a:	85 c0                	test   %eax,%eax
80105b9c:	0f 84 4e 01 00 00    	je     80105cf0 <create+0x180>
    return 0;
  ilock(dp);
80105ba2:	83 ec 0c             	sub    $0xc,%esp
80105ba5:	89 c3                	mov    %eax,%ebx
80105ba7:	50                   	push   %eax
80105ba8:	e8 e3 bc ff ff       	call   80101890 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105bad:	83 c4 0c             	add    $0xc,%esp
80105bb0:	6a 00                	push   $0x0
80105bb2:	56                   	push   %esi
80105bb3:	53                   	push   %ebx
80105bb4:	e8 07 c2 ff ff       	call   80101dc0 <dirlookup>
80105bb9:	83 c4 10             	add    $0x10,%esp
80105bbc:	85 c0                	test   %eax,%eax
80105bbe:	89 c7                	mov    %eax,%edi
80105bc0:	74 3e                	je     80105c00 <create+0x90>
    iunlockput(dp);
80105bc2:	83 ec 0c             	sub    $0xc,%esp
80105bc5:	53                   	push   %ebx
80105bc6:	e8 55 bf ff ff       	call   80101b20 <iunlockput>
    ilock(ip);
80105bcb:	89 3c 24             	mov    %edi,(%esp)
80105bce:	e8 bd bc ff ff       	call   80101890 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105bd3:	83 c4 10             	add    $0x10,%esp
80105bd6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105bdb:	0f 85 9f 00 00 00    	jne    80105c80 <create+0x110>
80105be1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105be6:	0f 85 94 00 00 00    	jne    80105c80 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105bec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bef:	89 f8                	mov    %edi,%eax
80105bf1:	5b                   	pop    %ebx
80105bf2:	5e                   	pop    %esi
80105bf3:	5f                   	pop    %edi
80105bf4:	5d                   	pop    %ebp
80105bf5:	c3                   	ret    
80105bf6:	8d 76 00             	lea    0x0(%esi),%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
80105c00:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105c04:	83 ec 08             	sub    $0x8,%esp
80105c07:	50                   	push   %eax
80105c08:	ff 33                	pushl  (%ebx)
80105c0a:	e8 11 bb ff ff       	call   80101720 <ialloc>
80105c0f:	83 c4 10             	add    $0x10,%esp
80105c12:	85 c0                	test   %eax,%eax
80105c14:	89 c7                	mov    %eax,%edi
80105c16:	0f 84 e8 00 00 00    	je     80105d04 <create+0x194>
  ilock(ip);
80105c1c:	83 ec 0c             	sub    $0xc,%esp
80105c1f:	50                   	push   %eax
80105c20:	e8 6b bc ff ff       	call   80101890 <ilock>
  ip->major = major;
80105c25:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105c29:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80105c2d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105c31:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105c35:	b8 01 00 00 00       	mov    $0x1,%eax
80105c3a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80105c3e:	89 3c 24             	mov    %edi,(%esp)
80105c41:	e8 9a bb ff ff       	call   801017e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105c4e:	74 50                	je     80105ca0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105c50:	83 ec 04             	sub    $0x4,%esp
80105c53:	ff 77 04             	pushl  0x4(%edi)
80105c56:	56                   	push   %esi
80105c57:	53                   	push   %ebx
80105c58:	e8 d3 c3 ff ff       	call   80102030 <dirlink>
80105c5d:	83 c4 10             	add    $0x10,%esp
80105c60:	85 c0                	test   %eax,%eax
80105c62:	0f 88 8f 00 00 00    	js     80105cf7 <create+0x187>
  iunlockput(dp);
80105c68:	83 ec 0c             	sub    $0xc,%esp
80105c6b:	53                   	push   %ebx
80105c6c:	e8 af be ff ff       	call   80101b20 <iunlockput>
  return ip;
80105c71:	83 c4 10             	add    $0x10,%esp
}
80105c74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c77:	89 f8                	mov    %edi,%eax
80105c79:	5b                   	pop    %ebx
80105c7a:	5e                   	pop    %esi
80105c7b:	5f                   	pop    %edi
80105c7c:	5d                   	pop    %ebp
80105c7d:	c3                   	ret    
80105c7e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105c80:	83 ec 0c             	sub    $0xc,%esp
80105c83:	57                   	push   %edi
    return 0;
80105c84:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105c86:	e8 95 be ff ff       	call   80101b20 <iunlockput>
    return 0;
80105c8b:	83 c4 10             	add    $0x10,%esp
}
80105c8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c91:	89 f8                	mov    %edi,%eax
80105c93:	5b                   	pop    %ebx
80105c94:	5e                   	pop    %esi
80105c95:	5f                   	pop    %edi
80105c96:	5d                   	pop    %ebp
80105c97:	c3                   	ret    
80105c98:	90                   	nop
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105ca0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105ca5:	83 ec 0c             	sub    $0xc,%esp
80105ca8:	53                   	push   %ebx
80105ca9:	e8 32 bb ff ff       	call   801017e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105cae:	83 c4 0c             	add    $0xc,%esp
80105cb1:	ff 77 04             	pushl  0x4(%edi)
80105cb4:	68 7d 89 10 80       	push   $0x8010897d
80105cb9:	57                   	push   %edi
80105cba:	e8 71 c3 ff ff       	call   80102030 <dirlink>
80105cbf:	83 c4 10             	add    $0x10,%esp
80105cc2:	85 c0                	test   %eax,%eax
80105cc4:	78 1c                	js     80105ce2 <create+0x172>
80105cc6:	83 ec 04             	sub    $0x4,%esp
80105cc9:	ff 73 04             	pushl  0x4(%ebx)
80105ccc:	68 7c 89 10 80       	push   $0x8010897c
80105cd1:	57                   	push   %edi
80105cd2:	e8 59 c3 ff ff       	call   80102030 <dirlink>
80105cd7:	83 c4 10             	add    $0x10,%esp
80105cda:	85 c0                	test   %eax,%eax
80105cdc:	0f 89 6e ff ff ff    	jns    80105c50 <create+0xe0>
      panic("create dots");
80105ce2:	83 ec 0c             	sub    $0xc,%esp
80105ce5:	68 c1 90 10 80       	push   $0x801090c1
80105cea:	e8 a1 a6 ff ff       	call   80100390 <panic>
80105cef:	90                   	nop
    return 0;
80105cf0:	31 ff                	xor    %edi,%edi
80105cf2:	e9 f5 fe ff ff       	jmp    80105bec <create+0x7c>
    panic("create: dirlink");
80105cf7:	83 ec 0c             	sub    $0xc,%esp
80105cfa:	68 cd 90 10 80       	push   $0x801090cd
80105cff:	e8 8c a6 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105d04:	83 ec 0c             	sub    $0xc,%esp
80105d07:	68 b2 90 10 80       	push   $0x801090b2
80105d0c:	e8 7f a6 ff ff       	call   80100390 <panic>
80105d11:	eb 0d                	jmp    80105d20 <sys_open>
80105d13:	90                   	nop
80105d14:	90                   	nop
80105d15:	90                   	nop
80105d16:	90                   	nop
80105d17:	90                   	nop
80105d18:	90                   	nop
80105d19:	90                   	nop
80105d1a:	90                   	nop
80105d1b:	90                   	nop
80105d1c:	90                   	nop
80105d1d:	90                   	nop
80105d1e:	90                   	nop
80105d1f:	90                   	nop

80105d20 <sys_open>:

int
sys_open(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	57                   	push   %edi
80105d24:	56                   	push   %esi
80105d25:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d26:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105d29:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d2c:	50                   	push   %eax
80105d2d:	6a 00                	push   $0x0
80105d2f:	e8 fc f7 ff ff       	call   80105530 <argstr>
80105d34:	83 c4 10             	add    $0x10,%esp
80105d37:	85 c0                	test   %eax,%eax
80105d39:	0f 88 1d 01 00 00    	js     80105e5c <sys_open+0x13c>
80105d3f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d42:	83 ec 08             	sub    $0x8,%esp
80105d45:	50                   	push   %eax
80105d46:	6a 01                	push   $0x1
80105d48:	e8 33 f7 ff ff       	call   80105480 <argint>
80105d4d:	83 c4 10             	add    $0x10,%esp
80105d50:	85 c0                	test   %eax,%eax
80105d52:	0f 88 04 01 00 00    	js     80105e5c <sys_open+0x13c>
    return -1;

  begin_op();
80105d58:	e8 13 d6 ff ff       	call   80103370 <begin_op>

  if(omode & O_CREATE){
80105d5d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d61:	0f 85 a9 00 00 00    	jne    80105e10 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d67:	83 ec 0c             	sub    $0xc,%esp
80105d6a:	ff 75 e0             	pushl  -0x20(%ebp)
80105d6d:	e8 7e c3 ff ff       	call   801020f0 <namei>
80105d72:	83 c4 10             	add    $0x10,%esp
80105d75:	85 c0                	test   %eax,%eax
80105d77:	89 c6                	mov    %eax,%esi
80105d79:	0f 84 ac 00 00 00    	je     80105e2b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
80105d7f:	83 ec 0c             	sub    $0xc,%esp
80105d82:	50                   	push   %eax
80105d83:	e8 08 bb ff ff       	call   80101890 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d88:	83 c4 10             	add    $0x10,%esp
80105d8b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d90:	0f 84 aa 00 00 00    	je     80105e40 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d96:	e8 f5 b1 ff ff       	call   80100f90 <filealloc>
80105d9b:	85 c0                	test   %eax,%eax
80105d9d:	89 c7                	mov    %eax,%edi
80105d9f:	0f 84 a6 00 00 00    	je     80105e4b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105da5:	e8 b6 e2 ff ff       	call   80104060 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105daa:	31 db                	xor    %ebx,%ebx
80105dac:	eb 0e                	jmp    80105dbc <sys_open+0x9c>
80105dae:	66 90                	xchg   %ax,%ax
80105db0:	83 c3 01             	add    $0x1,%ebx
80105db3:	83 fb 10             	cmp    $0x10,%ebx
80105db6:	0f 84 ac 00 00 00    	je     80105e68 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105dbc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105dc0:	85 d2                	test   %edx,%edx
80105dc2:	75 ec                	jne    80105db0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105dc4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105dc7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105dcb:	56                   	push   %esi
80105dcc:	e8 9f bb ff ff       	call   80101970 <iunlock>
  end_op();
80105dd1:	e8 0a d6 ff ff       	call   801033e0 <end_op>

  f->type = FD_INODE;
80105dd6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105ddc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ddf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105de2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105de5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105dec:	89 d0                	mov    %edx,%eax
80105dee:	f7 d0                	not    %eax
80105df0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105df3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105df6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105df9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105dfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e00:	89 d8                	mov    %ebx,%eax
80105e02:	5b                   	pop    %ebx
80105e03:	5e                   	pop    %esi
80105e04:	5f                   	pop    %edi
80105e05:	5d                   	pop    %ebp
80105e06:	c3                   	ret    
80105e07:	89 f6                	mov    %esi,%esi
80105e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105e10:	6a 00                	push   $0x0
80105e12:	6a 00                	push   $0x0
80105e14:	6a 02                	push   $0x2
80105e16:	ff 75 e0             	pushl  -0x20(%ebp)
80105e19:	e8 52 fd ff ff       	call   80105b70 <create>
    if(ip == 0){
80105e1e:	83 c4 10             	add    $0x10,%esp
80105e21:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105e23:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105e25:	0f 85 6b ff ff ff    	jne    80105d96 <sys_open+0x76>
      end_op();
80105e2b:	e8 b0 d5 ff ff       	call   801033e0 <end_op>
      return -1;
80105e30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e35:	eb c6                	jmp    80105dfd <sys_open+0xdd>
80105e37:	89 f6                	mov    %esi,%esi
80105e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e40:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e43:	85 c9                	test   %ecx,%ecx
80105e45:	0f 84 4b ff ff ff    	je     80105d96 <sys_open+0x76>
    iunlockput(ip);
80105e4b:	83 ec 0c             	sub    $0xc,%esp
80105e4e:	56                   	push   %esi
80105e4f:	e8 cc bc ff ff       	call   80101b20 <iunlockput>
    end_op();
80105e54:	e8 87 d5 ff ff       	call   801033e0 <end_op>
    return -1;
80105e59:	83 c4 10             	add    $0x10,%esp
80105e5c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105e61:	eb 9a                	jmp    80105dfd <sys_open+0xdd>
80105e63:	90                   	nop
80105e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105e68:	83 ec 0c             	sub    $0xc,%esp
80105e6b:	57                   	push   %edi
80105e6c:	e8 df b1 ff ff       	call   80101050 <fileclose>
80105e71:	83 c4 10             	add    $0x10,%esp
80105e74:	eb d5                	jmp    80105e4b <sys_open+0x12b>
80105e76:	8d 76 00             	lea    0x0(%esi),%esi
80105e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e80 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e86:	e8 e5 d4 ff ff       	call   80103370 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e8e:	83 ec 08             	sub    $0x8,%esp
80105e91:	50                   	push   %eax
80105e92:	6a 00                	push   $0x0
80105e94:	e8 97 f6 ff ff       	call   80105530 <argstr>
80105e99:	83 c4 10             	add    $0x10,%esp
80105e9c:	85 c0                	test   %eax,%eax
80105e9e:	78 30                	js     80105ed0 <sys_mkdir+0x50>
80105ea0:	6a 00                	push   $0x0
80105ea2:	6a 00                	push   $0x0
80105ea4:	6a 01                	push   $0x1
80105ea6:	ff 75 f4             	pushl  -0xc(%ebp)
80105ea9:	e8 c2 fc ff ff       	call   80105b70 <create>
80105eae:	83 c4 10             	add    $0x10,%esp
80105eb1:	85 c0                	test   %eax,%eax
80105eb3:	74 1b                	je     80105ed0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105eb5:	83 ec 0c             	sub    $0xc,%esp
80105eb8:	50                   	push   %eax
80105eb9:	e8 62 bc ff ff       	call   80101b20 <iunlockput>
  end_op();
80105ebe:	e8 1d d5 ff ff       	call   801033e0 <end_op>
  return 0;
80105ec3:	83 c4 10             	add    $0x10,%esp
80105ec6:	31 c0                	xor    %eax,%eax
}
80105ec8:	c9                   	leave  
80105ec9:	c3                   	ret    
80105eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105ed0:	e8 0b d5 ff ff       	call   801033e0 <end_op>
    return -1;
80105ed5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105eda:	c9                   	leave  
80105edb:	c3                   	ret    
80105edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ee0 <sys_mknod>:

int
sys_mknod(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105ee6:	e8 85 d4 ff ff       	call   80103370 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105eeb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105eee:	83 ec 08             	sub    $0x8,%esp
80105ef1:	50                   	push   %eax
80105ef2:	6a 00                	push   $0x0
80105ef4:	e8 37 f6 ff ff       	call   80105530 <argstr>
80105ef9:	83 c4 10             	add    $0x10,%esp
80105efc:	85 c0                	test   %eax,%eax
80105efe:	78 60                	js     80105f60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105f00:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f03:	83 ec 08             	sub    $0x8,%esp
80105f06:	50                   	push   %eax
80105f07:	6a 01                	push   $0x1
80105f09:	e8 72 f5 ff ff       	call   80105480 <argint>
  if((argstr(0, &path)) < 0 ||
80105f0e:	83 c4 10             	add    $0x10,%esp
80105f11:	85 c0                	test   %eax,%eax
80105f13:	78 4b                	js     80105f60 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105f15:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f18:	83 ec 08             	sub    $0x8,%esp
80105f1b:	50                   	push   %eax
80105f1c:	6a 02                	push   $0x2
80105f1e:	e8 5d f5 ff ff       	call   80105480 <argint>
     argint(1, &major) < 0 ||
80105f23:	83 c4 10             	add    $0x10,%esp
80105f26:	85 c0                	test   %eax,%eax
80105f28:	78 36                	js     80105f60 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f2a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105f2e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105f2f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105f33:	50                   	push   %eax
80105f34:	6a 03                	push   $0x3
80105f36:	ff 75 ec             	pushl  -0x14(%ebp)
80105f39:	e8 32 fc ff ff       	call   80105b70 <create>
80105f3e:	83 c4 10             	add    $0x10,%esp
80105f41:	85 c0                	test   %eax,%eax
80105f43:	74 1b                	je     80105f60 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f45:	83 ec 0c             	sub    $0xc,%esp
80105f48:	50                   	push   %eax
80105f49:	e8 d2 bb ff ff       	call   80101b20 <iunlockput>
  end_op();
80105f4e:	e8 8d d4 ff ff       	call   801033e0 <end_op>
  return 0;
80105f53:	83 c4 10             	add    $0x10,%esp
80105f56:	31 c0                	xor    %eax,%eax
}
80105f58:	c9                   	leave  
80105f59:	c3                   	ret    
80105f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105f60:	e8 7b d4 ff ff       	call   801033e0 <end_op>
    return -1;
80105f65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f6a:	c9                   	leave  
80105f6b:	c3                   	ret    
80105f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f70 <sys_chdir>:

int
sys_chdir(void)
{
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	56                   	push   %esi
80105f74:	53                   	push   %ebx
80105f75:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f78:	e8 e3 e0 ff ff       	call   80104060 <myproc>
80105f7d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f7f:	e8 ec d3 ff ff       	call   80103370 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f84:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f87:	83 ec 08             	sub    $0x8,%esp
80105f8a:	50                   	push   %eax
80105f8b:	6a 00                	push   $0x0
80105f8d:	e8 9e f5 ff ff       	call   80105530 <argstr>
80105f92:	83 c4 10             	add    $0x10,%esp
80105f95:	85 c0                	test   %eax,%eax
80105f97:	78 77                	js     80106010 <sys_chdir+0xa0>
80105f99:	83 ec 0c             	sub    $0xc,%esp
80105f9c:	ff 75 f4             	pushl  -0xc(%ebp)
80105f9f:	e8 4c c1 ff ff       	call   801020f0 <namei>
80105fa4:	83 c4 10             	add    $0x10,%esp
80105fa7:	85 c0                	test   %eax,%eax
80105fa9:	89 c3                	mov    %eax,%ebx
80105fab:	74 63                	je     80106010 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105fad:	83 ec 0c             	sub    $0xc,%esp
80105fb0:	50                   	push   %eax
80105fb1:	e8 da b8 ff ff       	call   80101890 <ilock>
  if(ip->type != T_DIR){
80105fb6:	83 c4 10             	add    $0x10,%esp
80105fb9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105fbe:	75 30                	jne    80105ff0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	53                   	push   %ebx
80105fc4:	e8 a7 b9 ff ff       	call   80101970 <iunlock>
  iput(curproc->cwd);
80105fc9:	58                   	pop    %eax
80105fca:	ff 76 68             	pushl  0x68(%esi)
80105fcd:	e8 ee b9 ff ff       	call   801019c0 <iput>
  end_op();
80105fd2:	e8 09 d4 ff ff       	call   801033e0 <end_op>
  curproc->cwd = ip;
80105fd7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105fda:	83 c4 10             	add    $0x10,%esp
80105fdd:	31 c0                	xor    %eax,%eax
}
80105fdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fe2:	5b                   	pop    %ebx
80105fe3:	5e                   	pop    %esi
80105fe4:	5d                   	pop    %ebp
80105fe5:	c3                   	ret    
80105fe6:	8d 76 00             	lea    0x0(%esi),%esi
80105fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105ff0:	83 ec 0c             	sub    $0xc,%esp
80105ff3:	53                   	push   %ebx
80105ff4:	e8 27 bb ff ff       	call   80101b20 <iunlockput>
    end_op();
80105ff9:	e8 e2 d3 ff ff       	call   801033e0 <end_op>
    return -1;
80105ffe:	83 c4 10             	add    $0x10,%esp
80106001:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106006:	eb d7                	jmp    80105fdf <sys_chdir+0x6f>
80106008:	90                   	nop
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80106010:	e8 cb d3 ff ff       	call   801033e0 <end_op>
    return -1;
80106015:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010601a:	eb c3                	jmp    80105fdf <sys_chdir+0x6f>
8010601c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106020 <sys_exec>:

int
sys_exec(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	57                   	push   %edi
80106024:	56                   	push   %esi
80106025:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106026:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010602c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106032:	50                   	push   %eax
80106033:	6a 00                	push   $0x0
80106035:	e8 f6 f4 ff ff       	call   80105530 <argstr>
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	85 c0                	test   %eax,%eax
8010603f:	0f 88 87 00 00 00    	js     801060cc <sys_exec+0xac>
80106045:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010604b:	83 ec 08             	sub    $0x8,%esp
8010604e:	50                   	push   %eax
8010604f:	6a 01                	push   $0x1
80106051:	e8 2a f4 ff ff       	call   80105480 <argint>
80106056:	83 c4 10             	add    $0x10,%esp
80106059:	85 c0                	test   %eax,%eax
8010605b:	78 6f                	js     801060cc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010605d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106063:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80106066:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106068:	68 80 00 00 00       	push   $0x80
8010606d:	6a 00                	push   $0x0
8010606f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106075:	50                   	push   %eax
80106076:	e8 05 f1 ff ff       	call   80105180 <memset>
8010607b:	83 c4 10             	add    $0x10,%esp
8010607e:	eb 2c                	jmp    801060ac <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80106080:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106086:	85 c0                	test   %eax,%eax
80106088:	74 56                	je     801060e0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010608a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106090:	83 ec 08             	sub    $0x8,%esp
80106093:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80106096:	52                   	push   %edx
80106097:	50                   	push   %eax
80106098:	e8 73 f3 ff ff       	call   80105410 <fetchstr>
8010609d:	83 c4 10             	add    $0x10,%esp
801060a0:	85 c0                	test   %eax,%eax
801060a2:	78 28                	js     801060cc <sys_exec+0xac>
  for(i=0;; i++){
801060a4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801060a7:	83 fb 20             	cmp    $0x20,%ebx
801060aa:	74 20                	je     801060cc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801060ac:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801060b2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801060b9:	83 ec 08             	sub    $0x8,%esp
801060bc:	57                   	push   %edi
801060bd:	01 f0                	add    %esi,%eax
801060bf:	50                   	push   %eax
801060c0:	e8 0b f3 ff ff       	call   801053d0 <fetchint>
801060c5:	83 c4 10             	add    $0x10,%esp
801060c8:	85 c0                	test   %eax,%eax
801060ca:	79 b4                	jns    80106080 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801060cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801060cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060d4:	5b                   	pop    %ebx
801060d5:	5e                   	pop    %esi
801060d6:	5f                   	pop    %edi
801060d7:	5d                   	pop    %ebp
801060d8:	c3                   	ret    
801060d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801060e0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801060e6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
801060e9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060f0:	00 00 00 00 
  return exec(path, argv);
801060f4:	50                   	push   %eax
801060f5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801060fb:	e8 10 a9 ff ff       	call   80100a10 <exec>
80106100:	83 c4 10             	add    $0x10,%esp
}
80106103:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106106:	5b                   	pop    %ebx
80106107:	5e                   	pop    %esi
80106108:	5f                   	pop    %edi
80106109:	5d                   	pop    %ebp
8010610a:	c3                   	ret    
8010610b:	90                   	nop
8010610c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106110 <sys_pipe>:

int
sys_pipe(void)
{
80106110:	55                   	push   %ebp
80106111:	89 e5                	mov    %esp,%ebp
80106113:	57                   	push   %edi
80106114:	56                   	push   %esi
80106115:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106116:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106119:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010611c:	6a 08                	push   $0x8
8010611e:	50                   	push   %eax
8010611f:	6a 00                	push   $0x0
80106121:	e8 aa f3 ff ff       	call   801054d0 <argptr>
80106126:	83 c4 10             	add    $0x10,%esp
80106129:	85 c0                	test   %eax,%eax
8010612b:	0f 88 ae 00 00 00    	js     801061df <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106131:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106134:	83 ec 08             	sub    $0x8,%esp
80106137:	50                   	push   %eax
80106138:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010613b:	50                   	push   %eax
8010613c:	e8 cf d8 ff ff       	call   80103a10 <pipealloc>
80106141:	83 c4 10             	add    $0x10,%esp
80106144:	85 c0                	test   %eax,%eax
80106146:	0f 88 93 00 00 00    	js     801061df <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010614c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010614f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106151:	e8 0a df ff ff       	call   80104060 <myproc>
80106156:	eb 10                	jmp    80106168 <sys_pipe+0x58>
80106158:	90                   	nop
80106159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106160:	83 c3 01             	add    $0x1,%ebx
80106163:	83 fb 10             	cmp    $0x10,%ebx
80106166:	74 60                	je     801061c8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80106168:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010616c:	85 f6                	test   %esi,%esi
8010616e:	75 f0                	jne    80106160 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106170:	8d 73 08             	lea    0x8(%ebx),%esi
80106173:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106177:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010617a:	e8 e1 de ff ff       	call   80104060 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010617f:	31 d2                	xor    %edx,%edx
80106181:	eb 0d                	jmp    80106190 <sys_pipe+0x80>
80106183:	90                   	nop
80106184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106188:	83 c2 01             	add    $0x1,%edx
8010618b:	83 fa 10             	cmp    $0x10,%edx
8010618e:	74 28                	je     801061b8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80106190:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106194:	85 c9                	test   %ecx,%ecx
80106196:	75 f0                	jne    80106188 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80106198:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010619c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010619f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061a4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061a7:	31 c0                	xor    %eax,%eax
}
801061a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061ac:	5b                   	pop    %ebx
801061ad:	5e                   	pop    %esi
801061ae:	5f                   	pop    %edi
801061af:	5d                   	pop    %ebp
801061b0:	c3                   	ret    
801061b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801061b8:	e8 a3 de ff ff       	call   80104060 <myproc>
801061bd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801061c4:	00 
801061c5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
801061c8:	83 ec 0c             	sub    $0xc,%esp
801061cb:	ff 75 e0             	pushl  -0x20(%ebp)
801061ce:	e8 7d ae ff ff       	call   80101050 <fileclose>
    fileclose(wf);
801061d3:	58                   	pop    %eax
801061d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801061d7:	e8 74 ae ff ff       	call   80101050 <fileclose>
    return -1;
801061dc:	83 c4 10             	add    $0x10,%esp
801061df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061e4:	eb c3                	jmp    801061a9 <sys_pipe+0x99>
801061e6:	66 90                	xchg   %ax,%ax
801061e8:	66 90                	xchg   %ax,%ax
801061ea:	66 90                	xchg   %ax,%ax
801061ec:	66 90                	xchg   %ax,%ax
801061ee:	66 90                	xchg   %ax,%ax

801061f0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801061f0:	55                   	push   %ebp
801061f1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801061f3:	5d                   	pop    %ebp
  return fork();
801061f4:	e9 27 e0 ff ff       	jmp    80104220 <fork>
801061f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106200 <sys_exit>:

int
sys_exit(void)
{
80106200:	55                   	push   %ebp
80106201:	89 e5                	mov    %esp,%ebp
80106203:	83 ec 08             	sub    $0x8,%esp
  exit();
80106206:	e8 55 e4 ff ff       	call   80104660 <exit>
  return 0;  // not reached
}
8010620b:	31 c0                	xor    %eax,%eax
8010620d:	c9                   	leave  
8010620e:	c3                   	ret    
8010620f:	90                   	nop

80106210 <sys_wait>:

int
sys_wait(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106213:	5d                   	pop    %ebp
  return wait();
80106214:	e9 b7 e6 ff ff       	jmp    801048d0 <wait>
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106220 <sys_kill>:

int
sys_kill(void)
{
80106220:	55                   	push   %ebp
80106221:	89 e5                	mov    %esp,%ebp
80106223:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106226:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106229:	50                   	push   %eax
8010622a:	6a 00                	push   $0x0
8010622c:	e8 4f f2 ff ff       	call   80105480 <argint>
80106231:	83 c4 10             	add    $0x10,%esp
80106234:	85 c0                	test   %eax,%eax
80106236:	78 18                	js     80106250 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106238:	83 ec 0c             	sub    $0xc,%esp
8010623b:	ff 75 f4             	pushl  -0xc(%ebp)
8010623e:	e8 4d e8 ff ff       	call   80104a90 <kill>
80106243:	83 c4 10             	add    $0x10,%esp
}
80106246:	c9                   	leave  
80106247:	c3                   	ret    
80106248:	90                   	nop
80106249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106255:	c9                   	leave  
80106256:	c3                   	ret    
80106257:	89 f6                	mov    %esi,%esi
80106259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106260 <sys_getpid>:

int
sys_getpid(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106266:	e8 f5 dd ff ff       	call   80104060 <myproc>
8010626b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010626e:	c9                   	leave  
8010626f:	c3                   	ret    

80106270 <sys_sbrk>:

int
sys_sbrk(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
80106274:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106277:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010627a:	50                   	push   %eax
8010627b:	6a 00                	push   $0x0
8010627d:	e8 fe f1 ff ff       	call   80105480 <argint>
80106282:	83 c4 10             	add    $0x10,%esp
80106285:	85 c0                	test   %eax,%eax
80106287:	78 27                	js     801062b0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106289:	e8 d2 dd ff ff       	call   80104060 <myproc>
  if(growproc(n) < 0)
8010628e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106291:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106293:	ff 75 f4             	pushl  -0xc(%ebp)
80106296:	e8 05 df ff ff       	call   801041a0 <growproc>
8010629b:	83 c4 10             	add    $0x10,%esp
8010629e:	85 c0                	test   %eax,%eax
801062a0:	78 0e                	js     801062b0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801062a2:	89 d8                	mov    %ebx,%eax
801062a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062a7:	c9                   	leave  
801062a8:	c3                   	ret    
801062a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801062b0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062b5:	eb eb                	jmp    801062a2 <sys_sbrk+0x32>
801062b7:	89 f6                	mov    %esi,%esi
801062b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062c0 <sys_sleep>:

int
sys_sleep(void)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801062c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062ca:	50                   	push   %eax
801062cb:	6a 00                	push   $0x0
801062cd:	e8 ae f1 ff ff       	call   80105480 <argint>
801062d2:	83 c4 10             	add    $0x10,%esp
801062d5:	85 c0                	test   %eax,%eax
801062d7:	0f 88 8a 00 00 00    	js     80106367 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801062dd:	83 ec 0c             	sub    $0xc,%esp
801062e0:	68 80 93 15 80       	push   $0x80159380
801062e5:	e8 86 ed ff ff       	call   80105070 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801062ed:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801062f0:	8b 1d c0 9b 15 80    	mov    0x80159bc0,%ebx
  while(ticks - ticks0 < n){
801062f6:	85 d2                	test   %edx,%edx
801062f8:	75 27                	jne    80106321 <sys_sleep+0x61>
801062fa:	eb 54                	jmp    80106350 <sys_sleep+0x90>
801062fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106300:	83 ec 08             	sub    $0x8,%esp
80106303:	68 80 93 15 80       	push   $0x80159380
80106308:	68 c0 9b 15 80       	push   $0x80159bc0
8010630d:	e8 fe e4 ff ff       	call   80104810 <sleep>
  while(ticks - ticks0 < n){
80106312:	a1 c0 9b 15 80       	mov    0x80159bc0,%eax
80106317:	83 c4 10             	add    $0x10,%esp
8010631a:	29 d8                	sub    %ebx,%eax
8010631c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010631f:	73 2f                	jae    80106350 <sys_sleep+0x90>
    if(myproc()->killed){
80106321:	e8 3a dd ff ff       	call   80104060 <myproc>
80106326:	8b 40 24             	mov    0x24(%eax),%eax
80106329:	85 c0                	test   %eax,%eax
8010632b:	74 d3                	je     80106300 <sys_sleep+0x40>
      release(&tickslock);
8010632d:	83 ec 0c             	sub    $0xc,%esp
80106330:	68 80 93 15 80       	push   $0x80159380
80106335:	e8 f6 ed ff ff       	call   80105130 <release>
      return -1;
8010633a:	83 c4 10             	add    $0x10,%esp
8010633d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106342:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106345:	c9                   	leave  
80106346:	c3                   	ret    
80106347:	89 f6                	mov    %esi,%esi
80106349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106350:	83 ec 0c             	sub    $0xc,%esp
80106353:	68 80 93 15 80       	push   $0x80159380
80106358:	e8 d3 ed ff ff       	call   80105130 <release>
  return 0;
8010635d:	83 c4 10             	add    $0x10,%esp
80106360:	31 c0                	xor    %eax,%eax
}
80106362:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106365:	c9                   	leave  
80106366:	c3                   	ret    
    return -1;
80106367:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010636c:	eb f4                	jmp    80106362 <sys_sleep+0xa2>
8010636e:	66 90                	xchg   %ax,%ax

80106370 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
80106373:	53                   	push   %ebx
80106374:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106377:	68 80 93 15 80       	push   $0x80159380
8010637c:	e8 ef ec ff ff       	call   80105070 <acquire>
  xticks = ticks;
80106381:	8b 1d c0 9b 15 80    	mov    0x80159bc0,%ebx
  release(&tickslock);
80106387:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
8010638e:	e8 9d ed ff ff       	call   80105130 <release>
  return xticks;
}
80106393:	89 d8                	mov    %ebx,%eax
80106395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106398:	c9                   	leave  
80106399:	c3                   	ret    
8010639a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801063a0 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
  return numFreePages();
}
801063a3:	5d                   	pop    %ebp
  return numFreePages();
801063a4:	e9 a7 c7 ff ff       	jmp    80102b50 <numFreePages>
801063a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801063b0 <sys_printProcDump>:

int
sys_printProcDump(void){
801063b0:	55                   	push   %ebp
801063b1:	89 e5                	mov    %esp,%ebp
801063b3:	53                   	push   %ebx
  int pid;
  if(argint(0, &pid) < 0)
801063b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_printProcDump(void){
801063b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &pid) < 0)
801063ba:	50                   	push   %eax
801063bb:	6a 00                	push   $0x0
801063bd:	e8 be f0 ff ff       	call   80105480 <argint>
801063c2:	83 c4 10             	add    $0x10,%esp
801063c5:	85 c0                	test   %eax,%eax
801063c7:	78 2f                	js     801063f8 <sys_printProcDump+0x48>
    return -1;
  if(pid == 0){
801063c9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801063cc:	85 db                	test   %ebx,%ebx
801063ce:	74 18                	je     801063e8 <sys_printProcDump+0x38>
    procdump();
  }else{
    singleProcDump(pid);
801063d0:	83 ec 0c             	sub    $0xc,%esp
801063d3:	53                   	push   %ebx
  }
  return 0;
801063d4:	31 db                	xor    %ebx,%ebx
    singleProcDump(pid);
801063d6:	e8 25 e9 ff ff       	call   80104d00 <singleProcDump>
801063db:	83 c4 10             	add    $0x10,%esp
801063de:	89 d8                	mov    %ebx,%eax
801063e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063e3:	c9                   	leave  
801063e4:	c3                   	ret    
801063e5:	8d 76 00             	lea    0x0(%esi),%esi
    procdump();
801063e8:	e8 23 e7 ff ff       	call   80104b10 <procdump>
801063ed:	89 d8                	mov    %ebx,%eax
801063ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063f2:	c9                   	leave  
801063f3:	c3                   	ret    
801063f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063f8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801063fd:	eb df                	jmp    801063de <sys_printProcDump+0x2e>

801063ff <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801063ff:	1e                   	push   %ds
  pushl %es
80106400:	06                   	push   %es
  pushl %fs
80106401:	0f a0                	push   %fs
  pushl %gs
80106403:	0f a8                	push   %gs
  pushal
80106405:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106406:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010640a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010640c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010640e:	54                   	push   %esp
  call trap
8010640f:	e8 cc 00 00 00       	call   801064e0 <trap>
  addl $4, %esp
80106414:	83 c4 04             	add    $0x4,%esp

80106417 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106417:	61                   	popa   
  popl %gs
80106418:	0f a9                	pop    %gs
  popl %fs
8010641a:	0f a1                	pop    %fs
  popl %es
8010641c:	07                   	pop    %es
  popl %ds
8010641d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010641e:	83 c4 08             	add    $0x8,%esp
  iret
80106421:	cf                   	iret   
80106422:	66 90                	xchg   %ax,%ax
80106424:	66 90                	xchg   %ax,%ax
80106426:	66 90                	xchg   %ax,%ax
80106428:	66 90                	xchg   %ax,%ax
8010642a:	66 90                	xchg   %ax,%ax
8010642c:	66 90                	xchg   %ax,%ax
8010642e:	66 90                	xchg   %ax,%ax

80106430 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106430:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106431:	31 c0                	xor    %eax,%eax
{
80106433:	89 e5                	mov    %esp,%ebp
80106435:	83 ec 08             	sub    $0x8,%esp
80106438:	90                   	nop
80106439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106440:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106447:	c7 04 c5 c2 93 15 80 	movl   $0x8e000008,-0x7fea6c3e(,%eax,8)
8010644e:	08 00 00 8e 
80106452:	66 89 14 c5 c0 93 15 	mov    %dx,-0x7fea6c40(,%eax,8)
80106459:	80 
8010645a:	c1 ea 10             	shr    $0x10,%edx
8010645d:	66 89 14 c5 c6 93 15 	mov    %dx,-0x7fea6c3a(,%eax,8)
80106464:	80 
  for(i = 0; i < 256; i++)
80106465:	83 c0 01             	add    $0x1,%eax
80106468:	3d 00 01 00 00       	cmp    $0x100,%eax
8010646d:	75 d1                	jne    80106440 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010646f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106474:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106477:	c7 05 c2 95 15 80 08 	movl   $0xef000008,0x801595c2
8010647e:	00 00 ef 
  initlock(&tickslock, "time");
80106481:	68 dd 90 10 80       	push   $0x801090dd
80106486:	68 80 93 15 80       	push   $0x80159380
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010648b:	66 a3 c0 95 15 80    	mov    %ax,0x801595c0
80106491:	c1 e8 10             	shr    $0x10,%eax
80106494:	66 a3 c6 95 15 80    	mov    %ax,0x801595c6
  initlock(&tickslock, "time");
8010649a:	e8 91 ea ff ff       	call   80104f30 <initlock>
}
8010649f:	83 c4 10             	add    $0x10,%esp
801064a2:	c9                   	leave  
801064a3:	c3                   	ret    
801064a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801064aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801064b0 <idtinit>:

void
idtinit(void)
{
801064b0:	55                   	push   %ebp
  pd[0] = size-1;
801064b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801064b6:	89 e5                	mov    %esp,%ebp
801064b8:	83 ec 10             	sub    $0x10,%esp
801064bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801064bf:	b8 c0 93 15 80       	mov    $0x801593c0,%eax
801064c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801064c8:	c1 e8 10             	shr    $0x10,%eax
801064cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801064cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801064d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801064d5:	c9                   	leave  
801064d6:	c3                   	ret    
801064d7:	89 f6                	mov    %esi,%esi
801064d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
801064e5:	53                   	push   %ebx
801064e6:	83 ec 1c             	sub    $0x1c,%esp
801064e9:	8b 7d 08             	mov    0x8(%ebp),%edi
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
801064ec:	8b 47 30             	mov    0x30(%edi),%eax
801064ef:	83 f8 40             	cmp    $0x40,%eax
801064f2:	0f 84 e0 00 00 00    	je     801065d8 <trap+0xf8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801064f8:	83 e8 0e             	sub    $0xe,%eax
801064fb:	83 f8 31             	cmp    $0x31,%eax
801064fe:	0f 87 bc 01 00 00    	ja     801066c0 <trap+0x1e0>
80106504:	ff 24 85 b8 91 10 80 	jmp    *-0x7fef6e48(,%eax,4)
8010650b:	90                   	nop
8010650c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106510:	0f 20 d3             	mov    %cr2,%ebx

      addr = rcr2();
      //pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
      //pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
      //pte_t *pte = &pgtab[PTX(addr)];
      pte_t *pte = walkpgdir(myproc()->pgdir,(char*)addr,0);
80106513:	e8 48 db ff ff       	call   80104060 <myproc>
  if(*pde & PTE_P){
80106518:	8b 40 04             	mov    0x4(%eax),%eax
  pde = &pgdir[PDX(va)];
8010651b:	89 da                	mov    %ebx,%edx
8010651d:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106520:	8b 04 90             	mov    (%eax,%edx,4),%eax
80106523:	a8 01                	test   $0x1,%al
80106525:	0f 84 0d 02 00 00    	je     80106738 <trap+0x258>
  return &pgtab[PTX(va)];
8010652b:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010652d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106532:	c1 ea 0a             	shr    $0xa,%edx
80106535:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
8010653b:	8d b4 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%esi
      uint pa = PTE_ADDR(*pte);
80106542:	8b 06                	mov    (%esi),%eax

      //int inSwapFile = (((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG);
      //cprintf("first %x %x\n",pa,addr);
      

      if((*pte & PTE_U ) == 0){
80106544:	a8 04                	test   $0x4,%al
80106546:	74 28                	je     80106570 <trap+0x90>
      }

      //cprintf("trap!\n");

      //cprintf("PGFLT: ");
      if(*pte & PTE_PG){
80106548:	f6 c4 02             	test   $0x2,%ah
8010654b:	0f 85 37 02 00 00    	jne    80106788 <trap+0x2a8>
        //cprintf("swapping: %x\n",PGROUNDDOWN(addr));
        myproc()->nPGFLT++;
        swapPage(addr);
        lcr3(V2P(myproc()->pgdir));
      }
      else if((*pte & PTE_W) == 0) {
80106551:	a8 02                	test   $0x2,%al
80106553:	75 09                	jne    8010655e <trap+0x7e>
        //cprintf("trap: %x\n",addr);
        if((*pte & PTE_COW) != 0){
80106555:	f6 c4 08             	test   $0x8,%ah
80106558:	0f 85 57 02 00 00    	jne    801067b5 <trap+0x2d5>
      }/*else{
        cprintf("pid: %d\n",myproc()->pid);
        panic("trap: PF fault");
      }*/
      
      lcr3(V2P(myproc()->pgdir));
8010655e:	e8 fd da ff ff       	call   80104060 <myproc>
80106563:	8b 40 04             	mov    0x4(%eax),%eax
80106566:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010656b:	0f 22 d8             	mov    %eax,%cr3
8010656e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106570:	e8 eb da ff ff       	call   80104060 <myproc>
80106575:	85 c0                	test   %eax,%eax
80106577:	74 1d                	je     80106596 <trap+0xb6>
80106579:	e8 e2 da ff ff       	call   80104060 <myproc>
8010657e:	8b 50 24             	mov    0x24(%eax),%edx
80106581:	85 d2                	test   %edx,%edx
80106583:	74 11                	je     80106596 <trap+0xb6>
80106585:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106589:	83 e0 03             	and    $0x3,%eax
8010658c:	66 83 f8 03          	cmp    $0x3,%ax
80106590:	0f 84 aa 01 00 00    	je     80106740 <trap+0x260>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106596:	e8 c5 da ff ff       	call   80104060 <myproc>
8010659b:	85 c0                	test   %eax,%eax
8010659d:	74 0b                	je     801065aa <trap+0xca>
8010659f:	e8 bc da ff ff       	call   80104060 <myproc>
801065a4:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801065a8:	74 66                	je     80106610 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065aa:	e8 b1 da ff ff       	call   80104060 <myproc>
801065af:	85 c0                	test   %eax,%eax
801065b1:	74 19                	je     801065cc <trap+0xec>
801065b3:	e8 a8 da ff ff       	call   80104060 <myproc>
801065b8:	8b 40 24             	mov    0x24(%eax),%eax
801065bb:	85 c0                	test   %eax,%eax
801065bd:	74 0d                	je     801065cc <trap+0xec>
801065bf:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801065c3:	83 e0 03             	and    $0x3,%eax
801065c6:	66 83 f8 03          	cmp    $0x3,%ax
801065ca:	74 35                	je     80106601 <trap+0x121>
    exit();
}
801065cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065cf:	5b                   	pop    %ebx
801065d0:	5e                   	pop    %esi
801065d1:	5f                   	pop    %edi
801065d2:	5d                   	pop    %ebp
801065d3:	c3                   	ret    
801065d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801065d8:	e8 83 da ff ff       	call   80104060 <myproc>
801065dd:	8b 70 24             	mov    0x24(%eax),%esi
801065e0:	85 f6                	test   %esi,%esi
801065e2:	0f 85 c8 00 00 00    	jne    801066b0 <trap+0x1d0>
    myproc()->tf = tf;
801065e8:	e8 73 da ff ff       	call   80104060 <myproc>
801065ed:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801065f0:	e8 7b ef ff ff       	call   80105570 <syscall>
    if(myproc()->killed)
801065f5:	e8 66 da ff ff       	call   80104060 <myproc>
801065fa:	8b 58 24             	mov    0x24(%eax),%ebx
801065fd:	85 db                	test   %ebx,%ebx
801065ff:	74 cb                	je     801065cc <trap+0xec>
}
80106601:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106604:	5b                   	pop    %ebx
80106605:	5e                   	pop    %esi
80106606:	5f                   	pop    %edi
80106607:	5d                   	pop    %ebp
      exit();
80106608:	e9 53 e0 ff ff       	jmp    80104660 <exit>
8010660d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106610:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80106614:	75 94                	jne    801065aa <trap+0xca>
    yield();
80106616:	e8 a5 e1 ff ff       	call   801047c0 <yield>
8010661b:	eb 8d                	jmp    801065aa <trap+0xca>
8010661d:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106620:	e8 1b da ff ff       	call   80104040 <cpuid>
80106625:	85 c0                	test   %eax,%eax
80106627:	0f 84 23 01 00 00    	je     80106750 <trap+0x270>
    lapiceoi();
8010662d:	e8 ee c8 ff ff       	call   80102f20 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106632:	e8 29 da ff ff       	call   80104060 <myproc>
80106637:	85 c0                	test   %eax,%eax
80106639:	0f 85 3a ff ff ff    	jne    80106579 <trap+0x99>
8010663f:	e9 52 ff ff ff       	jmp    80106596 <trap+0xb6>
80106644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106648:	e8 93 c7 ff ff       	call   80102de0 <kbdintr>
    lapiceoi();
8010664d:	e8 ce c8 ff ff       	call   80102f20 <lapiceoi>
    break;
80106652:	e9 19 ff ff ff       	jmp    80106570 <trap+0x90>
80106657:	89 f6                	mov    %esi,%esi
80106659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
80106660:	e8 1b 04 00 00       	call   80106a80 <uartintr>
    lapiceoi();
80106665:	e8 b6 c8 ff ff       	call   80102f20 <lapiceoi>
    break;
8010666a:	e9 01 ff ff ff       	jmp    80106570 <trap+0x90>
8010666f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106670:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106674:	8b 77 38             	mov    0x38(%edi),%esi
80106677:	e8 c4 d9 ff ff       	call   80104040 <cpuid>
8010667c:	56                   	push   %esi
8010667d:	53                   	push   %ebx
8010667e:	50                   	push   %eax
8010667f:	68 e8 90 10 80       	push   $0x801090e8
80106684:	e8 d7 9f ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106689:	e8 92 c8 ff ff       	call   80102f20 <lapiceoi>
    break;
8010668e:	83 c4 10             	add    $0x10,%esp
80106691:	e9 da fe ff ff       	jmp    80106570 <trap+0x90>
80106696:	8d 76 00             	lea    0x0(%esi),%esi
80106699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
801066a0:	e8 7b bf ff ff       	call   80102620 <ideintr>
801066a5:	eb 86                	jmp    8010662d <trap+0x14d>
801066a7:	89 f6                	mov    %esi,%esi
801066a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
801066b0:	e8 ab df ff ff       	call   80104660 <exit>
801066b5:	e9 2e ff ff ff       	jmp    801065e8 <trap+0x108>
801066ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801066c0:	e8 9b d9 ff ff       	call   80104060 <myproc>
801066c5:	85 c0                	test   %eax,%eax
801066c7:	0f 84 18 02 00 00    	je     801068e5 <trap+0x405>
801066cd:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801066d1:	0f 84 0e 02 00 00    	je     801068e5 <trap+0x405>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801066d7:	0f 20 d1             	mov    %cr2,%ecx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066da:	8b 57 38             	mov    0x38(%edi),%edx
801066dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801066e0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801066e3:	e8 58 d9 ff ff       	call   80104040 <cpuid>
801066e8:	8b 77 34             	mov    0x34(%edi),%esi
801066eb:	8b 5f 30             	mov    0x30(%edi),%ebx
801066ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801066f1:	e8 6a d9 ff ff       	call   80104060 <myproc>
801066f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066f9:	e8 62 d9 ff ff       	call   80104060 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066fe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106701:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106704:	51                   	push   %ecx
80106705:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80106706:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106709:	ff 75 e4             	pushl  -0x1c(%ebp)
8010670c:	56                   	push   %esi
8010670d:	53                   	push   %ebx
            myproc()->pid, myproc()->name, tf->trapno,
8010670e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106711:	52                   	push   %edx
80106712:	ff 70 10             	pushl  0x10(%eax)
80106715:	68 74 91 10 80       	push   $0x80109174
8010671a:	e8 41 9f ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
8010671f:	83 c4 20             	add    $0x20,%esp
80106722:	e8 39 d9 ff ff       	call   80104060 <myproc>
80106727:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010672e:	e9 3d fe ff ff       	jmp    80106570 <trap+0x90>
80106733:	90                   	nop
80106734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      uint pa = PTE_ADDR(*pte);
80106738:	a1 00 00 00 00       	mov    0x0,%eax
8010673d:	0f 0b                	ud2    
8010673f:	90                   	nop
    exit();
80106740:	e8 1b df ff ff       	call   80104660 <exit>
80106745:	e9 4c fe ff ff       	jmp    80106596 <trap+0xb6>
8010674a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106750:	83 ec 0c             	sub    $0xc,%esp
80106753:	68 80 93 15 80       	push   $0x80159380
80106758:	e8 13 e9 ff ff       	call   80105070 <acquire>
      wakeup(&ticks);
8010675d:	c7 04 24 c0 9b 15 80 	movl   $0x80159bc0,(%esp)
      ticks++;
80106764:	83 05 c0 9b 15 80 01 	addl   $0x1,0x80159bc0
      wakeup(&ticks);
8010676b:	e8 c0 e2 ff ff       	call   80104a30 <wakeup>
      release(&tickslock);
80106770:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
80106777:	e8 b4 e9 ff ff       	call   80105130 <release>
8010677c:	83 c4 10             	add    $0x10,%esp
8010677f:	e9 a9 fe ff ff       	jmp    8010662d <trap+0x14d>
80106784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        myproc()->nPGFLT++;
80106788:	e8 d3 d8 ff ff       	call   80104060 <myproc>
8010678d:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
        swapPage(addr);
80106794:	83 ec 0c             	sub    $0xc,%esp
80106797:	53                   	push   %ebx
80106798:	e8 33 20 00 00       	call   801087d0 <swapPage>
        lcr3(V2P(myproc()->pgdir));
8010679d:	e8 be d8 ff ff       	call   80104060 <myproc>
801067a2:	8b 40 04             	mov    0x4(%eax),%eax
801067a5:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801067aa:	0f 22 d8             	mov    %eax,%cr3
801067ad:	83 c4 10             	add    $0x10,%esp
801067b0:	e9 a9 fd ff ff       	jmp    8010655e <trap+0x7e>
      uint pa = PTE_ADDR(*pte);
801067b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
          uint refCount = getReferenceCount(pa);
801067ba:	83 ec 0c             	sub    $0xc,%esp
801067bd:	50                   	push   %eax
      uint pa = PTE_ADDR(*pte);
801067be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          uint refCount = getReferenceCount(pa);
801067c1:	e8 ea c4 ff ff       	call   80102cb0 <getReferenceCount>
          if(refCount > 1) {
801067c6:	83 c4 10             	add    $0x10,%esp
801067c9:	83 f8 01             	cmp    $0x1,%eax
801067cc:	0f 86 c1 00 00 00    	jbe    80106893 <trap+0x3b3>
801067d2:	89 d8                	mov    %ebx,%eax
          for(k = 0 ; k <  MAX_PSYC_PAGES; k++){
801067d4:	31 db                	xor    %ebx,%ebx
801067d6:	89 75 e0             	mov    %esi,-0x20(%ebp)
801067d9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801067de:	89 de                	mov    %ebx,%esi
801067e0:	89 c3                	mov    %eax,%ebx
801067e2:	eb 10                	jmp    801067f4 <trap+0x314>
801067e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067e8:	83 c6 01             	add    $0x1,%esi
801067eb:	83 fe 10             	cmp    $0x10,%esi
801067ee:	0f 84 9a 00 00 00    	je     8010688e <trap+0x3ae>
            if(myproc()->physicalPGs[k].va == (char*)PGROUNDDOWN(addr)){
801067f4:	e8 67 d8 ff ff       	call   80104060 <myproc>
801067f9:	8d 14 b6             	lea    (%esi,%esi,4),%edx
801067fc:	c1 e2 02             	shl    $0x2,%edx
801067ff:	39 9c 10 d8 01 00 00 	cmp    %ebx,0x1d8(%eax,%edx,1)
80106806:	75 e0                	jne    801067e8 <trap+0x308>
80106808:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010680b:	89 55 e0             	mov    %edx,-0x20(%ebp)
              myproc()->physicalPGs[k].alloceted = 1;
8010680e:	e8 4d d8 ff ff       	call   80104060 <myproc>
80106813:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106816:	c7 84 10 e0 01 00 00 	movl   $0x1,0x1e0(%eax,%edx,1)
8010681d:	01 00 00 00 
              myproc()->physicalPGs[k].age = 0;
80106821:	e8 3a d8 ff ff       	call   80104060 <myproc>
80106826:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106829:	c7 84 10 dc 01 00 00 	movl   $0x0,0x1dc(%eax,%edx,1)
80106830:	00 00 00 00 
            if((mem = kalloc()) == 0) {
80106834:	e8 87 c2 ff ff       	call   80102ac0 <kalloc>
80106839:	85 c0                	test   %eax,%eax
8010683b:	89 c3                	mov    %eax,%ebx
8010683d:	74 73                	je     801068b2 <trap+0x3d2>
            memmove(mem, (char*)P2V(pa), PGSIZE);
8010683f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106842:	83 ec 04             	sub    $0x4,%esp
80106845:	68 00 10 00 00       	push   $0x1000
8010684a:	05 00 00 00 80       	add    $0x80000000,%eax
8010684f:	50                   	push   %eax
80106850:	53                   	push   %ebx
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
80106851:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
            memmove(mem, (char*)P2V(pa), PGSIZE);
80106857:	e8 d4 e9 ff ff       	call   80105230 <memmove>
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
8010685c:	8b 06                	mov    (%esi),%eax
8010685e:	25 ff 0f 00 00       	and    $0xfff,%eax
80106863:	09 d8                	or     %ebx,%eax
            *pte &= ~PTE_COW;
80106865:	80 e4 f7             	and    $0xf7,%ah
80106868:	83 c8 03             	or     $0x3,%eax
8010686b:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
8010686d:	e8 ee d7 ff ff       	call   80104060 <myproc>
80106872:	8b 40 04             	mov    0x4(%eax),%eax
80106875:	05 00 00 00 80       	add    $0x80000000,%eax
8010687a:	0f 22 d8             	mov    %eax,%cr3
            decrementReferenceCount(pa);
8010687d:	59                   	pop    %ecx
8010687e:	ff 75 e4             	pushl  -0x1c(%ebp)
80106881:	e8 1a c3 ff ff       	call   80102ba0 <decrementReferenceCount>
80106886:	83 c4 10             	add    $0x10,%esp
80106889:	e9 d0 fc ff ff       	jmp    8010655e <trap+0x7e>
8010688e:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106891:	eb a1                	jmp    80106834 <trap+0x354>
            *pte &= ~PTE_COW;
80106893:	8b 06                	mov    (%esi),%eax
80106895:	80 e4 f7             	and    $0xf7,%ah
80106898:	83 c8 02             	or     $0x2,%eax
8010689b:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
8010689d:	e8 be d7 ff ff       	call   80104060 <myproc>
801068a2:	8b 40 04             	mov    0x4(%eax),%eax
801068a5:	05 00 00 00 80       	add    $0x80000000,%eax
801068aa:	0f 22 d8             	mov    %eax,%cr3
801068ad:	e9 ac fc ff ff       	jmp    8010655e <trap+0x7e>
              cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
801068b2:	e8 a9 d7 ff ff       	call   80104060 <myproc>
801068b7:	8b 58 10             	mov    0x10(%eax),%ebx
801068ba:	e8 a1 d7 ff ff       	call   80104060 <myproc>
801068bf:	83 ec 04             	sub    $0x4,%esp
801068c2:	83 c0 6c             	add    $0x6c,%eax
801068c5:	53                   	push   %ebx
801068c6:	50                   	push   %eax
801068c7:	68 0c 91 10 80       	push   $0x8010910c
801068cc:	e8 8f 9d ff ff       	call   80100660 <cprintf>
              myproc()->killed = 1;
801068d1:	e8 8a d7 ff ff       	call   80104060 <myproc>
              return;
801068d6:	83 c4 10             	add    $0x10,%esp
              myproc()->killed = 1;
801068d9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
              return;
801068e0:	e9 e7 fc ff ff       	jmp    801065cc <trap+0xec>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801068e5:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801068e8:	8b 5f 38             	mov    0x38(%edi),%ebx
801068eb:	e8 50 d7 ff ff       	call   80104040 <cpuid>
801068f0:	83 ec 0c             	sub    $0xc,%esp
801068f3:	56                   	push   %esi
801068f4:	53                   	push   %ebx
801068f5:	50                   	push   %eax
801068f6:	ff 77 30             	pushl  0x30(%edi)
801068f9:	68 40 91 10 80       	push   $0x80109140
801068fe:	e8 5d 9d ff ff       	call   80100660 <cprintf>
      panic("trap");
80106903:	83 c4 14             	add    $0x14,%esp
80106906:	68 e2 90 10 80       	push   $0x801090e2
8010690b:	e8 80 9a ff ff       	call   80100390 <panic>

80106910 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106910:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
80106915:	55                   	push   %ebp
80106916:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106918:	85 c0                	test   %eax,%eax
8010691a:	74 1c                	je     80106938 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010691c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106921:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106922:	a8 01                	test   $0x1,%al
80106924:	74 12                	je     80106938 <uartgetc+0x28>
80106926:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010692b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010692c:	0f b6 c0             	movzbl %al,%eax
}
8010692f:	5d                   	pop    %ebp
80106930:	c3                   	ret    
80106931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010693d:	5d                   	pop    %ebp
8010693e:	c3                   	ret    
8010693f:	90                   	nop

80106940 <uartputc.part.0>:
uartputc(int c)
80106940:	55                   	push   %ebp
80106941:	89 e5                	mov    %esp,%ebp
80106943:	57                   	push   %edi
80106944:	56                   	push   %esi
80106945:	53                   	push   %ebx
80106946:	89 c7                	mov    %eax,%edi
80106948:	bb 80 00 00 00       	mov    $0x80,%ebx
8010694d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106952:	83 ec 0c             	sub    $0xc,%esp
80106955:	eb 1b                	jmp    80106972 <uartputc.part.0+0x32>
80106957:	89 f6                	mov    %esi,%esi
80106959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106960:	83 ec 0c             	sub    $0xc,%esp
80106963:	6a 0a                	push   $0xa
80106965:	e8 d6 c5 ff ff       	call   80102f40 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010696a:	83 c4 10             	add    $0x10,%esp
8010696d:	83 eb 01             	sub    $0x1,%ebx
80106970:	74 07                	je     80106979 <uartputc.part.0+0x39>
80106972:	89 f2                	mov    %esi,%edx
80106974:	ec                   	in     (%dx),%al
80106975:	a8 20                	test   $0x20,%al
80106977:	74 e7                	je     80106960 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106979:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010697e:	89 f8                	mov    %edi,%eax
80106980:	ee                   	out    %al,(%dx)
}
80106981:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106984:	5b                   	pop    %ebx
80106985:	5e                   	pop    %esi
80106986:	5f                   	pop    %edi
80106987:	5d                   	pop    %ebp
80106988:	c3                   	ret    
80106989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106990 <uartinit>:
{
80106990:	55                   	push   %ebp
80106991:	31 c9                	xor    %ecx,%ecx
80106993:	89 c8                	mov    %ecx,%eax
80106995:	89 e5                	mov    %esp,%ebp
80106997:	57                   	push   %edi
80106998:	56                   	push   %esi
80106999:	53                   	push   %ebx
8010699a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010699f:	89 da                	mov    %ebx,%edx
801069a1:	83 ec 0c             	sub    $0xc,%esp
801069a4:	ee                   	out    %al,(%dx)
801069a5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801069aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801069af:	89 fa                	mov    %edi,%edx
801069b1:	ee                   	out    %al,(%dx)
801069b2:	b8 0c 00 00 00       	mov    $0xc,%eax
801069b7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069bc:	ee                   	out    %al,(%dx)
801069bd:	be f9 03 00 00       	mov    $0x3f9,%esi
801069c2:	89 c8                	mov    %ecx,%eax
801069c4:	89 f2                	mov    %esi,%edx
801069c6:	ee                   	out    %al,(%dx)
801069c7:	b8 03 00 00 00       	mov    $0x3,%eax
801069cc:	89 fa                	mov    %edi,%edx
801069ce:	ee                   	out    %al,(%dx)
801069cf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801069d4:	89 c8                	mov    %ecx,%eax
801069d6:	ee                   	out    %al,(%dx)
801069d7:	b8 01 00 00 00       	mov    $0x1,%eax
801069dc:	89 f2                	mov    %esi,%edx
801069de:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801069df:	ba fd 03 00 00       	mov    $0x3fd,%edx
801069e4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801069e5:	3c ff                	cmp    $0xff,%al
801069e7:	74 5a                	je     80106a43 <uartinit+0xb3>
  uart = 1;
801069e9:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
801069f0:	00 00 00 
801069f3:	89 da                	mov    %ebx,%edx
801069f5:	ec                   	in     (%dx),%al
801069f6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069fb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801069fc:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801069ff:	bb 80 92 10 80       	mov    $0x80109280,%ebx
  ioapicenable(IRQ_COM1, 0);
80106a04:	6a 00                	push   $0x0
80106a06:	6a 04                	push   $0x4
80106a08:	e8 63 be ff ff       	call   80102870 <ioapicenable>
80106a0d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106a10:	b8 78 00 00 00       	mov    $0x78,%eax
80106a15:	eb 13                	jmp    80106a2a <uartinit+0x9a>
80106a17:	89 f6                	mov    %esi,%esi
80106a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106a20:	83 c3 01             	add    $0x1,%ebx
80106a23:	0f be 03             	movsbl (%ebx),%eax
80106a26:	84 c0                	test   %al,%al
80106a28:	74 19                	je     80106a43 <uartinit+0xb3>
  if(!uart)
80106a2a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80106a30:	85 d2                	test   %edx,%edx
80106a32:	74 ec                	je     80106a20 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106a34:	83 c3 01             	add    $0x1,%ebx
80106a37:	e8 04 ff ff ff       	call   80106940 <uartputc.part.0>
80106a3c:	0f be 03             	movsbl (%ebx),%eax
80106a3f:	84 c0                	test   %al,%al
80106a41:	75 e7                	jne    80106a2a <uartinit+0x9a>
}
80106a43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a46:	5b                   	pop    %ebx
80106a47:	5e                   	pop    %esi
80106a48:	5f                   	pop    %edi
80106a49:	5d                   	pop    %ebp
80106a4a:	c3                   	ret    
80106a4b:	90                   	nop
80106a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a50 <uartputc>:
  if(!uart)
80106a50:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
{
80106a56:	55                   	push   %ebp
80106a57:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106a59:	85 d2                	test   %edx,%edx
{
80106a5b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106a5e:	74 10                	je     80106a70 <uartputc+0x20>
}
80106a60:	5d                   	pop    %ebp
80106a61:	e9 da fe ff ff       	jmp    80106940 <uartputc.part.0>
80106a66:	8d 76 00             	lea    0x0(%esi),%esi
80106a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106a70:	5d                   	pop    %ebp
80106a71:	c3                   	ret    
80106a72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a80 <uartintr>:

void
uartintr(void)
{
80106a80:	55                   	push   %ebp
80106a81:	89 e5                	mov    %esp,%ebp
80106a83:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106a86:	68 10 69 10 80       	push   $0x80106910
80106a8b:	e8 80 9d ff ff       	call   80100810 <consoleintr>
}
80106a90:	83 c4 10             	add    $0x10,%esp
80106a93:	c9                   	leave  
80106a94:	c3                   	ret    

80106a95 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106a95:	6a 00                	push   $0x0
  pushl $0
80106a97:	6a 00                	push   $0x0
  jmp alltraps
80106a99:	e9 61 f9 ff ff       	jmp    801063ff <alltraps>

80106a9e <vector1>:
.globl vector1
vector1:
  pushl $0
80106a9e:	6a 00                	push   $0x0
  pushl $1
80106aa0:	6a 01                	push   $0x1
  jmp alltraps
80106aa2:	e9 58 f9 ff ff       	jmp    801063ff <alltraps>

80106aa7 <vector2>:
.globl vector2
vector2:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $2
80106aa9:	6a 02                	push   $0x2
  jmp alltraps
80106aab:	e9 4f f9 ff ff       	jmp    801063ff <alltraps>

80106ab0 <vector3>:
.globl vector3
vector3:
  pushl $0
80106ab0:	6a 00                	push   $0x0
  pushl $3
80106ab2:	6a 03                	push   $0x3
  jmp alltraps
80106ab4:	e9 46 f9 ff ff       	jmp    801063ff <alltraps>

80106ab9 <vector4>:
.globl vector4
vector4:
  pushl $0
80106ab9:	6a 00                	push   $0x0
  pushl $4
80106abb:	6a 04                	push   $0x4
  jmp alltraps
80106abd:	e9 3d f9 ff ff       	jmp    801063ff <alltraps>

80106ac2 <vector5>:
.globl vector5
vector5:
  pushl $0
80106ac2:	6a 00                	push   $0x0
  pushl $5
80106ac4:	6a 05                	push   $0x5
  jmp alltraps
80106ac6:	e9 34 f9 ff ff       	jmp    801063ff <alltraps>

80106acb <vector6>:
.globl vector6
vector6:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $6
80106acd:	6a 06                	push   $0x6
  jmp alltraps
80106acf:	e9 2b f9 ff ff       	jmp    801063ff <alltraps>

80106ad4 <vector7>:
.globl vector7
vector7:
  pushl $0
80106ad4:	6a 00                	push   $0x0
  pushl $7
80106ad6:	6a 07                	push   $0x7
  jmp alltraps
80106ad8:	e9 22 f9 ff ff       	jmp    801063ff <alltraps>

80106add <vector8>:
.globl vector8
vector8:
  pushl $8
80106add:	6a 08                	push   $0x8
  jmp alltraps
80106adf:	e9 1b f9 ff ff       	jmp    801063ff <alltraps>

80106ae4 <vector9>:
.globl vector9
vector9:
  pushl $0
80106ae4:	6a 00                	push   $0x0
  pushl $9
80106ae6:	6a 09                	push   $0x9
  jmp alltraps
80106ae8:	e9 12 f9 ff ff       	jmp    801063ff <alltraps>

80106aed <vector10>:
.globl vector10
vector10:
  pushl $10
80106aed:	6a 0a                	push   $0xa
  jmp alltraps
80106aef:	e9 0b f9 ff ff       	jmp    801063ff <alltraps>

80106af4 <vector11>:
.globl vector11
vector11:
  pushl $11
80106af4:	6a 0b                	push   $0xb
  jmp alltraps
80106af6:	e9 04 f9 ff ff       	jmp    801063ff <alltraps>

80106afb <vector12>:
.globl vector12
vector12:
  pushl $12
80106afb:	6a 0c                	push   $0xc
  jmp alltraps
80106afd:	e9 fd f8 ff ff       	jmp    801063ff <alltraps>

80106b02 <vector13>:
.globl vector13
vector13:
  pushl $13
80106b02:	6a 0d                	push   $0xd
  jmp alltraps
80106b04:	e9 f6 f8 ff ff       	jmp    801063ff <alltraps>

80106b09 <vector14>:
.globl vector14
vector14:
  pushl $14
80106b09:	6a 0e                	push   $0xe
  jmp alltraps
80106b0b:	e9 ef f8 ff ff       	jmp    801063ff <alltraps>

80106b10 <vector15>:
.globl vector15
vector15:
  pushl $0
80106b10:	6a 00                	push   $0x0
  pushl $15
80106b12:	6a 0f                	push   $0xf
  jmp alltraps
80106b14:	e9 e6 f8 ff ff       	jmp    801063ff <alltraps>

80106b19 <vector16>:
.globl vector16
vector16:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $16
80106b1b:	6a 10                	push   $0x10
  jmp alltraps
80106b1d:	e9 dd f8 ff ff       	jmp    801063ff <alltraps>

80106b22 <vector17>:
.globl vector17
vector17:
  pushl $17
80106b22:	6a 11                	push   $0x11
  jmp alltraps
80106b24:	e9 d6 f8 ff ff       	jmp    801063ff <alltraps>

80106b29 <vector18>:
.globl vector18
vector18:
  pushl $0
80106b29:	6a 00                	push   $0x0
  pushl $18
80106b2b:	6a 12                	push   $0x12
  jmp alltraps
80106b2d:	e9 cd f8 ff ff       	jmp    801063ff <alltraps>

80106b32 <vector19>:
.globl vector19
vector19:
  pushl $0
80106b32:	6a 00                	push   $0x0
  pushl $19
80106b34:	6a 13                	push   $0x13
  jmp alltraps
80106b36:	e9 c4 f8 ff ff       	jmp    801063ff <alltraps>

80106b3b <vector20>:
.globl vector20
vector20:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $20
80106b3d:	6a 14                	push   $0x14
  jmp alltraps
80106b3f:	e9 bb f8 ff ff       	jmp    801063ff <alltraps>

80106b44 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b44:	6a 00                	push   $0x0
  pushl $21
80106b46:	6a 15                	push   $0x15
  jmp alltraps
80106b48:	e9 b2 f8 ff ff       	jmp    801063ff <alltraps>

80106b4d <vector22>:
.globl vector22
vector22:
  pushl $0
80106b4d:	6a 00                	push   $0x0
  pushl $22
80106b4f:	6a 16                	push   $0x16
  jmp alltraps
80106b51:	e9 a9 f8 ff ff       	jmp    801063ff <alltraps>

80106b56 <vector23>:
.globl vector23
vector23:
  pushl $0
80106b56:	6a 00                	push   $0x0
  pushl $23
80106b58:	6a 17                	push   $0x17
  jmp alltraps
80106b5a:	e9 a0 f8 ff ff       	jmp    801063ff <alltraps>

80106b5f <vector24>:
.globl vector24
vector24:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $24
80106b61:	6a 18                	push   $0x18
  jmp alltraps
80106b63:	e9 97 f8 ff ff       	jmp    801063ff <alltraps>

80106b68 <vector25>:
.globl vector25
vector25:
  pushl $0
80106b68:	6a 00                	push   $0x0
  pushl $25
80106b6a:	6a 19                	push   $0x19
  jmp alltraps
80106b6c:	e9 8e f8 ff ff       	jmp    801063ff <alltraps>

80106b71 <vector26>:
.globl vector26
vector26:
  pushl $0
80106b71:	6a 00                	push   $0x0
  pushl $26
80106b73:	6a 1a                	push   $0x1a
  jmp alltraps
80106b75:	e9 85 f8 ff ff       	jmp    801063ff <alltraps>

80106b7a <vector27>:
.globl vector27
vector27:
  pushl $0
80106b7a:	6a 00                	push   $0x0
  pushl $27
80106b7c:	6a 1b                	push   $0x1b
  jmp alltraps
80106b7e:	e9 7c f8 ff ff       	jmp    801063ff <alltraps>

80106b83 <vector28>:
.globl vector28
vector28:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $28
80106b85:	6a 1c                	push   $0x1c
  jmp alltraps
80106b87:	e9 73 f8 ff ff       	jmp    801063ff <alltraps>

80106b8c <vector29>:
.globl vector29
vector29:
  pushl $0
80106b8c:	6a 00                	push   $0x0
  pushl $29
80106b8e:	6a 1d                	push   $0x1d
  jmp alltraps
80106b90:	e9 6a f8 ff ff       	jmp    801063ff <alltraps>

80106b95 <vector30>:
.globl vector30
vector30:
  pushl $0
80106b95:	6a 00                	push   $0x0
  pushl $30
80106b97:	6a 1e                	push   $0x1e
  jmp alltraps
80106b99:	e9 61 f8 ff ff       	jmp    801063ff <alltraps>

80106b9e <vector31>:
.globl vector31
vector31:
  pushl $0
80106b9e:	6a 00                	push   $0x0
  pushl $31
80106ba0:	6a 1f                	push   $0x1f
  jmp alltraps
80106ba2:	e9 58 f8 ff ff       	jmp    801063ff <alltraps>

80106ba7 <vector32>:
.globl vector32
vector32:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $32
80106ba9:	6a 20                	push   $0x20
  jmp alltraps
80106bab:	e9 4f f8 ff ff       	jmp    801063ff <alltraps>

80106bb0 <vector33>:
.globl vector33
vector33:
  pushl $0
80106bb0:	6a 00                	push   $0x0
  pushl $33
80106bb2:	6a 21                	push   $0x21
  jmp alltraps
80106bb4:	e9 46 f8 ff ff       	jmp    801063ff <alltraps>

80106bb9 <vector34>:
.globl vector34
vector34:
  pushl $0
80106bb9:	6a 00                	push   $0x0
  pushl $34
80106bbb:	6a 22                	push   $0x22
  jmp alltraps
80106bbd:	e9 3d f8 ff ff       	jmp    801063ff <alltraps>

80106bc2 <vector35>:
.globl vector35
vector35:
  pushl $0
80106bc2:	6a 00                	push   $0x0
  pushl $35
80106bc4:	6a 23                	push   $0x23
  jmp alltraps
80106bc6:	e9 34 f8 ff ff       	jmp    801063ff <alltraps>

80106bcb <vector36>:
.globl vector36
vector36:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $36
80106bcd:	6a 24                	push   $0x24
  jmp alltraps
80106bcf:	e9 2b f8 ff ff       	jmp    801063ff <alltraps>

80106bd4 <vector37>:
.globl vector37
vector37:
  pushl $0
80106bd4:	6a 00                	push   $0x0
  pushl $37
80106bd6:	6a 25                	push   $0x25
  jmp alltraps
80106bd8:	e9 22 f8 ff ff       	jmp    801063ff <alltraps>

80106bdd <vector38>:
.globl vector38
vector38:
  pushl $0
80106bdd:	6a 00                	push   $0x0
  pushl $38
80106bdf:	6a 26                	push   $0x26
  jmp alltraps
80106be1:	e9 19 f8 ff ff       	jmp    801063ff <alltraps>

80106be6 <vector39>:
.globl vector39
vector39:
  pushl $0
80106be6:	6a 00                	push   $0x0
  pushl $39
80106be8:	6a 27                	push   $0x27
  jmp alltraps
80106bea:	e9 10 f8 ff ff       	jmp    801063ff <alltraps>

80106bef <vector40>:
.globl vector40
vector40:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $40
80106bf1:	6a 28                	push   $0x28
  jmp alltraps
80106bf3:	e9 07 f8 ff ff       	jmp    801063ff <alltraps>

80106bf8 <vector41>:
.globl vector41
vector41:
  pushl $0
80106bf8:	6a 00                	push   $0x0
  pushl $41
80106bfa:	6a 29                	push   $0x29
  jmp alltraps
80106bfc:	e9 fe f7 ff ff       	jmp    801063ff <alltraps>

80106c01 <vector42>:
.globl vector42
vector42:
  pushl $0
80106c01:	6a 00                	push   $0x0
  pushl $42
80106c03:	6a 2a                	push   $0x2a
  jmp alltraps
80106c05:	e9 f5 f7 ff ff       	jmp    801063ff <alltraps>

80106c0a <vector43>:
.globl vector43
vector43:
  pushl $0
80106c0a:	6a 00                	push   $0x0
  pushl $43
80106c0c:	6a 2b                	push   $0x2b
  jmp alltraps
80106c0e:	e9 ec f7 ff ff       	jmp    801063ff <alltraps>

80106c13 <vector44>:
.globl vector44
vector44:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $44
80106c15:	6a 2c                	push   $0x2c
  jmp alltraps
80106c17:	e9 e3 f7 ff ff       	jmp    801063ff <alltraps>

80106c1c <vector45>:
.globl vector45
vector45:
  pushl $0
80106c1c:	6a 00                	push   $0x0
  pushl $45
80106c1e:	6a 2d                	push   $0x2d
  jmp alltraps
80106c20:	e9 da f7 ff ff       	jmp    801063ff <alltraps>

80106c25 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c25:	6a 00                	push   $0x0
  pushl $46
80106c27:	6a 2e                	push   $0x2e
  jmp alltraps
80106c29:	e9 d1 f7 ff ff       	jmp    801063ff <alltraps>

80106c2e <vector47>:
.globl vector47
vector47:
  pushl $0
80106c2e:	6a 00                	push   $0x0
  pushl $47
80106c30:	6a 2f                	push   $0x2f
  jmp alltraps
80106c32:	e9 c8 f7 ff ff       	jmp    801063ff <alltraps>

80106c37 <vector48>:
.globl vector48
vector48:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $48
80106c39:	6a 30                	push   $0x30
  jmp alltraps
80106c3b:	e9 bf f7 ff ff       	jmp    801063ff <alltraps>

80106c40 <vector49>:
.globl vector49
vector49:
  pushl $0
80106c40:	6a 00                	push   $0x0
  pushl $49
80106c42:	6a 31                	push   $0x31
  jmp alltraps
80106c44:	e9 b6 f7 ff ff       	jmp    801063ff <alltraps>

80106c49 <vector50>:
.globl vector50
vector50:
  pushl $0
80106c49:	6a 00                	push   $0x0
  pushl $50
80106c4b:	6a 32                	push   $0x32
  jmp alltraps
80106c4d:	e9 ad f7 ff ff       	jmp    801063ff <alltraps>

80106c52 <vector51>:
.globl vector51
vector51:
  pushl $0
80106c52:	6a 00                	push   $0x0
  pushl $51
80106c54:	6a 33                	push   $0x33
  jmp alltraps
80106c56:	e9 a4 f7 ff ff       	jmp    801063ff <alltraps>

80106c5b <vector52>:
.globl vector52
vector52:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $52
80106c5d:	6a 34                	push   $0x34
  jmp alltraps
80106c5f:	e9 9b f7 ff ff       	jmp    801063ff <alltraps>

80106c64 <vector53>:
.globl vector53
vector53:
  pushl $0
80106c64:	6a 00                	push   $0x0
  pushl $53
80106c66:	6a 35                	push   $0x35
  jmp alltraps
80106c68:	e9 92 f7 ff ff       	jmp    801063ff <alltraps>

80106c6d <vector54>:
.globl vector54
vector54:
  pushl $0
80106c6d:	6a 00                	push   $0x0
  pushl $54
80106c6f:	6a 36                	push   $0x36
  jmp alltraps
80106c71:	e9 89 f7 ff ff       	jmp    801063ff <alltraps>

80106c76 <vector55>:
.globl vector55
vector55:
  pushl $0
80106c76:	6a 00                	push   $0x0
  pushl $55
80106c78:	6a 37                	push   $0x37
  jmp alltraps
80106c7a:	e9 80 f7 ff ff       	jmp    801063ff <alltraps>

80106c7f <vector56>:
.globl vector56
vector56:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $56
80106c81:	6a 38                	push   $0x38
  jmp alltraps
80106c83:	e9 77 f7 ff ff       	jmp    801063ff <alltraps>

80106c88 <vector57>:
.globl vector57
vector57:
  pushl $0
80106c88:	6a 00                	push   $0x0
  pushl $57
80106c8a:	6a 39                	push   $0x39
  jmp alltraps
80106c8c:	e9 6e f7 ff ff       	jmp    801063ff <alltraps>

80106c91 <vector58>:
.globl vector58
vector58:
  pushl $0
80106c91:	6a 00                	push   $0x0
  pushl $58
80106c93:	6a 3a                	push   $0x3a
  jmp alltraps
80106c95:	e9 65 f7 ff ff       	jmp    801063ff <alltraps>

80106c9a <vector59>:
.globl vector59
vector59:
  pushl $0
80106c9a:	6a 00                	push   $0x0
  pushl $59
80106c9c:	6a 3b                	push   $0x3b
  jmp alltraps
80106c9e:	e9 5c f7 ff ff       	jmp    801063ff <alltraps>

80106ca3 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $60
80106ca5:	6a 3c                	push   $0x3c
  jmp alltraps
80106ca7:	e9 53 f7 ff ff       	jmp    801063ff <alltraps>

80106cac <vector61>:
.globl vector61
vector61:
  pushl $0
80106cac:	6a 00                	push   $0x0
  pushl $61
80106cae:	6a 3d                	push   $0x3d
  jmp alltraps
80106cb0:	e9 4a f7 ff ff       	jmp    801063ff <alltraps>

80106cb5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106cb5:	6a 00                	push   $0x0
  pushl $62
80106cb7:	6a 3e                	push   $0x3e
  jmp alltraps
80106cb9:	e9 41 f7 ff ff       	jmp    801063ff <alltraps>

80106cbe <vector63>:
.globl vector63
vector63:
  pushl $0
80106cbe:	6a 00                	push   $0x0
  pushl $63
80106cc0:	6a 3f                	push   $0x3f
  jmp alltraps
80106cc2:	e9 38 f7 ff ff       	jmp    801063ff <alltraps>

80106cc7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $64
80106cc9:	6a 40                	push   $0x40
  jmp alltraps
80106ccb:	e9 2f f7 ff ff       	jmp    801063ff <alltraps>

80106cd0 <vector65>:
.globl vector65
vector65:
  pushl $0
80106cd0:	6a 00                	push   $0x0
  pushl $65
80106cd2:	6a 41                	push   $0x41
  jmp alltraps
80106cd4:	e9 26 f7 ff ff       	jmp    801063ff <alltraps>

80106cd9 <vector66>:
.globl vector66
vector66:
  pushl $0
80106cd9:	6a 00                	push   $0x0
  pushl $66
80106cdb:	6a 42                	push   $0x42
  jmp alltraps
80106cdd:	e9 1d f7 ff ff       	jmp    801063ff <alltraps>

80106ce2 <vector67>:
.globl vector67
vector67:
  pushl $0
80106ce2:	6a 00                	push   $0x0
  pushl $67
80106ce4:	6a 43                	push   $0x43
  jmp alltraps
80106ce6:	e9 14 f7 ff ff       	jmp    801063ff <alltraps>

80106ceb <vector68>:
.globl vector68
vector68:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $68
80106ced:	6a 44                	push   $0x44
  jmp alltraps
80106cef:	e9 0b f7 ff ff       	jmp    801063ff <alltraps>

80106cf4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106cf4:	6a 00                	push   $0x0
  pushl $69
80106cf6:	6a 45                	push   $0x45
  jmp alltraps
80106cf8:	e9 02 f7 ff ff       	jmp    801063ff <alltraps>

80106cfd <vector70>:
.globl vector70
vector70:
  pushl $0
80106cfd:	6a 00                	push   $0x0
  pushl $70
80106cff:	6a 46                	push   $0x46
  jmp alltraps
80106d01:	e9 f9 f6 ff ff       	jmp    801063ff <alltraps>

80106d06 <vector71>:
.globl vector71
vector71:
  pushl $0
80106d06:	6a 00                	push   $0x0
  pushl $71
80106d08:	6a 47                	push   $0x47
  jmp alltraps
80106d0a:	e9 f0 f6 ff ff       	jmp    801063ff <alltraps>

80106d0f <vector72>:
.globl vector72
vector72:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $72
80106d11:	6a 48                	push   $0x48
  jmp alltraps
80106d13:	e9 e7 f6 ff ff       	jmp    801063ff <alltraps>

80106d18 <vector73>:
.globl vector73
vector73:
  pushl $0
80106d18:	6a 00                	push   $0x0
  pushl $73
80106d1a:	6a 49                	push   $0x49
  jmp alltraps
80106d1c:	e9 de f6 ff ff       	jmp    801063ff <alltraps>

80106d21 <vector74>:
.globl vector74
vector74:
  pushl $0
80106d21:	6a 00                	push   $0x0
  pushl $74
80106d23:	6a 4a                	push   $0x4a
  jmp alltraps
80106d25:	e9 d5 f6 ff ff       	jmp    801063ff <alltraps>

80106d2a <vector75>:
.globl vector75
vector75:
  pushl $0
80106d2a:	6a 00                	push   $0x0
  pushl $75
80106d2c:	6a 4b                	push   $0x4b
  jmp alltraps
80106d2e:	e9 cc f6 ff ff       	jmp    801063ff <alltraps>

80106d33 <vector76>:
.globl vector76
vector76:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $76
80106d35:	6a 4c                	push   $0x4c
  jmp alltraps
80106d37:	e9 c3 f6 ff ff       	jmp    801063ff <alltraps>

80106d3c <vector77>:
.globl vector77
vector77:
  pushl $0
80106d3c:	6a 00                	push   $0x0
  pushl $77
80106d3e:	6a 4d                	push   $0x4d
  jmp alltraps
80106d40:	e9 ba f6 ff ff       	jmp    801063ff <alltraps>

80106d45 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d45:	6a 00                	push   $0x0
  pushl $78
80106d47:	6a 4e                	push   $0x4e
  jmp alltraps
80106d49:	e9 b1 f6 ff ff       	jmp    801063ff <alltraps>

80106d4e <vector79>:
.globl vector79
vector79:
  pushl $0
80106d4e:	6a 00                	push   $0x0
  pushl $79
80106d50:	6a 4f                	push   $0x4f
  jmp alltraps
80106d52:	e9 a8 f6 ff ff       	jmp    801063ff <alltraps>

80106d57 <vector80>:
.globl vector80
vector80:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $80
80106d59:	6a 50                	push   $0x50
  jmp alltraps
80106d5b:	e9 9f f6 ff ff       	jmp    801063ff <alltraps>

80106d60 <vector81>:
.globl vector81
vector81:
  pushl $0
80106d60:	6a 00                	push   $0x0
  pushl $81
80106d62:	6a 51                	push   $0x51
  jmp alltraps
80106d64:	e9 96 f6 ff ff       	jmp    801063ff <alltraps>

80106d69 <vector82>:
.globl vector82
vector82:
  pushl $0
80106d69:	6a 00                	push   $0x0
  pushl $82
80106d6b:	6a 52                	push   $0x52
  jmp alltraps
80106d6d:	e9 8d f6 ff ff       	jmp    801063ff <alltraps>

80106d72 <vector83>:
.globl vector83
vector83:
  pushl $0
80106d72:	6a 00                	push   $0x0
  pushl $83
80106d74:	6a 53                	push   $0x53
  jmp alltraps
80106d76:	e9 84 f6 ff ff       	jmp    801063ff <alltraps>

80106d7b <vector84>:
.globl vector84
vector84:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $84
80106d7d:	6a 54                	push   $0x54
  jmp alltraps
80106d7f:	e9 7b f6 ff ff       	jmp    801063ff <alltraps>

80106d84 <vector85>:
.globl vector85
vector85:
  pushl $0
80106d84:	6a 00                	push   $0x0
  pushl $85
80106d86:	6a 55                	push   $0x55
  jmp alltraps
80106d88:	e9 72 f6 ff ff       	jmp    801063ff <alltraps>

80106d8d <vector86>:
.globl vector86
vector86:
  pushl $0
80106d8d:	6a 00                	push   $0x0
  pushl $86
80106d8f:	6a 56                	push   $0x56
  jmp alltraps
80106d91:	e9 69 f6 ff ff       	jmp    801063ff <alltraps>

80106d96 <vector87>:
.globl vector87
vector87:
  pushl $0
80106d96:	6a 00                	push   $0x0
  pushl $87
80106d98:	6a 57                	push   $0x57
  jmp alltraps
80106d9a:	e9 60 f6 ff ff       	jmp    801063ff <alltraps>

80106d9f <vector88>:
.globl vector88
vector88:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $88
80106da1:	6a 58                	push   $0x58
  jmp alltraps
80106da3:	e9 57 f6 ff ff       	jmp    801063ff <alltraps>

80106da8 <vector89>:
.globl vector89
vector89:
  pushl $0
80106da8:	6a 00                	push   $0x0
  pushl $89
80106daa:	6a 59                	push   $0x59
  jmp alltraps
80106dac:	e9 4e f6 ff ff       	jmp    801063ff <alltraps>

80106db1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106db1:	6a 00                	push   $0x0
  pushl $90
80106db3:	6a 5a                	push   $0x5a
  jmp alltraps
80106db5:	e9 45 f6 ff ff       	jmp    801063ff <alltraps>

80106dba <vector91>:
.globl vector91
vector91:
  pushl $0
80106dba:	6a 00                	push   $0x0
  pushl $91
80106dbc:	6a 5b                	push   $0x5b
  jmp alltraps
80106dbe:	e9 3c f6 ff ff       	jmp    801063ff <alltraps>

80106dc3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $92
80106dc5:	6a 5c                	push   $0x5c
  jmp alltraps
80106dc7:	e9 33 f6 ff ff       	jmp    801063ff <alltraps>

80106dcc <vector93>:
.globl vector93
vector93:
  pushl $0
80106dcc:	6a 00                	push   $0x0
  pushl $93
80106dce:	6a 5d                	push   $0x5d
  jmp alltraps
80106dd0:	e9 2a f6 ff ff       	jmp    801063ff <alltraps>

80106dd5 <vector94>:
.globl vector94
vector94:
  pushl $0
80106dd5:	6a 00                	push   $0x0
  pushl $94
80106dd7:	6a 5e                	push   $0x5e
  jmp alltraps
80106dd9:	e9 21 f6 ff ff       	jmp    801063ff <alltraps>

80106dde <vector95>:
.globl vector95
vector95:
  pushl $0
80106dde:	6a 00                	push   $0x0
  pushl $95
80106de0:	6a 5f                	push   $0x5f
  jmp alltraps
80106de2:	e9 18 f6 ff ff       	jmp    801063ff <alltraps>

80106de7 <vector96>:
.globl vector96
vector96:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $96
80106de9:	6a 60                	push   $0x60
  jmp alltraps
80106deb:	e9 0f f6 ff ff       	jmp    801063ff <alltraps>

80106df0 <vector97>:
.globl vector97
vector97:
  pushl $0
80106df0:	6a 00                	push   $0x0
  pushl $97
80106df2:	6a 61                	push   $0x61
  jmp alltraps
80106df4:	e9 06 f6 ff ff       	jmp    801063ff <alltraps>

80106df9 <vector98>:
.globl vector98
vector98:
  pushl $0
80106df9:	6a 00                	push   $0x0
  pushl $98
80106dfb:	6a 62                	push   $0x62
  jmp alltraps
80106dfd:	e9 fd f5 ff ff       	jmp    801063ff <alltraps>

80106e02 <vector99>:
.globl vector99
vector99:
  pushl $0
80106e02:	6a 00                	push   $0x0
  pushl $99
80106e04:	6a 63                	push   $0x63
  jmp alltraps
80106e06:	e9 f4 f5 ff ff       	jmp    801063ff <alltraps>

80106e0b <vector100>:
.globl vector100
vector100:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $100
80106e0d:	6a 64                	push   $0x64
  jmp alltraps
80106e0f:	e9 eb f5 ff ff       	jmp    801063ff <alltraps>

80106e14 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e14:	6a 00                	push   $0x0
  pushl $101
80106e16:	6a 65                	push   $0x65
  jmp alltraps
80106e18:	e9 e2 f5 ff ff       	jmp    801063ff <alltraps>

80106e1d <vector102>:
.globl vector102
vector102:
  pushl $0
80106e1d:	6a 00                	push   $0x0
  pushl $102
80106e1f:	6a 66                	push   $0x66
  jmp alltraps
80106e21:	e9 d9 f5 ff ff       	jmp    801063ff <alltraps>

80106e26 <vector103>:
.globl vector103
vector103:
  pushl $0
80106e26:	6a 00                	push   $0x0
  pushl $103
80106e28:	6a 67                	push   $0x67
  jmp alltraps
80106e2a:	e9 d0 f5 ff ff       	jmp    801063ff <alltraps>

80106e2f <vector104>:
.globl vector104
vector104:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $104
80106e31:	6a 68                	push   $0x68
  jmp alltraps
80106e33:	e9 c7 f5 ff ff       	jmp    801063ff <alltraps>

80106e38 <vector105>:
.globl vector105
vector105:
  pushl $0
80106e38:	6a 00                	push   $0x0
  pushl $105
80106e3a:	6a 69                	push   $0x69
  jmp alltraps
80106e3c:	e9 be f5 ff ff       	jmp    801063ff <alltraps>

80106e41 <vector106>:
.globl vector106
vector106:
  pushl $0
80106e41:	6a 00                	push   $0x0
  pushl $106
80106e43:	6a 6a                	push   $0x6a
  jmp alltraps
80106e45:	e9 b5 f5 ff ff       	jmp    801063ff <alltraps>

80106e4a <vector107>:
.globl vector107
vector107:
  pushl $0
80106e4a:	6a 00                	push   $0x0
  pushl $107
80106e4c:	6a 6b                	push   $0x6b
  jmp alltraps
80106e4e:	e9 ac f5 ff ff       	jmp    801063ff <alltraps>

80106e53 <vector108>:
.globl vector108
vector108:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $108
80106e55:	6a 6c                	push   $0x6c
  jmp alltraps
80106e57:	e9 a3 f5 ff ff       	jmp    801063ff <alltraps>

80106e5c <vector109>:
.globl vector109
vector109:
  pushl $0
80106e5c:	6a 00                	push   $0x0
  pushl $109
80106e5e:	6a 6d                	push   $0x6d
  jmp alltraps
80106e60:	e9 9a f5 ff ff       	jmp    801063ff <alltraps>

80106e65 <vector110>:
.globl vector110
vector110:
  pushl $0
80106e65:	6a 00                	push   $0x0
  pushl $110
80106e67:	6a 6e                	push   $0x6e
  jmp alltraps
80106e69:	e9 91 f5 ff ff       	jmp    801063ff <alltraps>

80106e6e <vector111>:
.globl vector111
vector111:
  pushl $0
80106e6e:	6a 00                	push   $0x0
  pushl $111
80106e70:	6a 6f                	push   $0x6f
  jmp alltraps
80106e72:	e9 88 f5 ff ff       	jmp    801063ff <alltraps>

80106e77 <vector112>:
.globl vector112
vector112:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $112
80106e79:	6a 70                	push   $0x70
  jmp alltraps
80106e7b:	e9 7f f5 ff ff       	jmp    801063ff <alltraps>

80106e80 <vector113>:
.globl vector113
vector113:
  pushl $0
80106e80:	6a 00                	push   $0x0
  pushl $113
80106e82:	6a 71                	push   $0x71
  jmp alltraps
80106e84:	e9 76 f5 ff ff       	jmp    801063ff <alltraps>

80106e89 <vector114>:
.globl vector114
vector114:
  pushl $0
80106e89:	6a 00                	push   $0x0
  pushl $114
80106e8b:	6a 72                	push   $0x72
  jmp alltraps
80106e8d:	e9 6d f5 ff ff       	jmp    801063ff <alltraps>

80106e92 <vector115>:
.globl vector115
vector115:
  pushl $0
80106e92:	6a 00                	push   $0x0
  pushl $115
80106e94:	6a 73                	push   $0x73
  jmp alltraps
80106e96:	e9 64 f5 ff ff       	jmp    801063ff <alltraps>

80106e9b <vector116>:
.globl vector116
vector116:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $116
80106e9d:	6a 74                	push   $0x74
  jmp alltraps
80106e9f:	e9 5b f5 ff ff       	jmp    801063ff <alltraps>

80106ea4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ea4:	6a 00                	push   $0x0
  pushl $117
80106ea6:	6a 75                	push   $0x75
  jmp alltraps
80106ea8:	e9 52 f5 ff ff       	jmp    801063ff <alltraps>

80106ead <vector118>:
.globl vector118
vector118:
  pushl $0
80106ead:	6a 00                	push   $0x0
  pushl $118
80106eaf:	6a 76                	push   $0x76
  jmp alltraps
80106eb1:	e9 49 f5 ff ff       	jmp    801063ff <alltraps>

80106eb6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106eb6:	6a 00                	push   $0x0
  pushl $119
80106eb8:	6a 77                	push   $0x77
  jmp alltraps
80106eba:	e9 40 f5 ff ff       	jmp    801063ff <alltraps>

80106ebf <vector120>:
.globl vector120
vector120:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $120
80106ec1:	6a 78                	push   $0x78
  jmp alltraps
80106ec3:	e9 37 f5 ff ff       	jmp    801063ff <alltraps>

80106ec8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ec8:	6a 00                	push   $0x0
  pushl $121
80106eca:	6a 79                	push   $0x79
  jmp alltraps
80106ecc:	e9 2e f5 ff ff       	jmp    801063ff <alltraps>

80106ed1 <vector122>:
.globl vector122
vector122:
  pushl $0
80106ed1:	6a 00                	push   $0x0
  pushl $122
80106ed3:	6a 7a                	push   $0x7a
  jmp alltraps
80106ed5:	e9 25 f5 ff ff       	jmp    801063ff <alltraps>

80106eda <vector123>:
.globl vector123
vector123:
  pushl $0
80106eda:	6a 00                	push   $0x0
  pushl $123
80106edc:	6a 7b                	push   $0x7b
  jmp alltraps
80106ede:	e9 1c f5 ff ff       	jmp    801063ff <alltraps>

80106ee3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $124
80106ee5:	6a 7c                	push   $0x7c
  jmp alltraps
80106ee7:	e9 13 f5 ff ff       	jmp    801063ff <alltraps>

80106eec <vector125>:
.globl vector125
vector125:
  pushl $0
80106eec:	6a 00                	push   $0x0
  pushl $125
80106eee:	6a 7d                	push   $0x7d
  jmp alltraps
80106ef0:	e9 0a f5 ff ff       	jmp    801063ff <alltraps>

80106ef5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106ef5:	6a 00                	push   $0x0
  pushl $126
80106ef7:	6a 7e                	push   $0x7e
  jmp alltraps
80106ef9:	e9 01 f5 ff ff       	jmp    801063ff <alltraps>

80106efe <vector127>:
.globl vector127
vector127:
  pushl $0
80106efe:	6a 00                	push   $0x0
  pushl $127
80106f00:	6a 7f                	push   $0x7f
  jmp alltraps
80106f02:	e9 f8 f4 ff ff       	jmp    801063ff <alltraps>

80106f07 <vector128>:
.globl vector128
vector128:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $128
80106f09:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f0e:	e9 ec f4 ff ff       	jmp    801063ff <alltraps>

80106f13 <vector129>:
.globl vector129
vector129:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $129
80106f15:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f1a:	e9 e0 f4 ff ff       	jmp    801063ff <alltraps>

80106f1f <vector130>:
.globl vector130
vector130:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $130
80106f21:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f26:	e9 d4 f4 ff ff       	jmp    801063ff <alltraps>

80106f2b <vector131>:
.globl vector131
vector131:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $131
80106f2d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f32:	e9 c8 f4 ff ff       	jmp    801063ff <alltraps>

80106f37 <vector132>:
.globl vector132
vector132:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $132
80106f39:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f3e:	e9 bc f4 ff ff       	jmp    801063ff <alltraps>

80106f43 <vector133>:
.globl vector133
vector133:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $133
80106f45:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f4a:	e9 b0 f4 ff ff       	jmp    801063ff <alltraps>

80106f4f <vector134>:
.globl vector134
vector134:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $134
80106f51:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f56:	e9 a4 f4 ff ff       	jmp    801063ff <alltraps>

80106f5b <vector135>:
.globl vector135
vector135:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $135
80106f5d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106f62:	e9 98 f4 ff ff       	jmp    801063ff <alltraps>

80106f67 <vector136>:
.globl vector136
vector136:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $136
80106f69:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106f6e:	e9 8c f4 ff ff       	jmp    801063ff <alltraps>

80106f73 <vector137>:
.globl vector137
vector137:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $137
80106f75:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106f7a:	e9 80 f4 ff ff       	jmp    801063ff <alltraps>

80106f7f <vector138>:
.globl vector138
vector138:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $138
80106f81:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106f86:	e9 74 f4 ff ff       	jmp    801063ff <alltraps>

80106f8b <vector139>:
.globl vector139
vector139:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $139
80106f8d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106f92:	e9 68 f4 ff ff       	jmp    801063ff <alltraps>

80106f97 <vector140>:
.globl vector140
vector140:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $140
80106f99:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106f9e:	e9 5c f4 ff ff       	jmp    801063ff <alltraps>

80106fa3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $141
80106fa5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106faa:	e9 50 f4 ff ff       	jmp    801063ff <alltraps>

80106faf <vector142>:
.globl vector142
vector142:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $142
80106fb1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106fb6:	e9 44 f4 ff ff       	jmp    801063ff <alltraps>

80106fbb <vector143>:
.globl vector143
vector143:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $143
80106fbd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106fc2:	e9 38 f4 ff ff       	jmp    801063ff <alltraps>

80106fc7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $144
80106fc9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106fce:	e9 2c f4 ff ff       	jmp    801063ff <alltraps>

80106fd3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $145
80106fd5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106fda:	e9 20 f4 ff ff       	jmp    801063ff <alltraps>

80106fdf <vector146>:
.globl vector146
vector146:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $146
80106fe1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106fe6:	e9 14 f4 ff ff       	jmp    801063ff <alltraps>

80106feb <vector147>:
.globl vector147
vector147:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $147
80106fed:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106ff2:	e9 08 f4 ff ff       	jmp    801063ff <alltraps>

80106ff7 <vector148>:
.globl vector148
vector148:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $148
80106ff9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106ffe:	e9 fc f3 ff ff       	jmp    801063ff <alltraps>

80107003 <vector149>:
.globl vector149
vector149:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $149
80107005:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010700a:	e9 f0 f3 ff ff       	jmp    801063ff <alltraps>

8010700f <vector150>:
.globl vector150
vector150:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $150
80107011:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107016:	e9 e4 f3 ff ff       	jmp    801063ff <alltraps>

8010701b <vector151>:
.globl vector151
vector151:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $151
8010701d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107022:	e9 d8 f3 ff ff       	jmp    801063ff <alltraps>

80107027 <vector152>:
.globl vector152
vector152:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $152
80107029:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010702e:	e9 cc f3 ff ff       	jmp    801063ff <alltraps>

80107033 <vector153>:
.globl vector153
vector153:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $153
80107035:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010703a:	e9 c0 f3 ff ff       	jmp    801063ff <alltraps>

8010703f <vector154>:
.globl vector154
vector154:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $154
80107041:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107046:	e9 b4 f3 ff ff       	jmp    801063ff <alltraps>

8010704b <vector155>:
.globl vector155
vector155:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $155
8010704d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107052:	e9 a8 f3 ff ff       	jmp    801063ff <alltraps>

80107057 <vector156>:
.globl vector156
vector156:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $156
80107059:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010705e:	e9 9c f3 ff ff       	jmp    801063ff <alltraps>

80107063 <vector157>:
.globl vector157
vector157:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $157
80107065:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010706a:	e9 90 f3 ff ff       	jmp    801063ff <alltraps>

8010706f <vector158>:
.globl vector158
vector158:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $158
80107071:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107076:	e9 84 f3 ff ff       	jmp    801063ff <alltraps>

8010707b <vector159>:
.globl vector159
vector159:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $159
8010707d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107082:	e9 78 f3 ff ff       	jmp    801063ff <alltraps>

80107087 <vector160>:
.globl vector160
vector160:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $160
80107089:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010708e:	e9 6c f3 ff ff       	jmp    801063ff <alltraps>

80107093 <vector161>:
.globl vector161
vector161:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $161
80107095:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010709a:	e9 60 f3 ff ff       	jmp    801063ff <alltraps>

8010709f <vector162>:
.globl vector162
vector162:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $162
801070a1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070a6:	e9 54 f3 ff ff       	jmp    801063ff <alltraps>

801070ab <vector163>:
.globl vector163
vector163:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $163
801070ad:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070b2:	e9 48 f3 ff ff       	jmp    801063ff <alltraps>

801070b7 <vector164>:
.globl vector164
vector164:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $164
801070b9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801070be:	e9 3c f3 ff ff       	jmp    801063ff <alltraps>

801070c3 <vector165>:
.globl vector165
vector165:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $165
801070c5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801070ca:	e9 30 f3 ff ff       	jmp    801063ff <alltraps>

801070cf <vector166>:
.globl vector166
vector166:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $166
801070d1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801070d6:	e9 24 f3 ff ff       	jmp    801063ff <alltraps>

801070db <vector167>:
.globl vector167
vector167:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $167
801070dd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801070e2:	e9 18 f3 ff ff       	jmp    801063ff <alltraps>

801070e7 <vector168>:
.globl vector168
vector168:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $168
801070e9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801070ee:	e9 0c f3 ff ff       	jmp    801063ff <alltraps>

801070f3 <vector169>:
.globl vector169
vector169:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $169
801070f5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801070fa:	e9 00 f3 ff ff       	jmp    801063ff <alltraps>

801070ff <vector170>:
.globl vector170
vector170:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $170
80107101:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107106:	e9 f4 f2 ff ff       	jmp    801063ff <alltraps>

8010710b <vector171>:
.globl vector171
vector171:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $171
8010710d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107112:	e9 e8 f2 ff ff       	jmp    801063ff <alltraps>

80107117 <vector172>:
.globl vector172
vector172:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $172
80107119:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010711e:	e9 dc f2 ff ff       	jmp    801063ff <alltraps>

80107123 <vector173>:
.globl vector173
vector173:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $173
80107125:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010712a:	e9 d0 f2 ff ff       	jmp    801063ff <alltraps>

8010712f <vector174>:
.globl vector174
vector174:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $174
80107131:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107136:	e9 c4 f2 ff ff       	jmp    801063ff <alltraps>

8010713b <vector175>:
.globl vector175
vector175:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $175
8010713d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107142:	e9 b8 f2 ff ff       	jmp    801063ff <alltraps>

80107147 <vector176>:
.globl vector176
vector176:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $176
80107149:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010714e:	e9 ac f2 ff ff       	jmp    801063ff <alltraps>

80107153 <vector177>:
.globl vector177
vector177:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $177
80107155:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010715a:	e9 a0 f2 ff ff       	jmp    801063ff <alltraps>

8010715f <vector178>:
.globl vector178
vector178:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $178
80107161:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107166:	e9 94 f2 ff ff       	jmp    801063ff <alltraps>

8010716b <vector179>:
.globl vector179
vector179:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $179
8010716d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107172:	e9 88 f2 ff ff       	jmp    801063ff <alltraps>

80107177 <vector180>:
.globl vector180
vector180:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $180
80107179:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010717e:	e9 7c f2 ff ff       	jmp    801063ff <alltraps>

80107183 <vector181>:
.globl vector181
vector181:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $181
80107185:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010718a:	e9 70 f2 ff ff       	jmp    801063ff <alltraps>

8010718f <vector182>:
.globl vector182
vector182:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $182
80107191:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107196:	e9 64 f2 ff ff       	jmp    801063ff <alltraps>

8010719b <vector183>:
.globl vector183
vector183:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $183
8010719d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071a2:	e9 58 f2 ff ff       	jmp    801063ff <alltraps>

801071a7 <vector184>:
.globl vector184
vector184:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $184
801071a9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071ae:	e9 4c f2 ff ff       	jmp    801063ff <alltraps>

801071b3 <vector185>:
.globl vector185
vector185:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $185
801071b5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071ba:	e9 40 f2 ff ff       	jmp    801063ff <alltraps>

801071bf <vector186>:
.globl vector186
vector186:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $186
801071c1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801071c6:	e9 34 f2 ff ff       	jmp    801063ff <alltraps>

801071cb <vector187>:
.globl vector187
vector187:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $187
801071cd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801071d2:	e9 28 f2 ff ff       	jmp    801063ff <alltraps>

801071d7 <vector188>:
.globl vector188
vector188:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $188
801071d9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801071de:	e9 1c f2 ff ff       	jmp    801063ff <alltraps>

801071e3 <vector189>:
.globl vector189
vector189:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $189
801071e5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801071ea:	e9 10 f2 ff ff       	jmp    801063ff <alltraps>

801071ef <vector190>:
.globl vector190
vector190:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $190
801071f1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801071f6:	e9 04 f2 ff ff       	jmp    801063ff <alltraps>

801071fb <vector191>:
.globl vector191
vector191:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $191
801071fd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107202:	e9 f8 f1 ff ff       	jmp    801063ff <alltraps>

80107207 <vector192>:
.globl vector192
vector192:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $192
80107209:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010720e:	e9 ec f1 ff ff       	jmp    801063ff <alltraps>

80107213 <vector193>:
.globl vector193
vector193:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $193
80107215:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010721a:	e9 e0 f1 ff ff       	jmp    801063ff <alltraps>

8010721f <vector194>:
.globl vector194
vector194:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $194
80107221:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107226:	e9 d4 f1 ff ff       	jmp    801063ff <alltraps>

8010722b <vector195>:
.globl vector195
vector195:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $195
8010722d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107232:	e9 c8 f1 ff ff       	jmp    801063ff <alltraps>

80107237 <vector196>:
.globl vector196
vector196:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $196
80107239:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010723e:	e9 bc f1 ff ff       	jmp    801063ff <alltraps>

80107243 <vector197>:
.globl vector197
vector197:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $197
80107245:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010724a:	e9 b0 f1 ff ff       	jmp    801063ff <alltraps>

8010724f <vector198>:
.globl vector198
vector198:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $198
80107251:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107256:	e9 a4 f1 ff ff       	jmp    801063ff <alltraps>

8010725b <vector199>:
.globl vector199
vector199:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $199
8010725d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107262:	e9 98 f1 ff ff       	jmp    801063ff <alltraps>

80107267 <vector200>:
.globl vector200
vector200:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $200
80107269:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010726e:	e9 8c f1 ff ff       	jmp    801063ff <alltraps>

80107273 <vector201>:
.globl vector201
vector201:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $201
80107275:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010727a:	e9 80 f1 ff ff       	jmp    801063ff <alltraps>

8010727f <vector202>:
.globl vector202
vector202:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $202
80107281:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107286:	e9 74 f1 ff ff       	jmp    801063ff <alltraps>

8010728b <vector203>:
.globl vector203
vector203:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $203
8010728d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107292:	e9 68 f1 ff ff       	jmp    801063ff <alltraps>

80107297 <vector204>:
.globl vector204
vector204:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $204
80107299:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010729e:	e9 5c f1 ff ff       	jmp    801063ff <alltraps>

801072a3 <vector205>:
.globl vector205
vector205:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $205
801072a5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072aa:	e9 50 f1 ff ff       	jmp    801063ff <alltraps>

801072af <vector206>:
.globl vector206
vector206:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $206
801072b1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072b6:	e9 44 f1 ff ff       	jmp    801063ff <alltraps>

801072bb <vector207>:
.globl vector207
vector207:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $207
801072bd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801072c2:	e9 38 f1 ff ff       	jmp    801063ff <alltraps>

801072c7 <vector208>:
.globl vector208
vector208:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $208
801072c9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801072ce:	e9 2c f1 ff ff       	jmp    801063ff <alltraps>

801072d3 <vector209>:
.globl vector209
vector209:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $209
801072d5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801072da:	e9 20 f1 ff ff       	jmp    801063ff <alltraps>

801072df <vector210>:
.globl vector210
vector210:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $210
801072e1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801072e6:	e9 14 f1 ff ff       	jmp    801063ff <alltraps>

801072eb <vector211>:
.globl vector211
vector211:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $211
801072ed:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801072f2:	e9 08 f1 ff ff       	jmp    801063ff <alltraps>

801072f7 <vector212>:
.globl vector212
vector212:
  pushl $0
801072f7:	6a 00                	push   $0x0
  pushl $212
801072f9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801072fe:	e9 fc f0 ff ff       	jmp    801063ff <alltraps>

80107303 <vector213>:
.globl vector213
vector213:
  pushl $0
80107303:	6a 00                	push   $0x0
  pushl $213
80107305:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010730a:	e9 f0 f0 ff ff       	jmp    801063ff <alltraps>

8010730f <vector214>:
.globl vector214
vector214:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $214
80107311:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107316:	e9 e4 f0 ff ff       	jmp    801063ff <alltraps>

8010731b <vector215>:
.globl vector215
vector215:
  pushl $0
8010731b:	6a 00                	push   $0x0
  pushl $215
8010731d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107322:	e9 d8 f0 ff ff       	jmp    801063ff <alltraps>

80107327 <vector216>:
.globl vector216
vector216:
  pushl $0
80107327:	6a 00                	push   $0x0
  pushl $216
80107329:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010732e:	e9 cc f0 ff ff       	jmp    801063ff <alltraps>

80107333 <vector217>:
.globl vector217
vector217:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $217
80107335:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010733a:	e9 c0 f0 ff ff       	jmp    801063ff <alltraps>

8010733f <vector218>:
.globl vector218
vector218:
  pushl $0
8010733f:	6a 00                	push   $0x0
  pushl $218
80107341:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107346:	e9 b4 f0 ff ff       	jmp    801063ff <alltraps>

8010734b <vector219>:
.globl vector219
vector219:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $219
8010734d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107352:	e9 a8 f0 ff ff       	jmp    801063ff <alltraps>

80107357 <vector220>:
.globl vector220
vector220:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $220
80107359:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010735e:	e9 9c f0 ff ff       	jmp    801063ff <alltraps>

80107363 <vector221>:
.globl vector221
vector221:
  pushl $0
80107363:	6a 00                	push   $0x0
  pushl $221
80107365:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010736a:	e9 90 f0 ff ff       	jmp    801063ff <alltraps>

8010736f <vector222>:
.globl vector222
vector222:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $222
80107371:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107376:	e9 84 f0 ff ff       	jmp    801063ff <alltraps>

8010737b <vector223>:
.globl vector223
vector223:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $223
8010737d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107382:	e9 78 f0 ff ff       	jmp    801063ff <alltraps>

80107387 <vector224>:
.globl vector224
vector224:
  pushl $0
80107387:	6a 00                	push   $0x0
  pushl $224
80107389:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010738e:	e9 6c f0 ff ff       	jmp    801063ff <alltraps>

80107393 <vector225>:
.globl vector225
vector225:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $225
80107395:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010739a:	e9 60 f0 ff ff       	jmp    801063ff <alltraps>

8010739f <vector226>:
.globl vector226
vector226:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $226
801073a1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073a6:	e9 54 f0 ff ff       	jmp    801063ff <alltraps>

801073ab <vector227>:
.globl vector227
vector227:
  pushl $0
801073ab:	6a 00                	push   $0x0
  pushl $227
801073ad:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073b2:	e9 48 f0 ff ff       	jmp    801063ff <alltraps>

801073b7 <vector228>:
.globl vector228
vector228:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $228
801073b9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801073be:	e9 3c f0 ff ff       	jmp    801063ff <alltraps>

801073c3 <vector229>:
.globl vector229
vector229:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $229
801073c5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801073ca:	e9 30 f0 ff ff       	jmp    801063ff <alltraps>

801073cf <vector230>:
.globl vector230
vector230:
  pushl $0
801073cf:	6a 00                	push   $0x0
  pushl $230
801073d1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801073d6:	e9 24 f0 ff ff       	jmp    801063ff <alltraps>

801073db <vector231>:
.globl vector231
vector231:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $231
801073dd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801073e2:	e9 18 f0 ff ff       	jmp    801063ff <alltraps>

801073e7 <vector232>:
.globl vector232
vector232:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $232
801073e9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801073ee:	e9 0c f0 ff ff       	jmp    801063ff <alltraps>

801073f3 <vector233>:
.globl vector233
vector233:
  pushl $0
801073f3:	6a 00                	push   $0x0
  pushl $233
801073f5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801073fa:	e9 00 f0 ff ff       	jmp    801063ff <alltraps>

801073ff <vector234>:
.globl vector234
vector234:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $234
80107401:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107406:	e9 f4 ef ff ff       	jmp    801063ff <alltraps>

8010740b <vector235>:
.globl vector235
vector235:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $235
8010740d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107412:	e9 e8 ef ff ff       	jmp    801063ff <alltraps>

80107417 <vector236>:
.globl vector236
vector236:
  pushl $0
80107417:	6a 00                	push   $0x0
  pushl $236
80107419:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010741e:	e9 dc ef ff ff       	jmp    801063ff <alltraps>

80107423 <vector237>:
.globl vector237
vector237:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $237
80107425:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010742a:	e9 d0 ef ff ff       	jmp    801063ff <alltraps>

8010742f <vector238>:
.globl vector238
vector238:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $238
80107431:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107436:	e9 c4 ef ff ff       	jmp    801063ff <alltraps>

8010743b <vector239>:
.globl vector239
vector239:
  pushl $0
8010743b:	6a 00                	push   $0x0
  pushl $239
8010743d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107442:	e9 b8 ef ff ff       	jmp    801063ff <alltraps>

80107447 <vector240>:
.globl vector240
vector240:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $240
80107449:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010744e:	e9 ac ef ff ff       	jmp    801063ff <alltraps>

80107453 <vector241>:
.globl vector241
vector241:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $241
80107455:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010745a:	e9 a0 ef ff ff       	jmp    801063ff <alltraps>

8010745f <vector242>:
.globl vector242
vector242:
  pushl $0
8010745f:	6a 00                	push   $0x0
  pushl $242
80107461:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107466:	e9 94 ef ff ff       	jmp    801063ff <alltraps>

8010746b <vector243>:
.globl vector243
vector243:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $243
8010746d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107472:	e9 88 ef ff ff       	jmp    801063ff <alltraps>

80107477 <vector244>:
.globl vector244
vector244:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $244
80107479:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010747e:	e9 7c ef ff ff       	jmp    801063ff <alltraps>

80107483 <vector245>:
.globl vector245
vector245:
  pushl $0
80107483:	6a 00                	push   $0x0
  pushl $245
80107485:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010748a:	e9 70 ef ff ff       	jmp    801063ff <alltraps>

8010748f <vector246>:
.globl vector246
vector246:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $246
80107491:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107496:	e9 64 ef ff ff       	jmp    801063ff <alltraps>

8010749b <vector247>:
.globl vector247
vector247:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $247
8010749d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074a2:	e9 58 ef ff ff       	jmp    801063ff <alltraps>

801074a7 <vector248>:
.globl vector248
vector248:
  pushl $0
801074a7:	6a 00                	push   $0x0
  pushl $248
801074a9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074ae:	e9 4c ef ff ff       	jmp    801063ff <alltraps>

801074b3 <vector249>:
.globl vector249
vector249:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $249
801074b5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074ba:	e9 40 ef ff ff       	jmp    801063ff <alltraps>

801074bf <vector250>:
.globl vector250
vector250:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $250
801074c1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801074c6:	e9 34 ef ff ff       	jmp    801063ff <alltraps>

801074cb <vector251>:
.globl vector251
vector251:
  pushl $0
801074cb:	6a 00                	push   $0x0
  pushl $251
801074cd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801074d2:	e9 28 ef ff ff       	jmp    801063ff <alltraps>

801074d7 <vector252>:
.globl vector252
vector252:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $252
801074d9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801074de:	e9 1c ef ff ff       	jmp    801063ff <alltraps>

801074e3 <vector253>:
.globl vector253
vector253:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $253
801074e5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801074ea:	e9 10 ef ff ff       	jmp    801063ff <alltraps>

801074ef <vector254>:
.globl vector254
vector254:
  pushl $0
801074ef:	6a 00                	push   $0x0
  pushl $254
801074f1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801074f6:	e9 04 ef ff ff       	jmp    801063ff <alltraps>

801074fb <vector255>:
.globl vector255
vector255:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $255
801074fd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107502:	e9 f8 ee ff ff       	jmp    801063ff <alltraps>
80107507:	66 90                	xchg   %ax,%ax
80107509:	66 90                	xchg   %ax,%ax
8010750b:	66 90                	xchg   %ax,%ax
8010750d:	66 90                	xchg   %ax,%ax
8010750f:	90                   	nop

80107510 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	56                   	push   %esi
80107515:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107516:	89 d3                	mov    %edx,%ebx
{
80107518:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010751a:	c1 eb 16             	shr    $0x16,%ebx
8010751d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107520:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107523:	8b 06                	mov    (%esi),%eax
80107525:	a8 01                	test   $0x1,%al
80107527:	74 27                	je     80107550 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107529:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010752e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107534:	c1 ef 0a             	shr    $0xa,%edi
}
80107537:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010753a:	89 fa                	mov    %edi,%edx
8010753c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107542:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107545:	5b                   	pop    %ebx
80107546:	5e                   	pop    %esi
80107547:	5f                   	pop    %edi
80107548:	5d                   	pop    %ebp
80107549:	c3                   	ret    
8010754a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107550:	85 c9                	test   %ecx,%ecx
80107552:	74 2c                	je     80107580 <walkpgdir+0x70>
80107554:	e8 67 b5 ff ff       	call   80102ac0 <kalloc>
80107559:	85 c0                	test   %eax,%eax
8010755b:	89 c3                	mov    %eax,%ebx
8010755d:	74 21                	je     80107580 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010755f:	83 ec 04             	sub    $0x4,%esp
80107562:	68 00 10 00 00       	push   $0x1000
80107567:	6a 00                	push   $0x0
80107569:	50                   	push   %eax
8010756a:	e8 11 dc ff ff       	call   80105180 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010756f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107575:	83 c4 10             	add    $0x10,%esp
80107578:	83 c8 07             	or     $0x7,%eax
8010757b:	89 06                	mov    %eax,(%esi)
8010757d:	eb b5                	jmp    80107534 <walkpgdir+0x24>
8010757f:	90                   	nop
}
80107580:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107583:	31 c0                	xor    %eax,%eax
}
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107590 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	57                   	push   %edi
80107594:	56                   	push   %esi
80107595:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107596:	89 d3                	mov    %edx,%ebx
80107598:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010759e:	83 ec 1c             	sub    $0x1c,%esp
801075a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801075a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801075ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075b0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801075b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801075b6:	29 df                	sub    %ebx,%edi
801075b8:	83 c8 01             	or     $0x1,%eax
801075bb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801075be:	eb 15                	jmp    801075d5 <mappages+0x45>
    if(*pte & PTE_P)
801075c0:	f6 00 01             	testb  $0x1,(%eax)
801075c3:	75 45                	jne    8010760a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801075c5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801075c8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801075cb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801075cd:	74 31                	je     80107600 <mappages+0x70>
      break;
    a += PGSIZE;
801075cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801075d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801075dd:	89 da                	mov    %ebx,%edx
801075df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801075e2:	e8 29 ff ff ff       	call   80107510 <walkpgdir>
801075e7:	85 c0                	test   %eax,%eax
801075e9:	75 d5                	jne    801075c0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801075eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801075ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801075f3:	5b                   	pop    %ebx
801075f4:	5e                   	pop    %esi
801075f5:	5f                   	pop    %edi
801075f6:	5d                   	pop    %ebp
801075f7:	c3                   	ret    
801075f8:	90                   	nop
801075f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107600:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107603:	31 c0                	xor    %eax,%eax
}
80107605:	5b                   	pop    %ebx
80107606:	5e                   	pop    %esi
80107607:	5f                   	pop    %edi
80107608:	5d                   	pop    %ebp
80107609:	c3                   	ret    
      panic("remap");
8010760a:	83 ec 0c             	sub    $0xc,%esp
8010760d:	68 88 92 10 80       	push   $0x80109288
80107612:	e8 79 8d ff ff       	call   80100390 <panic>
80107617:	89 f6                	mov    %esi,%esi
80107619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107620 <seginit>:
{
80107620:	55                   	push   %ebp
80107621:	89 e5                	mov    %esp,%ebp
80107623:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107626:	e8 15 ca ff ff       	call   80104040 <cpuid>
8010762b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107631:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107636:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010763a:	c7 80 18 c8 14 80 ff 	movl   $0xffff,-0x7feb37e8(%eax)
80107641:	ff 00 00 
80107644:	c7 80 1c c8 14 80 00 	movl   $0xcf9a00,-0x7feb37e4(%eax)
8010764b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010764e:	c7 80 20 c8 14 80 ff 	movl   $0xffff,-0x7feb37e0(%eax)
80107655:	ff 00 00 
80107658:	c7 80 24 c8 14 80 00 	movl   $0xcf9200,-0x7feb37dc(%eax)
8010765f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107662:	c7 80 28 c8 14 80 ff 	movl   $0xffff,-0x7feb37d8(%eax)
80107669:	ff 00 00 
8010766c:	c7 80 2c c8 14 80 00 	movl   $0xcffa00,-0x7feb37d4(%eax)
80107673:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107676:	c7 80 30 c8 14 80 ff 	movl   $0xffff,-0x7feb37d0(%eax)
8010767d:	ff 00 00 
80107680:	c7 80 34 c8 14 80 00 	movl   $0xcff200,-0x7feb37cc(%eax)
80107687:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010768a:	05 10 c8 14 80       	add    $0x8014c810,%eax
  pd[1] = (uint)p;
8010768f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107693:	c1 e8 10             	shr    $0x10,%eax
80107696:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010769a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010769d:	0f 01 10             	lgdtl  (%eax)
}
801076a0:	c9                   	leave  
801076a1:	c3                   	ret    
801076a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076b0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076b0:	a1 c4 9b 15 80       	mov    0x80159bc4,%eax
{
801076b5:	55                   	push   %ebp
801076b6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076b8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076bd:	0f 22 d8             	mov    %eax,%cr3
}
801076c0:	5d                   	pop    %ebp
801076c1:	c3                   	ret    
801076c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076d0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 1c             	sub    $0x1c,%esp
801076d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801076dc:	85 db                	test   %ebx,%ebx
801076de:	0f 84 cb 00 00 00    	je     801077af <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801076e4:	8b 43 08             	mov    0x8(%ebx),%eax
801076e7:	85 c0                	test   %eax,%eax
801076e9:	0f 84 da 00 00 00    	je     801077c9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801076ef:	8b 43 04             	mov    0x4(%ebx),%eax
801076f2:	85 c0                	test   %eax,%eax
801076f4:	0f 84 c2 00 00 00    	je     801077bc <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
801076fa:	e8 a1 d8 ff ff       	call   80104fa0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801076ff:	e8 bc c8 ff ff       	call   80103fc0 <mycpu>
80107704:	89 c6                	mov    %eax,%esi
80107706:	e8 b5 c8 ff ff       	call   80103fc0 <mycpu>
8010770b:	89 c7                	mov    %eax,%edi
8010770d:	e8 ae c8 ff ff       	call   80103fc0 <mycpu>
80107712:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107715:	83 c7 08             	add    $0x8,%edi
80107718:	e8 a3 c8 ff ff       	call   80103fc0 <mycpu>
8010771d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107720:	83 c0 08             	add    $0x8,%eax
80107723:	ba 67 00 00 00       	mov    $0x67,%edx
80107728:	c1 e8 18             	shr    $0x18,%eax
8010772b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107732:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107739:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010773f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107744:	83 c1 08             	add    $0x8,%ecx
80107747:	c1 e9 10             	shr    $0x10,%ecx
8010774a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107750:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107755:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010775c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107761:	e8 5a c8 ff ff       	call   80103fc0 <mycpu>
80107766:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010776d:	e8 4e c8 ff ff       	call   80103fc0 <mycpu>
80107772:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107776:	8b 73 08             	mov    0x8(%ebx),%esi
80107779:	e8 42 c8 ff ff       	call   80103fc0 <mycpu>
8010777e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107784:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107787:	e8 34 c8 ff ff       	call   80103fc0 <mycpu>
8010778c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107790:	b8 28 00 00 00       	mov    $0x28,%eax
80107795:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107798:	8b 43 04             	mov    0x4(%ebx),%eax
8010779b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077a0:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801077a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077a6:	5b                   	pop    %ebx
801077a7:	5e                   	pop    %esi
801077a8:	5f                   	pop    %edi
801077a9:	5d                   	pop    %ebp
  popcli();
801077aa:	e9 31 d8 ff ff       	jmp    80104fe0 <popcli>
    panic("switchuvm: no process");
801077af:	83 ec 0c             	sub    $0xc,%esp
801077b2:	68 8e 92 10 80       	push   $0x8010928e
801077b7:	e8 d4 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801077bc:	83 ec 0c             	sub    $0xc,%esp
801077bf:	68 b9 92 10 80       	push   $0x801092b9
801077c4:	e8 c7 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801077c9:	83 ec 0c             	sub    $0xc,%esp
801077cc:	68 a4 92 10 80       	push   $0x801092a4
801077d1:	e8 ba 8b ff ff       	call   80100390 <panic>
801077d6:	8d 76 00             	lea    0x0(%esi),%esi
801077d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077e0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801077e0:	55                   	push   %ebp
801077e1:	89 e5                	mov    %esp,%ebp
801077e3:	57                   	push   %edi
801077e4:	56                   	push   %esi
801077e5:	53                   	push   %ebx
801077e6:	83 ec 1c             	sub    $0x1c,%esp
801077e9:	8b 75 10             	mov    0x10(%ebp),%esi
801077ec:	8b 45 08             	mov    0x8(%ebp),%eax
801077ef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801077f2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801077f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801077fb:	77 49                	ja     80107846 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
801077fd:	e8 be b2 ff ff       	call   80102ac0 <kalloc>
  memset(mem, 0, PGSIZE);
80107802:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107805:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107807:	68 00 10 00 00       	push   $0x1000
8010780c:	6a 00                	push   $0x0
8010780e:	50                   	push   %eax
8010780f:	e8 6c d9 ff ff       	call   80105180 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107814:	58                   	pop    %eax
80107815:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010781b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107820:	5a                   	pop    %edx
80107821:	6a 06                	push   $0x6
80107823:	50                   	push   %eax
80107824:	31 d2                	xor    %edx,%edx
80107826:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107829:	e8 62 fd ff ff       	call   80107590 <mappages>
  memmove(mem, init, sz);
8010782e:	89 75 10             	mov    %esi,0x10(%ebp)
80107831:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107834:	83 c4 10             	add    $0x10,%esp
80107837:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010783a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010783d:	5b                   	pop    %ebx
8010783e:	5e                   	pop    %esi
8010783f:	5f                   	pop    %edi
80107840:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107841:	e9 ea d9 ff ff       	jmp    80105230 <memmove>
    panic("inituvm: more than a page");
80107846:	83 ec 0c             	sub    $0xc,%esp
80107849:	68 cd 92 10 80       	push   $0x801092cd
8010784e:	e8 3d 8b ff ff       	call   80100390 <panic>
80107853:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107860 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107860:	55                   	push   %ebp
80107861:	89 e5                	mov    %esp,%ebp
80107863:	57                   	push   %edi
80107864:	56                   	push   %esi
80107865:	53                   	push   %ebx
80107866:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107869:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107870:	0f 85 91 00 00 00    	jne    80107907 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107876:	8b 75 18             	mov    0x18(%ebp),%esi
80107879:	31 db                	xor    %ebx,%ebx
8010787b:	85 f6                	test   %esi,%esi
8010787d:	75 1a                	jne    80107899 <loaduvm+0x39>
8010787f:	eb 6f                	jmp    801078f0 <loaduvm+0x90>
80107881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107888:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010788e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107894:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107897:	76 57                	jbe    801078f0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107899:	8b 55 0c             	mov    0xc(%ebp),%edx
8010789c:	8b 45 08             	mov    0x8(%ebp),%eax
8010789f:	31 c9                	xor    %ecx,%ecx
801078a1:	01 da                	add    %ebx,%edx
801078a3:	e8 68 fc ff ff       	call   80107510 <walkpgdir>
801078a8:	85 c0                	test   %eax,%eax
801078aa:	74 4e                	je     801078fa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801078ac:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078ae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801078b1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801078b6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801078bb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801078c1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078c4:	01 d9                	add    %ebx,%ecx
801078c6:	05 00 00 00 80       	add    $0x80000000,%eax
801078cb:	57                   	push   %edi
801078cc:	51                   	push   %ecx
801078cd:	50                   	push   %eax
801078ce:	ff 75 10             	pushl  0x10(%ebp)
801078d1:	e8 9a a2 ff ff       	call   80101b70 <readi>
801078d6:	83 c4 10             	add    $0x10,%esp
801078d9:	39 f8                	cmp    %edi,%eax
801078db:	74 ab                	je     80107888 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801078dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078e5:	5b                   	pop    %ebx
801078e6:	5e                   	pop    %esi
801078e7:	5f                   	pop    %edi
801078e8:	5d                   	pop    %ebp
801078e9:	c3                   	ret    
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078f3:	31 c0                	xor    %eax,%eax
}
801078f5:	5b                   	pop    %ebx
801078f6:	5e                   	pop    %esi
801078f7:	5f                   	pop    %edi
801078f8:	5d                   	pop    %ebp
801078f9:	c3                   	ret    
      panic("loaduvm: address should exist");
801078fa:	83 ec 0c             	sub    $0xc,%esp
801078fd:	68 e7 92 10 80       	push   $0x801092e7
80107902:	e8 89 8a ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107907:	83 ec 0c             	sub    $0xc,%esp
8010790a:	68 10 94 10 80       	push   $0x80109410
8010790f:	e8 7c 8a ff ff       	call   80100390 <panic>
80107914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010791a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107920 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107920:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107921:	31 c9                	xor    %ecx,%ecx
{
80107923:	89 e5                	mov    %esp,%ebp
80107925:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107928:	8b 55 0c             	mov    0xc(%ebp),%edx
8010792b:	8b 45 08             	mov    0x8(%ebp),%eax
8010792e:	e8 dd fb ff ff       	call   80107510 <walkpgdir>
  if(pte == 0)
80107933:	85 c0                	test   %eax,%eax
80107935:	74 05                	je     8010793c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107937:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010793a:	c9                   	leave  
8010793b:	c3                   	ret    
    panic("clearpteu");
8010793c:	83 ec 0c             	sub    $0xc,%esp
8010793f:	68 05 93 10 80       	push   $0x80109305
80107944:	e8 47 8a ff ff       	call   80100390 <panic>
80107949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107950 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107950:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107951:	31 c9                	xor    %ecx,%ecx
{
80107953:	89 e5                	mov    %esp,%ebp
80107955:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107958:	8b 55 0c             	mov    0xc(%ebp),%edx
8010795b:	8b 45 08             	mov    0x8(%ebp),%eax
8010795e:	e8 ad fb ff ff       	call   80107510 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107963:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107965:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107966:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107968:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010796d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107970:	05 00 00 00 80       	add    $0x80000000,%eax
80107975:	83 fa 05             	cmp    $0x5,%edx
80107978:	ba 00 00 00 00       	mov    $0x0,%edx
8010797d:	0f 45 c2             	cmovne %edx,%eax
}
80107980:	c3                   	ret    
80107981:	eb 0d                	jmp    80107990 <copyout>
80107983:	90                   	nop
80107984:	90                   	nop
80107985:	90                   	nop
80107986:	90                   	nop
80107987:	90                   	nop
80107988:	90                   	nop
80107989:	90                   	nop
8010798a:	90                   	nop
8010798b:	90                   	nop
8010798c:	90                   	nop
8010798d:	90                   	nop
8010798e:	90                   	nop
8010798f:	90                   	nop

80107990 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107990:	55                   	push   %ebp
80107991:	89 e5                	mov    %esp,%ebp
80107993:	57                   	push   %edi
80107994:	56                   	push   %esi
80107995:	53                   	push   %ebx
80107996:	83 ec 1c             	sub    $0x1c,%esp
80107999:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010799c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010799f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801079a2:	85 db                	test   %ebx,%ebx
801079a4:	75 40                	jne    801079e6 <copyout+0x56>
801079a6:	eb 70                	jmp    80107a18 <copyout+0x88>
801079a8:	90                   	nop
801079a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801079b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801079b3:	89 f1                	mov    %esi,%ecx
801079b5:	29 d1                	sub    %edx,%ecx
801079b7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801079bd:	39 d9                	cmp    %ebx,%ecx
801079bf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801079c2:	29 f2                	sub    %esi,%edx
801079c4:	83 ec 04             	sub    $0x4,%esp
801079c7:	01 d0                	add    %edx,%eax
801079c9:	51                   	push   %ecx
801079ca:	57                   	push   %edi
801079cb:	50                   	push   %eax
801079cc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801079cf:	e8 5c d8 ff ff       	call   80105230 <memmove>
    len -= n;
    buf += n;
801079d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801079d7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801079da:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801079e0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801079e2:	29 cb                	sub    %ecx,%ebx
801079e4:	74 32                	je     80107a18 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801079e6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801079e8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801079eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801079ee:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801079f4:	56                   	push   %esi
801079f5:	ff 75 08             	pushl  0x8(%ebp)
801079f8:	e8 53 ff ff ff       	call   80107950 <uva2ka>
    if(pa0 == 0)
801079fd:	83 c4 10             	add    $0x10,%esp
80107a00:	85 c0                	test   %eax,%eax
80107a02:	75 ac                	jne    801079b0 <copyout+0x20>
  }
  return 0;
}
80107a04:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a0c:	5b                   	pop    %ebx
80107a0d:	5e                   	pop    %esi
80107a0e:	5f                   	pop    %edi
80107a0f:	5d                   	pop    %ebp
80107a10:	c3                   	ret    
80107a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a18:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a1b:	31 c0                	xor    %eax,%eax
}
80107a1d:	5b                   	pop    %ebx
80107a1e:	5e                   	pop    %esi
80107a1f:	5f                   	pop    %edi
80107a20:	5d                   	pop    %ebp
80107a21:	c3                   	ret    
80107a22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a30 <leastAgeIndex>:
/***************************************************************************************************************************************************************/
/******************************************************************************   NFUA     *********************************************************************/
/***************************************************************************************************************************************************************/

int
leastAgeIndex(){
80107a30:	55                   	push   %ebp
80107a31:	89 e5                	mov    %esp,%ebp
80107a33:	57                   	push   %edi
80107a34:	56                   	push   %esi
80107a35:	53                   	push   %ebx
80107a36:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107a39:	e8 22 c6 ff ff       	call   80104060 <myproc>
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
80107a3e:	8b b8 80 00 00 00    	mov    0x80(%eax),%edi
80107a44:	85 ff                	test   %edi,%edi
80107a46:	7e 3f                	jle    80107a87 <leastAgeIndex+0x57>
80107a48:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
80107a4e:	31 c9                	xor    %ecx,%ecx
  int leastIndex = -1;
80107a50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint leastAge = __UINT32_MAX__;
80107a55:	be ff ff ff ff       	mov    $0xffffffff,%esi
80107a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
80107a60:	8b 5a 04             	mov    0x4(%edx),%ebx
80107a63:	39 f3                	cmp    %esi,%ebx
80107a65:	77 09                	ja     80107a70 <leastAgeIndex+0x40>
80107a67:	83 3a ff             	cmpl   $0xffffffff,(%edx)
80107a6a:	0f 45 c1             	cmovne %ecx,%eax
80107a6d:	0f 45 f3             	cmovne %ebx,%esi
  for(i = 0; i < p->nPgsPhysical ; i++){
80107a70:	83 c1 01             	add    $0x1,%ecx
80107a73:	83 c2 14             	add    $0x14,%edx
80107a76:	39 f9                	cmp    %edi,%ecx
80107a78:	75 e6                	jne    80107a60 <leastAgeIndex+0x30>
    }
  }



  if(leastIndex == -1){
80107a7a:	83 f8 ff             	cmp    $0xffffffff,%eax
80107a7d:	74 08                	je     80107a87 <leastAgeIndex+0x57>
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;

}
80107a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a82:	5b                   	pop    %ebx
80107a83:	5e                   	pop    %esi
80107a84:	5f                   	pop    %edi
80107a85:	5d                   	pop    %ebp
80107a86:	c3                   	ret    
    panic("IndexMaxAgePG : could not find age >= 0");
80107a87:	83 ec 0c             	sub    $0xc,%esp
80107a8a:	68 34 94 10 80       	push   $0x80109434
80107a8f:	e8 fc 88 ff ff       	call   80100390 <panic>
80107a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107aa0 <addSwappedNode>:
/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/

void
addSwappedNode(char* addr){
80107aa0:	55                   	push   %ebp
80107aa1:	89 e5                	mov    %esp,%ebp
80107aa3:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc();
80107aa6:	e8 b5 c5 ff ff       	call   80104060 <myproc>
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107aab:	31 d2                	xor    %edx,%edx
80107aad:	8d 88 a8 00 00 00    	lea    0xa8(%eax),%ecx
80107ab3:	eb 0e                	jmp    80107ac3 <addSwappedNode+0x23>
80107ab5:	8d 76 00             	lea    0x0(%esi),%esi
80107ab8:	83 c2 01             	add    $0x1,%edx
80107abb:	83 c1 14             	add    $0x14,%ecx
    if(i== MAX_PSYC_PAGES){
80107abe:	83 fa 10             	cmp    $0x10,%edx
80107ac1:	74 2d                	je     80107af0 <addSwappedNode+0x50>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == EMPTY_VA){
80107ac3:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107ac6:	75 f0                	jne    80107ab8 <addSwappedNode+0x18>
      p->swappedPGs[i].offset = i*PGSIZE;
80107ac8:	8d 0c 92             	lea    (%edx,%edx,4),%ecx
80107acb:	c1 e2 0c             	shl    $0xc,%edx
80107ace:	8d 0c 88             	lea    (%eax,%ecx,4),%ecx
      p->swappedPGs[i].va =(char*)PGROUNDDOWN((uint)addr);
80107ad1:	8b 45 08             	mov    0x8(%ebp),%eax
      p->swappedPGs[i].offset = i*PGSIZE;
80107ad4:	89 91 98 00 00 00    	mov    %edx,0x98(%ecx)
      p->swappedPGs[i].va =(char*)PGROUNDDOWN((uint)addr);
80107ada:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107adf:	89 81 a8 00 00 00    	mov    %eax,0xa8(%ecx)
      return;
    }
  }
}
80107ae5:	c9                   	leave  
80107ae6:	c3                   	ret    
80107ae7:	89 f6                	mov    %esi,%esi
80107ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107af0:	83 ec 0c             	sub    $0xc,%esp
80107af3:	68 5c 94 10 80       	push   $0x8010945c
80107af8:	e8 93 88 ff ff       	call   80100390 <panic>
80107afd:	8d 76 00             	lea    0x0(%esi),%esi

80107b00 <addPhysicalNode>:
  }
}


void
addPhysicalNode(uint addr){
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	57                   	push   %edi
80107b04:	56                   	push   %esi
80107b05:	53                   	push   %ebx
80107b06:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107b09:	e8 52 c5 ff ff       	call   80104060 <myproc>
  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107b0e:	31 d2                	xor    %edx,%edx
80107b10:	8d 88 d8 01 00 00    	lea    0x1d8(%eax),%ecx
80107b16:	eb 17                	jmp    80107b2f <addPhysicalNode+0x2f>
80107b18:	90                   	nop
80107b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b20:	83 c2 01             	add    $0x1,%edx
80107b23:	83 c1 14             	add    $0x14,%ecx
    if(i==MAX_PSYC_PAGES){
80107b26:	83 fa 10             	cmp    $0x10,%edx
80107b29:	0f 84 c9 00 00 00    	je     80107bf8 <addPhysicalNode+0xf8>
      panic("addPhysicalNode: cannot allocate phy page");
    }
    if(p->physicalPGs[i].va == EMPTY_VA){
80107b2f:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107b32:	75 ec                	jne    80107b20 <addPhysicalNode+0x20>
      //cprintf("added %x i: %d   pid: %d\n",PGROUNDDOWN(addr),i,myproc()->pid);
      p->physicalPGs[i].va = (char*)PGROUNDDOWN(addr);
80107b34:	8d 0c 92             	lea    (%edx,%edx,4),%ecx
80107b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
80107b3a:	8d 0c 88             	lea    (%eax,%ecx,4),%ecx
80107b3d:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107b43:	89 99 d8 01 00 00    	mov    %ebx,0x1d8(%ecx)
      p->physicalPGs[i].age = 0;
80107b49:	c7 81 dc 01 00 00 00 	movl   $0x0,0x1dc(%ecx)
80107b50:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80107b53:	c7 81 e0 01 00 00 01 	movl   $0x1,0x1e0(%ecx)
80107b5a:	00 00 00 
      
      #ifdef SCFIFO
        if(p->headPG == -1){
80107b5d:	8b 98 94 00 00 00    	mov    0x94(%eax),%ebx
80107b63:	83 fb ff             	cmp    $0xffffffff,%ebx
80107b66:	0f 84 9c 00 00 00    	je     80107c08 <addPhysicalNode+0x108>
          p->physicalPGs[i].prev = 0;
          p->physicalPGs[i].next = 0;
        }
        if(p->headPG == i){
80107b6c:	39 d3                	cmp    %edx,%ebx
80107b6e:	0f 84 aa 00 00 00    	je     80107c1e <addPhysicalNode+0x11e>
          cprintf("i: %d\n",i);
          panic("wtf");
        return;
      }
        if(p->physicalPGs[i].prev){
80107b74:	8b b1 e8 01 00 00    	mov    0x1e8(%ecx),%esi
80107b7a:	8b 99 e4 01 00 00    	mov    0x1e4(%ecx),%ebx
80107b80:	85 f6                	test   %esi,%esi
80107b82:	74 09                	je     80107b8d <addPhysicalNode+0x8d>
          p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
80107b84:	89 5e 0c             	mov    %ebx,0xc(%esi)
80107b87:	8b 99 e4 01 00 00    	mov    0x1e4(%ecx),%ebx
        }
        if(p->physicalPGs[i].next){
80107b8d:	85 db                	test   %ebx,%ebx
80107b8f:	74 0d                	je     80107b9e <addPhysicalNode+0x9e>
          p->physicalPGs[i].next->prev = p->physicalPGs[i].prev;
80107b91:	8d 0c 92             	lea    (%edx,%edx,4),%ecx
80107b94:	8b 8c 88 e8 01 00 00 	mov    0x1e8(%eax,%ecx,4),%ecx
80107b9b:	89 4b 10             	mov    %ecx,0x10(%ebx)
80107b9e:	8b 98 94 00 00 00    	mov    0x94(%eax),%ebx
        }
        p->physicalPGs[i].next = &p->physicalPGs[p->headPG];
80107ba4:	8d 34 92             	lea    (%edx,%edx,4),%esi
80107ba7:	8d 0c 9b             	lea    (%ebx,%ebx,4),%ecx
80107baa:	c1 e6 02             	shl    $0x2,%esi
80107bad:	c1 e1 02             	shl    $0x2,%ecx
80107bb0:	8d 3c 30             	lea    (%eax,%esi,1),%edi
80107bb3:	8d 9c 08 d8 01 00 00 	lea    0x1d8(%eax,%ecx,1),%ebx
80107bba:	89 9f e4 01 00 00    	mov    %ebx,0x1e4(%edi)
        p->physicalPGs[p->headPG].prev = &p->physicalPGs[i];
80107bc0:	8d 9c 30 d8 01 00 00 	lea    0x1d8(%eax,%esi,1),%ebx
80107bc7:	89 9c 08 e8 01 00 00 	mov    %ebx,0x1e8(%eax,%ecx,1)
        p->physicalPGs[i].prev = 0;
80107bce:	c7 87 e8 01 00 00 00 	movl   $0x0,0x1e8(%edi)
80107bd5:	00 00 00 
        p->headPG = i;
80107bd8:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
      #endif

      myproc()->nPgsPhysical++;
80107bde:	e8 7d c4 ff ff       	call   80104060 <myproc>
80107be3:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
      return;
    }
  }
}
80107bea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bed:	5b                   	pop    %ebx
80107bee:	5e                   	pop    %esi
80107bef:	5f                   	pop    %edi
80107bf0:	5d                   	pop    %ebp
80107bf1:	c3                   	ret    
80107bf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      panic("addPhysicalNode: cannot allocate phy page");
80107bf8:	83 ec 0c             	sub    $0xc,%esp
80107bfb:	68 90 94 10 80       	push   $0x80109490
80107c00:	e8 8b 87 ff ff       	call   80100390 <panic>
80107c05:	8d 76 00             	lea    0x0(%esi),%esi
          p->physicalPGs[i].prev = 0;
80107c08:	c7 81 e8 01 00 00 00 	movl   $0x0,0x1e8(%ecx)
80107c0f:	00 00 00 
          p->physicalPGs[i].next = 0;
80107c12:	c7 81 e4 01 00 00 00 	movl   $0x0,0x1e4(%ecx)
80107c19:	00 00 00 
80107c1c:	eb 86                	jmp    80107ba4 <addPhysicalNode+0xa4>
          cprintf("i: %d\n",i);
80107c1e:	50                   	push   %eax
80107c1f:	50                   	push   %eax
80107c20:	52                   	push   %edx
80107c21:	68 0f 93 10 80       	push   $0x8010930f
80107c26:	e8 35 8a ff ff       	call   80100660 <cprintf>
          panic("wtf");
80107c2b:	c7 04 24 16 93 10 80 	movl   $0x80109316,(%esp)
80107c32:	e8 59 87 ff ff       	call   80100390 <panic>
80107c37:	89 f6                	mov    %esi,%esi
80107c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c40 <clearSwapPage>:


void
clearSwapPage(int index){
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	53                   	push   %ebx
80107c44:	83 ec 04             	sub    $0x4,%esp
80107c47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107c4a:	e8 11 c4 ff ff       	call   80104060 <myproc>
  p->nPgsSwap--;
80107c4f:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
  p->swappedPGs[index].va = EMPTY_VA;
80107c56:	8d 14 9b             	lea    (%ebx,%ebx,4),%edx
80107c59:	c7 84 90 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%edx,4)
80107c60:	ff ff ff ff 
}
80107c64:	83 c4 04             	add    $0x4,%esp
80107c67:	5b                   	pop    %ebx
80107c68:	5d                   	pop    %ebp
80107c69:	c3                   	ret    
80107c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c70 <indexInSwapFile>:

int
indexInSwapFile(uint addr){
80107c70:	55                   	push   %ebp
80107c71:	89 e5                	mov    %esp,%ebp
80107c73:	57                   	push   %edi
80107c74:	56                   	push   %esi
80107c75:	53                   	push   %ebx
80107c76:	83 ec 0c             	sub    $0xc,%esp
  
  struct proc *p =myproc();
80107c79:	e8 e2 c3 ff ff       	call   80104060 <myproc>
80107c7e:	8b 75 08             	mov    0x8(%ebp),%esi
80107c81:	8d 90 a8 00 00 00    	lea    0xa8(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107c87:	31 c9                	xor    %ecx,%ecx
80107c89:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107c8f:	eb 12                	jmp    80107ca3 <indexInSwapFile+0x33>
80107c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c98:	83 c1 01             	add    $0x1,%ecx
80107c9b:	83 c2 14             	add    $0x14,%edx
80107c9e:	83 f9 10             	cmp    $0x10,%ecx
80107ca1:	74 15                	je     80107cb8 <indexInSwapFile+0x48>
    if(p->swappedPGs[i].va == (char*) PGROUNDDOWN(addr)){
80107ca3:	39 32                	cmp    %esi,(%edx)
80107ca5:	75 f1                	jne    80107c98 <indexInSwapFile+0x28>

    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107ca7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107caa:	89 c8                	mov    %ecx,%eax
80107cac:	5b                   	pop    %ebx
80107cad:	5e                   	pop    %esi
80107cae:	5f                   	pop    %edi
80107caf:	5d                   	pop    %ebp
80107cb0:	c3                   	ret    
80107cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cb8:	8d 98 d8 01 00 00    	lea    0x1d8(%eax),%ebx
80107cbe:	8d b8 18 03 00 00    	lea    0x318(%eax),%edi
80107cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
80107cc8:	83 ec 04             	sub    $0x4,%esp
80107ccb:	83 c3 14             	add    $0x14,%ebx
80107cce:	56                   	push   %esi
80107ccf:	ff 73 ec             	pushl  -0x14(%ebx)
80107cd2:	68 1a 93 10 80       	push   $0x8010931a
80107cd7:	e8 84 89 ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107cdc:	83 c4 10             	add    $0x10,%esp
80107cdf:	39 fb                	cmp    %edi,%ebx
80107ce1:	75 e5                	jne    80107cc8 <indexInSwapFile+0x58>
  panic("scfifoSwap: could not find page in swap file");
80107ce3:	83 ec 0c             	sub    $0xc,%esp
80107ce6:	68 bc 94 10 80       	push   $0x801094bc
80107ceb:	e8 a0 86 ff ff       	call   80100390 <panic>

80107cf0 <indexInPhysicalMem>:

int
indexInPhysicalMem(uint addr){
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	53                   	push   %ebx
80107cf4:	83 ec 04             	sub    $0x4,%esp
80107cf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p =myproc();
80107cfa:	e8 61 c3 ff ff       	call   80104060 <myproc>
80107cff:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107d05:	31 c0                	xor    %eax,%eax
80107d07:	89 d9                	mov    %ebx,%ecx
80107d09:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107d0f:	eb 12                	jmp    80107d23 <indexInPhysicalMem+0x33>
80107d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d18:	83 c0 01             	add    $0x1,%eax
80107d1b:	83 c2 14             	add    $0x14,%edx
80107d1e:	83 f8 10             	cmp    $0x10,%eax
80107d21:	74 0d                	je     80107d30 <indexInPhysicalMem+0x40>
    if(p->physicalPGs[i].va == (char*) PGROUNDDOWN(addr)){
80107d23:	39 0a                	cmp    %ecx,(%edx)
80107d25:	75 f1                	jne    80107d18 <indexInPhysicalMem+0x28>
    }
  }
  cprintf("tried find : %x\n",addr);
  panic("scfifoSwap: could not find page in physical mem");
  return -1;
}
80107d27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107d2a:	c9                   	leave  
80107d2b:	c3                   	ret    
80107d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  cprintf("tried find : %x\n",addr);
80107d30:	83 ec 08             	sub    $0x8,%esp
80107d33:	53                   	push   %ebx
80107d34:	68 31 93 10 80       	push   $0x80109331
80107d39:	e8 22 89 ff ff       	call   80100660 <cprintf>
  panic("scfifoSwap: could not find page in physical mem");
80107d3e:	c7 04 24 ec 94 10 80 	movl   $0x801094ec,(%esp)
80107d45:	e8 46 86 ff ff       	call   80100390 <panic>
80107d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d50 <scfifoLastPageIndex>:
scfifoLastPageIndex(){
80107d50:	55                   	push   %ebp
80107d51:	89 e5                	mov    %esp,%ebp
80107d53:	57                   	push   %edi
80107d54:	56                   	push   %esi
80107d55:	53                   	push   %ebx
80107d56:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107d59:	e8 02 c3 ff ff       	call   80104060 <myproc>
  struct procPG *page = &p->physicalPGs[p->headPG];
80107d5e:	8b 88 94 00 00 00    	mov    0x94(%eax),%ecx
  struct proc *p = myproc();
80107d64:	89 c6                	mov    %eax,%esi
  struct procPG *page = &p->physicalPGs[p->headPG];
80107d66:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107d69:	c1 e0 02             	shl    $0x2,%eax
80107d6c:	8d 9c 06 d8 01 00 00 	lea    0x1d8(%esi,%eax,1),%ebx
  if(!page->next){
80107d73:	8b 84 06 e4 01 00 00 	mov    0x1e4(%esi,%eax,1),%eax
80107d7a:	85 c0                	test   %eax,%eax
80107d7c:	0f 84 9a 00 00 00    	je     80107e1c <scfifoLastPageIndex+0xcc>
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80107d82:	83 be 80 00 00 00 01 	cmpl   $0x1,0x80(%esi)
80107d89:	ba 01 00 00 00       	mov    $0x1,%edx
80107d8e:	7f 0f                	jg     80107d9f <scfifoLastPageIndex+0x4f>
80107d90:	eb 24                	jmp    80107db6 <scfifoLastPageIndex+0x66>
80107d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107d98:	8b 43 0c             	mov    0xc(%ebx),%eax
80107d9b:	85 c0                	test   %eax,%eax
80107d9d:	74 11                	je     80107db0 <scfifoLastPageIndex+0x60>
      page->next->prev = page;
80107d9f:	89 58 10             	mov    %ebx,0x10(%eax)
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80107da2:	83 c2 01             	add    $0x1,%edx
80107da5:	39 96 80 00 00 00    	cmp    %edx,0x80(%esi)
      page = page->next;
80107dab:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  for(i = 1; i < p->nPgsPhysical && (page->next); i++)
80107dae:	7f e8                	jg     80107d98 <scfifoLastPageIndex+0x48>
80107db0:	8b 8e 94 00 00 00    	mov    0x94(%esi),%ecx
  p->physicalPGs[p->headPG].prev = page;
80107db6:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107db9:	89 9c 86 e8 01 00 00 	mov    %ebx,0x1e8(%esi,%eax,4)
  uint tailVa = (uint) page->va;
80107dc0:	8b 13                	mov    (%ebx),%edx
80107dc2:	89 d7                	mov    %edx,%edi
80107dc4:	eb 18                	jmp    80107dde <scfifoLastPageIndex+0x8e>
80107dc6:	8d 76 00             	lea    0x0(%esi),%esi
80107dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *pte &= ~PTE_A;
80107dd0:	83 e2 df             	and    $0xffffffdf,%edx
80107dd3:	89 10                	mov    %edx,(%eax)
    page = page->prev;
80107dd5:	8b 5b 10             	mov    0x10(%ebx),%ebx
  }while ((uint)page->va != tailVa);
80107dd8:	8b 13                	mov    (%ebx),%edx
80107dda:	39 fa                	cmp    %edi,%edx
80107ddc:	74 2a                	je     80107e08 <scfifoLastPageIndex+0xb8>
    pte = walkpgdir(p->pgdir,(void*)page->va,0);
80107dde:	8b 46 04             	mov    0x4(%esi),%eax
80107de1:	31 c9                	xor    %ecx,%ecx
80107de3:	e8 28 f7 ff ff       	call   80107510 <walkpgdir>
    if(*pte & PTE_A){
80107de8:	8b 10                	mov    (%eax),%edx
80107dea:	f6 c2 20             	test   $0x20,%dl
80107ded:	75 e1                	jne    80107dd0 <scfifoLastPageIndex+0x80>
      return indexInPhysicalMem((uint)page->va);
80107def:	83 ec 0c             	sub    $0xc,%esp
80107df2:	ff 33                	pushl  (%ebx)
80107df4:	e8 f7 fe ff ff       	call   80107cf0 <indexInPhysicalMem>
80107df9:	83 c4 10             	add    $0x10,%esp
}
80107dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107dff:	5b                   	pop    %ebx
80107e00:	5e                   	pop    %esi
80107e01:	5f                   	pop    %edi
80107e02:	5d                   	pop    %ebp
80107e03:	c3                   	ret    
80107e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return indexInPhysicalMem((uint)page->va);
80107e08:	83 ec 0c             	sub    $0xc,%esp
80107e0b:	52                   	push   %edx
80107e0c:	e8 df fe ff ff       	call   80107cf0 <indexInPhysicalMem>
80107e11:	83 c4 10             	add    $0x10,%esp
}
80107e14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e17:	5b                   	pop    %ebx
80107e18:	5e                   	pop    %esi
80107e19:	5f                   	pop    %edi
80107e1a:	5d                   	pop    %ebp
80107e1b:	c3                   	ret    
    panic("getLastPG: empty headPG list");
80107e1c:	83 ec 0c             	sub    $0xc,%esp
80107e1f:	68 42 93 10 80       	push   $0x80109342
80107e24:	e8 67 85 ff ff       	call   80100390 <panic>
80107e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107e30 <removePhysicalNode>:
removePhysicalNode(char* va){
80107e30:	55                   	push   %ebp
80107e31:	89 e5                	mov    %esp,%ebp
80107e33:	56                   	push   %esi
80107e34:	53                   	push   %ebx
  struct proc *p = myproc();
80107e35:	e8 26 c2 ff ff       	call   80104060 <myproc>
80107e3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107e3d:	89 c6                	mov    %eax,%esi
80107e3f:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107e45:	31 c0                	xor    %eax,%eax
80107e47:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107e4d:	eb 0c                	jmp    80107e5b <removePhysicalNode+0x2b>
80107e4f:	90                   	nop
80107e50:	83 c0 01             	add    $0x1,%eax
80107e53:	83 c2 14             	add    $0x14,%edx
    if(i==MAX_PSYC_PAGES){
80107e56:	83 f8 10             	cmp    $0x10,%eax
80107e59:	74 65                	je     80107ec0 <removePhysicalNode+0x90>
    if(p->physicalPGs[i].va ==(char*) PGROUNDDOWN((uint)va)){
80107e5b:	39 0a                	cmp    %ecx,(%edx)
80107e5d:	75 f1                	jne    80107e50 <removePhysicalNode+0x20>
      p->physicalPGs[i].va = EMPTY_VA;
80107e5f:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107e62:	8d 1c 96             	lea    (%esi,%edx,4),%ebx
80107e65:	c7 83 d8 01 00 00 ff 	movl   $0xffffffff,0x1d8(%ebx)
80107e6c:	ff ff ff 
      p->physicalPGs[i].age = 0;
80107e6f:	c7 83 dc 01 00 00 00 	movl   $0x0,0x1dc(%ebx)
80107e76:	00 00 00 
      p->physicalPGs[i].alloceted = 0;
80107e79:	c7 83 e0 01 00 00 00 	movl   $0x0,0x1e0(%ebx)
80107e80:	00 00 00 
      if(p->headPG == i){
80107e83:	39 86 94 00 00 00    	cmp    %eax,0x94(%esi)
80107e89:	74 45                	je     80107ed0 <removePhysicalNode+0xa0>
      if(p->physicalPGs[i].prev){
80107e8b:	8b 8b e8 01 00 00    	mov    0x1e8(%ebx),%ecx
80107e91:	8b 93 e4 01 00 00    	mov    0x1e4(%ebx),%edx
80107e97:	85 c9                	test   %ecx,%ecx
80107e99:	74 09                	je     80107ea4 <removePhysicalNode+0x74>
        p->physicalPGs[i].prev->next = p->physicalPGs[i].next;
80107e9b:	89 51 0c             	mov    %edx,0xc(%ecx)
80107e9e:	8b 93 e4 01 00 00    	mov    0x1e4(%ebx),%edx
      if(p->physicalPGs[i].next){
80107ea4:	85 d2                	test   %edx,%edx
80107ea6:	74 0d                	je     80107eb5 <removePhysicalNode+0x85>
        p->physicalPGs[i].next->prev = p->physicalPGs[i].prev;
80107ea8:	8d 04 80             	lea    (%eax,%eax,4),%eax
80107eab:	8b 84 86 e8 01 00 00 	mov    0x1e8(%esi,%eax,4),%eax
80107eb2:	89 42 10             	mov    %eax,0x10(%edx)
}
80107eb5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107eb8:	5b                   	pop    %ebx
80107eb9:	5e                   	pop    %esi
80107eba:	5d                   	pop    %ebp
80107ebb:	c3                   	ret    
80107ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("removePhysicalNode: cannot find phy page");
80107ec0:	83 ec 0c             	sub    $0xc,%esp
80107ec3:	68 1c 95 10 80       	push   $0x8010951c
80107ec8:	e8 c3 84 ff ff       	call   80100390 <panic>
80107ecd:	8d 76 00             	lea    0x0(%esi),%esi
        p->headPG = indexInPhysicalMem((uint)p->physicalPGs[i].next->va);
80107ed0:	8b 83 e4 01 00 00    	mov    0x1e4(%ebx),%eax
80107ed6:	83 ec 0c             	sub    $0xc,%esp
80107ed9:	ff 30                	pushl  (%eax)
80107edb:	e8 10 fe ff ff       	call   80107cf0 <indexInPhysicalMem>
80107ee0:	89 86 94 00 00 00    	mov    %eax,0x94(%esi)
        p->physicalPGs[i].next->prev = (void*)0;
80107ee6:	8b 83 e4 01 00 00    	mov    0x1e4(%ebx),%eax
        return;
80107eec:	83 c4 10             	add    $0x10,%esp
        p->physicalPGs[i].next->prev = (void*)0;
80107eef:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        return;
80107ef6:	eb bd                	jmp    80107eb5 <removePhysicalNode+0x85>
80107ef8:	90                   	nop
80107ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107f00 <deallocuvm.part.1>:
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f00:	55                   	push   %ebp
80107f01:	89 e5                	mov    %esp,%ebp
80107f03:	57                   	push   %edi
80107f04:	56                   	push   %esi
  a = PGROUNDUP(newsz);
80107f05:	8d b1 ff 0f 00 00    	lea    0xfff(%ecx),%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f0b:	53                   	push   %ebx
  a = PGROUNDUP(newsz);
80107f0c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f12:	83 ec 2c             	sub    $0x2c,%esp
80107f15:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f18:	39 d6                	cmp    %edx,%esi
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107f1a:	89 55 dc             	mov    %edx,-0x24(%ebp)
80107f1d:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107f20:	72 1b                	jb     80107f3d <deallocuvm.part.1+0x3d>
80107f22:	eb 43                	jmp    80107f67 <deallocuvm.part.1+0x67>
80107f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if((*pte & PTE_P) != 0){
80107f28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107f2b:	8b 18                	mov    (%eax),%ebx
80107f2d:	f6 c3 01             	test   $0x1,%bl
80107f30:	75 46                	jne    80107f78 <deallocuvm.part.1+0x78>
  for(; a  < oldsz; a += PGSIZE){
80107f32:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107f38:	3b 75 dc             	cmp    -0x24(%ebp),%esi
80107f3b:	73 2a                	jae    80107f67 <deallocuvm.part.1+0x67>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107f3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107f40:	31 c9                	xor    %ecx,%ecx
80107f42:	89 f2                	mov    %esi,%edx
80107f44:	e8 c7 f5 ff ff       	call   80107510 <walkpgdir>
    if(!pte)
80107f49:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
80107f4b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(!pte)
80107f4e:	75 d8                	jne    80107f28 <deallocuvm.part.1+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107f50:	81 e6 00 00 c0 ff    	and    $0xffc00000,%esi
80107f56:	81 c6 00 f0 3f 00    	add    $0x3ff000,%esi
  for(; a  < oldsz; a += PGSIZE){
80107f5c:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107f62:	3b 75 dc             	cmp    -0x24(%ebp),%esi
80107f65:	72 d6                	jb     80107f3d <deallocuvm.part.1+0x3d>
}
80107f67:	8b 45 d0             	mov    -0x30(%ebp),%eax
80107f6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f6d:	5b                   	pop    %ebx
80107f6e:	5e                   	pop    %esi
80107f6f:	5f                   	pop    %edi
80107f70:	5d                   	pop    %ebp
80107f71:	c3                   	ret    
80107f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(pa == 0)
80107f78:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107f7e:	0f 84 a1 00 00 00    	je     80108025 <deallocuvm.part.1+0x125>
      char *v = P2V(pa);
80107f84:	8d bb 00 00 00 80    	lea    -0x80000000(%ebx),%edi
      kfree(v);
80107f8a:	83 ec 0c             	sub    $0xc,%esp
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80107f8d:	31 db                	xor    %ebx,%ebx
      kfree(v);
80107f8f:	57                   	push   %edi
      char *v = P2V(pa);
80107f90:	89 7d d4             	mov    %edi,-0x2c(%ebp)
      kfree(v);
80107f93:	e8 18 a9 ff ff       	call   801028b0 <kfree>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80107f98:	89 75 d8             	mov    %esi,-0x28(%ebp)
      kfree(v);
80107f9b:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80107f9e:	89 de                	mov    %ebx,%esi
80107fa0:	89 fb                	mov    %edi,%ebx
80107fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          if(myproc()->physicalPGs[i].va == (char*)v){
80107fa8:	8d 3c b6             	lea    (%esi,%esi,4),%edi
80107fab:	e8 b0 c0 ff ff       	call   80104060 <myproc>
80107fb0:	c1 e7 02             	shl    $0x2,%edi
80107fb3:	3b 9c 38 d8 01 00 00 	cmp    0x1d8(%eax,%edi,1),%ebx
80107fba:	74 2c                	je     80107fe8 <deallocuvm.part.1+0xe8>
          }if(myproc()->swappedPGs[i].va == (char*)v){
80107fbc:	e8 9f c0 ff ff       	call   80104060 <myproc>
80107fc1:	3b 9c 38 a8 00 00 00 	cmp    0xa8(%eax,%edi,1),%ebx
80107fc8:	74 36                	je     80108000 <deallocuvm.part.1+0x100>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80107fca:	83 c6 01             	add    $0x1,%esi
80107fcd:	83 fe 10             	cmp    $0x10,%esi
80107fd0:	75 d6                	jne    80107fa8 <deallocuvm.part.1+0xa8>
80107fd2:	8b 75 d8             	mov    -0x28(%ebp),%esi
      *pte = 0;
80107fd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107fd8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107fde:	e9 4f ff ff ff       	jmp    80107f32 <deallocuvm.part.1+0x32>
80107fe3:	90                   	nop
80107fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            removePhysicalNode(v);
80107fe8:	83 ec 0c             	sub    $0xc,%esp
80107feb:	ff 75 d4             	pushl  -0x2c(%ebp)
80107fee:	8b 75 d8             	mov    -0x28(%ebp),%esi
80107ff1:	e8 3a fe ff ff       	call   80107e30 <removePhysicalNode>
80107ff6:	83 c4 10             	add    $0x10,%esp
80107ff9:	eb da                	jmp    80107fd5 <deallocuvm.part.1+0xd5>
80107ffb:	90                   	nop
80107ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108000:	8b 75 d8             	mov    -0x28(%ebp),%esi
            myproc()->swappedPGs[i].va = (char*) 0xffffffff;
80108003:	e8 58 c0 ff ff       	call   80104060 <myproc>
80108008:	c7 84 38 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%edi,1)
8010800f:	ff ff ff ff 
            myproc()->swappedPGs[i].offset = -1;
80108013:	e8 48 c0 ff ff       	call   80104060 <myproc>
80108018:	c7 84 38 98 00 00 00 	movl   $0xffffffff,0x98(%eax,%edi,1)
8010801f:	ff ff ff ff 
80108023:	eb b0                	jmp    80107fd5 <deallocuvm.part.1+0xd5>
        panic("kfree");
80108025:	83 ec 0c             	sub    $0xc,%esp
80108028:	68 5f 93 10 80       	push   $0x8010935f
8010802d:	e8 5e 83 ff ff       	call   80100390 <panic>
80108032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108040 <deallocuvm>:
{
80108040:	55                   	push   %ebp
80108041:	89 e5                	mov    %esp,%ebp
80108043:	8b 55 0c             	mov    0xc(%ebp),%edx
80108046:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108049:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz){
8010804c:	39 d1                	cmp    %edx,%ecx
8010804e:	73 10                	jae    80108060 <deallocuvm+0x20>
}
80108050:	5d                   	pop    %ebp
80108051:	e9 aa fe ff ff       	jmp    80107f00 <deallocuvm.part.1>
80108056:	8d 76 00             	lea    0x0(%esi),%esi
80108059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108060:	89 d0                	mov    %edx,%eax
80108062:	5d                   	pop    %ebp
80108063:	c3                   	ret    
80108064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010806a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108070 <freevm>:
{
80108070:	55                   	push   %ebp
80108071:	89 e5                	mov    %esp,%ebp
80108073:	57                   	push   %edi
80108074:	56                   	push   %esi
80108075:	53                   	push   %ebx
80108076:	83 ec 0c             	sub    $0xc,%esp
80108079:	8b 75 08             	mov    0x8(%ebp),%esi
  if(pgdir == 0)
8010807c:	85 f6                	test   %esi,%esi
8010807e:	74 59                	je     801080d9 <freevm+0x69>
80108080:	31 c9                	xor    %ecx,%ecx
80108082:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108087:	89 f0                	mov    %esi,%eax
80108089:	e8 72 fe ff ff       	call   80107f00 <deallocuvm.part.1>
8010808e:	89 f3                	mov    %esi,%ebx
80108090:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108096:	eb 0f                	jmp    801080a7 <freevm+0x37>
80108098:	90                   	nop
80108099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080a0:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
801080a3:	39 fb                	cmp    %edi,%ebx
801080a5:	74 23                	je     801080ca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801080a7:	8b 03                	mov    (%ebx),%eax
801080a9:	a8 01                	test   $0x1,%al
801080ab:	74 f3                	je     801080a0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801080ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
801080b2:	83 ec 0c             	sub    $0xc,%esp
801080b5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801080b8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801080bd:	50                   	push   %eax
801080be:	e8 ed a7 ff ff       	call   801028b0 <kfree>
801080c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801080c6:	39 fb                	cmp    %edi,%ebx
801080c8:	75 dd                	jne    801080a7 <freevm+0x37>
  kfree((char*)pgdir);
801080ca:	89 75 08             	mov    %esi,0x8(%ebp)
}
801080cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080d0:	5b                   	pop    %ebx
801080d1:	5e                   	pop    %esi
801080d2:	5f                   	pop    %edi
801080d3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801080d4:	e9 d7 a7 ff ff       	jmp    801028b0 <kfree>
    panic("freevm: no pgdir");
801080d9:	83 ec 0c             	sub    $0xc,%esp
801080dc:	68 65 93 10 80       	push   $0x80109365
801080e1:	e8 aa 82 ff ff       	call   80100390 <panic>
801080e6:	8d 76 00             	lea    0x0(%esi),%esi
801080e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801080f0 <setupkvm>:
{
801080f0:	55                   	push   %ebp
801080f1:	89 e5                	mov    %esp,%ebp
801080f3:	56                   	push   %esi
801080f4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801080f5:	e8 c6 a9 ff ff       	call   80102ac0 <kalloc>
801080fa:	85 c0                	test   %eax,%eax
801080fc:	89 c6                	mov    %eax,%esi
801080fe:	74 42                	je     80108142 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80108100:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108103:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80108108:	68 00 10 00 00       	push   $0x1000
8010810d:	6a 00                	push   $0x0
8010810f:	50                   	push   %eax
80108110:	e8 6b d0 ff ff       	call   80105180 <memset>
80108115:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80108118:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010811b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010811e:	83 ec 08             	sub    $0x8,%esp
80108121:	8b 13                	mov    (%ebx),%edx
80108123:	ff 73 0c             	pushl  0xc(%ebx)
80108126:	50                   	push   %eax
80108127:	29 c1                	sub    %eax,%ecx
80108129:	89 f0                	mov    %esi,%eax
8010812b:	e8 60 f4 ff ff       	call   80107590 <mappages>
80108130:	83 c4 10             	add    $0x10,%esp
80108133:	85 c0                	test   %eax,%eax
80108135:	78 19                	js     80108150 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108137:	83 c3 10             	add    $0x10,%ebx
8010813a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108140:	75 d6                	jne    80108118 <setupkvm+0x28>
}
80108142:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108145:	89 f0                	mov    %esi,%eax
80108147:	5b                   	pop    %ebx
80108148:	5e                   	pop    %esi
80108149:	5d                   	pop    %ebp
8010814a:	c3                   	ret    
8010814b:	90                   	nop
8010814c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108150:	83 ec 0c             	sub    $0xc,%esp
80108153:	56                   	push   %esi
      return 0;
80108154:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80108156:	e8 15 ff ff ff       	call   80108070 <freevm>
      return 0;
8010815b:	83 c4 10             	add    $0x10,%esp
}
8010815e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108161:	89 f0                	mov    %esi,%eax
80108163:	5b                   	pop    %ebx
80108164:	5e                   	pop    %esi
80108165:	5d                   	pop    %ebp
80108166:	c3                   	ret    
80108167:	89 f6                	mov    %esi,%esi
80108169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108170 <kvmalloc>:
{
80108170:	55                   	push   %ebp
80108171:	89 e5                	mov    %esp,%ebp
80108173:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108176:	e8 75 ff ff ff       	call   801080f0 <setupkvm>
8010817b:	a3 c4 9b 15 80       	mov    %eax,0x80159bc4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108180:	05 00 00 00 80       	add    $0x80000000,%eax
80108185:	0f 22 d8             	mov    %eax,%cr3
}
80108188:	c9                   	leave  
80108189:	c3                   	ret    
8010818a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108190 <copyuvm>:
{
80108190:	55                   	push   %ebp
80108191:	89 e5                	mov    %esp,%ebp
80108193:	57                   	push   %edi
80108194:	56                   	push   %esi
80108195:	53                   	push   %ebx
80108196:	83 ec 1c             	sub    $0x1c,%esp
  if((d = setupkvm()) == 0)
80108199:	e8 52 ff ff ff       	call   801080f0 <setupkvm>
8010819e:	85 c0                	test   %eax,%eax
801081a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801081a3:	0f 84 29 01 00 00    	je     801082d2 <copyuvm+0x142>
  for(i = 0; i < sz; i += PGSIZE){
801081a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801081ac:	85 c9                	test   %ecx,%ecx
801081ae:	0f 84 50 01 00 00    	je     80108304 <copyuvm+0x174>
801081b4:	31 db                	xor    %ebx,%ebx
801081b6:	eb 65                	jmp    8010821d <copyuvm+0x8d>
801081b8:	90                   	nop
801081b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(*pte & PTE_PG){
801081c0:	f6 c4 02             	test   $0x2,%ah
801081c3:	0f 85 17 01 00 00    	jne    801082e0 <copyuvm+0x150>
    *pte = *pte & ~PTE_W;
801081c9:	89 c2                	mov    %eax,%edx
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801081cb:	83 ec 08             	sub    $0x8,%esp
801081ce:	b9 00 10 00 00       	mov    $0x1000,%ecx
    *pte = *pte & ~PTE_W;
801081d3:	83 e2 fd             	and    $0xfffffffd,%edx
    *pte = *pte | PTE_COW;
801081d6:	80 ce 08             	or     $0x8,%dh
801081d9:	89 16                	mov    %edx,(%esi)
801081db:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
801081dd:	25 fd 0f 00 00       	and    $0xffd,%eax
801081e2:	80 cc 08             	or     $0x8,%ah
801081e5:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801081eb:	89 da                	mov    %ebx,%edx
801081ed:	50                   	push   %eax
801081ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801081f1:	56                   	push   %esi
801081f2:	e8 99 f3 ff ff       	call   80107590 <mappages>
801081f7:	83 c4 10             	add    $0x10,%esp
801081fa:	85 c0                	test   %eax,%eax
801081fc:	0f 88 b0 00 00 00    	js     801082b2 <copyuvm+0x122>
    incrementReferenceCount(pa);
80108202:	83 ec 0c             	sub    $0xc,%esp
80108205:	56                   	push   %esi
80108206:	e8 f5 a9 ff ff       	call   80102c00 <incrementReferenceCount>
8010820b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
8010820e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108214:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80108217:	0f 86 e7 00 00 00    	jbe    80108304 <copyuvm+0x174>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
8010821d:	8b 45 08             	mov    0x8(%ebp),%eax
80108220:	31 c9                	xor    %ecx,%ecx
80108222:	89 da                	mov    %ebx,%edx
80108224:	e8 e7 f2 ff ff       	call   80107510 <walkpgdir>
80108229:	85 c0                	test   %eax,%eax
8010822b:	89 c6                	mov    %eax,%esi
8010822d:	0f 84 e7 00 00 00    	je     8010831a <copyuvm+0x18a>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
80108233:	f7 00 01 02 00 00    	testl  $0x201,(%eax)
80108239:	0f 84 e8 00 00 00    	je     80108327 <copyuvm+0x197>
    if(myproc()->pid>2){
8010823f:	e8 1c be ff ff       	call   80104060 <myproc>
80108244:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
    if(*pte & PTE_PG){
80108248:	8b 06                	mov    (%esi),%eax
    if(myproc()->pid>2){
8010824a:	0f 8f 70 ff ff ff    	jg     801081c0 <copyuvm+0x30>
      pa = PTE_ADDR(*pte);
80108250:	89 c7                	mov    %eax,%edi
      flags = PTE_FLAGS(*pte);
80108252:	25 ff 0f 00 00       	and    $0xfff,%eax
      pa = PTE_ADDR(*pte);
80108257:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
      flags = PTE_FLAGS(*pte);
8010825d:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if((mem = kalloc()) == 0)
80108260:	e8 5b a8 ff ff       	call   80102ac0 <kalloc>
80108265:	85 c0                	test   %eax,%eax
80108267:	89 c6                	mov    %eax,%esi
80108269:	74 47                	je     801082b2 <copyuvm+0x122>
      memmove(mem, (char*)P2V(pa), PGSIZE);
8010826b:	83 ec 04             	sub    $0x4,%esp
8010826e:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108274:	68 00 10 00 00       	push   $0x1000
80108279:	57                   	push   %edi
8010827a:	50                   	push   %eax
8010827b:	e8 b0 cf ff ff       	call   80105230 <memmove>
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108280:	58                   	pop    %eax
80108281:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108287:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010828c:	5a                   	pop    %edx
8010828d:	ff 75 e0             	pushl  -0x20(%ebp)
80108290:	50                   	push   %eax
80108291:	89 da                	mov    %ebx,%edx
80108293:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108296:	e8 f5 f2 ff ff       	call   80107590 <mappages>
8010829b:	83 c4 10             	add    $0x10,%esp
8010829e:	85 c0                	test   %eax,%eax
801082a0:	0f 89 68 ff ff ff    	jns    8010820e <copyuvm+0x7e>
      kfree(mem);
801082a6:	83 ec 0c             	sub    $0xc,%esp
801082a9:	56                   	push   %esi
801082aa:	e8 01 a6 ff ff       	call   801028b0 <kfree>
      goto bad;
801082af:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801082b2:	83 ec 0c             	sub    $0xc,%esp
801082b5:	ff 75 e4             	pushl  -0x1c(%ebp)
801082b8:	e8 b3 fd ff ff       	call   80108070 <freevm>
  lcr3(V2P(pgdir));
801082bd:	8b 45 08             	mov    0x8(%ebp),%eax
801082c0:	05 00 00 00 80       	add    $0x80000000,%eax
801082c5:	0f 22 d8             	mov    %eax,%cr3
  return 0;
801082c8:	83 c4 10             	add    $0x10,%esp
801082cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
801082d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801082d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801082d8:	5b                   	pop    %ebx
801082d9:	5e                   	pop    %esi
801082da:	5f                   	pop    %edi
801082db:	5d                   	pop    %ebp
801082dc:	c3                   	ret    
801082dd:	8d 76 00             	lea    0x0(%esi),%esi
      pte = walkpgdir(d,(void*)i,1);
801082e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801082e3:	89 da                	mov    %ebx,%edx
801082e5:	b9 01 00 00 00       	mov    $0x1,%ecx
  for(i = 0; i < sz; i += PGSIZE){
801082ea:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      pte = walkpgdir(d,(void*)i,1);
801082f0:	e8 1b f2 ff ff       	call   80107510 <walkpgdir>
  for(i = 0; i < sz; i += PGSIZE){
801082f5:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
      *pte= PTE_U | PTE_W | PTE_PG;
801082f8:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  for(i = 0; i < sz; i += PGSIZE){
801082fe:	0f 87 19 ff ff ff    	ja     8010821d <copyuvm+0x8d>
  lcr3(V2P(pgdir));
80108304:	8b 45 08             	mov    0x8(%ebp),%eax
80108307:	05 00 00 00 80       	add    $0x80000000,%eax
8010830c:	0f 22 d8             	mov    %eax,%cr3
}
8010830f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108312:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108315:	5b                   	pop    %ebx
80108316:	5e                   	pop    %esi
80108317:	5f                   	pop    %edi
80108318:	5d                   	pop    %ebp
80108319:	c3                   	ret    
      panic("copyuvm: pte should exist");
8010831a:	83 ec 0c             	sub    $0xc,%esp
8010831d:	68 76 93 10 80       	push   $0x80109376
80108322:	e8 69 80 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80108327:	83 ec 0c             	sub    $0xc,%esp
8010832a:	68 90 93 10 80       	push   $0x80109390
8010832f:	e8 5c 80 ff ff       	call   80100390 <panic>
80108334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010833a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108340 <scfifoWriteToSwap>:
scfifoWriteToSwap(uint addr){/************************************************************************ SCFIFO :  write ******************************************/
80108340:	55                   	push   %ebp
80108341:	89 e5                	mov    %esp,%ebp
80108343:	57                   	push   %edi
80108344:	56                   	push   %esi
80108345:	53                   	push   %ebx
80108346:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80108349:	e8 12 bd ff ff       	call   80104060 <myproc>
8010834e:	89 c6                	mov    %eax,%esi
  struct procPG *lastPG = &p->physicalPGs[scfifoLastPageIndex()];
80108350:	e8 fb f9 ff ff       	call   80107d50 <scfifoLastPageIndex>
80108355:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
  pte_t *pte = walkpgdir(p->pgdir, (void*)lastPG->va, 0);
80108358:	31 c9                	xor    %ecx,%ecx
  struct procPG *lastPG = &p->physicalPGs[scfifoLastPageIndex()];
8010835a:	c1 e3 02             	shl    $0x2,%ebx
8010835d:	8d 84 1e d8 01 00 00 	lea    0x1d8(%esi,%ebx,1),%eax
  pte_t *pte = walkpgdir(p->pgdir, (void*)lastPG->va, 0);
80108364:	01 f3                	add    %esi,%ebx
80108366:	8b 93 d8 01 00 00    	mov    0x1d8(%ebx),%edx
  struct procPG *lastPG = &p->physicalPGs[scfifoLastPageIndex()];
8010836c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  pte_t *pte = walkpgdir(p->pgdir, (void*)lastPG->va, 0);
8010836f:	8b 46 04             	mov    0x4(%esi),%eax
80108372:	e8 99 f1 ff ff       	call   80107510 <walkpgdir>
  addSwappedNode(lastPG->va);
80108377:	83 ec 0c             	sub    $0xc,%esp
8010837a:	ff b3 d8 01 00 00    	pushl  0x1d8(%ebx)
  pte_t *pte = walkpgdir(p->pgdir, (void*)lastPG->va, 0);
80108380:	89 c7                	mov    %eax,%edi
  addSwappedNode(lastPG->va);
80108382:	e8 19 f7 ff ff       	call   80107aa0 <addSwappedNode>
  int offset = p->swappedPGs[indexInSwapFile((uint)lastPG->va)].offset;
80108387:	8b 8b d8 01 00 00    	mov    0x1d8(%ebx),%ecx
8010838d:	89 0c 24             	mov    %ecx,(%esp)
80108390:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80108393:	e8 d8 f8 ff ff       	call   80107c70 <indexInSwapFile>
  if(writeToSwapFile(p,(char*)PTE_ADDR(tempVa),offset, PGSIZE)<=0){
80108398:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  int offset = p->swappedPGs[indexInSwapFile((uint)lastPG->va)].offset;
8010839b:	8d 04 80             	lea    (%eax,%eax,4),%eax
  if(writeToSwapFile(p,(char*)PTE_ADDR(tempVa),offset, PGSIZE)<=0){
8010839e:	68 00 10 00 00       	push   $0x1000
801083a3:	ff b4 86 98 00 00 00 	pushl  0x98(%esi,%eax,4)
801083aa:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801083b0:	51                   	push   %ecx
801083b1:	56                   	push   %esi
801083b2:	e8 a9 a0 ff ff       	call   80102460 <writeToSwapFile>
801083b7:	83 c4 20             	add    $0x20,%esp
801083ba:	85 c0                	test   %eax,%eax
801083bc:	7e 41                	jle    801083ff <scfifoWriteToSwap+0xbf>
  kfree((char*)(P2V(PTE_ADDR(*pte))));
801083be:	8b 07                	mov    (%edi),%eax
801083c0:	83 ec 0c             	sub    $0xc,%esp
801083c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801083c8:	05 00 00 00 80       	add    $0x80000000,%eax
801083cd:	50                   	push   %eax
801083ce:	e8 dd a4 ff ff       	call   801028b0 <kfree>
  *pte &= ~PTE_P;
801083d3:	8b 07                	mov    (%edi),%eax
801083d5:	83 e0 fe             	and    $0xfffffffe,%eax
801083d8:	80 cc 02             	or     $0x2,%ah
801083db:	89 07                	mov    %eax,(%edi)
  removePhysicalNode(lastPG->va);
801083dd:	58                   	pop    %eax
801083de:	ff b3 d8 01 00 00    	pushl  0x1d8(%ebx)
801083e4:	e8 47 fa ff ff       	call   80107e30 <removePhysicalNode>
  lcr3(V2P(p->pgdir));  // switch to process's address space
801083e9:	8b 46 04             	mov    0x4(%esi),%eax
801083ec:	05 00 00 00 80       	add    $0x80000000,%eax
801083f1:	0f 22 d8             	mov    %eax,%cr3
}
801083f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801083f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801083fa:	5b                   	pop    %ebx
801083fb:	5e                   	pop    %esi
801083fc:	5f                   	pop    %edi
801083fd:	5d                   	pop    %ebp
801083fe:	c3                   	ret    
    panic("scfifoWriteToSwap: writeToSwapFile");
801083ff:	83 ec 0c             	sub    $0xc,%esp
80108402:	68 48 95 10 80       	push   $0x80109548
80108407:	e8 84 7f ff ff       	call   80100390 <panic>
8010840c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108410 <nfuaWriteToSwap>:
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
80108410:	55                   	push   %ebp
80108411:	89 e5                	mov    %esp,%ebp
80108413:	57                   	push   %edi
80108414:	56                   	push   %esi
80108415:	53                   	push   %ebx
80108416:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80108419:	e8 42 bc ff ff       	call   80104060 <myproc>
8010841e:	89 c6                	mov    %eax,%esi
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80108420:	e8 0b f6 ff ff       	call   80107a30 <leastAgeIndex>
80108425:	8d 1c 80             	lea    (%eax,%eax,4),%ebx
80108428:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
8010842b:	31 c9                	xor    %ecx,%ecx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
8010842d:	c1 e3 02             	shl    $0x2,%ebx
80108430:	8d 84 1e d8 01 00 00 	lea    0x1d8(%esi,%ebx,1),%eax
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80108437:	01 f3                	add    %esi,%ebx
80108439:	8b 93 d8 01 00 00    	mov    0x1d8(%ebx),%edx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
8010843f:	89 45 e0             	mov    %eax,-0x20(%ebp)
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80108442:	8b 46 04             	mov    0x4(%esi),%eax
80108445:	e8 c6 f0 ff ff       	call   80107510 <walkpgdir>
  addSwappedNode(leastAgePG->va);
8010844a:	83 ec 0c             	sub    $0xc,%esp
8010844d:	ff b3 d8 01 00 00    	pushl  0x1d8(%ebx)
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80108453:	89 c7                	mov    %eax,%edi
  addSwappedNode(leastAgePG->va);
80108455:	e8 46 f6 ff ff       	call   80107aa0 <addSwappedNode>
  acquire(&tickslock);
8010845a:	c7 04 24 80 93 15 80 	movl   $0x80159380,(%esp)
80108461:	e8 0a cc ff ff       	call   80105070 <acquire>
  if(*pte & PTE_A){
80108466:	8b 07                	mov    (%edi),%eax
80108468:	83 c4 10             	add    $0x10,%esp
8010846b:	a8 20                	test   $0x20,%al
8010846d:	74 05                	je     80108474 <nfuaWriteToSwap+0x64>
    *pte &= ~PTE_A;
8010846f:	83 e0 df             	and    $0xffffffdf,%eax
80108472:	89 07                	mov    %eax,(%edi)
  release(&tickslock);
80108474:	83 ec 0c             	sub    $0xc,%esp
80108477:	68 80 93 15 80       	push   $0x80159380
8010847c:	e8 af cc ff ff       	call   80105130 <release>
  int offset = p->swappedPGs[indexInSwapFile((uint)leastAgePG->va)].offset;
80108481:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108484:	5a                   	pop    %edx
80108485:	8d 04 80             	lea    (%eax,%eax,4),%eax
80108488:	8d 1c 86             	lea    (%esi,%eax,4),%ebx
8010848b:	ff b3 d8 01 00 00    	pushl  0x1d8(%ebx)
80108491:	e8 da f7 ff ff       	call   80107c70 <indexInSwapFile>
80108496:	8d 04 80             	lea    (%eax,%eax,4),%eax
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),offset, PGSIZE)<=0){
80108499:	68 00 10 00 00       	push   $0x1000
8010849e:	ff b4 86 98 00 00 00 	pushl  0x98(%esi,%eax,4)
801084a5:	8b 83 d8 01 00 00    	mov    0x1d8(%ebx),%eax
801084ab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084b0:	50                   	push   %eax
801084b1:	56                   	push   %esi
801084b2:	e8 a9 9f ff ff       	call   80102460 <writeToSwapFile>
801084b7:	83 c4 20             	add    $0x20,%esp
801084ba:	85 c0                	test   %eax,%eax
801084bc:	7e 41                	jle    801084ff <nfuaWriteToSwap+0xef>
  kfree((char*)(P2V(PTE_ADDR(*pte))));
801084be:	8b 07                	mov    (%edi),%eax
801084c0:	83 ec 0c             	sub    $0xc,%esp
801084c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801084c8:	05 00 00 00 80       	add    $0x80000000,%eax
801084cd:	50                   	push   %eax
801084ce:	e8 dd a3 ff ff       	call   801028b0 <kfree>
  *pte &= ~PTE_P;
801084d3:	8b 07                	mov    (%edi),%eax
801084d5:	83 e0 fe             	and    $0xfffffffe,%eax
801084d8:	80 cc 02             	or     $0x2,%ah
801084db:	89 07                	mov    %eax,(%edi)
  removePhysicalNode(leastAgePG->va);
801084dd:	58                   	pop    %eax
801084de:	ff b3 d8 01 00 00    	pushl  0x1d8(%ebx)
801084e4:	e8 47 f9 ff ff       	call   80107e30 <removePhysicalNode>
  lcr3(V2P(p->pgdir));  // switch to process's address space
801084e9:	8b 46 04             	mov    0x4(%esi),%eax
801084ec:	05 00 00 00 80       	add    $0x80000000,%eax
801084f1:	0f 22 d8             	mov    %eax,%cr3
}
801084f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084fa:	5b                   	pop    %ebx
801084fb:	5e                   	pop    %esi
801084fc:	5f                   	pop    %edi
801084fd:	5d                   	pop    %ebp
801084fe:	c3                   	ret    
    panic("scfifoWriteToSwap: writeToSwapFile");
801084ff:	83 ec 0c             	sub    $0xc,%esp
80108502:	68 48 95 10 80       	push   $0x80109548
80108507:	e8 84 7e ff ff       	call   80100390 <panic>
8010850c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108510 <writePageToSwapFile>:


// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
80108510:	55                   	push   %ebp
80108511:	89 e5                	mov    %esp,%ebp
80108513:	53                   	push   %ebx
80108514:	83 ec 10             	sub    $0x10,%esp
  //cprintf("write %x\n",va);
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap((uint)va);
80108517:	ff 75 08             	pushl  0x8(%ebp)
8010851a:	e8 21 fe ff ff       	call   80108340 <scfifoWriteToSwap>
8010851f:	89 c3                	mov    %eax,%ebx
  #endif
  #ifdef NFUA
    retPG=nfuaWriteToSwap((uint)va);
  #endif
  myproc()->nPgsPhysical--;
80108521:	e8 3a bb ff ff       	call   80104060 <myproc>
80108526:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
  myproc()->nTotalPGout++;
8010852d:	e8 2e bb ff ff       	call   80104060 <myproc>
80108532:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
  myproc()->nPgsSwap++;
80108539:	e8 22 bb ff ff       	call   80104060 <myproc>
8010853e:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}
80108545:	89 d8                	mov    %ebx,%eax
80108547:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010854a:	c9                   	leave  
8010854b:	c3                   	ret    
8010854c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108550 <scfifoSwap>:
scfifoSwap(uint addr){/******************************************************************************** SCFIFO :  swap ******************************************/
80108550:	55                   	push   %ebp
80108551:	89 e5                	mov    %esp,%ebp
80108553:	57                   	push   %edi
80108554:	56                   	push   %esi
80108555:	53                   	push   %ebx
80108556:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80108559:	e8 02 bb ff ff       	call   80104060 <myproc>
  int swapIndex = indexInSwapFile(addr);
8010855e:	83 ec 0c             	sub    $0xc,%esp
80108561:	ff 75 08             	pushl  0x8(%ebp)
  struct proc *p = myproc();
80108564:	89 c3                	mov    %eax,%ebx
  int swapIndex = indexInSwapFile(addr);
80108566:	e8 05 f7 ff ff       	call   80107c70 <indexInSwapFile>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
8010856b:	83 c4 10             	add    $0x10,%esp
8010856e:	83 bb 80 00 00 00 0f 	cmpl   $0xf,0x80(%ebx)
  int swapIndex = indexInSwapFile(addr);
80108575:	89 c7                	mov    %eax,%edi
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80108577:	0f 8f b3 00 00 00    	jg     80108630 <scfifoSwap+0xe0>
  if((buf = kalloc()) == 0){
8010857d:	e8 3e a5 ff ff       	call   80102ac0 <kalloc>
80108582:	85 c0                	test   %eax,%eax
80108584:	89 c6                	mov    %eax,%esi
80108586:	0f 84 c4 00 00 00    	je     80108650 <scfifoSwap+0x100>
  memset(buf, 0, PGSIZE );
8010858c:	83 ec 04             	sub    $0x4,%esp
8010858f:	68 00 10 00 00       	push   $0x1000
80108594:	6a 00                	push   $0x0
80108596:	50                   	push   %eax
80108597:	e8 e4 cb ff ff       	call   80105180 <memset>
  if(readFromSwapFile(p, buf, swapIndex*PGSIZE, PGSIZE) <= 0){
8010859c:	89 f8                	mov    %edi,%eax
8010859e:	68 00 10 00 00       	push   $0x1000
801085a3:	c1 e0 0c             	shl    $0xc,%eax
801085a6:	50                   	push   %eax
801085a7:	56                   	push   %esi
801085a8:	53                   	push   %ebx
801085a9:	e8 e2 9e ff ff       	call   80102490 <readFromSwapFile>
801085ae:	83 c4 20             	add    $0x20,%esp
801085b1:	85 c0                	test   %eax,%eax
801085b3:	0f 8e 8a 00 00 00    	jle    80108643 <scfifoSwap+0xf3>
  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
801085b9:	8b 45 08             	mov    0x8(%ebp),%eax
801085bc:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
801085c2:	83 ec 08             	sub    $0x8,%esp
801085c5:	b9 00 10 00 00       	mov    $0x1000,%ecx
801085ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085cf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801085d2:	8b 43 04             	mov    0x4(%ebx),%eax
801085d5:	6a 06                	push   $0x6
801085d7:	52                   	push   %edx
801085d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801085db:	e8 b0 ef ff ff       	call   80107590 <mappages>
  struct proc *p = myproc();
801085e0:	e8 7b ba ff ff       	call   80104060 <myproc>
  p->swappedPGs[index].va = EMPTY_VA;
801085e5:	8d 14 bf             	lea    (%edi,%edi,4),%edx
  p->nPgsSwap--;
801085e8:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
  pte = walkpgdir(p->pgdir,(void*)addr, 0);
801085ef:	31 c9                	xor    %ecx,%ecx
  p->swappedPGs[index].va = EMPTY_VA;
801085f1:	c7 84 90 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%edx,4)
801085f8:	ff ff ff ff 
  pte = walkpgdir(p->pgdir,(void*)addr, 0);
801085fc:	8b 55 08             	mov    0x8(%ebp),%edx
801085ff:	8b 43 04             	mov    0x4(%ebx),%eax
80108602:	e8 09 ef ff ff       	call   80107510 <walkpgdir>
  *pte &= ~PTE_PG;
80108607:	8b 10                	mov    (%eax),%edx
80108609:	80 e6 f5             	and    $0xf5,%dh
8010860c:	83 ca 03             	or     $0x3,%edx
8010860f:	89 10                	mov    %edx,(%eax)
  addPhysicalNode(addr);
80108611:	58                   	pop    %eax
80108612:	ff 75 08             	pushl  0x8(%ebp)
80108615:	e8 e6 f4 ff ff       	call   80107b00 <addPhysicalNode>
  lcr3(V2P(p->pgdir));
8010861a:	8b 43 04             	mov    0x4(%ebx),%eax
8010861d:	05 00 00 00 80       	add    $0x80000000,%eax
80108622:	0f 22 d8             	mov    %eax,%cr3
}
80108625:	83 c4 10             	add    $0x10,%esp
80108628:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010862b:	5b                   	pop    %ebx
8010862c:	5e                   	pop    %esi
8010862d:	5f                   	pop    %edi
8010862e:	5d                   	pop    %ebp
8010862f:	c3                   	ret    
    writePageToSwapFile((char*)addr);
80108630:	83 ec 0c             	sub    $0xc,%esp
80108633:	ff 75 08             	pushl  0x8(%ebp)
80108636:	e8 d5 fe ff ff       	call   80108510 <writePageToSwapFile>
8010863b:	83 c4 10             	add    $0x10,%esp
8010863e:	e9 3a ff ff ff       	jmp    8010857d <scfifoSwap+0x2d>
      panic("scfifoSwap: read from swapfile");
80108643:	83 ec 0c             	sub    $0xc,%esp
80108646:	68 6c 95 10 80       	push   $0x8010956c
8010864b:	e8 40 7d ff ff       	call   80100390 <panic>
    panic("nfuaSwap : allocating buf");
80108650:	83 ec 0c             	sub    $0xc,%esp
80108653:	68 aa 93 10 80       	push   $0x801093aa
80108658:	e8 33 7d ff ff       	call   80100390 <panic>
8010865d:	8d 76 00             	lea    0x0(%esi),%esi

80108660 <nfuaSwap>:
80108660:	55                   	push   %ebp
80108661:	89 e5                	mov    %esp,%ebp
80108663:	5d                   	pop    %ebp
80108664:	e9 e7 fe ff ff       	jmp    80108550 <scfifoSwap>
80108669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108670 <allocuvm>:
{
80108670:	55                   	push   %ebp
80108671:	89 e5                	mov    %esp,%ebp
80108673:	57                   	push   %edi
80108674:	56                   	push   %esi
80108675:	53                   	push   %ebx
80108676:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108679:	8b 7d 10             	mov    0x10(%ebp),%edi
8010867c:	85 ff                	test   %edi,%edi
8010867e:	0f 88 b9 00 00 00    	js     8010873d <allocuvm+0xcd>
  if(newsz < oldsz)
80108684:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108687:	0f 82 c3 00 00 00    	jb     80108750 <allocuvm+0xe0>
  a = PGROUNDUP(oldsz);
8010868d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108690:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108696:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010869c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010869f:	0f 86 ae 00 00 00    	jbe    80108753 <allocuvm+0xe3>
801086a5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801086a8:	8b 7d 08             	mov    0x8(%ebp),%edi
801086ab:	eb 4b                	jmp    801086f8 <allocuvm+0x88>
801086ad:	8d 76 00             	lea    0x0(%esi),%esi

}

int
initPhysicalPage(char *va){
  addPhysicalNode((uint) va);
801086b0:	83 ec 0c             	sub    $0xc,%esp
801086b3:	53                   	push   %ebx
801086b4:	e8 47 f4 ff ff       	call   80107b00 <addPhysicalNode>
    memset(mem, 0, PGSIZE);
801086b9:	83 c4 0c             	add    $0xc,%esp
801086bc:	68 00 10 00 00       	push   $0x1000
801086c1:	6a 00                	push   $0x0
801086c3:	56                   	push   %esi
801086c4:	e8 b7 ca ff ff       	call   80105180 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801086c9:	58                   	pop    %eax
801086ca:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801086d0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801086d5:	5a                   	pop    %edx
801086d6:	6a 06                	push   $0x6
801086d8:	50                   	push   %eax
801086d9:	89 da                	mov    %ebx,%edx
801086db:	89 f8                	mov    %edi,%eax
801086dd:	e8 ae ee ff ff       	call   80107590 <mappages>
801086e2:	83 c4 10             	add    $0x10,%esp
801086e5:	85 c0                	test   %eax,%eax
801086e7:	78 77                	js     80108760 <allocuvm+0xf0>
  for(; a < newsz; a += PGSIZE){
801086e9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801086ef:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801086f2:	0f 86 a8 00 00 00    	jbe    801087a0 <allocuvm+0x130>
      if(myproc()->nPgsPhysical >= MAX_PSYC_PAGES){
801086f8:	e8 63 b9 ff ff       	call   80104060 <myproc>
801086fd:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80108704:	7e 14                	jle    8010871a <allocuvm+0xaa>
        if( (pg = writePageToSwapFile((char*)a)) == 0){
80108706:	83 ec 0c             	sub    $0xc,%esp
80108709:	53                   	push   %ebx
8010870a:	e8 01 fe ff ff       	call   80108510 <writePageToSwapFile>
8010870f:	83 c4 10             	add    $0x10,%esp
80108712:	85 c0                	test   %eax,%eax
80108714:	0f 84 a7 00 00 00    	je     801087c1 <allocuvm+0x151>
    mem = kalloc();
8010871a:	e8 a1 a3 ff ff       	call   80102ac0 <kalloc>
    if(mem == 0){
8010871f:	85 c0                	test   %eax,%eax
    mem = kalloc();
80108721:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108723:	75 8b                	jne    801086b0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80108725:	83 ec 0c             	sub    $0xc,%esp
80108728:	68 da 93 10 80       	push   $0x801093da
8010872d:	e8 2e 7f ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz){
80108732:	83 c4 10             	add    $0x10,%esp
80108735:	8b 45 0c             	mov    0xc(%ebp),%eax
80108738:	39 45 10             	cmp    %eax,0x10(%ebp)
8010873b:	77 73                	ja     801087b0 <allocuvm+0x140>
}
8010873d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80108740:	31 ff                	xor    %edi,%edi
}
80108742:	89 f8                	mov    %edi,%eax
80108744:	5b                   	pop    %ebx
80108745:	5e                   	pop    %esi
80108746:	5f                   	pop    %edi
80108747:	5d                   	pop    %ebp
80108748:	c3                   	ret    
80108749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108750:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80108753:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108756:	89 f8                	mov    %edi,%eax
80108758:	5b                   	pop    %ebx
80108759:	5e                   	pop    %esi
8010875a:	5f                   	pop    %edi
8010875b:	5d                   	pop    %ebp
8010875c:	c3                   	ret    
8010875d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108760:	83 ec 0c             	sub    $0xc,%esp
80108763:	68 f2 93 10 80       	push   $0x801093f2
80108768:	e8 f3 7e ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz){
8010876d:	83 c4 10             	add    $0x10,%esp
80108770:	8b 45 0c             	mov    0xc(%ebp),%eax
80108773:	39 45 10             	cmp    %eax,0x10(%ebp)
80108776:	76 0d                	jbe    80108785 <allocuvm+0x115>
80108778:	89 c1                	mov    %eax,%ecx
8010877a:	8b 55 10             	mov    0x10(%ebp),%edx
8010877d:	8b 45 08             	mov    0x8(%ebp),%eax
80108780:	e8 7b f7 ff ff       	call   80107f00 <deallocuvm.part.1>
      kfree(mem);
80108785:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108788:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010878a:	56                   	push   %esi
8010878b:	e8 20 a1 ff ff       	call   801028b0 <kfree>
      return 0;
80108790:	83 c4 10             	add    $0x10,%esp
}
80108793:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108796:	89 f8                	mov    %edi,%eax
80108798:	5b                   	pop    %ebx
80108799:	5e                   	pop    %esi
8010879a:	5f                   	pop    %edi
8010879b:	5d                   	pop    %ebp
8010879c:	c3                   	ret    
8010879d:	8d 76 00             	lea    0x0(%esi),%esi
801087a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801087a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801087a6:	5b                   	pop    %ebx
801087a7:	89 f8                	mov    %edi,%eax
801087a9:	5e                   	pop    %esi
801087aa:	5f                   	pop    %edi
801087ab:	5d                   	pop    %ebp
801087ac:	c3                   	ret    
801087ad:	8d 76 00             	lea    0x0(%esi),%esi
801087b0:	89 c1                	mov    %eax,%ecx
801087b2:	8b 55 10             	mov    0x10(%ebp),%edx
801087b5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801087b8:	31 ff                	xor    %edi,%edi
801087ba:	e8 41 f7 ff ff       	call   80107f00 <deallocuvm.part.1>
801087bf:	eb 92                	jmp    80108753 <allocuvm+0xe3>
          panic("allocuvm: swapOutPage");
801087c1:	83 ec 0c             	sub    $0xc,%esp
801087c4:	68 c4 93 10 80       	push   $0x801093c4
801087c9:	e8 c2 7b ff ff       	call   80100390 <panic>
801087ce:	66 90                	xchg   %ax,%ax

801087d0 <swapPage>:
swapPage(uint addr){
801087d0:	55                   	push   %ebp
801087d1:	89 e5                	mov    %esp,%ebp
}
801087d3:	5d                   	pop    %ebp
    return scfifoSwap(addr);
801087d4:	e9 77 fd ff ff       	jmp    80108550 <scfifoSwap>
801087d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801087e0 <initPhysicalPage>:
initPhysicalPage(char *va){
801087e0:	55                   	push   %ebp
801087e1:	89 e5                	mov    %esp,%ebp
801087e3:	83 ec 14             	sub    $0x14,%esp
  addPhysicalNode((uint) va);
801087e6:	ff 75 08             	pushl  0x8(%ebp)
801087e9:	e8 12 f3 ff ff       	call   80107b00 <addPhysicalNode>

  

  return 0;
}
801087ee:	31 c0                	xor    %eax,%eax
801087f0:	c9                   	leave  
801087f1:	c3                   	ret    
