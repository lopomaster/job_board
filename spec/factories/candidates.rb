FactoryBot.define do
  factory :candidate do
    profession        { Faker::Movies::StarWars.planet }
    notes             { Faker::Lorem.paragraph }
  end
end

