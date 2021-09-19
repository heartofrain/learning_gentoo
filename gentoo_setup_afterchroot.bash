source /etc/profile
export PS1="(chroot) ${PS1}"
mount /dev/sda1 /boot
emerge-webrsync && emerge --sync && emerge --verbose --update --deep --newuse @world
echo 'en_US ISO-8859-1' > /etc/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
eselect locale set 6
env-update
source /etc/profile
export PS1="(chroot) ${PS1}"
echo 'ACCEPT_LICENSE="*"' >> /etc/portage/make.conf
emerge sys-kernel/gentoo-sources 
#（genkernel需要/usr/src下存在内核源码）
emerge sys-kernel/genkernel
# df -lT （查看所有分区的类型）
echo '/dev/sda1 /boot vfat noatime 0 1' >> /etc/fstab
echo '/dev/sda2 / ext4 noatime 0 0' >> /etc/fstab
mv /usr/src/linux-5.10.61-gentoo /usr/src/linux

genkernel all

# genkernel的内核config文件位于：/usr/share/genkernel/arch/x86_64/generated-config

echo 'hostname="user"' > /etc/conf.d/hostname
echo 'dns_domain_lo="homenetwork"' > /etc/conf.d/net
emerge net-misc/dhcpcd
echo '127.0.0.1  user.homenetwork   user   localhost' > /etc/hosts
echo -e '123!@#QWE\n123!@#QWE' | passwd root
mkdir -p /etc/portage/package.accept_keywords
echo "sys-boot/systemd-boot" >> /etc/portage/package.accept_keywords/systemd-boot
emerge sys-boot/systemd-boot
echo "sys-apps/systemd gnuefi" >> /etc/portage/package.use/systemd
emerge -uDU @world
bootctl --path /boot install
mv /boot/vmlinuz* /boot/vmlinuz
mv /boot/initramfs* /boot/initramfs

cat > /boot/loader/loader.conf << "EOF"
default mygentoo 
timeout 3
EOF

cat > /boot/loader/entries/mygentoo.conf << "EOF"
title myGentoo
linux /vmlinuz
initrd /initramfs
options root=/dev/sda2
EOF

# +++++++++++++++++
emerge neofetch
systemctl enable dhcpcd
systemctl enable sshd
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
#systemctl restart sshd

