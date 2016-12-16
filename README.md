# Zetto
[![Build Status](https://travis-ci.org/Rattt/zetto.svg?branch=develop)](https://travis-ci.org/Rattt/zetto) 
**Zetto** Gems for authentication and authorization

## Information on release

It can be used as storages of sessions in your project, during creation writing of authorization or authentication.
Will keep the object belonging to the specified class.
If he belongs to the specified class, then we store an object.
Add to your controller
```ruby 
create_session_for_user(user)
```
```ruby 
current_user
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

## Dependences

Only for `rails` framework. And you need `redis` db in your computer.

# Help

## [Concept](https://docs.google.com/document/d/1AGOqfECm_qLhpbPl75ssxHTLbZMRpd2-pYLfbDH67No)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Rattt/zetto. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

