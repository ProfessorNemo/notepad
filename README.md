# Консольное приложение `notepad`:
# Блокнот с использованием SQLite 
###### Язык написания - Ruby

## Описание приложения:
Представлен проект БД для блокнота, который пользуется SQlite-базой для хранения всех записей. 
Программа сохраняет новую запись в базе при добавлении и по запросу пользователя выводит последние
записи определенного типа (задача - Task, заметка - Memo, ссылка - Link). С помощью SQlite-браузера 
создается база данных "notepad.sqlite" и в ней таблица для блокнота (см. доплонительные исчточники по
SQL-запросам)

## Установка и запуск:

**Примечание:** Это ruby-приложение, поэтому необходимо
чтобы на вашем компьютере был установлен интерпретатор Ruby.

1. Перенесите содержимое данного репозитория на свой компьютер
```
git clone git@github.com:ProfessorNemo/notepad.git
```
2. Чтобы запустить приложение в этой же директории
следует воспользоваться следующими командами:
```
ruby new_post.rb
(для заполнения БД)
```
и
```
ruby read.rb
(для чтения данных из базы)
```
## Пример работы программы:
```
ruby new_post.rb

Привет, я твой блокнот!
Записываю новые записи в базу SQLite

Что хотите записать в блокнот?
        0. Memo
        1. Task
        2. Link
0
Новая заметка (все, что пишите до строчки "end"):
Web development is an interesting and exciting activity.
end
Запись сохранена в базе, id = 1
```

```
ruby read.rb --h
Usage: read.rb [options]
    -h                               Prints this help
        --type POST_TYPE             какой тип постов показывать (по умолчанию любой)
        --id POST_ID                 если задан id — показываем подробно  только этот пост
        --limit NUMBER               сколько последних постов показать (по умолчанию все)

ruby read.rb --id 1

Запись Memo, id = 1
Создано: 2022.04.28, 18:54:44
Web development is an interesting and exciting activity.
```
```
ruby read.rb


| id                 | @type              | @created_at        | @text              | @url               | @due_date          |
| 3                  | Link               | 2022-04-28 18:59:0 | Nokogiri library f | https://nokogiri.o |                    |
| 2                  | Task               | 2022-04-28 18:58:3 | Learn how to work  |                    | 32 days, 8 hours,  |
| 1                  | Memo               | 2022-04-28 18:54:4 | Web development is |                    |                    |
```








