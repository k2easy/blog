

为 CPython 的解释器太慢了。GraalPython（JVM 模式）预热后快了 21 倍。

# [基础教程](https://www.runoob.com/python3/python3-basic-syntax.html)

```
#!/usr/bin/python3
 
# 第一个注释
'''
多行注释
多行注释
'''
print ("Hello, Python!") # 第二个注释
```

使用缩进来表示代码块，不需要使用大括号 **{}**

```
if expression : 
   suite
elif expression : 
   suite 
else : 
   suite
```

```
total = item_one + \
        item_two + \
        item_three
```

## 基础类型

```
数字(Number)类型：
只有一种整数类型 int，表示为长整型
bool (布尔), 如 True。
float (浮点数), 如 1.23、3E-2
complex (复数), 如 1 + 2j、 1.1 + 2.2j

字符串(String)
python中单引号和双引号使用完全相同。
使用三引号('''或""")可以指定一个多行字符串。
字符串的截取的语法格式如下：变量[头下标:尾下标:步长]


>>> print('\n')       # 输出空行

>>> print(r'\n')      # 输出 \n ， r 指 raw，即 raw string，会自动将反斜杠转义
```



### import

将整个模块(somemodule)导入，格式为： **import somemodule 

从某个模块中导入多个函数,格式为： **from somemodule import firstfunc, secondfunc, thirdfunc**

将某个模块中的全部函数导入，格式为： **from somemodule import \***



```
#!/usr/bin/python3

counter = 100          # 整型变量
miles   = 1000.0       # 浮点型变量
name    = "runoob"     # 字符串

print (counter)
print (miles)
print (name)

a = b = c = 1
a, b, c = 1, 2, "runoob"
```

Python3 的六个标准数据类型中：

- **不可变数据（3 个）：**Number（数字）、String（字符串）、Tuple（元组）；
- **可变数据（3 个）：**List（列表）、Dictionary（字典）、Set（集合）。

```
>>> a, b, c, d = 20, 5.5, True, 4+3j
>>> print(type(a))
```

- isinstance()会认为子类是一种父类类型。

```
del var1[,var2[,var3[....,varN]]] 删除一些对象引用
```

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/04/0220210402160646.svg)

```
print (str[0:-1])    # 输出第一个到倒数第二个的所有字符 Runoo
```

```
list = [ 'abcd', 786 , 2.23, 'runoob', 70.2 ]
print (list[2:])        # 输出从第三个元素开始的所有元素
print (tinylist * 2)    # 输出两次列表
print (list + tinylist) # 连接列表
```

**元组**（tuple）与列表类似，不同之处在于元组的元素不能修改。元组写在小括号 **()** 里，元素之间用逗号隔开。

```
tuple = ( 'abcd', 786 , 2.23, 'runoob', 70.2  )
print (tuple[2:])         # 输出从第三个元素开始的所有元素
print (tinytuple * 2)     # 输出两次元组
print (tuple + tinytuple) # 连接元组
```

**集合**（set）使用大括号 **{ }** 或者 **set()** 函数创建集合，构成集合的事物或对象称作元素或是成员。注意：创建一个空集合必须用 **set()** 而不是 **{ }**，因为 **{ }** 是用来创建一个空字典。

```
sites = {'Google', 'Taobao', 'Runoob', 'Facebook', 'Zhihu', 'Baidu'}

# 成员测试
if 'Runoob' in sites :
    print('Runoob 在集合中')
else :
    print('Runoob 不在集合中')
```

列表是有序的对象集合，**字典**是无序的对象集合。两者之间的区别在于：字典当中的元素是通过键来存取的，而不是通过偏移存取。
它是一个无序的 **键(key) : 值(value)** 的集合。
键(key)必须使用不可变类型。 在同一个字典中，键(key)必须是唯一的。

```
dict = {}  # 创建空字典使用 { }
dict['one'] = "1 - 菜鸟教程"
dict[2]     = "2 - 菜鸟工具"
tinydict = {'name': 'runoob','code':1, 'site': 'www.runoob.com'}

print (dict['one'])       # 输出键为 'one' 的值
print (tinydict.keys())   # 输出所有键
print (tinydict.values()) # 输出所有值
```

流程控制

```
while <expr>:
    <statement(s)>
else:
    <additional_statement(s)>
    
for <variable> in <sequence>:
    <statements>
else:
    <statements>
```

```
>>>for i in range(0, 10, 3) :
    print(i)
    
>>> for x in list:
...     print (x)

>>> for i in range(len(list)):
...     print(i, list[i])
```

### 函数

```
def hello(age=35) :  #参数默认值
    print("Hello World!")

hello()

#不定长参数 
def printinfo( arg1, *vartuple ):
   "打印任何传入的参数"
   print ("输出: ")
   print (arg1)
   print (vartuple)
   for var in vartuple:
      print (var)
  
printinfo( 70, 60, 50 )
 
```

```
>>> for x in range(1, 11):
...     print('{0:2d} {1:3d} {2:4d}'.format(x, x*x, x*x*x))
...
 1   1    1
 2   4    8
 3   9   27
 4  16   64
 5  25  125
 6  36  216
 7  49  343
 8  64  512
 9  81  729
10 100 1000
```

```
>>> print('{}网址： "{}!"'.format('菜鸟教程', 'www.runoob.com'))
菜鸟教程网址： "www.runoob.com!"

>>> print('站点列表 {0}, {1}, 和 {other}。'.format('Google', 'Runoob', other='Taobao'))
站点列表 Google, Runoob, 和 Taobao。

>>> print('常量 PI 的值近似为 {0:.3f}。'.format(math.pi))
常量 PI 的值近似为 3.142。
```

```
>>> table = {'Google': 1, 'Runoob': 2, 'Taobao': 3}
>>> for name, number in table.items():
...     print('{0:10} ==> {1:10d}'.format(name, number))
```

```
str = input("读取键盘输入：");
print ("你输入的内容是: ", str)
```

## mysql

```
python -m pip install mysql-connector
```

demo_mysql_test.py

```python
import mysql.connector
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="123456"
)
 
mycursor = mydb.cursor()
mycursor.execute("SHOW DATABASES")
for x in mycursor:
  print(x)
  
mycursor.execute("CREATE TABLE sites (name VARCHAR(255), url VARCHAR(255))")

sql = "INSERT INTO sites (name, url) VALUES (%s, %s)"
val = [
  ('Google', 'https://www.google.com'),
  ('Github', 'https://www.github.com'),
  ('Taobao', 'https://www.taobao.com'),
  ('stackoverflow', 'https://www.stackoverflow.com/')
]
mycursor.executemany(sql, val)
mydb.commit()    # 数据表内容有更新，必须使用到该语句
print(mycursor.rowcount, "记录插入成功。")

# print("1 条记录已插入, ID:", mycursor.lastrowid)
# 在数据记录插入后，获取该记录的 ID 

# select
mycursor.execute("SELECT name, url FROM sites")
myresult = mycursor.fetchall() # fetchall()获取所有记录,fetchone() 只想读取一条数据
for x in myresult:
  print(x)
  
# myresult = mycursor.fetchone() 只想读取一条数据
```

为了防止数据库查询发生 SQL 注入的攻击，我们可以使用 %s 占位符来转义查询的条件

```python
sql = "SELECT * FROM sites WHERE name = %s"
na = ("RUNOOB", )
mycursor.execute(sql, na)
myresult = mycursor.fetchall()

ql = "UPDATE sites SET name = %s WHERE name = %s"
val = ("Zhihu", "ZH")
 
mycursor.execute(sql, val)
 
```

## PyMySQL 驱动

