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
  , tooltip: 'Click to edit', placeholder: '', cssclass: 'inherit'

cellEditorHandler = (value, settings) ->
  $td = $(this)
  $tr = $td.parent('tr')
  index = $td.index()
  $col  = $td.closest('table').find("th[data-index='#{index}']")
  inputType = $col.data('type')

  if validateCellInput(inputType, value)
    sanitizedValue = sanitizeCellInput inputType, value
    data = {_method: 'PUT', index: index, value: sanitizedValue} # NOTE: Index is 0-based.
    # TODO: We should handle failures and timeouts in POSTing, and make our own "Saving..." indicator.
    $.post($tr.data('url'), data, null, 'json')
    sanitizedValue
  else
    alert "This column can only store #{inputType} data and #{value || "no value"} is not a valid #{inputType}"
    undefined

validateCellInput = (inputType, value) ->
  switch inputType
    when "String" then true
    when "Integer"
      validateIntegerInput value
    when "Decimal"
      validateDecimalInput value
    when "Boolean"
      validateBooleanInput value
    else
      true

sanitizeCellInput = (inputType, value) ->
  switch inputType
    when "Boolean"
      sanitizeBooleanInput value
    else
      value

validateIntegerInput = (value) ->
  /^\+?(0|[1-9]\d*)$/.test(value)

validateDecimalInput = (value) ->
  !isNaN(parseFloat(value)) && isFinite(value)

validateBooleanInput = (value) ->
  switch value.toLowerCase()
    when "false", "no", "n", "0"
      true
    when "true", "yes", "y", "1"
      true
    else
      false

sanitizeBooleanInput = (value) ->
  switch value.toLowerCase()
    when "false", "no", "n", "0"
      'false'
    else
      'true'

window.enableEditables = enableEditables
