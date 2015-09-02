class Micropost < ActiveRecord::Base
  belongs_to :user  # この投稿はユーザの（に属する）ものである
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
