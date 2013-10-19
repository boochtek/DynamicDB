# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.data-table').dataTable()

  $('th').on 'dblclick', (e) ->
    e.preventDefault()
    $column = $(this)

    # Initialize form with value for column
    $("#column_type option[value='#{$column.data('type')}']").attr("selected", "selected")
    $("#column_name").val $column.data('name')
    $(".edit-column").attr("action", "/columns/#{$column.data('id')}")

    # Open Modal Form Dialog
    $(".edit-column").dialog "open"

  $(".edit-column").dialog
    autoOpen: false
    height: 300
    width: 350
    modal: true
    buttons:
      Cancel: ->
        $(this).dialog "close"
