# DefenceNet - Petr


### Задание 1

Готовим 2 виртуалки, атакуемую (Debian к примеру) и атакующую (Kali)
Нужно установить и настроить Suricata (для обнаружения атак) и fail2ban (для противодействия брутфорс атакам)

Ставим Suricata:

```bash
sudo apt install suricata
sudo suricata-update

sudo nano /etc/suricata/suricata.yaml
	EXTERNAL_NET: "any"  # это раскомментировать
	...
	default-rule-path: /var/lib/suricata/rules  # это проверить чтобы так было
	rule-files:
	  - suricata.rules
	...
	# И везде поменять имя сетевого интерфейса, к примеру enp0s3

sudo systemctl status suricata

# логи сурикаты
sudo tail /var/log/suricata/suricata.log
sudo tail /var/log/suricata/stats.log

# мониторим сработку правил сурикаты во время вторжений
sudo tail -f /var/log/suricata/fast.log

# ставим обязательно, чтобы логи ssh писались в /var/log/auth.log, иначе fail2ban не будет работать, он парсит эти логи
apt-get install rsyslog
```

Ставим fail2ban:

```bash
sudo apt install fail2ban
# без него служба не запускается
touch /var/log/auth.log

systemctl status fail2ban

# логи подключений по ssh
cat /var/log/auth.log
# логи fail2ban
cat /var/log/fail2ban.log

```

Сканируем порты в разных режимах c Kali:

```bash
sudo nmap -sA 192.168.1.110
sudo nmap -sS 192.168.1.110
sudo nmap -sT 192.168.1.110
sudo nmap -sV 192.168.1.110
```

Сканирование отобразилость только в логах сурикаты, поскольку не было авторизации по SSH, а только попытки уствновления TCP соединения на разных портах.

![Задание 1.1](https://github.com/tprvx/Netology/blob/DefenceNet/img/1.1.png?raw=true)
![Задание 1.2](https://github.com/tprvx/Netology/blob/DefenceNet/img/1.2.png?raw=true)


### Задание 2

Проводим подбор пароля без включенной защиты от брутфорса fail2ban

```bash
hydra -L logins.txt -P pass.txt 192.168.1.110 ssh
```

Включаем защиту от брутфорса и снова подбираем

```bash
nano /etc/fail2ban/jail.conf
	...
	[sshd]
	enabled: true
	...

hydra -L logins.txt -P pass.txt 192.168.1.110 ssh
```

Тут при выключеном fail2ban удалось брутфорсом подобрать пароль, только в сурикате отобразилось что идет атака. Привключенном fail2ban были заблокированы попытки подбора пароля, ну и так же сработало обнаружение атаки сурикатой.

![Задание 2.1](https://github.com/tprvx/Netology/blob/DefenceNet/img/2.1.png?raw=true)
![Задание 2.2](https://github.com/tprvx/Netology/blob/DefenceNet/img/2.2.png?raw=true)
![Задание 2.3](https://github.com/tprvx/Netology/blob/DefenceNet/img/2.3.png?raw=true)
![Задание 2.3](https://github.com/tprvx/Netology/blob/DefenceNet/img/2.4.png?raw=true)