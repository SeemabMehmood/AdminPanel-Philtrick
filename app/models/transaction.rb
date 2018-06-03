class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :amount, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  default_scope { order(created_at: :desc) }

  STATUS = ["Approved", "Rejected"]

  def pending?
    ['pending', 'Pending'].include? self.status
  end

  def approved?
    ['approved', 'Approved'].include? self.status
  end

  def self.build_new(params, user)
    trans = self.new(amount: params[:amount], date: Date.today, user: user)
    trans.currency = Currency.find_by_code(params[:currency])
    trans
  end
end
