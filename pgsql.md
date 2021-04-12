#  PostgreSQL 13 Released!

 [`datetime()`](https://www.postgresql.org/docs/13/functions-json.html#FUNCTIONS-SQLJSON-OP-TABLE) function to its SQL/JSON path support, which converts valid time formats  to PostgreSQL-native types.

[`gen_random_uuid()`](https://www.postgresql.org/docs/13/functions-uuid.html), is now available without having to install any extensions.



#  手册

http://www.postgres.cn/docs/12/index.html

https://www.postgresql.org/docs/13/index.html

行文约定

> 方括弧（`[`和`]`）表示可选的部分（在 Tcl 命令里，使用的是问号 （`?`），就像通常的 Tcl 一样）。 
>
> 花括弧（`{`和`}`）和竖线（`|`）表示你必须选取一个候选。
>
>  点（`...`）表示它前面的元素可以被重复。

一个服务器进程，它管理数据库文件、接受来自客户端应用与数据库的联接并且代表客户端在数据库上执行操作。 该数据库服务器程序叫做`postgres`。       

wiki https://wiki.postgresql.org/wiki/Main_Page

createdb mydb
dropdb mydb

运行PostgreSQL的交互式终端程序，它被称为*psql*， 它允许你交互地输入、编辑和执行SQL命令。      

 

```
psql -V ,--version
psql -l ,--list 
psql --help

```

##  安装遇到问题

$ psql -l
psql: error: could not connect to server: could not connect to server: No such file or directory
	Is the server running locally and accepting
	connections on Unix domain socket "/tmp/.s.PGSQL.5432"?

To change the password, simply type `sudo passwd postgres` and set up a new password.

wiki 不利于入门，先学习 http://postgresguide.com/setup/users.html

brew install postgresql
brew info postgresql

To have launchd start postgresql now and restart at login:
  brew services start postgresql   // restart
Or, if you don't want/need a background service you can just run:
  pg_ctl -D /usr/local/var/postgres start

To migrate existing data from a previous major version of PostgreSQL run:
  brew postgresql-upgrade-database

This formula has created a default database cluster with:
  initdb --locale=C -E UTF-8 /usr/local/var/postgres

brew services --help
brew services list 

 

psql -h localhost -p 5432 

ls /usr/local/bin | grep 'postgre*' // postgres

$ cd /usr/local/Cellar/postgresql

psql 报错连接不上，brew services restart -vvv postgresql 显示如下

```
<array>
       <string>/usr/local/opt/postgresql/bin/postgres</string>
       <string>-D</string>
       <string>/usr/local/var/postgres</string>
     </array>
     <key>RunAtLoad</key>
     <true/>
     <key>WorkingDirectory</key>
     <string>/usr/local</string>
     <key>StandardOutPath</key>
     <string>/usr/local/var/log/postgres.log</string>
```

tial -100f /usr/local/var/log/postgres.log 

database files are incompatible with server
2020-10-23 11:00:18.463 CST [98807] DETAIL:  The data directory was initialized by PostgreSQL version 11, which is not compatible with this version 13.0.

brew info postgresql 

==> Caveats
To migrate existing data from a previous major version of PostgreSQL run:
  brew postgresql-upgrade-database

失败，无法从把数据文件从11升级到13八本

brew doctor 

brew cleanup

完全删除重装

```
brew uninstall postgresql

# remove all local pgsql file 
rm -rf /usr/local/var/postgres
rm -rf .psql_history .psqlrc .psql.local .pgpass .psqlrc.local

brew list --formula | grep "postgre*"
```



postgrest
Serves a fully RESTful API from any existing PostgreSQL database 

brew install postgresql 

安装过程中自动创建默认数据库存储目录 *"/usr/local/var/postgres"* ,若无则自创建
initdb /usr/local/var/postgres， **create a physical PostgreSQL Database**

$ pg_ctl --help
pg_ctl is a utility to initialize, start, stop, or control a PostgreSQL server.



```jsx
brew services stop postgres
pg_ctl -D /usr/local/var/postgres start
pg_ctl -D /usr/local/var/postgres stop

createdb test ;// CREATE DATABASE test;
psql test ;
select version(); 
exit;
```

navicat 链接 localhost 5432 , initial database: postgres ,user:demo ,password: 无。

 

```
psql --help
psql is the PostgreSQL interactive terminal.

Usage:
  psql [OPTION]... [DBNAME [USERNAME]]

General options:
  -c, --command=COMMAND    run only single command (SQL or internal) and exit
  -d, --dbname=DBNAME      database name to connect to (default: "demo")
  -f, --file=FILENAME      execute commands from file, then exit
  -l, --list               list available databases, then exit
  -v, --set=, --variable=NAME=VALUE
                           set psql variable NAME to VALUE
                           (e.g., -v ON_ERROR_STOP=1)
  -V, --version            output version information, then exit
  -X, --no-psqlrc          do not read startup file (~/.psqlrc)
  -1 ("one"), --single-transaction
                           execute as a single transaction (if non-interactive)
  -?, --help[=options]     show this help, then exit
      --help=commands      list backslash commands, then exit
      --help=variables     list special variables, then exit
      
 type "\?" (for internal commands) or "\help" (for SQL
commands) from within psql,
```

```
pgsql -h localhost -p 5432 -d pgguide
pgguide=# \?
pgguide=#
```



# 用户

```
create user admin with password 'demo2020';
create database pgguide;
postgres=# grant all privileges on database pgguide to admin; 
        // grant select  
```

导入example数据

```
curl -L -O http://cl.ly/173L141n3402/download/example.dump
pg_restore --no-owner --dbname pgguide example.dump 
提示 shema public already exists ,但是数据也成功倒入进去了
```

```
psql --dbname pgguide
```

```
pgguide=# \d   显示table列表
\d users 显示users表结构
```

# view

> "a view consists of a stored query accessible as a virtual table in a  relational database or a set of documents in a document-oriented database composed  of the result set of a query or map and reduce functions."

```
CREATE OR REPLACE VIEW employee_view AS
SELECT  ...
```

# Window functions

> unlike regular aggregate functions, use of a window function does not  cause rows to become grouped into a single output row — the rows retain  their separate identities. Behind the scenes, the window function is  able to access more than just the current row of the query result.".
>
> A window function performs a calculation across a set of table rows that are somehow related to the current row.

示例1 获取各个部门工资排名第一的员工

```sql
SELECT *
FROM
    (
        SELECT last_name,
               salary,
               department,
               rank() OVER (
                PARTITION BY department
                ORDER BY salary
                DESC
               )
        FROM employees)
    sub_query
WHERE rank = 1;	

子查询使用 rank() 窗口函数 在 department上分区排序
```

# Backup and Restore

```
psql -l //显示所有db
template1 template0 两个库是模版库，是创建其他库的模版
```

> `template1` is the one used by default, and you can alter / add objects there to affect every newly created DB. `template0` starts out being the same and should never be changed - to provide a virgin template with original settings.



[pg_dump](http://www.postgresql.org/docs/8.4/static/app-pgdump.html) is the utility for backing up your database.

- Plaintext format (readable and large) vs. binary format (unreadable and small) vs. tarball (ideal for restore)

- All of your database or specific schemas/tables

```
pg_dump database_name_here > database.sql
pg_dump -Fc database_name_here > database.bak # compressed binary format
pg_dump -Ft database_name_here > database.tar # tarball


# database already exists
pg_restore -Fc database.bak # restore compressed binary format
pg_restore -Ft database.tar # restore tarball
# database not exists
pg_restore -Fc -C database.bak # -C create 
```

excel有最大行限制，csv is text 没有最大行限制。

# COPY

-   binary
-   tab delimited
-   csv delimited

```
pgguide=# \copy (select * from users where id=1)  TO '~/employ_1.tsv';
... TO '~/employees.csv' WITH (FORMAT CSV);
... TO '~/employees.dat' WITH (FORMAT "Binary")

导入表
\copy employees FROM '~/employees.tsv';
\copy employees FROM '~/employees.csv' WITH CSV;
\copy employees FROM '~/employees.dat' WITH BINARY;
```

# Psql CLI

> Psql is the interactive terminal for working with Postgres.

-   -h the host to connect to

-   -U the user to connect with

- -p the port to connect to (default is 5432)

  psql -h localhost -U username databasename

  另一种登录方式 use a full string and let psql parse it

```
psql "dbname=dbhere host=hosthere user=userhere password=pwhere port=5432 sslmode=require"
```

## \d

 Running \? will give you a list of all available commands,

\timing  开启查询用时

\d+ 显示表信息 ， + more info

\du users

\l+   list all db

\dn+ list all schemas

\df+ list all functions

\c dbname    //connect other db

\q   quit

\e   打开psql.editor. Text editor inside psql,Pretty handy for query modifications.

可以使用正则表达式

\df *to_array* lists all functions that contain to_array in its name.函数查找

\dt 只查看table ， \ds 只蝉看sequence序列

```
-- Automatically format output based on result length and screen
\x auto
pgguide=# \x
Expanded display is on.

-- Prettier nulls
\pset null '#'

-- Save history based on database name
\set HISTFILE ~/.psql_history- :DBNAME

\dt 只显示表 不显示view 
jsonb_pretty(yourcolumnhere). This will take care of making that huge JSON blob nice and readable.
```





# date time

## Datatypes

-   Date - Date only (2012-04-25)
-   Time - Time only (13:00:00.00)
-   Timestamp - Date and Time (2012-04-25 13:00:00.00)
-   Time with Timezone - Time only (13:00:00.00 PST)
-   Timestamp with Timezone (2012-04-25 13:00:00.00 PST)
-   Interval - A span of time (4 days)

\df date_* 显示date_相关函数

## date_trunc

```sql
SELECT count(*), date_trunc('day', created_at)
FROM users
GROUP BY 2
ORDER BY 2 DESC;
```

使用2表示第二个字段，生产环境不推荐，临时(ad-hoc )使用ok

 select (now() - interval '1 month');

```sql
WHERE created_at >= (now() - interval '1 month');
//1 day , 1 days ,1 week 

select date_trunc('week',now() - interval '1 day'); -- week 今年的第几周

-- 每周注册用户数
SELECT date_trunc('week', created_at),
       count(*)
FROM users
GROUP BY 1
ORDER BY 1 DESC; 

```

## generate_series

如果某一周没有注册用户会出现时间段折线图不连续

```sql
with weeks as (
  select week
  from generate_series('2017-01-01'::date, now()::date, '1 week'::interval) week
) -- 连续时间段

SELECT weeks.week,
       count(*)
FROM weeks,
     users
WHERE users.created_at > weeks.week
  AND users.created_at <= (weeks.week - '1 week'::interval)
GROUP BY 1
ORDER BY 1 DESC;

```

## timestamps

timestamps、timestamptz（with timezone embedded in）推荐

## extract 

```sql
 select date_part('month', timestamp '2001-02-16 20:38:40')
```



# 磁盘占用

Apart from general OS level disk usage commands like `du -sh` or `df -H`, there might be situations where we might to track database/table/index size individually.

```
\l+ 显示所有库磁盘大小
pgguide=# select pg_size_pretty(pg_database_size('dbname|tableName|index')); 

 total size of a table along with all of the indexes,
 # select pg_size_pretty(pg_total_relation_size('users'));
```

# Index

> An index is a specific structure that organizes a reference to your data that makes it easier to look up.
>
> Indexes are great for accessing your data faster. However, the trade off is that for each index you have you will insert data at a slower pace. Essentially when you insert your data with an index it must write data to two places as well as maintain the sort on the index as you insert data. 
>
> Certain indexes additionally will be more effective than others, such as indexes on numbers or timestamps (text is expensive).

```sql
CREATE INDEX idx_salary ON employees(last_name, salary);
```

### Create Index Concurrently

> 当创建索引时会锁表，小表很快，大表生成索引时会造成该表一段时间无法访问。
>
>  By using CREATE INDEX CONCURRENTLY your index will be built without a long lock on the table while index built. 

```
create index concurrently idx_salary on employee(last_name,salary)
```

An example case is when your query returns a large percentage of the  data that exists in a table, it may not use the index. This is because  it is easiest to scan the table once, versus using the index then making additional lookups.

count(*) queries can be optimized with indexes thanks to index-only scans.* 

### [Covering Indexes](https://wiki.postgresql.org/wiki/Index-only_scans#Covering_indexes)

> Also since Postgres version 9.2, queries that touch only an index can be much faster. For this reason, it can be useful to include important  data with an index. Performance can be particularly improved if the  newly-created index has many fewer columns than the table being indexed, since many fewer pages must be retrieved from the disk in order to  satisfy the query.

# **explain**

Every query within Postgres has an execution plan when executed. There are three forms of running **explain** to expose this to you:

-   The generic form (only shows what is likely to happen)
-   Analyze form (which actually runs the query and outputs what does happen)
-   Verbose form (stay away)

```
EXPLAIN ANALYZE SELECT last_name FROM employees where salary >= 50000;
```

![image](https://cdn.jsdelivr.net/gh/k2easy/picgo/2020/11/0620201106135301.png)

In this case we see there's a high time spent and a sequential scan. As a result we may want to try to add an index and examine the results:

```
CREATE INDEX idx_emps on employees (salary);
```



# navicat

shortcut
cmd+y new query
cmd+r refresh 
cmd+ + add record , - delete record, 回车 保存changes

`Ctrl + /` - To comment a block of code

`Ctrl + Shift + /` - To uncomment a block of code'

navicat 不太好用，尝试下 $ brew install pgcli  # Only on macOS

[# pgcli](https://github.com/dbcli/pgcli)

```shell
$ pgcli [database_name]

or

$ pgcli postgresql://[user[:password]@][netloc][:port][/dbname][?extra=value[&other=other-value]]

$ pgcli postgresql://demo@localhost:5432
FATAL:  database "demo" does not exist

$ pgcli postgresql://demo@localhost:5432/postgres
Server: PostgreSQL 13.0

```

`SELECT * FROM <tab>` will only show table names.

`SELECT * FROM users WHERE <tab>` will only show column names.

Primitive support for `psql` back-slash commands.

Pretty prints tabular data.

```
~/.config/pgcli/config
```



[# mycli](https://github.com/dbcli/mycli)

```shell
$ brew update && brew install mycli  # Only on macOS

 mycli mysql://my_user@my_host.com:3306/my_database
```





# Conditional Constraints

> There are times where  you may want data constraints, but only want them to exist in certain cases.

By using a [Partial Indexes](http://www.postgresql.org/docs/9.1/static/indexes-partial.html) this becomes simpler by placing a unique index on only non-deleted users:

```sql
create unique index user_email on users(email) where deleted_at is null;
```

# Cache

80/20 rule with 20% of your data accounting for 80% of the reads 
实际应用中经常使用的只是少部分热点数据。

```text
SELECT
       sum(heap_blks_read) as heap_read, 
       sum(heap_blks_hit) as heap_hit, 
       (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) as ratio

FROM
     pg_statio_user_tables;
```

If you find yourself with a ratio significantly lower than 99% then you  likely want to consider increasing the cache available to your database, ...

# HStore

 *With the release of Postgres 9.4 and JSONB,* in most cases JSONB is  a better approach than simply HStore.

HStore is a key value store within Postgres. //hstore,json,jsonb

*For a more in depth comparisson you can check out [this post](https://www.citusdata.com/blog/2016/07/14/choosing-nosql-hstore-json-jsonb/) by [Citus Data](https://www.citusdata.com)*

> JSONB is a binary representation of JSON, this means it’s compressed  and more efficient for storage than just text. 
>
> Creating a GIN index on a JSONB column will create an index on every key and value within that JSON document.

# JSONB

适用场景：

- Event tracking data, where you may want to include the payload in the event which might vary。移动变换数据如：定位数据
- Gaming data is especially common, especially where you have single player  games and have a changing schema based on the state of the user // 游戏人物装备等级等
- Tools that integrate multiple data sources, an example here may be a tool  that integrates customers databases to Salesforce to Zendesk to  something else. The mix of schemas makes doing this in a multitenant  fashion more painful than it has to be.//混合第三方定义的数据

```sql
CREATE TABLE integrations (id UUID, data JSONB);
INSERT INTO integrations VALUES (
  gen_random_uuid(),
  '{
     "service": "salesforce",
     "id": "AC347D212341XR",
     "email": "craig@citusdata.com",
     "occurred_at": "8/14/16 11:00:00",
     "added": {
       "lead_score": 50
     },
     "updated": {
       "updated_at": "8/14/16 11:00:00"
     }
   }');
select data->'email' as email   from integrations where id=?

-- Extracting an attribute as text， -- text 没有引号包围
pgguide=# select data->'email' as mail  from integrations limit 1;
-[ RECORD 1 ]---------------
mail | "craig@citusdata.com"

pgguide=# select data->>'email' as mail  from integrations limit 1;
-[ RECORD 1 ]-------------
mail | craig@citusdata.com



 select *
  from integrations
	where data->'email' ? 'craig@citusdata.com'; // ? =

jsonb索引
CREATE INDEX idx_products_attributes ON products USING GIN (attributes);

-- pretty jsonb 
-- 命令行比navicat好用
pgguide=# select jsonb_pretty(data) from integrations;
-[ RECORD 1 ]+-----------------------------------------
jsonb_pretty | {                                       +
             |     "id": "AC347D212341XR",             +
             |     "added": {                          +
             |         "lead_score": 50                +
             |     },                                  +
             |     "email": "craig@citusdata.com",     +
             |     "service": "salesforce",            +
             |     "updated": {                        +
             |         "updated_at": "8/14/16 11:00:00"+
             |     },                                  +
             |     "occurred_at": "8/14/16 11:00:00"   +
             | }
             
```

```sql
select jsonb_object_keys(data) from test;


```

## jsonb_to_record

```sql
select *
from (
 values(1,2),(3,4)
) t1;

WITH t(v) AS ( VALUES
  ('{
     "a":1,
     "b":[1,2,3],
     "c":"bar",
     "d":{
        "key1":"value1",
        "key2":"value2"
     }
   }'::JSONB)
)
select * from t ;
-- :: 值类型

SELECT x1.*,x2.* FROM t,
    jsonb_to_record(v) as x1(a int,b text,c text,d jsonb),
    jsonb_to_record(v->'d') as x2(key1 text,key2 text);

 a |     b     |  c  |                  d                   |  key1  |  key2  
---+-----------+-----+--------------------------------------+--------+--------
 1 | [1, 2, 3] | bar | {"key1": "value1", "key2": "value2"} | value1 | value2
(1 row)


等同于 
SELECT id, (data->>'a')::int AS a, (data->>'b')::int AS b
         , (data->>'c')::int AS c, (data->>'d')::int AS d
FROM   test;
```

  

# TEMP TABLE

```sql
CREATE TEMP TABLE obj(a int, b int, c int, d int);
```

 

# create table

```sql
drop table if exists test;
create table test(
 id serial PRIMARY key,
 name varchar
);
comment on table test is '测试';
comment on table test.id is '自增序列号,1~';

```

查看该表的建表语句

\d  users
$ pg_dump -t 'public.users' --schema-only pgguide

\d 显示列表 type包含 table ,sequence
sequnce表是 建表时 id int serial产生的,sequence表是个自增器 ，类似mysql autoincrement。

**Sequence** 使用的是整型数值，因此它的取值范围是 [-2147483647, 2147483647] 之间；//int 32
`\ds` 命令只查看当前数据库的所有序列

select * from user_id_sequence; // last_value ,long_cnt,is_called;

### string_agg  

```
string_agg(expression, delimiter)
直接把一个表达式变成字符串

array_agg(expression)
把表达式变成一个数组 一般配合 array_to_string() 函数使用
```



```
select deptno, string_agg(ename, ',') from jinbo.employee group by deptno;

 deptno |  string_agg  
--------+--------------
     20 | JONES
     30 | ALLEN,MARTIN
```

```
数组格式 array_agg
select deptno, array_to_string(array_agg(ename),',') from jinbo.employee group by deptno;
 deptno | array_to_string 
--------+-----------------
     20 | JONES
     30 | ALLEN,MARTIN
     
select deptno, array_agg(ename) from jinbo.employee group by deptno;
 deptno |   array_agg    
--------+----------------
     20 | {JONES}
     30 | {ALLEN,MARTIN}
     
select deptno, (array_agg(ename order by hiredate asc))[1] from jinbo.employee group by deptno;
 deptno | array_agg 
--------+-----------
     20 | JONES
     30 | ALLEN
```







# Arrays

> The type of the array can be an inbuilt type, a user-defined type or an enumerated type.

```sql
create TABLE test_array(
 id serial primary key,
 name text,
 members text[]
);

insert into test_array(name,members) values('小明',ARRAY['小明1','小明2'])
update  test_array set members[1]='test' where id =1
select members[1:2] from test_array;

-- 搜索
select name from test_array where 'Mason' = ANY(members);
```

# Enumerated Data Types

```sql
-- 没有enum类型，有自定义enum
create type e_contact_method as ENUM(
 'email',
 'sms',
 'phone'
);
alter type e_contact_method add value 'facebook' after 'sms'; -- before 

select t.typname, e.enumlabel, e.enumsortorder
from pg_type t, pg_enum e 
where t.oid = e.enumtypid 
order by e.enumsortorder;

 create TABLE test_enum(
 id serial primary key,
 name e_contact_method
);

insert into test_enum(name) values('email'); -- '1' invalid input 
```

 Postgres does not provide a way to remove values from enums.

> Although `enum` types are primarily intended for static sets  of values, there is support for adding new values to an existing enum  type, and for renaming values (see `ALTER TYPE`). Existing values cannot be removed from an enum type.
>
> create a new type without the value, convert all existing uses of the old type to use the new type, then drop the old type.

```sql
ALTER TYPE admin_level1 ADD VALUE 'god';
DELETE FROM blah WHERE power = 'god'; -- or update

-- Convert to new type, casting via text representation
ALTER TABLE blah 
  ALTER COLUMN power TYPE admin_level1_new 
    USING (power::text::admin_level1_new);

-- and swap the types
DROP TYPE admin_level1;

ALTER TYPE admin_level1_new RENAME TO admin_level1;
```

# CTEs

Long complex SQL queries aren't always the most readable thing. 
cte ,common table expressions 

对比view

类似subquery 
Views can be indexed but CTE can't.

Views being a physical object on database (but does not store data  physically) and can be used on multiple queries, thus provide  flexibility and centralized approach. CTE, on the other hand are  temporary and will be created when they are used; that's why they are  called as `inline view`.

cte不适合大数据量的处理，   Dealing with 3.5 million rows in CTE will create extra overhead on  TempDb which will eventually slow down SQL Server performance. Remember, CTE is a disposable view hence no statistics are stored and you can't  create Indexes too. It is just like a sub query. 

优点：使复杂的sql简洁化

```sql
WITH user_task AS 
(
    SELECT 
        u.id AS user_id,
        p.id AS project_id,
        u.email,
        array_agg(t.name) AS task_list,
        p.title
    FROM
        project p,
        task t,
        user_ u
    WHERE
            u.id = t.user_id
        AND p.id = t.project_id
    GROUP BY
        u.id,
        p.id
),

--- Calculates the total task per each project
total_task_per_project AS 
(
    SELECT 
        t.project_id,
        count(*) as task_count
    FROM 
        task t
    GROUP BY 
        t.project_id
),

--- Calculates the projects per each user
task_per_project_per_user AS 
(
    SELECT 
        t.user_id,
        t.project_id,
        count(*) as task_count
    FROM 
        task t
    GROUP BY 
        t.user_id, 
        t.project_id
),

--- Gets user ids that have over 50% of task assigned
overloaded_user AS 
(
    SELECT 
        tpu.user_id,
        tpu.project_id
    FROM 
        task_per_project_per_user tpu,
        total_task_per_project pp
    WHERE
            tpu.project_id = pp.project_id
        AND tpu.task_count > (pp.task_count / 2)
)

SELECT 
    ut.email,
    ut.task_list,
    ut.title
FROM 
     user_task ut,
     overloaded_user ou
WHERE
         ut.user_id = ou.user_id
     AND ut.project_id = ou.project_id
;
```

 

# postgre.cn》

http://www.postgres.cn/docs/12/

```shell
createdb mydb
dropdb mydb
psql mydb
\q 退出
```

SQL 是对关键字和标识符大小写不敏感的语言，只有在标识符用双引号包围时才能保留它们的大小写。

**SQL类型**

```
int`、`smallint`、`real`、`double precision`、`char(*`N`*)`、`varchar(*`N`*)`、`date`、`time`、`timestamp`和`interval
varchar(80)
point 
```

PostgreSQL中可以定制任意数量的用户定义数据类型。因而类型名并不是语法关键字 

```
create table weather(
	city varchar(80) ,
	temp_lo int,
	temp_hi int,
	prcp real ,-- 湿度 
	date date,-- '2020-10-20'  date类型实际上对可接收的格式相当灵活,推荐如此
)     
drop table tablename;

CREATE TABLE cities (
    name            varchar(80),
    location        point  -- '(-194.0,53.0)'
);
```

`COPY`从文本文件中装载大量数据。这种方式通常更快，因为`COPY`命令就是为这类应用优化的， 只是比 `INSERT`少一些灵活性

```
COPY weather FROM '/home/user/weather.txt';
```

这里源文件的文件名必须在运行后端进程的机器上是可用的， 而不是在客户端上，因为后端进程将直接读取该文件。 

人们广泛认为在一个连接查询中限定所有列名是一种好的风格，这样即使未来向其中一个表里添加重名列也不会导致查询失败。   select t.name,b.name

```sql
SELECT *
    FROM weather, cities
    WHERE city = name;
等同于
SELECT *
    FROM weather INNER JOIN cities ON (weather.city = cities.name);
```

扫描`weather`表， 并且对每一行都找出匹配的`cities`表行。如果我们没有找到匹配的行，那么我们需要一些“空值”代替cities表的列。 这种类型的查询叫*外连接* 

```sql
SELECT *
    FROM weather LEFT OUTER JOIN cities ON (weather.city = cities.name);
```

也可以把一个表和自己连接起来。这叫做*自连接*。  

### 聚集函数

聚集`max`不能被用于`WHERE`子句中（存在这个限制是因为`WHERE`子句决定哪些行可以被聚集计算包括；因此显然它必需在聚集函数之前被计算
每个聚集结果都是在匹配该城市的表行上面计算的。我们可以用`HAVING` 过滤这些被分组的行

```sql
SELECT city, max(temp_lo)
    FROM weather
    GROUP BY city
    HAVING max(temp_lo) < 40;
```

`WHERE`在分组和聚集计算之前选取输入行（因此，它控制哪些行进入聚集计算）， 而`HAVING`在分组和聚集之后选取分组行。

因此，`WHERE`子句不能包含聚集函数；  HAVING`子句总是包含聚集函数（严格说来，你可以写不使用聚集的`HAVING`子句， 但这样做很少有用。同样的条件用在`WHERE`阶段会更有效）。   

```
DELETE FROM tablename; 将从指定表中删除所有行，把它清空。做这些之前系统不会请求你确认！ 
```

### 视图

```
CREATE VIEW myview AS
    SELECT
```

​    对视图的使用是成就一个好的SQL数据库设计的关键方面。视图允许用户通过始终如一的接口封装表的结构细节，这样可以避免表结构随着应用的进化而改变。   

​    视图几乎可以用在任何可以使用表的地方。在其他视图基础上创建视图也并不少见。   

### 外建

我们希望确保在`cities`表中有相应项之前任何人都不能在`weather`表中插入行。这叫做维持数据的*引用完整性*。正确使用外键无疑会提高数据库应用的质量，

```
CREATE TABLE weather (
        city      varchar(80) references cities(city),
```

### 事务

事务最重要的一点是它将多个步骤捆绑成了一个单一的、要么全完成要么全不完成的操作。步骤之间的中间状态对于其他并发事务是不可见的，并且如果有某些错误发生导致事务不能完成，则其中任何一个步骤都不会对数据库造成影响。   

原子更新：当多个事务并发运行时，每一个都不能看到其他事务未完成的修改。例如，如果一个事务正忙着总计所有支行的余额，它不会只包括Alice的支行的扣款而不包括Bob的支行的存款，或者反之。所以事务的全做或全不做并不只体现在它们对数据库的持久影响，也体现在它们发生时的可见性。**一个事务所做的更新在它完成之前对于其他事务是不可见的，而之后所有的更新将同时变得可见。**   

开启一个事务需要将SQL命令用`BEGIN`和`COMMIT`命令包围起来。

```
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
-- etc etc
COMMIT; -- ROLLBACK
```

PostgreSQL实际上将每一个SQL语句都作为一个事务来执行。如果我们没有发出`BEGIN`命令，则每个独立的语句都会被加上一个隐式的`BEGIN`以及（如果成功）`COMMIT`来包围它。一组被`BEGIN`和`COMMIT`包围的语句也被称为一个*事务块*。   

某些客户端库会自动发出`BEGIN`和`COMMIT`命令，因此我们可能会在不被告知的情况下得到事务块的效果。

**保存点**

​    可以利用*保存点*来以更细的粒度来控制一个事务中的语句。保存点允许我们有选择性地放弃事务的一部分而提交剩下的部分。在使用`SAVEPOINT`定义一个保存点后，我们可以在必要时利用`ROLLBACK TO`回滚到该保存点。该事务中位于保存点和回滚点之间的数据库修改都会被放弃，但是早于该保存点的修改则会被保存。   

不管是释放保存点还是回滚到保存点都会释放定义在该保存点之后的所有其他保存点。   

当提交整个事务块时，被提交的动作将作为一个单元变得对其他会话可见，而被回滚的动作则永远不会变得可见。   

`ROLLBACK TO`是唯一的途径来重新控制一个由于错误被系统置为中断状态的事务块，

```sql
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
-- oops ... forget that and use Wally's account
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;
```

### 窗口函数

​    一个*窗口函数*在一系列与当前行有某种关联的表行上执行一种计算。这与一个聚集函数所完成的计算有可比之处。**但是窗口函数并不会使多行被聚集成一个单独的输出行，**这与通常的非窗口聚集函数不同。取而代之，行保留它们独立的标识。在这些现象背后，窗**口函数可以访问的不仅仅是查询结果的当前行。**   

```sql
SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
```

第四列表示对与当前行具有**相同**`depname`值的所有表行取得平均值（这实际和非窗口`avg`聚集函数是相同的函数，但是`OVER`子句使得它被当做一个窗口函数处理并在一个合适的窗口帧上计算。）。   

可以通过`OVER`上的`ORDER BY`控制窗口函数处理行的顺序（窗口的`ORDER BY`并不一定要符合行输出的顺序

```sql
SELECT depname, empno, salary,
       rank() OVER (PARTITION BY depname ORDER BY salary DESC) FROM empsalary;
```

```
  depname  | empno | salary | rank
-----------+-------+--------+------
 develop   |     8 |   6000 |    1
 develop   |    10 |   5200 |    2
 develop   |    11 |   5200 |    2
 develop   |     9 |   4500 |    4
 develop   |     7 |   4200 |    5
 personnel |     2 |   3900 |    1
 personnel |     5 |   3500 |    2
 sales     |     1 |   5000 |    1
 sales     |     4 |   4800 |    2
 sales     |     3 |   4800 |    2
(10 rows)
```

一个窗口函数调用总是包含一个直接跟在窗口函数名及其参数之后的`OVER`子句。这使得它从句法上和一个普通函数或非窗口函数区分开来。`OVER`子句决定究竟查询中的哪些行被分离出来由窗口函数处理。`OVER`子句中的`PARTITION BY`子句指定了将具有相同`PARTITION BY`表达式值的行分到组或者分区。对于每一行，窗口函数都会在当前行同一分区的行上进行计算。   

一个窗口函数所考虑的行属于那些通过查询的`FROM`子句产生并通过`WHERE`、`GROUP BY`、`HAVING`过滤的“虚拟表”。
在一个查询中可以包含多个窗口函数，每个窗口函数都可以用不同的`OVER`子句来按不同方式划分数据，但是它们都作用在由虚拟表定义的同一个行集上。   

如果行的顺序不重要时`ORDER BY`可以忽略。`PARTITION BY`同样也可以被忽略，在这种情况下会产生一个包含所有行的分区。   

```
SELECT salary, sum(salary) OVER () FROM empsalary;

 salary |  sum
--------+-------
   5200 | 47100
   5000 | 47100
   3500 | 47100
   4800 | 47100
   3900 | 47100
   4200 | 47100
```

**`OVER`子句中没有`ORDER BY`，窗口帧和分区一**样
**缺少`PARTITION BY`则和整个表一样**

对于每一行，在它的分区中的行集被称为它的窗口帧。 一些窗口函数只作用在*窗口帧*中的行上，而不是整个分区。// 在分区中的当前范围内的行集合就是窗口帧

默认情况下，如果使用`ORDER BY`，则帧包括**从分区开始到当前行的所有行**，**以及后续任何与当前行在`ORDER BY`子句上相等的行**。如果`ORDER BY`被忽略，则默认帧包含整个分区中所有的行。

```
SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;
 salary |  sum
--------+-------
   3500 |  3500
   3900 |  7400
   4200 | 11600
   4500 | 16100
   4800 | 25700
   4800 | 25700
   5000 | 30700  
   5200 | 41100 //order by salary,salary相同则当前行延伸，则属于同一个窗口帧
   5200 | 41100
   6000 | 47100
(10 rows)
这里的合计是从第一个（最低的）薪水一直到当前行，包括任何与当前行相同的行（注意相同薪水行的结果）。 
```

窗口函数只允许出现在查询的`SELECT`列表和`ORDER BY`子句中。它们不允许出现在其他地方，例如`GROUP BY`、`HAVING`和`WHERE`子句中。**这是因为窗口函数的执行逻辑是在处理完这些子句之后。**另外，**窗口函数在非窗口聚集函数之后执行。**这意味着可以在窗口函数的参数中包括一个聚集函数，但反过来不行。   

如果需要在窗口计算执行后进行过滤或者分组，我们可以使用子查询

```sql
SELECT  *
FROM
  (SELECT  rank() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
     FROM empsalary
  ) AS ss
WHERE pos < 3;
```

如果多个窗口函数要求同一个窗口行为时，这种做法是冗余的而且容易出错的。替代方案是，每一个窗口行为可以被放在一个命名的`WINDOW`子句中，然后在`OVER`中引用它。

```sql
SELECT sum(salary) OVER w, avg(salary) OVER w
  FROM empsalary
  WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);		
```

### 继承

继承是面向对象数据库中的概念。它展示了数据库设计的新的可能性。   
尽管继承很有用，但是它还未与唯一约束或外键集成，这也限制了它的可用性。

```
CREATE TABLE cities (
  name       text,
  population real,
  altitude   int     -- (in ft)
);

CREATE TABLE capitals (
  state      char(2)
) INHERITS (cities);

SELECT name, altitude
    FROM ONLY cities
    WHERE altitude > 500;
```

`ONLY`用于指示查询只在`cities`表上进行而不会涉及到继承层次中位于`cities`之下的其他表。很多我们已经讨论过的命令 — `SELECT`、`UPDATE` 和`DELETE` — 都支持这个`ONLY`记号。   



# fedora

Red Hat 所有的软件产品全部是开源（Open Sourced) 的。注意是“所有”，无一例外！红帽所有的企业级产品，一定对应一个社区版产品.

如**RHEL的社区版就是Fedora** 
Redhat是把Fedora作为RHEL的试验田，就是说在Fedora上会尽量使用一些最新的内核特性和用户层工具，等试验的差不多了，RHEL某个系列的Alpha版就直接Base在Fedora之上。
CentOS只是社区对RHEL的编译版本，跟RHEL应该差别不大。

我眼中的各linux发行版Fedora: 小白鼠，Red Hat 經常會往上強推一些不考慮兼容性的大變更。
Arch: 高效，輕量，面向專業用戶，有一定危險性。
Ubuntu: 面向初級用戶，比較傻瓜，靠能幹的妹妹（Debian）照料。
Red Hat: 企業級別技術支持。爲了穩定性所以經常比較老舊。
CentOS: 本質上和 Red Hat 的內容是一致的，但是沒有技術支持。兼顧 Red Hat 劣勢（老舊）和別的快速發行版的劣勢（沒有技術支持）。
Gentoo: 完全自己定製自己編譯，對自己全權負責，面向「真正」專業的用戶，能做到很多別的發行版做不到的事情，同時耗費時間（編譯）和金錢（電能）。
openSuSE: 美觀漂亮，有個強大的系統配置工具（yast）無微不至地照顧你，面向初級用戶。
slackware: 堅持老舊的觀念（用戶應該自己管理包依賴）和古典美學。
Debian: 能幹而靠譜，是 Ubuntu 的妹妹但是比 Ubuntu 靠譜很多。
Mint：就是Ubuntu帶個面具



where   record ~ '^[^0-9]+$'; //不包含数字的



# SQL 语言

## 字符串常量

当字符串中包含了很多单引号或反斜线时很难理解它，因为每一个都需要被双写。要在这种情形下允许可读性更好的查询，PostgreSQL提供了另一种被称为“美元引用”的方式来书写字符串常量。
一个美元引用的字符串常量由一个美元符号（`$`）、一个可选的另个或更多字符的“标签”、另一个美元符号、一个构成字符串内容的任意字符序列、一个美元符号、开始这个美元引用的相同标签和一个美元符号组成。

```
$$Dianne's horse$$
$SomeTag$Dianna's horse$SomeTag$
```

在一个美元引用字符串中不需要对字符进行转义：字符串内容总是按其字面意思写出。

可以通过在每一个嵌套级别上选择不同的标签来嵌套美元引用字符串常量。这最常被用在编写函数定义上。

```
$function$
BEGIN
    RETURN ($1 ~ $q$[\t\r\n\v\\]$q$);
END;
$function$
```

标签是大小写敏感的，因此`$tag$String content$tag$`是正确的，但是`$TAG$String content$tag$`不正确。

一个跟着一个关键词或标识符的美元引用字符串必须用空白与之分隔开，否则美元引用定界符可能会被作为前面标识符的一部分。    

美元引用不是 SQL 标准的一部分，但是在书写复杂字符串文字方面，它常常是一种比兼容标准的单引号语法更方便的方法。

**位串常量**
B'1001'
**数字常量**

```
digits
digits.[digits][e[+-]digits]
[digits].digits[e[+-]digits]
digitse[+-]digits

//合法数字常量示例
42
3.5
4.
.001
5e2
1.925e-3
```

如果使用了小数点，在小数点前面或后面必须至少有一个数字。如果存在一个指数标记（`e`），在其后必须跟着至少一个数字。

如果一个不包含小数点和指数的数字常量的值适合类型`integer`（32 位），它首先被假定为类型`integer`。否则如果它的值适合类型`bigint`（64 位），它被假定为类型`bigint`。再否则它会被取做类型`numeric`。包含小数点和/或指数的常量总是首先被假定为类型`numeric`。    
一个数字常量初始指派的数据类型只是类型转换算法的一个开始点。在大部分情况中，常量将被根据上下文自动被强制到最合适的类型。必要时，你可以通过造型它来强制一个数字值被解释为一种指定数据类型。例如，你可以这样强制一个数字值被当做类型`real`（`float4`）：

```
类型转换
REAL '1.23' -- string style
1.23::REAL -- pgsql historical style
```

```
type 'string'  // or typename ( 'string' )  // type语法无法对数组类型工作，指定一个数组常量的类型可使用::或CAST()。 
'string'::type
CAST ( 'string' AS type )
```

## 操作符

```
+ - * / < > = ~ ! @ # % ^ & | ` ?
```

特殊字符

- 跟随在一个美元符号（`$`）后面的数字被用来表示在一个函数定义或一个预备语句中的位置参数。在其他上下文中该美元符号可以作为一个标识符或者一个美元引用字符串常量的一部分。     

-  冒号（`:`）被用来从数组中选择“切片”
- 方括号（`[]`）被用来选择一个数组中的元素。

### 注释

-- ，也可以使用 C 风格注释块：

```
/* multiline comment
 * with nesting: /* nested block comment */
 */
```

可以注释掉一大段可能包含注释块的代码。   

### 操作符优先级

大部分操作符具有相同的优先并且是左结合的。操作符的优先级和结合性被硬写在解析器中。

当使用二元和一元操作符的组合时，有时你将需要增加圆括号。

```
SELECT 5 ! - 6;
被解析成 select 5 ! (-6);
```

因为解析器不知道 — 知道时就为时已晚 — `!`被定义为一个后缀操作符而不是一个中缀操作符。在这种情况下要得到想要的行为，你必须写成：

select (5!) - 6;



## 值表达式

### 位置参数

```
create function dept(text) return dept
 as $$ select * from dept where name = $1 $$
 language sql;
 -- $1引用函数被调用时第一个函数参数的值。 
```

### 数组下标

expression[subscript]
expression[lower_subscript:upper_subscript] // 数组切片
每一个*`下标`*自身是一个表达式，它必须得到一个整数值。   

```
mytable.arraycolumn[4]
mytable.two_d_column[17][34]
$1[10:42]
(arrayfunction(a,b))[42]
```

### 域选择

```
expression.fieldname

mytable.mycolumn
$1.somecolumn
(rowfunction(a,b)).col3
(compositecol).*
```

### 函数调用

```
function_name ([expression [, expression ... ]] )
sqrt(2) // 可能受限于一个模式名
```

### 聚集表达式

```
aggregate_name (expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ] 
aggregate_name (DISTINCT expression [ , ... ] [ order_by_clause ] ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name ( * ) [ FILTER ( WHERE filter_clause ) ]
aggregate_name ( [ expression [ , ... ] ] ) WITHIN GROUP ( order_by_clause ) [ FILTER ( WHERE filter_clause ) ]
```

大部分聚集函数忽略空输入，这样其中一个或多个表达式得到空值的行将被丢弃。除非另有说明，对于所有内建聚集都是这样。   
例如，`count(*)`得到输入行的总数。`count(f1)`得到输入行中`f1`为非空的数量，因为`count`忽略空值。而`count(distinct f1)`得到`f1`的非空可区分值的数量。   

一般地，交给聚集函数的输入行是未排序的。在很多情况中这没有关系，例如不管接收到什么样的输入，`min`总是产生相同的结果。但是，某些聚集函数（例如`array_agg` 和`string_agg`）依据输入行的排序产生结果。当使用这类聚集时，可选的*`order_by_clause`*可以被用来指定想要的顺序。

*`order_by_clause`*与查询级别的`ORDER BY`子句具有相同的语法，除了它的表达式总是仅有表达式并且不能是输出列名称或编号。//数字只带输出列，排序。

```
SELECT array_agg(a ORDER BY b DESC) FROM table;
SELECT string_agg(a, ',' ORDER BY a) FROM table;//多参数聚集函数
```

❓如果在*`order_by_clause`*之外指定了`DISTINCT`，那么所有的`ORDER BY`表达式必须匹配聚集的常规参数。也就是说，你不能在`DISTINCT`列表没有包括的表达式上排序。   

⚠️  在一个聚集函数中指定`DISTINCT`以及`ORDER BY`的能力是一种PostgreSQL扩展。    



有序集聚集的典型例子包括排名和百分位计算。

如果指定了`FILTER`，那么只有对*`filter_clause`*计算为真的输入行会被交给该聚集函数，其他行会被丢弃

```
 create table test(id int, c1 int);  
 insert into test select generate_series(1,10000), random()*10;  
```



```sql
SELECT
    count(*) AS unfiltered,
    count(*) FILTER (WHERE i < 5) AS filtered
FROM generate_series(1,10) AS s(i);
```

```sql
SELECT percentile_cont(0.5) WITHIN GROUP (ORDER BY income) FROM households;
```

一个聚集表达式只能出现在`SELECT`命令的结果列表或是`HAVING`子句中。在其他子句（如`WHERE`）中禁止使用它，因为那些子句的计算在逻辑上是在聚集的结果被形成之前。   

❓ within group

## 窗口函数调用

也叫做 窗口聚集函数

```
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ([expression [, expression ... ]]) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER window_name
function_name ( * ) [ FILTER ( WHERE filter_clause ) ] OVER ( window_definition )
```

其中*`window_definition`*的语法是

```
[ existing_window_name ]
[ PARTITION BY expression [, ...] ]
[ ORDER BY expression [ ASC | DESC | USING operator ] [ NULLS { FIRST | LAST } ] [, ...] ]
[ frame_clause ]
```

可选的*`frame_clause`*是下列之一

```
{ RANGE | ROWS | GROUPS } frame_start [ frame_exclusion ]
{ RANGE | ROWS | GROUPS } BETWEEN frame_start AND frame_end [ frame_exclusion ]
```

​    其中*`frame_start`*和*`frame_end`*可以是下面形式中的一种

```
UNBOUNDED PRECEDING
offset PRECEDING
CURRENT ROW
offset FOLLOWING
UNBOUNDED FOLLOWING
```

​    而*`frame_exclusion`*可以是下列之一

```
EXCLUDE CURRENT ROW
EXCLUDE GROUP
EXCLUDE TIES
EXCLUDE NO OTHERS
```

 这里，*`expression`*表示任何自身不含有窗口函数调用的值表达式。   

一个*窗口函数调用*表示在一个查询选择的行的某个部分上应用一个聚集类的函数。

 窗口函数能够根据窗口函数调用的分组声明（`PARTITION BY`列表）访问属于当前行所在分组中的所有行。



http://www.postgres.cn/docs/12/sql-expressions.html

暂停

```sql
select d::date as start_date,(d + '1 month'::interval - '1 day'::interval )::date end_date
from generate_series('2014-01-01'::date, '2014-06-30'::date, '1 month'::interval) d
```

```sql
select CURRENT_DATE + i 
from generate_series(date '2012-06-29'- CURRENT_DATE, 
     date '2012-07-03' - CURRENT_DATE ) i
```

or even shorter:

```sql
select i::date from generate_series('2012-06-29', 
  '2012-07-03', '1 day'::interval) i
```





```sql
ALTER TABLE place
  MODIFY( street_name VARCHAR2(20),
          county      VARCHAR2(20),
          city        VARCHAR2(20) )
```