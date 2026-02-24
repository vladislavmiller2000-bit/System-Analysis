# Пошаговая нормализация модели

## ЭТАП 0: ИСХОДНАЯ МОДЕЛЬ (Crow's Foot)

### Диаграмма

```
                    ZAKAS
                   ┌──────────┐
                   │ PK id    │
                   │ data     │
                   │ status   │
                   │ sposob   │
                   └──────────┘
                      │
            ┌─────────┼─────────┐
            │ 1:N     │ 1:1     │
            │         │         │
       ┌────▼──────┐  │    ┌────▼─────────────┐
       │ TOVAR_V_Z │  │    │ SVEDENIYA_DOST   │
       ├───────────┤  │    ├──────────────────┤
       │ PK,FK id_z   │    │ PK,FK id_z       │
       │ PK art    │  │    │ sposob           │
       │ kol       │  │    │ data             │
       │ tsena     │  │    │ strana ⚠️        │
       │ skidka    │  │    │ gorod  ⚠️        │
       └───────────┘  │    │ ulitsa ⚠️        │
                      │    │ nomer_d ⚠️       │
                      │    │ kvartira ⚠️      │
                      │    │ pochta_i ⚠️      │
                      │    └──────────────────┘
                      │
                ⚠️ НАРУШЕНИЕ 3НФ В АДРЕСЕ
```

**Статус**: 1НФ ✅, 2НФ ✅, 3НФ ⚠️ (частичное нарушение с адресом)

---

## ЭТАП 1: ПЕРВАЯ НОРМАЛЬНАЯ ФОРМА (1НФ)

### Изменения: **НИКАКИХ** (модель уже в 1НФ)

Модель уже содержит только атомарные значения, нет повторяющихся групп.

### Диаграмма: Идентична исходной

**Описание изменений**:
> Модель уже находится в 1НФ. Все значения в колонках атомарны (неделимы). Нет повторяющихся групп атрибутов. Каждое поле содержит одно значение. Таблицы не содержат списков или вложенных структур.

---

## ЭТАП 2: ВТОРАЯ НОРМАЛЬНАЯ ФОРМА (2НФ)

### Изменения: **ВЫДЕЛЯЕМ ТАБЛИЦУ ТОВАР**

**Проблема**: В таблице ТОВАР_В_ЗАКАЗЕ есть частичные зависимости:
- PK = (nomer_zakaza, artikul_tovara)
- **`tsena_za_edinitsu` зависит ТОЛЬКО от `artikul_tovara`** — частичная зависимость! ❌
- **`razmer_skidki` зависит ТОЛЬКО от `artikul_tovara`** — частичная зависимость! ❌
- Только `kolichestvo` зависит от полного ключа ✅

**Решение**: Создать отдельную таблицу ТОВАР, где цена и скидка зависят от артикула

### Новая структура

```
                    ZAKAS
                   ┌──────────┐
                   │ PK id    │
                   │ data     │
                   │ vremya   │
                   │ status   │
                   │ sposob   │
                   └──────────┘
                      │
            ┌─────────┼─────────┐
            │ 1:N     │ 1:1     │
            │         │         │
       ┌────▼──────┐  │    ┌────▼──────────────┐
       │TOVAR_V_Z  │  │    │ SVEDENIYA_DOST    │
       ├───────────┤  │    ├───────────────────┤
       │PK,FK id_z    │    │ PK,FK id_z        │
       │PK art    │  │    │ sposob            │
       │kol       │  │    │ data              │
       └───────────┘  │    │ strana ⚠️        │
            │         │    │ gorod  ⚠️        │
            │ N:1     │    │ ulitsa ⚠️        │
            │         │    │ nomer_d ⚠️       │
       ┌────▼──────┐  │    │ kvartira ⚠️      │
       │ ТОВАР      │  │    │ pochta_i ⚠️      │
       │(новая)    │  │    └──────────────────┘
       ├───────────┤  │
       │PK art    │  │
       │tsena ✅  │  │
       │skidka ✅ │  │
       └───────────┘  │
                      │
```

### Спецификация таблицы ТОВАР

