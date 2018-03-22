class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :username, :country, :company_name, presence: true
  validates :profit_share, numericality: {less_than_or_equal_to: 100}
  validates :net_income, numericality: {less_than_or_equal_to: 100000000}, allow_nil: true

  after_initialize :setup_password

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end

  def address
    return country_name if street_name.blank?
    [street_name, country_name].join(' - ')
  end

  private

  def setup_password
    self.password = self.password_confirmation = Devise.friendly_token.first(8) unless self.admin
  end

end
