# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'words/edit', type: :view do
  before(:each) do
    assign(:dict, DictionaryHelper::Dictionary.new('Yandex'))
    assign(:lang_pair, %w[en ru])
    assign(
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
    expect(rendered).to include('hello')
    expect(rendered).to include('приветствие')
    expect(rendered).to include('ср')
  end
end
