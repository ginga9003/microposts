class AddPagingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paging, :integer
  end
end
