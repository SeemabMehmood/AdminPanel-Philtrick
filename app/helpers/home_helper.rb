module HomeHelper
  def to_btc(amount)
    amount * 0.00013
  end

  def show_income(income)
    return income if income.present?
    0.0
  end
end
