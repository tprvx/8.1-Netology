# Prometheus - Часть 1 - Petr

### Install Prometheus

```bash
useradd --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz
tar xvfz prometheus-2.46.0.linux-amd64.tar.gz
mkdir /etc/prometheus /var/lib/prometheus
cp ./prometheus promtool /usr/local/bin
cp -R ./console_libraries /etc/prometheus
cp -R ./consoles/ /etc/prometheus
cp ./prometheus.yml /etc/prometheus
ls -l /etc/prometheus/
chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
chown -R prometheus:prometheus /var/lib/prometheus
chown prometheus:prometheus /usr/local/bin/prometheus /usr/local/bin/promtool

# отключаем gitlab-prometheus, освобождаем сокет 0.0.0.0:9090
systemctl disable gitlab-runsvdir.service
systemctl stop gitlab-runsvdir.service

/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries

GET http://192.168.1.152:9090

# прерываем prometeus, создаем сервис prometheus
nano /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus Service
After=network.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
ExecReload=/bin/kill -HUP $MAINPID Restart=on-failure
[Install]
WantedBy=multi-user.target

systemctl enable prometheus.service
systemctl start prometheus.service
systemctl status prometheus.service

tail -n 100 /var/log/syslog
chown -R prometheus:prometheus /var/lib/prometheus

systemctl start prometheus.service

```

### Install Node-Exporter

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
tar xfvz node_exporter-1.6.1.linux-amd64.tar.gz
cd node_exporter-1.6.1.linux-amd64
./node_exporter
GET http://192.168.1.152:9100

mkdir /etc/prometheus/node-exporter
cp ./node_exporter /etc/prometheus/node-exporter

nano /etc/systemd/system/node-exporter.service

[Unit] 
Description=Node Exporter
After=network.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/etc/prometheus/node-exporter/node_exporter
[Install]
WantedBy=multi-user.target

systemctl enable node-exporter.service
systemctl start node-exporter.service
systemctl status node-exporter.service

nano /etc/prometheus/prometheus.yml

static-configs:
    - targets: ["localhost:9090", "localhost:9100"]

systemctl restart prometheus.service
systemctl status prometheus.service

GET http://192.168.1.152:9090/targets?search=
```

### Install Grafana

```bash
GET https://grafana.com/grafana/download?edition=oss&pg=get&plcmt=selfmanaged-box1-cta1&platform=linux
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_10.1.1_amd64.deb
sudo dpkg -i grafana_10.1.1_amd64.deb

systemctl enable grafana-server.service
systemctl start grafana-server.service
systemctl status grafana-server.service

GET http://192.168.1.152:3000

admin
admin
```

### Add Dashboard to Grafana

```
Configuration > Data Sources 
Add data sourcе
Prometheus
http://localhost:9090

https://grafana.com/grafana/dashboards/1860-node-exporter-full/
Download *.json
Import Dashboard via *.json
```

### Задание 1*

![Задание 1](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/1.png?raw=true)

### Задание 2*

![Задание 2](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/2.png?raw=true)

### Задание 3*

![Задание 3](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/3.1.png?raw=true)

![Задание 3](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/3.2.png?raw=true)

### Задание 4*

![Задание 4](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/4.png?raw=true)

### Задание 5*

![Задание 5](https://github.com/tprvx/Netology-Homeworks/blob/Prometheus-1/img_homework/5.png?raw=true)
