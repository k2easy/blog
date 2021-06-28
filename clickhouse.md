# 入门》

https://clickhouse.tech/docs/zh/

# 简介

ClickHouse是一个用于联机分析(OLAP)的列式数据库管理系统(DBMS)。

列存储：相同列的数据类型一致，压缩解压效率高

不同的数据存储方式适用不同的业务场景，数据访问的场景包括：进行了何种查询、多久查询一次以及各类查询的比例；每种类型的查询(行、列和字节)读取多少数据；读取数据和更新之间的关系；使用的数据集大小以及如何使用本地的数据集；是否使用事务,以及它们是如何进行隔离的；数据的复制机制与数据的完整性要求；每种类型的查询要求的延迟与吞吐量等等。

系统负载越高，依据使用场景进行定制化就越重要，并且定制将会变的越精细。没有一个系统能够同时适用所有不同的业务场景。如果系统适用于广泛的场景，在负载高的情况下，要兼顾所有的场景，那么将不得不做出选择。是要平衡还是要效率？

##  OLAP场景的关键特征

- 绝大多数是读请求
- 数据以相当大的批次(> 1000行)更新，而不是单行更新;或者根本没有更新。
- 已添加到数据库的数据不能修改。
- 对于读取，从数据库中提取相当多的行，但只提取列的一小部分。
- 宽表，即每个表包含着大量的列
- 查询相对较少(通常每台服务器每秒查询数百次或更少)
- 对于简单查询，允许延迟大约50毫秒
- 列中的数据相对较小：数字和短字符串(例如，每个URL 60个字节)
- 处理单个查询时需要高吞吐量(每台服务器每秒可达数十亿行)
- 事务不是必须的
- 对数据一致性要求低
- 每个查询有一个大表。除了他以外，其他的都很小。
- 查询结果明显小于源数据。换句话说，数据经过过滤或聚合，因此结果适合于单个服务器的RAM中



OLAP场景与其他通常业务场景(例如,OLTP或K/V)有很大的不同， 因此想要使用OLTP(online transaction processing  线上交易处理，如订单、金融等日常交易活动)或Key-Value数据库去高效的处理分析查询场景，并不是非常完美的适用方案。例如，使用OLAP数据库去处理分析请求通常要优于使用MongoDB或Redis去处理分析请求。 

列式数据库更适合于OLAP场景，原因如下

