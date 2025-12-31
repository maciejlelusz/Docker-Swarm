# 19-Bezpieczenstwo — Bezpieczeństwo klastra

Swarm ma wbudowane mTLS i rotację certyfikatów. Ustalimy bazowe praktyki hardeningu.

## Cel
- Poznać mTLS w Swarm.
- Włączyć autolock (w labie).
- Zrozumieć zasady least privilege dla socketu Dockera.

## Wymagania
- Moduł 02.

## Teoria (w skrócie)
Swarm domyślnie używa szyfrowanej komunikacji i automatycznie zarządza certyfikatami węzłów.

Praktyki:
- ogranicz liczbę managerów i dostęp do nich,
- chroń `docker.sock` (to root-equivalent),
- rozważ `--autolock`, żeby klucze Raft były chronione po restarcie managera,
- kontroluj publikowane porty i sieci.


## Ćwiczenia
### 1. Sprawdź status swarm i certyfikaty

```bash
sudo docker info | sed -n '/Swarm:/,/^$/p'
```

### 2. Autolock (opcjonalnie)

Na managerze:

```bash
sudo docker swarm update --autolock=true
sudo docker swarm unlock-key
```

Zapisz key w bezpiecznym miejscu (w labie może być w notatkach).  
Omów, co się dzieje po restarcie dockera na managerze (wymaga `docker swarm unlock`).

### 3. Ryzyko docker.sock (dyskusja)

Przypomnij sobie moduł 04/15: bind-mount `/var/run/docker.sock` daje kontenerowi pełną kontrolę nad hostem.


## Weryfikacja
- Rozumiesz, co daje autolock i jakie ma koszty operacyjne.

## Cleanup
- (opcjonalnie) Wyłącz autolock: `docker swarm update --autolock=false`.

