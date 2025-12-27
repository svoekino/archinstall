# Check

## Check internet
ping ping.archlinux.org

## Check time
timedatectl

## Disks
cfdisk

```
/dev/sda1 2G EFI System
/dev/sda2 Linux filesystem (x86-64)
```

## Check disks
fdisk -l

## Check subvolumes

btrfs subvolume list /dev/sda2

***

# Set

## Chroot
arch-chroot /mnt

## Localization 
nano /etc/locale.gen 
locale-gen
cat /etc/locale.conf

## Root password
passwd
