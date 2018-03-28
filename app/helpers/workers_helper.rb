module WorkersHelper
  def back_worker_form_url(action_name, worker)
    return workers_path if action_name == 'index' || worker.new_record?
    worker_path(worker) if action_name == 'show' || action_name.blank?
  end
end
