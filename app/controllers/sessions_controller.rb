class SessionsController < Devise::SessionsController
  prepend_before_action :captcha_valid, only: [:create]
  skip_before_action    :verify_authenticity_token, only: :create

  layout 'admin_lte_2_login'

  private

  def captcha_valid
    return true if verify_recaptcha
    redirect_to new_user_session_path, alert: "Recaptcha not verified"
  end
end
