# Simple generator for rails
Zetto.setup do |config|

  # Класс к который получаем по сессии
  config.user_class = "User"

  # Настройки для подключения к бд redis, не используем 0 бд, так-как она предназначается для тестовых нужд
  config.redis_connect = {:password => "3443555", "db" => 1}

end
