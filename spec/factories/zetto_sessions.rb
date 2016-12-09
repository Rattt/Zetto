FactoryGirl.define do
  factory :zetto_session, class: 'Zetto::Session' do
    user_id 1
    session_id "MyString"
    algorithm "MyString"
  end
end
