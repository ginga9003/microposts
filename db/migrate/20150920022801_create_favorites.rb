class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :favorite, index: true

      t.timestamps null: false
      t.index [:user_id, :favorite_id], unique: true # このキーの組み合わせは重複NG
    end
  end
end
