class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  after_initialize :setup_password

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end

  private

  def setup_password
    self.password = self.password_confirmation = Devise.friendly_token.first(8) unless self.admin
  end

end
