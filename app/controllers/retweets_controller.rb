class RetweetsController < ApplicationController
  before_action :logged_in_user, only: [:destroy]
  
  # リツイート解除
  def destroy
    # お気に入り登録しているツイートを取得
    # favoritesテーブルのidが渡されるので、それをもとに検索をかけ、ヒットしたレコードから
    # micropost(retweet)を取得する
    @retweet = current_user.user_retweets.find(params[:id]).retweet
    
    #binding.pry

    # リツイート解除
    current_user.retweet_cancel(@retweet)
  end
end

