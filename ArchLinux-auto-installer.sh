#!/bin/bash
set -e

# --- SETTINGS ---
DISK="/dev/sda"
HOSTNAME="arch"
ROOT_PASSWORD="changeme"

echo "[*] Wiping $DISK"
sgdisk -Z "$DISK"
sgdisk -n 1:0:+512M -t 1:ef00 -c 1:EFI "$DISK"
sgdisk -n 2:0:0     -t 2:8300 -c 2:ROOT "$DISK"

echo "[*] Formatting partitions"
mkfs.fat -F32 ${DISK}1
mkfs.ext4 ${DISK}2

echo "[*] Mounting partitions"
mount ${DISK}2 /mnt
mkdir /mnt/boot
mount ${DISK}1 /mnt/boot

echo "[*] Installing base system"
pacstrap /mnt base linux linux-firmware

echo "[*] Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "[*] Configuring system in chroot"
arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "$HOSTNAME" > /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

echo "root:$ROOT_PASSWORD" | chpasswd

echo "[*] Installing bootloader"
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
EOF

echo "[*] Unmounting and rebooting"
umount -R /mnt
reboot
