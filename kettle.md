# 简介

Kettle是一个Java编写的ETL工具，从4.2版本开始遵守Apache Licence  2.0协议，最新稳定版为7.1。Kettle在2006年初加入了开源的BI公司Pentaho, 正式命名为：Pentaho Data  Integeration，简称“PDI”。自2017年9月20日起，Pentaho已经被合并于日本日立集团下的新公司： Hitachi  Vantara。企业版Kettle不是免费独立的，而是集成在Pentaho Business Analytics商业套件中。

Kettle不支持实时数据同步场景。尽管kettle可以使用trigger方式获取表级的增量数据，但源端的应用系统方一般不会同意使用这种侵入性很强的方式，而且trigger方式无法保证事务复制的完整性和时间次序性。

Kettle交换性能往往达不到要求。由于kettle采用了二十多年前老旧的Java调用技术，在任务多、数据量大的场景下，往往消枆过大的计算资源，交换性能急剧下降，造成系统阻塞的状况出现。

Kettle对断点信息没有记录和保存，无法保证断点续传及数据不丢失等可靠性要求。

Kettle的ETL  处理流程与目标输出耦合性强，新的数据要求往往会造成处理流程的重新设计，灵活性差，导致时间周期和成本不断增加。新出现的ELT（把T-处理放在了末端数仓中处理）技术架构和方案，将抽取、加载过程与转换过程分开，并将所有需要的全量和实时增量数据快速加载至数仓，意味着在数仓结构设计中更具有灵活性来考虑新的变化需求，有利于项目的运维和管理，将项目的风险最小化。

日益增加的异构数据源环境，包括各种关系型数据库、结构化及非结构化数据、以及NoSQL、MPP数据库/仓库和大数据平台Hadoop/Kafka的应用环境，Kettle缺乏对新数据源的有效支持能力。

免费版的Kettle缺乏必要的数据异常处理和监控运维等管理功能服务，项目开发商/服务商在项目成本及时间的约束下，难于满足这类管理功能需求，造成后续系统运维质量及用户满意度的下降。

在企业私有云和混合云的计算环境下，Kettle等传统产品的C/S架构难于满足构建云与边缘端的数据交换，并支持远程多用户共享使用的要求。

下载地址https://sourceforge.net/projects/pentaho/files/Data%20Integration/7.1/





# ETL工具比较

Kettle
 Pentaho 旗下的 ETL 工具，有商业版本和开源版本两种，开源的由 sourceforge 维护

In Pentaho you’ll define your jobs on a canvas and configure settings  through UI panes. In Airflow everything is defined within Python modules

Apache NiFi is a dataflow management platform. 



![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1820201118201106.jpg)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1820201118201131.jpg)

kettle为绿色软件，解压缩到任意本地路径即可

双击Spoon.bat，启动图形化界面工具，就可以直接使用了



## [ 使用Kettle导入Excel数据](https://blog.devzeng.com/blog/load-excel-data-with-kettle.html)

新建转换，拖入excel输入





# kettle数据同步的五种方案

数据同步：当数据源发生改变时，其他相关数据也跟着发展变化。

1.触发器

在数据库建立增删改的触发器。触发器将变更放到一张临时表里。oracle同步cdc

优点：实时同步
 缺点：影响到业务系统，因为需要在业务系统建立触发器

2.日志

通过分析源数据库日志，来获得源数据库中的变化的数据。oracle异步cdc

优点：不影响业务系统
 缺点：有一定得延时，对于没有提供日志分析接口的数据源，开发的难度比较大

3.时间戳

在要同步的源表里有时间戳字段，每当数据发生变化，时间戳会记录发生变化的时间

优点：基本不影响业务系统
 缺点：要求源表必须有时间戳这一列

4.数据比较

通过比较两边数据源数据，来完成数据同步。一般用于实时性要求不高的场景。

优点：基本不影响业务系统
 缺点：效率低

\5. 全表拷贝

定时清空目的数据源，将源数据源的数据全盘拷贝到目的数据源。一般用于数据量不大，实时性要求不高的场景。

