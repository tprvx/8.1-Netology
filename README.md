# INDEXES - Petr

### Задание 1

```sql
SELECT sum(index_length)/sum(data_length)* 100  Отношение
FROM INFORMATION_SCHEMA.TABLES
WHERE table_name IN (
	"actor",
    "address",
    "category",
    "city",
    "country",
    "customer",
    "film",
    "film_actor",
    "film_category",
    "film_text",
    "inventory",
    "language",
    "payment",
    "rental",
    "staff",
    "store"
);
```

![Задание 1.1](https://github.com/tprvx/Netology/blob/INDEXES/img/1.png?raw=true)


### Задание 2

До создания индекса sakila.payment(payment_date):

```sql
-> Table scan on <temporary>  (actual time=8.04..8.08 rows=391 loops=1)
     -> Aggregate using temporary table  (actual time=8.04..8.04 rows=391 loops=1)
         -> Nested loop inner join  (cost=3609 rows=1855) (actual time=0.0623..7.5 rows=642 loops=1)
 ...
```

После создания индекса sakila.payment(payment_date):

```sql
-> Table scan on <temporary>  (actual time=5.04..5.09 rows=391 loops=1)
     -> Aggregate using temporary table  (actual time=5.04..5.04 rows=391 loops=1)
         -> Nested loop inner join  (cost=812 rows=661) (actual time=0.0466..4.42 rows=642 loops=1)
  ...
```

Видно, что после создания индекса идет проход не по всем строкам, а только по части строк, это улучшает скорость запроса

```sql
CREATE INDEX idx_payment_date ON sakila.payment(payment_date);

EXPLAIN ANALYZE SELECT DISTINCT concat(c.last_name, ' ', c.first_name) Покупатель, sum(p.amount) Сумма
FROM sakila.payment p
JOIN sakila.customer c ON c.customer_id=p.customer_id
JOIN sakila.rental r ON p.payment_date=r.rental_date
JOIN sakila.inventory i ON i.inventory_id = r.inventory_id
WHERE p.payment_date >= '2005-07-30' and p.payment_date < DATE_ADD('2005-07-30', INTERVAL 1 DAY)
GROUP BY Покупатель;
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/INDEXES/img/2.1.png?raw=true)

![Задание 2.1](https://github.com/tprvx/Netology/blob/INDEXES/img/2.2.png?raw=true)
