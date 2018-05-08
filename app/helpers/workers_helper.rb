module WorkersHelper
  def back_worker_form_url(action_name, worker)
    return workers_path if action_name == 'index' || worker.new_record?
    worker_path(worker) if action_name == 'show' || action_name.blank?
  end

  def show_worker_count(deposit, worker)
    [current_user.admin? ? worker.total_workers : deposit.get_user_worker_count(current_user.id),
      worker.title].join(' x ')
  end
end
