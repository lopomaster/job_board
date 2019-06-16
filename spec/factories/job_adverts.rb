FactoryBot.define do

  factory :job_advert, class: JobAdvert do
    description { Faker::Lorem.sentence }
    company
  end

end

