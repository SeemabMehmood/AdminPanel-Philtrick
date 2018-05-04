class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :username, :country, :company_name, presence: true
  validates :profit_share, numericality: {less_than_or_equal_to: 100}
  validates :net_income, numericality: {less_than_or_equal_to: 99999999999, message: "must be less than 10 Billion"}

  has_many :user_workers, dependent: :delete_all
  has_many :workers, through: :user_workers

  scope :customers, -> { where(admin: false).order('id desc') }

  attr_accessor :worker_id, :action_name

  after_initialize :setup_password

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end

  def address
    return country_name if street_name.blank?
    [street_name, country_name].join(' - ')
  end

  def add_worker(worker_id, worker_count)
    self.user_workers.create(worker_id: worker_id, worker_count: worker_count)
  end

  def worker_exists?(worker_id)
    return true if self.workers.pluck(:id).include? worker_id
    false
  end

  def validate_workers(params)
    return false, "Worker Already Selected." if self.worker_exists?(params[:worker_id].to_i)
    return false, "Please select a worker." if params[:worker_id].blank?
    return false, "Worker count can neither be blank nor 0" if params[:worker_count].blank? || params[:worker_count] == "0"
    return false, "Worker count is greater than workers left in this group." if params[:worker_count].to_i > Worker.find(params[:worker_id].to_i).remaining_worker_count
    true
  end

  def update_net_income(worker_id, income_amount)
    income = self.net_income ? self.net_income : 0.0
    worker = Worker.find(worker_id)
    self.net_income = income + worker.get_income_for_worker_count(self.id, income_amount) - (worker.electricity_cost * 0.00018)
  end

  def daily_income_for_worker(worker_id)
    worker = Worker.find(worker_id)
    return 0.0 unless Deposit.for_worker_today(worker_id).present?
    worker.get_income_for_worker_count(self.id, Deposit.for_worker_today(worker_id).map(&:income).sum) - (worker.electricity_cost * 0.00018)
  end

  def income_today
    daily_income = 0.0
    self.user_workers.each do |user_worker|
      daily_income += daily_income_for_worker(user_worker.worker_id)
    end
    daily_income
  end

  private

  def setup_password
    return if self.persisted?
    self.confirmed_at = DateTime.now
    self.password = self.password_confirmation = Devise.friendly_token.first(8) unless self.admin
  end

end
