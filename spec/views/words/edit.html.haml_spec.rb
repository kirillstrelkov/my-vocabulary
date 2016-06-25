require 'rails_helper'

RSpec.describe "words/edit", type: :view do
  before(:each) do
    @word = assign(:word, Word.create!(
      lang_from: "English",
      lang_to: "German",
      :text => "MyString",
      translation: "MyString"
    ))
  end

  it "renders the edit word form" do
    render

    assert_select "form[action=?][method=?]", word_path(@word), "post" do

      assert_select "input#word_lang_from[name=?]", "word[lang_from]"

      assert_select "input#word_lang_to[name=?]", "word[lang_to]"

      assert_select "input#word_text[name=?]", "word[text]"

      assert_select "input#word_translation[name=?]", "word[translation]"
    end
  end
end
