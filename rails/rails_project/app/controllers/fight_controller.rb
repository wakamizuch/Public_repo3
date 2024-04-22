class FightController < ApplicationController
  # DB:Fightについて
  # カラム: user_id, task_id, fight_now(boolean)
  # すでにあるなら fight_now = !(fight_now)
  # そうでなければ、createしてsave
  def index
    pp index_params[:user_id]
    puts "fight のindex始めます"
    fight = Fight.where(
      user_id: index_params[:user_id],
      fight_now: true,
    )
    pp fight
    
    render_success fight:fight
  end

  def create
    pp fight_params
    pp "fight のcreate始めます"
    fight = Fight.find_by(
      user_id: fight_params[:user_id],
      task_id: fight_params[:task_id],
    )
    #もうすでにあるなら、アップデート
    if fight!= nil
      puts "成功しました"
      if fight.update(fight_now: !(fight.fight_now))
        render_success fight:fight
      else
        render_error
      end
    else
      #ないなら新たに作成
      puts "新たに作成します"
      fight = Fight.new(
        user_id: fight_params[:user_id],
        task_id: fight_params[:task_id],
        fight_now: true,
      )
      if fight.save
        pp "うまくいけました"
        render_success fight:fight
      else
        render_error
      end
    end
  end

  private
  def fight_params
    params.require(:fight).permit(:user_id,:task_id)
  end

  def index_params
    params.permit(:user_id )
  end
end