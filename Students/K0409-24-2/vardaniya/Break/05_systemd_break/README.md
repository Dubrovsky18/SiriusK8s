# 05_systemd_break

**Студент:** Вардания Леван Меджитович  
**Группа:** K0409-24-2

## Цель работы

Изучить диагностику проблемного systemd-сервиса, который постоянно перезапускается, и восстановить систему после поломки.

## Ход работы

Сначала был запущен скрипт `05_systemd_break.sh`, который создаёт unit `script-server.service` и запускает его в режиме постоянных перезапусков.

Команда запуска:

```bash
sudo bash 05_systemd_break.sh
```

На скриншоте видно, что:
	•	был создан unit script-server.service
	•	сервис был запущен
	•	скрипт сразу сообщает, что сервис попал в restart loop

Проверка статуса сервиса

Для диагностики была использована команда:

systemctl status script-server --no-pager

На скриншоте видно, что:
	•	сервис находится в состоянии activating (auto-restart)
	•	основной процесс завершился с ошибкой
	•	код завершения: status=1/FAILURE

Анализ логов через journalctl

Для просмотра логов использовалась команда:

journalctl -u script-server -b --no-pager -n 30

На скриншоте видно:
	•	многократные попытки перезапуска сервиса
	•	увеличение restart counter
	•	сообщения Main process exited
	•	сообщения Failed with result 'exit-code'

Это подтверждает, что unit уходит в цикл перезапусков.

Восстановление системы

Для отката использовался скрипт:

sudo bash 99_restore_systemd.sh

После этого были выполнены проверки:

systemctl status script-server --no-pager || echo "script-server service removed"
systemctl list-unit-files | grep script-server || echo "script-server unit not found"

На скриншоте видно, что:
	•	unit script-server.service удалён
	•	сервис больше не существует в системе

Вывод

В ходе работы была выполнена диагностика проблемного systemd-сервиса.
Удалось определить, что сервис завершался с ошибкой и автоматически перезапускался по политике Restart=always.
После этого unit был корректно удалён с помощью восстановительного скрипта.

