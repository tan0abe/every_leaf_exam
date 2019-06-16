require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデルのテスト' do
    context 'バリデーションのテスト' do
      it 'nameが空ならバリデーションが通らない' do
        user = User.new(name: '', email: 'test@gmail.com', password: '000000')
        expect(user).not_to be_valid
      end

       it 'emailが空ならバリデーションが通らない' do
        user = User.new(name: 'test', email: '', password: '000000')
        expect(user).not_to be_valid
      end

       it 'nameとemailに内容が記載されていればバリデーションが通る' do
        user = User.new(name: 'test', email: 'test@gmail.com', password: '000000')
        expect(user).to be_valid
      end

       it 'emailがすでに存在しているものは登録できない' do
        user_01 = FactoryBot.create(:user)
        user_02 = User.new(name: 'test', email: 'test1@example.com', password: '000000')
        expect(user_02).not_to be_valid
      end

       it 'emailが有効でなければ登録できない' do
        user = User.new(name: 'test', email: 'test', password: '000000')
        expect(user).not_to be_valid
      end
    end
  end
end