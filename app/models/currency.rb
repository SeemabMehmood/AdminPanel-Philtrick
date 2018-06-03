class Currency < ApplicationRecord
  has_many :workers
  has_many :transactions

  validates :price, numericality: {less_than_or_equal_to: 9999999999, message: "must be less than 1 Billion"}

  def self.bitcoin_rate
    find_by_code('BTC').price.to_f
  end

  def self.litcoin_rate
    find_by_code('LTC').price.to_f
  end

  def self.bitcash_rate
    find_by_code('BCH').price.to_f
  end
end
