require 'rails_helper'
require 'date'

describe 'タスク管理機能', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { FactoryBot.create(:task, title: '最初のタスク', user: user_a) }

  before do
    visit new_session_path
    fill_in 'Email', with: login_user.email
    fill_in 'Password', with: login_user.password
    click_button 'Log in'
  end

  shared_examples_for 'ユーザーAが作成したタスクが表示される' do
    it { expect(page).to have_content '最初のタスク' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
      # 同じ処理があるので、shared_example_forにまとめてit_behaves_likeを使用する
      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のタスク'
      # end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit tasks_path(task_a)
      end

      it_behaves_like 'ユーザーAが作成したタスクが表示される'
      # 同じ処理があるので、shared_example_forにまとめてit_behaves_likeを使用する
      # it 'ユーザーAが作成したタスクが表示される' do
      #   expect(page).to have_content '最初のタスク'
      # end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in 'task_title', with: task_title
      fill_in 'task_content', with: task_content
      select '高', from: 'task_priority'
      select '未着手', from: "task_status"
      # fill_in "task_deadline", with: '2019-06-10'
      fill_in 'task_deadline', with: Date.today
      click_button 'タスクを登録する'
    end

    context '新規作成画面で入力したとき' do
      let(:task_title) { '新規作成のテスト' }
      let(:task_content) { '詳細のテスト' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: 'タスクを作成しました'
      end
    end

    context '新規作成画面で入力しなかったとき' do
      let(:task_title) { '' }
      let(:task_content) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'タスク名を入力してください'
        end
      end
    end
  end
end
