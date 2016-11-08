module CardGeneratorHelper
  def generate_cards(user, rng=nil, text1=nil)
    cards = nil
    Word.pluck(:pos).uniq.shuffle.each do |pos|
      words = user.words
      lang_code1, lang_code2 = @lang_pair
      if words.count > 0
        min_memorized = words.minimum(:memorized)
        max_memorized = min_memorized + 1
        translations = words.where(
          'pos = (?) and '\
          '(lang_code1 = (?) and lang_code2 = (?) or'\
          ' lang_code1 = (?) and lang_code2 = (?)) and'\
          ' memorized between (?) and (?)',
          pos,
          lang_code1, lang_code2,
          lang_code2, lang_code1,
          min_memorized, max_memorized
        )

        unless translations.empty?
          word = text1 ? translations.where(text1: text1).first : translations.sample(random: rng)

          translations = translations.where.not(
            text1: word.text1,
            text2: word.text2
          ).order('random()')
          limited_translations = translations.limit(3)

          if limited_translations.pluck(:text2).uniq.length != 3
            limited_translations = limited_translations.to_a
            limited_translations.each do |t|
              if limited_translations.count {|lt| lt.text2 == t.text2} != 1
                limited_translations.delete(t)
              end
            end
            limited_translations += translations.where.not(
              text1: word.text1,
              text2: limited_translations.map(&:text2)
            ).limit(3 - limited_translations.length)
          end

          if limited_translations.length == 3
            limited_translations += [word]
            limited_translations.shuffle!
            cards = {
              word: word,
              translations:  limited_translations
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
