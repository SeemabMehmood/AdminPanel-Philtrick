class HomeController < ApplicationController
  def dashboard
    if current_user.admin
      @workers = Worker.all
      @offline_workers = Worker.offline
      @latest_deposits = Deposit.latest
    else
      @workers = Worker.get_customer_workers(current_user.id)
      @latest_deposits = Deposit.get_customer_deposits(current_user.id).latest
    end
    @chart_data = @latest_deposits.group_by { |d| d.created_at.to_date }
  end
end
