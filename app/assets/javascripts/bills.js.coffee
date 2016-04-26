$ ->
  # Convert cents to dollars
  cents = parseInt($('#bill_amount_cents').val())
  $('#bill_amount_cents').val(cents/100)

  # Convert dollars to cents
  $('.js-submit-bill').click((e) ->
    e.preventDefault()
    e.stopPropagation()

    input = $('#bill_amount_cents').val().trim()

    # Regex to test for number
    re = /^[0-9]*[\.]?[0-9]{0,2}$/

    if input.match(re) and input >= 0 and input <= 21474836
      $('#bill_amount_cents').attr({type: 'hidden'}).val(Math.round(input * 100))
      $('form').submit()
    else
      notie.alert(3, 'Invalid amount', 2.5)
  )
