class Currency < ApplicationRecord
  has_many :workers

  validates :price, numericality: {less_than_or_equal_to: 9999999999, message: "must be less than 1 Billion"}
end
