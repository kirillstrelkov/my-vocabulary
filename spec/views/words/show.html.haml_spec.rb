require 'rails_helper'

RSpec.describe "words/show", type: :view do
  before(:each) do
    @word = assign(:word, Word.create!(
      :lang_from => "English",
      :lang_to => "Russian",
      :text => "Text",
      :translation => "Translation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Lang from/)
    expect(rendered).to match(/Lang to/)
    expect(rendered).to match(/Text/)
    expect(rendered).to match(/Translation/)
  end
end
