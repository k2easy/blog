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