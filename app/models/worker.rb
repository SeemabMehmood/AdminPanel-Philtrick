class Worker < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :electricity_cost, presence: true, numericality: {less_than: 10000}

  has_many :user_workers, dependent: :delete_all
  has_many :users, through: :user_workers

  PER_PAGE = 10

  attr_accessor :user_id, :action_name

  scope :active, -> { left_outer_joins(:user_workers).where.not(user_workers: { user_id: nil }).uniq }
  scope :offline, -> { left_outer_joins(:user_workers).where(user_workers: { user_id: nil }) }
  scope :get_customer_workers, ->(user_id) { left_outer_joins(:user_workers).where(user_workers: { user_id: user_id }) }

  def add_customer(user_id, worker_count)
    self.user_workers.create(user_id: user_id, worker_count: worker_count)
  end
end
