# 09-Zmiany-w-klastrze — Zmiany w klastrze

Scenariusze operacyjne: drain node, promote/demote, usuwanie węzłów i quorum.

## Cel
- Umieć bezpiecznie wyłączyć węzeł z planowania (`drain`).
- Zrozumieć rolę managerów i quorum.
- Umieć dodać/usunąć węzeł.

## Wymagania
- Moduł 02.

## Teoria (w skrócie)
**Drain** przenosi taski na inne węzły (dla serwisów replikowanych).  
**Managers** trzymają stan klastra (Raft). Dla HA zwykle używa się nieparzystej liczby managerów (3/5).


## Ćwiczenia
### 1. Drain węzła

Uruchom serwis:

```bash
sudo docker service create --name demo --replicas 6 nginx:alpine
sudo docker service ps demo
```

Wyłącz planowanie na `worker01`:

```bash
sudo docker node update --availability drain worker01
sudo docker service ps demo
```

Zwróć uwagę, że taski powinny zostać przeniesione na inne węzły.

Przywróć:

```bash
sudo docker node update --availability active worker01
```

### 2. Promote/demote (opcjonalnie)

Pokaż token dla managera:

```bash
sudo docker swarm join-token manager
```

> Ten krok wymaga dodatkowego węzła albo przebudowania ról w labie. Jeśli masz tylko 1 manager, nie rób tego na produkcyjnych ćwiczeniach.


## Weryfikacja
- Po `drain` taski z `worker01` znikają i pojawiają się na innych węzłach.

## Cleanup
```bash
sudo docker service rm demo
```

