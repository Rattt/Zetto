require "zetto/load"
# Simple generator for rails
Zetto.setup do |config|

  # Список пользовательских классов
  config.user_classes = ['User']
  # Поиск сесиии по этим полям
  config.user_class_name     = 'email'
  config.user_class_password = 'password'

  # Длинна пароля, больше чем
  config.user_class_password_length_larger = 6

  # Хешировать пароль с помощью
  # ['MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']
  config.user_class_password_crypto = 'SHA1'

  # Настройки для подключения к бд redis, не используем 0 бд, так-как она предназначается для тестовых нужд
  config.redis_connect = { "db" => 1}

  # Чем больше тем надежнее, но будет медленее поиск
  config.session_length = 9

  # Время жизни сесии
  config.session_time_min = 30

  # За сколько минут перегенирировать
  config.session_time_restart_min = 5

  # Ведет лог посещений пользователей
  config.log = false

  # Можно настроить сессию на ип, что повысит стойкость, но имеем проблемы для людей с динамическим ип, в некоторых случаях
  config.check_ip = false

end