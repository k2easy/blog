# [《pro git》](https://git-scm.com/book/zh/v2)

# 初次配置

每台计算机上只需要配置一次，程序升级时会保留配置信息
git config

1. `/etc/gitconfig` 文件: 包含系统上每一个用户及他们仓库的通用配置。 如果在执行 `git config` 时带上 `--system` 选项，那么它就会读写该文件中的配置变量。 （由于它是系统配置文件，因此你需要管理员或超级用户权限来修改它。）
2. `~/.gitconfig` 或 `~/.config/git/config` 文件：只针对当前用户。 你可以传递 `--global` 选项让 Git 读写此文件，这会对你系统上 **所有** 的仓库生效。
3. 当前使用仓库的 Git 目录中的 `config` 文件（即 `.git/config`）：针对该仓库。 你可以传递 `--local` 选项让 Git 强制读写此文件，虽然默认情况下用的就是它。。 （当然，你需要进入某个 Git 仓库中才能让该选项生效。）

每一个级别会覆盖上一级别的配置，所以 `.git/config` 的配置变量会覆盖 `/etc/gitconfig` 中的配置变量。

```shell
$ git config --list --show-origin
```

安装完 Git 之后，要做的第一件事就是设置你的用户名和邮件地址。 这一点很重要，因为每一个 Git 提交都会使用这些信息，它们会写入到你的每一次提交中，不可更改：

```console
$ git config --global user.name "John Doe"
$ git config --global user.email johndoe@example.com
```

 

```
# demo @ demos-MacBook-Pro in /usr/local [7:32:50]
$ cat etc/gitconfig
[credential]
	helper = osxkeychain

# demo @ demos-MacBook-Pro in /usr/local [7:33:17]
$ cat ~/.gitconfig
[user]
	email = liujw.vip@outlook.com
	name = k2easy
[core]
	editor = code --wait
	

```

git config  显示 credential.helper=osxkeychain

在github.com或者gitlab上面新建仓库，并克隆到本地，首次使用的时候，会被问及用户名密码，

默认情况下你为什么没有被要求每次都输入用户名密码？

Mac系统，git默认是提供`osxkeychain`辅助程序来管理你的密码，以至于每次你当你需要提供用户名和密码的时候，`osxkeychain`辅助程序都默默帮你填写了。

也可以取消 credential

```
git config --local --unset credential.helper
git config --global --unset credential.helper
git config --system --unset credential.helper
```

当 Git 需要你输入信息时会调用它。 如果未配置，Git 会使用操作系统默认的文本编辑器。
配置vscode作为git默认编辑器，

```
$ code --help  //code已经加入环境变量
git config --global core.editor "code --wait"
git config --global -e //edit ,vscode打开.gitconfig文件
```

```console
$ git config --list
```

<!--检查 Git 的某一项配置-->

```
git config <key> 
```

 $ git help <verb>

# Git基础

## 获取 Git 仓库

```console
$ cd /Users/user/my_project
$ git init
$ git add *.c
$ git add LICENSE  // add 把该文件当前版本添加到暂存区 
$ git commit -m 'initial project version' //commit 提交到仓库
```

```console
$ git clone https://github.com/libgit2/libgit2
```

会在当前目录下创建一个名为 “libgit2” 的目录，并在这个目录下初始化一个 `.git` 文件夹， 从远程仓库拉取下所有数据放入 `.git` 文件夹，然后从中读取最新版本的文件的拷贝。

Git 支持多种数据传输协议。  `https://` 协议， git://` 协议  SSH 传输协议 `user@server:path/to/repo.git` 

```console
$ git clone https://github.com/libgit2/libgit2 mylibgit
```

指定新的目录名称

## 记录每次更新到仓库

工作目录下的文件状态：未跟踪、已跟踪（未修改、已修改、已放入暂存区）

 <img src="/Users/demo/Library/Application Support/typora-user-images/image-20200709071544624.png" alt="image-20200709071544624" style="zoom:50%;" />

```
git status 检查当前文件状态
git status -s  简洁描述 --short
```

```console
$ git status -s
 M README
MM Rakefile
A  lib/git.rb
M  lib/simplegit.rb
?? LICENSE.txt
```

新添加的未跟踪文件前面有 `??` 标记，新添加到暂存区中的文件前面有 `A` 标记，修改过的文件前面有 `M` 标记。

`Rakefile` 文件已修，暂存后又作了修改，因此该文件的修改中既有已暂存的部分，又有未暂存的部分

### 忽略文件

文件 `.gitignore` 的格式规范如下：

- 所有空行或者以 `#` 开头的行都会被 Git 忽略。
- 可以使用标准的 glob 模式匹配，它会递归地应用在整个工作区中。
- 匹配模式可以以（`/`）开头防止递归。
- 匹配模式可以以（`/`）结尾指定目录。
- 要忽略指定模式以外的文件或目录，可以在模式前加上叹号（`!`）取反。

glob 模式是指 shell 所使用的简化了的正则表达式。 星号（`*`）匹配零个或多个任意字符；`[abc]` 匹配任何一个列在方括号中的字符，问号（`?`）只匹配一个任意字符；`[0-9]` 表示匹配所有 0 到 9 的数字。两个星号（`**`）表示匹配任意中间目录，比如 `a/**/z` 可以匹配 `a/z` 、 `a/b/z` 

```
# 忽略所有的 .a 文件
*.a

# 但跟踪所有的 lib.a，即便你在前面忽略了 .a 文件
!lib.a

# 只忽略当前目录下的 TODO 文件，而不忽略 subdir/TODO
/TODO

# 忽略任何目录下名为 build 的文件夹
build/

# 忽略 doc/notes.txt，但不忽略 doc/server/arch.txt
doc/*.txt

# 忽略 doc/ 目录及其所有子目录下的 .pdf 文件
doc/**/*.pdf
```

多种开发语言的示例，https://github.com/github/gitignore

在最简单的情况下，一个仓库可能只根目录下有一个 `.gitignore` 文件，它递归地应用到整个仓库中。 然而，子目录下也可以有额外的 `.gitignore` 文件。子目录中的 `.gitignore` 文件中的规则只作用于它所在的目录中。

### 查看已暂存和未暂存的修改

想知道具体修改了什么地方，可以用 `git diff` 命令

