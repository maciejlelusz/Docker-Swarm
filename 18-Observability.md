# 18-Observability — Logowanie i monitoring

Minimalny PoC: Prometheus + Grafana jako stack oraz przegląd podejść do logowania w Swarm.

## Cel
- Umieć wdrożyć prosty monitoring w stacku.
- Znać opcje logowania (json-file, syslog, fluentd, loki itp.).

## Wymagania
- Moduł 11.

## Teoria (w skrócie)
Swarm nie narzuca jednej ścieżki obserwowalności. Najczęściej:
- metryki: Prometheus (+ exporters), Grafana
- logi: driver (syslog/fluentd) albo agent na hostach (np. promtail/fluent-bit) do centralnego systemu (Loki/ELK)

W tym labie robimy **najprostszy** deploy, żeby poznać mechanikę stacków i portów.


## Ćwiczenia
### 1. Deploy stacka

```bash
sudo docker stack deploy -c 18-Observability/stack.yml mon
sudo docker service ls
```

### 2. Wejście do UI

- Prometheus: `http://<IP_MANAGER01>:9090`
- Grafana: `http://<IP_MANAGER01>:3000` (domyślne: admin/admin)

### 3. Logi serwisu

```bash
sudo docker service logs -f --tail 50 mon_prometheus
```


## Weryfikacja
- Interfejsy Prometheus i Grafana działają.
- Potrafisz znaleźć logi usług w stacku.

## Cleanup
```bash
sudo docker stack rm mon
```

