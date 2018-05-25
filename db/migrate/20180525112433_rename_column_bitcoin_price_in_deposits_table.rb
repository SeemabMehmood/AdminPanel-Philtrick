class RenameColumnBitcoinPriceInDepositsTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :deposits, :bitcoin_price, :exchange_rate
  end
end