优点：基本不影响业务系统，开发、部署都很简单
 缺点：效率低
 总结：
 \1. 上面五种数据同步方式，除了第五种都需要业务表有主键。
 \2. 对于没有触发器和日志的一些小型数据源，如txt 文本，excel 文件，Aceess，则只能使用后三种方式。

\3. 对于大型数据源，一般优先选择日志方式，如 ORCALE Asynchronized CDC, 对于不能通过日志来实现的情况，可以考虑第1，3，4种方式。

要实现**实时的增量更新**共有两种方法：

1.通过触发器。在要抽取的表上建立需要的触发器，一般要建立插入、修改、删除三个触发器，每当源表中的数据发生变化，就被相应的触发器将变化的数据写入一个临时  表，抽取线程从临时表中抽取数据，临时表中抽取过的数据被标记或删除。触发器方式的优点是数据抽取的性能较高，缺点是要求业务表建立触发器，对业务系统有 一定的影响。
  2.通过时间戳。我是在两边[数据库](http://lib.csdn.net/base/mysql)的表里插入了一列（用来取数据变动时的时间），然后做个计划任务，设置每隔多少时间跑一次kettle，就行了。要实现“实时”，就只能把时间间隔设小一点。



## [使用触发器+快照表 进行数据增量更新](https://blog.csdn.net/demonson/article/details/79852191)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119143700.png)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119143720.png)

## [Kettle：利用设置变量(时间戳)实现数据增量更新](https://blog.csdn.net/demonson/article/details/79852212)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119155012.png)

下面在“表输入”环节中，使用传递过来的${MAXSJ}作为条件，完成向目标表插入数据，简要流程如下：

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119155030.png)

**果每次都是全表max，当数据量特别大时，效率将大打折扣。而此时，我们就需要添加一个时间戳记录表，另添加一个时间戳字段，每次抽取结束后，将每次抽取后最晚一条记录的时间戳时间记录到时间戳表中，然后每次查询起点时间时只需要从时间戳表中提取即可。**

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119155053.png)





#### 数据连接的重复使用

打开一个转换点击程序左边的主对象树，点击DB连接，展开，你会看到你当前所创建的连接，如果该连接是可复用的，那么字体会是粗黑，否则就是浅黑，我们找到浅黑的鼠标右键点击，会出现一个对话框，选择共享就好







# [ETL系列](https://www.jianshu.com/u/5355ffe834cc)

（extract）、交互转换（transform）、加载（load）

## Kettle Spoon数据库连接

**数据库表连接信息变量值选择**

在安装目录下找到“.kettle”文件夹，找到kettle.properties文件；使用编辑器打开kettle.properties文件，在文件底部添加新的数据库连接信息后保存文件。

```
kettle_mysql_host=10.11.255.60

kettle_mysql_port=63306

kettle_mysql_database=kett***

kettle_mysql_username=root

kettle_mysql_password=Encrypted************09409fe62d2b38cff 
```

还可以在Spoon 的【编辑】-【编辑kettle.properties】进行编辑。



数据库连接界面，在输入框中添加存在于kettle.properties文件的变量名

•  变量名输入，注意输入格式为“${变量名}”

•  变量名选择，使用CTRL-ALT-SPACE选择一个变量



**全局数据源和局部数据源**

在kettle.properties文件中定义好的数据库信息，可以作为全局数据源来使用，在后续的转化脚本和工作脚本可以使用数据库信息。

临时性的变量配置是属于某个配置的转换文件或工作文件
编辑-设置环境变量



通过右击【DB连接】中的数据库名称进行【共享】操作，将该数据源变更为全局数据源。

**kettle.properties变量未生效的原因**

将.kettle文件夹复制一份到【C盘】-【用户】文件夹下，重启spoon后，再打开。

## 转换

转换场景很多，处理源表到目标表的ETL场景转化场景主要有：

> 1、单表间直接转换
>
> 2、字段合并与字段拆分
>
> 3、行转列与列转行
>
> 4、字段的规格化清洗
>
> 5、字段的衍生计算
>
> 6、多表关联同步至单表与单表同步到多表 

**文件 → 新建 → 转换，** 新建一个**转换**；或者在欢迎页tab，主对象树窗口双击**转换**快速新建。

