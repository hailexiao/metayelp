require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name Faker::Name.name.split(' ')[0]
    last_name Faker::Name.name.split(' ')[1]
    password 'password'
    password_confirmation 'password'
  end

  factory :yelper do
    name Faker::Name.name
    location Faker::Address.city
    number_of_reviews Random.rand(10)
    image_url Faker::Avatar.image
    uid Faker::Lorem.characters(22)
  end

end
