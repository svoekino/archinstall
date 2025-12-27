# Check

## platform size check
/sys/firmware/efi/fw_platform_size

## Check internet
ping ping.archlinux.org

## Check time
timedatectl

## Disks
cfdisk

## Grub
grub efibootmgr

```
/dev/vda1 2G EFI System
/dev/vda2 Linux filesystem (x86-64)
```

## Check disks
fdisk -l

## Check subvolumes

btrfs subvolume list /dev/vda2

## Check fstab
cat /etc/fstab
```
rw,relatime,discard=async,compress=zstd:3,ssd,space_cache=v2
```

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
