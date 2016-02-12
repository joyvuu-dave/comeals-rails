$ ->
  # Detect max
  $('.js-submit-meal').click((e) ->
    e.preventDefault()
    e.stopPropagation()

    max = $('#meal_max').val().trim()

    # Regex to test for number
    re = /^[0-9]*$/

    # Alert if max isn't a number
    notie.alert(3, 'Invalid max', 2.5) unless max.match(re) and max >= 0 and max <= 21474836

    # How many checkboxes are checked?
    num_checked = 0
    $('input[type=checkbox]').each( ->
      if this.checked
        num_checked += 1
    )

    active_guests = 0
    guests = $('.js-guest').each( ->
      if $(this).is(':visible')
        active_guests += 1
    )

    if (num_checked + active_guests) > max
      # Alert if num of checked boxes is greater than max
      notie.alert(3, 'Max number of people reached', 2.5)
    else
      $('form').submit()
  )
