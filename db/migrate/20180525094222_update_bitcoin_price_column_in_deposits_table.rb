class UpdateBitcoinPriceColumnInDepositsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :deposits, :bitcoin_price, :decimal, precision: 15, scale: 5, default: 0.0
  end
end
