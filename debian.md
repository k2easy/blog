# 简介

>www.debian.org
>
>https://debian-handbook.info/
>
>https://debian-handbook.info/browse/zh-CN/stable/  翻译中

# 《debian-handbook.info》

**Linux 发行版本与 Linux 内核**

​		严格意义上说，Linux 只是一个内核，是处于硬件与应用程序之间的核心软件。 

​		Linux 发行版本则是一个完整的操作系统，通常包括 Linux 内核，安装程序，大部分重要的应用程序和其它能把电脑变得有用的软件。 

适用于 GNU/Linux 的通用文档也适用于 Debian，因为 Debian 包括最常见的自由软件。不过，作为一个发行版， Debian 带来了许多改进，带有“Debian 风格”。

#  第 1 章 Debian 项目

>`debian-cd` 已经存在很长时间了，它可以用来创建一组光盘，其中仅包含一系列预先选择的软件包；`debian-installer` 也是一个模块化的安装工具，易于适应不同的需求。`APT` 可以使用不同的来源安装软件包，同时保证系统整体的一致性。 		
>
>目前支持有 10 个硬件架构
>
>Debian 遵循所有的自由软件的原则，在充分准备好之前新版本不会释出。开发者不会被时间表限定需要追赶一个随意的截止日期。人们经常抱怨  Debian 发布稳定版之间的时间间隔过长，但这样的谨慎保证了 Debian  一贯的可靠性：在赋予全发行版“稳定”标签之前长时间的测试确实是必要的。 

## 如何迁移

### nmap

> Nmap（Network Mapper）是一款开放源代码的网络探测和安全审核工具。它用于快速扫描一个网络和一台主机开放的端口，还能使用TCP/IP协议栈特征探测远程主机的操作系统类型。
>
> 用于 快速地探测一台线上机器上运行着哪些互联网服务。
>
> `netstat -tupan` 指令可显示活动中或传输中的 TCP 会话，以及运行中程序监听的 UDP 端口。这有助于识别机器上提供的服务。 			

### 备份配置

> 源码安装的程序配置文件在 /etc/内
> 有时放在 `/usr/local/` 的子文件夹里 或 /opt/ 

 `/etc/debian_version`包括 Debian 系统的版本编号 

`apt-show-versions` 程序检查已安装软件包的列表并标识可用的版本

查看 `/etc/apt/sources.list` 文件 (以及 `/etc/apt/sources.list.d/` 文件夹) 可看到已安装 Debian 软件包的来源。
以人工方式安装 (在 `dpkg` 指令的帮助下) 从互联网随机抓来的软件包。在此情况下，可能表面上是 “标准” Debian 系统。碰到这种情况应放弃外来的软件包

`/usr/local/`  编译后与手动安装后的程序

debsums 软件包允许将由软件包安装的每个文件的 MD5 哈希和与参考哈希和进行比较，并帮助确定，那些文件被改变，

## 安装

Buster 的安装程序基于 `debian-installer`。

引导程序是 BIOS 开始的第一个程序。它把 Linux 内核加载进内存然后执行。通常提供给用户一个内核选择菜单去加载引导操作系统。 		

双系统，在 Debian 安装过程中检测到已经安装的操作系统时，会自动把它加到引导菜单项中，但不是所有的安装程序都能这么做。 		

GRUB 是 Debian 的默认引导程序：它能识别大部分的文件系统，因此在每次安装新内核之后无须作更新，这是由于引导时 GRUB 是通过读取配置文件找到新内核的实际位置的

安全启动（Secure Boot）是一种保证只有操作系统发行者确认合法的软件才允许运行的技术。对启动时的每个软件都进行密钥检验，过长太漫长。Debian决定不直接签署GRUB，使用shim中间引导加载程序，检查Grub上Debian提供的签名，并执行GRUB。为了在允许安全启动的机器上运行Debian，需要安装shim-signed软件包。 		

