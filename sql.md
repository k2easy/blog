UNION用的比较多union all是直接连接，取到得是所有值，记录可能有重复   union 是取唯一值，记录没有重复  



# Mysql5.7版本sql错误:this is incompatible with sql_mode=only_full_group_by
临时修改
set @@GLOBAL.sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
其实就是去掉了ONLY_FULL_GROUP_BY，在查询sql_mode可以看到设置成功。

永久修改
/etc/mysql/my.cnf
sql_mode="STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
service mysql restart // systemctl start mysql.service  //systemctl restart mysqld.service

mysql5.7默认也是开启了表明的大小写区分的，也可以通过修改配置文件来关闭
lower_case_table_names=1 1代表不区分大小写，0代表区分，改完后，重启mysql。





Myql 不支持 except 差集语法，postgresql支持

mysql 修改表字段默认值
alter table 表名 alter column 字段名 drop default; (若本身存在默认值，则先删除)
alter table 表名 alter column 字段名 set default 默认值;(若本身不存在则可以直接设定)

How to create a table from select query result in sqlserver?
Select * into new_table  from  old_table 



INSERT INTO tbl2 SELECT * from tbl1;
 
SELECT * FROM tbl1 INTO OUTFILE '/tmp/tbl1.txt';
LOAD DATA INFILE '/tmp/tbl1.txt' INTO TABLE tbl2;
instead of:

         
create table index_all
    select  i.id,i.name as valName,i.alias,i.unit,i.desc,i.frequency,g.name as group_name,s.name as subject_name, 
                  report.quantity as val,report.update_date 
          from t_item i,t_group g,t_subject s ,t_allindexofdailyreport report 
          where i.groupid=g.id  
          and g.subject_id=s.id 
          and i.name=report.IndexName 
          order by s.name desc ,g.name desc,i.name desc 

update `rkcr_crjcsj` set date= DATE_ADD(date,INTERVAL 2 YEAR)


# 取每组中的最新纪录
```
先将数据按照日期倒序排序（日期最新的在最前面），然后在group，这样每个分类的第一条肯定是日期最新的。
set @row=0;
select @row:=@row+1,* from (select * from `test` order by `date` desc) `temp`  group by category_id order by `date` desc
```

navicat 字段 default '默认值加上引号'

# mysql 递归查询
目录树实现 id/pid 模式，推荐 PostgreSQL XML/JSON 结构
## 向下递归
```
drop function if exists queryChildren;
create function queryChildren(id varchar(255))  
RETURNS varchar(4000)
BEGIN 
DECLARE sTemp    varchar(4000);
DECLARE sTempChd varchar(4000);
set sTemp='$';
set sTempChd= id ; -- cast(id as char);
while sTempChd is not null do 
set sTemp=concat(sTemp,',',sTempChd);
select group_concat(c_resid) into sTempChd from t_restree where find_in_set(c_pid,sTemp)>0;
end while ;
return sTemp;
end;

```
## 向上递归
```
DROP FUNCTION IF EXISTS queryChildrenAreaInfo1;
CREATE FUNCTION queryChildrenAreaInfo1(areaId INT)
RETURNS VARCHAR(4000)
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);
SET sTemp='$';
SET sTempChd = CAST(areaId AS CHAR);
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT parentId INTO sTempChd FROM t_areainfo WHERE id = sTempChd;
WHILE sTempChd <> 0 DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT parentId INTO sTempChd FROM t_areainfo WHERE id = sTempChd;
END WHILE;
RETURN sTemp;
END;
```

