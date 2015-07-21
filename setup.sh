mv /boot/*-generic /boot/EFI/
umount /boot/EFI
rm -rf /boot/*
mount /dev/sda1 /boot
systemctl enable uefiboot-update.path
systemctl start uefiboot-update.path
chmod /usr/bin/uefiboot-update a+x
