class AddTamoToUser < ActiveRecord::Migration
  def change
    add_column :users, :tamo, :integer
  end
end
