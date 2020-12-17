# Docker

RHEL 7也开始不正式支持Docker。相反，它们为容器环境提供Podman，Buildah和CRI-O。

https://github.com/cri-o/cri-o



我认为CRI-O的优势在于它的极简风格，因为它被创建为“ CRI”运行时。尽管容器化作为Docker的一部分试图变得更加开源，但它们是纯CRI运行时，因此CRI-O没有CRI不需要的任何内容。

 CRI运行时

正如我所描述的，CRI是Kubernetes提供的API，用于与容器运行时进行对话，以创建/删除容器化的应用程序。



它们通过IPC在gRPC中作为kubelet进行通信，并且运行时在同一主机上运行，并且CRI运行时负责从kubelet获取请求并执行OCI容器运行时以运行容器。等一下 也许我应该用一张图表来解释。![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/12/0320201203145307.png)

 因此，CRI运行时将执行以下操作

- 从kubelet获取gRPC请求
- 按照规范创建OCI json配置