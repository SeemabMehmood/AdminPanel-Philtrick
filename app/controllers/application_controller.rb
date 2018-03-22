class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to users_path, alert: exception.message
  end

  before_action :authenticate_user!

  layout 'admin_lte_2'

  protect_from_forgery with: :exception
end
