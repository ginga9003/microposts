class StaticPagesController < ApplicationController
  def home
    # ログインしてたら全投稿を取得する
    @micropost = current_user.microposts.build if logged_in?
  end
end
