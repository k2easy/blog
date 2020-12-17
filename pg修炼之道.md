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





navicat 

idea 

office 

 