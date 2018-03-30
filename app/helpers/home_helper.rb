module HomeHelper
  def to_euro(amount)
    amount * 5842.76
  end

  def show_income(income)
    return income if income.present?
    0.0
  end
end
