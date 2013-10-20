$ ->
  enableEditables()

enableEditables = ->
  $('span.editable').editable (value, settings) ->
    $span = $(this)
    also_update_selector = $span.data('also-update-selector')
    $(also_update_selector).text(value) if also_update_selector
    data = {_method: 'PUT'}
    data[$span.data('attribute')] = value
    # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
    $.post($span.data('url'), data)
    value
  , tooltip: 'Click to edit', placeholder: ''

  $('table.editable td').editable (value, settings) ->
    $td = $(this)
    $tr = $td.parent('tr')
    data = {_method: 'PUT', index: $td.index(), value: value} # NOTE: Index is 0-based.
    # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
    $.post($tr.data('url'), data, null, 'json')
    value
  , onblur: 'submit', placeholder: ''

window.enableEditables = enableEditables
