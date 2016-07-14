class AddIndexToWordsLangCode1LangCode2Text1Text2 < ActiveRecord::Migration
  def change
    add_index :words, [:lang_code1, :lang_code2, :text1, :text2], unique: true
  end
end