查看尚未暂存的文件更新了哪些部分，不加参数直接输入 `git diff`：
$ git diff 

查看已经暂存起来的变化 `--staged` 和 `--cached` 是同义词
$ git diff --cached 

请注意，git diff 本身只显示尚未暂存的改动，而不是自上次提交以来所做的所有改动。 所以有时候你一下子暂存了所有更新过的文件，运行 `git diff` 后却什么也没有，就是这个原因。

### 提交更新

```console
$ git commit
```

这样会启动你选择的文本编辑器来输入提交说明。

启动的编辑器是通过 Shell 的环境变量 `EDITOR` 指定的，一般为 vim ，使用 `git config --global core.editor` 命令设置你喜欢的编辑器。

```console
$ git commit -m "Story 182: Fix benchmarks for speed"
```

提交时记录的是放在暂存区域的快照。 任何还未暂存文件的仍然保持已修改状态，可以在下次提交时纳入版本管理。 每一次运行提交操作，都是对你项目作一次快照，以后可以回到这个状态，或者进行比较。

### 跳过使用暂存区域

尽管使用暂存区域的方式可以精心准备要提交的细节，但有时候这么做略显繁琐。 Git 提供了一个跳过使用暂存区域的方式， 只要在提交的时候，给 `git commit` 加上 `-a` 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 `git add` 步骤。

### 移除文件

要从 Git 中移除某个文件，就必须要**从已跟踪文件清单中移除**（确切地说，是从暂存区域移除），然后提交。 可以用 `git rm` 命令完成此项工作，并连带从工作目录中删除指定的文件，这样以后就不会出现在未跟踪文件清单中了。下一次提交时，该文件就不再纳入版本管理了。

如果要删除之前修改过或已经放到暂存区的文件，则必须使用强制删除选项 `-f`（ force）。 这是一种安全特性，用于防止误删尚未添加到快照的数据，这样的数据不能被 Git 恢复。

另一种情况，想把文件从 Git 仓库中删除（亦即从暂存区域移除），但仍然希望保留在当前工作目录中。想让文件保留在磁盘，但是并不想让 Git 继续跟踪。 当你忘记添加 `.gitignore` 文件，不小心把一个很大的日志文件或一堆 `.a` 这样的编译生成文件添加到暂存区时，这一做法尤其有用。

```console
$ git rm --cached README
```

`git rm` 命令后面可以列出文件或者目录的名字，也可以使用 `glob` 模式。

```
$ git rm log/\*.log
```

星号 `*` 之前的反斜杠 `\`， 因为 Git 有它自己的文件模式扩展匹配方式，所以我们不用 shell 来帮忙展开

### 移动文件

```console
$ git mv file_from file_to
```

运行 `git mv` 就相当于运行了下面三条命令：

```console
$ mv README.md README
$ git rm README.md
$ git add README
```

## 查看提交历史

$ git log    默认时间排序
$ git log -p -2 # --patch 补丁，显示每次提交的变化 -2只显示最近的两次提交 

$ git log --stat  显示每次提交的文件统计信息

$ git log --pretty=oneline // short full fuller    
$ git log --pretty=format:"%h - %an , %ar : %s"

| 选项 | 说明                                                         |
| ---- | ------------------------------------------------------------ |
| %H   | 提交的完整哈希值                                             |
| %h   | 提交的简写哈希值 hash                                        |
| %an  | 作者名称 author name                                         |
| %ar  | 作者的修订日期，按多久以前的方式显示  author relative相对日期 |
| %s   | 提交说明 summary                                             |

当 `oneline` 或 `format` 与另一个 `log` 选项 `--graph` 结合使用时尤其有用。 这个选项添加了一些 ASCII 字符串来形象地展示你的分支、合并历史：
$ git log --pretty=format:"%h %s" --graph

 `-<n>`  表示仅显示最近的 `n` 条提交。 不过实践中这个选项不是很常用，因为 Git 默认会将所有的输出传送到分页程序中，所以你一次只会看到一页的内容。
通常使用  `--since` ， `--until`做时间限制
$ git log --since=2.weeks    // “2020-01-01”  

| `-<n>`                | 仅显示最近的 n 条提交。                        |
| --------------------- | ---------------------------------------------- |
| `--since`, `--after`  | 仅显示指定时间之后的提交。                     |
| `--until`, `--before` | 仅显示指定时间之前的提交。                     |
| `--author`            | 仅显示**作者**匹配指定字符串的提交。           |
| `--committer`         | 仅显示**提交者**匹配指定字符串的提交。         |
| `--grep`              | 仅显示**提交说明**中包含指定字符串的提交。     |
| `-S`                  | 仅显**示添加或删除内容**匹配指定字符串的提交。 |

如果只关心某些文件或者目录的历史提交，可以在 git log 选项的最后指定它们的路径。 因为是放在最后位置上的选项，所以用两个短划线（--）隔开之前的选项和后面限定的路径名。

-S 过滤器， $ git log -S function_name

```console
$ git log --pretty="%h - %s" --author='Junio C Hamano' --since="2008-10-01" \
   --before="2008-11-01" --no-merges -- t/
