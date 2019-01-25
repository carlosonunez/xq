#!/usr/bin/env make
MAKEFLAGS += --silent
SHELL := /usr/bin/env bash
LOCAL_DOCKER_IMAGE_NAME := xq
COMMIT_SHA := $(shell git rev-parse HEAD | head -c8)

build:
	docker build -t $(LOCAL_DOCKER_IMAGE_NAME) .

test: build
test:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_UNDER_TEST=$(LOCAL_DOCKER_IMAGE_NAME) \
	GIT_SHA=$(COMMIT_SHA) \
	docker-compose run --rm unit-tests

deploy: build
deploy:
	HOST_PWD=$(PWD) \
	DOCKER_IMAGE_TO_DEPLOY=$(LOCAL_DOCKER_IMAGE_NAME) \
	GIT_SHA=$(COMMIT_SHA) \
	docker-compose run --rm push-to-docker-hub

clean:
	docker rmi $(LOCAL_DOCKER_IMAGE_NAME)
