class ChangeDatatypeStatusOfTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :status, :string, default: ""
  end
end
