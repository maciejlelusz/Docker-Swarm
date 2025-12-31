SHELL := /bin/bash

# Uwaga: to jest pomocniczy Makefile do labu.
# Zmienna NODE pozwala szybko przełączyć kontekst (np. przez ssh wrapper),
# ale w większości ćwiczeń używamy bezpośrednio 'docker' na wybranym węźle.

.PHONY: help info swarm-init swarm-leave stack-up stack-down

help:
	@echo "Targets:"
	@echo "  make info          - podstawowe informacje o swarm"
	@echo "  make swarm-init    - init swarm (na managerze)"
	@echo "  make swarm-leave   - leave swarm (na wszystkich węzłach ręcznie)"
	@echo "  make stack-up      - deploy stack (11-Stack)"
	@echo "  make stack-down    - remove stack (11-Stack)"

info:
	@docker info --format 'Swarm: {{.Swarm.LocalNodeState}} ({{.Swarm.ControlAvailable}}) | NodeID: {{.Swarm.NodeID}}'
	@docker node ls 2>/dev/null || true
	@docker service ls 2>/dev/null || true

swarm-init:
	@docker swarm init

swarm-leave:
	@echo "Uruchom ręcznie na każdym węźle: docker swarm leave --force"

stack-up:
	@docker stack deploy -c 11-Stack/stack.yml demo

stack-down:
	@docker stack rm demo
