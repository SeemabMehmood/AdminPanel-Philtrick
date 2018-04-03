class ChangeWorkerCountInUserWorkers < ActiveRecord::Migration[5.1]
  def change
    change_column :user_workers, :worker_count, :integer, default: 0
  end
end