# Mysql 存储过程分页 海量数据分页
` call pagination(?,?,?,?)`
```
drop procedure if exists pagination;
create procedure pagination(in i_query varchar(8000), in i_page int, in i_size int, out o_total int)
  begin
    set @limit_start = (i_page - 1) * i_size;
    set @limit_size = i_size;
    set @tmp_query = concat('select * from (', i_query, ') t limit ?, ?');

    set @tmp_total = 0;
    set @tmp_stat = concat('select count(1) into @tmp_total from (', i_query, ') t ');

    prepare stmt_query from @tmp_query;
    execute stmt_query using @limit_start, @limit_size;

    prepare stmt_count from @tmp_stat;
    execute stmt_count;
    set o_total = @tmp_total;
  end;

```
## function procedure  的区别
+---------------------------------+----------------------------------------+
| Stored Procedure (SP)           | Function (UDF - User Defined           |
|                                 | Function)                              |
+---------------------------------+----------------------------------------+
| SP can return zero , single or  | Function must return a single value    |
| multiple values.                | (which may be a scalar or a table).    |
+---------------------------------+----------------------------------------+
| We can use transaction in SP.   | We can't use transaction in UDF.       |
+---------------------------------+----------------------------------------+
| SP can have input/output        | Only input parameter.                  |
| parameter.                      |                                        |
+---------------------------------+----------------------------------------+
| We can call function from SP.   | We can't call SP from function.        |
+---------------------------------+----------------------------------------+
| We can't use SP in SELECT/      | We can use UDF in SELECT/ WHERE/       |
| WHERE/ HAVING statement.        | HAVING statement.                      |
+---------------------------------+----------------------------------------+
| We can use exception handling   | We can't use Try-Catch block in UDF.   |
| using Try-Catch block in SP.    |                                        |
+---------------------------------+----------------------------------------+

# CAST(expression AS datatype(length)) 
 SELECT CAST('2017-08-25' AS datetime); # 2017-08-25 00:00:00

 # 获取字段
 select COLUMN_NAME from information_schema.COLUMNS where table_name = 'your_table_name' and table_schema = 'your_db_name';

# date_format
mysql 类似to_char() to_date()函数
　date_format(date,'%Y-%m-%d') -------------->oracle中的to_char();
　　str_to_date(date,'%Y-%m-%d') -------------->oracle中的to_date();
　%Y：代表4位的年份
　　%y：代表2为的年份
　　%m：代表月, 格式为(01……12)
　　%c：代表月, 格式为(1……12)
　　%d：代表月份中的天数,格式为(00……31)
　　%e：代表月份中的天数, 格式为(0……31)
　　%H：代表小时,格式为(00……23)
　　%k：代表 小时,格式为(0……23)
　　%h： 代表小时,格式为(01……12)
　　%I： 代表小时,格式为(01……12)
　　%l ：代表小时,格式为(1……12)
　　%i： 代表分钟, 格式为(00……59)
　　%r：代表 时间,格式为12 小时(hh:mm:ss [AP]M)
　　%T：代表 时间,格式为24 小时(hh:mm:ss)
　　%S：代表 秒,格式为(00……59)
　　%s：代表 秒,格式为(00……59)
## 时间转字符串
select date_format(now(), '%Y-%m-%d');#结果：2016-01-05
## 字符串转时间
select str_to_date('2016-01-02', '%Y-%m-%d %H');

## 时间转时间戳
select unix_timestamp(now()); #结果：1452001082
## 字符串转时间戳
select unix_timestamp('2016-01-02');

## 时间戳转时间
select from_unixtime(1451997924);#结果：2016-01-05 20:45:24
## 时间戳转字符串
select from_unixtime(1451997924,'%Y-%d');

## MySQL date、datetime和timestamp类型的区别
date保存精度到天，格式为：YYYY-MM-DD

