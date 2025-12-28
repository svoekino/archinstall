# Live mode

## Set partitions

```
cfdisk
```

/dev/vda1 2G EFI System \
/dev/vda2 Linux filesystem (x86-64)


***


# Chroot mode

```
arch-chroot /mnt
```

## Set fstab

For root and home partitions

```
rw,relatime,discard=async,compress=zstd:3,ssd,space_cache=v2
```

## Localization 

```
nano /etc/locale.gen 
locale-gen
echo "LANG=ru_RU.UTF-8" > /etc/locale.conf
```

## Root password

```
passwd
```

# Create user

```
useradd -m -G wheel -s /bin/bash username
passwd username
```

```
EDITOR=nano visudo # uncomment: %wheel ALL=(ALL:ALL) ALL
```

***

# Exit from chroot

```
exit
```


***


# Resolve installation

```
umount -R /mnt
reboot
```

