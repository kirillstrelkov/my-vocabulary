require 'rails_helper'

RSpec.describe DictionaryController, type: :controller do

  describe 'GET #languages' do
    it 'returns http success' do
      get :languages, name: 'yandex', format: :json
      expect(response).to have_http_status(:success)
    end

    it 'returns supported languages for English - default' do
      get :languages, name: 'yandex', format: :json
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include(:en)
      expect(json[:en]).to include('English')
    end

    it 'returns supported languages for Russian' do
      get :languages, name: 'yandex', lang_code: 'ru', format: :json
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include(:en)
      expect(json[:en]).to include('Английский')
    end
  end

  describe 'GET #lookup' do
      it 'returns 400 bad request if pair is not supported' do
        get :lookup, name: 'yandex', format: :json, lang_pair: 'en-be', text: 'hello'
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to eq({code: 501, message: 'The specified language is not supported'})
      end

      it 'returns 406 if params are incorrect' do
        get :lookup, name: 'yandex', format: :json
        expect(response.status).to eq(406)
      end

      it 'returns translation for "hallo" from German to English' do
        get :lookup, name: 'yandex', format: :json, lang_pair: 'de-en', text: 'hallo'
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json.first.keys).to include(:lang_pair)
        expect(json.first[:lang_pair]).to include('de-en')

        expect(json.map {|t| t[:tr] }).to include('hello')
      end

      it 'returns translation for "hello" from English to Russian' do
        get :lookup, name: 'yandex', format: :json, lang_pair: 'en-ru', text: 'hello'
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json.first.keys).to include(:lang_pair)
        expect(json.first[:lang_pair]).to include('en-ru')

        expect(json.map {|t| t[:tr] }).to include('привет')
      end

  end

end