datetime和timestamp 两者时间格式一样
timestamp"时间戳"，它是当前时间到 Unix元年(1970 年 1 月 1 日 0 时 0 分 0 秒)的秒数 
```
类型	占据字节	表示形式
datetime	8 字节	yyyy-mm-dd hh:mm:ss
timestamp	4 字节	yyyy-mm-dd hh:mm:ss

类型	表示范围
datetime	'1000-01-01 00:00:00.000000' to '9999-12-31 23:59:59.999999'
timestamp	'1970-01-01 00:00:01.000000' to '2038-01-19 03:14:07.999999'
```
### 时区
timestamp 只占 4 个字节，而且是以utc的格式储存， 它会自动检索当前时区并进行转换。
datetime以 8 个字节储存，不会进行时区的检索.
对于timestamp来说，如果储存时的时区和检索时的时区不一样，那么拿出来的数据也不一样。对于datetime来说，存什么拿到的就是什么。
还有一个区别就是如果存进去的是NULL，timestamp会自动储存当前时间，而 datetime会储存 NULL。

如果只是想表示年、日期、时间的还可以使用 year、 date、 time，它们分别占据 1、3、3 字节，而datetime就是它们的集合。

# concat
CONCAT(str1,str2,…) 
返回结果为连接参数产生的字符串。如有任何一个参数为NULL ，则返回值为 NULL。
如果自变量中含有任一二进制字符串，则结果为一个二进制字符串。
SELECT CONCAT(CAST(int_xxx AS CHAR), char_col)

