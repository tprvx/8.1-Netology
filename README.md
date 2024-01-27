# ELK - Petr

### Задание 1

```bash
sudo dnf install -y nginx filefeat curl
# docker-compose должен быть уже установлен

# конфигурируем и запускаем веб-сервер
sudo systemctl start nginx
sudo systemctl status nginx
sudo systemctl enable nginx

sudo ./nginx.conf >> /etc/nginx/nginx.conf
sudo systemctl reload nginx

# запускаем ELK в контейнерах
sudo docker-compose up

# проверка работосопсобности Elasticsearch
curl -X GET 'localhost:9200/_cluster/health?pretty'
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/ELK/img/1.1.png?raw=true)

### Задание 2

```bash
# заходим в Kibana и проверяем видимость Elasticsearch
http://localhost:5601/app/dev_tools#/console
GET /_cluster/health?pretty
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/ELK/img/2.1.png?raw=true)

### Задание 3

```bash
# сначала создаем трафик на веб сервер
# потом идем в Kibana и ищем индекс
http://localhost:5601/app/dev_tools#/console
GET nginx-access.log-2024.01.26/_search
```

![Задание 3.1](https://github.com/tprvx/Netology/blob/ELK/img/3.1.jpg?raw=true)
![Задание 3.2](https://github.com/tprvx/Netology/blob/ELK/img/3.2.jpg?raw=true)
![Задание 3.3](https://github.com/tprvx/Netology/blob/ELK/img/3.3.jpg?raw=true)

### Задание 4

```bash
# закомментиурем logstash сервис в ELK сначала, чтобы оттуда логи не шли

sudo docker-compose down
sudo docker-compose up

# конфигурируем и запускаем Filebeat
sudo systemctl start filefeat
sudo systemctl status filefeat
sudo systemctl enable filefeat

sudo ./filebeat/filebeat.yml >> /etc/filebeat/filebeat.yml
sudo systemctl restert filefeat

# потом идем в Kibana и ищем индекс
http://localhost:5601/app/dev_tools#/console
GET filebeat-2024.01.27/_search
```

![Задание 4.1](https://github.com/tprvx/Netology/blob/ELK/img/4.1.jpg?raw=true)
![Задание 4.2](https://github.com/tprvx/Netology/blob/ELK/img/4.2.jpg?raw=true)
![Задание 4.3](https://github.com/tprvx/Netology/blob/ELK/img/4.3.jpg?raw=true)
