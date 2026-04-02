# Live mode

## Set partitions

```
cfdisk
```

/dev/sda1 2G EFI System \
/dev/sda2 Linux filesystem (x86-64)


***


# Chroot mode

```
arch-chroot /mnt
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

## Create user

```
useradd -m -G wheel -s /bin/zsh username
passwd username
```

```
EDITOR=nano visudo # uncomment: %wheel ALL=(ALL:ALL) ALL
```

## Grub settings

```
nano /etc/default/grub

# set
GRUB_SAVEDEFAULT=true
GRUB_DEFAULT=saved
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

