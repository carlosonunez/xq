#!/usr/bin/env make
MAKEFLAGS += --silent
SHELL := /usr/bin/env bash
LOCAL_DOCKER_IMAGE_NAME := xq
ifneq ($(shell uname),Darwin)
DOCKER_BINARY_PATH := /usr/bin/docker
else
DOCKER_BINARY_PATH := /usr/local/bin/docker
endif

build:
	if [ "$$(docker images -q $(LOCAL_DOCKER_IMAGE_NAME))" == "" ]; \
	then \
		docker build -t $(LOCAL_DOCKER_IMAGE_NAME) .; \
	fi

test: build
test:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_UNDER_TEST=$(LOCAL_DOCKER_IMAGE_NAME) \
	DOCKER_BIN_PATH=$(DOCKER_BINARY_PATH) \
	docker-compose run --rm unit-tests

push: build
push:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_TO_DEPLOY=$(LOCAL_DOCKER_IMAGE_NAME) \
	DOCKER_BIN_PATH=$(DOCKER_BINARY_PATH) \
	docker-compose run --rm push-to-docker-hub

clean:
	if [ "$$(docker images -q $(LOCAL_DOCKER_IMAGE_NAME))" != "" ]; \
	then \
		docker rmi $(LOCAL_DOCKER_IMAGE_NAME); \
	fi
