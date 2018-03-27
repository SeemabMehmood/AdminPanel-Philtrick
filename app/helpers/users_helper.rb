module UsersHelper
  def get_selected_country(user)
    user.country if user.new_record?
  end

  def form_submit_text(form_object)
    form_object.persisted? ? "Update Customer" : "Add Customer"
  end

  def back_user_url(action_name=nil)
    if action_name.present? && action_name == 'edit'
      current_user.admin ? users_path : current_user
    else
      current_user.admin ? users_path : authenticated_root_path
    end
  end
end
