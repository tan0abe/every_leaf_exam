class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :title, :string, null: false, default: 0
  end
end
