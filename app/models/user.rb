class User < ActiveRecord::Base
  before_save { self.email = email.downcase } #emailをすべて小文字に変換して代入
  
  # ユーザ名は必須で、50文字以内
  validates :name, presence: true, length: { maximum: 50 }
  
  # 表示名は50文字以内
  # よくよく考えたらユーザ名があるからいらないんだけど一応入れとく
  validates :nickname, presence: false, length: { maximum: 50 }
  
  # メールアドレスは必須、正規表現でチェック
  # case_sensitive：false => 大文字小文字を区別しない
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  # プロフィールは、200文字以内
  validates :description, presence: false, length: { maximum: 200 }
  
  # 地域は50文字以内
  validates :location, presence: false, length: { maximum: 50 }
  
  # 誕生日
  # 本当はdate_selectを使いたかったが現状すごく難しそうだったので、こちらで
  # 拡張機能実装時にでも対応予定
  validates :birthday, presence: false
  
  # 色はデフォルトが設定されており、現状手動で変更できないのでチェック無し
  # カラーコードでもカラーインデックスでも格納できるようにstringにしている
  
  # ちなみに列追加のコマンドは以下
  # rails generate migration AddProfileToUser nickname:string description:string location:string birthday:string color:string
  # rake db:migrate
  
  has_secure_password
end
