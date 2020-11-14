# frozen_string_literal: true

require 'open-uri'
require 'uri'

module DictionaryHelper
  def unique_langs(dict, direction)
    raise Excetion("Unsupported #{direction} parameter") unless %i[to from].include?(direction)

    supported_pairs.map do |code1, code2|
      code = direction == :from ? code1 : code2
      [language_name(dict, code), code]
    end.uniq
  end

  def supported_pairs
    [
      %w[be ru],
      %w[bg ru],
      %w[cs en], %w[cs ru],
      %w[da en], %w[da ru],
      %w[nl en], %w[nl ru],
      %w[en cs], %w[en da], %w[en nl], %w[en et],
      %w[en fi], %w[en fr], %w[en de], %w[en el],
      %w[en it], %w[en lv], %w[en lt], %w[en no],
      %w[en pt], %w[en ru], %w[en sk], %w[en es],
      %w[en sv], %w[en tr], %w[en uk],
      %w[et en], %w[et ru],
      %w[fi en], %w[fi ru],
      %w[fr en], %w[fr ru],
      %w[de en], %w[de ru], %w[de tr],
      %w[el en], %w[el ru],
      %w[it en], %w[it ru],
      %w[lv en], %w[lv ru],
      %w[lt en], %w[lt ru],
      %w[no en], %w[no ru],
      %w[pl ru],
      %w[pt en], %w[pt ru],
      %w[ru be], %w[ru bg], %w[ru cs], %w[ru da],
      %w[ru nl], %w[ru en], %w[ru et], %w[ru fi],
      %w[ru fr], %w[ru de], %w[ru el], %w[ru it],
      %w[ru lv], %w[ru lt], %w[ru no], %w[ru pl],
      %w[ru pt], %w[ru sk], %w[ru es], %w[ru sv],
      %w[ru tr], %w[ru uk],
      %w[sk en], %w[sk ru],
      %w[es en], %w[es ru],
      %w[sv en], %w[sv ru],
      %w[tr en], %w[tr de], %w[tr ru],
      %w[uk en], %w[uk ru]
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
    end.sort_alphabetical_by { |v, _c| v }
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

    def initialize(name, lang_ui = :en)
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
          simplify_translations(json, lang_pair = lang_pair)
        end
      end

      def self.simplify_translations(initial_json, lang_pair = nil)
        trans = []
        initial_json[:def].each do |w|
          w[:tr].each do |tr|
            translation = {
              text: w[:text],
              text_gen: w[:gen],
              pos: w[:pos],
              ts: w[:ts],
              tr: tr[:text],
              tr_gen: tr[:gen]
            }
            translation[:lang_pair] = lang_pair if lang_pair
            trans << translation
            next unless tr[:syn]

            tr[:syn].each do |syn|
              translation = {
                text: w[:text],
                text_gen: w[:gen],
                pos: syn[:pos],
                ts: w[:ts],
                tr: syn[:text],
                tr_gen: syn[:gen]
              }
              translation[:lang_pair] = lang_pair if lang_pair
              trans << translation
            end
          end
        end
        trans
      end
    end
  end
end
