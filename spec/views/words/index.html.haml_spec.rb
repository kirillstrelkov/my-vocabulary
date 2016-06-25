require 'rails_helper'

RSpec.describe 'words/index', type: :view do
  before(:each) do
    assign(:words, [
      Word.create!(
        lang_from: 'English',
        lang_to: 'Russian',
        text: 'hello',
        translation: 'привет'
      ),
      Word.create!(
        lang_from: 'German',
        lang_to: 'Russian',
        text: 'hallo',
        translation: 'привет'
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