![Row oriented](https://clickhouse.tech/docs/zh/images/row-oriented.gif)

![Column oriented](https://clickhouse.tech/docs/zh/images/column-oriented.gif)

**输入/输出**

1. 例如，如果只需要读取100列中的5列，这将帮助你最少减少20倍的I/O消耗。
2. 由于数据总是打包成批量读取的，所以压缩是非常容易的。同时数据按列分别存储这也更容易压缩。这进一步降低了I/O的体积。
3. 由于I/O的降低，这将帮助更多的数据被系统缓存。

**CPU**

由于执行一个查询需要处理大量的行，因此在整个向量上执行所有操作将比在每一行上执行所有操作更加高效。同时这将有助于实现一个几乎没有调用成本的查询引擎。

1. 向量引擎：所有的操作都是为向量而不是为单个值编写的。
2. 代码生成：生成一段代码，包含查询中的所有操作。

为了提高CPU效率，查询语言必须是声明型的(SQL或MDX)， 或者至少一个向量(J，K)。 查询应该只包含隐式循环，允许进行优化。

### MDX

MDX is short for Multidimensional Expressions, which is a syntax developed for defining multidimensional objects and querying and manipulating multidimensional data in OLAP databases. The purpose of MDX is to make creating queries to access data from multiple dimensional databases easier and more intuitive.

[MDX is a query language](http://searchsqlserver.techtarget.com/definition/multidimensional-expressions-MDX) designed for OLAP databases, as SQL is a query language for relational databases.

# [ZooKeeper](https://zookeeper.apache.org/)

Apache ZooKeeper is an effort to develop and maintain an open-source server which enables highly reliable distributed coordination.



JDBC(Java DataBase Connectivity standard)
ODBC(Open Database Connectivity，开放数据库互连)



# 开源BI比较

## Superset

由Airbnb贡献的轻量级BI产品，Superset语义层建模（被称为Table）时只能基于单表，多表关联要事先逻辑化成视图再使用，这点有点别扭。在Table里要显示地将字段标记成可分组、可过滤，指定聚合方式（计数、求和等），页面在使用时需要选择Group by（并没有叫做维度）、Metrics和Filter进行查询。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/04/2320210423070309.jpg)

缺点：

- 每一张用的表，都需要Sources -> Tables里定义。每一个用到的指标也需要定义。不适合做adhoc query的可视化。
- SQL Lab虽然可以做adhoc query的可视化，但每次都会生成一堆临时table，把Sources -> Tables里面的对象搞得很乱
- Dashboard不能分类，多了以后很难管理和查找
- 权限系统特别复杂，而且不好用



## Grafana

Grafana 主要用于对接时序数据库，分析展示监控数据。目前支持的数据源包括 InfluxDB、Elasticsearch、Graphite、Prometheus 等。

Grafana 为不同数据源提供了不同的编辑器，这样可以方便使用特定数据源的查询语法，很牛叉。

时间序列，日志与设备运行数据分析选 Grafana；企业生产经营数据分析则可以选 Superset。

## Redash

Redash 仅仅实现了 Superset 中 SQL Lab 的功能，但却把这个功能做到了极致。

Redash 有两个非常实用的功能，Query Snippet 与 Query Parameters。

Query Snippet 很好地解决了查询片段的复用问题。做数据报表时经常要用到十分复杂的 SQL 语句，这些语句中肯定有一些片段是可以在多个查询中复用的。在 Redash 中我们可以将这些片段定义成 Snippet，之后方便地复用。

Query Parameters 可以为查询添加可定制参数，

它的可视化种类比 Superset 逊色不少（不过其实也够用了）。另外，由于它只是纯粹地把数据查询结果可视化，所以也没有 Superset 里那些对时间维度上的聚合与对比的操作。

国内 BI 项目以企业级应用解决方案为主，其需求重点落在多维分析式的自助报表、Dashboard 以及一些相关平台管理功能，对于多步骤探索式分析需求相对较少（这部分功能一般由桌面 BI 解决）

https://redash.io/help/open-source/dev-guide

可以先离开30分钟阅读这位同学写的文章：《[使用Celery](https://zhuanlan.zhihu.com/p/22304455)》。

![img](https://pic3.zhimg.com/80/v2-50c3f04b9772f0f8f6d3c740a3794b56_1440w.jpg)

##  **Tableau**

![img](https://pic4.zhimg.com/80/v2-a8a2f729b1c4b388a8472a52d90fd5a3_1440w.jpg)

![image-20210317000314937](/Users/demo/Library/Application%20Support/typora-user-images/image-20210317000314937.png)



![image-20210317000938798](/Users/demo/Library/Application%20Support/typora-user-images/image-20210317000938798.png)



 Python is the best programming language to start your data science journey. 



要写接近实时，就不要能有垃圾回收(GC)。GC对于一些类型的程序几乎是致命的。想像一个低延时交易程序在看到一个交易机会之后因为某种原因触发长达100ms的GC，这个机会铁定就没了。要想达到接近实时且高性能就需要接近底层，即所谓bare-metal。新语言必须有**杀手级的特性**，这才是转语言的关键动力。
这一杀手级的特性就是Ownership和Lifetime。Rust首页宣称的"prevents nearly all segfaults, and guarantees thread safety"是超级诱人的，因为这是在没有GC和runtime的情况下实现的。

 

最后，Rust是一个脚踏实地(Practical)的语言。这意味着它不遵循某一个范式(paradigm)或者是为计算机科学教学而生的语言。这是一个写给开发者的语言，如果特性经过权衡发现对开发有益，语言作者不会因为它破坏了某种范式而不去加它。这种哲学有些类似于当年Linux相对Mimix选择monolithic kernel而不是结构上更干净的micro kernel，因为Linux需要性能。这样的选择会让语言更接近使用者，让使用者更开心。

rust 2019年把async/await稳定了 , 这让rust有快捷开发高性能web应用的能力 



# QQ音乐PB级ClickHouse实时数据平台架构演进之路

ClickHouse主要为OLAP应用场景的数据仓库，以库表的方式存储数据，可简单、高效地分析数据，结合Superset以可视化的方式输出分析数据图表。ClickHouse有着卓越的实时分析能力。以性能表现突出的单表为例，使用单表100G，3亿行数据，集群规模8核20G*3，简单的查询在毫秒级完成，复杂查询秒级，查询速度较Presto、SparkSQL提升3-6倍，较Hive提升30-100倍。

对比Presto、Impala、Hawq、Greenplum，ClickHouse以其分布式计算、多核计算、向量化执行与SIMD、代码生成技术以及列式存储等特性，实现了超高速的查询，凸显了更优越的性能。

QQ音乐大数据团队基于ClickHouse+Superset等基础组件，结合腾讯云EMR产品的云端能力，搭建起高可用、低延迟的实时OLAP分析计算可视化平台。

### **ClickHouse架构系统技术攻克点**

### **（1）基于SSD盘的ZooKeeper**

ClickHouse依赖于ZooKeeper实现分布式系统的协调工作，在ClickHouse并发写入量较大时，ZooKeeper对元数据存储处理不及时，会导致ClickHouse副本间同步出现延迟，降低集群整体性能。

**解决方案：**采用SSD盘的ZooKeeper大幅提高IO的性能，在表个数小于100，数据量级在TB级别时，也可采用HDD盘，其他情况都建议采用SSD盘。

### **（2）数据写入一致性**

数据在写入ClickHouse失败重试后内容出现重复，导致了不同系统，如Hive离线数仓中分析结果，与ClickHouse集群中运算结果不一致。

**解决方案：**基于统一全局的负载均衡调度策略，完成数据失败后仍然可写入同一Shard，实现数据幂等写入，从而保证在ClickHouse中数据一致性。？？？

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327085008.jpg)

### **（3）实时离线数据写入**

ClickHouse数据主要来自实时流水上报数据和离线数据中间分析结果数据，如何在架构中完成上万亿基本数据的高效安全写入，是一个巨大的挑战。

**解决方案：**基于Tube消息队列，完成统一数据的分发消费，基于上述的一致性策略实现数据幂同步，做到实时和离线数据的高效写入。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327084902.jpg)





### **（4）表分区数优化**

部分离线数据仓库采用按小时落地分区，如果采用原始的小时分区更新同步，会造成ClickHouse中Select查询打开大量文件及文件描述符，进而导致性能低下。

**解决方案：**ClickHouse官方也建议，表分区的数量建议不超过10000，上述的数据同步架构完成小时分区转换为天分区，同时程序中完成数据幂等消费。

### **（5）读/写分离架构**

频繁的写动作，会消耗大量CPU/内存/网卡资源，后台合并线程得不到有效资源，降低Merge Parts速度，MergeTree构建不及时，进而影响读取效率，导致集群性能降低。

**解决方案：**ClickHouse临时节点预先完成数据分区文件构建，动态加载到线上服务集群，缓解ClickHouse在大量并发写场景下的性能问题，实现高效的读/写分离架构，具体步骤和架构如下：

a）利用K8S的弹性构建部署能力，构建临时ClickHouse节点，数据写入该节点完成数据的Merge、排序等构建工作；b）构建完成数据按MergeTree结构关联至正式业务集群。

当然对一些小数据量的同步写入，可采用10000条以上批量的写入。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327085608.jpg)

### **（6）跨表查询本地化**

在ClickHouse集群中跨表进行Select查询时，采用Global IN/Global Join语句性能较为低下。分析原因，是在此类操作会生成临时表，并跨设备同步该表，导致查询速度慢。

**解决方案：**采用一致性hash，将相同主键数据写入同一个数据分片，在本地local表完成跨表联合查询，数据均来自于本地存储，从而提高查询速度。

这种优化方案也有一定的潜在问题，目前ClickHouse尚不提供数据的Reshard能力，当Shard所存储主键数据量持续增加，达到磁盘容量上限需要分拆时，目前只能根据原始数据再次重建CK集群，有较高的成本。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327085843.jpg)

### **3. 基于Superset的自助数据分析可视化平台**

ClickHouse在实时分析领域拥有诸多优势，在OLAP分析场景下，搭配在数据可视化领域表现抢眼的Superset组件，在对QQ音乐业务指标概览以及二维变量分析中，提供丰富的数据可视化集以供数据分析处理。

当前Superset上万个图表中，超60%由产品、研发、运营、研究员、财务等非数据人员创建，做到全民数据分析，数据平民化。![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327085954.jpg)







# HDFS+ClickHouse+Spark：从0到1实现一款轻量级大数据分析系统

希望通过MVP数据分析，驱动产品从"Minimum Viable Product" to "Most Valuable Product"。

clickBI 

MVP BI 

**数据建模**

MVP数据分析系统底层数据建设，一方面基于“用户(User)+事件ID(Event)+配置(Config)”思路，对产品数据信息进行高度抽象整合，收敛产品矩阵业务数据；另一方面，基于Key-Value模型，生成用户大宽表，一个User_Id仅有一条记录信息。

**技术选型**

 MySQL数据库承载数据能力在百万级，适合对结果型数据进行分析，对于上亿级数据是无能为力。

为了实现实时OLAP分析，对业界的大数据分析平台的技术方案我们进行了调研比较。业界存储引擎主要是HDFS与HBASE，计算引擎使用比较多的是Impala，Druid，ClickHouse，Spark。Druid系统维护成本高，无Join能力，且语法应用相对复杂。

从计算速度角度，ClickHouse比Presto快2倍+，比Impala快3倍+，比SparkSql快约4倍，计算性能比较如下。

和Impala相比，ClickHouse可以通过JDBC直接导入，数据导入成本低，ClickHouse系统维护成本相对低。另外，ClickHouse语法简单，易用性很强，对页面开发友好，可以快速开发出可视化页面。
使用Spark补齐ClickHouse无法进行大规模Join操作短板，比如处理大规模复杂的关联分析任务。，Spark可以无缝访问HDFS中Hive表数据，无需重新导数据，应用效率高。使用HDFS存储历史全量标签与行为数据（占比约80%），使用ClickHouse存储近期标签与行为数据（占比20%）。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327083244.jpg)