Debian10是支持安全启动（Secure Boot）的第一个发行版。此前，必须禁止BIOS或UEFI提供的系统设置屏幕上的安全特性。

安装现已完成，提示你取出光盘并重启计算机

如果你选择”图形桌面环境“，系统将显示 `gdm3` 登录管理器

# 包管理系统

> ​			`dpkg` 是处理 `.deb` 二进制文件的命令，包括是提取、分析和解包它们。 	
>
> ​			APT （Advanced Packaging Tool）是一组允许对系统进行高层定制的程序：安装或者删除一个软件包（并且保持依赖关系满足），更新系统，升级系统，列出可用的软件包等。 	

## 软件包元信息

> Debian 软件包不仅是一个待安装文件的归档。它是一个更大结构的一部分，它描述与其它 Debian  软件包的关系（前置、依赖、冲突、建议）。它还提供执行的脚本，供管理套件在软件包生命周期的不同阶段（安装、升级、删除）执行。软件包中的这些数据供包管理工具使用，但不是软件包的一部分，称为“元信息”（关于软件包的信息）。 	



control 描述文件

```
$ apt-cache show apt
Package: apt
Version: 1.8.2
Installed-Size: 4064
Maintainer: APT Development Team <deity@lists.debian.org>
Architecture: amd64
Provides: apt-transport-https (= 1.8.2)
Depends: adduser, gpgv | gpgv2 | gpgv1, debian-archive-keyring, libapt-pkg5.0 (>= 1.7.0~alpha3~), libc6 (>= 2.15),
```

**`dpkg` 的数据库**

 所有已安装的软件包的配置脚本都存在`/var/lib/dpkg/info/`目录，

dpkg处理.deb包的基础命令
apt或aptitude 高级包管理命令，解决包依赖问题

`dpkg` 是安装 Debian 已经可用软件包的工具 (因为不需下载任何东西)，-i --install

```
# dpkg -i man-db_2.8.5-2_amd64.deb
Unpacking man-db (2.8.5-2) over (2.8.5-2) ...
Setting up man-db (2.8.5-2) ...
Updating database of manual pages ...


```

常见错误：
遇到这样一个文件冲突，当一个软件包包含的文件中已经安装了另外一个软件包。: 		

```
Unpacking libgdm (from .../libgdm_3.8.3-2_amd64.deb) ...
dpkg: 处理 /var/cache/apt/archives/libgdm_3.8.3-2_amd64.deb (--unpack) 时发生错误:
 试图覆写 '/usr/bin/gdmflexiserver'，也同时在软件包 gdm3 3.4.1-9 内
```

如果你认为文件替换该文件可能不会对系统的稳定性造成重大的风险（通常情况下），你可以使用`--force-overwrite`选项来告诉`dpkg`去忽略这个错误并且覆盖该文件。 		

**软件包移除** 
-r --remove 
remove package ,not complete: all of the configuration files, maintainer scripts, log  files (system logs) and other user data handled by the package remain. 方便重装时使用上次相同的配置文件。

-p --purge 清理干净，completely remove everything associated with a package

```
# dpkg -r debian-cd
(Reading database ... 15915 files and directories currently installed.)
Removing debian-cd (3.1.25) ...
# dpkg -P debian-cd
(Reading database ... 15394 files and directories currently installed.)
Purging configuration files for debian-cd (3.1.25) ...
```

  **查询 `dpkg` 的数据库，并检查 `.deb` 文件**

`--listfiles *软件包*` (或 `-L`) ，列出该软件包安装的文件清单；
`--search *文件*` (或 `-S`)，寻找包括该文件的套性；
`--status *软件包*` (或 `-s`)，显示该软件包的标头；
`--list` (或 `-l`)，显示该系统内软件包清单与安装状态；
`--contents *file.deb*` (或 `-c`)，列出 Debian 指定软件包清单；
`--info *file.deb* ` (或 `-I`)，列出该软件包的标头。 		

