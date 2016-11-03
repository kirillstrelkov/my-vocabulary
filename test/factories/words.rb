FactoryGirl.define do
  factory :word do
    lang_code1 'en'
    lang_code2 'ru'
    text1 'my string'
    text2 'my string'
    pos 'noun'
    gender 'm'
    user_id 1
  end
end