```



隐藏合并提交
按照你代码仓库的工作流程，记录中可能有为数不少的合并提交，它们所包含的信息通常并不多。 为了避免显示的合并提交弄乱历史记录，可以为 `log` 加上 `--no-merges` 选项。

## 撤消操作

有时候我们提交完了才发现漏掉了几个文件没有添加，或者提交信息写错了。 此时，可以运行带有 `--amend` 选项的提交命令来重新提交：

```console
$ git commit -m 'initial commit'
$ git add forgotten_file
$ git commit --amend
```

这个命令会将暂存区中的文件提交。 如果自上次提交以来你还未做任何修改（例如，在上次提交后马上执行了此命令）， 那么快照会保持不变，第二次提交说明覆盖第一次提交说明。

修补提交最明显的价值是可以稍微改进你最后的提交，而不会让“啊，忘了添加一个文件”或者 “小修补，修正笔误”这种提交信息弄乱你的仓库历史。

### 取消暂存的文件

例如，你已经修改了两个文件并且想要将它们作为两次独立的修改提交， 但是却意外地输入 `git add *` 暂存了它们两个。如何只取消暂存两个中的一个呢？

使用 `git reset HEAD <file>...` 来取消暂存

```console
$ git reset HEAD CONTRIBUTING.md
```

### 撤消对文件的修改

如果你并不想保留对 `CONTRIBUTING.md` 文件的修改怎么办？ 你该如何方便地撤消修改——将它还原成上次提交时的样子（或者刚克隆完的样子）？

```console
$ git checkout -- CONTRIBUTING.md
```

 `git checkout -- <file>` 是一个危险的命令。 你对那个文件在本地的任何修改都会消失——Git 会用最近提交的版本覆盖掉它。 

在 Git 中任何 **已提交** 的东西几乎总是可以恢复的。 甚至那些被删除的分支中的提交或使用 `--amend` 选项覆盖的提交也可以恢复 。 然而，任何你未提交的东西丢失后很可能再也找不到了。

##  远程仓库的使用

远程仓库可以在你的本地主机上

 查看远程仓库

查看你已经配置的远程仓库服务器，可以运行 `git remote` 命令。 它会列出你指定的每一个远程服务器的简写。

 origin  是 Git 给你克隆的仓库服务器的默认名字

```console
$ git clone https://github.com/schacon/ticgit
Cloning into 'ticgit'...
$ cd ticgit
$ git remote
origin

$ git remote -v   // -v 显示对应的URL
origin	https://github.com/schacon/ticgit (fetch)
origin	https://github.com/schacon/ticgit (push)
```

### 添加远程仓库

 `git remote add <shortname> <url>` 添加一个新的远程 Git 仓库，同时指定一个方便使用的简写

```console
$ git remote
origin
$ git remote add pb https://github.com/paulboone/ticgit
$ git remote -v
origin	https://github.com/schacon/ticgit (fetch)
origin	https://github.com/schacon/ticgit (push)
pb	https://github.com/paulboone/ticgit (fetch)
pb	https://github.com/paulboone/ticgit (push)
$ git fetch pb
```

### 从远程仓库中抓取与拉取

```console
$ git fetch <remote>
```

访问远程仓库，从中拉取所有你还没有的数据。 执行完成后，你将会拥有那个远程仓库中所有分支的引用，可以随时合并或查看。 

如果你使用 `clone` 命令克隆了一个仓库，命令会自动将其添加为远程仓库并默认以 “origin” 为简写。 

所以，`git fetch origin` 会抓取克隆（或上一次抓取）后新推送的所有工作。 必须注意 `git fetch` 命令只会将数据下载到你的**本地仓库**——它并不会自动合并或修改你当前的工作。 当准备好时你必须手动将其合并入你的工作。

如果你的当前分支设置了跟踪远程分支 ， 那么可以用 `git pull` 命令来自动抓取后合并该远程分支到当前分支。 这或许是个更加简单舒服的工作流程。默认情况下，**`git clone` 命令会自动设置本地 master 分支跟踪克隆的远程仓库的 `master` 分支**（或其它名字的默认分支）。 运行 `git pull` 通常会从最初克隆的服务器上抓取数据并自动尝试合并到当前所在的分支。

### 推送到远程仓库

```
git push <remote> <branch>
```

```console
$ git push origin master
```

 协同工作时，必须先抓取其他人的工作并将其合并进你的工作后才能推送，否则可能会被拒绝。

### 查看某个远程仓库

查看某一个远程仓库的更多信息，

```
git remote show <remote>
```

### 远程仓库的重命名与移除

```console
$ git remote rename pb paul
```

这同样也会修改你所有远程跟踪的分支名字。 那些过去引用 `pb/master` 的现在会引用 `paul/master`。

```
$ git remote remove paul	
```

一旦你使用这种方式删除了一个远程仓库，那么所有和这个远程仓库相关的远程跟踪分支以及配置信息也会一起被删除。

## 打标签

标记软件发布的版本号

```
$ git tag  //列出标签 
v1.0
v2.0
```

Git 支持两种标签：轻量标签（lightweight）与附注标签（annotated）

附注标签 ，添加个版本注释

```console
$ git tag -a v1.4 -m "my version 1.4"  
$ git show v1.4
tag v1.4
Tagger: Ben Straub <ben@straub.cc>
Date:   Sat May 3 20:19:12 2014 -0700

my version 1.4
```

`-m` 选项指定了一条将会存储在标签中的信息。 如果没有为附注标签指定一条信息，Git 会启动编辑器要求你输入信息。

轻量标签很像一个不会改变的分支——它只是某个特定提交的引用。
轻量标签本质上是和提交校验存储到一个文件中——没有保存任何其他信息。

```console
$ git tag v1.4-lw  // git tab 标签名称
```

### 后期打标签

你也可以对过去的提交打标签

需要在命令的末尾指定提交的校验和（或部分校验和）：

```console
$ git tag -a v1.2 9fceb02
```

### 共享标签

默认情况下，`git push` 命令并不会传送标签到远程仓库服务器上

`git push origin <tagname>`。

如果想要一次性推送很多标签，也可以使用带有 `--tags` 选项的 `git push` 命令。 这将会把所有不在远程仓库服务器上的标签全部传送到那里。

```console
$ git push origin --tags
```

现在，当其他人从仓库中克隆或拉取，他们也能得到你的那些标签。

### 删除标签

删除掉本地仓库上的标签  `git tag -d <tagname>`

删除远程标签的方式是：

```console
$ git push origin --delete <tagname>
```

### 检出标签

如果你想查看某个标签所指向的文件版本，可以使用 `git checkout` 命令， 虽然这会使你的仓库处于“分离头指针（detached HEAD）”的状态——这个状态有些不好的副作用：

```console
$ git checkout 2.0.0
Note: checking out '2.0.0'.

