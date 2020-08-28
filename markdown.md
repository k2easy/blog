# Markdown语法
cmd+shift+v 无格式粘贴

```
## 标题2
### 标题3


>这是引用的内容
>>这是引用的内容
>>>这是引用的内容


**加粗**   

*斜体*


---
分割线
换行直接敲回车是不行的，在有些编译器里是不会换行的。解决办法是换行后敲至少两个空格，或敲两个空格后再回车换行。

段落与段落之间需要强制空一行才能分段。

![test](./img/test.png 'title')

-空格+文字来创建无序列表，通过输入数字.空格+文字创建有序列表

表头|表头|表头
-|:-:|-:
内容|内容|内容
内容|内容|内容

第二行分割表头和内容。
文字默认居左
-两边加：表示文字居中
-右边加：表示文字居右


[超链接名](超链接地址 "超链接title")
![图片alt](图片地址 "图片title") 
图片title是图片的标题，当鼠标移到图片上时显示的内容
title可加可不加

```



# typora
F11进入全屏状态
打字机模式，就是在你打字过程中自动滚屏，让你正在编辑的段落始终保持在屏幕正中央
专注模式，只有你当前编辑的段落正常显示，而把其余的上下文都半透明显示，和打字机功能相结合，能让你的眼神始终保持在同一个地方不走神。
可以设置为自动保存

高效的Typora让你双手不用离开键盘
## 快捷键
```
任务列表 -[空格]空格文字
设为标题 ctrl+数字
插入表格 cmd+option+T
生成目录 [TOC]回车
选中一整行 ctrl+L
引用 >空格
加粗 ctrl+B
倾斜 ctrl+I 
下划线 ctrl+U
插入链接 ctrl+K
```

无序列表、有序列表

