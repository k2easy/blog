

> https://github.com/antony-jr/lenovo-legion5-15arh05-scripts/blob/main/README.md
> 根据此文档描述，openSUSE 已经修复了亮度bug，所以安装 OpenSUSE Tumbleweed 滚动发型版，
> 该版比leap版硬件兼容性更好。
>
> 混合显卡模式下，windows亮度可以影响linxu亮度，先安装 win系统，关闭Y灯 fn+L，升级BIOS

## 安装win10

```
# diskutil list
# diskutil unmountDisk /dev/disk2 弹出U盘
# sudo dd if=/path/to/downloaded.iso of=/dev/rdiskN bs=1m  rDisk ，r代表裸磁盘，写入快
ctrl+T查看进度
或rufus制作启动盘

Microsoft Store 下载 lenovo vantage 更新驱动 BIOS升级

创建个分区给 suseLinux 使用
Windows磁盘管理工具里删除该分区。 注意，是删除分区！而不是格式化。
```

## [SUSUTW 安装](https://zh.opensuse.org/SDB:DVD_%E5%AE%89%E8%A3%85%E6%96%B9%E5%BC%8F)

如果你有一个非常大的磁盘并且你的第一个分区是 Windows 的并超过 125 GB，BIOS 很可能在启动时找不到 openSUSE 的启动加载器，在这种情况下你可以点击引导加载器的章节名，然后勾选 **Write to Master Boot Record**，这会把启动加载器放到您的磁盘的头部。

- 请不要让 windows 和 openSUSE 共享同一个 EFI 分区。
- 创建 root 分区的时候，请选择 openSUSE 官方推荐的 BTRFS 文件系统。

**根目录** 、 **[交换空间（SWAP）](https://zh.opensuse.org/SWAP)** 以及 **EFI(/boot/efi)**

suse安装时自动选择未分配的磁盘进行分区安装

```
agps //user ,k2easy
```

## [入门指南](https://zh.opensuse.org/Portal:%E6%96%B0%E6%89%8B%E6%8C%87%E5%8D%97)

> ZYpp (or libzypp; "Zen / YaST Packages Patches Patterns Products") is a package manager engine that powers Linux applications like YaST, Zypper and the implementation of PackageKit for openSUSE and SUSE Linux Enterprise

```
# zypper ar -f <URL> <别名>

ar	是 addrepo 命令的缩写
-f	命令 zypper 为新添加的源添加 自动刷新 旗标

https://mirrors.opensuse.org/
sudo zypper ar -fcg 'https://opentuna.cn/opensuse/tumbleweed/repo/oss/' 'OPEN-TUNA:TW:OSS'
http://mirror.sjtu.edu.cn/opensuse/tumbleweed/repo/oss/
http://mirrors.163.com/openSUSE/tumbleweed/repo/oss/


sudo zypper ref //手动刷新软件源
sudo zypper dup //更新系统
```

noarch是no architecture的缩写，说明这个包可以在各个不同的cpu上使用