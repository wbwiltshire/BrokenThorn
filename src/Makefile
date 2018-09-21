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
OBJECTS=Boot.bin KRNL.SYS KRNLDR.SYS

all: $(OBJECTS) $(IMAGE) iso

iso: $(IMAGE)
	genisoimage -quiet -V 'OSDEV' -input-charset iso8859-1 -o $(ISO) -b $(IMAGE) -hide $(IMAGE) iso/

$(IMAGE): $(OBJECTS)
	dd if=/dev/zero of=iso/$(IMAGE) bs=512   count=2880           # floppy is 2880 sectors of 512 bytes
	dd if=Boot.bin of=iso/$(IMAGE) seek=0 count=1 conv=notrunc   # Add boot image
	mcopy -i iso/brokenthorn.img KRNL.SYS \:\:KRNL.SYS
	mcopy -i iso/brokenthorn.img KRNLDR.SYS \:\:KRNLDR.SYS	

KRNL.SYS: Stage3.asm
	$(AS) $(AFLAGS) $< -o KRNL.SYS

KRNLDR.SYS: Stage2.asm
	$(AS) $(AFLAGS) $< -o KRNLDR.SYS

Boot.bin: Boot.asm
	$(AS) $(AFLAGS) $< -o Boot.bin

test:
	qemu-system-i386 -cdrom $(ISO)
	export DISPLAY=:0
	#qemu-system-i386 -m 10 -soundhw pcspk -boot a -drive file=iso/$(IMAGE),format=raw,if=floppy -d guest_errors -D error.log

clean:
	rm -f $(OBJECTS)
	rm -f *.o
	rm -f *.iso
	rm -f *.log
	rm -f iso/*.img iso/*.SYS

