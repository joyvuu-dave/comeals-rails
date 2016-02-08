$ ->
  $('#calendar').fullCalendar(
    loading: (bool) ->
      if bool then showSpinner() else hideSpinner()
    eventSources: [
      {url: '/api/meals', color: 'blue'},
      {url: '/api/bills', color: 'purple'}
    ]
  )
