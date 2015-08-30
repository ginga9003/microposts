class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :description, :string
    add_column :users, :location, :string
    add_column :users, :birthday, :string
    add_column :users, :color, :string
  end
end
