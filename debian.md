https://www.debian.org/doc/manuals/debian-reference/index.zh-cn.html

高级软件包工具(APT), `dpkg` 的前端，提供了 “`http`” 、“`ftp`” 和 “`file`” 的档案库访问方式（包含 `apt`、`apt-get` 和 `apt-cache` 命令）
aptitude(8) 使用一个交互式的文本界面来管理已安装的软件包和搜索可用的软件包。

“`/etc/apt/sources.list`”  

- “`deb`” 的那行定义了二进制软件包。
- “`deb-src`” 的那行定义了源代码软件包。

添加 demo到sudo用户组

```
su - root
usermod -a -G sudo demo
su - demo
groups demo # sudo
密码 2021
```

## install chrome

Google Chrome packages are not available in the Debian repositories since it is not purely open source 

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install wget
sudo apt install ./google-chrome-stable_current_amd64.deb
```

This command will install Google Chrome on Debian and required dependencies. In the process, it will also add the Google repository so your system for automatic updating of Google Chrome.

```
$ cat /etc/apt/sources.list.d/google-chrome.list 
```

```
$ google-chrome  # google-chrome --no-sandbox
sudo apt update
sudo apt upgrade
```

chrome>setting>apperance> GTK theme ,no title border  隐藏顶部窗口标题栏

## 常用配置

1. software & update ,enable download from the internet ,允许下载非开源软件
2. 



# [管理员手册》](https://debian-handbook.info/browse/zh-CN/stable/)

develper> unstable > test > stable 

# 安装美化

mirror 163

debain ，最小安装 取消 桌面选择界面所有选项

```
apt-get update
apt-get install vim curl git sudo 
vimm /etc/sudoers
demo ALL=(ALL) NOPASSWD:ALL

```



# debain 11

 **open** command is available as a convenience alias to **xdg-open** (by default) or **run-mailcap**，使用open命令打开应用

Fcitx 5 is an input method for Chinese

bullseye is the first release providing a Linux kernel which has support for the exFAT filesystem, 

安装 bullseye test 版本

内核升级到 5.11

uname -a
uname-r

cat /etc/os-release 

 find -name "ipconfig",ifconfig的功能替换成了ip。



```
ip a
eno1 is the onboard Ethernet (wired) adapter.

lo is a loopback device. You can imagine it as a virtual network device that is on all systems, even if they aren't connected to any network. It has an IP address of 127.0.0.1 and can be used to access network services locally. 

There is no wi-fi adapter listed. lspci and lsusb may help you find them in the first place at which point you need to figure out why it isn't working.
```

sudo poweroff

*Discrete* *graphics*是独立显卡;独立绘图卡;独立显示卡的意

