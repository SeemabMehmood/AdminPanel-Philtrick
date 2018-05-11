class AddUserIncomeToDepositWorkersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :deposit_workers, :user_income, :decimal, precision: 25, scale: 12
  end
end
