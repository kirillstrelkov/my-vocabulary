module CardGeneratorHelper
  def find_next_tran(trans, found_trans)
    texts1 = found_trans.map(&:text1).uniq
    texts2 = found_trans.map(&:text2).uniq
    trans.where.not(
      text1: texts1,
      text2: texts2
    ).order('random()').first
  end

  def generate_cards(user, rng=nil, text1=nil)
    words = user.words
    return if words.count.zero?

    min_memorized = words.minimum(:memorized)
    max_memorized = words.maximum(:memorized) + 1
    lang_code1, lang_code2 = @lang_pair
    (min_memorized...max_memorized).each do |mem|
      words.pluck(:pos).uniq.shuffle.each do |pos|
        filtered_words = words.where(
          'pos = (?) and '\
          '(memorized between (?) and (?)) and ' \
          '(lang_code1 = (?) and lang_code2 = (?) or'\
          ' lang_code1 = (?) and lang_code2 = (?))',
          pos,
          min_memorized, mem,
          lang_code1, lang_code2,
          lang_code2, lang_code1
        )

        word = nil
        if text1.nil?
          word = filtered_words.sample(random: rng)
        else
          word = filtered_words.where(text1: text1).first
        end

        continue if word.nil?

        translations = [word]
        3.times do
          next_tran = find_next_tran(filtered_words, translations)
          break if next_tran.nil?
          translations << next_tran
        end

        if translations.length == 4
          translations.shuffle!
          return {
            word: word,
            translations: translations
          }
        end
      end
    end
    flash[:notice] = 'Not enough words to play for this language pair, ' \
                     'please add more words or choose another pair'
    nil
  end
end
