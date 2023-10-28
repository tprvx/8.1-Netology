# HSRP и Keepalived - Petr

### Задание 1 - HSRP

#### Настройка отслеживания интерфейсов и preempt

Router1:
```
enable
config t
int gig0/1
standby 1 priority 95
standby 1 preempt
standby 1 track GigabitEthernet0/0
```

Router2:
```
enable
config t
int gig0/1
standby 1 track GigabitEthernet0/0
```

![Задание 1.1](https://github.com/tprvx/Netology-Homeworks/blob/Keepalived_HSRP/img/1.1.png?raw=true)


### Задание 2

На двух серверах SERVER_1 и SERVER_2:
```bash
sudo apt install -y keepalived

ip -4 a

sudo nano /etc/keepalived/keepalived.conf

# обязательно, это security требование для запуска
sudo chmod -x /etc/keepalived/keepalived.conf
sudo chmod 744 /etc/keepalived/monitor.sh

sudo systemctl start keepalived.service
sudo systemctl status keepalived.service

# должен появится плавающий ip на MASTER хосте
ip -4 a

sudo apt install nginx

sudo systemctl stop apache2.service
sudo systemctl status apache2.service
sudo systemctl start nginx.service
sudo systemctl status nginx.service

sudo systemctl disable apache2.servise
sudo systemctl enable nginx.servise

# прописать чтобы выводился реальный ip
sudo nano /var/www/html/index.html

# проверка сработки триггрера на отключение nginx
sudo systemctl stop nginx
sudo apt install curl
curl 192.168.1.15

# проверка сработки триггера на закрытие 80 порта
sudo iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j DROP
reboot
sudo iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT

# проверка сработки триггера на переименование файла
sudo mv /root/index.html /root/index1.html
sudo mv /root/index1.html /root/index.html
```

![Задание 2.1](https://github.com/tprvx/Netology-Homeworks/blob/Keepalived_HSRP/img/2.1.png?raw=true)

![Задание 2.2](https://github.com/tprvx/Netology-Homeworks/blob/Keepalived_HSRP/img/2.2.png?raw=true)

![Задание 2.3](https://github.com/tprvx/Netology-Homeworks/blob/Keepalived_HSRP/img/2.3.png?raw=true)

![Задание 2.4](https://github.com/tprvx/Netology-Homeworks/blob/Keepalived_HSRP/img/2.4.png?raw=true)
