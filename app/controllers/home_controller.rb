class HomeController < ApplicationController
  def dashboard
    if current_user.admin
      @workers = Worker.all
      @offline_workers = Worker.offline
    else
      @workers = Worker.get_customer_workers(current_user.id)
    end
  end
end
