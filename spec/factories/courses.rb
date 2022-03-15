FactoryBot.define do
  factory :course do |f|
    title { ('A'..'Z').to_a.sample(3).join }
    description { Faker::Lorem.sentence }
    published_at { Faker::Date.in_date_period(year: 2021) }
    fee { Faker::Number.number(digits: 6) }

    trait :with_tutors do
      after(:create) do |course|
        rand(1..5).times { FactoryBot.create(:tutor, course: course) }
      end
    end
  end
end
