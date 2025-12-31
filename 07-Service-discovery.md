# 07-Service-discovery — Service discovery

Swarm ma wbudowane DNS dla serwisów. Sprawdzimy VIP i DNSRR.

## Cel
- Zrozumieć VIP vs DNSRR.
- Zrobić prosty test round-robin i aliasów.

## Wymagania
- Moduł 05 (overlay).

## Teoria (w skrócie)
W Swarm service discovery działa przez wbudowany DNS (127.0.0.11 w kontenerach).

Dwa tryby endpointów:
- **VIP** (domyślnie): serwis dostaje wirtualny IP, a LB odbywa się "pod spodem".
- **DNSRR**: DNS zwraca listę IP tasków (bez VIP). Przydatne, gdy LB robisz sam (np. zewnętrzny).


## Ćwiczenia
### 1. VIP (domyślnie)

```bash
sudo docker network create --driver overlay sdnet
sudo docker service create --name api --network sdnet --replicas 3 traefik/whoami
sudo docker service create --name client --network sdnet --replicas 1 curlimages/curl:8.6.0   sh -lc 'while true; do curl -s http://api | head -n1; sleep 1; done'
sudo docker service logs -f --tail 20 client
```

### 2. DNSRR

Utwórz serwis z `--endpoint-mode dnsrr`:

```bash
sudo docker service rm api
sudo docker service create --name api --network sdnet --replicas 3 --endpoint-mode dnsrr traefik/whoami
```

Sprawdź DNS z poziomu taska klienta:

```bash
client_task=$(sudo docker ps --filter name=client -q | head -n1)
sudo docker exec -it "$client_task" nslookup api
```


## Weryfikacja
- W logach klienta widzisz odpowiedzi z różnych instancji.
- `nslookup api` w trybie DNSRR pokazuje wiele rekordów.

## Cleanup
```bash
sudo docker service rm client api
sudo docker network rm sdnet
```

