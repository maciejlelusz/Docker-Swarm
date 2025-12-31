# 06-Ingress-i-Host-Network — Ingress i host network

Poznamy routing mesh (ingress) oraz publikację portu w trybie `host`.

## Cel
- Zrozumieć różnicę między publikacją portów w trybie ingress i host.
- Umieć dobrać tryb do aplikacji (LB vs sticky / performance / UDP itp.).

## Wymagania
- Moduł 02.

## Teoria (w skrócie)
Publikując port serwisu masz dwa najczęstsze warianty:

- **ingress (routing mesh)** — ruch na opublikowany port dowolnego węzła trafia do tasków serwisu (przez overlay ingress).
- **host** — port jest otwierany **na węźle**, na którym działa task (bez routing mesh).

Ingress jest wygodny, host daje większą przewidywalność (np. dla NodePort, wydajności, niektórych protokołów).


## Ćwiczenia
### 1. Serwis z publikacją w trybie ingress (domyślnie)

```bash
sudo docker service create --name web-ingress --replicas 3 -p 8080:80 nginx:alpine
sudo docker service ps web-ingress
```

Wejdź na `http://<IP_DOWOLNEGO_WEZLA>:8080` — powinno działać niezależnie od tego, gdzie są taski.

### 2. Serwis w trybie host

```bash
sudo docker service create --name web-host --replicas 3   --publish published=8081,target=80,mode=host   nginx:alpine
sudo docker service ps web-host
```

Teraz `http://<IP_WEZLA_Z_TASKIEM>:8081` zadziała tylko na węzłach, gdzie jest uruchomiony task.

### 3. Porównanie

Sprawdź mapowanie portów i routing:

```bash
sudo docker service inspect web-ingress --format '{{ json .Endpoint.Spec.Ports }}' | jq .
sudo docker service inspect web-host --format '{{ json .Endpoint.Spec.Ports }}' | jq .
```


## Weryfikacja
- Ingress działa na każdym węźle.
- Host działa tylko na węźle z taskiem.

## Cleanup
```bash
sudo docker service rm web-ingress web-host
```

