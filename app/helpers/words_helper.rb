module WordsHelper
  def number_of_words
    @user ? @user.words.count : 0
  end
end
