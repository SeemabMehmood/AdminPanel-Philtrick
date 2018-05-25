class AddCurrencyIncomeColumnsToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :btc_net_income, :decimal, precision: 25, scale: 12, default: 0.0
    add_column :users, :ltc_net_income, :decimal, precision: 25, scale: 12, default: 0.0
    add_column :users, :bch_net_income, :decimal, precision: 25, scale: 12, default: 0.0
  end
end
