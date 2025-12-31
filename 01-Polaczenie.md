# 01-Polaczenie — Połączenie z labem

Dziś zaczynamy od przygotowania środowiska: logowanie na węzły i szybka kontrola, czy wszystko działa.

## Cel
- Zalogować się na wszystkie węzły.
- Zweryfikować wersję Dockera i podstawową łączność.
- Ustalić konwencję pracy: gdzie wykonujemy komendy manager/worker.

## Wymagania
- Dostęp SSH do węzłów (klucze/hasło).
- Zainstalowany Docker Engine na każdym węźle.

## Teoria (w skrócie)
Zakładamy, że w labie masz co najmniej 3 węzły:

- `manager01` (manager)
- `worker01`, `worker02` (workery)

W komendach używam `sudo` — usuń je, jeśli pracujesz jako root lub masz odpowiednią konfigurację dockera.

Docker Swarm to tryb pracy Dockera (Swarm Mode). Klastrami zarządzają **managery**, a zadania wykonują **workery** (manager też może wykonywać taski, ale zwykle ograniczamy to constraintem).

## Ćwiczenia
### 1. Logowanie i identyfikacja węzła

Na każdym węźle uruchom:

```bash
hostname
uname -a
sudo docker version
sudo docker info | sed -n '1,40p'
```

### 2. Szybki sanity-check sieci

Na `manager01`:

```bash
ping -c 1 worker01
ping -c 1 worker02
```

Jeśli w labie nie działa DNS po nazwach hostów, używaj adresów IP.

### 3. Alias do szybkiego podglądu

Dodaj do swojej sesji (opcjonalnie):

```bash
alias d='sudo docker'
alias ds='sudo docker service'
alias dn='sudo docker node'
```


## Weryfikacja
- `docker info` pokazuje poprawną wersję i brak krytycznych błędów.
- Pingi między węzłami działają (albo masz alternatywę: IP).


## Cleanup
- Brak.

## Materiały dodatkowe
- Dokumentacja: https://docs.docker.com/engine/swarm/

