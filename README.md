![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC%20BY--NC--ND%204.0-lightgrey.svg)

# Warsztat — Docker Swarm Fundamentals

Repozytorium plików do **jednodniowego** warsztatu Docker Swarm (Swarm Mode). Materiały są ułożone tak, aby przejść je kolejno — od uruchomienia klastra po wdrożenie aplikacji w stacku oraz tematy operacyjne (update, healthcheck, sekrety, obserwowalność).

> **Tip:** Każdy krok ma plik `XX-*.md` oraz katalog `XX-*` z plikami do ćwiczeń.

## Dla kogo?

- programiści i administratorzy, którzy znają podstawy Dockera (obrazy, kontenery, docker-compose)
- osoby chcące zrozumieć *orkiestrację* w praktyce: sieci, service discovery, rollout, HA i troubleshooting

## Wymagania wstępne

- podstawowa znajomość Dockera i Linuxa/Unix
- elementarna wiedza o sieciach TCP/IP (porty, DNS, routing)
- dostęp do labu z 3+ węzłami (VM/serwery) lub środowisko lokalne umożliwiające uruchomienie Swarm

## Jak pracować z repo

1. Przejdź przez moduły po kolei (01 → 20).
2. W każdym module:
   - przeczytaj **Cel** i **Teorię**
   - wykonaj **Ćwiczenia**
   - sprawdź wynik w sekcji **Weryfikacja**
   - na koniec zrób **Cleanup**, jeśli jest

## Agenda

- [01-Polaczenie — Połączenie z labem](01-Polaczenie.md)
- [02-Przygotowanie-klastra — Przygotowanie klastra](02-Przygotowanie-klastra.md)
- [03-Serwisy-i-taski — Serwisy i taski](03-Serwisy-i-taski.md)
- [04-Visualizer — Wizualizacja klastra](04-Visualizer.md)
- [05-Overlay — Sieci overlay](05-Overlay.md)
- [06-Ingress-i-Host-Network — Ingress i host network](06-Ingress-i-Host-Network.md)
- [07-Service-discovery — Service discovery](07-Service-discovery.md)
- [08-Constraints — Constraints i placement](08-Constraints.md)
- [09-Zmiany-w-klastrze — Zmiany w klastrze](09-Zmiany-w-klastrze.md)
- [10-Update — Rolling update i rollback](10-Update.md)
- [11-Stack — Stos (stack) i pliki Compose](11-Stack.md)
- [12-Health-check — Healthcheck i auto-healing](12-Health-check.md)
- [13-Limity-zasobow — Limity zasobów i reservations](13-Limity-zasobow.md)
- [14-Secrets — Secrets i Configs](14-Secrets.md)
- [15-Portainer — Portainer](15-Portainer.md)
- [16-Rancher — Rancher (legacy) i alternatywy](16-Rancher.md)
- [17-Wolumeny-i-dane — Wolumeny i trwałość danych](17-Wolumeny-i-dane.md)
- [18-Observability — Logowanie i monitoring](18-Observability.md)
- [19-Bezpieczenstwo — Bezpieczeństwo klastra](19-Bezpieczenstwo.md)
- [20-Troubleshooting — Troubleshooting i sprzątanie](20-Troubleshooting.md)

## Licencja
Materiały: **CC BY-NC-ND 4.0**.
