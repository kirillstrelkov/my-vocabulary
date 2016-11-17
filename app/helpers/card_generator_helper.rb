module CardGeneratorHelper
  def generate_cards(user, rng=nil, text1=nil)
    cards = nil
    words = user.words
    return cards if words.count.zero?
    min_memorized = words.minimum(:memorized)
    max_memorized = words.maximum(:memorized) + 1
    lang_code1, lang_code2 = @lang_pair
    (min_memorized...max_memorized).each do |mem|
      Word.pluck(:pos).uniq.shuffle.each do |pos|
        translations = words.where(
          'pos = (?) and '\
          '(lang_code1 = (?) and lang_code2 = (?) or'\
          ' lang_code1 = (?) and lang_code2 = (?))',
          pos,
          lang_code1, lang_code2,
          lang_code2, lang_code1,
        )

        unless translations.empty?
          word = nil
          if text1.nil?
            word = translations.where(
              'memorized between (?) and (?)',
              min_memorized, mem
            ).sample(random: rng)
          else
            word = translations.where(text1: text1).first
          end

          break if word.nil?

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
