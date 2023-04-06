traefik:
	docker compose -f docker-compose-traefik.yml up -d

traefik-down:
	docker compose -f docker-compose-traefik.yml down

single:
	docker compose -f docker-compose-single.yml up -d

single-down:
	docker compose -f docker-compose-single.yml down

replicas:
	docker compose -f docker-compose-replicas.yml up -d

replicas-down:
	docker compose -f docker-compose-replicas.yml down

middleware:
	docker compose -f docker-compose-middleware.yml up -d

middleware-down:
	docker compose -f docker-compose-middleware.yml down

down:
	make single-down && make replicas-down && make middleware-down && make traefik-down

all: traefik single replicas middleware