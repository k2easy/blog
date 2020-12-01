# db2 语法示例



```sql
 SELECT emp.EMPNO, emp.SALARY
 FROM (

     SELECT EMPNO, SALARY, 
            ROW_NUMBER() OVER(ORDER BY SALARY DESC) as row_number
     FROM EMPLOYEE

 ) emp
 WHERE emp.row_number > 10
 AND emp.row_number <= 20
```

#  [db2字符串函数](https://www.cnblogs.com/zhaoshuangshuang/archive/2012/09/23/2699172.html)



values length('中')
DB2一个汉字占3个字节，Oracle占两个字节。

locate(String param1,String param2,int param3)  从param2的第param3位置开始,返回param1第一次出现的位置，默认param2为1。
db2 => values **locate**('a','abca',3,codeunits16)

db2 => values position('中','abc1中',codeunits16)



substring（string,start_position,length,代码单元）：

db2 => values substring('中avbc',1,1,codeunits16)

1
\-------
中





替换函数 DB2中认为''和null不同
db2：value函数
db2 => values value(null,'a')--结果为a
db2 => values value('','a')--结果为空
Oracle：
nvl(par1,par2)--Oracle中null或''都代表为空



4、去空格函数 
	LTRIM() 把字符串头部的空格去掉；
	RTRIM() 把字符串尾部的空格去掉；
	TRIM()  把字符串头和尾部的空格去掉。

5、大小写转换函数
	LOWER()将字符串全部转为小写；
	UPPER()将字符串全部转为大写。 



DB2数据类型改变函数：varchar()、int()、date()、time()等

Oracle：SELECT to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual
DB2： SELECT varchar(current timestamp) from sysibm.sysdummy1 



16、取前几条记录
SQL Server： Select top n * from xtable
Oracle：Select * from xtable where rownum <=n
DB2：select * from syscat.tables fetch first 10 rows only



replace函数
语法：REPLACE(EXP1,EXP2,EXP3) 
REPLACE函数用EXP3代替EXP1中所有的EXP2。 
db2 => select replace('abcde','bc','oo') from sysibm.sysdummy1

update t1 set feild =  replace(feild,  ','   ,   '') 

17、repeat函数
语法：repeat(parm,int z) 
将parm重复z次后输出
select repeat('a',10) from sysibm.sysdummy1;



语法：POSSTR(EXP1,EXP2) 
POSSTR函数返回EXP2在EXP1中第一次出现的位置。 
db2 => select posstr('abca','a') from sysibm.sysdummy1



INSERT(ARG1,POS,SIZE,ARG2) 
INSERT函数返回一个字符串，将ARG1从POS处删除SIZE个字符，将ARG2插入该位置。 
这里的pos是按字节数算的。如果转化成按字符数算，可以改写成：INSERT(ARG1,POS,SIZE,ARG2,CODEUNITS16)
db2 => select insert('abcde',2,2,'中') from sysibm.sysdummy1



CONCAT函数 等价于 ||
语法：CONCAT(ARG1,ARG2) 
CONCAT函数返回两个字符串的连接。
db2 => select concat('a','b') from sysibm.sysdummy1



 select left('abcd',3),right('abcd',2) from sysibm.sysdummy1



语法：LTRIM()、RTRIM() 
LTRIM、RTRIM函数从CHAR、VARCHAR、GRAPHIC或者VARGRAPHIC中去掉左侧或右侧的空格。 





DB2中的Date 一共识别三种格式，最常见的是这样

```
'2013-12-12'
```

　　对，你没看错，DB2认为这样的字符串就是Date数据

然后我们可以利用函数这样寻找日期区间

```
select` `* ``from` `users ``where` `g_time ``between` `'2003-05-04 '` `and` `'2003-05-08'
```



