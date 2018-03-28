module UsersHelper
  def get_selected_country(user)
    user.country if user.new_record?
  end

  def form_submit_text(form_object, object_type)
    form_object.persisted? ? "Update #{object_type}" : "Add #{object_type}"
  end

  def back_user_form_url(action_name)
    return users_path if action_name == 'index'
    current_user if action_name == 'show' || action_name.blank?
  end

  def back_user_show_url
    return users_path if current_user.admin
    authenticated_root_path
  end

  def back_worker_form_url(action_name, worker)
    return workers_path if action_name == 'index'
    worker_path(worker) if action_name == 'show' || action_name.blank?
  end
end
