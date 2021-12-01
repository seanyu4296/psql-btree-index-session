delete from payment;
-- data setup: create 100,000 business with same ref_id
begin;
insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    md5(random()::text),
    'same-ref-id',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 200000) s(i);

insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    uuid_generate_v4(),
    'same-ref-id-2',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 200000) s(i);

insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    uuid_generate_v4(),
    'same-ref-id',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 200000) s(i);

insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    uuid_generate_v4(),
    'same-ref-id-2',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 200000) s(i);
insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    'sean-business-id',
    'same-ref-id-2',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 1) s(i);
insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    'sean-business-id',
    'same-ref-id-3',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 1) s(i);

commit;

-- select query

select * from payment where reference_id = 'same-ref-id-2' and business_id = 'sean-business-id';

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
    and t.relname like 'payment%'
order by
    t.relname,
    i.relname;

--