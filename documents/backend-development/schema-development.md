# Schema development

At this point, the backend schema used to generate database tables are 
generated using SQL, and not thru ORM services.

In order to have it nice and organized, we need to have some sort of conventions.

For references, take a look at `fixtures/schema` which contains the code 
to generate backend schema.

## Generator Script Conventions

1. Each schema script should be separated into folders or files which can be
   logically ordered.
2. A script file should only do one logical role to perform and has to be idempotent 
   (if executed repeatedly will end up the same end state). E.g. generating a 
   table, or defining a functions.
3. A folder of scripts is a module that contains logically related scripts that 
   perform one high level role. E.g. `main_fbf` folder will have scripts that 
   generates multiple tables for `fbf`. `functions` folder will have scripts 
   that only defines SQL functions/routines. `triggers` folder will have scripts
   that only defines SQL triggers.
4. Folders can have nested modules or folders.
5. Scripts will be executed in increasing order according to Unix alphanumerical
   order of its full path. Thus scripts will be executed in DFS (Depth First Search) 
   manner with alphanumerical sorting order if multiple scripts exists in the 
   same folder/module
6. To guarantee certain order of executions (to make sure object dependencies are obeyed),
   You include same digit numbering as prefix name of the scripts. E.g. `00_initial.sql` 
   will be executed first, then `01_prepare.sql` will be executed after that.
7. A namespace is the logical name of the folders/modules. If a script has a full path 
   `01_fbf/00_main/03_hazard_event.sql` then it's namespace is `fbf/main`.
   Namespace is useful to logically categorize the script/object in the script, so people 
   can locate it easily. In PyCharm for example we can use double shift search by namespace 
   just by typing it's namespace (not full path). It's also easier to make a script using this convention.
   
   
The above conventions can be applied to any script in general. 
But since we used it to generate database schema, in `fixtures/schema` folder 
you will find most of the script are SQL script. 
There is also a bash script like `initial/extensions/dependencies.sh`, it is possible 
that a case to execute shell script exists such as when we want to install necessary
OS dependencies or Postgres extensions or modify config variables.


## Database object conventions

For the database objects, there are several conventions we can use to make it easy 
for DB Admin to perform maintenance using DB Admin interface/tools such as pgAdmin or DataGrip.
Database objects refers to tables, views, or procedures in database.

1. Each database objects should have meaningful name and have comments on what is the object used for.
2. Prefer a singular name for the object if possible.
3. Have object namespace (with double underscore `__` delimiter) to logically 
   group the objects if possible. E.g. `fbf__hazard_event` table and `fbf__mv_administrative_mapping` materialized view 
   means it is coming from the same app namespace, which is `fbf`.
4. Add object type prefix to make it easy to understand the type of object. 
   E.g. `mv_administrative_mapping` means it is a materialized view. `vw_district_extent` is a view,
   `f_forecast_glofas` is a function, and `tr_building_area_mapper` is a trigger.
5. Some objects convey relationships, include the relations in the name.
   E.g. `hazard_event_trigger_status_fkey` foreign key means it is a column in `hazard_event` table
   which refer to `trigger_status` table
6. Some objects needs execution orders with objects of the same type, add digit numbering as prefix
   to control the order. E.g. `osm_buildings` table have 4 triggers to execute 
   with the last one needs to be executed after the first three finished.
   You can name the trigger like this: `osm_buildings_tg_00_area_mapper`, 
   `osm_buildings_tg_01_materials_mapper`, `osm_buildings_tg_02_recode_mapper`, 
   `osm_buildings_tg_03_total_vulnerability`, to make sure `total_vulnerability` trigger function
   are evaluated only after the previous triggers populated the building score needed to calculate vulnerability.
7. Functions or triggers needs to be designed so it can be tested by doing manual SQL statements with parameters.
   E.g. if you need triggers that calculates a column in a certain row, first 
   try to create a functions that does the calculations with arbitrary row id parameter,
   then attach the function as triggers.
   
   

## Schema/migration generation conventions

When we want to generate initial database schema/objects, or performing migrations,
there are several conventions we can use. 


1. Initial schema generations needs to obey object dependencies. E.g. if a table is
   going to be used as a foreign key, it has to exists first. Thus the scripts that
   generated the foreign key table has to be ordered to be executed first.
2. To allow idempotent executions, use statements that checks existences, like 
   `CREATE IF NOT EXISTS`. If not possible, drop cascade the objects first, then 
   create the object, like `DROP IF EXISTS ... CASCADE` then `CREATE FUNCTION ...`.
   Constraint statements usually does not allow multiple executions.
   You can either drop the constraint then recreate or include the constraint statement
   in one go inside the table creation statement.
3. In some cases you actually care about the data and wants to avoid `DROP ... CASCADE` statements.
   E.g. in a migration scripts, if you change foreign key, you had to decide 
   what to do with the data. The script then needs to take care to dump-alter-restore the data.
   This means you had to make temporary objects or schema that store your data 
   if you want to perform this with pure SQL. Otherwise, you can use bash or python 
   script to make full use of pg_dump/pg_restore/pg_depend.
4. A scrip executions must use transactions. It has to either fail or succeed. 
   No intermediate state are allowed 
   if the script fails in the middle. In psql you can use `-1` switch when importing SQL
   file to make a transactions import. In the SQL file you can make transactions block with 
   `BEGIN` and `COMMIT` statement. In psycopg2 you wan use `with` keywords. 
   Refer to your database client in order to use this.
5. Provide a rollback script if possible for migration statements. This is not 
   mandatory, however, because a migration script will typically be run once per database server update, 
   then it's not used again.


## Agreed Terminology

For naming conventions, listed below are our agreed prefix/terminology:

1. Namespace `fbf` for Forecast-based Financing
2. Database tables don't have prefix.
3. Database views uses `vw` prefix after namespace.
4. Database materialized views uses `mv` prefix after namespace.
5. Database functions/routines/procedures uses `f` prefix after namespace.
6. Database triggers uses `tg` prefix after namespace.

Some terminologies use suffix, because common DB admin tools already uses suffix pattern, 
and it will be difficult for us if we didn't use that conventions. 
It is commonly a result of autogenerated names.

1. Table sequences uses `seq` suffix
2. Table primary key uses `pkey` suffix
3. Table foreign key uses `fkey` suffix
4. Table indexes uses `idx` suffix 
