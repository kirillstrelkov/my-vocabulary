module WordsHelper
  def format_text(word, text)
    lang_code = word.send("lang_code#{text.to_s[/\d+/]}").to_sym
    gender = word.send("#{text}_gender")
    text = word.send(text.to_s)
    if gender
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
