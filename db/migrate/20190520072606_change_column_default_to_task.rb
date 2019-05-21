class ChangeColumnDefaultToTask < ActiveRecord::Migration[5.2]
  def up
    change_column_default :tasks, :title, nil
    change_column_default :tasks, :content, nil
    change_column_default :tasks, :priority, nil
    change_column_default :tasks, :status, nil
    change_column_default :tasks, :deadline, nil
  end

  def down
    change_column_default :tasks, :title, 0
    change_column_default :tasks, :content, 0
    change_column_default :tasks, :priority, 0
    change_column_default :tasks, :status, 0
    change_column_default :tasks, :deadline, 0
  end
end
