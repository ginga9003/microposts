class StaticPagesController < ApplicationController
  def home
    # ログインしてたら全投稿を取得する
    if logged_in? 
      @following_count = current_user.following_users.length # フォロー数
      @follower_count = current_user.follower_users.length # フォロワー数
      @post_count = current_user.microposts.length # 投稿数
      #@favorite_count = current_user.user_favorite_microposts.length # お気に入り数

      @microposts = current_user.microposts.build
      
      # タイムライン取得
      # 投稿順に並び替え
      # includes : LEFT OUTER JOIN Users
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      
      # リツイート一覧を取得
      @retweet_items = current_user.retweet_items.includes(:user).includes(:retweet).order(created_at: :desc)
      
      #binding.pry
    end
  end
end
