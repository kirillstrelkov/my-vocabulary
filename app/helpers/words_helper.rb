module WordsHelper
  def format_word(word, lang_code)
    lang_codes = [word.lang_code1, word.lang_code2]
    raise ArgumentError, "Lang code '#{lang_code}' not in #{lang_codes}" unless lang_codes.include?(lang_code)
    text_key = lang_code == word.lang_code1 ? 'text1' : 'text2'
    gender = word["#{text_key}_gender"]
    text = word[text_key]

    if gender && !gender.empty?
      lang_code = lang_code.to_sym
      if lang_code == :de
        subs = { n: 'das', f: 'die', m: 'der' }
        gender = subs[gender.to_sym]
        text = "#{gender} #{text}"
      else
        text = "#{text}(#{gender})"
      end
    end
    text
  end
end
