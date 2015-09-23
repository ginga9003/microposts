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
  validates :birthday, presence: false
  
  # 色はデフォルトが設定されており、現状手動で変更できないのでチェック無し
  # カラーコードでもカラーインデックスでも格納できるようにstringにしている
  
  has_secure_password
  has_many :microposts  # 1ユーザは複数の投稿（microposts）を持つという意味（１対多）

  # タイムライン（自分とフォローしているユーザのつぶやき）をすべて取得
  def feed_items
    # SELECT * FROM Miscroposts WHERE user_id = フォローしているユーザ OR user_id = 自分
    Micropost.where(user_id: following_user_ids + [self.id])
  end

  # ----------------------------
  # ここからフォロー関連
  # ----------------------------
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
  
  # あるユーザーにフォローされているかどうか？
  def followed?(other_user)
    follower_users.include?(other_user)
  end
  # ----------------------------
  # ここまでフォロー関連
  # ----------------------------
  
  # ----------------------------
  # ここからリツイート関連
  # ----------------------------
  has_many :user_retweets, class_name: "Retweet",
                            foreign_key: "user_id",
                            dependent: :destroy;  # Userを削除すると、Retweetテーブルの関連も削除される
  has_many :user_retweet_microposts, through: :user_retweets, source: :retweet      
  
  # リツイートする
  def retweet(retweet)
    user_retweets.create(retweet_id: retweet.id)
  end
  
  # リツイートをキャンセルする
  def retweet_cancel(retweet)
    user_retweets.find_by(retweet_id: retweet.id).destroy
  end
  
  # あるツイートをリツイートしているかどうか？
  def retweet?(retweet)
    user_retweet_microposts.include?(retweet)
  end
  
  # リツイートをすべて取得
  def retweet_items
    # SELECT * FROM Miscroposts WHERE user_id = フォローしているユーザ OR user_id = 自分
    Retweet.where(user_id: following_user_ids + [self.id]).where.not(retweet_id: nil)
  end
  # ----------------------------
  # ここまでリツイート関連
  # ----------------------------
  
  # ----------------------------
  # ここからお気に入り関連
  # ----------------------------
  has_many :user_favorites, class_name: "Favorite",
                            foreign_key: "user_id",
                            dependent: :destroy;  # Userを削除すると、Favoriteテーブルの関連も削除される
  has_many :user_favorite_microposts, through: :user_favorites, source: :favorite                            

  # あるツイートをお気に入り登録しているかどうか？
  def favorite?(favorite)
    user_favorite_microposts.include?(favorite)
  end

  # お気に入りに登録する
  def favorite(favorite)
    user_favorites.create(favorite_id: favorite.id)
  end
  
  # お気に入りをキャンセルする
  def favorite_cancel(favorite)
    user_favorites.find_by(favorite_id: favorite.id).destroy
  end
  # ----------------------------
  # ここまでお気に入り関連
  # ----------------------------

end
