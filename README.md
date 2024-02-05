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

Запрос переделал, он был похож больше на диверсию, за 5.5 секунд выполнялся, переписанный запрос за 0.015 секунд выполняется, думаю дальше оптимизировать нет смысла

```sql
SELECT DISTINCT concat(c.last_name, ' ', c.first_name) Покупатель, sum(p.amount) Сумма
FROM sakila.payment p
JOIN sakila.customer c ON c.customer_id=p.customer_id
WHERE DATE(p.payment_date)='2005-07-30'
GROUP BY Покупатель;
```

![Задание 2.1](https://github.com/tprvx/Netology/blob/INDEXES/img/2.png?raw=true)
