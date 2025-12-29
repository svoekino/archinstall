# Check

## Platform size check

```
/sys/firmware/efi/fw_platform_size
```

expected - 64

## Check internet

```
ping ping.archlinux.org
```

## Check time

```
timedatectl
```

## Check partitions

```
fdisk -l
```

## Check subvolumes

```
btrfs subvolume list /dev/sda2
```

## Check fstab

```
cat /etc/fstab
```
