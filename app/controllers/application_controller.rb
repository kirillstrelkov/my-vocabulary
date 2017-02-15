class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def init
    locale = params.fetch('lang', I18n.locale)
    @dict = DictionaryHelper::Dictionary.new('Yandex', locale)
    set_lang_pair
  end

  def set_lang_pair
    lang_pair = params[:lang_pair]
    if lang_pair && lang_pair.match(/^\w{2,3}-\w{2,3}$/)
      @lang_pair = lang_pair.downcase.split('-')
      session[:lang_pair] = @lang_pair
    elsif session[:lang_pair]
      @lang_pair = session[:lang_pair]
    else
      if @word
        @lang_pair = [@word.lang_code1, @word.lang_code2]
      else
        @lang_pair = [I18n.locale, nil]
      end
      session[:lang_pair] = @lang_pair
    end
    puts @lang_pair
  end
end
