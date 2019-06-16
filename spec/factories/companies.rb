FactoryBot.define do
  factory :company do
    name                    { Faker::Movies::StarWars.specie }
    description             { Faker::Lorem.paragraph }
  end
end