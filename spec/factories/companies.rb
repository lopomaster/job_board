FactoryBot.define do
  factory :company do
    name                    { Faker::Name.unique.name }
    description             { Faker::Lorem.paragraph }
  end
end