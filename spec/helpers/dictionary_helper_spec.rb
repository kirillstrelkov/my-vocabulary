require 'rails_helper'

RSpec.describe DictionaryHelper, type: :helper do
  let(:dict) { DictionaryHelper::Dictionary.new('Yandex') }

  describe 'DictionaryHelper::Dictionary' do
    context '#initialize' do
      describe 'bad parameters' do
        it 'empty string' do
          expect { DictionaryHelper::Dictionary.new(nil) }.to raise_error NameError
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

    describe '#languages' do
      it 'contains English language data' do
        pairs, langs = DictionaryHelper::Dictionary.new('yandex').pairs_and_languages('en')
        expect(pairs).to include('en-ru')
        expect(langs).to include(:en)
        expect(langs[:en]).to eq('English')
      end

      it 'contains Russian language data' do
        pairs, langs = DictionaryHelper::Dictionary.new('yandex').pairs_and_languages('ru')
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
                            ts: "ˈheˈləʊ",
                            tr: 'привет'},
                           {text: 'hello',
                            pos: 'noun',
                            ts: "ˈheˈləʊ",
                            tr: 'приветствие'},
                           {text: 'hello',
                            pos: 'verb',
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
                           [{:text => "do", :pos => "verb", :ts => "duː", :tr => "делать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "выполнять"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "исполнять"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "сделать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "выполнить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "совершать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "проделать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "поделать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "устраивать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "заниматься"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "заняться"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "поступать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "поступить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "подходить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "осуществлять"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "играть"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "провести"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "проводить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "обходиться"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "оказывать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "годиться"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "творить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "действовать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "вести себя"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "добиться"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "причинять"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "готовить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "покончить"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "заканчивать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "кончать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "преуспевать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "процветать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "обманывать"},
                            {:text => "do", :pos => "verb", :ts => "duː", :tr => "осматривать"},
                            {:text => "do", :pos => "noun", :ts => "duː", :tr => "участие"}]
                       )
    end
  end

  describe '#codes_and_languages' do
    it 'should contain data for english with english locate' do
      expect(codes_and_languages(dict, :en)).to include(['English', :en])
    end

    it 'should contain array for russian with russian locale' do
      expect(codes_and_languages(dict, :ru)).to include(['Русский', :ru])
    end
  end

  describe '#language_name' do
    context 'app lang=en' do
      it 'return English for :en' do
        expect(language_name(dict, :en, :en)).to eq('English')
      end

      it 'return Russian for :ru' do
        expect(language_name(dict, :ru, :en)).to eq('Russian')
      end
    end

    context 'app lang=ru' do
      it 'return English for :en' do
        expect(language_name(dict, :en, :ru)).to eq('Английский')
      end

      it 'return Russian for :ru' do
        expect(language_name(dict, :ru, :ru)).to eq('Русский')
      end
    end
  end

  describe '#language_pair' do
    it 'has en-ru and en-de' do
      locale = :en
      expect(language_pairs(dict, locale)).to include('en-ru')
      expect(language_pairs(dict, locale)).to include('en-de')
      expect(language_pairs(dict, locale)).not_to include('ru-en')
      expect(language_pairs(dict, locale)).not_to include('de-en')
    end

    it 'has de-ru and de-en' do
      locale = :de
      expect(language_pairs(dict, locale)).to include('de-ru')
      expect(language_pairs(dict, locale)).to include('de-en')
      expect(language_pairs(dict, locale)).not_to include('ru-de')
      expect(language_pairs(dict, locale)).not_to include('en-de')
    end
  end

  describe '#language_pairs_with_codes_and_languages' do
    it 'has en-ru and en-de' do
      locale = :en
      codes_and_languages = pairs_for_language(dict, locale)
      expect(codes_and_languages.first).to eq(['Belarusian', 'be'])
      expect(codes_and_languages).not_to include(['English', 'en'])
    end
  end

end
