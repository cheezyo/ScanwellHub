# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#components').dataTable
   bJQueryUI: true
   
  $('#component_last_check').datepicker
    dateFormat: 'yy-mm-dd'

$(document).ready(ready)
$(document).on('page:load', ready)


