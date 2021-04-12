# 使用 JavaScript 设置变量简介

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



 



##  动态日期参数

表输入 t-2 as tdate  -> 字段选择 -> 表输入 call proceder_name(?)->excel输出

# 英文名词

wizard 向导
metrics 度量
patents 专利



# [使用PDI构建开源ETL解决方案》](http://reader.epubee.com/books/mobile/8a/8a2a97ae8a9ebb3ec8e76c94a471416e/text00001.html)

# 第二章 kettle基本概念

解决方案：使用PDI构建开源ETL解决方案 [MATT CASTERS著；初建军，曹雪梅译]

在Kettle里，数据的单位是行，数据流就是数据行从一个步骤到另一个步骤的移动。数据流的另一个同义词就是记录流。

 ![image-20210111180844006](/Users/demo/Library/Application%20Support/typora-user-images/image-20210111180844006.png)

步骤需要有一个名字，这个名字在转换范围内唯一。

每个步骤都会读、写数据行（唯一例外是“生成记录”步骤，该步骤只写数据

■　大多数的步骤都可以有多个输出跳。一个步骤的数据发送可以被设置为轮流发送和复制发送。轮流发送是将数据行依次发给每一个输出跳（这种方式也称为round robin），复制发送是将全部数据行发送给所有输出跳。

在运行转换时，一个线程运行一个步骤和步骤的多份拷贝，所有步骤的线程几乎同时运行，数据行连续地流过步骤之间的跳。这样并发程度最高。这一规则也允许数据以最小消耗内存的数据流的方式来处理。

跳实际上是两个步骤之间的被称为行集（row set）的数据行缓存（行集的大小可以在转换的设置里定义）。当行集 满了，向行集写数据的步骤将停止写入，直到行集里又有了空间。当行集空了，从行集读取数据的步骤停止读取，直到行集里又有可读的数据行。

直到输入跳里不再有数据，就中止步骤的运行。当所有的步骤都中止了，整个转换就中止了。

String：字符类型数据。

■　Number：双精度浮点数。

■　Integer：带符号长整型（64位）。

■　BigNumber：任意精度数值。

■　Date：带毫秒精度的日期时间值。

■　Boolean：取值为true和false的布尔值。

■　Binary：



默认情况下，空字符串（""）被认为与NULL相等。参数KETTLE_EMPTY_STRING_DIFFERS_FROM_NULL来设置



| （格式）                    | 结果                    |
| --------------------------- | ----------------------- |
| yyyy/MM/dd 'T' HH:mm:ss.SSS | 2009/12/06T21:06:54.321 |

```
M-d-yy 	12-6-09
```

## 作业

大多数ETL项目都需要完成各种各样的维护工作。例如，当运行中发生错误，要做哪些操作；如何传送文件；验证数据库表是否存在，等等。而且这些操作要按照一定顺序完成。因为转换以并行方式执行，就需要一个可以串行执行的作业来处理这些操作。

一个作业包括一个或多个作业项，

![image-20210111182535554](/Users/demo/Library/Application%20Support/typora-user-images/image-20210111182535554.png)

作业项是作业的基本构成部分。如同转换的步骤，

但作业项可以有**影子拷贝**。这样可以把一个作业项放在多个不同的位置。这些影子拷贝里的信息都是相同的，编辑了一份拷贝，其他拷贝也会随之修改。

在作业项之间可以传递一个**结果对象**（result object）。这个结果对象里包含了数据行，它们不是以流的方式来传递的。而是等一个作业项执行完了，再传递给下一个作业项。

　默认情况下，所有的作业项都是以串行方式执行的，因为作业顺序执行作业项，所以必须定义一个起点，一个作业只能定义一个开始作业项。

**无条件执行**： 不论上一个作业项执行成功还是失败，下一个作业项都会执行。这是一种黑色的连接线，上面有一个锁的图标，如上图所示。

**当运行结果为真时执行**： 当上一个作业项的执行结果为真时，执行下一个作业项。通常在需要无错误执行的情况下使用。这是一种绿色的连接线，上面有一个对钩号的图标

**当运行结果为假时执行**： 当上一个作业项的执行结果为假或没有成功执行时，执行下一个作业项。这是一种红色的连接线，上面有一个红色的停止图标。

##### 多路径和回溯

Kettle使用一种回溯算法来执行作业里的所有作业项，而且作业项的运行结果（真或假）也决定执行路径。回溯算法就是：假设执行到了图里的一条路径的某个节点时，要依次执行这个 节点的所有子路径，直到没有再可以执行的子路径，就返回该节点的上一节点，再反复这个过程。

