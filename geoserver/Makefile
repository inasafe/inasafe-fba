

up:
	@mkdir -p .geoserver-data
	@docker-compose up -d

down:
	@docker-compose down

ps:
	@docker-compose ps

logs:
	@docker-compose logs -f --tail=30 geoserver

shell:
	@docker-compose exec geoserver bash

wait-geoserver-ready:
	@docker-compose exec geoserver bash -c 'until wget -qO- localhost:8080/geoserver &> /dev/null; do echo "Geoserver not ready. Waiting."; done; echo "Geoserver ready"'
