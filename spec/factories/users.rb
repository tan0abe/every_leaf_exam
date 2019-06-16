FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'qwerty' }
  end

  # factory :user2, class: User do
  #   name { 'テストユーザー2' }
  #   email { 'test22222@example.com' }
  #   password { 'qwerty' }
  # end
end
