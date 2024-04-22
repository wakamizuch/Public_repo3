class AddFollowNowToRelationships < ActiveRecord::Migration[6.1]
  def change
    add_column :relationships, :follow_now, :boolean, default:false
  end
end
