
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc c0 c5 10 80       	mov    $0x8010c5c0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 32 10 80       	mov    $0x801032b0,%eax
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
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 20 7b 10 80       	push   $0x80107b20
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 65 47 00 00       	call   801047c0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 0c 0d 11 80 bc 	movl   $0x80110cbc,0x80110d0c
80100062:	0c 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 10 0d 11 80 bc 	movl   $0x80110cbc,0x80110d10
8010006c:	0c 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba bc 0c 11 80       	mov    $0x80110cbc,%edx
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
8010008b:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 27 7b 10 80       	push   $0x80107b27
80100097:	50                   	push   %eax
80100098:	e8 f3 45 00 00       	call   80104690 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 10 0d 11 80       	mov    0x80110d10,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d bc 0c 11 80       	cmp    $0x80110cbc,%eax
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
801000df:	68 c0 c5 10 80       	push   $0x8010c5c0
801000e4:	e8 17 48 00 00       	call   80104900 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 10 0d 11 80    	mov    0x80110d10,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
80100120:	8b 1d 0c 0d 11 80    	mov    0x80110d0c,%ebx
80100126:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc 0c 11 80    	cmp    $0x80110cbc,%ebx
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
8010015d:	68 c0 c5 10 80       	push   $0x8010c5c0
80100162:	e8 59 48 00 00       	call   801049c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 45 00 00       	call   801046d0 <acquiresleep>
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
80100193:	68 2e 7b 10 80       	push   $0x80107b2e
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
801001ae:	e8 bd 45 00 00       	call   80104770 <holdingsleep>
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
801001cc:	68 3f 7b 10 80       	push   $0x80107b3f
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
801001ef:	e8 7c 45 00 00       	call   80104770 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 45 00 00       	call   80104730 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 f0 46 00 00       	call   80104900 <acquire>
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
80100232:	a1 10 0d 11 80       	mov    0x80110d10,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 bc 0c 11 80 	movl   $0x80110cbc,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 10 0d 11 80       	mov    0x80110d10,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 10 0d 11 80    	mov    %ebx,0x80110d10
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 c0 c5 10 80 	movl   $0x8010c5c0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 5f 47 00 00       	jmp    801049c0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 7b 10 80       	push   $0x80107b46
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
80100285:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010028c:	e8 6f 46 00 00       	call   80104900 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002a7:	39 15 a4 0f 11 80    	cmp    %edx,0x80110fa4
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
801002bb:	68 20 b5 10 80       	push   $0x8010b520
801002c0:	68 a0 0f 11 80       	push   $0x80110fa0
801002c5:	e8 56 40 00 00       	call   80104320 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 70 39 00 00       	call   80103c50 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 cc 46 00 00       	call   801049c0 <release>
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
80100313:	a3 a0 0f 11 80       	mov    %eax,0x80110fa0
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 20 0f 11 80 	movsbl -0x7feef0e0(%eax),%eax
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
80100348:	68 20 b5 10 80       	push   $0x8010b520
8010034d:	e8 6e 46 00 00       	call   801049c0 <release>
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
80100372:	89 15 a0 0f 11 80    	mov    %edx,0x80110fa0
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
80100399:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 92 27 00 00       	call   80102b40 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 4d 7b 10 80       	push   $0x80107b4d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 51 86 10 80 	movl   $0x80108651,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 03 44 00 00       	call   801047e0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 61 7b 10 80       	push   $0x80107b61
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 58 b5 10 80    	mov    0x8010b558,%ecx
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
8010043a:	e8 c1 5c 00 00       	call   80106100 <uartputc>
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
801004ec:	e8 0f 5c 00 00       	call   80106100 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 03 5c 00 00       	call   80106100 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 f7 5b 00 00       	call   80106100 <uartputc>
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
80100524:	e8 97 45 00 00       	call   80104ac0 <memmove>
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
80100541:	e8 ca 44 00 00       	call   80104a10 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 65 7b 10 80       	push   $0x80107b65
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
801005b1:	0f b6 92 90 7b 10 80 	movzbl -0x7fef8470(%edx),%edx
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
80100614:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010061b:	e8 e0 42 00 00       	call   80104900 <acquire>
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
80100642:	68 20 b5 10 80       	push   $0x8010b520
80100647:	e8 74 43 00 00       	call   801049c0 <release>
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
80100669:	a1 54 b5 10 80       	mov    0x8010b554,%eax
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
8010071a:	68 20 b5 10 80       	push   $0x8010b520
8010071f:	e8 9c 42 00 00       	call   801049c0 <release>
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
801007d0:	ba 78 7b 10 80       	mov    $0x80107b78,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 0b 41 00 00       	call   80104900 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 7f 7b 10 80       	push   $0x80107b7f
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
8010081e:	68 20 b5 10 80       	push   $0x8010b520
80100823:	e8 d8 40 00 00       	call   80104900 <acquire>
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
80100851:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100856:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
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
80100883:	68 20 b5 10 80       	push   $0x8010b520
80100888:	e8 33 41 00 00       	call   801049c0 <release>
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
801008a9:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 a0 0f 11 80    	sub    0x80110fa0,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 a8 0f 11 80    	mov    %edx,0x80110fa8
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 20 0f 11 80    	mov    %cl,-0x7feef0e0(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 a0 0f 11 80       	mov    0x80110fa0,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 a8 0f 11 80    	cmp    %eax,0x80110fa8
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 a4 0f 11 80       	mov    %eax,0x80110fa4
          wakeup(&input.r);
80100911:	68 a0 0f 11 80       	push   $0x80110fa0
80100916:	e8 c5 3b 00 00       	call   801044e0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
8010093d:	39 05 a4 0f 11 80    	cmp    %eax,0x80110fa4
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 a8 0f 11 80       	mov    %eax,0x80110fa8
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
80100964:	3b 05 a4 0f 11 80    	cmp    0x80110fa4,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba 20 0f 11 80 0a 	cmpb   $0xa,-0x7feef0e0(%edx)
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
80100997:	e9 24 3c 00 00       	jmp    801045c0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 20 0f 11 80 0a 	movb   $0xa,-0x7feef0e0(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 a8 0f 11 80       	mov    0x80110fa8,%eax
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
801009c6:	68 88 7b 10 80       	push   $0x80107b88
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 eb 3d 00 00       	call   801047c0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 6c 19 11 80 00 	movl   $0x80100600,0x8011196c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 68 19 11 80 70 	movl   $0x80100270,0x80111968
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
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
80100a1c:	e8 2f 32 00 00       	call   80103c50 <myproc>
80100a21:	89 c7                	mov    %eax,%edi

  begin_op();
80100a23:	e8 88 25 00 00       	call   80102fb0 <begin_op>

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
80100a6b:	e8 b0 25 00 00       	call   80103020 <end_op>
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
80100a8c:	e8 df 67 00 00       	call   80107270 <setupkvm>
80100a91:	85 c0                	test   %eax,%eax
80100a93:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a99:	74 c7                	je     80100a62 <exec+0x52>
80100a9b:	8d 87 cc 00 00 00    	lea    0xcc(%edi),%eax
80100aa1:	8d 97 8c 00 00 00    	lea    0x8c(%edi),%edx
80100aa7:	8d 8f 8c 01 00 00    	lea    0x18c(%edi),%ecx
80100aad:	8d 76 00             	lea    0x0(%esi),%esi
    curproc->physicalPGs[i].va = (char*)0xffffffff;
80100ab0:	c7 00 ff ff ff ff    	movl   $0xffffffff,(%eax)
    curproc->physicalPGs[i].next = 0;
80100ab6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
80100abd:	83 c0 0c             	add    $0xc,%eax
    curproc->physicalPGs[i].prev = 0;
80100ac0:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80100ac7:	83 c2 04             	add    $0x4,%edx
    curproc->swappedPGs[i].va = (char*)0xffffffff;
80100aca:	c7 42 fc ff ff ff ff 	movl   $0xffffffff,-0x4(%edx)
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
80100aef:	c7 87 88 00 00 00 00 	movl   $0x0,0x88(%edi)
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
80100b4e:	e8 dd 6d 00 00       	call   80107930 <allocuvm>
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
80100b80:	e8 8b 63 00 00       	call   80106f10 <loaduvm>
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
80100bca:	e8 21 66 00 00       	call   801071f0 <freevm>
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
80100bfe:	e8 1d 24 00 00       	call   80103020 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c03:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c09:	83 c4 0c             	add    $0xc,%esp
80100c0c:	56                   	push   %esi
80100c0d:	50                   	push   %eax
80100c0e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c14:	e8 17 6d 00 00       	call   80107930 <allocuvm>
80100c19:	83 c4 10             	add    $0x10,%esp
80100c1c:	85 c0                	test   %eax,%eax
80100c1e:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c24:	75 3a                	jne    80100c60 <exec+0x250>
    freevm(pgdir);
80100c26:	83 ec 0c             	sub    $0xc,%esp
80100c29:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c2f:	e8 bc 65 00 00       	call   801071f0 <freevm>
80100c34:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c3c:	e9 37 fe ff ff       	jmp    80100a78 <exec+0x68>
    end_op();
80100c41:	e8 da 23 00 00       	call   80103020 <end_op>
    cprintf("exec: fail\n");
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	68 a1 7b 10 80       	push   $0x80107ba1
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
80100c74:	e8 97 66 00 00       	call   80107310 <clearpteu>
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
80100ca9:	e8 82 3f 00 00       	call   80104c30 <strlen>
80100cae:	f7 d0                	not    %eax
80100cb0:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb5:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb6:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb9:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cbc:	e8 6f 3f 00 00       	call   80104c30 <strlen>
80100cc1:	83 c0 01             	add    $0x1,%eax
80100cc4:	50                   	push   %eax
80100cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc8:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ccb:	53                   	push   %ebx
80100ccc:	56                   	push   %esi
80100ccd:	e8 de 67 00 00       	call   801074b0 <copyout>
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
80100d39:	e8 72 67 00 00       	call   801074b0 <copyout>
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
80100d74:	e8 77 3e 00 00       	call   80104bf0 <safestrcpy>
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
80100da2:	e8 d9 5f 00 00       	call   80106d80 <switchuvm>
  freevm(oldpgdir);
80100da7:	89 34 24             	mov    %esi,(%esp)
80100daa:	e8 41 64 00 00       	call   801071f0 <freevm>
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
80100de6:	68 ad 7b 10 80       	push   $0x80107bad
80100deb:	68 c0 0f 11 80       	push   $0x80110fc0
80100df0:	e8 cb 39 00 00       	call   801047c0 <initlock>
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
80100e04:	bb f4 0f 11 80       	mov    $0x80110ff4,%ebx
{
80100e09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e0c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e11:	e8 ea 3a 00 00       	call   80104900 <acquire>
80100e16:	83 c4 10             	add    $0x10,%esp
80100e19:	eb 10                	jmp    80100e2b <filealloc+0x2b>
80100e1b:	90                   	nop
80100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e20:	83 c3 18             	add    $0x18,%ebx
80100e23:	81 fb 54 19 11 80    	cmp    $0x80111954,%ebx
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
80100e3c:	68 c0 0f 11 80       	push   $0x80110fc0
80100e41:	e8 7a 3b 00 00       	call   801049c0 <release>
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
80100e55:	68 c0 0f 11 80       	push   $0x80110fc0
80100e5a:	e8 61 3b 00 00       	call   801049c0 <release>
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
80100e7a:	68 c0 0f 11 80       	push   $0x80110fc0
80100e7f:	e8 7c 3a 00 00       	call   80104900 <acquire>
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
80100e97:	68 c0 0f 11 80       	push   $0x80110fc0
80100e9c:	e8 1f 3b 00 00       	call   801049c0 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 b4 7b 10 80       	push   $0x80107bb4
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
80100ecc:	68 c0 0f 11 80       	push   $0x80110fc0
80100ed1:	e8 2a 3a 00 00       	call   80104900 <acquire>
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
80100eee:	c7 45 08 c0 0f 11 80 	movl   $0x80110fc0,0x8(%ebp)
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
80100efc:	e9 bf 3a 00 00       	jmp    801049c0 <release>
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
80100f20:	68 c0 0f 11 80       	push   $0x80110fc0
  ff = *f;
80100f25:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f28:	e8 93 3a 00 00       	call   801049c0 <release>
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
80100f51:	e8 0a 28 00 00       	call   80103760 <pipeclose>
80100f56:	83 c4 10             	add    $0x10,%esp
80100f59:	eb df                	jmp    80100f3a <fileclose+0x7a>
80100f5b:	90                   	nop
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100f60:	e8 4b 20 00 00       	call   80102fb0 <begin_op>
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
80100f7a:	e9 a1 20 00 00       	jmp    80103020 <end_op>
    panic("fileclose");
80100f7f:	83 ec 0c             	sub    $0xc,%esp
80100f82:	68 bc 7b 10 80       	push   $0x80107bbc
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
8010104d:	e9 be 28 00 00       	jmp    80103910 <piperead>
80101052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101058:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010105d:	eb d7                	jmp    80101036 <fileread+0x56>
  panic("fileread");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 c6 7b 10 80       	push   $0x80107bc6
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
801010c9:	e8 52 1f 00 00       	call   80103020 <end_op>
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
801010f6:	e8 b5 1e 00 00       	call   80102fb0 <begin_op>
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
8010112d:	e8 ee 1e 00 00       	call   80103020 <end_op>
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
8010116d:	e9 8e 26 00 00       	jmp    80103800 <pipewrite>
        panic("short filewrite");
80101172:	83 ec 0c             	sub    $0xc,%esp
80101175:	68 cf 7b 10 80       	push   $0x80107bcf
8010117a:	e8 11 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 d5 7b 10 80       	push   $0x80107bd5
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
8010119a:	03 15 d8 19 11 80    	add    0x801119d8,%edx
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
801011d9:	e8 a2 1f 00 00       	call   80103180 <log_write>
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
801011f3:	68 df 7b 10 80       	push   $0x80107bdf
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
80101209:	8b 0d c0 19 11 80    	mov    0x801119c0,%ecx
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
8010122c:	03 05 d8 19 11 80    	add    0x801119d8,%eax
80101232:	50                   	push   %eax
80101233:	ff 75 d8             	pushl  -0x28(%ebp)
80101236:	e8 95 ee ff ff       	call   801000d0 <bread>
8010123b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010123e:	a1 c0 19 11 80       	mov    0x801119c0,%eax
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
80101299:	39 05 c0 19 11 80    	cmp    %eax,0x801119c0
8010129f:	77 80                	ja     80101221 <balloc+0x21>
  panic("balloc: out of blocks");
801012a1:	83 ec 0c             	sub    $0xc,%esp
801012a4:	68 f2 7b 10 80       	push   $0x80107bf2
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
801012bd:	e8 be 1e 00 00       	call   80103180 <log_write>
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
801012e5:	e8 26 37 00 00       	call   80104a10 <memset>
  log_write(bp);
801012ea:	89 1c 24             	mov    %ebx,(%esp)
801012ed:	e8 8e 1e 00 00       	call   80103180 <log_write>
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
8010131a:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
{
8010131f:	83 ec 28             	sub    $0x28,%esp
80101322:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101325:	68 e0 19 11 80       	push   $0x801119e0
8010132a:	e8 d1 35 00 00       	call   80104900 <acquire>
8010132f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101335:	eb 17                	jmp    8010134e <iget+0x3e>
80101337:	89 f6                	mov    %esi,%esi
80101339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101340:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101346:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
80101368:	81 fb 34 36 11 80    	cmp    $0x80113634,%ebx
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
8010138a:	68 e0 19 11 80       	push   $0x801119e0
8010138f:	e8 2c 36 00 00       	call   801049c0 <release>

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
801013b5:	68 e0 19 11 80       	push   $0x801119e0
      ip->ref++;
801013ba:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801013bd:	e8 fe 35 00 00       	call   801049c0 <release>
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
801013d2:	68 08 7c 10 80       	push   $0x80107c08
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
8010144e:	e8 2d 1d 00 00       	call   80103180 <log_write>
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
801014a7:	68 18 7c 10 80       	push   $0x80107c18
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
801014e1:	e8 da 35 00 00       	call   80104ac0 <memmove>
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
80101504:	bb 20 1a 11 80       	mov    $0x80111a20,%ebx
80101509:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010150c:	68 2b 7c 10 80       	push   $0x80107c2b
80101511:	68 e0 19 11 80       	push   $0x801119e0
80101516:	e8 a5 32 00 00       	call   801047c0 <initlock>
8010151b:	83 c4 10             	add    $0x10,%esp
8010151e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101520:	83 ec 08             	sub    $0x8,%esp
80101523:	68 32 7c 10 80       	push   $0x80107c32
80101528:	53                   	push   %ebx
80101529:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010152f:	e8 5c 31 00 00       	call   80104690 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101534:	83 c4 10             	add    $0x10,%esp
80101537:	81 fb 40 36 11 80    	cmp    $0x80113640,%ebx
8010153d:	75 e1                	jne    80101520 <iinit+0x20>
  readsb(dev, &sb);
8010153f:	83 ec 08             	sub    $0x8,%esp
80101542:	68 c0 19 11 80       	push   $0x801119c0
80101547:	ff 75 08             	pushl  0x8(%ebp)
8010154a:	e8 71 ff ff ff       	call   801014c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010154f:	ff 35 d8 19 11 80    	pushl  0x801119d8
80101555:	ff 35 d4 19 11 80    	pushl  0x801119d4
8010155b:	ff 35 d0 19 11 80    	pushl  0x801119d0
80101561:	ff 35 cc 19 11 80    	pushl  0x801119cc
80101567:	ff 35 c8 19 11 80    	pushl  0x801119c8
8010156d:	ff 35 c4 19 11 80    	pushl  0x801119c4
80101573:	ff 35 c0 19 11 80    	pushl  0x801119c0
80101579:	68 dc 7c 10 80       	push   $0x80107cdc
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
80101599:	83 3d c8 19 11 80 01 	cmpl   $0x1,0x801119c8
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
801015cf:	39 1d c8 19 11 80    	cmp    %ebx,0x801119c8
801015d5:	76 69                	jbe    80101640 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801015d7:	89 d8                	mov    %ebx,%eax
801015d9:	83 ec 08             	sub    $0x8,%esp
801015dc:	c1 e8 03             	shr    $0x3,%eax
801015df:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
8010160e:	e8 fd 33 00 00       	call   80104a10 <memset>
      dip->type = type;
80101613:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101617:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010161a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010161d:	89 3c 24             	mov    %edi,(%esp)
80101620:	e8 5b 1b 00 00       	call   80103180 <log_write>
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
80101643:	68 38 7c 10 80       	push   $0x80107c38
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
80101664:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
801016b1:	e8 0a 34 00 00       	call   80104ac0 <memmove>
  log_write(bp);
801016b6:	89 34 24             	mov    %esi,(%esp)
801016b9:	e8 c2 1a 00 00       	call   80103180 <log_write>
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
801016da:	68 e0 19 11 80       	push   $0x801119e0
801016df:	e8 1c 32 00 00       	call   80104900 <acquire>
  ip->ref++;
801016e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016e8:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801016ef:	e8 cc 32 00 00       	call   801049c0 <release>
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
80101722:	e8 a9 2f 00 00       	call   801046d0 <acquiresleep>
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
80101749:	03 05 d4 19 11 80    	add    0x801119d4,%eax
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
80101798:	e8 23 33 00 00       	call   80104ac0 <memmove>
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
801017bd:	68 50 7c 10 80       	push   $0x80107c50
801017c2:	e8 c9 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017c7:	83 ec 0c             	sub    $0xc,%esp
801017ca:	68 4a 7c 10 80       	push   $0x80107c4a
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
801017f3:	e8 78 2f 00 00       	call   80104770 <holdingsleep>
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
8010180f:	e9 1c 2f 00 00       	jmp    80104730 <releasesleep>
    panic("iunlock");
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	68 5f 7c 10 80       	push   $0x80107c5f
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
80101840:	e8 8b 2e 00 00       	call   801046d0 <acquiresleep>
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
8010185a:	e8 d1 2e 00 00       	call   80104730 <releasesleep>
  acquire(&icache.lock);
8010185f:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101866:	e8 95 30 00 00       	call   80104900 <acquire>
  ip->ref--;
8010186b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010186f:	83 c4 10             	add    $0x10,%esp
80101872:	c7 45 08 e0 19 11 80 	movl   $0x801119e0,0x8(%ebp)
}
80101879:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010187c:	5b                   	pop    %ebx
8010187d:	5e                   	pop    %esi
8010187e:	5f                   	pop    %edi
8010187f:	5d                   	pop    %ebp
  release(&icache.lock);
80101880:	e9 3b 31 00 00       	jmp    801049c0 <release>
80101885:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101888:	83 ec 0c             	sub    $0xc,%esp
8010188b:	68 e0 19 11 80       	push   $0x801119e0
80101890:	e8 6b 30 00 00       	call   80104900 <acquire>
    int r = ip->ref;
80101895:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101898:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010189f:	e8 1c 31 00 00       	call   801049c0 <release>
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
80101a87:	e8 34 30 00 00       	call   80104ac0 <memmove>
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
80101aba:	8b 04 c5 60 19 11 80 	mov    -0x7feee6a0(,%eax,8),%eax
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
80101b83:	e8 38 2f 00 00       	call   80104ac0 <memmove>
    log_write(bp);
80101b88:	89 3c 24             	mov    %edi,(%esp)
80101b8b:	e8 f0 15 00 00       	call   80103180 <log_write>
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
80101bca:	8b 04 c5 64 19 11 80 	mov    -0x7feee69c(,%eax,8),%eax
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
80101c1e:	e8 0d 2f 00 00       	call   80104b30 <strncmp>
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
80101c7d:	e8 ae 2e 00 00       	call   80104b30 <strncmp>
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
80101cc2:	68 79 7c 10 80       	push   $0x80107c79
80101cc7:	e8 c4 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101ccc:	83 ec 0c             	sub    $0xc,%esp
80101ccf:	68 67 7c 10 80       	push   $0x80107c67
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
80101cf9:	e8 52 1f 00 00       	call   80103c50 <myproc>
  acquire(&icache.lock);
80101cfe:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101d01:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101d04:	68 e0 19 11 80       	push   $0x801119e0
80101d09:	e8 f2 2b 00 00       	call   80104900 <acquire>
  ip->ref++;
80101d0e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d12:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101d19:	e8 a2 2c 00 00       	call   801049c0 <release>
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
80101d75:	e8 46 2d 00 00       	call   80104ac0 <memmove>
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
80101e08:	e8 b3 2c 00 00       	call   80104ac0 <memmove>
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
80101efd:	e8 8e 2c 00 00       	call   80104b90 <strncpy>
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
80101f3b:	68 88 7c 10 80       	push   $0x80107c88
80101f40:	e8 4b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f45:	83 ec 0c             	sub    $0xc,%esp
80101f48:	68 0d 83 10 80       	push   $0x8010830d
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
80102041:	68 95 7c 10 80       	push   $0x80107c95
80102046:	56                   	push   %esi
80102047:	e8 74 2a 00 00       	call   80104ac0 <memmove>
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
80102074:	e8 37 0f 00 00       	call   80102fb0 <begin_op>
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
801020a2:	68 9d 7c 10 80       	push   $0x80107c9d
801020a7:	53                   	push   %ebx
801020a8:	e8 83 2a 00 00       	call   80104b30 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801020ad:	83 c4 10             	add    $0x10,%esp
801020b0:	85 c0                	test   %eax,%eax
801020b2:	0f 84 f8 00 00 00    	je     801021b0 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
801020b8:	83 ec 04             	sub    $0x4,%esp
801020bb:	6a 0e                	push   $0xe
801020bd:	68 9c 7c 10 80       	push   $0x80107c9c
801020c2:	53                   	push   %ebx
801020c3:	e8 68 2a 00 00       	call   80104b30 <strncmp>
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
80102117:	e8 f4 28 00 00       	call   80104a10 <memset>
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
8010216d:	e8 ae 0e 00 00       	call   80103020 <end_op>

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
80102184:	e8 67 30 00 00       	call   801051f0 <isdirempty>
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
801021c1:	e8 5a 0e 00 00       	call   80103020 <end_op>
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
801021fa:	e8 21 0e 00 00       	call   80103020 <end_op>
    return -1;
801021ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102204:	e9 6e ff ff ff       	jmp    80102177 <removeSwapFile+0x147>
    panic("unlink: writei");
80102209:	83 ec 0c             	sub    $0xc,%esp
8010220c:	68 b1 7c 10 80       	push   $0x80107cb1
80102211:	e8 7a e1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80102216:	83 ec 0c             	sub    $0xc,%esp
80102219:	68 9f 7c 10 80       	push   $0x80107c9f
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
80102240:	68 95 7c 10 80       	push   $0x80107c95
80102245:	56                   	push   %esi
80102246:	e8 75 28 00 00       	call   80104ac0 <memmove>
  itoa(p->pid, path+ 6);
8010224b:	58                   	pop    %eax
8010224c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010224f:	5a                   	pop    %edx
80102250:	50                   	push   %eax
80102251:	ff 73 10             	pushl  0x10(%ebx)
80102254:	e8 47 fd ff ff       	call   80101fa0 <itoa>

    begin_op();
80102259:	e8 52 0d 00 00       	call   80102fb0 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
8010225e:	6a 00                	push   $0x0
80102260:	6a 00                	push   $0x0
80102262:	6a 02                	push   $0x2
80102264:	56                   	push   %esi
80102265:	e8 96 31 00 00       	call   80105400 <create>
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
801022a8:	e8 73 0d 00 00       	call   80103020 <end_op>

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
801022b9:	68 c0 7c 10 80       	push   $0x80107cc0
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
801023eb:	68 38 7d 10 80       	push   $0x80107d38
801023f0:	e8 9b df ff ff       	call   80100390 <panic>
    panic("idestart");
801023f5:	83 ec 0c             	sub    $0xc,%esp
801023f8:	68 2f 7d 10 80       	push   $0x80107d2f
801023fd:	e8 8e df ff ff       	call   80100390 <panic>
80102402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <ideinit>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102416:	68 4a 7d 10 80       	push   $0x80107d4a
8010241b:	68 80 b5 10 80       	push   $0x8010b580
80102420:	e8 9b 23 00 00       	call   801047c0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102425:	58                   	pop    %eax
80102426:	a1 00 3d 11 80       	mov    0x80113d00,%eax
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
8010246a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
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
80102499:	68 80 b5 10 80       	push   $0x8010b580
8010249e:	e8 5d 24 00 00       	call   80104900 <acquire>

  if((b = idequeue) == 0){
801024a3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801024a9:	83 c4 10             	add    $0x10,%esp
801024ac:	85 db                	test   %ebx,%ebx
801024ae:	74 67                	je     80102517 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801024b0:	8b 43 58             	mov    0x58(%ebx),%eax
801024b3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

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
80102501:	e8 da 1f 00 00       	call   801044e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102506:	a1 64 b5 10 80       	mov    0x8010b564,%eax
8010250b:	83 c4 10             	add    $0x10,%esp
8010250e:	85 c0                	test   %eax,%eax
80102510:	74 05                	je     80102517 <ideintr+0x87>
    idestart(idequeue);
80102512:	e8 19 fe ff ff       	call   80102330 <idestart>
    release(&idelock);
80102517:	83 ec 0c             	sub    $0xc,%esp
8010251a:	68 80 b5 10 80       	push   $0x8010b580
8010251f:	e8 9c 24 00 00       	call   801049c0 <release>

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
8010253e:	e8 2d 22 00 00       	call   80104770 <holdingsleep>
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
80102563:	a1 60 b5 10 80       	mov    0x8010b560,%eax
80102568:	85 c0                	test   %eax,%eax
8010256a:	0f 84 b1 00 00 00    	je     80102621 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102570:	83 ec 0c             	sub    $0xc,%esp
80102573:	68 80 b5 10 80       	push   $0x8010b580
80102578:	e8 83 23 00 00       	call   80104900 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010257d:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
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
801025a6:	39 1d 64 b5 10 80    	cmp    %ebx,0x8010b564
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
801025c3:	68 80 b5 10 80       	push   $0x8010b580
801025c8:	53                   	push   %ebx
801025c9:	e8 52 1d 00 00       	call   80104320 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025ce:	8b 03                	mov    (%ebx),%eax
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	83 e0 06             	and    $0x6,%eax
801025d6:	83 f8 02             	cmp    $0x2,%eax
801025d9:	75 e5                	jne    801025c0 <iderw+0x90>
  }


  release(&idelock);
801025db:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801025e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025e5:	c9                   	leave  
  release(&idelock);
801025e6:	e9 d5 23 00 00       	jmp    801049c0 <release>
801025eb:	90                   	nop
801025ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801025f0:	89 d8                	mov    %ebx,%eax
801025f2:	e8 39 fd ff ff       	call   80102330 <idestart>
801025f7:	eb b5                	jmp    801025ae <iderw+0x7e>
801025f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102600:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102605:	eb 9d                	jmp    801025a4 <iderw+0x74>
    panic("iderw: nothing to do");
80102607:	83 ec 0c             	sub    $0xc,%esp
8010260a:	68 64 7d 10 80       	push   $0x80107d64
8010260f:	e8 7c dd ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102614:	83 ec 0c             	sub    $0xc,%esp
80102617:	68 4e 7d 10 80       	push   $0x80107d4e
8010261c:	e8 6f dd ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102621:	83 ec 0c             	sub    $0xc,%esp
80102624:	68 79 7d 10 80       	push   $0x80107d79
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
80102631:	c7 05 34 36 11 80 00 	movl   $0xfec00000,0x80113634
80102638:	00 c0 fe 
{
8010263b:	89 e5                	mov    %esp,%ebp
8010263d:	56                   	push   %esi
8010263e:	53                   	push   %ebx
  ioapic->reg = reg;
8010263f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102646:	00 00 00 
  return ioapic->data;
80102649:	a1 34 36 11 80       	mov    0x80113634,%eax
8010264e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102651:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102657:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010265d:	0f b6 15 60 37 11 80 	movzbl 0x80113760,%edx
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
80102677:	68 98 7d 10 80       	push   $0x80107d98
8010267c:	e8 df df ff ff       	call   80100660 <cprintf>
80102681:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801026a2:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx

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
801026c0:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801026e1:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
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
801026f5:	8b 0d 34 36 11 80    	mov    0x80113634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026fb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801026fe:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102701:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102704:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102706:	a1 34 36 11 80       	mov    0x80113634,%eax
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
80102723:	53                   	push   %ebx
80102724:	83 ec 04             	sub    $0x4,%esp
80102727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010272a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102730:	75 70                	jne    801027a2 <kfree+0x82>
80102732:	81 fb a8 a8 11 80    	cmp    $0x8011a8a8,%ebx
80102738:	72 68                	jb     801027a2 <kfree+0x82>
8010273a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102740:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102745:	77 5b                	ja     801027a2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102747:	83 ec 04             	sub    $0x4,%esp
8010274a:	68 00 10 00 00       	push   $0x1000
8010274f:	6a 01                	push   $0x1
80102751:	53                   	push   %ebx
80102752:	e8 b9 22 00 00       	call   80104a10 <memset>

  if(kmem.use_lock)
80102757:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010275d:	83 c4 10             	add    $0x10,%esp
80102760:	85 d2                	test   %edx,%edx
80102762:	75 2c                	jne    80102790 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102764:	a1 78 36 11 80       	mov    0x80113678,%eax
80102769:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010276b:	a1 74 36 11 80       	mov    0x80113674,%eax
  kmem.freelist = r;
80102770:	89 1d 78 36 11 80    	mov    %ebx,0x80113678
  if(kmem.use_lock)
80102776:	85 c0                	test   %eax,%eax
80102778:	75 06                	jne    80102780 <kfree+0x60>
    release(&kmem.lock);
}
8010277a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277d:	c9                   	leave  
8010277e:	c3                   	ret    
8010277f:	90                   	nop
    release(&kmem.lock);
80102780:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
80102787:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010278a:	c9                   	leave  
    release(&kmem.lock);
8010278b:	e9 30 22 00 00       	jmp    801049c0 <release>
    acquire(&kmem.lock);
80102790:	83 ec 0c             	sub    $0xc,%esp
80102793:	68 40 36 11 80       	push   $0x80113640
80102798:	e8 63 21 00 00       	call   80104900 <acquire>
8010279d:	83 c4 10             	add    $0x10,%esp
801027a0:	eb c2                	jmp    80102764 <kfree+0x44>
    panic("kfree");
801027a2:	83 ec 0c             	sub    $0xc,%esp
801027a5:	68 ca 7d 10 80       	push   $0x80107dca
801027aa:	e8 e1 db ff ff       	call   80100390 <panic>
801027af:	90                   	nop

801027b0 <freerange>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	56                   	push   %esi
801027b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801027b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027cd:	39 de                	cmp    %ebx,%esi
801027cf:	72 23                	jb     801027f4 <freerange+0x44>
801027d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801027de:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027e7:	50                   	push   %eax
801027e8:	e8 33 ff ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ed:	83 c4 10             	add    $0x10,%esp
801027f0:	39 f3                	cmp    %esi,%ebx
801027f2:	76 e4                	jbe    801027d8 <freerange+0x28>
}
801027f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027f7:	5b                   	pop    %ebx
801027f8:	5e                   	pop    %esi
801027f9:	5d                   	pop    %ebp
801027fa:	c3                   	ret    
801027fb:	90                   	nop
801027fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102800 <kinit1>:
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	56                   	push   %esi
80102804:	53                   	push   %ebx
80102805:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102808:	83 ec 08             	sub    $0x8,%esp
8010280b:	68 d0 7d 10 80       	push   $0x80107dd0
80102810:	68 40 36 11 80       	push   $0x80113640
80102815:	e8 a6 1f 00 00       	call   801047c0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010281a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010281d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102820:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102827:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010282a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102830:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102836:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010283c:	39 de                	cmp    %ebx,%esi
8010283e:	72 1c                	jb     8010285c <kinit1+0x5c>
    kfree(p);
80102840:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102846:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102849:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010284f:	50                   	push   %eax
80102850:	e8 cb fe ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102855:	83 c4 10             	add    $0x10,%esp
80102858:	39 de                	cmp    %ebx,%esi
8010285a:	73 e4                	jae    80102840 <kinit1+0x40>
}
8010285c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010285f:	5b                   	pop    %ebx
80102860:	5e                   	pop    %esi
80102861:	5d                   	pop    %ebp
80102862:	c3                   	ret    
80102863:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102870 <kinit2>:
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	56                   	push   %esi
80102874:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102875:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102878:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010287b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102881:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102887:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010288d:	39 de                	cmp    %ebx,%esi
8010288f:	72 23                	jb     801028b4 <kinit2+0x44>
80102891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102898:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010289e:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028a7:	50                   	push   %eax
801028a8:	e8 73 fe ff ff       	call   80102720 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028ad:	83 c4 10             	add    $0x10,%esp
801028b0:	39 de                	cmp    %ebx,%esi
801028b2:	73 e4                	jae    80102898 <kinit2+0x28>
  kmem.use_lock = 1;
801028b4:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
801028bb:	00 00 00 
}
801028be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028c1:	5b                   	pop    %ebx
801028c2:	5e                   	pop    %esi
801028c3:	5d                   	pop    %ebp
801028c4:	c3                   	ret    
801028c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801028d0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801028d0:	a1 74 36 11 80       	mov    0x80113674,%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	75 1f                	jne    801028f8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801028d9:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
801028de:	85 c0                	test   %eax,%eax
801028e0:	74 0e                	je     801028f0 <kalloc+0x20>
    kmem.freelist = r->next;
801028e2:	8b 10                	mov    (%eax),%edx
801028e4:	89 15 78 36 11 80    	mov    %edx,0x80113678
801028ea:	c3                   	ret    
801028eb:	90                   	nop
801028ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801028f0:	f3 c3                	repz ret 
801028f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
801028f8:	55                   	push   %ebp
801028f9:	89 e5                	mov    %esp,%ebp
801028fb:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801028fe:	68 40 36 11 80       	push   $0x80113640
80102903:	e8 f8 1f 00 00       	call   80104900 <acquire>
  r = kmem.freelist;
80102908:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r)
8010290d:	83 c4 10             	add    $0x10,%esp
80102910:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102916:	85 c0                	test   %eax,%eax
80102918:	74 08                	je     80102922 <kalloc+0x52>
    kmem.freelist = r->next;
8010291a:	8b 08                	mov    (%eax),%ecx
8010291c:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
  if(kmem.use_lock)
80102922:	85 d2                	test   %edx,%edx
80102924:	74 16                	je     8010293c <kalloc+0x6c>
    release(&kmem.lock);
80102926:	83 ec 0c             	sub    $0xc,%esp
80102929:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010292c:	68 40 36 11 80       	push   $0x80113640
80102931:	e8 8a 20 00 00       	call   801049c0 <release>
  return (char*)r;
80102936:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102939:	83 c4 10             	add    $0x10,%esp
}
8010293c:	c9                   	leave  
8010293d:	c3                   	ret    
8010293e:	66 90                	xchg   %ax,%ax

80102940 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102940:	ba 64 00 00 00       	mov    $0x64,%edx
80102945:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102946:	a8 01                	test   $0x1,%al
80102948:	0f 84 c2 00 00 00    	je     80102a10 <kbdgetc+0xd0>
8010294e:	ba 60 00 00 00       	mov    $0x60,%edx
80102953:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102954:	0f b6 d0             	movzbl %al,%edx
80102957:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

  if(data == 0xE0){
8010295d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102963:	0f 84 7f 00 00 00    	je     801029e8 <kbdgetc+0xa8>
{
80102969:	55                   	push   %ebp
8010296a:	89 e5                	mov    %esp,%ebp
8010296c:	53                   	push   %ebx
8010296d:	89 cb                	mov    %ecx,%ebx
8010296f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102972:	84 c0                	test   %al,%al
80102974:	78 4a                	js     801029c0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102976:	85 db                	test   %ebx,%ebx
80102978:	74 09                	je     80102983 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010297a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010297d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102980:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102983:	0f b6 82 00 7f 10 80 	movzbl -0x7fef8100(%edx),%eax
8010298a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010298c:	0f b6 82 00 7e 10 80 	movzbl -0x7fef8200(%edx),%eax
80102993:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102995:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102997:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
8010299d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801029a0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801029a3:	8b 04 85 e0 7d 10 80 	mov    -0x7fef8220(,%eax,4),%eax
801029aa:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801029ae:	74 31                	je     801029e1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801029b0:	8d 50 9f             	lea    -0x61(%eax),%edx
801029b3:	83 fa 19             	cmp    $0x19,%edx
801029b6:	77 40                	ja     801029f8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801029b8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801029bb:	5b                   	pop    %ebx
801029bc:	5d                   	pop    %ebp
801029bd:	c3                   	ret    
801029be:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801029c0:	83 e0 7f             	and    $0x7f,%eax
801029c3:	85 db                	test   %ebx,%ebx
801029c5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801029c8:	0f b6 82 00 7f 10 80 	movzbl -0x7fef8100(%edx),%eax
801029cf:	83 c8 40             	or     $0x40,%eax
801029d2:	0f b6 c0             	movzbl %al,%eax
801029d5:	f7 d0                	not    %eax
801029d7:	21 c1                	and    %eax,%ecx
    return 0;
801029d9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801029db:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
}
801029e1:	5b                   	pop    %ebx
801029e2:	5d                   	pop    %ebp
801029e3:	c3                   	ret    
801029e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801029e8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801029eb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801029ed:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
    return 0;
801029f3:	c3                   	ret    
801029f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
801029f8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801029fb:	8d 50 20             	lea    0x20(%eax),%edx
}
801029fe:	5b                   	pop    %ebx
      c += 'a' - 'A';
801029ff:	83 f9 1a             	cmp    $0x1a,%ecx
80102a02:	0f 42 c2             	cmovb  %edx,%eax
}
80102a05:	5d                   	pop    %ebp
80102a06:	c3                   	ret    
80102a07:	89 f6                	mov    %esi,%esi
80102a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102a15:	c3                   	ret    
80102a16:	8d 76 00             	lea    0x0(%esi),%esi
80102a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a20 <kbdintr>:

void
kbdintr(void)
{
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102a26:	68 40 29 10 80       	push   $0x80102940
80102a2b:	e8 e0 dd ff ff       	call   80100810 <consoleintr>
}
80102a30:	83 c4 10             	add    $0x10,%esp
80102a33:	c9                   	leave  
80102a34:	c3                   	ret    
80102a35:	66 90                	xchg   %ax,%ax
80102a37:	66 90                	xchg   %ax,%ax
80102a39:	66 90                	xchg   %ax,%ax
80102a3b:	66 90                	xchg   %ax,%ax
80102a3d:	66 90                	xchg   %ax,%ax
80102a3f:	90                   	nop

80102a40 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102a40:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
80102a45:	55                   	push   %ebp
80102a46:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102a48:	85 c0                	test   %eax,%eax
80102a4a:	0f 84 c8 00 00 00    	je     80102b18 <lapicinit+0xd8>
  lapic[index] = value;
80102a50:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102a57:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a5a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a5d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a64:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a67:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a6a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a71:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a74:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a77:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a7e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a81:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a84:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a8b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a8e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a91:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a98:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a9b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a9e:	8b 50 30             	mov    0x30(%eax),%edx
80102aa1:	c1 ea 10             	shr    $0x10,%edx
80102aa4:	80 fa 03             	cmp    $0x3,%dl
80102aa7:	77 77                	ja     80102b20 <lapicinit+0xe0>
  lapic[index] = value;
80102aa9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102ab0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ab6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102abd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ac0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ac3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102aca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102acd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ad0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ad7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ada:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102add:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102ae4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aea:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102af1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102af4:	8b 50 20             	mov    0x20(%eax),%edx
80102af7:	89 f6                	mov    %esi,%esi
80102af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102b00:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102b06:	80 e6 10             	and    $0x10,%dh
80102b09:	75 f5                	jne    80102b00 <lapicinit+0xc0>
  lapic[index] = value;
80102b0b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102b12:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b15:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102b18:	5d                   	pop    %ebp
80102b19:	c3                   	ret    
80102b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102b20:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102b27:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b2a:	8b 50 20             	mov    0x20(%eax),%edx
80102b2d:	e9 77 ff ff ff       	jmp    80102aa9 <lapicinit+0x69>
80102b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b40 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102b40:	8b 15 7c 36 11 80    	mov    0x8011367c,%edx
{
80102b46:	55                   	push   %ebp
80102b47:	31 c0                	xor    %eax,%eax
80102b49:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102b4b:	85 d2                	test   %edx,%edx
80102b4d:	74 06                	je     80102b55 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102b4f:	8b 42 20             	mov    0x20(%edx),%eax
80102b52:	c1 e8 18             	shr    $0x18,%eax
}
80102b55:	5d                   	pop    %ebp
80102b56:	c3                   	ret    
80102b57:	89 f6                	mov    %esi,%esi
80102b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b60 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b60:	a1 7c 36 11 80       	mov    0x8011367c,%eax
{
80102b65:	55                   	push   %ebp
80102b66:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102b68:	85 c0                	test   %eax,%eax
80102b6a:	74 0d                	je     80102b79 <lapiceoi+0x19>
  lapic[index] = value;
80102b6c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b73:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b76:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b79:	5d                   	pop    %ebp
80102b7a:	c3                   	ret    
80102b7b:	90                   	nop
80102b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b80 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
}
80102b83:	5d                   	pop    %ebp
80102b84:	c3                   	ret    
80102b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b90 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b90:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b91:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b96:	ba 70 00 00 00       	mov    $0x70,%edx
80102b9b:	89 e5                	mov    %esp,%ebp
80102b9d:	53                   	push   %ebx
80102b9e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ba1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ba4:	ee                   	out    %al,(%dx)
80102ba5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102baa:	ba 71 00 00 00       	mov    $0x71,%edx
80102baf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102bb0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102bb2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102bb5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102bbb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102bbd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102bc0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102bc3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102bc5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102bc8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102bce:	a1 7c 36 11 80       	mov    0x8011367c,%eax
80102bd3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bd9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bdc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102be3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102be6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102be9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102bf0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bf3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bf6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102bfc:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bff:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c05:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c08:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c0e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c11:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c17:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102c1a:	5b                   	pop    %ebx
80102c1b:	5d                   	pop    %ebp
80102c1c:	c3                   	ret    
80102c1d:	8d 76 00             	lea    0x0(%esi),%esi

80102c20 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102c20:	55                   	push   %ebp
80102c21:	b8 0b 00 00 00       	mov    $0xb,%eax
80102c26:	ba 70 00 00 00       	mov    $0x70,%edx
80102c2b:	89 e5                	mov    %esp,%ebp
80102c2d:	57                   	push   %edi
80102c2e:	56                   	push   %esi
80102c2f:	53                   	push   %ebx
80102c30:	83 ec 4c             	sub    $0x4c,%esp
80102c33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c34:	ba 71 00 00 00       	mov    $0x71,%edx
80102c39:	ec                   	in     (%dx),%al
80102c3a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c3d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102c42:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102c45:	8d 76 00             	lea    0x0(%esi),%esi
80102c48:	31 c0                	xor    %eax,%eax
80102c4a:	89 da                	mov    %ebx,%edx
80102c4c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c4d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102c52:	89 ca                	mov    %ecx,%edx
80102c54:	ec                   	in     (%dx),%al
80102c55:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c58:	89 da                	mov    %ebx,%edx
80102c5a:	b8 02 00 00 00       	mov    $0x2,%eax
80102c5f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c60:	89 ca                	mov    %ecx,%edx
80102c62:	ec                   	in     (%dx),%al
80102c63:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c66:	89 da                	mov    %ebx,%edx
80102c68:	b8 04 00 00 00       	mov    $0x4,%eax
80102c6d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6e:	89 ca                	mov    %ecx,%edx
80102c70:	ec                   	in     (%dx),%al
80102c71:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c74:	89 da                	mov    %ebx,%edx
80102c76:	b8 07 00 00 00       	mov    $0x7,%eax
80102c7b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c7c:	89 ca                	mov    %ecx,%edx
80102c7e:	ec                   	in     (%dx),%al
80102c7f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c82:	89 da                	mov    %ebx,%edx
80102c84:	b8 08 00 00 00       	mov    $0x8,%eax
80102c89:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c8a:	89 ca                	mov    %ecx,%edx
80102c8c:	ec                   	in     (%dx),%al
80102c8d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c8f:	89 da                	mov    %ebx,%edx
80102c91:	b8 09 00 00 00       	mov    $0x9,%eax
80102c96:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c97:	89 ca                	mov    %ecx,%edx
80102c99:	ec                   	in     (%dx),%al
80102c9a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c9c:	89 da                	mov    %ebx,%edx
80102c9e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102ca3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ca4:	89 ca                	mov    %ecx,%edx
80102ca6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102ca7:	84 c0                	test   %al,%al
80102ca9:	78 9d                	js     80102c48 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102cab:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102caf:	89 fa                	mov    %edi,%edx
80102cb1:	0f b6 fa             	movzbl %dl,%edi
80102cb4:	89 f2                	mov    %esi,%edx
80102cb6:	0f b6 f2             	movzbl %dl,%esi
80102cb9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cbc:	89 da                	mov    %ebx,%edx
80102cbe:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102cc1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102cc4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102cc8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ccb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102ccf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102cd2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102cd6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102cd9:	31 c0                	xor    %eax,%eax
80102cdb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cdc:	89 ca                	mov    %ecx,%edx
80102cde:	ec                   	in     (%dx),%al
80102cdf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ce2:	89 da                	mov    %ebx,%edx
80102ce4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102ce7:	b8 02 00 00 00       	mov    $0x2,%eax
80102cec:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ced:	89 ca                	mov    %ecx,%edx
80102cef:	ec                   	in     (%dx),%al
80102cf0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf3:	89 da                	mov    %ebx,%edx
80102cf5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102cf8:	b8 04 00 00 00       	mov    $0x4,%eax
80102cfd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cfe:	89 ca                	mov    %ecx,%edx
80102d00:	ec                   	in     (%dx),%al
80102d01:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d04:	89 da                	mov    %ebx,%edx
80102d06:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102d09:	b8 07 00 00 00       	mov    $0x7,%eax
80102d0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d0f:	89 ca                	mov    %ecx,%edx
80102d11:	ec                   	in     (%dx),%al
80102d12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d15:	89 da                	mov    %ebx,%edx
80102d17:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102d1a:	b8 08 00 00 00       	mov    $0x8,%eax
80102d1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d20:	89 ca                	mov    %ecx,%edx
80102d22:	ec                   	in     (%dx),%al
80102d23:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d26:	89 da                	mov    %ebx,%edx
80102d28:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d2b:	b8 09 00 00 00       	mov    $0x9,%eax
80102d30:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d31:	89 ca                	mov    %ecx,%edx
80102d33:	ec                   	in     (%dx),%al
80102d34:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d37:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d3d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d40:	6a 18                	push   $0x18
80102d42:	50                   	push   %eax
80102d43:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d46:	50                   	push   %eax
80102d47:	e8 14 1d 00 00       	call   80104a60 <memcmp>
80102d4c:	83 c4 10             	add    $0x10,%esp
80102d4f:	85 c0                	test   %eax,%eax
80102d51:	0f 85 f1 fe ff ff    	jne    80102c48 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102d57:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102d5b:	75 78                	jne    80102dd5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d5d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d60:	89 c2                	mov    %eax,%edx
80102d62:	83 e0 0f             	and    $0xf,%eax
80102d65:	c1 ea 04             	shr    $0x4,%edx
80102d68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d6e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d71:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d74:	89 c2                	mov    %eax,%edx
80102d76:	83 e0 0f             	and    $0xf,%eax
80102d79:	c1 ea 04             	shr    $0x4,%edx
80102d7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d82:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d85:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d88:	89 c2                	mov    %eax,%edx
80102d8a:	83 e0 0f             	and    $0xf,%eax
80102d8d:	c1 ea 04             	shr    $0x4,%edx
80102d90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d96:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d9c:	89 c2                	mov    %eax,%edx
80102d9e:	83 e0 0f             	and    $0xf,%eax
80102da1:	c1 ea 04             	shr    $0x4,%edx
80102da4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102da7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102daa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102dad:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102db0:	89 c2                	mov    %eax,%edx
80102db2:	83 e0 0f             	and    $0xf,%eax
80102db5:	c1 ea 04             	shr    $0x4,%edx
80102db8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dbb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dbe:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102dc1:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dc4:	89 c2                	mov    %eax,%edx
80102dc6:	83 e0 0f             	and    $0xf,%eax
80102dc9:	c1 ea 04             	shr    $0x4,%edx
80102dcc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dcf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dd2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102dd5:	8b 75 08             	mov    0x8(%ebp),%esi
80102dd8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ddb:	89 06                	mov    %eax,(%esi)
80102ddd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102de0:	89 46 04             	mov    %eax,0x4(%esi)
80102de3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102de6:	89 46 08             	mov    %eax,0x8(%esi)
80102de9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dec:	89 46 0c             	mov    %eax,0xc(%esi)
80102def:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102df2:	89 46 10             	mov    %eax,0x10(%esi)
80102df5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102df8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102dfb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e05:	5b                   	pop    %ebx
80102e06:	5e                   	pop    %esi
80102e07:	5f                   	pop    %edi
80102e08:	5d                   	pop    %ebp
80102e09:	c3                   	ret    
80102e0a:	66 90                	xchg   %ax,%ax
80102e0c:	66 90                	xchg   %ax,%ax
80102e0e:	66 90                	xchg   %ax,%ax

80102e10 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e10:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80102e16:	85 c9                	test   %ecx,%ecx
80102e18:	0f 8e 8a 00 00 00    	jle    80102ea8 <install_trans+0x98>
{
80102e1e:	55                   	push   %ebp
80102e1f:	89 e5                	mov    %esp,%ebp
80102e21:	57                   	push   %edi
80102e22:	56                   	push   %esi
80102e23:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102e24:	31 db                	xor    %ebx,%ebx
{
80102e26:	83 ec 0c             	sub    $0xc,%esp
80102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e30:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102e35:	83 ec 08             	sub    $0x8,%esp
80102e38:	01 d8                	add    %ebx,%eax
80102e3a:	83 c0 01             	add    $0x1,%eax
80102e3d:	50                   	push   %eax
80102e3e:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102e44:	e8 87 d2 ff ff       	call   801000d0 <bread>
80102e49:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e4b:	58                   	pop    %eax
80102e4c:	5a                   	pop    %edx
80102e4d:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
80102e54:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e5d:	e8 6e d2 ff ff       	call   801000d0 <bread>
80102e62:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e64:	8d 47 5c             	lea    0x5c(%edi),%eax
80102e67:	83 c4 0c             	add    $0xc,%esp
80102e6a:	68 00 02 00 00       	push   $0x200
80102e6f:	50                   	push   %eax
80102e70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e73:	50                   	push   %eax
80102e74:	e8 47 1c 00 00       	call   80104ac0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e79:	89 34 24             	mov    %esi,(%esp)
80102e7c:	e8 1f d3 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102e81:	89 3c 24             	mov    %edi,(%esp)
80102e84:	e8 57 d3 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102e89:	89 34 24             	mov    %esi,(%esp)
80102e8c:	e8 4f d3 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e91:	83 c4 10             	add    $0x10,%esp
80102e94:	39 1d c8 36 11 80    	cmp    %ebx,0x801136c8
80102e9a:	7f 94                	jg     80102e30 <install_trans+0x20>
  }
}
80102e9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e9f:	5b                   	pop    %ebx
80102ea0:	5e                   	pop    %esi
80102ea1:	5f                   	pop    %edi
80102ea2:	5d                   	pop    %ebp
80102ea3:	c3                   	ret    
80102ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ea8:	f3 c3                	repz ret 
80102eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102eb0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	56                   	push   %esi
80102eb4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102eb5:	83 ec 08             	sub    $0x8,%esp
80102eb8:	ff 35 b4 36 11 80    	pushl  0x801136b4
80102ebe:	ff 35 c4 36 11 80    	pushl  0x801136c4
80102ec4:	e8 07 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ec9:	8b 1d c8 36 11 80    	mov    0x801136c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102ecf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ed2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ed4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ed6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ed9:	7e 16                	jle    80102ef1 <write_head+0x41>
80102edb:	c1 e3 02             	shl    $0x2,%ebx
80102ede:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102ee0:	8b 8a cc 36 11 80    	mov    -0x7feec934(%edx),%ecx
80102ee6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102eea:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102eed:	39 da                	cmp    %ebx,%edx
80102eef:	75 ef                	jne    80102ee0 <write_head+0x30>
  }
  bwrite(buf);
80102ef1:	83 ec 0c             	sub    $0xc,%esp
80102ef4:	56                   	push   %esi
80102ef5:	e8 a6 d2 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102efa:	89 34 24             	mov    %esi,(%esp)
80102efd:	e8 de d2 ff ff       	call   801001e0 <brelse>
}
80102f02:	83 c4 10             	add    $0x10,%esp
80102f05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102f08:	5b                   	pop    %ebx
80102f09:	5e                   	pop    %esi
80102f0a:	5d                   	pop    %ebp
80102f0b:	c3                   	ret    
80102f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102f10 <initlog>:
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 ec 2c             	sub    $0x2c,%esp
80102f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102f1a:	68 00 80 10 80       	push   $0x80108000
80102f1f:	68 80 36 11 80       	push   $0x80113680
80102f24:	e8 97 18 00 00       	call   801047c0 <initlock>
  readsb(dev, &sb);
80102f29:	58                   	pop    %eax
80102f2a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f2d:	5a                   	pop    %edx
80102f2e:	50                   	push   %eax
80102f2f:	53                   	push   %ebx
80102f30:	e8 8b e5 ff ff       	call   801014c0 <readsb>
  log.size = sb.nlog;
80102f35:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102f38:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f3b:	59                   	pop    %ecx
  log.dev = dev;
80102f3c:	89 1d c4 36 11 80    	mov    %ebx,0x801136c4
  log.size = sb.nlog;
80102f42:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
  log.start = sb.logstart;
80102f48:	a3 b4 36 11 80       	mov    %eax,0x801136b4
  struct buf *buf = bread(log.dev, log.start);
80102f4d:	5a                   	pop    %edx
80102f4e:	50                   	push   %eax
80102f4f:	53                   	push   %ebx
80102f50:	e8 7b d1 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102f55:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102f58:	83 c4 10             	add    $0x10,%esp
80102f5b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102f5d:	89 1d c8 36 11 80    	mov    %ebx,0x801136c8
  for (i = 0; i < log.lh.n; i++) {
80102f63:	7e 1c                	jle    80102f81 <initlog+0x71>
80102f65:	c1 e3 02             	shl    $0x2,%ebx
80102f68:	31 d2                	xor    %edx,%edx
80102f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102f70:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102f74:	83 c2 04             	add    $0x4,%edx
80102f77:	89 8a c8 36 11 80    	mov    %ecx,-0x7feec938(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102f7d:	39 d3                	cmp    %edx,%ebx
80102f7f:	75 ef                	jne    80102f70 <initlog+0x60>
  brelse(buf);
80102f81:	83 ec 0c             	sub    $0xc,%esp
80102f84:	50                   	push   %eax
80102f85:	e8 56 d2 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f8a:	e8 81 fe ff ff       	call   80102e10 <install_trans>
  log.lh.n = 0;
80102f8f:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
80102f96:	00 00 00 
  write_head(); // clear the log
80102f99:	e8 12 ff ff ff       	call   80102eb0 <write_head>
}
80102f9e:	83 c4 10             	add    $0x10,%esp
80102fa1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fa4:	c9                   	leave  
80102fa5:	c3                   	ret    
80102fa6:	8d 76 00             	lea    0x0(%esi),%esi
80102fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fb0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102fb6:	68 80 36 11 80       	push   $0x80113680
80102fbb:	e8 40 19 00 00       	call   80104900 <acquire>
80102fc0:	83 c4 10             	add    $0x10,%esp
80102fc3:	eb 18                	jmp    80102fdd <begin_op+0x2d>
80102fc5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102fc8:	83 ec 08             	sub    $0x8,%esp
80102fcb:	68 80 36 11 80       	push   $0x80113680
80102fd0:	68 80 36 11 80       	push   $0x80113680
80102fd5:	e8 46 13 00 00       	call   80104320 <sleep>
80102fda:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102fdd:	a1 c0 36 11 80       	mov    0x801136c0,%eax
80102fe2:	85 c0                	test   %eax,%eax
80102fe4:	75 e2                	jne    80102fc8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102fe6:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102feb:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
80102ff1:	83 c0 01             	add    $0x1,%eax
80102ff4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102ff7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102ffa:	83 fa 1e             	cmp    $0x1e,%edx
80102ffd:	7f c9                	jg     80102fc8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102fff:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103002:	a3 bc 36 11 80       	mov    %eax,0x801136bc
      release(&log.lock);
80103007:	68 80 36 11 80       	push   $0x80113680
8010300c:	e8 af 19 00 00       	call   801049c0 <release>
      break;
    }
  }
}
80103011:	83 c4 10             	add    $0x10,%esp
80103014:	c9                   	leave  
80103015:	c3                   	ret    
80103016:	8d 76 00             	lea    0x0(%esi),%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103020 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	57                   	push   %edi
80103024:	56                   	push   %esi
80103025:	53                   	push   %ebx
80103026:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103029:	68 80 36 11 80       	push   $0x80113680
8010302e:	e8 cd 18 00 00       	call   80104900 <acquire>
  log.outstanding -= 1;
80103033:	a1 bc 36 11 80       	mov    0x801136bc,%eax
  if(log.committing)
80103038:	8b 35 c0 36 11 80    	mov    0x801136c0,%esi
8010303e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103041:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103044:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103046:	89 1d bc 36 11 80    	mov    %ebx,0x801136bc
  if(log.committing)
8010304c:	0f 85 1a 01 00 00    	jne    8010316c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103052:	85 db                	test   %ebx,%ebx
80103054:	0f 85 ee 00 00 00    	jne    80103148 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010305a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010305d:	c7 05 c0 36 11 80 01 	movl   $0x1,0x801136c0
80103064:	00 00 00 
  release(&log.lock);
80103067:	68 80 36 11 80       	push   $0x80113680
8010306c:	e8 4f 19 00 00       	call   801049c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103071:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
80103077:	83 c4 10             	add    $0x10,%esp
8010307a:	85 c9                	test   %ecx,%ecx
8010307c:	0f 8e 85 00 00 00    	jle    80103107 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103082:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80103087:	83 ec 08             	sub    $0x8,%esp
8010308a:	01 d8                	add    %ebx,%eax
8010308c:	83 c0 01             	add    $0x1,%eax
8010308f:	50                   	push   %eax
80103090:	ff 35 c4 36 11 80    	pushl  0x801136c4
80103096:	e8 35 d0 ff ff       	call   801000d0 <bread>
8010309b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010309d:	58                   	pop    %eax
8010309e:	5a                   	pop    %edx
8010309f:	ff 34 9d cc 36 11 80 	pushl  -0x7feec934(,%ebx,4)
801030a6:	ff 35 c4 36 11 80    	pushl  0x801136c4
  for (tail = 0; tail < log.lh.n; tail++) {
801030ac:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801030af:	e8 1c d0 ff ff       	call   801000d0 <bread>
801030b4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801030b6:	8d 40 5c             	lea    0x5c(%eax),%eax
801030b9:	83 c4 0c             	add    $0xc,%esp
801030bc:	68 00 02 00 00       	push   $0x200
801030c1:	50                   	push   %eax
801030c2:	8d 46 5c             	lea    0x5c(%esi),%eax
801030c5:	50                   	push   %eax
801030c6:	e8 f5 19 00 00       	call   80104ac0 <memmove>
    bwrite(to);  // write the log
801030cb:	89 34 24             	mov    %esi,(%esp)
801030ce:	e8 cd d0 ff ff       	call   801001a0 <bwrite>
    brelse(from);
801030d3:	89 3c 24             	mov    %edi,(%esp)
801030d6:	e8 05 d1 ff ff       	call   801001e0 <brelse>
    brelse(to);
801030db:	89 34 24             	mov    %esi,(%esp)
801030de:	e8 fd d0 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801030e3:	83 c4 10             	add    $0x10,%esp
801030e6:	3b 1d c8 36 11 80    	cmp    0x801136c8,%ebx
801030ec:	7c 94                	jl     80103082 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801030ee:	e8 bd fd ff ff       	call   80102eb0 <write_head>
    install_trans(); // Now install writes to home locations
801030f3:	e8 18 fd ff ff       	call   80102e10 <install_trans>
    log.lh.n = 0;
801030f8:	c7 05 c8 36 11 80 00 	movl   $0x0,0x801136c8
801030ff:	00 00 00 
    write_head();    // Erase the transaction from the log
80103102:	e8 a9 fd ff ff       	call   80102eb0 <write_head>
    acquire(&log.lock);
80103107:	83 ec 0c             	sub    $0xc,%esp
8010310a:	68 80 36 11 80       	push   $0x80113680
8010310f:	e8 ec 17 00 00       	call   80104900 <acquire>
    wakeup(&log);
80103114:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
    log.committing = 0;
8010311b:	c7 05 c0 36 11 80 00 	movl   $0x0,0x801136c0
80103122:	00 00 00 
    wakeup(&log);
80103125:	e8 b6 13 00 00       	call   801044e0 <wakeup>
    release(&log.lock);
8010312a:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
80103131:	e8 8a 18 00 00       	call   801049c0 <release>
80103136:	83 c4 10             	add    $0x10,%esp
}
80103139:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010313c:	5b                   	pop    %ebx
8010313d:	5e                   	pop    %esi
8010313e:	5f                   	pop    %edi
8010313f:	5d                   	pop    %ebp
80103140:	c3                   	ret    
80103141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103148:	83 ec 0c             	sub    $0xc,%esp
8010314b:	68 80 36 11 80       	push   $0x80113680
80103150:	e8 8b 13 00 00       	call   801044e0 <wakeup>
  release(&log.lock);
80103155:	c7 04 24 80 36 11 80 	movl   $0x80113680,(%esp)
8010315c:	e8 5f 18 00 00       	call   801049c0 <release>
80103161:	83 c4 10             	add    $0x10,%esp
}
80103164:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103167:	5b                   	pop    %ebx
80103168:	5e                   	pop    %esi
80103169:	5f                   	pop    %edi
8010316a:	5d                   	pop    %ebp
8010316b:	c3                   	ret    
    panic("log.committing");
8010316c:	83 ec 0c             	sub    $0xc,%esp
8010316f:	68 04 80 10 80       	push   $0x80108004
80103174:	e8 17 d2 ff ff       	call   80100390 <panic>
80103179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103180 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	53                   	push   %ebx
80103184:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103187:	8b 15 c8 36 11 80    	mov    0x801136c8,%edx
{
8010318d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103190:	83 fa 1d             	cmp    $0x1d,%edx
80103193:	0f 8f 9d 00 00 00    	jg     80103236 <log_write+0xb6>
80103199:	a1 b8 36 11 80       	mov    0x801136b8,%eax
8010319e:	83 e8 01             	sub    $0x1,%eax
801031a1:	39 c2                	cmp    %eax,%edx
801031a3:	0f 8d 8d 00 00 00    	jge    80103236 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
801031a9:	a1 bc 36 11 80       	mov    0x801136bc,%eax
801031ae:	85 c0                	test   %eax,%eax
801031b0:	0f 8e 8d 00 00 00    	jle    80103243 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
801031b6:	83 ec 0c             	sub    $0xc,%esp
801031b9:	68 80 36 11 80       	push   $0x80113680
801031be:	e8 3d 17 00 00       	call   80104900 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801031c3:	8b 0d c8 36 11 80    	mov    0x801136c8,%ecx
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	83 f9 00             	cmp    $0x0,%ecx
801031cf:	7e 57                	jle    80103228 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031d1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801031d4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031d6:	3b 15 cc 36 11 80    	cmp    0x801136cc,%edx
801031dc:	75 0b                	jne    801031e9 <log_write+0x69>
801031de:	eb 38                	jmp    80103218 <log_write+0x98>
801031e0:	39 14 85 cc 36 11 80 	cmp    %edx,-0x7feec934(,%eax,4)
801031e7:	74 2f                	je     80103218 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801031e9:	83 c0 01             	add    $0x1,%eax
801031ec:	39 c1                	cmp    %eax,%ecx
801031ee:	75 f0                	jne    801031e0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801031f0:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801031f7:	83 c0 01             	add    $0x1,%eax
801031fa:	a3 c8 36 11 80       	mov    %eax,0x801136c8
  b->flags |= B_DIRTY; // prevent eviction
801031ff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103202:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
80103209:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010320c:	c9                   	leave  
  release(&log.lock);
8010320d:	e9 ae 17 00 00       	jmp    801049c0 <release>
80103212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103218:	89 14 85 cc 36 11 80 	mov    %edx,-0x7feec934(,%eax,4)
8010321f:	eb de                	jmp    801031ff <log_write+0x7f>
80103221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103228:	8b 43 08             	mov    0x8(%ebx),%eax
8010322b:	a3 cc 36 11 80       	mov    %eax,0x801136cc
  if (i == log.lh.n)
80103230:	75 cd                	jne    801031ff <log_write+0x7f>
80103232:	31 c0                	xor    %eax,%eax
80103234:	eb c1                	jmp    801031f7 <log_write+0x77>
    panic("too big a transaction");
80103236:	83 ec 0c             	sub    $0xc,%esp
80103239:	68 13 80 10 80       	push   $0x80108013
8010323e:	e8 4d d1 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103243:	83 ec 0c             	sub    $0xc,%esp
80103246:	68 29 80 10 80       	push   $0x80108029
8010324b:	e8 40 d1 ff ff       	call   80100390 <panic>

80103250 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	53                   	push   %ebx
80103254:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103257:	e8 d4 09 00 00       	call   80103c30 <cpuid>
8010325c:	89 c3                	mov    %eax,%ebx
8010325e:	e8 cd 09 00 00       	call   80103c30 <cpuid>
80103263:	83 ec 04             	sub    $0x4,%esp
80103266:	53                   	push   %ebx
80103267:	50                   	push   %eax
80103268:	68 44 80 10 80       	push   $0x80108044
8010326d:	e8 ee d3 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103272:	e8 59 2a 00 00       	call   80105cd0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103277:	e8 34 09 00 00       	call   80103bb0 <mycpu>
8010327c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010327e:	b8 01 00 00 00       	mov    $0x1,%eax
80103283:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010328a:	e8 81 0d 00 00       	call   80104010 <scheduler>
8010328f:	90                   	nop

80103290 <mpenter>:
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103296:	e8 c5 3a 00 00       	call   80106d60 <switchkvm>
  seginit();
8010329b:	e8 30 3a 00 00       	call   80106cd0 <seginit>
  lapicinit();
801032a0:	e8 9b f7 ff ff       	call   80102a40 <lapicinit>
  mpmain();
801032a5:	e8 a6 ff ff ff       	call   80103250 <mpmain>
801032aa:	66 90                	xchg   %ax,%ax
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <main>:
{
801032b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801032b4:	83 e4 f0             	and    $0xfffffff0,%esp
801032b7:	ff 71 fc             	pushl  -0x4(%ecx)
801032ba:	55                   	push   %ebp
801032bb:	89 e5                	mov    %esp,%ebp
801032bd:	53                   	push   %ebx
801032be:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801032bf:	83 ec 08             	sub    $0x8,%esp
801032c2:	68 00 00 40 80       	push   $0x80400000
801032c7:	68 a8 a8 11 80       	push   $0x8011a8a8
801032cc:	e8 2f f5 ff ff       	call   80102800 <kinit1>
  kvmalloc();      // kernel page table
801032d1:	e8 1a 40 00 00       	call   801072f0 <kvmalloc>
  mpinit();        // detect other processors
801032d6:	e8 75 01 00 00       	call   80103450 <mpinit>
  lapicinit();     // interrupt controller
801032db:	e8 60 f7 ff ff       	call   80102a40 <lapicinit>
  seginit();       // segment descriptors
801032e0:	e8 eb 39 00 00       	call   80106cd0 <seginit>
  picinit();       // disable pic
801032e5:	e8 46 03 00 00       	call   80103630 <picinit>
  ioapicinit();    // another interrupt controller
801032ea:	e8 41 f3 ff ff       	call   80102630 <ioapicinit>
  consoleinit();   // console hardware
801032ef:	e8 cc d6 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801032f4:	e8 47 2d 00 00       	call   80106040 <uartinit>
  pinit();         // process table
801032f9:	e8 92 08 00 00       	call   80103b90 <pinit>
  tvinit();        // trap vectors
801032fe:	e8 4d 29 00 00       	call   80105c50 <tvinit>
  binit();         // buffer cache
80103303:	e8 38 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103308:	e8 d3 da ff ff       	call   80100de0 <fileinit>
  ideinit();       // disk 
8010330d:	e8 fe f0 ff ff       	call   80102410 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103312:	83 c4 0c             	add    $0xc,%esp
80103315:	68 8a 00 00 00       	push   $0x8a
8010331a:	68 8c b4 10 80       	push   $0x8010b48c
8010331f:	68 00 70 00 80       	push   $0x80007000
80103324:	e8 97 17 00 00       	call   80104ac0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103329:	69 05 00 3d 11 80 b0 	imul   $0xb0,0x80113d00,%eax
80103330:	00 00 00 
80103333:	83 c4 10             	add    $0x10,%esp
80103336:	05 80 37 11 80       	add    $0x80113780,%eax
8010333b:	3d 80 37 11 80       	cmp    $0x80113780,%eax
80103340:	76 71                	jbe    801033b3 <main+0x103>
80103342:	bb 80 37 11 80       	mov    $0x80113780,%ebx
80103347:	89 f6                	mov    %esi,%esi
80103349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103350:	e8 5b 08 00 00       	call   80103bb0 <mycpu>
80103355:	39 d8                	cmp    %ebx,%eax
80103357:	74 41                	je     8010339a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103359:	e8 72 f5 ff ff       	call   801028d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010335e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103363:	c7 05 f8 6f 00 80 90 	movl   $0x80103290,0x80006ff8
8010336a:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010336d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103374:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103377:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010337c:	0f b6 03             	movzbl (%ebx),%eax
8010337f:	83 ec 08             	sub    $0x8,%esp
80103382:	68 00 70 00 00       	push   $0x7000
80103387:	50                   	push   %eax
80103388:	e8 03 f8 ff ff       	call   80102b90 <lapicstartap>
8010338d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103390:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103396:	85 c0                	test   %eax,%eax
80103398:	74 f6                	je     80103390 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010339a:	69 05 00 3d 11 80 b0 	imul   $0xb0,0x80113d00,%eax
801033a1:	00 00 00 
801033a4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801033aa:	05 80 37 11 80       	add    $0x80113780,%eax
801033af:	39 c3                	cmp    %eax,%ebx
801033b1:	72 9d                	jb     80103350 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801033b3:	83 ec 08             	sub    $0x8,%esp
801033b6:	68 00 00 00 8e       	push   $0x8e000000
801033bb:	68 00 00 40 80       	push   $0x80400000
801033c0:	e8 ab f4 ff ff       	call   80102870 <kinit2>
  userinit();      // first user process
801033c5:	e8 b6 08 00 00       	call   80103c80 <userinit>
  mpmain();        // finish this processor's setup
801033ca:	e8 81 fe ff ff       	call   80103250 <mpmain>
801033cf:	90                   	nop

801033d0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	57                   	push   %edi
801033d4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801033d5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801033db:	53                   	push   %ebx
  e = addr+len;
801033dc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801033df:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801033e2:	39 de                	cmp    %ebx,%esi
801033e4:	72 10                	jb     801033f6 <mpsearch1+0x26>
801033e6:	eb 50                	jmp    80103438 <mpsearch1+0x68>
801033e8:	90                   	nop
801033e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033f0:	39 fb                	cmp    %edi,%ebx
801033f2:	89 fe                	mov    %edi,%esi
801033f4:	76 42                	jbe    80103438 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033f6:	83 ec 04             	sub    $0x4,%esp
801033f9:	8d 7e 10             	lea    0x10(%esi),%edi
801033fc:	6a 04                	push   $0x4
801033fe:	68 58 80 10 80       	push   $0x80108058
80103403:	56                   	push   %esi
80103404:	e8 57 16 00 00       	call   80104a60 <memcmp>
80103409:	83 c4 10             	add    $0x10,%esp
8010340c:	85 c0                	test   %eax,%eax
8010340e:	75 e0                	jne    801033f0 <mpsearch1+0x20>
80103410:	89 f1                	mov    %esi,%ecx
80103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103418:	0f b6 11             	movzbl (%ecx),%edx
8010341b:	83 c1 01             	add    $0x1,%ecx
8010341e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103420:	39 f9                	cmp    %edi,%ecx
80103422:	75 f4                	jne    80103418 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103424:	84 c0                	test   %al,%al
80103426:	75 c8                	jne    801033f0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103428:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010342b:	89 f0                	mov    %esi,%eax
8010342d:	5b                   	pop    %ebx
8010342e:	5e                   	pop    %esi
8010342f:	5f                   	pop    %edi
80103430:	5d                   	pop    %ebp
80103431:	c3                   	ret    
80103432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103438:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010343b:	31 f6                	xor    %esi,%esi
}
8010343d:	89 f0                	mov    %esi,%eax
8010343f:	5b                   	pop    %ebx
80103440:	5e                   	pop    %esi
80103441:	5f                   	pop    %edi
80103442:	5d                   	pop    %ebp
80103443:	c3                   	ret    
80103444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010344a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103450 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	57                   	push   %edi
80103454:	56                   	push   %esi
80103455:	53                   	push   %ebx
80103456:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103459:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103460:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103467:	c1 e0 08             	shl    $0x8,%eax
8010346a:	09 d0                	or     %edx,%eax
8010346c:	c1 e0 04             	shl    $0x4,%eax
8010346f:	85 c0                	test   %eax,%eax
80103471:	75 1b                	jne    8010348e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103473:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010347a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103481:	c1 e0 08             	shl    $0x8,%eax
80103484:	09 d0                	or     %edx,%eax
80103486:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103489:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010348e:	ba 00 04 00 00       	mov    $0x400,%edx
80103493:	e8 38 ff ff ff       	call   801033d0 <mpsearch1>
80103498:	85 c0                	test   %eax,%eax
8010349a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010349d:	0f 84 3d 01 00 00    	je     801035e0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801034a6:	8b 58 04             	mov    0x4(%eax),%ebx
801034a9:	85 db                	test   %ebx,%ebx
801034ab:	0f 84 4f 01 00 00    	je     80103600 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801034b1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801034b7:	83 ec 04             	sub    $0x4,%esp
801034ba:	6a 04                	push   $0x4
801034bc:	68 75 80 10 80       	push   $0x80108075
801034c1:	56                   	push   %esi
801034c2:	e8 99 15 00 00       	call   80104a60 <memcmp>
801034c7:	83 c4 10             	add    $0x10,%esp
801034ca:	85 c0                	test   %eax,%eax
801034cc:	0f 85 2e 01 00 00    	jne    80103600 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801034d2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801034d9:	3c 01                	cmp    $0x1,%al
801034db:	0f 95 c2             	setne  %dl
801034de:	3c 04                	cmp    $0x4,%al
801034e0:	0f 95 c0             	setne  %al
801034e3:	20 c2                	and    %al,%dl
801034e5:	0f 85 15 01 00 00    	jne    80103600 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801034eb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801034f2:	66 85 ff             	test   %di,%di
801034f5:	74 1a                	je     80103511 <mpinit+0xc1>
801034f7:	89 f0                	mov    %esi,%eax
801034f9:	01 f7                	add    %esi,%edi
  sum = 0;
801034fb:	31 d2                	xor    %edx,%edx
801034fd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103500:	0f b6 08             	movzbl (%eax),%ecx
80103503:	83 c0 01             	add    $0x1,%eax
80103506:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103508:	39 c7                	cmp    %eax,%edi
8010350a:	75 f4                	jne    80103500 <mpinit+0xb0>
8010350c:	84 d2                	test   %dl,%dl
8010350e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103511:	85 f6                	test   %esi,%esi
80103513:	0f 84 e7 00 00 00    	je     80103600 <mpinit+0x1b0>
80103519:	84 d2                	test   %dl,%dl
8010351b:	0f 85 df 00 00 00    	jne    80103600 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103521:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103527:	a3 7c 36 11 80       	mov    %eax,0x8011367c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010352c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103533:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103539:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010353e:	01 d6                	add    %edx,%esi
80103540:	39 c6                	cmp    %eax,%esi
80103542:	76 23                	jbe    80103567 <mpinit+0x117>
    switch(*p){
80103544:	0f b6 10             	movzbl (%eax),%edx
80103547:	80 fa 04             	cmp    $0x4,%dl
8010354a:	0f 87 ca 00 00 00    	ja     8010361a <mpinit+0x1ca>
80103550:	ff 24 95 9c 80 10 80 	jmp    *-0x7fef7f64(,%edx,4)
80103557:	89 f6                	mov    %esi,%esi
80103559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103560:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103563:	39 c6                	cmp    %eax,%esi
80103565:	77 dd                	ja     80103544 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103567:	85 db                	test   %ebx,%ebx
80103569:	0f 84 9e 00 00 00    	je     8010360d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010356f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103572:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103576:	74 15                	je     8010358d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103578:	b8 70 00 00 00       	mov    $0x70,%eax
8010357d:	ba 22 00 00 00       	mov    $0x22,%edx
80103582:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103583:	ba 23 00 00 00       	mov    $0x23,%edx
80103588:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103589:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010358c:	ee                   	out    %al,(%dx)
  }
}
8010358d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103590:	5b                   	pop    %ebx
80103591:	5e                   	pop    %esi
80103592:	5f                   	pop    %edi
80103593:	5d                   	pop    %ebp
80103594:	c3                   	ret    
80103595:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103598:	8b 0d 00 3d 11 80    	mov    0x80113d00,%ecx
8010359e:	83 f9 07             	cmp    $0x7,%ecx
801035a1:	7f 19                	jg     801035bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801035a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801035ad:	83 c1 01             	add    $0x1,%ecx
801035b0:	89 0d 00 3d 11 80    	mov    %ecx,0x80113d00
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035b6:	88 97 80 37 11 80    	mov    %dl,-0x7feec880(%edi)
      p += sizeof(struct mpproc);
801035bc:	83 c0 14             	add    $0x14,%eax
      continue;
801035bf:	e9 7c ff ff ff       	jmp    80103540 <mpinit+0xf0>
801035c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801035c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801035cc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801035cf:	88 15 60 37 11 80    	mov    %dl,0x80113760
      continue;
801035d5:	e9 66 ff ff ff       	jmp    80103540 <mpinit+0xf0>
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801035e0:	ba 00 00 01 00       	mov    $0x10000,%edx
801035e5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801035ea:	e8 e1 fd ff ff       	call   801033d0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035ef:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801035f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801035f4:	0f 85 a9 fe ff ff    	jne    801034a3 <mpinit+0x53>
801035fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103600:	83 ec 0c             	sub    $0xc,%esp
80103603:	68 5d 80 10 80       	push   $0x8010805d
80103608:	e8 83 cd ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010360d:	83 ec 0c             	sub    $0xc,%esp
80103610:	68 7c 80 10 80       	push   $0x8010807c
80103615:	e8 76 cd ff ff       	call   80100390 <panic>
      ismp = 0;
8010361a:	31 db                	xor    %ebx,%ebx
8010361c:	e9 26 ff ff ff       	jmp    80103547 <mpinit+0xf7>
80103621:	66 90                	xchg   %ax,%ax
80103623:	66 90                	xchg   %ax,%ax
80103625:	66 90                	xchg   %ax,%ax
80103627:	66 90                	xchg   %ax,%ax
80103629:	66 90                	xchg   %ax,%ax
8010362b:	66 90                	xchg   %ax,%ax
8010362d:	66 90                	xchg   %ax,%ax
8010362f:	90                   	nop

80103630 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103630:	55                   	push   %ebp
80103631:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103636:	ba 21 00 00 00       	mov    $0x21,%edx
8010363b:	89 e5                	mov    %esp,%ebp
8010363d:	ee                   	out    %al,(%dx)
8010363e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103643:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103644:	5d                   	pop    %ebp
80103645:	c3                   	ret    
80103646:	66 90                	xchg   %ax,%ax
80103648:	66 90                	xchg   %ax,%ax
8010364a:	66 90                	xchg   %ax,%ax
8010364c:	66 90                	xchg   %ax,%ax
8010364e:	66 90                	xchg   %ax,%ax

80103650 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	53                   	push   %ebx
80103656:	83 ec 0c             	sub    $0xc,%esp
80103659:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010365c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010365f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103665:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010366b:	e8 90 d7 ff ff       	call   80100e00 <filealloc>
80103670:	85 c0                	test   %eax,%eax
80103672:	89 03                	mov    %eax,(%ebx)
80103674:	74 22                	je     80103698 <pipealloc+0x48>
80103676:	e8 85 d7 ff ff       	call   80100e00 <filealloc>
8010367b:	85 c0                	test   %eax,%eax
8010367d:	89 06                	mov    %eax,(%esi)
8010367f:	74 3f                	je     801036c0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103681:	e8 4a f2 ff ff       	call   801028d0 <kalloc>
80103686:	85 c0                	test   %eax,%eax
80103688:	89 c7                	mov    %eax,%edi
8010368a:	75 54                	jne    801036e0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010368c:	8b 03                	mov    (%ebx),%eax
8010368e:	85 c0                	test   %eax,%eax
80103690:	75 34                	jne    801036c6 <pipealloc+0x76>
80103692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103698:	8b 06                	mov    (%esi),%eax
8010369a:	85 c0                	test   %eax,%eax
8010369c:	74 0c                	je     801036aa <pipealloc+0x5a>
    fileclose(*f1);
8010369e:	83 ec 0c             	sub    $0xc,%esp
801036a1:	50                   	push   %eax
801036a2:	e8 19 d8 ff ff       	call   80100ec0 <fileclose>
801036a7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801036aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801036ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801036b2:	5b                   	pop    %ebx
801036b3:	5e                   	pop    %esi
801036b4:	5f                   	pop    %edi
801036b5:	5d                   	pop    %ebp
801036b6:	c3                   	ret    
801036b7:	89 f6                	mov    %esi,%esi
801036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801036c0:	8b 03                	mov    (%ebx),%eax
801036c2:	85 c0                	test   %eax,%eax
801036c4:	74 e4                	je     801036aa <pipealloc+0x5a>
    fileclose(*f0);
801036c6:	83 ec 0c             	sub    $0xc,%esp
801036c9:	50                   	push   %eax
801036ca:	e8 f1 d7 ff ff       	call   80100ec0 <fileclose>
  if(*f1)
801036cf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801036d1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036d4:	85 c0                	test   %eax,%eax
801036d6:	75 c6                	jne    8010369e <pipealloc+0x4e>
801036d8:	eb d0                	jmp    801036aa <pipealloc+0x5a>
801036da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801036e0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801036e3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036ea:	00 00 00 
  p->writeopen = 1;
801036ed:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036f4:	00 00 00 
  p->nwrite = 0;
801036f7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036fe:	00 00 00 
  p->nread = 0;
80103701:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103708:	00 00 00 
  initlock(&p->lock, "pipe");
8010370b:	68 b0 80 10 80       	push   $0x801080b0
80103710:	50                   	push   %eax
80103711:	e8 aa 10 00 00       	call   801047c0 <initlock>
  (*f0)->type = FD_PIPE;
80103716:	8b 03                	mov    (%ebx),%eax
  return 0;
80103718:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010371b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103721:	8b 03                	mov    (%ebx),%eax
80103723:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103727:	8b 03                	mov    (%ebx),%eax
80103729:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010372d:	8b 03                	mov    (%ebx),%eax
8010372f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103732:	8b 06                	mov    (%esi),%eax
80103734:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010373a:	8b 06                	mov    (%esi),%eax
8010373c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103740:	8b 06                	mov    (%esi),%eax
80103742:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103746:	8b 06                	mov    (%esi),%eax
80103748:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010374b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010374e:	31 c0                	xor    %eax,%eax
}
80103750:	5b                   	pop    %ebx
80103751:	5e                   	pop    %esi
80103752:	5f                   	pop    %edi
80103753:	5d                   	pop    %ebp
80103754:	c3                   	ret    
80103755:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103760 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103760:	55                   	push   %ebp
80103761:	89 e5                	mov    %esp,%ebp
80103763:	56                   	push   %esi
80103764:	53                   	push   %ebx
80103765:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103768:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010376b:	83 ec 0c             	sub    $0xc,%esp
8010376e:	53                   	push   %ebx
8010376f:	e8 8c 11 00 00       	call   80104900 <acquire>
  if(writable){
80103774:	83 c4 10             	add    $0x10,%esp
80103777:	85 f6                	test   %esi,%esi
80103779:	74 45                	je     801037c0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010377b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103781:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103784:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010378b:	00 00 00 
    wakeup(&p->nread);
8010378e:	50                   	push   %eax
8010378f:	e8 4c 0d 00 00       	call   801044e0 <wakeup>
80103794:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103797:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010379d:	85 d2                	test   %edx,%edx
8010379f:	75 0a                	jne    801037ab <pipeclose+0x4b>
801037a1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801037a7:	85 c0                	test   %eax,%eax
801037a9:	74 35                	je     801037e0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801037ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037b1:	5b                   	pop    %ebx
801037b2:	5e                   	pop    %esi
801037b3:	5d                   	pop    %ebp
    release(&p->lock);
801037b4:	e9 07 12 00 00       	jmp    801049c0 <release>
801037b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801037c0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801037c6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801037c9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801037d0:	00 00 00 
    wakeup(&p->nwrite);
801037d3:	50                   	push   %eax
801037d4:	e8 07 0d 00 00       	call   801044e0 <wakeup>
801037d9:	83 c4 10             	add    $0x10,%esp
801037dc:	eb b9                	jmp    80103797 <pipeclose+0x37>
801037de:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801037e0:	83 ec 0c             	sub    $0xc,%esp
801037e3:	53                   	push   %ebx
801037e4:	e8 d7 11 00 00       	call   801049c0 <release>
    kfree((char*)p);
801037e9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801037ec:	83 c4 10             	add    $0x10,%esp
}
801037ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037f2:	5b                   	pop    %ebx
801037f3:	5e                   	pop    %esi
801037f4:	5d                   	pop    %ebp
    kfree((char*)p);
801037f5:	e9 26 ef ff ff       	jmp    80102720 <kfree>
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103800 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103800:	55                   	push   %ebp
80103801:	89 e5                	mov    %esp,%ebp
80103803:	57                   	push   %edi
80103804:	56                   	push   %esi
80103805:	53                   	push   %ebx
80103806:	83 ec 28             	sub    $0x28,%esp
80103809:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010380c:	53                   	push   %ebx
8010380d:	e8 ee 10 00 00       	call   80104900 <acquire>
  for(i = 0; i < n; i++){
80103812:	8b 45 10             	mov    0x10(%ebp),%eax
80103815:	83 c4 10             	add    $0x10,%esp
80103818:	85 c0                	test   %eax,%eax
8010381a:	0f 8e c9 00 00 00    	jle    801038e9 <pipewrite+0xe9>
80103820:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103823:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103829:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010382f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103832:	03 4d 10             	add    0x10(%ebp),%ecx
80103835:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103838:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010383e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103844:	39 d0                	cmp    %edx,%eax
80103846:	75 71                	jne    801038b9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103848:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010384e:	85 c0                	test   %eax,%eax
80103850:	74 4e                	je     801038a0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103852:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103858:	eb 3a                	jmp    80103894 <pipewrite+0x94>
8010385a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103860:	83 ec 0c             	sub    $0xc,%esp
80103863:	57                   	push   %edi
80103864:	e8 77 0c 00 00       	call   801044e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103869:	5a                   	pop    %edx
8010386a:	59                   	pop    %ecx
8010386b:	53                   	push   %ebx
8010386c:	56                   	push   %esi
8010386d:	e8 ae 0a 00 00       	call   80104320 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103872:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103878:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010387e:	83 c4 10             	add    $0x10,%esp
80103881:	05 00 02 00 00       	add    $0x200,%eax
80103886:	39 c2                	cmp    %eax,%edx
80103888:	75 36                	jne    801038c0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010388a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103890:	85 c0                	test   %eax,%eax
80103892:	74 0c                	je     801038a0 <pipewrite+0xa0>
80103894:	e8 b7 03 00 00       	call   80103c50 <myproc>
80103899:	8b 40 24             	mov    0x24(%eax),%eax
8010389c:	85 c0                	test   %eax,%eax
8010389e:	74 c0                	je     80103860 <pipewrite+0x60>
        release(&p->lock);
801038a0:	83 ec 0c             	sub    $0xc,%esp
801038a3:	53                   	push   %ebx
801038a4:	e8 17 11 00 00       	call   801049c0 <release>
        return -1;
801038a9:	83 c4 10             	add    $0x10,%esp
801038ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801038b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b4:	5b                   	pop    %ebx
801038b5:	5e                   	pop    %esi
801038b6:	5f                   	pop    %edi
801038b7:	5d                   	pop    %ebp
801038b8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801038b9:	89 c2                	mov    %eax,%edx
801038bb:	90                   	nop
801038bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038c0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801038c3:	8d 42 01             	lea    0x1(%edx),%eax
801038c6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801038cc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038d2:	83 c6 01             	add    $0x1,%esi
801038d5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801038d9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801038dc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038df:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801038e3:	0f 85 4f ff ff ff    	jne    80103838 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801038e9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801038ef:	83 ec 0c             	sub    $0xc,%esp
801038f2:	50                   	push   %eax
801038f3:	e8 e8 0b 00 00       	call   801044e0 <wakeup>
  release(&p->lock);
801038f8:	89 1c 24             	mov    %ebx,(%esp)
801038fb:	e8 c0 10 00 00       	call   801049c0 <release>
  return n;
80103900:	83 c4 10             	add    $0x10,%esp
80103903:	8b 45 10             	mov    0x10(%ebp),%eax
80103906:	eb a9                	jmp    801038b1 <pipewrite+0xb1>
80103908:	90                   	nop
80103909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103910 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	57                   	push   %edi
80103914:	56                   	push   %esi
80103915:	53                   	push   %ebx
80103916:	83 ec 18             	sub    $0x18,%esp
80103919:	8b 75 08             	mov    0x8(%ebp),%esi
8010391c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010391f:	56                   	push   %esi
80103920:	e8 db 0f 00 00       	call   80104900 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010392e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103934:	75 6a                	jne    801039a0 <piperead+0x90>
80103936:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010393c:	85 db                	test   %ebx,%ebx
8010393e:	0f 84 c4 00 00 00    	je     80103a08 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103944:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010394a:	eb 2d                	jmp    80103979 <piperead+0x69>
8010394c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103950:	83 ec 08             	sub    $0x8,%esp
80103953:	56                   	push   %esi
80103954:	53                   	push   %ebx
80103955:	e8 c6 09 00 00       	call   80104320 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010395a:	83 c4 10             	add    $0x10,%esp
8010395d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103963:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103969:	75 35                	jne    801039a0 <piperead+0x90>
8010396b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103971:	85 d2                	test   %edx,%edx
80103973:	0f 84 8f 00 00 00    	je     80103a08 <piperead+0xf8>
    if(myproc()->killed){
80103979:	e8 d2 02 00 00       	call   80103c50 <myproc>
8010397e:	8b 48 24             	mov    0x24(%eax),%ecx
80103981:	85 c9                	test   %ecx,%ecx
80103983:	74 cb                	je     80103950 <piperead+0x40>
      release(&p->lock);
80103985:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103988:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010398d:	56                   	push   %esi
8010398e:	e8 2d 10 00 00       	call   801049c0 <release>
      return -1;
80103993:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103996:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103999:	89 d8                	mov    %ebx,%eax
8010399b:	5b                   	pop    %ebx
8010399c:	5e                   	pop    %esi
8010399d:	5f                   	pop    %edi
8010399e:	5d                   	pop    %ebp
8010399f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039a0:	8b 45 10             	mov    0x10(%ebp),%eax
801039a3:	85 c0                	test   %eax,%eax
801039a5:	7e 61                	jle    80103a08 <piperead+0xf8>
    if(p->nread == p->nwrite)
801039a7:	31 db                	xor    %ebx,%ebx
801039a9:	eb 13                	jmp    801039be <piperead+0xae>
801039ab:	90                   	nop
801039ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039b0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801039b6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801039bc:	74 1f                	je     801039dd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801039be:	8d 41 01             	lea    0x1(%ecx),%eax
801039c1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801039c7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801039cd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801039d2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039d5:	83 c3 01             	add    $0x1,%ebx
801039d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039db:	75 d3                	jne    801039b0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039dd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039e3:	83 ec 0c             	sub    $0xc,%esp
801039e6:	50                   	push   %eax
801039e7:	e8 f4 0a 00 00       	call   801044e0 <wakeup>
  release(&p->lock);
801039ec:	89 34 24             	mov    %esi,(%esp)
801039ef:	e8 cc 0f 00 00       	call   801049c0 <release>
  return i;
801039f4:	83 c4 10             	add    $0x10,%esp
}
801039f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039fa:	89 d8                	mov    %ebx,%eax
801039fc:	5b                   	pop    %ebx
801039fd:	5e                   	pop    %esi
801039fe:	5f                   	pop    %edi
801039ff:	5d                   	pop    %ebp
80103a00:	c3                   	ret    
80103a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103a08:	31 db                	xor    %ebx,%ebx
80103a0a:	eb d1                	jmp    801039dd <piperead+0xcd>
80103a0c:	66 90                	xchg   %ax,%ax
80103a0e:	66 90                	xchg   %ax,%ax

80103a10 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a14:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
{
80103a19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a1c:	68 20 3d 11 80       	push   $0x80113d20
80103a21:	e8 da 0e 00 00       	call   80104900 <acquire>
80103a26:	83 c4 10             	add    $0x10,%esp
80103a29:	eb 17                	jmp    80103a42 <allocproc+0x32>
80103a2b:	90                   	nop
80103a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a30:	81 c3 8c 01 00 00    	add    $0x18c,%ebx
80103a36:	81 fb 54 a0 11 80    	cmp    $0x8011a054,%ebx
80103a3c:	0f 83 d6 00 00 00    	jae    80103b18 <allocproc+0x108>
    if(p->state == UNUSED)
80103a42:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a45:	85 c0                	test   %eax,%eax
80103a47:	75 e7                	jne    80103a30 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a49:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103a4e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a51:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a58:	8d 50 01             	lea    0x1(%eax),%edx
80103a5b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103a5e:	68 20 3d 11 80       	push   $0x80113d20
  p->pid = nextpid++;
80103a63:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103a69:	e8 52 0f 00 00       	call   801049c0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a6e:	e8 5d ee ff ff       	call   801028d0 <kalloc>
80103a73:	83 c4 10             	add    $0x10,%esp
80103a76:	85 c0                	test   %eax,%eax
80103a78:	89 43 08             	mov    %eax,0x8(%ebx)
80103a7b:	0f 84 b0 00 00 00    	je     80103b31 <allocproc+0x121>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a81:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a87:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a8a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a8f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a92:	c7 40 14 42 5c 10 80 	movl   $0x80105c42,0x14(%eax)
  p->context = (struct context*)sp;
80103a99:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a9c:	6a 14                	push   $0x14
80103a9e:	6a 00                	push   $0x0
80103aa0:	50                   	push   %eax
80103aa1:	e8 6a 0f 00 00       	call   80104a10 <memset>
  p->context->eip = (uint)forkret;
80103aa6:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103aa9:	8d 93 8c 00 00 00    	lea    0x8c(%ebx),%edx
80103aaf:	8d 8b 8c 01 00 00    	lea    0x18c(%ebx),%ecx
80103ab5:	83 c4 10             	add    $0x10,%esp
80103ab8:	c7 40 10 40 3b 10 80 	movl   $0x80103b40,0x10(%eax)
80103abf:	8d 83 cc 00 00 00    	lea    0xcc(%ebx),%eax
80103ac5:	8d 76 00             	lea    0x0(%esi),%esi

  // Task 1
  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103ac8:	c7 02 ff ff ff ff    	movl   $0xffffffff,(%edx)
80103ace:	83 c0 0c             	add    $0xc,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103ad1:	c7 40 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%eax)
    p->physicalPGs[i].prev = 0;
80103ad8:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
    p->physicalPGs[i].next = 0;
80103adf:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
80103ae6:	83 c2 04             	add    $0x4,%edx
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103ae9:	39 c8                	cmp    %ecx,%eax
80103aeb:	75 db                	jne    80103ac8 <allocproc+0xb8>
  }
  p->nPgsSwap = 0;
80103aed:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103af4:	00 00 00 
  p->nPgsPhysical = 0;
80103af7:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103afe:	00 00 00 
  p->headPG = 0;
80103b01:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103b08:	00 00 00 

  return p;
}
80103b0b:	89 d8                	mov    %ebx,%eax
80103b0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b10:	c9                   	leave  
80103b11:	c3                   	ret    
80103b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103b18:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103b1b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103b1d:	68 20 3d 11 80       	push   $0x80113d20
80103b22:	e8 99 0e 00 00       	call   801049c0 <release>
}
80103b27:	89 d8                	mov    %ebx,%eax
  return 0;
80103b29:	83 c4 10             	add    $0x10,%esp
}
80103b2c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b2f:	c9                   	leave  
80103b30:	c3                   	ret    
    p->state = UNUSED;
80103b31:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103b38:	31 db                	xor    %ebx,%ebx
80103b3a:	eb cf                	jmp    80103b0b <allocproc+0xfb>
80103b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103b40 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103b46:	68 20 3d 11 80       	push   $0x80113d20
80103b4b:	e8 70 0e 00 00       	call   801049c0 <release>

  if (first) {
80103b50:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103b55:	83 c4 10             	add    $0x10,%esp
80103b58:	85 c0                	test   %eax,%eax
80103b5a:	75 04                	jne    80103b60 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b5c:	c9                   	leave  
80103b5d:	c3                   	ret    
80103b5e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103b60:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103b63:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103b6a:	00 00 00 
    iinit(ROOTDEV);
80103b6d:	6a 01                	push   $0x1
80103b6f:	e8 8c d9 ff ff       	call   80101500 <iinit>
    initlog(ROOTDEV);
80103b74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b7b:	e8 90 f3 ff ff       	call   80102f10 <initlog>
80103b80:	83 c4 10             	add    $0x10,%esp
}
80103b83:	c9                   	leave  
80103b84:	c3                   	ret    
80103b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b90 <pinit>:
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b96:	68 b5 80 10 80       	push   $0x801080b5
80103b9b:	68 20 3d 11 80       	push   $0x80113d20
80103ba0:	e8 1b 0c 00 00       	call   801047c0 <initlock>
}
80103ba5:	83 c4 10             	add    $0x10,%esp
80103ba8:	c9                   	leave  
80103ba9:	c3                   	ret    
80103baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103bb0 <mycpu>:
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	56                   	push   %esi
80103bb4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103bb5:	9c                   	pushf  
80103bb6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103bb7:	f6 c4 02             	test   $0x2,%ah
80103bba:	75 5e                	jne    80103c1a <mycpu+0x6a>
  apicid = lapicid();
80103bbc:	e8 7f ef ff ff       	call   80102b40 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103bc1:	8b 35 00 3d 11 80    	mov    0x80113d00,%esi
80103bc7:	85 f6                	test   %esi,%esi
80103bc9:	7e 42                	jle    80103c0d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103bcb:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
80103bd2:	39 d0                	cmp    %edx,%eax
80103bd4:	74 30                	je     80103c06 <mycpu+0x56>
80103bd6:	b9 30 38 11 80       	mov    $0x80113830,%ecx
  for (i = 0; i < ncpu; ++i) {
80103bdb:	31 d2                	xor    %edx,%edx
80103bdd:	8d 76 00             	lea    0x0(%esi),%esi
80103be0:	83 c2 01             	add    $0x1,%edx
80103be3:	39 f2                	cmp    %esi,%edx
80103be5:	74 26                	je     80103c0d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103be7:	0f b6 19             	movzbl (%ecx),%ebx
80103bea:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103bf0:	39 c3                	cmp    %eax,%ebx
80103bf2:	75 ec                	jne    80103be0 <mycpu+0x30>
80103bf4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103bfa:	05 80 37 11 80       	add    $0x80113780,%eax
}
80103bff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c02:	5b                   	pop    %ebx
80103c03:	5e                   	pop    %esi
80103c04:	5d                   	pop    %ebp
80103c05:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103c06:	b8 80 37 11 80       	mov    $0x80113780,%eax
      return &cpus[i];
80103c0b:	eb f2                	jmp    80103bff <mycpu+0x4f>
  panic("unknown apicid\n");
80103c0d:	83 ec 0c             	sub    $0xc,%esp
80103c10:	68 bc 80 10 80       	push   $0x801080bc
80103c15:	e8 76 c7 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103c1a:	83 ec 0c             	sub    $0xc,%esp
80103c1d:	68 bc 81 10 80       	push   $0x801081bc
80103c22:	e8 69 c7 ff ff       	call   80100390 <panic>
80103c27:	89 f6                	mov    %esi,%esi
80103c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c30 <cpuid>:
cpuid() {
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103c36:	e8 75 ff ff ff       	call   80103bb0 <mycpu>
80103c3b:	2d 80 37 11 80       	sub    $0x80113780,%eax
}
80103c40:	c9                   	leave  
  return mycpu()-cpus;
80103c41:	c1 f8 04             	sar    $0x4,%eax
80103c44:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103c4a:	c3                   	ret    
80103c4b:	90                   	nop
80103c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103c50 <myproc>:
myproc(void) {
80103c50:	55                   	push   %ebp
80103c51:	89 e5                	mov    %esp,%ebp
80103c53:	53                   	push   %ebx
80103c54:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103c57:	e8 d4 0b 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103c5c:	e8 4f ff ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
80103c61:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c67:	e8 04 0c 00 00       	call   80104870 <popcli>
}
80103c6c:	83 c4 04             	add    $0x4,%esp
80103c6f:	89 d8                	mov    %ebx,%eax
80103c71:	5b                   	pop    %ebx
80103c72:	5d                   	pop    %ebp
80103c73:	c3                   	ret    
80103c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c80 <userinit>:
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
80103c84:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c87:	e8 84 fd ff ff       	call   80103a10 <allocproc>
80103c8c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c8e:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103c93:	e8 d8 35 00 00       	call   80107270 <setupkvm>
80103c98:	85 c0                	test   %eax,%eax
80103c9a:	89 43 04             	mov    %eax,0x4(%ebx)
80103c9d:	0f 84 bd 00 00 00    	je     80103d60 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ca3:	83 ec 04             	sub    $0x4,%esp
80103ca6:	68 2c 00 00 00       	push   $0x2c
80103cab:	68 60 b4 10 80       	push   $0x8010b460
80103cb0:	50                   	push   %eax
80103cb1:	e8 da 31 00 00       	call   80106e90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103cb6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103cb9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103cbf:	6a 4c                	push   $0x4c
80103cc1:	6a 00                	push   $0x0
80103cc3:	ff 73 18             	pushl  0x18(%ebx)
80103cc6:	e8 45 0d 00 00       	call   80104a10 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103ccb:	8b 43 18             	mov    0x18(%ebx),%eax
80103cce:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103cd3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103cd8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103cdb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103cdf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103ce6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ce9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ced:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103cf1:	8b 43 18             	mov    0x18(%ebx),%eax
80103cf4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103cf8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103cfc:	8b 43 18             	mov    0x18(%ebx),%eax
80103cff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103d06:	8b 43 18             	mov    0x18(%ebx),%eax
80103d09:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103d10:	8b 43 18             	mov    0x18(%ebx),%eax
80103d13:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103d1a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103d1d:	6a 10                	push   $0x10
80103d1f:	68 e5 80 10 80       	push   $0x801080e5
80103d24:	50                   	push   %eax
80103d25:	e8 c6 0e 00 00       	call   80104bf0 <safestrcpy>
  p->cwd = namei("/");
80103d2a:	c7 04 24 ee 80 10 80 	movl   $0x801080ee,(%esp)
80103d31:	e8 2a e2 ff ff       	call   80101f60 <namei>
80103d36:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103d39:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103d40:	e8 bb 0b 00 00       	call   80104900 <acquire>
  p->state = RUNNABLE;
80103d45:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103d4c:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103d53:	e8 68 0c 00 00       	call   801049c0 <release>
}
80103d58:	83 c4 10             	add    $0x10,%esp
80103d5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d5e:	c9                   	leave  
80103d5f:	c3                   	ret    
    panic("userinit: out of memory?");
80103d60:	83 ec 0c             	sub    $0xc,%esp
80103d63:	68 cc 80 10 80       	push   $0x801080cc
80103d68:	e8 23 c6 ff ff       	call   80100390 <panic>
80103d6d:	8d 76 00             	lea    0x0(%esi),%esi

80103d70 <growproc>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	56                   	push   %esi
80103d74:	53                   	push   %ebx
80103d75:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103d78:	e8 b3 0a 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103d7d:	e8 2e fe ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
80103d82:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d88:	e8 e3 0a 00 00       	call   80104870 <popcli>
  if(n > 0){
80103d8d:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103d90:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103d92:	7f 1c                	jg     80103db0 <growproc+0x40>
  } else if(n < 0){
80103d94:	75 3a                	jne    80103dd0 <growproc+0x60>
  switchuvm(curproc);
80103d96:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103d99:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103d9b:	53                   	push   %ebx
80103d9c:	e8 df 2f 00 00       	call   80106d80 <switchuvm>
  return 0;
80103da1:	83 c4 10             	add    $0x10,%esp
80103da4:	31 c0                	xor    %eax,%eax
}
80103da6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103da9:	5b                   	pop    %ebx
80103daa:	5e                   	pop    %esi
80103dab:	5d                   	pop    %ebp
80103dac:	c3                   	ret    
80103dad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103db0:	83 ec 04             	sub    $0x4,%esp
80103db3:	01 c6                	add    %eax,%esi
80103db5:	56                   	push   %esi
80103db6:	50                   	push   %eax
80103db7:	ff 73 04             	pushl  0x4(%ebx)
80103dba:	e8 71 3b 00 00       	call   80107930 <allocuvm>
80103dbf:	83 c4 10             	add    $0x10,%esp
80103dc2:	85 c0                	test   %eax,%eax
80103dc4:	75 d0                	jne    80103d96 <growproc+0x26>
      return -1;
80103dc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103dcb:	eb d9                	jmp    80103da6 <growproc+0x36>
80103dcd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103dd0:	83 ec 04             	sub    $0x4,%esp
80103dd3:	01 c6                	add    %eax,%esi
80103dd5:	56                   	push   %esi
80103dd6:	50                   	push   %eax
80103dd7:	ff 73 04             	pushl  0x4(%ebx)
80103dda:	e8 f1 31 00 00       	call   80106fd0 <deallocuvm>
80103ddf:	83 c4 10             	add    $0x10,%esp
80103de2:	85 c0                	test   %eax,%eax
80103de4:	75 b0                	jne    80103d96 <growproc+0x26>
80103de6:	eb de                	jmp    80103dc6 <growproc+0x56>
80103de8:	90                   	nop
80103de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103df0 <fork>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	57                   	push   %edi
80103df4:	56                   	push   %esi
80103df5:	53                   	push   %ebx
80103df6:	81 ec 1c 08 00 00    	sub    $0x81c,%esp
  pushcli();
80103dfc:	e8 2f 0a 00 00       	call   80104830 <pushcli>
  c = mycpu();
80103e01:	e8 aa fd ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
80103e06:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103e0c:	e8 5f 0a 00 00       	call   80104870 <popcli>
  if((np = allocproc()) == 0){
80103e11:	e8 fa fb ff ff       	call   80103a10 <allocproc>
80103e16:	85 c0                	test   %eax,%eax
80103e18:	89 85 e4 f7 ff ff    	mov    %eax,-0x81c(%ebp)
80103e1e:	0f 84 9f 01 00 00    	je     80103fc3 <fork+0x1d3>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103e24:	83 ec 08             	sub    $0x8,%esp
80103e27:	ff 33                	pushl  (%ebx)
80103e29:	ff 73 04             	pushl  0x4(%ebx)
80103e2c:	89 c7                	mov    %eax,%edi
80103e2e:	e8 0d 35 00 00       	call   80107340 <copyuvm>
80103e33:	83 c4 10             	add    $0x10,%esp
80103e36:	85 c0                	test   %eax,%eax
80103e38:	89 47 04             	mov    %eax,0x4(%edi)
80103e3b:	0f 84 8e 01 00 00    	je     80103fcf <fork+0x1df>
  np->sz = curproc->sz;
80103e41:	8b 03                	mov    (%ebx),%eax
80103e43:	8b 8d e4 f7 ff ff    	mov    -0x81c(%ebp),%ecx
80103e49:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103e4b:	89 59 14             	mov    %ebx,0x14(%ecx)
80103e4e:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103e50:	8b 79 18             	mov    0x18(%ecx),%edi
80103e53:	8b 73 18             	mov    0x18(%ebx),%esi
80103e56:	b9 13 00 00 00       	mov    $0x13,%ecx
80103e5b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
80103e5d:	89 c7                	mov    %eax,%edi
  for(i = 0; i < NOFILE; i++)
80103e5f:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103e61:	8b 40 18             	mov    0x18(%eax),%eax
80103e64:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103e6b:	90                   	nop
80103e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103e70:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103e74:	85 c0                	test   %eax,%eax
80103e76:	74 10                	je     80103e88 <fork+0x98>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103e78:	83 ec 0c             	sub    $0xc,%esp
80103e7b:	50                   	push   %eax
80103e7c:	e8 ef cf ff ff       	call   80100e70 <filedup>
80103e81:	83 c4 10             	add    $0x10,%esp
80103e84:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103e88:	83 c6 01             	add    $0x1,%esi
80103e8b:	83 fe 10             	cmp    $0x10,%esi
80103e8e:	75 e0                	jne    80103e70 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80103e90:	83 ec 0c             	sub    $0xc,%esp
80103e93:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e96:	8d 73 6c             	lea    0x6c(%ebx),%esi
  np->cwd = idup(curproc->cwd);
80103e99:	e8 32 d8 ff ff       	call   801016d0 <idup>
80103e9e:	8b bd e4 f7 ff ff    	mov    -0x81c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103ea4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103ea7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103eaa:	8d 47 6c             	lea    0x6c(%edi),%eax
80103ead:	6a 10                	push   $0x10
80103eaf:	56                   	push   %esi
80103eb0:	50                   	push   %eax
80103eb1:	e8 3a 0d 00 00       	call   80104bf0 <safestrcpy>
  pid = np->pid;
80103eb6:	8b 4f 10             	mov    0x10(%edi),%ecx
  createSwapFile(np); //Task 1.1
80103eb9:	89 3c 24             	mov    %edi,(%esp)
    char buf[PGSIZE / 2] = "";
80103ebc:	8d bd ec f7 ff ff    	lea    -0x814(%ebp),%edi
  pid = np->pid;
80103ec2:	89 8d dc f7 ff ff    	mov    %ecx,-0x824(%ebp)
  createSwapFile(np); //Task 1.1
80103ec8:	e8 63 e3 ff ff       	call   80102230 <createSwapFile>
    if(strncmp(curproc->name, "init", 4) != 0 && strncmp(curproc->name, "sh", 2) != 0){ // TODO : remove the n
80103ecd:	83 c4 0c             	add    $0xc,%esp
    char buf[PGSIZE / 2] = "";
80103ed0:	31 c0                	xor    %eax,%eax
80103ed2:	b9 ff 01 00 00       	mov    $0x1ff,%ecx
80103ed7:	f3 ab                	rep stos %eax,%es:(%edi)
    if(strncmp(curproc->name, "init", 4) != 0 && strncmp(curproc->name, "sh", 2) != 0){ // TODO : remove the n
80103ed9:	6a 04                	push   $0x4
80103edb:	68 f0 80 10 80       	push   $0x801080f0
80103ee0:	56                   	push   %esi
    char buf[PGSIZE / 2] = "";
80103ee1:	c7 85 e8 f7 ff ff 00 	movl   $0x0,-0x818(%ebp)
80103ee8:	00 00 00 
    if(strncmp(curproc->name, "init", 4) != 0 && strncmp(curproc->name, "sh", 2) != 0){ // TODO : remove the n
80103eeb:	e8 40 0c 00 00       	call   80104b30 <strncmp>
80103ef0:	83 c4 10             	add    $0x10,%esp
80103ef3:	85 c0                	test   %eax,%eax
80103ef5:	0f 84 91 00 00 00    	je     80103f8c <fork+0x19c>
80103efb:	83 ec 04             	sub    $0x4,%esp
80103efe:	6a 02                	push   $0x2
80103f00:	68 f5 80 10 80       	push   $0x801080f5
80103f05:	56                   	push   %esi
80103f06:	e8 25 0c 00 00       	call   80104b30 <strncmp>
80103f0b:	83 c4 10             	add    $0x10,%esp
80103f0e:	85 c0                	test   %eax,%eax
80103f10:	74 7a                	je     80103f8c <fork+0x19c>
    int offset = 0;
80103f12:	31 f6                	xor    %esi,%esi
80103f14:	8d bd e8 f7 ff ff    	lea    -0x818(%ebp),%edi
80103f1a:	89 9d e0 f7 ff ff    	mov    %ebx,-0x820(%ebp)
80103f20:	eb 22                	jmp    80103f44 <fork+0x154>
80103f22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(writeToSwapFile(np, buf, offset, nread) == -1){
80103f28:	53                   	push   %ebx
80103f29:	56                   	push   %esi
80103f2a:	57                   	push   %edi
80103f2b:	ff b5 e4 f7 ff ff    	pushl  -0x81c(%ebp)
80103f31:	e8 9a e3 ff ff       	call   801022d0 <writeToSwapFile>
80103f36:	83 c4 10             	add    $0x10,%esp
80103f39:	83 f8 ff             	cmp    $0xffffffff,%eax
80103f3c:	0f 84 bb 00 00 00    	je     80103ffd <fork+0x20d>
        offset += nread;
80103f42:	01 de                	add    %ebx,%esi
      while ((nread = readFromSwapFile(curproc, buf, offset, PGSIZE / 2)) != 0 )
80103f44:	68 00 08 00 00       	push   $0x800
80103f49:	56                   	push   %esi
80103f4a:	57                   	push   %edi
80103f4b:	ff b5 e0 f7 ff ff    	pushl  -0x820(%ebp)
80103f51:	e8 aa e3 ff ff       	call   80102300 <readFromSwapFile>
80103f56:	83 c4 10             	add    $0x10,%esp
80103f59:	85 c0                	test   %eax,%eax
80103f5b:	89 c3                	mov    %eax,%ebx
80103f5d:	75 c9                	jne    80103f28 <fork+0x138>
80103f5f:	8b 8d e4 f7 ff ff    	mov    -0x81c(%ebp),%ecx
80103f65:	8b 9d e0 f7 ff ff    	mov    -0x820(%ebp),%ebx
80103f6b:	89 c2                	mov    %eax,%edx
80103f6d:	8d 76 00             	lea    0x0(%esi),%esi
        np->swappedPGs[i].va = curproc->swappedPGs[i].va;
80103f70:	8b 84 93 8c 00 00 00 	mov    0x8c(%ebx,%edx,4),%eax
80103f77:	89 84 91 8c 00 00 00 	mov    %eax,0x8c(%ecx,%edx,4)
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80103f7e:	83 c2 01             	add    $0x1,%edx
80103f81:	83 fa 10             	cmp    $0x10,%edx
80103f84:	75 ea                	jne    80103f70 <fork+0x180>
80103f86:	89 8d e4 f7 ff ff    	mov    %ecx,-0x81c(%ebp)
  acquire(&ptable.lock);
80103f8c:	83 ec 0c             	sub    $0xc,%esp
80103f8f:	68 20 3d 11 80       	push   $0x80113d20
80103f94:	e8 67 09 00 00       	call   80104900 <acquire>
  np->state = RUNNABLE;
80103f99:	8b 85 e4 f7 ff ff    	mov    -0x81c(%ebp),%eax
80103f9f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
80103fa6:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80103fad:	e8 0e 0a 00 00       	call   801049c0 <release>
  return pid;
80103fb2:	83 c4 10             	add    $0x10,%esp
}
80103fb5:	8b 85 dc f7 ff ff    	mov    -0x824(%ebp),%eax
80103fbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fbe:	5b                   	pop    %ebx
80103fbf:	5e                   	pop    %esi
80103fc0:	5f                   	pop    %edi
80103fc1:	5d                   	pop    %ebp
80103fc2:	c3                   	ret    
    return -1;
80103fc3:	c7 85 dc f7 ff ff ff 	movl   $0xffffffff,-0x824(%ebp)
80103fca:	ff ff ff 
80103fcd:	eb e6                	jmp    80103fb5 <fork+0x1c5>
    kfree(np->kstack);
80103fcf:	8b 9d e4 f7 ff ff    	mov    -0x81c(%ebp),%ebx
80103fd5:	83 ec 0c             	sub    $0xc,%esp
80103fd8:	ff 73 08             	pushl  0x8(%ebx)
80103fdb:	e8 40 e7 ff ff       	call   80102720 <kfree>
    np->kstack = 0;
80103fe0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103fe7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103fee:	83 c4 10             	add    $0x10,%esp
80103ff1:	c7 85 dc f7 ff ff ff 	movl   $0xffffffff,-0x824(%ebp)
80103ff8:	ff ff ff 
80103ffb:	eb b8                	jmp    80103fb5 <fork+0x1c5>
          panic("fork: writing to childs swap file");
80103ffd:	83 ec 0c             	sub    $0xc,%esp
80104000:	68 e4 81 10 80       	push   $0x801081e4
80104005:	e8 86 c3 ff ff       	call   80100390 <panic>
8010400a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104010 <scheduler>:
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	57                   	push   %edi
80104014:	56                   	push   %esi
80104015:	53                   	push   %ebx
80104016:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104019:	e8 92 fb ff ff       	call   80103bb0 <mycpu>
8010401e:	8d 78 04             	lea    0x4(%eax),%edi
80104021:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104023:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010402a:	00 00 00 
8010402d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104030:	fb                   	sti    
    acquire(&ptable.lock);
80104031:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104034:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
    acquire(&ptable.lock);
80104039:	68 20 3d 11 80       	push   $0x80113d20
8010403e:	e8 bd 08 00 00       	call   80104900 <acquire>
80104043:	83 c4 10             	add    $0x10,%esp
80104046:	8d 76 00             	lea    0x0(%esi),%esi
80104049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80104050:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104054:	75 33                	jne    80104089 <scheduler+0x79>
      switchuvm(p);
80104056:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104059:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010405f:	53                   	push   %ebx
80104060:	e8 1b 2d 00 00       	call   80106d80 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104065:	58                   	pop    %eax
80104066:	5a                   	pop    %edx
80104067:	ff 73 1c             	pushl  0x1c(%ebx)
8010406a:	57                   	push   %edi
      p->state = RUNNING;
8010406b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104072:	e8 d4 0b 00 00       	call   80104c4b <swtch>
      switchkvm();
80104077:	e8 e4 2c 00 00       	call   80106d60 <switchkvm>
      c->proc = 0;
8010407c:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104083:	00 00 00 
80104086:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104089:	81 c3 8c 01 00 00    	add    $0x18c,%ebx
8010408f:	81 fb 54 a0 11 80    	cmp    $0x8011a054,%ebx
80104095:	72 b9                	jb     80104050 <scheduler+0x40>
    release(&ptable.lock);
80104097:	83 ec 0c             	sub    $0xc,%esp
8010409a:	68 20 3d 11 80       	push   $0x80113d20
8010409f:	e8 1c 09 00 00       	call   801049c0 <release>
    sti();
801040a4:	83 c4 10             	add    $0x10,%esp
801040a7:	eb 87                	jmp    80104030 <scheduler+0x20>
801040a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040b0 <sched>:
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	56                   	push   %esi
801040b4:	53                   	push   %ebx
  pushcli();
801040b5:	e8 76 07 00 00       	call   80104830 <pushcli>
  c = mycpu();
801040ba:	e8 f1 fa ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
801040bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040c5:	e8 a6 07 00 00       	call   80104870 <popcli>
  if(!holding(&ptable.lock))
801040ca:	83 ec 0c             	sub    $0xc,%esp
801040cd:	68 20 3d 11 80       	push   $0x80113d20
801040d2:	e8 f9 07 00 00       	call   801048d0 <holding>
801040d7:	83 c4 10             	add    $0x10,%esp
801040da:	85 c0                	test   %eax,%eax
801040dc:	74 4f                	je     8010412d <sched+0x7d>
  if(mycpu()->ncli != 1)
801040de:	e8 cd fa ff ff       	call   80103bb0 <mycpu>
801040e3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801040ea:	75 68                	jne    80104154 <sched+0xa4>
  if(p->state == RUNNING)
801040ec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801040f0:	74 55                	je     80104147 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040f2:	9c                   	pushf  
801040f3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801040f4:	f6 c4 02             	test   $0x2,%ah
801040f7:	75 41                	jne    8010413a <sched+0x8a>
  intena = mycpu()->intena;
801040f9:	e8 b2 fa ff ff       	call   80103bb0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801040fe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104101:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104107:	e8 a4 fa ff ff       	call   80103bb0 <mycpu>
8010410c:	83 ec 08             	sub    $0x8,%esp
8010410f:	ff 70 04             	pushl  0x4(%eax)
80104112:	53                   	push   %ebx
80104113:	e8 33 0b 00 00       	call   80104c4b <swtch>
  mycpu()->intena = intena;
80104118:	e8 93 fa ff ff       	call   80103bb0 <mycpu>
}
8010411d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104120:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104126:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104129:	5b                   	pop    %ebx
8010412a:	5e                   	pop    %esi
8010412b:	5d                   	pop    %ebp
8010412c:	c3                   	ret    
    panic("sched ptable.lock");
8010412d:	83 ec 0c             	sub    $0xc,%esp
80104130:	68 f8 80 10 80       	push   $0x801080f8
80104135:	e8 56 c2 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	68 24 81 10 80       	push   $0x80108124
80104142:	e8 49 c2 ff ff       	call   80100390 <panic>
    panic("sched running");
80104147:	83 ec 0c             	sub    $0xc,%esp
8010414a:	68 16 81 10 80       	push   $0x80108116
8010414f:	e8 3c c2 ff ff       	call   80100390 <panic>
    panic("sched locks");
80104154:	83 ec 0c             	sub    $0xc,%esp
80104157:	68 0a 81 10 80       	push   $0x8010810a
8010415c:	e8 2f c2 ff ff       	call   80100390 <panic>
80104161:	eb 0d                	jmp    80104170 <exit>
80104163:	90                   	nop
80104164:	90                   	nop
80104165:	90                   	nop
80104166:	90                   	nop
80104167:	90                   	nop
80104168:	90                   	nop
80104169:	90                   	nop
8010416a:	90                   	nop
8010416b:	90                   	nop
8010416c:	90                   	nop
8010416d:	90                   	nop
8010416e:	90                   	nop
8010416f:	90                   	nop

80104170 <exit>:
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	57                   	push   %edi
80104174:	56                   	push   %esi
80104175:	53                   	push   %ebx
80104176:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104179:	e8 b2 06 00 00       	call   80104830 <pushcli>
  c = mycpu();
8010417e:	e8 2d fa ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
80104183:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104189:	e8 e2 06 00 00       	call   80104870 <popcli>
  if(curproc == initproc)
8010418e:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
80104194:	8d 5e 28             	lea    0x28(%esi),%ebx
80104197:	8d 7e 68             	lea    0x68(%esi),%edi
8010419a:	0f 84 1e 01 00 00    	je     801042be <exit+0x14e>
    if(curproc->ofile[fd]){
801041a0:	8b 03                	mov    (%ebx),%eax
801041a2:	85 c0                	test   %eax,%eax
801041a4:	74 12                	je     801041b8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801041a6:	83 ec 0c             	sub    $0xc,%esp
801041a9:	50                   	push   %eax
801041aa:	e8 11 cd ff ff       	call   80100ec0 <fileclose>
      curproc->ofile[fd] = 0;
801041af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801041b5:	83 c4 10             	add    $0x10,%esp
801041b8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801041bb:	39 fb                	cmp    %edi,%ebx
801041bd:	75 e1                	jne    801041a0 <exit+0x30>
  if(removeSwapFile(curproc) != 0){
801041bf:	83 ec 0c             	sub    $0xc,%esp
801041c2:	56                   	push   %esi
801041c3:	e8 68 de ff ff       	call   80102030 <removeSwapFile>
801041c8:	83 c4 10             	add    $0x10,%esp
801041cb:	85 c0                	test   %eax,%eax
801041cd:	0f 85 c5 00 00 00    	jne    80104298 <exit+0x128>
  begin_op();
801041d3:	e8 d8 ed ff ff       	call   80102fb0 <begin_op>
  iput(curproc->cwd);
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	ff 76 68             	pushl  0x68(%esi)
801041de:	e8 4d d6 ff ff       	call   80101830 <iput>
  end_op();
801041e3:	e8 38 ee ff ff       	call   80103020 <end_op>
  curproc->cwd = 0;
801041e8:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801041ef:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
801041f6:	e8 05 07 00 00       	call   80104900 <acquire>
  wakeup1(curproc->parent);
801041fb:	8b 56 14             	mov    0x14(%esi),%edx
801041fe:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104201:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
80104206:	eb 14                	jmp    8010421c <exit+0xac>
80104208:	90                   	nop
80104209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104210:	05 8c 01 00 00       	add    $0x18c,%eax
80104215:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
8010421a:	73 1e                	jae    8010423a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010421c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104220:	75 ee                	jne    80104210 <exit+0xa0>
80104222:	3b 50 20             	cmp    0x20(%eax),%edx
80104225:	75 e9                	jne    80104210 <exit+0xa0>
      p->state = RUNNABLE;
80104227:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010422e:	05 8c 01 00 00       	add    $0x18c,%eax
80104233:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
80104238:	72 e2                	jb     8010421c <exit+0xac>
      p->parent = initproc;
8010423a:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104240:	ba 54 3d 11 80       	mov    $0x80113d54,%edx
80104245:	eb 17                	jmp    8010425e <exit+0xee>
80104247:	89 f6                	mov    %esi,%esi
80104249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104250:	81 c2 8c 01 00 00    	add    $0x18c,%edx
80104256:	81 fa 54 a0 11 80    	cmp    $0x8011a054,%edx
8010425c:	73 47                	jae    801042a5 <exit+0x135>
    if(p->parent == curproc){
8010425e:	39 72 14             	cmp    %esi,0x14(%edx)
80104261:	75 ed                	jne    80104250 <exit+0xe0>
      if(p->state == ZOMBIE)
80104263:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104267:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010426a:	75 e4                	jne    80104250 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010426c:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
80104271:	eb 11                	jmp    80104284 <exit+0x114>
80104273:	90                   	nop
80104274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104278:	05 8c 01 00 00       	add    $0x18c,%eax
8010427d:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
80104282:	73 cc                	jae    80104250 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
80104284:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104288:	75 ee                	jne    80104278 <exit+0x108>
8010428a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010428d:	75 e9                	jne    80104278 <exit+0x108>
      p->state = RUNNABLE;
8010428f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104296:	eb e0                	jmp    80104278 <exit+0x108>
    panic("exit: cant remove swapfile");
80104298:	83 ec 0c             	sub    $0xc,%esp
8010429b:	68 45 81 10 80       	push   $0x80108145
801042a0:	e8 eb c0 ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
801042a5:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801042ac:	e8 ff fd ff ff       	call   801040b0 <sched>
  panic("zombie exit");
801042b1:	83 ec 0c             	sub    $0xc,%esp
801042b4:	68 60 81 10 80       	push   $0x80108160
801042b9:	e8 d2 c0 ff ff       	call   80100390 <panic>
    panic("init exiting");
801042be:	83 ec 0c             	sub    $0xc,%esp
801042c1:	68 38 81 10 80       	push   $0x80108138
801042c6:	e8 c5 c0 ff ff       	call   80100390 <panic>
801042cb:	90                   	nop
801042cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042d0 <yield>:
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801042d7:	68 20 3d 11 80       	push   $0x80113d20
801042dc:	e8 1f 06 00 00       	call   80104900 <acquire>
  pushcli();
801042e1:	e8 4a 05 00 00       	call   80104830 <pushcli>
  c = mycpu();
801042e6:	e8 c5 f8 ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
801042eb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042f1:	e8 7a 05 00 00       	call   80104870 <popcli>
  myproc()->state = RUNNABLE;
801042f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801042fd:	e8 ae fd ff ff       	call   801040b0 <sched>
  release(&ptable.lock);
80104302:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
80104309:	e8 b2 06 00 00       	call   801049c0 <release>
}
8010430e:	83 c4 10             	add    $0x10,%esp
80104311:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104314:	c9                   	leave  
80104315:	c3                   	ret    
80104316:	8d 76 00             	lea    0x0(%esi),%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104320 <sleep>:
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	57                   	push   %edi
80104324:	56                   	push   %esi
80104325:	53                   	push   %ebx
80104326:	83 ec 0c             	sub    $0xc,%esp
80104329:	8b 7d 08             	mov    0x8(%ebp),%edi
8010432c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010432f:	e8 fc 04 00 00       	call   80104830 <pushcli>
  c = mycpu();
80104334:	e8 77 f8 ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
80104339:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010433f:	e8 2c 05 00 00       	call   80104870 <popcli>
  if(p == 0)
80104344:	85 db                	test   %ebx,%ebx
80104346:	0f 84 87 00 00 00    	je     801043d3 <sleep+0xb3>
  if(lk == 0)
8010434c:	85 f6                	test   %esi,%esi
8010434e:	74 76                	je     801043c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104350:	81 fe 20 3d 11 80    	cmp    $0x80113d20,%esi
80104356:	74 50                	je     801043a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104358:	83 ec 0c             	sub    $0xc,%esp
8010435b:	68 20 3d 11 80       	push   $0x80113d20
80104360:	e8 9b 05 00 00       	call   80104900 <acquire>
    release(lk);
80104365:	89 34 24             	mov    %esi,(%esp)
80104368:	e8 53 06 00 00       	call   801049c0 <release>
  p->chan = chan;
8010436d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104370:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104377:	e8 34 fd ff ff       	call   801040b0 <sched>
  p->chan = 0;
8010437c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104383:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
8010438a:	e8 31 06 00 00       	call   801049c0 <release>
    acquire(lk);
8010438f:	89 75 08             	mov    %esi,0x8(%ebp)
80104392:	83 c4 10             	add    $0x10,%esp
}
80104395:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104398:	5b                   	pop    %ebx
80104399:	5e                   	pop    %esi
8010439a:	5f                   	pop    %edi
8010439b:	5d                   	pop    %ebp
    acquire(lk);
8010439c:	e9 5f 05 00 00       	jmp    80104900 <acquire>
801043a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801043a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801043ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801043b2:	e8 f9 fc ff ff       	call   801040b0 <sched>
  p->chan = 0;
801043b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801043be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043c1:	5b                   	pop    %ebx
801043c2:	5e                   	pop    %esi
801043c3:	5f                   	pop    %edi
801043c4:	5d                   	pop    %ebp
801043c5:	c3                   	ret    
    panic("sleep without lk");
801043c6:	83 ec 0c             	sub    $0xc,%esp
801043c9:	68 72 81 10 80       	push   $0x80108172
801043ce:	e8 bd bf ff ff       	call   80100390 <panic>
    panic("sleep");
801043d3:	83 ec 0c             	sub    $0xc,%esp
801043d6:	68 6c 81 10 80       	push   $0x8010816c
801043db:	e8 b0 bf ff ff       	call   80100390 <panic>

801043e0 <wait>:
{
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	56                   	push   %esi
801043e4:	53                   	push   %ebx
  pushcli();
801043e5:	e8 46 04 00 00       	call   80104830 <pushcli>
  c = mycpu();
801043ea:	e8 c1 f7 ff ff       	call   80103bb0 <mycpu>
  p = c->proc;
801043ef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043f5:	e8 76 04 00 00       	call   80104870 <popcli>
  acquire(&ptable.lock);
801043fa:	83 ec 0c             	sub    $0xc,%esp
801043fd:	68 20 3d 11 80       	push   $0x80113d20
80104402:	e8 f9 04 00 00       	call   80104900 <acquire>
80104407:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010440a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010440c:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
80104411:	eb 13                	jmp    80104426 <wait+0x46>
80104413:	90                   	nop
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	81 c3 8c 01 00 00    	add    $0x18c,%ebx
8010441e:	81 fb 54 a0 11 80    	cmp    $0x8011a054,%ebx
80104424:	73 1e                	jae    80104444 <wait+0x64>
      if(p->parent != curproc)
80104426:	39 73 14             	cmp    %esi,0x14(%ebx)
80104429:	75 ed                	jne    80104418 <wait+0x38>
      if(p->state == ZOMBIE){
8010442b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010442f:	74 37                	je     80104468 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104431:	81 c3 8c 01 00 00    	add    $0x18c,%ebx
      havekids = 1;
80104437:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010443c:	81 fb 54 a0 11 80    	cmp    $0x8011a054,%ebx
80104442:	72 e2                	jb     80104426 <wait+0x46>
    if(!havekids || curproc->killed){
80104444:	85 c0                	test   %eax,%eax
80104446:	74 76                	je     801044be <wait+0xde>
80104448:	8b 46 24             	mov    0x24(%esi),%eax
8010444b:	85 c0                	test   %eax,%eax
8010444d:	75 6f                	jne    801044be <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010444f:	83 ec 08             	sub    $0x8,%esp
80104452:	68 20 3d 11 80       	push   $0x80113d20
80104457:	56                   	push   %esi
80104458:	e8 c3 fe ff ff       	call   80104320 <sleep>
    havekids = 0;
8010445d:	83 c4 10             	add    $0x10,%esp
80104460:	eb a8                	jmp    8010440a <wait+0x2a>
80104462:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104468:	83 ec 0c             	sub    $0xc,%esp
8010446b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010446e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104471:	e8 aa e2 ff ff       	call   80102720 <kfree>
        freevm(p->pgdir);
80104476:	5a                   	pop    %edx
80104477:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010447a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104481:	e8 6a 2d 00 00       	call   801071f0 <freevm>
        release(&ptable.lock);
80104486:	c7 04 24 20 3d 11 80 	movl   $0x80113d20,(%esp)
        p->pid = 0;
8010448d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104494:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010449b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
8010449f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801044a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801044ad:	e8 0e 05 00 00       	call   801049c0 <release>
        return pid;
801044b2:	83 c4 10             	add    $0x10,%esp
}
801044b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044b8:	89 f0                	mov    %esi,%eax
801044ba:	5b                   	pop    %ebx
801044bb:	5e                   	pop    %esi
801044bc:	5d                   	pop    %ebp
801044bd:	c3                   	ret    
      release(&ptable.lock);
801044be:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801044c1:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801044c6:	68 20 3d 11 80       	push   $0x80113d20
801044cb:	e8 f0 04 00 00       	call   801049c0 <release>
      return -1;
801044d0:	83 c4 10             	add    $0x10,%esp
801044d3:	eb e0                	jmp    801044b5 <wait+0xd5>
801044d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	53                   	push   %ebx
801044e4:	83 ec 10             	sub    $0x10,%esp
801044e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801044ea:	68 20 3d 11 80       	push   $0x80113d20
801044ef:	e8 0c 04 00 00       	call   80104900 <acquire>
801044f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044f7:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
801044fc:	eb 0e                	jmp    8010450c <wakeup+0x2c>
801044fe:	66 90                	xchg   %ax,%ax
80104500:	05 8c 01 00 00       	add    $0x18c,%eax
80104505:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
8010450a:	73 1e                	jae    8010452a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010450c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104510:	75 ee                	jne    80104500 <wakeup+0x20>
80104512:	3b 58 20             	cmp    0x20(%eax),%ebx
80104515:	75 e9                	jne    80104500 <wakeup+0x20>
      p->state = RUNNABLE;
80104517:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010451e:	05 8c 01 00 00       	add    $0x18c,%eax
80104523:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
80104528:	72 e2                	jb     8010450c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010452a:	c7 45 08 20 3d 11 80 	movl   $0x80113d20,0x8(%ebp)
}
80104531:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104534:	c9                   	leave  
  release(&ptable.lock);
80104535:	e9 86 04 00 00       	jmp    801049c0 <release>
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 10             	sub    $0x10,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010454a:	68 20 3d 11 80       	push   $0x80113d20
8010454f:	e8 ac 03 00 00       	call   80104900 <acquire>
80104554:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104557:	b8 54 3d 11 80       	mov    $0x80113d54,%eax
8010455c:	eb 0e                	jmp    8010456c <kill+0x2c>
8010455e:	66 90                	xchg   %ax,%ax
80104560:	05 8c 01 00 00       	add    $0x18c,%eax
80104565:	3d 54 a0 11 80       	cmp    $0x8011a054,%eax
8010456a:	73 34                	jae    801045a0 <kill+0x60>
    if(p->pid == pid){
8010456c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010456f:	75 ef                	jne    80104560 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104571:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104575:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010457c:	75 07                	jne    80104585 <kill+0x45>
        p->state = RUNNABLE;
8010457e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104585:	83 ec 0c             	sub    $0xc,%esp
80104588:	68 20 3d 11 80       	push   $0x80113d20
8010458d:	e8 2e 04 00 00       	call   801049c0 <release>
      return 0;
80104592:	83 c4 10             	add    $0x10,%esp
80104595:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104597:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010459a:	c9                   	leave  
8010459b:	c3                   	ret    
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 20 3d 11 80       	push   $0x80113d20
801045a8:	e8 13 04 00 00       	call   801049c0 <release>
  return -1;
801045ad:	83 c4 10             	add    $0x10,%esp
801045b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045b8:	c9                   	leave  
801045b9:	c3                   	ret    
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c9:	bb 54 3d 11 80       	mov    $0x80113d54,%ebx
{
801045ce:	83 ec 3c             	sub    $0x3c,%esp
801045d1:	eb 27                	jmp    801045fa <procdump+0x3a>
801045d3:	90                   	nop
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	68 51 86 10 80       	push   $0x80108651
801045e0:	e8 7b c0 ff ff       	call   80100660 <cprintf>
801045e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e8:	81 c3 8c 01 00 00    	add    $0x18c,%ebx
801045ee:	81 fb 54 a0 11 80    	cmp    $0x8011a054,%ebx
801045f4:	0f 83 86 00 00 00    	jae    80104680 <procdump+0xc0>
    if(p->state == UNUSED)
801045fa:	8b 43 0c             	mov    0xc(%ebx),%eax
801045fd:	85 c0                	test   %eax,%eax
801045ff:	74 e7                	je     801045e8 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104601:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104604:	ba 83 81 10 80       	mov    $0x80108183,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104609:	77 11                	ja     8010461c <procdump+0x5c>
8010460b:	8b 14 85 08 82 10 80 	mov    -0x7fef7df8(,%eax,4),%edx
      state = "???";
80104612:	b8 83 81 10 80       	mov    $0x80108183,%eax
80104617:	85 d2                	test   %edx,%edx
80104619:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010461c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010461f:	50                   	push   %eax
80104620:	52                   	push   %edx
80104621:	ff 73 10             	pushl  0x10(%ebx)
80104624:	68 87 81 10 80       	push   $0x80108187
80104629:	e8 32 c0 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010462e:	83 c4 10             	add    $0x10,%esp
80104631:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104635:	75 a1                	jne    801045d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104637:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010463a:	83 ec 08             	sub    $0x8,%esp
8010463d:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104640:	50                   	push   %eax
80104641:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104644:	8b 40 0c             	mov    0xc(%eax),%eax
80104647:	83 c0 08             	add    $0x8,%eax
8010464a:	50                   	push   %eax
8010464b:	e8 90 01 00 00       	call   801047e0 <getcallerpcs>
80104650:	83 c4 10             	add    $0x10,%esp
80104653:	90                   	nop
80104654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104658:	8b 17                	mov    (%edi),%edx
8010465a:	85 d2                	test   %edx,%edx
8010465c:	0f 84 76 ff ff ff    	je     801045d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104662:	83 ec 08             	sub    $0x8,%esp
80104665:	83 c7 04             	add    $0x4,%edi
80104668:	52                   	push   %edx
80104669:	68 61 7b 10 80       	push   $0x80107b61
8010466e:	e8 ed bf ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104673:	83 c4 10             	add    $0x10,%esp
80104676:	39 fe                	cmp    %edi,%esi
80104678:	75 de                	jne    80104658 <procdump+0x98>
8010467a:	e9 59 ff ff ff       	jmp    801045d8 <procdump+0x18>
8010467f:	90                   	nop
  }
}
80104680:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104683:	5b                   	pop    %ebx
80104684:	5e                   	pop    %esi
80104685:	5f                   	pop    %edi
80104686:	5d                   	pop    %ebp
80104687:	c3                   	ret    
80104688:	66 90                	xchg   %ax,%ax
8010468a:	66 90                	xchg   %ax,%ax
8010468c:	66 90                	xchg   %ax,%ax
8010468e:	66 90                	xchg   %ax,%ax

80104690 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 0c             	sub    $0xc,%esp
80104697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010469a:	68 20 82 10 80       	push   $0x80108220
8010469f:	8d 43 04             	lea    0x4(%ebx),%eax
801046a2:	50                   	push   %eax
801046a3:	e8 18 01 00 00       	call   801047c0 <initlock>
  lk->name = name;
801046a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801046ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801046b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801046b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801046bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801046be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046c1:	c9                   	leave  
801046c2:	c3                   	ret    
801046c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046d8:	83 ec 0c             	sub    $0xc,%esp
801046db:	8d 73 04             	lea    0x4(%ebx),%esi
801046de:	56                   	push   %esi
801046df:	e8 1c 02 00 00       	call   80104900 <acquire>
  while (lk->locked) {
801046e4:	8b 13                	mov    (%ebx),%edx
801046e6:	83 c4 10             	add    $0x10,%esp
801046e9:	85 d2                	test   %edx,%edx
801046eb:	74 16                	je     80104703 <acquiresleep+0x33>
801046ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801046f0:	83 ec 08             	sub    $0x8,%esp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
801046f5:	e8 26 fc ff ff       	call   80104320 <sleep>
  while (lk->locked) {
801046fa:	8b 03                	mov    (%ebx),%eax
801046fc:	83 c4 10             	add    $0x10,%esp
801046ff:	85 c0                	test   %eax,%eax
80104701:	75 ed                	jne    801046f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104703:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104709:	e8 42 f5 ff ff       	call   80103c50 <myproc>
8010470e:	8b 40 10             	mov    0x10(%eax),%eax
80104711:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104714:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104717:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010471a:	5b                   	pop    %ebx
8010471b:	5e                   	pop    %esi
8010471c:	5d                   	pop    %ebp
  release(&lk->lk);
8010471d:	e9 9e 02 00 00       	jmp    801049c0 <release>
80104722:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104730 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	8d 73 04             	lea    0x4(%ebx),%esi
8010473e:	56                   	push   %esi
8010473f:	e8 bc 01 00 00       	call   80104900 <acquire>
  lk->locked = 0;
80104744:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010474a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104751:	89 1c 24             	mov    %ebx,(%esp)
80104754:	e8 87 fd ff ff       	call   801044e0 <wakeup>
  release(&lk->lk);
80104759:	89 75 08             	mov    %esi,0x8(%ebp)
8010475c:	83 c4 10             	add    $0x10,%esp
}
8010475f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104762:	5b                   	pop    %ebx
80104763:	5e                   	pop    %esi
80104764:	5d                   	pop    %ebp
  release(&lk->lk);
80104765:	e9 56 02 00 00       	jmp    801049c0 <release>
8010476a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104770 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	56                   	push   %esi
80104775:	53                   	push   %ebx
80104776:	31 ff                	xor    %edi,%edi
80104778:	83 ec 18             	sub    $0x18,%esp
8010477b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010477e:	8d 73 04             	lea    0x4(%ebx),%esi
80104781:	56                   	push   %esi
80104782:	e8 79 01 00 00       	call   80104900 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104787:	8b 03                	mov    (%ebx),%eax
80104789:	83 c4 10             	add    $0x10,%esp
8010478c:	85 c0                	test   %eax,%eax
8010478e:	74 13                	je     801047a3 <holdingsleep+0x33>
80104790:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104793:	e8 b8 f4 ff ff       	call   80103c50 <myproc>
80104798:	39 58 10             	cmp    %ebx,0x10(%eax)
8010479b:	0f 94 c0             	sete   %al
8010479e:	0f b6 c0             	movzbl %al,%eax
801047a1:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801047a3:	83 ec 0c             	sub    $0xc,%esp
801047a6:	56                   	push   %esi
801047a7:	e8 14 02 00 00       	call   801049c0 <release>
  return r;
}
801047ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047af:	89 f8                	mov    %edi,%eax
801047b1:	5b                   	pop    %ebx
801047b2:	5e                   	pop    %esi
801047b3:	5f                   	pop    %edi
801047b4:	5d                   	pop    %ebp
801047b5:	c3                   	ret    
801047b6:	66 90                	xchg   %ax,%ax
801047b8:	66 90                	xchg   %ax,%ax
801047ba:	66 90                	xchg   %ax,%ax
801047bc:	66 90                	xchg   %ax,%ax
801047be:	66 90                	xchg   %ax,%ax

801047c0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801047c6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801047c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801047cf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801047d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801047d9:	5d                   	pop    %ebp
801047da:	c3                   	ret    
801047db:	90                   	nop
801047dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047e0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801047e0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047e1:	31 d2                	xor    %edx,%edx
{
801047e3:	89 e5                	mov    %esp,%ebp
801047e5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801047e6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801047e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801047ec:	83 e8 08             	sub    $0x8,%eax
801047ef:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047f0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047f6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047fc:	77 1a                	ja     80104818 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801047fe:	8b 58 04             	mov    0x4(%eax),%ebx
80104801:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104804:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104807:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104809:	83 fa 0a             	cmp    $0xa,%edx
8010480c:	75 e2                	jne    801047f0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010480e:	5b                   	pop    %ebx
8010480f:	5d                   	pop    %ebp
80104810:	c3                   	ret    
80104811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104818:	8d 04 91             	lea    (%ecx,%edx,4),%eax
8010481b:	83 c1 28             	add    $0x28,%ecx
8010481e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104820:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104826:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104829:	39 c1                	cmp    %eax,%ecx
8010482b:	75 f3                	jne    80104820 <getcallerpcs+0x40>
}
8010482d:	5b                   	pop    %ebx
8010482e:	5d                   	pop    %ebp
8010482f:	c3                   	ret    

80104830 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 04             	sub    $0x4,%esp
80104837:	9c                   	pushf  
80104838:	5b                   	pop    %ebx
  asm volatile("cli");
80104839:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010483a:	e8 71 f3 ff ff       	call   80103bb0 <mycpu>
8010483f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104845:	85 c0                	test   %eax,%eax
80104847:	75 11                	jne    8010485a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104849:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010484f:	e8 5c f3 ff ff       	call   80103bb0 <mycpu>
80104854:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010485a:	e8 51 f3 ff ff       	call   80103bb0 <mycpu>
8010485f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104866:	83 c4 04             	add    $0x4,%esp
80104869:	5b                   	pop    %ebx
8010486a:	5d                   	pop    %ebp
8010486b:	c3                   	ret    
8010486c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104870 <popcli>:

void
popcli(void)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104876:	9c                   	pushf  
80104877:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104878:	f6 c4 02             	test   $0x2,%ah
8010487b:	75 35                	jne    801048b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010487d:	e8 2e f3 ff ff       	call   80103bb0 <mycpu>
80104882:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104889:	78 34                	js     801048bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010488b:	e8 20 f3 ff ff       	call   80103bb0 <mycpu>
80104890:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104896:	85 d2                	test   %edx,%edx
80104898:	74 06                	je     801048a0 <popcli+0x30>
    sti();
}
8010489a:	c9                   	leave  
8010489b:	c3                   	ret    
8010489c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801048a0:	e8 0b f3 ff ff       	call   80103bb0 <mycpu>
801048a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801048ab:	85 c0                	test   %eax,%eax
801048ad:	74 eb                	je     8010489a <popcli+0x2a>
  asm volatile("sti");
801048af:	fb                   	sti    
}
801048b0:	c9                   	leave  
801048b1:	c3                   	ret    
    panic("popcli - interruptible");
801048b2:	83 ec 0c             	sub    $0xc,%esp
801048b5:	68 2b 82 10 80       	push   $0x8010822b
801048ba:	e8 d1 ba ff ff       	call   80100390 <panic>
    panic("popcli");
801048bf:	83 ec 0c             	sub    $0xc,%esp
801048c2:	68 42 82 10 80       	push   $0x80108242
801048c7:	e8 c4 ba ff ff       	call   80100390 <panic>
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048d0 <holding>:
{
801048d0:	55                   	push   %ebp
801048d1:	89 e5                	mov    %esp,%ebp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	8b 75 08             	mov    0x8(%ebp),%esi
801048d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801048da:	e8 51 ff ff ff       	call   80104830 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048df:	8b 06                	mov    (%esi),%eax
801048e1:	85 c0                	test   %eax,%eax
801048e3:	74 10                	je     801048f5 <holding+0x25>
801048e5:	8b 5e 08             	mov    0x8(%esi),%ebx
801048e8:	e8 c3 f2 ff ff       	call   80103bb0 <mycpu>
801048ed:	39 c3                	cmp    %eax,%ebx
801048ef:	0f 94 c3             	sete   %bl
801048f2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801048f5:	e8 76 ff ff ff       	call   80104870 <popcli>
}
801048fa:	89 d8                	mov    %ebx,%eax
801048fc:	5b                   	pop    %ebx
801048fd:	5e                   	pop    %esi
801048fe:	5d                   	pop    %ebp
801048ff:	c3                   	ret    

80104900 <acquire>:
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	56                   	push   %esi
80104904:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104905:	e8 26 ff ff ff       	call   80104830 <pushcli>
  if(holding(lk))
8010490a:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010490d:	83 ec 0c             	sub    $0xc,%esp
80104910:	53                   	push   %ebx
80104911:	e8 ba ff ff ff       	call   801048d0 <holding>
80104916:	83 c4 10             	add    $0x10,%esp
80104919:	85 c0                	test   %eax,%eax
8010491b:	0f 85 83 00 00 00    	jne    801049a4 <acquire+0xa4>
80104921:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104923:	ba 01 00 00 00       	mov    $0x1,%edx
80104928:	eb 09                	jmp    80104933 <acquire+0x33>
8010492a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104930:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104933:	89 d0                	mov    %edx,%eax
80104935:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104938:	85 c0                	test   %eax,%eax
8010493a:	75 f4                	jne    80104930 <acquire+0x30>
  __sync_synchronize();
8010493c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104941:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104944:	e8 67 f2 ff ff       	call   80103bb0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104949:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010494c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010494f:	89 e8                	mov    %ebp,%eax
80104951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104958:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010495e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104964:	77 1a                	ja     80104980 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104966:	8b 48 04             	mov    0x4(%eax),%ecx
80104969:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010496c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010496f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104971:	83 fe 0a             	cmp    $0xa,%esi
80104974:	75 e2                	jne    80104958 <acquire+0x58>
}
80104976:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104979:	5b                   	pop    %ebx
8010497a:	5e                   	pop    %esi
8010497b:	5d                   	pop    %ebp
8010497c:	c3                   	ret    
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
80104980:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104983:	83 c2 28             	add    $0x28,%edx
80104986:	8d 76 00             	lea    0x0(%esi),%esi
80104989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104990:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104996:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104999:	39 d0                	cmp    %edx,%eax
8010499b:	75 f3                	jne    80104990 <acquire+0x90>
}
8010499d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049a0:	5b                   	pop    %ebx
801049a1:	5e                   	pop    %esi
801049a2:	5d                   	pop    %ebp
801049a3:	c3                   	ret    
    panic("acquire");
801049a4:	83 ec 0c             	sub    $0xc,%esp
801049a7:	68 49 82 10 80       	push   $0x80108249
801049ac:	e8 df b9 ff ff       	call   80100390 <panic>
801049b1:	eb 0d                	jmp    801049c0 <release>
801049b3:	90                   	nop
801049b4:	90                   	nop
801049b5:	90                   	nop
801049b6:	90                   	nop
801049b7:	90                   	nop
801049b8:	90                   	nop
801049b9:	90                   	nop
801049ba:	90                   	nop
801049bb:	90                   	nop
801049bc:	90                   	nop
801049bd:	90                   	nop
801049be:	90                   	nop
801049bf:	90                   	nop

801049c0 <release>:
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	53                   	push   %ebx
801049c4:	83 ec 10             	sub    $0x10,%esp
801049c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801049ca:	53                   	push   %ebx
801049cb:	e8 00 ff ff ff       	call   801048d0 <holding>
801049d0:	83 c4 10             	add    $0x10,%esp
801049d3:	85 c0                	test   %eax,%eax
801049d5:	74 22                	je     801049f9 <release+0x39>
  lk->pcs[0] = 0;
801049d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801049de:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801049e5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801049ea:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801049f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f3:	c9                   	leave  
  popcli();
801049f4:	e9 77 fe ff ff       	jmp    80104870 <popcli>
    panic("release");
801049f9:	83 ec 0c             	sub    $0xc,%esp
801049fc:	68 51 82 10 80       	push   $0x80108251
80104a01:	e8 8a b9 ff ff       	call   80100390 <panic>
80104a06:	66 90                	xchg   %ax,%ax
80104a08:	66 90                	xchg   %ax,%ax
80104a0a:	66 90                	xchg   %ax,%ax
80104a0c:	66 90                	xchg   %ax,%ax
80104a0e:	66 90                	xchg   %ax,%ax

80104a10 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	57                   	push   %edi
80104a14:	53                   	push   %ebx
80104a15:	8b 55 08             	mov    0x8(%ebp),%edx
80104a18:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104a1b:	f6 c2 03             	test   $0x3,%dl
80104a1e:	75 05                	jne    80104a25 <memset+0x15>
80104a20:	f6 c1 03             	test   $0x3,%cl
80104a23:	74 13                	je     80104a38 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104a25:	89 d7                	mov    %edx,%edi
80104a27:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a2a:	fc                   	cld    
80104a2b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a2d:	5b                   	pop    %ebx
80104a2e:	89 d0                	mov    %edx,%eax
80104a30:	5f                   	pop    %edi
80104a31:	5d                   	pop    %ebp
80104a32:	c3                   	ret    
80104a33:	90                   	nop
80104a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104a38:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a3c:	c1 e9 02             	shr    $0x2,%ecx
80104a3f:	89 f8                	mov    %edi,%eax
80104a41:	89 fb                	mov    %edi,%ebx
80104a43:	c1 e0 18             	shl    $0x18,%eax
80104a46:	c1 e3 10             	shl    $0x10,%ebx
80104a49:	09 d8                	or     %ebx,%eax
80104a4b:	09 f8                	or     %edi,%eax
80104a4d:	c1 e7 08             	shl    $0x8,%edi
80104a50:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a52:	89 d7                	mov    %edx,%edi
80104a54:	fc                   	cld    
80104a55:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104a57:	5b                   	pop    %ebx
80104a58:	89 d0                	mov    %edx,%eax
80104a5a:	5f                   	pop    %edi
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret    
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi

80104a60 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	57                   	push   %edi
80104a64:	56                   	push   %esi
80104a65:	53                   	push   %ebx
80104a66:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a69:	8b 75 08             	mov    0x8(%ebp),%esi
80104a6c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a6f:	85 db                	test   %ebx,%ebx
80104a71:	74 29                	je     80104a9c <memcmp+0x3c>
    if(*s1 != *s2)
80104a73:	0f b6 16             	movzbl (%esi),%edx
80104a76:	0f b6 0f             	movzbl (%edi),%ecx
80104a79:	38 d1                	cmp    %dl,%cl
80104a7b:	75 2b                	jne    80104aa8 <memcmp+0x48>
80104a7d:	b8 01 00 00 00       	mov    $0x1,%eax
80104a82:	eb 14                	jmp    80104a98 <memcmp+0x38>
80104a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a88:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104a8c:	83 c0 01             	add    $0x1,%eax
80104a8f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104a94:	38 ca                	cmp    %cl,%dl
80104a96:	75 10                	jne    80104aa8 <memcmp+0x48>
  while(n-- > 0){
80104a98:	39 d8                	cmp    %ebx,%eax
80104a9a:	75 ec                	jne    80104a88 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104a9c:	5b                   	pop    %ebx
  return 0;
80104a9d:	31 c0                	xor    %eax,%eax
}
80104a9f:	5e                   	pop    %esi
80104aa0:	5f                   	pop    %edi
80104aa1:	5d                   	pop    %ebp
80104aa2:	c3                   	ret    
80104aa3:	90                   	nop
80104aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104aa8:	0f b6 c2             	movzbl %dl,%eax
}
80104aab:	5b                   	pop    %ebx
      return *s1 - *s2;
80104aac:	29 c8                	sub    %ecx,%eax
}
80104aae:	5e                   	pop    %esi
80104aaf:	5f                   	pop    %edi
80104ab0:	5d                   	pop    %ebp
80104ab1:	c3                   	ret    
80104ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ac0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	53                   	push   %ebx
80104ac5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ac8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104acb:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104ace:	39 c3                	cmp    %eax,%ebx
80104ad0:	73 26                	jae    80104af8 <memmove+0x38>
80104ad2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104ad5:	39 c8                	cmp    %ecx,%eax
80104ad7:	73 1f                	jae    80104af8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ad9:	85 f6                	test   %esi,%esi
80104adb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104ade:	74 0f                	je     80104aef <memmove+0x2f>
      *--d = *--s;
80104ae0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ae4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104ae7:	83 ea 01             	sub    $0x1,%edx
80104aea:	83 fa ff             	cmp    $0xffffffff,%edx
80104aed:	75 f1                	jne    80104ae0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104aef:	5b                   	pop    %ebx
80104af0:	5e                   	pop    %esi
80104af1:	5d                   	pop    %ebp
80104af2:	c3                   	ret    
80104af3:	90                   	nop
80104af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104af8:	31 d2                	xor    %edx,%edx
80104afa:	85 f6                	test   %esi,%esi
80104afc:	74 f1                	je     80104aef <memmove+0x2f>
80104afe:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104b00:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104b04:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104b07:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104b0a:	39 d6                	cmp    %edx,%esi
80104b0c:	75 f2                	jne    80104b00 <memmove+0x40>
}
80104b0e:	5b                   	pop    %ebx
80104b0f:	5e                   	pop    %esi
80104b10:	5d                   	pop    %ebp
80104b11:	c3                   	ret    
80104b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b20 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104b23:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104b24:	eb 9a                	jmp    80104ac0 <memmove>
80104b26:	8d 76 00             	lea    0x0(%esi),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	57                   	push   %edi
80104b34:	56                   	push   %esi
80104b35:	8b 7d 10             	mov    0x10(%ebp),%edi
80104b38:	53                   	push   %ebx
80104b39:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104b3f:	85 ff                	test   %edi,%edi
80104b41:	74 2f                	je     80104b72 <strncmp+0x42>
80104b43:	0f b6 01             	movzbl (%ecx),%eax
80104b46:	0f b6 1e             	movzbl (%esi),%ebx
80104b49:	84 c0                	test   %al,%al
80104b4b:	74 37                	je     80104b84 <strncmp+0x54>
80104b4d:	38 c3                	cmp    %al,%bl
80104b4f:	75 33                	jne    80104b84 <strncmp+0x54>
80104b51:	01 f7                	add    %esi,%edi
80104b53:	eb 13                	jmp    80104b68 <strncmp+0x38>
80104b55:	8d 76 00             	lea    0x0(%esi),%esi
80104b58:	0f b6 01             	movzbl (%ecx),%eax
80104b5b:	84 c0                	test   %al,%al
80104b5d:	74 21                	je     80104b80 <strncmp+0x50>
80104b5f:	0f b6 1a             	movzbl (%edx),%ebx
80104b62:	89 d6                	mov    %edx,%esi
80104b64:	38 d8                	cmp    %bl,%al
80104b66:	75 1c                	jne    80104b84 <strncmp+0x54>
    n--, p++, q++;
80104b68:	8d 56 01             	lea    0x1(%esi),%edx
80104b6b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b6e:	39 fa                	cmp    %edi,%edx
80104b70:	75 e6                	jne    80104b58 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104b72:	5b                   	pop    %ebx
    return 0;
80104b73:	31 c0                	xor    %eax,%eax
}
80104b75:	5e                   	pop    %esi
80104b76:	5f                   	pop    %edi
80104b77:	5d                   	pop    %ebp
80104b78:	c3                   	ret    
80104b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b80:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104b84:	29 d8                	sub    %ebx,%eax
}
80104b86:	5b                   	pop    %ebx
80104b87:	5e                   	pop    %esi
80104b88:	5f                   	pop    %edi
80104b89:	5d                   	pop    %ebp
80104b8a:	c3                   	ret    
80104b8b:	90                   	nop
80104b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b90 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	8b 45 08             	mov    0x8(%ebp),%eax
80104b98:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b9b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b9e:	89 c2                	mov    %eax,%edx
80104ba0:	eb 19                	jmp    80104bbb <strncpy+0x2b>
80104ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ba8:	83 c3 01             	add    $0x1,%ebx
80104bab:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104baf:	83 c2 01             	add    $0x1,%edx
80104bb2:	84 c9                	test   %cl,%cl
80104bb4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bb7:	74 09                	je     80104bc2 <strncpy+0x32>
80104bb9:	89 f1                	mov    %esi,%ecx
80104bbb:	85 c9                	test   %ecx,%ecx
80104bbd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104bc0:	7f e6                	jg     80104ba8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104bc2:	31 c9                	xor    %ecx,%ecx
80104bc4:	85 f6                	test   %esi,%esi
80104bc6:	7e 17                	jle    80104bdf <strncpy+0x4f>
80104bc8:	90                   	nop
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104bd0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104bd4:	89 f3                	mov    %esi,%ebx
80104bd6:	83 c1 01             	add    $0x1,%ecx
80104bd9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104bdb:	85 db                	test   %ebx,%ebx
80104bdd:	7f f1                	jg     80104bd0 <strncpy+0x40>
  return os;
}
80104bdf:	5b                   	pop    %ebx
80104be0:	5e                   	pop    %esi
80104be1:	5d                   	pop    %ebp
80104be2:	c3                   	ret    
80104be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bf0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
80104bf5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104bf8:	8b 45 08             	mov    0x8(%ebp),%eax
80104bfb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104bfe:	85 c9                	test   %ecx,%ecx
80104c00:	7e 26                	jle    80104c28 <safestrcpy+0x38>
80104c02:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104c06:	89 c1                	mov    %eax,%ecx
80104c08:	eb 17                	jmp    80104c21 <safestrcpy+0x31>
80104c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104c10:	83 c2 01             	add    $0x1,%edx
80104c13:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104c17:	83 c1 01             	add    $0x1,%ecx
80104c1a:	84 db                	test   %bl,%bl
80104c1c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104c1f:	74 04                	je     80104c25 <safestrcpy+0x35>
80104c21:	39 f2                	cmp    %esi,%edx
80104c23:	75 eb                	jne    80104c10 <safestrcpy+0x20>
    ;
  *s = 0;
80104c25:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104c28:	5b                   	pop    %ebx
80104c29:	5e                   	pop    %esi
80104c2a:	5d                   	pop    %ebp
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <strlen>:

int
strlen(const char *s)
{
80104c30:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c31:	31 c0                	xor    %eax,%eax
{
80104c33:	89 e5                	mov    %esp,%ebp
80104c35:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c38:	80 3a 00             	cmpb   $0x0,(%edx)
80104c3b:	74 0c                	je     80104c49 <strlen+0x19>
80104c3d:	8d 76 00             	lea    0x0(%esi),%esi
80104c40:	83 c0 01             	add    $0x1,%eax
80104c43:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c47:	75 f7                	jne    80104c40 <strlen+0x10>
    ;
  return n;
}
80104c49:	5d                   	pop    %ebp
80104c4a:	c3                   	ret    

80104c4b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c4b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c4f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c53:	55                   	push   %ebp
  pushl %ebx
80104c54:	53                   	push   %ebx
  pushl %esi
80104c55:	56                   	push   %esi
  pushl %edi
80104c56:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c57:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c59:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c5b:	5f                   	pop    %edi
  popl %esi
80104c5c:	5e                   	pop    %esi
  popl %ebx
80104c5d:	5b                   	pop    %ebx
  popl %ebp
80104c5e:	5d                   	pop    %ebp
  ret
80104c5f:	c3                   	ret    

80104c60 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	83 ec 04             	sub    $0x4,%esp
80104c67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c6a:	e8 e1 ef ff ff       	call   80103c50 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c6f:	8b 00                	mov    (%eax),%eax
80104c71:	39 d8                	cmp    %ebx,%eax
80104c73:	76 1b                	jbe    80104c90 <fetchint+0x30>
80104c75:	8d 53 04             	lea    0x4(%ebx),%edx
80104c78:	39 d0                	cmp    %edx,%eax
80104c7a:	72 14                	jb     80104c90 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c7f:	8b 13                	mov    (%ebx),%edx
80104c81:	89 10                	mov    %edx,(%eax)
  return 0;
80104c83:	31 c0                	xor    %eax,%eax
}
80104c85:	83 c4 04             	add    $0x4,%esp
80104c88:	5b                   	pop    %ebx
80104c89:	5d                   	pop    %ebp
80104c8a:	c3                   	ret    
80104c8b:	90                   	nop
80104c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c95:	eb ee                	jmp    80104c85 <fetchint+0x25>
80104c97:	89 f6                	mov    %esi,%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 04             	sub    $0x4,%esp
80104ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104caa:	e8 a1 ef ff ff       	call   80103c50 <myproc>

  if(addr >= curproc->sz)
80104caf:	39 18                	cmp    %ebx,(%eax)
80104cb1:	76 29                	jbe    80104cdc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104cb3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104cb6:	89 da                	mov    %ebx,%edx
80104cb8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104cba:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104cbc:	39 c3                	cmp    %eax,%ebx
80104cbe:	73 1c                	jae    80104cdc <fetchstr+0x3c>
    if(*s == 0)
80104cc0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104cc3:	75 10                	jne    80104cd5 <fetchstr+0x35>
80104cc5:	eb 39                	jmp    80104d00 <fetchstr+0x60>
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cd0:	80 3a 00             	cmpb   $0x0,(%edx)
80104cd3:	74 1b                	je     80104cf0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104cd5:	83 c2 01             	add    $0x1,%edx
80104cd8:	39 d0                	cmp    %edx,%eax
80104cda:	77 f4                	ja     80104cd0 <fetchstr+0x30>
    return -1;
80104cdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104ce1:	83 c4 04             	add    $0x4,%esp
80104ce4:	5b                   	pop    %ebx
80104ce5:	5d                   	pop    %ebp
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cf0:	83 c4 04             	add    $0x4,%esp
80104cf3:	89 d0                	mov    %edx,%eax
80104cf5:	29 d8                	sub    %ebx,%eax
80104cf7:	5b                   	pop    %ebx
80104cf8:	5d                   	pop    %ebp
80104cf9:	c3                   	ret    
80104cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104d00:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104d02:	eb dd                	jmp    80104ce1 <fetchstr+0x41>
80104d04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104d10 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	56                   	push   %esi
80104d14:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d15:	e8 36 ef ff ff       	call   80103c50 <myproc>
80104d1a:	8b 40 18             	mov    0x18(%eax),%eax
80104d1d:	8b 55 08             	mov    0x8(%ebp),%edx
80104d20:	8b 40 44             	mov    0x44(%eax),%eax
80104d23:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d26:	e8 25 ef ff ff       	call   80103c50 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d2b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d2d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d30:	39 c6                	cmp    %eax,%esi
80104d32:	73 1c                	jae    80104d50 <argint+0x40>
80104d34:	8d 53 08             	lea    0x8(%ebx),%edx
80104d37:	39 d0                	cmp    %edx,%eax
80104d39:	72 15                	jb     80104d50 <argint+0x40>
  *ip = *(int*)(addr);
80104d3b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d3e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d41:	89 10                	mov    %edx,(%eax)
  return 0;
80104d43:	31 c0                	xor    %eax,%eax
}
80104d45:	5b                   	pop    %ebx
80104d46:	5e                   	pop    %esi
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d55:	eb ee                	jmp    80104d45 <argint+0x35>
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	53                   	push   %ebx
80104d65:	83 ec 10             	sub    $0x10,%esp
80104d68:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104d6b:	e8 e0 ee ff ff       	call   80103c50 <myproc>
80104d70:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104d72:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d75:	83 ec 08             	sub    $0x8,%esp
80104d78:	50                   	push   %eax
80104d79:	ff 75 08             	pushl  0x8(%ebp)
80104d7c:	e8 8f ff ff ff       	call   80104d10 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d81:	83 c4 10             	add    $0x10,%esp
80104d84:	85 c0                	test   %eax,%eax
80104d86:	78 28                	js     80104db0 <argptr+0x50>
80104d88:	85 db                	test   %ebx,%ebx
80104d8a:	78 24                	js     80104db0 <argptr+0x50>
80104d8c:	8b 16                	mov    (%esi),%edx
80104d8e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d91:	39 c2                	cmp    %eax,%edx
80104d93:	76 1b                	jbe    80104db0 <argptr+0x50>
80104d95:	01 c3                	add    %eax,%ebx
80104d97:	39 da                	cmp    %ebx,%edx
80104d99:	72 15                	jb     80104db0 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104d9b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d9e:	89 02                	mov    %eax,(%edx)
  return 0;
80104da0:	31 c0                	xor    %eax,%eax
}
80104da2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104da5:	5b                   	pop    %ebx
80104da6:	5e                   	pop    %esi
80104da7:	5d                   	pop    %ebp
80104da8:	c3                   	ret    
80104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104db5:	eb eb                	jmp    80104da2 <argptr+0x42>
80104db7:	89 f6                	mov    %esi,%esi
80104db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dc0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104dc6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc9:	50                   	push   %eax
80104dca:	ff 75 08             	pushl  0x8(%ebp)
80104dcd:	e8 3e ff ff ff       	call   80104d10 <argint>
80104dd2:	83 c4 10             	add    $0x10,%esp
80104dd5:	85 c0                	test   %eax,%eax
80104dd7:	78 17                	js     80104df0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104dd9:	83 ec 08             	sub    $0x8,%esp
80104ddc:	ff 75 0c             	pushl  0xc(%ebp)
80104ddf:	ff 75 f4             	pushl  -0xc(%ebp)
80104de2:	e8 b9 fe ff ff       	call   80104ca0 <fetchstr>
80104de7:	83 c4 10             	add    $0x10,%esp
}
80104dea:	c9                   	leave  
80104deb:	c3                   	ret    
80104dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	53                   	push   %ebx
80104e04:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104e07:	e8 44 ee ff ff       	call   80103c50 <myproc>
80104e0c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104e0e:	8b 40 18             	mov    0x18(%eax),%eax
80104e11:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e14:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e17:	83 fa 14             	cmp    $0x14,%edx
80104e1a:	77 1c                	ja     80104e38 <syscall+0x38>
80104e1c:	8b 14 85 80 82 10 80 	mov    -0x7fef7d80(,%eax,4),%edx
80104e23:	85 d2                	test   %edx,%edx
80104e25:	74 11                	je     80104e38 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104e27:	ff d2                	call   *%edx
80104e29:	8b 53 18             	mov    0x18(%ebx),%edx
80104e2c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104e2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e32:	c9                   	leave  
80104e33:	c3                   	ret    
80104e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104e38:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e39:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e3c:	50                   	push   %eax
80104e3d:	ff 73 10             	pushl  0x10(%ebx)
80104e40:	68 59 82 10 80       	push   $0x80108259
80104e45:	e8 16 b8 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104e4a:	8b 43 18             	mov    0x18(%ebx),%eax
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e57:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e5a:	c9                   	leave  
80104e5b:	c3                   	ret    
80104e5c:	66 90                	xchg   %ax,%ax
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	53                   	push   %ebx
80104e65:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104e67:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104e6a:	89 d6                	mov    %edx,%esi
80104e6c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e6f:	50                   	push   %eax
80104e70:	6a 00                	push   $0x0
80104e72:	e8 99 fe ff ff       	call   80104d10 <argint>
80104e77:	83 c4 10             	add    $0x10,%esp
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	78 2a                	js     80104ea8 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e7e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e82:	77 24                	ja     80104ea8 <argfd.constprop.0+0x48>
80104e84:	e8 c7 ed ff ff       	call   80103c50 <myproc>
80104e89:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e8c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104e90:	85 c0                	test   %eax,%eax
80104e92:	74 14                	je     80104ea8 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
80104e94:	85 db                	test   %ebx,%ebx
80104e96:	74 02                	je     80104e9a <argfd.constprop.0+0x3a>
    *pfd = fd;
80104e98:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
80104e9a:	89 06                	mov    %eax,(%esi)
  return 0;
80104e9c:	31 c0                	xor    %eax,%eax
}
80104e9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ea1:	5b                   	pop    %ebx
80104ea2:	5e                   	pop    %esi
80104ea3:	5d                   	pop    %ebp
80104ea4:	c3                   	ret    
80104ea5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104ea8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ead:	eb ef                	jmp    80104e9e <argfd.constprop.0+0x3e>
80104eaf:	90                   	nop

80104eb0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104eb0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104eb1:	31 c0                	xor    %eax,%eax
{
80104eb3:	89 e5                	mov    %esp,%ebp
80104eb5:	56                   	push   %esi
80104eb6:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80104eb7:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
80104eba:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80104ebd:	e8 9e ff ff ff       	call   80104e60 <argfd.constprop.0>
80104ec2:	85 c0                	test   %eax,%eax
80104ec4:	78 42                	js     80104f08 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104ec6:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104ec9:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80104ecb:	e8 80 ed ff ff       	call   80103c50 <myproc>
80104ed0:	eb 0e                	jmp    80104ee0 <sys_dup+0x30>
80104ed2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80104ed8:	83 c3 01             	add    $0x1,%ebx
80104edb:	83 fb 10             	cmp    $0x10,%ebx
80104ede:	74 28                	je     80104f08 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80104ee0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ee4:	85 d2                	test   %edx,%edx
80104ee6:	75 f0                	jne    80104ed8 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80104ee8:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	ff 75 f4             	pushl  -0xc(%ebp)
80104ef2:	e8 79 bf ff ff       	call   80100e70 <filedup>
  return fd;
80104ef7:	83 c4 10             	add    $0x10,%esp
}
80104efa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104efd:	89 d8                	mov    %ebx,%eax
80104eff:	5b                   	pop    %ebx
80104f00:	5e                   	pop    %esi
80104f01:	5d                   	pop    %ebp
80104f02:	c3                   	ret    
80104f03:	90                   	nop
80104f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f08:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f0b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f10:	89 d8                	mov    %ebx,%eax
80104f12:	5b                   	pop    %ebx
80104f13:	5e                   	pop    %esi
80104f14:	5d                   	pop    %ebp
80104f15:	c3                   	ret    
80104f16:	8d 76 00             	lea    0x0(%esi),%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <sys_read>:

int
sys_read(void)
{
80104f20:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f21:	31 c0                	xor    %eax,%eax
{
80104f23:	89 e5                	mov    %esp,%ebp
80104f25:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f2b:	e8 30 ff ff ff       	call   80104e60 <argfd.constprop.0>
80104f30:	85 c0                	test   %eax,%eax
80104f32:	78 4c                	js     80104f80 <sys_read+0x60>
80104f34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f37:	83 ec 08             	sub    $0x8,%esp
80104f3a:	50                   	push   %eax
80104f3b:	6a 02                	push   $0x2
80104f3d:	e8 ce fd ff ff       	call   80104d10 <argint>
80104f42:	83 c4 10             	add    $0x10,%esp
80104f45:	85 c0                	test   %eax,%eax
80104f47:	78 37                	js     80104f80 <sys_read+0x60>
80104f49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f4c:	83 ec 04             	sub    $0x4,%esp
80104f4f:	ff 75 f0             	pushl  -0x10(%ebp)
80104f52:	50                   	push   %eax
80104f53:	6a 01                	push   $0x1
80104f55:	e8 06 fe ff ff       	call   80104d60 <argptr>
80104f5a:	83 c4 10             	add    $0x10,%esp
80104f5d:	85 c0                	test   %eax,%eax
80104f5f:	78 1f                	js     80104f80 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104f61:	83 ec 04             	sub    $0x4,%esp
80104f64:	ff 75 f0             	pushl  -0x10(%ebp)
80104f67:	ff 75 f4             	pushl  -0xc(%ebp)
80104f6a:	ff 75 ec             	pushl  -0x14(%ebp)
80104f6d:	e8 6e c0 ff ff       	call   80100fe0 <fileread>
80104f72:	83 c4 10             	add    $0x10,%esp
}
80104f75:	c9                   	leave  
80104f76:	c3                   	ret    
80104f77:	89 f6                	mov    %esi,%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104f80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f85:	c9                   	leave  
80104f86:	c3                   	ret    
80104f87:	89 f6                	mov    %esi,%esi
80104f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f90 <sys_write>:

int
sys_write(void)
{
80104f90:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f91:	31 c0                	xor    %eax,%eax
{
80104f93:	89 e5                	mov    %esp,%ebp
80104f95:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f98:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f9b:	e8 c0 fe ff ff       	call   80104e60 <argfd.constprop.0>
80104fa0:	85 c0                	test   %eax,%eax
80104fa2:	78 4c                	js     80104ff0 <sys_write+0x60>
80104fa4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fa7:	83 ec 08             	sub    $0x8,%esp
80104faa:	50                   	push   %eax
80104fab:	6a 02                	push   $0x2
80104fad:	e8 5e fd ff ff       	call   80104d10 <argint>
80104fb2:	83 c4 10             	add    $0x10,%esp
80104fb5:	85 c0                	test   %eax,%eax
80104fb7:	78 37                	js     80104ff0 <sys_write+0x60>
80104fb9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fbc:	83 ec 04             	sub    $0x4,%esp
80104fbf:	ff 75 f0             	pushl  -0x10(%ebp)
80104fc2:	50                   	push   %eax
80104fc3:	6a 01                	push   $0x1
80104fc5:	e8 96 fd ff ff       	call   80104d60 <argptr>
80104fca:	83 c4 10             	add    $0x10,%esp
80104fcd:	85 c0                	test   %eax,%eax
80104fcf:	78 1f                	js     80104ff0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104fd1:	83 ec 04             	sub    $0x4,%esp
80104fd4:	ff 75 f0             	pushl  -0x10(%ebp)
80104fd7:	ff 75 f4             	pushl  -0xc(%ebp)
80104fda:	ff 75 ec             	pushl  -0x14(%ebp)
80104fdd:	e8 8e c0 ff ff       	call   80101070 <filewrite>
80104fe2:	83 c4 10             	add    $0x10,%esp
}
80104fe5:	c9                   	leave  
80104fe6:	c3                   	ret    
80104fe7:	89 f6                	mov    %esi,%esi
80104fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80104ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ff5:	c9                   	leave  
80104ff6:	c3                   	ret    
80104ff7:	89 f6                	mov    %esi,%esi
80104ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105000 <sys_close>:

int
sys_close(void)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105006:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105009:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010500c:	e8 4f fe ff ff       	call   80104e60 <argfd.constprop.0>
80105011:	85 c0                	test   %eax,%eax
80105013:	78 2b                	js     80105040 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105015:	e8 36 ec ff ff       	call   80103c50 <myproc>
8010501a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010501d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105020:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105027:	00 
  fileclose(f);
80105028:	ff 75 f4             	pushl  -0xc(%ebp)
8010502b:	e8 90 be ff ff       	call   80100ec0 <fileclose>
  return 0;
80105030:	83 c4 10             	add    $0x10,%esp
80105033:	31 c0                	xor    %eax,%eax
}
80105035:	c9                   	leave  
80105036:	c3                   	ret    
80105037:	89 f6                	mov    %esi,%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105045:	c9                   	leave  
80105046:	c3                   	ret    
80105047:	89 f6                	mov    %esi,%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105050 <sys_fstat>:

int
sys_fstat(void)
{
80105050:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105051:	31 c0                	xor    %eax,%eax
{
80105053:	89 e5                	mov    %esp,%ebp
80105055:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105058:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010505b:	e8 00 fe ff ff       	call   80104e60 <argfd.constprop.0>
80105060:	85 c0                	test   %eax,%eax
80105062:	78 2c                	js     80105090 <sys_fstat+0x40>
80105064:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105067:	83 ec 04             	sub    $0x4,%esp
8010506a:	6a 14                	push   $0x14
8010506c:	50                   	push   %eax
8010506d:	6a 01                	push   $0x1
8010506f:	e8 ec fc ff ff       	call   80104d60 <argptr>
80105074:	83 c4 10             	add    $0x10,%esp
80105077:	85 c0                	test   %eax,%eax
80105079:	78 15                	js     80105090 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010507b:	83 ec 08             	sub    $0x8,%esp
8010507e:	ff 75 f4             	pushl  -0xc(%ebp)
80105081:	ff 75 f0             	pushl  -0x10(%ebp)
80105084:	e8 07 bf ff ff       	call   80100f90 <filestat>
80105089:	83 c4 10             	add    $0x10,%esp
}
8010508c:	c9                   	leave  
8010508d:	c3                   	ret    
8010508e:	66 90                	xchg   %ax,%ax
    return -1;
80105090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105095:	c9                   	leave  
80105096:	c3                   	ret    
80105097:	89 f6                	mov    %esi,%esi
80105099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050a0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	57                   	push   %edi
801050a4:	56                   	push   %esi
801050a5:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050a6:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801050a9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050ac:	50                   	push   %eax
801050ad:	6a 00                	push   $0x0
801050af:	e8 0c fd ff ff       	call   80104dc0 <argstr>
801050b4:	83 c4 10             	add    $0x10,%esp
801050b7:	85 c0                	test   %eax,%eax
801050b9:	0f 88 fb 00 00 00    	js     801051ba <sys_link+0x11a>
801050bf:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050c2:	83 ec 08             	sub    $0x8,%esp
801050c5:	50                   	push   %eax
801050c6:	6a 01                	push   $0x1
801050c8:	e8 f3 fc ff ff       	call   80104dc0 <argstr>
801050cd:	83 c4 10             	add    $0x10,%esp
801050d0:	85 c0                	test   %eax,%eax
801050d2:	0f 88 e2 00 00 00    	js     801051ba <sys_link+0x11a>
    return -1;

  begin_op();
801050d8:	e8 d3 de ff ff       	call   80102fb0 <begin_op>
  if((ip = namei(old)) == 0){
801050dd:	83 ec 0c             	sub    $0xc,%esp
801050e0:	ff 75 d4             	pushl  -0x2c(%ebp)
801050e3:	e8 78 ce ff ff       	call   80101f60 <namei>
801050e8:	83 c4 10             	add    $0x10,%esp
801050eb:	85 c0                	test   %eax,%eax
801050ed:	89 c3                	mov    %eax,%ebx
801050ef:	0f 84 ea 00 00 00    	je     801051df <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
801050f5:	83 ec 0c             	sub    $0xc,%esp
801050f8:	50                   	push   %eax
801050f9:	e8 02 c6 ff ff       	call   80101700 <ilock>
  if(ip->type == T_DIR){
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105106:	0f 84 bb 00 00 00    	je     801051c7 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010510c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105111:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105114:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105117:	53                   	push   %ebx
80105118:	e8 33 c5 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
8010511d:	89 1c 24             	mov    %ebx,(%esp)
80105120:	e8 bb c6 ff ff       	call   801017e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105125:	58                   	pop    %eax
80105126:	5a                   	pop    %edx
80105127:	57                   	push   %edi
80105128:	ff 75 d0             	pushl  -0x30(%ebp)
8010512b:	e8 50 ce ff ff       	call   80101f80 <nameiparent>
80105130:	83 c4 10             	add    $0x10,%esp
80105133:	85 c0                	test   %eax,%eax
80105135:	89 c6                	mov    %eax,%esi
80105137:	74 5b                	je     80105194 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105139:	83 ec 0c             	sub    $0xc,%esp
8010513c:	50                   	push   %eax
8010513d:	e8 be c5 ff ff       	call   80101700 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105142:	83 c4 10             	add    $0x10,%esp
80105145:	8b 03                	mov    (%ebx),%eax
80105147:	39 06                	cmp    %eax,(%esi)
80105149:	75 3d                	jne    80105188 <sys_link+0xe8>
8010514b:	83 ec 04             	sub    $0x4,%esp
8010514e:	ff 73 04             	pushl  0x4(%ebx)
80105151:	57                   	push   %edi
80105152:	56                   	push   %esi
80105153:	e8 48 cd ff ff       	call   80101ea0 <dirlink>
80105158:	83 c4 10             	add    $0x10,%esp
8010515b:	85 c0                	test   %eax,%eax
8010515d:	78 29                	js     80105188 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010515f:	83 ec 0c             	sub    $0xc,%esp
80105162:	56                   	push   %esi
80105163:	e8 28 c8 ff ff       	call   80101990 <iunlockput>
  iput(ip);
80105168:	89 1c 24             	mov    %ebx,(%esp)
8010516b:	e8 c0 c6 ff ff       	call   80101830 <iput>

  end_op();
80105170:	e8 ab de ff ff       	call   80103020 <end_op>

  return 0;
80105175:	83 c4 10             	add    $0x10,%esp
80105178:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010517a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010517d:	5b                   	pop    %ebx
8010517e:	5e                   	pop    %esi
8010517f:	5f                   	pop    %edi
80105180:	5d                   	pop    %ebp
80105181:	c3                   	ret    
80105182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105188:	83 ec 0c             	sub    $0xc,%esp
8010518b:	56                   	push   %esi
8010518c:	e8 ff c7 ff ff       	call   80101990 <iunlockput>
    goto bad;
80105191:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105194:	83 ec 0c             	sub    $0xc,%esp
80105197:	53                   	push   %ebx
80105198:	e8 63 c5 ff ff       	call   80101700 <ilock>
  ip->nlink--;
8010519d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051a2:	89 1c 24             	mov    %ebx,(%esp)
801051a5:	e8 a6 c4 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
801051aa:	89 1c 24             	mov    %ebx,(%esp)
801051ad:	e8 de c7 ff ff       	call   80101990 <iunlockput>
  end_op();
801051b2:	e8 69 de ff ff       	call   80103020 <end_op>
  return -1;
801051b7:	83 c4 10             	add    $0x10,%esp
}
801051ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801051bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051c2:	5b                   	pop    %ebx
801051c3:	5e                   	pop    %esi
801051c4:	5f                   	pop    %edi
801051c5:	5d                   	pop    %ebp
801051c6:	c3                   	ret    
    iunlockput(ip);
801051c7:	83 ec 0c             	sub    $0xc,%esp
801051ca:	53                   	push   %ebx
801051cb:	e8 c0 c7 ff ff       	call   80101990 <iunlockput>
    end_op();
801051d0:	e8 4b de ff ff       	call   80103020 <end_op>
    return -1;
801051d5:	83 c4 10             	add    $0x10,%esp
801051d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051dd:	eb 9b                	jmp    8010517a <sys_link+0xda>
    end_op();
801051df:	e8 3c de ff ff       	call   80103020 <end_op>
    return -1;
801051e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e9:	eb 8f                	jmp    8010517a <sys_link+0xda>
801051eb:	90                   	nop
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051f0 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	57                   	push   %edi
801051f4:	56                   	push   %esi
801051f5:	53                   	push   %ebx
801051f6:	83 ec 1c             	sub    $0x1c,%esp
801051f9:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051fc:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105200:	76 3e                	jbe    80105240 <isdirempty+0x50>
80105202:	bb 20 00 00 00       	mov    $0x20,%ebx
80105207:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010520a:	eb 0c                	jmp    80105218 <isdirempty+0x28>
8010520c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105210:	83 c3 10             	add    $0x10,%ebx
80105213:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105216:	73 28                	jae    80105240 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105218:	6a 10                	push   $0x10
8010521a:	53                   	push   %ebx
8010521b:	57                   	push   %edi
8010521c:	56                   	push   %esi
8010521d:	e8 be c7 ff ff       	call   801019e0 <readi>
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	83 f8 10             	cmp    $0x10,%eax
80105228:	75 23                	jne    8010524d <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010522a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010522f:	74 df                	je     80105210 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105231:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105234:	31 c0                	xor    %eax,%eax
}
80105236:	5b                   	pop    %ebx
80105237:	5e                   	pop    %esi
80105238:	5f                   	pop    %edi
80105239:	5d                   	pop    %ebp
8010523a:	c3                   	ret    
8010523b:	90                   	nop
8010523c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105240:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
80105243:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105248:	5b                   	pop    %ebx
80105249:	5e                   	pop    %esi
8010524a:	5f                   	pop    %edi
8010524b:	5d                   	pop    %ebp
8010524c:	c3                   	ret    
      panic("isdirempty: readi");
8010524d:	83 ec 0c             	sub    $0xc,%esp
80105250:	68 d8 82 10 80       	push   $0x801082d8
80105255:	e8 36 b1 ff ff       	call   80100390 <panic>
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105260 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	57                   	push   %edi
80105264:	56                   	push   %esi
80105265:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105266:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105269:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010526c:	50                   	push   %eax
8010526d:	6a 00                	push   $0x0
8010526f:	e8 4c fb ff ff       	call   80104dc0 <argstr>
80105274:	83 c4 10             	add    $0x10,%esp
80105277:	85 c0                	test   %eax,%eax
80105279:	0f 88 51 01 00 00    	js     801053d0 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010527f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
80105282:	e8 29 dd ff ff       	call   80102fb0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105287:	83 ec 08             	sub    $0x8,%esp
8010528a:	53                   	push   %ebx
8010528b:	ff 75 c0             	pushl  -0x40(%ebp)
8010528e:	e8 ed cc ff ff       	call   80101f80 <nameiparent>
80105293:	83 c4 10             	add    $0x10,%esp
80105296:	85 c0                	test   %eax,%eax
80105298:	89 c6                	mov    %eax,%esi
8010529a:	0f 84 37 01 00 00    	je     801053d7 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
801052a0:	83 ec 0c             	sub    $0xc,%esp
801052a3:	50                   	push   %eax
801052a4:	e8 57 c4 ff ff       	call   80101700 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801052a9:	58                   	pop    %eax
801052aa:	5a                   	pop    %edx
801052ab:	68 9d 7c 10 80       	push   $0x80107c9d
801052b0:	53                   	push   %ebx
801052b1:	e8 5a c9 ff ff       	call   80101c10 <namecmp>
801052b6:	83 c4 10             	add    $0x10,%esp
801052b9:	85 c0                	test   %eax,%eax
801052bb:	0f 84 d7 00 00 00    	je     80105398 <sys_unlink+0x138>
801052c1:	83 ec 08             	sub    $0x8,%esp
801052c4:	68 9c 7c 10 80       	push   $0x80107c9c
801052c9:	53                   	push   %ebx
801052ca:	e8 41 c9 ff ff       	call   80101c10 <namecmp>
801052cf:	83 c4 10             	add    $0x10,%esp
801052d2:	85 c0                	test   %eax,%eax
801052d4:	0f 84 be 00 00 00    	je     80105398 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801052da:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801052dd:	83 ec 04             	sub    $0x4,%esp
801052e0:	50                   	push   %eax
801052e1:	53                   	push   %ebx
801052e2:	56                   	push   %esi
801052e3:	e8 48 c9 ff ff       	call   80101c30 <dirlookup>
801052e8:	83 c4 10             	add    $0x10,%esp
801052eb:	85 c0                	test   %eax,%eax
801052ed:	89 c3                	mov    %eax,%ebx
801052ef:	0f 84 a3 00 00 00    	je     80105398 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
801052f5:	83 ec 0c             	sub    $0xc,%esp
801052f8:	50                   	push   %eax
801052f9:	e8 02 c4 ff ff       	call   80101700 <ilock>

  if(ip->nlink < 1)
801052fe:	83 c4 10             	add    $0x10,%esp
80105301:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105306:	0f 8e e4 00 00 00    	jle    801053f0 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010530c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105311:	74 65                	je     80105378 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105313:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105316:	83 ec 04             	sub    $0x4,%esp
80105319:	6a 10                	push   $0x10
8010531b:	6a 00                	push   $0x0
8010531d:	57                   	push   %edi
8010531e:	e8 ed f6 ff ff       	call   80104a10 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105323:	6a 10                	push   $0x10
80105325:	ff 75 c4             	pushl  -0x3c(%ebp)
80105328:	57                   	push   %edi
80105329:	56                   	push   %esi
8010532a:	e8 b1 c7 ff ff       	call   80101ae0 <writei>
8010532f:	83 c4 20             	add    $0x20,%esp
80105332:	83 f8 10             	cmp    $0x10,%eax
80105335:	0f 85 a8 00 00 00    	jne    801053e3 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010533b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105340:	74 6e                	je     801053b0 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105342:	83 ec 0c             	sub    $0xc,%esp
80105345:	56                   	push   %esi
80105346:	e8 45 c6 ff ff       	call   80101990 <iunlockput>

  ip->nlink--;
8010534b:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105350:	89 1c 24             	mov    %ebx,(%esp)
80105353:	e8 f8 c2 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
80105358:	89 1c 24             	mov    %ebx,(%esp)
8010535b:	e8 30 c6 ff ff       	call   80101990 <iunlockput>

  end_op();
80105360:	e8 bb dc ff ff       	call   80103020 <end_op>

  return 0;
80105365:	83 c4 10             	add    $0x10,%esp
80105368:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
8010536a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010536d:	5b                   	pop    %ebx
8010536e:	5e                   	pop    %esi
8010536f:	5f                   	pop    %edi
80105370:	5d                   	pop    %ebp
80105371:	c3                   	ret    
80105372:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
80105378:	83 ec 0c             	sub    $0xc,%esp
8010537b:	53                   	push   %ebx
8010537c:	e8 6f fe ff ff       	call   801051f0 <isdirempty>
80105381:	83 c4 10             	add    $0x10,%esp
80105384:	85 c0                	test   %eax,%eax
80105386:	75 8b                	jne    80105313 <sys_unlink+0xb3>
    iunlockput(ip);
80105388:	83 ec 0c             	sub    $0xc,%esp
8010538b:	53                   	push   %ebx
8010538c:	e8 ff c5 ff ff       	call   80101990 <iunlockput>
    goto bad;
80105391:	83 c4 10             	add    $0x10,%esp
80105394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
80105398:	83 ec 0c             	sub    $0xc,%esp
8010539b:	56                   	push   %esi
8010539c:	e8 ef c5 ff ff       	call   80101990 <iunlockput>
  end_op();
801053a1:	e8 7a dc ff ff       	call   80103020 <end_op>
  return -1;
801053a6:	83 c4 10             	add    $0x10,%esp
801053a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ae:	eb ba                	jmp    8010536a <sys_unlink+0x10a>
    dp->nlink--;
801053b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801053b5:	83 ec 0c             	sub    $0xc,%esp
801053b8:	56                   	push   %esi
801053b9:	e8 92 c2 ff ff       	call   80101650 <iupdate>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	e9 7c ff ff ff       	jmp    80105342 <sys_unlink+0xe2>
801053c6:	8d 76 00             	lea    0x0(%esi),%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053d5:	eb 93                	jmp    8010536a <sys_unlink+0x10a>
    end_op();
801053d7:	e8 44 dc ff ff       	call   80103020 <end_op>
    return -1;
801053dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053e1:	eb 87                	jmp    8010536a <sys_unlink+0x10a>
    panic("unlink: writei");
801053e3:	83 ec 0c             	sub    $0xc,%esp
801053e6:	68 b1 7c 10 80       	push   $0x80107cb1
801053eb:	e8 a0 af ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	68 9f 7c 10 80       	push   $0x80107c9f
801053f8:	e8 93 af ff ff       	call   80100390 <panic>
801053fd:	8d 76 00             	lea    0x0(%esi),%esi

80105400 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105406:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105409:	83 ec 34             	sub    $0x34,%esp
8010540c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010540f:	8b 55 10             	mov    0x10(%ebp),%edx
80105412:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105415:	56                   	push   %esi
80105416:	ff 75 08             	pushl  0x8(%ebp)
{
80105419:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010541c:	89 55 d0             	mov    %edx,-0x30(%ebp)
8010541f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105422:	e8 59 cb ff ff       	call   80101f80 <nameiparent>
80105427:	83 c4 10             	add    $0x10,%esp
8010542a:	85 c0                	test   %eax,%eax
8010542c:	0f 84 4e 01 00 00    	je     80105580 <create+0x180>
    return 0;
  ilock(dp);
80105432:	83 ec 0c             	sub    $0xc,%esp
80105435:	89 c3                	mov    %eax,%ebx
80105437:	50                   	push   %eax
80105438:	e8 c3 c2 ff ff       	call   80101700 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
8010543d:	83 c4 0c             	add    $0xc,%esp
80105440:	6a 00                	push   $0x0
80105442:	56                   	push   %esi
80105443:	53                   	push   %ebx
80105444:	e8 e7 c7 ff ff       	call   80101c30 <dirlookup>
80105449:	83 c4 10             	add    $0x10,%esp
8010544c:	85 c0                	test   %eax,%eax
8010544e:	89 c7                	mov    %eax,%edi
80105450:	74 3e                	je     80105490 <create+0x90>
    iunlockput(dp);
80105452:	83 ec 0c             	sub    $0xc,%esp
80105455:	53                   	push   %ebx
80105456:	e8 35 c5 ff ff       	call   80101990 <iunlockput>
    ilock(ip);
8010545b:	89 3c 24             	mov    %edi,(%esp)
8010545e:	e8 9d c2 ff ff       	call   80101700 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105463:	83 c4 10             	add    $0x10,%esp
80105466:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010546b:	0f 85 9f 00 00 00    	jne    80105510 <create+0x110>
80105471:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80105476:	0f 85 94 00 00 00    	jne    80105510 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010547c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010547f:	89 f8                	mov    %edi,%eax
80105481:	5b                   	pop    %ebx
80105482:	5e                   	pop    %esi
80105483:	5f                   	pop    %edi
80105484:	5d                   	pop    %ebp
80105485:	c3                   	ret    
80105486:	8d 76 00             	lea    0x0(%esi),%esi
80105489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
80105490:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105494:	83 ec 08             	sub    $0x8,%esp
80105497:	50                   	push   %eax
80105498:	ff 33                	pushl  (%ebx)
8010549a:	e8 f1 c0 ff ff       	call   80101590 <ialloc>
8010549f:	83 c4 10             	add    $0x10,%esp
801054a2:	85 c0                	test   %eax,%eax
801054a4:	89 c7                	mov    %eax,%edi
801054a6:	0f 84 e8 00 00 00    	je     80105594 <create+0x194>
  ilock(ip);
801054ac:	83 ec 0c             	sub    $0xc,%esp
801054af:	50                   	push   %eax
801054b0:	e8 4b c2 ff ff       	call   80101700 <ilock>
  ip->major = major;
801054b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801054b9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
801054bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801054c1:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
801054c5:	b8 01 00 00 00       	mov    $0x1,%eax
801054ca:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
801054ce:	89 3c 24             	mov    %edi,(%esp)
801054d1:	e8 7a c1 ff ff       	call   80101650 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801054d6:	83 c4 10             	add    $0x10,%esp
801054d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801054de:	74 50                	je     80105530 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
801054e0:	83 ec 04             	sub    $0x4,%esp
801054e3:	ff 77 04             	pushl  0x4(%edi)
801054e6:	56                   	push   %esi
801054e7:	53                   	push   %ebx
801054e8:	e8 b3 c9 ff ff       	call   80101ea0 <dirlink>
801054ed:	83 c4 10             	add    $0x10,%esp
801054f0:	85 c0                	test   %eax,%eax
801054f2:	0f 88 8f 00 00 00    	js     80105587 <create+0x187>
  iunlockput(dp);
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	53                   	push   %ebx
801054fc:	e8 8f c4 ff ff       	call   80101990 <iunlockput>
  return ip;
80105501:	83 c4 10             	add    $0x10,%esp
}
80105504:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105507:	89 f8                	mov    %edi,%eax
80105509:	5b                   	pop    %ebx
8010550a:	5e                   	pop    %esi
8010550b:	5f                   	pop    %edi
8010550c:	5d                   	pop    %ebp
8010550d:	c3                   	ret    
8010550e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	57                   	push   %edi
    return 0;
80105514:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105516:	e8 75 c4 ff ff       	call   80101990 <iunlockput>
    return 0;
8010551b:	83 c4 10             	add    $0x10,%esp
}
8010551e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105521:	89 f8                	mov    %edi,%eax
80105523:	5b                   	pop    %ebx
80105524:	5e                   	pop    %esi
80105525:	5f                   	pop    %edi
80105526:	5d                   	pop    %ebp
80105527:	c3                   	ret    
80105528:	90                   	nop
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105530:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105535:	83 ec 0c             	sub    $0xc,%esp
80105538:	53                   	push   %ebx
80105539:	e8 12 c1 ff ff       	call   80101650 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010553e:	83 c4 0c             	add    $0xc,%esp
80105541:	ff 77 04             	pushl  0x4(%edi)
80105544:	68 9d 7c 10 80       	push   $0x80107c9d
80105549:	57                   	push   %edi
8010554a:	e8 51 c9 ff ff       	call   80101ea0 <dirlink>
8010554f:	83 c4 10             	add    $0x10,%esp
80105552:	85 c0                	test   %eax,%eax
80105554:	78 1c                	js     80105572 <create+0x172>
80105556:	83 ec 04             	sub    $0x4,%esp
80105559:	ff 73 04             	pushl  0x4(%ebx)
8010555c:	68 9c 7c 10 80       	push   $0x80107c9c
80105561:	57                   	push   %edi
80105562:	e8 39 c9 ff ff       	call   80101ea0 <dirlink>
80105567:	83 c4 10             	add    $0x10,%esp
8010556a:	85 c0                	test   %eax,%eax
8010556c:	0f 89 6e ff ff ff    	jns    801054e0 <create+0xe0>
      panic("create dots");
80105572:	83 ec 0c             	sub    $0xc,%esp
80105575:	68 f9 82 10 80       	push   $0x801082f9
8010557a:	e8 11 ae ff ff       	call   80100390 <panic>
8010557f:	90                   	nop
    return 0;
80105580:	31 ff                	xor    %edi,%edi
80105582:	e9 f5 fe ff ff       	jmp    8010547c <create+0x7c>
    panic("create: dirlink");
80105587:	83 ec 0c             	sub    $0xc,%esp
8010558a:	68 05 83 10 80       	push   $0x80108305
8010558f:	e8 fc ad ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105594:	83 ec 0c             	sub    $0xc,%esp
80105597:	68 ea 82 10 80       	push   $0x801082ea
8010559c:	e8 ef ad ff ff       	call   80100390 <panic>
801055a1:	eb 0d                	jmp    801055b0 <sys_open>
801055a3:	90                   	nop
801055a4:	90                   	nop
801055a5:	90                   	nop
801055a6:	90                   	nop
801055a7:	90                   	nop
801055a8:	90                   	nop
801055a9:	90                   	nop
801055aa:	90                   	nop
801055ab:	90                   	nop
801055ac:	90                   	nop
801055ad:	90                   	nop
801055ae:	90                   	nop
801055af:	90                   	nop

801055b0 <sys_open>:

int
sys_open(void)
{
801055b0:	55                   	push   %ebp
801055b1:	89 e5                	mov    %esp,%ebp
801055b3:	57                   	push   %edi
801055b4:	56                   	push   %esi
801055b5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055b6:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801055b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801055bc:	50                   	push   %eax
801055bd:	6a 00                	push   $0x0
801055bf:	e8 fc f7 ff ff       	call   80104dc0 <argstr>
801055c4:	83 c4 10             	add    $0x10,%esp
801055c7:	85 c0                	test   %eax,%eax
801055c9:	0f 88 1d 01 00 00    	js     801056ec <sys_open+0x13c>
801055cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055d2:	83 ec 08             	sub    $0x8,%esp
801055d5:	50                   	push   %eax
801055d6:	6a 01                	push   $0x1
801055d8:	e8 33 f7 ff ff       	call   80104d10 <argint>
801055dd:	83 c4 10             	add    $0x10,%esp
801055e0:	85 c0                	test   %eax,%eax
801055e2:	0f 88 04 01 00 00    	js     801056ec <sys_open+0x13c>
    return -1;

  begin_op();
801055e8:	e8 c3 d9 ff ff       	call   80102fb0 <begin_op>

  if(omode & O_CREATE){
801055ed:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055f1:	0f 85 a9 00 00 00    	jne    801056a0 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055f7:	83 ec 0c             	sub    $0xc,%esp
801055fa:	ff 75 e0             	pushl  -0x20(%ebp)
801055fd:	e8 5e c9 ff ff       	call   80101f60 <namei>
80105602:	83 c4 10             	add    $0x10,%esp
80105605:	85 c0                	test   %eax,%eax
80105607:	89 c6                	mov    %eax,%esi
80105609:	0f 84 ac 00 00 00    	je     801056bb <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
8010560f:	83 ec 0c             	sub    $0xc,%esp
80105612:	50                   	push   %eax
80105613:	e8 e8 c0 ff ff       	call   80101700 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105618:	83 c4 10             	add    $0x10,%esp
8010561b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105620:	0f 84 aa 00 00 00    	je     801056d0 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105626:	e8 d5 b7 ff ff       	call   80100e00 <filealloc>
8010562b:	85 c0                	test   %eax,%eax
8010562d:	89 c7                	mov    %eax,%edi
8010562f:	0f 84 a6 00 00 00    	je     801056db <sys_open+0x12b>
  struct proc *curproc = myproc();
80105635:	e8 16 e6 ff ff       	call   80103c50 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010563a:	31 db                	xor    %ebx,%ebx
8010563c:	eb 0e                	jmp    8010564c <sys_open+0x9c>
8010563e:	66 90                	xchg   %ax,%ax
80105640:	83 c3 01             	add    $0x1,%ebx
80105643:	83 fb 10             	cmp    $0x10,%ebx
80105646:	0f 84 ac 00 00 00    	je     801056f8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010564c:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105650:	85 d2                	test   %edx,%edx
80105652:	75 ec                	jne    80105640 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105654:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105657:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010565b:	56                   	push   %esi
8010565c:	e8 7f c1 ff ff       	call   801017e0 <iunlock>
  end_op();
80105661:	e8 ba d9 ff ff       	call   80103020 <end_op>

  f->type = FD_INODE;
80105666:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010566c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010566f:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105672:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105675:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010567c:	89 d0                	mov    %edx,%eax
8010567e:	f7 d0                	not    %eax
80105680:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105683:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105686:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105689:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
8010568d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105690:	89 d8                	mov    %ebx,%eax
80105692:	5b                   	pop    %ebx
80105693:	5e                   	pop    %esi
80105694:	5f                   	pop    %edi
80105695:	5d                   	pop    %ebp
80105696:	c3                   	ret    
80105697:	89 f6                	mov    %esi,%esi
80105699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
801056a0:	6a 00                	push   $0x0
801056a2:	6a 00                	push   $0x0
801056a4:	6a 02                	push   $0x2
801056a6:	ff 75 e0             	pushl  -0x20(%ebp)
801056a9:	e8 52 fd ff ff       	call   80105400 <create>
    if(ip == 0){
801056ae:	83 c4 10             	add    $0x10,%esp
801056b1:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801056b3:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801056b5:	0f 85 6b ff ff ff    	jne    80105626 <sys_open+0x76>
      end_op();
801056bb:	e8 60 d9 ff ff       	call   80103020 <end_op>
      return -1;
801056c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056c5:	eb c6                	jmp    8010568d <sys_open+0xdd>
801056c7:	89 f6                	mov    %esi,%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
801056d0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801056d3:	85 c9                	test   %ecx,%ecx
801056d5:	0f 84 4b ff ff ff    	je     80105626 <sys_open+0x76>
    iunlockput(ip);
801056db:	83 ec 0c             	sub    $0xc,%esp
801056de:	56                   	push   %esi
801056df:	e8 ac c2 ff ff       	call   80101990 <iunlockput>
    end_op();
801056e4:	e8 37 d9 ff ff       	call   80103020 <end_op>
    return -1;
801056e9:	83 c4 10             	add    $0x10,%esp
801056ec:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056f1:	eb 9a                	jmp    8010568d <sys_open+0xdd>
801056f3:	90                   	nop
801056f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801056f8:	83 ec 0c             	sub    $0xc,%esp
801056fb:	57                   	push   %edi
801056fc:	e8 bf b7 ff ff       	call   80100ec0 <fileclose>
80105701:	83 c4 10             	add    $0x10,%esp
80105704:	eb d5                	jmp    801056db <sys_open+0x12b>
80105706:	8d 76 00             	lea    0x0(%esi),%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105710 <sys_mkdir>:

int
sys_mkdir(void)
{
80105710:	55                   	push   %ebp
80105711:	89 e5                	mov    %esp,%ebp
80105713:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105716:	e8 95 d8 ff ff       	call   80102fb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010571b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010571e:	83 ec 08             	sub    $0x8,%esp
80105721:	50                   	push   %eax
80105722:	6a 00                	push   $0x0
80105724:	e8 97 f6 ff ff       	call   80104dc0 <argstr>
80105729:	83 c4 10             	add    $0x10,%esp
8010572c:	85 c0                	test   %eax,%eax
8010572e:	78 30                	js     80105760 <sys_mkdir+0x50>
80105730:	6a 00                	push   $0x0
80105732:	6a 00                	push   $0x0
80105734:	6a 01                	push   $0x1
80105736:	ff 75 f4             	pushl  -0xc(%ebp)
80105739:	e8 c2 fc ff ff       	call   80105400 <create>
8010573e:	83 c4 10             	add    $0x10,%esp
80105741:	85 c0                	test   %eax,%eax
80105743:	74 1b                	je     80105760 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105745:	83 ec 0c             	sub    $0xc,%esp
80105748:	50                   	push   %eax
80105749:	e8 42 c2 ff ff       	call   80101990 <iunlockput>
  end_op();
8010574e:	e8 cd d8 ff ff       	call   80103020 <end_op>
  return 0;
80105753:	83 c4 10             	add    $0x10,%esp
80105756:	31 c0                	xor    %eax,%eax
}
80105758:	c9                   	leave  
80105759:	c3                   	ret    
8010575a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105760:	e8 bb d8 ff ff       	call   80103020 <end_op>
    return -1;
80105765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010576a:	c9                   	leave  
8010576b:	c3                   	ret    
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_mknod>:

int
sys_mknod(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105776:	e8 35 d8 ff ff       	call   80102fb0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010577b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010577e:	83 ec 08             	sub    $0x8,%esp
80105781:	50                   	push   %eax
80105782:	6a 00                	push   $0x0
80105784:	e8 37 f6 ff ff       	call   80104dc0 <argstr>
80105789:	83 c4 10             	add    $0x10,%esp
8010578c:	85 c0                	test   %eax,%eax
8010578e:	78 60                	js     801057f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105790:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105793:	83 ec 08             	sub    $0x8,%esp
80105796:	50                   	push   %eax
80105797:	6a 01                	push   $0x1
80105799:	e8 72 f5 ff ff       	call   80104d10 <argint>
  if((argstr(0, &path)) < 0 ||
8010579e:	83 c4 10             	add    $0x10,%esp
801057a1:	85 c0                	test   %eax,%eax
801057a3:	78 4b                	js     801057f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801057a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057a8:	83 ec 08             	sub    $0x8,%esp
801057ab:	50                   	push   %eax
801057ac:	6a 02                	push   $0x2
801057ae:	e8 5d f5 ff ff       	call   80104d10 <argint>
     argint(1, &major) < 0 ||
801057b3:	83 c4 10             	add    $0x10,%esp
801057b6:	85 c0                	test   %eax,%eax
801057b8:	78 36                	js     801057f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801057ba:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801057be:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
801057bf:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
801057c3:	50                   	push   %eax
801057c4:	6a 03                	push   $0x3
801057c6:	ff 75 ec             	pushl  -0x14(%ebp)
801057c9:	e8 32 fc ff ff       	call   80105400 <create>
801057ce:	83 c4 10             	add    $0x10,%esp
801057d1:	85 c0                	test   %eax,%eax
801057d3:	74 1b                	je     801057f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057d5:	83 ec 0c             	sub    $0xc,%esp
801057d8:	50                   	push   %eax
801057d9:	e8 b2 c1 ff ff       	call   80101990 <iunlockput>
  end_op();
801057de:	e8 3d d8 ff ff       	call   80103020 <end_op>
  return 0;
801057e3:	83 c4 10             	add    $0x10,%esp
801057e6:	31 c0                	xor    %eax,%eax
}
801057e8:	c9                   	leave  
801057e9:	c3                   	ret    
801057ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
801057f0:	e8 2b d8 ff ff       	call   80103020 <end_op>
    return -1;
801057f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057fa:	c9                   	leave  
801057fb:	c3                   	ret    
801057fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105800 <sys_chdir>:

int
sys_chdir(void)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
80105805:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105808:	e8 43 e4 ff ff       	call   80103c50 <myproc>
8010580d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010580f:	e8 9c d7 ff ff       	call   80102fb0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105814:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105817:	83 ec 08             	sub    $0x8,%esp
8010581a:	50                   	push   %eax
8010581b:	6a 00                	push   $0x0
8010581d:	e8 9e f5 ff ff       	call   80104dc0 <argstr>
80105822:	83 c4 10             	add    $0x10,%esp
80105825:	85 c0                	test   %eax,%eax
80105827:	78 77                	js     801058a0 <sys_chdir+0xa0>
80105829:	83 ec 0c             	sub    $0xc,%esp
8010582c:	ff 75 f4             	pushl  -0xc(%ebp)
8010582f:	e8 2c c7 ff ff       	call   80101f60 <namei>
80105834:	83 c4 10             	add    $0x10,%esp
80105837:	85 c0                	test   %eax,%eax
80105839:	89 c3                	mov    %eax,%ebx
8010583b:	74 63                	je     801058a0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010583d:	83 ec 0c             	sub    $0xc,%esp
80105840:	50                   	push   %eax
80105841:	e8 ba be ff ff       	call   80101700 <ilock>
  if(ip->type != T_DIR){
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010584e:	75 30                	jne    80105880 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105850:	83 ec 0c             	sub    $0xc,%esp
80105853:	53                   	push   %ebx
80105854:	e8 87 bf ff ff       	call   801017e0 <iunlock>
  iput(curproc->cwd);
80105859:	58                   	pop    %eax
8010585a:	ff 76 68             	pushl  0x68(%esi)
8010585d:	e8 ce bf ff ff       	call   80101830 <iput>
  end_op();
80105862:	e8 b9 d7 ff ff       	call   80103020 <end_op>
  curproc->cwd = ip;
80105867:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010586a:	83 c4 10             	add    $0x10,%esp
8010586d:	31 c0                	xor    %eax,%eax
}
8010586f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105872:	5b                   	pop    %ebx
80105873:	5e                   	pop    %esi
80105874:	5d                   	pop    %ebp
80105875:	c3                   	ret    
80105876:	8d 76 00             	lea    0x0(%esi),%esi
80105879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105880:	83 ec 0c             	sub    $0xc,%esp
80105883:	53                   	push   %ebx
80105884:	e8 07 c1 ff ff       	call   80101990 <iunlockput>
    end_op();
80105889:	e8 92 d7 ff ff       	call   80103020 <end_op>
    return -1;
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105896:	eb d7                	jmp    8010586f <sys_chdir+0x6f>
80105898:	90                   	nop
80105899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801058a0:	e8 7b d7 ff ff       	call   80103020 <end_op>
    return -1;
801058a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058aa:	eb c3                	jmp    8010586f <sys_chdir+0x6f>
801058ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801058b0 <sys_exec>:

int
sys_exec(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	57                   	push   %edi
801058b4:	56                   	push   %esi
801058b5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801058b6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801058bc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801058c2:	50                   	push   %eax
801058c3:	6a 00                	push   $0x0
801058c5:	e8 f6 f4 ff ff       	call   80104dc0 <argstr>
801058ca:	83 c4 10             	add    $0x10,%esp
801058cd:	85 c0                	test   %eax,%eax
801058cf:	0f 88 87 00 00 00    	js     8010595c <sys_exec+0xac>
801058d5:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801058db:	83 ec 08             	sub    $0x8,%esp
801058de:	50                   	push   %eax
801058df:	6a 01                	push   $0x1
801058e1:	e8 2a f4 ff ff       	call   80104d10 <argint>
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	85 c0                	test   %eax,%eax
801058eb:	78 6f                	js     8010595c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801058ed:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801058f3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801058f6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058f8:	68 80 00 00 00       	push   $0x80
801058fd:	6a 00                	push   $0x0
801058ff:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105905:	50                   	push   %eax
80105906:	e8 05 f1 ff ff       	call   80104a10 <memset>
8010590b:	83 c4 10             	add    $0x10,%esp
8010590e:	eb 2c                	jmp    8010593c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105910:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105916:	85 c0                	test   %eax,%eax
80105918:	74 56                	je     80105970 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010591a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105920:	83 ec 08             	sub    $0x8,%esp
80105923:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105926:	52                   	push   %edx
80105927:	50                   	push   %eax
80105928:	e8 73 f3 ff ff       	call   80104ca0 <fetchstr>
8010592d:	83 c4 10             	add    $0x10,%esp
80105930:	85 c0                	test   %eax,%eax
80105932:	78 28                	js     8010595c <sys_exec+0xac>
  for(i=0;; i++){
80105934:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105937:	83 fb 20             	cmp    $0x20,%ebx
8010593a:	74 20                	je     8010595c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010593c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105942:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105949:	83 ec 08             	sub    $0x8,%esp
8010594c:	57                   	push   %edi
8010594d:	01 f0                	add    %esi,%eax
8010594f:	50                   	push   %eax
80105950:	e8 0b f3 ff ff       	call   80104c60 <fetchint>
80105955:	83 c4 10             	add    $0x10,%esp
80105958:	85 c0                	test   %eax,%eax
8010595a:	79 b4                	jns    80105910 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010595c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010595f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105964:	5b                   	pop    %ebx
80105965:	5e                   	pop    %esi
80105966:	5f                   	pop    %edi
80105967:	5d                   	pop    %ebp
80105968:	c3                   	ret    
80105969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105970:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105976:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105979:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105980:	00 00 00 00 
  return exec(path, argv);
80105984:	50                   	push   %eax
80105985:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010598b:	e8 80 b0 ff ff       	call   80100a10 <exec>
80105990:	83 c4 10             	add    $0x10,%esp
}
80105993:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105996:	5b                   	pop    %ebx
80105997:	5e                   	pop    %esi
80105998:	5f                   	pop    %edi
80105999:	5d                   	pop    %ebp
8010599a:	c3                   	ret    
8010599b:	90                   	nop
8010599c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059a0 <sys_pipe>:

int
sys_pipe(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	57                   	push   %edi
801059a4:	56                   	push   %esi
801059a5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801059a6:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801059a9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801059ac:	6a 08                	push   $0x8
801059ae:	50                   	push   %eax
801059af:	6a 00                	push   $0x0
801059b1:	e8 aa f3 ff ff       	call   80104d60 <argptr>
801059b6:	83 c4 10             	add    $0x10,%esp
801059b9:	85 c0                	test   %eax,%eax
801059bb:	0f 88 ae 00 00 00    	js     80105a6f <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801059c1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059c4:	83 ec 08             	sub    $0x8,%esp
801059c7:	50                   	push   %eax
801059c8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801059cb:	50                   	push   %eax
801059cc:	e8 7f dc ff ff       	call   80103650 <pipealloc>
801059d1:	83 c4 10             	add    $0x10,%esp
801059d4:	85 c0                	test   %eax,%eax
801059d6:	0f 88 93 00 00 00    	js     80105a6f <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801059df:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801059e1:	e8 6a e2 ff ff       	call   80103c50 <myproc>
801059e6:	eb 10                	jmp    801059f8 <sys_pipe+0x58>
801059e8:	90                   	nop
801059e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801059f0:	83 c3 01             	add    $0x1,%ebx
801059f3:	83 fb 10             	cmp    $0x10,%ebx
801059f6:	74 60                	je     80105a58 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
801059f8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801059fc:	85 f6                	test   %esi,%esi
801059fe:	75 f0                	jne    801059f0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105a00:	8d 73 08             	lea    0x8(%ebx),%esi
80105a03:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105a07:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105a0a:	e8 41 e2 ff ff       	call   80103c50 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105a0f:	31 d2                	xor    %edx,%edx
80105a11:	eb 0d                	jmp    80105a20 <sys_pipe+0x80>
80105a13:	90                   	nop
80105a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a18:	83 c2 01             	add    $0x1,%edx
80105a1b:	83 fa 10             	cmp    $0x10,%edx
80105a1e:	74 28                	je     80105a48 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105a20:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105a24:	85 c9                	test   %ecx,%ecx
80105a26:	75 f0                	jne    80105a18 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105a28:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105a2c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a2f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105a31:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a34:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105a37:	31 c0                	xor    %eax,%eax
}
80105a39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a3c:	5b                   	pop    %ebx
80105a3d:	5e                   	pop    %esi
80105a3e:	5f                   	pop    %edi
80105a3f:	5d                   	pop    %ebp
80105a40:	c3                   	ret    
80105a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105a48:	e8 03 e2 ff ff       	call   80103c50 <myproc>
80105a4d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105a54:	00 
80105a55:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105a58:	83 ec 0c             	sub    $0xc,%esp
80105a5b:	ff 75 e0             	pushl  -0x20(%ebp)
80105a5e:	e8 5d b4 ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
80105a63:	58                   	pop    %eax
80105a64:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a67:	e8 54 b4 ff ff       	call   80100ec0 <fileclose>
    return -1;
80105a6c:	83 c4 10             	add    $0x10,%esp
80105a6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a74:	eb c3                	jmp    80105a39 <sys_pipe+0x99>
80105a76:	66 90                	xchg   %ax,%ax
80105a78:	66 90                	xchg   %ax,%ax
80105a7a:	66 90                	xchg   %ax,%ax
80105a7c:	66 90                	xchg   %ax,%ax
80105a7e:	66 90                	xchg   %ax,%ax

80105a80 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105a83:	5d                   	pop    %ebp
  return fork();
80105a84:	e9 67 e3 ff ff       	jmp    80103df0 <fork>
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a90 <sys_exit>:

int
sys_exit(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a96:	e8 d5 e6 ff ff       	call   80104170 <exit>
  return 0;  // not reached
}
80105a9b:	31 c0                	xor    %eax,%eax
80105a9d:	c9                   	leave  
80105a9e:	c3                   	ret    
80105a9f:	90                   	nop

80105aa0 <sys_wait>:

int
sys_wait(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105aa3:	5d                   	pop    %ebp
  return wait();
80105aa4:	e9 37 e9 ff ff       	jmp    801043e0 <wait>
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ab0 <sys_kill>:

int
sys_kill(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ab6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ab9:	50                   	push   %eax
80105aba:	6a 00                	push   $0x0
80105abc:	e8 4f f2 ff ff       	call   80104d10 <argint>
80105ac1:	83 c4 10             	add    $0x10,%esp
80105ac4:	85 c0                	test   %eax,%eax
80105ac6:	78 18                	js     80105ae0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ace:	e8 6d ea ff ff       	call   80104540 <kill>
80105ad3:	83 c4 10             	add    $0x10,%esp
}
80105ad6:	c9                   	leave  
80105ad7:	c3                   	ret    
80105ad8:	90                   	nop
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae5:	c9                   	leave  
80105ae6:	c3                   	ret    
80105ae7:	89 f6                	mov    %esi,%esi
80105ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105af0 <sys_getpid>:

int
sys_getpid(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105af6:	e8 55 e1 ff ff       	call   80103c50 <myproc>
80105afb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105afe:	c9                   	leave  
80105aff:	c3                   	ret    

80105b00 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b0a:	50                   	push   %eax
80105b0b:	6a 00                	push   $0x0
80105b0d:	e8 fe f1 ff ff       	call   80104d10 <argint>
80105b12:	83 c4 10             	add    $0x10,%esp
80105b15:	85 c0                	test   %eax,%eax
80105b17:	78 27                	js     80105b40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b19:	e8 32 e1 ff ff       	call   80103c50 <myproc>
  if(growproc(n) < 0)
80105b1e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105b21:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105b23:	ff 75 f4             	pushl  -0xc(%ebp)
80105b26:	e8 45 e2 ff ff       	call   80103d70 <growproc>
80105b2b:	83 c4 10             	add    $0x10,%esp
80105b2e:	85 c0                	test   %eax,%eax
80105b30:	78 0e                	js     80105b40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b32:	89 d8                	mov    %ebx,%eax
80105b34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b37:	c9                   	leave  
80105b38:	c3                   	ret    
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b45:	eb eb                	jmp    80105b32 <sys_sbrk+0x32>
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b50 <sys_sleep>:

int
sys_sleep(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b54:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b57:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b5a:	50                   	push   %eax
80105b5b:	6a 00                	push   $0x0
80105b5d:	e8 ae f1 ff ff       	call   80104d10 <argint>
80105b62:	83 c4 10             	add    $0x10,%esp
80105b65:	85 c0                	test   %eax,%eax
80105b67:	0f 88 8a 00 00 00    	js     80105bf7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105b6d:	83 ec 0c             	sub    $0xc,%esp
80105b70:	68 60 a0 11 80       	push   $0x8011a060
80105b75:	e8 86 ed ff ff       	call   80104900 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105b7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b7d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105b80:	8b 1d a0 a8 11 80    	mov    0x8011a8a0,%ebx
  while(ticks - ticks0 < n){
80105b86:	85 d2                	test   %edx,%edx
80105b88:	75 27                	jne    80105bb1 <sys_sleep+0x61>
80105b8a:	eb 54                	jmp    80105be0 <sys_sleep+0x90>
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b90:	83 ec 08             	sub    $0x8,%esp
80105b93:	68 60 a0 11 80       	push   $0x8011a060
80105b98:	68 a0 a8 11 80       	push   $0x8011a8a0
80105b9d:	e8 7e e7 ff ff       	call   80104320 <sleep>
  while(ticks - ticks0 < n){
80105ba2:	a1 a0 a8 11 80       	mov    0x8011a8a0,%eax
80105ba7:	83 c4 10             	add    $0x10,%esp
80105baa:	29 d8                	sub    %ebx,%eax
80105bac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105baf:	73 2f                	jae    80105be0 <sys_sleep+0x90>
    if(myproc()->killed){
80105bb1:	e8 9a e0 ff ff       	call   80103c50 <myproc>
80105bb6:	8b 40 24             	mov    0x24(%eax),%eax
80105bb9:	85 c0                	test   %eax,%eax
80105bbb:	74 d3                	je     80105b90 <sys_sleep+0x40>
      release(&tickslock);
80105bbd:	83 ec 0c             	sub    $0xc,%esp
80105bc0:	68 60 a0 11 80       	push   $0x8011a060
80105bc5:	e8 f6 ed ff ff       	call   801049c0 <release>
      return -1;
80105bca:	83 c4 10             	add    $0x10,%esp
80105bcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105bd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bd5:	c9                   	leave  
80105bd6:	c3                   	ret    
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105be0:	83 ec 0c             	sub    $0xc,%esp
80105be3:	68 60 a0 11 80       	push   $0x8011a060
80105be8:	e8 d3 ed ff ff       	call   801049c0 <release>
  return 0;
80105bed:	83 c4 10             	add    $0x10,%esp
80105bf0:	31 c0                	xor    %eax,%eax
}
80105bf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bf5:	c9                   	leave  
80105bf6:	c3                   	ret    
    return -1;
80105bf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bfc:	eb f4                	jmp    80105bf2 <sys_sleep+0xa2>
80105bfe:	66 90                	xchg   %ax,%ax

80105c00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	53                   	push   %ebx
80105c04:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c07:	68 60 a0 11 80       	push   $0x8011a060
80105c0c:	e8 ef ec ff ff       	call   80104900 <acquire>
  xticks = ticks;
80105c11:	8b 1d a0 a8 11 80    	mov    0x8011a8a0,%ebx
  release(&tickslock);
80105c17:	c7 04 24 60 a0 11 80 	movl   $0x8011a060,(%esp)
80105c1e:	e8 9d ed ff ff       	call   801049c0 <release>
  return xticks;
}
80105c23:	89 d8                	mov    %ebx,%eax
80105c25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c28:	c9                   	leave  
80105c29:	c3                   	ret    

80105c2a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105c2a:	1e                   	push   %ds
  pushl %es
80105c2b:	06                   	push   %es
  pushl %fs
80105c2c:	0f a0                	push   %fs
  pushl %gs
80105c2e:	0f a8                	push   %gs
  pushal
80105c30:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105c31:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105c35:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105c37:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105c39:	54                   	push   %esp
  call trap
80105c3a:	e8 c1 00 00 00       	call   80105d00 <trap>
  addl $4, %esp
80105c3f:	83 c4 04             	add    $0x4,%esp

80105c42 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105c42:	61                   	popa   
  popl %gs
80105c43:	0f a9                	pop    %gs
  popl %fs
80105c45:	0f a1                	pop    %fs
  popl %es
80105c47:	07                   	pop    %es
  popl %ds
80105c48:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105c49:	83 c4 08             	add    $0x8,%esp
  iret
80105c4c:	cf                   	iret   
80105c4d:	66 90                	xchg   %ax,%ax
80105c4f:	90                   	nop

80105c50 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105c50:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105c51:	31 c0                	xor    %eax,%eax
{
80105c53:	89 e5                	mov    %esp,%ebp
80105c55:	83 ec 08             	sub    $0x8,%esp
80105c58:	90                   	nop
80105c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105c60:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105c67:	c7 04 c5 a2 a0 11 80 	movl   $0x8e000008,-0x7fee5f5e(,%eax,8)
80105c6e:	08 00 00 8e 
80105c72:	66 89 14 c5 a0 a0 11 	mov    %dx,-0x7fee5f60(,%eax,8)
80105c79:	80 
80105c7a:	c1 ea 10             	shr    $0x10,%edx
80105c7d:	66 89 14 c5 a6 a0 11 	mov    %dx,-0x7fee5f5a(,%eax,8)
80105c84:	80 
  for(i = 0; i < 256; i++)
80105c85:	83 c0 01             	add    $0x1,%eax
80105c88:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c8d:	75 d1                	jne    80105c60 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c8f:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80105c94:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105c97:	c7 05 a2 a2 11 80 08 	movl   $0xef000008,0x8011a2a2
80105c9e:	00 00 ef 
  initlock(&tickslock, "time");
80105ca1:	68 15 83 10 80       	push   $0x80108315
80105ca6:	68 60 a0 11 80       	push   $0x8011a060
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105cab:	66 a3 a0 a2 11 80    	mov    %ax,0x8011a2a0
80105cb1:	c1 e8 10             	shr    $0x10,%eax
80105cb4:	66 a3 a6 a2 11 80    	mov    %ax,0x8011a2a6
  initlock(&tickslock, "time");
80105cba:	e8 01 eb ff ff       	call   801047c0 <initlock>
}
80105cbf:	83 c4 10             	add    $0x10,%esp
80105cc2:	c9                   	leave  
80105cc3:	c3                   	ret    
80105cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105cd0 <idtinit>:

void
idtinit(void)
{
80105cd0:	55                   	push   %ebp
  pd[0] = size-1;
80105cd1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105cd6:	89 e5                	mov    %esp,%ebp
80105cd8:	83 ec 10             	sub    $0x10,%esp
80105cdb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105cdf:	b8 a0 a0 11 80       	mov    $0x8011a0a0,%eax
80105ce4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ce8:	c1 e8 10             	shr    $0x10,%eax
80105ceb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105cef:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105cf2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105cf5:	c9                   	leave  
80105cf6:	c3                   	ret    
80105cf7:	89 f6                	mov    %esi,%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	57                   	push   %edi
80105d04:	56                   	push   %esi
80105d05:	53                   	push   %ebx
80105d06:	83 ec 1c             	sub    $0x1c,%esp
80105d09:	8b 7d 08             	mov    0x8(%ebp),%edi
  uint addr;
  if(tf->trapno == T_SYSCALL){
80105d0c:	8b 47 30             	mov    0x30(%edi),%eax
80105d0f:	83 f8 40             	cmp    $0x40,%eax
80105d12:	0f 84 f0 00 00 00    	je     80105e08 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105d18:	83 e8 0e             	sub    $0xe,%eax
80105d1b:	83 f8 31             	cmp    $0x31,%eax
80105d1e:	77 10                	ja     80105d30 <trap+0x30>
80105d20:	ff 24 85 cc 83 10 80 	jmp    *-0x7fef7c34(,%eax,4)
80105d27:	89 f6                	mov    %esi,%esi
80105d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    }


  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105d30:	e8 1b df ff ff       	call   80103c50 <myproc>
80105d35:	85 c0                	test   %eax,%eax
80105d37:	0f 84 47 02 00 00    	je     80105f84 <trap+0x284>
80105d3d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80105d41:	0f 84 3d 02 00 00    	je     80105f84 <trap+0x284>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105d47:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d4a:	8b 57 38             	mov    0x38(%edi),%edx
80105d4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105d50:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105d53:	e8 d8 de ff ff       	call   80103c30 <cpuid>
80105d58:	8b 77 34             	mov    0x34(%edi),%esi
80105d5b:	8b 5f 30             	mov    0x30(%edi),%ebx
80105d5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105d61:	e8 ea de ff ff       	call   80103c50 <myproc>
80105d66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d69:	e8 e2 de ff ff       	call   80103c50 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d6e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d71:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d74:	51                   	push   %ecx
80105d75:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
80105d76:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d79:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d7c:	56                   	push   %esi
80105d7d:	53                   	push   %ebx
            myproc()->pid, myproc()->name, tf->trapno,
80105d7e:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105d81:	52                   	push   %edx
80105d82:	ff 70 10             	pushl  0x10(%eax)
80105d85:	68 88 83 10 80       	push   $0x80108388
80105d8a:	e8 d1 a8 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105d8f:	83 c4 20             	add    $0x20,%esp
80105d92:	e8 b9 de ff ff       	call   80103c50 <myproc>
80105d97:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105d9e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105da0:	e8 ab de ff ff       	call   80103c50 <myproc>
80105da5:	85 c0                	test   %eax,%eax
80105da7:	74 1d                	je     80105dc6 <trap+0xc6>
80105da9:	e8 a2 de ff ff       	call   80103c50 <myproc>
80105dae:	8b 50 24             	mov    0x24(%eax),%edx
80105db1:	85 d2                	test   %edx,%edx
80105db3:	74 11                	je     80105dc6 <trap+0xc6>
80105db5:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105db9:	83 e0 03             	and    $0x3,%eax
80105dbc:	66 83 f8 03          	cmp    $0x3,%ax
80105dc0:	0f 84 7a 01 00 00    	je     80105f40 <trap+0x240>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105dc6:	e8 85 de ff ff       	call   80103c50 <myproc>
80105dcb:	85 c0                	test   %eax,%eax
80105dcd:	74 0b                	je     80105dda <trap+0xda>
80105dcf:	e8 7c de ff ff       	call   80103c50 <myproc>
80105dd4:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105dd8:	74 66                	je     80105e40 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105dda:	e8 71 de ff ff       	call   80103c50 <myproc>
80105ddf:	85 c0                	test   %eax,%eax
80105de1:	74 19                	je     80105dfc <trap+0xfc>
80105de3:	e8 68 de ff ff       	call   80103c50 <myproc>
80105de8:	8b 40 24             	mov    0x24(%eax),%eax
80105deb:	85 c0                	test   %eax,%eax
80105ded:	74 0d                	je     80105dfc <trap+0xfc>
80105def:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80105df3:	83 e0 03             	and    $0x3,%eax
80105df6:	66 83 f8 03          	cmp    $0x3,%ax
80105dfa:	74 35                	je     80105e31 <trap+0x131>
    exit();
}
80105dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dff:	5b                   	pop    %ebx
80105e00:	5e                   	pop    %esi
80105e01:	5f                   	pop    %edi
80105e02:	5d                   	pop    %ebp
80105e03:	c3                   	ret    
80105e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105e08:	e8 43 de ff ff       	call   80103c50 <myproc>
80105e0d:	8b 58 24             	mov    0x24(%eax),%ebx
80105e10:	85 db                	test   %ebx,%ebx
80105e12:	0f 85 18 01 00 00    	jne    80105f30 <trap+0x230>
    myproc()->tf = tf;
80105e18:	e8 33 de ff ff       	call   80103c50 <myproc>
80105e1d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80105e20:	e8 db ef ff ff       	call   80104e00 <syscall>
    if(myproc()->killed)
80105e25:	e8 26 de ff ff       	call   80103c50 <myproc>
80105e2a:	8b 48 24             	mov    0x24(%eax),%ecx
80105e2d:	85 c9                	test   %ecx,%ecx
80105e2f:	74 cb                	je     80105dfc <trap+0xfc>
}
80105e31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e34:	5b                   	pop    %ebx
80105e35:	5e                   	pop    %esi
80105e36:	5f                   	pop    %edi
80105e37:	5d                   	pop    %ebp
      exit();
80105e38:	e9 33 e3 ff ff       	jmp    80104170 <exit>
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105e40:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
80105e44:	75 94                	jne    80105dda <trap+0xda>
    yield();
80105e46:	e8 85 e4 ff ff       	call   801042d0 <yield>
80105e4b:	eb 8d                	jmp    80105dda <trap+0xda>
80105e4d:	8d 76 00             	lea    0x0(%esi),%esi
80105e50:	0f 20 d3             	mov    %cr2,%ebx
    pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
80105e53:	e8 f8 dd ff ff       	call   80103c50 <myproc>
    int inSwapFile = ((((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG));
80105e58:	8b 40 04             	mov    0x4(%eax),%eax
    pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
80105e5b:	89 da                	mov    %ebx,%edx
80105e5d:	c1 ea 16             	shr    $0x16,%edx
    int inSwapFile = ((((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG));
80105e60:	8b 04 90             	mov    (%eax,%edx,4),%eax
80105e63:	89 da                	mov    %ebx,%edx
80105e65:	c1 ea 0c             	shr    $0xc,%edx
80105e68:	81 e2 ff 03 00 00    	and    $0x3ff,%edx
80105e6e:	05 00 00 00 80       	add    $0x80000000,%eax
80105e73:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(inSwapFile){
80105e78:	f6 44 90 01 02       	testb  $0x2,0x1(%eax,%edx,4)
80105e7d:	0f 84 2c 01 00 00    	je     80105faf <trap+0x2af>
      swapPage(PTE_ADDR(addr));
80105e83:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80105e89:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80105e8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e8f:	5b                   	pop    %ebx
80105e90:	5e                   	pop    %esi
80105e91:	5f                   	pop    %edi
80105e92:	5d                   	pop    %ebp
      swapPage(PTE_ADDR(addr));
80105e93:	e9 68 1a 00 00       	jmp    80107900 <swapPage>
80105e98:	90                   	nop
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105ea0:	e8 8b dd ff ff       	call   80103c30 <cpuid>
80105ea5:	85 c0                	test   %eax,%eax
80105ea7:	0f 84 a3 00 00 00    	je     80105f50 <trap+0x250>
    lapiceoi();
80105ead:	e8 ae cc ff ff       	call   80102b60 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105eb2:	e8 99 dd ff ff       	call   80103c50 <myproc>
80105eb7:	85 c0                	test   %eax,%eax
80105eb9:	0f 85 ea fe ff ff    	jne    80105da9 <trap+0xa9>
80105ebf:	e9 02 ff ff ff       	jmp    80105dc6 <trap+0xc6>
80105ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105ec8:	e8 53 cb ff ff       	call   80102a20 <kbdintr>
    lapiceoi();
80105ecd:	e8 8e cc ff ff       	call   80102b60 <lapiceoi>
    break;
80105ed2:	e9 c9 fe ff ff       	jmp    80105da0 <trap+0xa0>
80105ed7:	89 f6                	mov    %esi,%esi
80105ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    uartintr();
80105ee0:	e8 4b 02 00 00       	call   80106130 <uartintr>
    lapiceoi();
80105ee5:	e8 76 cc ff ff       	call   80102b60 <lapiceoi>
    break;
80105eea:	e9 b1 fe ff ff       	jmp    80105da0 <trap+0xa0>
80105eef:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ef0:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80105ef4:	8b 77 38             	mov    0x38(%edi),%esi
80105ef7:	e8 34 dd ff ff       	call   80103c30 <cpuid>
80105efc:	56                   	push   %esi
80105efd:	53                   	push   %ebx
80105efe:	50                   	push   %eax
80105eff:	68 30 83 10 80       	push   $0x80108330
80105f04:	e8 57 a7 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80105f09:	e8 52 cc ff ff       	call   80102b60 <lapiceoi>
    break;
80105f0e:	83 c4 10             	add    $0x10,%esp
80105f11:	e9 8a fe ff ff       	jmp    80105da0 <trap+0xa0>
80105f16:	8d 76 00             	lea    0x0(%esi),%esi
80105f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80105f20:	e8 6b c5 ff ff       	call   80102490 <ideintr>
80105f25:	eb 86                	jmp    80105ead <trap+0x1ad>
80105f27:	89 f6                	mov    %esi,%esi
80105f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
80105f30:	e8 3b e2 ff ff       	call   80104170 <exit>
80105f35:	e9 de fe ff ff       	jmp    80105e18 <trap+0x118>
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80105f40:	e8 2b e2 ff ff       	call   80104170 <exit>
80105f45:	e9 7c fe ff ff       	jmp    80105dc6 <trap+0xc6>
80105f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80105f50:	83 ec 0c             	sub    $0xc,%esp
80105f53:	68 60 a0 11 80       	push   $0x8011a060
80105f58:	e8 a3 e9 ff ff       	call   80104900 <acquire>
      wakeup(&ticks);
80105f5d:	c7 04 24 a0 a8 11 80 	movl   $0x8011a8a0,(%esp)
      ticks++;
80105f64:	83 05 a0 a8 11 80 01 	addl   $0x1,0x8011a8a0
      wakeup(&ticks);
80105f6b:	e8 70 e5 ff ff       	call   801044e0 <wakeup>
      release(&tickslock);
80105f70:	c7 04 24 60 a0 11 80 	movl   $0x8011a060,(%esp)
80105f77:	e8 44 ea ff ff       	call   801049c0 <release>
80105f7c:	83 c4 10             	add    $0x10,%esp
80105f7f:	e9 29 ff ff ff       	jmp    80105ead <trap+0x1ad>
80105f84:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105f87:	8b 5f 38             	mov    0x38(%edi),%ebx
80105f8a:	e8 a1 dc ff ff       	call   80103c30 <cpuid>
80105f8f:	83 ec 0c             	sub    $0xc,%esp
80105f92:	56                   	push   %esi
80105f93:	53                   	push   %ebx
80105f94:	50                   	push   %eax
80105f95:	ff 77 30             	pushl  0x30(%edi)
80105f98:	68 54 83 10 80       	push   $0x80108354
80105f9d:	e8 be a6 ff ff       	call   80100660 <cprintf>
      panic("trap");
80105fa2:	83 c4 14             	add    $0x14,%esp
80105fa5:	68 29 83 10 80       	push   $0x80108329
80105faa:	e8 e1 a3 ff ff       	call   80100390 <panic>
      panic("trap: PF fault");
80105faf:	83 ec 0c             	sub    $0xc,%esp
80105fb2:	68 1a 83 10 80       	push   $0x8010831a
80105fb7:	e8 d4 a3 ff ff       	call   80100390 <panic>
80105fbc:	66 90                	xchg   %ax,%ax
80105fbe:	66 90                	xchg   %ax,%ax

80105fc0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105fc0:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80105fc5:	55                   	push   %ebp
80105fc6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105fc8:	85 c0                	test   %eax,%eax
80105fca:	74 1c                	je     80105fe8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105fcc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105fd1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105fd2:	a8 01                	test   $0x1,%al
80105fd4:	74 12                	je     80105fe8 <uartgetc+0x28>
80105fd6:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fdb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105fdc:	0f b6 c0             	movzbl %al,%eax
}
80105fdf:	5d                   	pop    %ebp
80105fe0:	c3                   	ret    
80105fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fe8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105fed:	5d                   	pop    %ebp
80105fee:	c3                   	ret    
80105fef:	90                   	nop

80105ff0 <uartputc.part.0>:
uartputc(int c)
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	57                   	push   %edi
80105ff4:	56                   	push   %esi
80105ff5:	53                   	push   %ebx
80105ff6:	89 c7                	mov    %eax,%edi
80105ff8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ffd:	be fd 03 00 00       	mov    $0x3fd,%esi
80106002:	83 ec 0c             	sub    $0xc,%esp
80106005:	eb 1b                	jmp    80106022 <uartputc.part.0+0x32>
80106007:	89 f6                	mov    %esi,%esi
80106009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106010:	83 ec 0c             	sub    $0xc,%esp
80106013:	6a 0a                	push   $0xa
80106015:	e8 66 cb ff ff       	call   80102b80 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010601a:	83 c4 10             	add    $0x10,%esp
8010601d:	83 eb 01             	sub    $0x1,%ebx
80106020:	74 07                	je     80106029 <uartputc.part.0+0x39>
80106022:	89 f2                	mov    %esi,%edx
80106024:	ec                   	in     (%dx),%al
80106025:	a8 20                	test   $0x20,%al
80106027:	74 e7                	je     80106010 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106029:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010602e:	89 f8                	mov    %edi,%eax
80106030:	ee                   	out    %al,(%dx)
}
80106031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106034:	5b                   	pop    %ebx
80106035:	5e                   	pop    %esi
80106036:	5f                   	pop    %edi
80106037:	5d                   	pop    %ebp
80106038:	c3                   	ret    
80106039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106040 <uartinit>:
{
80106040:	55                   	push   %ebp
80106041:	31 c9                	xor    %ecx,%ecx
80106043:	89 c8                	mov    %ecx,%eax
80106045:	89 e5                	mov    %esp,%ebp
80106047:	57                   	push   %edi
80106048:	56                   	push   %esi
80106049:	53                   	push   %ebx
8010604a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010604f:	89 da                	mov    %ebx,%edx
80106051:	83 ec 0c             	sub    $0xc,%esp
80106054:	ee                   	out    %al,(%dx)
80106055:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010605a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010605f:	89 fa                	mov    %edi,%edx
80106061:	ee                   	out    %al,(%dx)
80106062:	b8 0c 00 00 00       	mov    $0xc,%eax
80106067:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010606c:	ee                   	out    %al,(%dx)
8010606d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106072:	89 c8                	mov    %ecx,%eax
80106074:	89 f2                	mov    %esi,%edx
80106076:	ee                   	out    %al,(%dx)
80106077:	b8 03 00 00 00       	mov    $0x3,%eax
8010607c:	89 fa                	mov    %edi,%edx
8010607e:	ee                   	out    %al,(%dx)
8010607f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106084:	89 c8                	mov    %ecx,%eax
80106086:	ee                   	out    %al,(%dx)
80106087:	b8 01 00 00 00       	mov    $0x1,%eax
8010608c:	89 f2                	mov    %esi,%edx
8010608e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010608f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106094:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106095:	3c ff                	cmp    $0xff,%al
80106097:	74 5a                	je     801060f3 <uartinit+0xb3>
  uart = 1;
80106099:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
801060a0:	00 00 00 
801060a3:	89 da                	mov    %ebx,%edx
801060a5:	ec                   	in     (%dx),%al
801060a6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801060ab:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801060ac:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801060af:	bb 94 84 10 80       	mov    $0x80108494,%ebx
  ioapicenable(IRQ_COM1, 0);
801060b4:	6a 00                	push   $0x0
801060b6:	6a 04                	push   $0x4
801060b8:	e8 23 c6 ff ff       	call   801026e0 <ioapicenable>
801060bd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801060c0:	b8 78 00 00 00       	mov    $0x78,%eax
801060c5:	eb 13                	jmp    801060da <uartinit+0x9a>
801060c7:	89 f6                	mov    %esi,%esi
801060c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801060d0:	83 c3 01             	add    $0x1,%ebx
801060d3:	0f be 03             	movsbl (%ebx),%eax
801060d6:	84 c0                	test   %al,%al
801060d8:	74 19                	je     801060f3 <uartinit+0xb3>
  if(!uart)
801060da:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
801060e0:	85 d2                	test   %edx,%edx
801060e2:	74 ec                	je     801060d0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801060e4:	83 c3 01             	add    $0x1,%ebx
801060e7:	e8 04 ff ff ff       	call   80105ff0 <uartputc.part.0>
801060ec:	0f be 03             	movsbl (%ebx),%eax
801060ef:	84 c0                	test   %al,%al
801060f1:	75 e7                	jne    801060da <uartinit+0x9a>
}
801060f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060f6:	5b                   	pop    %ebx
801060f7:	5e                   	pop    %esi
801060f8:	5f                   	pop    %edi
801060f9:	5d                   	pop    %ebp
801060fa:	c3                   	ret    
801060fb:	90                   	nop
801060fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106100 <uartputc>:
  if(!uart)
80106100:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
80106106:	55                   	push   %ebp
80106107:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106109:	85 d2                	test   %edx,%edx
{
8010610b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010610e:	74 10                	je     80106120 <uartputc+0x20>
}
80106110:	5d                   	pop    %ebp
80106111:	e9 da fe ff ff       	jmp    80105ff0 <uartputc.part.0>
80106116:	8d 76 00             	lea    0x0(%esi),%esi
80106119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106120:	5d                   	pop    %ebp
80106121:	c3                   	ret    
80106122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106130 <uartintr>:

void
uartintr(void)
{
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106136:	68 c0 5f 10 80       	push   $0x80105fc0
8010613b:	e8 d0 a6 ff ff       	call   80100810 <consoleintr>
}
80106140:	83 c4 10             	add    $0x10,%esp
80106143:	c9                   	leave  
80106144:	c3                   	ret    

80106145 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $0
80106147:	6a 00                	push   $0x0
  jmp alltraps
80106149:	e9 dc fa ff ff       	jmp    80105c2a <alltraps>

8010614e <vector1>:
.globl vector1
vector1:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $1
80106150:	6a 01                	push   $0x1
  jmp alltraps
80106152:	e9 d3 fa ff ff       	jmp    80105c2a <alltraps>

80106157 <vector2>:
.globl vector2
vector2:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $2
80106159:	6a 02                	push   $0x2
  jmp alltraps
8010615b:	e9 ca fa ff ff       	jmp    80105c2a <alltraps>

80106160 <vector3>:
.globl vector3
vector3:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $3
80106162:	6a 03                	push   $0x3
  jmp alltraps
80106164:	e9 c1 fa ff ff       	jmp    80105c2a <alltraps>

80106169 <vector4>:
.globl vector4
vector4:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $4
8010616b:	6a 04                	push   $0x4
  jmp alltraps
8010616d:	e9 b8 fa ff ff       	jmp    80105c2a <alltraps>

80106172 <vector5>:
.globl vector5
vector5:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $5
80106174:	6a 05                	push   $0x5
  jmp alltraps
80106176:	e9 af fa ff ff       	jmp    80105c2a <alltraps>

8010617b <vector6>:
.globl vector6
vector6:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $6
8010617d:	6a 06                	push   $0x6
  jmp alltraps
8010617f:	e9 a6 fa ff ff       	jmp    80105c2a <alltraps>

80106184 <vector7>:
.globl vector7
vector7:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $7
80106186:	6a 07                	push   $0x7
  jmp alltraps
80106188:	e9 9d fa ff ff       	jmp    80105c2a <alltraps>

8010618d <vector8>:
.globl vector8
vector8:
  pushl $8
8010618d:	6a 08                	push   $0x8
  jmp alltraps
8010618f:	e9 96 fa ff ff       	jmp    80105c2a <alltraps>

80106194 <vector9>:
.globl vector9
vector9:
  pushl $0
80106194:	6a 00                	push   $0x0
  pushl $9
80106196:	6a 09                	push   $0x9
  jmp alltraps
80106198:	e9 8d fa ff ff       	jmp    80105c2a <alltraps>

8010619d <vector10>:
.globl vector10
vector10:
  pushl $10
8010619d:	6a 0a                	push   $0xa
  jmp alltraps
8010619f:	e9 86 fa ff ff       	jmp    80105c2a <alltraps>

801061a4 <vector11>:
.globl vector11
vector11:
  pushl $11
801061a4:	6a 0b                	push   $0xb
  jmp alltraps
801061a6:	e9 7f fa ff ff       	jmp    80105c2a <alltraps>

801061ab <vector12>:
.globl vector12
vector12:
  pushl $12
801061ab:	6a 0c                	push   $0xc
  jmp alltraps
801061ad:	e9 78 fa ff ff       	jmp    80105c2a <alltraps>

801061b2 <vector13>:
.globl vector13
vector13:
  pushl $13
801061b2:	6a 0d                	push   $0xd
  jmp alltraps
801061b4:	e9 71 fa ff ff       	jmp    80105c2a <alltraps>

801061b9 <vector14>:
.globl vector14
vector14:
  pushl $14
801061b9:	6a 0e                	push   $0xe
  jmp alltraps
801061bb:	e9 6a fa ff ff       	jmp    80105c2a <alltraps>

801061c0 <vector15>:
.globl vector15
vector15:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $15
801061c2:	6a 0f                	push   $0xf
  jmp alltraps
801061c4:	e9 61 fa ff ff       	jmp    80105c2a <alltraps>

801061c9 <vector16>:
.globl vector16
vector16:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $16
801061cb:	6a 10                	push   $0x10
  jmp alltraps
801061cd:	e9 58 fa ff ff       	jmp    80105c2a <alltraps>

801061d2 <vector17>:
.globl vector17
vector17:
  pushl $17
801061d2:	6a 11                	push   $0x11
  jmp alltraps
801061d4:	e9 51 fa ff ff       	jmp    80105c2a <alltraps>

801061d9 <vector18>:
.globl vector18
vector18:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $18
801061db:	6a 12                	push   $0x12
  jmp alltraps
801061dd:	e9 48 fa ff ff       	jmp    80105c2a <alltraps>

801061e2 <vector19>:
.globl vector19
vector19:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $19
801061e4:	6a 13                	push   $0x13
  jmp alltraps
801061e6:	e9 3f fa ff ff       	jmp    80105c2a <alltraps>

801061eb <vector20>:
.globl vector20
vector20:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $20
801061ed:	6a 14                	push   $0x14
  jmp alltraps
801061ef:	e9 36 fa ff ff       	jmp    80105c2a <alltraps>

801061f4 <vector21>:
.globl vector21
vector21:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $21
801061f6:	6a 15                	push   $0x15
  jmp alltraps
801061f8:	e9 2d fa ff ff       	jmp    80105c2a <alltraps>

801061fd <vector22>:
.globl vector22
vector22:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $22
801061ff:	6a 16                	push   $0x16
  jmp alltraps
80106201:	e9 24 fa ff ff       	jmp    80105c2a <alltraps>

80106206 <vector23>:
.globl vector23
vector23:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $23
80106208:	6a 17                	push   $0x17
  jmp alltraps
8010620a:	e9 1b fa ff ff       	jmp    80105c2a <alltraps>

8010620f <vector24>:
.globl vector24
vector24:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $24
80106211:	6a 18                	push   $0x18
  jmp alltraps
80106213:	e9 12 fa ff ff       	jmp    80105c2a <alltraps>

80106218 <vector25>:
.globl vector25
vector25:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $25
8010621a:	6a 19                	push   $0x19
  jmp alltraps
8010621c:	e9 09 fa ff ff       	jmp    80105c2a <alltraps>

80106221 <vector26>:
.globl vector26
vector26:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $26
80106223:	6a 1a                	push   $0x1a
  jmp alltraps
80106225:	e9 00 fa ff ff       	jmp    80105c2a <alltraps>

8010622a <vector27>:
.globl vector27
vector27:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $27
8010622c:	6a 1b                	push   $0x1b
  jmp alltraps
8010622e:	e9 f7 f9 ff ff       	jmp    80105c2a <alltraps>

80106233 <vector28>:
.globl vector28
vector28:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $28
80106235:	6a 1c                	push   $0x1c
  jmp alltraps
80106237:	e9 ee f9 ff ff       	jmp    80105c2a <alltraps>

8010623c <vector29>:
.globl vector29
vector29:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $29
8010623e:	6a 1d                	push   $0x1d
  jmp alltraps
80106240:	e9 e5 f9 ff ff       	jmp    80105c2a <alltraps>

80106245 <vector30>:
.globl vector30
vector30:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $30
80106247:	6a 1e                	push   $0x1e
  jmp alltraps
80106249:	e9 dc f9 ff ff       	jmp    80105c2a <alltraps>

8010624e <vector31>:
.globl vector31
vector31:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $31
80106250:	6a 1f                	push   $0x1f
  jmp alltraps
80106252:	e9 d3 f9 ff ff       	jmp    80105c2a <alltraps>

80106257 <vector32>:
.globl vector32
vector32:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $32
80106259:	6a 20                	push   $0x20
  jmp alltraps
8010625b:	e9 ca f9 ff ff       	jmp    80105c2a <alltraps>

80106260 <vector33>:
.globl vector33
vector33:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $33
80106262:	6a 21                	push   $0x21
  jmp alltraps
80106264:	e9 c1 f9 ff ff       	jmp    80105c2a <alltraps>

80106269 <vector34>:
.globl vector34
vector34:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $34
8010626b:	6a 22                	push   $0x22
  jmp alltraps
8010626d:	e9 b8 f9 ff ff       	jmp    80105c2a <alltraps>

80106272 <vector35>:
.globl vector35
vector35:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $35
80106274:	6a 23                	push   $0x23
  jmp alltraps
80106276:	e9 af f9 ff ff       	jmp    80105c2a <alltraps>

8010627b <vector36>:
.globl vector36
vector36:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $36
8010627d:	6a 24                	push   $0x24
  jmp alltraps
8010627f:	e9 a6 f9 ff ff       	jmp    80105c2a <alltraps>

80106284 <vector37>:
.globl vector37
vector37:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $37
80106286:	6a 25                	push   $0x25
  jmp alltraps
80106288:	e9 9d f9 ff ff       	jmp    80105c2a <alltraps>

8010628d <vector38>:
.globl vector38
vector38:
  pushl $0
8010628d:	6a 00                	push   $0x0
  pushl $38
8010628f:	6a 26                	push   $0x26
  jmp alltraps
80106291:	e9 94 f9 ff ff       	jmp    80105c2a <alltraps>

80106296 <vector39>:
.globl vector39
vector39:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $39
80106298:	6a 27                	push   $0x27
  jmp alltraps
8010629a:	e9 8b f9 ff ff       	jmp    80105c2a <alltraps>

8010629f <vector40>:
.globl vector40
vector40:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $40
801062a1:	6a 28                	push   $0x28
  jmp alltraps
801062a3:	e9 82 f9 ff ff       	jmp    80105c2a <alltraps>

801062a8 <vector41>:
.globl vector41
vector41:
  pushl $0
801062a8:	6a 00                	push   $0x0
  pushl $41
801062aa:	6a 29                	push   $0x29
  jmp alltraps
801062ac:	e9 79 f9 ff ff       	jmp    80105c2a <alltraps>

801062b1 <vector42>:
.globl vector42
vector42:
  pushl $0
801062b1:	6a 00                	push   $0x0
  pushl $42
801062b3:	6a 2a                	push   $0x2a
  jmp alltraps
801062b5:	e9 70 f9 ff ff       	jmp    80105c2a <alltraps>

801062ba <vector43>:
.globl vector43
vector43:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $43
801062bc:	6a 2b                	push   $0x2b
  jmp alltraps
801062be:	e9 67 f9 ff ff       	jmp    80105c2a <alltraps>

801062c3 <vector44>:
.globl vector44
vector44:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $44
801062c5:	6a 2c                	push   $0x2c
  jmp alltraps
801062c7:	e9 5e f9 ff ff       	jmp    80105c2a <alltraps>

801062cc <vector45>:
.globl vector45
vector45:
  pushl $0
801062cc:	6a 00                	push   $0x0
  pushl $45
801062ce:	6a 2d                	push   $0x2d
  jmp alltraps
801062d0:	e9 55 f9 ff ff       	jmp    80105c2a <alltraps>

801062d5 <vector46>:
.globl vector46
vector46:
  pushl $0
801062d5:	6a 00                	push   $0x0
  pushl $46
801062d7:	6a 2e                	push   $0x2e
  jmp alltraps
801062d9:	e9 4c f9 ff ff       	jmp    80105c2a <alltraps>

801062de <vector47>:
.globl vector47
vector47:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $47
801062e0:	6a 2f                	push   $0x2f
  jmp alltraps
801062e2:	e9 43 f9 ff ff       	jmp    80105c2a <alltraps>

801062e7 <vector48>:
.globl vector48
vector48:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $48
801062e9:	6a 30                	push   $0x30
  jmp alltraps
801062eb:	e9 3a f9 ff ff       	jmp    80105c2a <alltraps>

801062f0 <vector49>:
.globl vector49
vector49:
  pushl $0
801062f0:	6a 00                	push   $0x0
  pushl $49
801062f2:	6a 31                	push   $0x31
  jmp alltraps
801062f4:	e9 31 f9 ff ff       	jmp    80105c2a <alltraps>

801062f9 <vector50>:
.globl vector50
vector50:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $50
801062fb:	6a 32                	push   $0x32
  jmp alltraps
801062fd:	e9 28 f9 ff ff       	jmp    80105c2a <alltraps>

80106302 <vector51>:
.globl vector51
vector51:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $51
80106304:	6a 33                	push   $0x33
  jmp alltraps
80106306:	e9 1f f9 ff ff       	jmp    80105c2a <alltraps>

8010630b <vector52>:
.globl vector52
vector52:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $52
8010630d:	6a 34                	push   $0x34
  jmp alltraps
8010630f:	e9 16 f9 ff ff       	jmp    80105c2a <alltraps>

80106314 <vector53>:
.globl vector53
vector53:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $53
80106316:	6a 35                	push   $0x35
  jmp alltraps
80106318:	e9 0d f9 ff ff       	jmp    80105c2a <alltraps>

8010631d <vector54>:
.globl vector54
vector54:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $54
8010631f:	6a 36                	push   $0x36
  jmp alltraps
80106321:	e9 04 f9 ff ff       	jmp    80105c2a <alltraps>

80106326 <vector55>:
.globl vector55
vector55:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $55
80106328:	6a 37                	push   $0x37
  jmp alltraps
8010632a:	e9 fb f8 ff ff       	jmp    80105c2a <alltraps>

8010632f <vector56>:
.globl vector56
vector56:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $56
80106331:	6a 38                	push   $0x38
  jmp alltraps
80106333:	e9 f2 f8 ff ff       	jmp    80105c2a <alltraps>

80106338 <vector57>:
.globl vector57
vector57:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $57
8010633a:	6a 39                	push   $0x39
  jmp alltraps
8010633c:	e9 e9 f8 ff ff       	jmp    80105c2a <alltraps>

80106341 <vector58>:
.globl vector58
vector58:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $58
80106343:	6a 3a                	push   $0x3a
  jmp alltraps
80106345:	e9 e0 f8 ff ff       	jmp    80105c2a <alltraps>

8010634a <vector59>:
.globl vector59
vector59:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $59
8010634c:	6a 3b                	push   $0x3b
  jmp alltraps
8010634e:	e9 d7 f8 ff ff       	jmp    80105c2a <alltraps>

80106353 <vector60>:
.globl vector60
vector60:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $60
80106355:	6a 3c                	push   $0x3c
  jmp alltraps
80106357:	e9 ce f8 ff ff       	jmp    80105c2a <alltraps>

8010635c <vector61>:
.globl vector61
vector61:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $61
8010635e:	6a 3d                	push   $0x3d
  jmp alltraps
80106360:	e9 c5 f8 ff ff       	jmp    80105c2a <alltraps>

80106365 <vector62>:
.globl vector62
vector62:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $62
80106367:	6a 3e                	push   $0x3e
  jmp alltraps
80106369:	e9 bc f8 ff ff       	jmp    80105c2a <alltraps>

8010636e <vector63>:
.globl vector63
vector63:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $63
80106370:	6a 3f                	push   $0x3f
  jmp alltraps
80106372:	e9 b3 f8 ff ff       	jmp    80105c2a <alltraps>

80106377 <vector64>:
.globl vector64
vector64:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $64
80106379:	6a 40                	push   $0x40
  jmp alltraps
8010637b:	e9 aa f8 ff ff       	jmp    80105c2a <alltraps>

80106380 <vector65>:
.globl vector65
vector65:
  pushl $0
80106380:	6a 00                	push   $0x0
  pushl $65
80106382:	6a 41                	push   $0x41
  jmp alltraps
80106384:	e9 a1 f8 ff ff       	jmp    80105c2a <alltraps>

80106389 <vector66>:
.globl vector66
vector66:
  pushl $0
80106389:	6a 00                	push   $0x0
  pushl $66
8010638b:	6a 42                	push   $0x42
  jmp alltraps
8010638d:	e9 98 f8 ff ff       	jmp    80105c2a <alltraps>

80106392 <vector67>:
.globl vector67
vector67:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $67
80106394:	6a 43                	push   $0x43
  jmp alltraps
80106396:	e9 8f f8 ff ff       	jmp    80105c2a <alltraps>

8010639b <vector68>:
.globl vector68
vector68:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $68
8010639d:	6a 44                	push   $0x44
  jmp alltraps
8010639f:	e9 86 f8 ff ff       	jmp    80105c2a <alltraps>

801063a4 <vector69>:
.globl vector69
vector69:
  pushl $0
801063a4:	6a 00                	push   $0x0
  pushl $69
801063a6:	6a 45                	push   $0x45
  jmp alltraps
801063a8:	e9 7d f8 ff ff       	jmp    80105c2a <alltraps>

801063ad <vector70>:
.globl vector70
vector70:
  pushl $0
801063ad:	6a 00                	push   $0x0
  pushl $70
801063af:	6a 46                	push   $0x46
  jmp alltraps
801063b1:	e9 74 f8 ff ff       	jmp    80105c2a <alltraps>

801063b6 <vector71>:
.globl vector71
vector71:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $71
801063b8:	6a 47                	push   $0x47
  jmp alltraps
801063ba:	e9 6b f8 ff ff       	jmp    80105c2a <alltraps>

801063bf <vector72>:
.globl vector72
vector72:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $72
801063c1:	6a 48                	push   $0x48
  jmp alltraps
801063c3:	e9 62 f8 ff ff       	jmp    80105c2a <alltraps>

801063c8 <vector73>:
.globl vector73
vector73:
  pushl $0
801063c8:	6a 00                	push   $0x0
  pushl $73
801063ca:	6a 49                	push   $0x49
  jmp alltraps
801063cc:	e9 59 f8 ff ff       	jmp    80105c2a <alltraps>

801063d1 <vector74>:
.globl vector74
vector74:
  pushl $0
801063d1:	6a 00                	push   $0x0
  pushl $74
801063d3:	6a 4a                	push   $0x4a
  jmp alltraps
801063d5:	e9 50 f8 ff ff       	jmp    80105c2a <alltraps>

801063da <vector75>:
.globl vector75
vector75:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $75
801063dc:	6a 4b                	push   $0x4b
  jmp alltraps
801063de:	e9 47 f8 ff ff       	jmp    80105c2a <alltraps>

801063e3 <vector76>:
.globl vector76
vector76:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $76
801063e5:	6a 4c                	push   $0x4c
  jmp alltraps
801063e7:	e9 3e f8 ff ff       	jmp    80105c2a <alltraps>

801063ec <vector77>:
.globl vector77
vector77:
  pushl $0
801063ec:	6a 00                	push   $0x0
  pushl $77
801063ee:	6a 4d                	push   $0x4d
  jmp alltraps
801063f0:	e9 35 f8 ff ff       	jmp    80105c2a <alltraps>

801063f5 <vector78>:
.globl vector78
vector78:
  pushl $0
801063f5:	6a 00                	push   $0x0
  pushl $78
801063f7:	6a 4e                	push   $0x4e
  jmp alltraps
801063f9:	e9 2c f8 ff ff       	jmp    80105c2a <alltraps>

801063fe <vector79>:
.globl vector79
vector79:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $79
80106400:	6a 4f                	push   $0x4f
  jmp alltraps
80106402:	e9 23 f8 ff ff       	jmp    80105c2a <alltraps>

80106407 <vector80>:
.globl vector80
vector80:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $80
80106409:	6a 50                	push   $0x50
  jmp alltraps
8010640b:	e9 1a f8 ff ff       	jmp    80105c2a <alltraps>

80106410 <vector81>:
.globl vector81
vector81:
  pushl $0
80106410:	6a 00                	push   $0x0
  pushl $81
80106412:	6a 51                	push   $0x51
  jmp alltraps
80106414:	e9 11 f8 ff ff       	jmp    80105c2a <alltraps>

80106419 <vector82>:
.globl vector82
vector82:
  pushl $0
80106419:	6a 00                	push   $0x0
  pushl $82
8010641b:	6a 52                	push   $0x52
  jmp alltraps
8010641d:	e9 08 f8 ff ff       	jmp    80105c2a <alltraps>

80106422 <vector83>:
.globl vector83
vector83:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $83
80106424:	6a 53                	push   $0x53
  jmp alltraps
80106426:	e9 ff f7 ff ff       	jmp    80105c2a <alltraps>

8010642b <vector84>:
.globl vector84
vector84:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $84
8010642d:	6a 54                	push   $0x54
  jmp alltraps
8010642f:	e9 f6 f7 ff ff       	jmp    80105c2a <alltraps>

80106434 <vector85>:
.globl vector85
vector85:
  pushl $0
80106434:	6a 00                	push   $0x0
  pushl $85
80106436:	6a 55                	push   $0x55
  jmp alltraps
80106438:	e9 ed f7 ff ff       	jmp    80105c2a <alltraps>

8010643d <vector86>:
.globl vector86
vector86:
  pushl $0
8010643d:	6a 00                	push   $0x0
  pushl $86
8010643f:	6a 56                	push   $0x56
  jmp alltraps
80106441:	e9 e4 f7 ff ff       	jmp    80105c2a <alltraps>

80106446 <vector87>:
.globl vector87
vector87:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $87
80106448:	6a 57                	push   $0x57
  jmp alltraps
8010644a:	e9 db f7 ff ff       	jmp    80105c2a <alltraps>

8010644f <vector88>:
.globl vector88
vector88:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $88
80106451:	6a 58                	push   $0x58
  jmp alltraps
80106453:	e9 d2 f7 ff ff       	jmp    80105c2a <alltraps>

80106458 <vector89>:
.globl vector89
vector89:
  pushl $0
80106458:	6a 00                	push   $0x0
  pushl $89
8010645a:	6a 59                	push   $0x59
  jmp alltraps
8010645c:	e9 c9 f7 ff ff       	jmp    80105c2a <alltraps>

80106461 <vector90>:
.globl vector90
vector90:
  pushl $0
80106461:	6a 00                	push   $0x0
  pushl $90
80106463:	6a 5a                	push   $0x5a
  jmp alltraps
80106465:	e9 c0 f7 ff ff       	jmp    80105c2a <alltraps>

8010646a <vector91>:
.globl vector91
vector91:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $91
8010646c:	6a 5b                	push   $0x5b
  jmp alltraps
8010646e:	e9 b7 f7 ff ff       	jmp    80105c2a <alltraps>

80106473 <vector92>:
.globl vector92
vector92:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $92
80106475:	6a 5c                	push   $0x5c
  jmp alltraps
80106477:	e9 ae f7 ff ff       	jmp    80105c2a <alltraps>

8010647c <vector93>:
.globl vector93
vector93:
  pushl $0
8010647c:	6a 00                	push   $0x0
  pushl $93
8010647e:	6a 5d                	push   $0x5d
  jmp alltraps
80106480:	e9 a5 f7 ff ff       	jmp    80105c2a <alltraps>

80106485 <vector94>:
.globl vector94
vector94:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $94
80106487:	6a 5e                	push   $0x5e
  jmp alltraps
80106489:	e9 9c f7 ff ff       	jmp    80105c2a <alltraps>

8010648e <vector95>:
.globl vector95
vector95:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $95
80106490:	6a 5f                	push   $0x5f
  jmp alltraps
80106492:	e9 93 f7 ff ff       	jmp    80105c2a <alltraps>

80106497 <vector96>:
.globl vector96
vector96:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $96
80106499:	6a 60                	push   $0x60
  jmp alltraps
8010649b:	e9 8a f7 ff ff       	jmp    80105c2a <alltraps>

801064a0 <vector97>:
.globl vector97
vector97:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $97
801064a2:	6a 61                	push   $0x61
  jmp alltraps
801064a4:	e9 81 f7 ff ff       	jmp    80105c2a <alltraps>

801064a9 <vector98>:
.globl vector98
vector98:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $98
801064ab:	6a 62                	push   $0x62
  jmp alltraps
801064ad:	e9 78 f7 ff ff       	jmp    80105c2a <alltraps>

801064b2 <vector99>:
.globl vector99
vector99:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $99
801064b4:	6a 63                	push   $0x63
  jmp alltraps
801064b6:	e9 6f f7 ff ff       	jmp    80105c2a <alltraps>

801064bb <vector100>:
.globl vector100
vector100:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $100
801064bd:	6a 64                	push   $0x64
  jmp alltraps
801064bf:	e9 66 f7 ff ff       	jmp    80105c2a <alltraps>

801064c4 <vector101>:
.globl vector101
vector101:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $101
801064c6:	6a 65                	push   $0x65
  jmp alltraps
801064c8:	e9 5d f7 ff ff       	jmp    80105c2a <alltraps>

801064cd <vector102>:
.globl vector102
vector102:
  pushl $0
801064cd:	6a 00                	push   $0x0
  pushl $102
801064cf:	6a 66                	push   $0x66
  jmp alltraps
801064d1:	e9 54 f7 ff ff       	jmp    80105c2a <alltraps>

801064d6 <vector103>:
.globl vector103
vector103:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $103
801064d8:	6a 67                	push   $0x67
  jmp alltraps
801064da:	e9 4b f7 ff ff       	jmp    80105c2a <alltraps>

801064df <vector104>:
.globl vector104
vector104:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $104
801064e1:	6a 68                	push   $0x68
  jmp alltraps
801064e3:	e9 42 f7 ff ff       	jmp    80105c2a <alltraps>

801064e8 <vector105>:
.globl vector105
vector105:
  pushl $0
801064e8:	6a 00                	push   $0x0
  pushl $105
801064ea:	6a 69                	push   $0x69
  jmp alltraps
801064ec:	e9 39 f7 ff ff       	jmp    80105c2a <alltraps>

801064f1 <vector106>:
.globl vector106
vector106:
  pushl $0
801064f1:	6a 00                	push   $0x0
  pushl $106
801064f3:	6a 6a                	push   $0x6a
  jmp alltraps
801064f5:	e9 30 f7 ff ff       	jmp    80105c2a <alltraps>

801064fa <vector107>:
.globl vector107
vector107:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $107
801064fc:	6a 6b                	push   $0x6b
  jmp alltraps
801064fe:	e9 27 f7 ff ff       	jmp    80105c2a <alltraps>

80106503 <vector108>:
.globl vector108
vector108:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $108
80106505:	6a 6c                	push   $0x6c
  jmp alltraps
80106507:	e9 1e f7 ff ff       	jmp    80105c2a <alltraps>

8010650c <vector109>:
.globl vector109
vector109:
  pushl $0
8010650c:	6a 00                	push   $0x0
  pushl $109
8010650e:	6a 6d                	push   $0x6d
  jmp alltraps
80106510:	e9 15 f7 ff ff       	jmp    80105c2a <alltraps>

80106515 <vector110>:
.globl vector110
vector110:
  pushl $0
80106515:	6a 00                	push   $0x0
  pushl $110
80106517:	6a 6e                	push   $0x6e
  jmp alltraps
80106519:	e9 0c f7 ff ff       	jmp    80105c2a <alltraps>

8010651e <vector111>:
.globl vector111
vector111:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $111
80106520:	6a 6f                	push   $0x6f
  jmp alltraps
80106522:	e9 03 f7 ff ff       	jmp    80105c2a <alltraps>

80106527 <vector112>:
.globl vector112
vector112:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $112
80106529:	6a 70                	push   $0x70
  jmp alltraps
8010652b:	e9 fa f6 ff ff       	jmp    80105c2a <alltraps>

80106530 <vector113>:
.globl vector113
vector113:
  pushl $0
80106530:	6a 00                	push   $0x0
  pushl $113
80106532:	6a 71                	push   $0x71
  jmp alltraps
80106534:	e9 f1 f6 ff ff       	jmp    80105c2a <alltraps>

80106539 <vector114>:
.globl vector114
vector114:
  pushl $0
80106539:	6a 00                	push   $0x0
  pushl $114
8010653b:	6a 72                	push   $0x72
  jmp alltraps
8010653d:	e9 e8 f6 ff ff       	jmp    80105c2a <alltraps>

80106542 <vector115>:
.globl vector115
vector115:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $115
80106544:	6a 73                	push   $0x73
  jmp alltraps
80106546:	e9 df f6 ff ff       	jmp    80105c2a <alltraps>

8010654b <vector116>:
.globl vector116
vector116:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $116
8010654d:	6a 74                	push   $0x74
  jmp alltraps
8010654f:	e9 d6 f6 ff ff       	jmp    80105c2a <alltraps>

80106554 <vector117>:
.globl vector117
vector117:
  pushl $0
80106554:	6a 00                	push   $0x0
  pushl $117
80106556:	6a 75                	push   $0x75
  jmp alltraps
80106558:	e9 cd f6 ff ff       	jmp    80105c2a <alltraps>

8010655d <vector118>:
.globl vector118
vector118:
  pushl $0
8010655d:	6a 00                	push   $0x0
  pushl $118
8010655f:	6a 76                	push   $0x76
  jmp alltraps
80106561:	e9 c4 f6 ff ff       	jmp    80105c2a <alltraps>

80106566 <vector119>:
.globl vector119
vector119:
  pushl $0
80106566:	6a 00                	push   $0x0
  pushl $119
80106568:	6a 77                	push   $0x77
  jmp alltraps
8010656a:	e9 bb f6 ff ff       	jmp    80105c2a <alltraps>

8010656f <vector120>:
.globl vector120
vector120:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $120
80106571:	6a 78                	push   $0x78
  jmp alltraps
80106573:	e9 b2 f6 ff ff       	jmp    80105c2a <alltraps>

80106578 <vector121>:
.globl vector121
vector121:
  pushl $0
80106578:	6a 00                	push   $0x0
  pushl $121
8010657a:	6a 79                	push   $0x79
  jmp alltraps
8010657c:	e9 a9 f6 ff ff       	jmp    80105c2a <alltraps>

80106581 <vector122>:
.globl vector122
vector122:
  pushl $0
80106581:	6a 00                	push   $0x0
  pushl $122
80106583:	6a 7a                	push   $0x7a
  jmp alltraps
80106585:	e9 a0 f6 ff ff       	jmp    80105c2a <alltraps>

8010658a <vector123>:
.globl vector123
vector123:
  pushl $0
8010658a:	6a 00                	push   $0x0
  pushl $123
8010658c:	6a 7b                	push   $0x7b
  jmp alltraps
8010658e:	e9 97 f6 ff ff       	jmp    80105c2a <alltraps>

80106593 <vector124>:
.globl vector124
vector124:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $124
80106595:	6a 7c                	push   $0x7c
  jmp alltraps
80106597:	e9 8e f6 ff ff       	jmp    80105c2a <alltraps>

8010659c <vector125>:
.globl vector125
vector125:
  pushl $0
8010659c:	6a 00                	push   $0x0
  pushl $125
8010659e:	6a 7d                	push   $0x7d
  jmp alltraps
801065a0:	e9 85 f6 ff ff       	jmp    80105c2a <alltraps>

801065a5 <vector126>:
.globl vector126
vector126:
  pushl $0
801065a5:	6a 00                	push   $0x0
  pushl $126
801065a7:	6a 7e                	push   $0x7e
  jmp alltraps
801065a9:	e9 7c f6 ff ff       	jmp    80105c2a <alltraps>

801065ae <vector127>:
.globl vector127
vector127:
  pushl $0
801065ae:	6a 00                	push   $0x0
  pushl $127
801065b0:	6a 7f                	push   $0x7f
  jmp alltraps
801065b2:	e9 73 f6 ff ff       	jmp    80105c2a <alltraps>

801065b7 <vector128>:
.globl vector128
vector128:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $128
801065b9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801065be:	e9 67 f6 ff ff       	jmp    80105c2a <alltraps>

801065c3 <vector129>:
.globl vector129
vector129:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $129
801065c5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801065ca:	e9 5b f6 ff ff       	jmp    80105c2a <alltraps>

801065cf <vector130>:
.globl vector130
vector130:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $130
801065d1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801065d6:	e9 4f f6 ff ff       	jmp    80105c2a <alltraps>

801065db <vector131>:
.globl vector131
vector131:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $131
801065dd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801065e2:	e9 43 f6 ff ff       	jmp    80105c2a <alltraps>

801065e7 <vector132>:
.globl vector132
vector132:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $132
801065e9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801065ee:	e9 37 f6 ff ff       	jmp    80105c2a <alltraps>

801065f3 <vector133>:
.globl vector133
vector133:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $133
801065f5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801065fa:	e9 2b f6 ff ff       	jmp    80105c2a <alltraps>

801065ff <vector134>:
.globl vector134
vector134:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $134
80106601:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106606:	e9 1f f6 ff ff       	jmp    80105c2a <alltraps>

8010660b <vector135>:
.globl vector135
vector135:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $135
8010660d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106612:	e9 13 f6 ff ff       	jmp    80105c2a <alltraps>

80106617 <vector136>:
.globl vector136
vector136:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $136
80106619:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010661e:	e9 07 f6 ff ff       	jmp    80105c2a <alltraps>

80106623 <vector137>:
.globl vector137
vector137:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $137
80106625:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010662a:	e9 fb f5 ff ff       	jmp    80105c2a <alltraps>

8010662f <vector138>:
.globl vector138
vector138:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $138
80106631:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106636:	e9 ef f5 ff ff       	jmp    80105c2a <alltraps>

8010663b <vector139>:
.globl vector139
vector139:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $139
8010663d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106642:	e9 e3 f5 ff ff       	jmp    80105c2a <alltraps>

80106647 <vector140>:
.globl vector140
vector140:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $140
80106649:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010664e:	e9 d7 f5 ff ff       	jmp    80105c2a <alltraps>

80106653 <vector141>:
.globl vector141
vector141:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $141
80106655:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010665a:	e9 cb f5 ff ff       	jmp    80105c2a <alltraps>

8010665f <vector142>:
.globl vector142
vector142:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $142
80106661:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106666:	e9 bf f5 ff ff       	jmp    80105c2a <alltraps>

8010666b <vector143>:
.globl vector143
vector143:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $143
8010666d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106672:	e9 b3 f5 ff ff       	jmp    80105c2a <alltraps>

80106677 <vector144>:
.globl vector144
vector144:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $144
80106679:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010667e:	e9 a7 f5 ff ff       	jmp    80105c2a <alltraps>

80106683 <vector145>:
.globl vector145
vector145:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $145
80106685:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010668a:	e9 9b f5 ff ff       	jmp    80105c2a <alltraps>

8010668f <vector146>:
.globl vector146
vector146:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $146
80106691:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106696:	e9 8f f5 ff ff       	jmp    80105c2a <alltraps>

8010669b <vector147>:
.globl vector147
vector147:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $147
8010669d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801066a2:	e9 83 f5 ff ff       	jmp    80105c2a <alltraps>

801066a7 <vector148>:
.globl vector148
vector148:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $148
801066a9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801066ae:	e9 77 f5 ff ff       	jmp    80105c2a <alltraps>

801066b3 <vector149>:
.globl vector149
vector149:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $149
801066b5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801066ba:	e9 6b f5 ff ff       	jmp    80105c2a <alltraps>

801066bf <vector150>:
.globl vector150
vector150:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $150
801066c1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801066c6:	e9 5f f5 ff ff       	jmp    80105c2a <alltraps>

801066cb <vector151>:
.globl vector151
vector151:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $151
801066cd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801066d2:	e9 53 f5 ff ff       	jmp    80105c2a <alltraps>

801066d7 <vector152>:
.globl vector152
vector152:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $152
801066d9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801066de:	e9 47 f5 ff ff       	jmp    80105c2a <alltraps>

801066e3 <vector153>:
.globl vector153
vector153:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $153
801066e5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801066ea:	e9 3b f5 ff ff       	jmp    80105c2a <alltraps>

801066ef <vector154>:
.globl vector154
vector154:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $154
801066f1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801066f6:	e9 2f f5 ff ff       	jmp    80105c2a <alltraps>

801066fb <vector155>:
.globl vector155
vector155:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $155
801066fd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106702:	e9 23 f5 ff ff       	jmp    80105c2a <alltraps>

80106707 <vector156>:
.globl vector156
vector156:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $156
80106709:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010670e:	e9 17 f5 ff ff       	jmp    80105c2a <alltraps>

80106713 <vector157>:
.globl vector157
vector157:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $157
80106715:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010671a:	e9 0b f5 ff ff       	jmp    80105c2a <alltraps>

8010671f <vector158>:
.globl vector158
vector158:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $158
80106721:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106726:	e9 ff f4 ff ff       	jmp    80105c2a <alltraps>

8010672b <vector159>:
.globl vector159
vector159:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $159
8010672d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106732:	e9 f3 f4 ff ff       	jmp    80105c2a <alltraps>

80106737 <vector160>:
.globl vector160
vector160:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $160
80106739:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010673e:	e9 e7 f4 ff ff       	jmp    80105c2a <alltraps>

80106743 <vector161>:
.globl vector161
vector161:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $161
80106745:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010674a:	e9 db f4 ff ff       	jmp    80105c2a <alltraps>

8010674f <vector162>:
.globl vector162
vector162:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $162
80106751:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106756:	e9 cf f4 ff ff       	jmp    80105c2a <alltraps>

8010675b <vector163>:
.globl vector163
vector163:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $163
8010675d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106762:	e9 c3 f4 ff ff       	jmp    80105c2a <alltraps>

80106767 <vector164>:
.globl vector164
vector164:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $164
80106769:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010676e:	e9 b7 f4 ff ff       	jmp    80105c2a <alltraps>

80106773 <vector165>:
.globl vector165
vector165:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $165
80106775:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010677a:	e9 ab f4 ff ff       	jmp    80105c2a <alltraps>

8010677f <vector166>:
.globl vector166
vector166:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $166
80106781:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106786:	e9 9f f4 ff ff       	jmp    80105c2a <alltraps>

8010678b <vector167>:
.globl vector167
vector167:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $167
8010678d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106792:	e9 93 f4 ff ff       	jmp    80105c2a <alltraps>

80106797 <vector168>:
.globl vector168
vector168:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $168
80106799:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010679e:	e9 87 f4 ff ff       	jmp    80105c2a <alltraps>

801067a3 <vector169>:
.globl vector169
vector169:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $169
801067a5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801067aa:	e9 7b f4 ff ff       	jmp    80105c2a <alltraps>

801067af <vector170>:
.globl vector170
vector170:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $170
801067b1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801067b6:	e9 6f f4 ff ff       	jmp    80105c2a <alltraps>

801067bb <vector171>:
.globl vector171
vector171:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $171
801067bd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801067c2:	e9 63 f4 ff ff       	jmp    80105c2a <alltraps>

801067c7 <vector172>:
.globl vector172
vector172:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $172
801067c9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801067ce:	e9 57 f4 ff ff       	jmp    80105c2a <alltraps>

801067d3 <vector173>:
.globl vector173
vector173:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $173
801067d5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801067da:	e9 4b f4 ff ff       	jmp    80105c2a <alltraps>

801067df <vector174>:
.globl vector174
vector174:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $174
801067e1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801067e6:	e9 3f f4 ff ff       	jmp    80105c2a <alltraps>

801067eb <vector175>:
.globl vector175
vector175:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $175
801067ed:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801067f2:	e9 33 f4 ff ff       	jmp    80105c2a <alltraps>

801067f7 <vector176>:
.globl vector176
vector176:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $176
801067f9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801067fe:	e9 27 f4 ff ff       	jmp    80105c2a <alltraps>

80106803 <vector177>:
.globl vector177
vector177:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $177
80106805:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010680a:	e9 1b f4 ff ff       	jmp    80105c2a <alltraps>

8010680f <vector178>:
.globl vector178
vector178:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $178
80106811:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106816:	e9 0f f4 ff ff       	jmp    80105c2a <alltraps>

8010681b <vector179>:
.globl vector179
vector179:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $179
8010681d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106822:	e9 03 f4 ff ff       	jmp    80105c2a <alltraps>

80106827 <vector180>:
.globl vector180
vector180:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $180
80106829:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010682e:	e9 f7 f3 ff ff       	jmp    80105c2a <alltraps>

80106833 <vector181>:
.globl vector181
vector181:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $181
80106835:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010683a:	e9 eb f3 ff ff       	jmp    80105c2a <alltraps>

8010683f <vector182>:
.globl vector182
vector182:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $182
80106841:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106846:	e9 df f3 ff ff       	jmp    80105c2a <alltraps>

8010684b <vector183>:
.globl vector183
vector183:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $183
8010684d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106852:	e9 d3 f3 ff ff       	jmp    80105c2a <alltraps>

80106857 <vector184>:
.globl vector184
vector184:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $184
80106859:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010685e:	e9 c7 f3 ff ff       	jmp    80105c2a <alltraps>

80106863 <vector185>:
.globl vector185
vector185:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $185
80106865:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010686a:	e9 bb f3 ff ff       	jmp    80105c2a <alltraps>

8010686f <vector186>:
.globl vector186
vector186:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $186
80106871:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106876:	e9 af f3 ff ff       	jmp    80105c2a <alltraps>

8010687b <vector187>:
.globl vector187
vector187:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $187
8010687d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106882:	e9 a3 f3 ff ff       	jmp    80105c2a <alltraps>

80106887 <vector188>:
.globl vector188
vector188:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $188
80106889:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010688e:	e9 97 f3 ff ff       	jmp    80105c2a <alltraps>

80106893 <vector189>:
.globl vector189
vector189:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $189
80106895:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010689a:	e9 8b f3 ff ff       	jmp    80105c2a <alltraps>

8010689f <vector190>:
.globl vector190
vector190:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $190
801068a1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801068a6:	e9 7f f3 ff ff       	jmp    80105c2a <alltraps>

801068ab <vector191>:
.globl vector191
vector191:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $191
801068ad:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801068b2:	e9 73 f3 ff ff       	jmp    80105c2a <alltraps>

801068b7 <vector192>:
.globl vector192
vector192:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $192
801068b9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801068be:	e9 67 f3 ff ff       	jmp    80105c2a <alltraps>

801068c3 <vector193>:
.globl vector193
vector193:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $193
801068c5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801068ca:	e9 5b f3 ff ff       	jmp    80105c2a <alltraps>

801068cf <vector194>:
.globl vector194
vector194:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $194
801068d1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801068d6:	e9 4f f3 ff ff       	jmp    80105c2a <alltraps>

801068db <vector195>:
.globl vector195
vector195:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $195
801068dd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801068e2:	e9 43 f3 ff ff       	jmp    80105c2a <alltraps>

801068e7 <vector196>:
.globl vector196
vector196:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $196
801068e9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801068ee:	e9 37 f3 ff ff       	jmp    80105c2a <alltraps>

801068f3 <vector197>:
.globl vector197
vector197:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $197
801068f5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801068fa:	e9 2b f3 ff ff       	jmp    80105c2a <alltraps>

801068ff <vector198>:
.globl vector198
vector198:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $198
80106901:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106906:	e9 1f f3 ff ff       	jmp    80105c2a <alltraps>

8010690b <vector199>:
.globl vector199
vector199:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $199
8010690d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106912:	e9 13 f3 ff ff       	jmp    80105c2a <alltraps>

80106917 <vector200>:
.globl vector200
vector200:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $200
80106919:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010691e:	e9 07 f3 ff ff       	jmp    80105c2a <alltraps>

80106923 <vector201>:
.globl vector201
vector201:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $201
80106925:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010692a:	e9 fb f2 ff ff       	jmp    80105c2a <alltraps>

8010692f <vector202>:
.globl vector202
vector202:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $202
80106931:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106936:	e9 ef f2 ff ff       	jmp    80105c2a <alltraps>

8010693b <vector203>:
.globl vector203
vector203:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $203
8010693d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106942:	e9 e3 f2 ff ff       	jmp    80105c2a <alltraps>

80106947 <vector204>:
.globl vector204
vector204:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $204
80106949:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010694e:	e9 d7 f2 ff ff       	jmp    80105c2a <alltraps>

80106953 <vector205>:
.globl vector205
vector205:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $205
80106955:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010695a:	e9 cb f2 ff ff       	jmp    80105c2a <alltraps>

8010695f <vector206>:
.globl vector206
vector206:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $206
80106961:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106966:	e9 bf f2 ff ff       	jmp    80105c2a <alltraps>

8010696b <vector207>:
.globl vector207
vector207:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $207
8010696d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106972:	e9 b3 f2 ff ff       	jmp    80105c2a <alltraps>

80106977 <vector208>:
.globl vector208
vector208:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $208
80106979:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010697e:	e9 a7 f2 ff ff       	jmp    80105c2a <alltraps>

80106983 <vector209>:
.globl vector209
vector209:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $209
80106985:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010698a:	e9 9b f2 ff ff       	jmp    80105c2a <alltraps>

8010698f <vector210>:
.globl vector210
vector210:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $210
80106991:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106996:	e9 8f f2 ff ff       	jmp    80105c2a <alltraps>

8010699b <vector211>:
.globl vector211
vector211:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $211
8010699d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801069a2:	e9 83 f2 ff ff       	jmp    80105c2a <alltraps>

801069a7 <vector212>:
.globl vector212
vector212:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $212
801069a9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801069ae:	e9 77 f2 ff ff       	jmp    80105c2a <alltraps>

801069b3 <vector213>:
.globl vector213
vector213:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $213
801069b5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801069ba:	e9 6b f2 ff ff       	jmp    80105c2a <alltraps>

801069bf <vector214>:
.globl vector214
vector214:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $214
801069c1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801069c6:	e9 5f f2 ff ff       	jmp    80105c2a <alltraps>

801069cb <vector215>:
.globl vector215
vector215:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $215
801069cd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801069d2:	e9 53 f2 ff ff       	jmp    80105c2a <alltraps>

801069d7 <vector216>:
.globl vector216
vector216:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $216
801069d9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801069de:	e9 47 f2 ff ff       	jmp    80105c2a <alltraps>

801069e3 <vector217>:
.globl vector217
vector217:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $217
801069e5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801069ea:	e9 3b f2 ff ff       	jmp    80105c2a <alltraps>

801069ef <vector218>:
.globl vector218
vector218:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $218
801069f1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801069f6:	e9 2f f2 ff ff       	jmp    80105c2a <alltraps>

801069fb <vector219>:
.globl vector219
vector219:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $219
801069fd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106a02:	e9 23 f2 ff ff       	jmp    80105c2a <alltraps>

80106a07 <vector220>:
.globl vector220
vector220:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $220
80106a09:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106a0e:	e9 17 f2 ff ff       	jmp    80105c2a <alltraps>

80106a13 <vector221>:
.globl vector221
vector221:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $221
80106a15:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106a1a:	e9 0b f2 ff ff       	jmp    80105c2a <alltraps>

80106a1f <vector222>:
.globl vector222
vector222:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $222
80106a21:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106a26:	e9 ff f1 ff ff       	jmp    80105c2a <alltraps>

80106a2b <vector223>:
.globl vector223
vector223:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $223
80106a2d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106a32:	e9 f3 f1 ff ff       	jmp    80105c2a <alltraps>

80106a37 <vector224>:
.globl vector224
vector224:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $224
80106a39:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106a3e:	e9 e7 f1 ff ff       	jmp    80105c2a <alltraps>

80106a43 <vector225>:
.globl vector225
vector225:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $225
80106a45:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106a4a:	e9 db f1 ff ff       	jmp    80105c2a <alltraps>

80106a4f <vector226>:
.globl vector226
vector226:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $226
80106a51:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106a56:	e9 cf f1 ff ff       	jmp    80105c2a <alltraps>

80106a5b <vector227>:
.globl vector227
vector227:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $227
80106a5d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106a62:	e9 c3 f1 ff ff       	jmp    80105c2a <alltraps>

80106a67 <vector228>:
.globl vector228
vector228:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $228
80106a69:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106a6e:	e9 b7 f1 ff ff       	jmp    80105c2a <alltraps>

80106a73 <vector229>:
.globl vector229
vector229:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $229
80106a75:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106a7a:	e9 ab f1 ff ff       	jmp    80105c2a <alltraps>

80106a7f <vector230>:
.globl vector230
vector230:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $230
80106a81:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106a86:	e9 9f f1 ff ff       	jmp    80105c2a <alltraps>

80106a8b <vector231>:
.globl vector231
vector231:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $231
80106a8d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106a92:	e9 93 f1 ff ff       	jmp    80105c2a <alltraps>

80106a97 <vector232>:
.globl vector232
vector232:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $232
80106a99:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106a9e:	e9 87 f1 ff ff       	jmp    80105c2a <alltraps>

80106aa3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $233
80106aa5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106aaa:	e9 7b f1 ff ff       	jmp    80105c2a <alltraps>

80106aaf <vector234>:
.globl vector234
vector234:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $234
80106ab1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106ab6:	e9 6f f1 ff ff       	jmp    80105c2a <alltraps>

80106abb <vector235>:
.globl vector235
vector235:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $235
80106abd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106ac2:	e9 63 f1 ff ff       	jmp    80105c2a <alltraps>

80106ac7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $236
80106ac9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106ace:	e9 57 f1 ff ff       	jmp    80105c2a <alltraps>

80106ad3 <vector237>:
.globl vector237
vector237:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $237
80106ad5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106ada:	e9 4b f1 ff ff       	jmp    80105c2a <alltraps>

80106adf <vector238>:
.globl vector238
vector238:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $238
80106ae1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106ae6:	e9 3f f1 ff ff       	jmp    80105c2a <alltraps>

80106aeb <vector239>:
.globl vector239
vector239:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $239
80106aed:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106af2:	e9 33 f1 ff ff       	jmp    80105c2a <alltraps>

80106af7 <vector240>:
.globl vector240
vector240:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $240
80106af9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106afe:	e9 27 f1 ff ff       	jmp    80105c2a <alltraps>

80106b03 <vector241>:
.globl vector241
vector241:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $241
80106b05:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106b0a:	e9 1b f1 ff ff       	jmp    80105c2a <alltraps>

80106b0f <vector242>:
.globl vector242
vector242:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $242
80106b11:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106b16:	e9 0f f1 ff ff       	jmp    80105c2a <alltraps>

80106b1b <vector243>:
.globl vector243
vector243:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $243
80106b1d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106b22:	e9 03 f1 ff ff       	jmp    80105c2a <alltraps>

80106b27 <vector244>:
.globl vector244
vector244:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $244
80106b29:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106b2e:	e9 f7 f0 ff ff       	jmp    80105c2a <alltraps>

80106b33 <vector245>:
.globl vector245
vector245:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $245
80106b35:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106b3a:	e9 eb f0 ff ff       	jmp    80105c2a <alltraps>

80106b3f <vector246>:
.globl vector246
vector246:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $246
80106b41:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106b46:	e9 df f0 ff ff       	jmp    80105c2a <alltraps>

80106b4b <vector247>:
.globl vector247
vector247:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $247
80106b4d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106b52:	e9 d3 f0 ff ff       	jmp    80105c2a <alltraps>

80106b57 <vector248>:
.globl vector248
vector248:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $248
80106b59:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106b5e:	e9 c7 f0 ff ff       	jmp    80105c2a <alltraps>

80106b63 <vector249>:
.globl vector249
vector249:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $249
80106b65:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106b6a:	e9 bb f0 ff ff       	jmp    80105c2a <alltraps>

80106b6f <vector250>:
.globl vector250
vector250:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $250
80106b71:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106b76:	e9 af f0 ff ff       	jmp    80105c2a <alltraps>

80106b7b <vector251>:
.globl vector251
vector251:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $251
80106b7d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106b82:	e9 a3 f0 ff ff       	jmp    80105c2a <alltraps>

80106b87 <vector252>:
.globl vector252
vector252:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $252
80106b89:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106b8e:	e9 97 f0 ff ff       	jmp    80105c2a <alltraps>

80106b93 <vector253>:
.globl vector253
vector253:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $253
80106b95:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106b9a:	e9 8b f0 ff ff       	jmp    80105c2a <alltraps>

80106b9f <vector254>:
.globl vector254
vector254:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $254
80106ba1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ba6:	e9 7f f0 ff ff       	jmp    80105c2a <alltraps>

80106bab <vector255>:
.globl vector255
vector255:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $255
80106bad:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106bb2:	e9 73 f0 ff ff       	jmp    80105c2a <alltraps>
80106bb7:	66 90                	xchg   %ax,%ax
80106bb9:	66 90                	xchg   %ax,%ax
80106bbb:	66 90                	xchg   %ax,%ax
80106bbd:	66 90                	xchg   %ax,%ax
80106bbf:	90                   	nop

80106bc0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106bc0:	55                   	push   %ebp
80106bc1:	89 e5                	mov    %esp,%ebp
80106bc3:	57                   	push   %edi
80106bc4:	56                   	push   %esi
80106bc5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106bc6:	89 d3                	mov    %edx,%ebx
{
80106bc8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106bca:	c1 eb 16             	shr    $0x16,%ebx
80106bcd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106bd0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106bd3:	8b 06                	mov    (%esi),%eax
80106bd5:	a8 01                	test   $0x1,%al
80106bd7:	74 27                	je     80106c00 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106bd9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106bde:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106be4:	c1 ef 0a             	shr    $0xa,%edi
}
80106be7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106bea:	89 fa                	mov    %edi,%edx
80106bec:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106bf2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106bf5:	5b                   	pop    %ebx
80106bf6:	5e                   	pop    %esi
80106bf7:	5f                   	pop    %edi
80106bf8:	5d                   	pop    %ebp
80106bf9:	c3                   	ret    
80106bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106c00:	85 c9                	test   %ecx,%ecx
80106c02:	74 2c                	je     80106c30 <walkpgdir+0x70>
80106c04:	e8 c7 bc ff ff       	call   801028d0 <kalloc>
80106c09:	85 c0                	test   %eax,%eax
80106c0b:	89 c3                	mov    %eax,%ebx
80106c0d:	74 21                	je     80106c30 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106c0f:	83 ec 04             	sub    $0x4,%esp
80106c12:	68 00 10 00 00       	push   $0x1000
80106c17:	6a 00                	push   $0x0
80106c19:	50                   	push   %eax
80106c1a:	e8 f1 dd ff ff       	call   80104a10 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106c1f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c25:	83 c4 10             	add    $0x10,%esp
80106c28:	83 c8 07             	or     $0x7,%eax
80106c2b:	89 06                	mov    %eax,(%esi)
80106c2d:	eb b5                	jmp    80106be4 <walkpgdir+0x24>
80106c2f:	90                   	nop
}
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106c33:	31 c0                	xor    %eax,%eax
}
80106c35:	5b                   	pop    %ebx
80106c36:	5e                   	pop    %esi
80106c37:	5f                   	pop    %edi
80106c38:	5d                   	pop    %ebp
80106c39:	c3                   	ret    
80106c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106c46:	89 d3                	mov    %edx,%ebx
80106c48:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106c4e:	83 ec 1c             	sub    $0x1c,%esp
80106c51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106c54:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106c58:	8b 7d 08             	mov    0x8(%ebp),%edi
80106c5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106c60:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106c63:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c66:	29 df                	sub    %ebx,%edi
80106c68:	83 c8 01             	or     $0x1,%eax
80106c6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106c6e:	eb 15                	jmp    80106c85 <mappages+0x45>
    if(*pte & PTE_P)
80106c70:	f6 00 01             	testb  $0x1,(%eax)
80106c73:	75 45                	jne    80106cba <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106c75:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106c78:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106c7b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106c7d:	74 31                	je     80106cb0 <mappages+0x70>
      break;
    a += PGSIZE;
80106c7f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106c85:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c88:	b9 01 00 00 00       	mov    $0x1,%ecx
80106c8d:	89 da                	mov    %ebx,%edx
80106c8f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106c92:	e8 29 ff ff ff       	call   80106bc0 <walkpgdir>
80106c97:	85 c0                	test   %eax,%eax
80106c99:	75 d5                	jne    80106c70 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106c9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106c9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ca3:	5b                   	pop    %ebx
80106ca4:	5e                   	pop    %esi
80106ca5:	5f                   	pop    %edi
80106ca6:	5d                   	pop    %ebp
80106ca7:	c3                   	ret    
80106ca8:	90                   	nop
80106ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cb3:	31 c0                	xor    %eax,%eax
}
80106cb5:	5b                   	pop    %ebx
80106cb6:	5e                   	pop    %esi
80106cb7:	5f                   	pop    %edi
80106cb8:	5d                   	pop    %ebp
80106cb9:	c3                   	ret    
      panic("remap");
80106cba:	83 ec 0c             	sub    $0xc,%esp
80106cbd:	68 9c 84 10 80       	push   $0x8010849c
80106cc2:	e8 c9 96 ff ff       	call   80100390 <panic>
80106cc7:	89 f6                	mov    %esi,%esi
80106cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106cd0 <seginit>:
{
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106cd6:	e8 55 cf ff ff       	call   80103c30 <cpuid>
80106cdb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80106ce1:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106ce6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106cea:	c7 80 f8 37 11 80 ff 	movl   $0xffff,-0x7feec808(%eax)
80106cf1:	ff 00 00 
80106cf4:	c7 80 fc 37 11 80 00 	movl   $0xcf9a00,-0x7feec804(%eax)
80106cfb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106cfe:	c7 80 00 38 11 80 ff 	movl   $0xffff,-0x7feec800(%eax)
80106d05:	ff 00 00 
80106d08:	c7 80 04 38 11 80 00 	movl   $0xcf9200,-0x7feec7fc(%eax)
80106d0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106d12:	c7 80 08 38 11 80 ff 	movl   $0xffff,-0x7feec7f8(%eax)
80106d19:	ff 00 00 
80106d1c:	c7 80 0c 38 11 80 00 	movl   $0xcffa00,-0x7feec7f4(%eax)
80106d23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106d26:	c7 80 10 38 11 80 ff 	movl   $0xffff,-0x7feec7f0(%eax)
80106d2d:	ff 00 00 
80106d30:	c7 80 14 38 11 80 00 	movl   $0xcff200,-0x7feec7ec(%eax)
80106d37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106d3a:	05 f0 37 11 80       	add    $0x801137f0,%eax
  pd[1] = (uint)p;
80106d3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106d43:	c1 e8 10             	shr    $0x10,%eax
80106d46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106d4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106d4d:	0f 01 10             	lgdtl  (%eax)
}
80106d50:	c9                   	leave  
80106d51:	c3                   	ret    
80106d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d60 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d60:	a1 a4 a8 11 80       	mov    0x8011a8a4,%eax
{
80106d65:	55                   	push   %ebp
80106d66:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106d68:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d6d:	0f 22 d8             	mov    %eax,%cr3
}
80106d70:	5d                   	pop    %ebp
80106d71:	c3                   	ret    
80106d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d80 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	57                   	push   %edi
80106d84:	56                   	push   %esi
80106d85:	53                   	push   %ebx
80106d86:	83 ec 1c             	sub    $0x1c,%esp
80106d89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106d8c:	85 db                	test   %ebx,%ebx
80106d8e:	0f 84 cb 00 00 00    	je     80106e5f <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106d94:	8b 43 08             	mov    0x8(%ebx),%eax
80106d97:	85 c0                	test   %eax,%eax
80106d99:	0f 84 da 00 00 00    	je     80106e79 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106d9f:	8b 43 04             	mov    0x4(%ebx),%eax
80106da2:	85 c0                	test   %eax,%eax
80106da4:	0f 84 c2 00 00 00    	je     80106e6c <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
80106daa:	e8 81 da ff ff       	call   80104830 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106daf:	e8 fc cd ff ff       	call   80103bb0 <mycpu>
80106db4:	89 c6                	mov    %eax,%esi
80106db6:	e8 f5 cd ff ff       	call   80103bb0 <mycpu>
80106dbb:	89 c7                	mov    %eax,%edi
80106dbd:	e8 ee cd ff ff       	call   80103bb0 <mycpu>
80106dc2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106dc5:	83 c7 08             	add    $0x8,%edi
80106dc8:	e8 e3 cd ff ff       	call   80103bb0 <mycpu>
80106dcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106dd0:	83 c0 08             	add    $0x8,%eax
80106dd3:	ba 67 00 00 00       	mov    $0x67,%edx
80106dd8:	c1 e8 18             	shr    $0x18,%eax
80106ddb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80106de2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80106de9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106def:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106df4:	83 c1 08             	add    $0x8,%ecx
80106df7:	c1 e9 10             	shr    $0x10,%ecx
80106dfa:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80106e00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106e05:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106e0c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80106e11:	e8 9a cd ff ff       	call   80103bb0 <mycpu>
80106e16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106e1d:	e8 8e cd ff ff       	call   80103bb0 <mycpu>
80106e22:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106e26:	8b 73 08             	mov    0x8(%ebx),%esi
80106e29:	e8 82 cd ff ff       	call   80103bb0 <mycpu>
80106e2e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106e34:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106e37:	e8 74 cd ff ff       	call   80103bb0 <mycpu>
80106e3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106e40:	b8 28 00 00 00       	mov    $0x28,%eax
80106e45:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106e48:	8b 43 04             	mov    0x4(%ebx),%eax
80106e4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106e50:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106e53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e56:	5b                   	pop    %ebx
80106e57:	5e                   	pop    %esi
80106e58:	5f                   	pop    %edi
80106e59:	5d                   	pop    %ebp
  popcli();
80106e5a:	e9 11 da ff ff       	jmp    80104870 <popcli>
    panic("switchuvm: no process");
80106e5f:	83 ec 0c             	sub    $0xc,%esp
80106e62:	68 a2 84 10 80       	push   $0x801084a2
80106e67:	e8 24 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80106e6c:	83 ec 0c             	sub    $0xc,%esp
80106e6f:	68 cd 84 10 80       	push   $0x801084cd
80106e74:	e8 17 95 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80106e79:	83 ec 0c             	sub    $0xc,%esp
80106e7c:	68 b8 84 10 80       	push   $0x801084b8
80106e81:	e8 0a 95 ff ff       	call   80100390 <panic>
80106e86:	8d 76 00             	lea    0x0(%esi),%esi
80106e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e90 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	57                   	push   %edi
80106e94:	56                   	push   %esi
80106e95:	53                   	push   %ebx
80106e96:	83 ec 1c             	sub    $0x1c,%esp
80106e99:	8b 75 10             	mov    0x10(%ebp),%esi
80106e9c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106ea2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106ea8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106eab:	77 49                	ja     80106ef6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106ead:	e8 1e ba ff ff       	call   801028d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106eb2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80106eb5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106eb7:	68 00 10 00 00       	push   $0x1000
80106ebc:	6a 00                	push   $0x0
80106ebe:	50                   	push   %eax
80106ebf:	e8 4c db ff ff       	call   80104a10 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106ec4:	58                   	pop    %eax
80106ec5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ecb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ed0:	5a                   	pop    %edx
80106ed1:	6a 06                	push   $0x6
80106ed3:	50                   	push   %eax
80106ed4:	31 d2                	xor    %edx,%edx
80106ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106ed9:	e8 62 fd ff ff       	call   80106c40 <mappages>
  memmove(mem, init, sz);
80106ede:	89 75 10             	mov    %esi,0x10(%ebp)
80106ee1:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106ee4:	83 c4 10             	add    $0x10,%esp
80106ee7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106eea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106eed:	5b                   	pop    %ebx
80106eee:	5e                   	pop    %esi
80106eef:	5f                   	pop    %edi
80106ef0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106ef1:	e9 ca db ff ff       	jmp    80104ac0 <memmove>
    panic("inituvm: more than a page");
80106ef6:	83 ec 0c             	sub    $0xc,%esp
80106ef9:	68 e1 84 10 80       	push   $0x801084e1
80106efe:	e8 8d 94 ff ff       	call   80100390 <panic>
80106f03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106f10 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	57                   	push   %edi
80106f14:	56                   	push   %esi
80106f15:	53                   	push   %ebx
80106f16:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106f19:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106f20:	0f 85 91 00 00 00    	jne    80106fb7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106f26:	8b 75 18             	mov    0x18(%ebp),%esi
80106f29:	31 db                	xor    %ebx,%ebx
80106f2b:	85 f6                	test   %esi,%esi
80106f2d:	75 1a                	jne    80106f49 <loaduvm+0x39>
80106f2f:	eb 6f                	jmp    80106fa0 <loaduvm+0x90>
80106f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f38:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f3e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106f44:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106f47:	76 57                	jbe    80106fa0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106f49:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f4c:	8b 45 08             	mov    0x8(%ebp),%eax
80106f4f:	31 c9                	xor    %ecx,%ecx
80106f51:	01 da                	add    %ebx,%edx
80106f53:	e8 68 fc ff ff       	call   80106bc0 <walkpgdir>
80106f58:	85 c0                	test   %eax,%eax
80106f5a:	74 4e                	je     80106faa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106f5c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f5e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80106f61:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80106f66:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106f6b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106f71:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106f74:	01 d9                	add    %ebx,%ecx
80106f76:	05 00 00 00 80       	add    $0x80000000,%eax
80106f7b:	57                   	push   %edi
80106f7c:	51                   	push   %ecx
80106f7d:	50                   	push   %eax
80106f7e:	ff 75 10             	pushl  0x10(%ebp)
80106f81:	e8 5a aa ff ff       	call   801019e0 <readi>
80106f86:	83 c4 10             	add    $0x10,%esp
80106f89:	39 f8                	cmp    %edi,%eax
80106f8b:	74 ab                	je     80106f38 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106f8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f95:	5b                   	pop    %ebx
80106f96:	5e                   	pop    %esi
80106f97:	5f                   	pop    %edi
80106f98:	5d                   	pop    %ebp
80106f99:	c3                   	ret    
80106f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fa0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106fa3:	31 c0                	xor    %eax,%eax
}
80106fa5:	5b                   	pop    %ebx
80106fa6:	5e                   	pop    %esi
80106fa7:	5f                   	pop    %edi
80106fa8:	5d                   	pop    %ebp
80106fa9:	c3                   	ret    
      panic("loaduvm: address should exist");
80106faa:	83 ec 0c             	sub    $0xc,%esp
80106fad:	68 fb 84 10 80       	push   $0x801084fb
80106fb2:	e8 d9 93 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80106fb7:	83 ec 0c             	sub    $0xc,%esp
80106fba:	68 54 86 10 80       	push   $0x80108654
80106fbf:	e8 cc 93 ff ff       	call   80100390 <panic>
80106fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106fd0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106fd0:	55                   	push   %ebp
80106fd1:	89 e5                	mov    %esp,%ebp
80106fd3:	57                   	push   %edi
80106fd4:	56                   	push   %esi
80106fd5:	53                   	push   %ebx
80106fd6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80106fd9:	e8 72 cc ff ff       	call   80103c50 <myproc>
80106fde:	89 45 e0             	mov    %eax,-0x20(%ebp)
  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz)
80106fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fe4:	39 45 10             	cmp    %eax,0x10(%ebp)
80106fe7:	0f 83 11 01 00 00    	jae    801070fe <deallocuvm+0x12e>
    return oldsz;

  a = PGROUNDUP(newsz);
80106fed:	8b 45 10             	mov    0x10(%ebp),%eax
80106ff0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106ff6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106ffc:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106fff:	77 57                	ja     80107058 <deallocuvm+0x88>
80107001:	e9 f5 00 00 00       	jmp    801070fb <deallocuvm+0x12b>
80107006:	8d 76 00             	lea    0x0(%esi),%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107010:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107015:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107018:	0f 84 c3 01 00 00    	je     801071e1 <deallocuvm+0x211>
        panic("kfree");

      //
      int i;
      if(myproc()->pgdir == pgdir){
8010701e:	e8 2d cc ff ff       	call   80103c50 <myproc>
80107023:	8b 55 08             	mov    0x8(%ebp),%edx
80107026:	39 50 04             	cmp    %edx,0x4(%eax)
80107029:	0f 84 e1 00 00 00    	je     80107110 <deallocuvm+0x140>
              break;
            }
        }
      }

      char *v = P2V(pa);
8010702f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      kfree(v);
80107032:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107035:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010703a:	50                   	push   %eax
8010703b:	e8 e0 b6 ff ff       	call   80102720 <kfree>

      *pte = 0;
80107040:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80107046:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107049:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010704f:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80107052:	0f 86 a3 00 00 00    	jbe    801070fb <deallocuvm+0x12b>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107058:	8b 45 08             	mov    0x8(%ebp),%eax
8010705b:	31 c9                	xor    %ecx,%ecx
8010705d:	89 da                	mov    %ebx,%edx
8010705f:	e8 5c fb ff ff       	call   80106bc0 <walkpgdir>
    if(!pte)
80107064:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
80107066:	89 c6                	mov    %eax,%esi
    if(!pte)
80107068:	74 76                	je     801070e0 <deallocuvm+0x110>
    else if((*pte & PTE_P) != 0){
8010706a:	8b 00                	mov    (%eax),%eax
8010706c:	a8 01                	test   $0x1,%al
8010706e:	75 a0                	jne    80107010 <deallocuvm+0x40>
    }else if(*pte & PTE_PG && myproc()->pgdir == pgdir){//
80107070:	f6 c4 02             	test   $0x2,%ah
80107073:	74 d4                	je     80107049 <deallocuvm+0x79>
80107075:	e8 d6 cb ff ff       	call   80103c50 <myproc>
8010707a:	8b 55 08             	mov    0x8(%ebp),%edx
8010707d:	39 50 04             	cmp    %edx,0x4(%eax)
80107080:	75 c7                	jne    80107049 <deallocuvm+0x79>
        int i;
        for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107082:	31 f6                	xor    %esi,%esi
80107084:	eb 16                	jmp    8010709c <deallocuvm+0xcc>
80107086:	8d 76 00             	lea    0x0(%esi),%esi
80107089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107090:	83 c6 01             	add    $0x1,%esi
          if(i==MAX_PSYC_PAGES){
80107093:	83 fe 10             	cmp    $0x10,%esi
80107096:	0f 84 38 01 00 00    	je     801071d4 <deallocuvm+0x204>
            panic("deallocuvm: cant find page2");
          }
          if(myproc()->swappedPGs[i].va == (char*)a){
8010709c:	e8 af cb ff ff       	call   80103c50 <myproc>
801070a1:	8d 56 20             	lea    0x20(%esi),%edx
801070a4:	3b 5c 90 0c          	cmp    0xc(%eax,%edx,4),%ebx
801070a8:	75 e6                	jne    80107090 <deallocuvm+0xc0>
            cprintf("cleaned2\n");
801070aa:	83 ec 0c             	sub    $0xc,%esp
801070ad:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801070b0:	68 5e 85 10 80       	push   $0x8010855e
801070b5:	e8 a6 95 ff ff       	call   80100660 <cprintf>
            myproc()->swappedPGs[i].va = (char*) 0xffffffff;
801070ba:	e8 91 cb ff ff       	call   80103c50 <myproc>
801070bf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070c2:	c7 44 90 0c ff ff ff 	movl   $0xffffffff,0xc(%eax,%edx,4)
801070c9:	ff 
            myproc()->nPgsSwap--;
801070ca:	e8 81 cb ff ff       	call   80103c50 <myproc>
            break;
801070cf:	83 c4 10             	add    $0x10,%esp
            myproc()->nPgsSwap--;
801070d2:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
            break;
801070d9:	e9 6b ff ff ff       	jmp    80107049 <deallocuvm+0x79>
801070de:	66 90                	xchg   %ax,%ax
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801070e0:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801070e6:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801070ec:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070f2:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801070f5:	0f 87 5d ff ff ff    	ja     80107058 <deallocuvm+0x88>
          }
        }
      }//
  }
  return newsz;
801070fb:	8b 45 10             	mov    0x10(%ebp),%eax
}
801070fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107101:	5b                   	pop    %ebx
80107102:	5e                   	pop    %esi
80107103:	5f                   	pop    %edi
80107104:	5d                   	pop    %ebp
80107105:	c3                   	ret    
80107106:	8d 76 00             	lea    0x0(%esi),%esi
80107109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107110:	31 ff                	xor    %edi,%edi
80107112:	eb 0c                	jmp    80107120 <deallocuvm+0x150>
80107114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107118:	83 c7 01             	add    $0x1,%edi
            if(i==MAX_PSYC_PAGES){
8010711b:	83 ff 10             	cmp    $0x10,%edi
8010711e:	74 70                	je     80107190 <deallocuvm+0x1c0>
            if(myproc()->physicalPGs[i].va == (char*)a){
80107120:	e8 2b cb ff ff       	call   80103c50 <myproc>
80107125:	8d 0c 7f             	lea    (%edi,%edi,2),%ecx
80107128:	c1 e1 02             	shl    $0x2,%ecx
8010712b:	39 9c 08 cc 00 00 00 	cmp    %ebx,0xcc(%eax,%ecx,1)
80107132:	75 e4                	jne    80107118 <deallocuvm+0x148>
              cprintf(" cleaned %d\n",a);
80107134:	83 ec 08             	sub    $0x8,%esp
80107137:	89 4d dc             	mov    %ecx,-0x24(%ebp)
8010713a:	53                   	push   %ebx
8010713b:	68 35 85 10 80       	push   $0x80108535
80107140:	e8 1b 95 ff ff       	call   80100660 <cprintf>
                p->nPgsPhysical--;
80107145:	8b 7d e0             	mov    -0x20(%ebp),%edi
80107148:	83 af 80 00 00 00 01 	subl   $0x1,0x80(%edi)
              myproc()->physicalPGs[i].va = (char*) 0xffffffff;
8010714f:	e8 fc ca ff ff       	call   80103c50 <myproc>
80107154:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80107157:	c7 84 08 cc 00 00 00 	movl   $0xffffffff,0xcc(%eax,%ecx,1)
8010715e:	ff ff ff ff 
              if(myproc()->headPG== &p->physicalPGs[i]){
80107162:	e8 e9 ca ff ff       	call   80103c50 <myproc>
80107167:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010716a:	83 c4 10             	add    $0x10,%esp
8010716d:	8d 94 0f cc 00 00 00 	lea    0xcc(%edi,%ecx,1),%edx
80107174:	39 90 88 00 00 00    	cmp    %edx,0x88(%eax)
8010717a:	74 34                	je     801071b0 <deallocuvm+0x1e0>
              myproc()->nPgsPhysical--;
8010717c:	e8 cf ca ff ff       	call   80103c50 <myproc>
80107181:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
              break;
80107188:	e9 a2 fe ff ff       	jmp    8010702f <deallocuvm+0x5f>
8010718d:	8d 76 00             	lea    0x0(%esi),%esi
              cprintf("%d\n",a);
80107190:	83 ec 08             	sub    $0x8,%esp
80107193:	53                   	push   %ebx
80107194:	68 3e 85 10 80       	push   $0x8010853e
80107199:	e8 c2 94 ff ff       	call   80100660 <cprintf>
              panic("deallocuvm: cant find page1");
8010719e:	c7 04 24 19 85 10 80 	movl   $0x80108519,(%esp)
801071a5:	e8 e6 91 ff ff       	call   80100390 <panic>
801071aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                p->headPG = p->physicalPGs[i].next;
801071b0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801071b3:	8b 84 0a d0 00 00 00 	mov    0xd0(%edx,%ecx,1),%eax
801071ba:	89 82 88 00 00 00    	mov    %eax,0x88(%edx)
                myproc()->headPG->prev=0;
801071c0:	e8 8b ca ff ff       	call   80103c50 <myproc>
801071c5:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
801071cb:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801071d2:	eb a8                	jmp    8010717c <deallocuvm+0x1ac>
            panic("deallocuvm: cant find page2");
801071d4:	83 ec 0c             	sub    $0xc,%esp
801071d7:	68 42 85 10 80       	push   $0x80108542
801071dc:	e8 af 91 ff ff       	call   80100390 <panic>
        panic("kfree");
801071e1:	83 ec 0c             	sub    $0xc,%esp
801071e4:	68 ca 7d 10 80       	push   $0x80107dca
801071e9:	e8 a2 91 ff ff       	call   80100390 <panic>
801071ee:	66 90                	xchg   %ax,%ax

801071f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	57                   	push   %edi
801071f4:	56                   	push   %esi
801071f5:	53                   	push   %ebx
801071f6:	83 ec 0c             	sub    $0xc,%esp
801071f9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801071fc:	85 f6                	test   %esi,%esi
801071fe:	74 59                	je     80107259 <freevm+0x69>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80107200:	83 ec 04             	sub    $0x4,%esp
80107203:	89 f3                	mov    %esi,%ebx
80107205:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010720b:	6a 00                	push   $0x0
8010720d:	68 00 00 00 80       	push   $0x80000000
80107212:	56                   	push   %esi
80107213:	e8 b8 fd ff ff       	call   80106fd0 <deallocuvm>
80107218:	83 c4 10             	add    $0x10,%esp
8010721b:	eb 0a                	jmp    80107227 <freevm+0x37>
8010721d:	8d 76 00             	lea    0x0(%esi),%esi
80107220:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
80107223:	39 fb                	cmp    %edi,%ebx
80107225:	74 23                	je     8010724a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107227:	8b 03                	mov    (%ebx),%eax
80107229:	a8 01                	test   $0x1,%al
8010722b:	74 f3                	je     80107220 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010722d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107232:	83 ec 0c             	sub    $0xc,%esp
80107235:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107238:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010723d:	50                   	push   %eax
8010723e:	e8 dd b4 ff ff       	call   80102720 <kfree>
80107243:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107246:	39 fb                	cmp    %edi,%ebx
80107248:	75 dd                	jne    80107227 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010724a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010724d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107250:	5b                   	pop    %ebx
80107251:	5e                   	pop    %esi
80107252:	5f                   	pop    %edi
80107253:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107254:	e9 c7 b4 ff ff       	jmp    80102720 <kfree>
    panic("freevm: no pgdir");
80107259:	83 ec 0c             	sub    $0xc,%esp
8010725c:	68 68 85 10 80       	push   $0x80108568
80107261:	e8 2a 91 ff ff       	call   80100390 <panic>
80107266:	8d 76 00             	lea    0x0(%esi),%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107270 <setupkvm>:
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	56                   	push   %esi
80107274:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107275:	e8 56 b6 ff ff       	call   801028d0 <kalloc>
8010727a:	85 c0                	test   %eax,%eax
8010727c:	89 c6                	mov    %eax,%esi
8010727e:	74 42                	je     801072c2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107280:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107283:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107288:	68 00 10 00 00       	push   $0x1000
8010728d:	6a 00                	push   $0x0
8010728f:	50                   	push   %eax
80107290:	e8 7b d7 ff ff       	call   80104a10 <memset>
80107295:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107298:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010729b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010729e:	83 ec 08             	sub    $0x8,%esp
801072a1:	8b 13                	mov    (%ebx),%edx
801072a3:	ff 73 0c             	pushl  0xc(%ebx)
801072a6:	50                   	push   %eax
801072a7:	29 c1                	sub    %eax,%ecx
801072a9:	89 f0                	mov    %esi,%eax
801072ab:	e8 90 f9 ff ff       	call   80106c40 <mappages>
801072b0:	83 c4 10             	add    $0x10,%esp
801072b3:	85 c0                	test   %eax,%eax
801072b5:	78 19                	js     801072d0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801072b7:	83 c3 10             	add    $0x10,%ebx
801072ba:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801072c0:	75 d6                	jne    80107298 <setupkvm+0x28>
}
801072c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801072c5:	89 f0                	mov    %esi,%eax
801072c7:	5b                   	pop    %ebx
801072c8:	5e                   	pop    %esi
801072c9:	5d                   	pop    %ebp
801072ca:	c3                   	ret    
801072cb:	90                   	nop
801072cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801072d0:	83 ec 0c             	sub    $0xc,%esp
801072d3:	56                   	push   %esi
      return 0;
801072d4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801072d6:	e8 15 ff ff ff       	call   801071f0 <freevm>
      return 0;
801072db:	83 c4 10             	add    $0x10,%esp
}
801072de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801072e1:	89 f0                	mov    %esi,%eax
801072e3:	5b                   	pop    %ebx
801072e4:	5e                   	pop    %esi
801072e5:	5d                   	pop    %ebp
801072e6:	c3                   	ret    
801072e7:	89 f6                	mov    %esi,%esi
801072e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072f0 <kvmalloc>:
{
801072f0:	55                   	push   %ebp
801072f1:	89 e5                	mov    %esp,%ebp
801072f3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801072f6:	e8 75 ff ff ff       	call   80107270 <setupkvm>
801072fb:	a3 a4 a8 11 80       	mov    %eax,0x8011a8a4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107300:	05 00 00 00 80       	add    $0x80000000,%eax
80107305:	0f 22 d8             	mov    %eax,%cr3
}
80107308:	c9                   	leave  
80107309:	c3                   	ret    
8010730a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107310 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107310:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107311:	31 c9                	xor    %ecx,%ecx
{
80107313:	89 e5                	mov    %esp,%ebp
80107315:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107318:	8b 55 0c             	mov    0xc(%ebp),%edx
8010731b:	8b 45 08             	mov    0x8(%ebp),%eax
8010731e:	e8 9d f8 ff ff       	call   80106bc0 <walkpgdir>
  if(pte == 0)
80107323:	85 c0                	test   %eax,%eax
80107325:	74 05                	je     8010732c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107327:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010732a:	c9                   	leave  
8010732b:	c3                   	ret    
    panic("clearpteu");
8010732c:	83 ec 0c             	sub    $0xc,%esp
8010732f:	68 79 85 10 80       	push   $0x80108579
80107334:	e8 57 90 ff ff       	call   80100390 <panic>
80107339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107340 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	56                   	push   %esi
80107345:	53                   	push   %ebx
80107346:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107349:	e8 22 ff ff ff       	call   80107270 <setupkvm>
8010734e:	85 c0                	test   %eax,%eax
80107350:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107353:	0f 84 b6 00 00 00    	je     8010740f <copyuvm+0xcf>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107359:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010735c:	85 c9                	test   %ecx,%ecx
8010735e:	0f 84 ab 00 00 00    	je     8010740f <copyuvm+0xcf>
80107364:	31 f6                	xor    %esi,%esi
80107366:	eb 69                	jmp    801073d1 <copyuvm+0x91>
80107368:	90                   	nop
80107369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *pte = PTE_U | PTE_W | PTE_PG;
      //lcr3(V2P(myproc()->pgdir));
      continue;
    }

    pa = PTE_ADDR(*pte);
80107370:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107372:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
80107377:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
8010737d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80107380:	e8 4b b5 ff ff       	call   801028d0 <kalloc>
80107385:	85 c0                	test   %eax,%eax
80107387:	89 c3                	mov    %eax,%ebx
80107389:	0f 84 9d 00 00 00    	je     8010742c <copyuvm+0xec>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
8010738f:	83 ec 04             	sub    $0x4,%esp
80107392:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107398:	68 00 10 00 00       	push   $0x1000
8010739d:	57                   	push   %edi
8010739e:	50                   	push   %eax
8010739f:	e8 1c d7 ff ff       	call   80104ac0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801073a4:	58                   	pop    %eax
801073a5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801073ab:	b9 00 10 00 00       	mov    $0x1000,%ecx
801073b0:	5a                   	pop    %edx
801073b1:	ff 75 e4             	pushl  -0x1c(%ebp)
801073b4:	50                   	push   %eax
801073b5:	89 f2                	mov    %esi,%edx
801073b7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073ba:	e8 81 f8 ff ff       	call   80106c40 <mappages>
801073bf:	83 c4 10             	add    $0x10,%esp
801073c2:	85 c0                	test   %eax,%eax
801073c4:	78 5a                	js     80107420 <copyuvm+0xe0>
  for(i = 0; i < sz; i += PGSIZE){
801073c6:	81 c6 00 10 00 00    	add    $0x1000,%esi
801073cc:	39 75 0c             	cmp    %esi,0xc(%ebp)
801073cf:	76 3e                	jbe    8010740f <copyuvm+0xcf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801073d1:	8b 45 08             	mov    0x8(%ebp),%eax
801073d4:	31 c9                	xor    %ecx,%ecx
801073d6:	89 f2                	mov    %esi,%edx
801073d8:	e8 e3 f7 ff ff       	call   80106bc0 <walkpgdir>
801073dd:	85 c0                	test   %eax,%eax
801073df:	74 78                	je     80107459 <copyuvm+0x119>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
801073e1:	8b 00                	mov    (%eax),%eax
801073e3:	a9 01 02 00 00       	test   $0x201,%eax
801073e8:	74 62                	je     8010744c <copyuvm+0x10c>
    if(*pte & PTE_PG){
801073ea:	f6 c4 02             	test   $0x2,%ah
801073ed:	74 81                	je     80107370 <copyuvm+0x30>
      pte = walkpgdir(d, (void*) i, 1);
801073ef:	8b 45 e0             	mov    -0x20(%ebp),%eax
801073f2:	89 f2                	mov    %esi,%edx
801073f4:	b9 01 00 00 00       	mov    $0x1,%ecx
  for(i = 0; i < sz; i += PGSIZE){
801073f9:	81 c6 00 10 00 00    	add    $0x1000,%esi
      pte = walkpgdir(d, (void*) i, 1);
801073ff:	e8 bc f7 ff ff       	call   80106bc0 <walkpgdir>
  for(i = 0; i < sz; i += PGSIZE){
80107404:	39 75 0c             	cmp    %esi,0xc(%ebp)
      *pte = PTE_U | PTE_W | PTE_PG;
80107407:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  for(i = 0; i < sz; i += PGSIZE){
8010740d:	77 c2                	ja     801073d1 <copyuvm+0x91>
  return d;

bad:
  freevm(d);
  return 0;
}
8010740f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107412:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107415:	5b                   	pop    %ebx
80107416:	5e                   	pop    %esi
80107417:	5f                   	pop    %edi
80107418:	5d                   	pop    %ebp
80107419:	c3                   	ret    
8010741a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kfree(mem);
80107420:	83 ec 0c             	sub    $0xc,%esp
80107423:	53                   	push   %ebx
80107424:	e8 f7 b2 ff ff       	call   80102720 <kfree>
      goto bad;
80107429:	83 c4 10             	add    $0x10,%esp
  freevm(d);
8010742c:	83 ec 0c             	sub    $0xc,%esp
8010742f:	ff 75 e0             	pushl  -0x20(%ebp)
80107432:	e8 b9 fd ff ff       	call   801071f0 <freevm>
  return 0;
80107437:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
8010743e:	83 c4 10             	add    $0x10,%esp
}
80107441:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107444:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107447:	5b                   	pop    %ebx
80107448:	5e                   	pop    %esi
80107449:	5f                   	pop    %edi
8010744a:	5d                   	pop    %ebp
8010744b:	c3                   	ret    
      panic("copyuvm: page not present");
8010744c:	83 ec 0c             	sub    $0xc,%esp
8010744f:	68 9d 85 10 80       	push   $0x8010859d
80107454:	e8 37 8f ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107459:	83 ec 0c             	sub    $0xc,%esp
8010745c:	68 83 85 10 80       	push   $0x80108583
80107461:	e8 2a 8f ff ff       	call   80100390 <panic>
80107466:	8d 76 00             	lea    0x0(%esi),%esi
80107469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107470 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107470:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107471:	31 c9                	xor    %ecx,%ecx
{
80107473:	89 e5                	mov    %esp,%ebp
80107475:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107478:	8b 55 0c             	mov    0xc(%ebp),%edx
8010747b:	8b 45 08             	mov    0x8(%ebp),%eax
8010747e:	e8 3d f7 ff ff       	call   80106bc0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107483:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107485:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107486:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107488:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010748d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107490:	05 00 00 00 80       	add    $0x80000000,%eax
80107495:	83 fa 05             	cmp    $0x5,%edx
80107498:	ba 00 00 00 00       	mov    $0x0,%edx
8010749d:	0f 45 c2             	cmovne %edx,%eax
}
801074a0:	c3                   	ret    
801074a1:	eb 0d                	jmp    801074b0 <copyout>
801074a3:	90                   	nop
801074a4:	90                   	nop
801074a5:	90                   	nop
801074a6:	90                   	nop
801074a7:	90                   	nop
801074a8:	90                   	nop
801074a9:	90                   	nop
801074aa:	90                   	nop
801074ab:	90                   	nop
801074ac:	90                   	nop
801074ad:	90                   	nop
801074ae:	90                   	nop
801074af:	90                   	nop

801074b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801074b0:	55                   	push   %ebp
801074b1:	89 e5                	mov    %esp,%ebp
801074b3:	57                   	push   %edi
801074b4:	56                   	push   %esi
801074b5:	53                   	push   %ebx
801074b6:	83 ec 1c             	sub    $0x1c,%esp
801074b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801074bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801074bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801074c2:	85 db                	test   %ebx,%ebx
801074c4:	75 40                	jne    80107506 <copyout+0x56>
801074c6:	eb 70                	jmp    80107538 <copyout+0x88>
801074c8:	90                   	nop
801074c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801074d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801074d3:	89 f1                	mov    %esi,%ecx
801074d5:	29 d1                	sub    %edx,%ecx
801074d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801074dd:	39 d9                	cmp    %ebx,%ecx
801074df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801074e2:	29 f2                	sub    %esi,%edx
801074e4:	83 ec 04             	sub    $0x4,%esp
801074e7:	01 d0                	add    %edx,%eax
801074e9:	51                   	push   %ecx
801074ea:	57                   	push   %edi
801074eb:	50                   	push   %eax
801074ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801074ef:	e8 cc d5 ff ff       	call   80104ac0 <memmove>
    len -= n;
    buf += n;
801074f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801074f7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801074fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107500:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107502:	29 cb                	sub    %ecx,%ebx
80107504:	74 32                	je     80107538 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107506:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107508:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010750b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010750e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107514:	56                   	push   %esi
80107515:	ff 75 08             	pushl  0x8(%ebp)
80107518:	e8 53 ff ff ff       	call   80107470 <uva2ka>
    if(pa0 == 0)
8010751d:	83 c4 10             	add    $0x10,%esp
80107520:	85 c0                	test   %eax,%eax
80107522:	75 ac                	jne    801074d0 <copyout+0x20>
  }
  return 0;
}
80107524:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010752c:	5b                   	pop    %ebx
8010752d:	5e                   	pop    %esi
8010752e:	5f                   	pop    %edi
8010752f:	5d                   	pop    %ebp
80107530:	c3                   	ret    
80107531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107538:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010753b:	31 c0                	xor    %eax,%eax
}
8010753d:	5b                   	pop    %ebx
8010753e:	5e                   	pop    %esi
8010753f:	5f                   	pop    %edi
80107540:	5d                   	pop    %ebp
80107541:	c3                   	ret    
80107542:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107550 <initSCFIFO>:

  lcr3(V2P(p->pgdir));
}

void
initSCFIFO(char *va){
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	53                   	push   %ebx
80107554:	83 ec 04             	sub    $0x4,%esp
80107557:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
8010755a:	e8 f1 c6 ff ff       	call   80103c50 <myproc>
  int i;
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
8010755f:	31 d2                	xor    %edx,%edx
80107561:	8d 88 cc 00 00 00    	lea    0xcc(%eax),%ecx
80107567:	eb 12                	jmp    8010757b <initSCFIFO+0x2b>
80107569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107570:	83 c2 01             	add    $0x1,%edx
80107573:	83 c1 0c             	add    $0xc,%ecx
    if(i == MAX_PSYC_PAGES) // DEBUG
80107576:	83 fa 10             	cmp    $0x10,%edx
80107579:	74 45                	je     801075c0 <initSCFIFO+0x70>
      panic("initSCFIFO: cant find free slot in phy mem");
    if(p->physicalPGs[i].va == (char*)0xffffffff){
8010757b:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
8010757e:	75 f0                	jne    80107570 <initSCFIFO+0x20>
      p->physicalPGs[i].va = va;
80107580:	8d 14 52             	lea    (%edx,%edx,2),%edx
80107583:	c1 e2 02             	shl    $0x2,%edx
80107586:	89 9c 10 cc 00 00 00 	mov    %ebx,0xcc(%eax,%edx,1)

      if(!p->headPG){
8010758d:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80107593:	8d 94 10 cc 00 00 00 	lea    0xcc(%eax,%edx,1),%edx
8010759a:	85 c9                	test   %ecx,%ecx
8010759c:	74 12                	je     801075b0 <initSCFIFO+0x60>
        p->headPG=&p->physicalPGs[i];
        return;
      }

      movePageToHead(&p->physicalPGs[i]);
8010759e:	89 55 08             	mov    %edx,0x8(%ebp)
      return;
    }
  }
}
801075a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801075a4:	c9                   	leave  
      movePageToHead(&p->physicalPGs[i]);
801075a5:	e9 16 05 00 00       	jmp    80107ac0 <movePageToHead>
801075aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->headPG=&p->physicalPGs[i];
801075b0:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
}
801075b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801075b9:	c9                   	leave  
801075ba:	c3                   	ret    
801075bb:	90                   	nop
801075bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("initSCFIFO: cant find free slot in phy mem");
801075c0:	83 ec 0c             	sub    $0xc,%esp
801075c3:	68 78 86 10 80       	push   $0x80108678
801075c8:	e8 c3 8d ff ff       	call   80100390 <panic>
801075cd:	8d 76 00             	lea    0x0(%esi),%esi

801075d0 <getLastPageSCFIFO>:




struct procPG*
getLastPageSCFIFO(){
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	53                   	push   %ebx
801075d4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p = myproc();
801075d7:	e8 74 c6 ff ff       	call   80103c50 <myproc>
  //#pragma GCC diagnostic ignored "-Wmaybe-uninitialized";
  struct procPG *page = p->headPG;
801075dc:	8b 98 88 00 00 00    	mov    0x88(%eax),%ebx
  if(!page->next){
801075e2:	8b 4b 04             	mov    0x4(%ebx),%ecx
801075e5:	85 c9                	test   %ecx,%ecx
801075e7:	74 38                	je     80107621 <getLastPageSCFIFO+0x51>
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical; i++)
801075e9:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
801075ef:	ba 01 00 00 00       	mov    $0x1,%edx
801075f4:	83 f8 01             	cmp    $0x1,%eax
801075f7:	7f 0a                	jg     80107603 <getLastPageSCFIFO+0x33>
801075f9:	eb 1d                	jmp    80107618 <getLastPageSCFIFO+0x48>
801075fb:	90                   	nop
801075fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107600:	8b 49 04             	mov    0x4(%ecx),%ecx
80107603:	83 c2 01             	add    $0x1,%edx
80107606:	39 c2                	cmp    %eax,%edx
80107608:	75 f6                	jne    80107600 <getLastPageSCFIFO+0x30>
  }
       //cprintf("~~%d %d\n",page->va, page->next);

  return page;

}
8010760a:	89 c8                	mov    %ecx,%eax
8010760c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010760f:	c9                   	leave  
80107610:	c3                   	ret    
80107611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 1; i < p->nPgsPhysical; i++)
80107618:	89 d9                	mov    %ebx,%ecx
}
8010761a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010761d:	89 c8                	mov    %ecx,%eax
8010761f:	c9                   	leave  
80107620:	c3                   	ret    
    panic("getLastPG: empty headPG list");
80107621:	83 ec 0c             	sub    $0xc,%esp
80107624:	68 b7 85 10 80       	push   $0x801085b7
80107629:	e8 62 8d ff ff       	call   80100390 <panic>
8010762e:	66 90                	xchg   %ax,%ax

80107630 <scfifoWriteToSwap>:
scfifoWriteToSwap(uint addr){
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	53                   	push   %ebx
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107636:	31 db                	xor    %ebx,%ebx
scfifoWriteToSwap(uint addr){
80107638:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
8010763b:	e8 10 c6 ff ff       	call   80103c50 <myproc>
80107640:	89 c6                	mov    %eax,%esi
80107642:	eb 10                	jmp    80107654 <scfifoWriteToSwap+0x24>
80107644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107648:	83 c3 01             	add    $0x1,%ebx
    if(i== MAX_PSYC_PAGES){
8010764b:	83 fb 10             	cmp    $0x10,%ebx
8010764e:	0f 84 ac 00 00 00    	je     80107700 <scfifoWriteToSwap+0xd0>
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107654:	83 bc 9e 8c 00 00 00 	cmpl   $0xffffffff,0x8c(%esi,%ebx,4)
8010765b:	ff 
8010765c:	75 ea                	jne    80107648 <scfifoWriteToSwap+0x18>
  if(p->headPG==0){
8010765e:	8b 86 88 00 00 00    	mov    0x88(%esi),%eax
80107664:	85 c0                	test   %eax,%eax
80107666:	0f 84 bb 00 00 00    	je     80107727 <scfifoWriteToSwap+0xf7>
  if(p->headPG->next==0){ // TODO: check if needed..
8010766c:	8b 40 04             	mov    0x4(%eax),%eax
8010766f:	85 c0                	test   %eax,%eax
80107671:	0f 84 a3 00 00 00    	je     8010771a <scfifoWriteToSwap+0xea>
  struct procPG *lastpg = getLastPageSCFIFO();
80107677:	e8 54 ff ff ff       	call   801075d0 <getLastPageSCFIFO>
8010767c:	89 c7                	mov    %eax,%edi
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
8010767e:	8b 46 04             	mov    0x4(%esi),%eax
80107681:	31 c9                	xor    %ecx,%ecx
80107683:	8b 17                	mov    (%edi),%edx
80107685:	e8 36 f5 ff ff       	call   80106bc0 <walkpgdir>
8010768a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  p->swappedPGs[i].va = lastpg->va;
8010768d:	8b 07                	mov    (%edi),%eax
8010768f:	89 84 9e 8c 00 00 00 	mov    %eax,0x8c(%esi,%ebx,4)
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107696:	c1 e3 0c             	shl    $0xc,%ebx
80107699:	68 00 10 00 00       	push   $0x1000
8010769e:	53                   	push   %ebx
8010769f:	8b 07                	mov    (%edi),%eax
801076a1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076a6:	50                   	push   %eax
801076a7:	56                   	push   %esi
801076a8:	e8 23 ac ff ff       	call   801022d0 <writeToSwapFile>
801076ad:	83 c4 10             	add    $0x10,%esp
801076b0:	85 c0                	test   %eax,%eax
801076b2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801076b5:	7e 56                	jle    8010770d <scfifoWriteToSwap+0xdd>
  kfree((char*)PTE_ADDR(P2V(*pte)));
801076b7:	8b 02                	mov    (%edx),%eax
801076b9:	83 ec 0c             	sub    $0xc,%esp
801076bc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801076bf:	05 00 00 00 80       	add    $0x80000000,%eax
801076c4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076c9:	50                   	push   %eax
801076ca:	e8 51 b0 ff ff       	call   80102720 <kfree>
  lastpg->va = (char*)PTE_ADDR(addr);
801076cf:	8b 45 08             	mov    0x8(%ebp),%eax
  *pte = PTE_W | PTE_U | PTE_PG;
801076d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  lastpg->va = (char*)PTE_ADDR(addr);
801076d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  *pte = PTE_W | PTE_U | PTE_PG;
801076da:	c7 02 06 02 00 00    	movl   $0x206,(%edx)
  lastpg->va = (char*)PTE_ADDR(addr);
801076e0:	89 07                	mov    %eax,(%edi)
  movePageToHead(lastpg);
801076e2:	89 3c 24             	mov    %edi,(%esp)
801076e5:	e8 d6 03 00 00       	call   80107ac0 <movePageToHead>
  lcr3(V2P(p->pgdir));  // switch to process's address space
801076ea:	8b 46 04             	mov    0x4(%esi),%eax
801076ed:	05 00 00 00 80       	add    $0x80000000,%eax
801076f2:	0f 22 d8             	mov    %eax,%cr3
}
801076f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076f8:	89 f8                	mov    %edi,%eax
801076fa:	5b                   	pop    %ebx
801076fb:	5e                   	pop    %esi
801076fc:	5f                   	pop    %edi
801076fd:	5d                   	pop    %ebp
801076fe:	c3                   	ret    
801076ff:	90                   	nop
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107700:	83 ec 0c             	sub    $0xc,%esp
80107703:	68 a4 86 10 80       	push   $0x801086a4
80107708:	e8 83 8c ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
8010770d:	83 ec 0c             	sub    $0xc,%esp
80107710:	68 30 87 10 80       	push   $0x80108730
80107715:	e8 76 8c ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: single page in headPG list");
8010771a:	83 ec 0c             	sub    $0xc,%esp
8010771d:	68 00 87 10 80       	push   $0x80108700
80107722:	e8 69 8c ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: empty headPG list");
80107727:	83 ec 0c             	sub    $0xc,%esp
8010772a:	68 d8 86 10 80       	push   $0x801086d8
8010772f:	e8 5c 8c ff ff       	call   80100390 <panic>
80107734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010773a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107740 <writePageToSwapFile>:
writePageToSwapFile(char* va){
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	53                   	push   %ebx
80107744:	83 ec 04             	sub    $0x4,%esp
80107747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  myproc()->nPgsSwap++;
8010774a:	e8 01 c5 ff ff       	call   80103c50 <myproc>
8010774f:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
    return scfifoWriteToSwap((uint)va);
80107756:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107759:	83 c4 04             	add    $0x4,%esp
8010775c:	5b                   	pop    %ebx
8010775d:	5d                   	pop    %ebp
    return scfifoWriteToSwap((uint)va);
8010775e:	e9 cd fe ff ff       	jmp    80107630 <scfifoWriteToSwap>
80107763:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107770 <scfifoSwap>:
scfifoSwap(uint addr){
80107770:	55                   	push   %ebp
80107771:	89 e5                	mov    %esp,%ebp
80107773:	57                   	push   %edi
80107774:	56                   	push   %esi
80107775:	53                   	push   %ebx
80107776:	81 ec 1c 10 00 00    	sub    $0x101c,%esp
  struct proc *p = myproc();
8010777c:	e8 cf c4 ff ff       	call   80103c50 <myproc>
80107781:	89 c6                	mov    %eax,%esi
  if(p->headPG==0){
80107783:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80107789:	85 c0                	test   %eax,%eax
8010778b:	0f 84 49 01 00 00    	je     801078da <scfifoSwap+0x16a>
  if(p->headPG->next==0){ // TODO: check if needed..
80107791:	8b 48 04             	mov    0x4(%eax),%ecx
80107794:	85 c9                	test   %ecx,%ecx
80107796:	0f 84 31 01 00 00    	je     801078cd <scfifoSwap+0x15d>
  struct procPG *lastpg = getLastPageSCFIFO();
8010779c:	e8 2f fe ff ff       	call   801075d0 <getLastPageSCFIFO>
801077a1:	89 c2                	mov    %eax,%edx
801077a3:	89 85 e4 ef ff ff    	mov    %eax,-0x101c(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
801077a9:	8b 46 04             	mov    0x4(%esi),%eax
801077ac:	8b 12                	mov    (%edx),%edx
801077ae:	31 c9                	xor    %ecx,%ecx
  int i = 0;
801077b0:	31 db                	xor    %ebx,%ebx
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
801077b2:	e8 09 f4 ff ff       	call   80106bc0 <walkpgdir>
801077b7:	8b 7d 08             	mov    0x8(%ebp),%edi
801077ba:	89 85 e0 ef ff ff    	mov    %eax,-0x1020(%ebp)
801077c0:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801077c6:	eb 14                	jmp    801077dc <scfifoSwap+0x6c>
801077c8:	90                   	nop
801077c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i <= MAX_PSYC_PAGES; i++){
801077d0:	83 c3 01             	add    $0x1,%ebx
    if(i==MAX_PSYC_PAGES){ // DEBUG
801077d3:	83 fb 10             	cmp    $0x10,%ebx
801077d6:	0f 84 e4 00 00 00    	je     801078c0 <scfifoSwap+0x150>
    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
801077dc:	39 bc 9e 8c 00 00 00 	cmp    %edi,0x8c(%esi,%ebx,4)
801077e3:	75 eb                	jne    801077d0 <scfifoSwap+0x60>
      p->swappedPGs[i].va = lastpg->va;
801077e5:	8b 85 e4 ef ff ff    	mov    -0x101c(%ebp),%eax
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
801077eb:	8b 55 08             	mov    0x8(%ebp),%edx
801077ee:	31 c9                	xor    %ecx,%ecx
      p->swappedPGs[i].va = lastpg->va;
801077f0:	8b 00                	mov    (%eax),%eax
801077f2:	89 84 9e 8c 00 00 00 	mov    %eax,0x8c(%esi,%ebx,4)
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
801077f9:	8b 46 04             	mov    0x4(%esi),%eax
801077fc:	e8 bf f3 ff ff       	call   80106bc0 <walkpgdir>
  if(!*pte2){
80107801:	8b 10                	mov    (%eax),%edx
80107803:	85 d2                	test   %edx,%edx
80107805:	0f 84 dc 00 00 00    	je     801078e7 <scfifoSwap+0x177>
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_W | PTE_P;
8010780b:	8b 8d e0 ef ff ff    	mov    -0x1020(%ebp),%ecx
  memset(buf, 0, PGSIZE);
80107811:	83 ec 04             	sub    $0x4,%esp
  int loc = (i * PGSIZE);
80107814:	c1 e3 0c             	shl    $0xc,%ebx
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_W | PTE_P;
80107817:	8b 11                	mov    (%ecx),%edx
80107819:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010781f:	83 ca 07             	or     $0x7,%edx
80107822:	89 10                	mov    %edx,(%eax)
  memset(buf, 0, PGSIZE);
80107824:	8d 95 e8 ef ff ff    	lea    -0x1018(%ebp),%edx
8010782a:	68 00 10 00 00       	push   $0x1000
8010782f:	6a 00                	push   $0x0
80107831:	52                   	push   %edx
80107832:	89 95 dc ef ff ff    	mov    %edx,-0x1024(%ebp)
80107838:	e8 d3 d1 ff ff       	call   80104a10 <memset>
  readFromSwapFile(p, buf, loc, PGSIZE);
8010783d:	8b 95 dc ef ff ff    	mov    -0x1024(%ebp),%edx
80107843:	68 00 10 00 00       	push   $0x1000
80107848:	53                   	push   %ebx
80107849:	52                   	push   %edx
8010784a:	56                   	push   %esi
8010784b:	e8 b0 aa ff ff       	call   80102300 <readFromSwapFile>
  writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1))), loc, PGSIZE);
80107850:	83 c4 20             	add    $0x20,%esp
80107853:	68 00 10 00 00       	push   $0x1000
80107858:	53                   	push   %ebx
80107859:	8b 9d e0 ef ff ff    	mov    -0x1020(%ebp),%ebx
8010785f:	8b 03                	mov    (%ebx),%eax
80107861:	89 85 e0 ef ff ff    	mov    %eax,-0x1020(%ebp)
80107867:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010786c:	05 00 00 00 80       	add    $0x80000000,%eax
80107871:	50                   	push   %eax
80107872:	56                   	push   %esi
80107873:	e8 58 aa ff ff       	call   801022d0 <writeToSwapFile>
  memmove((void*)(PTE_ADDR(addr)), (void*)buf, PGSIZE) ;
80107878:	8b 95 dc ef ff ff    	mov    -0x1024(%ebp),%edx
8010787e:	83 c4 0c             	add    $0xc,%esp
80107881:	68 00 10 00 00       	push   $0x1000
80107886:	52                   	push   %edx
80107887:	57                   	push   %edi
80107888:	e8 33 d2 ff ff       	call   80104ac0 <memmove>
  lastpg->va = (char*)PTE_ADDR(addr);
8010788d:	8b 85 e4 ef ff ff    	mov    -0x101c(%ebp),%eax
  *pte1 = PTE_U | PTE_W | PTE_PG;
80107893:	c7 03 06 02 00 00    	movl   $0x206,(%ebx)
  lastpg->va = (char*)PTE_ADDR(addr);
80107899:	89 38                	mov    %edi,(%eax)
  movePageToHead(lastpg);
8010789b:	89 04 24             	mov    %eax,(%esp)
8010789e:	e8 1d 02 00 00       	call   80107ac0 <movePageToHead>
  lcr3(V2P(p->pgdir));
801078a3:	8b 46 04             	mov    0x4(%esi),%eax
801078a6:	05 00 00 00 80       	add    $0x80000000,%eax
801078ab:	0f 22 d8             	mov    %eax,%cr3
}
801078ae:	83 c4 10             	add    $0x10,%esp
801078b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078b4:	5b                   	pop    %ebx
801078b5:	5e                   	pop    %esi
801078b6:	5f                   	pop    %edi
801078b7:	5d                   	pop    %ebp
801078b8:	c3                   	ret    
801078b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("scfifoSwap: could not find page in swap file");
801078c0:	83 ec 0c             	sub    $0xc,%esp
801078c3:	68 7c 87 10 80       	push   $0x8010877c
801078c8:	e8 c3 8a ff ff       	call   80100390 <panic>
    panic("scfifoSwap: single page in headPG list");
801078cd:	83 ec 0c             	sub    $0xc,%esp
801078d0:	68 54 87 10 80       	push   $0x80108754
801078d5:	e8 b6 8a ff ff       	call   80100390 <panic>
    panic("scfifoSwap: empty headPG list");
801078da:	83 ec 0c             	sub    $0xc,%esp
801078dd:	68 d4 85 10 80       	push   $0x801085d4
801078e2:	e8 a9 8a ff ff       	call   80100390 <panic>
    panic("scfifoSwap: pte2 empty");
801078e7:	83 ec 0c             	sub    $0xc,%esp
801078ea:	68 f2 85 10 80       	push   $0x801085f2
801078ef:	e8 9c 8a ff ff       	call   80100390 <panic>
801078f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107900 <swapPage>:
swapPage(uint addr){
80107900:	55                   	push   %ebp
80107901:	89 e5                	mov    %esp,%ebp
}
80107903:	5d                   	pop    %ebp
    return scfifoSwap((uint)addr);
80107904:	e9 67 fe ff ff       	jmp    80107770 <scfifoSwap>
80107909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107910 <initPhysicalPage>:

int
initPhysicalPage(char *va){
80107910:	55                   	push   %ebp
80107911:	89 e5                	mov    %esp,%ebp
80107913:	83 ec 14             	sub    $0x14,%esp
  #ifdef SCFIFO
    initSCFIFO(va);
80107916:	ff 75 08             	pushl  0x8(%ebp)
80107919:	e8 32 fc ff ff       	call   80107550 <initSCFIFO>
  #endif

  myproc()->nPgsPhysical++;
8010791e:	e8 2d c3 ff ff       	call   80103c50 <myproc>
80107923:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)

  return 0;
}
8010792a:	31 c0                	xor    %eax,%eax
8010792c:	c9                   	leave  
8010792d:	c3                   	ret    
8010792e:	66 90                	xchg   %ax,%ax

80107930 <allocuvm>:
{
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	57                   	push   %edi
80107934:	56                   	push   %esi
80107935:	53                   	push   %ebx
80107936:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107939:	8b 7d 10             	mov    0x10(%ebp),%edi
8010793c:	85 ff                	test   %edi,%edi
8010793e:	0f 88 dc 00 00 00    	js     80107a20 <allocuvm+0xf0>
  if(newsz < oldsz)
80107944:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107947:	0f 82 c3 00 00 00    	jb     80107a10 <allocuvm+0xe0>
  a = PGROUNDUP(oldsz);
8010794d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107950:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107956:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010795c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010795f:	0f 86 ae 00 00 00    	jbe    80107a13 <allocuvm+0xe3>
    int    newPage = 1;
80107965:	b8 01 00 00 00       	mov    $0x1,%eax
8010796a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010796d:	89 c7                	mov    %eax,%edi
8010796f:	eb 70                	jmp    801079e1 <allocuvm+0xb1>
80107971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if( (pg = writePageToSwapFile((char*)a)) == 0){
80107978:	83 ec 0c             	sub    $0xc,%esp
8010797b:	53                   	push   %ebx
8010797c:	e8 bf fd ff ff       	call   80107740 <writePageToSwapFile>
80107981:	83 c4 10             	add    $0x10,%esp
80107984:	85 c0                	test   %eax,%eax
80107986:	0f 84 19 01 00 00    	je     80107aa5 <allocuvm+0x175>
    mem = kalloc();
8010798c:	e8 3f af ff ff       	call   801028d0 <kalloc>
    if(mem == 0){
80107991:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107993:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107995:	0f 84 95 00 00 00    	je     80107a30 <allocuvm+0x100>
        newPage = 0;
8010799b:	31 ff                	xor    %edi,%edi
    memset(mem, 0, PGSIZE);
8010799d:	83 ec 04             	sub    $0x4,%esp
801079a0:	68 00 10 00 00       	push   $0x1000
801079a5:	6a 00                	push   $0x0
801079a7:	56                   	push   %esi
801079a8:	e8 63 d0 ff ff       	call   80104a10 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801079ad:	58                   	pop    %eax
801079ae:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801079b4:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079b9:	5a                   	pop    %edx
801079ba:	6a 06                	push   $0x6
801079bc:	50                   	push   %eax
801079bd:	89 da                	mov    %ebx,%edx
801079bf:	8b 45 08             	mov    0x8(%ebp),%eax
801079c2:	e8 79 f2 ff ff       	call   80106c40 <mappages>
801079c7:	83 c4 10             	add    $0x10,%esp
801079ca:	85 c0                	test   %eax,%eax
801079cc:	0f 88 8e 00 00 00    	js     80107a60 <allocuvm+0x130>
  for(; a < newsz; a += PGSIZE){
801079d2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801079d8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801079db:	0f 86 b7 00 00 00    	jbe    80107a98 <allocuvm+0x168>
      if(myproc()->nPgsPhysical >= MAX_PSYC_PAGES){
801079e1:	e8 6a c2 ff ff       	call   80103c50 <myproc>
801079e6:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
801079ed:	7f 89                	jg     80107978 <allocuvm+0x48>
    mem = kalloc();
801079ef:	e8 dc ae ff ff       	call   801028d0 <kalloc>
    if(mem == 0){
801079f4:	85 c0                	test   %eax,%eax
    mem = kalloc();
801079f6:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801079f8:	74 36                	je     80107a30 <allocuvm+0x100>
    if(newPage==1){
801079fa:	83 ff 01             	cmp    $0x1,%edi
801079fd:	75 9e                	jne    8010799d <allocuvm+0x6d>
        initPhysicalPage((char*)a);
801079ff:	83 ec 0c             	sub    $0xc,%esp
80107a02:	53                   	push   %ebx
80107a03:	e8 08 ff ff ff       	call   80107910 <initPhysicalPage>
80107a08:	83 c4 10             	add    $0x10,%esp
80107a0b:	eb 90                	jmp    8010799d <allocuvm+0x6d>
80107a0d:	8d 76 00             	lea    0x0(%esi),%esi
    return oldsz;
80107a10:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a16:	89 f8                	mov    %edi,%eax
80107a18:	5b                   	pop    %ebx
80107a19:	5e                   	pop    %esi
80107a1a:	5f                   	pop    %edi
80107a1b:	5d                   	pop    %ebp
80107a1c:	c3                   	ret    
80107a1d:	8d 76 00             	lea    0x0(%esi),%esi
80107a20:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107a23:	31 ff                	xor    %edi,%edi
}
80107a25:	89 f8                	mov    %edi,%eax
80107a27:	5b                   	pop    %ebx
80107a28:	5e                   	pop    %esi
80107a29:	5f                   	pop    %edi
80107a2a:	5d                   	pop    %ebp
80107a2b:	c3                   	ret    
80107a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory\n");
80107a30:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107a33:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory\n");
80107a35:	68 1f 86 10 80       	push   $0x8010861f
80107a3a:	e8 21 8c ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80107a3f:	83 c4 0c             	add    $0xc,%esp
80107a42:	ff 75 0c             	pushl  0xc(%ebp)
80107a45:	ff 75 10             	pushl  0x10(%ebp)
80107a48:	ff 75 08             	pushl  0x8(%ebp)
80107a4b:	e8 80 f5 ff ff       	call   80106fd0 <deallocuvm>
      return 0;
80107a50:	83 c4 10             	add    $0x10,%esp
}
80107a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a56:	89 f8                	mov    %edi,%eax
80107a58:	5b                   	pop    %ebx
80107a59:	5e                   	pop    %esi
80107a5a:	5f                   	pop    %edi
80107a5b:	5d                   	pop    %ebp
80107a5c:	c3                   	ret    
80107a5d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107a60:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107a63:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory (2)\n");
80107a65:	68 37 86 10 80       	push   $0x80108637
80107a6a:	e8 f1 8b ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80107a6f:	83 c4 0c             	add    $0xc,%esp
80107a72:	ff 75 0c             	pushl  0xc(%ebp)
80107a75:	ff 75 10             	pushl  0x10(%ebp)
80107a78:	ff 75 08             	pushl  0x8(%ebp)
80107a7b:	e8 50 f5 ff ff       	call   80106fd0 <deallocuvm>
      kfree(mem);
80107a80:	89 34 24             	mov    %esi,(%esp)
80107a83:	e8 98 ac ff ff       	call   80102720 <kfree>
      return 0;
80107a88:	83 c4 10             	add    $0x10,%esp
}
80107a8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a8e:	89 f8                	mov    %edi,%eax
80107a90:	5b                   	pop    %ebx
80107a91:	5e                   	pop    %esi
80107a92:	5f                   	pop    %edi
80107a93:	5d                   	pop    %ebp
80107a94:	c3                   	ret    
80107a95:	8d 76 00             	lea    0x0(%esi),%esi
80107a98:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107a9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a9e:	5b                   	pop    %ebx
80107a9f:	89 f8                	mov    %edi,%eax
80107aa1:	5e                   	pop    %esi
80107aa2:	5f                   	pop    %edi
80107aa3:	5d                   	pop    %ebp
80107aa4:	c3                   	ret    
          panic("allocuvm: swapOutPage");
80107aa5:	83 ec 0c             	sub    $0xc,%esp
80107aa8:	68 09 86 10 80       	push   $0x80108609
80107aad:	e8 de 88 ff ff       	call   80100390 <panic>
80107ab2:	66 90                	xchg   %ax,%ax
80107ab4:	66 90                	xchg   %ax,%ax
80107ab6:	66 90                	xchg   %ax,%ax
80107ab8:	66 90                	xchg   %ax,%ax
80107aba:	66 90                	xchg   %ax,%ax
80107abc:	66 90                	xchg   %ax,%ax
80107abe:	66 90                	xchg   %ax,%ax

80107ac0 <movePageToHead>:
#include "mmu.h"
#include "proc.h"
#include "elf.h"

void 
movePageToHead(struct procPG *pg){
80107ac0:	55                   	push   %ebp
80107ac1:	89 e5                	mov    %esp,%ebp
80107ac3:	53                   	push   %ebx
80107ac4:	83 ec 04             	sub    $0x4,%esp
80107ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107aca:	e8 81 c1 ff ff       	call   80103c50 <myproc>
  if(pg->prev){
80107acf:	8b 53 08             	mov    0x8(%ebx),%edx
80107ad2:	85 d2                	test   %edx,%edx
80107ad4:	74 06                	je     80107adc <movePageToHead+0x1c>
    pg->prev->next = pg->next;
80107ad6:	8b 4b 04             	mov    0x4(%ebx),%ecx
80107ad9:	89 4a 04             	mov    %ecx,0x4(%edx)
  }
  if(pg->next){
80107adc:	8b 53 04             	mov    0x4(%ebx),%edx
80107adf:	85 d2                	test   %edx,%edx
80107ae1:	74 06                	je     80107ae9 <movePageToHead+0x29>
    pg->next->prev = pg->prev;
80107ae3:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107ae6:	89 4a 08             	mov    %ecx,0x8(%edx)
  }

  pg->next = p->headPG;
80107ae9:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
  pg->prev = 0;
80107aef:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  pg->next = p->headPG;
80107af6:	89 53 04             	mov    %edx,0x4(%ebx)
  p->headPG->prev = pg;
80107af9:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80107aff:	89 5a 08             	mov    %ebx,0x8(%edx)
  p->headPG = pg;
80107b02:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)
}
80107b08:	83 c4 04             	add    $0x4,%esp
80107b0b:	5b                   	pop    %ebx
80107b0c:	5d                   	pop    %ebp
80107b0d:	c3                   	ret    
