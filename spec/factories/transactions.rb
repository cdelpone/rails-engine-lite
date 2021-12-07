FactoryBot.define do
  factory :transaction, class: Transaction do
    association :invoice
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    result { [0, 1].sample }
  end
end
