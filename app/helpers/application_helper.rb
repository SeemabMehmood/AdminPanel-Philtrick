module ApplicationHelper
  def titleize(str)
    str.titleize
  end

  def sidebar_active_class(current_page)
    return 'active' if request.path == '/' && current_page == 'dashboard'
    request.path.include?(current_page) ? 'active' : ''
  end

  def breadcrumb_action_name
    return "Customer" if titleize(params[:controller].parameterize) == "Users"
    titleize(params[:controller].parameterize)
  end

  def no_data_message(collection_object)
    ["<b>No ", titleize(collection_object.table_name), " found.</b>"].join.html_safe unless collection_object.any?
  end
end
