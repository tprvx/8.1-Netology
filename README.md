# Prometheus - 2 - Petr

### Install Alertmanager

```bash
wget https://github.com/prometheus/alertmanager/releases/download/v0.26.0/alertmanager-0.26.0.linux-amd64.tar.gz
tar xvfz alertmanager-0.26.0.linux-amd64.tar.gz
cp ./alertmanager-0.26.0.linux-amd64/alertmanager /usr/local/bin
cp ./alertmanager-0.26.0.linux-amd64/amtool /usr/local/bin/
cp ./alertmanager-0.26.0.linux-amd64/alertmanager.yml /etc/prometheus
chown prometheus:prometheus /etc/prometheus/alertmanager.yml

nano /etc/systemd/system/prometeus-alertmanager.service

[Unit]
Description=Alertmanager Service
After=network.target
[Service]
EnvironmentFile=-/etc/default/alertmanager
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/prometheus/alertmanager.yml $ARGS
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
[Install]
WantedBy=multi-user.target

/usr/local/bin/alertmanager --config.file=/etc/prometheus/alertmanager.yml
--storage.path=/var/lib/prometheus/alertmanager
GET 192.168.1.152:9093

systemctl enable prometeus-alertmanager.service
systemctl start prometeus-alertmanager.service
systemctl status prometeus-alertmanager.service
```

### Tune Alertmanager & Prometheus

```Bash
nano /etc/prometheus/prometheus.yml

# Alertmanager configuration
alerting:
 alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093

systemctl restart prometheus
systemctl status prometheus
```

### Create alert rule

```yml
nano /etc/prometheus/alert-1.yml

groups:
  - name: alert-1
    rules:
      - alert: InstanceDown
        expr: up == 0 # Переменная up
        for: 1m # Если up=0 больше 1m то срабатывает alert
        labels:
          severity: critical # Критичность события
        annotations: # Описание
          summary: "Instance {{ $labels.instance }} down" # Краткое
          description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.' # Полное
```
```Bash
cd /etc/prometheus/
nano ./prometheus.yml
```
```yml
rule_files:
  - "alert-1.yml"
```
```Bash
systemctl restart prometheus
systemctl status prometheus
nano ./alertmanager.yml
```
```yml
global:
route:
  group_by: ['alertname'] # Параметр группировки оповещений — по имени
  group_wait: 30s # Сколько ждать восстановления, перед тем как отправить первое оповещение
  group_interval: 10m # Сколько ждать, перед тем как дослать оповещение о новых сработках по текущему алерту
  repeat_interval: 60m # Сколько ждать, перед тем как отправить повторное оповещение
  receiver: 'email' # Способ, которым будет доставляться текущее оповещение
receivers: # Настройка способов оповещения
- name: 'email'
  email_configs:
  - to: 'yourmailto@todomain.com'
    from: 'yourmailfrom@fromdomain.com'
    smarthost: 'mailserver:25'
    auth_username: 'user'
    auth_identity: 'user'
    auth_password: 'paS$w0rd'
```
```Bash
systemctl restart prometeus-alertmanager
systemctl status prometeus-alertmanager

GET http://192.168.1.152:9093
GET http://192.168.1.152:9090/targets?search=

systemctl stop node-exporter.service
systemctl status node-exporter.service

```

### Monitoring Docker in Prometheus

```Bash
# after install Docker
systemctl enable docker
systemctl status docker

# тут можем менять стандартный конфиг докера
nano /etc/docker/daemon.json

{
    "metrics-addr": "0.0.0.0:9323",
    "experimental": true
}

systemctl restart docker
systemctl status docker

# смотрим метрики экспортера докера
GET http://192.168.1.152:9323/metrics
# проверка доступа с локалхоста
curl 127.0.0.1:9323/metrics

nano /etc/prometheus/prometheus.yml

static_configs:
    - targets: ["localhost:9090", "localhost:9100", "localhost:9323"]

systemctl restart prometheus
systemctl status prometheus

GET http://192.168.1.152:9090/targets?search=
```

### Задание 1*

![Задание 1.1](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/1.1.png?raw=true)

![Задание 1.2](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/1.2.png?raw=true)

### Задание 2*

![Задание 2.1](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/2.1.png?raw=true)

![Задание 2.2](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/2.2.png?raw=true)

### Задание 3*

![Задание 3.1](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/3.1.png?raw=true)

![Задание 3.2](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/3.2.png?raw=true)

### Задание 4*

![Задание 4](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-2/img_homework/4.png?raw=true)
