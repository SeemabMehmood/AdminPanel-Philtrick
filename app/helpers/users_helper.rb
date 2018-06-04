module UsersHelper
  def get_selected_country(user)
    user.country if user.new_record?
  end

  def form_submit_text(form_object, object_type)
    form_object.persisted? ? "Update #{object_type}" : "Add #{object_type}"
  end

  def back_user_form_url(action_name, user)
    return users_path if action_name == 'index' || user.new_record?
    current_user if action_name == 'show' || action_name.blank?
  end

  def back_user_show_url
    return users_path if current_user.admin
    authenticated_root_path
  end

  def check_mining_addresses(user)
    str = ""
    str = "BTC" if user.btc_mining_address.present?
    str = [str, "LTC"].join(", ") if user.ltc_mining_address.present?
    str = [str, "BCH"].join(", ") if user.bch_mining_address.present?
    return "Not Found" if str.blank?
    ["<i class='fa fa-check-circle'></i>", str].join(" ").html_safe
  end
end
