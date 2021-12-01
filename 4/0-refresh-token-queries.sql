-- queries to get refrehs token
explain (analyze, buffers, costs, verbose) SELECT *
FROM channel_account_tokens_bank_accounts as cat
WHERE cat.refresh_token_expiration_timestamp <= (now() + interval '2 day') AND cat.refresh_token_expiration_timestamp <> '0001-01-01 00:00:00'
LIMIT 500





-- query: check indexes for refresh_token ....
select
    t.relname as table_name,
    i.relname as index_name,
    a.attname as column_name
from
    pg_class t,
    pg_class i,
    pg_index ix,
    pg_attribute a
where
    t.oid = ix.indrelid
    and i.oid = ix.indexrelid
    and a.attrelid = t.oid
    and a.attnum = ANY(ix.indkey)
    and t.relkind = 'r'
    and t.relname like 'channel_account_tokens_bank_accounts%'
order by
    t.relname,
    i.relname;
