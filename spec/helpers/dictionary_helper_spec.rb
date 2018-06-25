require 'rails_helper'

RSpec.describe DictionaryHelper, type: :helper do
  let(:dict) { DictionaryHelper::Dictionary.new('Yandex', :en) }
  let(:dict_ru) { DictionaryHelper::Dictionary.new('Yandex', :ru) }
  let(:expected_good_pairs) do
    [
      ["be", "ru"],
      ["bg", "ru"],
      ["cs", "en"],
      ["cs", "ru"],
      ["da", "en"],
      ["da", "ru"],
      ["nl", "en"],
      ["nl", "ru"],
      ["en", "cs"],
      ["en", "da"],
      ["en", "nl"],
      ["en", "et"],
      ["en", "fi"],
      ["en", "fr"],
      ["en", "de"],
      ["en", "el"],
      ["en", "it"],
      ["en", "lv"],
      ["en", "lt"],
      ["en", "no"],
      ["en", "pt"],
      ["en", "ru"],
      ["en", "sk"],
      ["en", "es"],
      ["en", "sv"],
      ["en", "tr"],
      ["en", "uk"],
      ["et", "en"],
      ["et", "ru"],
      ["fi", "en"],
      ["fi", "ru"],
      ["fr", "en"],
      ["fr", "ru"],
      ["de", "en"],
      ["de", "ru"],
      ["de", "tr"],
      ["el", "en"],
      ["el", "ru"],
      ["it", "en"],
      ["it", "ru"],
      ["lv", "en"],
      ["lv", "ru"],
      ["lt", "en"],
      ["lt", "ru"],
      ["no", "en"],
      ["no", "ru"],
      ["pl", "ru"],
      ["pt", "en"],
      ["pt", "ru"],
      ["ru", "be"],
      ["ru", "bg"],
      ["ru", "cs"],
      ["ru", "da"],
      ["ru", "nl"],
      ["ru", "en"],
      ["ru", "et"],
      ["ru", "fi"],
      ["ru", "fr"],
      ["ru", "de"],
      ["ru", "el"],
      ["ru", "it"],
      ["ru", "lv"],
      ["ru", "lt"],
      ["ru", "no"],
      ["ru", "pl"],
      ["ru", "pt"],
      ["ru", "sk"],
      ["ru", "es"],
      ["ru", "sv"],
      ["ru", "tr"],
      ["ru", "uk"],
      ["sk", "en"],
      ["sk", "ru"],
      ["es", "en"],
      ["es", "ru"],
      ["sv", "en"],
      ["sv", "ru"],
      ["tr", "en"],
      ["tr", "de"],
      ["tr", "ru"],
      ["uk", "en"],
      ["uk", "ru"]
    ]
  end
  let(:expected_bad_pairs) do
    [
      ["sq", "en"],
      ["sq", "ru"],
      ["hy", "ru"],
      ["az", "ru"],
      ["be", "bg"],
      ["be", "cs"],
      ["be", "en"],
      ["be", "fr"],
      ["be", "de"],
      ["be", "it"],
      ["be", "pl"],
      ["be", "ro"],
      ["be", "sr"],
      ["be", "es"],
      ["be", "tr"],
      ["bg", "be"],
      ["bg", "uk"],
      ["ca", "en"],
      ["ca", "ru"],
      ["hr", "ru"],
      ["cs", "be"],
      ["cs", "uk"],
      ["en", "sq"],
      ["en", "be"],
      ["en", "ca"],
      ["en", "hu"],
      ["en", "mk"],
      ["en", "sl"],
      ["fr", "be"],
      ["fr", "de"],
      ["fr", "uk"],
      ["de", "be"],
      ["de", "fr"],
      ["de", "it"],
      ["de", "es"],
      ["de", "uk"],
      ["hu", "en"],
      ["hu", "ru"],
      ["it", "be"],
      ["it", "de"],
      ["it", "uk"],
      ["mk", "en"],
      ["mk", "ru"],
      ["pl", "be"],
      ["pl", "uk"],
      ["ro", "be"],
      ["ro", "ru"],
      ["ro", "uk"],
      ["ru", "sq"],
      ["ru", "hy"],
      ["ru", "az"],
      ["ru", "ca"],
      ["ru", "hr"],
      ["ru", "hu"],
      ["ru", "mk"],
      ["ru", "ro"],
      ["ru", "sr"],
      ["ru", "sl"],
      ["sr", "be"],
      ["sr", "ru"],
      ["sr", "uk"],
      ["sl", "en"],
      ["sl", "ru"],
      ["es", "be"],
      ["es", "de"],
      ["es", "uk"],
      ["tr", "be"],
      ["tr", "uk"],
      ["uk", "bg"],
      ["uk", "cs"],
      ["uk", "fr"],
      ["uk", "de"],
      ["uk", "it"],
      ["uk", "pl"],
      ["uk", "ro"],
      ["uk", "sr"],
      ["uk", "es"],
      ["uk", "tr"]
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
      json = {:head => {},
              :def =>
                  [{:text => "hello",
                    :pos => "noun",
                    :ts => "ˈheˈləʊ",
                    :tr =>
                        [{:text => "привет",
                          :pos => "noun",
                          :syn => [{:text => "приветствие", :pos => "noun", :gen => "ср"}],
                          :mean => [{:text => "hi"}, {:text => "welcome"}],
                          :ex => [{:text => "big hello", :tr => [{:text => "большой привет"}]}]}]},
                   {:text => "hello",
                    :pos => "verb",
                    :ts => "ˈheˈləʊ",
                    :tr =>
                        [{:text => "поздороваться",
                          :pos => "verb",
                          :asp => "сов",
                          :mean => [{:text => "greet"}]}]}]}
      trans = DictionaryHelper::Dictionary::Yandex.simplify_translations(json)
      expect(trans).to eq([{text: 'hello',
                            pos: 'noun',
                            text_gen: nil,
                            tr_gen: nil,
                            ts: "ˈheˈləʊ",
                            tr: 'привет'},
                           {text: 'hello',
                            pos: 'noun',
                            text_gen: nil,
                            tr_gen: "ср",
                            ts: "ˈheˈləʊ",
                            tr: 'приветствие'},
                           {text: 'hello',
                            pos: 'verb',
                            text_gen: nil,
                            tr_gen: nil,
                            ts: "ˈheˈləʊ",
                            tr: 'поздороваться'}])
    end

    it 'translate initial json for do to hash with translations' do
      json = {:head => {},
              :def =>
                  [{:text => "do",
                    :pos => "verb",
                    :ts => "duː",
                    :tr =>
                        [{:text => "делать",
                          :pos => "verb",
                          :asp => "несов",
                          :syn =>
                              [{:text => "выполнять", :pos => "verb", :asp => "несов"},
                               {:text => "исполнять", :pos => "verb", :asp => "несов"},
                               {:text => "сделать", :pos => "verb", :asp => "сов"},
                               {:text => "выполнить", :pos => "verb", :asp => "сов"},
                               {:text => "совершать", :pos => "verb", :asp => "несов"},
                               {:text => "проделать", :pos => "verb", :asp => "сов"},
                               {:text => "поделать", :pos => "verb", :asp => "сов"},
                               {:text => "устраивать", :pos => "verb", :asp => "несов"}],
                          :mean => [{:text => "make"}, {:text => "perform"}, {:text => "do about it"}],
                          :ex =>
                              [{:text => "do good", :tr => [{:text => "делать добро"}]},
                               {:text => "do the tasks", :tr => [{:text => "выполнять задания"}]},
                               {:text => "do shopping", :tr => [{:text => "сделать покупки"}]},
                               {:text => "do the job", :tr => [{:text => "выполнить задание"}]},
                               {:text => "do exploits", :tr => [{:text => "совершать подвиги"}]},
                               {:text => "do the work", :tr => [{:text => "проделать работу"}]}]},
                         {:text => "заниматься",
                          :pos => "verb",
                          :asp => "несов",
                          :syn => [{:text => "заняться", :pos => "verb", :asp => "сов"}],
                          :mean => [{:text => "be"}, {:text => "take"}],
                          :ex =>
                              [{:text => "do business", :tr => [{:text => "заниматься бизнесом"}]},
                               {:text => "do the cooking", :tr => [{:text => "заняться стряпней"}]}]},
                         {:text => "поступать",
                          :pos => "verb",
                          :asp => "несов",
                          :syn =>
                              [{:text => "поступить", :pos => "verb", :asp => "сов"},
                               {:text => "подходить", :pos => "verb", :asp => "несов"}],
                          :mean => [{:text => "come"}],
                          :ex =>
                              [{:text => "do righteousness", :tr => [{:text => "поступать праведно"}]},
                               {:text => "do otherwise", :tr => [{:text => "поступить иначе"}]}]},
                         {:text => "осуществлять",
                          :pos => "verb",
                          :asp => "несов",
                          :syn =>
                              [{:text => "играть", :pos => "verb", :asp => "несов"},
                               {:text => "провести", :pos => "verb", :asp => "сов"},
                               {:text => "проводить", :pos => "verb"}],
                          :mean => [{:text => "carry"}, {:text => "have"}],
                          :ex =>
                              [{:text => "do the scene", :tr => [{:text => "играть сцену"}]},
                               {:text => "do the experiment", :tr => [{:text => "провести эксперимент"}]},
                               {:text => "doing research", :tr => [{:text => "проводить исследование"}]}]},
                         {:text => "обходиться", :pos => "verb", :mean => [{:text => "manage"}]},
                         {:text => "оказывать",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "render"}]},
                         {:text => "годиться",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "fit"}]},
                         {:text => "творить",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "create"}],
                          :ex => [{:text => "do evil", :tr => [{:text => "творить зло"}]}]},
                         {:text => "действовать",
                          :pos => "verb",
                          :asp => "несов",
                          :syn => [{:text => "вести себя", :pos => "verb"}],
                          :mean => [{:text => "work"}, {:text => "behave"}],
                          :ex => [{:text => "do so", :tr => [{:text => "действовать так"}]}]},
                         {:text => "добиться",
                          :pos => "verb",
                          :asp => "сов",
                          :mean => [{:text => "get"}],
                          :ex => [{:text => "do the trick", :tr => [{:text => "добиться цели"}]}]},
                         {:text => "причинять",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "cause"}]},
                         {:text => "готовить",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "prepare"}]},
                         {:text => "покончить",
                          :pos => "verb",
                          :asp => "сов",
                          :syn =>
                              [{:text => "заканчивать", :pos => "verb", :asp => "несов"},
                               {:text => "кончать", :pos => "verb", :asp => "несов"}],
                          :mean => [{:text => "finish"}, {:text => "end"}]},
                         {:text => "преуспевать",
                          :pos => "verb",
                          :asp => "несов",
                          :syn => [{:text => "процветать", :pos => "verb", :asp => "несов"}],
                          :mean => [{:text => "succeed"}, {:text => "flourish"}]},
                         {:text => "обманывать",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "lie"}]},
                         {:text => "осматривать",
                          :pos => "verb",
                          :asp => "несов",
                          :mean => [{:text => "examine"}]}]},
                   {:text => "do",
                    :pos => "noun",
                    :ts => "duː",
                    :tr =>
                        [{:text => "участие",
                          :pos => "noun",
                          :gen => "ср",
                          :mean => [{:text => "part"}]}]}]}
      trans = DictionaryHelper::Dictionary::Yandex.simplify_translations(json)
      expect(trans).to eq(
                           [{:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "делать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "выполнять"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "исполнять"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "сделать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "выполнить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "совершать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "проделать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "поделать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "устраивать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "заниматься"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "заняться"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "поступать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "поступить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "подходить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "осуществлять"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "играть"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "провести"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "проводить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "обходиться"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "оказывать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "годиться"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "творить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "действовать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "вести себя"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "добиться"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "причинять"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "готовить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "покончить"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "заканчивать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "кончать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "преуспевать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "процветать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "обманывать"},
                            {:text => "do", :text_gen => nil, :pos => "verb", :tr_gen => nil, :ts => "duː", :tr => "осматривать"},
                            {:text => "do", :text_gen => nil, :pos => "noun", :tr_gen => "ср", :ts => "duː", :tr => "участие"}]
                       )
    end
  end

  describe '#codes_and_languages' do
    it 'should not contains unsupported languages' do
      codes_and_languages = supported_languages_and_codes(dict)
      codes = codes_and_languages.map {|l, c| c}
      languages = codes_and_languages.map {|l, c| l}
      expect(codes).not_to include(:af)
      expect(languages).not_to include('Afrikaans')
    end

    it 'should contain data for english with english locale' do
      languages_and_codes = supported_languages_and_codes(dict)
      expect(languages_and_codes).to include(%w(English en))
      expect(languages_and_codes.count(%w(English en))).to eq(1)
    end

    it 'should contain array for russian with russian locale' do
      languages_and_codes = supported_languages_and_codes(dict_ru)
      expect(languages_and_codes).to include(%w(Русский ru))
      expect(languages_and_codes.count(%w(Русский ru))).to eq(1)
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
      expect(language_pairs(locale)).to include(%w(en ru))
      expect(language_pairs(locale)).to include(%w(en de))
      expect(language_pairs(locale)).not_to include(%w(ru en))
      expect(language_pairs(locale)).not_to include(%w(de en))
    end

    it 'has de-ru and de-en' do
      locale = :de
      expect(language_pairs(locale)).to include(%w(de ru))
      expect(language_pairs(locale)).to include(%w(de en))
      expect(language_pairs(locale)).not_to include(%w(ru de))
      expect(language_pairs(locale)).not_to include(%w(en de))
    end
  end

  describe '#pairs_for_language' do
    context 'english' do
      it 'has czech but not english' do
        codes_and_languages = pairs_for_language(dict, :en)
        expect(codes_and_languages.first).to eq(%w(Czech cs))
        expect(codes_and_languages).not_to include(%w(English en))
      end
    end

    context 'russian' do
      it 'has belorusian but not russian' do
        codes_and_languages = pairs_for_language(dict, :ru)
        expect(codes_and_languages.first).to eq(%w(Belarusian be))
        expect(codes_and_languages).not_to include(%w(Russian ru))
      end
    end

    context 'russian locale' do
      it 'hash last element as estonian' do
        codes_and_languages = pairs_for_language(dict_ru, :en)
        expect(codes_and_languages.last).to eq(['Эстонский', 'et'])
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
        expect(langs).to include(%w(English en))
        expect(langs.count(%w(English en))).to eq(1)
        expect(langs.first).to eq(%w(Belarusian be))
      end

      it 'to' do
        langs = unique_langs(dict, :to)
        expect(langs).to include(%w(English en))
        expect(langs.count(%w(English en))).to eq(1)
        expect(langs.first).to eq(%w(Russian ru))
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
