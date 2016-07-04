require 'rails_helper'

RSpec.describe "words/new", type: :view do
  before(:each) do
    assign(:word, Word.new(
      lang_code1: 'en',
      lang_code2: 'ru',
      text1: 'hello',
      text2: 'hallo'
    ))
  end

  it "renders new word form" do
    render

    assert_select "form[action=?][method=?]", words_path, "post" do
      assert_select "select#word_lang_code1 option[selected]", text: 'English'
      assert_select "select#word_lang_code2 option[selected]", text: 'Russian'
      assert_select "input#word_text1", value: 'hello'
      assert_select "input#word_text2", value: 'hallo'
    end
  end
end
