class ChangeDatatypeFollowNowOfFight < ActiveRecord::Migration[6.1]
  def change
    change_column :fights, :fight_now, :boolean, default:false

  end
end
