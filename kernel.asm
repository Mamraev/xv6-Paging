
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
8010002d:	b8 b0 34 10 80       	mov    $0x801034b0,%eax
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
8010004c:	68 40 85 10 80       	push   $0x80108540
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 d5 4a 00 00       	call   80104b30 <initlock>
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
80100092:	68 47 85 10 80       	push   $0x80108547
80100097:	50                   	push   %eax
80100098:	e8 63 49 00 00       	call   80104a00 <initsleeplock>
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
801000e4:	e8 87 4b 00 00       	call   80104c70 <acquire>
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
80100162:	e8 c9 4b 00 00       	call   80104d30 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 48 00 00       	call   80104a40 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 ad 23 00 00       	call   80102530 <iderw>
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
80100193:	68 4e 85 10 80       	push   $0x8010854e
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
801001ae:	e8 2d 49 00 00       	call   80104ae0 <holdingsleep>
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
801001c4:	e9 67 23 00 00       	jmp    80102530 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 5f 85 10 80       	push   $0x8010855f
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
801001ef:	e8 ec 48 00 00       	call   80104ae0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 9c 48 00 00       	call   80104aa0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 60 4a 00 00       	call   80104c70 <acquire>
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
8010025c:	e9 cf 4a 00 00       	jmp    80104d30 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 85 10 80       	push   $0x80108566
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
80100280:	e8 5b 15 00 00       	call   801017e0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 df 49 00 00       	call   80104c70 <acquire>
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
801002c5:	e8 b6 42 00 00       	call   80104580 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 b0 3b 00 00       	call   80103e90 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 3c 4a 00 00       	call   80104d30 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 04 14 00 00       	call   80101700 <ilock>
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
8010034d:	e8 de 49 00 00       	call   80104d30 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 a6 13 00 00       	call   80101700 <ilock>
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
801003a9:	e8 92 29 00 00       	call   80102d40 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 85 10 80       	push   $0x8010856d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 32 91 10 80 	movl   $0x80109132,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 73 47 00 00       	call   80104b50 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 85 10 80       	push   $0x80108581
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
8010043a:	e8 51 61 00 00       	call   80106590 <uartputc>
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
801004ec:	e8 9f 60 00 00       	call   80106590 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 93 60 00 00       	call   80106590 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 87 60 00 00       	call   80106590 <uartputc>
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
80100524:	e8 07 49 00 00       	call   80104e30 <memmove>
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
80100541:	e8 3a 48 00 00       	call   80104d80 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 85 10 80       	push   $0x80108585
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
801005b1:	0f b6 92 b0 85 10 80 	movzbl -0x7fef7a50(%edx),%edx
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
8010060f:	e8 cc 11 00 00       	call   801017e0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 50 46 00 00       	call   80104c70 <acquire>
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
80100647:	e8 e4 46 00 00       	call   80104d30 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 ab 10 00 00       	call   80101700 <ilock>

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
8010071f:	e8 0c 46 00 00       	call   80104d30 <release>
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
801007d0:	ba 98 85 10 80       	mov    $0x80108598,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 7b 44 00 00       	call   80104c70 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 85 10 80       	push   $0x8010859f
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
80100823:	e8 48 44 00 00       	call   80104c70 <acquire>
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
80100888:	e8 a3 44 00 00       	call   80104d30 <release>
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
80100916:	e8 25 3e 00 00       	call   80104740 <wakeup>
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
80100997:	e9 84 3e 00 00       	jmp    80104820 <procdump>
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
801009c6:	68 a8 85 10 80       	push   $0x801085a8
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 5b 41 00 00       	call   80104b30 <initlock>

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
801009f9:	e8 e2 1c 00 00       	call   801026e0 <ioapicenable>
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
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 6f 34 00 00       	call   80103e90 <myproc>
80100a21:	89 c7                	mov    %eax,%edi

  begin_op();
80100a23:	e8 88 27 00 00       	call   801031b0 <begin_op>

  if((ip = namei(path)) == 0){
80100a28:	83 ec 0c             	sub    $0xc,%esp
80100a2b:	ff 75 08             	pushl  0x8(%ebp)
80100a2e:	e8 2d 15 00 00       	call   80101f60 <namei>
80100a33:	83 c4 10             	add    $0x10,%esp
80100a36:	85 c0                	test   %eax,%eax
80100a38:	0f 84 03 02 00 00    	je     80100c41 <exec+0x231>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a3e:	83 ec 0c             	sub    $0xc,%esp
80100a41:	89 c3                	mov    %eax,%ebx
80100a43:	50                   	push   %eax
80100a44:	e8 b7 0c 00 00       	call   80101700 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a49:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a4f:	6a 34                	push   $0x34
80100a51:	6a 00                	push   $0x0
80100a53:	50                   	push   %eax
80100a54:	53                   	push   %ebx
80100a55:	e8 86 0f 00 00       	call   801019e0 <readi>
80100a5a:	83 c4 20             	add    $0x20,%esp
80100a5d:	83 f8 34             	cmp    $0x34,%eax
80100a60:	74 1e                	je     80100a80 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a62:	83 ec 0c             	sub    $0xc,%esp
80100a65:	53                   	push   %ebx
80100a66:	e8 25 0f 00 00       	call   80101990 <iunlockput>
    end_op();
80100a6b:	e8 b0 27 00 00       	call   80103220 <end_op>
80100a70:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7b:	5b                   	pop    %ebx
80100a7c:	5e                   	pop    %esi
80100a7d:	5f                   	pop    %edi
80100a7e:	5d                   	pop    %ebp
80100a7f:	c3                   	ret    
  if(elf.magic != ELF_MAGIC)
80100a80:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a87:	45 4c 46 
80100a8a:	75 d6                	jne    80100a62 <exec+0x52>
  if((pgdir = setupkvm()) == 0)
80100a8c:	e8 ff 6b 00 00       	call   80107690 <setupkvm>
80100a91:	85 c0                	test   %eax,%eax
80100a93:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a99:	74 c7                	je     80100a62 <exec+0x52>
80100a9b:	8d 87 90 01 00 00    	lea    0x190(%edi),%eax
80100aa1:	8d 97 9c 00 00 00    	lea    0x9c(%edi),%edx
80100aa7:	8d 8f d0 02 00 00    	lea    0x2d0(%edi),%ecx
80100aad:	8d 76 00             	lea    0x0(%esi),%esi
    curproc->physicalPGs[i].va = (char*)0xffffffff;
80100ab0:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    curproc->physicalPGs[i].next = 0;
80100ab6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80100abd:	83 c0 14             	add    $0x14,%eax
    curproc->physicalPGs[i].prev = 0;
80100ac0:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80100ac7:	83 c2 10             	add    $0x10,%edx
    curproc->swappedPGs[i].va = (char*)0xffffffff;
80100aca:	c7 42 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%edx)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100ad1:	39 c8                	cmp    %ecx,%eax
80100ad3:	75 db                	jne    80100ab0 <exec+0xa0>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ad5:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
  curproc->nPgsPhysical = 0;
80100adb:	c7 87 80 00 00 00 00 	movl   $0x0,0x80(%edi)
80100ae2:	00 00 00 
  curproc->nPgsSwap = 0;
80100ae5:	c7 87 84 00 00 00 00 	movl   $0x0,0x84(%edi)
80100aec:	00 00 00 
  curproc->headPG = 0;
80100aef:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%edi)
80100af6:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100af9:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
  sz = 0;
80100aff:	31 c0                	xor    %eax,%eax
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b01:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b08:	00 
80100b09:	0f 84 aa 02 00 00    	je     80100db9 <exec+0x3a9>
80100b0f:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100b15:	31 f6                	xor    %esi,%esi
80100b17:	89 c7                	mov    %eax,%edi
80100b19:	eb 7f                	jmp    80100b9a <exec+0x18a>
80100b1b:	90                   	nop
80100b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b20:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b27:	75 63                	jne    80100b8c <exec+0x17c>
    if(ph.memsz < ph.filesz)
80100b29:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b2f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b35:	0f 82 86 00 00 00    	jb     80100bc1 <exec+0x1b1>
80100b3b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b41:	72 7e                	jb     80100bc1 <exec+0x1b1>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b43:	83 ec 04             	sub    $0x4,%esp
80100b46:	50                   	push   %eax
80100b47:	57                   	push   %edi
80100b48:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b4e:	e8 fd 77 00 00       	call   80108350 <allocuvm>
80100b53:	83 c4 10             	add    $0x10,%esp
80100b56:	85 c0                	test   %eax,%eax
80100b58:	89 c7                	mov    %eax,%edi
80100b5a:	74 65                	je     80100bc1 <exec+0x1b1>
    if(ph.vaddr % PGSIZE != 0)
80100b5c:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b62:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b67:	75 58                	jne    80100bc1 <exec+0x1b1>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b72:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b78:	53                   	push   %ebx
80100b79:	50                   	push   %eax
80100b7a:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b80:	e8 1b 68 00 00       	call   801073a0 <loaduvm>
80100b85:	83 c4 20             	add    $0x20,%esp
80100b88:	85 c0                	test   %eax,%eax
80100b8a:	78 35                	js     80100bc1 <exec+0x1b1>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b8c:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b93:	83 c6 01             	add    $0x1,%esi
80100b96:	39 f0                	cmp    %esi,%eax
80100b98:	7e 3d                	jle    80100bd7 <exec+0x1c7>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b9a:	89 f0                	mov    %esi,%eax
80100b9c:	6a 20                	push   $0x20
80100b9e:	c1 e0 05             	shl    $0x5,%eax
80100ba1:	03 85 f0 fe ff ff    	add    -0x110(%ebp),%eax
80100ba7:	50                   	push   %eax
80100ba8:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bae:	50                   	push   %eax
80100baf:	53                   	push   %ebx
80100bb0:	e8 2b 0e 00 00       	call   801019e0 <readi>
80100bb5:	83 c4 10             	add    $0x10,%esp
80100bb8:	83 f8 20             	cmp    $0x20,%eax
80100bbb:	0f 84 5f ff ff ff    	je     80100b20 <exec+0x110>
    freevm(pgdir);
80100bc1:	83 ec 0c             	sub    $0xc,%esp
80100bc4:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bca:	e8 41 6a 00 00       	call   80107610 <freevm>
80100bcf:	83 c4 10             	add    $0x10,%esp
80100bd2:	e9 8b fe ff ff       	jmp    80100a62 <exec+0x52>
80100bd7:	89 f8                	mov    %edi,%eax
80100bd9:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100bdf:	05 ff 0f 00 00       	add    $0xfff,%eax
80100be4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100be9:	8d b0 00 20 00 00    	lea    0x2000(%eax),%esi
  iunlockput(ip);
80100bef:	83 ec 0c             	sub    $0xc,%esp
80100bf2:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bf8:	53                   	push   %ebx
80100bf9:	e8 92 0d 00 00       	call   80101990 <iunlockput>
  end_op();
80100bfe:	e8 1d 26 00 00       	call   80103220 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c03:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c09:	83 c4 0c             	add    $0xc,%esp
80100c0c:	56                   	push   %esi
80100c0d:	50                   	push   %eax
80100c0e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c14:	e8 37 77 00 00       	call   80108350 <allocuvm>
80100c19:	83 c4 10             	add    $0x10,%esp
80100c1c:	85 c0                	test   %eax,%eax
80100c1e:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c24:	75 3a                	jne    80100c60 <exec+0x250>
    freevm(pgdir);
80100c26:	83 ec 0c             	sub    $0xc,%esp
80100c29:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c2f:	e8 dc 69 00 00       	call   80107610 <freevm>
80100c34:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c3c:	e9 37 fe ff ff       	jmp    80100a78 <exec+0x68>
    end_op();
80100c41:	e8 da 25 00 00       	call   80103220 <end_op>
    cprintf("exec: fail\n");
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	68 c1 85 10 80       	push   $0x801085c1
80100c4e:	e8 0d fa ff ff       	call   80100660 <cprintf>
    return -1;
80100c53:	83 c4 10             	add    $0x10,%esp
80100c56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c5b:	e9 18 fe ff ff       	jmp    80100a78 <exec+0x68>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c60:	89 c3                	mov    %eax,%ebx
80100c62:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c68:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100c6b:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c6d:	50                   	push   %eax
80100c6e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c74:	e8 b7 6a 00 00       	call   80107730 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c79:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c7c:	83 c4 10             	add    $0x10,%esp
80100c7f:	8b 00                	mov    (%eax),%eax
80100c81:	85 c0                	test   %eax,%eax
80100c83:	0f 84 3a 01 00 00    	je     80100dc3 <exec+0x3b3>
80100c89:	89 bd ec fe ff ff    	mov    %edi,-0x114(%ebp)
80100c8f:	89 f7                	mov    %esi,%edi
80100c91:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c97:	eb 0c                	jmp    80100ca5 <exec+0x295>
80100c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100ca0:	83 ff 20             	cmp    $0x20,%edi
80100ca3:	74 81                	je     80100c26 <exec+0x216>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ca5:	83 ec 0c             	sub    $0xc,%esp
80100ca8:	50                   	push   %eax
80100ca9:	e8 f2 42 00 00       	call   80104fa0 <strlen>
80100cae:	f7 d0                	not    %eax
80100cb0:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb5:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb6:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb9:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cbc:	e8 df 42 00 00       	call   80104fa0 <strlen>
80100cc1:	83 c0 01             	add    $0x1,%eax
80100cc4:	50                   	push   %eax
80100cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc8:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ccb:	53                   	push   %ebx
80100ccc:	56                   	push   %esi
80100ccd:	e8 fe 6b 00 00       	call   801078d0 <copyout>
80100cd2:	83 c4 20             	add    $0x20,%esp
80100cd5:	85 c0                	test   %eax,%eax
80100cd7:	0f 88 49 ff ff ff    	js     80100c26 <exec+0x216>
  for(argc = 0; argv[argc]; argc++) {
80100cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100ce0:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100ce7:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100cea:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cf0:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cf3:	85 c0                	test   %eax,%eax
80100cf5:	75 a9                	jne    80100ca0 <exec+0x290>
80100cf7:	89 fe                	mov    %edi,%esi
80100cf9:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cff:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100d06:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d08:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100d0f:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100d13:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d1a:	ff ff ff 
  ustack[1] = argc;
80100d1d:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d23:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d25:	83 c0 0c             	add    $0xc,%eax
80100d28:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d2a:	50                   	push   %eax
80100d2b:	52                   	push   %edx
80100d2c:	53                   	push   %ebx
80100d2d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d33:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d39:	e8 92 6b 00 00       	call   801078d0 <copyout>
80100d3e:	83 c4 10             	add    $0x10,%esp
80100d41:	85 c0                	test   %eax,%eax
80100d43:	0f 88 dd fe ff ff    	js     80100c26 <exec+0x216>
  for(last=s=path; *s; s++)
80100d49:	8b 45 08             	mov    0x8(%ebp),%eax
80100d4c:	0f b6 00             	movzbl (%eax),%eax
80100d4f:	84 c0                	test   %al,%al
80100d51:	74 17                	je     80100d6a <exec+0x35a>
80100d53:	8b 55 08             	mov    0x8(%ebp),%edx
80100d56:	89 d1                	mov    %edx,%ecx
80100d58:	83 c1 01             	add    $0x1,%ecx
80100d5b:	3c 2f                	cmp    $0x2f,%al
80100d5d:	0f b6 01             	movzbl (%ecx),%eax
80100d60:	0f 44 d1             	cmove  %ecx,%edx
80100d63:	84 c0                	test   %al,%al
80100d65:	75 f1                	jne    80100d58 <exec+0x348>
80100d67:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d6a:	50                   	push   %eax
80100d6b:	8d 47 6c             	lea    0x6c(%edi),%eax
80100d6e:	6a 10                	push   $0x10
80100d70:	ff 75 08             	pushl  0x8(%ebp)
80100d73:	50                   	push   %eax
80100d74:	e8 e7 41 00 00       	call   80104f60 <safestrcpy>
  curproc->pgdir = pgdir;
80100d79:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  oldpgdir = curproc->pgdir;
80100d7f:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->pgdir = pgdir;
80100d82:	89 47 04             	mov    %eax,0x4(%edi)
  curproc->sz = sz;
80100d85:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d8b:	89 07                	mov    %eax,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d8d:	8b 47 18             	mov    0x18(%edi),%eax
80100d90:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d96:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d99:	8b 47 18             	mov    0x18(%edi),%eax
80100d9c:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d9f:	89 3c 24             	mov    %edi,(%esp)
80100da2:	e8 69 64 00 00       	call   80107210 <switchuvm>
  freevm(oldpgdir);
80100da7:	89 34 24             	mov    %esi,(%esp)
80100daa:	e8 61 68 00 00       	call   80107610 <freevm>
  return 0;
80100daf:	83 c4 10             	add    $0x10,%esp
80100db2:	31 c0                	xor    %eax,%eax
80100db4:	e9 bf fc ff ff       	jmp    80100a78 <exec+0x68>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100db9:	be 00 20 00 00       	mov    $0x2000,%esi
80100dbe:	e9 2c fe ff ff       	jmp    80100bef <exec+0x1df>
  for(argc = 0; argv[argc]; argc++) {
80100dc3:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100dc9:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100dcf:	e9 2b ff ff ff       	jmp    80100cff <exec+0x2ef>
80100dd4:	66 90                	xchg   %ax,%ax
80100dd6:	66 90                	xchg   %ax,%ax
80100dd8:	66 90                	xchg   %ax,%ax
80100dda:	66 90                	xchg   %ax,%ax
80100ddc:	66 90                	xchg   %ax,%ax
80100dde:	66 90                	xchg   %ax,%ax

80100de0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100de6:	68 cd 85 10 80       	push   $0x801085cd
80100deb:	68 c0 1f 11 80       	push   $0x80111fc0
80100df0:	e8 3b 3d 00 00       	call   80104b30 <initlock>
}
80100df5:	83 c4 10             	add    $0x10,%esp
80100df8:	c9                   	leave  
80100df9:	c3                   	ret    
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e00 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e04:	bb f4 1f 11 80       	mov    $0x80111ff4,%ebx
{
80100e09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e0c:	68 c0 1f 11 80       	push   $0x80111fc0
80100e11:	e8 5a 3e 00 00       	call   80104c70 <acquire>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	eb 10                	jmp    80100e2b <filealloc+0x2b>
80100e1b:	90                   	nop
80100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e20:	83 c3 18             	add    $0x18,%ebx
80100e23:	81 fb 54 29 11 80    	cmp    $0x80112954,%ebx
80100e29:	73 25                	jae    80100e50 <filealloc+0x50>
    if(f->ref == 0){
80100e2b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e2e:	85 c0                	test   %eax,%eax
80100e30:	75 ee                	jne    80100e20 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e32:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e35:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e3c:	68 c0 1f 11 80       	push   $0x80111fc0
80100e41:	e8 ea 3e 00 00       	call   80104d30 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e46:	89 d8                	mov    %ebx,%eax
      return f;
80100e48:	83 c4 10             	add    $0x10,%esp
}
80100e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e4e:	c9                   	leave  
80100e4f:	c3                   	ret    
  release(&ftable.lock);
80100e50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e53:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e55:	68 c0 1f 11 80       	push   $0x80111fc0
80100e5a:	e8 d1 3e 00 00       	call   80104d30 <release>
}
80100e5f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e61:	83 c4 10             	add    $0x10,%esp
}
80100e64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e67:	c9                   	leave  
80100e68:	c3                   	ret    
80100e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100e70 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	53                   	push   %ebx
80100e74:	83 ec 10             	sub    $0x10,%esp
80100e77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e7a:	68 c0 1f 11 80       	push   $0x80111fc0
80100e7f:	e8 ec 3d 00 00       	call   80104c70 <acquire>
  if(f->ref < 1)
80100e84:	8b 43 04             	mov    0x4(%ebx),%eax
80100e87:	83 c4 10             	add    $0x10,%esp
80100e8a:	85 c0                	test   %eax,%eax
80100e8c:	7e 1a                	jle    80100ea8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e8e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e91:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e94:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e97:	68 c0 1f 11 80       	push   $0x80111fc0
80100e9c:	e8 8f 3e 00 00       	call   80104d30 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 d4 85 10 80       	push   $0x801085d4
80100eb0:	e8 db f4 ff ff       	call   80100390 <panic>
80100eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ec0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	57                   	push   %edi
80100ec4:	56                   	push   %esi
80100ec5:	53                   	push   %ebx
80100ec6:	83 ec 28             	sub    $0x28,%esp
80100ec9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100ecc:	68 c0 1f 11 80       	push   $0x80111fc0
80100ed1:	e8 9a 3d 00 00       	call   80104c70 <acquire>
  if(f->ref < 1)
80100ed6:	8b 43 04             	mov    0x4(%ebx),%eax
80100ed9:	83 c4 10             	add    $0x10,%esp
80100edc:	85 c0                	test   %eax,%eax
80100ede:	0f 8e 9b 00 00 00    	jle    80100f7f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100ee4:	83 e8 01             	sub    $0x1,%eax
80100ee7:	85 c0                	test   %eax,%eax
80100ee9:	89 43 04             	mov    %eax,0x4(%ebx)
80100eec:	74 1a                	je     80100f08 <fileclose+0x48>
    release(&ftable.lock);
80100eee:	c7 45 08 c0 1f 11 80 	movl   $0x80111fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100ef5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef8:	5b                   	pop    %ebx
80100ef9:	5e                   	pop    %esi
80100efa:	5f                   	pop    %edi
80100efb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100efc:	e9 2f 3e 00 00       	jmp    80104d30 <release>
80100f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100f08:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100f0c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100f0e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f11:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100f14:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f1a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f1d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f20:	68 c0 1f 11 80       	push   $0x80111fc0
  ff = *f;
80100f25:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f28:	e8 03 3e 00 00       	call   80104d30 <release>
  if(ff.type == FD_PIPE)
80100f2d:	83 c4 10             	add    $0x10,%esp
80100f30:	83 ff 01             	cmp    $0x1,%edi
80100f33:	74 13                	je     80100f48 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100f35:	83 ff 02             	cmp    $0x2,%edi
80100f38:	74 26                	je     80100f60 <fileclose+0xa0>
}
80100f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f3d:	5b                   	pop    %ebx
80100f3e:	5e                   	pop    %esi
80100f3f:	5f                   	pop    %edi
80100f40:	5d                   	pop    %ebp
80100f41:	c3                   	ret    
80100f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100f48:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f4c:	83 ec 08             	sub    $0x8,%esp
80100f4f:	53                   	push   %ebx
80100f50:	56                   	push   %esi
80100f51:	e8 0a 2a 00 00       	call   80103960 <pipeclose>
80100f56:	83 c4 10             	add    $0x10,%esp
80100f59:	eb df                	jmp    80100f3a <fileclose+0x7a>
80100f5b:	90                   	nop
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f60:	e8 4b 22 00 00       	call   801031b0 <begin_op>
    iput(ff.ip);
80100f65:	83 ec 0c             	sub    $0xc,%esp
80100f68:	ff 75 e0             	pushl  -0x20(%ebp)
80100f6b:	e8 c0 08 00 00       	call   80101830 <iput>
    end_op();
80100f70:	83 c4 10             	add    $0x10,%esp
}
80100f73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f76:	5b                   	pop    %ebx
80100f77:	5e                   	pop    %esi
80100f78:	5f                   	pop    %edi
80100f79:	5d                   	pop    %ebp
    end_op();
80100f7a:	e9 a1 22 00 00       	jmp    80103220 <end_op>
    panic("fileclose");
80100f7f:	83 ec 0c             	sub    $0xc,%esp
80100f82:	68 dc 85 10 80       	push   $0x801085dc
80100f87:	e8 04 f4 ff ff       	call   80100390 <panic>
80100f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f90 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	53                   	push   %ebx
80100f94:	83 ec 04             	sub    $0x4,%esp
80100f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f9a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f9d:	75 31                	jne    80100fd0 <filestat+0x40>
    ilock(f->ip);
80100f9f:	83 ec 0c             	sub    $0xc,%esp
80100fa2:	ff 73 10             	pushl  0x10(%ebx)
80100fa5:	e8 56 07 00 00       	call   80101700 <ilock>
    stati(f->ip, st);
80100faa:	58                   	pop    %eax
80100fab:	5a                   	pop    %edx
80100fac:	ff 75 0c             	pushl  0xc(%ebp)
80100faf:	ff 73 10             	pushl  0x10(%ebx)
80100fb2:	e8 f9 09 00 00       	call   801019b0 <stati>
    iunlock(f->ip);
80100fb7:	59                   	pop    %ecx
80100fb8:	ff 73 10             	pushl  0x10(%ebx)
80100fbb:	e8 20 08 00 00       	call   801017e0 <iunlock>
    return 0;
80100fc0:	83 c4 10             	add    $0x10,%esp
80100fc3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100fc5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc8:	c9                   	leave  
80100fc9:	c3                   	ret    
80100fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fd5:	eb ee                	jmp    80100fc5 <filestat+0x35>
80100fd7:	89 f6                	mov    %esi,%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 0c             	sub    $0xc,%esp
80100fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fec:	8b 75 0c             	mov    0xc(%ebp),%esi
80100fef:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100ff2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100ff6:	74 60                	je     80101058 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100ff8:	8b 03                	mov    (%ebx),%eax
80100ffa:	83 f8 01             	cmp    $0x1,%eax
80100ffd:	74 41                	je     80101040 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fff:	83 f8 02             	cmp    $0x2,%eax
80101002:	75 5b                	jne    8010105f <fileread+0x7f>
    ilock(f->ip);
80101004:	83 ec 0c             	sub    $0xc,%esp
80101007:	ff 73 10             	pushl  0x10(%ebx)
8010100a:	e8 f1 06 00 00       	call   80101700 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010100f:	57                   	push   %edi
80101010:	ff 73 14             	pushl  0x14(%ebx)
80101013:	56                   	push   %esi
80101014:	ff 73 10             	pushl  0x10(%ebx)
80101017:	e8 c4 09 00 00       	call   801019e0 <readi>
8010101c:	83 c4 20             	add    $0x20,%esp
8010101f:	85 c0                	test   %eax,%eax
80101021:	89 c6                	mov    %eax,%esi
80101023:	7e 03                	jle    80101028 <fileread+0x48>
      f->off += r;
80101025:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101028:	83 ec 0c             	sub    $0xc,%esp
8010102b:	ff 73 10             	pushl  0x10(%ebx)
8010102e:	e8 ad 07 00 00       	call   801017e0 <iunlock>
    return r;
80101033:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101036:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101039:	89 f0                	mov    %esi,%eax
8010103b:	5b                   	pop    %ebx
8010103c:	5e                   	pop    %esi
8010103d:	5f                   	pop    %edi
8010103e:	5d                   	pop    %ebp
8010103f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101040:	8b 43 0c             	mov    0xc(%ebx),%eax
80101043:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101046:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101049:	5b                   	pop    %ebx
8010104a:	5e                   	pop    %esi
8010104b:	5f                   	pop    %edi
8010104c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010104d:	e9 be 2a 00 00       	jmp    80103b10 <piperead>
80101052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101058:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010105d:	eb d7                	jmp    80101036 <fileread+0x56>
  panic("fileread");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 e6 85 10 80       	push   $0x801085e6
80101067:	e8 24 f3 ff ff       	call   80100390 <panic>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101070 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	57                   	push   %edi
80101074:	56                   	push   %esi
80101075:	53                   	push   %ebx
80101076:	83 ec 1c             	sub    $0x1c,%esp
80101079:	8b 75 08             	mov    0x8(%ebp),%esi
8010107c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010107f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101083:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101086:	8b 45 10             	mov    0x10(%ebp),%eax
80101089:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010108c:	0f 84 aa 00 00 00    	je     8010113c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101092:	8b 06                	mov    (%esi),%eax
80101094:	83 f8 01             	cmp    $0x1,%eax
80101097:	0f 84 c3 00 00 00    	je     80101160 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010109d:	83 f8 02             	cmp    $0x2,%eax
801010a0:	0f 85 d9 00 00 00    	jne    8010117f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010a9:	31 ff                	xor    %edi,%edi
    while(i < n){
801010ab:	85 c0                	test   %eax,%eax
801010ad:	7f 34                	jg     801010e3 <filewrite+0x73>
801010af:	e9 9c 00 00 00       	jmp    80101150 <filewrite+0xe0>
801010b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010b8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801010bb:	83 ec 0c             	sub    $0xc,%esp
801010be:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801010c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801010c4:	e8 17 07 00 00       	call   801017e0 <iunlock>
      end_op();
801010c9:	e8 52 21 00 00       	call   80103220 <end_op>
801010ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010d1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801010d4:	39 c3                	cmp    %eax,%ebx
801010d6:	0f 85 96 00 00 00    	jne    80101172 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801010dc:	01 df                	add    %ebx,%edi
    while(i < n){
801010de:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010e1:	7e 6d                	jle    80101150 <filewrite+0xe0>
      int n1 = n - i;
801010e3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010e6:	b8 00 06 00 00       	mov    $0x600,%eax
801010eb:	29 fb                	sub    %edi,%ebx
801010ed:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801010f3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801010f6:	e8 b5 20 00 00       	call   801031b0 <begin_op>
      ilock(f->ip);
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 76 10             	pushl  0x10(%esi)
80101101:	e8 fa 05 00 00       	call   80101700 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101106:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101109:	53                   	push   %ebx
8010110a:	ff 76 14             	pushl  0x14(%esi)
8010110d:	01 f8                	add    %edi,%eax
8010110f:	50                   	push   %eax
80101110:	ff 76 10             	pushl  0x10(%esi)
80101113:	e8 c8 09 00 00       	call   80101ae0 <writei>
80101118:	83 c4 20             	add    $0x20,%esp
8010111b:	85 c0                	test   %eax,%eax
8010111d:	7f 99                	jg     801010b8 <filewrite+0x48>
      iunlock(f->ip);
8010111f:	83 ec 0c             	sub    $0xc,%esp
80101122:	ff 76 10             	pushl  0x10(%esi)
80101125:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101128:	e8 b3 06 00 00       	call   801017e0 <iunlock>
      end_op();
8010112d:	e8 ee 20 00 00       	call   80103220 <end_op>
      if(r < 0)
80101132:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101135:	83 c4 10             	add    $0x10,%esp
80101138:	85 c0                	test   %eax,%eax
8010113a:	74 98                	je     801010d4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010113c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010113f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101144:	89 f8                	mov    %edi,%eax
80101146:	5b                   	pop    %ebx
80101147:	5e                   	pop    %esi
80101148:	5f                   	pop    %edi
80101149:	5d                   	pop    %ebp
8010114a:	c3                   	ret    
8010114b:	90                   	nop
8010114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101150:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101153:	75 e7                	jne    8010113c <filewrite+0xcc>
}
80101155:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101158:	89 f8                	mov    %edi,%eax
8010115a:	5b                   	pop    %ebx
8010115b:	5e                   	pop    %esi
8010115c:	5f                   	pop    %edi
8010115d:	5d                   	pop    %ebp
8010115e:	c3                   	ret    
8010115f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101160:	8b 46 0c             	mov    0xc(%esi),%eax
80101163:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101169:	5b                   	pop    %ebx
8010116a:	5e                   	pop    %esi
8010116b:	5f                   	pop    %edi
8010116c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010116d:	e9 8e 28 00 00       	jmp    80103a00 <pipewrite>
        panic("short filewrite");
80101172:	83 ec 0c             	sub    $0xc,%esp
80101175:	68 ef 85 10 80       	push   $0x801085ef
8010117a:	e8 11 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 f5 85 10 80       	push   $0x801085f5
80101187:	e8 04 f2 ff ff       	call   80100390 <panic>
8010118c:	66 90                	xchg   %ax,%ax
8010118e:	66 90                	xchg   %ax,%ax

80101190 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101190:	55                   	push   %ebp
80101191:	89 e5                	mov    %esp,%ebp
80101193:	56                   	push   %esi
80101194:	53                   	push   %ebx
80101195:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101197:	c1 ea 0c             	shr    $0xc,%edx
8010119a:	03 15 d8 29 11 80    	add    0x801129d8,%edx
801011a0:	83 ec 08             	sub    $0x8,%esp
801011a3:	52                   	push   %edx
801011a4:	50                   	push   %eax
801011a5:	e8 26 ef ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011aa:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011ac:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801011af:	ba 01 00 00 00       	mov    $0x1,%edx
801011b4:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801011b7:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801011bd:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801011c0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801011c2:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801011c7:	85 d1                	test   %edx,%ecx
801011c9:	74 25                	je     801011f0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801011cb:	f7 d2                	not    %edx
801011cd:	89 c6                	mov    %eax,%esi
  log_write(bp);
801011cf:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801011d2:	21 ca                	and    %ecx,%edx
801011d4:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801011d8:	56                   	push   %esi
801011d9:	e8 a2 21 00 00       	call   80103380 <log_write>
  brelse(bp);
801011de:	89 34 24             	mov    %esi,(%esp)
801011e1:	e8 fa ef ff ff       	call   801001e0 <brelse>
}
801011e6:	83 c4 10             	add    $0x10,%esp
801011e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801011ec:	5b                   	pop    %ebx
801011ed:	5e                   	pop    %esi
801011ee:	5d                   	pop    %ebp
801011ef:	c3                   	ret    
    panic("freeing free block");
801011f0:	83 ec 0c             	sub    $0xc,%esp
801011f3:	68 ff 85 10 80       	push   $0x801085ff
801011f8:	e8 93 f1 ff ff       	call   80100390 <panic>
801011fd:	8d 76 00             	lea    0x0(%esi),%esi

80101200 <balloc>:
{
80101200:	55                   	push   %ebp
80101201:	89 e5                	mov    %esp,%ebp
80101203:	57                   	push   %edi
80101204:	56                   	push   %esi
80101205:	53                   	push   %ebx
80101206:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101209:	8b 0d c0 29 11 80    	mov    0x801129c0,%ecx
{
8010120f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101212:	85 c9                	test   %ecx,%ecx
80101214:	0f 84 87 00 00 00    	je     801012a1 <balloc+0xa1>
8010121a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101221:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101224:	83 ec 08             	sub    $0x8,%esp
80101227:	89 f0                	mov    %esi,%eax
80101229:	c1 f8 0c             	sar    $0xc,%eax
8010122c:	03 05 d8 29 11 80    	add    0x801129d8,%eax
80101232:	50                   	push   %eax
80101233:	ff 75 d8             	pushl  -0x28(%ebp)
80101236:	e8 95 ee ff ff       	call   801000d0 <bread>
8010123b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010123e:	a1 c0 29 11 80       	mov    0x801129c0,%eax
80101243:	83 c4 10             	add    $0x10,%esp
80101246:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101249:	31 c0                	xor    %eax,%eax
8010124b:	eb 2f                	jmp    8010127c <balloc+0x7c>
8010124d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101250:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101252:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101255:	bb 01 00 00 00       	mov    $0x1,%ebx
8010125a:	83 e1 07             	and    $0x7,%ecx
8010125d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010125f:	89 c1                	mov    %eax,%ecx
80101261:	c1 f9 03             	sar    $0x3,%ecx
80101264:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101269:	85 df                	test   %ebx,%edi
8010126b:	89 fa                	mov    %edi,%edx
8010126d:	74 41                	je     801012b0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010126f:	83 c0 01             	add    $0x1,%eax
80101272:	83 c6 01             	add    $0x1,%esi
80101275:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010127a:	74 05                	je     80101281 <balloc+0x81>
8010127c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010127f:	77 cf                	ja     80101250 <balloc+0x50>
    brelse(bp);
80101281:	83 ec 0c             	sub    $0xc,%esp
80101284:	ff 75 e4             	pushl  -0x1c(%ebp)
80101287:	e8 54 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010128c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101293:	83 c4 10             	add    $0x10,%esp
80101296:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101299:	39 05 c0 29 11 80    	cmp    %eax,0x801129c0
8010129f:	77 80                	ja     80101221 <balloc+0x21>
  panic("balloc: out of blocks");
801012a1:	83 ec 0c             	sub    $0xc,%esp
801012a4:	68 12 86 10 80       	push   $0x80108612
801012a9:	e8 e2 f0 ff ff       	call   80100390 <panic>
801012ae:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012b3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012b6:	09 da                	or     %ebx,%edx
801012b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012bc:	57                   	push   %edi
801012bd:	e8 be 20 00 00       	call   80103380 <log_write>
        brelse(bp);
801012c2:	89 3c 24             	mov    %edi,(%esp)
801012c5:	e8 16 ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801012ca:	58                   	pop    %eax
801012cb:	5a                   	pop    %edx
801012cc:	56                   	push   %esi
801012cd:	ff 75 d8             	pushl  -0x28(%ebp)
801012d0:	e8 fb ed ff ff       	call   801000d0 <bread>
801012d5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801012da:	83 c4 0c             	add    $0xc,%esp
801012dd:	68 00 02 00 00       	push   $0x200
801012e2:	6a 00                	push   $0x0
801012e4:	50                   	push   %eax
801012e5:	e8 96 3a 00 00       	call   80104d80 <memset>
  log_write(bp);
801012ea:	89 1c 24             	mov    %ebx,(%esp)
801012ed:	e8 8e 20 00 00       	call   80103380 <log_write>
  brelse(bp);
801012f2:	89 1c 24             	mov    %ebx,(%esp)
801012f5:	e8 e6 ee ff ff       	call   801001e0 <brelse>
}
801012fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012fd:	89 f0                	mov    %esi,%eax
801012ff:	5b                   	pop    %ebx
80101300:	5e                   	pop    %esi
80101301:	5f                   	pop    %edi
80101302:	5d                   	pop    %ebp
80101303:	c3                   	ret    
80101304:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010130a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101310 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101310:	55                   	push   %ebp
80101311:	89 e5                	mov    %esp,%ebp
80101313:	57                   	push   %edi
80101314:	56                   	push   %esi
80101315:	53                   	push   %ebx
80101316:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101318:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010131a:	bb 14 2a 11 80       	mov    $0x80112a14,%ebx
{
8010131f:	83 ec 28             	sub    $0x28,%esp
80101322:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101325:	68 e0 29 11 80       	push   $0x801129e0
8010132a:	e8 41 39 00 00       	call   80104c70 <acquire>
8010132f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101335:	eb 17                	jmp    8010134e <iget+0x3e>
80101337:	89 f6                	mov    %esi,%esi
80101339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101340:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101346:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010134c:	73 22                	jae    80101370 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010134e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101351:	85 c9                	test   %ecx,%ecx
80101353:	7e 04                	jle    80101359 <iget+0x49>
80101355:	39 3b                	cmp    %edi,(%ebx)
80101357:	74 4f                	je     801013a8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101359:	85 f6                	test   %esi,%esi
8010135b:	75 e3                	jne    80101340 <iget+0x30>
8010135d:	85 c9                	test   %ecx,%ecx
8010135f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101362:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101368:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010136e:	72 de                	jb     8010134e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101370:	85 f6                	test   %esi,%esi
80101372:	74 5b                	je     801013cf <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101374:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101377:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101379:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010137c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101383:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010138a:	68 e0 29 11 80       	push   $0x801129e0
8010138f:	e8 9c 39 00 00       	call   80104d30 <release>

  return ip;
80101394:	83 c4 10             	add    $0x10,%esp
}
80101397:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010139a:	89 f0                	mov    %esi,%eax
8010139c:	5b                   	pop    %ebx
8010139d:	5e                   	pop    %esi
8010139e:	5f                   	pop    %edi
8010139f:	5d                   	pop    %ebp
801013a0:	c3                   	ret    
801013a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013a8:	39 53 04             	cmp    %edx,0x4(%ebx)
801013ab:	75 ac                	jne    80101359 <iget+0x49>
      release(&icache.lock);
801013ad:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801013b0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801013b3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801013b5:	68 e0 29 11 80       	push   $0x801129e0
      ip->ref++;
801013ba:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801013bd:	e8 6e 39 00 00       	call   80104d30 <release>
      return ip;
801013c2:	83 c4 10             	add    $0x10,%esp
}
801013c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013c8:	89 f0                	mov    %esi,%eax
801013ca:	5b                   	pop    %ebx
801013cb:	5e                   	pop    %esi
801013cc:	5f                   	pop    %edi
801013cd:	5d                   	pop    %ebp
801013ce:	c3                   	ret    
    panic("iget: no inodes");
801013cf:	83 ec 0c             	sub    $0xc,%esp
801013d2:	68 28 86 10 80       	push   $0x80108628
801013d7:	e8 b4 ef ff ff       	call   80100390 <panic>
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	57                   	push   %edi
801013e4:	56                   	push   %esi
801013e5:	53                   	push   %ebx
801013e6:	89 c6                	mov    %eax,%esi
801013e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801013eb:	83 fa 0b             	cmp    $0xb,%edx
801013ee:	77 18                	ja     80101408 <bmap+0x28>
801013f0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801013f3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801013f6:	85 db                	test   %ebx,%ebx
801013f8:	74 76                	je     80101470 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fd:	89 d8                	mov    %ebx,%eax
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5f                   	pop    %edi
80101402:	5d                   	pop    %ebp
80101403:	c3                   	ret    
80101404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101408:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010140b:	83 fb 7f             	cmp    $0x7f,%ebx
8010140e:	0f 87 90 00 00 00    	ja     801014a4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101414:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010141a:	8b 00                	mov    (%eax),%eax
8010141c:	85 d2                	test   %edx,%edx
8010141e:	74 70                	je     80101490 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101420:	83 ec 08             	sub    $0x8,%esp
80101423:	52                   	push   %edx
80101424:	50                   	push   %eax
80101425:	e8 a6 ec ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010142a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010142e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101431:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101433:	8b 1a                	mov    (%edx),%ebx
80101435:	85 db                	test   %ebx,%ebx
80101437:	75 1d                	jne    80101456 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101439:	8b 06                	mov    (%esi),%eax
8010143b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010143e:	e8 bd fd ff ff       	call   80101200 <balloc>
80101443:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101446:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101449:	89 c3                	mov    %eax,%ebx
8010144b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010144d:	57                   	push   %edi
8010144e:	e8 2d 1f 00 00       	call   80103380 <log_write>
80101453:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101456:	83 ec 0c             	sub    $0xc,%esp
80101459:	57                   	push   %edi
8010145a:	e8 81 ed ff ff       	call   801001e0 <brelse>
8010145f:	83 c4 10             	add    $0x10,%esp
}
80101462:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101465:	89 d8                	mov    %ebx,%eax
80101467:	5b                   	pop    %ebx
80101468:	5e                   	pop    %esi
80101469:	5f                   	pop    %edi
8010146a:	5d                   	pop    %ebp
8010146b:	c3                   	ret    
8010146c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101470:	8b 00                	mov    (%eax),%eax
80101472:	e8 89 fd ff ff       	call   80101200 <balloc>
80101477:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010147a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010147d:	89 c3                	mov    %eax,%ebx
}
8010147f:	89 d8                	mov    %ebx,%eax
80101481:	5b                   	pop    %ebx
80101482:	5e                   	pop    %esi
80101483:	5f                   	pop    %edi
80101484:	5d                   	pop    %ebp
80101485:	c3                   	ret    
80101486:	8d 76 00             	lea    0x0(%esi),%esi
80101489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101490:	e8 6b fd ff ff       	call   80101200 <balloc>
80101495:	89 c2                	mov    %eax,%edx
80101497:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010149d:	8b 06                	mov    (%esi),%eax
8010149f:	e9 7c ff ff ff       	jmp    80101420 <bmap+0x40>
  panic("bmap: out of range");
801014a4:	83 ec 0c             	sub    $0xc,%esp
801014a7:	68 38 86 10 80       	push   $0x80108638
801014ac:	e8 df ee ff ff       	call   80100390 <panic>
801014b1:	eb 0d                	jmp    801014c0 <readsb>
801014b3:	90                   	nop
801014b4:	90                   	nop
801014b5:	90                   	nop
801014b6:	90                   	nop
801014b7:	90                   	nop
801014b8:	90                   	nop
801014b9:	90                   	nop
801014ba:	90                   	nop
801014bb:	90                   	nop
801014bc:	90                   	nop
801014bd:	90                   	nop
801014be:	90                   	nop
801014bf:	90                   	nop

801014c0 <readsb>:
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	56                   	push   %esi
801014c4:	53                   	push   %ebx
801014c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801014c8:	83 ec 08             	sub    $0x8,%esp
801014cb:	6a 01                	push   $0x1
801014cd:	ff 75 08             	pushl  0x8(%ebp)
801014d0:	e8 fb eb ff ff       	call   801000d0 <bread>
801014d5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801014d7:	8d 40 5c             	lea    0x5c(%eax),%eax
801014da:	83 c4 0c             	add    $0xc,%esp
801014dd:	6a 1c                	push   $0x1c
801014df:	50                   	push   %eax
801014e0:	56                   	push   %esi
801014e1:	e8 4a 39 00 00       	call   80104e30 <memmove>
  brelse(bp);
801014e6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801014e9:	83 c4 10             	add    $0x10,%esp
}
801014ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801014ef:	5b                   	pop    %ebx
801014f0:	5e                   	pop    %esi
801014f1:	5d                   	pop    %ebp
  brelse(bp);
801014f2:	e9 e9 ec ff ff       	jmp    801001e0 <brelse>
801014f7:	89 f6                	mov    %esi,%esi
801014f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101500 <iinit>:
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	53                   	push   %ebx
80101504:	bb 20 2a 11 80       	mov    $0x80112a20,%ebx
80101509:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010150c:	68 4b 86 10 80       	push   $0x8010864b
80101511:	68 e0 29 11 80       	push   $0x801129e0
80101516:	e8 15 36 00 00       	call   80104b30 <initlock>
8010151b:	83 c4 10             	add    $0x10,%esp
8010151e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101520:	83 ec 08             	sub    $0x8,%esp
80101523:	68 52 86 10 80       	push   $0x80108652
80101528:	53                   	push   %ebx
80101529:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010152f:	e8 cc 34 00 00       	call   80104a00 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101534:	83 c4 10             	add    $0x10,%esp
80101537:	81 fb 40 46 11 80    	cmp    $0x80114640,%ebx
8010153d:	75 e1                	jne    80101520 <iinit+0x20>
  readsb(dev, &sb);
8010153f:	83 ec 08             	sub    $0x8,%esp
80101542:	68 c0 29 11 80       	push   $0x801129c0
80101547:	ff 75 08             	pushl  0x8(%ebp)
8010154a:	e8 71 ff ff ff       	call   801014c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010154f:	ff 35 d8 29 11 80    	pushl  0x801129d8
80101555:	ff 35 d4 29 11 80    	pushl  0x801129d4
8010155b:	ff 35 d0 29 11 80    	pushl  0x801129d0
80101561:	ff 35 cc 29 11 80    	pushl  0x801129cc
80101567:	ff 35 c8 29 11 80    	pushl  0x801129c8
8010156d:	ff 35 c4 29 11 80    	pushl  0x801129c4
80101573:	ff 35 c0 29 11 80    	pushl  0x801129c0
80101579:	68 fc 86 10 80       	push   $0x801086fc
8010157e:	e8 dd f0 ff ff       	call   80100660 <cprintf>
}
80101583:	83 c4 30             	add    $0x30,%esp
80101586:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101589:	c9                   	leave  
8010158a:	c3                   	ret    
8010158b:	90                   	nop
8010158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101590 <ialloc>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	57                   	push   %edi
80101594:	56                   	push   %esi
80101595:	53                   	push   %ebx
80101596:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101599:	83 3d c8 29 11 80 01 	cmpl   $0x1,0x801129c8
{
801015a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801015a3:	8b 75 08             	mov    0x8(%ebp),%esi
801015a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801015a9:	0f 86 91 00 00 00    	jbe    80101640 <ialloc+0xb0>
801015af:	bb 01 00 00 00       	mov    $0x1,%ebx
801015b4:	eb 21                	jmp    801015d7 <ialloc+0x47>
801015b6:	8d 76 00             	lea    0x0(%esi),%esi
801015b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801015c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801015c3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801015c6:	57                   	push   %edi
801015c7:	e8 14 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801015cc:	83 c4 10             	add    $0x10,%esp
801015cf:	39 1d c8 29 11 80    	cmp    %ebx,0x801129c8
801015d5:	76 69                	jbe    80101640 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015d7:	89 d8                	mov    %ebx,%eax
801015d9:	83 ec 08             	sub    $0x8,%esp
801015dc:	c1 e8 03             	shr    $0x3,%eax
801015df:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801015e5:	50                   	push   %eax
801015e6:	56                   	push   %esi
801015e7:	e8 e4 ea ff ff       	call   801000d0 <bread>
801015ec:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801015ee:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801015f0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801015f3:	83 e0 07             	and    $0x7,%eax
801015f6:	c1 e0 06             	shl    $0x6,%eax
801015f9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101601:	75 bd                	jne    801015c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101603:	83 ec 04             	sub    $0x4,%esp
80101606:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101609:	6a 40                	push   $0x40
8010160b:	6a 00                	push   $0x0
8010160d:	51                   	push   %ecx
8010160e:	e8 6d 37 00 00       	call   80104d80 <memset>
      dip->type = type;
80101613:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101617:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010161a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010161d:	89 3c 24             	mov    %edi,(%esp)
80101620:	e8 5b 1d 00 00       	call   80103380 <log_write>
      brelse(bp);
80101625:	89 3c 24             	mov    %edi,(%esp)
80101628:	e8 b3 eb ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010162d:	83 c4 10             	add    $0x10,%esp
}
80101630:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101633:	89 da                	mov    %ebx,%edx
80101635:	89 f0                	mov    %esi,%eax
}
80101637:	5b                   	pop    %ebx
80101638:	5e                   	pop    %esi
80101639:	5f                   	pop    %edi
8010163a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010163b:	e9 d0 fc ff ff       	jmp    80101310 <iget>
  panic("ialloc: no inodes");
80101640:	83 ec 0c             	sub    $0xc,%esp
80101643:	68 58 86 10 80       	push   $0x80108658
80101648:	e8 43 ed ff ff       	call   80100390 <panic>
8010164d:	8d 76 00             	lea    0x0(%esi),%esi

80101650 <iupdate>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	56                   	push   %esi
80101654:	53                   	push   %ebx
80101655:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101658:	83 ec 08             	sub    $0x8,%esp
8010165b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101661:	c1 e8 03             	shr    $0x3,%eax
80101664:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010166a:	50                   	push   %eax
8010166b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010166e:	e8 5d ea ff ff       	call   801000d0 <bread>
80101673:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101675:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101678:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010167c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010167f:	83 e0 07             	and    $0x7,%eax
80101682:	c1 e0 06             	shl    $0x6,%eax
80101685:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101689:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010168c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101690:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101693:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101697:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010169b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010169f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801016a3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801016a7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801016aa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016ad:	6a 34                	push   $0x34
801016af:	53                   	push   %ebx
801016b0:	50                   	push   %eax
801016b1:	e8 7a 37 00 00       	call   80104e30 <memmove>
  log_write(bp);
801016b6:	89 34 24             	mov    %esi,(%esp)
801016b9:	e8 c2 1c 00 00       	call   80103380 <log_write>
  brelse(bp);
801016be:	89 75 08             	mov    %esi,0x8(%ebp)
801016c1:	83 c4 10             	add    $0x10,%esp
}
801016c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c7:	5b                   	pop    %ebx
801016c8:	5e                   	pop    %esi
801016c9:	5d                   	pop    %ebp
  brelse(bp);
801016ca:	e9 11 eb ff ff       	jmp    801001e0 <brelse>
801016cf:	90                   	nop

801016d0 <idup>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	53                   	push   %ebx
801016d4:	83 ec 10             	sub    $0x10,%esp
801016d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016da:	68 e0 29 11 80       	push   $0x801129e0
801016df:	e8 8c 35 00 00       	call   80104c70 <acquire>
  ip->ref++;
801016e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016e8:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801016ef:	e8 3c 36 00 00       	call   80104d30 <release>
}
801016f4:	89 d8                	mov    %ebx,%eax
801016f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016f9:	c9                   	leave  
801016fa:	c3                   	ret    
801016fb:	90                   	nop
801016fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101700 <ilock>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	56                   	push   %esi
80101704:	53                   	push   %ebx
80101705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101708:	85 db                	test   %ebx,%ebx
8010170a:	0f 84 b7 00 00 00    	je     801017c7 <ilock+0xc7>
80101710:	8b 53 08             	mov    0x8(%ebx),%edx
80101713:	85 d2                	test   %edx,%edx
80101715:	0f 8e ac 00 00 00    	jle    801017c7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010171b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010171e:	83 ec 0c             	sub    $0xc,%esp
80101721:	50                   	push   %eax
80101722:	e8 19 33 00 00       	call   80104a40 <acquiresleep>
  if(ip->valid == 0){
80101727:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010172a:	83 c4 10             	add    $0x10,%esp
8010172d:	85 c0                	test   %eax,%eax
8010172f:	74 0f                	je     80101740 <ilock+0x40>
}
80101731:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101734:	5b                   	pop    %ebx
80101735:	5e                   	pop    %esi
80101736:	5d                   	pop    %ebp
80101737:	c3                   	ret    
80101738:	90                   	nop
80101739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101740:	8b 43 04             	mov    0x4(%ebx),%eax
80101743:	83 ec 08             	sub    $0x8,%esp
80101746:	c1 e8 03             	shr    $0x3,%eax
80101749:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010174f:	50                   	push   %eax
80101750:	ff 33                	pushl  (%ebx)
80101752:	e8 79 e9 ff ff       	call   801000d0 <bread>
80101757:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101759:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010175c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010175f:	83 e0 07             	and    $0x7,%eax
80101762:	c1 e0 06             	shl    $0x6,%eax
80101765:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101769:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010176c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010176f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101773:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101777:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010177b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010177f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101783:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101787:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010178b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010178e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101791:	6a 34                	push   $0x34
80101793:	50                   	push   %eax
80101794:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101797:	50                   	push   %eax
80101798:	e8 93 36 00 00       	call   80104e30 <memmove>
    brelse(bp);
8010179d:	89 34 24             	mov    %esi,(%esp)
801017a0:	e8 3b ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
801017a5:	83 c4 10             	add    $0x10,%esp
801017a8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
801017ad:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801017b4:	0f 85 77 ff ff ff    	jne    80101731 <ilock+0x31>
      panic("ilock: no type");
801017ba:	83 ec 0c             	sub    $0xc,%esp
801017bd:	68 70 86 10 80       	push   $0x80108670
801017c2:	e8 c9 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017c7:	83 ec 0c             	sub    $0xc,%esp
801017ca:	68 6a 86 10 80       	push   $0x8010866a
801017cf:	e8 bc eb ff ff       	call   80100390 <panic>
801017d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017e0 <iunlock>:
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	56                   	push   %esi
801017e4:	53                   	push   %ebx
801017e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017e8:	85 db                	test   %ebx,%ebx
801017ea:	74 28                	je     80101814 <iunlock+0x34>
801017ec:	8d 73 0c             	lea    0xc(%ebx),%esi
801017ef:	83 ec 0c             	sub    $0xc,%esp
801017f2:	56                   	push   %esi
801017f3:	e8 e8 32 00 00       	call   80104ae0 <holdingsleep>
801017f8:	83 c4 10             	add    $0x10,%esp
801017fb:	85 c0                	test   %eax,%eax
801017fd:	74 15                	je     80101814 <iunlock+0x34>
801017ff:	8b 43 08             	mov    0x8(%ebx),%eax
80101802:	85 c0                	test   %eax,%eax
80101804:	7e 0e                	jle    80101814 <iunlock+0x34>
  releasesleep(&ip->lock);
80101806:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101809:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010180f:	e9 8c 32 00 00       	jmp    80104aa0 <releasesleep>
    panic("iunlock");
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	68 7f 86 10 80       	push   $0x8010867f
8010181c:	e8 6f eb ff ff       	call   80100390 <panic>
80101821:	eb 0d                	jmp    80101830 <iput>
80101823:	90                   	nop
80101824:	90                   	nop
80101825:	90                   	nop
80101826:	90                   	nop
80101827:	90                   	nop
80101828:	90                   	nop
80101829:	90                   	nop
8010182a:	90                   	nop
8010182b:	90                   	nop
8010182c:	90                   	nop
8010182d:	90                   	nop
8010182e:	90                   	nop
8010182f:	90                   	nop

80101830 <iput>:
{
80101830:	55                   	push   %ebp
80101831:	89 e5                	mov    %esp,%ebp
80101833:	57                   	push   %edi
80101834:	56                   	push   %esi
80101835:	53                   	push   %ebx
80101836:	83 ec 28             	sub    $0x28,%esp
80101839:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010183c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010183f:	57                   	push   %edi
80101840:	e8 fb 31 00 00       	call   80104a40 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101845:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101848:	83 c4 10             	add    $0x10,%esp
8010184b:	85 d2                	test   %edx,%edx
8010184d:	74 07                	je     80101856 <iput+0x26>
8010184f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101854:	74 32                	je     80101888 <iput+0x58>
  releasesleep(&ip->lock);
80101856:	83 ec 0c             	sub    $0xc,%esp
80101859:	57                   	push   %edi
8010185a:	e8 41 32 00 00       	call   80104aa0 <releasesleep>
  acquire(&icache.lock);
8010185f:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101866:	e8 05 34 00 00       	call   80104c70 <acquire>
  ip->ref--;
8010186b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010186f:	83 c4 10             	add    $0x10,%esp
80101872:	c7 45 08 e0 29 11 80 	movl   $0x801129e0,0x8(%ebp)
}
80101879:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010187c:	5b                   	pop    %ebx
8010187d:	5e                   	pop    %esi
8010187e:	5f                   	pop    %edi
8010187f:	5d                   	pop    %ebp
  release(&icache.lock);
80101880:	e9 ab 34 00 00       	jmp    80104d30 <release>
80101885:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101888:	83 ec 0c             	sub    $0xc,%esp
8010188b:	68 e0 29 11 80       	push   $0x801129e0
80101890:	e8 db 33 00 00       	call   80104c70 <acquire>
    int r = ip->ref;
80101895:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101898:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010189f:	e8 8c 34 00 00       	call   80104d30 <release>
    if(r == 1){
801018a4:	83 c4 10             	add    $0x10,%esp
801018a7:	83 fe 01             	cmp    $0x1,%esi
801018aa:	75 aa                	jne    80101856 <iput+0x26>
801018ac:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801018b2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801018b5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801018b8:	89 cf                	mov    %ecx,%edi
801018ba:	eb 0b                	jmp    801018c7 <iput+0x97>
801018bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018c0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801018c3:	39 fe                	cmp    %edi,%esi
801018c5:	74 19                	je     801018e0 <iput+0xb0>
    if(ip->addrs[i]){
801018c7:	8b 16                	mov    (%esi),%edx
801018c9:	85 d2                	test   %edx,%edx
801018cb:	74 f3                	je     801018c0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801018cd:	8b 03                	mov    (%ebx),%eax
801018cf:	e8 bc f8 ff ff       	call   80101190 <bfree>
      ip->addrs[i] = 0;
801018d4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801018da:	eb e4                	jmp    801018c0 <iput+0x90>
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801018e0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018e6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018e9:	85 c0                	test   %eax,%eax
801018eb:	75 33                	jne    80101920 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801018ed:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801018f0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018f7:	53                   	push   %ebx
801018f8:	e8 53 fd ff ff       	call   80101650 <iupdate>
      ip->type = 0;
801018fd:	31 c0                	xor    %eax,%eax
801018ff:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101903:	89 1c 24             	mov    %ebx,(%esp)
80101906:	e8 45 fd ff ff       	call   80101650 <iupdate>
      ip->valid = 0;
8010190b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101912:	83 c4 10             	add    $0x10,%esp
80101915:	e9 3c ff ff ff       	jmp    80101856 <iput+0x26>
8010191a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101920:	83 ec 08             	sub    $0x8,%esp
80101923:	50                   	push   %eax
80101924:	ff 33                	pushl  (%ebx)
80101926:	e8 a5 e7 ff ff       	call   801000d0 <bread>
8010192b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101931:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101934:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101937:	8d 70 5c             	lea    0x5c(%eax),%esi
8010193a:	83 c4 10             	add    $0x10,%esp
8010193d:	89 cf                	mov    %ecx,%edi
8010193f:	eb 0e                	jmp    8010194f <iput+0x11f>
80101941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101948:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
8010194b:	39 fe                	cmp    %edi,%esi
8010194d:	74 0f                	je     8010195e <iput+0x12e>
      if(a[j])
8010194f:	8b 16                	mov    (%esi),%edx
80101951:	85 d2                	test   %edx,%edx
80101953:	74 f3                	je     80101948 <iput+0x118>
        bfree(ip->dev, a[j]);
80101955:	8b 03                	mov    (%ebx),%eax
80101957:	e8 34 f8 ff ff       	call   80101190 <bfree>
8010195c:	eb ea                	jmp    80101948 <iput+0x118>
    brelse(bp);
8010195e:	83 ec 0c             	sub    $0xc,%esp
80101961:	ff 75 e4             	pushl  -0x1c(%ebp)
80101964:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101967:	e8 74 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010196c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101972:	8b 03                	mov    (%ebx),%eax
80101974:	e8 17 f8 ff ff       	call   80101190 <bfree>
    ip->addrs[NDIRECT] = 0;
80101979:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101980:	00 00 00 
80101983:	83 c4 10             	add    $0x10,%esp
80101986:	e9 62 ff ff ff       	jmp    801018ed <iput+0xbd>
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <iunlockput>:
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	53                   	push   %ebx
80101994:	83 ec 10             	sub    $0x10,%esp
80101997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010199a:	53                   	push   %ebx
8010199b:	e8 40 fe ff ff       	call   801017e0 <iunlock>
  iput(ip);
801019a0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019a3:	83 c4 10             	add    $0x10,%esp
}
801019a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019a9:	c9                   	leave  
  iput(ip);
801019aa:	e9 81 fe ff ff       	jmp    80101830 <iput>
801019af:	90                   	nop

801019b0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801019b0:	55                   	push   %ebp
801019b1:	89 e5                	mov    %esp,%ebp
801019b3:	8b 55 08             	mov    0x8(%ebp),%edx
801019b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801019b9:	8b 0a                	mov    (%edx),%ecx
801019bb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801019be:	8b 4a 04             	mov    0x4(%edx),%ecx
801019c1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019c4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019c8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019cb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019cf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019d3:	8b 52 58             	mov    0x58(%edx),%edx
801019d6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019d9:	5d                   	pop    %ebp
801019da:	c3                   	ret    
801019db:	90                   	nop
801019dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019e0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	57                   	push   %edi
801019e4:	56                   	push   %esi
801019e5:	53                   	push   %ebx
801019e6:	83 ec 1c             	sub    $0x1c,%esp
801019e9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801019ef:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019f2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801019f7:	89 75 e0             	mov    %esi,-0x20(%ebp)
801019fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019fd:	8b 75 10             	mov    0x10(%ebp),%esi
80101a00:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101a03:	0f 84 a7 00 00 00    	je     80101ab0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101a09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a0c:	8b 40 58             	mov    0x58(%eax),%eax
80101a0f:	39 c6                	cmp    %eax,%esi
80101a11:	0f 87 ba 00 00 00    	ja     80101ad1 <readi+0xf1>
80101a17:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a1a:	89 f9                	mov    %edi,%ecx
80101a1c:	01 f1                	add    %esi,%ecx
80101a1e:	0f 82 ad 00 00 00    	jb     80101ad1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a24:	89 c2                	mov    %eax,%edx
80101a26:	29 f2                	sub    %esi,%edx
80101a28:	39 c8                	cmp    %ecx,%eax
80101a2a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a2d:	31 ff                	xor    %edi,%edi
80101a2f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101a31:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a34:	74 6c                	je     80101aa2 <readi+0xc2>
80101a36:	8d 76 00             	lea    0x0(%esi),%esi
80101a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a40:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a43:	89 f2                	mov    %esi,%edx
80101a45:	c1 ea 09             	shr    $0x9,%edx
80101a48:	89 d8                	mov    %ebx,%eax
80101a4a:	e8 91 f9 ff ff       	call   801013e0 <bmap>
80101a4f:	83 ec 08             	sub    $0x8,%esp
80101a52:	50                   	push   %eax
80101a53:	ff 33                	pushl  (%ebx)
80101a55:	e8 76 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a5a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a5d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a5f:	89 f0                	mov    %esi,%eax
80101a61:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a66:	b9 00 02 00 00       	mov    $0x200,%ecx
80101a6b:	83 c4 0c             	add    $0xc,%esp
80101a6e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a70:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a74:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a77:	29 fb                	sub    %edi,%ebx
80101a79:	39 d9                	cmp    %ebx,%ecx
80101a7b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a7e:	53                   	push   %ebx
80101a7f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a80:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a82:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a85:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a87:	e8 a4 33 00 00       	call   80104e30 <memmove>
    brelse(bp);
80101a8c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a8f:	89 14 24             	mov    %edx,(%esp)
80101a92:	e8 49 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a97:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a9a:	83 c4 10             	add    $0x10,%esp
80101a9d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101aa0:	77 9e                	ja     80101a40 <readi+0x60>
  }
  return n;
80101aa2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101aa5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101aa8:	5b                   	pop    %ebx
80101aa9:	5e                   	pop    %esi
80101aaa:	5f                   	pop    %edi
80101aab:	5d                   	pop    %ebp
80101aac:	c3                   	ret    
80101aad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ab0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ab4:	66 83 f8 09          	cmp    $0x9,%ax
80101ab8:	77 17                	ja     80101ad1 <readi+0xf1>
80101aba:	8b 04 c5 60 29 11 80 	mov    -0x7feed6a0(,%eax,8),%eax
80101ac1:	85 c0                	test   %eax,%eax
80101ac3:	74 0c                	je     80101ad1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ac5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101acb:	5b                   	pop    %ebx
80101acc:	5e                   	pop    %esi
80101acd:	5f                   	pop    %edi
80101ace:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101acf:	ff e0                	jmp    *%eax
      return -1;
80101ad1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ad6:	eb cd                	jmp    80101aa5 <readi+0xc5>
80101ad8:	90                   	nop
80101ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ae0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ae0:	55                   	push   %ebp
80101ae1:	89 e5                	mov    %esp,%ebp
80101ae3:	57                   	push   %edi
80101ae4:	56                   	push   %esi
80101ae5:	53                   	push   %ebx
80101ae6:	83 ec 1c             	sub    $0x1c,%esp
80101ae9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aec:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aef:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101af2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101af7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101afa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101afd:	8b 75 10             	mov    0x10(%ebp),%esi
80101b00:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101b03:	0f 84 b7 00 00 00    	je     80101bc0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101b09:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b0c:	39 70 58             	cmp    %esi,0x58(%eax)
80101b0f:	0f 82 eb 00 00 00    	jb     80101c00 <writei+0x120>
80101b15:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b18:	31 d2                	xor    %edx,%edx
80101b1a:	89 f8                	mov    %edi,%eax
80101b1c:	01 f0                	add    %esi,%eax
80101b1e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101b21:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101b26:	0f 87 d4 00 00 00    	ja     80101c00 <writei+0x120>
80101b2c:	85 d2                	test   %edx,%edx
80101b2e:	0f 85 cc 00 00 00    	jne    80101c00 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b34:	85 ff                	test   %edi,%edi
80101b36:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b3d:	74 72                	je     80101bb1 <writei+0xd1>
80101b3f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b40:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b43:	89 f2                	mov    %esi,%edx
80101b45:	c1 ea 09             	shr    $0x9,%edx
80101b48:	89 f8                	mov    %edi,%eax
80101b4a:	e8 91 f8 ff ff       	call   801013e0 <bmap>
80101b4f:	83 ec 08             	sub    $0x8,%esp
80101b52:	50                   	push   %eax
80101b53:	ff 37                	pushl  (%edi)
80101b55:	e8 76 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b5a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101b5d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b62:	89 f0                	mov    %esi,%eax
80101b64:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b69:	83 c4 0c             	add    $0xc,%esp
80101b6c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b71:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b73:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b77:	39 d9                	cmp    %ebx,%ecx
80101b79:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b7c:	53                   	push   %ebx
80101b7d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b80:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b82:	50                   	push   %eax
80101b83:	e8 a8 32 00 00       	call   80104e30 <memmove>
    log_write(bp);
80101b88:	89 3c 24             	mov    %edi,(%esp)
80101b8b:	e8 f0 17 00 00       	call   80103380 <log_write>
    brelse(bp);
80101b90:	89 3c 24             	mov    %edi,(%esp)
80101b93:	e8 48 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b98:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b9b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b9e:	83 c4 10             	add    $0x10,%esp
80101ba1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ba4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101ba7:	77 97                	ja     80101b40 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bac:	3b 70 58             	cmp    0x58(%eax),%esi
80101baf:	77 37                	ja     80101be8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101bb1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101bb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bb7:	5b                   	pop    %ebx
80101bb8:	5e                   	pop    %esi
80101bb9:	5f                   	pop    %edi
80101bba:	5d                   	pop    %ebp
80101bbb:	c3                   	ret    
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101bc0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101bc4:	66 83 f8 09          	cmp    $0x9,%ax
80101bc8:	77 36                	ja     80101c00 <writei+0x120>
80101bca:	8b 04 c5 64 29 11 80 	mov    -0x7feed69c(,%eax,8),%eax
80101bd1:	85 c0                	test   %eax,%eax
80101bd3:	74 2b                	je     80101c00 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101bd5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101bd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bdb:	5b                   	pop    %ebx
80101bdc:	5e                   	pop    %esi
80101bdd:	5f                   	pop    %edi
80101bde:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101bdf:	ff e0                	jmp    *%eax
80101be1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101be8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101beb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101bee:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101bf1:	50                   	push   %eax
80101bf2:	e8 59 fa ff ff       	call   80101650 <iupdate>
80101bf7:	83 c4 10             	add    $0x10,%esp
80101bfa:	eb b5                	jmp    80101bb1 <writei+0xd1>
80101bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c05:	eb ad                	jmp    80101bb4 <writei+0xd4>
80101c07:	89 f6                	mov    %esi,%esi
80101c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c10 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101c16:	6a 0e                	push   $0xe
80101c18:	ff 75 0c             	pushl  0xc(%ebp)
80101c1b:	ff 75 08             	pushl  0x8(%ebp)
80101c1e:	e8 7d 32 00 00       	call   80104ea0 <strncmp>
}
80101c23:	c9                   	leave  
80101c24:	c3                   	ret    
80101c25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c30 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c30:	55                   	push   %ebp
80101c31:	89 e5                	mov    %esp,%ebp
80101c33:	57                   	push   %edi
80101c34:	56                   	push   %esi
80101c35:	53                   	push   %ebx
80101c36:	83 ec 1c             	sub    $0x1c,%esp
80101c39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c3c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c41:	0f 85 85 00 00 00    	jne    80101ccc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c47:	8b 53 58             	mov    0x58(%ebx),%edx
80101c4a:	31 ff                	xor    %edi,%edi
80101c4c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c4f:	85 d2                	test   %edx,%edx
80101c51:	74 3e                	je     80101c91 <dirlookup+0x61>
80101c53:	90                   	nop
80101c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c58:	6a 10                	push   $0x10
80101c5a:	57                   	push   %edi
80101c5b:	56                   	push   %esi
80101c5c:	53                   	push   %ebx
80101c5d:	e8 7e fd ff ff       	call   801019e0 <readi>
80101c62:	83 c4 10             	add    $0x10,%esp
80101c65:	83 f8 10             	cmp    $0x10,%eax
80101c68:	75 55                	jne    80101cbf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101c6a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c6f:	74 18                	je     80101c89 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c71:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c74:	83 ec 04             	sub    $0x4,%esp
80101c77:	6a 0e                	push   $0xe
80101c79:	50                   	push   %eax
80101c7a:	ff 75 0c             	pushl  0xc(%ebp)
80101c7d:	e8 1e 32 00 00       	call   80104ea0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	85 c0                	test   %eax,%eax
80101c87:	74 17                	je     80101ca0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c89:	83 c7 10             	add    $0x10,%edi
80101c8c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c8f:	72 c7                	jb     80101c58 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c91:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c94:	31 c0                	xor    %eax,%eax
}
80101c96:	5b                   	pop    %ebx
80101c97:	5e                   	pop    %esi
80101c98:	5f                   	pop    %edi
80101c99:	5d                   	pop    %ebp
80101c9a:	c3                   	ret    
80101c9b:	90                   	nop
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101ca0:	8b 45 10             	mov    0x10(%ebp),%eax
80101ca3:	85 c0                	test   %eax,%eax
80101ca5:	74 05                	je     80101cac <dirlookup+0x7c>
        *poff = off;
80101ca7:	8b 45 10             	mov    0x10(%ebp),%eax
80101caa:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101cac:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101cb0:	8b 03                	mov    (%ebx),%eax
80101cb2:	e8 59 f6 ff ff       	call   80101310 <iget>
}
80101cb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cba:	5b                   	pop    %ebx
80101cbb:	5e                   	pop    %esi
80101cbc:	5f                   	pop    %edi
80101cbd:	5d                   	pop    %ebp
80101cbe:	c3                   	ret    
      panic("dirlookup read");
80101cbf:	83 ec 0c             	sub    $0xc,%esp
80101cc2:	68 99 86 10 80       	push   $0x80108699
80101cc7:	e8 c4 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101ccc:	83 ec 0c             	sub    $0xc,%esp
80101ccf:	68 87 86 10 80       	push   $0x80108687
80101cd4:	e8 b7 e6 ff ff       	call   80100390 <panic>
80101cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	89 cf                	mov    %ecx,%edi
80101ce8:	89 c3                	mov    %eax,%ebx
80101cea:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101ced:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cf0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101cf3:	0f 84 67 01 00 00    	je     80101e60 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cf9:	e8 92 21 00 00       	call   80103e90 <myproc>
  acquire(&icache.lock);
80101cfe:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d01:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d04:	68 e0 29 11 80       	push   $0x801129e0
80101d09:	e8 62 2f 00 00       	call   80104c70 <acquire>
  ip->ref++;
80101d0e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d12:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101d19:	e8 12 30 00 00       	call   80104d30 <release>
80101d1e:	83 c4 10             	add    $0x10,%esp
80101d21:	eb 08                	jmp    80101d2b <namex+0x4b>
80101d23:	90                   	nop
80101d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101d28:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d2b:	0f b6 03             	movzbl (%ebx),%eax
80101d2e:	3c 2f                	cmp    $0x2f,%al
80101d30:	74 f6                	je     80101d28 <namex+0x48>
  if(*path == 0)
80101d32:	84 c0                	test   %al,%al
80101d34:	0f 84 ee 00 00 00    	je     80101e28 <namex+0x148>
  while(*path != '/' && *path != 0)
80101d3a:	0f b6 03             	movzbl (%ebx),%eax
80101d3d:	3c 2f                	cmp    $0x2f,%al
80101d3f:	0f 84 b3 00 00 00    	je     80101df8 <namex+0x118>
80101d45:	84 c0                	test   %al,%al
80101d47:	89 da                	mov    %ebx,%edx
80101d49:	75 09                	jne    80101d54 <namex+0x74>
80101d4b:	e9 a8 00 00 00       	jmp    80101df8 <namex+0x118>
80101d50:	84 c0                	test   %al,%al
80101d52:	74 0a                	je     80101d5e <namex+0x7e>
    path++;
80101d54:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d57:	0f b6 02             	movzbl (%edx),%eax
80101d5a:	3c 2f                	cmp    $0x2f,%al
80101d5c:	75 f2                	jne    80101d50 <namex+0x70>
80101d5e:	89 d1                	mov    %edx,%ecx
80101d60:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d62:	83 f9 0d             	cmp    $0xd,%ecx
80101d65:	0f 8e 91 00 00 00    	jle    80101dfc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101d6b:	83 ec 04             	sub    $0x4,%esp
80101d6e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d71:	6a 0e                	push   $0xe
80101d73:	53                   	push   %ebx
80101d74:	57                   	push   %edi
80101d75:	e8 b6 30 00 00       	call   80104e30 <memmove>
    path++;
80101d7a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d7d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d80:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d82:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d85:	75 11                	jne    80101d98 <namex+0xb8>
80101d87:	89 f6                	mov    %esi,%esi
80101d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d90:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d93:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d96:	74 f8                	je     80101d90 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d98:	83 ec 0c             	sub    $0xc,%esp
80101d9b:	56                   	push   %esi
80101d9c:	e8 5f f9 ff ff       	call   80101700 <ilock>
    if(ip->type != T_DIR){
80101da1:	83 c4 10             	add    $0x10,%esp
80101da4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101da9:	0f 85 91 00 00 00    	jne    80101e40 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101daf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101db2:	85 d2                	test   %edx,%edx
80101db4:	74 09                	je     80101dbf <namex+0xdf>
80101db6:	80 3b 00             	cmpb   $0x0,(%ebx)
80101db9:	0f 84 b7 00 00 00    	je     80101e76 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101dbf:	83 ec 04             	sub    $0x4,%esp
80101dc2:	6a 00                	push   $0x0
80101dc4:	57                   	push   %edi
80101dc5:	56                   	push   %esi
80101dc6:	e8 65 fe ff ff       	call   80101c30 <dirlookup>
80101dcb:	83 c4 10             	add    $0x10,%esp
80101dce:	85 c0                	test   %eax,%eax
80101dd0:	74 6e                	je     80101e40 <namex+0x160>
  iunlock(ip);
80101dd2:	83 ec 0c             	sub    $0xc,%esp
80101dd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101dd8:	56                   	push   %esi
80101dd9:	e8 02 fa ff ff       	call   801017e0 <iunlock>
  iput(ip);
80101dde:	89 34 24             	mov    %esi,(%esp)
80101de1:	e8 4a fa ff ff       	call   80101830 <iput>
80101de6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101de9:	83 c4 10             	add    $0x10,%esp
80101dec:	89 c6                	mov    %eax,%esi
80101dee:	e9 38 ff ff ff       	jmp    80101d2b <namex+0x4b>
80101df3:	90                   	nop
80101df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101df8:	89 da                	mov    %ebx,%edx
80101dfa:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101dfc:	83 ec 04             	sub    $0x4,%esp
80101dff:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e02:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101e05:	51                   	push   %ecx
80101e06:	53                   	push   %ebx
80101e07:	57                   	push   %edi
80101e08:	e8 23 30 00 00       	call   80104e30 <memmove>
    name[len] = 0;
80101e0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101e10:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101e13:	83 c4 10             	add    $0x10,%esp
80101e16:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101e1a:	89 d3                	mov    %edx,%ebx
80101e1c:	e9 61 ff ff ff       	jmp    80101d82 <namex+0xa2>
80101e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e28:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e2b:	85 c0                	test   %eax,%eax
80101e2d:	75 5d                	jne    80101e8c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101e2f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e32:	89 f0                	mov    %esi,%eax
80101e34:	5b                   	pop    %ebx
80101e35:	5e                   	pop    %esi
80101e36:	5f                   	pop    %edi
80101e37:	5d                   	pop    %ebp
80101e38:	c3                   	ret    
80101e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 97 f9 ff ff       	call   801017e0 <iunlock>
  iput(ip);
80101e49:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101e4c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101e4e:	e8 dd f9 ff ff       	call   80101830 <iput>
      return 0;
80101e53:	83 c4 10             	add    $0x10,%esp
}
80101e56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e59:	89 f0                	mov    %esi,%eax
80101e5b:	5b                   	pop    %ebx
80101e5c:	5e                   	pop    %esi
80101e5d:	5f                   	pop    %edi
80101e5e:	5d                   	pop    %ebp
80101e5f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e60:	ba 01 00 00 00       	mov    $0x1,%edx
80101e65:	b8 01 00 00 00       	mov    $0x1,%eax
80101e6a:	e8 a1 f4 ff ff       	call   80101310 <iget>
80101e6f:	89 c6                	mov    %eax,%esi
80101e71:	e9 b5 fe ff ff       	jmp    80101d2b <namex+0x4b>
      iunlock(ip);
80101e76:	83 ec 0c             	sub    $0xc,%esp
80101e79:	56                   	push   %esi
80101e7a:	e8 61 f9 ff ff       	call   801017e0 <iunlock>
      return ip;
80101e7f:	83 c4 10             	add    $0x10,%esp
}
80101e82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e85:	89 f0                	mov    %esi,%eax
80101e87:	5b                   	pop    %ebx
80101e88:	5e                   	pop    %esi
80101e89:	5f                   	pop    %edi
80101e8a:	5d                   	pop    %ebp
80101e8b:	c3                   	ret    
    iput(ip);
80101e8c:	83 ec 0c             	sub    $0xc,%esp
80101e8f:	56                   	push   %esi
    return 0;
80101e90:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e92:	e8 99 f9 ff ff       	call   80101830 <iput>
    return 0;
80101e97:	83 c4 10             	add    $0x10,%esp
80101e9a:	eb 93                	jmp    80101e2f <namex+0x14f>
80101e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ea0 <dirlink>:
{
80101ea0:	55                   	push   %ebp
80101ea1:	89 e5                	mov    %esp,%ebp
80101ea3:	57                   	push   %edi
80101ea4:	56                   	push   %esi
80101ea5:	53                   	push   %ebx
80101ea6:	83 ec 20             	sub    $0x20,%esp
80101ea9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101eac:	6a 00                	push   $0x0
80101eae:	ff 75 0c             	pushl  0xc(%ebp)
80101eb1:	53                   	push   %ebx
80101eb2:	e8 79 fd ff ff       	call   80101c30 <dirlookup>
80101eb7:	83 c4 10             	add    $0x10,%esp
80101eba:	85 c0                	test   %eax,%eax
80101ebc:	75 67                	jne    80101f25 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ebe:	8b 7b 58             	mov    0x58(%ebx),%edi
80101ec1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ec4:	85 ff                	test   %edi,%edi
80101ec6:	74 29                	je     80101ef1 <dirlink+0x51>
80101ec8:	31 ff                	xor    %edi,%edi
80101eca:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ecd:	eb 09                	jmp    80101ed8 <dirlink+0x38>
80101ecf:	90                   	nop
80101ed0:	83 c7 10             	add    $0x10,%edi
80101ed3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101ed6:	73 19                	jae    80101ef1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ed8:	6a 10                	push   $0x10
80101eda:	57                   	push   %edi
80101edb:	56                   	push   %esi
80101edc:	53                   	push   %ebx
80101edd:	e8 fe fa ff ff       	call   801019e0 <readi>
80101ee2:	83 c4 10             	add    $0x10,%esp
80101ee5:	83 f8 10             	cmp    $0x10,%eax
80101ee8:	75 4e                	jne    80101f38 <dirlink+0x98>
    if(de.inum == 0)
80101eea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eef:	75 df                	jne    80101ed0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101ef1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ef4:	83 ec 04             	sub    $0x4,%esp
80101ef7:	6a 0e                	push   $0xe
80101ef9:	ff 75 0c             	pushl  0xc(%ebp)
80101efc:	50                   	push   %eax
80101efd:	e8 fe 2f 00 00       	call   80104f00 <strncpy>
  de.inum = inum;
80101f02:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f05:	6a 10                	push   $0x10
80101f07:	57                   	push   %edi
80101f08:	56                   	push   %esi
80101f09:	53                   	push   %ebx
  de.inum = inum;
80101f0a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f0e:	e8 cd fb ff ff       	call   80101ae0 <writei>
80101f13:	83 c4 20             	add    $0x20,%esp
80101f16:	83 f8 10             	cmp    $0x10,%eax
80101f19:	75 2a                	jne    80101f45 <dirlink+0xa5>
  return 0;
80101f1b:	31 c0                	xor    %eax,%eax
}
80101f1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f20:	5b                   	pop    %ebx
80101f21:	5e                   	pop    %esi
80101f22:	5f                   	pop    %edi
80101f23:	5d                   	pop    %ebp
80101f24:	c3                   	ret    
    iput(ip);
80101f25:	83 ec 0c             	sub    $0xc,%esp
80101f28:	50                   	push   %eax
80101f29:	e8 02 f9 ff ff       	call   80101830 <iput>
    return -1;
80101f2e:	83 c4 10             	add    $0x10,%esp
80101f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f36:	eb e5                	jmp    80101f1d <dirlink+0x7d>
      panic("dirlink read");
80101f38:	83 ec 0c             	sub    $0xc,%esp
80101f3b:	68 a8 86 10 80       	push   $0x801086a8
80101f40:	e8 4b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f45:	83 ec 0c             	sub    $0xc,%esp
80101f48:	68 91 8d 10 80       	push   $0x80108d91
80101f4d:	e8 3e e4 ff ff       	call   80100390 <panic>
80101f52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f60 <namei>:

struct inode*
namei(char *path)
{
80101f60:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f61:	31 d2                	xor    %edx,%edx
{
80101f63:	89 e5                	mov    %esp,%ebp
80101f65:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f68:	8b 45 08             	mov    0x8(%ebp),%eax
80101f6b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f6e:	e8 6d fd ff ff       	call   80101ce0 <namex>
}
80101f73:	c9                   	leave  
80101f74:	c3                   	ret    
80101f75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f80 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f80:	55                   	push   %ebp
  return namex(path, 1, name);
80101f81:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f86:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f88:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f8b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f8e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f8f:	e9 4c fd ff ff       	jmp    80101ce0 <namex>
80101f94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101f9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101fa0 <itoa>:

#include "fcntl.h"
#define DIGITS 14

char* itoa(int i, char b[]){
80101fa0:	55                   	push   %ebp
    char const digit[] = "0123456789";
80101fa1:	b8 38 39 00 00       	mov    $0x3938,%eax
char* itoa(int i, char b[]){
80101fa6:	89 e5                	mov    %esp,%ebp
80101fa8:	57                   	push   %edi
80101fa9:	56                   	push   %esi
80101faa:	53                   	push   %ebx
80101fab:	83 ec 10             	sub    $0x10,%esp
80101fae:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80101fb1:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80101fb8:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
80101fbf:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80101fc3:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
80101fc7:	8b 75 0c             	mov    0xc(%ebp),%esi
    char* p = b;
    if(i<0){
80101fca:	85 c9                	test   %ecx,%ecx
80101fcc:	79 0a                	jns    80101fd8 <itoa+0x38>
80101fce:	89 f0                	mov    %esi,%eax
80101fd0:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
80101fd3:	f7 d9                	neg    %ecx
        *p++ = '-';
80101fd5:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
80101fd8:	89 cb                	mov    %ecx,%ebx
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
80101fda:	bf 67 66 66 66       	mov    $0x66666667,%edi
80101fdf:	90                   	nop
80101fe0:	89 d8                	mov    %ebx,%eax
80101fe2:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
80101fe5:	83 c6 01             	add    $0x1,%esi
        shifter = shifter/10;
80101fe8:	f7 ef                	imul   %edi
80101fea:	c1 fa 02             	sar    $0x2,%edx
    }while(shifter);
80101fed:	29 da                	sub    %ebx,%edx
80101fef:	89 d3                	mov    %edx,%ebx
80101ff1:	75 ed                	jne    80101fe0 <itoa+0x40>
    *p = '\0';
80101ff3:	c6 06 00             	movb   $0x0,(%esi)
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
80101ff6:	bb 67 66 66 66       	mov    $0x66666667,%ebx
80101ffb:	90                   	nop
80101ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102000:	89 c8                	mov    %ecx,%eax
80102002:	83 ee 01             	sub    $0x1,%esi
80102005:	f7 eb                	imul   %ebx
80102007:	89 c8                	mov    %ecx,%eax
80102009:	c1 f8 1f             	sar    $0x1f,%eax
8010200c:	c1 fa 02             	sar    $0x2,%edx
8010200f:	29 c2                	sub    %eax,%edx
80102011:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102014:	01 c0                	add    %eax,%eax
80102016:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
80102018:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
8010201a:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
8010201f:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80102021:	88 06                	mov    %al,(%esi)
    }while(i);
80102023:	75 db                	jne    80102000 <itoa+0x60>
    return b;
}
80102025:	8b 45 0c             	mov    0xc(%ebp),%eax
80102028:	83 c4 10             	add    $0x10,%esp
8010202b:	5b                   	pop    %ebx
8010202c:	5e                   	pop    %esi
8010202d:	5f                   	pop    %edi
8010202e:	5d                   	pop    %ebp
8010202f:	c3                   	ret    

80102030 <removeSwapFile>:
//remove swap file of proc p;
int
removeSwapFile(struct proc* p)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	57                   	push   %edi
80102034:	56                   	push   %esi
80102035:	53                   	push   %ebx
  //path of proccess
  char path[DIGITS];
  memmove(path,"/.swap", 6);
80102036:	8d 75 bc             	lea    -0x44(%ebp),%esi
{
80102039:	83 ec 40             	sub    $0x40,%esp
8010203c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
8010203f:	6a 06                	push   $0x6
80102041:	68 b5 86 10 80       	push   $0x801086b5
80102046:	56                   	push   %esi
80102047:	e8 e4 2d 00 00       	call   80104e30 <memmove>
  itoa(p->pid, path+ 6);
8010204c:	58                   	pop    %eax
8010204d:	8d 45 c2             	lea    -0x3e(%ebp),%eax
80102050:	5a                   	pop    %edx
80102051:	50                   	push   %eax
80102052:	ff 73 10             	pushl  0x10(%ebx)
80102055:	e8 46 ff ff ff       	call   80101fa0 <itoa>
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ];
  uint off;

  if(0 == p->swapFile)
8010205a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010205d:	83 c4 10             	add    $0x10,%esp
80102060:	85 c0                	test   %eax,%eax
80102062:	0f 84 88 01 00 00    	je     801021f0 <removeSwapFile+0x1c0>
  {
    return -1;
  }
  fileclose(p->swapFile);
80102068:	83 ec 0c             	sub    $0xc,%esp
  return namex(path, 1, name);
8010206b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  fileclose(p->swapFile);
8010206e:	50                   	push   %eax
8010206f:	e8 4c ee ff ff       	call   80100ec0 <fileclose>

  begin_op();
80102074:	e8 37 11 00 00       	call   801031b0 <begin_op>
  return namex(path, 1, name);
80102079:	89 f0                	mov    %esi,%eax
8010207b:	89 d9                	mov    %ebx,%ecx
8010207d:	ba 01 00 00 00       	mov    $0x1,%edx
80102082:	e8 59 fc ff ff       	call   80101ce0 <namex>
  if((dp = nameiparent(path, name)) == 0)
80102087:	83 c4 10             	add    $0x10,%esp
8010208a:	85 c0                	test   %eax,%eax
  return namex(path, 1, name);
8010208c:	89 c6                	mov    %eax,%esi
  if((dp = nameiparent(path, name)) == 0)
8010208e:	0f 84 66 01 00 00    	je     801021fa <removeSwapFile+0x1ca>
  {
    end_op();
    return -1;
  }

  ilock(dp);
80102094:	83 ec 0c             	sub    $0xc,%esp
80102097:	50                   	push   %eax
80102098:	e8 63 f6 ff ff       	call   80101700 <ilock>
  return strncmp(s, t, DIRSIZ);
8010209d:	83 c4 0c             	add    $0xc,%esp
801020a0:	6a 0e                	push   $0xe
801020a2:	68 bd 86 10 80       	push   $0x801086bd
801020a7:	53                   	push   %ebx
801020a8:	e8 f3 2d 00 00       	call   80104ea0 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801020ad:	83 c4 10             	add    $0x10,%esp
801020b0:	85 c0                	test   %eax,%eax
801020b2:	0f 84 f8 00 00 00    	je     801021b0 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
801020b8:	83 ec 04             	sub    $0x4,%esp
801020bb:	6a 0e                	push   $0xe
801020bd:	68 bc 86 10 80       	push   $0x801086bc
801020c2:	53                   	push   %ebx
801020c3:	e8 d8 2d 00 00       	call   80104ea0 <strncmp>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801020c8:	83 c4 10             	add    $0x10,%esp
801020cb:	85 c0                	test   %eax,%eax
801020cd:	0f 84 dd 00 00 00    	je     801021b0 <removeSwapFile+0x180>
     goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801020d3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801020d6:	83 ec 04             	sub    $0x4,%esp
801020d9:	50                   	push   %eax
801020da:	53                   	push   %ebx
801020db:	56                   	push   %esi
801020dc:	e8 4f fb ff ff       	call   80101c30 <dirlookup>
801020e1:	83 c4 10             	add    $0x10,%esp
801020e4:	85 c0                	test   %eax,%eax
801020e6:	89 c3                	mov    %eax,%ebx
801020e8:	0f 84 c2 00 00 00    	je     801021b0 <removeSwapFile+0x180>
    goto bad;
  ilock(ip);
801020ee:	83 ec 0c             	sub    $0xc,%esp
801020f1:	50                   	push   %eax
801020f2:	e8 09 f6 ff ff       	call   80101700 <ilock>

  if(ip->nlink < 1)
801020f7:	83 c4 10             	add    $0x10,%esp
801020fa:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801020ff:	0f 8e 11 01 00 00    	jle    80102216 <removeSwapFile+0x1e6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80102105:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010210a:	74 74                	je     80102180 <removeSwapFile+0x150>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010210c:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010210f:	83 ec 04             	sub    $0x4,%esp
80102112:	6a 10                	push   $0x10
80102114:	6a 00                	push   $0x0
80102116:	57                   	push   %edi
80102117:	e8 64 2c 00 00       	call   80104d80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010211c:	6a 10                	push   $0x10
8010211e:	ff 75 b8             	pushl  -0x48(%ebp)
80102121:	57                   	push   %edi
80102122:	56                   	push   %esi
80102123:	e8 b8 f9 ff ff       	call   80101ae0 <writei>
80102128:	83 c4 20             	add    $0x20,%esp
8010212b:	83 f8 10             	cmp    $0x10,%eax
8010212e:	0f 85 d5 00 00 00    	jne    80102209 <removeSwapFile+0x1d9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80102134:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102139:	0f 84 91 00 00 00    	je     801021d0 <removeSwapFile+0x1a0>
  iunlock(ip);
8010213f:	83 ec 0c             	sub    $0xc,%esp
80102142:	56                   	push   %esi
80102143:	e8 98 f6 ff ff       	call   801017e0 <iunlock>
  iput(ip);
80102148:	89 34 24             	mov    %esi,(%esp)
8010214b:	e8 e0 f6 ff ff       	call   80101830 <iput>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
80102150:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80102155:	89 1c 24             	mov    %ebx,(%esp)
80102158:	e8 f3 f4 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
8010215d:	89 1c 24             	mov    %ebx,(%esp)
80102160:	e8 7b f6 ff ff       	call   801017e0 <iunlock>
  iput(ip);
80102165:	89 1c 24             	mov    %ebx,(%esp)
80102168:	e8 c3 f6 ff ff       	call   80101830 <iput>
  iunlockput(ip);

  end_op();
8010216d:	e8 ae 10 00 00       	call   80103220 <end_op>

  return 0;
80102172:	83 c4 10             	add    $0x10,%esp
80102175:	31 c0                	xor    %eax,%eax
  bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102177:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010217a:	5b                   	pop    %ebx
8010217b:	5e                   	pop    %esi
8010217c:	5f                   	pop    %edi
8010217d:	5d                   	pop    %ebp
8010217e:	c3                   	ret    
8010217f:	90                   	nop
  if(ip->type == T_DIR && !isdirempty(ip)){
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	53                   	push   %ebx
80102184:	e8 d7 33 00 00       	call   80105560 <isdirempty>
80102189:	83 c4 10             	add    $0x10,%esp
8010218c:	85 c0                	test   %eax,%eax
8010218e:	0f 85 78 ff ff ff    	jne    8010210c <removeSwapFile+0xdc>
  iunlock(ip);
80102194:	83 ec 0c             	sub    $0xc,%esp
80102197:	53                   	push   %ebx
80102198:	e8 43 f6 ff ff       	call   801017e0 <iunlock>
  iput(ip);
8010219d:	89 1c 24             	mov    %ebx,(%esp)
801021a0:	e8 8b f6 ff ff       	call   80101830 <iput>
801021a5:	83 c4 10             	add    $0x10,%esp
801021a8:	90                   	nop
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801021b0:	83 ec 0c             	sub    $0xc,%esp
801021b3:	56                   	push   %esi
801021b4:	e8 27 f6 ff ff       	call   801017e0 <iunlock>
  iput(ip);
801021b9:	89 34 24             	mov    %esi,(%esp)
801021bc:	e8 6f f6 ff ff       	call   80101830 <iput>
    end_op();
801021c1:	e8 5a 10 00 00       	call   80103220 <end_op>
    return -1;
801021c6:	83 c4 10             	add    $0x10,%esp
801021c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021ce:	eb a7                	jmp    80102177 <removeSwapFile+0x147>
    dp->nlink--;
801021d0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801021d5:	83 ec 0c             	sub    $0xc,%esp
801021d8:	56                   	push   %esi
801021d9:	e8 72 f4 ff ff       	call   80101650 <iupdate>
801021de:	83 c4 10             	add    $0x10,%esp
801021e1:	e9 59 ff ff ff       	jmp    8010213f <removeSwapFile+0x10f>
801021e6:	8d 76 00             	lea    0x0(%esi),%esi
801021e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801021f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801021f5:	e9 7d ff ff ff       	jmp    80102177 <removeSwapFile+0x147>
    end_op();
801021fa:	e8 21 10 00 00       	call   80103220 <end_op>
    return -1;
801021ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102204:	e9 6e ff ff ff       	jmp    80102177 <removeSwapFile+0x147>
    panic("unlink: writei");
80102209:	83 ec 0c             	sub    $0xc,%esp
8010220c:	68 d1 86 10 80       	push   $0x801086d1
80102211:	e8 7a e1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80102216:	83 ec 0c             	sub    $0xc,%esp
80102219:	68 bf 86 10 80       	push   $0x801086bf
8010221e:	e8 6d e1 ff ff       	call   80100390 <panic>
80102223:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102230 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc* p)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	56                   	push   %esi
80102234:	53                   	push   %ebx

  char path[DIGITS];
  memmove(path,"/.swap", 6);
80102235:	8d 75 ea             	lea    -0x16(%ebp),%esi
{
80102238:	83 ec 14             	sub    $0x14,%esp
8010223b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
8010223e:	6a 06                	push   $0x6
80102240:	68 b5 86 10 80       	push   $0x801086b5
80102245:	56                   	push   %esi
80102246:	e8 e5 2b 00 00       	call   80104e30 <memmove>
  itoa(p->pid, path+ 6);
8010224b:	58                   	pop    %eax
8010224c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010224f:	5a                   	pop    %edx
80102250:	50                   	push   %eax
80102251:	ff 73 10             	pushl  0x10(%ebx)
80102254:	e8 47 fd ff ff       	call   80101fa0 <itoa>

    begin_op();
80102259:	e8 52 0f 00 00       	call   801031b0 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
8010225e:	6a 00                	push   $0x0
80102260:	6a 00                	push   $0x0
80102262:	6a 02                	push   $0x2
80102264:	56                   	push   %esi
80102265:	e8 06 35 00 00       	call   80105770 <create>
  iunlock(in);
8010226a:	83 c4 14             	add    $0x14,%esp
    struct inode * in = create(path, T_FILE, 0, 0);
8010226d:	89 c6                	mov    %eax,%esi
  iunlock(in);
8010226f:	50                   	push   %eax
80102270:	e8 6b f5 ff ff       	call   801017e0 <iunlock>

  p->swapFile = filealloc();
80102275:	e8 86 eb ff ff       	call   80100e00 <filealloc>
  if (p->swapFile == 0)
8010227a:	83 c4 10             	add    $0x10,%esp
8010227d:	85 c0                	test   %eax,%eax
  p->swapFile = filealloc();
8010227f:	89 43 7c             	mov    %eax,0x7c(%ebx)
  if (p->swapFile == 0)
80102282:	74 32                	je     801022b6 <createSwapFile+0x86>
    panic("no slot for files on /store");

  p->swapFile->ip = in;
80102284:	89 70 10             	mov    %esi,0x10(%eax)
  p->swapFile->type = FD_INODE;
80102287:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010228a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  p->swapFile->off = 0;
80102290:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102293:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  p->swapFile->readable = O_WRONLY;
8010229a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010229d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->swapFile->writable = O_RDWR;
801022a1:	8b 43 7c             	mov    0x7c(%ebx),%eax
801022a4:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
801022a8:	e8 73 0f 00 00       	call   80103220 <end_op>

    return 0;
}
801022ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022b0:	31 c0                	xor    %eax,%eax
801022b2:	5b                   	pop    %ebx
801022b3:	5e                   	pop    %esi
801022b4:	5d                   	pop    %ebp
801022b5:	c3                   	ret    
    panic("no slot for files on /store");
801022b6:	83 ec 0c             	sub    $0xc,%esp
801022b9:	68 e0 86 10 80       	push   $0x801086e0
801022be:	e8 cd e0 ff ff       	call   80100390 <panic>
801022c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022d0 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
801022d6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801022d9:	8b 50 7c             	mov    0x7c(%eax),%edx
801022dc:	89 4a 14             	mov    %ecx,0x14(%edx)

  return filewrite(p->swapFile, buffer, size);
801022df:	8b 55 14             	mov    0x14(%ebp),%edx
801022e2:	89 55 10             	mov    %edx,0x10(%ebp)
801022e5:	8b 40 7c             	mov    0x7c(%eax),%eax
801022e8:	89 45 08             	mov    %eax,0x8(%ebp)

}
801022eb:	5d                   	pop    %ebp
  return filewrite(p->swapFile, buffer, size);
801022ec:	e9 7f ed ff ff       	jmp    80101070 <filewrite>
801022f1:	eb 0d                	jmp    80102300 <readFromSwapFile>
801022f3:	90                   	nop
801022f4:	90                   	nop
801022f5:	90                   	nop
801022f6:	90                   	nop
801022f7:	90                   	nop
801022f8:	90                   	nop
801022f9:	90                   	nop
801022fa:	90                   	nop
801022fb:	90                   	nop
801022fc:	90                   	nop
801022fd:	90                   	nop
801022fe:	90                   	nop
801022ff:	90                   	nop

80102300 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
80102306:	8b 4d 10             	mov    0x10(%ebp),%ecx
80102309:	8b 50 7c             	mov    0x7c(%eax),%edx
8010230c:	89 4a 14             	mov    %ecx,0x14(%edx)

  return fileread(p->swapFile, buffer,  size);
8010230f:	8b 55 14             	mov    0x14(%ebp),%edx
80102312:	89 55 10             	mov    %edx,0x10(%ebp)
80102315:	8b 40 7c             	mov    0x7c(%eax),%eax
80102318:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010231b:	5d                   	pop    %ebp
  return fileread(p->swapFile, buffer,  size);
8010231c:	e9 bf ec ff ff       	jmp    80100fe0 <fileread>
80102321:	66 90                	xchg   %ax,%ax
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102339:	85 c0                	test   %eax,%eax
8010233b:	0f 84 b4 00 00 00    	je     801023f5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102341:	8b 58 08             	mov    0x8(%eax),%ebx
80102344:	89 c6                	mov    %eax,%esi
80102346:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010234c:	0f 87 96 00 00 00    	ja     801023e8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102352:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102357:	89 f6                	mov    %esi,%esi
80102359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102360:	89 ca                	mov    %ecx,%edx
80102362:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102363:	83 e0 c0             	and    $0xffffffc0,%eax
80102366:	3c 40                	cmp    $0x40,%al
80102368:	75 f6                	jne    80102360 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010236a:	31 ff                	xor    %edi,%edi
8010236c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102371:	89 f8                	mov    %edi,%eax
80102373:	ee                   	out    %al,(%dx)
80102374:	b8 01 00 00 00       	mov    $0x1,%eax
80102379:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010237e:	ee                   	out    %al,(%dx)
8010237f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102384:	89 d8                	mov    %ebx,%eax
80102386:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102387:	89 d8                	mov    %ebx,%eax
80102389:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010238e:	c1 f8 08             	sar    $0x8,%eax
80102391:	ee                   	out    %al,(%dx)
80102392:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102397:	89 f8                	mov    %edi,%eax
80102399:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010239a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010239e:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023a3:	c1 e0 04             	shl    $0x4,%eax
801023a6:	83 e0 10             	and    $0x10,%eax
801023a9:	83 c8 e0             	or     $0xffffffe0,%eax
801023ac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801023ad:	f6 06 04             	testb  $0x4,(%esi)
801023b0:	75 16                	jne    801023c8 <idestart+0x98>
801023b2:	b8 20 00 00 00       	mov    $0x20,%eax
801023b7:	89 ca                	mov    %ecx,%edx
801023b9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801023ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023bd:	5b                   	pop    %ebx
801023be:	5e                   	pop    %esi
801023bf:	5f                   	pop    %edi
801023c0:	5d                   	pop    %ebp
801023c1:	c3                   	ret    
801023c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023c8:	b8 30 00 00 00       	mov    $0x30,%eax
801023cd:	89 ca                	mov    %ecx,%edx
801023cf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801023d0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801023d5:	83 c6 5c             	add    $0x5c,%esi
801023d8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023dd:	fc                   	cld    
801023de:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801023e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e3:	5b                   	pop    %ebx
801023e4:	5e                   	pop    %esi
801023e5:	5f                   	pop    %edi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret    
    panic("incorrect blockno");
801023e8:	83 ec 0c             	sub    $0xc,%esp
801023eb:	68 58 87 10 80       	push   $0x80108758
801023f0:	e8 9b df ff ff       	call   80100390 <panic>
    panic("idestart");
801023f5:	83 ec 0c             	sub    $0xc,%esp
801023f8:	68 4f 87 10 80       	push   $0x8010874f
801023fd:	e8 8e df ff ff       	call   80100390 <panic>
80102402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <ideinit>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102416:	68 6a 87 10 80       	push   $0x8010876a
8010241b:	68 80 c5 10 80       	push   $0x8010c580
80102420:	e8 0b 27 00 00       	call   80104b30 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102425:	58                   	pop    %eax
80102426:	a1 20 cd 14 80       	mov    0x8014cd20,%eax
8010242b:	5a                   	pop    %edx
8010242c:	83 e8 01             	sub    $0x1,%eax
8010242f:	50                   	push   %eax
80102430:	6a 0e                	push   $0xe
80102432:	e8 a9 02 00 00       	call   801026e0 <ioapicenable>
80102437:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010243a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010243f:	90                   	nop
80102440:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102441:	83 e0 c0             	and    $0xffffffc0,%eax
80102444:	3c 40                	cmp    $0x40,%al
80102446:	75 f8                	jne    80102440 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102448:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010244d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102452:	ee                   	out    %al,(%dx)
80102453:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102458:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010245d:	eb 06                	jmp    80102465 <ideinit+0x55>
8010245f:	90                   	nop
  for(i=0; i<1000; i++){
80102460:	83 e9 01             	sub    $0x1,%ecx
80102463:	74 0f                	je     80102474 <ideinit+0x64>
80102465:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102466:	84 c0                	test   %al,%al
80102468:	74 f6                	je     80102460 <ideinit+0x50>
      havedisk1 = 1;
8010246a:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80102471:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102474:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102479:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010247e:	ee                   	out    %al,(%dx)
}
8010247f:	c9                   	leave  
80102480:	c3                   	ret    
80102481:	eb 0d                	jmp    80102490 <ideintr>
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

80102490 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	57                   	push   %edi
80102494:	56                   	push   %esi
80102495:	53                   	push   %ebx
80102496:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102499:	68 80 c5 10 80       	push   $0x8010c580
8010249e:	e8 cd 27 00 00       	call   80104c70 <acquire>

  if((b = idequeue) == 0){
801024a3:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
801024a9:	83 c4 10             	add    $0x10,%esp
801024ac:	85 db                	test   %ebx,%ebx
801024ae:	74 67                	je     80102517 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801024b0:	8b 43 58             	mov    0x58(%ebx),%eax
801024b3:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801024b8:	8b 3b                	mov    (%ebx),%edi
801024ba:	f7 c7 04 00 00 00    	test   $0x4,%edi
801024c0:	75 31                	jne    801024f3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024c2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801024c7:	89 f6                	mov    %esi,%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801024d0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801024d1:	89 c6                	mov    %eax,%esi
801024d3:	83 e6 c0             	and    $0xffffffc0,%esi
801024d6:	89 f1                	mov    %esi,%ecx
801024d8:	80 f9 40             	cmp    $0x40,%cl
801024db:	75 f3                	jne    801024d0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801024dd:	a8 21                	test   $0x21,%al
801024df:	75 12                	jne    801024f3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801024e1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801024e4:	b9 80 00 00 00       	mov    $0x80,%ecx
801024e9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024ee:	fc                   	cld    
801024ef:	f3 6d                	rep insl (%dx),%es:(%edi)
801024f1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801024f3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801024f6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801024f9:	89 f9                	mov    %edi,%ecx
801024fb:	83 c9 02             	or     $0x2,%ecx
801024fe:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102500:	53                   	push   %ebx
80102501:	e8 3a 22 00 00       	call   80104740 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102506:	a1 64 c5 10 80       	mov    0x8010c564,%eax
8010250b:	83 c4 10             	add    $0x10,%esp
8010250e:	85 c0                	test   %eax,%eax
80102510:	74 05                	je     80102517 <ideintr+0x87>
    idestart(idequeue);
80102512:	e8 19 fe ff ff       	call   80102330 <idestart>
    release(&idelock);
80102517:	83 ec 0c             	sub    $0xc,%esp
8010251a:	68 80 c5 10 80       	push   $0x8010c580
8010251f:	e8 0c 28 00 00       	call   80104d30 <release>

  release(&idelock);
}
80102524:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102527:	5b                   	pop    %ebx
80102528:	5e                   	pop    %esi
80102529:	5f                   	pop    %edi
8010252a:	5d                   	pop    %ebp
8010252b:	c3                   	ret    
8010252c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102530 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	53                   	push   %ebx
80102534:	83 ec 10             	sub    $0x10,%esp
80102537:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010253a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010253d:	50                   	push   %eax
8010253e:	e8 9d 25 00 00       	call   80104ae0 <holdingsleep>
80102543:	83 c4 10             	add    $0x10,%esp
80102546:	85 c0                	test   %eax,%eax
80102548:	0f 84 c6 00 00 00    	je     80102614 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010254e:	8b 03                	mov    (%ebx),%eax
80102550:	83 e0 06             	and    $0x6,%eax
80102553:	83 f8 02             	cmp    $0x2,%eax
80102556:	0f 84 ab 00 00 00    	je     80102607 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010255c:	8b 53 04             	mov    0x4(%ebx),%edx
8010255f:	85 d2                	test   %edx,%edx
80102561:	74 0d                	je     80102570 <iderw+0x40>
80102563:	a1 60 c5 10 80       	mov    0x8010c560,%eax
80102568:	85 c0                	test   %eax,%eax
8010256a:	0f 84 b1 00 00 00    	je     80102621 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102570:	83 ec 0c             	sub    $0xc,%esp
80102573:	68 80 c5 10 80       	push   $0x8010c580
80102578:	e8 f3 26 00 00       	call   80104c70 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010257d:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102583:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102586:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010258d:	85 d2                	test   %edx,%edx
8010258f:	75 09                	jne    8010259a <iderw+0x6a>
80102591:	eb 6d                	jmp    80102600 <iderw+0xd0>
80102593:	90                   	nop
80102594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102598:	89 c2                	mov    %eax,%edx
8010259a:	8b 42 58             	mov    0x58(%edx),%eax
8010259d:	85 c0                	test   %eax,%eax
8010259f:	75 f7                	jne    80102598 <iderw+0x68>
801025a1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801025a4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801025a6:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
801025ac:	74 42                	je     801025f0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025ae:	8b 03                	mov    (%ebx),%eax
801025b0:	83 e0 06             	and    $0x6,%eax
801025b3:	83 f8 02             	cmp    $0x2,%eax
801025b6:	74 23                	je     801025db <iderw+0xab>
801025b8:	90                   	nop
801025b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801025c0:	83 ec 08             	sub    $0x8,%esp
801025c3:	68 80 c5 10 80       	push   $0x8010c580
801025c8:	53                   	push   %ebx
801025c9:	e8 b2 1f 00 00       	call   80104580 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025ce:	8b 03                	mov    (%ebx),%eax
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	83 e0 06             	and    $0x6,%eax
801025d6:	83 f8 02             	cmp    $0x2,%eax
801025d9:	75 e5                	jne    801025c0 <iderw+0x90>
  }


  release(&idelock);
801025db:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801025e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025e5:	c9                   	leave  
  release(&idelock);
801025e6:	e9 45 27 00 00       	jmp    80104d30 <release>
801025eb:	90                   	nop
801025ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801025f0:	89 d8                	mov    %ebx,%eax
801025f2:	e8 39 fd ff ff       	call   80102330 <idestart>
801025f7:	eb b5                	jmp    801025ae <iderw+0x7e>
801025f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102600:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
80102605:	eb 9d                	jmp    801025a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102607:	83 ec 0c             	sub    $0xc,%esp
8010260a:	68 84 87 10 80       	push   $0x80108784
8010260f:	e8 7c dd ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102614:	83 ec 0c             	sub    $0xc,%esp
80102617:	68 6e 87 10 80       	push   $0x8010876e
8010261c:	e8 6f dd ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102621:	83 ec 0c             	sub    $0xc,%esp
80102624:	68 99 87 10 80       	push   $0x80108799
80102629:	e8 62 dd ff ff       	call   80100390 <panic>
8010262e:	66 90                	xchg   %ax,%ax

80102630 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102630:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102631:	c7 05 34 46 11 80 00 	movl   $0xfec00000,0x80114634
80102638:	00 c0 fe 
{
8010263b:	89 e5                	mov    %esp,%ebp
8010263d:	56                   	push   %esi
8010263e:	53                   	push   %ebx
  ioapic->reg = reg;
8010263f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102646:	00 00 00 
  return ioapic->data;
80102649:	a1 34 46 11 80       	mov    0x80114634,%eax
8010264e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102651:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102657:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010265d:	0f b6 15 80 c7 14 80 	movzbl 0x8014c780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102664:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102667:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010266a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010266d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102670:	39 c2                	cmp    %eax,%edx
80102672:	74 16                	je     8010268a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102674:	83 ec 0c             	sub    $0xc,%esp
80102677:	68 b8 87 10 80       	push   $0x801087b8
8010267c:	e8 df df ff ff       	call   80100660 <cprintf>
80102681:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102687:	83 c4 10             	add    $0x10,%esp
8010268a:	83 c3 21             	add    $0x21,%ebx
{
8010268d:	ba 10 00 00 00       	mov    $0x10,%edx
80102692:	b8 20 00 00 00       	mov    $0x20,%eax
80102697:	89 f6                	mov    %esi,%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801026a0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801026a2:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801026a8:	89 c6                	mov    %eax,%esi
801026aa:	81 ce 00 00 01 00    	or     $0x10000,%esi
801026b0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801026b3:	89 71 10             	mov    %esi,0x10(%ecx)
801026b6:	8d 72 01             	lea    0x1(%edx),%esi
801026b9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801026bc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801026be:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801026c0:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
801026c6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801026cd:	75 d1                	jne    801026a0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801026cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026d2:	5b                   	pop    %ebx
801026d3:	5e                   	pop    %esi
801026d4:	5d                   	pop    %ebp
801026d5:	c3                   	ret    
801026d6:	8d 76 00             	lea    0x0(%esi),%esi
801026d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801026e0:	55                   	push   %ebp
  ioapic->reg = reg;
801026e1:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
{
801026e7:	89 e5                	mov    %esp,%ebp
801026e9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801026ec:	8d 50 20             	lea    0x20(%eax),%edx
801026ef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801026f3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026f5:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801026fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102701:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102704:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102706:	a1 34 46 11 80       	mov    0x80114634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010270b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010270e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102711:	5d                   	pop    %ebp
80102712:	c3                   	ret    
80102713:	66 90                	xchg   %ax,%ax
80102715:	66 90                	xchg   %ax,%ax
80102717:	66 90                	xchg   %ax,%ax
80102719:	66 90                	xchg   %ax,%ax
8010271b:	66 90                	xchg   %ax,%ax
8010271d:	66 90                	xchg   %ax,%ax
8010271f:	90                   	nop

80102720 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	56                   	push   %esi
80102724:	53                   	push   %ebx
80102725:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102728:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
8010272e:	0f 85 b9 00 00 00    	jne    801027ed <kfree+0xcd>
80102734:	81 fe c8 89 15 80    	cmp    $0x801589c8,%esi
8010273a:	0f 82 ad 00 00 00    	jb     801027ed <kfree+0xcd>
80102740:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102746:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010274c:	0f 87 9b 00 00 00    	ja     801027ed <kfree+0xcd>
    panic("kfree");

  if(kmem.use_lock)
80102752:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102758:	85 d2                	test   %edx,%edx
8010275a:	75 7c                	jne    801027d8 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;

  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] > 0){
8010275c:	c1 eb 0c             	shr    $0xc,%ebx
8010275f:	83 c3 10             	add    $0x10,%ebx
80102762:	8b 04 9d 40 46 11 80 	mov    -0x7feeb9c0(,%ebx,4),%eax
80102769:	85 c0                	test   %eax,%eax
8010276b:	75 3b                	jne    801027a8 <kfree+0x88>
    --kmem.pg_refcount[V2P(v) >> PGSHIFT];
  }
  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] == 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
8010276d:	83 ec 04             	sub    $0x4,%esp
80102770:	68 00 10 00 00       	push   $0x1000
80102775:	6a 01                	push   $0x1
80102777:	56                   	push   %esi
80102778:	e8 03 26 00 00       	call   80104d80 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
8010277d:	a1 78 46 11 80       	mov    0x80114678,%eax
    kmem.free_pages++;
80102782:	83 05 7c 46 11 80 01 	addl   $0x1,0x8011467c
    kmem.freelist = r;
80102789:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
8010278c:	89 06                	mov    %eax,(%esi)
  }

  if(kmem.use_lock)
8010278e:	a1 74 46 11 80       	mov    0x80114674,%eax
    kmem.freelist = r;
80102793:	89 35 78 46 11 80    	mov    %esi,0x80114678
  if(kmem.use_lock)
80102799:	85 c0                	test   %eax,%eax
8010279b:	75 22                	jne    801027bf <kfree+0x9f>
    release(&kmem.lock);
}
8010279d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027a0:	5b                   	pop    %ebx
801027a1:	5e                   	pop    %esi
801027a2:	5d                   	pop    %ebp
801027a3:	c3                   	ret    
801027a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    --kmem.pg_refcount[V2P(v) >> PGSHIFT];
801027a8:	83 e8 01             	sub    $0x1,%eax
  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] == 0){
801027ab:	85 c0                	test   %eax,%eax
    --kmem.pg_refcount[V2P(v) >> PGSHIFT];
801027ad:	89 04 9d 40 46 11 80 	mov    %eax,-0x7feeb9c0(,%ebx,4)
  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] == 0){
801027b4:	74 b7                	je     8010276d <kfree+0x4d>
  if(kmem.use_lock)
801027b6:	a1 74 46 11 80       	mov    0x80114674,%eax
801027bb:	85 c0                	test   %eax,%eax
801027bd:	74 de                	je     8010279d <kfree+0x7d>
    release(&kmem.lock);
801027bf:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
801027c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027c9:	5b                   	pop    %ebx
801027ca:	5e                   	pop    %esi
801027cb:	5d                   	pop    %ebp
    release(&kmem.lock);
801027cc:	e9 5f 25 00 00       	jmp    80104d30 <release>
801027d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
801027d8:	83 ec 0c             	sub    $0xc,%esp
801027db:	68 40 46 11 80       	push   $0x80114640
801027e0:	e8 8b 24 00 00       	call   80104c70 <acquire>
801027e5:	83 c4 10             	add    $0x10,%esp
801027e8:	e9 6f ff ff ff       	jmp    8010275c <kfree+0x3c>
    panic("kfree");
801027ed:	83 ec 0c             	sub    $0xc,%esp
801027f0:	68 ea 87 10 80       	push   $0x801087ea
801027f5:	e8 96 db ff ff       	call   80100390 <panic>
801027fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102800 <freerange>:
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	56                   	push   %esi
80102804:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102805:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102808:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010280b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102811:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102817:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010281d:	39 de                	cmp    %ebx,%esi
8010281f:	72 37                	jb     80102858 <freerange+0x58>
80102821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102828:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
8010282e:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102831:	c1 e8 0c             	shr    $0xc,%eax
80102834:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
8010283b:	00 00 00 00 
  kfree(p);
8010283f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102845:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
8010284b:	50                   	push   %eax
8010284c:	e8 cf fe ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102851:	83 c4 10             	add    $0x10,%esp
80102854:	39 f3                	cmp    %esi,%ebx
80102856:	76 d0                	jbe    80102828 <freerange+0x28>
}
80102858:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010285b:	5b                   	pop    %ebx
8010285c:	5e                   	pop    %esi
8010285d:	5d                   	pop    %ebp
8010285e:	c3                   	ret    
8010285f:	90                   	nop

80102860 <kinit1>:
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
80102863:	56                   	push   %esi
80102864:	53                   	push   %ebx
80102865:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102868:	83 ec 08             	sub    $0x8,%esp
8010286b:	68 f0 87 10 80       	push   $0x801087f0
80102870:	68 40 46 11 80       	push   $0x80114640
80102875:	e8 b6 22 00 00       	call   80104b30 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010287a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010287d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102880:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102887:	00 00 00 
  kmem.free_pages = 0;
8010288a:	c7 05 7c 46 11 80 00 	movl   $0x0,0x8011467c
80102891:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102894:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010289a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028a0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028a6:	39 de                	cmp    %ebx,%esi
801028a8:	72 36                	jb     801028e0 <kinit1+0x80>
801028aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
801028b0:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
801028b6:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
801028b9:	c1 e8 0c             	shr    $0xc,%eax
801028bc:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
801028c3:	00 00 00 00 
  kfree(p);
801028c7:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028cd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
801028d3:	50                   	push   %eax
801028d4:	e8 47 fe ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028d9:	83 c4 10             	add    $0x10,%esp
801028dc:	39 de                	cmp    %ebx,%esi
801028de:	73 d0                	jae    801028b0 <kinit1+0x50>
}
801028e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028e3:	5b                   	pop    %ebx
801028e4:	5e                   	pop    %esi
801028e5:	5d                   	pop    %ebp
801028e6:	c3                   	ret    
801028e7:	89 f6                	mov    %esi,%esi
801028e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028f0 <kinit2>:
{
801028f0:	55                   	push   %ebp
801028f1:	89 e5                	mov    %esp,%ebp
801028f3:	56                   	push   %esi
801028f4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028f5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801028fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102901:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102907:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010290d:	39 de                	cmp    %ebx,%esi
8010290f:	72 37                	jb     80102948 <kinit2+0x58>
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102918:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
8010291e:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102921:	c1 e8 0c             	shr    $0xc,%eax
80102924:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
8010292b:	00 00 00 00 
  kfree(p);
8010292f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102935:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
8010293b:	50                   	push   %eax
8010293c:	e8 df fd ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102941:	83 c4 10             	add    $0x10,%esp
80102944:	39 de                	cmp    %ebx,%esi
80102946:	73 d0                	jae    80102918 <kinit2+0x28>
  kmem.use_lock = 1;
80102948:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
8010294f:	00 00 00 
}
80102952:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102955:	5b                   	pop    %ebx
80102956:	5e                   	pop    %esi
80102957:	5d                   	pop    %ebp
80102958:	c3                   	ret    
80102959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102960 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102966:	8b 15 74 46 11 80    	mov    0x80114674,%edx
8010296c:	85 d2                	test   %edx,%edx
8010296e:	75 50                	jne    801029c0 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102970:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102975:	85 c0                	test   %eax,%eax
80102977:	74 27                	je     801029a0 <kalloc+0x40>
    kmem.freelist = r->next;
80102979:	8b 08                	mov    (%eax),%ecx
    kmem.free_pages--;
8010297b:	83 2d 7c 46 11 80 01 	subl   $0x1,0x8011467c
    kmem.freelist = r->next;
80102982:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
    kmem.pg_refcount[V2P((char*)r) >> PGSHIFT] = 1;
80102988:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010298e:	c1 e9 0c             	shr    $0xc,%ecx
80102991:	c7 04 8d 80 46 11 80 	movl   $0x1,-0x7feeb980(,%ecx,4)
80102998:	01 00 00 00 
  }

  if(kmem.use_lock)
8010299c:	85 d2                	test   %edx,%edx
8010299e:	75 08                	jne    801029a8 <kalloc+0x48>
    release(&kmem.lock);
  return (char*)r;
}
801029a0:	c9                   	leave  
801029a1:	c3                   	ret    
801029a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029a8:	83 ec 0c             	sub    $0xc,%esp
801029ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
801029ae:	68 40 46 11 80       	push   $0x80114640
801029b3:	e8 78 23 00 00       	call   80104d30 <release>
  return (char*)r;
801029b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801029bb:	83 c4 10             	add    $0x10,%esp
}
801029be:	c9                   	leave  
801029bf:	c3                   	ret    
    acquire(&kmem.lock);
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	68 40 46 11 80       	push   $0x80114640
801029c8:	e8 a3 22 00 00       	call   80104c70 <acquire>
  r = kmem.freelist;
801029cd:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
801029d2:	83 c4 10             	add    $0x10,%esp
801029d5:	8b 15 74 46 11 80    	mov    0x80114674,%edx
801029db:	85 c0                	test   %eax,%eax
801029dd:	75 9a                	jne    80102979 <kalloc+0x19>
801029df:	eb bb                	jmp    8010299c <kalloc+0x3c>
801029e1:	eb 0d                	jmp    801029f0 <numFreePages>
801029e3:	90                   	nop
801029e4:	90                   	nop
801029e5:	90                   	nop
801029e6:	90                   	nop
801029e7:	90                   	nop
801029e8:	90                   	nop
801029e9:	90                   	nop
801029ea:	90                   	nop
801029eb:	90                   	nop
801029ec:	90                   	nop
801029ed:	90                   	nop
801029ee:	90                   	nop
801029ef:	90                   	nop

801029f0 <numFreePages>:

uint numFreePages(){
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	53                   	push   %ebx
801029f4:	83 ec 10             	sub    $0x10,%esp
  acquire(&kmem.lock);
801029f7:	68 40 46 11 80       	push   $0x80114640
801029fc:	e8 6f 22 00 00       	call   80104c70 <acquire>
  uint free_pages = kmem.free_pages;
80102a01:	8b 1d 7c 46 11 80    	mov    0x8011467c,%ebx
  release(&kmem.lock);
80102a07:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102a0e:	e8 1d 23 00 00       	call   80104d30 <release>
  return free_pages;
}
80102a13:	89 d8                	mov    %ebx,%eax
80102a15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a18:	c9                   	leave  
80102a19:	c3                   	ret    
80102a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a20 <resetRefCounter>:

void resetRefCounter(uint pa){
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
  kmem.pg_refcount[pa >> PGSHIFT] = 1;
80102a23:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102a26:	5d                   	pop    %ebp
  kmem.pg_refcount[pa >> PGSHIFT] = 1;
80102a27:	c1 e8 0c             	shr    $0xc,%eax
80102a2a:	c7 04 85 80 46 11 80 	movl   $0x1,-0x7feeb980(,%eax,4)
80102a31:	01 00 00 00 
}
80102a35:	c3                   	ret    
80102a36:	8d 76 00             	lea    0x0(%esi),%esi
80102a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a40 <decrementReferenceCount>:

void decrementReferenceCount(uint pa)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	53                   	push   %ebx
80102a44:	83 ec 04             	sub    $0x4,%esp
80102a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if( pa >= PHYSTOP)
80102a4a:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102a50:	77 2b                	ja     80102a7d <decrementReferenceCount+0x3d>
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
80102a52:	83 ec 0c             	sub    $0xc,%esp
  --kmem.pg_refcount[pa >> PGSHIFT];
80102a55:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102a58:	68 40 46 11 80       	push   $0x80114640
80102a5d:	e8 0e 22 00 00       	call   80104c70 <acquire>
  --kmem.pg_refcount[pa >> PGSHIFT];
80102a62:	83 2c 9d 80 46 11 80 	subl   $0x1,-0x7feeb980(,%ebx,4)
80102a69:	01 
  release(&kmem.lock);
80102a6a:	83 c4 10             	add    $0x10,%esp
80102a6d:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)

}
80102a74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a77:	c9                   	leave  
  release(&kmem.lock);
80102a78:	e9 b3 22 00 00       	jmp    80104d30 <release>
    panic("decrementReferenceCount");
80102a7d:	83 ec 0c             	sub    $0xc,%esp
80102a80:	68 f5 87 10 80       	push   $0x801087f5
80102a85:	e8 06 d9 ff ff       	call   80100390 <panic>
80102a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a90 <incrementReferenceCount>:

void incrementReferenceCount(uint pa)
{
80102a90:	55                   	push   %ebp
80102a91:	89 e5                	mov    %esp,%ebp
80102a93:	53                   	push   %ebx
80102a94:	83 ec 04             	sub    $0x4,%esp
80102a97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102a9a:	81 fb c8 89 15 00    	cmp    $0x1589c8,%ebx
80102aa0:	72 33                	jb     80102ad5 <incrementReferenceCount+0x45>
80102aa2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102aa8:	77 2b                	ja     80102ad5 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102aaa:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[pa >> PGSHIFT];
80102aad:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102ab0:	68 40 46 11 80       	push   $0x80114640
80102ab5:	e8 b6 21 00 00       	call   80104c70 <acquire>
  ++kmem.pg_refcount[pa >> PGSHIFT];
80102aba:	83 04 9d 80 46 11 80 	addl   $0x1,-0x7feeb980(,%ebx,4)
80102ac1:	01 
  release(&kmem.lock);
80102ac2:	83 c4 10             	add    $0x10,%esp
80102ac5:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acf:	c9                   	leave  
  release(&kmem.lock);
80102ad0:	e9 5b 22 00 00       	jmp    80104d30 <release>
    panic("incrementReferenceCount");
80102ad5:	83 ec 0c             	sub    $0xc,%esp
80102ad8:	68 0d 88 10 80       	push   $0x8010880d
80102add:	e8 ae d8 ff ff       	call   80100390 <panic>
80102ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102af0 <getReferenceCount>:

uint getReferenceCount(uint pa)
{
80102af0:	55                   	push   %ebp
80102af1:	89 e5                	mov    %esp,%ebp
80102af3:	53                   	push   %ebx
80102af4:	83 ec 04             	sub    $0x4,%esp
80102af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if( pa >= PHYSTOP)
80102afa:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102b00:	77 2a                	ja     80102b2c <getReferenceCount+0x3c>
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
80102b02:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pg_refcount[pa >> PGSHIFT];
80102b05:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102b08:	68 40 46 11 80       	push   $0x80114640
80102b0d:	e8 5e 21 00 00       	call   80104c70 <acquire>
  count = kmem.pg_refcount[pa >> PGSHIFT];
80102b12:	8b 1c 9d 80 46 11 80 	mov    -0x7feeb980(,%ebx,4),%ebx
  release(&kmem.lock);
80102b19:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102b20:	e8 0b 22 00 00       	call   80104d30 <release>

  return count;
}
80102b25:	89 d8                	mov    %ebx,%eax
80102b27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b2a:	c9                   	leave  
80102b2b:	c3                   	ret    
    panic("getReferenceCount");
80102b2c:	83 ec 0c             	sub    $0xc,%esp
80102b2f:	68 25 88 10 80       	push   $0x80108825
80102b34:	e8 57 d8 ff ff       	call   80100390 <panic>
80102b39:	66 90                	xchg   %ax,%ax
80102b3b:	66 90                	xchg   %ax,%ax
80102b3d:	66 90                	xchg   %ax,%ax
80102b3f:	90                   	nop

80102b40 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b40:	ba 64 00 00 00       	mov    $0x64,%edx
80102b45:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102b46:	a8 01                	test   $0x1,%al
80102b48:	0f 84 c2 00 00 00    	je     80102c10 <kbdgetc+0xd0>
80102b4e:	ba 60 00 00 00       	mov    $0x60,%edx
80102b53:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102b54:	0f b6 d0             	movzbl %al,%edx
80102b57:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102b5d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102b63:	0f 84 7f 00 00 00    	je     80102be8 <kbdgetc+0xa8>
{
80102b69:	55                   	push   %ebp
80102b6a:	89 e5                	mov    %esp,%ebp
80102b6c:	53                   	push   %ebx
80102b6d:	89 cb                	mov    %ecx,%ebx
80102b6f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102b72:	84 c0                	test   %al,%al
80102b74:	78 4a                	js     80102bc0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102b76:	85 db                	test   %ebx,%ebx
80102b78:	74 09                	je     80102b83 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102b7a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102b7d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102b80:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102b83:	0f b6 82 60 89 10 80 	movzbl -0x7fef76a0(%edx),%eax
80102b8a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102b8c:	0f b6 82 60 88 10 80 	movzbl -0x7fef77a0(%edx),%eax
80102b93:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102b95:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102b97:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102b9d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102ba0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102ba3:	8b 04 85 40 88 10 80 	mov    -0x7fef77c0(,%eax,4),%eax
80102baa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102bae:	74 31                	je     80102be1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102bb0:	8d 50 9f             	lea    -0x61(%eax),%edx
80102bb3:	83 fa 19             	cmp    $0x19,%edx
80102bb6:	77 40                	ja     80102bf8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102bb8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102bbb:	5b                   	pop    %ebx
80102bbc:	5d                   	pop    %ebp
80102bbd:	c3                   	ret    
80102bbe:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102bc0:	83 e0 7f             	and    $0x7f,%eax
80102bc3:	85 db                	test   %ebx,%ebx
80102bc5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102bc8:	0f b6 82 60 89 10 80 	movzbl -0x7fef76a0(%edx),%eax
80102bcf:	83 c8 40             	or     $0x40,%eax
80102bd2:	0f b6 c0             	movzbl %al,%eax
80102bd5:	f7 d0                	not    %eax
80102bd7:	21 c1                	and    %eax,%ecx
    return 0;
80102bd9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102bdb:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102be1:	5b                   	pop    %ebx
80102be2:	5d                   	pop    %ebp
80102be3:	c3                   	ret    
80102be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102be8:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102beb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102bed:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102bf3:	c3                   	ret    
80102bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102bf8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102bfb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102bfe:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102bff:	83 f9 1a             	cmp    $0x1a,%ecx
80102c02:	0f 42 c2             	cmovb  %edx,%eax
}
80102c05:	5d                   	pop    %ebp
80102c06:	c3                   	ret    
80102c07:	89 f6                	mov    %esi,%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102c10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102c15:	c3                   	ret    
80102c16:	8d 76 00             	lea    0x0(%esi),%esi
80102c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c20 <kbdintr>:

void
kbdintr(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102c26:	68 40 2b 10 80       	push   $0x80102b40
80102c2b:	e8 e0 db ff ff       	call   80100810 <consoleintr>
}
80102c30:	83 c4 10             	add    $0x10,%esp
80102c33:	c9                   	leave  
80102c34:	c3                   	ret    
80102c35:	66 90                	xchg   %ax,%ax
80102c37:	66 90                	xchg   %ax,%ax
80102c39:	66 90                	xchg   %ax,%ax
80102c3b:	66 90                	xchg   %ax,%ax
80102c3d:	66 90                	xchg   %ax,%ax
80102c3f:	90                   	nop

80102c40 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102c40:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102c45:	55                   	push   %ebp
80102c46:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102c48:	85 c0                	test   %eax,%eax
80102c4a:	0f 84 c8 00 00 00    	je     80102d18 <lapicinit+0xd8>
  lapic[index] = value;
80102c50:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102c57:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c5a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c5d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102c64:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c67:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c6a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102c71:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102c74:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c77:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102c7e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102c81:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c84:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102c8b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c8e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c91:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102c98:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c9b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102c9e:	8b 50 30             	mov    0x30(%eax),%edx
80102ca1:	c1 ea 10             	shr    $0x10,%edx
80102ca4:	80 fa 03             	cmp    $0x3,%dl
80102ca7:	77 77                	ja     80102d20 <lapicinit+0xe0>
  lapic[index] = value;
80102ca9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102cb0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cb3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cb6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102cbd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cc0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cc3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102cca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ccd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cd0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102cd7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cda:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cdd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ce4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ce7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102cf1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102cf4:	8b 50 20             	mov    0x20(%eax),%edx
80102cf7:	89 f6                	mov    %esi,%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102d00:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d06:	80 e6 10             	and    $0x10,%dh
80102d09:	75 f5                	jne    80102d00 <lapicinit+0xc0>
  lapic[index] = value;
80102d0b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d12:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d15:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102d18:	5d                   	pop    %ebp
80102d19:	c3                   	ret    
80102d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102d20:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102d27:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2a:	8b 50 20             	mov    0x20(%eax),%edx
80102d2d:	e9 77 ff ff ff       	jmp    80102ca9 <lapicinit+0x69>
80102d32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d40 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102d40:	8b 15 80 c6 14 80    	mov    0x8014c680,%edx
{
80102d46:	55                   	push   %ebp
80102d47:	31 c0                	xor    %eax,%eax
80102d49:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102d4b:	85 d2                	test   %edx,%edx
80102d4d:	74 06                	je     80102d55 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102d4f:	8b 42 20             	mov    0x20(%edx),%eax
80102d52:	c1 e8 18             	shr    $0x18,%eax
}
80102d55:	5d                   	pop    %ebp
80102d56:	c3                   	ret    
80102d57:	89 f6                	mov    %esi,%esi
80102d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d60 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102d60:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102d65:	55                   	push   %ebp
80102d66:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102d68:	85 c0                	test   %eax,%eax
80102d6a:	74 0d                	je     80102d79 <lapiceoi+0x19>
  lapic[index] = value;
80102d6c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d73:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d76:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102d79:	5d                   	pop    %ebp
80102d7a:	c3                   	ret    
80102d7b:	90                   	nop
80102d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102d80 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
}
80102d83:	5d                   	pop    %ebp
80102d84:	c3                   	ret    
80102d85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d90 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102d90:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d91:	b8 0f 00 00 00       	mov    $0xf,%eax
80102d96:	ba 70 00 00 00       	mov    $0x70,%edx
80102d9b:	89 e5                	mov    %esp,%ebp
80102d9d:	53                   	push   %ebx
80102d9e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102da1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102da4:	ee                   	out    %al,(%dx)
80102da5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102daa:	ba 71 00 00 00       	mov    $0x71,%edx
80102daf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102db0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102db2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102db5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102dbb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102dbd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102dc0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102dc3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102dc5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102dc8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102dce:	a1 80 c6 14 80       	mov    0x8014c680,%eax
80102dd3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102dd9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ddc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102de3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102de6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102de9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102df0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102df3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102df6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102dfc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102dff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e05:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e08:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e0e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e11:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e17:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102e1a:	5b                   	pop    %ebx
80102e1b:	5d                   	pop    %ebp
80102e1c:	c3                   	ret    
80102e1d:	8d 76 00             	lea    0x0(%esi),%esi

80102e20 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102e20:	55                   	push   %ebp
80102e21:	b8 0b 00 00 00       	mov    $0xb,%eax
80102e26:	ba 70 00 00 00       	mov    $0x70,%edx
80102e2b:	89 e5                	mov    %esp,%ebp
80102e2d:	57                   	push   %edi
80102e2e:	56                   	push   %esi
80102e2f:	53                   	push   %ebx
80102e30:	83 ec 4c             	sub    $0x4c,%esp
80102e33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e34:	ba 71 00 00 00       	mov    $0x71,%edx
80102e39:	ec                   	in     (%dx),%al
80102e3a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e3d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102e42:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102e45:	8d 76 00             	lea    0x0(%esi),%esi
80102e48:	31 c0                	xor    %eax,%eax
80102e4a:	89 da                	mov    %ebx,%edx
80102e4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e4d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102e52:	89 ca                	mov    %ecx,%edx
80102e54:	ec                   	in     (%dx),%al
80102e55:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e58:	89 da                	mov    %ebx,%edx
80102e5a:	b8 02 00 00 00       	mov    $0x2,%eax
80102e5f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e60:	89 ca                	mov    %ecx,%edx
80102e62:	ec                   	in     (%dx),%al
80102e63:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e66:	89 da                	mov    %ebx,%edx
80102e68:	b8 04 00 00 00       	mov    $0x4,%eax
80102e6d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e6e:	89 ca                	mov    %ecx,%edx
80102e70:	ec                   	in     (%dx),%al
80102e71:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e74:	89 da                	mov    %ebx,%edx
80102e76:	b8 07 00 00 00       	mov    $0x7,%eax
80102e7b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e7c:	89 ca                	mov    %ecx,%edx
80102e7e:	ec                   	in     (%dx),%al
80102e7f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e82:	89 da                	mov    %ebx,%edx
80102e84:	b8 08 00 00 00       	mov    $0x8,%eax
80102e89:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e8a:	89 ca                	mov    %ecx,%edx
80102e8c:	ec                   	in     (%dx),%al
80102e8d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e8f:	89 da                	mov    %ebx,%edx
80102e91:	b8 09 00 00 00       	mov    $0x9,%eax
80102e96:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e97:	89 ca                	mov    %ecx,%edx
80102e99:	ec                   	in     (%dx),%al
80102e9a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e9c:	89 da                	mov    %ebx,%edx
80102e9e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102ea3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ea4:	89 ca                	mov    %ecx,%edx
80102ea6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102ea7:	84 c0                	test   %al,%al
80102ea9:	78 9d                	js     80102e48 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102eab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102eaf:	89 fa                	mov    %edi,%edx
80102eb1:	0f b6 fa             	movzbl %dl,%edi
80102eb4:	89 f2                	mov    %esi,%edx
80102eb6:	0f b6 f2             	movzbl %dl,%esi
80102eb9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ebc:	89 da                	mov    %ebx,%edx
80102ebe:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102ec1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ec4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102ec8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ecb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102ecf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ed2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ed6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ed9:	31 c0                	xor    %eax,%eax
80102edb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102edc:	89 ca                	mov    %ecx,%edx
80102ede:	ec                   	in     (%dx),%al
80102edf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ee2:	89 da                	mov    %ebx,%edx
80102ee4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ee7:	b8 02 00 00 00       	mov    $0x2,%eax
80102eec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eed:	89 ca                	mov    %ecx,%edx
80102eef:	ec                   	in     (%dx),%al
80102ef0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef3:	89 da                	mov    %ebx,%edx
80102ef5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102ef8:	b8 04 00 00 00       	mov    $0x4,%eax
80102efd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102efe:	89 ca                	mov    %ecx,%edx
80102f00:	ec                   	in     (%dx),%al
80102f01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f04:	89 da                	mov    %ebx,%edx
80102f06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f09:	b8 07 00 00 00       	mov    $0x7,%eax
80102f0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f0f:	89 ca                	mov    %ecx,%edx
80102f11:	ec                   	in     (%dx),%al
80102f12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f15:	89 da                	mov    %ebx,%edx
80102f17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f1a:	b8 08 00 00 00       	mov    $0x8,%eax
80102f1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f20:	89 ca                	mov    %ecx,%edx
80102f22:	ec                   	in     (%dx),%al
80102f23:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f26:	89 da                	mov    %ebx,%edx
80102f28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102f2b:	b8 09 00 00 00       	mov    $0x9,%eax
80102f30:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f31:	89 ca                	mov    %ecx,%edx
80102f33:	ec                   	in     (%dx),%al
80102f34:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102f37:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102f3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102f3d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102f40:	6a 18                	push   $0x18
80102f42:	50                   	push   %eax
80102f43:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102f46:	50                   	push   %eax
80102f47:	e8 84 1e 00 00       	call   80104dd0 <memcmp>
80102f4c:	83 c4 10             	add    $0x10,%esp
80102f4f:	85 c0                	test   %eax,%eax
80102f51:	0f 85 f1 fe ff ff    	jne    80102e48 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102f57:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102f5b:	75 78                	jne    80102fd5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102f5d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102f60:	89 c2                	mov    %eax,%edx
80102f62:	83 e0 0f             	and    $0xf,%eax
80102f65:	c1 ea 04             	shr    $0x4,%edx
80102f68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102f71:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102f74:	89 c2                	mov    %eax,%edx
80102f76:	83 e0 0f             	and    $0xf,%eax
80102f79:	c1 ea 04             	shr    $0x4,%edx
80102f7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f82:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102f85:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f88:	89 c2                	mov    %eax,%edx
80102f8a:	83 e0 0f             	and    $0xf,%eax
80102f8d:	c1 ea 04             	shr    $0x4,%edx
80102f90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f96:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102f99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f9c:	89 c2                	mov    %eax,%edx
80102f9e:	83 e0 0f             	and    $0xf,%eax
80102fa1:	c1 ea 04             	shr    $0x4,%edx
80102fa4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fa7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102faa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102fad:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102fb0:	89 c2                	mov    %eax,%edx
80102fb2:	83 e0 0f             	and    $0xf,%eax
80102fb5:	c1 ea 04             	shr    $0x4,%edx
80102fb8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fbb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fbe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102fc1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102fc4:	89 c2                	mov    %eax,%edx
80102fc6:	83 e0 0f             	and    $0xf,%eax
80102fc9:	c1 ea 04             	shr    $0x4,%edx
80102fcc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fcf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fd2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102fd5:	8b 75 08             	mov    0x8(%ebp),%esi
80102fd8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fdb:	89 06                	mov    %eax,(%esi)
80102fdd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102fe0:	89 46 04             	mov    %eax,0x4(%esi)
80102fe3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102fe6:	89 46 08             	mov    %eax,0x8(%esi)
80102fe9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102fec:	89 46 0c             	mov    %eax,0xc(%esi)
80102fef:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ff2:	89 46 10             	mov    %eax,0x10(%esi)
80102ff5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ff8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102ffb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103002:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103005:	5b                   	pop    %ebx
80103006:	5e                   	pop    %esi
80103007:	5f                   	pop    %edi
80103008:	5d                   	pop    %ebp
80103009:	c3                   	ret    
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103010:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103016:	85 c9                	test   %ecx,%ecx
80103018:	0f 8e 8a 00 00 00    	jle    801030a8 <install_trans+0x98>
{
8010301e:	55                   	push   %ebp
8010301f:	89 e5                	mov    %esp,%ebp
80103021:	57                   	push   %edi
80103022:	56                   	push   %esi
80103023:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80103024:	31 db                	xor    %ebx,%ebx
{
80103026:	83 ec 0c             	sub    $0xc,%esp
80103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103030:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103035:	83 ec 08             	sub    $0x8,%esp
80103038:	01 d8                	add    %ebx,%eax
8010303a:	83 c0 01             	add    $0x1,%eax
8010303d:	50                   	push   %eax
8010303e:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103044:	e8 87 d0 ff ff       	call   801000d0 <bread>
80103049:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010304b:	58                   	pop    %eax
8010304c:	5a                   	pop    %edx
8010304d:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103054:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010305a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010305d:	e8 6e d0 ff ff       	call   801000d0 <bread>
80103062:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103064:	8d 47 5c             	lea    0x5c(%edi),%eax
80103067:	83 c4 0c             	add    $0xc,%esp
8010306a:	68 00 02 00 00       	push   $0x200
8010306f:	50                   	push   %eax
80103070:	8d 46 5c             	lea    0x5c(%esi),%eax
80103073:	50                   	push   %eax
80103074:	e8 b7 1d 00 00       	call   80104e30 <memmove>
    bwrite(dbuf);  // write dst to disk
80103079:	89 34 24             	mov    %esi,(%esp)
8010307c:	e8 1f d1 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103081:	89 3c 24             	mov    %edi,(%esp)
80103084:	e8 57 d1 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103089:	89 34 24             	mov    %esi,(%esp)
8010308c:	e8 4f d1 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103091:	83 c4 10             	add    $0x10,%esp
80103094:	39 1d e8 c6 14 80    	cmp    %ebx,0x8014c6e8
8010309a:	7f 94                	jg     80103030 <install_trans+0x20>
  }
}
8010309c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010309f:	5b                   	pop    %ebx
801030a0:	5e                   	pop    %esi
801030a1:	5f                   	pop    %edi
801030a2:	5d                   	pop    %ebp
801030a3:	c3                   	ret    
801030a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030a8:	f3 c3                	repz ret 
801030aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801030b0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801030b0:	55                   	push   %ebp
801030b1:	89 e5                	mov    %esp,%ebp
801030b3:	56                   	push   %esi
801030b4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
801030b5:	83 ec 08             	sub    $0x8,%esp
801030b8:	ff 35 d4 c6 14 80    	pushl  0x8014c6d4
801030be:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
801030c4:	e8 07 d0 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801030c9:	8b 1d e8 c6 14 80    	mov    0x8014c6e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
801030cf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801030d2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
801030d4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
801030d6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
801030d9:	7e 16                	jle    801030f1 <write_head+0x41>
801030db:	c1 e3 02             	shl    $0x2,%ebx
801030de:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
801030e0:	8b 8a ec c6 14 80    	mov    -0x7feb3914(%edx),%ecx
801030e6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
801030ea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
801030ed:	39 da                	cmp    %ebx,%edx
801030ef:	75 ef                	jne    801030e0 <write_head+0x30>
  }
  bwrite(buf);
801030f1:	83 ec 0c             	sub    $0xc,%esp
801030f4:	56                   	push   %esi
801030f5:	e8 a6 d0 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801030fa:	89 34 24             	mov    %esi,(%esp)
801030fd:	e8 de d0 ff ff       	call   801001e0 <brelse>
}
80103102:	83 c4 10             	add    $0x10,%esp
80103105:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103108:	5b                   	pop    %ebx
80103109:	5e                   	pop    %esi
8010310a:	5d                   	pop    %ebp
8010310b:	c3                   	ret    
8010310c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103110 <initlog>:
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	53                   	push   %ebx
80103114:	83 ec 2c             	sub    $0x2c,%esp
80103117:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010311a:	68 60 8a 10 80       	push   $0x80108a60
8010311f:	68 a0 c6 14 80       	push   $0x8014c6a0
80103124:	e8 07 1a 00 00       	call   80104b30 <initlock>
  readsb(dev, &sb);
80103129:	58                   	pop    %eax
8010312a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010312d:	5a                   	pop    %edx
8010312e:	50                   	push   %eax
8010312f:	53                   	push   %ebx
80103130:	e8 8b e3 ff ff       	call   801014c0 <readsb>
  log.size = sb.nlog;
80103135:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103138:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010313b:	59                   	pop    %ecx
  log.dev = dev;
8010313c:	89 1d e4 c6 14 80    	mov    %ebx,0x8014c6e4
  log.size = sb.nlog;
80103142:	89 15 d8 c6 14 80    	mov    %edx,0x8014c6d8
  log.start = sb.logstart;
80103148:	a3 d4 c6 14 80       	mov    %eax,0x8014c6d4
  struct buf *buf = bread(log.dev, log.start);
8010314d:	5a                   	pop    %edx
8010314e:	50                   	push   %eax
8010314f:	53                   	push   %ebx
80103150:	e8 7b cf ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103155:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80103158:	83 c4 10             	add    $0x10,%esp
8010315b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
8010315d:	89 1d e8 c6 14 80    	mov    %ebx,0x8014c6e8
  for (i = 0; i < log.lh.n; i++) {
80103163:	7e 1c                	jle    80103181 <initlog+0x71>
80103165:	c1 e3 02             	shl    $0x2,%ebx
80103168:	31 d2                	xor    %edx,%edx
8010316a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103170:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103174:	83 c2 04             	add    $0x4,%edx
80103177:	89 8a e8 c6 14 80    	mov    %ecx,-0x7feb3918(%edx)
  for (i = 0; i < log.lh.n; i++) {
8010317d:	39 d3                	cmp    %edx,%ebx
8010317f:	75 ef                	jne    80103170 <initlog+0x60>
  brelse(buf);
80103181:	83 ec 0c             	sub    $0xc,%esp
80103184:	50                   	push   %eax
80103185:	e8 56 d0 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010318a:	e8 81 fe ff ff       	call   80103010 <install_trans>
  log.lh.n = 0;
8010318f:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
80103196:	00 00 00 
  write_head(); // clear the log
80103199:	e8 12 ff ff ff       	call   801030b0 <write_head>
}
8010319e:	83 c4 10             	add    $0x10,%esp
801031a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031a4:	c9                   	leave  
801031a5:	c3                   	ret    
801031a6:	8d 76 00             	lea    0x0(%esi),%esi
801031a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031b0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801031b6:	68 a0 c6 14 80       	push   $0x8014c6a0
801031bb:	e8 b0 1a 00 00       	call   80104c70 <acquire>
801031c0:	83 c4 10             	add    $0x10,%esp
801031c3:	eb 18                	jmp    801031dd <begin_op+0x2d>
801031c5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801031c8:	83 ec 08             	sub    $0x8,%esp
801031cb:	68 a0 c6 14 80       	push   $0x8014c6a0
801031d0:	68 a0 c6 14 80       	push   $0x8014c6a0
801031d5:	e8 a6 13 00 00       	call   80104580 <sleep>
801031da:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801031dd:	a1 e0 c6 14 80       	mov    0x8014c6e0,%eax
801031e2:	85 c0                	test   %eax,%eax
801031e4:	75 e2                	jne    801031c8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801031e6:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
801031eb:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
801031f1:	83 c0 01             	add    $0x1,%eax
801031f4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801031f7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801031fa:	83 fa 1e             	cmp    $0x1e,%edx
801031fd:	7f c9                	jg     801031c8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801031ff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103202:	a3 dc c6 14 80       	mov    %eax,0x8014c6dc
      release(&log.lock);
80103207:	68 a0 c6 14 80       	push   $0x8014c6a0
8010320c:	e8 1f 1b 00 00       	call   80104d30 <release>
      break;
    }
  }
}
80103211:	83 c4 10             	add    $0x10,%esp
80103214:	c9                   	leave  
80103215:	c3                   	ret    
80103216:	8d 76 00             	lea    0x0(%esi),%esi
80103219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103220 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103220:	55                   	push   %ebp
80103221:	89 e5                	mov    %esp,%ebp
80103223:	57                   	push   %edi
80103224:	56                   	push   %esi
80103225:	53                   	push   %ebx
80103226:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103229:	68 a0 c6 14 80       	push   $0x8014c6a0
8010322e:	e8 3d 1a 00 00       	call   80104c70 <acquire>
  log.outstanding -= 1;
80103233:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
  if(log.committing)
80103238:	8b 35 e0 c6 14 80    	mov    0x8014c6e0,%esi
8010323e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103241:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103244:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103246:	89 1d dc c6 14 80    	mov    %ebx,0x8014c6dc
  if(log.committing)
8010324c:	0f 85 1a 01 00 00    	jne    8010336c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103252:	85 db                	test   %ebx,%ebx
80103254:	0f 85 ee 00 00 00    	jne    80103348 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010325a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010325d:	c7 05 e0 c6 14 80 01 	movl   $0x1,0x8014c6e0
80103264:	00 00 00 
  release(&log.lock);
80103267:	68 a0 c6 14 80       	push   $0x8014c6a0
8010326c:	e8 bf 1a 00 00       	call   80104d30 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103271:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103277:	83 c4 10             	add    $0x10,%esp
8010327a:	85 c9                	test   %ecx,%ecx
8010327c:	0f 8e 85 00 00 00    	jle    80103307 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103282:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103287:	83 ec 08             	sub    $0x8,%esp
8010328a:	01 d8                	add    %ebx,%eax
8010328c:	83 c0 01             	add    $0x1,%eax
8010328f:	50                   	push   %eax
80103290:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103296:	e8 35 ce ff ff       	call   801000d0 <bread>
8010329b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010329d:	58                   	pop    %eax
8010329e:	5a                   	pop    %edx
8010329f:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
801032a6:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
801032ac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801032af:	e8 1c ce ff ff       	call   801000d0 <bread>
801032b4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801032b6:	8d 40 5c             	lea    0x5c(%eax),%eax
801032b9:	83 c4 0c             	add    $0xc,%esp
801032bc:	68 00 02 00 00       	push   $0x200
801032c1:	50                   	push   %eax
801032c2:	8d 46 5c             	lea    0x5c(%esi),%eax
801032c5:	50                   	push   %eax
801032c6:	e8 65 1b 00 00       	call   80104e30 <memmove>
    bwrite(to);  // write the log
801032cb:	89 34 24             	mov    %esi,(%esp)
801032ce:	e8 cd ce ff ff       	call   801001a0 <bwrite>
    brelse(from);
801032d3:	89 3c 24             	mov    %edi,(%esp)
801032d6:	e8 05 cf ff ff       	call   801001e0 <brelse>
    brelse(to);
801032db:	89 34 24             	mov    %esi,(%esp)
801032de:	e8 fd ce ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801032e3:	83 c4 10             	add    $0x10,%esp
801032e6:	3b 1d e8 c6 14 80    	cmp    0x8014c6e8,%ebx
801032ec:	7c 94                	jl     80103282 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801032ee:	e8 bd fd ff ff       	call   801030b0 <write_head>
    install_trans(); // Now install writes to home locations
801032f3:	e8 18 fd ff ff       	call   80103010 <install_trans>
    log.lh.n = 0;
801032f8:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
801032ff:	00 00 00 
    write_head();    // Erase the transaction from the log
80103302:	e8 a9 fd ff ff       	call   801030b0 <write_head>
    acquire(&log.lock);
80103307:	83 ec 0c             	sub    $0xc,%esp
8010330a:	68 a0 c6 14 80       	push   $0x8014c6a0
8010330f:	e8 5c 19 00 00       	call   80104c70 <acquire>
    wakeup(&log);
80103314:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
    log.committing = 0;
8010331b:	c7 05 e0 c6 14 80 00 	movl   $0x0,0x8014c6e0
80103322:	00 00 00 
    wakeup(&log);
80103325:	e8 16 14 00 00       	call   80104740 <wakeup>
    release(&log.lock);
8010332a:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
80103331:	e8 fa 19 00 00       	call   80104d30 <release>
80103336:	83 c4 10             	add    $0x10,%esp
}
80103339:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010333c:	5b                   	pop    %ebx
8010333d:	5e                   	pop    %esi
8010333e:	5f                   	pop    %edi
8010333f:	5d                   	pop    %ebp
80103340:	c3                   	ret    
80103341:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103348:	83 ec 0c             	sub    $0xc,%esp
8010334b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103350:	e8 eb 13 00 00       	call   80104740 <wakeup>
  release(&log.lock);
80103355:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
8010335c:	e8 cf 19 00 00       	call   80104d30 <release>
80103361:	83 c4 10             	add    $0x10,%esp
}
80103364:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103367:	5b                   	pop    %ebx
80103368:	5e                   	pop    %esi
80103369:	5f                   	pop    %edi
8010336a:	5d                   	pop    %ebp
8010336b:	c3                   	ret    
    panic("log.committing");
8010336c:	83 ec 0c             	sub    $0xc,%esp
8010336f:	68 64 8a 10 80       	push   $0x80108a64
80103374:	e8 17 d0 ff ff       	call   80100390 <panic>
80103379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103380 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	53                   	push   %ebx
80103384:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103387:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
{
8010338d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103390:	83 fa 1d             	cmp    $0x1d,%edx
80103393:	0f 8f 9d 00 00 00    	jg     80103436 <log_write+0xb6>
80103399:	a1 d8 c6 14 80       	mov    0x8014c6d8,%eax
8010339e:	83 e8 01             	sub    $0x1,%eax
801033a1:	39 c2                	cmp    %eax,%edx
801033a3:	0f 8d 8d 00 00 00    	jge    80103436 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
801033a9:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
801033ae:	85 c0                	test   %eax,%eax
801033b0:	0f 8e 8d 00 00 00    	jle    80103443 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	68 a0 c6 14 80       	push   $0x8014c6a0
801033be:	e8 ad 18 00 00       	call   80104c70 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801033c3:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	83 f9 00             	cmp    $0x0,%ecx
801033cf:	7e 57                	jle    80103428 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801033d1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801033d4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801033d6:	3b 15 ec c6 14 80    	cmp    0x8014c6ec,%edx
801033dc:	75 0b                	jne    801033e9 <log_write+0x69>
801033de:	eb 38                	jmp    80103418 <log_write+0x98>
801033e0:	39 14 85 ec c6 14 80 	cmp    %edx,-0x7feb3914(,%eax,4)
801033e7:	74 2f                	je     80103418 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801033e9:	83 c0 01             	add    $0x1,%eax
801033ec:	39 c1                	cmp    %eax,%ecx
801033ee:	75 f0                	jne    801033e0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801033f0:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801033f7:	83 c0 01             	add    $0x1,%eax
801033fa:	a3 e8 c6 14 80       	mov    %eax,0x8014c6e8
  b->flags |= B_DIRTY; // prevent eviction
801033ff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103402:	c7 45 08 a0 c6 14 80 	movl   $0x8014c6a0,0x8(%ebp)
}
80103409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010340c:	c9                   	leave  
  release(&log.lock);
8010340d:	e9 1e 19 00 00       	jmp    80104d30 <release>
80103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103418:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
8010341f:	eb de                	jmp    801033ff <log_write+0x7f>
80103421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103428:	8b 43 08             	mov    0x8(%ebx),%eax
8010342b:	a3 ec c6 14 80       	mov    %eax,0x8014c6ec
  if (i == log.lh.n)
80103430:	75 cd                	jne    801033ff <log_write+0x7f>
80103432:	31 c0                	xor    %eax,%eax
80103434:	eb c1                	jmp    801033f7 <log_write+0x77>
    panic("too big a transaction");
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	68 73 8a 10 80       	push   $0x80108a73
8010343e:	e8 4d cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103443:	83 ec 0c             	sub    $0xc,%esp
80103446:	68 89 8a 10 80       	push   $0x80108a89
8010344b:	e8 40 cf ff ff       	call   80100390 <panic>

80103450 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	53                   	push   %ebx
80103454:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103457:	e8 14 0a 00 00       	call   80103e70 <cpuid>
8010345c:	89 c3                	mov    %eax,%ebx
8010345e:	e8 0d 0a 00 00       	call   80103e70 <cpuid>
80103463:	83 ec 04             	sub    $0x4,%esp
80103466:	53                   	push   %ebx
80103467:	50                   	push   %eax
80103468:	68 a4 8a 10 80       	push   $0x80108aa4
8010346d:	e8 ee d1 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103472:	e8 d9 2b 00 00       	call   80106050 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103477:	e8 74 09 00 00       	call   80103df0 <mycpu>
8010347c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010347e:	b8 01 00 00 00       	mov    $0x1,%eax
80103483:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010348a:	e8 e1 0d 00 00       	call   80104270 <scheduler>
8010348f:	90                   	nop

80103490 <mpenter>:
{
80103490:	55                   	push   %ebp
80103491:	89 e5                	mov    %esp,%ebp
80103493:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103496:	e8 55 3d 00 00       	call   801071f0 <switchkvm>
  seginit();
8010349b:	e8 c0 3c 00 00       	call   80107160 <seginit>
  lapicinit();
801034a0:	e8 9b f7 ff ff       	call   80102c40 <lapicinit>
  mpmain();
801034a5:	e8 a6 ff ff ff       	call   80103450 <mpmain>
801034aa:	66 90                	xchg   %ax,%ax
801034ac:	66 90                	xchg   %ax,%ax
801034ae:	66 90                	xchg   %ax,%ax

801034b0 <main>:
{
801034b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801034b4:	83 e4 f0             	and    $0xfffffff0,%esp
801034b7:	ff 71 fc             	pushl  -0x4(%ecx)
801034ba:	55                   	push   %ebp
801034bb:	89 e5                	mov    %esp,%ebp
801034bd:	53                   	push   %ebx
801034be:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801034bf:	83 ec 08             	sub    $0x8,%esp
801034c2:	68 00 00 40 80       	push   $0x80400000
801034c7:	68 c8 89 15 80       	push   $0x801589c8
801034cc:	e8 8f f3 ff ff       	call   80102860 <kinit1>
  kvmalloc();      // kernel page table
801034d1:	e8 3a 42 00 00       	call   80107710 <kvmalloc>
  mpinit();        // detect other processors
801034d6:	e8 75 01 00 00       	call   80103650 <mpinit>
  lapicinit();     // interrupt controller
801034db:	e8 60 f7 ff ff       	call   80102c40 <lapicinit>
  seginit();       // segment descriptors
801034e0:	e8 7b 3c 00 00       	call   80107160 <seginit>
  picinit();       // disable pic
801034e5:	e8 46 03 00 00       	call   80103830 <picinit>
  ioapicinit();    // another interrupt controller
801034ea:	e8 41 f1 ff ff       	call   80102630 <ioapicinit>
  consoleinit();   // console hardware
801034ef:	e8 cc d4 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801034f4:	e8 d7 2f 00 00       	call   801064d0 <uartinit>
  pinit();         // process table
801034f9:	e8 d2 08 00 00       	call   80103dd0 <pinit>
  tvinit();        // trap vectors
801034fe:	e8 cd 2a 00 00       	call   80105fd0 <tvinit>
  binit();         // buffer cache
80103503:	e8 38 cb ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103508:	e8 d3 d8 ff ff       	call   80100de0 <fileinit>
  ideinit();       // disk 
8010350d:	e8 fe ee ff ff       	call   80102410 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103512:	83 c4 0c             	add    $0xc,%esp
80103515:	68 8a 00 00 00       	push   $0x8a
8010351a:	68 8c c4 10 80       	push   $0x8010c48c
8010351f:	68 00 70 00 80       	push   $0x80007000
80103524:	e8 07 19 00 00       	call   80104e30 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103529:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103530:	00 00 00 
80103533:	83 c4 10             	add    $0x10,%esp
80103536:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010353b:	3d a0 c7 14 80       	cmp    $0x8014c7a0,%eax
80103540:	76 71                	jbe    801035b3 <main+0x103>
80103542:	bb a0 c7 14 80       	mov    $0x8014c7a0,%ebx
80103547:	89 f6                	mov    %esi,%esi
80103549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103550:	e8 9b 08 00 00       	call   80103df0 <mycpu>
80103555:	39 d8                	cmp    %ebx,%eax
80103557:	74 41                	je     8010359a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103559:	e8 02 f4 ff ff       	call   80102960 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010355e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103563:	c7 05 f8 6f 00 80 90 	movl   $0x80103490,0x80006ff8
8010356a:	34 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010356d:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103574:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103577:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010357c:	0f b6 03             	movzbl (%ebx),%eax
8010357f:	83 ec 08             	sub    $0x8,%esp
80103582:	68 00 70 00 00       	push   $0x7000
80103587:	50                   	push   %eax
80103588:	e8 03 f8 ff ff       	call   80102d90 <lapicstartap>
8010358d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103590:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103596:	85 c0                	test   %eax,%eax
80103598:	74 f6                	je     80103590 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010359a:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
801035a1:	00 00 00 
801035a4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035aa:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
801035af:	39 c3                	cmp    %eax,%ebx
801035b1:	72 9d                	jb     80103550 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801035b3:	83 ec 08             	sub    $0x8,%esp
801035b6:	68 00 00 00 8e       	push   $0x8e000000
801035bb:	68 00 00 40 80       	push   $0x80400000
801035c0:	e8 2b f3 ff ff       	call   801028f0 <kinit2>
  userinit();      // first user process
801035c5:	e8 f6 08 00 00       	call   80103ec0 <userinit>
  mpmain();        // finish this processor's setup
801035ca:	e8 81 fe ff ff       	call   80103450 <mpmain>
801035cf:	90                   	nop

801035d0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801035d5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801035db:	53                   	push   %ebx
  e = addr+len;
801035dc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801035df:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801035e2:	39 de                	cmp    %ebx,%esi
801035e4:	72 10                	jb     801035f6 <mpsearch1+0x26>
801035e6:	eb 50                	jmp    80103638 <mpsearch1+0x68>
801035e8:	90                   	nop
801035e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f0:	39 fb                	cmp    %edi,%ebx
801035f2:	89 fe                	mov    %edi,%esi
801035f4:	76 42                	jbe    80103638 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035f6:	83 ec 04             	sub    $0x4,%esp
801035f9:	8d 7e 10             	lea    0x10(%esi),%edi
801035fc:	6a 04                	push   $0x4
801035fe:	68 b8 8a 10 80       	push   $0x80108ab8
80103603:	56                   	push   %esi
80103604:	e8 c7 17 00 00       	call   80104dd0 <memcmp>
80103609:	83 c4 10             	add    $0x10,%esp
8010360c:	85 c0                	test   %eax,%eax
8010360e:	75 e0                	jne    801035f0 <mpsearch1+0x20>
80103610:	89 f1                	mov    %esi,%ecx
80103612:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103618:	0f b6 11             	movzbl (%ecx),%edx
8010361b:	83 c1 01             	add    $0x1,%ecx
8010361e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103620:	39 f9                	cmp    %edi,%ecx
80103622:	75 f4                	jne    80103618 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103624:	84 c0                	test   %al,%al
80103626:	75 c8                	jne    801035f0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103628:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010362b:	89 f0                	mov    %esi,%eax
8010362d:	5b                   	pop    %ebx
8010362e:	5e                   	pop    %esi
8010362f:	5f                   	pop    %edi
80103630:	5d                   	pop    %ebp
80103631:	c3                   	ret    
80103632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103638:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010363b:	31 f6                	xor    %esi,%esi
}
8010363d:	89 f0                	mov    %esi,%eax
8010363f:	5b                   	pop    %ebx
80103640:	5e                   	pop    %esi
80103641:	5f                   	pop    %edi
80103642:	5d                   	pop    %ebp
80103643:	c3                   	ret    
80103644:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010364a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103650 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103659:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103660:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103667:	c1 e0 08             	shl    $0x8,%eax
8010366a:	09 d0                	or     %edx,%eax
8010366c:	c1 e0 04             	shl    $0x4,%eax
8010366f:	85 c0                	test   %eax,%eax
80103671:	75 1b                	jne    8010368e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103673:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010367a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103681:	c1 e0 08             	shl    $0x8,%eax
80103684:	09 d0                	or     %edx,%eax
80103686:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103689:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010368e:	ba 00 04 00 00       	mov    $0x400,%edx
80103693:	e8 38 ff ff ff       	call   801035d0 <mpsearch1>
80103698:	85 c0                	test   %eax,%eax
8010369a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010369d:	0f 84 3d 01 00 00    	je     801037e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801036a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801036a6:	8b 58 04             	mov    0x4(%eax),%ebx
801036a9:	85 db                	test   %ebx,%ebx
801036ab:	0f 84 4f 01 00 00    	je     80103800 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801036b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801036b7:	83 ec 04             	sub    $0x4,%esp
801036ba:	6a 04                	push   $0x4
801036bc:	68 d5 8a 10 80       	push   $0x80108ad5
801036c1:	56                   	push   %esi
801036c2:	e8 09 17 00 00       	call   80104dd0 <memcmp>
801036c7:	83 c4 10             	add    $0x10,%esp
801036ca:	85 c0                	test   %eax,%eax
801036cc:	0f 85 2e 01 00 00    	jne    80103800 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801036d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801036d9:	3c 01                	cmp    $0x1,%al
801036db:	0f 95 c2             	setne  %dl
801036de:	3c 04                	cmp    $0x4,%al
801036e0:	0f 95 c0             	setne  %al
801036e3:	20 c2                	and    %al,%dl
801036e5:	0f 85 15 01 00 00    	jne    80103800 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801036eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801036f2:	66 85 ff             	test   %di,%di
801036f5:	74 1a                	je     80103711 <mpinit+0xc1>
801036f7:	89 f0                	mov    %esi,%eax
801036f9:	01 f7                	add    %esi,%edi
  sum = 0;
801036fb:	31 d2                	xor    %edx,%edx
801036fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103700:	0f b6 08             	movzbl (%eax),%ecx
80103703:	83 c0 01             	add    $0x1,%eax
80103706:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103708:	39 c7                	cmp    %eax,%edi
8010370a:	75 f4                	jne    80103700 <mpinit+0xb0>
8010370c:	84 d2                	test   %dl,%dl
8010370e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103711:	85 f6                	test   %esi,%esi
80103713:	0f 84 e7 00 00 00    	je     80103800 <mpinit+0x1b0>
80103719:	84 d2                	test   %dl,%dl
8010371b:	0f 85 df 00 00 00    	jne    80103800 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103721:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103727:	a3 80 c6 14 80       	mov    %eax,0x8014c680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010372c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103733:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103739:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010373e:	01 d6                	add    %edx,%esi
80103740:	39 c6                	cmp    %eax,%esi
80103742:	76 23                	jbe    80103767 <mpinit+0x117>
    switch(*p){
80103744:	0f b6 10             	movzbl (%eax),%edx
80103747:	80 fa 04             	cmp    $0x4,%dl
8010374a:	0f 87 ca 00 00 00    	ja     8010381a <mpinit+0x1ca>
80103750:	ff 24 95 fc 8a 10 80 	jmp    *-0x7fef7504(,%edx,4)
80103757:	89 f6                	mov    %esi,%esi
80103759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103760:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103763:	39 c6                	cmp    %eax,%esi
80103765:	77 dd                	ja     80103744 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103767:	85 db                	test   %ebx,%ebx
80103769:	0f 84 9e 00 00 00    	je     8010380d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010376f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103772:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103776:	74 15                	je     8010378d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103778:	b8 70 00 00 00       	mov    $0x70,%eax
8010377d:	ba 22 00 00 00       	mov    $0x22,%edx
80103782:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103783:	ba 23 00 00 00       	mov    $0x23,%edx
80103788:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103789:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010378c:	ee                   	out    %al,(%dx)
  }
}
8010378d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103790:	5b                   	pop    %ebx
80103791:	5e                   	pop    %esi
80103792:	5f                   	pop    %edi
80103793:	5d                   	pop    %ebp
80103794:	c3                   	ret    
80103795:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103798:	8b 0d 20 cd 14 80    	mov    0x8014cd20,%ecx
8010379e:	83 f9 07             	cmp    $0x7,%ecx
801037a1:	7f 19                	jg     801037bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801037a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801037a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801037ad:	83 c1 01             	add    $0x1,%ecx
801037b0:	89 0d 20 cd 14 80    	mov    %ecx,0x8014cd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801037b6:	88 97 a0 c7 14 80    	mov    %dl,-0x7feb3860(%edi)
      p += sizeof(struct mpproc);
801037bc:	83 c0 14             	add    $0x14,%eax
      continue;
801037bf:	e9 7c ff ff ff       	jmp    80103740 <mpinit+0xf0>
801037c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801037c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801037cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801037cf:	88 15 80 c7 14 80    	mov    %dl,0x8014c780
      continue;
801037d5:	e9 66 ff ff ff       	jmp    80103740 <mpinit+0xf0>
801037da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801037e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801037e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801037ea:	e8 e1 fd ff ff       	call   801035d0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037ef:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801037f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037f4:	0f 85 a9 fe ff ff    	jne    801036a3 <mpinit+0x53>
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	68 bd 8a 10 80       	push   $0x80108abd
80103808:	e8 83 cb ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010380d:	83 ec 0c             	sub    $0xc,%esp
80103810:	68 dc 8a 10 80       	push   $0x80108adc
80103815:	e8 76 cb ff ff       	call   80100390 <panic>
      ismp = 0;
8010381a:	31 db                	xor    %ebx,%ebx
8010381c:	e9 26 ff ff ff       	jmp    80103747 <mpinit+0xf7>
80103821:	66 90                	xchg   %ax,%ax
80103823:	66 90                	xchg   %ax,%ax
80103825:	66 90                	xchg   %ax,%ax
80103827:	66 90                	xchg   %ax,%ax
80103829:	66 90                	xchg   %ax,%ax
8010382b:	66 90                	xchg   %ax,%ax
8010382d:	66 90                	xchg   %ax,%ax
8010382f:	90                   	nop

80103830 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103830:	55                   	push   %ebp
80103831:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103836:	ba 21 00 00 00       	mov    $0x21,%edx
8010383b:	89 e5                	mov    %esp,%ebp
8010383d:	ee                   	out    %al,(%dx)
8010383e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103843:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103844:	5d                   	pop    %ebp
80103845:	c3                   	ret    
80103846:	66 90                	xchg   %ax,%ax
80103848:	66 90                	xchg   %ax,%ax
8010384a:	66 90                	xchg   %ax,%ax
8010384c:	66 90                	xchg   %ax,%ax
8010384e:	66 90                	xchg   %ax,%ax

80103850 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	57                   	push   %edi
80103854:	56                   	push   %esi
80103855:	53                   	push   %ebx
80103856:	83 ec 0c             	sub    $0xc,%esp
80103859:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010385c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010385f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103865:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010386b:	e8 90 d5 ff ff       	call   80100e00 <filealloc>
80103870:	85 c0                	test   %eax,%eax
80103872:	89 03                	mov    %eax,(%ebx)
80103874:	74 22                	je     80103898 <pipealloc+0x48>
80103876:	e8 85 d5 ff ff       	call   80100e00 <filealloc>
8010387b:	85 c0                	test   %eax,%eax
8010387d:	89 06                	mov    %eax,(%esi)
8010387f:	74 3f                	je     801038c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103881:	e8 da f0 ff ff       	call   80102960 <kalloc>
80103886:	85 c0                	test   %eax,%eax
80103888:	89 c7                	mov    %eax,%edi
8010388a:	75 54                	jne    801038e0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010388c:	8b 03                	mov    (%ebx),%eax
8010388e:	85 c0                	test   %eax,%eax
80103890:	75 34                	jne    801038c6 <pipealloc+0x76>
80103892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103898:	8b 06                	mov    (%esi),%eax
8010389a:	85 c0                	test   %eax,%eax
8010389c:	74 0c                	je     801038aa <pipealloc+0x5a>
    fileclose(*f1);
8010389e:	83 ec 0c             	sub    $0xc,%esp
801038a1:	50                   	push   %eax
801038a2:	e8 19 d6 ff ff       	call   80100ec0 <fileclose>
801038a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801038aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801038ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801038b2:	5b                   	pop    %ebx
801038b3:	5e                   	pop    %esi
801038b4:	5f                   	pop    %edi
801038b5:	5d                   	pop    %ebp
801038b6:	c3                   	ret    
801038b7:	89 f6                	mov    %esi,%esi
801038b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801038c0:	8b 03                	mov    (%ebx),%eax
801038c2:	85 c0                	test   %eax,%eax
801038c4:	74 e4                	je     801038aa <pipealloc+0x5a>
    fileclose(*f0);
801038c6:	83 ec 0c             	sub    $0xc,%esp
801038c9:	50                   	push   %eax
801038ca:	e8 f1 d5 ff ff       	call   80100ec0 <fileclose>
  if(*f1)
801038cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801038d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801038d4:	85 c0                	test   %eax,%eax
801038d6:	75 c6                	jne    8010389e <pipealloc+0x4e>
801038d8:	eb d0                	jmp    801038aa <pipealloc+0x5a>
801038da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801038e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801038e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801038ea:	00 00 00 
  p->writeopen = 1;
801038ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801038f4:	00 00 00 
  p->nwrite = 0;
801038f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801038fe:	00 00 00 
  p->nread = 0;
80103901:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103908:	00 00 00 
  initlock(&p->lock, "pipe");
8010390b:	68 10 8b 10 80       	push   $0x80108b10
80103910:	50                   	push   %eax
80103911:	e8 1a 12 00 00       	call   80104b30 <initlock>
  (*f0)->type = FD_PIPE;
80103916:	8b 03                	mov    (%ebx),%eax
  return 0;
80103918:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010391b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103921:	8b 03                	mov    (%ebx),%eax
80103923:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103927:	8b 03                	mov    (%ebx),%eax
80103929:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010392d:	8b 03                	mov    (%ebx),%eax
8010392f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103932:	8b 06                	mov    (%esi),%eax
80103934:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010393a:	8b 06                	mov    (%esi),%eax
8010393c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103940:	8b 06                	mov    (%esi),%eax
80103942:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103946:	8b 06                	mov    (%esi),%eax
80103948:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010394b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010394e:	31 c0                	xor    %eax,%eax
}
80103950:	5b                   	pop    %ebx
80103951:	5e                   	pop    %esi
80103952:	5f                   	pop    %edi
80103953:	5d                   	pop    %ebp
80103954:	c3                   	ret    
80103955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	56                   	push   %esi
80103964:	53                   	push   %ebx
80103965:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103968:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010396b:	83 ec 0c             	sub    $0xc,%esp
8010396e:	53                   	push   %ebx
8010396f:	e8 fc 12 00 00       	call   80104c70 <acquire>
  if(writable){
80103974:	83 c4 10             	add    $0x10,%esp
80103977:	85 f6                	test   %esi,%esi
80103979:	74 45                	je     801039c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010397b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103981:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103984:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010398b:	00 00 00 
    wakeup(&p->nread);
8010398e:	50                   	push   %eax
8010398f:	e8 ac 0d 00 00       	call   80104740 <wakeup>
80103994:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103997:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010399d:	85 d2                	test   %edx,%edx
8010399f:	75 0a                	jne    801039ab <pipeclose+0x4b>
801039a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801039a7:	85 c0                	test   %eax,%eax
801039a9:	74 35                	je     801039e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801039ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801039ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039b1:	5b                   	pop    %ebx
801039b2:	5e                   	pop    %esi
801039b3:	5d                   	pop    %ebp
    release(&p->lock);
801039b4:	e9 77 13 00 00       	jmp    80104d30 <release>
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801039c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801039c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801039c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801039d0:	00 00 00 
    wakeup(&p->nwrite);
801039d3:	50                   	push   %eax
801039d4:	e8 67 0d 00 00       	call   80104740 <wakeup>
801039d9:	83 c4 10             	add    $0x10,%esp
801039dc:	eb b9                	jmp    80103997 <pipeclose+0x37>
801039de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801039e0:	83 ec 0c             	sub    $0xc,%esp
801039e3:	53                   	push   %ebx
801039e4:	e8 47 13 00 00       	call   80104d30 <release>
    kfree((char*)p);
801039e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801039ec:	83 c4 10             	add    $0x10,%esp
}
801039ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801039f2:	5b                   	pop    %ebx
801039f3:	5e                   	pop    %esi
801039f4:	5d                   	pop    %ebp
    kfree((char*)p);
801039f5:	e9 26 ed ff ff       	jmp    80102720 <kfree>
801039fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a00 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	57                   	push   %edi
80103a04:	56                   	push   %esi
80103a05:	53                   	push   %ebx
80103a06:	83 ec 28             	sub    $0x28,%esp
80103a09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103a0c:	53                   	push   %ebx
80103a0d:	e8 5e 12 00 00       	call   80104c70 <acquire>
  for(i = 0; i < n; i++){
80103a12:	8b 45 10             	mov    0x10(%ebp),%eax
80103a15:	83 c4 10             	add    $0x10,%esp
80103a18:	85 c0                	test   %eax,%eax
80103a1a:	0f 8e c9 00 00 00    	jle    80103ae9 <pipewrite+0xe9>
80103a20:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103a23:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103a29:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103a2f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103a32:	03 4d 10             	add    0x10(%ebp),%ecx
80103a35:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103a38:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103a3e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103a44:	39 d0                	cmp    %edx,%eax
80103a46:	75 71                	jne    80103ab9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103a48:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103a4e:	85 c0                	test   %eax,%eax
80103a50:	74 4e                	je     80103aa0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103a52:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103a58:	eb 3a                	jmp    80103a94 <pipewrite+0x94>
80103a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	57                   	push   %edi
80103a64:	e8 d7 0c 00 00       	call   80104740 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103a69:	5a                   	pop    %edx
80103a6a:	59                   	pop    %ecx
80103a6b:	53                   	push   %ebx
80103a6c:	56                   	push   %esi
80103a6d:	e8 0e 0b 00 00       	call   80104580 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103a72:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103a78:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103a7e:	83 c4 10             	add    $0x10,%esp
80103a81:	05 00 02 00 00       	add    $0x200,%eax
80103a86:	39 c2                	cmp    %eax,%edx
80103a88:	75 36                	jne    80103ac0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103a8a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103a90:	85 c0                	test   %eax,%eax
80103a92:	74 0c                	je     80103aa0 <pipewrite+0xa0>
80103a94:	e8 f7 03 00 00       	call   80103e90 <myproc>
80103a99:	8b 40 24             	mov    0x24(%eax),%eax
80103a9c:	85 c0                	test   %eax,%eax
80103a9e:	74 c0                	je     80103a60 <pipewrite+0x60>
        release(&p->lock);
80103aa0:	83 ec 0c             	sub    $0xc,%esp
80103aa3:	53                   	push   %ebx
80103aa4:	e8 87 12 00 00       	call   80104d30 <release>
        return -1;
80103aa9:	83 c4 10             	add    $0x10,%esp
80103aac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ab4:	5b                   	pop    %ebx
80103ab5:	5e                   	pop    %esi
80103ab6:	5f                   	pop    %edi
80103ab7:	5d                   	pop    %ebp
80103ab8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ab9:	89 c2                	mov    %eax,%edx
80103abb:	90                   	nop
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103ac0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103ac3:	8d 42 01             	lea    0x1(%edx),%eax
80103ac6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103acc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103ad2:	83 c6 01             	add    $0x1,%esi
80103ad5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103ad9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103adc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103adf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103ae3:	0f 85 4f ff ff ff    	jne    80103a38 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103ae9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103aef:	83 ec 0c             	sub    $0xc,%esp
80103af2:	50                   	push   %eax
80103af3:	e8 48 0c 00 00       	call   80104740 <wakeup>
  release(&p->lock);
80103af8:	89 1c 24             	mov    %ebx,(%esp)
80103afb:	e8 30 12 00 00       	call   80104d30 <release>
  return n;
80103b00:	83 c4 10             	add    $0x10,%esp
80103b03:	8b 45 10             	mov    0x10(%ebp),%eax
80103b06:	eb a9                	jmp    80103ab1 <pipewrite+0xb1>
80103b08:	90                   	nop
80103b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b10 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 18             	sub    $0x18,%esp
80103b19:	8b 75 08             	mov    0x8(%ebp),%esi
80103b1c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103b1f:	56                   	push   %esi
80103b20:	e8 4b 11 00 00       	call   80104c70 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103b25:	83 c4 10             	add    $0x10,%esp
80103b28:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103b2e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103b34:	75 6a                	jne    80103ba0 <piperead+0x90>
80103b36:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103b3c:	85 db                	test   %ebx,%ebx
80103b3e:	0f 84 c4 00 00 00    	je     80103c08 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103b44:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103b4a:	eb 2d                	jmp    80103b79 <piperead+0x69>
80103b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b50:	83 ec 08             	sub    $0x8,%esp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	e8 26 0a 00 00       	call   80104580 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103b5a:	83 c4 10             	add    $0x10,%esp
80103b5d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103b63:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103b69:	75 35                	jne    80103ba0 <piperead+0x90>
80103b6b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103b71:	85 d2                	test   %edx,%edx
80103b73:	0f 84 8f 00 00 00    	je     80103c08 <piperead+0xf8>
    if(myproc()->killed){
80103b79:	e8 12 03 00 00       	call   80103e90 <myproc>
80103b7e:	8b 48 24             	mov    0x24(%eax),%ecx
80103b81:	85 c9                	test   %ecx,%ecx
80103b83:	74 cb                	je     80103b50 <piperead+0x40>
      release(&p->lock);
80103b85:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103b88:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103b8d:	56                   	push   %esi
80103b8e:	e8 9d 11 00 00       	call   80104d30 <release>
      return -1;
80103b93:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103b96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b99:	89 d8                	mov    %ebx,%eax
80103b9b:	5b                   	pop    %ebx
80103b9c:	5e                   	pop    %esi
80103b9d:	5f                   	pop    %edi
80103b9e:	5d                   	pop    %ebp
80103b9f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103ba0:	8b 45 10             	mov    0x10(%ebp),%eax
80103ba3:	85 c0                	test   %eax,%eax
80103ba5:	7e 61                	jle    80103c08 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103ba7:	31 db                	xor    %ebx,%ebx
80103ba9:	eb 13                	jmp    80103bbe <piperead+0xae>
80103bab:	90                   	nop
80103bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bb0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103bb6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103bbc:	74 1f                	je     80103bdd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103bbe:	8d 41 01             	lea    0x1(%ecx),%eax
80103bc1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103bc7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103bcd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103bd2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103bd5:	83 c3 01             	add    $0x1,%ebx
80103bd8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103bdb:	75 d3                	jne    80103bb0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103bdd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103be3:	83 ec 0c             	sub    $0xc,%esp
80103be6:	50                   	push   %eax
80103be7:	e8 54 0b 00 00       	call   80104740 <wakeup>
  release(&p->lock);
80103bec:	89 34 24             	mov    %esi,(%esp)
80103bef:	e8 3c 11 00 00       	call   80104d30 <release>
  return i;
80103bf4:	83 c4 10             	add    $0x10,%esp
}
80103bf7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bfa:	89 d8                	mov    %ebx,%eax
80103bfc:	5b                   	pop    %ebx
80103bfd:	5e                   	pop    %esi
80103bfe:	5f                   	pop    %edi
80103bff:	5d                   	pop    %ebp
80103c00:	c3                   	ret    
80103c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c08:	31 db                	xor    %ebx,%ebx
80103c0a:	eb d1                	jmp    80103bdd <piperead+0xcd>
80103c0c:	66 90                	xchg   %ax,%ax
80103c0e:	66 90                	xchg   %ax,%ax

80103c10 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c14:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80103c19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c1c:	68 40 cd 14 80       	push   $0x8014cd40
80103c21:	e8 4a 10 00 00       	call   80104c70 <acquire>
80103c26:	83 c4 10             	add    $0x10,%esp
80103c29:	eb 17                	jmp    80103c42 <allocproc+0x32>
80103c2b:	90                   	nop
80103c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c30:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
80103c36:	81 fb 74 81 15 80    	cmp    $0x80158174,%ebx
80103c3c:	0f 83 0e 01 00 00    	jae    80103d50 <allocproc+0x140>
    if(p->state == UNUSED)
80103c42:	8b 43 0c             	mov    0xc(%ebx),%eax
80103c45:	85 c0                	test   %eax,%eax
80103c47:	75 e7                	jne    80103c30 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103c49:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80103c4e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103c51:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103c58:	8d 50 01             	lea    0x1(%eax),%edx
80103c5b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103c5e:	68 40 cd 14 80       	push   $0x8014cd40
  p->pid = nextpid++;
80103c63:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103c69:	e8 c2 10 00 00       	call   80104d30 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103c6e:	e8 ed ec ff ff       	call   80102960 <kalloc>
80103c73:	83 c4 10             	add    $0x10,%esp
80103c76:	85 c0                	test   %eax,%eax
80103c78:	89 43 08             	mov    %eax,0x8(%ebx)
80103c7b:	0f 84 e8 00 00 00    	je     80103d69 <allocproc+0x159>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103c81:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103c87:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103c8a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103c8f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103c92:	c7 40 14 c1 5f 10 80 	movl   $0x80105fc1,0x14(%eax)
  p->context = (struct context*)sp;
80103c99:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103c9c:	6a 14                	push   $0x14
80103c9e:	6a 00                	push   $0x0
80103ca0:	50                   	push   %eax
80103ca1:	e8 da 10 00 00       	call   80104d80 <memset>
  p->context->eip = (uint)forkret;
80103ca6:	8b 43 1c             	mov    0x1c(%ebx),%eax

  p->headPG = -1;
  // Task 1
  if(p->pid>2){
80103ca9:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103cac:	c7 40 10 80 3d 10 80 	movl   $0x80103d80,0x10(%eax)
  if(p->pid>2){
80103cb3:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  p->headPG = -1;
80103cb7:	c7 83 8c 00 00 00 ff 	movl   $0xffffffff,0x8c(%ebx)
80103cbe:	ff ff ff 
  if(p->pid>2){
80103cc1:	7f 75                	jg     80103d38 <allocproc+0x128>
80103cc3:	8d 93 98 00 00 00    	lea    0x98(%ebx),%edx
80103cc9:	8d 83 90 01 00 00    	lea    0x190(%ebx),%eax
80103ccf:	8d 8b d0 02 00 00    	lea    0x2d0(%ebx),%ecx
80103cd5:	8d 76 00             	lea    0x0(%esi),%esi

  }

  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103cd8:	c7 42 04 ff ff ff ff 	movl   $0xffffffff,0x4(%edx)
    p->swappedPGs[i].changeCounter = 0;
80103cdf:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103ce5:	83 c0 14             	add    $0x14,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103ce8:	c7 40 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%eax)
    p->physicalPGs[i].prev = 0;
80103cef:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80103cf6:	83 c2 10             	add    $0x10,%edx
    p->physicalPGs[i].next = 0;
80103cf9:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103d00:	39 c8                	cmp    %ecx,%eax
80103d02:	75 d4                	jne    80103cd8 <allocproc+0xc8>
  }
  p->allocatedInPhys = 0;
80103d04:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103d0b:	00 00 00 
  p->nPgsSwap = 0;
80103d0e:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103d15:	00 00 00 
  p->nPgsPhysical = 0;
80103d18:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103d1f:	00 00 00 
  p->headPG = 0;
80103d22:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103d29:	00 00 00 

  return p;
}
80103d2c:	89 d8                	mov    %ebx,%eax
80103d2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d31:	c9                   	leave  
80103d32:	c3                   	ret    
80103d33:	90                   	nop
80103d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    createSwapFile(p);
80103d38:	83 ec 0c             	sub    $0xc,%esp
80103d3b:	53                   	push   %ebx
80103d3c:	e8 ef e4 ff ff       	call   80102230 <createSwapFile>
80103d41:	83 c4 10             	add    $0x10,%esp
80103d44:	e9 7a ff ff ff       	jmp    80103cc3 <allocproc+0xb3>
80103d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103d50:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d53:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d55:	68 40 cd 14 80       	push   $0x8014cd40
80103d5a:	e8 d1 0f 00 00       	call   80104d30 <release>
}
80103d5f:	89 d8                	mov    %ebx,%eax
  return 0;
80103d61:	83 c4 10             	add    $0x10,%esp
}
80103d64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d67:	c9                   	leave  
80103d68:	c3                   	ret    
    p->state = UNUSED;
80103d69:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d70:	31 db                	xor    %ebx,%ebx
80103d72:	eb b8                	jmp    80103d2c <allocproc+0x11c>
80103d74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103d80 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103d86:	68 40 cd 14 80       	push   $0x8014cd40
80103d8b:	e8 a0 0f 00 00       	call   80104d30 <release>

  if (first) {
80103d90:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103d95:	83 c4 10             	add    $0x10,%esp
80103d98:	85 c0                	test   %eax,%eax
80103d9a:	75 04                	jne    80103da0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103d9c:	c9                   	leave  
80103d9d:	c3                   	ret    
80103d9e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103da0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103da3:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103daa:	00 00 00 
    iinit(ROOTDEV);
80103dad:	6a 01                	push   $0x1
80103daf:	e8 4c d7 ff ff       	call   80101500 <iinit>
    initlog(ROOTDEV);
80103db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103dbb:	e8 50 f3 ff ff       	call   80103110 <initlog>
80103dc0:	83 c4 10             	add    $0x10,%esp
}
80103dc3:	c9                   	leave  
80103dc4:	c3                   	ret    
80103dc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dd0 <pinit>:
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103dd6:	68 15 8b 10 80       	push   $0x80108b15
80103ddb:	68 40 cd 14 80       	push   $0x8014cd40
80103de0:	e8 4b 0d 00 00       	call   80104b30 <initlock>
}
80103de5:	83 c4 10             	add    $0x10,%esp
80103de8:	c9                   	leave  
80103de9:	c3                   	ret    
80103dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103df0 <mycpu>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	56                   	push   %esi
80103df4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103df5:	9c                   	pushf  
80103df6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103df7:	f6 c4 02             	test   $0x2,%ah
80103dfa:	75 5e                	jne    80103e5a <mycpu+0x6a>
  apicid = lapicid();
80103dfc:	e8 3f ef ff ff       	call   80102d40 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e01:	8b 35 20 cd 14 80    	mov    0x8014cd20,%esi
80103e07:	85 f6                	test   %esi,%esi
80103e09:	7e 42                	jle    80103e4d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103e0b:	0f b6 15 a0 c7 14 80 	movzbl 0x8014c7a0,%edx
80103e12:	39 d0                	cmp    %edx,%eax
80103e14:	74 30                	je     80103e46 <mycpu+0x56>
80103e16:	b9 50 c8 14 80       	mov    $0x8014c850,%ecx
  for (i = 0; i < ncpu; ++i) {
80103e1b:	31 d2                	xor    %edx,%edx
80103e1d:	8d 76 00             	lea    0x0(%esi),%esi
80103e20:	83 c2 01             	add    $0x1,%edx
80103e23:	39 f2                	cmp    %esi,%edx
80103e25:	74 26                	je     80103e4d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103e27:	0f b6 19             	movzbl (%ecx),%ebx
80103e2a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103e30:	39 c3                	cmp    %eax,%ebx
80103e32:	75 ec                	jne    80103e20 <mycpu+0x30>
80103e34:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103e3a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
}
80103e3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e42:	5b                   	pop    %ebx
80103e43:	5e                   	pop    %esi
80103e44:	5d                   	pop    %ebp
80103e45:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103e46:	b8 a0 c7 14 80       	mov    $0x8014c7a0,%eax
      return &cpus[i];
80103e4b:	eb f2                	jmp    80103e3f <mycpu+0x4f>
  panic("unknown apicid\n");
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	68 1c 8b 10 80       	push   $0x80108b1c
80103e55:	e8 36 c5 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 58 8c 10 80       	push   $0x80108c58
80103e62:	e8 29 c5 ff ff       	call   80100390 <panic>
80103e67:	89 f6                	mov    %esi,%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <cpuid>:
cpuid() {
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103e76:	e8 75 ff ff ff       	call   80103df0 <mycpu>
80103e7b:	2d a0 c7 14 80       	sub    $0x8014c7a0,%eax
}
80103e80:	c9                   	leave  
  return mycpu()-cpus;
80103e81:	c1 f8 04             	sar    $0x4,%eax
80103e84:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103e8a:	c3                   	ret    
80103e8b:	90                   	nop
80103e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e90 <myproc>:
myproc(void) {
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	53                   	push   %ebx
80103e94:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103e97:	e8 04 0d 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
80103e9c:	e8 4f ff ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80103ea1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea7:	e8 34 0d 00 00       	call   80104be0 <popcli>
}
80103eac:	83 c4 04             	add    $0x4,%esp
80103eaf:	89 d8                	mov    %ebx,%eax
80103eb1:	5b                   	pop    %ebx
80103eb2:	5d                   	pop    %ebp
80103eb3:	c3                   	ret    
80103eb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103eba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103ec0 <userinit>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	53                   	push   %ebx
80103ec4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ec7:	e8 44 fd ff ff       	call   80103c10 <allocproc>
80103ecc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103ece:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  if((p->pgdir = setupkvm()) == 0)
80103ed3:	e8 b8 37 00 00       	call   80107690 <setupkvm>
80103ed8:	85 c0                	test   %eax,%eax
80103eda:	89 43 04             	mov    %eax,0x4(%ebx)
80103edd:	0f 84 da 00 00 00    	je     80103fbd <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ee3:	83 ec 04             	sub    $0x4,%esp
80103ee6:	68 2c 00 00 00       	push   $0x2c
80103eeb:	68 60 c4 10 80       	push   $0x8010c460
80103ef0:	50                   	push   %eax
80103ef1:	e8 2a 34 00 00       	call   80107320 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ef6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ef9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103eff:	6a 4c                	push   $0x4c
80103f01:	6a 00                	push   $0x0
80103f03:	ff 73 18             	pushl  0x18(%ebx)
80103f06:	e8 75 0e 00 00       	call   80104d80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f0b:	8b 43 18             	mov    0x18(%ebx),%eax
80103f0e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f13:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f18:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f1b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f1f:	8b 43 18             	mov    0x18(%ebx),%eax
80103f22:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103f26:	8b 43 18             	mov    0x18(%ebx),%eax
80103f29:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f2d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103f31:	8b 43 18             	mov    0x18(%ebx),%eax
80103f34:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f38:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103f3c:	8b 43 18             	mov    0x18(%ebx),%eax
80103f3f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103f46:	8b 43 18             	mov    0x18(%ebx),%eax
80103f49:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103f50:	8b 43 18             	mov    0x18(%ebx),%eax
80103f53:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f5a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103f5d:	6a 10                	push   $0x10
80103f5f:	68 45 8b 10 80       	push   $0x80108b45
80103f64:	50                   	push   %eax
80103f65:	e8 f6 0f 00 00       	call   80104f60 <safestrcpy>
  p->cwd = namei("/");
80103f6a:	c7 04 24 4e 8b 10 80 	movl   $0x80108b4e,(%esp)
80103f71:	e8 ea df ff ff       	call   80101f60 <namei>
80103f76:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
80103f79:	c7 04 24 50 8b 10 80 	movl   $0x80108b50,(%esp)
80103f80:	e8 db c6 ff ff       	call   80100660 <cprintf>
80103f85:	58                   	pop    %eax
80103f86:	5a                   	pop    %edx
80103f87:	68 00 e0 00 00       	push   $0xe000
80103f8c:	68 58 8b 10 80       	push   $0x80108b58
80103f91:	e8 ca c6 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
80103f96:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80103f9d:	e8 ce 0c 00 00       	call   80104c70 <acquire>
  p->state = RUNNABLE;
80103fa2:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fa9:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80103fb0:	e8 7b 0d 00 00       	call   80104d30 <release>
}
80103fb5:	83 c4 10             	add    $0x10,%esp
80103fb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fbb:	c9                   	leave  
80103fbc:	c3                   	ret    
    panic("userinit: out of memory?");
80103fbd:	83 ec 0c             	sub    $0xc,%esp
80103fc0:	68 2c 8b 10 80       	push   $0x80108b2c
80103fc5:	e8 c6 c3 ff ff       	call   80100390 <panic>
80103fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fd0 <growproc>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	56                   	push   %esi
80103fd4:	53                   	push   %ebx
80103fd5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103fd8:	e8 c3 0b 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
80103fdd:	e8 0e fe ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80103fe2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fe8:	e8 f3 0b 00 00       	call   80104be0 <popcli>
  if(n > 0){
80103fed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ff0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ff2:	7f 1c                	jg     80104010 <growproc+0x40>
  } else if(n < 0){
80103ff4:	75 3a                	jne    80104030 <growproc+0x60>
  switchuvm(curproc);
80103ff6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ff9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103ffb:	53                   	push   %ebx
80103ffc:	e8 0f 32 00 00       	call   80107210 <switchuvm>
  return 0;
80104001:	83 c4 10             	add    $0x10,%esp
80104004:	31 c0                	xor    %eax,%eax
}
80104006:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104009:	5b                   	pop    %ebx
8010400a:	5e                   	pop    %esi
8010400b:	5d                   	pop    %ebp
8010400c:	c3                   	ret    
8010400d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104010:	83 ec 04             	sub    $0x4,%esp
80104013:	01 c6                	add    %eax,%esi
80104015:	56                   	push   %esi
80104016:	50                   	push   %eax
80104017:	ff 73 04             	pushl  0x4(%ebx)
8010401a:	e8 31 43 00 00       	call   80108350 <allocuvm>
8010401f:	83 c4 10             	add    $0x10,%esp
80104022:	85 c0                	test   %eax,%eax
80104024:	75 d0                	jne    80103ff6 <growproc+0x26>
      return -1;
80104026:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010402b:	eb d9                	jmp    80104006 <growproc+0x36>
8010402d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104030:	83 ec 04             	sub    $0x4,%esp
80104033:	01 c6                	add    %eax,%esi
80104035:	56                   	push   %esi
80104036:	50                   	push   %eax
80104037:	ff 73 04             	pushl  0x4(%ebx)
8010403a:	e8 21 34 00 00       	call   80107460 <deallocuvm>
8010403f:	83 c4 10             	add    $0x10,%esp
80104042:	85 c0                	test   %eax,%eax
80104044:	75 b0                	jne    80103ff6 <growproc+0x26>
80104046:	eb de                	jmp    80104026 <growproc+0x56>
80104048:	90                   	nop
80104049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104050 <fork>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	57                   	push   %edi
80104054:	56                   	push   %esi
80104055:	53                   	push   %ebx
80104056:	81 ec 1c 04 00 00    	sub    $0x41c,%esp
  pushcli();
8010405c:	e8 3f 0b 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
80104061:	e8 8a fd ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80104066:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010406c:	e8 6f 0b 00 00       	call   80104be0 <popcli>
  if((np = allocproc()) == 0){
80104071:	e8 9a fb ff ff       	call   80103c10 <allocproc>
80104076:	85 c0                	test   %eax,%eax
80104078:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
8010407e:	0f 84 a3 01 00 00    	je     80104227 <fork+0x1d7>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104084:	83 ec 08             	sub    $0x8,%esp
80104087:	ff 33                	pushl  (%ebx)
80104089:	ff 73 04             	pushl  0x4(%ebx)
8010408c:	89 c7                	mov    %eax,%edi
8010408e:	e8 cd 36 00 00       	call   80107760 <copyuvm>
80104093:	83 c4 10             	add    $0x10,%esp
80104096:	85 c0                	test   %eax,%eax
80104098:	89 47 04             	mov    %eax,0x4(%edi)
8010409b:	0f 84 92 01 00 00    	je     80104233 <fork+0x1e3>
  np->sz = curproc->sz;
801040a1:	8b 03                	mov    (%ebx),%eax
801040a3:	8b 95 e4 fb ff ff    	mov    -0x41c(%ebp),%edx
  *np->tf = *curproc->tf;
801040a9:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
801040ae:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
801040b0:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
801040b3:	8b 7a 18             	mov    0x18(%edx),%edi
801040b6:	8b 73 18             	mov    0x18(%ebx),%esi
801040b9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
801040bb:	89 d7                	mov    %edx,%edi
  for(i = 0; i < NOFILE; i++)
801040bd:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801040bf:	8b 42 18             	mov    0x18(%edx),%eax
801040c2:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
801040d0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801040d4:	85 c0                	test   %eax,%eax
801040d6:	74 10                	je     801040e8 <fork+0x98>
      np->ofile[i] = filedup(curproc->ofile[i]);
801040d8:	83 ec 0c             	sub    $0xc,%esp
801040db:	50                   	push   %eax
801040dc:	e8 8f cd ff ff       	call   80100e70 <filedup>
801040e1:	83 c4 10             	add    $0x10,%esp
801040e4:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
801040e8:	83 c6 01             	add    $0x1,%esi
801040eb:	83 fe 10             	cmp    $0x10,%esi
801040ee:	75 e0                	jne    801040d0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
801040f0:	83 ec 0c             	sub    $0xc,%esp
801040f3:	ff 73 68             	pushl  0x68(%ebx)
801040f6:	e8 d5 d5 ff ff       	call   801016d0 <idup>
801040fb:	8b bd e4 fb ff ff    	mov    -0x41c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104101:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104104:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104107:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010410a:	6a 10                	push   $0x10
8010410c:	50                   	push   %eax
8010410d:	8d 47 6c             	lea    0x6c(%edi),%eax
80104110:	50                   	push   %eax
80104111:	e8 4a 0e 00 00       	call   80104f60 <safestrcpy>
  if(curproc->pid>2){
80104116:	83 c4 10             	add    $0x10,%esp
80104119:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  pid = np->pid;
8010411d:	8b 47 10             	mov    0x10(%edi),%eax
80104120:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
  if(curproc->pid>2){
80104126:	0f 8e c4 00 00 00    	jle    801041f0 <fork+0x1a0>
    np->headPG = curproc ->headPG;
8010412c:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
    np->nPgsSwap = curproc->nPgsSwap;
80104132:	be 90 00 00 00       	mov    $0x90,%esi
    np->headPG = curproc ->headPG;
80104137:	89 87 8c 00 00 00    	mov    %eax,0x8c(%edi)
    np->nPgsPhysical = curproc->nPgsPhysical;
8010413d:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80104143:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
    np->nPgsSwap = curproc->nPgsSwap;
80104149:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
8010414f:	89 87 84 00 00 00    	mov    %eax,0x84(%edi)
80104155:	bf 90 01 00 00       	mov    $0x190,%edi
8010415a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      memmove(&np->physicalPGs[i],&curproc->physicalPGs[i],sizeof(struct procPG));
80104160:	8d 04 3b             	lea    (%ebx,%edi,1),%eax
80104163:	83 ec 04             	sub    $0x4,%esp
80104166:	6a 14                	push   $0x14
80104168:	50                   	push   %eax
80104169:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
8010416f:	01 f8                	add    %edi,%eax
80104171:	83 c7 14             	add    $0x14,%edi
80104174:	50                   	push   %eax
80104175:	e8 b6 0c 00 00       	call   80104e30 <memmove>
      memmove(&np->swappedPGs[i],&curproc->swappedPGs[i],sizeof(struct swappedPG));
8010417a:	8d 04 33             	lea    (%ebx,%esi,1),%eax
8010417d:	83 c4 0c             	add    $0xc,%esp
80104180:	6a 10                	push   $0x10
80104182:	50                   	push   %eax
80104183:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
80104189:	01 f0                	add    %esi,%eax
8010418b:	83 c6 10             	add    $0x10,%esi
8010418e:	50                   	push   %eax
8010418f:	e8 9c 0c 00 00       	call   80104e30 <memmove>
    for(int i = 0; i < MAX_PSYC_PAGES ; i++){
80104194:	83 c4 10             	add    $0x10,%esp
80104197:	81 ff d0 02 00 00    	cmp    $0x2d0,%edi
8010419d:	75 c1                	jne    80104160 <fork+0x110>
    int maxSZ = (curproc->nPgsSwap)*PGSIZE;
8010419f:	8b bb 84 00 00 00    	mov    0x84(%ebx),%edi
801041a5:	c1 e7 0c             	shl    $0xc,%edi
    for(i=0;i<maxSZ; i+=1024){
801041a8:	85 ff                	test   %edi,%edi
801041aa:	7e 44                	jle    801041f0 <fork+0x1a0>
801041ac:	89 d8                	mov    %ebx,%eax
801041ae:	89 bd e0 fb ff ff    	mov    %edi,-0x420(%ebp)
801041b4:	8d b5 e8 fb ff ff    	lea    -0x418(%ebp),%esi
801041ba:	31 ff                	xor    %edi,%edi
801041bc:	89 fb                	mov    %edi,%ebx
801041be:	89 c7                	mov    %eax,%edi
      readFromSwapFile(curproc,buf,i,1024);
801041c0:	68 00 04 00 00       	push   $0x400
801041c5:	53                   	push   %ebx
801041c6:	56                   	push   %esi
801041c7:	57                   	push   %edi
801041c8:	e8 33 e1 ff ff       	call   80102300 <readFromSwapFile>
      writeToSwapFile(np,buf,i,1024);
801041cd:	68 00 04 00 00       	push   $0x400
801041d2:	53                   	push   %ebx
    for(i=0;i<maxSZ; i+=1024){
801041d3:	81 c3 00 04 00 00    	add    $0x400,%ebx
      writeToSwapFile(np,buf,i,1024);
801041d9:	56                   	push   %esi
801041da:	ff b5 e4 fb ff ff    	pushl  -0x41c(%ebp)
801041e0:	e8 eb e0 ff ff       	call   801022d0 <writeToSwapFile>
    for(i=0;i<maxSZ; i+=1024){
801041e5:	83 c4 20             	add    $0x20,%esp
801041e8:	3b 9d e0 fb ff ff    	cmp    -0x420(%ebp),%ebx
801041ee:	75 d0                	jne    801041c0 <fork+0x170>
  acquire(&ptable.lock);
801041f0:	83 ec 0c             	sub    $0xc,%esp
801041f3:	68 40 cd 14 80       	push   $0x8014cd40
801041f8:	e8 73 0a 00 00       	call   80104c70 <acquire>
  np->state = RUNNABLE;
801041fd:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
80104203:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
8010420a:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104211:	e8 1a 0b 00 00       	call   80104d30 <release>
  return pid;
80104216:	83 c4 10             	add    $0x10,%esp
}
80104219:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
8010421f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104222:	5b                   	pop    %ebx
80104223:	5e                   	pop    %esi
80104224:	5f                   	pop    %edi
80104225:	5d                   	pop    %ebp
80104226:	c3                   	ret    
    return -1;
80104227:	c7 85 dc fb ff ff ff 	movl   $0xffffffff,-0x424(%ebp)
8010422e:	ff ff ff 
80104231:	eb e6                	jmp    80104219 <fork+0x1c9>
    kfree(np->kstack);
80104233:	8b 9d e4 fb ff ff    	mov    -0x41c(%ebp),%ebx
80104239:	83 ec 0c             	sub    $0xc,%esp
8010423c:	ff 73 08             	pushl  0x8(%ebx)
8010423f:	e8 dc e4 ff ff       	call   80102720 <kfree>
    np->kstack = 0;
80104244:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
8010424b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104252:	83 c4 10             	add    $0x10,%esp
80104255:	c7 85 dc fb ff ff ff 	movl   $0xffffffff,-0x424(%ebp)
8010425c:	ff ff ff 
8010425f:	eb b8                	jmp    80104219 <fork+0x1c9>
80104261:	eb 0d                	jmp    80104270 <scheduler>
80104263:	90                   	nop
80104264:	90                   	nop
80104265:	90                   	nop
80104266:	90                   	nop
80104267:	90                   	nop
80104268:	90                   	nop
80104269:	90                   	nop
8010426a:	90                   	nop
8010426b:	90                   	nop
8010426c:	90                   	nop
8010426d:	90                   	nop
8010426e:	90                   	nop
8010426f:	90                   	nop

80104270 <scheduler>:
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	57                   	push   %edi
80104274:	56                   	push   %esi
80104275:	53                   	push   %ebx
80104276:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104279:	e8 72 fb ff ff       	call   80103df0 <mycpu>
8010427e:	8d 78 04             	lea    0x4(%eax),%edi
80104281:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104283:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010428a:	00 00 00 
8010428d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104290:	fb                   	sti    
    acquire(&ptable.lock);
80104291:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104294:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
    acquire(&ptable.lock);
80104299:	68 40 cd 14 80       	push   $0x8014cd40
8010429e:	e8 cd 09 00 00       	call   80104c70 <acquire>
801042a3:	83 c4 10             	add    $0x10,%esp
801042a6:	8d 76 00             	lea    0x0(%esi),%esi
801042a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
801042b0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801042b4:	75 33                	jne    801042e9 <scheduler+0x79>
      switchuvm(p);
801042b6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801042b9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801042bf:	53                   	push   %ebx
801042c0:	e8 4b 2f 00 00       	call   80107210 <switchuvm>
      swtch(&(c->scheduler), p->context);
801042c5:	58                   	pop    %eax
801042c6:	5a                   	pop    %edx
801042c7:	ff 73 1c             	pushl  0x1c(%ebx)
801042ca:	57                   	push   %edi
      p->state = RUNNING;
801042cb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801042d2:	e8 e4 0c 00 00       	call   80104fbb <swtch>
      switchkvm();
801042d7:	e8 14 2f 00 00       	call   801071f0 <switchkvm>
      c->proc = 0;
801042dc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801042e3:	00 00 00 
801042e6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e9:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
801042ef:	81 fb 74 81 15 80    	cmp    $0x80158174,%ebx
801042f5:	72 b9                	jb     801042b0 <scheduler+0x40>
    release(&ptable.lock);
801042f7:	83 ec 0c             	sub    $0xc,%esp
801042fa:	68 40 cd 14 80       	push   $0x8014cd40
801042ff:	e8 2c 0a 00 00       	call   80104d30 <release>
    sti();
80104304:	83 c4 10             	add    $0x10,%esp
80104307:	eb 87                	jmp    80104290 <scheduler+0x20>
80104309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104310 <sched>:
{
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
  pushcli();
80104315:	e8 86 08 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
8010431a:	e8 d1 fa ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010431f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104325:	e8 b6 08 00 00       	call   80104be0 <popcli>
  if(!holding(&ptable.lock))
8010432a:	83 ec 0c             	sub    $0xc,%esp
8010432d:	68 40 cd 14 80       	push   $0x8014cd40
80104332:	e8 09 09 00 00       	call   80104c40 <holding>
80104337:	83 c4 10             	add    $0x10,%esp
8010433a:	85 c0                	test   %eax,%eax
8010433c:	74 4f                	je     8010438d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010433e:	e8 ad fa ff ff       	call   80103df0 <mycpu>
80104343:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010434a:	75 68                	jne    801043b4 <sched+0xa4>
  if(p->state == RUNNING)
8010434c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104350:	74 55                	je     801043a7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104352:	9c                   	pushf  
80104353:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104354:	f6 c4 02             	test   $0x2,%ah
80104357:	75 41                	jne    8010439a <sched+0x8a>
  intena = mycpu()->intena;
80104359:	e8 92 fa ff ff       	call   80103df0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010435e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104361:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104367:	e8 84 fa ff ff       	call   80103df0 <mycpu>
8010436c:	83 ec 08             	sub    $0x8,%esp
8010436f:	ff 70 04             	pushl  0x4(%eax)
80104372:	53                   	push   %ebx
80104373:	e8 43 0c 00 00       	call   80104fbb <swtch>
  mycpu()->intena = intena;
80104378:	e8 73 fa ff ff       	call   80103df0 <mycpu>
}
8010437d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104380:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104386:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104389:	5b                   	pop    %ebx
8010438a:	5e                   	pop    %esi
8010438b:	5d                   	pop    %ebp
8010438c:	c3                   	ret    
    panic("sched ptable.lock");
8010438d:	83 ec 0c             	sub    $0xc,%esp
80104390:	68 5b 8b 10 80       	push   $0x80108b5b
80104395:	e8 f6 bf ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010439a:	83 ec 0c             	sub    $0xc,%esp
8010439d:	68 87 8b 10 80       	push   $0x80108b87
801043a2:	e8 e9 bf ff ff       	call   80100390 <panic>
    panic("sched running");
801043a7:	83 ec 0c             	sub    $0xc,%esp
801043aa:	68 79 8b 10 80       	push   $0x80108b79
801043af:	e8 dc bf ff ff       	call   80100390 <panic>
    panic("sched locks");
801043b4:	83 ec 0c             	sub    $0xc,%esp
801043b7:	68 6d 8b 10 80       	push   $0x80108b6d
801043bc:	e8 cf bf ff ff       	call   80100390 <panic>
801043c1:	eb 0d                	jmp    801043d0 <exit>
801043c3:	90                   	nop
801043c4:	90                   	nop
801043c5:	90                   	nop
801043c6:	90                   	nop
801043c7:	90                   	nop
801043c8:	90                   	nop
801043c9:	90                   	nop
801043ca:	90                   	nop
801043cb:	90                   	nop
801043cc:	90                   	nop
801043cd:	90                   	nop
801043ce:	90                   	nop
801043cf:	90                   	nop

801043d0 <exit>:
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	56                   	push   %esi
801043d5:	53                   	push   %ebx
801043d6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801043d9:	e8 c2 07 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
801043de:	e8 0d fa ff ff       	call   80103df0 <mycpu>
  p = c->proc;
801043e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043e9:	e8 f2 07 00 00       	call   80104be0 <popcli>
  if(curproc == initproc)
801043ee:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
801043f4:	8d 5e 28             	lea    0x28(%esi),%ebx
801043f7:	8d 7e 68             	lea    0x68(%esi),%edi
801043fa:	0f 84 1e 01 00 00    	je     8010451e <exit+0x14e>
    if(curproc->ofile[fd]){
80104400:	8b 03                	mov    (%ebx),%eax
80104402:	85 c0                	test   %eax,%eax
80104404:	74 12                	je     80104418 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104406:	83 ec 0c             	sub    $0xc,%esp
80104409:	50                   	push   %eax
8010440a:	e8 b1 ca ff ff       	call   80100ec0 <fileclose>
      curproc->ofile[fd] = 0;
8010440f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104415:	83 c4 10             	add    $0x10,%esp
80104418:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
8010441b:	39 fb                	cmp    %edi,%ebx
8010441d:	75 e1                	jne    80104400 <exit+0x30>
  if(removeSwapFile(curproc) != 0){
8010441f:	83 ec 0c             	sub    $0xc,%esp
80104422:	56                   	push   %esi
80104423:	e8 08 dc ff ff       	call   80102030 <removeSwapFile>
80104428:	83 c4 10             	add    $0x10,%esp
8010442b:	85 c0                	test   %eax,%eax
8010442d:	0f 85 c5 00 00 00    	jne    801044f8 <exit+0x128>
  begin_op();
80104433:	e8 78 ed ff ff       	call   801031b0 <begin_op>
  iput(curproc->cwd);
80104438:	83 ec 0c             	sub    $0xc,%esp
8010443b:	ff 76 68             	pushl  0x68(%esi)
8010443e:	e8 ed d3 ff ff       	call   80101830 <iput>
  end_op();
80104443:	e8 d8 ed ff ff       	call   80103220 <end_op>
  curproc->cwd = 0;
80104448:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010444f:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104456:	e8 15 08 00 00       	call   80104c70 <acquire>
  wakeup1(curproc->parent);
8010445b:	8b 56 14             	mov    0x14(%esi),%edx
8010445e:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104461:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104466:	eb 14                	jmp    8010447c <exit+0xac>
80104468:	90                   	nop
80104469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104470:	05 d0 02 00 00       	add    $0x2d0,%eax
80104475:	3d 74 81 15 80       	cmp    $0x80158174,%eax
8010447a:	73 1e                	jae    8010449a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010447c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104480:	75 ee                	jne    80104470 <exit+0xa0>
80104482:	3b 50 20             	cmp    0x20(%eax),%edx
80104485:	75 e9                	jne    80104470 <exit+0xa0>
      p->state = RUNNABLE;
80104487:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010448e:	05 d0 02 00 00       	add    $0x2d0,%eax
80104493:	3d 74 81 15 80       	cmp    $0x80158174,%eax
80104498:	72 e2                	jb     8010447c <exit+0xac>
      p->parent = initproc;
8010449a:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a0:	ba 74 cd 14 80       	mov    $0x8014cd74,%edx
801044a5:	eb 17                	jmp    801044be <exit+0xee>
801044a7:	89 f6                	mov    %esi,%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801044b0:	81 c2 d0 02 00 00    	add    $0x2d0,%edx
801044b6:	81 fa 74 81 15 80    	cmp    $0x80158174,%edx
801044bc:	73 47                	jae    80104505 <exit+0x135>
    if(p->parent == curproc){
801044be:	39 72 14             	cmp    %esi,0x14(%edx)
801044c1:	75 ed                	jne    801044b0 <exit+0xe0>
      if(p->state == ZOMBIE)
801044c3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801044c7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801044ca:	75 e4                	jne    801044b0 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044cc:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801044d1:	eb 11                	jmp    801044e4 <exit+0x114>
801044d3:	90                   	nop
801044d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044d8:	05 d0 02 00 00       	add    $0x2d0,%eax
801044dd:	3d 74 81 15 80       	cmp    $0x80158174,%eax
801044e2:	73 cc                	jae    801044b0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
801044e4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044e8:	75 ee                	jne    801044d8 <exit+0x108>
801044ea:	3b 48 20             	cmp    0x20(%eax),%ecx
801044ed:	75 e9                	jne    801044d8 <exit+0x108>
      p->state = RUNNABLE;
801044ef:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801044f6:	eb e0                	jmp    801044d8 <exit+0x108>
    panic("exit: cant remove swapfile");
801044f8:	83 ec 0c             	sub    $0xc,%esp
801044fb:	68 a8 8b 10 80       	push   $0x80108ba8
80104500:	e8 8b be ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
80104505:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010450c:	e8 ff fd ff ff       	call   80104310 <sched>
  panic("zombie exit");
80104511:	83 ec 0c             	sub    $0xc,%esp
80104514:	68 c3 8b 10 80       	push   $0x80108bc3
80104519:	e8 72 be ff ff       	call   80100390 <panic>
    panic("init exiting");
8010451e:	83 ec 0c             	sub    $0xc,%esp
80104521:	68 9b 8b 10 80       	push   $0x80108b9b
80104526:	e8 65 be ff ff       	call   80100390 <panic>
8010452b:	90                   	nop
8010452c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104530 <yield>:
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104537:	68 40 cd 14 80       	push   $0x8014cd40
8010453c:	e8 2f 07 00 00       	call   80104c70 <acquire>
  pushcli();
80104541:	e8 5a 06 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
80104546:	e8 a5 f8 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010454b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104551:	e8 8a 06 00 00       	call   80104be0 <popcli>
  myproc()->state = RUNNABLE;
80104556:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010455d:	e8 ae fd ff ff       	call   80104310 <sched>
  release(&ptable.lock);
80104562:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104569:	e8 c2 07 00 00       	call   80104d30 <release>
}
8010456e:	83 c4 10             	add    $0x10,%esp
80104571:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104574:	c9                   	leave  
80104575:	c3                   	ret    
80104576:	8d 76 00             	lea    0x0(%esi),%esi
80104579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104580 <sleep>:
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	57                   	push   %edi
80104584:	56                   	push   %esi
80104585:	53                   	push   %ebx
80104586:	83 ec 0c             	sub    $0xc,%esp
80104589:	8b 7d 08             	mov    0x8(%ebp),%edi
8010458c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010458f:	e8 0c 06 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
80104594:	e8 57 f8 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80104599:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010459f:	e8 3c 06 00 00       	call   80104be0 <popcli>
  if(p == 0)
801045a4:	85 db                	test   %ebx,%ebx
801045a6:	0f 84 87 00 00 00    	je     80104633 <sleep+0xb3>
  if(lk == 0)
801045ac:	85 f6                	test   %esi,%esi
801045ae:	74 76                	je     80104626 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801045b0:	81 fe 40 cd 14 80    	cmp    $0x8014cd40,%esi
801045b6:	74 50                	je     80104608 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801045b8:	83 ec 0c             	sub    $0xc,%esp
801045bb:	68 40 cd 14 80       	push   $0x8014cd40
801045c0:	e8 ab 06 00 00       	call   80104c70 <acquire>
    release(lk);
801045c5:	89 34 24             	mov    %esi,(%esp)
801045c8:	e8 63 07 00 00       	call   80104d30 <release>
  p->chan = chan;
801045cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045d7:	e8 34 fd ff ff       	call   80104310 <sched>
  p->chan = 0;
801045dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045e3:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801045ea:	e8 41 07 00 00       	call   80104d30 <release>
    acquire(lk);
801045ef:	89 75 08             	mov    %esi,0x8(%ebp)
801045f2:	83 c4 10             	add    $0x10,%esp
}
801045f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045f8:	5b                   	pop    %ebx
801045f9:	5e                   	pop    %esi
801045fa:	5f                   	pop    %edi
801045fb:	5d                   	pop    %ebp
    acquire(lk);
801045fc:	e9 6f 06 00 00       	jmp    80104c70 <acquire>
80104601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104608:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010460b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104612:	e8 f9 fc ff ff       	call   80104310 <sched>
  p->chan = 0;
80104617:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010461e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5f                   	pop    %edi
80104624:	5d                   	pop    %ebp
80104625:	c3                   	ret    
    panic("sleep without lk");
80104626:	83 ec 0c             	sub    $0xc,%esp
80104629:	68 d5 8b 10 80       	push   $0x80108bd5
8010462e:	e8 5d bd ff ff       	call   80100390 <panic>
    panic("sleep");
80104633:	83 ec 0c             	sub    $0xc,%esp
80104636:	68 cf 8b 10 80       	push   $0x80108bcf
8010463b:	e8 50 bd ff ff       	call   80100390 <panic>

80104640 <wait>:
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
  pushcli();
80104645:	e8 56 05 00 00       	call   80104ba0 <pushcli>
  c = mycpu();
8010464a:	e8 a1 f7 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010464f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104655:	e8 86 05 00 00       	call   80104be0 <popcli>
  acquire(&ptable.lock);
8010465a:	83 ec 0c             	sub    $0xc,%esp
8010465d:	68 40 cd 14 80       	push   $0x8014cd40
80104662:	e8 09 06 00 00       	call   80104c70 <acquire>
80104667:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010466a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010466c:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
80104671:	eb 13                	jmp    80104686 <wait+0x46>
80104673:	90                   	nop
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104678:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
8010467e:	81 fb 74 81 15 80    	cmp    $0x80158174,%ebx
80104684:	73 1e                	jae    801046a4 <wait+0x64>
      if(p->parent != curproc)
80104686:	39 73 14             	cmp    %esi,0x14(%ebx)
80104689:	75 ed                	jne    80104678 <wait+0x38>
      if(p->state == ZOMBIE){
8010468b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010468f:	74 37                	je     801046c8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104691:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
      havekids = 1;
80104697:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010469c:	81 fb 74 81 15 80    	cmp    $0x80158174,%ebx
801046a2:	72 e2                	jb     80104686 <wait+0x46>
    if(!havekids || curproc->killed){
801046a4:	85 c0                	test   %eax,%eax
801046a6:	74 7d                	je     80104725 <wait+0xe5>
801046a8:	8b 46 24             	mov    0x24(%esi),%eax
801046ab:	85 c0                	test   %eax,%eax
801046ad:	75 76                	jne    80104725 <wait+0xe5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801046af:	83 ec 08             	sub    $0x8,%esp
801046b2:	68 40 cd 14 80       	push   $0x8014cd40
801046b7:	56                   	push   %esi
801046b8:	e8 c3 fe ff ff       	call   80104580 <sleep>
    havekids = 0;
801046bd:	83 c4 10             	add    $0x10,%esp
801046c0:	eb a8                	jmp    8010466a <wait+0x2a>
801046c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801046c8:	83 ec 0c             	sub    $0xc,%esp
801046cb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801046ce:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801046d1:	e8 4a e0 ff ff       	call   80102720 <kfree>
        freevm(p->pgdir);
801046d6:	5a                   	pop    %edx
801046d7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801046da:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801046e1:	e8 2a 2f 00 00       	call   80107610 <freevm>
        release(&ptable.lock);
801046e6:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
        p->pid = 0;
801046ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801046f4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801046fb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801046ff:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->pgdir = 0;
80104706:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        p->state = UNUSED;
8010470d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104714:	e8 17 06 00 00       	call   80104d30 <release>
        return pid;
80104719:	83 c4 10             	add    $0x10,%esp
}
8010471c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010471f:	89 f0                	mov    %esi,%eax
80104721:	5b                   	pop    %ebx
80104722:	5e                   	pop    %esi
80104723:	5d                   	pop    %ebp
80104724:	c3                   	ret    
      release(&ptable.lock);
80104725:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104728:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010472d:	68 40 cd 14 80       	push   $0x8014cd40
80104732:	e8 f9 05 00 00       	call   80104d30 <release>
      return -1;
80104737:	83 c4 10             	add    $0x10,%esp
8010473a:	eb e0                	jmp    8010471c <wait+0xdc>
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	53                   	push   %ebx
80104744:	83 ec 10             	sub    $0x10,%esp
80104747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010474a:	68 40 cd 14 80       	push   $0x8014cd40
8010474f:	e8 1c 05 00 00       	call   80104c70 <acquire>
80104754:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104757:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
8010475c:	eb 0e                	jmp    8010476c <wakeup+0x2c>
8010475e:	66 90                	xchg   %ax,%ax
80104760:	05 d0 02 00 00       	add    $0x2d0,%eax
80104765:	3d 74 81 15 80       	cmp    $0x80158174,%eax
8010476a:	73 1e                	jae    8010478a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010476c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104770:	75 ee                	jne    80104760 <wakeup+0x20>
80104772:	3b 58 20             	cmp    0x20(%eax),%ebx
80104775:	75 e9                	jne    80104760 <wakeup+0x20>
      p->state = RUNNABLE;
80104777:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010477e:	05 d0 02 00 00       	add    $0x2d0,%eax
80104783:	3d 74 81 15 80       	cmp    $0x80158174,%eax
80104788:	72 e2                	jb     8010476c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010478a:	c7 45 08 40 cd 14 80 	movl   $0x8014cd40,0x8(%ebp)
}
80104791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104794:	c9                   	leave  
  release(&ptable.lock);
80104795:	e9 96 05 00 00       	jmp    80104d30 <release>
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 10             	sub    $0x10,%esp
801047a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801047aa:	68 40 cd 14 80       	push   $0x8014cd40
801047af:	e8 bc 04 00 00       	call   80104c70 <acquire>
801047b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b7:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801047bc:	eb 0e                	jmp    801047cc <kill+0x2c>
801047be:	66 90                	xchg   %ax,%ax
801047c0:	05 d0 02 00 00       	add    $0x2d0,%eax
801047c5:	3d 74 81 15 80       	cmp    $0x80158174,%eax
801047ca:	73 34                	jae    80104800 <kill+0x60>
    if(p->pid == pid){
801047cc:	39 58 10             	cmp    %ebx,0x10(%eax)
801047cf:	75 ef                	jne    801047c0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801047d1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801047d5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801047dc:	75 07                	jne    801047e5 <kill+0x45>
        p->state = RUNNABLE;
801047de:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801047e5:	83 ec 0c             	sub    $0xc,%esp
801047e8:	68 40 cd 14 80       	push   $0x8014cd40
801047ed:	e8 3e 05 00 00       	call   80104d30 <release>
      return 0;
801047f2:	83 c4 10             	add    $0x10,%esp
801047f5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801047f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047fa:	c9                   	leave  
801047fb:	c3                   	ret    
801047fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	68 40 cd 14 80       	push   $0x8014cd40
80104808:	e8 23 05 00 00       	call   80104d30 <release>
  return -1;
8010480d:	83 c4 10             	add    $0x10,%esp
80104810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104815:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104818:	c9                   	leave  
80104819:	c3                   	ret    
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104820 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	57                   	push   %edi
80104824:	56                   	push   %esi
80104825:	53                   	push   %ebx
80104826:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104829:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
8010482e:	83 ec 3c             	sub    $0x3c,%esp
80104831:	eb 27                	jmp    8010485a <procdump+0x3a>
80104833:	90                   	nop
80104834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104838:	83 ec 0c             	sub    $0xc,%esp
8010483b:	68 32 91 10 80       	push   $0x80109132
80104840:	e8 1b be ff ff       	call   80100660 <cprintf>
80104845:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104848:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
8010484e:	81 fb 74 81 15 80    	cmp    $0x80158174,%ebx
80104854:	0f 83 86 00 00 00    	jae    801048e0 <procdump+0xc0>
    if(p->state == UNUSED)
8010485a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010485d:	85 c0                	test   %eax,%eax
8010485f:	74 e7                	je     80104848 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104861:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104864:	ba e6 8b 10 80       	mov    $0x80108be6,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104869:	77 11                	ja     8010487c <procdump+0x5c>
8010486b:	8b 14 85 80 8c 10 80 	mov    -0x7fef7380(,%eax,4),%edx
      state = "???";
80104872:	b8 e6 8b 10 80       	mov    $0x80108be6,%eax
80104877:	85 d2                	test   %edx,%edx
80104879:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010487c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010487f:	50                   	push   %eax
80104880:	52                   	push   %edx
80104881:	ff 73 10             	pushl  0x10(%ebx)
80104884:	68 ea 8b 10 80       	push   $0x80108bea
80104889:	e8 d2 bd ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010488e:	83 c4 10             	add    $0x10,%esp
80104891:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104895:	75 a1                	jne    80104838 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104897:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010489a:	83 ec 08             	sub    $0x8,%esp
8010489d:	8d 7d c0             	lea    -0x40(%ebp),%edi
801048a0:	50                   	push   %eax
801048a1:	8b 43 1c             	mov    0x1c(%ebx),%eax
801048a4:	8b 40 0c             	mov    0xc(%eax),%eax
801048a7:	83 c0 08             	add    $0x8,%eax
801048aa:	50                   	push   %eax
801048ab:	e8 a0 02 00 00       	call   80104b50 <getcallerpcs>
801048b0:	83 c4 10             	add    $0x10,%esp
801048b3:	90                   	nop
801048b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801048b8:	8b 17                	mov    (%edi),%edx
801048ba:	85 d2                	test   %edx,%edx
801048bc:	0f 84 76 ff ff ff    	je     80104838 <procdump+0x18>
        cprintf(" %p", pc[i]);
801048c2:	83 ec 08             	sub    $0x8,%esp
801048c5:	83 c7 04             	add    $0x4,%edi
801048c8:	52                   	push   %edx
801048c9:	68 81 85 10 80       	push   $0x80108581
801048ce:	e8 8d bd ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801048d3:	83 c4 10             	add    $0x10,%esp
801048d6:	39 fe                	cmp    %edi,%esi
801048d8:	75 de                	jne    801048b8 <procdump+0x98>
801048da:	e9 59 ff ff ff       	jmp    80104838 <procdump+0x18>
801048df:	90                   	nop
  }
}
801048e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048e3:	5b                   	pop    %ebx
801048e4:	5e                   	pop    %esi
801048e5:	5f                   	pop    %edi
801048e6:	5d                   	pop    %ebp
801048e7:	c3                   	ret    
801048e8:	90                   	nop
801048e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048f0 <nfuaTickUpdate>:

//update aging mechanisem of nfua algo each tick form trap.c
void
nfuaTickUpdate(){
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	57                   	push   %edi
801048f4:	56                   	push   %esi
801048f5:	53                   	push   %ebx
  struct proc *p;
  pte_t *pte,*pde,*pgtab;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048f6:	bf 74 cd 14 80       	mov    $0x8014cd74,%edi
nfuaTickUpdate(){
801048fb:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
801048fe:	68 40 cd 14 80       	push   $0x8014cd40
80104903:	e8 68 03 00 00       	call   80104c70 <acquire>
80104908:	83 c4 10             	add    $0x10,%esp
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid<=2)
80104910:	83 7f 10 02          	cmpl   $0x2,0x10(%edi)
80104914:	0f 8e 86 00 00 00    	jle    801049a0 <nfuaTickUpdate+0xb0>
      continue;
    if(!((p->state == RUNNING) || (p->state == RUNNABLE) || (p->state == SLEEPING)))
8010491a:	8b 47 0c             	mov    0xc(%edi),%eax
8010491d:	83 e8 02             	sub    $0x2,%eax
80104920:	83 f8 02             	cmp    $0x2,%eax
80104923:	77 7b                	ja     801049a0 <nfuaTickUpdate+0xb0>
80104925:	8d b7 98 01 00 00    	lea    0x198(%edi),%esi
8010492b:	8d 9f d8 02 00 00    	lea    0x2d8(%edi),%ebx
80104931:	eb 0c                	jmp    8010493f <nfuaTickUpdate+0x4f>
80104933:	90                   	nop
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104938:	83 c6 14             	add    $0x14,%esi
      continue;

    int i;
    for(i = 0; i < MAX_PSYC_PAGES; i++){
8010493b:	39 f3                	cmp    %esi,%ebx
8010493d:	74 61                	je     801049a0 <nfuaTickUpdate+0xb0>
      if(p->physicalPGs[i].va == (char*)0xffffffff)
8010493f:	8b 46 f8             	mov    -0x8(%esi),%eax
80104942:	83 f8 ff             	cmp    $0xffffffff,%eax
80104945:	74 f1                	je     80104938 <nfuaTickUpdate+0x48>
        continue;
      
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
      if(*pde & PTE_P){
80104947:	8b 57 04             	mov    0x4(%edi),%edx
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
8010494a:	89 c1                	mov    %eax,%ecx
8010494c:	c1 e9 16             	shr    $0x16,%ecx
      if(*pde & PTE_P){
8010494f:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80104952:	f6 c2 01             	test   $0x1,%dl
80104955:	74 79                	je     801049d0 <nfuaTickUpdate+0xe0>
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104957:	c1 e8 0a             	shr    $0xa,%eax
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010495a:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104960:	25 fc 0f 00 00       	and    $0xffc,%eax
80104965:	8d 94 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edx
      } else {
        cprintf("nfuaUpdate: pte is not PTE_P\n");
        continue;
      }
      if(!pte){
8010496c:	85 d2                	test   %edx,%edx
8010496e:	74 78                	je     801049e8 <nfuaTickUpdate+0xf8>
        cprintf("nfuaUpdate : !pte\n");
        continue;
      }

      p->physicalPGs[i].age = ((p->physicalPGs[i].age) >> 1); // shift right
80104970:	8b 06                	mov    (%esi),%eax
80104972:	d1 e8                	shr    %eax
80104974:	89 06                	mov    %eax,(%esi)
      //cprintf("shifted: %x\n",p->physicalPGs[i].age);

      if(*pte & PTE_A){                                       // set MSB if accessed
80104976:	f6 02 20             	testb  $0x20,(%edx)
80104979:	74 bd                	je     80104938 <nfuaTickUpdate+0x48>
        uint newBit = 1 << ((sizeof(uint)*8) - 1);
        p->physicalPGs[i].age |= newBit;
        cprintf("age: %x\n",p->physicalPGs[i].age);
8010497b:	83 ec 08             	sub    $0x8,%esp
        p->physicalPGs[i].age |= newBit;
8010497e:	0d 00 00 00 80       	or     $0x80000000,%eax
80104983:	83 c6 14             	add    $0x14,%esi
80104986:	89 46 ec             	mov    %eax,-0x14(%esi)
        cprintf("age: %x\n",p->physicalPGs[i].age);
80104989:	50                   	push   %eax
8010498a:	68 24 8c 10 80       	push   $0x80108c24
8010498f:	e8 cc bc ff ff       	call   80100660 <cprintf>
80104994:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104997:	39 f3                	cmp    %esi,%ebx
80104999:	75 a4                	jne    8010493f <nfuaTickUpdate+0x4f>
8010499b:	90                   	nop
8010499c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a0:	81 c7 d0 02 00 00    	add    $0x2d0,%edi
801049a6:	81 ff 74 81 15 80    	cmp    $0x80158174,%edi
801049ac:	0f 82 5e ff ff ff    	jb     80104910 <nfuaTickUpdate+0x20>

      }
    }
  }
  release(&ptable.lock);
801049b2:	83 ec 0c             	sub    $0xc,%esp
801049b5:	68 40 cd 14 80       	push   $0x8014cd40
801049ba:	e8 71 03 00 00       	call   80104d30 <release>
801049bf:	83 c4 10             	add    $0x10,%esp
801049c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049c5:	5b                   	pop    %ebx
801049c6:	5e                   	pop    %esi
801049c7:	5f                   	pop    %edi
801049c8:	5d                   	pop    %ebp
801049c9:	c3                   	ret    
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate: pte is not PTE_P\n");
801049d0:	83 ec 0c             	sub    $0xc,%esp
801049d3:	68 f3 8b 10 80       	push   $0x80108bf3
801049d8:	e8 83 bc ff ff       	call   80100660 <cprintf>
        continue;
801049dd:	83 c4 10             	add    $0x10,%esp
801049e0:	e9 53 ff ff ff       	jmp    80104938 <nfuaTickUpdate+0x48>
801049e5:	8d 76 00             	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate : !pte\n");
801049e8:	83 ec 0c             	sub    $0xc,%esp
801049eb:	68 11 8c 10 80       	push   $0x80108c11
801049f0:	e8 6b bc ff ff       	call   80100660 <cprintf>
        continue;
801049f5:	83 c4 10             	add    $0x10,%esp
801049f8:	e9 3b ff ff ff       	jmp    80104938 <nfuaTickUpdate+0x48>
801049fd:	66 90                	xchg   %ax,%ax
801049ff:	90                   	nop

80104a00 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	53                   	push   %ebx
80104a04:	83 ec 0c             	sub    $0xc,%esp
80104a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104a0a:	68 98 8c 10 80       	push   $0x80108c98
80104a0f:	8d 43 04             	lea    0x4(%ebx),%eax
80104a12:	50                   	push   %eax
80104a13:	e8 18 01 00 00       	call   80104b30 <initlock>
  lk->name = name;
80104a18:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104a1b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a21:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a24:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a2b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a31:	c9                   	leave  
80104a32:	c3                   	ret    
80104a33:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a40 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	56                   	push   %esi
80104a44:	53                   	push   %ebx
80104a45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a48:	83 ec 0c             	sub    $0xc,%esp
80104a4b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a4e:	56                   	push   %esi
80104a4f:	e8 1c 02 00 00       	call   80104c70 <acquire>
  while (lk->locked) {
80104a54:	8b 13                	mov    (%ebx),%edx
80104a56:	83 c4 10             	add    $0x10,%esp
80104a59:	85 d2                	test   %edx,%edx
80104a5b:	74 16                	je     80104a73 <acquiresleep+0x33>
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104a60:	83 ec 08             	sub    $0x8,%esp
80104a63:	56                   	push   %esi
80104a64:	53                   	push   %ebx
80104a65:	e8 16 fb ff ff       	call   80104580 <sleep>
  while (lk->locked) {
80104a6a:	8b 03                	mov    (%ebx),%eax
80104a6c:	83 c4 10             	add    $0x10,%esp
80104a6f:	85 c0                	test   %eax,%eax
80104a71:	75 ed                	jne    80104a60 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104a73:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a79:	e8 12 f4 ff ff       	call   80103e90 <myproc>
80104a7e:	8b 40 10             	mov    0x10(%eax),%eax
80104a81:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104a84:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104a87:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a8a:	5b                   	pop    %ebx
80104a8b:	5e                   	pop    %esi
80104a8c:	5d                   	pop    %ebp
  release(&lk->lk);
80104a8d:	e9 9e 02 00 00       	jmp    80104d30 <release>
80104a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
80104aa5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104aa8:	83 ec 0c             	sub    $0xc,%esp
80104aab:	8d 73 04             	lea    0x4(%ebx),%esi
80104aae:	56                   	push   %esi
80104aaf:	e8 bc 01 00 00       	call   80104c70 <acquire>
  lk->locked = 0;
80104ab4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104aba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ac1:	89 1c 24             	mov    %ebx,(%esp)
80104ac4:	e8 77 fc ff ff       	call   80104740 <wakeup>
  release(&lk->lk);
80104ac9:	89 75 08             	mov    %esi,0x8(%ebp)
80104acc:	83 c4 10             	add    $0x10,%esp
}
80104acf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ad2:	5b                   	pop    %ebx
80104ad3:	5e                   	pop    %esi
80104ad4:	5d                   	pop    %ebp
  release(&lk->lk);
80104ad5:	e9 56 02 00 00       	jmp    80104d30 <release>
80104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ae0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	57                   	push   %edi
80104ae4:	56                   	push   %esi
80104ae5:	53                   	push   %ebx
80104ae6:	31 ff                	xor    %edi,%edi
80104ae8:	83 ec 18             	sub    $0x18,%esp
80104aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104aee:	8d 73 04             	lea    0x4(%ebx),%esi
80104af1:	56                   	push   %esi
80104af2:	e8 79 01 00 00       	call   80104c70 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104af7:	8b 03                	mov    (%ebx),%eax
80104af9:	83 c4 10             	add    $0x10,%esp
80104afc:	85 c0                	test   %eax,%eax
80104afe:	74 13                	je     80104b13 <holdingsleep+0x33>
80104b00:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104b03:	e8 88 f3 ff ff       	call   80103e90 <myproc>
80104b08:	39 58 10             	cmp    %ebx,0x10(%eax)
80104b0b:	0f 94 c0             	sete   %al
80104b0e:	0f b6 c0             	movzbl %al,%eax
80104b11:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104b13:	83 ec 0c             	sub    $0xc,%esp
80104b16:	56                   	push   %esi
80104b17:	e8 14 02 00 00       	call   80104d30 <release>
  return r;
}
80104b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b1f:	89 f8                	mov    %edi,%eax
80104b21:	5b                   	pop    %ebx
80104b22:	5e                   	pop    %esi
80104b23:	5f                   	pop    %edi
80104b24:	5d                   	pop    %ebp
80104b25:	c3                   	ret    
80104b26:	66 90                	xchg   %ax,%ax
80104b28:	66 90                	xchg   %ax,%ax
80104b2a:	66 90                	xchg   %ax,%ax
80104b2c:	66 90                	xchg   %ax,%ax
80104b2e:	66 90                	xchg   %ax,%ax

80104b30 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b36:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b39:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b3f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b42:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b49:	5d                   	pop    %ebp
80104b4a:	c3                   	ret    
80104b4b:	90                   	nop
80104b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b50 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b50:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b51:	31 d2                	xor    %edx,%edx
{
80104b53:	89 e5                	mov    %esp,%ebp
80104b55:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b56:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b59:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b5c:	83 e8 08             	sub    $0x8,%eax
80104b5f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b60:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b66:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b6c:	77 1a                	ja     80104b88 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b6e:	8b 58 04             	mov    0x4(%eax),%ebx
80104b71:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b74:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b77:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b79:	83 fa 0a             	cmp    $0xa,%edx
80104b7c:	75 e2                	jne    80104b60 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b7e:	5b                   	pop    %ebx
80104b7f:	5d                   	pop    %ebp
80104b80:	c3                   	ret    
80104b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b88:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b8b:	83 c1 28             	add    $0x28,%ecx
80104b8e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104b90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b96:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104b99:	39 c1                	cmp    %eax,%ecx
80104b9b:	75 f3                	jne    80104b90 <getcallerpcs+0x40>
}
80104b9d:	5b                   	pop    %ebx
80104b9e:	5d                   	pop    %ebp
80104b9f:	c3                   	ret    

80104ba0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	53                   	push   %ebx
80104ba4:	83 ec 04             	sub    $0x4,%esp
80104ba7:	9c                   	pushf  
80104ba8:	5b                   	pop    %ebx
  asm volatile("cli");
80104ba9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104baa:	e8 41 f2 ff ff       	call   80103df0 <mycpu>
80104baf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104bb5:	85 c0                	test   %eax,%eax
80104bb7:	75 11                	jne    80104bca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104bb9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104bbf:	e8 2c f2 ff ff       	call   80103df0 <mycpu>
80104bc4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104bca:	e8 21 f2 ff ff       	call   80103df0 <mycpu>
80104bcf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104bd6:	83 c4 04             	add    $0x4,%esp
80104bd9:	5b                   	pop    %ebx
80104bda:	5d                   	pop    %ebp
80104bdb:	c3                   	ret    
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104be0 <popcli>:

void
popcli(void)
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104be6:	9c                   	pushf  
80104be7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104be8:	f6 c4 02             	test   $0x2,%ah
80104beb:	75 35                	jne    80104c22 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104bed:	e8 fe f1 ff ff       	call   80103df0 <mycpu>
80104bf2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104bf9:	78 34                	js     80104c2f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104bfb:	e8 f0 f1 ff ff       	call   80103df0 <mycpu>
80104c00:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c06:	85 d2                	test   %edx,%edx
80104c08:	74 06                	je     80104c10 <popcli+0x30>
    sti();
}
80104c0a:	c9                   	leave  
80104c0b:	c3                   	ret    
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c10:	e8 db f1 ff ff       	call   80103df0 <mycpu>
80104c15:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c1b:	85 c0                	test   %eax,%eax
80104c1d:	74 eb                	je     80104c0a <popcli+0x2a>
  asm volatile("sti");
80104c1f:	fb                   	sti    
}
80104c20:	c9                   	leave  
80104c21:	c3                   	ret    
    panic("popcli - interruptible");
80104c22:	83 ec 0c             	sub    $0xc,%esp
80104c25:	68 a3 8c 10 80       	push   $0x80108ca3
80104c2a:	e8 61 b7 ff ff       	call   80100390 <panic>
    panic("popcli");
80104c2f:	83 ec 0c             	sub    $0xc,%esp
80104c32:	68 ba 8c 10 80       	push   $0x80108cba
80104c37:	e8 54 b7 ff ff       	call   80100390 <panic>
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c40 <holding>:
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	56                   	push   %esi
80104c44:	53                   	push   %ebx
80104c45:	8b 75 08             	mov    0x8(%ebp),%esi
80104c48:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c4a:	e8 51 ff ff ff       	call   80104ba0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c4f:	8b 06                	mov    (%esi),%eax
80104c51:	85 c0                	test   %eax,%eax
80104c53:	74 10                	je     80104c65 <holding+0x25>
80104c55:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c58:	e8 93 f1 ff ff       	call   80103df0 <mycpu>
80104c5d:	39 c3                	cmp    %eax,%ebx
80104c5f:	0f 94 c3             	sete   %bl
80104c62:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104c65:	e8 76 ff ff ff       	call   80104be0 <popcli>
}
80104c6a:	89 d8                	mov    %ebx,%eax
80104c6c:	5b                   	pop    %ebx
80104c6d:	5e                   	pop    %esi
80104c6e:	5d                   	pop    %ebp
80104c6f:	c3                   	ret    

80104c70 <acquire>:
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c75:	e8 26 ff ff ff       	call   80104ba0 <pushcli>
  if(holding(lk))
80104c7a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c7d:	83 ec 0c             	sub    $0xc,%esp
80104c80:	53                   	push   %ebx
80104c81:	e8 ba ff ff ff       	call   80104c40 <holding>
80104c86:	83 c4 10             	add    $0x10,%esp
80104c89:	85 c0                	test   %eax,%eax
80104c8b:	0f 85 83 00 00 00    	jne    80104d14 <acquire+0xa4>
80104c91:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104c93:	ba 01 00 00 00       	mov    $0x1,%edx
80104c98:	eb 09                	jmp    80104ca3 <acquire+0x33>
80104c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ca0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ca3:	89 d0                	mov    %edx,%eax
80104ca5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104ca8:	85 c0                	test   %eax,%eax
80104caa:	75 f4                	jne    80104ca0 <acquire+0x30>
  __sync_synchronize();
80104cac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104cb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cb4:	e8 37 f1 ff ff       	call   80103df0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104cb9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104cbc:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104cbf:	89 e8                	mov    %ebp,%eax
80104cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cc8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104cce:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104cd4:	77 1a                	ja     80104cf0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cd6:	8b 48 04             	mov    0x4(%eax),%ecx
80104cd9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104cdc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104cdf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ce1:	83 fe 0a             	cmp    $0xa,%esi
80104ce4:	75 e2                	jne    80104cc8 <acquire+0x58>
}
80104ce6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ce9:	5b                   	pop    %ebx
80104cea:	5e                   	pop    %esi
80104ceb:	5d                   	pop    %ebp
80104cec:	c3                   	ret    
80104ced:	8d 76 00             	lea    0x0(%esi),%esi
80104cf0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104cf3:	83 c2 28             	add    $0x28,%edx
80104cf6:	8d 76 00             	lea    0x0(%esi),%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104d00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d06:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104d09:	39 d0                	cmp    %edx,%eax
80104d0b:	75 f3                	jne    80104d00 <acquire+0x90>
}
80104d0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d10:	5b                   	pop    %ebx
80104d11:	5e                   	pop    %esi
80104d12:	5d                   	pop    %ebp
80104d13:	c3                   	ret    
    panic("acquire");
80104d14:	83 ec 0c             	sub    $0xc,%esp
80104d17:	68 c1 8c 10 80       	push   $0x80108cc1
80104d1c:	e8 6f b6 ff ff       	call   80100390 <panic>
80104d21:	eb 0d                	jmp    80104d30 <release>
80104d23:	90                   	nop
80104d24:	90                   	nop
80104d25:	90                   	nop
80104d26:	90                   	nop
80104d27:	90                   	nop
80104d28:	90                   	nop
80104d29:	90                   	nop
80104d2a:	90                   	nop
80104d2b:	90                   	nop
80104d2c:	90                   	nop
80104d2d:	90                   	nop
80104d2e:	90                   	nop
80104d2f:	90                   	nop

80104d30 <release>:
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	53                   	push   %ebx
80104d34:	83 ec 10             	sub    $0x10,%esp
80104d37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d3a:	53                   	push   %ebx
80104d3b:	e8 00 ff ff ff       	call   80104c40 <holding>
80104d40:	83 c4 10             	add    $0x10,%esp
80104d43:	85 c0                	test   %eax,%eax
80104d45:	74 22                	je     80104d69 <release+0x39>
  lk->pcs[0] = 0;
80104d47:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d4e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d55:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d5a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d63:	c9                   	leave  
  popcli();
80104d64:	e9 77 fe ff ff       	jmp    80104be0 <popcli>
    panic("release");
80104d69:	83 ec 0c             	sub    $0xc,%esp
80104d6c:	68 c9 8c 10 80       	push   $0x80108cc9
80104d71:	e8 1a b6 ff ff       	call   80100390 <panic>
80104d76:	66 90                	xchg   %ax,%ax
80104d78:	66 90                	xchg   %ax,%ax
80104d7a:	66 90                	xchg   %ax,%ax
80104d7c:	66 90                	xchg   %ax,%ax
80104d7e:	66 90                	xchg   %ax,%ax

80104d80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	53                   	push   %ebx
80104d85:	8b 55 08             	mov    0x8(%ebp),%edx
80104d88:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104d8b:	f6 c2 03             	test   $0x3,%dl
80104d8e:	75 05                	jne    80104d95 <memset+0x15>
80104d90:	f6 c1 03             	test   $0x3,%cl
80104d93:	74 13                	je     80104da8 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104d95:	89 d7                	mov    %edx,%edi
80104d97:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d9a:	fc                   	cld    
80104d9b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d9d:	5b                   	pop    %ebx
80104d9e:	89 d0                	mov    %edx,%eax
80104da0:	5f                   	pop    %edi
80104da1:	5d                   	pop    %ebp
80104da2:	c3                   	ret    
80104da3:	90                   	nop
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104da8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104dac:	c1 e9 02             	shr    $0x2,%ecx
80104daf:	89 f8                	mov    %edi,%eax
80104db1:	89 fb                	mov    %edi,%ebx
80104db3:	c1 e0 18             	shl    $0x18,%eax
80104db6:	c1 e3 10             	shl    $0x10,%ebx
80104db9:	09 d8                	or     %ebx,%eax
80104dbb:	09 f8                	or     %edi,%eax
80104dbd:	c1 e7 08             	shl    $0x8,%edi
80104dc0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104dc2:	89 d7                	mov    %edx,%edi
80104dc4:	fc                   	cld    
80104dc5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104dc7:	5b                   	pop    %ebx
80104dc8:	89 d0                	mov    %edx,%eax
80104dca:	5f                   	pop    %edi
80104dcb:	5d                   	pop    %ebp
80104dcc:	c3                   	ret    
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi

80104dd0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	57                   	push   %edi
80104dd4:	56                   	push   %esi
80104dd5:	53                   	push   %ebx
80104dd6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104dd9:	8b 75 08             	mov    0x8(%ebp),%esi
80104ddc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104ddf:	85 db                	test   %ebx,%ebx
80104de1:	74 29                	je     80104e0c <memcmp+0x3c>
    if(*s1 != *s2)
80104de3:	0f b6 16             	movzbl (%esi),%edx
80104de6:	0f b6 0f             	movzbl (%edi),%ecx
80104de9:	38 d1                	cmp    %dl,%cl
80104deb:	75 2b                	jne    80104e18 <memcmp+0x48>
80104ded:	b8 01 00 00 00       	mov    $0x1,%eax
80104df2:	eb 14                	jmp    80104e08 <memcmp+0x38>
80104df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104df8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104dfc:	83 c0 01             	add    $0x1,%eax
80104dff:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104e04:	38 ca                	cmp    %cl,%dl
80104e06:	75 10                	jne    80104e18 <memcmp+0x48>
  while(n-- > 0){
80104e08:	39 d8                	cmp    %ebx,%eax
80104e0a:	75 ec                	jne    80104df8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104e0c:	5b                   	pop    %ebx
  return 0;
80104e0d:	31 c0                	xor    %eax,%eax
}
80104e0f:	5e                   	pop    %esi
80104e10:	5f                   	pop    %edi
80104e11:	5d                   	pop    %ebp
80104e12:	c3                   	ret    
80104e13:	90                   	nop
80104e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104e18:	0f b6 c2             	movzbl %dl,%eax
}
80104e1b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104e1c:	29 c8                	sub    %ecx,%eax
}
80104e1e:	5e                   	pop    %esi
80104e1f:	5f                   	pop    %edi
80104e20:	5d                   	pop    %ebp
80104e21:	c3                   	ret    
80104e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e30 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
80104e35:	8b 45 08             	mov    0x8(%ebp),%eax
80104e38:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e3b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e3e:	39 c3                	cmp    %eax,%ebx
80104e40:	73 26                	jae    80104e68 <memmove+0x38>
80104e42:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104e45:	39 c8                	cmp    %ecx,%eax
80104e47:	73 1f                	jae    80104e68 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104e49:	85 f6                	test   %esi,%esi
80104e4b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104e4e:	74 0f                	je     80104e5f <memmove+0x2f>
      *--d = *--s;
80104e50:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e54:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104e57:	83 ea 01             	sub    $0x1,%edx
80104e5a:	83 fa ff             	cmp    $0xffffffff,%edx
80104e5d:	75 f1                	jne    80104e50 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e5f:	5b                   	pop    %ebx
80104e60:	5e                   	pop    %esi
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret    
80104e63:	90                   	nop
80104e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104e68:	31 d2                	xor    %edx,%edx
80104e6a:	85 f6                	test   %esi,%esi
80104e6c:	74 f1                	je     80104e5f <memmove+0x2f>
80104e6e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104e70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e77:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104e7a:	39 d6                	cmp    %edx,%esi
80104e7c:	75 f2                	jne    80104e70 <memmove+0x40>
}
80104e7e:	5b                   	pop    %ebx
80104e7f:	5e                   	pop    %esi
80104e80:	5d                   	pop    %ebp
80104e81:	c3                   	ret    
80104e82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104e93:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104e94:	eb 9a                	jmp    80104e30 <memmove>
80104e96:	8d 76 00             	lea    0x0(%esi),%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	57                   	push   %edi
80104ea4:	56                   	push   %esi
80104ea5:	8b 7d 10             	mov    0x10(%ebp),%edi
80104ea8:	53                   	push   %ebx
80104ea9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104eac:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104eaf:	85 ff                	test   %edi,%edi
80104eb1:	74 2f                	je     80104ee2 <strncmp+0x42>
80104eb3:	0f b6 01             	movzbl (%ecx),%eax
80104eb6:	0f b6 1e             	movzbl (%esi),%ebx
80104eb9:	84 c0                	test   %al,%al
80104ebb:	74 37                	je     80104ef4 <strncmp+0x54>
80104ebd:	38 c3                	cmp    %al,%bl
80104ebf:	75 33                	jne    80104ef4 <strncmp+0x54>
80104ec1:	01 f7                	add    %esi,%edi
80104ec3:	eb 13                	jmp    80104ed8 <strncmp+0x38>
80104ec5:	8d 76 00             	lea    0x0(%esi),%esi
80104ec8:	0f b6 01             	movzbl (%ecx),%eax
80104ecb:	84 c0                	test   %al,%al
80104ecd:	74 21                	je     80104ef0 <strncmp+0x50>
80104ecf:	0f b6 1a             	movzbl (%edx),%ebx
80104ed2:	89 d6                	mov    %edx,%esi
80104ed4:	38 d8                	cmp    %bl,%al
80104ed6:	75 1c                	jne    80104ef4 <strncmp+0x54>
    n--, p++, q++;
80104ed8:	8d 56 01             	lea    0x1(%esi),%edx
80104edb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104ede:	39 fa                	cmp    %edi,%edx
80104ee0:	75 e6                	jne    80104ec8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104ee2:	5b                   	pop    %ebx
    return 0;
80104ee3:	31 c0                	xor    %eax,%eax
}
80104ee5:	5e                   	pop    %esi
80104ee6:	5f                   	pop    %edi
80104ee7:	5d                   	pop    %ebp
80104ee8:	c3                   	ret    
80104ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104ef4:	29 d8                	sub    %ebx,%eax
}
80104ef6:	5b                   	pop    %ebx
80104ef7:	5e                   	pop    %esi
80104ef8:	5f                   	pop    %edi
80104ef9:	5d                   	pop    %ebp
80104efa:	c3                   	ret    
80104efb:	90                   	nop
80104efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f00 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
80104f05:	8b 45 08             	mov    0x8(%ebp),%eax
80104f08:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104f0b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104f0e:	89 c2                	mov    %eax,%edx
80104f10:	eb 19                	jmp    80104f2b <strncpy+0x2b>
80104f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f18:	83 c3 01             	add    $0x1,%ebx
80104f1b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104f1f:	83 c2 01             	add    $0x1,%edx
80104f22:	84 c9                	test   %cl,%cl
80104f24:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f27:	74 09                	je     80104f32 <strncpy+0x32>
80104f29:	89 f1                	mov    %esi,%ecx
80104f2b:	85 c9                	test   %ecx,%ecx
80104f2d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f30:	7f e6                	jg     80104f18 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f32:	31 c9                	xor    %ecx,%ecx
80104f34:	85 f6                	test   %esi,%esi
80104f36:	7e 17                	jle    80104f4f <strncpy+0x4f>
80104f38:	90                   	nop
80104f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f40:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f44:	89 f3                	mov    %esi,%ebx
80104f46:	83 c1 01             	add    $0x1,%ecx
80104f49:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104f4b:	85 db                	test   %ebx,%ebx
80104f4d:	7f f1                	jg     80104f40 <strncpy+0x40>
  return os;
}
80104f4f:	5b                   	pop    %ebx
80104f50:	5e                   	pop    %esi
80104f51:	5d                   	pop    %ebp
80104f52:	c3                   	ret    
80104f53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f60 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	56                   	push   %esi
80104f64:	53                   	push   %ebx
80104f65:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f68:	8b 45 08             	mov    0x8(%ebp),%eax
80104f6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f6e:	85 c9                	test   %ecx,%ecx
80104f70:	7e 26                	jle    80104f98 <safestrcpy+0x38>
80104f72:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f76:	89 c1                	mov    %eax,%ecx
80104f78:	eb 17                	jmp    80104f91 <safestrcpy+0x31>
80104f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f80:	83 c2 01             	add    $0x1,%edx
80104f83:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104f87:	83 c1 01             	add    $0x1,%ecx
80104f8a:	84 db                	test   %bl,%bl
80104f8c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104f8f:	74 04                	je     80104f95 <safestrcpy+0x35>
80104f91:	39 f2                	cmp    %esi,%edx
80104f93:	75 eb                	jne    80104f80 <safestrcpy+0x20>
    ;
  *s = 0;
80104f95:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104f98:	5b                   	pop    %ebx
80104f99:	5e                   	pop    %esi
80104f9a:	5d                   	pop    %ebp
80104f9b:	c3                   	ret    
80104f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fa0 <strlen>:

int
strlen(const char *s)
{
80104fa0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104fa1:	31 c0                	xor    %eax,%eax
{
80104fa3:	89 e5                	mov    %esp,%ebp
80104fa5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104fa8:	80 3a 00             	cmpb   $0x0,(%edx)
80104fab:	74 0c                	je     80104fb9 <strlen+0x19>
80104fad:	8d 76 00             	lea    0x0(%esi),%esi
80104fb0:	83 c0 01             	add    $0x1,%eax
80104fb3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104fb7:	75 f7                	jne    80104fb0 <strlen+0x10>
    ;
  return n;
}
80104fb9:	5d                   	pop    %ebp
80104fba:	c3                   	ret    

80104fbb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104fbb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104fbf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104fc3:	55                   	push   %ebp
  pushl %ebx
80104fc4:	53                   	push   %ebx
  pushl %esi
80104fc5:	56                   	push   %esi
  pushl %edi
80104fc6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104fc7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104fc9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104fcb:	5f                   	pop    %edi
  popl %esi
80104fcc:	5e                   	pop    %esi
  popl %ebx
80104fcd:	5b                   	pop    %ebx
  popl %ebp
80104fce:	5d                   	pop    %ebp
  ret
80104fcf:	c3                   	ret    

80104fd0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104fd0:	55                   	push   %ebp
80104fd1:	89 e5                	mov    %esp,%ebp
80104fd3:	53                   	push   %ebx
80104fd4:	83 ec 04             	sub    $0x4,%esp
80104fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104fda:	e8 b1 ee ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fdf:	8b 00                	mov    (%eax),%eax
80104fe1:	39 d8                	cmp    %ebx,%eax
80104fe3:	76 1b                	jbe    80105000 <fetchint+0x30>
80104fe5:	8d 53 04             	lea    0x4(%ebx),%edx
80104fe8:	39 d0                	cmp    %edx,%eax
80104fea:	72 14                	jb     80105000 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104fec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fef:	8b 13                	mov    (%ebx),%edx
80104ff1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ff3:	31 c0                	xor    %eax,%eax
}
80104ff5:	83 c4 04             	add    $0x4,%esp
80104ff8:	5b                   	pop    %ebx
80104ff9:	5d                   	pop    %ebp
80104ffa:	c3                   	ret    
80104ffb:	90                   	nop
80104ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105005:	eb ee                	jmp    80104ff5 <fetchint+0x25>
80105007:	89 f6                	mov    %esi,%esi
80105009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105010 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105010:	55                   	push   %ebp
80105011:	89 e5                	mov    %esp,%ebp
80105013:	53                   	push   %ebx
80105014:	83 ec 04             	sub    $0x4,%esp
80105017:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010501a:	e8 71 ee ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz)
8010501f:	39 18                	cmp    %ebx,(%eax)
80105021:	76 29                	jbe    8010504c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105023:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105026:	89 da                	mov    %ebx,%edx
80105028:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010502a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010502c:	39 c3                	cmp    %eax,%ebx
8010502e:	73 1c                	jae    8010504c <fetchstr+0x3c>
    if(*s == 0)
80105030:	80 3b 00             	cmpb   $0x0,(%ebx)
80105033:	75 10                	jne    80105045 <fetchstr+0x35>
80105035:	eb 39                	jmp    80105070 <fetchstr+0x60>
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105040:	80 3a 00             	cmpb   $0x0,(%edx)
80105043:	74 1b                	je     80105060 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105045:	83 c2 01             	add    $0x1,%edx
80105048:	39 d0                	cmp    %edx,%eax
8010504a:	77 f4                	ja     80105040 <fetchstr+0x30>
    return -1;
8010504c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105051:	83 c4 04             	add    $0x4,%esp
80105054:	5b                   	pop    %ebx
80105055:	5d                   	pop    %ebp
80105056:	c3                   	ret    
80105057:	89 f6                	mov    %esi,%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105060:	83 c4 04             	add    $0x4,%esp
80105063:	89 d0                	mov    %edx,%eax
80105065:	29 d8                	sub    %ebx,%eax
80105067:	5b                   	pop    %ebx
80105068:	5d                   	pop    %ebp
80105069:	c3                   	ret    
8010506a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105070:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105072:	eb dd                	jmp    80105051 <fetchstr+0x41>
80105074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010507a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105080 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105085:	e8 06 ee ff ff       	call   80103e90 <myproc>
8010508a:	8b 40 18             	mov    0x18(%eax),%eax
8010508d:	8b 55 08             	mov    0x8(%ebp),%edx
80105090:	8b 40 44             	mov    0x44(%eax),%eax
80105093:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105096:	e8 f5 ed ff ff       	call   80103e90 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010509b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010509d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050a0:	39 c6                	cmp    %eax,%esi
801050a2:	73 1c                	jae    801050c0 <argint+0x40>
801050a4:	8d 53 08             	lea    0x8(%ebx),%edx
801050a7:	39 d0                	cmp    %edx,%eax
801050a9:	72 15                	jb     801050c0 <argint+0x40>
  *ip = *(int*)(addr);
801050ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ae:	8b 53 04             	mov    0x4(%ebx),%edx
801050b1:	89 10                	mov    %edx,(%eax)
  return 0;
801050b3:	31 c0                	xor    %eax,%eax
}
801050b5:	5b                   	pop    %ebx
801050b6:	5e                   	pop    %esi
801050b7:	5d                   	pop    %ebp
801050b8:	c3                   	ret    
801050b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050c5:	eb ee                	jmp    801050b5 <argint+0x35>
801050c7:	89 f6                	mov    %esi,%esi
801050c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050d0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	56                   	push   %esi
801050d4:	53                   	push   %ebx
801050d5:	83 ec 10             	sub    $0x10,%esp
801050d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801050db:	e8 b0 ed ff ff       	call   80103e90 <myproc>
801050e0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801050e2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050e5:	83 ec 08             	sub    $0x8,%esp
801050e8:	50                   	push   %eax
801050e9:	ff 75 08             	pushl  0x8(%ebp)
801050ec:	e8 8f ff ff ff       	call   80105080 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801050f1:	83 c4 10             	add    $0x10,%esp
801050f4:	85 c0                	test   %eax,%eax
801050f6:	78 28                	js     80105120 <argptr+0x50>
801050f8:	85 db                	test   %ebx,%ebx
801050fa:	78 24                	js     80105120 <argptr+0x50>
801050fc:	8b 16                	mov    (%esi),%edx
801050fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105101:	39 c2                	cmp    %eax,%edx
80105103:	76 1b                	jbe    80105120 <argptr+0x50>
80105105:	01 c3                	add    %eax,%ebx
80105107:	39 da                	cmp    %ebx,%edx
80105109:	72 15                	jb     80105120 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010510b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010510e:	89 02                	mov    %eax,(%edx)
  return 0;
80105110:	31 c0                	xor    %eax,%eax
}
80105112:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105115:	5b                   	pop    %ebx
80105116:	5e                   	pop    %esi
80105117:	5d                   	pop    %ebp
80105118:	c3                   	ret    
80105119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105125:	eb eb                	jmp    80105112 <argptr+0x42>
80105127:	89 f6                	mov    %esi,%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105130 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105136:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105139:	50                   	push   %eax
8010513a:	ff 75 08             	pushl  0x8(%ebp)
8010513d:	e8 3e ff ff ff       	call   80105080 <argint>
80105142:	83 c4 10             	add    $0x10,%esp
80105145:	85 c0                	test   %eax,%eax
80105147:	78 17                	js     80105160 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105149:	83 ec 08             	sub    $0x8,%esp
8010514c:	ff 75 0c             	pushl  0xc(%ebp)
8010514f:	ff 75 f4             	pushl  -0xc(%ebp)
80105152:	e8 b9 fe ff ff       	call   80105010 <fetchstr>
80105157:	83 c4 10             	add    $0x10,%esp
}
8010515a:	c9                   	leave  
8010515b:	c3                   	ret    
8010515c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105160:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105165:	c9                   	leave  
80105166:	c3                   	ret    
80105167:	89 f6                	mov    %esi,%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <syscall>:
[SYS_getNumberOfFreePages] sys_getNumberOfFreePages,
};

void
syscall(void)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	53                   	push   %ebx
80105174:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105177:	e8 14 ed ff ff       	call   80103e90 <myproc>
8010517c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010517e:	8b 40 18             	mov    0x18(%eax),%eax
80105181:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105184:	8d 50 ff             	lea    -0x1(%eax),%edx
80105187:	83 fa 15             	cmp    $0x15,%edx
8010518a:	77 1c                	ja     801051a8 <syscall+0x38>
8010518c:	8b 14 85 00 8d 10 80 	mov    -0x7fef7300(,%eax,4),%edx
80105193:	85 d2                	test   %edx,%edx
80105195:	74 11                	je     801051a8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105197:	ff d2                	call   *%edx
80105199:	8b 53 18             	mov    0x18(%ebx),%edx
8010519c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010519f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051a2:	c9                   	leave  
801051a3:	c3                   	ret    
801051a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
801051a8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801051a9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801051ac:	50                   	push   %eax
801051ad:	ff 73 10             	pushl  0x10(%ebx)
801051b0:	68 d1 8c 10 80       	push   $0x80108cd1
801051b5:	e8 a6 b4 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801051ba:	8b 43 18             	mov    0x18(%ebx),%eax
801051bd:	83 c4 10             	add    $0x10,%esp
801051c0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801051c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051ca:	c9                   	leave  
801051cb:	c3                   	ret    
801051cc:	66 90                	xchg   %ax,%ax
801051ce:	66 90                	xchg   %ax,%ax

801051d0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	56                   	push   %esi
801051d4:	53                   	push   %ebx
801051d5:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801051d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801051da:	89 d6                	mov    %edx,%esi
801051dc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801051df:	50                   	push   %eax
801051e0:	6a 00                	push   $0x0
801051e2:	e8 99 fe ff ff       	call   80105080 <argint>
801051e7:	83 c4 10             	add    $0x10,%esp
801051ea:	85 c0                	test   %eax,%eax
801051ec:	78 2a                	js     80105218 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051f2:	77 24                	ja     80105218 <argfd.constprop.0+0x48>
801051f4:	e8 97 ec ff ff       	call   80103e90 <myproc>
801051f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051fc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105200:	85 c0                	test   %eax,%eax
80105202:	74 14                	je     80105218 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80105204:	85 db                	test   %ebx,%ebx
80105206:	74 02                	je     8010520a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105208:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
8010520a:	89 06                	mov    %eax,(%esi)
  return 0;
8010520c:	31 c0                	xor    %eax,%eax
}
8010520e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105211:	5b                   	pop    %ebx
80105212:	5e                   	pop    %esi
80105213:	5d                   	pop    %ebp
80105214:	c3                   	ret    
80105215:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105218:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010521d:	eb ef                	jmp    8010520e <argfd.constprop.0+0x3e>
8010521f:	90                   	nop

80105220 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105220:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105221:	31 c0                	xor    %eax,%eax
{
80105223:	89 e5                	mov    %esp,%ebp
80105225:	56                   	push   %esi
80105226:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105227:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010522a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010522d:	e8 9e ff ff ff       	call   801051d0 <argfd.constprop.0>
80105232:	85 c0                	test   %eax,%eax
80105234:	78 42                	js     80105278 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105236:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105239:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010523b:	e8 50 ec ff ff       	call   80103e90 <myproc>
80105240:	eb 0e                	jmp    80105250 <sys_dup+0x30>
80105242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105248:	83 c3 01             	add    $0x1,%ebx
8010524b:	83 fb 10             	cmp    $0x10,%ebx
8010524e:	74 28                	je     80105278 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105250:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105254:	85 d2                	test   %edx,%edx
80105256:	75 f0                	jne    80105248 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105258:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010525c:	83 ec 0c             	sub    $0xc,%esp
8010525f:	ff 75 f4             	pushl  -0xc(%ebp)
80105262:	e8 09 bc ff ff       	call   80100e70 <filedup>
  return fd;
80105267:	83 c4 10             	add    $0x10,%esp
}
8010526a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010526d:	89 d8                	mov    %ebx,%eax
8010526f:	5b                   	pop    %ebx
80105270:	5e                   	pop    %esi
80105271:	5d                   	pop    %ebp
80105272:	c3                   	ret    
80105273:	90                   	nop
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105278:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010527b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105280:	89 d8                	mov    %ebx,%eax
80105282:	5b                   	pop    %ebx
80105283:	5e                   	pop    %esi
80105284:	5d                   	pop    %ebp
80105285:	c3                   	ret    
80105286:	8d 76 00             	lea    0x0(%esi),%esi
80105289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105290 <sys_read>:

int
sys_read(void)
{
80105290:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105291:	31 c0                	xor    %eax,%eax
{
80105293:	89 e5                	mov    %esp,%ebp
80105295:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105298:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010529b:	e8 30 ff ff ff       	call   801051d0 <argfd.constprop.0>
801052a0:	85 c0                	test   %eax,%eax
801052a2:	78 4c                	js     801052f0 <sys_read+0x60>
801052a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052a7:	83 ec 08             	sub    $0x8,%esp
801052aa:	50                   	push   %eax
801052ab:	6a 02                	push   $0x2
801052ad:	e8 ce fd ff ff       	call   80105080 <argint>
801052b2:	83 c4 10             	add    $0x10,%esp
801052b5:	85 c0                	test   %eax,%eax
801052b7:	78 37                	js     801052f0 <sys_read+0x60>
801052b9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052bc:	83 ec 04             	sub    $0x4,%esp
801052bf:	ff 75 f0             	pushl  -0x10(%ebp)
801052c2:	50                   	push   %eax
801052c3:	6a 01                	push   $0x1
801052c5:	e8 06 fe ff ff       	call   801050d0 <argptr>
801052ca:	83 c4 10             	add    $0x10,%esp
801052cd:	85 c0                	test   %eax,%eax
801052cf:	78 1f                	js     801052f0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801052d1:	83 ec 04             	sub    $0x4,%esp
801052d4:	ff 75 f0             	pushl  -0x10(%ebp)
801052d7:	ff 75 f4             	pushl  -0xc(%ebp)
801052da:	ff 75 ec             	pushl  -0x14(%ebp)
801052dd:	e8 fe bc ff ff       	call   80100fe0 <fileread>
801052e2:	83 c4 10             	add    $0x10,%esp
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052f5:	c9                   	leave  
801052f6:	c3                   	ret    
801052f7:	89 f6                	mov    %esi,%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <sys_write>:

int
sys_write(void)
{
80105300:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105301:	31 c0                	xor    %eax,%eax
{
80105303:	89 e5                	mov    %esp,%ebp
80105305:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105308:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010530b:	e8 c0 fe ff ff       	call   801051d0 <argfd.constprop.0>
80105310:	85 c0                	test   %eax,%eax
80105312:	78 4c                	js     80105360 <sys_write+0x60>
80105314:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105317:	83 ec 08             	sub    $0x8,%esp
8010531a:	50                   	push   %eax
8010531b:	6a 02                	push   $0x2
8010531d:	e8 5e fd ff ff       	call   80105080 <argint>
80105322:	83 c4 10             	add    $0x10,%esp
80105325:	85 c0                	test   %eax,%eax
80105327:	78 37                	js     80105360 <sys_write+0x60>
80105329:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010532c:	83 ec 04             	sub    $0x4,%esp
8010532f:	ff 75 f0             	pushl  -0x10(%ebp)
80105332:	50                   	push   %eax
80105333:	6a 01                	push   $0x1
80105335:	e8 96 fd ff ff       	call   801050d0 <argptr>
8010533a:	83 c4 10             	add    $0x10,%esp
8010533d:	85 c0                	test   %eax,%eax
8010533f:	78 1f                	js     80105360 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105341:	83 ec 04             	sub    $0x4,%esp
80105344:	ff 75 f0             	pushl  -0x10(%ebp)
80105347:	ff 75 f4             	pushl  -0xc(%ebp)
8010534a:	ff 75 ec             	pushl  -0x14(%ebp)
8010534d:	e8 1e bd ff ff       	call   80101070 <filewrite>
80105352:	83 c4 10             	add    $0x10,%esp
}
80105355:	c9                   	leave  
80105356:	c3                   	ret    
80105357:	89 f6                	mov    %esi,%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105360:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105365:	c9                   	leave  
80105366:	c3                   	ret    
80105367:	89 f6                	mov    %esi,%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <sys_close>:

int
sys_close(void)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105376:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105379:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010537c:	e8 4f fe ff ff       	call   801051d0 <argfd.constprop.0>
80105381:	85 c0                	test   %eax,%eax
80105383:	78 2b                	js     801053b0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105385:	e8 06 eb ff ff       	call   80103e90 <myproc>
8010538a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010538d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105390:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105397:	00 
  fileclose(f);
80105398:	ff 75 f4             	pushl  -0xc(%ebp)
8010539b:	e8 20 bb ff ff       	call   80100ec0 <fileclose>
  return 0;
801053a0:	83 c4 10             	add    $0x10,%esp
801053a3:	31 c0                	xor    %eax,%eax
}
801053a5:	c9                   	leave  
801053a6:	c3                   	ret    
801053a7:	89 f6                	mov    %esi,%esi
801053a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053b5:	c9                   	leave  
801053b6:	c3                   	ret    
801053b7:	89 f6                	mov    %esi,%esi
801053b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053c0 <sys_fstat>:

int
sys_fstat(void)
{
801053c0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053c1:	31 c0                	xor    %eax,%eax
{
801053c3:	89 e5                	mov    %esp,%ebp
801053c5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053c8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801053cb:	e8 00 fe ff ff       	call   801051d0 <argfd.constprop.0>
801053d0:	85 c0                	test   %eax,%eax
801053d2:	78 2c                	js     80105400 <sys_fstat+0x40>
801053d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d7:	83 ec 04             	sub    $0x4,%esp
801053da:	6a 14                	push   $0x14
801053dc:	50                   	push   %eax
801053dd:	6a 01                	push   $0x1
801053df:	e8 ec fc ff ff       	call   801050d0 <argptr>
801053e4:	83 c4 10             	add    $0x10,%esp
801053e7:	85 c0                	test   %eax,%eax
801053e9:	78 15                	js     80105400 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801053eb:	83 ec 08             	sub    $0x8,%esp
801053ee:	ff 75 f4             	pushl  -0xc(%ebp)
801053f1:	ff 75 f0             	pushl  -0x10(%ebp)
801053f4:	e8 97 bb ff ff       	call   80100f90 <filestat>
801053f9:	83 c4 10             	add    $0x10,%esp
}
801053fc:	c9                   	leave  
801053fd:	c3                   	ret    
801053fe:	66 90                	xchg   %ax,%ax
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105405:	c9                   	leave  
80105406:	c3                   	ret    
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105410:	55                   	push   %ebp
80105411:	89 e5                	mov    %esp,%ebp
80105413:	57                   	push   %edi
80105414:	56                   	push   %esi
80105415:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105416:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105419:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010541c:	50                   	push   %eax
8010541d:	6a 00                	push   $0x0
8010541f:	e8 0c fd ff ff       	call   80105130 <argstr>
80105424:	83 c4 10             	add    $0x10,%esp
80105427:	85 c0                	test   %eax,%eax
80105429:	0f 88 fb 00 00 00    	js     8010552a <sys_link+0x11a>
8010542f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105432:	83 ec 08             	sub    $0x8,%esp
80105435:	50                   	push   %eax
80105436:	6a 01                	push   $0x1
80105438:	e8 f3 fc ff ff       	call   80105130 <argstr>
8010543d:	83 c4 10             	add    $0x10,%esp
80105440:	85 c0                	test   %eax,%eax
80105442:	0f 88 e2 00 00 00    	js     8010552a <sys_link+0x11a>
    return -1;

  begin_op();
80105448:	e8 63 dd ff ff       	call   801031b0 <begin_op>
  if((ip = namei(old)) == 0){
8010544d:	83 ec 0c             	sub    $0xc,%esp
80105450:	ff 75 d4             	pushl  -0x2c(%ebp)
80105453:	e8 08 cb ff ff       	call   80101f60 <namei>
80105458:	83 c4 10             	add    $0x10,%esp
8010545b:	85 c0                	test   %eax,%eax
8010545d:	89 c3                	mov    %eax,%ebx
8010545f:	0f 84 ea 00 00 00    	je     8010554f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105465:	83 ec 0c             	sub    $0xc,%esp
80105468:	50                   	push   %eax
80105469:	e8 92 c2 ff ff       	call   80101700 <ilock>
  if(ip->type == T_DIR){
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105476:	0f 84 bb 00 00 00    	je     80105537 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010547c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105481:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105484:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105487:	53                   	push   %ebx
80105488:	e8 c3 c1 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
8010548d:	89 1c 24             	mov    %ebx,(%esp)
80105490:	e8 4b c3 ff ff       	call   801017e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105495:	58                   	pop    %eax
80105496:	5a                   	pop    %edx
80105497:	57                   	push   %edi
80105498:	ff 75 d0             	pushl  -0x30(%ebp)
8010549b:	e8 e0 ca ff ff       	call   80101f80 <nameiparent>
801054a0:	83 c4 10             	add    $0x10,%esp
801054a3:	85 c0                	test   %eax,%eax
801054a5:	89 c6                	mov    %eax,%esi
801054a7:	74 5b                	je     80105504 <sys_link+0xf4>
    goto bad;
  ilock(dp);
801054a9:	83 ec 0c             	sub    $0xc,%esp
801054ac:	50                   	push   %eax
801054ad:	e8 4e c2 ff ff       	call   80101700 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801054b2:	83 c4 10             	add    $0x10,%esp
801054b5:	8b 03                	mov    (%ebx),%eax
801054b7:	39 06                	cmp    %eax,(%esi)
801054b9:	75 3d                	jne    801054f8 <sys_link+0xe8>
801054bb:	83 ec 04             	sub    $0x4,%esp
801054be:	ff 73 04             	pushl  0x4(%ebx)
801054c1:	57                   	push   %edi
801054c2:	56                   	push   %esi
801054c3:	e8 d8 c9 ff ff       	call   80101ea0 <dirlink>
801054c8:	83 c4 10             	add    $0x10,%esp
801054cb:	85 c0                	test   %eax,%eax
801054cd:	78 29                	js     801054f8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801054cf:	83 ec 0c             	sub    $0xc,%esp
801054d2:	56                   	push   %esi
801054d3:	e8 b8 c4 ff ff       	call   80101990 <iunlockput>
  iput(ip);
801054d8:	89 1c 24             	mov    %ebx,(%esp)
801054db:	e8 50 c3 ff ff       	call   80101830 <iput>

  end_op();
801054e0:	e8 3b dd ff ff       	call   80103220 <end_op>

  return 0;
801054e5:	83 c4 10             	add    $0x10,%esp
801054e8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801054ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054ed:	5b                   	pop    %ebx
801054ee:	5e                   	pop    %esi
801054ef:	5f                   	pop    %edi
801054f0:	5d                   	pop    %ebp
801054f1:	c3                   	ret    
801054f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	56                   	push   %esi
801054fc:	e8 8f c4 ff ff       	call   80101990 <iunlockput>
    goto bad;
80105501:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105504:	83 ec 0c             	sub    $0xc,%esp
80105507:	53                   	push   %ebx
80105508:	e8 f3 c1 ff ff       	call   80101700 <ilock>
  ip->nlink--;
8010550d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105512:	89 1c 24             	mov    %ebx,(%esp)
80105515:	e8 36 c1 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
8010551a:	89 1c 24             	mov    %ebx,(%esp)
8010551d:	e8 6e c4 ff ff       	call   80101990 <iunlockput>
  end_op();
80105522:	e8 f9 dc ff ff       	call   80103220 <end_op>
  return -1;
80105527:	83 c4 10             	add    $0x10,%esp
}
8010552a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010552d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105532:	5b                   	pop    %ebx
80105533:	5e                   	pop    %esi
80105534:	5f                   	pop    %edi
80105535:	5d                   	pop    %ebp
80105536:	c3                   	ret    
    iunlockput(ip);
80105537:	83 ec 0c             	sub    $0xc,%esp
8010553a:	53                   	push   %ebx
8010553b:	e8 50 c4 ff ff       	call   80101990 <iunlockput>
    end_op();
80105540:	e8 db dc ff ff       	call   80103220 <end_op>
    return -1;
80105545:	83 c4 10             	add    $0x10,%esp
80105548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554d:	eb 9b                	jmp    801054ea <sys_link+0xda>
    end_op();
8010554f:	e8 cc dc ff ff       	call   80103220 <end_op>
    return -1;
80105554:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105559:	eb 8f                	jmp    801054ea <sys_link+0xda>
8010555b:	90                   	nop
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
80105565:	53                   	push   %ebx
80105566:	83 ec 1c             	sub    $0x1c,%esp
80105569:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010556c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105570:	76 3e                	jbe    801055b0 <isdirempty+0x50>
80105572:	bb 20 00 00 00       	mov    $0x20,%ebx
80105577:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010557a:	eb 0c                	jmp    80105588 <isdirempty+0x28>
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105580:	83 c3 10             	add    $0x10,%ebx
80105583:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105586:	73 28                	jae    801055b0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105588:	6a 10                	push   $0x10
8010558a:	53                   	push   %ebx
8010558b:	57                   	push   %edi
8010558c:	56                   	push   %esi
8010558d:	e8 4e c4 ff ff       	call   801019e0 <readi>
80105592:	83 c4 10             	add    $0x10,%esp
80105595:	83 f8 10             	cmp    $0x10,%eax
80105598:	75 23                	jne    801055bd <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010559a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010559f:	74 df                	je     80105580 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
801055a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801055a4:	31 c0                	xor    %eax,%eax
}
801055a6:	5b                   	pop    %ebx
801055a7:	5e                   	pop    %esi
801055a8:	5f                   	pop    %edi
801055a9:	5d                   	pop    %ebp
801055aa:	c3                   	ret    
801055ab:	90                   	nop
801055ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801055b3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801055b8:	5b                   	pop    %ebx
801055b9:	5e                   	pop    %esi
801055ba:	5f                   	pop    %edi
801055bb:	5d                   	pop    %ebp
801055bc:	c3                   	ret    
      panic("isdirempty: readi");
801055bd:	83 ec 0c             	sub    $0xc,%esp
801055c0:	68 5c 8d 10 80       	push   $0x80108d5c
801055c5:	e8 c6 ad ff ff       	call   80100390 <panic>
801055ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801055d0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
801055d5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801055d6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801055d9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801055dc:	50                   	push   %eax
801055dd:	6a 00                	push   $0x0
801055df:	e8 4c fb ff ff       	call   80105130 <argstr>
801055e4:	83 c4 10             	add    $0x10,%esp
801055e7:	85 c0                	test   %eax,%eax
801055e9:	0f 88 51 01 00 00    	js     80105740 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801055ef:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801055f2:	e8 b9 db ff ff       	call   801031b0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801055f7:	83 ec 08             	sub    $0x8,%esp
801055fa:	53                   	push   %ebx
801055fb:	ff 75 c0             	pushl  -0x40(%ebp)
801055fe:	e8 7d c9 ff ff       	call   80101f80 <nameiparent>
80105603:	83 c4 10             	add    $0x10,%esp
80105606:	85 c0                	test   %eax,%eax
80105608:	89 c6                	mov    %eax,%esi
8010560a:	0f 84 37 01 00 00    	je     80105747 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105610:	83 ec 0c             	sub    $0xc,%esp
80105613:	50                   	push   %eax
80105614:	e8 e7 c0 ff ff       	call   80101700 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105619:	58                   	pop    %eax
8010561a:	5a                   	pop    %edx
8010561b:	68 bd 86 10 80       	push   $0x801086bd
80105620:	53                   	push   %ebx
80105621:	e8 ea c5 ff ff       	call   80101c10 <namecmp>
80105626:	83 c4 10             	add    $0x10,%esp
80105629:	85 c0                	test   %eax,%eax
8010562b:	0f 84 d7 00 00 00    	je     80105708 <sys_unlink+0x138>
80105631:	83 ec 08             	sub    $0x8,%esp
80105634:	68 bc 86 10 80       	push   $0x801086bc
80105639:	53                   	push   %ebx
8010563a:	e8 d1 c5 ff ff       	call   80101c10 <namecmp>
8010563f:	83 c4 10             	add    $0x10,%esp
80105642:	85 c0                	test   %eax,%eax
80105644:	0f 84 be 00 00 00    	je     80105708 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010564a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010564d:	83 ec 04             	sub    $0x4,%esp
80105650:	50                   	push   %eax
80105651:	53                   	push   %ebx
80105652:	56                   	push   %esi
80105653:	e8 d8 c5 ff ff       	call   80101c30 <dirlookup>
80105658:	83 c4 10             	add    $0x10,%esp
8010565b:	85 c0                	test   %eax,%eax
8010565d:	89 c3                	mov    %eax,%ebx
8010565f:	0f 84 a3 00 00 00    	je     80105708 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105665:	83 ec 0c             	sub    $0xc,%esp
80105668:	50                   	push   %eax
80105669:	e8 92 c0 ff ff       	call   80101700 <ilock>

  if(ip->nlink < 1)
8010566e:	83 c4 10             	add    $0x10,%esp
80105671:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105676:	0f 8e e4 00 00 00    	jle    80105760 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010567c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105681:	74 65                	je     801056e8 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105683:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105686:	83 ec 04             	sub    $0x4,%esp
80105689:	6a 10                	push   $0x10
8010568b:	6a 00                	push   $0x0
8010568d:	57                   	push   %edi
8010568e:	e8 ed f6 ff ff       	call   80104d80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105693:	6a 10                	push   $0x10
80105695:	ff 75 c4             	pushl  -0x3c(%ebp)
80105698:	57                   	push   %edi
80105699:	56                   	push   %esi
8010569a:	e8 41 c4 ff ff       	call   80101ae0 <writei>
8010569f:	83 c4 20             	add    $0x20,%esp
801056a2:	83 f8 10             	cmp    $0x10,%eax
801056a5:	0f 85 a8 00 00 00    	jne    80105753 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801056ab:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056b0:	74 6e                	je     80105720 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801056b2:	83 ec 0c             	sub    $0xc,%esp
801056b5:	56                   	push   %esi
801056b6:	e8 d5 c2 ff ff       	call   80101990 <iunlockput>

  ip->nlink--;
801056bb:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056c0:	89 1c 24             	mov    %ebx,(%esp)
801056c3:	e8 88 bf ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
801056c8:	89 1c 24             	mov    %ebx,(%esp)
801056cb:	e8 c0 c2 ff ff       	call   80101990 <iunlockput>

  end_op();
801056d0:	e8 4b db ff ff       	call   80103220 <end_op>

  return 0;
801056d5:	83 c4 10             	add    $0x10,%esp
801056d8:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801056da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056dd:	5b                   	pop    %ebx
801056de:	5e                   	pop    %esi
801056df:	5f                   	pop    %edi
801056e0:	5d                   	pop    %ebp
801056e1:	c3                   	ret    
801056e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
801056e8:	83 ec 0c             	sub    $0xc,%esp
801056eb:	53                   	push   %ebx
801056ec:	e8 6f fe ff ff       	call   80105560 <isdirempty>
801056f1:	83 c4 10             	add    $0x10,%esp
801056f4:	85 c0                	test   %eax,%eax
801056f6:	75 8b                	jne    80105683 <sys_unlink+0xb3>
    iunlockput(ip);
801056f8:	83 ec 0c             	sub    $0xc,%esp
801056fb:	53                   	push   %ebx
801056fc:	e8 8f c2 ff ff       	call   80101990 <iunlockput>
    goto bad;
80105701:	83 c4 10             	add    $0x10,%esp
80105704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105708:	83 ec 0c             	sub    $0xc,%esp
8010570b:	56                   	push   %esi
8010570c:	e8 7f c2 ff ff       	call   80101990 <iunlockput>
  end_op();
80105711:	e8 0a db ff ff       	call   80103220 <end_op>
  return -1;
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010571e:	eb ba                	jmp    801056da <sys_unlink+0x10a>
    dp->nlink--;
80105720:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105725:	83 ec 0c             	sub    $0xc,%esp
80105728:	56                   	push   %esi
80105729:	e8 22 bf ff ff       	call   80101650 <iupdate>
8010572e:	83 c4 10             	add    $0x10,%esp
80105731:	e9 7c ff ff ff       	jmp    801056b2 <sys_unlink+0xe2>
80105736:	8d 76 00             	lea    0x0(%esi),%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105740:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105745:	eb 93                	jmp    801056da <sys_unlink+0x10a>
    end_op();
80105747:	e8 d4 da ff ff       	call   80103220 <end_op>
    return -1;
8010574c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105751:	eb 87                	jmp    801056da <sys_unlink+0x10a>
    panic("unlink: writei");
80105753:	83 ec 0c             	sub    $0xc,%esp
80105756:	68 d1 86 10 80       	push   $0x801086d1
8010575b:	e8 30 ac ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105760:	83 ec 0c             	sub    $0xc,%esp
80105763:	68 bf 86 10 80       	push   $0x801086bf
80105768:	e8 23 ac ff ff       	call   80100390 <panic>
8010576d:	8d 76 00             	lea    0x0(%esi),%esi

80105770 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	57                   	push   %edi
80105774:	56                   	push   %esi
80105775:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105776:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105779:	83 ec 34             	sub    $0x34,%esp
8010577c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010577f:	8b 55 10             	mov    0x10(%ebp),%edx
80105782:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105785:	56                   	push   %esi
80105786:	ff 75 08             	pushl  0x8(%ebp)
{
80105789:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010578c:	89 55 d0             	mov    %edx,-0x30(%ebp)
8010578f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105792:	e8 e9 c7 ff ff       	call   80101f80 <nameiparent>
80105797:	83 c4 10             	add    $0x10,%esp
8010579a:	85 c0                	test   %eax,%eax
8010579c:	0f 84 4e 01 00 00    	je     801058f0 <create+0x180>
    return 0;
  ilock(dp);
801057a2:	83 ec 0c             	sub    $0xc,%esp
801057a5:	89 c3                	mov    %eax,%ebx
801057a7:	50                   	push   %eax
801057a8:	e8 53 bf ff ff       	call   80101700 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801057ad:	83 c4 0c             	add    $0xc,%esp
801057b0:	6a 00                	push   $0x0
801057b2:	56                   	push   %esi
801057b3:	53                   	push   %ebx
801057b4:	e8 77 c4 ff ff       	call   80101c30 <dirlookup>
801057b9:	83 c4 10             	add    $0x10,%esp
801057bc:	85 c0                	test   %eax,%eax
801057be:	89 c7                	mov    %eax,%edi
801057c0:	74 3e                	je     80105800 <create+0x90>
    iunlockput(dp);
801057c2:	83 ec 0c             	sub    $0xc,%esp
801057c5:	53                   	push   %ebx
801057c6:	e8 c5 c1 ff ff       	call   80101990 <iunlockput>
    ilock(ip);
801057cb:	89 3c 24             	mov    %edi,(%esp)
801057ce:	e8 2d bf ff ff       	call   80101700 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801057d3:	83 c4 10             	add    $0x10,%esp
801057d6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801057db:	0f 85 9f 00 00 00    	jne    80105880 <create+0x110>
801057e1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801057e6:	0f 85 94 00 00 00    	jne    80105880 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801057ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057ef:	89 f8                	mov    %edi,%eax
801057f1:	5b                   	pop    %ebx
801057f2:	5e                   	pop    %esi
801057f3:	5f                   	pop    %edi
801057f4:	5d                   	pop    %ebp
801057f5:	c3                   	ret    
801057f6:	8d 76 00             	lea    0x0(%esi),%esi
801057f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
80105800:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105804:	83 ec 08             	sub    $0x8,%esp
80105807:	50                   	push   %eax
80105808:	ff 33                	pushl  (%ebx)
8010580a:	e8 81 bd ff ff       	call   80101590 <ialloc>
8010580f:	83 c4 10             	add    $0x10,%esp
80105812:	85 c0                	test   %eax,%eax
80105814:	89 c7                	mov    %eax,%edi
80105816:	0f 84 e8 00 00 00    	je     80105904 <create+0x194>
  ilock(ip);
8010581c:	83 ec 0c             	sub    $0xc,%esp
8010581f:	50                   	push   %eax
80105820:	e8 db be ff ff       	call   80101700 <ilock>
  ip->major = major;
80105825:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105829:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010582d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105831:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105835:	b8 01 00 00 00       	mov    $0x1,%eax
8010583a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010583e:	89 3c 24             	mov    %edi,(%esp)
80105841:	e8 0a be ff ff       	call   80101650 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010584e:	74 50                	je     801058a0 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105850:	83 ec 04             	sub    $0x4,%esp
80105853:	ff 77 04             	pushl  0x4(%edi)
80105856:	56                   	push   %esi
80105857:	53                   	push   %ebx
80105858:	e8 43 c6 ff ff       	call   80101ea0 <dirlink>
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	85 c0                	test   %eax,%eax
80105862:	0f 88 8f 00 00 00    	js     801058f7 <create+0x187>
  iunlockput(dp);
80105868:	83 ec 0c             	sub    $0xc,%esp
8010586b:	53                   	push   %ebx
8010586c:	e8 1f c1 ff ff       	call   80101990 <iunlockput>
  return ip;
80105871:	83 c4 10             	add    $0x10,%esp
}
80105874:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105877:	89 f8                	mov    %edi,%eax
80105879:	5b                   	pop    %ebx
8010587a:	5e                   	pop    %esi
8010587b:	5f                   	pop    %edi
8010587c:	5d                   	pop    %ebp
8010587d:	c3                   	ret    
8010587e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105880:	83 ec 0c             	sub    $0xc,%esp
80105883:	57                   	push   %edi
    return 0;
80105884:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105886:	e8 05 c1 ff ff       	call   80101990 <iunlockput>
    return 0;
8010588b:	83 c4 10             	add    $0x10,%esp
}
8010588e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105891:	89 f8                	mov    %edi,%eax
80105893:	5b                   	pop    %ebx
80105894:	5e                   	pop    %esi
80105895:	5f                   	pop    %edi
80105896:	5d                   	pop    %ebp
80105897:	c3                   	ret    
80105898:	90                   	nop
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
801058a0:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801058a5:	83 ec 0c             	sub    $0xc,%esp
801058a8:	53                   	push   %ebx
801058a9:	e8 a2 bd ff ff       	call   80101650 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801058ae:	83 c4 0c             	add    $0xc,%esp
801058b1:	ff 77 04             	pushl  0x4(%edi)
801058b4:	68 bd 86 10 80       	push   $0x801086bd
801058b9:	57                   	push   %edi
801058ba:	e8 e1 c5 ff ff       	call   80101ea0 <dirlink>
801058bf:	83 c4 10             	add    $0x10,%esp
801058c2:	85 c0                	test   %eax,%eax
801058c4:	78 1c                	js     801058e2 <create+0x172>
801058c6:	83 ec 04             	sub    $0x4,%esp
801058c9:	ff 73 04             	pushl  0x4(%ebx)
801058cc:	68 bc 86 10 80       	push   $0x801086bc
801058d1:	57                   	push   %edi
801058d2:	e8 c9 c5 ff ff       	call   80101ea0 <dirlink>
801058d7:	83 c4 10             	add    $0x10,%esp
801058da:	85 c0                	test   %eax,%eax
801058dc:	0f 89 6e ff ff ff    	jns    80105850 <create+0xe0>
      panic("create dots");
801058e2:	83 ec 0c             	sub    $0xc,%esp
801058e5:	68 7d 8d 10 80       	push   $0x80108d7d
801058ea:	e8 a1 aa ff ff       	call   80100390 <panic>
801058ef:	90                   	nop
    return 0;
801058f0:	31 ff                	xor    %edi,%edi
801058f2:	e9 f5 fe ff ff       	jmp    801057ec <create+0x7c>
    panic("create: dirlink");
801058f7:	83 ec 0c             	sub    $0xc,%esp
801058fa:	68 89 8d 10 80       	push   $0x80108d89
801058ff:	e8 8c aa ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105904:	83 ec 0c             	sub    $0xc,%esp
80105907:	68 6e 8d 10 80       	push   $0x80108d6e
8010590c:	e8 7f aa ff ff       	call   80100390 <panic>
80105911:	eb 0d                	jmp    80105920 <sys_open>
80105913:	90                   	nop
80105914:	90                   	nop
80105915:	90                   	nop
80105916:	90                   	nop
80105917:	90                   	nop
80105918:	90                   	nop
80105919:	90                   	nop
8010591a:	90                   	nop
8010591b:	90                   	nop
8010591c:	90                   	nop
8010591d:	90                   	nop
8010591e:	90                   	nop
8010591f:	90                   	nop

80105920 <sys_open>:

int
sys_open(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	57                   	push   %edi
80105924:	56                   	push   %esi
80105925:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105926:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105929:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010592c:	50                   	push   %eax
8010592d:	6a 00                	push   $0x0
8010592f:	e8 fc f7 ff ff       	call   80105130 <argstr>
80105934:	83 c4 10             	add    $0x10,%esp
80105937:	85 c0                	test   %eax,%eax
80105939:	0f 88 1d 01 00 00    	js     80105a5c <sys_open+0x13c>
8010593f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105942:	83 ec 08             	sub    $0x8,%esp
80105945:	50                   	push   %eax
80105946:	6a 01                	push   $0x1
80105948:	e8 33 f7 ff ff       	call   80105080 <argint>
8010594d:	83 c4 10             	add    $0x10,%esp
80105950:	85 c0                	test   %eax,%eax
80105952:	0f 88 04 01 00 00    	js     80105a5c <sys_open+0x13c>
    return -1;

  begin_op();
80105958:	e8 53 d8 ff ff       	call   801031b0 <begin_op>

  if(omode & O_CREATE){
8010595d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105961:	0f 85 a9 00 00 00    	jne    80105a10 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105967:	83 ec 0c             	sub    $0xc,%esp
8010596a:	ff 75 e0             	pushl  -0x20(%ebp)
8010596d:	e8 ee c5 ff ff       	call   80101f60 <namei>
80105972:	83 c4 10             	add    $0x10,%esp
80105975:	85 c0                	test   %eax,%eax
80105977:	89 c6                	mov    %eax,%esi
80105979:	0f 84 ac 00 00 00    	je     80105a2b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
8010597f:	83 ec 0c             	sub    $0xc,%esp
80105982:	50                   	push   %eax
80105983:	e8 78 bd ff ff       	call   80101700 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105988:	83 c4 10             	add    $0x10,%esp
8010598b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105990:	0f 84 aa 00 00 00    	je     80105a40 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105996:	e8 65 b4 ff ff       	call   80100e00 <filealloc>
8010599b:	85 c0                	test   %eax,%eax
8010599d:	89 c7                	mov    %eax,%edi
8010599f:	0f 84 a6 00 00 00    	je     80105a4b <sys_open+0x12b>
  struct proc *curproc = myproc();
801059a5:	e8 e6 e4 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059aa:	31 db                	xor    %ebx,%ebx
801059ac:	eb 0e                	jmp    801059bc <sys_open+0x9c>
801059ae:	66 90                	xchg   %ax,%ax
801059b0:	83 c3 01             	add    $0x1,%ebx
801059b3:	83 fb 10             	cmp    $0x10,%ebx
801059b6:	0f 84 ac 00 00 00    	je     80105a68 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801059bc:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059c0:	85 d2                	test   %edx,%edx
801059c2:	75 ec                	jne    801059b0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059c4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059c7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801059cb:	56                   	push   %esi
801059cc:	e8 0f be ff ff       	call   801017e0 <iunlock>
  end_op();
801059d1:	e8 4a d8 ff ff       	call   80103220 <end_op>

  f->type = FD_INODE;
801059d6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059dc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059df:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059e2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801059e5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059ec:	89 d0                	mov    %edx,%eax
801059ee:	f7 d0                	not    %eax
801059f0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059f3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059f6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059f9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a00:	89 d8                	mov    %ebx,%eax
80105a02:	5b                   	pop    %ebx
80105a03:	5e                   	pop    %esi
80105a04:	5f                   	pop    %edi
80105a05:	5d                   	pop    %ebp
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105a10:	6a 00                	push   $0x0
80105a12:	6a 00                	push   $0x0
80105a14:	6a 02                	push   $0x2
80105a16:	ff 75 e0             	pushl  -0x20(%ebp)
80105a19:	e8 52 fd ff ff       	call   80105770 <create>
    if(ip == 0){
80105a1e:	83 c4 10             	add    $0x10,%esp
80105a21:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105a23:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105a25:	0f 85 6b ff ff ff    	jne    80105996 <sys_open+0x76>
      end_op();
80105a2b:	e8 f0 d7 ff ff       	call   80103220 <end_op>
      return -1;
80105a30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a35:	eb c6                	jmp    801059fd <sys_open+0xdd>
80105a37:	89 f6                	mov    %esi,%esi
80105a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a40:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105a43:	85 c9                	test   %ecx,%ecx
80105a45:	0f 84 4b ff ff ff    	je     80105996 <sys_open+0x76>
    iunlockput(ip);
80105a4b:	83 ec 0c             	sub    $0xc,%esp
80105a4e:	56                   	push   %esi
80105a4f:	e8 3c bf ff ff       	call   80101990 <iunlockput>
    end_op();
80105a54:	e8 c7 d7 ff ff       	call   80103220 <end_op>
    return -1;
80105a59:	83 c4 10             	add    $0x10,%esp
80105a5c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a61:	eb 9a                	jmp    801059fd <sys_open+0xdd>
80105a63:	90                   	nop
80105a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105a68:	83 ec 0c             	sub    $0xc,%esp
80105a6b:	57                   	push   %edi
80105a6c:	e8 4f b4 ff ff       	call   80100ec0 <fileclose>
80105a71:	83 c4 10             	add    $0x10,%esp
80105a74:	eb d5                	jmp    80105a4b <sys_open+0x12b>
80105a76:	8d 76 00             	lea    0x0(%esi),%esi
80105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a80 <sys_mkdir>:

int
sys_mkdir(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a86:	e8 25 d7 ff ff       	call   801031b0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105a8b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a8e:	83 ec 08             	sub    $0x8,%esp
80105a91:	50                   	push   %eax
80105a92:	6a 00                	push   $0x0
80105a94:	e8 97 f6 ff ff       	call   80105130 <argstr>
80105a99:	83 c4 10             	add    $0x10,%esp
80105a9c:	85 c0                	test   %eax,%eax
80105a9e:	78 30                	js     80105ad0 <sys_mkdir+0x50>
80105aa0:	6a 00                	push   $0x0
80105aa2:	6a 00                	push   $0x0
80105aa4:	6a 01                	push   $0x1
80105aa6:	ff 75 f4             	pushl  -0xc(%ebp)
80105aa9:	e8 c2 fc ff ff       	call   80105770 <create>
80105aae:	83 c4 10             	add    $0x10,%esp
80105ab1:	85 c0                	test   %eax,%eax
80105ab3:	74 1b                	je     80105ad0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105ab5:	83 ec 0c             	sub    $0xc,%esp
80105ab8:	50                   	push   %eax
80105ab9:	e8 d2 be ff ff       	call   80101990 <iunlockput>
  end_op();
80105abe:	e8 5d d7 ff ff       	call   80103220 <end_op>
  return 0;
80105ac3:	83 c4 10             	add    $0x10,%esp
80105ac6:	31 c0                	xor    %eax,%eax
}
80105ac8:	c9                   	leave  
80105ac9:	c3                   	ret    
80105aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105ad0:	e8 4b d7 ff ff       	call   80103220 <end_op>
    return -1;
80105ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ada:	c9                   	leave  
80105adb:	c3                   	ret    
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <sys_mknod>:

int
sys_mknod(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105ae6:	e8 c5 d6 ff ff       	call   801031b0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105aeb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105aee:	83 ec 08             	sub    $0x8,%esp
80105af1:	50                   	push   %eax
80105af2:	6a 00                	push   $0x0
80105af4:	e8 37 f6 ff ff       	call   80105130 <argstr>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	85 c0                	test   %eax,%eax
80105afe:	78 60                	js     80105b60 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105b00:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b03:	83 ec 08             	sub    $0x8,%esp
80105b06:	50                   	push   %eax
80105b07:	6a 01                	push   $0x1
80105b09:	e8 72 f5 ff ff       	call   80105080 <argint>
  if((argstr(0, &path)) < 0 ||
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	85 c0                	test   %eax,%eax
80105b13:	78 4b                	js     80105b60 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105b15:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b18:	83 ec 08             	sub    $0x8,%esp
80105b1b:	50                   	push   %eax
80105b1c:	6a 02                	push   $0x2
80105b1e:	e8 5d f5 ff ff       	call   80105080 <argint>
     argint(1, &major) < 0 ||
80105b23:	83 c4 10             	add    $0x10,%esp
80105b26:	85 c0                	test   %eax,%eax
80105b28:	78 36                	js     80105b60 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b2a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105b2e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b2f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105b33:	50                   	push   %eax
80105b34:	6a 03                	push   $0x3
80105b36:	ff 75 ec             	pushl  -0x14(%ebp)
80105b39:	e8 32 fc ff ff       	call   80105770 <create>
80105b3e:	83 c4 10             	add    $0x10,%esp
80105b41:	85 c0                	test   %eax,%eax
80105b43:	74 1b                	je     80105b60 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b45:	83 ec 0c             	sub    $0xc,%esp
80105b48:	50                   	push   %eax
80105b49:	e8 42 be ff ff       	call   80101990 <iunlockput>
  end_op();
80105b4e:	e8 cd d6 ff ff       	call   80103220 <end_op>
  return 0;
80105b53:	83 c4 10             	add    $0x10,%esp
80105b56:	31 c0                	xor    %eax,%eax
}
80105b58:	c9                   	leave  
80105b59:	c3                   	ret    
80105b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105b60:	e8 bb d6 ff ff       	call   80103220 <end_op>
    return -1;
80105b65:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b6a:	c9                   	leave  
80105b6b:	c3                   	ret    
80105b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b70 <sys_chdir>:

int
sys_chdir(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	56                   	push   %esi
80105b74:	53                   	push   %ebx
80105b75:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b78:	e8 13 e3 ff ff       	call   80103e90 <myproc>
80105b7d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105b7f:	e8 2c d6 ff ff       	call   801031b0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105b84:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b87:	83 ec 08             	sub    $0x8,%esp
80105b8a:	50                   	push   %eax
80105b8b:	6a 00                	push   $0x0
80105b8d:	e8 9e f5 ff ff       	call   80105130 <argstr>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	85 c0                	test   %eax,%eax
80105b97:	78 77                	js     80105c10 <sys_chdir+0xa0>
80105b99:	83 ec 0c             	sub    $0xc,%esp
80105b9c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b9f:	e8 bc c3 ff ff       	call   80101f60 <namei>
80105ba4:	83 c4 10             	add    $0x10,%esp
80105ba7:	85 c0                	test   %eax,%eax
80105ba9:	89 c3                	mov    %eax,%ebx
80105bab:	74 63                	je     80105c10 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105bad:	83 ec 0c             	sub    $0xc,%esp
80105bb0:	50                   	push   %eax
80105bb1:	e8 4a bb ff ff       	call   80101700 <ilock>
  if(ip->type != T_DIR){
80105bb6:	83 c4 10             	add    $0x10,%esp
80105bb9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bbe:	75 30                	jne    80105bf0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105bc0:	83 ec 0c             	sub    $0xc,%esp
80105bc3:	53                   	push   %ebx
80105bc4:	e8 17 bc ff ff       	call   801017e0 <iunlock>
  iput(curproc->cwd);
80105bc9:	58                   	pop    %eax
80105bca:	ff 76 68             	pushl  0x68(%esi)
80105bcd:	e8 5e bc ff ff       	call   80101830 <iput>
  end_op();
80105bd2:	e8 49 d6 ff ff       	call   80103220 <end_op>
  curproc->cwd = ip;
80105bd7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105bda:	83 c4 10             	add    $0x10,%esp
80105bdd:	31 c0                	xor    %eax,%eax
}
80105bdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105be2:	5b                   	pop    %ebx
80105be3:	5e                   	pop    %esi
80105be4:	5d                   	pop    %ebp
80105be5:	c3                   	ret    
80105be6:	8d 76 00             	lea    0x0(%esi),%esi
80105be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105bf0:	83 ec 0c             	sub    $0xc,%esp
80105bf3:	53                   	push   %ebx
80105bf4:	e8 97 bd ff ff       	call   80101990 <iunlockput>
    end_op();
80105bf9:	e8 22 d6 ff ff       	call   80103220 <end_op>
    return -1;
80105bfe:	83 c4 10             	add    $0x10,%esp
80105c01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c06:	eb d7                	jmp    80105bdf <sys_chdir+0x6f>
80105c08:	90                   	nop
80105c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105c10:	e8 0b d6 ff ff       	call   80103220 <end_op>
    return -1;
80105c15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c1a:	eb c3                	jmp    80105bdf <sys_chdir+0x6f>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c20 <sys_exec>:

int
sys_exec(void)
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	57                   	push   %edi
80105c24:	56                   	push   %esi
80105c25:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c26:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105c2c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c32:	50                   	push   %eax
80105c33:	6a 00                	push   $0x0
80105c35:	e8 f6 f4 ff ff       	call   80105130 <argstr>
80105c3a:	83 c4 10             	add    $0x10,%esp
80105c3d:	85 c0                	test   %eax,%eax
80105c3f:	0f 88 87 00 00 00    	js     80105ccc <sys_exec+0xac>
80105c45:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c4b:	83 ec 08             	sub    $0x8,%esp
80105c4e:	50                   	push   %eax
80105c4f:	6a 01                	push   $0x1
80105c51:	e8 2a f4 ff ff       	call   80105080 <argint>
80105c56:	83 c4 10             	add    $0x10,%esp
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	78 6f                	js     80105ccc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c5d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c63:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105c66:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c68:	68 80 00 00 00       	push   $0x80
80105c6d:	6a 00                	push   $0x0
80105c6f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c75:	50                   	push   %eax
80105c76:	e8 05 f1 ff ff       	call   80104d80 <memset>
80105c7b:	83 c4 10             	add    $0x10,%esp
80105c7e:	eb 2c                	jmp    80105cac <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105c80:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c86:	85 c0                	test   %eax,%eax
80105c88:	74 56                	je     80105ce0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c8a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c90:	83 ec 08             	sub    $0x8,%esp
80105c93:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c96:	52                   	push   %edx
80105c97:	50                   	push   %eax
80105c98:	e8 73 f3 ff ff       	call   80105010 <fetchstr>
80105c9d:	83 c4 10             	add    $0x10,%esp
80105ca0:	85 c0                	test   %eax,%eax
80105ca2:	78 28                	js     80105ccc <sys_exec+0xac>
  for(i=0;; i++){
80105ca4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105ca7:	83 fb 20             	cmp    $0x20,%ebx
80105caa:	74 20                	je     80105ccc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105cac:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105cb2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105cb9:	83 ec 08             	sub    $0x8,%esp
80105cbc:	57                   	push   %edi
80105cbd:	01 f0                	add    %esi,%eax
80105cbf:	50                   	push   %eax
80105cc0:	e8 0b f3 ff ff       	call   80104fd0 <fetchint>
80105cc5:	83 c4 10             	add    $0x10,%esp
80105cc8:	85 c0                	test   %eax,%eax
80105cca:	79 b4                	jns    80105c80 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105ccc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cd4:	5b                   	pop    %ebx
80105cd5:	5e                   	pop    %esi
80105cd6:	5f                   	pop    %edi
80105cd7:	5d                   	pop    %ebp
80105cd8:	c3                   	ret    
80105cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ce0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105ce6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105ce9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105cf0:	00 00 00 00 
  return exec(path, argv);
80105cf4:	50                   	push   %eax
80105cf5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105cfb:	e8 10 ad ff ff       	call   80100a10 <exec>
80105d00:	83 c4 10             	add    $0x10,%esp
}
80105d03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d06:	5b                   	pop    %ebx
80105d07:	5e                   	pop    %esi
80105d08:	5f                   	pop    %edi
80105d09:	5d                   	pop    %ebp
80105d0a:	c3                   	ret    
80105d0b:	90                   	nop
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_pipe>:

int
sys_pipe(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d16:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105d19:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d1c:	6a 08                	push   $0x8
80105d1e:	50                   	push   %eax
80105d1f:	6a 00                	push   $0x0
80105d21:	e8 aa f3 ff ff       	call   801050d0 <argptr>
80105d26:	83 c4 10             	add    $0x10,%esp
80105d29:	85 c0                	test   %eax,%eax
80105d2b:	0f 88 ae 00 00 00    	js     80105ddf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105d31:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d34:	83 ec 08             	sub    $0x8,%esp
80105d37:	50                   	push   %eax
80105d38:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d3b:	50                   	push   %eax
80105d3c:	e8 0f db ff ff       	call   80103850 <pipealloc>
80105d41:	83 c4 10             	add    $0x10,%esp
80105d44:	85 c0                	test   %eax,%eax
80105d46:	0f 88 93 00 00 00    	js     80105ddf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d4c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105d4f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d51:	e8 3a e1 ff ff       	call   80103e90 <myproc>
80105d56:	eb 10                	jmp    80105d68 <sys_pipe+0x58>
80105d58:	90                   	nop
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105d60:	83 c3 01             	add    $0x1,%ebx
80105d63:	83 fb 10             	cmp    $0x10,%ebx
80105d66:	74 60                	je     80105dc8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105d68:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d6c:	85 f6                	test   %esi,%esi
80105d6e:	75 f0                	jne    80105d60 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105d70:	8d 73 08             	lea    0x8(%ebx),%esi
80105d73:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d7a:	e8 11 e1 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d7f:	31 d2                	xor    %edx,%edx
80105d81:	eb 0d                	jmp    80105d90 <sys_pipe+0x80>
80105d83:	90                   	nop
80105d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d88:	83 c2 01             	add    $0x1,%edx
80105d8b:	83 fa 10             	cmp    $0x10,%edx
80105d8e:	74 28                	je     80105db8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105d90:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105d94:	85 c9                	test   %ecx,%ecx
80105d96:	75 f0                	jne    80105d88 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105d98:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d9f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105da1:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105da4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105da7:	31 c0                	xor    %eax,%eax
}
80105da9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dac:	5b                   	pop    %ebx
80105dad:	5e                   	pop    %esi
80105dae:	5f                   	pop    %edi
80105daf:	5d                   	pop    %ebp
80105db0:	c3                   	ret    
80105db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105db8:	e8 d3 e0 ff ff       	call   80103e90 <myproc>
80105dbd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105dc4:	00 
80105dc5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105dc8:	83 ec 0c             	sub    $0xc,%esp
80105dcb:	ff 75 e0             	pushl  -0x20(%ebp)
80105dce:	e8 ed b0 ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
80105dd3:	58                   	pop    %eax
80105dd4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105dd7:	e8 e4 b0 ff ff       	call   80100ec0 <fileclose>
    return -1;
80105ddc:	83 c4 10             	add    $0x10,%esp
80105ddf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105de4:	eb c3                	jmp    80105da9 <sys_pipe+0x99>
80105de6:	66 90                	xchg   %ax,%ax
80105de8:	66 90                	xchg   %ax,%ax
80105dea:	66 90                	xchg   %ax,%ax
80105dec:	66 90                	xchg   %ax,%ax
80105dee:	66 90                	xchg   %ax,%ax

80105df0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105df3:	5d                   	pop    %ebp
  return fork();
80105df4:	e9 57 e2 ff ff       	jmp    80104050 <fork>
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <sys_exit>:

int
sys_exit(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	83 ec 08             	sub    $0x8,%esp
  exit();
80105e06:	e8 c5 e5 ff ff       	call   801043d0 <exit>
  return 0;  // not reached
}
80105e0b:	31 c0                	xor    %eax,%eax
80105e0d:	c9                   	leave  
80105e0e:	c3                   	ret    
80105e0f:	90                   	nop

80105e10 <sys_wait>:

int
sys_wait(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105e13:	5d                   	pop    %ebp
  return wait();
80105e14:	e9 27 e8 ff ff       	jmp    80104640 <wait>
80105e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e20 <sys_kill>:

int
sys_kill(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105e26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e29:	50                   	push   %eax
80105e2a:	6a 00                	push   $0x0
80105e2c:	e8 4f f2 ff ff       	call   80105080 <argint>
80105e31:	83 c4 10             	add    $0x10,%esp
80105e34:	85 c0                	test   %eax,%eax
80105e36:	78 18                	js     80105e50 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105e38:	83 ec 0c             	sub    $0xc,%esp
80105e3b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e3e:	e8 5d e9 ff ff       	call   801047a0 <kill>
80105e43:	83 c4 10             	add    $0x10,%esp
}
80105e46:	c9                   	leave  
80105e47:	c3                   	ret    
80105e48:	90                   	nop
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e55:	c9                   	leave  
80105e56:	c3                   	ret    
80105e57:	89 f6                	mov    %esi,%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e60 <sys_getpid>:

int
sys_getpid(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105e66:	e8 25 e0 ff ff       	call   80103e90 <myproc>
80105e6b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105e6e:	c9                   	leave  
80105e6f:	c3                   	ret    

80105e70 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
80105e74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e7a:	50                   	push   %eax
80105e7b:	6a 00                	push   $0x0
80105e7d:	e8 fe f1 ff ff       	call   80105080 <argint>
80105e82:	83 c4 10             	add    $0x10,%esp
80105e85:	85 c0                	test   %eax,%eax
80105e87:	78 27                	js     80105eb0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e89:	e8 02 e0 ff ff       	call   80103e90 <myproc>
  if(growproc(n) < 0)
80105e8e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e91:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e93:	ff 75 f4             	pushl  -0xc(%ebp)
80105e96:	e8 35 e1 ff ff       	call   80103fd0 <growproc>
80105e9b:	83 c4 10             	add    $0x10,%esp
80105e9e:	85 c0                	test   %eax,%eax
80105ea0:	78 0e                	js     80105eb0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105ea2:	89 d8                	mov    %ebx,%eax
80105ea4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ea7:	c9                   	leave  
80105ea8:	c3                   	ret    
80105ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105eb0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105eb5:	eb eb                	jmp    80105ea2 <sys_sbrk+0x32>
80105eb7:	89 f6                	mov    %esi,%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ec0 <sys_sleep>:

int
sys_sleep(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105ec4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ec7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105eca:	50                   	push   %eax
80105ecb:	6a 00                	push   $0x0
80105ecd:	e8 ae f1 ff ff       	call   80105080 <argint>
80105ed2:	83 c4 10             	add    $0x10,%esp
80105ed5:	85 c0                	test   %eax,%eax
80105ed7:	0f 88 8a 00 00 00    	js     80105f67 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105edd:	83 ec 0c             	sub    $0xc,%esp
80105ee0:	68 80 81 15 80       	push   $0x80158180
80105ee5:	e8 86 ed ff ff       	call   80104c70 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105eed:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ef0:	8b 1d c0 89 15 80    	mov    0x801589c0,%ebx
  while(ticks - ticks0 < n){
80105ef6:	85 d2                	test   %edx,%edx
80105ef8:	75 27                	jne    80105f21 <sys_sleep+0x61>
80105efa:	eb 54                	jmp    80105f50 <sys_sleep+0x90>
80105efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105f00:	83 ec 08             	sub    $0x8,%esp
80105f03:	68 80 81 15 80       	push   $0x80158180
80105f08:	68 c0 89 15 80       	push   $0x801589c0
80105f0d:	e8 6e e6 ff ff       	call   80104580 <sleep>
  while(ticks - ticks0 < n){
80105f12:	a1 c0 89 15 80       	mov    0x801589c0,%eax
80105f17:	83 c4 10             	add    $0x10,%esp
80105f1a:	29 d8                	sub    %ebx,%eax
80105f1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f1f:	73 2f                	jae    80105f50 <sys_sleep+0x90>
    if(myproc()->killed){
80105f21:	e8 6a df ff ff       	call   80103e90 <myproc>
80105f26:	8b 40 24             	mov    0x24(%eax),%eax
80105f29:	85 c0                	test   %eax,%eax
80105f2b:	74 d3                	je     80105f00 <sys_sleep+0x40>
      release(&tickslock);
80105f2d:	83 ec 0c             	sub    $0xc,%esp
80105f30:	68 80 81 15 80       	push   $0x80158180
80105f35:	e8 f6 ed ff ff       	call   80104d30 <release>
      return -1;
80105f3a:	83 c4 10             	add    $0x10,%esp
80105f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105f42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f45:	c9                   	leave  
80105f46:	c3                   	ret    
80105f47:	89 f6                	mov    %esi,%esi
80105f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105f50:	83 ec 0c             	sub    $0xc,%esp
80105f53:	68 80 81 15 80       	push   $0x80158180
80105f58:	e8 d3 ed ff ff       	call   80104d30 <release>
  return 0;
80105f5d:	83 c4 10             	add    $0x10,%esp
80105f60:	31 c0                	xor    %eax,%eax
}
80105f62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f65:	c9                   	leave  
80105f66:	c3                   	ret    
    return -1;
80105f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f6c:	eb f4                	jmp    80105f62 <sys_sleep+0xa2>
80105f6e:	66 90                	xchg   %ax,%ax

80105f70 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f70:	55                   	push   %ebp
80105f71:	89 e5                	mov    %esp,%ebp
80105f73:	53                   	push   %ebx
80105f74:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f77:	68 80 81 15 80       	push   $0x80158180
80105f7c:	e8 ef ec ff ff       	call   80104c70 <acquire>
  xticks = ticks;
80105f81:	8b 1d c0 89 15 80    	mov    0x801589c0,%ebx
  release(&tickslock);
80105f87:	c7 04 24 80 81 15 80 	movl   $0x80158180,(%esp)
80105f8e:	e8 9d ed ff ff       	call   80104d30 <release>
  return xticks;
}
80105f93:	89 d8                	mov    %ebx,%eax
80105f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f98:	c9                   	leave  
80105f99:	c3                   	ret    
80105f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fa0 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
  return numFreePages();
80105fa3:	5d                   	pop    %ebp
  return numFreePages();
80105fa4:	e9 47 ca ff ff       	jmp    801029f0 <numFreePages>

80105fa9 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105fa9:	1e                   	push   %ds
  pushl %es
80105faa:	06                   	push   %es
  pushl %fs
80105fab:	0f a0                	push   %fs
  pushl %gs
80105fad:	0f a8                	push   %gs
  pushal
80105faf:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105fb0:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105fb4:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105fb6:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105fb8:	54                   	push   %esp
  call trap
80105fb9:	e8 c2 00 00 00       	call   80106080 <trap>
  addl $4, %esp
80105fbe:	83 c4 04             	add    $0x4,%esp

80105fc1 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105fc1:	61                   	popa   
  popl %gs
80105fc2:	0f a9                	pop    %gs
  popl %fs
80105fc4:	0f a1                	pop    %fs
  popl %es
80105fc6:	07                   	pop    %es
  popl %ds
80105fc7:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105fc8:	83 c4 08             	add    $0x8,%esp
  iret
80105fcb:	cf                   	iret   
80105fcc:	66 90                	xchg   %ax,%ax
80105fce:	66 90                	xchg   %ax,%ax

80105fd0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105fd0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105fd1:	31 c0                	xor    %eax,%eax
{
80105fd3:	89 e5                	mov    %esp,%ebp
80105fd5:	83 ec 08             	sub    $0x8,%esp
80105fd8:	90                   	nop
80105fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105fe0:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80105fe7:	c7 04 c5 c2 81 15 80 	movl   $0x8e000008,-0x7fea7e3e(,%eax,8)
80105fee:	08 00 00 8e 
80105ff2:	66 89 14 c5 c0 81 15 	mov    %dx,-0x7fea7e40(,%eax,8)
80105ff9:	80 
80105ffa:	c1 ea 10             	shr    $0x10,%edx
80105ffd:	66 89 14 c5 c6 81 15 	mov    %dx,-0x7fea7e3a(,%eax,8)
80106004:	80 
  for(i = 0; i < 256; i++)
80106005:	83 c0 01             	add    $0x1,%eax
80106008:	3d 00 01 00 00       	cmp    $0x100,%eax
8010600d:	75 d1                	jne    80105fe0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010600f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106014:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106017:	c7 05 c2 83 15 80 08 	movl   $0xef000008,0x801583c2
8010601e:	00 00 ef 
  initlock(&tickslock, "time");
80106021:	68 99 8d 10 80       	push   $0x80108d99
80106026:	68 80 81 15 80       	push   $0x80158180
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010602b:	66 a3 c0 83 15 80    	mov    %ax,0x801583c0
80106031:	c1 e8 10             	shr    $0x10,%eax
80106034:	66 a3 c6 83 15 80    	mov    %ax,0x801583c6
  initlock(&tickslock, "time");
8010603a:	e8 f1 ea ff ff       	call   80104b30 <initlock>
}
8010603f:	83 c4 10             	add    $0x10,%esp
80106042:	c9                   	leave  
80106043:	c3                   	ret    
80106044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010604a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106050 <idtinit>:

void
idtinit(void)
{
80106050:	55                   	push   %ebp
  pd[0] = size-1;
80106051:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106056:	89 e5                	mov    %esp,%ebp
80106058:	83 ec 10             	sub    $0x10,%esp
8010605b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010605f:	b8 c0 81 15 80       	mov    $0x801581c0,%eax
80106064:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106068:	c1 e8 10             	shr    $0x10,%eax
8010606b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010606f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106072:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106075:	c9                   	leave  
80106076:	c3                   	ret    
80106077:	89 f6                	mov    %esi,%esi
80106079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106080 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
80106085:	53                   	push   %ebx
80106086:	83 ec 1c             	sub    $0x1c,%esp
80106089:	8b 5d 08             	mov    0x8(%ebp),%ebx
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
8010608c:	8b 43 30             	mov    0x30(%ebx),%eax
8010608f:	83 f8 40             	cmp    $0x40,%eax
80106092:	0f 84 f0 00 00 00    	je     80106188 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106098:	83 e8 0e             	sub    $0xe,%eax
8010609b:	83 f8 31             	cmp    $0x31,%eax
8010609e:	77 10                	ja     801060b0 <trap+0x30>
801060a0:	ff 24 85 b0 8e 10 80 	jmp    *-0x7fef7150(,%eax,4)
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi



  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801060b0:	e8 db dd ff ff       	call   80103e90 <myproc>
801060b5:	85 c0                	test   %eax,%eax
801060b7:	8b 7b 38             	mov    0x38(%ebx),%edi
801060ba:	0f 84 2a 03 00 00    	je     801063ea <trap+0x36a>
801060c0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801060c4:	0f 84 20 03 00 00    	je     801063ea <trap+0x36a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801060ca:	0f 20 d1             	mov    %cr2,%ecx
801060cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060d0:	e8 9b dd ff ff       	call   80103e70 <cpuid>
801060d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801060d8:	8b 43 34             	mov    0x34(%ebx),%eax
801060db:	8b 73 30             	mov    0x30(%ebx),%esi
801060de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801060e1:	e8 aa dd ff ff       	call   80103e90 <myproc>
801060e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801060e9:	e8 a2 dd ff ff       	call   80103e90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801060f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801060f4:	51                   	push   %ecx
801060f5:	57                   	push   %edi
801060f6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801060f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060fa:	ff 75 e4             	pushl  -0x1c(%ebp)
801060fd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801060fe:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106101:	52                   	push   %edx
80106102:	ff 70 10             	pushl  0x10(%eax)
80106105:	68 6c 8e 10 80       	push   $0x80108e6c
8010610a:	e8 51 a5 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010610f:	83 c4 20             	add    $0x20,%esp
80106112:	e8 79 dd ff ff       	call   80103e90 <myproc>
80106117:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010611e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106120:	e8 6b dd ff ff       	call   80103e90 <myproc>
80106125:	85 c0                	test   %eax,%eax
80106127:	74 1d                	je     80106146 <trap+0xc6>
80106129:	e8 62 dd ff ff       	call   80103e90 <myproc>
8010612e:	8b 50 24             	mov    0x24(%eax),%edx
80106131:	85 d2                	test   %edx,%edx
80106133:	74 11                	je     80106146 <trap+0xc6>
80106135:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106139:	83 e0 03             	and    $0x3,%eax
8010613c:	66 83 f8 03          	cmp    $0x3,%ax
80106140:	0f 84 ba 01 00 00    	je     80106300 <trap+0x280>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106146:	e8 45 dd ff ff       	call   80103e90 <myproc>
8010614b:	85 c0                	test   %eax,%eax
8010614d:	74 0b                	je     8010615a <trap+0xda>
8010614f:	e8 3c dd ff ff       	call   80103e90 <myproc>
80106154:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106158:	74 66                	je     801061c0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010615a:	e8 31 dd ff ff       	call   80103e90 <myproc>
8010615f:	85 c0                	test   %eax,%eax
80106161:	74 19                	je     8010617c <trap+0xfc>
80106163:	e8 28 dd ff ff       	call   80103e90 <myproc>
80106168:	8b 40 24             	mov    0x24(%eax),%eax
8010616b:	85 c0                	test   %eax,%eax
8010616d:	74 0d                	je     8010617c <trap+0xfc>
8010616f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106173:	83 e0 03             	and    $0x3,%eax
80106176:	66 83 f8 03          	cmp    $0x3,%ax
8010617a:	74 35                	je     801061b1 <trap+0x131>
    exit();
}
8010617c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010617f:	5b                   	pop    %ebx
80106180:	5e                   	pop    %esi
80106181:	5f                   	pop    %edi
80106182:	5d                   	pop    %ebp
80106183:	c3                   	ret    
80106184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106188:	e8 03 dd ff ff       	call   80103e90 <myproc>
8010618d:	8b 40 24             	mov    0x24(%eax),%eax
80106190:	85 c0                	test   %eax,%eax
80106192:	0f 85 58 01 00 00    	jne    801062f0 <trap+0x270>
    myproc()->tf = tf;
80106198:	e8 f3 dc ff ff       	call   80103e90 <myproc>
8010619d:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801061a0:	e8 cb ef ff ff       	call   80105170 <syscall>
    if(myproc()->killed)
801061a5:	e8 e6 dc ff ff       	call   80103e90 <myproc>
801061aa:	8b 78 24             	mov    0x24(%eax),%edi
801061ad:	85 ff                	test   %edi,%edi
801061af:	74 cb                	je     8010617c <trap+0xfc>
}
801061b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061b4:	5b                   	pop    %ebx
801061b5:	5e                   	pop    %esi
801061b6:	5f                   	pop    %edi
801061b7:	5d                   	pop    %ebp
      exit();
801061b8:	e9 13 e2 ff ff       	jmp    801043d0 <exit>
801061bd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801061c0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801061c4:	75 94                	jne    8010615a <trap+0xda>
    yield();
801061c6:	e8 65 e3 ff ff       	call   80104530 <yield>
801061cb:	eb 8d                	jmp    8010615a <trap+0xda>
801061cd:	8d 76 00             	lea    0x0(%esi),%esi
        nfuaTickUpdate();
801061d0:	e8 1b e7 ff ff       	call   801048f0 <nfuaTickUpdate>
801061d5:	0f 20 d6             	mov    %cr2,%esi
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061d8:	e8 b3 dc ff ff       	call   80103e90 <myproc>
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061dd:	8b 40 04             	mov    0x4(%eax),%eax
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061e0:	89 f2                	mov    %esi,%edx
      uint refCount = getReferenceCount(pa);
801061e2:	83 ec 0c             	sub    $0xc,%esp
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061e5:	c1 ea 16             	shr    $0x16,%edx
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061e8:	8b 14 90             	mov    (%eax,%edx,4),%edx
      pte_t *pte = &pgtab[PTX(addr)];
801061eb:	89 f0                	mov    %esi,%eax
801061ed:	c1 e8 0a             	shr    $0xa,%eax
801061f0:	25 fc 0f 00 00       	and    $0xffc,%eax
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061f5:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
      pte_t *pte = &pgtab[PTX(addr)];
801061fb:	8d bc 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edi
      uint pa = PTE_ADDR(*pte);
80106202:	8b 07                	mov    (%edi),%eax
80106204:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      uint refCount = getReferenceCount(pa);
80106209:	50                   	push   %eax
      uint pa = PTE_ADDR(*pte);
8010620a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      uint refCount = getReferenceCount(pa);
8010620d:	e8 de c8 ff ff       	call   80102af0 <getReferenceCount>
      if((*pte & PTE_PG ) != 0){
80106212:	8b 17                	mov    (%edi),%edx
80106214:	83 c4 10             	add    $0x10,%esp
80106217:	f6 c6 02             	test   $0x2,%dh
8010621a:	0f 85 80 01 00 00    	jne    801063a0 <trap+0x320>
      }else if(((*pte & PTE_W) == 0) && ((*pte & PTE_U) != 0)){
80106220:	89 d1                	mov    %edx,%ecx
80106222:	83 e1 06             	and    $0x6,%ecx
80106225:	83 f9 04             	cmp    $0x4,%ecx
80106228:	0f 85 e4 01 00 00    	jne    80106412 <trap+0x392>
        if(refCount > 1) {
8010622e:	83 f8 01             	cmp    $0x1,%eax
80106231:	0f 87 d9 00 00 00    	ja     80106310 <trap+0x290>
        else if(refCount == 1){
80106237:	0f 85 f5 01 00 00    	jne    80106432 <trap+0x3b2>
          *pte |= PTE_W;
8010623d:	83 ca 02             	or     $0x2,%edx
80106240:	89 17                	mov    %edx,(%edi)
      lcr3(V2P(myproc()->pgdir));
80106242:	e8 49 dc ff ff       	call   80103e90 <myproc>
80106247:	8b 40 04             	mov    0x4(%eax),%eax
8010624a:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010624f:	0f 22 d8             	mov    %eax,%cr3
80106252:	e9 c9 fe ff ff       	jmp    80106120 <trap+0xa0>
80106257:	89 f6                	mov    %esi,%esi
80106259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(cpuid() == 0){
80106260:	e8 0b dc ff ff       	call   80103e70 <cpuid>
80106265:	85 c0                	test   %eax,%eax
80106267:	0f 84 fb 00 00 00    	je     80106368 <trap+0x2e8>
    lapiceoi();
8010626d:	e8 ee ca ff ff       	call   80102d60 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106272:	e8 19 dc ff ff       	call   80103e90 <myproc>
80106277:	85 c0                	test   %eax,%eax
80106279:	0f 85 aa fe ff ff    	jne    80106129 <trap+0xa9>
8010627f:	e9 c2 fe ff ff       	jmp    80106146 <trap+0xc6>
80106284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106288:	e8 93 c9 ff ff       	call   80102c20 <kbdintr>
    lapiceoi();
8010628d:	e8 ce ca ff ff       	call   80102d60 <lapiceoi>
    break;
80106292:	e9 89 fe ff ff       	jmp    80106120 <trap+0xa0>
80106297:	89 f6                	mov    %esi,%esi
80106299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
801062a0:	e8 1b 03 00 00       	call   801065c0 <uartintr>
    lapiceoi();
801062a5:	e8 b6 ca ff ff       	call   80102d60 <lapiceoi>
    break;
801062aa:	e9 71 fe ff ff       	jmp    80106120 <trap+0xa0>
801062af:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062b0:	0f b7 7b 3c          	movzwl 0x3c(%ebx),%edi
801062b4:	8b 73 38             	mov    0x38(%ebx),%esi
801062b7:	e8 b4 db ff ff       	call   80103e70 <cpuid>
801062bc:	56                   	push   %esi
801062bd:	57                   	push   %edi
801062be:	50                   	push   %eax
801062bf:	68 e0 8d 10 80       	push   $0x80108de0
801062c4:	e8 97 a3 ff ff       	call   80100660 <cprintf>
    lapiceoi();
801062c9:	e8 92 ca ff ff       	call   80102d60 <lapiceoi>
    break;
801062ce:	83 c4 10             	add    $0x10,%esp
801062d1:	e9 4a fe ff ff       	jmp    80106120 <trap+0xa0>
801062d6:	8d 76 00             	lea    0x0(%esi),%esi
801062d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
801062e0:	e8 ab c1 ff ff       	call   80102490 <ideintr>
801062e5:	eb 86                	jmp    8010626d <trap+0x1ed>
801062e7:	89 f6                	mov    %esi,%esi
801062e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
801062f0:	e8 db e0 ff ff       	call   801043d0 <exit>
801062f5:	e9 9e fe ff ff       	jmp    80106198 <trap+0x118>
801062fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106300:	e8 cb e0 ff ff       	call   801043d0 <exit>
80106305:	e9 3c fe ff ff       	jmp    80106146 <trap+0xc6>
8010630a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          if((mem = kalloc()) == 0) {
80106310:	e8 4b c6 ff ff       	call   80102960 <kalloc>
80106315:	85 c0                	test   %eax,%eax
80106317:	89 c6                	mov    %eax,%esi
80106319:	0f 84 98 00 00 00    	je     801063b7 <trap+0x337>
          memmove(mem, (char*)P2V(pa), PGSIZE);
8010631f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106322:	83 ec 04             	sub    $0x4,%esp
80106325:	68 00 10 00 00       	push   $0x1000
8010632a:	05 00 00 00 80       	add    $0x80000000,%eax
8010632f:	50                   	push   %eax
80106330:	56                   	push   %esi
          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;
80106331:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106337:	83 ce 07             	or     $0x7,%esi
          memmove(mem, (char*)P2V(pa), PGSIZE);
8010633a:	e8 f1 ea ff ff       	call   80104e30 <memmove>
          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;
8010633f:	89 37                	mov    %esi,(%edi)
          decrementReferenceCount(pa);
80106341:	5e                   	pop    %esi
80106342:	ff 75 e4             	pushl  -0x1c(%ebp)
80106345:	e8 f6 c6 ff ff       	call   80102a40 <decrementReferenceCount>
          lcr3(V2P(myproc()->pgdir));
8010634a:	e8 41 db ff ff       	call   80103e90 <myproc>
8010634f:	8b 40 04             	mov    0x4(%eax),%eax
80106352:	05 00 00 00 80       	add    $0x80000000,%eax
80106357:	0f 22 d8             	mov    %eax,%cr3
8010635a:	83 c4 10             	add    $0x10,%esp
8010635d:	e9 e0 fe ff ff       	jmp    80106242 <trap+0x1c2>
80106362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106368:	83 ec 0c             	sub    $0xc,%esp
8010636b:	68 80 81 15 80       	push   $0x80158180
80106370:	e8 fb e8 ff ff       	call   80104c70 <acquire>
      wakeup(&ticks);
80106375:	c7 04 24 c0 89 15 80 	movl   $0x801589c0,(%esp)
      ticks++;
8010637c:	83 05 c0 89 15 80 01 	addl   $0x1,0x801589c0
      wakeup(&ticks);
80106383:	e8 b8 e3 ff ff       	call   80104740 <wakeup>
      release(&tickslock);
80106388:	c7 04 24 80 81 15 80 	movl   $0x80158180,(%esp)
8010638f:	e8 9c e9 ff ff       	call   80104d30 <release>
80106394:	83 c4 10             	add    $0x10,%esp
80106397:	e9 d1 fe ff ff       	jmp    8010626d <trap+0x1ed>
8010639c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        swapPage(PTE_ADDR(addr));
801063a0:	83 ec 0c             	sub    $0xc,%esp
801063a3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801063a9:	56                   	push   %esi
801063aa:	e8 31 1f 00 00       	call   801082e0 <swapPage>
        break;
801063af:	83 c4 10             	add    $0x10,%esp
801063b2:	e9 69 fd ff ff       	jmp    80106120 <trap+0xa0>
            cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
801063b7:	e8 d4 da ff ff       	call   80103e90 <myproc>
801063bc:	8b 58 10             	mov    0x10(%eax),%ebx
801063bf:	e8 cc da ff ff       	call   80103e90 <myproc>
801063c4:	83 ec 04             	sub    $0x4,%esp
801063c7:	83 c0 6c             	add    $0x6c,%eax
801063ca:	53                   	push   %ebx
801063cb:	50                   	push   %eax
801063cc:	68 04 8e 10 80       	push   $0x80108e04
801063d1:	e8 8a a2 ff ff       	call   80100660 <cprintf>
            myproc()->killed = 1;
801063d6:	e8 b5 da ff ff       	call   80103e90 <myproc>
            return;
801063db:	83 c4 10             	add    $0x10,%esp
            myproc()->killed = 1;
801063de:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            return;
801063e5:	e9 92 fd ff ff       	jmp    8010617c <trap+0xfc>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801063ea:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801063ed:	e8 7e da ff ff       	call   80103e70 <cpuid>
801063f2:	83 ec 0c             	sub    $0xc,%esp
801063f5:	56                   	push   %esi
801063f6:	57                   	push   %edi
801063f7:	50                   	push   %eax
801063f8:	ff 73 30             	pushl  0x30(%ebx)
801063fb:	68 38 8e 10 80       	push   $0x80108e38
80106400:	e8 5b a2 ff ff       	call   80100660 <cprintf>
      panic("trap");
80106405:	83 c4 14             	add    $0x14,%esp
80106408:	68 d9 8d 10 80       	push   $0x80108dd9
8010640d:	e8 7e 9f ff ff       	call   80100390 <panic>
        cprintf("pid: %d\n",myproc()->pid);
80106412:	e8 79 da ff ff       	call   80103e90 <myproc>
80106417:	51                   	push   %ecx
80106418:	51                   	push   %ecx
80106419:	ff 70 10             	pushl  0x10(%eax)
8010641c:	68 c1 8d 10 80       	push   $0x80108dc1
80106421:	e8 3a a2 ff ff       	call   80100660 <cprintf>
        panic("trap: PF fault");
80106426:	c7 04 24 ca 8d 10 80 	movl   $0x80108dca,(%esp)
8010642d:	e8 5e 9f ff ff       	call   80100390 <panic>
          cprintf("count: %d\n",refCount);
80106432:	53                   	push   %ebx
80106433:	53                   	push   %ebx
80106434:	6a 00                	push   $0x0
80106436:	68 9e 8d 10 80       	push   $0x80108d9e
8010643b:	e8 20 a2 ff ff       	call   80100660 <cprintf>
          panic("trap PTE_W : recCount<1");
80106440:	c7 04 24 a9 8d 10 80 	movl   $0x80108da9,(%esp)
80106447:	e8 44 9f ff ff       	call   80100390 <panic>
8010644c:	66 90                	xchg   %ax,%ax
8010644e:	66 90                	xchg   %ax,%ax

80106450 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106450:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
80106455:	55                   	push   %ebp
80106456:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106458:	85 c0                	test   %eax,%eax
8010645a:	74 1c                	je     80106478 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010645c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106461:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106462:	a8 01                	test   $0x1,%al
80106464:	74 12                	je     80106478 <uartgetc+0x28>
80106466:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010646b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010646c:	0f b6 c0             	movzbl %al,%eax
}
8010646f:	5d                   	pop    %ebp
80106470:	c3                   	ret    
80106471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106478:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010647d:	5d                   	pop    %ebp
8010647e:	c3                   	ret    
8010647f:	90                   	nop

80106480 <uartputc.part.0>:
uartputc(int c)
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	57                   	push   %edi
80106484:	56                   	push   %esi
80106485:	53                   	push   %ebx
80106486:	89 c7                	mov    %eax,%edi
80106488:	bb 80 00 00 00       	mov    $0x80,%ebx
8010648d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106492:	83 ec 0c             	sub    $0xc,%esp
80106495:	eb 1b                	jmp    801064b2 <uartputc.part.0+0x32>
80106497:	89 f6                	mov    %esi,%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
801064a0:	83 ec 0c             	sub    $0xc,%esp
801064a3:	6a 0a                	push   $0xa
801064a5:	e8 d6 c8 ff ff       	call   80102d80 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801064aa:	83 c4 10             	add    $0x10,%esp
801064ad:	83 eb 01             	sub    $0x1,%ebx
801064b0:	74 07                	je     801064b9 <uartputc.part.0+0x39>
801064b2:	89 f2                	mov    %esi,%edx
801064b4:	ec                   	in     (%dx),%al
801064b5:	a8 20                	test   $0x20,%al
801064b7:	74 e7                	je     801064a0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801064b9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064be:	89 f8                	mov    %edi,%eax
801064c0:	ee                   	out    %al,(%dx)
}
801064c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064c4:	5b                   	pop    %ebx
801064c5:	5e                   	pop    %esi
801064c6:	5f                   	pop    %edi
801064c7:	5d                   	pop    %ebp
801064c8:	c3                   	ret    
801064c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064d0 <uartinit>:
{
801064d0:	55                   	push   %ebp
801064d1:	31 c9                	xor    %ecx,%ecx
801064d3:	89 c8                	mov    %ecx,%eax
801064d5:	89 e5                	mov    %esp,%ebp
801064d7:	57                   	push   %edi
801064d8:	56                   	push   %esi
801064d9:	53                   	push   %ebx
801064da:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801064df:	89 da                	mov    %ebx,%edx
801064e1:	83 ec 0c             	sub    $0xc,%esp
801064e4:	ee                   	out    %al,(%dx)
801064e5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801064ea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801064ef:	89 fa                	mov    %edi,%edx
801064f1:	ee                   	out    %al,(%dx)
801064f2:	b8 0c 00 00 00       	mov    $0xc,%eax
801064f7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064fc:	ee                   	out    %al,(%dx)
801064fd:	be f9 03 00 00       	mov    $0x3f9,%esi
80106502:	89 c8                	mov    %ecx,%eax
80106504:	89 f2                	mov    %esi,%edx
80106506:	ee                   	out    %al,(%dx)
80106507:	b8 03 00 00 00       	mov    $0x3,%eax
8010650c:	89 fa                	mov    %edi,%edx
8010650e:	ee                   	out    %al,(%dx)
8010650f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106514:	89 c8                	mov    %ecx,%eax
80106516:	ee                   	out    %al,(%dx)
80106517:	b8 01 00 00 00       	mov    $0x1,%eax
8010651c:	89 f2                	mov    %esi,%edx
8010651e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010651f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106524:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106525:	3c ff                	cmp    $0xff,%al
80106527:	74 5a                	je     80106583 <uartinit+0xb3>
  uart = 1;
80106529:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
80106530:	00 00 00 
80106533:	89 da                	mov    %ebx,%edx
80106535:	ec                   	in     (%dx),%al
80106536:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010653b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010653c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010653f:	bb 78 8f 10 80       	mov    $0x80108f78,%ebx
  ioapicenable(IRQ_COM1, 0);
80106544:	6a 00                	push   $0x0
80106546:	6a 04                	push   $0x4
80106548:	e8 93 c1 ff ff       	call   801026e0 <ioapicenable>
8010654d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106550:	b8 78 00 00 00       	mov    $0x78,%eax
80106555:	eb 13                	jmp    8010656a <uartinit+0x9a>
80106557:	89 f6                	mov    %esi,%esi
80106559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106560:	83 c3 01             	add    $0x1,%ebx
80106563:	0f be 03             	movsbl (%ebx),%eax
80106566:	84 c0                	test   %al,%al
80106568:	74 19                	je     80106583 <uartinit+0xb3>
  if(!uart)
8010656a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80106570:	85 d2                	test   %edx,%edx
80106572:	74 ec                	je     80106560 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106574:	83 c3 01             	add    $0x1,%ebx
80106577:	e8 04 ff ff ff       	call   80106480 <uartputc.part.0>
8010657c:	0f be 03             	movsbl (%ebx),%eax
8010657f:	84 c0                	test   %al,%al
80106581:	75 e7                	jne    8010656a <uartinit+0x9a>
}
80106583:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106586:	5b                   	pop    %ebx
80106587:	5e                   	pop    %esi
80106588:	5f                   	pop    %edi
80106589:	5d                   	pop    %ebp
8010658a:	c3                   	ret    
8010658b:	90                   	nop
8010658c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106590 <uartputc>:
  if(!uart)
80106590:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
{
80106596:	55                   	push   %ebp
80106597:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106599:	85 d2                	test   %edx,%edx
{
8010659b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010659e:	74 10                	je     801065b0 <uartputc+0x20>
}
801065a0:	5d                   	pop    %ebp
801065a1:	e9 da fe ff ff       	jmp    80106480 <uartputc.part.0>
801065a6:	8d 76 00             	lea    0x0(%esi),%esi
801065a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801065b0:	5d                   	pop    %ebp
801065b1:	c3                   	ret    
801065b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065c0 <uartintr>:

void
uartintr(void)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801065c6:	68 50 64 10 80       	push   $0x80106450
801065cb:	e8 40 a2 ff ff       	call   80100810 <consoleintr>
}
801065d0:	83 c4 10             	add    $0x10,%esp
801065d3:	c9                   	leave  
801065d4:	c3                   	ret    

801065d5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801065d5:	6a 00                	push   $0x0
  pushl $0
801065d7:	6a 00                	push   $0x0
  jmp alltraps
801065d9:	e9 cb f9 ff ff       	jmp    80105fa9 <alltraps>

801065de <vector1>:
.globl vector1
vector1:
  pushl $0
801065de:	6a 00                	push   $0x0
  pushl $1
801065e0:	6a 01                	push   $0x1
  jmp alltraps
801065e2:	e9 c2 f9 ff ff       	jmp    80105fa9 <alltraps>

801065e7 <vector2>:
.globl vector2
vector2:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $2
801065e9:	6a 02                	push   $0x2
  jmp alltraps
801065eb:	e9 b9 f9 ff ff       	jmp    80105fa9 <alltraps>

801065f0 <vector3>:
.globl vector3
vector3:
  pushl $0
801065f0:	6a 00                	push   $0x0
  pushl $3
801065f2:	6a 03                	push   $0x3
  jmp alltraps
801065f4:	e9 b0 f9 ff ff       	jmp    80105fa9 <alltraps>

801065f9 <vector4>:
.globl vector4
vector4:
  pushl $0
801065f9:	6a 00                	push   $0x0
  pushl $4
801065fb:	6a 04                	push   $0x4
  jmp alltraps
801065fd:	e9 a7 f9 ff ff       	jmp    80105fa9 <alltraps>

80106602 <vector5>:
.globl vector5
vector5:
  pushl $0
80106602:	6a 00                	push   $0x0
  pushl $5
80106604:	6a 05                	push   $0x5
  jmp alltraps
80106606:	e9 9e f9 ff ff       	jmp    80105fa9 <alltraps>

8010660b <vector6>:
.globl vector6
vector6:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $6
8010660d:	6a 06                	push   $0x6
  jmp alltraps
8010660f:	e9 95 f9 ff ff       	jmp    80105fa9 <alltraps>

80106614 <vector7>:
.globl vector7
vector7:
  pushl $0
80106614:	6a 00                	push   $0x0
  pushl $7
80106616:	6a 07                	push   $0x7
  jmp alltraps
80106618:	e9 8c f9 ff ff       	jmp    80105fa9 <alltraps>

8010661d <vector8>:
.globl vector8
vector8:
  pushl $8
8010661d:	6a 08                	push   $0x8
  jmp alltraps
8010661f:	e9 85 f9 ff ff       	jmp    80105fa9 <alltraps>

80106624 <vector9>:
.globl vector9
vector9:
  pushl $0
80106624:	6a 00                	push   $0x0
  pushl $9
80106626:	6a 09                	push   $0x9
  jmp alltraps
80106628:	e9 7c f9 ff ff       	jmp    80105fa9 <alltraps>

8010662d <vector10>:
.globl vector10
vector10:
  pushl $10
8010662d:	6a 0a                	push   $0xa
  jmp alltraps
8010662f:	e9 75 f9 ff ff       	jmp    80105fa9 <alltraps>

80106634 <vector11>:
.globl vector11
vector11:
  pushl $11
80106634:	6a 0b                	push   $0xb
  jmp alltraps
80106636:	e9 6e f9 ff ff       	jmp    80105fa9 <alltraps>

8010663b <vector12>:
.globl vector12
vector12:
  pushl $12
8010663b:	6a 0c                	push   $0xc
  jmp alltraps
8010663d:	e9 67 f9 ff ff       	jmp    80105fa9 <alltraps>

80106642 <vector13>:
.globl vector13
vector13:
  pushl $13
80106642:	6a 0d                	push   $0xd
  jmp alltraps
80106644:	e9 60 f9 ff ff       	jmp    80105fa9 <alltraps>

80106649 <vector14>:
.globl vector14
vector14:
  pushl $14
80106649:	6a 0e                	push   $0xe
  jmp alltraps
8010664b:	e9 59 f9 ff ff       	jmp    80105fa9 <alltraps>

80106650 <vector15>:
.globl vector15
vector15:
  pushl $0
80106650:	6a 00                	push   $0x0
  pushl $15
80106652:	6a 0f                	push   $0xf
  jmp alltraps
80106654:	e9 50 f9 ff ff       	jmp    80105fa9 <alltraps>

80106659 <vector16>:
.globl vector16
vector16:
  pushl $0
80106659:	6a 00                	push   $0x0
  pushl $16
8010665b:	6a 10                	push   $0x10
  jmp alltraps
8010665d:	e9 47 f9 ff ff       	jmp    80105fa9 <alltraps>

80106662 <vector17>:
.globl vector17
vector17:
  pushl $17
80106662:	6a 11                	push   $0x11
  jmp alltraps
80106664:	e9 40 f9 ff ff       	jmp    80105fa9 <alltraps>

80106669 <vector18>:
.globl vector18
vector18:
  pushl $0
80106669:	6a 00                	push   $0x0
  pushl $18
8010666b:	6a 12                	push   $0x12
  jmp alltraps
8010666d:	e9 37 f9 ff ff       	jmp    80105fa9 <alltraps>

80106672 <vector19>:
.globl vector19
vector19:
  pushl $0
80106672:	6a 00                	push   $0x0
  pushl $19
80106674:	6a 13                	push   $0x13
  jmp alltraps
80106676:	e9 2e f9 ff ff       	jmp    80105fa9 <alltraps>

8010667b <vector20>:
.globl vector20
vector20:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $20
8010667d:	6a 14                	push   $0x14
  jmp alltraps
8010667f:	e9 25 f9 ff ff       	jmp    80105fa9 <alltraps>

80106684 <vector21>:
.globl vector21
vector21:
  pushl $0
80106684:	6a 00                	push   $0x0
  pushl $21
80106686:	6a 15                	push   $0x15
  jmp alltraps
80106688:	e9 1c f9 ff ff       	jmp    80105fa9 <alltraps>

8010668d <vector22>:
.globl vector22
vector22:
  pushl $0
8010668d:	6a 00                	push   $0x0
  pushl $22
8010668f:	6a 16                	push   $0x16
  jmp alltraps
80106691:	e9 13 f9 ff ff       	jmp    80105fa9 <alltraps>

80106696 <vector23>:
.globl vector23
vector23:
  pushl $0
80106696:	6a 00                	push   $0x0
  pushl $23
80106698:	6a 17                	push   $0x17
  jmp alltraps
8010669a:	e9 0a f9 ff ff       	jmp    80105fa9 <alltraps>

8010669f <vector24>:
.globl vector24
vector24:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $24
801066a1:	6a 18                	push   $0x18
  jmp alltraps
801066a3:	e9 01 f9 ff ff       	jmp    80105fa9 <alltraps>

801066a8 <vector25>:
.globl vector25
vector25:
  pushl $0
801066a8:	6a 00                	push   $0x0
  pushl $25
801066aa:	6a 19                	push   $0x19
  jmp alltraps
801066ac:	e9 f8 f8 ff ff       	jmp    80105fa9 <alltraps>

801066b1 <vector26>:
.globl vector26
vector26:
  pushl $0
801066b1:	6a 00                	push   $0x0
  pushl $26
801066b3:	6a 1a                	push   $0x1a
  jmp alltraps
801066b5:	e9 ef f8 ff ff       	jmp    80105fa9 <alltraps>

801066ba <vector27>:
.globl vector27
vector27:
  pushl $0
801066ba:	6a 00                	push   $0x0
  pushl $27
801066bc:	6a 1b                	push   $0x1b
  jmp alltraps
801066be:	e9 e6 f8 ff ff       	jmp    80105fa9 <alltraps>

801066c3 <vector28>:
.globl vector28
vector28:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $28
801066c5:	6a 1c                	push   $0x1c
  jmp alltraps
801066c7:	e9 dd f8 ff ff       	jmp    80105fa9 <alltraps>

801066cc <vector29>:
.globl vector29
vector29:
  pushl $0
801066cc:	6a 00                	push   $0x0
  pushl $29
801066ce:	6a 1d                	push   $0x1d
  jmp alltraps
801066d0:	e9 d4 f8 ff ff       	jmp    80105fa9 <alltraps>

801066d5 <vector30>:
.globl vector30
vector30:
  pushl $0
801066d5:	6a 00                	push   $0x0
  pushl $30
801066d7:	6a 1e                	push   $0x1e
  jmp alltraps
801066d9:	e9 cb f8 ff ff       	jmp    80105fa9 <alltraps>

801066de <vector31>:
.globl vector31
vector31:
  pushl $0
801066de:	6a 00                	push   $0x0
  pushl $31
801066e0:	6a 1f                	push   $0x1f
  jmp alltraps
801066e2:	e9 c2 f8 ff ff       	jmp    80105fa9 <alltraps>

801066e7 <vector32>:
.globl vector32
vector32:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $32
801066e9:	6a 20                	push   $0x20
  jmp alltraps
801066eb:	e9 b9 f8 ff ff       	jmp    80105fa9 <alltraps>

801066f0 <vector33>:
.globl vector33
vector33:
  pushl $0
801066f0:	6a 00                	push   $0x0
  pushl $33
801066f2:	6a 21                	push   $0x21
  jmp alltraps
801066f4:	e9 b0 f8 ff ff       	jmp    80105fa9 <alltraps>

801066f9 <vector34>:
.globl vector34
vector34:
  pushl $0
801066f9:	6a 00                	push   $0x0
  pushl $34
801066fb:	6a 22                	push   $0x22
  jmp alltraps
801066fd:	e9 a7 f8 ff ff       	jmp    80105fa9 <alltraps>

80106702 <vector35>:
.globl vector35
vector35:
  pushl $0
80106702:	6a 00                	push   $0x0
  pushl $35
80106704:	6a 23                	push   $0x23
  jmp alltraps
80106706:	e9 9e f8 ff ff       	jmp    80105fa9 <alltraps>

8010670b <vector36>:
.globl vector36
vector36:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $36
8010670d:	6a 24                	push   $0x24
  jmp alltraps
8010670f:	e9 95 f8 ff ff       	jmp    80105fa9 <alltraps>

80106714 <vector37>:
.globl vector37
vector37:
  pushl $0
80106714:	6a 00                	push   $0x0
  pushl $37
80106716:	6a 25                	push   $0x25
  jmp alltraps
80106718:	e9 8c f8 ff ff       	jmp    80105fa9 <alltraps>

8010671d <vector38>:
.globl vector38
vector38:
  pushl $0
8010671d:	6a 00                	push   $0x0
  pushl $38
8010671f:	6a 26                	push   $0x26
  jmp alltraps
80106721:	e9 83 f8 ff ff       	jmp    80105fa9 <alltraps>

80106726 <vector39>:
.globl vector39
vector39:
  pushl $0
80106726:	6a 00                	push   $0x0
  pushl $39
80106728:	6a 27                	push   $0x27
  jmp alltraps
8010672a:	e9 7a f8 ff ff       	jmp    80105fa9 <alltraps>

8010672f <vector40>:
.globl vector40
vector40:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $40
80106731:	6a 28                	push   $0x28
  jmp alltraps
80106733:	e9 71 f8 ff ff       	jmp    80105fa9 <alltraps>

80106738 <vector41>:
.globl vector41
vector41:
  pushl $0
80106738:	6a 00                	push   $0x0
  pushl $41
8010673a:	6a 29                	push   $0x29
  jmp alltraps
8010673c:	e9 68 f8 ff ff       	jmp    80105fa9 <alltraps>

80106741 <vector42>:
.globl vector42
vector42:
  pushl $0
80106741:	6a 00                	push   $0x0
  pushl $42
80106743:	6a 2a                	push   $0x2a
  jmp alltraps
80106745:	e9 5f f8 ff ff       	jmp    80105fa9 <alltraps>

8010674a <vector43>:
.globl vector43
vector43:
  pushl $0
8010674a:	6a 00                	push   $0x0
  pushl $43
8010674c:	6a 2b                	push   $0x2b
  jmp alltraps
8010674e:	e9 56 f8 ff ff       	jmp    80105fa9 <alltraps>

80106753 <vector44>:
.globl vector44
vector44:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $44
80106755:	6a 2c                	push   $0x2c
  jmp alltraps
80106757:	e9 4d f8 ff ff       	jmp    80105fa9 <alltraps>

8010675c <vector45>:
.globl vector45
vector45:
  pushl $0
8010675c:	6a 00                	push   $0x0
  pushl $45
8010675e:	6a 2d                	push   $0x2d
  jmp alltraps
80106760:	e9 44 f8 ff ff       	jmp    80105fa9 <alltraps>

80106765 <vector46>:
.globl vector46
vector46:
  pushl $0
80106765:	6a 00                	push   $0x0
  pushl $46
80106767:	6a 2e                	push   $0x2e
  jmp alltraps
80106769:	e9 3b f8 ff ff       	jmp    80105fa9 <alltraps>

8010676e <vector47>:
.globl vector47
vector47:
  pushl $0
8010676e:	6a 00                	push   $0x0
  pushl $47
80106770:	6a 2f                	push   $0x2f
  jmp alltraps
80106772:	e9 32 f8 ff ff       	jmp    80105fa9 <alltraps>

80106777 <vector48>:
.globl vector48
vector48:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $48
80106779:	6a 30                	push   $0x30
  jmp alltraps
8010677b:	e9 29 f8 ff ff       	jmp    80105fa9 <alltraps>

80106780 <vector49>:
.globl vector49
vector49:
  pushl $0
80106780:	6a 00                	push   $0x0
  pushl $49
80106782:	6a 31                	push   $0x31
  jmp alltraps
80106784:	e9 20 f8 ff ff       	jmp    80105fa9 <alltraps>

80106789 <vector50>:
.globl vector50
vector50:
  pushl $0
80106789:	6a 00                	push   $0x0
  pushl $50
8010678b:	6a 32                	push   $0x32
  jmp alltraps
8010678d:	e9 17 f8 ff ff       	jmp    80105fa9 <alltraps>

80106792 <vector51>:
.globl vector51
vector51:
  pushl $0
80106792:	6a 00                	push   $0x0
  pushl $51
80106794:	6a 33                	push   $0x33
  jmp alltraps
80106796:	e9 0e f8 ff ff       	jmp    80105fa9 <alltraps>

8010679b <vector52>:
.globl vector52
vector52:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $52
8010679d:	6a 34                	push   $0x34
  jmp alltraps
8010679f:	e9 05 f8 ff ff       	jmp    80105fa9 <alltraps>

801067a4 <vector53>:
.globl vector53
vector53:
  pushl $0
801067a4:	6a 00                	push   $0x0
  pushl $53
801067a6:	6a 35                	push   $0x35
  jmp alltraps
801067a8:	e9 fc f7 ff ff       	jmp    80105fa9 <alltraps>

801067ad <vector54>:
.globl vector54
vector54:
  pushl $0
801067ad:	6a 00                	push   $0x0
  pushl $54
801067af:	6a 36                	push   $0x36
  jmp alltraps
801067b1:	e9 f3 f7 ff ff       	jmp    80105fa9 <alltraps>

801067b6 <vector55>:
.globl vector55
vector55:
  pushl $0
801067b6:	6a 00                	push   $0x0
  pushl $55
801067b8:	6a 37                	push   $0x37
  jmp alltraps
801067ba:	e9 ea f7 ff ff       	jmp    80105fa9 <alltraps>

801067bf <vector56>:
.globl vector56
vector56:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $56
801067c1:	6a 38                	push   $0x38
  jmp alltraps
801067c3:	e9 e1 f7 ff ff       	jmp    80105fa9 <alltraps>

801067c8 <vector57>:
.globl vector57
vector57:
  pushl $0
801067c8:	6a 00                	push   $0x0
  pushl $57
801067ca:	6a 39                	push   $0x39
  jmp alltraps
801067cc:	e9 d8 f7 ff ff       	jmp    80105fa9 <alltraps>

801067d1 <vector58>:
.globl vector58
vector58:
  pushl $0
801067d1:	6a 00                	push   $0x0
  pushl $58
801067d3:	6a 3a                	push   $0x3a
  jmp alltraps
801067d5:	e9 cf f7 ff ff       	jmp    80105fa9 <alltraps>

801067da <vector59>:
.globl vector59
vector59:
  pushl $0
801067da:	6a 00                	push   $0x0
  pushl $59
801067dc:	6a 3b                	push   $0x3b
  jmp alltraps
801067de:	e9 c6 f7 ff ff       	jmp    80105fa9 <alltraps>

801067e3 <vector60>:
.globl vector60
vector60:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $60
801067e5:	6a 3c                	push   $0x3c
  jmp alltraps
801067e7:	e9 bd f7 ff ff       	jmp    80105fa9 <alltraps>

801067ec <vector61>:
.globl vector61
vector61:
  pushl $0
801067ec:	6a 00                	push   $0x0
  pushl $61
801067ee:	6a 3d                	push   $0x3d
  jmp alltraps
801067f0:	e9 b4 f7 ff ff       	jmp    80105fa9 <alltraps>

801067f5 <vector62>:
.globl vector62
vector62:
  pushl $0
801067f5:	6a 00                	push   $0x0
  pushl $62
801067f7:	6a 3e                	push   $0x3e
  jmp alltraps
801067f9:	e9 ab f7 ff ff       	jmp    80105fa9 <alltraps>

801067fe <vector63>:
.globl vector63
vector63:
  pushl $0
801067fe:	6a 00                	push   $0x0
  pushl $63
80106800:	6a 3f                	push   $0x3f
  jmp alltraps
80106802:	e9 a2 f7 ff ff       	jmp    80105fa9 <alltraps>

80106807 <vector64>:
.globl vector64
vector64:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $64
80106809:	6a 40                	push   $0x40
  jmp alltraps
8010680b:	e9 99 f7 ff ff       	jmp    80105fa9 <alltraps>

80106810 <vector65>:
.globl vector65
vector65:
  pushl $0
80106810:	6a 00                	push   $0x0
  pushl $65
80106812:	6a 41                	push   $0x41
  jmp alltraps
80106814:	e9 90 f7 ff ff       	jmp    80105fa9 <alltraps>

80106819 <vector66>:
.globl vector66
vector66:
  pushl $0
80106819:	6a 00                	push   $0x0
  pushl $66
8010681b:	6a 42                	push   $0x42
  jmp alltraps
8010681d:	e9 87 f7 ff ff       	jmp    80105fa9 <alltraps>

80106822 <vector67>:
.globl vector67
vector67:
  pushl $0
80106822:	6a 00                	push   $0x0
  pushl $67
80106824:	6a 43                	push   $0x43
  jmp alltraps
80106826:	e9 7e f7 ff ff       	jmp    80105fa9 <alltraps>

8010682b <vector68>:
.globl vector68
vector68:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $68
8010682d:	6a 44                	push   $0x44
  jmp alltraps
8010682f:	e9 75 f7 ff ff       	jmp    80105fa9 <alltraps>

80106834 <vector69>:
.globl vector69
vector69:
  pushl $0
80106834:	6a 00                	push   $0x0
  pushl $69
80106836:	6a 45                	push   $0x45
  jmp alltraps
80106838:	e9 6c f7 ff ff       	jmp    80105fa9 <alltraps>

8010683d <vector70>:
.globl vector70
vector70:
  pushl $0
8010683d:	6a 00                	push   $0x0
  pushl $70
8010683f:	6a 46                	push   $0x46
  jmp alltraps
80106841:	e9 63 f7 ff ff       	jmp    80105fa9 <alltraps>

80106846 <vector71>:
.globl vector71
vector71:
  pushl $0
80106846:	6a 00                	push   $0x0
  pushl $71
80106848:	6a 47                	push   $0x47
  jmp alltraps
8010684a:	e9 5a f7 ff ff       	jmp    80105fa9 <alltraps>

8010684f <vector72>:
.globl vector72
vector72:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $72
80106851:	6a 48                	push   $0x48
  jmp alltraps
80106853:	e9 51 f7 ff ff       	jmp    80105fa9 <alltraps>

80106858 <vector73>:
.globl vector73
vector73:
  pushl $0
80106858:	6a 00                	push   $0x0
  pushl $73
8010685a:	6a 49                	push   $0x49
  jmp alltraps
8010685c:	e9 48 f7 ff ff       	jmp    80105fa9 <alltraps>

80106861 <vector74>:
.globl vector74
vector74:
  pushl $0
80106861:	6a 00                	push   $0x0
  pushl $74
80106863:	6a 4a                	push   $0x4a
  jmp alltraps
80106865:	e9 3f f7 ff ff       	jmp    80105fa9 <alltraps>

8010686a <vector75>:
.globl vector75
vector75:
  pushl $0
8010686a:	6a 00                	push   $0x0
  pushl $75
8010686c:	6a 4b                	push   $0x4b
  jmp alltraps
8010686e:	e9 36 f7 ff ff       	jmp    80105fa9 <alltraps>

80106873 <vector76>:
.globl vector76
vector76:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $76
80106875:	6a 4c                	push   $0x4c
  jmp alltraps
80106877:	e9 2d f7 ff ff       	jmp    80105fa9 <alltraps>

8010687c <vector77>:
.globl vector77
vector77:
  pushl $0
8010687c:	6a 00                	push   $0x0
  pushl $77
8010687e:	6a 4d                	push   $0x4d
  jmp alltraps
80106880:	e9 24 f7 ff ff       	jmp    80105fa9 <alltraps>

80106885 <vector78>:
.globl vector78
vector78:
  pushl $0
80106885:	6a 00                	push   $0x0
  pushl $78
80106887:	6a 4e                	push   $0x4e
  jmp alltraps
80106889:	e9 1b f7 ff ff       	jmp    80105fa9 <alltraps>

8010688e <vector79>:
.globl vector79
vector79:
  pushl $0
8010688e:	6a 00                	push   $0x0
  pushl $79
80106890:	6a 4f                	push   $0x4f
  jmp alltraps
80106892:	e9 12 f7 ff ff       	jmp    80105fa9 <alltraps>

80106897 <vector80>:
.globl vector80
vector80:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $80
80106899:	6a 50                	push   $0x50
  jmp alltraps
8010689b:	e9 09 f7 ff ff       	jmp    80105fa9 <alltraps>

801068a0 <vector81>:
.globl vector81
vector81:
  pushl $0
801068a0:	6a 00                	push   $0x0
  pushl $81
801068a2:	6a 51                	push   $0x51
  jmp alltraps
801068a4:	e9 00 f7 ff ff       	jmp    80105fa9 <alltraps>

801068a9 <vector82>:
.globl vector82
vector82:
  pushl $0
801068a9:	6a 00                	push   $0x0
  pushl $82
801068ab:	6a 52                	push   $0x52
  jmp alltraps
801068ad:	e9 f7 f6 ff ff       	jmp    80105fa9 <alltraps>

801068b2 <vector83>:
.globl vector83
vector83:
  pushl $0
801068b2:	6a 00                	push   $0x0
  pushl $83
801068b4:	6a 53                	push   $0x53
  jmp alltraps
801068b6:	e9 ee f6 ff ff       	jmp    80105fa9 <alltraps>

801068bb <vector84>:
.globl vector84
vector84:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $84
801068bd:	6a 54                	push   $0x54
  jmp alltraps
801068bf:	e9 e5 f6 ff ff       	jmp    80105fa9 <alltraps>

801068c4 <vector85>:
.globl vector85
vector85:
  pushl $0
801068c4:	6a 00                	push   $0x0
  pushl $85
801068c6:	6a 55                	push   $0x55
  jmp alltraps
801068c8:	e9 dc f6 ff ff       	jmp    80105fa9 <alltraps>

801068cd <vector86>:
.globl vector86
vector86:
  pushl $0
801068cd:	6a 00                	push   $0x0
  pushl $86
801068cf:	6a 56                	push   $0x56
  jmp alltraps
801068d1:	e9 d3 f6 ff ff       	jmp    80105fa9 <alltraps>

801068d6 <vector87>:
.globl vector87
vector87:
  pushl $0
801068d6:	6a 00                	push   $0x0
  pushl $87
801068d8:	6a 57                	push   $0x57
  jmp alltraps
801068da:	e9 ca f6 ff ff       	jmp    80105fa9 <alltraps>

801068df <vector88>:
.globl vector88
vector88:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $88
801068e1:	6a 58                	push   $0x58
  jmp alltraps
801068e3:	e9 c1 f6 ff ff       	jmp    80105fa9 <alltraps>

801068e8 <vector89>:
.globl vector89
vector89:
  pushl $0
801068e8:	6a 00                	push   $0x0
  pushl $89
801068ea:	6a 59                	push   $0x59
  jmp alltraps
801068ec:	e9 b8 f6 ff ff       	jmp    80105fa9 <alltraps>

801068f1 <vector90>:
.globl vector90
vector90:
  pushl $0
801068f1:	6a 00                	push   $0x0
  pushl $90
801068f3:	6a 5a                	push   $0x5a
  jmp alltraps
801068f5:	e9 af f6 ff ff       	jmp    80105fa9 <alltraps>

801068fa <vector91>:
.globl vector91
vector91:
  pushl $0
801068fa:	6a 00                	push   $0x0
  pushl $91
801068fc:	6a 5b                	push   $0x5b
  jmp alltraps
801068fe:	e9 a6 f6 ff ff       	jmp    80105fa9 <alltraps>

80106903 <vector92>:
.globl vector92
vector92:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $92
80106905:	6a 5c                	push   $0x5c
  jmp alltraps
80106907:	e9 9d f6 ff ff       	jmp    80105fa9 <alltraps>

8010690c <vector93>:
.globl vector93
vector93:
  pushl $0
8010690c:	6a 00                	push   $0x0
  pushl $93
8010690e:	6a 5d                	push   $0x5d
  jmp alltraps
80106910:	e9 94 f6 ff ff       	jmp    80105fa9 <alltraps>

80106915 <vector94>:
.globl vector94
vector94:
  pushl $0
80106915:	6a 00                	push   $0x0
  pushl $94
80106917:	6a 5e                	push   $0x5e
  jmp alltraps
80106919:	e9 8b f6 ff ff       	jmp    80105fa9 <alltraps>

8010691e <vector95>:
.globl vector95
vector95:
  pushl $0
8010691e:	6a 00                	push   $0x0
  pushl $95
80106920:	6a 5f                	push   $0x5f
  jmp alltraps
80106922:	e9 82 f6 ff ff       	jmp    80105fa9 <alltraps>

80106927 <vector96>:
.globl vector96
vector96:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $96
80106929:	6a 60                	push   $0x60
  jmp alltraps
8010692b:	e9 79 f6 ff ff       	jmp    80105fa9 <alltraps>

80106930 <vector97>:
.globl vector97
vector97:
  pushl $0
80106930:	6a 00                	push   $0x0
  pushl $97
80106932:	6a 61                	push   $0x61
  jmp alltraps
80106934:	e9 70 f6 ff ff       	jmp    80105fa9 <alltraps>

80106939 <vector98>:
.globl vector98
vector98:
  pushl $0
80106939:	6a 00                	push   $0x0
  pushl $98
8010693b:	6a 62                	push   $0x62
  jmp alltraps
8010693d:	e9 67 f6 ff ff       	jmp    80105fa9 <alltraps>

80106942 <vector99>:
.globl vector99
vector99:
  pushl $0
80106942:	6a 00                	push   $0x0
  pushl $99
80106944:	6a 63                	push   $0x63
  jmp alltraps
80106946:	e9 5e f6 ff ff       	jmp    80105fa9 <alltraps>

8010694b <vector100>:
.globl vector100
vector100:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $100
8010694d:	6a 64                	push   $0x64
  jmp alltraps
8010694f:	e9 55 f6 ff ff       	jmp    80105fa9 <alltraps>

80106954 <vector101>:
.globl vector101
vector101:
  pushl $0
80106954:	6a 00                	push   $0x0
  pushl $101
80106956:	6a 65                	push   $0x65
  jmp alltraps
80106958:	e9 4c f6 ff ff       	jmp    80105fa9 <alltraps>

8010695d <vector102>:
.globl vector102
vector102:
  pushl $0
8010695d:	6a 00                	push   $0x0
  pushl $102
8010695f:	6a 66                	push   $0x66
  jmp alltraps
80106961:	e9 43 f6 ff ff       	jmp    80105fa9 <alltraps>

80106966 <vector103>:
.globl vector103
vector103:
  pushl $0
80106966:	6a 00                	push   $0x0
  pushl $103
80106968:	6a 67                	push   $0x67
  jmp alltraps
8010696a:	e9 3a f6 ff ff       	jmp    80105fa9 <alltraps>

8010696f <vector104>:
.globl vector104
vector104:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $104
80106971:	6a 68                	push   $0x68
  jmp alltraps
80106973:	e9 31 f6 ff ff       	jmp    80105fa9 <alltraps>

80106978 <vector105>:
.globl vector105
vector105:
  pushl $0
80106978:	6a 00                	push   $0x0
  pushl $105
8010697a:	6a 69                	push   $0x69
  jmp alltraps
8010697c:	e9 28 f6 ff ff       	jmp    80105fa9 <alltraps>

80106981 <vector106>:
.globl vector106
vector106:
  pushl $0
80106981:	6a 00                	push   $0x0
  pushl $106
80106983:	6a 6a                	push   $0x6a
  jmp alltraps
80106985:	e9 1f f6 ff ff       	jmp    80105fa9 <alltraps>

8010698a <vector107>:
.globl vector107
vector107:
  pushl $0
8010698a:	6a 00                	push   $0x0
  pushl $107
8010698c:	6a 6b                	push   $0x6b
  jmp alltraps
8010698e:	e9 16 f6 ff ff       	jmp    80105fa9 <alltraps>

80106993 <vector108>:
.globl vector108
vector108:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $108
80106995:	6a 6c                	push   $0x6c
  jmp alltraps
80106997:	e9 0d f6 ff ff       	jmp    80105fa9 <alltraps>

8010699c <vector109>:
.globl vector109
vector109:
  pushl $0
8010699c:	6a 00                	push   $0x0
  pushl $109
8010699e:	6a 6d                	push   $0x6d
  jmp alltraps
801069a0:	e9 04 f6 ff ff       	jmp    80105fa9 <alltraps>

801069a5 <vector110>:
.globl vector110
vector110:
  pushl $0
801069a5:	6a 00                	push   $0x0
  pushl $110
801069a7:	6a 6e                	push   $0x6e
  jmp alltraps
801069a9:	e9 fb f5 ff ff       	jmp    80105fa9 <alltraps>

801069ae <vector111>:
.globl vector111
vector111:
  pushl $0
801069ae:	6a 00                	push   $0x0
  pushl $111
801069b0:	6a 6f                	push   $0x6f
  jmp alltraps
801069b2:	e9 f2 f5 ff ff       	jmp    80105fa9 <alltraps>

801069b7 <vector112>:
.globl vector112
vector112:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $112
801069b9:	6a 70                	push   $0x70
  jmp alltraps
801069bb:	e9 e9 f5 ff ff       	jmp    80105fa9 <alltraps>

801069c0 <vector113>:
.globl vector113
vector113:
  pushl $0
801069c0:	6a 00                	push   $0x0
  pushl $113
801069c2:	6a 71                	push   $0x71
  jmp alltraps
801069c4:	e9 e0 f5 ff ff       	jmp    80105fa9 <alltraps>

801069c9 <vector114>:
.globl vector114
vector114:
  pushl $0
801069c9:	6a 00                	push   $0x0
  pushl $114
801069cb:	6a 72                	push   $0x72
  jmp alltraps
801069cd:	e9 d7 f5 ff ff       	jmp    80105fa9 <alltraps>

801069d2 <vector115>:
.globl vector115
vector115:
  pushl $0
801069d2:	6a 00                	push   $0x0
  pushl $115
801069d4:	6a 73                	push   $0x73
  jmp alltraps
801069d6:	e9 ce f5 ff ff       	jmp    80105fa9 <alltraps>

801069db <vector116>:
.globl vector116
vector116:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $116
801069dd:	6a 74                	push   $0x74
  jmp alltraps
801069df:	e9 c5 f5 ff ff       	jmp    80105fa9 <alltraps>

801069e4 <vector117>:
.globl vector117
vector117:
  pushl $0
801069e4:	6a 00                	push   $0x0
  pushl $117
801069e6:	6a 75                	push   $0x75
  jmp alltraps
801069e8:	e9 bc f5 ff ff       	jmp    80105fa9 <alltraps>

801069ed <vector118>:
.globl vector118
vector118:
  pushl $0
801069ed:	6a 00                	push   $0x0
  pushl $118
801069ef:	6a 76                	push   $0x76
  jmp alltraps
801069f1:	e9 b3 f5 ff ff       	jmp    80105fa9 <alltraps>

801069f6 <vector119>:
.globl vector119
vector119:
  pushl $0
801069f6:	6a 00                	push   $0x0
  pushl $119
801069f8:	6a 77                	push   $0x77
  jmp alltraps
801069fa:	e9 aa f5 ff ff       	jmp    80105fa9 <alltraps>

801069ff <vector120>:
.globl vector120
vector120:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $120
80106a01:	6a 78                	push   $0x78
  jmp alltraps
80106a03:	e9 a1 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a08 <vector121>:
.globl vector121
vector121:
  pushl $0
80106a08:	6a 00                	push   $0x0
  pushl $121
80106a0a:	6a 79                	push   $0x79
  jmp alltraps
80106a0c:	e9 98 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a11 <vector122>:
.globl vector122
vector122:
  pushl $0
80106a11:	6a 00                	push   $0x0
  pushl $122
80106a13:	6a 7a                	push   $0x7a
  jmp alltraps
80106a15:	e9 8f f5 ff ff       	jmp    80105fa9 <alltraps>

80106a1a <vector123>:
.globl vector123
vector123:
  pushl $0
80106a1a:	6a 00                	push   $0x0
  pushl $123
80106a1c:	6a 7b                	push   $0x7b
  jmp alltraps
80106a1e:	e9 86 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a23 <vector124>:
.globl vector124
vector124:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $124
80106a25:	6a 7c                	push   $0x7c
  jmp alltraps
80106a27:	e9 7d f5 ff ff       	jmp    80105fa9 <alltraps>

80106a2c <vector125>:
.globl vector125
vector125:
  pushl $0
80106a2c:	6a 00                	push   $0x0
  pushl $125
80106a2e:	6a 7d                	push   $0x7d
  jmp alltraps
80106a30:	e9 74 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a35 <vector126>:
.globl vector126
vector126:
  pushl $0
80106a35:	6a 00                	push   $0x0
  pushl $126
80106a37:	6a 7e                	push   $0x7e
  jmp alltraps
80106a39:	e9 6b f5 ff ff       	jmp    80105fa9 <alltraps>

80106a3e <vector127>:
.globl vector127
vector127:
  pushl $0
80106a3e:	6a 00                	push   $0x0
  pushl $127
80106a40:	6a 7f                	push   $0x7f
  jmp alltraps
80106a42:	e9 62 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a47 <vector128>:
.globl vector128
vector128:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $128
80106a49:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106a4e:	e9 56 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a53 <vector129>:
.globl vector129
vector129:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $129
80106a55:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106a5a:	e9 4a f5 ff ff       	jmp    80105fa9 <alltraps>

80106a5f <vector130>:
.globl vector130
vector130:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $130
80106a61:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106a66:	e9 3e f5 ff ff       	jmp    80105fa9 <alltraps>

80106a6b <vector131>:
.globl vector131
vector131:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $131
80106a6d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106a72:	e9 32 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a77 <vector132>:
.globl vector132
vector132:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $132
80106a79:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106a7e:	e9 26 f5 ff ff       	jmp    80105fa9 <alltraps>

80106a83 <vector133>:
.globl vector133
vector133:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $133
80106a85:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106a8a:	e9 1a f5 ff ff       	jmp    80105fa9 <alltraps>

80106a8f <vector134>:
.globl vector134
vector134:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $134
80106a91:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106a96:	e9 0e f5 ff ff       	jmp    80105fa9 <alltraps>

80106a9b <vector135>:
.globl vector135
vector135:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $135
80106a9d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106aa2:	e9 02 f5 ff ff       	jmp    80105fa9 <alltraps>

80106aa7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $136
80106aa9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106aae:	e9 f6 f4 ff ff       	jmp    80105fa9 <alltraps>

80106ab3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $137
80106ab5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106aba:	e9 ea f4 ff ff       	jmp    80105fa9 <alltraps>

80106abf <vector138>:
.globl vector138
vector138:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $138
80106ac1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106ac6:	e9 de f4 ff ff       	jmp    80105fa9 <alltraps>

80106acb <vector139>:
.globl vector139
vector139:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $139
80106acd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106ad2:	e9 d2 f4 ff ff       	jmp    80105fa9 <alltraps>

80106ad7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $140
80106ad9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106ade:	e9 c6 f4 ff ff       	jmp    80105fa9 <alltraps>

80106ae3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $141
80106ae5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106aea:	e9 ba f4 ff ff       	jmp    80105fa9 <alltraps>

80106aef <vector142>:
.globl vector142
vector142:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $142
80106af1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106af6:	e9 ae f4 ff ff       	jmp    80105fa9 <alltraps>

80106afb <vector143>:
.globl vector143
vector143:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $143
80106afd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106b02:	e9 a2 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b07 <vector144>:
.globl vector144
vector144:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $144
80106b09:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106b0e:	e9 96 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b13 <vector145>:
.globl vector145
vector145:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $145
80106b15:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106b1a:	e9 8a f4 ff ff       	jmp    80105fa9 <alltraps>

80106b1f <vector146>:
.globl vector146
vector146:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $146
80106b21:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106b26:	e9 7e f4 ff ff       	jmp    80105fa9 <alltraps>

80106b2b <vector147>:
.globl vector147
vector147:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $147
80106b2d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106b32:	e9 72 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b37 <vector148>:
.globl vector148
vector148:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $148
80106b39:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106b3e:	e9 66 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b43 <vector149>:
.globl vector149
vector149:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $149
80106b45:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106b4a:	e9 5a f4 ff ff       	jmp    80105fa9 <alltraps>

80106b4f <vector150>:
.globl vector150
vector150:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $150
80106b51:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106b56:	e9 4e f4 ff ff       	jmp    80105fa9 <alltraps>

80106b5b <vector151>:
.globl vector151
vector151:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $151
80106b5d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106b62:	e9 42 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b67 <vector152>:
.globl vector152
vector152:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $152
80106b69:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106b6e:	e9 36 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b73 <vector153>:
.globl vector153
vector153:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $153
80106b75:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106b7a:	e9 2a f4 ff ff       	jmp    80105fa9 <alltraps>

80106b7f <vector154>:
.globl vector154
vector154:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $154
80106b81:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106b86:	e9 1e f4 ff ff       	jmp    80105fa9 <alltraps>

80106b8b <vector155>:
.globl vector155
vector155:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $155
80106b8d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106b92:	e9 12 f4 ff ff       	jmp    80105fa9 <alltraps>

80106b97 <vector156>:
.globl vector156
vector156:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $156
80106b99:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106b9e:	e9 06 f4 ff ff       	jmp    80105fa9 <alltraps>

80106ba3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $157
80106ba5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106baa:	e9 fa f3 ff ff       	jmp    80105fa9 <alltraps>

80106baf <vector158>:
.globl vector158
vector158:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $158
80106bb1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106bb6:	e9 ee f3 ff ff       	jmp    80105fa9 <alltraps>

80106bbb <vector159>:
.globl vector159
vector159:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $159
80106bbd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106bc2:	e9 e2 f3 ff ff       	jmp    80105fa9 <alltraps>

80106bc7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $160
80106bc9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106bce:	e9 d6 f3 ff ff       	jmp    80105fa9 <alltraps>

80106bd3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $161
80106bd5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106bda:	e9 ca f3 ff ff       	jmp    80105fa9 <alltraps>

80106bdf <vector162>:
.globl vector162
vector162:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $162
80106be1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106be6:	e9 be f3 ff ff       	jmp    80105fa9 <alltraps>

80106beb <vector163>:
.globl vector163
vector163:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $163
80106bed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106bf2:	e9 b2 f3 ff ff       	jmp    80105fa9 <alltraps>

80106bf7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $164
80106bf9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106bfe:	e9 a6 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c03 <vector165>:
.globl vector165
vector165:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $165
80106c05:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106c0a:	e9 9a f3 ff ff       	jmp    80105fa9 <alltraps>

80106c0f <vector166>:
.globl vector166
vector166:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $166
80106c11:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106c16:	e9 8e f3 ff ff       	jmp    80105fa9 <alltraps>

80106c1b <vector167>:
.globl vector167
vector167:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $167
80106c1d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106c22:	e9 82 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c27 <vector168>:
.globl vector168
vector168:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $168
80106c29:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106c2e:	e9 76 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c33 <vector169>:
.globl vector169
vector169:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $169
80106c35:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106c3a:	e9 6a f3 ff ff       	jmp    80105fa9 <alltraps>

80106c3f <vector170>:
.globl vector170
vector170:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $170
80106c41:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106c46:	e9 5e f3 ff ff       	jmp    80105fa9 <alltraps>

80106c4b <vector171>:
.globl vector171
vector171:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $171
80106c4d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106c52:	e9 52 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c57 <vector172>:
.globl vector172
vector172:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $172
80106c59:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106c5e:	e9 46 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c63 <vector173>:
.globl vector173
vector173:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $173
80106c65:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106c6a:	e9 3a f3 ff ff       	jmp    80105fa9 <alltraps>

80106c6f <vector174>:
.globl vector174
vector174:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $174
80106c71:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106c76:	e9 2e f3 ff ff       	jmp    80105fa9 <alltraps>

80106c7b <vector175>:
.globl vector175
vector175:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $175
80106c7d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106c82:	e9 22 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c87 <vector176>:
.globl vector176
vector176:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $176
80106c89:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106c8e:	e9 16 f3 ff ff       	jmp    80105fa9 <alltraps>

80106c93 <vector177>:
.globl vector177
vector177:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $177
80106c95:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106c9a:	e9 0a f3 ff ff       	jmp    80105fa9 <alltraps>

80106c9f <vector178>:
.globl vector178
vector178:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $178
80106ca1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106ca6:	e9 fe f2 ff ff       	jmp    80105fa9 <alltraps>

80106cab <vector179>:
.globl vector179
vector179:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $179
80106cad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106cb2:	e9 f2 f2 ff ff       	jmp    80105fa9 <alltraps>

80106cb7 <vector180>:
.globl vector180
vector180:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $180
80106cb9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106cbe:	e9 e6 f2 ff ff       	jmp    80105fa9 <alltraps>

80106cc3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $181
80106cc5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106cca:	e9 da f2 ff ff       	jmp    80105fa9 <alltraps>

80106ccf <vector182>:
.globl vector182
vector182:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $182
80106cd1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106cd6:	e9 ce f2 ff ff       	jmp    80105fa9 <alltraps>

80106cdb <vector183>:
.globl vector183
vector183:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $183
80106cdd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106ce2:	e9 c2 f2 ff ff       	jmp    80105fa9 <alltraps>

80106ce7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $184
80106ce9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106cee:	e9 b6 f2 ff ff       	jmp    80105fa9 <alltraps>

80106cf3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $185
80106cf5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106cfa:	e9 aa f2 ff ff       	jmp    80105fa9 <alltraps>

80106cff <vector186>:
.globl vector186
vector186:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $186
80106d01:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106d06:	e9 9e f2 ff ff       	jmp    80105fa9 <alltraps>

80106d0b <vector187>:
.globl vector187
vector187:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $187
80106d0d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106d12:	e9 92 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d17 <vector188>:
.globl vector188
vector188:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $188
80106d19:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106d1e:	e9 86 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d23 <vector189>:
.globl vector189
vector189:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $189
80106d25:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106d2a:	e9 7a f2 ff ff       	jmp    80105fa9 <alltraps>

80106d2f <vector190>:
.globl vector190
vector190:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $190
80106d31:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106d36:	e9 6e f2 ff ff       	jmp    80105fa9 <alltraps>

80106d3b <vector191>:
.globl vector191
vector191:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $191
80106d3d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106d42:	e9 62 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d47 <vector192>:
.globl vector192
vector192:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $192
80106d49:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106d4e:	e9 56 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d53 <vector193>:
.globl vector193
vector193:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $193
80106d55:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106d5a:	e9 4a f2 ff ff       	jmp    80105fa9 <alltraps>

80106d5f <vector194>:
.globl vector194
vector194:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $194
80106d61:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106d66:	e9 3e f2 ff ff       	jmp    80105fa9 <alltraps>

80106d6b <vector195>:
.globl vector195
vector195:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $195
80106d6d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106d72:	e9 32 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d77 <vector196>:
.globl vector196
vector196:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $196
80106d79:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106d7e:	e9 26 f2 ff ff       	jmp    80105fa9 <alltraps>

80106d83 <vector197>:
.globl vector197
vector197:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $197
80106d85:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106d8a:	e9 1a f2 ff ff       	jmp    80105fa9 <alltraps>

80106d8f <vector198>:
.globl vector198
vector198:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $198
80106d91:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106d96:	e9 0e f2 ff ff       	jmp    80105fa9 <alltraps>

80106d9b <vector199>:
.globl vector199
vector199:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $199
80106d9d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106da2:	e9 02 f2 ff ff       	jmp    80105fa9 <alltraps>

80106da7 <vector200>:
.globl vector200
vector200:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $200
80106da9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106dae:	e9 f6 f1 ff ff       	jmp    80105fa9 <alltraps>

80106db3 <vector201>:
.globl vector201
vector201:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $201
80106db5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106dba:	e9 ea f1 ff ff       	jmp    80105fa9 <alltraps>

80106dbf <vector202>:
.globl vector202
vector202:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $202
80106dc1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106dc6:	e9 de f1 ff ff       	jmp    80105fa9 <alltraps>

80106dcb <vector203>:
.globl vector203
vector203:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $203
80106dcd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106dd2:	e9 d2 f1 ff ff       	jmp    80105fa9 <alltraps>

80106dd7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $204
80106dd9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106dde:	e9 c6 f1 ff ff       	jmp    80105fa9 <alltraps>

80106de3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $205
80106de5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106dea:	e9 ba f1 ff ff       	jmp    80105fa9 <alltraps>

80106def <vector206>:
.globl vector206
vector206:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $206
80106df1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106df6:	e9 ae f1 ff ff       	jmp    80105fa9 <alltraps>

80106dfb <vector207>:
.globl vector207
vector207:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $207
80106dfd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106e02:	e9 a2 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e07 <vector208>:
.globl vector208
vector208:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $208
80106e09:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106e0e:	e9 96 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e13 <vector209>:
.globl vector209
vector209:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $209
80106e15:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106e1a:	e9 8a f1 ff ff       	jmp    80105fa9 <alltraps>

80106e1f <vector210>:
.globl vector210
vector210:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $210
80106e21:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106e26:	e9 7e f1 ff ff       	jmp    80105fa9 <alltraps>

80106e2b <vector211>:
.globl vector211
vector211:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $211
80106e2d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106e32:	e9 72 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e37 <vector212>:
.globl vector212
vector212:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $212
80106e39:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106e3e:	e9 66 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e43 <vector213>:
.globl vector213
vector213:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $213
80106e45:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106e4a:	e9 5a f1 ff ff       	jmp    80105fa9 <alltraps>

80106e4f <vector214>:
.globl vector214
vector214:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $214
80106e51:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106e56:	e9 4e f1 ff ff       	jmp    80105fa9 <alltraps>

80106e5b <vector215>:
.globl vector215
vector215:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $215
80106e5d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106e62:	e9 42 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e67 <vector216>:
.globl vector216
vector216:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $216
80106e69:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106e6e:	e9 36 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e73 <vector217>:
.globl vector217
vector217:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $217
80106e75:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106e7a:	e9 2a f1 ff ff       	jmp    80105fa9 <alltraps>

80106e7f <vector218>:
.globl vector218
vector218:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $218
80106e81:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106e86:	e9 1e f1 ff ff       	jmp    80105fa9 <alltraps>

80106e8b <vector219>:
.globl vector219
vector219:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $219
80106e8d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106e92:	e9 12 f1 ff ff       	jmp    80105fa9 <alltraps>

80106e97 <vector220>:
.globl vector220
vector220:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $220
80106e99:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106e9e:	e9 06 f1 ff ff       	jmp    80105fa9 <alltraps>

80106ea3 <vector221>:
.globl vector221
vector221:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $221
80106ea5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106eaa:	e9 fa f0 ff ff       	jmp    80105fa9 <alltraps>

80106eaf <vector222>:
.globl vector222
vector222:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $222
80106eb1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106eb6:	e9 ee f0 ff ff       	jmp    80105fa9 <alltraps>

80106ebb <vector223>:
.globl vector223
vector223:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $223
80106ebd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106ec2:	e9 e2 f0 ff ff       	jmp    80105fa9 <alltraps>

80106ec7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $224
80106ec9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106ece:	e9 d6 f0 ff ff       	jmp    80105fa9 <alltraps>

80106ed3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $225
80106ed5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106eda:	e9 ca f0 ff ff       	jmp    80105fa9 <alltraps>

80106edf <vector226>:
.globl vector226
vector226:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $226
80106ee1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ee6:	e9 be f0 ff ff       	jmp    80105fa9 <alltraps>

80106eeb <vector227>:
.globl vector227
vector227:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $227
80106eed:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ef2:	e9 b2 f0 ff ff       	jmp    80105fa9 <alltraps>

80106ef7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $228
80106ef9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106efe:	e9 a6 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f03 <vector229>:
.globl vector229
vector229:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $229
80106f05:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106f0a:	e9 9a f0 ff ff       	jmp    80105fa9 <alltraps>

80106f0f <vector230>:
.globl vector230
vector230:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $230
80106f11:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106f16:	e9 8e f0 ff ff       	jmp    80105fa9 <alltraps>

80106f1b <vector231>:
.globl vector231
vector231:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $231
80106f1d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106f22:	e9 82 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f27 <vector232>:
.globl vector232
vector232:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $232
80106f29:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106f2e:	e9 76 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f33 <vector233>:
.globl vector233
vector233:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $233
80106f35:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106f3a:	e9 6a f0 ff ff       	jmp    80105fa9 <alltraps>

80106f3f <vector234>:
.globl vector234
vector234:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $234
80106f41:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106f46:	e9 5e f0 ff ff       	jmp    80105fa9 <alltraps>

80106f4b <vector235>:
.globl vector235
vector235:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $235
80106f4d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106f52:	e9 52 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f57 <vector236>:
.globl vector236
vector236:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $236
80106f59:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106f5e:	e9 46 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f63 <vector237>:
.globl vector237
vector237:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $237
80106f65:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106f6a:	e9 3a f0 ff ff       	jmp    80105fa9 <alltraps>

80106f6f <vector238>:
.globl vector238
vector238:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $238
80106f71:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106f76:	e9 2e f0 ff ff       	jmp    80105fa9 <alltraps>

80106f7b <vector239>:
.globl vector239
vector239:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $239
80106f7d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106f82:	e9 22 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f87 <vector240>:
.globl vector240
vector240:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $240
80106f89:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106f8e:	e9 16 f0 ff ff       	jmp    80105fa9 <alltraps>

80106f93 <vector241>:
.globl vector241
vector241:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $241
80106f95:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106f9a:	e9 0a f0 ff ff       	jmp    80105fa9 <alltraps>

80106f9f <vector242>:
.globl vector242
vector242:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $242
80106fa1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106fa6:	e9 fe ef ff ff       	jmp    80105fa9 <alltraps>

80106fab <vector243>:
.globl vector243
vector243:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $243
80106fad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106fb2:	e9 f2 ef ff ff       	jmp    80105fa9 <alltraps>

80106fb7 <vector244>:
.globl vector244
vector244:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $244
80106fb9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106fbe:	e9 e6 ef ff ff       	jmp    80105fa9 <alltraps>

80106fc3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $245
80106fc5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106fca:	e9 da ef ff ff       	jmp    80105fa9 <alltraps>

80106fcf <vector246>:
.globl vector246
vector246:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $246
80106fd1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106fd6:	e9 ce ef ff ff       	jmp    80105fa9 <alltraps>

80106fdb <vector247>:
.globl vector247
vector247:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $247
80106fdd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106fe2:	e9 c2 ef ff ff       	jmp    80105fa9 <alltraps>

80106fe7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $248
80106fe9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106fee:	e9 b6 ef ff ff       	jmp    80105fa9 <alltraps>

80106ff3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $249
80106ff5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106ffa:	e9 aa ef ff ff       	jmp    80105fa9 <alltraps>

80106fff <vector250>:
.globl vector250
vector250:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $250
80107001:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107006:	e9 9e ef ff ff       	jmp    80105fa9 <alltraps>

8010700b <vector251>:
.globl vector251
vector251:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $251
8010700d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107012:	e9 92 ef ff ff       	jmp    80105fa9 <alltraps>

80107017 <vector252>:
.globl vector252
vector252:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $252
80107019:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010701e:	e9 86 ef ff ff       	jmp    80105fa9 <alltraps>

80107023 <vector253>:
.globl vector253
vector253:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $253
80107025:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010702a:	e9 7a ef ff ff       	jmp    80105fa9 <alltraps>

8010702f <vector254>:
.globl vector254
vector254:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $254
80107031:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107036:	e9 6e ef ff ff       	jmp    80105fa9 <alltraps>

8010703b <vector255>:
.globl vector255
vector255:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $255
8010703d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107042:	e9 62 ef ff ff       	jmp    80105fa9 <alltraps>
80107047:	66 90                	xchg   %ax,%ax
80107049:	66 90                	xchg   %ax,%ax
8010704b:	66 90                	xchg   %ax,%ax
8010704d:	66 90                	xchg   %ax,%ax
8010704f:	90                   	nop

80107050 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107056:	89 d3                	mov    %edx,%ebx
{
80107058:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010705a:	c1 eb 16             	shr    $0x16,%ebx
8010705d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107060:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107063:	8b 06                	mov    (%esi),%eax
80107065:	a8 01                	test   $0x1,%al
80107067:	74 27                	je     80107090 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107069:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010706e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107074:	c1 ef 0a             	shr    $0xa,%edi
}
80107077:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010707a:	89 fa                	mov    %edi,%edx
8010707c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107082:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107085:	5b                   	pop    %ebx
80107086:	5e                   	pop    %esi
80107087:	5f                   	pop    %edi
80107088:	5d                   	pop    %ebp
80107089:	c3                   	ret    
8010708a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107090:	85 c9                	test   %ecx,%ecx
80107092:	74 2c                	je     801070c0 <walkpgdir+0x70>
80107094:	e8 c7 b8 ff ff       	call   80102960 <kalloc>
80107099:	85 c0                	test   %eax,%eax
8010709b:	89 c3                	mov    %eax,%ebx
8010709d:	74 21                	je     801070c0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010709f:	83 ec 04             	sub    $0x4,%esp
801070a2:	68 00 10 00 00       	push   $0x1000
801070a7:	6a 00                	push   $0x0
801070a9:	50                   	push   %eax
801070aa:	e8 d1 dc ff ff       	call   80104d80 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801070af:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801070b5:	83 c4 10             	add    $0x10,%esp
801070b8:	83 c8 07             	or     $0x7,%eax
801070bb:	89 06                	mov    %eax,(%esi)
801070bd:	eb b5                	jmp    80107074 <walkpgdir+0x24>
801070bf:	90                   	nop
}
801070c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801070c3:	31 c0                	xor    %eax,%eax
}
801070c5:	5b                   	pop    %ebx
801070c6:	5e                   	pop    %esi
801070c7:	5f                   	pop    %edi
801070c8:	5d                   	pop    %ebp
801070c9:	c3                   	ret    
801070ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801070d0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801070d0:	55                   	push   %ebp
801070d1:	89 e5                	mov    %esp,%ebp
801070d3:	57                   	push   %edi
801070d4:	56                   	push   %esi
801070d5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801070d6:	89 d3                	mov    %edx,%ebx
801070d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801070de:	83 ec 1c             	sub    $0x1c,%esp
801070e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801070e4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801070e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801070eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801070f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801070f6:	29 df                	sub    %ebx,%edi
801070f8:	83 c8 01             	or     $0x1,%eax
801070fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801070fe:	eb 15                	jmp    80107115 <mappages+0x45>
    if(*pte & PTE_P)
80107100:	f6 00 01             	testb  $0x1,(%eax)
80107103:	75 45                	jne    8010714a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107105:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107108:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010710b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010710d:	74 31                	je     80107140 <mappages+0x70>
      break;
    a += PGSIZE;
8010710f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107115:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107118:	b9 01 00 00 00       	mov    $0x1,%ecx
8010711d:	89 da                	mov    %ebx,%edx
8010711f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107122:	e8 29 ff ff ff       	call   80107050 <walkpgdir>
80107127:	85 c0                	test   %eax,%eax
80107129:	75 d5                	jne    80107100 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010712b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010712e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107133:	5b                   	pop    %ebx
80107134:	5e                   	pop    %esi
80107135:	5f                   	pop    %edi
80107136:	5d                   	pop    %ebp
80107137:	c3                   	ret    
80107138:	90                   	nop
80107139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107140:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107143:	31 c0                	xor    %eax,%eax
}
80107145:	5b                   	pop    %ebx
80107146:	5e                   	pop    %esi
80107147:	5f                   	pop    %edi
80107148:	5d                   	pop    %ebp
80107149:	c3                   	ret    
      panic("remap");
8010714a:	83 ec 0c             	sub    $0xc,%esp
8010714d:	68 80 8f 10 80       	push   $0x80108f80
80107152:	e8 39 92 ff ff       	call   80100390 <panic>
80107157:	89 f6                	mov    %esi,%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107160 <seginit>:
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107166:	e8 05 cd ff ff       	call   80103e70 <cpuid>
8010716b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107171:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107176:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010717a:	c7 80 18 c8 14 80 ff 	movl   $0xffff,-0x7feb37e8(%eax)
80107181:	ff 00 00 
80107184:	c7 80 1c c8 14 80 00 	movl   $0xcf9a00,-0x7feb37e4(%eax)
8010718b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010718e:	c7 80 20 c8 14 80 ff 	movl   $0xffff,-0x7feb37e0(%eax)
80107195:	ff 00 00 
80107198:	c7 80 24 c8 14 80 00 	movl   $0xcf9200,-0x7feb37dc(%eax)
8010719f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801071a2:	c7 80 28 c8 14 80 ff 	movl   $0xffff,-0x7feb37d8(%eax)
801071a9:	ff 00 00 
801071ac:	c7 80 2c c8 14 80 00 	movl   $0xcffa00,-0x7feb37d4(%eax)
801071b3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801071b6:	c7 80 30 c8 14 80 ff 	movl   $0xffff,-0x7feb37d0(%eax)
801071bd:	ff 00 00 
801071c0:	c7 80 34 c8 14 80 00 	movl   $0xcff200,-0x7feb37cc(%eax)
801071c7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071ca:	05 10 c8 14 80       	add    $0x8014c810,%eax
  pd[1] = (uint)p;
801071cf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071d3:	c1 e8 10             	shr    $0x10,%eax
801071d6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801071da:	8d 45 f2             	lea    -0xe(%ebp),%eax
801071dd:	0f 01 10             	lgdtl  (%eax)
}
801071e0:	c9                   	leave  
801071e1:	c3                   	ret    
801071e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071f0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071f0:	a1 c4 89 15 80       	mov    0x801589c4,%eax
{
801071f5:	55                   	push   %ebp
801071f6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071f8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801071fd:	0f 22 d8             	mov    %eax,%cr3
}
80107200:	5d                   	pop    %ebp
80107201:	c3                   	ret    
80107202:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107210 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	57                   	push   %edi
80107214:	56                   	push   %esi
80107215:	53                   	push   %ebx
80107216:	83 ec 1c             	sub    $0x1c,%esp
80107219:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010721c:	85 db                	test   %ebx,%ebx
8010721e:	0f 84 cb 00 00 00    	je     801072ef <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107224:	8b 43 08             	mov    0x8(%ebx),%eax
80107227:	85 c0                	test   %eax,%eax
80107229:	0f 84 da 00 00 00    	je     80107309 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010722f:	8b 43 04             	mov    0x4(%ebx),%eax
80107232:	85 c0                	test   %eax,%eax
80107234:	0f 84 c2 00 00 00    	je     801072fc <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
8010723a:	e8 61 d9 ff ff       	call   80104ba0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010723f:	e8 ac cb ff ff       	call   80103df0 <mycpu>
80107244:	89 c6                	mov    %eax,%esi
80107246:	e8 a5 cb ff ff       	call   80103df0 <mycpu>
8010724b:	89 c7                	mov    %eax,%edi
8010724d:	e8 9e cb ff ff       	call   80103df0 <mycpu>
80107252:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107255:	83 c7 08             	add    $0x8,%edi
80107258:	e8 93 cb ff ff       	call   80103df0 <mycpu>
8010725d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107260:	83 c0 08             	add    $0x8,%eax
80107263:	ba 67 00 00 00       	mov    $0x67,%edx
80107268:	c1 e8 18             	shr    $0x18,%eax
8010726b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107272:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107279:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010727f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107284:	83 c1 08             	add    $0x8,%ecx
80107287:	c1 e9 10             	shr    $0x10,%ecx
8010728a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107290:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107295:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010729c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
801072a1:	e8 4a cb ff ff       	call   80103df0 <mycpu>
801072a6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801072ad:	e8 3e cb ff ff       	call   80103df0 <mycpu>
801072b2:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801072b6:	8b 73 08             	mov    0x8(%ebx),%esi
801072b9:	e8 32 cb ff ff       	call   80103df0 <mycpu>
801072be:	81 c6 00 10 00 00    	add    $0x1000,%esi
801072c4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072c7:	e8 24 cb ff ff       	call   80103df0 <mycpu>
801072cc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801072d0:	b8 28 00 00 00       	mov    $0x28,%eax
801072d5:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072d8:	8b 43 04             	mov    0x4(%ebx),%eax
801072db:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801072e0:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801072e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072e6:	5b                   	pop    %ebx
801072e7:	5e                   	pop    %esi
801072e8:	5f                   	pop    %edi
801072e9:	5d                   	pop    %ebp
  popcli();
801072ea:	e9 f1 d8 ff ff       	jmp    80104be0 <popcli>
    panic("switchuvm: no process");
801072ef:	83 ec 0c             	sub    $0xc,%esp
801072f2:	68 86 8f 10 80       	push   $0x80108f86
801072f7:	e8 94 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801072fc:	83 ec 0c             	sub    $0xc,%esp
801072ff:	68 b1 8f 10 80       	push   $0x80108fb1
80107304:	e8 87 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107309:	83 ec 0c             	sub    $0xc,%esp
8010730c:	68 9c 8f 10 80       	push   $0x80108f9c
80107311:	e8 7a 90 ff ff       	call   80100390 <panic>
80107316:	8d 76 00             	lea    0x0(%esi),%esi
80107319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107320 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107320:	55                   	push   %ebp
80107321:	89 e5                	mov    %esp,%ebp
80107323:	57                   	push   %edi
80107324:	56                   	push   %esi
80107325:	53                   	push   %ebx
80107326:	83 ec 1c             	sub    $0x1c,%esp
80107329:	8b 75 10             	mov    0x10(%ebp),%esi
8010732c:	8b 45 08             	mov    0x8(%ebp),%eax
8010732f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107332:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107338:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010733b:	77 49                	ja     80107386 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010733d:	e8 1e b6 ff ff       	call   80102960 <kalloc>
  memset(mem, 0, PGSIZE);
80107342:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107345:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107347:	68 00 10 00 00       	push   $0x1000
8010734c:	6a 00                	push   $0x0
8010734e:	50                   	push   %eax
8010734f:	e8 2c da ff ff       	call   80104d80 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107354:	58                   	pop    %eax
80107355:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010735b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107360:	5a                   	pop    %edx
80107361:	6a 06                	push   $0x6
80107363:	50                   	push   %eax
80107364:	31 d2                	xor    %edx,%edx
80107366:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107369:	e8 62 fd ff ff       	call   801070d0 <mappages>
  memmove(mem, init, sz);
8010736e:	89 75 10             	mov    %esi,0x10(%ebp)
80107371:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107374:	83 c4 10             	add    $0x10,%esp
80107377:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010737a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010737d:	5b                   	pop    %ebx
8010737e:	5e                   	pop    %esi
8010737f:	5f                   	pop    %edi
80107380:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107381:	e9 aa da ff ff       	jmp    80104e30 <memmove>
    panic("inituvm: more than a page");
80107386:	83 ec 0c             	sub    $0xc,%esp
80107389:	68 c5 8f 10 80       	push   $0x80108fc5
8010738e:	e8 fd 8f ff ff       	call   80100390 <panic>
80107393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073a0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	57                   	push   %edi
801073a4:	56                   	push   %esi
801073a5:	53                   	push   %ebx
801073a6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801073a9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801073b0:	0f 85 91 00 00 00    	jne    80107447 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801073b6:	8b 75 18             	mov    0x18(%ebp),%esi
801073b9:	31 db                	xor    %ebx,%ebx
801073bb:	85 f6                	test   %esi,%esi
801073bd:	75 1a                	jne    801073d9 <loaduvm+0x39>
801073bf:	eb 6f                	jmp    80107430 <loaduvm+0x90>
801073c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073c8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801073ce:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801073d4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801073d7:	76 57                	jbe    80107430 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073d9:	8b 55 0c             	mov    0xc(%ebp),%edx
801073dc:	8b 45 08             	mov    0x8(%ebp),%eax
801073df:	31 c9                	xor    %ecx,%ecx
801073e1:	01 da                	add    %ebx,%edx
801073e3:	e8 68 fc ff ff       	call   80107050 <walkpgdir>
801073e8:	85 c0                	test   %eax,%eax
801073ea:	74 4e                	je     8010743a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801073ec:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073ee:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801073f1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801073f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801073fb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107401:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107404:	01 d9                	add    %ebx,%ecx
80107406:	05 00 00 00 80       	add    $0x80000000,%eax
8010740b:	57                   	push   %edi
8010740c:	51                   	push   %ecx
8010740d:	50                   	push   %eax
8010740e:	ff 75 10             	pushl  0x10(%ebp)
80107411:	e8 ca a5 ff ff       	call   801019e0 <readi>
80107416:	83 c4 10             	add    $0x10,%esp
80107419:	39 f8                	cmp    %edi,%eax
8010741b:	74 ab                	je     801073c8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
8010741d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107425:	5b                   	pop    %ebx
80107426:	5e                   	pop    %esi
80107427:	5f                   	pop    %edi
80107428:	5d                   	pop    %ebp
80107429:	c3                   	ret    
8010742a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107430:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107433:	31 c0                	xor    %eax,%eax
}
80107435:	5b                   	pop    %ebx
80107436:	5e                   	pop    %esi
80107437:	5f                   	pop    %edi
80107438:	5d                   	pop    %ebp
80107439:	c3                   	ret    
      panic("loaduvm: address should exist");
8010743a:	83 ec 0c             	sub    $0xc,%esp
8010743d:	68 df 8f 10 80       	push   $0x80108fdf
80107442:	e8 49 8f ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107447:	83 ec 0c             	sub    $0xc,%esp
8010744a:	68 34 91 10 80       	push   $0x80109134
8010744f:	e8 3c 8f ff ff       	call   80100390 <panic>
80107454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010745a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107460 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107460:	55                   	push   %ebp
80107461:	89 e5                	mov    %esp,%ebp
80107463:	57                   	push   %edi
80107464:	56                   	push   %esi
80107465:	53                   	push   %ebx
80107466:	83 ec 1c             	sub    $0x1c,%esp
  #ifndef NONE
    struct proc *p = myproc();
80107469:	e8 22 ca ff ff       	call   80103e90 <myproc>
8010746e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  #endif

  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
80107471:	8b 45 0c             	mov    0xc(%ebp),%eax
80107474:	39 45 10             	cmp    %eax,0x10(%ebp)
80107477:	0f 83 53 01 00 00    	jae    801075d0 <deallocuvm+0x170>
    cprintf("\n%d  %d\n",oldsz,newsz);
    return oldsz;
  }

  a = PGROUNDUP(newsz);
8010747d:	8b 45 10             	mov    0x10(%ebp),%eax
80107480:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107486:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010748c:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010748f:	77 21                	ja     801074b2 <deallocuvm+0x52>
80107491:	eb 48                	jmp    801074db <deallocuvm+0x7b>
80107493:	90                   	nop
80107494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107498:	8b 00                	mov    (%eax),%eax
8010749a:	a8 01                	test   $0x1,%al
8010749c:	75 52                	jne    801074f0 <deallocuvm+0x90>

      char *v = P2V(pa);
      kfree(v);

      *pte = 0;
    }else if((*pte & PTE_PG) && myproc()->pgdir == pgdir){//
8010749e:	f6 c4 02             	test   $0x2,%ah
801074a1:	0f 85 b9 00 00 00    	jne    80107560 <deallocuvm+0x100>
  for(; a  < oldsz; a += PGSIZE){
801074a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074ad:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801074b0:	76 29                	jbe    801074db <deallocuvm+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
801074b2:	8b 45 08             	mov    0x8(%ebp),%eax
801074b5:	31 c9                	xor    %ecx,%ecx
801074b7:	89 da                	mov    %ebx,%edx
801074b9:	e8 92 fb ff ff       	call   80107050 <walkpgdir>
    if(!pte)
801074be:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
801074c0:	89 c6                	mov    %eax,%esi
    if(!pte)
801074c2:	75 d4                	jne    80107498 <deallocuvm+0x38>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801074c4:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801074ca:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074d0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074d6:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801074d9:	77 d7                	ja     801074b2 <deallocuvm+0x52>
        }
        #endif

      }//
  }
  return newsz;
801074db:	8b 45 10             	mov    0x10(%ebp),%eax
}
801074de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074e1:	5b                   	pop    %ebx
801074e2:	5e                   	pop    %esi
801074e3:	5f                   	pop    %edi
801074e4:	5d                   	pop    %ebp
801074e5:	c3                   	ret    
801074e6:	8d 76 00             	lea    0x0(%esi),%esi
801074e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(pa == 0)
801074f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074f8:	0f 84 fe 00 00 00    	je     801075fc <deallocuvm+0x19c>
        for(i = 0; i < MAX_PSYC_PAGES; i++){
801074fe:	31 ff                	xor    %edi,%edi
80107500:	eb 0e                	jmp    80107510 <deallocuvm+0xb0>
80107502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107508:	83 c7 01             	add    $0x1,%edi
8010750b:	83 ff 10             	cmp    $0x10,%edi
8010750e:	74 27                	je     80107537 <deallocuvm+0xd7>
            if(myproc()->physicalPGs[i].va == (char*)a){
80107510:	e8 7b c9 ff ff       	call   80103e90 <myproc>
80107515:	8d 14 bf             	lea    (%edi,%edi,4),%edx
80107518:	39 9c 90 90 01 00 00 	cmp    %ebx,0x190(%eax,%edx,4)
8010751f:	75 e7                	jne    80107508 <deallocuvm+0xa8>
                p->nPgsPhysical--;
80107521:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107524:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
              myproc()->nPgsPhysical--;
8010752b:	e8 60 c9 ff ff       	call   80103e90 <myproc>
80107530:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
      char *v = P2V(pa);
80107537:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      kfree(v);
8010753a:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010753d:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107542:	50                   	push   %eax
80107543:	e8 d8 b1 ff ff       	call   80102720 <kfree>
      *pte = 0;
80107548:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010754e:	83 c4 10             	add    $0x10,%esp
80107551:	e9 51 ff ff ff       	jmp    801074a7 <deallocuvm+0x47>
80107556:	8d 76 00             	lea    0x0(%esi),%esi
80107559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    }else if((*pte & PTE_PG) && myproc()->pgdir == pgdir){//
80107560:	e8 2b c9 ff ff       	call   80103e90 <myproc>
80107565:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107568:	39 48 04             	cmp    %ecx,0x4(%eax)
8010756b:	0f 85 36 ff ff ff    	jne    801074a7 <deallocuvm+0x47>
        for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107571:	31 d2                	xor    %edx,%edx
80107573:	89 d7                	mov    %edx,%edi
80107575:	eb 11                	jmp    80107588 <deallocuvm+0x128>
80107577:	89 f6                	mov    %esi,%esi
80107579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107580:	83 c7 01             	add    $0x1,%edi
          if(i==MAX_PSYC_PAGES){
80107583:	83 ff 10             	cmp    $0x10,%edi
80107586:	74 67                	je     801075ef <deallocuvm+0x18f>
          if(myproc()->swappedPGs[i].va == (char*)a){
80107588:	8d 77 09             	lea    0x9(%edi),%esi
8010758b:	e8 00 c9 ff ff       	call   80103e90 <myproc>
80107590:	c1 e6 04             	shl    $0x4,%esi
80107593:	39 5c 30 0c          	cmp    %ebx,0xc(%eax,%esi,1)
80107597:	75 e7                	jne    80107580 <deallocuvm+0x120>
            cprintf("cleaned2\n");
80107599:	83 ec 0c             	sub    $0xc,%esp
8010759c:	68 22 90 10 80       	push   $0x80109022
801075a1:	e8 ba 90 ff ff       	call   80100660 <cprintf>
            myproc()->swappedPGs[i].va = (char*) 0xffffffff;
801075a6:	e8 e5 c8 ff ff       	call   80103e90 <myproc>
801075ab:	c7 44 30 0c ff ff ff 	movl   $0xffffffff,0xc(%eax,%esi,1)
801075b2:	ff 
            myproc()->nPgsSwap--;
801075b3:	e8 d8 c8 ff ff       	call   80103e90 <myproc>
            break;
801075b8:	83 c4 10             	add    $0x10,%esp
            myproc()->nPgsSwap--;
801075bb:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
            break;
801075c2:	e9 e0 fe ff ff       	jmp    801074a7 <deallocuvm+0x47>
801075c7:	89 f6                	mov    %esi,%esi
801075c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("\n%d  %d\n",oldsz,newsz);
801075d0:	83 ec 04             	sub    $0x4,%esp
801075d3:	ff 75 10             	pushl  0x10(%ebp)
801075d6:	50                   	push   %eax
801075d7:	68 fd 8f 10 80       	push   $0x80108ffd
801075dc:	e8 7f 90 ff ff       	call   80100660 <cprintf>
    return oldsz;
801075e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801075e4:	83 c4 10             	add    $0x10,%esp
}
801075e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075ea:	5b                   	pop    %ebx
801075eb:	5e                   	pop    %esi
801075ec:	5f                   	pop    %edi
801075ed:	5d                   	pop    %ebp
801075ee:	c3                   	ret    
            panic("deallocuvm: cant find page2");
801075ef:	83 ec 0c             	sub    $0xc,%esp
801075f2:	68 06 90 10 80       	push   $0x80109006
801075f7:	e8 94 8d ff ff       	call   80100390 <panic>
        panic("kfree");
801075fc:	83 ec 0c             	sub    $0xc,%esp
801075ff:	68 ea 87 10 80       	push   $0x801087ea
80107604:	e8 87 8d ff ff       	call   80100390 <panic>
80107609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107610 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	57                   	push   %edi
80107614:	56                   	push   %esi
80107615:	53                   	push   %ebx
80107616:	83 ec 0c             	sub    $0xc,%esp
80107619:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010761c:	85 f6                	test   %esi,%esi
8010761e:	74 59                	je     80107679 <freevm+0x69>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80107620:	83 ec 04             	sub    $0x4,%esp
80107623:	89 f3                	mov    %esi,%ebx
80107625:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010762b:	6a 00                	push   $0x0
8010762d:	68 00 00 00 80       	push   $0x80000000
80107632:	56                   	push   %esi
80107633:	e8 28 fe ff ff       	call   80107460 <deallocuvm>
80107638:	83 c4 10             	add    $0x10,%esp
8010763b:	eb 0a                	jmp    80107647 <freevm+0x37>
8010763d:	8d 76 00             	lea    0x0(%esi),%esi
80107640:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
80107643:	39 fb                	cmp    %edi,%ebx
80107645:	74 23                	je     8010766a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107647:	8b 03                	mov    (%ebx),%eax
80107649:	a8 01                	test   $0x1,%al
8010764b:	74 f3                	je     80107640 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010764d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107652:	83 ec 0c             	sub    $0xc,%esp
80107655:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107658:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010765d:	50                   	push   %eax
8010765e:	e8 bd b0 ff ff       	call   80102720 <kfree>
80107663:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107666:	39 fb                	cmp    %edi,%ebx
80107668:	75 dd                	jne    80107647 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010766a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010766d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107670:	5b                   	pop    %ebx
80107671:	5e                   	pop    %esi
80107672:	5f                   	pop    %edi
80107673:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107674:	e9 a7 b0 ff ff       	jmp    80102720 <kfree>
    panic("freevm: no pgdir");
80107679:	83 ec 0c             	sub    $0xc,%esp
8010767c:	68 2c 90 10 80       	push   $0x8010902c
80107681:	e8 0a 8d ff ff       	call   80100390 <panic>
80107686:	8d 76 00             	lea    0x0(%esi),%esi
80107689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107690 <setupkvm>:
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	56                   	push   %esi
80107694:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107695:	e8 c6 b2 ff ff       	call   80102960 <kalloc>
8010769a:	85 c0                	test   %eax,%eax
8010769c:	89 c6                	mov    %eax,%esi
8010769e:	74 42                	je     801076e2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801076a0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801076a3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801076a8:	68 00 10 00 00       	push   $0x1000
801076ad:	6a 00                	push   $0x0
801076af:	50                   	push   %eax
801076b0:	e8 cb d6 ff ff       	call   80104d80 <memset>
801076b5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801076b8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801076bb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801076be:	83 ec 08             	sub    $0x8,%esp
801076c1:	8b 13                	mov    (%ebx),%edx
801076c3:	ff 73 0c             	pushl  0xc(%ebx)
801076c6:	50                   	push   %eax
801076c7:	29 c1                	sub    %eax,%ecx
801076c9:	89 f0                	mov    %esi,%eax
801076cb:	e8 00 fa ff ff       	call   801070d0 <mappages>
801076d0:	83 c4 10             	add    $0x10,%esp
801076d3:	85 c0                	test   %eax,%eax
801076d5:	78 19                	js     801076f0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801076d7:	83 c3 10             	add    $0x10,%ebx
801076da:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801076e0:	75 d6                	jne    801076b8 <setupkvm+0x28>
}
801076e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076e5:	89 f0                	mov    %esi,%eax
801076e7:	5b                   	pop    %ebx
801076e8:	5e                   	pop    %esi
801076e9:	5d                   	pop    %ebp
801076ea:	c3                   	ret    
801076eb:	90                   	nop
801076ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801076f0:	83 ec 0c             	sub    $0xc,%esp
801076f3:	56                   	push   %esi
      return 0;
801076f4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076f6:	e8 15 ff ff ff       	call   80107610 <freevm>
      return 0;
801076fb:	83 c4 10             	add    $0x10,%esp
}
801076fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107701:	89 f0                	mov    %esi,%eax
80107703:	5b                   	pop    %ebx
80107704:	5e                   	pop    %esi
80107705:	5d                   	pop    %ebp
80107706:	c3                   	ret    
80107707:	89 f6                	mov    %esi,%esi
80107709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107710 <kvmalloc>:
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107716:	e8 75 ff ff ff       	call   80107690 <setupkvm>
8010771b:	a3 c4 89 15 80       	mov    %eax,0x801589c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107720:	05 00 00 00 80       	add    $0x80000000,%eax
80107725:	0f 22 d8             	mov    %eax,%cr3
}
80107728:	c9                   	leave  
80107729:	c3                   	ret    
8010772a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107730 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107730:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107731:	31 c9                	xor    %ecx,%ecx
{
80107733:	89 e5                	mov    %esp,%ebp
80107735:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107738:	8b 55 0c             	mov    0xc(%ebp),%edx
8010773b:	8b 45 08             	mov    0x8(%ebp),%eax
8010773e:	e8 0d f9 ff ff       	call   80107050 <walkpgdir>
  if(pte == 0)
80107743:	85 c0                	test   %eax,%eax
80107745:	74 05                	je     8010774c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107747:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010774a:	c9                   	leave  
8010774b:	c3                   	ret    
    panic("clearpteu");
8010774c:	83 ec 0c             	sub    $0xc,%esp
8010774f:	68 3d 90 10 80       	push   $0x8010903d
80107754:	e8 37 8c ff ff       	call   80100390 <panic>
80107759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107760 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107760:	55                   	push   %ebp
80107761:	89 e5                	mov    %esp,%ebp
80107763:	57                   	push   %edi
80107764:	56                   	push   %esi
80107765:	53                   	push   %ebx
80107766:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
80107769:	e8 22 ff ff ff       	call   80107690 <setupkvm>
8010776e:	85 c0                	test   %eax,%eax
80107770:	89 c7                	mov    %eax,%edi
80107772:	0f 84 bf 00 00 00    	je     80107837 <copyuvm+0xd7>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107778:	8b 45 0c             	mov    0xc(%ebp),%eax
8010777b:	85 c0                	test   %eax,%eax
8010777d:	0f 84 a9 00 00 00    	je     8010782c <copyuvm+0xcc>
80107783:	31 db                	xor    %ebx,%ebx
80107785:	eb 53                	jmp    801077da <copyuvm+0x7a>
80107787:	89 f6                	mov    %esi,%esi
80107789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *pte = PTE_U | PTE_W | PTE_PG;
      lcr3(V2P(myproc()->pgdir));
      continue;
    }

    *pte &= ~PTE_W;
80107790:	89 d1                	mov    %edx,%ecx

    pa = PTE_ADDR(*pte);
80107792:	89 d6                	mov    %edx,%esi
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
80107794:	83 ec 08             	sub    $0x8,%esp
    *pte &= ~PTE_W;
80107797:	83 e1 fd             	and    $0xfffffffd,%ecx
    flags = PTE_FLAGS(*pte);
8010779a:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    pa = PTE_ADDR(*pte);
801077a0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    *pte &= ~PTE_W;
801077a6:	89 08                	mov    %ecx,(%eax)
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801077a8:	52                   	push   %edx
801077a9:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077ae:	56                   	push   %esi
801077af:	89 da                	mov    %ebx,%edx
801077b1:	89 f8                	mov    %edi,%eax
801077b3:	e8 18 f9 ff ff       	call   801070d0 <mappages>
801077b8:	83 c4 10             	add    $0x10,%esp
801077bb:	85 c0                	test   %eax,%eax
801077bd:	0f 88 85 00 00 00    	js     80107848 <copyuvm+0xe8>
      goto bad;
    }
    incrementReferenceCount(pa);
801077c3:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < sz; i += PGSIZE){
801077c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    incrementReferenceCount(pa);
801077cc:	56                   	push   %esi
801077cd:	e8 be b2 ff ff       	call   80102a90 <incrementReferenceCount>
801077d2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
801077d5:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801077d8:	76 52                	jbe    8010782c <copyuvm+0xcc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801077da:	8b 45 08             	mov    0x8(%ebp),%eax
801077dd:	31 c9                	xor    %ecx,%ecx
801077df:	89 da                	mov    %ebx,%edx
801077e1:	e8 6a f8 ff ff       	call   80107050 <walkpgdir>
801077e6:	85 c0                	test   %eax,%eax
801077e8:	0f 84 8a 00 00 00    	je     80107878 <copyuvm+0x118>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
801077ee:	8b 10                	mov    (%eax),%edx
801077f0:	f7 c2 01 02 00 00    	test   $0x201,%edx
801077f6:	74 73                	je     8010786b <copyuvm+0x10b>
    if(*pte & PTE_PG){
801077f8:	f6 c6 02             	test   $0x2,%dh
801077fb:	74 93                	je     80107790 <copyuvm+0x30>
      pte = walkpgdir(d, (void*) i, 1);
801077fd:	b9 01 00 00 00       	mov    $0x1,%ecx
80107802:	89 da                	mov    %ebx,%edx
80107804:	89 f8                	mov    %edi,%eax
80107806:	e8 45 f8 ff ff       	call   80107050 <walkpgdir>
      *pte = PTE_U | PTE_W | PTE_PG;
8010780b:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
      lcr3(V2P(myproc()->pgdir));
80107811:	e8 7a c6 ff ff       	call   80103e90 <myproc>
80107816:	8b 40 04             	mov    0x4(%eax),%eax
80107819:	05 00 00 00 80       	add    $0x80000000,%eax
8010781e:	0f 22 d8             	mov    %eax,%cr3
  for(i = 0; i < sz; i += PGSIZE){
80107821:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107827:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010782a:	77 ae                	ja     801077da <copyuvm+0x7a>
        goto bad;
      }
    #endif
    //cprintf("increased to: %d\n",getReferenceCount(pa));
  }
  lcr3(V2P(pgdir));
8010782c:	8b 45 08             	mov    0x8(%ebp),%eax
8010782f:	05 00 00 00 80       	add    $0x80000000,%eax
80107834:	0f 22 d8             	mov    %eax,%cr3

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107837:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010783a:	89 f8                	mov    %edi,%eax
8010783c:	5b                   	pop    %ebx
8010783d:	5e                   	pop    %esi
8010783e:	5f                   	pop    %edi
8010783f:	5d                   	pop    %ebp
80107840:	c3                   	ret    
80107841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  freevm(d);
80107848:	83 ec 0c             	sub    $0xc,%esp
8010784b:	57                   	push   %edi
8010784c:	e8 bf fd ff ff       	call   80107610 <freevm>
  lcr3(V2P(pgdir));
80107851:	8b 45 08             	mov    0x8(%ebp),%eax
80107854:	05 00 00 00 80       	add    $0x80000000,%eax
80107859:	0f 22 d8             	mov    %eax,%cr3
  return 0;
8010785c:	83 c4 10             	add    $0x10,%esp
}
8010785f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107862:	31 ff                	xor    %edi,%edi
}
80107864:	89 f8                	mov    %edi,%eax
80107866:	5b                   	pop    %ebx
80107867:	5e                   	pop    %esi
80107868:	5f                   	pop    %edi
80107869:	5d                   	pop    %ebp
8010786a:	c3                   	ret    
      panic("copyuvm: page not present");
8010786b:	83 ec 0c             	sub    $0xc,%esp
8010786e:	68 61 90 10 80       	push   $0x80109061
80107873:	e8 18 8b ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107878:	83 ec 0c             	sub    $0xc,%esp
8010787b:	68 47 90 10 80       	push   $0x80109047
80107880:	e8 0b 8b ff ff       	call   80100390 <panic>
80107885:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107890 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107890:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107891:	31 c9                	xor    %ecx,%ecx
{
80107893:	89 e5                	mov    %esp,%ebp
80107895:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107898:	8b 55 0c             	mov    0xc(%ebp),%edx
8010789b:	8b 45 08             	mov    0x8(%ebp),%eax
8010789e:	e8 ad f7 ff ff       	call   80107050 <walkpgdir>
  if((*pte & PTE_P) == 0)
801078a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801078a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801078a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801078a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801078ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801078b0:	05 00 00 00 80       	add    $0x80000000,%eax
801078b5:	83 fa 05             	cmp    $0x5,%edx
801078b8:	ba 00 00 00 00       	mov    $0x0,%edx
801078bd:	0f 45 c2             	cmovne %edx,%eax
}
801078c0:	c3                   	ret    
801078c1:	eb 0d                	jmp    801078d0 <copyout>
801078c3:	90                   	nop
801078c4:	90                   	nop
801078c5:	90                   	nop
801078c6:	90                   	nop
801078c7:	90                   	nop
801078c8:	90                   	nop
801078c9:	90                   	nop
801078ca:	90                   	nop
801078cb:	90                   	nop
801078cc:	90                   	nop
801078cd:	90                   	nop
801078ce:	90                   	nop
801078cf:	90                   	nop

801078d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	57                   	push   %edi
801078d4:	56                   	push   %esi
801078d5:	53                   	push   %ebx
801078d6:	83 ec 1c             	sub    $0x1c,%esp
801078d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801078dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801078df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801078e2:	85 db                	test   %ebx,%ebx
801078e4:	75 40                	jne    80107926 <copyout+0x56>
801078e6:	eb 70                	jmp    80107958 <copyout+0x88>
801078e8:	90                   	nop
801078e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801078f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801078f3:	89 f1                	mov    %esi,%ecx
801078f5:	29 d1                	sub    %edx,%ecx
801078f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801078fd:	39 d9                	cmp    %ebx,%ecx
801078ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107902:	29 f2                	sub    %esi,%edx
80107904:	83 ec 04             	sub    $0x4,%esp
80107907:	01 d0                	add    %edx,%eax
80107909:	51                   	push   %ecx
8010790a:	57                   	push   %edi
8010790b:	50                   	push   %eax
8010790c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010790f:	e8 1c d5 ff ff       	call   80104e30 <memmove>
    len -= n;
    buf += n;
80107914:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107917:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
8010791a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107920:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107922:	29 cb                	sub    %ecx,%ebx
80107924:	74 32                	je     80107958 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107926:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107928:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010792b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010792e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107934:	56                   	push   %esi
80107935:	ff 75 08             	pushl  0x8(%ebp)
80107938:	e8 53 ff ff ff       	call   80107890 <uva2ka>
    if(pa0 == 0)
8010793d:	83 c4 10             	add    $0x10,%esp
80107940:	85 c0                	test   %eax,%eax
80107942:	75 ac                	jne    801078f0 <copyout+0x20>
  }
  return 0;
}
80107944:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107947:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010794c:	5b                   	pop    %ebx
8010794d:	5e                   	pop    %esi
8010794e:	5f                   	pop    %edi
8010794f:	5d                   	pop    %ebp
80107950:	c3                   	ret    
80107951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107958:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010795b:	31 c0                	xor    %eax,%eax
}
8010795d:	5b                   	pop    %ebx
8010795e:	5e                   	pop    %esi
8010795f:	5f                   	pop    %edi
80107960:	5d                   	pop    %ebp
80107961:	c3                   	ret    
80107962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107970 <getLastPageSCFIFO>:
    }
  }
}

struct procPG*
getLastPageSCFIFO(){/******************************************************************************** SCFIFO :  getLastPage ***********************************/
80107970:	55                   	push   %ebp
80107971:	89 e5                	mov    %esp,%ebp
80107973:	57                   	push   %edi
80107974:	56                   	push   %esi
80107975:	53                   	push   %ebx
80107976:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107979:	e8 12 c5 ff ff       	call   80103e90 <myproc>

  //#pragma GCC diagnostic ignored "-Wmaybe-uninitialized";
  struct procPG *page = &p->physicalPGs[p->headPG];
8010797e:	8b 88 8c 00 00 00    	mov    0x8c(%eax),%ecx
  struct proc *p = myproc();
80107984:	89 c6                	mov    %eax,%esi
  struct procPG *page = &p->physicalPGs[p->headPG];
80107986:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80107989:	c1 e0 02             	shl    $0x2,%eax
8010798c:	8d 9c 06 90 01 00 00 	lea    0x190(%esi,%eax,1),%ebx
  struct procPG *headHolder = &p->physicalPGs[p->headPG];

  if(!page->next){
80107993:	8b 84 06 9c 01 00 00 	mov    0x19c(%esi,%eax,1),%eax
  struct procPG *page = &p->physicalPGs[p->headPG];
8010799a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  if(!page->next){
8010799d:	85 c0                	test   %eax,%eax
8010799f:	74 6c                	je     80107a0d <getLastPageSCFIFO+0x9d>
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical; i++)
801079a1:	8b 96 80 00 00 00    	mov    0x80(%esi),%edx
801079a7:	b8 01 00 00 00       	mov    $0x1,%eax
801079ac:	83 fa 01             	cmp    $0x1,%edx
801079af:	7e 11                	jle    801079c2 <getLastPageSCFIFO+0x52>
801079b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079b8:	83 c0 01             	add    $0x1,%eax
  {
      page = page->next;
801079bb:	8b 5b 0c             	mov    0xc(%ebx),%ebx
  for(i = 1; i < p->nPgsPhysical; i++)
801079be:	39 d0                	cmp    %edx,%eax
801079c0:	75 f6                	jne    801079b8 <getLastPageSCFIFO+0x48>
  pte_t *pte;
  struct procPG *tailHolder = &p->physicalPGs[p->headPG];
  while ((*(pte = walkpgdir(p->pgdir,(void*)page->va,0)) & PTE_A) != 0)
  {
    *pte &= ~PTE_A;
    if(page->va == headHolder->va){
801079c2:	8d 3c 89             	lea    (%ecx,%ecx,4),%edi
801079c5:	eb 1c                	jmp    801079e3 <getLastPageSCFIFO+0x73>
801079c7:	89 f6                	mov    %esi,%esi
801079c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *pte &= ~PTE_A;
801079d0:	83 e2 df             	and    $0xffffffdf,%edx
801079d3:	89 10                	mov    %edx,(%eax)
    if(page->va == headHolder->va){
801079d5:	8b 84 be 90 01 00 00 	mov    0x190(%esi,%edi,4),%eax
801079dc:	39 03                	cmp    %eax,(%ebx)
801079de:	74 20                	je     80107a00 <getLastPageSCFIFO+0x90>
      page = tailHolder; //in case all pages had PTE_A bit, return the last one as fifo
      return page;
    }
    page = page->prev;
801079e0:	8b 5b 10             	mov    0x10(%ebx),%ebx
  while ((*(pte = walkpgdir(p->pgdir,(void*)page->va,0)) & PTE_A) != 0)
801079e3:	8b 13                	mov    (%ebx),%edx
801079e5:	8b 46 04             	mov    0x4(%esi),%eax
801079e8:	31 c9                	xor    %ecx,%ecx
801079ea:	e8 61 f6 ff ff       	call   80107050 <walkpgdir>
801079ef:	8b 10                	mov    (%eax),%edx
801079f1:	f6 c2 20             	test   $0x20,%dl
801079f4:	75 da                	jne    801079d0 <getLastPageSCFIFO+0x60>
  }
  return page;
}
801079f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079f9:	89 d8                	mov    %ebx,%eax
801079fb:	5b                   	pop    %ebx
801079fc:	5e                   	pop    %esi
801079fd:	5f                   	pop    %edi
801079fe:	5d                   	pop    %ebp
801079ff:	c3                   	ret    
      return page;
80107a00:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
}
80107a03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a06:	89 d8                	mov    %ebx,%eax
80107a08:	5b                   	pop    %ebx
80107a09:	5e                   	pop    %esi
80107a0a:	5f                   	pop    %edi
80107a0b:	5d                   	pop    %ebp
80107a0c:	c3                   	ret    
    panic("getLastPG: empty headPG list");
80107a0d:	83 ec 0c             	sub    $0xc,%esp
80107a10:	68 7b 90 10 80       	push   $0x8010907b
80107a15:	e8 76 89 ff ff       	call   80100390 <panic>
80107a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a20 <scfifoWriteToSwap>:
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
80107a20:	55                   	push   %ebp
80107a21:	89 e5                	mov    %esp,%ebp
80107a23:	57                   	push   %edi
80107a24:	56                   	push   %esi
80107a25:	53                   	push   %ebx
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107a26:	31 db                	xor    %ebx,%ebx
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
80107a28:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107a2b:	e8 60 c4 ff ff       	call   80103e90 <myproc>
80107a30:	89 c6                	mov    %eax,%esi
80107a32:	05 9c 00 00 00       	add    $0x9c,%eax
80107a37:	eb 16                	jmp    80107a4f <scfifoWriteToSwap+0x2f>
80107a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107a40:	83 c3 01             	add    $0x1,%ebx
80107a43:	83 c0 10             	add    $0x10,%eax
    if(i== MAX_PSYC_PAGES){
80107a46:	83 fb 10             	cmp    $0x10,%ebx
80107a49:	0f 84 b1 00 00 00    	je     80107b00 <scfifoWriteToSwap+0xe0>
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107a4f:	83 38 ff             	cmpl   $0xffffffff,(%eax)
80107a52:	75 ec                	jne    80107a40 <scfifoWriteToSwap+0x20>
  if(p->headPG==-1){
80107a54:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
80107a5b:	0f 84 c6 00 00 00    	je     80107b27 <scfifoWriteToSwap+0x107>
  struct procPG *lastpg = getLastPageSCFIFO();
80107a61:	e8 0a ff ff ff       	call   80107970 <getLastPageSCFIFO>
  p->swappedPGs[i].va = lastpg->va;
80107a66:	8b 10                	mov    (%eax),%edx
  struct procPG *lastpg = getLastPageSCFIFO();
80107a68:	89 c7                	mov    %eax,%edi
  p->swappedPGs[i].va = lastpg->va;
80107a6a:	8d 43 09             	lea    0x9(%ebx),%eax
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107a6d:	c1 e3 0c             	shl    $0xc,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107a70:	c1 e0 04             	shl    $0x4,%eax
80107a73:	89 54 06 0c          	mov    %edx,0xc(%esi,%eax,1)
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107a77:	68 00 10 00 00       	push   $0x1000
80107a7c:	53                   	push   %ebx
80107a7d:	8b 07                	mov    (%edi),%eax
80107a7f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a84:	50                   	push   %eax
80107a85:	56                   	push   %esi
80107a86:	e8 45 a8 ff ff       	call   801022d0 <writeToSwapFile>
80107a8b:	83 c4 10             	add    $0x10,%esp
80107a8e:	85 c0                	test   %eax,%eax
80107a90:	0f 8e 84 00 00 00    	jle    80107b1a <scfifoWriteToSwap+0xfa>
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107a96:	8b 46 04             	mov    0x4(%esi),%eax
80107a99:	8b 17                	mov    (%edi),%edx
80107a9b:	31 c9                	xor    %ecx,%ecx
80107a9d:	e8 ae f5 ff ff       	call   80107050 <walkpgdir>
  if(!pte){
80107aa2:	85 c0                	test   %eax,%eax
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107aa4:	89 c3                	mov    %eax,%ebx
  if(!pte){
80107aa6:	74 65                	je     80107b0d <scfifoWriteToSwap+0xed>
  decrementReferenceCount(PTE_ADDR(*pte));
80107aa8:	8b 00                	mov    (%eax),%eax
80107aaa:	83 ec 0c             	sub    $0xc,%esp
80107aad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ab2:	50                   	push   %eax
80107ab3:	e8 88 af ff ff       	call   80102a40 <decrementReferenceCount>
  kfree((char*)PTE_ADDR(P2V(*pte)));
80107ab8:	8b 03                	mov    (%ebx),%eax
80107aba:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80107ac0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107ac6:	89 14 24             	mov    %edx,(%esp)
80107ac9:	e8 52 ac ff ff       	call   80102720 <kfree>
  lastpg->va = (char*)addr;
80107ace:	8b 45 08             	mov    0x8(%ebp),%eax
  *pte = PTE_W | PTE_U | PTE_PG;
80107ad1:	c7 03 06 02 00 00    	movl   $0x206,(%ebx)
  lastpg->va = (char*)addr;
80107ad7:	89 07                	mov    %eax,(%edi)
  movePageToHead(lastpg);
80107ad9:	89 3c 24             	mov    %edi,(%esp)
80107adc:	e8 ff 09 00 00       	call   801084e0 <movePageToHead>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107ae1:	8b 46 04             	mov    0x4(%esi),%eax
80107ae4:	05 00 00 00 80       	add    $0x80000000,%eax
80107ae9:	0f 22 d8             	mov    %eax,%cr3
}
80107aec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aef:	89 f8                	mov    %edi,%eax
80107af1:	5b                   	pop    %ebx
80107af2:	5e                   	pop    %esi
80107af3:	5f                   	pop    %edi
80107af4:	5d                   	pop    %ebp
80107af5:	c3                   	ret    
80107af6:	8d 76 00             	lea    0x0(%esi),%esi
80107af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107b00:	83 ec 0c             	sub    $0xc,%esp
80107b03:	68 58 91 10 80       	push   $0x80109158
80107b08:	e8 83 88 ff ff       	call   80100390 <panic>
    panic("scfifoWrite: !pte");
80107b0d:	83 ec 0c             	sub    $0xc,%esp
80107b10:	68 98 90 10 80       	push   $0x80109098
80107b15:	e8 76 88 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107b1a:	83 ec 0c             	sub    $0xc,%esp
80107b1d:	68 b4 91 10 80       	push   $0x801091b4
80107b22:	e8 69 88 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: empty headPG list");
80107b27:	83 ec 0c             	sub    $0xc,%esp
80107b2a:	68 8c 91 10 80       	push   $0x8010918c
80107b2f:	e8 5c 88 ff ff       	call   80100390 <panic>
80107b34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107b40 <initSCFIFO>:
initSCFIFO(char *va){/******************************************************************************* SCFIFO :  init *******************************************/
80107b40:	55                   	push   %ebp
80107b41:	89 e5                	mov    %esp,%ebp
80107b43:	56                   	push   %esi
80107b44:	53                   	push   %ebx
80107b45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107b48:	e8 43 c3 ff ff       	call   80103e90 <myproc>
  if(p->allocatedInPhys == 16){
80107b4d:	83 b8 88 00 00 00 10 	cmpl   $0x10,0x88(%eax)
80107b54:	0f 84 96 00 00 00    	je     80107bf0 <initSCFIFO+0xb0>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107b5a:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80107b61:	89 c6                	mov    %eax,%esi
  char* addrToOverwrite = (char*)0xffffffff;
80107b63:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107b68:	7f 6e                	jg     80107bd8 <initSCFIFO+0x98>
80107b6a:	8d 96 90 01 00 00    	lea    0x190(%esi),%edx
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107b70:	31 c0                	xor    %eax,%eax
80107b72:	eb 0f                	jmp    80107b83 <initSCFIFO+0x43>
80107b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b78:	83 c0 01             	add    $0x1,%eax
80107b7b:	83 c2 14             	add    $0x14,%edx
80107b7e:	83 f8 11             	cmp    $0x11,%eax
80107b81:	74 2c                	je     80107baf <initSCFIFO+0x6f>
    if(p->physicalPGs[i].va == addrToOverwrite){
80107b83:	39 0a                	cmp    %ecx,(%edx)
80107b85:	75 f1                	jne    80107b78 <initSCFIFO+0x38>
      p->physicalPGs[i].va = va;
80107b87:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107b8a:	c1 e2 02             	shl    $0x2,%edx
80107b8d:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
80107b90:	89 99 90 01 00 00    	mov    %ebx,0x190(%ecx)
      p->physicalPGs[i].refs = 1;
80107b96:	c7 81 94 01 00 00 01 	movl   $0x1,0x194(%ecx)
80107b9d:	00 00 00 
      if(p->headPG == -1){
80107ba0:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
        p->headPG = i;
80107ba7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
      if(p->headPG == -1){
80107bad:	75 11                	jne    80107bc0 <initSCFIFO+0x80>
}
80107baf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bb2:	5b                   	pop    %ebx
80107bb3:	5e                   	pop    %esi
80107bb4:	5d                   	pop    %ebp
80107bb5:	c3                   	ret    
80107bb6:	8d 76 00             	lea    0x0(%esi),%esi
80107bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      movePageToHead(&p->physicalPGs[i]);
80107bc0:	8d 84 16 90 01 00 00 	lea    0x190(%esi,%edx,1),%eax
80107bc7:	89 45 08             	mov    %eax,0x8(%ebp)
}
80107bca:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bcd:	5b                   	pop    %ebx
80107bce:	5e                   	pop    %esi
80107bcf:	5d                   	pop    %ebp
      movePageToHead(&p->physicalPGs[i]);
80107bd0:	e9 0b 09 00 00       	jmp    801084e0 <movePageToHead>
80107bd5:	8d 76 00             	lea    0x0(%esi),%esi
      myproc()->nPgsPhysical--;
80107bd8:	e8 b3 c2 ff ff       	call   80103e90 <myproc>
80107bdd:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
      addrToOverwrite = getLastPageSCFIFO()->va;
80107be4:	e8 87 fd ff ff       	call   80107970 <getLastPageSCFIFO>
80107be9:	8b 08                	mov    (%eax),%ecx
80107beb:	e9 7a ff ff ff       	jmp    80107b6a <initSCFIFO+0x2a>
    panic("initSCFIFO");
80107bf0:	83 ec 0c             	sub    $0xc,%esp
80107bf3:	68 aa 90 10 80       	push   $0x801090aa
80107bf8:	e8 93 87 ff ff       	call   80100390 <panic>
80107bfd:	8d 76 00             	lea    0x0(%esi),%esi

80107c00 <leastAgeIndex>:
/***************************************************************************************************************************************************************/
/******************************************************************************   NFUA     *********************************************************************/
/***************************************************************************************************************************************************************/

int
leastAgeIndex(){
80107c00:	55                   	push   %ebp
80107c01:	89 e5                	mov    %esp,%ebp
80107c03:	56                   	push   %esi
80107c04:	53                   	push   %ebx
  struct proc *p = myproc();
80107c05:	e8 86 c2 ff ff       	call   80103e90 <myproc>
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107c0a:	31 d2                	xor    %edx,%edx
    if(p->physicalPGs[i].age<=leastAge){
80107c0c:	8b b0 98 01 00 00    	mov    0x198(%eax),%esi
80107c12:	8d 88 ac 01 00 00    	lea    0x1ac(%eax),%ecx
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107c18:	31 c0                	xor    %eax,%eax
80107c1a:	eb 11                	jmp    80107c2d <leastAgeIndex+0x2d>
80107c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->physicalPGs[i].age<=leastAge){
80107c20:	8b 19                	mov    (%ecx),%ebx
80107c22:	39 f3                	cmp    %esi,%ebx
80107c24:	77 04                	ja     80107c2a <leastAgeIndex+0x2a>
80107c26:	89 d0                	mov    %edx,%eax
80107c28:	89 de                	mov    %ebx,%esi
80107c2a:	83 c1 14             	add    $0x14,%ecx
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107c2d:	83 c2 01             	add    $0x1,%edx
80107c30:	83 fa 10             	cmp    $0x10,%edx
80107c33:	75 eb                	jne    80107c20 <leastAgeIndex+0x20>
  if(i == -1){
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;

}
80107c35:	5b                   	pop    %ebx
80107c36:	5e                   	pop    %esi
80107c37:	5d                   	pop    %ebp
80107c38:	c3                   	ret    
80107c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c40 <nfuaWriteToSwap>:

struct procPG*
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
80107c40:	55                   	push   %ebp
80107c41:	89 e5                	mov    %esp,%ebp
80107c43:	57                   	push   %edi
80107c44:	56                   	push   %esi
80107c45:	53                   	push   %ebx
  struct proc *p = myproc();

  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107c46:	31 db                	xor    %ebx,%ebx
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
80107c48:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107c4b:	e8 40 c2 ff ff       	call   80103e90 <myproc>
80107c50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107c53:	05 9c 00 00 00       	add    $0x9c,%eax
80107c58:	eb 15                	jmp    80107c6f <nfuaWriteToSwap+0x2f>
80107c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107c60:	83 c3 01             	add    $0x1,%ebx
80107c63:	83 c0 10             	add    $0x10,%eax
    if(i== MAX_PSYC_PAGES){
80107c66:	83 fb 10             	cmp    $0x10,%ebx
80107c69:	0f 84 41 01 00 00    	je     80107db0 <nfuaWriteToSwap+0x170>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107c6f:	83 38 ff             	cmpl   $0xffffffff,(%eax)
80107c72:	75 ec                	jne    80107c60 <nfuaWriteToSwap+0x20>
      break;
    }
  }

  if(p->headPG==-1){
80107c74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107c77:	83 b8 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%eax)
80107c7e:	0f 84 53 01 00 00    	je     80107dd7 <nfuaWriteToSwap+0x197>
  struct proc *p = myproc();
80107c84:	e8 07 c2 ff ff       	call   80103e90 <myproc>
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107c89:	31 f6                	xor    %esi,%esi
    if(p->physicalPGs[i].age<=leastAge){
80107c8b:	8b b8 98 01 00 00    	mov    0x198(%eax),%edi
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107c91:	31 d2                	xor    %edx,%edx
80107c93:	05 ac 01 00 00       	add    $0x1ac,%eax
80107c98:	eb 13                	jmp    80107cad <nfuaWriteToSwap+0x6d>
80107c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->physicalPGs[i].age<=leastAge){
80107ca0:	8b 08                	mov    (%eax),%ecx
80107ca2:	39 f9                	cmp    %edi,%ecx
80107ca4:	77 04                	ja     80107caa <nfuaWriteToSwap+0x6a>
80107ca6:	89 d6                	mov    %edx,%esi
80107ca8:	89 cf                	mov    %ecx,%edi
80107caa:	83 c0 14             	add    $0x14,%eax
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107cad:	83 c2 01             	add    $0x1,%edx
80107cb0:	83 fa 10             	cmp    $0x10,%edx
80107cb3:	75 eb                	jne    80107ca0 <nfuaWriteToSwap+0x60>
    panic("scfifoWriteToSwap: empty headPG list");
  }

  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107cb5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107cb8:	8d 14 b6             	lea    (%esi,%esi,4),%edx
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107cbb:	31 c9                	xor    %ecx,%ecx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107cbd:	c1 e2 02             	shl    $0x2,%edx
80107cc0:	8d bc 10 90 01 00 00 	lea    0x190(%eax,%edx,1),%edi
80107cc7:	89 7d e0             	mov    %edi,-0x20(%ebp)
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107cca:	89 c7                	mov    %eax,%edi
80107ccc:	8b 40 04             	mov    0x4(%eax),%eax
80107ccf:	8b 94 17 90 01 00 00 	mov    0x190(%edi,%edx,1),%edx
80107cd6:	e8 75 f3 ff ff       	call   80107050 <walkpgdir>

  if(!pte){
80107cdb:	85 c0                	test   %eax,%eax
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107cdd:	89 c7                	mov    %eax,%edi
  if(!pte){
80107cdf:	0f 84 e5 00 00 00    	je     80107dca <nfuaWriteToSwap+0x18a>
    panic("scfifoWrite: !pte");
  }

  acquire(&tickslock);
80107ce5:	83 ec 0c             	sub    $0xc,%esp
80107ce8:	68 80 81 15 80       	push   $0x80158180
80107ced:	e8 7e cf ff ff       	call   80104c70 <acquire>
  if(*pte & PTE_A){
80107cf2:	8b 07                	mov    (%edi),%eax
80107cf4:	83 c4 10             	add    $0x10,%esp
80107cf7:	a8 20                	test   $0x20,%al
80107cf9:	0f 85 a1 00 00 00    	jne    80107da0 <nfuaWriteToSwap+0x160>
    *pte &= ~PTE_A;
  }
  release(&tickslock);
80107cff:	83 ec 0c             	sub    $0xc,%esp
80107d02:	68 80 81 15 80       	push   $0x80158180
80107d07:	e8 24 d0 ff ff       	call   80104d30 <release>

  p->swappedPGs[i].va = leastAgePG->va;
80107d0c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107d0f:	8d 04 b6             	lea    (%esi,%esi,4),%eax
80107d12:	8d 4b 09             	lea    0x9(%ebx),%ecx

  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107d15:	c1 e3 0c             	shl    $0xc,%ebx
  p->swappedPGs[i].va = leastAgePG->va;
80107d18:	c1 e1 04             	shl    $0x4,%ecx
80107d1b:	8d 34 82             	lea    (%edx,%eax,4),%esi
80107d1e:	8b 86 90 01 00 00    	mov    0x190(%esi),%eax
80107d24:	89 44 0a 0c          	mov    %eax,0xc(%edx,%ecx,1)
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107d28:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d2d:	68 00 10 00 00       	push   $0x1000
80107d32:	53                   	push   %ebx
80107d33:	50                   	push   %eax
80107d34:	52                   	push   %edx
80107d35:	e8 96 a5 ff ff       	call   801022d0 <writeToSwapFile>
80107d3a:	83 c4 20             	add    $0x20,%esp
80107d3d:	85 c0                	test   %eax,%eax
80107d3f:	7e 7c                	jle    80107dbd <nfuaWriteToSwap+0x17d>
    panic("scfifoWriteToSwap: writeToSwapFile");
  }



  decrementReferenceCount(PTE_ADDR(*pte));
80107d41:	8b 07                	mov    (%edi),%eax
80107d43:	83 ec 0c             	sub    $0xc,%esp
80107d46:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d4b:	50                   	push   %eax
80107d4c:	e8 ef ac ff ff       	call   80102a40 <decrementReferenceCount>
  kfree((char*)PTE_ADDR(P2V(*pte)));
80107d51:	8b 07                	mov    (%edi),%eax
80107d53:	05 00 00 00 80       	add    $0x80000000,%eax
80107d58:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d5d:	89 04 24             	mov    %eax,(%esp)
80107d60:	e8 bb a9 ff ff       	call   80102720 <kfree>
  *pte = PTE_W | PTE_U | PTE_PG;

  //sets the empty page to the head of the proc page list
  leastAgePG->va = (char*)addr;
80107d65:	8b 45 08             	mov    0x8(%ebp),%eax
  *pte = PTE_W | PTE_U | PTE_PG;
80107d68:	c7 07 06 02 00 00    	movl   $0x206,(%edi)
  leastAgePG->va = (char*)addr;
80107d6e:	89 86 90 01 00 00    	mov    %eax,0x190(%esi)

  movePageToHead(leastAgePG);
80107d74:	8b 75 e0             	mov    -0x20(%ebp),%esi
80107d77:	89 34 24             	mov    %esi,(%esp)
80107d7a:	e8 61 07 00 00       	call   801084e0 <movePageToHead>

  lcr3(V2P(p->pgdir));  // switch to process's address space
80107d7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d82:	8b 40 04             	mov    0x4(%eax),%eax
80107d85:	05 00 00 00 80       	add    $0x80000000,%eax
80107d8a:	0f 22 d8             	mov    %eax,%cr3

  return leastAgePG;
}
80107d8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d90:	89 f0                	mov    %esi,%eax
80107d92:	5b                   	pop    %ebx
80107d93:	5e                   	pop    %esi
80107d94:	5f                   	pop    %edi
80107d95:	5d                   	pop    %ebp
80107d96:	c3                   	ret    
80107d97:	89 f6                	mov    %esi,%esi
80107d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    *pte &= ~PTE_A;
80107da0:	83 e0 df             	and    $0xffffffdf,%eax
80107da3:	89 07                	mov    %eax,(%edi)
80107da5:	e9 55 ff ff ff       	jmp    80107cff <nfuaWriteToSwap+0xbf>
80107daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107db0:	83 ec 0c             	sub    $0xc,%esp
80107db3:	68 58 91 10 80       	push   $0x80109158
80107db8:	e8 d3 85 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107dbd:	83 ec 0c             	sub    $0xc,%esp
80107dc0:	68 b4 91 10 80       	push   $0x801091b4
80107dc5:	e8 c6 85 ff ff       	call   80100390 <panic>
    panic("scfifoWrite: !pte");
80107dca:	83 ec 0c             	sub    $0xc,%esp
80107dcd:	68 98 90 10 80       	push   $0x80109098
80107dd2:	e8 b9 85 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: empty headPG list");
80107dd7:	83 ec 0c             	sub    $0xc,%esp
80107dda:	68 8c 91 10 80       	push   $0x8010918c
80107ddf:	e8 ac 85 ff ff       	call   80100390 <panic>
80107de4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107dea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107df0 <initNFUA>:

  lcr3(V2P(p->pgdir));
}

void
initNFUA(char *va){/******************************************************************************* NFUA :  init ***********************************************/
80107df0:	55                   	push   %ebp
80107df1:	89 e5                	mov    %esp,%ebp
80107df3:	56                   	push   %esi
80107df4:	53                   	push   %ebx
80107df5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107df8:	e8 93 c0 ff ff       	call   80103e90 <myproc>
  int i;
  char* addrToOverwrite = (char*)0xffffffff;
  if(p->allocatedInPhys == 16){
80107dfd:	83 b8 88 00 00 00 10 	cmpl   $0x10,0x88(%eax)
80107e04:	0f 84 96 00 00 00    	je     80107ea0 <initNFUA+0xb0>
    panic("initSCFIFO");
  }
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107e0a:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80107e11:	89 c6                	mov    %eax,%esi
  char* addrToOverwrite = (char*)0xffffffff;
80107e13:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107e18:	7f 6e                	jg     80107e88 <initNFUA+0x98>
80107e1a:	8d 96 90 01 00 00    	lea    0x190(%esi),%edx
      myproc()->nPgsPhysical--;

      addrToOverwrite = getLastPageSCFIFO()->va;
    //p->allocatedInPhys++;
  }
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107e20:	31 c0                	xor    %eax,%eax
80107e22:	eb 0f                	jmp    80107e33 <initNFUA+0x43>
80107e24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e28:	83 c0 01             	add    $0x1,%eax
80107e2b:	83 c2 14             	add    $0x14,%edx
80107e2e:	83 f8 11             	cmp    $0x11,%eax
80107e31:	74 2c                	je     80107e5f <initNFUA+0x6f>

    if(p->physicalPGs[i].va == addrToOverwrite){
80107e33:	39 0a                	cmp    %ecx,(%edx)
80107e35:	75 f1                	jne    80107e28 <initNFUA+0x38>
      p->physicalPGs[i].va = va;
80107e37:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107e3a:	c1 e2 02             	shl    $0x2,%edx
80107e3d:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
80107e40:	89 99 90 01 00 00    	mov    %ebx,0x190(%ecx)
      p->physicalPGs[i].age = 0;
80107e46:	c7 81 98 01 00 00 00 	movl   $0x0,0x198(%ecx)
80107e4d:	00 00 00 

      if(p->headPG == -1){
80107e50:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
        p->headPG = i;
80107e57:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
      if(p->headPG == -1){
80107e5d:	75 11                	jne    80107e70 <initNFUA+0x80>
      p->headPG = i;
      movePageToHead(&p->physicalPGs[i]);
      return;
    }
  }
}
80107e5f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107e62:	5b                   	pop    %ebx
80107e63:	5e                   	pop    %esi
80107e64:	5d                   	pop    %ebp
80107e65:	c3                   	ret    
80107e66:	8d 76 00             	lea    0x0(%esi),%esi
80107e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      movePageToHead(&p->physicalPGs[i]);
80107e70:	8d 84 16 90 01 00 00 	lea    0x190(%esi,%edx,1),%eax
80107e77:	89 45 08             	mov    %eax,0x8(%ebp)
}
80107e7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107e7d:	5b                   	pop    %ebx
80107e7e:	5e                   	pop    %esi
80107e7f:	5d                   	pop    %ebp
      movePageToHead(&p->physicalPGs[i]);
80107e80:	e9 5b 06 00 00       	jmp    801084e0 <movePageToHead>
80107e85:	8d 76 00             	lea    0x0(%esi),%esi
      myproc()->nPgsPhysical--;
80107e88:	e8 03 c0 ff ff       	call   80103e90 <myproc>
80107e8d:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
      addrToOverwrite = getLastPageSCFIFO()->va;
80107e94:	e8 d7 fa ff ff       	call   80107970 <getLastPageSCFIFO>
80107e99:	8b 08                	mov    (%eax),%ecx
80107e9b:	e9 7a ff ff ff       	jmp    80107e1a <initNFUA+0x2a>
    panic("initSCFIFO");
80107ea0:	83 ec 0c             	sub    $0xc,%esp
80107ea3:	68 aa 90 10 80       	push   $0x801090aa
80107ea8:	e8 e3 84 ff ff       	call   80100390 <panic>
80107ead:	8d 76 00             	lea    0x0(%esi),%esi

80107eb0 <indexInSwapFile>:
/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/
int
indexInSwapFile(uint addr){
80107eb0:	55                   	push   %ebp
80107eb1:	89 e5                	mov    %esp,%ebp
80107eb3:	83 ec 08             	sub    $0x8,%esp
  struct proc *p =myproc();
80107eb6:	e8 d5 bf ff ff       	call   80103e90 <myproc>
80107ebb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107ebe:	8d 90 9c 00 00 00    	lea    0x9c(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107ec4:	31 c0                	xor    %eax,%eax
80107ec6:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107ecc:	eb 0d                	jmp    80107edb <indexInSwapFile+0x2b>
80107ece:	66 90                	xchg   %ax,%ax
80107ed0:	83 c0 01             	add    $0x1,%eax
80107ed3:	83 c2 10             	add    $0x10,%edx
80107ed6:	83 f8 10             	cmp    $0x10,%eax
80107ed9:	74 0d                	je     80107ee8 <indexInSwapFile+0x38>

    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
80107edb:	39 0a                	cmp    %ecx,(%edx)
80107edd:	75 f1                	jne    80107ed0 <indexInSwapFile+0x20>
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107edf:	c9                   	leave  
80107ee0:	c3                   	ret    
80107ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  panic("scfifoSwap: could not find page in swap file");
80107ee8:	83 ec 0c             	sub    $0xc,%esp
80107eeb:	68 d8 91 10 80       	push   $0x801091d8
80107ef0:	e8 9b 84 ff ff       	call   80100390 <panic>
80107ef5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f00 <scfifoSwap>:
scfifoSwap(uint addr){/******************************************************************************** SCFIFO :  swap *****************************************/
80107f00:	55                   	push   %ebp
80107f01:	89 e5                	mov    %esp,%ebp
80107f03:	57                   	push   %edi
80107f04:	56                   	push   %esi
80107f05:	53                   	push   %ebx
80107f06:	81 ec 2c 04 00 00    	sub    $0x42c,%esp
  struct proc *p = myproc();
80107f0c:	e8 7f bf ff ff       	call   80103e90 <myproc>
80107f11:	89 c6                	mov    %eax,%esi
  struct procPG *lastpg = getLastPageSCFIFO();
80107f13:	e8 58 fa ff ff       	call   80107970 <getLastPageSCFIFO>
80107f18:	89 c7                	mov    %eax,%edi
80107f1a:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107f20:	8b 46 04             	mov    0x4(%esi),%eax
80107f23:	8b 17                	mov    (%edi),%edx
80107f25:	31 c9                	xor    %ecx,%ecx
80107f27:	e8 24 f1 ff ff       	call   80107050 <walkpgdir>
  int i = indexInSwapFile(addr);
80107f2c:	83 ec 0c             	sub    $0xc,%esp
80107f2f:	ff 75 08             	pushl  0x8(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107f32:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
  int i = indexInSwapFile(addr);
80107f38:	e8 73 ff ff ff       	call   80107eb0 <indexInSwapFile>
  p->swappedPGs[i].va = lastpg->va;
80107f3d:	8b 17                	mov    (%edi),%edx
  int i = indexInSwapFile(addr);
80107f3f:	89 c3                	mov    %eax,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107f41:	83 c0 09             	add    $0x9,%eax
80107f44:	c1 e0 04             	shl    $0x4,%eax
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107f47:	31 c9                	xor    %ecx,%ecx
  p->swappedPGs[i].va = lastpg->va;
80107f49:	89 54 06 0c          	mov    %edx,0xc(%esi,%eax,1)
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107f4d:	8b 55 08             	mov    0x8(%ebp),%edx
80107f50:	8b 46 04             	mov    0x4(%esi),%eax
80107f53:	e8 f8 f0 ff ff       	call   80107050 <walkpgdir>
  if(!*pte2){
80107f58:	8b 10                	mov    (%eax),%edx
80107f5a:	83 c4 10             	add    $0x10,%esp
80107f5d:	85 d2                	test   %edx,%edx
80107f5f:	0f 84 26 01 00 00    	je     8010808b <scfifoSwap+0x18b>
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
80107f65:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
80107f6b:	c1 e3 0c             	shl    $0xc,%ebx
80107f6e:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
80107f74:	89 9d d8 fb ff ff    	mov    %ebx,-0x428(%ebp)
    int loc = (i * PGSIZE) + ((PGSIZE / 4) * j);
80107f7a:	31 db                	xor    %ebx,%ebx
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
80107f7c:	8b 09                	mov    (%ecx),%ecx
80107f7e:	89 ca                	mov    %ecx,%edx
80107f80:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107f86:	83 ca 05             	or     $0x5,%edx
80107f89:	89 10                	mov    %edx,(%eax)
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80107f8b:	8b 45 08             	mov    0x8(%ebp),%eax
80107f8e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f93:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    memset(buf, 0, PGSIZE / 4);
80107f99:	83 ec 04             	sub    $0x4,%esp
80107f9c:	68 00 04 00 00       	push   $0x400
80107fa1:	6a 00                	push   $0x0
80107fa3:	57                   	push   %edi
80107fa4:	e8 d7 cd ff ff       	call   80104d80 <memset>
80107fa9:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
    if(readFromSwapFile(p, buf, loc, PGSIZE / 4) <= 0){
80107faf:	68 00 04 00 00       	push   $0x400
80107fb4:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80107fb7:	52                   	push   %edx
80107fb8:	57                   	push   %edi
80107fb9:	56                   	push   %esi
80107fba:	89 95 e4 fb ff ff    	mov    %edx,-0x41c(%ebp)
80107fc0:	e8 3b a3 ff ff       	call   80102300 <readFromSwapFile>
80107fc5:	83 c4 20             	add    $0x20,%esp
80107fc8:	85 c0                	test   %eax,%eax
80107fca:	8b 95 e4 fb ff ff    	mov    -0x41c(%ebp),%edx
80107fd0:	0f 8e a8 00 00 00    	jle    8010807e <scfifoSwap+0x17e>
    if(writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1)) + addroffset), loc, PGSIZE / 4)<= 0){
80107fd6:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
80107fdc:	68 00 04 00 00       	push   $0x400
80107fe1:	52                   	push   %edx
80107fe2:	8b 00                	mov    (%eax),%eax
80107fe4:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
80107fea:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107fef:	8d 84 03 00 00 00 80 	lea    -0x80000000(%ebx,%eax,1),%eax
80107ff6:	50                   	push   %eax
80107ff7:	56                   	push   %esi
80107ff8:	e8 d3 a2 ff ff       	call   801022d0 <writeToSwapFile>
80107ffd:	83 c4 10             	add    $0x10,%esp
80108000:	85 c0                	test   %eax,%eax
80108002:	7e 7a                	jle    8010807e <scfifoSwap+0x17e>
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80108004:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
8010800a:	83 ec 04             	sub    $0x4,%esp
8010800d:	68 00 04 00 00       	push   $0x400
80108012:	57                   	push   %edi
80108013:	01 d8                	add    %ebx,%eax
80108015:	81 c3 00 04 00 00    	add    $0x400,%ebx
8010801b:	50                   	push   %eax
8010801c:	e8 0f ce ff ff       	call   80104e30 <memmove>
  for (j = 0; j < 4; j++) {
80108021:	83 c4 10             	add    $0x10,%esp
80108024:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
8010802a:	0f 85 69 ff ff ff    	jne    80107f99 <scfifoSwap+0x99>
  *pte1 = PTE_U | PTE_W | PTE_PG;
80108030:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
    *pte1 &= ~PTE_W;
80108036:	31 c0                	xor    %eax,%eax
  *pte1 = PTE_U | PTE_W | PTE_PG;
80108038:	c7 01 06 02 00 00    	movl   $0x206,(%ecx)
    *pte1 &= ~PTE_W;
8010803e:	83 be 88 00 00 00 10 	cmpl   $0x10,0x88(%esi)
80108045:	0f 9c c0             	setl   %al
  movePageToHead(lastpg);
80108048:	83 ec 0c             	sub    $0xc,%esp
    *pte1 &= ~PTE_W;
8010804b:	8d 84 00 04 02 00 00 	lea    0x204(%eax,%eax,1),%eax
80108052:	89 01                	mov    %eax,(%ecx)
  lastpg->va = (char*)PTE_ADDR(addr);
80108054:	8b 85 d4 fb ff ff    	mov    -0x42c(%ebp),%eax
8010805a:	8b 8d dc fb ff ff    	mov    -0x424(%ebp),%ecx
80108060:	89 08                	mov    %ecx,(%eax)
  movePageToHead(lastpg);
80108062:	50                   	push   %eax
80108063:	e8 78 04 00 00       	call   801084e0 <movePageToHead>
  lcr3(V2P(p->pgdir));
80108068:	8b 46 04             	mov    0x4(%esi),%eax
8010806b:	05 00 00 00 80       	add    $0x80000000,%eax
80108070:	0f 22 d8             	mov    %eax,%cr3
}
80108073:	83 c4 10             	add    $0x10,%esp
80108076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108079:	5b                   	pop    %ebx
8010807a:	5e                   	pop    %esi
8010807b:	5f                   	pop    %edi
8010807c:	5d                   	pop    %ebp
8010807d:	c3                   	ret    
      panic("scfifoSwap: read from swapfile");
8010807e:	83 ec 0c             	sub    $0xc,%esp
80108081:	68 08 92 10 80       	push   $0x80109208
80108086:	e8 05 83 ff ff       	call   80100390 <panic>
    panic("scfifoSwap: pte2 empty");
8010808b:	83 ec 0c             	sub    $0xc,%esp
8010808e:	68 b5 90 10 80       	push   $0x801090b5
80108093:	e8 f8 82 ff ff       	call   80100390 <panic>
80108098:	90                   	nop
80108099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801080a0 <nfuaSwap>:
nfuaSwap(uint addr){/******************************************************************************** NFUA :  swap *********************************************/
801080a0:	55                   	push   %ebp
801080a1:	89 e5                	mov    %esp,%ebp
801080a3:	57                   	push   %edi
801080a4:	56                   	push   %esi
801080a5:	53                   	push   %ebx
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
801080a6:	31 ff                	xor    %edi,%edi
nfuaSwap(uint addr){/******************************************************************************** NFUA :  swap *********************************************/
801080a8:	81 ec 2c 04 00 00    	sub    $0x42c,%esp
  struct proc *p = myproc();
801080ae:	e8 dd bd ff ff       	call   80103e90 <myproc>
801080b3:	89 c6                	mov    %eax,%esi
  struct proc *p = myproc();
801080b5:	e8 d6 bd ff ff       	call   80103e90 <myproc>
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
801080ba:	31 d2                	xor    %edx,%edx
    if(p->physicalPGs[i].age<=leastAge){
801080bc:	8b 98 98 01 00 00    	mov    0x198(%eax),%ebx
801080c2:	05 ac 01 00 00       	add    $0x1ac,%eax
801080c7:	eb 14                	jmp    801080dd <nfuaSwap+0x3d>
801080c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801080d0:	8b 08                	mov    (%eax),%ecx
801080d2:	39 d9                	cmp    %ebx,%ecx
801080d4:	77 04                	ja     801080da <nfuaSwap+0x3a>
801080d6:	89 d7                	mov    %edx,%edi
801080d8:	89 cb                	mov    %ecx,%ebx
801080da:	83 c0 14             	add    $0x14,%eax
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
801080dd:	83 c2 01             	add    $0x1,%edx
801080e0:	83 fa 10             	cmp    $0x10,%edx
801080e3:	75 eb                	jne    801080d0 <nfuaSwap+0x30>
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
801080e5:	8d 1c bf             	lea    (%edi,%edi,4),%ebx
  pte1 = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
801080e8:	31 c9                	xor    %ecx,%ecx
801080ea:	89 bd d0 fb ff ff    	mov    %edi,-0x430(%ebp)
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
801080f0:	c1 e3 02             	shl    $0x2,%ebx
801080f3:	8d 84 1e 90 01 00 00 	lea    0x190(%esi,%ebx,1),%eax
  pte1 = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
801080fa:	01 f3                	add    %esi,%ebx
801080fc:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80108102:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80108108:	8b 46 04             	mov    0x4(%esi),%eax
8010810b:	e8 40 ef ff ff       	call   80107050 <walkpgdir>
  int i = indexInSwapFile(addr);
80108110:	83 ec 0c             	sub    $0xc,%esp
80108113:	ff 75 08             	pushl  0x8(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80108116:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
  int i = indexInSwapFile(addr);
8010811c:	e8 8f fd ff ff       	call   80107eb0 <indexInSwapFile>
  p->swappedPGs[i].va = leastAgePG->va;
80108121:	8b 93 90 01 00 00    	mov    0x190(%ebx),%edx
  int i = indexInSwapFile(addr);
80108127:	89 c7                	mov    %eax,%edi
  p->swappedPGs[i].va = leastAgePG->va;
80108129:	8d 40 09             	lea    0x9(%eax),%eax
8010812c:	c1 e0 04             	shl    $0x4,%eax
8010812f:	89 54 06 0c          	mov    %edx,0xc(%esi,%eax,1)
  acquire(&tickslock);
80108133:	c7 04 24 80 81 15 80 	movl   $0x80158180,(%esp)
8010813a:	e8 31 cb ff ff       	call   80104c70 <acquire>
  if(*pte1 & PTE_A){
8010813f:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
80108145:	83 c4 10             	add    $0x10,%esp
80108148:	8b 01                	mov    (%ecx),%eax
8010814a:	a8 20                	test   $0x20,%al
8010814c:	74 05                	je     80108153 <nfuaSwap+0xb3>
    *pte1 &= ~PTE_A;
8010814e:	83 e0 df             	and    $0xffffffdf,%eax
80108151:	89 01                	mov    %eax,(%ecx)
  release(&tickslock);
80108153:	83 ec 0c             	sub    $0xc,%esp
80108156:	68 80 81 15 80       	push   $0x80158180
8010815b:	e8 d0 cb ff ff       	call   80104d30 <release>
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80108160:	8b 55 08             	mov    0x8(%ebp),%edx
80108163:	8b 46 04             	mov    0x4(%esi),%eax
80108166:	31 c9                	xor    %ecx,%ecx
80108168:	e8 e3 ee ff ff       	call   80107050 <walkpgdir>
  if(!*pte2){
8010816d:	8b 10                	mov    (%eax),%edx
8010816f:	83 c4 10             	add    $0x10,%esp
80108172:	85 d2                	test   %edx,%edx
80108174:	0f 84 27 01 00 00    	je     801082a1 <nfuaSwap+0x201>
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
8010817a:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
80108180:	c1 e7 0c             	shl    $0xc,%edi
    int loc = (i * PGSIZE) + ((PGSIZE / 4) * j);
80108183:	31 db                	xor    %ebx,%ebx
80108185:	89 bd dc fb ff ff    	mov    %edi,-0x424(%ebp)
8010818b:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
80108191:	8b 09                	mov    (%ecx),%ecx
80108193:	89 ca                	mov    %ecx,%edx
80108195:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010819b:	83 ca 05             	or     $0x5,%edx
8010819e:	89 10                	mov    %edx,(%eax)
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
801081a0:	8b 45 08             	mov    0x8(%ebp),%eax
801081a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081a8:	89 85 d8 fb ff ff    	mov    %eax,-0x428(%ebp)
    memset(buf, 0, PGSIZE / 4);
801081ae:	83 ec 04             	sub    $0x4,%esp
801081b1:	68 00 04 00 00       	push   $0x400
801081b6:	6a 00                	push   $0x0
801081b8:	57                   	push   %edi
801081b9:	e8 c2 cb ff ff       	call   80104d80 <memset>
801081be:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    if(readFromSwapFile(p, buf, loc, PGSIZE / 4) <= 0){
801081c4:	68 00 04 00 00       	push   $0x400
801081c9:	8d 14 18             	lea    (%eax,%ebx,1),%edx
801081cc:	52                   	push   %edx
801081cd:	57                   	push   %edi
801081ce:	56                   	push   %esi
801081cf:	89 95 e4 fb ff ff    	mov    %edx,-0x41c(%ebp)
801081d5:	e8 26 a1 ff ff       	call   80102300 <readFromSwapFile>
801081da:	83 c4 20             	add    $0x20,%esp
801081dd:	85 c0                	test   %eax,%eax
801081df:	8b 95 e4 fb ff ff    	mov    -0x41c(%ebp),%edx
801081e5:	0f 8e a9 00 00 00    	jle    80108294 <nfuaSwap+0x1f4>
    if(writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1)) + addroffset), loc, PGSIZE / 4)<= 0){
801081eb:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
801081f1:	68 00 04 00 00       	push   $0x400
801081f6:	52                   	push   %edx
801081f7:	8b 00                	mov    (%eax),%eax
801081f9:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
801081ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108204:	8d 84 03 00 00 00 80 	lea    -0x80000000(%ebx,%eax,1),%eax
8010820b:	50                   	push   %eax
8010820c:	56                   	push   %esi
8010820d:	e8 be a0 ff ff       	call   801022d0 <writeToSwapFile>
80108212:	83 c4 10             	add    $0x10,%esp
80108215:	85 c0                	test   %eax,%eax
80108217:	7e 7b                	jle    80108294 <nfuaSwap+0x1f4>
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80108219:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
8010821f:	83 ec 04             	sub    $0x4,%esp
80108222:	68 00 04 00 00       	push   $0x400
80108227:	57                   	push   %edi
80108228:	01 d8                	add    %ebx,%eax
8010822a:	81 c3 00 04 00 00    	add    $0x400,%ebx
80108230:	50                   	push   %eax
80108231:	e8 fa cb ff ff       	call   80104e30 <memmove>
  for (j = 0; j < 4; j++) {
80108236:	83 c4 10             	add    $0x10,%esp
80108239:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
8010823f:	0f 85 69 ff ff ff    	jne    801081ae <nfuaSwap+0x10e>
  *pte1 = PTE_U | PTE_W | PTE_PG;
80108245:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
  leastAgePG->va = (char*)addr;
8010824b:	8b 7d 08             	mov    0x8(%ebp),%edi
  movePageToHead(leastAgePG);
8010824e:	83 ec 0c             	sub    $0xc,%esp
  *pte1 = PTE_U | PTE_W | PTE_PG;
80108251:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  leastAgePG->va = (char*)addr;
80108257:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
8010825d:	8d 04 80             	lea    (%eax,%eax,4),%eax
80108260:	8d 04 86             	lea    (%esi,%eax,4),%eax
80108263:	89 b8 90 01 00 00    	mov    %edi,0x190(%eax)
  leastAgePG->age = 0;
80108269:	c7 80 98 01 00 00 00 	movl   $0x0,0x198(%eax)
80108270:	00 00 00 
  movePageToHead(leastAgePG);
80108273:	ff b5 d4 fb ff ff    	pushl  -0x42c(%ebp)
80108279:	e8 62 02 00 00       	call   801084e0 <movePageToHead>
  lcr3(V2P(p->pgdir));
8010827e:	8b 46 04             	mov    0x4(%esi),%eax
80108281:	05 00 00 00 80       	add    $0x80000000,%eax
80108286:	0f 22 d8             	mov    %eax,%cr3
}
80108289:	83 c4 10             	add    $0x10,%esp
8010828c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010828f:	5b                   	pop    %ebx
80108290:	5e                   	pop    %esi
80108291:	5f                   	pop    %edi
80108292:	5d                   	pop    %ebp
80108293:	c3                   	ret    
      panic("scfifoSwap: read from swapfile");
80108294:	83 ec 0c             	sub    $0xc,%esp
80108297:	68 08 92 10 80       	push   $0x80109208
8010829c:	e8 ef 80 ff ff       	call   80100390 <panic>
    panic("scfifoSwap: pte2 empty");
801082a1:	83 ec 0c             	sub    $0xc,%esp
801082a4:	68 b5 90 10 80       	push   $0x801090b5
801082a9:	e8 e2 80 ff ff       	call   80100390 <panic>
801082ae:	66 90                	xchg   %ax,%ax

801082b0 <writePageToSwapFile>:


// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
801082b0:	55                   	push   %ebp
801082b1:	89 e5                	mov    %esp,%ebp
801082b3:	53                   	push   %ebx
801082b4:	83 ec 10             	sub    $0x10,%esp
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap((uint)va);
  #endif
  #ifdef NFUA
    retPG=nfuaWriteToSwap((uint)va);
801082b7:	ff 75 08             	pushl  0x8(%ebp)
801082ba:	e8 81 f9 ff ff       	call   80107c40 <nfuaWriteToSwap>
801082bf:	89 c3                	mov    %eax,%ebx
  #endif
  myproc()->nPgsSwap++;
801082c1:	e8 ca bb ff ff       	call   80103e90 <myproc>
801082c6:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}
801082cd:	89 d8                	mov    %ebx,%eax
801082cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801082d2:	c9                   	leave  
801082d3:	c3                   	ret    
801082d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801082da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801082e0 <swapPage>:

void 
swapPage(uint addr){
801082e0:	55                   	push   %ebp
801082e1:	89 e5                	mov    %esp,%ebp
801082e3:	53                   	push   %ebx
801082e4:	83 ec 04             	sub    $0x4,%esp
801082e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  //cprintf("swap\n");
  if(myproc()->headPG == -1){
801082ea:	e8 a1 bb ff ff       	call   80103e90 <myproc>
801082ef:	83 b8 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%eax)
801082f6:	74 0c                	je     80108304 <swapPage+0x24>
  #ifdef SCFIFO
    return scfifoSwap((uint)addr);
  #endif

  #ifdef NFUA
    return nfuaSwap((uint)addr);
801082f8:	89 5d 08             	mov    %ebx,0x8(%ebp)
  #endif

}
801082fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801082fe:	c9                   	leave  
    return nfuaSwap((uint)addr);
801082ff:	e9 9c fd ff ff       	jmp    801080a0 <nfuaSwap>
    panic("scfifoSwap: empty headPG list");
80108304:	83 ec 0c             	sub    $0xc,%esp
80108307:	68 cc 90 10 80       	push   $0x801090cc
8010830c:	e8 7f 80 ff ff       	call   80100390 <panic>
80108311:	eb 0d                	jmp    80108320 <initPhysicalPage>
80108313:	90                   	nop
80108314:	90                   	nop
80108315:	90                   	nop
80108316:	90                   	nop
80108317:	90                   	nop
80108318:	90                   	nop
80108319:	90                   	nop
8010831a:	90                   	nop
8010831b:	90                   	nop
8010831c:	90                   	nop
8010831d:	90                   	nop
8010831e:	90                   	nop
8010831f:	90                   	nop

80108320 <initPhysicalPage>:

int
initPhysicalPage(char *va){
80108320:	55                   	push   %ebp
80108321:	89 e5                	mov    %esp,%ebp
80108323:	83 ec 14             	sub    $0x14,%esp

  #ifdef SCFIFO
    initSCFIFO(va);
  #endif
  #ifdef NFUA
    initNFUA(va);
80108326:	ff 75 08             	pushl  0x8(%ebp)
80108329:	e8 c2 fa ff ff       	call   80107df0 <initNFUA>
  #endif

  myproc()->nPgsPhysical++;
8010832e:	e8 5d bb ff ff       	call   80103e90 <myproc>
80108333:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
  myproc()->allocatedInPhys++;
8010833a:	e8 51 bb ff ff       	call   80103e90 <myproc>
8010833f:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)


  return 0;
}
80108346:	31 c0                	xor    %eax,%eax
80108348:	c9                   	leave  
80108349:	c3                   	ret    
8010834a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108350 <allocuvm>:
{
80108350:	55                   	push   %ebp
80108351:	89 e5                	mov    %esp,%ebp
80108353:	57                   	push   %edi
80108354:	56                   	push   %esi
80108355:	53                   	push   %ebx
80108356:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80108359:	8b 7d 10             	mov    0x10(%ebp),%edi
8010835c:	85 ff                	test   %edi,%edi
8010835e:	0f 88 e4 00 00 00    	js     80108448 <allocuvm+0xf8>
  if(newsz < oldsz)
80108364:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108367:	0f 82 cb 00 00 00    	jb     80108438 <allocuvm+0xe8>
  a = PGROUNDUP(oldsz);
8010836d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108370:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108376:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010837c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010837f:	0f 86 b6 00 00 00    	jbe    8010843b <allocuvm+0xeb>
    int    newPage = 1;
80108385:	b8 01 00 00 00       	mov    $0x1,%eax
8010838a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010838d:	89 c7                	mov    %eax,%edi
8010838f:	eb 77                	jmp    80108408 <allocuvm+0xb8>
80108391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if( (pg = writePageToSwapFile((char*)a)) == 0){
80108398:	83 ec 0c             	sub    $0xc,%esp
8010839b:	53                   	push   %ebx
8010839c:	e8 0f ff ff ff       	call   801082b0 <writePageToSwapFile>
801083a1:	83 c4 10             	add    $0x10,%esp
801083a4:	85 c0                	test   %eax,%eax
801083a6:	0f 84 21 01 00 00    	je     801084cd <allocuvm+0x17d>
        pg->refs = 1; // COW: fresh page, only 1 ref
801083ac:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
    mem = kalloc();
801083b3:	e8 a8 a5 ff ff       	call   80102960 <kalloc>
    if(mem == 0){
801083b8:	85 c0                	test   %eax,%eax
    mem = kalloc();
801083ba:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801083bc:	0f 84 96 00 00 00    	je     80108458 <allocuvm+0x108>
        newPage = 0;
801083c2:	31 ff                	xor    %edi,%edi
    memset(mem, 0, PGSIZE);
801083c4:	83 ec 04             	sub    $0x4,%esp
801083c7:	68 00 10 00 00       	push   $0x1000
801083cc:	6a 00                	push   $0x0
801083ce:	56                   	push   %esi
801083cf:	e8 ac c9 ff ff       	call   80104d80 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801083d4:	58                   	pop    %eax
801083d5:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801083db:	b9 00 10 00 00       	mov    $0x1000,%ecx
801083e0:	5a                   	pop    %edx
801083e1:	6a 06                	push   $0x6
801083e3:	50                   	push   %eax
801083e4:	89 da                	mov    %ebx,%edx
801083e6:	8b 45 08             	mov    0x8(%ebp),%eax
801083e9:	e8 e2 ec ff ff       	call   801070d0 <mappages>
801083ee:	83 c4 10             	add    $0x10,%esp
801083f1:	85 c0                	test   %eax,%eax
801083f3:	0f 88 8f 00 00 00    	js     80108488 <allocuvm+0x138>
  for(; a < newsz; a += PGSIZE){
801083f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801083ff:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108402:	0f 86 b8 00 00 00    	jbe    801084c0 <allocuvm+0x170>
      if(myproc()->allocatedInPhys >= MAX_PSYC_PAGES){
80108408:	e8 83 ba ff ff       	call   80103e90 <myproc>
8010840d:	83 b8 88 00 00 00 0f 	cmpl   $0xf,0x88(%eax)
80108414:	7f 82                	jg     80108398 <allocuvm+0x48>
    mem = kalloc();
80108416:	e8 45 a5 ff ff       	call   80102960 <kalloc>
    if(mem == 0){
8010841b:	85 c0                	test   %eax,%eax
    mem = kalloc();
8010841d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010841f:	74 37                	je     80108458 <allocuvm+0x108>
    if(newPage==1){
80108421:	83 ff 01             	cmp    $0x1,%edi
80108424:	75 9e                	jne    801083c4 <allocuvm+0x74>
        initPhysicalPage((char*)a);
80108426:	83 ec 0c             	sub    $0xc,%esp
80108429:	53                   	push   %ebx
8010842a:	e8 f1 fe ff ff       	call   80108320 <initPhysicalPage>
8010842f:	83 c4 10             	add    $0x10,%esp
80108432:	eb 90                	jmp    801083c4 <allocuvm+0x74>
80108434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80108438:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
8010843b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010843e:	89 f8                	mov    %edi,%eax
80108440:	5b                   	pop    %ebx
80108441:	5e                   	pop    %esi
80108442:	5f                   	pop    %edi
80108443:	5d                   	pop    %ebp
80108444:	c3                   	ret    
80108445:	8d 76 00             	lea    0x0(%esi),%esi
80108448:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
8010844b:	31 ff                	xor    %edi,%edi
}
8010844d:	89 f8                	mov    %edi,%eax
8010844f:	5b                   	pop    %ebx
80108450:	5e                   	pop    %esi
80108451:	5f                   	pop    %edi
80108452:	5d                   	pop    %ebp
80108453:	c3                   	ret    
80108454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory\n");
80108458:	83 ec 0c             	sub    $0xc,%esp
      return 0;
8010845b:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory\n");
8010845d:	68 00 91 10 80       	push   $0x80109100
80108462:	e8 f9 81 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108467:	83 c4 0c             	add    $0xc,%esp
8010846a:	ff 75 0c             	pushl  0xc(%ebp)
8010846d:	ff 75 10             	pushl  0x10(%ebp)
80108470:	ff 75 08             	pushl  0x8(%ebp)
80108473:	e8 e8 ef ff ff       	call   80107460 <deallocuvm>
      return 0;
80108478:	83 c4 10             	add    $0x10,%esp
}
8010847b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010847e:	89 f8                	mov    %edi,%eax
80108480:	5b                   	pop    %ebx
80108481:	5e                   	pop    %esi
80108482:	5f                   	pop    %edi
80108483:	5d                   	pop    %ebp
80108484:	c3                   	ret    
80108485:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80108488:	83 ec 0c             	sub    $0xc,%esp
      return 0;
8010848b:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory (2)\n");
8010848d:	68 18 91 10 80       	push   $0x80109118
80108492:	e8 c9 81 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80108497:	83 c4 0c             	add    $0xc,%esp
8010849a:	ff 75 0c             	pushl  0xc(%ebp)
8010849d:	ff 75 10             	pushl  0x10(%ebp)
801084a0:	ff 75 08             	pushl  0x8(%ebp)
801084a3:	e8 b8 ef ff ff       	call   80107460 <deallocuvm>
      kfree(mem);
801084a8:	89 34 24             	mov    %esi,(%esp)
801084ab:	e8 70 a2 ff ff       	call   80102720 <kfree>
      return 0;
801084b0:	83 c4 10             	add    $0x10,%esp
}
801084b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084b6:	89 f8                	mov    %edi,%eax
801084b8:	5b                   	pop    %ebx
801084b9:	5e                   	pop    %esi
801084ba:	5f                   	pop    %edi
801084bb:	5d                   	pop    %ebp
801084bc:	c3                   	ret    
801084bd:	8d 76 00             	lea    0x0(%esi),%esi
801084c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801084c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084c6:	5b                   	pop    %ebx
801084c7:	89 f8                	mov    %edi,%eax
801084c9:	5e                   	pop    %esi
801084ca:	5f                   	pop    %edi
801084cb:	5d                   	pop    %ebp
801084cc:	c3                   	ret    
          panic("allocuvm: swapOutPage");
801084cd:	83 ec 0c             	sub    $0xc,%esp
801084d0:	68 ea 90 10 80       	push   $0x801090ea
801084d5:	e8 b6 7e ff ff       	call   80100390 <panic>
801084da:	66 90                	xchg   %ax,%ax
801084dc:	66 90                	xchg   %ax,%ax
801084de:	66 90                	xchg   %ax,%ax

801084e0 <movePageToHead>:
#include "mmu.h"
#include "proc.h"
#include "elf.h"

void 
movePageToHead(struct procPG *pg){
801084e0:	55                   	push   %ebp
801084e1:	89 e5                	mov    %esp,%ebp
801084e3:	53                   	push   %ebx
801084e4:	83 ec 04             	sub    $0x4,%esp
801084e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
801084ea:	e8 a1 b9 ff ff       	call   80103e90 <myproc>
  if(pg->prev){
801084ef:	8b 53 10             	mov    0x10(%ebx),%edx
801084f2:	85 d2                	test   %edx,%edx
801084f4:	74 06                	je     801084fc <movePageToHead+0x1c>
    pg->prev->next = pg->next;
801084f6:	8b 4b 0c             	mov    0xc(%ebx),%ecx
801084f9:	89 4a 0c             	mov    %ecx,0xc(%edx)
  }
  if(pg->next){
801084fc:	8b 53 0c             	mov    0xc(%ebx),%edx
801084ff:	85 d2                	test   %edx,%edx
80108501:	74 06                	je     80108509 <movePageToHead+0x29>
    pg->next->prev = pg->prev;
80108503:	8b 4b 10             	mov    0x10(%ebx),%ecx
80108506:	89 4a 10             	mov    %ecx,0x10(%edx)
  }

  pg->next = &p->physicalPGs[p->headPG];
80108509:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
  pg->prev = 0;
8010850f:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  pg->next = &p->physicalPGs[p->headPG];
80108516:	8d 14 92             	lea    (%edx,%edx,4),%edx
80108519:	8d 94 90 90 01 00 00 	lea    0x190(%eax,%edx,4),%edx
80108520:	89 53 0c             	mov    %edx,0xc(%ebx)
  p->physicalPGs[p->headPG].prev = pg;
80108523:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80108529:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010852c:	89 9c 90 a0 01 00 00 	mov    %ebx,0x1a0(%eax,%edx,4)

}
80108533:	83 c4 04             	add    $0x4,%esp
80108536:	5b                   	pop    %ebx
80108537:	5d                   	pop    %ebp
80108538:	c3                   	ret    