> 
>
> Ctrl+shift+[、Ctrl+shift+]
>
>  插入连接    ctrl + k
>
>  段落快捷键    ctrl + 0
>
> 高亮显示         ==文字==         ==单恋也是恋爱的一种形式，对方是想象力。==
>
> enter后，没有出现序号了，原因就是你写了两段，那么系统就不会默认你需要序号了，那么怎么把序号掉出来呢？先使用Ctrl+shift+[，再使用shift+tab，就可以了。
>
> 如果开序号下有很多小序号，使用tab和tab+shift键还可以一直进行缩进，同时序号也会变。
>
>  

 









## 扩展排版

- 插入代码块，输入代码后再选择语言，会自动依照语言把代码块高亮

- >支持直接拖拽插入图片，也可以支持截图直接Ctrl+V粘贴图片，支持静态图和GIF图。最好用的功能是可以通过设置，把拖入和粘贴的图片在文档所在的文件夹自动创建一个副本，这样就再也不用担心找不到原图了。

- 可以使用flow语言绘制流程图

- 公式块功能，借助LATEX语言插入漂亮的公式 




## quick start

`Esc` key will trigger assistant behavior, like open inline preview for inline math, auto-complete for emoji, etc. 

#### Actions

- Select word: cmd+D
- Delete word: shift+cmd+D
- Select line/sentence: cmd+L
- Select row in table: cmd+L
- Add row in table: cmd+Enter
- Select Styled Scope (or cell in a table) cmd+E
- Jump to selection: cmd+J
- Jump to Top: cmd+↑
- Jump To Bottom: cmd+↓
- Increase/decrease heading level from `<p>` to `<h1>`: cmd+-/+
- New line: shift+Return
- Move table row/column: ⌘ + ⌃ + arrow key.



# 石墨文档：解决多人协作的利器

使用Word编辑文档的时候，需要把成品文档发给别人，等待对方加好批注再发送回来，一处一处的找批注，再一点点修改，而且一旦需要审阅批注的人数大于两个，就只能等一个人批注完再传给下一个人，非常不方便。



# Markdown For Typora

one blank line (press `Return` once) to create a new paragraph.

Press `Shift` + `Return` to create a single line break

无序列表 - 空格

有序列表 1. 空格

```javascript
​```javascript     代码片段语法渲染
```



### Lists

Input `* list item 1` will create an unordered list - the `*` symbol can be replace with `+` or `-`.

Input `1. list item 1` will create an ordered list - their markdown source code is as follows:

```
- item1

1. item1
- [ ] item1
- [x] item1

​```sql

| id | name | 

--- 分隔线

[toc] 生成目录

[This link](http://example.net/) has no title attribute.
This is [an example](http://example.com/ "Title") inline link.


`<i@typora.io>` becomes <i@typora.io> 超链接打开邮箱


图片
![alt](path/img.jpg) ,比超链接多了一个！

 
*斜体*

**加粗**

underline ,cmd+U 
--删除--

:smile: 输入emoji

<span style="color:red">red</span>
使用html style 实现纯markdown不支持的特性，如：颜色


内嵌网址
<iframe height='265' scrolling='no' title='Fancy Animated SVG Menu' src='http://codepen.io/jeangontijo/embed/OxVywj/?height=265&theme-id=0&default-tab=css,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'></iframe>


嵌入视频 ,音乐
<video src="xxx.mp4" />
<audio src="xxx.mp3" />

```

- [ ] item1
- [x] item2



```sql
create table test(
)
```





| id   | name |
| ---- | ---- |
|      |      |



[^footnote]: Here is the *text* of the **footnote**.



---



 <i@mail.com>



_a_

*斜体*

**加粗**

~~删除掉~~

<u>underline</u>

:smile:

:lo

  `$\lim_{x \to \infty} \exp(-x) = 0$` will be rendered as LaTeX command.



 ==highlight==

  <span style="color:red">red</span>

<iframe height='265' scrolling='no' title='Fancy Animated SVG Menu' src='http://codepen.io/jeangontijo/embed/OxVywj/?height=265&theme-id=0&default-tab=css,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'></iframe>

 





Typora支持的html语法

```
<ruby> 漢 <rt> ㄏㄢˋ </rt> </ruby>
<span style='color:red'>This is red</span>
<kbd>Ctrl</kbd>+<kbd>F9</kbd>
<span style="font-size:2rem; background:yellow;">**Bigger**</span>


<details>
    <summary>I have keys but no locks. I have space but no room. You can enter but can't leave. What am I?</summary>
    A keyboard.
</details>

<audio src="xxx.mp3" /> 


twitter内嵌
Some websites only provide Javascript-based embed code, instead of an <iframe> snips, for example:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Sunsets don&#39;t get much better than this one over <a href="https://twitter.com/GrandTetonNPS?ref_src=twsrc%5Etfw">@GrandTetonNPS</a>. <a href="https://twitter.com/hashtag/nature?src=hash&amp;ref_src=twsrc%5Etfw">#nature</a> <a href="https://twitter.com/hashtag/sunset?src=hash&amp;ref_src=twsrc%5Etfw">#sunset</a> <a href="http://t.co/YuKy2rcjyU">pic.twitter.com/YuKy2rcjyU</a></p>&mdash; US Department of the Interior (@Interior) <a href="https://twitter.com/Interior/status/463440424141459456?ref_src=twsrc%5Etfw">May 5, 2014</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Typora only supports some script-based sharing code, and those contents/scripts will also be running in a sandbox iframe with no access to your local file and writing contents.


不支持内嵌pdf，可以使用online file viewers 替代，
https://gist.github.com/tzmartin/1cf85dc3d975f94cfddc04bc0dd399be


格式：
In HTML Block, no empty line is not allowed, or it will be rendered as two HTML Blocks.
不支持 id,class,data- ，自定义标签

```



 <kbd>cmd</kbd>+<kbd>aa</kbd>

<span style="background:yellow">sss</span>

<details>
  <summary>sss
  </summary>aaa
</details>


<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Sunsets don&#39;t get much better than this one over <a href="https://twitter.com/GrandTetonNPS?ref_src=twsrc%5Etfw">@GrandTetonNPS</a>. <a href="https://twitter.com/hashtag/nature?src=hash&amp;ref_src=twsrc%5Etfw">#nature</a> <a href="https://twitter.com/hashtag/sunset?src=hash&amp;ref_src=twsrc%5Etfw">#sunset</a> <a href="http://t.co/YuKy2rcjyU">pic.twitter.com/YuKy2rcjyU</a></p>&mdash; US Department of the Interior (@Interior) <a href="https://twitter.com/Interior/status/463440424141459456?ref_src=twsrc%5Etfw">May 5, 2014</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>





 

# 快捷键

选中单词 cmd+D
删除单词 Shift+cmd+D

选中行或一个语句 ，选中表格一行  cmd+L
移动表格行或列 cmd+ctrl+arrowKey
选中单元格或者styled scope.  cmd+E ,



添加表格行 cmd+Enter 
新建一行 shift+Return 

- Jump to selection: cmd+J
- Jump to Top: cmd+↑
- Jump To Bottom: cmd+↓
- Increase/decrease heading level from `<p>` to `<h1>`: cmd+-/+



可以Window>merge all window, ctrl+tab 切换标签

全屏  ctrl+cmd+F 



Focus Mode,当前文档，除光标以外部分蒙空

TyperMode 打字机模式，光标始终居中，内容自动上移

toggle sidebar，shift+cmd+L

ctrl+cmd+1,2,3 outline,articles, folder tree 

搜索 shift+cmd+f 

shit+cmd+0 , + , -   放大 ，缩小 文字



cmd + 0 ,1,2,3,4,5 段落，标题1，2，3

option+cmd+T 插入表格 

 opiton + cmd +c 代码段

<u>cmd+u</u>

<!--ssd
dfds
sdfds
dsfsd
sdfs
sdfsfsf-->

 ctrl + - 添加注释

<!---->

cmd+k  添加链接

[]()

![]()

ctrl+cmd+i 添加图片

cmd+i 斜体

cmd+\ 清除格式



Currently Typora only support to export as **PDF** or **HTML**.

alias typora="open -a typora"









docsify 可以快速帮你生成文档网站。不同于 GitBook、Hexo 的地方是它不会生成静态的 `.html` 文件，所有转换工作都是在运行时。如果你想要开始使用它，只需要创建一个 `index.html` 就可以开始编写文档并直接[部署在 GitHub Pages](https://docsify.js.org/#/zh-cn/deploy)。

配合 markdown ，git同步，网页显示



**GitHub Pages**是[GitHub](https://zh.wikipedia.org/wiki/GitHub)提供的一个[网页寄存服务](https://zh.wikipedia.org/wiki/網頁寄存服務)，于2008年推出[[1\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-pipinellis-1)[[2\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-announce-2)。可以用于存放静态网页，包括博客、项目文档[[3\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-bellbeer-3)[[1\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-pipinellis-1)甚至整本书。[[4\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-xie-4)[Jekyll软件](https://zh.wikipedia.org/w/index.php?title=Jekyll_(軟體)&action=edit&redlink=1)可以用于将文档转换成静态网页，该软件提供了将网页上传到GitHub Pages的功能。[[5\]](https://zh.wikipedia.org/zh-cn/GitHub_Pages#cite_note-clark-5)一般GitHub Pages的网站使用github.io的子域名，但是用户也可以使用第三方域名。 

自由度更高的网页制作，可以配合Github Action持续集成发布到个人网址





# GitHub Actions 入门教程



### 使用 jsDelivr CDN 加速 Github 仓库的图片，以作为博客的图床

jsDelivr 是国外的一家优秀的公共 CDN 服务提供商，也是首个「打通中国大陆（网宿公司运营）与海外的免费 CDN 服务」[1](https://blog.iljw.me/2019/05/jsdelivr-cdn-github.html#fn1)。jsDelivr 有一个十分好用的功能——**它可以加速 Github 仓库的文件**。我们可以借此搭建一个免费、全球访问速度超快的图床。

使用 PicGo[3](https://blog.iljw.me/2019/05/jsdelivr-cdn-github.html#fn3)将图片上传到指定 Github 仓库位置，再利用 jsDelivr 获得图片加速后的 url。

 

#### [PicGo使用](https://picgo.github.io/PicGo-Doc/zh/guide/config.html#github%E5%9B%BE%E5%BA%8A)

新建仓库 picgo, 
setting/developer settings/ personal access tokens 
![img](https://cdn.jsdelivr.net/gh/joeyliu6/Blogger@master/static_files/iljw/img/large/20190512153732.png)



repo的勾打上即可。然后翻到页面最底部，点击`Generate token`的绿色按钮生成token。

**注意：**这个token生成后只会显示一次！你要把这个token复制一下存到其他地方以备以后要用。

​     



插件 picgo-plugin-super-prefix

```
/img/2019/11/18/20191118005858.jpeg
```

## 修改配置参数后生效

注意：仓库名不能有空格 ![image-20200721181118289](/Users/demo/Library/Application Support/typora-user-images/image-20200721181118289.png)

------

| 参数         | 建议值           | 说明                        |
| ------------ | ---------------- | --------------------------- |
| prefixFormat | `YYYY/MM/DD/`    | 文件名个性前缀格式(以/结尾) |
| fileFormat   | `YYYYMMDDHHmmss` | 文件名个性格式              |

YYYY/MM 
DDHHmmss

该插件暂不支持  文件名称__时间后缀， 先这么用，等软件更新或者有空自己开发，不是太想搞这个。。。





自定义域名 ，无需注册，直接拼接好链接即可。

【[https://cdn.jsdelivr.net/gh/](https://link.zhihu.com/?target=https%3A//cdn.jsdelivr.net/gh/)用户名/图床仓库名 】，关于jsDelivr是如何引用资源的可以参考[《免费CDN：jsDeliver+Github》](https://link.zhihu.com/?target=https%3A//www.itrhx.com/2019/02/10/A18-free-cdn/)

将图片拖拽到上传区，将会自动上传并复制访问链接，将链接粘贴到博文中就行了，访问速度杠杠的，此外PicGo还有相册功能，可以对已上传的图片进行删除，修改链接等快捷操作



测试成功
https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/07/21180729.gif



## [Typora 支持 PicGo 来上传图片了](https://molunerfinn.com/typora-supports-picgo/#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%9B%BE%E7%89%87%E4%B8%8A%E4%BC%A0%E6%9C%8D%E5%8A%A1%E7%9A%84%E8%AE%BE%E7%BD%AE)

https://support.typora.io/Upload-Image/#config-picgo-core







# [docsify](https://docsify.js.org/#/?id=docsify)

 直接根据md文件生成网页，不需要html文件存在

Smart full-text search plugin

Multiple themes



```bash
npm i docsify-cli -g
cd blog
docsify init ./ 
```

 After the init is complete, you can see the file list in direction

- `index.html` as the entry file
- `README.md` as the home page
- `.nojekyll` prevents GitHub Pages from ignoring files that begin with an underscore

Preview your site

```
$ docsify serve ./ 
```



编辑index.html

```
<div id="app">Please wait...</div>
```



## [More pages](https://docsify.js.org/#/more-pages?id=more-pages)

```text
.
└── docs
    ├── README.md
    ├── guide.md
    └── zh-cn
        ├── README.md
        └── guide.md
```

Matching routes

```text
docs/README.md        => http://domain.com
docs/guide.md         => http://domain.com/#/guide
docs/zh-cn/README.md  => http://domain.com/#/zh-cn/
docs/zh-cn/guide.md   => http://domain.com/#/zh-cn/guide
```

## [Sidebar](https://docsify.js.org/#/more-pages?id=sidebar)

you can create your own `_sidebar.md` (see [this documentation's sidebar](https://github.com/docsifyjs/docsify/blob/master/docs/_sidebar.md) for an example):

First, you need to set `loadSidebar` to **true**. 

```markdown
<!-- docs/_sidebar.md -->

* [Home](/)
* [Guide](guide.md)
```

Docsify only looks for `_sidebar.md` in the current folder, 

## [Nested Sidebars](https://docsify.js.org/#/more-pages?id=nested-sidebars)

## [Set Page Titles from Sidebar Selection](https://docsify.js.org/#/more-pages?id=set-page-titles-from-sidebar-selection)

```markdown
<!-- docs/_sidebar.md -->
* [Home](/)
* [Guide](guide.md "The greatest guide in the world")
```

设置每页的 title属性









## [Deploy](https://docsify.js.org/#/deploy?id=deploy)

It is recommended that you save your files to the `./docs` subfolder of the `master` branch of your repository. Then select `master branch /docs folder` as your Github Pages source in your repositories' settings page.![github pages](https://docsify.js.org/_images/deploy-github-pages.png)











# Github Pages

Build your own site from scratch or generate one for your project.









