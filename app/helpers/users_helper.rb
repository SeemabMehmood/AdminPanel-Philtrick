module UsersHelper
  def get_selected_country(user)
    user.country if user.new_record?
  end
end
