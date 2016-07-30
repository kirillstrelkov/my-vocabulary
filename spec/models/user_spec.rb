require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid' do
    it 'with correct field' do
      user = FactoryGirl.build(:user)
      expect(user).to be_valid
    end
  end

  context 'invalid' do
    it 'with empty name' do
      user = FactoryGirl.build(:user, name: nil)
      expect(user).not_to be_valid
    end
  end

  context 'without words' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has no words' do
      expect(user.words).to be_empty
    end
  end

  context 'with words' do
    let(:user) do
      u = FactoryGirl.create(:user)
      FactoryGirl.create(:word, user_id: u.id)
      FactoryGirl.create(:word, text1: 'my string 1', user_id: u.id)
      FactoryGirl.create(:word, text1: 'my string 2', user_id: u.id)
      FactoryGirl.create(:word, text1: 'my string 3', user_id: u.id)
      u
    end

    it 'has words' do
      expect(user.words.count).to eq(4)
    end
  end
end
