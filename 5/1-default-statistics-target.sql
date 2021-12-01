show default_statistics_target;

set default_statistics_target to 1000;


alter table linked_account_tokens alter column status set statistics 10000;