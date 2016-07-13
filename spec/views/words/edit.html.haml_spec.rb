require 'rails_helper'

RSpec.describe 'words/edit', type: :view do
  before(:each) do
    @word = assign(:word, Word.create!(
      lang_code1: 'en',
      lang_code2: 'de',
      text1: 'hello',
      text2: 'hallo'
    ))
  end

  it 'renders the edit word form' do
    render

    assert_select '#q', value: 'hello'
    assert_select 'td', text: 'hello'
    assert_select 'td', text: 'hallo'
    assert_select 'td', text: 'en-de'
  end
end
