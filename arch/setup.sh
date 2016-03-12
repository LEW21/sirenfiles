#!/bin/sh
set -e

version=$1

# Follow pacman.conf
mv /var/lib/pacman /usr/lib/
rm /var/log/pacman.log

# Use a snapshot of Arch from a given day
echo "Server=https://archive.archlinux.org/repos/${version//.//}/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

# Sane default locale
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# /dev/random is too slow on VMs
bash -c "rm /dev/random; ln -s urandom /dev/random; pacman-key --init"

pacman-key --populate
pacman -Syyuu --noconfirm
pacman -S --noconfirm bash coreutils findutils tar sed systemd
locale-gen

# https://bugs.archlinux.org/task/45462
mv /var/lib/iptables /usr/share
mv /var/lib/ip6tables /usr/share
sed -i 's#/var/lib#/usr/share#g' /usr/lib/systemd/scripts/iptables-flush

# Required for network access.
systemctl enable systemd-networkd

# Not necessary, makes containers smaller.
rm /etc/mtab
ln -s ../proc/self/mounts /etc/mtab
ln -s ../usr/lib/os-release /etc/os-release
systemd-tmpfiles --create
rm /usr/lib/systemd/system/sysinit.target.wants/systemd-hwdb-update.service

# Replaceable Containers FHS
mkdir /data

# Add resolved for LLMNR.
# Don't delete dns because it's needed during build (when nspawning without --boot).
sed -i 's|hosts: files dns myhostname|hosts: files resolve dns myhostname|' /etc/nsswitch.conf
systemctl enable systemd-resolved

# Useless files
rm /etc/systemd/*.conf

# CoreOS
mkdir -p /usr/lib/systemd/journald.conf.d
printf "[Journal]\nCompress=no\n" > /usr/lib/systemd/journald.conf.d/coreos.conf

# pip
printf "[global]\ncache-dir=/var/cache/pip\ndisable-pip-version-check=yes\n" > /etc/pip.conf
