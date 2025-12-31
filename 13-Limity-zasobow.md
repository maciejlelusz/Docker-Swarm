# 13-Limity-zasobow — Limity zasobów i reservations

Uczymy się jak deklarować limity CPU/RAM oraz jak wpływa to na scheduling.

## Cel
- Umieć ustawić limity i rezerwacje.
- Zrozumieć wpływ na scheduler.
- Zobaczyć zachowanie przy OOM.

## Wymagania
- Moduł 03.

## Teoria (w skrócie)
`limits` ograniczają użycie zasobów przez kontener, `reservations` wpływają na planowanie (czy na węźle jest wystarczająco zasobów).

## Ćwiczenia
### 1. Serwis z limitami

```bash
sudo docker service create --name limits-demo   --replicas 2   --limit-cpu 0.25   --limit-memory 128M   --reserve-memory 64M   nginx:alpine
sudo docker service inspect limits-demo --format '{{ json .Spec.TaskTemplate.Resources }}' | jq .
```

### 2. (Opcjonalnie) Symulacja OOM

To ćwiczenie może obciążyć lab — rób ostrożnie.

```bash
sudo docker service create --name oom   --replicas 1   --limit-memory 64M   alpine:3.20 sh -lc 'python3 - <<PY
x=[]
while True:
  x.append("x"*1024*1024)
PY'
```

Obserwuj `docker service ps oom`.


## Weryfikacja
- Inspekcja pokazuje ustawione limity.
- W scenariuszu OOM task może się restartować.

## Cleanup
```bash
sudo docker service rm limits-demo oom 2>/dev/null || true
```

