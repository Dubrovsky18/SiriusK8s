# LR6 — Kubernetes: ConfigMap, Secret, PVC

**Студент:** Вардания Леван Меджитович  
**Группа:** K0409-24-2

## Цель работы

Изучить использование ConfigMap, Secret и PersistentVolumeClaim в Kubernetes.

## Ход работы

### 1. Работа с ConfigMap

Сначала был создан ConfigMap `app-config` из литералов, а затем ConfigMap `nginx-conf` из файла `nginx.conf`.

После этого был создан pod `config-demo`, в котором ConfigMap передавался тремя способами:

- через `envFrom`
- через `configMapKeyRef`
- через монтирование файла как volume

Проверка логов pod:

```bash
kubectl logs config-demo
```

На скриншоте видно, что:
	•	переменные окружения были переданы через envFrom
	•	переменная MY_ENV была получена через configMapKeyRef
	•	файл nginx.conf был смонтирован в контейнер

2. Работа с Secret

Далее был создан Secret db-credentials с логином и паролем.

Проверка Secret в YAML:

kubectl get secret db-credentials -o yaml

На скриншоте видно, что значения хранятся в data в виде base64.

3. Работа с PersistentVolumeClaim

Для PostgreSQL был создан PersistentVolumeClaim с именем postgres-pvc.
После применения манифеста PVC успешно привязался к тому.

Проверка PVC:
kubectl get pvc postgres-pvc

На скриншоте видно, что статус PVC — Bound.

4. Проверка сохранности данных после пересоздания pod

После запуска PostgreSQL была создана таблица items и добавлены тестовые данные:
	•	apple
	•	banana
	•	orange

Затем pod PostgreSQL был удалён, после чего Deployment автоматически создал новый pod.
После пересоздания был выполнен повторный запрос:

SELECT * FROM items;

На скриншоте видно, что данные сохранились, значит PVC работает корректно.

Вывод

В ходе лабораторной работы были изучены:
передача конфигурации через ConfigMap
хранение чувствительных данных через Secret
сохранение данных с помощью PersistentVolumeClaim

Также было подтверждено, что данные PostgreSQL не теряются после удаления и пересоздания pod.