PyMySQL 是在 Python3.x 版本中用于连接 MySQL 服务器的一个库
$ pip3 install PyMySQL

```
import pymysql

# Open database connection
db = pymysql.connect("localhost","testuser","test123","TESTDB" )

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Prepare SQL query to INSERT a record into the database.
sql = """INSERT INTO EMPLOYEE(FIRST_NAME,
   LAST_NAME, AGE, SEX, INCOME)
   VALUES ('Mac', 'Mohan', 20, 'M', 2000)"""
try:
   # Execute the SQL command
   cursor.execute(sql)
   # Commit your changes in the database
   db.commit()
except:
   # Rollback in case there is any error
   db.rollback()

# disconnect from server
db.close()
```



# http request

pip install requests

```bash
python test.py

import requests
res = requests.get(url)
res.status_code
res.text
json  = res.json()
json['list'][0]

```

# pip

pip 是 Python 包管理工具，该工具提供了对Python 包的查找、下载、安装、卸载的功能。 Python 3.4+ 以上版本都自带 pip 工具。#pip3 --version

cmd+opiton+x 快捷插入清单列表

```
pip install SomePackage              # 最新版本
pip install SomePackage==1.0.4       # 指定版本
pip install 'SomePackage>=1.0.4'     # 最小版本

pip install --upgrade SomePackage # 通过使用==, >=, <=, >, < 来指定一个版本号
pip uninstall SomePackage
pip search SomePackage
pip show -f SomePackage //查看该包的详细信息
pip list -o //列出已安装的包 , -o查看可以升级的包
pip3 install --upgrade pip   # python3.x  -U
```

镜像站 
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple some-package # 临时使用

```
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

  pip3 install <package>
They will install into the site-package directory
  /usr/local/lib/python3.9/site-packages

pip show requests ,也会显示下载的安装包目录位置 



vscode ，命令面板输入 keyboard，搜索terminalFocus



smartbi系统监控中的 sql监控应该支持按照数据源筛选



# [How to install packages offline?](https://stackoverflow.com/questions/11091623/how-to-install-packages-offline)


If you want install python libs and their dependencies offline, finish following these steps on a machine with the same os, network connected, and python installed:

1) Create a `requirements.txt` file with similar content (Note - these are the libraries you wish to download):

```py
Flask==0.12
requests>=2.7.0
scikit-learn==0.19.1
numpy==1.14.3
pandas==0.22.0
```

One option for creating the requirements file is to use `pip freeze > requirements.txt`. This will list all libraries in your environment. Then you can go in to `requirements.txt` and remove un-needed ones.

2) Execute command `mkdir wheelhouse && pip download -r requirements.txt -d wheelhouse` to download libs and their dependencies to directory `wheelhouse`

3) Copy requirements.txt into `wheelhouse` directory

4) Archive wheelhouse into `wheelhouse.tar.gz` with `tar -zcf wheelhouse.tar.gz wheelhouse`

Then upload `wheelhouse.tar.gz` to your target machine:

1) Execute `tar -zxf wheelhouse.tar.gz` to extract the files

2) Execute `pip install -r wheelhouse/requirements.txt --no-index --find-links wheelhouse` to install the libs and their dependencies

访问的jsp资源，js动态加载渲染，python request没有等待页面渲染结束的方法，其他实现方式复杂，尝试 puppeteer

# puppeteer

网页截图

```
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('http://www.baidu.com');
  await page.screenshot({ path: 'example.png' });

  await browser.close();
})();
```

示例1

```

const puppeteer = require('puppeteer');
(async () => {
const browser = await puppeteer.launch();

const page = await browser.newPage();
await page.goto('http://www.google.com', {waitUntil: 'networkidle2'});//打开网址

//await page.goto(`data:text/html,${content}`,{ waitUntil: 'networkidle0' }) 打开html模 版，content 是你的html代码


await page.pdf({path: 'hn8.pdf', width: '1600px' , height: '800px'});
await browser.close();
})();
```

networkidle则是用来等待所有的request结束。如果没有这个，比如，如果有的图片src是url的话，就不会被正确的render出来。

networkidle2 代表还有两个以下的request就考虑navigation结束

networkidle0 则是全部request结束





示例2

use [`page.waitForNavigation()`](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#pagewaitfornavigationoptions) to wait for the new page to load completely before generating a PDF

```
await page.goto(fullUrl, {
  waitUntil: 'networkidle0',
});

await page.type('#username', 'scott');
await page.type('#password', 'tiger');

await page.click('#Login_Button');

await page.waitForNavigation({
  waitUntil: 'networkidle0',
});

await page.pdf({
  path: outputFileName,
  displayHeaderFooter: true,
  headerTemplate: '',
  footerTemplate: '',
  printBackground: true,
  format: 'A4',
});
```

If there is a certain element that is generated dynamically that you would like included in your PDF, consider using [`page.waitForSelector()`](https://github.com/GoogleChrome/puppeteer/blob/master/docs/api.md#pagewaitforselectorselector-options) to ensure that the content is visible:

```js
await page.waitForSelector('#example', {
  visible: true,
});
```

https://pptr.dev/

```bash
npm i puppeteer
```

When you install Puppeteer, it downloads a recent version of Chromium (~170MB Mac, ~282MB Linux, ~280MB Win) that is guaranteed to work with the API. To skip the download, or to download a different browser, see [Environment variables](https://github.com/puppeteer/puppeteer/blob/v8.0.0/docs/api.md#environment-variables).



nodejs项目打包成可执行文件，exe

```
npm install -g pkg
pkg index.js
```

package.json
"pkg": { "assets": "views/**/*" }



```
npm config set registry https://registry.npm.taobao.org
npm config set registry https://registry.npmjs.org
npm config get registry

