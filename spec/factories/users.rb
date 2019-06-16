require 'securerandom'
require 'bcrypt'

FactoryBot.define do
  factory :user do
    username               { Faker::Name.unique.name }
    first_name             { Faker::Name.first_name }
    last_name              { Faker::Name.last_name }
    email                  { Faker::Internet.unique.email }
    password               { Faker::Internet.password }
    password_confirmation  { password }
    encrypted_password     { BCrypt::Password.create(password) }

    trait :as_candidate do
      association :profile, factory: :candidate
    end

    trait :as_company do
      association :profile, factory: :company
    end

  end

end