You are in 'detached HEAD' state 。You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.
```

在“分离头指针”状态下，如果你做了某些更改然后提交它们，标签不会发生变化， 但你的新提交将不属于任何分支，并且将无法访问，除非通过确切的提交哈希才能访问。 因此，如果你需要进行更改，比如你要修复旧版本中的错误，那么通常需要创建一个新分支：

```console
$ git checkout -b version2 v2.0.0
Switched to a new branch 'version2'
```

## Git 命令别名缩写

Git 并不会在你输入部分命令时自动推断出你想要的命令。 如果不想每次都输入完整的 Git 命令，可以通过 `git config` 文件来轻松地为每一个命令设置一个别名。 这里有一些例子你可以试试：

```console
$ git config --global alias.co checkout
```

```console
$ git config --global alias.unstage 'reset HEAD --'
```

这会使下面的两个命令等价：

```console
$ git unstage fileA
$ git reset HEAD -- fileA
```

Git 只是简单地将别名替换为对应的命令。

# Git 分支

## 分支简介

使用分支意味着你可以把你的工作从开发主线上分离开来，以免影响开发主线。 在很多版本控制系统中，这是一个略微低效的过程——常常需要完全创建一个源代码目录的副本。对于大项目来说，这样的过程会耗费很多时间。

有人把 Git 的分支模型称为它的“必杀技特性”，也正因为这一特性，使得 Git 从众多版本控制系统中脱颖而出。

Git 鼓励在工作流程中频繁地使用分支与合并，哪怕一天之内进行许多次。 理解和精通这一特性，你便会意识到 Git 是如此的强大而又独特，并且从此真正改变你的开发方式。

blob,二进制大型对象 (Binary large object),在数据库管理系统中，将二进制数据存储为一个单一个体的集合。Blob通常是影像、声音或多媒体文件

checkout 检出



Git 保存的不是文件的变化或者差异，而是一系列不同时刻的 **快照** 。

暂存操作会为暂存区的每一个文件计算校验和，然后会把当前版本的文件快照保存到 Git 仓库中 （Git 使用 *blob* 对象来保存它们），最终将校验和加入到暂存区域等待提交：

在进行提交操作时，Git 会保存一个提交对象（commit object），该提交对象会包含一个指向暂存内容快照的指针，以及作者的姓名和邮箱、提交时输入的信息以及指向它的父对象的指针。还会创建一个树对象，Git 会先计算每一个子目录（所有文件）的校验和， 然后在 Git 仓库中这些校验和保存为树对象。提交对象中还包含指向这个树对象的指针。
//方便切换工作目录到不通的提交节点

*blob* 对象（保存着文件快照）、 **树** 对象 （记录着目录结构和 blob 对象索引）、 **提交** 对象（包含着指向前述树对象的指针和所有提交信息）。

![首次提交对象及其树结构。](https://git-scm.com/book/en/v2/images/commit-and-tree.png)



做些修改后再次提交，那么这次产生的提交对象会包含一个指向上次提交对象（父对象）的指针。![提交对象及其父对象。](https://git-scm.com/book/en/v2/images/commits-and-parents.png)

Git 的默认分支名字是 `master`。 在多次提交操作之后，你其实已经有一个指向最后那个提交对象的 `master` 分支。 `master` 分支会在每次提交时**自动向前移动（始终指向最后一个提交节点）。**

Git 的 `master` 分支并不是一个特殊分支。 它就跟其它分支完全没有区别。 之所以几乎每一个仓库都有 master 分支，是因为 `git init` 命令默认创建它，并且大多数人都懒得去改动它。

![分支及其提交历史。](https://git-scm.com/book/en/v2/images/branch-and-history.png)



### 分支创建

```console
$ git branch testing
```

这会在当前所在的提交对象上创建一个指针。

![两个指向相同提交历史的分支。](https://git-scm.com/book/en/v2/images/two-branches.png)

Git  有一个名为 `HEAD` 的特殊指针，始终指向当前所在的本地分支（可以将 `HEAD` 想象为当前分支的别名）。

```console
$ git log --oneline --decorate // 查看各个分支当前所指的对象
```

### 分支切换

```console
$ git checkout testing
```

![HEAD 指向当前所在的分支。](https://git-scm.com/book/en/v2/images/head-to-testing.png)

```console
$ vim test.rb
$ git commit -a -m 'made a change'
HEAD 分支随着提交操作自动向前移动，master分支保持在原地。
```

![HEAD 分支随着提交操作自动向前移动。](https://git-scm.com/book/en/v2/images/advance-testing.png)



```console
$ git checkout master
```

![检出时 HEAD 随之移动。](https://git-scm.com/book/en/v2/images/checkout-master.png)

检出时 HEAD 随之移动

这条命令做了两件事。 一是使 HEAD 指回 `master` 分支，二是将工作目录恢复成 `master` 分支所指向的快照内容。 也就是说，你现在做修改的话，项目将始于一个较旧的版本。 本质上来讲，这就是忽略 `testing` 分支所做的修改，以便于向另一个方向进行开发。

分支切换会改变你工作目录中的文件

在切换分支时，一定要注意你工作目录里的文件会被改变。 如果是切换到一个较旧的分支，你的工作目录会恢复到该分支最后一次提交时的样子。 如果 Git 不能干净利落地完成这个任务，它将禁止切换分支。

工作目录和暂存区里那些还没有被提交的修改， 它可能会和你即将检出的分支产生冲突从而阻止 Git 切换到该分支，使用暂存（stashing） 和 修补提交（commit amending），详解 [贮藏与清理](https://git-scm.com/book/zh/v2/ch00/_git_stashing) 



```console
$ vim test.rb
$ git commit -a -m 'made other changes'
```

![项目分叉历史。](https://git-scm.com/book/en/v2/images/advance-master.png)

```console
$ git log --oneline --decorate --graph --all
* c2b9e (HEAD, master) made other changes
| * 87ab2 (testing) made a change
|/
```

Git 的分支实质上仅是包含所指对象校验和（长度为 40 的 SHA-1 值字符串）的文件，所以它的创建和销毁都异常高效。 创建一个新分支就相当于往一个文件中写入 41 个字节（40 个字符和 1 个换行符），

 Git 中，任何规模的项目都能在瞬间创建新分支。 同时，由于每次提交都会记录父对象，所以寻找恰当的合并基础（译注：即共同祖先）也是同样的简单和高效。 这些高效的特性使得 Git 鼓励开发人员频繁地创建和使用分支。



```
git checkout -b <newbranchname>
创建新分支的同时切换过去
```

## 分支的新建与合并

假设你已经修正了 #53 问题，并且打算将你的工作合并入 `master` 分支。 为此，你需要合并 `iss53` 分支到 `master` 分支

```console
$ git checkout master
$ git merge hotfix
Updating f42c576..3a0874c
Fast-forward
 index.html | 2 ++
 1 file changed, 2 insertions(+)
