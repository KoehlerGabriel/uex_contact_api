FactoryBot.define do
  factory :user do
    name { "João Carlos" }
    email { "joca@mail.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
