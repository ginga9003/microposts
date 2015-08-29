class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  # ユーザ登録
  def create
    @user = User.new(user_params)
    if @user.save
      # 登録成功
      flash[:success] = "Welcom to the Sample App!"
      redirect_to @user # redirect_to user_path(@user)と同じ意味
    else
      # 登録失敗
      render 'new'
    end
  end
  
  # 登録成功後表示画面
  def show
    @user = User.find(params[:id])  
  end
  
  private
  
  # 入力パラメータの許可
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)    
  end
end
