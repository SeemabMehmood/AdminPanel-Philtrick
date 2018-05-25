class AddColumnPriceInCurrenciesTable < ActiveRecord::Migration[5.1]
  def change
    add_column :currencies, :price, :decimal, precision: 15, scale: 5, default: 0.0
  end
end
