# Timeshift

```
systemctl edit --full grub-btrfsd
```

## Change the line
ExecStart=/usr/bin/grub-btrfsd /.snapshots --syslog

## To
ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto

## Restart service

```
systemctl start grub-btrfsd.service

```

## Enable service

```
systemctl enable grub-btrfsd.service

```

## Create snapshot

```
timeshift --create --comments "snapshot"
```

***

# Oh My ZSH!

https://ohmyz.sh/#install



