# 04_binary_break

**Студент:** Вардания Леван Меджитович  
**Группа:** K0409-24-2

## Цель работы

Изучить причины, по которым исполняемый файл может не запускаться в Linux, и научиться определять тип ошибки с помощью стандартных утилит.

## Ход работы

Сначала был запущен скрипт `04_binary_break.sh`, который создал несколько специально повреждённых или неправильно настроенных файлов в каталоге `/opt/break_lab`.

Команда запуска:

```bash
sudo bash 04_binary_break.sh
```

На скриншоте видно, что были созданы следующие файлы:
	•	mystery_no_exec
	•	mystery_bad_interpreter
	•	mystery_truncated_elf
	•	not_a_binary

1. Файл без права на исполнение

Сначала был проверен файл mystery_no_exec.

Использованные команды:
/opt/break_lab/mystery_no_exec
ls -l /opt/break_lab/mystery_no_exec
file /opt/break_lab/mystery_no_exec
sudo chmod +x /opt/break_lab/mystery_no_exec
ls -l /opt/break_lab/mystery_no_exec
/opt/break_lab/mystery_no_exec

На скриншоте видно, что:
	•	сначала файл не запускался из-за Permission denied
	•	после добавления права на исполнение через chmod +x он успешно запустился

2. Файл с несуществующим интерпретатором

Далее был проверен mystery_bad_interpreter.

Использованные команды:
ls -l /opt/break_lab/mystery_bad_interpreter
file /opt/break_lab/mystery_bad_interpreter
/opt/break_lab/mystery_bad_interpreter
head -n 1 /opt/break_lab/mystery_bad_interpreter

На скриншоте видно, что файл содержит некорректный shebang:
#!/bin/no_such_interpreter_break_lab
Из-за этого запуск завершается ошибкой required file not found.

3. Усечённый ELF-файл

Далее был проверен mystery_truncated_elf.

Использованные команды:
ls -l /opt/break_lab/mystery_truncated_elf
file /opt/break_lab/mystery_truncated_elf
ldd /opt/break_lab/mystery_truncated_elf
/opt/break_lab/mystery_truncated_elf

На скриншоте видно, что файл определяется как ELF, но он повреждён и запускается с ошибкой Exec format error.

4. Текстовый файл под видом бинарника

Последним был проверен файл not_a_binary.

Использованные команды:
ls -l /opt/break_lab/not_a_binary
file /opt/break_lab/not_a_binary
cat /opt/break_lab/not_a_binary
/opt/break_lab/not_a_binary
bash /opt/break_lab/not_a_binary

На скриншоте видно, что это обычный ASCII-текст с содержимым echo hello, который исполняется как shell-скрипт.

Вывод

В ходе работы были рассмотрены основные причины, по которым файл может не запускаться в Linux:
	•	отсутствует право на исполнение
	•	указан несуществующий интерпретатор
	•	бинарный файл повреждён
	•	файл вообще не является бинарником, а представляет собой текст

Для диагностики использовались стандартные утилиты Linux: ls, file, ldd, head, chmod.