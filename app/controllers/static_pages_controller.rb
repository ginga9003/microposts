class StaticPagesController < ApplicationController
  def home
    # ログインしてたら全投稿を取得する
    if logged_in? 
      @microposts = current_user.microposts.build
      
      @following_count = current_user.following_users.length # フォロー数
      @follower_count = current_user.follower_users.length # フォロワー数
      @post_count = current_user.microposts.length # 投稿数
    end
  end
end
