-- \i command

-- create payment table
CREATE TABLE IF NOT EXISTS "payment" (
    "id" VARCHAR(255) PRIMARY KEY NOT NULL DEFAULT (concat('ddpayment-', uuid_generate_v4())),
    "business_id" VARCHAR(255) NOT NULL,
    "reference_id" VARCHAR(255) NOT NULL,
    "currency" VARCHAR(50) NOT NULL,
    "amount" DECIMAL(16,4),
    "enable_otp" bool,
    "description" VARCHAR(255),
    "callback_url" VARCHAR(255),
    "status"  VARCHAR(50) NOT NULL,
    "created" TIMESTAMP NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
    "updated" TIMESTAMP NOT NULL DEFAULT (now() AT TIME ZONE 'utc')
);


-- data setup: random data business_id and ref_id
insert into payment (
    business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    uuid_generate_v4(),
    uuid_generate_v4(),
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 500000) s(i);

insert into payment (
  business_id, reference_id, currency, amount, enable_otp, description, callback_url, status
) select
    'obvious-business-id',
    'obvious-reference-id',
    'PHP',
    1000,
    true,
    'test description description',
    'http://google.com',
    'FAILED'
from generate_series(1, 1) s(i);



-- select query

select * from payment where reference_id = 'obvious-reference-id';
