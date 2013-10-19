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

window.enableEditables = enableEditables
