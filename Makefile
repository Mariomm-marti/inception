DOCKER_COMPOSE_FILE:=srcs/docker-compose.yml
ENV_FILE:=srcs/.env

start: check_env check_hosts
	docker-compose -f ${DOCKER_COMPOSE_FILE} up --build -d

check_env:
	@test -f ${ENV_FILE} || echo "${ENV_FILE} not found, use env.example as template"

check_hosts:
	@cat /etc/hosts | grep -q mmartin.42.fr || echo "review /etc/hosts as mmartin.42.fr is missing"

stop:
	docker-compose -f ${DOCKER_COMPOSE_FILE} stop

down:
	docker-compose -f ${DOCKER_COMPOSE_FILE} down || true

fulldown:
	@echo "/!\ Deleting all networks & services"
	docker rm -f $(shell docker ps -qa) || true
	docker image rm -f $(shell docker image ls -qa) || true
	docker volume rm -f $(shell docker volume ls -q) || true
	docker network rm -f $(shell docker network ls -q) || true
	docker-compose -f ${DOCKER_COMPOSE_FILE} down || true
