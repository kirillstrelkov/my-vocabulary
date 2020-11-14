# frozen_string_literal: true

class SessionController < ApplicationController
  include SessionHelper
  def update_lang_pair
    lang_pair = params[:lang_pair]
    status = :failed
    if lang_pair.match(/^\w{2,3}-\w{2,3}$/)
      update_session(:lang_pair, lang_pair.split('-'))
      status = :updated
    end
    render json: { status: status }
  end
end
