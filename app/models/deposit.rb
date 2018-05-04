class Deposit < ApplicationRecord
  belongs_to :worker

  validates :income, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}
  validates :bitcoin_price, numericality: {less_than_or_equal_to: 9999999999, message: "must be less than 1 Billion"}

  scope :latest, -> { order('created_at desc').first(5) }
  scope :for_today, -> { where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :for_worker, -> (worker_id) { where(worker_id: worker_id) }

  before_create :update_customer_income

  def self.net_income_for_worker_today(worker_id)
    self.for_worker(worker_id).for_today.map(&:income).sum
  end

  private

  def update_customer_income
    worker = Worker.find(self.worker_id)
    self.income = worker.calculate_income(self.income, self.bitcoin_price)
    worker.net_income += self.income
    worker.users.each do |user|
      user.update_net_income(self.worker_id, self.income, self.bitcoin_price)
      user.save!
    end
    worker.save!
  end
end
