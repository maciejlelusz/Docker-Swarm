# 15-Portainer — Portainer

Uruchomimy Portainera jako serwis w Swarm, aby zobaczyć zasoby przez UI.

## Cel
- Postawić Portainera w Swarm.
- Zalogować się i podejrzeć: nodes, services, stacks.
- Zrozumieć ryzyka i dobre praktyki.

## Wymagania
- Moduł 02.
- Dostęp do portu 9000 (lub 9443) na managerze.

## Teoria (w skrócie)
Portainer to wygodny panel, ale pamiętaj o bezpieczeństwie (role, ograniczony dostęp sieciowy, TLS).

## Ćwiczenia
### 1. Utwórz wolumen na dane

```bash
sudo docker volume create portainer_data
```

### 2. Deploy Portainera (na managerze)

```bash
sudo docker service create   --name portainer   --publish 9000:9000   --constraint 'node.role==manager'   --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock   --mount type=volume,src=portainer_data,dst=/data   portainer/portainer-ce:latest
```

Wejdź na `http://<IP_MANAGER01>:9000` i dokończ konfigurację (admin user + endpoint lokalny).

### 3. Szybki tour

- Nodes → sprawdź listę węzłów
- Services → zobacz serwisy
- Stacks → jeśli masz wdrożony stack z modułu 11, powinien się pojawić


## Weryfikacja
- UI Portainera działa i widzisz zasoby klastra.

## Cleanup
```bash
sudo docker service rm portainer
sudo docker volume rm portainer_data
```

