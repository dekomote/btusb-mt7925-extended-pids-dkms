CURRENT = $(shell uname -r)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)
MODDIR = /lib/modules/$(CURRENT)/kernel/drivers/bluetooth
MODNAME = btusb
MODVER = 1.4
MODNAMELONG = $(MODNAME)/$(MODVER)

obj-m = btusb.o

default:
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean
	@rm -f btusb.update.c

install: default
	make -C $(KDIR) M=$(PWD) INSTALL_MOD_DIR=updates modules_install
	modprobe -r btusb
	modprobe btusb

dkms-install: uninstall
	modprobe -r btusb
	cp -r . /usr/src/$(MODNAME)-$(MODVER)
	dkms install $(MODNAMELONG)
	modprobe btusb

uninstall:
	modprobe -r btusb
	-dkms remove $(MODNAMELONG)
	rm -rf /usr/src/$(MODNAME)-$(MODVER)
	rm -f $(KDIR)/../updates/btusb.ko.zst
	depmod
	modprobe btusb
