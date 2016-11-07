class AddMemorizedToWord < ActiveRecord::Migration
  def change
    add_column :words, :memorized, :integer, default: 0
  end
end
