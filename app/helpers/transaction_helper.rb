module TransactionHelper
  def class_for_status(status)
    return 'danger'  if ['rejected', 'Rejected'].include? status
    return 'warning' if ['pending', 'Pending'].include? status
    'success' if ['approved', 'Approved'].include? status
  end

  def transactions_heading
    current_user.admin? ? "Withdrawal Requests" : "Transactions History"
  end
end