```



windows包管理 chocolatey

PS C:\nodejs_space\cache> npm install -g  pkg **C:\Users\demo\AppData\Roaming\npm\node_modules**\pkg\lib-es5\bin.js



win7 安装
Latest node.js version that (officially) supports Windows 7 is 13.6.0.

Had same problem and ended solving it, I just installed node 14.15.0

- Go [here](https://nodejs.org/en/download/)
- Download the **Windows Binary (.zip)** either 32/64 bit
- Extract it in the directory where your node it's installed and say yes to replace all files (remember that the zip comes with npm that is in `node_modules/npm` directory I didn't copy from the zip because I already updated npm before replacing the files)
- Create an Environment variable called: `NODE_SKIP_PLATFORM_CHECK` and set it to 1
- Ready to use node in Windows 7 for now

先下载13.6，再用14.15二进制文件覆盖，注意备份 node_models/npm



```text
npm install pkg --save-dev
```

`--targets` option. A canonical target consists of 3 elements, separated by dashes, for example `node6-macos-x64` or `node4-linux-armv6`:

- **nodeRange** node${n} or latest
- **platform** freebsd, linux, alpine, macos, win
- **arch** x64, x86, armv6, armv7



fetched-v14.4.0-win-x64  ESOCKETTIMEDOUT

这是因为打包需要从GitHub上下载一些文件，但是国内网络的原因导致下载出错，可以手动从GitHub上下载到本地，[https://github.com/vercel/pkg-fetch/releases](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fvercel%2Fpkg-fetch%2Freleases)

 

放到如下目录并修改名字为`fetched-v14.4.0-win-x64`后缀名也包括在内（删除原来的后缀名），记得删除`.downloading`为后缀名的文件，因为这是下载失败的文件
 `C:\Users\Administrator\.pkg-cache\v2.6`



 

# rz命令 上传文件 xxxx was skipped

原因：

1、文件上传的目标文件夹，没有写入的权限

2、上传的文件没有可执行权限

解决办法：

1、换个目标目录，再次上传文件，排除一下原因

2、给文件赋予权限



# tutorial

使用对数据分析人员最友好的python语法开发，

https://docs.python.org/zh-cn/3.9/tutorial/

开发快

# 基础知识

Python 是一种解释型语言，不需要编译和链接，可以节省大量开发时间。

> 本语言的命名源自 BBC 的 “Monty Python 飞行马戏团”，与爬行动物无关（Python 原义为“蟒蛇”）

Python 解释器一般安装在 `/usr/local/bin/python3.9` 
$python3.9  -V

结束符号：ctrl+z ctrl+d  quit

> [>>>](https://docs.python.org/zh-cn/3.9/glossary.html#term-0) 与 [...](https://docs.python.org/zh-cn/3.9/glossary.html#term-1)）区分输入与输出

```
>>> tax = 12.5 / 100
>>> price = 100.50
>>> price * tax
12.5625
>>> price + _
113.0625
>>> round(_, 2)
113.06
```

上次输出的表达式会赋给变量 `_`,不要为它显式赋值，否则会创建一个同名独立局部变量，该变量会用它的魔法行为屏蔽内置变量。

#### 字符串

单引号（`'……'`）或双引号（`"……"`） ，反斜杠 `\` 用于转义

```
>>> 'doesn\'t' 
>>> '"Yes," they said.'
```

交互式解释器会为输出的字符串加注引号，特殊字符使用反斜杠转义。虽然，有时输出的字符串看起来与输入的字符串不一样（外加的引号可能会改变），但两个字符串是相同的。

[`print()`](https://docs.python.org/zh-cn/3.9/library/functions.html#print) 函数输出的内容更简洁易读，它会省略两边的引号，并输出转义后的特殊字符：

```
>>> s = 'First line.\nSecond line.'  # \n means newline
>>> s  # without print(), \n is included in the output
'First line.\nSecond line.'
>>> print(s)  # with print(), \n produces a new line
First line.
Second line.
```

如果不希望前置 `\` 的字符转义成特殊字符，可以使用 *原始字符串*，在引号前添加 `r`

```
>>> print('C:\some\name')  # here \n means newline!
C:\some
ame
>>> print(r'C:\some\name')  # note the r before the quote
C:\some\name
```

字符串可以用 `+` 合并（粘到一起），也可以用 `*` 重复：

```
>>> 3 * 'un' + 'ium'
'unununium'
```

字符串支持 *索引* （下标访问），第一个字符的索引是 0。单字符没有专用的类型，就是长度为一的字符串，支持用负数索引（-1）。-0 和 0 一样，因此，负数索引从 -1 开始

*切片*

```
word[0:2]
```

开始索引默认值为 0，结束索引默认为到字符串的结尾

```
索引越界会报错： 
>>> word[42]  # the word only has 6 characters
IndexError: string index out of range

切片会自动处理越界索引：
>>> word[4:42]
'on'
>>> word[42:]
''
```

要生成不同的字符串，应新建一个字符串：

```
>>> 'J' + word[1:]
'Jython' 
```

内置函数 [`len()`](https://docs.python.org/zh-cn/3.9/library/functions.html#len) 返回字符串的长度：

### 列表

```
>>> squares = [1, 4, 9, 16, 25]
>>> squares[:]  浅拷贝
>>> squares + [36, 49, 64, 81, 100] 合并
```

和字符串（及其他内置 [sequence](https://docs.python.org/zh-cn/3.9/glossary.html#term-sequence) 类型）一样，列表也支持索引和切片

与 [immutable](https://docs.python.org/zh-cn/3.9/glossary.html#term-immutable) 字符串不同, 列表是 [mutable](https://docs.python.org/zh-cn/3.9/glossary.html#term-mutable) 类型，其内容可以改变：



`append()` *方法* 可以在列表结尾添加新元素

```
>>> cubes.append(7 ** 3)  # and the cube of 7 
```

为切片赋值可以改变列表大小，甚至清空整个列表：

```
>>> # replace some values
>>> letters[2:5] = ['C', 'D', 'E']
>>> # now remove them
>>> letters[2:5] = []
>>> # clear the list by replacing all the elements with an empty list
>>> letters[:] = []
```

# 6 模块

一个 `.py` 文件就是 *模块* ；模块中的定义可以 *导入* 到其他模块或 *主* 模块。

在模块内部，通过全局变量 `__name__` 可以获取模块名（即字符串）。

```
>>> from fibo import fib, fib2 直接导入fibo.py 中的fib fib2 函数
>>> from fibo import *
>>> fib(500)
>>> import fibo as fib
>>> from fibo import fib as fibonacci
```

为了保证运行效率，每次解释器会话只导入一次模块。如果更改了模块内容，必须重启解释器；仅交互测试一个模块时，也可以使用 [`importlib.reload()`](https://docs.python.org/zh-cn/3.9/library/importlib.html#importlib.reload)，例

# pip 

pip search 无法使用，需要到网站搜索

https://pypi.org/



# pipenv 依赖包管理

>`pipenv` 是在你安装依赖的时候就进行记录
>
>使用 `Pipenv.lock` 文件记录了 `Python` 版本、软件包 `hash` 值、软件包版本、`pip` 仓库地址等重要信息。
>
>`Pipfile` 拥有独立的解析步骤，且不需要先将套件实际安装至环境中，当你将一个会破坏依赖结构的包加入 `Pipfile` 时，locking就会直接告知你这个依赖无法被解析。

It automatically creates and manages a virtualenv for your projects, as well as adds/removes packages from your `Pipfile` as you install/uninstall packages. 

```
$ brew install pipenv
or
$ pipx install pipenv
or
pip install pipenv  # 安装pipenv工具
$ pip install --user --upgrade pipenv
```

```
$ cd myproject
$ pipenv install requests

import requests
response = requests.get('https://httpbin.org/ip')
print('Your IP is {0}'.format(response.json()['origin']))

//$ pipenv run python main.py 
```

```

install  # 从Pipfile.lock安装需要的依赖
pipenv bash  # 启动虚拟环境，需在有Pipfile的目录下执行此命令
```

warning: the environment variable LANG is not set!

```
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

source ~/.zshrc
```

pipenv --pypi-mirror TEXT

The Python Package Index (PyPI) is a repository of software for the Python programming language.

# Create a local Python pip repository

Python is a very interesting programming language because it is possible to prototype a lot of things in a few minutes. 

> python -m http.server 8080 
>
> http://localhost:8080 对应到当前目录

```
pip install python-pypi-mirror

pypi-mirror download -d downloads requests //下载requests包及相关依赖到当前目录
pypi-mirror create -d downloads -m simple  // 创建simple文件夹，生成包索引目录结构 package index，满足pip对manual repoistory的目录要求，tree simple可以看到是软链接过去downloads目录内的内容，macos软链接到win失效。

python3 -m http.server
pip install -i http://127.0.0.1:8000/simple requests
// pip install -i http://ip.of.srv/simple --trusted-host ip.of.srv package
```

##### “Manual” repository[¶](https://packaging.python.org/guides/hosting-your-own-index/#manual-repository)

```
因为 macos软链接到win失效，需要在win环境下生成mirror依赖包仓库
PS C:\Python39\Lib\site-packages> python .\pypi_mirror.py download -d mirrors/downloads requests

