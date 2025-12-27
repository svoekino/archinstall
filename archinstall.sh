#!/bin/bash

set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color (reset formatting)

echo_green() {
    echo -e "${GREEN}$1${NC}"
}

echo_red() {
    echo -e "${RED}$1${NC}"
}

# Check platform size

PLATFORM_SIZE=/sys/firmware/efi/fw_platform_size

if [ "$PLATFORM_VALUE" != "64" ]; then
    echo_red "Required 64 platform size instead of $PLATFORM_VALUE"
    exit 1
fi

# Formatting volumes 

echo_green "=== Formatting volumes ==="

mkfs.fat -F 32 /dev/sda1
mkfs.btrfs /dev/sda2

# Mount volumes
echo_green "=== Mount volumes ==="

mount /dev/sda2 /mnt
mount --mkdir /dev/sda1 /mnt/boot

# Create subvolumes

echo_green "=== Create subvolumes ==="

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Unmount volume
echo_green "=== Unmount volume ==="
umount /dev/sda2

# Mount subvolumes

echo_green "=== Mount subvolumes ==="

mount -o subvol=@ /dev/sda2 /mnt
mount --mkdir -o subvol=@home /dev/sda2 /mnt/home

# Install Arch

echo_green "=== Install Arch ==="

pacstrap -K /mnt base linux linux-headers linux-lts linux-lts-headers linux-firmware sudo nano grub efibootmgr

# Activate chroot

echo_green "=== Activate chroot ==="

arch-chroot /mnt

# Generate fstab

echo_green "=== Generate fstab ==="

genfstab -U /mnt >> /mnt/etc/fstab

# Set local time

echo_green "=== Set local time ==="

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Set hostname

echo "svoekino" > /etc/hostname

