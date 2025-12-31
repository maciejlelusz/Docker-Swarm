# 08-Constraints — Constraints i placement

Sterujemy, gdzie uruchamiają się taski: role, etykiety i preferencje.

## Cel
- Umieć użyć `--constraint` i `--placement-pref`.
- Zobaczyć efekt etykiet z modułu 02.

## Wymagania
- Moduł 02 (etykiety).

## Teoria (w skrócie)
Constraints filtrują węzły (twardy warunek). Preferences są miękkie i wpływają na rozkład (np. spread po labelach).

## Ćwiczenia
### 1. Twarde constrainty (labels)

```bash
sudo docker service create --name pinned   --replicas 2   --constraint 'node.labels.zone == az1'   nginx:alpine
sudo docker service ps pinned
```

### 2. Spread po strefach (preference)

```bash
sudo docker service create --name spreaded   --replicas 6   --placement-pref 'spread=node.labels.zone'   nginx:alpine
sudo docker service ps spreaded
```


## Weryfikacja
- `pinned` uruchamia się wyłącznie na `worker01`.
- `spreaded` rozkłada taski pomiędzy węzły zgodnie z labelami (w miarę możliwości).

## Cleanup
```bash
sudo docker service rm pinned spreaded
```

