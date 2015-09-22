class Favorite < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :favorite, class_name: "Micropost"
end
