#Mysql Script
## get all dump and restore
```bash
  for i in $(ls recordings_inserts_1011_2025-05-*.sql) ; do echo $i ; mysql tgui -p.tel30! < $i ;done
```
