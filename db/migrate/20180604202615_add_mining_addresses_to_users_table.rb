class AddMiningAddressesToUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ltc_mining_address, :string
    add_column :users, :bch_mining_address, :string
    rename_column :users, :mining_address, :btc_mining_address
  end
end
