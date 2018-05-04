class HomeController < ApplicationController
  def dashboard
    if current_user.admin
      @workers = Worker.all
      @offline_workers = Worker.offline
      @latest_deposits = Deposit.latest
      @chart_data = @latest_deposits.group_by(&:date)
      @daily_deposits = Deposit.for_today.group_by(&:worker)
    else
      @workers_count = current_user.user_workers.sum(:worker_count)
    end
  end
end
