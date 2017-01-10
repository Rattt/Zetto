$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zetto/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zetto"
  s.version     = Zetto::VERSION
  s.authors     = ["Ivan Moroz", "Denis Shumkov", "Maksim Pestov", "Tatiana Podymova", "Vitaliy S"]
  s.email       = ["Genom-1990@yandex.ru"]
  s.homepage    = ""
  s.summary     = "Rails authentication applications."
  s.description = "Rails authentication applications."
  s.license     = "MIT"

  s.add_dependency "rails"
  s.add_dependency 'redis',    '~>3.2'
  s.add_dependency 'hiredis',  '~> 0.6.0'
  s.add_dependency 'i18n',     '0.7.0'
  s.add_dependency 'colorize', '0.8.1'

  s.add_development_dependency 'rspec-rails',        "~> 3.5.2"
  s.add_development_dependency 'capybara',           "~> 2.11.0"
  s.add_development_dependency 'factory_girl_rails', "~> 4.7.0"

  s.files = Dir["{app,generators,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "sqlite3"

end
