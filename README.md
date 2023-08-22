# Домашнее задание к занятию "`Система мониторинга Zabbix - Часть 1`" - `Petr`

## Задание 1

### install:

```
wget https://repo.zabbix.com/zabbix/6.4/debian/pool/main/z/zabbix-release/zabbix-release_6.4-1+debian11_all.deb
dpkg -i zabbix-release_6.4-1+debian11_all.deb
apt update

apt install zabbix-server-pgsql zabbix-frontend-php php7.4-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-agent

sudo -u postgres createuser --pwprompt zabbix
sudo -u postgres createdb -O zabbix zabbix

zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

nano /etc/zabbix/zabbix_server.conf
DBPassword=password

systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2

http://localhost/zabbix
Admin
zabbix
```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.5-Netology/img_homework/1.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.5-Netology/img_homework/1.2.png?raw=true)

## Задание 2

```
find / -name zabbix_agentd.conf
nano /etc/zabbix/zabbix_agentd.conf
Server=IP_address_zabbix_server

systemctl restart zabbix-agent.service
systemctl status zabbix-agent.service
```

![Скрин 1](https://github.com/tprvx/Netology-Homeworks/blob/8.5-Netology/img_homework/2.1.png?raw=true)

![Скрин 2](https://github.com/tprvx/Netology-Homeworks/blob/8.5-Netology/img_homework/2.2.png?raw=true)

![Скрин 3](https://github.com/tprvx/Netology-Homeworks/blob/8.5-Netology/img_homework/2.3.png?raw=true)