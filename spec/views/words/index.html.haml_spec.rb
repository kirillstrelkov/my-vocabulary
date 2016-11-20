require 'rails_helper'

RSpec.describe 'words/index', type: :view do
  before(:each) do
    assign(:dict, DictionaryHelper::Dictionary.new('Yandex'))
    assign(:lang_pair, ['en', 'ru'])
    assign(:words, [
      Word.create!(
        lang_code1: 'en',
        text1: 'hello',
        lang_code2: 'ru',
        text2: 'привет',
        user_id: 1,
      ),
    ])
  end

  it 'renders a list of words' do
    render
    {
        'Russian': 1,
        'English': 1,
        'hello': 1,
        'привет': 1,

    }.each do |text, count|
      assert_select 'tr>td', text: text.to_s, count: count
    end
  end

end
