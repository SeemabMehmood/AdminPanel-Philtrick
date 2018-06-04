module TransactionHelper
  def class_for_status(status)
    return 'danger'  if ['rejected', 'Rejected'].include? status
    return 'warning' if ['pending', 'Pending'].include? status
    'success' if ['approved', 'Approved'].include? status
  end

  def transactions_heading
    current_user.admin? ? "Withdrawal Requests" : "Transactions History"
  end

  def show_respective_mining_address(user, currency)
    return user.btc_mining_address? ? user.btc_mining_address : "Not Found" if currency.code == 'BTC'
    return user.ltc_mining_address? ? user.ltc_mining_address : "Not Found" if currency.code == 'LTC'
    user.bch_mining_address? ? user.bch_mining_address : "Not Found" if currency.code == 'BCH'
  end
end
