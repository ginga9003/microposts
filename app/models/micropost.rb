class Micropost < ActiveRecord::Base
  belongs_to :user  # この投稿はユーザの（に属する）ものである
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }, :if => "self.retweet_id.blank?"
  
  # ここからお気に入り関連
  has_many :micropost_favorites, class_name: "Favorite",
                                 foreign_key: "favorite_id",
                                 dependent: :destroy;  # Userを削除すると、Favoriteテーブルの関連も削除される
  has_many :micropost_favorite_users, through: :micropost_favorites, source: :user   
  
  # あるツイートがお気に入り登録されているかどうか？
  def favorited?(user)
    micropost_favorite_users.include?(user)
  end
  # ここまでお気に入り関連

  # ここからリツイート関連
  has_many :micropost_retweets, class_name: "Retweet",
                                foreign_key: "retweet_id",
                                dependent: :destroy;  # Userを削除すると、Retweetテーブルの関連も削除される
  has_many :micropost_retweet_users, through: :micropost_retweets, source: :user   
  
  # あるツイートがリツイートされているかどうか？
  def retweeted?(user)
    micropost_retweet_users.include?(user)
  end
  # ここまでリツイート関連
end
