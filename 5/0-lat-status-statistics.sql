
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
    'AUTHORIZED'
from generate_series(1, 1000) s(i);


select * from linked_account_tokens where status = 'CONFIRMED' -- 1000 rows
select * from linked_account_tokens where status = 'ACCOUNTS_UNLINKED' -- 1m rows


-- query: get distribution
SELECT null_frac, n_distinct, most_common_vals, most_common_freqs FROM pg_stats
WHERE tablename='linked_account_tokens' AND attname='status';

-- SELECT attname, inherited, n_distinct,
--        array_to_string(most_common_vals, E'\n') as most_common_vals
-- FROM pg_stats
-- WHERE tablename = 'linked_account_tokens' and attname = 'status';

-- query: get page and tuples
SELECT relname, relkind, reltuples, relpages
FROM pg_class;
-- https://www.calculatorsoup.com/calculators/math/scientific-notation-converter.php


-- explain analyze
postgres=# SELECT null_frac, n_distinct, most_common_vals, most_common_freqs FROM pg_stats
WHERE tablename='linked_account_tokens' AND attname='status';
 null_frac | n_distinct |               most_common_vals                |        most_common_freqs
-----------+------------+-----------------------------------------------+----------------------------------
         0 |          3 | {ACCOUNTS_UNLINKED,ACCOUNTS_LINKED,CONFIRMED} | {0.9989667,0.00063333334,0.0004}