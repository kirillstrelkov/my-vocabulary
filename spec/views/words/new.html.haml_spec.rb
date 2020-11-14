# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'words/new', type: :view do
  before(:each) do
    assign(:dict, DictionaryHelper::Dictionary.new('Yandex'))
    assign(:lang_pair, %w[en de])
    assign(:word, Word.new(
                    lang_code1: 'en',
                    lang_code2: 'de',
                    text1: 'hello',
                    text2: 'hallo',
                    user_id: 1
                  ))
  end

  it 'renders new word form' do
    render

    expect(rendered).to include('hello')
    expect(rendered).to include('hallo')
  end
end
