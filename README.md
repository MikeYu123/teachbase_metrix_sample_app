# Teachbase Test Task Sample App
Данное приложение является демонстрацией функционирования библиотеки [Teachbase Metrix Collector](https://github.com/MikeYu123/teachbase_metrix_collector).

## Ключевые Зависимости
Проект разрабатывался с использованием следующих (основных) рантаймов/библиотек:
* Ruby 2.4.0
* Rails 5.1.6
* Redis 4.0.2
* sqlite3 3.23.1
* rspec (3.9.0-pre)
* sidekiq (5.2.1)

## База Данных
В базе данных по заданию описаны модели CourseStat, SectionStat, QuizStat, MaterialStat, AnswerStat и TaskStat. В разработке использованы исключительно зависимости от ANSI SQL, что позволяет при необходимости изменить адаптер и базу данных на MySQL/PostgreSQL/Oracle/DB2...
## Sidekiq
Sidekiq используется как конкретная реализация очередей ActionCable. С небольшими усилиями можно заменить sidekiq на другой адаптер очередей.
## Запуск и тестирование
Для запуска необходимо (процессы 2-5 можно выполнить с помощью bin/setup):
1. Установить __Ruby 2.4.0__
2. Установить gem __bundler__
3. Выполнить в корне данного проекта `bundle install`
4. Запустить `rails db:create db:migrate`
5. Запустить процессы `bundle exec sidekiq` и `bundle exec rails s`
Для тестирования необходимо провести шаги 1-4 (с env-переменной `RAILS_ENV=test`) и запустить `bundle exec rspec`
## TODO
Небольшой список вещей, которые хотелось бы также выполнить в рамках тестового задания:
* Упростить setup-процесс (с помощью провизионирования)
* Добавить read и delete-actions в контроллеры
