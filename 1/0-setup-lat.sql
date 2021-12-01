
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TYPE "linked_account_token_status" AS ENUM (
  'INITIATED',
  'CONFIRMED',
  'AUTHORIZING',
  'AUTHORIZED',
  'ACCOUNTS_LINKED',
  'ACCOUNTS_UNLINKED'
);

CREATE TABLE IF NOT EXISTS "linked_account_tokens" (
  "id" VARCHAR(255) PRIMARY KEY NOT NULL DEFAULT (concat('lat-', uuid_generate_v4())),
  "business_id" VARCHAR(255) NOT NULL,
  "channel_code" VARCHAR(255) NOT NULL,
  "status" linked_account_token_status NOT NULL,
  "created" TIMESTAMP NOT NULL DEFAULT (now() AT TIME ZONE 'utc'),
  "updated" TIMESTAMP NOT NULL DEFAULT (now() AT TIME ZONE 'utc')
);


-- 1million rows ACCOUNTS_UNLINKED
insert into linked_account_tokens (
    business_id, channel_code, status
) select
    md5(random()::text),
    md5(random()::text),
    'ACCOUNTS_UNLINKED'
from generate_series(1, 1000000) s(i);

-- just 1 row
insert into linked_account_tokens (
    business_id, channel_code, status
) values ('test2', 'test2', 'ACCOUNTS_UNLINKED');
-- 200k confirmed
insert into linked_account_tokens (
    business_id, channel_code, status
) select
    md5(random()::text),
    md5(random()::text),
    'CONFIRMED'
from generate_series(1, 200000) s(i);