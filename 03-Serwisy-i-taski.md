# 03-Serwisy-i-taski — Serwisy i taski

Tworzymy pierwszy serwis i uczymy się jak Swarm zarządza taskami.

## Cel
- Zrozumieć różnicę service vs task vs container.
- Umieć tworzyć, skalować i usuwać serwisy.
- Umieć znaleźć logi i diagnozować rozmieszczenie tasków.

## Wymagania
- Działający klaster z modułu 02.

## Teoria (w skrócie)
W Swarm najczęściej pracujesz na poziomie **serwisu** (deklarujesz *stan docelowy*), a Swarm tworzy **taski** (instancje) i uruchamia dla nich kontenery.

Najważniejsze komendy:
- `docker service create|ls|ps|inspect|rm|scale|update|logs`
- `docker node ls|ps|inspect`


## Ćwiczenia
### 1. Prosty serwis

Na `manager01`:

```bash
sudo docker service create --replicas 1 --name helloworld alpine:3.20 ping -c 3 docker.com
sudo docker service ls
sudo docker service ps helloworld
```

### 2. Skalowanie

```bash
sudo docker service scale helloworld=5
sudo docker service ps helloworld
```

### 3. Logi serwisu

```bash
sudo docker service logs -f --tail 50 helloworld
```

### 4. Inspekcja i powiązanie task → node

```bash
sudo docker service ps helloworld --no-trunc
sudo docker node ps worker01
```

### 5. Usuwanie

```bash
sudo docker service rm helloworld
```


## Weryfikacja
- Po skalowaniu widzisz 5 tasków w stanie `Running` (lub `Complete`, jeśli kontener kończy pracę).
- `service logs` pokazuje output z tasków.

## Cleanup
- `docker service rm helloworld`.

