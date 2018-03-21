turboload = ->
  o = undefined
  o = $.AdminLTE.options
  if o.sidebarPushMenu
    $.AdminLTE.pushMenu.activate o.sidebarToggleSelector
  $.AdminLTE.layout.activate()

turborender = ->
  $.AdminLTE.tree(".sidebar")

$(document).ready turboload
document.addEventListener 'turbolinks:load', turboload
document.addEventListener 'turbolinks:render', turborender
