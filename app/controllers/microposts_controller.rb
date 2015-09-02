class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  # ツイート作成
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # 登録成功の場合
      flash[:success] = "Micropost created!"
      
      # トップページへリダイレクト
      redirect_to root_url
    else
      # エラー
      render 'static_pages/home'
    end
  end

  # ツイート削除
  def destroy
    # 削除するツイート取得
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?  # 見つからなかったら下の画面に戻る
    
    # 削除
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    
    # リファラがあれば元のURLへ。それ以外はrootへ
    redirect_to request.referrer || root_url
  end

  private
  # 入力パラメータ取得
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end