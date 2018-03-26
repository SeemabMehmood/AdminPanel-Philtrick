module UsersHelper
  def get_selected_country(user)
    user.country if user.new_record?
  end

  def form_submit_text(form_object)
    form_object.persisted? ? "Update Customer" : "Add Customer"
  end
end
