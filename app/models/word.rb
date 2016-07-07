class Word < ActiveRecord::Base
  validates :lang_code1, :lang_code2, :text1, :text2, presence: true
  validates :text1, :text2, length: { maximum: 50 }
  validates :lang_code1, :lang_code2, format: { with: /\A[a-z]{2,3}\z/,
                                                message: 'bad language code' }
  validates_uniqueness_of :text1, scope: [:text2, :lang_code1, :lang_code2]
end
