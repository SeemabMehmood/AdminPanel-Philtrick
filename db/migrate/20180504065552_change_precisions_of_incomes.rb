class ChangePrecisionsOfIncomes < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :net_income, :decimal, precision: 25, scale: 12
    change_column :workers, :net_income, :decimal, precision: 25, scale: 12
    change_column :deposits, :income, :decimal, precision: 25, scale: 12
    change_column :deposits, :bitcoin_price, :decimal, precision: 18, scale: 8
  end

  def down
    change_column :users, :net_income, :decimal, precision: 15, scale: 12
    change_column :workers, :net_income, :decimal, precision: 15, scale: 12
    change_column :deposits, :income, :decimal, precision: 15, scale: 12
  end
end
