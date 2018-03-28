class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposits do |t|
      t.belongs_to :user, index: true
      t.belongs_to :worker, index: true
      t.decimal :income, precision: 10, scale: 2

      t.timestamps
    end
  end
end
