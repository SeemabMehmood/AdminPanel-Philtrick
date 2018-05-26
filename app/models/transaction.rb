class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :amount, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  default_scope { order(created_at: :desc) }

  STATUS = ["Approved", "Pending", "Rejected"]

  def is_pending?
    ['pending', 'Pending'].include? self.status
  end
end
