# SQL2 - Petr

### Задание 1

```sql
SELECT staff.first_name 'Имя', staff.last_name 'Фамилия', city.city 'Город', 
	(SELECT count(*) FROM sakila.customer GROUP BY store_id HAVING count(*) > 300) 'Кол-во'
FROM sakila.staff staff
JOIN sakila.staff store ON store.store_id = staff.store_id
JOIN sakila.address address ON store.address_id = address.address_id
JOIN sakila.city city ON city.city_id = address.city_id
WHERE staff.store_id=(SELECT store_id FROM sakila.customer GROUP BY store_id HAVING count(*) > 300);
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/SQL2/img/1.png?raw=true)


### Задание 2

```sql
SELECT count(*) FROM sakila.film WHERE length > (SELECT avg(length) FROM sakila.film);
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/SQL2/img/2.png?raw=true)


### Задание 3

```sql
SELECT MONTH(CAST(payment_date AS DATE)) Месяц, sum(amount) Сумма, count(*) Аренд
FROM sakila.payment
GROUP BY Месяц
ORDER BY Сумма DESC LIMIT 1;
```

![Задание 3.1](https://github.com/tprvx/Netology/blob/SQL2/img/3.png?raw=true)
