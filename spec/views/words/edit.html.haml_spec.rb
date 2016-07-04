require 'rails_helper'

RSpec.describe "words/edit", type: :view do
  before(:each) do
    @word = assign(:word, Word.create!(
      lang_code1: 'en',
      lang_code2: 'de',
      text1: 'hello',
      text2: 'hallo'
    ))
  end

  it "renders the edit word form" do
    render

    assert_select "form[action=?][method=?]", word_path(@word), "post" do
      assert_select "select#word_lang_code1 option[selected]", text: 'English'
      assert_select "select#word_lang_code2 option[selected]", text: 'German'
      assert_select "input#word_text1", value: 'hello'
      assert_select "input#word_text2", value: 'hallo'
    end
  end
end
