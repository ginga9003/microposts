class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :user, index: true
      t.references :retweet, index: true

      t.timestamps null: false
      t.index [:user_id, :retweet_id], unique: true # このキーの組み合わせは重複NG
    end
  end
end
