-- query: create partial comp idx
create index lat_id_status_acc_linked on linked_account_tokens using btree (id, status)
WHERE status = 'ACCOUNTS_LINKED';

-- query: do a simple get
explain analyze select id, status from linked_account_tokens where status = 'ACCOUNTS_LINKED' limit 1;


-- query: show db memory consumption of two index
SELECT    CONCAT(n.nspname,'.', c.relname) AS table,
          i.relname AS index_name, pg_size_pretty(pg_relation_size(x.indrelid)) AS table_size,
          pg_size_pretty(pg_relation_size(x.indexrelid)) AS index_size,
          pg_size_pretty(pg_total_relation_size(x.indrelid)) AS total_size FROM pg_class c 
JOIN      pg_index x ON c.oid = x.indrelid
JOIN      pg_class i ON i.oid = x.indexrelid
LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE     c.relkind = ANY (ARRAY['r', 't'])
AND       n.oid NOT IN (99, 11, 12375);

-- query: delete idx with all the status
drop index lat_id_status