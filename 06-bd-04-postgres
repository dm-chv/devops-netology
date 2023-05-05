### Задание 1
<i>Найдите и приведите управляющие команды для:"
<code>
#вывода списка БД,
\l
#подключения к БД,
\c name_db
#вывода списка таблиц,
\dt
#вывода описания содержимого таблиц,
\dS+
\dtS+
#выхода из psql.
\q
</code>

### Задание 2
<i>Используя psql, создайте БД test_database.</i>
<i><b>Приведите в ответе</b> команду, которую вы использовали для вычисления, и полученный результат.</i>


<code>
#ANALYZE
est_database=# ANALYZE VERBOSE public.orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE

#Поиск наибольшего среднего значения
SELECT MAX(avg_width) AS "MAX_AVG" FROM pg_stats WHERE tablename='orders';
</code>

### Задание 3
<i>провести разбиение таблицы на 2: шардировать на orders_1 - price>499 и orders_2 - price<=499.</i>
<code>
test_database=# CREATE TABLE orders_1 AS (SELECT * FROM orders WHERE price>499);
SELECT 3
test_database=# CREATE TABLE orders_2 AS (SELECT * FROM orders WHERE price<=499);
SELECT 5
</code>
<i>Можно ли было изначально исключить ручное разбиение при проектировании таблицы orders?</i>
<code>
CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
)PARTITION BY RANGE (price);

CREATE TABLE public.orders_low PARTITION OF public.orders
    FOR VALUES FROM ('0') TO ('499');

CREATE TABLE public.orders_high PARTITION OF public.orders
    FOR VALUES FROM ('499') TO ('999999');
</code>

### Задание 4
<i>Используя утилиту pg_dump, создайте бекап БД test_database.<\i>
<code>
pg_dump -U postgres -d test_database > /backup/test_database_dump.sql
<\code>
<i>Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца title для таблиц test_database?</i>
* можно для столбца тайтл использовать индекс "UNIQUE"