![img](http://reader.epubee.com/books/mobile/8a/8a2a97ae8a9ebb3ec8e76c94a471416e/Image00007.jpg)

```
首先“开始”作业项搜索所有下一个节点作业项，找到了“A”和“C”。

■　执行“A”。

■　搜索“A”后面的作业项，发现了“B”。

■　执行“B”。

■　搜索“B”后面的作业项，没有找到任何作业项。

■　回到“A”，也没有发现其他作业项。

■　回到Start，发现另一个要执行的作业项“C”。

■　执行“C”。

■　搜索“C”后面的作业项，没有找到任何作业项。

■　回到Start，没有找到任何作业项。

■　作业结束。

因为没有定义执行顺序，所以上面例子的执行顺序除了ABC，还可以有CAB。
```

作业也需要一个运行结果，因为一个作业可以是另一个作业的作业项。一个作业的运行结果，来自于它最后一个执行的作业项。上面的例子里作业的执行顺序可以是ABC，也可以是CAB，所以不能保证作业项C的结果就是作业的结果。

当你在作业里创建了一个循环（作业里允许循环），一个作业项就会被执行多次，作业项的多次运行结果会保存在内存里，便于以后使用

作业项并行执行

![img](http://reader.epubee.com/books/mobile/8a/8a2a97ae8a9ebb3ec8e76c94a471416e/Image00008.jpg)



设计者希望一部分作业项并行执行，然后再串行执行其他作业项。这就需要把要并行的作业项放到一个新的作业里，然后作为另一个作业的作业项，

## 作业结果

作业执行结果不仅决定了作业的执行路径，而且还向下一个作业项传递了一个结果对象

**一组数据行：** 在转换里使用“复制行到结果”步骤可以设置这组数据行。“从结果获取行”步骤可以获取这组数据行。在一些作业项里，如“Shell脚本”、“转换”、“作业”的设置里有一个选项可以循环这组数据行，这样可以通过参数化来控制转换和作业。

**一组文件名：** 在作业项的执行过程中可以获得一些文件名（通过步骤的选项：“添加到结果文件”。这组文件名是所有与作业项发生过交互的文件的名称。使用转 换里的“从结果获取文件”步骤可以获取到

**读、写、输入、输出、更新、删除、拒绝的行数和转换里的错误数**

**脚本作业项的退出状态**

JavaScript作业项

| **表达式**                                            | **数据类型** | **含义**                                               |
| ----------------------------------------------------- | ------------ | ------------------------------------------------------ |
| previous_result.getResult()                           | Boolean      | true：前一个作业项成功执行 false：前一个作业项执行错误 |
| previous_result.getExitStatus()或exit_status          | Int          | 前一个脚本作业项的退出状态码                           |
| previous_result.getEntryNr()或nr                      | Int          | 已执行的作业项的个数：每执行一个作业项增加一个         |
| previous_result.getNrErrors()或errors                 | long         | 错误个数                                               |
| previous_result.getNrLinesInput()或lines_input        | long         | 从文件或数据库里读到的行数，输入行数                   |
| previous_result.getNrLinesOutput()或lines_output      | long         | 写到文件或数据库里的行数，输出行数                     |
| previous_result.getNrLinesRead()或lines_read          | long         | 从上一个步骤里读到的行数，读行数                       |
| previous_result.getNrLinesUpdated()或lines_updated    | long         | 对文件或数据库更新的行数，更新行数                     |
| previous_result.getNrLinesWritten()或lines_written    | long         | 写到下一个步骤里的行数，写行数                         |
| previous_result.getNrLinesDeleted()或lines_deleted    | long         | 删除的行数                                             |
| previous_result.getNrLinesRejected()或lines_rejected  | long         | 发生错误被拒绝，并通过错误处理传给下一个步骤的行数     |
| previous_result.getRows()                             | List         | 结果行数                                               |
| previous_result.getResultFileList()                   | List         | 前面作业项里用到的所有文件列表                         |
| previous_result.getNrFileRetrieved()或files_retrieved | Int          | 从FTP、SFTP等处获得的文件                              |





对ETL开发者而言，要尽可能利用数据库自身的性能优势，来完成连接或排序这样的操作。如果不能在数据库里进行连接这样的操作，如数据的来源不同，也应该先在数据库里排序，以便在ETL里做连接操作。

### 事务

转换里的步骤是并行执行的，每个步骤都打开一个独立的数据库连接并开始一个事务。尽管这样在很多情况下会提高性能，但当不同步骤更新同一个表时，也会带来锁和参照完整性问题。

为解决打开多个连接而产生的问题，Kettle可以在一个事务中完成转换。转换设置对话框的选项“转换放在数据库事务中”，可以完成此功能。当选中了这个选项，所有步骤里的数据库连接都使用同一个数据库连接。只有所有步骤都正确，转换正确执行，才提交事务，否则回滚事务。

##### **数据库集群**

一般采用标识符计算余数的方法来决定分片的数据保存到哪个数据库实例里。



Spoon：图形界面工具，快速设计和维护复杂的ETL工作流。

■　Kitchen：运行作业的命令行工具。

■　Pan：运行转换的命令行工具。

■　Carte：轻量级的（大概1MB）Web服务器，用来远程执行转换或作业。一

**数据库资源库：** 数据库资源库是把所有的ETL信息保存在关系型数据库中，这种资源库比较容易创建，只要新建一个数据库连接即可。

**文件资源库：** 文件资源库是在一个文件目录下定义一个资源库，Kettle使用的是虚拟文件系统（Apache VFS——译者注），所以这里的文件目录是一个广泛的概念，包括了zip文件、Web服务、FTP服务等。

## 2.3　参数和变量

每个变量都有一个唯一的名字，而且代表着一个任意长度的字符串值。变量可以是系统级变量也可在作业内动态设置。

系统设置和用户定义。系统变量包括Java虚拟机的变量（如变量java.io.tmpdir就是系统临时文件的目录）和Kettle内部定义的变量（如Internal.Kettle.Version就是当前运行的Kettle的版本号）。

常用的方式就是把变量保存在kettle.properties文件中，（kettle.properties文件位于${KETTLE_HOME}/.kettle目录下

动态变量
转换里的“Set Variables”步骤，可以在当前作业的不同范围内设置一个变量；
使用“JavaScript”步骤或“User Defined Java Class”步骤

# faq

## 使用js设置变量

<img src="https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114111957.jpeg" alt="在这里插入图片描述" style="zoom:50%;" />

## switch case on parameter value

[
![KTR example](https://i.stack.imgur.com/kcHqD.png)](https://i.stack.imgur.com/kcHqD.png)

If it's a job scope you're referring to, then just implement the switch-case as a stream of variable evaluation:

[![KJB example](https://i.stack.imgur.com/aWMcc.png)](https://i.stack.imgur.com/aWMcc.png)

## 从数据表中查询数据作为变量传递使用(单值)

1. job

![在这里插入图片描述](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114113118.png)

1. get_tno

![在这里插入图片描述](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114113043.png)

1. insert

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200115155837614.png)
获取变量，这里注意变量这里，可以用 %%变量名%% 或 ${变量名}
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200115161328721.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzMyNjU2NTYx,size_16,color_FFFFFF,t_70)

<img src="https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114113150.png" alt="在这里插入图片描述" style="zoom:50%;" />

在表输入中使用它，Kettle中参数使用方法有两种：分别是 %%变量名%% 和 ${变量名}。这两种方法变量数据类型都是数字类型，如果传递的是string类型 需要用引号。**要点击勾选“替换SQL语句里的变量”**

## 从步骤插入数据

输出改成日志控件，直接输出查看

表输入中，使用 “?”来占位，然后“从步骤插入数据”，选择上一个步骤，然后会将数据替换占位符

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114132415)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114132316)

![img](https://cdn.jsdelivr.net/gh/k2easy/picgo/2021/01/1420210114132328)





裁剪表

**alter table [tablename] activate not logged initially with empty table**

) Tell your DBA to relax and grant you this privilege OR
b) don't truncate any table



## db2 table space cannot be accessed.

DB2中，对表进行访问时，有时会遇到以下报错：

SQL1477N  For table "<table-name>" an object "<object-id>" in table
   space "<tbspace-id>" cannot be accessed.

```
可能的原因如下：

1.）开启了不记日志的操作之后，若显示地发出了rollback命令，或者SQL因为意外情况失败（比如锁超时、内存不足等）导致事务回滚，则该表将不能访问,示例：
$ db2 +c "alter table t1 activate not logged initially"
DB20000I  The SQL command completed successfully.
$ db2 +c "insert into t1 select * from t1"
DB20000I  The SQL command completed successfully.
$ db2 "rollback"
DB20000I  The SQL command completed successfully.
$ db2 "select * from t1"
BIRTHDATE
----------
SQL1477N  For table "MIAOQINGSONG.T1" an object "5" in table space "2" cannot
be accessed.  SQLSTATE=55019

2.） HADR的环境，如果主机上有不记日志的操作或者load的时候指定了nonrecoverable选项，则备机上对应的表就不可访问了，若备机可读或者takeover以后，访问时就会遇到SQL1477N。

3.）使用了db2dart命令显示地将表标记为无效，我们知道，db2dart的 /MI 选项可以将索引标记为无效。其实也有相应的选项将表标记为无效，这个需要IBM的服务密码，具体方法请质询IBM技术支持团队。


----分割线---


具体的处理方法：
 
 没有办法使该表变得可以重新访问，只能删掉并重建。如果需要里面的数据，可以使用db2dart工具导出。
```

## unexpected batch update error committing the database connection





https://www.staroon.dev/2018/07/30/KettleDoc-7/