CONCAT_WS(separator,str1,str2,...)
 CONCAT With Separator 
 如果分隔符为 NULL，则结果为 NULL。函数会忽略任何分隔符参数后的 NULL 值。
 mysql CONCAT_WS()不会忽略任何空字符串。 (然而会忽略所有的 NULL）。


# MySQL Procedure within a Select?
```
DELIMITER $$

CREATE PROCEDURE Ticket_FiscalTotals()
BEGIN
  DROP TEMPORARY TABLE IF EXISTS temp1;
  CREATE TEMPORARY TABLE temp1(
    Service FLOAT(10.2),
    Items FLOAT(10.2),
    SalesTax FLOAT(10.2),
    eTaxAmount FLOAT(10.2),
    GrandTotal FLOAT(10.2)
  );
  INSERT INTO temp1 VALUES (75.0, 325.0, 25.19, 8.0, 433.19);
END
$$

DELIMITER ;

-- Usage
CALL Ticket_FiscalTotals();
SELECT t.*, tmp.service FROM Ticket t, temp1 tmp;
```

# replace into ,insert into 增强版
replace into 首先尝试插入数据到表中， 1. 如果发现表中已经有此行数据（根据主键或者唯一索引判断）则先删除此行数据，然后插入新的数据。 2. 否则，直接插入新数据。
replace into t(id, update_time) values(1, now());
插入数据的表必须有主键或者是唯一索引！否则的话，replace into 会直接插入数据，这将导致表中出现重复的数据
 “into” 关键字可以省略，不过最好加上 “into”，这样意思更加直观

# REPLACE(str, find_string, replace_with)
```
drop table if exists test_de.hncity_wt;
create table hncity_wt 
SELECT
	area_id as id,
	area_name as name,
	area_parent as pid,
	replace(replace(replace(area_name,'黎族自治',''),'黎族苗族自治',''),'经济开发','') as sname 
FROM
	`dict_wt_area` 
WHERE
	( area_parent = '460000000000' OR area_parent = '469000000000' ) 
	AND area_id != '469000000000' 
ORDER BY
	area_id
```
# REGEXP_REPLACE
REGEXP_REPLACE(expr, pat, repl[, pos[, occurrence[, match_type]]])

Replaces occurrences in the string expr that match the regular expression specified by the pattern pat with the replacement string repl, and returns the resulting string. If expr, pat, or repl is NULL, the return value is NULL.
```
SELECT REGEXP_REPLACE('Stackoverflow','[A-Zf]','-',1,0,'c'); 
-- Output:
-tackover-low
```

# CAST() and CONVERT(… USING …)
CAST and CONVERT do the same thing, except that CONVERT allows more options, such as changing character set with USING.
CONVERT(value, type)
```
DATE	Converts value to DATE. Format: "YYYY-MM-DD"
DATETIME	Converts value to DATETIME. Format: "YYYY-MM-DD HH:MM:SS"
TIME	Converts value to TIME. Format: "HH:MM:SS"
CHAR	Converts value to CHAR (a fixed length string)
SIGNED	Converts value to SIGNED (a signed 64-bit integer)
UNSIGNED	Converts value to UNSIGNED (an 
 64-bit integer)
BINARY	Converts value to BINARY (a binary string)
```
CONVERT(value USING charset)
这个语句将服务器的默认字符集中的字符串 ‘abc’转化为utf8字符集中相应的字符串：
`SELECT   CONVERT('abc'   USING   utf8);`

## convert
oreder by 	convert(t.value,SIGNED) // value 是varchar类型

## order by field(...)
```
SELECT * FROM table WHERE id IN (118,17,113,23,72) 
ORDER BY FIELD(id,118,17,113,23,72)

SELECT * FROM table WHERE id IN (118,17,113,23,72) 
    ORDER BY FIND_IN_SET(id, '118,17,113,23,72');
```

## substring_index('abc.123','.',1)
abc


# 表结构设计
## 一对一
常用信息表：ID(P)，姓名，性别，年龄，身高，体重
不常用信息表：ID(P)，籍贯，家庭住址，紧急联系人
解决方案：将常用的和不常用的信息分享存储，分成两张表，找一个具有唯一性的字段来共同连接两张表。

## 一对多
母亲表：ID(P),名字，年龄，性别
孩子表：ID(P),名字，年龄，性别，母亲表ID（母亲表主键）

## 多对多
老师表 T_ID(P),姓名，性别
学生表 S_ID(P),姓名，性别
增加一张中间关系表，老师与学生的关系表：ID(P),T_ID,S_ID
老师表与中间表形成一对多的关系，而中间表是多表；维护了能够唯一找到一表的关系；
同样的学生表与中间表也是一个一对多的关系;
学生找老师：找出学生ID--->中间表寻找匹配记录（多条）--->老师表匹配（一条）
老师找学生：找出老师ID--->中间表寻找匹配记录（多条）--->学生表匹配（一条）



# 索引
mysql索引类型：FULLTEXT、NORMAL、SPATIAL、UNIQUE

## Normal 普通索引
表示普通索引，大多数情况下都可以使用

## Unique(要求列唯一)
Primary Key(primary key = unique + not null 列唯一)
Primary Key是拥有自动定义的Unique约束，但是每个表中可以有多个Unique约束，但是只能有一个Primary Key约束。

## Full Text 全文索引
表示全文搜索，在检索长文本的时候，效果最好，短文本建议使用Index,但是在检索的时候数据量比较大的时候，现将数据放入一个没有全局索引的表中，然后在用Create Index创建的Full Text索引，要比先为一张表建立Full Text然后在写入数据要快的很多

FULLTEXT 用于搜索很长一篇文章的时候，效果最好。用在比较短的文本，如果就一两行字的，普通的 INDEX 也可以。 

## SPATIAL 空间索引
空间索引是对空间数据类型的字段建立的索引，MYSQL中的空间数据类型有4种，分别是GEOMETRY、POINT、LINESTRING、POLYGON。
创建空间索引的列，必须将其声明为NOT NULL，空间索引只能在存储引擎为MYISAM的表中创建。


## btree索引和hash索引的区别
1、BTREE（B树（可以是多叉树）） {主流使用}
2、HASH（key,value） 这种方式对范围查询支持得不是很好

hash 索引结构的特殊性，其检索效率非常高，索引的检索可以一次定位，不像B-Tree 索引需要从根节点到枝节点，最后才能访问到页节点这样多次的IO访问，所以 Hash 索引的查询效率要远高于 B-Tree 索引。但是
1）Hash 索引仅仅能满足”=”,”IN”和”<=>”查询，不能使用范围查询。
（2）Hash 索引无法被用来避免数据的排序操作。

## 创建索引
1．选择唯一性索引
2．为经常需要排序、分组和联合操作的字段建立索引
3．为常作为查询条件的字段建立索引
4．限制索引的数目
5．尽量使用数据量少的索引
6．尽量使用前缀来索引
7．删除不再使用或者很少使用的索引
8. 经常更新修改的字段不要建立索引（针对mysql说，因为字段更改同时索引就要重新建立，排序，而Orcale好像是有这样的机制字段值更改了，它不立刻建立索引，排序索引，而是根据更改个数，时间段去做平衡索引这件事的）
9、不推荐在同一列建多个索引 
 




## sql优化
千万级人口表
index_id 建立索引，in()执行50s, or执行2s 命中了索引。
`	AND (t.index_id='006013' or t.index_id='006021') --  IN ( 006013, 006021 ) `

# [MySQL 对于千万级的大表要怎么优化？](https://www.zhihu.com/question/19719997)
第一优化你的sql和索引；
第二加缓存，memcached,redis；
第三以上都做了后，还是慢，就做主从复制或主主复制，读写分离，可以在应用层做，效率高，也可以用三方工具，第三方工具推荐360的atlas,其它的要么效率不高，要么没人维护；
第四如果以上都做了还是慢，不要想着去做切分，mysql自带分区表，先试试这个，对你的应用是透明的，无需更改代码,但是sql语句是需要针对分区表做优化的，sql条件中要带上分区条件的列，从而使查询定位到少量的分区上，否则就会扫描全部分区，另外分区表还有一些坑，在这里就不多说了；
第五如果以上都做了，那就先做垂直拆分，其实就是根据你模块的耦合度，将一个大的系统分为多个小的系统，也就是分布式系统；
第六才是水平切分，针对数据量大的表，这一步最麻烦，最能考验技术水平，要选择一个合理的sharding key,为了有好的查询效率，表结构也要改动，做一定的冗余，应用也要改，sql中尽量带sharding key，将数据定位到限定的表上去查，而不是扫描全部的表；mysql数据库一般都是按照这个步骤去演化的，成本也是由低到高；



日志表容量大应该放在NoSQL数据库,无容量限制。

## 设计表时要注意：
表字段避免null值出现，null值很难查询优化且占用额外的索引空间，推荐默认数字0代替null。 尽量使用INT而非BIGINT，如果非负则加上UNSIGNED（这样数值容量会扩大一倍），当然能使用TINYINT、SMALLINT、MEDIUM_INT更好。 使用枚举或整数代替字符串类型 尽量使用TIMESTAMP而非DATETIME 单表不要有太多字段，建议在20以内 用整型来存IP
 
### 整型IP
MySQL version >= 5.6.3. 支持  IS_IPV6
ip字段类型设为 VARBINARY(16).
```
You cannot store the equivalent of an IPv6 address in an integer column, as IPv6 addresses are 128 bits long, while the longest integer supported by MySQL is BIGINT UNSIGNED, which is only 64 bits. INET6_ATON() returns a VARBINARY(16) for IPv6 addresses.
```

```
UPDATE 
ip_city_country_location 
SET ip_from = IF(IS_IPV6(ip_from),INET6_ATON(ip_from), INET_ATON(ip_from)),         
    ip_to = IF(IS_IPV6(ip_to),INET6_ATON(ip_to), INET_ATON(ip_to));
```


# 为什么要选择PostgreSQL
PostgreSQL阵营： Apple  IMDB Macworld , Debian Fujitsu , Red Hat , Sun MicrosystemCisco , Skype   
MySQL阵营： GitHub , NASA ,Facebook ,Twitter, YouTube ,Tesla
 大部分传统的公司，大多选择了 PostgreSQL , 大部分互联网类似的公司使用了 MySQL
PG 被定调为对象关系数据库管理系统(ORDBMS
MYSQL 这边被定调关系数据库管理系统(RDBMS)，

如果你是传统的企业，或者你的业务逻辑比较复杂的情况下，一些公司在数据库层面的首选可能是 POSTGRESQL，因为到目前为止，你很少听说有在 MYSQL上面实现很复杂的 存储过程，函数，以及类似ORACLE 那样的SQL 的写法去加载到MYSQL中。

而互联网企业一般可能由于业务简单，以及需要更灵活的一些架构，并且开发的LEVEL 也比较高，在这些基础上，大致都在选择MYSQL 作为基础数据库，进行各种分库。

MYSQL 主键设计中的一些需要注意的地方，而如果是POSTGRESQL， 则我会持比较开放的态度，基本上不会有特别的要求。（这当然是索引组织表 VS  堆表之间的差异）从设计的角度来看可能POSTGRESQL 对开发人员更加的友好一些，初级的设计人员即使设计的不是特别NICE，也不会出太大的乱子，而MYSQL 则需要设计的人员，一开始（有ORACLE 的表设计的多年的经验，也不见得特别有用）会要求比较多，例如范式我们是不是要严格要求（当然不），以哪种观点来设计表。

 POSTGRESQL 如果出现一些功能上的需求，一般去找 extension list 而MYSQL 如果想扩展功能，一般都去找第三方的工具，


# [通过MySQL自动同步刷新Redis](https://cloud.tencent.com/developer/article/1091077)
通常：当我们在业务层有数据查询需求时，先到Redis缓存中查询，如果查不到，再到MySQL数据库中查询，同时将查到的数据更新到Redis里；当我们在业务层有修改插入数据需求时，直接向MySQL发起请求，同时更新Redis缓存。

自动同步：一旦表格有更新，就会同步到内存数据库，但还是一但UDF 崩溃会连累mysql。
MySQL的CRUD发生后自动地更新到Redis里，这需要通过MySQL UDF来实现。
我们把更新Redis的逻辑放到MySQL中去做，即定义一个触发器Trigger，监听CRUD这些操作，当操作发生后，调用对应的UDF函数，远程写回Redis，所以业务逻辑只需要负责更新MySQL就行了，剩下的交给MySQL UDF去完成。

crud是指在做计算处理时的增加(Create)、读取(Retrieve)、更新(Update)和删除(Delete)几个单词的首字母简写

UDF User Defined Function 用户定义函数
UDF比存储方法有更高的执行效率，并且支持聚集函数。
安装mysql开发包，C语言实现自定义函数 ，链接redis，触发器调用自定义函数。

缺点：UDF毕竟是通过插件的形式运行在MySQL中的，并没有过多的安全干预，一旦插件发生致命性崩溃，有可能MySQL也会挂，所以在编写UDF的时候需要非常谨慎”。如果有相当多的db，相当多的udf插件，和相当多的导出需求。这样做出问题的几率大很多。

 大规模的数据输出有两种方式定时任务ETL，写一堆脚本，结合Airflow，DataX，Kettel流处理，即读取binlog然后做后续的处理（比如阿里的canal）定时任务的稍微好维护些，但是延迟比较大（毕竟是每隔几小时，几天跑一次的，数据没有那么及时）而流处理的开发和维护难一些。
 最后的话：如果你的数据量比较大，请只把mysql当作存储用，不要考虑触发器、函数等高级功能。
 

 ## binlog
 binlog是Mysql sever层维护的一种二进制日志，与innodb引擎中的redo/undo log是完全不同的日志；其主要是用来记录对mysql数据更新或潜在发生更新的SQL语句，并以"事务"的形式保存在磁盘中；

作用主要有：

复制：MySQL Replication在Master端开启binlog，Master把它的二进制日志传递给slaves并回放来达到master-slave数据一致的目的
数据还原恢复
增量备份

Mysql数据库会以二进制形式，自动把用户对mysql数据库的操作，记录到备份文件中。
当用户希望恢复的时候，可以使用备份文件，来进行相应的恢复。
备份文件中会记录创建表的语句、删除表的语句、insert语句、delect语句、update语句等，而不会记录select语句。
增量备份记录的内容包括：
（1）操作语句本身。
（2）操作的时间。
（3）操作的位置。


Golang 有这个 siddontang/go-mysql 用来抓取 binlog， 我们在生产环境里用了很久了很可靠。
消费了写 redis/memcache，或者觉得想要往多个 redis/memcached 里写的话，可以先写到 kafka 里面再启动多个 consumer 来消费计算并存储到 redis/memcached 里


# 分布式存储 TiDB
MySQL在达到一定数据量（我的经验是3T、单表1亿）时，复杂查询会有明显的延迟。继续分库分表，会严重增加业务复杂性，尤其对很多非互联网产品来说，急需一个分布式存储。

TiDB是开源的，某些组件强制要求SSD，且需配备DBA，造成了整体成本的上升。但是使用案例较多，经历过较大规模的应用。

PolarDB。阿里新的明星产品，价格相对合理，但使用案例有限，也无法窥视其源码，只有零星宣传文档。鉴于阿里喜好夸大的尿性，需试用后进行深入评价。但云端优势太明显，已被优先考虑。通过咨询已有经验的实践者，普遍吐槽会遇到很多奇怪的问题，并不像宣传中的那么美好。

## 简介
TiDB 是 PingCAP 公司设计的开源分布式 HTAP (Hybrid Transactional and Analytical Processing) 数据库，结合了传统的 RDBMS 和 NoSQL 的最佳特性。TiDB 兼容 MySQL，支持无限的水平扩展，具备强一致性和高可用性。TiDB 的目标是为 OLTP (Online Transactional Processing) 和 OLAP (Online Analytical Processing) 场景提供一站式的解决方案。


# navicat 
           
单元格 右键选择set to NULL



# 异常解决方案

## Too many connections
造成这种情况的一种原因是访问量过高，MySQL服务器抗不住，这个时候就要考虑增加从服务器分散读压力；另一种原因就是MySQL配置文件中max_connections值过小。

查看mysql的最大连接数：
mysql> show variables like '%max_connections%';

查看服务器响应的最大连接数:
mysql> show global status like 'Max_used_connections';

服务器响应的最大连接数值占服务器上限连接数值的比例值在10%以上，如果在10%以下，说明mysql服务器最大连接上限值设置过高。

mysql> set GLOBAL max_connections=256;


连接数超过了 MySQL 设置的值，与 max_connections 和 wait_timeout 都有关系。wait_timeout 的值越大，连接的空闲等待就越长，这样就会造成当前连接数越大。

mysql> show global variables like 'wait_timeout';
wait_timeout过大有弊端 默认值为28800(即8小时)，其体现就是MySQL里大量的SLEEP进程无法及时释放，拖累系统性能，不过也不能把这个指设置的过小，否则你可能会遭遇到“MySQL has gone away”之类的问题，通常来说，我觉得把wait_timeout设置为10秒。但某些情况下可能也会出问题，比如说有一个CRON脚本，其中两次SQL查询的间隔时间大于10秒的话，那么这个设置就有问题了（当然，这也不是不能解决的问题，你可以在程序里时不时mysql_ping一下，以便服务器知道你还活着，重新计算wait_timeout时间）


mysql> set global wait_timeout=10;
生产服务器上数据库又不能随便重启，只好想办法手动去释放一些没用的连接。

mysql> show processlist；可以得到所有连接到这个服务器上的MySQL连接
mysql> kill 1180421;（其中1180421是进程列表里找到并且要杀掉的进程号）

为了防止发生too many connections时候无法登录的问题，必须只赋予root用户的SUPER权限，同时所有数据库连接的帐户不能赋予SUPER权限。前面说到的报错后无法登录就是由于我们的应用程序直接配置的root用户
查看当前数据库的所有用户:
select user,host,password from mysql.user;

给用户赋予super权限(super和ALL PRIVILEGES都可以)：
GRANT super ON *.* TO 'mysql'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'localhost';

删除用户的super权限(super和ALL PRIVILEGES都可以)：
REVOKE super ON *.* FROM 'mysql'@'localhost';
REVOKE ALL PRIVILEGES ON *.* FROM 'mysql'@'localhost';

查看赋予用户的权限
SHOW GRANTS FOR 'mysql'@'localhost'; 

## show processlist
show processlist 是显示用户正在运行的线程，需要注意的是，除了 root 用户能看到所有正在运行的线程外，其他用户都只能看到自己正在运行的线程，看不到其它用户正在运行的线程。除非单独个这个用户赋予了PROCESS 权限。

显示的信息都是来自MySQL系统库 information_schema 中的 processlist 表。
select * from information_schema.processlist
### 字段
Id: 就是这个线程的唯一标识， kill id 杀掉该进程
Command: 是指此刻该线程正在执行的命令。
Time: 表示该线程处于当前状态的时间。
State: 线程的状态，
Info: 一般记录的是线程执行的语句。默认只显示前100个字符，也就是你看到的语句可能是截断了的，要看全部信息，需要使用 show full processlist。

## state
Sleep: 正在等待客户端向它发送执行语句

### 常用sql
```
按客户端 IP 分组，看哪个客户端的链接数最多
select client_ip,count(client_ip) as client_num from (select substring_index(host,':' ,1) as client_ip from processlist ) as connect_info group by client_ip order by client_num desc;

查看正在执行的线程，并按 Time 倒排序，看看有没有执行时间特别长的线程
select * from information_schema.processlist where Command != 'Sleep' order by Time desc;

找出所有执行时间超过 5 分钟的线程，拼凑出 kill 语句，方便后面查杀
select concat('kill ', id, ';') from information_schema.processlist where Command != 'Sleep' and Time > 300 order by Time desc;
```

## mysql经典的8小时问题-wait_timeout
show global variables like 'wait_timeout' 
28800秒 即 8小时
MySQL 的默认设置下，当一个连接的空闲时间超过8小时后，MySQL 就会断开该连接，而 c3p0/dbcp 连接池则以为该被断开的连接依然有效。在这种情况下，如果客户端代码向c3p0/dbcp 连接池请求连接的话，连接池就会把已经失效的连接返回给客户端，客户端在使用该失效连接的时候即抛出异常。

 ## interactive_timeout
show global variables like '%timeout%'
(1)interactive_timeout: 服务器关闭交互式连接前等待活动的秒数
 (2)wait_timeout: 服务器关闭非交互连接之前等待活动的秒数。
 两者生效取决于：客户端是交互或者非交互的连接。
 在交互模式下，interactive_timeout才生效；非交互模式下，wait_timeout生效。


  show variables like '%max_connections%';	
 show global status like 'Max_used_connections';
 show global variables like 'wait_timeout';
show processlist; 
show global variables like '%timeout%'

-- set global max_connections =300
-- set global wait_timeout =500


# PostgreSQL
Built-in data types for Array, Range, UUID, Geolocation, etc.
Native support for document storage (JSON-style), XML, and key-value storage (Hstore)
Synchronous and asynchronous replication
Scriptable in PL, Perl, Python and more
Full-text search

geolocation engine ,use case : location-based apps — try finding all nearby points manually
部分满足 文档存储 和 key-value存储，当文档数量过大时使用其他NoSQL数据库


# 其他数据库选型
## MariaDB 
mysql源码fork版
Dynamic columns for different rows in a table.
Speed improvements over MySQL, especially due to the Aria storage engine for complex queries.
Virtual columns

mysql数据迁移到MariaDB是一次性的，不可能再由MariaDB迁移回去。

## Neo4j
graph数据库，用例：构建社会关系网络图

## MongoDB
non-relational database 
like “document database,” which means it stores data in chunks
用例：简历制作网站 Canva, where the user can create arbitrarily complex designs and be able to edit them later


## RethinkDB
 real-time apps
 When a database gets updated, there’s no way for the application to know。







