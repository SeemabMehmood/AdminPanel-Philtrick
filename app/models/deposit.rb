class Deposit < ApplicationRecord
  belongs_to :worker

  has_many :deposit_workers

  validates :income, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}
  validates :bitcoin_price, numericality: {less_than_or_equal_to: 9999999999, message: "must be less than 1 Billion"}

  scope :latest, -> { order('created_at desc').first(5) }
  scope :for_today, -> { where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :for_worker, -> (worker_id) { where(worker_id: worker_id) }
  scope :order_by_date, -> { order('date desc') }

  before_create :update_customer_income

  after_create :create_deposit_workers

  def self.net_income_for_worker_today(worker_id)
    self.for_worker(worker_id).for_today.map(&:income).sum
  end

  def get_user_worker_count(user_id)
    self.deposit_workers.for_user(user_id).last.try(:worker_count)
  end

  private

  def update_customer_income
    worker = Worker.find(self.worker_id)
    self.income = worker.calculate_income(self.income, self.bitcoin_price)
    worker.net_income += self.income * worker.total_workers
    worker.users.each do |user|
      user.update_net_income(self.worker_id, self.income, self.bitcoin_price)
      user.save!
    end
    worker.save!
  end

  def create_deposit_workers
    worker = Worker.find(self.worker_id)
    worker.users.each do |user|
      self.deposit_workers.create(user: user, worker_count: user.get_worker_count(worker.id))
    end
  end
end
