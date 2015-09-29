require 'factory_girl'
require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name Faker::Name.name.split(' ')[0]
    last_name Faker::Name.name.split(' ')[1]
    password 'password'
    password_confirmation 'password'
    role 'member'
  end

  factory :yelper do
    name { Faker::Name.name }
    location { Faker::Address.city }
    sequence(:number_of_reviews) { |n| n }
    image_url { Faker::Avatar.image }
    uid { 22.times.map { ('a'..'z').to_a[Random.rand(26)] }.join }
  end

  factory :review do
    yelper
    user
    rating "4"
    body "ZOMG I LOVE THIS YELPER. His or her reviews move me in ways I didn't feel was possible."
  end

  factory :upvote do
    user
    review_id nil
  end

  factory :downvote do
    review_id nil
    user
  end
end
