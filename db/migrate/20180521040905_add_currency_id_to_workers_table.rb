class AddCurrencyIdToWorkersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :workers, :currency_id, :integer
  end
end
