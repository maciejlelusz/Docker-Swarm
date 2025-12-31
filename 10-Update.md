# 10-Update — Rolling update i rollback

Zrobimy aktualizację serwisu z kontrolą tempa i rollback w razie problemu.

## Cel
- Umieć wykonać rolling update.
- Umieć rollback.
- Zrozumieć parametry: parallelism, delay, failure-action.

## Wymagania
- Moduł 03.

## Teoria (w skrócie)
`docker service update` pozwala sterować rolloutem. Dobre praktyki: małe batch'e, healthcheck, monitorowanie błędów, szybki rollback.

## Ćwiczenia
### 1. Start serwisu

```bash
sudo docker service create --name web --replicas 6 nginx:1.25-alpine
sudo docker service ps web
```

### 2. Rolling update

```bash
sudo docker service update   --image nginx:1.26-alpine   --update-parallelism 2   --update-delay 5s   web
sudo docker service ps web
```

### 3. Wymuszenie błędu i rollback

Spróbuj z nieistniejącym tagiem:

```bash
sudo docker service update --image nginx:this-tag-does-not-exist web
sudo docker service ps web
```

Gdy zobaczysz błędy pullowania, zrób rollback:

```bash
sudo docker service rollback web
sudo docker service ps web
```


## Weryfikacja
- Rollout przebiega partiami.
- Po rollback wracasz do poprzedniego obrazu.

## Cleanup
```bash
sudo docker service rm web
```

