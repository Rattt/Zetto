FactoryGirl.define do
  factory :zetto_session, class: 'Zetto::Models::Session' do
    user_id '1'
    session_id '123456789'
    algorithm 0
  end

  factory :zetto_session_two, class: 'Zetto::Models::Session' do
    user_id '2'
    session_id '123458789'
    algorithm 0
  end

end


