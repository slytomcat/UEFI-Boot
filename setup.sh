#1. Remount EFS partition as /boot
# Move all kernel's files to EFS partition (that is mounted in /boot/efi)
mv /boot/*-generic /boot/efi/
# Unmount EFS partition
umount /boot/efi
# Remove all rest from /boot (it will be just mount point)
rm -rf /boot/*
# Change EFS mount path from '/boot/efi' to '/boot' 
sed -i 's/\/boot\/efi/\/boot/' /etc/fstab
# Mount EFS partition as /boot
mount /boot

#2. Copy files
cp usr/bin/uefiboot-update /usr/bin/
cp etc/uefiboot.cfg /etc/
cp etc/systemd/system/uefiboot-update.* /etc/systemd/system/

#3. Activate and start the watcher service
systemctl enable uefiboot-update.path
systemctl start uefiboot-update.path

#4. Make sure the utility has exec right
chmod a+x /usr/bin/uefiboot-update 

#5. Remove bootloaders
apt-get purge grub*, shim

#6. Instruct APT do not install recommended dependencies (a kernel package has grub in recommends)
echo 'APT::Install-Recommends "false";' > /etc/apt/apt.conf.d/zz-no-recommends