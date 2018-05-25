class HomeController < ApplicationController
  def dashboard
    if current_user.admin
      @workers_count = Worker.all.count
      @customers_count = User.all.count
      @offline_workers = Worker.offline
      @latest_deposits = Deposit.latest
      @chart_data = @latest_deposits.group_by(&:date)
      @daily_deposits = @latest_deposits.group_by { |d| [d.date, d.worker] }
    else
      @customer_workers = Worker.get_customer_workers(current_user)
      @litecoin_workers = @customer_workers.get_currency_workers('LTC')
      @litecoin_income_today = current_user.income_today_for_workers(@litecoin_workers)
      @litecoin_workers_count = @litecoin_workers.exists? ? @litecoin_workers.sum(:worker_count) : 0
      @litecoin_net_income = current_user.ltc_net_income

      @bitcoin_workers = @customer_workers.get_currency_workers('BTC')
      @bitcoin_income_today = current_user.income_today_for_workers(@bitcoin_workers)
      @bitcoin_workers_count = @bitcoin_workers.exists? ? @bitcoin_workers.sum(:worker_count) : 0
      @bitcoin_net_income = current_user.btc_net_income

      @bitcash_workers = @customer_workers.get_currency_workers('BCH')
      @bitcash_income_today = current_user.income_today_for_workers(@bitcash_workers)
      @bitcash_workers_count = @bitcash_workers.exists? ? @bitcash_workers.sum(:worker_count) : 0
      @bitcash_net_income = current_user.bch_net_income
    end
  end
end
