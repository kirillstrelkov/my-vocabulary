FactoryGirl.define do
  factory :user do
    name 'Guest'
    email 'guest@localhost'
    password 'guest@localhost'
    factory :random_user do
      email Faker::Internet.email
    end
  end
end
