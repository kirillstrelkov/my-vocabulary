require 'rails_helper'

RSpec.describe 'words/index', type: :view do
  before(:each) do
    assign(:dict, DictionaryHelper::Dictionary.new('Yandex'))
    assign(:words, [
      Word.create!(
        lang_code1: 'en',
        text1: 'hello',
        lang_code2: 'ru',
        text2: 'привет'
      ),
      Word.create!(
        lang_code1: 'de',
        text1: 'hallo',
        lang_code2: 'ru',
        text2: 'привет'
      )
    ])
  end

  it 'renders a list of words' do
    render
    {
        'Russian': 2,
        'German': 1,
        'English': 1,
        'hello': 1,
        'hallo':1,
        'привет': 2,

    }.each do |text, count|
      assert_select 'tr>td', text: text.to_s, count: count
    end
  end

end
