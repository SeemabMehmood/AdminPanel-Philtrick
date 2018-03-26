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

turborender = ->
  $.AdminLTE.tree(".sidebar")

draw_linechart = ->
  ctx = document.getElementById('lineChart').getContext('2d')
  chart = new Chart(ctx,
    type: 'line'
    data:
      labels: [
        'January'
        'February'
        'March'
        'April'
        'May'
        'June'
        'July'
      ]
      datasets: [ {
        label: 'Active Workers History'
        backgroundColor: 'rgb(255, 99, 132)'
        borderColor: 'rgb(255, 99, 132)'
        data: [
          0
          10
          5
          2
          20
          30
          45
        ]
      } ]
    options: {})

$(document).ready ready
document.addEventListener 'turbolinks:load', turboload
document.addEventListener 'turbolinks:render', turborender
