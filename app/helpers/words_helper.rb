module WordsHelper
  def format_text(word, text)
    gender = word["#{text}_gender"]
    lang_code = word["lang_code#{text.to_s[/\d+/]}"].to_sym
    text = word[text.to_s]
    if gender && !gender.empty?
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
