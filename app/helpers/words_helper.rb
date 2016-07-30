module WordsHelper
  def number_of_words
    Word.all.length
  end
  def score
    0
  end
end
