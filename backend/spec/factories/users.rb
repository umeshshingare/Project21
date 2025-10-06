FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    role { 1 }
    reset_password_token { "MyString" }
    reset_password_sent_at { "2025-10-02 14:30:29" }
  end
end