```

“快进（fast-forward）”这个词。 由于你想要合并的分支 `hotfix` 所指向的提交 `C4` 是你所在的提交 `C2` 的直接后继， 因此 Git 会直接将指针向前移动。这种情况下的合并操作没有需要解决的分歧——这就叫做 “快进（fast-forward）”。

![基于 `master` 分支的紧急问题分支（hotfix branch）。](https://git-scm.com/book/en/v2/images/basic-branching-4.png)

![`master` 被快进到 `hotfix`。](https://git-scm.com/book/en/v2/images/basic-branching-5.png)

继续在 `iss53` 分支上的工作

你在 `hotfix` 分支上所做的工作并没有包含到 `iss53` 分支中。 如果你需要拉取 `hotfix` 所做的修改，你可以使用 `git merge master` 命令将 `master` 分支合并入 `iss53` 分支，或者你也可以等到 `iss53` 分支完成其使命，再将其合并回 `master` 分支。

### 分支的合并

![一次典型合并中所用到的三个快照。](https://git-scm.com/book/en/v2/images/basic-merging-1.png)

因为，`master` 分支所在提交并不是 `iss53` 分支所在提交的直接祖先，Git 不得不做一些额外的工作。 出现这种情况的时候，Git 会使用两个分支的末端所指的快照（`C4` 和 `C5`）以及这两个分支的公共祖先（`C2`），做一个简单的三方合并。

和之前将分支指针向前推进所不同的是，Git 将此次三方合并的结果做了一个新的快照并且自动创建一个新的提交指向它。 这个被称作一次合并提交，它的特别之处在于他有不止一个父提交。![一个合并提交。](https://git-scm.com/book/en/v2/images/basic-merging-2.png)

既然你的修改已经合并进来了，就不再需要 `iss53` 分支了。 现在你可以在任务追踪系统中关闭此项任务，并删除这个分支。

```console
$ git branch -d iss53
```

### 遇到冲突时的分支合并

如果你在两个不同的分支中，对同一个文件的同一个部分进行了不同的修改，Git 就没法干净的合并它们。

在合并它们的时候就会产生合并冲突：

```console
$ git merge iss53
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

此时 Git 做了合并，但是没有自动地创建一个新的合并提交。 **Git 会暂停下来，等待你去解决合并产生的冲突。** 你可以在合并冲突后的任意时刻使用 `git status` 命令来查看那些因包含合并冲突而处于未合并（unmerged）状态的文件：

```console
$ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")

Unmerged paths:
  (use "git add <file>..." to mark resolution)

    both modified:      index.html

no changes added to commit (use "git add" and/or "git commit -a")
```

含合并冲突而有待解决的文件，都会以未合并状态标识出来。 Git 会在有冲突的文件中加入标准的冲突解决标记，这样你可以打开这些包含冲突的文件然后手动解决冲突。

```html
<<<<<<< HEAD:index.html
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
 please contact us at support@github.com
</div>
>>>>>>> iss53:index.html
```

`HEAD` 所指示的版本`=======` 的上半部分 与  `iss53` 分支所指示的版本在 `=======` 的下半部分 存在冲突。

```
<div id="footer">
please contact us at email.support@github.com
</div>
```

解决冲突后 ，对每个文件使用 `git add` 命令来将其标记为冲突已解决。 一旦暂存这些原本有冲突的文件，Git 就会将它们标记为冲突已解决。 `git commit` 来完成合并提交

## 分支管理

```console
$ git branch // 当前所有分支的一个列表
  iss53
* master
  testing
```

 `*` 字符：它代表现在检出的那一个分支（也就是说，当前 `HEAD` 指针所指向的分支）

```console
$ git branch -v   // 查看每一个分支的最后一次提交
```

`--merged` 与 `--no-merged` 这两个有用的选项可以过滤这个列表中已经合并或尚未合并到**当前分支**的分支。

```console
$ git branch --merged
  iss53
* master
```

因为之前已经合并了 `iss53` 分支，所以现在看到它在列表中。 在这个列表中分支名字前没有 `*` 号的分支通常可以使用 `git branch -d` 删除掉；你已经将它们的工作整合到了另一个分支，所以并不会失去任何东西。

查看所有包含未合并工作的分支 

```console
$ git branch --no-merged
  testing
```

这里显示了其他分支。 因为它包含了还未合并的工作，尝试使用 `git branch -d` 命令删除它时会失败：

如果真的想要删除分支并丢掉那些工作，可以使用 `-D` 选项强制删除它。

可以提供一个附加的参数来查看其它分支的合并状态而不必检出它们。 例如，尚未合并到 `master` 分支的有哪些？

```console
$ git checkout testing
$ git branch --no-merged master
```

## 分支开发工作流

### 长期分支

因为 Git 使用简单的三方合并，所以就算在一段较长的时间内，反复把一个分支合并入另一个分支，也不是什么难事。

只在 `master` 分支上保留完全稳定的代码——有可能仅仅是已经发布或即将发布的代码。

还有一些名为 `develop` 或者 `next` 的平行分支，被用来做后续开发或者测试稳定性——这些分支不必保持绝对稳定，但是一旦达到稳定状态，它们就可以被合并入 `master` 分支了。

