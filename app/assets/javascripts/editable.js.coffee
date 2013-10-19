$ ->
  $('span.editable').editable (value, settings) ->
    $span = $(this)
    url = "/#{$span.data('base-url')}/#{$span.data('id')}"
    attribute = $span.data('attribute')
    data = {}
    data[attribute] = value
    $.post(url, data)
    value
  , tooltip: 'Click to edit', indicator: 'Saving...', submitdata: {}


#$ ->
#  $('body').on 'click', 'span.editable', ->
#    $this = $(this)
#    value = $this.text()
#    console.log(value)
#    $form = $("<form style='display: inline'><input type='text' value='#{value}' /></form>")
#    $form.on 'submit', (e) ->
#      e.preventDefault()
#      $this = $(this)
#      value = $this.find('input').val()
#      console.log("value: #{value}")
#      $this.replaceWith("<span class='editable'>#{value}</span>")
#    $this.replaceWith($form)
#    $form.trigger('active')
