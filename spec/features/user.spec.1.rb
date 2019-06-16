require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  feature "一覧表示機能" do
    given(:user_a) { FactoryBot.create(:user, name: 'test_user01', email: 'a@example.com') }
    given(:user_b) { FactoryBot.create(:user, name: 'test_user02', email: 'b@example.com') }

  before do
    FactoryBot.create(:task, title: '最初のタスク', user: user_a)
    visit new_session_path
    fill_in 'session_email', with: login_user.email
    fill_in 'session_password', with: login_user.password
    click_button 'Log in'
  end

  context "ユーザーAでログインする" do
    given(:login_user) { user_a }
    scenario "ユーザーAのタスクが表示される" do
      expect(page).to have_content "タスク一覧"
      click_on 'タスク登録'
      expect(page).to have_content "タスク作成画面"
    end
  end

    scenario "ユーザーBでログアウトする" do
      click_on 'ログアウト'
      expect(page).to have_content "ログアウトしました"
    end

    scenario "ログインしていないとログインページに戻される" do
      click_on 'ログアウト'
      visit tasks_path
      expect(page).to have_content "ログインが必要です"
    end

    scenario "ログイン中にユーザ登録画面にいけない" do
      visit new_user_path
      expect(page).to have_content "ログイン済です"
    end
  end
end