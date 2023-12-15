-- +goose Up
-- +goose StatementBegin

-- GLOBAL TABLES
create schema if not exists lavka;

create table if not exists lavka.products(
   id bigserial primary key,
   name varchar,
   calories int,
   created_at timestamp default now(),
   updated_at timestamp default now()
);

comment on table lavka.products is 'Список товаров';


create table if not exists lavka.employees(
    id bigserial primary key,
    name varchar,
    surname varchar,
    created_at timestamp default now(),
    updated_at timestamp default now()
);


create table if not exists lavka.assemble_points(
    id bigserial primary key,
    adress varchar,
    latitude Decimal(9,6), 
    longtitude Decimal(9,6),
    created_at timestamp default now(),
    updated_at timestamp default now()
);

comment on table lavka.assemble_points is 'Пункт сбора';


-- LOCAL TABLES
create table if not exists lavka.orders_from_warehouse(
    id bigserial,
    employee_id bigint,
    created_at timestamp default now(),
    done_at timestamp default now(),

    warehouse_id int
) PARTITION BY RANGE (warehouse_id);

create table if not exists lavka.ordered_products_from_warehouse(
    order_id bigint,
    product_id bigint,
    quantity integer,

    warehouse_id int
) PARTITION BY RANGE (warehouse_id);

create table if not exists lavka.products_in_assemble_point(
    product_id bigint,
    quantity bigint,

    assemble_point_id int
) PARTITION BY RANGE (assemble_point_id);
-- +goose StatementEnd


-- +goose Down
-- +goose StatementBegin
drop table if exists lavka.products cascade;
drop table if exists lavka.employees cascade;
drop table if exists lavka.assemble_points cascade;
drop table if exists lavka.orders_from_warehouse cascade;
drop table if exists lavka.products_in_assemble_point cascade;
drop table if exists lavka.ordered_products_from_warehouse cascade;
-- +goose StatementEnd