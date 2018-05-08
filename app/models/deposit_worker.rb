class DepositWorker < ApplicationRecord
  belongs_to :deposit
  belongs_to :user

  scope :for_user, -> (user_id) { where(user_id: user_id) }
end
