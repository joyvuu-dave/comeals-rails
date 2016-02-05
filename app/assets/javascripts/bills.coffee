# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  # Convert cents to dollars
  cents = parseInt($('#bill_amount').val())
  $('#bill_amount').val(cents/100)

  # Convert dollars to cents
  $('.js-submit-bill').click((e) ->
    e.preventDefault()
    e.stopPropagation()

    input = $('#bill_amount').val().trim()

    # Regex to test for number
    re = /^[0-9]*[\.]?[0-9]{0,2}$/

    if input.match(re) and input >= 0 and input <= 21474836
      $('#bill_amount').attr({type: 'hidden'}).val(Math.round(input * 100))
      $('form').submit()
    else
      notie.alert(3, 'Invalid amount', 2.5)
  )
