# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

openColumnEditForm = ($column) ->
  # Initialize form with values for column
  $form = $(".edit-column")
  column_data = $column.data()
  $form.find("#column_data_type option[value='#{column_data.type}']").attr("selected", "selected")
  toggleLinkFields column_data.type

  if column_data.type is "Link" and column_data.linkId?
    $option = $form.find("#column_linked_column_id option[value='#{column_data.linkId}']")
    $option.attr("selected", "selected")
    table_id = $option.closest('.field').data('table-id')
    $form.find("#column_linked_table option[value='#{table_id}']").attr("selected", "selected")
    toggleLinkColumnFields table_id

  $form.find("#column_name").val(column_data.name)
  $form.data(id: column_data.id)
  $form.attr(action: "/columns/#{column_data.id}", method: "put")

  # Open Modal Form Dialog
  $(".edit-column").dialog "open"

columnEditSubmitHandler = (e) ->
  e.preventDefault()
  form = $(e.target)
  colData = form.serializeObject()['column']
  # TODO: deal with errors/validations. Waiting indicator
  $.ajax
    url: form.attr('action'),
    type: 'PUT'
    data: colData
    success: ->
      updateColumnHeader(colData)
      $(".edit-column").dialog "close"

updateColumnHeader = (colData) ->
  $th = $("th[data-id='#{colData.id}']")
  $th.text(colData.name)
  $th.data(colData)

show_table = (table_id) ->
  $('.database .tables .table').empty()
  # TODO: We should test for failure or timeout here, and show a loading indicator.
  $.get "/tables/#{table_id}", (data, textStatus, jqXHR) ->
    $('.database .tables .table').append($(data))
    bindEventHandlers()

columnsReordered = ->
  console.log('Columns reordered') # TODO: Send updates to server, so column order is persisted.

rowSelected = (row) ->
  $row = $(row)
  # TODO: We should make each input appropraite for the column it's in.
  return if $row.has(':input[type=submit][value=Save]').length == 1 # The row is already in save mode.
  $row.find('td').each (index) ->
    $td = $(this)
    text = $td.text()
    $td.replaceWith("<td><input type='text' value='#{text}' /></td>")
  $actions_th = $row.find('th.actions')
  $actions_th.append('<input type="submit" value="Save" />')
  $actions_th.find('input[value=Save]').on 'click', () ->
    saveRow(row)
  $row.find('td:first :input').focus()

saveRow = (row) ->
  console.log('Saving row:')
  $row = $(row)
  values = $row.find(':input:not(:input[type=submit][value=Save])').map(() -> $(this).val()).get()
  console.log values
  saveRecord($row.data('url'), $row.data('id'), values)
  # TODO: We should do validations first.
  # TODO: We shouldn't do this until the save has succeded.
  $row.find('td').each (index) ->
    $td = $(this)
    text = $td.find(':input').val()
    $td.replaceWith("<td>#{text}</td>")
  $row.find('th.actions input[value=Save]').remove()
  $row.removeClass('selected')

saveRecord = (url, record_id, values) ->
  data = {_method: 'PUT', all_values: values}
  # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
  $.post(url, data, null, 'json')

rowDeselected = (row) ->
  console.log('Row deselected')

enableDataTables = ->
  # See http://datatables.net/examples/basic_init/dom.html for explanation of sDom (we just want the table itself).
  # For sDom:
  #   R = reorderable columns (ColReorder plugin)
  #   r = processing indicator
  #   t = the table itself
  #   T = TableTools plugin
  #   S = Scroller plugin (must come after t)
  $('.data-table').dataTable
    bPaginate: false,                                     # No pagination.
    bSort: false,                                         # Disable clicking on columns to sort.
    bDeferRender: false,                                  # Set to true to be lazy about rendering off-screen rows/columns/
    sScrollY: '',                                         # Scroll amount (or disable scrolling if '').
    sDom: 'T<"clear">Rrt',                                # See above.
    oColReorder: {                                        # Options for ColReorder plugin.
      fnReorderCallback: columnsReordered                 # Call this (with no arguments) when columns are reordered.
    },
    oTableTools: {                                        # Options for TableTools plugin.
      aButtons: ['copy', 'csv', 'xls', 'pdf', 'print'],   # Include these buttons (we're showing all buttons).
      sRowSelect: 'multi',                                # Allow selecting multiple rows.
      sSelectedClass: 'selected',                         # Add 'selected' class to selected rows.
      sSwfPath: '/assets/dataTables/extras/swf/copy_csv_xls_pdf.swf', # Path to SWF file used by copy and local file operations.
      fnRowSelected: rowSelected,                         # Call this (with array of TR nodes) when a row is selected.
      fnRowDeselected: rowDeselected,                     # Call this (with array of TR nodes) when a row is deselected.
    }

enableColumnHeaders = ->
  $('.database .tables .table thead th').on 'dblclick', (e) ->
    e.preventDefault()
    openColumnEditForm $(this)

bindEventHandlers = ->
  enableEditables()
  enableDataTables()
  enableColumnHeaders()

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

  $(".edit-column #column_data_type").on 'change', (e) ->
    toggleLinkFields $(e.target).val()

  $(".edit-column #column_linked_table").on 'change', (e) ->
    toggleLinkColumnFields $(e.target).val()

  $('form.add-record').on 'click', (e) ->
    e.preventDefault()
    $.post '/records', {table_id: $('.database .tables .table').data('id')}, (data, textStatus, jqXHR) ->
      add_new_record_to_table(data['id'])
    , 'json'

  $('form.add-column').on 'click', (e) ->
    e.preventDefault()
    num_columns = $('table.data-table thead tr th:not(.actions)').length
    new_column_name = "Column #{num_columns + 1}"
    $.post '/columns', {name: new_column_name, table_id: $('.database .tables .table').data('id')}, (data, textStatus, jqXHR) ->
      add_new_column_to_table(new_column_name, data['id'])
    , 'json'

toggleLinkFields = (selected) ->
  if "Link" == selected
    $('#column_linked_table').parent().removeClass('hidden')
    toggleLinkColumnFields
    val = $("#column_linked_table").val()
    toggleLinkColumnFields val
  else
    $('#column_linked_table').parent().addClass('hidden')
    $('.column_selector').addClass('hidden')
    $(".column_selector select").attr('disabled', 'disabled')

toggleLinkColumnFields = (table_id) ->
  $('.column_selector').addClass('hidden')
  $(".column_selector select").attr('disabled', 'disabled')
  $("#columns_for_#{table_id}").removeClass('hidden')
  $(".field[data-table-id='#{table_id}'] select").attr('disabled', false)

add_new_record_to_table = (new_record_id) ->
  num_columns = $('table.data-table thead tr th').length
  num_rows = $('table.data-table tbody tr').length
  $new_row = $('<tr></tr>')
  $new_row.addClass(if (num_rows % 2 == 1) then 'even' else 'odd') # FIXME: We should stop using odd/even classes in favor of CSS nth-child.
  $new_row.data(id: new_record_id, url: "/records/#{new_record_id}")
  $new_row.append('<td></td>') for i in [1..num_columns]
  $new_row.appendTo('table.data-table tbody')
  enableEditables()

add_new_column_to_table = (new_column_name, new_column_id) ->
  num_columns = $('table.data-table thead tr th:not(.actions)').length
  $new_th = $("<th>#{new_column_name}</th>")
  $new_th.data(id: new_column_id, index: num_columns, name: new_column_name, type: 'String')
  $('table.data-table thead tr th.actions').before($new_th);
  $('table.data-table tbody tr th.actions').before('<td></td>');
  enableColumnHeaders()
  enableEditables()
