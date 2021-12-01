
insert into linked_account_tokens (
    business_id, channel_code, status
)
select
    md5(random()::text),
    md5(random()::text),
    'ACCOUNTS_LINKED'
from generate_series(1, 1000) s(i);

insert into linked_account_tokens (
    business_id, channel_code, status
)
select
    md5(random()::text),
    md5(random()::text),
    'CONFIRMED'
from generate_series(1, 1000) s(i);


select * from linked_account_tokens where status = 'CONFIRMED' -- 1000 rows
select * from linked_account_tokens where status = 'ACCOUNTS_UNLINKED' -- 1m rows


-- query: get distribution
-- query: get page and tuples