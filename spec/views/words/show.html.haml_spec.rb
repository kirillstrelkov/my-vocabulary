require 'rails_helper'

RSpec.describe "words/show", type: :view do
  before(:each) do
    assign(:dict, DictionaryHelper::Dictionary.new('Yandex'))
    assign(:word, Word.create!(
      lang_code1: 'en',
      lang_code2: 'ru',
      text1: 'text 1',
      text2: 'text 2',
      user_id: 1,
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/English/)
    expect(rendered).to match(/Russian/)
    expect(rendered).to match(/text 1/)
    expect(rendered).to match(/text 2/)
  end
end
