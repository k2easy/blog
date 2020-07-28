ohmyz.sh

常用的Shell有这么几种 
通过以下命令查看系统有几种shell：
cat /etc/shells
/bin/sh、bash(默认)、csh、zsh


sudo vi /etc/hosts


https://github.com/robbyrussell/oh-my-zsh/wiki

Oh-My-Zsh is a framework for Zsh, the Z shell.
 
Oh My Zsh is a delightful, open source, community-driven framework for managing your Zsh configuration. It comes bundled with thousands of helpful functions, helpers, plugins, themes, and a few things that make you shout “Oh My ZSH!”

《《install zsh
zsh --version //5.3
brew search zsh 
brew info zsh //安装最新版 5.7 
install zsh  //安装
brew install zsh zsh-completions 
vi .zshrc 
# If you come from bash you might have to change your $PATH 
export PATH=$HOME/bin/:/usr/local/bin:$PATH 
zsh --version  //5.7最新安装的版本 

$ zsh --version
zsh 5.7.1 (x86_64-apple-darwin18.2.0)

$ which zsh //准确
/usr/local/bin/zsh

$ whereis zsh //不准确
/bin/zsh

chsh -s /bin/zsh //set as default shell 
echo $SHELL /// usr/bin/zsh or /bin/zsh 

$ $SHELL --version
zsh 5.3 (x86_64-apple-darwin18.0)// 不是最新版
$ /bin/zsh --version
zsh 5.3 (x86_64-apple-darwin18.0)

$  whatis which
which                (1)  - shows the full path of (shell) commands
$  whatis whereis
whereis              (1)  - locate the binary, source, and manual page files for a command
Basically, whereis searches for "possibly useful" files, 【which】 only searches for executables.

chsh -s $(which zsh)
echo $SHELL
 --- install zsh over》》

install oh-my-zsh 
$ sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" 

《------ 安装 tldr
npm search tldr 
no available search source错误，是因为把 .npmrc registry 设置成了淘宝的镜像，将其改为官方的源： https://registry.npmjs.org/即可解决问题。

开发React Native时，通过下面命令将npm设置成淘宝镜像
npm config set registry https://registry.npm.taobao.org
npm config set disturl https://npm.taobao.org/dist

npm configure --help 
npm config list -l  // globalconfig = "/usr/local/etc/npmrc"
vi npmrc 
npm install -g tldr 下载太慢，更换taobao源
npm set registry https://registry.npm.taobao.org # 注册模块镜像
npm set disturl https://npm.taobao.org/dist # node-gyp 编译依赖的 node 源码镜像

tldr sh 
-------------》

cd ;
ls -al | grep zsh 
cd .oh-my-zsh;ls // themes plugins 
code .zshrc
ZSH_THEME=robbyrussell // ZSH_THEME="" 不使用任何主题

安装 zsh-autosuggestions 插件 历史命令自动提示
brew install zsh-autosuggestions
add the following to your .zshrc:
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source .zshrc or start a new terminal session.
输入命令时 右箭头选择
上箭头历史命令 


HTTPie: a CLI, cURL-like tool for humans
HTTPie can be used for testing, debugging, and generally interacting with HTTP servers.

zsh 自动补全 
ls - //tab 补全 

快速跳转
输入 cd 后面加一个减号后，按一次 tab 马上就列出本次登陆后去过的最近几次路径，接着根据下面的提示输入数字按回车就过去了，比如输入：
$ cd -5 <回车>

路径名称缩写

无需输入cd 直接输入路径即可  ..后退1级 ...后退两级

ls *.png查找当前目录下所有 png 文件，ls **/*.png递归查找。

按下 tab 键显示出所有待选项后，再按一次 tab 键，即进入选择模式，进入选择模式后，按 tab或 方向键切向下一个选项，

以前杀进程是ps aux | grep xxx查进程的 PID，然后kill PID。有了 zsh，直接kill xxx然后按下 tab 键即可～

kill emacs
# 按下 tab，变成：
kill 59683


别名
zsh 不仅支持普通 alias，还支持针对文件类型的 alias。我配置的文件类型 alias 如下：

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s php=vi
alias -s py=vi
alias -s rb=vi
alias -s html=vi
alias gcid="git log | head -1 | awk '{print substr(\$2,1,7)}' | pbcopy"
配置完毕之后，在 zsh 下直接输入xxx.rb，将自动用 vi 打开，直接输入xxx.tgz，将直接按照tar -xzvf解压。最后一个gcid将当前 git 项目的第一个 commit 的 id 复制到系统剪切板（pbcopy是 Mac 下的复制到系统剪切板命令，linux 请参考相应的发行版更改），在执行 rebase 的时候特别方便。




git
精简 git 命令，减少输入字符数。参见 Plugin:git。该插件提供的快捷命令比较多，挑几个常用和好记的记忆即可，不必全记。我常用的有gst, ggp, gco, gcm, gcp 等。

brew install autojump 
autojump 是基于cd去过的路径，没用去过的路径无法短写跳转
路径跳转错误可以使用 autojump --purge 来清理错误路径


ccat 是上色的cat，在 cat 的基础上提供了语法高亮。可通过brew install ccat安装。目前已支持ruby, python, javascript, java, c, go。


proxychains 是命令行的科学上网工具。安装brew install proxychains-ng。如图所示，亚马逊 S3 存储服务和 github 并不稳定，有时候需要科学上网才能访问。
# 原命令
brew cask install xxx
# 使用 proxychains
proxychains4 brew cask install xxx
使用 proxychains 需要本地先开启科学上网的工具，比如 VPN/shadowsocks，然后在配置文件中添加相应的配置

在Mac下使用ShadowsocksX-NG及ProxyChains-NG实现终端代理
brew install proxychains-ng
vim /usr/local/etc/proxychains.conf
在 [ProxyList] 下面, 注释掉默认的代理地址和端口,并添加socks代理:
socks5 127.0.0.1 1086
提示: 1086是ShadowSocksX-NG的socks5默认端口
proxychains4 curl google.com
注意: socks,http代理等使用的是TCP或UDP协议, 而ping命令则是ICMP协议, 所以proxychains4对ping命令无效.


