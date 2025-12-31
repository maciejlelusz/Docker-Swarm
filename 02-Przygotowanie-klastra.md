# 02-Przygotowanie-klastra — Przygotowanie klastra

Inicjalizujemy Swarm Mode i dołączamy węzły do klastra.

## Cel
- Zainicjalizować klaster na managerze.
- Dołączyć workery.
- Poznać tokeny join i podstawowe komendy `docker node`.

## Wymagania
- Moduł 01.
- Porty wymagane przez Swarm otwarte między węzłami (TCP 2377, TCP/UDP 7946, UDP 4789).

## Teoria (w skrócie)
Zakładamy, że w labie masz co najmniej 3 węzły:

- `manager01` (manager)
- `worker01`, `worker02` (workery)

W komendach używam `sudo` — usuń je, jeśli pracujesz jako root lub masz odpowiednią konfigurację dockera.


Swarm używa:
- **2377/TCP** — komunikacja control-plane (join/zarządzanie),
- **7946/TCP+UDP** — gossip i wykrywanie,
- **4789/UDP** — overlay (VXLAN) dla sieci między hostami.


## Ćwiczenia
### 1. Init na managerze

Na `manager01`:

```bash
sudo docker swarm init --advertise-addr <IP_MANAGERA>
```

> Jeśli masz poprawnie skonfigurowany DNS i tylko jeden interfejs, często wystarczy `docker swarm init`.

### 2. Pobierz token dołączania

```bash
sudo docker swarm join-token worker
```

Skopiuj komendę `docker swarm join ...` i wykonaj ją na `worker01` oraz `worker02`.

### 3. Lista węzłów

Na `manager01`:

```bash
sudo docker node ls
```

### 4. Etykiety (labels) — przygotowanie pod placement

Nadajmy etykiety (przykładowo):

```bash
sudo docker node update --label-add zone=az1 worker01
sudo docker node update --label-add zone=az2 worker02
sudo docker node inspect worker01 --format '{{ json .Spec.Labels }}' | jq .
```


## Weryfikacja
- `docker node ls` pokazuje 3 węzły w stanie `Ready`.
- Workery mają ustawione etykiety `zone`.


## Cleanup
Jeśli musisz rozwiązać klaster:

Na workerach:
```bash
sudo docker swarm leave
```

Na managerze:
```bash
sudo docker swarm leave --force
```


## Materiały dodatkowe
- Porty Swarm: https://docs.docker.com/engine/swarm/swarm-tutorial/#open-protocols-and-ports-between-the-hosts

