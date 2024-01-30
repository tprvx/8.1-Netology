# Database - Petr

### Задание 1

```sql
1 таблица
Сотрудники {
	id сотруюника, SERIAL, PRIMARY KEY,
	ФИО сотрудника, character varying(100),
	id должности, FOREIGN KEY, integer,
	id оклада, FOREIGN KEY, integer,
	Дата найма, integer,
}

2 таблица 
Структурные подразделения{
	id cтруктурного подразделения SERIAL, PRIMARY KEY,
	Название, character varying(100),
	id типа подразделения, FOREIGN KEY, integer,
	id филиала, FOREIGN KEY, integer,
}

3 таблица
Типы подразделений {
	id типа подразделения, SERIAL, PRIMARY KEY,
	Тип подразделения character varying(30)
}

4 таблица
Должности {
	id должности, SERIAL, PRIMARY KEY,
	Должность, character varying(100),
	id структурного подразделения, FOREIGN KEY, integer
}

5 таблица
Филиалы {
	id филиала, SERIAL, PRIMARY KEY,
	Область, character varying(100),
	Город, character varying(100),
	Адрес, character varying(100)
}

6 таблица
Проекты {
	id проекта, SERIAL, PRIMARY KEY,
	Название проета, character varying(100),
	id назначенного сотрудника, FOREIGN KEY, integer
}

7 таблица
Оклад {
	id оклада, SERIAL, PRIMARY KEY,
	id сотрудника FOREIGN KEY, integer,
	Оклад, Decimal(10, 2)
}
```
