# frozen_string_literal: true

class Word < ActiveRecord::Base
  validates :lang_code1, :lang_code2, :text1, :text2, :user_id, presence: true
  validates :text1, :text2, length: { maximum: 50 }
  validates :lang_code1, :lang_code2, format: { with: /\A[a-z]{2,3}\z/,
                                                message: 'bad language code' }
  validate :uniqness, on: :create
  belongs_to :post

  scope :with_lang_pair, lambda { |pair|
    where(lang_code1: pair, lang_code2: pair)
  }
  self.per_page = 10

  private

  def uniqness
    errors.add('Pair', "'#{text1} - #{text2}'  has already been added") unless Word.with_lang_pair([lang_code1, lang_code2]).where(
      'user_id = (?) and '\
      '(text1 = (?) and text2 = (?) or'\
      ' text2 = (?) and text1 = (?))',
      user_id,
      text1, text2,
      text1, text2
    ).empty?
  end
end
