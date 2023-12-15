-- +goose Up
-- +goose NO TRANSACTION

CREATE SUBSCRIPTION db_sub_2 CONNECTION 'host=master_lavka user=replicator password=secret dbname=lavka' PUBLICATION db_pub_2;

-- +goose Down
