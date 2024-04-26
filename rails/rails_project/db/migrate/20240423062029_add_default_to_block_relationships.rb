class AddDefaultToBlockRelationships < ActiveRecord::Migration[6.1]
  def change
    change_column_default :block_relationships, :block_now, false
  end
end
