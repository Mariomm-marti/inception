TARGET:=
DOCKER_COMPOSE_FILE:=srcs/docker-compose.yml
ENV_FILE:=srcs/.env

start: check_env
	docker-compose up -f ${DOCKER_COMPOSE_FILE} --build -d

check_env:
	@test -f ${ENV_FILE} || echo "${ENV_FILE} not found, use env.example as template"

stop:
	docker-compose stop -f ${DOCKER_COMPOSE_FILE} ${TARGET}

down:
	@echo "/!\ Deleting all networks & services"
	docker-compose down -f ${DOCKER_COMPOSE_FILE}
