# Debian 管理员手册》

www.debian.org

https://debian-handbook.info/

https://debian-handbook.info/browse/zh-CN/stable/  翻译中

# 安装

**Debian Pure Blends** 为各个行业准备的发行版：游戏 化学工程师。。。

CD = 精简（大概可以这样说？(*´д`)）的镜像
DVD = 附带一大堆可选软件包的镜像
Live CD 从光盘启动的镜像系统 

[debian-10.7.0-amd64-DVD-1.iso.torrent](https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/debian-10.7.0-amd64-DVD-1.iso.torrent)
[debian-10.7.0-amd64-DVD-2.iso.torrent](https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/debian-10.7.0-amd64-DVD-2.iso.torrent)
[debian-10.7.0-amd64-DVD-3.iso.torrent](https://cdimage.debian.org/debian-cd/current/amd64/bt-dvd/debian-10.7.0-amd64-DVD-3.iso.torrent)

The three DVDs contain optional,  rarely used programs. If you want to install exotic programs on a  machine without Internet connection, you'll need all three.

If you want to install debian right now, don't bother, the first DVD is more than enough. 



## 分区

第一种方法是 “都在一个分区”。整个 Linux 系统都存在于单个文件系统下，即根 `/` 文件夹。这个对于个人或单用户系统来说简单也实用。实际上，会建两个分区；第一个是整个系统，第二个是虚拟内存(交换分区)。 			
第二种： /  , /home
第三种： /home`, `/usr`, `/var`,  `/tmp ，适合于服务器和多用户系统
 除了根 (`/`) 和用户 (`/home/`) 分区，还有 应用软件 (`/usr/`)，服务器软件数据 (`/var/`, 和临时文件 (`/tmp/`)。这样分区有几个优势。用户不会因为使用完所有可用硬盘空间而锁定整个服务器 (他们只能用完`/tmp/` 和 `/home/`)。守护进程的数据(尤其是日志)不会再填满系统的其余部分。 			

### 配置包管理 (`apt`)

为了能够安装附加软件， APT 需要配置以便知道到何处寻找 Debian 软件包。这一步是尽可能自动化的。开始会提问是否必须使用软件包的网络源，或者仅仅在 CD-ROM 里寻找所需软件。 		

引导程序是 BIOS 开始的第一个程序。它把 Linux 内核加载进内存然后执行。通常提供给用户一个内核选择菜单去加载引导操作系统。 

在 Debian 安装过程中检测到已经安装的操作系统时，会自动把它加到引导菜单项中，
				默认情况下，GRUB 显示菜单包括了所有已检测到操作系统的 Linux 内核。这就是为什么你要接受安装它到主引导扇区的原因。保存旧的内核的好处在于，当你的新内核不能在硬件上工作良好时，还能用旧内核正常引导系统，所以最好保存最近三个版本的内核。 		

GRUB 是 Debian 的默认引导程序：它能识别大部分的文件系统，因此在每次安装新内核之后无须作更新，这是由于引导时 GRUB 是通过读取配置文件找到新内核的实际位置的。

GRUB 更像是一组始于不同情况的多个引导加载程序。GRUB源软件包之外建立多个二进制软件包反映出：grub-efi-amd64是64位PC以UEFI模式启动，grub-efi-ia32是32位PC以UEFI模式启动，grub-pc是以BIOS模式启动PC*grub-uboot*用于ARM计算机等。

**安全启动**（Secure  Boot）是一种保证只有操作系统发行者确认合法的软件才允许运行的技术。为了实现这个工作，启动顺序的每个单元都确认将要运行的下个软件部分合法。在最深的层次上，UEFI固件嵌入了微软提供的密钥，来检查引导加载程序的签名，确保安全执行。由于获得微软签署的二级制文件是个漫长的过程，Debian决定不直接签署GRUB。取而代之的是使用被称为shim的中间引导加载程序，它几乎从不需要改变，其角色是检查Grub上Debian提供的签名，并执行GRUB。为了在允许安全启动的机器上运行Debian，需要安装shim-signed软件包。 		

Debian10是支持安全启动（Secure Boot）的第一个发行版。此前，必须禁止BIOS或UEFI提供的系统设置屏幕上的安全特性。 		

**首次启动后**

如果你选择”图形桌面环境“，系统将显示 `gdm3` 登录管理器。 	
安装软件。`apt`(从命令行执行) 和 `synaptic` (**系统** → **管理** → **Synaptic 包管理**) 。 		

为了所安装的程序的一致性， Debian 创造了专用于特定用途的 “任务” (邮件服务器，文件服务器，等等)。在安装过程中你已经有机会选择它们了，感谢包管理工具你能够以后再次访问它们，比如 `aptitude` (在不同的部分列出的任务) 和 `synaptic` (通过目录 **编辑** → **任务标记软件包…**) 。 		

Aptitude 是 APT 全屏字符模式的接口。它允许用户以各种方式浏览可用软件包列表







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



