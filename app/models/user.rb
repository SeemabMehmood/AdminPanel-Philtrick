class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :username, :country, :company_name, presence: true
  validates :profit_share, numericality: {less_than_or_equal_to: 100}

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
    true
  end
  private

  def setup_password
    return if self.persisted?
    self.password = self.password_confirmation = Devise.friendly_token.first(8) unless self.admin
  end

end
