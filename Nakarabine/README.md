# Nakarabine — Проектирование базы данных e-commerce платформы

## О проекте

Полный цикл проектирования базы данных для интернет-магазина одежды Nakarabine: от концептуальной модели до нормализованной физической схемы.

## Что сделано

| Этап | Результат |
|------|-----------|
| Требования к данным | Определены сущности, атрибуты, бизнес-правила, ограничения целостности |
| Концептуальная модель | ERD в нотации Чена: сущности, атрибуты, связи |
| Логическая модель | ERD в нотации Crow's Foot: 5 таблиц с типами данных и кардинальностями |
| Нормализация | Пошаговый разбор с 1НФ через 2НФ до 3НФ с обоснованием каждого шага |
| Словарь данных | Описание всех атрибутов с типами, ограничениями и бизнес-правилами |
| Валидация | Проверка схемы по именованию, ключам, кардинальностям, ограничениям |

## Диаграммы

### В этом репозитории (HTML, открываются в браузере):
- [ERD — нотация Чена](chen_diagram_real.html)
- [ERD — нотация Crow's Foot (3НФ)](1nf_crows_foot.html)
- [Логическая модель (детальная)](nakarabine_logical_model_detailed.html)
- [Словарь данных](data_dictionary_final.html)

### Финальные версии в Draw.io:
- [Use Case, ERD (Chen), ERD (Crow's Foot), Нормализация](https://app.diagrams.net/#G1AOk6NrXDIK3hbL4n7AGNNfTBaCbZoZ3V#%7B%22pageId%22%3A%22w6Cyh-53SWGdDepHjgfD%22%7D)

### Требования к данным (Google Docs):
- [Требования к данным Nakarabine](https://docs.google.com/document/d/1WGV5_Z2h5BfPWJOXWd14uf8WGRujukI12VY-ycldlhA/edit?tab=t.0)

## Файлы проекта

| Файл | Описание |
|------|----------|
| [chen_diagram_real.html](chen_diagram_real.html) | ERD в нотации Чена (интерактивный) |
| [1nf_crows_foot.html](1nf_crows_foot.html) | ERD в нотации Crow's Foot |
| [nakarabine_logical_model_detailed.html](nakarabine_logical_model_detailed.html) | Детальная логическая модель |
| [data_dictionary_final.html](data_dictionary_final.html) | Словарь данных |
| [normalization_stages.md](normalization_stages.md) | Нормализация 1НФ → 2НФ → 3НФ |
| [nakarabine_data_requirements_v2.md](nakarabine_data_requirements_v2.md) | Требования к данным |
| [crows_foot_validation.md](crows_foot_validation.md) | Валидация итоговой схемы |

## Навыки

`ER-моделирование (Chen, Crow's Foot)` `Нормализация (1НФ–3НФ)` `Словарь данных` `Логическое проектирование БД` `SQL DDL`
