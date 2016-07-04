json.array!(@words) do |word|
  json.extract! word, :id, :lang_code1, :lang_code2, :text1, :text2
  json.url word_url(word, format: :json)
end
