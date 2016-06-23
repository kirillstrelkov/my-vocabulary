require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:valid_data) do
    {
      lang_from: 'German',
      lang_to: 'English',
      text: 'hallo',
      translation: 'hello'
    }
  end
  let(:valid_word) { FactoryGirl.build(:word, valid_data) }

  it 'has correct field' do
    valid_data.each do |k, v|
      expect(valid_word.send(k)).to eq(v)
    end
  end

  context 'valid?' do
    it 'contains all fields' do
      expect(valid_word).to be_valid
    end
  end
  context 'not valid?' do
    it 'has field is not set' do
      invalid_words = valid_data.map do |k, v|
        FactoryGirl.build(:word, valid_data.merge({k => nil}))
      end
      invalid_words.each do |word|
        expect(word).not_to be_valid
      end
    end
    it 'has long text' do
      expect(FactoryGirl.build(:word, text: Faker::Lorem.characters(51))).not_to be_valid
    end
    it 'has bad from language' do
      expect(FactoryGirl.build(:word, lang_from: Faker::Lorem.characters(5))).not_to be_valid
    end
    it 'has bad to language' do
      expect(FactoryGirl.build(:word, lang_to: Faker::Lorem.characters(5))).not_to be_valid
    end
  end
end
