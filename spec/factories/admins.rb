FactoryBot.define do
  factory :admin do
    sequence(:username) { |n| "admin#{n}" }
    hash_password { "123456" }
  end
end