require 'rails_helper'

RSpec.describe SessionController, type: :controller do

  describe "Post #update_lang_pair" do
    it "updates session" do
      {'en-ru' => ['en', 'ru'], 'de-en' => ['de', 'en']}.each do |pair_string, pair|
        post :update_lang_pair, lang_pair: pair_string
        expect(session[:lang_pair]).to eq(pair)
      end
    end
  end

end
