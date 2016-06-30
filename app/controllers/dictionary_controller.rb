class DictionaryController < ApplicationController
  respond_to :json
  before_action :init_dictionary

  # def pairs
  #   respond_with @dict.pairs(params.fetch('lang_code', I18n.locale))
  # end

  def languages
    respond_with @dict.languages(params.fetch('lang_code', I18n.locale))
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
      respond_with @dict.lookup(params['text'], params['lang_pair'], params.fetch('lang_code', I18n.locale))
    else
      render json: {errors: errors}, status: :not_acceptable
    end
  end

  private

  def init_dictionary
    @dict = DictionaryHelper::Dictionary.new(params[:name])
  end
end
