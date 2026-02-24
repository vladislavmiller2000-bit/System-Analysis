# Анализ продаж ресторана — SQL-проект

## О проекте

Аналитический SQL-проект: исследование данных о продажах ресторана. 50 заказов, 20 позиций меню, период январь–март 2026.

Весь проект — это **один SQL-файл**, который создаёт базу данных, заливает тестовые данные и выполняет 20 аналитических запросов.

## Что сделано

- Спроектировал реляционную схему из 3 таблиц (заказы, меню, позиции заказа)
- Написал 20 аналитических запросов с комментариями
- Каждый запрос отвечает на конкретный бизнес-вопрос

## Бизнес-вопросы

| # | Вопрос | SQL-техники |
|---|--------|-------------|
| 1–3 | Выручка: общая, по месяцам, по дням недели | `SUM`, `AVG`, `GROUP BY`, `LAG` |
| 4–5 | Выручка по времени суток, пиковые часы | `CASE`, `substr`, `GROUP BY` |
| 6–8 | Топ-блюда по продажам, выручке, марже | `JOIN`, `ORDER BY`, `LIMIT` |
| 9–10 | ABC-анализ меню, категории | `CTE`, оконные функции, `CASE` |
| 11–13 | Средний чек, размер заказа, способы оплаты | `AVG`, `COUNT`, `GROUP BY` |
| 14–16 | Типы клиентов, тренды, прибыльность | `Window functions`, `RANK` |
| 17–20 | Помесячный пивот, рейтинги, кумулятивные итоги | `CASE`, `SUM OVER`, `ROW_NUMBER` |

## Схема базы данных

```
menu_items (item_id, item_name, category, price, cost)
    ↑
order_items (order_item_id, order_id, item_id, quantity, item_price)
    ↓
orders (order_id, order_date, order_time, total_amount, payment_method, customer_type)
```

## Как запустить

### Вариант 1: Скрипт (рекомендуется)
```bash
cd SQL_Project
./run_analysis.sh
```

### Вариант 2: Вручную через SQLite
```bash
cd SQL_Project
sqlite3 restaurant.db < restaurant_analysis.sql
sqlite3 restaurant.db
```
Далее в интерактивном режиме:
```sql
.tables                           -- посмотреть таблицы
.schema menu_items                -- структура таблицы
SELECT * FROM menu_items LIMIT 5; -- любой запрос
.quit                             -- выход
```

### Вариант 3: Через GUI
Открыть `restaurant_analysis.sql` в **DBeaver**, **pgAdmin**, **DataGrip** или VS Code с расширением SQLite — файл создаст всё сам.

### Вариант 4: Показать на ноутбуке
1. Установить SQLite: `brew install sqlite` (macOS) или `sudo apt install sqlite3` (Linux)
2. Скопировать папку `SQL_Project`
3. Запустить `./run_analysis.sh` — база создаётся, данные загружаются, запросы выполняются
4. Открыть `sqlite3 restaurant.db` для интерактивной демонстрации

## SQL-навыки в проекте

`DDL (CREATE TABLE)` `DML (INSERT, SELECT)` `JOIN (INNER, LEFT)` `GROUP BY / HAVING` `Подзапросы` `CTE (WITH)` `Оконные функции (ROW_NUMBER, RANK, LAG)` `CASE-выражения` `Агрегатные функции (SUM, AVG, COUNT, MIN, MAX)` `Работа с датами`

## Файлы

| Файл | Описание |
|------|----------|
| [restaurant_analysis.sql](restaurant_analysis.sql) | Основной файл — схема + данные + 20 запросов |
| [run_analysis.sh](run_analysis.sh) | Скрипт для быстрого запуска |