```
Таблица: ТОВАР (новая)
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ artikul      │ VARCHAR(50)  │ PK              │ Артикул      │
│ tsena        │ DECIMAL(10,2)│ -               │ Цена         │
│ razmer_skidki│ DECIMAL(5,2) │ -               │ Скидка       │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
CREATE TABLE TOVAR (
    artikul VARCHAR(50) PRIMARY KEY,
    tsena_za_edinitsu DECIMAL(10,2) NOT NULL,
    razmer_skidki DECIMAL(5,2) DEFAULT 0
);
```

### Спецификация исправленной таблицы TOVAR_V_ZAKAZE

```
Таблица: TOVAR_V_ZAKAZE (исправленная)
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ nomer_zakaza │ INT          │ PK, FK          │ На ZAKAS      │
│ artikul      │ VARCHAR(50)  │ PK, FK          │ На TOVAR      │
│ kolichestvo  │ INT          │ -               │ Количество    │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
CREATE TABLE TOVAR_V_ZAKAZE (
    nomer_zakaza INT NOT NULL,
    artikul VARCHAR(50) NOT NULL,
    kolichestvo INT NOT NULL,
    PRIMARY KEY (nomer_zakaza, artikul),
    FOREIGN KEY (nomer_zakaza) REFERENCES ZAKAS(nomer_zakaza),
    FOREIGN KEY (artikul) REFERENCES TOVAR(artikul)
);
```

**Описание изменений**:
> Выделены атрибуты, зависящие только от артикула (tsena_za_edinitsu, razmer_skidki), в отдельную таблицу TOVAR. Это устраняет частичные зависимости в таблице TOVAR_V_ZAKAZE. Теперь каждая таблица имеет только атрибуты, зависящие от ее полного первичного ключа. Модель теперь находится в 2НФ.

---

## ЭТАП 3: ТРЕТЬЯ НОРМАЛЬНАЯ ФОРМА (3НФ)

### Изменения: **ВЫДЕЛЯЕМ ТАБЛИЦУ ADRES + ОБЪЕДИНЯЕМ ДАТУ И ВРЕМЯ**

**Проблема 1**: Компоненты адреса (strana, gorod, ulitsa, pochtovyy_indeks) создают транзитивную зависимость:
- nomer_zakaza → (strana, gorod, ulitsa) → pochtovyy_indeks

**Проблема 2**: Дата и время заказа — одно события, логически связаны:
- nomer_zakaza → data_zakaza и nomer_zakaza → vremya_zakaza (зависят друг от друга)
- Это логическая связь: время без даты бессмысленно

**Решение**: 
1. Создать отдельную таблицу ADRES (для устранения транзитивной зависимости)
2. Объединить data_zakaza и vremya_zakaza в единый TIMESTAMP (для логической целостности)

### Новая структура

```
                    ZAKAS
                   ┌──────────────┐
                   │ PK id        │
                   │ vremya ✅    │
                   │  (TIMESTAMP) │
                   │ status       │
                   │ sposob       │
                   │ summa (пр.)  │
                   │ summa_sk(пр.)│
                   │ FK id_polz   │
                   └──────────────┘
                      │
            ┌─────────┼──────────┐
            │ 1:N     │ 1:1      │
            │         │          │
       ┌────▼──────┐  │   ┌──────▼──────────────┐
       │ TOVAR_V_Z │  │   │ SVEDENIYA_DOST      │
       ├───────────┤  │   ├──────────────────────┤
       │PK,FK id_z    │   │ PK,FK id_z           │
       │ PK art   │  │   │ sposob_dostavki      │
       │ kol      │  │   │ data_dostavki        │
       └───────────┘  │   │ FK id_adresa ✅     │
            │         │   └──────────────────────┘
            │ N:1     │           │
            │         │           │ N:1
       ┌────▼──────┐  │           │
       │ TOVAR      │  │    ┌──────▼──────────┐
       ├───────────┤  │    │ ADRES (новая)   │
       │ PK art   │  │    ├────────────────┤
       │ tsena    │  │    │ PK id_adresa   │
       │ skidka   │  │    │ strana ✅      │
       └───────────┘  │    │ gorod  ✅      │
                      │    │ ulitsa ✅      │
                      │    │ nomer_d ✅     │
                      │    │ kvartira ✅    │
                      │    │ pochta_i ✅    │
                      │    └────────────────┘
```

**Статус**: 1НФ ✅, 2НФ ✅, 3НФ ✅

### Спецификация таблицы ZAKAS (исправленная)

