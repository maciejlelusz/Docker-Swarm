# 05-Overlay — Sieci overlay

Nauczymy się tworzyć sieci overlay i sprawdzimy komunikację między serwisami na różnych hostach.

## Cel
- Utworzyć sieć overlay.
- Wdrożyć 2 serwisy w jednej sieci.
- Zrozumieć izolację i podstawowy troubleshooting.

## Wymagania
- Moduł 02.
- `jq` (opcjonalnie) do czytania inspekcji.

## Teoria (w skrócie)
Sieć **overlay** pozwala łączyć kontenery/serwisy między hostami. Swarm buduje ją na VXLAN (UDP/4789).
W Swarm sieci tworzymy zwykle na managerze, a następnie przypinamy do serwisów/stacków.


## Ćwiczenia
### 1. Sieć overlay

Na `manager01`:

```bash
sudo docker network create --driver overlay --attachable appnet
sudo docker network ls
sudo docker network inspect appnet | jq '.[0].Driver, .[0].Scope'
```

### 2. Deploy przykładowego stacka

W repo jest gotowy plik: `05-Overlay/stack.yml`.

```bash
sudo docker stack deploy -c 05-Overlay/stack.yml netdemo
sudo docker service ls
sudo docker service ps netdemo_web
sudo docker service logs -f --tail 20 netdemo_curl
```

### 3. Szybki test DNS w overlay

```bash
curl_task=$(sudo docker ps --filter name=netdemo_curl -q | head -n1)
sudo docker exec -it "$curl_task" nslookup web
```


## Weryfikacja
- Logi `netdemo_curl` pokazują cykliczne `ok`.
- `nslookup web` zwraca adres usługi w overlay.

## Cleanup
```bash
sudo docker stack rm netdemo
sudo docker network rm appnet
```


