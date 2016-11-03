class AddGenToWords < ActiveRecord::Migration
  def change
    add_column :words, :gender, :string
  end
end
