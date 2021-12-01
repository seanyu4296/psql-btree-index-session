create index p_ref_id_b_id on payment using btree (reference_id, business_id)

SELECT
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    tablename = 'payment';


delete from payment;
-- data setup: create business with a lot of payments (ref id)

insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    'sean-business-id-2',
    uuid_generate_v4(),
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 200000) s(i);
insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) values (
    'sean-business-id-2',
    'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
);

select * from payment where business_id = 'sean-business-id-2' and reference_id = 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'

-- index create b_id and ref_id


-- index create ref_id and b_id
create index p_b_id_ref_id on payment using btree (business_id, reference_id)