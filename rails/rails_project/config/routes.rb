Rails.application.routes.draw do
  # 6. get'/sample_items'から、'sample_items#index'つまり 'sample_items_controller.rb のindexっていう関数へ'
  #a4. post'/sample_items'から、'sample_items#create'つまり 'sample_items_controller.rb のcreateっていう関数へ'
  scope :api do
    get '/get_csrf_token', to: 'csrf_tokens#show'
    get '/sample_items', to: 'sample_items#index'
    post '/sample_items', to: 'sample_items#create'
    
    #user
    post '/addUserData', to: 'user#create'
    post '/login', to: 'user#login'

    #task
    get '/load_task_cards' ,to: 'task#load_task_cards'
    post '/task_page', to: 'task#show_all'
    post '/create_task', to: 'task#create'
    post '/update_task_flag', to: 'task#update_task_flag'
    get '/load_my_task_cards/:user_id', to: 'task#load_my_task_cards'
    post "/updateFightNum" , to: 'task#update_fight_num'

    # relation
    get '/get_followed_list/:follower', to: 'relation#index'
    post '/follow', to: 'relation#create'
    
    # fight
    get '/get_fight_task_list/:user_id', to: 'fight#index'
    post '/fight', to: 'fight#create'

    get '*path', to: 'application#not_found'
  end
end




