FactoryBot.define do
  factory :book do
    title {"This is a title"}
    published_date { 2.days.ago }
    author 
  end
end
