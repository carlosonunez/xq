#!/usr/bin/env make
MAKEFLAGS += --silent
SHELL := /usr/bin/env bash
LOCAL_DOCKER_IMAGE_NAME := xq

build:
	docker build -t $(LOCAL_DOCKER_IMAGE_NAME) .

test: build
test:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_UNDER_TEST=$(LOCAL_DOCKER_IMAGE_NAME) \
	docker-compose run --rm unit-tests

push: build
push:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_TO_DEPLOY=$(LOCAL_DOCKER_IMAGE_NAME) \
	docker-compose run --rm push-to-docker-hub

clean:
	docker rmi $(LOCAL_DOCKER_IMAGE_NAME)
