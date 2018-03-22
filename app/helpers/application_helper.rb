module ApplicationHelper
  def titleize(str)
    str.titleize
  end

  def get_selected_country(user)
    user.country if user.new_record?
  end
end
