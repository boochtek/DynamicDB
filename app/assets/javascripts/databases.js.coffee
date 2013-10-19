# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#example').dataTable()
  $('td').editable()
  $('th').on 'dblclick', (e) ->
    e.preventDefault()
    $(".edit_database").dialog "open"

  $(".edit_database").dialog
    autoOpen: false
    height: 300
    width: 350
    modal: true
    buttons:
      Cancel: ->
        $(this).dialog "close"
