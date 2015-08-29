module SessionsHelper
  
  # ログインユーザ取得
  def current_user
    # @current_userが設定されていればそれを返し、未設定の場合は
    # セッションに格納されているユーザIDを元にユーザ情報を返す
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # ログインしているかどうか
  def logged_in?
    # 最後に?が付いているのでtrue/falseを返す
    # current_userだとオブジェクトが返るので, true/falseで返したい場合に!!を使用する
    # current_userが存在する場合はtrue, それ以外はfalseを返す
    !!current_user
  end
  
  # URLを保存する
  def store_location
    # GETリクエストの場合は、セッションにリクエストURLを格納
    # ログインが必要な画面に、未ログイン状態でアクセスした場合に
    # ログイン画面でログイン後に指定URLに遷移するため
    session[:forwarding_url] = request.url if request.get?
  end
end