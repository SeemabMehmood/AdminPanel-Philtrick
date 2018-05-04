class AddBitcoinPriceAndDateToDepositsTable < ActiveRecord::Migration[5.1]
  def change
    add_column :deposits, :bitcoin_price, :decimal, precision: 15, scale: 12, default: 0.0
    add_column :deposits, :date, :date
  end
end
