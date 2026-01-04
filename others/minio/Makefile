.PHONY: check-% config save load all restart stop rm ps
include .env

check-%:
	@if [ "${${*}}" = "" ]; then \
		echo ".env variable ${*} not set"; \
		exit 1; \
	fi

config:
	@docker-compose config

save:
	@docker-compose pull
	@docker save -o minio:${MINIO_VERSION}.zip minio/minio:${MINIO_VERSION}

load:
	@docker load -i minio:${MINIO_VERSION}.zip

all: check-MINIO_DIR
	@mkdir -p ${MINIO_DIR}/data
	@docker-compose up -d

restart:
	@docker-compose restart

stop:
	@docker-compose stop

rm:
	@docker-compose rm

ps:
	@docker-compose ps -a
