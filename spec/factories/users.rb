FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'qwerty' }
  end

  factory :admin_user, class: User do
    name { "admin_user" }
    email { "admin@example.com" }
    password { "qwerty" }
    admin {"true"}
  end
end
