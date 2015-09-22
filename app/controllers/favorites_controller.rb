class FavoritesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  # お気に入り登録
  def create
    @favorite = Micropost.find(params[:micropost_id])
    current_user.favorite(@favorite)
  end
  
  # お気に入り削除
  def destroy
    # お気に入り登録しているツイートを取得
    # favoritesテーブルのidが渡されるので、それをもとに検索をかけ、ヒットしたレコードから
    # micropost(favorite)を取得する
    @favorite = current_user.user_favorites.find(params[:id]).favorite
    
    #binding.pry

    # お気に入り削除
    current_user.favorite_cancel(@favorite)
  end
end
