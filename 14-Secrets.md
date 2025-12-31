# 14-Secrets — Secrets i Configs

Bezpieczne przekazywanie wrażliwych danych oraz konfiguracji do serwisów.

## Cel
- Utworzyć secret i przekazać go do serwisu.
- Zrozumieć różnice secrets vs configs.
- Zobaczyć rotację secretu (w prostym wariancie).

## Wymagania
- Moduł 11.

## Teoria (w skrócie)
**Secrets** są szyfrowane w Raft na managerach i montowane w kontenerach jako pliki w `/run/secrets/*`.
**Configs** są podobne, ale bez założenia wrażliwości (mogą zawierać np. config nginx).

Dobre praktyki:
- minimalny dostęp (tylko serwisy, które potrzebują),
- rotacja (nowy secret, update serwisu, usunięcie starego).


## Ćwiczenia
### 1. Utwórz secret

```bash
echo -n 'super-tajne-haslo' | sudo docker secret create demo_secret -
sudo docker secret ls
```

### 2. Serwis, który czyta secret

W repo masz prosty skrypt: `14-Secrets/app.sh`.

```bash
sudo docker service create --name secret-app   --secret demo_secret   --replicas 1   alpine:3.20 sh -lc 'apk add --no-cache busybox-extras >/dev/null; /bin/sh /app/app.sh'   --mount type=bind,src=$(pwd)/14-Secrets/app.sh,dst=/app/app.sh,ro
sudo docker service logs -f --tail 20 secret-app
```

### 3. Rotacja (prosty wariant)

Utwórz nowy secret:

```bash
echo -n 'super-tajne-haslo-v2' | sudo docker secret create demo_secret_v2 -
```

Zaktualizuj serwis, żeby używał nowego secretu (i usuń stary):

```bash
sudo docker service update --secret-rm demo_secret --secret-add demo_secret_v2 secret-app
sudo docker secret rm demo_secret
```


## Weryfikacja
- Logi serwisu pokazują wartość secretu.
- Po rotacji widzisz nową wartość.

## Cleanup
```bash
sudo docker service rm secret-app
sudo docker secret rm demo_secret_v2 2>/dev/null || true
```

