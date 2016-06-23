require 'rails_helper'

RSpec.describe 'words/index', type: :view do
  before(:each) do
    assign(:words, [
      Word.create!(
        :lang_from => 'English',
        :lang_to => 'Russian',
        :text => 'Text',
        :translation => 'Translation'
      ),
      Word.create!(
        :lang_from => 'German',
        :lang_to => 'Russian',
        :text => 'Text',
        :translation => 'Translation'
      )
    ])
  end

  it 'renders a list of words' do
    render
    assert_select 'tr>td', :text => 'Lang from'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Lang to'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Text'.to_s, :count => 2
    assert_select 'tr>td', :text => 'Translation'.to_s, :count => 2
  end
end
