# bparser

Example of the bash daemon (systemd)

Требования. Нужны установленные inotify-tools https://github.com/inotify-tools/inotify-tools/wiki

git clone https://github.com/zirf0/bparse.git
cd bparse
Внимательно. Файлов всего три 

*bparse* это файл конфигурации.
*bparse.sh* это сам скрипт.
*bparse.service* это файл службы.

*install.sh* раскидывает файлы по директориям, это для Ubuntu 20.04. Для CentOS его надо редактировать.

Скрипт по факту выполняет dry-run, то есть печатает, что собирался исполнить и дополнительную информацию.
Но я проверил на докере.
SIGHUP строго говоря перезагрузка (reload) скорее, но смысл думаю понятен.
Проверки запущена ли служба не происходит для простоты.
Также нет проверок на существование файлов для того же.

Тест простой, в файле /var/tmp/test кусок лога.После запуска службы
sudo systemctl start bparse
дернуть файл

cat aaaa >> /var/tmp/test

sudo systemctl status  bparse

Что-то такое

 sudo systemctl status bparse
● bparse.service - Simple bash log parser
     Loaded: loaded (/lib/systemd/system/bparse.service; disabled; vendor preset: enabled)
     Active: active (running) since Wed 2020-07-29 10:04:14 UTC; 48min ago
    Process: 2191 ExecStart=/usr/local/bin/bparse.sh (code=exited, status=0/SUCCESS)
   Main PID: 2194 (bparse.sh)
      Tasks: 3 (limit: 1164)
     Memory: 1.3M
     CGroup: /system.slice/bparse.service
             ├─2194 /bin/bash /usr/local/bin/bparse.sh
             ├─2195 /usr/bin/inotifywait -e modify /var/tmp/test -m
             └─2196 /bin/bash /usr/local/bin/bparse.sh

Jul 29 10:04:14 ip-172-31-47-190 bparse.sh[2191]: Running ...
Jul 29 10:04:14 ip-172-31-47-190 systemd[1]: Started Simple bash log parser.
Jul 29 10:04:14 ip-172-31-47-190 bparse.sh[2195]: Setting up watches.
Jul 29 10:04:14 ip-172-31-47-190 bparse.sh[2195]: Watches established.
Jul 29 10:04:32 ip-172-31-47-190 bparse.sh[2196]: Service original name: savonix-worker-tasks:
Jul 29 10:04:32 ip-172-31-47-190 bparse.sh[2196]: Service parced name: savonix-worker-tasks
Jul 29 10:04:32 ip-172-31-47-190 bparse.sh[2196]: /usr/bin/sudo /usr/bin/kill -HUP

у меня службы нет pidof ничего и не выводит




 

 