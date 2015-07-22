mv /boot/*-generic /boot/EFI/
umount /boot/EFI
rm -rf /boot/*
sed -i 's/\/boot\/efi/\/boot/' /etc/fstab
mount /boot
cp usr/bin/uefiboot-update /usr/bin/
cp etc/uefiboot.cfg /etc/
cp etc/systemd/system/uefiboot-update.* /etc/systemd/system/
systemctl enable uefiboot-update.path
systemctl start uefiboot-update.path
chmod a+x /usr/bin/uefiboot-update 
apt-get purge grub*, shim