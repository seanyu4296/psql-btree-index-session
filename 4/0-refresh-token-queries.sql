-- queries to get refrehs token
explain (analyze, buffers, costs, verbose) SELECT cat.id, cat.linked_account_token_id, cat.access_token, cat.refresh_token, cat.access_token_expiration_timestamp, cat.refresh_token_expiration_timestamp, cat.created, cat.updated, cat.refresh_remaining, cat.expiration_timestamp, cat.channel_metadata, lat.id, lat.business_id, lat.customer_id, lat.channel_code, lat.status, lat.type, lat.linked_account_token_details_id, lat.unlinked_account_token_id, lat.metadata, lat.device_fingerprint, lat.channel_reference_id, lat.created, lat.updated
FROM channel_account_tokens_bank_accounts as cat
    JOIN linked_account_tokens as lat ON ( cat.linked_account_token_id = lat.id )
WHERE cat.refresh_token_expiration_timestamp <= (now() + interval '2 day') AND cat.refresh_token_expiration_timestamp <> '0001-01-01 00:00:00' AND lat.status <> 'ACCOUNTS_UNLINKED' AND lat.status <> 'EXPIRED' AND lat.status <> 'FAILED' AND ( cat.refresh_remaining <> -1 OR lat.status <> 'EXPIRING' )
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
