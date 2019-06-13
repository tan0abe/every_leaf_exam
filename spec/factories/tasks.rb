FactoryBot.define do
  factory :task do
      title { 'テストを書く' }
      content { 'test_content01' }
      priority {'低'}
      status {'未着手'}
      deadline { '2019-06-10' }
      user
    end
end