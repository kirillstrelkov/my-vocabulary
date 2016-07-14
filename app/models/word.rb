class Word < ActiveRecord::Base
  validates :lang_code1, :lang_code2, :text1, :text2, presence: true
  validates :text1, :text2, length: { maximum: 50 }
  validates :lang_code1, :lang_code2, format: { with: /\A[a-z]{2,3}\z/,
                                                message: 'bad language code' }
  validate :uniqness, on: :create

  private
  def uniqness
    errors.add('Pair', "'#{text1} - #{text2}'  has already been added") if Word.find_by({text1: text1, text2: text2, lang_code1: lang_code1, lang_code2: lang_code2})
  end
end
