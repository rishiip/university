FactoryBot.define do
  factory :tutor do |f|
    association :course, factory: :course, strategy: :build

    name { Faker::Name.name }
    phone { Faker::Base.numerify("#{[6, 7, 8, 9].sample}#########") }
    email { Faker::Internet.email }
    age { rand(20..100) }
    qualification { ('A'..'Z').to_a.sample(3).join }
    sex { Faker::Gender.short_binary_type }
  end
end
