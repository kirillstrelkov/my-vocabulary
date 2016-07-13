require 'rails_helper'

RSpec.describe 'words/new', type: :view do
  before(:each) do
    assign(:word, Word.new(
      lang_code1: 'en',
      lang_code2: 'ru',
      text1: 'hello',
      text2: 'hallo'
    ))
  end

  it 'renders new word form' do
    render

    assert_select '#q', value: 'hello'
    assert_select 'td', text: 'hello'
    assert_select 'td', text: 'hallo'
    assert_select 'td', text: 'en-ru'
  end
end
