# Currency Exchanger API

## Описание

Приложение на основе данных с сайта [OpenExchangeRates](https://openexchangerates.org/) реализует 2 REST API метода:
1. `GET /currencies` — возвращает список курсов валют
2. `GET /currencies/{iso_code}` — возвращает курс валюты для переданного кода валюты согласно стандарту ISO

В приложении реализованы:
- Пагинация для списка валют - [kaminari](https://github.com/kaminari/kaminari)
- Интеграционные тесты и документация в формате [Swagger UI](https://swagger.io/tools/swagger-ui/) - [rswag](https://github.com/rswag/rswag)
- `Rake task` для обновления данных в таблице с валютами
- bearer аутентификация
- Выполнение HTTP-запросов - [httparty](https://github.com/jnunemaker/httparty)

## Версия Ruby

```
ruby 3.0.2
```

## Версия Rails

```
rails 7.0.3
```

## Версия Postgresql

```
postgresql 12.12
```

## Использование

### Первый запуск

```
gem install bundler
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
```

Требуется зарегистрироваться на [OpenExchangeRates](https://openexchangerates.org/) для получения `APP_ID`.

Затем ввести следующую команду

```
copy .env.template .env
```

И заполнить файл `.env`

```
OPENEXCHANGERATES_APP_ID=<APP_ID>
AUTH_TOKEN=<some_token>

```

### Загрузить данные о валютах

```
bundle exec rake currencies:update
```

### Запустить сервер

```
bundle exec rails s
```

### Запустить тесты

```
bundle exec rspec
```

## Документация API

Примеры запросов доступны по адресу http://localhost:3000/api-docs
