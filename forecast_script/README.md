# Script installations

These scripts needs to be deployed to the target postgres database.
Location of directory `entrypoint-scripts` must corresponds to `/docker-entrypoint-initdb.d` in the target container.
See `docker-compose.yml` for example.

Script will run iteratively in ascending order.
We intentionally put the order in front of the script name:
```
00-dependencies.sh
01-extensions.sql
etc...
```

So the scripts can be executed in the correct order.

Currently, kartoza/postgis supports `.sql`, `.sql.gz`, and `.sh` extensions.

