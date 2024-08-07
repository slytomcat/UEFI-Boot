# UEFI-Boot
UEFI-Boot- is a small and simple project aimed to organize the loading of linux kernel directly via UEFI firmware (without any bootloader).

Utility uefuboot-update synchronizes UEFI boot options with installed/removed kernel versions.
It may be triggered via /etc/kernel/postinst.d and /etc/kernel/postrm.d kernel triggers to do it's job when a new kernel installed or old one is removed.

Boot options of UEFI boot menu will have labels formed of three parts
  - distribution name 
  - distribution identity
  - the kernel version

After the syncronization the latest kernel will became the first option to load on next boot.

## Script parameters:

All the script parameters have default values.
Default values can be redefined by values from config file `/etc/uefiboot.conf`. 
Any value specified via command line options overides its default and config value.

## Default values:

  - the reference to root filesystem (requered for boot process) is taken from `/etc/fstab`
  - root filesystem mount options (important for btrfs in other cases) is taken from `/etc/fstab`
  - kernel boot options are `"ro quiet"`
  - disk with botable EFS partition is `"/dev/sda"` or `"/dev/nvme0n1"` when `"/dev/sda"` is not exists 
  - EFS partition number is determined from output of `gdisk` utility
  - distribution name is determined as `"$(lsb_release -d -s)"`
  - distribution identity is determined as `"$(lsb_release -r -s) $(lsb_release -c -s)"`

## Сommand line option:
  
    -l name  Distributive name to be included in EFI boot option (default: value of 'lsb_release -i -s')
    -i id    Distributive version (default: values of 'lsb_release -r -s' and 'lsb_release -c -s')
    -d disk  Disk with EFI partition (default: '/dev/sda' or '/dev/nvme0n1' when '/dev/sda' is not exists)
    -p p#    EFI partition number on disk (default: the number of partiotion with type EF00)
    -o opt   Boot options (default: 'ro quiet')
    -r root  Root partition (default: the root partition from /etc/fstab)
    -f opt   Root partition mout options (default: the root partition options from /etc/fstab, usually 'defaults')
    -b path  Path to boot directory (default '/boot')
    -n       Don't write to EFI, only output the commands instead of execution them
    -h       Prints the help message and exits`

## Files:
  - `README.md` - this file
  - `license` - GPL license
  - `setup.sh` - setup and initialization script (see important notes below)
  - `usr/bin/uefuboot-update` - utility to update UEFI boot options according to installed kernel versions
  - `etc/uefiboot.conf` - configuration file of uefuboot-update utility (see comments inside).
  - `keys/` - set of known keys for SecureBoot support.

# IMPORTANT NOTES:

Setup script is designed to work on Ubuntu system that is installed with UEFI support (`grub-efi` is in use instead of `grub-pc`). 
It's very important to review and verify that commands in this file corresponds to your configuration before you run it.
It may be better to execute commands from this file one by one by copying it from script and pasting to terminal. 


# IMPORTANT:

Be very careful with script parameters! If you make a mistake in parameters values and update UEFI boot options then the system startup may fall in to initramfs shell or even into UEFIShell. There will be three options to recover normal boot:
1. From initramfs shell: try to mount root device into /root catalog and exit from initramfs shell.
2. Using UEFI Shell (if it is available on your system): you can manualy start the kernel and specify correct parameters for it. The `uefuboot-update` utility creates special file `startup.nsh` in the EFS that contains the start command for last added kernel. This file (`startup.nsh`) is started automatically by UEFIShell. But as it created from the same options that were provided to `uefuboot-update` utility it may also fail.
3. Using LiveUSB/CD: boot in UEFI mode from LiveUSB/CD and use efibootmgr utility to define correct UEFI boot option.
After loading system you have to run uefiboot-update utility with correct parametres. 
