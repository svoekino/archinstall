#!/bin/bash

set -e +x

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

mkfs.fat -F 32 /dev/vda1
mkfs.btrfs -f /dev/vda2

# Mount volumes
echo_green "=== Mount volumes ==="

mount /dev/vda2 /mnt

# Create subvolumes

echo_green "=== Create subvolumes ==="

btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home

# Unmount volume
echo_green "=== Unmount volume ==="
umount /dev/vda2

# Mount subvolumes and boot

echo_green "=== Mount subvolumes and boot ==="

mount -o subvol=@ /dev/vda2 /mnt
mount --mkdir -o subvol=@home /dev/vda2 /mnt/home
mount --mkdir /dev/vda1 /mnt/boot/efi

# Install Arch

echo_green "=== Install Arch ==="

pacstrap -K /mnt base linux linux-headers linux-lts linux-lts-headers linux-firmware sudo nano grub efibootmgr gnome networkmanager pipewire git zsh timeshift mesa libva-mesa-driver vulkan-radeon xorg-server

# Generate fstab

echo_green "=== Generate fstab ==="

genfstab -U /mnt >> /mnt/etc/fstab



