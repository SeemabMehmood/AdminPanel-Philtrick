class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :currency, index: true

      t.datetime :date
      t.string   :status, default: "pending"
      t.decimal  :amount, precision: 25, scale: 12, default: 0.0

      t.timestamps
    end
  end
end
