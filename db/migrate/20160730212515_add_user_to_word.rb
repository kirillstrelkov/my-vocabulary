class AddUserToWord < ActiveRecord::Migration
  def change
    add_column :words, :user_id, :reference
  end
end