![趋于稳定分支的线性图。](https://git-scm.com/book/en/v2/images/lr-branches-1.png)

通常把他们想象成流水线（work silos）可能更好理解一点，那些经过测试考验的提交会被遴选到更加稳定的流水线上去。

![趋于稳定分支的工作流（“silo”）视图。](https://git-scm.com/book/en/v2/images/lr-branches-2.png)

比较适合在一个非常庞大或者复杂的项目。

### 主题分支

svn只有一个联网版本库，本地没有办法做版本管理，分支更灵活适合做一些功能点测试开发，不想要的话方便删除，比svn灵活。

主题分支是一种短期分支，它被用来实现单一特性或其相关工作

主题分支（`iss53` 和 `hotfix` 分支）中提交了一些更新，并且在它们合并入主干分支之后，你又删除了它们。 这项技术能使你快速并且完整地进行上下文切换（context-switch）——因为你的工作被分散到不同的流水线中，在不同的流水线中每个分支都仅与其目标特性相关，因此，在做代码审查之类的工作的时候就能更加容易地看出你做了哪些改动。 你可以把做出的改动在主题分支中保留几分钟、几天甚至几个月，等它们成熟之后再合并，而不用在乎它们建立的顺序或工作进度。

例子，你在 `master` 分支上工作到 `C1`，这时为了解决一个问题而新建 `iss91` 分支，在 `iss91` 分支上工作到 `C4`，然而对于那个问题你又有了新的想法，于是你再新建一个 `iss91v2` 分支试图用另一种方法解决那个问题，接着你回到 `master` 分支工作了一会儿，你又冒出了一个不太确定的想法，你便在 `C10` 的时候新建一个 `dumbidea` 分支，并在上面做些实验。 你的提交历史看起来像下面这个样子：

![拥有多个主题分支的提交历史。](https://git-scm.com/book/en/v2/images/topic-branches-1.png)

你将 `dumbidea` 分支拿给你的同事看过之后，结果发现这是个惊人之举。 这时你可以抛弃 `iss91` 分支（即丢弃 `C5` 和 `C6` 提交），然后把另外两个分支合并入主干分支。 最终你的提交历史看起来像下面这个样子：

![https://git-scm.com/book/en/v2/images/topic-branches-2.png](https://git-scm.com/book/en/v2/images/topic-branches-2.png)

## 远程分支

远程引用是对远程仓库的引用（指针），包括分支、标签等等。 你可以通过 `git ls-remote <remote>` 来显式地获得远程引用的完整列表， 或者通过 `git remote show <remote>` 获得远程分支的更多信息。一个更常见的做法是利用远程跟踪分支。

克隆之后的服务器与本地仓库

![克隆之后的服务器与本地仓库。](https://git-scm.com/book/en/v2/images/remote-branches-1.png)

本地与远程的工作可以分叉

其他人推送提交到 `git.ourcompany.com` 并且更新了它的 `master` 分支，这就是说你们的提交历史已走向不同的方向。 即便这样，只要你保持不与 `origin` 服务器连接（并拉取数据），你的 `origin/master` 指针就不会移动。

![本地与远程的工作可以分叉。](https://git-scm.com/book/en/v2/images/remote-branches-2.png)

如果要与给定的远程仓库同步数据，运行 `git fetch <remote>` 命令（在本例中为 `git fetch origin`）。 这个命令查找 “origin” 是哪一个服务器（在本例中，它是 `git.ourcompany.com`）， 从中抓取本地没有的数据，并且更新本地数据库，移动 `origin/master` 指针到更新之后的位置。

![`git fetch` 更新你的远程仓库引用。](https://git-scm.com/book/en/v2/images/remote-branches-3.png)

### 推送

本地的分支并不会自动与远程仓库同步——你必须显式地推送想要分享的分支。

```console
$ git push origin serverfix
```

Git 自动将 `serverfix` 分支名字展开为 `refs/heads/serverfix:refs/heads/serverfix`， 那意味着，“推送本地的 `serverfix` 分支来更新远程仓库上的 `serverfix` 分支。”

如果并不想让远程仓库上的分支叫做 `serverfix`，可以运行 `git push origin serverfix:awesomebranch` 来将本地的 `serverfix` 分支推送到远程仓库上的 `awesomebranch` 分支。



下一次其他协作者从服务器上抓取数据时，他们会在本地生成一个远程分支 `origin/serverfix`，指向服务器的 `serverfix` 分支的引用：

```console
$ git fetch origin
```

当抓取到新的远程跟踪分支时，本地不会自动生成一份可编辑的副本（拷贝）。 换一句话说，这种情况下，不会有一个新的 `serverfix` 分支——只有一个不可以修改的 `origin/serverfix` 指针。

可以运行 `git merge origin/serverfix` 将这些工作合并到当前所在的分支



如果想要在自己的 `serverfix` 分支上工作，可以将其建立在远程跟踪分支之上：

```console
$ git checkout -b serverfix origin/serverfix  //建立跟踪分支
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

这会给你一个用于工作的本地分支，并且起点位于 `origin/serverfix`。



### 如何避免每次输入密码

如果你正在使用 HTTPS URL 来推送，Git 服务器会询问用户名与密码。 默认情况下它会在终端中提示服务器是否允许你进行推送。

如果不想在每一次推送时都输入用户名与密码，你可以设置一个 “credential cache”。 最简单的方式就是将其保存在内存中几分钟，可以简单地运行 `git config --global credential.helper cache` 来设置它。



### 跟踪分支

从一个远程跟踪分支检出一个本地分支会自动创建所谓的“跟踪分支”（它跟踪的分支叫做“上游分支”）。 跟踪分支是与远程分支有直接关系的本地分支。

如果在一个跟踪分支上输入 `git pull`，Git 能自动地识别去哪个服务器上抓取、合并到哪个分支。

当克隆一个仓库时，它通常会自动地创建一个跟踪 `origin/master` 的 `master` 分支。

创建其他跟踪分支
 `git checkout -b <branch> <remote>/<branch>` 或 使用 `--track` 快捷方式，例如：
$ git checkout --track origin/serverfix

由于这个操作太常用了，该捷径本身还有一个捷径。 如果你尝试检出的分支 (a) 不存在且 (b) 刚好只有一个名字与之匹配的远程分支，那么 Git 就会为你创建一个跟踪分支：

```console
$ git checkout serverfix
Branch serverfix set up to track remote branch serverfix from origin.
Switched to a new branch 'serverfix'
```

设置已有的本地分支跟踪一个刚刚拉取下来的远程分支，或者想要修改正在跟踪的上游分支，使用 `-u` 或 `--set-upstream-to` 选项

```console
$ git branch -u origin/serverfix
Branch serverfix set up to track remote branch serverfix from origin.
```

```console
$ git branch -vv
```

将所有的本地分支列出来并且包含更多的信息，如每一个分支正在跟踪哪个远程分支与本地分支是否是领先、落后或是都有 

```console
$ git fetch --all; git branch -vv
  iss53     7e424c3 [origin/iss53: ahead 2] forgot the brackets
  master    1ae2a45 [origin/master] deploying index fix
* serverfix f8674d9 [teamone/server-fix-good: ahead 3, behind 1] this should do it
  testing   5ea463a trying something new
```

这里可以看到 `iss53` 分支正在跟踪 `origin/iss53` 并且 “ahead” 是 2，意味着本地有两个提交还没有推送到服务器上。 也能看到 `master` 分支正在跟踪 `origin/master` 分支并且是最新的。 接下来可以看到 `serverfix` 分支正在跟踪 `teamone` 服务器上的 `server-fix-good` 分支并且领先 3 落后 1， 意味着服务器上有一次提交还没有合并入同时本地有三次提交还没有推送。 最后看到 `testing` 分支并没有跟踪任何远程分支。

### 拉取

当 `git fetch` 命令从服务器上抓取本地没有的数据时，它并不会修改工作目录中的内容。 它只会获取数据然后让你自己合并。

```
git pull 命令，类似，git fetch 紧接着一个 git merge 命令。
```

由于 `git pull` 的魔法经常令人困惑所以通常单独显式地使用 `fetch` 与 `merge` 命令会更好一些。

### 删除远程分支

如果已经完成了一个特性， 并且将其合并到了远程仓库的 `master` 分支（或任何其他稳定代码分支）。 可以运行带有 `--delete` 选项的 `git push` 命令来删除一个远程分支。

```console
$ git push origin --delete serverfix
To https://github.com/schacon/simplegit
 - [deleted]         serverfix
```

这个命令做的只是从服务器上移除这个指针。 Git 服务器通常会保留数据一段时间直到垃圾回收运行，所以如果不小心删除掉了，通常是很容易恢复的。



## 变基 rebase

在 Git 中整合来自不同分支的修改主要有两种方法：`merge` 以及 `rebase`。

### merge

![分叉的提交历史。](https://git-scm.com/book/en/v2/images/basic-rebase-1.png)



![通过合并操作来整合分叉了的历史。](https://git-scm.com/book/en/v2/images/basic-rebase-2.png)

### rebase

```console
$ git checkout experiment
$ git rebase maste
```

原理是首先找到这两个分支（即当前分支 `experiment`、变基操作的目标基底分支 `master`） 的最近**共同祖先** `C2`，然后对比**当前分支**相对于该祖先的历次提交，提取相应的修改并存为临时文件， 然后将当前分支指向目标基底 `C3`, 最后以此将之前另存为临时文件的修改依序应用。

![将 `C4` 中的修改变基到 `C3` 上。](https://git-scm.com/book/en/v2/images/basic-rebase-3.png)

现在回到 `master` 分支，进行一次**快进合并**。

```console
$ git checkout master
$ git merge experiment
```

![`master` 分支的快进合并。](https://git-scm.com/book/en/v2/images/basic-rebase-4.png)



此时，`C4'` 指向的快照就和 [the merge example](https://git-scm.com/book/zh/v2/ch00/ebasing-merging-example) 中 `C5` 指向的快照一模一样了。 **这两种整合方法的最终结果没有任何区别，但是变基使得提交历史更加整洁。** 你在查看一个经过变基的分支的历史记录时会发现，尽管实际的开发工作是并行的， 但它们看上去就像是串行的一样，提交历史是一条直线没有分叉。

一般我们这样做的目的是为了确保在向远程分支推送时能保持提交历史的整洁——例如向某个其他人维护的项目贡献代码时。 在这种情况下，你首先在自己的分支里进行开发，当开发完成时你需要先将你的代码变基到 `origin/master` 上，然后再向主项目提交修改。 这样的话，该项目的维护者就不再需要进行整合工作，只需要快进合并便可。



总的原则是，只对尚未推送或分享给别人的本地修改执行变基操作清理历史， 从不对已推送至别处的提交执行变基操作。

## 服务器上的 Git

为了使用 Git 协作功能，你还需要有远程的 Git 仓库。 尽管在技术上你可以从个人仓库进行推送（push）和拉取（pull）来修改内容，但不鼓励使用这种方法，因为一不留心就很容易弄混其他人的进度。 此外，你希望你的合作者们即使在你的电脑未联机时亦能存取仓库 — 拥有一个更可靠的公用仓库十分有用。 因此，与他人合作的最佳方法即是建立一个你与合作者们都有权利访问，且可从那里推送和拉取资料的共用仓库。

一个远程仓库通常只是一个裸仓库（bare repository）——即一个没有当前工作目录的仓库。 因为该仓库仅仅作为合作媒介，不需要从磁盘检查快照；存放的只有 Git 的资料。 简单的说，裸仓库就是你工程目录内的 `.git` 子目录内容，不包含其他资料。



### 协议

Git 可以使用四种不同的协议来传输资料：本地协议（Local），HTTP 协议，SSH（Secure Shell）协议及 Git 协议。

#### 本地协议

远程版本库就是同一主机上的另一个目录。常见于团队每一个成员都对一个共享的文件系统（例如一个挂载的 NFS）拥有访问权，

```console
$ git clone file:///srv/git/project.git
```

#### 智能 HTTP 协议

智能 HTTP 的运行方式和 SSH 及 Git 协议类似，只是运行在标准的 HTTP/S 端口上并且可以使用各种 HTTP 验证机制， 这意味着使用起来会比 SSH 协议简单的多，比如可以使用 HTTP 协议的用户名/密码授权，免去设置 SSH 公钥。

智能 HTTP 协议或许已经是最流行的使用 Git 的方式了，它即支持像 `git://` 协议一样设置匿名服务， 也可以像 SSH 协议一样提供传输时的授权和加密。 而且只用一个 URL 就可以都做到，省去了为不同的需求设置不同的 URL。

#### SSH 协议

```console
$ git clone ssh://[user@]server/project.git
$ git clone [user@]server:project.git
```

#### Git 协议

这是包含在 Git 里的一个特殊的守护进程；它监听在一个特定的端口（9418），类似于 SSH 服务，但是访问无需任何授权。缺乏授权机制。

### 在服务器上搭建 Git

...

###  生成 SSH 公钥

许多 Git 服务器都使用 SSH 公钥进行认证
默认情况下，用户的 SSH 密钥存储在其 `~/.ssh` 目录下
一对以 `id_dsa` 或 `id_rsa` 命名的文件，其中一个带有 `.pub` 扩展名。 `.pub` 文件是你的公钥，另一个则是与之对应的私钥。

$ ssh-keygen -o  // 创建

### GitLab

## 分布式 Git

### 分布式工作流程

#### 集成管理者工作流

1. 项目维护者推送到主仓库。
2. 贡献者克隆此仓库，做出修改。
3. 贡献者将数据推送到自己的公开仓库。
4. 贡献者给维护者发送邮件，请求拉取自己的更新。
5. 维护者在自己本地的仓库中，将贡献者的仓库加为远程仓库并合并修改。
6. 维护者将合并后的修改推送到主仓库。

![集成管理者工作流。](https://git-scm.com/book/en/v2/images/integration-manager.png)

#### 主管与副主管工作流

一般拥有数百位协作开发者的超大型项目才会用到这样的工作方式，例如著名的 Linux 内核项目。 被称为 **副主管（lieutenant）** 的各个集成管理者分别负责集成项目中的特定部分。 所有这些副主管头上还有一位称为 **主管（dictator）** 的总集成管理者负责统筹。 主管维护的仓库作为参考仓库，为所有协作者提供他们需要拉取的项目代码。

1. 普通开发者在自己的主题分支上工作，并根据 `master` 分支进行变基。 这里是主管推送的参考仓库的 `master` 分支。
2. 副主管将普通开发者的主题分支合并到自己的 `master` 分支中。
3. 主管将所有副主管的 `master` 分支并入自己的 `master` 分支中。
4. 最后，主管将集成后的 `master` 分支推送到参考仓库中，以便所有其他开发者以此为基础进行变基。

![主管与副主管工作流。](https://git-scm.com/book/en/v2/images/benevolent-dictator.png)



## 向一个项目贡献

### 提交准则

你的提交不应该包含任何空白错误。`git diff --check`，它将会找到可能的空白错误并将它们为你列出来。

尝试让每一个提交成为一个逻辑上的独立变更集。

尝试让改动可以理解——不要在整个周末编码解决五个问题，然后在周一时将它们提交为一个巨大的提交。 即使在周末期间你无法提交，在周一时使用暂存区域将你的工作最少拆分为每个问题一个提交，并且为每一个提交附带一个有用的信息。

如果其中一些改动修改了同一个文件，尝试使用 `git add --patch` 来部分暂存文件。

不管你做一个或五个提交，只要所有的改动是在同一时刻添加的，项目分支末端的快照就是独立的，使同事开发者必须审查你的改动时尽量让事情容易些。

有一个创建优质提交信息的习惯会使 Git 的使用与协作容易的多。 一般情况下，信息应当以少于 50 个字符（25个汉字）的单行开始且简要地描述变更，接着是一个空白行，再接着是一个更详细的解释。

使用指令式的语气来编写提交信息，比如使用“Fix bug”而非“Fixed bug”或“Fixes bug”。 模版：首字母大写的摘要（不多于 50 个字符）

#### 小型团队

John 会推送失败，因为之前 Jessica 已经推送了她的更改，尽管 Subversion 会对编辑的不同文件在服务器上自动进行一次合并，但 Git 要求你先在本地合并提交。 换言之，John 必须先抓取 Jessica 的上游改动并将它们合并到自己的本地仓库中，才能被允许推送。

###  协作 带需阅读

...

## GitHub

创建账户
Account settings > Add an SSH key > ~/.ssh/id_rsa.pub 公钥文件的内容粘贴到文本区

GitHub 使用用户邮件地址区分 Git 提交。 如果你在自己的提交中使用了多个邮件地址，希望 GitHub 可以正确地将它们连接起来， 你需要在管理页面的 Emails 部分添加你拥有的所有邮箱地址。

### 派生项目

如果你想要参与某个项目，但是并没有推送权限，这时可以对这个项目进行“派生（Fork）”。 当你“派生”一个项目时，GitHub 会在你的空间中创建一个完全属于你的项目副本，且你对其具有推送权限。通过这种方式，项目的管理者不再需要忙着把用户添加到贡献者列表并给予他们推送权限。

 流程通常如下：

1. 派生一个项目
2. 从 `master` 分支创建一个新分支
3. 提交一些修改来改进项目
4. 将这个分支推送到 GitHub 上
5. 创建一个拉取请求，create pull request ,这个项目的拥有者将会收到一条包含关改动和拉取请求页面的链接的提醒。
6. 讨论，根据实际情况继续修改
7. 项目的拥有者合并或关闭你的拉取请求
8. 将更新后的 `master` 分支同步到你的派生中

 对拉取请求内的特定一行发表评论

当维护者发表评论后，提交拉取请求的人，以及所有正在关注（Watching）这个版本库的用户都会收到通知。





#### 新建项目

New repository > 添加合作者  ,Settings > Collaborators 



#### 组织账号

GitHub 还提供被称为组织（Organizations）的帐户，被用于开源群组（例如：“perl”或者“rails”），或者公司（例如：“google”或者“twitter”）。

组织使用团队（Teams）来管理成员，团队就是组织中的一组个人账户和版本库，以及团队成员对这些版本库的访问权限。

#### 脚本 GitHub

如何使用 GitHub 钩子系统与 API 接口，使 GitHub 按照我们的设想来工作。

为了整合持续集成服务、BUG 与问题追踪系统、聊天室系统与文档系统。

## [Git 工具](https://git-scm.com/book/zh/v2/Git-工具-选择修订版本)







```shell
$ git push
fatal: The current branch master has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin master



$ git push --set-upstream origin master
git: 'credential-xGJTdvT7Dcz8v5S' is not a git command. See 'git --help'.
To https://gitee.com/archerdudu/hn_jkyldsjpt.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://gitee.com/archerdudu/hn_jkyldsjpt.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.

git pull
From https://gitee.com/archerdudu/hn_jkyldsjpt
 * [new branch]      master     -> origin/master
There is no tracking information for the current branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>

If you wish to set tracking information for this branch you can do so with:

    git branch --set-upstream-to=origin/<branch> master

$ git pull
git: 'credential-xGJTdvT7Dcz8v5S' is not a git command. See 'git --help'.
fatal: refusing to merge unrelated histories


如果你是git pull或者git push报fatal: refusing to merge unrelated histories
同理：
git pull origin master --allow-unrelated-histories
```















