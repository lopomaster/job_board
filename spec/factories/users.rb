require 'securerandom'
require 'bcrypt'

FactoryBot.define do
  factory :user do
    username              { Faker::StarWars.specie }
    firstname             { Faker::Name.first_name }
    lastname              { Faker::Name.last_name }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password }
    password_confirmation password
    encrypted_password    { BCrypt::Password.create(password) }
  end
end

