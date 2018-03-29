ready = ->
  turboload()
  draw_linechart()

turboload = ->
  o = undefined
  o = $.AdminLTE.options
  if o.sidebarPushMenu
    $.AdminLTE.pushMenu.activate o.sidebarToggleSelector
  $.AdminLTE.layout.activate()

  $('.alert').delay(5000).slideUp 500, ->
    $('.alert').alert 'close'

  draw_linechart()

turborender = ->
  $.AdminLTE.tree(".sidebar")

draw_linechart = ->
  if document.getElementById('lineChart')
    data = document.getElementById('deposits_information').getAttribute('data-latest-deposits')
    labels = document.getElementById('deposits_information').getAttribute('data-labels')
    ctx = document.getElementById('lineChart').getContext('2d')
    chart = new Chart(ctx,
      type: 'line'
      data:
        labels: set_chart_data(labels)
        datasets: [ {
          label: 'Deposits History'
          backgroundColor: 'rgb(255, 99, 132)'
          borderColor: 'rgb(255, 99, 132)'
          data: set_chart_data(data)
        } ]
      options: {})

set_chart_data = (data) ->
  data.split('","').map((x) -> x.replace('[', '').replace(']', '').replace('"', ''))

$(document).ready ready
document.addEventListener 'turbolinks:load', turboload
document.addEventListener 'turbolinks:render', turborender
