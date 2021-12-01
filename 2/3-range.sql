ALTER TABLE payment
ADD COLUMN ref_id_int int;

insert into payment (
    business_id, reference_id, ref_id_int, currency, amount, enable_otp, description, callback_url, status
) select
    'gorio-business-id',
    '',
    random() * 100,
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 100000) s(i);
insert into payment (
    business_id, reference_id, ref_id_int, currency, amount, enable_otp, description, callback_url, status
) select
    random() :: text,
    '',
    random() * 100,
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 400000) s(i);


explain analyze select * from payment where business_id = 'gorio-business-id' and ref_id_int > 10 and ref_id_int < 15;

create index p_b_id_ref_id_int on payment (business_id, ref_id_int);
create index p_ref_id_int_b_id on payment (ref_id_int, business_id);


-- EXPLAIN
postgres=# explain analyze select * from payment where business_id = 'gorio-business-id' and ref_id_int > 10 and ref_id_int < 20;
                                                              QUERY PLAN

--------------------------------------------------------------------------------------------------------------------------
------------
 Bitmap Heap Scan on payment  (cost=754.42..10579.24 rows=16593 width=150) (actual time=5.333..16.414 rows=17891 loops=1)
   Recheck Cond: ((ref_id_int > 10) AND (ref_id_int < 20) AND ((business_id)::text = 'gorio-business-id'::text))
   Heap Blocks: exact=4561
   ->  Bitmap Index Scan on p_b_ref_id_int_b_id  (cost=0.00..750.27 rows=16593 width=0) (actual time=3.818..3.819 rows=178
91 loops=1)
         Index Cond: ((ref_id_int > 10) AND (ref_id_int < 20) AND ((business_id)::text = 'gorio-business-id'::text))
 Planning Time: 0.468 ms
 Execution Time: 17.444 ms
(7 rows)

postgres=# create index p_b_id_ref_id_int on payment (business_id, ref_id_int);
CREATE INDEX
postgres=# explain analyze select * from payment where business_id = 'gorio-business-id' and ref_id_int > 10 and ref_id_int < 20;
                                                             QUERY PLAN

--------------------------------------------------------------------------------------------------------------------------
----------
 Bitmap Heap Scan on payment  (cost=343.98..10168.80 rows=16593 width=150) (actual time=3.929..14.866 rows=17891 loops=1)
   Recheck Cond: (((business_id)::text = 'gorio-business-id'::text) AND (ref_id_int > 10) AND (ref_id_int < 20))
   Heap Blocks: exact=4561
   ->  Bitmap Index Scan on p_b_id_ref_id_int  (cost=0.00..339.84 rows=16593 width=0) (actual time=2.492..2.492 rows=17891
 loops=1)
         Index Cond: (((business_id)::text = 'gorio-business-id'::text) AND (ref_id_int > 10) AND (ref_id_int < 20))
 Planning Time: 0.859 ms
 Execution Time: 16.096 ms
(7 rows)
