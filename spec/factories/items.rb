FactoryBot.define do
  FactoryBot.define do
    factory :item do
      name { "MyString" }
      description { "MyText" }
      unit_price { Faker::Commerce.price }
      created_at { "MyString" }
      updated_at { "MyString" }
      merchant
    end
  end
end
