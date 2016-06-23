class Word < ActiveRecord::Base
  validates :lang_from, :lang_to, :text, :translation, presence: true
  validates :text, length: { maximum: 50 }
  validates :lang_from, :lang_to, inclusion: { in: %w(English German Russian),
                                               message: "'%{value}' is not a valid %in" }
end
