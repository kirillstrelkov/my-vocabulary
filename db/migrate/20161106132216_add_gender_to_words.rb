class AddGenderToWords < ActiveRecord::Migration
  def change
    add_column :words, :text1_gender, :string, default: nil
    add_column :words, :text2_gender, :string, default: nil
  end
end
