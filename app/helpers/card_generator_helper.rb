module CardGeneratorHelper
  def generate_cards(user, rng=nil)
    cards = nil
    Word.pluck(:pos).uniq.shuffle.each do |pos|
      words = user.words
      lang_code1, lang_code2 = @lang_pair
      if words.count > 0
        translations = words.where(
          'pos = (?) and (lang_code1 = (?) and lang_code2 = (?) or lang_code1 = (?) and lang_code2 = (?))',
          pos, lang_code1, lang_code2, lang_code2, lang_code1
        )

        unless translations.empty?
          word = translations.sample(random: rng)

          translations = translations.where.not(
            text1: word.text1,
            text2: word.text2
          ).limit(3)

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
