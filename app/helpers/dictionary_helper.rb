require 'open-uri'

module DictionaryHelper
  def language_name(dict, lang_code, lang)
    Hash[codes_and_languages(dict, lang.to_sym).map {|v, c| [c,v]}][lang_code.to_sym]
  end

  def codes_and_languages(dict, lang_code)
    dict.pairs_and_languages(lang_code).last.map do |code, value|
      [value, code]
    end.sort_by {|v, c| v}
  end

  class Dictionary
    include RedisHelper

    def get_data(method, *params)
      key = params.join('_')
      prefix = method.to_s
      data = get(prefix, key)
      unless data
        data = @dict.send(method, *params)
        set(prefix, key, data)
      end
      data
    end


    def initialize(name)
      @dict = Dictionary.const_get(name.capitalize)
    end

    def pairs(lang_code)
      pairs_and_languages(lang_code).first
    end

    def languages(lang_code)
      pairs_and_languages(lang_code).last
    end

    def pairs_and_languages(lang_code)
      data = get_data(__method__, lang_code)
      [data[:dirs], data[:langs]]
    end

    def lookup(text, lang_to_lang, lang_code)
      get_data(__method__, text, lang_to_lang, lang_code)
    end

    module Yandex
      TRNSL_API_KEY = 'trnsl.1.1.20160628T200655Z.c8b724f2b136fa7b.04f68b56a9aaf7bf3e0c8164c3efe063d8f316d7'
      TRNSL_URL = 'https://translate.yandex.net/api/v1.5/tr.json/'

      DICT_API_KEY = 'dict.1.1.20160628T204751Z.71532c0441bb3f56.edcc94822048ae14ba397c5ab1dfab9580077edb'
      DICT_URL = 'https://dictionary.yandex.net/api/v1/dicservice.json/'

      def self.pairs_and_languages(lang_code)
        url = TRNSL_URL + "getLangs?key=#{TRNSL_API_KEY}&ui=#{lang_code}"
        JSON.parse(open(url).read, symbolize_names: true)
      end

      def self.lookup(text, lang_pair, lang_code)
        url = DICT_URL + "lookup?key=#{DICT_API_KEY}&text=#{text}&lang=#{lang_pair}&ui=#{lang_code}"
        simplify_translations(JSON.parse(open(url).read, symbolize_names: true), lang_pair=lang_pair)
      end

      def self.simplify_translations(initial_json, lang_pair=nil)
        trans = []
        initial_json[:def].each do |w|
            w[:tr].each do |tr|
              translation = {
                  text: w[:text],
                  pos: w[:pos],
                  ts: w[:ts],
                  tr: tr[:text]
              }
              translation[:lang_pair] = lang_pair if lang_pair
              trans << translation
              if tr[:syn]
                tr[:syn].each do |syn|
                  translation = {
                      text: w[:text],
                      pos: syn[:pos],
                      ts: w[:ts],
                      tr: syn[:text]
                  }
                  translation[:lang_pair] = lang_pair if lang_pair
                  trans << translation
                end
              end
            end
        end
        trans
      end
    end
  end

end
