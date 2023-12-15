-- +goose Up
-- +goose NO TRANSACTION

CREATE SUBSCRIPTION db_sub_1 CONNECTION 'host=master_lavka user=replicator password=secret dbname=lavka' PUBLICATION db_pub_1;

-- +goose Down
