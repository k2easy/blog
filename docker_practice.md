# [Docker — 从入门到实践》](https://vuepress.mirror.docker-practice.com/#%E5%BE%AE%E4%BF%A1%E5%B0%8F%E7%A8%8B%E5%BA%8F)

> `Docker` 最初是在 `Ubuntu 12.04` 上开发实现的；`Red Hat` 则从 `RHEL 6.5` 开始对 `Docker` 进行支持；`Google` 也在其 `PaaS` 产品中广泛应用 `Docker`。
>
> **Docker** 使用 `Google` 公司推出的 [Go 语言 (opens new window)](https://golang.google.cn/)进行开发实现，基于 `Linux` 内核的 [cgroup (opens new window)](https://zh.wikipedia.org/wiki/Cgroups)，[namespace (opens new window)](https://en.wikipedia.org/wiki/Linux_namespaces)，以及 [OverlayFS (opens new window)](https://docs.docker.com/storage/storagedriver/overlayfs-driver/)类的 [Union FS (opens new window)](https://en.wikipedia.org/wiki/Union_mount)等技术，对进程进行封装隔离，属于 [操作系统层面的虚拟化技术 (opens new window)](https://en.wikipedia.org/wiki/Operating-system-level_virtualization)。由于隔离的进程独立于宿主和其它的隔离的进程，因此也称其为容器。

> `runc` 是一个 Linux 命令行工具，用于根据 [OCI容器运行时规范 (opens new window)](https://github.com/opencontainers/runtime-spec)创建和运行容器。

> `containerd` 是一个守护程序，它管理容器生命周期，提供了在一个节点上执行容器和管理镜像的最小功能集。

![Docker 架构](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/04/3020210430213145.png)



容器不需要进行硬件虚拟以及运行完整操作系统等额外开销，`Docker` 对系统资源的利用率更高。

 `Docker` 的镜像提供了除内核外完整的运行时环境，确保了应用运行环境一致性，从而不会再出现 *「这段代码在我机器上没问题啊」* 这类问题

 `Docker` 容器应用，由于直接运行于宿主内核，无需启动完整的操作系统，因此可以做到秒级、甚至毫秒级的启动时间。大大的节约了开发、测试、部署的时间。

开发人员可以通过 [Dockerfile](https://vuepress.mirror.docker-practice.com/image/dockerfile/) 来进行镜像构建，并结合 [持续集成(Continuous Integration) (opens new window)](https://en.wikipedia.org/wiki/Continuous_integration)系统进行集成测试，而运维人员则可以直接在生产环境中快速部署该镜像，甚至结合 [持续部署(Continuous Delivery/Deployment) (opens new window)](https://en.wikipedia.org/wiki/Continuous_delivery)系统进行自动部署。

使用 [`Dockerfile`](https://vuepress.mirror.docker-practice.com/image/build.html) 使镜像构建透明化,方便运维团队理解应用运行所需条件





