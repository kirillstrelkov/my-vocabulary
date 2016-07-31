require 'open-uri'
require 'uri'

module DictionaryHelper
  def language_pairs(dict, lang_code)
    dict.pairs.select {|p| p.split('-').first == lang_code.to_s}.sort
  end

  def language_name(dict, lang_code)
    Hash[dict.languages][lang_code.to_sym]
  end

  def pairs_for_language(dict, lang_code)
    pairs = language_pairs(dict, lang_code)
    pairs.map do |p|
      code2 = p.split('-').last
      [language_name(dict, code2), code2]
    end.sort_alphabetical_by {|v, c| v}
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
