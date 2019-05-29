# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  let(:task_a) { Task.create!(title: 'こんにちは', content: '世界', priority: '高', status: '着手中', deadline: '2020-01-01') }
  background do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end

  scenario "タスク一覧のテスト" do
    visit tasks_path
    expect(page).to have_content 'Factory_content1'
    expect(page).to have_content 'Factory_content2'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'task_title', with: 'なごみの湯'
    fill_in 'task_content', with: '1人でもくもく'
    fill_in 'task_priority', with: '高'
    fill_in 'task_status', with: '未着手'
    fill_in 'task_deadline', with: '2019-06-10'
    click_on 'タスクを登録する'
    expect(page).to have_content 'なごみの湯'
    expect(page).to have_content '1人でもくもく'
    expect(page).to have_content '高'
    expect(page).to have_content '未着手'
    expect(page).to have_content '2019-06-10'
  end

  scenario "タスク詳細のテスト" do
    # 6行目でセットしてある初期値を使ってテストを作成
    visit task_path(task_a)
    expect(page).to have_content "こんにちは 世界 高 着手中 2020-01-01"
  end

  scenario "タスクが作成日時の降順に並んでいるかテスト" do
    visit tasks_path
    expect(Task.order("created_at DESC").each)
  end

  scenario "タスクが終了期限の降順に並んでいるかテスト" do
    visit tasks_path
    click_on "終了期限で並び替える"
    expect(Task.order("deadline ASC").each)
  end

  scenario "タスクが優先度の降順に並んでいるかテスト" do
    visit tasks_path
    click_on "優先度で並び替える"
    expect(Task.order("priority ASC").each)
  end
end