FactoryBot.define do
  factory :customer do
    first_name { Faker::JapaneseMedia::DragonBall.character }
    last_name { Faker::JapaneseMedia::DragonBall.race }
  end
end
