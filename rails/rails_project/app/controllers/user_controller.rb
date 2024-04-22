class UserController < ApplicationController

  def create
    puts user_params
    @user = UserInfo.new(
      name: user_params[:name],
      email: user_params[:email],
      password: user_params[:password]
    )
    if @user.save
      puts "成功しました"
      puts user_params
      render_success link_to: {name:"SignIn"}
    else
      puts "失敗しました"
      render_success link_to: {name:"SignUp"}
    end
  end

  def login
    puts user_params_login
    #if user_params_login[:email].include?("@")
    #  @user = UserInfo.find_by(email: user_params_login[:email])
    #else
    #  @user = UserInfo.find_by(name: user_params_login[:email])
    #end
    @user = UserInfo.find_by(email: user_params_login[:email])
    if !@user
      # emailに入っていることに注意
      @user = UserInfo.find_by(name: user_params_login[:email])
      puts "成功しました"
    end
    
    # if文の条件を&&とauthenticateメソッドを用いる
    if @user && @user.authenticate(user_params_login[:password])
      puts "ログインできました"
      render_success userId: @user.id 
    else
      puts "メールアドレスまたはパスワードが間違っています"
      render_success userId: -1 
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  private
  def user_params_login
    params.require(:user).permit(:email, :password)
  end

end
  