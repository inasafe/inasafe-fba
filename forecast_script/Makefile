build:
	@echo Create forecast_script binaries
	@export REPO_ROOT=$$(realpath $$PWD/../); ./build.sh
	@docker-compose build
#	@sh -c "export REPO_ROOT=$$(realpath $$PWD/../); echo $$(REPO_ROOT)"

up:
	@docker-compose up -d

down:
	@docker-compose down

wait-entrypoint-scripts-ready:
	@rm -f entrypoint-scripts/.entry_point.lock
	@docker-compose restart; until ls entrypoint-scripts/.entry_point.lock > /dev/null; do sleep $(or ${TIMEOUT},60); done

test:
	@docker-compose exec db python3 -m unittest discover /docker-entrypoint-initdb.d/forecast_worker/fbf

shell:
	@docker-compose exec db bash
