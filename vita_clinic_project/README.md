# Vita Clinic — Анализ бизнес-процессов медицинской клиники

## О проекте

Полный цикл системного анализа для сети медицинских клиник «Вита» имени Е.Л. Яницкой. Клиника хотела перевести запись пациентов с телефонной линии на мобильное приложение.

## Что сделано

| Этап | Результат |
|------|-----------|
| Сбор требований | 3 интервью → 17 функциональных, 4 нефункциональных, 4 бизнес- и 4 пользовательских требования |
| AS-IS анализ | BPMN-диаграмма текущего процесса записи через рецепциониста, выявлены 4 узких места |
| TO-BE проектирование | BPMN-диаграмма целевого процесса — прямая запись через приложение без рецепциониста |
| UML State Machine | Диаграмма 6 состояний жизненного цикла записи на приём |
| UI/UX прототипирование | 12 вайрфреймов мобильного приложения (Figma + HTML-прототип) |

## Диаграммы

### В этом репозитории (HTML, открываются в браузере):
- [AS-IS BPMN](diagrams/01_as_is_bpmn_v2.html) — текущий процесс записи
- [TO-BE BPMN](diagrams/04_to_be_bpmn_final.html) — целевой процесс с приложением
- [UML State Machine](diagrams/02_uml_state_machine_v2.html) — состояния записи

### Финальные версии в Draw.io:
- [BPMN AS-IS, UML State Machine, BPMN TO-BE](https://app.diagrams.net/#G1cpTBE5WZsy-v7101zYY8ejd1wBPt9vyv#%7B%22pageId%22%3A%22L5DA05nVIV4_2HLQhlJK%22%7D)

### Спецификация требований (Use Case):
- [Google Docs — Спецификация требований](https://docs.google.com/document/d/1X8YmMWUtYVwiQn9p_pQ7CKJstmVVdmBX_gUB1LEBUWc/edit?tab=t.0#heading=h.2i1oh6evwa20)

## UI/UX Прототип

### Figma (финальная версия):
- [Figma — Раскадровка мобильного приложения](https://www.figma.com/design/rxccOxVZ3ekyBEJi02YzMZ/%D0%94%D0%97-%D0%A1%D0%BF%D1%80%D0%B8%D0%BD%D1%82-6-v.2--Copy-?node-id=0-1&p=f&t=GWWOPp7YJUyboXTo-0)

### В этом репозитории:
- [HTML-прототип (12 кликабельных вайрфреймов)](05_storyboard_prototype.html) — справочная версия
- [Руководство по вайрфреймам](04_storyboard_figma_guide.md) — детальное описание элементов каждого экрана

## Файлы проекта

| Файл | Описание |
|------|----------|
| [00_project_summary.md](00_project_summary.md) | Сводка проекта, требования, план |
| [01_project_analysis.md](01_project_analysis.md) | Детальный анализ интервью и требований |
| [04_storyboard_figma_guide.md](04_storyboard_figma_guide.md) | Руководство по созданию вайрфреймов |
| [05_storyboard_prototype.html](05_storyboard_prototype.html) | Кликабельный HTML-прототип |

## User Story Map + MVP (функция «Чекап»)

Отдельный мини-блок по новой функции **«Чекап»**: подбор плана регулярных обследований и путь до записи.

- [checkup/01_checkup_user_story_map_mvp.md](checkup/01_checkup_user_story_map_mvp.md) — единый артефакт: User Story Map + MVP

## Навыки

`BPMN 2.0` `UML State Machine` `AS-IS / TO-BE` `Сбор требований` `Интервью стейкхолдеров` `Use Case` `Figma` `UI/UX wireframing`
