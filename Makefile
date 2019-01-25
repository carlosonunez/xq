#!/usr/bin/env make
MAKEFLAGS += --silent
SHELL := /usr/bin/env bash

build:
	if [ "$$(docker images -q xq)" == "" ]; \
	then \
		docker build -t xq .; \
	fi

test: build
test:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_UNDER_TEST=xq \
	DOCKER_BIN_PATH=$$(which docker) \
	docker-compose run --rm unit-tests

push: build
push:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_TO_DEPLOY=xq \
	DOCKER_BIN_PATH=$$(which docker) \
	docker-compose run --rm push-to-docker-hub

clean:
	if [ "$$(docker images -q xq)" != "" ]; \
	then \
		docker rmi xq; \
	fi
