# frozen_string_literal: true

class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :lang_code1
      t.string :text1
      t.string :lang_code2
      t.string :text2

      t.timestamps null: false
    end
  end
end
