# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'Factory_title1' }
    content { 'Factory_content1' }
    priority { '高' }
    status { '未完了' }
    deadline { '2019-05-29' }
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factory_title2' }
    content { 'Factory_content2' }
    priority { '中' }
    status { '着手中' }
    deadline { '2020-01-01' }
  end

  factory :user_task, class: Task do
      title { 'test_title01' }
      content { 'test_content01' }
      deadline { '2019-06-10' }
      status {'完了'}
      priority {'低'}
      user
    end
end