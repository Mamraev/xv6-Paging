
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
8010002d:	b8 60 35 10 80       	mov    $0x80103560,%eax
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
8010004c:	68 60 84 10 80       	push   $0x80108460
80100051:	68 c0 d5 10 80       	push   $0x8010d5c0
80100056:	e8 c5 4c 00 00       	call   80104d20 <initlock>
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
80100092:	68 67 84 10 80       	push   $0x80108467
80100097:	50                   	push   %eax
80100098:	e8 53 4b 00 00       	call   80104bf0 <initsleeplock>
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
801000e4:	e8 77 4d 00 00       	call   80104e60 <acquire>
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
80100162:	e8 b9 4d 00 00       	call   80104f20 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 4a 00 00       	call   80104c30 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 6d 24 00 00       	call   801025f0 <iderw>
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
80100193:	68 6e 84 10 80       	push   $0x8010846e
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
801001ae:	e8 1d 4b 00 00       	call   80104cd0 <holdingsleep>
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
801001c4:	e9 27 24 00 00       	jmp    801025f0 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 7f 84 10 80       	push   $0x8010847f
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
801001ef:	e8 dc 4a 00 00       	call   80104cd0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 4a 00 00       	call   80104c90 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 d5 10 80 	movl   $0x8010d5c0,(%esp)
8010020b:	e8 50 4c 00 00       	call   80104e60 <acquire>
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
8010025c:	e9 bf 4c 00 00       	jmp    80104f20 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 86 84 10 80       	push   $0x80108486
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
80100280:	e8 1b 16 00 00       	call   801018a0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010028c:	e8 cf 4b 00 00       	call   80104e60 <acquire>
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
801002c5:	e8 96 43 00 00       	call   80104660 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 1f 11 80    	mov    0x80111fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 1f 11 80    	cmp    0x80111fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 80 3c 00 00       	call   80103f60 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 c5 10 80       	push   $0x8010c520
801002ef:	e8 2c 4c 00 00       	call   80104f20 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 c4 14 00 00       	call   801017c0 <ilock>
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
8010034d:	e8 ce 4b 00 00       	call   80104f20 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 66 14 00 00       	call   801017c0 <ilock>
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
801003a9:	e8 42 2a 00 00       	call   80102df0 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 8d 84 10 80       	push   $0x8010848d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 17 90 10 80 	movl   $0x80109017,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 49 00 00       	call   80104d40 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 a1 84 10 80       	push   $0x801084a1
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
8010043a:	e8 01 64 00 00       	call   80106840 <uartputc>
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
801004ec:	e8 4f 63 00 00       	call   80106840 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 43 63 00 00       	call   80106840 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 37 63 00 00       	call   80106840 <uartputc>
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
80100524:	e8 f7 4a 00 00       	call   80105020 <memmove>
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
80100541:	e8 2a 4a 00 00       	call   80104f70 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 a5 84 10 80       	push   $0x801084a5
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
801005b1:	0f b6 92 d0 84 10 80 	movzbl -0x7fef7b30(%edx),%edx
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
8010060f:	e8 8c 12 00 00       	call   801018a0 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010061b:	e8 40 48 00 00       	call   80104e60 <acquire>
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
80100647:	e8 d4 48 00 00       	call   80104f20 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 6b 11 00 00       	call   801017c0 <ilock>

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
8010071f:	e8 fc 47 00 00       	call   80104f20 <release>
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
801007d0:	ba b8 84 10 80       	mov    $0x801084b8,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 c5 10 80       	push   $0x8010c520
801007f0:	e8 6b 46 00 00       	call   80104e60 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 bf 84 10 80       	push   $0x801084bf
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
80100823:	e8 38 46 00 00       	call   80104e60 <acquire>
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
80100888:	e8 93 46 00 00       	call   80104f20 <release>
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
80100916:	e8 05 3f 00 00       	call   80104820 <wakeup>
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
80100997:	e9 64 3f 00 00       	jmp    80104900 <procdump>
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
801009c6:	68 c8 84 10 80       	push   $0x801084c8
801009cb:	68 20 c5 10 80       	push   $0x8010c520
801009d0:	e8 4b 43 00 00       	call   80104d20 <initlock>

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
801009f9:	e8 a2 1d 00 00       	call   801027a0 <ioapicenable>
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
80100a16:	81 ec cc 03 00 00    	sub    $0x3cc,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 3f 35 00 00       	call   80103f60 <myproc>
80100a21:	8d 88 d8 01 00 00    	lea    0x1d8(%eax),%ecx
80100a27:	8d 98 a8 00 00 00    	lea    0xa8(%eax),%ebx
80100a2d:	8d b0 58 03 00 00    	lea    0x358(%eax),%esi
80100a33:	89 85 34 fc ff ff    	mov    %eax,-0x3cc(%ebp)
80100a39:	89 8d 30 fc ff ff    	mov    %ecx,-0x3d0(%ebp)
80100a3f:	89 cf                	mov    %ecx,%edi
80100a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct procPG physicalPGs[MAX_PSYC_PAGES];

  //memmove(swappedPGs,curproc->swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
  //memmove(physicalPGs,curproc->physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
    resetRefCounter((uint)curproc->physicalPGs[i].va);
80100a48:	83 ec 0c             	sub    $0xc,%esp
80100a4b:	ff 37                	pushl  (%edi)
80100a4d:	83 c7 18             	add    $0x18,%edi
80100a50:	83 c3 14             	add    $0x14,%ebx
80100a53:	e8 58 20 00 00       	call   80102ab0 <resetRefCounter>
    curproc->physicalPGs[i].va = (char*)0xffffffff;
80100a58:	c7 47 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%edi)
    curproc->physicalPGs[i].next = 0;
80100a5f:	c7 47 f8 00 00 00 00 	movl   $0x0,-0x8(%edi)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100a66:	83 c4 10             	add    $0x10,%esp
    curproc->physicalPGs[i].prev = 0;
80100a69:	c7 47 fc 00 00 00 00 	movl   $0x0,-0x4(%edi)
    curproc->physicalPGs[i].age = 0;
80100a70:	c7 47 f0 00 00 00 00 	movl   $0x0,-0x10(%edi)
    curproc->physicalPGs[i].alloceted = 0;
80100a77:	c7 47 f4 00 00 00 00 	movl   $0x0,-0xc(%edi)
    curproc->swappedPGs[i].va = (char*)0xffffffff;
80100a7e:	c7 43 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%ebx)
  for(i = 0 ;i < MAX_PSYC_PAGES ; i++){
80100a85:	39 f7                	cmp    %esi,%edi
80100a87:	75 bf                	jne    80100a48 <exec+0x38>
  }
  /*curproc->nPgsPhysical = 0;
  curproc->allocatedInPhys = 0;*/

  curproc->nPgsSwap = 0;
80100a89:	8b 85 34 fc ff ff    	mov    -0x3cc(%ebp),%eax
80100a8f:	c7 80 84 00 00 00 00 	movl   $0x0,0x84(%eax)
80100a96:	00 00 00 
  curproc->headPG = 0;
80100a99:	c7 80 94 00 00 00 00 	movl   $0x0,0x94(%eax)
80100aa0:	00 00 00 
  #endif

  begin_op();
80100aa3:	e8 b8 27 00 00       	call   80103260 <begin_op>

  if((ip = namei(path)) == 0){
80100aa8:	83 ec 0c             	sub    $0xc,%esp
80100aab:	ff 75 08             	pushl  0x8(%ebp)
80100aae:	e8 6d 15 00 00       	call   80102020 <namei>
80100ab3:	83 c4 10             	add    $0x10,%esp
80100ab6:	85 c0                	test   %eax,%eax
80100ab8:	89 c6                	mov    %eax,%esi
80100aba:	0f 84 4b 02 00 00    	je     80100d0b <exec+0x2fb>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ac0:	83 ec 0c             	sub    $0xc,%esp
80100ac3:	50                   	push   %eax
80100ac4:	e8 f7 0c 00 00       	call   801017c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100ac9:	8d 85 64 fc ff ff    	lea    -0x39c(%ebp),%eax
80100acf:	6a 34                	push   $0x34
80100ad1:	6a 00                	push   $0x0
80100ad3:	50                   	push   %eax
80100ad4:	56                   	push   %esi
80100ad5:	e8 c6 0f 00 00       	call   80101aa0 <readi>
80100ada:	83 c4 20             	add    $0x20,%esp
80100add:	83 f8 34             	cmp    $0x34,%eax
80100ae0:	75 0c                	jne    80100aee <exec+0xde>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100ae2:	81 bd 64 fc ff ff 7f 	cmpl   $0x464c457f,-0x39c(%ebp)
80100ae9:	45 4c 46 
80100aec:	74 5c                	je     80100b4a <exec+0x13a>
  switchuvm(curproc);
  freevm(oldpgdir);
  return 0;

 bad:
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100aee:	8b 9d 34 fc ff ff    	mov    -0x3cc(%ebp),%ebx
80100af4:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100afa:	83 ec 04             	sub    $0x4,%esp
80100afd:	68 40 01 00 00       	push   $0x140
80100b02:	50                   	push   %eax
80100b03:	81 c3 98 00 00 00    	add    $0x98,%ebx
80100b09:	53                   	push   %ebx
80100b0a:	e8 11 45 00 00       	call   80105020 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100b0f:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100b15:	83 c4 0c             	add    $0xc,%esp
80100b18:	68 80 01 00 00       	push   $0x180
80100b1d:	50                   	push   %eax
80100b1e:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100b24:	e8 f7 44 00 00       	call   80105020 <memmove>
80100b29:	83 c4 10             	add    $0x10,%esp
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b2c:	83 ec 0c             	sub    $0xc,%esp
80100b2f:	56                   	push   %esi
80100b30:	e8 1b 0f 00 00       	call   80101a50 <iunlockput>
    end_op();
80100b35:	e8 96 27 00 00       	call   801032d0 <end_op>
80100b3a:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b45:	5b                   	pop    %ebx
80100b46:	5e                   	pop    %esi
80100b47:	5f                   	pop    %edi
80100b48:	5d                   	pop    %ebp
80100b49:	c3                   	ret    
  if((pgdir = setupkvm()) == 0)
80100b4a:	e8 b1 6d 00 00       	call   80107900 <setupkvm>
80100b4f:	85 c0                	test   %eax,%eax
80100b51:	89 85 2c fc ff ff    	mov    %eax,-0x3d4(%ebp)
80100b57:	74 95                	je     80100aee <exec+0xde>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b59:	66 83 bd 90 fc ff ff 	cmpw   $0x0,-0x370(%ebp)
80100b60:	00 
80100b61:	8b 85 80 fc ff ff    	mov    -0x380(%ebp),%eax
80100b67:	89 85 28 fc ff ff    	mov    %eax,-0x3d8(%ebp)
80100b6d:	0f 84 15 03 00 00    	je     80100e88 <exec+0x478>
  sz = 0;
80100b73:	31 db                	xor    %ebx,%ebx
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b75:	31 ff                	xor    %edi,%edi
80100b77:	e9 7e 00 00 00       	jmp    80100bfa <exec+0x1ea>
80100b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100b80:	83 bd 44 fc ff ff 01 	cmpl   $0x1,-0x3bc(%ebp)
80100b87:	75 63                	jne    80100bec <exec+0x1dc>
    if(ph.memsz < ph.filesz)
80100b89:	8b 85 58 fc ff ff    	mov    -0x3a8(%ebp),%eax
80100b8f:	3b 85 54 fc ff ff    	cmp    -0x3ac(%ebp),%eax
80100b95:	0f 82 86 00 00 00    	jb     80100c21 <exec+0x211>
80100b9b:	03 85 4c fc ff ff    	add    -0x3b4(%ebp),%eax
80100ba1:	72 7e                	jb     80100c21 <exec+0x211>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ba3:	83 ec 04             	sub    $0x4,%esp
80100ba6:	50                   	push   %eax
80100ba7:	53                   	push   %ebx
80100ba8:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100bae:	e8 3d 75 00 00       	call   801080f0 <allocuvm>
80100bb3:	83 c4 10             	add    $0x10,%esp
80100bb6:	85 c0                	test   %eax,%eax
80100bb8:	89 c3                	mov    %eax,%ebx
80100bba:	74 65                	je     80100c21 <exec+0x211>
    if(ph.vaddr % PGSIZE != 0)
80100bbc:	8b 85 4c fc ff ff    	mov    -0x3b4(%ebp),%eax
80100bc2:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc7:	75 58                	jne    80100c21 <exec+0x211>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc9:	83 ec 0c             	sub    $0xc,%esp
80100bcc:	ff b5 54 fc ff ff    	pushl  -0x3ac(%ebp)
80100bd2:	ff b5 48 fc ff ff    	pushl  -0x3b8(%ebp)
80100bd8:	56                   	push   %esi
80100bd9:	50                   	push   %eax
80100bda:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100be0:	e8 6b 6a 00 00       	call   80107650 <loaduvm>
80100be5:	83 c4 20             	add    $0x20,%esp
80100be8:	85 c0                	test   %eax,%eax
80100bea:	78 35                	js     80100c21 <exec+0x211>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bec:	0f b7 85 90 fc ff ff 	movzwl -0x370(%ebp),%eax
80100bf3:	83 c7 01             	add    $0x1,%edi
80100bf6:	39 f8                	cmp    %edi,%eax
80100bf8:	7e 76                	jle    80100c70 <exec+0x260>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bfa:	89 f8                	mov    %edi,%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	c1 e0 05             	shl    $0x5,%eax
80100c01:	03 85 28 fc ff ff    	add    -0x3d8(%ebp),%eax
80100c07:	50                   	push   %eax
80100c08:	8d 85 44 fc ff ff    	lea    -0x3bc(%ebp),%eax
80100c0e:	50                   	push   %eax
80100c0f:	56                   	push   %esi
80100c10:	e8 8b 0e 00 00       	call   80101aa0 <readi>
80100c15:	83 c4 10             	add    $0x10,%esp
80100c18:	83 f8 20             	cmp    $0x20,%eax
80100c1b:	0f 84 5f ff ff ff    	je     80100b80 <exec+0x170>
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100c21:	8b 9d 34 fc ff ff    	mov    -0x3cc(%ebp),%ebx
80100c27:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100c2d:	83 ec 04             	sub    $0x4,%esp
80100c30:	68 40 01 00 00       	push   $0x140
80100c35:	50                   	push   %eax
80100c36:	81 c3 98 00 00 00    	add    $0x98,%ebx
80100c3c:	53                   	push   %ebx
80100c3d:	e8 de 43 00 00       	call   80105020 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100c42:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100c48:	83 c4 0c             	add    $0xc,%esp
80100c4b:	68 80 01 00 00       	push   $0x180
80100c50:	50                   	push   %eax
80100c51:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100c57:	e8 c4 43 00 00       	call   80105020 <memmove>
    freevm(pgdir);
80100c5c:	58                   	pop    %eax
80100c5d:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100c63:	e8 18 6c 00 00       	call   80107880 <freevm>
80100c68:	83 c4 10             	add    $0x10,%esp
80100c6b:	e9 bc fe ff ff       	jmp    80100b2c <exec+0x11c>
80100c70:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80100c76:	89 df                	mov    %ebx,%edi
80100c78:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100c7e:	8d 87 00 20 00 00    	lea    0x2000(%edi),%eax
  iunlockput(ip);
80100c84:	83 ec 0c             	sub    $0xc,%esp
80100c87:	89 85 28 fc ff ff    	mov    %eax,-0x3d8(%ebp)
80100c8d:	56                   	push   %esi
80100c8e:	e8 bd 0d 00 00       	call   80101a50 <iunlockput>
  end_op();
80100c93:	e8 38 26 00 00       	call   801032d0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c98:	8b 85 28 fc ff ff    	mov    -0x3d8(%ebp),%eax
80100c9e:	83 c4 0c             	add    $0xc,%esp
80100ca1:	50                   	push   %eax
80100ca2:	57                   	push   %edi
80100ca3:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100ca9:	e8 42 74 00 00       	call   801080f0 <allocuvm>
80100cae:	83 c4 10             	add    $0x10,%esp
80100cb1:	85 c0                	test   %eax,%eax
80100cb3:	89 c3                	mov    %eax,%ebx
80100cb5:	75 73                	jne    80100d2a <exec+0x31a>
  memmove(curproc->swappedPGs,swappedPGs,sizeof(struct swappedPG)*MAX_PSYC_PAGES);
80100cb7:	8b 9d 34 fc ff ff    	mov    -0x3cc(%ebp),%ebx
80100cbd:	8d 85 28 fd ff ff    	lea    -0x2d8(%ebp),%eax
80100cc3:	83 ec 04             	sub    $0x4,%esp
80100cc6:	68 40 01 00 00       	push   $0x140
80100ccb:	50                   	push   %eax
80100ccc:	81 c3 98 00 00 00    	add    $0x98,%ebx
80100cd2:	53                   	push   %ebx
80100cd3:	e8 48 43 00 00       	call   80105020 <memmove>
  memmove(curproc->physicalPGs,physicalPGs,sizeof(struct procPG)*MAX_PSYC_PAGES);
80100cd8:	8d 85 68 fe ff ff    	lea    -0x198(%ebp),%eax
80100cde:	83 c4 0c             	add    $0xc,%esp
80100ce1:	68 80 01 00 00       	push   $0x180
80100ce6:	50                   	push   %eax
80100ce7:	ff b5 30 fc ff ff    	pushl  -0x3d0(%ebp)
80100ced:	e8 2e 43 00 00       	call   80105020 <memmove>
    freevm(pgdir);
80100cf2:	59                   	pop    %ecx
80100cf3:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100cf9:	e8 82 6b 00 00       	call   80107880 <freevm>
80100cfe:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d06:	e9 37 fe ff ff       	jmp    80100b42 <exec+0x132>
    end_op();
80100d0b:	e8 c0 25 00 00       	call   801032d0 <end_op>
    cprintf("exec: fail\n");
80100d10:	83 ec 0c             	sub    $0xc,%esp
80100d13:	68 e1 84 10 80       	push   $0x801084e1
80100d18:	e8 43 f9 ff ff       	call   80100660 <cprintf>
    return -1;
80100d1d:	83 c4 10             	add    $0x10,%esp
80100d20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d25:	e9 18 fe ff ff       	jmp    80100b42 <exec+0x132>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d2a:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100d30:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100d33:	31 ff                	xor    %edi,%edi
80100d35:	89 de                	mov    %ebx,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d37:	50                   	push   %eax
80100d38:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100d3e:	e8 5d 6c 00 00       	call   801079a0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d43:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d46:	83 c4 10             	add    $0x10,%esp
80100d49:	8d 8d 98 fc ff ff    	lea    -0x368(%ebp),%ecx
80100d4f:	8b 00                	mov    (%eax),%eax
80100d51:	85 c0                	test   %eax,%eax
80100d53:	75 14                	jne    80100d69 <exec+0x359>
80100d55:	eb 69                	jmp    80100dc0 <exec+0x3b0>
80100d57:	89 f6                	mov    %esi,%esi
80100d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
80100d60:	83 ff 20             	cmp    $0x20,%edi
80100d63:	0f 84 4e ff ff ff    	je     80100cb7 <exec+0x2a7>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d69:	83 ec 0c             	sub    $0xc,%esp
80100d6c:	50                   	push   %eax
80100d6d:	e8 1e 44 00 00       	call   80105190 <strlen>
80100d72:	f7 d0                	not    %eax
80100d74:	01 c6                	add    %eax,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d76:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d79:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d7a:	83 e6 fc             	and    $0xfffffffc,%esi
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d7d:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d80:	e8 0b 44 00 00       	call   80105190 <strlen>
80100d85:	83 c0 01             	add    $0x1,%eax
80100d88:	50                   	push   %eax
80100d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d8c:	ff 34 b8             	pushl  (%eax,%edi,4)
80100d8f:	56                   	push   %esi
80100d90:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
80100d96:	e8 25 6e 00 00       	call   80107bc0 <copyout>
80100d9b:	83 c4 20             	add    $0x20,%esp
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	0f 88 11 ff ff ff    	js     80100cb7 <exec+0x2a7>
  for(argc = 0; argv[argc]; argc++) {
80100da6:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100da9:	89 b4 bd a4 fc ff ff 	mov    %esi,-0x35c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100db0:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100db3:	8d 8d 98 fc ff ff    	lea    -0x368(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100db9:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100dbc:	85 c0                	test   %eax,%eax
80100dbe:	75 a0                	jne    80100d60 <exec+0x350>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100dc0:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100dc7:	89 f2                	mov    %esi,%edx
  ustack[3+argc] = 0;
80100dc9:	c7 84 bd a4 fc ff ff 	movl   $0x0,-0x35c(%ebp,%edi,4)
80100dd0:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100dd4:	c7 85 98 fc ff ff ff 	movl   $0xffffffff,-0x368(%ebp)
80100ddb:	ff ff ff 
  ustack[1] = argc;
80100dde:	89 bd 9c fc ff ff    	mov    %edi,-0x364(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100de4:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100de6:	83 c0 0c             	add    $0xc,%eax
80100de9:	29 c6                	sub    %eax,%esi
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100deb:	50                   	push   %eax
80100dec:	51                   	push   %ecx
80100ded:	56                   	push   %esi
80100dee:	ff b5 2c fc ff ff    	pushl  -0x3d4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100df4:	89 95 a0 fc ff ff    	mov    %edx,-0x360(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100dfa:	e8 c1 6d 00 00       	call   80107bc0 <copyout>
80100dff:	83 c4 10             	add    $0x10,%esp
80100e02:	85 c0                	test   %eax,%eax
80100e04:	0f 88 ad fe ff ff    	js     80100cb7 <exec+0x2a7>
  for(last=s=path; *s; s++)
80100e0a:	8b 45 08             	mov    0x8(%ebp),%eax
80100e0d:	0f b6 00             	movzbl (%eax),%eax
80100e10:	84 c0                	test   %al,%al
80100e12:	74 17                	je     80100e2b <exec+0x41b>
80100e14:	8b 55 08             	mov    0x8(%ebp),%edx
80100e17:	89 d1                	mov    %edx,%ecx
80100e19:	83 c1 01             	add    $0x1,%ecx
80100e1c:	3c 2f                	cmp    $0x2f,%al
80100e1e:	0f b6 01             	movzbl (%ecx),%eax
80100e21:	0f 44 d1             	cmove  %ecx,%edx
80100e24:	84 c0                	test   %al,%al
80100e26:	75 f1                	jne    80100e19 <exec+0x409>
80100e28:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e2b:	8b bd 34 fc ff ff    	mov    -0x3cc(%ebp),%edi
80100e31:	83 ec 04             	sub    $0x4,%esp
80100e34:	6a 10                	push   $0x10
80100e36:	ff 75 08             	pushl  0x8(%ebp)
80100e39:	8d 47 6c             	lea    0x6c(%edi),%eax
80100e3c:	50                   	push   %eax
80100e3d:	e8 0e 43 00 00       	call   80105150 <safestrcpy>
  curproc->pgdir = pgdir;
80100e42:	8b 8d 2c fc ff ff    	mov    -0x3d4(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e48:	8b 47 04             	mov    0x4(%edi),%eax
  curproc->sz = sz;
80100e4b:	89 1f                	mov    %ebx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e4d:	8b 57 18             	mov    0x18(%edi),%edx
  curproc->pgdir = pgdir;
80100e50:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->tf->eip = elf.entry;  // main
80100e53:	8b 8d 7c fc ff ff    	mov    -0x384(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e59:	89 85 34 fc ff ff    	mov    %eax,-0x3cc(%ebp)
  curproc->tf->eip = elf.entry;  // main
80100e5f:	89 4a 38             	mov    %ecx,0x38(%edx)
  curproc->tf->esp = sp;
80100e62:	8b 57 18             	mov    0x18(%edi),%edx
80100e65:	89 72 44             	mov    %esi,0x44(%edx)
  switchuvm(curproc);
80100e68:	89 3c 24             	mov    %edi,(%esp)
80100e6b:	e8 50 66 00 00       	call   801074c0 <switchuvm>
  freevm(oldpgdir);
80100e70:	8b 85 34 fc ff ff    	mov    -0x3cc(%ebp),%eax
80100e76:	89 04 24             	mov    %eax,(%esp)
80100e79:	e8 02 6a 00 00       	call   80107880 <freevm>
  return 0;
80100e7e:	83 c4 10             	add    $0x10,%esp
80100e81:	31 c0                	xor    %eax,%eax
80100e83:	e9 ba fc ff ff       	jmp    80100b42 <exec+0x132>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e88:	31 ff                	xor    %edi,%edi
80100e8a:	b8 00 20 00 00       	mov    $0x2000,%eax
80100e8f:	e9 f0 fd ff ff       	jmp    80100c84 <exec+0x274>
80100e94:	66 90                	xchg   %ax,%ax
80100e96:	66 90                	xchg   %ax,%ax
80100e98:	66 90                	xchg   %ax,%ax
80100e9a:	66 90                	xchg   %ax,%ax
80100e9c:	66 90                	xchg   %ax,%ax
80100e9e:	66 90                	xchg   %ax,%ax

80100ea0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100ea6:	68 ed 84 10 80       	push   $0x801084ed
80100eab:	68 c0 1f 11 80       	push   $0x80111fc0
80100eb0:	e8 6b 3e 00 00       	call   80104d20 <initlock>
}
80100eb5:	83 c4 10             	add    $0x10,%esp
80100eb8:	c9                   	leave  
80100eb9:	c3                   	ret    
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ec0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ec4:	bb f4 1f 11 80       	mov    $0x80111ff4,%ebx
{
80100ec9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100ecc:	68 c0 1f 11 80       	push   $0x80111fc0
80100ed1:	e8 8a 3f 00 00       	call   80104e60 <acquire>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb 10                	jmp    80100eeb <filealloc+0x2b>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ee0:	83 c3 18             	add    $0x18,%ebx
80100ee3:	81 fb 54 29 11 80    	cmp    $0x80112954,%ebx
80100ee9:	73 25                	jae    80100f10 <filealloc+0x50>
    if(f->ref == 0){
80100eeb:	8b 43 04             	mov    0x4(%ebx),%eax
80100eee:	85 c0                	test   %eax,%eax
80100ef0:	75 ee                	jne    80100ee0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100ef2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100ef5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100efc:	68 c0 1f 11 80       	push   $0x80111fc0
80100f01:	e8 1a 40 00 00       	call   80104f20 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f06:	89 d8                	mov    %ebx,%eax
      return f;
80100f08:	83 c4 10             	add    $0x10,%esp
}
80100f0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f0e:	c9                   	leave  
80100f0f:	c3                   	ret    
  release(&ftable.lock);
80100f10:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f13:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f15:	68 c0 1f 11 80       	push   $0x80111fc0
80100f1a:	e8 01 40 00 00       	call   80104f20 <release>
}
80100f1f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f21:	83 c4 10             	add    $0x10,%esp
}
80100f24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f27:	c9                   	leave  
80100f28:	c3                   	ret    
80100f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f30 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	53                   	push   %ebx
80100f34:	83 ec 10             	sub    $0x10,%esp
80100f37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f3a:	68 c0 1f 11 80       	push   $0x80111fc0
80100f3f:	e8 1c 3f 00 00       	call   80104e60 <acquire>
  if(f->ref < 1)
80100f44:	8b 43 04             	mov    0x4(%ebx),%eax
80100f47:	83 c4 10             	add    $0x10,%esp
80100f4a:	85 c0                	test   %eax,%eax
80100f4c:	7e 1a                	jle    80100f68 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f4e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f51:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f54:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f57:	68 c0 1f 11 80       	push   $0x80111fc0
80100f5c:	e8 bf 3f 00 00       	call   80104f20 <release>
  return f;
}
80100f61:	89 d8                	mov    %ebx,%eax
80100f63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f66:	c9                   	leave  
80100f67:	c3                   	ret    
    panic("filedup");
80100f68:	83 ec 0c             	sub    $0xc,%esp
80100f6b:	68 f4 84 10 80       	push   $0x801084f4
80100f70:	e8 1b f4 ff ff       	call   80100390 <panic>
80100f75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f80 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f80:	55                   	push   %ebp
80100f81:	89 e5                	mov    %esp,%ebp
80100f83:	57                   	push   %edi
80100f84:	56                   	push   %esi
80100f85:	53                   	push   %ebx
80100f86:	83 ec 28             	sub    $0x28,%esp
80100f89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f8c:	68 c0 1f 11 80       	push   $0x80111fc0
80100f91:	e8 ca 3e 00 00       	call   80104e60 <acquire>
  if(f->ref < 1)
80100f96:	8b 43 04             	mov    0x4(%ebx),%eax
80100f99:	83 c4 10             	add    $0x10,%esp
80100f9c:	85 c0                	test   %eax,%eax
80100f9e:	0f 8e 9b 00 00 00    	jle    8010103f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100fa4:	83 e8 01             	sub    $0x1,%eax
80100fa7:	85 c0                	test   %eax,%eax
80100fa9:	89 43 04             	mov    %eax,0x4(%ebx)
80100fac:	74 1a                	je     80100fc8 <fileclose+0x48>
    release(&ftable.lock);
80100fae:	c7 45 08 c0 1f 11 80 	movl   $0x80111fc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100fb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb8:	5b                   	pop    %ebx
80100fb9:	5e                   	pop    %esi
80100fba:	5f                   	pop    %edi
80100fbb:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fbc:	e9 5f 3f 00 00       	jmp    80104f20 <release>
80100fc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100fc8:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100fcc:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100fce:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100fd1:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100fd4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100fda:	88 45 e7             	mov    %al,-0x19(%ebp)
80100fdd:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100fe0:	68 c0 1f 11 80       	push   $0x80111fc0
  ff = *f;
80100fe5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100fe8:	e8 33 3f 00 00       	call   80104f20 <release>
  if(ff.type == FD_PIPE)
80100fed:	83 c4 10             	add    $0x10,%esp
80100ff0:	83 ff 01             	cmp    $0x1,%edi
80100ff3:	74 13                	je     80101008 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100ff5:	83 ff 02             	cmp    $0x2,%edi
80100ff8:	74 26                	je     80101020 <fileclose+0xa0>
}
80100ffa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ffd:	5b                   	pop    %ebx
80100ffe:	5e                   	pop    %esi
80100fff:	5f                   	pop    %edi
80101000:	5d                   	pop    %ebp
80101001:	c3                   	ret    
80101002:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80101008:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
8010100c:	83 ec 08             	sub    $0x8,%esp
8010100f:	53                   	push   %ebx
80101010:	56                   	push   %esi
80101011:	e8 fa 29 00 00       	call   80103a10 <pipeclose>
80101016:	83 c4 10             	add    $0x10,%esp
80101019:	eb df                	jmp    80100ffa <fileclose+0x7a>
8010101b:	90                   	nop
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80101020:	e8 3b 22 00 00       	call   80103260 <begin_op>
    iput(ff.ip);
80101025:	83 ec 0c             	sub    $0xc,%esp
80101028:	ff 75 e0             	pushl  -0x20(%ebp)
8010102b:	e8 c0 08 00 00       	call   801018f0 <iput>
    end_op();
80101030:	83 c4 10             	add    $0x10,%esp
}
80101033:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101036:	5b                   	pop    %ebx
80101037:	5e                   	pop    %esi
80101038:	5f                   	pop    %edi
80101039:	5d                   	pop    %ebp
    end_op();
8010103a:	e9 91 22 00 00       	jmp    801032d0 <end_op>
    panic("fileclose");
8010103f:	83 ec 0c             	sub    $0xc,%esp
80101042:	68 fc 84 10 80       	push   $0x801084fc
80101047:	e8 44 f3 ff ff       	call   80100390 <panic>
8010104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101050 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101050:	55                   	push   %ebp
80101051:	89 e5                	mov    %esp,%ebp
80101053:	53                   	push   %ebx
80101054:	83 ec 04             	sub    $0x4,%esp
80101057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010105a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010105d:	75 31                	jne    80101090 <filestat+0x40>
    ilock(f->ip);
8010105f:	83 ec 0c             	sub    $0xc,%esp
80101062:	ff 73 10             	pushl  0x10(%ebx)
80101065:	e8 56 07 00 00       	call   801017c0 <ilock>
    stati(f->ip, st);
8010106a:	58                   	pop    %eax
8010106b:	5a                   	pop    %edx
8010106c:	ff 75 0c             	pushl  0xc(%ebp)
8010106f:	ff 73 10             	pushl  0x10(%ebx)
80101072:	e8 f9 09 00 00       	call   80101a70 <stati>
    iunlock(f->ip);
80101077:	59                   	pop    %ecx
80101078:	ff 73 10             	pushl  0x10(%ebx)
8010107b:	e8 20 08 00 00       	call   801018a0 <iunlock>
    return 0;
80101080:	83 c4 10             	add    $0x10,%esp
80101083:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101088:	c9                   	leave  
80101089:	c3                   	ret    
8010108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80101090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101095:	eb ee                	jmp    80101085 <filestat+0x35>
80101097:	89 f6                	mov    %esi,%esi
80101099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801010a0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	57                   	push   %edi
801010a4:	56                   	push   %esi
801010a5:	53                   	push   %ebx
801010a6:	83 ec 0c             	sub    $0xc,%esp
801010a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010ac:	8b 75 0c             	mov    0xc(%ebp),%esi
801010af:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801010b2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801010b6:	74 60                	je     80101118 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801010b8:	8b 03                	mov    (%ebx),%eax
801010ba:	83 f8 01             	cmp    $0x1,%eax
801010bd:	74 41                	je     80101100 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010bf:	83 f8 02             	cmp    $0x2,%eax
801010c2:	75 5b                	jne    8010111f <fileread+0x7f>
    ilock(f->ip);
801010c4:	83 ec 0c             	sub    $0xc,%esp
801010c7:	ff 73 10             	pushl  0x10(%ebx)
801010ca:	e8 f1 06 00 00       	call   801017c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801010cf:	57                   	push   %edi
801010d0:	ff 73 14             	pushl  0x14(%ebx)
801010d3:	56                   	push   %esi
801010d4:	ff 73 10             	pushl  0x10(%ebx)
801010d7:	e8 c4 09 00 00       	call   80101aa0 <readi>
801010dc:	83 c4 20             	add    $0x20,%esp
801010df:	85 c0                	test   %eax,%eax
801010e1:	89 c6                	mov    %eax,%esi
801010e3:	7e 03                	jle    801010e8 <fileread+0x48>
      f->off += r;
801010e5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010e8:	83 ec 0c             	sub    $0xc,%esp
801010eb:	ff 73 10             	pushl  0x10(%ebx)
801010ee:	e8 ad 07 00 00       	call   801018a0 <iunlock>
    return r;
801010f3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010f9:	89 f0                	mov    %esi,%eax
801010fb:	5b                   	pop    %ebx
801010fc:	5e                   	pop    %esi
801010fd:	5f                   	pop    %edi
801010fe:	5d                   	pop    %ebp
801010ff:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101100:	8b 43 0c             	mov    0xc(%ebx),%eax
80101103:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101106:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101109:	5b                   	pop    %ebx
8010110a:	5e                   	pop    %esi
8010110b:	5f                   	pop    %edi
8010110c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010110d:	e9 ae 2a 00 00       	jmp    80103bc0 <piperead>
80101112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101118:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010111d:	eb d7                	jmp    801010f6 <fileread+0x56>
  panic("fileread");
8010111f:	83 ec 0c             	sub    $0xc,%esp
80101122:	68 06 85 10 80       	push   $0x80108506
80101127:	e8 64 f2 ff ff       	call   80100390 <panic>
8010112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101130 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	57                   	push   %edi
80101134:	56                   	push   %esi
80101135:	53                   	push   %ebx
80101136:	83 ec 1c             	sub    $0x1c,%esp
80101139:	8b 75 08             	mov    0x8(%ebp),%esi
8010113c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010113f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101143:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101146:	8b 45 10             	mov    0x10(%ebp),%eax
80101149:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010114c:	0f 84 aa 00 00 00    	je     801011fc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101152:	8b 06                	mov    (%esi),%eax
80101154:	83 f8 01             	cmp    $0x1,%eax
80101157:	0f 84 c3 00 00 00    	je     80101220 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010115d:	83 f8 02             	cmp    $0x2,%eax
80101160:	0f 85 d9 00 00 00    	jne    8010123f <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101166:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101169:	31 ff                	xor    %edi,%edi
    while(i < n){
8010116b:	85 c0                	test   %eax,%eax
8010116d:	7f 34                	jg     801011a3 <filewrite+0x73>
8010116f:	e9 9c 00 00 00       	jmp    80101210 <filewrite+0xe0>
80101174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101178:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010117b:	83 ec 0c             	sub    $0xc,%esp
8010117e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101181:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101184:	e8 17 07 00 00       	call   801018a0 <iunlock>
      end_op();
80101189:	e8 42 21 00 00       	call   801032d0 <end_op>
8010118e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101191:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101194:	39 c3                	cmp    %eax,%ebx
80101196:	0f 85 96 00 00 00    	jne    80101232 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010119c:	01 df                	add    %ebx,%edi
    while(i < n){
8010119e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801011a1:	7e 6d                	jle    80101210 <filewrite+0xe0>
      int n1 = n - i;
801011a3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011a6:	b8 00 06 00 00       	mov    $0x600,%eax
801011ab:	29 fb                	sub    %edi,%ebx
801011ad:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801011b3:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801011b6:	e8 a5 20 00 00       	call   80103260 <begin_op>
      ilock(f->ip);
801011bb:	83 ec 0c             	sub    $0xc,%esp
801011be:	ff 76 10             	pushl  0x10(%esi)
801011c1:	e8 fa 05 00 00       	call   801017c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801011c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011c9:	53                   	push   %ebx
801011ca:	ff 76 14             	pushl  0x14(%esi)
801011cd:	01 f8                	add    %edi,%eax
801011cf:	50                   	push   %eax
801011d0:	ff 76 10             	pushl  0x10(%esi)
801011d3:	e8 c8 09 00 00       	call   80101ba0 <writei>
801011d8:	83 c4 20             	add    $0x20,%esp
801011db:	85 c0                	test   %eax,%eax
801011dd:	7f 99                	jg     80101178 <filewrite+0x48>
      iunlock(f->ip);
801011df:	83 ec 0c             	sub    $0xc,%esp
801011e2:	ff 76 10             	pushl  0x10(%esi)
801011e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801011e8:	e8 b3 06 00 00       	call   801018a0 <iunlock>
      end_op();
801011ed:	e8 de 20 00 00       	call   801032d0 <end_op>
      if(r < 0)
801011f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011f5:	83 c4 10             	add    $0x10,%esp
801011f8:	85 c0                	test   %eax,%eax
801011fa:	74 98                	je     80101194 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801011fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801011ff:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
80101204:	89 f8                	mov    %edi,%eax
80101206:	5b                   	pop    %ebx
80101207:	5e                   	pop    %esi
80101208:	5f                   	pop    %edi
80101209:	5d                   	pop    %ebp
8010120a:	c3                   	ret    
8010120b:	90                   	nop
8010120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
80101210:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101213:	75 e7                	jne    801011fc <filewrite+0xcc>
}
80101215:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101218:	89 f8                	mov    %edi,%eax
8010121a:	5b                   	pop    %ebx
8010121b:	5e                   	pop    %esi
8010121c:	5f                   	pop    %edi
8010121d:	5d                   	pop    %ebp
8010121e:	c3                   	ret    
8010121f:	90                   	nop
    return pipewrite(f->pipe, addr, n);
80101220:	8b 46 0c             	mov    0xc(%esi),%eax
80101223:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101226:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101229:	5b                   	pop    %ebx
8010122a:	5e                   	pop    %esi
8010122b:	5f                   	pop    %edi
8010122c:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
8010122d:	e9 7e 28 00 00       	jmp    80103ab0 <pipewrite>
        panic("short filewrite");
80101232:	83 ec 0c             	sub    $0xc,%esp
80101235:	68 0f 85 10 80       	push   $0x8010850f
8010123a:	e8 51 f1 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010123f:	83 ec 0c             	sub    $0xc,%esp
80101242:	68 15 85 10 80       	push   $0x80108515
80101247:	e8 44 f1 ff ff       	call   80100390 <panic>
8010124c:	66 90                	xchg   %ax,%ax
8010124e:	66 90                	xchg   %ax,%ax

80101250 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101250:	55                   	push   %ebp
80101251:	89 e5                	mov    %esp,%ebp
80101253:	56                   	push   %esi
80101254:	53                   	push   %ebx
80101255:	89 d3                	mov    %edx,%ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101257:	c1 ea 0c             	shr    $0xc,%edx
8010125a:	03 15 d8 29 11 80    	add    0x801129d8,%edx
80101260:	83 ec 08             	sub    $0x8,%esp
80101263:	52                   	push   %edx
80101264:	50                   	push   %eax
80101265:	e8 66 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010126a:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010126c:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
8010126f:	ba 01 00 00 00       	mov    $0x1,%edx
80101274:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101277:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010127d:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101280:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101282:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101287:	85 d1                	test   %edx,%ecx
80101289:	74 25                	je     801012b0 <bfree+0x60>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010128b:	f7 d2                	not    %edx
8010128d:	89 c6                	mov    %eax,%esi
  log_write(bp);
8010128f:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101292:	21 ca                	and    %ecx,%edx
80101294:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101298:	56                   	push   %esi
80101299:	e8 92 21 00 00       	call   80103430 <log_write>
  brelse(bp);
8010129e:	89 34 24             	mov    %esi,(%esp)
801012a1:	e8 3a ef ff ff       	call   801001e0 <brelse>
}
801012a6:	83 c4 10             	add    $0x10,%esp
801012a9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5d                   	pop    %ebp
801012af:	c3                   	ret    
    panic("freeing free block");
801012b0:	83 ec 0c             	sub    $0xc,%esp
801012b3:	68 1f 85 10 80       	push   $0x8010851f
801012b8:	e8 d3 f0 ff ff       	call   80100390 <panic>
801012bd:	8d 76 00             	lea    0x0(%esi),%esi

801012c0 <balloc>:
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801012c9:	8b 0d c0 29 11 80    	mov    0x801129c0,%ecx
{
801012cf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012d2:	85 c9                	test   %ecx,%ecx
801012d4:	0f 84 87 00 00 00    	je     80101361 <balloc+0xa1>
801012da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801012e1:	8b 75 dc             	mov    -0x24(%ebp),%esi
801012e4:	83 ec 08             	sub    $0x8,%esp
801012e7:	89 f0                	mov    %esi,%eax
801012e9:	c1 f8 0c             	sar    $0xc,%eax
801012ec:	03 05 d8 29 11 80    	add    0x801129d8,%eax
801012f2:	50                   	push   %eax
801012f3:	ff 75 d8             	pushl  -0x28(%ebp)
801012f6:	e8 d5 ed ff ff       	call   801000d0 <bread>
801012fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012fe:	a1 c0 29 11 80       	mov    0x801129c0,%eax
80101303:	83 c4 10             	add    $0x10,%esp
80101306:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101309:	31 c0                	xor    %eax,%eax
8010130b:	eb 2f                	jmp    8010133c <balloc+0x7c>
8010130d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101310:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101312:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101315:	bb 01 00 00 00       	mov    $0x1,%ebx
8010131a:	83 e1 07             	and    $0x7,%ecx
8010131d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010131f:	89 c1                	mov    %eax,%ecx
80101321:	c1 f9 03             	sar    $0x3,%ecx
80101324:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101329:	85 df                	test   %ebx,%edi
8010132b:	89 fa                	mov    %edi,%edx
8010132d:	74 41                	je     80101370 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010132f:	83 c0 01             	add    $0x1,%eax
80101332:	83 c6 01             	add    $0x1,%esi
80101335:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010133a:	74 05                	je     80101341 <balloc+0x81>
8010133c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010133f:	77 cf                	ja     80101310 <balloc+0x50>
    brelse(bp);
80101341:	83 ec 0c             	sub    $0xc,%esp
80101344:	ff 75 e4             	pushl  -0x1c(%ebp)
80101347:	e8 94 ee ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010134c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101353:	83 c4 10             	add    $0x10,%esp
80101356:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101359:	39 05 c0 29 11 80    	cmp    %eax,0x801129c0
8010135f:	77 80                	ja     801012e1 <balloc+0x21>
  panic("balloc: out of blocks");
80101361:	83 ec 0c             	sub    $0xc,%esp
80101364:	68 32 85 10 80       	push   $0x80108532
80101369:	e8 22 f0 ff ff       	call   80100390 <panic>
8010136e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101370:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101373:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101376:	09 da                	or     %ebx,%edx
80101378:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010137c:	57                   	push   %edi
8010137d:	e8 ae 20 00 00       	call   80103430 <log_write>
        brelse(bp);
80101382:	89 3c 24             	mov    %edi,(%esp)
80101385:	e8 56 ee ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
8010138a:	58                   	pop    %eax
8010138b:	5a                   	pop    %edx
8010138c:	56                   	push   %esi
8010138d:	ff 75 d8             	pushl  -0x28(%ebp)
80101390:	e8 3b ed ff ff       	call   801000d0 <bread>
80101395:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101397:	8d 40 5c             	lea    0x5c(%eax),%eax
8010139a:	83 c4 0c             	add    $0xc,%esp
8010139d:	68 00 02 00 00       	push   $0x200
801013a2:	6a 00                	push   $0x0
801013a4:	50                   	push   %eax
801013a5:	e8 c6 3b 00 00       	call   80104f70 <memset>
  log_write(bp);
801013aa:	89 1c 24             	mov    %ebx,(%esp)
801013ad:	e8 7e 20 00 00       	call   80103430 <log_write>
  brelse(bp);
801013b2:	89 1c 24             	mov    %ebx,(%esp)
801013b5:	e8 26 ee ff ff       	call   801001e0 <brelse>
}
801013ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013bd:	89 f0                	mov    %esi,%eax
801013bf:	5b                   	pop    %ebx
801013c0:	5e                   	pop    %esi
801013c1:	5f                   	pop    %edi
801013c2:	5d                   	pop    %ebp
801013c3:	c3                   	ret    
801013c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801013d0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	57                   	push   %edi
801013d4:	56                   	push   %esi
801013d5:	53                   	push   %ebx
801013d6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013d8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013da:	bb 14 2a 11 80       	mov    $0x80112a14,%ebx
{
801013df:	83 ec 28             	sub    $0x28,%esp
801013e2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013e5:	68 e0 29 11 80       	push   $0x801129e0
801013ea:	e8 71 3a 00 00       	call   80104e60 <acquire>
801013ef:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013f2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013f5:	eb 17                	jmp    8010140e <iget+0x3e>
801013f7:	89 f6                	mov    %esi,%esi
801013f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101400:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101406:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010140c:	73 22                	jae    80101430 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010140e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101411:	85 c9                	test   %ecx,%ecx
80101413:	7e 04                	jle    80101419 <iget+0x49>
80101415:	39 3b                	cmp    %edi,(%ebx)
80101417:	74 4f                	je     80101468 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101419:	85 f6                	test   %esi,%esi
8010141b:	75 e3                	jne    80101400 <iget+0x30>
8010141d:	85 c9                	test   %ecx,%ecx
8010141f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101422:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101428:	81 fb 34 46 11 80    	cmp    $0x80114634,%ebx
8010142e:	72 de                	jb     8010140e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101430:	85 f6                	test   %esi,%esi
80101432:	74 5b                	je     8010148f <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101434:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101437:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101439:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010143c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101443:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010144a:	68 e0 29 11 80       	push   $0x801129e0
8010144f:	e8 cc 3a 00 00       	call   80104f20 <release>

  return ip;
80101454:	83 c4 10             	add    $0x10,%esp
}
80101457:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010145a:	89 f0                	mov    %esi,%eax
8010145c:	5b                   	pop    %ebx
8010145d:	5e                   	pop    %esi
8010145e:	5f                   	pop    %edi
8010145f:	5d                   	pop    %ebp
80101460:	c3                   	ret    
80101461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101468:	39 53 04             	cmp    %edx,0x4(%ebx)
8010146b:	75 ac                	jne    80101419 <iget+0x49>
      release(&icache.lock);
8010146d:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101470:	83 c1 01             	add    $0x1,%ecx
      return ip;
80101473:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
80101475:	68 e0 29 11 80       	push   $0x801129e0
      ip->ref++;
8010147a:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
8010147d:	e8 9e 3a 00 00       	call   80104f20 <release>
      return ip;
80101482:	83 c4 10             	add    $0x10,%esp
}
80101485:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101488:	89 f0                	mov    %esi,%eax
8010148a:	5b                   	pop    %ebx
8010148b:	5e                   	pop    %esi
8010148c:	5f                   	pop    %edi
8010148d:	5d                   	pop    %ebp
8010148e:	c3                   	ret    
    panic("iget: no inodes");
8010148f:	83 ec 0c             	sub    $0xc,%esp
80101492:	68 48 85 10 80       	push   $0x80108548
80101497:	e8 f4 ee ff ff       	call   80100390 <panic>
8010149c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	57                   	push   %edi
801014a4:	56                   	push   %esi
801014a5:	53                   	push   %ebx
801014a6:	89 c6                	mov    %eax,%esi
801014a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801014ab:	83 fa 0b             	cmp    $0xb,%edx
801014ae:	77 18                	ja     801014c8 <bmap+0x28>
801014b0:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
801014b3:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801014b6:	85 db                	test   %ebx,%ebx
801014b8:	74 76                	je     80101530 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801014ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014bd:	89 d8                	mov    %ebx,%eax
801014bf:	5b                   	pop    %ebx
801014c0:	5e                   	pop    %esi
801014c1:	5f                   	pop    %edi
801014c2:	5d                   	pop    %ebp
801014c3:	c3                   	ret    
801014c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
801014c8:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
801014cb:	83 fb 7f             	cmp    $0x7f,%ebx
801014ce:	0f 87 90 00 00 00    	ja     80101564 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
801014d4:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
801014da:	8b 00                	mov    (%eax),%eax
801014dc:	85 d2                	test   %edx,%edx
801014de:	74 70                	je     80101550 <bmap+0xb0>
    bp = bread(ip->dev, addr);
801014e0:	83 ec 08             	sub    $0x8,%esp
801014e3:	52                   	push   %edx
801014e4:	50                   	push   %eax
801014e5:	e8 e6 eb ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801014ea:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801014ee:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
801014f1:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801014f3:	8b 1a                	mov    (%edx),%ebx
801014f5:	85 db                	test   %ebx,%ebx
801014f7:	75 1d                	jne    80101516 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
801014f9:	8b 06                	mov    (%esi),%eax
801014fb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801014fe:	e8 bd fd ff ff       	call   801012c0 <balloc>
80101503:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101506:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101509:	89 c3                	mov    %eax,%ebx
8010150b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010150d:	57                   	push   %edi
8010150e:	e8 1d 1f 00 00       	call   80103430 <log_write>
80101513:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101516:	83 ec 0c             	sub    $0xc,%esp
80101519:	57                   	push   %edi
8010151a:	e8 c1 ec ff ff       	call   801001e0 <brelse>
8010151f:	83 c4 10             	add    $0x10,%esp
}
80101522:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101525:	89 d8                	mov    %ebx,%eax
80101527:	5b                   	pop    %ebx
80101528:	5e                   	pop    %esi
80101529:	5f                   	pop    %edi
8010152a:	5d                   	pop    %ebp
8010152b:	c3                   	ret    
8010152c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101530:	8b 00                	mov    (%eax),%eax
80101532:	e8 89 fd ff ff       	call   801012c0 <balloc>
80101537:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010153d:	89 c3                	mov    %eax,%ebx
}
8010153f:	89 d8                	mov    %ebx,%eax
80101541:	5b                   	pop    %ebx
80101542:	5e                   	pop    %esi
80101543:	5f                   	pop    %edi
80101544:	5d                   	pop    %ebp
80101545:	c3                   	ret    
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101550:	e8 6b fd ff ff       	call   801012c0 <balloc>
80101555:	89 c2                	mov    %eax,%edx
80101557:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010155d:	8b 06                	mov    (%esi),%eax
8010155f:	e9 7c ff ff ff       	jmp    801014e0 <bmap+0x40>
  panic("bmap: out of range");
80101564:	83 ec 0c             	sub    $0xc,%esp
80101567:	68 58 85 10 80       	push   $0x80108558
8010156c:	e8 1f ee ff ff       	call   80100390 <panic>
80101571:	eb 0d                	jmp    80101580 <readsb>
80101573:	90                   	nop
80101574:	90                   	nop
80101575:	90                   	nop
80101576:	90                   	nop
80101577:	90                   	nop
80101578:	90                   	nop
80101579:	90                   	nop
8010157a:	90                   	nop
8010157b:	90                   	nop
8010157c:	90                   	nop
8010157d:	90                   	nop
8010157e:	90                   	nop
8010157f:	90                   	nop

80101580 <readsb>:
{
80101580:	55                   	push   %ebp
80101581:	89 e5                	mov    %esp,%ebp
80101583:	56                   	push   %esi
80101584:	53                   	push   %ebx
80101585:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101588:	83 ec 08             	sub    $0x8,%esp
8010158b:	6a 01                	push   $0x1
8010158d:	ff 75 08             	pushl  0x8(%ebp)
80101590:	e8 3b eb ff ff       	call   801000d0 <bread>
80101595:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101597:	8d 40 5c             	lea    0x5c(%eax),%eax
8010159a:	83 c4 0c             	add    $0xc,%esp
8010159d:	6a 1c                	push   $0x1c
8010159f:	50                   	push   %eax
801015a0:	56                   	push   %esi
801015a1:	e8 7a 3a 00 00       	call   80105020 <memmove>
  brelse(bp);
801015a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015a9:	83 c4 10             	add    $0x10,%esp
}
801015ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015af:	5b                   	pop    %ebx
801015b0:	5e                   	pop    %esi
801015b1:	5d                   	pop    %ebp
  brelse(bp);
801015b2:	e9 29 ec ff ff       	jmp    801001e0 <brelse>
801015b7:	89 f6                	mov    %esi,%esi
801015b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015c0 <iinit>:
{
801015c0:	55                   	push   %ebp
801015c1:	89 e5                	mov    %esp,%ebp
801015c3:	53                   	push   %ebx
801015c4:	bb 20 2a 11 80       	mov    $0x80112a20,%ebx
801015c9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015cc:	68 6b 85 10 80       	push   $0x8010856b
801015d1:	68 e0 29 11 80       	push   $0x801129e0
801015d6:	e8 45 37 00 00       	call   80104d20 <initlock>
801015db:	83 c4 10             	add    $0x10,%esp
801015de:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015e0:	83 ec 08             	sub    $0x8,%esp
801015e3:	68 72 85 10 80       	push   $0x80108572
801015e8:	53                   	push   %ebx
801015e9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015ef:	e8 fc 35 00 00       	call   80104bf0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801015f4:	83 c4 10             	add    $0x10,%esp
801015f7:	81 fb 40 46 11 80    	cmp    $0x80114640,%ebx
801015fd:	75 e1                	jne    801015e0 <iinit+0x20>
  readsb(dev, &sb);
801015ff:	83 ec 08             	sub    $0x8,%esp
80101602:	68 c0 29 11 80       	push   $0x801129c0
80101607:	ff 75 08             	pushl  0x8(%ebp)
8010160a:	e8 71 ff ff ff       	call   80101580 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010160f:	ff 35 d8 29 11 80    	pushl  0x801129d8
80101615:	ff 35 d4 29 11 80    	pushl  0x801129d4
8010161b:	ff 35 d0 29 11 80    	pushl  0x801129d0
80101621:	ff 35 cc 29 11 80    	pushl  0x801129cc
80101627:	ff 35 c8 29 11 80    	pushl  0x801129c8
8010162d:	ff 35 c4 29 11 80    	pushl  0x801129c4
80101633:	ff 35 c0 29 11 80    	pushl  0x801129c0
80101639:	68 1c 86 10 80       	push   $0x8010861c
8010163e:	e8 1d f0 ff ff       	call   80100660 <cprintf>
}
80101643:	83 c4 30             	add    $0x30,%esp
80101646:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101649:	c9                   	leave  
8010164a:	c3                   	ret    
8010164b:	90                   	nop
8010164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101650 <ialloc>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	57                   	push   %edi
80101654:	56                   	push   %esi
80101655:	53                   	push   %ebx
80101656:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101659:	83 3d c8 29 11 80 01 	cmpl   $0x1,0x801129c8
{
80101660:	8b 45 0c             	mov    0xc(%ebp),%eax
80101663:	8b 75 08             	mov    0x8(%ebp),%esi
80101666:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101669:	0f 86 91 00 00 00    	jbe    80101700 <ialloc+0xb0>
8010166f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101674:	eb 21                	jmp    80101697 <ialloc+0x47>
80101676:	8d 76 00             	lea    0x0(%esi),%esi
80101679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101680:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101683:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101686:	57                   	push   %edi
80101687:	e8 54 eb ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010168c:	83 c4 10             	add    $0x10,%esp
8010168f:	39 1d c8 29 11 80    	cmp    %ebx,0x801129c8
80101695:	76 69                	jbe    80101700 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101697:	89 d8                	mov    %ebx,%eax
80101699:	83 ec 08             	sub    $0x8,%esp
8010169c:	c1 e8 03             	shr    $0x3,%eax
8010169f:	03 05 d4 29 11 80    	add    0x801129d4,%eax
801016a5:	50                   	push   %eax
801016a6:	56                   	push   %esi
801016a7:	e8 24 ea ff ff       	call   801000d0 <bread>
801016ac:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
801016ae:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
801016b0:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
801016b3:	83 e0 07             	and    $0x7,%eax
801016b6:	c1 e0 06             	shl    $0x6,%eax
801016b9:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016bd:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016c1:	75 bd                	jne    80101680 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016c3:	83 ec 04             	sub    $0x4,%esp
801016c6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016c9:	6a 40                	push   $0x40
801016cb:	6a 00                	push   $0x0
801016cd:	51                   	push   %ecx
801016ce:	e8 9d 38 00 00       	call   80104f70 <memset>
      dip->type = type;
801016d3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801016d7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801016da:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801016dd:	89 3c 24             	mov    %edi,(%esp)
801016e0:	e8 4b 1d 00 00       	call   80103430 <log_write>
      brelse(bp);
801016e5:	89 3c 24             	mov    %edi,(%esp)
801016e8:	e8 f3 ea ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801016ed:	83 c4 10             	add    $0x10,%esp
}
801016f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016f3:	89 da                	mov    %ebx,%edx
801016f5:	89 f0                	mov    %esi,%eax
}
801016f7:	5b                   	pop    %ebx
801016f8:	5e                   	pop    %esi
801016f9:	5f                   	pop    %edi
801016fa:	5d                   	pop    %ebp
      return iget(dev, inum);
801016fb:	e9 d0 fc ff ff       	jmp    801013d0 <iget>
  panic("ialloc: no inodes");
80101700:	83 ec 0c             	sub    $0xc,%esp
80101703:	68 78 85 10 80       	push   $0x80108578
80101708:	e8 83 ec ff ff       	call   80100390 <panic>
8010170d:	8d 76 00             	lea    0x0(%esi),%esi

80101710 <iupdate>:
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	56                   	push   %esi
80101714:	53                   	push   %ebx
80101715:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101718:	83 ec 08             	sub    $0x8,%esp
8010171b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010171e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101721:	c1 e8 03             	shr    $0x3,%eax
80101724:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010172a:	50                   	push   %eax
8010172b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010172e:	e8 9d e9 ff ff       	call   801000d0 <bread>
80101733:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101735:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101738:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010173f:	83 e0 07             	and    $0x7,%eax
80101742:	c1 e0 06             	shl    $0x6,%eax
80101745:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101749:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010174c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101750:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101753:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101757:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010175b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010175f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101763:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101767:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010176a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010176d:	6a 34                	push   $0x34
8010176f:	53                   	push   %ebx
80101770:	50                   	push   %eax
80101771:	e8 aa 38 00 00       	call   80105020 <memmove>
  log_write(bp);
80101776:	89 34 24             	mov    %esi,(%esp)
80101779:	e8 b2 1c 00 00       	call   80103430 <log_write>
  brelse(bp);
8010177e:	89 75 08             	mov    %esi,0x8(%ebp)
80101781:	83 c4 10             	add    $0x10,%esp
}
80101784:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101787:	5b                   	pop    %ebx
80101788:	5e                   	pop    %esi
80101789:	5d                   	pop    %ebp
  brelse(bp);
8010178a:	e9 51 ea ff ff       	jmp    801001e0 <brelse>
8010178f:	90                   	nop

80101790 <idup>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	53                   	push   %ebx
80101794:	83 ec 10             	sub    $0x10,%esp
80101797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010179a:	68 e0 29 11 80       	push   $0x801129e0
8010179f:	e8 bc 36 00 00       	call   80104e60 <acquire>
  ip->ref++;
801017a4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017a8:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
801017af:	e8 6c 37 00 00       	call   80104f20 <release>
}
801017b4:	89 d8                	mov    %ebx,%eax
801017b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017b9:	c9                   	leave  
801017ba:	c3                   	ret    
801017bb:	90                   	nop
801017bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017c0 <ilock>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	56                   	push   %esi
801017c4:	53                   	push   %ebx
801017c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017c8:	85 db                	test   %ebx,%ebx
801017ca:	0f 84 b7 00 00 00    	je     80101887 <ilock+0xc7>
801017d0:	8b 53 08             	mov    0x8(%ebx),%edx
801017d3:	85 d2                	test   %edx,%edx
801017d5:	0f 8e ac 00 00 00    	jle    80101887 <ilock+0xc7>
  acquiresleep(&ip->lock);
801017db:	8d 43 0c             	lea    0xc(%ebx),%eax
801017de:	83 ec 0c             	sub    $0xc,%esp
801017e1:	50                   	push   %eax
801017e2:	e8 49 34 00 00       	call   80104c30 <acquiresleep>
  if(ip->valid == 0){
801017e7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017ea:	83 c4 10             	add    $0x10,%esp
801017ed:	85 c0                	test   %eax,%eax
801017ef:	74 0f                	je     80101800 <ilock+0x40>
}
801017f1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017f4:	5b                   	pop    %ebx
801017f5:	5e                   	pop    %esi
801017f6:	5d                   	pop    %ebp
801017f7:	c3                   	ret    
801017f8:	90                   	nop
801017f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101800:	8b 43 04             	mov    0x4(%ebx),%eax
80101803:	83 ec 08             	sub    $0x8,%esp
80101806:	c1 e8 03             	shr    $0x3,%eax
80101809:	03 05 d4 29 11 80    	add    0x801129d4,%eax
8010180f:	50                   	push   %eax
80101810:	ff 33                	pushl  (%ebx)
80101812:	e8 b9 e8 ff ff       	call   801000d0 <bread>
80101817:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101819:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010181c:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010181f:	83 e0 07             	and    $0x7,%eax
80101822:	c1 e0 06             	shl    $0x6,%eax
80101825:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101829:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010182c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010182f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101833:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101837:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010183b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010183f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101843:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101847:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010184b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010184e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101851:	6a 34                	push   $0x34
80101853:	50                   	push   %eax
80101854:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101857:	50                   	push   %eax
80101858:	e8 c3 37 00 00       	call   80105020 <memmove>
    brelse(bp);
8010185d:	89 34 24             	mov    %esi,(%esp)
80101860:	e8 7b e9 ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101865:	83 c4 10             	add    $0x10,%esp
80101868:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010186d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101874:	0f 85 77 ff ff ff    	jne    801017f1 <ilock+0x31>
      panic("ilock: no type");
8010187a:	83 ec 0c             	sub    $0xc,%esp
8010187d:	68 90 85 10 80       	push   $0x80108590
80101882:	e8 09 eb ff ff       	call   80100390 <panic>
    panic("ilock");
80101887:	83 ec 0c             	sub    $0xc,%esp
8010188a:	68 8a 85 10 80       	push   $0x8010858a
8010188f:	e8 fc ea ff ff       	call   80100390 <panic>
80101894:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010189a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801018a0 <iunlock>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	56                   	push   %esi
801018a4:	53                   	push   %ebx
801018a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018a8:	85 db                	test   %ebx,%ebx
801018aa:	74 28                	je     801018d4 <iunlock+0x34>
801018ac:	8d 73 0c             	lea    0xc(%ebx),%esi
801018af:	83 ec 0c             	sub    $0xc,%esp
801018b2:	56                   	push   %esi
801018b3:	e8 18 34 00 00       	call   80104cd0 <holdingsleep>
801018b8:	83 c4 10             	add    $0x10,%esp
801018bb:	85 c0                	test   %eax,%eax
801018bd:	74 15                	je     801018d4 <iunlock+0x34>
801018bf:	8b 43 08             	mov    0x8(%ebx),%eax
801018c2:	85 c0                	test   %eax,%eax
801018c4:	7e 0e                	jle    801018d4 <iunlock+0x34>
  releasesleep(&ip->lock);
801018c6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018cc:	5b                   	pop    %ebx
801018cd:	5e                   	pop    %esi
801018ce:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018cf:	e9 bc 33 00 00       	jmp    80104c90 <releasesleep>
    panic("iunlock");
801018d4:	83 ec 0c             	sub    $0xc,%esp
801018d7:	68 9f 85 10 80       	push   $0x8010859f
801018dc:	e8 af ea ff ff       	call   80100390 <panic>
801018e1:	eb 0d                	jmp    801018f0 <iput>
801018e3:	90                   	nop
801018e4:	90                   	nop
801018e5:	90                   	nop
801018e6:	90                   	nop
801018e7:	90                   	nop
801018e8:	90                   	nop
801018e9:	90                   	nop
801018ea:	90                   	nop
801018eb:	90                   	nop
801018ec:	90                   	nop
801018ed:	90                   	nop
801018ee:	90                   	nop
801018ef:	90                   	nop

801018f0 <iput>:
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	57                   	push   %edi
801018f4:	56                   	push   %esi
801018f5:	53                   	push   %ebx
801018f6:	83 ec 28             	sub    $0x28,%esp
801018f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018fc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018ff:	57                   	push   %edi
80101900:	e8 2b 33 00 00       	call   80104c30 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101905:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101908:	83 c4 10             	add    $0x10,%esp
8010190b:	85 d2                	test   %edx,%edx
8010190d:	74 07                	je     80101916 <iput+0x26>
8010190f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101914:	74 32                	je     80101948 <iput+0x58>
  releasesleep(&ip->lock);
80101916:	83 ec 0c             	sub    $0xc,%esp
80101919:	57                   	push   %edi
8010191a:	e8 71 33 00 00       	call   80104c90 <releasesleep>
  acquire(&icache.lock);
8010191f:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101926:	e8 35 35 00 00       	call   80104e60 <acquire>
  ip->ref--;
8010192b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010192f:	83 c4 10             	add    $0x10,%esp
80101932:	c7 45 08 e0 29 11 80 	movl   $0x801129e0,0x8(%ebp)
}
80101939:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010193c:	5b                   	pop    %ebx
8010193d:	5e                   	pop    %esi
8010193e:	5f                   	pop    %edi
8010193f:	5d                   	pop    %ebp
  release(&icache.lock);
80101940:	e9 db 35 00 00       	jmp    80104f20 <release>
80101945:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101948:	83 ec 0c             	sub    $0xc,%esp
8010194b:	68 e0 29 11 80       	push   $0x801129e0
80101950:	e8 0b 35 00 00       	call   80104e60 <acquire>
    int r = ip->ref;
80101955:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101958:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
8010195f:	e8 bc 35 00 00       	call   80104f20 <release>
    if(r == 1){
80101964:	83 c4 10             	add    $0x10,%esp
80101967:	83 fe 01             	cmp    $0x1,%esi
8010196a:	75 aa                	jne    80101916 <iput+0x26>
8010196c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101972:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101975:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101978:	89 cf                	mov    %ecx,%edi
8010197a:	eb 0b                	jmp    80101987 <iput+0x97>
8010197c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101980:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101983:	39 fe                	cmp    %edi,%esi
80101985:	74 19                	je     801019a0 <iput+0xb0>
    if(ip->addrs[i]){
80101987:	8b 16                	mov    (%esi),%edx
80101989:	85 d2                	test   %edx,%edx
8010198b:	74 f3                	je     80101980 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010198d:	8b 03                	mov    (%ebx),%eax
8010198f:	e8 bc f8 ff ff       	call   80101250 <bfree>
      ip->addrs[i] = 0;
80101994:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010199a:	eb e4                	jmp    80101980 <iput+0x90>
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019a0:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019a9:	85 c0                	test   %eax,%eax
801019ab:	75 33                	jne    801019e0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019ad:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019b0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019b7:	53                   	push   %ebx
801019b8:	e8 53 fd ff ff       	call   80101710 <iupdate>
      ip->type = 0;
801019bd:	31 c0                	xor    %eax,%eax
801019bf:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019c3:	89 1c 24             	mov    %ebx,(%esp)
801019c6:	e8 45 fd ff ff       	call   80101710 <iupdate>
      ip->valid = 0;
801019cb:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801019d2:	83 c4 10             	add    $0x10,%esp
801019d5:	e9 3c ff ff ff       	jmp    80101916 <iput+0x26>
801019da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801019e0:	83 ec 08             	sub    $0x8,%esp
801019e3:	50                   	push   %eax
801019e4:	ff 33                	pushl  (%ebx)
801019e6:	e8 e5 e6 ff ff       	call   801000d0 <bread>
801019eb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019f1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801019f7:	8d 70 5c             	lea    0x5c(%eax),%esi
801019fa:	83 c4 10             	add    $0x10,%esp
801019fd:	89 cf                	mov    %ecx,%edi
801019ff:	eb 0e                	jmp    80101a0f <iput+0x11f>
80101a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a08:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
80101a0b:	39 fe                	cmp    %edi,%esi
80101a0d:	74 0f                	je     80101a1e <iput+0x12e>
      if(a[j])
80101a0f:	8b 16                	mov    (%esi),%edx
80101a11:	85 d2                	test   %edx,%edx
80101a13:	74 f3                	je     80101a08 <iput+0x118>
        bfree(ip->dev, a[j]);
80101a15:	8b 03                	mov    (%ebx),%eax
80101a17:	e8 34 f8 ff ff       	call   80101250 <bfree>
80101a1c:	eb ea                	jmp    80101a08 <iput+0x118>
    brelse(bp);
80101a1e:	83 ec 0c             	sub    $0xc,%esp
80101a21:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a24:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a27:	e8 b4 e7 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a2c:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a32:	8b 03                	mov    (%ebx),%eax
80101a34:	e8 17 f8 ff ff       	call   80101250 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a39:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a40:	00 00 00 
80101a43:	83 c4 10             	add    $0x10,%esp
80101a46:	e9 62 ff ff ff       	jmp    801019ad <iput+0xbd>
80101a4b:	90                   	nop
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a50 <iunlockput>:
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	53                   	push   %ebx
80101a54:	83 ec 10             	sub    $0x10,%esp
80101a57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101a5a:	53                   	push   %ebx
80101a5b:	e8 40 fe ff ff       	call   801018a0 <iunlock>
  iput(ip);
80101a60:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a63:	83 c4 10             	add    $0x10,%esp
}
80101a66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a69:	c9                   	leave  
  iput(ip);
80101a6a:	e9 81 fe ff ff       	jmp    801018f0 <iput>
80101a6f:	90                   	nop

80101a70 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	8b 55 08             	mov    0x8(%ebp),%edx
80101a76:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a79:	8b 0a                	mov    (%edx),%ecx
80101a7b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a7e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a81:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a84:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a88:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a8b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a8f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a93:	8b 52 58             	mov    0x58(%edx),%edx
80101a96:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a99:	5d                   	pop    %ebp
80101a9a:	c3                   	ret    
80101a9b:	90                   	nop
80101a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101aa0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aaf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ab7:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101abd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ac0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ac3:	0f 84 a7 00 00 00    	je     80101b70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	8b 40 58             	mov    0x58(%eax),%eax
80101acf:	39 c6                	cmp    %eax,%esi
80101ad1:	0f 87 ba 00 00 00    	ja     80101b91 <readi+0xf1>
80101ad7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101ada:	89 f9                	mov    %edi,%ecx
80101adc:	01 f1                	add    %esi,%ecx
80101ade:	0f 82 ad 00 00 00    	jb     80101b91 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101ae4:	89 c2                	mov    %eax,%edx
80101ae6:	29 f2                	sub    %esi,%edx
80101ae8:	39 c8                	cmp    %ecx,%eax
80101aea:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101aed:	31 ff                	xor    %edi,%edi
80101aef:	85 d2                	test   %edx,%edx
    n = ip->size - off;
80101af1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101af4:	74 6c                	je     80101b62 <readi+0xc2>
80101af6:	8d 76 00             	lea    0x0(%esi),%esi
80101af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b03:	89 f2                	mov    %esi,%edx
80101b05:	c1 ea 09             	shr    $0x9,%edx
80101b08:	89 d8                	mov    %ebx,%eax
80101b0a:	e8 91 f9 ff ff       	call   801014a0 <bmap>
80101b0f:	83 ec 08             	sub    $0x8,%esp
80101b12:	50                   	push   %eax
80101b13:	ff 33                	pushl  (%ebx)
80101b15:	e8 b6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b1d:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1f:	89 f0                	mov    %esi,%eax
80101b21:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b26:	b9 00 02 00 00       	mov    $0x200,%ecx
80101b2b:	83 c4 0c             	add    $0xc,%esp
80101b2e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b30:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101b34:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b37:	29 fb                	sub    %edi,%ebx
80101b39:	39 d9                	cmp    %ebx,%ecx
80101b3b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b3e:	53                   	push   %ebx
80101b3f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b40:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101b42:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b45:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b47:	e8 d4 34 00 00       	call   80105020 <memmove>
    brelse(bp);
80101b4c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b4f:	89 14 24             	mov    %edx,(%esp)
80101b52:	e8 89 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b57:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b5a:	83 c4 10             	add    $0x10,%esp
80101b5d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b60:	77 9e                	ja     80101b00 <readi+0x60>
  }
  return n;
80101b62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b68:	5b                   	pop    %ebx
80101b69:	5e                   	pop    %esi
80101b6a:	5f                   	pop    %edi
80101b6b:	5d                   	pop    %ebp
80101b6c:	c3                   	ret    
80101b6d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b74:	66 83 f8 09          	cmp    $0x9,%ax
80101b78:	77 17                	ja     80101b91 <readi+0xf1>
80101b7a:	8b 04 c5 60 29 11 80 	mov    -0x7feed6a0(,%eax,8),%eax
80101b81:	85 c0                	test   %eax,%eax
80101b83:	74 0c                	je     80101b91 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b85:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b8f:	ff e0                	jmp    *%eax
      return -1;
80101b91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b96:	eb cd                	jmp    80101b65 <readi+0xc5>
80101b98:	90                   	nop
80101b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ba0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 1c             	sub    $0x1c,%esp
80101ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101baf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101bb2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101bb7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101bba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bbd:	8b 75 10             	mov    0x10(%ebp),%esi
80101bc0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bc3:	0f 84 b7 00 00 00    	je     80101c80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bc9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bcc:	39 70 58             	cmp    %esi,0x58(%eax)
80101bcf:	0f 82 eb 00 00 00    	jb     80101cc0 <writei+0x120>
80101bd5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bd8:	31 d2                	xor    %edx,%edx
80101bda:	89 f8                	mov    %edi,%eax
80101bdc:	01 f0                	add    %esi,%eax
80101bde:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101be1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101be6:	0f 87 d4 00 00 00    	ja     80101cc0 <writei+0x120>
80101bec:	85 d2                	test   %edx,%edx
80101bee:	0f 85 cc 00 00 00    	jne    80101cc0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bf4:	85 ff                	test   %edi,%edi
80101bf6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101bfd:	74 72                	je     80101c71 <writei+0xd1>
80101bff:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101c03:	89 f2                	mov    %esi,%edx
80101c05:	c1 ea 09             	shr    $0x9,%edx
80101c08:	89 f8                	mov    %edi,%eax
80101c0a:	e8 91 f8 ff ff       	call   801014a0 <bmap>
80101c0f:	83 ec 08             	sub    $0x8,%esp
80101c12:	50                   	push   %eax
80101c13:	ff 37                	pushl  (%edi)
80101c15:	e8 b6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c1a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c1d:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c20:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c22:	89 f0                	mov    %esi,%eax
80101c24:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c29:	83 c4 0c             	add    $0xc,%esp
80101c2c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c31:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c33:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c37:	39 d9                	cmp    %ebx,%ecx
80101c39:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c3c:	53                   	push   %ebx
80101c3d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c40:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c42:	50                   	push   %eax
80101c43:	e8 d8 33 00 00       	call   80105020 <memmove>
    log_write(bp);
80101c48:	89 3c 24             	mov    %edi,(%esp)
80101c4b:	e8 e0 17 00 00       	call   80103430 <log_write>
    brelse(bp);
80101c50:	89 3c 24             	mov    %edi,(%esp)
80101c53:	e8 88 e5 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c58:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c5b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c5e:	83 c4 10             	add    $0x10,%esp
80101c61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c64:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c67:	77 97                	ja     80101c00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c69:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c6c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c6f:	77 37                	ja     80101ca8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c71:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c77:	5b                   	pop    %ebx
80101c78:	5e                   	pop    %esi
80101c79:	5f                   	pop    %edi
80101c7a:	5d                   	pop    %ebp
80101c7b:	c3                   	ret    
80101c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c84:	66 83 f8 09          	cmp    $0x9,%ax
80101c88:	77 36                	ja     80101cc0 <writei+0x120>
80101c8a:	8b 04 c5 64 29 11 80 	mov    -0x7feed69c(,%eax,8),%eax
80101c91:	85 c0                	test   %eax,%eax
80101c93:	74 2b                	je     80101cc0 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101c95:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101c98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c9b:	5b                   	pop    %ebx
80101c9c:	5e                   	pop    %esi
80101c9d:	5f                   	pop    %edi
80101c9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c9f:	ff e0                	jmp    *%eax
80101ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101ca8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101cab:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101cae:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101cb1:	50                   	push   %eax
80101cb2:	e8 59 fa ff ff       	call   80101710 <iupdate>
80101cb7:	83 c4 10             	add    $0x10,%esp
80101cba:	eb b5                	jmp    80101c71 <writei+0xd1>
80101cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cc5:	eb ad                	jmp    80101c74 <writei+0xd4>
80101cc7:	89 f6                	mov    %esi,%esi
80101cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cd6:	6a 0e                	push   $0xe
80101cd8:	ff 75 0c             	pushl  0xc(%ebp)
80101cdb:	ff 75 08             	pushl  0x8(%ebp)
80101cde:	e8 ad 33 00 00       	call   80105090 <strncmp>
}
80101ce3:	c9                   	leave  
80101ce4:	c3                   	ret    
80101ce5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	53                   	push   %ebx
80101cf6:	83 ec 1c             	sub    $0x1c,%esp
80101cf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d01:	0f 85 85 00 00 00    	jne    80101d8c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d07:	8b 53 58             	mov    0x58(%ebx),%edx
80101d0a:	31 ff                	xor    %edi,%edi
80101d0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d0f:	85 d2                	test   %edx,%edx
80101d11:	74 3e                	je     80101d51 <dirlookup+0x61>
80101d13:	90                   	nop
80101d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d18:	6a 10                	push   $0x10
80101d1a:	57                   	push   %edi
80101d1b:	56                   	push   %esi
80101d1c:	53                   	push   %ebx
80101d1d:	e8 7e fd ff ff       	call   80101aa0 <readi>
80101d22:	83 c4 10             	add    $0x10,%esp
80101d25:	83 f8 10             	cmp    $0x10,%eax
80101d28:	75 55                	jne    80101d7f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d2f:	74 18                	je     80101d49 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d31:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d34:	83 ec 04             	sub    $0x4,%esp
80101d37:	6a 0e                	push   $0xe
80101d39:	50                   	push   %eax
80101d3a:	ff 75 0c             	pushl  0xc(%ebp)
80101d3d:	e8 4e 33 00 00       	call   80105090 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d42:	83 c4 10             	add    $0x10,%esp
80101d45:	85 c0                	test   %eax,%eax
80101d47:	74 17                	je     80101d60 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d49:	83 c7 10             	add    $0x10,%edi
80101d4c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d4f:	72 c7                	jb     80101d18 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d51:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d54:	31 c0                	xor    %eax,%eax
}
80101d56:	5b                   	pop    %ebx
80101d57:	5e                   	pop    %esi
80101d58:	5f                   	pop    %edi
80101d59:	5d                   	pop    %ebp
80101d5a:	c3                   	ret    
80101d5b:	90                   	nop
80101d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101d60:	8b 45 10             	mov    0x10(%ebp),%eax
80101d63:	85 c0                	test   %eax,%eax
80101d65:	74 05                	je     80101d6c <dirlookup+0x7c>
        *poff = off;
80101d67:	8b 45 10             	mov    0x10(%ebp),%eax
80101d6a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d6c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d70:	8b 03                	mov    (%ebx),%eax
80101d72:	e8 59 f6 ff ff       	call   801013d0 <iget>
}
80101d77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7a:	5b                   	pop    %ebx
80101d7b:	5e                   	pop    %esi
80101d7c:	5f                   	pop    %edi
80101d7d:	5d                   	pop    %ebp
80101d7e:	c3                   	ret    
      panic("dirlookup read");
80101d7f:	83 ec 0c             	sub    $0xc,%esp
80101d82:	68 b9 85 10 80       	push   $0x801085b9
80101d87:	e8 04 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101d8c:	83 ec 0c             	sub    $0xc,%esp
80101d8f:	68 a7 85 10 80       	push   $0x801085a7
80101d94:	e8 f7 e5 ff ff       	call   80100390 <panic>
80101d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101da0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	89 cf                	mov    %ecx,%edi
80101da8:	89 c3                	mov    %eax,%ebx
80101daa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dad:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101db0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101db3:	0f 84 67 01 00 00    	je     80101f20 <namex+0x180>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101db9:	e8 a2 21 00 00       	call   80103f60 <myproc>
  acquire(&icache.lock);
80101dbe:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101dc1:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101dc4:	68 e0 29 11 80       	push   $0x801129e0
80101dc9:	e8 92 30 00 00       	call   80104e60 <acquire>
  ip->ref++;
80101dce:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dd2:	c7 04 24 e0 29 11 80 	movl   $0x801129e0,(%esp)
80101dd9:	e8 42 31 00 00       	call   80104f20 <release>
80101dde:	83 c4 10             	add    $0x10,%esp
80101de1:	eb 08                	jmp    80101deb <namex+0x4b>
80101de3:	90                   	nop
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101de8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101deb:	0f b6 03             	movzbl (%ebx),%eax
80101dee:	3c 2f                	cmp    $0x2f,%al
80101df0:	74 f6                	je     80101de8 <namex+0x48>
  if(*path == 0)
80101df2:	84 c0                	test   %al,%al
80101df4:	0f 84 ee 00 00 00    	je     80101ee8 <namex+0x148>
  while(*path != '/' && *path != 0)
80101dfa:	0f b6 03             	movzbl (%ebx),%eax
80101dfd:	3c 2f                	cmp    $0x2f,%al
80101dff:	0f 84 b3 00 00 00    	je     80101eb8 <namex+0x118>
80101e05:	84 c0                	test   %al,%al
80101e07:	89 da                	mov    %ebx,%edx
80101e09:	75 09                	jne    80101e14 <namex+0x74>
80101e0b:	e9 a8 00 00 00       	jmp    80101eb8 <namex+0x118>
80101e10:	84 c0                	test   %al,%al
80101e12:	74 0a                	je     80101e1e <namex+0x7e>
    path++;
80101e14:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101e17:	0f b6 02             	movzbl (%edx),%eax
80101e1a:	3c 2f                	cmp    $0x2f,%al
80101e1c:	75 f2                	jne    80101e10 <namex+0x70>
80101e1e:	89 d1                	mov    %edx,%ecx
80101e20:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101e22:	83 f9 0d             	cmp    $0xd,%ecx
80101e25:	0f 8e 91 00 00 00    	jle    80101ebc <namex+0x11c>
    memmove(name, s, DIRSIZ);
80101e2b:	83 ec 04             	sub    $0x4,%esp
80101e2e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101e31:	6a 0e                	push   $0xe
80101e33:	53                   	push   %ebx
80101e34:	57                   	push   %edi
80101e35:	e8 e6 31 00 00       	call   80105020 <memmove>
    path++;
80101e3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101e3d:	83 c4 10             	add    $0x10,%esp
    path++;
80101e40:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101e42:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101e45:	75 11                	jne    80101e58 <namex+0xb8>
80101e47:	89 f6                	mov    %esi,%esi
80101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101e50:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e56:	74 f8                	je     80101e50 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e58:	83 ec 0c             	sub    $0xc,%esp
80101e5b:	56                   	push   %esi
80101e5c:	e8 5f f9 ff ff       	call   801017c0 <ilock>
    if(ip->type != T_DIR){
80101e61:	83 c4 10             	add    $0x10,%esp
80101e64:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e69:	0f 85 91 00 00 00    	jne    80101f00 <namex+0x160>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101e72:	85 d2                	test   %edx,%edx
80101e74:	74 09                	je     80101e7f <namex+0xdf>
80101e76:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e79:	0f 84 b7 00 00 00    	je     80101f36 <namex+0x196>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e7f:	83 ec 04             	sub    $0x4,%esp
80101e82:	6a 00                	push   $0x0
80101e84:	57                   	push   %edi
80101e85:	56                   	push   %esi
80101e86:	e8 65 fe ff ff       	call   80101cf0 <dirlookup>
80101e8b:	83 c4 10             	add    $0x10,%esp
80101e8e:	85 c0                	test   %eax,%eax
80101e90:	74 6e                	je     80101f00 <namex+0x160>
  iunlock(ip);
80101e92:	83 ec 0c             	sub    $0xc,%esp
80101e95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e98:	56                   	push   %esi
80101e99:	e8 02 fa ff ff       	call   801018a0 <iunlock>
  iput(ip);
80101e9e:	89 34 24             	mov    %esi,(%esp)
80101ea1:	e8 4a fa ff ff       	call   801018f0 <iput>
80101ea6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ea9:	83 c4 10             	add    $0x10,%esp
80101eac:	89 c6                	mov    %eax,%esi
80101eae:	e9 38 ff ff ff       	jmp    80101deb <namex+0x4b>
80101eb3:	90                   	nop
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101eb8:	89 da                	mov    %ebx,%edx
80101eba:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101ebc:	83 ec 04             	sub    $0x4,%esp
80101ebf:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ec2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101ec5:	51                   	push   %ecx
80101ec6:	53                   	push   %ebx
80101ec7:	57                   	push   %edi
80101ec8:	e8 53 31 00 00       	call   80105020 <memmove>
    name[len] = 0;
80101ecd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ed0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ed3:	83 c4 10             	add    $0x10,%esp
80101ed6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101eda:	89 d3                	mov    %edx,%ebx
80101edc:	e9 61 ff ff ff       	jmp    80101e42 <namex+0xa2>
80101ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ee8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101eeb:	85 c0                	test   %eax,%eax
80101eed:	75 5d                	jne    80101f4c <namex+0x1ac>
    iput(ip);
    return 0;
  }
  return ip;
}
80101eef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ef2:	89 f0                	mov    %esi,%eax
80101ef4:	5b                   	pop    %ebx
80101ef5:	5e                   	pop    %esi
80101ef6:	5f                   	pop    %edi
80101ef7:	5d                   	pop    %ebp
80101ef8:	c3                   	ret    
80101ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101f00:	83 ec 0c             	sub    $0xc,%esp
80101f03:	56                   	push   %esi
80101f04:	e8 97 f9 ff ff       	call   801018a0 <iunlock>
  iput(ip);
80101f09:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f0c:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f0e:	e8 dd f9 ff ff       	call   801018f0 <iput>
      return 0;
80101f13:	83 c4 10             	add    $0x10,%esp
}
80101f16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f19:	89 f0                	mov    %esi,%eax
80101f1b:	5b                   	pop    %ebx
80101f1c:	5e                   	pop    %esi
80101f1d:	5f                   	pop    %edi
80101f1e:	5d                   	pop    %ebp
80101f1f:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101f20:	ba 01 00 00 00       	mov    $0x1,%edx
80101f25:	b8 01 00 00 00       	mov    $0x1,%eax
80101f2a:	e8 a1 f4 ff ff       	call   801013d0 <iget>
80101f2f:	89 c6                	mov    %eax,%esi
80101f31:	e9 b5 fe ff ff       	jmp    80101deb <namex+0x4b>
      iunlock(ip);
80101f36:	83 ec 0c             	sub    $0xc,%esp
80101f39:	56                   	push   %esi
80101f3a:	e8 61 f9 ff ff       	call   801018a0 <iunlock>
      return ip;
80101f3f:	83 c4 10             	add    $0x10,%esp
}
80101f42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f45:	89 f0                	mov    %esi,%eax
80101f47:	5b                   	pop    %ebx
80101f48:	5e                   	pop    %esi
80101f49:	5f                   	pop    %edi
80101f4a:	5d                   	pop    %ebp
80101f4b:	c3                   	ret    
    iput(ip);
80101f4c:	83 ec 0c             	sub    $0xc,%esp
80101f4f:	56                   	push   %esi
    return 0;
80101f50:	31 f6                	xor    %esi,%esi
    iput(ip);
80101f52:	e8 99 f9 ff ff       	call   801018f0 <iput>
    return 0;
80101f57:	83 c4 10             	add    $0x10,%esp
80101f5a:	eb 93                	jmp    80101eef <namex+0x14f>
80101f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f60 <dirlink>:
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 20             	sub    $0x20,%esp
80101f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f6c:	6a 00                	push   $0x0
80101f6e:	ff 75 0c             	pushl  0xc(%ebp)
80101f71:	53                   	push   %ebx
80101f72:	e8 79 fd ff ff       	call   80101cf0 <dirlookup>
80101f77:	83 c4 10             	add    $0x10,%esp
80101f7a:	85 c0                	test   %eax,%eax
80101f7c:	75 67                	jne    80101fe5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f7e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101f81:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f84:	85 ff                	test   %edi,%edi
80101f86:	74 29                	je     80101fb1 <dirlink+0x51>
80101f88:	31 ff                	xor    %edi,%edi
80101f8a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f8d:	eb 09                	jmp    80101f98 <dirlink+0x38>
80101f8f:	90                   	nop
80101f90:	83 c7 10             	add    $0x10,%edi
80101f93:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f96:	73 19                	jae    80101fb1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f98:	6a 10                	push   $0x10
80101f9a:	57                   	push   %edi
80101f9b:	56                   	push   %esi
80101f9c:	53                   	push   %ebx
80101f9d:	e8 fe fa ff ff       	call   80101aa0 <readi>
80101fa2:	83 c4 10             	add    $0x10,%esp
80101fa5:	83 f8 10             	cmp    $0x10,%eax
80101fa8:	75 4e                	jne    80101ff8 <dirlink+0x98>
    if(de.inum == 0)
80101faa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101faf:	75 df                	jne    80101f90 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101fb1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fb4:	83 ec 04             	sub    $0x4,%esp
80101fb7:	6a 0e                	push   $0xe
80101fb9:	ff 75 0c             	pushl  0xc(%ebp)
80101fbc:	50                   	push   %eax
80101fbd:	e8 2e 31 00 00       	call   801050f0 <strncpy>
  de.inum = inum;
80101fc2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fc5:	6a 10                	push   $0x10
80101fc7:	57                   	push   %edi
80101fc8:	56                   	push   %esi
80101fc9:	53                   	push   %ebx
  de.inum = inum;
80101fca:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fce:	e8 cd fb ff ff       	call   80101ba0 <writei>
80101fd3:	83 c4 20             	add    $0x20,%esp
80101fd6:	83 f8 10             	cmp    $0x10,%eax
80101fd9:	75 2a                	jne    80102005 <dirlink+0xa5>
  return 0;
80101fdb:	31 c0                	xor    %eax,%eax
}
80101fdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe0:	5b                   	pop    %ebx
80101fe1:	5e                   	pop    %esi
80101fe2:	5f                   	pop    %edi
80101fe3:	5d                   	pop    %ebp
80101fe4:	c3                   	ret    
    iput(ip);
80101fe5:	83 ec 0c             	sub    $0xc,%esp
80101fe8:	50                   	push   %eax
80101fe9:	e8 02 f9 ff ff       	call   801018f0 <iput>
    return -1;
80101fee:	83 c4 10             	add    $0x10,%esp
80101ff1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff6:	eb e5                	jmp    80101fdd <dirlink+0x7d>
      panic("dirlink read");
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	68 c8 85 10 80       	push   $0x801085c8
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("dirlink");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 15 8d 10 80       	push   $0x80108d15
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <namei>:

struct inode*
namei(char *path)
{
80102020:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102021:	31 d2                	xor    %edx,%edx
{
80102023:	89 e5                	mov    %esp,%ebp
80102025:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102028:	8b 45 08             	mov    0x8(%ebp),%eax
8010202b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010202e:	e8 6d fd ff ff       	call   80101da0 <namex>
}
80102033:	c9                   	leave  
80102034:	c3                   	ret    
80102035:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102040 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102040:	55                   	push   %ebp
  return namex(path, 1, name);
80102041:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102046:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102048:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010204b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010204e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010204f:	e9 4c fd ff ff       	jmp    80101da0 <namex>
80102054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010205a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102060 <itoa>:

#include "fcntl.h"
#define DIGITS 14

char* itoa(int i, char b[]){
80102060:	55                   	push   %ebp
    char const digit[] = "0123456789";
80102061:	b8 38 39 00 00       	mov    $0x3938,%eax
char* itoa(int i, char b[]){
80102066:	89 e5                	mov    %esp,%ebp
80102068:	57                   	push   %edi
80102069:	56                   	push   %esi
8010206a:	53                   	push   %ebx
8010206b:	83 ec 10             	sub    $0x10,%esp
8010206e:	8b 4d 08             	mov    0x8(%ebp),%ecx
    char const digit[] = "0123456789";
80102071:	c7 45 e9 30 31 32 33 	movl   $0x33323130,-0x17(%ebp)
80102078:	c7 45 ed 34 35 36 37 	movl   $0x37363534,-0x13(%ebp)
8010207f:	66 89 45 f1          	mov    %ax,-0xf(%ebp)
80102083:	c6 45 f3 00          	movb   $0x0,-0xd(%ebp)
80102087:	8b 75 0c             	mov    0xc(%ebp),%esi
    char* p = b;
    if(i<0){
8010208a:	85 c9                	test   %ecx,%ecx
8010208c:	79 0a                	jns    80102098 <itoa+0x38>
8010208e:	89 f0                	mov    %esi,%eax
80102090:	8d 76 01             	lea    0x1(%esi),%esi
        *p++ = '-';
        i *= -1;
80102093:	f7 d9                	neg    %ecx
        *p++ = '-';
80102095:	c6 00 2d             	movb   $0x2d,(%eax)
    }
    int shifter = i;
80102098:	89 cb                	mov    %ecx,%ebx
    do{ //Move to where representation ends
        ++p;
        shifter = shifter/10;
8010209a:	bf 67 66 66 66       	mov    $0x66666667,%edi
8010209f:	90                   	nop
801020a0:	89 d8                	mov    %ebx,%eax
801020a2:	c1 fb 1f             	sar    $0x1f,%ebx
        ++p;
801020a5:	83 c6 01             	add    $0x1,%esi
        shifter = shifter/10;
801020a8:	f7 ef                	imul   %edi
801020aa:	c1 fa 02             	sar    $0x2,%edx
    }while(shifter);
801020ad:	29 da                	sub    %ebx,%edx
801020af:	89 d3                	mov    %edx,%ebx
801020b1:	75 ed                	jne    801020a0 <itoa+0x40>
    *p = '\0';
801020b3:	c6 06 00             	movb   $0x0,(%esi)
    do{ //Move back, inserting digits as u go
        *--p = digit[i%10];
801020b6:	bb 67 66 66 66       	mov    $0x66666667,%ebx
801020bb:	90                   	nop
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020c0:	89 c8                	mov    %ecx,%eax
801020c2:	83 ee 01             	sub    $0x1,%esi
801020c5:	f7 eb                	imul   %ebx
801020c7:	89 c8                	mov    %ecx,%eax
801020c9:	c1 f8 1f             	sar    $0x1f,%eax
801020cc:	c1 fa 02             	sar    $0x2,%edx
801020cf:	29 c2                	sub    %eax,%edx
801020d1:	8d 04 92             	lea    (%edx,%edx,4),%eax
801020d4:	01 c0                	add    %eax,%eax
801020d6:	29 c1                	sub    %eax,%ecx
        i = i/10;
    }while(i);
801020d8:	85 d2                	test   %edx,%edx
        *--p = digit[i%10];
801020da:	0f b6 44 0d e9       	movzbl -0x17(%ebp,%ecx,1),%eax
        i = i/10;
801020df:	89 d1                	mov    %edx,%ecx
        *--p = digit[i%10];
801020e1:	88 06                	mov    %al,(%esi)
    }while(i);
801020e3:	75 db                	jne    801020c0 <itoa+0x60>
    return b;
}
801020e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801020e8:	83 c4 10             	add    $0x10,%esp
801020eb:	5b                   	pop    %ebx
801020ec:	5e                   	pop    %esi
801020ed:	5f                   	pop    %edi
801020ee:	5d                   	pop    %ebp
801020ef:	c3                   	ret    

801020f0 <removeSwapFile>:
//remove swap file of proc p;
int
removeSwapFile(struct proc* p)
{
801020f0:	55                   	push   %ebp
801020f1:	89 e5                	mov    %esp,%ebp
801020f3:	57                   	push   %edi
801020f4:	56                   	push   %esi
801020f5:	53                   	push   %ebx
  //path of proccess
  char path[DIGITS];
  memmove(path,"/.swap", 6);
801020f6:	8d 75 bc             	lea    -0x44(%ebp),%esi
{
801020f9:	83 ec 40             	sub    $0x40,%esp
801020fc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
801020ff:	6a 06                	push   $0x6
80102101:	68 d5 85 10 80       	push   $0x801085d5
80102106:	56                   	push   %esi
80102107:	e8 14 2f 00 00       	call   80105020 <memmove>
  itoa(p->pid, path+ 6);
8010210c:	58                   	pop    %eax
8010210d:	8d 45 c2             	lea    -0x3e(%ebp),%eax
80102110:	5a                   	pop    %edx
80102111:	50                   	push   %eax
80102112:	ff 73 10             	pushl  0x10(%ebx)
80102115:	e8 46 ff ff ff       	call   80102060 <itoa>
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ];
  uint off;

  if(0 == p->swapFile)
8010211a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010211d:	83 c4 10             	add    $0x10,%esp
80102120:	85 c0                	test   %eax,%eax
80102122:	0f 84 88 01 00 00    	je     801022b0 <removeSwapFile+0x1c0>
  {
    return -1;
  }
  fileclose(p->swapFile);
80102128:	83 ec 0c             	sub    $0xc,%esp
  return namex(path, 1, name);
8010212b:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  fileclose(p->swapFile);
8010212e:	50                   	push   %eax
8010212f:	e8 4c ee ff ff       	call   80100f80 <fileclose>

  begin_op();
80102134:	e8 27 11 00 00       	call   80103260 <begin_op>
  return namex(path, 1, name);
80102139:	89 f0                	mov    %esi,%eax
8010213b:	89 d9                	mov    %ebx,%ecx
8010213d:	ba 01 00 00 00       	mov    $0x1,%edx
80102142:	e8 59 fc ff ff       	call   80101da0 <namex>
  if((dp = nameiparent(path, name)) == 0)
80102147:	83 c4 10             	add    $0x10,%esp
8010214a:	85 c0                	test   %eax,%eax
  return namex(path, 1, name);
8010214c:	89 c6                	mov    %eax,%esi
  if((dp = nameiparent(path, name)) == 0)
8010214e:	0f 84 66 01 00 00    	je     801022ba <removeSwapFile+0x1ca>
  {
    end_op();
    return -1;
  }

  ilock(dp);
80102154:	83 ec 0c             	sub    $0xc,%esp
80102157:	50                   	push   %eax
80102158:	e8 63 f6 ff ff       	call   801017c0 <ilock>
  return strncmp(s, t, DIRSIZ);
8010215d:	83 c4 0c             	add    $0xc,%esp
80102160:	6a 0e                	push   $0xe
80102162:	68 dd 85 10 80       	push   $0x801085dd
80102167:	53                   	push   %ebx
80102168:	e8 23 2f 00 00       	call   80105090 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010216d:	83 c4 10             	add    $0x10,%esp
80102170:	85 c0                	test   %eax,%eax
80102172:	0f 84 f8 00 00 00    	je     80102270 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
80102178:	83 ec 04             	sub    $0x4,%esp
8010217b:	6a 0e                	push   $0xe
8010217d:	68 dc 85 10 80       	push   $0x801085dc
80102182:	53                   	push   %ebx
80102183:	e8 08 2f 00 00       	call   80105090 <strncmp>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80102188:	83 c4 10             	add    $0x10,%esp
8010218b:	85 c0                	test   %eax,%eax
8010218d:	0f 84 dd 00 00 00    	je     80102270 <removeSwapFile+0x180>
     goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80102193:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102196:	83 ec 04             	sub    $0x4,%esp
80102199:	50                   	push   %eax
8010219a:	53                   	push   %ebx
8010219b:	56                   	push   %esi
8010219c:	e8 4f fb ff ff       	call   80101cf0 <dirlookup>
801021a1:	83 c4 10             	add    $0x10,%esp
801021a4:	85 c0                	test   %eax,%eax
801021a6:	89 c3                	mov    %eax,%ebx
801021a8:	0f 84 c2 00 00 00    	je     80102270 <removeSwapFile+0x180>
    goto bad;
  ilock(ip);
801021ae:	83 ec 0c             	sub    $0xc,%esp
801021b1:	50                   	push   %eax
801021b2:	e8 09 f6 ff ff       	call   801017c0 <ilock>

  if(ip->nlink < 1)
801021b7:	83 c4 10             	add    $0x10,%esp
801021ba:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801021bf:	0f 8e 11 01 00 00    	jle    801022d6 <removeSwapFile+0x1e6>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801021c5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021ca:	74 74                	je     80102240 <removeSwapFile+0x150>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801021cc:	8d 7d d8             	lea    -0x28(%ebp),%edi
801021cf:	83 ec 04             	sub    $0x4,%esp
801021d2:	6a 10                	push   $0x10
801021d4:	6a 00                	push   $0x0
801021d6:	57                   	push   %edi
801021d7:	e8 94 2d 00 00       	call   80104f70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021dc:	6a 10                	push   $0x10
801021de:	ff 75 b8             	pushl  -0x48(%ebp)
801021e1:	57                   	push   %edi
801021e2:	56                   	push   %esi
801021e3:	e8 b8 f9 ff ff       	call   80101ba0 <writei>
801021e8:	83 c4 20             	add    $0x20,%esp
801021eb:	83 f8 10             	cmp    $0x10,%eax
801021ee:	0f 85 d5 00 00 00    	jne    801022c9 <removeSwapFile+0x1d9>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801021f4:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021f9:	0f 84 91 00 00 00    	je     80102290 <removeSwapFile+0x1a0>
  iunlock(ip);
801021ff:	83 ec 0c             	sub    $0xc,%esp
80102202:	56                   	push   %esi
80102203:	e8 98 f6 ff ff       	call   801018a0 <iunlock>
  iput(ip);
80102208:	89 34 24             	mov    %esi,(%esp)
8010220b:	e8 e0 f6 ff ff       	call   801018f0 <iput>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
80102210:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80102215:	89 1c 24             	mov    %ebx,(%esp)
80102218:	e8 f3 f4 ff ff       	call   80101710 <iupdate>
  iunlock(ip);
8010221d:	89 1c 24             	mov    %ebx,(%esp)
80102220:	e8 7b f6 ff ff       	call   801018a0 <iunlock>
  iput(ip);
80102225:	89 1c 24             	mov    %ebx,(%esp)
80102228:	e8 c3 f6 ff ff       	call   801018f0 <iput>
  iunlockput(ip);

  end_op();
8010222d:	e8 9e 10 00 00       	call   801032d0 <end_op>

  return 0;
80102232:	83 c4 10             	add    $0x10,%esp
80102235:	31 c0                	xor    %eax,%eax
  bad:
    iunlockput(dp);
    end_op();
    return -1;

}
80102237:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010223a:	5b                   	pop    %ebx
8010223b:	5e                   	pop    %esi
8010223c:	5f                   	pop    %edi
8010223d:	5d                   	pop    %ebp
8010223e:	c3                   	ret    
8010223f:	90                   	nop
  if(ip->type == T_DIR && !isdirempty(ip)){
80102240:	83 ec 0c             	sub    $0xc,%esp
80102243:	53                   	push   %ebx
80102244:	e8 07 35 00 00       	call   80105750 <isdirempty>
80102249:	83 c4 10             	add    $0x10,%esp
8010224c:	85 c0                	test   %eax,%eax
8010224e:	0f 85 78 ff ff ff    	jne    801021cc <removeSwapFile+0xdc>
  iunlock(ip);
80102254:	83 ec 0c             	sub    $0xc,%esp
80102257:	53                   	push   %ebx
80102258:	e8 43 f6 ff ff       	call   801018a0 <iunlock>
  iput(ip);
8010225d:	89 1c 24             	mov    %ebx,(%esp)
80102260:	e8 8b f6 ff ff       	call   801018f0 <iput>
80102265:	83 c4 10             	add    $0x10,%esp
80102268:	90                   	nop
80102269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102270:	83 ec 0c             	sub    $0xc,%esp
80102273:	56                   	push   %esi
80102274:	e8 27 f6 ff ff       	call   801018a0 <iunlock>
  iput(ip);
80102279:	89 34 24             	mov    %esi,(%esp)
8010227c:	e8 6f f6 ff ff       	call   801018f0 <iput>
    end_op();
80102281:	e8 4a 10 00 00       	call   801032d0 <end_op>
    return -1;
80102286:	83 c4 10             	add    $0x10,%esp
80102289:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010228e:	eb a7                	jmp    80102237 <removeSwapFile+0x147>
    dp->nlink--;
80102290:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80102295:	83 ec 0c             	sub    $0xc,%esp
80102298:	56                   	push   %esi
80102299:	e8 72 f4 ff ff       	call   80101710 <iupdate>
8010229e:	83 c4 10             	add    $0x10,%esp
801022a1:	e9 59 ff ff ff       	jmp    801021ff <removeSwapFile+0x10f>
801022a6:	8d 76 00             	lea    0x0(%esi),%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801022b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022b5:	e9 7d ff ff ff       	jmp    80102237 <removeSwapFile+0x147>
    end_op();
801022ba:	e8 11 10 00 00       	call   801032d0 <end_op>
    return -1;
801022bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022c4:	e9 6e ff ff ff       	jmp    80102237 <removeSwapFile+0x147>
    panic("unlink: writei");
801022c9:	83 ec 0c             	sub    $0xc,%esp
801022cc:	68 f1 85 10 80       	push   $0x801085f1
801022d1:	e8 ba e0 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
801022d6:	83 ec 0c             	sub    $0xc,%esp
801022d9:	68 df 85 10 80       	push   $0x801085df
801022de:	e8 ad e0 ff ff       	call   80100390 <panic>
801022e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <createSwapFile>:


//return 0 on success
int
createSwapFile(struct proc* p)
{
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	56                   	push   %esi
801022f4:	53                   	push   %ebx

  char path[DIGITS];
  memmove(path,"/.swap", 6);
801022f5:	8d 75 ea             	lea    -0x16(%ebp),%esi
{
801022f8:	83 ec 14             	sub    $0x14,%esp
801022fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  memmove(path,"/.swap", 6);
801022fe:	6a 06                	push   $0x6
80102300:	68 d5 85 10 80       	push   $0x801085d5
80102305:	56                   	push   %esi
80102306:	e8 15 2d 00 00       	call   80105020 <memmove>
  itoa(p->pid, path+ 6);
8010230b:	58                   	pop    %eax
8010230c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010230f:	5a                   	pop    %edx
80102310:	50                   	push   %eax
80102311:	ff 73 10             	pushl  0x10(%ebx)
80102314:	e8 47 fd ff ff       	call   80102060 <itoa>

    begin_op();
80102319:	e8 42 0f 00 00       	call   80103260 <begin_op>
    struct inode * in = create(path, T_FILE, 0, 0);
8010231e:	6a 00                	push   $0x0
80102320:	6a 00                	push   $0x0
80102322:	6a 02                	push   $0x2
80102324:	56                   	push   %esi
80102325:	e8 36 36 00 00       	call   80105960 <create>
  iunlock(in);
8010232a:	83 c4 14             	add    $0x14,%esp
    struct inode * in = create(path, T_FILE, 0, 0);
8010232d:	89 c6                	mov    %eax,%esi
  iunlock(in);
8010232f:	50                   	push   %eax
80102330:	e8 6b f5 ff ff       	call   801018a0 <iunlock>

  p->swapFile = filealloc();
80102335:	e8 86 eb ff ff       	call   80100ec0 <filealloc>
  if (p->swapFile == 0)
8010233a:	83 c4 10             	add    $0x10,%esp
8010233d:	85 c0                	test   %eax,%eax
  p->swapFile = filealloc();
8010233f:	89 43 7c             	mov    %eax,0x7c(%ebx)
  if (p->swapFile == 0)
80102342:	74 32                	je     80102376 <createSwapFile+0x86>
    panic("no slot for files on /store");

  p->swapFile->ip = in;
80102344:	89 70 10             	mov    %esi,0x10(%eax)
  p->swapFile->type = FD_INODE;
80102347:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010234a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  p->swapFile->off = 0;
80102350:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102353:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  p->swapFile->readable = O_WRONLY;
8010235a:	8b 43 7c             	mov    0x7c(%ebx),%eax
8010235d:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  p->swapFile->writable = O_RDWR;
80102361:	8b 43 7c             	mov    0x7c(%ebx),%eax
80102364:	c6 40 09 02          	movb   $0x2,0x9(%eax)
    end_op();
80102368:	e8 63 0f 00 00       	call   801032d0 <end_op>

    return 0;
}
8010236d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102370:	31 c0                	xor    %eax,%eax
80102372:	5b                   	pop    %ebx
80102373:	5e                   	pop    %esi
80102374:	5d                   	pop    %ebp
80102375:	c3                   	ret    
    panic("no slot for files on /store");
80102376:	83 ec 0c             	sub    $0xc,%esp
80102379:	68 00 86 10 80       	push   $0x80108600
8010237e:	e8 0d e0 ff ff       	call   80100390 <panic>
80102383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102390 <writeToSwapFile>:

//return as sys_write (-1 when error)
int
writeToSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
80102396:	8b 4d 10             	mov    0x10(%ebp),%ecx
80102399:	8b 50 7c             	mov    0x7c(%eax),%edx
8010239c:	89 4a 14             	mov    %ecx,0x14(%edx)

  return filewrite(p->swapFile, buffer, size);
8010239f:	8b 55 14             	mov    0x14(%ebp),%edx
801023a2:	89 55 10             	mov    %edx,0x10(%ebp)
801023a5:	8b 40 7c             	mov    0x7c(%eax),%eax
801023a8:	89 45 08             	mov    %eax,0x8(%ebp)

}
801023ab:	5d                   	pop    %ebp
  return filewrite(p->swapFile, buffer, size);
801023ac:	e9 7f ed ff ff       	jmp    80101130 <filewrite>
801023b1:	eb 0d                	jmp    801023c0 <readFromSwapFile>
801023b3:	90                   	nop
801023b4:	90                   	nop
801023b5:	90                   	nop
801023b6:	90                   	nop
801023b7:	90                   	nop
801023b8:	90                   	nop
801023b9:	90                   	nop
801023ba:	90                   	nop
801023bb:	90                   	nop
801023bc:	90                   	nop
801023bd:	90                   	nop
801023be:	90                   	nop
801023bf:	90                   	nop

801023c0 <readFromSwapFile>:

//return as sys_read (-1 when error)
int
readFromSwapFile(struct proc * p, char* buffer, uint placeOnFile, uint size)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	8b 45 08             	mov    0x8(%ebp),%eax
  p->swapFile->off = placeOnFile;
801023c6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801023c9:	8b 50 7c             	mov    0x7c(%eax),%edx
801023cc:	89 4a 14             	mov    %ecx,0x14(%edx)

  return fileread(p->swapFile, buffer,  size);
801023cf:	8b 55 14             	mov    0x14(%ebp),%edx
801023d2:	89 55 10             	mov    %edx,0x10(%ebp)
801023d5:	8b 40 7c             	mov    0x7c(%eax),%eax
801023d8:	89 45 08             	mov    %eax,0x8(%ebp)
}
801023db:	5d                   	pop    %ebp
  return fileread(p->swapFile, buffer,  size);
801023dc:	e9 bf ec ff ff       	jmp    801010a0 <fileread>
801023e1:	66 90                	xchg   %ax,%ax
801023e3:	66 90                	xchg   %ax,%ax
801023e5:	66 90                	xchg   %ax,%ax
801023e7:	66 90                	xchg   %ax,%ax
801023e9:	66 90                	xchg   %ax,%ax
801023eb:	66 90                	xchg   %ax,%ax
801023ed:	66 90                	xchg   %ax,%ax
801023ef:	90                   	nop

801023f0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	57                   	push   %edi
801023f4:	56                   	push   %esi
801023f5:	53                   	push   %ebx
801023f6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801023f9:	85 c0                	test   %eax,%eax
801023fb:	0f 84 b4 00 00 00    	je     801024b5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102401:	8b 58 08             	mov    0x8(%eax),%ebx
80102404:	89 c6                	mov    %eax,%esi
80102406:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
8010240c:	0f 87 96 00 00 00    	ja     801024a8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102412:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102417:	89 f6                	mov    %esi,%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102420:	89 ca                	mov    %ecx,%edx
80102422:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102423:	83 e0 c0             	and    $0xffffffc0,%eax
80102426:	3c 40                	cmp    $0x40,%al
80102428:	75 f6                	jne    80102420 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010242a:	31 ff                	xor    %edi,%edi
8010242c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102431:	89 f8                	mov    %edi,%eax
80102433:	ee                   	out    %al,(%dx)
80102434:	b8 01 00 00 00       	mov    $0x1,%eax
80102439:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010243e:	ee                   	out    %al,(%dx)
8010243f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102444:	89 d8                	mov    %ebx,%eax
80102446:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102447:	89 d8                	mov    %ebx,%eax
80102449:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010244e:	c1 f8 08             	sar    $0x8,%eax
80102451:	ee                   	out    %al,(%dx)
80102452:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102457:	89 f8                	mov    %edi,%eax
80102459:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010245a:	0f b6 46 04          	movzbl 0x4(%esi),%eax
8010245e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102463:	c1 e0 04             	shl    $0x4,%eax
80102466:	83 e0 10             	and    $0x10,%eax
80102469:	83 c8 e0             	or     $0xffffffe0,%eax
8010246c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010246d:	f6 06 04             	testb  $0x4,(%esi)
80102470:	75 16                	jne    80102488 <idestart+0x98>
80102472:	b8 20 00 00 00       	mov    $0x20,%eax
80102477:	89 ca                	mov    %ecx,%edx
80102479:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010247a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010247d:	5b                   	pop    %ebx
8010247e:	5e                   	pop    %esi
8010247f:	5f                   	pop    %edi
80102480:	5d                   	pop    %ebp
80102481:	c3                   	ret    
80102482:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102488:	b8 30 00 00 00       	mov    $0x30,%eax
8010248d:	89 ca                	mov    %ecx,%edx
8010248f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102490:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102495:	83 c6 5c             	add    $0x5c,%esi
80102498:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010249d:	fc                   	cld    
8010249e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801024a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024a3:	5b                   	pop    %ebx
801024a4:	5e                   	pop    %esi
801024a5:	5f                   	pop    %edi
801024a6:	5d                   	pop    %ebp
801024a7:	c3                   	ret    
    panic("incorrect blockno");
801024a8:	83 ec 0c             	sub    $0xc,%esp
801024ab:	68 78 86 10 80       	push   $0x80108678
801024b0:	e8 db de ff ff       	call   80100390 <panic>
    panic("idestart");
801024b5:	83 ec 0c             	sub    $0xc,%esp
801024b8:	68 6f 86 10 80       	push   $0x8010866f
801024bd:	e8 ce de ff ff       	call   80100390 <panic>
801024c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024d0 <ideinit>:
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801024d6:	68 8a 86 10 80       	push   $0x8010868a
801024db:	68 80 c5 10 80       	push   $0x8010c580
801024e0:	e8 3b 28 00 00       	call   80104d20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801024e5:	58                   	pop    %eax
801024e6:	a1 20 cd 14 80       	mov    0x8014cd20,%eax
801024eb:	5a                   	pop    %edx
801024ec:	83 e8 01             	sub    $0x1,%eax
801024ef:	50                   	push   %eax
801024f0:	6a 0e                	push   $0xe
801024f2:	e8 a9 02 00 00       	call   801027a0 <ioapicenable>
801024f7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024fa:	ba f7 01 00 00       	mov    $0x1f7,%edx
801024ff:	90                   	nop
80102500:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102501:	83 e0 c0             	and    $0xffffffc0,%eax
80102504:	3c 40                	cmp    $0x40,%al
80102506:	75 f8                	jne    80102500 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102508:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010250d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102512:	ee                   	out    %al,(%dx)
80102513:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102518:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010251d:	eb 06                	jmp    80102525 <ideinit+0x55>
8010251f:	90                   	nop
  for(i=0; i<1000; i++){
80102520:	83 e9 01             	sub    $0x1,%ecx
80102523:	74 0f                	je     80102534 <ideinit+0x64>
80102525:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102526:	84 c0                	test   %al,%al
80102528:	74 f6                	je     80102520 <ideinit+0x50>
      havedisk1 = 1;
8010252a:	c7 05 60 c5 10 80 01 	movl   $0x1,0x8010c560
80102531:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102534:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102539:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010253e:	ee                   	out    %al,(%dx)
}
8010253f:	c9                   	leave  
80102540:	c3                   	ret    
80102541:	eb 0d                	jmp    80102550 <ideintr>
80102543:	90                   	nop
80102544:	90                   	nop
80102545:	90                   	nop
80102546:	90                   	nop
80102547:	90                   	nop
80102548:	90                   	nop
80102549:	90                   	nop
8010254a:	90                   	nop
8010254b:	90                   	nop
8010254c:	90                   	nop
8010254d:	90                   	nop
8010254e:	90                   	nop
8010254f:	90                   	nop

80102550 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	57                   	push   %edi
80102554:	56                   	push   %esi
80102555:	53                   	push   %ebx
80102556:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102559:	68 80 c5 10 80       	push   $0x8010c580
8010255e:	e8 fd 28 00 00       	call   80104e60 <acquire>

  if((b = idequeue) == 0){
80102563:	8b 1d 64 c5 10 80    	mov    0x8010c564,%ebx
80102569:	83 c4 10             	add    $0x10,%esp
8010256c:	85 db                	test   %ebx,%ebx
8010256e:	74 67                	je     801025d7 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102570:	8b 43 58             	mov    0x58(%ebx),%eax
80102573:	a3 64 c5 10 80       	mov    %eax,0x8010c564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102578:	8b 3b                	mov    (%ebx),%edi
8010257a:	f7 c7 04 00 00 00    	test   $0x4,%edi
80102580:	75 31                	jne    801025b3 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102582:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102587:	89 f6                	mov    %esi,%esi
80102589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80102590:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102591:	89 c6                	mov    %eax,%esi
80102593:	83 e6 c0             	and    $0xffffffc0,%esi
80102596:	89 f1                	mov    %esi,%ecx
80102598:	80 f9 40             	cmp    $0x40,%cl
8010259b:	75 f3                	jne    80102590 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010259d:	a8 21                	test   $0x21,%al
8010259f:	75 12                	jne    801025b3 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801025a1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801025a4:	b9 80 00 00 00       	mov    $0x80,%ecx
801025a9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025ae:	fc                   	cld    
801025af:	f3 6d                	rep insl (%dx),%es:(%edi)
801025b1:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801025b3:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
801025b6:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801025b9:	89 f9                	mov    %edi,%ecx
801025bb:	83 c9 02             	or     $0x2,%ecx
801025be:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801025c0:	53                   	push   %ebx
801025c1:	e8 5a 22 00 00       	call   80104820 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801025c6:	a1 64 c5 10 80       	mov    0x8010c564,%eax
801025cb:	83 c4 10             	add    $0x10,%esp
801025ce:	85 c0                	test   %eax,%eax
801025d0:	74 05                	je     801025d7 <ideintr+0x87>
    idestart(idequeue);
801025d2:	e8 19 fe ff ff       	call   801023f0 <idestart>
    release(&idelock);
801025d7:	83 ec 0c             	sub    $0xc,%esp
801025da:	68 80 c5 10 80       	push   $0x8010c580
801025df:	e8 3c 29 00 00       	call   80104f20 <release>

  release(&idelock);
}
801025e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025e7:	5b                   	pop    %ebx
801025e8:	5e                   	pop    %esi
801025e9:	5f                   	pop    %edi
801025ea:	5d                   	pop    %ebp
801025eb:	c3                   	ret    
801025ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025f0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801025f0:	55                   	push   %ebp
801025f1:	89 e5                	mov    %esp,%ebp
801025f3:	53                   	push   %ebx
801025f4:	83 ec 10             	sub    $0x10,%esp
801025f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801025fa:	8d 43 0c             	lea    0xc(%ebx),%eax
801025fd:	50                   	push   %eax
801025fe:	e8 cd 26 00 00       	call   80104cd0 <holdingsleep>
80102603:	83 c4 10             	add    $0x10,%esp
80102606:	85 c0                	test   %eax,%eax
80102608:	0f 84 c6 00 00 00    	je     801026d4 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010260e:	8b 03                	mov    (%ebx),%eax
80102610:	83 e0 06             	and    $0x6,%eax
80102613:	83 f8 02             	cmp    $0x2,%eax
80102616:	0f 84 ab 00 00 00    	je     801026c7 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010261c:	8b 53 04             	mov    0x4(%ebx),%edx
8010261f:	85 d2                	test   %edx,%edx
80102621:	74 0d                	je     80102630 <iderw+0x40>
80102623:	a1 60 c5 10 80       	mov    0x8010c560,%eax
80102628:	85 c0                	test   %eax,%eax
8010262a:	0f 84 b1 00 00 00    	je     801026e1 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102630:	83 ec 0c             	sub    $0xc,%esp
80102633:	68 80 c5 10 80       	push   $0x8010c580
80102638:	e8 23 28 00 00       	call   80104e60 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010263d:	8b 15 64 c5 10 80    	mov    0x8010c564,%edx
80102643:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102646:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010264d:	85 d2                	test   %edx,%edx
8010264f:	75 09                	jne    8010265a <iderw+0x6a>
80102651:	eb 6d                	jmp    801026c0 <iderw+0xd0>
80102653:	90                   	nop
80102654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102658:	89 c2                	mov    %eax,%edx
8010265a:	8b 42 58             	mov    0x58(%edx),%eax
8010265d:	85 c0                	test   %eax,%eax
8010265f:	75 f7                	jne    80102658 <iderw+0x68>
80102661:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102664:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102666:	39 1d 64 c5 10 80    	cmp    %ebx,0x8010c564
8010266c:	74 42                	je     801026b0 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010266e:	8b 03                	mov    (%ebx),%eax
80102670:	83 e0 06             	and    $0x6,%eax
80102673:	83 f8 02             	cmp    $0x2,%eax
80102676:	74 23                	je     8010269b <iderw+0xab>
80102678:	90                   	nop
80102679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102680:	83 ec 08             	sub    $0x8,%esp
80102683:	68 80 c5 10 80       	push   $0x8010c580
80102688:	53                   	push   %ebx
80102689:	e8 d2 1f 00 00       	call   80104660 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010268e:	8b 03                	mov    (%ebx),%eax
80102690:	83 c4 10             	add    $0x10,%esp
80102693:	83 e0 06             	and    $0x6,%eax
80102696:	83 f8 02             	cmp    $0x2,%eax
80102699:	75 e5                	jne    80102680 <iderw+0x90>
  }


  release(&idelock);
8010269b:	c7 45 08 80 c5 10 80 	movl   $0x8010c580,0x8(%ebp)
}
801026a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026a5:	c9                   	leave  
  release(&idelock);
801026a6:	e9 75 28 00 00       	jmp    80104f20 <release>
801026ab:	90                   	nop
801026ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
801026b0:	89 d8                	mov    %ebx,%eax
801026b2:	e8 39 fd ff ff       	call   801023f0 <idestart>
801026b7:	eb b5                	jmp    8010266e <iderw+0x7e>
801026b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026c0:	ba 64 c5 10 80       	mov    $0x8010c564,%edx
801026c5:	eb 9d                	jmp    80102664 <iderw+0x74>
    panic("iderw: nothing to do");
801026c7:	83 ec 0c             	sub    $0xc,%esp
801026ca:	68 a4 86 10 80       	push   $0x801086a4
801026cf:	e8 bc dc ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
801026d4:	83 ec 0c             	sub    $0xc,%esp
801026d7:	68 8e 86 10 80       	push   $0x8010868e
801026dc:	e8 af dc ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
801026e1:	83 ec 0c             	sub    $0xc,%esp
801026e4:	68 b9 86 10 80       	push   $0x801086b9
801026e9:	e8 a2 dc ff ff       	call   80100390 <panic>
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801026f0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801026f1:	c7 05 34 46 11 80 00 	movl   $0xfec00000,0x80114634
801026f8:	00 c0 fe 
{
801026fb:	89 e5                	mov    %esp,%ebp
801026fd:	56                   	push   %esi
801026fe:	53                   	push   %ebx
  ioapic->reg = reg;
801026ff:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102706:	00 00 00 
  return ioapic->data;
80102709:	a1 34 46 11 80       	mov    0x80114634,%eax
8010270e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102711:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102717:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010271d:	0f b6 15 80 c7 14 80 	movzbl 0x8014c780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102724:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102727:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010272a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010272d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102730:	39 c2                	cmp    %eax,%edx
80102732:	74 16                	je     8010274a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102734:	83 ec 0c             	sub    $0xc,%esp
80102737:	68 d8 86 10 80       	push   $0x801086d8
8010273c:	e8 1f df ff ff       	call   80100660 <cprintf>
80102741:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102747:	83 c4 10             	add    $0x10,%esp
8010274a:	83 c3 21             	add    $0x21,%ebx
{
8010274d:	ba 10 00 00 00       	mov    $0x10,%edx
80102752:	b8 20 00 00 00       	mov    $0x20,%eax
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
80102760:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80102762:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102768:	89 c6                	mov    %eax,%esi
8010276a:	81 ce 00 00 01 00    	or     $0x10000,%esi
80102770:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102773:	89 71 10             	mov    %esi,0x10(%ecx)
80102776:	8d 72 01             	lea    0x1(%edx),%esi
80102779:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
8010277c:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
8010277e:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
80102780:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
80102786:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010278d:	75 d1                	jne    80102760 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010278f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102792:	5b                   	pop    %ebx
80102793:	5e                   	pop    %esi
80102794:	5d                   	pop    %ebp
80102795:	c3                   	ret    
80102796:	8d 76 00             	lea    0x0(%esi),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801027a0:	55                   	push   %ebp
  ioapic->reg = reg;
801027a1:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
{
801027a7:	89 e5                	mov    %esp,%ebp
801027a9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801027ac:	8d 50 20             	lea    0x20(%eax),%edx
801027af:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801027b3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027b5:	8b 0d 34 46 11 80    	mov    0x80114634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027bb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801027be:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027c1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801027c4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801027c6:	a1 34 46 11 80       	mov    0x80114634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801027cb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801027ce:	89 50 10             	mov    %edx,0x10(%eax)
}
801027d1:	5d                   	pop    %ebp
801027d2:	c3                   	ret    
801027d3:	66 90                	xchg   %ax,%ax
801027d5:	66 90                	xchg   %ax,%ax
801027d7:	66 90                	xchg   %ax,%ax
801027d9:	66 90                	xchg   %ax,%ax
801027db:	66 90                	xchg   %ax,%ax
801027dd:	66 90                	xchg   %ax,%ax
801027df:	90                   	nop

801027e0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801027e0:	55                   	push   %ebp
801027e1:	89 e5                	mov    %esp,%ebp
801027e3:	56                   	push   %esi
801027e4:	53                   	push   %ebx
801027e5:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801027e8:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
801027ee:	0f 85 b9 00 00 00    	jne    801028ad <kfree+0xcd>
801027f4:	81 fe c8 ab 15 80    	cmp    $0x8015abc8,%esi
801027fa:	0f 82 ad 00 00 00    	jb     801028ad <kfree+0xcd>
80102800:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102806:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010280c:	0f 87 9b 00 00 00    	ja     801028ad <kfree+0xcd>
    panic("kfree1");

  if(kmem.use_lock)
80102812:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102818:	85 d2                	test   %edx,%edx
8010281a:	75 7c                	jne    80102898 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;

  if(kmem.pg_refcount[index(V2P(v))] > 0){
8010281c:	c1 eb 0c             	shr    $0xc,%ebx
8010281f:	83 c3 10             	add    $0x10,%ebx
80102822:	8b 04 9d 40 46 11 80 	mov    -0x7feeb9c0(,%ebx,4),%eax
80102829:	85 c0                	test   %eax,%eax
8010282b:	75 3b                	jne    80102868 <kfree+0x88>
    --kmem.pg_refcount[index(V2P(v))];
  }
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
    // Fill with junk to catch dangling refs.
    memset(v, 1, PGSIZE);
8010282d:	83 ec 04             	sub    $0x4,%esp
80102830:	68 00 10 00 00       	push   $0x1000
80102835:	6a 01                	push   $0x1
80102837:	56                   	push   %esi
80102838:	e8 33 27 00 00       	call   80104f70 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
8010283d:	a1 78 46 11 80       	mov    0x80114678,%eax
    kmem.free_pages++;
80102842:	83 05 7c 46 11 80 01 	addl   $0x1,0x8011467c
    kmem.freelist = r;
80102849:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
8010284c:	89 06                	mov    %eax,(%esi)
  }

  if(kmem.use_lock)
8010284e:	a1 74 46 11 80       	mov    0x80114674,%eax
    kmem.freelist = r;
80102853:	89 35 78 46 11 80    	mov    %esi,0x80114678
  if(kmem.use_lock)
80102859:	85 c0                	test   %eax,%eax
8010285b:	75 22                	jne    8010287f <kfree+0x9f>
    release(&kmem.lock);
}
8010285d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102860:	5b                   	pop    %ebx
80102861:	5e                   	pop    %esi
80102862:	5d                   	pop    %ebp
80102863:	c3                   	ret    
80102864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    --kmem.pg_refcount[index(V2P(v))];
80102868:	83 e8 01             	sub    $0x1,%eax
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
8010286b:	85 c0                	test   %eax,%eax
    --kmem.pg_refcount[index(V2P(v))];
8010286d:	89 04 9d 40 46 11 80 	mov    %eax,-0x7feeb9c0(,%ebx,4)
  if(kmem.pg_refcount[index(V2P(v))] <= 0){
80102874:	74 b7                	je     8010282d <kfree+0x4d>
  if(kmem.use_lock)
80102876:	a1 74 46 11 80       	mov    0x80114674,%eax
8010287b:	85 c0                	test   %eax,%eax
8010287d:	74 de                	je     8010285d <kfree+0x7d>
    release(&kmem.lock);
8010287f:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102886:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102889:	5b                   	pop    %ebx
8010288a:	5e                   	pop    %esi
8010288b:	5d                   	pop    %ebp
    release(&kmem.lock);
8010288c:	e9 8f 26 00 00       	jmp    80104f20 <release>
80102891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
80102898:	83 ec 0c             	sub    $0xc,%esp
8010289b:	68 40 46 11 80       	push   $0x80114640
801028a0:	e8 bb 25 00 00       	call   80104e60 <acquire>
801028a5:	83 c4 10             	add    $0x10,%esp
801028a8:	e9 6f ff ff ff       	jmp    8010281c <kfree+0x3c>
    panic("kfree1");
801028ad:	83 ec 0c             	sub    $0xc,%esp
801028b0:	68 0a 87 10 80       	push   $0x8010870a
801028b5:	e8 d6 da ff ff       	call   80100390 <panic>
801028ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028c0 <freerange>:
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	56                   	push   %esi
801028c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801028cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028dd:	39 de                	cmp    %ebx,%esi
801028df:	72 23                	jb     80102904 <freerange+0x44>
801028e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801028e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801028ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028f7:	50                   	push   %eax
801028f8:	e8 e3 fe ff ff       	call   801027e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801028fd:	83 c4 10             	add    $0x10,%esp
80102900:	39 f3                	cmp    %esi,%ebx
80102902:	76 e4                	jbe    801028e8 <freerange+0x28>
}
80102904:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102907:	5b                   	pop    %ebx
80102908:	5e                   	pop    %esi
80102909:	5d                   	pop    %ebp
8010290a:	c3                   	ret    
8010290b:	90                   	nop
8010290c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102910 <kinit1>:
{
80102910:	55                   	push   %ebp
80102911:	89 e5                	mov    %esp,%ebp
80102913:	56                   	push   %esi
80102914:	53                   	push   %ebx
80102915:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102918:	83 ec 08             	sub    $0x8,%esp
8010291b:	68 11 87 10 80       	push   $0x80108711
80102920:	68 40 46 11 80       	push   $0x80114640
80102925:	e8 f6 23 00 00       	call   80104d20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010292a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010292d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102930:	c7 05 74 46 11 80 00 	movl   $0x0,0x80114674
80102937:	00 00 00 
  kmem.free_pages = 0;
8010293a:	c7 05 7c 46 11 80 00 	movl   $0x0,0x8011467c
80102941:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102944:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
8010294a:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102950:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102956:	39 de                	cmp    %ebx,%esi
80102958:	72 22                	jb     8010297c <kinit1+0x6c>
8010295a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kfree(p);
80102960:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102966:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102969:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010296f:	50                   	push   %eax
80102970:	e8 6b fe ff ff       	call   801027e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
80102975:	83 c4 10             	add    $0x10,%esp
80102978:	39 de                	cmp    %ebx,%esi
8010297a:	73 e4                	jae    80102960 <kinit1+0x50>
}
8010297c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010297f:	5b                   	pop    %ebx
80102980:	5e                   	pop    %esi
80102981:	5d                   	pop    %ebp
80102982:	c3                   	ret    
80102983:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102990 <kinit2>:
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
801029af:	72 23                	jb     801029d4 <kinit2+0x44>
801029b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801029b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801029be:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801029c7:	50                   	push   %eax
801029c8:	e8 13 fe ff ff       	call   801027e0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
801029cd:	83 c4 10             	add    $0x10,%esp
801029d0:	39 de                	cmp    %ebx,%esi
801029d2:	73 e4                	jae    801029b8 <kinit2+0x28>
  kmem.use_lock = 1;
801029d4:	c7 05 74 46 11 80 01 	movl   $0x1,0x80114674
801029db:	00 00 00 
}
801029de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029e1:	5b                   	pop    %ebx
801029e2:	5e                   	pop    %esi
801029e3:	5d                   	pop    %ebp
801029e4:	c3                   	ret    
801029e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801029f0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801029f0:	55                   	push   %ebp
801029f1:	89 e5                	mov    %esp,%ebp
801029f3:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
801029f6:	8b 15 74 46 11 80    	mov    0x80114674,%edx
801029fc:	85 d2                	test   %edx,%edx
801029fe:	75 50                	jne    80102a50 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102a00:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102a05:	85 c0                	test   %eax,%eax
80102a07:	74 27                	je     80102a30 <kalloc+0x40>
    kmem.freelist = r->next;
80102a09:	8b 08                	mov    (%eax),%ecx
    kmem.free_pages--;
80102a0b:	83 2d 7c 46 11 80 01 	subl   $0x1,0x8011467c
    kmem.freelist = r->next;
80102a12:	89 0d 78 46 11 80    	mov    %ecx,0x80114678
    kmem.pg_refcount[index(V2P((char*)r))] = 1;
80102a18:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80102a1e:	c1 e9 0c             	shr    $0xc,%ecx
80102a21:	c7 04 8d 80 46 11 80 	movl   $0x1,-0x7feeb980(,%ecx,4)
80102a28:	01 00 00 00 
  }

  if(kmem.use_lock)
80102a2c:	85 d2                	test   %edx,%edx
80102a2e:	75 08                	jne    80102a38 <kalloc+0x48>
    release(&kmem.lock);
  return (char*)r;
}
80102a30:	c9                   	leave  
80102a31:	c3                   	ret    
80102a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102a38:	83 ec 0c             	sub    $0xc,%esp
80102a3b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a3e:	68 40 46 11 80       	push   $0x80114640
80102a43:	e8 d8 24 00 00       	call   80104f20 <release>
  return (char*)r;
80102a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102a4b:	83 c4 10             	add    $0x10,%esp
}
80102a4e:	c9                   	leave  
80102a4f:	c3                   	ret    
    acquire(&kmem.lock);
80102a50:	83 ec 0c             	sub    $0xc,%esp
80102a53:	68 40 46 11 80       	push   $0x80114640
80102a58:	e8 03 24 00 00       	call   80104e60 <acquire>
  r = kmem.freelist;
80102a5d:	a1 78 46 11 80       	mov    0x80114678,%eax
  if(r){
80102a62:	83 c4 10             	add    $0x10,%esp
80102a65:	8b 15 74 46 11 80    	mov    0x80114674,%edx
80102a6b:	85 c0                	test   %eax,%eax
80102a6d:	75 9a                	jne    80102a09 <kalloc+0x19>
80102a6f:	eb bb                	jmp    80102a2c <kalloc+0x3c>
80102a71:	eb 0d                	jmp    80102a80 <numFreePages>
80102a73:	90                   	nop
80102a74:	90                   	nop
80102a75:	90                   	nop
80102a76:	90                   	nop
80102a77:	90                   	nop
80102a78:	90                   	nop
80102a79:	90                   	nop
80102a7a:	90                   	nop
80102a7b:	90                   	nop
80102a7c:	90                   	nop
80102a7d:	90                   	nop
80102a7e:	90                   	nop
80102a7f:	90                   	nop

80102a80 <numFreePages>:

uint numFreePages(){
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	53                   	push   %ebx
80102a84:	83 ec 10             	sub    $0x10,%esp
  acquire(&kmem.lock);
80102a87:	68 40 46 11 80       	push   $0x80114640
80102a8c:	e8 cf 23 00 00       	call   80104e60 <acquire>
  uint free_pages = kmem.free_pages;
80102a91:	8b 1d 7c 46 11 80    	mov    0x8011467c,%ebx
  release(&kmem.lock);
80102a97:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102a9e:	e8 7d 24 00 00       	call   80104f20 <release>
  return free_pages;
}
80102aa3:	89 d8                	mov    %ebx,%eax
80102aa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102aa8:	c9                   	leave  
80102aa9:	c3                   	ret    
80102aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ab0 <resetRefCounter>:

void resetRefCounter(uint pa){
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
  kmem.pg_refcount[index(pa)] = 1;
80102ab3:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102ab6:	5d                   	pop    %ebp
  kmem.pg_refcount[index(pa)] = 1;
80102ab7:	c1 e8 0c             	shr    $0xc,%eax
80102aba:	c7 04 85 80 46 11 80 	movl   $0x1,-0x7feeb980(,%eax,4)
80102ac1:	01 00 00 00 
}
80102ac5:	c3                   	ret    
80102ac6:	8d 76 00             	lea    0x0(%esi),%esi
80102ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ad0 <decrementReferenceCount>:

void decrementReferenceCount(uint pa)
{
80102ad0:	55                   	push   %ebp
80102ad1:	89 e5                	mov    %esp,%ebp
80102ad3:	53                   	push   %ebx
80102ad4:	83 ec 04             	sub    $0x4,%esp
80102ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("3");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102ada:	81 fb c8 ab 15 00    	cmp    $0x15abc8,%ebx
80102ae0:	72 33                	jb     80102b15 <decrementReferenceCount+0x45>
80102ae2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102ae8:	77 2b                	ja     80102b15 <decrementReferenceCount+0x45>
    panic("decrementReferenceCount");

  acquire(&kmem.lock);
80102aea:	83 ec 0c             	sub    $0xc,%esp
  --kmem.pg_refcount[index(pa)];
80102aed:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102af0:	68 40 46 11 80       	push   $0x80114640
80102af5:	e8 66 23 00 00       	call   80104e60 <acquire>
  --kmem.pg_refcount[index(pa)];
80102afa:	83 2c 9d 80 46 11 80 	subl   $0x1,-0x7feeb980(,%ebx,4)
80102b01:	01 
  release(&kmem.lock);
80102b02:	83 c4 10             	add    $0x10,%esp
80102b05:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)

}
80102b0c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b0f:	c9                   	leave  
  release(&kmem.lock);
80102b10:	e9 0b 24 00 00       	jmp    80104f20 <release>
    panic("decrementReferenceCount");
80102b15:	83 ec 0c             	sub    $0xc,%esp
80102b18:	68 16 87 10 80       	push   $0x80108716
80102b1d:	e8 6e d8 ff ff       	call   80100390 <panic>
80102b22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <incrementReferenceCount>:

void incrementReferenceCount(uint pa)
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 04             	sub    $0x4,%esp
80102b37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("2");
  // }
  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102b3a:	81 fb c8 ab 15 00    	cmp    $0x15abc8,%ebx
80102b40:	72 33                	jb     80102b75 <incrementReferenceCount+0x45>
80102b42:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102b48:	77 2b                	ja     80102b75 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102b4a:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[index(pa)];
80102b4d:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102b50:	68 40 46 11 80       	push   $0x80114640
80102b55:	e8 06 23 00 00       	call   80104e60 <acquire>
  ++kmem.pg_refcount[index(pa)];
80102b5a:	83 04 9d 80 46 11 80 	addl   $0x1,-0x7feeb980(,%ebx,4)
80102b61:	01 
  release(&kmem.lock);
80102b62:	83 c4 10             	add    $0x10,%esp
80102b65:	c7 45 08 40 46 11 80 	movl   $0x80114640,0x8(%ebp)
}
80102b6c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b6f:	c9                   	leave  
  release(&kmem.lock);
80102b70:	e9 ab 23 00 00       	jmp    80104f20 <release>
    panic("incrementReferenceCount");
80102b75:	83 ec 0c             	sub    $0xc,%esp
80102b78:	68 2e 87 10 80       	push   $0x8010872e
80102b7d:	e8 0e d8 ff ff       	call   80100390 <panic>
80102b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b90 <getReferenceCount>:

uint getReferenceCount(uint pa)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	53                   	push   %ebx
80102b94:	83 ec 04             	sub    $0x4,%esp
80102b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // if(pa > PHYSTOP/PGSIZE){
  //     cprintf("pa: %d, res: %d\n",pa, PHYSTOP/PGSIZE);
  //   panic("1");
  // }

  if(pa < (uint)V2P(end) || pa >= PHYSTOP)
80102b9a:	81 fb c8 ab 15 00    	cmp    $0x15abc8,%ebx
80102ba0:	72 32                	jb     80102bd4 <getReferenceCount+0x44>
80102ba2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102ba8:	77 2a                	ja     80102bd4 <getReferenceCount+0x44>
    panic("getReferenceCount");
  uint count;

  acquire(&kmem.lock);
80102baa:	83 ec 0c             	sub    $0xc,%esp
  count = kmem.pg_refcount[index(pa)];
80102bad:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102bb0:	68 40 46 11 80       	push   $0x80114640
80102bb5:	e8 a6 22 00 00       	call   80104e60 <acquire>
  count = kmem.pg_refcount[index(pa)];
80102bba:	8b 1c 9d 80 46 11 80 	mov    -0x7feeb980(,%ebx,4),%ebx
  release(&kmem.lock);
80102bc1:	c7 04 24 40 46 11 80 	movl   $0x80114640,(%esp)
80102bc8:	e8 53 23 00 00       	call   80104f20 <release>

  return count;
}
80102bcd:	89 d8                	mov    %ebx,%eax
80102bcf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bd2:	c9                   	leave  
80102bd3:	c3                   	ret    
    panic("getReferenceCount");
80102bd4:	83 ec 0c             	sub    $0xc,%esp
80102bd7:	68 46 87 10 80       	push   $0x80108746
80102bdc:	e8 af d7 ff ff       	call   80100390 <panic>
80102be1:	66 90                	xchg   %ax,%ax
80102be3:	66 90                	xchg   %ax,%ax
80102be5:	66 90                	xchg   %ax,%ax
80102be7:	66 90                	xchg   %ax,%ax
80102be9:	66 90                	xchg   %ax,%ax
80102beb:	66 90                	xchg   %ax,%ax
80102bed:	66 90                	xchg   %ax,%ax
80102bef:	90                   	nop

80102bf0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bf0:	ba 64 00 00 00       	mov    $0x64,%edx
80102bf5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102bf6:	a8 01                	test   $0x1,%al
80102bf8:	0f 84 c2 00 00 00    	je     80102cc0 <kbdgetc+0xd0>
80102bfe:	ba 60 00 00 00       	mov    $0x60,%edx
80102c03:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102c04:	0f b6 d0             	movzbl %al,%edx
80102c07:	8b 0d b4 c5 10 80    	mov    0x8010c5b4,%ecx

  if(data == 0xE0){
80102c0d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102c13:	0f 84 7f 00 00 00    	je     80102c98 <kbdgetc+0xa8>
{
80102c19:	55                   	push   %ebp
80102c1a:	89 e5                	mov    %esp,%ebp
80102c1c:	53                   	push   %ebx
80102c1d:	89 cb                	mov    %ecx,%ebx
80102c1f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102c22:	84 c0                	test   %al,%al
80102c24:	78 4a                	js     80102c70 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102c26:	85 db                	test   %ebx,%ebx
80102c28:	74 09                	je     80102c33 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c2a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102c2d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102c30:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102c33:	0f b6 82 80 88 10 80 	movzbl -0x7fef7780(%edx),%eax
80102c3a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102c3c:	0f b6 82 80 87 10 80 	movzbl -0x7fef7880(%edx),%eax
80102c43:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c45:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102c47:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102c4d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c50:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c53:	8b 04 85 60 87 10 80 	mov    -0x7fef78a0(,%eax,4),%eax
80102c5a:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102c5e:	74 31                	je     80102c91 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
80102c60:	8d 50 9f             	lea    -0x61(%eax),%edx
80102c63:	83 fa 19             	cmp    $0x19,%edx
80102c66:	77 40                	ja     80102ca8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c68:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c6b:	5b                   	pop    %ebx
80102c6c:	5d                   	pop    %ebp
80102c6d:	c3                   	ret    
80102c6e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102c70:	83 e0 7f             	and    $0x7f,%eax
80102c73:	85 db                	test   %ebx,%ebx
80102c75:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102c78:	0f b6 82 80 88 10 80 	movzbl -0x7fef7780(%edx),%eax
80102c7f:	83 c8 40             	or     $0x40,%eax
80102c82:	0f b6 c0             	movzbl %al,%eax
80102c85:	f7 d0                	not    %eax
80102c87:	21 c1                	and    %eax,%ecx
    return 0;
80102c89:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102c8b:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
}
80102c91:	5b                   	pop    %ebx
80102c92:	5d                   	pop    %ebp
80102c93:	c3                   	ret    
80102c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80102c98:	83 c9 40             	or     $0x40,%ecx
    return 0;
80102c9b:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c9d:	89 0d b4 c5 10 80    	mov    %ecx,0x8010c5b4
    return 0;
80102ca3:	c3                   	ret    
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102ca8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102cab:	8d 50 20             	lea    0x20(%eax),%edx
}
80102cae:	5b                   	pop    %ebx
      c += 'a' - 'A';
80102caf:	83 f9 1a             	cmp    $0x1a,%ecx
80102cb2:	0f 42 c2             	cmovb  %edx,%eax
}
80102cb5:	5d                   	pop    %ebp
80102cb6:	c3                   	ret    
80102cb7:	89 f6                	mov    %esi,%esi
80102cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102cc5:	c3                   	ret    
80102cc6:	8d 76 00             	lea    0x0(%esi),%esi
80102cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cd0 <kbdintr>:

void
kbdintr(void)
{
80102cd0:	55                   	push   %ebp
80102cd1:	89 e5                	mov    %esp,%ebp
80102cd3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102cd6:	68 f0 2b 10 80       	push   $0x80102bf0
80102cdb:	e8 30 db ff ff       	call   80100810 <consoleintr>
}
80102ce0:	83 c4 10             	add    $0x10,%esp
80102ce3:	c9                   	leave  
80102ce4:	c3                   	ret    
80102ce5:	66 90                	xchg   %ax,%ax
80102ce7:	66 90                	xchg   %ax,%ax
80102ce9:	66 90                	xchg   %ax,%ax
80102ceb:	66 90                	xchg   %ax,%ax
80102ced:	66 90                	xchg   %ax,%ax
80102cef:	90                   	nop

80102cf0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102cf0:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102cf5:	55                   	push   %ebp
80102cf6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102cf8:	85 c0                	test   %eax,%eax
80102cfa:	0f 84 c8 00 00 00    	je     80102dc8 <lapicinit+0xd8>
  lapic[index] = value;
80102d00:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102d07:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d0a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d0d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102d14:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d17:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d1a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102d21:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102d24:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d27:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102d2e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102d31:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d34:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d3b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d3e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d41:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d48:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d4b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d4e:	8b 50 30             	mov    0x30(%eax),%edx
80102d51:	c1 ea 10             	shr    $0x10,%edx
80102d54:	80 fa 03             	cmp    $0x3,%dl
80102d57:	77 77                	ja     80102dd0 <lapicinit+0xe0>
  lapic[index] = value;
80102d59:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d60:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d63:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d66:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d6d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d70:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d73:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d7a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d7d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d80:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d87:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d8a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d8d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d94:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d97:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d9a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102da1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102da4:	8b 50 20             	mov    0x20(%eax),%edx
80102da7:	89 f6                	mov    %esi,%esi
80102da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102db0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102db6:	80 e6 10             	and    $0x10,%dh
80102db9:	75 f5                	jne    80102db0 <lapicinit+0xc0>
  lapic[index] = value;
80102dbb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102dc2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102dc5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102dc8:	5d                   	pop    %ebp
80102dc9:	c3                   	ret    
80102dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102dd0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102dd7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102dda:	8b 50 20             	mov    0x20(%eax),%edx
80102ddd:	e9 77 ff ff ff       	jmp    80102d59 <lapicinit+0x69>
80102de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102df0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102df0:	8b 15 80 c6 14 80    	mov    0x8014c680,%edx
{
80102df6:	55                   	push   %ebp
80102df7:	31 c0                	xor    %eax,%eax
80102df9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102dfb:	85 d2                	test   %edx,%edx
80102dfd:	74 06                	je     80102e05 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
80102dff:	8b 42 20             	mov    0x20(%edx),%eax
80102e02:	c1 e8 18             	shr    $0x18,%eax
}
80102e05:	5d                   	pop    %ebp
80102e06:	c3                   	ret    
80102e07:	89 f6                	mov    %esi,%esi
80102e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e10 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102e10:	a1 80 c6 14 80       	mov    0x8014c680,%eax
{
80102e15:	55                   	push   %ebp
80102e16:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102e18:	85 c0                	test   %eax,%eax
80102e1a:	74 0d                	je     80102e29 <lapiceoi+0x19>
  lapic[index] = value;
80102e1c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e23:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e26:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102e29:	5d                   	pop    %ebp
80102e2a:	c3                   	ret    
80102e2b:	90                   	nop
80102e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102e30 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
}
80102e33:	5d                   	pop    %ebp
80102e34:	c3                   	ret    
80102e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102e40 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e40:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e41:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e46:	ba 70 00 00 00       	mov    $0x70,%edx
80102e4b:	89 e5                	mov    %esp,%ebp
80102e4d:	53                   	push   %ebx
80102e4e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e51:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e54:	ee                   	out    %al,(%dx)
80102e55:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e5a:	ba 71 00 00 00       	mov    $0x71,%edx
80102e5f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e60:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102e62:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e65:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e6b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e6d:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
80102e70:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
80102e73:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e75:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e78:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102e7e:	a1 80 c6 14 80       	mov    0x8014c680,%eax
80102e83:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e89:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e8c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e93:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e96:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e99:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102ea0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ea3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ea6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102eaf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eb5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102eb8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ebe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ec1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ec7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102eca:	5b                   	pop    %ebx
80102ecb:	5d                   	pop    %ebp
80102ecc:	c3                   	ret    
80102ecd:	8d 76 00             	lea    0x0(%esi),%esi

80102ed0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102ed0:	55                   	push   %ebp
80102ed1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102ed6:	ba 70 00 00 00       	mov    $0x70,%edx
80102edb:	89 e5                	mov    %esp,%ebp
80102edd:	57                   	push   %edi
80102ede:	56                   	push   %esi
80102edf:	53                   	push   %ebx
80102ee0:	83 ec 4c             	sub    $0x4c,%esp
80102ee3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ee9:	ec                   	in     (%dx),%al
80102eea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eed:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ef2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ef5:	8d 76 00             	lea    0x0(%esi),%esi
80102ef8:	31 c0                	xor    %eax,%eax
80102efa:	89 da                	mov    %ebx,%edx
80102efc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102efd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102f02:	89 ca                	mov    %ecx,%edx
80102f04:	ec                   	in     (%dx),%al
80102f05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f08:	89 da                	mov    %ebx,%edx
80102f0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102f0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f10:	89 ca                	mov    %ecx,%edx
80102f12:	ec                   	in     (%dx),%al
80102f13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f16:	89 da                	mov    %ebx,%edx
80102f18:	b8 04 00 00 00       	mov    $0x4,%eax
80102f1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f1e:	89 ca                	mov    %ecx,%edx
80102f20:	ec                   	in     (%dx),%al
80102f21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f24:	89 da                	mov    %ebx,%edx
80102f26:	b8 07 00 00 00       	mov    $0x7,%eax
80102f2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f2c:	89 ca                	mov    %ecx,%edx
80102f2e:	ec                   	in     (%dx),%al
80102f2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f32:	89 da                	mov    %ebx,%edx
80102f34:	b8 08 00 00 00       	mov    $0x8,%eax
80102f39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f3a:	89 ca                	mov    %ecx,%edx
80102f3c:	ec                   	in     (%dx),%al
80102f3d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f3f:	89 da                	mov    %ebx,%edx
80102f41:	b8 09 00 00 00       	mov    $0x9,%eax
80102f46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f47:	89 ca                	mov    %ecx,%edx
80102f49:	ec                   	in     (%dx),%al
80102f4a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f4c:	89 da                	mov    %ebx,%edx
80102f4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f54:	89 ca                	mov    %ecx,%edx
80102f56:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f57:	84 c0                	test   %al,%al
80102f59:	78 9d                	js     80102ef8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102f5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f5f:	89 fa                	mov    %edi,%edx
80102f61:	0f b6 fa             	movzbl %dl,%edi
80102f64:	89 f2                	mov    %esi,%edx
80102f66:	0f b6 f2             	movzbl %dl,%esi
80102f69:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6c:	89 da                	mov    %ebx,%edx
80102f6e:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102f71:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f74:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f78:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102f7b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102f7f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102f82:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102f86:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102f89:	31 c0                	xor    %eax,%eax
80102f8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f8c:	89 ca                	mov    %ecx,%edx
80102f8e:	ec                   	in     (%dx),%al
80102f8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f92:	89 da                	mov    %ebx,%edx
80102f94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f97:	b8 02 00 00 00       	mov    $0x2,%eax
80102f9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f9d:	89 ca                	mov    %ecx,%edx
80102f9f:	ec                   	in     (%dx),%al
80102fa0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fa3:	89 da                	mov    %ebx,%edx
80102fa5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102fa8:	b8 04 00 00 00       	mov    $0x4,%eax
80102fad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fae:	89 ca                	mov    %ecx,%edx
80102fb0:	ec                   	in     (%dx),%al
80102fb1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fb4:	89 da                	mov    %ebx,%edx
80102fb6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102fb9:	b8 07 00 00 00       	mov    $0x7,%eax
80102fbe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fbf:	89 ca                	mov    %ecx,%edx
80102fc1:	ec                   	in     (%dx),%al
80102fc2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fc5:	89 da                	mov    %ebx,%edx
80102fc7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102fca:	b8 08 00 00 00       	mov    $0x8,%eax
80102fcf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd0:	89 ca                	mov    %ecx,%edx
80102fd2:	ec                   	in     (%dx),%al
80102fd3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fd6:	89 da                	mov    %ebx,%edx
80102fd8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102fdb:	b8 09 00 00 00       	mov    $0x9,%eax
80102fe0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fe1:	89 ca                	mov    %ecx,%edx
80102fe3:	ec                   	in     (%dx),%al
80102fe4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102fe7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102fea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102fed:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ff0:	6a 18                	push   $0x18
80102ff2:	50                   	push   %eax
80102ff3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ff6:	50                   	push   %eax
80102ff7:	e8 c4 1f 00 00       	call   80104fc0 <memcmp>
80102ffc:	83 c4 10             	add    $0x10,%esp
80102fff:	85 c0                	test   %eax,%eax
80103001:	0f 85 f1 fe ff ff    	jne    80102ef8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103007:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010300b:	75 78                	jne    80103085 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010300d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103010:	89 c2                	mov    %eax,%edx
80103012:	83 e0 0f             	and    $0xf,%eax
80103015:	c1 ea 04             	shr    $0x4,%edx
80103018:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010301b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010301e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103021:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103024:	89 c2                	mov    %eax,%edx
80103026:	83 e0 0f             	and    $0xf,%eax
80103029:	c1 ea 04             	shr    $0x4,%edx
8010302c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010302f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103032:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103035:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103038:	89 c2                	mov    %eax,%edx
8010303a:	83 e0 0f             	and    $0xf,%eax
8010303d:	c1 ea 04             	shr    $0x4,%edx
80103040:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103043:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103046:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103049:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010304c:	89 c2                	mov    %eax,%edx
8010304e:	83 e0 0f             	and    $0xf,%eax
80103051:	c1 ea 04             	shr    $0x4,%edx
80103054:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103057:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010305a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010305d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103060:	89 c2                	mov    %eax,%edx
80103062:	83 e0 0f             	and    $0xf,%eax
80103065:	c1 ea 04             	shr    $0x4,%edx
80103068:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010306b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010306e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103071:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103074:	89 c2                	mov    %eax,%edx
80103076:	83 e0 0f             	and    $0xf,%eax
80103079:	c1 ea 04             	shr    $0x4,%edx
8010307c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010307f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103082:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103085:	8b 75 08             	mov    0x8(%ebp),%esi
80103088:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010308b:	89 06                	mov    %eax,(%esi)
8010308d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103090:	89 46 04             	mov    %eax,0x4(%esi)
80103093:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103096:	89 46 08             	mov    %eax,0x8(%esi)
80103099:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010309c:	89 46 0c             	mov    %eax,0xc(%esi)
8010309f:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030a2:	89 46 10             	mov    %eax,0x10(%esi)
801030a5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030a8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801030ab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801030b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030b5:	5b                   	pop    %ebx
801030b6:	5e                   	pop    %esi
801030b7:	5f                   	pop    %edi
801030b8:	5d                   	pop    %ebp
801030b9:	c3                   	ret    
801030ba:	66 90                	xchg   %ax,%ax
801030bc:	66 90                	xchg   %ax,%ax
801030be:	66 90                	xchg   %ax,%ax

801030c0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030c0:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
801030c6:	85 c9                	test   %ecx,%ecx
801030c8:	0f 8e 8a 00 00 00    	jle    80103158 <install_trans+0x98>
{
801030ce:	55                   	push   %ebp
801030cf:	89 e5                	mov    %esp,%ebp
801030d1:	57                   	push   %edi
801030d2:	56                   	push   %esi
801030d3:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
801030d4:	31 db                	xor    %ebx,%ebx
{
801030d6:	83 ec 0c             	sub    $0xc,%esp
801030d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801030e0:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
801030e5:	83 ec 08             	sub    $0x8,%esp
801030e8:	01 d8                	add    %ebx,%eax
801030ea:	83 c0 01             	add    $0x1,%eax
801030ed:	50                   	push   %eax
801030ee:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
801030f4:	e8 d7 cf ff ff       	call   801000d0 <bread>
801030f9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030fb:	58                   	pop    %eax
801030fc:	5a                   	pop    %edx
801030fd:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103104:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010310a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010310d:	e8 be cf ff ff       	call   801000d0 <bread>
80103112:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103114:	8d 47 5c             	lea    0x5c(%edi),%eax
80103117:	83 c4 0c             	add    $0xc,%esp
8010311a:	68 00 02 00 00       	push   $0x200
8010311f:	50                   	push   %eax
80103120:	8d 46 5c             	lea    0x5c(%esi),%eax
80103123:	50                   	push   %eax
80103124:	e8 f7 1e 00 00       	call   80105020 <memmove>
    bwrite(dbuf);  // write dst to disk
80103129:	89 34 24             	mov    %esi,(%esp)
8010312c:	e8 6f d0 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103131:	89 3c 24             	mov    %edi,(%esp)
80103134:	e8 a7 d0 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103139:	89 34 24             	mov    %esi,(%esp)
8010313c:	e8 9f d0 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103141:	83 c4 10             	add    $0x10,%esp
80103144:	39 1d e8 c6 14 80    	cmp    %ebx,0x8014c6e8
8010314a:	7f 94                	jg     801030e0 <install_trans+0x20>
  }
}
8010314c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010314f:	5b                   	pop    %ebx
80103150:	5e                   	pop    %esi
80103151:	5f                   	pop    %edi
80103152:	5d                   	pop    %ebp
80103153:	c3                   	ret    
80103154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103158:	f3 c3                	repz ret 
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103160 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103160:	55                   	push   %ebp
80103161:	89 e5                	mov    %esp,%ebp
80103163:	56                   	push   %esi
80103164:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80103165:	83 ec 08             	sub    $0x8,%esp
80103168:	ff 35 d4 c6 14 80    	pushl  0x8014c6d4
8010316e:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103174:	e8 57 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103179:	8b 1d e8 c6 14 80    	mov    0x8014c6e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
8010317f:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103182:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80103184:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80103186:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103189:	7e 16                	jle    801031a1 <write_head+0x41>
8010318b:	c1 e3 02             	shl    $0x2,%ebx
8010318e:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80103190:	8b 8a ec c6 14 80    	mov    -0x7feb3914(%edx),%ecx
80103196:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
8010319a:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
8010319d:	39 da                	cmp    %ebx,%edx
8010319f:	75 ef                	jne    80103190 <write_head+0x30>
  }
  bwrite(buf);
801031a1:	83 ec 0c             	sub    $0xc,%esp
801031a4:	56                   	push   %esi
801031a5:	e8 f6 cf ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801031aa:	89 34 24             	mov    %esi,(%esp)
801031ad:	e8 2e d0 ff ff       	call   801001e0 <brelse>
}
801031b2:	83 c4 10             	add    $0x10,%esp
801031b5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031b8:	5b                   	pop    %ebx
801031b9:	5e                   	pop    %esi
801031ba:	5d                   	pop    %ebp
801031bb:	c3                   	ret    
801031bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801031c0 <initlog>:
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	53                   	push   %ebx
801031c4:	83 ec 2c             	sub    $0x2c,%esp
801031c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801031ca:	68 80 89 10 80       	push   $0x80108980
801031cf:	68 a0 c6 14 80       	push   $0x8014c6a0
801031d4:	e8 47 1b 00 00       	call   80104d20 <initlock>
  readsb(dev, &sb);
801031d9:	58                   	pop    %eax
801031da:	8d 45 dc             	lea    -0x24(%ebp),%eax
801031dd:	5a                   	pop    %edx
801031de:	50                   	push   %eax
801031df:	53                   	push   %ebx
801031e0:	e8 9b e3 ff ff       	call   80101580 <readsb>
  log.size = sb.nlog;
801031e5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801031e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801031eb:	59                   	pop    %ecx
  log.dev = dev;
801031ec:	89 1d e4 c6 14 80    	mov    %ebx,0x8014c6e4
  log.size = sb.nlog;
801031f2:	89 15 d8 c6 14 80    	mov    %edx,0x8014c6d8
  log.start = sb.logstart;
801031f8:	a3 d4 c6 14 80       	mov    %eax,0x8014c6d4
  struct buf *buf = bread(log.dev, log.start);
801031fd:	5a                   	pop    %edx
801031fe:	50                   	push   %eax
801031ff:	53                   	push   %ebx
80103200:	e8 cb ce ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80103205:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80103208:	83 c4 10             	add    $0x10,%esp
8010320b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
8010320d:	89 1d e8 c6 14 80    	mov    %ebx,0x8014c6e8
  for (i = 0; i < log.lh.n; i++) {
80103213:	7e 1c                	jle    80103231 <initlog+0x71>
80103215:	c1 e3 02             	shl    $0x2,%ebx
80103218:	31 d2                	xor    %edx,%edx
8010321a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103220:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103224:	83 c2 04             	add    $0x4,%edx
80103227:	89 8a e8 c6 14 80    	mov    %ecx,-0x7feb3918(%edx)
  for (i = 0; i < log.lh.n; i++) {
8010322d:	39 d3                	cmp    %edx,%ebx
8010322f:	75 ef                	jne    80103220 <initlog+0x60>
  brelse(buf);
80103231:	83 ec 0c             	sub    $0xc,%esp
80103234:	50                   	push   %eax
80103235:	e8 a6 cf ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010323a:	e8 81 fe ff ff       	call   801030c0 <install_trans>
  log.lh.n = 0;
8010323f:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
80103246:	00 00 00 
  write_head(); // clear the log
80103249:	e8 12 ff ff ff       	call   80103160 <write_head>
}
8010324e:	83 c4 10             	add    $0x10,%esp
80103251:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103254:	c9                   	leave  
80103255:	c3                   	ret    
80103256:	8d 76 00             	lea    0x0(%esi),%esi
80103259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103260 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103266:	68 a0 c6 14 80       	push   $0x8014c6a0
8010326b:	e8 f0 1b 00 00       	call   80104e60 <acquire>
80103270:	83 c4 10             	add    $0x10,%esp
80103273:	eb 18                	jmp    8010328d <begin_op+0x2d>
80103275:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103278:	83 ec 08             	sub    $0x8,%esp
8010327b:	68 a0 c6 14 80       	push   $0x8014c6a0
80103280:	68 a0 c6 14 80       	push   $0x8014c6a0
80103285:	e8 d6 13 00 00       	call   80104660 <sleep>
8010328a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010328d:	a1 e0 c6 14 80       	mov    0x8014c6e0,%eax
80103292:	85 c0                	test   %eax,%eax
80103294:	75 e2                	jne    80103278 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103296:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010329b:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
801032a1:	83 c0 01             	add    $0x1,%eax
801032a4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801032a7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801032aa:	83 fa 1e             	cmp    $0x1e,%edx
801032ad:	7f c9                	jg     80103278 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801032af:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801032b2:	a3 dc c6 14 80       	mov    %eax,0x8014c6dc
      release(&log.lock);
801032b7:	68 a0 c6 14 80       	push   $0x8014c6a0
801032bc:	e8 5f 1c 00 00       	call   80104f20 <release>
      break;
    }
  }
}
801032c1:	83 c4 10             	add    $0x10,%esp
801032c4:	c9                   	leave  
801032c5:	c3                   	ret    
801032c6:	8d 76 00             	lea    0x0(%esi),%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801032d0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	57                   	push   %edi
801032d4:	56                   	push   %esi
801032d5:	53                   	push   %ebx
801032d6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801032d9:	68 a0 c6 14 80       	push   $0x8014c6a0
801032de:	e8 7d 1b 00 00       	call   80104e60 <acquire>
  log.outstanding -= 1;
801032e3:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
  if(log.committing)
801032e8:	8b 35 e0 c6 14 80    	mov    0x8014c6e0,%esi
801032ee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801032f1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
801032f4:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
801032f6:	89 1d dc c6 14 80    	mov    %ebx,0x8014c6dc
  if(log.committing)
801032fc:	0f 85 1a 01 00 00    	jne    8010341c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80103302:	85 db                	test   %ebx,%ebx
80103304:	0f 85 ee 00 00 00    	jne    801033f8 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
8010330a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
8010330d:	c7 05 e0 c6 14 80 01 	movl   $0x1,0x8014c6e0
80103314:	00 00 00 
  release(&log.lock);
80103317:	68 a0 c6 14 80       	push   $0x8014c6a0
8010331c:	e8 ff 1b 00 00       	call   80104f20 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103321:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103327:	83 c4 10             	add    $0x10,%esp
8010332a:	85 c9                	test   %ecx,%ecx
8010332c:	0f 8e 85 00 00 00    	jle    801033b7 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103332:	a1 d4 c6 14 80       	mov    0x8014c6d4,%eax
80103337:	83 ec 08             	sub    $0x8,%esp
8010333a:	01 d8                	add    %ebx,%eax
8010333c:	83 c0 01             	add    $0x1,%eax
8010333f:	50                   	push   %eax
80103340:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
80103346:	e8 85 cd ff ff       	call   801000d0 <bread>
8010334b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010334d:	58                   	pop    %eax
8010334e:	5a                   	pop    %edx
8010334f:	ff 34 9d ec c6 14 80 	pushl  -0x7feb3914(,%ebx,4)
80103356:	ff 35 e4 c6 14 80    	pushl  0x8014c6e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010335c:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010335f:	e8 6c cd ff ff       	call   801000d0 <bread>
80103364:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103366:	8d 40 5c             	lea    0x5c(%eax),%eax
80103369:	83 c4 0c             	add    $0xc,%esp
8010336c:	68 00 02 00 00       	push   $0x200
80103371:	50                   	push   %eax
80103372:	8d 46 5c             	lea    0x5c(%esi),%eax
80103375:	50                   	push   %eax
80103376:	e8 a5 1c 00 00       	call   80105020 <memmove>
    bwrite(to);  // write the log
8010337b:	89 34 24             	mov    %esi,(%esp)
8010337e:	e8 1d ce ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103383:	89 3c 24             	mov    %edi,(%esp)
80103386:	e8 55 ce ff ff       	call   801001e0 <brelse>
    brelse(to);
8010338b:	89 34 24             	mov    %esi,(%esp)
8010338e:	e8 4d ce ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103393:	83 c4 10             	add    $0x10,%esp
80103396:	3b 1d e8 c6 14 80    	cmp    0x8014c6e8,%ebx
8010339c:	7c 94                	jl     80103332 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010339e:	e8 bd fd ff ff       	call   80103160 <write_head>
    install_trans(); // Now install writes to home locations
801033a3:	e8 18 fd ff ff       	call   801030c0 <install_trans>
    log.lh.n = 0;
801033a8:	c7 05 e8 c6 14 80 00 	movl   $0x0,0x8014c6e8
801033af:	00 00 00 
    write_head();    // Erase the transaction from the log
801033b2:	e8 a9 fd ff ff       	call   80103160 <write_head>
    acquire(&log.lock);
801033b7:	83 ec 0c             	sub    $0xc,%esp
801033ba:	68 a0 c6 14 80       	push   $0x8014c6a0
801033bf:	e8 9c 1a 00 00       	call   80104e60 <acquire>
    wakeup(&log);
801033c4:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
    log.committing = 0;
801033cb:	c7 05 e0 c6 14 80 00 	movl   $0x0,0x8014c6e0
801033d2:	00 00 00 
    wakeup(&log);
801033d5:	e8 46 14 00 00       	call   80104820 <wakeup>
    release(&log.lock);
801033da:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
801033e1:	e8 3a 1b 00 00       	call   80104f20 <release>
801033e6:	83 c4 10             	add    $0x10,%esp
}
801033e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033ec:	5b                   	pop    %ebx
801033ed:	5e                   	pop    %esi
801033ee:	5f                   	pop    %edi
801033ef:	5d                   	pop    %ebp
801033f0:	c3                   	ret    
801033f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
801033f8:	83 ec 0c             	sub    $0xc,%esp
801033fb:	68 a0 c6 14 80       	push   $0x8014c6a0
80103400:	e8 1b 14 00 00       	call   80104820 <wakeup>
  release(&log.lock);
80103405:	c7 04 24 a0 c6 14 80 	movl   $0x8014c6a0,(%esp)
8010340c:	e8 0f 1b 00 00       	call   80104f20 <release>
80103411:	83 c4 10             	add    $0x10,%esp
}
80103414:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103417:	5b                   	pop    %ebx
80103418:	5e                   	pop    %esi
80103419:	5f                   	pop    %edi
8010341a:	5d                   	pop    %ebp
8010341b:	c3                   	ret    
    panic("log.committing");
8010341c:	83 ec 0c             	sub    $0xc,%esp
8010341f:	68 84 89 10 80       	push   $0x80108984
80103424:	e8 67 cf ff ff       	call   80100390 <panic>
80103429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103430 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	53                   	push   %ebx
80103434:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103437:	8b 15 e8 c6 14 80    	mov    0x8014c6e8,%edx
{
8010343d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103440:	83 fa 1d             	cmp    $0x1d,%edx
80103443:	0f 8f 9d 00 00 00    	jg     801034e6 <log_write+0xb6>
80103449:	a1 d8 c6 14 80       	mov    0x8014c6d8,%eax
8010344e:	83 e8 01             	sub    $0x1,%eax
80103451:	39 c2                	cmp    %eax,%edx
80103453:	0f 8d 8d 00 00 00    	jge    801034e6 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103459:	a1 dc c6 14 80       	mov    0x8014c6dc,%eax
8010345e:	85 c0                	test   %eax,%eax
80103460:	0f 8e 8d 00 00 00    	jle    801034f3 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103466:	83 ec 0c             	sub    $0xc,%esp
80103469:	68 a0 c6 14 80       	push   $0x8014c6a0
8010346e:	e8 ed 19 00 00       	call   80104e60 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103473:	8b 0d e8 c6 14 80    	mov    0x8014c6e8,%ecx
80103479:	83 c4 10             	add    $0x10,%esp
8010347c:	83 f9 00             	cmp    $0x0,%ecx
8010347f:	7e 57                	jle    801034d8 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103481:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80103484:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103486:	3b 15 ec c6 14 80    	cmp    0x8014c6ec,%edx
8010348c:	75 0b                	jne    80103499 <log_write+0x69>
8010348e:	eb 38                	jmp    801034c8 <log_write+0x98>
80103490:	39 14 85 ec c6 14 80 	cmp    %edx,-0x7feb3914(,%eax,4)
80103497:	74 2f                	je     801034c8 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80103499:	83 c0 01             	add    $0x1,%eax
8010349c:	39 c1                	cmp    %eax,%ecx
8010349e:	75 f0                	jne    80103490 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801034a0:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801034a7:	83 c0 01             	add    $0x1,%eax
801034aa:	a3 e8 c6 14 80       	mov    %eax,0x8014c6e8
  b->flags |= B_DIRTY; // prevent eviction
801034af:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
801034b2:	c7 45 08 a0 c6 14 80 	movl   $0x8014c6a0,0x8(%ebp)
}
801034b9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034bc:	c9                   	leave  
  release(&log.lock);
801034bd:	e9 5e 1a 00 00       	jmp    80104f20 <release>
801034c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801034c8:	89 14 85 ec c6 14 80 	mov    %edx,-0x7feb3914(,%eax,4)
801034cf:	eb de                	jmp    801034af <log_write+0x7f>
801034d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034d8:	8b 43 08             	mov    0x8(%ebx),%eax
801034db:	a3 ec c6 14 80       	mov    %eax,0x8014c6ec
  if (i == log.lh.n)
801034e0:	75 cd                	jne    801034af <log_write+0x7f>
801034e2:	31 c0                	xor    %eax,%eax
801034e4:	eb c1                	jmp    801034a7 <log_write+0x77>
    panic("too big a transaction");
801034e6:	83 ec 0c             	sub    $0xc,%esp
801034e9:	68 93 89 10 80       	push   $0x80108993
801034ee:	e8 9d ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801034f3:	83 ec 0c             	sub    $0xc,%esp
801034f6:	68 a9 89 10 80       	push   $0x801089a9
801034fb:	e8 90 ce ff ff       	call   80100390 <panic>

80103500 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103500:	55                   	push   %ebp
80103501:	89 e5                	mov    %esp,%ebp
80103503:	53                   	push   %ebx
80103504:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103507:	e8 34 0a 00 00       	call   80103f40 <cpuid>
8010350c:	89 c3                	mov    %eax,%ebx
8010350e:	e8 2d 0a 00 00       	call   80103f40 <cpuid>
80103513:	83 ec 04             	sub    $0x4,%esp
80103516:	53                   	push   %ebx
80103517:	50                   	push   %eax
80103518:	68 c4 89 10 80       	push   $0x801089c4
8010351d:	e8 3e d1 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103522:	e8 79 2d 00 00       	call   801062a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103527:	e8 94 09 00 00       	call   80103ec0 <mycpu>
8010352c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010352e:	b8 01 00 00 00       	mov    $0x1,%eax
80103533:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010353a:	e8 11 0e 00 00       	call   80104350 <scheduler>
8010353f:	90                   	nop

80103540 <mpenter>:
{
80103540:	55                   	push   %ebp
80103541:	89 e5                	mov    %esp,%ebp
80103543:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103546:	e8 55 3f 00 00       	call   801074a0 <switchkvm>
  seginit();
8010354b:	e8 c0 3e 00 00       	call   80107410 <seginit>
  lapicinit();
80103550:	e8 9b f7 ff ff       	call   80102cf0 <lapicinit>
  mpmain();
80103555:	e8 a6 ff ff ff       	call   80103500 <mpmain>
8010355a:	66 90                	xchg   %ax,%ax
8010355c:	66 90                	xchg   %ax,%ax
8010355e:	66 90                	xchg   %ax,%ax

80103560 <main>:
{
80103560:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103564:	83 e4 f0             	and    $0xfffffff0,%esp
80103567:	ff 71 fc             	pushl  -0x4(%ecx)
8010356a:	55                   	push   %ebp
8010356b:	89 e5                	mov    %esp,%ebp
8010356d:	53                   	push   %ebx
8010356e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010356f:	83 ec 08             	sub    $0x8,%esp
80103572:	68 00 00 40 80       	push   $0x80400000
80103577:	68 c8 ab 15 80       	push   $0x8015abc8
8010357c:	e8 8f f3 ff ff       	call   80102910 <kinit1>
  kvmalloc();      // kernel page table
80103581:	e8 fa 43 00 00       	call   80107980 <kvmalloc>
  mpinit();        // detect other processors
80103586:	e8 75 01 00 00       	call   80103700 <mpinit>
  lapicinit();     // interrupt controller
8010358b:	e8 60 f7 ff ff       	call   80102cf0 <lapicinit>
  seginit();       // segment descriptors
80103590:	e8 7b 3e 00 00       	call   80107410 <seginit>
  picinit();       // disable pic
80103595:	e8 46 03 00 00       	call   801038e0 <picinit>
  ioapicinit();    // another interrupt controller
8010359a:	e8 51 f1 ff ff       	call   801026f0 <ioapicinit>
  consoleinit();   // console hardware
8010359f:	e8 1c d4 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801035a4:	e8 d7 31 00 00       	call   80106780 <uartinit>
  pinit();         // process table
801035a9:	e8 f2 08 00 00       	call   80103ea0 <pinit>
  tvinit();        // trap vectors
801035ae:	e8 6d 2c 00 00       	call   80106220 <tvinit>
  binit();         // buffer cache
801035b3:	e8 88 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
801035b8:	e8 e3 d8 ff ff       	call   80100ea0 <fileinit>
  ideinit();       // disk 
801035bd:	e8 0e ef ff ff       	call   801024d0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801035c2:	83 c4 0c             	add    $0xc,%esp
801035c5:	68 8a 00 00 00       	push   $0x8a
801035ca:	68 8c c4 10 80       	push   $0x8010c48c
801035cf:	68 00 70 00 80       	push   $0x80007000
801035d4:	e8 47 1a 00 00       	call   80105020 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801035d9:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
801035e0:	00 00 00 
801035e3:	83 c4 10             	add    $0x10,%esp
801035e6:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
801035eb:	3d a0 c7 14 80       	cmp    $0x8014c7a0,%eax
801035f0:	76 71                	jbe    80103663 <main+0x103>
801035f2:	bb a0 c7 14 80       	mov    $0x8014c7a0,%ebx
801035f7:	89 f6                	mov    %esi,%esi
801035f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == mycpu())  // We've started already.
80103600:	e8 bb 08 00 00       	call   80103ec0 <mycpu>
80103605:	39 d8                	cmp    %ebx,%eax
80103607:	74 41                	je     8010364a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103609:	e8 e2 f3 ff ff       	call   801029f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
8010360e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80103613:	c7 05 f8 6f 00 80 40 	movl   $0x80103540,0x80006ff8
8010361a:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
8010361d:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103624:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103627:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
8010362c:	0f b6 03             	movzbl (%ebx),%eax
8010362f:	83 ec 08             	sub    $0x8,%esp
80103632:	68 00 70 00 00       	push   $0x7000
80103637:	50                   	push   %eax
80103638:	e8 03 f8 ff ff       	call   80102e40 <lapicstartap>
8010363d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103640:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103646:	85 c0                	test   %eax,%eax
80103648:	74 f6                	je     80103640 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
8010364a:	69 05 20 cd 14 80 b0 	imul   $0xb0,0x8014cd20,%eax
80103651:	00 00 00 
80103654:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010365a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
8010365f:	39 c3                	cmp    %eax,%ebx
80103661:	72 9d                	jb     80103600 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103663:	83 ec 08             	sub    $0x8,%esp
80103666:	68 00 00 00 8e       	push   $0x8e000000
8010366b:	68 00 00 40 80       	push   $0x80400000
80103670:	e8 1b f3 ff ff       	call   80102990 <kinit2>
  userinit();      // first user process
80103675:	e8 16 09 00 00       	call   80103f90 <userinit>
  mpmain();        // finish this processor's setup
8010367a:	e8 81 fe ff ff       	call   80103500 <mpmain>
8010367f:	90                   	nop

80103680 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103680:	55                   	push   %ebp
80103681:	89 e5                	mov    %esp,%ebp
80103683:	57                   	push   %edi
80103684:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103685:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010368b:	53                   	push   %ebx
  e = addr+len;
8010368c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010368f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103692:	39 de                	cmp    %ebx,%esi
80103694:	72 10                	jb     801036a6 <mpsearch1+0x26>
80103696:	eb 50                	jmp    801036e8 <mpsearch1+0x68>
80103698:	90                   	nop
80103699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036a0:	39 fb                	cmp    %edi,%ebx
801036a2:	89 fe                	mov    %edi,%esi
801036a4:	76 42                	jbe    801036e8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036a6:	83 ec 04             	sub    $0x4,%esp
801036a9:	8d 7e 10             	lea    0x10(%esi),%edi
801036ac:	6a 04                	push   $0x4
801036ae:	68 d8 89 10 80       	push   $0x801089d8
801036b3:	56                   	push   %esi
801036b4:	e8 07 19 00 00       	call   80104fc0 <memcmp>
801036b9:	83 c4 10             	add    $0x10,%esp
801036bc:	85 c0                	test   %eax,%eax
801036be:	75 e0                	jne    801036a0 <mpsearch1+0x20>
801036c0:	89 f1                	mov    %esi,%ecx
801036c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801036c8:	0f b6 11             	movzbl (%ecx),%edx
801036cb:	83 c1 01             	add    $0x1,%ecx
801036ce:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
801036d0:	39 f9                	cmp    %edi,%ecx
801036d2:	75 f4                	jne    801036c8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036d4:	84 c0                	test   %al,%al
801036d6:	75 c8                	jne    801036a0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801036d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036db:	89 f0                	mov    %esi,%eax
801036dd:	5b                   	pop    %ebx
801036de:	5e                   	pop    %esi
801036df:	5f                   	pop    %edi
801036e0:	5d                   	pop    %ebp
801036e1:	c3                   	ret    
801036e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036eb:	31 f6                	xor    %esi,%esi
}
801036ed:	89 f0                	mov    %esi,%eax
801036ef:	5b                   	pop    %ebx
801036f0:	5e                   	pop    %esi
801036f1:	5f                   	pop    %edi
801036f2:	5d                   	pop    %ebp
801036f3:	c3                   	ret    
801036f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103700 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103700:	55                   	push   %ebp
80103701:	89 e5                	mov    %esp,%ebp
80103703:	57                   	push   %edi
80103704:	56                   	push   %esi
80103705:	53                   	push   %ebx
80103706:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103709:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103710:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103717:	c1 e0 08             	shl    $0x8,%eax
8010371a:	09 d0                	or     %edx,%eax
8010371c:	c1 e0 04             	shl    $0x4,%eax
8010371f:	85 c0                	test   %eax,%eax
80103721:	75 1b                	jne    8010373e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103723:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010372a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103731:	c1 e0 08             	shl    $0x8,%eax
80103734:	09 d0                	or     %edx,%eax
80103736:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103739:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010373e:	ba 00 04 00 00       	mov    $0x400,%edx
80103743:	e8 38 ff ff ff       	call   80103680 <mpsearch1>
80103748:	85 c0                	test   %eax,%eax
8010374a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010374d:	0f 84 3d 01 00 00    	je     80103890 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103753:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103756:	8b 58 04             	mov    0x4(%eax),%ebx
80103759:	85 db                	test   %ebx,%ebx
8010375b:	0f 84 4f 01 00 00    	je     801038b0 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103761:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103767:	83 ec 04             	sub    $0x4,%esp
8010376a:	6a 04                	push   $0x4
8010376c:	68 f5 89 10 80       	push   $0x801089f5
80103771:	56                   	push   %esi
80103772:	e8 49 18 00 00       	call   80104fc0 <memcmp>
80103777:	83 c4 10             	add    $0x10,%esp
8010377a:	85 c0                	test   %eax,%eax
8010377c:	0f 85 2e 01 00 00    	jne    801038b0 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
80103782:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103789:	3c 01                	cmp    $0x1,%al
8010378b:	0f 95 c2             	setne  %dl
8010378e:	3c 04                	cmp    $0x4,%al
80103790:	0f 95 c0             	setne  %al
80103793:	20 c2                	and    %al,%dl
80103795:	0f 85 15 01 00 00    	jne    801038b0 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
8010379b:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
801037a2:	66 85 ff             	test   %di,%di
801037a5:	74 1a                	je     801037c1 <mpinit+0xc1>
801037a7:	89 f0                	mov    %esi,%eax
801037a9:	01 f7                	add    %esi,%edi
  sum = 0;
801037ab:	31 d2                	xor    %edx,%edx
801037ad:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801037b0:	0f b6 08             	movzbl (%eax),%ecx
801037b3:	83 c0 01             	add    $0x1,%eax
801037b6:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801037b8:	39 c7                	cmp    %eax,%edi
801037ba:	75 f4                	jne    801037b0 <mpinit+0xb0>
801037bc:	84 d2                	test   %dl,%dl
801037be:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801037c1:	85 f6                	test   %esi,%esi
801037c3:	0f 84 e7 00 00 00    	je     801038b0 <mpinit+0x1b0>
801037c9:	84 d2                	test   %dl,%dl
801037cb:	0f 85 df 00 00 00    	jne    801038b0 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801037d1:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801037d7:	a3 80 c6 14 80       	mov    %eax,0x8014c680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037dc:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801037e3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
801037e9:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037ee:	01 d6                	add    %edx,%esi
801037f0:	39 c6                	cmp    %eax,%esi
801037f2:	76 23                	jbe    80103817 <mpinit+0x117>
    switch(*p){
801037f4:	0f b6 10             	movzbl (%eax),%edx
801037f7:	80 fa 04             	cmp    $0x4,%dl
801037fa:	0f 87 ca 00 00 00    	ja     801038ca <mpinit+0x1ca>
80103800:	ff 24 95 1c 8a 10 80 	jmp    *-0x7fef75e4(,%edx,4)
80103807:	89 f6                	mov    %esi,%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103810:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103813:	39 c6                	cmp    %eax,%esi
80103815:	77 dd                	ja     801037f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103817:	85 db                	test   %ebx,%ebx
80103819:	0f 84 9e 00 00 00    	je     801038bd <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010381f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103822:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103826:	74 15                	je     8010383d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103828:	b8 70 00 00 00       	mov    $0x70,%eax
8010382d:	ba 22 00 00 00       	mov    $0x22,%edx
80103832:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103833:	ba 23 00 00 00       	mov    $0x23,%edx
80103838:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103839:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010383c:	ee                   	out    %al,(%dx)
  }
}
8010383d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103840:	5b                   	pop    %ebx
80103841:	5e                   	pop    %esi
80103842:	5f                   	pop    %edi
80103843:	5d                   	pop    %ebp
80103844:	c3                   	ret    
80103845:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
80103848:	8b 0d 20 cd 14 80    	mov    0x8014cd20,%ecx
8010384e:	83 f9 07             	cmp    $0x7,%ecx
80103851:	7f 19                	jg     8010386c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103853:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103857:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010385d:	83 c1 01             	add    $0x1,%ecx
80103860:	89 0d 20 cd 14 80    	mov    %ecx,0x8014cd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103866:	88 97 a0 c7 14 80    	mov    %dl,-0x7feb3860(%edi)
      p += sizeof(struct mpproc);
8010386c:	83 c0 14             	add    $0x14,%eax
      continue;
8010386f:	e9 7c ff ff ff       	jmp    801037f0 <mpinit+0xf0>
80103874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103878:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010387c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010387f:	88 15 80 c7 14 80    	mov    %dl,0x8014c780
      continue;
80103885:	e9 66 ff ff ff       	jmp    801037f0 <mpinit+0xf0>
8010388a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
80103890:	ba 00 00 01 00       	mov    $0x10000,%edx
80103895:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010389a:	e8 e1 fd ff ff       	call   80103680 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010389f:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
801038a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801038a4:	0f 85 a9 fe ff ff    	jne    80103753 <mpinit+0x53>
801038aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801038b0:	83 ec 0c             	sub    $0xc,%esp
801038b3:	68 dd 89 10 80       	push   $0x801089dd
801038b8:	e8 d3 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801038bd:	83 ec 0c             	sub    $0xc,%esp
801038c0:	68 fc 89 10 80       	push   $0x801089fc
801038c5:	e8 c6 ca ff ff       	call   80100390 <panic>
      ismp = 0;
801038ca:	31 db                	xor    %ebx,%ebx
801038cc:	e9 26 ff ff ff       	jmp    801037f7 <mpinit+0xf7>
801038d1:	66 90                	xchg   %ax,%ax
801038d3:	66 90                	xchg   %ax,%ax
801038d5:	66 90                	xchg   %ax,%ax
801038d7:	66 90                	xchg   %ax,%ax
801038d9:	66 90                	xchg   %ax,%ax
801038db:	66 90                	xchg   %ax,%ax
801038dd:	66 90                	xchg   %ax,%ax
801038df:	90                   	nop

801038e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801038e0:	55                   	push   %ebp
801038e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038e6:	ba 21 00 00 00       	mov    $0x21,%edx
801038eb:	89 e5                	mov    %esp,%ebp
801038ed:	ee                   	out    %al,(%dx)
801038ee:	ba a1 00 00 00       	mov    $0xa1,%edx
801038f3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801038f4:	5d                   	pop    %ebp
801038f5:	c3                   	ret    
801038f6:	66 90                	xchg   %ax,%ax
801038f8:	66 90                	xchg   %ax,%ax
801038fa:	66 90                	xchg   %ax,%ax
801038fc:	66 90                	xchg   %ax,%ax
801038fe:	66 90                	xchg   %ax,%ax

80103900 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	57                   	push   %edi
80103904:	56                   	push   %esi
80103905:	53                   	push   %ebx
80103906:	83 ec 0c             	sub    $0xc,%esp
80103909:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010390f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103915:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010391b:	e8 a0 d5 ff ff       	call   80100ec0 <filealloc>
80103920:	85 c0                	test   %eax,%eax
80103922:	89 03                	mov    %eax,(%ebx)
80103924:	74 22                	je     80103948 <pipealloc+0x48>
80103926:	e8 95 d5 ff ff       	call   80100ec0 <filealloc>
8010392b:	85 c0                	test   %eax,%eax
8010392d:	89 06                	mov    %eax,(%esi)
8010392f:	74 3f                	je     80103970 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103931:	e8 ba f0 ff ff       	call   801029f0 <kalloc>
80103936:	85 c0                	test   %eax,%eax
80103938:	89 c7                	mov    %eax,%edi
8010393a:	75 54                	jne    80103990 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010393c:	8b 03                	mov    (%ebx),%eax
8010393e:	85 c0                	test   %eax,%eax
80103940:	75 34                	jne    80103976 <pipealloc+0x76>
80103942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
80103948:	8b 06                	mov    (%esi),%eax
8010394a:	85 c0                	test   %eax,%eax
8010394c:	74 0c                	je     8010395a <pipealloc+0x5a>
    fileclose(*f1);
8010394e:	83 ec 0c             	sub    $0xc,%esp
80103951:	50                   	push   %eax
80103952:	e8 29 d6 ff ff       	call   80100f80 <fileclose>
80103957:	83 c4 10             	add    $0x10,%esp
  return -1;
}
8010395a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010395d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103962:	5b                   	pop    %ebx
80103963:	5e                   	pop    %esi
80103964:	5f                   	pop    %edi
80103965:	5d                   	pop    %ebp
80103966:	c3                   	ret    
80103967:	89 f6                	mov    %esi,%esi
80103969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
80103970:	8b 03                	mov    (%ebx),%eax
80103972:	85 c0                	test   %eax,%eax
80103974:	74 e4                	je     8010395a <pipealloc+0x5a>
    fileclose(*f0);
80103976:	83 ec 0c             	sub    $0xc,%esp
80103979:	50                   	push   %eax
8010397a:	e8 01 d6 ff ff       	call   80100f80 <fileclose>
  if(*f1)
8010397f:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
80103981:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103984:	85 c0                	test   %eax,%eax
80103986:	75 c6                	jne    8010394e <pipealloc+0x4e>
80103988:	eb d0                	jmp    8010395a <pipealloc+0x5a>
8010398a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
80103990:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
80103993:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010399a:	00 00 00 
  p->writeopen = 1;
8010399d:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801039a4:	00 00 00 
  p->nwrite = 0;
801039a7:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801039ae:	00 00 00 
  p->nread = 0;
801039b1:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801039b8:	00 00 00 
  initlock(&p->lock, "pipe");
801039bb:	68 30 8a 10 80       	push   $0x80108a30
801039c0:	50                   	push   %eax
801039c1:	e8 5a 13 00 00       	call   80104d20 <initlock>
  (*f0)->type = FD_PIPE;
801039c6:	8b 03                	mov    (%ebx),%eax
  return 0;
801039c8:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801039cb:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801039d1:	8b 03                	mov    (%ebx),%eax
801039d3:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801039d7:	8b 03                	mov    (%ebx),%eax
801039d9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801039dd:	8b 03                	mov    (%ebx),%eax
801039df:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801039e2:	8b 06                	mov    (%esi),%eax
801039e4:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801039ea:	8b 06                	mov    (%esi),%eax
801039ec:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801039f0:	8b 06                	mov    (%esi),%eax
801039f2:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801039f6:	8b 06                	mov    (%esi),%eax
801039f8:	89 78 0c             	mov    %edi,0xc(%eax)
}
801039fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801039fe:	31 c0                	xor    %eax,%eax
}
80103a00:	5b                   	pop    %ebx
80103a01:	5e                   	pop    %esi
80103a02:	5f                   	pop    %edi
80103a03:	5d                   	pop    %ebp
80103a04:	c3                   	ret    
80103a05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a10 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	56                   	push   %esi
80103a14:	53                   	push   %ebx
80103a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a18:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103a1b:	83 ec 0c             	sub    $0xc,%esp
80103a1e:	53                   	push   %ebx
80103a1f:	e8 3c 14 00 00       	call   80104e60 <acquire>
  if(writable){
80103a24:	83 c4 10             	add    $0x10,%esp
80103a27:	85 f6                	test   %esi,%esi
80103a29:	74 45                	je     80103a70 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a2b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a31:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103a34:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a3b:	00 00 00 
    wakeup(&p->nread);
80103a3e:	50                   	push   %eax
80103a3f:	e8 dc 0d 00 00       	call   80104820 <wakeup>
80103a44:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a47:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a4d:	85 d2                	test   %edx,%edx
80103a4f:	75 0a                	jne    80103a5b <pipeclose+0x4b>
80103a51:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a57:	85 c0                	test   %eax,%eax
80103a59:	74 35                	je     80103a90 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a5b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a61:	5b                   	pop    %ebx
80103a62:	5e                   	pop    %esi
80103a63:	5d                   	pop    %ebp
    release(&p->lock);
80103a64:	e9 b7 14 00 00       	jmp    80104f20 <release>
80103a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103a70:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103a76:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
80103a79:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a80:	00 00 00 
    wakeup(&p->nwrite);
80103a83:	50                   	push   %eax
80103a84:	e8 97 0d 00 00       	call   80104820 <wakeup>
80103a89:	83 c4 10             	add    $0x10,%esp
80103a8c:	eb b9                	jmp    80103a47 <pipeclose+0x37>
80103a8e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103a90:	83 ec 0c             	sub    $0xc,%esp
80103a93:	53                   	push   %ebx
80103a94:	e8 87 14 00 00       	call   80104f20 <release>
    kfree((char*)p);
80103a99:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a9c:	83 c4 10             	add    $0x10,%esp
}
80103a9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa2:	5b                   	pop    %ebx
80103aa3:	5e                   	pop    %esi
80103aa4:	5d                   	pop    %ebp
    kfree((char*)p);
80103aa5:	e9 36 ed ff ff       	jmp    801027e0 <kfree>
80103aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ab0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 28             	sub    $0x28,%esp
80103ab9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103abc:	53                   	push   %ebx
80103abd:	e8 9e 13 00 00       	call   80104e60 <acquire>
  for(i = 0; i < n; i++){
80103ac2:	8b 45 10             	mov    0x10(%ebp),%eax
80103ac5:	83 c4 10             	add    $0x10,%esp
80103ac8:	85 c0                	test   %eax,%eax
80103aca:	0f 8e c9 00 00 00    	jle    80103b99 <pipewrite+0xe9>
80103ad0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103ad3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103ad9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103adf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103ae2:	03 4d 10             	add    0x10(%ebp),%ecx
80103ae5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ae8:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103aee:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103af4:	39 d0                	cmp    %edx,%eax
80103af6:	75 71                	jne    80103b69 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103af8:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103afe:	85 c0                	test   %eax,%eax
80103b00:	74 4e                	je     80103b50 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b02:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103b08:	eb 3a                	jmp    80103b44 <pipewrite+0x94>
80103b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103b10:	83 ec 0c             	sub    $0xc,%esp
80103b13:	57                   	push   %edi
80103b14:	e8 07 0d 00 00       	call   80104820 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b19:	5a                   	pop    %edx
80103b1a:	59                   	pop    %ecx
80103b1b:	53                   	push   %ebx
80103b1c:	56                   	push   %esi
80103b1d:	e8 3e 0b 00 00       	call   80104660 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b22:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b28:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b2e:	83 c4 10             	add    $0x10,%esp
80103b31:	05 00 02 00 00       	add    $0x200,%eax
80103b36:	39 c2                	cmp    %eax,%edx
80103b38:	75 36                	jne    80103b70 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103b3a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b40:	85 c0                	test   %eax,%eax
80103b42:	74 0c                	je     80103b50 <pipewrite+0xa0>
80103b44:	e8 17 04 00 00       	call   80103f60 <myproc>
80103b49:	8b 40 24             	mov    0x24(%eax),%eax
80103b4c:	85 c0                	test   %eax,%eax
80103b4e:	74 c0                	je     80103b10 <pipewrite+0x60>
        release(&p->lock);
80103b50:	83 ec 0c             	sub    $0xc,%esp
80103b53:	53                   	push   %ebx
80103b54:	e8 c7 13 00 00       	call   80104f20 <release>
        return -1;
80103b59:	83 c4 10             	add    $0x10,%esp
80103b5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103b61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b64:	5b                   	pop    %ebx
80103b65:	5e                   	pop    %esi
80103b66:	5f                   	pop    %edi
80103b67:	5d                   	pop    %ebp
80103b68:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b69:	89 c2                	mov    %eax,%edx
80103b6b:	90                   	nop
80103b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b70:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b73:	8d 42 01             	lea    0x1(%edx),%eax
80103b76:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b7c:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103b82:	83 c6 01             	add    $0x1,%esi
80103b85:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
80103b89:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b8c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b8f:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103b93:	0f 85 4f ff ff ff    	jne    80103ae8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103b99:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b9f:	83 ec 0c             	sub    $0xc,%esp
80103ba2:	50                   	push   %eax
80103ba3:	e8 78 0c 00 00       	call   80104820 <wakeup>
  release(&p->lock);
80103ba8:	89 1c 24             	mov    %ebx,(%esp)
80103bab:	e8 70 13 00 00       	call   80104f20 <release>
  return n;
80103bb0:	83 c4 10             	add    $0x10,%esp
80103bb3:	8b 45 10             	mov    0x10(%ebp),%eax
80103bb6:	eb a9                	jmp    80103b61 <pipewrite+0xb1>
80103bb8:	90                   	nop
80103bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103bc0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	57                   	push   %edi
80103bc4:	56                   	push   %esi
80103bc5:	53                   	push   %ebx
80103bc6:	83 ec 18             	sub    $0x18,%esp
80103bc9:	8b 75 08             	mov    0x8(%ebp),%esi
80103bcc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103bcf:	56                   	push   %esi
80103bd0:	e8 8b 12 00 00       	call   80104e60 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103bd5:	83 c4 10             	add    $0x10,%esp
80103bd8:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103bde:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103be4:	75 6a                	jne    80103c50 <piperead+0x90>
80103be6:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
80103bec:	85 db                	test   %ebx,%ebx
80103bee:	0f 84 c4 00 00 00    	je     80103cb8 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103bf4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103bfa:	eb 2d                	jmp    80103c29 <piperead+0x69>
80103bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c00:	83 ec 08             	sub    $0x8,%esp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
80103c05:	e8 56 0a 00 00       	call   80104660 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c0a:	83 c4 10             	add    $0x10,%esp
80103c0d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c13:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c19:	75 35                	jne    80103c50 <piperead+0x90>
80103c1b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103c21:	85 d2                	test   %edx,%edx
80103c23:	0f 84 8f 00 00 00    	je     80103cb8 <piperead+0xf8>
    if(myproc()->killed){
80103c29:	e8 32 03 00 00       	call   80103f60 <myproc>
80103c2e:	8b 48 24             	mov    0x24(%eax),%ecx
80103c31:	85 c9                	test   %ecx,%ecx
80103c33:	74 cb                	je     80103c00 <piperead+0x40>
      release(&p->lock);
80103c35:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c38:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c3d:	56                   	push   %esi
80103c3e:	e8 dd 12 00 00       	call   80104f20 <release>
      return -1;
80103c43:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103c46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c49:	89 d8                	mov    %ebx,%eax
80103c4b:	5b                   	pop    %ebx
80103c4c:	5e                   	pop    %esi
80103c4d:	5f                   	pop    %edi
80103c4e:	5d                   	pop    %ebp
80103c4f:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c50:	8b 45 10             	mov    0x10(%ebp),%eax
80103c53:	85 c0                	test   %eax,%eax
80103c55:	7e 61                	jle    80103cb8 <piperead+0xf8>
    if(p->nread == p->nwrite)
80103c57:	31 db                	xor    %ebx,%ebx
80103c59:	eb 13                	jmp    80103c6e <piperead+0xae>
80103c5b:	90                   	nop
80103c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c60:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103c66:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103c6c:	74 1f                	je     80103c8d <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103c6e:	8d 41 01             	lea    0x1(%ecx),%eax
80103c71:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103c77:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
80103c7d:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
80103c82:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c85:	83 c3 01             	add    $0x1,%ebx
80103c88:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c8b:	75 d3                	jne    80103c60 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103c8d:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c93:	83 ec 0c             	sub    $0xc,%esp
80103c96:	50                   	push   %eax
80103c97:	e8 84 0b 00 00       	call   80104820 <wakeup>
  release(&p->lock);
80103c9c:	89 34 24             	mov    %esi,(%esp)
80103c9f:	e8 7c 12 00 00       	call   80104f20 <release>
  return i;
80103ca4:	83 c4 10             	add    $0x10,%esp
}
80103ca7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103caa:	89 d8                	mov    %ebx,%eax
80103cac:	5b                   	pop    %ebx
80103cad:	5e                   	pop    %esi
80103cae:	5f                   	pop    %edi
80103caf:	5d                   	pop    %ebp
80103cb0:	c3                   	ret    
80103cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cb8:	31 db                	xor    %ebx,%ebx
80103cba:	eb d1                	jmp    80103c8d <piperead+0xcd>
80103cbc:	66 90                	xchg   %ax,%ax
80103cbe:	66 90                	xchg   %ax,%ax

80103cc0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103cc0:	55                   	push   %ebp
80103cc1:	89 e5                	mov    %esp,%ebp
80103cc3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cc4:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80103cc9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103ccc:	68 40 cd 14 80       	push   $0x8014cd40
80103cd1:	e8 8a 11 00 00       	call   80104e60 <acquire>
80103cd6:	83 c4 10             	add    $0x10,%esp
80103cd9:	eb 17                	jmp    80103cf2 <allocproc+0x32>
80103cdb:	90                   	nop
80103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ce0:	81 c3 58 03 00 00    	add    $0x358,%ebx
80103ce6:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
80103cec:	0f 83 2e 01 00 00    	jae    80103e20 <allocproc+0x160>
    if(p->state == UNUSED)
80103cf2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103cf5:	85 c0                	test   %eax,%eax
80103cf7:	75 e7                	jne    80103ce0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103cf9:	a1 04 c0 10 80       	mov    0x8010c004,%eax

  release(&ptable.lock);
80103cfe:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103d01:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103d08:	8d 50 01             	lea    0x1(%eax),%edx
80103d0b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103d0e:	68 40 cd 14 80       	push   $0x8014cd40
  p->pid = nextpid++;
80103d13:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
80103d19:	e8 02 12 00 00       	call   80104f20 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d1e:	e8 cd ec ff ff       	call   801029f0 <kalloc>
80103d23:	83 c4 10             	add    $0x10,%esp
80103d26:	85 c0                	test   %eax,%eax
80103d28:	89 43 08             	mov    %eax,0x8(%ebx)
80103d2b:	0f 84 08 01 00 00    	je     80103e39 <allocproc+0x179>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103d31:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103d37:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d3a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d3f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103d42:	c7 40 14 07 62 10 80 	movl   $0x80106207,0x14(%eax)
  p->context = (struct context*)sp;
80103d49:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d4c:	6a 14                	push   $0x14
80103d4e:	6a 00                	push   $0x0
80103d50:	50                   	push   %eax
80103d51:	e8 1a 12 00 00       	call   80104f70 <memset>
  p->context->eip = (uint)forkret;
80103d56:	8b 43 1c             	mov    0x1c(%ebx),%eax

  p->headPG = -1;
  // Task 1
  if(p->pid>2){
80103d59:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d5c:	c7 40 10 50 3e 10 80 	movl   $0x80103e50,0x10(%eax)
  if(p->pid>2){
80103d63:	83 7b 10 02          	cmpl   $0x2,0x10(%ebx)
  p->headPG = -1;
80103d67:	c7 83 94 00 00 00 ff 	movl   $0xffffffff,0x94(%ebx)
80103d6e:	ff ff ff 
  if(p->pid>2){
80103d71:	0f 8f 91 00 00 00    	jg     80103e08 <allocproc+0x148>
80103d77:	8d 93 a4 00 00 00    	lea    0xa4(%ebx),%edx
80103d7d:	8d 83 d8 01 00 00    	lea    0x1d8(%ebx),%eax
80103d83:	8d 8b 58 03 00 00    	lea    0x358(%ebx),%ecx
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  }

  int i;
  for(i = 0; i < MAX_PSYC_PAGES; i++){
    p->swappedPGs[i].va = (char*)0xffffffff;
80103d90:	c7 42 04 ff ff ff ff 	movl   $0xffffffff,0x4(%edx)
    p->swappedPGs[i].changeCounter = 0;
80103d97:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80103d9d:	83 c0 18             	add    $0x18,%eax
    p->physicalPGs[i].va = (char*)0xffffffff;
80103da0:	c7 40 e8 ff ff ff ff 	movl   $0xffffffff,-0x18(%eax)
    p->physicalPGs[i].prev = 0;
80103da7:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80103dae:	83 c2 14             	add    $0x14,%edx
    p->physicalPGs[i].next = 0;
80103db1:	c7 40 f8 00 00 00 00 	movl   $0x0,-0x8(%eax)
    p->physicalPGs[i].age = 0;
80103db8:	c7 40 f0 00 00 00 00 	movl   $0x0,-0x10(%eax)
    p->physicalPGs[i].alloceted = 0;
80103dbf:	c7 40 f4 00 00 00 00 	movl   $0x0,-0xc(%eax)
  for(i = 0; i < MAX_PSYC_PAGES; i++){
80103dc6:	39 c8                	cmp    %ecx,%eax
80103dc8:	75 c6                	jne    80103d90 <allocproc+0xd0>
  }
  p->nTotalPGout = 0;
80103dca:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103dd1:	00 00 00 
  p->allocatedInPhys = 0;
80103dd4:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103ddb:	00 00 00 
  p->nPgsSwap = 0;
80103dde:	c7 83 84 00 00 00 00 	movl   $0x0,0x84(%ebx)
80103de5:	00 00 00 
  p->nPgsPhysical = 0;
80103de8:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
80103def:	00 00 00 
  p->headPG = 0;
80103df2:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
80103df9:	00 00 00 

  return p;
}
80103dfc:	89 d8                	mov    %ebx,%eax
80103dfe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e01:	c9                   	leave  
80103e02:	c3                   	ret    
80103e03:	90                   	nop
80103e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    createSwapFile(p);
80103e08:	83 ec 0c             	sub    $0xc,%esp
80103e0b:	53                   	push   %ebx
80103e0c:	e8 df e4 ff ff       	call   801022f0 <createSwapFile>
80103e11:	83 c4 10             	add    $0x10,%esp
80103e14:	e9 5e ff ff ff       	jmp    80103d77 <allocproc+0xb7>
80103e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103e20:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103e23:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103e25:	68 40 cd 14 80       	push   $0x8014cd40
80103e2a:	e8 f1 10 00 00       	call   80104f20 <release>
}
80103e2f:	89 d8                	mov    %ebx,%eax
  return 0;
80103e31:	83 c4 10             	add    $0x10,%esp
}
80103e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e37:	c9                   	leave  
80103e38:	c3                   	ret    
    p->state = UNUSED;
80103e39:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103e40:	31 db                	xor    %ebx,%ebx
80103e42:	eb b8                	jmp    80103dfc <allocproc+0x13c>
80103e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e50 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103e56:	68 40 cd 14 80       	push   $0x8014cd40
80103e5b:	e8 c0 10 00 00       	call   80104f20 <release>

  if (first) {
80103e60:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80103e65:	83 c4 10             	add    $0x10,%esp
80103e68:	85 c0                	test   %eax,%eax
80103e6a:	75 04                	jne    80103e70 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103e6c:	c9                   	leave  
80103e6d:	c3                   	ret    
80103e6e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103e70:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103e73:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
80103e7a:	00 00 00 
    iinit(ROOTDEV);
80103e7d:	6a 01                	push   $0x1
80103e7f:	e8 3c d7 ff ff       	call   801015c0 <iinit>
    initlog(ROOTDEV);
80103e84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103e8b:	e8 30 f3 ff ff       	call   801031c0 <initlog>
80103e90:	83 c4 10             	add    $0x10,%esp
}
80103e93:	c9                   	leave  
80103e94:	c3                   	ret    
80103e95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ea0 <pinit>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ea6:	68 35 8a 10 80       	push   $0x80108a35
80103eab:	68 40 cd 14 80       	push   $0x8014cd40
80103eb0:	e8 6b 0e 00 00       	call   80104d20 <initlock>
}
80103eb5:	83 c4 10             	add    $0x10,%esp
80103eb8:	c9                   	leave  
80103eb9:	c3                   	ret    
80103eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ec0 <mycpu>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	56                   	push   %esi
80103ec4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ec5:	9c                   	pushf  
80103ec6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ec7:	f6 c4 02             	test   $0x2,%ah
80103eca:	75 5e                	jne    80103f2a <mycpu+0x6a>
  apicid = lapicid();
80103ecc:	e8 1f ef ff ff       	call   80102df0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103ed1:	8b 35 20 cd 14 80    	mov    0x8014cd20,%esi
80103ed7:	85 f6                	test   %esi,%esi
80103ed9:	7e 42                	jle    80103f1d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103edb:	0f b6 15 a0 c7 14 80 	movzbl 0x8014c7a0,%edx
80103ee2:	39 d0                	cmp    %edx,%eax
80103ee4:	74 30                	je     80103f16 <mycpu+0x56>
80103ee6:	b9 50 c8 14 80       	mov    $0x8014c850,%ecx
  for (i = 0; i < ncpu; ++i) {
80103eeb:	31 d2                	xor    %edx,%edx
80103eed:	8d 76 00             	lea    0x0(%esi),%esi
80103ef0:	83 c2 01             	add    $0x1,%edx
80103ef3:	39 f2                	cmp    %esi,%edx
80103ef5:	74 26                	je     80103f1d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103ef7:	0f b6 19             	movzbl (%ecx),%ebx
80103efa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103f00:	39 c3                	cmp    %eax,%ebx
80103f02:	75 ec                	jne    80103ef0 <mycpu+0x30>
80103f04:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
80103f0a:	05 a0 c7 14 80       	add    $0x8014c7a0,%eax
}
80103f0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f12:	5b                   	pop    %ebx
80103f13:	5e                   	pop    %esi
80103f14:	5d                   	pop    %ebp
80103f15:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103f16:	b8 a0 c7 14 80       	mov    $0x8014c7a0,%eax
      return &cpus[i];
80103f1b:	eb f2                	jmp    80103f0f <mycpu+0x4f>
  panic("unknown apicid\n");
80103f1d:	83 ec 0c             	sub    $0xc,%esp
80103f20:	68 3c 8a 10 80       	push   $0x80108a3c
80103f25:	e8 66 c4 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f2a:	83 ec 0c             	sub    $0xc,%esp
80103f2d:	68 68 8b 10 80       	push   $0x80108b68
80103f32:	e8 59 c4 ff ff       	call   80100390 <panic>
80103f37:	89 f6                	mov    %esi,%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <cpuid>:
cpuid() {
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103f46:	e8 75 ff ff ff       	call   80103ec0 <mycpu>
80103f4b:	2d a0 c7 14 80       	sub    $0x8014c7a0,%eax
}
80103f50:	c9                   	leave  
  return mycpu()-cpus;
80103f51:	c1 f8 04             	sar    $0x4,%eax
80103f54:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f5a:	c3                   	ret    
80103f5b:	90                   	nop
80103f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f60 <myproc>:
myproc(void) {
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	53                   	push   %ebx
80103f64:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f67:	e8 24 0e 00 00       	call   80104d90 <pushcli>
  c = mycpu();
80103f6c:	e8 4f ff ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80103f71:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f77:	e8 54 0e 00 00       	call   80104dd0 <popcli>
}
80103f7c:	83 c4 04             	add    $0x4,%esp
80103f7f:	89 d8                	mov    %ebx,%eax
80103f81:	5b                   	pop    %ebx
80103f82:	5d                   	pop    %ebp
80103f83:	c3                   	ret    
80103f84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103f8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103f90 <userinit>:
{
80103f90:	55                   	push   %ebp
80103f91:	89 e5                	mov    %esp,%ebp
80103f93:	53                   	push   %ebx
80103f94:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103f97:	e8 24 fd ff ff       	call   80103cc0 <allocproc>
80103f9c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103f9e:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
  if((p->pgdir = setupkvm()) == 0)
80103fa3:	e8 58 39 00 00       	call   80107900 <setupkvm>
80103fa8:	85 c0                	test   %eax,%eax
80103faa:	89 43 04             	mov    %eax,0x4(%ebx)
80103fad:	0f 84 da 00 00 00    	je     8010408d <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103fb3:	83 ec 04             	sub    $0x4,%esp
80103fb6:	68 2c 00 00 00       	push   $0x2c
80103fbb:	68 60 c4 10 80       	push   $0x8010c460
80103fc0:	50                   	push   %eax
80103fc1:	e8 0a 36 00 00       	call   801075d0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103fc6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103fc9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103fcf:	6a 4c                	push   $0x4c
80103fd1:	6a 00                	push   $0x0
80103fd3:	ff 73 18             	pushl  0x18(%ebx)
80103fd6:	e8 95 0f 00 00       	call   80104f70 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103fdb:	8b 43 18             	mov    0x18(%ebx),%eax
80103fde:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103fe3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103fe8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103feb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103fef:	8b 43 18             	mov    0x18(%ebx),%eax
80103ff2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103ff6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ff9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ffd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104001:	8b 43 18             	mov    0x18(%ebx),%eax
80104004:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104008:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010400c:	8b 43 18             	mov    0x18(%ebx),%eax
8010400f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104016:	8b 43 18             	mov    0x18(%ebx),%eax
80104019:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104020:	8b 43 18             	mov    0x18(%ebx),%eax
80104023:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
8010402a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010402d:	6a 10                	push   $0x10
8010402f:	68 65 8a 10 80       	push   $0x80108a65
80104034:	50                   	push   %eax
80104035:	e8 16 11 00 00       	call   80105150 <safestrcpy>
  p->cwd = namei("/");
8010403a:	c7 04 24 6e 8a 10 80 	movl   $0x80108a6e,(%esp)
80104041:	e8 da df ff ff       	call   80102020 <namei>
80104046:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
80104049:	c7 04 24 70 8a 10 80 	movl   $0x80108a70,(%esp)
80104050:	e8 0b c6 ff ff       	call   80100660 <cprintf>
80104055:	58                   	pop    %eax
80104056:	5a                   	pop    %edx
80104057:	68 00 e0 00 00       	push   $0xe000
8010405c:	68 78 8a 10 80       	push   $0x80108a78
80104061:	e8 fa c5 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
80104066:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
8010406d:	e8 ee 0d 00 00       	call   80104e60 <acquire>
  p->state = RUNNABLE;
80104072:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104079:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104080:	e8 9b 0e 00 00       	call   80104f20 <release>
}
80104085:	83 c4 10             	add    $0x10,%esp
80104088:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010408b:	c9                   	leave  
8010408c:	c3                   	ret    
    panic("userinit: out of memory?");
8010408d:	83 ec 0c             	sub    $0xc,%esp
80104090:	68 4c 8a 10 80       	push   $0x80108a4c
80104095:	e8 f6 c2 ff ff       	call   80100390 <panic>
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040a0 <growproc>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	56                   	push   %esi
801040a4:	53                   	push   %ebx
801040a5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801040a8:	e8 e3 0c 00 00       	call   80104d90 <pushcli>
  c = mycpu();
801040ad:	e8 0e fe ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801040b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040b8:	e8 13 0d 00 00       	call   80104dd0 <popcli>
  if(n > 0){
801040bd:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
801040c0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801040c2:	7f 1c                	jg     801040e0 <growproc+0x40>
  } else if(n < 0){
801040c4:	75 3a                	jne    80104100 <growproc+0x60>
  switchuvm(curproc);
801040c6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801040c9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801040cb:	53                   	push   %ebx
801040cc:	e8 ef 33 00 00       	call   801074c0 <switchuvm>
  return 0;
801040d1:	83 c4 10             	add    $0x10,%esp
801040d4:	31 c0                	xor    %eax,%eax
}
801040d6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040d9:	5b                   	pop    %ebx
801040da:	5e                   	pop    %esi
801040db:	5d                   	pop    %ebp
801040dc:	c3                   	ret    
801040dd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801040e0:	83 ec 04             	sub    $0x4,%esp
801040e3:	01 c6                	add    %eax,%esi
801040e5:	56                   	push   %esi
801040e6:	50                   	push   %eax
801040e7:	ff 73 04             	pushl  0x4(%ebx)
801040ea:	e8 01 40 00 00       	call   801080f0 <allocuvm>
801040ef:	83 c4 10             	add    $0x10,%esp
801040f2:	85 c0                	test   %eax,%eax
801040f4:	75 d0                	jne    801040c6 <growproc+0x26>
      return -1;
801040f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040fb:	eb d9                	jmp    801040d6 <growproc+0x36>
801040fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104100:	83 ec 04             	sub    $0x4,%esp
80104103:	01 c6                	add    %eax,%esi
80104105:	56                   	push   %esi
80104106:	50                   	push   %eax
80104107:	ff 73 04             	pushl  0x4(%ebx)
8010410a:	e8 01 36 00 00       	call   80107710 <deallocuvm>
8010410f:	83 c4 10             	add    $0x10,%esp
80104112:	85 c0                	test   %eax,%eax
80104114:	75 b0                	jne    801040c6 <growproc+0x26>
80104116:	eb de                	jmp    801040f6 <growproc+0x56>
80104118:	90                   	nop
80104119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104120 <fork>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	57                   	push   %edi
80104124:	56                   	push   %esi
80104125:	53                   	push   %ebx
80104126:	83 ec 2c             	sub    $0x2c,%esp
  pushcli();
80104129:	e8 62 0c 00 00       	call   80104d90 <pushcli>
  c = mycpu();
8010412e:	e8 8d fd ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80104133:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
80104139:	89 7d d8             	mov    %edi,-0x28(%ebp)
  popcli();
8010413c:	e8 8f 0c 00 00       	call   80104dd0 <popcli>
  if((np = allocproc()) == 0){
80104141:	e8 7a fb ff ff       	call   80103cc0 <allocproc>
80104146:	85 c0                	test   %eax,%eax
80104148:	0f 84 c9 01 00 00    	je     80104317 <fork+0x1f7>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010414e:	83 ec 08             	sub    $0x8,%esp
80104151:	ff 37                	pushl  (%edi)
80104153:	ff 77 04             	pushl  0x4(%edi)
80104156:	89 c3                	mov    %eax,%ebx
80104158:	e8 73 38 00 00       	call   801079d0 <copyuvm>
8010415d:	83 c4 10             	add    $0x10,%esp
80104160:	85 c0                	test   %eax,%eax
80104162:	89 43 04             	mov    %eax,0x4(%ebx)
80104165:	0f 84 b5 01 00 00    	je     80104320 <fork+0x200>
  np->sz = curproc->sz;
8010416b:	8b 55 d8             	mov    -0x28(%ebp),%edx
  *np->tf = *curproc->tf;
8010416e:	8b 7b 18             	mov    0x18(%ebx),%edi
80104171:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80104176:	8b 02                	mov    (%edx),%eax
  np->parent = curproc;
80104178:	89 53 14             	mov    %edx,0x14(%ebx)
  np->sz = curproc->sz;
8010417b:	89 03                	mov    %eax,(%ebx)
  *np->tf = *curproc->tf;
8010417d:	8b 72 18             	mov    0x18(%edx),%esi
80104180:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104182:	31 f6                	xor    %esi,%esi
80104184:	89 d7                	mov    %edx,%edi
  np->tf->eax = 0;
80104186:	8b 43 18             	mov    0x18(%ebx),%eax
80104189:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104190:	8b 44 b7 28          	mov    0x28(%edi,%esi,4),%eax
80104194:	85 c0                	test   %eax,%eax
80104196:	74 10                	je     801041a8 <fork+0x88>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104198:	83 ec 0c             	sub    $0xc,%esp
8010419b:	50                   	push   %eax
8010419c:	e8 8f cd ff ff       	call   80100f30 <filedup>
801041a1:	83 c4 10             	add    $0x10,%esp
801041a4:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801041a8:	83 c6 01             	add    $0x1,%esi
801041ab:	83 fe 10             	cmp    $0x10,%esi
801041ae:	75 e0                	jne    80104190 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801041b0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801041b3:	83 ec 0c             	sub    $0xc,%esp
801041b6:	ff 77 68             	pushl  0x68(%edi)
801041b9:	e8 d2 d5 ff ff       	call   80101790 <idup>
801041be:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801041c1:	8d 47 6c             	lea    0x6c(%edi),%eax
801041c4:	83 c4 0c             	add    $0xc,%esp
801041c7:	6a 10                	push   $0x10
801041c9:	50                   	push   %eax
801041ca:	8d 43 6c             	lea    0x6c(%ebx),%eax
801041cd:	50                   	push   %eax
801041ce:	e8 7d 0f 00 00       	call   80105150 <safestrcpy>
  if(curproc->pid>2){
801041d3:	83 c4 10             	add    $0x10,%esp
801041d6:	83 7f 10 02          	cmpl   $0x2,0x10(%edi)
  pid = np->pid;
801041da:	8b 43 10             	mov    0x10(%ebx),%eax
801041dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(curproc->pid>2){
801041e0:	0f 8e 03 01 00 00    	jle    801042e9 <fork+0x1c9>
    np->nTotalPGout = 0;
801041e6:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801041ed:	00 00 00 
    np->nPGFLT = 0;
801041f0:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801041f7:	00 00 00 
801041fa:	8d 93 d8 01 00 00    	lea    0x1d8(%ebx),%edx
    np->nPgsSwap = curproc->nPgsSwap;
80104200:	8b 87 84 00 00 00    	mov    0x84(%edi),%eax
80104206:	8d 8f d8 01 00 00    	lea    0x1d8(%edi),%ecx
8010420c:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010420f:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80104215:	89 f8                	mov    %edi,%eax
80104217:	8d bb 98 00 00 00    	lea    0x98(%ebx),%edi
8010421d:	8d b0 98 00 00 00    	lea    0x98(%eax),%esi
80104223:	8d 83 58 03 00 00    	lea    0x358(%ebx),%eax
80104229:	89 d3                	mov    %edx,%ebx
8010422b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010422e:	66 90                	xchg   %ax,%ax
      memmove(&np->physicalPGs[i],&curproc->physicalPGs[i],sizeof(struct procPG));
80104230:	83 ec 04             	sub    $0x4,%esp
80104233:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104236:	6a 18                	push   $0x18
80104238:	51                   	push   %ecx
80104239:	53                   	push   %ebx
8010423a:	e8 e1 0d 00 00       	call   80105020 <memmove>
      memmove(&np->swappedPGs[i],&curproc->swappedPGs[i],sizeof(struct swappedPG));
8010423f:	83 c4 0c             	add    $0xc,%esp
80104242:	6a 14                	push   $0x14
80104244:	56                   	push   %esi
80104245:	57                   	push   %edi
80104246:	e8 d5 0d 00 00       	call   80105020 <memmove>
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
8010424b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
      np->physicalPGs[i].alloceted = 0;
8010424e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
      if(curproc->physicalPGs[i].va != (char*)0xffffffff){
80104255:	83 c4 10             	add    $0x10,%esp
80104258:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
8010425b:	74 0a                	je     80104267 <fork+0x147>
        np->nPgsPhysical++;
8010425d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104260:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
80104267:	83 c3 18             	add    $0x18,%ebx
8010426a:	83 c1 18             	add    $0x18,%ecx
8010426d:	83 c7 14             	add    $0x14,%edi
80104270:	83 c6 14             	add    $0x14,%esi
    for(int i = 0; i < MAX_PSYC_PAGES ; i++){
80104273:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80104276:	75 b8                	jne    80104230 <fork+0x110>
80104278:	8b 5d dc             	mov    -0x24(%ebp),%ebx
    char* newPage = kalloc();
8010427b:	e8 70 e7 ff ff       	call   801029f0 <kalloc>
80104280:	89 c6                	mov    %eax,%esi
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
80104282:	8b 45 d8             	mov    -0x28(%ebp),%eax
80104285:	8b 90 84 00 00 00    	mov    0x84(%eax),%edx
8010428b:	85 d2                	test   %edx,%edx
8010428d:	7e 4e                	jle    801042dd <fork+0x1bd>
8010428f:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80104292:	31 ff                	xor    %edi,%edi
80104294:	89 c3                	mov    %eax,%ebx
80104296:	8d 76 00             	lea    0x0(%esi),%esi
80104299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801042a0:	89 f9                	mov    %edi,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
801042a2:	68 00 10 00 00       	push   $0x1000
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801042a7:	83 c7 01             	add    $0x1,%edi
801042aa:	c1 e1 0c             	shl    $0xc,%ecx
      readFromSwapFile(curproc,newPage,i*PGSIZE,PGSIZE);
801042ad:	51                   	push   %ecx
801042ae:	56                   	push   %esi
801042af:	53                   	push   %ebx
801042b0:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801042b3:	e8 08 e1 ff ff       	call   801023c0 <readFromSwapFile>
      writeToSwapFile(np,newPage,i*PGSIZE,PGSIZE);
801042b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801042bb:	68 00 10 00 00       	push   $0x1000
801042c0:	51                   	push   %ecx
801042c1:	56                   	push   %esi
801042c2:	ff 75 e0             	pushl  -0x20(%ebp)
801042c5:	e8 c6 e0 ff ff       	call   80102390 <writeToSwapFile>
    for(i = 0; i < (curproc->nPgsSwap)*PGSIZE ; i++){
801042ca:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
801042d0:	83 c4 20             	add    $0x20,%esp
801042d3:	c1 e0 0c             	shl    $0xc,%eax
801042d6:	39 f8                	cmp    %edi,%eax
801042d8:	7f c6                	jg     801042a0 <fork+0x180>
801042da:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    kfree(newPage);
801042dd:	83 ec 0c             	sub    $0xc,%esp
801042e0:	56                   	push   %esi
801042e1:	e8 fa e4 ff ff       	call   801027e0 <kfree>
801042e6:	83 c4 10             	add    $0x10,%esp
  acquire(&ptable.lock);
801042e9:	83 ec 0c             	sub    $0xc,%esp
801042ec:	68 40 cd 14 80       	push   $0x8014cd40
801042f1:	e8 6a 0b 00 00       	call   80104e60 <acquire>
  np->state = RUNNABLE;
801042f6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
801042fd:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104304:	e8 17 0c 00 00       	call   80104f20 <release>
  return pid;
80104309:	83 c4 10             	add    $0x10,%esp
}
8010430c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
8010430f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104312:	5b                   	pop    %ebx
80104313:	5e                   	pop    %esi
80104314:	5f                   	pop    %edi
80104315:	5d                   	pop    %ebp
80104316:	c3                   	ret    
    return -1;
80104317:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
8010431e:	eb ec                	jmp    8010430c <fork+0x1ec>
    kfree(np->kstack);
80104320:	83 ec 0c             	sub    $0xc,%esp
80104323:	ff 73 08             	pushl  0x8(%ebx)
80104326:	e8 b5 e4 ff ff       	call   801027e0 <kfree>
    np->kstack = 0;
8010432b:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80104332:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104339:	83 c4 10             	add    $0x10,%esp
8010433c:	c7 45 d4 ff ff ff ff 	movl   $0xffffffff,-0x2c(%ebp)
80104343:	eb c7                	jmp    8010430c <fork+0x1ec>
80104345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104350 <scheduler>:
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	57                   	push   %edi
80104354:	56                   	push   %esi
80104355:	53                   	push   %ebx
80104356:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104359:	e8 62 fb ff ff       	call   80103ec0 <mycpu>
8010435e:	8d 78 04             	lea    0x4(%eax),%edi
80104361:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104363:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010436a:	00 00 00 
8010436d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104370:	fb                   	sti    
    acquire(&ptable.lock);
80104371:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104374:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
    acquire(&ptable.lock);
80104379:	68 40 cd 14 80       	push   $0x8014cd40
8010437e:	e8 dd 0a 00 00       	call   80104e60 <acquire>
80104383:	83 c4 10             	add    $0x10,%esp
80104386:	8d 76 00             	lea    0x0(%esi),%esi
80104389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(p->state != RUNNABLE)
80104390:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104394:	75 33                	jne    801043c9 <scheduler+0x79>
      switchuvm(p);
80104396:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104399:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010439f:	53                   	push   %ebx
801043a0:	e8 1b 31 00 00       	call   801074c0 <switchuvm>
      swtch(&(c->scheduler), p->context);
801043a5:	58                   	pop    %eax
801043a6:	5a                   	pop    %edx
801043a7:	ff 73 1c             	pushl  0x1c(%ebx)
801043aa:	57                   	push   %edi
      p->state = RUNNING;
801043ab:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801043b2:	e8 f4 0d 00 00       	call   801051ab <swtch>
      switchkvm();
801043b7:	e8 e4 30 00 00       	call   801074a0 <switchkvm>
      c->proc = 0;
801043bc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801043c3:	00 00 00 
801043c6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043c9:	81 c3 58 03 00 00    	add    $0x358,%ebx
801043cf:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
801043d5:	72 b9                	jb     80104390 <scheduler+0x40>
    release(&ptable.lock);
801043d7:	83 ec 0c             	sub    $0xc,%esp
801043da:	68 40 cd 14 80       	push   $0x8014cd40
801043df:	e8 3c 0b 00 00       	call   80104f20 <release>
    sti();
801043e4:	83 c4 10             	add    $0x10,%esp
801043e7:	eb 87                	jmp    80104370 <scheduler+0x20>
801043e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043f0 <sched>:
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	56                   	push   %esi
801043f4:	53                   	push   %ebx
  pushcli();
801043f5:	e8 96 09 00 00       	call   80104d90 <pushcli>
  c = mycpu();
801043fa:	e8 c1 fa ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801043ff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104405:	e8 c6 09 00 00       	call   80104dd0 <popcli>
  if(!holding(&ptable.lock))
8010440a:	83 ec 0c             	sub    $0xc,%esp
8010440d:	68 40 cd 14 80       	push   $0x8014cd40
80104412:	e8 19 0a 00 00       	call   80104e30 <holding>
80104417:	83 c4 10             	add    $0x10,%esp
8010441a:	85 c0                	test   %eax,%eax
8010441c:	74 4f                	je     8010446d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010441e:	e8 9d fa ff ff       	call   80103ec0 <mycpu>
80104423:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010442a:	75 68                	jne    80104494 <sched+0xa4>
  if(p->state == RUNNING)
8010442c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104430:	74 55                	je     80104487 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104432:	9c                   	pushf  
80104433:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104434:	f6 c4 02             	test   $0x2,%ah
80104437:	75 41                	jne    8010447a <sched+0x8a>
  intena = mycpu()->intena;
80104439:	e8 82 fa ff ff       	call   80103ec0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010443e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104441:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104447:	e8 74 fa ff ff       	call   80103ec0 <mycpu>
8010444c:	83 ec 08             	sub    $0x8,%esp
8010444f:	ff 70 04             	pushl  0x4(%eax)
80104452:	53                   	push   %ebx
80104453:	e8 53 0d 00 00       	call   801051ab <swtch>
  mycpu()->intena = intena;
80104458:	e8 63 fa ff ff       	call   80103ec0 <mycpu>
}
8010445d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104460:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104466:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104469:	5b                   	pop    %ebx
8010446a:	5e                   	pop    %esi
8010446b:	5d                   	pop    %ebp
8010446c:	c3                   	ret    
    panic("sched ptable.lock");
8010446d:	83 ec 0c             	sub    $0xc,%esp
80104470:	68 7b 8a 10 80       	push   $0x80108a7b
80104475:	e8 16 bf ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010447a:	83 ec 0c             	sub    $0xc,%esp
8010447d:	68 a7 8a 10 80       	push   $0x80108aa7
80104482:	e8 09 bf ff ff       	call   80100390 <panic>
    panic("sched running");
80104487:	83 ec 0c             	sub    $0xc,%esp
8010448a:	68 99 8a 10 80       	push   $0x80108a99
8010448f:	e8 fc be ff ff       	call   80100390 <panic>
    panic("sched locks");
80104494:	83 ec 0c             	sub    $0xc,%esp
80104497:	68 8d 8a 10 80       	push   $0x80108a8d
8010449c:	e8 ef be ff ff       	call   80100390 <panic>
801044a1:	eb 0d                	jmp    801044b0 <exit>
801044a3:	90                   	nop
801044a4:	90                   	nop
801044a5:	90                   	nop
801044a6:	90                   	nop
801044a7:	90                   	nop
801044a8:	90                   	nop
801044a9:	90                   	nop
801044aa:	90                   	nop
801044ab:	90                   	nop
801044ac:	90                   	nop
801044ad:	90                   	nop
801044ae:	90                   	nop
801044af:	90                   	nop

801044b0 <exit>:
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	57                   	push   %edi
801044b4:	56                   	push   %esi
801044b5:	53                   	push   %ebx
801044b6:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
801044b9:	e8 d2 08 00 00       	call   80104d90 <pushcli>
  c = mycpu();
801044be:	e8 fd f9 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801044c3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044c9:	e8 02 09 00 00       	call   80104dd0 <popcli>
  if(curproc == initproc)
801044ce:	39 35 b8 c5 10 80    	cmp    %esi,0x8010c5b8
801044d4:	8d 5e 28             	lea    0x28(%esi),%ebx
801044d7:	8d 7e 68             	lea    0x68(%esi),%edi
801044da:	0f 84 1e 01 00 00    	je     801045fe <exit+0x14e>
    if(curproc->ofile[fd]){
801044e0:	8b 03                	mov    (%ebx),%eax
801044e2:	85 c0                	test   %eax,%eax
801044e4:	74 12                	je     801044f8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801044e6:	83 ec 0c             	sub    $0xc,%esp
801044e9:	50                   	push   %eax
801044ea:	e8 91 ca ff ff       	call   80100f80 <fileclose>
      curproc->ofile[fd] = 0;
801044ef:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801044f5:	83 c4 10             	add    $0x10,%esp
801044f8:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
801044fb:	39 fb                	cmp    %edi,%ebx
801044fd:	75 e1                	jne    801044e0 <exit+0x30>
  if(removeSwapFile(curproc) != 0){
801044ff:	83 ec 0c             	sub    $0xc,%esp
80104502:	56                   	push   %esi
80104503:	e8 e8 db ff ff       	call   801020f0 <removeSwapFile>
80104508:	83 c4 10             	add    $0x10,%esp
8010450b:	85 c0                	test   %eax,%eax
8010450d:	0f 85 c5 00 00 00    	jne    801045d8 <exit+0x128>
  begin_op();
80104513:	e8 48 ed ff ff       	call   80103260 <begin_op>
  iput(curproc->cwd);
80104518:	83 ec 0c             	sub    $0xc,%esp
8010451b:	ff 76 68             	pushl  0x68(%esi)
8010451e:	e8 cd d3 ff ff       	call   801018f0 <iput>
  end_op();
80104523:	e8 a8 ed ff ff       	call   801032d0 <end_op>
  curproc->cwd = 0;
80104528:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
8010452f:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104536:	e8 25 09 00 00       	call   80104e60 <acquire>
  wakeup1(curproc->parent);
8010453b:	8b 56 14             	mov    0x14(%esi),%edx
8010453e:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104541:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
80104546:	eb 14                	jmp    8010455c <exit+0xac>
80104548:	90                   	nop
80104549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104550:	05 58 03 00 00       	add    $0x358,%eax
80104555:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
8010455a:	73 1e                	jae    8010457a <exit+0xca>
    if(p->state == SLEEPING && p->chan == chan)
8010455c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104560:	75 ee                	jne    80104550 <exit+0xa0>
80104562:	3b 50 20             	cmp    0x20(%eax),%edx
80104565:	75 e9                	jne    80104550 <exit+0xa0>
      p->state = RUNNABLE;
80104567:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010456e:	05 58 03 00 00       	add    $0x358,%eax
80104573:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
80104578:	72 e2                	jb     8010455c <exit+0xac>
      p->parent = initproc;
8010457a:	8b 0d b8 c5 10 80    	mov    0x8010c5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104580:	ba 74 cd 14 80       	mov    $0x8014cd74,%edx
80104585:	eb 17                	jmp    8010459e <exit+0xee>
80104587:	89 f6                	mov    %esi,%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104590:	81 c2 58 03 00 00    	add    $0x358,%edx
80104596:	81 fa 74 a3 15 80    	cmp    $0x8015a374,%edx
8010459c:	73 47                	jae    801045e5 <exit+0x135>
    if(p->parent == curproc){
8010459e:	39 72 14             	cmp    %esi,0x14(%edx)
801045a1:	75 ed                	jne    80104590 <exit+0xe0>
      if(p->state == ZOMBIE)
801045a3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801045a7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801045aa:	75 e4                	jne    80104590 <exit+0xe0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045ac:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
801045b1:	eb 11                	jmp    801045c4 <exit+0x114>
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	05 58 03 00 00       	add    $0x358,%eax
801045bd:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
801045c2:	73 cc                	jae    80104590 <exit+0xe0>
    if(p->state == SLEEPING && p->chan == chan)
801045c4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045c8:	75 ee                	jne    801045b8 <exit+0x108>
801045ca:	3b 48 20             	cmp    0x20(%eax),%ecx
801045cd:	75 e9                	jne    801045b8 <exit+0x108>
      p->state = RUNNABLE;
801045cf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801045d6:	eb e0                	jmp    801045b8 <exit+0x108>
    panic("exit: cant remove swapfile");
801045d8:	83 ec 0c             	sub    $0xc,%esp
801045db:	68 c8 8a 10 80       	push   $0x80108ac8
801045e0:	e8 ab bd ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
801045e5:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801045ec:	e8 ff fd ff ff       	call   801043f0 <sched>
  panic("zombie exit");
801045f1:	83 ec 0c             	sub    $0xc,%esp
801045f4:	68 e3 8a 10 80       	push   $0x80108ae3
801045f9:	e8 92 bd ff ff       	call   80100390 <panic>
    panic("init exiting");
801045fe:	83 ec 0c             	sub    $0xc,%esp
80104601:	68 bb 8a 10 80       	push   $0x80108abb
80104606:	e8 85 bd ff ff       	call   80100390 <panic>
8010460b:	90                   	nop
8010460c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104610 <yield>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	53                   	push   %ebx
80104614:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104617:	68 40 cd 14 80       	push   $0x8014cd40
8010461c:	e8 3f 08 00 00       	call   80104e60 <acquire>
  pushcli();
80104621:	e8 6a 07 00 00       	call   80104d90 <pushcli>
  c = mycpu();
80104626:	e8 95 f8 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
8010462b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104631:	e8 9a 07 00 00       	call   80104dd0 <popcli>
  myproc()->state = RUNNABLE;
80104636:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010463d:	e8 ae fd ff ff       	call   801043f0 <sched>
  release(&ptable.lock);
80104642:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
80104649:	e8 d2 08 00 00       	call   80104f20 <release>
}
8010464e:	83 c4 10             	add    $0x10,%esp
80104651:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104654:	c9                   	leave  
80104655:	c3                   	ret    
80104656:	8d 76 00             	lea    0x0(%esi),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <sleep>:
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	53                   	push   %ebx
80104666:	83 ec 0c             	sub    $0xc,%esp
80104669:	8b 7d 08             	mov    0x8(%ebp),%edi
8010466c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010466f:	e8 1c 07 00 00       	call   80104d90 <pushcli>
  c = mycpu();
80104674:	e8 47 f8 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80104679:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010467f:	e8 4c 07 00 00       	call   80104dd0 <popcli>
  if(p == 0)
80104684:	85 db                	test   %ebx,%ebx
80104686:	0f 84 87 00 00 00    	je     80104713 <sleep+0xb3>
  if(lk == 0)
8010468c:	85 f6                	test   %esi,%esi
8010468e:	74 76                	je     80104706 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104690:	81 fe 40 cd 14 80    	cmp    $0x8014cd40,%esi
80104696:	74 50                	je     801046e8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104698:	83 ec 0c             	sub    $0xc,%esp
8010469b:	68 40 cd 14 80       	push   $0x8014cd40
801046a0:	e8 bb 07 00 00       	call   80104e60 <acquire>
    release(lk);
801046a5:	89 34 24             	mov    %esi,(%esp)
801046a8:	e8 73 08 00 00       	call   80104f20 <release>
  p->chan = chan;
801046ad:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801046b0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801046b7:	e8 34 fd ff ff       	call   801043f0 <sched>
  p->chan = 0;
801046bc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801046c3:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
801046ca:	e8 51 08 00 00       	call   80104f20 <release>
    acquire(lk);
801046cf:	89 75 08             	mov    %esi,0x8(%ebp)
801046d2:	83 c4 10             	add    $0x10,%esp
}
801046d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046d8:	5b                   	pop    %ebx
801046d9:	5e                   	pop    %esi
801046da:	5f                   	pop    %edi
801046db:	5d                   	pop    %ebp
    acquire(lk);
801046dc:	e9 7f 07 00 00       	jmp    80104e60 <acquire>
801046e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801046e8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801046eb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801046f2:	e8 f9 fc ff ff       	call   801043f0 <sched>
  p->chan = 0;
801046f7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801046fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104701:	5b                   	pop    %ebx
80104702:	5e                   	pop    %esi
80104703:	5f                   	pop    %edi
80104704:	5d                   	pop    %ebp
80104705:	c3                   	ret    
    panic("sleep without lk");
80104706:	83 ec 0c             	sub    $0xc,%esp
80104709:	68 f5 8a 10 80       	push   $0x80108af5
8010470e:	e8 7d bc ff ff       	call   80100390 <panic>
    panic("sleep");
80104713:	83 ec 0c             	sub    $0xc,%esp
80104716:	68 ef 8a 10 80       	push   $0x80108aef
8010471b:	e8 70 bc ff ff       	call   80100390 <panic>

80104720 <wait>:
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
  pushcli();
80104725:	e8 66 06 00 00       	call   80104d90 <pushcli>
  c = mycpu();
8010472a:	e8 91 f7 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
8010472f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104735:	e8 96 06 00 00       	call   80104dd0 <popcli>
  acquire(&ptable.lock);
8010473a:	83 ec 0c             	sub    $0xc,%esp
8010473d:	68 40 cd 14 80       	push   $0x8014cd40
80104742:	e8 19 07 00 00       	call   80104e60 <acquire>
80104747:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010474a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010474c:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
80104751:	eb 13                	jmp    80104766 <wait+0x46>
80104753:	90                   	nop
80104754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104758:	81 c3 58 03 00 00    	add    $0x358,%ebx
8010475e:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
80104764:	73 1e                	jae    80104784 <wait+0x64>
      if(p->parent != curproc)
80104766:	39 73 14             	cmp    %esi,0x14(%ebx)
80104769:	75 ed                	jne    80104758 <wait+0x38>
      if(p->state == ZOMBIE){
8010476b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010476f:	74 37                	je     801047a8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104771:	81 c3 58 03 00 00    	add    $0x358,%ebx
      havekids = 1;
80104777:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010477c:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
80104782:	72 e2                	jb     80104766 <wait+0x46>
    if(!havekids || curproc->killed){
80104784:	85 c0                	test   %eax,%eax
80104786:	74 76                	je     801047fe <wait+0xde>
80104788:	8b 46 24             	mov    0x24(%esi),%eax
8010478b:	85 c0                	test   %eax,%eax
8010478d:	75 6f                	jne    801047fe <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010478f:	83 ec 08             	sub    $0x8,%esp
80104792:	68 40 cd 14 80       	push   $0x8014cd40
80104797:	56                   	push   %esi
80104798:	e8 c3 fe ff ff       	call   80104660 <sleep>
    havekids = 0;
8010479d:	83 c4 10             	add    $0x10,%esp
801047a0:	eb a8                	jmp    8010474a <wait+0x2a>
801047a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
801047a8:	83 ec 0c             	sub    $0xc,%esp
801047ab:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801047ae:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801047b1:	e8 2a e0 ff ff       	call   801027e0 <kfree>
        freevm(p->pgdir);
801047b6:	5a                   	pop    %edx
801047b7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801047ba:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801047c1:	e8 ba 30 00 00       	call   80107880 <freevm>
        release(&ptable.lock);
801047c6:	c7 04 24 40 cd 14 80 	movl   $0x8014cd40,(%esp)
        p->pid = 0;
801047cd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801047d4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801047db:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801047df:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801047e6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801047ed:	e8 2e 07 00 00       	call   80104f20 <release>
        return pid;
801047f2:	83 c4 10             	add    $0x10,%esp
}
801047f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047f8:	89 f0                	mov    %esi,%eax
801047fa:	5b                   	pop    %ebx
801047fb:	5e                   	pop    %esi
801047fc:	5d                   	pop    %ebp
801047fd:	c3                   	ret    
      release(&ptable.lock);
801047fe:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104801:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104806:	68 40 cd 14 80       	push   $0x8014cd40
8010480b:	e8 10 07 00 00       	call   80104f20 <release>
      return -1;
80104810:	83 c4 10             	add    $0x10,%esp
80104813:	eb e0                	jmp    801047f5 <wait+0xd5>
80104815:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 10             	sub    $0x10,%esp
80104827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010482a:	68 40 cd 14 80       	push   $0x8014cd40
8010482f:	e8 2c 06 00 00       	call   80104e60 <acquire>
80104834:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104837:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
8010483c:	eb 0e                	jmp    8010484c <wakeup+0x2c>
8010483e:	66 90                	xchg   %ax,%ax
80104840:	05 58 03 00 00       	add    $0x358,%eax
80104845:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
8010484a:	73 1e                	jae    8010486a <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010484c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104850:	75 ee                	jne    80104840 <wakeup+0x20>
80104852:	3b 58 20             	cmp    0x20(%eax),%ebx
80104855:	75 e9                	jne    80104840 <wakeup+0x20>
      p->state = RUNNABLE;
80104857:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010485e:	05 58 03 00 00       	add    $0x358,%eax
80104863:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
80104868:	72 e2                	jb     8010484c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010486a:	c7 45 08 40 cd 14 80 	movl   $0x8014cd40,0x8(%ebp)
}
80104871:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104874:	c9                   	leave  
  release(&ptable.lock);
80104875:	e9 a6 06 00 00       	jmp    80104f20 <release>
8010487a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104880 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	53                   	push   %ebx
80104884:	83 ec 10             	sub    $0x10,%esp
80104887:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010488a:	68 40 cd 14 80       	push   $0x8014cd40
8010488f:	e8 cc 05 00 00       	call   80104e60 <acquire>
80104894:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104897:	b8 74 cd 14 80       	mov    $0x8014cd74,%eax
8010489c:	eb 0e                	jmp    801048ac <kill+0x2c>
8010489e:	66 90                	xchg   %ax,%ax
801048a0:	05 58 03 00 00       	add    $0x358,%eax
801048a5:	3d 74 a3 15 80       	cmp    $0x8015a374,%eax
801048aa:	73 34                	jae    801048e0 <kill+0x60>
    if(p->pid == pid){
801048ac:	39 58 10             	cmp    %ebx,0x10(%eax)
801048af:	75 ef                	jne    801048a0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801048b1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801048b5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801048bc:	75 07                	jne    801048c5 <kill+0x45>
        p->state = RUNNABLE;
801048be:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
801048c5:	83 ec 0c             	sub    $0xc,%esp
801048c8:	68 40 cd 14 80       	push   $0x8014cd40
801048cd:	e8 4e 06 00 00       	call   80104f20 <release>
      return 0;
801048d2:	83 c4 10             	add    $0x10,%esp
801048d5:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801048d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048da:	c9                   	leave  
801048db:	c3                   	ret    
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801048e0:	83 ec 0c             	sub    $0xc,%esp
801048e3:	68 40 cd 14 80       	push   $0x8014cd40
801048e8:	e8 33 06 00 00       	call   80104f20 <release>
  return -1;
801048ed:	83 c4 10             	add    $0x10,%esp
801048f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801048f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048f8:	c9                   	leave  
801048f9:	c3                   	ret    
801048fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104900 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	57                   	push   %edi
80104904:	56                   	push   %esi
80104905:	53                   	push   %ebx
80104906:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104909:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
8010490e:	83 ec 3c             	sub    $0x3c,%esp
80104911:	eb 27                	jmp    8010493a <procdump+0x3a>
80104913:	90                   	nop
80104914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104918:	83 ec 0c             	sub    $0xc,%esp
8010491b:	68 17 90 10 80       	push   $0x80109017
80104920:	e8 3b bd ff ff       	call   80100660 <cprintf>
80104925:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104928:	81 c3 58 03 00 00    	add    $0x358,%ebx
8010492e:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
80104934:	0f 83 a6 00 00 00    	jae    801049e0 <procdump+0xe0>
    if(p->state == UNUSED)
8010493a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010493d:	85 c0                	test   %eax,%eax
8010493f:	74 e7                	je     80104928 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104941:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104944:	ba 06 8b 10 80       	mov    $0x80108b06,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104949:	77 11                	ja     8010495c <procdump+0x5c>
8010494b:	8b 14 85 04 8c 10 80 	mov    -0x7fef73fc(,%eax,4),%edx
      state = "???";
80104952:	b8 06 8b 10 80       	mov    $0x80108b06,%eax
80104957:	85 d2                	test   %edx,%edx
80104959:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d allocated: %d   inPhysical: %d   swapped: %d   swappedOut: %d   %s %s", p->pid, p->allocatedInPhys, p->nPgsPhysical, p->nPgsSwap,p->nTotalPGout, state, p->name);
8010495c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010495f:	50                   	push   %eax
80104960:	52                   	push   %edx
80104961:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104967:	ff b3 84 00 00 00    	pushl  0x84(%ebx)
8010496d:	ff b3 80 00 00 00    	pushl  0x80(%ebx)
80104973:	ff b3 90 00 00 00    	pushl  0x90(%ebx)
80104979:	ff 73 10             	pushl  0x10(%ebx)
8010497c:	68 90 8b 10 80       	push   $0x80108b90
80104981:	e8 da bc ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104986:	83 c4 20             	add    $0x20,%esp
80104989:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
8010498d:	75 89                	jne    80104918 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010498f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104992:	83 ec 08             	sub    $0x8,%esp
80104995:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104998:	50                   	push   %eax
80104999:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010499c:	8b 40 0c             	mov    0xc(%eax),%eax
8010499f:	83 c0 08             	add    $0x8,%eax
801049a2:	50                   	push   %eax
801049a3:	e8 98 03 00 00       	call   80104d40 <getcallerpcs>
801049a8:	83 c4 10             	add    $0x10,%esp
801049ab:	90                   	nop
801049ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801049b0:	8b 17                	mov    (%edi),%edx
801049b2:	85 d2                	test   %edx,%edx
801049b4:	0f 84 5e ff ff ff    	je     80104918 <procdump+0x18>
        cprintf(" %p", pc[i]);
801049ba:	83 ec 08             	sub    $0x8,%esp
801049bd:	83 c7 04             	add    $0x4,%edi
801049c0:	52                   	push   %edx
801049c1:	68 a1 84 10 80       	push   $0x801084a1
801049c6:	e8 95 bc ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801049cb:	83 c4 10             	add    $0x10,%esp
801049ce:	39 fe                	cmp    %edi,%esi
801049d0:	75 de                	jne    801049b0 <procdump+0xb0>
801049d2:	e9 41 ff ff ff       	jmp    80104918 <procdump+0x18>
801049d7:	89 f6                	mov    %esi,%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
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
80104a03:	e8 58 04 00 00       	call   80104e60 <acquire>
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
80104a25:	8d 9e e0 01 00 00    	lea    0x1e0(%esi),%ebx
80104a2b:	8d be 60 03 00 00    	lea    0x360(%esi),%edi
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
80104a88:	68 0a 8b 10 80       	push   $0x80108b0a
80104a8d:	e8 ce bb ff ff       	call   80100660 <cprintf>
        continue;
80104a92:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104a95:	39 df                	cmp    %ebx,%edi
80104a97:	75 d1                	jne    80104a6a <nfuaTickUpdate+0x7a>
80104a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa0:	81 c6 58 03 00 00    	add    $0x358,%esi
80104aa6:	81 fe 74 a3 15 80    	cmp    $0x8015a374,%esi
80104aac:	0f 82 5e ff ff ff    	jb     80104a10 <nfuaTickUpdate+0x20>
      }
    }
  }
  release(&ptable.lock);
80104ab2:	83 ec 0c             	sub    $0xc,%esp
80104ab5:	68 40 cd 14 80       	push   $0x8014cd40
80104aba:	e8 61 04 00 00       	call   80104f20 <release>
}
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
80104ad3:	68 28 8b 10 80       	push   $0x80108b28
80104ad8:	e8 83 bb ff ff       	call   80100660 <cprintf>
        continue;
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	eb 81                	jmp    80104a63 <nfuaTickUpdate+0x73>
80104ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <singleProcDump>:

void
singleProcDump(int pid)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	56                   	push   %esi
80104af4:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];
  
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104af5:	bb 74 cd 14 80       	mov    $0x8014cd74,%ebx
{
80104afa:	83 ec 30             	sub    $0x30,%esp
80104afd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if(p->pid != pid)
80104b00:	8b 43 10             	mov    0x10(%ebx),%eax
80104b03:	39 c8                	cmp    %ecx,%eax
80104b05:	75 59                	jne    80104b60 <singleProcDump+0x70>
      continue;
    if(p->state == UNUSED)
80104b07:	8b 53 0c             	mov    0xc(%ebx),%edx
80104b0a:	85 d2                	test   %edx,%edx
80104b0c:	74 52                	je     80104b60 <singleProcDump+0x70>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b0e:	83 fa 05             	cmp    $0x5,%edx
      state = states[p->state];
    else
      state = "???";
80104b11:	b9 06 8b 10 80       	mov    $0x80108b06,%ecx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b16:	76 70                	jbe    80104b88 <singleProcDump+0x98>
    cprintf("%d allocated: %d   inPhysical: %d   swapped: %d   swappedOut: %d   %s %s", p->pid, p->allocatedInPhys, p->nPgsPhysical, p->nPgsSwap,p->nTotalPGout, state, p->name);
80104b18:	8d 53 6c             	lea    0x6c(%ebx),%edx
80104b1b:	52                   	push   %edx
80104b1c:	51                   	push   %ecx
80104b1d:	ff b3 88 00 00 00    	pushl  0x88(%ebx)
80104b23:	ff b3 84 00 00 00    	pushl  0x84(%ebx)
80104b29:	ff b3 80 00 00 00    	pushl  0x80(%ebx)
80104b2f:	ff b3 90 00 00 00    	pushl  0x90(%ebx)
80104b35:	50                   	push   %eax
80104b36:	68 90 8b 10 80       	push   $0x80108b90
80104b3b:	e8 20 bb ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104b40:	83 c4 20             	add    $0x20,%esp
80104b43:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104b47:	74 57                	je     80104ba0 <singleProcDump+0xb0>
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b49:	83 ec 0c             	sub    $0xc,%esp
80104b4c:	68 17 90 10 80       	push   $0x80109017
80104b51:	e8 0a bb ff ff       	call   80100660 <cprintf>
    return;
80104b56:	83 c4 10             	add    $0x10,%esp
  }
  cprintf("Error: ProcDump could not find pid %d\n",pid);
80104b59:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b5c:	5b                   	pop    %ebx
80104b5d:	5e                   	pop    %esi
80104b5e:	5d                   	pop    %ebp
80104b5f:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b60:	81 c3 58 03 00 00    	add    $0x358,%ebx
80104b66:	81 fb 74 a3 15 80    	cmp    $0x8015a374,%ebx
80104b6c:	72 92                	jb     80104b00 <singleProcDump+0x10>
  cprintf("Error: ProcDump could not find pid %d\n",pid);
80104b6e:	83 ec 08             	sub    $0x8,%esp
80104b71:	51                   	push   %ecx
80104b72:	68 dc 8b 10 80       	push   $0x80108bdc
80104b77:	e8 e4 ba ff ff       	call   80100660 <cprintf>
80104b7c:	83 c4 10             	add    $0x10,%esp
80104b7f:	eb d8                	jmp    80104b59 <singleProcDump+0x69>
80104b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b88:	8b 0c 95 04 8c 10 80 	mov    -0x7fef73fc(,%edx,4),%ecx
      state = "???";
80104b8f:	ba 06 8b 10 80       	mov    $0x80108b06,%edx
80104b94:	85 c9                	test   %ecx,%ecx
80104b96:	0f 44 ca             	cmove  %edx,%ecx
80104b99:	e9 7a ff ff ff       	jmp    80104b18 <singleProcDump+0x28>
80104b9e:	66 90                	xchg   %ax,%ax
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ba0:	8d 75 d0             	lea    -0x30(%ebp),%esi
80104ba3:	83 ec 08             	sub    $0x8,%esp
80104ba6:	56                   	push   %esi
80104ba7:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104baa:	89 f3                	mov    %esi,%ebx
80104bac:	8d 75 f8             	lea    -0x8(%ebp),%esi
80104baf:	8b 40 0c             	mov    0xc(%eax),%eax
80104bb2:	83 c0 08             	add    $0x8,%eax
80104bb5:	50                   	push   %eax
80104bb6:	e8 85 01 00 00       	call   80104d40 <getcallerpcs>
80104bbb:	83 c4 10             	add    $0x10,%esp
80104bbe:	66 90                	xchg   %ax,%ax
      for(i=0; i<10 && pc[i] != 0; i++)
80104bc0:	8b 03                	mov    (%ebx),%eax
80104bc2:	85 c0                	test   %eax,%eax
80104bc4:	74 83                	je     80104b49 <singleProcDump+0x59>
        cprintf(" %p", pc[i]);
80104bc6:	83 ec 08             	sub    $0x8,%esp
80104bc9:	83 c3 04             	add    $0x4,%ebx
80104bcc:	50                   	push   %eax
80104bcd:	68 a1 84 10 80       	push   $0x801084a1
80104bd2:	e8 89 ba ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104bd7:	83 c4 10             	add    $0x10,%esp
80104bda:	39 de                	cmp    %ebx,%esi
80104bdc:	75 e2                	jne    80104bc0 <singleProcDump+0xd0>
80104bde:	e9 66 ff ff ff       	jmp    80104b49 <singleProcDump+0x59>
80104be3:	66 90                	xchg   %ax,%ax
80104be5:	66 90                	xchg   %ax,%ax
80104be7:	66 90                	xchg   %ax,%ax
80104be9:	66 90                	xchg   %ax,%ax
80104beb:	66 90                	xchg   %ax,%ax
80104bed:	66 90                	xchg   %ax,%ax
80104bef:	90                   	nop

80104bf0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	53                   	push   %ebx
80104bf4:	83 ec 0c             	sub    $0xc,%esp
80104bf7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104bfa:	68 1c 8c 10 80       	push   $0x80108c1c
80104bff:	8d 43 04             	lea    0x4(%ebx),%eax
80104c02:	50                   	push   %eax
80104c03:	e8 18 01 00 00       	call   80104d20 <initlock>
  lk->name = name;
80104c08:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104c0b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104c11:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104c14:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104c1b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104c1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c21:	c9                   	leave  
80104c22:	c3                   	ret    
80104c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	56                   	push   %esi
80104c34:	53                   	push   %ebx
80104c35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104c38:	83 ec 0c             	sub    $0xc,%esp
80104c3b:	8d 73 04             	lea    0x4(%ebx),%esi
80104c3e:	56                   	push   %esi
80104c3f:	e8 1c 02 00 00       	call   80104e60 <acquire>
  while (lk->locked) {
80104c44:	8b 13                	mov    (%ebx),%edx
80104c46:	83 c4 10             	add    $0x10,%esp
80104c49:	85 d2                	test   %edx,%edx
80104c4b:	74 16                	je     80104c63 <acquiresleep+0x33>
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104c50:	83 ec 08             	sub    $0x8,%esp
80104c53:	56                   	push   %esi
80104c54:	53                   	push   %ebx
80104c55:	e8 06 fa ff ff       	call   80104660 <sleep>
  while (lk->locked) {
80104c5a:	8b 03                	mov    (%ebx),%eax
80104c5c:	83 c4 10             	add    $0x10,%esp
80104c5f:	85 c0                	test   %eax,%eax
80104c61:	75 ed                	jne    80104c50 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104c63:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104c69:	e8 f2 f2 ff ff       	call   80103f60 <myproc>
80104c6e:	8b 40 10             	mov    0x10(%eax),%eax
80104c71:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104c74:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104c77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c7a:	5b                   	pop    %ebx
80104c7b:	5e                   	pop    %esi
80104c7c:	5d                   	pop    %ebp
  release(&lk->lk);
80104c7d:	e9 9e 02 00 00       	jmp    80104f20 <release>
80104c82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c90 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
80104c95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104c98:	83 ec 0c             	sub    $0xc,%esp
80104c9b:	8d 73 04             	lea    0x4(%ebx),%esi
80104c9e:	56                   	push   %esi
80104c9f:	e8 bc 01 00 00       	call   80104e60 <acquire>
  lk->locked = 0;
80104ca4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104caa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104cb1:	89 1c 24             	mov    %ebx,(%esp)
80104cb4:	e8 67 fb ff ff       	call   80104820 <wakeup>
  release(&lk->lk);
80104cb9:	89 75 08             	mov    %esi,0x8(%ebp)
80104cbc:	83 c4 10             	add    $0x10,%esp
}
80104cbf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cc2:	5b                   	pop    %ebx
80104cc3:	5e                   	pop    %esi
80104cc4:	5d                   	pop    %ebp
  release(&lk->lk);
80104cc5:	e9 56 02 00 00       	jmp    80104f20 <release>
80104cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cd0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104cd0:	55                   	push   %ebp
80104cd1:	89 e5                	mov    %esp,%ebp
80104cd3:	57                   	push   %edi
80104cd4:	56                   	push   %esi
80104cd5:	53                   	push   %ebx
80104cd6:	31 ff                	xor    %edi,%edi
80104cd8:	83 ec 18             	sub    $0x18,%esp
80104cdb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104cde:	8d 73 04             	lea    0x4(%ebx),%esi
80104ce1:	56                   	push   %esi
80104ce2:	e8 79 01 00 00       	call   80104e60 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ce7:	8b 03                	mov    (%ebx),%eax
80104ce9:	83 c4 10             	add    $0x10,%esp
80104cec:	85 c0                	test   %eax,%eax
80104cee:	74 13                	je     80104d03 <holdingsleep+0x33>
80104cf0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104cf3:	e8 68 f2 ff ff       	call   80103f60 <myproc>
80104cf8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104cfb:	0f 94 c0             	sete   %al
80104cfe:	0f b6 c0             	movzbl %al,%eax
80104d01:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104d03:	83 ec 0c             	sub    $0xc,%esp
80104d06:	56                   	push   %esi
80104d07:	e8 14 02 00 00       	call   80104f20 <release>
  return r;
}
80104d0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d0f:	89 f8                	mov    %edi,%eax
80104d11:	5b                   	pop    %ebx
80104d12:	5e                   	pop    %esi
80104d13:	5f                   	pop    %edi
80104d14:	5d                   	pop    %ebp
80104d15:	c3                   	ret    
80104d16:	66 90                	xchg   %ax,%ax
80104d18:	66 90                	xchg   %ax,%ax
80104d1a:	66 90                	xchg   %ax,%ax
80104d1c:	66 90                	xchg   %ax,%ax
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104d26:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104d29:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104d2f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104d32:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104d39:	5d                   	pop    %ebp
80104d3a:	c3                   	ret    
80104d3b:	90                   	nop
80104d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104d40:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104d41:	31 d2                	xor    %edx,%edx
{
80104d43:	89 e5                	mov    %esp,%ebp
80104d45:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104d46:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104d49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104d4c:	83 e8 08             	sub    $0x8,%eax
80104d4f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104d50:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104d56:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104d5c:	77 1a                	ja     80104d78 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104d5e:	8b 58 04             	mov    0x4(%eax),%ebx
80104d61:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104d64:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104d67:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104d69:	83 fa 0a             	cmp    $0xa,%edx
80104d6c:	75 e2                	jne    80104d50 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104d6e:	5b                   	pop    %ebx
80104d6f:	5d                   	pop    %ebp
80104d70:	c3                   	ret    
80104d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d78:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104d7b:	83 c1 28             	add    $0x28,%ecx
80104d7e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104d80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104d86:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104d89:	39 c1                	cmp    %eax,%ecx
80104d8b:	75 f3                	jne    80104d80 <getcallerpcs+0x40>
}
80104d8d:	5b                   	pop    %ebx
80104d8e:	5d                   	pop    %ebp
80104d8f:	c3                   	ret    

80104d90 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	53                   	push   %ebx
80104d94:	83 ec 04             	sub    $0x4,%esp
80104d97:	9c                   	pushf  
80104d98:	5b                   	pop    %ebx
  asm volatile("cli");
80104d99:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104d9a:	e8 21 f1 ff ff       	call   80103ec0 <mycpu>
80104d9f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104da5:	85 c0                	test   %eax,%eax
80104da7:	75 11                	jne    80104dba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104da9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104daf:	e8 0c f1 ff ff       	call   80103ec0 <mycpu>
80104db4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104dba:	e8 01 f1 ff ff       	call   80103ec0 <mycpu>
80104dbf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104dc6:	83 c4 04             	add    $0x4,%esp
80104dc9:	5b                   	pop    %ebx
80104dca:	5d                   	pop    %ebp
80104dcb:	c3                   	ret    
80104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104dd0 <popcli>:

void
popcli(void)
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104dd6:	9c                   	pushf  
80104dd7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104dd8:	f6 c4 02             	test   $0x2,%ah
80104ddb:	75 35                	jne    80104e12 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104ddd:	e8 de f0 ff ff       	call   80103ec0 <mycpu>
80104de2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104de9:	78 34                	js     80104e1f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104deb:	e8 d0 f0 ff ff       	call   80103ec0 <mycpu>
80104df0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104df6:	85 d2                	test   %edx,%edx
80104df8:	74 06                	je     80104e00 <popcli+0x30>
    sti();
}
80104dfa:	c9                   	leave  
80104dfb:	c3                   	ret    
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104e00:	e8 bb f0 ff ff       	call   80103ec0 <mycpu>
80104e05:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104e0b:	85 c0                	test   %eax,%eax
80104e0d:	74 eb                	je     80104dfa <popcli+0x2a>
  asm volatile("sti");
80104e0f:	fb                   	sti    
}
80104e10:	c9                   	leave  
80104e11:	c3                   	ret    
    panic("popcli - interruptible");
80104e12:	83 ec 0c             	sub    $0xc,%esp
80104e15:	68 27 8c 10 80       	push   $0x80108c27
80104e1a:	e8 71 b5 ff ff       	call   80100390 <panic>
    panic("popcli");
80104e1f:	83 ec 0c             	sub    $0xc,%esp
80104e22:	68 3e 8c 10 80       	push   $0x80108c3e
80104e27:	e8 64 b5 ff ff       	call   80100390 <panic>
80104e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e30 <holding>:
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
80104e35:	8b 75 08             	mov    0x8(%ebp),%esi
80104e38:	31 db                	xor    %ebx,%ebx
  pushcli();
80104e3a:	e8 51 ff ff ff       	call   80104d90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104e3f:	8b 06                	mov    (%esi),%eax
80104e41:	85 c0                	test   %eax,%eax
80104e43:	74 10                	je     80104e55 <holding+0x25>
80104e45:	8b 5e 08             	mov    0x8(%esi),%ebx
80104e48:	e8 73 f0 ff ff       	call   80103ec0 <mycpu>
80104e4d:	39 c3                	cmp    %eax,%ebx
80104e4f:	0f 94 c3             	sete   %bl
80104e52:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104e55:	e8 76 ff ff ff       	call   80104dd0 <popcli>
}
80104e5a:	89 d8                	mov    %ebx,%eax
80104e5c:	5b                   	pop    %ebx
80104e5d:	5e                   	pop    %esi
80104e5e:	5d                   	pop    %ebp
80104e5f:	c3                   	ret    

80104e60 <acquire>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104e65:	e8 26 ff ff ff       	call   80104d90 <pushcli>
  if(holding(lk))
80104e6a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e6d:	83 ec 0c             	sub    $0xc,%esp
80104e70:	53                   	push   %ebx
80104e71:	e8 ba ff ff ff       	call   80104e30 <holding>
80104e76:	83 c4 10             	add    $0x10,%esp
80104e79:	85 c0                	test   %eax,%eax
80104e7b:	0f 85 83 00 00 00    	jne    80104f04 <acquire+0xa4>
80104e81:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104e83:	ba 01 00 00 00       	mov    $0x1,%edx
80104e88:	eb 09                	jmp    80104e93 <acquire+0x33>
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e90:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e93:	89 d0                	mov    %edx,%eax
80104e95:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104e98:	85 c0                	test   %eax,%eax
80104e9a:	75 f4                	jne    80104e90 <acquire+0x30>
  __sync_synchronize();
80104e9c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ea1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ea4:	e8 17 f0 ff ff       	call   80103ec0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104ea9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104eac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104eaf:	89 e8                	mov    %ebp,%eax
80104eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104eb8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104ebe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104ec4:	77 1a                	ja     80104ee0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104ec6:	8b 48 04             	mov    0x4(%eax),%ecx
80104ec9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104ecc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104ecf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ed1:	83 fe 0a             	cmp    $0xa,%esi
80104ed4:	75 e2                	jne    80104eb8 <acquire+0x58>
}
80104ed6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ed9:	5b                   	pop    %ebx
80104eda:	5e                   	pop    %esi
80104edb:	5d                   	pop    %ebp
80104edc:	c3                   	ret    
80104edd:	8d 76 00             	lea    0x0(%esi),%esi
80104ee0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104ee3:	83 c2 28             	add    $0x28,%edx
80104ee6:	8d 76 00             	lea    0x0(%esi),%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104ef0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ef6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104ef9:	39 d0                	cmp    %edx,%eax
80104efb:	75 f3                	jne    80104ef0 <acquire+0x90>
}
80104efd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f00:	5b                   	pop    %ebx
80104f01:	5e                   	pop    %esi
80104f02:	5d                   	pop    %ebp
80104f03:	c3                   	ret    
    panic("acquire");
80104f04:	83 ec 0c             	sub    $0xc,%esp
80104f07:	68 45 8c 10 80       	push   $0x80108c45
80104f0c:	e8 7f b4 ff ff       	call   80100390 <panic>
80104f11:	eb 0d                	jmp    80104f20 <release>
80104f13:	90                   	nop
80104f14:	90                   	nop
80104f15:	90                   	nop
80104f16:	90                   	nop
80104f17:	90                   	nop
80104f18:	90                   	nop
80104f19:	90                   	nop
80104f1a:	90                   	nop
80104f1b:	90                   	nop
80104f1c:	90                   	nop
80104f1d:	90                   	nop
80104f1e:	90                   	nop
80104f1f:	90                   	nop

80104f20 <release>:
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	53                   	push   %ebx
80104f24:	83 ec 10             	sub    $0x10,%esp
80104f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104f2a:	53                   	push   %ebx
80104f2b:	e8 00 ff ff ff       	call   80104e30 <holding>
80104f30:	83 c4 10             	add    $0x10,%esp
80104f33:	85 c0                	test   %eax,%eax
80104f35:	74 22                	je     80104f59 <release+0x39>
  lk->pcs[0] = 0;
80104f37:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104f3e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104f45:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104f4a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104f50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f53:	c9                   	leave  
  popcli();
80104f54:	e9 77 fe ff ff       	jmp    80104dd0 <popcli>
    panic("release");
80104f59:	83 ec 0c             	sub    $0xc,%esp
80104f5c:	68 4d 8c 10 80       	push   $0x80108c4d
80104f61:	e8 2a b4 ff ff       	call   80100390 <panic>
80104f66:	66 90                	xchg   %ax,%ax
80104f68:	66 90                	xchg   %ax,%ax
80104f6a:	66 90                	xchg   %ax,%ax
80104f6c:	66 90                	xchg   %ax,%ax
80104f6e:	66 90                	xchg   %ax,%ax

80104f70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	57                   	push   %edi
80104f74:	53                   	push   %ebx
80104f75:	8b 55 08             	mov    0x8(%ebp),%edx
80104f78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104f7b:	f6 c2 03             	test   $0x3,%dl
80104f7e:	75 05                	jne    80104f85 <memset+0x15>
80104f80:	f6 c1 03             	test   $0x3,%cl
80104f83:	74 13                	je     80104f98 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104f85:	89 d7                	mov    %edx,%edi
80104f87:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f8a:	fc                   	cld    
80104f8b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104f8d:	5b                   	pop    %ebx
80104f8e:	89 d0                	mov    %edx,%eax
80104f90:	5f                   	pop    %edi
80104f91:	5d                   	pop    %ebp
80104f92:	c3                   	ret    
80104f93:	90                   	nop
80104f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104f98:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104f9c:	c1 e9 02             	shr    $0x2,%ecx
80104f9f:	89 f8                	mov    %edi,%eax
80104fa1:	89 fb                	mov    %edi,%ebx
80104fa3:	c1 e0 18             	shl    $0x18,%eax
80104fa6:	c1 e3 10             	shl    $0x10,%ebx
80104fa9:	09 d8                	or     %ebx,%eax
80104fab:	09 f8                	or     %edi,%eax
80104fad:	c1 e7 08             	shl    $0x8,%edi
80104fb0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104fb2:	89 d7                	mov    %edx,%edi
80104fb4:	fc                   	cld    
80104fb5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104fb7:	5b                   	pop    %ebx
80104fb8:	89 d0                	mov    %edx,%eax
80104fba:	5f                   	pop    %edi
80104fbb:	5d                   	pop    %ebp
80104fbc:	c3                   	ret    
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi

80104fc0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	56                   	push   %esi
80104fc5:	53                   	push   %ebx
80104fc6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104fc9:	8b 75 08             	mov    0x8(%ebp),%esi
80104fcc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104fcf:	85 db                	test   %ebx,%ebx
80104fd1:	74 29                	je     80104ffc <memcmp+0x3c>
    if(*s1 != *s2)
80104fd3:	0f b6 16             	movzbl (%esi),%edx
80104fd6:	0f b6 0f             	movzbl (%edi),%ecx
80104fd9:	38 d1                	cmp    %dl,%cl
80104fdb:	75 2b                	jne    80105008 <memcmp+0x48>
80104fdd:	b8 01 00 00 00       	mov    $0x1,%eax
80104fe2:	eb 14                	jmp    80104ff8 <memcmp+0x38>
80104fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fe8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104fec:	83 c0 01             	add    $0x1,%eax
80104fef:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104ff4:	38 ca                	cmp    %cl,%dl
80104ff6:	75 10                	jne    80105008 <memcmp+0x48>
  while(n-- > 0){
80104ff8:	39 d8                	cmp    %ebx,%eax
80104ffa:	75 ec                	jne    80104fe8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104ffc:	5b                   	pop    %ebx
  return 0;
80104ffd:	31 c0                	xor    %eax,%eax
}
80104fff:	5e                   	pop    %esi
80105000:	5f                   	pop    %edi
80105001:	5d                   	pop    %ebp
80105002:	c3                   	ret    
80105003:	90                   	nop
80105004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80105008:	0f b6 c2             	movzbl %dl,%eax
}
8010500b:	5b                   	pop    %ebx
      return *s1 - *s2;
8010500c:	29 c8                	sub    %ecx,%eax
}
8010500e:	5e                   	pop    %esi
8010500f:	5f                   	pop    %edi
80105010:	5d                   	pop    %ebp
80105011:	c3                   	ret    
80105012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105020 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	56                   	push   %esi
80105024:	53                   	push   %ebx
80105025:	8b 45 08             	mov    0x8(%ebp),%eax
80105028:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010502b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010502e:	39 c3                	cmp    %eax,%ebx
80105030:	73 26                	jae    80105058 <memmove+0x38>
80105032:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80105035:	39 c8                	cmp    %ecx,%eax
80105037:	73 1f                	jae    80105058 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105039:	85 f6                	test   %esi,%esi
8010503b:	8d 56 ff             	lea    -0x1(%esi),%edx
8010503e:	74 0f                	je     8010504f <memmove+0x2f>
      *--d = *--s;
80105040:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105044:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80105047:	83 ea 01             	sub    $0x1,%edx
8010504a:	83 fa ff             	cmp    $0xffffffff,%edx
8010504d:	75 f1                	jne    80105040 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010504f:	5b                   	pop    %ebx
80105050:	5e                   	pop    %esi
80105051:	5d                   	pop    %ebp
80105052:	c3                   	ret    
80105053:	90                   	nop
80105054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80105058:	31 d2                	xor    %edx,%edx
8010505a:	85 f6                	test   %esi,%esi
8010505c:	74 f1                	je     8010504f <memmove+0x2f>
8010505e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105060:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105064:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105067:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
8010506a:	39 d6                	cmp    %edx,%esi
8010506c:	75 f2                	jne    80105060 <memmove+0x40>
}
8010506e:	5b                   	pop    %ebx
8010506f:	5e                   	pop    %esi
80105070:	5d                   	pop    %ebp
80105071:	c3                   	ret    
80105072:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105080 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105083:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80105084:	eb 9a                	jmp    80105020 <memmove>
80105086:	8d 76 00             	lea    0x0(%esi),%esi
80105089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105090 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105090:	55                   	push   %ebp
80105091:	89 e5                	mov    %esp,%ebp
80105093:	57                   	push   %edi
80105094:	56                   	push   %esi
80105095:	8b 7d 10             	mov    0x10(%ebp),%edi
80105098:	53                   	push   %ebx
80105099:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010509c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010509f:	85 ff                	test   %edi,%edi
801050a1:	74 2f                	je     801050d2 <strncmp+0x42>
801050a3:	0f b6 01             	movzbl (%ecx),%eax
801050a6:	0f b6 1e             	movzbl (%esi),%ebx
801050a9:	84 c0                	test   %al,%al
801050ab:	74 37                	je     801050e4 <strncmp+0x54>
801050ad:	38 c3                	cmp    %al,%bl
801050af:	75 33                	jne    801050e4 <strncmp+0x54>
801050b1:	01 f7                	add    %esi,%edi
801050b3:	eb 13                	jmp    801050c8 <strncmp+0x38>
801050b5:	8d 76 00             	lea    0x0(%esi),%esi
801050b8:	0f b6 01             	movzbl (%ecx),%eax
801050bb:	84 c0                	test   %al,%al
801050bd:	74 21                	je     801050e0 <strncmp+0x50>
801050bf:	0f b6 1a             	movzbl (%edx),%ebx
801050c2:	89 d6                	mov    %edx,%esi
801050c4:	38 d8                	cmp    %bl,%al
801050c6:	75 1c                	jne    801050e4 <strncmp+0x54>
    n--, p++, q++;
801050c8:	8d 56 01             	lea    0x1(%esi),%edx
801050cb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801050ce:	39 fa                	cmp    %edi,%edx
801050d0:	75 e6                	jne    801050b8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
801050d2:	5b                   	pop    %ebx
    return 0;
801050d3:	31 c0                	xor    %eax,%eax
}
801050d5:	5e                   	pop    %esi
801050d6:	5f                   	pop    %edi
801050d7:	5d                   	pop    %ebp
801050d8:	c3                   	ret    
801050d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050e0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
801050e4:	29 d8                	sub    %ebx,%eax
}
801050e6:	5b                   	pop    %ebx
801050e7:	5e                   	pop    %esi
801050e8:	5f                   	pop    %edi
801050e9:	5d                   	pop    %ebp
801050ea:	c3                   	ret    
801050eb:	90                   	nop
801050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050f0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801050f0:	55                   	push   %ebp
801050f1:	89 e5                	mov    %esp,%ebp
801050f3:	56                   	push   %esi
801050f4:	53                   	push   %ebx
801050f5:	8b 45 08             	mov    0x8(%ebp),%eax
801050f8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801050fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801050fe:	89 c2                	mov    %eax,%edx
80105100:	eb 19                	jmp    8010511b <strncpy+0x2b>
80105102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105108:	83 c3 01             	add    $0x1,%ebx
8010510b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010510f:	83 c2 01             	add    $0x1,%edx
80105112:	84 c9                	test   %cl,%cl
80105114:	88 4a ff             	mov    %cl,-0x1(%edx)
80105117:	74 09                	je     80105122 <strncpy+0x32>
80105119:	89 f1                	mov    %esi,%ecx
8010511b:	85 c9                	test   %ecx,%ecx
8010511d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80105120:	7f e6                	jg     80105108 <strncpy+0x18>
    ;
  while(n-- > 0)
80105122:	31 c9                	xor    %ecx,%ecx
80105124:	85 f6                	test   %esi,%esi
80105126:	7e 17                	jle    8010513f <strncpy+0x4f>
80105128:	90                   	nop
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105130:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105134:	89 f3                	mov    %esi,%ebx
80105136:	83 c1 01             	add    $0x1,%ecx
80105139:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
8010513b:	85 db                	test   %ebx,%ebx
8010513d:	7f f1                	jg     80105130 <strncpy+0x40>
  return os;
}
8010513f:	5b                   	pop    %ebx
80105140:	5e                   	pop    %esi
80105141:	5d                   	pop    %ebp
80105142:	c3                   	ret    
80105143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105150 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	56                   	push   %esi
80105154:	53                   	push   %ebx
80105155:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105158:	8b 45 08             	mov    0x8(%ebp),%eax
8010515b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010515e:	85 c9                	test   %ecx,%ecx
80105160:	7e 26                	jle    80105188 <safestrcpy+0x38>
80105162:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105166:	89 c1                	mov    %eax,%ecx
80105168:	eb 17                	jmp    80105181 <safestrcpy+0x31>
8010516a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105170:	83 c2 01             	add    $0x1,%edx
80105173:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105177:	83 c1 01             	add    $0x1,%ecx
8010517a:	84 db                	test   %bl,%bl
8010517c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010517f:	74 04                	je     80105185 <safestrcpy+0x35>
80105181:	39 f2                	cmp    %esi,%edx
80105183:	75 eb                	jne    80105170 <safestrcpy+0x20>
    ;
  *s = 0;
80105185:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105188:	5b                   	pop    %ebx
80105189:	5e                   	pop    %esi
8010518a:	5d                   	pop    %ebp
8010518b:	c3                   	ret    
8010518c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105190 <strlen>:

int
strlen(const char *s)
{
80105190:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105191:	31 c0                	xor    %eax,%eax
{
80105193:	89 e5                	mov    %esp,%ebp
80105195:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80105198:	80 3a 00             	cmpb   $0x0,(%edx)
8010519b:	74 0c                	je     801051a9 <strlen+0x19>
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
801051a0:	83 c0 01             	add    $0x1,%eax
801051a3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801051a7:	75 f7                	jne    801051a0 <strlen+0x10>
    ;
  return n;
}
801051a9:	5d                   	pop    %ebp
801051aa:	c3                   	ret    

801051ab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801051ab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801051af:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801051b3:	55                   	push   %ebp
  pushl %ebx
801051b4:	53                   	push   %ebx
  pushl %esi
801051b5:	56                   	push   %esi
  pushl %edi
801051b6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801051b7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801051b9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801051bb:	5f                   	pop    %edi
  popl %esi
801051bc:	5e                   	pop    %esi
  popl %ebx
801051bd:	5b                   	pop    %ebx
  popl %ebp
801051be:	5d                   	pop    %ebp
  ret
801051bf:	c3                   	ret    

801051c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	53                   	push   %ebx
801051c4:	83 ec 04             	sub    $0x4,%esp
801051c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801051ca:	e8 91 ed ff ff       	call   80103f60 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801051cf:	8b 00                	mov    (%eax),%eax
801051d1:	39 d8                	cmp    %ebx,%eax
801051d3:	76 1b                	jbe    801051f0 <fetchint+0x30>
801051d5:	8d 53 04             	lea    0x4(%ebx),%edx
801051d8:	39 d0                	cmp    %edx,%eax
801051da:	72 14                	jb     801051f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801051dc:	8b 45 0c             	mov    0xc(%ebp),%eax
801051df:	8b 13                	mov    (%ebx),%edx
801051e1:	89 10                	mov    %edx,(%eax)
  return 0;
801051e3:	31 c0                	xor    %eax,%eax
}
801051e5:	83 c4 04             	add    $0x4,%esp
801051e8:	5b                   	pop    %ebx
801051e9:	5d                   	pop    %ebp
801051ea:	c3                   	ret    
801051eb:	90                   	nop
801051ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801051f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051f5:	eb ee                	jmp    801051e5 <fetchint+0x25>
801051f7:	89 f6                	mov    %esi,%esi
801051f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105200 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105200:	55                   	push   %ebp
80105201:	89 e5                	mov    %esp,%ebp
80105203:	53                   	push   %ebx
80105204:	83 ec 04             	sub    $0x4,%esp
80105207:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010520a:	e8 51 ed ff ff       	call   80103f60 <myproc>

  if(addr >= curproc->sz)
8010520f:	39 18                	cmp    %ebx,(%eax)
80105211:	76 29                	jbe    8010523c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105213:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105216:	89 da                	mov    %ebx,%edx
80105218:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010521a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010521c:	39 c3                	cmp    %eax,%ebx
8010521e:	73 1c                	jae    8010523c <fetchstr+0x3c>
    if(*s == 0)
80105220:	80 3b 00             	cmpb   $0x0,(%ebx)
80105223:	75 10                	jne    80105235 <fetchstr+0x35>
80105225:	eb 39                	jmp    80105260 <fetchstr+0x60>
80105227:	89 f6                	mov    %esi,%esi
80105229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105230:	80 3a 00             	cmpb   $0x0,(%edx)
80105233:	74 1b                	je     80105250 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105235:	83 c2 01             	add    $0x1,%edx
80105238:	39 d0                	cmp    %edx,%eax
8010523a:	77 f4                	ja     80105230 <fetchstr+0x30>
    return -1;
8010523c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105241:	83 c4 04             	add    $0x4,%esp
80105244:	5b                   	pop    %ebx
80105245:	5d                   	pop    %ebp
80105246:	c3                   	ret    
80105247:	89 f6                	mov    %esi,%esi
80105249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105250:	83 c4 04             	add    $0x4,%esp
80105253:	89 d0                	mov    %edx,%eax
80105255:	29 d8                	sub    %ebx,%eax
80105257:	5b                   	pop    %ebx
80105258:	5d                   	pop    %ebp
80105259:	c3                   	ret    
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105260:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105262:	eb dd                	jmp    80105241 <fetchstr+0x41>
80105264:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010526a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105270 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	56                   	push   %esi
80105274:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105275:	e8 e6 ec ff ff       	call   80103f60 <myproc>
8010527a:	8b 40 18             	mov    0x18(%eax),%eax
8010527d:	8b 55 08             	mov    0x8(%ebp),%edx
80105280:	8b 40 44             	mov    0x44(%eax),%eax
80105283:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105286:	e8 d5 ec ff ff       	call   80103f60 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010528b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010528d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105290:	39 c6                	cmp    %eax,%esi
80105292:	73 1c                	jae    801052b0 <argint+0x40>
80105294:	8d 53 08             	lea    0x8(%ebx),%edx
80105297:	39 d0                	cmp    %edx,%eax
80105299:	72 15                	jb     801052b0 <argint+0x40>
  *ip = *(int*)(addr);
8010529b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010529e:	8b 53 04             	mov    0x4(%ebx),%edx
801052a1:	89 10                	mov    %edx,(%eax)
  return 0;
801052a3:	31 c0                	xor    %eax,%eax
}
801052a5:	5b                   	pop    %ebx
801052a6:	5e                   	pop    %esi
801052a7:	5d                   	pop    %ebp
801052a8:	c3                   	ret    
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801052b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801052b5:	eb ee                	jmp    801052a5 <argint+0x35>
801052b7:	89 f6                	mov    %esi,%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	53                   	push   %ebx
801052c5:	83 ec 10             	sub    $0x10,%esp
801052c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801052cb:	e8 90 ec ff ff       	call   80103f60 <myproc>
801052d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801052d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052d5:	83 ec 08             	sub    $0x8,%esp
801052d8:	50                   	push   %eax
801052d9:	ff 75 08             	pushl  0x8(%ebp)
801052dc:	e8 8f ff ff ff       	call   80105270 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801052e1:	83 c4 10             	add    $0x10,%esp
801052e4:	85 c0                	test   %eax,%eax
801052e6:	78 28                	js     80105310 <argptr+0x50>
801052e8:	85 db                	test   %ebx,%ebx
801052ea:	78 24                	js     80105310 <argptr+0x50>
801052ec:	8b 16                	mov    (%esi),%edx
801052ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052f1:	39 c2                	cmp    %eax,%edx
801052f3:	76 1b                	jbe    80105310 <argptr+0x50>
801052f5:	01 c3                	add    %eax,%ebx
801052f7:	39 da                	cmp    %ebx,%edx
801052f9:	72 15                	jb     80105310 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801052fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801052fe:	89 02                	mov    %eax,(%edx)
  return 0;
80105300:	31 c0                	xor    %eax,%eax
}
80105302:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105305:	5b                   	pop    %ebx
80105306:	5e                   	pop    %esi
80105307:	5d                   	pop    %ebp
80105308:	c3                   	ret    
80105309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105315:	eb eb                	jmp    80105302 <argptr+0x42>
80105317:	89 f6                	mov    %esi,%esi
80105319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105320 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105326:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105329:	50                   	push   %eax
8010532a:	ff 75 08             	pushl  0x8(%ebp)
8010532d:	e8 3e ff ff ff       	call   80105270 <argint>
80105332:	83 c4 10             	add    $0x10,%esp
80105335:	85 c0                	test   %eax,%eax
80105337:	78 17                	js     80105350 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105339:	83 ec 08             	sub    $0x8,%esp
8010533c:	ff 75 0c             	pushl  0xc(%ebp)
8010533f:	ff 75 f4             	pushl  -0xc(%ebp)
80105342:	e8 b9 fe ff ff       	call   80105200 <fetchstr>
80105347:	83 c4 10             	add    $0x10,%esp
}
8010534a:	c9                   	leave  
8010534b:	c3                   	ret    
8010534c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105355:	c9                   	leave  
80105356:	c3                   	ret    
80105357:	89 f6                	mov    %esi,%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <syscall>:
[SYS_printProcDump] sys_printProcDump,
};

void
syscall(void)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	53                   	push   %ebx
80105364:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105367:	e8 f4 eb ff ff       	call   80103f60 <myproc>
8010536c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010536e:	8b 40 18             	mov    0x18(%eax),%eax
80105371:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105374:	8d 50 ff             	lea    -0x1(%eax),%edx
80105377:	83 fa 16             	cmp    $0x16,%edx
8010537a:	77 1c                	ja     80105398 <syscall+0x38>
8010537c:	8b 14 85 80 8c 10 80 	mov    -0x7fef7380(,%eax,4),%edx
80105383:	85 d2                	test   %edx,%edx
80105385:	74 11                	je     80105398 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105387:	ff d2                	call   *%edx
80105389:	8b 53 18             	mov    0x18(%ebx),%edx
8010538c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010538f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105392:	c9                   	leave  
80105393:	c3                   	ret    
80105394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105398:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105399:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010539c:	50                   	push   %eax
8010539d:	ff 73 10             	pushl  0x10(%ebx)
801053a0:	68 55 8c 10 80       	push   $0x80108c55
801053a5:	e8 b6 b2 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801053aa:	8b 43 18             	mov    0x18(%ebx),%eax
801053ad:	83 c4 10             	add    $0x10,%esp
801053b0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801053b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053ba:	c9                   	leave  
801053bb:	c3                   	ret    
801053bc:	66 90                	xchg   %ax,%ax
801053be:	66 90                	xchg   %ax,%ax

801053c0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	56                   	push   %esi
801053c4:	53                   	push   %ebx
801053c5:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801053c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801053ca:	89 d6                	mov    %edx,%esi
801053cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053cf:	50                   	push   %eax
801053d0:	6a 00                	push   $0x0
801053d2:	e8 99 fe ff ff       	call   80105270 <argint>
801053d7:	83 c4 10             	add    $0x10,%esp
801053da:	85 c0                	test   %eax,%eax
801053dc:	78 2a                	js     80105408 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053e2:	77 24                	ja     80105408 <argfd.constprop.0+0x48>
801053e4:	e8 77 eb ff ff       	call   80103f60 <myproc>
801053e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801053f0:	85 c0                	test   %eax,%eax
801053f2:	74 14                	je     80105408 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
801053f4:	85 db                	test   %ebx,%ebx
801053f6:	74 02                	je     801053fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801053f8:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
801053fa:	89 06                	mov    %eax,(%esi)
  return 0;
801053fc:	31 c0                	xor    %eax,%eax
}
801053fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105401:	5b                   	pop    %ebx
80105402:	5e                   	pop    %esi
80105403:	5d                   	pop    %ebp
80105404:	c3                   	ret    
80105405:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105408:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010540d:	eb ef                	jmp    801053fe <argfd.constprop.0+0x3e>
8010540f:	90                   	nop

80105410 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105410:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105411:	31 c0                	xor    %eax,%eax
{
80105413:	89 e5                	mov    %esp,%ebp
80105415:	56                   	push   %esi
80105416:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105417:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010541a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010541d:	e8 9e ff ff ff       	call   801053c0 <argfd.constprop.0>
80105422:	85 c0                	test   %eax,%eax
80105424:	78 42                	js     80105468 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105426:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105429:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010542b:	e8 30 eb ff ff       	call   80103f60 <myproc>
80105430:	eb 0e                	jmp    80105440 <sys_dup+0x30>
80105432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105438:	83 c3 01             	add    $0x1,%ebx
8010543b:	83 fb 10             	cmp    $0x10,%ebx
8010543e:	74 28                	je     80105468 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105440:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105444:	85 d2                	test   %edx,%edx
80105446:	75 f0                	jne    80105438 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105448:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010544c:	83 ec 0c             	sub    $0xc,%esp
8010544f:	ff 75 f4             	pushl  -0xc(%ebp)
80105452:	e8 d9 ba ff ff       	call   80100f30 <filedup>
  return fd;
80105457:	83 c4 10             	add    $0x10,%esp
}
8010545a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010545d:	89 d8                	mov    %ebx,%eax
8010545f:	5b                   	pop    %ebx
80105460:	5e                   	pop    %esi
80105461:	5d                   	pop    %ebp
80105462:	c3                   	ret    
80105463:	90                   	nop
80105464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105468:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010546b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105470:	89 d8                	mov    %ebx,%eax
80105472:	5b                   	pop    %ebx
80105473:	5e                   	pop    %esi
80105474:	5d                   	pop    %ebp
80105475:	c3                   	ret    
80105476:	8d 76 00             	lea    0x0(%esi),%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <sys_read>:

int
sys_read(void)
{
80105480:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105481:	31 c0                	xor    %eax,%eax
{
80105483:	89 e5                	mov    %esp,%ebp
80105485:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105488:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010548b:	e8 30 ff ff ff       	call   801053c0 <argfd.constprop.0>
80105490:	85 c0                	test   %eax,%eax
80105492:	78 4c                	js     801054e0 <sys_read+0x60>
80105494:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105497:	83 ec 08             	sub    $0x8,%esp
8010549a:	50                   	push   %eax
8010549b:	6a 02                	push   $0x2
8010549d:	e8 ce fd ff ff       	call   80105270 <argint>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 37                	js     801054e0 <sys_read+0x60>
801054a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ac:	83 ec 04             	sub    $0x4,%esp
801054af:	ff 75 f0             	pushl  -0x10(%ebp)
801054b2:	50                   	push   %eax
801054b3:	6a 01                	push   $0x1
801054b5:	e8 06 fe ff ff       	call   801052c0 <argptr>
801054ba:	83 c4 10             	add    $0x10,%esp
801054bd:	85 c0                	test   %eax,%eax
801054bf:	78 1f                	js     801054e0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801054c1:	83 ec 04             	sub    $0x4,%esp
801054c4:	ff 75 f0             	pushl  -0x10(%ebp)
801054c7:	ff 75 f4             	pushl  -0xc(%ebp)
801054ca:	ff 75 ec             	pushl  -0x14(%ebp)
801054cd:	e8 ce bb ff ff       	call   801010a0 <fileread>
801054d2:	83 c4 10             	add    $0x10,%esp
}
801054d5:	c9                   	leave  
801054d6:	c3                   	ret    
801054d7:	89 f6                	mov    %esi,%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054f0 <sys_write>:

int
sys_write(void)
{
801054f0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054f1:	31 c0                	xor    %eax,%eax
{
801054f3:	89 e5                	mov    %esp,%ebp
801054f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801054f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801054fb:	e8 c0 fe ff ff       	call   801053c0 <argfd.constprop.0>
80105500:	85 c0                	test   %eax,%eax
80105502:	78 4c                	js     80105550 <sys_write+0x60>
80105504:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105507:	83 ec 08             	sub    $0x8,%esp
8010550a:	50                   	push   %eax
8010550b:	6a 02                	push   $0x2
8010550d:	e8 5e fd ff ff       	call   80105270 <argint>
80105512:	83 c4 10             	add    $0x10,%esp
80105515:	85 c0                	test   %eax,%eax
80105517:	78 37                	js     80105550 <sys_write+0x60>
80105519:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010551c:	83 ec 04             	sub    $0x4,%esp
8010551f:	ff 75 f0             	pushl  -0x10(%ebp)
80105522:	50                   	push   %eax
80105523:	6a 01                	push   $0x1
80105525:	e8 96 fd ff ff       	call   801052c0 <argptr>
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	85 c0                	test   %eax,%eax
8010552f:	78 1f                	js     80105550 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105531:	83 ec 04             	sub    $0x4,%esp
80105534:	ff 75 f0             	pushl  -0x10(%ebp)
80105537:	ff 75 f4             	pushl  -0xc(%ebp)
8010553a:	ff 75 ec             	pushl  -0x14(%ebp)
8010553d:	e8 ee bb ff ff       	call   80101130 <filewrite>
80105542:	83 c4 10             	add    $0x10,%esp
}
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105550:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105555:	c9                   	leave  
80105556:	c3                   	ret    
80105557:	89 f6                	mov    %esi,%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <sys_close>:

int
sys_close(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105566:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105569:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010556c:	e8 4f fe ff ff       	call   801053c0 <argfd.constprop.0>
80105571:	85 c0                	test   %eax,%eax
80105573:	78 2b                	js     801055a0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105575:	e8 e6 e9 ff ff       	call   80103f60 <myproc>
8010557a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010557d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105580:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105587:	00 
  fileclose(f);
80105588:	ff 75 f4             	pushl  -0xc(%ebp)
8010558b:	e8 f0 b9 ff ff       	call   80100f80 <fileclose>
  return 0;
80105590:	83 c4 10             	add    $0x10,%esp
80105593:	31 c0                	xor    %eax,%eax
}
80105595:	c9                   	leave  
80105596:	c3                   	ret    
80105597:	89 f6                	mov    %esi,%esi
80105599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801055a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055a5:	c9                   	leave  
801055a6:	c3                   	ret    
801055a7:	89 f6                	mov    %esi,%esi
801055a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055b0 <sys_fstat>:

int
sys_fstat(void)
{
801055b0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055b1:	31 c0                	xor    %eax,%eax
{
801055b3:	89 e5                	mov    %esp,%ebp
801055b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801055b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801055bb:	e8 00 fe ff ff       	call   801053c0 <argfd.constprop.0>
801055c0:	85 c0                	test   %eax,%eax
801055c2:	78 2c                	js     801055f0 <sys_fstat+0x40>
801055c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055c7:	83 ec 04             	sub    $0x4,%esp
801055ca:	6a 14                	push   $0x14
801055cc:	50                   	push   %eax
801055cd:	6a 01                	push   $0x1
801055cf:	e8 ec fc ff ff       	call   801052c0 <argptr>
801055d4:	83 c4 10             	add    $0x10,%esp
801055d7:	85 c0                	test   %eax,%eax
801055d9:	78 15                	js     801055f0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801055db:	83 ec 08             	sub    $0x8,%esp
801055de:	ff 75 f4             	pushl  -0xc(%ebp)
801055e1:	ff 75 f0             	pushl  -0x10(%ebp)
801055e4:	e8 67 ba ff ff       	call   80101050 <filestat>
801055e9:	83 c4 10             	add    $0x10,%esp
}
801055ec:	c9                   	leave  
801055ed:	c3                   	ret    
801055ee:	66 90                	xchg   %ax,%ax
    return -1;
801055f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055f5:	c9                   	leave  
801055f6:	c3                   	ret    
801055f7:	89 f6                	mov    %esi,%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105600 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	57                   	push   %edi
80105604:	56                   	push   %esi
80105605:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105606:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105609:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010560c:	50                   	push   %eax
8010560d:	6a 00                	push   $0x0
8010560f:	e8 0c fd ff ff       	call   80105320 <argstr>
80105614:	83 c4 10             	add    $0x10,%esp
80105617:	85 c0                	test   %eax,%eax
80105619:	0f 88 fb 00 00 00    	js     8010571a <sys_link+0x11a>
8010561f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105622:	83 ec 08             	sub    $0x8,%esp
80105625:	50                   	push   %eax
80105626:	6a 01                	push   $0x1
80105628:	e8 f3 fc ff ff       	call   80105320 <argstr>
8010562d:	83 c4 10             	add    $0x10,%esp
80105630:	85 c0                	test   %eax,%eax
80105632:	0f 88 e2 00 00 00    	js     8010571a <sys_link+0x11a>
    return -1;

  begin_op();
80105638:	e8 23 dc ff ff       	call   80103260 <begin_op>
  if((ip = namei(old)) == 0){
8010563d:	83 ec 0c             	sub    $0xc,%esp
80105640:	ff 75 d4             	pushl  -0x2c(%ebp)
80105643:	e8 d8 c9 ff ff       	call   80102020 <namei>
80105648:	83 c4 10             	add    $0x10,%esp
8010564b:	85 c0                	test   %eax,%eax
8010564d:	89 c3                	mov    %eax,%ebx
8010564f:	0f 84 ea 00 00 00    	je     8010573f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105655:	83 ec 0c             	sub    $0xc,%esp
80105658:	50                   	push   %eax
80105659:	e8 62 c1 ff ff       	call   801017c0 <ilock>
  if(ip->type == T_DIR){
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105666:	0f 84 bb 00 00 00    	je     80105727 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010566c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105671:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105674:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105677:	53                   	push   %ebx
80105678:	e8 93 c0 ff ff       	call   80101710 <iupdate>
  iunlock(ip);
8010567d:	89 1c 24             	mov    %ebx,(%esp)
80105680:	e8 1b c2 ff ff       	call   801018a0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105685:	58                   	pop    %eax
80105686:	5a                   	pop    %edx
80105687:	57                   	push   %edi
80105688:	ff 75 d0             	pushl  -0x30(%ebp)
8010568b:	e8 b0 c9 ff ff       	call   80102040 <nameiparent>
80105690:	83 c4 10             	add    $0x10,%esp
80105693:	85 c0                	test   %eax,%eax
80105695:	89 c6                	mov    %eax,%esi
80105697:	74 5b                	je     801056f4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105699:	83 ec 0c             	sub    $0xc,%esp
8010569c:	50                   	push   %eax
8010569d:	e8 1e c1 ff ff       	call   801017c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801056a2:	83 c4 10             	add    $0x10,%esp
801056a5:	8b 03                	mov    (%ebx),%eax
801056a7:	39 06                	cmp    %eax,(%esi)
801056a9:	75 3d                	jne    801056e8 <sys_link+0xe8>
801056ab:	83 ec 04             	sub    $0x4,%esp
801056ae:	ff 73 04             	pushl  0x4(%ebx)
801056b1:	57                   	push   %edi
801056b2:	56                   	push   %esi
801056b3:	e8 a8 c8 ff ff       	call   80101f60 <dirlink>
801056b8:	83 c4 10             	add    $0x10,%esp
801056bb:	85 c0                	test   %eax,%eax
801056bd:	78 29                	js     801056e8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801056bf:	83 ec 0c             	sub    $0xc,%esp
801056c2:	56                   	push   %esi
801056c3:	e8 88 c3 ff ff       	call   80101a50 <iunlockput>
  iput(ip);
801056c8:	89 1c 24             	mov    %ebx,(%esp)
801056cb:	e8 20 c2 ff ff       	call   801018f0 <iput>

  end_op();
801056d0:	e8 fb db ff ff       	call   801032d0 <end_op>

  return 0;
801056d5:	83 c4 10             	add    $0x10,%esp
801056d8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
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
    iunlockput(dp);
801056e8:	83 ec 0c             	sub    $0xc,%esp
801056eb:	56                   	push   %esi
801056ec:	e8 5f c3 ff ff       	call   80101a50 <iunlockput>
    goto bad;
801056f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801056f4:	83 ec 0c             	sub    $0xc,%esp
801056f7:	53                   	push   %ebx
801056f8:	e8 c3 c0 ff ff       	call   801017c0 <ilock>
  ip->nlink--;
801056fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105702:	89 1c 24             	mov    %ebx,(%esp)
80105705:	e8 06 c0 ff ff       	call   80101710 <iupdate>
  iunlockput(ip);
8010570a:	89 1c 24             	mov    %ebx,(%esp)
8010570d:	e8 3e c3 ff ff       	call   80101a50 <iunlockput>
  end_op();
80105712:	e8 b9 db ff ff       	call   801032d0 <end_op>
  return -1;
80105717:	83 c4 10             	add    $0x10,%esp
}
8010571a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010571d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105722:	5b                   	pop    %ebx
80105723:	5e                   	pop    %esi
80105724:	5f                   	pop    %edi
80105725:	5d                   	pop    %ebp
80105726:	c3                   	ret    
    iunlockput(ip);
80105727:	83 ec 0c             	sub    $0xc,%esp
8010572a:	53                   	push   %ebx
8010572b:	e8 20 c3 ff ff       	call   80101a50 <iunlockput>
    end_op();
80105730:	e8 9b db ff ff       	call   801032d0 <end_op>
    return -1;
80105735:	83 c4 10             	add    $0x10,%esp
80105738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010573d:	eb 9b                	jmp    801056da <sys_link+0xda>
    end_op();
8010573f:	e8 8c db ff ff       	call   801032d0 <end_op>
    return -1;
80105744:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105749:	eb 8f                	jmp    801056da <sys_link+0xda>
8010574b:	90                   	nop
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105750 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	57                   	push   %edi
80105754:	56                   	push   %esi
80105755:	53                   	push   %ebx
80105756:	83 ec 1c             	sub    $0x1c,%esp
80105759:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010575c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105760:	76 3e                	jbe    801057a0 <isdirempty+0x50>
80105762:	bb 20 00 00 00       	mov    $0x20,%ebx
80105767:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010576a:	eb 0c                	jmp    80105778 <isdirempty+0x28>
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105770:	83 c3 10             	add    $0x10,%ebx
80105773:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105776:	73 28                	jae    801057a0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105778:	6a 10                	push   $0x10
8010577a:	53                   	push   %ebx
8010577b:	57                   	push   %edi
8010577c:	56                   	push   %esi
8010577d:	e8 1e c3 ff ff       	call   80101aa0 <readi>
80105782:	83 c4 10             	add    $0x10,%esp
80105785:	83 f8 10             	cmp    $0x10,%eax
80105788:	75 23                	jne    801057ad <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010578a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010578f:	74 df                	je     80105770 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105791:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105794:	31 c0                	xor    %eax,%eax
}
80105796:	5b                   	pop    %ebx
80105797:	5e                   	pop    %esi
80105798:	5f                   	pop    %edi
80105799:	5d                   	pop    %ebp
8010579a:	c3                   	ret    
8010579b:	90                   	nop
8010579c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801057a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801057a8:	5b                   	pop    %ebx
801057a9:	5e                   	pop    %esi
801057aa:	5f                   	pop    %edi
801057ab:	5d                   	pop    %ebp
801057ac:	c3                   	ret    
      panic("isdirempty: readi");
801057ad:	83 ec 0c             	sub    $0xc,%esp
801057b0:	68 e0 8c 10 80       	push   $0x80108ce0
801057b5:	e8 d6 ab ff ff       	call   80100390 <panic>
801057ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801057c0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	57                   	push   %edi
801057c4:	56                   	push   %esi
801057c5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801057c6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801057c9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801057cc:	50                   	push   %eax
801057cd:	6a 00                	push   $0x0
801057cf:	e8 4c fb ff ff       	call   80105320 <argstr>
801057d4:	83 c4 10             	add    $0x10,%esp
801057d7:	85 c0                	test   %eax,%eax
801057d9:	0f 88 51 01 00 00    	js     80105930 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801057df:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801057e2:	e8 79 da ff ff       	call   80103260 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801057e7:	83 ec 08             	sub    $0x8,%esp
801057ea:	53                   	push   %ebx
801057eb:	ff 75 c0             	pushl  -0x40(%ebp)
801057ee:	e8 4d c8 ff ff       	call   80102040 <nameiparent>
801057f3:	83 c4 10             	add    $0x10,%esp
801057f6:	85 c0                	test   %eax,%eax
801057f8:	89 c6                	mov    %eax,%esi
801057fa:	0f 84 37 01 00 00    	je     80105937 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105800:	83 ec 0c             	sub    $0xc,%esp
80105803:	50                   	push   %eax
80105804:	e8 b7 bf ff ff       	call   801017c0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105809:	58                   	pop    %eax
8010580a:	5a                   	pop    %edx
8010580b:	68 dd 85 10 80       	push   $0x801085dd
80105810:	53                   	push   %ebx
80105811:	e8 ba c4 ff ff       	call   80101cd0 <namecmp>
80105816:	83 c4 10             	add    $0x10,%esp
80105819:	85 c0                	test   %eax,%eax
8010581b:	0f 84 d7 00 00 00    	je     801058f8 <sys_unlink+0x138>
80105821:	83 ec 08             	sub    $0x8,%esp
80105824:	68 dc 85 10 80       	push   $0x801085dc
80105829:	53                   	push   %ebx
8010582a:	e8 a1 c4 ff ff       	call   80101cd0 <namecmp>
8010582f:	83 c4 10             	add    $0x10,%esp
80105832:	85 c0                	test   %eax,%eax
80105834:	0f 84 be 00 00 00    	je     801058f8 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010583a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010583d:	83 ec 04             	sub    $0x4,%esp
80105840:	50                   	push   %eax
80105841:	53                   	push   %ebx
80105842:	56                   	push   %esi
80105843:	e8 a8 c4 ff ff       	call   80101cf0 <dirlookup>
80105848:	83 c4 10             	add    $0x10,%esp
8010584b:	85 c0                	test   %eax,%eax
8010584d:	89 c3                	mov    %eax,%ebx
8010584f:	0f 84 a3 00 00 00    	je     801058f8 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105855:	83 ec 0c             	sub    $0xc,%esp
80105858:	50                   	push   %eax
80105859:	e8 62 bf ff ff       	call   801017c0 <ilock>

  if(ip->nlink < 1)
8010585e:	83 c4 10             	add    $0x10,%esp
80105861:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105866:	0f 8e e4 00 00 00    	jle    80105950 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010586c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105871:	74 65                	je     801058d8 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105873:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105876:	83 ec 04             	sub    $0x4,%esp
80105879:	6a 10                	push   $0x10
8010587b:	6a 00                	push   $0x0
8010587d:	57                   	push   %edi
8010587e:	e8 ed f6 ff ff       	call   80104f70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105883:	6a 10                	push   $0x10
80105885:	ff 75 c4             	pushl  -0x3c(%ebp)
80105888:	57                   	push   %edi
80105889:	56                   	push   %esi
8010588a:	e8 11 c3 ff ff       	call   80101ba0 <writei>
8010588f:	83 c4 20             	add    $0x20,%esp
80105892:	83 f8 10             	cmp    $0x10,%eax
80105895:	0f 85 a8 00 00 00    	jne    80105943 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010589b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801058a0:	74 6e                	je     80105910 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801058a2:	83 ec 0c             	sub    $0xc,%esp
801058a5:	56                   	push   %esi
801058a6:	e8 a5 c1 ff ff       	call   80101a50 <iunlockput>

  ip->nlink--;
801058ab:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801058b0:	89 1c 24             	mov    %ebx,(%esp)
801058b3:	e8 58 be ff ff       	call   80101710 <iupdate>
  iunlockput(ip);
801058b8:	89 1c 24             	mov    %ebx,(%esp)
801058bb:	e8 90 c1 ff ff       	call   80101a50 <iunlockput>

  end_op();
801058c0:	e8 0b da ff ff       	call   801032d0 <end_op>

  return 0;
801058c5:	83 c4 10             	add    $0x10,%esp
801058c8:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801058ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058cd:	5b                   	pop    %ebx
801058ce:	5e                   	pop    %esi
801058cf:	5f                   	pop    %edi
801058d0:	5d                   	pop    %ebp
801058d1:	c3                   	ret    
801058d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
801058d8:	83 ec 0c             	sub    $0xc,%esp
801058db:	53                   	push   %ebx
801058dc:	e8 6f fe ff ff       	call   80105750 <isdirempty>
801058e1:	83 c4 10             	add    $0x10,%esp
801058e4:	85 c0                	test   %eax,%eax
801058e6:	75 8b                	jne    80105873 <sys_unlink+0xb3>
    iunlockput(ip);
801058e8:	83 ec 0c             	sub    $0xc,%esp
801058eb:	53                   	push   %ebx
801058ec:	e8 5f c1 ff ff       	call   80101a50 <iunlockput>
    goto bad;
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
801058f8:	83 ec 0c             	sub    $0xc,%esp
801058fb:	56                   	push   %esi
801058fc:	e8 4f c1 ff ff       	call   80101a50 <iunlockput>
  end_op();
80105901:	e8 ca d9 ff ff       	call   801032d0 <end_op>
  return -1;
80105906:	83 c4 10             	add    $0x10,%esp
80105909:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010590e:	eb ba                	jmp    801058ca <sys_unlink+0x10a>
    dp->nlink--;
80105910:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105915:	83 ec 0c             	sub    $0xc,%esp
80105918:	56                   	push   %esi
80105919:	e8 f2 bd ff ff       	call   80101710 <iupdate>
8010591e:	83 c4 10             	add    $0x10,%esp
80105921:	e9 7c ff ff ff       	jmp    801058a2 <sys_unlink+0xe2>
80105926:	8d 76 00             	lea    0x0(%esi),%esi
80105929:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105935:	eb 93                	jmp    801058ca <sys_unlink+0x10a>
    end_op();
80105937:	e8 94 d9 ff ff       	call   801032d0 <end_op>
    return -1;
8010593c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105941:	eb 87                	jmp    801058ca <sys_unlink+0x10a>
    panic("unlink: writei");
80105943:	83 ec 0c             	sub    $0xc,%esp
80105946:	68 f1 85 10 80       	push   $0x801085f1
8010594b:	e8 40 aa ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105950:	83 ec 0c             	sub    $0xc,%esp
80105953:	68 df 85 10 80       	push   $0x801085df
80105958:	e8 33 aa ff ff       	call   80100390 <panic>
8010595d:	8d 76 00             	lea    0x0(%esi),%esi

80105960 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	57                   	push   %edi
80105964:	56                   	push   %esi
80105965:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105966:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105969:	83 ec 34             	sub    $0x34,%esp
8010596c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010596f:	8b 55 10             	mov    0x10(%ebp),%edx
80105972:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105975:	56                   	push   %esi
80105976:	ff 75 08             	pushl  0x8(%ebp)
{
80105979:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010597c:	89 55 d0             	mov    %edx,-0x30(%ebp)
8010597f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105982:	e8 b9 c6 ff ff       	call   80102040 <nameiparent>
80105987:	83 c4 10             	add    $0x10,%esp
8010598a:	85 c0                	test   %eax,%eax
8010598c:	0f 84 4e 01 00 00    	je     80105ae0 <create+0x180>
    return 0;
  ilock(dp);
80105992:	83 ec 0c             	sub    $0xc,%esp
80105995:	89 c3                	mov    %eax,%ebx
80105997:	50                   	push   %eax
80105998:	e8 23 be ff ff       	call   801017c0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
8010599d:	83 c4 0c             	add    $0xc,%esp
801059a0:	6a 00                	push   $0x0
801059a2:	56                   	push   %esi
801059a3:	53                   	push   %ebx
801059a4:	e8 47 c3 ff ff       	call   80101cf0 <dirlookup>
801059a9:	83 c4 10             	add    $0x10,%esp
801059ac:	85 c0                	test   %eax,%eax
801059ae:	89 c7                	mov    %eax,%edi
801059b0:	74 3e                	je     801059f0 <create+0x90>
    iunlockput(dp);
801059b2:	83 ec 0c             	sub    $0xc,%esp
801059b5:	53                   	push   %ebx
801059b6:	e8 95 c0 ff ff       	call   80101a50 <iunlockput>
    ilock(ip);
801059bb:	89 3c 24             	mov    %edi,(%esp)
801059be:	e8 fd bd ff ff       	call   801017c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801059c3:	83 c4 10             	add    $0x10,%esp
801059c6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801059cb:	0f 85 9f 00 00 00    	jne    80105a70 <create+0x110>
801059d1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801059d6:	0f 85 94 00 00 00    	jne    80105a70 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801059dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059df:	89 f8                	mov    %edi,%eax
801059e1:	5b                   	pop    %ebx
801059e2:	5e                   	pop    %esi
801059e3:	5f                   	pop    %edi
801059e4:	5d                   	pop    %ebp
801059e5:	c3                   	ret    
801059e6:	8d 76 00             	lea    0x0(%esi),%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
801059f0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801059f4:	83 ec 08             	sub    $0x8,%esp
801059f7:	50                   	push   %eax
801059f8:	ff 33                	pushl  (%ebx)
801059fa:	e8 51 bc ff ff       	call   80101650 <ialloc>
801059ff:	83 c4 10             	add    $0x10,%esp
80105a02:	85 c0                	test   %eax,%eax
80105a04:	89 c7                	mov    %eax,%edi
80105a06:	0f 84 e8 00 00 00    	je     80105af4 <create+0x194>
  ilock(ip);
80105a0c:	83 ec 0c             	sub    $0xc,%esp
80105a0f:	50                   	push   %eax
80105a10:	e8 ab bd ff ff       	call   801017c0 <ilock>
  ip->major = major;
80105a15:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105a19:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80105a1d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105a21:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105a25:	b8 01 00 00 00       	mov    $0x1,%eax
80105a2a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80105a2e:	89 3c 24             	mov    %edi,(%esp)
80105a31:	e8 da bc ff ff       	call   80101710 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105a36:	83 c4 10             	add    $0x10,%esp
80105a39:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105a3e:	74 50                	je     80105a90 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105a40:	83 ec 04             	sub    $0x4,%esp
80105a43:	ff 77 04             	pushl  0x4(%edi)
80105a46:	56                   	push   %esi
80105a47:	53                   	push   %ebx
80105a48:	e8 13 c5 ff ff       	call   80101f60 <dirlink>
80105a4d:	83 c4 10             	add    $0x10,%esp
80105a50:	85 c0                	test   %eax,%eax
80105a52:	0f 88 8f 00 00 00    	js     80105ae7 <create+0x187>
  iunlockput(dp);
80105a58:	83 ec 0c             	sub    $0xc,%esp
80105a5b:	53                   	push   %ebx
80105a5c:	e8 ef bf ff ff       	call   80101a50 <iunlockput>
  return ip;
80105a61:	83 c4 10             	add    $0x10,%esp
}
80105a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a67:	89 f8                	mov    %edi,%eax
80105a69:	5b                   	pop    %ebx
80105a6a:	5e                   	pop    %esi
80105a6b:	5f                   	pop    %edi
80105a6c:	5d                   	pop    %ebp
80105a6d:	c3                   	ret    
80105a6e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105a70:	83 ec 0c             	sub    $0xc,%esp
80105a73:	57                   	push   %edi
    return 0;
80105a74:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105a76:	e8 d5 bf ff ff       	call   80101a50 <iunlockput>
    return 0;
80105a7b:	83 c4 10             	add    $0x10,%esp
}
80105a7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a81:	89 f8                	mov    %edi,%eax
80105a83:	5b                   	pop    %ebx
80105a84:	5e                   	pop    %esi
80105a85:	5f                   	pop    %edi
80105a86:	5d                   	pop    %ebp
80105a87:	c3                   	ret    
80105a88:	90                   	nop
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105a90:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105a95:	83 ec 0c             	sub    $0xc,%esp
80105a98:	53                   	push   %ebx
80105a99:	e8 72 bc ff ff       	call   80101710 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105a9e:	83 c4 0c             	add    $0xc,%esp
80105aa1:	ff 77 04             	pushl  0x4(%edi)
80105aa4:	68 dd 85 10 80       	push   $0x801085dd
80105aa9:	57                   	push   %edi
80105aaa:	e8 b1 c4 ff ff       	call   80101f60 <dirlink>
80105aaf:	83 c4 10             	add    $0x10,%esp
80105ab2:	85 c0                	test   %eax,%eax
80105ab4:	78 1c                	js     80105ad2 <create+0x172>
80105ab6:	83 ec 04             	sub    $0x4,%esp
80105ab9:	ff 73 04             	pushl  0x4(%ebx)
80105abc:	68 dc 85 10 80       	push   $0x801085dc
80105ac1:	57                   	push   %edi
80105ac2:	e8 99 c4 ff ff       	call   80101f60 <dirlink>
80105ac7:	83 c4 10             	add    $0x10,%esp
80105aca:	85 c0                	test   %eax,%eax
80105acc:	0f 89 6e ff ff ff    	jns    80105a40 <create+0xe0>
      panic("create dots");
80105ad2:	83 ec 0c             	sub    $0xc,%esp
80105ad5:	68 01 8d 10 80       	push   $0x80108d01
80105ada:	e8 b1 a8 ff ff       	call   80100390 <panic>
80105adf:	90                   	nop
    return 0;
80105ae0:	31 ff                	xor    %edi,%edi
80105ae2:	e9 f5 fe ff ff       	jmp    801059dc <create+0x7c>
    panic("create: dirlink");
80105ae7:	83 ec 0c             	sub    $0xc,%esp
80105aea:	68 0d 8d 10 80       	push   $0x80108d0d
80105aef:	e8 9c a8 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105af4:	83 ec 0c             	sub    $0xc,%esp
80105af7:	68 f2 8c 10 80       	push   $0x80108cf2
80105afc:	e8 8f a8 ff ff       	call   80100390 <panic>
80105b01:	eb 0d                	jmp    80105b10 <sys_open>
80105b03:	90                   	nop
80105b04:	90                   	nop
80105b05:	90                   	nop
80105b06:	90                   	nop
80105b07:	90                   	nop
80105b08:	90                   	nop
80105b09:	90                   	nop
80105b0a:	90                   	nop
80105b0b:	90                   	nop
80105b0c:	90                   	nop
80105b0d:	90                   	nop
80105b0e:	90                   	nop
80105b0f:	90                   	nop

80105b10 <sys_open>:

int
sys_open(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	57                   	push   %edi
80105b14:	56                   	push   %esi
80105b15:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b16:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105b19:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b1c:	50                   	push   %eax
80105b1d:	6a 00                	push   $0x0
80105b1f:	e8 fc f7 ff ff       	call   80105320 <argstr>
80105b24:	83 c4 10             	add    $0x10,%esp
80105b27:	85 c0                	test   %eax,%eax
80105b29:	0f 88 1d 01 00 00    	js     80105c4c <sys_open+0x13c>
80105b2f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b32:	83 ec 08             	sub    $0x8,%esp
80105b35:	50                   	push   %eax
80105b36:	6a 01                	push   $0x1
80105b38:	e8 33 f7 ff ff       	call   80105270 <argint>
80105b3d:	83 c4 10             	add    $0x10,%esp
80105b40:	85 c0                	test   %eax,%eax
80105b42:	0f 88 04 01 00 00    	js     80105c4c <sys_open+0x13c>
    return -1;

  begin_op();
80105b48:	e8 13 d7 ff ff       	call   80103260 <begin_op>

  if(omode & O_CREATE){
80105b4d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105b51:	0f 85 a9 00 00 00    	jne    80105c00 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105b57:	83 ec 0c             	sub    $0xc,%esp
80105b5a:	ff 75 e0             	pushl  -0x20(%ebp)
80105b5d:	e8 be c4 ff ff       	call   80102020 <namei>
80105b62:	83 c4 10             	add    $0x10,%esp
80105b65:	85 c0                	test   %eax,%eax
80105b67:	89 c6                	mov    %eax,%esi
80105b69:	0f 84 ac 00 00 00    	je     80105c1b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
80105b6f:	83 ec 0c             	sub    $0xc,%esp
80105b72:	50                   	push   %eax
80105b73:	e8 48 bc ff ff       	call   801017c0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105b80:	0f 84 aa 00 00 00    	je     80105c30 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105b86:	e8 35 b3 ff ff       	call   80100ec0 <filealloc>
80105b8b:	85 c0                	test   %eax,%eax
80105b8d:	89 c7                	mov    %eax,%edi
80105b8f:	0f 84 a6 00 00 00    	je     80105c3b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105b95:	e8 c6 e3 ff ff       	call   80103f60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b9a:	31 db                	xor    %ebx,%ebx
80105b9c:	eb 0e                	jmp    80105bac <sys_open+0x9c>
80105b9e:	66 90                	xchg   %ax,%ax
80105ba0:	83 c3 01             	add    $0x1,%ebx
80105ba3:	83 fb 10             	cmp    $0x10,%ebx
80105ba6:	0f 84 ac 00 00 00    	je     80105c58 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
80105bac:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105bb0:	85 d2                	test   %edx,%edx
80105bb2:	75 ec                	jne    80105ba0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105bb4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105bb7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105bbb:	56                   	push   %esi
80105bbc:	e8 df bc ff ff       	call   801018a0 <iunlock>
  end_op();
80105bc1:	e8 0a d7 ff ff       	call   801032d0 <end_op>

  f->type = FD_INODE;
80105bc6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105bcc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105bcf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105bd2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105bd5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105bdc:	89 d0                	mov    %edx,%eax
80105bde:	f7 d0                	not    %eax
80105be0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105be3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105be6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105be9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf0:	89 d8                	mov    %ebx,%eax
80105bf2:	5b                   	pop    %ebx
80105bf3:	5e                   	pop    %esi
80105bf4:	5f                   	pop    %edi
80105bf5:	5d                   	pop    %ebp
80105bf6:	c3                   	ret    
80105bf7:	89 f6                	mov    %esi,%esi
80105bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105c00:	6a 00                	push   $0x0
80105c02:	6a 00                	push   $0x0
80105c04:	6a 02                	push   $0x2
80105c06:	ff 75 e0             	pushl  -0x20(%ebp)
80105c09:	e8 52 fd ff ff       	call   80105960 <create>
    if(ip == 0){
80105c0e:	83 c4 10             	add    $0x10,%esp
80105c11:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105c13:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105c15:	0f 85 6b ff ff ff    	jne    80105b86 <sys_open+0x76>
      end_op();
80105c1b:	e8 b0 d6 ff ff       	call   801032d0 <end_op>
      return -1;
80105c20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c25:	eb c6                	jmp    80105bed <sys_open+0xdd>
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105c30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105c33:	85 c9                	test   %ecx,%ecx
80105c35:	0f 84 4b ff ff ff    	je     80105b86 <sys_open+0x76>
    iunlockput(ip);
80105c3b:	83 ec 0c             	sub    $0xc,%esp
80105c3e:	56                   	push   %esi
80105c3f:	e8 0c be ff ff       	call   80101a50 <iunlockput>
    end_op();
80105c44:	e8 87 d6 ff ff       	call   801032d0 <end_op>
    return -1;
80105c49:	83 c4 10             	add    $0x10,%esp
80105c4c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105c51:	eb 9a                	jmp    80105bed <sys_open+0xdd>
80105c53:	90                   	nop
80105c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105c58:	83 ec 0c             	sub    $0xc,%esp
80105c5b:	57                   	push   %edi
80105c5c:	e8 1f b3 ff ff       	call   80100f80 <fileclose>
80105c61:	83 c4 10             	add    $0x10,%esp
80105c64:	eb d5                	jmp    80105c3b <sys_open+0x12b>
80105c66:	8d 76 00             	lea    0x0(%esi),%esi
80105c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c70 <sys_mkdir>:

int
sys_mkdir(void)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105c76:	e8 e5 d5 ff ff       	call   80103260 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c7e:	83 ec 08             	sub    $0x8,%esp
80105c81:	50                   	push   %eax
80105c82:	6a 00                	push   $0x0
80105c84:	e8 97 f6 ff ff       	call   80105320 <argstr>
80105c89:	83 c4 10             	add    $0x10,%esp
80105c8c:	85 c0                	test   %eax,%eax
80105c8e:	78 30                	js     80105cc0 <sys_mkdir+0x50>
80105c90:	6a 00                	push   $0x0
80105c92:	6a 00                	push   $0x0
80105c94:	6a 01                	push   $0x1
80105c96:	ff 75 f4             	pushl  -0xc(%ebp)
80105c99:	e8 c2 fc ff ff       	call   80105960 <create>
80105c9e:	83 c4 10             	add    $0x10,%esp
80105ca1:	85 c0                	test   %eax,%eax
80105ca3:	74 1b                	je     80105cc0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105ca5:	83 ec 0c             	sub    $0xc,%esp
80105ca8:	50                   	push   %eax
80105ca9:	e8 a2 bd ff ff       	call   80101a50 <iunlockput>
  end_op();
80105cae:	e8 1d d6 ff ff       	call   801032d0 <end_op>
  return 0;
80105cb3:	83 c4 10             	add    $0x10,%esp
80105cb6:	31 c0                	xor    %eax,%eax
}
80105cb8:	c9                   	leave  
80105cb9:	c3                   	ret    
80105cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105cc0:	e8 0b d6 ff ff       	call   801032d0 <end_op>
    return -1;
80105cc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cca:	c9                   	leave  
80105ccb:	c3                   	ret    
80105ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cd0 <sys_mknod>:

int
sys_mknod(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105cd6:	e8 85 d5 ff ff       	call   80103260 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105cdb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105cde:	83 ec 08             	sub    $0x8,%esp
80105ce1:	50                   	push   %eax
80105ce2:	6a 00                	push   $0x0
80105ce4:	e8 37 f6 ff ff       	call   80105320 <argstr>
80105ce9:	83 c4 10             	add    $0x10,%esp
80105cec:	85 c0                	test   %eax,%eax
80105cee:	78 60                	js     80105d50 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105cf0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cf3:	83 ec 08             	sub    $0x8,%esp
80105cf6:	50                   	push   %eax
80105cf7:	6a 01                	push   $0x1
80105cf9:	e8 72 f5 ff ff       	call   80105270 <argint>
  if((argstr(0, &path)) < 0 ||
80105cfe:	83 c4 10             	add    $0x10,%esp
80105d01:	85 c0                	test   %eax,%eax
80105d03:	78 4b                	js     80105d50 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105d05:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d08:	83 ec 08             	sub    $0x8,%esp
80105d0b:	50                   	push   %eax
80105d0c:	6a 02                	push   $0x2
80105d0e:	e8 5d f5 ff ff       	call   80105270 <argint>
     argint(1, &major) < 0 ||
80105d13:	83 c4 10             	add    $0x10,%esp
80105d16:	85 c0                	test   %eax,%eax
80105d18:	78 36                	js     80105d50 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d1a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105d1e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d1f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105d23:	50                   	push   %eax
80105d24:	6a 03                	push   $0x3
80105d26:	ff 75 ec             	pushl  -0x14(%ebp)
80105d29:	e8 32 fc ff ff       	call   80105960 <create>
80105d2e:	83 c4 10             	add    $0x10,%esp
80105d31:	85 c0                	test   %eax,%eax
80105d33:	74 1b                	je     80105d50 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105d35:	83 ec 0c             	sub    $0xc,%esp
80105d38:	50                   	push   %eax
80105d39:	e8 12 bd ff ff       	call   80101a50 <iunlockput>
  end_op();
80105d3e:	e8 8d d5 ff ff       	call   801032d0 <end_op>
  return 0;
80105d43:	83 c4 10             	add    $0x10,%esp
80105d46:	31 c0                	xor    %eax,%eax
}
80105d48:	c9                   	leave  
80105d49:	c3                   	ret    
80105d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105d50:	e8 7b d5 ff ff       	call   801032d0 <end_op>
    return -1;
80105d55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d5a:	c9                   	leave  
80105d5b:	c3                   	ret    
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d60 <sys_chdir>:

int
sys_chdir(void)
{
80105d60:	55                   	push   %ebp
80105d61:	89 e5                	mov    %esp,%ebp
80105d63:	56                   	push   %esi
80105d64:	53                   	push   %ebx
80105d65:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105d68:	e8 f3 e1 ff ff       	call   80103f60 <myproc>
80105d6d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105d6f:	e8 ec d4 ff ff       	call   80103260 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105d74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d77:	83 ec 08             	sub    $0x8,%esp
80105d7a:	50                   	push   %eax
80105d7b:	6a 00                	push   $0x0
80105d7d:	e8 9e f5 ff ff       	call   80105320 <argstr>
80105d82:	83 c4 10             	add    $0x10,%esp
80105d85:	85 c0                	test   %eax,%eax
80105d87:	78 77                	js     80105e00 <sys_chdir+0xa0>
80105d89:	83 ec 0c             	sub    $0xc,%esp
80105d8c:	ff 75 f4             	pushl  -0xc(%ebp)
80105d8f:	e8 8c c2 ff ff       	call   80102020 <namei>
80105d94:	83 c4 10             	add    $0x10,%esp
80105d97:	85 c0                	test   %eax,%eax
80105d99:	89 c3                	mov    %eax,%ebx
80105d9b:	74 63                	je     80105e00 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105d9d:	83 ec 0c             	sub    $0xc,%esp
80105da0:	50                   	push   %eax
80105da1:	e8 1a ba ff ff       	call   801017c0 <ilock>
  if(ip->type != T_DIR){
80105da6:	83 c4 10             	add    $0x10,%esp
80105da9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105dae:	75 30                	jne    80105de0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105db0:	83 ec 0c             	sub    $0xc,%esp
80105db3:	53                   	push   %ebx
80105db4:	e8 e7 ba ff ff       	call   801018a0 <iunlock>
  iput(curproc->cwd);
80105db9:	58                   	pop    %eax
80105dba:	ff 76 68             	pushl  0x68(%esi)
80105dbd:	e8 2e bb ff ff       	call   801018f0 <iput>
  end_op();
80105dc2:	e8 09 d5 ff ff       	call   801032d0 <end_op>
  curproc->cwd = ip;
80105dc7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105dca:	83 c4 10             	add    $0x10,%esp
80105dcd:	31 c0                	xor    %eax,%eax
}
80105dcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105dd2:	5b                   	pop    %ebx
80105dd3:	5e                   	pop    %esi
80105dd4:	5d                   	pop    %ebp
80105dd5:	c3                   	ret    
80105dd6:	8d 76 00             	lea    0x0(%esi),%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	53                   	push   %ebx
80105de4:	e8 67 bc ff ff       	call   80101a50 <iunlockput>
    end_op();
80105de9:	e8 e2 d4 ff ff       	call   801032d0 <end_op>
    return -1;
80105dee:	83 c4 10             	add    $0x10,%esp
80105df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df6:	eb d7                	jmp    80105dcf <sys_chdir+0x6f>
80105df8:	90                   	nop
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e00:	e8 cb d4 ff ff       	call   801032d0 <end_op>
    return -1;
80105e05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0a:	eb c3                	jmp    80105dcf <sys_chdir+0x6f>
80105e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_exec>:

int
sys_exec(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	57                   	push   %edi
80105e14:	56                   	push   %esi
80105e15:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e16:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105e1c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e22:	50                   	push   %eax
80105e23:	6a 00                	push   $0x0
80105e25:	e8 f6 f4 ff ff       	call   80105320 <argstr>
80105e2a:	83 c4 10             	add    $0x10,%esp
80105e2d:	85 c0                	test   %eax,%eax
80105e2f:	0f 88 87 00 00 00    	js     80105ebc <sys_exec+0xac>
80105e35:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105e3b:	83 ec 08             	sub    $0x8,%esp
80105e3e:	50                   	push   %eax
80105e3f:	6a 01                	push   $0x1
80105e41:	e8 2a f4 ff ff       	call   80105270 <argint>
80105e46:	83 c4 10             	add    $0x10,%esp
80105e49:	85 c0                	test   %eax,%eax
80105e4b:	78 6f                	js     80105ebc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105e4d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105e53:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105e56:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105e58:	68 80 00 00 00       	push   $0x80
80105e5d:	6a 00                	push   $0x0
80105e5f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105e65:	50                   	push   %eax
80105e66:	e8 05 f1 ff ff       	call   80104f70 <memset>
80105e6b:	83 c4 10             	add    $0x10,%esp
80105e6e:	eb 2c                	jmp    80105e9c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105e70:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105e76:	85 c0                	test   %eax,%eax
80105e78:	74 56                	je     80105ed0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105e7a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105e80:	83 ec 08             	sub    $0x8,%esp
80105e83:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105e86:	52                   	push   %edx
80105e87:	50                   	push   %eax
80105e88:	e8 73 f3 ff ff       	call   80105200 <fetchstr>
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	85 c0                	test   %eax,%eax
80105e92:	78 28                	js     80105ebc <sys_exec+0xac>
  for(i=0;; i++){
80105e94:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105e97:	83 fb 20             	cmp    $0x20,%ebx
80105e9a:	74 20                	je     80105ebc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105e9c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105ea2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ea9:	83 ec 08             	sub    $0x8,%esp
80105eac:	57                   	push   %edi
80105ead:	01 f0                	add    %esi,%eax
80105eaf:	50                   	push   %eax
80105eb0:	e8 0b f3 ff ff       	call   801051c0 <fetchint>
80105eb5:	83 c4 10             	add    $0x10,%esp
80105eb8:	85 c0                	test   %eax,%eax
80105eba:	79 b4                	jns    80105e70 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ebf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ec4:	5b                   	pop    %ebx
80105ec5:	5e                   	pop    %esi
80105ec6:	5f                   	pop    %edi
80105ec7:	5d                   	pop    %ebp
80105ec8:	c3                   	ret    
80105ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ed0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105ed6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105ed9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ee0:	00 00 00 00 
  return exec(path, argv);
80105ee4:	50                   	push   %eax
80105ee5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105eeb:	e8 20 ab ff ff       	call   80100a10 <exec>
80105ef0:	83 c4 10             	add    $0x10,%esp
}
80105ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ef6:	5b                   	pop    %ebx
80105ef7:	5e                   	pop    %esi
80105ef8:	5f                   	pop    %edi
80105ef9:	5d                   	pop    %ebp
80105efa:	c3                   	ret    
80105efb:	90                   	nop
80105efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f00 <sys_pipe>:

int
sys_pipe(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	57                   	push   %edi
80105f04:	56                   	push   %esi
80105f05:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f06:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105f09:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f0c:	6a 08                	push   $0x8
80105f0e:	50                   	push   %eax
80105f0f:	6a 00                	push   $0x0
80105f11:	e8 aa f3 ff ff       	call   801052c0 <argptr>
80105f16:	83 c4 10             	add    $0x10,%esp
80105f19:	85 c0                	test   %eax,%eax
80105f1b:	0f 88 ae 00 00 00    	js     80105fcf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105f21:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f24:	83 ec 08             	sub    $0x8,%esp
80105f27:	50                   	push   %eax
80105f28:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105f2b:	50                   	push   %eax
80105f2c:	e8 cf d9 ff ff       	call   80103900 <pipealloc>
80105f31:	83 c4 10             	add    $0x10,%esp
80105f34:	85 c0                	test   %eax,%eax
80105f36:	0f 88 93 00 00 00    	js     80105fcf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f3c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105f3f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105f41:	e8 1a e0 ff ff       	call   80103f60 <myproc>
80105f46:	eb 10                	jmp    80105f58 <sys_pipe+0x58>
80105f48:	90                   	nop
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105f50:	83 c3 01             	add    $0x1,%ebx
80105f53:	83 fb 10             	cmp    $0x10,%ebx
80105f56:	74 60                	je     80105fb8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105f58:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105f5c:	85 f6                	test   %esi,%esi
80105f5e:	75 f0                	jne    80105f50 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105f60:	8d 73 08             	lea    0x8(%ebx),%esi
80105f63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105f6a:	e8 f1 df ff ff       	call   80103f60 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f6f:	31 d2                	xor    %edx,%edx
80105f71:	eb 0d                	jmp    80105f80 <sys_pipe+0x80>
80105f73:	90                   	nop
80105f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f78:	83 c2 01             	add    $0x1,%edx
80105f7b:	83 fa 10             	cmp    $0x10,%edx
80105f7e:	74 28                	je     80105fa8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105f80:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105f84:	85 c9                	test   %ecx,%ecx
80105f86:	75 f0                	jne    80105f78 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105f88:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105f8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f8f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105f91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f94:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105f97:	31 c0                	xor    %eax,%eax
}
80105f99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f9c:	5b                   	pop    %ebx
80105f9d:	5e                   	pop    %esi
80105f9e:	5f                   	pop    %edi
80105f9f:	5d                   	pop    %ebp
80105fa0:	c3                   	ret    
80105fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105fa8:	e8 b3 df ff ff       	call   80103f60 <myproc>
80105fad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105fb4:	00 
80105fb5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105fb8:	83 ec 0c             	sub    $0xc,%esp
80105fbb:	ff 75 e0             	pushl  -0x20(%ebp)
80105fbe:	e8 bd af ff ff       	call   80100f80 <fileclose>
    fileclose(wf);
80105fc3:	58                   	pop    %eax
80105fc4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105fc7:	e8 b4 af ff ff       	call   80100f80 <fileclose>
    return -1;
80105fcc:	83 c4 10             	add    $0x10,%esp
80105fcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd4:	eb c3                	jmp    80105f99 <sys_pipe+0x99>
80105fd6:	66 90                	xchg   %ax,%ax
80105fd8:	66 90                	xchg   %ax,%ax
80105fda:	66 90                	xchg   %ax,%ax
80105fdc:	66 90                	xchg   %ax,%ax
80105fde:	66 90                	xchg   %ax,%ax

80105fe0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105fe3:	5d                   	pop    %ebp
  return fork();
80105fe4:	e9 37 e1 ff ff       	jmp    80104120 <fork>
80105fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_exit>:

int
sys_exit(void)
{
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ff6:	e8 b5 e4 ff ff       	call   801044b0 <exit>
  return 0;  // not reached
}
80105ffb:	31 c0                	xor    %eax,%eax
80105ffd:	c9                   	leave  
80105ffe:	c3                   	ret    
80105fff:	90                   	nop

80106000 <sys_wait>:

int
sys_wait(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106003:	5d                   	pop    %ebp
  return wait();
80106004:	e9 17 e7 ff ff       	jmp    80104720 <wait>
80106009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106010 <sys_kill>:

int
sys_kill(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106016:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106019:	50                   	push   %eax
8010601a:	6a 00                	push   $0x0
8010601c:	e8 4f f2 ff ff       	call   80105270 <argint>
80106021:	83 c4 10             	add    $0x10,%esp
80106024:	85 c0                	test   %eax,%eax
80106026:	78 18                	js     80106040 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106028:	83 ec 0c             	sub    $0xc,%esp
8010602b:	ff 75 f4             	pushl  -0xc(%ebp)
8010602e:	e8 4d e8 ff ff       	call   80104880 <kill>
80106033:	83 c4 10             	add    $0x10,%esp
}
80106036:	c9                   	leave  
80106037:	c3                   	ret    
80106038:	90                   	nop
80106039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106045:	c9                   	leave  
80106046:	c3                   	ret    
80106047:	89 f6                	mov    %esi,%esi
80106049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106050 <sys_getpid>:

int
sys_getpid(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106056:	e8 05 df ff ff       	call   80103f60 <myproc>
8010605b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010605e:	c9                   	leave  
8010605f:	c3                   	ret    

80106060 <sys_sbrk>:

int
sys_sbrk(void)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
80106064:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106067:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010606a:	50                   	push   %eax
8010606b:	6a 00                	push   $0x0
8010606d:	e8 fe f1 ff ff       	call   80105270 <argint>
80106072:	83 c4 10             	add    $0x10,%esp
80106075:	85 c0                	test   %eax,%eax
80106077:	78 27                	js     801060a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106079:	e8 e2 de ff ff       	call   80103f60 <myproc>
  if(growproc(n) < 0)
8010607e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106081:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106083:	ff 75 f4             	pushl  -0xc(%ebp)
80106086:	e8 15 e0 ff ff       	call   801040a0 <growproc>
8010608b:	83 c4 10             	add    $0x10,%esp
8010608e:	85 c0                	test   %eax,%eax
80106090:	78 0e                	js     801060a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106092:	89 d8                	mov    %ebx,%eax
80106094:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106097:	c9                   	leave  
80106098:	c3                   	ret    
80106099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801060a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801060a5:	eb eb                	jmp    80106092 <sys_sbrk+0x32>
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060b0 <sys_sleep>:

int
sys_sleep(void)
{
801060b0:	55                   	push   %ebp
801060b1:	89 e5                	mov    %esp,%ebp
801060b3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801060b4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801060b7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801060ba:	50                   	push   %eax
801060bb:	6a 00                	push   $0x0
801060bd:	e8 ae f1 ff ff       	call   80105270 <argint>
801060c2:	83 c4 10             	add    $0x10,%esp
801060c5:	85 c0                	test   %eax,%eax
801060c7:	0f 88 8a 00 00 00    	js     80106157 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801060cd:	83 ec 0c             	sub    $0xc,%esp
801060d0:	68 80 a3 15 80       	push   $0x8015a380
801060d5:	e8 86 ed ff ff       	call   80104e60 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801060da:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060dd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801060e0:	8b 1d c0 ab 15 80    	mov    0x8015abc0,%ebx
  while(ticks - ticks0 < n){
801060e6:	85 d2                	test   %edx,%edx
801060e8:	75 27                	jne    80106111 <sys_sleep+0x61>
801060ea:	eb 54                	jmp    80106140 <sys_sleep+0x90>
801060ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801060f0:	83 ec 08             	sub    $0x8,%esp
801060f3:	68 80 a3 15 80       	push   $0x8015a380
801060f8:	68 c0 ab 15 80       	push   $0x8015abc0
801060fd:	e8 5e e5 ff ff       	call   80104660 <sleep>
  while(ticks - ticks0 < n){
80106102:	a1 c0 ab 15 80       	mov    0x8015abc0,%eax
80106107:	83 c4 10             	add    $0x10,%esp
8010610a:	29 d8                	sub    %ebx,%eax
8010610c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010610f:	73 2f                	jae    80106140 <sys_sleep+0x90>
    if(myproc()->killed){
80106111:	e8 4a de ff ff       	call   80103f60 <myproc>
80106116:	8b 40 24             	mov    0x24(%eax),%eax
80106119:	85 c0                	test   %eax,%eax
8010611b:	74 d3                	je     801060f0 <sys_sleep+0x40>
      release(&tickslock);
8010611d:	83 ec 0c             	sub    $0xc,%esp
80106120:	68 80 a3 15 80       	push   $0x8015a380
80106125:	e8 f6 ed ff ff       	call   80104f20 <release>
      return -1;
8010612a:	83 c4 10             	add    $0x10,%esp
8010612d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80106132:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106135:	c9                   	leave  
80106136:	c3                   	ret    
80106137:	89 f6                	mov    %esi,%esi
80106139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80106140:	83 ec 0c             	sub    $0xc,%esp
80106143:	68 80 a3 15 80       	push   $0x8015a380
80106148:	e8 d3 ed ff ff       	call   80104f20 <release>
  return 0;
8010614d:	83 c4 10             	add    $0x10,%esp
80106150:	31 c0                	xor    %eax,%eax
}
80106152:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106155:	c9                   	leave  
80106156:	c3                   	ret    
    return -1;
80106157:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010615c:	eb f4                	jmp    80106152 <sys_sleep+0xa2>
8010615e:	66 90                	xchg   %ax,%ax

80106160 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106160:	55                   	push   %ebp
80106161:	89 e5                	mov    %esp,%ebp
80106163:	53                   	push   %ebx
80106164:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106167:	68 80 a3 15 80       	push   $0x8015a380
8010616c:	e8 ef ec ff ff       	call   80104e60 <acquire>
  xticks = ticks;
80106171:	8b 1d c0 ab 15 80    	mov    0x8015abc0,%ebx
  release(&tickslock);
80106177:	c7 04 24 80 a3 15 80 	movl   $0x8015a380,(%esp)
8010617e:	e8 9d ed ff ff       	call   80104f20 <release>
  return xticks;
}
80106183:	89 d8                	mov    %ebx,%eax
80106185:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106188:	c9                   	leave  
80106189:	c3                   	ret    
8010618a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106190 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
80106190:	55                   	push   %ebp
80106191:	89 e5                	mov    %esp,%ebp
  return numFreePages();
}
80106193:	5d                   	pop    %ebp
  return numFreePages();
80106194:	e9 e7 c8 ff ff       	jmp    80102a80 <numFreePages>
80106199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061a0 <sys_printProcDump>:

int
sys_printProcDump(void){
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	53                   	push   %ebx
  int pid;
  if(argint(0, &pid) < 0)
801061a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
sys_printProcDump(void){
801061a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &pid) < 0)
801061aa:	50                   	push   %eax
801061ab:	6a 00                	push   $0x0
801061ad:	e8 be f0 ff ff       	call   80105270 <argint>
801061b2:	83 c4 10             	add    $0x10,%esp
801061b5:	85 c0                	test   %eax,%eax
801061b7:	78 2f                	js     801061e8 <sys_printProcDump+0x48>
    return -1;
  if(pid == 0){
801061b9:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801061bc:	85 db                	test   %ebx,%ebx
801061be:	74 18                	je     801061d8 <sys_printProcDump+0x38>
    procdump();
  }else{
    singleProcDump(pid);
801061c0:	83 ec 0c             	sub    $0xc,%esp
801061c3:	53                   	push   %ebx
  }
  return 0;
801061c4:	31 db                	xor    %ebx,%ebx
    singleProcDump(pid);
801061c6:	e8 25 e9 ff ff       	call   80104af0 <singleProcDump>
801061cb:	83 c4 10             	add    $0x10,%esp
801061ce:	89 d8                	mov    %ebx,%eax
801061d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061d3:	c9                   	leave  
801061d4:	c3                   	ret    
801061d5:	8d 76 00             	lea    0x0(%esi),%esi
    procdump();
801061d8:	e8 23 e7 ff ff       	call   80104900 <procdump>
801061dd:	89 d8                	mov    %ebx,%eax
801061df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061e2:	c9                   	leave  
801061e3:	c3                   	ret    
801061e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801061e8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801061ed:	eb df                	jmp    801061ce <sys_printProcDump+0x2e>

801061ef <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801061ef:	1e                   	push   %ds
  pushl %es
801061f0:	06                   	push   %es
  pushl %fs
801061f1:	0f a0                	push   %fs
  pushl %gs
801061f3:	0f a8                	push   %gs
  pushal
801061f5:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801061f6:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801061fa:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801061fc:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801061fe:	54                   	push   %esp
  call trap
801061ff:	e8 cc 00 00 00       	call   801062d0 <trap>
  addl $4, %esp
80106204:	83 c4 04             	add    $0x4,%esp

80106207 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106207:	61                   	popa   
  popl %gs
80106208:	0f a9                	pop    %gs
  popl %fs
8010620a:	0f a1                	pop    %fs
  popl %es
8010620c:	07                   	pop    %es
  popl %ds
8010620d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010620e:	83 c4 08             	add    $0x8,%esp
  iret
80106211:	cf                   	iret   
80106212:	66 90                	xchg   %ax,%ax
80106214:	66 90                	xchg   %ax,%ax
80106216:	66 90                	xchg   %ax,%ax
80106218:	66 90                	xchg   %ax,%ax
8010621a:	66 90                	xchg   %ax,%ax
8010621c:	66 90                	xchg   %ax,%ax
8010621e:	66 90                	xchg   %ax,%ax

80106220 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106220:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106221:	31 c0                	xor    %eax,%eax
{
80106223:	89 e5                	mov    %esp,%ebp
80106225:	83 ec 08             	sub    $0x8,%esp
80106228:	90                   	nop
80106229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106230:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106237:	c7 04 c5 c2 a3 15 80 	movl   $0x8e000008,-0x7fea5c3e(,%eax,8)
8010623e:	08 00 00 8e 
80106242:	66 89 14 c5 c0 a3 15 	mov    %dx,-0x7fea5c40(,%eax,8)
80106249:	80 
8010624a:	c1 ea 10             	shr    $0x10,%edx
8010624d:	66 89 14 c5 c6 a3 15 	mov    %dx,-0x7fea5c3a(,%eax,8)
80106254:	80 
  for(i = 0; i < 256; i++)
80106255:	83 c0 01             	add    $0x1,%eax
80106258:	3d 00 01 00 00       	cmp    $0x100,%eax
8010625d:	75 d1                	jne    80106230 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010625f:	a1 08 c1 10 80       	mov    0x8010c108,%eax

  initlock(&tickslock, "time");
80106264:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106267:	c7 05 c2 a5 15 80 08 	movl   $0xef000008,0x8015a5c2
8010626e:	00 00 ef 
  initlock(&tickslock, "time");
80106271:	68 1d 8d 10 80       	push   $0x80108d1d
80106276:	68 80 a3 15 80       	push   $0x8015a380
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010627b:	66 a3 c0 a5 15 80    	mov    %ax,0x8015a5c0
80106281:	c1 e8 10             	shr    $0x10,%eax
80106284:	66 a3 c6 a5 15 80    	mov    %ax,0x8015a5c6
  initlock(&tickslock, "time");
8010628a:	e8 91 ea ff ff       	call   80104d20 <initlock>
}
8010628f:	83 c4 10             	add    $0x10,%esp
80106292:	c9                   	leave  
80106293:	c3                   	ret    
80106294:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010629a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801062a0 <idtinit>:

void
idtinit(void)
{
801062a0:	55                   	push   %ebp
  pd[0] = size-1;
801062a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801062a6:	89 e5                	mov    %esp,%ebp
801062a8:	83 ec 10             	sub    $0x10,%esp
801062ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801062af:	b8 c0 a3 15 80       	mov    $0x8015a3c0,%eax
801062b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801062b8:	c1 e8 10             	shr    $0x10,%eax
801062bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801062bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801062c2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801062c5:	c9                   	leave  
801062c6:	c3                   	ret    
801062c7:	89 f6                	mov    %esi,%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062d0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	57                   	push   %edi
801062d4:	56                   	push   %esi
801062d5:	53                   	push   %ebx
801062d6:	83 ec 1c             	sub    $0x1c,%esp
801062d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
801062dc:	8b 47 30             	mov    0x30(%edi),%eax
801062df:	83 f8 40             	cmp    $0x40,%eax
801062e2:	0f 84 e8 00 00 00    	je     801063d0 <trap+0x100>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801062e8:	83 e8 0e             	sub    $0xe,%eax
801062eb:	83 f8 31             	cmp    $0x31,%eax
801062ee:	0f 87 bc 01 00 00    	ja     801064b0 <trap+0x1e0>
801062f4:	ff 24 85 f8 8d 10 80 	jmp    *-0x7fef7208(,%eax,4)
801062fb:	90                   	nop
801062fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_PGFLT:
    #ifndef NONE
    // TODO: Chek for illigal addr
    
      #ifdef NFUA  //there is commented version in tick trap
        nfuaTickUpdate();
80106300:	e8 eb e6 ff ff       	call   801049f0 <nfuaTickUpdate>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106305:	0f 20 d3             	mov    %cr2,%ebx

      addr = rcr2();
      //pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
      //pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
      //pte_t *pte = &pgtab[PTX(addr)];
      pte_t *pte = walkpgdir(myproc()->pgdir,(char*)addr,0);
80106308:	e8 53 dc ff ff       	call   80103f60 <myproc>
  if(*pde & PTE_P){
8010630d:	8b 40 04             	mov    0x4(%eax),%eax
  pde = &pgdir[PDX(va)];
80106310:	89 da                	mov    %ebx,%edx
80106312:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106315:	8b 04 90             	mov    (%eax,%edx,4),%eax
80106318:	a8 01                	test   $0x1,%al
8010631a:	0f 84 08 02 00 00    	je     80106528 <trap+0x258>
  return &pgtab[PTX(va)];
80106320:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106322:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106327:	c1 ea 0a             	shr    $0xa,%edx
8010632a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106330:	8d b4 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%esi
      uint pa = PTE_ADDR(*pte);
80106337:	8b 06                	mov    (%esi),%eax

      //int inSwapFile = (((uint*)PTE_ADDR(P2V(*vaddr)))[PTX(addr)] & PTE_PG);
      //cprintf("first %x %x\n",pa,addr);
      

      if((*pte & PTE_U ) == 0){
80106339:	a8 04                	test   $0x4,%al
8010633b:	74 2b                	je     80106368 <trap+0x98>
      }

      //cprintf("trap!\n");

      //cprintf("PGFLT: ");
      if(*pte & PTE_PG){
8010633d:	f6 c4 02             	test   $0x2,%ah
80106340:	0f 85 32 02 00 00    	jne    80106578 <trap+0x2a8>
        //cprintf("swapping: %x\n",PGROUNDDOWN(addr));
        myproc()->nPGFLT++;
        swapPage(addr);
        lcr3(V2P(myproc()->pgdir));
      }
      else if((*pte & PTE_W) == 0) {
80106346:	a8 02                	test   $0x2,%al
80106348:	75 09                	jne    80106353 <trap+0x83>
        //cprintf("trap: %x\n",addr);
        if((*pte & PTE_COW) != 0){
8010634a:	f6 c4 08             	test   $0x8,%ah
8010634d:	0f 85 52 02 00 00    	jne    801065a5 <trap+0x2d5>
      }/*else{
        cprintf("pid: %d\n",myproc()->pid);
        panic("trap: PF fault");
      }*/
      
      lcr3(V2P(myproc()->pgdir));
80106353:	e8 08 dc ff ff       	call   80103f60 <myproc>
80106358:	8b 40 04             	mov    0x4(%eax),%eax
8010635b:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106360:	0f 22 d8             	mov    %eax,%cr3
80106363:	90                   	nop
80106364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106368:	e8 f3 db ff ff       	call   80103f60 <myproc>
8010636d:	85 c0                	test   %eax,%eax
8010636f:	74 1d                	je     8010638e <trap+0xbe>
80106371:	e8 ea db ff ff       	call   80103f60 <myproc>
80106376:	8b 50 24             	mov    0x24(%eax),%edx
80106379:	85 d2                	test   %edx,%edx
8010637b:	74 11                	je     8010638e <trap+0xbe>
8010637d:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106381:	83 e0 03             	and    $0x3,%eax
80106384:	66 83 f8 03          	cmp    $0x3,%ax
80106388:	0f 84 a2 01 00 00    	je     80106530 <trap+0x260>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
8010638e:	e8 cd db ff ff       	call   80103f60 <myproc>
80106393:	85 c0                	test   %eax,%eax
80106395:	74 0b                	je     801063a2 <trap+0xd2>
80106397:	e8 c4 db ff ff       	call   80103f60 <myproc>
8010639c:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801063a0:	74 66                	je     80106408 <trap+0x138>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801063a2:	e8 b9 db ff ff       	call   80103f60 <myproc>
801063a7:	85 c0                	test   %eax,%eax
801063a9:	74 19                	je     801063c4 <trap+0xf4>
801063ab:	e8 b0 db ff ff       	call   80103f60 <myproc>
801063b0:	8b 40 24             	mov    0x24(%eax),%eax
801063b3:	85 c0                	test   %eax,%eax
801063b5:	74 0d                	je     801063c4 <trap+0xf4>
801063b7:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801063bb:	83 e0 03             	and    $0x3,%eax
801063be:	66 83 f8 03          	cmp    $0x3,%ax
801063c2:	74 35                	je     801063f9 <trap+0x129>
    exit();
}
801063c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063c7:	5b                   	pop    %ebx
801063c8:	5e                   	pop    %esi
801063c9:	5f                   	pop    %edi
801063ca:	5d                   	pop    %ebp
801063cb:	c3                   	ret    
801063cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801063d0:	e8 8b db ff ff       	call   80103f60 <myproc>
801063d5:	8b 70 24             	mov    0x24(%eax),%esi
801063d8:	85 f6                	test   %esi,%esi
801063da:	0f 85 c0 00 00 00    	jne    801064a0 <trap+0x1d0>
    myproc()->tf = tf;
801063e0:	e8 7b db ff ff       	call   80103f60 <myproc>
801063e5:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801063e8:	e8 73 ef ff ff       	call   80105360 <syscall>
    if(myproc()->killed)
801063ed:	e8 6e db ff ff       	call   80103f60 <myproc>
801063f2:	8b 58 24             	mov    0x24(%eax),%ebx
801063f5:	85 db                	test   %ebx,%ebx
801063f7:	74 cb                	je     801063c4 <trap+0xf4>
}
801063f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063fc:	5b                   	pop    %ebx
801063fd:	5e                   	pop    %esi
801063fe:	5f                   	pop    %edi
801063ff:	5d                   	pop    %ebp
      exit();
80106400:	e9 ab e0 ff ff       	jmp    801044b0 <exit>
80106405:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
80106408:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
8010640c:	75 94                	jne    801063a2 <trap+0xd2>
    yield();
8010640e:	e8 fd e1 ff ff       	call   80104610 <yield>
80106413:	eb 8d                	jmp    801063a2 <trap+0xd2>
80106415:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106418:	e8 23 db ff ff       	call   80103f40 <cpuid>
8010641d:	85 c0                	test   %eax,%eax
8010641f:	0f 84 1b 01 00 00    	je     80106540 <trap+0x270>
    lapiceoi();
80106425:	e8 e6 c9 ff ff       	call   80102e10 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010642a:	e8 31 db ff ff       	call   80103f60 <myproc>
8010642f:	85 c0                	test   %eax,%eax
80106431:	0f 85 3a ff ff ff    	jne    80106371 <trap+0xa1>
80106437:	e9 52 ff ff ff       	jmp    8010638e <trap+0xbe>
8010643c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106440:	e8 8b c8 ff ff       	call   80102cd0 <kbdintr>
    lapiceoi();
80106445:	e8 c6 c9 ff ff       	call   80102e10 <lapiceoi>
    break;
8010644a:	e9 19 ff ff ff       	jmp    80106368 <trap+0x98>
8010644f:	90                   	nop
    uartintr();
80106450:	e8 1b 04 00 00       	call   80106870 <uartintr>
    lapiceoi();
80106455:	e8 b6 c9 ff ff       	call   80102e10 <lapiceoi>
    break;
8010645a:	e9 09 ff ff ff       	jmp    80106368 <trap+0x98>
8010645f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106460:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106464:	8b 77 38             	mov    0x38(%edi),%esi
80106467:	e8 d4 da ff ff       	call   80103f40 <cpuid>
8010646c:	56                   	push   %esi
8010646d:	53                   	push   %ebx
8010646e:	50                   	push   %eax
8010646f:	68 28 8d 10 80       	push   $0x80108d28
80106474:	e8 e7 a1 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106479:	e8 92 c9 ff ff       	call   80102e10 <lapiceoi>
    break;
8010647e:	83 c4 10             	add    $0x10,%esp
80106481:	e9 e2 fe ff ff       	jmp    80106368 <trap+0x98>
80106486:	8d 76 00             	lea    0x0(%esi),%esi
80106489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
80106490:	e8 bb c0 ff ff       	call   80102550 <ideintr>
80106495:	eb 8e                	jmp    80106425 <trap+0x155>
80106497:	89 f6                	mov    %esi,%esi
80106499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
801064a0:	e8 0b e0 ff ff       	call   801044b0 <exit>
801064a5:	e9 36 ff ff ff       	jmp    801063e0 <trap+0x110>
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801064b0:	e8 ab da ff ff       	call   80103f60 <myproc>
801064b5:	85 c0                	test   %eax,%eax
801064b7:	8b 5f 38             	mov    0x38(%edi),%ebx
801064ba:	0f 84 15 02 00 00    	je     801066d5 <trap+0x405>
801064c0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801064c4:	0f 84 0b 02 00 00    	je     801066d5 <trap+0x405>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064ca:	0f 20 d1             	mov    %cr2,%ecx
801064cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064d0:	e8 6b da ff ff       	call   80103f40 <cpuid>
801064d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801064d8:	8b 47 34             	mov    0x34(%edi),%eax
801064db:	8b 77 30             	mov    0x30(%edi),%esi
801064de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801064e1:	e8 7a da ff ff       	call   80103f60 <myproc>
801064e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801064e9:	e8 72 da ff ff       	call   80103f60 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801064f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801064f4:	51                   	push   %ecx
801064f5:	53                   	push   %ebx
801064f6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801064f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064fa:	ff 75 e4             	pushl  -0x1c(%ebp)
801064fd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801064fe:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106501:	52                   	push   %edx
80106502:	ff 70 10             	pushl  0x10(%eax)
80106505:	68 b4 8d 10 80       	push   $0x80108db4
8010650a:	e8 51 a1 ff ff       	call   80100660 <cprintf>
    myproc()->killed = 1;
8010650f:	83 c4 20             	add    $0x20,%esp
80106512:	e8 49 da ff ff       	call   80103f60 <myproc>
80106517:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010651e:	e9 45 fe ff ff       	jmp    80106368 <trap+0x98>
80106523:	90                   	nop
80106524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      uint pa = PTE_ADDR(*pte);
80106528:	a1 00 00 00 00       	mov    0x0,%eax
8010652d:	0f 0b                	ud2    
8010652f:	90                   	nop
    exit();
80106530:	e8 7b df ff ff       	call   801044b0 <exit>
80106535:	e9 54 fe ff ff       	jmp    8010638e <trap+0xbe>
8010653a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106540:	83 ec 0c             	sub    $0xc,%esp
80106543:	68 80 a3 15 80       	push   $0x8015a380
80106548:	e8 13 e9 ff ff       	call   80104e60 <acquire>
      wakeup(&ticks);
8010654d:	c7 04 24 c0 ab 15 80 	movl   $0x8015abc0,(%esp)
      ticks++;
80106554:	83 05 c0 ab 15 80 01 	addl   $0x1,0x8015abc0
      wakeup(&ticks);
8010655b:	e8 c0 e2 ff ff       	call   80104820 <wakeup>
      release(&tickslock);
80106560:	c7 04 24 80 a3 15 80 	movl   $0x8015a380,(%esp)
80106567:	e8 b4 e9 ff ff       	call   80104f20 <release>
8010656c:	83 c4 10             	add    $0x10,%esp
8010656f:	e9 b1 fe ff ff       	jmp    80106425 <trap+0x155>
80106574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        myproc()->nPGFLT++;
80106578:	e8 e3 d9 ff ff       	call   80103f60 <myproc>
8010657d:	83 80 8c 00 00 00 01 	addl   $0x1,0x8c(%eax)
        swapPage(addr);
80106584:	83 ec 0c             	sub    $0xc,%esp
80106587:	53                   	push   %ebx
80106588:	e8 33 1b 00 00       	call   801080c0 <swapPage>
        lcr3(V2P(myproc()->pgdir));
8010658d:	e8 ce d9 ff ff       	call   80103f60 <myproc>
80106592:	8b 40 04             	mov    0x4(%eax),%eax
80106595:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010659a:	0f 22 d8             	mov    %eax,%cr3
8010659d:	83 c4 10             	add    $0x10,%esp
801065a0:	e9 ae fd ff ff       	jmp    80106353 <trap+0x83>
      uint pa = PTE_ADDR(*pte);
801065a5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
          uint refCount = getReferenceCount(pa);
801065aa:	83 ec 0c             	sub    $0xc,%esp
801065ad:	50                   	push   %eax
      uint pa = PTE_ADDR(*pte);
801065ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
          uint refCount = getReferenceCount(pa);
801065b1:	e8 da c5 ff ff       	call   80102b90 <getReferenceCount>
          if(refCount > 1) {
801065b6:	83 c4 10             	add    $0x10,%esp
801065b9:	83 f8 01             	cmp    $0x1,%eax
801065bc:	0f 86 c1 00 00 00    	jbe    80106683 <trap+0x3b3>
801065c2:	89 d8                	mov    %ebx,%eax
          for(k = 0 ; k <  MAX_PSYC_PAGES; k++){
801065c4:	31 db                	xor    %ebx,%ebx
801065c6:	89 75 e0             	mov    %esi,-0x20(%ebp)
801065c9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801065ce:	89 de                	mov    %ebx,%esi
801065d0:	89 c3                	mov    %eax,%ebx
801065d2:	eb 10                	jmp    801065e4 <trap+0x314>
801065d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065d8:	83 c6 01             	add    $0x1,%esi
801065db:	83 fe 10             	cmp    $0x10,%esi
801065de:	0f 84 9a 00 00 00    	je     8010667e <trap+0x3ae>
            if(myproc()->physicalPGs[k].va == (char*)PGROUNDDOWN(addr)){
801065e4:	e8 77 d9 ff ff       	call   80103f60 <myproc>
801065e9:	8d 14 76             	lea    (%esi,%esi,2),%edx
801065ec:	c1 e2 03             	shl    $0x3,%edx
801065ef:	39 9c 10 d8 01 00 00 	cmp    %ebx,0x1d8(%eax,%edx,1)
801065f6:	75 e0                	jne    801065d8 <trap+0x308>
801065f8:	8b 75 e0             	mov    -0x20(%ebp),%esi
801065fb:	89 55 e0             	mov    %edx,-0x20(%ebp)
              myproc()->physicalPGs[k].alloceted = 1;
801065fe:	e8 5d d9 ff ff       	call   80103f60 <myproc>
80106603:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106606:	c7 84 10 e4 01 00 00 	movl   $0x1,0x1e4(%eax,%edx,1)
8010660d:	01 00 00 00 
              myproc()->physicalPGs[k].age = 0;
80106611:	e8 4a d9 ff ff       	call   80103f60 <myproc>
80106616:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106619:	c7 84 10 e0 01 00 00 	movl   $0x0,0x1e0(%eax,%edx,1)
80106620:	00 00 00 00 
            if((mem = kalloc()) == 0) {
80106624:	e8 c7 c3 ff ff       	call   801029f0 <kalloc>
80106629:	85 c0                	test   %eax,%eax
8010662b:	89 c3                	mov    %eax,%ebx
8010662d:	74 73                	je     801066a2 <trap+0x3d2>
            memmove(mem, (char*)P2V(pa), PGSIZE);
8010662f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106632:	83 ec 04             	sub    $0x4,%esp
80106635:	68 00 10 00 00       	push   $0x1000
8010663a:	05 00 00 00 80       	add    $0x80000000,%eax
8010663f:	50                   	push   %eax
80106640:	53                   	push   %ebx
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
80106641:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
            memmove(mem, (char*)P2V(pa), PGSIZE);
80106647:	e8 d4 e9 ff ff       	call   80105020 <memmove>
            *pte = V2P(mem) | PTE_P | PTE_W | PTE_FLAGS(*pte);
8010664c:	8b 06                	mov    (%esi),%eax
8010664e:	25 ff 0f 00 00       	and    $0xfff,%eax
80106653:	09 d8                	or     %ebx,%eax
            *pte &= ~PTE_COW;
80106655:	80 e4 f7             	and    $0xf7,%ah
80106658:	83 c8 03             	or     $0x3,%eax
8010665b:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
8010665d:	e8 fe d8 ff ff       	call   80103f60 <myproc>
80106662:	8b 40 04             	mov    0x4(%eax),%eax
80106665:	05 00 00 00 80       	add    $0x80000000,%eax
8010666a:	0f 22 d8             	mov    %eax,%cr3
            decrementReferenceCount(pa);
8010666d:	59                   	pop    %ecx
8010666e:	ff 75 e4             	pushl  -0x1c(%ebp)
80106671:	e8 5a c4 ff ff       	call   80102ad0 <decrementReferenceCount>
80106676:	83 c4 10             	add    $0x10,%esp
80106679:	e9 d5 fc ff ff       	jmp    80106353 <trap+0x83>
8010667e:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106681:	eb a1                	jmp    80106624 <trap+0x354>
            *pte &= ~PTE_COW;
80106683:	8b 06                	mov    (%esi),%eax
80106685:	80 e4 f7             	and    $0xf7,%ah
80106688:	83 c8 02             	or     $0x2,%eax
8010668b:	89 06                	mov    %eax,(%esi)
            lcr3(V2P(myproc()->pgdir));
8010668d:	e8 ce d8 ff ff       	call   80103f60 <myproc>
80106692:	8b 40 04             	mov    0x4(%eax),%eax
80106695:	05 00 00 00 80       	add    $0x80000000,%eax
8010669a:	0f 22 d8             	mov    %eax,%cr3
8010669d:	e9 b1 fc ff ff       	jmp    80106353 <trap+0x83>
              cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
801066a2:	e8 b9 d8 ff ff       	call   80103f60 <myproc>
801066a7:	8b 58 10             	mov    0x10(%eax),%ebx
801066aa:	e8 b1 d8 ff ff       	call   80103f60 <myproc>
801066af:	83 ec 04             	sub    $0x4,%esp
801066b2:	83 c0 6c             	add    $0x6c,%eax
801066b5:	53                   	push   %ebx
801066b6:	50                   	push   %eax
801066b7:	68 4c 8d 10 80       	push   $0x80108d4c
801066bc:	e8 9f 9f ff ff       	call   80100660 <cprintf>
              myproc()->killed = 1;
801066c1:	e8 9a d8 ff ff       	call   80103f60 <myproc>
              return;
801066c6:	83 c4 10             	add    $0x10,%esp
              myproc()->killed = 1;
801066c9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
              return;
801066d0:	e9 ef fc ff ff       	jmp    801063c4 <trap+0xf4>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801066d5:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801066d8:	e8 63 d8 ff ff       	call   80103f40 <cpuid>
801066dd:	83 ec 0c             	sub    $0xc,%esp
801066e0:	56                   	push   %esi
801066e1:	53                   	push   %ebx
801066e2:	50                   	push   %eax
801066e3:	ff 77 30             	pushl  0x30(%edi)
801066e6:	68 80 8d 10 80       	push   $0x80108d80
801066eb:	e8 70 9f ff ff       	call   80100660 <cprintf>
      panic("trap");
801066f0:	83 c4 14             	add    $0x14,%esp
801066f3:	68 22 8d 10 80       	push   $0x80108d22
801066f8:	e8 93 9c ff ff       	call   80100390 <panic>
801066fd:	66 90                	xchg   %ax,%ax
801066ff:	90                   	nop

80106700 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106700:	a1 bc c5 10 80       	mov    0x8010c5bc,%eax
{
80106705:	55                   	push   %ebp
80106706:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106708:	85 c0                	test   %eax,%eax
8010670a:	74 1c                	je     80106728 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010670c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106711:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106712:	a8 01                	test   $0x1,%al
80106714:	74 12                	je     80106728 <uartgetc+0x28>
80106716:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010671b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010671c:	0f b6 c0             	movzbl %al,%eax
}
8010671f:	5d                   	pop    %ebp
80106720:	c3                   	ret    
80106721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010672d:	5d                   	pop    %ebp
8010672e:	c3                   	ret    
8010672f:	90                   	nop

80106730 <uartputc.part.0>:
uartputc(int c)
80106730:	55                   	push   %ebp
80106731:	89 e5                	mov    %esp,%ebp
80106733:	57                   	push   %edi
80106734:	56                   	push   %esi
80106735:	53                   	push   %ebx
80106736:	89 c7                	mov    %eax,%edi
80106738:	bb 80 00 00 00       	mov    $0x80,%ebx
8010673d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106742:	83 ec 0c             	sub    $0xc,%esp
80106745:	eb 1b                	jmp    80106762 <uartputc.part.0+0x32>
80106747:	89 f6                	mov    %esi,%esi
80106749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106750:	83 ec 0c             	sub    $0xc,%esp
80106753:	6a 0a                	push   $0xa
80106755:	e8 d6 c6 ff ff       	call   80102e30 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010675a:	83 c4 10             	add    $0x10,%esp
8010675d:	83 eb 01             	sub    $0x1,%ebx
80106760:	74 07                	je     80106769 <uartputc.part.0+0x39>
80106762:	89 f2                	mov    %esi,%edx
80106764:	ec                   	in     (%dx),%al
80106765:	a8 20                	test   $0x20,%al
80106767:	74 e7                	je     80106750 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106769:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010676e:	89 f8                	mov    %edi,%eax
80106770:	ee                   	out    %al,(%dx)
}
80106771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106774:	5b                   	pop    %ebx
80106775:	5e                   	pop    %esi
80106776:	5f                   	pop    %edi
80106777:	5d                   	pop    %ebp
80106778:	c3                   	ret    
80106779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106780 <uartinit>:
{
80106780:	55                   	push   %ebp
80106781:	31 c9                	xor    %ecx,%ecx
80106783:	89 c8                	mov    %ecx,%eax
80106785:	89 e5                	mov    %esp,%ebp
80106787:	57                   	push   %edi
80106788:	56                   	push   %esi
80106789:	53                   	push   %ebx
8010678a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010678f:	89 da                	mov    %ebx,%edx
80106791:	83 ec 0c             	sub    $0xc,%esp
80106794:	ee                   	out    %al,(%dx)
80106795:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010679a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010679f:	89 fa                	mov    %edi,%edx
801067a1:	ee                   	out    %al,(%dx)
801067a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801067a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067ac:	ee                   	out    %al,(%dx)
801067ad:	be f9 03 00 00       	mov    $0x3f9,%esi
801067b2:	89 c8                	mov    %ecx,%eax
801067b4:	89 f2                	mov    %esi,%edx
801067b6:	ee                   	out    %al,(%dx)
801067b7:	b8 03 00 00 00       	mov    $0x3,%eax
801067bc:	89 fa                	mov    %edi,%edx
801067be:	ee                   	out    %al,(%dx)
801067bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801067c4:	89 c8                	mov    %ecx,%eax
801067c6:	ee                   	out    %al,(%dx)
801067c7:	b8 01 00 00 00       	mov    $0x1,%eax
801067cc:	89 f2                	mov    %esi,%edx
801067ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801067cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801067d4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801067d5:	3c ff                	cmp    $0xff,%al
801067d7:	74 5a                	je     80106833 <uartinit+0xb3>
  uart = 1;
801067d9:	c7 05 bc c5 10 80 01 	movl   $0x1,0x8010c5bc
801067e0:	00 00 00 
801067e3:	89 da                	mov    %ebx,%edx
801067e5:	ec                   	in     (%dx),%al
801067e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067eb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801067ec:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801067ef:	bb c0 8e 10 80       	mov    $0x80108ec0,%ebx
  ioapicenable(IRQ_COM1, 0);
801067f4:	6a 00                	push   $0x0
801067f6:	6a 04                	push   $0x4
801067f8:	e8 a3 bf ff ff       	call   801027a0 <ioapicenable>
801067fd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106800:	b8 78 00 00 00       	mov    $0x78,%eax
80106805:	eb 13                	jmp    8010681a <uartinit+0x9a>
80106807:	89 f6                	mov    %esi,%esi
80106809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106810:	83 c3 01             	add    $0x1,%ebx
80106813:	0f be 03             	movsbl (%ebx),%eax
80106816:	84 c0                	test   %al,%al
80106818:	74 19                	je     80106833 <uartinit+0xb3>
  if(!uart)
8010681a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80106820:	85 d2                	test   %edx,%edx
80106822:	74 ec                	je     80106810 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106824:	83 c3 01             	add    $0x1,%ebx
80106827:	e8 04 ff ff ff       	call   80106730 <uartputc.part.0>
8010682c:	0f be 03             	movsbl (%ebx),%eax
8010682f:	84 c0                	test   %al,%al
80106831:	75 e7                	jne    8010681a <uartinit+0x9a>
}
80106833:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106836:	5b                   	pop    %ebx
80106837:	5e                   	pop    %esi
80106838:	5f                   	pop    %edi
80106839:	5d                   	pop    %ebp
8010683a:	c3                   	ret    
8010683b:	90                   	nop
8010683c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106840 <uartputc>:
  if(!uart)
80106840:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
{
80106846:	55                   	push   %ebp
80106847:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106849:	85 d2                	test   %edx,%edx
{
8010684b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010684e:	74 10                	je     80106860 <uartputc+0x20>
}
80106850:	5d                   	pop    %ebp
80106851:	e9 da fe ff ff       	jmp    80106730 <uartputc.part.0>
80106856:	8d 76 00             	lea    0x0(%esi),%esi
80106859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106860:	5d                   	pop    %ebp
80106861:	c3                   	ret    
80106862:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106870 <uartintr>:

void
uartintr(void)
{
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106876:	68 00 67 10 80       	push   $0x80106700
8010687b:	e8 90 9f ff ff       	call   80100810 <consoleintr>
}
80106880:	83 c4 10             	add    $0x10,%esp
80106883:	c9                   	leave  
80106884:	c3                   	ret    

80106885 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106885:	6a 00                	push   $0x0
  pushl $0
80106887:	6a 00                	push   $0x0
  jmp alltraps
80106889:	e9 61 f9 ff ff       	jmp    801061ef <alltraps>

8010688e <vector1>:
.globl vector1
vector1:
  pushl $0
8010688e:	6a 00                	push   $0x0
  pushl $1
80106890:	6a 01                	push   $0x1
  jmp alltraps
80106892:	e9 58 f9 ff ff       	jmp    801061ef <alltraps>

80106897 <vector2>:
.globl vector2
vector2:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $2
80106899:	6a 02                	push   $0x2
  jmp alltraps
8010689b:	e9 4f f9 ff ff       	jmp    801061ef <alltraps>

801068a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801068a0:	6a 00                	push   $0x0
  pushl $3
801068a2:	6a 03                	push   $0x3
  jmp alltraps
801068a4:	e9 46 f9 ff ff       	jmp    801061ef <alltraps>

801068a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801068a9:	6a 00                	push   $0x0
  pushl $4
801068ab:	6a 04                	push   $0x4
  jmp alltraps
801068ad:	e9 3d f9 ff ff       	jmp    801061ef <alltraps>

801068b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801068b2:	6a 00                	push   $0x0
  pushl $5
801068b4:	6a 05                	push   $0x5
  jmp alltraps
801068b6:	e9 34 f9 ff ff       	jmp    801061ef <alltraps>

801068bb <vector6>:
.globl vector6
vector6:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $6
801068bd:	6a 06                	push   $0x6
  jmp alltraps
801068bf:	e9 2b f9 ff ff       	jmp    801061ef <alltraps>

801068c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801068c4:	6a 00                	push   $0x0
  pushl $7
801068c6:	6a 07                	push   $0x7
  jmp alltraps
801068c8:	e9 22 f9 ff ff       	jmp    801061ef <alltraps>

801068cd <vector8>:
.globl vector8
vector8:
  pushl $8
801068cd:	6a 08                	push   $0x8
  jmp alltraps
801068cf:	e9 1b f9 ff ff       	jmp    801061ef <alltraps>

801068d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801068d4:	6a 00                	push   $0x0
  pushl $9
801068d6:	6a 09                	push   $0x9
  jmp alltraps
801068d8:	e9 12 f9 ff ff       	jmp    801061ef <alltraps>

801068dd <vector10>:
.globl vector10
vector10:
  pushl $10
801068dd:	6a 0a                	push   $0xa
  jmp alltraps
801068df:	e9 0b f9 ff ff       	jmp    801061ef <alltraps>

801068e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801068e4:	6a 0b                	push   $0xb
  jmp alltraps
801068e6:	e9 04 f9 ff ff       	jmp    801061ef <alltraps>

801068eb <vector12>:
.globl vector12
vector12:
  pushl $12
801068eb:	6a 0c                	push   $0xc
  jmp alltraps
801068ed:	e9 fd f8 ff ff       	jmp    801061ef <alltraps>

801068f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801068f2:	6a 0d                	push   $0xd
  jmp alltraps
801068f4:	e9 f6 f8 ff ff       	jmp    801061ef <alltraps>

801068f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801068f9:	6a 0e                	push   $0xe
  jmp alltraps
801068fb:	e9 ef f8 ff ff       	jmp    801061ef <alltraps>

80106900 <vector15>:
.globl vector15
vector15:
  pushl $0
80106900:	6a 00                	push   $0x0
  pushl $15
80106902:	6a 0f                	push   $0xf
  jmp alltraps
80106904:	e9 e6 f8 ff ff       	jmp    801061ef <alltraps>

80106909 <vector16>:
.globl vector16
vector16:
  pushl $0
80106909:	6a 00                	push   $0x0
  pushl $16
8010690b:	6a 10                	push   $0x10
  jmp alltraps
8010690d:	e9 dd f8 ff ff       	jmp    801061ef <alltraps>

80106912 <vector17>:
.globl vector17
vector17:
  pushl $17
80106912:	6a 11                	push   $0x11
  jmp alltraps
80106914:	e9 d6 f8 ff ff       	jmp    801061ef <alltraps>

80106919 <vector18>:
.globl vector18
vector18:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $18
8010691b:	6a 12                	push   $0x12
  jmp alltraps
8010691d:	e9 cd f8 ff ff       	jmp    801061ef <alltraps>

80106922 <vector19>:
.globl vector19
vector19:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $19
80106924:	6a 13                	push   $0x13
  jmp alltraps
80106926:	e9 c4 f8 ff ff       	jmp    801061ef <alltraps>

8010692b <vector20>:
.globl vector20
vector20:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $20
8010692d:	6a 14                	push   $0x14
  jmp alltraps
8010692f:	e9 bb f8 ff ff       	jmp    801061ef <alltraps>

80106934 <vector21>:
.globl vector21
vector21:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $21
80106936:	6a 15                	push   $0x15
  jmp alltraps
80106938:	e9 b2 f8 ff ff       	jmp    801061ef <alltraps>

8010693d <vector22>:
.globl vector22
vector22:
  pushl $0
8010693d:	6a 00                	push   $0x0
  pushl $22
8010693f:	6a 16                	push   $0x16
  jmp alltraps
80106941:	e9 a9 f8 ff ff       	jmp    801061ef <alltraps>

80106946 <vector23>:
.globl vector23
vector23:
  pushl $0
80106946:	6a 00                	push   $0x0
  pushl $23
80106948:	6a 17                	push   $0x17
  jmp alltraps
8010694a:	e9 a0 f8 ff ff       	jmp    801061ef <alltraps>

8010694f <vector24>:
.globl vector24
vector24:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $24
80106951:	6a 18                	push   $0x18
  jmp alltraps
80106953:	e9 97 f8 ff ff       	jmp    801061ef <alltraps>

80106958 <vector25>:
.globl vector25
vector25:
  pushl $0
80106958:	6a 00                	push   $0x0
  pushl $25
8010695a:	6a 19                	push   $0x19
  jmp alltraps
8010695c:	e9 8e f8 ff ff       	jmp    801061ef <alltraps>

80106961 <vector26>:
.globl vector26
vector26:
  pushl $0
80106961:	6a 00                	push   $0x0
  pushl $26
80106963:	6a 1a                	push   $0x1a
  jmp alltraps
80106965:	e9 85 f8 ff ff       	jmp    801061ef <alltraps>

8010696a <vector27>:
.globl vector27
vector27:
  pushl $0
8010696a:	6a 00                	push   $0x0
  pushl $27
8010696c:	6a 1b                	push   $0x1b
  jmp alltraps
8010696e:	e9 7c f8 ff ff       	jmp    801061ef <alltraps>

80106973 <vector28>:
.globl vector28
vector28:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $28
80106975:	6a 1c                	push   $0x1c
  jmp alltraps
80106977:	e9 73 f8 ff ff       	jmp    801061ef <alltraps>

8010697c <vector29>:
.globl vector29
vector29:
  pushl $0
8010697c:	6a 00                	push   $0x0
  pushl $29
8010697e:	6a 1d                	push   $0x1d
  jmp alltraps
80106980:	e9 6a f8 ff ff       	jmp    801061ef <alltraps>

80106985 <vector30>:
.globl vector30
vector30:
  pushl $0
80106985:	6a 00                	push   $0x0
  pushl $30
80106987:	6a 1e                	push   $0x1e
  jmp alltraps
80106989:	e9 61 f8 ff ff       	jmp    801061ef <alltraps>

8010698e <vector31>:
.globl vector31
vector31:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $31
80106990:	6a 1f                	push   $0x1f
  jmp alltraps
80106992:	e9 58 f8 ff ff       	jmp    801061ef <alltraps>

80106997 <vector32>:
.globl vector32
vector32:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $32
80106999:	6a 20                	push   $0x20
  jmp alltraps
8010699b:	e9 4f f8 ff ff       	jmp    801061ef <alltraps>

801069a0 <vector33>:
.globl vector33
vector33:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $33
801069a2:	6a 21                	push   $0x21
  jmp alltraps
801069a4:	e9 46 f8 ff ff       	jmp    801061ef <alltraps>

801069a9 <vector34>:
.globl vector34
vector34:
  pushl $0
801069a9:	6a 00                	push   $0x0
  pushl $34
801069ab:	6a 22                	push   $0x22
  jmp alltraps
801069ad:	e9 3d f8 ff ff       	jmp    801061ef <alltraps>

801069b2 <vector35>:
.globl vector35
vector35:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $35
801069b4:	6a 23                	push   $0x23
  jmp alltraps
801069b6:	e9 34 f8 ff ff       	jmp    801061ef <alltraps>

801069bb <vector36>:
.globl vector36
vector36:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $36
801069bd:	6a 24                	push   $0x24
  jmp alltraps
801069bf:	e9 2b f8 ff ff       	jmp    801061ef <alltraps>

801069c4 <vector37>:
.globl vector37
vector37:
  pushl $0
801069c4:	6a 00                	push   $0x0
  pushl $37
801069c6:	6a 25                	push   $0x25
  jmp alltraps
801069c8:	e9 22 f8 ff ff       	jmp    801061ef <alltraps>

801069cd <vector38>:
.globl vector38
vector38:
  pushl $0
801069cd:	6a 00                	push   $0x0
  pushl $38
801069cf:	6a 26                	push   $0x26
  jmp alltraps
801069d1:	e9 19 f8 ff ff       	jmp    801061ef <alltraps>

801069d6 <vector39>:
.globl vector39
vector39:
  pushl $0
801069d6:	6a 00                	push   $0x0
  pushl $39
801069d8:	6a 27                	push   $0x27
  jmp alltraps
801069da:	e9 10 f8 ff ff       	jmp    801061ef <alltraps>

801069df <vector40>:
.globl vector40
vector40:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $40
801069e1:	6a 28                	push   $0x28
  jmp alltraps
801069e3:	e9 07 f8 ff ff       	jmp    801061ef <alltraps>

801069e8 <vector41>:
.globl vector41
vector41:
  pushl $0
801069e8:	6a 00                	push   $0x0
  pushl $41
801069ea:	6a 29                	push   $0x29
  jmp alltraps
801069ec:	e9 fe f7 ff ff       	jmp    801061ef <alltraps>

801069f1 <vector42>:
.globl vector42
vector42:
  pushl $0
801069f1:	6a 00                	push   $0x0
  pushl $42
801069f3:	6a 2a                	push   $0x2a
  jmp alltraps
801069f5:	e9 f5 f7 ff ff       	jmp    801061ef <alltraps>

801069fa <vector43>:
.globl vector43
vector43:
  pushl $0
801069fa:	6a 00                	push   $0x0
  pushl $43
801069fc:	6a 2b                	push   $0x2b
  jmp alltraps
801069fe:	e9 ec f7 ff ff       	jmp    801061ef <alltraps>

80106a03 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $44
80106a05:	6a 2c                	push   $0x2c
  jmp alltraps
80106a07:	e9 e3 f7 ff ff       	jmp    801061ef <alltraps>

80106a0c <vector45>:
.globl vector45
vector45:
  pushl $0
80106a0c:	6a 00                	push   $0x0
  pushl $45
80106a0e:	6a 2d                	push   $0x2d
  jmp alltraps
80106a10:	e9 da f7 ff ff       	jmp    801061ef <alltraps>

80106a15 <vector46>:
.globl vector46
vector46:
  pushl $0
80106a15:	6a 00                	push   $0x0
  pushl $46
80106a17:	6a 2e                	push   $0x2e
  jmp alltraps
80106a19:	e9 d1 f7 ff ff       	jmp    801061ef <alltraps>

80106a1e <vector47>:
.globl vector47
vector47:
  pushl $0
80106a1e:	6a 00                	push   $0x0
  pushl $47
80106a20:	6a 2f                	push   $0x2f
  jmp alltraps
80106a22:	e9 c8 f7 ff ff       	jmp    801061ef <alltraps>

80106a27 <vector48>:
.globl vector48
vector48:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $48
80106a29:	6a 30                	push   $0x30
  jmp alltraps
80106a2b:	e9 bf f7 ff ff       	jmp    801061ef <alltraps>

80106a30 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a30:	6a 00                	push   $0x0
  pushl $49
80106a32:	6a 31                	push   $0x31
  jmp alltraps
80106a34:	e9 b6 f7 ff ff       	jmp    801061ef <alltraps>

80106a39 <vector50>:
.globl vector50
vector50:
  pushl $0
80106a39:	6a 00                	push   $0x0
  pushl $50
80106a3b:	6a 32                	push   $0x32
  jmp alltraps
80106a3d:	e9 ad f7 ff ff       	jmp    801061ef <alltraps>

80106a42 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a42:	6a 00                	push   $0x0
  pushl $51
80106a44:	6a 33                	push   $0x33
  jmp alltraps
80106a46:	e9 a4 f7 ff ff       	jmp    801061ef <alltraps>

80106a4b <vector52>:
.globl vector52
vector52:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $52
80106a4d:	6a 34                	push   $0x34
  jmp alltraps
80106a4f:	e9 9b f7 ff ff       	jmp    801061ef <alltraps>

80106a54 <vector53>:
.globl vector53
vector53:
  pushl $0
80106a54:	6a 00                	push   $0x0
  pushl $53
80106a56:	6a 35                	push   $0x35
  jmp alltraps
80106a58:	e9 92 f7 ff ff       	jmp    801061ef <alltraps>

80106a5d <vector54>:
.globl vector54
vector54:
  pushl $0
80106a5d:	6a 00                	push   $0x0
  pushl $54
80106a5f:	6a 36                	push   $0x36
  jmp alltraps
80106a61:	e9 89 f7 ff ff       	jmp    801061ef <alltraps>

80106a66 <vector55>:
.globl vector55
vector55:
  pushl $0
80106a66:	6a 00                	push   $0x0
  pushl $55
80106a68:	6a 37                	push   $0x37
  jmp alltraps
80106a6a:	e9 80 f7 ff ff       	jmp    801061ef <alltraps>

80106a6f <vector56>:
.globl vector56
vector56:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $56
80106a71:	6a 38                	push   $0x38
  jmp alltraps
80106a73:	e9 77 f7 ff ff       	jmp    801061ef <alltraps>

80106a78 <vector57>:
.globl vector57
vector57:
  pushl $0
80106a78:	6a 00                	push   $0x0
  pushl $57
80106a7a:	6a 39                	push   $0x39
  jmp alltraps
80106a7c:	e9 6e f7 ff ff       	jmp    801061ef <alltraps>

80106a81 <vector58>:
.globl vector58
vector58:
  pushl $0
80106a81:	6a 00                	push   $0x0
  pushl $58
80106a83:	6a 3a                	push   $0x3a
  jmp alltraps
80106a85:	e9 65 f7 ff ff       	jmp    801061ef <alltraps>

80106a8a <vector59>:
.globl vector59
vector59:
  pushl $0
80106a8a:	6a 00                	push   $0x0
  pushl $59
80106a8c:	6a 3b                	push   $0x3b
  jmp alltraps
80106a8e:	e9 5c f7 ff ff       	jmp    801061ef <alltraps>

80106a93 <vector60>:
.globl vector60
vector60:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $60
80106a95:	6a 3c                	push   $0x3c
  jmp alltraps
80106a97:	e9 53 f7 ff ff       	jmp    801061ef <alltraps>

80106a9c <vector61>:
.globl vector61
vector61:
  pushl $0
80106a9c:	6a 00                	push   $0x0
  pushl $61
80106a9e:	6a 3d                	push   $0x3d
  jmp alltraps
80106aa0:	e9 4a f7 ff ff       	jmp    801061ef <alltraps>

80106aa5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106aa5:	6a 00                	push   $0x0
  pushl $62
80106aa7:	6a 3e                	push   $0x3e
  jmp alltraps
80106aa9:	e9 41 f7 ff ff       	jmp    801061ef <alltraps>

80106aae <vector63>:
.globl vector63
vector63:
  pushl $0
80106aae:	6a 00                	push   $0x0
  pushl $63
80106ab0:	6a 3f                	push   $0x3f
  jmp alltraps
80106ab2:	e9 38 f7 ff ff       	jmp    801061ef <alltraps>

80106ab7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $64
80106ab9:	6a 40                	push   $0x40
  jmp alltraps
80106abb:	e9 2f f7 ff ff       	jmp    801061ef <alltraps>

80106ac0 <vector65>:
.globl vector65
vector65:
  pushl $0
80106ac0:	6a 00                	push   $0x0
  pushl $65
80106ac2:	6a 41                	push   $0x41
  jmp alltraps
80106ac4:	e9 26 f7 ff ff       	jmp    801061ef <alltraps>

80106ac9 <vector66>:
.globl vector66
vector66:
  pushl $0
80106ac9:	6a 00                	push   $0x0
  pushl $66
80106acb:	6a 42                	push   $0x42
  jmp alltraps
80106acd:	e9 1d f7 ff ff       	jmp    801061ef <alltraps>

80106ad2 <vector67>:
.globl vector67
vector67:
  pushl $0
80106ad2:	6a 00                	push   $0x0
  pushl $67
80106ad4:	6a 43                	push   $0x43
  jmp alltraps
80106ad6:	e9 14 f7 ff ff       	jmp    801061ef <alltraps>

80106adb <vector68>:
.globl vector68
vector68:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $68
80106add:	6a 44                	push   $0x44
  jmp alltraps
80106adf:	e9 0b f7 ff ff       	jmp    801061ef <alltraps>

80106ae4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106ae4:	6a 00                	push   $0x0
  pushl $69
80106ae6:	6a 45                	push   $0x45
  jmp alltraps
80106ae8:	e9 02 f7 ff ff       	jmp    801061ef <alltraps>

80106aed <vector70>:
.globl vector70
vector70:
  pushl $0
80106aed:	6a 00                	push   $0x0
  pushl $70
80106aef:	6a 46                	push   $0x46
  jmp alltraps
80106af1:	e9 f9 f6 ff ff       	jmp    801061ef <alltraps>

80106af6 <vector71>:
.globl vector71
vector71:
  pushl $0
80106af6:	6a 00                	push   $0x0
  pushl $71
80106af8:	6a 47                	push   $0x47
  jmp alltraps
80106afa:	e9 f0 f6 ff ff       	jmp    801061ef <alltraps>

80106aff <vector72>:
.globl vector72
vector72:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $72
80106b01:	6a 48                	push   $0x48
  jmp alltraps
80106b03:	e9 e7 f6 ff ff       	jmp    801061ef <alltraps>

80106b08 <vector73>:
.globl vector73
vector73:
  pushl $0
80106b08:	6a 00                	push   $0x0
  pushl $73
80106b0a:	6a 49                	push   $0x49
  jmp alltraps
80106b0c:	e9 de f6 ff ff       	jmp    801061ef <alltraps>

80106b11 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b11:	6a 00                	push   $0x0
  pushl $74
80106b13:	6a 4a                	push   $0x4a
  jmp alltraps
80106b15:	e9 d5 f6 ff ff       	jmp    801061ef <alltraps>

80106b1a <vector75>:
.globl vector75
vector75:
  pushl $0
80106b1a:	6a 00                	push   $0x0
  pushl $75
80106b1c:	6a 4b                	push   $0x4b
  jmp alltraps
80106b1e:	e9 cc f6 ff ff       	jmp    801061ef <alltraps>

80106b23 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $76
80106b25:	6a 4c                	push   $0x4c
  jmp alltraps
80106b27:	e9 c3 f6 ff ff       	jmp    801061ef <alltraps>

80106b2c <vector77>:
.globl vector77
vector77:
  pushl $0
80106b2c:	6a 00                	push   $0x0
  pushl $77
80106b2e:	6a 4d                	push   $0x4d
  jmp alltraps
80106b30:	e9 ba f6 ff ff       	jmp    801061ef <alltraps>

80106b35 <vector78>:
.globl vector78
vector78:
  pushl $0
80106b35:	6a 00                	push   $0x0
  pushl $78
80106b37:	6a 4e                	push   $0x4e
  jmp alltraps
80106b39:	e9 b1 f6 ff ff       	jmp    801061ef <alltraps>

80106b3e <vector79>:
.globl vector79
vector79:
  pushl $0
80106b3e:	6a 00                	push   $0x0
  pushl $79
80106b40:	6a 4f                	push   $0x4f
  jmp alltraps
80106b42:	e9 a8 f6 ff ff       	jmp    801061ef <alltraps>

80106b47 <vector80>:
.globl vector80
vector80:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $80
80106b49:	6a 50                	push   $0x50
  jmp alltraps
80106b4b:	e9 9f f6 ff ff       	jmp    801061ef <alltraps>

80106b50 <vector81>:
.globl vector81
vector81:
  pushl $0
80106b50:	6a 00                	push   $0x0
  pushl $81
80106b52:	6a 51                	push   $0x51
  jmp alltraps
80106b54:	e9 96 f6 ff ff       	jmp    801061ef <alltraps>

80106b59 <vector82>:
.globl vector82
vector82:
  pushl $0
80106b59:	6a 00                	push   $0x0
  pushl $82
80106b5b:	6a 52                	push   $0x52
  jmp alltraps
80106b5d:	e9 8d f6 ff ff       	jmp    801061ef <alltraps>

80106b62 <vector83>:
.globl vector83
vector83:
  pushl $0
80106b62:	6a 00                	push   $0x0
  pushl $83
80106b64:	6a 53                	push   $0x53
  jmp alltraps
80106b66:	e9 84 f6 ff ff       	jmp    801061ef <alltraps>

80106b6b <vector84>:
.globl vector84
vector84:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $84
80106b6d:	6a 54                	push   $0x54
  jmp alltraps
80106b6f:	e9 7b f6 ff ff       	jmp    801061ef <alltraps>

80106b74 <vector85>:
.globl vector85
vector85:
  pushl $0
80106b74:	6a 00                	push   $0x0
  pushl $85
80106b76:	6a 55                	push   $0x55
  jmp alltraps
80106b78:	e9 72 f6 ff ff       	jmp    801061ef <alltraps>

80106b7d <vector86>:
.globl vector86
vector86:
  pushl $0
80106b7d:	6a 00                	push   $0x0
  pushl $86
80106b7f:	6a 56                	push   $0x56
  jmp alltraps
80106b81:	e9 69 f6 ff ff       	jmp    801061ef <alltraps>

80106b86 <vector87>:
.globl vector87
vector87:
  pushl $0
80106b86:	6a 00                	push   $0x0
  pushl $87
80106b88:	6a 57                	push   $0x57
  jmp alltraps
80106b8a:	e9 60 f6 ff ff       	jmp    801061ef <alltraps>

80106b8f <vector88>:
.globl vector88
vector88:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $88
80106b91:	6a 58                	push   $0x58
  jmp alltraps
80106b93:	e9 57 f6 ff ff       	jmp    801061ef <alltraps>

80106b98 <vector89>:
.globl vector89
vector89:
  pushl $0
80106b98:	6a 00                	push   $0x0
  pushl $89
80106b9a:	6a 59                	push   $0x59
  jmp alltraps
80106b9c:	e9 4e f6 ff ff       	jmp    801061ef <alltraps>

80106ba1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106ba1:	6a 00                	push   $0x0
  pushl $90
80106ba3:	6a 5a                	push   $0x5a
  jmp alltraps
80106ba5:	e9 45 f6 ff ff       	jmp    801061ef <alltraps>

80106baa <vector91>:
.globl vector91
vector91:
  pushl $0
80106baa:	6a 00                	push   $0x0
  pushl $91
80106bac:	6a 5b                	push   $0x5b
  jmp alltraps
80106bae:	e9 3c f6 ff ff       	jmp    801061ef <alltraps>

80106bb3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $92
80106bb5:	6a 5c                	push   $0x5c
  jmp alltraps
80106bb7:	e9 33 f6 ff ff       	jmp    801061ef <alltraps>

80106bbc <vector93>:
.globl vector93
vector93:
  pushl $0
80106bbc:	6a 00                	push   $0x0
  pushl $93
80106bbe:	6a 5d                	push   $0x5d
  jmp alltraps
80106bc0:	e9 2a f6 ff ff       	jmp    801061ef <alltraps>

80106bc5 <vector94>:
.globl vector94
vector94:
  pushl $0
80106bc5:	6a 00                	push   $0x0
  pushl $94
80106bc7:	6a 5e                	push   $0x5e
  jmp alltraps
80106bc9:	e9 21 f6 ff ff       	jmp    801061ef <alltraps>

80106bce <vector95>:
.globl vector95
vector95:
  pushl $0
80106bce:	6a 00                	push   $0x0
  pushl $95
80106bd0:	6a 5f                	push   $0x5f
  jmp alltraps
80106bd2:	e9 18 f6 ff ff       	jmp    801061ef <alltraps>

80106bd7 <vector96>:
.globl vector96
vector96:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $96
80106bd9:	6a 60                	push   $0x60
  jmp alltraps
80106bdb:	e9 0f f6 ff ff       	jmp    801061ef <alltraps>

80106be0 <vector97>:
.globl vector97
vector97:
  pushl $0
80106be0:	6a 00                	push   $0x0
  pushl $97
80106be2:	6a 61                	push   $0x61
  jmp alltraps
80106be4:	e9 06 f6 ff ff       	jmp    801061ef <alltraps>

80106be9 <vector98>:
.globl vector98
vector98:
  pushl $0
80106be9:	6a 00                	push   $0x0
  pushl $98
80106beb:	6a 62                	push   $0x62
  jmp alltraps
80106bed:	e9 fd f5 ff ff       	jmp    801061ef <alltraps>

80106bf2 <vector99>:
.globl vector99
vector99:
  pushl $0
80106bf2:	6a 00                	push   $0x0
  pushl $99
80106bf4:	6a 63                	push   $0x63
  jmp alltraps
80106bf6:	e9 f4 f5 ff ff       	jmp    801061ef <alltraps>

80106bfb <vector100>:
.globl vector100
vector100:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $100
80106bfd:	6a 64                	push   $0x64
  jmp alltraps
80106bff:	e9 eb f5 ff ff       	jmp    801061ef <alltraps>

80106c04 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c04:	6a 00                	push   $0x0
  pushl $101
80106c06:	6a 65                	push   $0x65
  jmp alltraps
80106c08:	e9 e2 f5 ff ff       	jmp    801061ef <alltraps>

80106c0d <vector102>:
.globl vector102
vector102:
  pushl $0
80106c0d:	6a 00                	push   $0x0
  pushl $102
80106c0f:	6a 66                	push   $0x66
  jmp alltraps
80106c11:	e9 d9 f5 ff ff       	jmp    801061ef <alltraps>

80106c16 <vector103>:
.globl vector103
vector103:
  pushl $0
80106c16:	6a 00                	push   $0x0
  pushl $103
80106c18:	6a 67                	push   $0x67
  jmp alltraps
80106c1a:	e9 d0 f5 ff ff       	jmp    801061ef <alltraps>

80106c1f <vector104>:
.globl vector104
vector104:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $104
80106c21:	6a 68                	push   $0x68
  jmp alltraps
80106c23:	e9 c7 f5 ff ff       	jmp    801061ef <alltraps>

80106c28 <vector105>:
.globl vector105
vector105:
  pushl $0
80106c28:	6a 00                	push   $0x0
  pushl $105
80106c2a:	6a 69                	push   $0x69
  jmp alltraps
80106c2c:	e9 be f5 ff ff       	jmp    801061ef <alltraps>

80106c31 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c31:	6a 00                	push   $0x0
  pushl $106
80106c33:	6a 6a                	push   $0x6a
  jmp alltraps
80106c35:	e9 b5 f5 ff ff       	jmp    801061ef <alltraps>

80106c3a <vector107>:
.globl vector107
vector107:
  pushl $0
80106c3a:	6a 00                	push   $0x0
  pushl $107
80106c3c:	6a 6b                	push   $0x6b
  jmp alltraps
80106c3e:	e9 ac f5 ff ff       	jmp    801061ef <alltraps>

80106c43 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $108
80106c45:	6a 6c                	push   $0x6c
  jmp alltraps
80106c47:	e9 a3 f5 ff ff       	jmp    801061ef <alltraps>

80106c4c <vector109>:
.globl vector109
vector109:
  pushl $0
80106c4c:	6a 00                	push   $0x0
  pushl $109
80106c4e:	6a 6d                	push   $0x6d
  jmp alltraps
80106c50:	e9 9a f5 ff ff       	jmp    801061ef <alltraps>

80106c55 <vector110>:
.globl vector110
vector110:
  pushl $0
80106c55:	6a 00                	push   $0x0
  pushl $110
80106c57:	6a 6e                	push   $0x6e
  jmp alltraps
80106c59:	e9 91 f5 ff ff       	jmp    801061ef <alltraps>

80106c5e <vector111>:
.globl vector111
vector111:
  pushl $0
80106c5e:	6a 00                	push   $0x0
  pushl $111
80106c60:	6a 6f                	push   $0x6f
  jmp alltraps
80106c62:	e9 88 f5 ff ff       	jmp    801061ef <alltraps>

80106c67 <vector112>:
.globl vector112
vector112:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $112
80106c69:	6a 70                	push   $0x70
  jmp alltraps
80106c6b:	e9 7f f5 ff ff       	jmp    801061ef <alltraps>

80106c70 <vector113>:
.globl vector113
vector113:
  pushl $0
80106c70:	6a 00                	push   $0x0
  pushl $113
80106c72:	6a 71                	push   $0x71
  jmp alltraps
80106c74:	e9 76 f5 ff ff       	jmp    801061ef <alltraps>

80106c79 <vector114>:
.globl vector114
vector114:
  pushl $0
80106c79:	6a 00                	push   $0x0
  pushl $114
80106c7b:	6a 72                	push   $0x72
  jmp alltraps
80106c7d:	e9 6d f5 ff ff       	jmp    801061ef <alltraps>

80106c82 <vector115>:
.globl vector115
vector115:
  pushl $0
80106c82:	6a 00                	push   $0x0
  pushl $115
80106c84:	6a 73                	push   $0x73
  jmp alltraps
80106c86:	e9 64 f5 ff ff       	jmp    801061ef <alltraps>

80106c8b <vector116>:
.globl vector116
vector116:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $116
80106c8d:	6a 74                	push   $0x74
  jmp alltraps
80106c8f:	e9 5b f5 ff ff       	jmp    801061ef <alltraps>

80106c94 <vector117>:
.globl vector117
vector117:
  pushl $0
80106c94:	6a 00                	push   $0x0
  pushl $117
80106c96:	6a 75                	push   $0x75
  jmp alltraps
80106c98:	e9 52 f5 ff ff       	jmp    801061ef <alltraps>

80106c9d <vector118>:
.globl vector118
vector118:
  pushl $0
80106c9d:	6a 00                	push   $0x0
  pushl $118
80106c9f:	6a 76                	push   $0x76
  jmp alltraps
80106ca1:	e9 49 f5 ff ff       	jmp    801061ef <alltraps>

80106ca6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ca6:	6a 00                	push   $0x0
  pushl $119
80106ca8:	6a 77                	push   $0x77
  jmp alltraps
80106caa:	e9 40 f5 ff ff       	jmp    801061ef <alltraps>

80106caf <vector120>:
.globl vector120
vector120:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $120
80106cb1:	6a 78                	push   $0x78
  jmp alltraps
80106cb3:	e9 37 f5 ff ff       	jmp    801061ef <alltraps>

80106cb8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106cb8:	6a 00                	push   $0x0
  pushl $121
80106cba:	6a 79                	push   $0x79
  jmp alltraps
80106cbc:	e9 2e f5 ff ff       	jmp    801061ef <alltraps>

80106cc1 <vector122>:
.globl vector122
vector122:
  pushl $0
80106cc1:	6a 00                	push   $0x0
  pushl $122
80106cc3:	6a 7a                	push   $0x7a
  jmp alltraps
80106cc5:	e9 25 f5 ff ff       	jmp    801061ef <alltraps>

80106cca <vector123>:
.globl vector123
vector123:
  pushl $0
80106cca:	6a 00                	push   $0x0
  pushl $123
80106ccc:	6a 7b                	push   $0x7b
  jmp alltraps
80106cce:	e9 1c f5 ff ff       	jmp    801061ef <alltraps>

80106cd3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $124
80106cd5:	6a 7c                	push   $0x7c
  jmp alltraps
80106cd7:	e9 13 f5 ff ff       	jmp    801061ef <alltraps>

80106cdc <vector125>:
.globl vector125
vector125:
  pushl $0
80106cdc:	6a 00                	push   $0x0
  pushl $125
80106cde:	6a 7d                	push   $0x7d
  jmp alltraps
80106ce0:	e9 0a f5 ff ff       	jmp    801061ef <alltraps>

80106ce5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106ce5:	6a 00                	push   $0x0
  pushl $126
80106ce7:	6a 7e                	push   $0x7e
  jmp alltraps
80106ce9:	e9 01 f5 ff ff       	jmp    801061ef <alltraps>

80106cee <vector127>:
.globl vector127
vector127:
  pushl $0
80106cee:	6a 00                	push   $0x0
  pushl $127
80106cf0:	6a 7f                	push   $0x7f
  jmp alltraps
80106cf2:	e9 f8 f4 ff ff       	jmp    801061ef <alltraps>

80106cf7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $128
80106cf9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106cfe:	e9 ec f4 ff ff       	jmp    801061ef <alltraps>

80106d03 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $129
80106d05:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d0a:	e9 e0 f4 ff ff       	jmp    801061ef <alltraps>

80106d0f <vector130>:
.globl vector130
vector130:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $130
80106d11:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d16:	e9 d4 f4 ff ff       	jmp    801061ef <alltraps>

80106d1b <vector131>:
.globl vector131
vector131:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $131
80106d1d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d22:	e9 c8 f4 ff ff       	jmp    801061ef <alltraps>

80106d27 <vector132>:
.globl vector132
vector132:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $132
80106d29:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d2e:	e9 bc f4 ff ff       	jmp    801061ef <alltraps>

80106d33 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $133
80106d35:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d3a:	e9 b0 f4 ff ff       	jmp    801061ef <alltraps>

80106d3f <vector134>:
.globl vector134
vector134:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $134
80106d41:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d46:	e9 a4 f4 ff ff       	jmp    801061ef <alltraps>

80106d4b <vector135>:
.globl vector135
vector135:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $135
80106d4d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106d52:	e9 98 f4 ff ff       	jmp    801061ef <alltraps>

80106d57 <vector136>:
.globl vector136
vector136:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $136
80106d59:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106d5e:	e9 8c f4 ff ff       	jmp    801061ef <alltraps>

80106d63 <vector137>:
.globl vector137
vector137:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $137
80106d65:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106d6a:	e9 80 f4 ff ff       	jmp    801061ef <alltraps>

80106d6f <vector138>:
.globl vector138
vector138:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $138
80106d71:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106d76:	e9 74 f4 ff ff       	jmp    801061ef <alltraps>

80106d7b <vector139>:
.globl vector139
vector139:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $139
80106d7d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106d82:	e9 68 f4 ff ff       	jmp    801061ef <alltraps>

80106d87 <vector140>:
.globl vector140
vector140:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $140
80106d89:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106d8e:	e9 5c f4 ff ff       	jmp    801061ef <alltraps>

80106d93 <vector141>:
.globl vector141
vector141:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $141
80106d95:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106d9a:	e9 50 f4 ff ff       	jmp    801061ef <alltraps>

80106d9f <vector142>:
.globl vector142
vector142:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $142
80106da1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106da6:	e9 44 f4 ff ff       	jmp    801061ef <alltraps>

80106dab <vector143>:
.globl vector143
vector143:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $143
80106dad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106db2:	e9 38 f4 ff ff       	jmp    801061ef <alltraps>

80106db7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $144
80106db9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106dbe:	e9 2c f4 ff ff       	jmp    801061ef <alltraps>

80106dc3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $145
80106dc5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106dca:	e9 20 f4 ff ff       	jmp    801061ef <alltraps>

80106dcf <vector146>:
.globl vector146
vector146:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $146
80106dd1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106dd6:	e9 14 f4 ff ff       	jmp    801061ef <alltraps>

80106ddb <vector147>:
.globl vector147
vector147:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $147
80106ddd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106de2:	e9 08 f4 ff ff       	jmp    801061ef <alltraps>

80106de7 <vector148>:
.globl vector148
vector148:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $148
80106de9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106dee:	e9 fc f3 ff ff       	jmp    801061ef <alltraps>

80106df3 <vector149>:
.globl vector149
vector149:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $149
80106df5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106dfa:	e9 f0 f3 ff ff       	jmp    801061ef <alltraps>

80106dff <vector150>:
.globl vector150
vector150:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $150
80106e01:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e06:	e9 e4 f3 ff ff       	jmp    801061ef <alltraps>

80106e0b <vector151>:
.globl vector151
vector151:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $151
80106e0d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e12:	e9 d8 f3 ff ff       	jmp    801061ef <alltraps>

80106e17 <vector152>:
.globl vector152
vector152:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $152
80106e19:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e1e:	e9 cc f3 ff ff       	jmp    801061ef <alltraps>

80106e23 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $153
80106e25:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e2a:	e9 c0 f3 ff ff       	jmp    801061ef <alltraps>

80106e2f <vector154>:
.globl vector154
vector154:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $154
80106e31:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e36:	e9 b4 f3 ff ff       	jmp    801061ef <alltraps>

80106e3b <vector155>:
.globl vector155
vector155:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $155
80106e3d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e42:	e9 a8 f3 ff ff       	jmp    801061ef <alltraps>

80106e47 <vector156>:
.globl vector156
vector156:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $156
80106e49:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106e4e:	e9 9c f3 ff ff       	jmp    801061ef <alltraps>

80106e53 <vector157>:
.globl vector157
vector157:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $157
80106e55:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106e5a:	e9 90 f3 ff ff       	jmp    801061ef <alltraps>

80106e5f <vector158>:
.globl vector158
vector158:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $158
80106e61:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106e66:	e9 84 f3 ff ff       	jmp    801061ef <alltraps>

80106e6b <vector159>:
.globl vector159
vector159:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $159
80106e6d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106e72:	e9 78 f3 ff ff       	jmp    801061ef <alltraps>

80106e77 <vector160>:
.globl vector160
vector160:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $160
80106e79:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106e7e:	e9 6c f3 ff ff       	jmp    801061ef <alltraps>

80106e83 <vector161>:
.globl vector161
vector161:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $161
80106e85:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106e8a:	e9 60 f3 ff ff       	jmp    801061ef <alltraps>

80106e8f <vector162>:
.globl vector162
vector162:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $162
80106e91:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106e96:	e9 54 f3 ff ff       	jmp    801061ef <alltraps>

80106e9b <vector163>:
.globl vector163
vector163:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $163
80106e9d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ea2:	e9 48 f3 ff ff       	jmp    801061ef <alltraps>

80106ea7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $164
80106ea9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106eae:	e9 3c f3 ff ff       	jmp    801061ef <alltraps>

80106eb3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $165
80106eb5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106eba:	e9 30 f3 ff ff       	jmp    801061ef <alltraps>

80106ebf <vector166>:
.globl vector166
vector166:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $166
80106ec1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106ec6:	e9 24 f3 ff ff       	jmp    801061ef <alltraps>

80106ecb <vector167>:
.globl vector167
vector167:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $167
80106ecd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ed2:	e9 18 f3 ff ff       	jmp    801061ef <alltraps>

80106ed7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $168
80106ed9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ede:	e9 0c f3 ff ff       	jmp    801061ef <alltraps>

80106ee3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $169
80106ee5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106eea:	e9 00 f3 ff ff       	jmp    801061ef <alltraps>

80106eef <vector170>:
.globl vector170
vector170:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $170
80106ef1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ef6:	e9 f4 f2 ff ff       	jmp    801061ef <alltraps>

80106efb <vector171>:
.globl vector171
vector171:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $171
80106efd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f02:	e9 e8 f2 ff ff       	jmp    801061ef <alltraps>

80106f07 <vector172>:
.globl vector172
vector172:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $172
80106f09:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f0e:	e9 dc f2 ff ff       	jmp    801061ef <alltraps>

80106f13 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $173
80106f15:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f1a:	e9 d0 f2 ff ff       	jmp    801061ef <alltraps>

80106f1f <vector174>:
.globl vector174
vector174:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $174
80106f21:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f26:	e9 c4 f2 ff ff       	jmp    801061ef <alltraps>

80106f2b <vector175>:
.globl vector175
vector175:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $175
80106f2d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f32:	e9 b8 f2 ff ff       	jmp    801061ef <alltraps>

80106f37 <vector176>:
.globl vector176
vector176:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $176
80106f39:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f3e:	e9 ac f2 ff ff       	jmp    801061ef <alltraps>

80106f43 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $177
80106f45:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f4a:	e9 a0 f2 ff ff       	jmp    801061ef <alltraps>

80106f4f <vector178>:
.globl vector178
vector178:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $178
80106f51:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106f56:	e9 94 f2 ff ff       	jmp    801061ef <alltraps>

80106f5b <vector179>:
.globl vector179
vector179:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $179
80106f5d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106f62:	e9 88 f2 ff ff       	jmp    801061ef <alltraps>

80106f67 <vector180>:
.globl vector180
vector180:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $180
80106f69:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106f6e:	e9 7c f2 ff ff       	jmp    801061ef <alltraps>

80106f73 <vector181>:
.globl vector181
vector181:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $181
80106f75:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106f7a:	e9 70 f2 ff ff       	jmp    801061ef <alltraps>

80106f7f <vector182>:
.globl vector182
vector182:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $182
80106f81:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106f86:	e9 64 f2 ff ff       	jmp    801061ef <alltraps>

80106f8b <vector183>:
.globl vector183
vector183:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $183
80106f8d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106f92:	e9 58 f2 ff ff       	jmp    801061ef <alltraps>

80106f97 <vector184>:
.globl vector184
vector184:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $184
80106f99:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106f9e:	e9 4c f2 ff ff       	jmp    801061ef <alltraps>

80106fa3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $185
80106fa5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106faa:	e9 40 f2 ff ff       	jmp    801061ef <alltraps>

80106faf <vector186>:
.globl vector186
vector186:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $186
80106fb1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106fb6:	e9 34 f2 ff ff       	jmp    801061ef <alltraps>

80106fbb <vector187>:
.globl vector187
vector187:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $187
80106fbd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106fc2:	e9 28 f2 ff ff       	jmp    801061ef <alltraps>

80106fc7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $188
80106fc9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106fce:	e9 1c f2 ff ff       	jmp    801061ef <alltraps>

80106fd3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $189
80106fd5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106fda:	e9 10 f2 ff ff       	jmp    801061ef <alltraps>

80106fdf <vector190>:
.globl vector190
vector190:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $190
80106fe1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106fe6:	e9 04 f2 ff ff       	jmp    801061ef <alltraps>

80106feb <vector191>:
.globl vector191
vector191:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $191
80106fed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106ff2:	e9 f8 f1 ff ff       	jmp    801061ef <alltraps>

80106ff7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $192
80106ff9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106ffe:	e9 ec f1 ff ff       	jmp    801061ef <alltraps>

80107003 <vector193>:
.globl vector193
vector193:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $193
80107005:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010700a:	e9 e0 f1 ff ff       	jmp    801061ef <alltraps>

8010700f <vector194>:
.globl vector194
vector194:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $194
80107011:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107016:	e9 d4 f1 ff ff       	jmp    801061ef <alltraps>

8010701b <vector195>:
.globl vector195
vector195:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $195
8010701d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107022:	e9 c8 f1 ff ff       	jmp    801061ef <alltraps>

80107027 <vector196>:
.globl vector196
vector196:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $196
80107029:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010702e:	e9 bc f1 ff ff       	jmp    801061ef <alltraps>

80107033 <vector197>:
.globl vector197
vector197:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $197
80107035:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010703a:	e9 b0 f1 ff ff       	jmp    801061ef <alltraps>

8010703f <vector198>:
.globl vector198
vector198:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $198
80107041:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107046:	e9 a4 f1 ff ff       	jmp    801061ef <alltraps>

8010704b <vector199>:
.globl vector199
vector199:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $199
8010704d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107052:	e9 98 f1 ff ff       	jmp    801061ef <alltraps>

80107057 <vector200>:
.globl vector200
vector200:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $200
80107059:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010705e:	e9 8c f1 ff ff       	jmp    801061ef <alltraps>

80107063 <vector201>:
.globl vector201
vector201:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $201
80107065:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010706a:	e9 80 f1 ff ff       	jmp    801061ef <alltraps>

8010706f <vector202>:
.globl vector202
vector202:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $202
80107071:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107076:	e9 74 f1 ff ff       	jmp    801061ef <alltraps>

8010707b <vector203>:
.globl vector203
vector203:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $203
8010707d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107082:	e9 68 f1 ff ff       	jmp    801061ef <alltraps>

80107087 <vector204>:
.globl vector204
vector204:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $204
80107089:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010708e:	e9 5c f1 ff ff       	jmp    801061ef <alltraps>

80107093 <vector205>:
.globl vector205
vector205:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $205
80107095:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010709a:	e9 50 f1 ff ff       	jmp    801061ef <alltraps>

8010709f <vector206>:
.globl vector206
vector206:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $206
801070a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801070a6:	e9 44 f1 ff ff       	jmp    801061ef <alltraps>

801070ab <vector207>:
.globl vector207
vector207:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $207
801070ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801070b2:	e9 38 f1 ff ff       	jmp    801061ef <alltraps>

801070b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $208
801070b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801070be:	e9 2c f1 ff ff       	jmp    801061ef <alltraps>

801070c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $209
801070c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801070ca:	e9 20 f1 ff ff       	jmp    801061ef <alltraps>

801070cf <vector210>:
.globl vector210
vector210:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $210
801070d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801070d6:	e9 14 f1 ff ff       	jmp    801061ef <alltraps>

801070db <vector211>:
.globl vector211
vector211:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $211
801070dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801070e2:	e9 08 f1 ff ff       	jmp    801061ef <alltraps>

801070e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $212
801070e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801070ee:	e9 fc f0 ff ff       	jmp    801061ef <alltraps>

801070f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $213
801070f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801070fa:	e9 f0 f0 ff ff       	jmp    801061ef <alltraps>

801070ff <vector214>:
.globl vector214
vector214:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $214
80107101:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107106:	e9 e4 f0 ff ff       	jmp    801061ef <alltraps>

8010710b <vector215>:
.globl vector215
vector215:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $215
8010710d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107112:	e9 d8 f0 ff ff       	jmp    801061ef <alltraps>

80107117 <vector216>:
.globl vector216
vector216:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $216
80107119:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010711e:	e9 cc f0 ff ff       	jmp    801061ef <alltraps>

80107123 <vector217>:
.globl vector217
vector217:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $217
80107125:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010712a:	e9 c0 f0 ff ff       	jmp    801061ef <alltraps>

8010712f <vector218>:
.globl vector218
vector218:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $218
80107131:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107136:	e9 b4 f0 ff ff       	jmp    801061ef <alltraps>

8010713b <vector219>:
.globl vector219
vector219:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $219
8010713d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107142:	e9 a8 f0 ff ff       	jmp    801061ef <alltraps>

80107147 <vector220>:
.globl vector220
vector220:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $220
80107149:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010714e:	e9 9c f0 ff ff       	jmp    801061ef <alltraps>

80107153 <vector221>:
.globl vector221
vector221:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $221
80107155:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010715a:	e9 90 f0 ff ff       	jmp    801061ef <alltraps>

8010715f <vector222>:
.globl vector222
vector222:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $222
80107161:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107166:	e9 84 f0 ff ff       	jmp    801061ef <alltraps>

8010716b <vector223>:
.globl vector223
vector223:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $223
8010716d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107172:	e9 78 f0 ff ff       	jmp    801061ef <alltraps>

80107177 <vector224>:
.globl vector224
vector224:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $224
80107179:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010717e:	e9 6c f0 ff ff       	jmp    801061ef <alltraps>

80107183 <vector225>:
.globl vector225
vector225:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $225
80107185:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010718a:	e9 60 f0 ff ff       	jmp    801061ef <alltraps>

8010718f <vector226>:
.globl vector226
vector226:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $226
80107191:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107196:	e9 54 f0 ff ff       	jmp    801061ef <alltraps>

8010719b <vector227>:
.globl vector227
vector227:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $227
8010719d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801071a2:	e9 48 f0 ff ff       	jmp    801061ef <alltraps>

801071a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $228
801071a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801071ae:	e9 3c f0 ff ff       	jmp    801061ef <alltraps>

801071b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $229
801071b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801071ba:	e9 30 f0 ff ff       	jmp    801061ef <alltraps>

801071bf <vector230>:
.globl vector230
vector230:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $230
801071c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801071c6:	e9 24 f0 ff ff       	jmp    801061ef <alltraps>

801071cb <vector231>:
.globl vector231
vector231:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $231
801071cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801071d2:	e9 18 f0 ff ff       	jmp    801061ef <alltraps>

801071d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $232
801071d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801071de:	e9 0c f0 ff ff       	jmp    801061ef <alltraps>

801071e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $233
801071e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801071ea:	e9 00 f0 ff ff       	jmp    801061ef <alltraps>

801071ef <vector234>:
.globl vector234
vector234:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $234
801071f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801071f6:	e9 f4 ef ff ff       	jmp    801061ef <alltraps>

801071fb <vector235>:
.globl vector235
vector235:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $235
801071fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107202:	e9 e8 ef ff ff       	jmp    801061ef <alltraps>

80107207 <vector236>:
.globl vector236
vector236:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $236
80107209:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010720e:	e9 dc ef ff ff       	jmp    801061ef <alltraps>

80107213 <vector237>:
.globl vector237
vector237:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $237
80107215:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010721a:	e9 d0 ef ff ff       	jmp    801061ef <alltraps>

8010721f <vector238>:
.globl vector238
vector238:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $238
80107221:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107226:	e9 c4 ef ff ff       	jmp    801061ef <alltraps>

8010722b <vector239>:
.globl vector239
vector239:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $239
8010722d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107232:	e9 b8 ef ff ff       	jmp    801061ef <alltraps>

80107237 <vector240>:
.globl vector240
vector240:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $240
80107239:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010723e:	e9 ac ef ff ff       	jmp    801061ef <alltraps>

80107243 <vector241>:
.globl vector241
vector241:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $241
80107245:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010724a:	e9 a0 ef ff ff       	jmp    801061ef <alltraps>

8010724f <vector242>:
.globl vector242
vector242:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $242
80107251:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107256:	e9 94 ef ff ff       	jmp    801061ef <alltraps>

8010725b <vector243>:
.globl vector243
vector243:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $243
8010725d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107262:	e9 88 ef ff ff       	jmp    801061ef <alltraps>

80107267 <vector244>:
.globl vector244
vector244:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $244
80107269:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010726e:	e9 7c ef ff ff       	jmp    801061ef <alltraps>

80107273 <vector245>:
.globl vector245
vector245:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $245
80107275:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010727a:	e9 70 ef ff ff       	jmp    801061ef <alltraps>

8010727f <vector246>:
.globl vector246
vector246:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $246
80107281:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107286:	e9 64 ef ff ff       	jmp    801061ef <alltraps>

8010728b <vector247>:
.globl vector247
vector247:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $247
8010728d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107292:	e9 58 ef ff ff       	jmp    801061ef <alltraps>

80107297 <vector248>:
.globl vector248
vector248:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $248
80107299:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010729e:	e9 4c ef ff ff       	jmp    801061ef <alltraps>

801072a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $249
801072a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801072aa:	e9 40 ef ff ff       	jmp    801061ef <alltraps>

801072af <vector250>:
.globl vector250
vector250:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $250
801072b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801072b6:	e9 34 ef ff ff       	jmp    801061ef <alltraps>

801072bb <vector251>:
.globl vector251
vector251:
  pushl $0
801072bb:	6a 00                	push   $0x0
  pushl $251
801072bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801072c2:	e9 28 ef ff ff       	jmp    801061ef <alltraps>

801072c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $252
801072c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801072ce:	e9 1c ef ff ff       	jmp    801061ef <alltraps>

801072d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801072d3:	6a 00                	push   $0x0
  pushl $253
801072d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801072da:	e9 10 ef ff ff       	jmp    801061ef <alltraps>

801072df <vector254>:
.globl vector254
vector254:
  pushl $0
801072df:	6a 00                	push   $0x0
  pushl $254
801072e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801072e6:	e9 04 ef ff ff       	jmp    801061ef <alltraps>

801072eb <vector255>:
.globl vector255
vector255:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $255
801072ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801072f2:	e9 f8 ee ff ff       	jmp    801061ef <alltraps>
801072f7:	66 90                	xchg   %ax,%ax
801072f9:	66 90                	xchg   %ax,%ax
801072fb:	66 90                	xchg   %ax,%ax
801072fd:	66 90                	xchg   %ax,%ax
801072ff:	90                   	nop

80107300 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107300:	55                   	push   %ebp
80107301:	89 e5                	mov    %esp,%ebp
80107303:	57                   	push   %edi
80107304:	56                   	push   %esi
80107305:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107306:	89 d3                	mov    %edx,%ebx
{
80107308:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010730a:	c1 eb 16             	shr    $0x16,%ebx
8010730d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107310:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107313:	8b 06                	mov    (%esi),%eax
80107315:	a8 01                	test   $0x1,%al
80107317:	74 27                	je     80107340 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107319:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010731e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107324:	c1 ef 0a             	shr    $0xa,%edi
}
80107327:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010732a:	89 fa                	mov    %edi,%edx
8010732c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107332:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107335:	5b                   	pop    %ebx
80107336:	5e                   	pop    %esi
80107337:	5f                   	pop    %edi
80107338:	5d                   	pop    %ebp
80107339:	c3                   	ret    
8010733a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107340:	85 c9                	test   %ecx,%ecx
80107342:	74 2c                	je     80107370 <walkpgdir+0x70>
80107344:	e8 a7 b6 ff ff       	call   801029f0 <kalloc>
80107349:	85 c0                	test   %eax,%eax
8010734b:	89 c3                	mov    %eax,%ebx
8010734d:	74 21                	je     80107370 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010734f:	83 ec 04             	sub    $0x4,%esp
80107352:	68 00 10 00 00       	push   $0x1000
80107357:	6a 00                	push   $0x0
80107359:	50                   	push   %eax
8010735a:	e8 11 dc ff ff       	call   80104f70 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010735f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107365:	83 c4 10             	add    $0x10,%esp
80107368:	83 c8 07             	or     $0x7,%eax
8010736b:	89 06                	mov    %eax,(%esi)
8010736d:	eb b5                	jmp    80107324 <walkpgdir+0x24>
8010736f:	90                   	nop
}
80107370:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107373:	31 c0                	xor    %eax,%eax
}
80107375:	5b                   	pop    %ebx
80107376:	5e                   	pop    %esi
80107377:	5f                   	pop    %edi
80107378:	5d                   	pop    %ebp
80107379:	c3                   	ret    
8010737a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107380 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	57                   	push   %edi
80107384:	56                   	push   %esi
80107385:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107386:	89 d3                	mov    %edx,%ebx
80107388:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010738e:	83 ec 1c             	sub    $0x1c,%esp
80107391:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107394:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107398:	8b 7d 08             	mov    0x8(%ebp),%edi
8010739b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801073a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801073a6:	29 df                	sub    %ebx,%edi
801073a8:	83 c8 01             	or     $0x1,%eax
801073ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
801073ae:	eb 15                	jmp    801073c5 <mappages+0x45>
    if(*pte & PTE_P)
801073b0:	f6 00 01             	testb  $0x1,(%eax)
801073b3:	75 45                	jne    801073fa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801073b5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801073b8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801073bb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801073bd:	74 31                	je     801073f0 <mappages+0x70>
      break;
    a += PGSIZE;
801073bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801073c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073c8:	b9 01 00 00 00       	mov    $0x1,%ecx
801073cd:	89 da                	mov    %ebx,%edx
801073cf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801073d2:	e8 29 ff ff ff       	call   80107300 <walkpgdir>
801073d7:	85 c0                	test   %eax,%eax
801073d9:	75 d5                	jne    801073b0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801073db:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073e3:	5b                   	pop    %ebx
801073e4:	5e                   	pop    %esi
801073e5:	5f                   	pop    %edi
801073e6:	5d                   	pop    %ebp
801073e7:	c3                   	ret    
801073e8:	90                   	nop
801073e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073f3:	31 c0                	xor    %eax,%eax
}
801073f5:	5b                   	pop    %ebx
801073f6:	5e                   	pop    %esi
801073f7:	5f                   	pop    %edi
801073f8:	5d                   	pop    %ebp
801073f9:	c3                   	ret    
      panic("remap");
801073fa:	83 ec 0c             	sub    $0xc,%esp
801073fd:	68 c8 8e 10 80       	push   $0x80108ec8
80107402:	e8 89 8f ff ff       	call   80100390 <panic>
80107407:	89 f6                	mov    %esi,%esi
80107409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107410 <seginit>:
{
80107410:	55                   	push   %ebp
80107411:	89 e5                	mov    %esp,%ebp
80107413:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107416:	e8 25 cb ff ff       	call   80103f40 <cpuid>
8010741b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107421:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107426:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010742a:	c7 80 18 c8 14 80 ff 	movl   $0xffff,-0x7feb37e8(%eax)
80107431:	ff 00 00 
80107434:	c7 80 1c c8 14 80 00 	movl   $0xcf9a00,-0x7feb37e4(%eax)
8010743b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010743e:	c7 80 20 c8 14 80 ff 	movl   $0xffff,-0x7feb37e0(%eax)
80107445:	ff 00 00 
80107448:	c7 80 24 c8 14 80 00 	movl   $0xcf9200,-0x7feb37dc(%eax)
8010744f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107452:	c7 80 28 c8 14 80 ff 	movl   $0xffff,-0x7feb37d8(%eax)
80107459:	ff 00 00 
8010745c:	c7 80 2c c8 14 80 00 	movl   $0xcffa00,-0x7feb37d4(%eax)
80107463:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107466:	c7 80 30 c8 14 80 ff 	movl   $0xffff,-0x7feb37d0(%eax)
8010746d:	ff 00 00 
80107470:	c7 80 34 c8 14 80 00 	movl   $0xcff200,-0x7feb37cc(%eax)
80107477:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010747a:	05 10 c8 14 80       	add    $0x8014c810,%eax
  pd[1] = (uint)p;
8010747f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107483:	c1 e8 10             	shr    $0x10,%eax
80107486:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010748a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010748d:	0f 01 10             	lgdtl  (%eax)
}
80107490:	c9                   	leave  
80107491:	c3                   	ret    
80107492:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074a0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801074a0:	a1 c4 ab 15 80       	mov    0x8015abc4,%eax
{
801074a5:	55                   	push   %ebp
801074a6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801074a8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801074ad:	0f 22 d8             	mov    %eax,%cr3
}
801074b0:	5d                   	pop    %ebp
801074b1:	c3                   	ret    
801074b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801074c0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	57                   	push   %edi
801074c4:	56                   	push   %esi
801074c5:	53                   	push   %ebx
801074c6:	83 ec 1c             	sub    $0x1c,%esp
801074c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801074cc:	85 db                	test   %ebx,%ebx
801074ce:	0f 84 cb 00 00 00    	je     8010759f <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801074d4:	8b 43 08             	mov    0x8(%ebx),%eax
801074d7:	85 c0                	test   %eax,%eax
801074d9:	0f 84 da 00 00 00    	je     801075b9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801074df:	8b 43 04             	mov    0x4(%ebx),%eax
801074e2:	85 c0                	test   %eax,%eax
801074e4:	0f 84 c2 00 00 00    	je     801075ac <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
801074ea:	e8 a1 d8 ff ff       	call   80104d90 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801074ef:	e8 cc c9 ff ff       	call   80103ec0 <mycpu>
801074f4:	89 c6                	mov    %eax,%esi
801074f6:	e8 c5 c9 ff ff       	call   80103ec0 <mycpu>
801074fb:	89 c7                	mov    %eax,%edi
801074fd:	e8 be c9 ff ff       	call   80103ec0 <mycpu>
80107502:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107505:	83 c7 08             	add    $0x8,%edi
80107508:	e8 b3 c9 ff ff       	call   80103ec0 <mycpu>
8010750d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107510:	83 c0 08             	add    $0x8,%eax
80107513:	ba 67 00 00 00       	mov    $0x67,%edx
80107518:	c1 e8 18             	shr    $0x18,%eax
8010751b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107522:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107529:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010752f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107534:	83 c1 08             	add    $0x8,%ecx
80107537:	c1 e9 10             	shr    $0x10,%ecx
8010753a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107540:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107545:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010754c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107551:	e8 6a c9 ff ff       	call   80103ec0 <mycpu>
80107556:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010755d:	e8 5e c9 ff ff       	call   80103ec0 <mycpu>
80107562:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107566:	8b 73 08             	mov    0x8(%ebx),%esi
80107569:	e8 52 c9 ff ff       	call   80103ec0 <mycpu>
8010756e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107574:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107577:	e8 44 c9 ff ff       	call   80103ec0 <mycpu>
8010757c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107580:	b8 28 00 00 00       	mov    $0x28,%eax
80107585:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107588:	8b 43 04             	mov    0x4(%ebx),%eax
8010758b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107590:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80107593:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107596:	5b                   	pop    %ebx
80107597:	5e                   	pop    %esi
80107598:	5f                   	pop    %edi
80107599:	5d                   	pop    %ebp
  popcli();
8010759a:	e9 31 d8 ff ff       	jmp    80104dd0 <popcli>
    panic("switchuvm: no process");
8010759f:	83 ec 0c             	sub    $0xc,%esp
801075a2:	68 ce 8e 10 80       	push   $0x80108ece
801075a7:	e8 e4 8d ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801075ac:	83 ec 0c             	sub    $0xc,%esp
801075af:	68 f9 8e 10 80       	push   $0x80108ef9
801075b4:	e8 d7 8d ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801075b9:	83 ec 0c             	sub    $0xc,%esp
801075bc:	68 e4 8e 10 80       	push   $0x80108ee4
801075c1:	e8 ca 8d ff ff       	call   80100390 <panic>
801075c6:	8d 76 00             	lea    0x0(%esi),%esi
801075c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801075d0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	57                   	push   %edi
801075d4:	56                   	push   %esi
801075d5:	53                   	push   %ebx
801075d6:	83 ec 1c             	sub    $0x1c,%esp
801075d9:	8b 75 10             	mov    0x10(%ebp),%esi
801075dc:	8b 45 08             	mov    0x8(%ebp),%eax
801075df:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801075e2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
801075e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801075eb:	77 49                	ja     80107636 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
801075ed:	e8 fe b3 ff ff       	call   801029f0 <kalloc>
  memset(mem, 0, PGSIZE);
801075f2:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
801075f5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801075f7:	68 00 10 00 00       	push   $0x1000
801075fc:	6a 00                	push   $0x0
801075fe:	50                   	push   %eax
801075ff:	e8 6c d9 ff ff       	call   80104f70 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107604:	58                   	pop    %eax
80107605:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010760b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107610:	5a                   	pop    %edx
80107611:	6a 06                	push   $0x6
80107613:	50                   	push   %eax
80107614:	31 d2                	xor    %edx,%edx
80107616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107619:	e8 62 fd ff ff       	call   80107380 <mappages>
  memmove(mem, init, sz);
8010761e:	89 75 10             	mov    %esi,0x10(%ebp)
80107621:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107624:	83 c4 10             	add    $0x10,%esp
80107627:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010762a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010762d:	5b                   	pop    %ebx
8010762e:	5e                   	pop    %esi
8010762f:	5f                   	pop    %edi
80107630:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107631:	e9 ea d9 ff ff       	jmp    80105020 <memmove>
    panic("inituvm: more than a page");
80107636:	83 ec 0c             	sub    $0xc,%esp
80107639:	68 0d 8f 10 80       	push   $0x80108f0d
8010763e:	e8 4d 8d ff ff       	call   80100390 <panic>
80107643:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107650 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	57                   	push   %edi
80107654:	56                   	push   %esi
80107655:	53                   	push   %ebx
80107656:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107659:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107660:	0f 85 91 00 00 00    	jne    801076f7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107666:	8b 75 18             	mov    0x18(%ebp),%esi
80107669:	31 db                	xor    %ebx,%ebx
8010766b:	85 f6                	test   %esi,%esi
8010766d:	75 1a                	jne    80107689 <loaduvm+0x39>
8010766f:	eb 6f                	jmp    801076e0 <loaduvm+0x90>
80107671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107678:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010767e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107684:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107687:	76 57                	jbe    801076e0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107689:	8b 55 0c             	mov    0xc(%ebp),%edx
8010768c:	8b 45 08             	mov    0x8(%ebp),%eax
8010768f:	31 c9                	xor    %ecx,%ecx
80107691:	01 da                	add    %ebx,%edx
80107693:	e8 68 fc ff ff       	call   80107300 <walkpgdir>
80107698:	85 c0                	test   %eax,%eax
8010769a:	74 4e                	je     801076ea <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010769c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010769e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801076a1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801076a6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801076ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801076b1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801076b4:	01 d9                	add    %ebx,%ecx
801076b6:	05 00 00 00 80       	add    $0x80000000,%eax
801076bb:	57                   	push   %edi
801076bc:	51                   	push   %ecx
801076bd:	50                   	push   %eax
801076be:	ff 75 10             	pushl  0x10(%ebp)
801076c1:	e8 da a3 ff ff       	call   80101aa0 <readi>
801076c6:	83 c4 10             	add    $0x10,%esp
801076c9:	39 f8                	cmp    %edi,%eax
801076cb:	74 ab                	je     80107678 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801076cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801076d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801076d5:	5b                   	pop    %ebx
801076d6:	5e                   	pop    %esi
801076d7:	5f                   	pop    %edi
801076d8:	5d                   	pop    %ebp
801076d9:	c3                   	ret    
801076da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801076e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801076e3:	31 c0                	xor    %eax,%eax
}
801076e5:	5b                   	pop    %ebx
801076e6:	5e                   	pop    %esi
801076e7:	5f                   	pop    %edi
801076e8:	5d                   	pop    %ebp
801076e9:	c3                   	ret    
      panic("loaduvm: address should exist");
801076ea:	83 ec 0c             	sub    $0xc,%esp
801076ed:	68 27 8f 10 80       	push   $0x80108f27
801076f2:	e8 99 8c ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
801076f7:	83 ec 0c             	sub    $0xc,%esp
801076fa:	68 1c 90 10 80       	push   $0x8010901c
801076ff:	e8 8c 8c ff ff       	call   80100390 <panic>
80107704:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010770a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107710 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107710:	55                   	push   %ebp
80107711:	89 e5                	mov    %esp,%ebp
80107713:	57                   	push   %edi
80107714:	56                   	push   %esi
80107715:	53                   	push   %ebx
80107716:	83 ec 1c             	sub    $0x1c,%esp
  #ifndef NONE
    struct proc *p = myproc();
80107719:	e8 42 c8 ff ff       	call   80103f60 <myproc>
8010771e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  #endif

  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
80107721:	8b 45 0c             	mov    0xc(%ebp),%eax
80107724:	39 45 10             	cmp    %eax,0x10(%ebp)
80107727:	73 59                	jae    80107782 <deallocuvm+0x72>
    return oldsz;
  }

  a = PGROUNDUP(newsz);
80107729:	8b 45 10             	mov    0x10(%ebp),%eax
8010772c:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107732:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a  < oldsz; a += PGSIZE){
80107738:	39 75 0c             	cmp    %esi,0xc(%ebp)
8010773b:	77 18                	ja     80107755 <deallocuvm+0x45>
8010773d:	eb 40                	jmp    8010777f <deallocuvm+0x6f>
8010773f:	90                   	nop
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      //a += (NPTENTRIES - 1) * PGSIZE;
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107743:	8b 18                	mov    (%eax),%ebx
80107745:	f6 c3 01             	test   $0x1,%bl
80107748:	75 46                	jne    80107790 <deallocuvm+0x80>
  for(; a  < oldsz; a += PGSIZE){
8010774a:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107750:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107753:	76 2a                	jbe    8010777f <deallocuvm+0x6f>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107755:	8b 45 08             	mov    0x8(%ebp),%eax
80107758:	31 c9                	xor    %ecx,%ecx
8010775a:	89 f2                	mov    %esi,%edx
8010775c:	e8 9f fb ff ff       	call   80107300 <walkpgdir>
    if(!pte)
80107761:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
80107763:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(!pte)
80107766:	75 d8                	jne    80107740 <deallocuvm+0x30>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107768:	81 e6 00 00 c0 ff    	and    $0xffc00000,%esi
8010776e:	81 c6 00 f0 3f 00    	add    $0x3ff000,%esi
  for(; a  < oldsz; a += PGSIZE){
80107774:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010777a:	39 75 0c             	cmp    %esi,0xc(%ebp)
8010777d:	77 d6                	ja     80107755 <deallocuvm+0x45>
      #endif
      *pte = 0;
  
    }
  }
  return newsz;
8010777f:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107782:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107785:	5b                   	pop    %ebx
80107786:	5e                   	pop    %esi
80107787:	5f                   	pop    %edi
80107788:	5d                   	pop    %ebp
80107789:	c3                   	ret    
8010778a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(pa == 0)
80107790:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107796:	0f 84 c8 00 00 00    	je     80107864 <deallocuvm+0x154>
      kfree(v);
8010779c:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010779f:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
      for(i = 0; i < MAX_PSYC_PAGES; i++){
801077a5:	31 ff                	xor    %edi,%edi
      kfree(v);
801077a7:	53                   	push   %ebx
801077a8:	e8 33 b0 ff ff       	call   801027e0 <kfree>
801077ad:	83 c4 10             	add    $0x10,%esp
          if(myproc()->physicalPGs[i].va == (char*)v){
801077b0:	e8 ab c7 ff ff       	call   80103f60 <myproc>
801077b5:	8d 0c 7f             	lea    (%edi,%edi,2),%ecx
801077b8:	c1 e1 03             	shl    $0x3,%ecx
801077bb:	39 9c 08 d8 01 00 00 	cmp    %ebx,0x1d8(%eax,%ecx,1)
801077c2:	74 2c                	je     801077f0 <deallocuvm+0xe0>
          }if(myproc()->swappedPGs[i].va == (char*)v){
801077c4:	e8 97 c7 ff ff       	call   80103f60 <myproc>
801077c9:	8d 0c bf             	lea    (%edi,%edi,4),%ecx
801077cc:	c1 e1 02             	shl    $0x2,%ecx
801077cf:	39 9c 08 a8 00 00 00 	cmp    %ebx,0xa8(%eax,%ecx,1)
801077d6:	74 68                	je     80107840 <deallocuvm+0x130>
      for(i = 0; i < MAX_PSYC_PAGES; i++){
801077d8:	83 c7 01             	add    $0x1,%edi
801077db:	83 ff 10             	cmp    $0x10,%edi
801077de:	75 d0                	jne    801077b0 <deallocuvm+0xa0>
      *pte = 0;
801077e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801077e3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801077e9:	e9 5c ff ff ff       	jmp    8010774a <deallocuvm+0x3a>
801077ee:	66 90                	xchg   %ax,%ax
            p->nPgsPhysical--;
801077f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077f3:	89 4d dc             	mov    %ecx,-0x24(%ebp)
801077f6:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
            if(myproc()->physicalPGs[i].alloceted){
801077fd:	e8 5e c7 ff ff       	call   80103f60 <myproc>
            myproc()->physicalPGs[i].va = (char*) 0xffffffff;
80107802:	e8 59 c7 ff ff       	call   80103f60 <myproc>
80107807:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010780a:	c7 84 08 d8 01 00 00 	movl   $0xffffffff,0x1d8(%eax,%ecx,1)
80107811:	ff ff ff ff 
            myproc()->physicalPGs[i].alloceted = 0;
80107815:	e8 46 c7 ff ff       	call   80103f60 <myproc>
8010781a:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010781d:	c7 84 08 e4 01 00 00 	movl   $0x0,0x1e4(%eax,%ecx,1)
80107824:	00 00 00 00 
      *pte = 0;
80107828:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010782b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107831:	e9 14 ff ff ff       	jmp    8010774a <deallocuvm+0x3a>
80107836:	8d 76 00             	lea    0x0(%esi),%esi
80107839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107840:	89 4d dc             	mov    %ecx,-0x24(%ebp)
            myproc()->swappedPGs[i].va = (char*) 0xffffffff;
80107843:	e8 18 c7 ff ff       	call   80103f60 <myproc>
80107848:	8b 4d dc             	mov    -0x24(%ebp),%ecx
8010784b:	c7 84 08 a8 00 00 00 	movl   $0xffffffff,0xa8(%eax,%ecx,1)
80107852:	ff ff ff ff 
      *pte = 0;
80107856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107859:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010785f:	e9 e6 fe ff ff       	jmp    8010774a <deallocuvm+0x3a>
        panic("kfree");
80107864:	83 ec 0c             	sub    $0xc,%esp
80107867:	68 45 8f 10 80       	push   $0x80108f45
8010786c:	e8 1f 8b ff ff       	call   80100390 <panic>
80107871:	eb 0d                	jmp    80107880 <freevm>
80107873:	90                   	nop
80107874:	90                   	nop
80107875:	90                   	nop
80107876:	90                   	nop
80107877:	90                   	nop
80107878:	90                   	nop
80107879:	90                   	nop
8010787a:	90                   	nop
8010787b:	90                   	nop
8010787c:	90                   	nop
8010787d:	90                   	nop
8010787e:	90                   	nop
8010787f:	90                   	nop

80107880 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107880:	55                   	push   %ebp
80107881:	89 e5                	mov    %esp,%ebp
80107883:	57                   	push   %edi
80107884:	56                   	push   %esi
80107885:	53                   	push   %ebx
80107886:	83 ec 0c             	sub    $0xc,%esp
80107889:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010788c:	85 f6                	test   %esi,%esi
8010788e:	74 59                	je     801078e9 <freevm+0x69>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80107890:	83 ec 04             	sub    $0x4,%esp
80107893:	89 f3                	mov    %esi,%ebx
80107895:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010789b:	6a 00                	push   $0x0
8010789d:	68 00 00 00 80       	push   $0x80000000
801078a2:	56                   	push   %esi
801078a3:	e8 68 fe ff ff       	call   80107710 <deallocuvm>
801078a8:	83 c4 10             	add    $0x10,%esp
801078ab:	eb 0a                	jmp    801078b7 <freevm+0x37>
801078ad:	8d 76 00             	lea    0x0(%esi),%esi
801078b0:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
801078b3:	39 fb                	cmp    %edi,%ebx
801078b5:	74 23                	je     801078da <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801078b7:	8b 03                	mov    (%ebx),%eax
801078b9:	a8 01                	test   $0x1,%al
801078bb:	74 f3                	je     801078b0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801078bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax

      kfree(v);
801078c2:	83 ec 0c             	sub    $0xc,%esp
801078c5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801078c8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
801078cd:	50                   	push   %eax
801078ce:	e8 0d af ff ff       	call   801027e0 <kfree>
801078d3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
801078d6:	39 fb                	cmp    %edi,%ebx
801078d8:	75 dd                	jne    801078b7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
801078da:	89 75 08             	mov    %esi,0x8(%ebp)
}
801078dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078e0:	5b                   	pop    %ebx
801078e1:	5e                   	pop    %esi
801078e2:	5f                   	pop    %edi
801078e3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801078e4:	e9 f7 ae ff ff       	jmp    801027e0 <kfree>
    panic("freevm: no pgdir");
801078e9:	83 ec 0c             	sub    $0xc,%esp
801078ec:	68 4b 8f 10 80       	push   $0x80108f4b
801078f1:	e8 9a 8a ff ff       	call   80100390 <panic>
801078f6:	8d 76 00             	lea    0x0(%esi),%esi
801078f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107900 <setupkvm>:
{
80107900:	55                   	push   %ebp
80107901:	89 e5                	mov    %esp,%ebp
80107903:	56                   	push   %esi
80107904:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107905:	e8 e6 b0 ff ff       	call   801029f0 <kalloc>
8010790a:	85 c0                	test   %eax,%eax
8010790c:	89 c6                	mov    %eax,%esi
8010790e:	74 42                	je     80107952 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107910:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107913:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
80107918:	68 00 10 00 00       	push   $0x1000
8010791d:	6a 00                	push   $0x0
8010791f:	50                   	push   %eax
80107920:	e8 4b d6 ff ff       	call   80104f70 <memset>
80107925:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107928:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010792b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010792e:	83 ec 08             	sub    $0x8,%esp
80107931:	8b 13                	mov    (%ebx),%edx
80107933:	ff 73 0c             	pushl  0xc(%ebx)
80107936:	50                   	push   %eax
80107937:	29 c1                	sub    %eax,%ecx
80107939:	89 f0                	mov    %esi,%eax
8010793b:	e8 40 fa ff ff       	call   80107380 <mappages>
80107940:	83 c4 10             	add    $0x10,%esp
80107943:	85 c0                	test   %eax,%eax
80107945:	78 19                	js     80107960 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107947:	83 c3 10             	add    $0x10,%ebx
8010794a:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80107950:	75 d6                	jne    80107928 <setupkvm+0x28>
}
80107952:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107955:	89 f0                	mov    %esi,%eax
80107957:	5b                   	pop    %ebx
80107958:	5e                   	pop    %esi
80107959:	5d                   	pop    %ebp
8010795a:	c3                   	ret    
8010795b:	90                   	nop
8010795c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107960:	83 ec 0c             	sub    $0xc,%esp
80107963:	56                   	push   %esi
      return 0;
80107964:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107966:	e8 15 ff ff ff       	call   80107880 <freevm>
      return 0;
8010796b:	83 c4 10             	add    $0x10,%esp
}
8010796e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107971:	89 f0                	mov    %esi,%eax
80107973:	5b                   	pop    %ebx
80107974:	5e                   	pop    %esi
80107975:	5d                   	pop    %ebp
80107976:	c3                   	ret    
80107977:	89 f6                	mov    %esi,%esi
80107979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107980 <kvmalloc>:
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107986:	e8 75 ff ff ff       	call   80107900 <setupkvm>
8010798b:	a3 c4 ab 15 80       	mov    %eax,0x8015abc4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107990:	05 00 00 00 80       	add    $0x80000000,%eax
80107995:	0f 22 d8             	mov    %eax,%cr3
}
80107998:	c9                   	leave  
80107999:	c3                   	ret    
8010799a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801079a0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801079a0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801079a1:	31 c9                	xor    %ecx,%ecx
{
801079a3:	89 e5                	mov    %esp,%ebp
801079a5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801079a8:	8b 55 0c             	mov    0xc(%ebp),%edx
801079ab:	8b 45 08             	mov    0x8(%ebp),%eax
801079ae:	e8 4d f9 ff ff       	call   80107300 <walkpgdir>
  if(pte == 0)
801079b3:	85 c0                	test   %eax,%eax
801079b5:	74 05                	je     801079bc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801079b7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801079ba:	c9                   	leave  
801079bb:	c3                   	ret    
    panic("clearpteu");
801079bc:	83 ec 0c             	sub    $0xc,%esp
801079bf:	68 5c 8f 10 80       	push   $0x80108f5c
801079c4:	e8 c7 89 ff ff       	call   80100390 <panic>
801079c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801079d0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801079d0:	55                   	push   %ebp
801079d1:	89 e5                	mov    %esp,%ebp
801079d3:	57                   	push   %edi
801079d4:	56                   	push   %esi
801079d5:	53                   	push   %ebx
801079d6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
801079d9:	e8 22 ff ff ff       	call   80107900 <setupkvm>
801079de:	85 c0                	test   %eax,%eax
801079e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801079e3:	0f 84 29 01 00 00    	je     80107b12 <copyuvm+0x142>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801079e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079ec:	85 c9                	test   %ecx,%ecx
801079ee:	0f 84 50 01 00 00    	je     80107b44 <copyuvm+0x174>
801079f4:	31 db                	xor    %ebx,%ebx
801079f6:	eb 65                	jmp    80107a5d <copyuvm+0x8d>
801079f8:	90                   	nop
801079f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    
    #ifndef NONE
    if(myproc()->pid>2){
    //pa = PTE_ADDR(*pte);
    if(*pte & PTE_PG){
80107a00:	f6 c4 02             	test   $0x2,%ah
80107a03:	0f 85 17 01 00 00    	jne    80107b20 <copyuvm+0x150>
        goto bad;
      }*/
      continue;
    }
    // Task 1
    *pte = *pte & ~PTE_W;
80107a09:	89 c2                	mov    %eax,%edx
    *pte = *pte | PTE_COW;
  
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);

    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
80107a0b:	83 ec 08             	sub    $0x8,%esp
80107a0e:	b9 00 10 00 00       	mov    $0x1000,%ecx
    *pte = *pte & ~PTE_W;
80107a13:	83 e2 fd             	and    $0xfffffffd,%edx
    *pte = *pte | PTE_COW;
80107a16:	80 ce 08             	or     $0x8,%dh
80107a19:	89 16                	mov    %edx,(%esi)
80107a1b:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80107a1d:	25 fd 0f 00 00       	and    $0xffd,%eax
80107a22:	80 cc 08             	or     $0x8,%ah
80107a25:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
80107a2b:	89 da                	mov    %ebx,%edx
80107a2d:	50                   	push   %eax
80107a2e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a31:	56                   	push   %esi
80107a32:	e8 49 f9 ff ff       	call   80107380 <mappages>
80107a37:	83 c4 10             	add    $0x10,%esp
80107a3a:	85 c0                	test   %eax,%eax
80107a3c:	0f 88 b0 00 00 00    	js     80107af2 <copyuvm+0x122>
      goto bad;
    }
    incrementReferenceCount(pa);
80107a42:	83 ec 0c             	sub    $0xc,%esp
80107a45:	56                   	push   %esi
80107a46:	e8 e5 b0 ff ff       	call   80102b30 <incrementReferenceCount>
80107a4b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
80107a4e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107a54:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80107a57:	0f 86 e7 00 00 00    	jbe    80107b44 <copyuvm+0x174>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107a5d:	8b 45 08             	mov    0x8(%ebp),%eax
80107a60:	31 c9                	xor    %ecx,%ecx
80107a62:	89 da                	mov    %ebx,%edx
80107a64:	e8 97 f8 ff ff       	call   80107300 <walkpgdir>
80107a69:	85 c0                	test   %eax,%eax
80107a6b:	89 c6                	mov    %eax,%esi
80107a6d:	0f 84 e7 00 00 00    	je     80107b5a <copyuvm+0x18a>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
80107a73:	f7 00 01 02 00 00    	testl  $0x201,(%eax)
80107a79:	0f 84 e8 00 00 00    	je     80107b67 <copyuvm+0x197>
    if(myproc()->pid>2){
80107a7f:	e8 dc c4 ff ff       	call   80103f60 <myproc>
80107a84:	83 78 10 02          	cmpl   $0x2,0x10(%eax)
    if(*pte & PTE_PG){
80107a88:	8b 06                	mov    (%esi),%eax
    if(myproc()->pid>2){
80107a8a:	0f 8f 70 ff ff ff    	jg     80107a00 <copyuvm+0x30>
    }else{
      char *mem;
      pa = PTE_ADDR(*pte);
80107a90:	89 c7                	mov    %eax,%edi
      flags = PTE_FLAGS(*pte);
80107a92:	25 ff 0f 00 00       	and    $0xfff,%eax
      pa = PTE_ADDR(*pte);
80107a97:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
      flags = PTE_FLAGS(*pte);
80107a9d:	89 45 e0             	mov    %eax,-0x20(%ebp)

      if((mem = kalloc()) == 0)
80107aa0:	e8 4b af ff ff       	call   801029f0 <kalloc>
80107aa5:	85 c0                	test   %eax,%eax
80107aa7:	89 c6                	mov    %eax,%esi
80107aa9:	74 47                	je     80107af2 <copyuvm+0x122>
        goto bad;
      memmove(mem, (char*)P2V(pa), PGSIZE);
80107aab:	83 ec 04             	sub    $0x4,%esp
80107aae:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ab4:	68 00 10 00 00       	push   $0x1000
80107ab9:	57                   	push   %edi
80107aba:	50                   	push   %eax
80107abb:	e8 60 d5 ff ff       	call   80105020 <memmove>
      if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107ac0:	58                   	pop    %eax
80107ac1:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107ac7:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107acc:	5a                   	pop    %edx
80107acd:	ff 75 e0             	pushl  -0x20(%ebp)
80107ad0:	50                   	push   %eax
80107ad1:	89 da                	mov    %ebx,%edx
80107ad3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ad6:	e8 a5 f8 ff ff       	call   80107380 <mappages>
80107adb:	83 c4 10             	add    $0x10,%esp
80107ade:	85 c0                	test   %eax,%eax
80107ae0:	0f 89 68 ff ff ff    	jns    80107a4e <copyuvm+0x7e>
      kfree(mem);
80107ae6:	83 ec 0c             	sub    $0xc,%esp
80107ae9:	56                   	push   %esi
80107aea:	e8 f1 ac ff ff       	call   801027e0 <kfree>
      goto bad;
80107aef:	83 c4 10             	add    $0x10,%esp
  //panic("shit");
  lcr3(V2P(pgdir));
  return d;

bad:
  freevm(d);
80107af2:	83 ec 0c             	sub    $0xc,%esp
80107af5:	ff 75 e4             	pushl  -0x1c(%ebp)
80107af8:	e8 83 fd ff ff       	call   80107880 <freevm>
  lcr3(V2P(pgdir));
80107afd:	8b 45 08             	mov    0x8(%ebp),%eax
80107b00:	05 00 00 00 80       	add    $0x80000000,%eax
80107b05:	0f 22 d8             	mov    %eax,%cr3
  return 0;
80107b08:	83 c4 10             	add    $0x10,%esp
80107b0b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107b12:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b15:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b18:	5b                   	pop    %ebx
80107b19:	5e                   	pop    %esi
80107b1a:	5f                   	pop    %edi
80107b1b:	5d                   	pop    %ebp
80107b1c:	c3                   	ret    
80107b1d:	8d 76 00             	lea    0x0(%esi),%esi
      pte = walkpgdir(d,(void*)i,1);
80107b20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b23:	89 da                	mov    %ebx,%edx
80107b25:	b9 01 00 00 00       	mov    $0x1,%ecx
  for(i = 0; i < sz; i += PGSIZE){
80107b2a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      pte = walkpgdir(d,(void*)i,1);
80107b30:	e8 cb f7 ff ff       	call   80107300 <walkpgdir>
  for(i = 0; i < sz; i += PGSIZE){
80107b35:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
      *pte= PTE_U | PTE_W | PTE_PG;
80107b38:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
  for(i = 0; i < sz; i += PGSIZE){
80107b3e:	0f 87 19 ff ff ff    	ja     80107a5d <copyuvm+0x8d>
  lcr3(V2P(pgdir));
80107b44:	8b 45 08             	mov    0x8(%ebp),%eax
80107b47:	05 00 00 00 80       	add    $0x80000000,%eax
80107b4c:	0f 22 d8             	mov    %eax,%cr3
}
80107b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b52:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b55:	5b                   	pop    %ebx
80107b56:	5e                   	pop    %esi
80107b57:	5f                   	pop    %edi
80107b58:	5d                   	pop    %ebp
80107b59:	c3                   	ret    
      panic("copyuvm: pte should exist");
80107b5a:	83 ec 0c             	sub    $0xc,%esp
80107b5d:	68 66 8f 10 80       	push   $0x80108f66
80107b62:	e8 29 88 ff ff       	call   80100390 <panic>
      panic("copyuvm: page not present");
80107b67:	83 ec 0c             	sub    $0xc,%esp
80107b6a:	68 80 8f 10 80       	push   $0x80108f80
80107b6f:	e8 1c 88 ff ff       	call   80100390 <panic>
80107b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107b80 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107b80:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b81:	31 c9                	xor    %ecx,%ecx
{
80107b83:	89 e5                	mov    %esp,%ebp
80107b85:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107b88:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b8b:	8b 45 08             	mov    0x8(%ebp),%eax
80107b8e:	e8 6d f7 ff ff       	call   80107300 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107b93:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b95:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107b96:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b98:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107b9d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ba0:	05 00 00 00 80       	add    $0x80000000,%eax
80107ba5:	83 fa 05             	cmp    $0x5,%edx
80107ba8:	ba 00 00 00 00       	mov    $0x0,%edx
80107bad:	0f 45 c2             	cmovne %edx,%eax
}
80107bb0:	c3                   	ret    
80107bb1:	eb 0d                	jmp    80107bc0 <copyout>
80107bb3:	90                   	nop
80107bb4:	90                   	nop
80107bb5:	90                   	nop
80107bb6:	90                   	nop
80107bb7:	90                   	nop
80107bb8:	90                   	nop
80107bb9:	90                   	nop
80107bba:	90                   	nop
80107bbb:	90                   	nop
80107bbc:	90                   	nop
80107bbd:	90                   	nop
80107bbe:	90                   	nop
80107bbf:	90                   	nop

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
80107bff:	e8 1c d4 ff ff       	call   80105020 <memmove>
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

80107c60 <leastAgeIndex>:
/***************************************************************************************************************************************************************/
/******************************************************************************   NFUA     *********************************************************************/
/***************************************************************************************************************************************************************/

int
leastAgeIndex(){
80107c60:	55                   	push   %ebp
80107c61:	89 e5                	mov    %esp,%ebp
80107c63:	57                   	push   %edi
80107c64:	56                   	push   %esi
80107c65:	53                   	push   %ebx
80107c66:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80107c69:	e8 f2 c2 ff ff       	call   80103f60 <myproc>
  uint leastAge = __UINT32_MAX__;
  int leastIndex = -1;
  int i;

  for(i = 0; i < p->nPgsPhysical ; i++){
80107c6e:	8b b8 80 00 00 00    	mov    0x80(%eax),%edi
80107c74:	85 ff                	test   %edi,%edi
80107c76:	7e 3f                	jle    80107cb7 <leastAgeIndex+0x57>
80107c78:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
80107c7e:	31 c9                	xor    %ecx,%ecx
  int leastIndex = -1;
80107c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint leastAge = __UINT32_MAX__;
80107c85:	be ff ff ff ff       	mov    $0xffffffff,%esi
80107c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->physicalPGs[i].age<=leastAge && p->physicalPGs[i].va != (char*)0xffffffff){
80107c90:	8b 5a 08             	mov    0x8(%edx),%ebx
80107c93:	39 f3                	cmp    %esi,%ebx
80107c95:	77 09                	ja     80107ca0 <leastAgeIndex+0x40>
80107c97:	83 3a ff             	cmpl   $0xffffffff,(%edx)
80107c9a:	0f 45 c1             	cmovne %ecx,%eax
80107c9d:	0f 45 f3             	cmovne %ebx,%esi
  for(i = 0; i < p->nPgsPhysical ; i++){
80107ca0:	83 c1 01             	add    $0x1,%ecx
80107ca3:	83 c2 18             	add    $0x18,%edx
80107ca6:	39 f9                	cmp    %edi,%ecx
80107ca8:	75 e6                	jne    80107c90 <leastAgeIndex+0x30>
    }
  }



  if(leastIndex == -1){
80107caa:	83 f8 ff             	cmp    $0xffffffff,%eax
80107cad:	74 08                	je     80107cb7 <leastAgeIndex+0x57>
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
80107cba:	68 40 90 10 80       	push   $0x80109040
80107cbf:	e8 cc 86 ff ff       	call   80100390 <panic>
80107cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107cd0 <nfuaWriteToSwap>:

struct procPG*
nfuaWriteToSwap(uint addr){/******************************************************************************** NFUA :  write *************************************/
80107cd0:	55                   	push   %ebp
80107cd1:	89 e5                	mov    %esp,%ebp
80107cd3:	57                   	push   %edi
80107cd4:	56                   	push   %esi
80107cd5:	53                   	push   %ebx
80107cd6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107cd9:	e8 82 c2 ff ff       	call   80103f60 <myproc>
80107cde:	89 c3                	mov    %eax,%ebx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107ce0:	e8 7b ff ff ff       	call   80107c60 <leastAgeIndex>
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107ce5:	8d 14 40             	lea    (%eax,%eax,2),%edx
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107ce8:	89 c6                	mov    %eax,%esi
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107cea:	8b 43 04             	mov    0x4(%ebx),%eax
80107ced:	31 c9                	xor    %ecx,%ecx
80107cef:	8b 94 d3 d8 01 00 00 	mov    0x1d8(%ebx,%edx,8),%edx
80107cf6:	e8 05 f6 ff ff       	call   80107300 <walkpgdir>

  p->nPgsPhysical--;
80107cfb:	83 ab 80 00 00 00 01 	subl   $0x1,0x80(%ebx)
  pte_t *pte = walkpgdir(p->pgdir, (void*)leastAgePG->va, 0);
80107d02:	89 c2                	mov    %eax,%edx
80107d04:	8d 8b a8 00 00 00    	lea    0xa8(%ebx),%ecx
  }else{
    //cprintf("!!addr: %x   pid: %x\n",(uint)leastAgePG->va,myproc()->pid);
  }

  int i;
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107d0a:	31 c0                	xor    %eax,%eax
80107d0c:	eb 11                	jmp    80107d1f <nfuaWriteToSwap+0x4f>
80107d0e:	66 90                	xchg   %ax,%ax
80107d10:	83 c0 01             	add    $0x1,%eax
80107d13:	83 c1 14             	add    $0x14,%ecx
    if(i== MAX_PSYC_PAGES){
80107d16:	83 f8 10             	cmp    $0x10,%eax
80107d19:	0f 84 f1 00 00 00    	je     80107e10 <nfuaWriteToSwap+0x140>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
    }
    if(p->swappedPGs[i].va == (char*)0xffffffff){
80107d1f:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107d22:	75 ec                	jne    80107d10 <nfuaWriteToSwap+0x40>
      p->swappedPGs[i].offset = i*PGSIZE;
80107d24:	89 c7                	mov    %eax,%edi
80107d26:	8d 04 80             	lea    (%eax,%eax,4),%eax
      p->swappedPGs[i].va = (char*)leastAgePG->va;
80107d29:	8d 0c 76             	lea    (%esi,%esi,2),%ecx
      p->swappedPGs[i].offset = i*PGSIZE;
80107d2c:	c1 e7 0c             	shl    $0xc,%edi
      //cprintf("swapped addr: %d\n",(uint)p->swappedPGs[i].va);
    }
  }


  acquire(&tickslock);
80107d2f:	83 ec 0c             	sub    $0xc,%esp
80107d32:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      p->swappedPGs[i].offset = i*PGSIZE;
80107d35:	8d 04 83             	lea    (%ebx,%eax,4),%eax
80107d38:	89 b8 98 00 00 00    	mov    %edi,0x98(%eax)
      p->swappedPGs[i].va = (char*)leastAgePG->va;
80107d3e:	8b 8c cb d8 01 00 00 	mov    0x1d8(%ebx,%ecx,8),%ecx
80107d45:	89 88 a8 00 00 00    	mov    %ecx,0xa8(%eax)
  acquire(&tickslock);
80107d4b:	68 80 a3 15 80       	push   $0x8015a380
80107d50:	e8 0b d1 ff ff       	call   80104e60 <acquire>
  if(*pte & PTE_A){
80107d55:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107d58:	83 c4 10             	add    $0x10,%esp
80107d5b:	8b 02                	mov    (%edx),%eax
80107d5d:	a8 20                	test   $0x20,%al
80107d5f:	0f 85 9b 00 00 00    	jne    80107e00 <nfuaWriteToSwap+0x130>
    *pte &= ~PTE_A;
  }
  release(&tickslock);
80107d65:	83 ec 0c             	sub    $0xc,%esp

  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107d68:	8d 34 76             	lea    (%esi,%esi,2),%esi
80107d6b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  release(&tickslock);
80107d6e:	68 80 a3 15 80       	push   $0x8015a380
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107d73:	c1 e6 03             	shl    $0x3,%esi
  release(&tickslock);
80107d76:	e8 a5 d1 ff ff       	call   80104f20 <release>
  if(writeToSwapFile(p,(char*)PTE_ADDR(leastAgePG->va),i*PGSIZE, PGSIZE)<=0){
80107d7b:	68 00 10 00 00       	push   $0x1000
80107d80:	57                   	push   %edi
80107d81:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
80107d84:	8b 87 d8 01 00 00    	mov    0x1d8(%edi),%eax
80107d8a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d8f:	50                   	push   %eax
80107d90:	53                   	push   %ebx
80107d91:	e8 fa a5 ff ff       	call   80102390 <writeToSwapFile>
80107d96:	83 c4 20             	add    $0x20,%esp
80107d99:	85 c0                	test   %eax,%eax
80107d9b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107d9e:	7e 7d                	jle    80107e1d <nfuaWriteToSwap+0x14d>

  //if(p->allocatedInPhys>MAX_PSYC_PAGES){
    
  
  //decrementReferenceCount(PTE_ADDR(*pte));
  kfree((char*)(P2V(PTE_ADDR(*pte))));
80107da0:	8b 02                	mov    (%edx),%eax
80107da2:	83 ec 0c             	sub    $0xc,%esp
80107da5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107da8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107dad:	05 00 00 00 80       	add    $0x80000000,%eax
80107db2:	50                   	push   %eax
80107db3:	e8 28 aa ff ff       	call   801027e0 <kfree>


  //}
  *pte |= PTE_PG;
  *pte &= ~PTE_P;
80107db8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107dbb:	8b 02                	mov    (%edx),%eax
80107dbd:	83 e0 fe             	and    $0xfffffffe,%eax
80107dc0:	80 cc 02             	or     $0x2,%ah
80107dc3:	89 02                	mov    %eax,(%edx)
  //*pte &= ~PTE_COW;

  //sets the empty page to the head of the proc page list
  leastAgePG->va = (char*) 0xffffffff;
80107dc5:	c7 87 d8 01 00 00 ff 	movl   $0xffffffff,0x1d8(%edi)
80107dcc:	ff ff ff 
  leastAgePG->age = 0 ;
80107dcf:	c7 87 e0 01 00 00 00 	movl   $0x0,0x1e0(%edi)
80107dd6:	00 00 00 
  leastAgePG->alloceted = 0 ;
80107dd9:	c7 87 e4 01 00 00 00 	movl   $0x0,0x1e4(%edi)
80107de0:	00 00 00 

  //movePageToHead(leastAgePG);

  lcr3(V2P(p->pgdir));  // switch to process's address space
80107de3:	8b 43 04             	mov    0x4(%ebx),%eax
80107de6:	05 00 00 00 80       	add    $0x80000000,%eax
80107deb:	0f 22 d8             	mov    %eax,%cr3

  return leastAgePG;
}
80107dee:	8d 65 f4             	lea    -0xc(%ebp),%esp
  struct procPG *leastAgePG = &p->physicalPGs[leastAgeIndex()];
80107df1:	8d 84 33 d8 01 00 00 	lea    0x1d8(%ebx,%esi,1),%eax
}
80107df8:	5b                   	pop    %ebx
80107df9:	5e                   	pop    %esi
80107dfa:	5f                   	pop    %edi
80107dfb:	5d                   	pop    %ebp
80107dfc:	c3                   	ret    
80107dfd:	8d 76 00             	lea    0x0(%esi),%esi
    *pte &= ~PTE_A;
80107e00:	83 e0 df             	and    $0xffffffdf,%eax
80107e03:	89 02                	mov    %eax,(%edx)
80107e05:	e9 5b ff ff ff       	jmp    80107d65 <nfuaWriteToSwap+0x95>
80107e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      panic(" scfifoWriteToSwap: unable to find slot for swap");
80107e10:	83 ec 0c             	sub    $0xc,%esp
80107e13:	68 68 90 10 80       	push   $0x80109068
80107e18:	e8 73 85 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107e1d:	83 ec 0c             	sub    $0xc,%esp
80107e20:	68 9c 90 10 80       	push   $0x8010909c
80107e25:	e8 66 85 ff ff       	call   80100390 <panic>
80107e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e30 <initNFUA>:

  lcr3(V2P(p->pgdir));
}

void
initNFUA(char *va){/******************************************************************************* NFUA :  init ***********************************************/
80107e30:	55                   	push   %ebp
80107e31:	89 e5                	mov    %esp,%ebp
80107e33:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc();
80107e36:	e8 25 c1 ff ff       	call   80103f60 <myproc>
  int i;
  char* addrToOverwrite = (char*)0xffffffff;
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107e3b:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80107e42:	7f 41                	jg     80107e85 <initNFUA+0x55>
80107e44:	8d 88 d8 01 00 00    	lea    0x1d8(%eax),%ecx
      panic("wtf");
      myproc()->nPgsPhysical--;
  }
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107e4a:	31 d2                	xor    %edx,%edx
80107e4c:	eb 0d                	jmp    80107e5b <initNFUA+0x2b>
80107e4e:	66 90                	xchg   %ax,%ax
80107e50:	83 c2 01             	add    $0x1,%edx
80107e53:	83 c1 18             	add    $0x18,%ecx
80107e56:	83 fa 11             	cmp    $0x11,%edx
80107e59:	74 28                	je     80107e83 <initNFUA+0x53>

    if(p->physicalPGs[i].va == addrToOverwrite){
80107e5b:	83 39 ff             	cmpl   $0xffffffff,(%ecx)
80107e5e:	75 f0                	jne    80107e50 <initNFUA+0x20>
      p->physicalPGs[i].va = va;
80107e60:	8d 14 52             	lea    (%edx,%edx,2),%edx
80107e63:	8d 04 d0             	lea    (%eax,%edx,8),%eax
80107e66:	8b 55 08             	mov    0x8(%ebp),%edx
      p->physicalPGs[i].age = 0;
80107e69:	c7 80 e0 01 00 00 00 	movl   $0x0,0x1e0(%eax)
80107e70:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80107e73:	c7 80 e4 01 00 00 01 	movl   $0x1,0x1e4(%eax)
80107e7a:	00 00 00 
      p->physicalPGs[i].va = va;
80107e7d:	89 90 d8 01 00 00    	mov    %edx,0x1d8(%eax)
      return;
    }
  }
}
80107e83:	c9                   	leave  
80107e84:	c3                   	ret    
      panic("wtf");
80107e85:	83 ec 0c             	sub    $0xc,%esp
80107e88:	68 9a 8f 10 80       	push   $0x80108f9a
80107e8d:	e8 fe 84 ff ff       	call   80100390 <panic>
80107e92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ea0 <indexInSwapFile>:
/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/
int
indexInSwapFile(uint addr){
80107ea0:	55                   	push   %ebp
80107ea1:	89 e5                	mov    %esp,%ebp
80107ea3:	57                   	push   %edi
80107ea4:	56                   	push   %esi
80107ea5:	53                   	push   %ebx
80107ea6:	83 ec 0c             	sub    $0xc,%esp
  
  struct proc *p =myproc();
80107ea9:	e8 b2 c0 ff ff       	call   80103f60 <myproc>
80107eae:	8b 75 08             	mov    0x8(%ebp),%esi
80107eb1:	8d 90 a8 00 00 00    	lea    0xa8(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107eb7:	31 c9                	xor    %ecx,%ecx
80107eb9:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107ebf:	eb 12                	jmp    80107ed3 <indexInSwapFile+0x33>
80107ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ec8:	83 c1 01             	add    $0x1,%ecx
80107ecb:	83 c2 14             	add    $0x14,%edx
80107ece:	83 f9 10             	cmp    $0x10,%ecx
80107ed1:	74 15                	je     80107ee8 <indexInSwapFile+0x48>

    if(p->swappedPGs[i].va == (char*) PGROUNDDOWN(addr)){
80107ed3:	39 32                	cmp    %esi,(%edx)
80107ed5:	75 f1                	jne    80107ec8 <indexInSwapFile+0x28>

    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107ed7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107eda:	89 c8                	mov    %ecx,%eax
80107edc:	5b                   	pop    %ebx
80107edd:	5e                   	pop    %esi
80107ede:	5f                   	pop    %edi
80107edf:	5d                   	pop    %ebp
80107ee0:	c3                   	ret    
80107ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ee8:	8d 98 d8 01 00 00    	lea    0x1d8(%eax),%ebx
80107eee:	8d b8 58 03 00 00    	lea    0x358(%eax),%edi
80107ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("after panic: %x as %x\n",(uint)p->physicalPGs[i].va,PGROUNDDOWN(addr));
80107ef8:	83 ec 04             	sub    $0x4,%esp
80107efb:	83 c3 18             	add    $0x18,%ebx
80107efe:	56                   	push   %esi
80107eff:	ff 73 e8             	pushl  -0x18(%ebx)
80107f02:	68 9e 8f 10 80       	push   $0x80108f9e
80107f07:	e8 54 87 ff ff       	call   80100660 <cprintf>
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107f0c:	83 c4 10             	add    $0x10,%esp
80107f0f:	39 fb                	cmp    %edi,%ebx
80107f11:	75 e5                	jne    80107ef8 <indexInSwapFile+0x58>
  panic("scfifoSwap: could not find page in swap file");
80107f13:	83 ec 0c             	sub    $0xc,%esp
80107f16:	68 c0 90 10 80       	push   $0x801090c0
80107f1b:	e8 70 84 ff ff       	call   80100390 <panic>

80107f20 <writePageToSwapFile>:


// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
80107f20:	55                   	push   %ebp
80107f21:	89 e5                	mov    %esp,%ebp
80107f23:	53                   	push   %ebx
80107f24:	83 ec 10             	sub    $0x10,%esp
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap(PGROUNDDOWN((uint)va));
  #endif
  #ifdef NFUA
    retPG=nfuaWriteToSwap((uint)va);
80107f27:	ff 75 08             	pushl  0x8(%ebp)
80107f2a:	e8 a1 fd ff ff       	call   80107cd0 <nfuaWriteToSwap>
80107f2f:	89 c3                	mov    %eax,%ebx
  #endif
  myproc()->nTotalPGout++;
80107f31:	e8 2a c0 ff ff       	call   80103f60 <myproc>
80107f36:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)
  myproc()->nPgsSwap++;
80107f3d:	e8 1e c0 ff ff       	call   80103f60 <myproc>
80107f42:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}
80107f49:	89 d8                	mov    %ebx,%eax
80107f4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f4e:	c9                   	leave  
80107f4f:	c3                   	ret    

80107f50 <nfuaSwap>:
nfuaSwap(uint addr){/******************************************************************************** NFUA :  swap *********************************************/
80107f50:	55                   	push   %ebp
80107f51:	89 e5                	mov    %esp,%ebp
80107f53:	57                   	push   %edi
80107f54:	56                   	push   %esi
80107f55:	53                   	push   %ebx
80107f56:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
80107f59:	e8 02 c0 ff ff       	call   80103f60 <myproc>
  int i = indexInSwapFile(addr);
80107f5e:	83 ec 0c             	sub    $0xc,%esp
80107f61:	ff 75 08             	pushl  0x8(%ebp)
  struct proc *p = myproc();
80107f64:	89 c3                	mov    %eax,%ebx
  int i = indexInSwapFile(addr);
80107f66:	e8 35 ff ff ff       	call   80107ea0 <indexInSwapFile>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107f6b:	83 c4 10             	add    $0x10,%esp
80107f6e:	83 bb 80 00 00 00 0f 	cmpl   $0xf,0x80(%ebx)
  int i = indexInSwapFile(addr);
80107f75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107f78:	0f 8f 12 01 00 00    	jg     80108090 <nfuaSwap+0x140>
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107f7e:	8b 55 08             	mov    0x8(%ebp),%edx
80107f81:	8b 43 04             	mov    0x4(%ebx),%eax
80107f84:	31 c9                	xor    %ecx,%ecx
80107f86:	e8 75 f3 ff ff       	call   80107300 <walkpgdir>
  if((buf = kalloc()) == 0){
80107f8b:	e8 60 aa ff ff       	call   801029f0 <kalloc>
80107f90:	85 c0                	test   %eax,%eax
80107f92:	89 c6                	mov    %eax,%esi
80107f94:	0f 84 16 01 00 00    	je     801080b0 <nfuaSwap+0x160>
  memset(buf, 0, PGSIZE );
80107f9a:	83 ec 04             	sub    $0x4,%esp
80107f9d:	68 00 10 00 00       	push   $0x1000
80107fa2:	6a 00                	push   $0x0
80107fa4:	50                   	push   %eax
80107fa5:	e8 c6 cf ff ff       	call   80104f70 <memset>
  if(readFromSwapFile(p, buf, i*PGSIZE, PGSIZE) <= 0){
80107faa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107fad:	68 00 10 00 00       	push   $0x1000
80107fb2:	c1 e0 0c             	shl    $0xc,%eax
80107fb5:	50                   	push   %eax
80107fb6:	56                   	push   %esi
80107fb7:	53                   	push   %ebx
80107fb8:	e8 03 a4 ff ff       	call   801023c0 <readFromSwapFile>
80107fbd:	83 c4 20             	add    $0x20,%esp
80107fc0:	85 c0                	test   %eax,%eax
80107fc2:	0f 8e db 00 00 00    	jle    801080a3 <nfuaSwap+0x153>
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107fc8:	8b 55 08             	mov    0x8(%ebp),%edx
80107fcb:	8b 43 04             	mov    0x4(%ebx),%eax
80107fce:	31 c9                	xor    %ecx,%ecx
  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
80107fd0:	81 c6 00 00 00 80    	add    $0x80000000,%esi
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107fd6:	e8 25 f3 ff ff       	call   80107300 <walkpgdir>
  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
80107fdb:	8b 55 08             	mov    0x8(%ebp),%edx
80107fde:	83 ec 08             	sub    $0x8,%esp
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107fe1:	89 c7                	mov    %eax,%edi
  mappages(p->pgdir,(char*)PTE_ADDR(PGROUNDDOWN(addr)) , PGSIZE , V2P(buf), PTE_W | PTE_U);
80107fe3:	8b 43 04             	mov    0x4(%ebx),%eax
80107fe6:	6a 06                	push   $0x6
80107fe8:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107fed:	56                   	push   %esi
80107fee:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107ff4:	89 55 e0             	mov    %edx,-0x20(%ebp)
80107ff7:	e8 84 f3 ff ff       	call   80107380 <mappages>
  p->swappedPGs[i].va = (char*)0xffffffff;//
80107ffc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  p->nPgsSwap--;
80107fff:	83 ab 84 00 00 00 01 	subl   $0x1,0x84(%ebx)
80108006:	8d 93 d8 01 00 00    	lea    0x1d8(%ebx),%edx
8010800c:	83 c4 10             	add    $0x10,%esp
  p->swappedPGs[i].va = (char*)0xffffffff;//
8010800f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80108012:	c7 84 83 a8 00 00 00 	movl   $0xffffffff,0xa8(%ebx,%eax,4)
80108019:	ff ff ff ff 
  *pte2 &= ~PTE_PG;
8010801d:	8b 07                	mov    (%edi),%eax
8010801f:	80 e4 f5             	and    $0xf5,%ah
80108022:	83 c8 03             	or     $0x3,%eax
80108025:	89 07                	mov    %eax,(%edi)
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
80108027:	31 c0                	xor    %eax,%eax
80108029:	eb 10                	jmp    8010803b <nfuaSwap+0xeb>
8010802b:	90                   	nop
8010802c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108030:	83 c0 01             	add    $0x1,%eax
80108033:	83 c2 18             	add    $0x18,%edx
    if(i==MAX_PSYC_PAGES){
80108036:	83 f8 10             	cmp    $0x10,%eax
80108039:	74 45                	je     80108080 <nfuaSwap+0x130>
    if(p->physicalPGs[i].va == (char*)0xffffffff){
8010803b:	83 3a ff             	cmpl   $0xffffffff,(%edx)
8010803e:	75 f0                	jne    80108030 <nfuaSwap+0xe0>
      p->physicalPGs[i].va = (char*)PGROUNDDOWN(addr);
80108040:	8d 04 40             	lea    (%eax,%eax,2),%eax
80108043:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80108046:	8d 04 c3             	lea    (%ebx,%eax,8),%eax
80108049:	89 88 d8 01 00 00    	mov    %ecx,0x1d8(%eax)
      p->physicalPGs[i].age = 0;
8010804f:	c7 80 e0 01 00 00 00 	movl   $0x0,0x1e0(%eax)
80108056:	00 00 00 
      p->physicalPGs[i].alloceted = 1;
80108059:	c7 80 e4 01 00 00 01 	movl   $0x1,0x1e4(%eax)
80108060:	00 00 00 
  lcr3(V2P(p->pgdir));
80108063:	8b 43 04             	mov    0x4(%ebx),%eax
  p->nPgsPhysical++;
80108066:	83 83 80 00 00 00 01 	addl   $0x1,0x80(%ebx)
  lcr3(V2P(p->pgdir));
8010806d:	05 00 00 00 80       	add    $0x80000000,%eax
80108072:	0f 22 d8             	mov    %eax,%cr3
}
80108075:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108078:	5b                   	pop    %ebx
80108079:	5e                   	pop    %esi
8010807a:	5f                   	pop    %edi
8010807b:	5d                   	pop    %ebp
8010807c:	c3                   	ret    
8010807d:	8d 76 00             	lea    0x0(%esi),%esi
      panic("cannot allocate phy page nfuaSwap");
80108080:	83 ec 0c             	sub    $0xc,%esp
80108083:	68 10 91 10 80       	push   $0x80109110
80108088:	e8 03 83 ff ff       	call   80100390 <panic>
8010808d:	8d 76 00             	lea    0x0(%esi),%esi
    writePageToSwapFile((char*)addr);
80108090:	83 ec 0c             	sub    $0xc,%esp
80108093:	ff 75 08             	pushl  0x8(%ebp)
80108096:	e8 85 fe ff ff       	call   80107f20 <writePageToSwapFile>
8010809b:	83 c4 10             	add    $0x10,%esp
8010809e:	e9 db fe ff ff       	jmp    80107f7e <nfuaSwap+0x2e>
      panic("scfifoSwap: read from swapfile");
801080a3:	83 ec 0c             	sub    $0xc,%esp
801080a6:	68 f0 90 10 80       	push   $0x801090f0
801080ab:	e8 e0 82 ff ff       	call   80100390 <panic>
    panic("nfuaSwap : allocating buf");
801080b0:	83 ec 0c             	sub    $0xc,%esp
801080b3:	68 b5 8f 10 80       	push   $0x80108fb5
801080b8:	e8 d3 82 ff ff       	call   80100390 <panic>
801080bd:	8d 76 00             	lea    0x0(%esi),%esi

801080c0 <swapPage>:

void 
swapPage(uint addr){
801080c0:	55                   	push   %ebp
801080c1:	89 e5                	mov    %esp,%ebp

  #ifdef NFUA
    return nfuaSwap(addr);
  #endif

}
801080c3:	5d                   	pop    %ebp
    return nfuaSwap(addr);
801080c4:	e9 87 fe ff ff       	jmp    80107f50 <nfuaSwap>
801080c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801080d0 <initPhysicalPage>:

int
initPhysicalPage(char *va){
801080d0:	55                   	push   %ebp
801080d1:	89 e5                	mov    %esp,%ebp
801080d3:	83 ec 14             	sub    $0x14,%esp

  #ifdef SCFIFO
    initSCFIFO(va);
  #endif
  #ifdef NFUA
    initNFUA(va);
801080d6:	ff 75 08             	pushl  0x8(%ebp)
801080d9:	e8 52 fd ff ff       	call   80107e30 <initNFUA>
  #endif
  myproc()->nPgsPhysical++;
801080de:	e8 7d be ff ff       	call   80103f60 <myproc>
801080e3:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
  //myproc()->allocatedInPhys++;
  //cprintf("%d chikd : %d\n",myproc()->pid,myproc()->allocatedInPhys);


  return 0;
}
801080ea:	31 c0                	xor    %eax,%eax
801080ec:	c9                   	leave  
801080ed:	c3                   	ret    
801080ee:	66 90                	xchg   %ax,%ax

801080f0 <allocuvm>:
{
801080f0:	55                   	push   %ebp
801080f1:	89 e5                	mov    %esp,%ebp
801080f3:	57                   	push   %edi
801080f4:	56                   	push   %esi
801080f5:	53                   	push   %ebx
801080f6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801080f9:	8b 7d 10             	mov    0x10(%ebp),%edi
801080fc:	85 ff                	test   %edi,%edi
801080fe:	0f 88 ec 00 00 00    	js     801081f0 <allocuvm+0x100>
  if(newsz < oldsz)
80108104:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108107:	0f 82 d3 00 00 00    	jb     801081e0 <allocuvm+0xf0>
  a = PGROUNDUP(oldsz);
8010810d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108110:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108116:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010811c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010811f:	0f 86 be 00 00 00    	jbe    801081e3 <allocuvm+0xf3>
80108125:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80108128:	8b 7d 08             	mov    0x8(%ebp),%edi
8010812b:	eb 4f                	jmp    8010817c <allocuvm+0x8c>
8010812d:	8d 76 00             	lea    0x0(%esi),%esi
      initPhysicalPage((char*)a);
80108130:	83 ec 0c             	sub    $0xc,%esp
80108133:	53                   	push   %ebx
80108134:	e8 97 ff ff ff       	call   801080d0 <initPhysicalPage>
    memset(mem, 0, PGSIZE);
80108139:	83 c4 0c             	add    $0xc,%esp
8010813c:	68 00 10 00 00       	push   $0x1000
80108141:	6a 00                	push   $0x0
80108143:	56                   	push   %esi
80108144:	e8 27 ce ff ff       	call   80104f70 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108149:	58                   	pop    %eax
8010814a:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108150:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108155:	5a                   	pop    %edx
80108156:	6a 06                	push   $0x6
80108158:	50                   	push   %eax
80108159:	89 da                	mov    %ebx,%edx
8010815b:	89 f8                	mov    %edi,%eax
8010815d:	e8 1e f2 ff ff       	call   80107380 <mappages>
80108162:	83 c4 10             	add    $0x10,%esp
80108165:	85 c0                	test   %eax,%eax
80108167:	0f 88 93 00 00 00    	js     80108200 <allocuvm+0x110>
  for(; a < newsz; a += PGSIZE){
8010816d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80108173:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80108176:	0f 86 bc 00 00 00    	jbe    80108238 <allocuvm+0x148>
      if(myproc()->nPgsPhysical >= MAX_PSYC_PAGES){
8010817c:	e8 df bd ff ff       	call   80103f60 <myproc>
80108181:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80108188:	7e 14                	jle    8010819e <allocuvm+0xae>
        if( (pg = writePageToSwapFile((char*)a)) == 0){
8010818a:	83 ec 0c             	sub    $0xc,%esp
8010818d:	53                   	push   %ebx
8010818e:	e8 8d fd ff ff       	call   80107f20 <writePageToSwapFile>
80108193:	83 c4 10             	add    $0x10,%esp
80108196:	85 c0                	test   %eax,%eax
80108198:	0f 84 a7 00 00 00    	je     80108245 <allocuvm+0x155>
    mem = kalloc();
8010819e:	e8 4d a8 ff ff       	call   801029f0 <kalloc>
    if(mem == 0){
801081a3:	85 c0                	test   %eax,%eax
    mem = kalloc();
801081a5:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801081a7:	75 87                	jne    80108130 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801081a9:	83 ec 0c             	sub    $0xc,%esp
      return 0;
801081ac:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory\n");
801081ae:	68 e5 8f 10 80       	push   $0x80108fe5
801081b3:	e8 a8 84 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801081b8:	83 c4 0c             	add    $0xc,%esp
801081bb:	ff 75 0c             	pushl  0xc(%ebp)
801081be:	ff 75 10             	pushl  0x10(%ebp)
801081c1:	ff 75 08             	pushl  0x8(%ebp)
801081c4:	e8 47 f5 ff ff       	call   80107710 <deallocuvm>
      return 0;
801081c9:	83 c4 10             	add    $0x10,%esp
}
801081cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081cf:	89 f8                	mov    %edi,%eax
801081d1:	5b                   	pop    %ebx
801081d2:	5e                   	pop    %esi
801081d3:	5f                   	pop    %edi
801081d4:	5d                   	pop    %ebp
801081d5:	c3                   	ret    
801081d6:	8d 76 00             	lea    0x0(%esi),%esi
801081d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return oldsz;
801081e0:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
801081e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081e6:	89 f8                	mov    %edi,%eax
801081e8:	5b                   	pop    %ebx
801081e9:	5e                   	pop    %esi
801081ea:	5f                   	pop    %edi
801081eb:	5d                   	pop    %ebp
801081ec:	c3                   	ret    
801081ed:	8d 76 00             	lea    0x0(%esi),%esi
801081f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801081f3:	31 ff                	xor    %edi,%edi
}
801081f5:	89 f8                	mov    %edi,%eax
801081f7:	5b                   	pop    %ebx
801081f8:	5e                   	pop    %esi
801081f9:	5f                   	pop    %edi
801081fa:	5d                   	pop    %ebp
801081fb:	c3                   	ret    
801081fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80108200:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80108203:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory (2)\n");
80108205:	68 fd 8f 10 80       	push   $0x80108ffd
8010820a:	e8 51 84 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
8010820f:	83 c4 0c             	add    $0xc,%esp
80108212:	ff 75 0c             	pushl  0xc(%ebp)
80108215:	ff 75 10             	pushl  0x10(%ebp)
80108218:	ff 75 08             	pushl  0x8(%ebp)
8010821b:	e8 f0 f4 ff ff       	call   80107710 <deallocuvm>
      kfree(mem);
80108220:	89 34 24             	mov    %esi,(%esp)
80108223:	e8 b8 a5 ff ff       	call   801027e0 <kfree>
      return 0;
80108228:	83 c4 10             	add    $0x10,%esp
}
8010822b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010822e:	89 f8                	mov    %edi,%eax
80108230:	5b                   	pop    %ebx
80108231:	5e                   	pop    %esi
80108232:	5f                   	pop    %edi
80108233:	5d                   	pop    %ebp
80108234:	c3                   	ret    
80108235:	8d 76 00             	lea    0x0(%esi),%esi
80108238:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010823b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010823e:	5b                   	pop    %ebx
8010823f:	89 f8                	mov    %edi,%eax
80108241:	5e                   	pop    %esi
80108242:	5f                   	pop    %edi
80108243:	5d                   	pop    %ebp
80108244:	c3                   	ret    
          panic("allocuvm: swapOutPage");
80108245:	83 ec 0c             	sub    $0xc,%esp
80108248:	68 cf 8f 10 80       	push   $0x80108fcf
8010824d:	e8 3e 81 ff ff       	call   80100390 <panic>
80108252:	66 90                	xchg   %ax,%ax
80108254:	66 90                	xchg   %ax,%ax
80108256:	66 90                	xchg   %ax,%ax
80108258:	66 90                	xchg   %ax,%ax
8010825a:	66 90                	xchg   %ax,%ax
8010825c:	66 90                	xchg   %ax,%ax
8010825e:	66 90                	xchg   %ax,%ax

80108260 <indexInPhysicalMem>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "elf.h"
int
indexInPhysicalMem(struct procPG *pg){
80108260:	55                   	push   %ebp
80108261:	89 e5                	mov    %esp,%ebp
80108263:	83 ec 08             	sub    $0x8,%esp
  struct proc *p =myproc();
80108266:	e8 f5 bc ff ff       	call   80103f60 <myproc>
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){

    if(p->physicalPGs[i].va == pg->va){
8010826b:	8b 55 08             	mov    0x8(%ebp),%edx
8010826e:	8b 0a                	mov    (%edx),%ecx
80108270:	8d 90 d8 01 00 00    	lea    0x1d8(%eax),%edx
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80108276:	31 c0                	xor    %eax,%eax
80108278:	eb 11                	jmp    8010828b <indexInPhysicalMem+0x2b>
8010827a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80108280:	83 c0 01             	add    $0x1,%eax
80108283:	83 c2 18             	add    $0x18,%edx
80108286:	83 f8 10             	cmp    $0x10,%eax
80108289:	74 0d                	je     80108298 <indexInPhysicalMem+0x38>
    if(p->physicalPGs[i].va == pg->va){
8010828b:	39 0a                	cmp    %ecx,(%edx)
8010828d:	75 f1                	jne    80108280 <indexInPhysicalMem+0x20>
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
8010828f:	c9                   	leave  
80108290:	c3                   	ret    
80108291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  panic("scfifoSwap: could not find page in swap file");
80108298:	83 ec 0c             	sub    $0xc,%esp
8010829b:	68 c0 90 10 80       	push   $0x801090c0
801082a0:	e8 eb 80 ff ff       	call   80100390 <panic>
801082a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801082a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801082b0 <movePageToHead>:


void 
movePageToHead(struct procPG *pg){
801082b0:	55                   	push   %ebp
801082b1:	89 e5                	mov    %esp,%ebp
801082b3:	53                   	push   %ebx
801082b4:	83 ec 04             	sub    $0x4,%esp
801082b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  struct proc *p = myproc();
801082ba:	e8 a1 bc ff ff       	call   80103f60 <myproc>

  if(p->headPG==-1){
801082bf:	83 b8 94 00 00 00 ff 	cmpl   $0xffffffff,0x94(%eax)
801082c6:	74 49                	je     80108311 <movePageToHead+0x61>
    panic("aaa");
  }
  if(pg->prev){
801082c8:	8b 4b 14             	mov    0x14(%ebx),%ecx
801082cb:	8b 53 10             	mov    0x10(%ebx),%edx
801082ce:	85 c9                	test   %ecx,%ecx
801082d0:	74 06                	je     801082d8 <movePageToHead+0x28>
    pg->prev->next = pg->next;
801082d2:	89 51 10             	mov    %edx,0x10(%ecx)
801082d5:	8b 53 10             	mov    0x10(%ebx),%edx
  }
  if(pg->next){
801082d8:	85 d2                	test   %edx,%edx
801082da:	74 06                	je     801082e2 <movePageToHead+0x32>
    pg->next->prev = pg->prev;
801082dc:	8b 4b 14             	mov    0x14(%ebx),%ecx
801082df:	89 4a 14             	mov    %ecx,0x14(%edx)
  }

  pg->next = &p->physicalPGs[p->headPG];
801082e2:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
  pg->prev = 0;
801082e8:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  pg->next = &p->physicalPGs[p->headPG];
801082ef:	8d 14 52             	lea    (%edx,%edx,2),%edx
801082f2:	8d 94 d0 d8 01 00 00 	lea    0x1d8(%eax,%edx,8),%edx
801082f9:	89 53 10             	mov    %edx,0x10(%ebx)
  p->physicalPGs[p->headPG].prev = pg;
801082fc:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80108302:	8d 14 52             	lea    (%edx,%edx,2),%edx
80108305:	89 9c d0 ec 01 00 00 	mov    %ebx,0x1ec(%eax,%edx,8)

}
8010830c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010830f:	c9                   	leave  
80108310:	c3                   	ret    
    panic("aaa");
80108311:	83 ec 0c             	sub    $0xc,%esp
80108314:	68 34 91 10 80       	push   $0x80109134
80108319:	e8 72 80 ff ff       	call   80100390 <panic>
8010831e:	66 90                	xchg   %ax,%ax

80108320 <movePageToTail>:

void 
movePageToTail(struct procPG *pg){
80108320:	55                   	push   %ebp
80108321:	89 e5                	mov    %esp,%ebp
80108323:	53                   	push   %ebx
80108324:	83 ec 04             	sub    $0x4,%esp
80108327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  
  struct proc *p = myproc();
8010832a:	e8 31 bc ff ff       	call   80103f60 <myproc>

  if(p->headPG==-1){
8010832f:	83 b8 94 00 00 00 ff 	cmpl   $0xffffffff,0x94(%eax)
80108336:	74 49                	je     80108381 <movePageToTail+0x61>
    panic("aaa");
  }
  if(pg->prev){
80108338:	8b 4b 14             	mov    0x14(%ebx),%ecx
8010833b:	8b 53 10             	mov    0x10(%ebx),%edx
8010833e:	85 c9                	test   %ecx,%ecx
80108340:	74 06                	je     80108348 <movePageToTail+0x28>
    pg->prev->next = pg->next;
80108342:	89 51 10             	mov    %edx,0x10(%ecx)
80108345:	8b 53 10             	mov    0x10(%ebx),%edx
  }
  if(pg->next){
80108348:	85 d2                	test   %edx,%edx
8010834a:	74 06                	je     80108352 <movePageToTail+0x32>
    pg->next->prev = pg->prev;
8010834c:	8b 4b 14             	mov    0x14(%ebx),%ecx
8010834f:	89 4a 14             	mov    %ecx,0x14(%edx)
  }

  struct procPG *tempPG = &p->physicalPGs[p->headPG];
80108352:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
80108358:	8d 14 52             	lea    (%edx,%edx,2),%edx
8010835b:	8d 94 d0 d8 01 00 00 	lea    0x1d8(%eax,%edx,8),%edx
  while (tempPG->next && tempPG->next->va !=(char*)0xffffffff)
80108362:	eb 0b                	jmp    8010836f <movePageToTail+0x4f>
80108364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108368:	83 38 ff             	cmpl   $0xffffffff,(%eax)
8010836b:	74 09                	je     80108376 <movePageToTail+0x56>
8010836d:	89 c2                	mov    %eax,%edx
8010836f:	8b 42 10             	mov    0x10(%edx),%eax
80108372:	85 c0                	test   %eax,%eax
80108374:	75 f2                	jne    80108368 <movePageToTail+0x48>
  {
    tempPG = tempPG->next;
  }
  
  tempPG->next = pg;
80108376:	89 5a 10             	mov    %ebx,0x10(%edx)
  pg->prev = tempPG;
80108379:	89 53 14             	mov    %edx,0x14(%ebx)
  

}
8010837c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010837f:	c9                   	leave  
80108380:	c3                   	ret    
    panic("aaa");
80108381:	83 ec 0c             	sub    $0xc,%esp
80108384:	68 34 91 10 80       	push   $0x80109134
80108389:	e8 02 80 ff ff       	call   80100390 <panic>
8010838e:	66 90                	xchg   %ax,%ax

80108390 <freePageFromList>:

void freePageFromList(struct procPG *pg){
80108390:	55                   	push   %ebp
80108391:	89 e5                	mov    %esp,%ebp
80108393:	57                   	push   %edi
80108394:	56                   	push   %esi
80108395:	53                   	push   %ebx
80108396:	83 ec 0c             	sub    $0xc,%esp
80108399:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
8010839c:	e8 bf bb ff ff       	call   80103f60 <myproc>
  if(p->physicalPGs[p->headPG].va == pg->va){
801083a1:	8b 90 94 00 00 00    	mov    0x94(%eax),%edx
801083a7:	8b 3b                	mov    (%ebx),%edi
    int i = 0;
    for(i = 0; i < MAX_PSYC_PAGES ; i++){
      if(p->physicalPGs[i].va == pg->next->va){
801083a9:	8b 73 10             	mov    0x10(%ebx),%esi
  if(p->physicalPGs[p->headPG].va == pg->va){
801083ac:	8d 14 52             	lea    (%edx,%edx,2),%edx
801083af:	39 bc d0 d8 01 00 00 	cmp    %edi,0x1d8(%eax,%edx,8)
801083b6:	74 38                	je     801083f0 <freePageFromList+0x60>
        
        return;
      }
    }
  }
  if(pg->prev){
801083b8:	8b 43 14             	mov    0x14(%ebx),%eax
801083bb:	85 c0                	test   %eax,%eax
801083bd:	74 06                	je     801083c5 <freePageFromList+0x35>
    pg->prev->next = pg->next;
801083bf:	89 70 10             	mov    %esi,0x10(%eax)
801083c2:	8b 73 10             	mov    0x10(%ebx),%esi
  }
  if(pg->next){
801083c5:	85 f6                	test   %esi,%esi
801083c7:	74 06                	je     801083cf <freePageFromList+0x3f>
801083c9:	8b 43 14             	mov    0x14(%ebx),%eax
    pg->next->prev = pg->prev;
801083cc:	89 46 14             	mov    %eax,0x14(%esi)
  }

  pg->va = (char*)0xffffffff;
801083cf:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
  pg->next = 0;
801083d5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  pg->prev = 0;
801083dc:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  
  return;
}
801083e3:	83 c4 0c             	add    $0xc,%esp
801083e6:	5b                   	pop    %ebx
801083e7:	5e                   	pop    %esi
801083e8:	5f                   	pop    %edi
801083e9:	5d                   	pop    %ebp
801083ea:	c3                   	ret    
801083eb:	90                   	nop
801083ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->physicalPGs[i].va == pg->next->va){
801083f0:	8b 3e                	mov    (%esi),%edi
801083f2:	8d 88 d8 01 00 00    	lea    0x1d8(%eax),%ecx
    for(i = 0; i < MAX_PSYC_PAGES ; i++){
801083f8:	31 d2                	xor    %edx,%edx
801083fa:	eb 0f                	jmp    8010840b <freePageFromList+0x7b>
801083fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80108400:	83 c2 01             	add    $0x1,%edx
80108403:	83 c1 18             	add    $0x18,%ecx
80108406:	83 fa 10             	cmp    $0x10,%edx
80108409:	74 35                	je     80108440 <freePageFromList+0xb0>
      if(p->physicalPGs[i].va == pg->next->va){
8010840b:	39 39                	cmp    %edi,(%ecx)
8010840d:	75 f1                	jne    80108400 <freePageFromList+0x70>
        pg->va = (char*)0xffffffff;
8010840f:	c7 03 ff ff ff ff    	movl   $0xffffffff,(%ebx)
        pg->next = 0;
80108415:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        pg->prev = 0;
8010841c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->headPG = i;
80108423:	89 90 94 00 00 00    	mov    %edx,0x94(%eax)
        p->physicalPGs[i].prev = 0;
80108429:	8d 14 52             	lea    (%edx,%edx,2),%edx
8010842c:	c7 84 d0 ec 01 00 00 	movl   $0x0,0x1ec(%eax,%edx,8)
80108433:	00 00 00 00 
}
80108437:	83 c4 0c             	add    $0xc,%esp
8010843a:	5b                   	pop    %ebx
8010843b:	5e                   	pop    %esi
8010843c:	5f                   	pop    %edi
8010843d:	5d                   	pop    %ebp
8010843e:	c3                   	ret    
8010843f:	90                   	nop
  if(pg->prev){
80108440:	8b 43 14             	mov    0x14(%ebx),%eax
80108443:	85 c0                	test   %eax,%eax
80108445:	0f 85 74 ff ff ff    	jne    801083bf <freePageFromList+0x2f>
8010844b:	e9 7c ff ff ff       	jmp    801083cc <freePageFromList+0x3c>
