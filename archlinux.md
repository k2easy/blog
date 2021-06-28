# installl

5.11.16 

硬盘分区 格式化 挂载

```
fdisk -l
fdisk /dev/sda
n 新建 
+2G 
w 保存
fdisk -x

mkfs.ext4 /dev/sda6 
mkswap /dev/sda5

mount /dev/sda6 /mnt  挂载根目录
swapon /dev/sda5
```

在 LiveCD 启动的系统上，在连接到因特网后，[reflector](https://wiki.archlinux.org/title/Reflector) 会通过选择 20 个最新同步的 HTTPS 镜像并按下载速率对其进行排序来更新镜像列表/etc/pacman.d/mirrorlist,越前的镜像在下载软件包时有越高的优先权。可自定义修改，这个文件接下来还会被 *pacstrap* 拷贝到新系统里



安装必须的软件包

```
pacstrap /mnt base 
pacstrap /mnt linux 
pacstrap /mnt linux-frimware
```

- 在虚拟机或容器中安装时，可以不安装固件软件包。
  

配置系统

```
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt 到新安装的系统


设置时区
# ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# hwclock --systohc 同步硬件时间

网络配置
pacman -S vim  
vim /etc/hostname
myarch（主机名）
vim /etc/hosts
127.0.0.1	localhost
::1		localhost
127.0.1.1	myarch.localdomain	myarch# 主机名.本地域名 主机名

passwd 
k2easy 

安装引导程序 grub
```

安装参考  https://itsfoss.com/install-arch-linux/

```
pacman -S grub
# grub-install --target=i386-pc /dev/sda # 磁盘 /dev/sda，而 不是 分区 /dev/sda1
# grub-mkconfig -o /boot/grub/grub.cfg
```

安装图形窗口

```
pacman -S xorg
pacman -S gnome

systemctl start gdm.service
systemctl enable gdm.service
systemctl enable NetworkManager.service

exit 
shutdown now
```

拔出USB 光盘ios，vmware  cd/dvd dirver 取消ios

ctrl+alt+F1 图形窗口。F2~F6 tty

reboot 重启

无法启动gnome terminal

```
localectl set-locale LANG="en_US.UTF-8"
localectl set-x11-keymap us
gnome>settings, Regions & Language  选择 英语 即可
reboot
```



# 使用 wiki

```
pacman -Syu
```

- S stands for sync
- y is for refresh (local
- u is for system update

pacman -Ss _string1_ _string2_ ... 搜索包

pacman -Qs _string1_ _string2_ ... 搜索 已安装包

To search for package file names in remote packages:

```
pacman -F _string1_ _string2_ ...
```

To view the dependency tree of a package:

```
pactree _package_naenter code hereme_
```

paccache -r 

Cleaning the package cache

Pacman stores its downloaded packages in /var/cache/pacman/pkg/ and does not remove the old or uninstalled versions automatically. 

## Installing Google Chrome with an AUR Helper

Arch User Repository)

pacman -S --help

useradd -m demo

```
su - root
passwd demo
```

```
# useradd -m -G wheel -s /bin/bash techuser

The -s option specifies the default login shell. In this case, we are assigning bash shell denoted by /bin/bash.

# visudo
Or
# vi /etc/ sudoers

## Uncomment to allow members of group wheel to execute any command
%wheel ALL=(ALL) ALL  
techusr ALL=(ALL) ALL
su - techuser
$ whoami
example_user
$ sudo whoami

sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay-git.git
cd yay
makepkg -si
yay -S google-chrome
yay -Syu
```

```
# usermod --append --groups wheel example_user
```

## update arch linux

```
sudo pacman --sync --refresh

```

aur 安装失败

```
echo "export GOPROXY=https://goproxy.cn" >> ~/.profile
source ~/.profile
```





arch 兼容性不好，例如chrome 没有arch包 ，但是有 chrome.deb ，切换到debian