PS C:\Python39\Lib\site-packages> python  .\pypi_mirror.py create -d .\mirrors\downloads\ -m .\mirrors\simple\ 
*** error: (1314, 'CreateSymbolicLink', 'A required privilege is not held by the client.')
右键 powershell管理员运行，没有创建符号链接的权限
https://www.scivision.dev/windows-symbolic-link-permission-enable/
Open gpedit.msc
Computer Configuration → Windows Settings → Security Settings → Local Policies → User Rights Assignment → Create symbolic links
Type the user name and click “Check Names” then OK.
Reboot the computer


cd mirros
python -m http.server

```





# pyenv

控制python版本的工具，暂时用不到。

搞错了，pyenv is a simple python version management tool. It lets you easily switch between multiple versions of Python. 这个不是pipenv
使用pip离线安装pyenv-win
PS C:\Windows\system32> pip install -i http://localhost:8000/simple/ pyenv-win --target $HOME\\.pyenv     
配置pyevn环境变量，如果使用 Chocolatey 安装的可以跳过
https://github.com/pyenv-win/pyenv-win#installation
执行以下命令
[System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

[System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")

[System.Environment]::SetEnvironmentVariable('path', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")

重启powershell
pyenv --version 是刚才安装的版本

pyenv --help



# pipenv

```
http://localhost:8000/simple/
离线安装失败，在线安装 成功
pip install --user --upgrade pipenv
PS C:\Users\demo\AppData\Roaming\Python\Python39\Scripts>pipenv.exe

PS C:\codes\mirrors> pip install --no-index --find-links=file:/C:/codes/mirrors
PS C:\codes\mirrors> pip install --no-index --find-links=file:/C:/codes/mirrors pipenv
```



### [Unofficial Windows Binaries for Python Extension Packages](https://www.lfd.uci.edu/~gohlke/pythonlibs/)

This page provides 32- and 64-bit Windows binaries of many scientific open-source extension packages for the official [CPython distribution](https://www.python.org/download/) of the [Python](https://www.python.org/) programming language. A few binaries are available for the [PyPy](http://pypy.org/download.html) distribution.

https://stackoverflow.com/questions/51528441/pipenv-how-to-handle-locally-installed-whl-packages

修改Pipfile

```py
[[source]]
url = "http://hostname:8080/simple"
verify_ssl = false
name = "some_logical_name"
```

For binary wheels published outside of an index (such as [those built by Christoph Gohlke](https://www.lfd.uci.edu/~gohlke/pythonlibs/)), you could consider just installing the full wheel URL:

```py
pipenv install https://download.lfd.uci.edu/pythonlibs/l8ulg3xw/aiohttp-3.3.2-cp36-cp36m-win_amd64.whl
```



win10  管理员运行powershell，执行pip install

# [Python pip离线安装package方法总结（以TensorFlow为例）](https://imshuai.com/python-pip-install-package-offline-tensorflow)

PyPI上package有好几种格式：

1. 源文件（一般是`.tar.gz`或`.zip`文件，用`pip`安装，与机器架构无关，但某些package可能涉及到C/C++编译）
2. wheel文件（二进制文件，拓展名为`.whl`，用`pip`安装，无需编译，但与机器架构相关）
3. `.egg`文件（二进制文件，用`easy_install`安装，无需编译，但与机器架构相关）

**保证online和offline机器架构一样。** 所谓架构一样，其实就是四个参数一样：`--platform`, `--python-version`, `--implementation`, and `--abi`

- platform即操作系统，这个可以通过虚拟机或docker解决
- python-version，可以通过pipenv解决
- implementation，目前一般只考虑cpython
- abi，通过虚拟机或docker吧

 经过上面的分析总结，首先需要让online和offline机器架构一样。

1. 如果online和offline的机器架构完全一样：OS一样、Python版本一样，非常简单：

   1. 现在online机器执行download，下载所有依赖package到当前目录：

      ```
       pip download tensorflow
      ```

   2. 将目录内容拷贝到目标offline机器（比如/offline_package_dir），并目标offline机器执行

      ```
       pip install --no-index --find-links=file:/offline_package_dir tensorflow
      ```

2. 如果online和offline架构不一样 可以先尝试用download指定参数试一下是否能成功下载，如果不能再考虑下面的做法。 具体分为两种情况：

   1. 仅Python版本不一样
      1. 通过pyenv安装指定版本的python 2.7.13 `curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash` `pyenv install 2.7.13`
      2. 切换Python版本 `pyenv global 2.7.13`
      3. 接下来同第1中情况的步骤
   2. OS不一样 使用docker创建一个和目标机器架构相同的容器，在容器内安装和目标机器一样的Python版本，然后在容器内按第1种情况处理。 以我的例子:
      1. 先启动目标系统的docker镜像（这里以Ubuntu为例），并映射package下载目录 `docker run -it -v /offline_tensorflow_py3:/package ubuntu /bin/bash`
      2. 在容器内安装python `apt-get update && apt-get install python python-pip`
      3. 接下来同2.1步骤一样



```
cd mirrors
pip download pipenv
pip install --no-index --find-links=file:/C:/codes/mirrors pipenv

py -m pip freeze > requirements.txt 
pip install --no-index --find-links=/local/wheels -r requirements.txt
```

```
实际使用 
https://stackoverflow.com/questions/51528441/pipenv-how-to-handle-locally-installed-whl-packages

先使用 pip download，pip install 内网安装 pipenv ,pypiserver ,构建pypi whell仓库，pipenv从仓库中下载
 pip download --no-cache-dir ibm_db
 
$mkdir private_pypi && cd private_pypi

```

# [PipEnv: How to handle locally installed .whl packages](https://stackoverflow.com/questions/51528441/pipenv-how-to-handle-locally-installed-whl-packages)

```
$ mkdir private_pypi && cd private_pypi
pip install pypiserver                # Or: pypiserver[passlib,watchdog]
mkdir ~/packages                      # Copy packages into this directory.
pypi-server -p 8080 ~/packages &      # Will listen to all IPs.
 
[[source]]
url = "http://hostname:8080/simple"
verify_ssl = false
name = "some_logical_name"
```



# ibm_db

```
cd mirrors/packages
pip download -v --no-cache-dri ibm_db
```

```
from ibm_db import connect
# Careful with the punctuation here - we have 3 arguments.
# The first is a big string with semicolons in it.
# (Strings separated by only whitespace, newlines included,
#  are automatically joined together, in case you didn't know.)
# The last two are emptry strings.
connection = connect('DATABASE=<database name>;'
                     'HOSTNAME=<database ip>;'  # 127.0.0.1 or localhost works if it's local
                     'PORT=<database port>;'
                     'PROTOCOL=TCPIP;'
                     'UID=<database username>;'
                     'PWD=<username password>;', '', '')
                    
```

```
import ibm_db_dbi as db

conn = db.connect("DATABASE=name;HOSTNAME=host;PORT=60000;PROTOCOL=TCPIP;UID=username;PWD=password;", "", "")

for t in conn.tables():
    print(t)
    
cursor = conn.cursor()
cursor.execute("SELECT * FROM Schema.Table")
for r in cursor.fetchall():
    print(r)
    
