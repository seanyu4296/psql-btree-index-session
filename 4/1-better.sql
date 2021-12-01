-- query: the real query with explain analyze
explain (analyze, buffers, costs, verbose) SELECT *
FROM channel_account_tokens_bank_accounts as cat
WHERE cat.refresh_token_expiration_timestamp <= (now() + interval '2 day')  and cat.refresh_token_expiration_timestamp >= (now() - interval '7 day');
