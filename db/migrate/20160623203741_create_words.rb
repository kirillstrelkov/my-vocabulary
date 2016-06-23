class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :lang_from
      t.string :lang_to
      t.string :text
      t.string :translation

      t.timestamps null: false
    end
  end
end
