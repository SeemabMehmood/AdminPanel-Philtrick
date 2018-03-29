class UserWorker < ApplicationRecord
  validates :net_income, numericality: {less_than_or_equal_to: 100000000}, allow_nil: true

  belongs_to :user, inverse_of: :user_workers
  belongs_to :worker, inverse_of: :user_workers
end
