class RelationshipsController < ApplicationController
  before_action :logged_in_user # ログインしているかどうか
  
  # フォロー
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end
  
  # アンフォロー
  def destroy
    # フォローしているユーザを取得
    @user = current_user.following_relationships.find(params[:id]).followed

    # アンフォロー
    curren_user.unfollow(@user)
  end
end
