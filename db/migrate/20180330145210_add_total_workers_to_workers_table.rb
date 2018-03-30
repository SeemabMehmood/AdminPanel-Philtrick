class AddTotalWorkersToWorkersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :workers, :total_workers, :integer, null: false, default: 0
  end
end
