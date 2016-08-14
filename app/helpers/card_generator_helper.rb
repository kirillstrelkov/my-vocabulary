module CardGeneratorHelper
  def generate_cards(user)
    cards = nil
    Word.pluck(:pos).uniq.shuffle.each do |pos|
      words = user.words
      lang_code1, lang_code2 = @lang_pair
      if words.count > 0
        translations = words.where(
          lang_code1: lang_code1,
          lang_code2: lang_code2,
          pos: pos,
        )
        unless translations.empty?
          uniq_text1 = translations.select(:text1).distinct.map(&:text1)
          word = translations.sample
          translations = translations.where(text1: uniq_text1 - [word.text1]).limit(3)
          if translations.length == 3
            translations += [word]
            translations.shuffle!
            cards = {
              word: word,
              translations:  translations
            }
            break
          end
        end
      end
    end
    flash[:notice] = 'Not enough words to play for this language pair, please add more words or choose another pair' if cards.nil? || cards.empty?
    cards
  end
end
