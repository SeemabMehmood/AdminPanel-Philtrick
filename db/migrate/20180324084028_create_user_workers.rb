class CreateUserWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_workers do |t|
      t.references :user, foreign_key: true
      t.references :worker, foreign_key: true
      t.decimal :net_income, precision: 10, scale: 2

      t.timestamps
    end
  end
end
