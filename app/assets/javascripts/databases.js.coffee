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

show_table = (table_id) ->
  console.log(table_id)
  $('.database .tables .table').empty()
  # TODO: We should test for failure or timeout here, and show a loading indicator.
  $.get "/tables/#{table_id}", (data, textStatus, jqXHR) ->
    console.log(data)
    $('.database .tables .table').append($(data))
    bindEventHandlers()

bindEventHandlers = ->
  enableEditables()
  $('.data-table').dataTable(bPaginate: false, bSort: false)
  $('th.column-head').on 'dblclick', (e) ->
    e.preventDefault()
    openColumnEditForm $(this)

$ ->
  bindEventHandlers()
  $('#add-table').on 'click', (e) ->
    # TODO: We should test for failure or timeout here, and show a loading indicator.
    $.post '/tables', {table: {database_id: $('.database').data('id')}}, (data, textStatus, jqXHR) ->
      table_id = data['id']
      $('.database .tables ul.list').append("<li><a data-id='#{table_id}'>New Table</a></li>")
      show_table(table_id)
    , 'json'

  $('.database .tables ul.list').on 'click', 'li a:not(#add-table)', (e) ->
    table_id = $(this).data('id')
    show_table(table_id)

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
