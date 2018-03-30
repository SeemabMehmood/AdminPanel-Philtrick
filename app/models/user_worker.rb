class UserWorker < ApplicationRecord
  belongs_to :user, inverse_of: :user_workers
  belongs_to :worker, inverse_of: :user_workers

  scope :for_user, -> (user_id) { where(user_id: user_id).last }
  scope :for_worker, -> (worker_id) { where(worker_id: worker_id).last }
end
