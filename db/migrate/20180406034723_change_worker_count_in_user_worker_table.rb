class ChangeWorkerCountInUserWorkerTable < ActiveRecord::Migration[5.1]
  def change
    change_column :user_workers, :worker_count, :integer, null: false, default: 0
  end
end
