# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserController, type: :controller do
  login_user
  before(:each) do
    user = User.first
    user.update_attribute(:score, 0)
    Word.destroy_all
    [%w[de en hallo hello],
     %w[de en machen make],
     %w[de en haben have],
     %w[de en muss must],
     %w[de en tun do]].each do |l1, l2, text1, text2|
      user.words << FactoryBot.create(
        :word,
        lang_code1: l1, lang_code2: l2,
        text1: text1, text2: text2,
        user_id: user.id
      )
    end
  end

  describe 'post #update_score' do
    it 'increases score and word memorized' do
      current_user = User.first
      word = current_user.words.first
      expect(word.memorized).to eq(0)
      expect(current_user.score).to eq(0)
      post :update_score, word_id: word.id, command: 'increase'
      word.reload
      current_user.reload
      expect(word.memorized).to eq(1)
      expect(current_user.score).to eq(1)
    end

    it 'decreases score and word memorized' do
      current_user = User.first
      word = current_user.words.first
      expect(word.memorized).to eq(0)
      expect(current_user.score).to eq(0)
      post :update_score, word_id: word.id, command: 'decrease'
      word.reload
      current_user.reload
      expect(word.memorized).to eq(0)
      expect(current_user.score).to eq(-1)
    end
  end
end
