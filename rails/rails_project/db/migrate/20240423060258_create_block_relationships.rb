class CreateBlockRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :block_relationships do |t|
      t.integer :blocker_id
      t.integer :blocked_id
      t.boolean :block_now

      t.timestamps
    end
    
  end
 
end
