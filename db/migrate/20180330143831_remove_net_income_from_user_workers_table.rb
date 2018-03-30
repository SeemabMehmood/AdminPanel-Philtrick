class RemoveNetIncomeFromUserWorkersTable < ActiveRecord::Migration[5.1]
  def up
    remove_column :user_workers, :net_income, :decimal
  end

  def down
    add_column :user_workers, :net_income, :decimal, precision: 10, scale: 2
  end
end
