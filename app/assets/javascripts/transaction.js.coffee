ready = ->
  $(".status-select").change ->
    e = $(this)
    selected_transaction_id = e.val()
    selected_transaction_user_id = e.closest("tr").children().first().text()

    $.post '/transactions/' + selected_transaction_id + '/change_status',
      status: e.find(':selected').text()
      user_id: selected_transaction_user_id

document.addEventListener 'turbolinks:load', ready