```

https://www.ibm.com/docs/en/db2/11.1?topic=framework-application-development-db

```
1. Installed ibm_db in my local virtual environment using easy_install
2. Used 'wheel convert' to create an .whl file from installed folder
3. Copied .whl file to the server and used its 'pip' to install the wheel file
4. No issues were observed.
```

以在ibm_db模块中的setup.py中找到[下载链接](https://public.dhe.ibm.com/ibmdl/export/pub/software/data/db2/drivers/odbc_cli/)，如下图所示：
![ibm_db模块中的setup.py](https://img-blog.csdn.net/20180429094703685?watermark/2/text/Ly9ibG9nLmNzZG4ubmV0L215X3h4aA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)
访问该网址即可下载，如下图所示：

解压**ntx64_odbc_cli.zip**为文件夹**clidriver**，并替换掉**[ibm_db模块中](https://test.pypi.org/project/ibm-db/)**中对应名称的文件夹。



# ibm_db 使用

> https://github.com/ibmdb/python-ibmdb

> `ibm_db_dbi.py` module [here](https://github.com/ibmdb/python-ibmdb/blob/master/IBM_DB/ibm_db/ibm_db_dbi.py). This module implements the Python DB API Specification v2.0 for Db2 by acting as a wrapper around the Db2-specific `ibm_db` API calls.
>
> The `ibm_db` APIs are themselves very much like the Db2 Call Level Interfaces (CLI) and ODBC APIs. In fact, the `ibm_db` APIs are a wrapper around the CLI APIs implemented in Python and C.
>
> ibm_db_dbi 是对 ibm_db的上层封装

# ibm_db_dbi

> https://www.idug.org/blogs/john-maenpaa1/2021/01/22/db2-python-programing-hdbc-vs-hdbi

##### [Custom python application name in db2 list application output](https://stackoverflow.com/questions/50594084/custom-python-application-name-in-db2-list-application-output)

It's possible using `ibm_db_dbi.ibm_db.SQL_ATTR_INFO_PROGRAMNAME` connection attribute

```python
import ibm_db_dbi
db2ConnArgs = "DATABASE=%s;HOSTNAME=%s;PORT=%s;PROTOCOL=TCPIP;UID=%s;PWD=%s;" % ('SAMPLE', 'localhost', 50000, 'db2test', 'db2test')
db2ConnDict = {ibm_db_dbi.SQL_ATTR_CURRENT_SCHEMA:'SAMPLE', ibm_db_dbi.ibm_db.SQL_ATTR_INFO_PROGRAMNAME : 'luis_app'}
dbhandle = ibm_db_dbi.connect(db2ConnArgs,"", "","","",db2ConnDict)
```

Run `db2 list application`

```py
Auth Id  Application    Appl.      Application Id                                                 DB       # of
        Name           Handle                                                                    Name    Agents
-------- -------------- ---------- -------------------------------------------------------------- -------- -----
DB2TEST  luis_app       31         127.0.0.1.34194.180529223939                                   SAMPLE   1
```

##### Attach CLI/ODBC configuration keyword

db2cli.ini keyword syntax:

ATTACH = **TRUE** | **FALSE**

Default setting:The SQLDriverConnect() function connects to the specified database. 
When you set the keyword to TRUE, the SQLDriverConnect() function does not connect to a database but instead connects to the specified server instance.

SQL_ATTR_INFO_WRKSTNNAME attribute is used to set the client workstation name that is sent to a database.  
SQL_ATTR_INFO_USERID attribute is used to set the client user ID (accounting user ID) that is sent to a database. The SQL_ATTR_INFO_USERID attribute is for identification purposes only and is not used for any authentication.

```python
  connect_options = { "SQL_ATTR_INFO_PROGRAMNAME": "JHMTESTHELPERS", # 20 char max
                    "SQL_ATTR_INFO_USERID" : getpass.getuser(),    # 255 char max
                    "SQL_ATTR_INFO_WRKSTNNAME" : platform.node()   # 255 char max
                  } 
  hdbi = ibm_db_dbi.connect("ATTACH=FALSE;PROTOCOL=TCPIP;PORT=50000",
        host=hostname, database=database,
        user=userid, password=password,
        conn_options=connect_options)
        
        
        hdbi.close()
```

Python Database API defines Cursor objects as the interface that should be used for executing the SQL (or calling stored procedures). 

```
my_sql =  """select distinct tabschema, tabname
               from syscat.tables;
"""

my_cursor = hdbi.cursor()
my_cursor.execute(my_sql)
my_tables = my_cursor.fetchall() #  list
for (tabschema,tablename) in my_tables:
    print(tabschema,tablename)
my_cursor.close()
```

execute()

callproc() to call a stored procedure

executemany() to execute a list of statements

##### Parameters

```
my_sql = """select distinct tabschema, tabname
             from syscat.tables
            where tabschema = ?
              and type = ?;
"""

my_params = ('DB2INST1', 'T') # my_single_tuple = (input_var1, )
my_cursor.execute(my_sql, my_params)
```

##### Result Columns

cursor执行过execute()之后，会返回 description list,ach entry in this list contains the following information items about the column:

- name
- type_code
- display_size
- internal_size
- precision
- scale
- null_ok

```
for column_variable in my_cursor.description:
    column_name = column_variable[0]
    print(column_variable)
```

### Fetching

- `fetchone()` returns a single row or `None` if there are no more rows
- `fetchmany()` returns a set of rows
- `fetchall()` returns all remaining (unfetched) rows ,数据量过大会卡住内存
- `nextset()` allows you to retrieve multiple result sets from a stored procedure

##### Error

There are both `Warning` and `Error` classes. You should wrap your `ibm_db_dbi` function calls in `try/catch` blocks.

```
try:
    my_cursor.execute(my_sql)
except Exception as err:
    print("Error on Execute", err)
```

示例

```python
""" Example program using IBM_DB against Db2"""
import os
import sys
import getpass
import platform
import ibm_db_dbi

# --------------------------------------------------
# Database Connection Settings
# --------------------------------------------------
database = "sample"
hostname = "modi"
userid = "db2inst1"
password = "mypasswd"
port = 50000

connect_string = "ATTACH=FALSE;"
# connect_string += "PROTOCOL=TCPIP;PORT=" + str(port) + ";"

connect_options = { "SQL_ATTR_INFO_PROGRAMNAME": "JHMTESTHELPERS", # 20 char max
                    "SQL_ATTR_INFO_USERID" : getpass.getuser(),    # 255 char max
                    "SQL_ATTR_INFO_WRKSTNNAME" : platform.node()   # 255 char max
                  }
# --------------------------------------------------
hdbi = None  # Connection Object
# --------------------------------------------------

try:
    hdbi = ibm_db_dbi.connect(connect_string,
        host=hostname, database=database,
        user=userid, password=password,
        conn_options=connect_options)
except ibm_db_dbi.Warning as warn:
    print("Connection warning:", warn)
except ibm_db_dbi.Error as err:
    print("connection error:", err)
    sys.exit(1)

if hdbi:
    print("connected")

# --------------------------------------------------
# Query 1
# --------------------------------------------------
print("\nQuery1 begin")

my_sql = """select distinct tabschema, tabname
             from syscat.tables
            where tabschema = 'DB2INST1';
"""

my_cursor = hdbi.cursor()

try:
    my_cursor.execute(my_sql)
except Exception as err:
    print("Error on Execute", err)

try:
    my_tables = my_cursor.fetchall()
except Exception as err:
    print("Error on Fetch", err)

for (tabschema,tablename) in my_tables:
    print(tabschema,tablename)

# --------------------------------------------------
# Query 2
# --------------------------------------------------
print("\nQuery2 begin")

my_sql = """select distinct tabschema, tabname
             from syscat.tables
            where tabschema = ?
              and type = ?;
"""

my_params = ("DB2INST1", "T")
my_cursor.execute(my_sql, my_params)

print("Cursor column descriptions")
for column_variable in my_cursor.description:
    print(column_variable)

column_name1 = my_cursor.description[0][0]
column_name2 = my_cursor.description[1][0]

my_tables = my_cursor.fetchall()

if my_tables:
    print("\n")
    print(column_name1, column_name2)
    for (tabschema,tablename) in my_tables:
        print(tabschema,tablename)

