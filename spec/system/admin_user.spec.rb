require 'rails_helper'

 describe "管理者によるユーザー管理機能", type: :system do

   describe 'ユーザー一覧機能' do
    let(:admin_user_01){FactoryBot.create(:admin_user)}
    let(:user_01){FactoryBot.create(:user)}

     before do
      visit new_session_path
      fill_in 'Email', with: login_user.email
      fill_in 'Password',	with: login_user.password
      click_button 'Log in'
    end

     context "管理者がログインしている時" do
      let(:login_user) { admin_user_01 }
      it "ユーザー管理が表示される" do
        expect(page).to have_content 'ユーザー管理'
      end
    end

     context "一般ユーザーがログインしている時" do
      let(:login_user) { user_01 }
      it "ユーザー管理が表示されない" do
        expect(page).not_to have_content 'ユーザー管理'
      end
    end
  end

  describe '新規登録機能' do

    before do
      #管理者ユーザーでログインする
      FactoryBot.create(:admin_user)
      visit new_session_path
      fill_in 'Email', with: "admin@example.com"
      fill_in 'Password',	with: "qwerty"
      click_button 'Log in'
    end

     context "管理者権限にチェックを入れる" do
      it "新規管理者ユーザーは、ユーザー管理画面へアクセスできる" do
        visit new_admin_user_path

        fill_in 'user_name', with: "admin_user_01"
        fill_in 'user_email', with: "admin_01@example.com"
        fill_in 'user_password',	with: "qwerty"
        fill_in "user_password_confirmation",	with: "qwerty"
        check "管理者権限"

        click_button '登録する'

        click_link 'ログアウト'

         #新規管理者ユーザーでログインする
        visit new_session_path
        fill_in 'Email', with: "admin_01@example.com"
        fill_in 'Password',	with: "qwerty"
        click_button 'Log in'

        expect(page).to have_content 'ユーザー管理'
      end
    end
  end

   describe '編集機能' do
    before do
      #管理者ユーザーでログインする
      FactoryBot.create(:admin_user)
      @user = FactoryBot.create(:user)
      visit new_session_path
      fill_in 'Email', with: "admin@example.com"
      fill_in 'Password',	with: "qwerty"
      click_button 'Log in'
      click_link 'ユーザー管理'
    end

     context "管理者が一般ユーザーの編集画面へ" do
      it "名前を編集すると変更されているかどうか" do
        visit edit_admin_user_path(@user.id)

        fill_in "user_name",	with: "testuser_update"
        click_button '更新する'

        expect(page).to have_content 'testuser_update'
      end
    end
  end

   describe '削除機能' do
    before do
      #管理者ユーザーでログインする
      FactoryBot.create(:admin_user)
      FactoryBot.create(:user)
      visit new_session_path
      fill_in 'Email', with: "admin@example.com"
      fill_in 'Password',	with: "qwerty"
      click_button 'Log in'
      click_link 'ユーザー管理'
    end

    context "管理者がユーザー管理画面へ" do
      it "削除ボタンを押した時に削除されているかどうか" do
        # 削除ボタンをクリックする
        find('.delete_link').click
        # 本当に削除してもいいですか？と確認されるのでOKを押す処理
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content 'test1@example.com'
      end
    end
  end
end