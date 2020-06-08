
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
8010002d:	b8 a0 35 10 80       	mov    $0x801035a0,%eax
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
8010004c:	68 20 87 10 80       	push   $0x80108720
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 c5 4b 00 00       	call   80104c20 <initlock>
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
80100092:	68 27 87 10 80       	push   $0x80108727
80100097:	50                   	push   %eax
80100098:	e8 53 4a 00 00       	call   80104af0 <initsleeplock>
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
801000e4:	e8 77 4c 00 00       	call   80104d60 <acquire>
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
80100162:	e8 b9 4c 00 00       	call   80104e20 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 49 00 00       	call   80104b30 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 8d 24 00 00       	call   80102610 <iderw>
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
80100193:	68 2e 87 10 80       	push   $0x8010872e
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
801001ae:	e8 1d 4a 00 00       	call   80104bd0 <holdingsleep>
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
801001c4:	e9 47 24 00 00       	jmp    80102610 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 3f 87 10 80       	push   $0x8010873f
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
801001ef:	e8 dc 49 00 00       	call   80104bd0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 49 00 00       	call   80104b90 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 50 4b 00 00       	call   80104d60 <acquire>
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
8010025c:	e9 bf 4b 00 00       	jmp    80104e20 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 46 87 10 80       	push   $0x80108746
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
80100280:	e8 3b 16 00 00       	call   801018c0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 cf 4a 00 00       	call   80104d60 <acquire>
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
801002c5:	e8 a6 43 00 00       	call   80104670 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 b0 3c 00 00       	call   80103f90 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 2c 4b 00 00       	call   80104e20 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 e4 14 00 00       	call   801017e0 <ilock>
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
8010034d:	e8 ce 4a 00 00       	call   80104e20 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 86 14 00 00       	call   801017e0 <ilock>
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
801003a9:	e8 82 2a 00 00       	call   80102e30 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 4d 87 10 80       	push   $0x8010874d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 d6 92 10 80 	movl   $0x801092d6,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 48 00 00       	call   80104c40 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 61 87 10 80       	push   $0x80108761
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
8010043a:	e8 b1 62 00 00       	call   801066f0 <uartputc>
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
801004ec:	e8 ff 61 00 00       	call   801066f0 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 f3 61 00 00       	call   801066f0 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 e7 61 00 00       	call   801066f0 <uartputc>
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
80100524:	e8 f7 49 00 00       	call   80104f20 <memmove>
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
80100541:	e8 2a 49 00 00       	call   80104e70 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 65 87 10 80       	push   $0x80108765
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
801005b1:	0f b6 92 90 87 10 80 	movzbl -0x7fef7870(%edx),%edx
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
8010060f:	e8 ac 12 00 00       	call   801018c0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 40 47 00 00       	call   80104d60 <acquire>
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
80100647:	e8 d4 47 00 00       	call   80104e20 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 8b 11 00 00       	call   801017e0 <ilock>

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
8010071f:	e8 fc 46 00 00       	call   80104e20 <release>
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
801007d0:	ba 78 87 10 80       	mov    $0x80108778,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 6b 45 00 00       	call   80104d60 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 7f 87 10 80       	push   $0x8010877f
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
80100823:	e8 38 45 00 00       	call   80104d60 <acquire>
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
80100888:	e8 93 45 00 00       	call   80104e20 <release>
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
80100916:	e8 15 3f 00 00       	call   80104830 <wakeup>
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
80100997:	e9 74 3f 00 00       	jmp    80104910 <procdump>
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
801009c6:	68 88 87 10 80       	push   $0x80108788
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 4b 42 00 00       	call   80104c20 <initlock>

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
801009f9:	e8 c2 1d 00 00       	call   801027c0 <ioapicenable>
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
80100a16:	81 ec dc 03 00 00    	sub    $0x3dc,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 6f 35 00 00       	call   80103f90 <myproc>
80100a21:	89 c6                	mov    %eax,%esi
80100a23:	89 85 34 fc ff ff    	mov    %eax,-0x3cc(%ebp)
  #ifndef NONE
  // cprintf("EXEC!!\n");
  struct swappedPG swappedPGs[MAX_PSYC_PAGES];
  struct procPG physicalPGs[MAX_PSYC_PAGES];

  memmove(swappedPGs,curproc->swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100a29:	8d 80 90 00 00 00    	lea    0x90(%eax),%eax
80100a2f:	83 ec 04             	sub    $0x4,%esp
80100a32:	8d 9e a0 00 00 00    	lea    0xa0(%esi),%ebx
80100a38:	68 40 01 00 00       	push   $0x140
80100a3d:	89 85 30 fc ff ff    	mov    %eax,-0x3d0(%ebp)
80100a43:	50                   	push   %eax
80100a44:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100a4a:	50                   	push   %eax
80100a4b:	e8 d0 44 00 00       	call   80104f20 <memmove>
  memmove(physicalPGs,curproc->physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100a50:	8d 86 d0 01 00 00    	lea    0x1d0(%esi),%eax
80100a56:	83 c4 0c             	add    $0xc,%esp
80100a59:	81 c6 50 03 00 00    	add    $0x350,%esi
80100a5f:	68 80 01 00 00       	push   $0x180
80100a64:	89 85 2c fc ff ff    	mov    %eax,-0x3d4(%ebp)
80100a6a:	50                   	push   %eax
80100a6b:	89 c7                	mov    %eax,%edi
80100a6d:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100a73:	50                   	push   %eax
80100a74:	e8 a7 44 00 00       	call   80104f20 <memmove>
80100a79:	83 c4 10             	add    $0x10,%esp
80100a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
    resetRefCounter((uint)curproc->physicalPGs[i].va);
80100a80:	83 ec 0c             	sub    $0xc,%esp
80100a83:	ff 37                	pushl  (%edi)
80100a85:	83 c7 18             	add    $0x18,%edi
80100a88:	83 c3 14             	add    $0x14,%ebx
80100a8b:	e8 70 20 00 00       	call   80102b00 <resetRefCounter>
    curproc->physicalPGs[i].va = (char*)0xffffffff;
80100a90:	c7 47 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%edi)
    curproc->physicalPGs[i].next = 0;
80100a97:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%edi)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100a9e:	83 c4 10             	add    $0x10,%esp
    curproc->physicalPGs[i].prev = 0;
80100aa1:	c7 47 fc 00 00 00 00 	movl   $0x0,-0x4(%edi)
    curproc->physicalPGs[i].age = 0;
80100aa8:	c7 47 f0 00 00 00 00 	movl   $0x0,-0x10(%edi)
    curproc->physicalPGs[i].alloceted = 0;
80100aaf:	c7 47 f4 00 00 00 00 	movl   $0x0,-0xc(%edi)
    curproc->swappedPGs[i].va = (char*)0xffffffff;
80100ab6:	c7 43 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebx)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100abd:	39 f7                	cmp    %esi,%edi
80100abf:	75 bf                	jne    80100a80 <exec+0x70>
  }
  /*curproc->nPgsPhysical = 0;
  curproc->allocatedInPhys = 0;*/

  curproc->nPgsSwap = 0;
80100ac1:	8b 85 34 fc ff ff    	mov    -0x3cc(%ebp),%eax
80100ac7:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80100ace:	00 00 00 
  curproc->headPG = 0;
80100ad1:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80100ad8:	00 00 00 
  #endif

  begin_op();
80100adb:	e8 c0 27 00 00       	call   801032a0 <begin_op>

  if((ip = namei(path)) == 0){
80100ae0:	83 ec 0c             	sub    $0xc,%esp
80100ae3:	ff 75 08             	pushl  0x8(%ebp)
80100ae6:	e8 55 15 00 00       	call   80102040 <namei>
80100aeb:	83 c4 10             	add    $0x10,%esp
80100aee:	85 c0                	test   %eax,%eax
80100af0:	89 c6                	mov    %eax,%esi
80100af2:	0f 84 35 02 00 00    	je     80100d2d <exec+0x31d>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100af8:	83 ec 0c             	sub    $0xc,%esp
80100afb:	50                   	push   %eax
80100afc:	e8 df 0c 00 00       	call   801017e0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b01:	8d 85 64 fc ff ff    	lea    -0x39c(%ebp),%eax
80100b07:	6a 34                	push   $0x34
80100b09:	6a 00                	push   $0x0
80100b0b:	50                   	push   %eax
80100b0c:	56                   	push   %esi
80100b0d:	e8 ae 0f 00 00       	call   80101ac0 <readi>
80100b12:	83 c4 20             	add    $0x20,%esp
80100b15:	83 f8 34             	cmp    $0x34,%eax
80100b18:	75 0c                	jne    80100b26 <exec+0x116>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b1a:	81 bd 64 fc ff ff 7f 	cmpl   $0x464c457f,-0x39c(%ebp)
80100b21:	45 4c 46 
80100b24:	74 55                	je     80100b7b <exec+0x16b>
  switchuvm(curproc);
  freevm(oldpgdir);
  return 0;

 bad:
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100b26:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100b2c:	83 ec 04             	sub    $0x4,%esp
80100b2f:	68 40 01 00 00       	push   $0x140
80100b34:	50                   	push   %eax
80100b35:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100b3b:	e8 e0 43 00 00       	call   80104f20 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100b40:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100b46:	83 c4 0c             	add    $0xc,%esp
80100b49:	68 80 01 00 00       	push   $0x180
80100b4e:	50                   	push   %eax
80100b4f:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100b55:	e8 c6 43 00 00       	call   80104f20 <memmove>
80100b5a:	83 c4 10             	add    $0x10,%esp
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b5d:	83 ec 0c             	sub    $0xc,%esp
80100b60:	56                   	push   %esi
80100b61:	e8 0a 0f 00 00       	call   80101a70 <iunlockput>
    end_op();
80100b66:	e8 a5 27 00 00       	call   80103310 <end_op>
80100b6b:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b6e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b73:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b76:	5b                   	pop    %ebx
80100b77:	5e                   	pop    %esi
80100b78:	5f                   	pop    %edi
80100b79:	5d                   	pop    %ebp
80100b7a:	c3                   	ret    
  if((pgdir = setupkvm()) == 0)
80100b7b:	e8 30 6c 00 00       	call   801077b0 <setupkvm>
80100b80:	85 c0                	test   %eax,%eax
80100b82:	89 85 28 fc ff ff    	mov    %eax,-0x3d8(%ebp)
80100b88:	74 9c                	je     80100b26 <exec+0x116>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b8a:	66 83 bd 90 fc ff ff 	cmpw   $0x0,-0x370(%ebp)
80100b91:	00 
80100b92:	8b 85 80 fc ff ff    	mov    -0x380(%ebp),%eax
80100b98:	89 85 24 fc ff ff    	mov    %eax,-0x3dc(%ebp)
80100b9e:	0f 84 04 03 00 00    	je     80100ea8 <exec+0x498>
  sz = 0;
80100ba4:	31 db                	xor    %ebx,%ebx
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ba6:	31 ff                	xor    %edi,%edi
80100ba8:	e9 7d 00 00 00       	jmp    80100c2a <exec+0x21a>
80100bad:	8d 76 00             	lea    0x0(%esi),%esi
    if(ph.type != ELF_PROG_LOAD)
80100bb0:	83 bd 44 fc ff ff 01 	cmpl   $0x1,-0x3bc(%ebp)
80100bb7:	75 63                	jne    80100c1c <exec+0x20c>
    if(ph.memsz < ph.filesz)
80100bb9:	8b 85 58 fc ff ff    	mov    -0x3a8(%ebp),%eax
80100bbf:	3b 85 54 fc ff ff    	cmp    -0x3ac(%ebp),%eax
80100bc5:	0f 82 86 00 00 00    	jb     80100c51 <exec+0x241>
80100bcb:	03 85 4c fc ff ff    	add    -0x3b4(%ebp),%eax
80100bd1:	72 7e                	jb     80100c51 <exec+0x241>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bd3:	83 ec 04             	sub    $0x4,%esp
80100bd6:	50                   	push   %eax
80100bd7:	53                   	push   %ebx
80100bd8:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100bde:	e8 dd 77 00 00       	call   801083c0 <allocuvm>
80100be3:	83 c4 10             	add    $0x10,%esp
80100be6:	85 c0                	test   %eax,%eax
80100be8:	89 c3                	mov    %eax,%ebx
80100bea:	74 65                	je     80100c51 <exec+0x241>
    if(ph.vaddr % PGSIZE != 0)
80100bec:	8b 85 4c fc ff ff    	mov    -0x3b4(%ebp),%eax
80100bf2:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bf7:	75 58                	jne    80100c51 <exec+0x241>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bf9:	83 ec 0c             	sub    $0xc,%esp
80100bfc:	ff b5 54 fc ff ff    	pushl  -0x3ac(%ebp)
80100c02:	ff b5 48 fc ff ff    	pushl  -0x3b8(%ebp)
80100c08:	56                   	push   %esi
80100c09:	50                   	push   %eax
80100c0a:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100c10:	e8 eb 68 00 00       	call   80107500 <loaduvm>
80100c15:	83 c4 20             	add    $0x20,%esp
80100c18:	85 c0                	test   %eax,%eax
80100c1a:	78 35                	js     80100c51 <exec+0x241>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c1c:	0f b7 85 90 fc ff ff 	movzwl -0x370(%ebp),%eax
80100c23:	83 c7 01             	add    $0x1,%edi
80100c26:	39 f8                	cmp    %edi,%eax
80100c28:	7e 6f                	jle    80100c99 <exec+0x289>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c2a:	89 f8                	mov    %edi,%eax
80100c2c:	6a 20                	push   $0x20
80100c2e:	c1 e0 05             	shl    $0x5,%eax
80100c31:	03 85 24 fc ff ff    	add    -0x3dc(%ebp),%eax
80100c37:	50                   	push   %eax
80100c38:	8d 85 44 fc ff ff    	lea    -0x3bc(%ebp),%eax
80100c3e:	50                   	push   %eax
80100c3f:	56                   	push   %esi
80100c40:	e8 7b 0e 00 00       	call   80101ac0 <readi>
80100c45:	83 c4 10             	add    $0x10,%esp
80100c48:	83 f8 20             	cmp    $0x20,%eax
80100c4b:	0f 84 5f ff ff ff    	je     80100bb0 <exec+0x1a0>
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100c51:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100c57:	83 ec 04             	sub    $0x4,%esp
80100c5a:	68 40 01 00 00       	push   $0x140
80100c5f:	50                   	push   %eax
80100c60:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100c66:	e8 b5 42 00 00       	call   80104f20 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100c6b:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100c71:	83 c4 0c             	add    $0xc,%esp
80100c74:	68 80 01 00 00       	push   $0x180
80100c79:	50                   	push   %eax
80100c7a:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100c80:	e8 9b 42 00 00       	call   80104f20 <memmove>
    freevm(pgdir);
80100c85:	58                   	pop    %eax
80100c86:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100c8c:	e8 9f 6a 00 00       	call   80107730 <freevm>
80100c91:	83 c4 10             	add    $0x10,%esp
80100c94:	e9 c4 fe ff ff       	jmp    80100b5d <exec+0x14d>
80100c99:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80100c9f:	89 df                	mov    %ebx,%edi
80100ca1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100ca7:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100cad:	83 ec 0c             	sub    $0xc,%esp
80100cb0:	89 85 24 fc ff ff    	mov    %eax,-0x3dc(%ebp)
80100cb6:	56                   	push   %esi
80100cb7:	e8 b4 0d 00 00       	call   80101a70 <iunlockput>
  end_op();
80100cbc:	e8 4f 26 00 00       	call   80103310 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cc1:	8b 85 24 fc ff ff    	mov    -0x3dc(%ebp),%eax
80100cc7:	83 c4 0c             	add    $0xc,%esp
80100cca:	50                   	push   %eax
80100ccb:	57                   	push   %edi
80100ccc:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100cd2:	e8 e9 76 00 00       	call   801083c0 <allocuvm>
80100cd7:	83 c4 10             	add    $0x10,%esp
80100cda:	85 c0                	test   %eax,%eax
80100cdc:	89 c3                	mov    %eax,%ebx
80100cde:	75 6c                	jne    80100d4c <exec+0x33c>
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100ce0:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100ce6:	83 ec 04             	sub    $0x4,%esp
80100ce9:	68 40 01 00 00       	push   $0x140
80100cee:	50                   	push   %eax
80100cef:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100cf5:	e8 26 42 00 00       	call   80104f20 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100cfa:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100d00:	83 c4 0c             	add    $0xc,%esp
80100d03:	68 80 01 00 00       	push   $0x180
80100d08:	50                   	push   %eax
80100d09:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100d0f:	e8 0c 42 00 00       	call   80104f20 <memmove>
    freevm(pgdir);
80100d14:	59                   	pop    %ecx
80100d15:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100d1b:	e8 10 6a 00 00       	call   80107730 <freevm>
80100d20:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d28:	e9 46 fe ff ff       	jmp    80100b73 <exec+0x163>
    end_op();
80100d2d:	e8 de 25 00 00       	call   80103310 <end_op>
    cprintf("exec: fail\n");
80100d32:	83 ec 0c             	sub    $0xc,%esp
80100d35:	68 a1 87 10 80       	push   $0x801087a1
80100d3a:	e8 21 f9 ff ff       	call   80100660 <cprintf>
    return -1;
80100d3f:	83 c4 10             	add    $0x10,%esp
80100d42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d47:	e9 27 fe ff ff       	jmp    80100b73 <exec+0x163>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d4c:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100d52:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100d55:	31 ff                	xor    %edi,%edi
80100d57:	89 de                	mov    %ebx,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d59:	50                   	push   %eax
80100d5a:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100d60:	e8 eb 6a 00 00       	call   80107850 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d65:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	8d 8d 98 fc ff ff    	lea    -0x368(%ebp),%ecx
80100d71:	8b 00                	mov    (%eax),%eax
80100d73:	85 c0                	test   %eax,%eax
80100d75:	75 12                	jne    80100d89 <exec+0x379>
80100d77:	eb 67                	jmp    80100de0 <exec+0x3d0>
80100d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100d80:	83 ff 20             	cmp    $0x20,%edi
80100d83:	0f 84 57 ff ff ff    	je     80100ce0 <exec+0x2d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d89:	83 ec 0c             	sub    $0xc,%esp
80100d8c:	50                   	push   %eax
80100d8d:	e8 fe 42 00 00       	call   80105090 <strlen>
80100d92:	f7 d0                	not    %eax
80100d94:	01 c6                	add    %eax,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d96:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d99:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d9a:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d9d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100da0:	e8 eb 42 00 00       	call   80105090 <strlen>
80100da5:	83 c0 01             	add    $0x1,%eax
80100da8:	50                   	push   %eax
80100da9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dac:	ff 34 b8             	pushl  (%eax,%edi,4)
80100daf:	56                   	push   %esi
80100db0:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
80100db6:	e8 15 6c 00 00       	call   801079d0 <copyout>
80100dbb:	83 c4 20             	add    $0x20,%esp
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	0f 88 1a ff ff ff    	js     80100ce0 <exec+0x2d0>
  for(argc = 0; argv[argc]; argc++) {
80100dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100dc9:	89 b4 bd a4 fc ff ff 	mov    %esi,-0x35c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100dd0:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100dd3:	8d 8d 98 fc ff ff    	lea    -0x368(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100dd9:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100ddc:	85 c0                	test   %eax,%eax
80100dde:	75 a0                	jne    80100d80 <exec+0x370>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100de0:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100de7:	89 f2                	mov    %esi,%edx
  ustack[3+argc] = 0;
80100de9:	c7 84 bd a4 fc ff ff 	movl   $0x0,-0x35c(%ebp,%edi,4)
80100df0:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100df4:	c7 85 98 fc ff ff ff 	movl   $0xffffffff,-0x368(%ebp)
80100dfb:	ff ff ff 
  ustack[1] = argc;
80100dfe:	89 bd 9c fc ff ff    	mov    %edi,-0x364(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e04:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100e06:	83 c0 0c             	add    $0xc,%eax
80100e09:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e0b:	50                   	push   %eax
80100e0c:	51                   	push   %ecx
80100e0d:	56                   	push   %esi
80100e0e:	ff b5 28 fc ff ff    	pushl  -0x3d8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e14:	89 95 a0 fc ff ff    	mov    %edx,-0x360(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e1a:	e8 b1 6b 00 00       	call   801079d0 <copyout>
80100e1f:	83 c4 10             	add    $0x10,%esp
80100e22:	85 c0                	test   %eax,%eax
80100e24:	0f 88 b6 fe ff ff    	js     80100ce0 <exec+0x2d0>
  for(last=s=path; *s; s++)
80100e2a:	8b 45 08             	mov    0x8(%ebp),%eax
80100e2d:	0f b6 00             	movzbl (%eax),%eax
80100e30:	84 c0                	test   %al,%al
80100e32:	74 17                	je     80100e4b <exec+0x43b>
80100e34:	8b 55 08             	mov    0x8(%ebp),%edx
80100e37:	89 d1                	mov    %edx,%ecx
80100e39:	83 c1 01             	add    $0x1,%ecx
80100e3c:	3c 2f                	cmp    $0x2f,%al
80100e3e:	0f b6 01             	movzbl (%ecx),%eax
80100e41:	0f 44 d1             	cmove  %ecx,%edx
80100e44:	84 c0                	test   %al,%al
80100e46:	75 f1                	jne    80100e39 <exec+0x429>
80100e48:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e4b:	8b bd 34 fc ff ff    	mov    -0x3cc(%ebp),%edi
80100e51:	83 ec 04             	sub    $0x4,%esp
80100e54:	6a 10                	push   $0x10
80100e56:	ff 75 08             	pushl  0x8(%ebp)
80100e59:	8d 47 6c             	lea    0x6c(%edi),%eax
80100e5c:	50                   	push   %eax
80100e5d:	e8 ee 41 00 00       	call   80105050 <safestrcpy>
  curproc->pgdir = pgdir;
80100e62:	8b 8d 28 fc ff ff    	mov    -0x3d8(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e68:	8b 47 04             	mov    0x4(%edi),%eax
  curproc->sz = sz;
80100e6b:	89 1f                	mov    %ebx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e6d:	8b 57 18             	mov    0x18(%edi),%edx
  curproc->pgdir = pgdir;
80100e70:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e73:	8b 8d 7c fc ff ff    	mov    -0x384(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e79:	89 85 34 fc ff ff    	mov    %eax,-0x3cc(%ebp)
  curproc->tf->eip = elf.entry;  // main
80100e7f:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80100e82:	8b 57 18             	mov    0x18(%edi),%edx
80100e85:	89 72 44             	mov    %esi,0x44(%edx)
  switchuvm(curproc);
80100e88:	89 3c 24             	mov    %edi,(%esp)
80100e8b:	e8 e0 64 00 00       	call   80107370 <switchuvm>
  freevm(oldpgdir);
80100e90:	8b 85 34 fc ff ff    	mov    -0x3cc(%ebp),%eax
80100e96:	89 04 24             	mov    %eax,(%esp)
80100e99:	e8 92 68 00 00       	call   80107730 <freevm>
  return 0;
80100e9e:	83 c4 10             	add    $0x10,%esp
80100ea1:	31 c0                	xor    %eax,%eax
80100ea3:	e9 cb fc ff ff       	jmp    80100b73 <exec+0x163>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ea8:	31 ff                	xor    %edi,%edi
80100eaa:	b8 00 20 00 00       	mov    $0x2000,%eax
80100eaf:	e9 f9 fd ff ff       	jmp    80100cad <exec+0x29d>
80100eb4:	66 90                	xchg   %ax,%ax
80100eb6:	66 90                	xchg   %ax,%ax
80100eb8:	66 90                	xchg   %ax,%ax
80100eba:	66 90                	xchg   %ax,%ax
80100ebc:	66 90                	xchg   %ax,%ax
80100ebe:	66 90                	xchg   %ax,%ax

80100ec0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ec6:	68 ad 87 10 80       	push   $0x801087ad
80100ecb:	68 c0 1f 11 80       	push   $0x80111fc0
80100ed0:	e8 4b 3d 00 00       	call   80104c20 <initlock>
}
80100ed5:	83 c4 10             	add    $0x10,%esp
80100ed8:	c9                   	leave  
80100ed9:	c3                   	ret    
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ee0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ee4:	bb f4 1f 11 80       	mov    $0x80111ff4,%ebx
{
80100ee9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100eec:	68 c0 1f 11 80       	push   $0x80111fc0
80100ef1:	e8 6a 3e 00 00       	call   80104d60 <acquire>
80100ef6:	83 c4 10             	add    $0x10,%esp
80100ef9:	eb 10                	jmp    80100f0b <filealloc+0x2b>
80100efb:	90                   	nop
80100efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f00:	83 c3 18             	add    $0x18,%ebx
80100f03:	81 fb 54 29 11 80    	cmp    $0x80112954,%ebx
80100f09:	73 25                	jae    80100f30 <filealloc+0x50>
    if(f->ref == 0){
80100f0b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f0e:	85 c0                	test   %eax,%eax
80100f10:	75 ee                	jne    80100f00 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f12:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f15:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f1c:	68 c0 1f 11 80       	push   $0x80111fc0
80100f21:	e8 fa 3e 00 00       	call   80104e20 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f26:	89 d8                	mov    %ebx,%eax
      return f;
80100f28:	83 c4 10             	add    $0x10,%esp
}
80100f2b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f2e:	c9                   	leave  
80100f2f:	c3                   	ret    
  release(&ftable.lock);
80100f30:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f33:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f35:	68 c0 1f 11 80       	push   $0x80111fc0
80100f3a:	e8 e1 3e 00 00       	call   80104e20 <release>
}
80100f3f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f41:	83 c4 10             	add    $0x10,%esp
}
80100f44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f47:	c9                   	leave  
80100f48:	c3                   	ret    
80100f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 10             	sub    $0x10,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f5a:	68 c0 1f 11 80       	push   $0x80111fc0
80100f5f:	e8 fc 3d 00 00       	call   80104d60 <acquire>
  if(f->ref < 1)
80100f64:	8b 43 04             	mov    0x4(%ebx),%eax
80100f67:	83 c4 10             	add    $0x10,%esp
80100f6a:	85 c0                	test   %eax,%eax
80100f6c:	7e 1a                	jle    80100f88 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f6e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f71:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f74:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f77:	68 c0 1f 11 80       	push   $0x80111fc0
80100f7c:	e8 9f 3e 00 00       	call   80104e20 <release>
  return f;
}
80100f81:	89 d8                	mov    %ebx,%eax
80100f83:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f86:	c9                   	leave  
80100f87:	c3                   	ret    
    panic("filedup");
80100f88:	83 ec 0c             	sub    $0xc,%esp
80100f8b:	68 b4 87 10 80       	push   $0x801087b4
80100f90:	e8 fb f3 ff ff       	call   80100390 <panic>
80100f95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fa0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 28             	sub    $0x28,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100fac:	68 c0 1f 11 80       	push   $0x80111fc0
80100fb1:	e8 aa 3d 00 00       	call   80104d60 <acquire>
  if(f->ref < 1)
80100fb6:	8b 43 04             	mov    0x4(%ebx),%eax
80100fb9:	83 c4 10             	add    $0x10,%esp
80100fbc:	85 c0                	test   %eax,%eax
80100fbe:	0f 8e 9b 00 00 00    	jle    8010105f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100fc4:	83 e8 01             	sub    $0x1,%eax
80100fc7:	85 c0                	test   %eax,%eax
80100fc9:	89 43 04             	mov    %eax,0x4(%ebx)
80100fcc:	74 1a                	je     80100fe8 <fileclose+0x48>
    release(&ftable.lock);
80100fce:	c7 45 08 c0 1f 11 80 	movl   $0x80111fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fd8:	5b                   	pop    %ebx
80100fd9:	5e                   	pop    %esi
80100fda:	5f                   	pop    %edi
80100fdb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fdc:	e9 3f 3e 00 00       	jmp    80104e20 <release>
80100fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100fe8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100fec:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100fee:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100ff1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100ff4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100ffa:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ffd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80101000:	68 c0 1f 11 80       	push   $0x80111fc0
  ff = *f;
80101005:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101008:	e8 13 3e 00 00       	call   80104e20 <release>
  if(ff.type == FD_PIPE)
8010100d:	83 c4 10             	add    $0x10,%esp
80101010:	83 ff 01             	cmp    $0x1,%edi
80101013:	74 13                	je     80101028 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80101015:	83 ff 02             	cmp    $0x2,%edi
80101018:	74 26                	je     80101040 <fileclose+0xa0>
}
8010101a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010101d:	5b                   	pop    %ebx
8010101e:	5e                   	pop    %esi
8010101f:	5f                   	pop    %edi
80101020:	5d                   	pop    %ebp
80101021:	c3                   	ret    
80101022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101028:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010102c:	83 ec 08             	sub    $0x8,%esp
8010102f:	53                   	push   %ebx
80101030:	56                   	push   %esi
80101031:	e8 1a 2a 00 00       	call   80103a50 <pipeclose>
80101036:	83 c4 10             	add    $0x10,%esp
80101039:	eb df                	jmp    8010101a <fileclose+0x7a>
8010103b:	90                   	nop
8010103c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80101040:	e8 5b 22 00 00       	call   801032a0 <begin_op>
    iput(ff.ip);
80101045:	83 ec 0c             	sub    $0xc,%esp
80101048:	ff 75 e0             	pushl  -0x20(%ebp)
8010104b:	e8 c0 08 00 00       	call   80101910 <iput>
    end_op();
80101050:	83 c4 10             	add    $0x10,%esp
}
80101053:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101056:	5b                   	pop    %ebx
80101057:	5e                   	pop    %esi
80101058:	5f                   	pop    %edi
80101059:	5d                   	pop    %ebp
    end_op();
8010105a:	e9 b1 22 00 00       	jmp    80103310 <end_op>
    panic("fileclose");
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	68 bc 87 10 80       	push   $0x801087bc
80101067:	e8 24 f3 ff ff       	call   80100390 <panic>
8010106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101070 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	53                   	push   %ebx
80101074:	83 ec 04             	sub    $0x4,%esp
80101077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010107a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010107d:	75 31                	jne    801010b0 <filestat+0x40>
    ilock(f->ip);
8010107f:	83 ec 0c             	sub    $0xc,%esp
80101082:	ff 73 10             	pushl  0x10(%ebx)
80101085:	e8 56 07 00 00       	call   801017e0 <ilock>
    stati(f->ip, st);
8010108a:	58                   	pop    %eax
8010108b:	5a                   	pop    %edx
8010108c:	ff 75 0c             	pushl  0xc(%ebp)
8010108f:	ff 73 10             	pushl  0x10(%ebx)
80101092:	e8 f9 09 00 00       	call   80101a90 <stati>
    iunlock(f->ip);
80101097:	59                   	pop    %ecx
80101098:	ff 73 10             	pushl  0x10(%ebx)
8010109b:	e8 20 08 00 00       	call   801018c0 <iunlock>
    return 0;
801010a0:	83 c4 10             	add    $0x10,%esp
801010a3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
801010a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010a8:	c9                   	leave  
801010a9:	c3                   	ret    
801010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
801010b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010b5:	eb ee                	jmp    801010a5 <filestat+0x35>
801010b7:	89 f6                	mov    %esi,%esi
801010b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801010c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	57                   	push   %edi
801010c4:	56                   	push   %esi
801010c5:	53                   	push   %ebx
801010c6:	83 ec 0c             	sub    $0xc,%esp
801010c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801010cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010d6:	74 60                	je     80101138 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010d8:	8b 03                	mov    (%ebx),%eax
801010da:	83 f8 01             	cmp    $0x1,%eax
801010dd:	74 41                	je     80101120 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010df:	83 f8 02             	cmp    $0x2,%eax
801010e2:	75 5b                	jne    8010113f <fileread+0x7f>
    ilock(f->ip);
801010e4:	83 ec 0c             	sub    $0xc,%esp
801010e7:	ff 73 10             	pushl  0x10(%ebx)
801010ea:	e8 f1 06 00 00       	call   801017e0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010ef:	57                   	push   %edi
801010f0:	ff 73 14             	pushl  0x14(%ebx)
801010f3:	56                   	push   %esi
801010f4:	ff 73 10             	pushl  0x10(%ebx)
801010f7:	e8 c4 09 00 00       	call   80101ac0 <readi>
801010fc:	83 c4 20             	add    $0x20,%esp
801010ff:	85 c0                	test   %eax,%eax
80101101:	89 c6                	mov    %eax,%esi
80101103:	7e 03                	jle    80101108 <fileread+0x48>
      f->off += r;
80101105:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101108:	83 ec 0c             	sub    $0xc,%esp
8010110b:	ff 73 10             	pushl  0x10(%ebx)
8010110e:	e8 ad 07 00 00       	call   801018c0 <iunlock>
    return r;
80101113:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101116:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101119:	89 f0                	mov    %esi,%eax
8010111b:	5b                   	pop    %ebx
8010111c:	5e                   	pop    %esi
8010111d:	5f                   	pop    %edi
8010111e:	5d                   	pop    %ebp
8010111f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101120:	8b 43 0c             	mov    0xc(%ebx),%eax
80101123:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101126:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101129:	5b                   	pop    %ebx
8010112a:	5e                   	pop    %esi
8010112b:	5f                   	pop    %edi
8010112c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010112d:	e9 ce 2a 00 00       	jmp    80103c00 <piperead>
80101132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101138:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010113d:	eb d7                	jmp    80101116 <fileread+0x56>
  panic("fileread");
8010113f:	83 ec 0c             	sub    $0xc,%esp
80101142:	68 c6 87 10 80       	push   $0x801087c6
80101147:	e8 44 f2 ff ff       	call   80100390 <panic>
8010114c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101150 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 1c             	sub    $0x1c,%esp
80101159:	8b 75 08             	mov    0x8(%ebp),%esi
8010115c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010115f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101163:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101166:	8b 45 10             	mov    0x10(%ebp),%eax
80101169:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010116c:	0f 84 aa 00 00 00    	je     8010121c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101172:	8b 06                	mov    (%esi),%eax
80101174:	83 f8 01             	cmp    $0x1,%eax
80101177:	0f 84 c3 00 00 00    	je     80101240 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010117d:	83 f8 02             	cmp    $0x2,%eax
80101180:	0f 85 d9 00 00 00    	jne    8010125f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101186:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101189:	31 ff                	xor    %edi,%edi
    while(i < n){
8010118b:	85 c0                	test   %eax,%eax
8010118d:	7f 34                	jg     801011c3 <filewrite+0x73>
8010118f:	e9 9c 00 00 00       	jmp    80101230 <filewrite+0xe0>
80101194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101198:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010119b:	83 ec 0c             	sub    $0xc,%esp
8010119e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801011a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011a4:	e8 17 07 00 00       	call   801018c0 <iunlock>
      end_op();
801011a9:	e8 62 21 00 00       	call   80103310 <end_op>
801011ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011b1:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
801011b4:	39 c3                	cmp    %eax,%ebx
801011b6:	0f 85 96 00 00 00    	jne    80101252 <filewrite+0x102>
        panic("short filewrite");
      i += r;
801011bc:	01 df                	add    %ebx,%edi
    while(i < n){
801011be:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011c1:	7e 6d                	jle    80101230 <filewrite+0xe0>
      int n1 = n - i;
801011c3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011c6:	b8 00 06 00 00       	mov    $0x600,%eax
801011cb:	29 fb                	sub    %edi,%ebx
801011cd:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801011d3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011d6:	e8 c5 20 00 00       	call   801032a0 <begin_op>
      ilock(f->ip);
801011db:	83 ec 0c             	sub    $0xc,%esp
801011de:	ff 76 10             	pushl  0x10(%esi)
801011e1:	e8 fa 05 00 00       	call   801017e0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e9:	53                   	push   %ebx
801011ea:	ff 76 14             	pushl  0x14(%esi)
801011ed:	01 f8                	add    %edi,%eax
801011ef:	50                   	push   %eax
801011f0:	ff 76 10             	pushl  0x10(%esi)
801011f3:	e8 c8 09 00 00       	call   80101bc0 <writei>
801011f8:	83 c4 20             	add    $0x20,%esp
801011fb:	85 c0                	test   %eax,%eax
801011fd:	7f 99                	jg     80101198 <filewrite+0x48>
      iunlock(f->ip);
801011ff:	83 ec 0c             	sub    $0xc,%esp
80101202:	ff 76 10             	pushl  0x10(%esi)
80101205:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101208:	e8 b3 06 00 00       	call   801018c0 <iunlock>
      end_op();
8010120d:	e8 fe 20 00 00       	call   80103310 <end_op>
      if(r < 0)
80101212:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101215:	83 c4 10             	add    $0x10,%esp
80101218:	85 c0                	test   %eax,%eax
8010121a:	74 98                	je     801011b4 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010121c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010121f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101224:	89 f8                	mov    %edi,%eax
80101226:	5b                   	pop    %ebx
80101227:	5e                   	pop    %esi
80101228:	5f                   	pop    %edi
80101229:	5d                   	pop    %ebp
8010122a:	c3                   	ret    
8010122b:	90                   	nop
8010122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101230:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101233:	75 e7                	jne    8010121c <filewrite+0xcc>
}
80101235:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101238:	89 f8                	mov    %edi,%eax
8010123a:	5b                   	pop    %ebx
8010123b:	5e                   	pop    %esi
8010123c:	5f                   	pop    %edi
8010123d:	5d                   	pop    %ebp
8010123e:	c3                   	ret    
8010123f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101240:	8b 46 0c             	mov    0xc(%esi),%eax
80101243:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101246:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101249:	5b                   	pop    %ebx
8010124a:	5e                   	pop    %esi
8010124b:	5f                   	pop    %edi
8010124c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010124d:	e9 9e 28 00 00       	jmp    80103af0 <pipewrite>
        panic("short filewrite");
80101252:	83 ec 0c             	sub    $0xc,%esp
80101255:	68 cf 87 10 80       	push   $0x801087cf
8010125a:	e8 31 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010125f:	83 ec 0c             	sub    $0xc,%esp
80101262:	68 d5 87 10 80       	push   $0x801087d5
80101267:	e8 24 f1 ff ff       	call   80100390 <panic>
8010126c:	66 90                	xchg   %ax,%ax
8010126e:	66 90                	xchg   %ax,%ax

80101270 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101270:	55                   	push   %ebp
80101271:	89 e5                	mov    %esp,%ebp
80101273:	56                   	push   %esi
80101274:	53                   	push   %ebx
80101275:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101277:	c1 ea 0c             	shr    $0xc,%edx
8010127a:	03 15 d8 29 11 80    	add    0x801129d8,%edx
80101280:	83 ec 08             	sub    $0x8,%esp
80101283:	52                   	push   %edx
80101284:	50                   	push   %eax
80101285:	e8 46 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010128a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010128c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010128f:	ba 01 00 00 00       	mov    $0x1,%edx
80101294:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101297:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010129d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801012a0:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801012a2:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801012a7:	85 d1                	test   %edx,%ecx
801012a9:	74 25                	je     801012d0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801012ab:	f7 d2                	not    %edx
801012ad:	89 c6                	mov    %eax,%esi
  log_write(bp);
801012af:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801012b2:	21 ca                	and    %ecx,%edx
801012b4:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
801012b8:	56                   	push   %esi
801012b9:	e8 b2 21 00 00       	call   80103470 <log_write>
  brelse(bp);
801012be:	89 34 24             	mov    %esi,(%esp)
801012c1:	e8 1a ef ff ff       	call   801001e0 <brelse>
}
801012c6:	83 c4 10             	add    $0x10,%esp
801012c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5d                   	pop    %ebp
801012cf:	c3                   	ret    
    panic("freeing free block");
801012d0:	83 ec 0c             	sub    $0xc,%esp
801012d3:	68 df 87 10 80       	push   $0x801087df
801012d8:	e8 b3 f0 ff ff       	call   80100390 <panic>
801012dd:	8d 76 00             	lea    0x0(%esi),%esi

801012e0 <balloc>:
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	57                   	push   %edi
801012e4:	56                   	push   %esi
801012e5:	53                   	push   %ebx
801012e6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801012e9:	8b 0d c0 29 11 80    	mov    0x801129c0,%ecx
{
801012ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012f2:	85 c9                	test   %ecx,%ecx
801012f4:	0f 84 87 00 00 00    	je     80101381 <balloc+0xa1>
801012fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101301:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101304:	83 ec 08             	sub    $0x8,%esp
80101307:	89 f0                	mov    %esi,%eax
80101309:	c1 f8 0c             	sar    $0xc,%eax
8010130c:	03 05 d8 29 11 80    	add    0x801129d8,%eax
80101312:	50                   	push   %eax
80101313:	ff 75 d8             	pushl  -0x28(%ebp)
80101316:	e8 b5 ed ff ff       	call   801000d0 <bread>
8010131b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010131e:	a1 c0 29 11 80       	mov    0x801129c0,%eax
80101323:	83 c4 10             	add    $0x10,%esp
80101326:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101329:	31 c0                	xor    %eax,%eax
8010132b:	eb 2f                	jmp    8010135c <balloc+0x7c>
8010132d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101330:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101332:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101335:	bb 01 00 00 00       	mov    $0x1,%ebx
8010133a:	83 e1 07             	and    $0x7,%ecx
8010133d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010133f:	89 c1                	mov    %eax,%ecx
80101341:	c1 f9 03             	sar    $0x3,%ecx
80101344:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101349:	85 df                	test   %ebx,%edi
8010134b:	89 fa                	mov    %edi,%edx
8010134d:	74 41                	je     80101390 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010134f:	83 c0 01             	add    $0x1,%eax
80101352:	83 c6 01             	add    $0x1,%esi
80101355:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010135a:	74 05                	je     80101361 <balloc+0x81>
8010135c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010135f:	77 cf                	ja     80101330 <balloc+0x50>
    brelse(bp);
80101361:	83 ec 0c             	sub    $0xc,%esp
80101364:	ff 75 e4             	pushl  -0x1c(%ebp)
80101367:	e8 74 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010136c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101373:	83 c4 10             	add    $0x10,%esp
80101376:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101379:	39 05 c0 29 11 80    	cmp    %eax,0x801129c0
8010137f:	77 80                	ja     80101301 <balloc+0x21>
  panic("balloc: out of blocks");
80101381:	83 ec 0c             	sub    $0xc,%esp
80101384:	68 f2 87 10 80       	push   $0x801087f2
80101389:	e8 02 f0 ff ff       	call   80100390 <panic>
8010138e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101390:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101393:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101396:	09 da                	or     %ebx,%edx
80101398:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010139c:	57                   	push   %edi
8010139d:	e8 ce 20 00 00       	call   80103470 <log_write>
        brelse(bp);
801013a2:	89 3c 24             	mov    %edi,(%esp)
801013a5:	e8 36 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801013aa:	58                   	pop    %eax
801013ab:	5a                   	pop    %edx
801013ac:	56                   	push   %esi
801013ad:	ff 75 d8             	pushl  -0x28(%ebp)
801013b0:	e8 1b ed ff ff       	call   801000d0 <bread>
801013b5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801013b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ba:	83 c4 0c             	add    $0xc,%esp
801013bd:	68 00 02 00 00       	push   $0x200
801013c2:	6a 00                	push   $0x0
801013c4:	50                   	push   %eax
801013c5:	e8 a6 3a 00 00       	call   80104e70 <memset>
  log_write(bp);
801013ca:	89 1c 24             	mov    %ebx,(%esp)
801013cd:	e8 9e 20 00 00       	call   80103470 <log_write>
  brelse(bp);
801013d2:	89 1c 24             	mov    %ebx,(%esp)
801013d5:	e8 06 ee ff ff       	call   801001e0 <brelse>
}
801013da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013dd:	89 f0                	mov    %esi,%eax
801013df:	5b                   	pop    %ebx
801013e0:	5e                   	pop    %esi
801013e1:	5f                   	pop    %edi
801013e2:	5d                   	pop    %ebp
801013e3:	c3                   	ret    
801013e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	57                   	push   %edi
801013f4:	56                   	push   %esi
801013f5:	53                   	push   %ebx
801013f6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013f8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013fa:	bb 14 2a 11 80       	mov    $0x80112a14,%ebx
{
801013ff:	83 ec 28             	sub    $0x28,%esp
80101402:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101405:	68 e0 29 11 80       	push   $0x801129e0
8010140a:	e8 51 39 00 00       	call   80104d60 <acquire>
8010140f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101412:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101415:	eb 17                	jmp    8010142e <iget+0x3e>
80101417:	89 f6                	mov    %esi,%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101420:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101426:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010142c:	73 22                	jae    80101450 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010142e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101431:	85 c9                	test   %ecx,%ecx
80101433:	7e 04                	jle    80101439 <iget+0x49>
80101435:	39 3b                	cmp    %edi,(%ebx)
80101437:	74 4f                	je     80101488 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101439:	85 f6                	test   %esi,%esi
8010143b:	75 e3                	jne    80101420 <iget+0x30>
8010143d:	85 c9                	test   %ecx,%ecx
8010143f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101442:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101448:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010144e:	72 de                	jb     8010142e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101450:	85 f6                	test   %esi,%esi
80101452:	74 5b                	je     801014af <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101454:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101457:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101459:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010145c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101463:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010146a:	68 e0 29 11 80       	push   $0x801129e0
8010146f:	e8 ac 39 00 00       	call   80104e20 <release>

  return ip;
80101474:	83 c4 10             	add    $0x10,%esp
}
80101477:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010147a:	89 f0                	mov    %esi,%eax
8010147c:	5b                   	pop    %ebx
8010147d:	5e                   	pop    %esi
8010147e:	5f                   	pop    %edi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
80101481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101488:	39 53 04             	cmp    %edx,0x4(%ebx)
8010148b:	75 ac                	jne    80101439 <iget+0x49>
      release(&icache.lock);
8010148d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101490:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101493:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101495:	68 e0 29 11 80       	push   $0x801129e0
      ip->ref++;
8010149a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010149d:	e8 7e 39 00 00       	call   80104e20 <release>
      return ip;
801014a2:	83 c4 10             	add    $0x10,%esp
}
801014a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a8:	89 f0                	mov    %esi,%eax
801014aa:	5b                   	pop    %ebx
801014ab:	5e                   	pop    %esi
801014ac:	5f                   	pop    %edi
801014ad:	5d                   	pop    %ebp
801014ae:	c3                   	ret    
    panic("iget: no inodes");
801014af:	83 ec 0c             	sub    $0xc,%esp
801014b2:	68 08 88 10 80       	push   $0x80108808
801014b7:	e8 d4 ee ff ff       	call   80100390 <panic>
801014bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	57                   	push   %edi
801014c4:	56                   	push   %esi
801014c5:	53                   	push   %ebx
801014c6:	89 c6                	mov    %eax,%esi
801014c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014cb:	83 fa 0b             	cmp    $0xb,%edx
801014ce:	77 18                	ja     801014e8 <bmap+0x28>
801014d0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801014d3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801014d6:	85 db                	test   %ebx,%ebx
801014d8:	74 76                	je     80101550 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014dd:	89 d8                	mov    %ebx,%eax
801014df:	5b                   	pop    %ebx
801014e0:	5e                   	pop    %esi
801014e1:	5f                   	pop    %edi
801014e2:	5d                   	pop    %ebp
801014e3:	c3                   	ret    
801014e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801014e8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801014eb:	83 fb 7f             	cmp    $0x7f,%ebx
801014ee:	0f 87 90 00 00 00    	ja     80101584 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801014f4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801014fa:	8b 00                	mov    (%eax),%eax
801014fc:	85 d2                	test   %edx,%edx
801014fe:	74 70                	je     80101570 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101500:	83 ec 08             	sub    $0x8,%esp
80101503:	52                   	push   %edx
80101504:	50                   	push   %eax
80101505:	e8 c6 eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010150a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010150e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101511:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101513:	8b 1a                	mov    (%edx),%ebx
80101515:	85 db                	test   %ebx,%ebx
80101517:	75 1d                	jne    80101536 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101519:	8b 06                	mov    (%esi),%eax
8010151b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010151e:	e8 bd fd ff ff       	call   801012e0 <balloc>
80101523:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101526:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101529:	89 c3                	mov    %eax,%ebx
8010152b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010152d:	57                   	push   %edi
8010152e:	e8 3d 1f 00 00       	call   80103470 <log_write>
80101533:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101536:	83 ec 0c             	sub    $0xc,%esp
80101539:	57                   	push   %edi
8010153a:	e8 a1 ec ff ff       	call   801001e0 <brelse>
8010153f:	83 c4 10             	add    $0x10,%esp
}
80101542:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101545:	89 d8                	mov    %ebx,%eax
80101547:	5b                   	pop    %ebx
80101548:	5e                   	pop    %esi
80101549:	5f                   	pop    %edi
8010154a:	5d                   	pop    %ebp
8010154b:	c3                   	ret    
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101550:	8b 00                	mov    (%eax),%eax
80101552:	e8 89 fd ff ff       	call   801012e0 <balloc>
80101557:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010155a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010155d:	89 c3                	mov    %eax,%ebx
}
8010155f:	89 d8                	mov    %ebx,%eax
80101561:	5b                   	pop    %ebx
80101562:	5e                   	pop    %esi
80101563:	5f                   	pop    %edi
80101564:	5d                   	pop    %ebp
80101565:	c3                   	ret    
80101566:	8d 76 00             	lea    0x0(%esi),%esi
80101569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101570:	e8 6b fd ff ff       	call   801012e0 <balloc>
80101575:	89 c2                	mov    %eax,%edx
80101577:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010157d:	8b 06                	mov    (%esi),%eax
8010157f:	e9 7c ff ff ff       	jmp    80101500 <bmap+0x40>
  panic("bmap: out of range");
80101584:	83 ec 0c             	sub    $0xc,%esp
80101587:	68 18 88 10 80       	push   $0x80108818
8010158c:	e8 ff ed ff ff       	call   80100390 <panic>
80101591:	eb 0d                	jmp    801015a0 <readsb>
80101593:	90                   	nop
80101594:	90                   	nop
80101595:	90                   	nop
80101596:	90                   	nop
80101597:	90                   	nop
80101598:	90                   	nop
80101599:	90                   	nop
8010159a:	90                   	nop
8010159b:	90                   	nop
8010159c:	90                   	nop
8010159d:	90                   	nop
8010159e:	90                   	nop
8010159f:	90                   	nop

801015a0 <readsb>:
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	56                   	push   %esi
801015a4:	53                   	push   %ebx
801015a5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801015a8:	83 ec 08             	sub    $0x8,%esp
801015ab:	6a 01                	push   $0x1
801015ad:	ff 75 08             	pushl  0x8(%ebp)
801015b0:	e8 1b eb ff ff       	call   801000d0 <bread>
801015b5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ba:	83 c4 0c             	add    $0xc,%esp
801015bd:	6a 1c                	push   $0x1c
801015bf:	50                   	push   %eax
801015c0:	56                   	push   %esi
801015c1:	e8 5a 39 00 00       	call   80104f20 <memmove>
  brelse(bp);
801015c6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015c9:	83 c4 10             	add    $0x10,%esp
}
801015cc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015cf:	5b                   	pop    %ebx
801015d0:	5e                   	pop    %esi
801015d1:	5d                   	pop    %ebp
  brelse(bp);
801015d2:	e9 09 ec ff ff       	jmp    801001e0 <brelse>
801015d7:	89 f6                	mov    %esi,%esi
801015d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015e0 <iinit>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	53                   	push   %ebx
801015e4:	bb 20 2a 11 80       	mov    $0x80112a20,%ebx
801015e9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015ec:	68 2b 88 10 80       	push   $0x8010882b
801015f1:	68 e0 29 11 80       	push   $0x801129e0
801015f6:	e8 25 36 00 00       	call   80104c20 <initlock>
801015fb:	83 c4 10             	add    $0x10,%esp
801015fe:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101600:	83 ec 08             	sub    $0x8,%esp
80101603:	68 32 88 10 80       	push   $0x80108832
80101608:	53                   	push   %ebx
80101609:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010160f:	e8 dc 34 00 00       	call   80104af0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101614:	83 c4 10             	add    $0x10,%esp
80101617:	81 fb 40 46 11 80    	cmp    $0x80114640,%ebx
8010161d:	75 e1                	jne    80101600 <iinit+0x20>
  readsb(dev, &sb);
8010161f:	83 ec 08             	sub    $0x8,%esp
80101622:	68 c0 29 11 80       	push   $0x801129c0
80101627:	ff 75 08             	pushl  0x8(%ebp)
8010162a:	e8 71 ff ff ff       	call   801015a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010162f:	ff 35 d8 29 11 80    	pushl  0x801129d8
80101635:	ff 35 d4 29 11 80    	pushl  0x801129d4
8010163b:	ff 35 d0 29 11 80    	pushl  0x801129d0
80101641:	ff 35 cc 29 11 80    	pushl  0x801129cc
80101647:	ff 35 c8 29 11 80    	pushl  0x801129c8
8010164d:	ff 35 c4 29 11 80    	pushl  0x801129c4
80101653:	ff 35 c0 29 11 80    	pushl  0x801129c0
80101659:	68 dc 88 10 80       	push   $0x801088dc
8010165e:	e8 fd ef ff ff       	call   80100660 <cprintf>
}
80101663:	83 c4 30             	add    $0x30,%esp
80101666:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101669:	c9                   	leave  
8010166a:	c3                   	ret    
8010166b:	90                   	nop
8010166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101670 <ialloc>:
{
80101670:	55                   	push   %ebp
80101671:	89 e5                	mov    %esp,%ebp
80101673:	57                   	push   %edi
80101674:	56                   	push   %esi
80101675:	53                   	push   %ebx
80101676:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101679:	83 3d c8 29 11 80 01 	cmpl   $0x1,0x801129c8
{
80101680:	8b 45 0c             	mov    0xc(%ebp),%eax
80101683:	8b 75 08             	mov    0x8(%ebp),%esi
80101686:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101689:	0f 86 91 00 00 00    	jbe    80101720 <ialloc+0xb0>
8010168f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101694:	eb 21                	jmp    801016b7 <ialloc+0x47>
80101696:	8d 76 00             	lea    0x0(%esi),%esi
80101699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
801016a0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016a3:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
801016a6:	57                   	push   %edi
801016a7:	e8 34 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016ac:	83 c4 10             	add    $0x10,%esp
801016af:	39 1d c8 29 11 80    	cmp    %ebx,0x801129c8
801016b5:	76 69                	jbe    80101720 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016b7:	89 d8                	mov    %ebx,%eax
801016b9:	83 ec 08             	sub    $0x8,%esp
801016bc:	c1 e8 03             	shr    $0x3,%eax
801016bf:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801016c5:	50                   	push   %eax
801016c6:	56                   	push   %esi
801016c7:	e8 04 ea ff ff       	call   801000d0 <bread>
801016cc:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801016ce:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801016d0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801016d3:	83 e0 07             	and    $0x7,%eax
801016d6:	c1 e0 06             	shl    $0x6,%eax
801016d9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016dd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016e1:	75 bd                	jne    801016a0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016e3:	83 ec 04             	sub    $0x4,%esp
801016e6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016e9:	6a 40                	push   $0x40
801016eb:	6a 00                	push   $0x0
801016ed:	51                   	push   %ecx
801016ee:	e8 7d 37 00 00       	call   80104e70 <memset>
      dip->type = type;
801016f3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016f7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016fa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016fd:	89 3c 24             	mov    %edi,(%esp)
80101700:	e8 6b 1d 00 00       	call   80103470 <log_write>
      brelse(bp);
80101705:	89 3c 24             	mov    %edi,(%esp)
80101708:	e8 d3 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010170d:	83 c4 10             	add    $0x10,%esp
}
80101710:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101713:	89 da                	mov    %ebx,%edx
80101715:	89 f0                	mov    %esi,%eax
}
80101717:	5b                   	pop    %ebx
80101718:	5e                   	pop    %esi
80101719:	5f                   	pop    %edi
8010171a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010171b:	e9 d0 fc ff ff       	jmp    801013f0 <iget>
  panic("ialloc: no inodes");
80101720:	83 ec 0c             	sub    $0xc,%esp
80101723:	68 38 88 10 80       	push   $0x80108838
80101728:	e8 63 ec ff ff       	call   80100390 <panic>
8010172d:	8d 76 00             	lea    0x0(%esi),%esi

80101730 <iupdate>:
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	56                   	push   %esi
80101734:	53                   	push   %ebx
80101735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101738:	83 ec 08             	sub    $0x8,%esp
8010173b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101741:	c1 e8 03             	shr    $0x3,%eax
80101744:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010174a:	50                   	push   %eax
8010174b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010174e:	e8 7d e9 ff ff       	call   801000d0 <bread>
80101753:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101755:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101758:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010175c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010175f:	83 e0 07             	and    $0x7,%eax
80101762:	c1 e0 06             	shl    $0x6,%eax
80101765:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101769:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010176c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101770:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101773:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101777:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010177b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010177f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101783:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101787:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010178a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010178d:	6a 34                	push   $0x34
8010178f:	53                   	push   %ebx
80101790:	50                   	push   %eax
80101791:	e8 8a 37 00 00       	call   80104f20 <memmove>
  log_write(bp);
80101796:	89 34 24             	mov    %esi,(%esp)
80101799:	e8 d2 1c 00 00       	call   80103470 <log_write>
  brelse(bp);
8010179e:	89 75 08             	mov    %esi,0x8(%ebp)
801017a1:	83 c4 10             	add    $0x10,%esp
}
801017a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017a7:	5b                   	pop    %ebx
801017a8:	5e                   	pop    %esi
801017a9:	5d                   	pop    %ebp
  brelse(bp);
801017aa:	e9 31 ea ff ff       	jmp    801001e0 <brelse>
801017af:	90                   	nop

801017b0 <idup>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	53                   	push   %ebx
801017b4:	83 ec 10             	sub    $0x10,%esp
801017b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017ba:	68 e0 29 11 80       	push   $0x801129e0
801017bf:	e8 9c 35 00 00       	call   80104d60 <acquire>
  ip->ref++;
801017c4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017c8:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801017cf:	e8 4c 36 00 00       	call   80104e20 <release>
}
801017d4:	89 d8                	mov    %ebx,%eax
801017d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017d9:	c9                   	leave  
801017da:	c3                   	ret    
801017db:	90                   	nop
801017dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017e0 <ilock>:
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	56                   	push   %esi
801017e4:	53                   	push   %ebx
801017e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017e8:	85 db                	test   %ebx,%ebx
801017ea:	0f 84 b7 00 00 00    	je     801018a7 <ilock+0xc7>
801017f0:	8b 53 08             	mov    0x8(%ebx),%edx
801017f3:	85 d2                	test   %edx,%edx
801017f5:	0f 8e ac 00 00 00    	jle    801018a7 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017fb:	8d 43 0c             	lea    0xc(%ebx),%eax
801017fe:	83 ec 0c             	sub    $0xc,%esp
80101801:	50                   	push   %eax
80101802:	e8 29 33 00 00       	call   80104b30 <acquiresleep>
  if(ip->valid == 0){
80101807:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010180a:	83 c4 10             	add    $0x10,%esp
8010180d:	85 c0                	test   %eax,%eax
8010180f:	74 0f                	je     80101820 <ilock+0x40>
}
80101811:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101814:	5b                   	pop    %ebx
80101815:	5e                   	pop    %esi
80101816:	5d                   	pop    %ebp
80101817:	c3                   	ret    
80101818:	90                   	nop
80101819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101820:	8b 43 04             	mov    0x4(%ebx),%eax
80101823:	83 ec 08             	sub    $0x8,%esp
80101826:	c1 e8 03             	shr    $0x3,%eax
80101829:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010182f:	50                   	push   %eax
80101830:	ff 33                	pushl  (%ebx)
80101832:	e8 99 e8 ff ff       	call   801000d0 <bread>
80101837:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101839:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010183c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010183f:	83 e0 07             	and    $0x7,%eax
80101842:	c1 e0 06             	shl    $0x6,%eax
80101845:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101849:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010184c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010184f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101853:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101857:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010185b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010185f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101863:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101867:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010186b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010186e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101871:	6a 34                	push   $0x34
80101873:	50                   	push   %eax
80101874:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101877:	50                   	push   %eax
80101878:	e8 a3 36 00 00       	call   80104f20 <memmove>
    brelse(bp);
8010187d:	89 34 24             	mov    %esi,(%esp)
80101880:	e8 5b e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101885:	83 c4 10             	add    $0x10,%esp
80101888:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010188d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101894:	0f 85 77 ff ff ff    	jne    80101811 <ilock+0x31>
      panic("ilock: no type");
8010189a:	83 ec 0c             	sub    $0xc,%esp
8010189d:	68 50 88 10 80       	push   $0x80108850
801018a2:	e8 e9 ea ff ff       	call   80100390 <panic>
    panic("ilock");
801018a7:	83 ec 0c             	sub    $0xc,%esp
801018aa:	68 4a 88 10 80       	push   $0x8010884a
801018af:	e8 dc ea ff ff       	call   80100390 <panic>
801018b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801018ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801018c0 <iunlock>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	56                   	push   %esi
801018c4:	53                   	push   %ebx
801018c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018c8:	85 db                	test   %ebx,%ebx
801018ca:	74 28                	je     801018f4 <iunlock+0x34>
801018cc:	8d 73 0c             	lea    0xc(%ebx),%esi
801018cf:	83 ec 0c             	sub    $0xc,%esp
801018d2:	56                   	push   %esi
801018d3:	e8 f8 32 00 00       	call   80104bd0 <holdingsleep>
801018d8:	83 c4 10             	add    $0x10,%esp
801018db:	85 c0                	test   %eax,%eax
801018dd:	74 15                	je     801018f4 <iunlock+0x34>
801018df:	8b 43 08             	mov    0x8(%ebx),%eax
801018e2:	85 c0                	test   %eax,%eax
801018e4:	7e 0e                	jle    801018f4 <iunlock+0x34>
  releasesleep(&ip->lock);
801018e6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018e9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018ec:	5b                   	pop    %ebx
801018ed:	5e                   	pop    %esi
801018ee:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018ef:	e9 9c 32 00 00       	jmp    80104b90 <releasesleep>
    panic("iunlock");
801018f4:	83 ec 0c             	sub    $0xc,%esp
801018f7:	68 5f 88 10 80       	push   $0x8010885f
801018fc:	e8 8f ea ff ff       	call   80100390 <panic>
80101901:	eb 0d                	jmp    80101910 <iput>
80101903:	90                   	nop
80101904:	90                   	nop
80101905:	90                   	nop
80101906:	90                   	nop
80101907:	90                   	nop
80101908:	90                   	nop
80101909:	90                   	nop
8010190a:	90                   	nop
8010190b:	90                   	nop
8010190c:	90                   	nop
8010190d:	90                   	nop
8010190e:	90                   	nop
8010190f:	90                   	nop

80101910 <iput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	57                   	push   %edi
80101914:	56                   	push   %esi
80101915:	53                   	push   %ebx
80101916:	83 ec 28             	sub    $0x28,%esp
80101919:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010191c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010191f:	57                   	push   %edi
80101920:	e8 0b 32 00 00       	call   80104b30 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101925:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101928:	83 c4 10             	add    $0x10,%esp
8010192b:	85 d2                	test   %edx,%edx
8010192d:	74 07                	je     80101936 <iput+0x26>
8010192f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101934:	74 32                	je     80101968 <iput+0x58>
  releasesleep(&ip->lock);
80101936:	83 ec 0c             	sub    $0xc,%esp
80101939:	57                   	push   %edi
8010193a:	e8 51 32 00 00       	call   80104b90 <releasesleep>
  acquire(&icache.lock);
8010193f:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101946:	e8 15 34 00 00       	call   80104d60 <acquire>
  ip->ref--;
8010194b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010194f:	83 c4 10             	add    $0x10,%esp
80101952:	c7 45 08 e0 29 11 80 	movl   $0x801129e0,0x8(%ebp)
}
80101959:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010195c:	5b                   	pop    %ebx
8010195d:	5e                   	pop    %esi
8010195e:	5f                   	pop    %edi
8010195f:	5d                   	pop    %ebp
  release(&icache.lock);
80101960:	e9 bb 34 00 00       	jmp    80104e20 <release>
80101965:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101968:	83 ec 0c             	sub    $0xc,%esp
8010196b:	68 e0 29 11 80       	push   $0x801129e0
80101970:	e8 eb 33 00 00       	call   80104d60 <acquire>
    int r = ip->ref;
80101975:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101978:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010197f:	e8 9c 34 00 00       	call   80104e20 <release>
    if(r == 1){
80101984:	83 c4 10             	add    $0x10,%esp
80101987:	83 fe 01             	cmp    $0x1,%esi
8010198a:	75 aa                	jne    80101936 <iput+0x26>
8010198c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101992:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101995:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101998:	89 cf                	mov    %ecx,%edi
8010199a:	eb 0b                	jmp    801019a7 <iput+0x97>
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019a0:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019a3:	39 fe                	cmp    %edi,%esi
801019a5:	74 19                	je     801019c0 <iput+0xb0>
    if(ip->addrs[i]){
801019a7:	8b 16                	mov    (%esi),%edx
801019a9:	85 d2                	test   %edx,%edx
801019ab:	74 f3                	je     801019a0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019ad:	8b 03                	mov    (%ebx),%eax
801019af:	e8 bc f8 ff ff       	call   80101270 <bfree>
      ip->addrs[i] = 0;
801019b4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019ba:	eb e4                	jmp    801019a0 <iput+0x90>
801019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019c0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019c9:	85 c0                	test   %eax,%eax
801019cb:	75 33                	jne    80101a00 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019cd:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019d0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019d7:	53                   	push   %ebx
801019d8:	e8 53 fd ff ff       	call   80101730 <iupdate>
      ip->type = 0;
801019dd:	31 c0                	xor    %eax,%eax
801019df:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019e3:	89 1c 24             	mov    %ebx,(%esp)
801019e6:	e8 45 fd ff ff       	call   80101730 <iupdate>
      ip->valid = 0;
801019eb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019f2:	83 c4 10             	add    $0x10,%esp
801019f5:	e9 3c ff ff ff       	jmp    80101936 <iput+0x26>
801019fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a00:	83 ec 08             	sub    $0x8,%esp
80101a03:	50                   	push   %eax
80101a04:	ff 33                	pushl  (%ebx)
80101a06:	e8 c5 e6 ff ff       	call   801000d0 <bread>
80101a0b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101a11:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a14:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101a17:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	89 cf                	mov    %ecx,%edi
80101a1f:	eb 0e                	jmp    80101a2f <iput+0x11f>
80101a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a28:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101a2b:	39 fe                	cmp    %edi,%esi
80101a2d:	74 0f                	je     80101a3e <iput+0x12e>
      if(a[j])
80101a2f:	8b 16                	mov    (%esi),%edx
80101a31:	85 d2                	test   %edx,%edx
80101a33:	74 f3                	je     80101a28 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a35:	8b 03                	mov    (%ebx),%eax
80101a37:	e8 34 f8 ff ff       	call   80101270 <bfree>
80101a3c:	eb ea                	jmp    80101a28 <iput+0x118>
    brelse(bp);
80101a3e:	83 ec 0c             	sub    $0xc,%esp
80101a41:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a44:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a47:	e8 94 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a4c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a52:	8b 03                	mov    (%ebx),%eax
80101a54:	e8 17 f8 ff ff       	call   80101270 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a59:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a60:	00 00 00 
80101a63:	83 c4 10             	add    $0x10,%esp
80101a66:	e9 62 ff ff ff       	jmp    801019cd <iput+0xbd>
80101a6b:	90                   	nop
80101a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a70 <iunlockput>:
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	53                   	push   %ebx
80101a74:	83 ec 10             	sub    $0x10,%esp
80101a77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a7a:	53                   	push   %ebx
80101a7b:	e8 40 fe ff ff       	call   801018c0 <iunlock>
  iput(ip);
80101a80:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a83:	83 c4 10             	add    $0x10,%esp
}
80101a86:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a89:	c9                   	leave  
  iput(ip);
80101a8a:	e9 81 fe ff ff       	jmp    80101910 <iput>
80101a8f:	90                   	nop

80101a90 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	8b 55 08             	mov    0x8(%ebp),%edx
80101a96:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a99:	8b 0a                	mov    (%edx),%ecx
80101a9b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a9e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101aa1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101aa4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101aa8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101aab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aaf:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ab3:	8b 52 58             	mov    0x58(%edx),%edx
80101ab6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101ab9:	5d                   	pop    %ebp
80101aba:	c3                   	ret    
80101abb:	90                   	nop
80101abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ac0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101ac0:	55                   	push   %ebp
80101ac1:	89 e5                	mov    %esp,%ebp
80101ac3:	57                   	push   %edi
80101ac4:	56                   	push   %esi
80101ac5:	53                   	push   %ebx
80101ac6:	83 ec 1c             	sub    $0x1c,%esp
80101ac9:	8b 45 08             	mov    0x8(%ebp),%eax
80101acc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101acf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ad2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ad7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101ada:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101add:	8b 75 10             	mov    0x10(%ebp),%esi
80101ae0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ae3:	0f 84 a7 00 00 00    	je     80101b90 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ae9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101aec:	8b 40 58             	mov    0x58(%eax),%eax
80101aef:	39 c6                	cmp    %eax,%esi
80101af1:	0f 87 ba 00 00 00    	ja     80101bb1 <readi+0xf1>
80101af7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101afa:	89 f9                	mov    %edi,%ecx
80101afc:	01 f1                	add    %esi,%ecx
80101afe:	0f 82 ad 00 00 00    	jb     80101bb1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b04:	89 c2                	mov    %eax,%edx
80101b06:	29 f2                	sub    %esi,%edx
80101b08:	39 c8                	cmp    %ecx,%eax
80101b0a:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b0d:	31 ff                	xor    %edi,%edi
80101b0f:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101b11:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b14:	74 6c                	je     80101b82 <readi+0xc2>
80101b16:	8d 76 00             	lea    0x0(%esi),%esi
80101b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b20:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b23:	89 f2                	mov    %esi,%edx
80101b25:	c1 ea 09             	shr    $0x9,%edx
80101b28:	89 d8                	mov    %ebx,%eax
80101b2a:	e8 91 f9 ff ff       	call   801014c0 <bmap>
80101b2f:	83 ec 08             	sub    $0x8,%esp
80101b32:	50                   	push   %eax
80101b33:	ff 33                	pushl  (%ebx)
80101b35:	e8 96 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b3a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b3d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b3f:	89 f0                	mov    %esi,%eax
80101b41:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b46:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b4b:	83 c4 0c             	add    $0xc,%esp
80101b4e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b50:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b54:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b57:	29 fb                	sub    %edi,%ebx
80101b59:	39 d9                	cmp    %ebx,%ecx
80101b5b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b5e:	53                   	push   %ebx
80101b5f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b60:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b62:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b65:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b67:	e8 b4 33 00 00       	call   80104f20 <memmove>
    brelse(bp);
80101b6c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b6f:	89 14 24             	mov    %edx,(%esp)
80101b72:	e8 69 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b77:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b7a:	83 c4 10             	add    $0x10,%esp
80101b7d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b80:	77 9e                	ja     80101b20 <readi+0x60>
  }
  return n;
80101b82:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b88:	5b                   	pop    %ebx
80101b89:	5e                   	pop    %esi
80101b8a:	5f                   	pop    %edi
80101b8b:	5d                   	pop    %ebp
80101b8c:	c3                   	ret    
80101b8d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b90:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b94:	66 83 f8 09          	cmp    $0x9,%ax
80101b98:	77 17                	ja     80101bb1 <readi+0xf1>
80101b9a:	8b 04 c5 60 29 11 80 	mov    -0x7feed6a0(,%eax,8),%eax
80101ba1:	85 c0                	test   %eax,%eax
80101ba3:	74 0c                	je     80101bb1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ba5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ba8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bab:	5b                   	pop    %ebx
80101bac:	5e                   	pop    %esi
80101bad:	5f                   	pop    %edi
80101bae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101baf:	ff e0                	jmp    *%eax
      return -1;
80101bb1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bb6:	eb cd                	jmp    80101b85 <readi+0xc5>
80101bb8:	90                   	nop
80101bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101bc0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bcc:	8b 75 0c             	mov    0xc(%ebp),%esi
80101bcf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bd2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bd7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bda:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bdd:	8b 75 10             	mov    0x10(%ebp),%esi
80101be0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101be3:	0f 84 b7 00 00 00    	je     80101ca0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101be9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bec:	39 70 58             	cmp    %esi,0x58(%eax)
80101bef:	0f 82 eb 00 00 00    	jb     80101ce0 <writei+0x120>
80101bf5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bf8:	31 d2                	xor    %edx,%edx
80101bfa:	89 f8                	mov    %edi,%eax
80101bfc:	01 f0                	add    %esi,%eax
80101bfe:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c01:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101c06:	0f 87 d4 00 00 00    	ja     80101ce0 <writei+0x120>
80101c0c:	85 d2                	test   %edx,%edx
80101c0e:	0f 85 cc 00 00 00    	jne    80101ce0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c14:	85 ff                	test   %edi,%edi
80101c16:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101c1d:	74 72                	je     80101c91 <writei+0xd1>
80101c1f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c20:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c23:	89 f2                	mov    %esi,%edx
80101c25:	c1 ea 09             	shr    $0x9,%edx
80101c28:	89 f8                	mov    %edi,%eax
80101c2a:	e8 91 f8 ff ff       	call   801014c0 <bmap>
80101c2f:	83 ec 08             	sub    $0x8,%esp
80101c32:	50                   	push   %eax
80101c33:	ff 37                	pushl  (%edi)
80101c35:	e8 96 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c3a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c3d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c40:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c42:	89 f0                	mov    %esi,%eax
80101c44:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c49:	83 c4 0c             	add    $0xc,%esp
80101c4c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c51:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c53:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c57:	39 d9                	cmp    %ebx,%ecx
80101c59:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c5c:	53                   	push   %ebx
80101c5d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c60:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c62:	50                   	push   %eax
80101c63:	e8 b8 32 00 00       	call   80104f20 <memmove>
    log_write(bp);
80101c68:	89 3c 24             	mov    %edi,(%esp)
80101c6b:	e8 00 18 00 00       	call   80103470 <log_write>
    brelse(bp);
80101c70:	89 3c 24             	mov    %edi,(%esp)
80101c73:	e8 68 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c78:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c7b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c7e:	83 c4 10             	add    $0x10,%esp
80101c81:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c84:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c87:	77 97                	ja     80101c20 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c8c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c8f:	77 37                	ja     80101cc8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c91:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c94:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c97:	5b                   	pop    %ebx
80101c98:	5e                   	pop    %esi
80101c99:	5f                   	pop    %edi
80101c9a:	5d                   	pop    %ebp
80101c9b:	c3                   	ret    
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ca0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ca4:	66 83 f8 09          	cmp    $0x9,%ax
80101ca8:	77 36                	ja     80101ce0 <writei+0x120>
80101caa:	8b 04 c5 64 29 11 80 	mov    -0x7feed69c(,%eax,8),%eax
80101cb1:	85 c0                	test   %eax,%eax
80101cb3:	74 2b                	je     80101ce0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101cb5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101cb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cbb:	5b                   	pop    %ebx
80101cbc:	5e                   	pop    %esi
80101cbd:	5f                   	pop    %edi
80101cbe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101cbf:	ff e0                	jmp    *%eax
80101cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101cc8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101ccb:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cce:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101cd1:	50                   	push   %eax
80101cd2:	e8 59 fa ff ff       	call   80101730 <iupdate>
80101cd7:	83 c4 10             	add    $0x10,%esp
80101cda:	eb b5                	jmp    80101c91 <writei+0xd1>
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ce5:	eb ad                	jmp    80101c94 <writei+0xd4>
80101ce7:	89 f6                	mov    %esi,%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cf0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cf6:	6a 0e                	push   $0xe
80101cf8:	ff 75 0c             	pushl  0xc(%ebp)
80101cfb:	ff 75 08             	pushl  0x8(%ebp)
80101cfe:	e8 8d 32 00 00       	call   80104f90 <strncmp>
}
80101d03:	c9                   	leave  
80101d04:	c3                   	ret    
80101d05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101d10 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	56                   	push   %esi
80101d15:	53                   	push   %ebx
80101d16:	83 ec 1c             	sub    $0x1c,%esp
80101d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d1c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d21:	0f 85 85 00 00 00    	jne    80101dac <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d27:	8b 53 58             	mov    0x58(%ebx),%edx
80101d2a:	31 ff                	xor    %edi,%edi
80101d2c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d2f:	85 d2                	test   %edx,%edx
80101d31:	74 3e                	je     80101d71 <dirlookup+0x61>
80101d33:	90                   	nop
80101d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d38:	6a 10                	push   $0x10
80101d3a:	57                   	push   %edi
80101d3b:	56                   	push   %esi
80101d3c:	53                   	push   %ebx
80101d3d:	e8 7e fd ff ff       	call   80101ac0 <readi>
80101d42:	83 c4 10             	add    $0x10,%esp
80101d45:	83 f8 10             	cmp    $0x10,%eax
80101d48:	75 55                	jne    80101d9f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d4a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d4f:	74 18                	je     80101d69 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d51:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d54:	83 ec 04             	sub    $0x4,%esp
80101d57:	6a 0e                	push   $0xe
80101d59:	50                   	push   %eax
80101d5a:	ff 75 0c             	pushl  0xc(%ebp)
80101d5d:	e8 2e 32 00 00       	call   80104f90 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d62:	83 c4 10             	add    $0x10,%esp
80101d65:	85 c0                	test   %eax,%eax
80101d67:	74 17                	je     80101d80 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d69:	83 c7 10             	add    $0x10,%edi
80101d6c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d6f:	72 c7                	jb     80101d38 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d71:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d74:	31 c0                	xor    %eax,%eax
}
80101d76:	5b                   	pop    %ebx
80101d77:	5e                   	pop    %esi
80101d78:	5f                   	pop    %edi
80101d79:	5d                   	pop    %ebp
80101d7a:	c3                   	ret    
80101d7b:	90                   	nop
80101d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d80:	8b 45 10             	mov    0x10(%ebp),%eax
80101d83:	85 c0                	test   %eax,%eax
80101d85:	74 05                	je     80101d8c <dirlookup+0x7c>
        *poff = off;
80101d87:	8b 45 10             	mov    0x10(%ebp),%eax
80101d8a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d8c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d90:	8b 03                	mov    (%ebx),%eax
80101d92:	e8 59 f6 ff ff       	call   801013f0 <iget>
}
80101d97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d9a:	5b                   	pop    %ebx
80101d9b:	5e                   	pop    %esi
80101d9c:	5f                   	pop    %edi
80101d9d:	5d                   	pop    %ebp
80101d9e:	c3                   	ret    
      panic("dirlookup read");
80101d9f:	83 ec 0c             	sub    $0xc,%esp
80101da2:	68 79 88 10 80       	push   $0x80108879
80101da7:	e8 e4 e5 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101dac:	83 ec 0c             	sub    $0xc,%esp
80101daf:	68 67 88 10 80       	push   $0x80108867
80101db4:	e8 d7 e5 ff ff       	call   80100390 <panic>
80101db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101dc0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101dc0:	55                   	push   %ebp
80101dc1:	89 e5                	mov    %esp,%ebp
80101dc3:	57                   	push   %edi
80101dc4:	56                   	push   %esi
80101dc5:	53                   	push   %ebx
80101dc6:	89 cf                	mov    %ecx,%edi
80101dc8:	89 c3                	mov    %eax,%ebx
80101dca:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dcd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101dd0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101dd3:	0f 84 67 01 00 00    	je     80101f40 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101dd9:	e8 b2 21 00 00       	call   80103f90 <myproc>
  acquire(&icache.lock);
80101dde:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101de1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101de4:	68 e0 29 11 80       	push   $0x801129e0
80101de9:	e8 72 2f 00 00       	call   80104d60 <acquire>
  ip->ref++;
80101dee:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101df2:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101df9:	e8 22 30 00 00       	call   80104e20 <release>
80101dfe:	83 c4 10             	add    $0x10,%esp
80101e01:	eb 08                	jmp    80101e0b <namex+0x4b>
80101e03:	90                   	nop
80101e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e08:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e0b:	0f b6 03             	movzbl (%ebx),%eax
80101e0e:	3c 2f                	cmp    $0x2f,%al
80101e10:	74 f6                	je     80101e08 <namex+0x48>
  if(*path == 0)
80101e12:	84 c0                	test   %al,%al
80101e14:	0f 84 ee 00 00 00    	je     80101f08 <namex+0x148>
  while(*path != '/' && *path != 0)
80101e1a:	0f b6 03             	movzbl (%ebx),%eax
80101e1d:	3c 2f                	cmp    $0x2f,%al
80101e1f:	0f 84 b3 00 00 00    	je     80101ed8 <namex+0x118>
80101e25:	84 c0                	test   %al,%al
80101e27:	89 da                	mov    %ebx,%edx
80101e29:	75 09                	jne    80101e34 <namex+0x74>
80101e2b:	e9 a8 00 00 00       	jmp    80101ed8 <namex+0x118>
80101e30:	84 c0                	test   %al,%al
80101e32:	74 0a                	je     80101e3e <namex+0x7e>
    path++;
80101e34:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e37:	0f b6 02             	movzbl (%edx),%eax
80101e3a:	3c 2f                	cmp    $0x2f,%al
80101e3c:	75 f2                	jne    80101e30 <namex+0x70>
80101e3e:	89 d1                	mov    %edx,%ecx
80101e40:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e42:	83 f9 0d             	cmp    $0xd,%ecx
80101e45:	0f 8e 91 00 00 00    	jle    80101edc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e4b:	83 ec 04             	sub    $0x4,%esp
80101e4e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e51:	6a 0e                	push   $0xe
80101e53:	53                   	push   %ebx
80101e54:	57                   	push   %edi
80101e55:	e8 c6 30 00 00       	call   80104f20 <memmove>
    path++;
80101e5a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e5d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e60:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e62:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e65:	75 11                	jne    80101e78 <namex+0xb8>
80101e67:	89 f6                	mov    %esi,%esi
80101e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e70:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e73:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e76:	74 f8                	je     80101e70 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e78:	83 ec 0c             	sub    $0xc,%esp
80101e7b:	56                   	push   %esi
80101e7c:	e8 5f f9 ff ff       	call   801017e0 <ilock>
    if(ip->type != T_DIR){
80101e81:	83 c4 10             	add    $0x10,%esp
80101e84:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e89:	0f 85 91 00 00 00    	jne    80101f20 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e8f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e92:	85 d2                	test   %edx,%edx
80101e94:	74 09                	je     80101e9f <namex+0xdf>
80101e96:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e99:	0f 84 b7 00 00 00    	je     80101f56 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e9f:	83 ec 04             	sub    $0x4,%esp
80101ea2:	6a 00                	push   $0x0
80101ea4:	57                   	push   %edi
80101ea5:	56                   	push   %esi
80101ea6:	e8 65 fe ff ff       	call   80101d10 <dirlookup>
80101eab:	83 c4 10             	add    $0x10,%esp
80101eae:	85 c0                	test   %eax,%eax
80101eb0:	74 6e                	je     80101f20 <namex+0x160>
  iunlock(ip);
80101eb2:	83 ec 0c             	sub    $0xc,%esp
80101eb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101eb8:	56                   	push   %esi
80101eb9:	e8 02 fa ff ff       	call   801018c0 <iunlock>
  iput(ip);
80101ebe:	89 34 24             	mov    %esi,(%esp)
80101ec1:	e8 4a fa ff ff       	call   80101910 <iput>
80101ec6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ec9:	83 c4 10             	add    $0x10,%esp
80101ecc:	89 c6                	mov    %eax,%esi
80101ece:	e9 38 ff ff ff       	jmp    80101e0b <namex+0x4b>
80101ed3:	90                   	nop
80101ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101ed8:	89 da                	mov    %ebx,%edx
80101eda:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101edc:	83 ec 04             	sub    $0x4,%esp
80101edf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ee2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ee5:	51                   	push   %ecx
80101ee6:	53                   	push   %ebx
80101ee7:	57                   	push   %edi
80101ee8:	e8 33 30 00 00       	call   80104f20 <memmove>
    name[len] = 0;
80101eed:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ef0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ef3:	83 c4 10             	add    $0x10,%esp
80101ef6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101efa:	89 d3                	mov    %edx,%ebx
80101efc:	e9 61 ff ff ff       	jmp    80101e62 <namex+0xa2>
80101f01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101f0b:	85 c0                	test   %eax,%eax
80101f0d:	75 5d                	jne    80101f6c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f0f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f12:	89 f0                	mov    %esi,%eax
80101f14:	5b                   	pop    %ebx
80101f15:	5e                   	pop    %esi
80101f16:	5f                   	pop    %edi
80101f17:	5d                   	pop    %ebp
80101f18:	c3                   	ret    
80101f19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f20:	83 ec 0c             	sub    $0xc,%esp
80101f23:	56                   	push   %esi
80101f24:	e8 97 f9 ff ff       	call   801018c0 <iunlock>
  iput(ip);
80101f29:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f2c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f2e:	e8 dd f9 ff ff       	call   80101910 <iput>
      return 0;
80101f33:	83 c4 10             	add    $0x10,%esp
}
80101f36:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f39:	89 f0                	mov    %esi,%eax
80101f3b:	5b                   	pop    %ebx
80101f3c:	5e                   	pop    %esi
80101f3d:	5f                   	pop    %edi
80101f3e:	5d                   	pop    %ebp
80101f3f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f40:	ba 01 00 00 00       	mov    $0x1,%edx
80101f45:	b8 01 00 00 00       	mov    $0x1,%eax
80101f4a:	e8 a1 f4 ff ff       	call   801013f0 <iget>
80101f4f:	89 c6                	mov    %eax,%esi
80101f51:	e9 b5 fe ff ff       	jmp    80101e0b <namex+0x4b>
      iunlock(ip);
80101f56:	83 ec 0c             	sub    $0xc,%esp
80101f59:	56                   	push   %esi
80101f5a:	e8 61 f9 ff ff       	call   801018c0 <iunlock>
      return ip;
80101f5f:	83 c4 10             	add    $0x10,%esp
}
80101f62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f65:	89 f0                	mov    %esi,%eax
80101f67:	5b                   	pop    %ebx
80101f68:	5e                   	pop    %esi
80101f69:	5f                   	pop    %edi
80101f6a:	5d                   	pop    %ebp
80101f6b:	c3                   	ret    
    iput(ip);
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	56                   	push   %esi
    return 0;
80101f70:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f72:	e8 99 f9 ff ff       	call   80101910 <iput>
    return 0;
80101f77:	83 c4 10             	add    $0x10,%esp
80101f7a:	eb 93                	jmp    80101f0f <namex+0x14f>
80101f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f80 <dirlink>:
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	83 ec 20             	sub    $0x20,%esp
80101f89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f8c:	6a 00                	push   $0x0
80101f8e:	ff 75 0c             	pushl  0xc(%ebp)
80101f91:	53                   	push   %ebx
80101f92:	e8 79 fd ff ff       	call   80101d10 <dirlookup>
80101f97:	83 c4 10             	add    $0x10,%esp
80101f9a:	85 c0                	test   %eax,%eax
80101f9c:	75 67                	jne    80102005 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f9e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101fa1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fa4:	85 ff                	test   %edi,%edi
80101fa6:	74 29                	je     80101fd1 <dirlink+0x51>
80101fa8:	31 ff                	xor    %edi,%edi
80101faa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101fad:	eb 09                	jmp    80101fb8 <dirlink+0x38>
80101faf:	90                   	nop
80101fb0:	83 c7 10             	add    $0x10,%edi
80101fb3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fb6:	73 19                	jae    80101fd1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fb8:	6a 10                	push   $0x10
80101fba:	57                   	push   %edi
80101fbb:	56                   	push   %esi
80101fbc:	53                   	push   %ebx
80101fbd:	e8 fe fa ff ff       	call   80101ac0 <readi>
80101fc2:	83 c4 10             	add    $0x10,%esp
80101fc5:	83 f8 10             	cmp    $0x10,%eax
80101fc8:	75 4e                	jne    80102018 <dirlink+0x98>
    if(de.inum == 0)
80101fca:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fcf:	75 df                	jne    80101fb0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101fd1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fd4:	83 ec 04             	sub    $0x4,%esp
80101fd7:	6a 0e                	push   $0xe
80101fd9:	ff 75 0c             	pushl  0xc(%ebp)
80101fdc:	50                   	push   %eax
80101fdd:	e8 0e 30 00 00       	call   80104ff0 <strncpy>
  de.inum = inum;
80101fe2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fe5:	6a 10                	push   $0x10
80101fe7:	57                   	push   %edi
80101fe8:	56                   	push   %esi
80101fe9:	53                   	push   %ebx
  de.inum = inum;
80101fea:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fee:	e8 cd fb ff ff       	call   80101bc0 <writei>
80101ff3:	83 c4 20             	add    $0x20,%esp
80101ff6:	83 f8 10             	cmp    $0x10,%eax
80101ff9:	75 2a                	jne    80102025 <dirlink+0xa5>
  return 0;
80101ffb:	31 c0                	xor    %eax,%eax
}
80101ffd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102000:	5b                   	pop    %ebx
80102001:	5e                   	pop    %esi
80102002:	5f                   	pop    %edi
80102003:	5d                   	pop    %ebp
80102004:	c3                   	ret    
    iput(ip);
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	50                   	push   %eax
80102009:	e8 02 f9 ff ff       	call   80101910 <iput>
    return -1;
8010200e:	83 c4 10             	add    $0x10,%esp
80102011:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102016:	eb e5                	jmp    80101ffd <dirlink+0x7d>
      panic("dirlink read");
80102018:	83 ec 0c             	sub    $0xc,%esp
8010201b:	68 88 88 10 80       	push   $0x80108888
80102020:	e8 6b e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102025:	83 ec 0c             	sub    $0xc,%esp
80102028:	68 91 8f 10 80       	push   $0x80108f91
8010202d:	e8 5e e3 ff ff       	call   80100390 <panic>
80102032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102040 <namei>:

struct inode*
namei(char *path)
{
80102040:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102041:	31 d2                	xor    %edx,%edx
{
80102043:	89 e5                	mov    %esp,%ebp
80102045:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102048:	8b 45 08             	mov    0x8(%ebp),%eax
8010204b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010204e:	e8 6d fd ff ff       	call   80101dc0 <namex>
}
80102053:	c9                   	leave  
80102054:	c3                   	ret    
80102055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102060 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102060:	55                   	push   %ebp
  return namex(path, 1, name);
80102061:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102066:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102068:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010206b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010206e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010206f:	e9 4c fd ff ff       	jmp    80101dc0 <namex>
80102074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010207a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102080 <itoa>:

#include "fcntl.h"
#define DIGITS 14

char* itoa(int i, char b[]){
80102080:	55                   	push   %ebp
    char const digit[] = "0123456789";
80102081:	b8 38 39 00 00       	mov    $0x3938,%eax
char* itoa(int i, char b[]){
80102086:	89 e5                	mov    %esp,%ebp
80102088:	57                   	push   %edi
80102089:	56                   	push   %esi
8010208a:	53                   	push   %ebx
8010208b:	83 ec 10             	sub    $0x10,%esp
8010208e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80102091:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80102098:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
8010209f:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
801020a3:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
801020a7:	8b 75 0c             	mov    0xc(%ebp),%esi
    char* p = b;
    if(i<0){
801020aa:	85 c9                	test   %ecx,%ecx
801020ac:	79 0a                	jns    801020b8 <itoa+0x38>
801020ae:	89 f0                	mov    %esi,%eax
801020b0:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
801020b3:	f7 d9                	neg    %ecx
        *p++ = '-';
801020b5:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
801020b8:	89 cb                	mov    %ecx,%ebx
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
801020ba:	bf 67 66 66 66       	mov    $0x66666667,%edi
801020bf:	90                   	nop
801020c0:	89 d8                	mov    %ebx,%eax
801020c2:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
801020c5:	83 c6 01             	add    $0x1,%esi
        shifter = shifter/10;
801020c8:	f7 ef                	imul   %edi
801020ca:	c1 fa 02             	sar    $0x2,%edx
    }while(shifter);
801020cd:	29 da                	sub    %ebx,%edx
801020cf:	89 d3                	mov    %edx,%ebx
801020d1:	75 ed                	jne    801020c0 <itoa+0x40>
    *p = '\0';
801020d3:	c6 06 00             	movb   $0x0,(%esi)
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
801020d6:	bb 67 66 66 66       	mov    $0x66666667,%ebx
801020db:	90                   	nop
801020dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020e0:	89 c8                	mov    %ecx,%eax
801020e2:	83 ee 01             	sub    $0x1,%esi
801020e5:	f7 eb                	imul   %ebx
801020e7:	89 c8                	mov    %ecx,%eax
801020e9:	c1 f8 1f             	sar    $0x1f,%eax
801020ec:	c1 fa 02             	sar    $0x2,%edx
801020ef:	29 c2                	sub    %eax,%edx
801020f1:	8d 04 92             	lea    (%edx,%edx,4),%eax
801020f4:	01 c0                	add    %eax,%eax
801020f6:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
801020f8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801020fa:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
801020ff:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
80102101:	88 06                	mov    %al,(%esi)
    }while(i);
80102103:	75 db                	jne    801020e0 <itoa+0x60>
    return b;
}
80102105:	8b 45 0c             	mov    0xc(%ebp),%eax
80102108:	83 c4 10             	add    $0x10,%esp
8010210b:	5b                   	pop    %ebx
8010210c:	5e                   	pop    %esi
8010210d:	5f                   	pop    %edi
8010210e:	5d                   	pop    %ebp
8010210f:	c3                   	ret    

80102110 <removeSwapFile>:
//remove swap file of proc p;
int
removeSwapFile(struct proc* p)
{
80102110:	55                   	push   %ebp
80102111:	89 e5                	mov    %esp,%ebp
80102113:	57                   	push   %edi
80102114:	56                   	push   %esi
80102115:	53                   	push   %ebx
  //path of proccess
  char path[DIGITS];
  memmove(path,"/.swap", 6);
80102116:	8d 75 bc             	lea    -0x44(%ebp),%esi
{
80102119:	83 ec 40             	sub    $0x40,%esp
8010211c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
8010211f:	6a 06                	push   $0x6
80102121:	68 95 88 10 80       	push   $0x80108895
80102126:	56                   	push   %esi
80102127:	e8 f4 2d 00 00       	call   80104f20 <memmove>
  itoa(p->pid, path+ 6);
8010212c:	58                   	pop    %eax
8010212d:	8d 45 c2             	lea    -0x3e(%ebp),%eax
80102130:	5a                   	pop    %edx
80102131:	50                   	push   %eax
80102132:	ff 73 10             	pushl  0x10(%ebx)
80102135:	e8 46 ff ff ff       	call   80102080 <itoa>
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ];
  uint off;

  if(0 == p->swapFile)
8010213a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010213d:	83 c4 10             	add    $0x10,%esp
80102140:	85 c0                	test   %eax,%eax
80102142:	0f 84 88 01 00 00    	je     801022d0 <removeSwapFile+0x1c0>
  {
    return -1;
  }
  fileclose(p->swapFile);
80102148:	83 ec 0c             	sub    $0xc,%esp
  return namex(path, 1, name);
8010214b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  fileclose(p->swapFile);
8010214e:	50                   	push   %eax
8010214f:	e8 4c ee ff ff       	call   80100fa0 <fileclose>

  begin_op();
80102154:	e8 47 11 00 00       	call   801032a0 <begin_op>
  return namex(path, 1, name);
80102159:	89 f0                	mov    %esi,%eax
8010215b:	89 d9                	mov    %ebx,%ecx
8010215d:	ba 01 00 00 00       	mov    $0x1,%edx
80102162:	e8 59 fc ff ff       	call   80101dc0 <namex>
  if((dp = nameiparent(path, name)) == 0)
80102167:	83 c4 10             	add    $0x10,%esp
8010216a:	85 c0                	test   %eax,%eax
  return namex(path, 1, name);
8010216c:	89 c6                	mov    %eax,%esi
  if((dp = nameiparent(path, name)) == 0)
8010216e:	0f 84 66 01 00 00    	je     801022da <removeSwapFile+0x1ca>
  {
    end_op();
    return -1;
  }

  ilock(dp);
80102174:	83 ec 0c             	sub    $0xc,%esp
80102177:	50                   	push   %eax
80102178:	e8 63 f6 ff ff       	call   801017e0 <ilock>
  return strncmp(s, t, DIRSIZ);
8010217d:	83 c4 0c             	add    $0xc,%esp
80102180:	6a 0e                	push   $0xe
80102182:	68 9d 88 10 80       	push   $0x8010889d
80102187:	53                   	push   %ebx
80102188:	e8 03 2e 00 00       	call   80104f90 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010218d:	83 c4 10             	add    $0x10,%esp
80102190:	85 c0                	test   %eax,%eax
80102192:	0f 84 f8 00 00 00    	je     80102290 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
80102198:	83 ec 04             	sub    $0x4,%esp
8010219b:	6a 0e                	push   $0xe
8010219d:	68 9c 88 10 80       	push   $0x8010889c
801021a2:	53                   	push   %ebx
801021a3:	e8 e8 2d 00 00       	call   80104f90 <strncmp>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801021a8:	83 c4 10             	add    $0x10,%esp
801021ab:	85 c0                	test   %eax,%eax
801021ad:	0f 84 dd 00 00 00    	je     80102290 <removeSwapFile+0x180>
     goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801021b3:	8d 45 b8             	lea    -0x48(%ebp),%eax
801021b6:	83 ec 04             	sub    $0x4,%esp
801021b9:	50                   	push   %eax
801021ba:	53                   	push   %ebx
801021bb:	56                   	push   %esi
801021bc:	e8 4f fb ff ff       	call   80101d10 <dirlookup>
801021c1:	83 c4 10             	add    $0x10,%esp
801021c4:	85 c0                	test   %eax,%eax
801021c6:	89 c3                	mov    %eax,%ebx
801021c8:	0f 84 c2 00 00 00    	je     80102290 <removeSwapFile+0x180>
    goto bad;
  ilock(ip);
801021ce:	83 ec 0c             	sub    $0xc,%esp
801021d1:	50                   	push   %eax
801021d2:	e8 09 f6 ff ff       	call   801017e0 <ilock>

  if(ip->nlink < 1)
801021d7:	83 c4 10             	add    $0x10,%esp
801021da:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801021df:	0f 8e 11 01 00 00    	jle    801022f6 <removeSwapFile+0x1e6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801021e5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021ea:	74 74                	je     80102260 <removeSwapFile+0x150>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801021ec:	8d 7d d8             	lea    -0x28(%ebp),%edi
801021ef:	83 ec 04             	sub    $0x4,%esp
801021f2:	6a 10                	push   $0x10
801021f4:	6a 00                	push   $0x0
801021f6:	57                   	push   %edi
801021f7:	e8 74 2c 00 00       	call   80104e70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021fc:	6a 10                	push   $0x10
801021fe:	ff 75 b8             	pushl  -0x48(%ebp)
80102201:	57                   	push   %edi
80102202:	56                   	push   %esi
80102203:	e8 b8 f9 ff ff       	call   80101bc0 <writei>
80102208:	83 c4 20             	add    $0x20,%esp
8010220b:	83 f8 10             	cmp    $0x10,%eax
8010220e:	0f 85 d5 00 00 00    	jne    801022e9 <removeSwapFile+0x1d9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80102214:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102219:	0f 84 91 00 00 00    	je     801022b0 <removeSwapFile+0x1a0>
  iunlock(ip);
8010221f:	83 ec 0c             	sub    $0xc,%esp
80102222:	56                   	push   %esi
80102223:	e8 98 f6 ff ff       	call   801018c0 <iunlock>
  iput(ip);
80102228:	89 34 24             	mov    %esi,(%esp)
8010222b:	e8 e0 f6 ff ff       	call   80101910 <iput>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
80102230:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80102235:	89 1c 24             	mov    %ebx,(%esp)
80102238:	e8 f3 f4 ff ff       	call   80101730 <iupdate>
  iunlock(ip);
8010223d:	89 1c 24             	mov    %ebx,(%esp)
80102240:	e8 7b f6 ff ff       	call   801018c0 <iunlock>
  iput(ip);
80102245:	89 1c 24             	mov    %ebx,(%esp)
80102248:	e8 c3 f6 ff ff       	call   80101910 <iput>
  iunlockput(ip);

  end_op();
8010224d:	e8 be 10 00 00       	call   80103310 <end_op>

  return 0;
80102252:	83 c4 10             	add    $0x10,%esp
80102255:	31 c0                	xor    %eax,%eax
  bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102257:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010225a:	5b                   	pop    %ebx
8010225b:	5e                   	pop    %esi
8010225c:	5f                   	pop    %edi
8010225d:	5d                   	pop    %ebp
8010225e:	c3                   	ret    
8010225f:	90                   	nop
  if(ip->type == T_DIR && !isdirempty(ip)){
80102260:	83 ec 0c             	sub    $0xc,%esp
80102263:	53                   	push   %ebx
80102264:	e8 e7 33 00 00       	call   80105650 <isdirempty>
80102269:	83 c4 10             	add    $0x10,%esp
8010226c:	85 c0                	test   %eax,%eax
8010226e:	0f 85 78 ff ff ff    	jne    801021ec <removeSwapFile+0xdc>
  iunlock(ip);
80102274:	83 ec 0c             	sub    $0xc,%esp
80102277:	53                   	push   %ebx
80102278:	e8 43 f6 ff ff       	call   801018c0 <iunlock>
  iput(ip);
8010227d:	89 1c 24             	mov    %ebx,(%esp)
80102280:	e8 8b f6 ff ff       	call   80101910 <iput>
80102285:	83 c4 10             	add    $0x10,%esp
80102288:	90                   	nop
80102289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102290:	83 ec 0c             	sub    $0xc,%esp
80102293:	56                   	push   %esi
80102294:	e8 27 f6 ff ff       	call   801018c0 <iunlock>
  iput(ip);
80102299:	89 34 24             	mov    %esi,(%esp)
8010229c:	e8 6f f6 ff ff       	call   80101910 <iput>
    end_op();
801022a1:	e8 6a 10 00 00       	call   80103310 <end_op>
    return -1;
801022a6:	83 c4 10             	add    $0x10,%esp
801022a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022ae:	eb a7                	jmp    80102257 <removeSwapFile+0x147>
    dp->nlink--;
801022b0:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
801022b5:	83 ec 0c             	sub    $0xc,%esp
801022b8:	56                   	push   %esi
801022b9:	e8 72 f4 ff ff       	call   80101730 <iupdate>
801022be:	83 c4 10             	add    $0x10,%esp
801022c1:	e9 59 ff ff ff       	jmp    8010221f <removeSwapFile+0x10f>
801022c6:	8d 76 00             	lea    0x0(%esi),%esi
801022c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801022d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022d5:	e9 7d ff ff ff       	jmp    80102257 <removeSwapFile+0x147>
    end_op();
801022da:	e8 31 10 00 00       	call   80103310 <end_op>
    return -1;
801022df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022e4:	e9 6e ff ff ff       	jmp    80102257 <removeSwapFile+0x147>
    panic("unlink: writei");
801022e9:	83 ec 0c             	sub    $0xc,%esp
801022ec:	68 b1 88 10 80       	push   $0x801088b1
801022f1:	e8 9a e0 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801022f6:	83 ec 0c             	sub    $0xc,%esp
801022f9:	68 9f 88 10 80       	push   $0x8010889f
801022fe:	e8 8d e0 ff ff       	call   80100390 <panic>
80102303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102310 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc* p)
{
80102310:	55                   	push   %ebp
80102311:	89 e5                	mov    %esp,%ebp
80102313:	56                   	push   %esi
80102314:	53                   	push   %ebx

  char path[DIGITS];
  memmove(path,"/.swap", 6);
80102315:	8d 75 ea             	lea    -0x16(%ebp),%esi
{
80102318:	83 ec 14             	sub    $0x14,%esp
8010231b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
8010231e:	6a 06                	push   $0x6
80102320:	68 95 88 10 80       	push   $0x80108895
80102325:	56                   	push   %esi
80102326:	e8 f5 2b 00 00       	call   80104f20 <memmove>
  itoa(p->pid, path+ 6);
8010232b:	58                   	pop    %eax
8010232c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010232f:	5a                   	pop    %edx
80102330:	50                   	push   %eax
80102331:	ff 73 10             	pushl  0x10(%ebx)
80102334:	e8 47 fd ff ff       	call   80102080 <itoa>

    begin_op();
80102339:	e8 62 0f 00 00       	call   801032a0 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
8010233e:	6a 00                	push   $0x0
80102340:	6a 00                	push   $0x0
80102342:	6a 02                	push   $0x2
80102344:	56                   	push   %esi
80102345:	e8 16 35 00 00       	call   80105860 <create>
  iunlock(in);
8010234a:	83 c4 14             	add    $0x14,%esp
    struct inode * in = create(path, T_FILE, 0, 0);
8010234d:	89 c6                	mov    %eax,%esi
  iunlock(in);
8010234f:	50                   	push   %eax
80102350:	e8 6b f5 ff ff       	call   801018c0 <iunlock>

  p->swapFile = filealloc();
80102355:	e8 86 eb ff ff       	call   80100ee0 <filealloc>
  if (p->swapFile == 0)
8010235a:	83 c4 10             	add    $0x10,%esp
8010235d:	85 c0                	test   %eax,%eax
  p->swapFile = filealloc();
8010235f:	89 43 7c             	mov    %eax,0x7c(%ebx)
  if (p->swapFile == 0)
80102362:	74 32                	je     80102396 <createSwapFile+0x86>
    panic("no slot for files on /store");

  p->swapFile->ip = in;
80102364:	89 70 10             	mov    %esi,0x10(%eax)
  p->swapFile->type = FD_INODE;
80102367:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010236a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  p->swapFile->off = 0;
80102370:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102373:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  p->swapFile->readable = O_WRONLY;
8010237a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010237d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->swapFile->writable = O_RDWR;
80102381:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102384:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
80102388:	e8 83 0f 00 00       	call   80103310 <end_op>

    return 0;
}
8010238d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102390:	31 c0                	xor    %eax,%eax
80102392:	5b                   	pop    %ebx
80102393:	5e                   	pop    %esi
80102394:	5d                   	pop    %ebp
80102395:	c3                   	ret    
    panic("no slot for files on /store");
80102396:	83 ec 0c             	sub    $0xc,%esp
80102399:	68 c0 88 10 80       	push   $0x801088c0
8010239e:	e8 ed df ff ff       	call   80100390 <panic>
801023a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023b0 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
801023b0:	55                   	push   %ebp
801023b1:	89 e5                	mov    %esp,%ebp
801023b3:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
801023b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801023b9:	8b 50 7c             	mov    0x7c(%eax),%edx
801023bc:	89 4a 14             	mov    %ecx,0x14(%edx)

  return filewrite(p->swapFile, buffer, size);
801023bf:	8b 55 14             	mov    0x14(%ebp),%edx
801023c2:	89 55 10             	mov    %edx,0x10(%ebp)
801023c5:	8b 40 7c             	mov    0x7c(%eax),%eax
801023c8:	89 45 08             	mov    %eax,0x8(%ebp)

}
801023cb:	5d                   	pop    %ebp
  return filewrite(p->swapFile, buffer, size);
801023cc:	e9 7f ed ff ff       	jmp    80101150 <filewrite>
801023d1:	eb 0d                	jmp    801023e0 <readFromSwapFile>
801023d3:	90                   	nop
801023d4:	90                   	nop
801023d5:	90                   	nop
801023d6:	90                   	nop
801023d7:	90                   	nop
801023d8:	90                   	nop
801023d9:	90                   	nop
801023da:	90                   	nop
801023db:	90                   	nop
801023dc:	90                   	nop
801023dd:	90                   	nop
801023de:	90                   	nop
801023df:	90                   	nop

801023e0 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
801023e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801023e9:	8b 50 7c             	mov    0x7c(%eax),%edx
801023ec:	89 4a 14             	mov    %ecx,0x14(%edx)

  return fileread(p->swapFile, buffer,  size);
801023ef:	8b 55 14             	mov    0x14(%ebp),%edx
801023f2:	89 55 10             	mov    %edx,0x10(%ebp)
801023f5:	8b 40 7c             	mov    0x7c(%eax),%eax
801023f8:	89 45 08             	mov    %eax,0x8(%ebp)
}
801023fb:	5d                   	pop    %ebp
  return fileread(p->swapFile, buffer,  size);
801023fc:	e9 bf ec ff ff       	jmp    801010c0 <fileread>
80102401:	66 90                	xchg   %ax,%ax
80102403:	66 90                	xchg   %ax,%ax
80102405:	66 90                	xchg   %ax,%ax
80102407:	66 90                	xchg   %ax,%ax
80102409:	66 90                	xchg   %ax,%ax
8010240b:	66 90                	xchg   %ax,%ax
8010240d:	66 90                	xchg   %ax,%ax
8010240f:	90                   	nop

80102410 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	57                   	push   %edi
80102414:	56                   	push   %esi
80102415:	53                   	push   %ebx
80102416:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102419:	85 c0                	test   %eax,%eax
8010241b:	0f 84 b4 00 00 00    	je     801024d5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102421:	8b 58 08             	mov    0x8(%eax),%ebx
80102424:	89 c6                	mov    %eax,%esi
80102426:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010242c:	0f 87 96 00 00 00    	ja     801024c8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102432:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102437:	89 f6                	mov    %esi,%esi
80102439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102440:	89 ca                	mov    %ecx,%edx
80102442:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102443:	83 e0 c0             	and    $0xffffffc0,%eax
80102446:	3c 40                	cmp    $0x40,%al
80102448:	75 f6                	jne    80102440 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010244a:	31 ff                	xor    %edi,%edi
8010244c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102451:	89 f8                	mov    %edi,%eax
80102453:	ee                   	out    %al,(%dx)
80102454:	b8 01 00 00 00       	mov    $0x1,%eax
80102459:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010245e:	ee                   	out    %al,(%dx)
8010245f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102464:	89 d8                	mov    %ebx,%eax
80102466:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102467:	89 d8                	mov    %ebx,%eax
80102469:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010246e:	c1 f8 08             	sar    $0x8,%eax
80102471:	ee                   	out    %al,(%dx)
80102472:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102477:	89 f8                	mov    %edi,%eax
80102479:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010247a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010247e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102483:	c1 e0 04             	shl    $0x4,%eax
80102486:	83 e0 10             	and    $0x10,%eax
80102489:	83 c8 e0             	or     $0xffffffe0,%eax
8010248c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010248d:	f6 06 04             	testb  $0x4,(%esi)
80102490:	75 16                	jne    801024a8 <idestart+0x98>
80102492:	b8 20 00 00 00       	mov    $0x20,%eax
80102497:	89 ca                	mov    %ecx,%edx
80102499:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010249a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010249d:	5b                   	pop    %ebx
8010249e:	5e                   	pop    %esi
8010249f:	5f                   	pop    %edi
801024a0:	5d                   	pop    %ebp
801024a1:	c3                   	ret    
801024a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024a8:	b8 30 00 00 00       	mov    $0x30,%eax
801024ad:	89 ca                	mov    %ecx,%edx
801024af:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801024b0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801024b5:	83 c6 5c             	add    $0x5c,%esi
801024b8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024bd:	fc                   	cld    
801024be:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801024c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024c3:	5b                   	pop    %ebx
801024c4:	5e                   	pop    %esi
801024c5:	5f                   	pop    %edi
801024c6:	5d                   	pop    %ebp
801024c7:	c3                   	ret    
    panic("incorrect blockno");
801024c8:	83 ec 0c             	sub    $0xc,%esp
801024cb:	68 38 89 10 80       	push   $0x80108938
801024d0:	e8 bb de ff ff       	call   80100390 <panic>
    panic("idestart");
801024d5:	83 ec 0c             	sub    $0xc,%esp
801024d8:	68 2f 89 10 80       	push   $0x8010892f
801024dd:	e8 ae de ff ff       	call   80100390 <panic>
801024e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <ideinit>:
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801024f6:	68 4a 89 10 80       	push   $0x8010894a
801024fb:	68 80 c5 10 80       	push   $0x8010c580
80102500:	e8 1b 27 00 00       	call   80104c20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102505:	58                   	pop    %eax
80102506:	a1 20 cd 14 80       	mov    0x8014cd20,%eax
8010250b:	5a                   	pop    %edx
8010250c:	83 e8 01             	sub    $0x1,%eax
8010250f:	50                   	push   %eax
80102510:	6a 0e                	push   $0xe
80102512:	e8 a9 02 00 00       	call   801027c0 <ioapicenable>
80102517:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010251a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010251f:	90                   	nop
80102520:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102521:	83 e0 c0             	and    $0xffffffc0,%eax
80102524:	3c 40                	cmp    $0x40,%al
80102526:	75 f8                	jne    80102520 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102528:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010252d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102532:	ee                   	out    %al,(%dx)
80102533:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102538:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010253d:	eb 06                	jmp    80102545 <ideinit+0x55>
8010253f:	90                   	nop
  for(i=0; i<1000; i++){
80102540:	83 e9 01             	sub    $0x1,%ecx
80102543:	74 0f                	je     80102554 <ideinit+0x64>
80102545:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102546:	84 c0                	test   %al,%al
80102548:	74 f6                	je     80102540 <ideinit+0x50>
      havedisk1 = 1;
8010254a:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80102551:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102554:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102559:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010255e:	ee                   	out    %al,(%dx)
}
8010255f:	c9                   	leave  
80102560:	c3                   	ret    
80102561:	eb 0d                	jmp    80102570 <ideintr>
80102563:	90                   	nop
80102564:	90                   	nop
80102565:	90                   	nop
80102566:	90                   	nop
80102567:	90                   	nop
80102568:	90                   	nop
80102569:	90                   	nop
8010256a:	90                   	nop
8010256b:	90                   	nop
8010256c:	90                   	nop
8010256d:	90                   	nop
8010256e:	90                   	nop
8010256f:	90                   	nop

80102570 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	57                   	push   %edi
80102574:	56                   	push   %esi
80102575:	53                   	push   %ebx
80102576:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102579:	68 80 c5 10 80       	push   $0x8010c580
8010257e:	e8 dd 27 00 00       	call   80104d60 <acquire>

  if((b = idequeue) == 0){
80102583:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102589:	83 c4 10             	add    $0x10,%esp
8010258c:	85 db                	test   %ebx,%ebx
8010258e:	74 67                	je     801025f7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102590:	8b 43 58             	mov    0x58(%ebx),%eax
80102593:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102598:	8b 3b                	mov    (%ebx),%edi
8010259a:	f7 c7 04 00 00 00    	test   $0x4,%edi
801025a0:	75 31                	jne    801025d3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025a2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025a7:	89 f6                	mov    %esi,%esi
801025a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801025b0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025b1:	89 c6                	mov    %eax,%esi
801025b3:	83 e6 c0             	and    $0xffffffc0,%esi
801025b6:	89 f1                	mov    %esi,%ecx
801025b8:	80 f9 40             	cmp    $0x40,%cl
801025bb:	75 f3                	jne    801025b0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801025bd:	a8 21                	test   $0x21,%al
801025bf:	75 12                	jne    801025d3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801025c1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801025c4:	b9 80 00 00 00       	mov    $0x80,%ecx
801025c9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025ce:	fc                   	cld    
801025cf:	f3 6d                	rep insl (%dx),%es:(%edi)
801025d1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801025d3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801025d6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801025d9:	89 f9                	mov    %edi,%ecx
801025db:	83 c9 02             	or     $0x2,%ecx
801025de:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801025e0:	53                   	push   %ebx
801025e1:	e8 4a 22 00 00       	call   80104830 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801025e6:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801025eb:	83 c4 10             	add    $0x10,%esp
801025ee:	85 c0                	test   %eax,%eax
801025f0:	74 05                	je     801025f7 <ideintr+0x87>
    idestart(idequeue);
801025f2:	e8 19 fe ff ff       	call   80102410 <idestart>
    release(&idelock);
801025f7:	83 ec 0c             	sub    $0xc,%esp
801025fa:	68 80 c5 10 80       	push   $0x8010c580
801025ff:	e8 1c 28 00 00       	call   80104e20 <release>

  release(&idelock);
}
80102604:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102607:	5b                   	pop    %ebx
80102608:	5e                   	pop    %esi
80102609:	5f                   	pop    %edi
8010260a:	5d                   	pop    %ebp
8010260b:	c3                   	ret    
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102610 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	53                   	push   %ebx
80102614:	83 ec 10             	sub    $0x10,%esp
80102617:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010261a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010261d:	50                   	push   %eax
8010261e:	e8 ad 25 00 00       	call   80104bd0 <holdingsleep>
80102623:	83 c4 10             	add    $0x10,%esp
80102626:	85 c0                	test   %eax,%eax
80102628:	0f 84 c6 00 00 00    	je     801026f4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010262e:	8b 03                	mov    (%ebx),%eax
80102630:	83 e0 06             	and    $0x6,%eax
80102633:	83 f8 02             	cmp    $0x2,%eax
80102636:	0f 84 ab 00 00 00    	je     801026e7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010263c:	8b 53 04             	mov    0x4(%ebx),%edx
8010263f:	85 d2                	test   %edx,%edx
80102641:	74 0d                	je     80102650 <iderw+0x40>
80102643:	a1 60 c5 10 80       	mov    0x8010c560,%eax
80102648:	85 c0                	test   %eax,%eax
8010264a:	0f 84 b1 00 00 00    	je     80102701 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	68 80 c5 10 80       	push   $0x8010c580
80102658:	e8 03 27 00 00       	call   80104d60 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010265d:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102663:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102666:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010266d:	85 d2                	test   %edx,%edx
8010266f:	75 09                	jne    8010267a <iderw+0x6a>
80102671:	eb 6d                	jmp    801026e0 <iderw+0xd0>
80102673:	90                   	nop
80102674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102678:	89 c2                	mov    %eax,%edx
8010267a:	8b 42 58             	mov    0x58(%edx),%eax
8010267d:	85 c0                	test   %eax,%eax
8010267f:	75 f7                	jne    80102678 <iderw+0x68>
80102681:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102684:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102686:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
8010268c:	74 42                	je     801026d0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010268e:	8b 03                	mov    (%ebx),%eax
80102690:	83 e0 06             	and    $0x6,%eax
80102693:	83 f8 02             	cmp    $0x2,%eax
80102696:	74 23                	je     801026bb <iderw+0xab>
80102698:	90                   	nop
80102699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801026a0:	83 ec 08             	sub    $0x8,%esp
801026a3:	68 80 c5 10 80       	push   $0x8010c580
801026a8:	53                   	push   %ebx
801026a9:	e8 c2 1f 00 00       	call   80104670 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801026ae:	8b 03                	mov    (%ebx),%eax
801026b0:	83 c4 10             	add    $0x10,%esp
801026b3:	83 e0 06             	and    $0x6,%eax
801026b6:	83 f8 02             	cmp    $0x2,%eax
801026b9:	75 e5                	jne    801026a0 <iderw+0x90>
  }


  release(&idelock);
801026bb:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801026c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026c5:	c9                   	leave  
  release(&idelock);
801026c6:	e9 55 27 00 00       	jmp    80104e20 <release>
801026cb:	90                   	nop
801026cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801026d0:	89 d8                	mov    %ebx,%eax
801026d2:	e8 39 fd ff ff       	call   80102410 <idestart>
801026d7:	eb b5                	jmp    8010268e <iderw+0x7e>
801026d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026e0:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
801026e5:	eb 9d                	jmp    80102684 <iderw+0x74>
    panic("iderw: nothing to do");
801026e7:	83 ec 0c             	sub    $0xc,%esp
801026ea:	68 64 89 10 80       	push   $0x80108964
801026ef:	e8 9c dc ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801026f4:	83 ec 0c             	sub    $0xc,%esp
801026f7:	68 4e 89 10 80       	push   $0x8010894e
801026fc:	e8 8f dc ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102701:	83 ec 0c             	sub    $0xc,%esp
80102704:	68 79 89 10 80       	push   $0x80108979
80102709:	e8 82 dc ff ff       	call   80100390 <panic>
8010270e:	66 90                	xchg   %ax,%ax

80102710 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102710:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102711:	c7 05 34 46 11 80 00 	movl   $0xfec00000,0x80114634
80102718:	00 c0 fe 
{
8010271b:	89 e5                	mov    %esp,%ebp
8010271d:	56                   	push   %esi
8010271e:	53                   	push   %ebx
  ioapic->reg = reg;
8010271f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102726:	00 00 00 
  return ioapic->data;
80102729:	a1 34 46 11 80       	mov    0x80114634,%eax
8010272e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102731:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102737:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010273d:	0f b6 15 80 c7 14 80 	movzbl 0x8014c780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102744:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102747:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010274a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010274d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102750:	39 c2                	cmp    %eax,%edx
80102752:	74 16                	je     8010276a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102754:	83 ec 0c             	sub    $0xc,%esp
80102757:	68 98 89 10 80       	push   $0x80108998
8010275c:	e8 ff de ff ff       	call   80100660 <cprintf>
80102761:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102767:	83 c4 10             	add    $0x10,%esp
8010276a:	83 c3 21             	add    $0x21,%ebx
{
8010276d:	ba 10 00 00 00       	mov    $0x10,%edx
80102772:	b8 20 00 00 00       	mov    $0x20,%eax
80102777:	89 f6                	mov    %esi,%esi
80102779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102780:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102782:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102788:	89 c6                	mov    %eax,%esi
8010278a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102790:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102793:	89 71 10             	mov    %esi,0x10(%ecx)
80102796:	8d 72 01             	lea    0x1(%edx),%esi
80102799:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010279c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010279e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801027a0:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
801027a6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801027ad:	75 d1                	jne    80102780 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801027af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027b2:	5b                   	pop    %ebx
801027b3:	5e                   	pop    %esi
801027b4:	5d                   	pop    %ebp
801027b5:	c3                   	ret    
801027b6:	8d 76 00             	lea    0x0(%esi),%esi
801027b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801027c0:	55                   	push   %ebp
  ioapic->reg = reg;
801027c1:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
{
801027c7:	89 e5                	mov    %esp,%ebp
801027c9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801027cc:	8d 50 20             	lea    0x20(%eax),%edx
801027cf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801027d3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027d5:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027db:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801027de:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027e1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801027e4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027e6:	a1 34 46 11 80       	mov    0x80114634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027eb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801027ee:	89 50 10             	mov    %edx,0x10(%eax)
}
801027f1:	5d                   	pop    %ebp
801027f2:	c3                   	ret    
801027f3:	66 90                	xchg   %ax,%ax
801027f5:	66 90                	xchg   %ax,%ax
801027f7:	66 90                	xchg   %ax,%ax
801027f9:	66 90                	xchg   %ax,%ax
801027fb:	66 90                	xchg   %ax,%ax
801027fd:	66 90                	xchg   %ax,%ax
801027ff:	90                   	nop

80102800 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	56                   	push   %esi
80102804:	53                   	push   %ebx
80102805:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102808:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
8010280e:	0f 85 b9 00 00 00    	jne    801028cd <kfree+0xcd>
80102814:	81 fe c8 a9 15 80    	cmp    $0x8015a9c8,%esi
8010281a:	0f 82 ad 00 00 00    	jb     801028cd <kfree+0xcd>
80102820:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102826:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010282c:	0f 87 9b 00 00 00    	ja     801028cd <kfree+0xcd>
    panic("kfree");

  if(kmem.use_lock)
80102832:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102838:	85 d2                	test   %edx,%edx
8010283a:	75 7c                	jne    801028b8 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;

  if(kmem.pg_refcount[index(V2P(v))] > 0){
8010283c:	c1 eb 0c             	shr    $0xc,%ebx
8010283f:	83 c3 10             	add    $0x10,%ebx
80102842:	8b 04 9d 40 46 11 80 	mov    -0x7feeb9c0(,%ebx,4),%eax
80102849:	85 c0                	test   %eax,%eax
8010284b:	75 3b                	jne    80102888 <kfree+0x88>
    --kmem.pg_refcount[index(V2P(v))];
  }
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
8010284d:	83 ec 04             	sub    $0x4,%esp
80102850:	68 00 10 00 00       	push   $0x1000
80102855:	6a 01                	push   $0x1
80102857:	56                   	push   %esi
80102858:	e8 13 26 00 00       	call   80104e70 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
8010285d:	a1 78 46 11 80       	mov    0x80114678,%eax
    kmem.free_pages++;
80102862:	83 05 7c 46 11 80 01 	addl   $0x1,0x8011467c
    kmem.freelist = r;
80102869:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
8010286c:	89 06                	mov    %eax,(%esi)
  }

  if(kmem.use_lock)
8010286e:	a1 74 46 11 80       	mov    0x80114674,%eax
    kmem.freelist = r;
80102873:	89 35 78 46 11 80    	mov    %esi,0x80114678
  if(kmem.use_lock)
80102879:	85 c0                	test   %eax,%eax
8010287b:	75 22                	jne    8010289f <kfree+0x9f>
    release(&kmem.lock);
}
8010287d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102880:	5b                   	pop    %ebx
80102881:	5e                   	pop    %esi
80102882:	5d                   	pop    %ebp
80102883:	c3                   	ret    
80102884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    --kmem.pg_refcount[index(V2P(v))];
80102888:	83 e8 01             	sub    $0x1,%eax
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
8010288b:	85 c0                	test   %eax,%eax
    --kmem.pg_refcount[index(V2P(v))];
8010288d:	89 04 9d 40 46 11 80 	mov    %eax,-0x7feeb9c0(,%ebx,4)
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
80102894:	74 b7                	je     8010284d <kfree+0x4d>
  if(kmem.use_lock)
80102896:	a1 74 46 11 80       	mov    0x80114674,%eax
8010289b:	85 c0                	test   %eax,%eax
8010289d:	74 de                	je     8010287d <kfree+0x7d>
    release(&kmem.lock);
8010289f:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
801028a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028a9:	5b                   	pop    %ebx
801028aa:	5e                   	pop    %esi
801028ab:	5d                   	pop    %ebp
    release(&kmem.lock);
801028ac:	e9 6f 25 00 00       	jmp    80104e20 <release>
801028b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
801028b8:	83 ec 0c             	sub    $0xc,%esp
801028bb:	68 40 46 11 80       	push   $0x80114640
801028c0:	e8 9b 24 00 00       	call   80104d60 <acquire>
801028c5:	83 c4 10             	add    $0x10,%esp
801028c8:	e9 6f ff ff ff       	jmp    8010283c <kfree+0x3c>
    panic("kfree");
801028cd:	83 ec 0c             	sub    $0xc,%esp
801028d0:	68 ca 89 10 80       	push   $0x801089ca
801028d5:	e8 b6 da ff ff       	call   80100390 <panic>
801028da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028e0 <freerange>:
{
801028e0:	55                   	push   %ebp
801028e1:	89 e5                	mov    %esp,%ebp
801028e3:	56                   	push   %esi
801028e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801028eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028fd:	39 de                	cmp    %ebx,%esi
801028ff:	72 37                	jb     80102938 <freerange+0x58>
80102901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102908:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
8010290e:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102911:	c1 e8 0c             	shr    $0xc,%eax
80102914:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
8010291b:	00 00 00 00 
  kfree(p);
8010291f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102925:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
8010292b:	50                   	push   %eax
8010292c:	e8 cf fe ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102931:	83 c4 10             	add    $0x10,%esp
80102934:	39 f3                	cmp    %esi,%ebx
80102936:	76 d0                	jbe    80102908 <freerange+0x28>
}
80102938:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010293b:	5b                   	pop    %ebx
8010293c:	5e                   	pop    %esi
8010293d:	5d                   	pop    %ebp
8010293e:	c3                   	ret    
8010293f:	90                   	nop

80102940 <kinit1>:
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	56                   	push   %esi
80102944:	53                   	push   %ebx
80102945:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102948:	83 ec 08             	sub    $0x8,%esp
8010294b:	68 d0 89 10 80       	push   $0x801089d0
80102950:	68 40 46 11 80       	push   $0x80114640
80102955:	e8 c6 22 00 00       	call   80104c20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010295a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010295d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102960:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102967:	00 00 00 
  kmem.free_pages = 0;
8010296a:	c7 05 7c 46 11 80 00 	movl   $0x0,0x8011467c
80102971:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102974:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010297a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102980:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102986:	39 de                	cmp    %ebx,%esi
80102988:	72 36                	jb     801029c0 <kinit1+0x80>
8010298a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102990:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
80102996:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102999:	c1 e8 0c             	shr    $0xc,%eax
8010299c:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
801029a3:	00 00 00 00 
  kfree(p);
801029a7:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029ad:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
801029b3:	50                   	push   %eax
801029b4:	e8 47 fe ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029b9:	83 c4 10             	add    $0x10,%esp
801029bc:	39 de                	cmp    %ebx,%esi
801029be:	73 d0                	jae    80102990 <kinit1+0x50>
}
801029c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029c3:	5b                   	pop    %ebx
801029c4:	5e                   	pop    %esi
801029c5:	5d                   	pop    %ebp
801029c6:	c3                   	ret    
801029c7:	89 f6                	mov    %esi,%esi
801029c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801029d0 <kinit2>:
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	56                   	push   %esi
801029d4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801029d5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801029d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801029db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801029e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029ed:	39 de                	cmp    %ebx,%esi
801029ef:	72 37                	jb     80102a28 <kinit2+0x58>
801029f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
801029f8:	8d 83 00 f0 ff 7f    	lea    0x7ffff000(%ebx),%eax
  kfree(p);
801029fe:	83 ec 0c             	sub    $0xc,%esp
  kmem.pg_refcount[V2P(p) >> PGSHIFT] = 0;
80102a01:	c1 e8 0c             	shr    $0xc,%eax
80102a04:	c7 04 85 80 46 11 80 	movl   $0x0,-0x7feeb980(,%eax,4)
80102a0b:	00 00 00 00 
  kfree(p);
80102a0f:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a15:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  kfree(p);
80102a1b:	50                   	push   %eax
80102a1c:	e8 df fd ff ff       	call   80102800 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102a21:	83 c4 10             	add    $0x10,%esp
80102a24:	39 de                	cmp    %ebx,%esi
80102a26:	73 d0                	jae    801029f8 <kinit2+0x28>
  kmem.use_lock = 1;
80102a28:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
80102a2f:	00 00 00 
}
80102a32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a35:	5b                   	pop    %ebx
80102a36:	5e                   	pop    %esi
80102a37:	5d                   	pop    %ebp
80102a38:	c3                   	ret    
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102a40 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102a46:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102a4c:	85 d2                	test   %edx,%edx
80102a4e:	75 50                	jne    80102aa0 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102a50:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102a55:	85 c0                	test   %eax,%eax
80102a57:	74 27                	je     80102a80 <kalloc+0x40>
    kmem.freelist = r->next;
80102a59:	8b 08                	mov    (%eax),%ecx
    kmem.free_pages--;
80102a5b:	83 2d 7c 46 11 80 01 	subl   $0x1,0x8011467c
    kmem.freelist = r->next;
80102a62:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
    kmem.pg_refcount[index(V2P((char*)r))] = 1;
80102a68:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80102a6e:	c1 e9 0c             	shr    $0xc,%ecx
80102a71:	c7 04 8d 80 46 11 80 	movl   $0x1,-0x7feeb980(,%ecx,4)
80102a78:	01 00 00 00 
  }

  if(kmem.use_lock)
80102a7c:	85 d2                	test   %edx,%edx
80102a7e:	75 08                	jne    80102a88 <kalloc+0x48>
    release(&kmem.lock);
  return (char*)r;
}
80102a80:	c9                   	leave  
80102a81:	c3                   	ret    
80102a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102a88:	83 ec 0c             	sub    $0xc,%esp
80102a8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a8e:	68 40 46 11 80       	push   $0x80114640
80102a93:	e8 88 23 00 00       	call   80104e20 <release>
  return (char*)r;
80102a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102a9b:	83 c4 10             	add    $0x10,%esp
}
80102a9e:	c9                   	leave  
80102a9f:	c3                   	ret    
    acquire(&kmem.lock);
80102aa0:	83 ec 0c             	sub    $0xc,%esp
80102aa3:	68 40 46 11 80       	push   $0x80114640
80102aa8:	e8 b3 22 00 00       	call   80104d60 <acquire>
  r = kmem.freelist;
80102aad:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102ab2:	83 c4 10             	add    $0x10,%esp
80102ab5:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102abb:	85 c0                	test   %eax,%eax
80102abd:	75 9a                	jne    80102a59 <kalloc+0x19>
80102abf:	eb bb                	jmp    80102a7c <kalloc+0x3c>
80102ac1:	eb 0d                	jmp    80102ad0 <numFreePages>
80102ac3:	90                   	nop
80102ac4:	90                   	nop
80102ac5:	90                   	nop
80102ac6:	90                   	nop
80102ac7:	90                   	nop
80102ac8:	90                   	nop
80102ac9:	90                   	nop
80102aca:	90                   	nop
80102acb:	90                   	nop
80102acc:	90                   	nop
80102acd:	90                   	nop
80102ace:	90                   	nop
80102acf:	90                   	nop

80102ad0 <numFreePages>:

uint numFreePages(){
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 10             	sub    $0x10,%esp
  acquire(&kmem.lock);
80102ad7:	68 40 46 11 80       	push   $0x80114640
80102adc:	e8 7f 22 00 00       	call   80104d60 <acquire>
  uint free_pages = kmem.free_pages;
80102ae1:	8b 1d 7c 46 11 80    	mov    0x8011467c,%ebx
  release(&kmem.lock);
80102ae7:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102aee:	e8 2d 23 00 00       	call   80104e20 <release>
  return free_pages;
}
80102af3:	89 d8                	mov    %ebx,%eax
80102af5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102af8:	c9                   	leave  
80102af9:	c3                   	ret    
80102afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b00 <resetRefCounter>:

void resetRefCounter(uint pa){
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
  kmem.pg_refcount[index(pa)] = 1;
80102b03:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102b06:	5d                   	pop    %ebp
  kmem.pg_refcount[index(pa)] = 1;
80102b07:	c1 e8 0c             	shr    $0xc,%eax
80102b0a:	c7 04 85 80 46 11 80 	movl   $0x1,-0x7feeb980(,%eax,4)
80102b11:	01 00 00 00 
}
80102b15:	c3                   	ret    
80102b16:	8d 76 00             	lea    0x0(%esi),%esi
80102b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b20 <decrementReferenceCount>:

void decrementReferenceCount(uint pa)
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 04             	sub    $0x4,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("3");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102b2a:	81 fb c8 a9 15 00    	cmp    $0x15a9c8,%ebx
80102b30:	72 33                	jb     80102b65 <decrementReferenceCount+0x45>
80102b32:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102b38:	77 2b                	ja     80102b65 <decrementReferenceCount+0x45>
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
80102b3a:	83 ec 0c             	sub    $0xc,%esp
  --kmem.pg_refcount[index(pa)];
80102b3d:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102b40:	68 40 46 11 80       	push   $0x80114640
80102b45:	e8 16 22 00 00       	call   80104d60 <acquire>
  --kmem.pg_refcount[index(pa)];
80102b4a:	83 2c 9d 80 46 11 80 	subl   $0x1,-0x7feeb980(,%ebx,4)
80102b51:	01 
  release(&kmem.lock);
80102b52:	83 c4 10             	add    $0x10,%esp
80102b55:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)

}
80102b5c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b5f:	c9                   	leave  
  release(&kmem.lock);
80102b60:	e9 bb 22 00 00       	jmp    80104e20 <release>
    panic("decrementReferenceCount");
80102b65:	83 ec 0c             	sub    $0xc,%esp
80102b68:	68 d5 89 10 80       	push   $0x801089d5
80102b6d:	e8 1e d8 ff ff       	call   80100390 <panic>
80102b72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b80 <incrementReferenceCount>:

void incrementReferenceCount(uint pa)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	53                   	push   %ebx
80102b84:	83 ec 04             	sub    $0x4,%esp
80102b87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("2");
  // }
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102b8a:	81 fb c8 a9 15 00    	cmp    $0x15a9c8,%ebx
80102b90:	72 33                	jb     80102bc5 <incrementReferenceCount+0x45>
80102b92:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102b98:	77 2b                	ja     80102bc5 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102b9a:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[index(pa)];
80102b9d:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102ba0:	68 40 46 11 80       	push   $0x80114640
80102ba5:	e8 b6 21 00 00       	call   80104d60 <acquire>
  ++kmem.pg_refcount[index(pa)];
80102baa:	83 04 9d 80 46 11 80 	addl   $0x1,-0x7feeb980(,%ebx,4)
80102bb1:	01 
  release(&kmem.lock);
80102bb2:	83 c4 10             	add    $0x10,%esp
80102bb5:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102bbc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bbf:	c9                   	leave  
  release(&kmem.lock);
80102bc0:	e9 5b 22 00 00       	jmp    80104e20 <release>
    panic("incrementReferenceCount");
80102bc5:	83 ec 0c             	sub    $0xc,%esp
80102bc8:	68 ed 89 10 80       	push   $0x801089ed
80102bcd:	e8 be d7 ff ff       	call   80100390 <panic>
80102bd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102be0 <getReferenceCount>:

uint getReferenceCount(uint pa)
{
80102be0:	55                   	push   %ebp
80102be1:	89 e5                	mov    %esp,%ebp
80102be3:	53                   	push   %ebx
80102be4:	83 ec 04             	sub    $0x4,%esp
80102be7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("1");
  // }

  if( pa >= PHYSTOP)
80102bea:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102bf0:	77 2a                	ja     80102c1c <getReferenceCount+0x3c>
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
80102bf2:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pg_refcount[index(pa)];
80102bf5:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102bf8:	68 40 46 11 80       	push   $0x80114640
80102bfd:	e8 5e 21 00 00       	call   80104d60 <acquire>
  count = kmem.pg_refcount[index(pa)];
80102c02:	8b 1c 9d 80 46 11 80 	mov    -0x7feeb980(,%ebx,4),%ebx
  release(&kmem.lock);
80102c09:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102c10:	e8 0b 22 00 00       	call   80104e20 <release>

  return count;
}
80102c15:	89 d8                	mov    %ebx,%eax
80102c17:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c1a:	c9                   	leave  
80102c1b:	c3                   	ret    
    panic("getReferenceCount");
80102c1c:	83 ec 0c             	sub    $0xc,%esp
80102c1f:	68 05 8a 10 80       	push   $0x80108a05
80102c24:	e8 67 d7 ff ff       	call   80100390 <panic>
80102c29:	66 90                	xchg   %ax,%ax
80102c2b:	66 90                	xchg   %ax,%ax
80102c2d:	66 90                	xchg   %ax,%ax
80102c2f:	90                   	nop

80102c30 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c30:	ba 64 00 00 00       	mov    $0x64,%edx
80102c35:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102c36:	a8 01                	test   $0x1,%al
80102c38:	0f 84 c2 00 00 00    	je     80102d00 <kbdgetc+0xd0>
80102c3e:	ba 60 00 00 00       	mov    $0x60,%edx
80102c43:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102c44:	0f b6 d0             	movzbl %al,%edx
80102c47:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102c4d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102c53:	0f 84 7f 00 00 00    	je     80102cd8 <kbdgetc+0xa8>
{
80102c59:	55                   	push   %ebp
80102c5a:	89 e5                	mov    %esp,%ebp
80102c5c:	53                   	push   %ebx
80102c5d:	89 cb                	mov    %ecx,%ebx
80102c5f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102c62:	84 c0                	test   %al,%al
80102c64:	78 4a                	js     80102cb0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102c66:	85 db                	test   %ebx,%ebx
80102c68:	74 09                	je     80102c73 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c6a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102c6d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102c70:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102c73:	0f b6 82 40 8b 10 80 	movzbl -0x7fef74c0(%edx),%eax
80102c7a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102c7c:	0f b6 82 40 8a 10 80 	movzbl -0x7fef75c0(%edx),%eax
80102c83:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c85:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102c87:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102c8d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c90:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c93:	8b 04 85 20 8a 10 80 	mov    -0x7fef75e0(,%eax,4),%eax
80102c9a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102c9e:	74 31                	je     80102cd1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102ca0:	8d 50 9f             	lea    -0x61(%eax),%edx
80102ca3:	83 fa 19             	cmp    $0x19,%edx
80102ca6:	77 40                	ja     80102ce8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102ca8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102cab:	5b                   	pop    %ebx
80102cac:	5d                   	pop    %ebp
80102cad:	c3                   	ret    
80102cae:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102cb0:	83 e0 7f             	and    $0x7f,%eax
80102cb3:	85 db                	test   %ebx,%ebx
80102cb5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102cb8:	0f b6 82 40 8b 10 80 	movzbl -0x7fef74c0(%edx),%eax
80102cbf:	83 c8 40             	or     $0x40,%eax
80102cc2:	0f b6 c0             	movzbl %al,%eax
80102cc5:	f7 d0                	not    %eax
80102cc7:	21 c1                	and    %eax,%ecx
    return 0;
80102cc9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102ccb:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102cd1:	5b                   	pop    %ebx
80102cd2:	5d                   	pop    %ebp
80102cd3:	c3                   	ret    
80102cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102cd8:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102cdb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102cdd:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102ce3:	c3                   	ret    
80102ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102ce8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102ceb:	8d 50 20             	lea    0x20(%eax),%edx
}
80102cee:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102cef:	83 f9 1a             	cmp    $0x1a,%ecx
80102cf2:	0f 42 c2             	cmovb  %edx,%eax
}
80102cf5:	5d                   	pop    %ebp
80102cf6:	c3                   	ret    
80102cf7:	89 f6                	mov    %esi,%esi
80102cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102d05:	c3                   	ret    
80102d06:	8d 76 00             	lea    0x0(%esi),%esi
80102d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d10 <kbdintr>:

void
kbdintr(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102d16:	68 30 2c 10 80       	push   $0x80102c30
80102d1b:	e8 f0 da ff ff       	call   80100810 <consoleintr>
}
80102d20:	83 c4 10             	add    $0x10,%esp
80102d23:	c9                   	leave  
80102d24:	c3                   	ret    
80102d25:	66 90                	xchg   %ax,%ax
80102d27:	66 90                	xchg   %ax,%ax
80102d29:	66 90                	xchg   %ax,%ax
80102d2b:	66 90                	xchg   %ax,%ax
80102d2d:	66 90                	xchg   %ax,%ax
80102d2f:	90                   	nop

80102d30 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102d30:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102d35:	55                   	push   %ebp
80102d36:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102d38:	85 c0                	test   %eax,%eax
80102d3a:	0f 84 c8 00 00 00    	je     80102e08 <lapicinit+0xd8>
  lapic[index] = value;
80102d40:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102d47:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d4a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d4d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102d54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d5a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102d61:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102d64:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d67:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102d6e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102d71:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d74:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d7b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d81:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d88:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d8b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d8e:	8b 50 30             	mov    0x30(%eax),%edx
80102d91:	c1 ea 10             	shr    $0x10,%edx
80102d94:	80 fa 03             	cmp    $0x3,%dl
80102d97:	77 77                	ja     80102e10 <lapicinit+0xe0>
  lapic[index] = value;
80102d99:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102da0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102da3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102da6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102dad:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102db0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102db3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102dba:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dbd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dc0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102dc7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dca:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dcd:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102dd4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dd7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102dda:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102de1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102de4:	8b 50 20             	mov    0x20(%eax),%edx
80102de7:	89 f6                	mov    %esi,%esi
80102de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102df0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102df6:	80 e6 10             	and    $0x10,%dh
80102df9:	75 f5                	jne    80102df0 <lapicinit+0xc0>
  lapic[index] = value;
80102dfb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102e02:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e05:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102e08:	5d                   	pop    %ebp
80102e09:	c3                   	ret    
80102e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102e10:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102e17:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102e1a:	8b 50 20             	mov    0x20(%eax),%edx
80102e1d:	e9 77 ff ff ff       	jmp    80102d99 <lapicinit+0x69>
80102e22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e30 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102e30:	8b 15 80 c6 14 80    	mov    0x8014c680,%edx
{
80102e36:	55                   	push   %ebp
80102e37:	31 c0                	xor    %eax,%eax
80102e39:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102e3b:	85 d2                	test   %edx,%edx
80102e3d:	74 06                	je     80102e45 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102e3f:	8b 42 20             	mov    0x20(%edx),%eax
80102e42:	c1 e8 18             	shr    $0x18,%eax
}
80102e45:	5d                   	pop    %ebp
80102e46:	c3                   	ret    
80102e47:	89 f6                	mov    %esi,%esi
80102e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e50 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102e50:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102e55:	55                   	push   %ebp
80102e56:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102e58:	85 c0                	test   %eax,%eax
80102e5a:	74 0d                	je     80102e69 <lapiceoi+0x19>
  lapic[index] = value;
80102e5c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e63:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e66:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102e69:	5d                   	pop    %ebp
80102e6a:	c3                   	ret    
80102e6b:	90                   	nop
80102e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e70 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
}
80102e73:	5d                   	pop    %ebp
80102e74:	c3                   	ret    
80102e75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e80 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e80:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e81:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e86:	ba 70 00 00 00       	mov    $0x70,%edx
80102e8b:	89 e5                	mov    %esp,%ebp
80102e8d:	53                   	push   %ebx
80102e8e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e91:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e94:	ee                   	out    %al,(%dx)
80102e95:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e9a:	ba 71 00 00 00       	mov    $0x71,%edx
80102e9f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102ea0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102ea2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102ea5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102eab:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102ead:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102eb0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102eb3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102eb5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102eb8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102ebe:	a1 80 c6 14 80       	mov    0x8014c680,%eax
80102ec3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ec9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ecc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102ed3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ed6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ed9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ee0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ee3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ee6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eec:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102eef:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ef5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ef8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102efe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102f01:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102f07:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102f0a:	5b                   	pop    %ebx
80102f0b:	5d                   	pop    %ebp
80102f0c:	c3                   	ret    
80102f0d:	8d 76 00             	lea    0x0(%esi),%esi

80102f10 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102f10:	55                   	push   %ebp
80102f11:	b8 0b 00 00 00       	mov    $0xb,%eax
80102f16:	ba 70 00 00 00       	mov    $0x70,%edx
80102f1b:	89 e5                	mov    %esp,%ebp
80102f1d:	57                   	push   %edi
80102f1e:	56                   	push   %esi
80102f1f:	53                   	push   %ebx
80102f20:	83 ec 4c             	sub    $0x4c,%esp
80102f23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f24:	ba 71 00 00 00       	mov    $0x71,%edx
80102f29:	ec                   	in     (%dx),%al
80102f2a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f2d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102f32:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
80102f38:	31 c0                	xor    %eax,%eax
80102f3a:	89 da                	mov    %ebx,%edx
80102f3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f3d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102f42:	89 ca                	mov    %ecx,%edx
80102f44:	ec                   	in     (%dx),%al
80102f45:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f48:	89 da                	mov    %ebx,%edx
80102f4a:	b8 02 00 00 00       	mov    $0x2,%eax
80102f4f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f50:	89 ca                	mov    %ecx,%edx
80102f52:	ec                   	in     (%dx),%al
80102f53:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f56:	89 da                	mov    %ebx,%edx
80102f58:	b8 04 00 00 00       	mov    $0x4,%eax
80102f5d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f5e:	89 ca                	mov    %ecx,%edx
80102f60:	ec                   	in     (%dx),%al
80102f61:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f64:	89 da                	mov    %ebx,%edx
80102f66:	b8 07 00 00 00       	mov    $0x7,%eax
80102f6b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f6c:	89 ca                	mov    %ecx,%edx
80102f6e:	ec                   	in     (%dx),%al
80102f6f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f72:	89 da                	mov    %ebx,%edx
80102f74:	b8 08 00 00 00       	mov    $0x8,%eax
80102f79:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f7a:	89 ca                	mov    %ecx,%edx
80102f7c:	ec                   	in     (%dx),%al
80102f7d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f7f:	89 da                	mov    %ebx,%edx
80102f81:	b8 09 00 00 00       	mov    $0x9,%eax
80102f86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f87:	89 ca                	mov    %ecx,%edx
80102f89:	ec                   	in     (%dx),%al
80102f8a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f8c:	89 da                	mov    %ebx,%edx
80102f8e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f93:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f94:	89 ca                	mov    %ecx,%edx
80102f96:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f97:	84 c0                	test   %al,%al
80102f99:	78 9d                	js     80102f38 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102f9b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f9f:	89 fa                	mov    %edi,%edx
80102fa1:	0f b6 fa             	movzbl %dl,%edi
80102fa4:	89 f2                	mov    %esi,%edx
80102fa6:	0f b6 f2             	movzbl %dl,%esi
80102fa9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fac:	89 da                	mov    %ebx,%edx
80102fae:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102fb1:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fb4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102fb8:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102fbb:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102fbf:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102fc2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102fc6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102fc9:	31 c0                	xor    %eax,%eax
80102fcb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fcc:	89 ca                	mov    %ecx,%edx
80102fce:	ec                   	in     (%dx),%al
80102fcf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fd2:	89 da                	mov    %ebx,%edx
80102fd4:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102fd7:	b8 02 00 00 00       	mov    $0x2,%eax
80102fdc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fdd:	89 ca                	mov    %ecx,%edx
80102fdf:	ec                   	in     (%dx),%al
80102fe0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fe3:	89 da                	mov    %ebx,%edx
80102fe5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102fe8:	b8 04 00 00 00       	mov    $0x4,%eax
80102fed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fee:	89 ca                	mov    %ecx,%edx
80102ff0:	ec                   	in     (%dx),%al
80102ff1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ff4:	89 da                	mov    %ebx,%edx
80102ff6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ff9:	b8 07 00 00 00       	mov    $0x7,%eax
80102ffe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fff:	89 ca                	mov    %ecx,%edx
80103001:	ec                   	in     (%dx),%al
80103002:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103005:	89 da                	mov    %ebx,%edx
80103007:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010300a:	b8 08 00 00 00       	mov    $0x8,%eax
8010300f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103010:	89 ca                	mov    %ecx,%edx
80103012:	ec                   	in     (%dx),%al
80103013:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103016:	89 da                	mov    %ebx,%edx
80103018:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010301b:	b8 09 00 00 00       	mov    $0x9,%eax
80103020:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103021:	89 ca                	mov    %ecx,%edx
80103023:	ec                   	in     (%dx),%al
80103024:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103027:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010302a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010302d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80103030:	6a 18                	push   $0x18
80103032:	50                   	push   %eax
80103033:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103036:	50                   	push   %eax
80103037:	e8 84 1e 00 00       	call   80104ec0 <memcmp>
8010303c:	83 c4 10             	add    $0x10,%esp
8010303f:	85 c0                	test   %eax,%eax
80103041:	0f 85 f1 fe ff ff    	jne    80102f38 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103047:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010304b:	75 78                	jne    801030c5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010304d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103050:	89 c2                	mov    %eax,%edx
80103052:	83 e0 0f             	and    $0xf,%eax
80103055:	c1 ea 04             	shr    $0x4,%edx
80103058:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010305b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010305e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103061:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103064:	89 c2                	mov    %eax,%edx
80103066:	83 e0 0f             	and    $0xf,%eax
80103069:	c1 ea 04             	shr    $0x4,%edx
8010306c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010306f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103072:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103075:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103078:	89 c2                	mov    %eax,%edx
8010307a:	83 e0 0f             	and    $0xf,%eax
8010307d:	c1 ea 04             	shr    $0x4,%edx
80103080:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103083:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103086:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103089:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010308c:	89 c2                	mov    %eax,%edx
8010308e:	83 e0 0f             	and    $0xf,%eax
80103091:	c1 ea 04             	shr    $0x4,%edx
80103094:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103097:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010309a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010309d:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030a0:	89 c2                	mov    %eax,%edx
801030a2:	83 e0 0f             	and    $0xf,%eax
801030a5:	c1 ea 04             	shr    $0x4,%edx
801030a8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030ab:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030ae:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801030b1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030b4:	89 c2                	mov    %eax,%edx
801030b6:	83 e0 0f             	and    $0xf,%eax
801030b9:	c1 ea 04             	shr    $0x4,%edx
801030bc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801030bf:	8d 04 50             	lea    (%eax,%edx,2),%eax
801030c2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801030c5:	8b 75 08             	mov    0x8(%ebp),%esi
801030c8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801030cb:	89 06                	mov    %eax,(%esi)
801030cd:	8b 45 bc             	mov    -0x44(%ebp),%eax
801030d0:	89 46 04             	mov    %eax,0x4(%esi)
801030d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801030d6:	89 46 08             	mov    %eax,0x8(%esi)
801030d9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801030dc:	89 46 0c             	mov    %eax,0xc(%esi)
801030df:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030e2:	89 46 10             	mov    %eax,0x10(%esi)
801030e5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030e8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801030eb:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801030f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030f5:	5b                   	pop    %ebx
801030f6:	5e                   	pop    %esi
801030f7:	5f                   	pop    %edi
801030f8:	5d                   	pop    %ebp
801030f9:	c3                   	ret    
801030fa:	66 90                	xchg   %ax,%ax
801030fc:	66 90                	xchg   %ax,%ax
801030fe:	66 90                	xchg   %ax,%ax

80103100 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103100:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103106:	85 c9                	test   %ecx,%ecx
80103108:	0f 8e 8a 00 00 00    	jle    80103198 <install_trans+0x98>
{
8010310e:	55                   	push   %ebp
8010310f:	89 e5                	mov    %esp,%ebp
80103111:	57                   	push   %edi
80103112:	56                   	push   %esi
80103113:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80103114:	31 db                	xor    %ebx,%ebx
{
80103116:	83 ec 0c             	sub    $0xc,%esp
80103119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103120:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103125:	83 ec 08             	sub    $0x8,%esp
80103128:	01 d8                	add    %ebx,%eax
8010312a:	83 c0 01             	add    $0x1,%eax
8010312d:	50                   	push   %eax
8010312e:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103134:	e8 97 cf ff ff       	call   801000d0 <bread>
80103139:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010313b:	58                   	pop    %eax
8010313c:	5a                   	pop    %edx
8010313d:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103144:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010314a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010314d:	e8 7e cf ff ff       	call   801000d0 <bread>
80103152:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103154:	8d 47 5c             	lea    0x5c(%edi),%eax
80103157:	83 c4 0c             	add    $0xc,%esp
8010315a:	68 00 02 00 00       	push   $0x200
8010315f:	50                   	push   %eax
80103160:	8d 46 5c             	lea    0x5c(%esi),%eax
80103163:	50                   	push   %eax
80103164:	e8 b7 1d 00 00       	call   80104f20 <memmove>
    bwrite(dbuf);  // write dst to disk
80103169:	89 34 24             	mov    %esi,(%esp)
8010316c:	e8 2f d0 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103171:	89 3c 24             	mov    %edi,(%esp)
80103174:	e8 67 d0 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103179:	89 34 24             	mov    %esi,(%esp)
8010317c:	e8 5f d0 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103181:	83 c4 10             	add    $0x10,%esp
80103184:	39 1d e8 c6 14 80    	cmp    %ebx,0x8014c6e8
8010318a:	7f 94                	jg     80103120 <install_trans+0x20>
  }
}
8010318c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010318f:	5b                   	pop    %ebx
80103190:	5e                   	pop    %esi
80103191:	5f                   	pop    %edi
80103192:	5d                   	pop    %ebp
80103193:	c3                   	ret    
80103194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103198:	f3 c3                	repz ret 
8010319a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801031a0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	56                   	push   %esi
801031a4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
801031a5:	83 ec 08             	sub    $0x8,%esp
801031a8:	ff 35 d4 c6 14 80    	pushl  0x8014c6d4
801031ae:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
801031b4:	e8 17 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801031b9:	8b 1d e8 c6 14 80    	mov    0x8014c6e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
801031bf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
801031c2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
801031c4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
801031c6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031c9:	7e 16                	jle    801031e1 <write_head+0x41>
801031cb:	c1 e3 02             	shl    $0x2,%ebx
801031ce:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
801031d0:	8b 8a ec c6 14 80    	mov    -0x7feb3914(%edx),%ecx
801031d6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
801031da:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
801031dd:	39 da                	cmp    %ebx,%edx
801031df:	75 ef                	jne    801031d0 <write_head+0x30>
  }
  bwrite(buf);
801031e1:	83 ec 0c             	sub    $0xc,%esp
801031e4:	56                   	push   %esi
801031e5:	e8 b6 cf ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801031ea:	89 34 24             	mov    %esi,(%esp)
801031ed:	e8 ee cf ff ff       	call   801001e0 <brelse>
}
801031f2:	83 c4 10             	add    $0x10,%esp
801031f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031f8:	5b                   	pop    %ebx
801031f9:	5e                   	pop    %esi
801031fa:	5d                   	pop    %ebp
801031fb:	c3                   	ret    
801031fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103200 <initlog>:
{
80103200:	55                   	push   %ebp
80103201:	89 e5                	mov    %esp,%ebp
80103203:	53                   	push   %ebx
80103204:	83 ec 2c             	sub    $0x2c,%esp
80103207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010320a:	68 40 8c 10 80       	push   $0x80108c40
8010320f:	68 a0 c6 14 80       	push   $0x8014c6a0
80103214:	e8 07 1a 00 00       	call   80104c20 <initlock>
  readsb(dev, &sb);
80103219:	58                   	pop    %eax
8010321a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010321d:	5a                   	pop    %edx
8010321e:	50                   	push   %eax
8010321f:	53                   	push   %ebx
80103220:	e8 7b e3 ff ff       	call   801015a0 <readsb>
  log.size = sb.nlog;
80103225:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103228:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010322b:	59                   	pop    %ecx
  log.dev = dev;
8010322c:	89 1d e4 c6 14 80    	mov    %ebx,0x8014c6e4
  log.size = sb.nlog;
80103232:	89 15 d8 c6 14 80    	mov    %edx,0x8014c6d8
  log.start = sb.logstart;
80103238:	a3 d4 c6 14 80       	mov    %eax,0x8014c6d4
  struct buf *buf = bread(log.dev, log.start);
8010323d:	5a                   	pop    %edx
8010323e:	50                   	push   %eax
8010323f:	53                   	push   %ebx
80103240:	e8 8b ce ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103245:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80103248:	83 c4 10             	add    $0x10,%esp
8010324b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
8010324d:	89 1d e8 c6 14 80    	mov    %ebx,0x8014c6e8
  for (i = 0; i < log.lh.n; i++) {
80103253:	7e 1c                	jle    80103271 <initlog+0x71>
80103255:	c1 e3 02             	shl    $0x2,%ebx
80103258:	31 d2                	xor    %edx,%edx
8010325a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103260:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103264:	83 c2 04             	add    $0x4,%edx
80103267:	89 8a e8 c6 14 80    	mov    %ecx,-0x7feb3918(%edx)
  for (i = 0; i < log.lh.n; i++) {
8010326d:	39 d3                	cmp    %edx,%ebx
8010326f:	75 ef                	jne    80103260 <initlog+0x60>
  brelse(buf);
80103271:	83 ec 0c             	sub    $0xc,%esp
80103274:	50                   	push   %eax
80103275:	e8 66 cf ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010327a:	e8 81 fe ff ff       	call   80103100 <install_trans>
  log.lh.n = 0;
8010327f:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
80103286:	00 00 00 
  write_head(); // clear the log
80103289:	e8 12 ff ff ff       	call   801031a0 <write_head>
}
8010328e:	83 c4 10             	add    $0x10,%esp
80103291:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103294:	c9                   	leave  
80103295:	c3                   	ret    
80103296:	8d 76 00             	lea    0x0(%esi),%esi
80103299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801032a0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801032a6:	68 a0 c6 14 80       	push   $0x8014c6a0
801032ab:	e8 b0 1a 00 00       	call   80104d60 <acquire>
801032b0:	83 c4 10             	add    $0x10,%esp
801032b3:	eb 18                	jmp    801032cd <begin_op+0x2d>
801032b5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801032b8:	83 ec 08             	sub    $0x8,%esp
801032bb:	68 a0 c6 14 80       	push   $0x8014c6a0
801032c0:	68 a0 c6 14 80       	push   $0x8014c6a0
801032c5:	e8 a6 13 00 00       	call   80104670 <sleep>
801032ca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801032cd:	a1 e0 c6 14 80       	mov    0x8014c6e0,%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	75 e2                	jne    801032b8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801032d6:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
801032db:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
801032e1:	83 c0 01             	add    $0x1,%eax
801032e4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801032e7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801032ea:	83 fa 1e             	cmp    $0x1e,%edx
801032ed:	7f c9                	jg     801032b8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801032ef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801032f2:	a3 dc c6 14 80       	mov    %eax,0x8014c6dc
      release(&log.lock);
801032f7:	68 a0 c6 14 80       	push   $0x8014c6a0
801032fc:	e8 1f 1b 00 00       	call   80104e20 <release>
      break;
    }
  }
}
80103301:	83 c4 10             	add    $0x10,%esp
80103304:	c9                   	leave  
80103305:	c3                   	ret    
80103306:	8d 76 00             	lea    0x0(%esi),%esi
80103309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103310 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	57                   	push   %edi
80103314:	56                   	push   %esi
80103315:	53                   	push   %ebx
80103316:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103319:	68 a0 c6 14 80       	push   $0x8014c6a0
8010331e:	e8 3d 1a 00 00       	call   80104d60 <acquire>
  log.outstanding -= 1;
80103323:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
  if(log.committing)
80103328:	8b 35 e0 c6 14 80    	mov    0x8014c6e0,%esi
8010332e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103331:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103334:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103336:	89 1d dc c6 14 80    	mov    %ebx,0x8014c6dc
  if(log.committing)
8010333c:	0f 85 1a 01 00 00    	jne    8010345c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103342:	85 db                	test   %ebx,%ebx
80103344:	0f 85 ee 00 00 00    	jne    80103438 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010334a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010334d:	c7 05 e0 c6 14 80 01 	movl   $0x1,0x8014c6e0
80103354:	00 00 00 
  release(&log.lock);
80103357:	68 a0 c6 14 80       	push   $0x8014c6a0
8010335c:	e8 bf 1a 00 00       	call   80104e20 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103361:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103367:	83 c4 10             	add    $0x10,%esp
8010336a:	85 c9                	test   %ecx,%ecx
8010336c:	0f 8e 85 00 00 00    	jle    801033f7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103372:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103377:	83 ec 08             	sub    $0x8,%esp
8010337a:	01 d8                	add    %ebx,%eax
8010337c:	83 c0 01             	add    $0x1,%eax
8010337f:	50                   	push   %eax
80103380:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103386:	e8 45 cd ff ff       	call   801000d0 <bread>
8010338b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010338d:	58                   	pop    %eax
8010338e:	5a                   	pop    %edx
8010338f:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103396:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010339c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010339f:	e8 2c cd ff ff       	call   801000d0 <bread>
801033a4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801033a6:	8d 40 5c             	lea    0x5c(%eax),%eax
801033a9:	83 c4 0c             	add    $0xc,%esp
801033ac:	68 00 02 00 00       	push   $0x200
801033b1:	50                   	push   %eax
801033b2:	8d 46 5c             	lea    0x5c(%esi),%eax
801033b5:	50                   	push   %eax
801033b6:	e8 65 1b 00 00       	call   80104f20 <memmove>
    bwrite(to);  // write the log
801033bb:	89 34 24             	mov    %esi,(%esp)
801033be:	e8 dd cd ff ff       	call   801001a0 <bwrite>
    brelse(from);
801033c3:	89 3c 24             	mov    %edi,(%esp)
801033c6:	e8 15 ce ff ff       	call   801001e0 <brelse>
    brelse(to);
801033cb:	89 34 24             	mov    %esi,(%esp)
801033ce:	e8 0d ce ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801033d3:	83 c4 10             	add    $0x10,%esp
801033d6:	3b 1d e8 c6 14 80    	cmp    0x8014c6e8,%ebx
801033dc:	7c 94                	jl     80103372 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801033de:	e8 bd fd ff ff       	call   801031a0 <write_head>
    install_trans(); // Now install writes to home locations
801033e3:	e8 18 fd ff ff       	call   80103100 <install_trans>
    log.lh.n = 0;
801033e8:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
801033ef:	00 00 00 
    write_head();    // Erase the transaction from the log
801033f2:	e8 a9 fd ff ff       	call   801031a0 <write_head>
    acquire(&log.lock);
801033f7:	83 ec 0c             	sub    $0xc,%esp
801033fa:	68 a0 c6 14 80       	push   $0x8014c6a0
801033ff:	e8 5c 19 00 00       	call   80104d60 <acquire>
    wakeup(&log);
80103404:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
    log.committing = 0;
8010340b:	c7 05 e0 c6 14 80 00 	movl   $0x0,0x8014c6e0
80103412:	00 00 00 
    wakeup(&log);
80103415:	e8 16 14 00 00       	call   80104830 <wakeup>
    release(&log.lock);
8010341a:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
80103421:	e8 fa 19 00 00       	call   80104e20 <release>
80103426:	83 c4 10             	add    $0x10,%esp
}
80103429:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010342c:	5b                   	pop    %ebx
8010342d:	5e                   	pop    %esi
8010342e:	5f                   	pop    %edi
8010342f:	5d                   	pop    %ebp
80103430:	c3                   	ret    
80103431:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80103438:	83 ec 0c             	sub    $0xc,%esp
8010343b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103440:	e8 eb 13 00 00       	call   80104830 <wakeup>
  release(&log.lock);
80103445:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
8010344c:	e8 cf 19 00 00       	call   80104e20 <release>
80103451:	83 c4 10             	add    $0x10,%esp
}
80103454:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103457:	5b                   	pop    %ebx
80103458:	5e                   	pop    %esi
80103459:	5f                   	pop    %edi
8010345a:	5d                   	pop    %ebp
8010345b:	c3                   	ret    
    panic("log.committing");
8010345c:	83 ec 0c             	sub    $0xc,%esp
8010345f:	68 44 8c 10 80       	push   $0x80108c44
80103464:	e8 27 cf ff ff       	call   80100390 <panic>
80103469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103470 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103470:	55                   	push   %ebp
80103471:	89 e5                	mov    %esp,%ebp
80103473:	53                   	push   %ebx
80103474:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103477:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
{
8010347d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103480:	83 fa 1d             	cmp    $0x1d,%edx
80103483:	0f 8f 9d 00 00 00    	jg     80103526 <log_write+0xb6>
80103489:	a1 d8 c6 14 80       	mov    0x8014c6d8,%eax
8010348e:	83 e8 01             	sub    $0x1,%eax
80103491:	39 c2                	cmp    %eax,%edx
80103493:	0f 8d 8d 00 00 00    	jge    80103526 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103499:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010349e:	85 c0                	test   %eax,%eax
801034a0:	0f 8e 8d 00 00 00    	jle    80103533 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
801034a6:	83 ec 0c             	sub    $0xc,%esp
801034a9:	68 a0 c6 14 80       	push   $0x8014c6a0
801034ae:	e8 ad 18 00 00       	call   80104d60 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801034b3:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
801034b9:	83 c4 10             	add    $0x10,%esp
801034bc:	83 f9 00             	cmp    $0x0,%ecx
801034bf:	7e 57                	jle    80103518 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034c1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801034c4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034c6:	3b 15 ec c6 14 80    	cmp    0x8014c6ec,%edx
801034cc:	75 0b                	jne    801034d9 <log_write+0x69>
801034ce:	eb 38                	jmp    80103508 <log_write+0x98>
801034d0:	39 14 85 ec c6 14 80 	cmp    %edx,-0x7feb3914(,%eax,4)
801034d7:	74 2f                	je     80103508 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801034d9:	83 c0 01             	add    $0x1,%eax
801034dc:	39 c1                	cmp    %eax,%ecx
801034de:	75 f0                	jne    801034d0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801034e0:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801034e7:	83 c0 01             	add    $0x1,%eax
801034ea:	a3 e8 c6 14 80       	mov    %eax,0x8014c6e8
  b->flags |= B_DIRTY; // prevent eviction
801034ef:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801034f2:	c7 45 08 a0 c6 14 80 	movl   $0x8014c6a0,0x8(%ebp)
}
801034f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034fc:	c9                   	leave  
  release(&log.lock);
801034fd:	e9 1e 19 00 00       	jmp    80104e20 <release>
80103502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103508:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
8010350f:	eb de                	jmp    801034ef <log_write+0x7f>
80103511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103518:	8b 43 08             	mov    0x8(%ebx),%eax
8010351b:	a3 ec c6 14 80       	mov    %eax,0x8014c6ec
  if (i == log.lh.n)
80103520:	75 cd                	jne    801034ef <log_write+0x7f>
80103522:	31 c0                	xor    %eax,%eax
80103524:	eb c1                	jmp    801034e7 <log_write+0x77>
    panic("too big a transaction");
80103526:	83 ec 0c             	sub    $0xc,%esp
80103529:	68 53 8c 10 80       	push   $0x80108c53
8010352e:	e8 5d ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103533:	83 ec 0c             	sub    $0xc,%esp
80103536:	68 69 8c 10 80       	push   $0x80108c69
8010353b:	e8 50 ce ff ff       	call   80100390 <panic>

80103540 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	53                   	push   %ebx
80103544:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103547:	e8 24 0a 00 00       	call   80103f70 <cpuid>
8010354c:	89 c3                	mov    %eax,%ebx
8010354e:	e8 1d 0a 00 00       	call   80103f70 <cpuid>
80103553:	83 ec 04             	sub    $0x4,%esp
80103556:	53                   	push   %ebx
80103557:	50                   	push   %eax
80103558:	68 84 8c 10 80       	push   $0x80108c84
8010355d:	e8 fe d0 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103562:	e8 d9 2b 00 00       	call   80106140 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103567:	e8 84 09 00 00       	call   80103ef0 <mycpu>
8010356c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010356e:	b8 01 00 00 00       	mov    $0x1,%eax
80103573:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010357a:	e8 e1 0d 00 00       	call   80104360 <scheduler>
8010357f:	90                   	nop

80103580 <mpenter>:
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103586:	e8 c5 3d 00 00       	call   80107350 <switchkvm>
  seginit();
8010358b:	e8 30 3d 00 00       	call   801072c0 <seginit>
  lapicinit();
80103590:	e8 9b f7 ff ff       	call   80102d30 <lapicinit>
  mpmain();
80103595:	e8 a6 ff ff ff       	call   80103540 <mpmain>
8010359a:	66 90                	xchg   %ax,%ax
8010359c:	66 90                	xchg   %ax,%ax
8010359e:	66 90                	xchg   %ax,%ax

801035a0 <main>:
{
801035a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801035a4:	83 e4 f0             	and    $0xfffffff0,%esp
801035a7:	ff 71 fc             	pushl  -0x4(%ecx)
801035aa:	55                   	push   %ebp
801035ab:	89 e5                	mov    %esp,%ebp
801035ad:	53                   	push   %ebx
801035ae:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801035af:	83 ec 08             	sub    $0x8,%esp
801035b2:	68 00 00 40 80       	push   $0x80400000
801035b7:	68 c8 a9 15 80       	push   $0x8015a9c8
801035bc:	e8 7f f3 ff ff       	call   80102940 <kinit1>
  kvmalloc();      // kernel page table
801035c1:	e8 6a 42 00 00       	call   80107830 <kvmalloc>
  mpinit();        // detect other processors
801035c6:	e8 75 01 00 00       	call   80103740 <mpinit>
  lapicinit();     // interrupt controller
801035cb:	e8 60 f7 ff ff       	call   80102d30 <lapicinit>
  seginit();       // segment descriptors
801035d0:	e8 eb 3c 00 00       	call   801072c0 <seginit>
  picinit();       // disable pic
801035d5:	e8 46 03 00 00       	call   80103920 <picinit>
  ioapicinit();    // another interrupt controller
801035da:	e8 31 f1 ff ff       	call   80102710 <ioapicinit>
  consoleinit();   // console hardware
801035df:	e8 dc d3 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801035e4:	e8 47 30 00 00       	call   80106630 <uartinit>
  pinit();         // process table
801035e9:	e8 e2 08 00 00       	call   80103ed0 <pinit>
  tvinit();        // trap vectors
801035ee:	e8 cd 2a 00 00       	call   801060c0 <tvinit>
  binit();         // buffer cache
801035f3:	e8 48 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
801035f8:	e8 c3 d8 ff ff       	call   80100ec0 <fileinit>
  ideinit();       // disk 
801035fd:	e8 ee ee ff ff       	call   801024f0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103602:	83 c4 0c             	add    $0xc,%esp
80103605:	68 8a 00 00 00       	push   $0x8a
8010360a:	68 8c c4 10 80       	push   $0x8010c48c
8010360f:	68 00 70 00 80       	push   $0x80007000
80103614:	e8 07 19 00 00       	call   80104f20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103619:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103620:	00 00 00 
80103623:	83 c4 10             	add    $0x10,%esp
80103626:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010362b:	3d a0 c7 14 80       	cmp    $0x8014c7a0,%eax
80103630:	76 71                	jbe    801036a3 <main+0x103>
80103632:	bb a0 c7 14 80       	mov    $0x8014c7a0,%ebx
80103637:	89 f6                	mov    %esi,%esi
80103639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103640:	e8 ab 08 00 00       	call   80103ef0 <mycpu>
80103645:	39 d8                	cmp    %ebx,%eax
80103647:	74 41                	je     8010368a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103649:	e8 f2 f3 ff ff       	call   80102a40 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010364e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103653:	c7 05 f8 6f 00 80 80 	movl   $0x80103580,0x80006ff8
8010365a:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010365d:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103664:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103667:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010366c:	0f b6 03             	movzbl (%ebx),%eax
8010366f:	83 ec 08             	sub    $0x8,%esp
80103672:	68 00 70 00 00       	push   $0x7000
80103677:	50                   	push   %eax
80103678:	e8 03 f8 ff ff       	call   80102e80 <lapicstartap>
8010367d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103680:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103686:	85 c0                	test   %eax,%eax
80103688:	74 f6                	je     80103680 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010368a:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103691:	00 00 00 
80103694:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010369a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010369f:	39 c3                	cmp    %eax,%ebx
801036a1:	72 9d                	jb     80103640 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801036a3:	83 ec 08             	sub    $0x8,%esp
801036a6:	68 00 00 00 8e       	push   $0x8e000000
801036ab:	68 00 00 40 80       	push   $0x80400000
801036b0:	e8 1b f3 ff ff       	call   801029d0 <kinit2>
  userinit();      // first user process
801036b5:	e8 06 09 00 00       	call   80103fc0 <userinit>
  mpmain();        // finish this processor's setup
801036ba:	e8 81 fe ff ff       	call   80103540 <mpmain>
801036bf:	90                   	nop

801036c0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801036c5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801036cb:	53                   	push   %ebx
  e = addr+len;
801036cc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801036cf:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801036d2:	39 de                	cmp    %ebx,%esi
801036d4:	72 10                	jb     801036e6 <mpsearch1+0x26>
801036d6:	eb 50                	jmp    80103728 <mpsearch1+0x68>
801036d8:	90                   	nop
801036d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036e0:	39 fb                	cmp    %edi,%ebx
801036e2:	89 fe                	mov    %edi,%esi
801036e4:	76 42                	jbe    80103728 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036e6:	83 ec 04             	sub    $0x4,%esp
801036e9:	8d 7e 10             	lea    0x10(%esi),%edi
801036ec:	6a 04                	push   $0x4
801036ee:	68 98 8c 10 80       	push   $0x80108c98
801036f3:	56                   	push   %esi
801036f4:	e8 c7 17 00 00       	call   80104ec0 <memcmp>
801036f9:	83 c4 10             	add    $0x10,%esp
801036fc:	85 c0                	test   %eax,%eax
801036fe:	75 e0                	jne    801036e0 <mpsearch1+0x20>
80103700:	89 f1                	mov    %esi,%ecx
80103702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103708:	0f b6 11             	movzbl (%ecx),%edx
8010370b:	83 c1 01             	add    $0x1,%ecx
8010370e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103710:	39 f9                	cmp    %edi,%ecx
80103712:	75 f4                	jne    80103708 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103714:	84 c0                	test   %al,%al
80103716:	75 c8                	jne    801036e0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103718:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010371b:	89 f0                	mov    %esi,%eax
8010371d:	5b                   	pop    %ebx
8010371e:	5e                   	pop    %esi
8010371f:	5f                   	pop    %edi
80103720:	5d                   	pop    %ebp
80103721:	c3                   	ret    
80103722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103728:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010372b:	31 f6                	xor    %esi,%esi
}
8010372d:	89 f0                	mov    %esi,%eax
8010372f:	5b                   	pop    %ebx
80103730:	5e                   	pop    %esi
80103731:	5f                   	pop    %edi
80103732:	5d                   	pop    %ebp
80103733:	c3                   	ret    
80103734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010373a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103740 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	57                   	push   %edi
80103744:	56                   	push   %esi
80103745:	53                   	push   %ebx
80103746:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103749:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103750:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103757:	c1 e0 08             	shl    $0x8,%eax
8010375a:	09 d0                	or     %edx,%eax
8010375c:	c1 e0 04             	shl    $0x4,%eax
8010375f:	85 c0                	test   %eax,%eax
80103761:	75 1b                	jne    8010377e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103763:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010376a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103771:	c1 e0 08             	shl    $0x8,%eax
80103774:	09 d0                	or     %edx,%eax
80103776:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103779:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010377e:	ba 00 04 00 00       	mov    $0x400,%edx
80103783:	e8 38 ff ff ff       	call   801036c0 <mpsearch1>
80103788:	85 c0                	test   %eax,%eax
8010378a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010378d:	0f 84 3d 01 00 00    	je     801038d0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103793:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103796:	8b 58 04             	mov    0x4(%eax),%ebx
80103799:	85 db                	test   %ebx,%ebx
8010379b:	0f 84 4f 01 00 00    	je     801038f0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801037a1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801037a7:	83 ec 04             	sub    $0x4,%esp
801037aa:	6a 04                	push   $0x4
801037ac:	68 b5 8c 10 80       	push   $0x80108cb5
801037b1:	56                   	push   %esi
801037b2:	e8 09 17 00 00       	call   80104ec0 <memcmp>
801037b7:	83 c4 10             	add    $0x10,%esp
801037ba:	85 c0                	test   %eax,%eax
801037bc:	0f 85 2e 01 00 00    	jne    801038f0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801037c2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801037c9:	3c 01                	cmp    $0x1,%al
801037cb:	0f 95 c2             	setne  %dl
801037ce:	3c 04                	cmp    $0x4,%al
801037d0:	0f 95 c0             	setne  %al
801037d3:	20 c2                	and    %al,%dl
801037d5:	0f 85 15 01 00 00    	jne    801038f0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801037db:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801037e2:	66 85 ff             	test   %di,%di
801037e5:	74 1a                	je     80103801 <mpinit+0xc1>
801037e7:	89 f0                	mov    %esi,%eax
801037e9:	01 f7                	add    %esi,%edi
  sum = 0;
801037eb:	31 d2                	xor    %edx,%edx
801037ed:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801037f0:	0f b6 08             	movzbl (%eax),%ecx
801037f3:	83 c0 01             	add    $0x1,%eax
801037f6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801037f8:	39 c7                	cmp    %eax,%edi
801037fa:	75 f4                	jne    801037f0 <mpinit+0xb0>
801037fc:	84 d2                	test   %dl,%dl
801037fe:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103801:	85 f6                	test   %esi,%esi
80103803:	0f 84 e7 00 00 00    	je     801038f0 <mpinit+0x1b0>
80103809:	84 d2                	test   %dl,%dl
8010380b:	0f 85 df 00 00 00    	jne    801038f0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103811:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103817:	a3 80 c6 14 80       	mov    %eax,0x8014c680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010381c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103823:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103829:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010382e:	01 d6                	add    %edx,%esi
80103830:	39 c6                	cmp    %eax,%esi
80103832:	76 23                	jbe    80103857 <mpinit+0x117>
    switch(*p){
80103834:	0f b6 10             	movzbl (%eax),%edx
80103837:	80 fa 04             	cmp    $0x4,%dl
8010383a:	0f 87 ca 00 00 00    	ja     8010390a <mpinit+0x1ca>
80103840:	ff 24 95 dc 8c 10 80 	jmp    *-0x7fef7324(,%edx,4)
80103847:	89 f6                	mov    %esi,%esi
80103849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103850:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103853:	39 c6                	cmp    %eax,%esi
80103855:	77 dd                	ja     80103834 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103857:	85 db                	test   %ebx,%ebx
80103859:	0f 84 9e 00 00 00    	je     801038fd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010385f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103862:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103866:	74 15                	je     8010387d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103868:	b8 70 00 00 00       	mov    $0x70,%eax
8010386d:	ba 22 00 00 00       	mov    $0x22,%edx
80103872:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103873:	ba 23 00 00 00       	mov    $0x23,%edx
80103878:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103879:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010387c:	ee                   	out    %al,(%dx)
  }
}
8010387d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103880:	5b                   	pop    %ebx
80103881:	5e                   	pop    %esi
80103882:	5f                   	pop    %edi
80103883:	5d                   	pop    %ebp
80103884:	c3                   	ret    
80103885:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103888:	8b 0d 20 cd 14 80    	mov    0x8014cd20,%ecx
8010388e:	83 f9 07             	cmp    $0x7,%ecx
80103891:	7f 19                	jg     801038ac <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103893:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103897:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010389d:	83 c1 01             	add    $0x1,%ecx
801038a0:	89 0d 20 cd 14 80    	mov    %ecx,0x8014cd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038a6:	88 97 a0 c7 14 80    	mov    %dl,-0x7feb3860(%edi)
      p += sizeof(struct mpproc);
801038ac:	83 c0 14             	add    $0x14,%eax
      continue;
801038af:	e9 7c ff ff ff       	jmp    80103830 <mpinit+0xf0>
801038b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801038b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801038bc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801038bf:	88 15 80 c7 14 80    	mov    %dl,0x8014c780
      continue;
801038c5:	e9 66 ff ff ff       	jmp    80103830 <mpinit+0xf0>
801038ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801038d0:	ba 00 00 01 00       	mov    $0x10000,%edx
801038d5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801038da:	e8 e1 fd ff ff       	call   801036c0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038df:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801038e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038e4:	0f 85 a9 fe ff ff    	jne    80103793 <mpinit+0x53>
801038ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801038f0:	83 ec 0c             	sub    $0xc,%esp
801038f3:	68 9d 8c 10 80       	push   $0x80108c9d
801038f8:	e8 93 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801038fd:	83 ec 0c             	sub    $0xc,%esp
80103900:	68 bc 8c 10 80       	push   $0x80108cbc
80103905:	e8 86 ca ff ff       	call   80100390 <panic>
      ismp = 0;
8010390a:	31 db                	xor    %ebx,%ebx
8010390c:	e9 26 ff ff ff       	jmp    80103837 <mpinit+0xf7>
80103911:	66 90                	xchg   %ax,%ax
80103913:	66 90                	xchg   %ax,%ax
80103915:	66 90                	xchg   %ax,%ax
80103917:	66 90                	xchg   %ax,%ax
80103919:	66 90                	xchg   %ax,%ax
8010391b:	66 90                	xchg   %ax,%ax
8010391d:	66 90                	xchg   %ax,%ax
8010391f:	90                   	nop

80103920 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103920:	55                   	push   %ebp
80103921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103926:	ba 21 00 00 00       	mov    $0x21,%edx
8010392b:	89 e5                	mov    %esp,%ebp
8010392d:	ee                   	out    %al,(%dx)
8010392e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103933:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103934:	5d                   	pop    %ebp
80103935:	c3                   	ret    
80103936:	66 90                	xchg   %ax,%ax
80103938:	66 90                	xchg   %ax,%ax
8010393a:	66 90                	xchg   %ax,%ax
8010393c:	66 90                	xchg   %ax,%ax
8010393e:	66 90                	xchg   %ax,%ax

80103940 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	57                   	push   %edi
80103944:	56                   	push   %esi
80103945:	53                   	push   %ebx
80103946:	83 ec 0c             	sub    $0xc,%esp
80103949:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010394c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010394f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103955:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010395b:	e8 80 d5 ff ff       	call   80100ee0 <filealloc>
80103960:	85 c0                	test   %eax,%eax
80103962:	89 03                	mov    %eax,(%ebx)
80103964:	74 22                	je     80103988 <pipealloc+0x48>
80103966:	e8 75 d5 ff ff       	call   80100ee0 <filealloc>
8010396b:	85 c0                	test   %eax,%eax
8010396d:	89 06                	mov    %eax,(%esi)
8010396f:	74 3f                	je     801039b0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103971:	e8 ca f0 ff ff       	call   80102a40 <kalloc>
80103976:	85 c0                	test   %eax,%eax
80103978:	89 c7                	mov    %eax,%edi
8010397a:	75 54                	jne    801039d0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010397c:	8b 03                	mov    (%ebx),%eax
8010397e:	85 c0                	test   %eax,%eax
80103980:	75 34                	jne    801039b6 <pipealloc+0x76>
80103982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103988:	8b 06                	mov    (%esi),%eax
8010398a:	85 c0                	test   %eax,%eax
8010398c:	74 0c                	je     8010399a <pipealloc+0x5a>
    fileclose(*f1);
8010398e:	83 ec 0c             	sub    $0xc,%esp
80103991:	50                   	push   %eax
80103992:	e8 09 d6 ff ff       	call   80100fa0 <fileclose>
80103997:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010399a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010399d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801039a2:	5b                   	pop    %ebx
801039a3:	5e                   	pop    %esi
801039a4:	5f                   	pop    %edi
801039a5:	5d                   	pop    %ebp
801039a6:	c3                   	ret    
801039a7:	89 f6                	mov    %esi,%esi
801039a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801039b0:	8b 03                	mov    (%ebx),%eax
801039b2:	85 c0                	test   %eax,%eax
801039b4:	74 e4                	je     8010399a <pipealloc+0x5a>
    fileclose(*f0);
801039b6:	83 ec 0c             	sub    $0xc,%esp
801039b9:	50                   	push   %eax
801039ba:	e8 e1 d5 ff ff       	call   80100fa0 <fileclose>
  if(*f1)
801039bf:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801039c1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801039c4:	85 c0                	test   %eax,%eax
801039c6:	75 c6                	jne    8010398e <pipealloc+0x4e>
801039c8:	eb d0                	jmp    8010399a <pipealloc+0x5a>
801039ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801039d0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801039d3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801039da:	00 00 00 
  p->writeopen = 1;
801039dd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801039e4:	00 00 00 
  p->nwrite = 0;
801039e7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801039ee:	00 00 00 
  p->nread = 0;
801039f1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801039f8:	00 00 00 
  initlock(&p->lock, "pipe");
801039fb:	68 f0 8c 10 80       	push   $0x80108cf0
80103a00:	50                   	push   %eax
80103a01:	e8 1a 12 00 00       	call   80104c20 <initlock>
  (*f0)->type = FD_PIPE;
80103a06:	8b 03                	mov    (%ebx),%eax
  return 0;
80103a08:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103a0b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103a11:	8b 03                	mov    (%ebx),%eax
80103a13:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103a17:	8b 03                	mov    (%ebx),%eax
80103a19:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103a1d:	8b 03                	mov    (%ebx),%eax
80103a1f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103a22:	8b 06                	mov    (%esi),%eax
80103a24:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103a2a:	8b 06                	mov    (%esi),%eax
80103a2c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103a30:	8b 06                	mov    (%esi),%eax
80103a32:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103a36:	8b 06                	mov    (%esi),%eax
80103a38:	89 78 0c             	mov    %edi,0xc(%eax)
}
80103a3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103a3e:	31 c0                	xor    %eax,%eax
}
80103a40:	5b                   	pop    %ebx
80103a41:	5e                   	pop    %esi
80103a42:	5f                   	pop    %edi
80103a43:	5d                   	pop    %ebp
80103a44:	c3                   	ret    
80103a45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a50 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	56                   	push   %esi
80103a54:	53                   	push   %ebx
80103a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a58:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103a5b:	83 ec 0c             	sub    $0xc,%esp
80103a5e:	53                   	push   %ebx
80103a5f:	e8 fc 12 00 00       	call   80104d60 <acquire>
  if(writable){
80103a64:	83 c4 10             	add    $0x10,%esp
80103a67:	85 f6                	test   %esi,%esi
80103a69:	74 45                	je     80103ab0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a6b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a71:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103a74:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a7b:	00 00 00 
    wakeup(&p->nread);
80103a7e:	50                   	push   %eax
80103a7f:	e8 ac 0d 00 00       	call   80104830 <wakeup>
80103a84:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a87:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a8d:	85 d2                	test   %edx,%edx
80103a8f:	75 0a                	jne    80103a9b <pipeclose+0x4b>
80103a91:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a97:	85 c0                	test   %eax,%eax
80103a99:	74 35                	je     80103ad0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a9b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa1:	5b                   	pop    %ebx
80103aa2:	5e                   	pop    %esi
80103aa3:	5d                   	pop    %ebp
    release(&p->lock);
80103aa4:	e9 77 13 00 00       	jmp    80104e20 <release>
80103aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103ab0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103ab6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103ab9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103ac0:	00 00 00 
    wakeup(&p->nwrite);
80103ac3:	50                   	push   %eax
80103ac4:	e8 67 0d 00 00       	call   80104830 <wakeup>
80103ac9:	83 c4 10             	add    $0x10,%esp
80103acc:	eb b9                	jmp    80103a87 <pipeclose+0x37>
80103ace:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103ad0:	83 ec 0c             	sub    $0xc,%esp
80103ad3:	53                   	push   %ebx
80103ad4:	e8 47 13 00 00       	call   80104e20 <release>
    kfree((char*)p);
80103ad9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103adc:	83 c4 10             	add    $0x10,%esp
}
80103adf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ae2:	5b                   	pop    %ebx
80103ae3:	5e                   	pop    %esi
80103ae4:	5d                   	pop    %ebp
    kfree((char*)p);
80103ae5:	e9 16 ed ff ff       	jmp    80102800 <kfree>
80103aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103af0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	57                   	push   %edi
80103af4:	56                   	push   %esi
80103af5:	53                   	push   %ebx
80103af6:	83 ec 28             	sub    $0x28,%esp
80103af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103afc:	53                   	push   %ebx
80103afd:	e8 5e 12 00 00       	call   80104d60 <acquire>
  for(i = 0; i < n; i++){
80103b02:	8b 45 10             	mov    0x10(%ebp),%eax
80103b05:	83 c4 10             	add    $0x10,%esp
80103b08:	85 c0                	test   %eax,%eax
80103b0a:	0f 8e c9 00 00 00    	jle    80103bd9 <pipewrite+0xe9>
80103b10:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103b13:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103b19:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103b1f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103b22:	03 4d 10             	add    0x10(%ebp),%ecx
80103b25:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b28:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103b2e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103b34:	39 d0                	cmp    %edx,%eax
80103b36:	75 71                	jne    80103ba9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103b38:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b3e:	85 c0                	test   %eax,%eax
80103b40:	74 4e                	je     80103b90 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b42:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103b48:	eb 3a                	jmp    80103b84 <pipewrite+0x94>
80103b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103b50:	83 ec 0c             	sub    $0xc,%esp
80103b53:	57                   	push   %edi
80103b54:	e8 d7 0c 00 00       	call   80104830 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b59:	5a                   	pop    %edx
80103b5a:	59                   	pop    %ecx
80103b5b:	53                   	push   %ebx
80103b5c:	56                   	push   %esi
80103b5d:	e8 0e 0b 00 00       	call   80104670 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b62:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b68:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b6e:	83 c4 10             	add    $0x10,%esp
80103b71:	05 00 02 00 00       	add    $0x200,%eax
80103b76:	39 c2                	cmp    %eax,%edx
80103b78:	75 36                	jne    80103bb0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103b7a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b80:	85 c0                	test   %eax,%eax
80103b82:	74 0c                	je     80103b90 <pipewrite+0xa0>
80103b84:	e8 07 04 00 00       	call   80103f90 <myproc>
80103b89:	8b 40 24             	mov    0x24(%eax),%eax
80103b8c:	85 c0                	test   %eax,%eax
80103b8e:	74 c0                	je     80103b50 <pipewrite+0x60>
        release(&p->lock);
80103b90:	83 ec 0c             	sub    $0xc,%esp
80103b93:	53                   	push   %ebx
80103b94:	e8 87 12 00 00       	call   80104e20 <release>
        return -1;
80103b99:	83 c4 10             	add    $0x10,%esp
80103b9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103ba1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ba4:	5b                   	pop    %ebx
80103ba5:	5e                   	pop    %esi
80103ba6:	5f                   	pop    %edi
80103ba7:	5d                   	pop    %ebp
80103ba8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ba9:	89 c2                	mov    %eax,%edx
80103bab:	90                   	nop
80103bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103bb0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103bb3:	8d 42 01             	lea    0x1(%edx),%eax
80103bb6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103bbc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103bc2:	83 c6 01             	add    $0x1,%esi
80103bc5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103bc9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103bcc:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103bcf:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103bd3:	0f 85 4f ff ff ff    	jne    80103b28 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103bd9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103bdf:	83 ec 0c             	sub    $0xc,%esp
80103be2:	50                   	push   %eax
80103be3:	e8 48 0c 00 00       	call   80104830 <wakeup>
  release(&p->lock);
80103be8:	89 1c 24             	mov    %ebx,(%esp)
80103beb:	e8 30 12 00 00       	call   80104e20 <release>
  return n;
80103bf0:	83 c4 10             	add    $0x10,%esp
80103bf3:	8b 45 10             	mov    0x10(%ebp),%eax
80103bf6:	eb a9                	jmp    80103ba1 <pipewrite+0xb1>
80103bf8:	90                   	nop
80103bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c00 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 18             	sub    $0x18,%esp
80103c09:	8b 75 08             	mov    0x8(%ebp),%esi
80103c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103c0f:	56                   	push   %esi
80103c10:	e8 4b 11 00 00       	call   80104d60 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c15:	83 c4 10             	add    $0x10,%esp
80103c18:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c1e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c24:	75 6a                	jne    80103c90 <piperead+0x90>
80103c26:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103c2c:	85 db                	test   %ebx,%ebx
80103c2e:	0f 84 c4 00 00 00    	je     80103cf8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103c34:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103c3a:	eb 2d                	jmp    80103c69 <piperead+0x69>
80103c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c40:	83 ec 08             	sub    $0x8,%esp
80103c43:	56                   	push   %esi
80103c44:	53                   	push   %ebx
80103c45:	e8 26 0a 00 00       	call   80104670 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c4a:	83 c4 10             	add    $0x10,%esp
80103c4d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c53:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c59:	75 35                	jne    80103c90 <piperead+0x90>
80103c5b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103c61:	85 d2                	test   %edx,%edx
80103c63:	0f 84 8f 00 00 00    	je     80103cf8 <piperead+0xf8>
    if(myproc()->killed){
80103c69:	e8 22 03 00 00       	call   80103f90 <myproc>
80103c6e:	8b 48 24             	mov    0x24(%eax),%ecx
80103c71:	85 c9                	test   %ecx,%ecx
80103c73:	74 cb                	je     80103c40 <piperead+0x40>
      release(&p->lock);
80103c75:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c78:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c7d:	56                   	push   %esi
80103c7e:	e8 9d 11 00 00       	call   80104e20 <release>
      return -1;
80103c83:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103c86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c89:	89 d8                	mov    %ebx,%eax
80103c8b:	5b                   	pop    %ebx
80103c8c:	5e                   	pop    %esi
80103c8d:	5f                   	pop    %edi
80103c8e:	5d                   	pop    %ebp
80103c8f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c90:	8b 45 10             	mov    0x10(%ebp),%eax
80103c93:	85 c0                	test   %eax,%eax
80103c95:	7e 61                	jle    80103cf8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103c97:	31 db                	xor    %ebx,%ebx
80103c99:	eb 13                	jmp    80103cae <piperead+0xae>
80103c9b:	90                   	nop
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ca0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103ca6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103cac:	74 1f                	je     80103ccd <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103cae:	8d 41 01             	lea    0x1(%ecx),%eax
80103cb1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103cb7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103cbd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103cc2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103cc5:	83 c3 01             	add    $0x1,%ebx
80103cc8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103ccb:	75 d3                	jne    80103ca0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103ccd:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103cd3:	83 ec 0c             	sub    $0xc,%esp
80103cd6:	50                   	push   %eax
80103cd7:	e8 54 0b 00 00       	call   80104830 <wakeup>
  release(&p->lock);
80103cdc:	89 34 24             	mov    %esi,(%esp)
80103cdf:	e8 3c 11 00 00       	call   80104e20 <release>
  return i;
80103ce4:	83 c4 10             	add    $0x10,%esp
}
80103ce7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cea:	89 d8                	mov    %ebx,%eax
80103cec:	5b                   	pop    %ebx
80103ced:	5e                   	pop    %esi
80103cee:	5f                   	pop    %edi
80103cef:	5d                   	pop    %ebp
80103cf0:	c3                   	ret    
80103cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cf8:	31 db                	xor    %ebx,%ebx
80103cfa:	eb d1                	jmp    80103ccd <piperead+0xcd>
80103cfc:	66 90                	xchg   %ax,%ax
80103cfe:	66 90                	xchg   %ax,%ax

80103d00 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d04:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80103d09:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103d0c:	68 40 cd 14 80       	push   $0x8014cd40
80103d11:	e8 4a 10 00 00       	call   80104d60 <acquire>
80103d16:	83 c4 10             	add    $0x10,%esp
80103d19:	eb 17                	jmp    80103d32 <allocproc+0x32>
80103d1b:	90                   	nop
80103d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d20:	81 c3 50 03 00 00    	add    $0x350,%ebx
80103d26:	81 fb 74 a1 15 80    	cmp    $0x8015a174,%ebx
80103d2c:	0f 83 26 01 00 00    	jae    80103e58 <allocproc+0x158>
    if(p->state == UNUSED)
80103d32:	8b 43 0c             	mov    0xc(%ebx),%eax
80103d35:	85 c0                	test   %eax,%eax
80103d37:	75 e7                	jne    80103d20 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103d39:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80103d3e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103d41:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103d48:	8d 50 01             	lea    0x1(%eax),%edx
80103d4b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103d4e:	68 40 cd 14 80       	push   $0x8014cd40
  p->pid = nextpid++;
80103d53:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103d59:	e8 c2 10 00 00       	call   80104e20 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d5e:	e8 dd ec ff ff       	call   80102a40 <kalloc>
80103d63:	83 c4 10             	add    $0x10,%esp
80103d66:	85 c0                	test   %eax,%eax
80103d68:	89 43 08             	mov    %eax,0x8(%ebx)
80103d6b:	0f 84 00 01 00 00    	je     80103e71 <allocproc+0x171>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103d71:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103d77:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d7a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d7f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103d82:	c7 40 14 b1 60 10 80 	movl   $0x801060b1,0x14(%eax)
  p->context = (struct context*)sp;
80103d89:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d8c:	6a 14                	push   $0x14
80103d8e:	6a 00                	push   $0x0
80103d90:	50                   	push   %eax
80103d91:	e8 da 10 00 00       	call   80104e70 <memset>
  p->context->eip = (uint)forkret;
80103d96:	8b 43 1c             	mov    0x1c(%ebx),%eax

  p->headPG = -1;
  // Task 1
  if(p->pid>2){
80103d99:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d9c:	c7 40 10 80 3e 10 80 	movl   $0x80103e80,0x10(%eax)
  if(p->pid>2){
80103da3:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  p->headPG = -1;
80103da7:	c7 83 8c 00 00 00 ff 	movl   $0xffffffff,0x8c(%ebx)
80103dae:	ff ff ff 
  if(p->pid>2){
80103db1:	0f 8f 89 00 00 00    	jg     80103e40 <allocproc+0x140>
80103db7:	8d 93 9c 00 00 00    	lea    0x9c(%ebx),%edx
80103dbd:	8d 83 d0 01 00 00    	lea    0x1d0(%ebx),%eax
80103dc3:	8d 8b 50 03 00 00    	lea    0x350(%ebx),%ecx
80103dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  }

  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103dd0:	c7 42 04 ff ff ff ff 	movl   $0xffffffff,0x4(%edx)
    p->swappedPGs[i].changeCounter = 0;
80103dd7:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103ddd:	83 c0 18             	add    $0x18,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103de0:	c7 40 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%eax)
    p->physicalPGs[i].prev = 0;
80103de7:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80103dee:	83 c2 14             	add    $0x14,%edx
    p->physicalPGs[i].next = 0;
80103df1:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
    p->physicalPGs[i].age = 0;
80103df8:	c7 40 f0 00 00 00 00 	movl   $0x0,-0x10(%eax)
    p->physicalPGs[i].alloceted = 0;
80103dff:	c7 40 f4 00 00 00 00 	movl   $0x0,-0xc(%eax)
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103e06:	39 c8                	cmp    %ecx,%eax
80103e08:	75 c6                	jne    80103dd0 <allocproc+0xd0>
  }
  p->allocatedInPhys = 0;
80103e0a:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103e11:	00 00 00 
  p->nPgsSwap = 0;
  p->nPgsPhysical = 0;
  p->headPG = 0;
80103e14:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103e1b:	00 00 00 
  p->nPgsSwap = 0;
80103e1e:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103e25:	00 00 00 
  p->nPgsPhysical = 0;
80103e28:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103e2f:	00 00 00 

  return p;
}
80103e32:	89 d8                	mov    %ebx,%eax
80103e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e37:	c9                   	leave  
80103e38:	c3                   	ret    
80103e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    createSwapFile(p);
80103e40:	83 ec 0c             	sub    $0xc,%esp
80103e43:	53                   	push   %ebx
80103e44:	e8 c7 e4 ff ff       	call   80102310 <createSwapFile>
80103e49:	83 c4 10             	add    $0x10,%esp
80103e4c:	e9 66 ff ff ff       	jmp    80103db7 <allocproc+0xb7>
80103e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103e58:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103e5b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103e5d:	68 40 cd 14 80       	push   $0x8014cd40
80103e62:	e8 b9 0f 00 00       	call   80104e20 <release>
}
80103e67:	89 d8                	mov    %ebx,%eax
  return 0;
80103e69:	83 c4 10             	add    $0x10,%esp
}
80103e6c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e6f:	c9                   	leave  
80103e70:	c3                   	ret    
    p->state = UNUSED;
80103e71:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103e78:	31 db                	xor    %ebx,%ebx
80103e7a:	eb b6                	jmp    80103e32 <allocproc+0x132>
80103e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e80 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103e80:	55                   	push   %ebp
80103e81:	89 e5                	mov    %esp,%ebp
80103e83:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103e86:	68 40 cd 14 80       	push   $0x8014cd40
80103e8b:	e8 90 0f 00 00       	call   80104e20 <release>

  if (first) {
80103e90:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103e95:	83 c4 10             	add    $0x10,%esp
80103e98:	85 c0                	test   %eax,%eax
80103e9a:	75 04                	jne    80103ea0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103e9c:	c9                   	leave  
80103e9d:	c3                   	ret    
80103e9e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103ea0:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103ea3:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103eaa:	00 00 00 
    iinit(ROOTDEV);
80103ead:	6a 01                	push   $0x1
80103eaf:	e8 2c d7 ff ff       	call   801015e0 <iinit>
    initlog(ROOTDEV);
80103eb4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103ebb:	e8 40 f3 ff ff       	call   80103200 <initlog>
80103ec0:	83 c4 10             	add    $0x10,%esp
}
80103ec3:	c9                   	leave  
80103ec4:	c3                   	ret    
80103ec5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ed0 <pinit>:
{
80103ed0:	55                   	push   %ebp
80103ed1:	89 e5                	mov    %esp,%ebp
80103ed3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ed6:	68 f5 8c 10 80       	push   $0x80108cf5
80103edb:	68 40 cd 14 80       	push   $0x8014cd40
80103ee0:	e8 3b 0d 00 00       	call   80104c20 <initlock>
}
80103ee5:	83 c4 10             	add    $0x10,%esp
80103ee8:	c9                   	leave  
80103ee9:	c3                   	ret    
80103eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ef0 <mycpu>:
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	56                   	push   %esi
80103ef4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ef5:	9c                   	pushf  
80103ef6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ef7:	f6 c4 02             	test   $0x2,%ah
80103efa:	75 5e                	jne    80103f5a <mycpu+0x6a>
  apicid = lapicid();
80103efc:	e8 2f ef ff ff       	call   80102e30 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103f01:	8b 35 20 cd 14 80    	mov    0x8014cd20,%esi
80103f07:	85 f6                	test   %esi,%esi
80103f09:	7e 42                	jle    80103f4d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103f0b:	0f b6 15 a0 c7 14 80 	movzbl 0x8014c7a0,%edx
80103f12:	39 d0                	cmp    %edx,%eax
80103f14:	74 30                	je     80103f46 <mycpu+0x56>
80103f16:	b9 50 c8 14 80       	mov    $0x8014c850,%ecx
  for (i = 0; i < ncpu; ++i) {
80103f1b:	31 d2                	xor    %edx,%edx
80103f1d:	8d 76 00             	lea    0x0(%esi),%esi
80103f20:	83 c2 01             	add    $0x1,%edx
80103f23:	39 f2                	cmp    %esi,%edx
80103f25:	74 26                	je     80103f4d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103f27:	0f b6 19             	movzbl (%ecx),%ebx
80103f2a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103f30:	39 c3                	cmp    %eax,%ebx
80103f32:	75 ec                	jne    80103f20 <mycpu+0x30>
80103f34:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103f3a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
}
80103f3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f42:	5b                   	pop    %ebx
80103f43:	5e                   	pop    %esi
80103f44:	5d                   	pop    %ebp
80103f45:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103f46:	b8 a0 c7 14 80       	mov    $0x8014c7a0,%eax
      return &cpus[i];
80103f4b:	eb f2                	jmp    80103f3f <mycpu+0x4f>
  panic("unknown apicid\n");
80103f4d:	83 ec 0c             	sub    $0xc,%esp
80103f50:	68 fc 8c 10 80       	push   $0x80108cfc
80103f55:	e8 36 c4 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f5a:	83 ec 0c             	sub    $0xc,%esp
80103f5d:	68 28 8e 10 80       	push   $0x80108e28
80103f62:	e8 29 c4 ff ff       	call   80100390 <panic>
80103f67:	89 f6                	mov    %esi,%esi
80103f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f70 <cpuid>:
cpuid() {
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103f76:	e8 75 ff ff ff       	call   80103ef0 <mycpu>
80103f7b:	2d a0 c7 14 80       	sub    $0x8014c7a0,%eax
}
80103f80:	c9                   	leave  
  return mycpu()-cpus;
80103f81:	c1 f8 04             	sar    $0x4,%eax
80103f84:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f8a:	c3                   	ret    
80103f8b:	90                   	nop
80103f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f90 <myproc>:
myproc(void) {
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	53                   	push   %ebx
80103f94:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f97:	e8 f4 0c 00 00       	call   80104c90 <pushcli>
  c = mycpu();
80103f9c:	e8 4f ff ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
80103fa1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fa7:	e8 24 0d 00 00       	call   80104cd0 <popcli>
}
80103fac:	83 c4 04             	add    $0x4,%esp
80103faf:	89 d8                	mov    %ebx,%eax
80103fb1:	5b                   	pop    %ebx
80103fb2:	5d                   	pop    %ebp
80103fb3:	c3                   	ret    
80103fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103fc0 <userinit>:
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	53                   	push   %ebx
80103fc4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103fc7:	e8 34 fd ff ff       	call   80103d00 <allocproc>
80103fcc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103fce:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  if((p->pgdir = setupkvm()) == 0)
80103fd3:	e8 d8 37 00 00       	call   801077b0 <setupkvm>
80103fd8:	85 c0                	test   %eax,%eax
80103fda:	89 43 04             	mov    %eax,0x4(%ebx)
80103fdd:	0f 84 da 00 00 00    	je     801040bd <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103fe3:	83 ec 04             	sub    $0x4,%esp
80103fe6:	68 2c 00 00 00       	push   $0x2c
80103feb:	68 60 c4 10 80       	push   $0x8010c460
80103ff0:	50                   	push   %eax
80103ff1:	e8 8a 34 00 00       	call   80107480 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ff6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ff9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103fff:	6a 4c                	push   $0x4c
80104001:	6a 00                	push   $0x0
80104003:	ff 73 18             	pushl  0x18(%ebx)
80104006:	e8 65 0e 00 00       	call   80104e70 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010400b:	8b 43 18             	mov    0x18(%ebx),%eax
8010400e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104013:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104018:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010401b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010401f:	8b 43 18             	mov    0x18(%ebx),%eax
80104022:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104026:	8b 43 18             	mov    0x18(%ebx),%eax
80104029:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010402d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104031:	8b 43 18             	mov    0x18(%ebx),%eax
80104034:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104038:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010403c:	8b 43 18             	mov    0x18(%ebx),%eax
8010403f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104046:	8b 43 18             	mov    0x18(%ebx),%eax
80104049:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104050:	8b 43 18             	mov    0x18(%ebx),%eax
80104053:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010405a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010405d:	6a 10                	push   $0x10
8010405f:	68 25 8d 10 80       	push   $0x80108d25
80104064:	50                   	push   %eax
80104065:	e8 e6 0f 00 00       	call   80105050 <safestrcpy>
  p->cwd = namei("/");
8010406a:	c7 04 24 2e 8d 10 80 	movl   $0x80108d2e,(%esp)
80104071:	e8 ca df ff ff       	call   80102040 <namei>
80104076:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
80104079:	c7 04 24 30 8d 10 80 	movl   $0x80108d30,(%esp)
80104080:	e8 db c5 ff ff       	call   80100660 <cprintf>
80104085:	58                   	pop    %eax
80104086:	5a                   	pop    %edx
80104087:	68 00 e0 00 00       	push   $0xe000
8010408c:	68 38 8d 10 80       	push   $0x80108d38
80104091:	e8 ca c5 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
80104096:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
8010409d:	e8 be 0c 00 00       	call   80104d60 <acquire>
  p->state = RUNNABLE;
801040a2:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801040a9:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801040b0:	e8 6b 0d 00 00       	call   80104e20 <release>
}
801040b5:	83 c4 10             	add    $0x10,%esp
801040b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040bb:	c9                   	leave  
801040bc:	c3                   	ret    
    panic("userinit: out of memory?");
801040bd:	83 ec 0c             	sub    $0xc,%esp
801040c0:	68 0c 8d 10 80       	push   $0x80108d0c
801040c5:	e8 c6 c2 ff ff       	call   80100390 <panic>
801040ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040d0 <growproc>:
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	56                   	push   %esi
801040d4:	53                   	push   %ebx
801040d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801040d8:	e8 b3 0b 00 00       	call   80104c90 <pushcli>
  c = mycpu();
801040dd:	e8 0e fe ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
801040e2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040e8:	e8 e3 0b 00 00       	call   80104cd0 <popcli>
  if(n > 0){
801040ed:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801040f0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801040f2:	7f 1c                	jg     80104110 <growproc+0x40>
  } else if(n < 0){
801040f4:	75 3a                	jne    80104130 <growproc+0x60>
  switchuvm(curproc);
801040f6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801040f9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801040fb:	53                   	push   %ebx
801040fc:	e8 6f 32 00 00       	call   80107370 <switchuvm>
  return 0;
80104101:	83 c4 10             	add    $0x10,%esp
80104104:	31 c0                	xor    %eax,%eax
}
80104106:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104109:	5b                   	pop    %ebx
8010410a:	5e                   	pop    %esi
8010410b:	5d                   	pop    %ebp
8010410c:	c3                   	ret    
8010410d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104110:	83 ec 04             	sub    $0x4,%esp
80104113:	01 c6                	add    %eax,%esi
80104115:	56                   	push   %esi
80104116:	50                   	push   %eax
80104117:	ff 73 04             	pushl  0x4(%ebx)
8010411a:	e8 a1 42 00 00       	call   801083c0 <allocuvm>
8010411f:	83 c4 10             	add    $0x10,%esp
80104122:	85 c0                	test   %eax,%eax
80104124:	75 d0                	jne    801040f6 <growproc+0x26>
      return -1;
80104126:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010412b:	eb d9                	jmp    80104106 <growproc+0x36>
8010412d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104130:	83 ec 04             	sub    $0x4,%esp
80104133:	01 c6                	add    %eax,%esi
80104135:	56                   	push   %esi
80104136:	50                   	push   %eax
80104137:	ff 73 04             	pushl  0x4(%ebx)
8010413a:	e8 81 34 00 00       	call   801075c0 <deallocuvm>
8010413f:	83 c4 10             	add    $0x10,%esp
80104142:	85 c0                	test   %eax,%eax
80104144:	75 b0                	jne    801040f6 <growproc+0x26>
80104146:	eb de                	jmp    80104126 <growproc+0x56>
80104148:	90                   	nop
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104150 <fork>:
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 2c             	sub    $0x2c,%esp
  pushcli();
80104159:	e8 32 0b 00 00       	call   80104c90 <pushcli>
  c = mycpu();
8010415e:	e8 8d fd ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
80104163:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104169:	e8 62 0b 00 00       	call   80104cd0 <popcli>
  if((np = allocproc()) == 0){
8010416e:	e8 8d fb ff ff       	call   80103d00 <allocproc>
80104173:	85 c0                	test   %eax,%eax
80104175:	89 45 dc             	mov    %eax,-0x24(%ebp)
80104178:	0f 84 ad 01 00 00    	je     8010432b <fork+0x1db>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010417e:	83 ec 08             	sub    $0x8,%esp
80104181:	ff 33                	pushl  (%ebx)
80104183:	ff 73 04             	pushl  0x4(%ebx)
80104186:	89 c7                	mov    %eax,%edi
80104188:	e8 f3 36 00 00       	call   80107880 <copyuvm>
8010418d:	83 c4 10             	add    $0x10,%esp
80104190:	85 c0                	test   %eax,%eax
80104192:	89 47 04             	mov    %eax,0x4(%edi)
80104195:	0f 84 99 01 00 00    	je     80104334 <fork+0x1e4>
  np->sz = curproc->sz;
8010419b:	8b 03                	mov    (%ebx),%eax
8010419d:	8b 55 dc             	mov    -0x24(%ebp),%edx
  *np->tf = *curproc->tf;
801041a0:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
801041a5:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
801041a7:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
801041aa:	8b 7a 18             	mov    0x18(%edx),%edi
801041ad:	8b 73 18             	mov    0x18(%ebx),%esi
801041b0:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eax = 0;
801041b2:	89 d7                	mov    %edx,%edi
  for(i = 0; i < NOFILE; i++)
801041b4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801041b6:	8b 42 18             	mov    0x18(%edx),%eax
801041b9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801041c0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801041c4:	85 c0                	test   %eax,%eax
801041c6:	74 10                	je     801041d8 <fork+0x88>
      np->ofile[i] = filedup(curproc->ofile[i]);
801041c8:	83 ec 0c             	sub    $0xc,%esp
801041cb:	50                   	push   %eax
801041cc:	e8 7f cd ff ff       	call   80100f50 <filedup>
801041d1:	83 c4 10             	add    $0x10,%esp
801041d4:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
  for(i = 0; i < NOFILE; i++)
801041d8:	83 c6 01             	add    $0x1,%esi
801041db:	83 fe 10             	cmp    $0x10,%esi
801041de:	75 e0                	jne    801041c0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801041e0:	83 ec 0c             	sub    $0xc,%esp
801041e3:	ff 73 68             	pushl  0x68(%ebx)
801041e6:	e8 c5 d5 ff ff       	call   801017b0 <idup>
801041eb:	8b 7d dc             	mov    -0x24(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801041ee:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801041f1:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801041f4:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041f7:	6a 10                	push   $0x10
801041f9:	50                   	push   %eax
801041fa:	8d 47 6c             	lea    0x6c(%edi),%eax
801041fd:	50                   	push   %eax
801041fe:	e8 4d 0e 00 00       	call   80105050 <safestrcpy>
  if(curproc->pid>2){
80104203:	83 c4 10             	add    $0x10,%esp
80104206:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  pid = np->pid;
8010420a:	8b 47 10             	mov    0x10(%edi),%eax
8010420d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if(curproc->pid>2){
80104210:	0f 8e e4 00 00 00    	jle    801042fa <fork+0x1aa>
    np->headPG = curproc ->headPG;
80104216:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010421c:	8d 97 d0 01 00 00    	lea    0x1d0(%edi),%edx
80104222:	8d 8b d0 01 00 00    	lea    0x1d0(%ebx),%ecx
80104228:	8d b3 90 00 00 00    	lea    0x90(%ebx),%esi
8010422e:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
80104231:	89 87 8c 00 00 00    	mov    %eax,0x8c(%edi)
    np->nPgsPhysical = curproc->nPgsPhysical;
80104237:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
8010423d:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
    np->nPgsSwap = curproc->nPgsSwap;
80104243:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80104249:	89 d3                	mov    %edx,%ebx
8010424b:	89 87 84 00 00 00    	mov    %eax,0x84(%edi)
80104251:	89 f8                	mov    %edi,%eax
80104253:	8d bf 90 00 00 00    	lea    0x90(%edi),%edi
80104259:	05 50 03 00 00       	add    $0x350,%eax
8010425e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80104261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      memmove(&np->physicalPGs[i],&curproc->physicalPGs[i],sizeof(struct procPG));
80104268:	83 ec 04             	sub    $0x4,%esp
8010426b:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010426e:	6a 18                	push   $0x18
80104270:	51                   	push   %ecx
80104271:	53                   	push   %ebx
80104272:	83 c3 18             	add    $0x18,%ebx
80104275:	e8 a6 0c 00 00       	call   80104f20 <memmove>
      memmove(&np->swappedPGs[i],&curproc->swappedPGs[i],sizeof(struct swappedPG));
8010427a:	83 c4 0c             	add    $0xc,%esp
8010427d:	6a 14                	push   $0x14
8010427f:	56                   	push   %esi
80104280:	83 c6 14             	add    $0x14,%esi
80104283:	57                   	push   %edi
80104284:	83 c7 14             	add    $0x14,%edi
80104287:	e8 94 0c 00 00       	call   80104f20 <memmove>
8010428c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      np->physicalPGs[i].alloceted = 0;
8010428f:	c7 43 f4 00 00 00 00 	movl   $0x0,-0xc(%ebx)
    for(int i = 0; i < MAX_PSYC_PAGES ; i++){
80104296:	83 c4 10             	add    $0x10,%esp
80104299:	83 c1 18             	add    $0x18,%ecx
8010429c:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
8010429f:	75 c7                	jne    80104268 <fork+0x118>
801042a1:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    char* newPage = kalloc();
801042a4:	e8 97 e7 ff ff       	call   80102a40 <kalloc>
801042a9:	89 c6                	mov    %eax,%esi
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801042ab:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801042b1:	85 c0                	test   %eax,%eax
801042b3:	7e 45                	jle    801042fa <fork+0x1aa>
801042b5:	31 ff                	xor    %edi,%edi
801042b7:	89 f6                	mov    %esi,%esi
801042b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801042c0:	89 f9                	mov    %edi,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
801042c2:	68 00 10 00 00       	push   $0x1000
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801042c7:	83 c7 01             	add    $0x1,%edi
801042ca:	c1 e1 0c             	shl    $0xc,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
801042cd:	51                   	push   %ecx
801042ce:	56                   	push   %esi
801042cf:	53                   	push   %ebx
801042d0:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801042d3:	e8 08 e1 ff ff       	call   801023e0 <readFromSwapFile>
      writeToSwapFile(np,newPage,i*PGSIZE,PGSIZE);
801042d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801042db:	68 00 10 00 00       	push   $0x1000
801042e0:	51                   	push   %ecx
801042e1:	56                   	push   %esi
801042e2:	ff 75 dc             	pushl  -0x24(%ebp)
801042e5:	e8 c6 e0 ff ff       	call   801023b0 <writeToSwapFile>
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801042ea:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801042f0:	83 c4 20             	add    $0x20,%esp
801042f3:	c1 e0 0c             	shl    $0xc,%eax
801042f6:	39 f8                	cmp    %edi,%eax
801042f8:	7f c6                	jg     801042c0 <fork+0x170>
  acquire(&ptable.lock);
801042fa:	83 ec 0c             	sub    $0xc,%esp
801042fd:	68 40 cd 14 80       	push   $0x8014cd40
80104302:	e8 59 0a 00 00       	call   80104d60 <acquire>
  np->state = RUNNABLE;
80104307:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010430a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
80104311:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104318:	e8 03 0b 00 00       	call   80104e20 <release>
  return pid;
8010431d:	83 c4 10             	add    $0x10,%esp
}
80104320:	8b 45 d8             	mov    -0x28(%ebp),%eax
80104323:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104326:	5b                   	pop    %ebx
80104327:	5e                   	pop    %esi
80104328:	5f                   	pop    %edi
80104329:	5d                   	pop    %ebp
8010432a:	c3                   	ret    
    return -1;
8010432b:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
80104332:	eb ec                	jmp    80104320 <fork+0x1d0>
    kfree(np->kstack);
80104334:	8b 7d dc             	mov    -0x24(%ebp),%edi
80104337:	83 ec 0c             	sub    $0xc,%esp
8010433a:	ff 77 08             	pushl  0x8(%edi)
8010433d:	e8 be e4 ff ff       	call   80102800 <kfree>
    np->kstack = 0;
80104342:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80104349:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80104350:	83 c4 10             	add    $0x10,%esp
80104353:	c7 45 d8 ff ff ff ff 	movl   $0xffffffff,-0x28(%ebp)
8010435a:	eb c4                	jmp    80104320 <fork+0x1d0>
8010435c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104360 <scheduler>:
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	57                   	push   %edi
80104364:	56                   	push   %esi
80104365:	53                   	push   %ebx
80104366:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104369:	e8 82 fb ff ff       	call   80103ef0 <mycpu>
8010436e:	8d 78 04             	lea    0x4(%eax),%edi
80104371:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104373:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010437a:	00 00 00 
8010437d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104380:	fb                   	sti    
    acquire(&ptable.lock);
80104381:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104384:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
    acquire(&ptable.lock);
80104389:	68 40 cd 14 80       	push   $0x8014cd40
8010438e:	e8 cd 09 00 00       	call   80104d60 <acquire>
80104393:	83 c4 10             	add    $0x10,%esp
80104396:	8d 76 00             	lea    0x0(%esi),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
801043a0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801043a4:	75 33                	jne    801043d9 <scheduler+0x79>
      switchuvm(p);
801043a6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801043a9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801043af:	53                   	push   %ebx
801043b0:	e8 bb 2f 00 00       	call   80107370 <switchuvm>
      swtch(&(c->scheduler), p->context);
801043b5:	58                   	pop    %eax
801043b6:	5a                   	pop    %edx
801043b7:	ff 73 1c             	pushl  0x1c(%ebx)
801043ba:	57                   	push   %edi
      p->state = RUNNING;
801043bb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801043c2:	e8 e4 0c 00 00       	call   801050ab <swtch>
      switchkvm();
801043c7:	e8 84 2f 00 00       	call   80107350 <switchkvm>
      c->proc = 0;
801043cc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801043d3:	00 00 00 
801043d6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043d9:	81 c3 50 03 00 00    	add    $0x350,%ebx
801043df:	81 fb 74 a1 15 80    	cmp    $0x8015a174,%ebx
801043e5:	72 b9                	jb     801043a0 <scheduler+0x40>
    release(&ptable.lock);
801043e7:	83 ec 0c             	sub    $0xc,%esp
801043ea:	68 40 cd 14 80       	push   $0x8014cd40
801043ef:	e8 2c 0a 00 00       	call   80104e20 <release>
    sti();
801043f4:	83 c4 10             	add    $0x10,%esp
801043f7:	eb 87                	jmp    80104380 <scheduler+0x20>
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104400 <sched>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	56                   	push   %esi
80104404:	53                   	push   %ebx
  pushcli();
80104405:	e8 86 08 00 00       	call   80104c90 <pushcli>
  c = mycpu();
8010440a:	e8 e1 fa ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
8010440f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104415:	e8 b6 08 00 00       	call   80104cd0 <popcli>
  if(!holding(&ptable.lock))
8010441a:	83 ec 0c             	sub    $0xc,%esp
8010441d:	68 40 cd 14 80       	push   $0x8014cd40
80104422:	e8 09 09 00 00       	call   80104d30 <holding>
80104427:	83 c4 10             	add    $0x10,%esp
8010442a:	85 c0                	test   %eax,%eax
8010442c:	74 4f                	je     8010447d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010442e:	e8 bd fa ff ff       	call   80103ef0 <mycpu>
80104433:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010443a:	75 68                	jne    801044a4 <sched+0xa4>
  if(p->state == RUNNING)
8010443c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104440:	74 55                	je     80104497 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104442:	9c                   	pushf  
80104443:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104444:	f6 c4 02             	test   $0x2,%ah
80104447:	75 41                	jne    8010448a <sched+0x8a>
  intena = mycpu()->intena;
80104449:	e8 a2 fa ff ff       	call   80103ef0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010444e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104451:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104457:	e8 94 fa ff ff       	call   80103ef0 <mycpu>
8010445c:	83 ec 08             	sub    $0x8,%esp
8010445f:	ff 70 04             	pushl  0x4(%eax)
80104462:	53                   	push   %ebx
80104463:	e8 43 0c 00 00       	call   801050ab <swtch>
  mycpu()->intena = intena;
80104468:	e8 83 fa ff ff       	call   80103ef0 <mycpu>
}
8010446d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104470:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104476:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104479:	5b                   	pop    %ebx
8010447a:	5e                   	pop    %esi
8010447b:	5d                   	pop    %ebp
8010447c:	c3                   	ret    
    panic("sched ptable.lock");
8010447d:	83 ec 0c             	sub    $0xc,%esp
80104480:	68 3b 8d 10 80       	push   $0x80108d3b
80104485:	e8 06 bf ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010448a:	83 ec 0c             	sub    $0xc,%esp
8010448d:	68 67 8d 10 80       	push   $0x80108d67
80104492:	e8 f9 be ff ff       	call   80100390 <panic>
    panic("sched running");
80104497:	83 ec 0c             	sub    $0xc,%esp
8010449a:	68 59 8d 10 80       	push   $0x80108d59
8010449f:	e8 ec be ff ff       	call   80100390 <panic>
    panic("sched locks");
801044a4:	83 ec 0c             	sub    $0xc,%esp
801044a7:	68 4d 8d 10 80       	push   $0x80108d4d
801044ac:	e8 df be ff ff       	call   80100390 <panic>
801044b1:	eb 0d                	jmp    801044c0 <exit>
801044b3:	90                   	nop
801044b4:	90                   	nop
801044b5:	90                   	nop
801044b6:	90                   	nop
801044b7:	90                   	nop
801044b8:	90                   	nop
801044b9:	90                   	nop
801044ba:	90                   	nop
801044bb:	90                   	nop
801044bc:	90                   	nop
801044bd:	90                   	nop
801044be:	90                   	nop
801044bf:	90                   	nop

801044c0 <exit>:
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	56                   	push   %esi
801044c5:	53                   	push   %ebx
801044c6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801044c9:	e8 c2 07 00 00       	call   80104c90 <pushcli>
  c = mycpu();
801044ce:	e8 1d fa ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
801044d3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044d9:	e8 f2 07 00 00       	call   80104cd0 <popcli>
  if(curproc == initproc)
801044de:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
801044e4:	8d 5e 28             	lea    0x28(%esi),%ebx
801044e7:	8d 7e 68             	lea    0x68(%esi),%edi
801044ea:	0f 84 1e 01 00 00    	je     8010460e <exit+0x14e>
    if(curproc->ofile[fd]){
801044f0:	8b 03                	mov    (%ebx),%eax
801044f2:	85 c0                	test   %eax,%eax
801044f4:	74 12                	je     80104508 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801044f6:	83 ec 0c             	sub    $0xc,%esp
801044f9:	50                   	push   %eax
801044fa:	e8 a1 ca ff ff       	call   80100fa0 <fileclose>
      curproc->ofile[fd] = 0;
801044ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104505:	83 c4 10             	add    $0x10,%esp
80104508:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
8010450b:	39 fb                	cmp    %edi,%ebx
8010450d:	75 e1                	jne    801044f0 <exit+0x30>
  if(removeSwapFile(curproc) != 0){
8010450f:	83 ec 0c             	sub    $0xc,%esp
80104512:	56                   	push   %esi
80104513:	e8 f8 db ff ff       	call   80102110 <removeSwapFile>
80104518:	83 c4 10             	add    $0x10,%esp
8010451b:	85 c0                	test   %eax,%eax
8010451d:	0f 85 c5 00 00 00    	jne    801045e8 <exit+0x128>
  begin_op();
80104523:	e8 78 ed ff ff       	call   801032a0 <begin_op>
  iput(curproc->cwd);
80104528:	83 ec 0c             	sub    $0xc,%esp
8010452b:	ff 76 68             	pushl  0x68(%esi)
8010452e:	e8 dd d3 ff ff       	call   80101910 <iput>
  end_op();
80104533:	e8 d8 ed ff ff       	call   80103310 <end_op>
  curproc->cwd = 0;
80104538:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010453f:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104546:	e8 15 08 00 00       	call   80104d60 <acquire>
  wakeup1(curproc->parent);
8010454b:	8b 56 14             	mov    0x14(%esi),%edx
8010454e:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104551:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104556:	eb 14                	jmp    8010456c <exit+0xac>
80104558:	90                   	nop
80104559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104560:	05 50 03 00 00       	add    $0x350,%eax
80104565:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
8010456a:	73 1e                	jae    8010458a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010456c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104570:	75 ee                	jne    80104560 <exit+0xa0>
80104572:	3b 50 20             	cmp    0x20(%eax),%edx
80104575:	75 e9                	jne    80104560 <exit+0xa0>
      p->state = RUNNABLE;
80104577:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010457e:	05 50 03 00 00       	add    $0x350,%eax
80104583:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
80104588:	72 e2                	jb     8010456c <exit+0xac>
      p->parent = initproc;
8010458a:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104590:	ba 74 cd 14 80       	mov    $0x8014cd74,%edx
80104595:	eb 17                	jmp    801045ae <exit+0xee>
80104597:	89 f6                	mov    %esi,%esi
80104599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801045a0:	81 c2 50 03 00 00    	add    $0x350,%edx
801045a6:	81 fa 74 a1 15 80    	cmp    $0x8015a174,%edx
801045ac:	73 47                	jae    801045f5 <exit+0x135>
    if(p->parent == curproc){
801045ae:	39 72 14             	cmp    %esi,0x14(%edx)
801045b1:	75 ed                	jne    801045a0 <exit+0xe0>
      if(p->state == ZOMBIE)
801045b3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801045b7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801045ba:	75 e4                	jne    801045a0 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045bc:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801045c1:	eb 11                	jmp    801045d4 <exit+0x114>
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045c8:	05 50 03 00 00       	add    $0x350,%eax
801045cd:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
801045d2:	73 cc                	jae    801045a0 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
801045d4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045d8:	75 ee                	jne    801045c8 <exit+0x108>
801045da:	3b 48 20             	cmp    0x20(%eax),%ecx
801045dd:	75 e9                	jne    801045c8 <exit+0x108>
      p->state = RUNNABLE;
801045df:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801045e6:	eb e0                	jmp    801045c8 <exit+0x108>
    panic("exit: cant remove swapfile");
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	68 88 8d 10 80       	push   $0x80108d88
801045f0:	e8 9b bd ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
801045f5:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801045fc:	e8 ff fd ff ff       	call   80104400 <sched>
  panic("zombie exit");
80104601:	83 ec 0c             	sub    $0xc,%esp
80104604:	68 a3 8d 10 80       	push   $0x80108da3
80104609:	e8 82 bd ff ff       	call   80100390 <panic>
    panic("init exiting");
8010460e:	83 ec 0c             	sub    $0xc,%esp
80104611:	68 7b 8d 10 80       	push   $0x80108d7b
80104616:	e8 75 bd ff ff       	call   80100390 <panic>
8010461b:	90                   	nop
8010461c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104620 <yield>:
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
80104623:	53                   	push   %ebx
80104624:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104627:	68 40 cd 14 80       	push   $0x8014cd40
8010462c:	e8 2f 07 00 00       	call   80104d60 <acquire>
  pushcli();
80104631:	e8 5a 06 00 00       	call   80104c90 <pushcli>
  c = mycpu();
80104636:	e8 b5 f8 ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
8010463b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104641:	e8 8a 06 00 00       	call   80104cd0 <popcli>
  myproc()->state = RUNNABLE;
80104646:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010464d:	e8 ae fd ff ff       	call   80104400 <sched>
  release(&ptable.lock);
80104652:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104659:	e8 c2 07 00 00       	call   80104e20 <release>
}
8010465e:	83 c4 10             	add    $0x10,%esp
80104661:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104664:	c9                   	leave  
80104665:	c3                   	ret    
80104666:	8d 76 00             	lea    0x0(%esi),%esi
80104669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104670 <sleep>:
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	57                   	push   %edi
80104674:	56                   	push   %esi
80104675:	53                   	push   %ebx
80104676:	83 ec 0c             	sub    $0xc,%esp
80104679:	8b 7d 08             	mov    0x8(%ebp),%edi
8010467c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010467f:	e8 0c 06 00 00       	call   80104c90 <pushcli>
  c = mycpu();
80104684:	e8 67 f8 ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
80104689:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010468f:	e8 3c 06 00 00       	call   80104cd0 <popcli>
  if(p == 0)
80104694:	85 db                	test   %ebx,%ebx
80104696:	0f 84 87 00 00 00    	je     80104723 <sleep+0xb3>
  if(lk == 0)
8010469c:	85 f6                	test   %esi,%esi
8010469e:	74 76                	je     80104716 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801046a0:	81 fe 40 cd 14 80    	cmp    $0x8014cd40,%esi
801046a6:	74 50                	je     801046f8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801046a8:	83 ec 0c             	sub    $0xc,%esp
801046ab:	68 40 cd 14 80       	push   $0x8014cd40
801046b0:	e8 ab 06 00 00       	call   80104d60 <acquire>
    release(lk);
801046b5:	89 34 24             	mov    %esi,(%esp)
801046b8:	e8 63 07 00 00       	call   80104e20 <release>
  p->chan = chan;
801046bd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801046c0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801046c7:	e8 34 fd ff ff       	call   80104400 <sched>
  p->chan = 0;
801046cc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801046d3:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801046da:	e8 41 07 00 00       	call   80104e20 <release>
    acquire(lk);
801046df:	89 75 08             	mov    %esi,0x8(%ebp)
801046e2:	83 c4 10             	add    $0x10,%esp
}
801046e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046e8:	5b                   	pop    %ebx
801046e9:	5e                   	pop    %esi
801046ea:	5f                   	pop    %edi
801046eb:	5d                   	pop    %ebp
    acquire(lk);
801046ec:	e9 6f 06 00 00       	jmp    80104d60 <acquire>
801046f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801046f8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801046fb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104702:	e8 f9 fc ff ff       	call   80104400 <sched>
  p->chan = 0;
80104707:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010470e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104711:	5b                   	pop    %ebx
80104712:	5e                   	pop    %esi
80104713:	5f                   	pop    %edi
80104714:	5d                   	pop    %ebp
80104715:	c3                   	ret    
    panic("sleep without lk");
80104716:	83 ec 0c             	sub    $0xc,%esp
80104719:	68 b5 8d 10 80       	push   $0x80108db5
8010471e:	e8 6d bc ff ff       	call   80100390 <panic>
    panic("sleep");
80104723:	83 ec 0c             	sub    $0xc,%esp
80104726:	68 af 8d 10 80       	push   $0x80108daf
8010472b:	e8 60 bc ff ff       	call   80100390 <panic>

80104730 <wait>:
{
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
  pushcli();
80104735:	e8 56 05 00 00       	call   80104c90 <pushcli>
  c = mycpu();
8010473a:	e8 b1 f7 ff ff       	call   80103ef0 <mycpu>
  p = c->proc;
8010473f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104745:	e8 86 05 00 00       	call   80104cd0 <popcli>
  acquire(&ptable.lock);
8010474a:	83 ec 0c             	sub    $0xc,%esp
8010474d:	68 40 cd 14 80       	push   $0x8014cd40
80104752:	e8 09 06 00 00       	call   80104d60 <acquire>
80104757:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010475a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010475c:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
80104761:	eb 13                	jmp    80104776 <wait+0x46>
80104763:	90                   	nop
80104764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104768:	81 c3 50 03 00 00    	add    $0x350,%ebx
8010476e:	81 fb 74 a1 15 80    	cmp    $0x8015a174,%ebx
80104774:	73 1e                	jae    80104794 <wait+0x64>
      if(p->parent != curproc)
80104776:	39 73 14             	cmp    %esi,0x14(%ebx)
80104779:	75 ed                	jne    80104768 <wait+0x38>
      if(p->state == ZOMBIE){
8010477b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010477f:	74 37                	je     801047b8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104781:	81 c3 50 03 00 00    	add    $0x350,%ebx
      havekids = 1;
80104787:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010478c:	81 fb 74 a1 15 80    	cmp    $0x8015a174,%ebx
80104792:	72 e2                	jb     80104776 <wait+0x46>
    if(!havekids || curproc->killed){
80104794:	85 c0                	test   %eax,%eax
80104796:	74 7d                	je     80104815 <wait+0xe5>
80104798:	8b 46 24             	mov    0x24(%esi),%eax
8010479b:	85 c0                	test   %eax,%eax
8010479d:	75 76                	jne    80104815 <wait+0xe5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010479f:	83 ec 08             	sub    $0x8,%esp
801047a2:	68 40 cd 14 80       	push   $0x8014cd40
801047a7:	56                   	push   %esi
801047a8:	e8 c3 fe ff ff       	call   80104670 <sleep>
    havekids = 0;
801047ad:	83 c4 10             	add    $0x10,%esp
801047b0:	eb a8                	jmp    8010475a <wait+0x2a>
801047b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801047b8:	83 ec 0c             	sub    $0xc,%esp
801047bb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801047be:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801047c1:	e8 3a e0 ff ff       	call   80102800 <kfree>
        freevm(p->pgdir);
801047c6:	5a                   	pop    %edx
801047c7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801047ca:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801047d1:	e8 5a 2f 00 00       	call   80107730 <freevm>
        release(&ptable.lock);
801047d6:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
        p->pid = 0;
801047dd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801047e4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801047eb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801047ef:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->pgdir = 0;
801047f6:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        p->state = UNUSED;
801047fd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104804:	e8 17 06 00 00       	call   80104e20 <release>
        return pid;
80104809:	83 c4 10             	add    $0x10,%esp
}
8010480c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010480f:	89 f0                	mov    %esi,%eax
80104811:	5b                   	pop    %ebx
80104812:	5e                   	pop    %esi
80104813:	5d                   	pop    %ebp
80104814:	c3                   	ret    
      release(&ptable.lock);
80104815:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104818:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010481d:	68 40 cd 14 80       	push   $0x8014cd40
80104822:	e8 f9 05 00 00       	call   80104e20 <release>
      return -1;
80104827:	83 c4 10             	add    $0x10,%esp
8010482a:	eb e0                	jmp    8010480c <wait+0xdc>
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104830 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	53                   	push   %ebx
80104834:	83 ec 10             	sub    $0x10,%esp
80104837:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010483a:	68 40 cd 14 80       	push   $0x8014cd40
8010483f:	e8 1c 05 00 00       	call   80104d60 <acquire>
80104844:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104847:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
8010484c:	eb 0e                	jmp    8010485c <wakeup+0x2c>
8010484e:	66 90                	xchg   %ax,%ax
80104850:	05 50 03 00 00       	add    $0x350,%eax
80104855:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
8010485a:	73 1e                	jae    8010487a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010485c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104860:	75 ee                	jne    80104850 <wakeup+0x20>
80104862:	3b 58 20             	cmp    0x20(%eax),%ebx
80104865:	75 e9                	jne    80104850 <wakeup+0x20>
      p->state = RUNNABLE;
80104867:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010486e:	05 50 03 00 00       	add    $0x350,%eax
80104873:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
80104878:	72 e2                	jb     8010485c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010487a:	c7 45 08 40 cd 14 80 	movl   $0x8014cd40,0x8(%ebp)
}
80104881:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104884:	c9                   	leave  
  release(&ptable.lock);
80104885:	e9 96 05 00 00       	jmp    80104e20 <release>
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104890 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104890:	55                   	push   %ebp
80104891:	89 e5                	mov    %esp,%ebp
80104893:	53                   	push   %ebx
80104894:	83 ec 10             	sub    $0x10,%esp
80104897:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010489a:	68 40 cd 14 80       	push   $0x8014cd40
8010489f:	e8 bc 04 00 00       	call   80104d60 <acquire>
801048a4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048a7:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801048ac:	eb 0e                	jmp    801048bc <kill+0x2c>
801048ae:	66 90                	xchg   %ax,%ax
801048b0:	05 50 03 00 00       	add    $0x350,%eax
801048b5:	3d 74 a1 15 80       	cmp    $0x8015a174,%eax
801048ba:	73 34                	jae    801048f0 <kill+0x60>
    if(p->pid == pid){
801048bc:	39 58 10             	cmp    %ebx,0x10(%eax)
801048bf:	75 ef                	jne    801048b0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801048c1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801048c5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801048cc:	75 07                	jne    801048d5 <kill+0x45>
        p->state = RUNNABLE;
801048ce:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801048d5:	83 ec 0c             	sub    $0xc,%esp
801048d8:	68 40 cd 14 80       	push   $0x8014cd40
801048dd:	e8 3e 05 00 00       	call   80104e20 <release>
      return 0;
801048e2:	83 c4 10             	add    $0x10,%esp
801048e5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801048e7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048ea:	c9                   	leave  
801048eb:	c3                   	ret    
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801048f0:	83 ec 0c             	sub    $0xc,%esp
801048f3:	68 40 cd 14 80       	push   $0x8014cd40
801048f8:	e8 23 05 00 00       	call   80104e20 <release>
  return -1;
801048fd:	83 c4 10             	add    $0x10,%esp
80104900:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104905:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104908:	c9                   	leave  
80104909:	c3                   	ret    
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104910 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	56                   	push   %esi
80104915:	53                   	push   %ebx
80104916:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104919:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
8010491e:	83 ec 3c             	sub    $0x3c,%esp
80104921:	eb 27                	jmp    8010494a <procdump+0x3a>
80104923:	90                   	nop
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104928:	83 ec 0c             	sub    $0xc,%esp
8010492b:	68 d6 92 10 80       	push   $0x801092d6
80104930:	e8 2b bd ff ff       	call   80100660 <cprintf>
80104935:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104938:	81 c3 50 03 00 00    	add    $0x350,%ebx
8010493e:	81 fb 74 a1 15 80    	cmp    $0x8015a174,%ebx
80104944:	0f 83 96 00 00 00    	jae    801049e0 <procdump+0xd0>
    if(p->state == UNUSED)
8010494a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010494d:	85 c0                	test   %eax,%eax
8010494f:	74 e7                	je     80104938 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104951:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104954:	ba c6 8d 10 80       	mov    $0x80108dc6,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104959:	77 11                	ja     8010496c <procdump+0x5c>
8010495b:	8b 14 85 80 8e 10 80 	mov    -0x7fef7180(,%eax,4),%edx
      state = "???";
80104962:	b8 c6 8d 10 80       	mov    $0x80108dc6,%eax
80104967:	85 d2                	test   %edx,%edx
80104969:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d allocated: %d   inPhysical: %d         %s %s", p->pid, p->allocatedInPhys, p->nPgsPhysical, state, p->name);
8010496c:	8b 8b 80 00 00 00    	mov    0x80(%ebx),%ecx
80104972:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80104978:	8d 7b 6c             	lea    0x6c(%ebx),%edi
8010497b:	83 ec 08             	sub    $0x8,%esp
8010497e:	57                   	push   %edi
8010497f:	52                   	push   %edx
80104980:	51                   	push   %ecx
80104981:	50                   	push   %eax
80104982:	ff 73 10             	pushl  0x10(%ebx)
80104985:	68 50 8e 10 80       	push   $0x80108e50
8010498a:	e8 d1 bc ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
8010498f:	83 c4 20             	add    $0x20,%esp
80104992:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104996:	75 90                	jne    80104928 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104998:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010499b:	83 ec 08             	sub    $0x8,%esp
8010499e:	8d 7d c0             	lea    -0x40(%ebp),%edi
801049a1:	50                   	push   %eax
801049a2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801049a5:	8b 40 0c             	mov    0xc(%eax),%eax
801049a8:	83 c0 08             	add    $0x8,%eax
801049ab:	50                   	push   %eax
801049ac:	e8 8f 02 00 00       	call   80104c40 <getcallerpcs>
801049b1:	83 c4 10             	add    $0x10,%esp
801049b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801049b8:	8b 07                	mov    (%edi),%eax
801049ba:	85 c0                	test   %eax,%eax
801049bc:	0f 84 66 ff ff ff    	je     80104928 <procdump+0x18>
        cprintf(" %p", pc[i]);
801049c2:	83 ec 08             	sub    $0x8,%esp
801049c5:	83 c7 04             	add    $0x4,%edi
801049c8:	50                   	push   %eax
801049c9:	68 61 87 10 80       	push   $0x80108761
801049ce:	e8 8d bc ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801049d3:	83 c4 10             	add    $0x10,%esp
801049d6:	39 fe                	cmp    %edi,%esi
801049d8:	75 de                	jne    801049b8 <procdump+0xa8>
801049da:	e9 49 ff ff ff       	jmp    80104928 <procdump+0x18>
801049df:	90                   	nop
  }
}
801049e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049e3:	5b                   	pop    %ebx
801049e4:	5e                   	pop    %esi
801049e5:	5f                   	pop    %edi
801049e6:	5d                   	pop    %ebp
801049e7:	c3                   	ret    
801049e8:	90                   	nop
801049e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049f0 <nfuaTickUpdate>:

//update aging mechanisem of nfua algo each tick form trap.c
void
nfuaTickUpdate(){
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	56                   	push   %esi
801049f5:	53                   	push   %ebx
  struct proc *p;
  pte_t *pte,*pde,*pgtab;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049f6:	be 74 cd 14 80       	mov    $0x8014cd74,%esi
nfuaTickUpdate(){
801049fb:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
801049fe:	68 40 cd 14 80       	push   $0x8014cd40
80104a03:	e8 58 03 00 00       	call   80104d60 <acquire>
80104a08:	83 c4 10             	add    $0x10,%esp
80104a0b:	90                   	nop
80104a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid<=2)
80104a10:	83 7e 10 02          	cmpl   $0x2,0x10(%esi)
80104a14:	0f 8e 86 00 00 00    	jle    80104aa0 <nfuaTickUpdate+0xb0>
      continue;
    if(!((p->state == RUNNING) || (p->state == RUNNABLE) || (p->state == SLEEPING)))
80104a1a:	8b 46 0c             	mov    0xc(%esi),%eax
80104a1d:	83 e8 02             	sub    $0x2,%eax
80104a20:	83 f8 02             	cmp    $0x2,%eax
80104a23:	77 7b                	ja     80104aa0 <nfuaTickUpdate+0xb0>
80104a25:	8d 9e d8 01 00 00    	lea    0x1d8(%esi),%ebx
80104a2b:	8d be 58 03 00 00    	lea    0x358(%esi),%edi
80104a31:	eb 37                	jmp    80104a6a <nfuaTickUpdate+0x7a>
80104a33:	90                   	nop
80104a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        continue;
      
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
      if(*pde & PTE_P){
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104a38:	c1 e8 0a             	shr    $0xa,%eax
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80104a3b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104a41:	25 fc 0f 00 00       	and    $0xffc,%eax
80104a46:	8d 94 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edx
      } else {
        cprintf("nfuaUpdate: pte is not PTE_P\n");
        continue;
      }
      if(!pte){
80104a4d:	85 d2                	test   %edx,%edx
80104a4f:	74 7f                	je     80104ad0 <nfuaTickUpdate+0xe0>
        cprintf("nfuaUpdate : !pte\n");
        continue;
      }

      p->physicalPGs[i].age = ((p->physicalPGs[i].age) >> 1); // shift right
80104a51:	8b 03                	mov    (%ebx),%eax
80104a53:	d1 e8                	shr    %eax
80104a55:	89 03                	mov    %eax,(%ebx)
      //cprintf("shifted: %x\n",p->physicalPGs[i].age);

      if(*pte & PTE_A){                                       // set MSB if accessed
80104a57:	f6 02 20             	testb  $0x20,(%edx)
80104a5a:	74 07                	je     80104a63 <nfuaTickUpdate+0x73>
        uint newBit = 1 << ((sizeof(uint)*8) - 1);
        p->physicalPGs[i].age |= newBit;
80104a5c:	0d 00 00 00 80       	or     $0x80000000,%eax
80104a61:	89 03                	mov    %eax,(%ebx)
80104a63:	83 c3 18             	add    $0x18,%ebx
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104a66:	39 df                	cmp    %ebx,%edi
80104a68:	74 36                	je     80104aa0 <nfuaTickUpdate+0xb0>
      if(p->physicalPGs[i].va == (char*)0xffffffff)
80104a6a:	8b 43 f8             	mov    -0x8(%ebx),%eax
80104a6d:	83 f8 ff             	cmp    $0xffffffff,%eax
80104a70:	74 f1                	je     80104a63 <nfuaTickUpdate+0x73>
      if(*pde & PTE_P){
80104a72:	8b 56 04             	mov    0x4(%esi),%edx
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
80104a75:	89 c1                	mov    %eax,%ecx
80104a77:	c1 e9 16             	shr    $0x16,%ecx
      if(*pde & PTE_P){
80104a7a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80104a7d:	f6 c2 01             	test   $0x1,%dl
80104a80:	75 b6                	jne    80104a38 <nfuaTickUpdate+0x48>
        cprintf("nfuaUpdate: pte is not PTE_P\n");
80104a82:	83 ec 0c             	sub    $0xc,%esp
80104a85:	83 c3 18             	add    $0x18,%ebx
80104a88:	68 ca 8d 10 80       	push   $0x80108dca
80104a8d:	e8 ce bb ff ff       	call   80100660 <cprintf>
        continue;
80104a92:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104a95:	39 df                	cmp    %ebx,%edi
80104a97:	75 d1                	jne    80104a6a <nfuaTickUpdate+0x7a>
80104a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa0:	81 c6 50 03 00 00    	add    $0x350,%esi
80104aa6:	81 fe 74 a1 15 80    	cmp    $0x8015a174,%esi
80104aac:	0f 82 5e ff ff ff    	jb     80104a10 <nfuaTickUpdate+0x20>
      }
    }
  }
  release(&ptable.lock);
80104ab2:	83 ec 0c             	sub    $0xc,%esp
80104ab5:	68 40 cd 14 80       	push   $0x8014cd40
80104aba:	e8 61 03 00 00       	call   80104e20 <release>
80104abf:	83 c4 10             	add    $0x10,%esp
80104ac2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ac5:	5b                   	pop    %ebx
80104ac6:	5e                   	pop    %esi
80104ac7:	5f                   	pop    %edi
80104ac8:	5d                   	pop    %ebp
80104ac9:	c3                   	ret    
80104aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate : !pte\n");
80104ad0:	83 ec 0c             	sub    $0xc,%esp
80104ad3:	68 e8 8d 10 80       	push   $0x80108de8
80104ad8:	e8 83 bb ff ff       	call   80100660 <cprintf>
        continue;
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	eb 81                	jmp    80104a63 <nfuaTickUpdate+0x73>
80104ae2:	66 90                	xchg   %ax,%ax
80104ae4:	66 90                	xchg   %ax,%ax
80104ae6:	66 90                	xchg   %ax,%ax
80104ae8:	66 90                	xchg   %ax,%ax
80104aea:	66 90                	xchg   %ax,%ax
80104aec:	66 90                	xchg   %ax,%ax
80104aee:	66 90                	xchg   %ax,%ax

80104af0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	53                   	push   %ebx
80104af4:	83 ec 0c             	sub    $0xc,%esp
80104af7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104afa:	68 98 8e 10 80       	push   $0x80108e98
80104aff:	8d 43 04             	lea    0x4(%ebx),%eax
80104b02:	50                   	push   %eax
80104b03:	e8 18 01 00 00       	call   80104c20 <initlock>
  lk->name = name;
80104b08:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104b0b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104b11:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104b14:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104b1b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104b1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b21:	c9                   	leave  
80104b22:	c3                   	ret    
80104b23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b30 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
80104b35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104b38:	83 ec 0c             	sub    $0xc,%esp
80104b3b:	8d 73 04             	lea    0x4(%ebx),%esi
80104b3e:	56                   	push   %esi
80104b3f:	e8 1c 02 00 00       	call   80104d60 <acquire>
  while (lk->locked) {
80104b44:	8b 13                	mov    (%ebx),%edx
80104b46:	83 c4 10             	add    $0x10,%esp
80104b49:	85 d2                	test   %edx,%edx
80104b4b:	74 16                	je     80104b63 <acquiresleep+0x33>
80104b4d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104b50:	83 ec 08             	sub    $0x8,%esp
80104b53:	56                   	push   %esi
80104b54:	53                   	push   %ebx
80104b55:	e8 16 fb ff ff       	call   80104670 <sleep>
  while (lk->locked) {
80104b5a:	8b 03                	mov    (%ebx),%eax
80104b5c:	83 c4 10             	add    $0x10,%esp
80104b5f:	85 c0                	test   %eax,%eax
80104b61:	75 ed                	jne    80104b50 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104b63:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104b69:	e8 22 f4 ff ff       	call   80103f90 <myproc>
80104b6e:	8b 40 10             	mov    0x10(%eax),%eax
80104b71:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104b74:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104b77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b7a:	5b                   	pop    %ebx
80104b7b:	5e                   	pop    %esi
80104b7c:	5d                   	pop    %ebp
  release(&lk->lk);
80104b7d:	e9 9e 02 00 00       	jmp    80104e20 <release>
80104b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b90 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	56                   	push   %esi
80104b94:	53                   	push   %ebx
80104b95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104b98:	83 ec 0c             	sub    $0xc,%esp
80104b9b:	8d 73 04             	lea    0x4(%ebx),%esi
80104b9e:	56                   	push   %esi
80104b9f:	e8 bc 01 00 00       	call   80104d60 <acquire>
  lk->locked = 0;
80104ba4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104baa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104bb1:	89 1c 24             	mov    %ebx,(%esp)
80104bb4:	e8 77 fc ff ff       	call   80104830 <wakeup>
  release(&lk->lk);
80104bb9:	89 75 08             	mov    %esi,0x8(%ebp)
80104bbc:	83 c4 10             	add    $0x10,%esp
}
80104bbf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bc2:	5b                   	pop    %ebx
80104bc3:	5e                   	pop    %esi
80104bc4:	5d                   	pop    %ebp
  release(&lk->lk);
80104bc5:	e9 56 02 00 00       	jmp    80104e20 <release>
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bd0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	57                   	push   %edi
80104bd4:	56                   	push   %esi
80104bd5:	53                   	push   %ebx
80104bd6:	31 ff                	xor    %edi,%edi
80104bd8:	83 ec 18             	sub    $0x18,%esp
80104bdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104bde:	8d 73 04             	lea    0x4(%ebx),%esi
80104be1:	56                   	push   %esi
80104be2:	e8 79 01 00 00       	call   80104d60 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104be7:	8b 03                	mov    (%ebx),%eax
80104be9:	83 c4 10             	add    $0x10,%esp
80104bec:	85 c0                	test   %eax,%eax
80104bee:	74 13                	je     80104c03 <holdingsleep+0x33>
80104bf0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104bf3:	e8 98 f3 ff ff       	call   80103f90 <myproc>
80104bf8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104bfb:	0f 94 c0             	sete   %al
80104bfe:	0f b6 c0             	movzbl %al,%eax
80104c01:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104c03:	83 ec 0c             	sub    $0xc,%esp
80104c06:	56                   	push   %esi
80104c07:	e8 14 02 00 00       	call   80104e20 <release>
  return r;
}
80104c0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c0f:	89 f8                	mov    %edi,%eax
80104c11:	5b                   	pop    %ebx
80104c12:	5e                   	pop    %esi
80104c13:	5f                   	pop    %edi
80104c14:	5d                   	pop    %ebp
80104c15:	c3                   	ret    
80104c16:	66 90                	xchg   %ax,%ax
80104c18:	66 90                	xchg   %ax,%ax
80104c1a:	66 90                	xchg   %ax,%ax
80104c1c:	66 90                	xchg   %ax,%ax
80104c1e:	66 90                	xchg   %ax,%ax

80104c20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104c26:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104c29:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104c2f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104c32:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104c39:	5d                   	pop    %ebp
80104c3a:	c3                   	ret    
80104c3b:	90                   	nop
80104c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104c40:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104c41:	31 d2                	xor    %edx,%edx
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104c46:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104c49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104c4c:	83 e8 08             	sub    $0x8,%eax
80104c4f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c50:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104c56:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104c5c:	77 1a                	ja     80104c78 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104c5e:	8b 58 04             	mov    0x4(%eax),%ebx
80104c61:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104c64:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104c67:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104c69:	83 fa 0a             	cmp    $0xa,%edx
80104c6c:	75 e2                	jne    80104c50 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104c6e:	5b                   	pop    %ebx
80104c6f:	5d                   	pop    %ebp
80104c70:	c3                   	ret    
80104c71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c78:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104c7b:	83 c1 28             	add    $0x28,%ecx
80104c7e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104c80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c86:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104c89:	39 c1                	cmp    %eax,%ecx
80104c8b:	75 f3                	jne    80104c80 <getcallerpcs+0x40>
}
80104c8d:	5b                   	pop    %ebx
80104c8e:	5d                   	pop    %ebp
80104c8f:	c3                   	ret    

80104c90 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	53                   	push   %ebx
80104c94:	83 ec 04             	sub    $0x4,%esp
80104c97:	9c                   	pushf  
80104c98:	5b                   	pop    %ebx
  asm volatile("cli");
80104c99:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104c9a:	e8 51 f2 ff ff       	call   80103ef0 <mycpu>
80104c9f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104ca5:	85 c0                	test   %eax,%eax
80104ca7:	75 11                	jne    80104cba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104ca9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104caf:	e8 3c f2 ff ff       	call   80103ef0 <mycpu>
80104cb4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104cba:	e8 31 f2 ff ff       	call   80103ef0 <mycpu>
80104cbf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104cc6:	83 c4 04             	add    $0x4,%esp
80104cc9:	5b                   	pop    %ebx
80104cca:	5d                   	pop    %ebp
80104ccb:	c3                   	ret    
80104ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cd0 <popcli>:

void
popcli(void)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104cd6:	9c                   	pushf  
80104cd7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104cd8:	f6 c4 02             	test   $0x2,%ah
80104cdb:	75 35                	jne    80104d12 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104cdd:	e8 0e f2 ff ff       	call   80103ef0 <mycpu>
80104ce2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ce9:	78 34                	js     80104d1f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104ceb:	e8 00 f2 ff ff       	call   80103ef0 <mycpu>
80104cf0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104cf6:	85 d2                	test   %edx,%edx
80104cf8:	74 06                	je     80104d00 <popcli+0x30>
    sti();
}
80104cfa:	c9                   	leave  
80104cfb:	c3                   	ret    
80104cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104d00:	e8 eb f1 ff ff       	call   80103ef0 <mycpu>
80104d05:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104d0b:	85 c0                	test   %eax,%eax
80104d0d:	74 eb                	je     80104cfa <popcli+0x2a>
  asm volatile("sti");
80104d0f:	fb                   	sti    
}
80104d10:	c9                   	leave  
80104d11:	c3                   	ret    
    panic("popcli - interruptible");
80104d12:	83 ec 0c             	sub    $0xc,%esp
80104d15:	68 a3 8e 10 80       	push   $0x80108ea3
80104d1a:	e8 71 b6 ff ff       	call   80100390 <panic>
    panic("popcli");
80104d1f:	83 ec 0c             	sub    $0xc,%esp
80104d22:	68 ba 8e 10 80       	push   $0x80108eba
80104d27:	e8 64 b6 ff ff       	call   80100390 <panic>
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d30 <holding>:
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	56                   	push   %esi
80104d34:	53                   	push   %ebx
80104d35:	8b 75 08             	mov    0x8(%ebp),%esi
80104d38:	31 db                	xor    %ebx,%ebx
  pushcli();
80104d3a:	e8 51 ff ff ff       	call   80104c90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104d3f:	8b 06                	mov    (%esi),%eax
80104d41:	85 c0                	test   %eax,%eax
80104d43:	74 10                	je     80104d55 <holding+0x25>
80104d45:	8b 5e 08             	mov    0x8(%esi),%ebx
80104d48:	e8 a3 f1 ff ff       	call   80103ef0 <mycpu>
80104d4d:	39 c3                	cmp    %eax,%ebx
80104d4f:	0f 94 c3             	sete   %bl
80104d52:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104d55:	e8 76 ff ff ff       	call   80104cd0 <popcli>
}
80104d5a:	89 d8                	mov    %ebx,%eax
80104d5c:	5b                   	pop    %ebx
80104d5d:	5e                   	pop    %esi
80104d5e:	5d                   	pop    %ebp
80104d5f:	c3                   	ret    

80104d60 <acquire>:
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104d65:	e8 26 ff ff ff       	call   80104c90 <pushcli>
  if(holding(lk))
80104d6a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d6d:	83 ec 0c             	sub    $0xc,%esp
80104d70:	53                   	push   %ebx
80104d71:	e8 ba ff ff ff       	call   80104d30 <holding>
80104d76:	83 c4 10             	add    $0x10,%esp
80104d79:	85 c0                	test   %eax,%eax
80104d7b:	0f 85 83 00 00 00    	jne    80104e04 <acquire+0xa4>
80104d81:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104d83:	ba 01 00 00 00       	mov    $0x1,%edx
80104d88:	eb 09                	jmp    80104d93 <acquire+0x33>
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d90:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104d93:	89 d0                	mov    %edx,%eax
80104d95:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104d98:	85 c0                	test   %eax,%eax
80104d9a:	75 f4                	jne    80104d90 <acquire+0x30>
  __sync_synchronize();
80104d9c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104da1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104da4:	e8 47 f1 ff ff       	call   80103ef0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104da9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104dac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104daf:	89 e8                	mov    %ebp,%eax
80104db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104db8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104dbe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104dc4:	77 1a                	ja     80104de0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104dc6:	8b 48 04             	mov    0x4(%eax),%ecx
80104dc9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104dcc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104dcf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104dd1:	83 fe 0a             	cmp    $0xa,%esi
80104dd4:	75 e2                	jne    80104db8 <acquire+0x58>
}
80104dd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dd9:	5b                   	pop    %ebx
80104dda:	5e                   	pop    %esi
80104ddb:	5d                   	pop    %ebp
80104ddc:	c3                   	ret    
80104ddd:	8d 76 00             	lea    0x0(%esi),%esi
80104de0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104de3:	83 c2 28             	add    $0x28,%edx
80104de6:	8d 76 00             	lea    0x0(%esi),%esi
80104de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104df0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104df6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104df9:	39 d0                	cmp    %edx,%eax
80104dfb:	75 f3                	jne    80104df0 <acquire+0x90>
}
80104dfd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e00:	5b                   	pop    %ebx
80104e01:	5e                   	pop    %esi
80104e02:	5d                   	pop    %ebp
80104e03:	c3                   	ret    
    panic("acquire");
80104e04:	83 ec 0c             	sub    $0xc,%esp
80104e07:	68 c1 8e 10 80       	push   $0x80108ec1
80104e0c:	e8 7f b5 ff ff       	call   80100390 <panic>
80104e11:	eb 0d                	jmp    80104e20 <release>
80104e13:	90                   	nop
80104e14:	90                   	nop
80104e15:	90                   	nop
80104e16:	90                   	nop
80104e17:	90                   	nop
80104e18:	90                   	nop
80104e19:	90                   	nop
80104e1a:	90                   	nop
80104e1b:	90                   	nop
80104e1c:	90                   	nop
80104e1d:	90                   	nop
80104e1e:	90                   	nop
80104e1f:	90                   	nop

80104e20 <release>:
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	53                   	push   %ebx
80104e24:	83 ec 10             	sub    $0x10,%esp
80104e27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104e2a:	53                   	push   %ebx
80104e2b:	e8 00 ff ff ff       	call   80104d30 <holding>
80104e30:	83 c4 10             	add    $0x10,%esp
80104e33:	85 c0                	test   %eax,%eax
80104e35:	74 22                	je     80104e59 <release+0x39>
  lk->pcs[0] = 0;
80104e37:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104e3e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104e45:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104e4a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104e50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e53:	c9                   	leave  
  popcli();
80104e54:	e9 77 fe ff ff       	jmp    80104cd0 <popcli>
    panic("release");
80104e59:	83 ec 0c             	sub    $0xc,%esp
80104e5c:	68 c9 8e 10 80       	push   $0x80108ec9
80104e61:	e8 2a b5 ff ff       	call   80100390 <panic>
80104e66:	66 90                	xchg   %ax,%ax
80104e68:	66 90                	xchg   %ax,%ax
80104e6a:	66 90                	xchg   %ax,%ax
80104e6c:	66 90                	xchg   %ax,%ax
80104e6e:	66 90                	xchg   %ax,%ax

80104e70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104e70:	55                   	push   %ebp
80104e71:	89 e5                	mov    %esp,%ebp
80104e73:	57                   	push   %edi
80104e74:	53                   	push   %ebx
80104e75:	8b 55 08             	mov    0x8(%ebp),%edx
80104e78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104e7b:	f6 c2 03             	test   $0x3,%dl
80104e7e:	75 05                	jne    80104e85 <memset+0x15>
80104e80:	f6 c1 03             	test   $0x3,%cl
80104e83:	74 13                	je     80104e98 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104e85:	89 d7                	mov    %edx,%edi
80104e87:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e8a:	fc                   	cld    
80104e8b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104e8d:	5b                   	pop    %ebx
80104e8e:	89 d0                	mov    %edx,%eax
80104e90:	5f                   	pop    %edi
80104e91:	5d                   	pop    %ebp
80104e92:	c3                   	ret    
80104e93:	90                   	nop
80104e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104e98:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104e9c:	c1 e9 02             	shr    $0x2,%ecx
80104e9f:	89 f8                	mov    %edi,%eax
80104ea1:	89 fb                	mov    %edi,%ebx
80104ea3:	c1 e0 18             	shl    $0x18,%eax
80104ea6:	c1 e3 10             	shl    $0x10,%ebx
80104ea9:	09 d8                	or     %ebx,%eax
80104eab:	09 f8                	or     %edi,%eax
80104ead:	c1 e7 08             	shl    $0x8,%edi
80104eb0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104eb2:	89 d7                	mov    %edx,%edi
80104eb4:	fc                   	cld    
80104eb5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104eb7:	5b                   	pop    %ebx
80104eb8:	89 d0                	mov    %edx,%eax
80104eba:	5f                   	pop    %edi
80104ebb:	5d                   	pop    %ebp
80104ebc:	c3                   	ret    
80104ebd:	8d 76 00             	lea    0x0(%esi),%esi

80104ec0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	53                   	push   %ebx
80104ec6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104ec9:	8b 75 08             	mov    0x8(%ebp),%esi
80104ecc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104ecf:	85 db                	test   %ebx,%ebx
80104ed1:	74 29                	je     80104efc <memcmp+0x3c>
    if(*s1 != *s2)
80104ed3:	0f b6 16             	movzbl (%esi),%edx
80104ed6:	0f b6 0f             	movzbl (%edi),%ecx
80104ed9:	38 d1                	cmp    %dl,%cl
80104edb:	75 2b                	jne    80104f08 <memcmp+0x48>
80104edd:	b8 01 00 00 00       	mov    $0x1,%eax
80104ee2:	eb 14                	jmp    80104ef8 <memcmp+0x38>
80104ee4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ee8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104eec:	83 c0 01             	add    $0x1,%eax
80104eef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104ef4:	38 ca                	cmp    %cl,%dl
80104ef6:	75 10                	jne    80104f08 <memcmp+0x48>
  while(n-- > 0){
80104ef8:	39 d8                	cmp    %ebx,%eax
80104efa:	75 ec                	jne    80104ee8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104efc:	5b                   	pop    %ebx
  return 0;
80104efd:	31 c0                	xor    %eax,%eax
}
80104eff:	5e                   	pop    %esi
80104f00:	5f                   	pop    %edi
80104f01:	5d                   	pop    %ebp
80104f02:	c3                   	ret    
80104f03:	90                   	nop
80104f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104f08:	0f b6 c2             	movzbl %dl,%eax
}
80104f0b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104f0c:	29 c8                	sub    %ecx,%eax
}
80104f0e:	5e                   	pop    %esi
80104f0f:	5f                   	pop    %edi
80104f10:	5d                   	pop    %ebp
80104f11:	c3                   	ret    
80104f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	56                   	push   %esi
80104f24:	53                   	push   %ebx
80104f25:	8b 45 08             	mov    0x8(%ebp),%eax
80104f28:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104f2b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104f2e:	39 c3                	cmp    %eax,%ebx
80104f30:	73 26                	jae    80104f58 <memmove+0x38>
80104f32:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104f35:	39 c8                	cmp    %ecx,%eax
80104f37:	73 1f                	jae    80104f58 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104f39:	85 f6                	test   %esi,%esi
80104f3b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104f3e:	74 0f                	je     80104f4f <memmove+0x2f>
      *--d = *--s;
80104f40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104f44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104f47:	83 ea 01             	sub    $0x1,%edx
80104f4a:	83 fa ff             	cmp    $0xffffffff,%edx
80104f4d:	75 f1                	jne    80104f40 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104f4f:	5b                   	pop    %ebx
80104f50:	5e                   	pop    %esi
80104f51:	5d                   	pop    %ebp
80104f52:	c3                   	ret    
80104f53:	90                   	nop
80104f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104f58:	31 d2                	xor    %edx,%edx
80104f5a:	85 f6                	test   %esi,%esi
80104f5c:	74 f1                	je     80104f4f <memmove+0x2f>
80104f5e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104f60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104f64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104f67:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104f6a:	39 d6                	cmp    %edx,%esi
80104f6c:	75 f2                	jne    80104f60 <memmove+0x40>
}
80104f6e:	5b                   	pop    %ebx
80104f6f:	5e                   	pop    %esi
80104f70:	5d                   	pop    %ebp
80104f71:	c3                   	ret    
80104f72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104f83:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104f84:	eb 9a                	jmp    80104f20 <memmove>
80104f86:	8d 76 00             	lea    0x0(%esi),%esi
80104f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f90 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104f90:	55                   	push   %ebp
80104f91:	89 e5                	mov    %esp,%ebp
80104f93:	57                   	push   %edi
80104f94:	56                   	push   %esi
80104f95:	8b 7d 10             	mov    0x10(%ebp),%edi
80104f98:	53                   	push   %ebx
80104f99:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104f9f:	85 ff                	test   %edi,%edi
80104fa1:	74 2f                	je     80104fd2 <strncmp+0x42>
80104fa3:	0f b6 01             	movzbl (%ecx),%eax
80104fa6:	0f b6 1e             	movzbl (%esi),%ebx
80104fa9:	84 c0                	test   %al,%al
80104fab:	74 37                	je     80104fe4 <strncmp+0x54>
80104fad:	38 c3                	cmp    %al,%bl
80104faf:	75 33                	jne    80104fe4 <strncmp+0x54>
80104fb1:	01 f7                	add    %esi,%edi
80104fb3:	eb 13                	jmp    80104fc8 <strncmp+0x38>
80104fb5:	8d 76 00             	lea    0x0(%esi),%esi
80104fb8:	0f b6 01             	movzbl (%ecx),%eax
80104fbb:	84 c0                	test   %al,%al
80104fbd:	74 21                	je     80104fe0 <strncmp+0x50>
80104fbf:	0f b6 1a             	movzbl (%edx),%ebx
80104fc2:	89 d6                	mov    %edx,%esi
80104fc4:	38 d8                	cmp    %bl,%al
80104fc6:	75 1c                	jne    80104fe4 <strncmp+0x54>
    n--, p++, q++;
80104fc8:	8d 56 01             	lea    0x1(%esi),%edx
80104fcb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104fce:	39 fa                	cmp    %edi,%edx
80104fd0:	75 e6                	jne    80104fb8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104fd2:	5b                   	pop    %ebx
    return 0;
80104fd3:	31 c0                	xor    %eax,%eax
}
80104fd5:	5e                   	pop    %esi
80104fd6:	5f                   	pop    %edi
80104fd7:	5d                   	pop    %ebp
80104fd8:	c3                   	ret    
80104fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fe0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104fe4:	29 d8                	sub    %ebx,%eax
}
80104fe6:	5b                   	pop    %ebx
80104fe7:	5e                   	pop    %esi
80104fe8:	5f                   	pop    %edi
80104fe9:	5d                   	pop    %ebp
80104fea:	c3                   	ret    
80104feb:	90                   	nop
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	53                   	push   %ebx
80104ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ff8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104ffb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104ffe:	89 c2                	mov    %eax,%edx
80105000:	eb 19                	jmp    8010501b <strncpy+0x2b>
80105002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105008:	83 c3 01             	add    $0x1,%ebx
8010500b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010500f:	83 c2 01             	add    $0x1,%edx
80105012:	84 c9                	test   %cl,%cl
80105014:	88 4a ff             	mov    %cl,-0x1(%edx)
80105017:	74 09                	je     80105022 <strncpy+0x32>
80105019:	89 f1                	mov    %esi,%ecx
8010501b:	85 c9                	test   %ecx,%ecx
8010501d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105020:	7f e6                	jg     80105008 <strncpy+0x18>
    ;
  while(n-- > 0)
80105022:	31 c9                	xor    %ecx,%ecx
80105024:	85 f6                	test   %esi,%esi
80105026:	7e 17                	jle    8010503f <strncpy+0x4f>
80105028:	90                   	nop
80105029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105030:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105034:	89 f3                	mov    %esi,%ebx
80105036:	83 c1 01             	add    $0x1,%ecx
80105039:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010503b:	85 db                	test   %ebx,%ebx
8010503d:	7f f1                	jg     80105030 <strncpy+0x40>
  return os;
}
8010503f:	5b                   	pop    %ebx
80105040:	5e                   	pop    %esi
80105041:	5d                   	pop    %ebp
80105042:	c3                   	ret    
80105043:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105050 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	56                   	push   %esi
80105054:	53                   	push   %ebx
80105055:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105058:	8b 45 08             	mov    0x8(%ebp),%eax
8010505b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010505e:	85 c9                	test   %ecx,%ecx
80105060:	7e 26                	jle    80105088 <safestrcpy+0x38>
80105062:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105066:	89 c1                	mov    %eax,%ecx
80105068:	eb 17                	jmp    80105081 <safestrcpy+0x31>
8010506a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105070:	83 c2 01             	add    $0x1,%edx
80105073:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105077:	83 c1 01             	add    $0x1,%ecx
8010507a:	84 db                	test   %bl,%bl
8010507c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010507f:	74 04                	je     80105085 <safestrcpy+0x35>
80105081:	39 f2                	cmp    %esi,%edx
80105083:	75 eb                	jne    80105070 <safestrcpy+0x20>
    ;
  *s = 0;
80105085:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105088:	5b                   	pop    %ebx
80105089:	5e                   	pop    %esi
8010508a:	5d                   	pop    %ebp
8010508b:	c3                   	ret    
8010508c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105090 <strlen>:

int
strlen(const char *s)
{
80105090:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105091:	31 c0                	xor    %eax,%eax
{
80105093:	89 e5                	mov    %esp,%ebp
80105095:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105098:	80 3a 00             	cmpb   $0x0,(%edx)
8010509b:	74 0c                	je     801050a9 <strlen+0x19>
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
801050a0:	83 c0 01             	add    $0x1,%eax
801050a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801050a7:	75 f7                	jne    801050a0 <strlen+0x10>
    ;
  return n;
}
801050a9:	5d                   	pop    %ebp
801050aa:	c3                   	ret    

801050ab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801050ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801050af:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801050b3:	55                   	push   %ebp
  pushl %ebx
801050b4:	53                   	push   %ebx
  pushl %esi
801050b5:	56                   	push   %esi
  pushl %edi
801050b6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801050b7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801050b9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801050bb:	5f                   	pop    %edi
  popl %esi
801050bc:	5e                   	pop    %esi
  popl %ebx
801050bd:	5b                   	pop    %ebx
  popl %ebp
801050be:	5d                   	pop    %ebp
  ret
801050bf:	c3                   	ret    

801050c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	53                   	push   %ebx
801050c4:	83 ec 04             	sub    $0x4,%esp
801050c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801050ca:	e8 c1 ee ff ff       	call   80103f90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801050cf:	8b 00                	mov    (%eax),%eax
801050d1:	39 d8                	cmp    %ebx,%eax
801050d3:	76 1b                	jbe    801050f0 <fetchint+0x30>
801050d5:	8d 53 04             	lea    0x4(%ebx),%edx
801050d8:	39 d0                	cmp    %edx,%eax
801050da:	72 14                	jb     801050f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801050dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801050df:	8b 13                	mov    (%ebx),%edx
801050e1:	89 10                	mov    %edx,(%eax)
  return 0;
801050e3:	31 c0                	xor    %eax,%eax
}
801050e5:	83 c4 04             	add    $0x4,%esp
801050e8:	5b                   	pop    %ebx
801050e9:	5d                   	pop    %ebp
801050ea:	c3                   	ret    
801050eb:	90                   	nop
801050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050f5:	eb ee                	jmp    801050e5 <fetchint+0x25>
801050f7:	89 f6                	mov    %esi,%esi
801050f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105100 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	53                   	push   %ebx
80105104:	83 ec 04             	sub    $0x4,%esp
80105107:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010510a:	e8 81 ee ff ff       	call   80103f90 <myproc>

  if(addr >= curproc->sz)
8010510f:	39 18                	cmp    %ebx,(%eax)
80105111:	76 29                	jbe    8010513c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105113:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105116:	89 da                	mov    %ebx,%edx
80105118:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010511a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010511c:	39 c3                	cmp    %eax,%ebx
8010511e:	73 1c                	jae    8010513c <fetchstr+0x3c>
    if(*s == 0)
80105120:	80 3b 00             	cmpb   $0x0,(%ebx)
80105123:	75 10                	jne    80105135 <fetchstr+0x35>
80105125:	eb 39                	jmp    80105160 <fetchstr+0x60>
80105127:	89 f6                	mov    %esi,%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105130:	80 3a 00             	cmpb   $0x0,(%edx)
80105133:	74 1b                	je     80105150 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105135:	83 c2 01             	add    $0x1,%edx
80105138:	39 d0                	cmp    %edx,%eax
8010513a:	77 f4                	ja     80105130 <fetchstr+0x30>
    return -1;
8010513c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105141:	83 c4 04             	add    $0x4,%esp
80105144:	5b                   	pop    %ebx
80105145:	5d                   	pop    %ebp
80105146:	c3                   	ret    
80105147:	89 f6                	mov    %esi,%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105150:	83 c4 04             	add    $0x4,%esp
80105153:	89 d0                	mov    %edx,%eax
80105155:	29 d8                	sub    %ebx,%eax
80105157:	5b                   	pop    %ebx
80105158:	5d                   	pop    %ebp
80105159:	c3                   	ret    
8010515a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105160:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105162:	eb dd                	jmp    80105141 <fetchstr+0x41>
80105164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010516a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105170 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	56                   	push   %esi
80105174:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105175:	e8 16 ee ff ff       	call   80103f90 <myproc>
8010517a:	8b 40 18             	mov    0x18(%eax),%eax
8010517d:	8b 55 08             	mov    0x8(%ebp),%edx
80105180:	8b 40 44             	mov    0x44(%eax),%eax
80105183:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105186:	e8 05 ee ff ff       	call   80103f90 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010518b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010518d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105190:	39 c6                	cmp    %eax,%esi
80105192:	73 1c                	jae    801051b0 <argint+0x40>
80105194:	8d 53 08             	lea    0x8(%ebx),%edx
80105197:	39 d0                	cmp    %edx,%eax
80105199:	72 15                	jb     801051b0 <argint+0x40>
  *ip = *(int*)(addr);
8010519b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010519e:	8b 53 04             	mov    0x4(%ebx),%edx
801051a1:	89 10                	mov    %edx,(%eax)
  return 0;
801051a3:	31 c0                	xor    %eax,%eax
}
801051a5:	5b                   	pop    %ebx
801051a6:	5e                   	pop    %esi
801051a7:	5d                   	pop    %ebp
801051a8:	c3                   	ret    
801051a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801051b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801051b5:	eb ee                	jmp    801051a5 <argint+0x35>
801051b7:	89 f6                	mov    %esi,%esi
801051b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	56                   	push   %esi
801051c4:	53                   	push   %ebx
801051c5:	83 ec 10             	sub    $0x10,%esp
801051c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801051cb:	e8 c0 ed ff ff       	call   80103f90 <myproc>
801051d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801051d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051d5:	83 ec 08             	sub    $0x8,%esp
801051d8:	50                   	push   %eax
801051d9:	ff 75 08             	pushl  0x8(%ebp)
801051dc:	e8 8f ff ff ff       	call   80105170 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801051e1:	83 c4 10             	add    $0x10,%esp
801051e4:	85 c0                	test   %eax,%eax
801051e6:	78 28                	js     80105210 <argptr+0x50>
801051e8:	85 db                	test   %ebx,%ebx
801051ea:	78 24                	js     80105210 <argptr+0x50>
801051ec:	8b 16                	mov    (%esi),%edx
801051ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801051f1:	39 c2                	cmp    %eax,%edx
801051f3:	76 1b                	jbe    80105210 <argptr+0x50>
801051f5:	01 c3                	add    %eax,%ebx
801051f7:	39 da                	cmp    %ebx,%edx
801051f9:	72 15                	jb     80105210 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801051fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801051fe:	89 02                	mov    %eax,(%edx)
  return 0;
80105200:	31 c0                	xor    %eax,%eax
}
80105202:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105205:	5b                   	pop    %ebx
80105206:	5e                   	pop    %esi
80105207:	5d                   	pop    %ebp
80105208:	c3                   	ret    
80105209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105215:	eb eb                	jmp    80105202 <argptr+0x42>
80105217:	89 f6                	mov    %esi,%esi
80105219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105220 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105226:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105229:	50                   	push   %eax
8010522a:	ff 75 08             	pushl  0x8(%ebp)
8010522d:	e8 3e ff ff ff       	call   80105170 <argint>
80105232:	83 c4 10             	add    $0x10,%esp
80105235:	85 c0                	test   %eax,%eax
80105237:	78 17                	js     80105250 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105239:	83 ec 08             	sub    $0x8,%esp
8010523c:	ff 75 0c             	pushl  0xc(%ebp)
8010523f:	ff 75 f4             	pushl  -0xc(%ebp)
80105242:	e8 b9 fe ff ff       	call   80105100 <fetchstr>
80105247:	83 c4 10             	add    $0x10,%esp
}
8010524a:	c9                   	leave  
8010524b:	c3                   	ret    
8010524c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105255:	c9                   	leave  
80105256:	c3                   	ret    
80105257:	89 f6                	mov    %esi,%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105260 <syscall>:
[SYS_getNumberOfFreePages] sys_getNumberOfFreePages,
};

void
syscall(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	53                   	push   %ebx
80105264:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105267:	e8 24 ed ff ff       	call   80103f90 <myproc>
8010526c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010526e:	8b 40 18             	mov    0x18(%eax),%eax
80105271:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105274:	8d 50 ff             	lea    -0x1(%eax),%edx
80105277:	83 fa 15             	cmp    $0x15,%edx
8010527a:	77 1c                	ja     80105298 <syscall+0x38>
8010527c:	8b 14 85 00 8f 10 80 	mov    -0x7fef7100(,%eax,4),%edx
80105283:	85 d2                	test   %edx,%edx
80105285:	74 11                	je     80105298 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105287:	ff d2                	call   *%edx
80105289:	8b 53 18             	mov    0x18(%ebx),%edx
8010528c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010528f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105292:	c9                   	leave  
80105293:	c3                   	ret    
80105294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105298:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105299:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010529c:	50                   	push   %eax
8010529d:	ff 73 10             	pushl  0x10(%ebx)
801052a0:	68 d1 8e 10 80       	push   $0x80108ed1
801052a5:	e8 b6 b3 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801052aa:	8b 43 18             	mov    0x18(%ebx),%eax
801052ad:	83 c4 10             	add    $0x10,%esp
801052b0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801052b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052ba:	c9                   	leave  
801052bb:	c3                   	ret    
801052bc:	66 90                	xchg   %ax,%ax
801052be:	66 90                	xchg   %ax,%ax

801052c0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	53                   	push   %ebx
801052c5:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801052c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801052ca:	89 d6                	mov    %edx,%esi
801052cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052cf:	50                   	push   %eax
801052d0:	6a 00                	push   $0x0
801052d2:	e8 99 fe ff ff       	call   80105170 <argint>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	78 2a                	js     80105308 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052e2:	77 24                	ja     80105308 <argfd.constprop.0+0x48>
801052e4:	e8 a7 ec ff ff       	call   80103f90 <myproc>
801052e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801052f0:	85 c0                	test   %eax,%eax
801052f2:	74 14                	je     80105308 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
801052f4:	85 db                	test   %ebx,%ebx
801052f6:	74 02                	je     801052fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801052f8:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
801052fa:	89 06                	mov    %eax,(%esi)
  return 0;
801052fc:	31 c0                	xor    %eax,%eax
}
801052fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105301:	5b                   	pop    %ebx
80105302:	5e                   	pop    %esi
80105303:	5d                   	pop    %ebp
80105304:	c3                   	ret    
80105305:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530d:	eb ef                	jmp    801052fe <argfd.constprop.0+0x3e>
8010530f:	90                   	nop

80105310 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105310:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105311:	31 c0                	xor    %eax,%eax
{
80105313:	89 e5                	mov    %esp,%ebp
80105315:	56                   	push   %esi
80105316:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105317:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010531a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010531d:	e8 9e ff ff ff       	call   801052c0 <argfd.constprop.0>
80105322:	85 c0                	test   %eax,%eax
80105324:	78 42                	js     80105368 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105326:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105329:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010532b:	e8 60 ec ff ff       	call   80103f90 <myproc>
80105330:	eb 0e                	jmp    80105340 <sys_dup+0x30>
80105332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105338:	83 c3 01             	add    $0x1,%ebx
8010533b:	83 fb 10             	cmp    $0x10,%ebx
8010533e:	74 28                	je     80105368 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105340:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105344:	85 d2                	test   %edx,%edx
80105346:	75 f0                	jne    80105338 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105348:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010534c:	83 ec 0c             	sub    $0xc,%esp
8010534f:	ff 75 f4             	pushl  -0xc(%ebp)
80105352:	e8 f9 bb ff ff       	call   80100f50 <filedup>
  return fd;
80105357:	83 c4 10             	add    $0x10,%esp
}
8010535a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010535d:	89 d8                	mov    %ebx,%eax
8010535f:	5b                   	pop    %ebx
80105360:	5e                   	pop    %esi
80105361:	5d                   	pop    %ebp
80105362:	c3                   	ret    
80105363:	90                   	nop
80105364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105368:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010536b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105370:	89 d8                	mov    %ebx,%eax
80105372:	5b                   	pop    %ebx
80105373:	5e                   	pop    %esi
80105374:	5d                   	pop    %ebp
80105375:	c3                   	ret    
80105376:	8d 76 00             	lea    0x0(%esi),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105380 <sys_read>:

int
sys_read(void)
{
80105380:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105381:	31 c0                	xor    %eax,%eax
{
80105383:	89 e5                	mov    %esp,%ebp
80105385:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105388:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010538b:	e8 30 ff ff ff       	call   801052c0 <argfd.constprop.0>
80105390:	85 c0                	test   %eax,%eax
80105392:	78 4c                	js     801053e0 <sys_read+0x60>
80105394:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105397:	83 ec 08             	sub    $0x8,%esp
8010539a:	50                   	push   %eax
8010539b:	6a 02                	push   $0x2
8010539d:	e8 ce fd ff ff       	call   80105170 <argint>
801053a2:	83 c4 10             	add    $0x10,%esp
801053a5:	85 c0                	test   %eax,%eax
801053a7:	78 37                	js     801053e0 <sys_read+0x60>
801053a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ac:	83 ec 04             	sub    $0x4,%esp
801053af:	ff 75 f0             	pushl  -0x10(%ebp)
801053b2:	50                   	push   %eax
801053b3:	6a 01                	push   $0x1
801053b5:	e8 06 fe ff ff       	call   801051c0 <argptr>
801053ba:	83 c4 10             	add    $0x10,%esp
801053bd:	85 c0                	test   %eax,%eax
801053bf:	78 1f                	js     801053e0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801053c1:	83 ec 04             	sub    $0x4,%esp
801053c4:	ff 75 f0             	pushl  -0x10(%ebp)
801053c7:	ff 75 f4             	pushl  -0xc(%ebp)
801053ca:	ff 75 ec             	pushl  -0x14(%ebp)
801053cd:	e8 ee bc ff ff       	call   801010c0 <fileread>
801053d2:	83 c4 10             	add    $0x10,%esp
}
801053d5:	c9                   	leave  
801053d6:	c3                   	ret    
801053d7:	89 f6                	mov    %esi,%esi
801053d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053e5:	c9                   	leave  
801053e6:	c3                   	ret    
801053e7:	89 f6                	mov    %esi,%esi
801053e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053f0 <sys_write>:

int
sys_write(void)
{
801053f0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053f1:	31 c0                	xor    %eax,%eax
{
801053f3:	89 e5                	mov    %esp,%ebp
801053f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053fb:	e8 c0 fe ff ff       	call   801052c0 <argfd.constprop.0>
80105400:	85 c0                	test   %eax,%eax
80105402:	78 4c                	js     80105450 <sys_write+0x60>
80105404:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105407:	83 ec 08             	sub    $0x8,%esp
8010540a:	50                   	push   %eax
8010540b:	6a 02                	push   $0x2
8010540d:	e8 5e fd ff ff       	call   80105170 <argint>
80105412:	83 c4 10             	add    $0x10,%esp
80105415:	85 c0                	test   %eax,%eax
80105417:	78 37                	js     80105450 <sys_write+0x60>
80105419:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010541c:	83 ec 04             	sub    $0x4,%esp
8010541f:	ff 75 f0             	pushl  -0x10(%ebp)
80105422:	50                   	push   %eax
80105423:	6a 01                	push   $0x1
80105425:	e8 96 fd ff ff       	call   801051c0 <argptr>
8010542a:	83 c4 10             	add    $0x10,%esp
8010542d:	85 c0                	test   %eax,%eax
8010542f:	78 1f                	js     80105450 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105431:	83 ec 04             	sub    $0x4,%esp
80105434:	ff 75 f0             	pushl  -0x10(%ebp)
80105437:	ff 75 f4             	pushl  -0xc(%ebp)
8010543a:	ff 75 ec             	pushl  -0x14(%ebp)
8010543d:	e8 0e bd ff ff       	call   80101150 <filewrite>
80105442:	83 c4 10             	add    $0x10,%esp
}
80105445:	c9                   	leave  
80105446:	c3                   	ret    
80105447:	89 f6                	mov    %esi,%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105455:	c9                   	leave  
80105456:	c3                   	ret    
80105457:	89 f6                	mov    %esi,%esi
80105459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105460 <sys_close>:

int
sys_close(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105466:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105469:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010546c:	e8 4f fe ff ff       	call   801052c0 <argfd.constprop.0>
80105471:	85 c0                	test   %eax,%eax
80105473:	78 2b                	js     801054a0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105475:	e8 16 eb ff ff       	call   80103f90 <myproc>
8010547a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010547d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105480:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105487:	00 
  fileclose(f);
80105488:	ff 75 f4             	pushl  -0xc(%ebp)
8010548b:	e8 10 bb ff ff       	call   80100fa0 <fileclose>
  return 0;
80105490:	83 c4 10             	add    $0x10,%esp
80105493:	31 c0                	xor    %eax,%eax
}
80105495:	c9                   	leave  
80105496:	c3                   	ret    
80105497:	89 f6                	mov    %esi,%esi
80105499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054a5:	c9                   	leave  
801054a6:	c3                   	ret    
801054a7:	89 f6                	mov    %esi,%esi
801054a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054b0 <sys_fstat>:

int
sys_fstat(void)
{
801054b0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054b1:	31 c0                	xor    %eax,%eax
{
801054b3:	89 e5                	mov    %esp,%ebp
801054b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801054bb:	e8 00 fe ff ff       	call   801052c0 <argfd.constprop.0>
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 2c                	js     801054f0 <sys_fstat+0x40>
801054c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054c7:	83 ec 04             	sub    $0x4,%esp
801054ca:	6a 14                	push   $0x14
801054cc:	50                   	push   %eax
801054cd:	6a 01                	push   $0x1
801054cf:	e8 ec fc ff ff       	call   801051c0 <argptr>
801054d4:	83 c4 10             	add    $0x10,%esp
801054d7:	85 c0                	test   %eax,%eax
801054d9:	78 15                	js     801054f0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801054db:	83 ec 08             	sub    $0x8,%esp
801054de:	ff 75 f4             	pushl  -0xc(%ebp)
801054e1:	ff 75 f0             	pushl  -0x10(%ebp)
801054e4:	e8 87 bb ff ff       	call   80101070 <filestat>
801054e9:	83 c4 10             	add    $0x10,%esp
}
801054ec:	c9                   	leave  
801054ed:	c3                   	ret    
801054ee:	66 90                	xchg   %ax,%ax
    return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f5:	c9                   	leave  
801054f6:	c3                   	ret    
801054f7:	89 f6                	mov    %esi,%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105500 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	57                   	push   %edi
80105504:	56                   	push   %esi
80105505:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105506:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105509:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010550c:	50                   	push   %eax
8010550d:	6a 00                	push   $0x0
8010550f:	e8 0c fd ff ff       	call   80105220 <argstr>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	0f 88 fb 00 00 00    	js     8010561a <sys_link+0x11a>
8010551f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105522:	83 ec 08             	sub    $0x8,%esp
80105525:	50                   	push   %eax
80105526:	6a 01                	push   $0x1
80105528:	e8 f3 fc ff ff       	call   80105220 <argstr>
8010552d:	83 c4 10             	add    $0x10,%esp
80105530:	85 c0                	test   %eax,%eax
80105532:	0f 88 e2 00 00 00    	js     8010561a <sys_link+0x11a>
    return -1;

  begin_op();
80105538:	e8 63 dd ff ff       	call   801032a0 <begin_op>
  if((ip = namei(old)) == 0){
8010553d:	83 ec 0c             	sub    $0xc,%esp
80105540:	ff 75 d4             	pushl  -0x2c(%ebp)
80105543:	e8 f8 ca ff ff       	call   80102040 <namei>
80105548:	83 c4 10             	add    $0x10,%esp
8010554b:	85 c0                	test   %eax,%eax
8010554d:	89 c3                	mov    %eax,%ebx
8010554f:	0f 84 ea 00 00 00    	je     8010563f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105555:	83 ec 0c             	sub    $0xc,%esp
80105558:	50                   	push   %eax
80105559:	e8 82 c2 ff ff       	call   801017e0 <ilock>
  if(ip->type == T_DIR){
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105566:	0f 84 bb 00 00 00    	je     80105627 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010556c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105571:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105574:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105577:	53                   	push   %ebx
80105578:	e8 b3 c1 ff ff       	call   80101730 <iupdate>
  iunlock(ip);
8010557d:	89 1c 24             	mov    %ebx,(%esp)
80105580:	e8 3b c3 ff ff       	call   801018c0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105585:	58                   	pop    %eax
80105586:	5a                   	pop    %edx
80105587:	57                   	push   %edi
80105588:	ff 75 d0             	pushl  -0x30(%ebp)
8010558b:	e8 d0 ca ff ff       	call   80102060 <nameiparent>
80105590:	83 c4 10             	add    $0x10,%esp
80105593:	85 c0                	test   %eax,%eax
80105595:	89 c6                	mov    %eax,%esi
80105597:	74 5b                	je     801055f4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105599:	83 ec 0c             	sub    $0xc,%esp
8010559c:	50                   	push   %eax
8010559d:	e8 3e c2 ff ff       	call   801017e0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055a2:	83 c4 10             	add    $0x10,%esp
801055a5:	8b 03                	mov    (%ebx),%eax
801055a7:	39 06                	cmp    %eax,(%esi)
801055a9:	75 3d                	jne    801055e8 <sys_link+0xe8>
801055ab:	83 ec 04             	sub    $0x4,%esp
801055ae:	ff 73 04             	pushl  0x4(%ebx)
801055b1:	57                   	push   %edi
801055b2:	56                   	push   %esi
801055b3:	e8 c8 c9 ff ff       	call   80101f80 <dirlink>
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	85 c0                	test   %eax,%eax
801055bd:	78 29                	js     801055e8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801055bf:	83 ec 0c             	sub    $0xc,%esp
801055c2:	56                   	push   %esi
801055c3:	e8 a8 c4 ff ff       	call   80101a70 <iunlockput>
  iput(ip);
801055c8:	89 1c 24             	mov    %ebx,(%esp)
801055cb:	e8 40 c3 ff ff       	call   80101910 <iput>

  end_op();
801055d0:	e8 3b dd ff ff       	call   80103310 <end_op>

  return 0;
801055d5:	83 c4 10             	add    $0x10,%esp
801055d8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801055da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055dd:	5b                   	pop    %ebx
801055de:	5e                   	pop    %esi
801055df:	5f                   	pop    %edi
801055e0:	5d                   	pop    %ebp
801055e1:	c3                   	ret    
801055e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801055e8:	83 ec 0c             	sub    $0xc,%esp
801055eb:	56                   	push   %esi
801055ec:	e8 7f c4 ff ff       	call   80101a70 <iunlockput>
    goto bad;
801055f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801055f4:	83 ec 0c             	sub    $0xc,%esp
801055f7:	53                   	push   %ebx
801055f8:	e8 e3 c1 ff ff       	call   801017e0 <ilock>
  ip->nlink--;
801055fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105602:	89 1c 24             	mov    %ebx,(%esp)
80105605:	e8 26 c1 ff ff       	call   80101730 <iupdate>
  iunlockput(ip);
8010560a:	89 1c 24             	mov    %ebx,(%esp)
8010560d:	e8 5e c4 ff ff       	call   80101a70 <iunlockput>
  end_op();
80105612:	e8 f9 dc ff ff       	call   80103310 <end_op>
  return -1;
80105617:	83 c4 10             	add    $0x10,%esp
}
8010561a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010561d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105622:	5b                   	pop    %ebx
80105623:	5e                   	pop    %esi
80105624:	5f                   	pop    %edi
80105625:	5d                   	pop    %ebp
80105626:	c3                   	ret    
    iunlockput(ip);
80105627:	83 ec 0c             	sub    $0xc,%esp
8010562a:	53                   	push   %ebx
8010562b:	e8 40 c4 ff ff       	call   80101a70 <iunlockput>
    end_op();
80105630:	e8 db dc ff ff       	call   80103310 <end_op>
    return -1;
80105635:	83 c4 10             	add    $0x10,%esp
80105638:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563d:	eb 9b                	jmp    801055da <sys_link+0xda>
    end_op();
8010563f:	e8 cc dc ff ff       	call   80103310 <end_op>
    return -1;
80105644:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105649:	eb 8f                	jmp    801055da <sys_link+0xda>
8010564b:	90                   	nop
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
80105655:	53                   	push   %ebx
80105656:	83 ec 1c             	sub    $0x1c,%esp
80105659:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010565c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105660:	76 3e                	jbe    801056a0 <isdirempty+0x50>
80105662:	bb 20 00 00 00       	mov    $0x20,%ebx
80105667:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010566a:	eb 0c                	jmp    80105678 <isdirempty+0x28>
8010566c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105670:	83 c3 10             	add    $0x10,%ebx
80105673:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105676:	73 28                	jae    801056a0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105678:	6a 10                	push   $0x10
8010567a:	53                   	push   %ebx
8010567b:	57                   	push   %edi
8010567c:	56                   	push   %esi
8010567d:	e8 3e c4 ff ff       	call   80101ac0 <readi>
80105682:	83 c4 10             	add    $0x10,%esp
80105685:	83 f8 10             	cmp    $0x10,%eax
80105688:	75 23                	jne    801056ad <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010568a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010568f:	74 df                	je     80105670 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105691:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105694:	31 c0                	xor    %eax,%eax
}
80105696:	5b                   	pop    %ebx
80105697:	5e                   	pop    %esi
80105698:	5f                   	pop    %edi
80105699:	5d                   	pop    %ebp
8010569a:	c3                   	ret    
8010569b:	90                   	nop
8010569c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801056a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801056a8:	5b                   	pop    %ebx
801056a9:	5e                   	pop    %esi
801056aa:	5f                   	pop    %edi
801056ab:	5d                   	pop    %ebp
801056ac:	c3                   	ret    
      panic("isdirempty: readi");
801056ad:	83 ec 0c             	sub    $0xc,%esp
801056b0:	68 5c 8f 10 80       	push   $0x80108f5c
801056b5:	e8 d6 ac ff ff       	call   80100390 <panic>
801056ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801056c0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801056c0:	55                   	push   %ebp
801056c1:	89 e5                	mov    %esp,%ebp
801056c3:	57                   	push   %edi
801056c4:	56                   	push   %esi
801056c5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801056c6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801056c9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801056cc:	50                   	push   %eax
801056cd:	6a 00                	push   $0x0
801056cf:	e8 4c fb ff ff       	call   80105220 <argstr>
801056d4:	83 c4 10             	add    $0x10,%esp
801056d7:	85 c0                	test   %eax,%eax
801056d9:	0f 88 51 01 00 00    	js     80105830 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801056df:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801056e2:	e8 b9 db ff ff       	call   801032a0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801056e7:	83 ec 08             	sub    $0x8,%esp
801056ea:	53                   	push   %ebx
801056eb:	ff 75 c0             	pushl  -0x40(%ebp)
801056ee:	e8 6d c9 ff ff       	call   80102060 <nameiparent>
801056f3:	83 c4 10             	add    $0x10,%esp
801056f6:	85 c0                	test   %eax,%eax
801056f8:	89 c6                	mov    %eax,%esi
801056fa:	0f 84 37 01 00 00    	je     80105837 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105700:	83 ec 0c             	sub    $0xc,%esp
80105703:	50                   	push   %eax
80105704:	e8 d7 c0 ff ff       	call   801017e0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105709:	58                   	pop    %eax
8010570a:	5a                   	pop    %edx
8010570b:	68 9d 88 10 80       	push   $0x8010889d
80105710:	53                   	push   %ebx
80105711:	e8 da c5 ff ff       	call   80101cf0 <namecmp>
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	85 c0                	test   %eax,%eax
8010571b:	0f 84 d7 00 00 00    	je     801057f8 <sys_unlink+0x138>
80105721:	83 ec 08             	sub    $0x8,%esp
80105724:	68 9c 88 10 80       	push   $0x8010889c
80105729:	53                   	push   %ebx
8010572a:	e8 c1 c5 ff ff       	call   80101cf0 <namecmp>
8010572f:	83 c4 10             	add    $0x10,%esp
80105732:	85 c0                	test   %eax,%eax
80105734:	0f 84 be 00 00 00    	je     801057f8 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010573a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010573d:	83 ec 04             	sub    $0x4,%esp
80105740:	50                   	push   %eax
80105741:	53                   	push   %ebx
80105742:	56                   	push   %esi
80105743:	e8 c8 c5 ff ff       	call   80101d10 <dirlookup>
80105748:	83 c4 10             	add    $0x10,%esp
8010574b:	85 c0                	test   %eax,%eax
8010574d:	89 c3                	mov    %eax,%ebx
8010574f:	0f 84 a3 00 00 00    	je     801057f8 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105755:	83 ec 0c             	sub    $0xc,%esp
80105758:	50                   	push   %eax
80105759:	e8 82 c0 ff ff       	call   801017e0 <ilock>

  if(ip->nlink < 1)
8010575e:	83 c4 10             	add    $0x10,%esp
80105761:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105766:	0f 8e e4 00 00 00    	jle    80105850 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010576c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105771:	74 65                	je     801057d8 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105773:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105776:	83 ec 04             	sub    $0x4,%esp
80105779:	6a 10                	push   $0x10
8010577b:	6a 00                	push   $0x0
8010577d:	57                   	push   %edi
8010577e:	e8 ed f6 ff ff       	call   80104e70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105783:	6a 10                	push   $0x10
80105785:	ff 75 c4             	pushl  -0x3c(%ebp)
80105788:	57                   	push   %edi
80105789:	56                   	push   %esi
8010578a:	e8 31 c4 ff ff       	call   80101bc0 <writei>
8010578f:	83 c4 20             	add    $0x20,%esp
80105792:	83 f8 10             	cmp    $0x10,%eax
80105795:	0f 85 a8 00 00 00    	jne    80105843 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010579b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057a0:	74 6e                	je     80105810 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801057a2:	83 ec 0c             	sub    $0xc,%esp
801057a5:	56                   	push   %esi
801057a6:	e8 c5 c2 ff ff       	call   80101a70 <iunlockput>

  ip->nlink--;
801057ab:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801057b0:	89 1c 24             	mov    %ebx,(%esp)
801057b3:	e8 78 bf ff ff       	call   80101730 <iupdate>
  iunlockput(ip);
801057b8:	89 1c 24             	mov    %ebx,(%esp)
801057bb:	e8 b0 c2 ff ff       	call   80101a70 <iunlockput>

  end_op();
801057c0:	e8 4b db ff ff       	call   80103310 <end_op>

  return 0;
801057c5:	83 c4 10             	add    $0x10,%esp
801057c8:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801057ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057cd:	5b                   	pop    %ebx
801057ce:	5e                   	pop    %esi
801057cf:	5f                   	pop    %edi
801057d0:	5d                   	pop    %ebp
801057d1:	c3                   	ret    
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
801057d8:	83 ec 0c             	sub    $0xc,%esp
801057db:	53                   	push   %ebx
801057dc:	e8 6f fe ff ff       	call   80105650 <isdirempty>
801057e1:	83 c4 10             	add    $0x10,%esp
801057e4:	85 c0                	test   %eax,%eax
801057e6:	75 8b                	jne    80105773 <sys_unlink+0xb3>
    iunlockput(ip);
801057e8:	83 ec 0c             	sub    $0xc,%esp
801057eb:	53                   	push   %ebx
801057ec:	e8 7f c2 ff ff       	call   80101a70 <iunlockput>
    goto bad;
801057f1:	83 c4 10             	add    $0x10,%esp
801057f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
801057f8:	83 ec 0c             	sub    $0xc,%esp
801057fb:	56                   	push   %esi
801057fc:	e8 6f c2 ff ff       	call   80101a70 <iunlockput>
  end_op();
80105801:	e8 0a db ff ff       	call   80103310 <end_op>
  return -1;
80105806:	83 c4 10             	add    $0x10,%esp
80105809:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010580e:	eb ba                	jmp    801057ca <sys_unlink+0x10a>
    dp->nlink--;
80105810:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105815:	83 ec 0c             	sub    $0xc,%esp
80105818:	56                   	push   %esi
80105819:	e8 12 bf ff ff       	call   80101730 <iupdate>
8010581e:	83 c4 10             	add    $0x10,%esp
80105821:	e9 7c ff ff ff       	jmp    801057a2 <sys_unlink+0xe2>
80105826:	8d 76 00             	lea    0x0(%esi),%esi
80105829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105830:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105835:	eb 93                	jmp    801057ca <sys_unlink+0x10a>
    end_op();
80105837:	e8 d4 da ff ff       	call   80103310 <end_op>
    return -1;
8010583c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105841:	eb 87                	jmp    801057ca <sys_unlink+0x10a>
    panic("unlink: writei");
80105843:	83 ec 0c             	sub    $0xc,%esp
80105846:	68 b1 88 10 80       	push   $0x801088b1
8010584b:	e8 40 ab ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105850:	83 ec 0c             	sub    $0xc,%esp
80105853:	68 9f 88 10 80       	push   $0x8010889f
80105858:	e8 33 ab ff ff       	call   80100390 <panic>
8010585d:	8d 76 00             	lea    0x0(%esi),%esi

80105860 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	57                   	push   %edi
80105864:	56                   	push   %esi
80105865:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105866:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105869:	83 ec 34             	sub    $0x34,%esp
8010586c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010586f:	8b 55 10             	mov    0x10(%ebp),%edx
80105872:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105875:	56                   	push   %esi
80105876:	ff 75 08             	pushl  0x8(%ebp)
{
80105879:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010587c:	89 55 d0             	mov    %edx,-0x30(%ebp)
8010587f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105882:	e8 d9 c7 ff ff       	call   80102060 <nameiparent>
80105887:	83 c4 10             	add    $0x10,%esp
8010588a:	85 c0                	test   %eax,%eax
8010588c:	0f 84 4e 01 00 00    	je     801059e0 <create+0x180>
    return 0;
  ilock(dp);
80105892:	83 ec 0c             	sub    $0xc,%esp
80105895:	89 c3                	mov    %eax,%ebx
80105897:	50                   	push   %eax
80105898:	e8 43 bf ff ff       	call   801017e0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
8010589d:	83 c4 0c             	add    $0xc,%esp
801058a0:	6a 00                	push   $0x0
801058a2:	56                   	push   %esi
801058a3:	53                   	push   %ebx
801058a4:	e8 67 c4 ff ff       	call   80101d10 <dirlookup>
801058a9:	83 c4 10             	add    $0x10,%esp
801058ac:	85 c0                	test   %eax,%eax
801058ae:	89 c7                	mov    %eax,%edi
801058b0:	74 3e                	je     801058f0 <create+0x90>
    iunlockput(dp);
801058b2:	83 ec 0c             	sub    $0xc,%esp
801058b5:	53                   	push   %ebx
801058b6:	e8 b5 c1 ff ff       	call   80101a70 <iunlockput>
    ilock(ip);
801058bb:	89 3c 24             	mov    %edi,(%esp)
801058be:	e8 1d bf ff ff       	call   801017e0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801058c3:	83 c4 10             	add    $0x10,%esp
801058c6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801058cb:	0f 85 9f 00 00 00    	jne    80105970 <create+0x110>
801058d1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801058d6:	0f 85 94 00 00 00    	jne    80105970 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801058dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058df:	89 f8                	mov    %edi,%eax
801058e1:	5b                   	pop    %ebx
801058e2:	5e                   	pop    %esi
801058e3:	5f                   	pop    %edi
801058e4:	5d                   	pop    %ebp
801058e5:	c3                   	ret    
801058e6:	8d 76 00             	lea    0x0(%esi),%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
801058f0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801058f4:	83 ec 08             	sub    $0x8,%esp
801058f7:	50                   	push   %eax
801058f8:	ff 33                	pushl  (%ebx)
801058fa:	e8 71 bd ff ff       	call   80101670 <ialloc>
801058ff:	83 c4 10             	add    $0x10,%esp
80105902:	85 c0                	test   %eax,%eax
80105904:	89 c7                	mov    %eax,%edi
80105906:	0f 84 e8 00 00 00    	je     801059f4 <create+0x194>
  ilock(ip);
8010590c:	83 ec 0c             	sub    $0xc,%esp
8010590f:	50                   	push   %eax
80105910:	e8 cb be ff ff       	call   801017e0 <ilock>
  ip->major = major;
80105915:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105919:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010591d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105921:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105925:	b8 01 00 00 00       	mov    $0x1,%eax
8010592a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010592e:	89 3c 24             	mov    %edi,(%esp)
80105931:	e8 fa bd ff ff       	call   80101730 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105936:	83 c4 10             	add    $0x10,%esp
80105939:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010593e:	74 50                	je     80105990 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105940:	83 ec 04             	sub    $0x4,%esp
80105943:	ff 77 04             	pushl  0x4(%edi)
80105946:	56                   	push   %esi
80105947:	53                   	push   %ebx
80105948:	e8 33 c6 ff ff       	call   80101f80 <dirlink>
8010594d:	83 c4 10             	add    $0x10,%esp
80105950:	85 c0                	test   %eax,%eax
80105952:	0f 88 8f 00 00 00    	js     801059e7 <create+0x187>
  iunlockput(dp);
80105958:	83 ec 0c             	sub    $0xc,%esp
8010595b:	53                   	push   %ebx
8010595c:	e8 0f c1 ff ff       	call   80101a70 <iunlockput>
  return ip;
80105961:	83 c4 10             	add    $0x10,%esp
}
80105964:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105967:	89 f8                	mov    %edi,%eax
80105969:	5b                   	pop    %ebx
8010596a:	5e                   	pop    %esi
8010596b:	5f                   	pop    %edi
8010596c:	5d                   	pop    %ebp
8010596d:	c3                   	ret    
8010596e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105970:	83 ec 0c             	sub    $0xc,%esp
80105973:	57                   	push   %edi
    return 0;
80105974:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105976:	e8 f5 c0 ff ff       	call   80101a70 <iunlockput>
    return 0;
8010597b:	83 c4 10             	add    $0x10,%esp
}
8010597e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105981:	89 f8                	mov    %edi,%eax
80105983:	5b                   	pop    %ebx
80105984:	5e                   	pop    %esi
80105985:	5f                   	pop    %edi
80105986:	5d                   	pop    %ebp
80105987:	c3                   	ret    
80105988:	90                   	nop
80105989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105990:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105995:	83 ec 0c             	sub    $0xc,%esp
80105998:	53                   	push   %ebx
80105999:	e8 92 bd ff ff       	call   80101730 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010599e:	83 c4 0c             	add    $0xc,%esp
801059a1:	ff 77 04             	pushl  0x4(%edi)
801059a4:	68 9d 88 10 80       	push   $0x8010889d
801059a9:	57                   	push   %edi
801059aa:	e8 d1 c5 ff ff       	call   80101f80 <dirlink>
801059af:	83 c4 10             	add    $0x10,%esp
801059b2:	85 c0                	test   %eax,%eax
801059b4:	78 1c                	js     801059d2 <create+0x172>
801059b6:	83 ec 04             	sub    $0x4,%esp
801059b9:	ff 73 04             	pushl  0x4(%ebx)
801059bc:	68 9c 88 10 80       	push   $0x8010889c
801059c1:	57                   	push   %edi
801059c2:	e8 b9 c5 ff ff       	call   80101f80 <dirlink>
801059c7:	83 c4 10             	add    $0x10,%esp
801059ca:	85 c0                	test   %eax,%eax
801059cc:	0f 89 6e ff ff ff    	jns    80105940 <create+0xe0>
      panic("create dots");
801059d2:	83 ec 0c             	sub    $0xc,%esp
801059d5:	68 7d 8f 10 80       	push   $0x80108f7d
801059da:	e8 b1 a9 ff ff       	call   80100390 <panic>
801059df:	90                   	nop
    return 0;
801059e0:	31 ff                	xor    %edi,%edi
801059e2:	e9 f5 fe ff ff       	jmp    801058dc <create+0x7c>
    panic("create: dirlink");
801059e7:	83 ec 0c             	sub    $0xc,%esp
801059ea:	68 89 8f 10 80       	push   $0x80108f89
801059ef:	e8 9c a9 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801059f4:	83 ec 0c             	sub    $0xc,%esp
801059f7:	68 6e 8f 10 80       	push   $0x80108f6e
801059fc:	e8 8f a9 ff ff       	call   80100390 <panic>
80105a01:	eb 0d                	jmp    80105a10 <sys_open>
80105a03:	90                   	nop
80105a04:	90                   	nop
80105a05:	90                   	nop
80105a06:	90                   	nop
80105a07:	90                   	nop
80105a08:	90                   	nop
80105a09:	90                   	nop
80105a0a:	90                   	nop
80105a0b:	90                   	nop
80105a0c:	90                   	nop
80105a0d:	90                   	nop
80105a0e:	90                   	nop
80105a0f:	90                   	nop

80105a10 <sys_open>:

int
sys_open(void)
{
80105a10:	55                   	push   %ebp
80105a11:	89 e5                	mov    %esp,%ebp
80105a13:	57                   	push   %edi
80105a14:	56                   	push   %esi
80105a15:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105a16:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105a19:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105a1c:	50                   	push   %eax
80105a1d:	6a 00                	push   $0x0
80105a1f:	e8 fc f7 ff ff       	call   80105220 <argstr>
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	85 c0                	test   %eax,%eax
80105a29:	0f 88 1d 01 00 00    	js     80105b4c <sys_open+0x13c>
80105a2f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a32:	83 ec 08             	sub    $0x8,%esp
80105a35:	50                   	push   %eax
80105a36:	6a 01                	push   $0x1
80105a38:	e8 33 f7 ff ff       	call   80105170 <argint>
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	85 c0                	test   %eax,%eax
80105a42:	0f 88 04 01 00 00    	js     80105b4c <sys_open+0x13c>
    return -1;

  begin_op();
80105a48:	e8 53 d8 ff ff       	call   801032a0 <begin_op>

  if(omode & O_CREATE){
80105a4d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105a51:	0f 85 a9 00 00 00    	jne    80105b00 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105a57:	83 ec 0c             	sub    $0xc,%esp
80105a5a:	ff 75 e0             	pushl  -0x20(%ebp)
80105a5d:	e8 de c5 ff ff       	call   80102040 <namei>
80105a62:	83 c4 10             	add    $0x10,%esp
80105a65:	85 c0                	test   %eax,%eax
80105a67:	89 c6                	mov    %eax,%esi
80105a69:	0f 84 ac 00 00 00    	je     80105b1b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
80105a6f:	83 ec 0c             	sub    $0xc,%esp
80105a72:	50                   	push   %eax
80105a73:	e8 68 bd ff ff       	call   801017e0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105a80:	0f 84 aa 00 00 00    	je     80105b30 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105a86:	e8 55 b4 ff ff       	call   80100ee0 <filealloc>
80105a8b:	85 c0                	test   %eax,%eax
80105a8d:	89 c7                	mov    %eax,%edi
80105a8f:	0f 84 a6 00 00 00    	je     80105b3b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105a95:	e8 f6 e4 ff ff       	call   80103f90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105a9a:	31 db                	xor    %ebx,%ebx
80105a9c:	eb 0e                	jmp    80105aac <sys_open+0x9c>
80105a9e:	66 90                	xchg   %ax,%ax
80105aa0:	83 c3 01             	add    $0x1,%ebx
80105aa3:	83 fb 10             	cmp    $0x10,%ebx
80105aa6:	0f 84 ac 00 00 00    	je     80105b58 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105aac:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105ab0:	85 d2                	test   %edx,%edx
80105ab2:	75 ec                	jne    80105aa0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ab4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105ab7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105abb:	56                   	push   %esi
80105abc:	e8 ff bd ff ff       	call   801018c0 <iunlock>
  end_op();
80105ac1:	e8 4a d8 ff ff       	call   80103310 <end_op>

  f->type = FD_INODE;
80105ac6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105acc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105acf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105ad2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105ad5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105adc:	89 d0                	mov    %edx,%eax
80105ade:	f7 d0                	not    %eax
80105ae0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ae3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105ae6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105ae9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105aed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105af0:	89 d8                	mov    %ebx,%eax
80105af2:	5b                   	pop    %ebx
80105af3:	5e                   	pop    %esi
80105af4:	5f                   	pop    %edi
80105af5:	5d                   	pop    %ebp
80105af6:	c3                   	ret    
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105b00:	6a 00                	push   $0x0
80105b02:	6a 00                	push   $0x0
80105b04:	6a 02                	push   $0x2
80105b06:	ff 75 e0             	pushl  -0x20(%ebp)
80105b09:	e8 52 fd ff ff       	call   80105860 <create>
    if(ip == 0){
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105b13:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105b15:	0f 85 6b ff ff ff    	jne    80105a86 <sys_open+0x76>
      end_op();
80105b1b:	e8 f0 d7 ff ff       	call   80103310 <end_op>
      return -1;
80105b20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b25:	eb c6                	jmp    80105aed <sys_open+0xdd>
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105b33:	85 c9                	test   %ecx,%ecx
80105b35:	0f 84 4b ff ff ff    	je     80105a86 <sys_open+0x76>
    iunlockput(ip);
80105b3b:	83 ec 0c             	sub    $0xc,%esp
80105b3e:	56                   	push   %esi
80105b3f:	e8 2c bf ff ff       	call   80101a70 <iunlockput>
    end_op();
80105b44:	e8 c7 d7 ff ff       	call   80103310 <end_op>
    return -1;
80105b49:	83 c4 10             	add    $0x10,%esp
80105b4c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b51:	eb 9a                	jmp    80105aed <sys_open+0xdd>
80105b53:	90                   	nop
80105b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105b58:	83 ec 0c             	sub    $0xc,%esp
80105b5b:	57                   	push   %edi
80105b5c:	e8 3f b4 ff ff       	call   80100fa0 <fileclose>
80105b61:	83 c4 10             	add    $0x10,%esp
80105b64:	eb d5                	jmp    80105b3b <sys_open+0x12b>
80105b66:	8d 76 00             	lea    0x0(%esi),%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b70 <sys_mkdir>:

int
sys_mkdir(void)
{
80105b70:	55                   	push   %ebp
80105b71:	89 e5                	mov    %esp,%ebp
80105b73:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105b76:	e8 25 d7 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105b7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b7e:	83 ec 08             	sub    $0x8,%esp
80105b81:	50                   	push   %eax
80105b82:	6a 00                	push   $0x0
80105b84:	e8 97 f6 ff ff       	call   80105220 <argstr>
80105b89:	83 c4 10             	add    $0x10,%esp
80105b8c:	85 c0                	test   %eax,%eax
80105b8e:	78 30                	js     80105bc0 <sys_mkdir+0x50>
80105b90:	6a 00                	push   $0x0
80105b92:	6a 00                	push   $0x0
80105b94:	6a 01                	push   $0x1
80105b96:	ff 75 f4             	pushl  -0xc(%ebp)
80105b99:	e8 c2 fc ff ff       	call   80105860 <create>
80105b9e:	83 c4 10             	add    $0x10,%esp
80105ba1:	85 c0                	test   %eax,%eax
80105ba3:	74 1b                	je     80105bc0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105ba5:	83 ec 0c             	sub    $0xc,%esp
80105ba8:	50                   	push   %eax
80105ba9:	e8 c2 be ff ff       	call   80101a70 <iunlockput>
  end_op();
80105bae:	e8 5d d7 ff ff       	call   80103310 <end_op>
  return 0;
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	31 c0                	xor    %eax,%eax
}
80105bb8:	c9                   	leave  
80105bb9:	c3                   	ret    
80105bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105bc0:	e8 4b d7 ff ff       	call   80103310 <end_op>
    return -1;
80105bc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bca:	c9                   	leave  
80105bcb:	c3                   	ret    
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105bd0 <sys_mknod>:

int
sys_mknod(void)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105bd6:	e8 c5 d6 ff ff       	call   801032a0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105bdb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105bde:	83 ec 08             	sub    $0x8,%esp
80105be1:	50                   	push   %eax
80105be2:	6a 00                	push   $0x0
80105be4:	e8 37 f6 ff ff       	call   80105220 <argstr>
80105be9:	83 c4 10             	add    $0x10,%esp
80105bec:	85 c0                	test   %eax,%eax
80105bee:	78 60                	js     80105c50 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105bf0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bf3:	83 ec 08             	sub    $0x8,%esp
80105bf6:	50                   	push   %eax
80105bf7:	6a 01                	push   $0x1
80105bf9:	e8 72 f5 ff ff       	call   80105170 <argint>
  if((argstr(0, &path)) < 0 ||
80105bfe:	83 c4 10             	add    $0x10,%esp
80105c01:	85 c0                	test   %eax,%eax
80105c03:	78 4b                	js     80105c50 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105c05:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c08:	83 ec 08             	sub    $0x8,%esp
80105c0b:	50                   	push   %eax
80105c0c:	6a 02                	push   $0x2
80105c0e:	e8 5d f5 ff ff       	call   80105170 <argint>
     argint(1, &major) < 0 ||
80105c13:	83 c4 10             	add    $0x10,%esp
80105c16:	85 c0                	test   %eax,%eax
80105c18:	78 36                	js     80105c50 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105c1a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105c1e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105c1f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105c23:	50                   	push   %eax
80105c24:	6a 03                	push   $0x3
80105c26:	ff 75 ec             	pushl  -0x14(%ebp)
80105c29:	e8 32 fc ff ff       	call   80105860 <create>
80105c2e:	83 c4 10             	add    $0x10,%esp
80105c31:	85 c0                	test   %eax,%eax
80105c33:	74 1b                	je     80105c50 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105c35:	83 ec 0c             	sub    $0xc,%esp
80105c38:	50                   	push   %eax
80105c39:	e8 32 be ff ff       	call   80101a70 <iunlockput>
  end_op();
80105c3e:	e8 cd d6 ff ff       	call   80103310 <end_op>
  return 0;
80105c43:	83 c4 10             	add    $0x10,%esp
80105c46:	31 c0                	xor    %eax,%eax
}
80105c48:	c9                   	leave  
80105c49:	c3                   	ret    
80105c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105c50:	e8 bb d6 ff ff       	call   80103310 <end_op>
    return -1;
80105c55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c5a:	c9                   	leave  
80105c5b:	c3                   	ret    
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c60 <sys_chdir>:

int
sys_chdir(void)
{
80105c60:	55                   	push   %ebp
80105c61:	89 e5                	mov    %esp,%ebp
80105c63:	56                   	push   %esi
80105c64:	53                   	push   %ebx
80105c65:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105c68:	e8 23 e3 ff ff       	call   80103f90 <myproc>
80105c6d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105c6f:	e8 2c d6 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105c74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c77:	83 ec 08             	sub    $0x8,%esp
80105c7a:	50                   	push   %eax
80105c7b:	6a 00                	push   $0x0
80105c7d:	e8 9e f5 ff ff       	call   80105220 <argstr>
80105c82:	83 c4 10             	add    $0x10,%esp
80105c85:	85 c0                	test   %eax,%eax
80105c87:	78 77                	js     80105d00 <sys_chdir+0xa0>
80105c89:	83 ec 0c             	sub    $0xc,%esp
80105c8c:	ff 75 f4             	pushl  -0xc(%ebp)
80105c8f:	e8 ac c3 ff ff       	call   80102040 <namei>
80105c94:	83 c4 10             	add    $0x10,%esp
80105c97:	85 c0                	test   %eax,%eax
80105c99:	89 c3                	mov    %eax,%ebx
80105c9b:	74 63                	je     80105d00 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105c9d:	83 ec 0c             	sub    $0xc,%esp
80105ca0:	50                   	push   %eax
80105ca1:	e8 3a bb ff ff       	call   801017e0 <ilock>
  if(ip->type != T_DIR){
80105ca6:	83 c4 10             	add    $0x10,%esp
80105ca9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cae:	75 30                	jne    80105ce0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105cb0:	83 ec 0c             	sub    $0xc,%esp
80105cb3:	53                   	push   %ebx
80105cb4:	e8 07 bc ff ff       	call   801018c0 <iunlock>
  iput(curproc->cwd);
80105cb9:	58                   	pop    %eax
80105cba:	ff 76 68             	pushl  0x68(%esi)
80105cbd:	e8 4e bc ff ff       	call   80101910 <iput>
  end_op();
80105cc2:	e8 49 d6 ff ff       	call   80103310 <end_op>
  curproc->cwd = ip;
80105cc7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	31 c0                	xor    %eax,%eax
}
80105ccf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105cd2:	5b                   	pop    %ebx
80105cd3:	5e                   	pop    %esi
80105cd4:	5d                   	pop    %ebp
80105cd5:	c3                   	ret    
80105cd6:	8d 76 00             	lea    0x0(%esi),%esi
80105cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105ce0:	83 ec 0c             	sub    $0xc,%esp
80105ce3:	53                   	push   %ebx
80105ce4:	e8 87 bd ff ff       	call   80101a70 <iunlockput>
    end_op();
80105ce9:	e8 22 d6 ff ff       	call   80103310 <end_op>
    return -1;
80105cee:	83 c4 10             	add    $0x10,%esp
80105cf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cf6:	eb d7                	jmp    80105ccf <sys_chdir+0x6f>
80105cf8:	90                   	nop
80105cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105d00:	e8 0b d6 ff ff       	call   80103310 <end_op>
    return -1;
80105d05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d0a:	eb c3                	jmp    80105ccf <sys_chdir+0x6f>
80105d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_exec>:

int
sys_exec(void)
{
80105d10:	55                   	push   %ebp
80105d11:	89 e5                	mov    %esp,%ebp
80105d13:	57                   	push   %edi
80105d14:	56                   	push   %esi
80105d15:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105d16:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105d1c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105d22:	50                   	push   %eax
80105d23:	6a 00                	push   $0x0
80105d25:	e8 f6 f4 ff ff       	call   80105220 <argstr>
80105d2a:	83 c4 10             	add    $0x10,%esp
80105d2d:	85 c0                	test   %eax,%eax
80105d2f:	0f 88 87 00 00 00    	js     80105dbc <sys_exec+0xac>
80105d35:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105d3b:	83 ec 08             	sub    $0x8,%esp
80105d3e:	50                   	push   %eax
80105d3f:	6a 01                	push   $0x1
80105d41:	e8 2a f4 ff ff       	call   80105170 <argint>
80105d46:	83 c4 10             	add    $0x10,%esp
80105d49:	85 c0                	test   %eax,%eax
80105d4b:	78 6f                	js     80105dbc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105d4d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105d53:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105d56:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105d58:	68 80 00 00 00       	push   $0x80
80105d5d:	6a 00                	push   $0x0
80105d5f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105d65:	50                   	push   %eax
80105d66:	e8 05 f1 ff ff       	call   80104e70 <memset>
80105d6b:	83 c4 10             	add    $0x10,%esp
80105d6e:	eb 2c                	jmp    80105d9c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105d70:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105d76:	85 c0                	test   %eax,%eax
80105d78:	74 56                	je     80105dd0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105d7a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105d80:	83 ec 08             	sub    $0x8,%esp
80105d83:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105d86:	52                   	push   %edx
80105d87:	50                   	push   %eax
80105d88:	e8 73 f3 ff ff       	call   80105100 <fetchstr>
80105d8d:	83 c4 10             	add    $0x10,%esp
80105d90:	85 c0                	test   %eax,%eax
80105d92:	78 28                	js     80105dbc <sys_exec+0xac>
  for(i=0;; i++){
80105d94:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105d97:	83 fb 20             	cmp    $0x20,%ebx
80105d9a:	74 20                	je     80105dbc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105d9c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105da2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105da9:	83 ec 08             	sub    $0x8,%esp
80105dac:	57                   	push   %edi
80105dad:	01 f0                	add    %esi,%eax
80105daf:	50                   	push   %eax
80105db0:	e8 0b f3 ff ff       	call   801050c0 <fetchint>
80105db5:	83 c4 10             	add    $0x10,%esp
80105db8:	85 c0                	test   %eax,%eax
80105dba:	79 b4                	jns    80105d70 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105dbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105dbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105dc4:	5b                   	pop    %ebx
80105dc5:	5e                   	pop    %esi
80105dc6:	5f                   	pop    %edi
80105dc7:	5d                   	pop    %ebp
80105dc8:	c3                   	ret    
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105dd0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105dd6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105dd9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105de0:	00 00 00 00 
  return exec(path, argv);
80105de4:	50                   	push   %eax
80105de5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105deb:	e8 20 ac ff ff       	call   80100a10 <exec>
80105df0:	83 c4 10             	add    $0x10,%esp
}
80105df3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105df6:	5b                   	pop    %ebx
80105df7:	5e                   	pop    %esi
80105df8:	5f                   	pop    %edi
80105df9:	5d                   	pop    %ebp
80105dfa:	c3                   	ret    
80105dfb:	90                   	nop
80105dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e00 <sys_pipe>:

int
sys_pipe(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	57                   	push   %edi
80105e04:	56                   	push   %esi
80105e05:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105e06:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105e09:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105e0c:	6a 08                	push   $0x8
80105e0e:	50                   	push   %eax
80105e0f:	6a 00                	push   $0x0
80105e11:	e8 aa f3 ff ff       	call   801051c0 <argptr>
80105e16:	83 c4 10             	add    $0x10,%esp
80105e19:	85 c0                	test   %eax,%eax
80105e1b:	0f 88 ae 00 00 00    	js     80105ecf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105e21:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e24:	83 ec 08             	sub    $0x8,%esp
80105e27:	50                   	push   %eax
80105e28:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105e2b:	50                   	push   %eax
80105e2c:	e8 0f db ff ff       	call   80103940 <pipealloc>
80105e31:	83 c4 10             	add    $0x10,%esp
80105e34:	85 c0                	test   %eax,%eax
80105e36:	0f 88 93 00 00 00    	js     80105ecf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105e3c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105e3f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105e41:	e8 4a e1 ff ff       	call   80103f90 <myproc>
80105e46:	eb 10                	jmp    80105e58 <sys_pipe+0x58>
80105e48:	90                   	nop
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105e50:	83 c3 01             	add    $0x1,%ebx
80105e53:	83 fb 10             	cmp    $0x10,%ebx
80105e56:	74 60                	je     80105eb8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105e58:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105e5c:	85 f6                	test   %esi,%esi
80105e5e:	75 f0                	jne    80105e50 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105e60:	8d 73 08             	lea    0x8(%ebx),%esi
80105e63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105e67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105e6a:	e8 21 e1 ff ff       	call   80103f90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105e6f:	31 d2                	xor    %edx,%edx
80105e71:	eb 0d                	jmp    80105e80 <sys_pipe+0x80>
80105e73:	90                   	nop
80105e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e78:	83 c2 01             	add    $0x1,%edx
80105e7b:	83 fa 10             	cmp    $0x10,%edx
80105e7e:	74 28                	je     80105ea8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105e80:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105e84:	85 c9                	test   %ecx,%ecx
80105e86:	75 f0                	jne    80105e78 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105e88:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105e8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e8f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105e91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105e94:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105e97:	31 c0                	xor    %eax,%eax
}
80105e99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e9c:	5b                   	pop    %ebx
80105e9d:	5e                   	pop    %esi
80105e9e:	5f                   	pop    %edi
80105e9f:	5d                   	pop    %ebp
80105ea0:	c3                   	ret    
80105ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105ea8:	e8 e3 e0 ff ff       	call   80103f90 <myproc>
80105ead:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105eb4:	00 
80105eb5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105eb8:	83 ec 0c             	sub    $0xc,%esp
80105ebb:	ff 75 e0             	pushl  -0x20(%ebp)
80105ebe:	e8 dd b0 ff ff       	call   80100fa0 <fileclose>
    fileclose(wf);
80105ec3:	58                   	pop    %eax
80105ec4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105ec7:	e8 d4 b0 ff ff       	call   80100fa0 <fileclose>
    return -1;
80105ecc:	83 c4 10             	add    $0x10,%esp
80105ecf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ed4:	eb c3                	jmp    80105e99 <sys_pipe+0x99>
80105ed6:	66 90                	xchg   %ax,%ax
80105ed8:	66 90                	xchg   %ax,%ax
80105eda:	66 90                	xchg   %ax,%ax
80105edc:	66 90                	xchg   %ax,%ax
80105ede:	66 90                	xchg   %ax,%ax

80105ee0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105ee3:	5d                   	pop    %ebp
  return fork();
80105ee4:	e9 67 e2 ff ff       	jmp    80104150 <fork>
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ef0 <sys_exit>:

int
sys_exit(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ef6:	e8 c5 e5 ff ff       	call   801044c0 <exit>
  return 0;  // not reached
}
80105efb:	31 c0                	xor    %eax,%eax
80105efd:	c9                   	leave  
80105efe:	c3                   	ret    
80105eff:	90                   	nop

80105f00 <sys_wait>:

int
sys_wait(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105f03:	5d                   	pop    %ebp
  return wait();
80105f04:	e9 27 e8 ff ff       	jmp    80104730 <wait>
80105f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f10 <sys_kill>:

int
sys_kill(void)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105f16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f19:	50                   	push   %eax
80105f1a:	6a 00                	push   $0x0
80105f1c:	e8 4f f2 ff ff       	call   80105170 <argint>
80105f21:	83 c4 10             	add    $0x10,%esp
80105f24:	85 c0                	test   %eax,%eax
80105f26:	78 18                	js     80105f40 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105f28:	83 ec 0c             	sub    $0xc,%esp
80105f2b:	ff 75 f4             	pushl  -0xc(%ebp)
80105f2e:	e8 5d e9 ff ff       	call   80104890 <kill>
80105f33:	83 c4 10             	add    $0x10,%esp
}
80105f36:	c9                   	leave  
80105f37:	c3                   	ret    
80105f38:	90                   	nop
80105f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f45:	c9                   	leave  
80105f46:	c3                   	ret    
80105f47:	89 f6                	mov    %esi,%esi
80105f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f50 <sys_getpid>:

int
sys_getpid(void)
{
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105f56:	e8 35 e0 ff ff       	call   80103f90 <myproc>
80105f5b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105f5e:	c9                   	leave  
80105f5f:	c3                   	ret    

80105f60 <sys_sbrk>:

int
sys_sbrk(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
80105f64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f6a:	50                   	push   %eax
80105f6b:	6a 00                	push   $0x0
80105f6d:	e8 fe f1 ff ff       	call   80105170 <argint>
80105f72:	83 c4 10             	add    $0x10,%esp
80105f75:	85 c0                	test   %eax,%eax
80105f77:	78 27                	js     80105fa0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105f79:	e8 12 e0 ff ff       	call   80103f90 <myproc>
  if(growproc(n) < 0)
80105f7e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105f81:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105f83:	ff 75 f4             	pushl  -0xc(%ebp)
80105f86:	e8 45 e1 ff ff       	call   801040d0 <growproc>
80105f8b:	83 c4 10             	add    $0x10,%esp
80105f8e:	85 c0                	test   %eax,%eax
80105f90:	78 0e                	js     80105fa0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105f92:	89 d8                	mov    %ebx,%eax
80105f94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f97:	c9                   	leave  
80105f98:	c3                   	ret    
80105f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105fa0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fa5:	eb eb                	jmp    80105f92 <sys_sbrk+0x32>
80105fa7:	89 f6                	mov    %esi,%esi
80105fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fb0 <sys_sleep>:

int
sys_sleep(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
80105fb3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105fb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105fb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105fba:	50                   	push   %eax
80105fbb:	6a 00                	push   $0x0
80105fbd:	e8 ae f1 ff ff       	call   80105170 <argint>
80105fc2:	83 c4 10             	add    $0x10,%esp
80105fc5:	85 c0                	test   %eax,%eax
80105fc7:	0f 88 8a 00 00 00    	js     80106057 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105fcd:	83 ec 0c             	sub    $0xc,%esp
80105fd0:	68 80 a1 15 80       	push   $0x8015a180
80105fd5:	e8 86 ed ff ff       	call   80104d60 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105fda:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105fdd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105fe0:	8b 1d c0 a9 15 80    	mov    0x8015a9c0,%ebx
  while(ticks - ticks0 < n){
80105fe6:	85 d2                	test   %edx,%edx
80105fe8:	75 27                	jne    80106011 <sys_sleep+0x61>
80105fea:	eb 54                	jmp    80106040 <sys_sleep+0x90>
80105fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ff0:	83 ec 08             	sub    $0x8,%esp
80105ff3:	68 80 a1 15 80       	push   $0x8015a180
80105ff8:	68 c0 a9 15 80       	push   $0x8015a9c0
80105ffd:	e8 6e e6 ff ff       	call   80104670 <sleep>
  while(ticks - ticks0 < n){
80106002:	a1 c0 a9 15 80       	mov    0x8015a9c0,%eax
80106007:	83 c4 10             	add    $0x10,%esp
8010600a:	29 d8                	sub    %ebx,%eax
8010600c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010600f:	73 2f                	jae    80106040 <sys_sleep+0x90>
    if(myproc()->killed){
80106011:	e8 7a df ff ff       	call   80103f90 <myproc>
80106016:	8b 40 24             	mov    0x24(%eax),%eax
80106019:	85 c0                	test   %eax,%eax
8010601b:	74 d3                	je     80105ff0 <sys_sleep+0x40>
      release(&tickslock);
8010601d:	83 ec 0c             	sub    $0xc,%esp
80106020:	68 80 a1 15 80       	push   $0x8015a180
80106025:	e8 f6 ed ff ff       	call   80104e20 <release>
      return -1;
8010602a:	83 c4 10             	add    $0x10,%esp
8010602d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106032:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106035:	c9                   	leave  
80106036:	c3                   	ret    
80106037:	89 f6                	mov    %esi,%esi
80106039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106040:	83 ec 0c             	sub    $0xc,%esp
80106043:	68 80 a1 15 80       	push   $0x8015a180
80106048:	e8 d3 ed ff ff       	call   80104e20 <release>
  return 0;
8010604d:	83 c4 10             	add    $0x10,%esp
80106050:	31 c0                	xor    %eax,%eax
}
80106052:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106055:	c9                   	leave  
80106056:	c3                   	ret    
    return -1;
80106057:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010605c:	eb f4                	jmp    80106052 <sys_sleep+0xa2>
8010605e:	66 90                	xchg   %ax,%ax

80106060 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	53                   	push   %ebx
80106064:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106067:	68 80 a1 15 80       	push   $0x8015a180
8010606c:	e8 ef ec ff ff       	call   80104d60 <acquire>
  xticks = ticks;
80106071:	8b 1d c0 a9 15 80    	mov    0x8015a9c0,%ebx
  release(&tickslock);
80106077:	c7 04 24 80 a1 15 80 	movl   $0x8015a180,(%esp)
8010607e:	e8 9d ed ff ff       	call   80104e20 <release>
  return xticks;
}
80106083:	89 d8                	mov    %ebx,%eax
80106085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106088:	c9                   	leave  
80106089:	c3                   	ret    
8010608a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106090 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
80106090:	55                   	push   %ebp
80106091:	89 e5                	mov    %esp,%ebp
  return numFreePages();
80106093:	5d                   	pop    %ebp
  return numFreePages();
80106094:	e9 37 ca ff ff       	jmp    80102ad0 <numFreePages>

80106099 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106099:	1e                   	push   %ds
  pushl %es
8010609a:	06                   	push   %es
  pushl %fs
8010609b:	0f a0                	push   %fs
  pushl %gs
8010609d:	0f a8                	push   %gs
  pushal
8010609f:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801060a0:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801060a4:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801060a6:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801060a8:	54                   	push   %esp
  call trap
801060a9:	e8 c2 00 00 00       	call   80106170 <trap>
  addl $4, %esp
801060ae:	83 c4 04             	add    $0x4,%esp

801060b1 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801060b1:	61                   	popa   
  popl %gs
801060b2:	0f a9                	pop    %gs
  popl %fs
801060b4:	0f a1                	pop    %fs
  popl %es
801060b6:	07                   	pop    %es
  popl %ds
801060b7:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801060b8:	83 c4 08             	add    $0x8,%esp
  iret
801060bb:	cf                   	iret   
801060bc:	66 90                	xchg   %ax,%ax
801060be:	66 90                	xchg   %ax,%ax

801060c0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801060c0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801060c1:	31 c0                	xor    %eax,%eax
{
801060c3:	89 e5                	mov    %esp,%ebp
801060c5:	83 ec 08             	sub    $0x8,%esp
801060c8:	90                   	nop
801060c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801060d0:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
801060d7:	c7 04 c5 c2 a1 15 80 	movl   $0x8e000008,-0x7fea5e3e(,%eax,8)
801060de:	08 00 00 8e 
801060e2:	66 89 14 c5 c0 a1 15 	mov    %dx,-0x7fea5e40(,%eax,8)
801060e9:	80 
801060ea:	c1 ea 10             	shr    $0x10,%edx
801060ed:	66 89 14 c5 c6 a1 15 	mov    %dx,-0x7fea5e3a(,%eax,8)
801060f4:	80 
  for(i = 0; i < 256; i++)
801060f5:	83 c0 01             	add    $0x1,%eax
801060f8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060fd:	75 d1                	jne    801060d0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060ff:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106104:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106107:	c7 05 c2 a3 15 80 08 	movl   $0xef000008,0x8015a3c2
8010610e:	00 00 ef 
  initlock(&tickslock, "time");
80106111:	68 99 8f 10 80       	push   $0x80108f99
80106116:	68 80 a1 15 80       	push   $0x8015a180
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010611b:	66 a3 c0 a3 15 80    	mov    %ax,0x8015a3c0
80106121:	c1 e8 10             	shr    $0x10,%eax
80106124:	66 a3 c6 a3 15 80    	mov    %ax,0x8015a3c6
  initlock(&tickslock, "time");
8010612a:	e8 f1 ea ff ff       	call   80104c20 <initlock>
}
8010612f:	83 c4 10             	add    $0x10,%esp
80106132:	c9                   	leave  
80106133:	c3                   	ret    
80106134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010613a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106140 <idtinit>:

void
idtinit(void)
{
80106140:	55                   	push   %ebp
  pd[0] = size-1;
80106141:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106146:	89 e5                	mov    %esp,%ebp
80106148:	83 ec 10             	sub    $0x10,%esp
8010614b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010614f:	b8 c0 a1 15 80       	mov    $0x8015a1c0,%eax
80106154:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106158:	c1 e8 10             	shr    $0x10,%eax
8010615b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010615f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106162:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106165:	c9                   	leave  
80106166:	c3                   	ret    
80106167:	89 f6                	mov    %esi,%esi
80106169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106170 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	57                   	push   %edi
80106174:	56                   	push   %esi
80106175:	53                   	push   %ebx
80106176:	83 ec 1c             	sub    $0x1c,%esp
80106179:	8b 7d 08             	mov    0x8(%ebp),%edi
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
8010617c:	8b 47 30             	mov    0x30(%edi),%eax
8010617f:	83 f8 40             	cmp    $0x40,%eax
80106182:	0f 84 f0 00 00 00    	je     80106278 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106188:	83 e8 0e             	sub    $0xe,%eax
8010618b:	83 f8 31             	cmp    $0x31,%eax
8010618e:	77 10                	ja     801061a0 <trap+0x30>
80106190:	ff 24 85 74 90 10 80 	jmp    *-0x7fef6f8c(,%eax,4)
80106197:	89 f6                	mov    %esi,%esi
80106199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi



  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801061a0:	e8 eb dd ff ff       	call   80103f90 <myproc>
801061a5:	85 c0                	test   %eax,%eax
801061a7:	8b 5f 38             	mov    0x38(%edi),%ebx
801061aa:	0f 84 d1 03 00 00    	je     80106581 <trap+0x411>
801061b0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801061b4:	0f 84 c7 03 00 00    	je     80106581 <trap+0x411>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801061ba:	0f 20 d1             	mov    %cr2,%ecx
801061bd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061c0:	e8 ab dd ff ff       	call   80103f70 <cpuid>
801061c5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801061c8:	8b 47 34             	mov    0x34(%edi),%eax
801061cb:	8b 77 30             	mov    0x30(%edi),%esi
801061ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801061d1:	e8 ba dd ff ff       	call   80103f90 <myproc>
801061d6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061d9:	e8 b2 dd ff ff       	call   80103f90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061de:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061e1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061e4:	51                   	push   %ecx
801061e5:	53                   	push   %ebx
801061e6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801061e7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061ea:	ff 75 e4             	pushl  -0x1c(%ebp)
801061ed:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801061ee:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801061f1:	52                   	push   %edx
801061f2:	ff 70 10             	pushl  0x10(%eax)
801061f5:	68 30 90 10 80       	push   $0x80109030
801061fa:	e8 61 a4 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801061ff:	83 c4 20             	add    $0x20,%esp
80106202:	e8 89 dd ff ff       	call   80103f90 <myproc>
80106207:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010620e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106210:	e8 7b dd ff ff       	call   80103f90 <myproc>
80106215:	85 c0                	test   %eax,%eax
80106217:	74 1d                	je     80106236 <trap+0xc6>
80106219:	e8 72 dd ff ff       	call   80103f90 <myproc>
8010621e:	8b 50 24             	mov    0x24(%eax),%edx
80106221:	85 d2                	test   %edx,%edx
80106223:	74 11                	je     80106236 <trap+0xc6>
80106225:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106229:	83 e0 03             	and    $0x3,%eax
8010622c:	66 83 f8 03          	cmp    $0x3,%ax
80106230:	0f 84 6a 02 00 00    	je     801064a0 <trap+0x330>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106236:	e8 55 dd ff ff       	call   80103f90 <myproc>
8010623b:	85 c0                	test   %eax,%eax
8010623d:	74 0b                	je     8010624a <trap+0xda>
8010623f:	e8 4c dd ff ff       	call   80103f90 <myproc>
80106244:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106248:	74 66                	je     801062b0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010624a:	e8 41 dd ff ff       	call   80103f90 <myproc>
8010624f:	85 c0                	test   %eax,%eax
80106251:	74 19                	je     8010626c <trap+0xfc>
80106253:	e8 38 dd ff ff       	call   80103f90 <myproc>
80106258:	8b 40 24             	mov    0x24(%eax),%eax
8010625b:	85 c0                	test   %eax,%eax
8010625d:	74 0d                	je     8010626c <trap+0xfc>
8010625f:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106263:	83 e0 03             	and    $0x3,%eax
80106266:	66 83 f8 03          	cmp    $0x3,%ax
8010626a:	74 35                	je     801062a1 <trap+0x131>
    exit();
}
8010626c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010626f:	5b                   	pop    %ebx
80106270:	5e                   	pop    %esi
80106271:	5f                   	pop    %edi
80106272:	5d                   	pop    %ebp
80106273:	c3                   	ret    
80106274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106278:	e8 13 dd ff ff       	call   80103f90 <myproc>
8010627d:	8b 70 24             	mov    0x24(%eax),%esi
80106280:	85 f6                	test   %esi,%esi
80106282:	0f 85 f8 01 00 00    	jne    80106480 <trap+0x310>
    myproc()->tf = tf;
80106288:	e8 03 dd ff ff       	call   80103f90 <myproc>
8010628d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106290:	e8 cb ef ff ff       	call   80105260 <syscall>
    if(myproc()->killed)
80106295:	e8 f6 dc ff ff       	call   80103f90 <myproc>
8010629a:	8b 58 24             	mov    0x24(%eax),%ebx
8010629d:	85 db                	test   %ebx,%ebx
8010629f:	74 cb                	je     8010626c <trap+0xfc>
}
801062a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062a4:	5b                   	pop    %ebx
801062a5:	5e                   	pop    %esi
801062a6:	5f                   	pop    %edi
801062a7:	5d                   	pop    %ebp
      exit();
801062a8:	e9 13 e2 ff ff       	jmp    801044c0 <exit>
801062ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801062b0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801062b4:	75 94                	jne    8010624a <trap+0xda>
    yield();
801062b6:	e8 65 e3 ff ff       	call   80104620 <yield>
801062bb:	eb 8d                	jmp    8010624a <trap+0xda>
801062bd:	8d 76 00             	lea    0x0(%esi),%esi
        nfuaTickUpdate();
801062c0:	e8 2b e7 ff ff       	call   801049f0 <nfuaTickUpdate>
801062c5:	0f 20 d3             	mov    %cr2,%ebx
      pte_t *pte = walkpgdir(myproc()->pgdir,(char*)addr,0);
801062c8:	e8 c3 dc ff ff       	call   80103f90 <myproc>
  if(*pde & PTE_P){
801062cd:	8b 40 04             	mov    0x4(%eax),%eax
  pde = &pgdir[PDX(va)];
801062d0:	89 da                	mov    %ebx,%edx
801062d2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801062d5:	8b 04 90             	mov    (%eax,%edx,4),%eax
801062d8:	a8 01                	test   $0x1,%al
801062da:	0f 84 b0 01 00 00    	je     80106490 <trap+0x320>
  return &pgtab[PTX(va)];
801062e0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801062e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      uint refCount = getReferenceCount(pa);
801062e7:	83 ec 0c             	sub    $0xc,%esp
  return &pgtab[PTX(va)];
801062ea:	c1 ea 0a             	shr    $0xa,%edx
801062ed:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801062f3:	8d b4 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%esi
      uint pa = PTE_ADDR(*pte);
801062fa:	8b 06                	mov    (%esi),%eax
  return &pgtab[PTX(va)];
801062fc:	89 75 e0             	mov    %esi,-0x20(%ebp)
      uint pa = PTE_ADDR(*pte);
801062ff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      uint refCount = getReferenceCount(pa);
80106304:	50                   	push   %eax
      uint pa = PTE_ADDR(*pte);
80106305:	89 45 dc             	mov    %eax,-0x24(%ebp)
      uint refCount = getReferenceCount(pa);
80106308:	e8 d3 c8 ff ff       	call   80102be0 <getReferenceCount>
8010630d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(((*pte & PTE_W) == 0) && ((*pte & PTE_PG) == 0)) {
80106310:	8b 06                	mov    (%esi),%eax
80106312:	83 c4 10             	add    $0x10,%esp
80106315:	a9 02 02 00 00       	test   $0x202,%eax
8010631a:	0f 85 90 01 00 00    	jne    801064b0 <trap+0x340>
        if((*pte & PTE_COW) != 0){
80106320:	f6 c4 08             	test   $0x8,%ah
80106323:	0f 84 b7 00 00 00    	je     801063e0 <trap+0x270>
          for(k = 0 ; k < MAX_PSYC_PAGES; k++){
80106329:	31 f6                	xor    %esi,%esi
8010632b:	eb 0b                	jmp    80106338 <trap+0x1c8>
8010632d:	8d 76 00             	lea    0x0(%esi),%esi
80106330:	83 c6 01             	add    $0x1,%esi
80106333:	83 fe 10             	cmp    $0x10,%esi
80106336:	74 41                	je     80106379 <trap+0x209>
            if(myproc()->physicalPGs[k].va == (char*)addr){
80106338:	e8 53 dc ff ff       	call   80103f90 <myproc>
8010633d:	8d 0c 76             	lea    (%esi,%esi,2),%ecx
80106340:	c1 e1 03             	shl    $0x3,%ecx
80106343:	39 9c 08 d0 01 00 00 	cmp    %ebx,0x1d0(%eax,%ecx,1)
8010634a:	75 e4                	jne    80106330 <trap+0x1c0>
8010634c:	89 4d d8             	mov    %ecx,-0x28(%ebp)
              if(myproc()->physicalPGs[k].alloceted == 0){
8010634f:	e8 3c dc ff ff       	call   80103f90 <myproc>
80106354:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106357:	8b 8c 08 dc 01 00 00 	mov    0x1dc(%eax,%ecx,1),%ecx
8010635e:	85 c9                	test   %ecx,%ecx
80106360:	0f 84 cf 01 00 00    	je     80106535 <trap+0x3c5>
              myproc()->physicalPGs[k].alloceted = 1;
80106366:	e8 25 dc ff ff       	call   80103f90 <myproc>
8010636b:	8d 14 76             	lea    (%esi,%esi,2),%edx
8010636e:	c7 84 d0 dc 01 00 00 	movl   $0x1,0x1dc(%eax,%edx,8)
80106375:	01 00 00 00 
          if(refCount > 1) {
80106379:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
8010637d:	0f 86 8d 01 00 00    	jbe    80106510 <trap+0x3a0>
            if((mem = kalloc()) == 0) {
80106383:	e8 b8 c6 ff ff       	call   80102a40 <kalloc>
80106388:	85 c0                	test   %eax,%eax
8010638a:	89 c3                	mov    %eax,%ebx
8010638c:	0f 84 bc 01 00 00    	je     8010654e <trap+0x3de>
            memmove(mem, (char*)P2V(pa), PGSIZE);
80106392:	8b 75 dc             	mov    -0x24(%ebp),%esi
80106395:	83 ec 04             	sub    $0x4,%esp
80106398:	68 00 10 00 00       	push   $0x1000
8010639d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801063a3:	50                   	push   %eax
801063a4:	53                   	push   %ebx
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
801063a5:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
            memmove(mem, (char*)P2V(pa), PGSIZE);
801063ab:	e8 70 eb ff ff       	call   80104f20 <memmove>
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
801063b0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801063b3:	8b 01                	mov    (%ecx),%eax
801063b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801063b8:	25 ff 0f 00 00       	and    $0xfff,%eax
801063bd:	83 c8 03             	or     $0x3,%eax
801063c0:	09 d8                	or     %ebx,%eax
801063c2:	89 01                	mov    %eax,(%ecx)
            lcr3(V2P(myproc()->pgdir));
801063c4:	e8 c7 db ff ff       	call   80103f90 <myproc>
801063c9:	8b 40 04             	mov    0x4(%eax),%eax
801063cc:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801063d1:	0f 22 d8             	mov    %eax,%cr3
            decrementReferenceCount(pa);
801063d4:	89 34 24             	mov    %esi,(%esp)
801063d7:	e8 44 c7 ff ff       	call   80102b20 <decrementReferenceCount>
801063dc:	83 c4 10             	add    $0x10,%esp
801063df:	90                   	nop
      lcr3(V2P(myproc()->pgdir));
801063e0:	e8 ab db ff ff       	call   80103f90 <myproc>
801063e5:	8b 40 04             	mov    0x4(%eax),%eax
801063e8:	05 00 00 00 80       	add    $0x80000000,%eax
801063ed:	0f 22 d8             	mov    %eax,%cr3
801063f0:	e9 1b fe ff ff       	jmp    80106210 <trap+0xa0>
801063f5:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801063f8:	e8 73 db ff ff       	call   80103f70 <cpuid>
801063fd:	85 c0                	test   %eax,%eax
801063ff:	0f 84 d3 00 00 00    	je     801064d8 <trap+0x368>
    lapiceoi();
80106405:	e8 46 ca ff ff       	call   80102e50 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010640a:	e8 81 db ff ff       	call   80103f90 <myproc>
8010640f:	85 c0                	test   %eax,%eax
80106411:	0f 85 02 fe ff ff    	jne    80106219 <trap+0xa9>
80106417:	e9 1a fe ff ff       	jmp    80106236 <trap+0xc6>
8010641c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106420:	e8 eb c8 ff ff       	call   80102d10 <kbdintr>
    lapiceoi();
80106425:	e8 26 ca ff ff       	call   80102e50 <lapiceoi>
    break;
8010642a:	e9 e1 fd ff ff       	jmp    80106210 <trap+0xa0>
8010642f:	90                   	nop
    uartintr();
80106430:	e8 eb 02 00 00       	call   80106720 <uartintr>
    lapiceoi();
80106435:	e8 16 ca ff ff       	call   80102e50 <lapiceoi>
    break;
8010643a:	e9 d1 fd ff ff       	jmp    80106210 <trap+0xa0>
8010643f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106440:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106444:	8b 77 38             	mov    0x38(%edi),%esi
80106447:	e8 24 db ff ff       	call   80103f70 <cpuid>
8010644c:	56                   	push   %esi
8010644d:	53                   	push   %ebx
8010644e:	50                   	push   %eax
8010644f:	68 a4 8f 10 80       	push   $0x80108fa4
80106454:	e8 07 a2 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106459:	e8 f2 c9 ff ff       	call   80102e50 <lapiceoi>
    break;
8010645e:	83 c4 10             	add    $0x10,%esp
80106461:	e9 aa fd ff ff       	jmp    80106210 <trap+0xa0>
80106466:	8d 76 00             	lea    0x0(%esi),%esi
80106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80106470:	e8 fb c0 ff ff       	call   80102570 <ideintr>
80106475:	eb 8e                	jmp    80106405 <trap+0x295>
80106477:	89 f6                	mov    %esi,%esi
80106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
80106480:	e8 3b e0 ff ff       	call   801044c0 <exit>
80106485:	e9 fe fd ff ff       	jmp    80106288 <trap+0x118>
8010648a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      uint pa = PTE_ADDR(*pte);
80106490:	a1 00 00 00 00       	mov    0x0,%eax
80106495:	0f 0b                	ud2    
80106497:	89 f6                	mov    %esi,%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    exit();
801064a0:	e8 1b e0 ff ff       	call   801044c0 <exit>
801064a5:	e9 8c fd ff ff       	jmp    80106236 <trap+0xc6>
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        swapPage(addr);
801064b0:	83 ec 0c             	sub    $0xc,%esp
801064b3:	53                   	push   %ebx
801064b4:	e8 b7 1e 00 00       	call   80108370 <swapPage>
        lcr3(V2P(myproc()->pgdir));
801064b9:	e8 d2 da ff ff       	call   80103f90 <myproc>
801064be:	8b 40 04             	mov    0x4(%eax),%eax
801064c1:	05 00 00 00 80       	add    $0x80000000,%eax
801064c6:	0f 22 d8             	mov    %eax,%cr3
801064c9:	83 c4 10             	add    $0x10,%esp
801064cc:	e9 0f ff ff ff       	jmp    801063e0 <trap+0x270>
801064d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      acquire(&tickslock);
801064d8:	83 ec 0c             	sub    $0xc,%esp
801064db:	68 80 a1 15 80       	push   $0x8015a180
801064e0:	e8 7b e8 ff ff       	call   80104d60 <acquire>
      wakeup(&ticks);
801064e5:	c7 04 24 c0 a9 15 80 	movl   $0x8015a9c0,(%esp)
      ticks++;
801064ec:	83 05 c0 a9 15 80 01 	addl   $0x1,0x8015a9c0
      wakeup(&ticks);
801064f3:	e8 38 e3 ff ff       	call   80104830 <wakeup>
      release(&tickslock);
801064f8:	c7 04 24 80 a1 15 80 	movl   $0x8015a180,(%esp)
801064ff:	e8 1c e9 ff ff       	call   80104e20 <release>
80106504:	83 c4 10             	add    $0x10,%esp
80106507:	e9 f9 fe ff ff       	jmp    80106405 <trap+0x295>
8010650c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            *pte &= ~PTE_COW;
80106510:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80106513:	8b 03                	mov    (%ebx),%eax
80106515:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106518:	80 e4 f7             	and    $0xf7,%ah
8010651b:	83 c8 02             	or     $0x2,%eax
8010651e:	89 03                	mov    %eax,(%ebx)
            lcr3(V2P(myproc()->pgdir));
80106520:	e8 6b da ff ff       	call   80103f90 <myproc>
80106525:	8b 40 04             	mov    0x4(%eax),%eax
80106528:	05 00 00 00 80       	add    $0x80000000,%eax
8010652d:	0f 22 d8             	mov    %eax,%cr3
80106530:	e9 ab fe ff ff       	jmp    801063e0 <trap+0x270>
                myproc()->allocatedInPhys++;
80106535:	e8 56 da ff ff       	call   80103f90 <myproc>
8010653a:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80106540:	83 c1 01             	add    $0x1,%ecx
80106543:	89 88 88 00 00 00    	mov    %ecx,0x88(%eax)
80106549:	e9 18 fe ff ff       	jmp    80106366 <trap+0x1f6>
              cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
8010654e:	e8 3d da ff ff       	call   80103f90 <myproc>
80106553:	8b 58 10             	mov    0x10(%eax),%ebx
80106556:	e8 35 da ff ff       	call   80103f90 <myproc>
8010655b:	83 ec 04             	sub    $0x4,%esp
8010655e:	83 c0 6c             	add    $0x6c,%eax
80106561:	53                   	push   %ebx
80106562:	50                   	push   %eax
80106563:	68 c8 8f 10 80       	push   $0x80108fc8
80106568:	e8 f3 a0 ff ff       	call   80100660 <cprintf>
              myproc()->killed = 1;
8010656d:	e8 1e da ff ff       	call   80103f90 <myproc>
              return;
80106572:	83 c4 10             	add    $0x10,%esp
              myproc()->killed = 1;
80106575:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
              return;
8010657c:	e9 eb fc ff ff       	jmp    8010626c <trap+0xfc>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106581:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106584:	e8 e7 d9 ff ff       	call   80103f70 <cpuid>
80106589:	83 ec 0c             	sub    $0xc,%esp
8010658c:	56                   	push   %esi
8010658d:	53                   	push   %ebx
8010658e:	50                   	push   %eax
8010658f:	ff 77 30             	pushl  0x30(%edi)
80106592:	68 fc 8f 10 80       	push   $0x80108ffc
80106597:	e8 c4 a0 ff ff       	call   80100660 <cprintf>
      panic("trap");
8010659c:	83 c4 14             	add    $0x14,%esp
8010659f:	68 9e 8f 10 80       	push   $0x80108f9e
801065a4:	e8 e7 9d ff ff       	call   80100390 <panic>
801065a9:	66 90                	xchg   %ax,%ax
801065ab:	66 90                	xchg   %ax,%ax
801065ad:	66 90                	xchg   %ax,%ax
801065af:	90                   	nop

801065b0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801065b0:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
801065b5:	55                   	push   %ebp
801065b6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801065b8:	85 c0                	test   %eax,%eax
801065ba:	74 1c                	je     801065d8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801065bc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801065c1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801065c2:	a8 01                	test   $0x1,%al
801065c4:	74 12                	je     801065d8 <uartgetc+0x28>
801065c6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065cb:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801065cc:	0f b6 c0             	movzbl %al,%eax
}
801065cf:	5d                   	pop    %ebp
801065d0:	c3                   	ret    
801065d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801065d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065dd:	5d                   	pop    %ebp
801065de:	c3                   	ret    
801065df:	90                   	nop

801065e0 <uartputc.part.0>:
uartputc(int c)
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	57                   	push   %edi
801065e4:	56                   	push   %esi
801065e5:	53                   	push   %ebx
801065e6:	89 c7                	mov    %eax,%edi
801065e8:	bb 80 00 00 00       	mov    $0x80,%ebx
801065ed:	be fd 03 00 00       	mov    $0x3fd,%esi
801065f2:	83 ec 0c             	sub    $0xc,%esp
801065f5:	eb 1b                	jmp    80106612 <uartputc.part.0+0x32>
801065f7:	89 f6                	mov    %esi,%esi
801065f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106600:	83 ec 0c             	sub    $0xc,%esp
80106603:	6a 0a                	push   $0xa
80106605:	e8 66 c8 ff ff       	call   80102e70 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010660a:	83 c4 10             	add    $0x10,%esp
8010660d:	83 eb 01             	sub    $0x1,%ebx
80106610:	74 07                	je     80106619 <uartputc.part.0+0x39>
80106612:	89 f2                	mov    %esi,%edx
80106614:	ec                   	in     (%dx),%al
80106615:	a8 20                	test   $0x20,%al
80106617:	74 e7                	je     80106600 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106619:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010661e:	89 f8                	mov    %edi,%eax
80106620:	ee                   	out    %al,(%dx)
}
80106621:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106624:	5b                   	pop    %ebx
80106625:	5e                   	pop    %esi
80106626:	5f                   	pop    %edi
80106627:	5d                   	pop    %ebp
80106628:	c3                   	ret    
80106629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106630 <uartinit>:
{
80106630:	55                   	push   %ebp
80106631:	31 c9                	xor    %ecx,%ecx
80106633:	89 c8                	mov    %ecx,%eax
80106635:	89 e5                	mov    %esp,%ebp
80106637:	57                   	push   %edi
80106638:	56                   	push   %esi
80106639:	53                   	push   %ebx
8010663a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010663f:	89 da                	mov    %ebx,%edx
80106641:	83 ec 0c             	sub    $0xc,%esp
80106644:	ee                   	out    %al,(%dx)
80106645:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010664a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010664f:	89 fa                	mov    %edi,%edx
80106651:	ee                   	out    %al,(%dx)
80106652:	b8 0c 00 00 00       	mov    $0xc,%eax
80106657:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010665c:	ee                   	out    %al,(%dx)
8010665d:	be f9 03 00 00       	mov    $0x3f9,%esi
80106662:	89 c8                	mov    %ecx,%eax
80106664:	89 f2                	mov    %esi,%edx
80106666:	ee                   	out    %al,(%dx)
80106667:	b8 03 00 00 00       	mov    $0x3,%eax
8010666c:	89 fa                	mov    %edi,%edx
8010666e:	ee                   	out    %al,(%dx)
8010666f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106674:	89 c8                	mov    %ecx,%eax
80106676:	ee                   	out    %al,(%dx)
80106677:	b8 01 00 00 00       	mov    $0x1,%eax
8010667c:	89 f2                	mov    %esi,%edx
8010667e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010667f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106684:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106685:	3c ff                	cmp    $0xff,%al
80106687:	74 5a                	je     801066e3 <uartinit+0xb3>
  uart = 1;
80106689:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
80106690:	00 00 00 
80106693:	89 da                	mov    %ebx,%edx
80106695:	ec                   	in     (%dx),%al
80106696:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010669b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010669c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010669f:	bb 3c 91 10 80       	mov    $0x8010913c,%ebx
  ioapicenable(IRQ_COM1, 0);
801066a4:	6a 00                	push   $0x0
801066a6:	6a 04                	push   $0x4
801066a8:	e8 13 c1 ff ff       	call   801027c0 <ioapicenable>
801066ad:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801066b0:	b8 78 00 00 00       	mov    $0x78,%eax
801066b5:	eb 13                	jmp    801066ca <uartinit+0x9a>
801066b7:	89 f6                	mov    %esi,%esi
801066b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801066c0:	83 c3 01             	add    $0x1,%ebx
801066c3:	0f be 03             	movsbl (%ebx),%eax
801066c6:	84 c0                	test   %al,%al
801066c8:	74 19                	je     801066e3 <uartinit+0xb3>
  if(!uart)
801066ca:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
801066d0:	85 d2                	test   %edx,%edx
801066d2:	74 ec                	je     801066c0 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
801066d4:	83 c3 01             	add    $0x1,%ebx
801066d7:	e8 04 ff ff ff       	call   801065e0 <uartputc.part.0>
801066dc:	0f be 03             	movsbl (%ebx),%eax
801066df:	84 c0                	test   %al,%al
801066e1:	75 e7                	jne    801066ca <uartinit+0x9a>
}
801066e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066e6:	5b                   	pop    %ebx
801066e7:	5e                   	pop    %esi
801066e8:	5f                   	pop    %edi
801066e9:	5d                   	pop    %ebp
801066ea:	c3                   	ret    
801066eb:	90                   	nop
801066ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801066f0 <uartputc>:
  if(!uart)
801066f0:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
{
801066f6:	55                   	push   %ebp
801066f7:	89 e5                	mov    %esp,%ebp
  if(!uart)
801066f9:	85 d2                	test   %edx,%edx
{
801066fb:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801066fe:	74 10                	je     80106710 <uartputc+0x20>
}
80106700:	5d                   	pop    %ebp
80106701:	e9 da fe ff ff       	jmp    801065e0 <uartputc.part.0>
80106706:	8d 76 00             	lea    0x0(%esi),%esi
80106709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106710:	5d                   	pop    %ebp
80106711:	c3                   	ret    
80106712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106720 <uartintr>:

void
uartintr(void)
{
80106720:	55                   	push   %ebp
80106721:	89 e5                	mov    %esp,%ebp
80106723:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106726:	68 b0 65 10 80       	push   $0x801065b0
8010672b:	e8 e0 a0 ff ff       	call   80100810 <consoleintr>
}
80106730:	83 c4 10             	add    $0x10,%esp
80106733:	c9                   	leave  
80106734:	c3                   	ret    

80106735 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106735:	6a 00                	push   $0x0
  pushl $0
80106737:	6a 00                	push   $0x0
  jmp alltraps
80106739:	e9 5b f9 ff ff       	jmp    80106099 <alltraps>

8010673e <vector1>:
.globl vector1
vector1:
  pushl $0
8010673e:	6a 00                	push   $0x0
  pushl $1
80106740:	6a 01                	push   $0x1
  jmp alltraps
80106742:	e9 52 f9 ff ff       	jmp    80106099 <alltraps>

80106747 <vector2>:
.globl vector2
vector2:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $2
80106749:	6a 02                	push   $0x2
  jmp alltraps
8010674b:	e9 49 f9 ff ff       	jmp    80106099 <alltraps>

80106750 <vector3>:
.globl vector3
vector3:
  pushl $0
80106750:	6a 00                	push   $0x0
  pushl $3
80106752:	6a 03                	push   $0x3
  jmp alltraps
80106754:	e9 40 f9 ff ff       	jmp    80106099 <alltraps>

80106759 <vector4>:
.globl vector4
vector4:
  pushl $0
80106759:	6a 00                	push   $0x0
  pushl $4
8010675b:	6a 04                	push   $0x4
  jmp alltraps
8010675d:	e9 37 f9 ff ff       	jmp    80106099 <alltraps>

80106762 <vector5>:
.globl vector5
vector5:
  pushl $0
80106762:	6a 00                	push   $0x0
  pushl $5
80106764:	6a 05                	push   $0x5
  jmp alltraps
80106766:	e9 2e f9 ff ff       	jmp    80106099 <alltraps>

8010676b <vector6>:
.globl vector6
vector6:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $6
8010676d:	6a 06                	push   $0x6
  jmp alltraps
8010676f:	e9 25 f9 ff ff       	jmp    80106099 <alltraps>

80106774 <vector7>:
.globl vector7
vector7:
  pushl $0
80106774:	6a 00                	push   $0x0
  pushl $7
80106776:	6a 07                	push   $0x7
  jmp alltraps
80106778:	e9 1c f9 ff ff       	jmp    80106099 <alltraps>

8010677d <vector8>:
.globl vector8
vector8:
  pushl $8
8010677d:	6a 08                	push   $0x8
  jmp alltraps
8010677f:	e9 15 f9 ff ff       	jmp    80106099 <alltraps>

80106784 <vector9>:
.globl vector9
vector9:
  pushl $0
80106784:	6a 00                	push   $0x0
  pushl $9
80106786:	6a 09                	push   $0x9
  jmp alltraps
80106788:	e9 0c f9 ff ff       	jmp    80106099 <alltraps>

8010678d <vector10>:
.globl vector10
vector10:
  pushl $10
8010678d:	6a 0a                	push   $0xa
  jmp alltraps
8010678f:	e9 05 f9 ff ff       	jmp    80106099 <alltraps>

80106794 <vector11>:
.globl vector11
vector11:
  pushl $11
80106794:	6a 0b                	push   $0xb
  jmp alltraps
80106796:	e9 fe f8 ff ff       	jmp    80106099 <alltraps>

8010679b <vector12>:
.globl vector12
vector12:
  pushl $12
8010679b:	6a 0c                	push   $0xc
  jmp alltraps
8010679d:	e9 f7 f8 ff ff       	jmp    80106099 <alltraps>

801067a2 <vector13>:
.globl vector13
vector13:
  pushl $13
801067a2:	6a 0d                	push   $0xd
  jmp alltraps
801067a4:	e9 f0 f8 ff ff       	jmp    80106099 <alltraps>

801067a9 <vector14>:
.globl vector14
vector14:
  pushl $14
801067a9:	6a 0e                	push   $0xe
  jmp alltraps
801067ab:	e9 e9 f8 ff ff       	jmp    80106099 <alltraps>

801067b0 <vector15>:
.globl vector15
vector15:
  pushl $0
801067b0:	6a 00                	push   $0x0
  pushl $15
801067b2:	6a 0f                	push   $0xf
  jmp alltraps
801067b4:	e9 e0 f8 ff ff       	jmp    80106099 <alltraps>

801067b9 <vector16>:
.globl vector16
vector16:
  pushl $0
801067b9:	6a 00                	push   $0x0
  pushl $16
801067bb:	6a 10                	push   $0x10
  jmp alltraps
801067bd:	e9 d7 f8 ff ff       	jmp    80106099 <alltraps>

801067c2 <vector17>:
.globl vector17
vector17:
  pushl $17
801067c2:	6a 11                	push   $0x11
  jmp alltraps
801067c4:	e9 d0 f8 ff ff       	jmp    80106099 <alltraps>

801067c9 <vector18>:
.globl vector18
vector18:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $18
801067cb:	6a 12                	push   $0x12
  jmp alltraps
801067cd:	e9 c7 f8 ff ff       	jmp    80106099 <alltraps>

801067d2 <vector19>:
.globl vector19
vector19:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $19
801067d4:	6a 13                	push   $0x13
  jmp alltraps
801067d6:	e9 be f8 ff ff       	jmp    80106099 <alltraps>

801067db <vector20>:
.globl vector20
vector20:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $20
801067dd:	6a 14                	push   $0x14
  jmp alltraps
801067df:	e9 b5 f8 ff ff       	jmp    80106099 <alltraps>

801067e4 <vector21>:
.globl vector21
vector21:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $21
801067e6:	6a 15                	push   $0x15
  jmp alltraps
801067e8:	e9 ac f8 ff ff       	jmp    80106099 <alltraps>

801067ed <vector22>:
.globl vector22
vector22:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $22
801067ef:	6a 16                	push   $0x16
  jmp alltraps
801067f1:	e9 a3 f8 ff ff       	jmp    80106099 <alltraps>

801067f6 <vector23>:
.globl vector23
vector23:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $23
801067f8:	6a 17                	push   $0x17
  jmp alltraps
801067fa:	e9 9a f8 ff ff       	jmp    80106099 <alltraps>

801067ff <vector24>:
.globl vector24
vector24:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $24
80106801:	6a 18                	push   $0x18
  jmp alltraps
80106803:	e9 91 f8 ff ff       	jmp    80106099 <alltraps>

80106808 <vector25>:
.globl vector25
vector25:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $25
8010680a:	6a 19                	push   $0x19
  jmp alltraps
8010680c:	e9 88 f8 ff ff       	jmp    80106099 <alltraps>

80106811 <vector26>:
.globl vector26
vector26:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $26
80106813:	6a 1a                	push   $0x1a
  jmp alltraps
80106815:	e9 7f f8 ff ff       	jmp    80106099 <alltraps>

8010681a <vector27>:
.globl vector27
vector27:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $27
8010681c:	6a 1b                	push   $0x1b
  jmp alltraps
8010681e:	e9 76 f8 ff ff       	jmp    80106099 <alltraps>

80106823 <vector28>:
.globl vector28
vector28:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $28
80106825:	6a 1c                	push   $0x1c
  jmp alltraps
80106827:	e9 6d f8 ff ff       	jmp    80106099 <alltraps>

8010682c <vector29>:
.globl vector29
vector29:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $29
8010682e:	6a 1d                	push   $0x1d
  jmp alltraps
80106830:	e9 64 f8 ff ff       	jmp    80106099 <alltraps>

80106835 <vector30>:
.globl vector30
vector30:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $30
80106837:	6a 1e                	push   $0x1e
  jmp alltraps
80106839:	e9 5b f8 ff ff       	jmp    80106099 <alltraps>

8010683e <vector31>:
.globl vector31
vector31:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $31
80106840:	6a 1f                	push   $0x1f
  jmp alltraps
80106842:	e9 52 f8 ff ff       	jmp    80106099 <alltraps>

80106847 <vector32>:
.globl vector32
vector32:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $32
80106849:	6a 20                	push   $0x20
  jmp alltraps
8010684b:	e9 49 f8 ff ff       	jmp    80106099 <alltraps>

80106850 <vector33>:
.globl vector33
vector33:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $33
80106852:	6a 21                	push   $0x21
  jmp alltraps
80106854:	e9 40 f8 ff ff       	jmp    80106099 <alltraps>

80106859 <vector34>:
.globl vector34
vector34:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $34
8010685b:	6a 22                	push   $0x22
  jmp alltraps
8010685d:	e9 37 f8 ff ff       	jmp    80106099 <alltraps>

80106862 <vector35>:
.globl vector35
vector35:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $35
80106864:	6a 23                	push   $0x23
  jmp alltraps
80106866:	e9 2e f8 ff ff       	jmp    80106099 <alltraps>

8010686b <vector36>:
.globl vector36
vector36:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $36
8010686d:	6a 24                	push   $0x24
  jmp alltraps
8010686f:	e9 25 f8 ff ff       	jmp    80106099 <alltraps>

80106874 <vector37>:
.globl vector37
vector37:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $37
80106876:	6a 25                	push   $0x25
  jmp alltraps
80106878:	e9 1c f8 ff ff       	jmp    80106099 <alltraps>

8010687d <vector38>:
.globl vector38
vector38:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $38
8010687f:	6a 26                	push   $0x26
  jmp alltraps
80106881:	e9 13 f8 ff ff       	jmp    80106099 <alltraps>

80106886 <vector39>:
.globl vector39
vector39:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $39
80106888:	6a 27                	push   $0x27
  jmp alltraps
8010688a:	e9 0a f8 ff ff       	jmp    80106099 <alltraps>

8010688f <vector40>:
.globl vector40
vector40:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $40
80106891:	6a 28                	push   $0x28
  jmp alltraps
80106893:	e9 01 f8 ff ff       	jmp    80106099 <alltraps>

80106898 <vector41>:
.globl vector41
vector41:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $41
8010689a:	6a 29                	push   $0x29
  jmp alltraps
8010689c:	e9 f8 f7 ff ff       	jmp    80106099 <alltraps>

801068a1 <vector42>:
.globl vector42
vector42:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $42
801068a3:	6a 2a                	push   $0x2a
  jmp alltraps
801068a5:	e9 ef f7 ff ff       	jmp    80106099 <alltraps>

801068aa <vector43>:
.globl vector43
vector43:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $43
801068ac:	6a 2b                	push   $0x2b
  jmp alltraps
801068ae:	e9 e6 f7 ff ff       	jmp    80106099 <alltraps>

801068b3 <vector44>:
.globl vector44
vector44:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $44
801068b5:	6a 2c                	push   $0x2c
  jmp alltraps
801068b7:	e9 dd f7 ff ff       	jmp    80106099 <alltraps>

801068bc <vector45>:
.globl vector45
vector45:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $45
801068be:	6a 2d                	push   $0x2d
  jmp alltraps
801068c0:	e9 d4 f7 ff ff       	jmp    80106099 <alltraps>

801068c5 <vector46>:
.globl vector46
vector46:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $46
801068c7:	6a 2e                	push   $0x2e
  jmp alltraps
801068c9:	e9 cb f7 ff ff       	jmp    80106099 <alltraps>

801068ce <vector47>:
.globl vector47
vector47:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $47
801068d0:	6a 2f                	push   $0x2f
  jmp alltraps
801068d2:	e9 c2 f7 ff ff       	jmp    80106099 <alltraps>

801068d7 <vector48>:
.globl vector48
vector48:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $48
801068d9:	6a 30                	push   $0x30
  jmp alltraps
801068db:	e9 b9 f7 ff ff       	jmp    80106099 <alltraps>

801068e0 <vector49>:
.globl vector49
vector49:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $49
801068e2:	6a 31                	push   $0x31
  jmp alltraps
801068e4:	e9 b0 f7 ff ff       	jmp    80106099 <alltraps>

801068e9 <vector50>:
.globl vector50
vector50:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $50
801068eb:	6a 32                	push   $0x32
  jmp alltraps
801068ed:	e9 a7 f7 ff ff       	jmp    80106099 <alltraps>

801068f2 <vector51>:
.globl vector51
vector51:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $51
801068f4:	6a 33                	push   $0x33
  jmp alltraps
801068f6:	e9 9e f7 ff ff       	jmp    80106099 <alltraps>

801068fb <vector52>:
.globl vector52
vector52:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $52
801068fd:	6a 34                	push   $0x34
  jmp alltraps
801068ff:	e9 95 f7 ff ff       	jmp    80106099 <alltraps>

80106904 <vector53>:
.globl vector53
vector53:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $53
80106906:	6a 35                	push   $0x35
  jmp alltraps
80106908:	e9 8c f7 ff ff       	jmp    80106099 <alltraps>

8010690d <vector54>:
.globl vector54
vector54:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $54
8010690f:	6a 36                	push   $0x36
  jmp alltraps
80106911:	e9 83 f7 ff ff       	jmp    80106099 <alltraps>

80106916 <vector55>:
.globl vector55
vector55:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $55
80106918:	6a 37                	push   $0x37
  jmp alltraps
8010691a:	e9 7a f7 ff ff       	jmp    80106099 <alltraps>

8010691f <vector56>:
.globl vector56
vector56:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $56
80106921:	6a 38                	push   $0x38
  jmp alltraps
80106923:	e9 71 f7 ff ff       	jmp    80106099 <alltraps>

80106928 <vector57>:
.globl vector57
vector57:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $57
8010692a:	6a 39                	push   $0x39
  jmp alltraps
8010692c:	e9 68 f7 ff ff       	jmp    80106099 <alltraps>

80106931 <vector58>:
.globl vector58
vector58:
  pushl $0
80106931:	6a 00                	push   $0x0
  pushl $58
80106933:	6a 3a                	push   $0x3a
  jmp alltraps
80106935:	e9 5f f7 ff ff       	jmp    80106099 <alltraps>

8010693a <vector59>:
.globl vector59
vector59:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $59
8010693c:	6a 3b                	push   $0x3b
  jmp alltraps
8010693e:	e9 56 f7 ff ff       	jmp    80106099 <alltraps>

80106943 <vector60>:
.globl vector60
vector60:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $60
80106945:	6a 3c                	push   $0x3c
  jmp alltraps
80106947:	e9 4d f7 ff ff       	jmp    80106099 <alltraps>

8010694c <vector61>:
.globl vector61
vector61:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $61
8010694e:	6a 3d                	push   $0x3d
  jmp alltraps
80106950:	e9 44 f7 ff ff       	jmp    80106099 <alltraps>

80106955 <vector62>:
.globl vector62
vector62:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $62
80106957:	6a 3e                	push   $0x3e
  jmp alltraps
80106959:	e9 3b f7 ff ff       	jmp    80106099 <alltraps>

8010695e <vector63>:
.globl vector63
vector63:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $63
80106960:	6a 3f                	push   $0x3f
  jmp alltraps
80106962:	e9 32 f7 ff ff       	jmp    80106099 <alltraps>

80106967 <vector64>:
.globl vector64
vector64:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $64
80106969:	6a 40                	push   $0x40
  jmp alltraps
8010696b:	e9 29 f7 ff ff       	jmp    80106099 <alltraps>

80106970 <vector65>:
.globl vector65
vector65:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $65
80106972:	6a 41                	push   $0x41
  jmp alltraps
80106974:	e9 20 f7 ff ff       	jmp    80106099 <alltraps>

80106979 <vector66>:
.globl vector66
vector66:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $66
8010697b:	6a 42                	push   $0x42
  jmp alltraps
8010697d:	e9 17 f7 ff ff       	jmp    80106099 <alltraps>

80106982 <vector67>:
.globl vector67
vector67:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $67
80106984:	6a 43                	push   $0x43
  jmp alltraps
80106986:	e9 0e f7 ff ff       	jmp    80106099 <alltraps>

8010698b <vector68>:
.globl vector68
vector68:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $68
8010698d:	6a 44                	push   $0x44
  jmp alltraps
8010698f:	e9 05 f7 ff ff       	jmp    80106099 <alltraps>

80106994 <vector69>:
.globl vector69
vector69:
  pushl $0
80106994:	6a 00                	push   $0x0
  pushl $69
80106996:	6a 45                	push   $0x45
  jmp alltraps
80106998:	e9 fc f6 ff ff       	jmp    80106099 <alltraps>

8010699d <vector70>:
.globl vector70
vector70:
  pushl $0
8010699d:	6a 00                	push   $0x0
  pushl $70
8010699f:	6a 46                	push   $0x46
  jmp alltraps
801069a1:	e9 f3 f6 ff ff       	jmp    80106099 <alltraps>

801069a6 <vector71>:
.globl vector71
vector71:
  pushl $0
801069a6:	6a 00                	push   $0x0
  pushl $71
801069a8:	6a 47                	push   $0x47
  jmp alltraps
801069aa:	e9 ea f6 ff ff       	jmp    80106099 <alltraps>

801069af <vector72>:
.globl vector72
vector72:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $72
801069b1:	6a 48                	push   $0x48
  jmp alltraps
801069b3:	e9 e1 f6 ff ff       	jmp    80106099 <alltraps>

801069b8 <vector73>:
.globl vector73
vector73:
  pushl $0
801069b8:	6a 00                	push   $0x0
  pushl $73
801069ba:	6a 49                	push   $0x49
  jmp alltraps
801069bc:	e9 d8 f6 ff ff       	jmp    80106099 <alltraps>

801069c1 <vector74>:
.globl vector74
vector74:
  pushl $0
801069c1:	6a 00                	push   $0x0
  pushl $74
801069c3:	6a 4a                	push   $0x4a
  jmp alltraps
801069c5:	e9 cf f6 ff ff       	jmp    80106099 <alltraps>

801069ca <vector75>:
.globl vector75
vector75:
  pushl $0
801069ca:	6a 00                	push   $0x0
  pushl $75
801069cc:	6a 4b                	push   $0x4b
  jmp alltraps
801069ce:	e9 c6 f6 ff ff       	jmp    80106099 <alltraps>

801069d3 <vector76>:
.globl vector76
vector76:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $76
801069d5:	6a 4c                	push   $0x4c
  jmp alltraps
801069d7:	e9 bd f6 ff ff       	jmp    80106099 <alltraps>

801069dc <vector77>:
.globl vector77
vector77:
  pushl $0
801069dc:	6a 00                	push   $0x0
  pushl $77
801069de:	6a 4d                	push   $0x4d
  jmp alltraps
801069e0:	e9 b4 f6 ff ff       	jmp    80106099 <alltraps>

801069e5 <vector78>:
.globl vector78
vector78:
  pushl $0
801069e5:	6a 00                	push   $0x0
  pushl $78
801069e7:	6a 4e                	push   $0x4e
  jmp alltraps
801069e9:	e9 ab f6 ff ff       	jmp    80106099 <alltraps>

801069ee <vector79>:
.globl vector79
vector79:
  pushl $0
801069ee:	6a 00                	push   $0x0
  pushl $79
801069f0:	6a 4f                	push   $0x4f
  jmp alltraps
801069f2:	e9 a2 f6 ff ff       	jmp    80106099 <alltraps>

801069f7 <vector80>:
.globl vector80
vector80:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $80
801069f9:	6a 50                	push   $0x50
  jmp alltraps
801069fb:	e9 99 f6 ff ff       	jmp    80106099 <alltraps>

80106a00 <vector81>:
.globl vector81
vector81:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $81
80106a02:	6a 51                	push   $0x51
  jmp alltraps
80106a04:	e9 90 f6 ff ff       	jmp    80106099 <alltraps>

80106a09 <vector82>:
.globl vector82
vector82:
  pushl $0
80106a09:	6a 00                	push   $0x0
  pushl $82
80106a0b:	6a 52                	push   $0x52
  jmp alltraps
80106a0d:	e9 87 f6 ff ff       	jmp    80106099 <alltraps>

80106a12 <vector83>:
.globl vector83
vector83:
  pushl $0
80106a12:	6a 00                	push   $0x0
  pushl $83
80106a14:	6a 53                	push   $0x53
  jmp alltraps
80106a16:	e9 7e f6 ff ff       	jmp    80106099 <alltraps>

80106a1b <vector84>:
.globl vector84
vector84:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $84
80106a1d:	6a 54                	push   $0x54
  jmp alltraps
80106a1f:	e9 75 f6 ff ff       	jmp    80106099 <alltraps>

80106a24 <vector85>:
.globl vector85
vector85:
  pushl $0
80106a24:	6a 00                	push   $0x0
  pushl $85
80106a26:	6a 55                	push   $0x55
  jmp alltraps
80106a28:	e9 6c f6 ff ff       	jmp    80106099 <alltraps>

80106a2d <vector86>:
.globl vector86
vector86:
  pushl $0
80106a2d:	6a 00                	push   $0x0
  pushl $86
80106a2f:	6a 56                	push   $0x56
  jmp alltraps
80106a31:	e9 63 f6 ff ff       	jmp    80106099 <alltraps>

80106a36 <vector87>:
.globl vector87
vector87:
  pushl $0
80106a36:	6a 00                	push   $0x0
  pushl $87
80106a38:	6a 57                	push   $0x57
  jmp alltraps
80106a3a:	e9 5a f6 ff ff       	jmp    80106099 <alltraps>

80106a3f <vector88>:
.globl vector88
vector88:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $88
80106a41:	6a 58                	push   $0x58
  jmp alltraps
80106a43:	e9 51 f6 ff ff       	jmp    80106099 <alltraps>

80106a48 <vector89>:
.globl vector89
vector89:
  pushl $0
80106a48:	6a 00                	push   $0x0
  pushl $89
80106a4a:	6a 59                	push   $0x59
  jmp alltraps
80106a4c:	e9 48 f6 ff ff       	jmp    80106099 <alltraps>

80106a51 <vector90>:
.globl vector90
vector90:
  pushl $0
80106a51:	6a 00                	push   $0x0
  pushl $90
80106a53:	6a 5a                	push   $0x5a
  jmp alltraps
80106a55:	e9 3f f6 ff ff       	jmp    80106099 <alltraps>

80106a5a <vector91>:
.globl vector91
vector91:
  pushl $0
80106a5a:	6a 00                	push   $0x0
  pushl $91
80106a5c:	6a 5b                	push   $0x5b
  jmp alltraps
80106a5e:	e9 36 f6 ff ff       	jmp    80106099 <alltraps>

80106a63 <vector92>:
.globl vector92
vector92:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $92
80106a65:	6a 5c                	push   $0x5c
  jmp alltraps
80106a67:	e9 2d f6 ff ff       	jmp    80106099 <alltraps>

80106a6c <vector93>:
.globl vector93
vector93:
  pushl $0
80106a6c:	6a 00                	push   $0x0
  pushl $93
80106a6e:	6a 5d                	push   $0x5d
  jmp alltraps
80106a70:	e9 24 f6 ff ff       	jmp    80106099 <alltraps>

80106a75 <vector94>:
.globl vector94
vector94:
  pushl $0
80106a75:	6a 00                	push   $0x0
  pushl $94
80106a77:	6a 5e                	push   $0x5e
  jmp alltraps
80106a79:	e9 1b f6 ff ff       	jmp    80106099 <alltraps>

80106a7e <vector95>:
.globl vector95
vector95:
  pushl $0
80106a7e:	6a 00                	push   $0x0
  pushl $95
80106a80:	6a 5f                	push   $0x5f
  jmp alltraps
80106a82:	e9 12 f6 ff ff       	jmp    80106099 <alltraps>

80106a87 <vector96>:
.globl vector96
vector96:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $96
80106a89:	6a 60                	push   $0x60
  jmp alltraps
80106a8b:	e9 09 f6 ff ff       	jmp    80106099 <alltraps>

80106a90 <vector97>:
.globl vector97
vector97:
  pushl $0
80106a90:	6a 00                	push   $0x0
  pushl $97
80106a92:	6a 61                	push   $0x61
  jmp alltraps
80106a94:	e9 00 f6 ff ff       	jmp    80106099 <alltraps>

80106a99 <vector98>:
.globl vector98
vector98:
  pushl $0
80106a99:	6a 00                	push   $0x0
  pushl $98
80106a9b:	6a 62                	push   $0x62
  jmp alltraps
80106a9d:	e9 f7 f5 ff ff       	jmp    80106099 <alltraps>

80106aa2 <vector99>:
.globl vector99
vector99:
  pushl $0
80106aa2:	6a 00                	push   $0x0
  pushl $99
80106aa4:	6a 63                	push   $0x63
  jmp alltraps
80106aa6:	e9 ee f5 ff ff       	jmp    80106099 <alltraps>

80106aab <vector100>:
.globl vector100
vector100:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $100
80106aad:	6a 64                	push   $0x64
  jmp alltraps
80106aaf:	e9 e5 f5 ff ff       	jmp    80106099 <alltraps>

80106ab4 <vector101>:
.globl vector101
vector101:
  pushl $0
80106ab4:	6a 00                	push   $0x0
  pushl $101
80106ab6:	6a 65                	push   $0x65
  jmp alltraps
80106ab8:	e9 dc f5 ff ff       	jmp    80106099 <alltraps>

80106abd <vector102>:
.globl vector102
vector102:
  pushl $0
80106abd:	6a 00                	push   $0x0
  pushl $102
80106abf:	6a 66                	push   $0x66
  jmp alltraps
80106ac1:	e9 d3 f5 ff ff       	jmp    80106099 <alltraps>

80106ac6 <vector103>:
.globl vector103
vector103:
  pushl $0
80106ac6:	6a 00                	push   $0x0
  pushl $103
80106ac8:	6a 67                	push   $0x67
  jmp alltraps
80106aca:	e9 ca f5 ff ff       	jmp    80106099 <alltraps>

80106acf <vector104>:
.globl vector104
vector104:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $104
80106ad1:	6a 68                	push   $0x68
  jmp alltraps
80106ad3:	e9 c1 f5 ff ff       	jmp    80106099 <alltraps>

80106ad8 <vector105>:
.globl vector105
vector105:
  pushl $0
80106ad8:	6a 00                	push   $0x0
  pushl $105
80106ada:	6a 69                	push   $0x69
  jmp alltraps
80106adc:	e9 b8 f5 ff ff       	jmp    80106099 <alltraps>

80106ae1 <vector106>:
.globl vector106
vector106:
  pushl $0
80106ae1:	6a 00                	push   $0x0
  pushl $106
80106ae3:	6a 6a                	push   $0x6a
  jmp alltraps
80106ae5:	e9 af f5 ff ff       	jmp    80106099 <alltraps>

80106aea <vector107>:
.globl vector107
vector107:
  pushl $0
80106aea:	6a 00                	push   $0x0
  pushl $107
80106aec:	6a 6b                	push   $0x6b
  jmp alltraps
80106aee:	e9 a6 f5 ff ff       	jmp    80106099 <alltraps>

80106af3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $108
80106af5:	6a 6c                	push   $0x6c
  jmp alltraps
80106af7:	e9 9d f5 ff ff       	jmp    80106099 <alltraps>

80106afc <vector109>:
.globl vector109
vector109:
  pushl $0
80106afc:	6a 00                	push   $0x0
  pushl $109
80106afe:	6a 6d                	push   $0x6d
  jmp alltraps
80106b00:	e9 94 f5 ff ff       	jmp    80106099 <alltraps>

80106b05 <vector110>:
.globl vector110
vector110:
  pushl $0
80106b05:	6a 00                	push   $0x0
  pushl $110
80106b07:	6a 6e                	push   $0x6e
  jmp alltraps
80106b09:	e9 8b f5 ff ff       	jmp    80106099 <alltraps>

80106b0e <vector111>:
.globl vector111
vector111:
  pushl $0
80106b0e:	6a 00                	push   $0x0
  pushl $111
80106b10:	6a 6f                	push   $0x6f
  jmp alltraps
80106b12:	e9 82 f5 ff ff       	jmp    80106099 <alltraps>

80106b17 <vector112>:
.globl vector112
vector112:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $112
80106b19:	6a 70                	push   $0x70
  jmp alltraps
80106b1b:	e9 79 f5 ff ff       	jmp    80106099 <alltraps>

80106b20 <vector113>:
.globl vector113
vector113:
  pushl $0
80106b20:	6a 00                	push   $0x0
  pushl $113
80106b22:	6a 71                	push   $0x71
  jmp alltraps
80106b24:	e9 70 f5 ff ff       	jmp    80106099 <alltraps>

80106b29 <vector114>:
.globl vector114
vector114:
  pushl $0
80106b29:	6a 00                	push   $0x0
  pushl $114
80106b2b:	6a 72                	push   $0x72
  jmp alltraps
80106b2d:	e9 67 f5 ff ff       	jmp    80106099 <alltraps>

80106b32 <vector115>:
.globl vector115
vector115:
  pushl $0
80106b32:	6a 00                	push   $0x0
  pushl $115
80106b34:	6a 73                	push   $0x73
  jmp alltraps
80106b36:	e9 5e f5 ff ff       	jmp    80106099 <alltraps>

80106b3b <vector116>:
.globl vector116
vector116:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $116
80106b3d:	6a 74                	push   $0x74
  jmp alltraps
80106b3f:	e9 55 f5 ff ff       	jmp    80106099 <alltraps>

80106b44 <vector117>:
.globl vector117
vector117:
  pushl $0
80106b44:	6a 00                	push   $0x0
  pushl $117
80106b46:	6a 75                	push   $0x75
  jmp alltraps
80106b48:	e9 4c f5 ff ff       	jmp    80106099 <alltraps>

80106b4d <vector118>:
.globl vector118
vector118:
  pushl $0
80106b4d:	6a 00                	push   $0x0
  pushl $118
80106b4f:	6a 76                	push   $0x76
  jmp alltraps
80106b51:	e9 43 f5 ff ff       	jmp    80106099 <alltraps>

80106b56 <vector119>:
.globl vector119
vector119:
  pushl $0
80106b56:	6a 00                	push   $0x0
  pushl $119
80106b58:	6a 77                	push   $0x77
  jmp alltraps
80106b5a:	e9 3a f5 ff ff       	jmp    80106099 <alltraps>

80106b5f <vector120>:
.globl vector120
vector120:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $120
80106b61:	6a 78                	push   $0x78
  jmp alltraps
80106b63:	e9 31 f5 ff ff       	jmp    80106099 <alltraps>

80106b68 <vector121>:
.globl vector121
vector121:
  pushl $0
80106b68:	6a 00                	push   $0x0
  pushl $121
80106b6a:	6a 79                	push   $0x79
  jmp alltraps
80106b6c:	e9 28 f5 ff ff       	jmp    80106099 <alltraps>

80106b71 <vector122>:
.globl vector122
vector122:
  pushl $0
80106b71:	6a 00                	push   $0x0
  pushl $122
80106b73:	6a 7a                	push   $0x7a
  jmp alltraps
80106b75:	e9 1f f5 ff ff       	jmp    80106099 <alltraps>

80106b7a <vector123>:
.globl vector123
vector123:
  pushl $0
80106b7a:	6a 00                	push   $0x0
  pushl $123
80106b7c:	6a 7b                	push   $0x7b
  jmp alltraps
80106b7e:	e9 16 f5 ff ff       	jmp    80106099 <alltraps>

80106b83 <vector124>:
.globl vector124
vector124:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $124
80106b85:	6a 7c                	push   $0x7c
  jmp alltraps
80106b87:	e9 0d f5 ff ff       	jmp    80106099 <alltraps>

80106b8c <vector125>:
.globl vector125
vector125:
  pushl $0
80106b8c:	6a 00                	push   $0x0
  pushl $125
80106b8e:	6a 7d                	push   $0x7d
  jmp alltraps
80106b90:	e9 04 f5 ff ff       	jmp    80106099 <alltraps>

80106b95 <vector126>:
.globl vector126
vector126:
  pushl $0
80106b95:	6a 00                	push   $0x0
  pushl $126
80106b97:	6a 7e                	push   $0x7e
  jmp alltraps
80106b99:	e9 fb f4 ff ff       	jmp    80106099 <alltraps>

80106b9e <vector127>:
.globl vector127
vector127:
  pushl $0
80106b9e:	6a 00                	push   $0x0
  pushl $127
80106ba0:	6a 7f                	push   $0x7f
  jmp alltraps
80106ba2:	e9 f2 f4 ff ff       	jmp    80106099 <alltraps>

80106ba7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $128
80106ba9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106bae:	e9 e6 f4 ff ff       	jmp    80106099 <alltraps>

80106bb3 <vector129>:
.globl vector129
vector129:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $129
80106bb5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106bba:	e9 da f4 ff ff       	jmp    80106099 <alltraps>

80106bbf <vector130>:
.globl vector130
vector130:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $130
80106bc1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106bc6:	e9 ce f4 ff ff       	jmp    80106099 <alltraps>

80106bcb <vector131>:
.globl vector131
vector131:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $131
80106bcd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106bd2:	e9 c2 f4 ff ff       	jmp    80106099 <alltraps>

80106bd7 <vector132>:
.globl vector132
vector132:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $132
80106bd9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106bde:	e9 b6 f4 ff ff       	jmp    80106099 <alltraps>

80106be3 <vector133>:
.globl vector133
vector133:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $133
80106be5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106bea:	e9 aa f4 ff ff       	jmp    80106099 <alltraps>

80106bef <vector134>:
.globl vector134
vector134:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $134
80106bf1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106bf6:	e9 9e f4 ff ff       	jmp    80106099 <alltraps>

80106bfb <vector135>:
.globl vector135
vector135:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $135
80106bfd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106c02:	e9 92 f4 ff ff       	jmp    80106099 <alltraps>

80106c07 <vector136>:
.globl vector136
vector136:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $136
80106c09:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106c0e:	e9 86 f4 ff ff       	jmp    80106099 <alltraps>

80106c13 <vector137>:
.globl vector137
vector137:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $137
80106c15:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106c1a:	e9 7a f4 ff ff       	jmp    80106099 <alltraps>

80106c1f <vector138>:
.globl vector138
vector138:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $138
80106c21:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106c26:	e9 6e f4 ff ff       	jmp    80106099 <alltraps>

80106c2b <vector139>:
.globl vector139
vector139:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $139
80106c2d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106c32:	e9 62 f4 ff ff       	jmp    80106099 <alltraps>

80106c37 <vector140>:
.globl vector140
vector140:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $140
80106c39:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106c3e:	e9 56 f4 ff ff       	jmp    80106099 <alltraps>

80106c43 <vector141>:
.globl vector141
vector141:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $141
80106c45:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106c4a:	e9 4a f4 ff ff       	jmp    80106099 <alltraps>

80106c4f <vector142>:
.globl vector142
vector142:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $142
80106c51:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106c56:	e9 3e f4 ff ff       	jmp    80106099 <alltraps>

80106c5b <vector143>:
.globl vector143
vector143:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $143
80106c5d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106c62:	e9 32 f4 ff ff       	jmp    80106099 <alltraps>

80106c67 <vector144>:
.globl vector144
vector144:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $144
80106c69:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106c6e:	e9 26 f4 ff ff       	jmp    80106099 <alltraps>

80106c73 <vector145>:
.globl vector145
vector145:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $145
80106c75:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106c7a:	e9 1a f4 ff ff       	jmp    80106099 <alltraps>

80106c7f <vector146>:
.globl vector146
vector146:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $146
80106c81:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106c86:	e9 0e f4 ff ff       	jmp    80106099 <alltraps>

80106c8b <vector147>:
.globl vector147
vector147:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $147
80106c8d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106c92:	e9 02 f4 ff ff       	jmp    80106099 <alltraps>

80106c97 <vector148>:
.globl vector148
vector148:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $148
80106c99:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106c9e:	e9 f6 f3 ff ff       	jmp    80106099 <alltraps>

80106ca3 <vector149>:
.globl vector149
vector149:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $149
80106ca5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106caa:	e9 ea f3 ff ff       	jmp    80106099 <alltraps>

80106caf <vector150>:
.globl vector150
vector150:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $150
80106cb1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106cb6:	e9 de f3 ff ff       	jmp    80106099 <alltraps>

80106cbb <vector151>:
.globl vector151
vector151:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $151
80106cbd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106cc2:	e9 d2 f3 ff ff       	jmp    80106099 <alltraps>

80106cc7 <vector152>:
.globl vector152
vector152:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $152
80106cc9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106cce:	e9 c6 f3 ff ff       	jmp    80106099 <alltraps>

80106cd3 <vector153>:
.globl vector153
vector153:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $153
80106cd5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106cda:	e9 ba f3 ff ff       	jmp    80106099 <alltraps>

80106cdf <vector154>:
.globl vector154
vector154:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $154
80106ce1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106ce6:	e9 ae f3 ff ff       	jmp    80106099 <alltraps>

80106ceb <vector155>:
.globl vector155
vector155:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $155
80106ced:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106cf2:	e9 a2 f3 ff ff       	jmp    80106099 <alltraps>

80106cf7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $156
80106cf9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106cfe:	e9 96 f3 ff ff       	jmp    80106099 <alltraps>

80106d03 <vector157>:
.globl vector157
vector157:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $157
80106d05:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106d0a:	e9 8a f3 ff ff       	jmp    80106099 <alltraps>

80106d0f <vector158>:
.globl vector158
vector158:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $158
80106d11:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106d16:	e9 7e f3 ff ff       	jmp    80106099 <alltraps>

80106d1b <vector159>:
.globl vector159
vector159:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $159
80106d1d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106d22:	e9 72 f3 ff ff       	jmp    80106099 <alltraps>

80106d27 <vector160>:
.globl vector160
vector160:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $160
80106d29:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106d2e:	e9 66 f3 ff ff       	jmp    80106099 <alltraps>

80106d33 <vector161>:
.globl vector161
vector161:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $161
80106d35:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106d3a:	e9 5a f3 ff ff       	jmp    80106099 <alltraps>

80106d3f <vector162>:
.globl vector162
vector162:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $162
80106d41:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106d46:	e9 4e f3 ff ff       	jmp    80106099 <alltraps>

80106d4b <vector163>:
.globl vector163
vector163:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $163
80106d4d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106d52:	e9 42 f3 ff ff       	jmp    80106099 <alltraps>

80106d57 <vector164>:
.globl vector164
vector164:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $164
80106d59:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106d5e:	e9 36 f3 ff ff       	jmp    80106099 <alltraps>

80106d63 <vector165>:
.globl vector165
vector165:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $165
80106d65:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106d6a:	e9 2a f3 ff ff       	jmp    80106099 <alltraps>

80106d6f <vector166>:
.globl vector166
vector166:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $166
80106d71:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106d76:	e9 1e f3 ff ff       	jmp    80106099 <alltraps>

80106d7b <vector167>:
.globl vector167
vector167:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $167
80106d7d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106d82:	e9 12 f3 ff ff       	jmp    80106099 <alltraps>

80106d87 <vector168>:
.globl vector168
vector168:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $168
80106d89:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106d8e:	e9 06 f3 ff ff       	jmp    80106099 <alltraps>

80106d93 <vector169>:
.globl vector169
vector169:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $169
80106d95:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106d9a:	e9 fa f2 ff ff       	jmp    80106099 <alltraps>

80106d9f <vector170>:
.globl vector170
vector170:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $170
80106da1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106da6:	e9 ee f2 ff ff       	jmp    80106099 <alltraps>

80106dab <vector171>:
.globl vector171
vector171:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $171
80106dad:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106db2:	e9 e2 f2 ff ff       	jmp    80106099 <alltraps>

80106db7 <vector172>:
.globl vector172
vector172:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $172
80106db9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106dbe:	e9 d6 f2 ff ff       	jmp    80106099 <alltraps>

80106dc3 <vector173>:
.globl vector173
vector173:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $173
80106dc5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106dca:	e9 ca f2 ff ff       	jmp    80106099 <alltraps>

80106dcf <vector174>:
.globl vector174
vector174:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $174
80106dd1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106dd6:	e9 be f2 ff ff       	jmp    80106099 <alltraps>

80106ddb <vector175>:
.globl vector175
vector175:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $175
80106ddd:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106de2:	e9 b2 f2 ff ff       	jmp    80106099 <alltraps>

80106de7 <vector176>:
.globl vector176
vector176:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $176
80106de9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106dee:	e9 a6 f2 ff ff       	jmp    80106099 <alltraps>

80106df3 <vector177>:
.globl vector177
vector177:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $177
80106df5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106dfa:	e9 9a f2 ff ff       	jmp    80106099 <alltraps>

80106dff <vector178>:
.globl vector178
vector178:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $178
80106e01:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106e06:	e9 8e f2 ff ff       	jmp    80106099 <alltraps>

80106e0b <vector179>:
.globl vector179
vector179:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $179
80106e0d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106e12:	e9 82 f2 ff ff       	jmp    80106099 <alltraps>

80106e17 <vector180>:
.globl vector180
vector180:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $180
80106e19:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106e1e:	e9 76 f2 ff ff       	jmp    80106099 <alltraps>

80106e23 <vector181>:
.globl vector181
vector181:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $181
80106e25:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106e2a:	e9 6a f2 ff ff       	jmp    80106099 <alltraps>

80106e2f <vector182>:
.globl vector182
vector182:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $182
80106e31:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106e36:	e9 5e f2 ff ff       	jmp    80106099 <alltraps>

80106e3b <vector183>:
.globl vector183
vector183:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $183
80106e3d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106e42:	e9 52 f2 ff ff       	jmp    80106099 <alltraps>

80106e47 <vector184>:
.globl vector184
vector184:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $184
80106e49:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106e4e:	e9 46 f2 ff ff       	jmp    80106099 <alltraps>

80106e53 <vector185>:
.globl vector185
vector185:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $185
80106e55:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106e5a:	e9 3a f2 ff ff       	jmp    80106099 <alltraps>

80106e5f <vector186>:
.globl vector186
vector186:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $186
80106e61:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106e66:	e9 2e f2 ff ff       	jmp    80106099 <alltraps>

80106e6b <vector187>:
.globl vector187
vector187:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $187
80106e6d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106e72:	e9 22 f2 ff ff       	jmp    80106099 <alltraps>

80106e77 <vector188>:
.globl vector188
vector188:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $188
80106e79:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106e7e:	e9 16 f2 ff ff       	jmp    80106099 <alltraps>

80106e83 <vector189>:
.globl vector189
vector189:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $189
80106e85:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106e8a:	e9 0a f2 ff ff       	jmp    80106099 <alltraps>

80106e8f <vector190>:
.globl vector190
vector190:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $190
80106e91:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106e96:	e9 fe f1 ff ff       	jmp    80106099 <alltraps>

80106e9b <vector191>:
.globl vector191
vector191:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $191
80106e9d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106ea2:	e9 f2 f1 ff ff       	jmp    80106099 <alltraps>

80106ea7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $192
80106ea9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106eae:	e9 e6 f1 ff ff       	jmp    80106099 <alltraps>

80106eb3 <vector193>:
.globl vector193
vector193:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $193
80106eb5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106eba:	e9 da f1 ff ff       	jmp    80106099 <alltraps>

80106ebf <vector194>:
.globl vector194
vector194:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $194
80106ec1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106ec6:	e9 ce f1 ff ff       	jmp    80106099 <alltraps>

80106ecb <vector195>:
.globl vector195
vector195:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $195
80106ecd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106ed2:	e9 c2 f1 ff ff       	jmp    80106099 <alltraps>

80106ed7 <vector196>:
.globl vector196
vector196:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $196
80106ed9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106ede:	e9 b6 f1 ff ff       	jmp    80106099 <alltraps>

80106ee3 <vector197>:
.globl vector197
vector197:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $197
80106ee5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106eea:	e9 aa f1 ff ff       	jmp    80106099 <alltraps>

80106eef <vector198>:
.globl vector198
vector198:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $198
80106ef1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106ef6:	e9 9e f1 ff ff       	jmp    80106099 <alltraps>

80106efb <vector199>:
.globl vector199
vector199:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $199
80106efd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106f02:	e9 92 f1 ff ff       	jmp    80106099 <alltraps>

80106f07 <vector200>:
.globl vector200
vector200:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $200
80106f09:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106f0e:	e9 86 f1 ff ff       	jmp    80106099 <alltraps>

80106f13 <vector201>:
.globl vector201
vector201:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $201
80106f15:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106f1a:	e9 7a f1 ff ff       	jmp    80106099 <alltraps>

80106f1f <vector202>:
.globl vector202
vector202:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $202
80106f21:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106f26:	e9 6e f1 ff ff       	jmp    80106099 <alltraps>

80106f2b <vector203>:
.globl vector203
vector203:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $203
80106f2d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106f32:	e9 62 f1 ff ff       	jmp    80106099 <alltraps>

80106f37 <vector204>:
.globl vector204
vector204:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $204
80106f39:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106f3e:	e9 56 f1 ff ff       	jmp    80106099 <alltraps>

80106f43 <vector205>:
.globl vector205
vector205:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $205
80106f45:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106f4a:	e9 4a f1 ff ff       	jmp    80106099 <alltraps>

80106f4f <vector206>:
.globl vector206
vector206:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $206
80106f51:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106f56:	e9 3e f1 ff ff       	jmp    80106099 <alltraps>

80106f5b <vector207>:
.globl vector207
vector207:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $207
80106f5d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106f62:	e9 32 f1 ff ff       	jmp    80106099 <alltraps>

80106f67 <vector208>:
.globl vector208
vector208:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $208
80106f69:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106f6e:	e9 26 f1 ff ff       	jmp    80106099 <alltraps>

80106f73 <vector209>:
.globl vector209
vector209:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $209
80106f75:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106f7a:	e9 1a f1 ff ff       	jmp    80106099 <alltraps>

80106f7f <vector210>:
.globl vector210
vector210:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $210
80106f81:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106f86:	e9 0e f1 ff ff       	jmp    80106099 <alltraps>

80106f8b <vector211>:
.globl vector211
vector211:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $211
80106f8d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106f92:	e9 02 f1 ff ff       	jmp    80106099 <alltraps>

80106f97 <vector212>:
.globl vector212
vector212:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $212
80106f99:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106f9e:	e9 f6 f0 ff ff       	jmp    80106099 <alltraps>

80106fa3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $213
80106fa5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106faa:	e9 ea f0 ff ff       	jmp    80106099 <alltraps>

80106faf <vector214>:
.globl vector214
vector214:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $214
80106fb1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106fb6:	e9 de f0 ff ff       	jmp    80106099 <alltraps>

80106fbb <vector215>:
.globl vector215
vector215:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $215
80106fbd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106fc2:	e9 d2 f0 ff ff       	jmp    80106099 <alltraps>

80106fc7 <vector216>:
.globl vector216
vector216:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $216
80106fc9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106fce:	e9 c6 f0 ff ff       	jmp    80106099 <alltraps>

80106fd3 <vector217>:
.globl vector217
vector217:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $217
80106fd5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106fda:	e9 ba f0 ff ff       	jmp    80106099 <alltraps>

80106fdf <vector218>:
.globl vector218
vector218:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $218
80106fe1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106fe6:	e9 ae f0 ff ff       	jmp    80106099 <alltraps>

80106feb <vector219>:
.globl vector219
vector219:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $219
80106fed:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106ff2:	e9 a2 f0 ff ff       	jmp    80106099 <alltraps>

80106ff7 <vector220>:
.globl vector220
vector220:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $220
80106ff9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106ffe:	e9 96 f0 ff ff       	jmp    80106099 <alltraps>

80107003 <vector221>:
.globl vector221
vector221:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $221
80107005:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010700a:	e9 8a f0 ff ff       	jmp    80106099 <alltraps>

8010700f <vector222>:
.globl vector222
vector222:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $222
80107011:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107016:	e9 7e f0 ff ff       	jmp    80106099 <alltraps>

8010701b <vector223>:
.globl vector223
vector223:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $223
8010701d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107022:	e9 72 f0 ff ff       	jmp    80106099 <alltraps>

80107027 <vector224>:
.globl vector224
vector224:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $224
80107029:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010702e:	e9 66 f0 ff ff       	jmp    80106099 <alltraps>

80107033 <vector225>:
.globl vector225
vector225:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $225
80107035:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010703a:	e9 5a f0 ff ff       	jmp    80106099 <alltraps>

8010703f <vector226>:
.globl vector226
vector226:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $226
80107041:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107046:	e9 4e f0 ff ff       	jmp    80106099 <alltraps>

8010704b <vector227>:
.globl vector227
vector227:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $227
8010704d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107052:	e9 42 f0 ff ff       	jmp    80106099 <alltraps>

80107057 <vector228>:
.globl vector228
vector228:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $228
80107059:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010705e:	e9 36 f0 ff ff       	jmp    80106099 <alltraps>

80107063 <vector229>:
.globl vector229
vector229:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $229
80107065:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010706a:	e9 2a f0 ff ff       	jmp    80106099 <alltraps>

8010706f <vector230>:
.globl vector230
vector230:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $230
80107071:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107076:	e9 1e f0 ff ff       	jmp    80106099 <alltraps>

8010707b <vector231>:
.globl vector231
vector231:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $231
8010707d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107082:	e9 12 f0 ff ff       	jmp    80106099 <alltraps>

80107087 <vector232>:
.globl vector232
vector232:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $232
80107089:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010708e:	e9 06 f0 ff ff       	jmp    80106099 <alltraps>

80107093 <vector233>:
.globl vector233
vector233:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $233
80107095:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010709a:	e9 fa ef ff ff       	jmp    80106099 <alltraps>

8010709f <vector234>:
.globl vector234
vector234:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $234
801070a1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801070a6:	e9 ee ef ff ff       	jmp    80106099 <alltraps>

801070ab <vector235>:
.globl vector235
vector235:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $235
801070ad:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801070b2:	e9 e2 ef ff ff       	jmp    80106099 <alltraps>

801070b7 <vector236>:
.globl vector236
vector236:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $236
801070b9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801070be:	e9 d6 ef ff ff       	jmp    80106099 <alltraps>

801070c3 <vector237>:
.globl vector237
vector237:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $237
801070c5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801070ca:	e9 ca ef ff ff       	jmp    80106099 <alltraps>

801070cf <vector238>:
.globl vector238
vector238:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $238
801070d1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801070d6:	e9 be ef ff ff       	jmp    80106099 <alltraps>

801070db <vector239>:
.globl vector239
vector239:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $239
801070dd:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801070e2:	e9 b2 ef ff ff       	jmp    80106099 <alltraps>

801070e7 <vector240>:
.globl vector240
vector240:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $240
801070e9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801070ee:	e9 a6 ef ff ff       	jmp    80106099 <alltraps>

801070f3 <vector241>:
.globl vector241
vector241:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $241
801070f5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801070fa:	e9 9a ef ff ff       	jmp    80106099 <alltraps>

801070ff <vector242>:
.globl vector242
vector242:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $242
80107101:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107106:	e9 8e ef ff ff       	jmp    80106099 <alltraps>

8010710b <vector243>:
.globl vector243
vector243:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $243
8010710d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107112:	e9 82 ef ff ff       	jmp    80106099 <alltraps>

80107117 <vector244>:
.globl vector244
vector244:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $244
80107119:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010711e:	e9 76 ef ff ff       	jmp    80106099 <alltraps>

80107123 <vector245>:
.globl vector245
vector245:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $245
80107125:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010712a:	e9 6a ef ff ff       	jmp    80106099 <alltraps>

8010712f <vector246>:
.globl vector246
vector246:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $246
80107131:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107136:	e9 5e ef ff ff       	jmp    80106099 <alltraps>

8010713b <vector247>:
.globl vector247
vector247:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $247
8010713d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107142:	e9 52 ef ff ff       	jmp    80106099 <alltraps>

80107147 <vector248>:
.globl vector248
vector248:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $248
80107149:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010714e:	e9 46 ef ff ff       	jmp    80106099 <alltraps>

80107153 <vector249>:
.globl vector249
vector249:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $249
80107155:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010715a:	e9 3a ef ff ff       	jmp    80106099 <alltraps>

8010715f <vector250>:
.globl vector250
vector250:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $250
80107161:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107166:	e9 2e ef ff ff       	jmp    80106099 <alltraps>

8010716b <vector251>:
.globl vector251
vector251:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $251
8010716d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107172:	e9 22 ef ff ff       	jmp    80106099 <alltraps>

80107177 <vector252>:
.globl vector252
vector252:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $252
80107179:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010717e:	e9 16 ef ff ff       	jmp    80106099 <alltraps>

80107183 <vector253>:
.globl vector253
vector253:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $253
80107185:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010718a:	e9 0a ef ff ff       	jmp    80106099 <alltraps>

8010718f <vector254>:
.globl vector254
vector254:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $254
80107191:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107196:	e9 fe ee ff ff       	jmp    80106099 <alltraps>

8010719b <vector255>:
.globl vector255
vector255:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $255
8010719d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801071a2:	e9 f2 ee ff ff       	jmp    80106099 <alltraps>
801071a7:	66 90                	xchg   %ax,%ax
801071a9:	66 90                	xchg   %ax,%ax
801071ab:	66 90                	xchg   %ax,%ax
801071ad:	66 90                	xchg   %ax,%ax
801071af:	90                   	nop

801071b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801071b6:	89 d3                	mov    %edx,%ebx
{
801071b8:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
801071ba:	c1 eb 16             	shr    $0x16,%ebx
801071bd:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
801071c0:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801071c3:	8b 06                	mov    (%esi),%eax
801071c5:	a8 01                	test   $0x1,%al
801071c7:	74 27                	je     801071f0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071ce:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801071d4:	c1 ef 0a             	shr    $0xa,%edi
}
801071d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801071da:	89 fa                	mov    %edi,%edx
801071dc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801071e2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801071e5:	5b                   	pop    %ebx
801071e6:	5e                   	pop    %esi
801071e7:	5f                   	pop    %edi
801071e8:	5d                   	pop    %ebp
801071e9:	c3                   	ret    
801071ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801071f0:	85 c9                	test   %ecx,%ecx
801071f2:	74 2c                	je     80107220 <walkpgdir+0x70>
801071f4:	e8 47 b8 ff ff       	call   80102a40 <kalloc>
801071f9:	85 c0                	test   %eax,%eax
801071fb:	89 c3                	mov    %eax,%ebx
801071fd:	74 21                	je     80107220 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801071ff:	83 ec 04             	sub    $0x4,%esp
80107202:	68 00 10 00 00       	push   $0x1000
80107207:	6a 00                	push   $0x0
80107209:	50                   	push   %eax
8010720a:	e8 61 dc ff ff       	call   80104e70 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010720f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107215:	83 c4 10             	add    $0x10,%esp
80107218:	83 c8 07             	or     $0x7,%eax
8010721b:	89 06                	mov    %eax,(%esi)
8010721d:	eb b5                	jmp    801071d4 <walkpgdir+0x24>
8010721f:	90                   	nop
}
80107220:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107223:	31 c0                	xor    %eax,%eax
}
80107225:	5b                   	pop    %ebx
80107226:	5e                   	pop    %esi
80107227:	5f                   	pop    %edi
80107228:	5d                   	pop    %ebp
80107229:	c3                   	ret    
8010722a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107230 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107236:	89 d3                	mov    %edx,%ebx
80107238:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010723e:	83 ec 1c             	sub    $0x1c,%esp
80107241:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107244:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107248:	8b 7d 08             	mov    0x8(%ebp),%edi
8010724b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107250:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107253:	8b 45 0c             	mov    0xc(%ebp),%eax
80107256:	29 df                	sub    %ebx,%edi
80107258:	83 c8 01             	or     $0x1,%eax
8010725b:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010725e:	eb 15                	jmp    80107275 <mappages+0x45>
    if(*pte & PTE_P)
80107260:	f6 00 01             	testb  $0x1,(%eax)
80107263:	75 45                	jne    801072aa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80107265:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107268:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
8010726b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010726d:	74 31                	je     801072a0 <mappages+0x70>
      break;
    a += PGSIZE;
8010726f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107275:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107278:	b9 01 00 00 00       	mov    $0x1,%ecx
8010727d:	89 da                	mov    %ebx,%edx
8010727f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107282:	e8 29 ff ff ff       	call   801071b0 <walkpgdir>
80107287:	85 c0                	test   %eax,%eax
80107289:	75 d5                	jne    80107260 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010728b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010728e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107293:	5b                   	pop    %ebx
80107294:	5e                   	pop    %esi
80107295:	5f                   	pop    %edi
80107296:	5d                   	pop    %ebp
80107297:	c3                   	ret    
80107298:	90                   	nop
80107299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801072a3:	31 c0                	xor    %eax,%eax
}
801072a5:	5b                   	pop    %ebx
801072a6:	5e                   	pop    %esi
801072a7:	5f                   	pop    %edi
801072a8:	5d                   	pop    %ebp
801072a9:	c3                   	ret    
      panic("remap");
801072aa:	83 ec 0c             	sub    $0xc,%esp
801072ad:	68 44 91 10 80       	push   $0x80109144
801072b2:	e8 d9 90 ff ff       	call   80100390 <panic>
801072b7:	89 f6                	mov    %esi,%esi
801072b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072c0 <seginit>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801072c6:	e8 a5 cc ff ff       	call   80103f70 <cpuid>
801072cb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801072d1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801072d6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801072da:	c7 80 18 c8 14 80 ff 	movl   $0xffff,-0x7feb37e8(%eax)
801072e1:	ff 00 00 
801072e4:	c7 80 1c c8 14 80 00 	movl   $0xcf9a00,-0x7feb37e4(%eax)
801072eb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801072ee:	c7 80 20 c8 14 80 ff 	movl   $0xffff,-0x7feb37e0(%eax)
801072f5:	ff 00 00 
801072f8:	c7 80 24 c8 14 80 00 	movl   $0xcf9200,-0x7feb37dc(%eax)
801072ff:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107302:	c7 80 28 c8 14 80 ff 	movl   $0xffff,-0x7feb37d8(%eax)
80107309:	ff 00 00 
8010730c:	c7 80 2c c8 14 80 00 	movl   $0xcffa00,-0x7feb37d4(%eax)
80107313:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107316:	c7 80 30 c8 14 80 ff 	movl   $0xffff,-0x7feb37d0(%eax)
8010731d:	ff 00 00 
80107320:	c7 80 34 c8 14 80 00 	movl   $0xcff200,-0x7feb37cc(%eax)
80107327:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010732a:	05 10 c8 14 80       	add    $0x8014c810,%eax
  pd[1] = (uint)p;
8010732f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107333:	c1 e8 10             	shr    $0x10,%eax
80107336:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010733a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010733d:	0f 01 10             	lgdtl  (%eax)
}
80107340:	c9                   	leave  
80107341:	c3                   	ret    
80107342:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107350 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107350:	a1 c4 a9 15 80       	mov    0x8015a9c4,%eax
{
80107355:	55                   	push   %ebp
80107356:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107358:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010735d:	0f 22 d8             	mov    %eax,%cr3
}
80107360:	5d                   	pop    %ebp
80107361:	c3                   	ret    
80107362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107370 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107370:	55                   	push   %ebp
80107371:	89 e5                	mov    %esp,%ebp
80107373:	57                   	push   %edi
80107374:	56                   	push   %esi
80107375:	53                   	push   %ebx
80107376:	83 ec 1c             	sub    $0x1c,%esp
80107379:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010737c:	85 db                	test   %ebx,%ebx
8010737e:	0f 84 cb 00 00 00    	je     8010744f <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107384:	8b 43 08             	mov    0x8(%ebx),%eax
80107387:	85 c0                	test   %eax,%eax
80107389:	0f 84 da 00 00 00    	je     80107469 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010738f:	8b 43 04             	mov    0x4(%ebx),%eax
80107392:	85 c0                	test   %eax,%eax
80107394:	0f 84 c2 00 00 00    	je     8010745c <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
8010739a:	e8 f1 d8 ff ff       	call   80104c90 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010739f:	e8 4c cb ff ff       	call   80103ef0 <mycpu>
801073a4:	89 c6                	mov    %eax,%esi
801073a6:	e8 45 cb ff ff       	call   80103ef0 <mycpu>
801073ab:	89 c7                	mov    %eax,%edi
801073ad:	e8 3e cb ff ff       	call   80103ef0 <mycpu>
801073b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073b5:	83 c7 08             	add    $0x8,%edi
801073b8:	e8 33 cb ff ff       	call   80103ef0 <mycpu>
801073bd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801073c0:	83 c0 08             	add    $0x8,%eax
801073c3:	ba 67 00 00 00       	mov    $0x67,%edx
801073c8:	c1 e8 18             	shr    $0x18,%eax
801073cb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801073d2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801073d9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801073df:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801073e4:	83 c1 08             	add    $0x8,%ecx
801073e7:	c1 e9 10             	shr    $0x10,%ecx
801073ea:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801073f0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801073f5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801073fc:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107401:	e8 ea ca ff ff       	call   80103ef0 <mycpu>
80107406:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010740d:	e8 de ca ff ff       	call   80103ef0 <mycpu>
80107412:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107416:	8b 73 08             	mov    0x8(%ebx),%esi
80107419:	e8 d2 ca ff ff       	call   80103ef0 <mycpu>
8010741e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107424:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107427:	e8 c4 ca ff ff       	call   80103ef0 <mycpu>
8010742c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107430:	b8 28 00 00 00       	mov    $0x28,%eax
80107435:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107438:	8b 43 04             	mov    0x4(%ebx),%eax
8010743b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107440:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80107443:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107446:	5b                   	pop    %ebx
80107447:	5e                   	pop    %esi
80107448:	5f                   	pop    %edi
80107449:	5d                   	pop    %ebp
  popcli();
8010744a:	e9 81 d8 ff ff       	jmp    80104cd0 <popcli>
    panic("switchuvm: no process");
8010744f:	83 ec 0c             	sub    $0xc,%esp
80107452:	68 4a 91 10 80       	push   $0x8010914a
80107457:	e8 34 8f ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010745c:	83 ec 0c             	sub    $0xc,%esp
8010745f:	68 75 91 10 80       	push   $0x80109175
80107464:	e8 27 8f ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107469:	83 ec 0c             	sub    $0xc,%esp
8010746c:	68 60 91 10 80       	push   $0x80109160
80107471:	e8 1a 8f ff ff       	call   80100390 <panic>
80107476:	8d 76 00             	lea    0x0(%esi),%esi
80107479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107480 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
80107486:	83 ec 1c             	sub    $0x1c,%esp
80107489:	8b 75 10             	mov    0x10(%ebp),%esi
8010748c:	8b 45 08             	mov    0x8(%ebp),%eax
8010748f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107492:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107498:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010749b:	77 49                	ja     801074e6 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010749d:	e8 9e b5 ff ff       	call   80102a40 <kalloc>
  memset(mem, 0, PGSIZE);
801074a2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801074a5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801074a7:	68 00 10 00 00       	push   $0x1000
801074ac:	6a 00                	push   $0x0
801074ae:	50                   	push   %eax
801074af:	e8 bc d9 ff ff       	call   80104e70 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801074b4:	58                   	pop    %eax
801074b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074bb:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074c0:	5a                   	pop    %edx
801074c1:	6a 06                	push   $0x6
801074c3:	50                   	push   %eax
801074c4:	31 d2                	xor    %edx,%edx
801074c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074c9:	e8 62 fd ff ff       	call   80107230 <mappages>
  memmove(mem, init, sz);
801074ce:	89 75 10             	mov    %esi,0x10(%ebp)
801074d1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801074d4:	83 c4 10             	add    $0x10,%esp
801074d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801074da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074dd:	5b                   	pop    %ebx
801074de:	5e                   	pop    %esi
801074df:	5f                   	pop    %edi
801074e0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801074e1:	e9 3a da ff ff       	jmp    80104f20 <memmove>
    panic("inituvm: more than a page");
801074e6:	83 ec 0c             	sub    $0xc,%esp
801074e9:	68 89 91 10 80       	push   $0x80109189
801074ee:	e8 9d 8e ff ff       	call   80100390 <panic>
801074f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107500 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107500:	55                   	push   %ebp
80107501:	89 e5                	mov    %esp,%ebp
80107503:	57                   	push   %edi
80107504:	56                   	push   %esi
80107505:	53                   	push   %ebx
80107506:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107509:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107510:	0f 85 91 00 00 00    	jne    801075a7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107516:	8b 75 18             	mov    0x18(%ebp),%esi
80107519:	31 db                	xor    %ebx,%ebx
8010751b:	85 f6                	test   %esi,%esi
8010751d:	75 1a                	jne    80107539 <loaduvm+0x39>
8010751f:	eb 6f                	jmp    80107590 <loaduvm+0x90>
80107521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107528:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010752e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107534:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107537:	76 57                	jbe    80107590 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107539:	8b 55 0c             	mov    0xc(%ebp),%edx
8010753c:	8b 45 08             	mov    0x8(%ebp),%eax
8010753f:	31 c9                	xor    %ecx,%ecx
80107541:	01 da                	add    %ebx,%edx
80107543:	e8 68 fc ff ff       	call   801071b0 <walkpgdir>
80107548:	85 c0                	test   %eax,%eax
8010754a:	74 4e                	je     8010759a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010754c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010754e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107551:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107556:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010755b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107561:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107564:	01 d9                	add    %ebx,%ecx
80107566:	05 00 00 00 80       	add    $0x80000000,%eax
8010756b:	57                   	push   %edi
8010756c:	51                   	push   %ecx
8010756d:	50                   	push   %eax
8010756e:	ff 75 10             	pushl  0x10(%ebp)
80107571:	e8 4a a5 ff ff       	call   80101ac0 <readi>
80107576:	83 c4 10             	add    $0x10,%esp
80107579:	39 f8                	cmp    %edi,%eax
8010757b:	74 ab                	je     80107528 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
8010757d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
8010758a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107590:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107593:	31 c0                	xor    %eax,%eax
}
80107595:	5b                   	pop    %ebx
80107596:	5e                   	pop    %esi
80107597:	5f                   	pop    %edi
80107598:	5d                   	pop    %ebp
80107599:	c3                   	ret    
      panic("loaduvm: address should exist");
8010759a:	83 ec 0c             	sub    $0xc,%esp
8010759d:	68 a3 91 10 80       	push   $0x801091a3
801075a2:	e8 e9 8d ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801075a7:	83 ec 0c             	sub    $0xc,%esp
801075aa:	68 d8 92 10 80       	push   $0x801092d8
801075af:	e8 dc 8d ff ff       	call   80100390 <panic>
801075b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801075c0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801075c0:	55                   	push   %ebp
801075c1:	89 e5                	mov    %esp,%ebp
801075c3:	57                   	push   %edi
801075c4:	56                   	push   %esi
801075c5:	53                   	push   %ebx
801075c6:	83 ec 1c             	sub    $0x1c,%esp
  #ifndef NONE
    struct proc *p = myproc();
801075c9:	e8 c2 c9 ff ff       	call   80103f90 <myproc>
801075ce:	89 45 dc             	mov    %eax,-0x24(%ebp)
  #endif

  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
801075d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801075d4:	39 45 10             	cmp    %eax,0x10(%ebp)
801075d7:	0f 83 23 01 00 00    	jae    80107700 <deallocuvm+0x140>
    cprintf("\n%d  %d\n",oldsz,newsz);
    return oldsz;
  }

  a = PGROUNDUP(newsz);
801075dd:	8b 45 10             	mov    0x10(%ebp),%eax
801075e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801075e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801075ec:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801075ef:	77 1c                	ja     8010760d <deallocuvm+0x4d>
801075f1:	eb 43                	jmp    80107636 <deallocuvm+0x76>
801075f3:	90                   	nop
801075f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801075f8:	8b 30                	mov    (%eax),%esi
801075fa:	f7 c6 01 00 00 00    	test   $0x1,%esi
80107600:	75 46                	jne    80107648 <deallocuvm+0x88>
  for(; a  < oldsz; a += PGSIZE){
80107602:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107608:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010760b:	76 29                	jbe    80107636 <deallocuvm+0x76>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010760d:	8b 45 08             	mov    0x8(%ebp),%eax
80107610:	31 c9                	xor    %ecx,%ecx
80107612:	89 da                	mov    %ebx,%edx
80107614:	e8 97 fb ff ff       	call   801071b0 <walkpgdir>
    if(!pte)
80107619:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
8010761b:	89 c7                	mov    %eax,%edi
    if(!pte)
8010761d:	75 d9                	jne    801075f8 <deallocuvm+0x38>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010761f:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107625:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010762b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107631:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80107634:	77 d7                	ja     8010760d <deallocuvm+0x4d>
      #endif
      *pte = 0;
  
    }
  }
  return newsz;
80107636:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107639:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010763c:	5b                   	pop    %ebx
8010763d:	5e                   	pop    %esi
8010763e:	5f                   	pop    %edi
8010763f:	5d                   	pop    %ebp
80107640:	c3                   	ret    
80107641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80107648:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
8010764e:	0f 84 cb 00 00 00    	je     8010771f <deallocuvm+0x15f>
      p->nPgsPhysical--;
80107654:	8b 55 dc             	mov    -0x24(%ebp),%edx
      kfree(v);
80107657:	83 ec 0c             	sub    $0xc,%esp
      p->nPgsPhysical--;
8010765a:	8b 82 80 00 00 00    	mov    0x80(%edx),%eax
80107660:	83 e8 01             	sub    $0x1,%eax
80107663:	89 82 80 00 00 00    	mov    %eax,0x80(%edx)
      p->allocatedInPhys--;
80107669:	8b 82 88 00 00 00    	mov    0x88(%edx),%eax
8010766f:	83 e8 01             	sub    $0x1,%eax
80107672:	89 82 88 00 00 00    	mov    %eax,0x88(%edx)
      char *v = P2V(pa);
80107678:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
      for(i = 0; i < MAX_PSYC_PAGES; i++){
8010767e:	31 f6                	xor    %esi,%esi
      kfree(v);
80107680:	50                   	push   %eax
80107681:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107684:	e8 77 b1 ff ff       	call   80102800 <kfree>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
80107689:	89 5d e0             	mov    %ebx,-0x20(%ebp)
      kfree(v);
8010768c:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < MAX_PSYC_PAGES; i++){
8010768f:	89 f3                	mov    %esi,%ebx
80107691:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80107694:	eb 12                	jmp    801076a8 <deallocuvm+0xe8>
80107696:	8d 76 00             	lea    0x0(%esi),%esi
80107699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801076a0:	83 c3 01             	add    $0x1,%ebx
801076a3:	83 fb 10             	cmp    $0x10,%ebx
801076a6:	74 50                	je     801076f8 <deallocuvm+0x138>
          if(myproc()->physicalPGs[i].va == (char*)v){
801076a8:	e8 e3 c8 ff ff       	call   80103f90 <myproc>
801076ad:	8d 0c 5b             	lea    (%ebx,%ebx,2),%ecx
801076b0:	c1 e1 03             	shl    $0x3,%ecx
801076b3:	39 b4 08 d0 01 00 00 	cmp    %esi,0x1d0(%eax,%ecx,1)
801076ba:	75 e4                	jne    801076a0 <deallocuvm+0xe0>
801076bc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801076bf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
            myproc()->physicalPGs[i].va = (char*) 0xffffffff;
801076c2:	e8 c9 c8 ff ff       	call   80103f90 <myproc>
801076c7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801076ca:	c7 84 08 d0 01 00 00 	movl   $0xffffffff,0x1d0(%eax,%ecx,1)
801076d1:	ff ff ff ff 
            myproc()->physicalPGs[i].alloceted = 0;
801076d5:	e8 b6 c8 ff ff       	call   80103f90 <myproc>
801076da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801076dd:	c7 84 08 dc 01 00 00 	movl   $0x0,0x1dc(%eax,%ecx,1)
801076e4:	00 00 00 00 
      *pte = 0;
801076e8:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801076ee:	e9 0f ff ff ff       	jmp    80107602 <deallocuvm+0x42>
801076f3:	90                   	nop
801076f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076f8:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801076fb:	eb eb                	jmp    801076e8 <deallocuvm+0x128>
801076fd:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("\n%d  %d\n",oldsz,newsz);
80107700:	83 ec 04             	sub    $0x4,%esp
80107703:	ff 75 10             	pushl  0x10(%ebp)
80107706:	50                   	push   %eax
80107707:	68 c1 91 10 80       	push   $0x801091c1
8010770c:	e8 4f 8f ff ff       	call   80100660 <cprintf>
    return oldsz;
80107711:	8b 45 0c             	mov    0xc(%ebp),%eax
80107714:	83 c4 10             	add    $0x10,%esp
}
80107717:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010771a:	5b                   	pop    %ebx
8010771b:	5e                   	pop    %esi
8010771c:	5f                   	pop    %edi
8010771d:	5d                   	pop    %ebp
8010771e:	c3                   	ret    
        panic("kfree");
8010771f:	83 ec 0c             	sub    $0xc,%esp
80107722:	68 ca 89 10 80       	push   $0x801089ca
80107727:	e8 64 8c ff ff       	call   80100390 <panic>
8010772c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107730 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107730:	55                   	push   %ebp
80107731:	89 e5                	mov    %esp,%ebp
80107733:	57                   	push   %edi
80107734:	56                   	push   %esi
80107735:	53                   	push   %ebx
80107736:	83 ec 0c             	sub    $0xc,%esp
80107739:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010773c:	85 f6                	test   %esi,%esi
8010773e:	74 59                	je     80107799 <freevm+0x69>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80107740:	83 ec 04             	sub    $0x4,%esp
80107743:	89 f3                	mov    %esi,%ebx
80107745:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010774b:	6a 00                	push   $0x0
8010774d:	68 00 00 00 80       	push   $0x80000000
80107752:	56                   	push   %esi
80107753:	e8 68 fe ff ff       	call   801075c0 <deallocuvm>
80107758:	83 c4 10             	add    $0x10,%esp
8010775b:	eb 0a                	jmp    80107767 <freevm+0x37>
8010775d:	8d 76 00             	lea    0x0(%esi),%esi
80107760:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
80107763:	39 fb                	cmp    %edi,%ebx
80107765:	74 23                	je     8010778a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107767:	8b 03                	mov    (%ebx),%eax
80107769:	a8 01                	test   $0x1,%al
8010776b:	74 f3                	je     80107760 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010776d:	25 00 f0 ff ff       	and    $0xfffff000,%eax

      kfree(v);
80107772:	83 ec 0c             	sub    $0xc,%esp
80107775:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107778:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010777d:	50                   	push   %eax
8010777e:	e8 7d b0 ff ff       	call   80102800 <kfree>
80107783:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107786:	39 fb                	cmp    %edi,%ebx
80107788:	75 dd                	jne    80107767 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010778a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010778d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107790:	5b                   	pop    %ebx
80107791:	5e                   	pop    %esi
80107792:	5f                   	pop    %edi
80107793:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107794:	e9 67 b0 ff ff       	jmp    80102800 <kfree>
    panic("freevm: no pgdir");
80107799:	83 ec 0c             	sub    $0xc,%esp
8010779c:	68 ca 91 10 80       	push   $0x801091ca
801077a1:	e8 ea 8b ff ff       	call   80100390 <panic>
801077a6:	8d 76 00             	lea    0x0(%esi),%esi
801077a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801077b0 <setupkvm>:
{
801077b0:	55                   	push   %ebp
801077b1:	89 e5                	mov    %esp,%ebp
801077b3:	56                   	push   %esi
801077b4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801077b5:	e8 86 b2 ff ff       	call   80102a40 <kalloc>
801077ba:	85 c0                	test   %eax,%eax
801077bc:	89 c6                	mov    %eax,%esi
801077be:	74 42                	je     80107802 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801077c0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801077c3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801077c8:	68 00 10 00 00       	push   $0x1000
801077cd:	6a 00                	push   $0x0
801077cf:	50                   	push   %eax
801077d0:	e8 9b d6 ff ff       	call   80104e70 <memset>
801077d5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801077d8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801077db:	8b 4b 08             	mov    0x8(%ebx),%ecx
801077de:	83 ec 08             	sub    $0x8,%esp
801077e1:	8b 13                	mov    (%ebx),%edx
801077e3:	ff 73 0c             	pushl  0xc(%ebx)
801077e6:	50                   	push   %eax
801077e7:	29 c1                	sub    %eax,%ecx
801077e9:	89 f0                	mov    %esi,%eax
801077eb:	e8 40 fa ff ff       	call   80107230 <mappages>
801077f0:	83 c4 10             	add    $0x10,%esp
801077f3:	85 c0                	test   %eax,%eax
801077f5:	78 19                	js     80107810 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801077f7:	83 c3 10             	add    $0x10,%ebx
801077fa:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80107800:	75 d6                	jne    801077d8 <setupkvm+0x28>
}
80107802:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107805:	89 f0                	mov    %esi,%eax
80107807:	5b                   	pop    %ebx
80107808:	5e                   	pop    %esi
80107809:	5d                   	pop    %ebp
8010780a:	c3                   	ret    
8010780b:	90                   	nop
8010780c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107810:	83 ec 0c             	sub    $0xc,%esp
80107813:	56                   	push   %esi
      return 0;
80107814:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107816:	e8 15 ff ff ff       	call   80107730 <freevm>
      return 0;
8010781b:	83 c4 10             	add    $0x10,%esp
}
8010781e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107821:	89 f0                	mov    %esi,%eax
80107823:	5b                   	pop    %ebx
80107824:	5e                   	pop    %esi
80107825:	5d                   	pop    %ebp
80107826:	c3                   	ret    
80107827:	89 f6                	mov    %esi,%esi
80107829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107830 <kvmalloc>:
{
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107836:	e8 75 ff ff ff       	call   801077b0 <setupkvm>
8010783b:	a3 c4 a9 15 80       	mov    %eax,0x8015a9c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107840:	05 00 00 00 80       	add    $0x80000000,%eax
80107845:	0f 22 d8             	mov    %eax,%cr3
}
80107848:	c9                   	leave  
80107849:	c3                   	ret    
8010784a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107850 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107850:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107851:	31 c9                	xor    %ecx,%ecx
{
80107853:	89 e5                	mov    %esp,%ebp
80107855:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107858:	8b 55 0c             	mov    0xc(%ebp),%edx
8010785b:	8b 45 08             	mov    0x8(%ebp),%eax
8010785e:	e8 4d f9 ff ff       	call   801071b0 <walkpgdir>
  if(pte == 0)
80107863:	85 c0                	test   %eax,%eax
80107865:	74 05                	je     8010786c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107867:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010786a:	c9                   	leave  
8010786b:	c3                   	ret    
    panic("clearpteu");
8010786c:	83 ec 0c             	sub    $0xc,%esp
8010786f:	68 db 91 10 80       	push   $0x801091db
80107874:	e8 17 8b ff ff       	call   80100390 <panic>
80107879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107880 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
80107889:	e8 22 ff ff ff       	call   801077b0 <setupkvm>
8010788e:	85 c0                	test   %eax,%eax
80107890:	89 c7                	mov    %eax,%edi
80107892:	0f 84 ad 00 00 00    	je     80107945 <copyuvm+0xc5>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107898:	8b 45 0c             	mov    0xc(%ebp),%eax
8010789b:	85 c0                	test   %eax,%eax
8010789d:	0f 84 97 00 00 00    	je     8010793a <copyuvm+0xba>
801078a3:	31 db                	xor    %ebx,%ebx
801078a5:	eb 55                	jmp    801078fc <copyuvm+0x7c>
801078a7:	89 f6                	mov    %esi,%esi
801078a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      pte = walkpgdir(d,(void*)i,1);
      *pte = PTE_U | PTE_W | PTE_PG;
      continue;
    }
    // Task 1
    *pte = *pte & ~PTE_W;
801078b0:	89 d1                	mov    %edx,%ecx
801078b2:	89 d6                	mov    %edx,%esi
    *pte = *pte | PTE_COW;
  
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
801078b4:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    *pte = *pte & ~PTE_W;
801078ba:	83 e1 fd             	and    $0xfffffffd,%ecx
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801078bd:	83 ec 08             	sub    $0x8,%esp
    flags = PTE_FLAGS(*pte);
801078c0:	80 ce 08             	or     $0x8,%dh
    *pte = *pte | PTE_COW;
801078c3:	80 cd 08             	or     $0x8,%ch
801078c6:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801078cc:	89 08                	mov    %ecx,(%eax)
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
801078ce:	52                   	push   %edx
801078cf:	b9 00 10 00 00       	mov    $0x1000,%ecx
801078d4:	56                   	push   %esi
801078d5:	89 da                	mov    %ebx,%edx
801078d7:	89 f8                	mov    %edi,%eax
801078d9:	e8 52 f9 ff ff       	call   80107230 <mappages>
801078de:	83 c4 10             	add    $0x10,%esp
801078e1:	85 c0                	test   %eax,%eax
801078e3:	78 6b                	js     80107950 <copyuvm+0xd0>
      goto bad;
    }
    incrementReferenceCount(pa);
801078e5:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < sz; i += PGSIZE){
801078e8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    incrementReferenceCount(pa);
801078ee:	56                   	push   %esi
801078ef:	e8 8c b2 ff ff       	call   80102b80 <incrementReferenceCount>
801078f4:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
801078f7:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801078fa:	76 3e                	jbe    8010793a <copyuvm+0xba>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801078fc:	8b 45 08             	mov    0x8(%ebp),%eax
801078ff:	31 c9                	xor    %ecx,%ecx
80107901:	89 da                	mov    %ebx,%edx
80107903:	e8 a8 f8 ff ff       	call   801071b0 <walkpgdir>
80107908:	85 c0                	test   %eax,%eax
8010790a:	74 74                	je     80107980 <copyuvm+0x100>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
8010790c:	8b 10                	mov    (%eax),%edx
8010790e:	f7 c2 01 02 00 00    	test   $0x201,%edx
80107914:	74 5d                	je     80107973 <copyuvm+0xf3>
    if(*pte & PTE_PG){
80107916:	f6 c6 02             	test   $0x2,%dh
80107919:	74 95                	je     801078b0 <copyuvm+0x30>
      pte = walkpgdir(d,(void*)i,1);
8010791b:	89 da                	mov    %ebx,%edx
8010791d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107922:	89 f8                	mov    %edi,%eax
80107924:	e8 87 f8 ff ff       	call   801071b0 <walkpgdir>
  for(i = 0; i < sz; i += PGSIZE){
80107929:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010792f:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
      *pte = PTE_U | PTE_W | PTE_PG;
80107932:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  for(i = 0; i < sz; i += PGSIZE){
80107938:	77 c2                	ja     801078fc <copyuvm+0x7c>
      }
    #endif
    //cprintf("increased to: %d\n",getReferenceCount(pa));
  }
  //panic("shit");
  lcr3(V2P(pgdir));
8010793a:	8b 45 08             	mov    0x8(%ebp),%eax
8010793d:	05 00 00 00 80       	add    $0x80000000,%eax
80107942:	0f 22 d8             	mov    %eax,%cr3

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107945:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107948:	89 f8                	mov    %edi,%eax
8010794a:	5b                   	pop    %ebx
8010794b:	5e                   	pop    %esi
8010794c:	5f                   	pop    %edi
8010794d:	5d                   	pop    %ebp
8010794e:	c3                   	ret    
8010794f:	90                   	nop
  freevm(d);
80107950:	83 ec 0c             	sub    $0xc,%esp
80107953:	57                   	push   %edi
80107954:	e8 d7 fd ff ff       	call   80107730 <freevm>
  lcr3(V2P(pgdir));
80107959:	8b 45 08             	mov    0x8(%ebp),%eax
8010795c:	05 00 00 00 80       	add    $0x80000000,%eax
80107961:	0f 22 d8             	mov    %eax,%cr3
  return 0;
80107964:	83 c4 10             	add    $0x10,%esp
}
80107967:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010796a:	31 ff                	xor    %edi,%edi
}
8010796c:	89 f8                	mov    %edi,%eax
8010796e:	5b                   	pop    %ebx
8010796f:	5e                   	pop    %esi
80107970:	5f                   	pop    %edi
80107971:	5d                   	pop    %ebp
80107972:	c3                   	ret    
      panic("copyuvm: page not present");
80107973:	83 ec 0c             	sub    $0xc,%esp
80107976:	68 ff 91 10 80       	push   $0x801091ff
8010797b:	e8 10 8a ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107980:	83 ec 0c             	sub    $0xc,%esp
80107983:	68 e5 91 10 80       	push   $0x801091e5
80107988:	e8 03 8a ff ff       	call   80100390 <panic>
8010798d:	8d 76 00             	lea    0x0(%esi),%esi

80107990 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107990:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107991:	31 c9                	xor    %ecx,%ecx
{
80107993:	89 e5                	mov    %esp,%ebp
80107995:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107998:	8b 55 0c             	mov    0xc(%ebp),%edx
8010799b:	8b 45 08             	mov    0x8(%ebp),%eax
8010799e:	e8 0d f8 ff ff       	call   801071b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
801079a3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801079a5:	c9                   	leave  
  if((*pte & PTE_U) == 0)
801079a6:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801079ad:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801079b0:	05 00 00 00 80       	add    $0x80000000,%eax
801079b5:	83 fa 05             	cmp    $0x5,%edx
801079b8:	ba 00 00 00 00       	mov    $0x0,%edx
801079bd:	0f 45 c2             	cmovne %edx,%eax
}
801079c0:	c3                   	ret    
801079c1:	eb 0d                	jmp    801079d0 <copyout>
801079c3:	90                   	nop
801079c4:	90                   	nop
801079c5:	90                   	nop
801079c6:	90                   	nop
801079c7:	90                   	nop
801079c8:	90                   	nop
801079c9:	90                   	nop
801079ca:	90                   	nop
801079cb:	90                   	nop
801079cc:	90                   	nop
801079cd:	90                   	nop
801079ce:	90                   	nop
801079cf:	90                   	nop

801079d0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801079d0:	55                   	push   %ebp
801079d1:	89 e5                	mov    %esp,%ebp
801079d3:	57                   	push   %edi
801079d4:	56                   	push   %esi
801079d5:	53                   	push   %ebx
801079d6:	83 ec 1c             	sub    $0x1c,%esp
801079d9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801079dc:	8b 55 0c             	mov    0xc(%ebp),%edx
801079df:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801079e2:	85 db                	test   %ebx,%ebx
801079e4:	75 40                	jne    80107a26 <copyout+0x56>
801079e6:	eb 70                	jmp    80107a58 <copyout+0x88>
801079e8:	90                   	nop
801079e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801079f0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801079f3:	89 f1                	mov    %esi,%ecx
801079f5:	29 d1                	sub    %edx,%ecx
801079f7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801079fd:	39 d9                	cmp    %ebx,%ecx
801079ff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107a02:	29 f2                	sub    %esi,%edx
80107a04:	83 ec 04             	sub    $0x4,%esp
80107a07:	01 d0                	add    %edx,%eax
80107a09:	51                   	push   %ecx
80107a0a:	57                   	push   %edi
80107a0b:	50                   	push   %eax
80107a0c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107a0f:	e8 0c d5 ff ff       	call   80104f20 <memmove>
    len -= n;
    buf += n;
80107a14:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
80107a17:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
80107a1a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107a20:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107a22:	29 cb                	sub    %ecx,%ebx
80107a24:	74 32                	je     80107a58 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107a26:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a28:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107a2b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107a2e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a34:	56                   	push   %esi
80107a35:	ff 75 08             	pushl  0x8(%ebp)
80107a38:	e8 53 ff ff ff       	call   80107990 <uva2ka>
    if(pa0 == 0)
80107a3d:	83 c4 10             	add    $0x10,%esp
80107a40:	85 c0                	test   %eax,%eax
80107a42:	75 ac                	jne    801079f0 <copyout+0x20>
  }
  return 0;
}
80107a44:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a4c:	5b                   	pop    %ebx
80107a4d:	5e                   	pop    %esi
80107a4e:	5f                   	pop    %edi
80107a4f:	5d                   	pop    %ebp
80107a50:	c3                   	ret    
80107a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a5b:	31 c0                	xor    %eax,%eax
}
80107a5d:	5b                   	pop    %ebx
80107a5e:	5e                   	pop    %esi
80107a5f:	5f                   	pop    %edi
80107a60:	5d                   	pop    %ebp
80107a61:	c3                   	ret    
80107a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a70 <getLastPageSCFIFO>:
    }
  }
}

struct procPG*
getLastPageSCFIFO(){/******************************************************************************** SCFIFO :  getLastPage ***********************************/
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	57                   	push   %edi
80107a74:	56                   	push   %esi
80107a75:	53                   	push   %ebx
80107a76:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107a79:	e8 12 c5 ff ff       	call   80103f90 <myproc>

  //#pragma GCC diagnostic ignored "-Wmaybe-uninitialized";
  struct procPG *page = &p->physicalPGs[p->headPG];
80107a7e:	8b 88 8c 00 00 00    	mov    0x8c(%eax),%ecx
  struct proc *p = myproc();
80107a84:	89 c6                	mov    %eax,%esi
  struct procPG *page = &p->physicalPGs[p->headPG];
80107a86:	8d 04 49             	lea    (%ecx,%ecx,2),%eax
80107a89:	c1 e0 03             	shl    $0x3,%eax
80107a8c:	8d 9c 06 d0 01 00 00 	lea    0x1d0(%esi,%eax,1),%ebx
  struct procPG *headHolder = &p->physicalPGs[p->headPG];

  if(!page->next){
80107a93:	8b 84 06 e0 01 00 00 	mov    0x1e0(%esi,%eax,1),%eax
  struct procPG *page = &p->physicalPGs[p->headPG];
80107a9a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  if(!page->next){
80107a9d:	85 c0                	test   %eax,%eax
80107a9f:	74 6c                	je     80107b0d <getLastPageSCFIFO+0x9d>
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical; i++)
80107aa1:	8b 96 80 00 00 00    	mov    0x80(%esi),%edx
80107aa7:	b8 01 00 00 00       	mov    $0x1,%eax
80107aac:	83 fa 01             	cmp    $0x1,%edx
80107aaf:	7e 17                	jle    80107ac8 <getLastPageSCFIFO+0x58>
80107ab1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ab8:	8b 96 80 00 00 00    	mov    0x80(%esi),%edx
80107abe:	83 c0 01             	add    $0x1,%eax
  {
      page = page->next;
80107ac1:	8b 5b 10             	mov    0x10(%ebx),%ebx
  for(i = 1; i < p->nPgsPhysical; i++)
80107ac4:	39 c2                	cmp    %eax,%edx
80107ac6:	7f f0                	jg     80107ab8 <getLastPageSCFIFO+0x48>
  pte_t *pte;
  struct procPG *tailHolder = &p->physicalPGs[p->headPG];
  while ((*(pte = walkpgdir(p->pgdir,(void*)page->va,0)) & PTE_A) != 0)
  {
    *pte &= ~PTE_A;
    if(page->va == headHolder->va){
80107ac8:	8d 3c 49             	lea    (%ecx,%ecx,2),%edi
80107acb:	eb 16                	jmp    80107ae3 <getLastPageSCFIFO+0x73>
80107acd:	8d 76 00             	lea    0x0(%esi),%esi
    *pte &= ~PTE_A;
80107ad0:	83 e2 df             	and    $0xffffffdf,%edx
80107ad3:	89 10                	mov    %edx,(%eax)
    if(page->va == headHolder->va){
80107ad5:	8b 84 fe d0 01 00 00 	mov    0x1d0(%esi,%edi,8),%eax
80107adc:	39 03                	cmp    %eax,(%ebx)
80107ade:	74 20                	je     80107b00 <getLastPageSCFIFO+0x90>
      page = tailHolder; //in case all pages had PTE_A bit, return the last one as fifo
      return page;
    }
    page = page->prev;
80107ae0:	8b 5b 14             	mov    0x14(%ebx),%ebx
  while ((*(pte = walkpgdir(p->pgdir,(void*)page->va,0)) & PTE_A) != 0)
80107ae3:	8b 13                	mov    (%ebx),%edx
80107ae5:	8b 46 04             	mov    0x4(%esi),%eax
80107ae8:	31 c9                	xor    %ecx,%ecx
80107aea:	e8 c1 f6 ff ff       	call   801071b0 <walkpgdir>
80107aef:	8b 10                	mov    (%eax),%edx
80107af1:	f6 c2 20             	test   $0x20,%dl
80107af4:	75 da                	jne    80107ad0 <getLastPageSCFIFO+0x60>
  }
  return page;
}
80107af6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107af9:	89 d8                	mov    %ebx,%eax
80107afb:	5b                   	pop    %ebx
80107afc:	5e                   	pop    %esi
80107afd:	5f                   	pop    %edi
80107afe:	5d                   	pop    %ebp
80107aff:	c3                   	ret    
      return page;
80107b00:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
}
80107b03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b06:	89 d8                	mov    %ebx,%eax
80107b08:	5b                   	pop    %ebx
80107b09:	5e                   	pop    %esi
80107b0a:	5f                   	pop    %edi
80107b0b:	5d                   	pop    %ebp
80107b0c:	c3                   	ret    
    panic("getLastPG: empty headPG list");
80107b0d:	83 ec 0c             	sub    $0xc,%esp
80107b10:	68 19 92 10 80       	push   $0x80109219
80107b15:	e8 76 88 ff ff       	call   80100390 <panic>
80107b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b20 <scfifoWriteToSwap>:
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
80107b20:	55                   	push   %ebp
80107b21:	89 e5                	mov    %esp,%ebp
80107b23:	57                   	push   %edi
80107b24:	56                   	push   %esi
80107b25:	53                   	push   %ebx
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107b26:	31 db                	xor    %ebx,%ebx
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
80107b28:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107b2b:	e8 60 c4 ff ff       	call   80103f90 <myproc>
80107b30:	89 c6                	mov    %eax,%esi
80107b32:	05 a0 00 00 00       	add    $0xa0,%eax
80107b37:	eb 16                	jmp    80107b4f <scfifoWriteToSwap+0x2f>
80107b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107b40:	83 c3 01             	add    $0x1,%ebx
80107b43:	83 c0 14             	add    $0x14,%eax
    if(i== MAX_PSYC_PAGES){
80107b46:	83 fb 10             	cmp    $0x10,%ebx
80107b49:	0f 84 99 00 00 00    	je     80107be8 <scfifoWriteToSwap+0xc8>
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107b4f:	83 38 ff             	cmpl   $0xffffffff,(%eax)
80107b52:	75 ec                	jne    80107b40 <scfifoWriteToSwap+0x20>
  if(p->headPG==-1){
80107b54:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
80107b5b:	0f 84 ae 00 00 00    	je     80107c0f <scfifoWriteToSwap+0xef>
  struct procPG *lastpg = getLastPageSCFIFO();
80107b61:	e8 0a ff ff ff       	call   80107a70 <getLastPageSCFIFO>
  p->swappedPGs[i].va = lastpg->va;
80107b66:	8b 10                	mov    (%eax),%edx
  struct procPG *lastpg = getLastPageSCFIFO();
80107b68:	89 c7                	mov    %eax,%edi
  p->swappedPGs[i].va = lastpg->va;
80107b6a:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107b6d:	c1 e3 0c             	shl    $0xc,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107b70:	89 94 86 a0 00 00 00 	mov    %edx,0xa0(%esi,%eax,4)
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107b77:	68 00 10 00 00       	push   $0x1000
80107b7c:	53                   	push   %ebx
80107b7d:	8b 07                	mov    (%edi),%eax
80107b7f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107b84:	50                   	push   %eax
80107b85:	56                   	push   %esi
80107b86:	e8 25 a8 ff ff       	call   801023b0 <writeToSwapFile>
80107b8b:	83 c4 10             	add    $0x10,%esp
80107b8e:	85 c0                	test   %eax,%eax
80107b90:	7e 70                	jle    80107c02 <scfifoWriteToSwap+0xe2>
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107b92:	8b 46 04             	mov    0x4(%esi),%eax
80107b95:	8b 17                	mov    (%edi),%edx
80107b97:	31 c9                	xor    %ecx,%ecx
80107b99:	e8 12 f6 ff ff       	call   801071b0 <walkpgdir>
  if(!pte){
80107b9e:	85 c0                	test   %eax,%eax
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107ba0:	89 c3                	mov    %eax,%ebx
  if(!pte){
80107ba2:	74 51                	je     80107bf5 <scfifoWriteToSwap+0xd5>
  kfree((char*)PTE_ADDR(P2V(*pte)));
80107ba4:	8b 00                	mov    (%eax),%eax
80107ba6:	83 ec 0c             	sub    $0xc,%esp
80107ba9:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80107baf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107bb5:	52                   	push   %edx
80107bb6:	e8 45 ac ff ff       	call   80102800 <kfree>
  lastpg->va = (char*)addr;
80107bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  *pte = PTE_W | PTE_U | PTE_PG;
80107bbe:	c7 03 06 02 00 00    	movl   $0x206,(%ebx)
  lastpg->va = (char*)addr;
80107bc4:	89 07                	mov    %eax,(%edi)
  movePageToHead(lastpg);
80107bc6:	89 3c 24             	mov    %edi,(%esp)
80107bc9:	e8 b2 09 00 00       	call   80108580 <movePageToHead>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107bce:	8b 46 04             	mov    0x4(%esi),%eax
80107bd1:	05 00 00 00 80       	add    $0x80000000,%eax
80107bd6:	0f 22 d8             	mov    %eax,%cr3
}
80107bd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bdc:	89 f8                	mov    %edi,%eax
80107bde:	5b                   	pop    %ebx
80107bdf:	5e                   	pop    %esi
80107be0:	5f                   	pop    %edi
80107be1:	5d                   	pop    %ebp
80107be2:	c3                   	ret    
80107be3:	90                   	nop
80107be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107be8:	83 ec 0c             	sub    $0xc,%esp
80107beb:	68 fc 92 10 80       	push   $0x801092fc
80107bf0:	e8 9b 87 ff ff       	call   80100390 <panic>
    panic("scfifoWrite: !pte");
80107bf5:	83 ec 0c             	sub    $0xc,%esp
80107bf8:	68 36 92 10 80       	push   $0x80109236
80107bfd:	e8 8e 87 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107c02:	83 ec 0c             	sub    $0xc,%esp
80107c05:	68 58 93 10 80       	push   $0x80109358
80107c0a:	e8 81 87 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: empty headPG list");
80107c0f:	83 ec 0c             	sub    $0xc,%esp
80107c12:	68 30 93 10 80       	push   $0x80109330
80107c17:	e8 74 87 ff ff       	call   80100390 <panic>
80107c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107c20 <initSCFIFO>:
initSCFIFO(char *va){/******************************************************************************* SCFIFO :  init *******************************************/
80107c20:	55                   	push   %ebp
80107c21:	89 e5                	mov    %esp,%ebp
80107c23:	56                   	push   %esi
80107c24:	53                   	push   %ebx
80107c25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107c28:	e8 63 c3 ff ff       	call   80103f90 <myproc>
80107c2d:	89 c6                	mov    %eax,%esi
  if(p->allocatedInPhys == 16){
80107c2f:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80107c35:	83 f8 10             	cmp    $0x10,%eax
80107c38:	0f 84 9a 00 00 00    	je     80107cd8 <initSCFIFO+0xb8>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107c3e:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
  char* addrToOverwrite = (char*)0xffffffff;
80107c44:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107c49:	83 f8 0f             	cmp    $0xf,%eax
80107c4c:	7f 6a                	jg     80107cb8 <initSCFIFO+0x98>
80107c4e:	8d 96 d0 01 00 00    	lea    0x1d0(%esi),%edx
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107c54:	31 c0                	xor    %eax,%eax
80107c56:	eb 13                	jmp    80107c6b <initSCFIFO+0x4b>
80107c58:	90                   	nop
80107c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c60:	83 c0 01             	add    $0x1,%eax
80107c63:	83 c2 18             	add    $0x18,%edx
80107c66:	83 f8 11             	cmp    $0x11,%eax
80107c69:	74 2c                	je     80107c97 <initSCFIFO+0x77>
    if(p->physicalPGs[i].va == addrToOverwrite){
80107c6b:	39 0a                	cmp    %ecx,(%edx)
80107c6d:	75 f1                	jne    80107c60 <initSCFIFO+0x40>
      p->physicalPGs[i].va = va;
80107c6f:	8d 14 40             	lea    (%eax,%eax,2),%edx
80107c72:	c1 e2 03             	shl    $0x3,%edx
80107c75:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
80107c78:	89 99 d0 01 00 00    	mov    %ebx,0x1d0(%ecx)
      p->physicalPGs[i].refs = 1;
80107c7e:	c7 81 d4 01 00 00 01 	movl   $0x1,0x1d4(%ecx)
80107c85:	00 00 00 
      if(p->headPG == -1){
80107c88:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
        p->headPG = i;
80107c8f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
      if(p->headPG == -1){
80107c95:	75 09                	jne    80107ca0 <initSCFIFO+0x80>
}
80107c97:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c9a:	5b                   	pop    %ebx
80107c9b:	5e                   	pop    %esi
80107c9c:	5d                   	pop    %ebp
80107c9d:	c3                   	ret    
80107c9e:	66 90                	xchg   %ax,%ax
      movePageToHead(&p->physicalPGs[i]);
80107ca0:	8d 84 16 d0 01 00 00 	lea    0x1d0(%esi,%edx,1),%eax
80107ca7:	89 45 08             	mov    %eax,0x8(%ebp)
}
80107caa:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107cad:	5b                   	pop    %ebx
80107cae:	5e                   	pop    %esi
80107caf:	5d                   	pop    %ebp
      movePageToHead(&p->physicalPGs[i]);
80107cb0:	e9 cb 08 00 00       	jmp    80108580 <movePageToHead>
80107cb5:	8d 76 00             	lea    0x0(%esi),%esi
      myproc()->nPgsPhysical--;
80107cb8:	e8 d3 c2 ff ff       	call   80103f90 <myproc>
80107cbd:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80107cc3:	83 ea 01             	sub    $0x1,%edx
80107cc6:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
      addrToOverwrite = getLastPageSCFIFO()->va;
80107ccc:	e8 9f fd ff ff       	call   80107a70 <getLastPageSCFIFO>
80107cd1:	8b 08                	mov    (%eax),%ecx
80107cd3:	e9 76 ff ff ff       	jmp    80107c4e <initSCFIFO+0x2e>
    panic("initSCFIFO");
80107cd8:	83 ec 0c             	sub    $0xc,%esp
80107cdb:	68 48 92 10 80       	push   $0x80109248
80107ce0:	e8 ab 86 ff ff       	call   80100390 <panic>
80107ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107cf0 <leastAgeIndex>:
/***************************************************************************************************************************************************************/
/******************************************************************************   NFUA     *********************************************************************/
/***************************************************************************************************************************************************************/

int
leastAgeIndex(){
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	56                   	push   %esi
80107cf4:	53                   	push   %ebx
  struct proc *p = myproc();
  uint leastAge = __UINT32_MAX__;
80107cf5:	be ff ff ff ff       	mov    $0xffffffff,%esi
  struct proc *p = myproc();
80107cfa:	e8 91 c2 ff ff       	call   80103f90 <myproc>
  int leastIndex = -1;
  int i;
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107cff:	31 c9                	xor    %ecx,%ecx
80107d01:	8d 90 d0 01 00 00    	lea    0x1d0(%eax),%edx
  int leastIndex = -1;
80107d07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
80107d10:	8b 5a 08             	mov    0x8(%edx),%ebx
80107d13:	39 f3                	cmp    %esi,%ebx
80107d15:	77 09                	ja     80107d20 <leastAgeIndex+0x30>
80107d17:	83 3a ff             	cmpl   $0xffffffff,(%edx)
80107d1a:	0f 45 c1             	cmovne %ecx,%eax
80107d1d:	0f 45 f3             	cmovne %ebx,%esi
  for(i = 0; i < MAX_PSYC_PAGES ; i++){
80107d20:	83 c1 01             	add    $0x1,%ecx
80107d23:	83 c2 18             	add    $0x18,%edx
80107d26:	83 f9 10             	cmp    $0x10,%ecx
80107d29:	75 e5                	jne    80107d10 <leastAgeIndex+0x20>
  if(i == -1){
    panic("IndexMaxAgePG : could not find age >= 0");
  }
  return leastIndex;

}
80107d2b:	5b                   	pop    %ebx
80107d2c:	5e                   	pop    %esi
80107d2d:	5d                   	pop    %ebp
80107d2e:	c3                   	ret    
80107d2f:	90                   	nop

80107d30 <nfuaWriteToSwap>:

struct procPG*
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
80107d30:	55                   	push   %ebp
80107d31:	89 e5                	mov    %esp,%ebp
80107d33:	57                   	push   %edi
80107d34:	56                   	push   %esi
80107d35:	53                   	push   %ebx
80107d36:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107d39:	e8 52 c2 ff ff       	call   80103f90 <myproc>
80107d3e:	89 c3                	mov    %eax,%ebx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107d40:	e8 ab ff ff ff       	call   80107cf0 <leastAgeIndex>
80107d45:	89 c6                	mov    %eax,%esi
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107d47:	8d 04 40             	lea    (%eax,%eax,2),%eax
80107d4a:	31 c9                	xor    %ecx,%ecx
80107d4c:	8d 3c c3             	lea    (%ebx,%eax,8),%edi
80107d4f:	8b 43 04             	mov    0x4(%ebx),%eax
80107d52:	8b 97 d0 01 00 00    	mov    0x1d0(%edi),%edx
80107d58:	e8 53 f4 ff ff       	call   801071b0 <walkpgdir>
80107d5d:	89 c2                	mov    %eax,%edx

  p->nPgsPhysical--;
80107d5f:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80107d65:	83 e8 01             	sub    $0x1,%eax
80107d68:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
  if(leastAgePG->alloceted){
80107d6e:	8b 87 dc 01 00 00    	mov    0x1dc(%edi),%eax
80107d74:	85 c0                	test   %eax,%eax
80107d76:	74 0f                	je     80107d87 <nfuaWriteToSwap+0x57>
    p->allocatedInPhys--;
80107d78:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80107d7e:	83 e8 01             	sub    $0x1,%eax
80107d81:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
80107d87:	8d 8b a0 00 00 00    	lea    0xa0(%ebx),%ecx
  }

  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107d8d:	31 c0                	xor    %eax,%eax
80107d8f:	eb 16                	jmp    80107da7 <nfuaWriteToSwap+0x77>
80107d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d98:	83 c0 01             	add    $0x1,%eax
80107d9b:	83 c1 14             	add    $0x14,%ecx
    if(i== MAX_PSYC_PAGES){
80107d9e:	83 f8 10             	cmp    $0x10,%eax
80107da1:	0f 84 f9 00 00 00    	je     80107ea0 <nfuaWriteToSwap+0x170>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107da7:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107daa:	75 ec                	jne    80107d98 <nfuaWriteToSwap+0x68>
      p->swappedPGs[i].offset = i*PGSIZE;
80107dac:	89 c7                	mov    %eax,%edi
80107dae:	8d 04 80             	lea    (%eax,%eax,4),%eax
      break;
    }
  }


  acquire(&tickslock);
80107db1:	83 ec 0c             	sub    $0xc,%esp
      p->swappedPGs[i].offset = i*PGSIZE;
80107db4:	c1 e7 0c             	shl    $0xc,%edi
80107db7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107dba:	8d 0c 83             	lea    (%ebx,%eax,4),%ecx
      p->swappedPGs[i].va = (char*)PTE_ADDR(leastAgePG->va);
80107dbd:	8d 04 76             	lea    (%esi,%esi,2),%eax
      p->swappedPGs[i].offset = i*PGSIZE;
80107dc0:	89 b9 90 00 00 00    	mov    %edi,0x90(%ecx)
      p->swappedPGs[i].va = (char*)PTE_ADDR(leastAgePG->va);
80107dc6:	8b 84 c3 d0 01 00 00 	mov    0x1d0(%ebx,%eax,8),%eax
80107dcd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107dd2:	89 81 a0 00 00 00    	mov    %eax,0xa0(%ecx)
  acquire(&tickslock);
80107dd8:	68 80 a1 15 80       	push   $0x8015a180
80107ddd:	e8 7e cf ff ff       	call   80104d60 <acquire>
  if(*pte & PTE_A){
80107de2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107de5:	83 c4 10             	add    $0x10,%esp
80107de8:	8b 02                	mov    (%edx),%eax
80107dea:	a8 20                	test   $0x20,%al
80107dec:	0f 85 9e 00 00 00    	jne    80107e90 <nfuaWriteToSwap+0x160>
    *pte &= ~PTE_A;
  }
  release(&tickslock);
80107df2:	83 ec 0c             	sub    $0xc,%esp

  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107df5:	8d 34 76             	lea    (%esi,%esi,2),%esi
80107df8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  release(&tickslock);
80107dfb:	68 80 a1 15 80       	push   $0x8015a180
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107e00:	c1 e6 03             	shl    $0x3,%esi
  release(&tickslock);
80107e03:	e8 18 d0 ff ff       	call   80104e20 <release>
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107e08:	68 00 10 00 00       	push   $0x1000
80107e0d:	57                   	push   %edi
80107e0e:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
80107e11:	8b 87 d0 01 00 00    	mov    0x1d0(%edi),%eax
80107e17:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e1c:	50                   	push   %eax
80107e1d:	53                   	push   %ebx
80107e1e:	e8 8d a5 ff ff       	call   801023b0 <writeToSwapFile>
80107e23:	83 c4 20             	add    $0x20,%esp
80107e26:	85 c0                	test   %eax,%eax
80107e28:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107e2b:	0f 8e 7c 00 00 00    	jle    80107ead <nfuaWriteToSwap+0x17d>
  }


  //if(p->allocatedInPhys>MAX_PSYC_PAGES){
  //decrementReferenceCount(PTE_ADDR(*pte));
  kfree((char*)PTE_ADDR(P2V(*pte)));
80107e31:	8b 02                	mov    (%edx),%eax
80107e33:	83 ec 0c             	sub    $0xc,%esp
80107e36:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107e39:	05 00 00 00 80       	add    $0x80000000,%eax
80107e3e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e43:	50                   	push   %eax
80107e44:	e8 b7 a9 ff ff       	call   80102800 <kfree>



  //}
  *pte |= PTE_PG;
  *pte &= ~PTE_P;
80107e49:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107e4c:	8b 02                	mov    (%edx),%eax
80107e4e:	83 e0 fe             	and    $0xfffffffe,%eax
80107e51:	80 cc 02             	or     $0x2,%ah
80107e54:	89 02                	mov    %eax,(%edx)
  //*pte &= ~PTE_COW;

  //sets the empty page to the head of the proc page list
  leastAgePG->va = (char*) 0xffffffff;
80107e56:	c7 87 d0 01 00 00 ff 	movl   $0xffffffff,0x1d0(%edi)
80107e5d:	ff ff ff 
  leastAgePG->age = 0 ;
80107e60:	c7 87 d8 01 00 00 00 	movl   $0x0,0x1d8(%edi)
80107e67:	00 00 00 
  leastAgePG->alloceted = 0 ;
80107e6a:	c7 87 dc 01 00 00 00 	movl   $0x0,0x1dc(%edi)
80107e71:	00 00 00 

  //movePageToHead(leastAgePG);

  lcr3(V2P(p->pgdir));  // switch to process's address space
80107e74:	8b 43 04             	mov    0x4(%ebx),%eax
80107e77:	05 00 00 00 80       	add    $0x80000000,%eax
80107e7c:	0f 22 d8             	mov    %eax,%cr3

  return leastAgePG;
}
80107e7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107e82:	8d 84 33 d0 01 00 00 	lea    0x1d0(%ebx,%esi,1),%eax
}
80107e89:	5b                   	pop    %ebx
80107e8a:	5e                   	pop    %esi
80107e8b:	5f                   	pop    %edi
80107e8c:	5d                   	pop    %ebp
80107e8d:	c3                   	ret    
80107e8e:	66 90                	xchg   %ax,%ax
    *pte &= ~PTE_A;
80107e90:	83 e0 df             	and    $0xffffffdf,%eax
80107e93:	89 02                	mov    %eax,(%edx)
80107e95:	e9 58 ff ff ff       	jmp    80107df2 <nfuaWriteToSwap+0xc2>
80107e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107ea0:	83 ec 0c             	sub    $0xc,%esp
80107ea3:	68 fc 92 10 80       	push   $0x801092fc
80107ea8:	e8 e3 84 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107ead:	83 ec 0c             	sub    $0xc,%esp
80107eb0:	68 58 93 10 80       	push   $0x80109358
80107eb5:	e8 d6 84 ff ff       	call   80100390 <panic>
80107eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ec0 <initNFUA>:

  lcr3(V2P(p->pgdir));
}

void
initNFUA(char *va){/******************************************************************************* NFUA :  init ***********************************************/
80107ec0:	55                   	push   %ebp
80107ec1:	89 e5                	mov    %esp,%ebp
80107ec3:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = myproc();
80107ec6:	e8 c5 c0 ff ff       	call   80103f90 <myproc>
  int i;
  char* addrToOverwrite = (char*)0xffffffff;
  if(p->allocatedInPhys == 16){
80107ecb:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80107ed1:	83 fa 10             	cmp    $0x10,%edx
80107ed4:	74 42                	je     80107f18 <initNFUA+0x58>
80107ed6:	8d 88 d0 01 00 00    	lea    0x1d0(%eax),%ecx
      myproc()->nPgsPhysical--;

      addrToOverwrite = p->physicalPGs[leastAgeIndex()].va;
    //p->allocatedInPhys++;
  }*/
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107edc:	31 d2                	xor    %edx,%edx
80107ede:	eb 0b                	jmp    80107eeb <initNFUA+0x2b>
80107ee0:	83 c2 01             	add    $0x1,%edx
80107ee3:	83 c1 18             	add    $0x18,%ecx
80107ee6:	83 fa 11             	cmp    $0x11,%edx
80107ee9:	74 28                	je     80107f13 <initNFUA+0x53>

    if(p->physicalPGs[i].va == addrToOverwrite){
80107eeb:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107eee:	75 f0                	jne    80107ee0 <initNFUA+0x20>
      p->physicalPGs[i].va = va;
80107ef0:	8d 14 52             	lea    (%edx,%edx,2),%edx
80107ef3:	8d 04 d0             	lea    (%eax,%edx,8),%eax
80107ef6:	8b 55 08             	mov    0x8(%ebp),%edx
      p->physicalPGs[i].age = 0;
80107ef9:	c7 80 d8 01 00 00 00 	movl   $0x0,0x1d8(%eax)
80107f00:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80107f03:	c7 80 dc 01 00 00 01 	movl   $0x1,0x1dc(%eax)
80107f0a:	00 00 00 
      p->physicalPGs[i].va = va;
80107f0d:	89 90 d0 01 00 00    	mov    %edx,0x1d0(%eax)
      //p->headPG = i;
      //movePageToHead(&p->physicalPGs[i]);
      return;
    }
  }
}
80107f13:	c9                   	leave  
80107f14:	c3                   	ret    
80107f15:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("initNFUA\n");
80107f18:	83 ec 0c             	sub    $0xc,%esp
80107f1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107f1e:	68 53 92 10 80       	push   $0x80109253
80107f23:	e8 38 87 ff ff       	call   80100660 <cprintf>
80107f28:	83 c4 10             	add    $0x10,%esp
80107f2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f2e:	eb a6                	jmp    80107ed6 <initNFUA+0x16>

80107f30 <indexInSwapFile>:
/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/
int
indexInSwapFile(uint addr){
80107f30:	55                   	push   %ebp
80107f31:	89 e5                	mov    %esp,%ebp
80107f33:	56                   	push   %esi
80107f34:	53                   	push   %ebx
  struct proc *p =myproc();
80107f35:	e8 56 c0 ff ff       	call   80103f90 <myproc>
  int i;
  for(i = 0 ; i < p->nPgsSwap; i++){
80107f3a:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
80107f40:	85 d2                	test   %edx,%edx
80107f42:	7e 3e                	jle    80107f82 <indexInSwapFile+0x52>

    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
80107f44:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0 ; i < p->nPgsSwap; i++){
80107f47:	31 d2                	xor    %edx,%edx
80107f49:	8d 88 b4 00 00 00    	lea    0xb4(%eax),%ecx
    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
80107f4f:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107f55:	39 b0 a0 00 00 00    	cmp    %esi,0xa0(%eax)
80107f5b:	74 21                	je     80107f7e <indexInSwapFile+0x4e>
80107f5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0 ; i < p->nPgsSwap; i++){
80107f60:	8b 98 84 00 00 00    	mov    0x84(%eax),%ebx
80107f66:	83 c2 01             	add    $0x1,%edx
80107f69:	39 d3                	cmp    %edx,%ebx
80107f6b:	7e 15                	jle    80107f82 <indexInSwapFile+0x52>
80107f6d:	83 c1 14             	add    $0x14,%ecx
    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
80107f70:	39 71 ec             	cmp    %esi,-0x14(%ecx)
80107f73:	75 eb                	jne    80107f60 <indexInSwapFile+0x30>
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107f75:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107f78:	89 d0                	mov    %edx,%eax
80107f7a:	5b                   	pop    %ebx
80107f7b:	5e                   	pop    %esi
80107f7c:	5d                   	pop    %ebp
80107f7d:	c3                   	ret    
  for(i = 0 ; i < p->nPgsSwap; i++){
80107f7e:	31 d2                	xor    %edx,%edx
80107f80:	eb f3                	jmp    80107f75 <indexInSwapFile+0x45>
  panic("scfifoSwap: could not find page in swap file");
80107f82:	83 ec 0c             	sub    $0xc,%esp
80107f85:	68 7c 93 10 80       	push   $0x8010937c
80107f8a:	e8 01 84 ff ff       	call   80100390 <panic>
80107f8f:	90                   	nop

80107f90 <scfifoSwap>:
scfifoSwap(uint addr){/******************************************************************************** SCFIFO :  swap *****************************************/
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	57                   	push   %edi
80107f94:	56                   	push   %esi
80107f95:	53                   	push   %ebx
80107f96:	81 ec 1c 04 00 00    	sub    $0x41c,%esp
  struct proc *p = myproc();
80107f9c:	e8 ef bf ff ff       	call   80103f90 <myproc>
80107fa1:	89 c6                	mov    %eax,%esi
  struct procPG *lastpg = getLastPageSCFIFO();
80107fa3:	e8 c8 fa ff ff       	call   80107a70 <getLastPageSCFIFO>
80107fa8:	89 c7                	mov    %eax,%edi
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107faa:	8b 46 04             	mov    0x4(%esi),%eax
80107fad:	31 c9                	xor    %ecx,%ecx
80107faf:	8b 17                	mov    (%edi),%edx
80107fb1:	89 bd d8 fb ff ff    	mov    %edi,-0x428(%ebp)
80107fb7:	e8 f4 f1 ff ff       	call   801071b0 <walkpgdir>
  int i = indexInSwapFile(addr);
80107fbc:	83 ec 0c             	sub    $0xc,%esp
80107fbf:	ff 75 08             	pushl  0x8(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107fc2:	89 c7                	mov    %eax,%edi
  int i = indexInSwapFile(addr);
80107fc4:	e8 67 ff ff ff       	call   80107f30 <indexInSwapFile>
80107fc9:	89 c3                	mov    %eax,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107fcb:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107fd1:	31 c9                	xor    %ecx,%ecx
  p->swappedPGs[i].va = lastpg->va;
80107fd3:	8b 10                	mov    (%eax),%edx
80107fd5:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
80107fd8:	89 94 86 a0 00 00 00 	mov    %edx,0xa0(%esi,%eax,4)
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107fdf:	8b 55 08             	mov    0x8(%ebp),%edx
80107fe2:	8b 46 04             	mov    0x4(%esi),%eax
80107fe5:	e8 c6 f1 ff ff       	call   801071b0 <walkpgdir>
  if(!*pte2){
80107fea:	8b 10                	mov    (%eax),%edx
80107fec:	83 c4 10             	add    $0x10,%esp
80107fef:	85 d2                	test   %edx,%edx
80107ff1:	0f 84 07 01 00 00    	je     801080fe <scfifoSwap+0x16e>
  *pte2 = PTE_ADDR(*pte1) | PTE_U  | PTE_W| PTE_P;
80107ff7:	8b 17                	mov    (%edi),%edx
80107ff9:	c1 e3 0c             	shl    $0xc,%ebx
80107ffc:	89 9d dc fb ff ff    	mov    %ebx,-0x424(%ebp)
    int loc = (i * PGSIZE) + ((PGSIZE / 4) * j);
80108002:	31 db                	xor    %ebx,%ebx
  *pte2 = PTE_ADDR(*pte1) | PTE_U  | PTE_W| PTE_P;
80108004:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010800a:	83 ca 07             	or     $0x7,%edx
8010800d:	89 10                	mov    %edx,(%eax)
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
8010800f:	8b 45 08             	mov    0x8(%ebp),%eax
80108012:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108017:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
    memset(buf, 0, PGSIZE / 4);
8010801d:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80108023:	83 ec 04             	sub    $0x4,%esp
80108026:	68 00 04 00 00       	push   $0x400
8010802b:	6a 00                	push   $0x0
8010802d:	50                   	push   %eax
8010802e:	e8 3d ce ff ff       	call   80104e70 <memset>
80108033:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
    if(readFromSwapFile(p, buf, loc, PGSIZE / 4) <= 0){
80108039:	68 00 04 00 00       	push   $0x400
8010803e:	8d 14 03             	lea    (%ebx,%eax,1),%edx
80108041:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80108047:	52                   	push   %edx
80108048:	50                   	push   %eax
80108049:	56                   	push   %esi
8010804a:	89 95 e4 fb ff ff    	mov    %edx,-0x41c(%ebp)
80108050:	e8 8b a3 ff ff       	call   801023e0 <readFromSwapFile>
80108055:	83 c4 20             	add    $0x20,%esp
80108058:	85 c0                	test   %eax,%eax
8010805a:	8b 95 e4 fb ff ff    	mov    -0x41c(%ebp),%edx
80108060:	0f 8e 8b 00 00 00    	jle    801080f1 <scfifoSwap+0x161>
    if(writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1)) + addroffset), loc, PGSIZE / 4)<= 0){
80108066:	68 00 04 00 00       	push   $0x400
8010806b:	52                   	push   %edx
8010806c:	8b 07                	mov    (%edi),%eax
8010806e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108073:	8d 84 03 00 00 00 80 	lea    -0x80000000(%ebx,%eax,1),%eax
8010807a:	50                   	push   %eax
8010807b:	56                   	push   %esi
8010807c:	e8 2f a3 ff ff       	call   801023b0 <writeToSwapFile>
80108081:	83 c4 10             	add    $0x10,%esp
80108084:	85 c0                	test   %eax,%eax
80108086:	7e 69                	jle    801080f1 <scfifoSwap+0x161>
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80108088:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
8010808e:	83 ec 04             	sub    $0x4,%esp
80108091:	68 00 04 00 00       	push   $0x400
80108096:	50                   	push   %eax
80108097:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
8010809d:	01 d8                	add    %ebx,%eax
8010809f:	81 c3 00 04 00 00    	add    $0x400,%ebx
801080a5:	50                   	push   %eax
801080a6:	e8 75 ce ff ff       	call   80104f20 <memmove>
  for (j = 0; j < 4; j++) {
801080ab:	83 c4 10             	add    $0x10,%esp
801080ae:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
801080b4:	0f 85 63 ff ff ff    	jne    8010801d <scfifoSwap+0x8d>
  *pte1 &= ~PTE_PG;
801080ba:	8b 07                	mov    (%edi),%eax
  lastpg->va = (char*)PTE_ADDR(addr);
801080bc:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
  movePageToHead(lastpg);
801080c2:	83 ec 0c             	sub    $0xc,%esp
  *pte1 &= ~PTE_PG;
801080c5:	80 e4 fd             	and    $0xfd,%ah
801080c8:	83 c8 02             	or     $0x2,%eax
801080cb:	89 07                	mov    %eax,(%edi)
  lastpg->va = (char*)PTE_ADDR(addr);
801080cd:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
801080d3:	89 08                	mov    %ecx,(%eax)
  movePageToHead(lastpg);
801080d5:	50                   	push   %eax
801080d6:	e8 a5 04 00 00       	call   80108580 <movePageToHead>
  lcr3(V2P(p->pgdir));
801080db:	8b 46 04             	mov    0x4(%esi),%eax
801080de:	05 00 00 00 80       	add    $0x80000000,%eax
801080e3:	0f 22 d8             	mov    %eax,%cr3
}
801080e6:	83 c4 10             	add    $0x10,%esp
801080e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080ec:	5b                   	pop    %ebx
801080ed:	5e                   	pop    %esi
801080ee:	5f                   	pop    %edi
801080ef:	5d                   	pop    %ebp
801080f0:	c3                   	ret    
      panic("scfifoSwap: read from swapfile");
801080f1:	83 ec 0c             	sub    $0xc,%esp
801080f4:	68 ac 93 10 80       	push   $0x801093ac
801080f9:	e8 92 82 ff ff       	call   80100390 <panic>
    panic("scfifoSwap: pte2 empty");
801080fe:	83 ec 0c             	sub    $0xc,%esp
80108101:	68 5d 92 10 80       	push   $0x8010925d
80108106:	e8 85 82 ff ff       	call   80100390 <panic>
8010810b:	90                   	nop
8010810c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108110 <writePageToSwapFile>:


// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
80108110:	55                   	push   %ebp
80108111:	89 e5                	mov    %esp,%ebp
80108113:	53                   	push   %ebx
80108114:	83 ec 10             	sub    $0x10,%esp
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap(PGROUNDDOWN((uint)va));
  #endif
  #ifdef NFUA
    retPG=nfuaWriteToSwap((uint)va);
80108117:	ff 75 08             	pushl  0x8(%ebp)
8010811a:	e8 11 fc ff ff       	call   80107d30 <nfuaWriteToSwap>
8010811f:	89 c3                	mov    %eax,%ebx
  #endif
  myproc()->nPgsSwap++;
80108121:	e8 6a be ff ff       	call   80103f90 <myproc>
80108126:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
8010812c:	83 c2 01             	add    $0x1,%edx
8010812f:	89 90 84 00 00 00    	mov    %edx,0x84(%eax)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}
80108135:	89 d8                	mov    %ebx,%eax
80108137:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010813a:	c9                   	leave  
8010813b:	c3                   	ret    
8010813c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108140 <nfuaSwap>:
nfuaSwap(uint addr){/******************************************************************************** NFUA :  swap *********************************************/
80108140:	55                   	push   %ebp
80108141:	89 e5                	mov    %esp,%ebp
80108143:	57                   	push   %edi
80108144:	56                   	push   %esi
80108145:	53                   	push   %ebx
80108146:	83 ec 1c             	sub    $0x1c,%esp
80108149:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct proc *p = myproc();
8010814c:	e8 3f be ff ff       	call   80103f90 <myproc>
80108151:	89 c3                	mov    %eax,%ebx
  int i = indexInSwapFile(PTE_ADDR(addr));
80108153:	83 ec 0c             	sub    $0xc,%esp
80108156:	89 f8                	mov    %edi,%eax
80108158:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010815d:	50                   	push   %eax
8010815e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108161:	e8 ca fd ff ff       	call   80107f30 <indexInSwapFile>
80108166:	89 45 e0             	mov    %eax,-0x20(%ebp)
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80108169:	8b 43 04             	mov    0x4(%ebx),%eax
8010816c:	31 c9                	xor    %ecx,%ecx
8010816e:	89 fa                	mov    %edi,%edx
80108170:	e8 3b f0 ff ff       	call   801071b0 <walkpgdir>
80108175:	89 c6                	mov    %eax,%esi
          if(p->allocatedInPhys>=MAX_PSYC_PAGES ) {
80108177:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
8010817d:	83 c4 10             	add    $0x10,%esp
80108180:	83 f8 0f             	cmp    $0xf,%eax
80108183:	0f 8f 1f 01 00 00    	jg     801082a8 <nfuaSwap+0x168>
  writePageToSwapFile((char*)addr);
80108189:	83 ec 0c             	sub    $0xc,%esp
8010818c:	57                   	push   %edi
8010818d:	e8 7e ff ff ff       	call   80108110 <writePageToSwapFile>
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80108192:	8b 43 04             	mov    0x4(%ebx),%eax
80108195:	31 c9                	xor    %ecx,%ecx
80108197:	89 fa                	mov    %edi,%edx
80108199:	e8 12 f0 ff ff       	call   801071b0 <walkpgdir>
  if((buf = kalloc()) == 0){
8010819e:	e8 9d a8 ff ff       	call   80102a40 <kalloc>
801081a3:	83 c4 10             	add    $0x10,%esp
801081a6:	85 c0                	test   %eax,%eax
801081a8:	89 c6                	mov    %eax,%esi
801081aa:	0f 84 9b 01 00 00    	je     8010834b <nfuaSwap+0x20b>
  memset(buf, 0, PGSIZE );
801081b0:	83 ec 04             	sub    $0x4,%esp
801081b3:	68 00 10 00 00       	push   $0x1000
801081b8:	6a 00                	push   $0x0
801081ba:	50                   	push   %eax
801081bb:	e8 b0 cc ff ff       	call   80104e70 <memset>
  if(readFromSwapFile(p, buf, i*PGSIZE, PGSIZE) <= 0){
801081c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801081c3:	68 00 10 00 00       	push   $0x1000
801081c8:	c1 e0 0c             	shl    $0xc,%eax
801081cb:	50                   	push   %eax
801081cc:	56                   	push   %esi
801081cd:	53                   	push   %ebx
801081ce:	e8 0d a2 ff ff       	call   801023e0 <readFromSwapFile>
801081d3:	83 c4 20             	add    $0x20,%esp
801081d6:	85 c0                	test   %eax,%eax
801081d8:	0f 8e 7a 01 00 00    	jle    80108358 <nfuaSwap+0x218>
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
801081de:	8b 43 04             	mov    0x4(%ebx),%eax
801081e1:	89 fa                	mov    %edi,%edx
801081e3:	31 c9                	xor    %ecx,%ecx
  mappages(p->pgdir,(char*)PTE_ADDR(addr) , PGSIZE , V2P(buf), PTE_W | PTE_U);
801081e5:	81 c6 00 00 00 80    	add    $0x80000000,%esi
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
801081eb:	e8 c0 ef ff ff       	call   801071b0 <walkpgdir>
801081f0:	89 c7                	mov    %eax,%edi
  *pte2 &= ~PTE_P;
801081f2:	8b 00                	mov    (%eax),%eax
  mappages(p->pgdir,(char*)PTE_ADDR(addr) , PGSIZE , V2P(buf), PTE_W | PTE_U);
801081f4:	83 ec 08             	sub    $0x8,%esp
801081f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801081fa:	b9 00 10 00 00       	mov    $0x1000,%ecx
  *pte2 &= ~PTE_P;
801081ff:	83 e0 fe             	and    $0xfffffffe,%eax
  *pte2 |= PTE_PG;
80108202:	80 cc 02             	or     $0x2,%ah
80108205:	89 07                	mov    %eax,(%edi)
  mappages(p->pgdir,(char*)PTE_ADDR(addr) , PGSIZE , V2P(buf), PTE_W | PTE_U);
80108207:	8b 43 04             	mov    0x4(%ebx),%eax
8010820a:	6a 06                	push   $0x6
8010820c:	56                   	push   %esi
8010820d:	e8 1e f0 ff ff       	call   80107230 <mappages>
  *pte2 &= ~PTE_PG;
80108212:	8b 07                	mov    (%edi),%eax
80108214:	8d 93 d0 01 00 00    	lea    0x1d0(%ebx),%edx
8010821a:	83 c4 10             	add    $0x10,%esp
8010821d:	80 e4 fd             	and    $0xfd,%ah
80108220:	83 c8 01             	or     $0x1,%eax
80108223:	89 07                	mov    %eax,(%edi)
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80108225:	31 c0                	xor    %eax,%eax
80108227:	eb 12                	jmp    8010823b <nfuaSwap+0xfb>
80108229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108230:	83 c0 01             	add    $0x1,%eax
80108233:	83 c2 18             	add    $0x18,%edx
    if(i==MAX_PSYC_PAGES){
80108236:	83 f8 10             	cmp    $0x10,%eax
80108239:	74 5d                	je     80108298 <nfuaSwap+0x158>
    if(p->physicalPGs[i].va == (char*)0xffffffff){
8010823b:	83 3a ff             	cmpl   $0xffffffff,(%edx)
8010823e:	75 f0                	jne    80108230 <nfuaSwap+0xf0>
      p->physicalPGs[i].va = (char*)PTE_ADDR(addr);
80108240:	8d 04 40             	lea    (%eax,%eax,2),%eax
80108243:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80108246:	8d 04 c3             	lea    (%ebx,%eax,8),%eax
80108249:	89 88 d0 01 00 00    	mov    %ecx,0x1d0(%eax)
      p->physicalPGs[i].age = 0;
8010824f:	c7 80 d8 01 00 00 00 	movl   $0x0,0x1d8(%eax)
80108256:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80108259:	c7 80 dc 01 00 00 01 	movl   $0x1,0x1dc(%eax)
80108260:	00 00 00 
  p->nPgsPhysical++;
80108263:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80108269:	83 c0 01             	add    $0x1,%eax
8010826c:	89 83 80 00 00 00    	mov    %eax,0x80(%ebx)
    p->allocatedInPhys++;
80108272:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80108278:	83 c0 01             	add    $0x1,%eax
8010827b:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
  lcr3(V2P(p->pgdir));
80108281:	8b 43 04             	mov    0x4(%ebx),%eax
80108284:	05 00 00 00 80       	add    $0x80000000,%eax
80108289:	0f 22 d8             	mov    %eax,%cr3
}
8010828c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010828f:	5b                   	pop    %ebx
80108290:	5e                   	pop    %esi
80108291:	5f                   	pop    %edi
80108292:	5d                   	pop    %ebp
80108293:	c3                   	ret    
80108294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("cannot allocate phy page nfuaSwap");
80108298:	83 ec 0c             	sub    $0xc,%esp
8010829b:	68 cc 93 10 80       	push   $0x801093cc
801082a0:	e8 eb 80 ff ff       	call   80100390 <panic>
801082a5:	8d 76 00             	lea    0x0(%esi),%esi
            if(getReferenceCount(PTE_ADDR(*pte2)) > 1){
801082a8:	8b 06                	mov    (%esi),%eax
801082aa:	83 ec 0c             	sub    $0xc,%esp
801082ad:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082b2:	50                   	push   %eax
801082b3:	e8 28 a9 ff ff       	call   80102be0 <getReferenceCount>
801082b8:	83 c4 10             	add    $0x10,%esp
801082bb:	83 f8 01             	cmp    $0x1,%eax
801082be:	77 28                	ja     801082e8 <nfuaSwap+0x1a8>
            *pte2 &= PTE_COW;
801082c0:	8b 06                	mov    (%esi),%eax
801082c2:	25 00 08 00 00       	and    $0x800,%eax
            *pte2 |= PTE_W;
801082c7:	83 c8 02             	or     $0x2,%eax
801082ca:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
801082cc:	e8 bf bc ff ff       	call   80103f90 <myproc>
801082d1:	8b 40 04             	mov    0x4(%eax),%eax
801082d4:	05 00 00 00 80       	add    $0x80000000,%eax
801082d9:	0f 22 d8             	mov    %eax,%cr3
801082dc:	e9 a8 fe ff ff       	jmp    80108189 <nfuaSwap+0x49>
801082e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
              char* newVa = kalloc();
801082e8:	e8 53 a7 ff ff       	call   80102a40 <kalloc>
              memmove((char*)newVa,va, PGSIZE);
801082ed:	83 ec 04             	sub    $0x4,%esp
              char* newVa = kalloc();
801082f0:	89 c2                	mov    %eax,%edx
              memmove((char*)newVa,va, PGSIZE);
801082f2:	68 00 10 00 00       	push   $0x1000
              char* va = (char*)P2V(PTE_ADDR(*pte2));
801082f7:	8b 06                	mov    (%esi),%eax
              memmove((char*)newVa,va, PGSIZE);
801082f9:	89 55 dc             	mov    %edx,-0x24(%ebp)
              char* va = (char*)P2V(PTE_ADDR(*pte2));
801082fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108301:	05 00 00 00 80       	add    $0x80000000,%eax
              memmove((char*)newVa,va, PGSIZE);
80108306:	50                   	push   %eax
80108307:	52                   	push   %edx
80108308:	e8 13 cc ff ff       	call   80104f20 <memmove>
              *pte2 = V2P(newVa) | PTE_FLAGS(*pte2) |PTE_P | PTE_W;
8010830d:	8b 06                	mov    (%esi),%eax
8010830f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80108312:	25 ff 0f 00 00       	and    $0xfff,%eax
80108317:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010831d:	83 c8 03             	or     $0x3,%eax
80108320:	09 c2                	or     %eax,%edx
80108322:	89 16                	mov    %edx,(%esi)
              lcr3(V2P(myproc()->pgdir));
80108324:	e8 67 bc ff ff       	call   80103f90 <myproc>
80108329:	8b 40 04             	mov    0x4(%eax),%eax
8010832c:	05 00 00 00 80       	add    $0x80000000,%eax
80108331:	0f 22 d8             	mov    %eax,%cr3
              decrementReferenceCount(PTE_ADDR(*pte2));
80108334:	8b 06                	mov    (%esi),%eax
80108336:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010833b:	89 04 24             	mov    %eax,(%esp)
8010833e:	e8 dd a7 ff ff       	call   80102b20 <decrementReferenceCount>
80108343:	83 c4 10             	add    $0x10,%esp
80108346:	e9 75 ff ff ff       	jmp    801082c0 <nfuaSwap+0x180>
    panic("nfuaSwap : allocating buf");
8010834b:	83 ec 0c             	sub    $0xc,%esp
8010834e:	68 74 92 10 80       	push   $0x80109274
80108353:	e8 38 80 ff ff       	call   80100390 <panic>
      panic("scfifoSwap: read from swapfile");
80108358:	83 ec 0c             	sub    $0xc,%esp
8010835b:	68 ac 93 10 80       	push   $0x801093ac
80108360:	e8 2b 80 ff ff       	call   80100390 <panic>
80108365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108370 <swapPage>:

void 
swapPage(uint addr){
80108370:	55                   	push   %ebp
80108371:	89 e5                	mov    %esp,%ebp

  #ifdef NFUA
    return nfuaSwap(addr);
  #endif

}
80108373:	5d                   	pop    %ebp
    return nfuaSwap(addr);
80108374:	e9 c7 fd ff ff       	jmp    80108140 <nfuaSwap>
80108379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108380 <initPhysicalPage>:

int
initPhysicalPage(char *va){
80108380:	55                   	push   %ebp
80108381:	89 e5                	mov    %esp,%ebp
80108383:	83 ec 14             	sub    $0x14,%esp

  #ifdef SCFIFO
    initSCFIFO(va);
  #endif
  #ifdef NFUA
    initNFUA(va);
80108386:	ff 75 08             	pushl  0x8(%ebp)
80108389:	e8 32 fb ff ff       	call   80107ec0 <initNFUA>
  #endif

  myproc()->nPgsPhysical++;
8010838e:	e8 fd bb ff ff       	call   80103f90 <myproc>
80108393:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80108399:	83 c2 01             	add    $0x1,%edx
8010839c:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  myproc()->allocatedInPhys++;
801083a2:	e8 e9 bb ff ff       	call   80103f90 <myproc>
801083a7:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
801083ad:	83 c2 01             	add    $0x1,%edx
801083b0:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
  //cprintf("%d chikd : %d\n",myproc()->pid,myproc()->allocatedInPhys);


  return 0;
}
801083b6:	31 c0                	xor    %eax,%eax
801083b8:	c9                   	leave  
801083b9:	c3                   	ret    
801083ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801083c0 <allocuvm>:
{
801083c0:	55                   	push   %ebp
801083c1:	89 e5                	mov    %esp,%ebp
801083c3:	57                   	push   %edi
801083c4:	56                   	push   %esi
801083c5:	53                   	push   %ebx
801083c6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801083c9:	8b 7d 10             	mov    0x10(%ebp),%edi
801083cc:	85 ff                	test   %edi,%edi
801083ce:	0f 88 ec 00 00 00    	js     801084c0 <allocuvm+0x100>
  if(newsz < oldsz)
801083d4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801083d7:	0f 82 d3 00 00 00    	jb     801084b0 <allocuvm+0xf0>
  a = PGROUNDUP(oldsz);
801083dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801083e0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801083e6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801083ec:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801083ef:	0f 86 be 00 00 00    	jbe    801084b3 <allocuvm+0xf3>
801083f5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801083f8:	8b 7d 08             	mov    0x8(%ebp),%edi
801083fb:	eb 4f                	jmp    8010844c <allocuvm+0x8c>
801083fd:	8d 76 00             	lea    0x0(%esi),%esi
      initPhysicalPage((char*)a);
80108400:	83 ec 0c             	sub    $0xc,%esp
80108403:	53                   	push   %ebx
80108404:	e8 77 ff ff ff       	call   80108380 <initPhysicalPage>
    memset(mem, 0, PGSIZE);
80108409:	83 c4 0c             	add    $0xc,%esp
8010840c:	68 00 10 00 00       	push   $0x1000
80108411:	6a 00                	push   $0x0
80108413:	56                   	push   %esi
80108414:	e8 57 ca ff ff       	call   80104e70 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108419:	58                   	pop    %eax
8010841a:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108420:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108425:	5a                   	pop    %edx
80108426:	6a 06                	push   $0x6
80108428:	50                   	push   %eax
80108429:	89 da                	mov    %ebx,%edx
8010842b:	89 f8                	mov    %edi,%eax
8010842d:	e8 fe ed ff ff       	call   80107230 <mappages>
80108432:	83 c4 10             	add    $0x10,%esp
80108435:	85 c0                	test   %eax,%eax
80108437:	0f 88 93 00 00 00    	js     801084d0 <allocuvm+0x110>
  for(; a < newsz; a += PGSIZE){
8010843d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108443:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108446:	0f 86 bc 00 00 00    	jbe    80108508 <allocuvm+0x148>
      if(myproc()->allocatedInPhys >= MAX_PSYC_PAGES){
8010844c:	e8 3f bb ff ff       	call   80103f90 <myproc>
80108451:	8b 80 88 00 00 00    	mov    0x88(%eax),%eax
80108457:	83 f8 0f             	cmp    $0xf,%eax
8010845a:	7e 14                	jle    80108470 <allocuvm+0xb0>
        if( (pg = writePageToSwapFile((char*)a)) == 0){
8010845c:	83 ec 0c             	sub    $0xc,%esp
8010845f:	53                   	push   %ebx
80108460:	e8 ab fc ff ff       	call   80108110 <writePageToSwapFile>
80108465:	83 c4 10             	add    $0x10,%esp
80108468:	85 c0                	test   %eax,%eax
8010846a:	0f 84 a5 00 00 00    	je     80108515 <allocuvm+0x155>
    mem = kalloc();
80108470:	e8 cb a5 ff ff       	call   80102a40 <kalloc>
    if(mem == 0){
80108475:	85 c0                	test   %eax,%eax
    mem = kalloc();
80108477:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108479:	75 85                	jne    80108400 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010847b:	83 ec 0c             	sub    $0xc,%esp
      return 0;
8010847e:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory\n");
80108480:	68 a4 92 10 80       	push   $0x801092a4
80108485:	e8 d6 81 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
8010848a:	83 c4 0c             	add    $0xc,%esp
8010848d:	ff 75 0c             	pushl  0xc(%ebp)
80108490:	ff 75 10             	pushl  0x10(%ebp)
80108493:	ff 75 08             	pushl  0x8(%ebp)
80108496:	e8 25 f1 ff ff       	call   801075c0 <deallocuvm>
      return 0;
8010849b:	83 c4 10             	add    $0x10,%esp
}
8010849e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084a1:	89 f8                	mov    %edi,%eax
801084a3:	5b                   	pop    %ebx
801084a4:	5e                   	pop    %esi
801084a5:	5f                   	pop    %edi
801084a6:	5d                   	pop    %ebp
801084a7:	c3                   	ret    
801084a8:	90                   	nop
801084a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
801084b0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801084b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084b6:	89 f8                	mov    %edi,%eax
801084b8:	5b                   	pop    %ebx
801084b9:	5e                   	pop    %esi
801084ba:	5f                   	pop    %edi
801084bb:	5d                   	pop    %ebp
801084bc:	c3                   	ret    
801084bd:	8d 76 00             	lea    0x0(%esi),%esi
801084c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801084c3:	31 ff                	xor    %edi,%edi
}
801084c5:	89 f8                	mov    %edi,%eax
801084c7:	5b                   	pop    %ebx
801084c8:	5e                   	pop    %esi
801084c9:	5f                   	pop    %edi
801084ca:	5d                   	pop    %ebp
801084cb:	c3                   	ret    
801084cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
801084d0:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801084d3:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory (2)\n");
801084d5:	68 bc 92 10 80       	push   $0x801092bc
801084da:	e8 81 81 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801084df:	83 c4 0c             	add    $0xc,%esp
801084e2:	ff 75 0c             	pushl  0xc(%ebp)
801084e5:	ff 75 10             	pushl  0x10(%ebp)
801084e8:	ff 75 08             	pushl  0x8(%ebp)
801084eb:	e8 d0 f0 ff ff       	call   801075c0 <deallocuvm>
      kfree(mem);
801084f0:	89 34 24             	mov    %esi,(%esp)
801084f3:	e8 08 a3 ff ff       	call   80102800 <kfree>
      return 0;
801084f8:	83 c4 10             	add    $0x10,%esp
}
801084fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084fe:	89 f8                	mov    %edi,%eax
80108500:	5b                   	pop    %ebx
80108501:	5e                   	pop    %esi
80108502:	5f                   	pop    %edi
80108503:	5d                   	pop    %ebp
80108504:	c3                   	ret    
80108505:	8d 76 00             	lea    0x0(%esi),%esi
80108508:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010850b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010850e:	5b                   	pop    %ebx
8010850f:	89 f8                	mov    %edi,%eax
80108511:	5e                   	pop    %esi
80108512:	5f                   	pop    %edi
80108513:	5d                   	pop    %ebp
80108514:	c3                   	ret    
          panic("allocuvm: swapOutPage");
80108515:	83 ec 0c             	sub    $0xc,%esp
80108518:	68 8e 92 10 80       	push   $0x8010928e
8010851d:	e8 6e 7e ff ff       	call   80100390 <panic>
80108522:	66 90                	xchg   %ax,%ax
80108524:	66 90                	xchg   %ax,%ax
80108526:	66 90                	xchg   %ax,%ax
80108528:	66 90                	xchg   %ax,%ax
8010852a:	66 90                	xchg   %ax,%ax
8010852c:	66 90                	xchg   %ax,%ax
8010852e:	66 90                	xchg   %ax,%ax

80108530 <indexInPhysicalMem>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
int
indexInPhysicalMem(struct procPG *pg){
80108530:	55                   	push   %ebp
80108531:	89 e5                	mov    %esp,%ebp
80108533:	83 ec 08             	sub    $0x8,%esp
  struct proc *p =myproc();
80108536:	e8 55 ba ff ff       	call   80103f90 <myproc>
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){

    if(p->physicalPGs[i].va == pg->va){
8010853b:	8b 55 08             	mov    0x8(%ebp),%edx
8010853e:	8b 0a                	mov    (%edx),%ecx
80108540:	8d 90 d0 01 00 00    	lea    0x1d0(%eax),%edx
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80108546:	31 c0                	xor    %eax,%eax
80108548:	eb 11                	jmp    8010855b <indexInPhysicalMem+0x2b>
8010854a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108550:	83 c0 01             	add    $0x1,%eax
80108553:	83 c2 18             	add    $0x18,%edx
80108556:	83 f8 10             	cmp    $0x10,%eax
80108559:	74 0d                	je     80108568 <indexInPhysicalMem+0x38>
    if(p->physicalPGs[i].va == pg->va){
8010855b:	39 0a                	cmp    %ecx,(%edx)
8010855d:	75 f1                	jne    80108550 <indexInPhysicalMem+0x20>
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
8010855f:	c9                   	leave  
80108560:	c3                   	ret    
80108561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  panic("scfifoSwap: could not find page in swap file");
80108568:	83 ec 0c             	sub    $0xc,%esp
8010856b:	68 7c 93 10 80       	push   $0x8010937c
80108570:	e8 1b 7e ff ff       	call   80100390 <panic>
80108575:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108580 <movePageToHead>:


void 
movePageToHead(struct procPG *pg){
80108580:	55                   	push   %ebp
80108581:	89 e5                	mov    %esp,%ebp
80108583:	53                   	push   %ebx
80108584:	83 ec 04             	sub    $0x4,%esp
80108587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  struct proc *p = myproc();
8010858a:	e8 01 ba ff ff       	call   80103f90 <myproc>

  if(p->headPG==-1){
8010858f:	83 b8 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%eax)
80108596:	74 49                	je     801085e1 <movePageToHead+0x61>
    panic("aaa");
  }
  if(pg->prev){
80108598:	8b 4b 14             	mov    0x14(%ebx),%ecx
8010859b:	8b 53 10             	mov    0x10(%ebx),%edx
8010859e:	85 c9                	test   %ecx,%ecx
801085a0:	74 06                	je     801085a8 <movePageToHead+0x28>
    pg->prev->next = pg->next;
801085a2:	89 51 10             	mov    %edx,0x10(%ecx)
801085a5:	8b 53 10             	mov    0x10(%ebx),%edx
  }
  if(pg->next){
801085a8:	85 d2                	test   %edx,%edx
801085aa:	74 06                	je     801085b2 <movePageToHead+0x32>
    pg->next->prev = pg->prev;
801085ac:	8b 4b 14             	mov    0x14(%ebx),%ecx
801085af:	89 4a 14             	mov    %ecx,0x14(%edx)
  }

  pg->next = &p->physicalPGs[p->headPG];
801085b2:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
  pg->prev = 0;
801085b8:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  pg->next = &p->physicalPGs[p->headPG];
801085bf:	8d 14 52             	lea    (%edx,%edx,2),%edx
801085c2:	8d 94 d0 d0 01 00 00 	lea    0x1d0(%eax,%edx,8),%edx
801085c9:	89 53 10             	mov    %edx,0x10(%ebx)
  p->physicalPGs[p->headPG].prev = pg;
801085cc:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801085d2:	8d 14 52             	lea    (%edx,%edx,2),%edx
801085d5:	89 9c d0 e4 01 00 00 	mov    %ebx,0x1e4(%eax,%edx,8)

}
801085dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801085df:	c9                   	leave  
801085e0:	c3                   	ret    
    panic("aaa");
801085e1:	83 ec 0c             	sub    $0xc,%esp
801085e4:	68 f0 93 10 80       	push   $0x801093f0
801085e9:	e8 a2 7d ff ff       	call   80100390 <panic>
801085ee:	66 90                	xchg   %ax,%ax

801085f0 <movePageToTail>:

void 
movePageToTail(struct procPG *pg){
801085f0:	55                   	push   %ebp
801085f1:	89 e5                	mov    %esp,%ebp
801085f3:	53                   	push   %ebx
801085f4:	83 ec 04             	sub    $0x4,%esp
801085f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  struct proc *p = myproc();
801085fa:	e8 91 b9 ff ff       	call   80103f90 <myproc>

  if(p->headPG==-1){
801085ff:	83 b8 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%eax)
80108606:	74 49                	je     80108651 <movePageToTail+0x61>
    panic("aaa");
  }
  if(pg->prev){
80108608:	8b 4b 14             	mov    0x14(%ebx),%ecx
8010860b:	8b 53 10             	mov    0x10(%ebx),%edx
8010860e:	85 c9                	test   %ecx,%ecx
80108610:	74 06                	je     80108618 <movePageToTail+0x28>
    pg->prev->next = pg->next;
80108612:	89 51 10             	mov    %edx,0x10(%ecx)
80108615:	8b 53 10             	mov    0x10(%ebx),%edx
  }
  if(pg->next){
80108618:	85 d2                	test   %edx,%edx
8010861a:	74 06                	je     80108622 <movePageToTail+0x32>
    pg->next->prev = pg->prev;
8010861c:	8b 4b 14             	mov    0x14(%ebx),%ecx
8010861f:	89 4a 14             	mov    %ecx,0x14(%edx)
  }

  struct procPG *tempPG = &p->physicalPGs[p->headPG];
80108622:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80108628:	8d 14 52             	lea    (%edx,%edx,2),%edx
8010862b:	8d 94 d0 d0 01 00 00 	lea    0x1d0(%eax,%edx,8),%edx
  while (tempPG->next && tempPG->next->va !=(char*)0xffffffff)
80108632:	eb 0b                	jmp    8010863f <movePageToTail+0x4f>
80108634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108638:	83 38 ff             	cmpl   $0xffffffff,(%eax)
8010863b:	74 09                	je     80108646 <movePageToTail+0x56>
8010863d:	89 c2                	mov    %eax,%edx
8010863f:	8b 42 10             	mov    0x10(%edx),%eax
80108642:	85 c0                	test   %eax,%eax
80108644:	75 f2                	jne    80108638 <movePageToTail+0x48>
  {
    tempPG = tempPG->next;
  }
  
  tempPG->next = pg;
80108646:	89 5a 10             	mov    %ebx,0x10(%edx)
  pg->prev = tempPG;
80108649:	89 53 14             	mov    %edx,0x14(%ebx)
  

}
8010864c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010864f:	c9                   	leave  
80108650:	c3                   	ret    
    panic("aaa");
80108651:	83 ec 0c             	sub    $0xc,%esp
80108654:	68 f0 93 10 80       	push   $0x801093f0
80108659:	e8 32 7d ff ff       	call   80100390 <panic>
8010865e:	66 90                	xchg   %ax,%ax

80108660 <freePageFromList>:

void freePageFromList(struct procPG *pg){
80108660:	55                   	push   %ebp
80108661:	89 e5                	mov    %esp,%ebp
80108663:	57                   	push   %edi
80108664:	56                   	push   %esi
80108665:	53                   	push   %ebx
80108666:	83 ec 0c             	sub    $0xc,%esp
80108669:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
8010866c:	e8 1f b9 ff ff       	call   80103f90 <myproc>
  if(p->physicalPGs[p->headPG].va == pg->va){
80108671:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80108677:	8b 3b                	mov    (%ebx),%edi
    int i = 0;
    for(i = 0; i < MAX_PSYC_PAGES ; i++){
      if(p->physicalPGs[i].va == pg->next->va){
80108679:	8b 73 10             	mov    0x10(%ebx),%esi
  if(p->physicalPGs[p->headPG].va == pg->va){
8010867c:	8d 14 52             	lea    (%edx,%edx,2),%edx
8010867f:	39 bc d0 d0 01 00 00 	cmp    %edi,0x1d0(%eax,%edx,8)
80108686:	74 38                	je     801086c0 <freePageFromList+0x60>
        
        return;
      }
    }
  }
  if(pg->prev){
80108688:	8b 43 14             	mov    0x14(%ebx),%eax
8010868b:	85 c0                	test   %eax,%eax
8010868d:	74 06                	je     80108695 <freePageFromList+0x35>
    pg->prev->next = pg->next;
8010868f:	89 70 10             	mov    %esi,0x10(%eax)
80108692:	8b 73 10             	mov    0x10(%ebx),%esi
  }
  if(pg->next){
80108695:	85 f6                	test   %esi,%esi
80108697:	74 06                	je     8010869f <freePageFromList+0x3f>
80108699:	8b 43 14             	mov    0x14(%ebx),%eax
    pg->next->prev = pg->prev;
8010869c:	89 46 14             	mov    %eax,0x14(%esi)
  }

  pg->va = (char*)0xffffffff;
8010869f:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
  pg->next = 0;
801086a5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  pg->prev = 0;
801086ac:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  
  return;
}
801086b3:	83 c4 0c             	add    $0xc,%esp
801086b6:	5b                   	pop    %ebx
801086b7:	5e                   	pop    %esi
801086b8:	5f                   	pop    %edi
801086b9:	5d                   	pop    %ebp
801086ba:	c3                   	ret    
801086bb:	90                   	nop
801086bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->physicalPGs[i].va == pg->next->va){
801086c0:	8b 3e                	mov    (%esi),%edi
801086c2:	8d 88 d0 01 00 00    	lea    0x1d0(%eax),%ecx
    for(i = 0; i < MAX_PSYC_PAGES ; i++){
801086c8:	31 d2                	xor    %edx,%edx
801086ca:	eb 0f                	jmp    801086db <freePageFromList+0x7b>
801086cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801086d0:	83 c2 01             	add    $0x1,%edx
801086d3:	83 c1 18             	add    $0x18,%ecx
801086d6:	83 fa 10             	cmp    $0x10,%edx
801086d9:	74 35                	je     80108710 <freePageFromList+0xb0>
      if(p->physicalPGs[i].va == pg->next->va){
801086db:	39 39                	cmp    %edi,(%ecx)
801086dd:	75 f1                	jne    801086d0 <freePageFromList+0x70>
        pg->va = (char*)0xffffffff;
801086df:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
        pg->next = 0;
801086e5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        pg->prev = 0;
801086ec:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->headPG = i;
801086f3:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
        p->physicalPGs[i].prev = 0;
801086f9:	8d 14 52             	lea    (%edx,%edx,2),%edx
801086fc:	c7 84 d0 e4 01 00 00 	movl   $0x0,0x1e4(%eax,%edx,8)
80108703:	00 00 00 00 
}
80108707:	83 c4 0c             	add    $0xc,%esp
8010870a:	5b                   	pop    %ebx
8010870b:	5e                   	pop    %esi
8010870c:	5f                   	pop    %edi
8010870d:	5d                   	pop    %ebp
8010870e:	c3                   	ret    
8010870f:	90                   	nop
  if(pg->prev){
80108710:	8b 43 14             	mov    0x14(%ebx),%eax
80108713:	85 c0                	test   %eax,%eax
80108715:	0f 85 74 ff ff ff    	jne    8010868f <freePageFromList+0x2f>
8010871b:	e9 7c ff ff ff       	jmp    8010869c <freePageFromList+0x3c>
