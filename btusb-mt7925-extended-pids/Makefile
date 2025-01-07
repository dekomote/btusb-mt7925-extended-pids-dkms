KVER ?= $(shell uname -r)
KVER_CLEAN = $(shell echo $(KVER) | cut -d- -f1)
KDIR = /lib/modules/$(KVER)/build
PWD = $(shell pwd)
MODDIR = /lib/modules/$(KVER)/kernel/drivers/bluetooth
MODNAME = btusb
MODVER ?= 1.6
MODNAMELONG = $(MODNAME)/$(MODVER)

obj-m = btusb.o

default:
	KVER=$(KVER_CLEAN) MODVER=$(MODVER) sh update.sh 
	make -C $(KDIR) M=$(PWD) modules

clean:
	make -C $(KDIR) M=$(PWD) clean
	@rm -f btusb.update.c
	@rm -f *.c *.h

install: default
	KVER=$(KVER_CLEAN) MODVER=$(MODVER) sh update.sh 
	make -C $(KDIR) M=$(PWD) INSTALL_MOD_DIR=updates modules_install
	modprobe -r btusb
	modprobe btusb
