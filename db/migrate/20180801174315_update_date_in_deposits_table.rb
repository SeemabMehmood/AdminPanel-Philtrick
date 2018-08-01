class UpdateDateInDepositsTable < ActiveRecord::Migration[5.1]
  def change
    change_column :deposits, :date, :date, null: false
  end

  def change
    change_column :deposits, :date, :date
  end
end
