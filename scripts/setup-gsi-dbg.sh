#!/bin/sh

# halium firmware loader conflicts with ueventd one
if [ -f "/usr/lib/udev/rules.d/50-firmware.rules" ]; then
	rm /usr/lib/udev/rules.d/50-firmware.rules
fi

# create android users and groups
systemd-sysusers

# disable mobian MTP services
systemctl disable mobian-usb-gadget
systemctl disable umtp-responder

# disable android LXC service
# systemctl enable lxc@android
mv /etc/systemd/system/lxc@android.service /
ln -sf /dev/null /etc/systemd/system/lxc@android.service

# disable android hwcomposer service
systemctl disable android-service@hwcomposer

# disable mtp-server
touch /home/droidian/.mtp_disable
ln -s /dev/null /etc/systemd/user/mtp-server.service

# disable droidian fpd service
systemctl disable droidian-fpd

# disable android mount service
systemctl disable android-mount.service
