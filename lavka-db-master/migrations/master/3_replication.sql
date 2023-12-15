-- +goose Up
-- +goose NO TRANSACTION

CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'secret';
GRANT ALL ON ALL TABLES IN SCHEMA lavka TO replicator;
GRANT ALL ON SCHEMA lavka to replicator;

ALTER SYSTEM SET max_wal_senders TO '10';
ALTER SYSTEM SET listen_addresses TO '*';
ALTER SYSTEM SET archive_mode TO 'ON';
ALTER SYSTEM SET archive_command TO 'cp %p /archives/%f';
ALTER SYSTEM SET restore_command TO 'cp /archives/%f %p';
ALTER SYSTEM SET wal_keep_size TO '1GB';
ALTER SYSTEM SET wal_compression TO 'ON';

ALTER SYSTEM SET wal_level = logical;

CREATE PUBLICATION db_pub_1 FOR TABLE 
    lavka.products,
    lavka.employees,
    lavka.assemble_points;
    
CREATE PUBLICATION db_pub_2 FOR TABLE 
    lavka.products,
    lavka.employees,
    lavka.assemble_points;

CREATE EXTENSION postgres_fdw;

create schema if not exists slave_1;
create schema if not exists slave_2;

create server if not exists slave_1 foreign DATA WRAPPER postgres_fdw options (host 'unit_1_lavka', dbname 'lavka', port '5432');
create server if not exists slave_2 foreign DATA WRAPPER postgres_fdw options (host 'unit_2_lavka', dbname 'lavka', port '5432');

CREATE USER MAPPING FOR lavka
  SERVER slave_1
  OPTIONS (user 'lavka', password 'postgres_password');

CREATE USER MAPPING FOR lavka
  SERVER slave_2
  OPTIONS (user 'lavka', password 'postgres_password');

create foreign table if not exists slave_1.orders_from_warehouse 
partition of lavka.orders_from_warehouse
FOR VALUES FROM (1) TO (2) server slave_1 OPTIONS(schema_name 'lavka');

create foreign table if not exists slave_2.orders_from_warehouse
partition of lavka.orders_from_warehouse  
FOR VALUES FROM (2) TO (3) server slave_2 OPTIONS(schema_name 'lavka');


-- +goose Down
-- +goose NO TRANSACTION