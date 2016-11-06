require 'rails_helper'

RSpec.describe 'words/edit', type: :view do
  before(:each) do
    @word = assign(
      :word,
      Word.create!(
        lang_code1: 'en',
        lang_code2: 'ru',
        text1: 'hello',
        text1_gender: 'ср',
        text2: 'приветствие',
        text2_gender: 'ср',
        user_id: 1
      )
    )
  end

  it 'renders the edit word form' do
    render

    assert_select '#q', value: 'hello'
    assert_select 'td', text: 'hello'
    assert_select 'td', text: 'приветствие'
    assert_select 'td', text: 'en-ru'
    assert_select 'td', text: 'ср'
  end
end
