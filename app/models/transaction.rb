class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :amount, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  default_scope { order(created_at: :desc) }
  scope :for_user, -> (user_id) { includes(:user).where(user_id: user_id) }

  STATUS = ["Approved", "Rejected"]

  def pending?
    ['pending', 'Pending'].include? self.status
  end

  def approved?
    ['approved', 'Approved'].include? self.status
  end
end
