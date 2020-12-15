FactoryBot.define do
  FactoryBot.define do
    factory :merchant do
      name { Faker::Company.name }
      created_at { "MyString" }
      updated_at { "MyString" }

      trait :with_items do
        after :create do |merchant|
          create_list(:item, 2, merchant: merchant)
        end
      end
    end
  end
end
