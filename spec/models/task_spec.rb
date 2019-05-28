require 'rails_helper'

RSpec.describe Task, type: :model do
  FactoryBot.create(:task)
  FactoryBot.create(:second_task)

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: 'test', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    expect(task).not_to be_valid  # .not_toとすることでバリデーションが通らない事を確認している
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: '', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(title: '成功テスト', content: '成功テスト', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    expect(task).to be_valid  # .toとすることでバリデーションが通っている事を確認している
  end

  it "search_titleスコープのテスト" do
    # scope_test = Task.search_title(Task.find(1).title)
    # binding.pry
    expect(Task.search_title(Task.find(1).title)).to eq Task.where("title LIKE ?", "%#{Task.find(1).title}%")
    # Task.where("title LIKE ?", "%#{Task.find(1).title}%")
    # Task.where(title: 'Factory_title1')
  end

  it "search_statusスコープのテスト" do
    expect(Task.search_status('未完了')).to eq Task.where("status LIKE ?", "%#{'未完了'}%")
    # Task.where("status LIKE?", "%#{'未完了'}%")
  end
end