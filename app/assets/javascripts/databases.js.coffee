# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.data-table').dataTable()
  $('td').editable()
  $('th').on 'dblclick', (e) ->
    e.preventDefault()
    $col = $(this)
    console.log $col

    $("#column_type option[value='#{$col.data('type')}']").attr("selected", "selected")
    $("#column_name").val $col.data('name')
    $(".edit-column").attr("action", "/columns/#{$col.data('id')}")
    $(".edit-column").dialog "open"

  $(".edit-column").dialog
    autoOpen: false
    height: 300
    width: 350
    modal: true
    buttons:
      Cancel: ->
        $(this).dialog "close"