由于[各种原因](https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/)，Debian现在默认将一些顶层文件夹作为符号链接安装到`/usr`下面的相应位置。例如，`/bin`、`/sbin`和`/lib`现在是`/usr/bin`、`/usr/sbin`和`/usr/lib`各自的符号链接。 		

> `dpkg`的日志文件  `/var/log/dpkg.log` 

 



# APT

> A "source package" — a package containing the source code of a program 
>
> a "package source" — a repository (website, 
>
> apt need repositoried site ,  `/etc/apt/sources.list` 
> apt会下载各个仓库的 Sourece.xz 之类的软件包目录文件。



`.gz` 表示文件经过`gzip`工具的压缩。`gzip` 是一个经典的 Unix 命令，用于快速高效压缩文件。

一些新的压缩工具更为有效，但需要更多内存和时间来完成压缩和解压。按照出现的次序，这些工具有：`bzip2` （生成文件名后缀为`.bz2`），`lzma`（生成文件名后缀为`.lzma`）和`xz`（生成文件名后缀为`.xz`）。 

```
/etc/apt/sources.list 给 Debian Stable 使用者的文件

# Security updates
deb http://security.debian.org/ buster/updates main contrib non-free
deb-src http://security.debian.org/ buster/updates main contrib non-free

## Debian mirror

# Base repository
deb https://deb.debian.org/debian buster main contrib non-free
deb-src https://deb.debian.org/debian buster main contrib non-free


```

[china mirror list](https://www.debian.org/mirror/list)

|                              |                                                         |                                                              |
| ---------------------------- | ------------------------------------------------------- | ------------------------------------------------------------ |
| ftp2.cn.debian.org           | [/debian/](http://ftp2.cn.debian.org/debian/)           | amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| ftp.cn.debian.org            | [/debian/](http://ftp.cn.debian.org/debian/)            | amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| mirror.lzu.edu.cn            | [/debian/](http://mirror.lzu.edu.cn/debian/)            | ALL amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| mirrors.163.com              | [/debian/](http://mirrors.163.com/debian/)              | amd64 i386                                                   |
| mirrors.bfsu.edu.cn          | [/debian/](http://mirrors.bfsu.edu.cn/debian/)          | ALL amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| mirrors.huaweicloud.com      | [/debian/](http://mirrors.huaweicloud.com/debian/)      | ALL amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| mirrors.tuna.tsinghua.edu.cn | [/debian/](http://mirrors.tuna.tsinghua.edu.cn/debian/) | amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |
| mirrors.ustc.edu.cn          | [/debian/](http://mirrors.ustc.edu.cn/debian/)          | amd64 arm64 armel armhf i386 mips mips64el mipsel ppc64el s390x |

sodu apt-get update -y

 

apt apt-get  aptitude(图形应用)

```
$ sudo apt -o "Acquire::PDiffs=false" update
Acquire::Languages可以限制或禁止下载Translation-language-code文件，并节省更多时间

 apt install package
 apt remove package 
 apt purge package
 
 
```

 

在几台电脑上安装同一批软件包会很实用。这很容易做到。 
从已经安装过的电脑中取得所安装软件包的列表作为用于复制的“模板”	

当一整个网络的机器被配置为使用同样的远程服务器并下载同样的更新包时，管理员可以配置一个当作网络-本地间缓存器的中介代理。

apt-cacher与apt-cacher-ng的工作方式类似代理缓存服务器。对于外部请求，APT 的`sources.list` 保持不变，但是 APT 被配置为把它们作为代理使用。 		

```
/etc/approx/approx.conf
# Sample sources.list pointing to a local approx server
deb http://localhost:9999/security buster/updates main contrib non-free
deb http://localhost:9999/debian buster main contrib non-free
```



[6.2. `aptitude`、`apt-get`和 `apt` 命令](https://debian-handbook.info/browse/zh-CN/stable/sect.apt-get.html)


