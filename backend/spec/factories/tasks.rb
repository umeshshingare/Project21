FactoryBot.define do
  factory :task do
    title { "MyString" }
    description { "MyText" }
    status { 1 }
    project { nil }
    user { nil }
    due_date { "2025-10-02 14:34:40" }
  end
end
