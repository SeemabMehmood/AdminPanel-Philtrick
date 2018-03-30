class Deposit < ApplicationRecord
  belongs_to :worker

  validates :income, numericality: {less_than_or_equal_to: 100000000}

  scope :latest, -> { order('created_at desc').first(5) }

  before_save :update_customer_income

  private

  def update_customer_income
    worker = Worker.find(self.worker_id)
    worker.net_income = (worker.net_income ? worker.net_income : 0.0) + self.income
    worker.users.each do |user|
      user.net_income = (user.net_income ? user.net_income : 0.0) + self.income
      user.save!
    end
    worker.save!
  end
end
