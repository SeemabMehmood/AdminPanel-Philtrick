class Worker < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :electricity_cost, presence: true, numericality: {less_than_or_equal_to: 999}
  validates :net_income, numericality: {less_than_or_equal_to: 100000000}
end
