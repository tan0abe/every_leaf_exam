require 'rails_helper'

RSpec.describe Task, type: :model do

  it "titleが空ならバリデーションが通らない" do
    task = Task.new(title: '', content: 'test', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    # .not_toとすることでバリデーションが通らない事を確認している
    expect(task).not_to be_valid
  end

  it "contentが空ならバリデーションが通らない" do
    task = Task.new(title: '失敗テスト', content: '', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    expect(task).not_to be_valid
  end

  it "titleとcontentに内容が記載されていればバリデーションが通る" do
    task = Task.new(title: '成功テスト', content: '成功テスト', priority: '成功テスト', status: '成功テスト', deadline: '成功テスト')
    # .toとすることでバリデーションが通っている事を確認している
    expect(task).to be_valid
  end
end