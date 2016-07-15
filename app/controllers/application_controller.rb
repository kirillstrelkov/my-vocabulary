class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init_dictionary

  private

  def init_dictionary
    @dict = DictionaryHelper::Dictionary.new('Yandex', params.fetch('lang', I18n.locale))
  end
end
