include .env
export $(shell sed 's/=.*//' .env)

build:
	docker-compose build && docker-compose up

up:
	docker-compose up -d

ssh:
	docker-compose exec $(container) bash

add_vm:
	sudo echo 127.0.0.1 $(CONTAINER_HOST_NAME) >> /etc/hosts
