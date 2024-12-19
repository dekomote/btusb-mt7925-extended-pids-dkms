KERNEL_SEMVER=$(uname -r | cut -d- -f1)

VERSION=${1:-"1.5"}


for i in $(echo "intel bcm rtl mtk" | sed 's/ /\n/g'); do
  curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.h?h=v$KERNEL_SEMVER"
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.c?h=v$KERNEL_SEMVER"
done

curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/btusb.c?h=v$KERNEL_SEMVER"


sed -i "s/^#define VERSION \".*\"/#define VERSION \"$VERSION\"/" btusb.c
awk '
{
    if ($0 ~ /\{ USB_DEVICE\(0x0489, 0xe0c8\), .driver_info = BTUSB_MEDIATEK/) {
        # Start of the block
        block = $0
        in_block = 1
    } else if (in_block) {
        block = block "\n" $0
        if ($0 ~ /\},$/) {
            # End of the block
            print block
            gsub(/0xe0c8/, "0xe124", block)
            print block
            in_block = 0
        }
    } else {
        print $0
    }
}' btusb.c > tmp_file &&  mv tmp_file btusb.c
