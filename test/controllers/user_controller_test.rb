# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test 'should get update' do
    get :update
    assert_response :success
  end
end
