SHELL := /bin/bash
# Makefile for env, not conda etc.
.PHONY: help remove init
#.SILENT: dist

.venv/bin/activate: requirements.txt
	@echo 'Creating virtual environment: .venv'
	pip3  install virtualenv
	python3 -m venv .venv
	echo 'Upgrading pip'
	./.venv/bin/python3 -m pip install --upgrade pip
	#chown -R raoul:staff ./.venv
	echo 'Installing dependencies (from requirements.txt)'
	./.venv/bin/pip install -r requirements.txt
	@echo 'Activating .venv' ## happens cause, see line 7

help:                   	## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init: .venv/bin/activate		## create directories and virtual environment
	@echo 'Init'

remove: 		## deactivates and deletes environment venv
	@echo 'Removing virtual environment: venv'
	@rm -rf .venv

