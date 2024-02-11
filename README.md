# Managed Databases - PostgreSQL Cluster YC - Petr


### Задание 1

Подключаемся к кластеру

```Bash
mkdir -p ~/.postgresql && \
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
    --output-document ~/.postgresql/root.crt && \
chmod 0600 ~/.postgresql/root.crt

sudo apt update && sudo apt install --yes postgresql-client

psql "host=rc1a-u26i64mt2lroulej.mdb.yandexcloud.net,rc1b-ru95wckhm1433bm8.mdb.yandexcloud.net \
    port=6432 \
    sslmode=verify-full \
    dbname=Chocolate \
    user=chocolate \
    target_session_attrs=read-write"

SELECT version();
```

Проверяем что подключились к мастеру

```Bash
select case when pg_is_in_recovery() then 'REPLICA' else 'MASTER' end;
```

Количество подключенных реплик

```Bash
select count(*) from pg_stat_replication;
```

Создаем на мастере таблицу и заполняем ее

```Bash
CREATE TABLE test_table(text varchar);
insert into test_table values('Строка 1');
insert into test_table values('Строка 2');
insert into test_table values('Строка 22334');
\q
```

Подключаемся на реплику и проверяем что данные реплицировались

```Bash
psql "host=rc1a-u26i64mt2lroulej.mdb.yandexcloud.net,rc1b-ru95wckhm1433bm8.mdb.yandexcloud.net \
    port=6432 \
    sslmode=verify-full \
    dbname=Chocolate \
    user=chocolate \
    host=rc1b-ru95wckhm1433bm8.mdb.yandexcloud.net"

# проверка что подключились к реплике
select case when pg_is_in_recovery() then 'REPLICA' else 'MASTER' end;

# состояние репликации
select status from pg_stat_wal_receiver;

# проверяем что механизм репликации данных работает между зонами доступности облака
select * from test_table;
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/MDB/img/1.png?raw=true)
![Задание 1.2](https://github.com/tprvx/Netology/blob/MDB/img/2.png?raw=true)
![Задание 1.3](https://github.com/tprvx/Netology/blob/MDB/img/3.png?raw=true)
![Задание 1.4](https://github.com/tprvx/Netology/blob/MDB/img/4.png?raw=true)
![Задание 1.5](https://github.com/tprvx/Netology/blob/MDB/img/5.png?raw=true)
![Задание 1.6](https://github.com/tprvx/Netology/blob/MDB/img/6.png?raw=true)
![Задание 1.7](https://github.com/tprvx/Netology/blob/MDB/img/7.png?raw=true)
![Задание 1.8](https://github.com/tprvx/Netology/blob/MDB/img/8.png?raw=true)