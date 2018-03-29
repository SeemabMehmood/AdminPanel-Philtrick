module DepositsHelper
  def back_deposit_form_url(action_name, deposit)
    return deposits_path if action_name == 'index' || deposit.new_record?
    deposit_path(deposit) if action_name == 'show' || action_name.blank?
  end
end
