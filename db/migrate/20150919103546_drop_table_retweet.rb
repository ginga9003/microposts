class DropTableRetweet < ActiveRecord::Migration
  def change
    drop_table :retweets
  end
end
