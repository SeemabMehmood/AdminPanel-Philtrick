class UserWorker < ApplicationRecord
  belongs_to :user, inverse_of: :user_workers
  belongs_to :worker, inverse_of: :user_workers
end
