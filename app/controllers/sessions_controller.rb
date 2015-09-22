class SessionsController < ApplicationController
  def new
  end
  
  # ログイン（セッション作成）
  def create 
    # emailからユーザ情報を取得
    @user = User.find_by(email: params[:session][:email].downcase)

    # ユーザが存在する かつ 認証（入力Passwordが一致するかどうかチェック）
    # has_secure_passwordで提供されるauthenticateを呼ぶことで、
    # password_digestと比較してくれる
    if @user && @user.authenticate(params[:session][:password])
      # 一致する場合
      # セッションにユーザIDを格納
      session[:user_id] = @user.id
      
      flash[:info] = I18n.t('controller.sessions.login') + @user.name
      redirect_to @user
    else
      # 一致しない場合
      flash[:danger] = I18n.t('controller.sessions.invalid_email')
      render "new"
    end
  end
  
  # ログアウト（セッション削除）
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
