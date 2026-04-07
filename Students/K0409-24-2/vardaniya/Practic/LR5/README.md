# LR5 — Kubernetes: Deployment, Service, Ingress

**Студент:** Вардания Леван Меджитович  
**Группа:** K0409-24-2

## Цель работы

Изучить работу Deployment, Service и Ingress в Kubernetes, а также выполнить rolling update и rollback приложения.

## Ход работы

### 1. Создание Deployment

Был создан Deployment `webapp` с тремя репликами.  
После применения манифеста все pod приложения были успешно запущены.

```bash
kubectl get pods
```

2. Создание Service

Для Deployment был создан Service webapp-svc типа NodePort, чтобы к приложению можно было обращаться через IP ноды и порт.

3. Rolling update и история ревизий

После этого был выполнен rolling update Deployment.
Затем была просмотрена история развёртываний:

kubectl rollout history deployment/webapp

На скриншоте видно минимум две ревизии.
После проверки был выполнен rollback.

4. Настройка Ingress

Далее был включён ingress в minikube и создан Ingress для маршрутизации:
	•	/ → webapp-svc
	•	/api → api-svc

Также в /etc/hosts была добавлена запись для webapp.local.

5. Проверка root-маршрута

Запрос к корню сайта:
curl webapp.local

6. Проверка API-маршрута

Запрос к API:
curl webapp.local/api

Разница между ClusterIP и NodePort
	•	ClusterIP — сервис доступен только внутри кластера Kubernetes
	•	NodePort — сервис доступен снаружи через IP ноды и выделенный порт

Вывод

В ходе лабораторной работы был создан Deployment с тремя репликами, настроен Service типа NodePort, выполнены rolling update и rollback, а также настроен Ingress для маршрутизации запросов на разные сервисы.