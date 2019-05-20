class AddColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :string, null: false, default: 0
    add_column :tasks, :status, :string, null: false, default: 0
    add_column :tasks, :deadline, :integer, null: false, default: 0
    add_column :tasks, :label, :string
  end
end
