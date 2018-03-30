class Deposit < ApplicationRecord
  belongs_to :worker

  validates :income, numericality: {less_than_or_equal_to: 100000000}

  scope :latest, -> { order('created_at desc').first(5) }
  scope :for_today, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :for_worker_today, -> (worker_id) { where(worker_id: worker_id).for_today }

  before_save :update_customer_income

  def self.net_income_for_worker_today(worker_id)
    for_worker_today(worker_id).map(&:income).sum
  end

  private

  def update_customer_income
    worker = Worker.find(self.worker_id)
    worker.net_income = (worker.net_income ? worker.net_income : 0.0) + self.income
    worker.users.each do |user|
      user.update_net_income(self.worker_id, self.income)
      user.save!
    end
    worker.save!
  end
end
