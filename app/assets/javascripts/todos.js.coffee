ready = ->
  $('#completed-tasks, #incompleted-tasks').dataTable
   bJQueryUI: true

$(document).ready(ready)
$(document).on('page:load', ready)

