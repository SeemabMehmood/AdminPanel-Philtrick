ready = ->
  $('.datepicker').datepicker
    format: 'dd-mm-yyyy'
    assumeNearbyYear: true
    autoclose: true

$(document).ready ready
document.addEventListener 'turbolinks:load', ready
