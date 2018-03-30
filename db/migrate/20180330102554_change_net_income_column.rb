class ChangeNetIncomeColumn < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :net_income, :decimal, precision: 15, scale: 12
    change_column :workers, :net_income, :decimal, precision: 15, scale: 12
    change_column :deposits, :income, :decimal, precision: 15, scale: 12
  end
end
