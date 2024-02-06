# Replication - Petr

### Задание 1

 - В репликации master-slave: из master-ноды slave-нода выкачивает изменения, на slave-ноде изменения не реплицируются  в master-ноду 
 - В репликации master-master: обе ноды равнозначны, изменения в одной записываются в другую и наоборот


### Задание 2

```bash
docker-compose up --remove-orphans
docker ps

# master
docker exec -it dee5f2cf3742 /bin/bash
mysql -u root -p
show master status\G
CREATE USER 'repl'@'%' IDENTIFIED WITH mysql_native_password BY 'slaverepl';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
SHOW GRANTS FOR 'repl'@'%';
SHOW MASTER STATUS\G

# slave
docker exec -it 16413f5bb9a8 /bin/bash
mysql -u root -p
CHANGE MASTER TO
	MASTER_HOST='mysql-master',
	MASTER_USER='repl',
	MASTER_PASSWORD='slaverepl',
	MASTER_LOG_FILE='mysql-bin.000003',
	MASTER_LOG_POS=1103;
START SLAVE;
SHOW SLAVE STATUS\G

# master
show databases;
create database test1;
show databases;
SHOW MASTER STATUS\G

# slave
SHOW SLAVE STATUS\G
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/Replication/img/2.1.jpg?raw=true)
![Задание 2.2](https://github.com/tprvx/Netology/blob/Replication/img/2.2.jpg?raw=true)
![Задание 2.3](https://github.com/tprvx/Netology/blob/Replication/img/2.3.jpg?raw=true)
