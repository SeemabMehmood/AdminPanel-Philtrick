class Deposit < ApplicationRecord
  belongs_to :worker

  has_many :deposit_workers

  validates :income, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  default_scope { order(created_at: :desc) }
  scope :latest, -> { order('created_at desc').first(5) }
  scope :for_today, -> { where(date: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }
  scope :for_worker, -> (worker_id) { where(worker_id: worker_id) }
  scope :order_by_date, -> { order('date desc') }

  before_create :update_customer_income
  before_destroy :delete_all_incomes

  after_create :create_deposit_workers

  def self.net_income_for_worker_today(worker_id)
    self.for_worker(worker_id).for_today.map(&:income).sum
  end

  def get_user_worker_count(user_id)
    self.deposit_workers.find_by_user_id(user_id).try(:worker_count)
  end

  def user_net_income(user_id)
    self.deposit_workers.for_user(user_id).sum(:user_income)
  end

  private

  def update_customer_income
    worker = Worker.find(self.worker_id)
    self.exchange_rate = worker.currency.price
    self.income = worker.calculate_income(self.income, self.exchange_rate)
    worker.net_income += self.income * worker.workers_in_use
    worker.users.each do |user|
      user.update_net_income(self.worker_id, self.income, worker.currency.code)
      user.save!
    end
    worker.save!
  end

  def create_deposit_workers
    worker = Worker.find(self.worker_id)
    worker.users.each do |user|
      worker_count_for_user = user.get_worker_count(worker.id)
      self.deposit_workers.create(user: user, worker_count: worker_count_for_user,
        user_income: self.income * worker_count_for_user)
    end
  end

  def delete_all_incomes
    worker = Worker.find(self.worker_id)
    worker.net_income -= self.income * worker.workers_in_use

    worker.users.each do |user|
      user.deduct_net_income(self.worker_id, self.income, worker.currency.code)
      user.save!
    end
    worker.save!
  end

end
