
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
80100044:	bb f4 c5 10 80       	mov    $0x8010c5f4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 80 10 80       	push   $0x80108040
80100051:	68 c0 c5 10 80       	push   $0x8010c5c0
80100056:	e8 c5 4a 00 00       	call   80104b20 <initlock>
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
80100092:	68 47 80 10 80       	push   $0x80108047
80100097:	50                   	push   %eax
80100098:	e8 53 49 00 00       	call   801049f0 <initsleeplock>
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
801000e4:	e8 77 4b 00 00       	call   80104c60 <acquire>
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
80100162:	e8 b9 4b 00 00       	call   80104d20 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 48 00 00       	call   80104a30 <acquiresleep>
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
80100193:	68 4e 80 10 80       	push   $0x8010804e
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
801001ae:	e8 1d 49 00 00       	call   80104ad0 <holdingsleep>
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
801001cc:	68 5f 80 10 80       	push   $0x8010805f
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
801001ef:	e8 dc 48 00 00       	call   80104ad0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 8c 48 00 00       	call   80104a90 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 c0 c5 10 80 	movl   $0x8010c5c0,(%esp)
8010020b:	e8 50 4a 00 00       	call   80104c60 <acquire>
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
8010025c:	e9 bf 4a 00 00       	jmp    80104d20 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 66 80 10 80       	push   $0x80108066
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
8010028c:	e8 cf 49 00 00       	call   80104c60 <acquire>
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
801002c5:	e8 b6 42 00 00       	call   80104580 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 a0 0f 11 80    	mov    0x80110fa0,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 a4 0f 11 80    	cmp    0x80110fa4,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 b0 3b 00 00       	call   80103e90 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 20 b5 10 80       	push   $0x8010b520
801002ef:	e8 2c 4a 00 00       	call   80104d20 <release>
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
8010034d:	e8 ce 49 00 00       	call   80104d20 <release>
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
801003a9:	e8 92 29 00 00       	call   80102d40 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 6d 80 10 80       	push   $0x8010806d
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 32 8c 10 80 	movl   $0x80108c32,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 63 47 00 00       	call   80104b40 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 81 80 10 80       	push   $0x80108081
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
8010043a:	e8 31 61 00 00       	call   80106570 <uartputc>
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
801004ec:	e8 7f 60 00 00       	call   80106570 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 73 60 00 00       	call   80106570 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 67 60 00 00       	call   80106570 <uartputc>
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
80100524:	e8 f7 48 00 00       	call   80104e20 <memmove>
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
80100541:	e8 2a 48 00 00       	call   80104d70 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 85 80 10 80       	push   $0x80108085
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
801005b1:	0f b6 92 b0 80 10 80 	movzbl -0x7fef7f50(%edx),%edx
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
8010061b:	e8 40 46 00 00       	call   80104c60 <acquire>
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
80100647:	e8 d4 46 00 00       	call   80104d20 <release>
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
8010071f:	e8 fc 45 00 00       	call   80104d20 <release>
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
801007d0:	ba 98 80 10 80       	mov    $0x80108098,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 20 b5 10 80       	push   $0x8010b520
801007f0:	e8 6b 44 00 00       	call   80104c60 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 9f 80 10 80       	push   $0x8010809f
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
80100823:	e8 38 44 00 00       	call   80104c60 <acquire>
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
80100888:	e8 93 44 00 00       	call   80104d20 <release>
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
80100997:	e9 84 3e 00 00       	jmp    80104820 <procdump>
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
801009c6:	68 a8 80 10 80       	push   $0x801080a8
801009cb:	68 20 b5 10 80       	push   $0x8010b520
801009d0:	e8 4b 41 00 00       	call   80104b20 <initlock>

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
80100a8c:	e8 df 6b 00 00       	call   80107670 <setupkvm>
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
80100b4e:	e8 ed 72 00 00       	call   80107e40 <allocuvm>
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
80100b80:	e8 fb 67 00 00       	call   80107380 <loaduvm>
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
80100bca:	e8 21 6a 00 00       	call   801075f0 <freevm>
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
80100c14:	e8 27 72 00 00       	call   80107e40 <allocuvm>
80100c19:	83 c4 10             	add    $0x10,%esp
80100c1c:	85 c0                	test   %eax,%eax
80100c1e:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c24:	75 3a                	jne    80100c60 <exec+0x250>
    freevm(pgdir);
80100c26:	83 ec 0c             	sub    $0xc,%esp
80100c29:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c2f:	e8 bc 69 00 00       	call   801075f0 <freevm>
80100c34:	83 c4 10             	add    $0x10,%esp
  return -1;
80100c37:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c3c:	e9 37 fe ff ff       	jmp    80100a78 <exec+0x68>
    end_op();
80100c41:	e8 da 25 00 00       	call   80103220 <end_op>
    cprintf("exec: fail\n");
80100c46:	83 ec 0c             	sub    $0xc,%esp
80100c49:	68 c1 80 10 80       	push   $0x801080c1
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
80100c74:	e8 97 6a 00 00       	call   80107710 <clearpteu>
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
80100ca9:	e8 e2 42 00 00       	call   80104f90 <strlen>
80100cae:	f7 d0                	not    %eax
80100cb0:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb2:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cb5:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cb6:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cb9:	ff 34 b8             	pushl  (%eax,%edi,4)
80100cbc:	e8 cf 42 00 00       	call   80104f90 <strlen>
80100cc1:	83 c0 01             	add    $0x1,%eax
80100cc4:	50                   	push   %eax
80100cc5:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cc8:	ff 34 b8             	pushl  (%eax,%edi,4)
80100ccb:	53                   	push   %ebx
80100ccc:	56                   	push   %esi
80100ccd:	e8 de 6b 00 00       	call   801078b0 <copyout>
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
80100d39:	e8 72 6b 00 00       	call   801078b0 <copyout>
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
80100d74:	e8 d7 41 00 00       	call   80104f50 <safestrcpy>
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
80100da2:	e8 49 64 00 00       	call   801071f0 <switchuvm>
  freevm(oldpgdir);
80100da7:	89 34 24             	mov    %esi,(%esp)
80100daa:	e8 41 68 00 00       	call   801075f0 <freevm>
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
80100de6:	68 cd 80 10 80       	push   $0x801080cd
80100deb:	68 c0 0f 11 80       	push   $0x80110fc0
80100df0:	e8 2b 3d 00 00       	call   80104b20 <initlock>
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
80100e11:	e8 4a 3e 00 00       	call   80104c60 <acquire>
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
80100e41:	e8 da 3e 00 00       	call   80104d20 <release>
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
80100e5a:	e8 c1 3e 00 00       	call   80104d20 <release>
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
80100e7f:	e8 dc 3d 00 00       	call   80104c60 <acquire>
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
80100e9c:	e8 7f 3e 00 00       	call   80104d20 <release>
  return f;
}
80100ea1:	89 d8                	mov    %ebx,%eax
80100ea3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ea6:	c9                   	leave  
80100ea7:	c3                   	ret    
    panic("filedup");
80100ea8:	83 ec 0c             	sub    $0xc,%esp
80100eab:	68 d4 80 10 80       	push   $0x801080d4
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
80100ed1:	e8 8a 3d 00 00       	call   80104c60 <acquire>
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
80100efc:	e9 1f 3e 00 00       	jmp    80104d20 <release>
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
80100f28:	e8 f3 3d 00 00       	call   80104d20 <release>
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
80100f82:	68 dc 80 10 80       	push   $0x801080dc
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
80101062:	68 e6 80 10 80       	push   $0x801080e6
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
80101175:	68 ef 80 10 80       	push   $0x801080ef
8010117a:	e8 11 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 f5 80 10 80       	push   $0x801080f5
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
801011f3:	68 ff 80 10 80       	push   $0x801080ff
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
801012a4:	68 12 81 10 80       	push   $0x80108112
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
801012e5:	e8 86 3a 00 00       	call   80104d70 <memset>
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
8010131a:	bb 14 1a 11 80       	mov    $0x80111a14,%ebx
{
8010131f:	83 ec 28             	sub    $0x28,%esp
80101322:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101325:	68 e0 19 11 80       	push   $0x801119e0
8010132a:	e8 31 39 00 00       	call   80104c60 <acquire>
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
8010138f:	e8 8c 39 00 00       	call   80104d20 <release>

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
801013bd:	e8 5e 39 00 00       	call   80104d20 <release>
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
801013d2:	68 28 81 10 80       	push   $0x80108128
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
801014a7:	68 38 81 10 80       	push   $0x80108138
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
801014e1:	e8 3a 39 00 00       	call   80104e20 <memmove>
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
8010150c:	68 4b 81 10 80       	push   $0x8010814b
80101511:	68 e0 19 11 80       	push   $0x801119e0
80101516:	e8 05 36 00 00       	call   80104b20 <initlock>
8010151b:	83 c4 10             	add    $0x10,%esp
8010151e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101520:	83 ec 08             	sub    $0x8,%esp
80101523:	68 52 81 10 80       	push   $0x80108152
80101528:	53                   	push   %ebx
80101529:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010152f:	e8 bc 34 00 00       	call   801049f0 <initsleeplock>
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
80101579:	68 fc 81 10 80       	push   $0x801081fc
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
8010160e:	e8 5d 37 00 00       	call   80104d70 <memset>
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
80101643:	68 58 81 10 80       	push   $0x80108158
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
801016b1:	e8 6a 37 00 00       	call   80104e20 <memmove>
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
801016da:	68 e0 19 11 80       	push   $0x801119e0
801016df:	e8 7c 35 00 00       	call   80104c60 <acquire>
  ip->ref++;
801016e4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016e8:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
801016ef:	e8 2c 36 00 00       	call   80104d20 <release>
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
80101722:	e8 09 33 00 00       	call   80104a30 <acquiresleep>
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
80101798:	e8 83 36 00 00       	call   80104e20 <memmove>
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
801017bd:	68 70 81 10 80       	push   $0x80108170
801017c2:	e8 c9 eb ff ff       	call   80100390 <panic>
    panic("ilock");
801017c7:	83 ec 0c             	sub    $0xc,%esp
801017ca:	68 6a 81 10 80       	push   $0x8010816a
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
801017f3:	e8 d8 32 00 00       	call   80104ad0 <holdingsleep>
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
8010180f:	e9 7c 32 00 00       	jmp    80104a90 <releasesleep>
    panic("iunlock");
80101814:	83 ec 0c             	sub    $0xc,%esp
80101817:	68 7f 81 10 80       	push   $0x8010817f
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
80101840:	e8 eb 31 00 00       	call   80104a30 <acquiresleep>
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
8010185a:	e8 31 32 00 00       	call   80104a90 <releasesleep>
  acquire(&icache.lock);
8010185f:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101866:	e8 f5 33 00 00       	call   80104c60 <acquire>
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
80101880:	e9 9b 34 00 00       	jmp    80104d20 <release>
80101885:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101888:	83 ec 0c             	sub    $0xc,%esp
8010188b:	68 e0 19 11 80       	push   $0x801119e0
80101890:	e8 cb 33 00 00       	call   80104c60 <acquire>
    int r = ip->ref;
80101895:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101898:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
8010189f:	e8 7c 34 00 00       	call   80104d20 <release>
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
80101a87:	e8 94 33 00 00       	call   80104e20 <memmove>
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
80101b83:	e8 98 32 00 00       	call   80104e20 <memmove>
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
80101c1e:	e8 6d 32 00 00       	call   80104e90 <strncmp>
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
80101c7d:	e8 0e 32 00 00       	call   80104e90 <strncmp>
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
80101cc2:	68 99 81 10 80       	push   $0x80108199
80101cc7:	e8 c4 e6 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101ccc:	83 ec 0c             	sub    $0xc,%esp
80101ccf:	68 87 81 10 80       	push   $0x80108187
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
80101d04:	68 e0 19 11 80       	push   $0x801119e0
80101d09:	e8 52 2f 00 00       	call   80104c60 <acquire>
  ip->ref++;
80101d0e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101d12:	c7 04 24 e0 19 11 80 	movl   $0x801119e0,(%esp)
80101d19:	e8 02 30 00 00       	call   80104d20 <release>
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
80101d75:	e8 a6 30 00 00       	call   80104e20 <memmove>
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
80101e08:	e8 13 30 00 00       	call   80104e20 <memmove>
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
80101efd:	e8 ee 2f 00 00       	call   80104ef0 <strncpy>
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
80101f3b:	68 a8 81 10 80       	push   $0x801081a8
80101f40:	e8 4b e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101f45:	83 ec 0c             	sub    $0xc,%esp
80101f48:	68 91 88 10 80       	push   $0x80108891
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
80102041:	68 b5 81 10 80       	push   $0x801081b5
80102046:	56                   	push   %esi
80102047:	e8 d4 2d 00 00       	call   80104e20 <memmove>
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
801020a2:	68 bd 81 10 80       	push   $0x801081bd
801020a7:	53                   	push   %ebx
801020a8:	e8 e3 2d 00 00       	call   80104e90 <strncmp>

    // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801020ad:	83 c4 10             	add    $0x10,%esp
801020b0:	85 c0                	test   %eax,%eax
801020b2:	0f 84 f8 00 00 00    	je     801021b0 <removeSwapFile+0x180>
  return strncmp(s, t, DIRSIZ);
801020b8:	83 ec 04             	sub    $0x4,%esp
801020bb:	6a 0e                	push   $0xe
801020bd:	68 bc 81 10 80       	push   $0x801081bc
801020c2:	53                   	push   %ebx
801020c3:	e8 c8 2d 00 00       	call   80104e90 <strncmp>
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
80102117:	e8 54 2c 00 00       	call   80104d70 <memset>
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
80102184:	e8 c7 33 00 00       	call   80105550 <isdirempty>
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
8010220c:	68 d1 81 10 80       	push   $0x801081d1
80102211:	e8 7a e1 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80102216:	83 ec 0c             	sub    $0xc,%esp
80102219:	68 bf 81 10 80       	push   $0x801081bf
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
80102240:	68 b5 81 10 80       	push   $0x801081b5
80102245:	56                   	push   %esi
80102246:	e8 d5 2b 00 00       	call   80104e20 <memmove>
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
80102265:	e8 f6 34 00 00       	call   80105760 <create>
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
801022b9:	68 e0 81 10 80       	push   $0x801081e0
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
801023eb:	68 58 82 10 80       	push   $0x80108258
801023f0:	e8 9b df ff ff       	call   80100390 <panic>
    panic("idestart");
801023f5:	83 ec 0c             	sub    $0xc,%esp
801023f8:	68 4f 82 10 80       	push   $0x8010824f
801023fd:	e8 8e df ff ff       	call   80100390 <panic>
80102402:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <ideinit>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102416:	68 6a 82 10 80       	push   $0x8010826a
8010241b:	68 80 b5 10 80       	push   $0x8010b580
80102420:	e8 fb 26 00 00       	call   80104b20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102425:	58                   	pop    %eax
80102426:	a1 20 bd 14 80       	mov    0x8014bd20,%eax
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
8010249e:	e8 bd 27 00 00       	call   80104c60 <acquire>

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
80102501:	e8 3a 22 00 00       	call   80104740 <wakeup>

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
8010251f:	e8 fc 27 00 00       	call   80104d20 <release>

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
8010253e:	e8 8d 25 00 00       	call   80104ad0 <holdingsleep>
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
80102578:	e8 e3 26 00 00       	call   80104c60 <acquire>

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
801025c9:	e8 b2 1f 00 00       	call   80104580 <sleep>
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
801025e6:	e9 35 27 00 00       	jmp    80104d20 <release>
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
8010260a:	68 84 82 10 80       	push   $0x80108284
8010260f:	e8 7c dd ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102614:	83 ec 0c             	sub    $0xc,%esp
80102617:	68 6e 82 10 80       	push   $0x8010826e
8010261c:	e8 6f dd ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102621:	83 ec 0c             	sub    $0xc,%esp
80102624:	68 99 82 10 80       	push   $0x80108299
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
8010265d:	0f b6 15 80 b7 14 80 	movzbl 0x8014b780,%edx
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
80102677:	68 b8 82 10 80       	push   $0x801082b8
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
80102723:	56                   	push   %esi
80102724:	53                   	push   %ebx
80102725:	8b 75 08             	mov    0x8(%ebp),%esi
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102728:	f7 c6 ff 0f 00 00    	test   $0xfff,%esi
8010272e:	0f 85 b9 00 00 00    	jne    801027ed <kfree+0xcd>
80102734:	81 fe c8 79 15 80    	cmp    $0x801579c8,%esi
8010273a:	0f 82 ad 00 00 00    	jb     801027ed <kfree+0xcd>
80102740:	8d 9e 00 00 00 80    	lea    -0x80000000(%esi),%ebx
80102746:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
8010274c:	0f 87 9b 00 00 00    	ja     801027ed <kfree+0xcd>
    panic("kfree");

  if(kmem.use_lock)
80102752:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102758:	85 d2                	test   %edx,%edx
8010275a:	75 7c                	jne    801027d8 <kfree+0xb8>
    acquire(&kmem.lock);
  r = (struct run*)v;

  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] > 0){
8010275c:	c1 eb 0c             	shr    $0xc,%ebx
8010275f:	83 c3 10             	add    $0x10,%ebx
80102762:	8b 04 9d 40 36 11 80 	mov    -0x7feec9c0(,%ebx,4),%eax
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
80102778:	e8 f3 25 00 00       	call   80104d70 <memset>
    kmem.free_pages++;
    r->next = kmem.freelist;
8010277d:	a1 78 36 11 80       	mov    0x80113678,%eax
    kmem.free_pages++;
80102782:	83 05 7c 36 11 80 01 	addl   $0x1,0x8011367c
    kmem.freelist = r;
80102789:	83 c4 10             	add    $0x10,%esp
    r->next = kmem.freelist;
8010278c:	89 06                	mov    %eax,(%esi)
  }

  if(kmem.use_lock)
8010278e:	a1 74 36 11 80       	mov    0x80113674,%eax
    kmem.freelist = r;
80102793:	89 35 78 36 11 80    	mov    %esi,0x80113678
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
801027ad:	89 04 9d 40 36 11 80 	mov    %eax,-0x7feec9c0(,%ebx,4)
  if(kmem.pg_refcount[V2P(v) >> PGSHIFT] == 0){
801027b4:	74 b7                	je     8010276d <kfree+0x4d>
  if(kmem.use_lock)
801027b6:	a1 74 36 11 80       	mov    0x80113674,%eax
801027bb:	85 c0                	test   %eax,%eax
801027bd:	74 de                	je     8010279d <kfree+0x7d>
    release(&kmem.lock);
801027bf:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
801027c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027c9:	5b                   	pop    %ebx
801027ca:	5e                   	pop    %esi
801027cb:	5d                   	pop    %ebp
    release(&kmem.lock);
801027cc:	e9 4f 25 00 00       	jmp    80104d20 <release>
801027d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
801027d8:	83 ec 0c             	sub    $0xc,%esp
801027db:	68 40 36 11 80       	push   $0x80113640
801027e0:	e8 7b 24 00 00       	call   80104c60 <acquire>
801027e5:	83 c4 10             	add    $0x10,%esp
801027e8:	e9 6f ff ff ff       	jmp    8010275c <kfree+0x3c>
    panic("kfree");
801027ed:	83 ec 0c             	sub    $0xc,%esp
801027f0:	68 ea 82 10 80       	push   $0x801082ea
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
80102834:	c7 04 85 80 36 11 80 	movl   $0x0,-0x7feec980(,%eax,4)
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
8010286b:	68 f0 82 10 80       	push   $0x801082f0
80102870:	68 40 36 11 80       	push   $0x80113640
80102875:	e8 a6 22 00 00       	call   80104b20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010287a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE){
8010287d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102880:	c7 05 74 36 11 80 00 	movl   $0x0,0x80113674
80102887:	00 00 00 
  kmem.free_pages = 0;
8010288a:	c7 05 7c 36 11 80 00 	movl   $0x0,0x8011367c
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
801028bc:	c7 04 85 80 36 11 80 	movl   $0x0,-0x7feec980(,%eax,4)
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
80102924:	c7 04 85 80 36 11 80 	movl   $0x0,-0x7feec980(,%eax,4)
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
80102948:	c7 05 74 36 11 80 01 	movl   $0x1,0x80113674
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
80102966:	8b 15 74 36 11 80    	mov    0x80113674,%edx
8010296c:	85 d2                	test   %edx,%edx
8010296e:	75 50                	jne    801029c0 <kalloc+0x60>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102970:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r){
80102975:	85 c0                	test   %eax,%eax
80102977:	74 27                	je     801029a0 <kalloc+0x40>
    kmem.freelist = r->next;
80102979:	8b 08                	mov    (%eax),%ecx
    kmem.free_pages--;
8010297b:	83 2d 7c 36 11 80 01 	subl   $0x1,0x8011367c
    kmem.freelist = r->next;
80102982:	89 0d 78 36 11 80    	mov    %ecx,0x80113678
    kmem.pg_refcount[V2P((char*)r) >> PGSHIFT] = 1;
80102988:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010298e:	c1 e9 0c             	shr    $0xc,%ecx
80102991:	c7 04 8d 80 36 11 80 	movl   $0x1,-0x7feec980(,%ecx,4)
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
801029ae:	68 40 36 11 80       	push   $0x80113640
801029b3:	e8 68 23 00 00       	call   80104d20 <release>
  return (char*)r;
801029b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801029bb:	83 c4 10             	add    $0x10,%esp
}
801029be:	c9                   	leave  
801029bf:	c3                   	ret    
    acquire(&kmem.lock);
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	68 40 36 11 80       	push   $0x80113640
801029c8:	e8 93 22 00 00       	call   80104c60 <acquire>
  r = kmem.freelist;
801029cd:	a1 78 36 11 80       	mov    0x80113678,%eax
  if(r){
801029d2:	83 c4 10             	add    $0x10,%esp
801029d5:	8b 15 74 36 11 80    	mov    0x80113674,%edx
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
801029f7:	68 40 36 11 80       	push   $0x80113640
801029fc:	e8 5f 22 00 00       	call   80104c60 <acquire>
  uint free_pages = kmem.free_pages;
80102a01:	8b 1d 7c 36 11 80    	mov    0x8011367c,%ebx
  release(&kmem.lock);
80102a07:	c7 04 24 40 36 11 80 	movl   $0x80113640,(%esp)
80102a0e:	e8 0d 23 00 00       	call   80104d20 <release>
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
80102a2a:	c7 04 85 80 36 11 80 	movl   $0x1,-0x7feec980(,%eax,4)
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
80102a58:	68 40 36 11 80       	push   $0x80113640
80102a5d:	e8 fe 21 00 00       	call   80104c60 <acquire>
  --kmem.pg_refcount[pa >> PGSHIFT];
80102a62:	83 2c 9d 80 36 11 80 	subl   $0x1,-0x7feec980(,%ebx,4)
80102a69:	01 
  release(&kmem.lock);
80102a6a:	83 c4 10             	add    $0x10,%esp
80102a6d:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)

}
80102a74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a77:	c9                   	leave  
  release(&kmem.lock);
80102a78:	e9 a3 22 00 00       	jmp    80104d20 <release>
    panic("decrementReferenceCount");
80102a7d:	83 ec 0c             	sub    $0xc,%esp
80102a80:	68 f5 82 10 80       	push   $0x801082f5
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
80102a9a:	81 fb c8 79 15 00    	cmp    $0x1579c8,%ebx
80102aa0:	72 33                	jb     80102ad5 <incrementReferenceCount+0x45>
80102aa2:	81 fb ff ff ff 0d    	cmp    $0xdffffff,%ebx
80102aa8:	77 2b                	ja     80102ad5 <incrementReferenceCount+0x45>
    panic("incrementReferenceCount");

  acquire(&kmem.lock);
80102aaa:	83 ec 0c             	sub    $0xc,%esp
  ++kmem.pg_refcount[pa >> PGSHIFT];
80102aad:	c1 eb 0c             	shr    $0xc,%ebx
  acquire(&kmem.lock);
80102ab0:	68 40 36 11 80       	push   $0x80113640
80102ab5:	e8 a6 21 00 00       	call   80104c60 <acquire>
  ++kmem.pg_refcount[pa >> PGSHIFT];
80102aba:	83 04 9d 80 36 11 80 	addl   $0x1,-0x7feec980(,%ebx,4)
80102ac1:	01 
  release(&kmem.lock);
80102ac2:	83 c4 10             	add    $0x10,%esp
80102ac5:	c7 45 08 40 36 11 80 	movl   $0x80113640,0x8(%ebp)
}
80102acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102acf:	c9                   	leave  
  release(&kmem.lock);
80102ad0:	e9 4b 22 00 00       	jmp    80104d20 <release>
    panic("incrementReferenceCount");
80102ad5:	83 ec 0c             	sub    $0xc,%esp
80102ad8:	68 0d 83 10 80       	push   $0x8010830d
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
80102b08:	68 40 36 11 80       	push   $0x80113640
80102b0d:	e8 4e 21 00 00       	call   80104c60 <acquire>
  count = kmem.pg_refcount[pa >> PGSHIFT];
80102b12:	8b 1c 9d 80 36 11 80 	mov    -0x7feec980(,%ebx,4),%ebx
  release(&kmem.lock);
80102b19:	c7 04 24 40 36 11 80 	movl   $0x80113640,(%esp)
80102b20:	e8 fb 21 00 00       	call   80104d20 <release>

  return count;
}
80102b25:	89 d8                	mov    %ebx,%eax
80102b27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b2a:	c9                   	leave  
80102b2b:	c3                   	ret    
    panic("getReferenceCount");
80102b2c:	83 ec 0c             	sub    $0xc,%esp
80102b2f:	68 25 83 10 80       	push   $0x80108325
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
80102b57:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx

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
80102b83:	0f b6 82 60 84 10 80 	movzbl -0x7fef7ba0(%edx),%eax
80102b8a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
80102b8c:	0f b6 82 60 83 10 80 	movzbl -0x7fef7ca0(%edx),%eax
80102b93:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102b95:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102b97:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
80102b9d:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102ba0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102ba3:	8b 04 85 40 83 10 80 	mov    -0x7fef7cc0(,%eax,4),%eax
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
80102bc8:	0f b6 82 60 84 10 80 	movzbl -0x7fef7ba0(%edx),%eax
80102bcf:	83 c8 40             	or     $0x40,%eax
80102bd2:	0f b6 c0             	movzbl %al,%eax
80102bd5:	f7 d0                	not    %eax
80102bd7:	21 c1                	and    %eax,%ecx
    return 0;
80102bd9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102bdb:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
80102bed:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
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
80102c40:	a1 80 b6 14 80       	mov    0x8014b680,%eax
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
80102d40:	8b 15 80 b6 14 80    	mov    0x8014b680,%edx
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
80102d60:	a1 80 b6 14 80       	mov    0x8014b680,%eax
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
80102dce:	a1 80 b6 14 80       	mov    0x8014b680,%eax
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
80102f47:	e8 74 1e 00 00       	call   80104dc0 <memcmp>
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
80103010:	8b 0d e8 b6 14 80    	mov    0x8014b6e8,%ecx
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
80103030:	a1 d4 b6 14 80       	mov    0x8014b6d4,%eax
80103035:	83 ec 08             	sub    $0x8,%esp
80103038:	01 d8                	add    %ebx,%eax
8010303a:	83 c0 01             	add    $0x1,%eax
8010303d:	50                   	push   %eax
8010303e:	ff 35 e4 b6 14 80    	pushl  0x8014b6e4
80103044:	e8 87 d0 ff ff       	call   801000d0 <bread>
80103049:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010304b:	58                   	pop    %eax
8010304c:	5a                   	pop    %edx
8010304d:	ff 34 9d ec b6 14 80 	pushl  -0x7feb4914(,%ebx,4)
80103054:	ff 35 e4 b6 14 80    	pushl  0x8014b6e4
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
80103074:	e8 a7 1d 00 00       	call   80104e20 <memmove>
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
80103094:	39 1d e8 b6 14 80    	cmp    %ebx,0x8014b6e8
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
801030b8:	ff 35 d4 b6 14 80    	pushl  0x8014b6d4
801030be:	ff 35 e4 b6 14 80    	pushl  0x8014b6e4
801030c4:	e8 07 d0 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
801030c9:	8b 1d e8 b6 14 80    	mov    0x8014b6e8,%ebx
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
801030e0:	8b 8a ec b6 14 80    	mov    -0x7feb4914(%edx),%ecx
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
8010311a:	68 60 85 10 80       	push   $0x80108560
8010311f:	68 a0 b6 14 80       	push   $0x8014b6a0
80103124:	e8 f7 19 00 00       	call   80104b20 <initlock>
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
8010313c:	89 1d e4 b6 14 80    	mov    %ebx,0x8014b6e4
  log.size = sb.nlog;
80103142:	89 15 d8 b6 14 80    	mov    %edx,0x8014b6d8
  log.start = sb.logstart;
80103148:	a3 d4 b6 14 80       	mov    %eax,0x8014b6d4
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
8010315d:	89 1d e8 b6 14 80    	mov    %ebx,0x8014b6e8
  for (i = 0; i < log.lh.n; i++) {
80103163:	7e 1c                	jle    80103181 <initlog+0x71>
80103165:	c1 e3 02             	shl    $0x2,%ebx
80103168:	31 d2                	xor    %edx,%edx
8010316a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80103170:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103174:	83 c2 04             	add    $0x4,%edx
80103177:	89 8a e8 b6 14 80    	mov    %ecx,-0x7feb4918(%edx)
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
8010318f:	c7 05 e8 b6 14 80 00 	movl   $0x0,0x8014b6e8
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
801031b6:	68 a0 b6 14 80       	push   $0x8014b6a0
801031bb:	e8 a0 1a 00 00       	call   80104c60 <acquire>
801031c0:	83 c4 10             	add    $0x10,%esp
801031c3:	eb 18                	jmp    801031dd <begin_op+0x2d>
801031c5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801031c8:	83 ec 08             	sub    $0x8,%esp
801031cb:	68 a0 b6 14 80       	push   $0x8014b6a0
801031d0:	68 a0 b6 14 80       	push   $0x8014b6a0
801031d5:	e8 a6 13 00 00       	call   80104580 <sleep>
801031da:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801031dd:	a1 e0 b6 14 80       	mov    0x8014b6e0,%eax
801031e2:	85 c0                	test   %eax,%eax
801031e4:	75 e2                	jne    801031c8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801031e6:	a1 dc b6 14 80       	mov    0x8014b6dc,%eax
801031eb:	8b 15 e8 b6 14 80    	mov    0x8014b6e8,%edx
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
80103202:	a3 dc b6 14 80       	mov    %eax,0x8014b6dc
      release(&log.lock);
80103207:	68 a0 b6 14 80       	push   $0x8014b6a0
8010320c:	e8 0f 1b 00 00       	call   80104d20 <release>
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
80103229:	68 a0 b6 14 80       	push   $0x8014b6a0
8010322e:	e8 2d 1a 00 00       	call   80104c60 <acquire>
  log.outstanding -= 1;
80103233:	a1 dc b6 14 80       	mov    0x8014b6dc,%eax
  if(log.committing)
80103238:	8b 35 e0 b6 14 80    	mov    0x8014b6e0,%esi
8010323e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103241:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80103244:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80103246:	89 1d dc b6 14 80    	mov    %ebx,0x8014b6dc
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
8010325d:	c7 05 e0 b6 14 80 01 	movl   $0x1,0x8014b6e0
80103264:	00 00 00 
  release(&log.lock);
80103267:	68 a0 b6 14 80       	push   $0x8014b6a0
8010326c:	e8 af 1a 00 00       	call   80104d20 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103271:	8b 0d e8 b6 14 80    	mov    0x8014b6e8,%ecx
80103277:	83 c4 10             	add    $0x10,%esp
8010327a:	85 c9                	test   %ecx,%ecx
8010327c:	0f 8e 85 00 00 00    	jle    80103307 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103282:	a1 d4 b6 14 80       	mov    0x8014b6d4,%eax
80103287:	83 ec 08             	sub    $0x8,%esp
8010328a:	01 d8                	add    %ebx,%eax
8010328c:	83 c0 01             	add    $0x1,%eax
8010328f:	50                   	push   %eax
80103290:	ff 35 e4 b6 14 80    	pushl  0x8014b6e4
80103296:	e8 35 ce ff ff       	call   801000d0 <bread>
8010329b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010329d:	58                   	pop    %eax
8010329e:	5a                   	pop    %edx
8010329f:	ff 34 9d ec b6 14 80 	pushl  -0x7feb4914(,%ebx,4)
801032a6:	ff 35 e4 b6 14 80    	pushl  0x8014b6e4
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
801032c6:	e8 55 1b 00 00       	call   80104e20 <memmove>
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
801032e6:	3b 1d e8 b6 14 80    	cmp    0x8014b6e8,%ebx
801032ec:	7c 94                	jl     80103282 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801032ee:	e8 bd fd ff ff       	call   801030b0 <write_head>
    install_trans(); // Now install writes to home locations
801032f3:	e8 18 fd ff ff       	call   80103010 <install_trans>
    log.lh.n = 0;
801032f8:	c7 05 e8 b6 14 80 00 	movl   $0x0,0x8014b6e8
801032ff:	00 00 00 
    write_head();    // Erase the transaction from the log
80103302:	e8 a9 fd ff ff       	call   801030b0 <write_head>
    acquire(&log.lock);
80103307:	83 ec 0c             	sub    $0xc,%esp
8010330a:	68 a0 b6 14 80       	push   $0x8014b6a0
8010330f:	e8 4c 19 00 00       	call   80104c60 <acquire>
    wakeup(&log);
80103314:	c7 04 24 a0 b6 14 80 	movl   $0x8014b6a0,(%esp)
    log.committing = 0;
8010331b:	c7 05 e0 b6 14 80 00 	movl   $0x0,0x8014b6e0
80103322:	00 00 00 
    wakeup(&log);
80103325:	e8 16 14 00 00       	call   80104740 <wakeup>
    release(&log.lock);
8010332a:	c7 04 24 a0 b6 14 80 	movl   $0x8014b6a0,(%esp)
80103331:	e8 ea 19 00 00       	call   80104d20 <release>
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
8010334b:	68 a0 b6 14 80       	push   $0x8014b6a0
80103350:	e8 eb 13 00 00       	call   80104740 <wakeup>
  release(&log.lock);
80103355:	c7 04 24 a0 b6 14 80 	movl   $0x8014b6a0,(%esp)
8010335c:	e8 bf 19 00 00       	call   80104d20 <release>
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
8010336f:	68 64 85 10 80       	push   $0x80108564
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
80103387:	8b 15 e8 b6 14 80    	mov    0x8014b6e8,%edx
{
8010338d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103390:	83 fa 1d             	cmp    $0x1d,%edx
80103393:	0f 8f 9d 00 00 00    	jg     80103436 <log_write+0xb6>
80103399:	a1 d8 b6 14 80       	mov    0x8014b6d8,%eax
8010339e:	83 e8 01             	sub    $0x1,%eax
801033a1:	39 c2                	cmp    %eax,%edx
801033a3:	0f 8d 8d 00 00 00    	jge    80103436 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
801033a9:	a1 dc b6 14 80       	mov    0x8014b6dc,%eax
801033ae:	85 c0                	test   %eax,%eax
801033b0:	0f 8e 8d 00 00 00    	jle    80103443 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
801033b6:	83 ec 0c             	sub    $0xc,%esp
801033b9:	68 a0 b6 14 80       	push   $0x8014b6a0
801033be:	e8 9d 18 00 00       	call   80104c60 <acquire>
  for (i = 0; i < log.lh.n; i++) {
801033c3:	8b 0d e8 b6 14 80    	mov    0x8014b6e8,%ecx
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	83 f9 00             	cmp    $0x0,%ecx
801033cf:	7e 57                	jle    80103428 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801033d1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
801033d4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801033d6:	3b 15 ec b6 14 80    	cmp    0x8014b6ec,%edx
801033dc:	75 0b                	jne    801033e9 <log_write+0x69>
801033de:	eb 38                	jmp    80103418 <log_write+0x98>
801033e0:	39 14 85 ec b6 14 80 	cmp    %edx,-0x7feb4914(,%eax,4)
801033e7:	74 2f                	je     80103418 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
801033e9:	83 c0 01             	add    $0x1,%eax
801033ec:	39 c1                	cmp    %eax,%ecx
801033ee:	75 f0                	jne    801033e0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
801033f0:	89 14 85 ec b6 14 80 	mov    %edx,-0x7feb4914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
801033f7:	83 c0 01             	add    $0x1,%eax
801033fa:	a3 e8 b6 14 80       	mov    %eax,0x8014b6e8
  b->flags |= B_DIRTY; // prevent eviction
801033ff:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103402:	c7 45 08 a0 b6 14 80 	movl   $0x8014b6a0,0x8(%ebp)
}
80103409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010340c:	c9                   	leave  
  release(&log.lock);
8010340d:	e9 0e 19 00 00       	jmp    80104d20 <release>
80103412:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103418:	89 14 85 ec b6 14 80 	mov    %edx,-0x7feb4914(,%eax,4)
8010341f:	eb de                	jmp    801033ff <log_write+0x7f>
80103421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103428:	8b 43 08             	mov    0x8(%ebx),%eax
8010342b:	a3 ec b6 14 80       	mov    %eax,0x8014b6ec
  if (i == log.lh.n)
80103430:	75 cd                	jne    801033ff <log_write+0x7f>
80103432:	31 c0                	xor    %eax,%eax
80103434:	eb c1                	jmp    801033f7 <log_write+0x77>
    panic("too big a transaction");
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	68 73 85 10 80       	push   $0x80108573
8010343e:	e8 4d cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80103443:	83 ec 0c             	sub    $0xc,%esp
80103446:	68 89 85 10 80       	push   $0x80108589
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
80103468:	68 a4 85 10 80       	push   $0x801085a4
8010346d:	e8 ee d1 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80103472:	e8 c9 2b 00 00       	call   80106040 <idtinit>
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
80103496:	e8 35 3d 00 00       	call   801071d0 <switchkvm>
  seginit();
8010349b:	e8 a0 3c 00 00       	call   80107140 <seginit>
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
801034c7:	68 c8 79 15 80       	push   $0x801579c8
801034cc:	e8 8f f3 ff ff       	call   80102860 <kinit1>
  kvmalloc();      // kernel page table
801034d1:	e8 1a 42 00 00       	call   801076f0 <kvmalloc>
  mpinit();        // detect other processors
801034d6:	e8 75 01 00 00       	call   80103650 <mpinit>
  lapicinit();     // interrupt controller
801034db:	e8 60 f7 ff ff       	call   80102c40 <lapicinit>
  seginit();       // segment descriptors
801034e0:	e8 5b 3c 00 00       	call   80107140 <seginit>
  picinit();       // disable pic
801034e5:	e8 46 03 00 00       	call   80103830 <picinit>
  ioapicinit();    // another interrupt controller
801034ea:	e8 41 f1 ff ff       	call   80102630 <ioapicinit>
  consoleinit();   // console hardware
801034ef:	e8 cc d4 ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
801034f4:	e8 b7 2f 00 00       	call   801064b0 <uartinit>
  pinit();         // process table
801034f9:	e8 d2 08 00 00       	call   80103dd0 <pinit>
  tvinit();        // trap vectors
801034fe:	e8 bd 2a 00 00       	call   80105fc0 <tvinit>
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
8010351a:	68 8c b4 10 80       	push   $0x8010b48c
8010351f:	68 00 70 00 80       	push   $0x80007000
80103524:	e8 f7 18 00 00       	call   80104e20 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103529:	69 05 20 bd 14 80 b0 	imul   $0xb0,0x8014bd20,%eax
80103530:	00 00 00 
80103533:	83 c4 10             	add    $0x10,%esp
80103536:	05 a0 b7 14 80       	add    $0x8014b7a0,%eax
8010353b:	3d a0 b7 14 80       	cmp    $0x8014b7a0,%eax
80103540:	76 71                	jbe    801035b3 <main+0x103>
80103542:	bb a0 b7 14 80       	mov    $0x8014b7a0,%ebx
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
8010356d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103574:	a0 10 00 
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
8010359a:	69 05 20 bd 14 80 b0 	imul   $0xb0,0x8014bd20,%eax
801035a1:	00 00 00 
801035a4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035aa:	05 a0 b7 14 80       	add    $0x8014b7a0,%eax
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
801035fe:	68 b8 85 10 80       	push   $0x801085b8
80103603:	56                   	push   %esi
80103604:	e8 b7 17 00 00       	call   80104dc0 <memcmp>
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
801036bc:	68 d5 85 10 80       	push   $0x801085d5
801036c1:	56                   	push   %esi
801036c2:	e8 f9 16 00 00       	call   80104dc0 <memcmp>
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
80103727:	a3 80 b6 14 80       	mov    %eax,0x8014b680
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
80103750:	ff 24 95 fc 85 10 80 	jmp    *-0x7fef7a04(,%edx,4)
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
80103798:	8b 0d 20 bd 14 80    	mov    0x8014bd20,%ecx
8010379e:	83 f9 07             	cmp    $0x7,%ecx
801037a1:	7f 19                	jg     801037bc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801037a3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801037a7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801037ad:	83 c1 01             	add    $0x1,%ecx
801037b0:	89 0d 20 bd 14 80    	mov    %ecx,0x8014bd20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801037b6:	88 97 a0 b7 14 80    	mov    %dl,-0x7feb4860(%edi)
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
801037cf:	88 15 80 b7 14 80    	mov    %dl,0x8014b780
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
80103803:	68 bd 85 10 80       	push   $0x801085bd
80103808:	e8 83 cb ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010380d:	83 ec 0c             	sub    $0xc,%esp
80103810:	68 dc 85 10 80       	push   $0x801085dc
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
8010390b:	68 10 86 10 80       	push   $0x80108610
80103910:	50                   	push   %eax
80103911:	e8 0a 12 00 00       	call   80104b20 <initlock>
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
8010396f:	e8 ec 12 00 00       	call   80104c60 <acquire>
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
801039b4:	e9 67 13 00 00       	jmp    80104d20 <release>
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
801039e4:	e8 37 13 00 00       	call   80104d20 <release>
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
80103a0d:	e8 4e 12 00 00       	call   80104c60 <acquire>
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
80103aa4:	e8 77 12 00 00       	call   80104d20 <release>
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
80103afb:	e8 20 12 00 00       	call   80104d20 <release>
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
80103b20:	e8 3b 11 00 00       	call   80104c60 <acquire>
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
80103b8e:	e8 8d 11 00 00       	call   80104d20 <release>
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
80103bef:	e8 2c 11 00 00       	call   80104d20 <release>
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
80103c14:	bb 74 bd 14 80       	mov    $0x8014bd74,%ebx
{
80103c19:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c1c:	68 40 bd 14 80       	push   $0x8014bd40
80103c21:	e8 3a 10 00 00       	call   80104c60 <acquire>
80103c26:	83 c4 10             	add    $0x10,%esp
80103c29:	eb 17                	jmp    80103c42 <allocproc+0x32>
80103c2b:	90                   	nop
80103c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c30:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
80103c36:	81 fb 74 71 15 80    	cmp    $0x80157174,%ebx
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
80103c49:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103c4e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103c51:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103c58:	8d 50 01             	lea    0x1(%eax),%edx
80103c5b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103c5e:	68 40 bd 14 80       	push   $0x8014bd40
  p->pid = nextpid++;
80103c63:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103c69:	e8 b2 10 00 00       	call   80104d20 <release>

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
80103c92:	c7 40 14 b1 5f 10 80 	movl   $0x80105fb1,0x14(%eax)
  p->context = (struct context*)sp;
80103c99:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103c9c:	6a 14                	push   $0x14
80103c9e:	6a 00                	push   $0x0
80103ca0:	50                   	push   %eax
80103ca1:	e8 ca 10 00 00       	call   80104d70 <memset>
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
80103d55:	68 40 bd 14 80       	push   $0x8014bd40
80103d5a:	e8 c1 0f 00 00       	call   80104d20 <release>
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
80103d86:	68 40 bd 14 80       	push   $0x8014bd40
80103d8b:	e8 90 0f 00 00       	call   80104d20 <release>

  if (first) {
80103d90:	a1 00 b0 10 80       	mov    0x8010b000,%eax
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
80103da3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
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
80103dd6:	68 15 86 10 80       	push   $0x80108615
80103ddb:	68 40 bd 14 80       	push   $0x8014bd40
80103de0:	e8 3b 0d 00 00       	call   80104b20 <initlock>
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
80103e01:	8b 35 20 bd 14 80    	mov    0x8014bd20,%esi
80103e07:	85 f6                	test   %esi,%esi
80103e09:	7e 42                	jle    80103e4d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103e0b:	0f b6 15 a0 b7 14 80 	movzbl 0x8014b7a0,%edx
80103e12:	39 d0                	cmp    %edx,%eax
80103e14:	74 30                	je     80103e46 <mycpu+0x56>
80103e16:	b9 50 b8 14 80       	mov    $0x8014b850,%ecx
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
80103e3a:	05 a0 b7 14 80       	add    $0x8014b7a0,%eax
}
80103e3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e42:	5b                   	pop    %ebx
80103e43:	5e                   	pop    %esi
80103e44:	5d                   	pop    %ebp
80103e45:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103e46:	b8 a0 b7 14 80       	mov    $0x8014b7a0,%eax
      return &cpus[i];
80103e4b:	eb f2                	jmp    80103e3f <mycpu+0x4f>
  panic("unknown apicid\n");
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	68 1c 86 10 80       	push   $0x8010861c
80103e55:	e8 36 c5 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 50 87 10 80       	push   $0x80108750
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
80103e7b:	2d a0 b7 14 80       	sub    $0x8014b7a0,%eax
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
80103e97:	e8 f4 0c 00 00       	call   80104b90 <pushcli>
  c = mycpu();
80103e9c:	e8 4f ff ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80103ea1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea7:	e8 24 0d 00 00       	call   80104bd0 <popcli>
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
80103ece:	a3 b8 b5 10 80       	mov    %eax,0x8010b5b8
  if((p->pgdir = setupkvm()) == 0)
80103ed3:	e8 98 37 00 00       	call   80107670 <setupkvm>
80103ed8:	85 c0                	test   %eax,%eax
80103eda:	89 43 04             	mov    %eax,0x4(%ebx)
80103edd:	0f 84 da 00 00 00    	je     80103fbd <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ee3:	83 ec 04             	sub    $0x4,%esp
80103ee6:	68 2c 00 00 00       	push   $0x2c
80103eeb:	68 60 b4 10 80       	push   $0x8010b460
80103ef0:	50                   	push   %eax
80103ef1:	e8 0a 34 00 00       	call   80107300 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ef6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ef9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103eff:	6a 4c                	push   $0x4c
80103f01:	6a 00                	push   $0x0
80103f03:	ff 73 18             	pushl  0x18(%ebx)
80103f06:	e8 65 0e 00 00       	call   80104d70 <memset>
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
80103f5f:	68 45 86 10 80       	push   $0x80108645
80103f64:	50                   	push   %eax
80103f65:	e8 e6 0f 00 00       	call   80104f50 <safestrcpy>
  p->cwd = namei("/");
80103f6a:	c7 04 24 4e 86 10 80 	movl   $0x8010864e,(%esp)
80103f71:	e8 ea df ff ff       	call   80101f60 <namei>
80103f76:	89 43 68             	mov    %eax,0x68(%ebx)
  DEBUG_PRINT("%d",(PHYSTOP >> PGSHIFT));
80103f79:	c7 04 24 50 86 10 80 	movl   $0x80108650,(%esp)
80103f80:	e8 db c6 ff ff       	call   80100660 <cprintf>
80103f85:	58                   	pop    %eax
80103f86:	5a                   	pop    %edx
80103f87:	68 00 e0 00 00       	push   $0xe000
80103f8c:	68 58 86 10 80       	push   $0x80108658
80103f91:	e8 ca c6 ff ff       	call   80100660 <cprintf>
  acquire(&ptable.lock);
80103f96:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
80103f9d:	e8 be 0c 00 00       	call   80104c60 <acquire>
  p->state = RUNNABLE;
80103fa2:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fa9:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
80103fb0:	e8 6b 0d 00 00       	call   80104d20 <release>
}
80103fb5:	83 c4 10             	add    $0x10,%esp
80103fb8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fbb:	c9                   	leave  
80103fbc:	c3                   	ret    
    panic("userinit: out of memory?");
80103fbd:	83 ec 0c             	sub    $0xc,%esp
80103fc0:	68 2c 86 10 80       	push   $0x8010862c
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
80103fd8:	e8 b3 0b 00 00       	call   80104b90 <pushcli>
  c = mycpu();
80103fdd:	e8 0e fe ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80103fe2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fe8:	e8 e3 0b 00 00       	call   80104bd0 <popcli>
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
80103ffc:	e8 ef 31 00 00       	call   801071f0 <switchuvm>
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
8010401a:	e8 21 3e 00 00       	call   80107e40 <allocuvm>
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
8010403a:	e8 01 34 00 00       	call   80107440 <deallocuvm>
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
8010405c:	e8 2f 0b 00 00       	call   80104b90 <pushcli>
  c = mycpu();
80104061:	e8 8a fd ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80104066:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010406c:	e8 5f 0b 00 00       	call   80104bd0 <popcli>
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
8010408e:	e8 ad 36 00 00       	call   80107740 <copyuvm>
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
80104111:	e8 3a 0e 00 00       	call   80104f50 <safestrcpy>
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
80104175:	e8 a6 0c 00 00       	call   80104e20 <memmove>
      memmove(&np->swappedPGs[i],&curproc->swappedPGs[i],sizeof(struct swappedPG));
8010417a:	8d 04 33             	lea    (%ebx,%esi,1),%eax
8010417d:	83 c4 0c             	add    $0xc,%esp
80104180:	6a 10                	push   $0x10
80104182:	50                   	push   %eax
80104183:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
80104189:	01 f0                	add    %esi,%eax
8010418b:	83 c6 10             	add    $0x10,%esi
8010418e:	50                   	push   %eax
8010418f:	e8 8c 0c 00 00       	call   80104e20 <memmove>
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
801041f3:	68 40 bd 14 80       	push   $0x8014bd40
801041f8:	e8 63 0a 00 00       	call   80104c60 <acquire>
  np->state = RUNNABLE;
801041fd:	8b 85 e4 fb ff ff    	mov    -0x41c(%ebp),%eax
80104203:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  release(&ptable.lock);
8010420a:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
80104211:	e8 0a 0b 00 00       	call   80104d20 <release>
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
80104294:	bb 74 bd 14 80       	mov    $0x8014bd74,%ebx
    acquire(&ptable.lock);
80104299:	68 40 bd 14 80       	push   $0x8014bd40
8010429e:	e8 bd 09 00 00       	call   80104c60 <acquire>
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
801042c0:	e8 2b 2f 00 00       	call   801071f0 <switchuvm>
      swtch(&(c->scheduler), p->context);
801042c5:	58                   	pop    %eax
801042c6:	5a                   	pop    %edx
801042c7:	ff 73 1c             	pushl  0x1c(%ebx)
801042ca:	57                   	push   %edi
      p->state = RUNNING;
801042cb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
801042d2:	e8 d4 0c 00 00       	call   80104fab <swtch>
      switchkvm();
801042d7:	e8 f4 2e 00 00       	call   801071d0 <switchkvm>
      c->proc = 0;
801042dc:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801042e3:	00 00 00 
801042e6:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e9:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
801042ef:	81 fb 74 71 15 80    	cmp    $0x80157174,%ebx
801042f5:	72 b9                	jb     801042b0 <scheduler+0x40>
    release(&ptable.lock);
801042f7:	83 ec 0c             	sub    $0xc,%esp
801042fa:	68 40 bd 14 80       	push   $0x8014bd40
801042ff:	e8 1c 0a 00 00       	call   80104d20 <release>
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
80104315:	e8 76 08 00 00       	call   80104b90 <pushcli>
  c = mycpu();
8010431a:	e8 d1 fa ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010431f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104325:	e8 a6 08 00 00       	call   80104bd0 <popcli>
  if(!holding(&ptable.lock))
8010432a:	83 ec 0c             	sub    $0xc,%esp
8010432d:	68 40 bd 14 80       	push   $0x8014bd40
80104332:	e8 f9 08 00 00       	call   80104c30 <holding>
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
80104373:	e8 33 0c 00 00       	call   80104fab <swtch>
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
80104390:	68 5b 86 10 80       	push   $0x8010865b
80104395:	e8 f6 bf ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010439a:	83 ec 0c             	sub    $0xc,%esp
8010439d:	68 87 86 10 80       	push   $0x80108687
801043a2:	e8 e9 bf ff ff       	call   80100390 <panic>
    panic("sched running");
801043a7:	83 ec 0c             	sub    $0xc,%esp
801043aa:	68 79 86 10 80       	push   $0x80108679
801043af:	e8 dc bf ff ff       	call   80100390 <panic>
    panic("sched locks");
801043b4:	83 ec 0c             	sub    $0xc,%esp
801043b7:	68 6d 86 10 80       	push   $0x8010866d
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
801043d9:	e8 b2 07 00 00       	call   80104b90 <pushcli>
  c = mycpu();
801043de:	e8 0d fa ff ff       	call   80103df0 <mycpu>
  p = c->proc;
801043e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043e9:	e8 e2 07 00 00       	call   80104bd0 <popcli>
  if(curproc == initproc)
801043ee:	39 35 b8 b5 10 80    	cmp    %esi,0x8010b5b8
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
8010444f:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
80104456:	e8 05 08 00 00       	call   80104c60 <acquire>
  wakeup1(curproc->parent);
8010445b:	8b 56 14             	mov    0x14(%esi),%edx
8010445e:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104461:	b8 74 bd 14 80       	mov    $0x8014bd74,%eax
80104466:	eb 14                	jmp    8010447c <exit+0xac>
80104468:	90                   	nop
80104469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104470:	05 d0 02 00 00       	add    $0x2d0,%eax
80104475:	3d 74 71 15 80       	cmp    $0x80157174,%eax
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
80104493:	3d 74 71 15 80       	cmp    $0x80157174,%eax
80104498:	72 e2                	jb     8010447c <exit+0xac>
      p->parent = initproc;
8010449a:	8b 0d b8 b5 10 80    	mov    0x8010b5b8,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a0:	ba 74 bd 14 80       	mov    $0x8014bd74,%edx
801044a5:	eb 17                	jmp    801044be <exit+0xee>
801044a7:	89 f6                	mov    %esi,%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801044b0:	81 c2 d0 02 00 00    	add    $0x2d0,%edx
801044b6:	81 fa 74 71 15 80    	cmp    $0x80157174,%edx
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
801044cc:	b8 74 bd 14 80       	mov    $0x8014bd74,%eax
801044d1:	eb 11                	jmp    801044e4 <exit+0x114>
801044d3:	90                   	nop
801044d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044d8:	05 d0 02 00 00       	add    $0x2d0,%eax
801044dd:	3d 74 71 15 80       	cmp    $0x80157174,%eax
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
801044fb:	68 a8 86 10 80       	push   $0x801086a8
80104500:	e8 8b be ff ff       	call   80100390 <panic>
  curproc->state = ZOMBIE;
80104505:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010450c:	e8 ff fd ff ff       	call   80104310 <sched>
  panic("zombie exit");
80104511:	83 ec 0c             	sub    $0xc,%esp
80104514:	68 c3 86 10 80       	push   $0x801086c3
80104519:	e8 72 be ff ff       	call   80100390 <panic>
    panic("init exiting");
8010451e:	83 ec 0c             	sub    $0xc,%esp
80104521:	68 9b 86 10 80       	push   $0x8010869b
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
80104537:	68 40 bd 14 80       	push   $0x8014bd40
8010453c:	e8 1f 07 00 00       	call   80104c60 <acquire>
  pushcli();
80104541:	e8 4a 06 00 00       	call   80104b90 <pushcli>
  c = mycpu();
80104546:	e8 a5 f8 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010454b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104551:	e8 7a 06 00 00       	call   80104bd0 <popcli>
  myproc()->state = RUNNABLE;
80104556:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010455d:	e8 ae fd ff ff       	call   80104310 <sched>
  release(&ptable.lock);
80104562:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
80104569:	e8 b2 07 00 00       	call   80104d20 <release>
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
8010458f:	e8 fc 05 00 00       	call   80104b90 <pushcli>
  c = mycpu();
80104594:	e8 57 f8 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
80104599:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010459f:	e8 2c 06 00 00       	call   80104bd0 <popcli>
  if(p == 0)
801045a4:	85 db                	test   %ebx,%ebx
801045a6:	0f 84 87 00 00 00    	je     80104633 <sleep+0xb3>
  if(lk == 0)
801045ac:	85 f6                	test   %esi,%esi
801045ae:	74 76                	je     80104626 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801045b0:	81 fe 40 bd 14 80    	cmp    $0x8014bd40,%esi
801045b6:	74 50                	je     80104608 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801045b8:	83 ec 0c             	sub    $0xc,%esp
801045bb:	68 40 bd 14 80       	push   $0x8014bd40
801045c0:	e8 9b 06 00 00       	call   80104c60 <acquire>
    release(lk);
801045c5:	89 34 24             	mov    %esi,(%esp)
801045c8:	e8 53 07 00 00       	call   80104d20 <release>
  p->chan = chan;
801045cd:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801045d0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801045d7:	e8 34 fd ff ff       	call   80104310 <sched>
  p->chan = 0;
801045dc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801045e3:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
801045ea:	e8 31 07 00 00       	call   80104d20 <release>
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
801045fc:	e9 5f 06 00 00       	jmp    80104c60 <acquire>
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
80104629:	68 d5 86 10 80       	push   $0x801086d5
8010462e:	e8 5d bd ff ff       	call   80100390 <panic>
    panic("sleep");
80104633:	83 ec 0c             	sub    $0xc,%esp
80104636:	68 cf 86 10 80       	push   $0x801086cf
8010463b:	e8 50 bd ff ff       	call   80100390 <panic>

80104640 <wait>:
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	56                   	push   %esi
80104644:	53                   	push   %ebx
  pushcli();
80104645:	e8 46 05 00 00       	call   80104b90 <pushcli>
  c = mycpu();
8010464a:	e8 a1 f7 ff ff       	call   80103df0 <mycpu>
  p = c->proc;
8010464f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104655:	e8 76 05 00 00       	call   80104bd0 <popcli>
  acquire(&ptable.lock);
8010465a:	83 ec 0c             	sub    $0xc,%esp
8010465d:	68 40 bd 14 80       	push   $0x8014bd40
80104662:	e8 f9 05 00 00       	call   80104c60 <acquire>
80104667:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010466a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010466c:	bb 74 bd 14 80       	mov    $0x8014bd74,%ebx
80104671:	eb 13                	jmp    80104686 <wait+0x46>
80104673:	90                   	nop
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104678:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
8010467e:	81 fb 74 71 15 80    	cmp    $0x80157174,%ebx
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
8010469c:	81 fb 74 71 15 80    	cmp    $0x80157174,%ebx
801046a2:	72 e2                	jb     80104686 <wait+0x46>
    if(!havekids || curproc->killed){
801046a4:	85 c0                	test   %eax,%eax
801046a6:	74 7d                	je     80104725 <wait+0xe5>
801046a8:	8b 46 24             	mov    0x24(%esi),%eax
801046ab:	85 c0                	test   %eax,%eax
801046ad:	75 76                	jne    80104725 <wait+0xe5>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801046af:	83 ec 08             	sub    $0x8,%esp
801046b2:	68 40 bd 14 80       	push   $0x8014bd40
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
801046e1:	e8 0a 2f 00 00       	call   801075f0 <freevm>
        release(&ptable.lock);
801046e6:	c7 04 24 40 bd 14 80 	movl   $0x8014bd40,(%esp)
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
80104714:	e8 07 06 00 00       	call   80104d20 <release>
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
8010472d:	68 40 bd 14 80       	push   $0x8014bd40
80104732:	e8 e9 05 00 00       	call   80104d20 <release>
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
8010474a:	68 40 bd 14 80       	push   $0x8014bd40
8010474f:	e8 0c 05 00 00       	call   80104c60 <acquire>
80104754:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104757:	b8 74 bd 14 80       	mov    $0x8014bd74,%eax
8010475c:	eb 0e                	jmp    8010476c <wakeup+0x2c>
8010475e:	66 90                	xchg   %ax,%ax
80104760:	05 d0 02 00 00       	add    $0x2d0,%eax
80104765:	3d 74 71 15 80       	cmp    $0x80157174,%eax
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
80104783:	3d 74 71 15 80       	cmp    $0x80157174,%eax
80104788:	72 e2                	jb     8010476c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
8010478a:	c7 45 08 40 bd 14 80 	movl   $0x8014bd40,0x8(%ebp)
}
80104791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104794:	c9                   	leave  
  release(&ptable.lock);
80104795:	e9 86 05 00 00       	jmp    80104d20 <release>
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
801047aa:	68 40 bd 14 80       	push   $0x8014bd40
801047af:	e8 ac 04 00 00       	call   80104c60 <acquire>
801047b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047b7:	b8 74 bd 14 80       	mov    $0x8014bd74,%eax
801047bc:	eb 0e                	jmp    801047cc <kill+0x2c>
801047be:	66 90                	xchg   %ax,%ax
801047c0:	05 d0 02 00 00       	add    $0x2d0,%eax
801047c5:	3d 74 71 15 80       	cmp    $0x80157174,%eax
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
801047e8:	68 40 bd 14 80       	push   $0x8014bd40
801047ed:	e8 2e 05 00 00       	call   80104d20 <release>
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
80104803:	68 40 bd 14 80       	push   $0x8014bd40
80104808:	e8 13 05 00 00       	call   80104d20 <release>
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
80104829:	bb 74 bd 14 80       	mov    $0x8014bd74,%ebx
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
8010483b:	68 32 8c 10 80       	push   $0x80108c32
80104840:	e8 1b be ff ff       	call   80100660 <cprintf>
80104845:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104848:	81 c3 d0 02 00 00    	add    $0x2d0,%ebx
8010484e:	81 fb 74 71 15 80    	cmp    $0x80157174,%ebx
80104854:	0f 83 86 00 00 00    	jae    801048e0 <procdump+0xc0>
    if(p->state == UNUSED)
8010485a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010485d:	85 c0                	test   %eax,%eax
8010485f:	74 e7                	je     80104848 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104861:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104864:	ba e6 86 10 80       	mov    $0x801086e6,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104869:	77 11                	ja     8010487c <procdump+0x5c>
8010486b:	8b 14 85 78 87 10 80 	mov    -0x7fef7888(,%eax,4),%edx
      state = "???";
80104872:	b8 e6 86 10 80       	mov    $0x801086e6,%eax
80104877:	85 d2                	test   %edx,%edx
80104879:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010487c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010487f:	50                   	push   %eax
80104880:	52                   	push   %edx
80104881:	ff 73 10             	pushl  0x10(%ebx)
80104884:	68 ea 86 10 80       	push   $0x801086ea
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
801048ab:	e8 90 02 00 00       	call   80104b40 <getcallerpcs>
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
801048c9:	68 81 80 10 80       	push   $0x80108081
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
801048f6:	be 74 bd 14 80       	mov    $0x8014bd74,%esi
nfuaTickUpdate(){
801048fb:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);
801048fe:	68 40 bd 14 80       	push   $0x8014bd40
80104903:	e8 58 03 00 00       	call   80104c60 <acquire>
80104908:	83 c4 10             	add    $0x10,%esp
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid>2)
80104910:	83 7e 10 02          	cmpl   $0x2,0x10(%esi)
80104914:	0f 8f 98 00 00 00    	jg     801049b2 <nfuaTickUpdate+0xc2>
      break;
    if(!((p->state == RUNNING) || (p->state == RUNNING) || (p->state == RUNNING)))
8010491a:	83 7e 0c 04          	cmpl   $0x4,0xc(%esi)
8010491e:	0f 85 8e 00 00 00    	jne    801049b2 <nfuaTickUpdate+0xc2>
80104924:	8d 9e 98 01 00 00    	lea    0x198(%esi),%ebx
8010492a:	8d be d8 02 00 00    	lea    0x2d8(%esi),%edi
80104930:	eb 38                	jmp    8010496a <nfuaTickUpdate+0x7a>
80104932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        continue;
      
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
      if(*pde & PTE_P){
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104938:	c1 e8 0a             	shr    $0xa,%eax
        pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010493b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
        pte = &pgtab[PTX(p->physicalPGs[i].va)];
80104941:	25 fc 0f 00 00       	and    $0xffc,%eax
80104946:	8d 94 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edx
      } else {
        cprintf("nfuaUpdate: pte is not PTE_P\n");
        continue;
      }
      if(!pte){
8010494d:	85 d2                	test   %edx,%edx
8010494f:	74 7f                	je     801049d0 <nfuaTickUpdate+0xe0>
        cprintf("nfuaUpdate : !pte\n");
        continue;
      }

      p->physicalPGs[i].age = ((p->physicalPGs[i].age) >> 1); // shift right
80104951:	8b 03                	mov    (%ebx),%eax
80104953:	d1 e8                	shr    %eax
80104955:	89 03                	mov    %eax,(%ebx)

      if(*pte & PTE_A){                                       // set MSB if accessed
80104957:	f6 02 20             	testb  $0x20,(%edx)
8010495a:	74 07                	je     80104963 <nfuaTickUpdate+0x73>
        uint newBit = 1 << ((sizeof(uint)*8) - 1);
        p->physicalPGs[i].age |= newBit;
8010495c:	0d 00 00 00 80       	or     $0x80000000,%eax
80104961:	89 03                	mov    %eax,(%ebx)
80104963:	83 c3 14             	add    $0x14,%ebx
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104966:	39 df                	cmp    %ebx,%edi
80104968:	74 36                	je     801049a0 <nfuaTickUpdate+0xb0>
      if(p->physicalPGs[i].va == (char*)0xffffffff)
8010496a:	8b 43 f8             	mov    -0x8(%ebx),%eax
8010496d:	83 f8 ff             	cmp    $0xffffffff,%eax
80104970:	74 f1                	je     80104963 <nfuaTickUpdate+0x73>
      if(*pde & PTE_P){
80104972:	8b 56 04             	mov    0x4(%esi),%edx
      pde = &p->pgdir[PDX(p->physicalPGs[i].va)];
80104975:	89 c1                	mov    %eax,%ecx
80104977:	c1 e9 16             	shr    $0x16,%ecx
      if(*pde & PTE_P){
8010497a:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
8010497d:	f6 c2 01             	test   $0x1,%dl
80104980:	75 b6                	jne    80104938 <nfuaTickUpdate+0x48>
        cprintf("nfuaUpdate: pte is not PTE_P\n");
80104982:	83 ec 0c             	sub    $0xc,%esp
80104985:	83 c3 14             	add    $0x14,%ebx
80104988:	68 f3 86 10 80       	push   $0x801086f3
8010498d:	e8 ce bc ff ff       	call   80100660 <cprintf>
        continue;
80104992:	83 c4 10             	add    $0x10,%esp
    for(i = 0; i < MAX_PSYC_PAGES; i++){
80104995:	39 df                	cmp    %ebx,%edi
80104997:	75 d1                	jne    8010496a <nfuaTickUpdate+0x7a>
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049a0:	81 c6 d0 02 00 00    	add    $0x2d0,%esi
801049a6:	81 fe 74 71 15 80    	cmp    $0x80157174,%esi
801049ac:	0f 82 5e ff ff ff    	jb     80104910 <nfuaTickUpdate+0x20>
      }
    }
  }
  release(&ptable.lock);
801049b2:	83 ec 0c             	sub    $0xc,%esp
801049b5:	68 40 bd 14 80       	push   $0x8014bd40
801049ba:	e8 61 03 00 00       	call   80104d20 <release>
801049bf:	83 c4 10             	add    $0x10,%esp
801049c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049c5:	5b                   	pop    %ebx
801049c6:	5e                   	pop    %esi
801049c7:	5f                   	pop    %edi
801049c8:	5d                   	pop    %ebp
801049c9:	c3                   	ret    
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("nfuaUpdate : !pte\n");
801049d0:	83 ec 0c             	sub    $0xc,%esp
801049d3:	68 11 87 10 80       	push   $0x80108711
801049d8:	e8 83 bc ff ff       	call   80100660 <cprintf>
        continue;
801049dd:	83 c4 10             	add    $0x10,%esp
801049e0:	eb 81                	jmp    80104963 <nfuaTickUpdate+0x73>
801049e2:	66 90                	xchg   %ax,%ax
801049e4:	66 90                	xchg   %ax,%ax
801049e6:	66 90                	xchg   %ax,%ax
801049e8:	66 90                	xchg   %ax,%ax
801049ea:	66 90                	xchg   %ax,%ax
801049ec:	66 90                	xchg   %ax,%ax
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	53                   	push   %ebx
801049f4:	83 ec 0c             	sub    $0xc,%esp
801049f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801049fa:	68 90 87 10 80       	push   $0x80108790
801049ff:	8d 43 04             	lea    0x4(%ebx),%eax
80104a02:	50                   	push   %eax
80104a03:	e8 18 01 00 00       	call   80104b20 <initlock>
  lk->name = name;
80104a08:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104a0b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104a11:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104a14:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104a1b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104a1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a21:	c9                   	leave  
80104a22:	c3                   	ret    
80104a23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a30 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	56                   	push   %esi
80104a34:	53                   	push   %ebx
80104a35:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a38:	83 ec 0c             	sub    $0xc,%esp
80104a3b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a3e:	56                   	push   %esi
80104a3f:	e8 1c 02 00 00       	call   80104c60 <acquire>
  while (lk->locked) {
80104a44:	8b 13                	mov    (%ebx),%edx
80104a46:	83 c4 10             	add    $0x10,%esp
80104a49:	85 d2                	test   %edx,%edx
80104a4b:	74 16                	je     80104a63 <acquiresleep+0x33>
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104a50:	83 ec 08             	sub    $0x8,%esp
80104a53:	56                   	push   %esi
80104a54:	53                   	push   %ebx
80104a55:	e8 26 fb ff ff       	call   80104580 <sleep>
  while (lk->locked) {
80104a5a:	8b 03                	mov    (%ebx),%eax
80104a5c:	83 c4 10             	add    $0x10,%esp
80104a5f:	85 c0                	test   %eax,%eax
80104a61:	75 ed                	jne    80104a50 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104a63:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104a69:	e8 22 f4 ff ff       	call   80103e90 <myproc>
80104a6e:	8b 40 10             	mov    0x10(%eax),%eax
80104a71:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104a74:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104a77:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a7a:	5b                   	pop    %ebx
80104a7b:	5e                   	pop    %esi
80104a7c:	5d                   	pop    %ebp
  release(&lk->lk);
80104a7d:	e9 9e 02 00 00       	jmp    80104d20 <release>
80104a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a90 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	56                   	push   %esi
80104a94:	53                   	push   %ebx
80104a95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104a98:	83 ec 0c             	sub    $0xc,%esp
80104a9b:	8d 73 04             	lea    0x4(%ebx),%esi
80104a9e:	56                   	push   %esi
80104a9f:	e8 bc 01 00 00       	call   80104c60 <acquire>
  lk->locked = 0;
80104aa4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104aaa:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ab1:	89 1c 24             	mov    %ebx,(%esp)
80104ab4:	e8 87 fc ff ff       	call   80104740 <wakeup>
  release(&lk->lk);
80104ab9:	89 75 08             	mov    %esi,0x8(%ebp)
80104abc:	83 c4 10             	add    $0x10,%esp
}
80104abf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ac2:	5b                   	pop    %ebx
80104ac3:	5e                   	pop    %esi
80104ac4:	5d                   	pop    %ebp
  release(&lk->lk);
80104ac5:	e9 56 02 00 00       	jmp    80104d20 <release>
80104aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ad0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	57                   	push   %edi
80104ad4:	56                   	push   %esi
80104ad5:	53                   	push   %ebx
80104ad6:	31 ff                	xor    %edi,%edi
80104ad8:	83 ec 18             	sub    $0x18,%esp
80104adb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ade:	8d 73 04             	lea    0x4(%ebx),%esi
80104ae1:	56                   	push   %esi
80104ae2:	e8 79 01 00 00       	call   80104c60 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ae7:	8b 03                	mov    (%ebx),%eax
80104ae9:	83 c4 10             	add    $0x10,%esp
80104aec:	85 c0                	test   %eax,%eax
80104aee:	74 13                	je     80104b03 <holdingsleep+0x33>
80104af0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104af3:	e8 98 f3 ff ff       	call   80103e90 <myproc>
80104af8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104afb:	0f 94 c0             	sete   %al
80104afe:	0f b6 c0             	movzbl %al,%eax
80104b01:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104b03:	83 ec 0c             	sub    $0xc,%esp
80104b06:	56                   	push   %esi
80104b07:	e8 14 02 00 00       	call   80104d20 <release>
  return r;
}
80104b0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b0f:	89 f8                	mov    %edi,%eax
80104b11:	5b                   	pop    %ebx
80104b12:	5e                   	pop    %esi
80104b13:	5f                   	pop    %edi
80104b14:	5d                   	pop    %ebp
80104b15:	c3                   	ret    
80104b16:	66 90                	xchg   %ax,%ax
80104b18:	66 90                	xchg   %ax,%ax
80104b1a:	66 90                	xchg   %ax,%ax
80104b1c:	66 90                	xchg   %ax,%ax
80104b1e:	66 90                	xchg   %ax,%ax

80104b20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104b20:	55                   	push   %ebp
80104b21:	89 e5                	mov    %esp,%ebp
80104b23:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104b26:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104b29:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104b2f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104b32:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104b39:	5d                   	pop    %ebp
80104b3a:	c3                   	ret    
80104b3b:	90                   	nop
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104b40:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b41:	31 d2                	xor    %edx,%edx
{
80104b43:	89 e5                	mov    %esp,%ebp
80104b45:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104b46:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104b49:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b4c:	83 e8 08             	sub    $0x8,%eax
80104b4f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b50:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104b56:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b5c:	77 1a                	ja     80104b78 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b5e:	8b 58 04             	mov    0x4(%eax),%ebx
80104b61:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104b64:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104b67:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104b69:	83 fa 0a             	cmp    $0xa,%edx
80104b6c:	75 e2                	jne    80104b50 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104b6e:	5b                   	pop    %ebx
80104b6f:	5d                   	pop    %ebp
80104b70:	c3                   	ret    
80104b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b78:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104b7b:	83 c1 28             	add    $0x28,%ecx
80104b7e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104b80:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104b86:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104b89:	39 c1                	cmp    %eax,%ecx
80104b8b:	75 f3                	jne    80104b80 <getcallerpcs+0x40>
}
80104b8d:	5b                   	pop    %ebx
80104b8e:	5d                   	pop    %ebp
80104b8f:	c3                   	ret    

80104b90 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	53                   	push   %ebx
80104b94:	83 ec 04             	sub    $0x4,%esp
80104b97:	9c                   	pushf  
80104b98:	5b                   	pop    %ebx
  asm volatile("cli");
80104b99:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104b9a:	e8 51 f2 ff ff       	call   80103df0 <mycpu>
80104b9f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104ba5:	85 c0                	test   %eax,%eax
80104ba7:	75 11                	jne    80104bba <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104ba9:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104baf:	e8 3c f2 ff ff       	call   80103df0 <mycpu>
80104bb4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
80104bba:	e8 31 f2 ff ff       	call   80103df0 <mycpu>
80104bbf:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104bc6:	83 c4 04             	add    $0x4,%esp
80104bc9:	5b                   	pop    %ebx
80104bca:	5d                   	pop    %ebp
80104bcb:	c3                   	ret    
80104bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104bd0 <popcli>:

void
popcli(void)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104bd6:	9c                   	pushf  
80104bd7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bd8:	f6 c4 02             	test   $0x2,%ah
80104bdb:	75 35                	jne    80104c12 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104bdd:	e8 0e f2 ff ff       	call   80103df0 <mycpu>
80104be2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104be9:	78 34                	js     80104c1f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104beb:	e8 00 f2 ff ff       	call   80103df0 <mycpu>
80104bf0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104bf6:	85 d2                	test   %edx,%edx
80104bf8:	74 06                	je     80104c00 <popcli+0x30>
    sti();
}
80104bfa:	c9                   	leave  
80104bfb:	c3                   	ret    
80104bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c00:	e8 eb f1 ff ff       	call   80103df0 <mycpu>
80104c05:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c0b:	85 c0                	test   %eax,%eax
80104c0d:	74 eb                	je     80104bfa <popcli+0x2a>
  asm volatile("sti");
80104c0f:	fb                   	sti    
}
80104c10:	c9                   	leave  
80104c11:	c3                   	ret    
    panic("popcli - interruptible");
80104c12:	83 ec 0c             	sub    $0xc,%esp
80104c15:	68 9b 87 10 80       	push   $0x8010879b
80104c1a:	e8 71 b7 ff ff       	call   80100390 <panic>
    panic("popcli");
80104c1f:	83 ec 0c             	sub    $0xc,%esp
80104c22:	68 b2 87 10 80       	push   $0x801087b2
80104c27:	e8 64 b7 ff ff       	call   80100390 <panic>
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <holding>:
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	56                   	push   %esi
80104c34:	53                   	push   %ebx
80104c35:	8b 75 08             	mov    0x8(%ebp),%esi
80104c38:	31 db                	xor    %ebx,%ebx
  pushcli();
80104c3a:	e8 51 ff ff ff       	call   80104b90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104c3f:	8b 06                	mov    (%esi),%eax
80104c41:	85 c0                	test   %eax,%eax
80104c43:	74 10                	je     80104c55 <holding+0x25>
80104c45:	8b 5e 08             	mov    0x8(%esi),%ebx
80104c48:	e8 a3 f1 ff ff       	call   80103df0 <mycpu>
80104c4d:	39 c3                	cmp    %eax,%ebx
80104c4f:	0f 94 c3             	sete   %bl
80104c52:	0f b6 db             	movzbl %bl,%ebx
  popcli();
80104c55:	e8 76 ff ff ff       	call   80104bd0 <popcli>
}
80104c5a:	89 d8                	mov    %ebx,%eax
80104c5c:	5b                   	pop    %ebx
80104c5d:	5e                   	pop    %esi
80104c5e:	5d                   	pop    %ebp
80104c5f:	c3                   	ret    

80104c60 <acquire>:
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	56                   	push   %esi
80104c64:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104c65:	e8 26 ff ff ff       	call   80104b90 <pushcli>
  if(holding(lk))
80104c6a:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c6d:	83 ec 0c             	sub    $0xc,%esp
80104c70:	53                   	push   %ebx
80104c71:	e8 ba ff ff ff       	call   80104c30 <holding>
80104c76:	83 c4 10             	add    $0x10,%esp
80104c79:	85 c0                	test   %eax,%eax
80104c7b:	0f 85 83 00 00 00    	jne    80104d04 <acquire+0xa4>
80104c81:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104c83:	ba 01 00 00 00       	mov    $0x1,%edx
80104c88:	eb 09                	jmp    80104c93 <acquire+0x33>
80104c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c90:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c93:	89 d0                	mov    %edx,%eax
80104c95:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104c98:	85 c0                	test   %eax,%eax
80104c9a:	75 f4                	jne    80104c90 <acquire+0x30>
  __sync_synchronize();
80104c9c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ca1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ca4:	e8 47 f1 ff ff       	call   80103df0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104ca9:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
80104cac:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104caf:	89 e8                	mov    %ebp,%eax
80104cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cb8:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
80104cbe:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104cc4:	77 1a                	ja     80104ce0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104cc6:	8b 48 04             	mov    0x4(%eax),%ecx
80104cc9:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
80104ccc:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104ccf:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104cd1:	83 fe 0a             	cmp    $0xa,%esi
80104cd4:	75 e2                	jne    80104cb8 <acquire+0x58>
}
80104cd6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cd9:	5b                   	pop    %ebx
80104cda:	5e                   	pop    %esi
80104cdb:	5d                   	pop    %ebp
80104cdc:	c3                   	ret    
80104cdd:	8d 76 00             	lea    0x0(%esi),%esi
80104ce0:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104ce3:	83 c2 28             	add    $0x28,%edx
80104ce6:	8d 76 00             	lea    0x0(%esi),%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104cf0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104cf6:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104cf9:	39 d0                	cmp    %edx,%eax
80104cfb:	75 f3                	jne    80104cf0 <acquire+0x90>
}
80104cfd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d00:	5b                   	pop    %ebx
80104d01:	5e                   	pop    %esi
80104d02:	5d                   	pop    %ebp
80104d03:	c3                   	ret    
    panic("acquire");
80104d04:	83 ec 0c             	sub    $0xc,%esp
80104d07:	68 b9 87 10 80       	push   $0x801087b9
80104d0c:	e8 7f b6 ff ff       	call   80100390 <panic>
80104d11:	eb 0d                	jmp    80104d20 <release>
80104d13:	90                   	nop
80104d14:	90                   	nop
80104d15:	90                   	nop
80104d16:	90                   	nop
80104d17:	90                   	nop
80104d18:	90                   	nop
80104d19:	90                   	nop
80104d1a:	90                   	nop
80104d1b:	90                   	nop
80104d1c:	90                   	nop
80104d1d:	90                   	nop
80104d1e:	90                   	nop
80104d1f:	90                   	nop

80104d20 <release>:
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	53                   	push   %ebx
80104d24:	83 ec 10             	sub    $0x10,%esp
80104d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104d2a:	53                   	push   %ebx
80104d2b:	e8 00 ff ff ff       	call   80104c30 <holding>
80104d30:	83 c4 10             	add    $0x10,%esp
80104d33:	85 c0                	test   %eax,%eax
80104d35:	74 22                	je     80104d59 <release+0x39>
  lk->pcs[0] = 0;
80104d37:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104d3e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104d45:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104d4a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104d50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d53:	c9                   	leave  
  popcli();
80104d54:	e9 77 fe ff ff       	jmp    80104bd0 <popcli>
    panic("release");
80104d59:	83 ec 0c             	sub    $0xc,%esp
80104d5c:	68 c1 87 10 80       	push   $0x801087c1
80104d61:	e8 2a b6 ff ff       	call   80100390 <panic>
80104d66:	66 90                	xchg   %ax,%ax
80104d68:	66 90                	xchg   %ax,%ax
80104d6a:	66 90                	xchg   %ax,%ax
80104d6c:	66 90                	xchg   %ax,%ax
80104d6e:	66 90                	xchg   %ax,%ax

80104d70 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d70:	55                   	push   %ebp
80104d71:	89 e5                	mov    %esp,%ebp
80104d73:	57                   	push   %edi
80104d74:	53                   	push   %ebx
80104d75:	8b 55 08             	mov    0x8(%ebp),%edx
80104d78:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104d7b:	f6 c2 03             	test   $0x3,%dl
80104d7e:	75 05                	jne    80104d85 <memset+0x15>
80104d80:	f6 c1 03             	test   $0x3,%cl
80104d83:	74 13                	je     80104d98 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104d85:	89 d7                	mov    %edx,%edi
80104d87:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d8a:	fc                   	cld    
80104d8b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d8d:	5b                   	pop    %ebx
80104d8e:	89 d0                	mov    %edx,%eax
80104d90:	5f                   	pop    %edi
80104d91:	5d                   	pop    %ebp
80104d92:	c3                   	ret    
80104d93:	90                   	nop
80104d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104d98:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104d9c:	c1 e9 02             	shr    $0x2,%ecx
80104d9f:	89 f8                	mov    %edi,%eax
80104da1:	89 fb                	mov    %edi,%ebx
80104da3:	c1 e0 18             	shl    $0x18,%eax
80104da6:	c1 e3 10             	shl    $0x10,%ebx
80104da9:	09 d8                	or     %ebx,%eax
80104dab:	09 f8                	or     %edi,%eax
80104dad:	c1 e7 08             	shl    $0x8,%edi
80104db0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104db2:	89 d7                	mov    %edx,%edi
80104db4:	fc                   	cld    
80104db5:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104db7:	5b                   	pop    %ebx
80104db8:	89 d0                	mov    %edx,%eax
80104dba:	5f                   	pop    %edi
80104dbb:	5d                   	pop    %ebp
80104dbc:	c3                   	ret    
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi

80104dc0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	57                   	push   %edi
80104dc4:	56                   	push   %esi
80104dc5:	53                   	push   %ebx
80104dc6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104dc9:	8b 75 08             	mov    0x8(%ebp),%esi
80104dcc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104dcf:	85 db                	test   %ebx,%ebx
80104dd1:	74 29                	je     80104dfc <memcmp+0x3c>
    if(*s1 != *s2)
80104dd3:	0f b6 16             	movzbl (%esi),%edx
80104dd6:	0f b6 0f             	movzbl (%edi),%ecx
80104dd9:	38 d1                	cmp    %dl,%cl
80104ddb:	75 2b                	jne    80104e08 <memcmp+0x48>
80104ddd:	b8 01 00 00 00       	mov    $0x1,%eax
80104de2:	eb 14                	jmp    80104df8 <memcmp+0x38>
80104de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104de8:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104dec:	83 c0 01             	add    $0x1,%eax
80104def:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104df4:	38 ca                	cmp    %cl,%dl
80104df6:	75 10                	jne    80104e08 <memcmp+0x48>
  while(n-- > 0){
80104df8:	39 d8                	cmp    %ebx,%eax
80104dfa:	75 ec                	jne    80104de8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104dfc:	5b                   	pop    %ebx
  return 0;
80104dfd:	31 c0                	xor    %eax,%eax
}
80104dff:	5e                   	pop    %esi
80104e00:	5f                   	pop    %edi
80104e01:	5d                   	pop    %ebp
80104e02:	c3                   	ret    
80104e03:	90                   	nop
80104e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104e08:	0f b6 c2             	movzbl %dl,%eax
}
80104e0b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104e0c:	29 c8                	sub    %ecx,%eax
}
80104e0e:	5e                   	pop    %esi
80104e0f:	5f                   	pop    %edi
80104e10:	5d                   	pop    %ebp
80104e11:	c3                   	ret    
80104e12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	56                   	push   %esi
80104e24:	53                   	push   %ebx
80104e25:	8b 45 08             	mov    0x8(%ebp),%eax
80104e28:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104e2b:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104e2e:	39 c3                	cmp    %eax,%ebx
80104e30:	73 26                	jae    80104e58 <memmove+0x38>
80104e32:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104e35:	39 c8                	cmp    %ecx,%eax
80104e37:	73 1f                	jae    80104e58 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104e39:	85 f6                	test   %esi,%esi
80104e3b:	8d 56 ff             	lea    -0x1(%esi),%edx
80104e3e:	74 0f                	je     80104e4f <memmove+0x2f>
      *--d = *--s;
80104e40:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e44:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104e47:	83 ea 01             	sub    $0x1,%edx
80104e4a:	83 fa ff             	cmp    $0xffffffff,%edx
80104e4d:	75 f1                	jne    80104e40 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e4f:	5b                   	pop    %ebx
80104e50:	5e                   	pop    %esi
80104e51:	5d                   	pop    %ebp
80104e52:	c3                   	ret    
80104e53:	90                   	nop
80104e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104e58:	31 d2                	xor    %edx,%edx
80104e5a:	85 f6                	test   %esi,%esi
80104e5c:	74 f1                	je     80104e4f <memmove+0x2f>
80104e5e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104e60:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e64:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e67:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104e6a:	39 d6                	cmp    %edx,%esi
80104e6c:	75 f2                	jne    80104e60 <memmove+0x40>
}
80104e6e:	5b                   	pop    %ebx
80104e6f:	5e                   	pop    %esi
80104e70:	5d                   	pop    %ebp
80104e71:	c3                   	ret    
80104e72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e80 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104e83:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104e84:	eb 9a                	jmp    80104e20 <memmove>
80104e86:	8d 76 00             	lea    0x0(%esi),%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	57                   	push   %edi
80104e94:	56                   	push   %esi
80104e95:	8b 7d 10             	mov    0x10(%ebp),%edi
80104e98:	53                   	push   %ebx
80104e99:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e9c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104e9f:	85 ff                	test   %edi,%edi
80104ea1:	74 2f                	je     80104ed2 <strncmp+0x42>
80104ea3:	0f b6 01             	movzbl (%ecx),%eax
80104ea6:	0f b6 1e             	movzbl (%esi),%ebx
80104ea9:	84 c0                	test   %al,%al
80104eab:	74 37                	je     80104ee4 <strncmp+0x54>
80104ead:	38 c3                	cmp    %al,%bl
80104eaf:	75 33                	jne    80104ee4 <strncmp+0x54>
80104eb1:	01 f7                	add    %esi,%edi
80104eb3:	eb 13                	jmp    80104ec8 <strncmp+0x38>
80104eb5:	8d 76 00             	lea    0x0(%esi),%esi
80104eb8:	0f b6 01             	movzbl (%ecx),%eax
80104ebb:	84 c0                	test   %al,%al
80104ebd:	74 21                	je     80104ee0 <strncmp+0x50>
80104ebf:	0f b6 1a             	movzbl (%edx),%ebx
80104ec2:	89 d6                	mov    %edx,%esi
80104ec4:	38 d8                	cmp    %bl,%al
80104ec6:	75 1c                	jne    80104ee4 <strncmp+0x54>
    n--, p++, q++;
80104ec8:	8d 56 01             	lea    0x1(%esi),%edx
80104ecb:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104ece:	39 fa                	cmp    %edi,%edx
80104ed0:	75 e6                	jne    80104eb8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104ed2:	5b                   	pop    %ebx
    return 0;
80104ed3:	31 c0                	xor    %eax,%eax
}
80104ed5:	5e                   	pop    %esi
80104ed6:	5f                   	pop    %edi
80104ed7:	5d                   	pop    %ebp
80104ed8:	c3                   	ret    
80104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ee0:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104ee4:	29 d8                	sub    %ebx,%eax
}
80104ee6:	5b                   	pop    %ebx
80104ee7:	5e                   	pop    %esi
80104ee8:	5f                   	pop    %edi
80104ee9:	5d                   	pop    %ebp
80104eea:	c3                   	ret    
80104eeb:	90                   	nop
80104eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ef0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ef8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104efb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104efe:	89 c2                	mov    %eax,%edx
80104f00:	eb 19                	jmp    80104f1b <strncpy+0x2b>
80104f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f08:	83 c3 01             	add    $0x1,%ebx
80104f0b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104f0f:	83 c2 01             	add    $0x1,%edx
80104f12:	84 c9                	test   %cl,%cl
80104f14:	88 4a ff             	mov    %cl,-0x1(%edx)
80104f17:	74 09                	je     80104f22 <strncpy+0x32>
80104f19:	89 f1                	mov    %esi,%ecx
80104f1b:	85 c9                	test   %ecx,%ecx
80104f1d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f20:	7f e6                	jg     80104f08 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f22:	31 c9                	xor    %ecx,%ecx
80104f24:	85 f6                	test   %esi,%esi
80104f26:	7e 17                	jle    80104f3f <strncpy+0x4f>
80104f28:	90                   	nop
80104f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f30:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f34:	89 f3                	mov    %esi,%ebx
80104f36:	83 c1 01             	add    $0x1,%ecx
80104f39:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104f3b:	85 db                	test   %ebx,%ebx
80104f3d:	7f f1                	jg     80104f30 <strncpy+0x40>
  return os;
}
80104f3f:	5b                   	pop    %ebx
80104f40:	5e                   	pop    %esi
80104f41:	5d                   	pop    %ebp
80104f42:	c3                   	ret    
80104f43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f50 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	56                   	push   %esi
80104f54:	53                   	push   %ebx
80104f55:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f58:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f5e:	85 c9                	test   %ecx,%ecx
80104f60:	7e 26                	jle    80104f88 <safestrcpy+0x38>
80104f62:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f66:	89 c1                	mov    %eax,%ecx
80104f68:	eb 17                	jmp    80104f81 <safestrcpy+0x31>
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f70:	83 c2 01             	add    $0x1,%edx
80104f73:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104f77:	83 c1 01             	add    $0x1,%ecx
80104f7a:	84 db                	test   %bl,%bl
80104f7c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104f7f:	74 04                	je     80104f85 <safestrcpy+0x35>
80104f81:	39 f2                	cmp    %esi,%edx
80104f83:	75 eb                	jne    80104f70 <safestrcpy+0x20>
    ;
  *s = 0;
80104f85:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104f88:	5b                   	pop    %ebx
80104f89:	5e                   	pop    %esi
80104f8a:	5d                   	pop    %ebp
80104f8b:	c3                   	ret    
80104f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f90 <strlen>:

int
strlen(const char *s)
{
80104f90:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f91:	31 c0                	xor    %eax,%eax
{
80104f93:	89 e5                	mov    %esp,%ebp
80104f95:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104f98:	80 3a 00             	cmpb   $0x0,(%edx)
80104f9b:	74 0c                	je     80104fa9 <strlen+0x19>
80104f9d:	8d 76 00             	lea    0x0(%esi),%esi
80104fa0:	83 c0 01             	add    $0x1,%eax
80104fa3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104fa7:	75 f7                	jne    80104fa0 <strlen+0x10>
    ;
  return n;
}
80104fa9:	5d                   	pop    %ebp
80104faa:	c3                   	ret    

80104fab <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104fab:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104faf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104fb3:	55                   	push   %ebp
  pushl %ebx
80104fb4:	53                   	push   %ebx
  pushl %esi
80104fb5:	56                   	push   %esi
  pushl %edi
80104fb6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104fb7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104fb9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104fbb:	5f                   	pop    %edi
  popl %esi
80104fbc:	5e                   	pop    %esi
  popl %ebx
80104fbd:	5b                   	pop    %ebx
  popl %ebp
80104fbe:	5d                   	pop    %ebp
  ret
80104fbf:	c3                   	ret    

80104fc0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	53                   	push   %ebx
80104fc4:	83 ec 04             	sub    $0x4,%esp
80104fc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104fca:	e8 c1 ee ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fcf:	8b 00                	mov    (%eax),%eax
80104fd1:	39 d8                	cmp    %ebx,%eax
80104fd3:	76 1b                	jbe    80104ff0 <fetchint+0x30>
80104fd5:	8d 53 04             	lea    0x4(%ebx),%edx
80104fd8:	39 d0                	cmp    %edx,%eax
80104fda:	72 14                	jb     80104ff0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104fdc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fdf:	8b 13                	mov    (%ebx),%edx
80104fe1:	89 10                	mov    %edx,(%eax)
  return 0;
80104fe3:	31 c0                	xor    %eax,%eax
}
80104fe5:	83 c4 04             	add    $0x4,%esp
80104fe8:	5b                   	pop    %ebx
80104fe9:	5d                   	pop    %ebp
80104fea:	c3                   	ret    
80104feb:	90                   	nop
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ff0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ff5:	eb ee                	jmp    80104fe5 <fetchint+0x25>
80104ff7:	89 f6                	mov    %esi,%esi
80104ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105000 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	53                   	push   %ebx
80105004:	83 ec 04             	sub    $0x4,%esp
80105007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010500a:	e8 81 ee ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz)
8010500f:	39 18                	cmp    %ebx,(%eax)
80105011:	76 29                	jbe    8010503c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105013:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105016:	89 da                	mov    %ebx,%edx
80105018:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010501a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010501c:	39 c3                	cmp    %eax,%ebx
8010501e:	73 1c                	jae    8010503c <fetchstr+0x3c>
    if(*s == 0)
80105020:	80 3b 00             	cmpb   $0x0,(%ebx)
80105023:	75 10                	jne    80105035 <fetchstr+0x35>
80105025:	eb 39                	jmp    80105060 <fetchstr+0x60>
80105027:	89 f6                	mov    %esi,%esi
80105029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105030:	80 3a 00             	cmpb   $0x0,(%edx)
80105033:	74 1b                	je     80105050 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80105035:	83 c2 01             	add    $0x1,%edx
80105038:	39 d0                	cmp    %edx,%eax
8010503a:	77 f4                	ja     80105030 <fetchstr+0x30>
    return -1;
8010503c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80105041:	83 c4 04             	add    $0x4,%esp
80105044:	5b                   	pop    %ebx
80105045:	5d                   	pop    %ebp
80105046:	c3                   	ret    
80105047:	89 f6                	mov    %esi,%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105050:	83 c4 04             	add    $0x4,%esp
80105053:	89 d0                	mov    %edx,%eax
80105055:	29 d8                	sub    %ebx,%eax
80105057:	5b                   	pop    %ebx
80105058:	5d                   	pop    %ebp
80105059:	c3                   	ret    
8010505a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80105060:	31 c0                	xor    %eax,%eax
      return s - *pp;
80105062:	eb dd                	jmp    80105041 <fetchstr+0x41>
80105064:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010506a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105070 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105070:	55                   	push   %ebp
80105071:	89 e5                	mov    %esp,%ebp
80105073:	56                   	push   %esi
80105074:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105075:	e8 16 ee ff ff       	call   80103e90 <myproc>
8010507a:	8b 40 18             	mov    0x18(%eax),%eax
8010507d:	8b 55 08             	mov    0x8(%ebp),%edx
80105080:	8b 40 44             	mov    0x44(%eax),%eax
80105083:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105086:	e8 05 ee ff ff       	call   80103e90 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010508b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010508d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105090:	39 c6                	cmp    %eax,%esi
80105092:	73 1c                	jae    801050b0 <argint+0x40>
80105094:	8d 53 08             	lea    0x8(%ebx),%edx
80105097:	39 d0                	cmp    %edx,%eax
80105099:	72 15                	jb     801050b0 <argint+0x40>
  *ip = *(int*)(addr);
8010509b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010509e:	8b 53 04             	mov    0x4(%ebx),%edx
801050a1:	89 10                	mov    %edx,(%eax)
  return 0;
801050a3:	31 c0                	xor    %eax,%eax
}
801050a5:	5b                   	pop    %ebx
801050a6:	5e                   	pop    %esi
801050a7:	5d                   	pop    %ebp
801050a8:	c3                   	ret    
801050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801050b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801050b5:	eb ee                	jmp    801050a5 <argint+0x35>
801050b7:	89 f6                	mov    %esi,%esi
801050b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801050c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	56                   	push   %esi
801050c4:	53                   	push   %ebx
801050c5:	83 ec 10             	sub    $0x10,%esp
801050c8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801050cb:	e8 c0 ed ff ff       	call   80103e90 <myproc>
801050d0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801050d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050d5:	83 ec 08             	sub    $0x8,%esp
801050d8:	50                   	push   %eax
801050d9:	ff 75 08             	pushl  0x8(%ebp)
801050dc:	e8 8f ff ff ff       	call   80105070 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801050e1:	83 c4 10             	add    $0x10,%esp
801050e4:	85 c0                	test   %eax,%eax
801050e6:	78 28                	js     80105110 <argptr+0x50>
801050e8:	85 db                	test   %ebx,%ebx
801050ea:	78 24                	js     80105110 <argptr+0x50>
801050ec:	8b 16                	mov    (%esi),%edx
801050ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050f1:	39 c2                	cmp    %eax,%edx
801050f3:	76 1b                	jbe    80105110 <argptr+0x50>
801050f5:	01 c3                	add    %eax,%ebx
801050f7:	39 da                	cmp    %ebx,%edx
801050f9:	72 15                	jb     80105110 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801050fb:	8b 55 0c             	mov    0xc(%ebp),%edx
801050fe:	89 02                	mov    %eax,(%edx)
  return 0;
80105100:	31 c0                	xor    %eax,%eax
}
80105102:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105105:	5b                   	pop    %ebx
80105106:	5e                   	pop    %esi
80105107:	5d                   	pop    %ebp
80105108:	c3                   	ret    
80105109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105115:	eb eb                	jmp    80105102 <argptr+0x42>
80105117:	89 f6                	mov    %esi,%esi
80105119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105120 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105126:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105129:	50                   	push   %eax
8010512a:	ff 75 08             	pushl  0x8(%ebp)
8010512d:	e8 3e ff ff ff       	call   80105070 <argint>
80105132:	83 c4 10             	add    $0x10,%esp
80105135:	85 c0                	test   %eax,%eax
80105137:	78 17                	js     80105150 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105139:	83 ec 08             	sub    $0x8,%esp
8010513c:	ff 75 0c             	pushl  0xc(%ebp)
8010513f:	ff 75 f4             	pushl  -0xc(%ebp)
80105142:	e8 b9 fe ff ff       	call   80105000 <fetchstr>
80105147:	83 c4 10             	add    $0x10,%esp
}
8010514a:	c9                   	leave  
8010514b:	c3                   	ret    
8010514c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105155:	c9                   	leave  
80105156:	c3                   	ret    
80105157:	89 f6                	mov    %esi,%esi
80105159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105160 <syscall>:
[SYS_getNumberOfFreePages] sys_getNumberOfFreePages,
};

void
syscall(void)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	53                   	push   %ebx
80105164:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105167:	e8 24 ed ff ff       	call   80103e90 <myproc>
8010516c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010516e:	8b 40 18             	mov    0x18(%eax),%eax
80105171:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105174:	8d 50 ff             	lea    -0x1(%eax),%edx
80105177:	83 fa 15             	cmp    $0x15,%edx
8010517a:	77 1c                	ja     80105198 <syscall+0x38>
8010517c:	8b 14 85 00 88 10 80 	mov    -0x7fef7800(,%eax,4),%edx
80105183:	85 d2                	test   %edx,%edx
80105185:	74 11                	je     80105198 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105187:	ff d2                	call   *%edx
80105189:	8b 53 18             	mov    0x18(%ebx),%edx
8010518c:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010518f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105192:	c9                   	leave  
80105193:	c3                   	ret    
80105194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105198:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105199:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
8010519c:	50                   	push   %eax
8010519d:	ff 73 10             	pushl  0x10(%ebx)
801051a0:	68 c9 87 10 80       	push   $0x801087c9
801051a5:	e8 b6 b4 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
801051aa:	8b 43 18             	mov    0x18(%ebx),%eax
801051ad:	83 c4 10             	add    $0x10,%esp
801051b0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801051b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051ba:	c9                   	leave  
801051bb:	c3                   	ret    
801051bc:	66 90                	xchg   %ax,%ax
801051be:	66 90                	xchg   %ax,%ax

801051c0 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	56                   	push   %esi
801051c4:	53                   	push   %ebx
801051c5:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801051c7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801051ca:	89 d6                	mov    %edx,%esi
801051cc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801051cf:	50                   	push   %eax
801051d0:	6a 00                	push   $0x0
801051d2:	e8 99 fe ff ff       	call   80105070 <argint>
801051d7:	83 c4 10             	add    $0x10,%esp
801051da:	85 c0                	test   %eax,%eax
801051dc:	78 2a                	js     80105208 <argfd.constprop.0+0x48>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801051de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801051e2:	77 24                	ja     80105208 <argfd.constprop.0+0x48>
801051e4:	e8 a7 ec ff ff       	call   80103e90 <myproc>
801051e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051ec:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801051f0:	85 c0                	test   %eax,%eax
801051f2:	74 14                	je     80105208 <argfd.constprop.0+0x48>
    return -1;
  if(pfd)
801051f4:	85 db                	test   %ebx,%ebx
801051f6:	74 02                	je     801051fa <argfd.constprop.0+0x3a>
    *pfd = fd;
801051f8:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
801051fa:	89 06                	mov    %eax,(%esi)
  return 0;
801051fc:	31 c0                	xor    %eax,%eax
}
801051fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105201:	5b                   	pop    %ebx
80105202:	5e                   	pop    %esi
80105203:	5d                   	pop    %ebp
80105204:	c3                   	ret    
80105205:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010520d:	eb ef                	jmp    801051fe <argfd.constprop.0+0x3e>
8010520f:	90                   	nop

80105210 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105210:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105211:	31 c0                	xor    %eax,%eax
{
80105213:	89 e5                	mov    %esp,%ebp
80105215:	56                   	push   %esi
80105216:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105217:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010521a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010521d:	e8 9e ff ff ff       	call   801051c0 <argfd.constprop.0>
80105222:	85 c0                	test   %eax,%eax
80105224:	78 42                	js     80105268 <sys_dup+0x58>
    return -1;
  if((fd=fdalloc(f)) < 0)
80105226:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105229:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010522b:	e8 60 ec ff ff       	call   80103e90 <myproc>
80105230:	eb 0e                	jmp    80105240 <sys_dup+0x30>
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105238:	83 c3 01             	add    $0x1,%ebx
8010523b:	83 fb 10             	cmp    $0x10,%ebx
8010523e:	74 28                	je     80105268 <sys_dup+0x58>
    if(curproc->ofile[fd] == 0){
80105240:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105244:	85 d2                	test   %edx,%edx
80105246:	75 f0                	jne    80105238 <sys_dup+0x28>
      curproc->ofile[fd] = f;
80105248:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
    return -1;
  filedup(f);
8010524c:	83 ec 0c             	sub    $0xc,%esp
8010524f:	ff 75 f4             	pushl  -0xc(%ebp)
80105252:	e8 19 bc ff ff       	call   80100e70 <filedup>
  return fd;
80105257:	83 c4 10             	add    $0x10,%esp
}
8010525a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010525d:	89 d8                	mov    %ebx,%eax
8010525f:	5b                   	pop    %ebx
80105260:	5e                   	pop    %esi
80105261:	5d                   	pop    %ebp
80105262:	c3                   	ret    
80105263:	90                   	nop
80105264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105268:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010526b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105270:	89 d8                	mov    %ebx,%eax
80105272:	5b                   	pop    %ebx
80105273:	5e                   	pop    %esi
80105274:	5d                   	pop    %ebp
80105275:	c3                   	ret    
80105276:	8d 76 00             	lea    0x0(%esi),%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <sys_read>:

int
sys_read(void)
{
80105280:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105281:	31 c0                	xor    %eax,%eax
{
80105283:	89 e5                	mov    %esp,%ebp
80105285:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105288:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010528b:	e8 30 ff ff ff       	call   801051c0 <argfd.constprop.0>
80105290:	85 c0                	test   %eax,%eax
80105292:	78 4c                	js     801052e0 <sys_read+0x60>
80105294:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105297:	83 ec 08             	sub    $0x8,%esp
8010529a:	50                   	push   %eax
8010529b:	6a 02                	push   $0x2
8010529d:	e8 ce fd ff ff       	call   80105070 <argint>
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	85 c0                	test   %eax,%eax
801052a7:	78 37                	js     801052e0 <sys_read+0x60>
801052a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052ac:	83 ec 04             	sub    $0x4,%esp
801052af:	ff 75 f0             	pushl  -0x10(%ebp)
801052b2:	50                   	push   %eax
801052b3:	6a 01                	push   $0x1
801052b5:	e8 06 fe ff ff       	call   801050c0 <argptr>
801052ba:	83 c4 10             	add    $0x10,%esp
801052bd:	85 c0                	test   %eax,%eax
801052bf:	78 1f                	js     801052e0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801052c1:	83 ec 04             	sub    $0x4,%esp
801052c4:	ff 75 f0             	pushl  -0x10(%ebp)
801052c7:	ff 75 f4             	pushl  -0xc(%ebp)
801052ca:	ff 75 ec             	pushl  -0x14(%ebp)
801052cd:	e8 0e bd ff ff       	call   80100fe0 <fileread>
801052d2:	83 c4 10             	add    $0x10,%esp
}
801052d5:	c9                   	leave  
801052d6:	c3                   	ret    
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801052e5:	c9                   	leave  
801052e6:	c3                   	ret    
801052e7:	89 f6                	mov    %esi,%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <sys_write>:

int
sys_write(void)
{
801052f0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052f1:	31 c0                	xor    %eax,%eax
{
801052f3:	89 e5                	mov    %esp,%ebp
801052f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801052f8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801052fb:	e8 c0 fe ff ff       	call   801051c0 <argfd.constprop.0>
80105300:	85 c0                	test   %eax,%eax
80105302:	78 4c                	js     80105350 <sys_write+0x60>
80105304:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105307:	83 ec 08             	sub    $0x8,%esp
8010530a:	50                   	push   %eax
8010530b:	6a 02                	push   $0x2
8010530d:	e8 5e fd ff ff       	call   80105070 <argint>
80105312:	83 c4 10             	add    $0x10,%esp
80105315:	85 c0                	test   %eax,%eax
80105317:	78 37                	js     80105350 <sys_write+0x60>
80105319:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010531c:	83 ec 04             	sub    $0x4,%esp
8010531f:	ff 75 f0             	pushl  -0x10(%ebp)
80105322:	50                   	push   %eax
80105323:	6a 01                	push   $0x1
80105325:	e8 96 fd ff ff       	call   801050c0 <argptr>
8010532a:	83 c4 10             	add    $0x10,%esp
8010532d:	85 c0                	test   %eax,%eax
8010532f:	78 1f                	js     80105350 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105331:	83 ec 04             	sub    $0x4,%esp
80105334:	ff 75 f0             	pushl  -0x10(%ebp)
80105337:	ff 75 f4             	pushl  -0xc(%ebp)
8010533a:	ff 75 ec             	pushl  -0x14(%ebp)
8010533d:	e8 2e bd ff ff       	call   80101070 <filewrite>
80105342:	83 c4 10             	add    $0x10,%esp
}
80105345:	c9                   	leave  
80105346:	c3                   	ret    
80105347:	89 f6                	mov    %esi,%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105355:	c9                   	leave  
80105356:	c3                   	ret    
80105357:	89 f6                	mov    %esi,%esi
80105359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105360 <sys_close>:

int
sys_close(void)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105366:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105369:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010536c:	e8 4f fe ff ff       	call   801051c0 <argfd.constprop.0>
80105371:	85 c0                	test   %eax,%eax
80105373:	78 2b                	js     801053a0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105375:	e8 16 eb ff ff       	call   80103e90 <myproc>
8010537a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
8010537d:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105380:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105387:	00 
  fileclose(f);
80105388:	ff 75 f4             	pushl  -0xc(%ebp)
8010538b:	e8 30 bb ff ff       	call   80100ec0 <fileclose>
  return 0;
80105390:	83 c4 10             	add    $0x10,%esp
80105393:	31 c0                	xor    %eax,%eax
}
80105395:	c9                   	leave  
80105396:	c3                   	ret    
80105397:	89 f6                	mov    %esi,%esi
80105399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801053a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053a5:	c9                   	leave  
801053a6:	c3                   	ret    
801053a7:	89 f6                	mov    %esi,%esi
801053a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053b0 <sys_fstat>:

int
sys_fstat(void)
{
801053b0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053b1:	31 c0                	xor    %eax,%eax
{
801053b3:	89 e5                	mov    %esp,%ebp
801053b5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801053b8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801053bb:	e8 00 fe ff ff       	call   801051c0 <argfd.constprop.0>
801053c0:	85 c0                	test   %eax,%eax
801053c2:	78 2c                	js     801053f0 <sys_fstat+0x40>
801053c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053c7:	83 ec 04             	sub    $0x4,%esp
801053ca:	6a 14                	push   $0x14
801053cc:	50                   	push   %eax
801053cd:	6a 01                	push   $0x1
801053cf:	e8 ec fc ff ff       	call   801050c0 <argptr>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	78 15                	js     801053f0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
801053db:	83 ec 08             	sub    $0x8,%esp
801053de:	ff 75 f4             	pushl  -0xc(%ebp)
801053e1:	ff 75 f0             	pushl  -0x10(%ebp)
801053e4:	e8 a7 bb ff ff       	call   80100f90 <filestat>
801053e9:	83 c4 10             	add    $0x10,%esp
}
801053ec:	c9                   	leave  
801053ed:	c3                   	ret    
801053ee:	66 90                	xchg   %ax,%ax
    return -1;
801053f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053f5:	c9                   	leave  
801053f6:	c3                   	ret    
801053f7:	89 f6                	mov    %esi,%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105406:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105409:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010540c:	50                   	push   %eax
8010540d:	6a 00                	push   $0x0
8010540f:	e8 0c fd ff ff       	call   80105120 <argstr>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	0f 88 fb 00 00 00    	js     8010551a <sys_link+0x11a>
8010541f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105422:	83 ec 08             	sub    $0x8,%esp
80105425:	50                   	push   %eax
80105426:	6a 01                	push   $0x1
80105428:	e8 f3 fc ff ff       	call   80105120 <argstr>
8010542d:	83 c4 10             	add    $0x10,%esp
80105430:	85 c0                	test   %eax,%eax
80105432:	0f 88 e2 00 00 00    	js     8010551a <sys_link+0x11a>
    return -1;

  begin_op();
80105438:	e8 73 dd ff ff       	call   801031b0 <begin_op>
  if((ip = namei(old)) == 0){
8010543d:	83 ec 0c             	sub    $0xc,%esp
80105440:	ff 75 d4             	pushl  -0x2c(%ebp)
80105443:	e8 18 cb ff ff       	call   80101f60 <namei>
80105448:	83 c4 10             	add    $0x10,%esp
8010544b:	85 c0                	test   %eax,%eax
8010544d:	89 c3                	mov    %eax,%ebx
8010544f:	0f 84 ea 00 00 00    	je     8010553f <sys_link+0x13f>
    end_op();
    return -1;
  }

  ilock(ip);
80105455:	83 ec 0c             	sub    $0xc,%esp
80105458:	50                   	push   %eax
80105459:	e8 a2 c2 ff ff       	call   80101700 <ilock>
  if(ip->type == T_DIR){
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105466:	0f 84 bb 00 00 00    	je     80105527 <sys_link+0x127>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010546c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105471:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105474:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105477:	53                   	push   %ebx
80105478:	e8 d3 c1 ff ff       	call   80101650 <iupdate>
  iunlock(ip);
8010547d:	89 1c 24             	mov    %ebx,(%esp)
80105480:	e8 5b c3 ff ff       	call   801017e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105485:	58                   	pop    %eax
80105486:	5a                   	pop    %edx
80105487:	57                   	push   %edi
80105488:	ff 75 d0             	pushl  -0x30(%ebp)
8010548b:	e8 f0 ca ff ff       	call   80101f80 <nameiparent>
80105490:	83 c4 10             	add    $0x10,%esp
80105493:	85 c0                	test   %eax,%eax
80105495:	89 c6                	mov    %eax,%esi
80105497:	74 5b                	je     801054f4 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105499:	83 ec 0c             	sub    $0xc,%esp
8010549c:	50                   	push   %eax
8010549d:	e8 5e c2 ff ff       	call   80101700 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	8b 03                	mov    (%ebx),%eax
801054a7:	39 06                	cmp    %eax,(%esi)
801054a9:	75 3d                	jne    801054e8 <sys_link+0xe8>
801054ab:	83 ec 04             	sub    $0x4,%esp
801054ae:	ff 73 04             	pushl  0x4(%ebx)
801054b1:	57                   	push   %edi
801054b2:	56                   	push   %esi
801054b3:	e8 e8 c9 ff ff       	call   80101ea0 <dirlink>
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	85 c0                	test   %eax,%eax
801054bd:	78 29                	js     801054e8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
801054bf:	83 ec 0c             	sub    $0xc,%esp
801054c2:	56                   	push   %esi
801054c3:	e8 c8 c4 ff ff       	call   80101990 <iunlockput>
  iput(ip);
801054c8:	89 1c 24             	mov    %ebx,(%esp)
801054cb:	e8 60 c3 ff ff       	call   80101830 <iput>

  end_op();
801054d0:	e8 4b dd ff ff       	call   80103220 <end_op>

  return 0;
801054d5:	83 c4 10             	add    $0x10,%esp
801054d8:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801054da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054dd:	5b                   	pop    %ebx
801054de:	5e                   	pop    %esi
801054df:	5f                   	pop    %edi
801054e0:	5d                   	pop    %ebp
801054e1:	c3                   	ret    
801054e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801054e8:	83 ec 0c             	sub    $0xc,%esp
801054eb:	56                   	push   %esi
801054ec:	e8 9f c4 ff ff       	call   80101990 <iunlockput>
    goto bad;
801054f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801054f4:	83 ec 0c             	sub    $0xc,%esp
801054f7:	53                   	push   %ebx
801054f8:	e8 03 c2 ff ff       	call   80101700 <ilock>
  ip->nlink--;
801054fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105502:	89 1c 24             	mov    %ebx,(%esp)
80105505:	e8 46 c1 ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
8010550a:	89 1c 24             	mov    %ebx,(%esp)
8010550d:	e8 7e c4 ff ff       	call   80101990 <iunlockput>
  end_op();
80105512:	e8 09 dd ff ff       	call   80103220 <end_op>
  return -1;
80105517:	83 c4 10             	add    $0x10,%esp
}
8010551a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010551d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105522:	5b                   	pop    %ebx
80105523:	5e                   	pop    %esi
80105524:	5f                   	pop    %edi
80105525:	5d                   	pop    %ebp
80105526:	c3                   	ret    
    iunlockput(ip);
80105527:	83 ec 0c             	sub    $0xc,%esp
8010552a:	53                   	push   %ebx
8010552b:	e8 60 c4 ff ff       	call   80101990 <iunlockput>
    end_op();
80105530:	e8 eb dc ff ff       	call   80103220 <end_op>
    return -1;
80105535:	83 c4 10             	add    $0x10,%esp
80105538:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553d:	eb 9b                	jmp    801054da <sys_link+0xda>
    end_op();
8010553f:	e8 dc dc ff ff       	call   80103220 <end_op>
    return -1;
80105544:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105549:	eb 8f                	jmp    801054da <sys_link+0xda>
8010554b:	90                   	nop
8010554c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105550 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
int
isdirempty(struct inode *dp)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	56                   	push   %esi
80105555:	53                   	push   %ebx
80105556:	83 ec 1c             	sub    $0x1c,%esp
80105559:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
8010555c:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80105560:	76 3e                	jbe    801055a0 <isdirempty+0x50>
80105562:	bb 20 00 00 00       	mov    $0x20,%ebx
80105567:	8d 7d d8             	lea    -0x28(%ebp),%edi
8010556a:	eb 0c                	jmp    80105578 <isdirempty+0x28>
8010556c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105570:	83 c3 10             	add    $0x10,%ebx
80105573:	3b 5e 58             	cmp    0x58(%esi),%ebx
80105576:	73 28                	jae    801055a0 <isdirempty+0x50>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105578:	6a 10                	push   $0x10
8010557a:	53                   	push   %ebx
8010557b:	57                   	push   %edi
8010557c:	56                   	push   %esi
8010557d:	e8 5e c4 ff ff       	call   801019e0 <readi>
80105582:	83 c4 10             	add    $0x10,%esp
80105585:	83 f8 10             	cmp    $0x10,%eax
80105588:	75 23                	jne    801055ad <isdirempty+0x5d>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010558a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010558f:	74 df                	je     80105570 <isdirempty+0x20>
      return 0;
  }
  return 1;
}
80105591:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80105594:	31 c0                	xor    %eax,%eax
}
80105596:	5b                   	pop    %ebx
80105597:	5e                   	pop    %esi
80105598:	5f                   	pop    %edi
80105599:	5d                   	pop    %ebp
8010559a:	c3                   	ret    
8010559b:	90                   	nop
8010559c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801055a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
801055a3:	b8 01 00 00 00       	mov    $0x1,%eax
}
801055a8:	5b                   	pop    %ebx
801055a9:	5e                   	pop    %esi
801055aa:	5f                   	pop    %edi
801055ab:	5d                   	pop    %ebp
801055ac:	c3                   	ret    
      panic("isdirempty: readi");
801055ad:	83 ec 0c             	sub    $0xc,%esp
801055b0:	68 5c 88 10 80       	push   $0x8010885c
801055b5:	e8 d6 ad ff ff       	call   80100390 <panic>
801055ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801055c0 <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	57                   	push   %edi
801055c4:	56                   	push   %esi
801055c5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801055c6:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801055c9:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
801055cc:	50                   	push   %eax
801055cd:	6a 00                	push   $0x0
801055cf:	e8 4c fb ff ff       	call   80105120 <argstr>
801055d4:	83 c4 10             	add    $0x10,%esp
801055d7:	85 c0                	test   %eax,%eax
801055d9:	0f 88 51 01 00 00    	js     80105730 <sys_unlink+0x170>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
801055df:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801055e2:	e8 c9 db ff ff       	call   801031b0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801055e7:	83 ec 08             	sub    $0x8,%esp
801055ea:	53                   	push   %ebx
801055eb:	ff 75 c0             	pushl  -0x40(%ebp)
801055ee:	e8 8d c9 ff ff       	call   80101f80 <nameiparent>
801055f3:	83 c4 10             	add    $0x10,%esp
801055f6:	85 c0                	test   %eax,%eax
801055f8:	89 c6                	mov    %eax,%esi
801055fa:	0f 84 37 01 00 00    	je     80105737 <sys_unlink+0x177>
    end_op();
    return -1;
  }

  ilock(dp);
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	50                   	push   %eax
80105604:	e8 f7 c0 ff ff       	call   80101700 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105609:	58                   	pop    %eax
8010560a:	5a                   	pop    %edx
8010560b:	68 bd 81 10 80       	push   $0x801081bd
80105610:	53                   	push   %ebx
80105611:	e8 fa c5 ff ff       	call   80101c10 <namecmp>
80105616:	83 c4 10             	add    $0x10,%esp
80105619:	85 c0                	test   %eax,%eax
8010561b:	0f 84 d7 00 00 00    	je     801056f8 <sys_unlink+0x138>
80105621:	83 ec 08             	sub    $0x8,%esp
80105624:	68 bc 81 10 80       	push   $0x801081bc
80105629:	53                   	push   %ebx
8010562a:	e8 e1 c5 ff ff       	call   80101c10 <namecmp>
8010562f:	83 c4 10             	add    $0x10,%esp
80105632:	85 c0                	test   %eax,%eax
80105634:	0f 84 be 00 00 00    	je     801056f8 <sys_unlink+0x138>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010563a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010563d:	83 ec 04             	sub    $0x4,%esp
80105640:	50                   	push   %eax
80105641:	53                   	push   %ebx
80105642:	56                   	push   %esi
80105643:	e8 e8 c5 ff ff       	call   80101c30 <dirlookup>
80105648:	83 c4 10             	add    $0x10,%esp
8010564b:	85 c0                	test   %eax,%eax
8010564d:	89 c3                	mov    %eax,%ebx
8010564f:	0f 84 a3 00 00 00    	je     801056f8 <sys_unlink+0x138>
    goto bad;
  ilock(ip);
80105655:	83 ec 0c             	sub    $0xc,%esp
80105658:	50                   	push   %eax
80105659:	e8 a2 c0 ff ff       	call   80101700 <ilock>

  if(ip->nlink < 1)
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105666:	0f 8e e4 00 00 00    	jle    80105750 <sys_unlink+0x190>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
8010566c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105671:	74 65                	je     801056d8 <sys_unlink+0x118>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105673:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105676:	83 ec 04             	sub    $0x4,%esp
80105679:	6a 10                	push   $0x10
8010567b:	6a 00                	push   $0x0
8010567d:	57                   	push   %edi
8010567e:	e8 ed f6 ff ff       	call   80104d70 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105683:	6a 10                	push   $0x10
80105685:	ff 75 c4             	pushl  -0x3c(%ebp)
80105688:	57                   	push   %edi
80105689:	56                   	push   %esi
8010568a:	e8 51 c4 ff ff       	call   80101ae0 <writei>
8010568f:	83 c4 20             	add    $0x20,%esp
80105692:	83 f8 10             	cmp    $0x10,%eax
80105695:	0f 85 a8 00 00 00    	jne    80105743 <sys_unlink+0x183>
    panic("unlink: writei");
  if(ip->type == T_DIR){
8010569b:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056a0:	74 6e                	je     80105710 <sys_unlink+0x150>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801056a2:	83 ec 0c             	sub    $0xc,%esp
801056a5:	56                   	push   %esi
801056a6:	e8 e5 c2 ff ff       	call   80101990 <iunlockput>

  ip->nlink--;
801056ab:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801056b0:	89 1c 24             	mov    %ebx,(%esp)
801056b3:	e8 98 bf ff ff       	call   80101650 <iupdate>
  iunlockput(ip);
801056b8:	89 1c 24             	mov    %ebx,(%esp)
801056bb:	e8 d0 c2 ff ff       	call   80101990 <iunlockput>

  end_op();
801056c0:	e8 5b db ff ff       	call   80103220 <end_op>

  return 0;
801056c5:	83 c4 10             	add    $0x10,%esp
801056c8:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
801056ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056cd:	5b                   	pop    %ebx
801056ce:	5e                   	pop    %esi
801056cf:	5f                   	pop    %edi
801056d0:	5d                   	pop    %ebp
801056d1:	c3                   	ret    
801056d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(ip->type == T_DIR && !isdirempty(ip)){
801056d8:	83 ec 0c             	sub    $0xc,%esp
801056db:	53                   	push   %ebx
801056dc:	e8 6f fe ff ff       	call   80105550 <isdirempty>
801056e1:	83 c4 10             	add    $0x10,%esp
801056e4:	85 c0                	test   %eax,%eax
801056e6:	75 8b                	jne    80105673 <sys_unlink+0xb3>
    iunlockput(ip);
801056e8:	83 ec 0c             	sub    $0xc,%esp
801056eb:	53                   	push   %ebx
801056ec:	e8 9f c2 ff ff       	call   80101990 <iunlockput>
    goto bad;
801056f1:	83 c4 10             	add    $0x10,%esp
801056f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlockput(dp);
801056f8:	83 ec 0c             	sub    $0xc,%esp
801056fb:	56                   	push   %esi
801056fc:	e8 8f c2 ff ff       	call   80101990 <iunlockput>
  end_op();
80105701:	e8 1a db ff ff       	call   80103220 <end_op>
  return -1;
80105706:	83 c4 10             	add    $0x10,%esp
80105709:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010570e:	eb ba                	jmp    801056ca <sys_unlink+0x10a>
    dp->nlink--;
80105710:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105715:	83 ec 0c             	sub    $0xc,%esp
80105718:	56                   	push   %esi
80105719:	e8 32 bf ff ff       	call   80101650 <iupdate>
8010571e:	83 c4 10             	add    $0x10,%esp
80105721:	e9 7c ff ff ff       	jmp    801056a2 <sys_unlink+0xe2>
80105726:	8d 76 00             	lea    0x0(%esi),%esi
80105729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105735:	eb 93                	jmp    801056ca <sys_unlink+0x10a>
    end_op();
80105737:	e8 e4 da ff ff       	call   80103220 <end_op>
    return -1;
8010573c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105741:	eb 87                	jmp    801056ca <sys_unlink+0x10a>
    panic("unlink: writei");
80105743:	83 ec 0c             	sub    $0xc,%esp
80105746:	68 d1 81 10 80       	push   $0x801081d1
8010574b:	e8 40 ac ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105750:	83 ec 0c             	sub    $0xc,%esp
80105753:	68 bf 81 10 80       	push   $0x801081bf
80105758:	e8 33 ac ff ff       	call   80100390 <panic>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi

80105760 <create>:

struct inode*
create(char *path, short type, short major, short minor)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
80105765:	53                   	push   %ebx
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105766:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80105769:	83 ec 34             	sub    $0x34,%esp
8010576c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010576f:	8b 55 10             	mov    0x10(%ebp),%edx
80105772:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105775:	56                   	push   %esi
80105776:	ff 75 08             	pushl  0x8(%ebp)
{
80105779:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010577c:	89 55 d0             	mov    %edx,-0x30(%ebp)
8010577f:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105782:	e8 f9 c7 ff ff       	call   80101f80 <nameiparent>
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	85 c0                	test   %eax,%eax
8010578c:	0f 84 4e 01 00 00    	je     801058e0 <create+0x180>
    return 0;
  ilock(dp);
80105792:	83 ec 0c             	sub    $0xc,%esp
80105795:	89 c3                	mov    %eax,%ebx
80105797:	50                   	push   %eax
80105798:	e8 63 bf ff ff       	call   80101700 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
8010579d:	83 c4 0c             	add    $0xc,%esp
801057a0:	6a 00                	push   $0x0
801057a2:	56                   	push   %esi
801057a3:	53                   	push   %ebx
801057a4:	e8 87 c4 ff ff       	call   80101c30 <dirlookup>
801057a9:	83 c4 10             	add    $0x10,%esp
801057ac:	85 c0                	test   %eax,%eax
801057ae:	89 c7                	mov    %eax,%edi
801057b0:	74 3e                	je     801057f0 <create+0x90>
    iunlockput(dp);
801057b2:	83 ec 0c             	sub    $0xc,%esp
801057b5:	53                   	push   %ebx
801057b6:	e8 d5 c1 ff ff       	call   80101990 <iunlockput>
    ilock(ip);
801057bb:	89 3c 24             	mov    %edi,(%esp)
801057be:	e8 3d bf ff ff       	call   80101700 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801057c3:	83 c4 10             	add    $0x10,%esp
801057c6:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801057cb:	0f 85 9f 00 00 00    	jne    80105870 <create+0x110>
801057d1:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
801057d6:	0f 85 94 00 00 00    	jne    80105870 <create+0x110>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801057dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057df:	89 f8                	mov    %edi,%eax
801057e1:	5b                   	pop    %ebx
801057e2:	5e                   	pop    %esi
801057e3:	5f                   	pop    %edi
801057e4:	5d                   	pop    %ebp
801057e5:	c3                   	ret    
801057e6:	8d 76 00             	lea    0x0(%esi),%esi
801057e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if((ip = ialloc(dp->dev, type)) == 0)
801057f0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801057f4:	83 ec 08             	sub    $0x8,%esp
801057f7:	50                   	push   %eax
801057f8:	ff 33                	pushl  (%ebx)
801057fa:	e8 91 bd ff ff       	call   80101590 <ialloc>
801057ff:	83 c4 10             	add    $0x10,%esp
80105802:	85 c0                	test   %eax,%eax
80105804:	89 c7                	mov    %eax,%edi
80105806:	0f 84 e8 00 00 00    	je     801058f4 <create+0x194>
  ilock(ip);
8010580c:	83 ec 0c             	sub    $0xc,%esp
8010580f:	50                   	push   %eax
80105810:	e8 eb be ff ff       	call   80101700 <ilock>
  ip->major = major;
80105815:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105819:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
8010581d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105821:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80105825:	b8 01 00 00 00       	mov    $0x1,%eax
8010582a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
8010582e:	89 3c 24             	mov    %edi,(%esp)
80105831:	e8 1a be ff ff       	call   80101650 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105836:	83 c4 10             	add    $0x10,%esp
80105839:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010583e:	74 50                	je     80105890 <create+0x130>
  if(dirlink(dp, name, ip->inum) < 0)
80105840:	83 ec 04             	sub    $0x4,%esp
80105843:	ff 77 04             	pushl  0x4(%edi)
80105846:	56                   	push   %esi
80105847:	53                   	push   %ebx
80105848:	e8 53 c6 ff ff       	call   80101ea0 <dirlink>
8010584d:	83 c4 10             	add    $0x10,%esp
80105850:	85 c0                	test   %eax,%eax
80105852:	0f 88 8f 00 00 00    	js     801058e7 <create+0x187>
  iunlockput(dp);
80105858:	83 ec 0c             	sub    $0xc,%esp
8010585b:	53                   	push   %ebx
8010585c:	e8 2f c1 ff ff       	call   80101990 <iunlockput>
  return ip;
80105861:	83 c4 10             	add    $0x10,%esp
}
80105864:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105867:	89 f8                	mov    %edi,%eax
80105869:	5b                   	pop    %ebx
8010586a:	5e                   	pop    %esi
8010586b:	5f                   	pop    %edi
8010586c:	5d                   	pop    %ebp
8010586d:	c3                   	ret    
8010586e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105870:	83 ec 0c             	sub    $0xc,%esp
80105873:	57                   	push   %edi
    return 0;
80105874:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80105876:	e8 15 c1 ff ff       	call   80101990 <iunlockput>
    return 0;
8010587b:	83 c4 10             	add    $0x10,%esp
}
8010587e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105881:	89 f8                	mov    %edi,%eax
80105883:	5b                   	pop    %ebx
80105884:	5e                   	pop    %esi
80105885:	5f                   	pop    %edi
80105886:	5d                   	pop    %ebp
80105887:	c3                   	ret    
80105888:	90                   	nop
80105889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80105890:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105895:	83 ec 0c             	sub    $0xc,%esp
80105898:	53                   	push   %ebx
80105899:	e8 b2 bd ff ff       	call   80101650 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010589e:	83 c4 0c             	add    $0xc,%esp
801058a1:	ff 77 04             	pushl  0x4(%edi)
801058a4:	68 bd 81 10 80       	push   $0x801081bd
801058a9:	57                   	push   %edi
801058aa:	e8 f1 c5 ff ff       	call   80101ea0 <dirlink>
801058af:	83 c4 10             	add    $0x10,%esp
801058b2:	85 c0                	test   %eax,%eax
801058b4:	78 1c                	js     801058d2 <create+0x172>
801058b6:	83 ec 04             	sub    $0x4,%esp
801058b9:	ff 73 04             	pushl  0x4(%ebx)
801058bc:	68 bc 81 10 80       	push   $0x801081bc
801058c1:	57                   	push   %edi
801058c2:	e8 d9 c5 ff ff       	call   80101ea0 <dirlink>
801058c7:	83 c4 10             	add    $0x10,%esp
801058ca:	85 c0                	test   %eax,%eax
801058cc:	0f 89 6e ff ff ff    	jns    80105840 <create+0xe0>
      panic("create dots");
801058d2:	83 ec 0c             	sub    $0xc,%esp
801058d5:	68 7d 88 10 80       	push   $0x8010887d
801058da:	e8 b1 aa ff ff       	call   80100390 <panic>
801058df:	90                   	nop
    return 0;
801058e0:	31 ff                	xor    %edi,%edi
801058e2:	e9 f5 fe ff ff       	jmp    801057dc <create+0x7c>
    panic("create: dirlink");
801058e7:	83 ec 0c             	sub    $0xc,%esp
801058ea:	68 89 88 10 80       	push   $0x80108889
801058ef:	e8 9c aa ff ff       	call   80100390 <panic>
    panic("create: ialloc");
801058f4:	83 ec 0c             	sub    $0xc,%esp
801058f7:	68 6e 88 10 80       	push   $0x8010886e
801058fc:	e8 8f aa ff ff       	call   80100390 <panic>
80105901:	eb 0d                	jmp    80105910 <sys_open>
80105903:	90                   	nop
80105904:	90                   	nop
80105905:	90                   	nop
80105906:	90                   	nop
80105907:	90                   	nop
80105908:	90                   	nop
80105909:	90                   	nop
8010590a:	90                   	nop
8010590b:	90                   	nop
8010590c:	90                   	nop
8010590d:	90                   	nop
8010590e:	90                   	nop
8010590f:	90                   	nop

80105910 <sys_open>:

int
sys_open(void)
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	57                   	push   %edi
80105914:	56                   	push   %esi
80105915:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105916:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105919:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010591c:	50                   	push   %eax
8010591d:	6a 00                	push   $0x0
8010591f:	e8 fc f7 ff ff       	call   80105120 <argstr>
80105924:	83 c4 10             	add    $0x10,%esp
80105927:	85 c0                	test   %eax,%eax
80105929:	0f 88 1d 01 00 00    	js     80105a4c <sys_open+0x13c>
8010592f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105932:	83 ec 08             	sub    $0x8,%esp
80105935:	50                   	push   %eax
80105936:	6a 01                	push   $0x1
80105938:	e8 33 f7 ff ff       	call   80105070 <argint>
8010593d:	83 c4 10             	add    $0x10,%esp
80105940:	85 c0                	test   %eax,%eax
80105942:	0f 88 04 01 00 00    	js     80105a4c <sys_open+0x13c>
    return -1;

  begin_op();
80105948:	e8 63 d8 ff ff       	call   801031b0 <begin_op>

  if(omode & O_CREATE){
8010594d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105951:	0f 85 a9 00 00 00    	jne    80105a00 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105957:	83 ec 0c             	sub    $0xc,%esp
8010595a:	ff 75 e0             	pushl  -0x20(%ebp)
8010595d:	e8 fe c5 ff ff       	call   80101f60 <namei>
80105962:	83 c4 10             	add    $0x10,%esp
80105965:	85 c0                	test   %eax,%eax
80105967:	89 c6                	mov    %eax,%esi
80105969:	0f 84 ac 00 00 00    	je     80105a1b <sys_open+0x10b>
      end_op();
      return -1;
    }
    ilock(ip);
8010596f:	83 ec 0c             	sub    $0xc,%esp
80105972:	50                   	push   %eax
80105973:	e8 88 bd ff ff       	call   80101700 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105978:	83 c4 10             	add    $0x10,%esp
8010597b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105980:	0f 84 aa 00 00 00    	je     80105a30 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105986:	e8 75 b4 ff ff       	call   80100e00 <filealloc>
8010598b:	85 c0                	test   %eax,%eax
8010598d:	89 c7                	mov    %eax,%edi
8010598f:	0f 84 a6 00 00 00    	je     80105a3b <sys_open+0x12b>
  struct proc *curproc = myproc();
80105995:	e8 f6 e4 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010599a:	31 db                	xor    %ebx,%ebx
8010599c:	eb 0e                	jmp    801059ac <sys_open+0x9c>
8010599e:	66 90                	xchg   %ax,%ax
801059a0:	83 c3 01             	add    $0x1,%ebx
801059a3:	83 fb 10             	cmp    $0x10,%ebx
801059a6:	0f 84 ac 00 00 00    	je     80105a58 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
801059ac:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801059b0:	85 d2                	test   %edx,%edx
801059b2:	75 ec                	jne    801059a0 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059b4:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801059b7:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801059bb:	56                   	push   %esi
801059bc:	e8 1f be ff ff       	call   801017e0 <iunlock>
  end_op();
801059c1:	e8 5a d8 ff ff       	call   80103220 <end_op>

  f->type = FD_INODE;
801059c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059cf:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801059d2:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801059d5:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801059dc:	89 d0                	mov    %edx,%eax
801059de:	f7 d0                	not    %eax
801059e0:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059e3:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801059e6:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059e9:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801059ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059f0:	89 d8                	mov    %ebx,%eax
801059f2:	5b                   	pop    %ebx
801059f3:	5e                   	pop    %esi
801059f4:	5f                   	pop    %edi
801059f5:	5d                   	pop    %ebp
801059f6:	c3                   	ret    
801059f7:	89 f6                	mov    %esi,%esi
801059f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ip = create(path, T_FILE, 0, 0);
80105a00:	6a 00                	push   $0x0
80105a02:	6a 00                	push   $0x0
80105a04:	6a 02                	push   $0x2
80105a06:	ff 75 e0             	pushl  -0x20(%ebp)
80105a09:	e8 52 fd ff ff       	call   80105760 <create>
    if(ip == 0){
80105a0e:	83 c4 10             	add    $0x10,%esp
80105a11:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105a13:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105a15:	0f 85 6b ff ff ff    	jne    80105986 <sys_open+0x76>
      end_op();
80105a1b:	e8 00 d8 ff ff       	call   80103220 <end_op>
      return -1;
80105a20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a25:	eb c6                	jmp    801059ed <sys_open+0xdd>
80105a27:	89 f6                	mov    %esi,%esi
80105a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105a33:	85 c9                	test   %ecx,%ecx
80105a35:	0f 84 4b ff ff ff    	je     80105986 <sys_open+0x76>
    iunlockput(ip);
80105a3b:	83 ec 0c             	sub    $0xc,%esp
80105a3e:	56                   	push   %esi
80105a3f:	e8 4c bf ff ff       	call   80101990 <iunlockput>
    end_op();
80105a44:	e8 d7 d7 ff ff       	call   80103220 <end_op>
    return -1;
80105a49:	83 c4 10             	add    $0x10,%esp
80105a4c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105a51:	eb 9a                	jmp    801059ed <sys_open+0xdd>
80105a53:	90                   	nop
80105a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
80105a58:	83 ec 0c             	sub    $0xc,%esp
80105a5b:	57                   	push   %edi
80105a5c:	e8 5f b4 ff ff       	call   80100ec0 <fileclose>
80105a61:	83 c4 10             	add    $0x10,%esp
80105a64:	eb d5                	jmp    80105a3b <sys_open+0x12b>
80105a66:	8d 76 00             	lea    0x0(%esi),%esi
80105a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a70 <sys_mkdir>:

int
sys_mkdir(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a76:	e8 35 d7 ff ff       	call   801031b0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105a7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a7e:	83 ec 08             	sub    $0x8,%esp
80105a81:	50                   	push   %eax
80105a82:	6a 00                	push   $0x0
80105a84:	e8 97 f6 ff ff       	call   80105120 <argstr>
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	85 c0                	test   %eax,%eax
80105a8e:	78 30                	js     80105ac0 <sys_mkdir+0x50>
80105a90:	6a 00                	push   $0x0
80105a92:	6a 00                	push   $0x0
80105a94:	6a 01                	push   $0x1
80105a96:	ff 75 f4             	pushl  -0xc(%ebp)
80105a99:	e8 c2 fc ff ff       	call   80105760 <create>
80105a9e:	83 c4 10             	add    $0x10,%esp
80105aa1:	85 c0                	test   %eax,%eax
80105aa3:	74 1b                	je     80105ac0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105aa5:	83 ec 0c             	sub    $0xc,%esp
80105aa8:	50                   	push   %eax
80105aa9:	e8 e2 be ff ff       	call   80101990 <iunlockput>
  end_op();
80105aae:	e8 6d d7 ff ff       	call   80103220 <end_op>
  return 0;
80105ab3:	83 c4 10             	add    $0x10,%esp
80105ab6:	31 c0                	xor    %eax,%eax
}
80105ab8:	c9                   	leave  
80105ab9:	c3                   	ret    
80105aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105ac0:	e8 5b d7 ff ff       	call   80103220 <end_op>
    return -1;
80105ac5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105aca:	c9                   	leave  
80105acb:	c3                   	ret    
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_mknod>:

int
sys_mknod(void)
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105ad6:	e8 d5 d6 ff ff       	call   801031b0 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105adb:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ade:	83 ec 08             	sub    $0x8,%esp
80105ae1:	50                   	push   %eax
80105ae2:	6a 00                	push   $0x0
80105ae4:	e8 37 f6 ff ff       	call   80105120 <argstr>
80105ae9:	83 c4 10             	add    $0x10,%esp
80105aec:	85 c0                	test   %eax,%eax
80105aee:	78 60                	js     80105b50 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105af0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105af3:	83 ec 08             	sub    $0x8,%esp
80105af6:	50                   	push   %eax
80105af7:	6a 01                	push   $0x1
80105af9:	e8 72 f5 ff ff       	call   80105070 <argint>
  if((argstr(0, &path)) < 0 ||
80105afe:	83 c4 10             	add    $0x10,%esp
80105b01:	85 c0                	test   %eax,%eax
80105b03:	78 4b                	js     80105b50 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105b05:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b08:	83 ec 08             	sub    $0x8,%esp
80105b0b:	50                   	push   %eax
80105b0c:	6a 02                	push   $0x2
80105b0e:	e8 5d f5 ff ff       	call   80105070 <argint>
     argint(1, &major) < 0 ||
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	85 c0                	test   %eax,%eax
80105b18:	78 36                	js     80105b50 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b1a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
80105b1e:	50                   	push   %eax
     (ip = create(path, T_DEV, major, minor)) == 0){
80105b1f:	0f bf 45 f0          	movswl -0x10(%ebp),%eax
     argint(2, &minor) < 0 ||
80105b23:	50                   	push   %eax
80105b24:	6a 03                	push   $0x3
80105b26:	ff 75 ec             	pushl  -0x14(%ebp)
80105b29:	e8 32 fc ff ff       	call   80105760 <create>
80105b2e:	83 c4 10             	add    $0x10,%esp
80105b31:	85 c0                	test   %eax,%eax
80105b33:	74 1b                	je     80105b50 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b35:	83 ec 0c             	sub    $0xc,%esp
80105b38:	50                   	push   %eax
80105b39:	e8 52 be ff ff       	call   80101990 <iunlockput>
  end_op();
80105b3e:	e8 dd d6 ff ff       	call   80103220 <end_op>
  return 0;
80105b43:	83 c4 10             	add    $0x10,%esp
80105b46:	31 c0                	xor    %eax,%eax
}
80105b48:	c9                   	leave  
80105b49:	c3                   	ret    
80105b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
80105b50:	e8 cb d6 ff ff       	call   80103220 <end_op>
    return -1;
80105b55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b5a:	c9                   	leave  
80105b5b:	c3                   	ret    
80105b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b60 <sys_chdir>:

int
sys_chdir(void)
{
80105b60:	55                   	push   %ebp
80105b61:	89 e5                	mov    %esp,%ebp
80105b63:	56                   	push   %esi
80105b64:	53                   	push   %ebx
80105b65:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105b68:	e8 23 e3 ff ff       	call   80103e90 <myproc>
80105b6d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105b6f:	e8 3c d6 ff ff       	call   801031b0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105b74:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b77:	83 ec 08             	sub    $0x8,%esp
80105b7a:	50                   	push   %eax
80105b7b:	6a 00                	push   $0x0
80105b7d:	e8 9e f5 ff ff       	call   80105120 <argstr>
80105b82:	83 c4 10             	add    $0x10,%esp
80105b85:	85 c0                	test   %eax,%eax
80105b87:	78 77                	js     80105c00 <sys_chdir+0xa0>
80105b89:	83 ec 0c             	sub    $0xc,%esp
80105b8c:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8f:	e8 cc c3 ff ff       	call   80101f60 <namei>
80105b94:	83 c4 10             	add    $0x10,%esp
80105b97:	85 c0                	test   %eax,%eax
80105b99:	89 c3                	mov    %eax,%ebx
80105b9b:	74 63                	je     80105c00 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b9d:	83 ec 0c             	sub    $0xc,%esp
80105ba0:	50                   	push   %eax
80105ba1:	e8 5a bb ff ff       	call   80101700 <ilock>
  if(ip->type != T_DIR){
80105ba6:	83 c4 10             	add    $0x10,%esp
80105ba9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bae:	75 30                	jne    80105be0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	53                   	push   %ebx
80105bb4:	e8 27 bc ff ff       	call   801017e0 <iunlock>
  iput(curproc->cwd);
80105bb9:	58                   	pop    %eax
80105bba:	ff 76 68             	pushl  0x68(%esi)
80105bbd:	e8 6e bc ff ff       	call   80101830 <iput>
  end_op();
80105bc2:	e8 59 d6 ff ff       	call   80103220 <end_op>
  curproc->cwd = ip;
80105bc7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105bca:	83 c4 10             	add    $0x10,%esp
80105bcd:	31 c0                	xor    %eax,%eax
}
80105bcf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bd2:	5b                   	pop    %ebx
80105bd3:	5e                   	pop    %esi
80105bd4:	5d                   	pop    %ebp
80105bd5:	c3                   	ret    
80105bd6:	8d 76 00             	lea    0x0(%esi),%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    iunlockput(ip);
80105be0:	83 ec 0c             	sub    $0xc,%esp
80105be3:	53                   	push   %ebx
80105be4:	e8 a7 bd ff ff       	call   80101990 <iunlockput>
    end_op();
80105be9:	e8 32 d6 ff ff       	call   80103220 <end_op>
    return -1;
80105bee:	83 c4 10             	add    $0x10,%esp
80105bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bf6:	eb d7                	jmp    80105bcf <sys_chdir+0x6f>
80105bf8:	90                   	nop
80105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105c00:	e8 1b d6 ff ff       	call   80103220 <end_op>
    return -1;
80105c05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0a:	eb c3                	jmp    80105bcf <sys_chdir+0x6f>
80105c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c10 <sys_exec>:

int
sys_exec(void)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	57                   	push   %edi
80105c14:	56                   	push   %esi
80105c15:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c16:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105c1c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105c22:	50                   	push   %eax
80105c23:	6a 00                	push   $0x0
80105c25:	e8 f6 f4 ff ff       	call   80105120 <argstr>
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	85 c0                	test   %eax,%eax
80105c2f:	0f 88 87 00 00 00    	js     80105cbc <sys_exec+0xac>
80105c35:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c3b:	83 ec 08             	sub    $0x8,%esp
80105c3e:	50                   	push   %eax
80105c3f:	6a 01                	push   $0x1
80105c41:	e8 2a f4 ff ff       	call   80105070 <argint>
80105c46:	83 c4 10             	add    $0x10,%esp
80105c49:	85 c0                	test   %eax,%eax
80105c4b:	78 6f                	js     80105cbc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c4d:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c53:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
80105c56:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105c58:	68 80 00 00 00       	push   $0x80
80105c5d:	6a 00                	push   $0x0
80105c5f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c65:	50                   	push   %eax
80105c66:	e8 05 f1 ff ff       	call   80104d70 <memset>
80105c6b:	83 c4 10             	add    $0x10,%esp
80105c6e:	eb 2c                	jmp    80105c9c <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
80105c70:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c76:	85 c0                	test   %eax,%eax
80105c78:	74 56                	je     80105cd0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c7a:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105c80:	83 ec 08             	sub    $0x8,%esp
80105c83:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105c86:	52                   	push   %edx
80105c87:	50                   	push   %eax
80105c88:	e8 73 f3 ff ff       	call   80105000 <fetchstr>
80105c8d:	83 c4 10             	add    $0x10,%esp
80105c90:	85 c0                	test   %eax,%eax
80105c92:	78 28                	js     80105cbc <sys_exec+0xac>
  for(i=0;; i++){
80105c94:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105c97:	83 fb 20             	cmp    $0x20,%ebx
80105c9a:	74 20                	je     80105cbc <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105c9c:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105ca2:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ca9:	83 ec 08             	sub    $0x8,%esp
80105cac:	57                   	push   %edi
80105cad:	01 f0                	add    %esi,%eax
80105caf:	50                   	push   %eax
80105cb0:	e8 0b f3 ff ff       	call   80104fc0 <fetchint>
80105cb5:	83 c4 10             	add    $0x10,%esp
80105cb8:	85 c0                	test   %eax,%eax
80105cba:	79 b4                	jns    80105c70 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105cbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105cbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cc4:	5b                   	pop    %ebx
80105cc5:	5e                   	pop    %esi
80105cc6:	5f                   	pop    %edi
80105cc7:	5d                   	pop    %ebp
80105cc8:	c3                   	ret    
80105cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105cd0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105cd6:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105cd9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ce0:	00 00 00 00 
  return exec(path, argv);
80105ce4:	50                   	push   %eax
80105ce5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105ceb:	e8 20 ad ff ff       	call   80100a10 <exec>
80105cf0:	83 c4 10             	add    $0x10,%esp
}
80105cf3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cf6:	5b                   	pop    %ebx
80105cf7:	5e                   	pop    %esi
80105cf8:	5f                   	pop    %edi
80105cf9:	5d                   	pop    %ebp
80105cfa:	c3                   	ret    
80105cfb:	90                   	nop
80105cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d00 <sys_pipe>:

int
sys_pipe(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	57                   	push   %edi
80105d04:	56                   	push   %esi
80105d05:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d06:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105d09:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105d0c:	6a 08                	push   $0x8
80105d0e:	50                   	push   %eax
80105d0f:	6a 00                	push   $0x0
80105d11:	e8 aa f3 ff ff       	call   801050c0 <argptr>
80105d16:	83 c4 10             	add    $0x10,%esp
80105d19:	85 c0                	test   %eax,%eax
80105d1b:	0f 88 ae 00 00 00    	js     80105dcf <sys_pipe+0xcf>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105d21:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d24:	83 ec 08             	sub    $0x8,%esp
80105d27:	50                   	push   %eax
80105d28:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d2b:	50                   	push   %eax
80105d2c:	e8 1f db ff ff       	call   80103850 <pipealloc>
80105d31:	83 c4 10             	add    $0x10,%esp
80105d34:	85 c0                	test   %eax,%eax
80105d36:	0f 88 93 00 00 00    	js     80105dcf <sys_pipe+0xcf>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d3c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105d3f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105d41:	e8 4a e1 ff ff       	call   80103e90 <myproc>
80105d46:	eb 10                	jmp    80105d58 <sys_pipe+0x58>
80105d48:	90                   	nop
80105d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105d50:	83 c3 01             	add    $0x1,%ebx
80105d53:	83 fb 10             	cmp    $0x10,%ebx
80105d56:	74 60                	je     80105db8 <sys_pipe+0xb8>
    if(curproc->ofile[fd] == 0){
80105d58:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105d5c:	85 f6                	test   %esi,%esi
80105d5e:	75 f0                	jne    80105d50 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105d60:	8d 73 08             	lea    0x8(%ebx),%esi
80105d63:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d67:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105d6a:	e8 21 e1 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d6f:	31 d2                	xor    %edx,%edx
80105d71:	eb 0d                	jmp    80105d80 <sys_pipe+0x80>
80105d73:	90                   	nop
80105d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d78:	83 c2 01             	add    $0x1,%edx
80105d7b:	83 fa 10             	cmp    $0x10,%edx
80105d7e:	74 28                	je     80105da8 <sys_pipe+0xa8>
    if(curproc->ofile[fd] == 0){
80105d80:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105d84:	85 c9                	test   %ecx,%ecx
80105d86:	75 f0                	jne    80105d78 <sys_pipe+0x78>
      curproc->ofile[fd] = f;
80105d88:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d8c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d8f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105d91:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d94:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d97:	31 c0                	xor    %eax,%eax
}
80105d99:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d9c:	5b                   	pop    %ebx
80105d9d:	5e                   	pop    %esi
80105d9e:	5f                   	pop    %edi
80105d9f:	5d                   	pop    %ebp
80105da0:	c3                   	ret    
80105da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
80105da8:	e8 e3 e0 ff ff       	call   80103e90 <myproc>
80105dad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105db4:	00 
80105db5:	8d 76 00             	lea    0x0(%esi),%esi
    fileclose(rf);
80105db8:	83 ec 0c             	sub    $0xc,%esp
80105dbb:	ff 75 e0             	pushl  -0x20(%ebp)
80105dbe:	e8 fd b0 ff ff       	call   80100ec0 <fileclose>
    fileclose(wf);
80105dc3:	58                   	pop    %eax
80105dc4:	ff 75 e4             	pushl  -0x1c(%ebp)
80105dc7:	e8 f4 b0 ff ff       	call   80100ec0 <fileclose>
    return -1;
80105dcc:	83 c4 10             	add    $0x10,%esp
80105dcf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd4:	eb c3                	jmp    80105d99 <sys_pipe+0x99>
80105dd6:	66 90                	xchg   %ax,%ax
80105dd8:	66 90                	xchg   %ax,%ax
80105dda:	66 90                	xchg   %ax,%ax
80105ddc:	66 90                	xchg   %ax,%ax
80105dde:	66 90                	xchg   %ax,%ax

80105de0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105de3:	5d                   	pop    %ebp
  return fork();
80105de4:	e9 67 e2 ff ff       	jmp    80104050 <fork>
80105de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105df0 <sys_exit>:

int
sys_exit(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105df6:	e8 d5 e5 ff ff       	call   801043d0 <exit>
  return 0;  // not reached
}
80105dfb:	31 c0                	xor    %eax,%eax
80105dfd:	c9                   	leave  
80105dfe:	c3                   	ret    
80105dff:	90                   	nop

80105e00 <sys_wait>:

int
sys_wait(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105e03:	5d                   	pop    %ebp
  return wait();
80105e04:	e9 37 e8 ff ff       	jmp    80104640 <wait>
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_kill>:

int
sys_kill(void)
{
80105e10:	55                   	push   %ebp
80105e11:	89 e5                	mov    %esp,%ebp
80105e13:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105e16:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e19:	50                   	push   %eax
80105e1a:	6a 00                	push   $0x0
80105e1c:	e8 4f f2 ff ff       	call   80105070 <argint>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	85 c0                	test   %eax,%eax
80105e26:	78 18                	js     80105e40 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105e28:	83 ec 0c             	sub    $0xc,%esp
80105e2b:	ff 75 f4             	pushl  -0xc(%ebp)
80105e2e:	e8 6d e9 ff ff       	call   801047a0 <kill>
80105e33:	83 c4 10             	add    $0x10,%esp
}
80105e36:	c9                   	leave  
80105e37:	c3                   	ret    
80105e38:	90                   	nop
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e45:	c9                   	leave  
80105e46:	c3                   	ret    
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <sys_getpid>:

int
sys_getpid(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105e56:	e8 35 e0 ff ff       	call   80103e90 <myproc>
80105e5b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105e5e:	c9                   	leave  
80105e5f:	c3                   	ret    

80105e60 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	53                   	push   %ebx
  int addr;
  int n;
  
  if(argint(0, &n) < 0)
80105e64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105e67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105e6a:	50                   	push   %eax
80105e6b:	6a 00                	push   $0x0
80105e6d:	e8 fe f1 ff ff       	call   80105070 <argint>
80105e72:	83 c4 10             	add    $0x10,%esp
80105e75:	85 c0                	test   %eax,%eax
80105e77:	78 27                	js     80105ea0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105e79:	e8 12 e0 ff ff       	call   80103e90 <myproc>
  if(growproc(n) < 0)
80105e7e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105e81:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e83:	ff 75 f4             	pushl  -0xc(%ebp)
80105e86:	e8 45 e1 ff ff       	call   80103fd0 <growproc>
80105e8b:	83 c4 10             	add    $0x10,%esp
80105e8e:	85 c0                	test   %eax,%eax
80105e90:	78 0e                	js     80105ea0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105e92:	89 d8                	mov    %ebx,%eax
80105e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e97:	c9                   	leave  
80105e98:	c3                   	ret    
80105e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ea0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ea5:	eb eb                	jmp    80105e92 <sys_sbrk+0x32>
80105ea7:	89 f6                	mov    %esi,%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105eb0 <sys_sleep>:

int
sys_sleep(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105eb7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105eba:	50                   	push   %eax
80105ebb:	6a 00                	push   $0x0
80105ebd:	e8 ae f1 ff ff       	call   80105070 <argint>
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	0f 88 8a 00 00 00    	js     80105f57 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105ecd:	83 ec 0c             	sub    $0xc,%esp
80105ed0:	68 80 71 15 80       	push   $0x80157180
80105ed5:	e8 86 ed ff ff       	call   80104c60 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105eda:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105edd:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105ee0:	8b 1d c0 79 15 80    	mov    0x801579c0,%ebx
  while(ticks - ticks0 < n){
80105ee6:	85 d2                	test   %edx,%edx
80105ee8:	75 27                	jne    80105f11 <sys_sleep+0x61>
80105eea:	eb 54                	jmp    80105f40 <sys_sleep+0x90>
80105eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105ef0:	83 ec 08             	sub    $0x8,%esp
80105ef3:	68 80 71 15 80       	push   $0x80157180
80105ef8:	68 c0 79 15 80       	push   $0x801579c0
80105efd:	e8 7e e6 ff ff       	call   80104580 <sleep>
  while(ticks - ticks0 < n){
80105f02:	a1 c0 79 15 80       	mov    0x801579c0,%eax
80105f07:	83 c4 10             	add    $0x10,%esp
80105f0a:	29 d8                	sub    %ebx,%eax
80105f0c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105f0f:	73 2f                	jae    80105f40 <sys_sleep+0x90>
    if(myproc()->killed){
80105f11:	e8 7a df ff ff       	call   80103e90 <myproc>
80105f16:	8b 40 24             	mov    0x24(%eax),%eax
80105f19:	85 c0                	test   %eax,%eax
80105f1b:	74 d3                	je     80105ef0 <sys_sleep+0x40>
      release(&tickslock);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	68 80 71 15 80       	push   $0x80157180
80105f25:	e8 f6 ed ff ff       	call   80104d20 <release>
      return -1;
80105f2a:	83 c4 10             	add    $0x10,%esp
80105f2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105f32:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f35:	c9                   	leave  
80105f36:	c3                   	ret    
80105f37:	89 f6                	mov    %esi,%esi
80105f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105f40:	83 ec 0c             	sub    $0xc,%esp
80105f43:	68 80 71 15 80       	push   $0x80157180
80105f48:	e8 d3 ed ff ff       	call   80104d20 <release>
  return 0;
80105f4d:	83 c4 10             	add    $0x10,%esp
80105f50:	31 c0                	xor    %eax,%eax
}
80105f52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f55:	c9                   	leave  
80105f56:	c3                   	ret    
    return -1;
80105f57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f5c:	eb f4                	jmp    80105f52 <sys_sleep+0xa2>
80105f5e:	66 90                	xchg   %ax,%ax

80105f60 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	53                   	push   %ebx
80105f64:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f67:	68 80 71 15 80       	push   $0x80157180
80105f6c:	e8 ef ec ff ff       	call   80104c60 <acquire>
  xticks = ticks;
80105f71:	8b 1d c0 79 15 80    	mov    0x801579c0,%ebx
  release(&tickslock);
80105f77:	c7 04 24 80 71 15 80 	movl   $0x80157180,(%esp)
80105f7e:	e8 9d ed ff ff       	call   80104d20 <release>
  return xticks;
}
80105f83:	89 d8                	mov    %ebx,%eax
80105f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f88:	c9                   	leave  
80105f89:	c3                   	ret    
80105f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f90 <sys_getNumberOfFreePages>:

int
sys_getNumberOfFreePages(void){
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
  return numFreePages();
80105f93:	5d                   	pop    %ebp
  return numFreePages();
80105f94:	e9 57 ca ff ff       	jmp    801029f0 <numFreePages>

80105f99 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105f99:	1e                   	push   %ds
  pushl %es
80105f9a:	06                   	push   %es
  pushl %fs
80105f9b:	0f a0                	push   %fs
  pushl %gs
80105f9d:	0f a8                	push   %gs
  pushal
80105f9f:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105fa0:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105fa4:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105fa6:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105fa8:	54                   	push   %esp
  call trap
80105fa9:	e8 c2 00 00 00       	call   80106070 <trap>
  addl $4, %esp
80105fae:	83 c4 04             	add    $0x4,%esp

80105fb1 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105fb1:	61                   	popa   
  popl %gs
80105fb2:	0f a9                	pop    %gs
  popl %fs
80105fb4:	0f a1                	pop    %fs
  popl %es
80105fb6:	07                   	pop    %es
  popl %ds
80105fb7:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105fb8:	83 c4 08             	add    $0x8,%esp
  iret
80105fbb:	cf                   	iret   
80105fbc:	66 90                	xchg   %ax,%ax
80105fbe:	66 90                	xchg   %ax,%ax

80105fc0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105fc0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105fc1:	31 c0                	xor    %eax,%eax
{
80105fc3:	89 e5                	mov    %esp,%ebp
80105fc5:	83 ec 08             	sub    $0x8,%esp
80105fc8:	90                   	nop
80105fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105fd0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105fd7:	c7 04 c5 c2 71 15 80 	movl   $0x8e000008,-0x7fea8e3e(,%eax,8)
80105fde:	08 00 00 8e 
80105fe2:	66 89 14 c5 c0 71 15 	mov    %dx,-0x7fea8e40(,%eax,8)
80105fe9:	80 
80105fea:	c1 ea 10             	shr    $0x10,%edx
80105fed:	66 89 14 c5 c6 71 15 	mov    %dx,-0x7fea8e3a(,%eax,8)
80105ff4:	80 
  for(i = 0; i < 256; i++)
80105ff5:	83 c0 01             	add    $0x1,%eax
80105ff8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105ffd:	75 d1                	jne    80105fd0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105fff:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106004:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106007:	c7 05 c2 73 15 80 08 	movl   $0xef000008,0x801573c2
8010600e:	00 00 ef 
  initlock(&tickslock, "time");
80106011:	68 99 88 10 80       	push   $0x80108899
80106016:	68 80 71 15 80       	push   $0x80157180
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010601b:	66 a3 c0 73 15 80    	mov    %ax,0x801573c0
80106021:	c1 e8 10             	shr    $0x10,%eax
80106024:	66 a3 c6 73 15 80    	mov    %ax,0x801573c6
  initlock(&tickslock, "time");
8010602a:	e8 f1 ea ff ff       	call   80104b20 <initlock>
}
8010602f:	83 c4 10             	add    $0x10,%esp
80106032:	c9                   	leave  
80106033:	c3                   	ret    
80106034:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010603a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106040 <idtinit>:

void
idtinit(void)
{
80106040:	55                   	push   %ebp
  pd[0] = size-1;
80106041:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106046:	89 e5                	mov    %esp,%ebp
80106048:	83 ec 10             	sub    $0x10,%esp
8010604b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010604f:	b8 c0 71 15 80       	mov    $0x801571c0,%eax
80106054:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106058:	c1 e8 10             	shr    $0x10,%eax
8010605b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010605f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106062:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106065:	c9                   	leave  
80106066:	c3                   	ret    
80106067:	89 f6                	mov    %esi,%esi
80106069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106070 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106070:	55                   	push   %ebp
80106071:	89 e5                	mov    %esp,%ebp
80106073:	57                   	push   %edi
80106074:	56                   	push   %esi
80106075:	53                   	push   %ebx
80106076:	83 ec 1c             	sub    $0x1c,%esp
80106079:	8b 5d 08             	mov    0x8(%ebp),%ebx
  #ifndef NONE
    uint addr;
  #endif

  if(tf->trapno == T_SYSCALL){
8010607c:	8b 43 30             	mov    0x30(%ebx),%eax
8010607f:	83 f8 40             	cmp    $0x40,%eax
80106082:	0f 84 f0 00 00 00    	je     80106178 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106088:	83 e8 0e             	sub    $0xe,%eax
8010608b:	83 f8 31             	cmp    $0x31,%eax
8010608e:	77 10                	ja     801060a0 <trap+0x30>
80106090:	ff 24 85 b0 89 10 80 	jmp    *-0x7fef7650(,%eax,4)
80106097:	89 f6                	mov    %esi,%esi
80106099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi



  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801060a0:	e8 eb dd ff ff       	call   80103e90 <myproc>
801060a5:	85 c0                	test   %eax,%eax
801060a7:	0f 84 1d 03 00 00    	je     801063ca <trap+0x35a>
801060ad:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801060b1:	0f 84 13 03 00 00    	je     801063ca <trap+0x35a>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801060b7:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060ba:	8b 53 38             	mov    0x38(%ebx),%edx
801060bd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801060c0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801060c3:	e8 a8 dd ff ff       	call   80103e70 <cpuid>
801060c8:	89 c7                	mov    %eax,%edi
801060ca:	8b 43 30             	mov    0x30(%ebx),%eax
801060cd:	8b 73 34             	mov    0x34(%ebx),%esi
801060d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801060d3:	e8 b8 dd ff ff       	call   80103e90 <myproc>
801060d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801060db:	e8 b0 dd ff ff       	call   80103e90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060e0:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801060e3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801060e6:	51                   	push   %ecx
801060e7:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801060e8:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060eb:	57                   	push   %edi
801060ec:	56                   	push   %esi
801060ed:	ff 75 e4             	pushl  -0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801060f0:	83 c2 6c             	add    $0x6c,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060f3:	52                   	push   %edx
801060f4:	ff 70 10             	pushl  0x10(%eax)
801060f7:	68 6c 89 10 80       	push   $0x8010896c
801060fc:	e8 5f a5 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106101:	83 c4 20             	add    $0x20,%esp
80106104:	e8 87 dd ff ff       	call   80103e90 <myproc>
80106109:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106110:	e8 7b dd ff ff       	call   80103e90 <myproc>
80106115:	85 c0                	test   %eax,%eax
80106117:	74 1d                	je     80106136 <trap+0xc6>
80106119:	e8 72 dd ff ff       	call   80103e90 <myproc>
8010611e:	8b 50 24             	mov    0x24(%eax),%edx
80106121:	85 d2                	test   %edx,%edx
80106123:	74 11                	je     80106136 <trap+0xc6>
80106125:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106129:	83 e0 03             	and    $0x3,%eax
8010612c:	66 83 f8 03          	cmp    $0x3,%ax
80106130:	0f 84 aa 01 00 00    	je     801062e0 <trap+0x270>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106136:	e8 55 dd ff ff       	call   80103e90 <myproc>
8010613b:	85 c0                	test   %eax,%eax
8010613d:	74 0b                	je     8010614a <trap+0xda>
8010613f:	e8 4c dd ff ff       	call   80103e90 <myproc>
80106144:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106148:	74 66                	je     801061b0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010614a:	e8 41 dd ff ff       	call   80103e90 <myproc>
8010614f:	85 c0                	test   %eax,%eax
80106151:	74 19                	je     8010616c <trap+0xfc>
80106153:	e8 38 dd ff ff       	call   80103e90 <myproc>
80106158:	8b 40 24             	mov    0x24(%eax),%eax
8010615b:	85 c0                	test   %eax,%eax
8010615d:	74 0d                	je     8010616c <trap+0xfc>
8010615f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106163:	83 e0 03             	and    $0x3,%eax
80106166:	66 83 f8 03          	cmp    $0x3,%ax
8010616a:	74 35                	je     801061a1 <trap+0x131>
    exit();
}
8010616c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010616f:	5b                   	pop    %ebx
80106170:	5e                   	pop    %esi
80106171:	5f                   	pop    %edi
80106172:	5d                   	pop    %ebp
80106173:	c3                   	ret    
80106174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106178:	e8 13 dd ff ff       	call   80103e90 <myproc>
8010617d:	8b 40 24             	mov    0x24(%eax),%eax
80106180:	85 c0                	test   %eax,%eax
80106182:	0f 85 48 01 00 00    	jne    801062d0 <trap+0x260>
    myproc()->tf = tf;
80106188:	e8 03 dd ff ff       	call   80103e90 <myproc>
8010618d:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106190:	e8 cb ef ff ff       	call   80105160 <syscall>
    if(myproc()->killed)
80106195:	e8 f6 dc ff ff       	call   80103e90 <myproc>
8010619a:	8b 78 24             	mov    0x24(%eax),%edi
8010619d:	85 ff                	test   %edi,%edi
8010619f:	74 cb                	je     8010616c <trap+0xfc>
}
801061a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061a4:	5b                   	pop    %ebx
801061a5:	5e                   	pop    %esi
801061a6:	5f                   	pop    %edi
801061a7:	5d                   	pop    %ebp
      exit();
801061a8:	e9 23 e2 ff ff       	jmp    801043d0 <exit>
801061ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801061b0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801061b4:	75 94                	jne    8010614a <trap+0xda>
    yield();
801061b6:	e8 75 e3 ff ff       	call   80104530 <yield>
801061bb:	eb 8d                	jmp    8010614a <trap+0xda>
801061bd:	8d 76 00             	lea    0x0(%esi),%esi
801061c0:	0f 20 d6             	mov    %cr2,%esi
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061c3:	e8 c8 dc ff ff       	call   80103e90 <myproc>
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061c8:	8b 40 04             	mov    0x4(%eax),%eax
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061cb:	89 f2                	mov    %esi,%edx
      uint refCount = getReferenceCount(pa);
801061cd:	83 ec 0c             	sub    $0xc,%esp
      pte_t *vaddr = &myproc()->pgdir[PDX(PGROUNDDOWN(addr))];
801061d0:	c1 ea 16             	shr    $0x16,%edx
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061d3:	8b 14 90             	mov    (%eax,%edx,4),%edx
      pte_t *pte = &pgtab[PTX(addr)];
801061d6:	89 f0                	mov    %esi,%eax
801061d8:	c1 e8 0a             	shr    $0xa,%eax
801061db:	25 fc 0f 00 00       	and    $0xffc,%eax
      pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*vaddr));
801061e0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
      pte_t *pte = &pgtab[PTX(addr)];
801061e6:	8d bc 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%edi
      uint pa = PTE_ADDR(*pte);
801061ed:	8b 07                	mov    (%edi),%eax
801061ef:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      uint refCount = getReferenceCount(pa);
801061f4:	50                   	push   %eax
      uint pa = PTE_ADDR(*pte);
801061f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      uint refCount = getReferenceCount(pa);
801061f8:	e8 f3 c8 ff ff       	call   80102af0 <getReferenceCount>
      if((*pte & PTE_PG ) != 0){
801061fd:	8b 17                	mov    (%edi),%edx
801061ff:	83 c4 10             	add    $0x10,%esp
80106202:	f6 c6 02             	test   $0x2,%dh
80106205:	0f 85 75 01 00 00    	jne    80106380 <trap+0x310>
      }else if(((*pte & PTE_W) == 0) && ((*pte & PTE_U) != 0)){
8010620b:	89 d1                	mov    %edx,%ecx
8010620d:	83 e1 06             	and    $0x6,%ecx
80106210:	83 f9 04             	cmp    $0x4,%ecx
80106213:	0f 85 dc 01 00 00    	jne    801063f5 <trap+0x385>
        if(refCount > 1) {
80106219:	83 f8 01             	cmp    $0x1,%eax
8010621c:	0f 87 ce 00 00 00    	ja     801062f0 <trap+0x280>
        else if(refCount == 1){
80106222:	0f 85 ed 01 00 00    	jne    80106415 <trap+0x3a5>
          *pte |= PTE_W;
80106228:	83 ca 02             	or     $0x2,%edx
8010622b:	89 17                	mov    %edx,(%edi)
      lcr3(V2P(myproc()->pgdir));
8010622d:	e8 5e dc ff ff       	call   80103e90 <myproc>
80106232:	8b 40 04             	mov    0x4(%eax),%eax
80106235:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010623a:	0f 22 d8             	mov    %eax,%cr3
8010623d:	e9 ce fe ff ff       	jmp    80106110 <trap+0xa0>
80106242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(cpuid() == 0){
80106248:	e8 23 dc ff ff       	call   80103e70 <cpuid>
8010624d:	85 c0                	test   %eax,%eax
8010624f:	0f 84 f3 00 00 00    	je     80106348 <trap+0x2d8>
    lapiceoi();
80106255:	e8 06 cb ff ff       	call   80102d60 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010625a:	e8 31 dc ff ff       	call   80103e90 <myproc>
8010625f:	85 c0                	test   %eax,%eax
80106261:	0f 85 b2 fe ff ff    	jne    80106119 <trap+0xa9>
80106267:	e9 ca fe ff ff       	jmp    80106136 <trap+0xc6>
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106270:	e8 ab c9 ff ff       	call   80102c20 <kbdintr>
    lapiceoi();
80106275:	e8 e6 ca ff ff       	call   80102d60 <lapiceoi>
    break;
8010627a:	e9 91 fe ff ff       	jmp    80106110 <trap+0xa0>
8010627f:	90                   	nop
    uartintr();
80106280:	e8 1b 03 00 00       	call   801065a0 <uartintr>
    lapiceoi();
80106285:	e8 d6 ca ff ff       	call   80102d60 <lapiceoi>
    break;
8010628a:	e9 81 fe ff ff       	jmp    80106110 <trap+0xa0>
8010628f:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106290:	0f b7 7b 3c          	movzwl 0x3c(%ebx),%edi
80106294:	8b 73 38             	mov    0x38(%ebx),%esi
80106297:	e8 d4 db ff ff       	call   80103e70 <cpuid>
8010629c:	56                   	push   %esi
8010629d:	57                   	push   %edi
8010629e:	50                   	push   %eax
8010629f:	68 e0 88 10 80       	push   $0x801088e0
801062a4:	e8 b7 a3 ff ff       	call   80100660 <cprintf>
    lapiceoi();
801062a9:	e8 b2 ca ff ff       	call   80102d60 <lapiceoi>
    break;
801062ae:	83 c4 10             	add    $0x10,%esp
801062b1:	e9 5a fe ff ff       	jmp    80106110 <trap+0xa0>
801062b6:	8d 76 00             	lea    0x0(%esi),%esi
801062b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    ideintr();
801062c0:	e8 cb c1 ff ff       	call   80102490 <ideintr>
801062c5:	eb 8e                	jmp    80106255 <trap+0x1e5>
801062c7:	89 f6                	mov    %esi,%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exit();
801062d0:	e8 fb e0 ff ff       	call   801043d0 <exit>
801062d5:	e9 ae fe ff ff       	jmp    80106188 <trap+0x118>
801062da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
801062e0:	e8 eb e0 ff ff       	call   801043d0 <exit>
801062e5:	e9 4c fe ff ff       	jmp    80106136 <trap+0xc6>
801062ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          if((mem = kalloc()) == 0) {
801062f0:	e8 6b c6 ff ff       	call   80102960 <kalloc>
801062f5:	85 c0                	test   %eax,%eax
801062f7:	89 c6                	mov    %eax,%esi
801062f9:	0f 84 98 00 00 00    	je     80106397 <trap+0x327>
          memmove(mem, (char*)P2V(pa), PGSIZE);
801062ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106302:	83 ec 04             	sub    $0x4,%esp
80106305:	68 00 10 00 00       	push   $0x1000
8010630a:	05 00 00 00 80       	add    $0x80000000,%eax
8010630f:	50                   	push   %eax
80106310:	56                   	push   %esi
          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;
80106311:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106317:	83 ce 07             	or     $0x7,%esi
          memmove(mem, (char*)P2V(pa), PGSIZE);
8010631a:	e8 01 eb ff ff       	call   80104e20 <memmove>
          *pte = V2P(mem) | PTE_P | PTE_U | PTE_W;
8010631f:	89 37                	mov    %esi,(%edi)
          decrementReferenceCount(pa);
80106321:	5e                   	pop    %esi
80106322:	ff 75 e4             	pushl  -0x1c(%ebp)
80106325:	e8 16 c7 ff ff       	call   80102a40 <decrementReferenceCount>
          lcr3(V2P(myproc()->pgdir));
8010632a:	e8 61 db ff ff       	call   80103e90 <myproc>
8010632f:	8b 40 04             	mov    0x4(%eax),%eax
80106332:	05 00 00 00 80       	add    $0x80000000,%eax
80106337:	0f 22 d8             	mov    %eax,%cr3
8010633a:	83 c4 10             	add    $0x10,%esp
8010633d:	e9 eb fe ff ff       	jmp    8010622d <trap+0x1bd>
80106342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
80106348:	83 ec 0c             	sub    $0xc,%esp
8010634b:	68 80 71 15 80       	push   $0x80157180
80106350:	e8 0b e9 ff ff       	call   80104c60 <acquire>
      wakeup(&ticks);
80106355:	c7 04 24 c0 79 15 80 	movl   $0x801579c0,(%esp)
      ticks++;
8010635c:	83 05 c0 79 15 80 01 	addl   $0x1,0x801579c0
      wakeup(&ticks);
80106363:	e8 d8 e3 ff ff       	call   80104740 <wakeup>
      release(&tickslock);
80106368:	c7 04 24 80 71 15 80 	movl   $0x80157180,(%esp)
8010636f:	e8 ac e9 ff ff       	call   80104d20 <release>
80106374:	83 c4 10             	add    $0x10,%esp
80106377:	e9 d9 fe ff ff       	jmp    80106255 <trap+0x1e5>
8010637c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        swapPage(PTE_ADDR(addr));
80106380:	83 ec 0c             	sub    $0xc,%esp
80106383:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106389:	56                   	push   %esi
8010638a:	e8 71 1a 00 00       	call   80107e00 <swapPage>
        break;
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	e9 79 fd ff ff       	jmp    80106110 <trap+0xa0>
            cprintf("Page fault out of memory, kill proc %s with pid %d\n", myproc()->name, myproc()->pid);
80106397:	e8 f4 da ff ff       	call   80103e90 <myproc>
8010639c:	8b 58 10             	mov    0x10(%eax),%ebx
8010639f:	e8 ec da ff ff       	call   80103e90 <myproc>
801063a4:	83 ec 04             	sub    $0x4,%esp
801063a7:	83 c0 6c             	add    $0x6c,%eax
801063aa:	53                   	push   %ebx
801063ab:	50                   	push   %eax
801063ac:	68 04 89 10 80       	push   $0x80108904
801063b1:	e8 aa a2 ff ff       	call   80100660 <cprintf>
            myproc()->killed = 1;
801063b6:	e8 d5 da ff ff       	call   80103e90 <myproc>
            return;
801063bb:	83 c4 10             	add    $0x10,%esp
            myproc()->killed = 1;
801063be:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            return;
801063c5:	e9 a2 fd ff ff       	jmp    8010616c <trap+0xfc>
  asm volatile("movl %%cr2,%0" : "=r" (val));
801063ca:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801063cd:	8b 7b 38             	mov    0x38(%ebx),%edi
801063d0:	e8 9b da ff ff       	call   80103e70 <cpuid>
801063d5:	83 ec 0c             	sub    $0xc,%esp
801063d8:	56                   	push   %esi
801063d9:	57                   	push   %edi
801063da:	50                   	push   %eax
801063db:	ff 73 30             	pushl  0x30(%ebx)
801063de:	68 38 89 10 80       	push   $0x80108938
801063e3:	e8 78 a2 ff ff       	call   80100660 <cprintf>
      panic("trap");
801063e8:	83 c4 14             	add    $0x14,%esp
801063eb:	68 d9 88 10 80       	push   $0x801088d9
801063f0:	e8 9b 9f ff ff       	call   80100390 <panic>
        cprintf("pid: %d\n",myproc()->pid);
801063f5:	e8 96 da ff ff       	call   80103e90 <myproc>
801063fa:	51                   	push   %ecx
801063fb:	51                   	push   %ecx
801063fc:	ff 70 10             	pushl  0x10(%eax)
801063ff:	68 c1 88 10 80       	push   $0x801088c1
80106404:	e8 57 a2 ff ff       	call   80100660 <cprintf>
        panic("trap: PF fault");
80106409:	c7 04 24 ca 88 10 80 	movl   $0x801088ca,(%esp)
80106410:	e8 7b 9f ff ff       	call   80100390 <panic>
          cprintf("count: %d\n",refCount);
80106415:	53                   	push   %ebx
80106416:	53                   	push   %ebx
80106417:	6a 00                	push   $0x0
80106419:	68 9e 88 10 80       	push   $0x8010889e
8010641e:	e8 3d a2 ff ff       	call   80100660 <cprintf>
          panic("trap PTE_W : recCount<1");
80106423:	c7 04 24 a9 88 10 80 	movl   $0x801088a9,(%esp)
8010642a:	e8 61 9f ff ff       	call   80100390 <panic>
8010642f:	90                   	nop

80106430 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106430:	a1 bc b5 10 80       	mov    0x8010b5bc,%eax
{
80106435:	55                   	push   %ebp
80106436:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106438:	85 c0                	test   %eax,%eax
8010643a:	74 1c                	je     80106458 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010643c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106441:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106442:	a8 01                	test   $0x1,%al
80106444:	74 12                	je     80106458 <uartgetc+0x28>
80106446:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010644b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010644c:	0f b6 c0             	movzbl %al,%eax
}
8010644f:	5d                   	pop    %ebp
80106450:	c3                   	ret    
80106451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106458:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010645d:	5d                   	pop    %ebp
8010645e:	c3                   	ret    
8010645f:	90                   	nop

80106460 <uartputc.part.0>:
uartputc(int c)
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	57                   	push   %edi
80106464:	56                   	push   %esi
80106465:	53                   	push   %ebx
80106466:	89 c7                	mov    %eax,%edi
80106468:	bb 80 00 00 00       	mov    $0x80,%ebx
8010646d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106472:	83 ec 0c             	sub    $0xc,%esp
80106475:	eb 1b                	jmp    80106492 <uartputc.part.0+0x32>
80106477:	89 f6                	mov    %esi,%esi
80106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106480:	83 ec 0c             	sub    $0xc,%esp
80106483:	6a 0a                	push   $0xa
80106485:	e8 f6 c8 ff ff       	call   80102d80 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010648a:	83 c4 10             	add    $0x10,%esp
8010648d:	83 eb 01             	sub    $0x1,%ebx
80106490:	74 07                	je     80106499 <uartputc.part.0+0x39>
80106492:	89 f2                	mov    %esi,%edx
80106494:	ec                   	in     (%dx),%al
80106495:	a8 20                	test   $0x20,%al
80106497:	74 e7                	je     80106480 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106499:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010649e:	89 f8                	mov    %edi,%eax
801064a0:	ee                   	out    %al,(%dx)
}
801064a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064a4:	5b                   	pop    %ebx
801064a5:	5e                   	pop    %esi
801064a6:	5f                   	pop    %edi
801064a7:	5d                   	pop    %ebp
801064a8:	c3                   	ret    
801064a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064b0 <uartinit>:
{
801064b0:	55                   	push   %ebp
801064b1:	31 c9                	xor    %ecx,%ecx
801064b3:	89 c8                	mov    %ecx,%eax
801064b5:	89 e5                	mov    %esp,%ebp
801064b7:	57                   	push   %edi
801064b8:	56                   	push   %esi
801064b9:	53                   	push   %ebx
801064ba:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801064bf:	89 da                	mov    %ebx,%edx
801064c1:	83 ec 0c             	sub    $0xc,%esp
801064c4:	ee                   	out    %al,(%dx)
801064c5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801064ca:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801064cf:	89 fa                	mov    %edi,%edx
801064d1:	ee                   	out    %al,(%dx)
801064d2:	b8 0c 00 00 00       	mov    $0xc,%eax
801064d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064dc:	ee                   	out    %al,(%dx)
801064dd:	be f9 03 00 00       	mov    $0x3f9,%esi
801064e2:	89 c8                	mov    %ecx,%eax
801064e4:	89 f2                	mov    %esi,%edx
801064e6:	ee                   	out    %al,(%dx)
801064e7:	b8 03 00 00 00       	mov    $0x3,%eax
801064ec:	89 fa                	mov    %edi,%edx
801064ee:	ee                   	out    %al,(%dx)
801064ef:	ba fc 03 00 00       	mov    $0x3fc,%edx
801064f4:	89 c8                	mov    %ecx,%eax
801064f6:	ee                   	out    %al,(%dx)
801064f7:	b8 01 00 00 00       	mov    $0x1,%eax
801064fc:	89 f2                	mov    %esi,%edx
801064fe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801064ff:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106504:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106505:	3c ff                	cmp    $0xff,%al
80106507:	74 5a                	je     80106563 <uartinit+0xb3>
  uart = 1;
80106509:	c7 05 bc b5 10 80 01 	movl   $0x1,0x8010b5bc
80106510:	00 00 00 
80106513:	89 da                	mov    %ebx,%edx
80106515:	ec                   	in     (%dx),%al
80106516:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010651b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010651c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010651f:	bb 78 8a 10 80       	mov    $0x80108a78,%ebx
  ioapicenable(IRQ_COM1, 0);
80106524:	6a 00                	push   $0x0
80106526:	6a 04                	push   $0x4
80106528:	e8 b3 c1 ff ff       	call   801026e0 <ioapicenable>
8010652d:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106530:	b8 78 00 00 00       	mov    $0x78,%eax
80106535:	eb 13                	jmp    8010654a <uartinit+0x9a>
80106537:	89 f6                	mov    %esi,%esi
80106539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106540:	83 c3 01             	add    $0x1,%ebx
80106543:	0f be 03             	movsbl (%ebx),%eax
80106546:	84 c0                	test   %al,%al
80106548:	74 19                	je     80106563 <uartinit+0xb3>
  if(!uart)
8010654a:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
80106550:	85 d2                	test   %edx,%edx
80106552:	74 ec                	je     80106540 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106554:	83 c3 01             	add    $0x1,%ebx
80106557:	e8 04 ff ff ff       	call   80106460 <uartputc.part.0>
8010655c:	0f be 03             	movsbl (%ebx),%eax
8010655f:	84 c0                	test   %al,%al
80106561:	75 e7                	jne    8010654a <uartinit+0x9a>
}
80106563:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106566:	5b                   	pop    %ebx
80106567:	5e                   	pop    %esi
80106568:	5f                   	pop    %edi
80106569:	5d                   	pop    %ebp
8010656a:	c3                   	ret    
8010656b:	90                   	nop
8010656c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106570 <uartputc>:
  if(!uart)
80106570:	8b 15 bc b5 10 80    	mov    0x8010b5bc,%edx
{
80106576:	55                   	push   %ebp
80106577:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106579:	85 d2                	test   %edx,%edx
{
8010657b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010657e:	74 10                	je     80106590 <uartputc+0x20>
}
80106580:	5d                   	pop    %ebp
80106581:	e9 da fe ff ff       	jmp    80106460 <uartputc.part.0>
80106586:	8d 76 00             	lea    0x0(%esi),%esi
80106589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106590:	5d                   	pop    %ebp
80106591:	c3                   	ret    
80106592:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065a0 <uartintr>:

void
uartintr(void)
{
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801065a6:	68 30 64 10 80       	push   $0x80106430
801065ab:	e8 60 a2 ff ff       	call   80100810 <consoleintr>
}
801065b0:	83 c4 10             	add    $0x10,%esp
801065b3:	c9                   	leave  
801065b4:	c3                   	ret    

801065b5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801065b5:	6a 00                	push   $0x0
  pushl $0
801065b7:	6a 00                	push   $0x0
  jmp alltraps
801065b9:	e9 db f9 ff ff       	jmp    80105f99 <alltraps>

801065be <vector1>:
.globl vector1
vector1:
  pushl $0
801065be:	6a 00                	push   $0x0
  pushl $1
801065c0:	6a 01                	push   $0x1
  jmp alltraps
801065c2:	e9 d2 f9 ff ff       	jmp    80105f99 <alltraps>

801065c7 <vector2>:
.globl vector2
vector2:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $2
801065c9:	6a 02                	push   $0x2
  jmp alltraps
801065cb:	e9 c9 f9 ff ff       	jmp    80105f99 <alltraps>

801065d0 <vector3>:
.globl vector3
vector3:
  pushl $0
801065d0:	6a 00                	push   $0x0
  pushl $3
801065d2:	6a 03                	push   $0x3
  jmp alltraps
801065d4:	e9 c0 f9 ff ff       	jmp    80105f99 <alltraps>

801065d9 <vector4>:
.globl vector4
vector4:
  pushl $0
801065d9:	6a 00                	push   $0x0
  pushl $4
801065db:	6a 04                	push   $0x4
  jmp alltraps
801065dd:	e9 b7 f9 ff ff       	jmp    80105f99 <alltraps>

801065e2 <vector5>:
.globl vector5
vector5:
  pushl $0
801065e2:	6a 00                	push   $0x0
  pushl $5
801065e4:	6a 05                	push   $0x5
  jmp alltraps
801065e6:	e9 ae f9 ff ff       	jmp    80105f99 <alltraps>

801065eb <vector6>:
.globl vector6
vector6:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $6
801065ed:	6a 06                	push   $0x6
  jmp alltraps
801065ef:	e9 a5 f9 ff ff       	jmp    80105f99 <alltraps>

801065f4 <vector7>:
.globl vector7
vector7:
  pushl $0
801065f4:	6a 00                	push   $0x0
  pushl $7
801065f6:	6a 07                	push   $0x7
  jmp alltraps
801065f8:	e9 9c f9 ff ff       	jmp    80105f99 <alltraps>

801065fd <vector8>:
.globl vector8
vector8:
  pushl $8
801065fd:	6a 08                	push   $0x8
  jmp alltraps
801065ff:	e9 95 f9 ff ff       	jmp    80105f99 <alltraps>

80106604 <vector9>:
.globl vector9
vector9:
  pushl $0
80106604:	6a 00                	push   $0x0
  pushl $9
80106606:	6a 09                	push   $0x9
  jmp alltraps
80106608:	e9 8c f9 ff ff       	jmp    80105f99 <alltraps>

8010660d <vector10>:
.globl vector10
vector10:
  pushl $10
8010660d:	6a 0a                	push   $0xa
  jmp alltraps
8010660f:	e9 85 f9 ff ff       	jmp    80105f99 <alltraps>

80106614 <vector11>:
.globl vector11
vector11:
  pushl $11
80106614:	6a 0b                	push   $0xb
  jmp alltraps
80106616:	e9 7e f9 ff ff       	jmp    80105f99 <alltraps>

8010661b <vector12>:
.globl vector12
vector12:
  pushl $12
8010661b:	6a 0c                	push   $0xc
  jmp alltraps
8010661d:	e9 77 f9 ff ff       	jmp    80105f99 <alltraps>

80106622 <vector13>:
.globl vector13
vector13:
  pushl $13
80106622:	6a 0d                	push   $0xd
  jmp alltraps
80106624:	e9 70 f9 ff ff       	jmp    80105f99 <alltraps>

80106629 <vector14>:
.globl vector14
vector14:
  pushl $14
80106629:	6a 0e                	push   $0xe
  jmp alltraps
8010662b:	e9 69 f9 ff ff       	jmp    80105f99 <alltraps>

80106630 <vector15>:
.globl vector15
vector15:
  pushl $0
80106630:	6a 00                	push   $0x0
  pushl $15
80106632:	6a 0f                	push   $0xf
  jmp alltraps
80106634:	e9 60 f9 ff ff       	jmp    80105f99 <alltraps>

80106639 <vector16>:
.globl vector16
vector16:
  pushl $0
80106639:	6a 00                	push   $0x0
  pushl $16
8010663b:	6a 10                	push   $0x10
  jmp alltraps
8010663d:	e9 57 f9 ff ff       	jmp    80105f99 <alltraps>

80106642 <vector17>:
.globl vector17
vector17:
  pushl $17
80106642:	6a 11                	push   $0x11
  jmp alltraps
80106644:	e9 50 f9 ff ff       	jmp    80105f99 <alltraps>

80106649 <vector18>:
.globl vector18
vector18:
  pushl $0
80106649:	6a 00                	push   $0x0
  pushl $18
8010664b:	6a 12                	push   $0x12
  jmp alltraps
8010664d:	e9 47 f9 ff ff       	jmp    80105f99 <alltraps>

80106652 <vector19>:
.globl vector19
vector19:
  pushl $0
80106652:	6a 00                	push   $0x0
  pushl $19
80106654:	6a 13                	push   $0x13
  jmp alltraps
80106656:	e9 3e f9 ff ff       	jmp    80105f99 <alltraps>

8010665b <vector20>:
.globl vector20
vector20:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $20
8010665d:	6a 14                	push   $0x14
  jmp alltraps
8010665f:	e9 35 f9 ff ff       	jmp    80105f99 <alltraps>

80106664 <vector21>:
.globl vector21
vector21:
  pushl $0
80106664:	6a 00                	push   $0x0
  pushl $21
80106666:	6a 15                	push   $0x15
  jmp alltraps
80106668:	e9 2c f9 ff ff       	jmp    80105f99 <alltraps>

8010666d <vector22>:
.globl vector22
vector22:
  pushl $0
8010666d:	6a 00                	push   $0x0
  pushl $22
8010666f:	6a 16                	push   $0x16
  jmp alltraps
80106671:	e9 23 f9 ff ff       	jmp    80105f99 <alltraps>

80106676 <vector23>:
.globl vector23
vector23:
  pushl $0
80106676:	6a 00                	push   $0x0
  pushl $23
80106678:	6a 17                	push   $0x17
  jmp alltraps
8010667a:	e9 1a f9 ff ff       	jmp    80105f99 <alltraps>

8010667f <vector24>:
.globl vector24
vector24:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $24
80106681:	6a 18                	push   $0x18
  jmp alltraps
80106683:	e9 11 f9 ff ff       	jmp    80105f99 <alltraps>

80106688 <vector25>:
.globl vector25
vector25:
  pushl $0
80106688:	6a 00                	push   $0x0
  pushl $25
8010668a:	6a 19                	push   $0x19
  jmp alltraps
8010668c:	e9 08 f9 ff ff       	jmp    80105f99 <alltraps>

80106691 <vector26>:
.globl vector26
vector26:
  pushl $0
80106691:	6a 00                	push   $0x0
  pushl $26
80106693:	6a 1a                	push   $0x1a
  jmp alltraps
80106695:	e9 ff f8 ff ff       	jmp    80105f99 <alltraps>

8010669a <vector27>:
.globl vector27
vector27:
  pushl $0
8010669a:	6a 00                	push   $0x0
  pushl $27
8010669c:	6a 1b                	push   $0x1b
  jmp alltraps
8010669e:	e9 f6 f8 ff ff       	jmp    80105f99 <alltraps>

801066a3 <vector28>:
.globl vector28
vector28:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $28
801066a5:	6a 1c                	push   $0x1c
  jmp alltraps
801066a7:	e9 ed f8 ff ff       	jmp    80105f99 <alltraps>

801066ac <vector29>:
.globl vector29
vector29:
  pushl $0
801066ac:	6a 00                	push   $0x0
  pushl $29
801066ae:	6a 1d                	push   $0x1d
  jmp alltraps
801066b0:	e9 e4 f8 ff ff       	jmp    80105f99 <alltraps>

801066b5 <vector30>:
.globl vector30
vector30:
  pushl $0
801066b5:	6a 00                	push   $0x0
  pushl $30
801066b7:	6a 1e                	push   $0x1e
  jmp alltraps
801066b9:	e9 db f8 ff ff       	jmp    80105f99 <alltraps>

801066be <vector31>:
.globl vector31
vector31:
  pushl $0
801066be:	6a 00                	push   $0x0
  pushl $31
801066c0:	6a 1f                	push   $0x1f
  jmp alltraps
801066c2:	e9 d2 f8 ff ff       	jmp    80105f99 <alltraps>

801066c7 <vector32>:
.globl vector32
vector32:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $32
801066c9:	6a 20                	push   $0x20
  jmp alltraps
801066cb:	e9 c9 f8 ff ff       	jmp    80105f99 <alltraps>

801066d0 <vector33>:
.globl vector33
vector33:
  pushl $0
801066d0:	6a 00                	push   $0x0
  pushl $33
801066d2:	6a 21                	push   $0x21
  jmp alltraps
801066d4:	e9 c0 f8 ff ff       	jmp    80105f99 <alltraps>

801066d9 <vector34>:
.globl vector34
vector34:
  pushl $0
801066d9:	6a 00                	push   $0x0
  pushl $34
801066db:	6a 22                	push   $0x22
  jmp alltraps
801066dd:	e9 b7 f8 ff ff       	jmp    80105f99 <alltraps>

801066e2 <vector35>:
.globl vector35
vector35:
  pushl $0
801066e2:	6a 00                	push   $0x0
  pushl $35
801066e4:	6a 23                	push   $0x23
  jmp alltraps
801066e6:	e9 ae f8 ff ff       	jmp    80105f99 <alltraps>

801066eb <vector36>:
.globl vector36
vector36:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $36
801066ed:	6a 24                	push   $0x24
  jmp alltraps
801066ef:	e9 a5 f8 ff ff       	jmp    80105f99 <alltraps>

801066f4 <vector37>:
.globl vector37
vector37:
  pushl $0
801066f4:	6a 00                	push   $0x0
  pushl $37
801066f6:	6a 25                	push   $0x25
  jmp alltraps
801066f8:	e9 9c f8 ff ff       	jmp    80105f99 <alltraps>

801066fd <vector38>:
.globl vector38
vector38:
  pushl $0
801066fd:	6a 00                	push   $0x0
  pushl $38
801066ff:	6a 26                	push   $0x26
  jmp alltraps
80106701:	e9 93 f8 ff ff       	jmp    80105f99 <alltraps>

80106706 <vector39>:
.globl vector39
vector39:
  pushl $0
80106706:	6a 00                	push   $0x0
  pushl $39
80106708:	6a 27                	push   $0x27
  jmp alltraps
8010670a:	e9 8a f8 ff ff       	jmp    80105f99 <alltraps>

8010670f <vector40>:
.globl vector40
vector40:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $40
80106711:	6a 28                	push   $0x28
  jmp alltraps
80106713:	e9 81 f8 ff ff       	jmp    80105f99 <alltraps>

80106718 <vector41>:
.globl vector41
vector41:
  pushl $0
80106718:	6a 00                	push   $0x0
  pushl $41
8010671a:	6a 29                	push   $0x29
  jmp alltraps
8010671c:	e9 78 f8 ff ff       	jmp    80105f99 <alltraps>

80106721 <vector42>:
.globl vector42
vector42:
  pushl $0
80106721:	6a 00                	push   $0x0
  pushl $42
80106723:	6a 2a                	push   $0x2a
  jmp alltraps
80106725:	e9 6f f8 ff ff       	jmp    80105f99 <alltraps>

8010672a <vector43>:
.globl vector43
vector43:
  pushl $0
8010672a:	6a 00                	push   $0x0
  pushl $43
8010672c:	6a 2b                	push   $0x2b
  jmp alltraps
8010672e:	e9 66 f8 ff ff       	jmp    80105f99 <alltraps>

80106733 <vector44>:
.globl vector44
vector44:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $44
80106735:	6a 2c                	push   $0x2c
  jmp alltraps
80106737:	e9 5d f8 ff ff       	jmp    80105f99 <alltraps>

8010673c <vector45>:
.globl vector45
vector45:
  pushl $0
8010673c:	6a 00                	push   $0x0
  pushl $45
8010673e:	6a 2d                	push   $0x2d
  jmp alltraps
80106740:	e9 54 f8 ff ff       	jmp    80105f99 <alltraps>

80106745 <vector46>:
.globl vector46
vector46:
  pushl $0
80106745:	6a 00                	push   $0x0
  pushl $46
80106747:	6a 2e                	push   $0x2e
  jmp alltraps
80106749:	e9 4b f8 ff ff       	jmp    80105f99 <alltraps>

8010674e <vector47>:
.globl vector47
vector47:
  pushl $0
8010674e:	6a 00                	push   $0x0
  pushl $47
80106750:	6a 2f                	push   $0x2f
  jmp alltraps
80106752:	e9 42 f8 ff ff       	jmp    80105f99 <alltraps>

80106757 <vector48>:
.globl vector48
vector48:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $48
80106759:	6a 30                	push   $0x30
  jmp alltraps
8010675b:	e9 39 f8 ff ff       	jmp    80105f99 <alltraps>

80106760 <vector49>:
.globl vector49
vector49:
  pushl $0
80106760:	6a 00                	push   $0x0
  pushl $49
80106762:	6a 31                	push   $0x31
  jmp alltraps
80106764:	e9 30 f8 ff ff       	jmp    80105f99 <alltraps>

80106769 <vector50>:
.globl vector50
vector50:
  pushl $0
80106769:	6a 00                	push   $0x0
  pushl $50
8010676b:	6a 32                	push   $0x32
  jmp alltraps
8010676d:	e9 27 f8 ff ff       	jmp    80105f99 <alltraps>

80106772 <vector51>:
.globl vector51
vector51:
  pushl $0
80106772:	6a 00                	push   $0x0
  pushl $51
80106774:	6a 33                	push   $0x33
  jmp alltraps
80106776:	e9 1e f8 ff ff       	jmp    80105f99 <alltraps>

8010677b <vector52>:
.globl vector52
vector52:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $52
8010677d:	6a 34                	push   $0x34
  jmp alltraps
8010677f:	e9 15 f8 ff ff       	jmp    80105f99 <alltraps>

80106784 <vector53>:
.globl vector53
vector53:
  pushl $0
80106784:	6a 00                	push   $0x0
  pushl $53
80106786:	6a 35                	push   $0x35
  jmp alltraps
80106788:	e9 0c f8 ff ff       	jmp    80105f99 <alltraps>

8010678d <vector54>:
.globl vector54
vector54:
  pushl $0
8010678d:	6a 00                	push   $0x0
  pushl $54
8010678f:	6a 36                	push   $0x36
  jmp alltraps
80106791:	e9 03 f8 ff ff       	jmp    80105f99 <alltraps>

80106796 <vector55>:
.globl vector55
vector55:
  pushl $0
80106796:	6a 00                	push   $0x0
  pushl $55
80106798:	6a 37                	push   $0x37
  jmp alltraps
8010679a:	e9 fa f7 ff ff       	jmp    80105f99 <alltraps>

8010679f <vector56>:
.globl vector56
vector56:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $56
801067a1:	6a 38                	push   $0x38
  jmp alltraps
801067a3:	e9 f1 f7 ff ff       	jmp    80105f99 <alltraps>

801067a8 <vector57>:
.globl vector57
vector57:
  pushl $0
801067a8:	6a 00                	push   $0x0
  pushl $57
801067aa:	6a 39                	push   $0x39
  jmp alltraps
801067ac:	e9 e8 f7 ff ff       	jmp    80105f99 <alltraps>

801067b1 <vector58>:
.globl vector58
vector58:
  pushl $0
801067b1:	6a 00                	push   $0x0
  pushl $58
801067b3:	6a 3a                	push   $0x3a
  jmp alltraps
801067b5:	e9 df f7 ff ff       	jmp    80105f99 <alltraps>

801067ba <vector59>:
.globl vector59
vector59:
  pushl $0
801067ba:	6a 00                	push   $0x0
  pushl $59
801067bc:	6a 3b                	push   $0x3b
  jmp alltraps
801067be:	e9 d6 f7 ff ff       	jmp    80105f99 <alltraps>

801067c3 <vector60>:
.globl vector60
vector60:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $60
801067c5:	6a 3c                	push   $0x3c
  jmp alltraps
801067c7:	e9 cd f7 ff ff       	jmp    80105f99 <alltraps>

801067cc <vector61>:
.globl vector61
vector61:
  pushl $0
801067cc:	6a 00                	push   $0x0
  pushl $61
801067ce:	6a 3d                	push   $0x3d
  jmp alltraps
801067d0:	e9 c4 f7 ff ff       	jmp    80105f99 <alltraps>

801067d5 <vector62>:
.globl vector62
vector62:
  pushl $0
801067d5:	6a 00                	push   $0x0
  pushl $62
801067d7:	6a 3e                	push   $0x3e
  jmp alltraps
801067d9:	e9 bb f7 ff ff       	jmp    80105f99 <alltraps>

801067de <vector63>:
.globl vector63
vector63:
  pushl $0
801067de:	6a 00                	push   $0x0
  pushl $63
801067e0:	6a 3f                	push   $0x3f
  jmp alltraps
801067e2:	e9 b2 f7 ff ff       	jmp    80105f99 <alltraps>

801067e7 <vector64>:
.globl vector64
vector64:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $64
801067e9:	6a 40                	push   $0x40
  jmp alltraps
801067eb:	e9 a9 f7 ff ff       	jmp    80105f99 <alltraps>

801067f0 <vector65>:
.globl vector65
vector65:
  pushl $0
801067f0:	6a 00                	push   $0x0
  pushl $65
801067f2:	6a 41                	push   $0x41
  jmp alltraps
801067f4:	e9 a0 f7 ff ff       	jmp    80105f99 <alltraps>

801067f9 <vector66>:
.globl vector66
vector66:
  pushl $0
801067f9:	6a 00                	push   $0x0
  pushl $66
801067fb:	6a 42                	push   $0x42
  jmp alltraps
801067fd:	e9 97 f7 ff ff       	jmp    80105f99 <alltraps>

80106802 <vector67>:
.globl vector67
vector67:
  pushl $0
80106802:	6a 00                	push   $0x0
  pushl $67
80106804:	6a 43                	push   $0x43
  jmp alltraps
80106806:	e9 8e f7 ff ff       	jmp    80105f99 <alltraps>

8010680b <vector68>:
.globl vector68
vector68:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $68
8010680d:	6a 44                	push   $0x44
  jmp alltraps
8010680f:	e9 85 f7 ff ff       	jmp    80105f99 <alltraps>

80106814 <vector69>:
.globl vector69
vector69:
  pushl $0
80106814:	6a 00                	push   $0x0
  pushl $69
80106816:	6a 45                	push   $0x45
  jmp alltraps
80106818:	e9 7c f7 ff ff       	jmp    80105f99 <alltraps>

8010681d <vector70>:
.globl vector70
vector70:
  pushl $0
8010681d:	6a 00                	push   $0x0
  pushl $70
8010681f:	6a 46                	push   $0x46
  jmp alltraps
80106821:	e9 73 f7 ff ff       	jmp    80105f99 <alltraps>

80106826 <vector71>:
.globl vector71
vector71:
  pushl $0
80106826:	6a 00                	push   $0x0
  pushl $71
80106828:	6a 47                	push   $0x47
  jmp alltraps
8010682a:	e9 6a f7 ff ff       	jmp    80105f99 <alltraps>

8010682f <vector72>:
.globl vector72
vector72:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $72
80106831:	6a 48                	push   $0x48
  jmp alltraps
80106833:	e9 61 f7 ff ff       	jmp    80105f99 <alltraps>

80106838 <vector73>:
.globl vector73
vector73:
  pushl $0
80106838:	6a 00                	push   $0x0
  pushl $73
8010683a:	6a 49                	push   $0x49
  jmp alltraps
8010683c:	e9 58 f7 ff ff       	jmp    80105f99 <alltraps>

80106841 <vector74>:
.globl vector74
vector74:
  pushl $0
80106841:	6a 00                	push   $0x0
  pushl $74
80106843:	6a 4a                	push   $0x4a
  jmp alltraps
80106845:	e9 4f f7 ff ff       	jmp    80105f99 <alltraps>

8010684a <vector75>:
.globl vector75
vector75:
  pushl $0
8010684a:	6a 00                	push   $0x0
  pushl $75
8010684c:	6a 4b                	push   $0x4b
  jmp alltraps
8010684e:	e9 46 f7 ff ff       	jmp    80105f99 <alltraps>

80106853 <vector76>:
.globl vector76
vector76:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $76
80106855:	6a 4c                	push   $0x4c
  jmp alltraps
80106857:	e9 3d f7 ff ff       	jmp    80105f99 <alltraps>

8010685c <vector77>:
.globl vector77
vector77:
  pushl $0
8010685c:	6a 00                	push   $0x0
  pushl $77
8010685e:	6a 4d                	push   $0x4d
  jmp alltraps
80106860:	e9 34 f7 ff ff       	jmp    80105f99 <alltraps>

80106865 <vector78>:
.globl vector78
vector78:
  pushl $0
80106865:	6a 00                	push   $0x0
  pushl $78
80106867:	6a 4e                	push   $0x4e
  jmp alltraps
80106869:	e9 2b f7 ff ff       	jmp    80105f99 <alltraps>

8010686e <vector79>:
.globl vector79
vector79:
  pushl $0
8010686e:	6a 00                	push   $0x0
  pushl $79
80106870:	6a 4f                	push   $0x4f
  jmp alltraps
80106872:	e9 22 f7 ff ff       	jmp    80105f99 <alltraps>

80106877 <vector80>:
.globl vector80
vector80:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $80
80106879:	6a 50                	push   $0x50
  jmp alltraps
8010687b:	e9 19 f7 ff ff       	jmp    80105f99 <alltraps>

80106880 <vector81>:
.globl vector81
vector81:
  pushl $0
80106880:	6a 00                	push   $0x0
  pushl $81
80106882:	6a 51                	push   $0x51
  jmp alltraps
80106884:	e9 10 f7 ff ff       	jmp    80105f99 <alltraps>

80106889 <vector82>:
.globl vector82
vector82:
  pushl $0
80106889:	6a 00                	push   $0x0
  pushl $82
8010688b:	6a 52                	push   $0x52
  jmp alltraps
8010688d:	e9 07 f7 ff ff       	jmp    80105f99 <alltraps>

80106892 <vector83>:
.globl vector83
vector83:
  pushl $0
80106892:	6a 00                	push   $0x0
  pushl $83
80106894:	6a 53                	push   $0x53
  jmp alltraps
80106896:	e9 fe f6 ff ff       	jmp    80105f99 <alltraps>

8010689b <vector84>:
.globl vector84
vector84:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $84
8010689d:	6a 54                	push   $0x54
  jmp alltraps
8010689f:	e9 f5 f6 ff ff       	jmp    80105f99 <alltraps>

801068a4 <vector85>:
.globl vector85
vector85:
  pushl $0
801068a4:	6a 00                	push   $0x0
  pushl $85
801068a6:	6a 55                	push   $0x55
  jmp alltraps
801068a8:	e9 ec f6 ff ff       	jmp    80105f99 <alltraps>

801068ad <vector86>:
.globl vector86
vector86:
  pushl $0
801068ad:	6a 00                	push   $0x0
  pushl $86
801068af:	6a 56                	push   $0x56
  jmp alltraps
801068b1:	e9 e3 f6 ff ff       	jmp    80105f99 <alltraps>

801068b6 <vector87>:
.globl vector87
vector87:
  pushl $0
801068b6:	6a 00                	push   $0x0
  pushl $87
801068b8:	6a 57                	push   $0x57
  jmp alltraps
801068ba:	e9 da f6 ff ff       	jmp    80105f99 <alltraps>

801068bf <vector88>:
.globl vector88
vector88:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $88
801068c1:	6a 58                	push   $0x58
  jmp alltraps
801068c3:	e9 d1 f6 ff ff       	jmp    80105f99 <alltraps>

801068c8 <vector89>:
.globl vector89
vector89:
  pushl $0
801068c8:	6a 00                	push   $0x0
  pushl $89
801068ca:	6a 59                	push   $0x59
  jmp alltraps
801068cc:	e9 c8 f6 ff ff       	jmp    80105f99 <alltraps>

801068d1 <vector90>:
.globl vector90
vector90:
  pushl $0
801068d1:	6a 00                	push   $0x0
  pushl $90
801068d3:	6a 5a                	push   $0x5a
  jmp alltraps
801068d5:	e9 bf f6 ff ff       	jmp    80105f99 <alltraps>

801068da <vector91>:
.globl vector91
vector91:
  pushl $0
801068da:	6a 00                	push   $0x0
  pushl $91
801068dc:	6a 5b                	push   $0x5b
  jmp alltraps
801068de:	e9 b6 f6 ff ff       	jmp    80105f99 <alltraps>

801068e3 <vector92>:
.globl vector92
vector92:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $92
801068e5:	6a 5c                	push   $0x5c
  jmp alltraps
801068e7:	e9 ad f6 ff ff       	jmp    80105f99 <alltraps>

801068ec <vector93>:
.globl vector93
vector93:
  pushl $0
801068ec:	6a 00                	push   $0x0
  pushl $93
801068ee:	6a 5d                	push   $0x5d
  jmp alltraps
801068f0:	e9 a4 f6 ff ff       	jmp    80105f99 <alltraps>

801068f5 <vector94>:
.globl vector94
vector94:
  pushl $0
801068f5:	6a 00                	push   $0x0
  pushl $94
801068f7:	6a 5e                	push   $0x5e
  jmp alltraps
801068f9:	e9 9b f6 ff ff       	jmp    80105f99 <alltraps>

801068fe <vector95>:
.globl vector95
vector95:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $95
80106900:	6a 5f                	push   $0x5f
  jmp alltraps
80106902:	e9 92 f6 ff ff       	jmp    80105f99 <alltraps>

80106907 <vector96>:
.globl vector96
vector96:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $96
80106909:	6a 60                	push   $0x60
  jmp alltraps
8010690b:	e9 89 f6 ff ff       	jmp    80105f99 <alltraps>

80106910 <vector97>:
.globl vector97
vector97:
  pushl $0
80106910:	6a 00                	push   $0x0
  pushl $97
80106912:	6a 61                	push   $0x61
  jmp alltraps
80106914:	e9 80 f6 ff ff       	jmp    80105f99 <alltraps>

80106919 <vector98>:
.globl vector98
vector98:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $98
8010691b:	6a 62                	push   $0x62
  jmp alltraps
8010691d:	e9 77 f6 ff ff       	jmp    80105f99 <alltraps>

80106922 <vector99>:
.globl vector99
vector99:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $99
80106924:	6a 63                	push   $0x63
  jmp alltraps
80106926:	e9 6e f6 ff ff       	jmp    80105f99 <alltraps>

8010692b <vector100>:
.globl vector100
vector100:
  pushl $0
8010692b:	6a 00                	push   $0x0
  pushl $100
8010692d:	6a 64                	push   $0x64
  jmp alltraps
8010692f:	e9 65 f6 ff ff       	jmp    80105f99 <alltraps>

80106934 <vector101>:
.globl vector101
vector101:
  pushl $0
80106934:	6a 00                	push   $0x0
  pushl $101
80106936:	6a 65                	push   $0x65
  jmp alltraps
80106938:	e9 5c f6 ff ff       	jmp    80105f99 <alltraps>

8010693d <vector102>:
.globl vector102
vector102:
  pushl $0
8010693d:	6a 00                	push   $0x0
  pushl $102
8010693f:	6a 66                	push   $0x66
  jmp alltraps
80106941:	e9 53 f6 ff ff       	jmp    80105f99 <alltraps>

80106946 <vector103>:
.globl vector103
vector103:
  pushl $0
80106946:	6a 00                	push   $0x0
  pushl $103
80106948:	6a 67                	push   $0x67
  jmp alltraps
8010694a:	e9 4a f6 ff ff       	jmp    80105f99 <alltraps>

8010694f <vector104>:
.globl vector104
vector104:
  pushl $0
8010694f:	6a 00                	push   $0x0
  pushl $104
80106951:	6a 68                	push   $0x68
  jmp alltraps
80106953:	e9 41 f6 ff ff       	jmp    80105f99 <alltraps>

80106958 <vector105>:
.globl vector105
vector105:
  pushl $0
80106958:	6a 00                	push   $0x0
  pushl $105
8010695a:	6a 69                	push   $0x69
  jmp alltraps
8010695c:	e9 38 f6 ff ff       	jmp    80105f99 <alltraps>

80106961 <vector106>:
.globl vector106
vector106:
  pushl $0
80106961:	6a 00                	push   $0x0
  pushl $106
80106963:	6a 6a                	push   $0x6a
  jmp alltraps
80106965:	e9 2f f6 ff ff       	jmp    80105f99 <alltraps>

8010696a <vector107>:
.globl vector107
vector107:
  pushl $0
8010696a:	6a 00                	push   $0x0
  pushl $107
8010696c:	6a 6b                	push   $0x6b
  jmp alltraps
8010696e:	e9 26 f6 ff ff       	jmp    80105f99 <alltraps>

80106973 <vector108>:
.globl vector108
vector108:
  pushl $0
80106973:	6a 00                	push   $0x0
  pushl $108
80106975:	6a 6c                	push   $0x6c
  jmp alltraps
80106977:	e9 1d f6 ff ff       	jmp    80105f99 <alltraps>

8010697c <vector109>:
.globl vector109
vector109:
  pushl $0
8010697c:	6a 00                	push   $0x0
  pushl $109
8010697e:	6a 6d                	push   $0x6d
  jmp alltraps
80106980:	e9 14 f6 ff ff       	jmp    80105f99 <alltraps>

80106985 <vector110>:
.globl vector110
vector110:
  pushl $0
80106985:	6a 00                	push   $0x0
  pushl $110
80106987:	6a 6e                	push   $0x6e
  jmp alltraps
80106989:	e9 0b f6 ff ff       	jmp    80105f99 <alltraps>

8010698e <vector111>:
.globl vector111
vector111:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $111
80106990:	6a 6f                	push   $0x6f
  jmp alltraps
80106992:	e9 02 f6 ff ff       	jmp    80105f99 <alltraps>

80106997 <vector112>:
.globl vector112
vector112:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $112
80106999:	6a 70                	push   $0x70
  jmp alltraps
8010699b:	e9 f9 f5 ff ff       	jmp    80105f99 <alltraps>

801069a0 <vector113>:
.globl vector113
vector113:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $113
801069a2:	6a 71                	push   $0x71
  jmp alltraps
801069a4:	e9 f0 f5 ff ff       	jmp    80105f99 <alltraps>

801069a9 <vector114>:
.globl vector114
vector114:
  pushl $0
801069a9:	6a 00                	push   $0x0
  pushl $114
801069ab:	6a 72                	push   $0x72
  jmp alltraps
801069ad:	e9 e7 f5 ff ff       	jmp    80105f99 <alltraps>

801069b2 <vector115>:
.globl vector115
vector115:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $115
801069b4:	6a 73                	push   $0x73
  jmp alltraps
801069b6:	e9 de f5 ff ff       	jmp    80105f99 <alltraps>

801069bb <vector116>:
.globl vector116
vector116:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $116
801069bd:	6a 74                	push   $0x74
  jmp alltraps
801069bf:	e9 d5 f5 ff ff       	jmp    80105f99 <alltraps>

801069c4 <vector117>:
.globl vector117
vector117:
  pushl $0
801069c4:	6a 00                	push   $0x0
  pushl $117
801069c6:	6a 75                	push   $0x75
  jmp alltraps
801069c8:	e9 cc f5 ff ff       	jmp    80105f99 <alltraps>

801069cd <vector118>:
.globl vector118
vector118:
  pushl $0
801069cd:	6a 00                	push   $0x0
  pushl $118
801069cf:	6a 76                	push   $0x76
  jmp alltraps
801069d1:	e9 c3 f5 ff ff       	jmp    80105f99 <alltraps>

801069d6 <vector119>:
.globl vector119
vector119:
  pushl $0
801069d6:	6a 00                	push   $0x0
  pushl $119
801069d8:	6a 77                	push   $0x77
  jmp alltraps
801069da:	e9 ba f5 ff ff       	jmp    80105f99 <alltraps>

801069df <vector120>:
.globl vector120
vector120:
  pushl $0
801069df:	6a 00                	push   $0x0
  pushl $120
801069e1:	6a 78                	push   $0x78
  jmp alltraps
801069e3:	e9 b1 f5 ff ff       	jmp    80105f99 <alltraps>

801069e8 <vector121>:
.globl vector121
vector121:
  pushl $0
801069e8:	6a 00                	push   $0x0
  pushl $121
801069ea:	6a 79                	push   $0x79
  jmp alltraps
801069ec:	e9 a8 f5 ff ff       	jmp    80105f99 <alltraps>

801069f1 <vector122>:
.globl vector122
vector122:
  pushl $0
801069f1:	6a 00                	push   $0x0
  pushl $122
801069f3:	6a 7a                	push   $0x7a
  jmp alltraps
801069f5:	e9 9f f5 ff ff       	jmp    80105f99 <alltraps>

801069fa <vector123>:
.globl vector123
vector123:
  pushl $0
801069fa:	6a 00                	push   $0x0
  pushl $123
801069fc:	6a 7b                	push   $0x7b
  jmp alltraps
801069fe:	e9 96 f5 ff ff       	jmp    80105f99 <alltraps>

80106a03 <vector124>:
.globl vector124
vector124:
  pushl $0
80106a03:	6a 00                	push   $0x0
  pushl $124
80106a05:	6a 7c                	push   $0x7c
  jmp alltraps
80106a07:	e9 8d f5 ff ff       	jmp    80105f99 <alltraps>

80106a0c <vector125>:
.globl vector125
vector125:
  pushl $0
80106a0c:	6a 00                	push   $0x0
  pushl $125
80106a0e:	6a 7d                	push   $0x7d
  jmp alltraps
80106a10:	e9 84 f5 ff ff       	jmp    80105f99 <alltraps>

80106a15 <vector126>:
.globl vector126
vector126:
  pushl $0
80106a15:	6a 00                	push   $0x0
  pushl $126
80106a17:	6a 7e                	push   $0x7e
  jmp alltraps
80106a19:	e9 7b f5 ff ff       	jmp    80105f99 <alltraps>

80106a1e <vector127>:
.globl vector127
vector127:
  pushl $0
80106a1e:	6a 00                	push   $0x0
  pushl $127
80106a20:	6a 7f                	push   $0x7f
  jmp alltraps
80106a22:	e9 72 f5 ff ff       	jmp    80105f99 <alltraps>

80106a27 <vector128>:
.globl vector128
vector128:
  pushl $0
80106a27:	6a 00                	push   $0x0
  pushl $128
80106a29:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106a2e:	e9 66 f5 ff ff       	jmp    80105f99 <alltraps>

80106a33 <vector129>:
.globl vector129
vector129:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $129
80106a35:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106a3a:	e9 5a f5 ff ff       	jmp    80105f99 <alltraps>

80106a3f <vector130>:
.globl vector130
vector130:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $130
80106a41:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106a46:	e9 4e f5 ff ff       	jmp    80105f99 <alltraps>

80106a4b <vector131>:
.globl vector131
vector131:
  pushl $0
80106a4b:	6a 00                	push   $0x0
  pushl $131
80106a4d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106a52:	e9 42 f5 ff ff       	jmp    80105f99 <alltraps>

80106a57 <vector132>:
.globl vector132
vector132:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $132
80106a59:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106a5e:	e9 36 f5 ff ff       	jmp    80105f99 <alltraps>

80106a63 <vector133>:
.globl vector133
vector133:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $133
80106a65:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106a6a:	e9 2a f5 ff ff       	jmp    80105f99 <alltraps>

80106a6f <vector134>:
.globl vector134
vector134:
  pushl $0
80106a6f:	6a 00                	push   $0x0
  pushl $134
80106a71:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106a76:	e9 1e f5 ff ff       	jmp    80105f99 <alltraps>

80106a7b <vector135>:
.globl vector135
vector135:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $135
80106a7d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106a82:	e9 12 f5 ff ff       	jmp    80105f99 <alltraps>

80106a87 <vector136>:
.globl vector136
vector136:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $136
80106a89:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106a8e:	e9 06 f5 ff ff       	jmp    80105f99 <alltraps>

80106a93 <vector137>:
.globl vector137
vector137:
  pushl $0
80106a93:	6a 00                	push   $0x0
  pushl $137
80106a95:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106a9a:	e9 fa f4 ff ff       	jmp    80105f99 <alltraps>

80106a9f <vector138>:
.globl vector138
vector138:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $138
80106aa1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106aa6:	e9 ee f4 ff ff       	jmp    80105f99 <alltraps>

80106aab <vector139>:
.globl vector139
vector139:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $139
80106aad:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106ab2:	e9 e2 f4 ff ff       	jmp    80105f99 <alltraps>

80106ab7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106ab7:	6a 00                	push   $0x0
  pushl $140
80106ab9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106abe:	e9 d6 f4 ff ff       	jmp    80105f99 <alltraps>

80106ac3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $141
80106ac5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106aca:	e9 ca f4 ff ff       	jmp    80105f99 <alltraps>

80106acf <vector142>:
.globl vector142
vector142:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $142
80106ad1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106ad6:	e9 be f4 ff ff       	jmp    80105f99 <alltraps>

80106adb <vector143>:
.globl vector143
vector143:
  pushl $0
80106adb:	6a 00                	push   $0x0
  pushl $143
80106add:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106ae2:	e9 b2 f4 ff ff       	jmp    80105f99 <alltraps>

80106ae7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $144
80106ae9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106aee:	e9 a6 f4 ff ff       	jmp    80105f99 <alltraps>

80106af3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $145
80106af5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106afa:	e9 9a f4 ff ff       	jmp    80105f99 <alltraps>

80106aff <vector146>:
.globl vector146
vector146:
  pushl $0
80106aff:	6a 00                	push   $0x0
  pushl $146
80106b01:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106b06:	e9 8e f4 ff ff       	jmp    80105f99 <alltraps>

80106b0b <vector147>:
.globl vector147
vector147:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $147
80106b0d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106b12:	e9 82 f4 ff ff       	jmp    80105f99 <alltraps>

80106b17 <vector148>:
.globl vector148
vector148:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $148
80106b19:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106b1e:	e9 76 f4 ff ff       	jmp    80105f99 <alltraps>

80106b23 <vector149>:
.globl vector149
vector149:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $149
80106b25:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106b2a:	e9 6a f4 ff ff       	jmp    80105f99 <alltraps>

80106b2f <vector150>:
.globl vector150
vector150:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $150
80106b31:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106b36:	e9 5e f4 ff ff       	jmp    80105f99 <alltraps>

80106b3b <vector151>:
.globl vector151
vector151:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $151
80106b3d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106b42:	e9 52 f4 ff ff       	jmp    80105f99 <alltraps>

80106b47 <vector152>:
.globl vector152
vector152:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $152
80106b49:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106b4e:	e9 46 f4 ff ff       	jmp    80105f99 <alltraps>

80106b53 <vector153>:
.globl vector153
vector153:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $153
80106b55:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106b5a:	e9 3a f4 ff ff       	jmp    80105f99 <alltraps>

80106b5f <vector154>:
.globl vector154
vector154:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $154
80106b61:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106b66:	e9 2e f4 ff ff       	jmp    80105f99 <alltraps>

80106b6b <vector155>:
.globl vector155
vector155:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $155
80106b6d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106b72:	e9 22 f4 ff ff       	jmp    80105f99 <alltraps>

80106b77 <vector156>:
.globl vector156
vector156:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $156
80106b79:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106b7e:	e9 16 f4 ff ff       	jmp    80105f99 <alltraps>

80106b83 <vector157>:
.globl vector157
vector157:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $157
80106b85:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106b8a:	e9 0a f4 ff ff       	jmp    80105f99 <alltraps>

80106b8f <vector158>:
.globl vector158
vector158:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $158
80106b91:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106b96:	e9 fe f3 ff ff       	jmp    80105f99 <alltraps>

80106b9b <vector159>:
.globl vector159
vector159:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $159
80106b9d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ba2:	e9 f2 f3 ff ff       	jmp    80105f99 <alltraps>

80106ba7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $160
80106ba9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106bae:	e9 e6 f3 ff ff       	jmp    80105f99 <alltraps>

80106bb3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $161
80106bb5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106bba:	e9 da f3 ff ff       	jmp    80105f99 <alltraps>

80106bbf <vector162>:
.globl vector162
vector162:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $162
80106bc1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106bc6:	e9 ce f3 ff ff       	jmp    80105f99 <alltraps>

80106bcb <vector163>:
.globl vector163
vector163:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $163
80106bcd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106bd2:	e9 c2 f3 ff ff       	jmp    80105f99 <alltraps>

80106bd7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $164
80106bd9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106bde:	e9 b6 f3 ff ff       	jmp    80105f99 <alltraps>

80106be3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $165
80106be5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106bea:	e9 aa f3 ff ff       	jmp    80105f99 <alltraps>

80106bef <vector166>:
.globl vector166
vector166:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $166
80106bf1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106bf6:	e9 9e f3 ff ff       	jmp    80105f99 <alltraps>

80106bfb <vector167>:
.globl vector167
vector167:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $167
80106bfd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106c02:	e9 92 f3 ff ff       	jmp    80105f99 <alltraps>

80106c07 <vector168>:
.globl vector168
vector168:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $168
80106c09:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106c0e:	e9 86 f3 ff ff       	jmp    80105f99 <alltraps>

80106c13 <vector169>:
.globl vector169
vector169:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $169
80106c15:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106c1a:	e9 7a f3 ff ff       	jmp    80105f99 <alltraps>

80106c1f <vector170>:
.globl vector170
vector170:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $170
80106c21:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106c26:	e9 6e f3 ff ff       	jmp    80105f99 <alltraps>

80106c2b <vector171>:
.globl vector171
vector171:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $171
80106c2d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106c32:	e9 62 f3 ff ff       	jmp    80105f99 <alltraps>

80106c37 <vector172>:
.globl vector172
vector172:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $172
80106c39:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106c3e:	e9 56 f3 ff ff       	jmp    80105f99 <alltraps>

80106c43 <vector173>:
.globl vector173
vector173:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $173
80106c45:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106c4a:	e9 4a f3 ff ff       	jmp    80105f99 <alltraps>

80106c4f <vector174>:
.globl vector174
vector174:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $174
80106c51:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106c56:	e9 3e f3 ff ff       	jmp    80105f99 <alltraps>

80106c5b <vector175>:
.globl vector175
vector175:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $175
80106c5d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106c62:	e9 32 f3 ff ff       	jmp    80105f99 <alltraps>

80106c67 <vector176>:
.globl vector176
vector176:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $176
80106c69:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106c6e:	e9 26 f3 ff ff       	jmp    80105f99 <alltraps>

80106c73 <vector177>:
.globl vector177
vector177:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $177
80106c75:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106c7a:	e9 1a f3 ff ff       	jmp    80105f99 <alltraps>

80106c7f <vector178>:
.globl vector178
vector178:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $178
80106c81:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106c86:	e9 0e f3 ff ff       	jmp    80105f99 <alltraps>

80106c8b <vector179>:
.globl vector179
vector179:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $179
80106c8d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106c92:	e9 02 f3 ff ff       	jmp    80105f99 <alltraps>

80106c97 <vector180>:
.globl vector180
vector180:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $180
80106c99:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106c9e:	e9 f6 f2 ff ff       	jmp    80105f99 <alltraps>

80106ca3 <vector181>:
.globl vector181
vector181:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $181
80106ca5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106caa:	e9 ea f2 ff ff       	jmp    80105f99 <alltraps>

80106caf <vector182>:
.globl vector182
vector182:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $182
80106cb1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106cb6:	e9 de f2 ff ff       	jmp    80105f99 <alltraps>

80106cbb <vector183>:
.globl vector183
vector183:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $183
80106cbd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106cc2:	e9 d2 f2 ff ff       	jmp    80105f99 <alltraps>

80106cc7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $184
80106cc9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106cce:	e9 c6 f2 ff ff       	jmp    80105f99 <alltraps>

80106cd3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $185
80106cd5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106cda:	e9 ba f2 ff ff       	jmp    80105f99 <alltraps>

80106cdf <vector186>:
.globl vector186
vector186:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $186
80106ce1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106ce6:	e9 ae f2 ff ff       	jmp    80105f99 <alltraps>

80106ceb <vector187>:
.globl vector187
vector187:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $187
80106ced:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106cf2:	e9 a2 f2 ff ff       	jmp    80105f99 <alltraps>

80106cf7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $188
80106cf9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106cfe:	e9 96 f2 ff ff       	jmp    80105f99 <alltraps>

80106d03 <vector189>:
.globl vector189
vector189:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $189
80106d05:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106d0a:	e9 8a f2 ff ff       	jmp    80105f99 <alltraps>

80106d0f <vector190>:
.globl vector190
vector190:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $190
80106d11:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106d16:	e9 7e f2 ff ff       	jmp    80105f99 <alltraps>

80106d1b <vector191>:
.globl vector191
vector191:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $191
80106d1d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106d22:	e9 72 f2 ff ff       	jmp    80105f99 <alltraps>

80106d27 <vector192>:
.globl vector192
vector192:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $192
80106d29:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106d2e:	e9 66 f2 ff ff       	jmp    80105f99 <alltraps>

80106d33 <vector193>:
.globl vector193
vector193:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $193
80106d35:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106d3a:	e9 5a f2 ff ff       	jmp    80105f99 <alltraps>

80106d3f <vector194>:
.globl vector194
vector194:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $194
80106d41:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106d46:	e9 4e f2 ff ff       	jmp    80105f99 <alltraps>

80106d4b <vector195>:
.globl vector195
vector195:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $195
80106d4d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106d52:	e9 42 f2 ff ff       	jmp    80105f99 <alltraps>

80106d57 <vector196>:
.globl vector196
vector196:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $196
80106d59:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106d5e:	e9 36 f2 ff ff       	jmp    80105f99 <alltraps>

80106d63 <vector197>:
.globl vector197
vector197:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $197
80106d65:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106d6a:	e9 2a f2 ff ff       	jmp    80105f99 <alltraps>

80106d6f <vector198>:
.globl vector198
vector198:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $198
80106d71:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106d76:	e9 1e f2 ff ff       	jmp    80105f99 <alltraps>

80106d7b <vector199>:
.globl vector199
vector199:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $199
80106d7d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106d82:	e9 12 f2 ff ff       	jmp    80105f99 <alltraps>

80106d87 <vector200>:
.globl vector200
vector200:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $200
80106d89:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106d8e:	e9 06 f2 ff ff       	jmp    80105f99 <alltraps>

80106d93 <vector201>:
.globl vector201
vector201:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $201
80106d95:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106d9a:	e9 fa f1 ff ff       	jmp    80105f99 <alltraps>

80106d9f <vector202>:
.globl vector202
vector202:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $202
80106da1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106da6:	e9 ee f1 ff ff       	jmp    80105f99 <alltraps>

80106dab <vector203>:
.globl vector203
vector203:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $203
80106dad:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106db2:	e9 e2 f1 ff ff       	jmp    80105f99 <alltraps>

80106db7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $204
80106db9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106dbe:	e9 d6 f1 ff ff       	jmp    80105f99 <alltraps>

80106dc3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $205
80106dc5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106dca:	e9 ca f1 ff ff       	jmp    80105f99 <alltraps>

80106dcf <vector206>:
.globl vector206
vector206:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $206
80106dd1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106dd6:	e9 be f1 ff ff       	jmp    80105f99 <alltraps>

80106ddb <vector207>:
.globl vector207
vector207:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $207
80106ddd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106de2:	e9 b2 f1 ff ff       	jmp    80105f99 <alltraps>

80106de7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $208
80106de9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106dee:	e9 a6 f1 ff ff       	jmp    80105f99 <alltraps>

80106df3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $209
80106df5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106dfa:	e9 9a f1 ff ff       	jmp    80105f99 <alltraps>

80106dff <vector210>:
.globl vector210
vector210:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $210
80106e01:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106e06:	e9 8e f1 ff ff       	jmp    80105f99 <alltraps>

80106e0b <vector211>:
.globl vector211
vector211:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $211
80106e0d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106e12:	e9 82 f1 ff ff       	jmp    80105f99 <alltraps>

80106e17 <vector212>:
.globl vector212
vector212:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $212
80106e19:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106e1e:	e9 76 f1 ff ff       	jmp    80105f99 <alltraps>

80106e23 <vector213>:
.globl vector213
vector213:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $213
80106e25:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106e2a:	e9 6a f1 ff ff       	jmp    80105f99 <alltraps>

80106e2f <vector214>:
.globl vector214
vector214:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $214
80106e31:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106e36:	e9 5e f1 ff ff       	jmp    80105f99 <alltraps>

80106e3b <vector215>:
.globl vector215
vector215:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $215
80106e3d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106e42:	e9 52 f1 ff ff       	jmp    80105f99 <alltraps>

80106e47 <vector216>:
.globl vector216
vector216:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $216
80106e49:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106e4e:	e9 46 f1 ff ff       	jmp    80105f99 <alltraps>

80106e53 <vector217>:
.globl vector217
vector217:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $217
80106e55:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106e5a:	e9 3a f1 ff ff       	jmp    80105f99 <alltraps>

80106e5f <vector218>:
.globl vector218
vector218:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $218
80106e61:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106e66:	e9 2e f1 ff ff       	jmp    80105f99 <alltraps>

80106e6b <vector219>:
.globl vector219
vector219:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $219
80106e6d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106e72:	e9 22 f1 ff ff       	jmp    80105f99 <alltraps>

80106e77 <vector220>:
.globl vector220
vector220:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $220
80106e79:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106e7e:	e9 16 f1 ff ff       	jmp    80105f99 <alltraps>

80106e83 <vector221>:
.globl vector221
vector221:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $221
80106e85:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106e8a:	e9 0a f1 ff ff       	jmp    80105f99 <alltraps>

80106e8f <vector222>:
.globl vector222
vector222:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $222
80106e91:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106e96:	e9 fe f0 ff ff       	jmp    80105f99 <alltraps>

80106e9b <vector223>:
.globl vector223
vector223:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $223
80106e9d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106ea2:	e9 f2 f0 ff ff       	jmp    80105f99 <alltraps>

80106ea7 <vector224>:
.globl vector224
vector224:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $224
80106ea9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106eae:	e9 e6 f0 ff ff       	jmp    80105f99 <alltraps>

80106eb3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $225
80106eb5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106eba:	e9 da f0 ff ff       	jmp    80105f99 <alltraps>

80106ebf <vector226>:
.globl vector226
vector226:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $226
80106ec1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106ec6:	e9 ce f0 ff ff       	jmp    80105f99 <alltraps>

80106ecb <vector227>:
.globl vector227
vector227:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $227
80106ecd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106ed2:	e9 c2 f0 ff ff       	jmp    80105f99 <alltraps>

80106ed7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $228
80106ed9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106ede:	e9 b6 f0 ff ff       	jmp    80105f99 <alltraps>

80106ee3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $229
80106ee5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106eea:	e9 aa f0 ff ff       	jmp    80105f99 <alltraps>

80106eef <vector230>:
.globl vector230
vector230:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $230
80106ef1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106ef6:	e9 9e f0 ff ff       	jmp    80105f99 <alltraps>

80106efb <vector231>:
.globl vector231
vector231:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $231
80106efd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106f02:	e9 92 f0 ff ff       	jmp    80105f99 <alltraps>

80106f07 <vector232>:
.globl vector232
vector232:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $232
80106f09:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106f0e:	e9 86 f0 ff ff       	jmp    80105f99 <alltraps>

80106f13 <vector233>:
.globl vector233
vector233:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $233
80106f15:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106f1a:	e9 7a f0 ff ff       	jmp    80105f99 <alltraps>

80106f1f <vector234>:
.globl vector234
vector234:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $234
80106f21:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106f26:	e9 6e f0 ff ff       	jmp    80105f99 <alltraps>

80106f2b <vector235>:
.globl vector235
vector235:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $235
80106f2d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106f32:	e9 62 f0 ff ff       	jmp    80105f99 <alltraps>

80106f37 <vector236>:
.globl vector236
vector236:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $236
80106f39:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106f3e:	e9 56 f0 ff ff       	jmp    80105f99 <alltraps>

80106f43 <vector237>:
.globl vector237
vector237:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $237
80106f45:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106f4a:	e9 4a f0 ff ff       	jmp    80105f99 <alltraps>

80106f4f <vector238>:
.globl vector238
vector238:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $238
80106f51:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106f56:	e9 3e f0 ff ff       	jmp    80105f99 <alltraps>

80106f5b <vector239>:
.globl vector239
vector239:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $239
80106f5d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106f62:	e9 32 f0 ff ff       	jmp    80105f99 <alltraps>

80106f67 <vector240>:
.globl vector240
vector240:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $240
80106f69:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106f6e:	e9 26 f0 ff ff       	jmp    80105f99 <alltraps>

80106f73 <vector241>:
.globl vector241
vector241:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $241
80106f75:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106f7a:	e9 1a f0 ff ff       	jmp    80105f99 <alltraps>

80106f7f <vector242>:
.globl vector242
vector242:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $242
80106f81:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106f86:	e9 0e f0 ff ff       	jmp    80105f99 <alltraps>

80106f8b <vector243>:
.globl vector243
vector243:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $243
80106f8d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106f92:	e9 02 f0 ff ff       	jmp    80105f99 <alltraps>

80106f97 <vector244>:
.globl vector244
vector244:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $244
80106f99:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106f9e:	e9 f6 ef ff ff       	jmp    80105f99 <alltraps>

80106fa3 <vector245>:
.globl vector245
vector245:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $245
80106fa5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106faa:	e9 ea ef ff ff       	jmp    80105f99 <alltraps>

80106faf <vector246>:
.globl vector246
vector246:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $246
80106fb1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106fb6:	e9 de ef ff ff       	jmp    80105f99 <alltraps>

80106fbb <vector247>:
.globl vector247
vector247:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $247
80106fbd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106fc2:	e9 d2 ef ff ff       	jmp    80105f99 <alltraps>

80106fc7 <vector248>:
.globl vector248
vector248:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $248
80106fc9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106fce:	e9 c6 ef ff ff       	jmp    80105f99 <alltraps>

80106fd3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $249
80106fd5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106fda:	e9 ba ef ff ff       	jmp    80105f99 <alltraps>

80106fdf <vector250>:
.globl vector250
vector250:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $250
80106fe1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106fe6:	e9 ae ef ff ff       	jmp    80105f99 <alltraps>

80106feb <vector251>:
.globl vector251
vector251:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $251
80106fed:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ff2:	e9 a2 ef ff ff       	jmp    80105f99 <alltraps>

80106ff7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $252
80106ff9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106ffe:	e9 96 ef ff ff       	jmp    80105f99 <alltraps>

80107003 <vector253>:
.globl vector253
vector253:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $253
80107005:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010700a:	e9 8a ef ff ff       	jmp    80105f99 <alltraps>

8010700f <vector254>:
.globl vector254
vector254:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $254
80107011:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107016:	e9 7e ef ff ff       	jmp    80105f99 <alltraps>

8010701b <vector255>:
.globl vector255
vector255:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $255
8010701d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107022:	e9 72 ef ff ff       	jmp    80105f99 <alltraps>
80107027:	66 90                	xchg   %ax,%ax
80107029:	66 90                	xchg   %ax,%ax
8010702b:	66 90                	xchg   %ax,%ax
8010702d:	66 90                	xchg   %ax,%ax
8010702f:	90                   	nop

80107030 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107036:	89 d3                	mov    %edx,%ebx
{
80107038:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
8010703a:	c1 eb 16             	shr    $0x16,%ebx
8010703d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80107040:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107043:	8b 06                	mov    (%esi),%eax
80107045:	a8 01                	test   $0x1,%al
80107047:	74 27                	je     80107070 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107049:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010704e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107054:	c1 ef 0a             	shr    $0xa,%edi
}
80107057:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
8010705a:	89 fa                	mov    %edi,%edx
8010705c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107062:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80107065:	5b                   	pop    %ebx
80107066:	5e                   	pop    %esi
80107067:	5f                   	pop    %edi
80107068:	5d                   	pop    %ebp
80107069:	c3                   	ret    
8010706a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107070:	85 c9                	test   %ecx,%ecx
80107072:	74 2c                	je     801070a0 <walkpgdir+0x70>
80107074:	e8 e7 b8 ff ff       	call   80102960 <kalloc>
80107079:	85 c0                	test   %eax,%eax
8010707b:	89 c3                	mov    %eax,%ebx
8010707d:	74 21                	je     801070a0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010707f:	83 ec 04             	sub    $0x4,%esp
80107082:	68 00 10 00 00       	push   $0x1000
80107087:	6a 00                	push   $0x0
80107089:	50                   	push   %eax
8010708a:	e8 e1 dc ff ff       	call   80104d70 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010708f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107095:	83 c4 10             	add    $0x10,%esp
80107098:	83 c8 07             	or     $0x7,%eax
8010709b:	89 06                	mov    %eax,(%esi)
8010709d:	eb b5                	jmp    80107054 <walkpgdir+0x24>
8010709f:	90                   	nop
}
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801070a3:	31 c0                	xor    %eax,%eax
}
801070a5:	5b                   	pop    %ebx
801070a6:	5e                   	pop    %esi
801070a7:	5f                   	pop    %edi
801070a8:	5d                   	pop    %ebp
801070a9:	c3                   	ret    
801070aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801070b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	57                   	push   %edi
801070b4:	56                   	push   %esi
801070b5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801070b6:	89 d3                	mov    %edx,%ebx
801070b8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801070be:	83 ec 1c             	sub    $0x1c,%esp
801070c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801070c4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801070c8:	8b 7d 08             	mov    0x8(%ebp),%edi
801070cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801070d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801070d6:	29 df                	sub    %ebx,%edi
801070d8:	83 c8 01             	or     $0x1,%eax
801070db:	89 45 dc             	mov    %eax,-0x24(%ebp)
801070de:	eb 15                	jmp    801070f5 <mappages+0x45>
    if(*pte & PTE_P)
801070e0:	f6 00 01             	testb  $0x1,(%eax)
801070e3:	75 45                	jne    8010712a <mappages+0x7a>
    *pte = pa | perm | PTE_P;
801070e5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801070e8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
801070eb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801070ed:	74 31                	je     80107120 <mappages+0x70>
      break;
    a += PGSIZE;
801070ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801070f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801070fd:	89 da                	mov    %ebx,%edx
801070ff:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107102:	e8 29 ff ff ff       	call   80107030 <walkpgdir>
80107107:	85 c0                	test   %eax,%eax
80107109:	75 d5                	jne    801070e0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
8010710b:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010710e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107113:	5b                   	pop    %ebx
80107114:	5e                   	pop    %esi
80107115:	5f                   	pop    %edi
80107116:	5d                   	pop    %ebp
80107117:	c3                   	ret    
80107118:	90                   	nop
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107120:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107123:	31 c0                	xor    %eax,%eax
}
80107125:	5b                   	pop    %ebx
80107126:	5e                   	pop    %esi
80107127:	5f                   	pop    %edi
80107128:	5d                   	pop    %ebp
80107129:	c3                   	ret    
      panic("remap");
8010712a:	83 ec 0c             	sub    $0xc,%esp
8010712d:	68 80 8a 10 80       	push   $0x80108a80
80107132:	e8 59 92 ff ff       	call   80100390 <panic>
80107137:	89 f6                	mov    %esi,%esi
80107139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107140 <seginit>:
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107146:	e8 25 cd ff ff       	call   80103e70 <cpuid>
8010714b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
80107151:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107156:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010715a:	c7 80 18 b8 14 80 ff 	movl   $0xffff,-0x7feb47e8(%eax)
80107161:	ff 00 00 
80107164:	c7 80 1c b8 14 80 00 	movl   $0xcf9a00,-0x7feb47e4(%eax)
8010716b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010716e:	c7 80 20 b8 14 80 ff 	movl   $0xffff,-0x7feb47e0(%eax)
80107175:	ff 00 00 
80107178:	c7 80 24 b8 14 80 00 	movl   $0xcf9200,-0x7feb47dc(%eax)
8010717f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107182:	c7 80 28 b8 14 80 ff 	movl   $0xffff,-0x7feb47d8(%eax)
80107189:	ff 00 00 
8010718c:	c7 80 2c b8 14 80 00 	movl   $0xcffa00,-0x7feb47d4(%eax)
80107193:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107196:	c7 80 30 b8 14 80 ff 	movl   $0xffff,-0x7feb47d0(%eax)
8010719d:	ff 00 00 
801071a0:	c7 80 34 b8 14 80 00 	movl   $0xcff200,-0x7feb47cc(%eax)
801071a7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801071aa:	05 10 b8 14 80       	add    $0x8014b810,%eax
  pd[1] = (uint)p;
801071af:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801071b3:	c1 e8 10             	shr    $0x10,%eax
801071b6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801071ba:	8d 45 f2             	lea    -0xe(%ebp),%eax
801071bd:	0f 01 10             	lgdtl  (%eax)
}
801071c0:	c9                   	leave  
801071c1:	c3                   	ret    
801071c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071d0 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071d0:	a1 c4 79 15 80       	mov    0x801579c4,%eax
{
801071d5:	55                   	push   %ebp
801071d6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801071d8:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801071dd:	0f 22 d8             	mov    %eax,%cr3
}
801071e0:	5d                   	pop    %ebp
801071e1:	c3                   	ret    
801071e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071f0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801071f0:	55                   	push   %ebp
801071f1:	89 e5                	mov    %esp,%ebp
801071f3:	57                   	push   %edi
801071f4:	56                   	push   %esi
801071f5:	53                   	push   %ebx
801071f6:	83 ec 1c             	sub    $0x1c,%esp
801071f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
801071fc:	85 db                	test   %ebx,%ebx
801071fe:	0f 84 cb 00 00 00    	je     801072cf <switchuvm+0xdf>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107204:	8b 43 08             	mov    0x8(%ebx),%eax
80107207:	85 c0                	test   %eax,%eax
80107209:	0f 84 da 00 00 00    	je     801072e9 <switchuvm+0xf9>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010720f:	8b 43 04             	mov    0x4(%ebx),%eax
80107212:	85 c0                	test   %eax,%eax
80107214:	0f 84 c2 00 00 00    	je     801072dc <switchuvm+0xec>
    panic("switchuvm: no pgdir");

  pushcli();
8010721a:	e8 71 d9 ff ff       	call   80104b90 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010721f:	e8 cc cb ff ff       	call   80103df0 <mycpu>
80107224:	89 c6                	mov    %eax,%esi
80107226:	e8 c5 cb ff ff       	call   80103df0 <mycpu>
8010722b:	89 c7                	mov    %eax,%edi
8010722d:	e8 be cb ff ff       	call   80103df0 <mycpu>
80107232:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107235:	83 c7 08             	add    $0x8,%edi
80107238:	e8 b3 cb ff ff       	call   80103df0 <mycpu>
8010723d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107240:	83 c0 08             	add    $0x8,%eax
80107243:	ba 67 00 00 00       	mov    $0x67,%edx
80107248:	c1 e8 18             	shr    $0x18,%eax
8010724b:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
80107252:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
80107259:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010725f:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107264:	83 c1 08             	add    $0x8,%ecx
80107267:	c1 e9 10             	shr    $0x10,%ecx
8010726a:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
80107270:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107275:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010727c:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
80107281:	e8 6a cb ff ff       	call   80103df0 <mycpu>
80107286:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010728d:	e8 5e cb ff ff       	call   80103df0 <mycpu>
80107292:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107296:	8b 73 08             	mov    0x8(%ebx),%esi
80107299:	e8 52 cb ff ff       	call   80103df0 <mycpu>
8010729e:	81 c6 00 10 00 00    	add    $0x1000,%esi
801072a4:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801072a7:	e8 44 cb ff ff       	call   80103df0 <mycpu>
801072ac:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801072b0:	b8 28 00 00 00       	mov    $0x28,%eax
801072b5:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
801072b8:	8b 43 04             	mov    0x4(%ebx),%eax
801072bb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801072c0:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
801072c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072c6:	5b                   	pop    %ebx
801072c7:	5e                   	pop    %esi
801072c8:	5f                   	pop    %edi
801072c9:	5d                   	pop    %ebp
  popcli();
801072ca:	e9 01 d9 ff ff       	jmp    80104bd0 <popcli>
    panic("switchuvm: no process");
801072cf:	83 ec 0c             	sub    $0xc,%esp
801072d2:	68 86 8a 10 80       	push   $0x80108a86
801072d7:	e8 b4 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801072dc:	83 ec 0c             	sub    $0xc,%esp
801072df:	68 b1 8a 10 80       	push   $0x80108ab1
801072e4:	e8 a7 90 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801072e9:	83 ec 0c             	sub    $0xc,%esp
801072ec:	68 9c 8a 10 80       	push   $0x80108a9c
801072f1:	e8 9a 90 ff ff       	call   80100390 <panic>
801072f6:	8d 76 00             	lea    0x0(%esi),%esi
801072f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107300 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107300:	55                   	push   %ebp
80107301:	89 e5                	mov    %esp,%ebp
80107303:	57                   	push   %edi
80107304:	56                   	push   %esi
80107305:	53                   	push   %ebx
80107306:	83 ec 1c             	sub    $0x1c,%esp
80107309:	8b 75 10             	mov    0x10(%ebp),%esi
8010730c:	8b 45 08             	mov    0x8(%ebp),%eax
8010730f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107312:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107318:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010731b:	77 49                	ja     80107366 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010731d:	e8 3e b6 ff ff       	call   80102960 <kalloc>
  memset(mem, 0, PGSIZE);
80107322:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107325:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107327:	68 00 10 00 00       	push   $0x1000
8010732c:	6a 00                	push   $0x0
8010732e:	50                   	push   %eax
8010732f:	e8 3c da ff ff       	call   80104d70 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107334:	58                   	pop    %eax
80107335:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010733b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107340:	5a                   	pop    %edx
80107341:	6a 06                	push   $0x6
80107343:	50                   	push   %eax
80107344:	31 d2                	xor    %edx,%edx
80107346:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107349:	e8 62 fd ff ff       	call   801070b0 <mappages>
  memmove(mem, init, sz);
8010734e:	89 75 10             	mov    %esi,0x10(%ebp)
80107351:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107354:	83 c4 10             	add    $0x10,%esp
80107357:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010735a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010735d:	5b                   	pop    %ebx
8010735e:	5e                   	pop    %esi
8010735f:	5f                   	pop    %edi
80107360:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107361:	e9 ba da ff ff       	jmp    80104e20 <memmove>
    panic("inituvm: more than a page");
80107366:	83 ec 0c             	sub    $0xc,%esp
80107369:	68 c5 8a 10 80       	push   $0x80108ac5
8010736e:	e8 1d 90 ff ff       	call   80100390 <panic>
80107373:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107380 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107380:	55                   	push   %ebp
80107381:	89 e5                	mov    %esp,%ebp
80107383:	57                   	push   %edi
80107384:	56                   	push   %esi
80107385:	53                   	push   %ebx
80107386:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107389:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107390:	0f 85 91 00 00 00    	jne    80107427 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107396:	8b 75 18             	mov    0x18(%ebp),%esi
80107399:	31 db                	xor    %ebx,%ebx
8010739b:	85 f6                	test   %esi,%esi
8010739d:	75 1a                	jne    801073b9 <loaduvm+0x39>
8010739f:	eb 6f                	jmp    80107410 <loaduvm+0x90>
801073a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801073ae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801073b4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801073b7:	76 57                	jbe    80107410 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801073b9:	8b 55 0c             	mov    0xc(%ebp),%edx
801073bc:	8b 45 08             	mov    0x8(%ebp),%eax
801073bf:	31 c9                	xor    %ecx,%ecx
801073c1:	01 da                	add    %ebx,%edx
801073c3:	e8 68 fc ff ff       	call   80107030 <walkpgdir>
801073c8:	85 c0                	test   %eax,%eax
801073ca:	74 4e                	je     8010741a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801073cc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
801073d1:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801073d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801073db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801073e1:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801073e4:	01 d9                	add    %ebx,%ecx
801073e6:	05 00 00 00 80       	add    $0x80000000,%eax
801073eb:	57                   	push   %edi
801073ec:	51                   	push   %ecx
801073ed:	50                   	push   %eax
801073ee:	ff 75 10             	pushl  0x10(%ebp)
801073f1:	e8 ea a5 ff ff       	call   801019e0 <readi>
801073f6:	83 c4 10             	add    $0x10,%esp
801073f9:	39 f8                	cmp    %edi,%eax
801073fb:	74 ab                	je     801073a8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801073fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107405:	5b                   	pop    %ebx
80107406:	5e                   	pop    %esi
80107407:	5f                   	pop    %edi
80107408:	5d                   	pop    %ebp
80107409:	c3                   	ret    
8010740a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107410:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107413:	31 c0                	xor    %eax,%eax
}
80107415:	5b                   	pop    %ebx
80107416:	5e                   	pop    %esi
80107417:	5f                   	pop    %edi
80107418:	5d                   	pop    %ebp
80107419:	c3                   	ret    
      panic("loaduvm: address should exist");
8010741a:	83 ec 0c             	sub    $0xc,%esp
8010741d:	68 df 8a 10 80       	push   $0x80108adf
80107422:	e8 69 8f ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107427:	83 ec 0c             	sub    $0xc,%esp
8010742a:	68 34 8c 10 80       	push   $0x80108c34
8010742f:	e8 5c 8f ff ff       	call   80100390 <panic>
80107434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010743a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107440 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107440:	55                   	push   %ebp
80107441:	89 e5                	mov    %esp,%ebp
80107443:	57                   	push   %edi
80107444:	56                   	push   %esi
80107445:	53                   	push   %ebx
80107446:	83 ec 1c             	sub    $0x1c,%esp
  #ifndef NONE
    struct proc *p = myproc();
80107449:	e8 42 ca ff ff       	call   80103e90 <myproc>
8010744e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  #endif

  pte_t *pte;
  uint a, pa;
  if(newsz >= oldsz){
80107451:	8b 45 0c             	mov    0xc(%ebp),%eax
80107454:	39 45 10             	cmp    %eax,0x10(%ebp)
80107457:	0f 83 53 01 00 00    	jae    801075b0 <deallocuvm+0x170>
    cprintf("\n%d  %d\n",oldsz,newsz);
    return oldsz;
  }

  a = PGROUNDUP(newsz);
8010745d:	8b 45 10             	mov    0x10(%ebp),%eax
80107460:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107466:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010746c:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010746f:	77 21                	ja     80107492 <deallocuvm+0x52>
80107471:	eb 48                	jmp    801074bb <deallocuvm+0x7b>
80107473:	90                   	nop
80107474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107478:	8b 00                	mov    (%eax),%eax
8010747a:	a8 01                	test   $0x1,%al
8010747c:	75 52                	jne    801074d0 <deallocuvm+0x90>

      char *v = P2V(pa);
      kfree(v);

      *pte = 0;
    }else if((*pte & PTE_PG) && myproc()->pgdir == pgdir){//
8010747e:	f6 c4 02             	test   $0x2,%ah
80107481:	0f 85 b9 00 00 00    	jne    80107540 <deallocuvm+0x100>
  for(; a  < oldsz; a += PGSIZE){
80107487:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010748d:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80107490:	76 29                	jbe    801074bb <deallocuvm+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107492:	8b 45 08             	mov    0x8(%ebp),%eax
80107495:	31 c9                	xor    %ecx,%ecx
80107497:	89 da                	mov    %ebx,%edx
80107499:	e8 92 fb ff ff       	call   80107030 <walkpgdir>
    if(!pte)
8010749e:	85 c0                	test   %eax,%eax
    pte = walkpgdir(pgdir, (char*)a, 0);
801074a0:	89 c6                	mov    %eax,%esi
    if(!pte)
801074a2:	75 d4                	jne    80107478 <deallocuvm+0x38>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801074a4:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801074aa:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074b0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074b6:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801074b9:	77 d7                	ja     80107492 <deallocuvm+0x52>
        }
        #endif

      }//
  }
  return newsz;
801074bb:	8b 45 10             	mov    0x10(%ebp),%eax
}
801074be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074c1:	5b                   	pop    %ebx
801074c2:	5e                   	pop    %esi
801074c3:	5f                   	pop    %edi
801074c4:	5d                   	pop    %ebp
801074c5:	c3                   	ret    
801074c6:	8d 76 00             	lea    0x0(%esi),%esi
801074c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      if(pa == 0)
801074d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801074d8:	0f 84 fe 00 00 00    	je     801075dc <deallocuvm+0x19c>
        for(i = 0; i < MAX_PSYC_PAGES; i++){
801074de:	31 ff                	xor    %edi,%edi
801074e0:	eb 0e                	jmp    801074f0 <deallocuvm+0xb0>
801074e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801074e8:	83 c7 01             	add    $0x1,%edi
801074eb:	83 ff 10             	cmp    $0x10,%edi
801074ee:	74 27                	je     80107517 <deallocuvm+0xd7>
            if(myproc()->physicalPGs[i].va == (char*)a){
801074f0:	e8 9b c9 ff ff       	call   80103e90 <myproc>
801074f5:	8d 14 bf             	lea    (%edi,%edi,4),%edx
801074f8:	39 9c 90 90 01 00 00 	cmp    %ebx,0x190(%eax,%edx,4)
801074ff:	75 e7                	jne    801074e8 <deallocuvm+0xa8>
                p->nPgsPhysical--;
80107501:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107504:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
              myproc()->nPgsPhysical--;
8010750b:	e8 80 c9 ff ff       	call   80103e90 <myproc>
80107510:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
      char *v = P2V(pa);
80107517:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      kfree(v);
8010751a:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010751d:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107522:	50                   	push   %eax
80107523:	e8 f8 b1 ff ff       	call   80102720 <kfree>
      *pte = 0;
80107528:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010752e:	83 c4 10             	add    $0x10,%esp
80107531:	e9 51 ff ff ff       	jmp    80107487 <deallocuvm+0x47>
80107536:	8d 76 00             	lea    0x0(%esi),%esi
80107539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    }else if((*pte & PTE_PG) && myproc()->pgdir == pgdir){//
80107540:	e8 4b c9 ff ff       	call   80103e90 <myproc>
80107545:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107548:	39 48 04             	cmp    %ecx,0x4(%eax)
8010754b:	0f 85 36 ff ff ff    	jne    80107487 <deallocuvm+0x47>
        for(i = 0; i <= MAX_PSYC_PAGES; i++){
80107551:	31 d2                	xor    %edx,%edx
80107553:	89 d7                	mov    %edx,%edi
80107555:	eb 11                	jmp    80107568 <deallocuvm+0x128>
80107557:	89 f6                	mov    %esi,%esi
80107559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107560:	83 c7 01             	add    $0x1,%edi
          if(i==MAX_PSYC_PAGES){
80107563:	83 ff 10             	cmp    $0x10,%edi
80107566:	74 67                	je     801075cf <deallocuvm+0x18f>
          if(myproc()->swappedPGs[i].va == (char*)a){
80107568:	8d 77 09             	lea    0x9(%edi),%esi
8010756b:	e8 20 c9 ff ff       	call   80103e90 <myproc>
80107570:	c1 e6 04             	shl    $0x4,%esi
80107573:	39 5c 30 0c          	cmp    %ebx,0xc(%eax,%esi,1)
80107577:	75 e7                	jne    80107560 <deallocuvm+0x120>
            cprintf("cleaned2\n");
80107579:	83 ec 0c             	sub    $0xc,%esp
8010757c:	68 22 8b 10 80       	push   $0x80108b22
80107581:	e8 da 90 ff ff       	call   80100660 <cprintf>
            myproc()->swappedPGs[i].va = (char*) 0xffffffff;
80107586:	e8 05 c9 ff ff       	call   80103e90 <myproc>
8010758b:	c7 44 30 0c ff ff ff 	movl   $0xffffffff,0xc(%eax,%esi,1)
80107592:	ff 
            myproc()->nPgsSwap--;
80107593:	e8 f8 c8 ff ff       	call   80103e90 <myproc>
            break;
80107598:	83 c4 10             	add    $0x10,%esp
            myproc()->nPgsSwap--;
8010759b:	83 a8 84 00 00 00 01 	subl   $0x1,0x84(%eax)
            break;
801075a2:	e9 e0 fe ff ff       	jmp    80107487 <deallocuvm+0x47>
801075a7:	89 f6                	mov    %esi,%esi
801075a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    cprintf("\n%d  %d\n",oldsz,newsz);
801075b0:	83 ec 04             	sub    $0x4,%esp
801075b3:	ff 75 10             	pushl  0x10(%ebp)
801075b6:	50                   	push   %eax
801075b7:	68 fd 8a 10 80       	push   $0x80108afd
801075bc:	e8 9f 90 ff ff       	call   80100660 <cprintf>
    return oldsz;
801075c1:	8b 45 0c             	mov    0xc(%ebp),%eax
801075c4:	83 c4 10             	add    $0x10,%esp
}
801075c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075ca:	5b                   	pop    %ebx
801075cb:	5e                   	pop    %esi
801075cc:	5f                   	pop    %edi
801075cd:	5d                   	pop    %ebp
801075ce:	c3                   	ret    
            panic("deallocuvm: cant find page2");
801075cf:	83 ec 0c             	sub    $0xc,%esp
801075d2:	68 06 8b 10 80       	push   $0x80108b06
801075d7:	e8 b4 8d ff ff       	call   80100390 <panic>
        panic("kfree");
801075dc:	83 ec 0c             	sub    $0xc,%esp
801075df:	68 ea 82 10 80       	push   $0x801082ea
801075e4:	e8 a7 8d ff ff       	call   80100390 <panic>
801075e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801075f0:	55                   	push   %ebp
801075f1:	89 e5                	mov    %esp,%ebp
801075f3:	57                   	push   %edi
801075f4:	56                   	push   %esi
801075f5:	53                   	push   %ebx
801075f6:	83 ec 0c             	sub    $0xc,%esp
801075f9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801075fc:	85 f6                	test   %esi,%esi
801075fe:	74 59                	je     80107659 <freevm+0x69>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80107600:	83 ec 04             	sub    $0x4,%esp
80107603:	89 f3                	mov    %esi,%ebx
80107605:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010760b:	6a 00                	push   $0x0
8010760d:	68 00 00 00 80       	push   $0x80000000
80107612:	56                   	push   %esi
80107613:	e8 28 fe ff ff       	call   80107440 <deallocuvm>
80107618:	83 c4 10             	add    $0x10,%esp
8010761b:	eb 0a                	jmp    80107627 <freevm+0x37>
8010761d:	8d 76 00             	lea    0x0(%esi),%esi
80107620:	83 c3 04             	add    $0x4,%ebx
  for(i = 0; i < NPDENTRIES; i++){
80107623:	39 fb                	cmp    %edi,%ebx
80107625:	74 23                	je     8010764a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107627:	8b 03                	mov    (%ebx),%eax
80107629:	a8 01                	test   $0x1,%al
8010762b:	74 f3                	je     80107620 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010762d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107632:	83 ec 0c             	sub    $0xc,%esp
80107635:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107638:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010763d:	50                   	push   %eax
8010763e:	e8 dd b0 ff ff       	call   80102720 <kfree>
80107643:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107646:	39 fb                	cmp    %edi,%ebx
80107648:	75 dd                	jne    80107627 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010764a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010764d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107650:	5b                   	pop    %ebx
80107651:	5e                   	pop    %esi
80107652:	5f                   	pop    %edi
80107653:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107654:	e9 c7 b0 ff ff       	jmp    80102720 <kfree>
    panic("freevm: no pgdir");
80107659:	83 ec 0c             	sub    $0xc,%esp
8010765c:	68 2c 8b 10 80       	push   $0x80108b2c
80107661:	e8 2a 8d ff ff       	call   80100390 <panic>
80107666:	8d 76 00             	lea    0x0(%esi),%esi
80107669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107670 <setupkvm>:
{
80107670:	55                   	push   %ebp
80107671:	89 e5                	mov    %esp,%ebp
80107673:	56                   	push   %esi
80107674:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107675:	e8 e6 b2 ff ff       	call   80102960 <kalloc>
8010767a:	85 c0                	test   %eax,%eax
8010767c:	89 c6                	mov    %eax,%esi
8010767e:	74 42                	je     801076c2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107680:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107683:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107688:	68 00 10 00 00       	push   $0x1000
8010768d:	6a 00                	push   $0x0
8010768f:	50                   	push   %eax
80107690:	e8 db d6 ff ff       	call   80104d70 <memset>
80107695:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107698:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010769b:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010769e:	83 ec 08             	sub    $0x8,%esp
801076a1:	8b 13                	mov    (%ebx),%edx
801076a3:	ff 73 0c             	pushl  0xc(%ebx)
801076a6:	50                   	push   %eax
801076a7:	29 c1                	sub    %eax,%ecx
801076a9:	89 f0                	mov    %esi,%eax
801076ab:	e8 00 fa ff ff       	call   801070b0 <mappages>
801076b0:	83 c4 10             	add    $0x10,%esp
801076b3:	85 c0                	test   %eax,%eax
801076b5:	78 19                	js     801076d0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801076b7:	83 c3 10             	add    $0x10,%ebx
801076ba:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801076c0:	75 d6                	jne    80107698 <setupkvm+0x28>
}
801076c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076c5:	89 f0                	mov    %esi,%eax
801076c7:	5b                   	pop    %ebx
801076c8:	5e                   	pop    %esi
801076c9:	5d                   	pop    %ebp
801076ca:	c3                   	ret    
801076cb:	90                   	nop
801076cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801076d0:	83 ec 0c             	sub    $0xc,%esp
801076d3:	56                   	push   %esi
      return 0;
801076d4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801076d6:	e8 15 ff ff ff       	call   801075f0 <freevm>
      return 0;
801076db:	83 c4 10             	add    $0x10,%esp
}
801076de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076e1:	89 f0                	mov    %esi,%eax
801076e3:	5b                   	pop    %ebx
801076e4:	5e                   	pop    %esi
801076e5:	5d                   	pop    %ebp
801076e6:	c3                   	ret    
801076e7:	89 f6                	mov    %esi,%esi
801076e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076f0 <kvmalloc>:
{
801076f0:	55                   	push   %ebp
801076f1:	89 e5                	mov    %esp,%ebp
801076f3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801076f6:	e8 75 ff ff ff       	call   80107670 <setupkvm>
801076fb:	a3 c4 79 15 80       	mov    %eax,0x801579c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107700:	05 00 00 00 80       	add    $0x80000000,%eax
80107705:	0f 22 d8             	mov    %eax,%cr3
}
80107708:	c9                   	leave  
80107709:	c3                   	ret    
8010770a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107710 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107710:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107711:	31 c9                	xor    %ecx,%ecx
{
80107713:	89 e5                	mov    %esp,%ebp
80107715:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107718:	8b 55 0c             	mov    0xc(%ebp),%edx
8010771b:	8b 45 08             	mov    0x8(%ebp),%eax
8010771e:	e8 0d f9 ff ff       	call   80107030 <walkpgdir>
  if(pte == 0)
80107723:	85 c0                	test   %eax,%eax
80107725:	74 05                	je     8010772c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107727:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010772a:	c9                   	leave  
8010772b:	c3                   	ret    
    panic("clearpteu");
8010772c:	83 ec 0c             	sub    $0xc,%esp
8010772f:	68 3d 8b 10 80       	push   $0x80108b3d
80107734:	e8 57 8c ff ff       	call   80100390 <panic>
80107739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107740 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107740:	55                   	push   %ebp
80107741:	89 e5                	mov    %esp,%ebp
80107743:	57                   	push   %edi
80107744:	56                   	push   %esi
80107745:	53                   	push   %ebx
80107746:	83 ec 0c             	sub    $0xc,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;

  if((d = setupkvm()) == 0)
80107749:	e8 22 ff ff ff       	call   80107670 <setupkvm>
8010774e:	85 c0                	test   %eax,%eax
80107750:	89 c7                	mov    %eax,%edi
80107752:	0f 84 bf 00 00 00    	je     80107817 <copyuvm+0xd7>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107758:	8b 45 0c             	mov    0xc(%ebp),%eax
8010775b:	85 c0                	test   %eax,%eax
8010775d:	0f 84 a9 00 00 00    	je     8010780c <copyuvm+0xcc>
80107763:	31 db                	xor    %ebx,%ebx
80107765:	eb 53                	jmp    801077ba <copyuvm+0x7a>
80107767:	89 f6                	mov    %esi,%esi
80107769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *pte = PTE_U | PTE_W | PTE_PG;
      lcr3(V2P(myproc()->pgdir));
      continue;
    }

    *pte &= ~PTE_W;
80107770:	89 d1                	mov    %edx,%ecx

    pa = PTE_ADDR(*pte);
80107772:	89 d6                	mov    %edx,%esi
    flags = PTE_FLAGS(*pte);
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
80107774:	83 ec 08             	sub    $0x8,%esp
    *pte &= ~PTE_W;
80107777:	83 e1 fd             	and    $0xfffffffd,%ecx
    flags = PTE_FLAGS(*pte);
8010777a:	81 e2 fd 0f 00 00    	and    $0xffd,%edx
    pa = PTE_ADDR(*pte);
80107780:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    *pte &= ~PTE_W;
80107786:	89 08                	mov    %ecx,(%eax)
    if(mappages(d, (void*)i, PGSIZE, pa, flags) < 0) {
80107788:	52                   	push   %edx
80107789:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010778e:	56                   	push   %esi
8010778f:	89 da                	mov    %ebx,%edx
80107791:	89 f8                	mov    %edi,%eax
80107793:	e8 18 f9 ff ff       	call   801070b0 <mappages>
80107798:	83 c4 10             	add    $0x10,%esp
8010779b:	85 c0                	test   %eax,%eax
8010779d:	0f 88 85 00 00 00    	js     80107828 <copyuvm+0xe8>
      goto bad;
    }
    incrementReferenceCount(pa);
801077a3:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < sz; i += PGSIZE){
801077a6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    incrementReferenceCount(pa);
801077ac:	56                   	push   %esi
801077ad:	e8 de b2 ff ff       	call   80102a90 <incrementReferenceCount>
801077b2:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sz; i += PGSIZE){
801077b5:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
801077b8:	76 52                	jbe    8010780c <copyuvm+0xcc>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801077ba:	8b 45 08             	mov    0x8(%ebp),%eax
801077bd:	31 c9                	xor    %ecx,%ecx
801077bf:	89 da                	mov    %ebx,%edx
801077c1:	e8 6a f8 ff ff       	call   80107030 <walkpgdir>
801077c6:	85 c0                	test   %eax,%eax
801077c8:	0f 84 8a 00 00 00    	je     80107858 <copyuvm+0x118>
    if(!(*pte & PTE_P) && !(*pte & PTE_PG))
801077ce:	8b 10                	mov    (%eax),%edx
801077d0:	f7 c2 01 02 00 00    	test   $0x201,%edx
801077d6:	74 73                	je     8010784b <copyuvm+0x10b>
    if(*pte & PTE_PG){
801077d8:	f6 c6 02             	test   $0x2,%dh
801077db:	74 93                	je     80107770 <copyuvm+0x30>
      pte = walkpgdir(d, (void*) i, 1);
801077dd:	b9 01 00 00 00       	mov    $0x1,%ecx
801077e2:	89 da                	mov    %ebx,%edx
801077e4:	89 f8                	mov    %edi,%eax
801077e6:	e8 45 f8 ff ff       	call   80107030 <walkpgdir>
      *pte = PTE_U | PTE_W | PTE_PG;
801077eb:	c7 00 06 02 00 00    	movl   $0x206,(%eax)
      lcr3(V2P(myproc()->pgdir));
801077f1:	e8 9a c6 ff ff       	call   80103e90 <myproc>
801077f6:	8b 40 04             	mov    0x4(%eax),%eax
801077f9:	05 00 00 00 80       	add    $0x80000000,%eax
801077fe:	0f 22 d8             	mov    %eax,%cr3
  for(i = 0; i < sz; i += PGSIZE){
80107801:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107807:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
8010780a:	77 ae                	ja     801077ba <copyuvm+0x7a>
        goto bad;
      }
    #endif
    //cprintf("increased to: %d\n",getReferenceCount(pa));
  }
  lcr3(V2P(pgdir));
8010780c:	8b 45 08             	mov    0x8(%ebp),%eax
8010780f:	05 00 00 00 80       	add    $0x80000000,%eax
80107814:	0f 22 d8             	mov    %eax,%cr3

bad:
  freevm(d);
  lcr3(V2P(pgdir));
  return 0;
}
80107817:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010781a:	89 f8                	mov    %edi,%eax
8010781c:	5b                   	pop    %ebx
8010781d:	5e                   	pop    %esi
8010781e:	5f                   	pop    %edi
8010781f:	5d                   	pop    %ebp
80107820:	c3                   	ret    
80107821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  freevm(d);
80107828:	83 ec 0c             	sub    $0xc,%esp
8010782b:	57                   	push   %edi
8010782c:	e8 bf fd ff ff       	call   801075f0 <freevm>
  lcr3(V2P(pgdir));
80107831:	8b 45 08             	mov    0x8(%ebp),%eax
80107834:	05 00 00 00 80       	add    $0x80000000,%eax
80107839:	0f 22 d8             	mov    %eax,%cr3
  return 0;
8010783c:	83 c4 10             	add    $0x10,%esp
}
8010783f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107842:	31 ff                	xor    %edi,%edi
}
80107844:	89 f8                	mov    %edi,%eax
80107846:	5b                   	pop    %ebx
80107847:	5e                   	pop    %esi
80107848:	5f                   	pop    %edi
80107849:	5d                   	pop    %ebp
8010784a:	c3                   	ret    
      panic("copyuvm: page not present");
8010784b:	83 ec 0c             	sub    $0xc,%esp
8010784e:	68 61 8b 10 80       	push   $0x80108b61
80107853:	e8 38 8b ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107858:	83 ec 0c             	sub    $0xc,%esp
8010785b:	68 47 8b 10 80       	push   $0x80108b47
80107860:	e8 2b 8b ff ff       	call   80100390 <panic>
80107865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107870 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107870:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107871:	31 c9                	xor    %ecx,%ecx
{
80107873:	89 e5                	mov    %esp,%ebp
80107875:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107878:	8b 55 0c             	mov    0xc(%ebp),%edx
8010787b:	8b 45 08             	mov    0x8(%ebp),%eax
8010787e:	e8 ad f7 ff ff       	call   80107030 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107883:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107885:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107886:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107888:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010788d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107890:	05 00 00 00 80       	add    $0x80000000,%eax
80107895:	83 fa 05             	cmp    $0x5,%edx
80107898:	ba 00 00 00 00       	mov    $0x0,%edx
8010789d:	0f 45 c2             	cmovne %edx,%eax
}
801078a0:	c3                   	ret    
801078a1:	eb 0d                	jmp    801078b0 <copyout>
801078a3:	90                   	nop
801078a4:	90                   	nop
801078a5:	90                   	nop
801078a6:	90                   	nop
801078a7:	90                   	nop
801078a8:	90                   	nop
801078a9:	90                   	nop
801078aa:	90                   	nop
801078ab:	90                   	nop
801078ac:	90                   	nop
801078ad:	90                   	nop
801078ae:	90                   	nop
801078af:	90                   	nop

801078b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801078b0:	55                   	push   %ebp
801078b1:	89 e5                	mov    %esp,%ebp
801078b3:	57                   	push   %edi
801078b4:	56                   	push   %esi
801078b5:	53                   	push   %ebx
801078b6:	83 ec 1c             	sub    $0x1c,%esp
801078b9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801078bc:	8b 55 0c             	mov    0xc(%ebp),%edx
801078bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801078c2:	85 db                	test   %ebx,%ebx
801078c4:	75 40                	jne    80107906 <copyout+0x56>
801078c6:	eb 70                	jmp    80107938 <copyout+0x88>
801078c8:	90                   	nop
801078c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801078d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801078d3:	89 f1                	mov    %esi,%ecx
801078d5:	29 d1                	sub    %edx,%ecx
801078d7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801078dd:	39 d9                	cmp    %ebx,%ecx
801078df:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801078e2:	29 f2                	sub    %esi,%edx
801078e4:	83 ec 04             	sub    $0x4,%esp
801078e7:	01 d0                	add    %edx,%eax
801078e9:	51                   	push   %ecx
801078ea:	57                   	push   %edi
801078eb:	50                   	push   %eax
801078ec:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801078ef:	e8 2c d5 ff ff       	call   80104e20 <memmove>
    len -= n;
    buf += n;
801078f4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801078f7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801078fa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
80107900:	01 cf                	add    %ecx,%edi
  while(len > 0){
80107902:	29 cb                	sub    %ecx,%ebx
80107904:	74 32                	je     80107938 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107906:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107908:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
8010790b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010790e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107914:	56                   	push   %esi
80107915:	ff 75 08             	pushl  0x8(%ebp)
80107918:	e8 53 ff ff ff       	call   80107870 <uva2ka>
    if(pa0 == 0)
8010791d:	83 c4 10             	add    $0x10,%esp
80107920:	85 c0                	test   %eax,%eax
80107922:	75 ac                	jne    801078d0 <copyout+0x20>
  }
  return 0;
}
80107924:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010792c:	5b                   	pop    %ebx
8010792d:	5e                   	pop    %esi
8010792e:	5f                   	pop    %edi
8010792f:	5d                   	pop    %ebp
80107930:	c3                   	ret    
80107931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107938:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010793b:	31 c0                	xor    %eax,%eax
}
8010793d:	5b                   	pop    %ebx
8010793e:	5e                   	pop    %esi
8010793f:	5f                   	pop    %edi
80107940:	5d                   	pop    %ebp
80107941:	c3                   	ret    
80107942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107950 <getLastPageSCFIFO>:
    }
  }
}

struct procPG*
getLastPageSCFIFO(){/******************************************************************************** SCFIFO :  getLastPage ***********************************/
80107950:	55                   	push   %ebp
80107951:	89 e5                	mov    %esp,%ebp
80107953:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc();
80107956:	e8 35 c5 ff ff       	call   80103e90 <myproc>

  //#pragma GCC diagnostic ignored "-Wmaybe-uninitialized";
  struct procPG *page = &p->physicalPGs[p->headPG];
8010795b:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80107961:	8d 14 92             	lea    (%edx,%edx,4),%edx
80107964:	c1 e2 02             	shl    $0x2,%edx
80107967:	8d 8c 10 90 01 00 00 	lea    0x190(%eax,%edx,1),%ecx
  //struct procPG *headHolder = &p->physicalPGs[p->headPG];

  if(!page->next){
8010796e:	8b 94 10 9c 01 00 00 	mov    0x19c(%eax,%edx,1),%edx
80107975:	85 d2                	test   %edx,%edx
80107977:	74 25                	je     8010799e <getLastPageSCFIFO+0x4e>
    panic("getLastPG: empty headPG list");
  }
  int i;
  for(i = 1; i < p->nPgsPhysical; i++)
80107979:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010797f:	ba 01 00 00 00       	mov    $0x1,%edx
80107984:	83 f8 01             	cmp    $0x1,%eax
80107987:	7e 11                	jle    8010799a <getLastPageSCFIFO+0x4a>
80107989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107990:	83 c2 01             	add    $0x1,%edx
  {
      page = page->next;
80107993:	8b 49 0c             	mov    0xc(%ecx),%ecx
  for(i = 1; i < p->nPgsPhysical; i++)
80107996:	39 c2                	cmp    %eax,%edx
80107998:	75 f6                	jne    80107990 <getLastPageSCFIFO+0x40>
      return page;
    }
    page = page->prev;
  }*/
  return page;
}
8010799a:	89 c8                	mov    %ecx,%eax
8010799c:	c9                   	leave  
8010799d:	c3                   	ret    
    panic("getLastPG: empty headPG list");
8010799e:	83 ec 0c             	sub    $0xc,%esp
801079a1:	68 7b 8b 10 80       	push   $0x80108b7b
801079a6:	e8 e5 89 ff ff       	call   80100390 <panic>
801079ab:	90                   	nop
801079ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801079b0 <scfifoWriteToSwap>:
scfifoWriteToSwap(uint addr){/******************************************************************************** SCFIFO :  write *********************************/
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
801079b9:	e8 d2 c4 ff ff       	call   80103e90 <myproc>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES  && p->allocatedInPhys < MAX_PSYC_PAGES ){
801079be:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
  struct proc *p = myproc();
801079c5:	89 c6                	mov    %eax,%esi
  char* addrToOverwrite = (char*)0xffffffff;
801079c7:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  if(p->nPgsPhysical>=MAX_PSYC_PAGES  && p->allocatedInPhys < MAX_PSYC_PAGES ){
801079cc:	7e 0d                	jle    801079db <scfifoWriteToSwap+0x2b>
801079ce:	83 b8 88 00 00 00 0f 	cmpl   $0xf,0x88(%eax)
801079d5:	0f 8e e5 00 00 00    	jle    80107ac0 <scfifoWriteToSwap+0x110>
801079db:	8d 86 9c 00 00 00    	lea    0x9c(%esi),%eax
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
801079e1:	31 db                	xor    %ebx,%ebx
801079e3:	90                   	nop
801079e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->swappedPGs[i].va == (char*)0xffffffff || p->swappedPGs[i].va == addrToOverwrite){
801079e8:	8b 10                	mov    (%eax),%edx
801079ea:	83 fa ff             	cmp    $0xffffffff,%edx
801079ed:	74 21                	je     80107a10 <scfifoWriteToSwap+0x60>
801079ef:	39 ca                	cmp    %ecx,%edx
801079f1:	74 1d                	je     80107a10 <scfifoWriteToSwap+0x60>
  for(i = 0; i <= MAX_PSYC_PAGES; i++){
801079f3:	83 c3 01             	add    $0x1,%ebx
801079f6:	83 c0 10             	add    $0x10,%eax
    if(i== MAX_PSYC_PAGES){
801079f9:	83 fb 10             	cmp    $0x10,%ebx
801079fc:	75 ea                	jne    801079e8 <scfifoWriteToSwap+0x38>
      panic(" scfifoWriteToSwap: unable to find slot for swap");
801079fe:	83 ec 0c             	sub    $0xc,%esp
80107a01:	68 58 8c 10 80       	push   $0x80108c58
80107a06:	e8 85 89 ff ff       	call   80100390 <panic>
80107a0b:	90                   	nop
80107a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(p->headPG==-1){
80107a10:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
80107a17:	0f 84 b6 00 00 00    	je     80107ad3 <scfifoWriteToSwap+0x123>
  struct procPG *lastpg = getLastPageSCFIFO();
80107a1d:	e8 2e ff ff ff       	call   80107950 <getLastPageSCFIFO>
  p->swappedPGs[i].va = lastpg->va;
80107a22:	8b 10                	mov    (%eax),%edx
  struct procPG *lastpg = getLastPageSCFIFO();
80107a24:	89 c7                	mov    %eax,%edi
  p->swappedPGs[i].va = lastpg->va;
80107a26:	8d 43 09             	lea    0x9(%ebx),%eax
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107a29:	c1 e3 0c             	shl    $0xc,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107a2c:	c1 e0 04             	shl    $0x4,%eax
80107a2f:	89 54 06 0c          	mov    %edx,0xc(%esi,%eax,1)
  if(writeToSwapFile(p,(char*)PTE_ADDR(lastpg->va),i*PGSIZE, PGSIZE)<=0){
80107a33:	68 00 10 00 00       	push   $0x1000
80107a38:	53                   	push   %ebx
80107a39:	8b 07                	mov    (%edi),%eax
80107a3b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a40:	50                   	push   %eax
80107a41:	56                   	push   %esi
80107a42:	e8 89 a8 ff ff       	call   801022d0 <writeToSwapFile>
80107a47:	83 c4 10             	add    $0x10,%esp
80107a4a:	85 c0                	test   %eax,%eax
80107a4c:	0f 8e 9b 00 00 00    	jle    80107aed <scfifoWriteToSwap+0x13d>
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107a52:	8b 46 04             	mov    0x4(%esi),%eax
80107a55:	8b 17                	mov    (%edi),%edx
80107a57:	31 c9                	xor    %ecx,%ecx
80107a59:	e8 d2 f5 ff ff       	call   80107030 <walkpgdir>
  if(!pte){
80107a5e:	85 c0                	test   %eax,%eax
  pte = walkpgdir(p->pgdir, (void*)lastpg->va ,0);
80107a60:	89 c3                	mov    %eax,%ebx
  if(!pte){
80107a62:	74 7c                	je     80107ae0 <scfifoWriteToSwap+0x130>
  decrementReferenceCount(PTE_ADDR(*pte));
80107a64:	8b 00                	mov    (%eax),%eax
80107a66:	83 ec 0c             	sub    $0xc,%esp
80107a69:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a6e:	50                   	push   %eax
80107a6f:	e8 cc af ff ff       	call   80102a40 <decrementReferenceCount>
  kfree((char*)PTE_ADDR(P2V(*pte)));
80107a74:	8b 03                	mov    (%ebx),%eax
80107a76:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80107a7c:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107a82:	89 14 24             	mov    %edx,(%esp)
80107a85:	e8 96 ac ff ff       	call   80102720 <kfree>
  lastpg->va = (char*)PTE_ADDR(addr);
80107a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  *pte = PTE_W | PTE_U | PTE_PG;
80107a8d:	c7 03 06 02 00 00    	movl   $0x206,(%ebx)
  lastpg->va = (char*)PTE_ADDR(addr);
80107a93:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a98:	89 07                	mov    %eax,(%edi)
  movePageToHead(lastpg);
80107a9a:	89 3c 24             	mov    %edi,(%esp)
80107a9d:	e8 2e 05 00 00       	call   80107fd0 <movePageToHead>
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107aa2:	8b 46 04             	mov    0x4(%esi),%eax
80107aa5:	05 00 00 00 80       	add    $0x80000000,%eax
80107aaa:	0f 22 d8             	mov    %eax,%cr3
}
80107aad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ab0:	89 f8                	mov    %edi,%eax
80107ab2:	5b                   	pop    %ebx
80107ab3:	5e                   	pop    %esi
80107ab4:	5f                   	pop    %edi
80107ab5:	5d                   	pop    %ebp
80107ab6:	c3                   	ret    
80107ab7:	89 f6                	mov    %esi,%esi
80107ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    addrToOverwrite = getLastPageSCFIFO()->va;
80107ac0:	e8 8b fe ff ff       	call   80107950 <getLastPageSCFIFO>
80107ac5:	8b 08                	mov    (%eax),%ecx
    p->allocatedInPhys++;
80107ac7:	83 86 88 00 00 00 01 	addl   $0x1,0x88(%esi)
80107ace:	e9 08 ff ff ff       	jmp    801079db <scfifoWriteToSwap+0x2b>
    panic("scfifoWriteToSwap: empty headPG list");
80107ad3:	83 ec 0c             	sub    $0xc,%esp
80107ad6:	68 8c 8c 10 80       	push   $0x80108c8c
80107adb:	e8 b0 88 ff ff       	call   80100390 <panic>
    panic("scfifoWrite: !pte");
80107ae0:	83 ec 0c             	sub    $0xc,%esp
80107ae3:	68 98 8b 10 80       	push   $0x80108b98
80107ae8:	e8 a3 88 ff ff       	call   80100390 <panic>
    panic("scfifoWriteToSwap: writeToSwapFile");
80107aed:	83 ec 0c             	sub    $0xc,%esp
80107af0:	68 b4 8c 10 80       	push   $0x80108cb4
80107af5:	e8 96 88 ff ff       	call   80100390 <panic>
80107afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b00 <initSCFIFO>:
initSCFIFO(char *va){/******************************************************************************* SCFIFO :  init *******************************************/
80107b00:	55                   	push   %ebp
80107b01:	89 e5                	mov    %esp,%ebp
80107b03:	56                   	push   %esi
80107b04:	53                   	push   %ebx
80107b05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107b08:	e8 83 c3 ff ff       	call   80103e90 <myproc>
  if(p->allocatedInPhys == 16){
80107b0d:	83 b8 88 00 00 00 10 	cmpl   $0x10,0x88(%eax)
80107b14:	0f 84 96 00 00 00    	je     80107bb0 <initSCFIFO+0xb0>
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107b1a:	83 b8 80 00 00 00 0f 	cmpl   $0xf,0x80(%eax)
80107b21:	89 c6                	mov    %eax,%esi
  char* addrToOverwrite = (char*)0xffffffff;
80107b23:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  if(p->nPgsPhysical>=MAX_PSYC_PAGES){
80107b28:	7f 6e                	jg     80107b98 <initSCFIFO+0x98>
80107b2a:	8d 96 90 01 00 00    	lea    0x190(%esi),%edx
  for(i = 0 ; i<= MAX_PSYC_PAGES; i++){
80107b30:	31 c0                	xor    %eax,%eax
80107b32:	eb 0f                	jmp    80107b43 <initSCFIFO+0x43>
80107b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b38:	83 c0 01             	add    $0x1,%eax
80107b3b:	83 c2 14             	add    $0x14,%edx
80107b3e:	83 f8 11             	cmp    $0x11,%eax
80107b41:	74 2c                	je     80107b6f <initSCFIFO+0x6f>
    if(p->physicalPGs[i].va == addrToOverwrite){
80107b43:	39 0a                	cmp    %ecx,(%edx)
80107b45:	75 f1                	jne    80107b38 <initSCFIFO+0x38>
      p->physicalPGs[i].va = va;
80107b47:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107b4a:	c1 e2 02             	shl    $0x2,%edx
80107b4d:	8d 0c 16             	lea    (%esi,%edx,1),%ecx
80107b50:	89 99 90 01 00 00    	mov    %ebx,0x190(%ecx)
      p->physicalPGs[i].refs = 1;
80107b56:	c7 81 94 01 00 00 01 	movl   $0x1,0x194(%ecx)
80107b5d:	00 00 00 
      if(p->headPG == -1){
80107b60:	83 be 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%esi)
        p->headPG = i;
80107b67:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
      if(p->headPG == -1){
80107b6d:	75 11                	jne    80107b80 <initSCFIFO+0x80>
}
80107b6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b72:	5b                   	pop    %ebx
80107b73:	5e                   	pop    %esi
80107b74:	5d                   	pop    %ebp
80107b75:	c3                   	ret    
80107b76:	8d 76 00             	lea    0x0(%esi),%esi
80107b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      movePageToHead(&p->physicalPGs[i]);
80107b80:	8d 84 16 90 01 00 00 	lea    0x190(%esi,%edx,1),%eax
80107b87:	89 45 08             	mov    %eax,0x8(%ebp)
}
80107b8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b8d:	5b                   	pop    %ebx
80107b8e:	5e                   	pop    %esi
80107b8f:	5d                   	pop    %ebp
      movePageToHead(&p->physicalPGs[i]);
80107b90:	e9 3b 04 00 00       	jmp    80107fd0 <movePageToHead>
80107b95:	8d 76 00             	lea    0x0(%esi),%esi
      myproc()->nPgsPhysical--;
80107b98:	e8 f3 c2 ff ff       	call   80103e90 <myproc>
80107b9d:	83 a8 80 00 00 00 01 	subl   $0x1,0x80(%eax)
    addrToOverwrite = getLastPageSCFIFO()->va;
80107ba4:	e8 a7 fd ff ff       	call   80107950 <getLastPageSCFIFO>
80107ba9:	8b 08                	mov    (%eax),%ecx
80107bab:	e9 7a ff ff ff       	jmp    80107b2a <initSCFIFO+0x2a>
    panic("initSCFIFO");
80107bb0:	83 ec 0c             	sub    $0xc,%esp
80107bb3:	68 aa 8b 10 80       	push   $0x80108baa
80107bb8:	e8 d3 87 ff ff       	call   80100390 <panic>
80107bbd:	8d 76 00             	lea    0x0(%esi),%esi

80107bc0 <indexInSwapFile>:

/***************************************************************************************************************************************************************/
/******************************************************************************   UTILS    *********************************************************************/
/***************************************************************************************************************************************************************/
int
indexInSwapFile(uint addr){
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	83 ec 08             	sub    $0x8,%esp
  struct proc *p =myproc();
80107bc6:	e8 c5 c2 ff ff       	call   80103e90 <myproc>
80107bcb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107bce:	8d 90 9c 00 00 00    	lea    0x9c(%eax),%edx
  int i;
  for(i = 0 ; i < MAX_PSYC_PAGES; i++){
80107bd4:	31 c0                	xor    %eax,%eax
80107bd6:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107bdc:	eb 0d                	jmp    80107beb <indexInSwapFile+0x2b>
80107bde:	66 90                	xchg   %ax,%ax
80107be0:	83 c0 01             	add    $0x1,%eax
80107be3:	83 c2 10             	add    $0x10,%edx
80107be6:	83 f8 10             	cmp    $0x10,%eax
80107be9:	74 0d                	je     80107bf8 <indexInSwapFile+0x38>

    if(p->swappedPGs[i].va == (char*)PTE_ADDR(addr)){
80107beb:	39 0a                	cmp    %ecx,(%edx)
80107bed:	75 f1                	jne    80107be0 <indexInSwapFile+0x20>
      return i;
    }
  }
  panic("scfifoSwap: could not find page in swap file");
  return -1;
}
80107bef:	c9                   	leave  
80107bf0:	c3                   	ret    
80107bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  panic("scfifoSwap: could not find page in swap file");
80107bf8:	83 ec 0c             	sub    $0xc,%esp
80107bfb:	68 d8 8c 10 80       	push   $0x80108cd8
80107c00:	e8 8b 87 ff ff       	call   80100390 <panic>
80107c05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c10 <scfifoSwap>:
scfifoSwap(uint addr){/******************************************************************************** SCFIFO :  swap *****************************************/
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	57                   	push   %edi
80107c14:	56                   	push   %esi
80107c15:	53                   	push   %ebx
80107c16:	81 ec 2c 04 00 00    	sub    $0x42c,%esp
  struct proc *p = myproc();
80107c1c:	e8 6f c2 ff ff       	call   80103e90 <myproc>
  if(p->headPG == -1){
80107c21:	83 b8 8c 00 00 00 ff 	cmpl   $0xffffffff,0x8c(%eax)
80107c28:	0f 84 87 01 00 00    	je     80107db5 <scfifoSwap+0x1a5>
80107c2e:	89 c6                	mov    %eax,%esi
  struct procPG *lastpg = getLastPageSCFIFO();
80107c30:	e8 1b fd ff ff       	call   80107950 <getLastPageSCFIFO>
80107c35:	89 c7                	mov    %eax,%edi
80107c37:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107c3d:	8b 46 04             	mov    0x4(%esi),%eax
80107c40:	8b 17                	mov    (%edi),%edx
80107c42:	31 c9                	xor    %ecx,%ecx
80107c44:	e8 e7 f3 ff ff       	call   80107030 <walkpgdir>
  int i = indexInSwapFile(addr);
80107c49:	83 ec 0c             	sub    $0xc,%esp
80107c4c:	ff 75 08             	pushl  0x8(%ebp)
  pte1 = walkpgdir(p->pgdir, (void*)lastpg->va,0);
80107c4f:	89 85 e0 fb ff ff    	mov    %eax,-0x420(%ebp)
  int i = indexInSwapFile(addr);
80107c55:	e8 66 ff ff ff       	call   80107bc0 <indexInSwapFile>
  p->swappedPGs[i].va = lastpg->va;
80107c5a:	8b 17                	mov    (%edi),%edx
  int i = indexInSwapFile(addr);
80107c5c:	89 c3                	mov    %eax,%ebx
  p->swappedPGs[i].va = lastpg->va;
80107c5e:	8d 40 09             	lea    0x9(%eax),%eax
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107c61:	31 c9                	xor    %ecx,%ecx
  p->swappedPGs[i].va = lastpg->va;
80107c63:	c1 e0 04             	shl    $0x4,%eax
80107c66:	89 54 06 0c          	mov    %edx,0xc(%esi,%eax,1)
  pte2 = walkpgdir(p->pgdir,(void*)addr, 0);
80107c6a:	8b 55 08             	mov    0x8(%ebp),%edx
80107c6d:	8b 46 04             	mov    0x4(%esi),%eax
80107c70:	e8 bb f3 ff ff       	call   80107030 <walkpgdir>
  if(!*pte2){
80107c75:	8b 10                	mov    (%eax),%edx
80107c77:	83 c4 10             	add    $0x10,%esp
80107c7a:	85 d2                	test   %edx,%edx
80107c7c:	0f 84 26 01 00 00    	je     80107da8 <scfifoSwap+0x198>
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
80107c82:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
80107c88:	c1 e3 0c             	shl    $0xc,%ebx
80107c8b:	8d bd e8 fb ff ff    	lea    -0x418(%ebp),%edi
80107c91:	89 9d d8 fb ff ff    	mov    %ebx,-0x428(%ebp)
    int loc = (i * PGSIZE) + ((PGSIZE / 4) * j);
80107c97:	31 db                	xor    %ebx,%ebx
  *pte2 = PTE_ADDR(*pte1) | PTE_U | PTE_P;
80107c99:	8b 09                	mov    (%ecx),%ecx
80107c9b:	89 ca                	mov    %ecx,%edx
80107c9d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107ca3:	83 ca 05             	or     $0x5,%edx
80107ca6:	89 10                	mov    %edx,(%eax)
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80107ca8:	8b 45 08             	mov    0x8(%ebp),%eax
80107cab:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cb0:	89 85 dc fb ff ff    	mov    %eax,-0x424(%ebp)
    memset(buf, 0, PGSIZE / 4);
80107cb6:	83 ec 04             	sub    $0x4,%esp
80107cb9:	68 00 04 00 00       	push   $0x400
80107cbe:	6a 00                	push   $0x0
80107cc0:	57                   	push   %edi
80107cc1:	e8 aa d0 ff ff       	call   80104d70 <memset>
80107cc6:	8b 85 d8 fb ff ff    	mov    -0x428(%ebp),%eax
    if(readFromSwapFile(p, buf, loc, PGSIZE / 4) <= 0){
80107ccc:	68 00 04 00 00       	push   $0x400
80107cd1:	8d 14 18             	lea    (%eax,%ebx,1),%edx
80107cd4:	52                   	push   %edx
80107cd5:	57                   	push   %edi
80107cd6:	56                   	push   %esi
80107cd7:	89 95 e4 fb ff ff    	mov    %edx,-0x41c(%ebp)
80107cdd:	e8 1e a6 ff ff       	call   80102300 <readFromSwapFile>
80107ce2:	83 c4 20             	add    $0x20,%esp
80107ce5:	85 c0                	test   %eax,%eax
80107ce7:	8b 95 e4 fb ff ff    	mov    -0x41c(%ebp),%edx
80107ced:	0f 8e a8 00 00 00    	jle    80107d9b <scfifoSwap+0x18b>
    if(writeToSwapFile(p, (char*)(P2V(PTE_ADDR(*pte1)) + addroffset), loc, PGSIZE / 4)<= 0){
80107cf3:	8b 85 e0 fb ff ff    	mov    -0x420(%ebp),%eax
80107cf9:	68 00 04 00 00       	push   $0x400
80107cfe:	52                   	push   %edx
80107cff:	8b 00                	mov    (%eax),%eax
80107d01:	89 85 e4 fb ff ff    	mov    %eax,-0x41c(%ebp)
80107d07:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d0c:	8d 84 03 00 00 00 80 	lea    -0x80000000(%ebx,%eax,1),%eax
80107d13:	50                   	push   %eax
80107d14:	56                   	push   %esi
80107d15:	e8 b6 a5 ff ff       	call   801022d0 <writeToSwapFile>
80107d1a:	83 c4 10             	add    $0x10,%esp
80107d1d:	85 c0                	test   %eax,%eax
80107d1f:	7e 7a                	jle    80107d9b <scfifoSwap+0x18b>
    memmove((void*)(PTE_ADDR(addr) + addroffset), (void*)buf, PGSIZE / 4);
80107d21:	8b 85 dc fb ff ff    	mov    -0x424(%ebp),%eax
80107d27:	83 ec 04             	sub    $0x4,%esp
80107d2a:	68 00 04 00 00       	push   $0x400
80107d2f:	57                   	push   %edi
80107d30:	01 d8                	add    %ebx,%eax
80107d32:	81 c3 00 04 00 00    	add    $0x400,%ebx
80107d38:	50                   	push   %eax
80107d39:	e8 e2 d0 ff ff       	call   80104e20 <memmove>
  for (j = 0; j < 4; j++) {
80107d3e:	83 c4 10             	add    $0x10,%esp
80107d41:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
80107d47:	0f 85 69 ff ff ff    	jne    80107cb6 <scfifoSwap+0xa6>
  *pte1 = PTE_U | PTE_W | PTE_PG;
80107d4d:	8b 8d e0 fb ff ff    	mov    -0x420(%ebp),%ecx
    *pte1 &= ~PTE_W;
80107d53:	31 c0                	xor    %eax,%eax
  *pte1 = PTE_U | PTE_W | PTE_PG;
80107d55:	c7 01 06 02 00 00    	movl   $0x206,(%ecx)
    *pte1 &= ~PTE_W;
80107d5b:	83 be 88 00 00 00 10 	cmpl   $0x10,0x88(%esi)
80107d62:	0f 9c c0             	setl   %al
  movePageToHead(lastpg);
80107d65:	83 ec 0c             	sub    $0xc,%esp
    *pte1 &= ~PTE_W;
80107d68:	8d 84 00 04 02 00 00 	lea    0x204(%eax,%eax,1),%eax
80107d6f:	89 01                	mov    %eax,(%ecx)
  lastpg->va = (char*)PTE_ADDR(addr);
80107d71:	8b 85 d4 fb ff ff    	mov    -0x42c(%ebp),%eax
80107d77:	8b 8d dc fb ff ff    	mov    -0x424(%ebp),%ecx
80107d7d:	89 08                	mov    %ecx,(%eax)
  movePageToHead(lastpg);
80107d7f:	50                   	push   %eax
80107d80:	e8 4b 02 00 00       	call   80107fd0 <movePageToHead>
  lcr3(V2P(p->pgdir));
80107d85:	8b 46 04             	mov    0x4(%esi),%eax
80107d88:	05 00 00 00 80       	add    $0x80000000,%eax
80107d8d:	0f 22 d8             	mov    %eax,%cr3
}
80107d90:	83 c4 10             	add    $0x10,%esp
80107d93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d96:	5b                   	pop    %ebx
80107d97:	5e                   	pop    %esi
80107d98:	5f                   	pop    %edi
80107d99:	5d                   	pop    %ebp
80107d9a:	c3                   	ret    
      panic("scfifoSwap: read from swapfile");
80107d9b:	83 ec 0c             	sub    $0xc,%esp
80107d9e:	68 08 8d 10 80       	push   $0x80108d08
80107da3:	e8 e8 85 ff ff       	call   80100390 <panic>
    panic("scfifoSwap: pte2 empty");
80107da8:	83 ec 0c             	sub    $0xc,%esp
80107dab:	68 d3 8b 10 80       	push   $0x80108bd3
80107db0:	e8 db 85 ff ff       	call   80100390 <panic>
    panic("scfifoSwap: empty headPG list");
80107db5:	83 ec 0c             	sub    $0xc,%esp
80107db8:	68 b5 8b 10 80       	push   $0x80108bb5
80107dbd:	e8 ce 85 ff ff       	call   80100390 <panic>
80107dc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107dd0 <writePageToSwapFile>:
// swaps out a page
struct procPG*
writePageToSwapFile(char* va){
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	53                   	push   %ebx
80107dd4:	83 ec 10             	sub    $0x10,%esp
  //cprintf("write\n");
  struct procPG *retPG = (void*)0;
  #ifdef SCFIFO
    retPG=scfifoWriteToSwap((uint)va);
80107dd7:	ff 75 08             	pushl  0x8(%ebp)
80107dda:	e8 d1 fb ff ff       	call   801079b0 <scfifoWriteToSwap>
80107ddf:	89 c3                	mov    %eax,%ebx
  #endif
  myproc()->nPgsSwap++;
80107de1:	e8 aa c0 ff ff       	call   80103e90 <myproc>
80107de6:	83 80 84 00 00 00 01 	addl   $0x1,0x84(%eax)
  {
    cprintf("move to 1\n");
    decrementReferenceCount(pa);
  }*/
  return retPG;
}
80107ded:	89 d8                	mov    %ebx,%eax
80107def:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107df2:	c9                   	leave  
80107df3:	c3                   	ret    
80107df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107e00 <swapPage>:

void 
swapPage(uint addr){
80107e00:	55                   	push   %ebp
80107e01:	89 e5                	mov    %esp,%ebp
  //cprintf("swap\n");
  #ifdef SCFIFO
    return scfifoSwap((uint)addr);
  #endif

}
80107e03:	5d                   	pop    %ebp
    return scfifoSwap((uint)addr);
80107e04:	e9 07 fe ff ff       	jmp    80107c10 <scfifoSwap>
80107e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107e10 <initPhysicalPage>:

int
initPhysicalPage(char *va){
80107e10:	55                   	push   %ebp
80107e11:	89 e5                	mov    %esp,%ebp
80107e13:	83 ec 14             	sub    $0x14,%esp

  #ifdef SCFIFO
    initSCFIFO(va);
80107e16:	ff 75 08             	pushl  0x8(%ebp)
80107e19:	e8 e2 fc ff ff       	call   80107b00 <initSCFIFO>
  #endif

  myproc()->nPgsPhysical++;
80107e1e:	e8 6d c0 ff ff       	call   80103e90 <myproc>
80107e23:	83 80 80 00 00 00 01 	addl   $0x1,0x80(%eax)
  myproc()->allocatedInPhys++;
80107e2a:	e8 61 c0 ff ff       	call   80103e90 <myproc>
80107e2f:	83 80 88 00 00 00 01 	addl   $0x1,0x88(%eax)


  return 0;
}
80107e36:	31 c0                	xor    %eax,%eax
80107e38:	c9                   	leave  
80107e39:	c3                   	ret    
80107e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e40 <allocuvm>:
{
80107e40:	55                   	push   %ebp
80107e41:	89 e5                	mov    %esp,%ebp
80107e43:	57                   	push   %edi
80107e44:	56                   	push   %esi
80107e45:	53                   	push   %ebx
80107e46:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107e49:	8b 7d 10             	mov    0x10(%ebp),%edi
80107e4c:	85 ff                	test   %edi,%edi
80107e4e:	0f 88 e4 00 00 00    	js     80107f38 <allocuvm+0xf8>
  if(newsz < oldsz)
80107e54:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107e57:	0f 82 cb 00 00 00    	jb     80107f28 <allocuvm+0xe8>
  a = PGROUNDUP(oldsz);
80107e5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e60:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107e66:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80107e6c:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107e6f:	0f 86 b6 00 00 00    	jbe    80107f2b <allocuvm+0xeb>
    int    newPage = 1;
80107e75:	b8 01 00 00 00       	mov    $0x1,%eax
80107e7a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107e7d:	89 c7                	mov    %eax,%edi
80107e7f:	eb 77                	jmp    80107ef8 <allocuvm+0xb8>
80107e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if( (pg = writePageToSwapFile((char*)a)) == 0){
80107e88:	83 ec 0c             	sub    $0xc,%esp
80107e8b:	53                   	push   %ebx
80107e8c:	e8 3f ff ff ff       	call   80107dd0 <writePageToSwapFile>
80107e91:	83 c4 10             	add    $0x10,%esp
80107e94:	85 c0                	test   %eax,%eax
80107e96:	0f 84 21 01 00 00    	je     80107fbd <allocuvm+0x17d>
        pg->refs = 1; // COW: fresh page, only 1 ref
80107e9c:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
    mem = kalloc();
80107ea3:	e8 b8 aa ff ff       	call   80102960 <kalloc>
    if(mem == 0){
80107ea8:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107eaa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107eac:	0f 84 96 00 00 00    	je     80107f48 <allocuvm+0x108>
        newPage = 0;
80107eb2:	31 ff                	xor    %edi,%edi
    memset(mem, 0, PGSIZE);
80107eb4:	83 ec 04             	sub    $0x4,%esp
80107eb7:	68 00 10 00 00       	push   $0x1000
80107ebc:	6a 00                	push   $0x0
80107ebe:	56                   	push   %esi
80107ebf:	e8 ac ce ff ff       	call   80104d70 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107ec4:	58                   	pop    %eax
80107ec5:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107ecb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107ed0:	5a                   	pop    %edx
80107ed1:	6a 06                	push   $0x6
80107ed3:	50                   	push   %eax
80107ed4:	89 da                	mov    %ebx,%edx
80107ed6:	8b 45 08             	mov    0x8(%ebp),%eax
80107ed9:	e8 d2 f1 ff ff       	call   801070b0 <mappages>
80107ede:	83 c4 10             	add    $0x10,%esp
80107ee1:	85 c0                	test   %eax,%eax
80107ee3:	0f 88 8f 00 00 00    	js     80107f78 <allocuvm+0x138>
  for(; a < newsz; a += PGSIZE){
80107ee9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107eef:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107ef2:	0f 86 b8 00 00 00    	jbe    80107fb0 <allocuvm+0x170>
      if(myproc()->allocatedInPhys >= MAX_PSYC_PAGES){
80107ef8:	e8 93 bf ff ff       	call   80103e90 <myproc>
80107efd:	83 b8 88 00 00 00 0f 	cmpl   $0xf,0x88(%eax)
80107f04:	7f 82                	jg     80107e88 <allocuvm+0x48>
    mem = kalloc();
80107f06:	e8 55 aa ff ff       	call   80102960 <kalloc>
    if(mem == 0){
80107f0b:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107f0d:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107f0f:	74 37                	je     80107f48 <allocuvm+0x108>
    if(newPage==1){
80107f11:	83 ff 01             	cmp    $0x1,%edi
80107f14:	75 9e                	jne    80107eb4 <allocuvm+0x74>
        initPhysicalPage((char*)a);
80107f16:	83 ec 0c             	sub    $0xc,%esp
80107f19:	53                   	push   %ebx
80107f1a:	e8 f1 fe ff ff       	call   80107e10 <initPhysicalPage>
80107f1f:	83 c4 10             	add    $0x10,%esp
80107f22:	eb 90                	jmp    80107eb4 <allocuvm+0x74>
80107f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107f28:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107f2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f2e:	89 f8                	mov    %edi,%eax
80107f30:	5b                   	pop    %ebx
80107f31:	5e                   	pop    %esi
80107f32:	5f                   	pop    %edi
80107f33:	5d                   	pop    %ebp
80107f34:	c3                   	ret    
80107f35:	8d 76 00             	lea    0x0(%esi),%esi
80107f38:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107f3b:	31 ff                	xor    %edi,%edi
}
80107f3d:	89 f8                	mov    %edi,%eax
80107f3f:	5b                   	pop    %ebx
80107f40:	5e                   	pop    %esi
80107f41:	5f                   	pop    %edi
80107f42:	5d                   	pop    %ebp
80107f43:	c3                   	ret    
80107f44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory\n");
80107f48:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107f4b:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory\n");
80107f4d:	68 00 8c 10 80       	push   $0x80108c00
80107f52:	e8 09 87 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80107f57:	83 c4 0c             	add    $0xc,%esp
80107f5a:	ff 75 0c             	pushl  0xc(%ebp)
80107f5d:	ff 75 10             	pushl  0x10(%ebp)
80107f60:	ff 75 08             	pushl  0x8(%ebp)
80107f63:	e8 d8 f4 ff ff       	call   80107440 <deallocuvm>
      return 0;
80107f68:	83 c4 10             	add    $0x10,%esp
}
80107f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f6e:	89 f8                	mov    %edi,%eax
80107f70:	5b                   	pop    %ebx
80107f71:	5e                   	pop    %esi
80107f72:	5f                   	pop    %edi
80107f73:	5d                   	pop    %ebp
80107f74:	c3                   	ret    
80107f75:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107f78:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107f7b:	31 ff                	xor    %edi,%edi
      cprintf("allocuvm out of memory (2)\n");
80107f7d:	68 18 8c 10 80       	push   $0x80108c18
80107f82:	e8 d9 86 ff ff       	call   80100660 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80107f87:	83 c4 0c             	add    $0xc,%esp
80107f8a:	ff 75 0c             	pushl  0xc(%ebp)
80107f8d:	ff 75 10             	pushl  0x10(%ebp)
80107f90:	ff 75 08             	pushl  0x8(%ebp)
80107f93:	e8 a8 f4 ff ff       	call   80107440 <deallocuvm>
      kfree(mem);
80107f98:	89 34 24             	mov    %esi,(%esp)
80107f9b:	e8 80 a7 ff ff       	call   80102720 <kfree>
      return 0;
80107fa0:	83 c4 10             	add    $0x10,%esp
}
80107fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107fa6:	89 f8                	mov    %edi,%eax
80107fa8:	5b                   	pop    %ebx
80107fa9:	5e                   	pop    %esi
80107faa:	5f                   	pop    %edi
80107fab:	5d                   	pop    %ebp
80107fac:	c3                   	ret    
80107fad:	8d 76 00             	lea    0x0(%esi),%esi
80107fb0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107fb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107fb6:	5b                   	pop    %ebx
80107fb7:	89 f8                	mov    %edi,%eax
80107fb9:	5e                   	pop    %esi
80107fba:	5f                   	pop    %edi
80107fbb:	5d                   	pop    %ebp
80107fbc:	c3                   	ret    
          panic("allocuvm: swapOutPage");
80107fbd:	83 ec 0c             	sub    $0xc,%esp
80107fc0:	68 ea 8b 10 80       	push   $0x80108bea
80107fc5:	e8 c6 83 ff ff       	call   80100390 <panic>
80107fca:	66 90                	xchg   %ax,%ax
80107fcc:	66 90                	xchg   %ax,%ax
80107fce:	66 90                	xchg   %ax,%ax

80107fd0 <movePageToHead>:
#include "mmu.h"
#include "proc.h"
#include "elf.h"

void 
movePageToHead(struct procPG *pg){
80107fd0:	55                   	push   %ebp
80107fd1:	89 e5                	mov    %esp,%ebp
80107fd3:	53                   	push   %ebx
80107fd4:	83 ec 04             	sub    $0x4,%esp
80107fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80107fda:	e8 b1 be ff ff       	call   80103e90 <myproc>
  if(pg->prev){
80107fdf:	8b 53 10             	mov    0x10(%ebx),%edx
80107fe2:	85 d2                	test   %edx,%edx
80107fe4:	74 06                	je     80107fec <movePageToHead+0x1c>
    pg->prev->next = pg->next;
80107fe6:	8b 4b 0c             	mov    0xc(%ebx),%ecx
80107fe9:	89 4a 0c             	mov    %ecx,0xc(%edx)
  }
  if(pg->next){
80107fec:	8b 53 0c             	mov    0xc(%ebx),%edx
80107fef:	85 d2                	test   %edx,%edx
80107ff1:	74 06                	je     80107ff9 <movePageToHead+0x29>
    pg->next->prev = pg->prev;
80107ff3:	8b 4b 10             	mov    0x10(%ebx),%ecx
80107ff6:	89 4a 10             	mov    %ecx,0x10(%edx)
  }

  pg->next = &p->physicalPGs[p->headPG];
80107ff9:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
  pg->prev = 0;
80107fff:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  pg->next = &p->physicalPGs[p->headPG];
80108006:	8d 14 92             	lea    (%edx,%edx,4),%edx
80108009:	8d 94 90 90 01 00 00 	lea    0x190(%eax,%edx,4),%edx
80108010:	89 53 0c             	mov    %edx,0xc(%ebx)
  p->physicalPGs[p->headPG].prev = pg;
80108013:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80108019:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010801c:	89 9c 90 a0 01 00 00 	mov    %ebx,0x1a0(%eax,%edx,4)

}
80108023:	83 c4 04             	add    $0x4,%esp
80108026:	5b                   	pop    %ebx
80108027:	5d                   	pop    %ebp
80108028:	c3                   	ret    
