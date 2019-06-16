require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "Taskモデルのテスト" do
    user = FactoryBot.create(:user)

    context "バリデーションのテスト" do
      it "titleが空ならバリデーションが通らない" do
        task = user.tasks.build(
          title: "",
          content: "テスト内容"
        )
        expect(task).not_to be_valid
      end

      it "contentが空ならバリデーションが通らない" do
        task = user.tasks.build(
          title: "テストタイトル",
          content: ""
        )
        expect(task).not_to be_valid
      end

      it "titleとcontentに内容が記載されていればバリデーションが通る" do
        task = user.tasks.build(
          title: "テストタイトル",
          content: "テスト内容",
          priority: 0,
          status: "未着手",
          deadline: "2019-06-10"
        )
        expect(task).to be_valid
      end
    end
  end
end