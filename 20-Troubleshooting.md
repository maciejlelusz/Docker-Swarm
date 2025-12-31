# 20-Troubleshooting — Troubleshooting i sprzątanie

Zbieramy checklisty i robimy końcowy cleanup.

## Cel
- Umieć szybko zdiagnozować: sieć, scheduling, rollout, obraz, porty.
- Zostawić lab w czystym stanie.

## Wymagania
- Wszystkie poprzednie moduły (lub część).

## Teoria (w skrócie)
### Checklista diagnostyczna (CLI)

- Węzły: `docker node ls`, `docker node ps <node>`
- Serwisy: `docker service ls`, `docker service ps <svc>`, `docker service inspect <svc>`
- Logi: `docker service logs <svc>`
- Sieci: `docker network ls`, `docker network inspect <net>`
- Stacks: `docker stack ls`, `docker stack services <stack>`, `docker stack ps <stack>`

### Najczęstsze przyczyny

- brak portów Swarm między hostami (2377/7946/4789)
- zły `advertise-addr` przy init
- brak obrazu / rate limiting w registry
- constraints wycinają wszystkie węzły
- publikacja portu w trybie host vs ingress (mylenie)


## Ćwiczenia
### 1. Szybka diagnostyka przykładowego błędu

Wygeneruj błąd image pull:

```bash
sudo docker service create --name bad --replicas 2 nginx:nope
sudo docker service ps bad
sudo docker service inspect bad --pretty
```

Zobacz, jak czytać komunikaty i gdzie szukać przyczyny.

### 2. Cleanup wszystkiego

Usuń wszystkie stacki i serwisy utworzone w trakcie warsztatu:

```bash
sudo docker stack ls
sudo docker service ls
```

Następnie usuń wskazane zasoby (uważaj, żeby nie skasować czegoś spoza labu).

Przykład:
```bash
sudo docker service rm bad 2>/dev/null || true
```

Jeśli chcesz wyczyścić klaster (opcjonalnie):
- workery: `docker swarm leave`
- manager: `docker swarm leave --force`


## Weryfikacja
- Potrafisz zdiagnozować typowe problemy komendami z checklisty.

## Cleanup
- Zależnie od potrzeb: usuń serwisy/stacki, ewentualnie rozwiąż klaster.