if my_cursor:
    my_cursor.close()

# --------------------------------------------------
# Clean up
# --------------------------------------------------
if hdbi:
    if hdbi.close():
        print("disconnected")

print("done")
```

Ref Resouces

> - IBM_DB API Documentation https://github.com/ibmdb/python-ibmdb/wiki/APIs
> - Python Database API Specification https://www.python.org/dev/peps/pep-0249/
> - IBM Python & Jupyter Samples on Github https://github.com/IBM/db2-python

# db2-samples

> https://github.com/IBM/db2-samples/blob/master/python_samples/Python_Examples/ibm_db_dbi



# 常见python工具

Matplotlib 是 Python 的一个绘图库。可以有效的结合numpy和pandas数据分析包，

Numpy是以矩阵为基础的数学计算模块，纯数学。

Scipy基于Numpy，科学计算库，有一些高阶抽象和物理模型。比方说做个傅立叶变换，这是纯数学的，用Numpy；做个滤波器，这属于信号处理模型了，在Scipy里找。

Pandas提供了一套名为DataFrame的数据结构，比较契合统计分析中的表结构，并且提供了计算接口，可用Numpy或其它方式进行计算。

Jinja 后端模版引擎
saltStack 监控软件

sqlalchemy是一个python语言实现的的针对关系型数据库的orm库。可用于连接大多数常见的数据库，比如Postges、MySQL、SQLite、Oracle等。将你的代码从底层数据库及其相关的SQL特性中抽象出来。两种使用模式，SQL表达式语言（SQLAlchemy Core） 、ORM

 **MATLAB** 是一款由美国The MathWorks公司出品的商业数学软件。MATLAB是一种用于算法开发、数据可视化、数据分析以及数值计算的高级技术计算语言和交互式环境。

Python和MATLAB，谁也淘汰不了谁。**Python写算法，是撸代码的形式；MATLAB Simulink建模型，是拖拽搭积木的形式。 

**MATLAB对各种硬件做了广泛的支持，这些硬件包括各种传感器（摄像头、激光雷达等）、各种工业控制器等等**

另外，有两个应用中，MATLAB是绝对王者。这两个应用便是控制器开发过程中广泛存在的两个环节——快速控制原型和硬件在环仿真。

<p>汽车、航空航天等领域的应用，涉及多个学科，往往需要多个软件联合使用，每个软件各尽所能：MATLAB、AMESim、ADAMS、ANSYS、GT-SUIT等等。与控制、运动学、动力学等相关的软件，几乎所有软件都提供了MATLAB/Simulink的接口，可以与MATLAB/Simulink联合仿真或者互相传输数据。也有不少软件提供了Python的接口，但相比MATLAB/Simulink还是会少一些。</p>



Django大而全，Flask轻量化，在快速开发，容易上手方面，这俩框架都做得不错。再看Tornado，特点在于基于事件循环支持高并发，这就

# flask

Flask 是一个微型的 Python 开发的 Web 框架，基于Werkzeug WSGI工具箱和Jinja2 模板引擎。 Flask使用BSD授权。 Flask也被称为"microframework"，因为它使用简单的核心，用extension增加其他功能。Flask没有默认使用的数据库、窗体验证工具。然而，Flask保留了扩增的弹性，可以用Flask-extension加入这些功能：ORM、窗体验证工具、文件上传、各种开放式身份验证技术。



# Streamlit

为什么会有人做了这么一款神器出来？

原因很简单，咱们前面提到的痛点，是大伙儿都有的。

咱们这些麻瓜（Muggle），遇到痛点只能忍着。

但是真正的魔法师（优秀程序员），是忍不了的。

最大的痛点，就是数据科学家训练好机器学习模型后，需要验证效果，和用户反馈沟通。

但是，做机器学习的工程师本身，并不掌握这一整套的工具栈。所以，就得在把全部的数据分析和模型训练工作完成后，把这东西移交给一个**工具制作团队**(前端或者网页app开发)，数据分析模型更改那么 网页也要重新做网页开发， 

Adrien Treuille 很敏锐地捕捉到了这个长期痛点，于是在 2018 年， 创立了 streamlit 。

// 一般的分析报告 借助python的画图功能，分析报告是静态的。
//更近一步，生成web组件，让报告变成动态的。
// 不适合BI通用工具，大部分客户不会ptyhon 会sql excel函数等，交互页面的设计需要走 前端js 拖拽处理

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/04/0920210409131312.gif)

分布式：rpc ， 消息队列：kafka|pulsar 

Spark 基本上已经成为批处理领域的佼佼者， Flink 成为了低延迟流处理领域的不二选择， Kafka 在消息中间件领域基本上占据了垄断地位。

Kafka is a pure distributed log designed for efficient event streaming at a high scale. RabbitMQ is a traditional messaging system, designed to publish messages quickly and delete them. Pulsar sits somewhere in between. It's not a distributed log in the true sense, but it synthesizes some similar properties.

for lightweight messaging that requires request-response, queuing, and pub-sub RabbitMQ is well suited; Pulsar is really only for the brave at heart, but it may have a place in the future for those that require both queuing and event streaming in the same system; for event streaming use cases that require high throughput, scalability, and permanent message storage Kafka is the clear winner. 



预编译

数据库接受到sql语句之后，需要词法和语义解析，优化sql语句，制定执行计划。这需要花费一些时间。但是很多情况，我们的一条sql语句可能会反复执行，或者`每次执行的时候只有个别的值不同`（比如query的where子句值不同，update的set子句值不同,insert的values值不同）。
 （2）减少编译的方法
 如果每次都需要经过上面的词法语义解析、语句优化、制定执行计划等，则效率就明显不行了。为了解决上面的问题，于是就有了预编译，预编译语句就是将这类语句中的`值用占位符替代`，可以视为将`sql语句模板化或者说参数化`。一次编译、多次运行，省去了解析优化等过程。

预编译是通过PreparedStatement和占位符来实现的。



# SAVEPOINT 回滚点

```
import ibm_db
ibm_db_conn = ibm_db.connect('pydev', 'db2inst1', 'secret')
import ibm_db_dbi
conn = ibm_db_dbi.Connection(ibm_db_conn)
cur = conn.cursor()
cur.execute('SAVEPOINT test ON ROLLBACK RETAIN CURSORS')
cur.execute('RELEASE SAVEPOINT test')
```

```py
cur.execute("select 1 from TEST where IP='%s' and firewall='%s'" % (obj[0], fw_ip[0]))
```

 



# python廖雪峰》

#### Python解释器

### CPython

当我们从[Python官方网站](https://www.python.org/)下载并安装好Python 3.x后，我们就直接获得了一个官方版本的解释器：CPython。这个解释器是用C语言开发的，所以叫CPython。在命令行下运行`python`就是启动CPython解释器。

### IPython

IPython是基于CPython之上的一个交互式解释器，

### PyPy

PyPy是另一个Python解释器，它的目标是执行速度。PyPy采用[JIT技术](http://en.wikipedia.org/wiki/Just-in-time_compilation)，对Python代码进行动态编译（注意不是解释），所以可以显著提高Python代码的执行速度。 

# 基础

```
name = input('please enter your name: ')
print('hello,', name)
# `print()`会依次打印每个字符串，遇到逗号“,”会输出一个空格
```

约定 使用*4个空格*的缩进。

对于很大的数，例如`10000000000`，很难数清楚0的个数。Python允许在数字中间以`_`分隔，因此，写成`10_000_000_000`和`10000000000`是完全一样的。十六进制数也可以写成`0xa1b2_c3d4`。

浮点数也就是小数，之所以称为浮点数，是因为按照科学记数法表示时，一个浮点数的小数点位置是可变的，比如，1.23x109和12.3x108是完全相等的，但是对于很大或很小的浮点数，就必须用科学计数法表示，把10用e替代，1.23x109就是`1.23e9`，或者`12.3e8`，0.000012可以写成`1.2e-5`

整数和浮点数在计算机内部存储的方式是不同的，整数运算永远是精确的（除法难道也是精确的？是的！），而浮点数运算则可能会有四舍五入的误差。

字符串是以单引号`'`或双引号`"`括起来的任意文本，`''`或`""`本身只是一种表示方式，不是字符串的一部分，因此，字符串`'abc'`只有`a`，`b`，`c`这3个字符。如果`'`本身也是一个字符，那就可以用`""`括起来

如果字符串内部既包含`'`又包含`"`怎么办？可以用转义字符`\`来标识 

