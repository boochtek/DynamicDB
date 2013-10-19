# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

openColumnEditForm = ($column) ->
    # Initialize form with values for column
    $("#column_type option[value='#{$column.data('type')}']").attr("selected", "selected")
    $("#column_name").val $column.data('name')
    $(".edit-column").attr("action", "/columns/#{$column.data('id')}")

    # Open Modal Form Dialog
    $(".edit-column").dialog "open"

$ ->
  $('.data-table').dataTable()

  $('th').on 'dblclick', (e) ->
    e.preventDefault()
    openColumnEditForm $(this)

  $(".edit-column").dialog
    autoOpen: false
    height: 200
    width: 350
    modal: true
    resizable: false
    title: 'Modify Column Attributes'
    buttons:
      [
        {
          text: 'Cancel'
          click: ->
            $(this).dialog "close"
          class: 'cancel'
        },
        {
          text: 'Save Changes'
          click: ->
            $('form').submit()
        }
      ]
