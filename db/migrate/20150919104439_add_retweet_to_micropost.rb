class AddRetweetToMicropost < ActiveRecord::Migration
  def change
    add_reference :microposts, :retweet, index: true
  end
end
