.PHONY: check-% config save load all restart stop rm ps
.PHONY: logs-rmqnamesrv logs-rmqbroker logs-rmqconsole
.PHONY: stop-rmqnamesrv stop-rmqbroker stop-rmqconsole
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
	@docker save -o rmqnamesrv:${RMQ_NAME_SERVER_VERSION}.zip foxiswho/rocketmq:${RMQ_NAME_SERVER_VERSION}
	@docker save -o rmqbroker:${RMQ_BROKER_VERSION}.zip foxiswho/rocketmq:${RMQ_BROKER_VERSION}
	@docker save -o rmqconsole:${RMQ_CONSOLE_VERSION}.zip pongsky/rocketmq-console-ng:${RMQ_CONSOLE_VERSION}

load:
	@docker load -i rmqnamesrv:${RMQ_NAME_SERVER_VERSION}.zip
	@docker load -i rmqbroker:${RMQ_BROKER_VERSION}.zip
	@docker load -i rmqconsole:${RMQ_CONSOLE_VERSION}.zip

all: check-RMQ_NAME_SERVER_DIR check-RMQ_BROKER_DIR check-RMQ_CONSOLE_DIR
	@mkdir -p ${RMQ_NAME_SERVER_DIR}/logs
	@mkdir -p ${RMQ_NAME_SERVER_DIR}/store
	@mkdir -p ${RMQ_BROKER_DIR}/logs
	@mkdir -p ${RMQ_BROKER_DIR}/store
	@mkdir -p ${RMQ_CONSOLE_DIR}
	@sed -e "s/brokerIP1=127.0.0.1/brokerIP1=${INTERNAL_IP}/" \
		-e "s/listenPort=10911/listenPort=${RMQ_BROKER_LISTEN_PORT}/" \
		broker.conf > ${RMQ_BROKER_DIR}/broker.conf
	@cp users.properties ${RMQ_CONSOLE_DIR}
	@chmod -R 777 ${RMQ_NAME_SERVER_DIR}/logs
	@chmod -R 777 ${RMQ_NAME_SERVER_DIR}/store
	@chmod -R 777 ${RMQ_BROKER_DIR}/logs
	@chmod -R 777 ${RMQ_BROKER_DIR}/store
	@docker-compose up -d

logs-rmqnamesrv:
	@docker-compose logs rmqnamesrv

logs-rmqbroker:
	@docker-compose logs rmqbroker

logs-rmqconsole:
	@docker-compose logs rmqconsole

stop-rmqnamesrv:
	@docker-compose stop rmqnamesrv

stop-rmqbroker:
	@docker-compose stop rmqbroker

stop-rmqconsole:
	@docker-compose stop rmqconsole

restart:
	@docker-compose restart

stop:
	@docker-compose stop

rm:
	@docker-compose rm

ps:
	@docker-compose ps -a
