# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Word, type: :model do
  let(:valid_data) do
    {
      lang_code1: 'de',
      lang_code2: 'en',
      text1: 'hallo',
      text2: 'hello',
      user_id: 1
    }
  end
  let(:valid_word) { FactoryGirl.build(:word, valid_data) }
  let(:word_without_user_id) do
    FactoryGirl.build(:word, valid_data.update({ user_id: nil }))
  end

  before :each do
    Word.destroy_all
  end

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
    it 'has user_id not set' do
      expect(word_without_user_id).not_to be_valid
    end
    it 'has field not set' do
      invalid_words = valid_data.map do |k, _v|
        FactoryGirl.build(:word, valid_data.merge({ k => nil }))
      end
      invalid_words.each do |word|
        expect(word).not_to be_valid
      end
    end
    it 'has long text' do
      expect(FactoryGirl.build(:word, valid_data.merge(text1: Faker::Lorem.characters(51)))).not_to be_valid
    end
    it 'has short language code' do
      expect(FactoryGirl.build(:word, valid_data.merge(lang_code1: Faker::Lorem.characters(1)))).not_to be_valid
    end
    it 'has long language code' do
      expect(FactoryGirl.build(:word, valid_data.merge(lang_code2: Faker::Lorem.characters(4)))).not_to be_valid
    end

    it 'is a duplicate' do
      FactoryGirl.create(:word, valid_data)
      expect { FactoryGirl.create(:word, valid_data) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
