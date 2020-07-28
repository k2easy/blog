# Pro Git

## 起步

##### 直接记录快照，而非差异比较

SVN将它们保存的信息看作是一组基本文件和每个文件随时间逐步累积的差异。

![image-20200302151331925](/Users/demo/Documents/_markdown_images/image-20200302151331925.png)

Git 更像是把数据看作是对小型文件系统的一组快照,提供了许多以此为基础构建的超强工具，而不只是一个简单的 VCS。

![image-20200302151410211](/Users/demo/Documents/_markdown_images/image-20200302151410211.png)

#####  近乎所有操作都是本地执行

Git 中的绝大多数操作都只需要访问本地文件和资源，网络延时开销低。

使用SVN能修改 文件，但不能向数据库提交修改（因为你的本地数据库离线了）

##### Git 保证完整性

Git 中所有数据在存储前都计算校验和，然后以校验和来引用。 这意味着不可能在 Git 不知情时更改任何文件内 容或目录内容。若你在传送过程中丢失信息或损坏 文件，Git 就能发现。

> Git 用以计算校验和的机制叫做 SHA-1 散列（hash，哈希）。 这是一个由 40 个十六进制字符（0-9 和 a-f）组 成的字符串，基于 Git 中文件的内容或目录结构计算出来。如：24b9da6552252987aa493b52f8696cd6d3b00373

##### Git 一般只添加数据

你执行的 Git 操作，几乎只往 Git 数据库中增加数据。同别的 VCS 一样，未提交更新时有可能丢失或弄乱修改的内容；但是一旦你提交快照到 Git 中，就难 以再丢失数据

##### 三种状态

已提交（committed）、已修改（modified）和已暂存（staged）。

> 已提交表示数据已经安全的 保存在本地数据库中。
>
> 已修改表示修改了文件，但还没保存到数据库中。 
>
> 已暂存表示对一个已修改文件的当前 版本做了标记，使之包含在下次提交的快照中。

![image-20200302173104850](/Users/demo/Documents/_markdown_images/image-20200302173104850.png)

> Git 仓库目录是 Git 用来保存项目的元数据和对象数据库的地方。，从其它计算机克隆 仓库时，拷贝的就是这里的数据。
>
> 暂存区域是一个文件，保存了下次将提交的文件列表信息，一般在 Git 仓库目录中。

基本的 Git 工作流程如下：

1. 在工作目录中修改文件。
2. 暂存文件，将文件的快照放入暂存区域。
3. 提交更新，找到暂存区域的文件，将快照永久性存储到 Git 仓库目录。

##### 安装git

```
sudo apt-get install git
```

##### 初次运行git前的配置

每台计算机上只需要配置一次，程序升 级时会保留配置信息。 你可以在任何时候再次通过运行命令来修改它们。

1. /etc/gitconfig 文件: 包含系统上每一个用户及他们仓库的通用配置。 如果使用带有 --system 选项的 git config 时，它会从此文件读写配置变量。

2. ~/.gitconfig 或 ~/.config/git/config 文件：只针对当前用户。 可以传递 --global 选项让 Git 读写此文件。

3. 当前使用仓库的 Git 目录中的 config 文件（就是 .git/config）：针对该仓库。

  每一个级别覆盖上一级别的配置

##### 用户信息

```
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

配置默认文本编辑器了，当 Git 需要你输入信息时会调用它。 如果未配 置，Git 会使用操作系统默认的文本编辑器，通常是 Vim。

$ git config --global core.editor emacs

用 git config --list命令来列出所有 Git 当时能找到的配置。

##### 获取帮助

```
$ git help <verb> 
$ git <verb> --help 
$ man git-<verb>
```

## Git基础

##### 获取 Git 仓库

1、在已存在目录中初始化仓库

```
git init 
git add *.txt
git commit -m 'init project'
```

2、克隆现有的仓库

```
$ git clone [url]
$ git clone https://github.com/libgit2/libgit2
```

是"clone"而不是"checkout"。 这是 Git 区别于其它版本控制系统的一个重要特性，Git 克隆的是该 Git 仓库服务 器上的几乎所有数据，而不是仅仅复制完成你的工作所需要文件。 当你执行 git clone 命令的时候，默认配置 下远程 Git 仓库中的每一个文件的每一个版本都将被拉取下来。

