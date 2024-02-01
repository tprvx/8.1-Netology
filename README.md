# DDL-DML - Petr

### Задание 1

##### Пункт 1-2

![Задание 1.1](https://github.com/tprvx/Netology/blob/DDL-DML/img/1-2.png?raw=true)


##### Пункт 3

```sql
SELECT User, Host FROM mysql.User;
```

![Задание 1.3](https://github.com/tprvx/Netology/blob/DDL-DML/img/3.png?raw=true)


##### Пункт 4

```sql
GRANT ALL PRIVILEGES ON *.* to 'sys_temp'@'localhost';
```

![Задание 1.4](https://github.com/tprvx/Netology/blob/DDL-DML/img/4.png?raw=true)


##### Пункт 5

```sql
SELECT * FROM mysql.user WHERE User='sys_temp';
```
или
```sql
SHOW GRANTS FOR 'sys_temp'@'localhost';
```

![Задание 1.5](https://github.com/tprvx/Netology/blob/DDL-DML/img/5.png?raw=true)


##### Пункт 6

в MySQL Shell:
\connect sys_temp@localhost:3306

![Задание 1.6](https://github.com/tprvx/Netology/blob/DDL-DML/img/6.png?raw=true)


##### Пункт 7

```sql
ALTER USER 'sys_temp'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```
![Задание 1.7](https://github.com/tprvx/Netology/blob/DDL-DML/img/7.png?raw=true)


##### Пункт 8

![Задание 1.8](https://github.com/tprvx/Netology/blob/DDL-DML/img/8.png?raw=true)


### Задание 2

```js
Название таблицы | Название первичного ключа
--------------------------------------------
addres           | address_id
country	         | country_id
store	         | store_id
film_category	 | film_id
staff	         | staff_id
payment	         | payment_id
film	         | film_id
city	         | city_id
category	     | category_id
rental	         | rental_id
film_text	     | film_id
customer	     | customer_id
film_actor	     | film_id
actor	         | actor_id
inventory	     | inventory_id
language	     | language_id
```
