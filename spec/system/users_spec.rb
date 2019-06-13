require 'rails_helper'

 describe 'ユーザー管理機能', type: :system do
  describe '新規登録機能' do

    before do
      visit new_user_path
      fill_in 'user_email',	with: 'test_user@gmail.com'
      fill_in 'user_password',	with: 'qwerty'
      fill_in 'user_password_confirmation',	with: 'qwerty'
    end

    it '新規登録画面で名前を入力した時、正常に登録される' do
      fill_in 'user_name',	with: 'テストユーザー'

      click_button 'アカウントを作成する'

      expect(page).to have_selector '.alert-notice', text: 'ユーザー登録しました'
    end

    it '新規作成画面で名称を入力しなかった時、エラーとなる' do
      fill_in 'user_name',	with: ''

      click_button 'アカウントを作成する'

      within '#error_explanation' do
        expect(page).to have_content 'Nameを入力してください'
      end
    end
  end

   describe 'ログイン・ログアウト機能' do
    before do
      FactoryBot.create(:user)
       visit new_session_path
    end

    context 'ログインテスト' do
      it 'ログインに成功した時' do
        fill_in 'Email',	with: 'test1@example.com'
        fill_in 'Password',	with: 'qwerty'

        click_button 'Log in'

        expect(page).to have_selector '.alert-notice', text: 'ログインしました'
      end

      it 'emailを間違えて、ログインに失敗した時' do
        fill_in 'Email',	with: 'test111111111@example.com'
        fill_in 'Password',	with: 'qwerty'

        click_button 'Log in'
        expect(page).to have_selector '.alert-danger', text: 'ログインに失敗しました'
      end
    end

    context 'ログアウトテスト' do
      it 'ログイン後に、ログアウトした時' do
        fill_in 'Email',	with: 'test1@example.com'
        fill_in 'Password',	with: 'qwerty'

        click_button 'Log in'

        click_link 'ログアウト'
        expect(page).to have_current_path '/sessions/new'
      end
    end
  end

   describe '詳細表示機能' do
    before do
      FactoryBot.create(:user)
       visit new_session_path
    end
    it 'ユーザー詳細画面が見れるかどうか' do
      fill_in 'Email',	with: 'test1@example.com'
      fill_in 'Password',	with: 'qwerty'

       click_button 'Log in'

       click_link 'マイページ'
      expect(page).to have_content 'テストユーザー'
      expect(page).to have_content 'test1@example.com'
    end
  end
end