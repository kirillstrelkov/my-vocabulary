class DictionaryController < ApplicationController
  include DictionaryHelper
  respond_to :json

  def pairs
    respond_with pairs_for_language(@dict, params['lang_code'])
  end

  def languages
    respond_with @dict.languages
  end

  def lookup
    errors = []
    [:text, :lang_pair].each do |param|
      begin
        params.require(param)
      rescue ActionController::ParameterMissing => e
        errors << e.message
      end
    end
    if errors.empty?
      respond_with @dict.lookup(params['text'], params['lang_pair'])
    else
      render json: {errors: errors}, status: :not_acceptable
    end
  end
end
