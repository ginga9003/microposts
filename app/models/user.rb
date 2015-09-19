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
  has_many :microposts  # 1ユーザは複数の投稿（microposts）を持つという意味（１対多）
  
  has_many :following_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy;  # Userを削除すると、Relationshipテーブルの関連も削除される
  has_many :following_users, through: :following_relationships, source: :followed                            

  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy;  # Userを削除すると、Relationshipテーブルの関連も削除される
  has_many :follower_users, through: :follower_relationships, source: :follower                         

  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end
  
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  # タイムライン（自分とフォローしているユーザのつぶやき）をすべて取得
  def feed_items
    # SELECT * FROM Miscroposts WHERE user_id = フォローしているユーザ OR user_id = 自分
    Micropost.where(user_id: following_user_ids + [self.id])
  end

  # あるユーザーにフォローされているかどうか？
  def followed?(other_user)
    follower_users.include?(other_user)
  end
end
