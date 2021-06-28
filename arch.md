****

# Install

 Arch Linux 安装镜像不支持安全启动（Secure Boot）。要引导安装媒介，需要 [禁用安全启动](https://wiki.archlinux.org/title/Unified_Extensible_Firmware_Interface/Secure_Boot#Disabling_Secure_Boot)。如果需要，可在完成安装后重新配置 [安全启动](https://wiki.archlinux.org/title/Secure_Boot)。

安装映像使用 [systemd-boot](https://wiki.archlinux.org/title/Systemd-boot) 在 UEFI 模式下引导，

F12 禁用安全模式> 

1. 您将会以 root 身份登录进一个[虚拟控制台](https://en.wikipedia.org/wiki/Virtual_console)，默认的 Shell 是 [Zsh](https://wiki.archlinux.org/title/Zsh)。

## [download](https://archlinux.org/download/)

The image can be burned to a CD, mounted as an ISO file, or be directly written to a USB stick using a utility like `dd`. It is intended for new installations only; an existing Arch Linux system can always be updated with `pacman -Syu`.

- **Current Release:** 2021.06.01
- **Included Kernel:** 5.12.8
- **ISO Size:** 774.3 MB



## dd(disk duplication)

windows平台，可以使用 *Rufus* is a utility that helps format and create *bootable* USB flash drives,

```
df -h
  Gives an overview of the filesystem disk space usage.
查看U盘 盘符
```

```
sha1sum对文件进行唯一较验的hash算法，
shasum archlinux-2021.06.01-x86_64.iso | grep 6c41a22fb3c5eabfb7872970a9b5653ec47c3ad5
```

```
diskutil umountDisk /dev/disk2s1
sudo dd if=/Users/demo/Downloads/archlinux-2021.06.01-x86_64.iso of=/dev/disk2s1 bs=1m
# if inFile outFile blockSize
#You can press the ctrl+t (hold control key and press t) to see dd command progress on macOS


dd: /dev/rdisk1: Resource busy
$diskutil unmountDisk /dev/disk1 and then executed the command. 
```

 

## [Network configuration/Wireless](https://wiki.archlinux.org/title/Network_configuration/Wireless)

1) 安装无线驱动，通常iso文件中有相应的无线网卡驱动程序
2）管理无线连接的工具

### Device driver

The default Arch Linux kernel is *modular*, meaning many of the drivers for machine hardware reside on the hard drive and are available as [modules](https://wiki.archlinux.org/title/Kernel_modules). At boot, [udev](https://wiki.archlinux.org/title/Udev) takes an inventory(目录) of your hardware and loads appropriate modules (drivers) for your corresponding hardware, which will in turn allow creation of a network *interface*.

Many firmware images are provided by the [linux-firmware](https://archlinux.org/packages/?name=linux-firmware) package，proprietary firmware(私有固件)images are not included and have to be installed separately. 	

### Check the driver status

```
lspci -v 列出所有PCI设备 详细信息
获取 USB card设备信息，root用户 执行 dmesg | grep usbcore 
					 dmesg 用于检测和控制内核环缓冲。 了解系统的启动信息，
					 dmesg | grep usb 
没看到 无线网卡，

network controller:realtek semiconductor Co.,Ltd . Device 8852
subsystem : lenovo device 4852
kernel modules: w1

ethernet controller: RTL8111/8168/8411 PCI  有线
devicename : realtek RTL8111E Ethernet LOM
kernel driver : r8169


lspci | grep -i net
无线网卡 realtek 8852 支持wifi6

插上路由器网线 ping baidu.com ok, 无线网络要怎么配置
lspci -v | more  
```

usually the naming of the wireless network interfaces starts with the letter "w", e.g. wlan0 or wlp2s0. 

```
ip link set wlan0 up  # bring the wireless interface up
```

可能的错误信息：
 `Operation not possible due to RF-kill`, make sure that hardware switch is *on*. 例如摄像头 网卡 硬件开关

`No such file or directory`,  需要额外的驱动

```
# dmesg | grep firmware
# dmesg | grep iwlwifi # lspci -v 打印出来的 wifi>Kernel driver in use: iwlwifi
If the kernel module is fail loaded ，查找适配的无线网卡驱动进行安装。
```

  [#Installing driver/firmware](https://wiki.archlinux.org/title/Network_configuration/Wireless#Installing_driver/firmware) 根据  usb-id (for USB devices) or pci-id (for PCI devices)  查找无线网卡硬件是否被支持，然后安装。

### Utilities

[wpa_supplicant](https://archlinux.org/packages/?name=wpa_supplicant)  

> 浏览器打开网页输入密码登录wifi， most likely whitelists your MAC address for a hour or a day.



BIOS thermal Mode 热量模式，如何通过命令行调整？

rfkill是一个内核级别的管理工具，可以打开和关闭设备的蓝牙和wifi

```
# rfkill list
# rfkill unblock wifi
  rfkill unblock all
```

### mount

```
mount可将指定设备中指定的文件系统加载到Linux目录下（也就是装载点）。可将经常使用的设备写入文件/etc/fstab,以使系统在每次启动时自动加载。mount加载设备的信息记录在/etc/mtab文件中。使用umount命令卸载设备时，记录将被清除。 

使用目录/mnt/vcdrom，即可访问盘镜像文件mydisk.iso中的所有文件。
# mount -o loop -t iso9660 /home/sunky/mydisk.iso /mnt/vcdrom

administrator 和 pldy123 是ip地址为10.140.133.23 windows计算机的一个用户名和密码，c$是这台计算机的一个磁盘共享
# mount -t smbfs -o username=administrator,password=pldy123 //10.140.133.23/c$ /mnt/samba
```

```
https://archlinuxstudio.github.io/ArchLinuxTutorial/#/rookie/basic_install
systemctl stop reflector.service ， reflector 服务，它会自己更新 mirrorlist。

因为 ip link 没有看到wlan0无线网卡，无线网卡驱动有问题，只能先链接有线安装
iwctl // wlan0 无线网卡
station wlan0 getnetworks
station wlan0 connect wifiName
exit
ping www.baidu.com
systemctl start dhcpcd

timedatectl set-ntp ture 系统时间与网络时间同步
timedatectl status

vim /etc/pacman.d/mirrorlist
/ustc
dd p 剪贴到第一行

首先将磁盘转换为 gpt 类型
lsblk
parted /dev/sda
(parted)mktable             #输入mktable,carete a new disklabel(partition table)
gpt
quit

对磁盘分区 create disk 
cfdisk /dev/sda
new 300m type:efiSystem
new 2G type:linux swap
 root linux system
 home 
 write

8 GB - 64 GB	0.5 times the amount of RAM
/dev/efi 300M
/dev/swap 8G

 fdisk -l
 格式化 format disk
 mkfs.ext4 /dev/sda3
 mkfs.vfat /dev/sda1 ,efi system
 mkswap  -f /dev/sda2
 swapon /dev/sda2
 
 挂载
 mount /dev/sda3 /mnt
 mkdir /mnt/home 
 mount /dev/sda4 /mnt/home
 mkdir /mnt/boot
 mkdir /mnt/boot/EFI
 mount /dev/sda1 /mnt/boot/EFI
 
 安装系统 , pacstrap - install packages to the specified new root directory
pacstrap /mnt base base-devel linux linux-firmware  #base-devel在AUR包的安装是必须的
pacstrap /mnt dhcpcd iwd vim sudo bash-completion   #一个有线所需 一个无线所需 一个编辑器  一个提权工具 一个补全工具 iwd也需要dhcpcd
 
 fstab 用来定义磁盘分区
 genfstab -U /mnt >> /mnt/etc/fstab 
 cat /mnt/etc/fstab
 切换到/mnt下面的应用系统中
 arch-chroot /mnt
 设置时区
 ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 这里的local没有e
 设置主机名
 vim /etc/hostname
 myarch
 vim /etc/hosts
 127.0.0.1   localhost
 ::1         localhost
 127.0.1.1   myarch.localdomain    myarch

 hwclock --systohc 同步硬件时间
 设置语言 字符集
 vim /etc/locale.gen 
 /en_US n  en_US.UTF-8 x剪切# :wq
 去掉 en_US.UTF-8 行以及 zh_CN.UTF-8 的注释符号（#）。
 locale-gen
 echo "LANG=en_US.UTF-8" > /etc/locale.conf
 
 passwd root
 pacman -S amd-ucode // intel-ucode  处理器制造商发布对处理器微码的稳定性和安全性更新。
 
 引导程序
 pacman -S grub efibootmgr
 grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
 vim /etc/default/grub
 去掉GRUB_CMDLINE_LINUX_DEFAULT一行中最后的 quiet 参数，同时把 log level 的数值从 3 改成 5。这样是为了后续如果出现系统错误，方便排错。同时加入 nowatchdog 参数，这可以显著提高开关机速度。
 
 grub-mkconfig -o /boot/grub/grub.cfg
 exit 
 unmount -R /mnt 卸载分区 ，重启前要先拔掉优盘
 reboot
 
 ping www.baidu.com ,Temporay failure in name resolution
 systemctl enable dhcpcd 开机自启
 systemctl start dhcpcd ，几秒后即可
 pacman -S neofetch
 neofetch
 
 https://archlinuxstudio.github.io/ArchLinuxTutorial/#/rookie/DE&App
 
 《桌面环境》
pacman -Syyu    #升级系统中全部包
 useradd -m -g users -G wheel -s /bin/bash demo
 passwd demo
 
 visudo 提示 no editor found (editor path = /usr/bin/vi)
 EDITOR=vim  visudo //设置变量，visudo使用editor变量
 /wheel 
 取消wheel组注释
 %wheel ALL=(ALL) ALL
%wheel 代表是 wheel 组，百分号是前缀
ALL= 代表在所有主机上都生效(如果把同样的sudoers文件下发到了多个主机上)
(ALL) 代表可以成为任意目标用户
ALL 代表可以执行任意命令
 
 pacman -S plasma-meta kconsole dolphin bash-completion 
 回车执行默认选项1 回车代表yes 
 
 systenlc enable sddm //  greeter sddm 
 
KDE 自身提供开箱即用的睡眠功能(suspend)，即将系统挂起到内存，消耗少量的电量。休眠(hibernate)会将系统挂起到交换分区或文件，几乎不消耗电量。
 
开启 32 位支持库与 ArchLinuxCN 支持库
去掉[multilib]一节中两行的注释，来开启 32 位库支持。

 sudo vim /etc/pacman.conf 
 G 取消注释 multilib ,Include = /etc/pacman.d/mirrorlist
 custom 修改为 
 [archlinuxcn]
 Server =https://mirros.ustc.edu.cn/archlinuxcn/$arch
 中科大中文源 软件
 https://github.com/archlinuxcn/mirrorlist-repo#arch-linux-cn-community-repo-mirrors-list
 
 
 pacman -Syyu 能够看到multilib archlinuxcn 源显示出来了
 reboot
 
 sudo pacman -S ntfs-3g  外接硬盘ntfs
 sudo pacman -S adobe-source-han-serif-cn-fonts wqy-zenhei 开源字体
 pacman -S noto-fonts-cjk noto-fonts-emoj noto-fonts-extra google字体
 pacman -S firefox chromium
 pacman -S archlinuxcn-keyring 
 pacman -S yay 
 
 settings>region > language >简体中文
 logout
 
 pacman -S fcitx5-im 中文输入法
 pacman -S fcitx5-chinese-addons
 pacman -S fcitx5-pinyin-moegirl 词库
 pacman -S fcitx5-material-color 
 settings>region > 添加输入法 >pinyin

 vim ~/.pam_environmentt
 环境变量
 INPUT_METHOD DEFAULT=fcitx5
 GTK_IM_MODULE DEFAULT=fcitx5
 QT_IM_MODULE DEFAULT=fcitx5
 XMODIFIERS DEFAULT=\@im=fcitx5
 
 系统设置>开机关机>添加搜索输入法开机自启
 ctrl+空格
 
 启动蓝牙 sudo systemctl enable --now bluetooth
 
 
sudo pacman -Syyu #更新官方仓库
yay -Syyu #同时更新官方仓库与AUR
 
```

[为什么使用 Arch Linux？](https://archlinuxstudio.github.io/ArchLinuxTutorial/#/?id=为什么使用-arch-linux？)

最重要的，Arch Linux 的软件包是最新的，这在日常使用中非常必要，你可以第一时间享受到新软件的特性，而不用烦心于升级软件时的过旧依赖的问题。

```
为什么Deepin现在把LibreOffice作为默认办公软件而不是WPS？
免费不等于自由，虽然英文都是free。
wps有自己的用户条款。Deepin系统不能代替用户去同意金山公司的条款。有些，尤其可能涉及用户隐私数据的，只能由用户自己决定是否接受条款。在法律上，软件的使用，复制，分发都是不同的概念。金山允许你免费使用，不代表就允许Deepin你复制，并分发给你的用户。
```

```
modprobe
功能：Linux内核添加删除模块
```

# pacman

```
-s, --search <regexp>
-S, --sync
Synchronize packages. Packages are installed directly from the remote repositories, including all dependencies required to run the packages.

pacman -Ss {pkgNameHere}
pacman -Ss {keyWordHere}

pacman -Ss vscode

```

在Linux系统中的SWAP（交换分区），类似于Windows系统的虚拟内存。系统会把一部分硬盘空间虚拟成内存使用，将系统内非活动内存换页到SWAP，以提高系统可用内存。



### FAQ

mount: /mnt: unknown filesystem type 'ext4'.
Reboot your system, you updated your kernel and now the old modules are no longer there.

start dhcpcd  platform regulatory direct firmware load for regulatory.db failed
https://stackoverflow.com/questions/61346623/error-when-starting-wifi-interface-failed-to-load-regulatory-db



无线网卡未识别

安装适配 Realtek 8852 的驱动 https://github.com/lwfinger/rtw89

```
pacman -Syu
pacman -S make gcc linux-headers base-devel git
// base-devel 等同于 apt的 build-essential

linux-headers 5.12.12.arch1-1
即这个包名是linux-headers 

lspci -v | more
可以看 8852 无线网卡使用的 kernel module: rtw89pci
编译替换该模块即可

git clone https://github.com/lwfinger/rtw89.git
cd rtw89
make
sudo make install
sudo modprobe rtw89pci 
ip link 能看到 wlan0 ,wireless 无线网络了

iwctl - Internet wireless control utility
systemctl enable iwd
systemctl restart iwd
iwctl                           #进入交互式命令行
device list                     #列出设备名，比如无线网卡看到叫 wlan0
station wlan0 scan              #扫描网络
station wlan0 get-networks      #列出网络 比如想连接CMCC-5AQ7这个无线
station wlan0 connect CMCC-5AQ7 #进行连接 输入密码即可
exit                            #成功后exit退出

rfkill unblock wifi
failed to release fwcmd 重启电脑

备注：内核改变时，需要重新执行
When your kernel changes, then you need to do the following:
cd ~/rtw89
git pull
make
sudo make install
```

##  [iwd](https://wiki.archlinux.org/title/Iwd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

[ iwd](https://iwd.wiki.kernel.org/) (iNet wireless daemon，iNet 无线守护程序) 是由英特尔（Intel）为 Linux 编写的一个无线网络守护程序。该项目的核心目标是不依赖任何外部库，而是最大程度地利用 Linux 内核提供的功能来优化资源利用。[[1\]](https://www.youtube.com/watch?v=F2Q86cphKDo)

iwd 可以独立工作，也可以和 [ConnMan](https://wiki.archlinux.org/title/ConnMan)、[systemd-networkd](https://wiki.archlinux.org/title/Systemd-networkd) 和 [NetworkManager](https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend) 这样更完善的网络管理器结合使用

[iwd](https://archlinux.org/packages/?name=iwd) 软件包提供了客户端程序 `iwctl`、守护程序 `iwd` 和 WiFi 监控工具 `iwmon`。

```
[iwd]# station device connect SSID  会提示输入密码
```

```
$ iwctl --passphrase passphrase station device connect SSID
```

- `iwd` 会自动将网络密码存储在 `/var/lib/iwd` 目录中，以后就可以使用其自动连接记住的网络。参见 [#可选配置](https://wiki.archlinux.org/title/Iwd_(简体中文)#可选配置) 一节。
- 要连接 SSID 里带空格的网络，连接时请用双引号将网络名称括起来。

```
[iwd]# station device disconnect 断开网络连接
[iwd]# device device show 显示 WiFi 设备详细情况，比如 MAC 地址：
[iwd]# station device show 显示网络连接状态
[iwd]# known-networks list
[iwd]# known-networks SSID forget 
```

## 美化

[**Sleek GrubBootloader themes [That greets you with your name]**](https://www.pling.com/p/1414997/)



# 屏幕亮度 无法调整

```
/etc/default/grub 
GRUB_CMDLINE_LINUX_DEFAULT="video.use_native_backlight=1"
sudo update-grub

- GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"
+ GRUB_CMDLINE_LINUX_DEFAULT="quiet splash noveau.modeset=0 acpi_backlight=native"

配置出错，重启不了
```



## 救援模式

[boot into rescue mod or emergency mod](https://linux.cn/article-10409-1.html)
**救援模式**相当于使用 **SysV** 作为默认的服务管理器的 Linux 发行版中的 **单用户模式**。在救援模式下，将挂载所有本地文件系统，仅启动一些重要服务。但是，不会启动正常服务（例如网络服务）。救援模式在系统无法正常启动的情况下很有用。此外，我们可以在救援模式下执行一些重要的救援操作，例如[重置 root 密码](https://www.ostechnix.com/how-to-reset-or-recover-root-user-password-in-linux/)。

与救援模式相比，在**紧急模式**中不启动任何东西。没有服务启动、没有挂载点、没有建立套接字，什么也没有。你所拥有的只是一个**原始的 shell**。紧急模式适用于调试目的。

启动你的 Ubuntu 18 系统。出现 Grub 菜单时，选择第一条并按下 `e` 进行编辑。

如果你没有看到 Grub 菜单，只需在 BIOS 的 logo 消失后立即按下 `ESC` 键。

//archlinux 启动时 按e 编辑 archlinux的启动参数，即可

找到以单词 `linux` 开头的行，并在该行的末尾添加以下内容（要到达末尾，只需按下 `CTRL+e` 
![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/06/2620210626113858.png)

添加完成后，只需按下 `CTRL+x` 或 `F10` 即可继续启动救援模式。几秒钟后，你将以 root 用户身份进入救援模式（单用户模式）

输入以下命令将根 （`/`） 文件系统重新挂载成读/写模式。 //archlinux 不需要，有读写权限

```
mount -n -o remount,rw /
```



## [关闭terminal beep 提示声](https://linuxconfig.org/turn-off-beep-bell-on-linux-terminal)

```
$ sudo nano /etc/inputrc
		set bell-style none

//for vim 
set visualbell 
//To turn it off completely, edit or create a .vimrc file in your home directory ( ~/ ) and add the following line

rmmod pcspkr  // 有效
sudo nano /etc/modprobe.d/blacklist.conf
	blacklist pcspkr 
```



nouveau 是一个自由及开放源代码显卡驱动程序，是为Nvidia的显卡所编写





### 显卡驱动

安装 optimus-manager。可以在核芯显卡和独立显卡间轻松切换

optimus-manager 提供三种模式，分别为仅用独显，仅用核显，和 hybrid 动态切换模式。

```
yay -S optimus-manager optimus-manager-qt
sudo systemctl enable optimus-manager
```

```
lsmod指令，会列出所有已载入系统的模块。Linux操作系统的核心具有模块化的特性，应此在编译核心时，务须把全部的功能都放入核心。
```





```
 查看用户列表
 cat /etc/passwd
 
 pacman -Syu 同步软件包数据库
 
 pacman -S reflecto // 根据响应速度更新 /etc/pacman.d/mirrorlist
 reflector --verbose --lastest 5 --sort rate --country 'China,Germany'  --save /etc/pacman.d/mirrorlist
 
 dns
 resolv.conf.head file, or write-protect /etc/resolv.conf
 
 pacman -S code  安装vscode
 
update-grub command is just a script which runs the grub-mkconfig tool to generate a grub.cfg file.
# grub-mkconfig -o /boot/grub/grub.cfg

查看linux kernel version
uname -r
cat /proc/version

The shortcut I remember for back logo light is Fn + L 关闭laptop 背光灯
```

I'm fucked ,  亮度无法调节 外接显示器 不现实 ，fuck archlinux 

https://www.reddit.com/r/archlinux/comments/nz0ytw/legion_5_15ach6h_my_journey_with_arch_is_so_short/

no hope with archlinux ,go debian or ubutnu

By the way

1. If I enable in BIOS Hybrid mode - I have the same brightness as in Windows by default in Ubuntu, without can't changing
2. If I enable in BIOS Discrete mode - I have 100% brightness in Ubuntu, without can't changing
