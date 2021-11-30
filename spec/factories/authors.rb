FactoryBot.define do
  factory :author do
    first_name { "MyString" }
    last_name { "MyString" }
    sequence(:email) {|n| "my_email_#{n}@example.com" }
  end
end
