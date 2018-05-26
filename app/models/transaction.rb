class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :amount, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  STATUS = ["Approved", "Pending", "Rejected"]
end
