FactoryBot.define do
  factory :item do
    name { Faker::Vehicle.make_and_model }
    description { Faker::Lorem.sentence }
    unit_price { 1.5 }
    merchant_id { nil }
  end
end
