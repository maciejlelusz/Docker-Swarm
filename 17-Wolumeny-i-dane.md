# 17-Wolumeny-i-dane — Wolumeny i trwałość danych

Jak przechowywać dane w Swarm i jakie są ograniczenia (szczególnie w środowiskach wielowęzłowych).

## Cel
- Zrozumieć local volume vs shared storage.
- Umieć przypiąć serwis do konkretnego węzła, jeśli używa local volume.
- Znać patterny: backup, replikacja, zewnętrzny storage.

## Wymagania
- Moduł 08 (constraints).

## Teoria (w skrócie)
W Swarm standardowy `local` volume jest **lokalny dla hosta**.  
Jeśli serwis z local volume zostanie przeniesiony na inny węzeł, dane nie "pójdą" za nim.

Opcje:
- constraints na konkretny węzeł (dla labu / prostych przypadków),
- zewnętrzny storage (NFS, iSCSI, cloud volumes),
- aplikacyjne HA (replikacja DB).


## Ćwiczenia
### 1. Serwis z local volume + constraint

Utwórz wolumen na `worker01` (komenda na workerze):

```bash
sudo docker volume create dbdata
```

Na `manager01` uruchom serwis przypięty do `worker01`:

```bash
sudo docker service create --name redis   --replicas 1   --constraint 'node.hostname == worker01'   --mount type=volume,src=dbdata,dst=/data   redis:7-alpine
sudo docker service ps redis
```

### 2. Co się stanie bez constraint?

Usuń serwis i uruchom ponownie bez constraint — scheduler może umieścić go gdzie indziej:

```bash
sudo docker service rm redis
sudo docker service create --name redis --replicas 1 --mount type=volume,src=dbdata,dst=/data redis:7-alpine
sudo docker service ps redis
```

Omów, dlaczego to może być problem.


## Weryfikacja
- Rozumiesz, że local volume wymaga świadomego placementu lub zewnętrznego storage.

## Cleanup
```bash
sudo docker service rm redis
```

