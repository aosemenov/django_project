.PHONY: all_stop, all_start, master_up, master_down, slaves_up, slaves_down

all_stop:
	docker compose down
	sudo rm -rf ./volumes

all_start:
	docker compose up -d

	sleep 4

	goose -dir migrations/master/set_wal postgres "postgres://lavka:postgres_password@localhost:5434/lavka" up
	goose -dir migrations/slave_1/set_wal postgres "postgres://lavka:postgres_password@localhost:5435/lavka" up
	goose -dir migrations/slave_2/set_wal postgres "postgres://lavka:postgres_password@localhost:5436/lavka" up

	docker restart lavka-db-master_lavka-1 lavka-db-unit_1_lavka-1 lavka-db-unit_2_lavka-1

	sleep 1

	goose -dir migrations/master postgres "postgres://lavka:postgres_password@localhost:5434/lavka" up

	sleep 1

	goose -dir migrations/slave_1 postgres "postgres://lavka:postgres_password@localhost:5435/lavka" up
	goose -dir migrations/slave_2 postgres "postgres://lavka:postgres_password@localhost:5436/lavka" up

	sleep 1

	docker restart lavka-db-master_lavka-1 lavka-db-unit_1_lavka-1 lavka-db-unit_2_lavka-1


master_up:
	docker compose up master_lavka -d
	sleep 4
	goose -dir migrations/master/set_wal postgres "postgres://lavka:postgres_password@localhost:5434/lavka" up
	docker restart lavka-db-master_lavka-1 
	sleep 1
	goose -dir migrations/master postgres "postgres://lavka:postgres_password@localhost:5434/lavka" up
	docker restart lavka-db-master_lavka-1
	sleep 1 

master_down:
	docker stop lavka-db-master_lavka-1 && docker rm lavka-db-master_lavka-1
	sudo rm -rf ./volumes/master

slaves_up:
	docker compose up unit_1_lavka unit_2_lavka -d
	sleep 4
	goose -dir migrations/slave_1/set_wal postgres "postgres://lavka:postgres_password@localhost:5435/lavka" up
	goose -dir migrations/slave_2/set_wal postgres "postgres://lavka:postgres_password@localhost:5436/lavka" up
	
	docker restart lavka-db-unit_1_lavka-1
	docker restart lavka-db-unit_2_lavka-1
	sleep 2

	goose -dir migrations/slave_1 postgres "postgres://lavka:postgres_password@localhost:5435/lavka" up
	goose -dir migrations/slave_2 postgres "postgres://lavka:postgres_password@localhost:5436/lavka" up
	docker restart lavka-db-unit_1_lavka-1
	docker restart lavka-db-unit_2_lavka-1
slaves_down: 
	docker stop lavka-db-unit_1_lavka-1 && docker rm lavka-db-unit_1_lavka-1
	docker stop lavka-db-unit_2_lavka-1 && docker rm lavka-db-unit_2_lavka-1
	sudo rm -rf ./volumes/slave_1
	sudo rm -rf ./volumes/slave_2
