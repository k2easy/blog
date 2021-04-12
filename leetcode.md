

```sql
SELECT 
    COUNT(CASE WHEN rsp_ind = 0 then 1 ELSE NULL END) as "New",
    COUNT(CASE WHEN rsp_ind = 1 then 1 ELSE NULL END) as "Accepted"
from tb_a
```

