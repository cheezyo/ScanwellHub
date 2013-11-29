ready = ->
 
  
  $('#unit_yearly_check_date, #component_yearly_check_date').datepicker
    dateFormat: 'yy-mm-dd'

  
$(document).ready(ready)
$(document).on('page:load', ready)