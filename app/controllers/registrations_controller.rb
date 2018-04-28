class RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication

  def create
    @user = User.new(sign_up_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Customer was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :username, :company_name, :zip, :country, :street_name, :profit_share)
  end
end
