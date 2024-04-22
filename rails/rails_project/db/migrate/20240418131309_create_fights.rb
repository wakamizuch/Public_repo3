class CreateFights < ActiveRecord::Migration[6.1]
  def change
    create_table :fights do |t|
      t.string :user_id
      t.string :task_id
      t.string :fight_now

      t.timestamps
    end
  end
end
