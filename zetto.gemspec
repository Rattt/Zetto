$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zetto/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zetto"
  s.version     = Zetto::VERSION
  s.authors     = ["Ivan"]
  s.email       = ["Genom-1990@yandex.ru"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.6"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'

  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "sqlite3"

end