表输入插件是为了查询来源数据，也就是抽取的数据，

表输入配置完成后，保存转换文件，可点击【运行这个转换】按钮进行本地运行。

点击左侧的 **核心对象** ，选择 **插入/更新** 并把它拖到右侧的编辑区中，按住 **shift键**连接 “表输入”。

表输出插件是为了将抽取数据输出到目标表，进行目标表字段唯一索引字段的配置，根据唯一索引，查看数据是否存在，当数据存在，更新数据；若不存在，则插入数据；

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119162430.png)

用来查询的关键字，选择id，表示这里按照id查询，如果此id存在，则更新数据，若不存在则插入数据；将目标表字段和来源表的流字段的映射关系进行匹配后，点击保存即可。

## 字段合并与字段拆分

抽取数据：抽取来源库A的数据表A的数据**，可以定义抽取数据范围；**

拖选【表输入】插件，为了方便业务理解，可以将插件重命名。

 **核心对象** ，选择 **javaScript脚本** 并把它拖到右侧的编辑区中，按住 **shift** 画线连接 “表输入（查询来源数据）”。

javaScript代码脚本提供了很多转换函数，在进行字段的转化过程中比较方便。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119163127.png)

配置完成后，保存转换文件，可点击【运行这个转换】按钮进行本地运行。

几步测试运行一次，看控制台是否报错，当前流程是否正常

，除了这种字段合并转化方式，我们可以使用SQL语句中 CONCAT函数更方便地进行字段合并后推送。

**表输入** 
select concat(1,2) as resName

### 字段拆分

如【湖北省武汉市东湖新技术开发区】，映射到目标表需要拆分为【湖北省】、【武汉市】、【东湖新技术开发区】,

选择**拆分字段**并把它拖到右侧的编辑区中进行拆分字段配置。

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119164849.png)



![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/1920201119165000.png)



**【方式二】-使用SUBSTRING 函数进行字段拆分**

表输入 select SUBSTRING_INDEX(used_name, '->', 1) AS used_name，代表截取来源表中used_name字段第1个 '->' 之前的所有字符；

AS 后是来源表抽取后的流字段。

## 行转列与列转行

常见的行转列（横表转竖表）与列转行（竖表转横表）例子以方便理解。

![img](https://upload-images.jianshu.io/upload_images/1321052-0a7e34b29cc6a0c1.png?imageMogr2/auto-orient/strip|imageView2/2/w/247)

横表示例

![img](https://upload-images.jianshu.io/upload_images/1321052-b2c7f1285ca033c1.png?imageMogr2/auto-orient/strip|imageView2/2/w/193)

竖表示例

> 横表的特点是一个ID对应所有的值信息，以行Key-Value1-Value2-Value3的方式存储；
>
> 竖表的特点是每行仅存储该ID的某一个类别字段的值，以行Key-Value的方式存储。

**行转列**是指横表转竖表，**列转行**是指竖表转横表。



表输出 裁剪表truncate 



union all 字段顺序 需要 保持一致

## 数据分发和复制

![ETL工具kettle的数据分发和复制的区别](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2620201126161921.png)

第一个连接就是 分发，第二个就是复制，复制有一个书页的标志；

右键数据发送：**Round-Robin**代表分发，复制模式就是复制
如果下个节点获取不到数据，改为分发。

这两种方式的区别是，分发会将一份数据按照发扑克牌一样分给下一个组件，数据始终都只有一份，而复制则是不一样，他会将一份数据复制n份给下一个组件，而这个N是多少呢取决于下一个组件的数量，举两个例子

![ETL工具kettle的数据分发和复制的区别](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/2620201126162021.png)



## ETL系列七：核心转换场景-规格化清洗

**操作方式1：通过JavaScript 函数进行数据清洗**

自定义常量数据 用来创建静态数据表

**字符串替换** ，“*\d.*[、，。,】）)[]【】（）()（【[]"  ""

**通过SQL函数进行数据清洗**
表输入 ，CAST(PUBLISHDATE  AS DATE)

**通过获取系统信息插件进行数据清洗**

