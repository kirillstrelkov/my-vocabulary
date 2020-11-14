# frozen_string_literal: true

FactoryBot.define do
  factory :word do
    lang_code1 { 'en' }
    lang_code2 { 'ru' }
    text1 { 'my string' }
    text2 { 'my string' }
    pos { 'noun' }
    text1_gender nil
    text2_gender { 'm' }
    user_id { 1 }
    memorized { 0 }
  end
end