```
Таблица: ZAKAS (исправленная)
┌──────────────┬──────────────┬─────────────────┬──────────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание          │
├──────────────┼──────────────┼─────────────────┼──────────────────┤
│ nomer_zakaza │ INT          │ PK              │ Номер заказа     │
│ vremya_zakaza│ TIMESTAMP    │ -               │ Дата+время (объед)│
│ status       │ VARCHAR(30)  │ -               │ Статус заказа    │
│ sposob_oplaty│ VARCHAR(30)  │ -               │ Способ оплаты    │
│ summa_zakaza │ DECIMAL(12,2)│ - (производная) │ Сумма (вычис.)   │
│ summa_skidok │ DECIMAL(12,2)│ - (производная) │ Скидки (вычис.)  │
│ id_polzovate │ INT          │ FK              │ На таблицу USERS  │
└──────────────┴──────────────┴─────────────────┴──────────────────┘

SQL:
CREATE TABLE ZAKAS (
    nomer_zakaza INT PRIMARY KEY AUTO_INCREMENT,
    vremya_zakaza TIMESTAMP NOT NULL,
    status_zakaza VARCHAR(30) DEFAULT 'новый',
    sposob_oplaty VARCHAR(30) NOT NULL,
    id_polzovatelya INT NOT NULL,
    FOREIGN KEY (id_polzovatelya) REFERENCES USERS(id_polzovatelya)
);
```

### Спецификация таблицы TOVAR (новая)

```
Таблица: TOVAR (новая)
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ artikul      │ VARCHAR(50)  │ PK              │ Артикул      │
│ tsena        │ DECIMAL(10,2)│ -               │ Цена         │
│ razmer_skidki│ DECIMAL(5,2) │ -               │ Скидка       │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
CREATE TABLE TOVAR (
    artikul VARCHAR(50) PRIMARY KEY,
    tsena_za_edinitsu DECIMAL(10,2) NOT NULL,
    razmer_skidki DECIMAL(5,2) DEFAULT 0
);
```

### Спецификация исправленной таблицы TOVAR_V_ZAKAZE

```
Таблица: TOVAR_V_ZAKAZE (исправленная)
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ nomer_zakaza │ INT          │ PK, FK          │ На ZAKAS      │
│ artikul      │ VARCHAR(50)  │ PK, FK          │ На TOVAR      │
│ kolichestvo  │ INT          │ -               │ Количество    │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
CREATE TABLE TOVAR_V_ZAKAZE (
    nomer_zakaza INT NOT NULL,
    artikul VARCHAR(50) NOT NULL,
    kolichestvo INT NOT NULL,
    PRIMARY KEY (nomer_zakaza, artikul),
    FOREIGN KEY (nomer_zakaza) REFERENCES ZAKAS(nomer_zakaza),
    FOREIGN KEY (artikul) REFERENCES TOVAR(artikul)
);
```

### Спецификация исправленной таблицы SVEDENIYA_O_DOSTAVKE

```
Таблица: SVEDENIYA_O_DOSTAVKE (исправленная)
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ nomer_zakaza │ INT          │ PK, FK          │ На ZAKAS      │
│ sposob_dost  │ VARCHAR(30)  │ -               │ Способ       │
│ data_dost    │ DATE         │ -               │ Дата          │
│ id_adresa    │ INT          │ FK              │ На ADRES      │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
ALTER TABLE SVEDENIYA_O_DOSTAVKE
DROP COLUMN strana,
DROP COLUMN gorod,
DROP COLUMN ulitsa,
DROP COLUMN nomer_doma,
DROP COLUMN kvartira,
DROP COLUMN pochtovyy_indeks,
ADD COLUMN id_adresa INT NOT NULL,
ADD FOREIGN KEY (id_adresa) REFERENCES ADRES(id_adresa);
```

### Спецификация таблицы ADRES

