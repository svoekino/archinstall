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


# Set local time

echo_green "=== Set local time ==="

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

# Set hostname

echo_green "=== Set hostname ==="

echo "svoekino" > /etc/hostname

# Set cyr font

echo_green "=== Set cyr font ==="

echo "FONT=cyr-sun16" >> /etc/vconsole.conf

# GRUB

echo_green "=== Set GRUB ==="

grub-install --target=x86_64-efi  --efi-directory=/boot/efi --bootloader-id=grub

grub-mkconfig -o /boot/grub/grub.cfg

# GDM

echo_green "=== Enable GDM ==="

systemctl enable gdm.service

# NetworkManager

echo_green "=== Enable NetworkManager ==="

systemctl enable NetworkManager

# Reflector

echo_green "=== Set reflector ==="

reflector --country Russia --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Resolve

echo_green "=== Install completed ==="
echo ""
echo_green "=== Manual adjustment is required ==="
