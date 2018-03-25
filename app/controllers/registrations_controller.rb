class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  private
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :username, :company_name, :zip, :country, :street_name, :profit_share, :net_income, :worker_id)
  end
end
