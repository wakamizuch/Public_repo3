class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :following_user_id
      t.integer :followed_user_id
      t.timestamps
    end

    #add_foreign_key :relationships, :user_infos, column: :following_user_id
    #add_foreign_key :relationships, :user_infos, column: :followed_user_id
  end
  update_task_flag
end
