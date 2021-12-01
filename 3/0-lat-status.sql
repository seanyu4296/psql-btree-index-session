-- query
-- data setup: from previous already
-- DEMO: composite index

-- 1. explain analyze: show "index scan"
explain analyze select id, status from linked_account_tokens where id = 'insert-some-existent-id';

-- 2. create index
create index lat_id_status on linked_account_tokens using btree (id, status);

-- 3. show "index only scan"