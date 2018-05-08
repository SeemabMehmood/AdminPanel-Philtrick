class CreateDepositWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :deposit_workers do |t|
      t.belongs_to :user, index: true
      t.belongs_to :deposit, index: true

      t.integer :worker_count

      t.timestamps
    end
  end
end