```
'I\'m \"OK\"!'
```

转义字符`\`可以转义很多字符，比如`\n`表示换行，`\t`表示制表符，字符`\`本身也要转义，所以`\\`表示的字符就是`\`，

如果字符串里面有很多字符都需要转义，就需要加很多`\`，为了简化，Python还允许用`r''`表示`''`内部的字符串默认不转义
如果字符串内部有很多换行，用`\n`写在一行里不好阅读，为了简化，Python允许用`'''...'''`的格式表示多行内容，

在交互式命令行内输入，注意在输入多行内容时，提示符由`>>>`变为`...`，提示你可以接着上一行输入，注意`...`是提示符，不是代码的一部分

在Python中，可以直接用`True`、`False`表示布尔值（请注意大小写），布尔值可以用`and`、`or`和`not`运算。

空值是Python里一个特殊的值，用`None`表示。`None`不能理解为`0`，因为`0`是有意义的，而`None`是一个特殊的空值。

变量本身类型不固定的语言称之为*动态语言*，与之对应的是*静态语言*。静态语言在定义变量时必须指定变量类型，如果赋值的时候类型不匹配，就会报错

```
a = 'ABC'
b = a
a = 'XYZ'
print(b)
```

```
>>> 10 / 3
3.3333333333333335
/除法计算结果是浮点数，即使是两个整数恰好整除，结果也是浮点数：
>>> 9 / 3
3.0
>>> 10 // 3
3
```

### 字符编码

因为计算机只能处理数字，如果要处理文本，就必须先把文本转换为数字才能处理。最早的计算机在设计时采用8个比特（bit）作为一个字节（byte），所以，一个字节能表示的最大的整数就是255（二进制11111111=十进制255），如果要表示更大的整数，就必须用更多的字节。比如两个字节可以表示的最大整数是`65535`，4个字节可以表示的最大整数是`4294967295`。

由于计算机是美国人发明的，因此，最早只有127个字符被编码到计算机里，也就是大小写英文字母、数字和一些符号，这个编码表被称为`ASCII`编码，比如大写字母`A`的编码是`65`，小写字母`z`的编码是`122`。

但是要处理中文显然一个字节是不够的，至少需要两个字节，而且还不能和ASCII编码冲突，所以，中国制定了`GB2312`编码，用来把中文编进去。

Unicode字符集应运而生。Unicode把所有语言都统一到一套编码里，这样就不会再有乱码问题了。

Unicode标准也在不断发展，但最常用的是UCS-16编码，用两个字节表示一个字符（如果要用到非常偏僻的字符，就需要4个字节）。现代操作系统和大多数编程语言都直接支持Unicode。

如果统一成Unicode编码，乱码问题从此消失了。但是，如果你写的文本基本上全部是英文的话，用Unicode编码比ASCII编码需要多一倍的存储空间，在存储和传输上就十分不划算。

所以，本着节约的精神，又出现了把Unicode编码转化为“可变长编码”的`UTF-8`编码。UTF-8编码把一个Unicode字符根据不同的数字大小编码成1-6个字节，常用的英文字母被编码成1个字节，汉字通常是3个字节，只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符，用UTF-8编码就能节省空间：

在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。

`ord()`函数获取字符的整数表示，`chr()`函数把编码转换为对应的字符

```
>>> ord('中')
20013
>>> chr(66)
'B'
```

```
>>> '\u4e2d\u6587'
'中文'
字符和十六进制编码 两种形式等价
```

Python的字符串类型是`str`，在内存中以Unicode表示，一个字符对应若干个字节。如果要在网络上传输，或者保存到磁盘上，就需要把`str`变为以字节为单位的`bytes`。**`bytes`的每个字符都只占用一个字节**

`bytes`类型的数据用带`b`前缀的单引号或双引号 x = b'ABC'

以Unicode表示的`str`通过`encode()`方法可以编码为指定的`bytes`，

```
>>> 'ABC'.encode('ascii')
b'ABC'
>>> '中文'.encode('utf-8')
b'\xe4\xb8\xad\xe6\x96\x87'
>>> b'ABC'.decode('ascii')
'ABC'
```

`len()`函数计算的是`str`的字符数，如果换成`bytes`，`len()`函数就计算字节数

```
>>> len('ABC')
3
>>> len('中文')
2
>>> len('中文'.encode('utf-8'))
6
```

`%`运算符就是用来格式化字符串的

```
%d	整数
%f	浮点数
%s	字符串
%x	十六进制整数

