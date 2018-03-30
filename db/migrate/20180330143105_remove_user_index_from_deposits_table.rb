class RemoveUserIndexFromDepositsTable < ActiveRecord::Migration[5.1]
  def change
    remove_reference :deposits, :user, index: true
  end
end
