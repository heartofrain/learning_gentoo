dd if=/dev/zero of=/dev/sda bs=1024 count=1

echo 'g
n
1

+1G
t
1
n



w
' | fdisk /dev/sda
mkfs.vfat -F 32 /dev/sda1
echo 'y
' | mkfs.ext4 /dev/sda2
mount /dev/sda2 /mnt/gentoo
ntpd -q -g
cd /mnt/gentoo
wget https://mirrors.tuna.tsinghua.edu.cn/gentoo/releases/amd64/autobuilds/20210912T170541Z/stage3-amd64-systemd-20210912T170541Z.tar.xz
tar xpf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
echo 'MAKEOPTS="-j8"' >> /mnt/gentoo/etc/portage/make.conf
echo 'GENTOO_MIRRORS="https://mirrors.aliyun.com/gentoo/ http://mirrors.aliyun.com/gentoo/ https://mirrors.163.com/gentoo/ http://mirrors.163.com/gentoo/ https://mirrors.tuna.tsinghua.edu.cn/gentoo"' >> /mnt/gentoo/etc/portage/make.conf
mkdir --parents /mnt/gentoo/etc/portage/repos.conf
cp /mnt/gentoo/usr/share/portage/config/repos.conf /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
sed -i 's/rsync.gentoo.org/mirrors.tuna.tsinghua.edu.cn/g' /mnt/gentoo/etc/portage/repos.conf/gentoo.conf
cp --dereference /etc/resolv.conf /mnt/gentoo/etc/
mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev

cp /gentoo_setup_afterchroot.bash /mnt/gentoo/gentoo_setup_afterchroot.bash 
chroot /mnt/gentoo /bin/bash /gentoo_setup_afterchroot.bash

reboot