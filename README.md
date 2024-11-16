# btusb-mt7925-extended-pids-dkms

This package provides support for extended PIDs for the mt7925 chipset bluetooth module that are not yet included in the mainline Linux kernel.
It is intended for users who require these PIDs for Bluetooth functionality but don't want to wait for the official kernel inclusion e.g. those with some X870 boards.

It uses DKMS to build the module.

## Features
- Adds support for additional PIDs for the mt7925 chipset bluetooth module.
- Works with Fedora Linux versions 40 and 41.
- Includes a DKMS module to automatically build and install the driver on system updates.
- Provides a systemd sleep script for handling suspend/hibernate events. The bluetooth is still borked during suspend/resume, so the module needs to be removed and loaded.

## Installation

You can install the `btusb-mt7925-extended-pids-dkms` package from the Fedora Copr repository.

## License

This project is licensed under the GPLv2 License - see the LICENSE file for details.
