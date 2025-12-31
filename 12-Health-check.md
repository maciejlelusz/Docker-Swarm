# 12-Health-check — Healthcheck i auto-healing

Ustawimy healthcheck i zobaczymy jak Swarm reaguje na niesprawny kontener.

## Cel
- Umieć dodać healthcheck.
- Zrozumieć różnicę: restart_policy vs healthcheck.
- Zobaczyć auto-healing w praktyce.

## Wymagania
- Moduł 03.

## Teoria (w skrócie)
Healthcheck jest wykonywany *wewnątrz kontenera*. Gdy kontener jest `unhealthy`, Swarm może go zastąpić (zależnie od aplikacji i restart policy).

## Ćwiczenia
### 1. Serwis z healthcheck

```bash
sudo docker service create --name hc   --replicas 2   --health-cmd 'wget -qO- http://localhost || exit 1'   --health-interval 5s   --health-timeout 2s   --health-retries 3   nginx:alpine
sudo docker service ps hc
```

### 2. Zasymuluj problem

Wejdź do jednego z kontenerów i usuń pliki nginx, żeby healthcheck zaczął padać:

```bash
cid=$(sudo docker ps --filter name=hc -q | head -n1)
sudo docker exec -it "$cid" sh -lc 'rm -rf /usr/share/nginx/html/*'
```

Obserwuj zmiany:

```bash
sudo docker ps --filter name=hc
sudo docker service ps hc
```


## Weryfikacja
- Po pewnym czasie powinieneś zobaczyć restarty lub podmianę taska.

## Cleanup
```bash
sudo docker service rm hc
```

