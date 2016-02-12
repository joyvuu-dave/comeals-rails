$ ->
  $('#calendar').fullCalendar(
    eventSources: [
      {url: '/api/meals', color: 'blue'},
      {url: '/api/bills', color: 'purple'}
    ]
  )
