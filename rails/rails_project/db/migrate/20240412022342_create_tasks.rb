class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :user_name
      t.string :text

      t.timestamps
    end
  end
end
