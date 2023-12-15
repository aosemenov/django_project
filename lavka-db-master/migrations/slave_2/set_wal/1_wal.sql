-- +goose Up
-- +goose NO TRANSACTION
ALTER SYSTEM SET wal_level = logical;

-- +goose Down