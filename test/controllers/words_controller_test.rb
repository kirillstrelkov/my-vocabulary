# frozen_string_literal: true

require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  setup do
    @word = words(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:words)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create word' do
    assert_difference('Word.count') do
      post :create, word: { lang_code1: @word.lang_from, lang_code2: @word.lang_to, text1: @word.text, text2: @word.translation }
    end

    assert_redirected_to word_path(assigns(:word))
  end

  test 'should show word' do
    get :show, id: @word
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @word
    assert_response :success
  end

  test 'should update word' do
    patch :update, id: @word, word: { lang_code1: @word.lang_from, lang_code2: @word.lang_to, text1: @word.text, text2: @word.translation }
    assert_redirected_to word_path(assigns(:word))
  end

  test 'should destroy word' do
    assert_difference('Word.count', -1) do
      delete :destroy, id: @word
    end

    assert_redirected_to words_path
  end
end
