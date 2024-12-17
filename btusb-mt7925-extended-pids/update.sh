KERNEL_SEMVER=$(uname -r | cut -d- -f1)

for i in $(echo "intel bcm rtl mtk" | sed 's/ /\n/g'); do
  curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.h?h=v$KERNEL_SEMVER"
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.c?h=v$KERNEL_SEMVER"
done

curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/btusb.c?h=v$KERNEL_SEMVER"
