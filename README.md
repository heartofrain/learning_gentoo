 ## gentoo 一键安装脚本 

### 描述

脚本文件位于`installation_scripts`文件夹下。根据[gentoo官方文档](https://wiki.gentoo.org/wiki/Handbook:AMD64)编写而成。

### 使用方法

**【警告】：脚本会自动分区并格式化`/dev/sda`，严禁在宿主机中执行脚本。仅可在分配有新硬盘的虚拟机中尝试。**

step0、安装虚拟机，下载[gentoo安装媒介](https://wiki.gentoo.org/wiki/Handbook:AMD64/Installation/Media)

step1、为虚拟机分配4GB以上的内存、4核以上的CPU、20GB以上的硬盘，打开EFI支持，将上一步中下载的iso文件分配到虚拟机

step2、启动虚拟机电源，等待安装媒介的root账户登录

step3、依次执行以下命令：

```bash
wget https://github.com/heartofrain/learning_gentoo/archive/refs/heads/main.zip
unzip main.zip
cd learning_gentoo-main/installation_scripts
cp ./gentoo_installation_afterchroot.bash /gentoo_installation_afterchroot.bash
cp ./gentoo_installation_beforechroot.bash /gentoo_installation_beforechroot.bash
bash /gentoo_installation_beforechroot.bash
```

step4、等待安装完成即可，默认的root密码为：123!@#QWE