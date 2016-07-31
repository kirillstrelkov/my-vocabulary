module WordsHelper
  def number_of_words
    Word.all.length
  end
end
