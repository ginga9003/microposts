class Retweet < ActiveRecord::Base
  belongs_to :user, class_name: 'User'
  belongs_to :retweet, class_name: 'Micropost'
end
