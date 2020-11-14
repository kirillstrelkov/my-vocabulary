# frozen_string_literal: true

class ChangeTableWordsWithNewIndex < ActiveRecord::Migration
  def change
    remove_index :words, %i[lang_code1 lang_code2 text1 text2]
    add_index :words,
              %i[lang_code1 lang_code2 text1 text2 user_id],
              unique: true, name: 'unique_word'
  end
end
