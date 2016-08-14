class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init_dictionary
  before_filter :authenticate_user!

  private

  def init_dictionary
    locale = params.fetch('lang', I18n.locale)
    @dict = DictionaryHelper::Dictionary.new('Yandex', locale)
  end
end
