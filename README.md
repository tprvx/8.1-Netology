# SQL1 - Petr

### Задание 1

```sql
SELECT DISTINCT district FROM sakila.address 
WHERE district LIKE 'K%a'
	and POSITION(' ' IN district)=0 
ORDER BY district ASC;
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/SQL1/img/1.png?raw=true)


### Задание 2

```sql
SELECT * FROM sakila.payment
WHERE cast(payment_date AS DATE) >= cast('2005-06-15' AS DATE)
	and cast(payment_date AS DATE) <= cast('2005-06-18' AS DATE)
    and amount > 10
ORDER BY payment_date ASC, customer_id DESC;
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/SQL1/img/2.png?raw=true)


### Задание 3

```sql
SELECT * FROM sakila.rental ORDER BY rental_id DESC LIMIT 5;
```

![Задание 3.1](https://github.com/tprvx/Netology/blob/SQL1/img/3.png?raw=true)


### Задание 4

```sql
SELECT customer_id, replace(lower(first_name), 'll', 'pp') as first_name, lower(last_name)
FROM sakila.customer
WHERE first_name IN ('Kelly', 'Willie');
```

![Задание 4.1](https://github.com/tprvx/Netology/blob/SQL1/img/4.png?raw=true)
