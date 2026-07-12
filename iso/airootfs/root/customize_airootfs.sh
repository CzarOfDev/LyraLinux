#!/usr/bin/env bash
set -e -u

# Локаль
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(ru_RU\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Live-пользователь
groupadd -r autologin
useradd -m -G wheel,autologin,video,audio,storage -s /bin/bash live
passwd -d live

# sudo без пароля в live-сессии
echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/00-lyra-live
chmod 440 /etc/sudoers.d/00-lyra-live
