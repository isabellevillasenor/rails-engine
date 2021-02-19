FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { Faker::Number.number(digits: 10) }
    credit_card_expiration_date { 12/21 }
    result { "success" }
  end
end
