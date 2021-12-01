-- query: the real query with explain analyze
explain (analyze, buffers, costs, verbose) SELECT cat.id, cat.linked_account_token_id, cat.access_token, cat.refresh_token, cat.access_token_expiration_timestamp, cat.refresh_token_expiration_timestamp, cat.created, cat.updated, cat.refresh_remaining, cat.expiration_timestamp, cat.channel_metadata, lat.id, lat.business_id, lat.customer_id, lat.channel_code, lat.status, lat.type, lat.linked_account_token_details_id, lat.unlinked_account_token_id, lat.metadata, lat.device_fingerprint, lat.channel_reference_id, lat.created, lat.updated
FROM channel_account_tokens_bank_accounts as cat
left JOIN linked_account_tokens as lat ON ( cat.linked_account_token_id = lat.id )
WHERE cat.refresh_token_expiration_timestamp <= (now() + interval '2 day') and cat.refresh_token_expiration_timestamp >= (now() - interval '7 day') AND cat.refresh_token_expiration_timestamp <> '0001-01-01 00:00:00'
AND lat.status not in ('ACCOUNTS_UNLINKED','EXPIRED', 'FAILED')
AND ( cat.refresh_remaining <> -1 OR lat.status <> 'EXPIRING' )
LIMIT 500
