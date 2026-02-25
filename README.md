# Vladislav Orekhov — System & Business Analyst Portfolio

> Junior System Analyst | BPMN · UML · ERD · SQL · Figma  
> Moscow, Russia · vladislav.miller2000@gmail.com

Системный аналитик с практическим опытом полного цикла аналитической работы: от сбора требований и моделирования бизнес-процессов до проектирования баз данных и SQL-анализа. Прохожу специализацию «Системный аналитик» в Яндекс Практикум (2026).

---

## Проекты

### 1. [Vita Clinic — Анализ бизнес-процессов медицинской клиники](vita_clinic_project/)

Полный цикл системного анализа для сети медицинских клиник: автоматизация записи пациентов через мобильное приложение.

| Что сделал | Детали |
|------------|--------|
| Сбор требований | 3 интервью → 17 функциональных + 4 нефункциональных требования |
| AS-IS анализ | BPMN-диаграмма текущего процесса, выявлены 4 узких места |
| TO-BE проектирование | Новый BPMN-процесс без рецепциониста |
| UML State Machine | 6 состояний жизненного цикла записи |
| UI/UX прототип | 12 вайрфреймов в Figma + кликабельный HTML-прототип |

**Ключевые артефакты:**
[AS-IS BPMN](vita_clinic_project/diagrams/01_as_is_bpmn_v2.html) · [TO-BE BPMN](vita_clinic_project/diagrams/04_to_be_bpmn_final.html) · [UML State Machine](vita_clinic_project/diagrams/02_uml_state_machine_v2.html) · [Figma-прототип](https://www.figma.com/design/rxccOxVZ3ekyBEJi02YzMZ/) · [Спецификация Use Case](https://docs.google.com/document/d/1X8YmMWUtYVwiQn9p_pQ7CKJstmVVdmBX_gUB1LEBUWc/edit?tab=t.0) · [Диаграммы в Draw.io](https://app.diagrams.net/#G1cpTBE5WZsy-v7101zYY8ejd1wBPt9vyv)

`BPMN 2.0` `UML State Machine` `AS-IS / TO-BE` `Сбор требований` `Use Case` `Figma`

---

### 2. [Nakarabine — Проектирование базы данных e-commerce](Nakarabine/)

Проектирование БД интернет-магазина одежды: от концептуальной модели до нормализованной схемы.

| Что сделал | Детали |
|------------|--------|
| Концептуальная модель | ERD в нотации Чена |
| Логическая модель | ERD в нотации Crow's Foot, 5 таблиц |
| Нормализация | Пошаговый разбор 1НФ → 2НФ → 3НФ |
| Словарь данных | Все атрибуты, типы, ограничения, бизнес-правила |

**Ключевые артефакты:**
[ERD Chen](Nakarabine/chen_diagram_real.html) · [ERD Crow's Foot](Nakarabine/1nf_crows_foot.html) · [Нормализация](Nakarabine/normalization_stages.md) · [Словарь данных](Nakarabine/data_dictionary_final.html) · [Диаграммы в Draw.io](https://app.diagrams.net/#G1AOk6NrXDIK3hbL4n7AGNNfTBaCbZoZ3V) · [Требования к данным](https://docs.google.com/document/d/1WGV5_Z2h5BfPWJOXWd14uf8WGRujukI12VY-ycldlhA/edit?tab=t.0)

`ER-моделирование (Chen, Crow's Foot)` `Нормализация (1НФ–3НФ)` `Словарь данных` `SQL DDL`

---

### 3. [Анализ продаж ресторана — SQL](SQL_Project/)

20 аналитических SQL-запросов на данных ресторана: выручка, маржинальность, ABC-анализ меню, тренды.

| Что сделал | Детали |
|------------|--------|
| Схема БД | 3 таблицы: заказы, меню, позиции заказа |
| Аналитика | 20 запросов с бизнес-вопросами и комментариями |
| Техники | JOIN, CTE, оконные функции, подзапросы, CASE |

**Как запустить:** `cd SQL_Project && ./run_analysis.sh` (SQLite — база создаётся автоматически)

**Ключевые артефакты:**
[SQL-запросы](SQL_Project/restaurant_analysis.sql) · [Подробнее](SQL_Project/README.md)

`SQL` `JOIN` `CTE` `Оконные функции` `GROUP BY / HAVING` `CASE` `Агрегация`

---

## Резюме

| Версия | Файл |
|--------|------|
| Русский (Markdown) | [Resume/resume_ru_new.md](Resume/resume_ru_new.md) |
| English (Markdown) | [Resume/resume_en_new.md](Resume/resume_en_new.md) |
| Русский (Word) | [Resume/Resume_Vladislav_Orekhov_RU.docx](Resume/Resume_Vladislav_Orekhov_RU.docx) |
| English (Word) | [Resume/Resume_Vladislav_Orekhov_EN.docx](Resume/Resume_Vladislav_Orekhov_EN.docx) |
| Сопроводительное письмо (Markdown) | [Resume/cover_letter_ru.md](Resume/cover_letter_ru.md) |
| Сопроводительное письмо (Word) | [Resume/Cover_Letter_Vladislav_Orekhov_RU.docx](Resume/Cover_Letter_Vladislav_Orekhov_RU.docx) |

---

## Стек технологий

| Категория | Инструменты |
|-----------|-------------|
| Моделирование процессов | BPMN 2.0, UML (State Machine, Use Case, Activity) |
| Моделирование данных | ERD (Chen, Crow's Foot), нормализация (1НФ–3НФ) |
| Требования | Функциональные / нефункциональные, Use Case, User Stories |
| SQL | SQLite, PostgreSQL |
| Инструменты | Draw.io, Figma, Miro, Power BI, MS Excel |
| Разработка | Git, VS Code, Jira (знаком), Confluence (знаком) |

---

## Обо мне

- **Финансовый университет при Правительстве РФ** — Бакалавр экономики, Международные финансы (2018–2022)
- **Яндекс Практикум** — Системный аналитик (2025–2026)
- Стажировки: **Burger King** (маркетинговые исследования, бизнес-аналитика), **Knight Frank** (анализ рынка недвижимости)
- Языки: Русский (родной) · English (fluent) · Español (básico) · עברית (בסיסי)

---

## Структура репозитория

```
System-Analysis/
├── README.md                  ← вы здесь
├── Resume/                    ← резюме, сопроводительное письмо (Markdown + Word)
├── vita_clinic_project/       ← проект 1: бизнес-анализ клиники
│   ├── diagrams/              ← BPMN, UML диаграммы (HTML)
│   └── ...                    ← анализ, требования, прототип
├── Nakarabine/                ← проект 2: проектирование БД
│   └── ...                    ← ERD, нормализация, словарь данных
└── SQL_Project/               ← проект 3: SQL-аналитика
    ├── restaurant_analysis.sql
    └── run_analysis.sh
```
