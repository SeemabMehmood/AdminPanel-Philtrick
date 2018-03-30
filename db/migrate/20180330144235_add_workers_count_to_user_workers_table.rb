class AddWorkersCountToUserWorkersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :user_workers, :worker_count, :integer
  end
end
