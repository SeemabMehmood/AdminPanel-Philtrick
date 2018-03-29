class CreateWorkers < ActiveRecord::Migration[5.1]
  def change
    create_table :workers do |t|
      t.string :title, null: false, default: ""
      t.text :description
      t.decimal :electricity_cost, precision: 5, scale: 2, null: false, default: 0.0
      t.decimal :net_income, precision: 10, scale: 2

      t.timestamps
    end
    add_index :workers, :title, unique: true
  end
end
