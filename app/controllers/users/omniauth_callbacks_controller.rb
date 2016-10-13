class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def vkontakte
    @user = User.from_omniauth(request.env['omniauth.auth'])
    provider = request.env['omniauth.auth'].provider

    set_flash_message(
      :notice, :success, kind: provider.capitalize
    ) if is_navigational_format?
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      # byebug
    else
      # session['devise.omniauth_data'] = request.env['omniauth.auth']
      # byebug
      redirect_to edit_user_registration_path
    end
  end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
