# PostgreSQL 修炼之道》

2020-09第二版 

# 现状

PL/Proxy  PostgreSQL的数据水平拆分软件

pgQ 使用PostgreSQL的消息队列软件

Instagram 也大量使用pgsql

是最接近工业标砖SQL92的查询语言，能实现复杂的sql查询
pgsql是唯一能做到数据零丢失的开源数据库



支持主流多表连接查询，Nest Loop ,Hash Join ,Sort Merge JOIN
支持CTE
对正则表达式支持最强，内置函数最丰富
字段类型支持：ip地址类型，XML类型，JSON类型，UUID类型，数组类型
pgsql内置大量性能视图，方便定位问题：锁视图看到谁在等待，哪条记录被锁定
pgsql增加新列时只是在系统表上把列定义上，无需对物理结构做更新，可瞬间完成。支持在线建索引时不锁定更新操作。

支持同步复制，synchronous replication ,实现Master 和 Slave之间的零数据丢高可用复制方案。

可以方便的编写插件扩展pgsql数据库的功能， create extension ,提供外部数据源FDW框架和编程接口。
已有Oracle MySQL SQLServer等第三方插件，通过这些插件可以在pgsql数据库中方便的访问外部数据。
pgsql提供了钩子函数接口，如 pg_pathman分区表插件 citus分库分表插件。

PostGIS插件  移动端的空间索引， 解决LBS中的位置计算问题。


MySQL对SQL语法支持较弱，MySQL数据库仓库的存储引擎Infobight社区版在功能上有限制，如不支持数据更新、不支持太多的并发执行（最多支持十几个）。

plsql不仅支持复杂的SQL，还支持大量的分析函数，非常适合做数据仓库。

Instagram在使用Python+PostgreSQL结构后，几十个人就支撑起了公司的业务。高效 简洁 

ORACLE最强商业数据库 ，PostgreSQL最强开源数据库。

使用共享内存的进程结构，客户端与服务端建立一个连接后，服务器端就会启动一个进程为这个连接服务。

pgsql的WAL日志 与Oracle的Redo日志记录的都是物理块数据的变化。

PostgreSQL可以搭建同步备库  异步备库 延迟备库

RedHat安装 

1. 




TOAST是**“The Oversized-Attribute Storage Technique”（超尺寸属性存储技术）**的缩写，主要用于存储一个大字段的值。

要理解TOAST，我们要先理解**页（BLOCK）**的概念。在PG中，页是数据在文件存储中的基本单位， 默认的大小为8KB。同时，PG不允许一行数据跨页存储。那么对于超长的行数据，PG就会启动TOAST，将大的字段压缩或切片成多个物理行存到另一张系统表中（**TOAST表**），这种存储方式叫**行外存储**。



禁用索引扫描 

```
SET enable_indexscan = False;
EXPLAIN SELECT * FROM table WHERE indexed_column='some_value';
```





### EDB

数据库平台提供商 EnterpriseDB （EDB）  都基于开源数据库服务器 PostgreSQL 为企业级客户提供商业服务， 技术团队包含大部分 PostgreSQL 社区的主要贡献者。 

EDB. Power to Postgres

工具 ： Postgres Enterprise Manager 数据库监控管理工具 

SQL profile  



