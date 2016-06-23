json.array!(@words) do |word|
  json.extract! word, :id, :lang_from, :lang_to, :text, :translation
  json.url word_url(word, format: :json)
end
