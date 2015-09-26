class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
      t.index [:follower_id, :followed_id], unique: true # このキーの組み合わせは重複NG
    end
  end
end
