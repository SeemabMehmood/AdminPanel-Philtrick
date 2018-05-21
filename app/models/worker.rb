class Worker < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :electricity_cost, presence: true, numericality: {less_than: 10000}

  has_many :user_workers, dependent: :delete_all
  has_many :users, through: :user_workers

  has_many :deposits
  belongs_to :currency

  PER_PAGE = 10

  attr_accessor :user_id, :action_name

  default_scope { order(created_at: :desc) }
  scope :active, -> { left_outer_joins(:user_workers).where.not(user_workers: { user_id: nil }).uniq }
  scope :offline, -> { left_outer_joins(:user_workers).where(user_workers: { user_id: nil }) }
  scope :get_customer_workers, ->(user_id) { left_outer_joins(:user_workers).where(user_workers: { user_id: user_id }) }

  def add_customer(user_id, worker_count)
    if self.user_exists?(user_id)
      self.user_workers.find_by_user_id(user_id).update_attributes(worker_count: worker_count)
    else
      self.user_workers.create(user_id: user_id, worker_count: worker_count)
    end
  end

  def user_exists?(user_id)
    return true if self.users.pluck(:id).include? user_id
    false
  end

  def remaining_worker_count
    self.total_workers - self.workers_in_use
  end

  def workers_in_use
    return 0 unless self.user_workers.present?
    self.user_workers.map(&:worker_count).sum
  end

  def validate_customers(params)
    return false, "Please select a customer." if params[:user_id].blank?
    return false, "Worker count can neither be blank nor 0" if params[:worker_count].blank? || params[:worker_count] == "0"
    return false, "Worker count is greater than workers left in this group." if params[:worker_count].to_i > self.remaining_worker_count
    true
  end

  def get_income_for_worker_count(user_id, income)
    self.get_customer_workers_count(user_id) * income
  end

  def get_electricity_cost(number_of_deposits)
    self.electricity_cost * number_of_deposits
  end

  def calculate_income(income, btc_price)
    income - (self.electricity_cost / btc_price)
  end

  def get_customer_workers_count(user_id)
    self.user_workers.for_user(user_id).worker_count
  end

  def get_user_net_income(user_id)
    sum_income = 0.0
    self.deposits.each do |deposit|
      sum_income += deposit.deposit_workers.for_user(user_id).sum(:user_income)
    end
    sum_income
  end
end
