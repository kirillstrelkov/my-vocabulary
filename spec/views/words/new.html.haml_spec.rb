require 'rails_helper'

RSpec.describe "words/new", type: :view do
  before(:each) do
    assign(:word, Word.new(
      lang_from: "English",
      lang_to: "Russian",
      :text => "MyString",
      translation: "MyString"
    ))
  end

  it "renders new word form" do
    render

    assert_select "form[action=?][method=?]", words_path, "post" do

      assert_select "input#word_lang_from[name=?]", "word[lang_from]"

      assert_select "input#word_lang_to[name=?]", "word[lang_to]"

      assert_select "input#word_text[name=?]", "word[text]"

      assert_select "input#word_translation[name=?]", "word[translation]"
    end
  end
end
