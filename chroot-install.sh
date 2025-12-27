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


# Set local time

echo_green "=== Set local time ==="

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Set hostname

echo_green "=== Set hostname ==="

echo "svoekino" > /etc/hostname

# GRUB

echo_green "=== Set GRUB ==="

grub-install --target=x86_64-efi  --efi-directory=/boot/efi --bootloader-id=grub

mkdir /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Gnome

# echo_green "=== Install gnome ==="

# pacman -S gnome
# systemctl enable gdm.service

echo_green "=== Install complete ==="
echo ""
echo_green "=== Manual adjustment is required ==="
