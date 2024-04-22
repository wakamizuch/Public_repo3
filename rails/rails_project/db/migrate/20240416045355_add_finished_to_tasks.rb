class AddFinishedToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :is_task_finished, :boolean, default:false
    
  end
end
