# Zetto
[![Build Status](https://travis-ci.org/Rattt/zetto.svg?branch=develop)](https://travis-ci.org/Rattt/zetto) 
**Zetto** Gems for authentication and authorization

## Общее описание

Эта библиотека позвояляет хранить сесии пользователя, различных моделей.
Сессия умеет продлеватся.
Позволяет настраивать поля которые будут использоватся в качестве логина и пароля.
Имеет логирование входа пользователей.
Хранит юзерагент посетителя.

## Установка
Чтобы работать с моделями мы должны указать в настройке `config.user_classes` необходимые модели.
И затем для каждой из этих моделей мы должны запустить генератор 

1. Вы должны иметь redis на своем сервере
2. Вы должны включить гем в ваш Gemfile:
  ```ruby
  gem 'zetto'
  ```

3. А затем запустить
  ```ruby
  bundle
  ```

4. Запустить инициализатор, для первоначальной настроки гема:
    
   ```ruby
   rails g zetto:install
   ```
5. Добавляем вашу модель в список `config.user_classes` и запускаем генератор для этой модели
   ```ruby
   rails g zetto YourModel
   ```  
Запускать генератор для модели важно, так-как он добавляет метод который валидирует пароль и миграции.
Все, установка законченна!


## Использование
У нас есть 3 метода доступны в контроллере.  

* Первый подписывает пользователя, создает шифрованную кукис

   ```ruby
   authorization(model_name, name, password)
   ```
* Так мы можем получить пользователя обратно    

   ```ruby
   current_user
   ```
* Или завершить сессию, убив куки

  ```ruby
  logout
  ```
## Настройки


* Список пользовательских классов
    `config.user_classes = ['User']`
* Указываем поля логина и пароля
    `config.user_class_name     = 'email'`
    `config.user_class_password = 'password'`

* Настройка длины пароля для моделей
    `config.user_class_password_length_larger = 6`

* Хешировать пароль модели с помощью
    `['MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']`
    `config.user_class_password_crypto = 'SHA1'`

* Настройки для подключения к бд redis, не используем 0 бд, так-как она предназначается для тестовых нужд
    `config.redis_connect = {:password => "3443555", "db" => 1}`

* Длинна идентификатора сесиии, но фактически будет больше потому что шифруется
    `config.session_length = 9`

* Время жизни сесии
    `config.session_time_min = 30`

* За сколько минут перегенирировать
    `config.session_time_restart_min = 5`

* Ведет лог посещений пользователей
    `config.log = false`

## Ruby version tested

2.2.4

# Help

## [Concept](https://docs.google.com/document/d/1AGOqfECm_qLhpbPl75ssxHTLbZMRpd2-pYLfbDH67No)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Rattt/zetto. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

