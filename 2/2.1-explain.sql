postgres=# explain analyze select * from payment where reference_id = 'same-ref-id-3';
                                                       QUERY PLAN
-------------------------------------------------------------------------------------------------------------------------
 Index Scan using p_ref_id_b_id on payment  (cost=0.42..7.11 rows=1 width=174) (actual time=0.034..0.054 rows=1 loops=1)
   Index Cond: ((reference_id)::text = 'same-ref-id-3'::text)
 Planning Time: 1.603 ms
 Execution Time: 0.202 ms
(4 rows)

Time: 3.157 ms
postgres=# drop index p_ref_id_b_id;
DROP INDEX
Time: 44.653 ms
postgres=# explain analyze select * from payment where reference_id = 'same-ref-id-3';
                                                            QUERY PLAN
-----------------------------------------------------------------------------------------------------------------------------------
 Index Scan using p_b_id_ref_id on payment  (cost=0.42..35236.44 rows=1 width=174) (actual time=2953.786..2953.813 rows=1 loops=1)
   Index Cond: ((reference_id)::text = 'same-ref-id-3'::text)
 Planning Time: 0.243 ms
 Execution Time: 2953.894 ms
(4 rows)

Time: 2956.893 ms (00:02.957)
postgres=# $4$^C