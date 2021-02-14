FactoryBot.define do
  factory :merchant do
    name { Faker::Books::Dune.character }
  end
end
