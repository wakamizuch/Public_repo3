class AddFightNumToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :fight_num, :integer ,default:0
    
  end
end
