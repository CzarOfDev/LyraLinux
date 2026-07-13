#!/usr/bin/env bash
set -e -u

# locale
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(ru_RU\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Live-user
groupadd -r autologin
useradd -m -G wheel,autologin,video,audio,storage -s /bin/bash lyra
passwd -d lyra

# sudo without password in live-session
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/00-lyra-live
chmod 440 /etc/sudoers.d/00-lyra-live

#Hostname

echo 'lyraiso' > /etc/hostname

# os-release: перебиваем то, что принёс пакет filesystem
cat > /usr/lib/os-release << 'OSREL'
NAME="Lyra Linux"
PRETTY_NAME="Lyra Linux"
ID=lyra
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;143;166;238"
HOME_URL="https://github.com/CzarOfDev/LyraLinux"
BUG_REPORT_URL="https://github.com/CzarOfDev/LyraLinux/issues"
LOGO=lyra
OSREL
ln -sf /usr/lib/os-release /etc/os-release
