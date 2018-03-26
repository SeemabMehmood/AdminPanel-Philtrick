class Worker < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :electricity_cost, presence: true, numericality: {less_than_or_equal_to: 999}
  validates :net_income, numericality: {less_than_or_equal_to: 100000000}

  has_many :user_workers, dependent: :delete_all
  has_many :users, through: :user_workers

  attr_accessor :user_id

  def self.initialize_worker(params)
    worker = self.new(params.except(:user_id))
    worker.users << User.find(params[:user_id]) if params[:user_id].present?
    worker
  end

  def add_customers(user_ids)
    user_ids.each do |user_id|
      self.users << User.find(user_id)
    end
  end
end
