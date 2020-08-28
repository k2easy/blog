# [get-started](https://docs.docker.com/get-started/)

install docker desktop

```
docker --version

git clone https://github.com/dockersamples/node-bulletin-board
cd node-bulletin-board/bulletin-board-app

docker build --tag bulletinboard:1.0 .

docker run --publish 8000:8080 --detach --name bb bulletinboard:1.0

--publish ,外部8000端口请求转发到容器8080端口，默认容器防火墙阻止所有请求
--detach , run in background
--name 别名

localhost:8000

docker rm --force bb 
--force stop

```



# Docker 国内仓库和镜像

> 由于网络原因，我们在pull Image 的时候，从Docker Hub上下载会很慢。。。所以，国内的Docker爱好者们就添加了一些国内的镜像（mirror）,方便大家使用。

[镜像加速器](https://yeasy.gitbook.io/docker_practice/install/mirror)

对于使用 macOS 的用户，在任务栏点击 Docker Desktop 应用图标 -> `Perferences`，在左侧导航菜单选择 `Docker Engine`，在右侧像下边一样编辑 json 文件。修改完成之后，点击 `Apply & Restart` 按钮，

```
{
  "registry-mirrors": [
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}
$ docker info
```



# Dockerfile

```


# Use the official image as a parent image.
FROM node:current-slim

# Set the working directory.
WORKDIR /usr/src/app

# Copy the file from your host to your current location.
COPY package.json .

# Run the command inside your image filesystem.
RUN npm install

# Add metadata to the image to describe which port the container is listening on at runtime.
EXPOSE 8080

# Run the specified command within the container.
CMD [ "npm", "start" ]

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

```



为什么单独复制 package.json
Docker creates layers for each command COPY/ADD,In build time docker will see to the changes, if in some layer will detected change all below layers will be rebuild. 
只有package.json改变才会执行 npm install.执行一次。
如果 先copy . . 再 npm install,那么每次编辑src文件后都会执行一次 npm install ，耗时久。



# [resouces](https://docs.docker.com/get-started/resources/)

# Develop with Docker



# [《docker从入门到实践》](https://yeasy.gitbook.io/docker_practice/)

# 基本概念

**镜像**

操作系统分为内核和用户空间。对于 Linux 而言，内核启动后，会挂载 `root` 文件系统为其提供用户空间支持。而 Docker 镜像（Image），就相当于是一个 `root` 文件系统。

Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数（如匿名卷、环境变量、用户等）。镜像不包含任何动态数据，其内容在构建之后也不会被改变。

**分层存储**

 Docker 利用 [Union FS](https://en.wikipedia.org/wiki/Union_mount) 的技术，将其设计为分层存储的架构。 镜像并非是像一个 ISO 那样的打包文件，镜像只是一个虚拟的概念，其实际体现并非由一个文件组成，而是由一组文件系统组成

镜像构建时，会一层层构建，前一层是后一层的基础。每一层构建完就不会再发生改变，后一层上的任何改变只发生在自己这一层。比如，删除前一层文件的操作，实际不是真的删除前一层的文件，而是仅在当前层标记为该文件已删除。

在构建镜像的时候，需要额外小心，每一层尽量只包含该层需要添加的东西，任何额外的东西应该在该层构建结束前清理掉。

分层存储的特征还使得镜像的复用、定制变的更为容易。



**容器**

镜像（`Image`）和容器（`Container`）的关系，就像是面向对象程序设计中的 `类` 和 `实例` 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。

容器的实质是进程，但与直接在宿主执行的进程不同，容器进程运行于属于自己的独立的 [命名空间](https://en.wikipedia.org/wiki/Linux_namespaces)。因此容器可以拥有自己的 `root` 文件系统、自己的网络配置、自己的进程空间，甚至自己的用户 ID 空间。容器内的进程是运行在一个隔离的环境里，使用起来，就好像是在一个独立于宿主的系统下操作一样。这种特性使得容器封装的应用比直接在宿主运行更加安全。

镜像使用的是分层存储，容器也是如此。每一个容器运行时，是以镜像为基础层，在其上创建一个当前容器的存储层，我们可以称这个为容器运行时读写而准备的存储层为 **容器存储层**。

容器存储层的生存周期和容器一样，容器消亡时，容器存储层也随之消亡。因此，任何保存于容器存储层的信息都会随容器删除而丢失。

按照 Docker 最佳实践的要求，容器不应该向其存储层内写入任何数据，容器存储层要保持无状态化。所有的文件写入操作，都应该使用 [数据卷（Volume）]()、或者绑定宿主目录，在这些位置的读写会跳过容器存储层，直接对宿主（或网络存储）发生读写，其性能和稳定性更高。

**仓库**

如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，[Docker Registry]() 就是这样的服务

一个 **Docker Registry** 中可以包含多个 **仓库**（`Repository`）；每个仓库可以包含多个 **标签**（`Tag`）；每个标签对应一个镜像。

```
ubuntu:18.04 具体指定所需哪个版本的镜像。如果忽略了标签，比如 `ubuntu`，那将视为 `ubuntu:latest
```

仓库名经常以 *两段式路径* 形式出现，比如 `jwilder/nginx-proxy`

官方的 [Docker Hub](https://hub.docker.com/)，Red Hat 的 [Quay.io](https://quay.io/repository/)；Google 的 [Google Container Registry](https://cloud.google.com/container-registry/)，[Kubernetes](https://kubernetes.io/) 的镜像使用的就是这个服务。

直接从国内的地址下载 Docker Hub 的镜像，比直接从 Docker Hub 下载速度会提高很多

搭建私有 Docker Registry。Docker 官方提供了 [Docker Registry](https://hub.docker.com/_/registry/) 镜像，可以直接使用做为私有 Registry 服务。

# 使用镜像

## 获取镜像

```
docker pull [选项] [Docker Registry 地址[:端口号]/]仓库名[:标签]
docker pull --help
$ docker pull ubuntu:18.04
```

默认地址是 Docker Hub。
仓库名 <用户名>/<软件名> ，对于 Docker Hub，如果不给出用户名，则默认为 `library`，也就是官方镜像。

```
docker run -it --remove \
 ubuntu:18.04 \
 bash 
```

`-i`：交互式操作，一个是 `-t` 终端

`--rm`：容器退出后随之将其删除

放在镜像名后的是 **命令**

```
cat /etc/os-release  # 查看当前系统版本的命令
exit
```

> Debian is the rock on which Ubuntu is built

## 列出镜像

```
docker image ls
```

镜像 ID 则是镜像的唯一标识，一个镜像可以对应多个 标签。

Docker Hub 中显示的体积是压缩后的体积。在镜像下载和上传过程中镜像是保持着压缩状态的

`docker image ls` 显示的是镜像下载到本地后，展开的大小，准确说，是展开后的各层所占空间的总和。

列表中的镜像体积总和并非是所有镜像实际硬盘消耗。由于 Docker 镜像是多层存储结构，并且可以继承、复用，因此不同镜像可能会因为使用相同的基础镜像，从而拥有共同的层。由于 Docker 使用 Union FS，相同的层只需要保存一份即可，因此实际镜像硬盘占用空间很可能要比这个列表镜像大小的总和要小的多。

```
docker system df # 查看镜像、容器、数据卷所占用的空间
```

**虚悬镜像(dangling image)** 

```
$ docker image ls -f dangling=true
```

有些镜像既没有仓库名，也没有标签，均为 `<none>`，垃圾镜像文件。

例如：随着官方镜像维护，发布了新版本后，重新 `docker pull mongo:3.2` 时，`mongo:3.2` 这个镜像名被转移到了新下载的镜像身上，而旧的镜像上的这个名称则被取消，从而成为了 `<none>`

```
$ docker image prune # 虚悬镜像已经失去了存在的价值，是可以随意删除
```



**中间层镜像**

为了加速镜像构建、重复利用资源，Docker 会利用 **中间层镜像**

默认的 `docker image ls` 列表中只会显示顶层镜像，-a 显示包括中间层镜像在内的所有镜像

这些无标签的中间层镜像是其他顶层镜像的依赖，相同的层只会存一遍，不需要关心。只要删除那些依赖它们的镜像后，这些依赖的中间层镜像也会被连带删除。

```
$ docker image ls ubuntu
$ docker image ls -f since=mongo:3.2 # filter
$ docker image ls -f label=com.example.version=0.1
```

## **删除镜像**

```
$ docker image rm [选项] <镜像1> [<镜像2> ...]
<镜像> 可以是 镜像短 ID、镜像长 ID、镜像名 或者 镜像摘要
```



## 利用 commit 理解镜像构成

```
docker run --name webserver -d  -p 80:80 nginx
访问localhost
修改欢迎页面
docker exec -it webserver bash 
echo "hello,docker" > /usr/share/ngix/html/index.html
exit
再刷新浏览器的话，会发现内容被改变了。
```

我们修改了容器的文件，也就是改动了容器的存储层。我们可以通过 `docker diff` 命令看到具体的改动。

Docker 提供了一个 `docker commit` 命令，可以在原有镜像的基础上，再叠加上容器的存储层，并构成新的镜像。

```
docker commit [选项] <容器ID或容器名> [<仓库名>[:<标签>]]
```

```
$ docker commit \
    --author "Tao Wang <twang2218@gmail.com>" \
    --message "修改了默认网页" \
    webserver \
    nginx:v2
docker image ls nginx 
docker run --name web2 -d -p 81:80 nginx:v2
```

**慎用 `docker commit`**

`docker commit` 意味着所有对镜像的操作都是黑箱操作，生成的镜像也被称为 **黑箱镜像**，换句话说，就是除了制作镜像的人知道执行过什么命令、怎么生成的镜像，别人根本无从得知。而且，即使是这个制作镜像的人，过一段时间后也无法记清具体的操作。这种黑箱镜像的维护工作是非常痛苦的。

如果使用 `docker commit` 制作镜像，以及后期修改的话，每一次修改都会让镜像更加臃肿一次，所删除的上一层的东西并不会丢失，会一直如影随形的跟着这个镜像，即使根本无法访问到。这会让镜像更加臃肿。



## 使用 Dockerfile 定制镜像

每一行是一条指令，每一条指令构建一层

```
$ mkdir mynginx
$ cd mynginx
$ touch Dockerfile
```

```
FROM nginx
RUN echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
```

`FROM` 就是指定 **基础镜像**，因此一个 `Dockerfile` 中 `FROM` 是必备的指令，并且必须是第一条指令。

如 [`nginx`](https://hub.docker.com/_/nginx/)、[`redis`](https://hub.docker.com/_/redis/)、[`mongo`](https://hub.docker.com/_/mongo/)、[`mysql`](https://hub.docker.com/_/mysql/)、[`httpd`](https://hub.docker.com/_/httpd/)、[`php`](https://hub.docker.com/_/php/)、[`tomcat`](https://hub.docker.com/_/tomcat/) 等；也有一些方便开发、构建、运行各种语言应用的镜像，如 [`node`](https://hub.docker.com/_/node)、[`openjdk`](https://hub.docker.com/_/openjdk/)、[`python`](https://hub.docker.com/_/python/)、[`ruby`](https://hub.docker.com/_/ruby/)、[`golang`](https://hub.docker.com/_/golang/) 等。如 [`ubuntu`](https://hub.docker.com/_/ubuntu/)、[`debian`](https://hub.docker.com/_/debian/)、[`centos`](https://hub.docker.com/_/centos/)、[`fedora`](https://hub.docker.com/_/fedora/)、[`alpine`](https://hub.docker.com/_/alpine/) 等

```
FROM scratch 
# 虚拟概念，并不实际存在，表示一个空白的镜像
```

对于 Linux 下静态编译的程序来说，并不需要有操作系统提供运行时支持，所需的一切库都已经在可执行文件里了，因此直接 `FROM scratch` 会让镜像体积更加小巧。使用 [Go 语言](https://golang.org/) 开发的应用很多会使用这种方式来制作镜像，这也是为什么有人认为 Go 是特别适合容器微服务架构的语言的原因之一。



**RUN 执行命令**

*shell* 格式：`RUN <命令>`，就像直接在命令行中输入的命令一样

*exec* 格式：`RUN ["可执行文件", "参数1", "参数2"]`，这更像是函数调用中的格式。

Union FS 是有最大层数限制的，不得超过 127 层。

在撰写 Dockerfile 的时候，要经常提醒自己，这并不是在写 Shell 脚本，而是在定义每一层该如何构建。

Dockerfile 支持 Shell 类的行尾添加 `\` 的命令换行方式，以及行首 `#` 进行注释的格式。

每一层只添加真正需要添加的东西，任何无关的东西都应该清理掉。

```
FROM debian:stretch

RUN apt-get update
RUN apt-get install -y gcc libc6-dev make wget
RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
RUN mkdir -p /usr/src/redis
RUN tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1
RUN make -C /usr/src/redis
RUN make -C /usr/src/redis install
```

```
FROM debian:stretch

RUN buildDeps='gcc libc6-dev make wget' \
    && apt-get update \
    && apt-get install -y $buildDeps \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && make -C /usr/src/redis \
    && make -C /usr/src/redis install \
    && rm -rf /var/lib/apt/lists/* \
    && rm redis.tar.gz \
    && rm -r /usr/src/redis \
    && apt-get purge -y --auto-remove $buildDeps
 # purge 清理
```



在 `Dockerfile` 文件所在目录执行：

```
$ docker build -t nginx:v3 .
Sending build context to Docker daemon 2.048 kB
...
```

 `.`  是在指定上下文的目录，`docker build` 命令会将该目录下的内容打包交给 Docker 引擎以帮助构建镜像。

**直接用 Git repo 进行构建**

```
$ docker build https://github.com/twang2218/gitlab-ce-zh.git#:11.1

Sending build context to Docker daemon 2.048 kB
Step 1 : FROM gitlab/gitlab-ce:11.1.0-ce.0
11.1.0-ce.0: Pulling from gitlab/gitlab-ce
```

## Dockerfile 指令详解

### COPY

```
COPY [--chown=<user>:<group>] <源路径>... <目标路径>
COPY [--chown=<user>:<group>] ["<源路径1>",... "<目标路径>"]
```

`<目标路径>` 可以是容器内的绝对路径，也可以是相对于工作目录的相对路径（工作目录可以用 `WORKDIR` 指令来指定）。目标路径不需要事先创建，如果目录不存在会在复制文件前先行创建缺失目录。

```
COPY package.json /usr/src/app/
COPY hom* /mydir/
COPY hom?.txt /mydir/
```



### ADD

所有的文件复制均使用 `COPY` 指令，仅在需要自动解压缩的场合使用 `ADD`。

```
FROM scratch
ADD ubuntu-xenial-core-cloudimg-amd64-root.tar.gz /

--chown=<user>:<group>
```



**CMD 容器启动命令**

Docker 不是虚拟机，容器就是进程。既然是进程，那么在启动容器的时候，需要指定所运行的程序及参数。

`CMD` 指令就是用于指定默认的容器主进程的启动命令的。

```
shell` 格式：`CMD <命令>
exec` 格式：`CMD ["可执行文件", "参数1", "参数2"...]
```

参数列表格式：`CMD ["参数1", "参数2"...]`。在指定了 `ENTRYPOINT` 指令后，用 `CMD` 指定具体的参数。



> ubuntu` 镜像默认的 `CMD` 是 `/bin/bash`，如果我们直接 `docker run -it ubuntu` 的话，会直接进入 `bash

在运行时可以指定新的命令来替代镜像设置中的这个默认命令，

```
docker run -it ubuntu cat /etc/os-release
```

**推荐使用 `exec` 格式**，这类格式在解析时会被解析为 JSON 数组，因此一定要使用双引号 `"`

Docker 不是虚拟机，容器中的应用都应该以前台执行，而不是像虚拟机、物理机里面那样，用 `systemd` 去启动后台服务，容器内没有后台服务的概念。



对于容器而言，其启动程序就是容器应用进程，容器就是为了主进程而存在的，主进程退出，容器就失去了存在的意义，从而退出，其它辅助进程不是它需要关心的东西。



```
CMD service nginx start
# 使用 service nginx start 命令，则是希望 upstart 来以后台守护进程形式启动 nginx 服务
```

会发现容器执行后就立即退出。

sh -c command 

`CMD service nginx start` 会被理解为 `CMD [ "sh", "-c", "service nginx start"]`，因此主进程实际上是 `sh`。那么当 `service nginx start` 命令结束后，`sh` 也就结束了，`sh` 作为主进程退出了，自然就会令容器退出。

正确的做法是直接执行 `nginx` 可执行文件，并且要求以前台形式运行。

CMD ["nginx", "-g", "daemon off;"]



### ENTRYPOINT 入口点

`ENTRYPOINT` 的目的和 `CMD` 一样，都是在指定容器启动程序及参数。

`ENTRYPOINT` 在运行时也可以替代， docker run  `--entrypoint` 来指定。

当指定了 `ENTRYPOINT` 后，`CMD` 的含义就发生了改变，不再是直接的运行其命令，而是**将 `CMD` 的内容作为参数传给 `ENTRYPOINT` 指令**.

<ENTRYPOINT> "<CMD>"

**场景一：让镜像变成像命令一样使用**

```
FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*
CMD [ "curl", "-s", "http://ip.cn" ]

$ docker run myip
当前 IP：61.148.226.66 来自：北京市 联通

希望显示 HTTP 头信息，就需要加上 -i 参数。那么我们可以直接加 -i 参数给 docker run myip 么？
$ docker run myip -i
docker: Error response from daemon: executable file not found

跟在镜像名后面的是 command，运行时会替换 CMD 的默认值。因此这里的 -i 替换了原来的 CMD，而不是添加在原来的 curl -s http://ip.cn 后面。而 -i 根本不是命令，所以自然找不到。

$ docker run myip curl -s http://ip.cn -i 
重新完整的输入这个命令,显然不是很好的解决方案. 
```

```
FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y curl \
    && rm -rf /var/lib/apt/lists/*
ENTRYPOINT [ "curl", "-s", "http://ip.cn" ]

$ docker run myip -i
```

当存在 `ENTRYPOINT` 后，`CMD` 的内容将会作为参数传给 `ENTRYPOINT`，而这里 `-i` 就是新的 `CMD`，因此会作为参数传给 `curl`，从而达到了我们预期的效果。

**场景二：应用运行前的准备工作**

启动容器就是启动主进程，但有些时候，启动主进程前，需要一些准备工作。

比如 `mysql` 类的数据库，可能需要一些数据库配置、初始化的工作，这些工作要在最终的 mysql 服务器运行之前解决。

比如  避免使用root启动服务，在启动服务前还需要以 `root` 身份执行一些必要的准备工作，最后切换到服务用户身份启动服务

这些准备工作是和容器 `CMD` 无关的，无论 `CMD` 为什么，都需要事先进行一个预处理的工作。这种情况下，可以写一个脚本，然后放入 `ENTRYPOINT` 中去执行，而这个脚本会将接到的参数（也就是 `<CMD>`）作为命令，在脚本最后执行。比如官方镜像 `redis` 中就是这么做的：

```
FROM alpine:3.4
...
RUN addgroup -S redis  &&  adduser -S -G redis redis 
...
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
```



> #!/bin/sh #!/bin/bash 区别
>
> `bash` and `sh` are two different shells. Basically `bash` is `sh`, with more features and better syntax. Most commands work the same, but they are different.  

```
#!/bin/sh 
...
# allow the conainer to be started  wtih --user
if ["$1" = 'redis-server' -a "$(id -u)" = '0' ];then
	chown -R redis .
	exec su-exec redis "$0" "$@"
fi

exec "$@"
```

该脚本的内容就是根据 `CMD` 的内容来判断，如果是 `redis-server` 的话，则切换到 `redis` 用户身份启动服务器，否则依旧使用 `root` 身份执行。比如：

```
$ docker run -it redis id
uid=0(root) gid=0(root) groups=0(root)
```



### ENV 设置环境变量

```
ENV <key> <value>
ENV <key1>=<value1> <key2>=<value2>...
```

```
ENV VERSION=1.0 DEBUG=on \
    NAME="Happy Feet"
```

```
ENV NODE_VERSION 7.2.0
```



### ARG 构建参数

### VOLUME 定义匿名卷

```
VOLUME ["<路径1>", "<路径2>"...]
VOLUME <路径>
```

为了防止运行时用户忘记将动态文件所保存目录挂载为卷，在 `Dockerfile` 中，我们可以事先指定某些目录挂载为匿名卷，这样在运行时如果用户不指定挂载，其应用也可以正常运行，不会向容器存储层写入大量数据。

```
VOLUME /data
```

 `/data` 目录就会在运行时自动挂载为匿名卷，任何向 `/data` 中写入的信息都不会记录进容器存储层，从而保证了容器存储层的无状态化。当然，运行时可以覆盖这个挂载设置

```
docker run -d -v mydata:/data xxxx
```

### EXPOSE 暴露端口

```
EXPOSE <端口1> [<端口2>...]
```

声明运行时容器提供服务端口，这只是一个声明，在运行时并不会因为这个声明应用就会开启这个端口的服务

方便 ，一个是帮助镜像使用者理解这个镜像服务的守护端口，以方便配置映射；另一个用处则是在运行时使用随机端口映射时，也就是 `docker run -P` 时，会自动随机映射 `EXPOSE` 的端口。

### WORKDIR 指定工作目录

`WORKDIR` 指令可以来指定工作目录（或者称为当前目录），如该目录不存在，`WORKDIR` 会帮你建立目录。

初学者常犯的错误是把 `Dockerfile` 等同于 Shell 脚本来书写，如下。

```
RUN cd /app
RUN echo "hello" > world.txt
```

如果将这个 `Dockerfile` 进行构建镜像运行后，会发现找不到 `/app/world.txt` 文件，或者其内容不是 `hello`。原因其实很简单，在 Shell 中，连续两行是同一个进程执行环境，因此前一个命令修改的内存状态，会直接影响后一个命令；而在 `Dockerfile` 中，这两行 `RUN` 命令的执行环境根本不同，是两个完全不同的容器。这就是对 `Dockerfile` 构建分层存储的概念不了解所导致的错误。

每一个 `RUN` 都是启动一个容器、执行命令、然后提交存储层文件变更。第一层 `RUN cd /app` 的执行仅仅是当前进程的工作目录变更，一个内存上的变化而已，其结果不会造成任何文件变更。而到第二层的时候，启动的是一个全新的容器，跟第一层的容器更完全没关系，自然不可能继承前一层构建过程中的内存变化。

因此如果需要改变以后各层的工作目录的位置，那么应该使用 `WORKDIR` 指令



### USER 指定当前用户

USER <用户名>[:<用户组>]

`USER` 指令和 `WORKDIR` 相似，都是改变环境状态并影响以后的层。`WORKDIR` 是改变工作目录，`USER` 则是改变之后层的执行 `RUN`, `CMD` 以及 `ENTRYPOINT` 这类命令的身份。

如果以 `root` 执行的脚本，在执行期间希望改变身份，比如希望以某个已经建立好的用户来运行某个服务进程，不要使用 `su` 或者 `sudo`，这些都需要比较麻烦的配置，而且在 TTY 缺失的环境下经常出错。建议使用 [`gosu`](https://github.com/tianon/gosu)。

```
# 建立 redis 用户，并使用 gosu 换另一个用户执行命令
RUN groupadd -r redis && useradd -r -g redis redis
# 下载 gosu
RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true
# 设置 CMD，并以另外的用户执行
CMD [ "exec", "gosu", "redis", "redis-server" ]
```



### HEALTHCHECK 健康检查

`HEALTHCHECK` 指令是告诉 Docker 应该如何进行判断容器的状态是否正常，

`HEALTHCHECK [选项] CMD <命令>`：设置检查容器健康状况的命令

`HEALTHCHECK NONE`：如果基础镜像有健康检查指令，使用这行可以屏蔽掉其健康检查指令

检查：如果程序进入死锁状态，或者死循环状态，部分容器已经无法提供服务了却还在接受用户请求。



当在一个镜像指定了 `HEALTHCHECK` 指令后，用其启动容器，初始状态会为 `starting`，在 `HEALTHCHECK` 指令检查成功后变为 `healthy`，如果连续一定次数失败，则会变为 `unhealthy`。

返回值决定了该次健康检查的成功与否：`0`：成功；`1`：失败

```
FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s \
  CMD curl -fs http://localhost/ || exit 1
```

`--interval=<间隔>`：两次健康检查的间隔，默认为 30 秒；

`--timeout=<时长>`：健康检查命令运行超时时间，如果超过这个时间，本次健康检查就被视为失败，默认 30 秒；

`--retries=<次数>`：当连续失败指定次数后，则将容器状态视为 `unhealthy`，默认 3 次。

`docker container ls` 查看容器状态

为了帮助排障，健康检查命令的输出（包括 `stdout` 以及 `stderr`）都会被存储于健康状态里，可以用 `docker inspect` 来查看。

```
$ docker inspect --format '{{json .State.Health}}' web | python -m json.tool
```



### ONBUILD

```
ONBUILD <其它指令>
```

其它指令都是为了定制当前镜像而准备的，唯有 `ONBUILD` 是为了帮助别人定制自己而准备的。

其他指令，在当前镜像构建时并不会被执行。只有当以当前镜像为基础镜像，去构建下一级镜像的时候才会被执行。

```
FROM node:slim
RUN mkdir /app
WORKDIR /app
COPY ./package.json /app
RUN [ "npm", "install" ]
COPY . /app/
CMD [ "npm", "start" ]
```

类似的node.js 项目共用一个基础镜像 docker build -t my-node ,避免多次修改。

```
FROM node:slim
RUN mkdir /app
WORKDIR /app
ONBUILD COPY ./package.json /app
ONBUILD RUN [ "npm", "install" ]
ONBUILD COPY . /app/
CMD [ "npm", "start" ]
```

 `ONBUILD`，这样在构建基础镜像的时候，这三行并不会被执行

各个项目

```
FROM my-node
```

在各个项目目录中，用这个只有一行的 `Dockerfile` 构建镜像时，之前基础镜像的那三行 `ONBUILD` 就会开始执行，成功的将当前项目的代码复制进镜像、并且针对本项目执行 `npm install`，生成应用镜像。

## 参考文档

`Dockerfie` 官方文档：https://docs.docker.com/engine/reference/builder/

`Dockerfile` 最佳实践文档：https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

`Docker` 官方镜像 `Dockerfile`：https://github.com/docker-library/docs

## Dockerfile 多阶段构建

将所有的构建过程编包含在一个 `Dockerfile` 中，包括项目及其依赖库的编译、测试、打包等流程，这里可能会带来的一些问题：

- 镜像层次多，镜像体积较大，部署时间变长
- 源代码存在泄露的风险

Docker v17.05 开始支持多阶段构建 (`multistage builds`)。使用多阶段构建我们就可以很容易解决前面提到的问题，并且只需要编写一个 `Dockerfile`。

```
FROM golang:1.9-alpine as builder

RUN apk --no-cache add git

WORKDIR /go/src/github.com/go/helloworld/

RUN go get -d -v github.com/go-sql-driver/mysql

COPY app.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest as prod

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=0 /go/src/github.com/go/helloworld/app .

CMD ["./app"]
```

使用 `as` 来为某一阶段命名，

只想构建 `builder` 阶段的镜像时，增加 `--target=builder` 参数即可，

```
$ docker build --target builder -t username/imagename:tag .
```

构建时从其他镜像复制文件，

```
COPY --from=0 /go/src/github.com/go/helloworld/app . 
 从上一阶段的镜像中复制文件
 
$ COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf
复制任意镜像中的文件
```

## 多种系统架构

使用镜像创建一个容器，该镜像必须与 Docker 宿主机系统架构一致，例如 `Linux x86_64` 架构的系统中只能使用 `Linux x86_64` 的镜像创建容器。

Windows、macOS 除外，其使用了 [binfmt_misc](https://docs.docker.com/docker-for-mac/multi-arch/) 提供了多种架构支持，在 Windows、macOS 系统上 (x86_64) 可以运行 arm 等其他架构的镜像。

在 `Linux x86_64`上构建的镜像发布到docker hub之后，树莓派 `Linux arm64v8` 找不到。

 Docker 引擎根据系统架构自动拉取对应的镜像？

在 `Linux x86_64` 和 `Linux arm64v8` 架构的计算机中执行 `$ docker run golang:alpine go version` 时我们发现都是可以正确的运行。

当用户获取一个镜像时，Docker 引擎会首先查找该镜像是否有 `manifest` 列表，如果有的话 Docker 引擎会按照 Docker 运行环境（系统及架构）查找出对应镜像（例如 `golang:alpine`）。如果没有的话会直接获取镜像（例如上例中我们构建的 `username/test`）。

```
$ docker manifest inspect golang:alpine
```

> 该命令属于实验特性，请参考 [开启实验特性](https://github.com/yeasy/docker_practice/tree/18ab3069a318680153a786f497395664f61e7473/install/experimental/README.md) 一节

```
{
   "schemaVersion": 2,
   "mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
   "manifests": [
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1365,
         "digest": "sha256:5e28ac423243b187f464d635bcfe1e909f4a31c6c8bce51d0db0a1062bec9e16",
         "platform": {
            "architecture": "amd64",
            "os": "linux"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1365,
         "digest": "sha256:2945c46e26c9787da884b4065d1de64cf93a3b81ead1b949843dda1fcd458bae",
         "platform": {
            "architecture": "arm",
            "os": "linux",
            "variant": "v7"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1365,
         "digest": "sha256:87fff60114fd3402d0c1a7ddf1eea1ded658f171749b57dc782fd33ee2d47b2d",
         "platform": {
            "architecture": "arm64",
            "os": "linux",
            "variant": "v8"
         }
      },
      {
         "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
         "size": 1365,
         "digest": "sha256:607b43f1d91144f82a9433764e85eb3ccf83f73569552a49bc9788c31b4338de",
         "platform": {
            "architecture": "386",
            "os": "linux"
         }
      },
   ]
}
```

 `manifest` 列表中包含了不同系统架构所对应的镜像 `digest` 值，这样 Docker 就可以在不同的架构中使用相同的 `manifest` (例如 `golang:alpine`) 获取对应的镜像。

# 操作容器

## 启动

一种是基于镜像新建一个容器并启动，另外一个是将在终止状态（`stopped`）的容器重新启动。

因为 Docker 的容器实在太轻量级了，很多时候用户都是随时删除和新创建容器。

### 新建并启动

```
$ docker run -t -i ubuntu:18.04 /bin/bash
root@af8bae53bdd3:/#
```

`-t` 选项让Docker分配一个伪终端（pseudo-tty）并绑定到容器的标准输入上， `-i` 则让容器的标准输入保持打开。

当利用 `docker run` 来创建容器时，Docker 在后台运行的标准操作包括：

- 检查本地是否存在指定的镜像，不存在就从公有仓库下载
- 利用镜像创建并启动一个容器
- 分配一个文件系统，并在只读的镜像层外面挂载一层可读写层
- 从宿主主机配置的网桥接口中桥接一个虚拟接口到容器中去
- 从地址池配置一个 ip 地址给容器
- 执行用户指定的应用程序
- 执行完毕后容器被终止

### 启动已终止容器

```
docker container start
```

容器的核心为所执行的应用程序，所需要的资源都是应用程序运行所必需的。除此之外，并没有其它的资源。

##  守护态运行

 `-d` 参数 启动后会返回一个唯一的 id

**注：** 容器是否会长久运行，是和 `docker run` 指定的命令有关，和 `-d` 参数无关。

获取容器的输出信息

```
$ docker container logs [container ID or NAMES]
```



**终止**

终止状态的容器可以用 `docker container ls -a` 命令看到

`docker container stop` 来终止一个运行中的容器。

`docker container restart` 命令会将一个运行态的容器终止，然后再重新启动它



## 进入容器

在使用 `-d` 参数时，容器启动后会进入后台。某些时候需要进入容器进行操作

```
$ docker exec -it 69d1 bash
```

如果从这个 stdin 中 exit，不会导致容器的停止。 推荐使用docker exec 。

## 导出和导入

导出容器快照到本地文件

```
docker container ls -a
docker export id > ubuntu.tar
```

导入

```
cat ubuntu.tar | docker import - test/ubuntu:v1.0

docker import url_filepa$ docker import http://example.com/exampleimage.tgz example/imagerepo
```



*注：用户既可以使用* *`docker load`* *来导入镜像存储文件到本地镜像库，也可以使用* *`docker import`* *来导入一个容器快照到本地镜像库。这两者的区别在于容器快照文件将丢弃所有的历史记录和元数据信息（即仅保存容器当时的快照状态），而镜像存储文件将保存完整记录，体积也要大。此外，从容器快照文件导入时可以重新指定标签等元数据信息。*

## 删除

```
docker container rm  trusting_newton
-f Docker 会发送 SIGKILL 信号给容器。
```

**清理所有处于终止状态的容器**

```
docker container ls -a 
docker container prune
```

# 访问仓库

## Docker Hub

> 仓库（`Repository`）是一个具体的项目或目录。例如对于仓库地址 `docker.io/ubuntu` 来说，`docker.io` 是注册服务器地址，`ubuntu` 是仓库名。
>
> 注册服务器（`Registry`）

你可以在 [https://hub.docker.com](https://hub.docker.com/) 免费注册一个 Docker 账号。

```
$ docker login 
docker logout

docker search centos 
--filter=stars=N 参数可以指定仅显示收藏数量为 N 以上的镜像。

docker pull centos
```

根据是否是官方提供，可将镜像分为两类。

>一种是类似 `centos` 这样的镜像，被称为基础镜像或根镜像。这些基础镜像由 Docker 公司创建、验证、支持、提供。这样的镜像往往使用单个单词作为名字。
>
>还有一种类型，比如 `tianon/centos` 镜像，它是由 Docker Hub 的注册用户创建并维护的，往往带有用户名称前缀。

 用户也可以在登录后通过 `docker push` 命令来将自己的镜像推送到 Docker Hub。

```
docker tag ubuntu:18.04  username/ubuntu:18.0.4
docker image ls 
docker push username/ubuntu:18.0.4
docker search username
```

### 自动构建

有时候，用户构建了镜像，安装了某个软件，当软件发布新版本则需要手动更新镜像。

而自动构建允许用户通过 Docker Hub 指定跟踪一个目标网站（支持 [GitHub](https://github.com/) 或 [BitBucket](https://bitbucket.org/)）上的项目，一旦项目发生新的提交 （commit）或者创建了新的标签（tag），Docker Hub 会自动构建镜像并推送到 Docker Hub 中。

## 私有仓库



# 数据管理

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/08/2020200820220938.png)

## 数据卷（Volumes）

`数据卷` 是一个可供一个或多个容器使用的特殊目录，



> 注意：`数据卷` 的使用，类似于 Linux 下对目录或文件进行 mount，镜像中的被指定为挂载点的目录中的文件会隐藏掉，能显示看到的是挂载的 `数据卷`。

```
docker volume create my-vol
docker volume ls 
dcoker volume inspect my-vol
```

在用 `docker run` 命令的时候，使用 `--mount` 标记来将一个或多个 `数据卷` 挂载到容器里

```
docker run -d -P \
--name web \
-v my-vol:/webapp \
training/webapp \
python app.pp
```

加载一个 `数据卷` 到容器的 `/webapp` 目录

```
docker inspect web # 查看web容器的数据卷信息

"Mounts": [
    {
        "Type": "volume",
        "Name": "my-vol",
        "Source": "/var/lib/docker/volumes/my-vol/_data",
        "Destination": "/app",
        "Driver": "local",
```



数据卷` 是被设计用来持久化数据的，它的生命周期独立于容器，Docker 不会在容器被删除后自动删除 `数据卷`，并且也不存在垃圾回收这样的机制来处理没有任何容器引用的 `数据卷`。如果需要在删除容器的同时移除数据卷。可以在删除容器的时候使用 `docker rm -v` 这个命令。

```
docker volume rm my-vol # -v

无主的数据卷可能会占据很多空间，要清理请使用以下命令
docker volume prune 
```



## 挂载主机目录 (Bind mounts)

```
docker run -d -P \
--name web \
# -v /src/webapp:/opt/webapp \
--mount type=bind,source=/src/webapp,target=/opt/webapp \
training/webapp \
python app.py
```

加载主机的 `/src/webapp` 目录到容器的 `/opt/webapp`目录。这个功能在进行测试的时候十分方便，比如用户可以放置一些程序到本地目录中，来查看容器是否正常工作

 `-v` 参数时如果本地目录不存在 Docker 会自动为你创建一个文件夹，现在使用 `--mount` 参数时如果本地目录不存在，Docker 会报错。



`--mount` 标记也可以从主机挂载单个文件到容器

```
$ docker run --rm -it \
   # -v $HOME/.bash_history:/root/.bash_history \
   --mount type=bind,source=$HOME/.bash_history,target=/root/.bash_history \
   ubuntu:18.04 \
   bash

root@2affd44b4667:/# history
1  ls
2  diskutil list
```

这样就可以记录在容器输入过的命令了。

# 使用网络

## 外部访问容器

可以通过 `-P` 或 `-p` 参数来指定端口映射。
`-P` 标记时，Docker 会随机映射一个 `49000~49900` 的端口到内部容器开放的网络端口。

-p 格式
`ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort`。x

```
$ docker container ls -l # 查看容器端口
$ docker logs -f nostalgic_morse # 查看应用消息
```

```
# 映射所有接口地址
$ docker run -d -p 5000:5000 training/webapp python app.py 

# 映射到指定地址的指定端口
$ docker run -d -p 127.0.0.1:5000:5000 training/webapp python app.py

# 映射到指定地址的任意端口
$ docker run -d -p 127.0.0.1::5000 training/webapp python app.py

```

查看映射端口配置

```
$ docker port nostalgic_morse 5000
127.0.0.1:49155.

-p 标记可以多次使用来绑定多个端口
$ docker run -d \
    -p 5000:5000 \
    -p 3000:80 \
    training/webapp \
    python app.py
```



## 容器互联

```
docker network create -d bridge my-net 
```

> -d` 参数指定 Docker 网络类型，有 `bridge` `overlay
> `overlay` 网络类型用于 [Swarm mode]()

```
$ docker run -it --rm --name busybox1 --network my-net busybox sh
$ docker run -it --rm --name busybox2 --network my-net busybox sh

互ping
/ # ping busybox2
/ # ping busybox1
```

这样，`busybox1` 容器和 `busybox2` 容器建立了互联关系。

## 配置 DNS

# 高级网络配置



# Docker Buildx

Docker Buildx 是一个 docker CLI 插件，其扩展了 docker 命令，支持 [Moby BuildKit]() 提供的功能。

> 该功能仅适用于 Docker v19.03+ 版本

**BuildKit** 是下一代的镜像构建组件，在 https://github.com/moby/buildkit 开源。

建议使用 BuildKit 构建镜像时使用一个新的 Dockerfile 文件（例如 Dockerfile.buildkit）

 **`Dockerfile` 新增指令详解**

```
FROM node:alpine as builder

WORKDIR /app

COPY package.json /app/

RUN npm i --registry=https://registry.npm.taobao.org \
        && rm -rf ~/.npm

COPY src /app/src

RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/dist /app/dist
```

例如 `Go` 中的 `go mod`、`Node.js` 中的 `npm` 等等，当我们构建一个镜像时，往往会重复的从互联网中获取依赖包，难以缓存，大大降低了镜像的构建效率。

当 `package.json` 文件变动时，`RUN npm i && rm -rf ~/.npm` 这一层会重新执行，变更多次后，生成了大量的中间层镜像。



RUN --mount=type=cache ,在镜像构建时把 `node_modules` 文件夹挂载上去，在构建完成后，这个 `node_modules` 文件夹会自动卸载，实际的镜像中并不包含 `node_modules` 这个文件夹，这样我们就省去了每次获取依赖的时间，大大增加了镜像构建效率，同时也避免了生成了大量的中间层镜像。

```
# syntax = docker/dockerfile:experimental
FROM node:alpine as builder

WORKDIR /app

COPY package.json /app/

RUN --mount=type=cache,target=/app/node_modules,id=my_app_npm_module,sharing=locked \
    --mount=type=cache,target=/root/.npm,id=npm_cache \
        npm i --registry=https://registry.npm.taobao.org

COPY src /app/src

RUN --mount=type=cache,target=/app/node_modules,id=my_app_npm_module,sharing=locked \
# --mount=type=cache,target=/app/dist,id=my_app_dist,sharing=locked \
        npm run build

FROM nginx:alpine

# COPY --from=builder /app/dist /app/dist

# 为了更直观的说明 from 和 source 指令，这里使用 RUN 指令
RUN --mount=type=cache,target=/tmp/dist,from=builder,source=/app/dist \
    # --mount=type=cache,target/tmp/dist,from=my_app_dist,sharing=locked \
    mkdir -p /app/dist && cp -r /tmp/dist/* /app/dist
```

# Docker Compose

> `Docker Compose` 是 Docker 官方编排（Orchestration）项目之一，负责快速的部署分布式应用。
>
> `Compose` 定位是 「定义和运行多个 Docker 容器的应用（Defining and running multi-container Docker applications）」

日常工作中，经常会碰到需要多个容器相互配合来完成某项任务的情况。例如要实现一个 Web 项目，除了 Web 服务容器本身，往往还需要再加上后端的数据库服务容器，甚至还包括负载均衡容器等。

`Compose`  允许用户通过一个单独的 `docker-compose.yml` 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）。

概念：

- 服务 (`service`)：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例。

- 项目 (`project`)：由一组关联的应用容器组成的一个完整业务单元

`Compose` 的默认管理对象是项目，通过子命令对项目中的一组容器进行便捷地生命周期管理。

```
$ docker-compose --version
```

**web项目 场景**



# Swarm mode

Docker 1.12 [Swarm mode](https://docs.docker.com/engine/swarm/) 已经内嵌入 Docker 引擎，成为了 docker 子命令 `docker swarm`。

`Swarm mode` 内置 kv 存储功能，提供了众多的新特性，比如：具有容错能力的去中心化设计、内置服务发现、负载均衡、路由网格、动态伸缩、滚动更新、安全传输等。使得 Docker 原生的 `Swarm` 集群具备与 Mesos、Kubernetes 竞争的实力。

# [etcd](https://github.com/etcd-io/etcd)

> etc d 
>
> `etcd` 是 `CoreOS` 团队于 2013 年 6 月发起的开源项目，它的目标是构建一个高可用的分布式键值（`key-value`）数据库，基于 `Go` 语言实现。我们知道，在分布式系统中，各种服务的配置信息的管理分享，服务的发现是一个很基本同时也是很重要的问题。`CoreOS` 项目就希望基于 `etcd` 来解决这一问题。

受到 [Apache ZooKeeper](https://zookeeper.apache.org/) 项目和 [doozer](https://github.com/ha/doozerd) 项目的启发，`etcd` 在设计的时候重点考虑了下面四个要素：

- 简单：具有定义良好、面向用户的 `API` ([gRPC](https://github.com/grpc/grpc))
- 安全：支持 `HTTPS` 方式的访问
- 快速：支持并发 `10 k/s` 的写操作
- 可靠：支持分布式结构，基于 `Raft` 的一致性算法

>*Apache ZooKeeper 是一套知名的分布式系统中进行同步和一致性管理的工具。*
>
>*doozer 是一个一致性分布式数据库。*
>
>[*Raft*](https://raft.github.io/) *是一套通过选举主节点来实现分布式系统一致性的算法*

一般情况下，用户使用 `etcd` 可以在多个节点上启动多个实例，并添加它们为一个集群。同一个集群中的 `etcd` 实例将会保持彼此信息的一致性。

...



# Fedora CoreOS

> `CoreOS` 是一个专门为安全和大规模运行容器化工作负载而构建的新 Fedora 版本
>
> `CoreOS` 的安装文件和运行依赖非常小，它提供了精简的 Linux 系统。它使用 Linux 容器在更高的抽象层来管理你的服务，而不是通过常规的包管理工具 `yum` 或 `apt` 来安装包。
>
> `CoreOS` 几乎可以运行在任何平台：`VirtualBox` `Amazon EC2` `QEMU/KVM` `VMware` `Bare Metal` 和 `OpenStack` 等 。



## 简介

> [Fedora CoreOS](https://getfedora.org/coreos/) 是一个自动更新的，最小的，整体的，以容器为中心的操作系统，不仅适用于集群，而且可独立运行，并针对运行 Kubernetes 进行了优化。
>
> 目标是提供最佳的容器主机，以安全，大规模地运行容器化的工作负载。

**一个最小化操作系统**

它比现有的 Linux 安装平均节省 40% 的 RAM（大约 114M ）并允许从 PXE 或 iPXE 非常快速的启动。

**系统初始化**

Ignition 是一种配置实用程序，在系统首次启动期间（在 initramfs 中）仅运行一次,可读取配置文件（JSON 格式）并根据该配置配置 FCOS 系统。可配置的组件包括存储，文件系统，systemd 和用户。

 Ignition 在启动过程中的早期运行，因此它可以在用户空间开始启动之前重新对磁盘分区，格式化文件系统，创建用户并写入文件。当 systemd 启动时，systemd 服务已被写入磁盘，从而加快了启动时间。

**自动更新**

FCOS 使用 rpm-ostree 系统进行事务性升级。无需像 yum 升级那样升级单个软件包，

**容器工具**

对于诸如构建，复制和其他管理容器的任务，FCOS 用一组兼容的容器工具代替了 **Docker CLI** 工具。**podman CLI** 工具支持许多容器运行时功能，例如运行，启动，停止，列出和删除容器和镜像。**skopeo CLI** 工具可以复制，认证和签名镜像。您还可以使用 **crictl CLI** 工具来处理 CRI-O 容器引擎中的容器和镜像。

# 实战案例 - 操作系统

目前常用的 Linux 发行版主要包括 `Debian/Ubuntu` 系列和 `CentOS/Fedora` 系列。

前者以自带软件包版本较新而出名；后者则宣称运行更稳定一些。

## Busybox

`BusyBox` 是一个集成了一百多个最常用 Linux 命令和工具（如 `cat`、`echo`、`grep`、`mount`、`telnet` 等）的精简工具箱，它只需要3 MB 的大小，很方便进行各种快速验证，被誉为“Linux 系统的瑞士军刀”。

```
$ docker search busybox
$ docker pull busybox:latest
$ docker image ls
$ docker run -it busybox
/ # grep
```



## Alpine

> `Alpine` 操作系统是一个面向安全的轻型 `Linux` 发行版。它不同于通常 `Linux` 发行版，`Alpine` 采用了 `musl libc` 和 `busybox` 以减小系统的体积和运行时资源消耗，但功能上比 `busybox` 又完善的多，因此得到开源社区越来越多的青睐。
>
> `Alpine` 还提供了自己的包管理工具 `apk`，  `https://pkgs.alpinelinux.org/packages`  
>
> `Alpine` 由非商业组织维护的，支持广泛场景的 `Linux`发行版，它特别为资深/重度`Linux`用户而优化，关注安全，性能和资源效能。`Alpine` 镜像可以适用于更多常用场景，并且是一个优秀的可以适用于生产的基础系统/环境。

`Alpine` Docker 镜像仅仅只有 **5 MB** 左右（对比 `Ubuntu` 系列镜像接近 `200 MB`），且拥有非常友好的包管理机制。官方镜像来自 `docker-alpine` 项目。

由于镜像很小，下载时间往往很短，读者可以直接使用 `docker run` 指令直接运行一个 `Alpine` 容器，

```
$ docker run alpine echo '123'

```



由于在国内访问 `apk` 仓库较缓慢，建议在使用 `apk` 之前先替换仓库地址为国内镜像。

```
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \
      && apk add --no-cache <package>
```



`CentOS` 和 `Fedora` 都是基于 `Redhat` 的常见 Linux 分支。`CentOS` 是目前企业级服务器的常用操作系统；`Fedora` 则主要面向个人桌面用户。

# CI/CD

**持续集成(Continuous integration)** 是一种软件开发实践，每次集成都通过自动化的构建（包括编译，发布，自动化测试）来验证，从而尽早地发现集成错误。

**持续部署(continuous deployment)** 是通过自动化的构建、测试和部署循环来快速交付高质量的产品。

与 `Jenkins` 不同的是，基于 Docker 的 CI/CD 每一步都运行在 Docker 容器中，所以理论上支持所有的编程语言。

GitHub [Actions](https://github.com/features/actions) 是 GitHub 推出的一款 CI/CD 工具,我们可以在每个 `job` 的 `step` 中使用 Docker 执行构建步骤.

```
on: push

name: CI

jobs:
  my-job:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@master
        with:
          fetch-depth: 2
      - name: run docker container
        uses: docker://golang:alpine
        with:
          args: go version
```



# VS Code Docker

无需本地安装开发工具，直接将 Docker 容器作为开发环境，具体参考 [官方文档](https://code.visualstudio.com/docs/remote/containers)。





# LinuxKit

`LinuxKit` 这个工具可以将多个 Docker 镜像组成一个最小化、可自由定制的 Linux 系统，最后的生成的系统只有几十 M 大小，可以很方便的在云端进行部署。

# podman - 下一代 Linux 容器工具

[`podman`](https://github.com/containers/podman) 是一个无守护程序与 docker 命令兼容的下一代 Linux 容器工具。

只需将 `docker` 替换为 `podman` 即可

# 附录

常见问题

命令查询

调试docker

资源链接





