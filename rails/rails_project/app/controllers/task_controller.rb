class TaskController < ApplicationController

  def create
    pp "adfsd"
    puts task_params
    user_name = UserInfo.find(task_params[:user_id]).name
    task = Task.new(
      user_id: task_params[:user_id],
      user_name: user_name,
      text: task_params[:text],
    )
    if task.save
      puts "タスクのセーブに成功しました"
          #puts task_params
      render_success task: task
    else
      render_error
    end
  end
  # 自分のid...のタスクのフラグを変更する
  def update_task_flag
    pp task_params_for_update
    @update_task = Task.find(task_params_for_update[:task_id])
    pp @update_task
    @update_task.update(is_task_finished: !(@update_task.is_task_finished))
  end

  def load_my_task_cards
    puts "調査してみます"
    pp params.permit(:user_id)
    #user_id = params.permit(:user_id)
  #pp user_id[:user_id]
    #pp user_params
    #puts user_params
    tasks = Task.where(user_id: user_params[:user_id]).order(created_at: :desc)
    puts "調査終わりました"
    pp tasks
    render_success tasks: tasks
  end
  
  def load_task_cards
    
    tasks = Task.all.order(created_at: :desc).limit(15)
    pp "全てのタスクのロードします"
    pp tasks
    render_success tasks: tasks
  end

  def update_fight_num
    puts "fight_numの変更をします"
    pp fight_params
    task = Task.find_by(
      id:fight_params[:task_id],
    )
    if fight_params[:fight_now]
      if task.update(fight_num:task.fight_num+=1)
        render_success task:task
      else
        render_error
      end
    else 
      if task.update(fight_num:task.fight_num-=1)
        render_success
      else
        render_error task:task
      end
    end

  end

  private
  def task_params
    pp params
    params.require(:task).permit(:user_id , :text)
  end

  private
  def task_params_for_update
    pp params
    params.require(:task).permit(:task_id)
  end

  private
  def user_params
      puts "user_paramsです:"
    pp params
    
    #params.require.permit(:user_id)
    params.permit(:user_id)
  end

  private 
  def fight_params
    params.require(:fight).permit(:task_id ,:fight_now)
  end

end
  