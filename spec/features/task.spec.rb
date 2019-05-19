# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  let(:task_a) { Task.create!(title: 'こんにちは', content: '世界') }
  # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
  # new_task_pathにvisitする（タスク登録ページに遷移する）
  # 1.ここにnew_task_pathにvisitする処理を書く
    visit new_task_path
  # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
  # タスクのタイトルと内容をそれぞれfill_in（入力）する
  # 2.ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
  # 3.ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
    fill_in 'task_title', with: 'なごみの湯'
    fill_in 'task_content', with: '1人でもくもく'

  # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
  # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on 'タスクを登録する'

  # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
  # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
  # 5.タスク詳細ページに、テストコードで作成したはずのデータ（記述）がhave_contentされているか（含まれているか）を確認（期待）するコードを書く
    expect(page).to have_content 'なごみの湯'
    expect(page).to have_content '1人でもくもく'
  end

  scenario "タスク詳細のテスト" do
    visit task_path(task_a)
    expect(page).to have_content "タスク詳細画面\nタスク名 タスク詳細 こんにちは 世界\nタスク一覧へ戻る"
  end
end