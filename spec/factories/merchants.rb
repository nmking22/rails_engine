FactoryBot.define do
  FactoryBot.define do
    factory :merchant do
      name { Faker::Company.name }
      created_at { "MyString" }
      updated_at { "MyString" }
    end
  end
end