```
    SELECT 
    round(23.44/5,2) AS MONEY1, 
    round(t.MONEY/5,2) AS MONEY2,
    round(CAST(t.MONEY AS DECIMAL(31,3))/5 ,2)  AS MONEY3,
    CAST(round(CAST(t.MONEY AS DECIMAL(31,3))/5 ,2) AS DECIMAL(31,2)) AS MONEY4
    FROM TEST1 t;
```



```sql
SELECT *
FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY location) as RRN, *
    FROM CSPAPP.LOCATIONS
    )
WHERE RRN between 100 and 200
```



# DB2 INTERSECT、EXCEPT 

**交集**

INTERSECT和INTERSECT ALL是等效的

  SELECT * FROM AA_WEEK X WHERE X.CODE IN (1,2,3) -- 集合A

  INTERSECT                    -- 集合B

  SELECT * FROM AA_WEEK X WHERE X.CODE IN (2,3,4);

**差集**

EXCEPT和EXCEPT ALL是等效的。

  SELECT * FROM AA_WEEK X WHERE X.CODE IN (1,2,3) -- 集合A

  EXCEPT                     -- 集合B

  SELECT * FROM AA_WEEK w WHERE w.CODE IN (2,3,4);    

**合集运算**：UNION、UNION ALL

UNION和UNION ALL是不同的。UNION消除重复行记录，UNION ALL不消除重复行记录。







```sql
SELECT 
    SUBSTR('CHG-FFH', 1, LOCATE('-','CHG-FFH')-1) as FIRST_PART
  , SUBSTR('CHG-FFH', LOCATE('-','CHG-FFH')+1)   as SECOND_PART
FROM SYSIBM.SYSDUMMY1;
```

# COALESCE

The COALESCE function returns the first non-null expression in a list of expressions.

返回首个不是null的字段





```sql
SELECT VALUE1, VALUE2, VALUE3
FROM  MYTABLE
where (VALUEW, VALUEX, VALUEY, VALUEZ) in ( values
        (010, 46793, '329', '10'),
        (011, 46798, '322', '12'),
        (012, 33333, '111', '14')
        );
```

```sql
WITH mylist(w,x,y,z) AS (
SELECT  010, 46793, '329', '10' FROM SYSIBM.SYSDUMMY1 UNION ALL
SELECT  011, 46798, '322', '12' FROM SYSIBM.SYSDUMMY1 UNION ALL
SELECT  012, 33333, '111', '14' FROM SYSIBM.SYSDUMMY1 
)
SELECT VALUE1, VALUE2, VALUE3
FROM MYTABLE
INNER JOIN mylist
ON (VALUEW, VALUEX, VALUEY, VALUEZ)=(w,x,y,z)
```

the `SUM` automatically ignores the `NULL` values and correctly returns the sum of the numbers.某行null会被SUM函数忽略，所有行都没有数值结果为NULL

```
COALESCE(sum(URT.TO_REMOVEALLPRIV), 0) as TO_REMOVEALLPRIV_SUM
```

```
IFNULL(sum(URT.TO_REMOVEALLPRIV), 0) as TO_REMOVEALLPRIV_SUM
```



comment

```sql
COMMENT ON COLUMN TableName.ColumnName IS 'comment text';
```



timestamp 

```
insert_ts timestamp not null with default current timestamp,
   change_ts timestamp not null generated always for each row 
                                on update as row change timestamp
```





四舍五入

23.44/5 = 4.688， 四舍五入后 = 4.69

```sql
round(CAST(t.MONEY AS DECIMAL(31,3))/5 ,2)  AS MONEY3,
```





```
WHERE   

CASE 
    WHEN tb1.col1 = 'Y'
    THEN Condition1
    ELSE Condition2
END
```

```
WHERE   

    ( tb1.col1 = 'Y'  AND Condition1 )
 OR ( tb1.col1 <> 'Y' AND Condition2 )
```



```sql
WHERE (
       (locationID <> 0 AND myVar = locationID) 
       OR 
       (locationID = 0 AND myVar = location2ID)
      ) 
```

