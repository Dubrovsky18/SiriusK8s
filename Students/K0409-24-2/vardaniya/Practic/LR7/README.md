# LR7 — Kubernetes: RBAC, NetworkPolicy, TLS

**Студент:** Вардания Леван Меджитович  
**Группа:** K0409-24-2

## Цель работы

Изучить базовые механизмы безопасности в Kubernetes: RBAC, NetworkPolicy и TLS.

## Ход работы

### 1. RBAC

Сначала был создан namespace `rbac-demo`, ServiceAccount `app-reader`, Role `pod-reader` и RoleBinding.

После этого были проверены права доступа для сервисного аккаунта.

Проверка права на просмотр pod:

```bash
kubectl auth can-i list pods -n rbac-demo --as=system:serviceaccount:rbac-demo:app-reader
```

Проверка права на удаление pod:
kubectl auth can-i delete pods -n rbac-demo --as=system:serviceaccount:rbac-demo:app-reader

2. NetworkPolicy

Далее был создан namespace netpol-demo и три pod:
	•	frontend
	•	backend
	•	database

После этого были применены NetworkPolicy:
	•	default deny ingress
	•	отдельное правило, разрешающее доступ от backend к database

Проверка доступа от frontend к database-svc:

kubectl exec -n netpol-demo -c frontend frontend -- wget -T 5 -O- database-svc

На скриншоте видно, что соединение завершается по timeout, значит политика сети работает.

Проверка доступа от backend к database-svc:

kubectl exec -n netpol-demo -c backend backend -- wget -qO- database-svc

На скриншоте видно, что backend успешно получает ответ от nginx.

3. TLS

После этого были созданы:
	•	собственный CA-сертификат
	•	сертификат для webapp.local
	•	TLS Secret в Kubernetes
	•	nginx pod и service для HTTPS

Проверка сертификата:

openssl verify -CAfile ca.crt webapp.crt

На скриншоте видно, что сертификат успешно проверяется.

Затем был выполнен запрос по HTTPS с использованием доверенного CA:

curl --cacert ca.crt https://webapp.local

На скриншоте видно, что nginx отвечает по TLS.

Вывод

В ходе лабораторной работы были изучены три важных механизма безопасности Kubernetes:
RBAC — управление правами доступа
NetworkPolicy — ограничение сетевого взаимодействия между pod
TLS — защита соединения с помощью сертификатов