redis设计与实现》

EXPIRE key seconds
为给定 key 设置生存时间，当 key 过期时(生存时间为 0 )，它会被自动删除。



# wiki

KEYS 命令 ,KEYS pattern
redis> keys *

flushall 清空所有key

## TTL
 TTL 命令 - 以秒为单位，返回给定 key 的剩余生存时间(TTL, time to live)。
 TTL KEY_NAME

 Redis Flushdb 命令	删除当前数据库的所有key
 Redis Flushall 命令	删除所有数据库的所有key

 当 key 不存在时，返回 -2 。 当 key 存在但没有设置剩余生存时间时，返回 -1 。 否则，以毫秒为单位，返回 key 的剩余生存时间。





https://t.co/kBKoylXGMp?amp=1

DigitalOcean 发布的免费英文电子书《如何管理 Redis 数据库》，向初学者介绍什么是 Redis 和它的基本用法

IRedis：基于终端的 Redis 客户端，具有代码自动补全、语法高亮、命令验证等不错的功能



登录后 auth pass

或者 redis-cli -h xxx -p 6379 -a xxx

[DEL key](https://www.runoob.com/redis/keys-del.html)
该命令用于在 key 存在时删除  key。

