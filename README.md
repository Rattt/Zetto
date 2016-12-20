# Zetto
[![Build Status](https://travis-ci.org/Rattt/zetto.svg?branch=develop)](https://travis-ci.org/Rattt/zetto) 
**Zetto** Gems for authentication and authorization

## Information on release

Allows to adjust time of life of sessions of the user
Besides can work with several user models at once

Has 3 methods in controller
```ruby 
registration(class_name, name, password)
```
```ruby 
current_user
```
```ruby 
logout
```

## Ruby version tested

2.2.4

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zetto'
```
And then execute:

```ruby
bundle
```

Run installation:

```ruby
rails g zetto:install
```

You can change a config

Then we specify models with which we will work

```ruby
rails generate zetto MODEL
```

## Dependences

Only for `rails` framework. And you need `redis` db in your computer.

# Help

## [Concept](https://docs.google.com/document/d/1AGOqfECm_qLhpbPl75ssxHTLbZMRpd2-pYLfbDH67No)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Rattt/zetto. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

