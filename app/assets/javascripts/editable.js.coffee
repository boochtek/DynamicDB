$ ->
  enableEditables()

enableEditables = ->
  $('span.editable').editable (value, settings) ->
    $span = $(this)
    data = {_method: 'PUT'}
    data[$span.data('attribute')] = value
    # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
    $.post($span.data('url'), data)
    value
  , tooltip: 'Click to edit'

  $('table.editable td').editable (value, settings) ->
    $td = $(this)
    $tr = $td.parent('tr')
    data = {_method: 'PUT', index: $td.index(), value: value} # NOTE: Index is 0-based.
    # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
    $.post($tr.data('url'), data, null, 'json')
    value
  , onblur: 'submit'

window.enableEditables = enableEditables
