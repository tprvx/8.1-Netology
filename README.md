# RabbitMQ - Petr

### Задание 1

```bash
chmod +x cluster-entrypoint.sh
docker-compose up
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/RabbitMQ/img/1.1.png?raw=true)

### Задание 2

```bash
pip install pika
python3 producer.py
python3 consumer.py
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/RabbitMQ/img/2.1.png?raw=true)
![Задание 2.2](https://github.com/tprvx/Netology/blob/RabbitMQ/img/2.2.png?raw=true)

### Задание 3

```bash
echo "172.22.0.2 rmq1" >> /etc/hosts
echo "172.22.0.3 rmq2" >> /etc/hosts
echo "172.22.0.4 rmq3" >> /etc/hosts

docker exec -it aa838b3f285c /bin/bash
rabbitmqctl set_policy ha-all "" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
rabbitmqctl cluster_status
docker exec -it 89344e81a3c3 /bin/bash
rabbitmqctl set_policy ha-all "" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
rabbitmqctl cluster_status
docker exec -it baf09e281f2f /bin/bash
rabbitmqctl set_policy ha-all "" '{"ha-mode":"all","ha-sync-mode":"automatic"}'
rabbitmqctl cluster_status

python3 producer.py

docker exec -it aa838b3f285c /bin/bash
rabbitmqadmin --username=user --password=pass get queue='hello'
docker exec -it 89344e81a3c3 /bin/bash
rabbitmqadmin --username=user --password=pass get queue='hello'
docker exec -it baf09e281f2f /bin/bash
rabbitmqadmin --username=user --password=pass get queue='hello'

docker stop aa838b3f285c

python3 consumer.py

docker-compose down
```

![Задание 3.1](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.1.png?raw=true)
![Задание 3.2](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.2.png?raw=true)
![Задание 3.3](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.3.png?raw=true)
![Задание 3.4](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.4.png?raw=true)
![Задание 3.5](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.5.png?raw=true)
![Задание 3.6](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.6.png?raw=true)
![Задание 3.7](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.7.png?raw=true)
![Задание 3.8](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.8.png?raw=true)
![Задание 3.9](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.9.png?raw=true)
![Задание 3.10](https://github.com/tprvx/Netology/blob/RabbitMQ/img/3.10.png?raw=true)
