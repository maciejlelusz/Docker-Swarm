# 11-Stack — Stos (stack) i pliki Compose

Wdrażamy aplikację wieloserwisową w oparciu o plik Compose v3 i `docker stack deploy`.

## Cel
- Zrozumieć różnice: compose (lokalnie) vs stack (Swarm).
- Umieć wdrożyć i zaktualizować stack.
- Użyć `configs` jako przykład konfiguracji aplikacji.

## Wymagania
- Moduł 05.
- Dostęp do portu 8088 z Twojej sieci (opcjonalnie).

## Teoria (w skrócie)
`docker stack deploy` bierze plik Compose (v3+) i tworzy: serwisy, sieci, configi, sekrety.

W stacku często:
- opisujesz `deploy.*` (replicas, update_config, restart_policy),
- budujesz sieci overlay,
- trzymasz konfigurację w `configs` i dane w wolumenach.


## Ćwiczenia
W katalogu `11-Stack/` masz gotowy przykład.

### 1. Deploy

```bash
sudo docker stack deploy -c 11-Stack/stack.yml demo
sudo docker stack ls
sudo docker service ls
```

### 2. Test

```bash
curl -s http://<IP_WEZLA>:8088/
curl -s http://<IP_WEZLA>:8088/whoami/
```

### 3. Aktualizacja konfiguracji

Zmień `11-Stack/nginx/default.conf` i przeładuj stack:

```bash
sudo docker stack deploy -c 11-Stack/stack.yml demo
```

> Swarm wykryje zmianę configu i wykona update serwisu, który go używa (tu: `nginx`).


## Weryfikacja
- `demo_nginx` i `demo_whoami` działają, a endpointy zwracają odpowiedź.
- Ponowny deploy nie psuje stanu, tylko wprowadza zmiany.

## Cleanup
```bash
sudo docker stack rm demo
```

