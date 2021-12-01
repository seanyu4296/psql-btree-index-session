-- index
create index payment_ref_id on payment using btree (reference_id);

drop index payment_ref_id;