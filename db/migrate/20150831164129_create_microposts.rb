class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.references :user, index: true, foreign_key: true  # インデックスを生成
      t.text :content

      t.timestamps null: false
      t.index [:user_id, :created_at] # ユーザIDと作成時間でインデックス生成
    end
  end
end
