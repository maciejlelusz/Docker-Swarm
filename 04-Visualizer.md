# 04-Visualizer — Wizualizacja klastra

Uruchomimy prosty wizualizator, żeby "zobaczyć" scheduling tasków na węzłach.

## Cel
- Uruchomić serwis tylko na managerze.
- Zobaczyć jak zmienia się rozkład tasków przy skalowaniu.

## Wymagania
- Moduł 02.
- Dostęp HTTP do portu 8090 na managerze (z Twojej sieci).

## Teoria (w skrócie)
Wizualizator to zwykły serwis w Swarm. Używa bind-mount do `/var/run/docker.sock`, więc uruchamiamy go wyłącznie na managerze i tylko w labie.

## Ćwiczenia
### 1. Deploy wizualizatora

Na `manager01`:

```bash
sudo docker service create   --name=viz   --publish=8090:8080/tcp   --constraint=node.role==manager   --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock   dockersamples/visualizer
```

Wejdź w przeglądarce:
- `http://<IP_MANAGER01>:8090`

### 2. Zobacz zmianę przy skalowaniu serwisu

Stwórz serwis testowy i skaluj:

```bash
sudo docker service create --name whoami --replicas 1 traefik/whoami
sudo docker service scale whoami=10
sudo docker service ps whoami
```

Obserwuj w UI jak taski rozkładają się na węzłach.


## Weryfikacja
- Strona wizualizatora działa i pokazuje węzły.
- Serwis `whoami` ma zadeklarowaną liczbę replik.

## Cleanup
```bash
sudo docker service rm whoami viz
```


