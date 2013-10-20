# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

openColumnEditForm = ($column) ->
  # Initialize form with values for column
  $form = $(".edit-column")
  $form.find("#column_type option[value='#{$column.data('type')}']").attr("selected", "selected")
  $form.find("#column_name").val($column.data('name'))
  $form.data(id: $column.data('id'))
  $form.attr(action: "/columns/#{$column.data('id')}", method: "put")

  # Open Modal Form Dialog
  $(".edit-column").dialog "open"

columnEditSubmitHandler = (e) ->
  e.preventDefault()
  form = $(e.target)
  data_type = $('#column_type').val()
  name = $('#column_name').val()
  # TODO: deal with errors/validations. Waiting indicator
  $.ajax
    url: form.attr('action'),
    type: 'PUT'
    data:
      column:
        data_type: data_type
        name: name
    success: ->
      updateColumnHeader(form.data('id'), name, data_type)
      $(".edit-column").dialog "close"

updateColumnHeader = (id, name, data_type) ->
  $th = $("th[data-id='#{id}']")
  $th.text(name)
  $th.data(type: data_type, name: name)

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
  $('form.edit-column').on 'submit', columnEditSubmitHandler
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

  $('form.add-record').on 'click', (e) ->
    e.preventDefault()
    $.post '/records', {table_id: $('.database .tables .table').data('id')}, (data, textStatus, jqXHR) ->
      add_new_record_to_table(data['id'])
    , 'json'


add_new_record_to_table = (new_record_id) ->
  num_columns = $('table.data-table thead tr th').length
  num_rows = $('table.data-table tbody tr').length
  $new_row = $('<tr></tr>')
  $new_row.addClass(if (num_rows % 2 == 1) then 'even' else 'odd') # FIXME: We should stop using odd/even classes in favor of CSS nth-child.
  $new_row.data(id: new_record_id, url: "/records/#{new_record_id}")
  $new_row.append('<td></td>') for i in [1..num_columns]
  $new_row.appendTo('table.data-table tbody')
  enableEditables()
