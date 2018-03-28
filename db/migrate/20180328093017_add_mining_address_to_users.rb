class AddMiningAddressToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :mining_address, :string
  end
end
