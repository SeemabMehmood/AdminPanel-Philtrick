class HomeController < ApplicationController
  def dashboard
    if current_user.admin
      @workers = Worker.all
      @offline_workers = Worker.offline
      @latest_deposits = Deposit.latest
      @chart_data = @latest_deposits.group_by { |d| d.created_at.to_date }
      @daily_deposits = Deposit.for_today.group_by(&:worker)
    else
      @workers = Worker.get_customer_workers(current_user.id)
    end
  end
end