print('%2d-%02d' % (3, 1))
print('%.2f' % 3.1415926

>>> 'Hello, {0}, 成绩提升了 {1:.1f}%'.format('小明', 17.125)

>>> r = 2.5
>>> s = 3.14 * r ** 2
>>> print(f'The area of a circle with radius {r} is {s:.2f}')
```

### **list**

```
>>> classmates = ['Michael', 'Bob', 'Tracy']
>>> len(classmates)
>>> classmates.append('Adam')
>>> classmates.insert(1, 'Jack')
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy', 'Adam']
>>> classmates.pop() #删除末尾元素
'Adam'
>>> classmates
['Michael', 'Jack', 'Bob', 'Tracy']

>>> classmates[1] = 'Sarah' # 修改
```

可以用`-1`做索引，直接获取最后一个元素

删除指定位置的元素，用`pop(i)`方法，其中`i`是索引位置：

list里面的元素的数据类型也可以不同，比如：

```
>>> L = ['Apple', 123, True]
>>> s = ['python', 'java', ['asp', 'php'], 'scheme'] #包含另外一个list
>>> p = ['asp', 'php'] 
>>> s = ['python', 'java', p, 'scheme'] # 拆开表示更直观，
```

### tuple

另一种有序列表叫元组：tuple。tuple和list非常类似，但是tuple一旦初始化就不能修改

```
>>> classmates = ('Michael', 'Bob', 'Tracy')
```

你可以正常地使用`classmates[0]`，`classmates[-1]`，但不能赋值成另外的元素。

只有1个元素的tuple定义时必须加一个逗号`,`，来消除歧义：因为括号`()`既可以表示tuple，又可以表示数学公式中的小括号，

```
>>> t = (1,)
```

tuple的底层元素修改

```
>>> t = ('a', 'b', ['A', 'B'])
>>> t[2][0] = 'X'
>>> t[2][1] = 'Y'
>>> t
('a', 'b', ['X', 'Y'])
```

tuple所谓的“不变”是说，tuple的每个元素，指向永远不变。即指向`'a'`，就不能改成指向`'b'`，指向一个list，就不能改成指向其他对象，但指向的这个list本身是可变的！

### 条件判断

```
age = 3
if age >= 18:
    print('adult')
elif age >= 6:  # elif是else if的缩写
    print('teenager')
else:
    print('kid')
```

```
if x:
    print('True')
```

只要`x`是非零数值、非空字符串、非空list等，就判断为`True`，否则为`False`。 

```
s = input('birth: ')
birth = int(s)
```

### 循环

Python的循环有两种，一种是for...in循环，依次把list或tuple中的每个元素迭代出来

```
for name in names:
```

第二种循环是while循环

### dict

Python内置了字典：dict的支持，dict全称dictionary，在其他语言中也称为map，使用键-值（key-value）存储，具有极快的查找速度。

```
>>> d = {'Michael': 95, 'Bob': 75, 'Tracy': 85}
>>> d['Michael']
```

如果key不存在，dict就会报错：一是通过`in`判断key是否存在：

```
>>> 'Thomas' in d
False
```

二是通过dict提供的`get()`方法，如果key不存在，可以返回`None`，或者自己指定的value

```
>>> d.get('Thomas')
>>> d.get('Thomas', -1)
-1
```

注意：返回`None`的时候Python的交互环境不显示结果。

```
>>> d.pop('Bob')
75
```

和list比较，dict有以下几个特点：

1. 查找和插入的速度极快，不会随着key的增加而变慢；
2. 需要占用大量的内存，内存浪费多。

而list相反：

1. 查找和插入的时间随着元素的增加而增加；
2. 占用空间小，浪费内存很少。

dict的key必须是**不可变对象**。这个通过key计算位置的算法称为哈希算法（Hash）。  

### SET

重复元素在set中自动被过滤：

```
>>> s = set([1, 1, 2, 2, 3, 3])
>>> s
{1, 2, 3}
```

`add(key)` remove(key) 

set可以看成数学意义上的无序和无重复元素的集合，set1 & set2 与,交集
set1 | set2  或,并集

### 不可变对象

str是不变对象，而list是可变对象

对list进行操作，list内部的内容是会变化的

对于可变对象，比如list，对list进行操作，list内部的内容是会变化的，比如：

```
>>> a = ['c', 'b', 'a']
>>> a.sort()
>>> a
['a', 'b', 'c']
```

而对于不可变对象，比如str，对str进行操作呢：

```
>>> a = 'abc'
>>> a.replace('a', 'A')
'Abc'
>>> a
'abc'
```

虽然字符串有个`replace()`方法，也确实变出了`'Abc'`，但变量`a`最后仍是`'abc'`，`replace`方法创建了一个新字符串`'Abc'`并返回

# 函数

```
>>> abs(-20)
>>> max(2, 3, 1, -5)
>>> int('123')
>>> str(1.23)
>>> bool(1)
True
>>> bool('')
False
```

 [Built-in Functions](https://docs.python.org/3/library/functions.html)

```
def nop():
    pass
# 空函数 pass语句什么都不做，pass可以用来作为占位符，比如现在还没想好怎么写函数的代码，就可以先放一个pass，让代码能运行起来
```

```
def my_abs(x):
    if not isinstance(x, (int, float)):
        raise TypeError('bad operand type')
    if x >= 0:
        return x
    else:
        return -x
```

### 返回多个值

原来返回值是一个tuple！但是，在语法上，返回一个tuple可以省略括号，而多个变量可以同时接收一个tuple，按位置赋给对应的值，所以，Python的函数返回多值其实就是返回一个tuple，但写起来更方便。

```
def move(x, y, step, angle=0): 
    return nx, ny
    
>>> x, y = move(100, 100, 60, math.pi / 6)
>>> print(x, y)

>>> r = move(100, 100, 60, math.pi / 6)
>>> print(r)
(151.96152422706632, 70.0)
```

```
a,b = 1,2
```

默认参数 def power(x, n=2)



```
def add_end(L=[]):
    L.append('END')
    return L
>>> add_end()
['END']
>>> add_end()
['END', 'END'] 
```

Python函数在定义的时候，默认参数`L`的值就被计算出来了，即`[]`，因为默认参数`L`也是一个变量，它指向对象`[]`，每次调用该函数，如果改变了`L`的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的`[]`了。

默认参数必须指向不变对象！

```
def add_end(L=None):
    if L is None:
        L = []
    L.append('END')
    return L
```

为什么要设计`str`、`None`这样的不变对象呢？因为不变对象一旦创建，对象内部的数据就不能修改，这样就减少了由于修改数据导致的错误。此外，由于对象不变，多任务环境下同时读取对象不需要加锁，同时读一点问题都没有。我们在编写程序时，如果可以设计一个不变对象，那就尽量设计成不变对象。

### 可变参数

可变参数就是传入的参数个数是可变的，

```
def calc(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
```

```
>>> calc(1, 2)
5
```

可变参数 仅仅在参数前面加了一个`*`号。在函数内部，参数`numbers`接收到的是一个tuple

```
>>> nums = [1, 2, 3]
>>> calc(*nums)
```

可变参数允许你传入0个或任意个参数，这些可变参数在函数调用时自动组装为一个tuple。

**关键字参数**允许你传入0个或任意个含参数名的参数，这些关键字参数在函数内部自动组装为一个dict

```
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
>>> person('Michael', 30)
name: Michael age: 30 other: {}
>>> person('Adam', 45, gender='M', job='Engineer')
name: Adam age: 45 other: {'gender': 'M', 'job': 'Engineer'}
```

可以扩展函数的功能。例如：用户注册的功能，除了用户名和年龄是必填项外，其他都是可选项，利用关键字参数来定义这个函数就能满足注册的需求。

```
>>> extra = {'city': 'Beijing', 'job': 'Engineer'}
>>> person('Jack', 24, **extra)
```

### 命名关键字参数

如果要限制关键字参数的名字，就可以用命名关键字参数

```
def person(name, age, *, city='Beijing', job):
	# 由于命名关键字参数city具有默认值，调用时，可不传入city参数
    print(name, age, city, job)
```

和关键字参数`**kw`不同，命名关键字参数需要一个特殊分隔符`*`，`*`后面的参数被视为命名关键字参数。

```
>>> person('Jack', 24, city='Beijing', job='Engineer') #命名关键字参数必须传入参数名
```

如果函数定义中已经有了一个可变参数，后面跟着的命名关键字参数就不再需要一个特殊分隔符`*`了：

```
def person(name, age, *args, city, job):
    print(name, age, args, city, job)
```

### 参数组合

参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数。

#### 递归函数

一个函数在内部调用自身本身，这个函数就是递归函数。

```
def fact(n):
    if n==1:
        return 1
    return n * fact(n - 1)
```

所有的递归函数都可以写成循环的方式，但循环的逻辑不如递归清晰。

使用递归函数需要注意防止栈溢出。在计算机中，函数调用是通过栈（stack）这种数据结构实现的，每当进入一个函数调用，栈就会加一层栈帧，每当函数返回，栈就会减一层栈帧。由于栈的大小不是无限的，所以，递归调用的次数过多，会导致栈溢出。可以试试`fact(1000)`：

解决递归调用栈溢出的方法是通过**尾递归**优化，事实上尾递归和循环的效果是一样的，

尾递归是指，在函数返回的时候，调用自身本身，并且，return语句不能包含表达式。这样，编译器或者解释器就可以把尾递归做优化，使递归本身无论调用多少次，都只占用一个栈帧，不会出现栈溢出的情况。

```
def fact(n):
    return fact_iter(n, 1)

def fact_iter(num, product):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product)
```

# 高级特性

#### 切片

```
>>> L = ['Michael', 'Sarah', 'Tracy', 'Bob', 'Jack']
>>> L[:3]
>>> L[-2:-1]

>>> L = list(range(100))

```





















































