require 'rails_helper'

RSpec.describe CardGeneratorHelper, type: :helper do
  context '#generate_cards' do
    before :all do
      @user = FactoryGirl.create(:random_user)
      @lang_pair = ['de', 'en']
    end

    before :each do
      Word.destroy_all
    end

    it 'returns empty array when 2 words are nouns and 3 words are verbs' do
      data = [
        ['de', 'en', 'hallo', 'hello', 'noun'],
        ['de', 'en', 'hallo', 'hi', 'noun'],
        %w(de en haben have verb),
        %w(de en müssen must verb),
        %w(de en tun do verb),
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      expect(generate_cards(@user)).to be_nil
    end

    it 'returns cards when 4 words are verbs' do
      [
        %w(de en machen make verb),
        %w(de en haben have verb),
        %w(de en müssen must verb),
        %w(de en tun do verb)
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      cards = generate_cards(@user)
      expect(cards).to include(:translations)
      verify_cards(cards)
    end

    it 'returns cards when 4 words are verbs and 2 words are nouns' do
      [
        %w(de en machen make verb),
        %w(de en haben have verb),
        %w(de en müssen must verb),
        %w(de en tun do verb),
        ['de', 'en', 'hallo', 'hello', 'noun'],
        ['de', 'en', 'hallo', 'hi', 'noun'],
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      cards = generate_cards(@user)
      expect(cards).to include(:translations)
      verify_cards(cards)
    end

    it 'returns nil when 4 words and selected word has same translation as in translation words' do
      [
        %w(de en machen make verb),
        %w(de en stellen make verb),
        %w(de en müssen must verb),
        %w(de en tun do verb),
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      (1..100).each do |e|
        expect(generate_cards(@user, Random.new(3))).to be_nil
      end
    end

    it 'returns nil when 4 words and 2 translation words have same translation' do
      data = [
        %w(de en machen make verb),
        %w(de en stellen make verb),
        %w(de en müssen must verb),
        %w(de en tun do verb),
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      expect(generate_cards(@user, Random.new(3))).to be_nil
    end

    it 'returns always something when 2 positions and one with less than 4 words' do
      data = [
        %w(de en machen make verb),
        %w(de en stellen make verb),
        %w(de en müssen must verb),
        %w(de en tun do verb),
      ].each do |lang_code1, lang_code2, text1, text2, pos|
        FactoryGirl.create(
          :word,
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          text1: text1,
          text2: text2,
          pos: pos,
          user_id: @user.id
        )
      end
      expect(generate_cards(@user, Random.new(3))).to be_nil
    end
  end

  def verify_cards(cards)
    word = cards[:word]
    expect(cards[:translations].count).to eq(4)
    translations = cards[:translations] - [word]
    translations.each do |t|
      expect(t.text1).not_to eq(word.text1)
      expect(t.text2).not_to eq(word.text2)
      expect(t.pos).to eq(word.pos)
      expect(t.lang_code1).to eq(word.lang_code1)
      expect(t.lang_code2).to eq(word.lang_code2)
    end
  end
end
