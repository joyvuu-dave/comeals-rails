$ ->
  $('a').qtip()

  $('#calendar').fullCalendar(
    eventSources: [
      {url: '/api/meals', color: 'blue'},
      {url: '/api/bills', color: 'purple'}
    ]
    eventRender: (event, element) ->
      element.qtip({ content: { text: event.description} }) if event.description
      return
  )
