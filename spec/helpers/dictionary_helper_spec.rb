# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DictionaryHelper, type: :helper do
  let(:dict) { DictionaryHelper::Dictionary.new('Yandex', :en) }
  let(:dict_ru) { DictionaryHelper::Dictionary.new('Yandex', :ru) }
  let(:expected_good_pairs) do
    [
      %w[be ru],
      %w[bg ru],
      %w[cs en],
      %w[cs ru],
      %w[da en],
      %w[da ru],
      %w[nl en],
      %w[nl ru],
      %w[en cs],
      %w[en da],
      %w[en nl],
      %w[en et],
      %w[en fi],
      %w[en fr],
      %w[en de],
      %w[en el],
      %w[en it],
      %w[en lv],
      %w[en lt],
      %w[en no],
      %w[en pt],
      %w[en ru],
      %w[en sk],
      %w[en es],
      %w[en sv],
      %w[en tr],
      %w[en uk],
      %w[et en],
      %w[et ru],
      %w[fi en],
      %w[fi ru],
      %w[fr en],
      %w[fr ru],
      %w[de en],
      %w[de ru],
      %w[de tr],
      %w[el en],
      %w[el ru],
      %w[it en],
      %w[it ru],
      %w[lv en],
      %w[lv ru],
      %w[lt en],
      %w[lt ru],
      %w[no en],
      %w[no ru],
      %w[pl ru],
      %w[pt en],
      %w[pt ru],
      %w[ru be],
      %w[ru bg],
      %w[ru cs],
      %w[ru da],
      %w[ru nl],
      %w[ru en],
      %w[ru et],
      %w[ru fi],
      %w[ru fr],
      %w[ru de],
      %w[ru el],
      %w[ru it],
      %w[ru lv],
      %w[ru lt],
      %w[ru no],
      %w[ru pl],
      %w[ru pt],
      %w[ru sk],
      %w[ru es],
      %w[ru sv],
      %w[ru tr],
      %w[ru uk],
      %w[sk en],
      %w[sk ru],
      %w[es en],
      %w[es ru],
      %w[sv en],
      %w[sv ru],
      %w[tr en],
      %w[tr de],
      %w[tr ru],
      %w[uk en],
      %w[uk ru]
    ]
  end
  let(:expected_bad_pairs) do
    [
      %w[sq en],
      %w[sq ru],
      %w[hy ru],
      %w[az ru],
      %w[be bg],
      %w[be cs],
      %w[be en],
      %w[be fr],
      %w[be de],
      %w[be it],
      %w[be pl],
      %w[be ro],
      %w[be sr],
      %w[be es],
      %w[be tr],
      %w[bg be],
      %w[bg uk],
      %w[ca en],
      %w[ca ru],
      %w[hr ru],
      %w[cs be],
      %w[cs uk],
      %w[en sq],
      %w[en be],
      %w[en ca],
      %w[en hu],
      %w[en mk],
      %w[en sl],
      %w[fr be],
      %w[fr de],
      %w[fr uk],
      %w[de be],
      %w[de fr],
      %w[de it],
      %w[de es],
      %w[de uk],
      %w[hu en],
      %w[hu ru],
      %w[it be],
      %w[it de],
      %w[it uk],
      %w[mk en],
      %w[mk ru],
      %w[pl be],
      %w[pl uk],
      %w[ro be],
      %w[ro ru],
      %w[ro uk],
      %w[ru sq],
      %w[ru hy],
      %w[ru az],
      %w[ru ca],
      %w[ru hr],
      %w[ru hu],
      %w[ru mk],
      %w[ru ro],
      %w[ru sr],
      %w[ru sl],
      %w[sr be],
      %w[sr ru],
      %w[sr uk],
      %w[sl en],
      %w[sl ru],
      %w[es be],
      %w[es de],
      %w[es uk],
      %w[tr be],
      %w[tr uk],
      %w[uk bg],
      %w[uk cs],
      %w[uk fr],
      %w[uk de],
      %w[uk it],
      %w[uk pl],
      %w[uk ro],
      %w[uk sr],
      %w[uk es],
      %w[uk tr]
    ]
  end

  describe 'DictionaryHelper::Dictionary' do
    context '#initialize' do
      describe 'bad parameters' do
        it 'empty string' do
          expect { DictionaryHelper::Dictionary.negw(nil) }.to raise_error NameError
        end

        it 'empty string' do
          expect { DictionaryHelper::Dictionary.new('') }.to raise_error NameError
        end

        it 'weird string' do
          expect { DictionaryHelper::Dictionary.new('dsfsdfdsf') }.to raise_error NameError
        end
      end

      describe 'correct' do
        it 'lowercase' do
          expect(DictionaryHelper::Dictionary.new('yandex')).not_to be_nil
        end

        it 'capitalize' do
          expect(DictionaryHelper::Dictionary.new('Yandex')).not_to be_nil
        end
      end
    end

    describe '#pairs_and_languages' do
      it 'contains English language data' do
        pairs, langs = DictionaryHelper::Dictionary.new('yandex').pairs_and_languages
        expect(pairs).to include('en-ru')
        expect(langs).to include(:en)
        expect(langs[:en]).to eq('English')
      end

      it 'contains Russian language data' do
        pairs, langs = DictionaryHelper::Dictionary.new('yandex', :ru).pairs_and_languages
        expect(pairs).to include('ru-de')
        expect(langs).to include(:ru)
        expect(langs[:en]).to eq('Английский')
      end
    end
  end

  describe 'translation_hash' do
    it 'translate initial json for hello to hash with translations' do
      json = { head: {},
               def: [{ text: 'hello',
                       pos: 'noun',
                       ts: 'ˈheˈləʊ',
                       tr: [{ text: 'привет',
                              pos: 'noun',
                              syn: [{ text: 'приветствие', pos: 'noun', gen: 'ср' }],
                              mean: [{ text: 'hi' }, { text: 'welcome' }],
                              ex: [{ text: 'big hello', tr: [{ text: 'большой привет' }] }] }] },
                     { text: 'hello',
                       pos: 'verb',
                       ts: 'ˈheˈləʊ',
                       tr: [{ text: 'поздороваться',
                              pos: 'verb',
                              asp: 'сов',
                              mean: [{ text: 'greet' }] }] }] }
      trans = DictionaryHelper::Dictionary::Yandex.simplify_translations(json)
      expect(trans).to eq([{ text: 'hello',
                             pos: 'noun',
                             text_gen: nil,
                             tr_gen: nil,
                             ts: 'ˈheˈləʊ',
                             tr: 'привет' },
                           { text: 'hello',
                             pos: 'noun',
                             text_gen: nil,
                             tr_gen: 'ср',
                             ts: 'ˈheˈləʊ',
                             tr: 'приветствие' },
                           { text: 'hello',
                             pos: 'verb',
                             text_gen: nil,
                             tr_gen: nil,
                             ts: 'ˈheˈləʊ',
                             tr: 'поздороваться' }])
    end

    it 'translate initial json for do to hash with translations' do
      json = { head: {},
               def: [{ text: 'do',
                       pos: 'verb',
                       ts: 'duː',
                       tr: [{ text: 'делать',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'выполнять', pos: 'verb', asp: 'несов' },
                                    { text: 'исполнять', pos: 'verb', asp: 'несов' },
                                    { text: 'сделать', pos: 'verb', asp: 'сов' },
                                    { text: 'выполнить', pos: 'verb', asp: 'сов' },
                                    { text: 'совершать', pos: 'verb', asp: 'несов' },
                                    { text: 'проделать', pos: 'verb', asp: 'сов' },
                                    { text: 'поделать', pos: 'verb', asp: 'сов' },
                                    { text: 'устраивать', pos: 'verb', asp: 'несов' }],
                              mean: [{ text: 'make' }, { text: 'perform' }, { text: 'do about it' }],
                              ex: [{ text: 'do good', tr: [{ text: 'делать добро' }] },
                                   { text: 'do the tasks', tr: [{ text: 'выполнять задания' }] },
                                   { text: 'do shopping', tr: [{ text: 'сделать покупки' }] },
                                   { text: 'do the job', tr: [{ text: 'выполнить задание' }] },
                                   { text: 'do exploits', tr: [{ text: 'совершать подвиги' }] },
                                   { text: 'do the work', tr: [{ text: 'проделать работу' }] }] },
                            { text: 'заниматься',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'заняться', pos: 'verb', asp: 'сов' }],
                              mean: [{ text: 'be' }, { text: 'take' }],
                              ex: [{ text: 'do business', tr: [{ text: 'заниматься бизнесом' }] },
                                   { text: 'do the cooking', tr: [{ text: 'заняться стряпней' }] }] },
                            { text: 'поступать',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'поступить', pos: 'verb', asp: 'сов' },
                                    { text: 'подходить', pos: 'verb', asp: 'несов' }],
                              mean: [{ text: 'come' }],
                              ex: [{ text: 'do righteousness', tr: [{ text: 'поступать праведно' }] },
                                   { text: 'do otherwise', tr: [{ text: 'поступить иначе' }] }] },
                            { text: 'осуществлять',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'играть', pos: 'verb', asp: 'несов' },
                                    { text: 'провести', pos: 'verb', asp: 'сов' },
                                    { text: 'проводить', pos: 'verb' }],
                              mean: [{ text: 'carry' }, { text: 'have' }],
                              ex: [{ text: 'do the scene', tr: [{ text: 'играть сцену' }] },
                                   { text: 'do the experiment', tr: [{ text: 'провести эксперимент' }] },
                                   { text: 'doing research', tr: [{ text: 'проводить исследование' }] }] },
                            { text: 'обходиться', pos: 'verb', mean: [{ text: 'manage' }] },
                            { text: 'оказывать',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'render' }] },
                            { text: 'годиться',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'fit' }] },
                            { text: 'творить',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'create' }],
                              ex: [{ text: 'do evil', tr: [{ text: 'творить зло' }] }] },
                            { text: 'действовать',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'вести себя', pos: 'verb' }],
                              mean: [{ text: 'work' }, { text: 'behave' }],
                              ex: [{ text: 'do so', tr: [{ text: 'действовать так' }] }] },
                            { text: 'добиться',
                              pos: 'verb',
                              asp: 'сов',
                              mean: [{ text: 'get' }],
                              ex: [{ text: 'do the trick', tr: [{ text: 'добиться цели' }] }] },
                            { text: 'причинять',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'cause' }] },
                            { text: 'готовить',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'prepare' }] },
                            { text: 'покончить',
                              pos: 'verb',
                              asp: 'сов',
                              syn: [{ text: 'заканчивать', pos: 'verb', asp: 'несов' },
                                    { text: 'кончать', pos: 'verb', asp: 'несов' }],
                              mean: [{ text: 'finish' }, { text: 'end' }] },
                            { text: 'преуспевать',
                              pos: 'verb',
                              asp: 'несов',
                              syn: [{ text: 'процветать', pos: 'verb', asp: 'несов' }],
                              mean: [{ text: 'succeed' }, { text: 'flourish' }] },
                            { text: 'обманывать',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'lie' }] },
                            { text: 'осматривать',
                              pos: 'verb',
                              asp: 'несов',
                              mean: [{ text: 'examine' }] }] },
                     { text: 'do',
                       pos: 'noun',
                       ts: 'duː',
                       tr: [{ text: 'участие',
                              pos: 'noun',
                              gen: 'ср',
                              mean: [{ text: 'part' }] }] }] }
      trans = DictionaryHelper::Dictionary::Yandex.simplify_translations(json)
      expect(trans).to eq(
        [{ text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'делать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'выполнять' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'исполнять' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'сделать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'выполнить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'совершать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'проделать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'поделать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'устраивать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'заниматься' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'заняться' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'поступать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'поступить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'подходить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'осуществлять' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'играть' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'провести' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'проводить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'обходиться' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'оказывать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'годиться' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'творить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'действовать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'вести себя' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'добиться' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'причинять' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'готовить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'покончить' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'заканчивать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'кончать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'преуспевать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'процветать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'обманывать' },
         { text: 'do', text_gen: nil, pos: 'verb', tr_gen: nil, ts: 'duː', tr: 'осматривать' },
         { text: 'do', text_gen: nil, pos: 'noun', tr_gen: 'ср', ts: 'duː', tr: 'участие' }]
      )
    end
  end

  describe '#codes_and_languages' do
    it 'should not contains unsupported languages' do
      codes_and_languages = supported_languages_and_codes(dict)
      codes = codes_and_languages.map { |_l, c| c }
      languages = codes_and_languages.map { |l, _c| l }
      expect(codes).not_to include(:af)
      expect(languages).not_to include('Afrikaans')
    end

    it 'should contain data for english with english locale' do
      languages_and_codes = supported_languages_and_codes(dict)
      expect(languages_and_codes).to include(%w[English en])
      expect(languages_and_codes.count(%w[English en])).to eq(1)
    end

    it 'should contain array for russian with russian locale' do
      languages_and_codes = supported_languages_and_codes(dict_ru)
      expect(languages_and_codes).to include(%w[Русский ru])
      expect(languages_and_codes.count(%w[Русский ru])).to eq(1)
    end
  end

  describe '#language_name' do
    context 'app lang=en' do
      it 'return English for :en' do
        expect(language_name(dict, :en)).to eq('English')
      end

      it 'return Russian for :ru' do
        expect(language_name(dict, :ru)).to eq('Russian')
      end
    end

    context 'app lang=ru' do
      it 'return English for :en' do
        expect(language_name(dict_ru, :en)).to eq('Английский')
      end

      it 'return Russian for :ru' do
        expect(language_name(dict_ru, :ru)).to eq('Русский')
      end
    end
  end

  describe '#language_pair' do
    it 'has en-ru and en-de' do
      locale = :en
      expect(language_pairs(locale)).to include(%w[en ru])
      expect(language_pairs(locale)).to include(%w[en de])
      expect(language_pairs(locale)).not_to include(%w[ru en])
      expect(language_pairs(locale)).not_to include(%w[de en])
    end

    it 'has de-ru and de-en' do
      locale = :de
      expect(language_pairs(locale)).to include(%w[de ru])
      expect(language_pairs(locale)).to include(%w[de en])
      expect(language_pairs(locale)).not_to include(%w[ru de])
      expect(language_pairs(locale)).not_to include(%w[en de])
    end
  end

  describe '#pairs_for_language' do
    context 'english' do
      it 'has czech but not english' do
        codes_and_languages = pairs_for_language(dict, :en)
        expect(codes_and_languages.first).to eq(%w[Czech cs])
        expect(codes_and_languages).not_to include(%w[English en])
      end
    end

    context 'russian' do
      it 'has belorusian but not russian' do
        codes_and_languages = pairs_for_language(dict, :ru)
        expect(codes_and_languages.first).to eq(%w[Belarusian be])
        expect(codes_and_languages).not_to include(%w[Russian ru])
      end
    end

    context 'russian locale' do
      it 'hash last element as estonian' do
        codes_and_languages = pairs_for_language(dict_ru, :en)
        expect(codes_and_languages.last).to eq(%w[Эстонский et])
      end
    end
  end

  # describe '#supported_languages_and_codes and #pairs_for_language' do
  #   it 'should return only supported languages' do
  #     bad_pairs = []
  #     good_pairs = []
  #     supported_languages_and_codes(dict).each do |_, code1|
  #       pairs_for_language(code1).each do |_, code2|
  #         lang_pair = "#{code1}-#{code2}"
  #         lookup = dict.lookup('', lang_pair)
  #         if lookup.empty?
  #           good_pairs << [code1, code2]
  #         else
  #           bad_pairs << [code1, code2]
  #         end
  #       end
  #     end
  #     expect(good_pairs).to eq(expected_good_pairs)
  #     expect(bad_pairs).to eq(expected_bad_pairs)
  #   end
  # end

  describe '#supported_pairs' do
    it 'should return correct pairs' do
      expect(supported_pairs).to eq(expected_good_pairs)
    end

    it 'should NOT return incorrect pairs' do
      expect(supported_pairs).not_to eq(expected_bad_pairs)
    end
  end

  describe '#unique_langs' do
    context 'should return correct pairs' do
      it 'from' do
        langs = unique_langs(dict, :from)
        expect(langs).to include(%w[English en])
        expect(langs.count(%w[English en])).to eq(1)
        expect(langs.first).to eq(%w[Belarusian be])
      end

      it 'to' do
        langs = unique_langs(dict, :to)
        expect(langs).to include(%w[English en])
        expect(langs.count(%w[English en])).to eq(1)
        expect(langs.first).to eq(%w[Russian ru])
      end

      it 'raise exception' do
        expect { unique_langs(dict, :oo) }.to raise_error Exception
      end
    end
  end

  describe '#lookup' do
    it 'return valid object en' do
      obj = dict.lookup('dog', 'en-ru')
      expect(obj).to include(lang_pair: 'en-ru',
                             pos: 'noun',
                             text: 'dog',
                             text_gen: nil,
                             tr: 'собака',
                             tr_gen: 'ж',
                             ts: 'dɔg')
    end
    it 'return valid object de' do
      obj = dict.lookup('pferd', 'de-ru')
      expect(obj).to include(lang_pair: 'de-ru',
                             pos: 'noun',
                             text: 'Pferd',
                             text_gen: 'n',
                             tr: 'лошадь',
                             tr_gen: 'ж',
                             ts: 'pfeːɐ̯t')
      expect(obj).to include(lang_pair: 'de-ru',
                             pos: 'noun',
                             text: 'Pferd',
                             text_gen: 'n',
                             tr: 'конь',
                             tr_gen: 'м',
                             ts: 'pfeːɐ̯t')
    end
  end
end
