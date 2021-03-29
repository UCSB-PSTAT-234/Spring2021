.PHONY: help build start stop test test-env

# Docker image name and tag
IMAGE:=syoh/pstat-234-spring-2021
TAG?=latest
# Shell that make should use
SHELL:=bash

setup:
	./setup.sh

help: ## http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_%/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: DARGS?=
build: ## Make the latest build of the image
	docker build $(DARGS) --rm --force-rm -t $(IMAGE):$(TAG) .

start: ARGS?=-d
start: PORT?=443
start: 
	IMAGE=$(IMAGE) PORT=$(PORT) docker-compose up $(ARGS)

colab: ARGS?=-d
colab: OPT?="\
	--NotebookApp.port_retries=0 \
	--NotebookApp.token='' \
	--NotebookApp.allow_origin='https://colab.research.google.com'"
colab: 
	PORT=8888 PASSWD="" OPT=$(OPT) docker-compose up $(ARGS)

stop: ARGS?=
stop: ## Stop container with docker-compose.yml
	IMAGE=$(IMAGE) docker-compose down $(ARGS)

test: ## Make a test run against the latest image
	pytest tests

test-env: ## Make a test environment by installing test dependencies with pip
	pip install -r tests/requirements.txt

repo-structure: ## Create public/private repository pair 
	git remote add private-repo https://github.com/UCSB-PSTAT-234/Spring2021-Private
	git remote add public-repo https://github.com/UCSB-PSTAT-234/Spring2021
	git remote rm origin
	git pull --set-upstream private-repo private
	git checkout --orphan public
	git pull --set-upstream public-repo public
	git checkout private
