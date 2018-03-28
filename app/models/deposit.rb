class Deposit < ApplicationRecord
  belongs_to :user
  belongs_to :worker

  validates :income, numericality: {less_than_or_equal_to: 100000000}

  scope :get_customer_deposits, ->(user_id) { where(user_id: user_id) }

  before_save :update_customer_income

  private

  def update_customer_income
    user = User.find(self.user_id)
    user.net_income = (user.net_income ? user.net_income : 0.0) + self.income

    worker = Worker.find(self.worker_id)
    worker.net_income = (worker.net_income ? worker.net_income : 0.0) + self.income

    user.save!
    worker.save!
  end
end