```
Таблица: ADRES
┌──────────────┬──────────────┬─────────────────┬──────────────┐
│ Колонка      │ Тип          │ Ключ            │ Описание      │
├──────────────┼──────────────┼─────────────────┼──────────────┤
│ id_adresa    │ INT          │ PK              │ Уник. ID     │
│ strana       │ VARCHAR(100) │ -               │ Страна       │
│ gorod        │ VARCHAR(100) │ -               │ Город        │
│ ulitsa       │ VARCHAR(100) │ -               │ Улица        │
│ nomer_doma   │ VARCHAR(20)  │ -               │ Номер дома   │
│ kvartira     │ VARCHAR(20)  │ - (NULL)        │ Квартира     │
│ pochtovyy_i  │ VARCHAR(20)  │ - (NULL)        │ Почт. индекс │
└──────────────┴──────────────┴─────────────────┴──────────────┘

SQL:
CREATE TABLE ADRES (
    id_adresa INT PRIMARY KEY AUTO_INCREMENT,
    strana VARCHAR(100) NOT NULL,
    gorod VARCHAR(100) NOT NULL,
    ulitsa VARCHAR(100) NOT NULL,
    nomer_doma VARCHAR(20) NOT NULL,
    kvartira VARCHAR(20),
    pochtovyy_indeks VARCHAR(20),
    UNIQUE KEY unique_address (strana, gorod, ulitsa, nomer_doma, kvartira)
);
```

**Описание изменений**:
> Выделены компоненты адреса (strana, gorod, ulitsa, nomer_doma, kvartira, pochtovyy_indeks) в отдельную таблицу ADRES. Это устраняет транзитивную зависимость, где pochtovyy_indeks зависел от (strana, gorod) более, чем от самого заказа. Таблица SVEDENIYA_O_DOSTAVKE теперь содержит только атрибуты, которые напрямую относятся к доставке заказа, и ссылается на ADRES через внешний ключ (id_adresa). Модель теперь полностью находится в 3НФ.

---

## ФИНАЛЬНАЯ МОДЕЛЬ (3НФ)

### Полная диаграмма

```
                    ZAKAS
                   ┌──────────────────┐
                   │ PK nomer_zak     │
                   │ vremya_zakaza    │
                   │  (TIMESTAMP) ✅  │
                   │ status           │
                   │ sposob_oplaty    │
                   │ summa (пр.)      │
                   │ summa_sk (пр.)   │
                   │ FK id_polz       │
                   └──────────────────┘
                      │
            ┌─────────┼──────────────┐
            │ 1:N     │ 1:1          │
            │         │              │
       ┌────▼──────┐  │  ┌──────────▼─────────────────┐
       │TOVAR_V_Z  │  │  │ SVEDENIYA_O_DOSTAVKE      │
       ├───────────┤  │  ├───────────────────────────┤
       │PK,FK id_z    │  │ PK,FK nomer_zak           │
       │ PK art   │  │  │ sposob_dostavki           │
       │ kol      │  │  │ data_dostavki             │
       └───────────┘  │  │ FK id_adresa              │
            │         │  └──────────────────────────┬┘
            │ N:1     │                    │ N:1
            │         │                    │
       ┌────▼──────┐  │            ┌───────▼──────┐
       │ TOVAR ✅  │  │            │ ADRES ✅     │
       ├───────────┤  │            ├──────────────┤
       │PK art    │  │            │ PK id_adr    │
       │tsena    │  │            │ strana       │
       │skidka   │  │            │ gorod        │
       └───────────┘  │            │ ulitsa       │
                      │            │ nomer_d      │
                      │            │ kvartira     │
                      │            │ pochta_i     │
                      │            └──────────────┘
```

### Таблицы (исправленные)

#### 1. ZAKAS (исправленная)
```
PK nomer_zakaza
vremya_zakaza (TIMESTAMP - объединенные дата и время) ✅
status_zakaza
sposob_oplaty
summa_zakaza (производная)
summa_skidok (производная)
FK id_polzovatelya
```

#### 2. TOVAR (новая) ✅
```
PK artikul_tovara
tsena_za_edinitsu
razmer_skidki
```

#### 3. TOVAR_V_ZAKAZE (исправленная)
```
PK, FK nomer_zakaza
PK, FK artikul_tovara
kolichestvo
```

#### 4. SVEDENIYA_O_DOSTAVKE (исправленная)
```
PK, FK nomer_zakaza
sposob_dostavki
data_dostavki
FK id_adresa
```

#### 5. ADRES (новая) ✅
```
PK id_adresa
strana
gorod
ulitsa
nomer_doma
kvartira
pochtovyy_indeks
```

---

## ПРОВЕРКА 3НФ ФИНАЛЬНОЙ МОДЕЛИ

