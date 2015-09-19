class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]  # edit, update, destroyの処理の前にuserを設定する

  def new
    @user = User.new
  end
  
  # ユーザ登録
  def create
    @user = User.new(user_params)
    @user.description = ""
    @user.location = ""
    @user.birthday = ""
    if @user.save
      # 登録成功
      flash[:success] = "Welcome to the MICROPOSTS!"
      redirect_to login_path # redirect_to user_path(@user)と同じ意味
    else
      # 登録失敗
      render 'new'
    end
  end
  
  # 登録成功後表示画面
  def show
    @user = User.find(params[:id])
    
    # 全投稿を取得
    @microposts = @user.microposts
    
    # フォロー、フォロワー情報取得
    set_user_basic_info
  end
  
  # ユーザ情報変更
  def edit
  end
  
  # ユーザ情報更新
  def update
    if @user.update(user_params)
      # 更新成功
      flash[:success] = "Update Completed!"
      redirect_to current_user
    else
      # 登録失敗
      render 'edit'
    end
  end
  
  # フォローしているユーザ一覧
  def followings
    @user = User.find(params[:id])
    
    #rabinding.pry
    # フォローしているユーザ一覧を取得
    @following_users = @user.following_users

    # フォロー、フォロワー情報取得
    set_user_basic_info
  end
  
  # フォローしてくれてるユーザ一覧
  def followers
    @user = User.find(params[:id])
  
    # フォロワー覧を取得
    @follower_users = @user.follower_users

    # フォロー、フォロワー情報取得
    set_user_basic_info
  end
  
  private
  
  # 入力パラメータの許可
  def user_params
    
    if action_name == "update"
      # 更新の場合
      #binding.pry
      params.require(:user).permit(:name, :nickname, :email, 
                                   :description, :location, :birthday, :color)    
    else
      # それ以外の場合
      params.require(:user).permit(:name, :email, :password, 
                                   :password_confirmation)    
    end
  end
  
  # ユーザ情報を取得する
  def set_user
    @user = User.find(params[:id])
  end
  
  # ユーザ情報を取得する
  def set_user_basic_info
    @following_count = @user.following_users.length # フォロー数
    @follower_count = @user.follower_users.length # フォロワー数
    @post_count = @user.microposts.length # 投稿数
  end
end
