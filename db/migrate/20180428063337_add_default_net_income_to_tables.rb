class AddDefaultNetIncomeToTables < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :net_income, :decimal, precision: 15, scale: 12, default: 0.0
    change_column :workers, :net_income, :decimal, precision: 15, scale: 12, default: 0.0
    change_column :deposits, :income, :decimal, precision: 15, scale: 12, default: 0.0
  end
end
