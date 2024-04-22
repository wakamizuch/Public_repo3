class ChangDatatypeUserIdOfFights < ActiveRecord::Migration[6.1]
  def change
    change_column :fights, :user_id, :integer
    change_column :fights, :task_id, :integer
  end
end
