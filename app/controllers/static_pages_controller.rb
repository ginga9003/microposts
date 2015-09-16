class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # ログインしてたら
      # 全投稿を取得する
      @micropost = current_user.microposts.build
      
      # タイムライン取得
      # 投稿順に並び替え
      # includes : LEFT OUTER JOIN Users
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
