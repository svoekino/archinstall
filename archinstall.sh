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

# Formatting volumes 

echo_green "=== Formatting volumes ==="

mkfs.fat -F 32 /dev/sda1
mkfs.btrfs /dev/sda2

# Mount volumes
echo_green "=== Mount volumes ==="

mount /dev/sda2 /mnt

# Create subvolumes

echo_green "=== Create subvolumes ==="

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Unmount volume
echo_green "=== Unmount volume ==="
umount /dev/sda2

# Mount subvolumes and boot

echo_green "=== Mount subvolumes and boot ==="

mount -o subvol=@ /dev/sda2 /mnt
mount --mkdir -o subvol=@home /dev/sda2 /mnt/home
mount --mkdir /dev/sda1 /mnt/boot

# Install Arch

echo_green "=== Install Arch ==="

pacstrap -K /mnt base linux linux-headers linux-lts linux-lts-headers linux-firmware sudo nano grub efibootmgr

# Generate fstab

echo_green "=== Generate fstab ==="

genfstab -U /mnt >> /mnt/etc/fstab





# Activate chroot

echo_green "=== Activate chroot ==="

arch-chroot /mnt

# Set local time

echo_green "=== Set local time ==="

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Set hostname

echo_green "=== Set hostname ==="

echo "svoekino" > /etc/hostname

# GRUB

echo_green "=== Set GRUB ==="

grub-install --efi-directory=/boot/efi --boot-directory=/boot/efi/EFI --bootloader-id=grub

mkdir /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Gnome

# echo_green "=== Install gnome ==="

# pacman -S gnome
# systemctl enable gdm.service

echo_green "=== Install complete ==="
echo ""
echo_green "=== You can reboot the system ==="
