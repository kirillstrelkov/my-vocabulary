require 'open-uri'
require 'uri'

module DictionaryHelper
  def unique_langs(dict, direction)
    raise Excetion("Unsupported #{direction} parameter") unless [:to, :from].include?(direction)
    supported_pairs.map do |code1, code2|
      code = direction == :from ? code1 : code2
      [language_name(dict, code), code]
    end.uniq
  end

  def supported_pairs
    [
      ["be", "ru"],
      ["bg", "ru"],
      ["cs", "en"], ["cs", "ru"],
      ["da", "en"], ["da", "ru"],
      ["nl", "en"], ["nl", "ru"],
      ["en", "cs"], ["en", "da"], ["en", "nl"], ["en", "et"],
      ["en", "fi"], ["en", "fr"], ["en", "de"], ["en", "el"],
      ["en", "it"], ["en", "lv"], ["en", "lt"], ["en", "no"],
      ["en", "pt"], ["en", "ru"], ["en", "sk"], ["en", "es"],
      ["en", "sv"], ["en", "tr"], ["en", "uk"],
      ["et", "en"], ["et", "ru"],
      ["fi", "en"], ["fi", "ru"],
      ["fr", "en"], ["fr", "ru"],
      ["de", "en"], ["de", "ru"], ["de", "tr"],
      ["el", "en"], ["el", "ru"],
      ["it", "en"], ["it", "ru"],
      ["lv", "en"], ["lv", "ru"],
      ["lt", "en"], ["lt", "ru"],
      ["no", "en"], ["no", "ru"],
      ["pl", "ru"],
      ["pt", "en"], ["pt", "ru"],
      ["ru", "be"], ["ru", "bg"], ["ru", "cs"], ["ru", "da"],
      ["ru", "nl"], ["ru", "en"], ["ru", "et"], ["ru", "fi"],
      ["ru", "fr"], ["ru", "de"], ["ru", "el"], ["ru", "it"],
      ["ru", "lv"], ["ru", "lt"], ["ru", "no"], ["ru", "pl"],
      ["ru", "pt"], ["ru", "sk"], ["ru", "es"], ["ru", "sv"],
      ["ru", "tr"], ["ru", "uk"],
      ["sk", "en"], ["sk", "ru"],
      ["es", "en"], ["es", "ru"],
      ["sv", "en"], ["sv", "ru"],
      ["tr", "en"], ["tr", "de"], ["tr", "ru"],
      ["uk", "en"], ["uk", "ru"]
    ]
  end

  def language_pairs(lang_code)
    supported_pairs.select { |code1, _| code1 == lang_code.to_s }.sort
  end

  def language_name(dict, lang_code)
    Hash[dict.languages][lang_code.to_sym]
  end

  def pairs_for_language(dict, lang_code)
    language_pairs(lang_code).map do |_, code2|
      [language_name(dict, code2), code2]
    end.sort_alphabetical_by do |v, _|
      v
    end
  end

  def supported_languages_and_codes(dict)
    dict.pairs.map do |pair|
      pair.split('-').first
    end.uniq.map do |code|
      [language_name(dict, code), code]
    end.sort_alphabetical_by {|v, c| v}
  end

  class Dictionary
    include RedisHelper

    attr_accessor :lang_ui

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


    def initialize(name, lang_ui=:en)
      @dict = Dictionary.const_get(name.capitalize)
      @lang_ui = lang_ui
    end

    def pairs
      pairs_and_languages.first
    end

    def languages
      pairs_and_languages.last
    end

    def pairs_and_languages
      data = get_data(__method__, @lang_ui)
      [data[:dirs], data[:langs]]
    end

    def lookup(text, lang_to_lang)
      get_data(__method__, text, lang_to_lang, @lang_ui)
    end

    module Yandex
      TRNSL_API_KEY = ENV['YANDEX_TRNSL_API_KEY']
      TRNSL_URL = 'https://translate.yandex.net/api/v1.5/tr.json/'

      DICT_API_KEY = ENV['YANDEX_DICT_API_KEY']
      DICT_URL = 'https://dictionary.yandex.net/api/v1/dicservice.json/'

      def self.pairs_and_languages(lang_ui)
        url = TRNSL_URL + "getLangs?key=#{TRNSL_API_KEY}&ui=#{lang_ui}"

        Rails.logger.debug("#{self}##{__method__}: #{url}")

        JSON.parse(open(URI.encode(url)).read, symbolize_names: true)
      end

      def self.lookup(text, lang_pair, lang_ui)
        url = DICT_URL + "lookup?key=#{DICT_API_KEY}&text=#{text}&lang=#{lang_pair}&ui=#{lang_ui}"

        Rails.logger.debug("#{self}##{__method__}: #{url}")

        begin
          json = JSON.parse(open(URI.encode(url)).read, symbolize_names: true)
        rescue OpenURI::HTTPError => e
          Rails.logger.debug("HTTPError status: #{e.io.status}")
          Rails.logger.debug("HTTPError string: #{e.io.string}")
          json = JSON.parse(e.io.string, symbolize_names: true)
        end
        if json.include?(:code)
          json
        else
          simplify_translations(json, lang_pair=lang_pair)
        end
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
