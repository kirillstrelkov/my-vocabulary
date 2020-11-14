# frozen_string_literal: true

require 'test_helper'

class DictionaryControllerTest < ActionController::TestCase
  test 'should get languages' do
    get :languages
    assert_response :success
  end

  test 'should get lookup' do
    get :lookup
    assert_response :success
  end
end
