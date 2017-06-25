AS=nasm
AFLAGS=-f bin
LD=
LDFLAGS=
LOOPDIR=loopdir
ROOT=brokenthorn
SOURCES=
EXECUTABLE=
IMAGE=$(ROOT).img
ISO=$(ROOT).iso
OBJECTS=Boot1.bin KRNL.SYS KRNLDR.SYS

all: $(OBJECTS)

iso: $(IMAGE)
	genisoimage -quiet -V 'OSDEV' -input-charset iso8859-1 -o $(ISO) -b $(IMAGE) -hide $(IMAGE) iso/

$(IMAGE): $(OBJECTS)
	mkdir -p $(LOOPDIR)
	dd if=/dev/zero of=iso/$(IMAGE) bs=1024 count=1440
	dd if=Boot1.bin of=iso/$(IMAGE) seek=0 count=1 conv=notrunc
	sudo mount -o loop iso/$(IMAGE) $(LOOPDIR) -o fat=12
	sudo cp KRNLDR.SYS $(LOOPDIR)
	sudo cp KRNL.SYS $(LOOPDIR)
	sudo umount $(LOOPDIR)
	rm -r $(LOOPDIR)

KRNL.SYS: Stage3.asm
	$(AS) $(AFLAGS) $< -o KRNL.SYS

KRNLDR.SYS: Stage2.asm
	$(AS) $(AFLAGS) $< -o KRNLDR.SYS

Boot1.bin: Boot1.asm
	$(AS) $(AFLAGS) $< -o Boot1.bin

test:
	#qemu-system-i386 -m 10 -soundhw pcspk -boot d -cdrom $(ISO)
	qemu-system-i386 -m 10 -soundhw pcspk -boot a -drive file=iso/$(IMAGE),format=raw,if=floppy -d guest_errors -D error.log

clean:
	rm -f $(OBJECTS)
	rm -f *.o
	rm -f *.iso

