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
    ["<b>No ", titleize(model_name(collection_object.table_name)), " found.</b>"].join.html_safe unless collection_object.any?
  end

  def model_name(table_nam)
    table_nam == 'users' ? 'customers' : table_nam
  end

  def currency_symbol(currency)
    return if currency.blank?
    return '<b>Ł</b>'.html_safe if currency.code == 'LTC'
    return "<i class='fa fa-btc'></i>".html_safe if currency.code == 'BTC'
    image_tag("bch_icon.ico", class: "bch-icon", alt: "Bitcoin Cash") if currency.code == 'BCH'
  end
end
