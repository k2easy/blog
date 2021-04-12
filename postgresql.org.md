 

[Awesome Postgres](https://github.com/dhamaniasad/awesome-postgres)

### [PostgreSQL 13.1 Documentation](https://www.postgresql.org/docs/current/)

# [I. Tutorial](https://www.postgresql.org/docs/current/tutorial.html)

brackets (`[` and `]`) indicate optional parts. 
Braces (`{` and `}`) and vertical lines (`|`) indicate that you must choose one alternative. 
Dots (`...`) mean that the preceding element can be repeated.

SQL commands are preceded by the prompt `=>`, and shell commands are preceded by the prompt `$`. 

The PostgreSQL [wiki](https://wiki.postgresql.org/) contains the project's [FAQ](https://wiki.postgresql.org/wiki/Frequently_Asked_Questions) (Frequently Asked Questions) list, [TODO](https://wiki.postgresql.org/wiki/Todo) list, and detailed information about many more topics.

PostgreSQL uses a client/server model.

```
$ createdb mydb 
$ /usr/local/pgsql/bin/createdb mydb
$ psql mydb
mydb=> select version();
select now();//datetime
select current_date;// date
select 1+2;//3
```

客户端：

pgAdmin pgAgent

### 内置命令

internal commands that are not SQL commands. They begin with the backslash character, “`\`”. 

```
mydb#> \h  帮助
\q 退出
```

