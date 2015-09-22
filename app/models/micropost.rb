class Micropost < ActiveRecord::Base
  belongs_to :user  # この投稿はユーザの（に属する）ものである
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  has_many :micropost_favorites, class_name: "Favorite",
                                 foreign_key: "favorite_id",
                                 dependent: :destroy;  # Userを削除すると、Favoriteテーブルの関連も削除される
  has_many :micropost_favorite_users, through: :micropost_favorites, source: :user   
  
  # あるツイートがお気に入り登録されているかどうか？
  def favorited?(user)
    micropost_favorite_users.include?(user)
  end

end
