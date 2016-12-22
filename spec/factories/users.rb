FactoryGirl.define do

  factory :user_ivan, class: 'User' do
    name                  'ivan'
    email                 'jov777@mail.ru'
    password              '12345678'
    password_confirmation '12345678'
  end

  factory :user_other, class: 'User' do
    name                  'other'
    email                 'Genom-1990@yandex.ru'
    password              '12345678'
    password_confirmation '12345678'
  end

  factory :cat_user, class: 'Cat' do
    name                  'other'
    email                 'Genom-1990@yandex.ru'
    password              '12345678'
    password_confirmation '12345678'
  end

end

