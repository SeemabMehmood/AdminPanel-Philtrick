module ApplicationHelper
  def titleize(str)
    str.titleize
  end

  def sidebar_active_class(current_page)
    return 'active' if request.path == '/' && current_page == 'dashboard'
    request.path.include?(current_page) ? 'active' : ''
  end
end