**页面交互**

MVP页面交互形式，80%数据分析诉求是可以直接通过页面实时分析完成，剩下约20%复杂分析任务，是通过提交任务式分析完成。
经营指标体系、事件模型分析、漏斗模型分析、留存模型分析等，是通过页面实时分析完成，用户人群画像洞察、用户兴趣偏好洞察是通过提交任务式分析完成。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327083711.jpg)

![img](https://pic4.zhimg.com/80/v2-949448e096b60e200e381f8e3de25353_1440w.jpg)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/03/2720210327083650.jpg)

es 在线低延迟索引，比如日志查询，关键字搜索，clickhouse 离线聚合性能好，比如出报表。有条件有需求两个可以都上，没条件上一个要求高的硬顶一下另一个不是不行。
速度要很快，应该是在线服务，就选 es 。



东使用的架构，Kafka --> flink 定时任务 --> Clickhouse

# Flink

核心是用[Java](https://zh.wikipedia.org/wiki/Java)和[Scala](https://zh.wikipedia.org/wiki/Scala)编写的分布式流数据流引擎。[[2\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-2)[[3\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-3)Flink以[数据并行](https://zh.wikipedia.org/wiki/数据并行)和[管道](https://zh.wikipedia.org/wiki/管道_(软件))方式执行任意流数据程序[[4\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-4)，Flink的流水线运行时系统可以执行[批处理](https://zh.wikipedia.org/wiki/批处理任务)和流处理程序。[[5\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-5)[[6\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-6)此外，Flink的运行时本身也支持[迭代算法](https://zh.wikipedia.org/wiki/迭代法)的执行。

Flink提供高吞吐量、低延迟的流数据引擎[[8\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-8)以及对事件-时间处理和状态管理的支持。Flink应用程序在发生机器故障时具有容错能力，并且支持exactly-once语义。[[9\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-:2-9)程序可以用Java、Scala[[10\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-10)、[Python](https://zh.wikipedia.org/wiki/Python)[[11\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-11)和[SQL](https://zh.wikipedia.org/wiki/SQL)[[12\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-12)等语言编写。

Flink并不提供自己的数据存储系统，但为[Amazon Kinesis](https://zh.wikipedia.org/wiki/Amazon_Web_Services#Analytics)、[Apache Kafka](https://zh.wikipedia.org/wiki/Apache_Kafka)、[Alluxio](https://zh.wikipedia.org/wiki/Alluxio)、[HDFS](https://zh.wikipedia.org/wiki/HDFS)、[Apache Cassandra](https://zh.wikipedia.org/wiki/Apache_Cassandra)和[Elasticsearch](https://zh.wikipedia.org/wiki/Elasticsearch)等系统提供了数据源和接收器。[[15\]](https://zh.wikipedia.org/wiki/Apache_Flink#cite_note-:0-15)

// 实时OLAP，离线hive hdfs ，实时kafaka



Databricks是由Apache Spark的最初創建者創建的企業軟件公司

  Redash is joining Databricks

> We’re excited to be one of the many open-source projects that Databricks supports. They’re the original creators of Apache Spark™, the standard for large-scale data processing, as well as Delta Lake for reliable data lakes, MLflow for the machine learning lifecycle, Koalas for data science productivity on Spark. Now, Redash joins this community of open source projects for collaborative SQL queries and dashboarding. 

**Redash includes the following features:**

1. **Query editor:** Quickly compose SQL and NoSQL queries with a schema browser and auto-complete.
2. **Visualization and dashboards:** Create beautiful visualizations with drag and drop, and combine them into a single dashboard.
3. **Sharing:** Collaborate easily by sharing visualizations and their associated queries, enabling peer review of reports and queries.
4. **Schedule refreshes:** Automatically update your charts and dashboards at regular intervals you define.
5. **Alerts:** Define conditions and be alerted instantly when your data changes.
6. **REST API:** Everything that can be done in the UI is also available through REST API.
7. **Broad support for data sources:** Extensible data source API with native support for a long list of common SQL, NoSQL databases and platforms.





# [SQLite is not a toy database](https://antonz.org/sqlite-is-not-a-toy-database/)

```
> .import --csv city.csv city
> select count(*) from city;
```



 

# [Redash Developer Installation Guide](https://redash.io/help/open-source/dev-guide/setup)

```
文件开头
#!/usr/bin/env python

man env
env command // using the first directory in the PATH that contains the python3 executable.
```



### 12. Virtual Environments and Packages[¶](https://docs.python.org/3.7/tutorial/venv.html#virtual-environments-and-packages)

```
python3 -m venv tutorial-env 调用venv模块创建项目 
source tutorial-env/bin/activate 
tutorial-env\Scripts\activate.bat

$ pip install requests==2.6.0
$ pip install --upgrade requests
$ pip show requests
 (tutorial-env) $ pip list #  display all of the packages installed in the virtual environment:

```

“search”, “install”, “uninstall”, “freeze”, etc

`pip freeze` will produce a similar list of the installed packages, 

```
(tutorial-env) $ pip freeze > requirements.txt
(tutorial-env) $ cat requirements.txt 
其他人恢复环境，执行 $ pip install -r requirements.txt
```



### [click](https://pypi.org/project/click/)

“Command Line Interface Creation Kit”.

```
$ pip install -U click   // -U upgrade

import click

@click.command()
@click.option("--count", default=1, help="Number of greetings.")
@click.option("--name", prompt="Your name", help="The person to greet.")
def hello(count, name):
    """Simple program that greets NAME for a total of COUNT times."""
    for _ in range(count):
        click.echo(f"Hello, {name}!")

if __name__ == '__main__':
    hello()


$ python hello.py --count=3
Your name: Click
Hello, Click!
Hello, Click!
Hello, Click!
```







# [clickhouse.tech》](https://clickhouse.tech/docs/zh/)

## 简介

ClickHouse是一个用于联机分析(OLAP)的列式数据库管理系统(DBMS)

- 绝大多数是读请求
- 数据以相当大的批次(> 1000行)更新，而
- 已添加到数据库的数据不能修改。
- 对于读取，从数据库中提取相当多的行，但只提取列的一小部分。
- 宽表，即每个表包含着大量的列
- 查询相对较少(通常每台服务器每秒查询数百次或更少)
- 对于简单查询，允许延迟大约50毫秒
- 列中的数据相对较小：数字和短字符串(例如，每个URL 60个字节)
- 处理单个查询时需要高吞吐量(每台服务器每秒可达数十亿行)
- 事务不是必须的
- 对数据一致性要求低
- 每个查询有一个大表。除了他以外，其他的都很小。
- 查询结果明显小于源数据。换句话说，数据经过过滤或聚合，因此结果适合于单个服务器的RAM中

## When NOT to use ClickHouse

- ✕ Transactional workloads (OLTP)
- ✕ Key-value requests with a high rate

- ✕ Blob or document storage
- ✕ Over-normalized data



支持的查询[GROUP BY](https://clickhouse.tech/docs/zh/sql-reference/statements/select/group-by/), [ORDER BY](https://clickhouse.tech/docs/zh/sql-reference/statements/select/order-by/), [FROM](https://clickhouse.tech/docs/zh/sql-reference/statements/select/from/), [JOIN](https://clickhouse.tech/docs/zh/sql-reference/statements/select/join/), [IN](https://clickhouse.tech/docs/zh/sql-reference/operators/in/)以及非相关子查询。

相关(依赖性)子查询和窗口函数暂不受支持，

数据压缩，解压效率高

为了高效的使用CPU，数据不仅仅按列存储，同时还按向量(列的一部分)进行处理，这样可以更加高效地使用CPU。

## 实时的数据更新[ ](https://clickhouse.tech/docs/zh/introduction/distinctive-features/#shi-shi-de-shu-ju-geng-xin)

ClickHouse支持在表中定义主键。为了使查询能够快速在主键中进行范围查找，数据总是以增量的方式有序的存储在MergeTree中。因此，数据可以持续不断地高效的写入到表中，并且写入的过程中不会存在任何加锁的行为。

## 支持近似计算[¶](https://clickhouse.tech/docs/zh/introduction/distinctive-features/#zhi-chi-jin-si-ji-suan)

1. 用于近似计算的各类聚合函数，如：distinct values, medians, quantiles
2. 基于数据的部分样本进行近似查询。这时，仅会从磁盘检索少部分比例的数据。
3. 不使用全部的聚合条件，通过随机选择有限个数据聚合条件进行聚合。 

持自定义[JOIN](https://clickhouse.tech/docs/zh/sql-reference/statements/select/join/)多个表，它更倾向于散列连接算法，如果有多个大表，则使用合并-连接算法

### 支持数据复制和数据完整性[ ](https://clickhouse.tech/docs/zh/introduction/distinctive-features/#zhi-chi-shu-ju-fu-zhi-he-shu-ju-wan-zheng-xing)

ClickHouse使用异步的多主复制技术。当数据被写入任何一个可用副本后，系统会在后台将数据分发给其他副本，以保证系统在不同副本上保持相同的数据。在大多数情况下ClickHouse能在故障后自动恢复，在一些少数的复杂情况下需要手动恢复。

### 限制[ ](https://clickhouse.tech/docs/zh/introduction/distinctive-features/#clickhouseke-xian-zhi)

1. 没有完整的事务支持。
2. 缺少高频率，低延迟的修改或删除已存在数据的能力。仅能用于批量删除或修改数据，但这符合 [GDPR](https://gdpr-info.eu/)。
3. 稀疏索引使得ClickHouse不适合通过其键检索单行的点查询。







`ifconfig` is now `ip a`. Try `ip -s -c -h a`.

```
ifconfig
```

is equivalent to

```
ip addr show
```







### `resolve.symlinks` 

```
boolean = true
```

是否将符号链接(symlink)解析到它们的符号链接位置(symlink location)。

启用时，符号链接(symlink)的资源，将解析为其 *真实* 路径，而不是其符号链接(symlink)的位置。



Elasticsearch最擅长的主要是完全搜索场景（where过滤后的记录数较少），在内存富裕运行环境下可以展现出非常出色的并发查询能力。但是在大规模数据的分析场景下（where过滤后的记录数较多），ClickHouse凭借极致的列存和向量化计算会有更加出色的并发表现，并且查询支持完备度也更好。ClickHouse的并发处理能力立足于磁盘吞吐，而Elasticsearch的并发处理能力立足于内存Cache，这使得两者的成本区间有很大差异，ClickHouse更加适合低成本、大数据量的分析场景，它能够充分利用磁盘的带宽能力。数据导入和存储成本上，ClickHouse更加具有绝对的优势。





Apache Superset和Tableau





# Why GO

数据时代公司 DataTech BI,dtBI

目前，计算机领域正在从 IT 时代向 DT 时代迅速演进。
       IT 时代，就是信息科技时代。是用信息技术改善工作效率。
       DT 时代，就是数据科技时代。根据数据进行决策，改善决策效率。

根据数据进行决策，这个工作可以分为两个部分，一个部分是数据的采集、整理、加工和处理，另一部分是使用统计学、机器学习、人工智能等的模型从数据中提取知识进行决策。



​       数据和数据之间的关系，决定了基于数据决策的效果的理论上限。模型，只能无限逼近这个理论上限。

​       而且，现实中，简单和复杂的模型，其实际效果相差都不大。因此，如何搜集数据、处理数据、加工数据、分析数据，这样的脏活和累活，其实才是数据科学工作中最重要的工作，也是工作量最大的工作。设计模型相对来说没有那么重要。

 目前，数据处理和分析，主要使用的是 Python 语言，也有一些统计学背景的从业者使用 R 语言。当然，也有人使用 SAS，SPSS，Matlab 等付费语言和软件。

​      Python 语言中，numpy 和 Pandas 库更是数据分析的神器

日常进行一些探索性的数据分析，Python 是非常实用的工具。Python 开发效率高，可以快速编写出多个版本的代码，进行数据探索，寻找内部规律。


      但是，一旦在生产环境中部署 Python 数据分析程序，就会暴露出 Python 程序运行性能低的问题。生产环境中并发访问量有时可能很大，如果部署 Python 的数据分析程序，由于其性能较低，需要部署大量节点，使用大量计算资源来满足并发需求。这成本就比较高了。

​      而且即使部署大量资源，由于 Python 程序性能较低，也难以满足某些要求快速响应的业务场景。

​      那么，有没有什么适合数据分析且运行效率高的语言呢？R 语言行不行呢？抱歉，R 语言虽然也非常适合编写数据分析程序，但是 R 语言的运行效率比 Python 语言还低。

​      我发现 Go 语言，是替代 Python 进行高性能数据分析非常适合的语言。

Go 语言中也有对应的开源软件：gonum 和 gota。



PingCAP 数据库机遇 Mysql数据库开发的分布式数据库

**Bigtable是用于管理结构化数据的分布式存储系统**
 Bigtable旨在可靠地扩展到PB级数据和数千台计算机。



**Tableau**重点是一种图形化的，非专业统计学人士使用的分析工具，而不是一个报表工具。重点是这个分析过程。首先业务有个问题，然后在分析中发现答案，然后把分析图表发给业务人员，告诉他们分析结果。所以这种分析要求直观，能够展现数据的特点。美观是次要的。

Tableau是BI工具，可以实现简单报表展示，但更多的是图表的可视化。

而中国式报表，尤其是政企事业单位、银行业还有一些国企的特点是很明显的，主要是表格类数据报表，类目多、数据明细，十分复杂。

Tableau这种自助式BI工具重在可视化分析，复杂的中国式报表还是得通过报表软件或者excel来完成。

都说 tableau做不了 中国式报表

SmartBI的自助仪表盘 借鉴的 Tableau 可视化

**Apache Parquet**是Apache Hadoop生态系统的一种免费的，开源的，面向列的数据存储格式。它类似于Hadoop中可用的其他列存储文件格式，即RCFile和ORC。它与Hadoop环境中的大多数数据处理框架兼容。



[常见 列数据库 评价](https://news.ycombinator.com/item?id=22457767)

clickhouse只有一个外部依赖，Zookeeper

Greenplum is a Postgres fork, and same scale requires much more hardware. Citus is row based, and therefore will lag in scan time for many OLAP query patterns. Presto, Hive, Spark, all of the "post-hadoop" options may scale larger, but will also lag in scan time, and have significant external dependencies - mainly storage.

Clickhouse is easy to install, configure a cluster, load and query. It does have limitations, but currently all horizontally scaled database platforms do.



Clickhouse is extremely optimized for performing analytics on time series style data. T



It’s operationally simple in both the scale-up and the scale-down. clickhouse 相对于 pg分片 更易新增机器 。

1. Rows are sorted based on a primary key, and columns are individually stored and compressed in physical files. This enabled the data behind Tagstore to go from terabytes to gigabytes on disk.
2. Data can be queried as soon as it is written in real time. 
3. There’s no magic of a query planner. If we want to optimize a query pattern, the solutions that ClickHouse provides are few but potent. Most importantly, their ability to provide a [PREWHERE](https://clickhouse.yandex/docs/en/query_language/select/#prewhere-clause) clause enables us to skip a vast amount of data due to strong filtration conditions.



##### [ClickHouse + SuperSet](https://altinity.com/blog/visualizing-clickhouse-data-with-apache-superset-part-1-installation)



