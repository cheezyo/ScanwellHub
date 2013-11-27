ready = ->
 
  
  $('#yearl_check_date').datepicker
    dateFormat: 'yy-mm-dd'

  
$(document).ready(ready)
$(document).on('page:load', ready)