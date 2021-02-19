FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Games::WarhammerFantasy.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    merchant
  end
end