### Таблица ZAKAS
```
PK: nomer_zakaza
Зависимости:
- nomer_zakaza → vremya_zakaza ✅ (от PK, одно событие)
- nomer_zakaza → status_zakaza ✅ (от PK)
- nomer_zakaza → sposob_oplaty ✅ (от PK)
- nomer_zakaza → id_polzovatelya ✅ (от PK)

Нет зависимостей между неключевыми атрибутами ✅
Нет транзитивных зависимостей ✅
```
**Статус**: ✅ 3НФ

### Таблица TOVAR (новая)
```
PK: artikul
Зависимости:
- artikul → tsena_za_edinitsu ✅ (от PK)
- artikul → razmer_skidki ✅ (от PK)

Нет зависимостей между неключевыми атрибутами ✅
Нет транзитивных зависимостей ✅
```
**Статус**: ✅ 3НФ

### Таблица TOVAR_V_ZAKAZE (исправленная)
```
PK: (nomer_zakaza, artikul)
Зависимости:
- (nomer_zakaza, artikul) → kolichestvo ✅ (от полного PK)

Нет зависимостей между неключевыми атрибутами ✅ (остался только одна зависимость!)
Нет транзитивных зависимостей ✅
```
**Статус**: ✅ 3НФ (частичные зависимости устранены!)

### Таблица SVEDENIYA_O_DOSTAVKE (исправленная)
```
PK: nomer_zakaza
Зависимости:
- nomer_zakaza → sposob_dostavki ✅ (от PK)
- nomer_zakaza → data_dostavki ✅ (от PK)
- nomer_zakaza → id_adresa ✅ (от PK)

Нет зависимостей между неключевыми атрибутами ✅
Нет транзитивных зависимостей ✅
```
**Статус**: ✅ 3НФ (транзитивные зависимости устранены!)

### Таблица ADRES (новая)
```
PK: id_adresa
Зависимости:
- id_adresa → strana ✅ (от PK)
- id_adresa → gorod ✅ (от PK)
- id_adresa → ulitsa ✅ (от PK)
- id_adresa → nomer_doma ✅ (от PK)
- id_adresa → kvartira ✅ (от PK)
- id_adresa → pochtovyy_indeks ✅ (от PK)

Компоненты адреса теперь зависят от id_adresa, а не от nomer_zakaza ✅
Нет транзитивных зависимостей ✅
```
**Статус**: ✅ 3НФ

---

## ИТОГОВЫЙ РЕЗУЛЬТАТ

### ✅ МОДЕЛЬ ПОЛНОСТЬЮ НАХОДИТСЯ В 3НФ ✅

| Таблица | 1НФ | 2НФ | 3НФ | Изменения |
|---------|-----|-----|-----|-----------|
| ZAKAS | ✅ | ✅ | ✅ | Объединены data + vremya в TIMESTAMP |
| TOVAR | ✅ | ✅ | ✅ | **НОВАЯ** (из TOVAR_V_ZAKAZE) |
| TOVAR_V_ZAKAZE | ✅ | ✅ | ✅ | Удалены tsena и skidka (частичные зависимости) |
| SVEDENIYA_O_DOSTAVKE | ✅ | ✅ | ✅ | Удалены компоненты адреса (транзитивные зависимости) |
| ADRES | ✅ | ✅ | ✅ | **НОВАЯ** (из SVEDENIYA_O_DOSTAVKE) |

**Преимущества модели после нормализации**:
- ✅ Нет дублирования данных (tsena товара хранится в одном месте)
- ✅ Легко обновлять цены товаров (в одной таблице TOVAR)
- ✅ Легко обновлять адреса (в одной таблице ADRES)
- ✅ Нет неконсистентности данных
- ✅ Оптимальное хранение памяти (нет избыточности)
- ✅ Консистентная целостность данных
- ✅ Быстрые запросы к БД
- ✅ Модель готова к использованию в продакшене

**Ключевые исправления**:
1. ❌ → ✅ Устранена частичная зависимость в TOVAR_V_ZAKAZE (tsena, skidka)
2. ❌ → ✅ Устранена транзитивная зависимость в SVEDENIYA_O_DOSTAVKE (адрес компоненты)
3. ⚠️ → ✅ Объединены дата и время в логическое TIMESTAMP событие

