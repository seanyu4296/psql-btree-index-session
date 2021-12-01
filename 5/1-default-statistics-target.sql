show default_statistics_target;

set default_statistics_target to 1000;


alter table <table_name> alter column <column_name> set statistics -1 ;