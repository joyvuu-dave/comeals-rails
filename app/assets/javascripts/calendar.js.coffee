$ ->
  $('a').qtip()

  $('#calendar').fullCalendar(
    eventSources: [
      {url: '/api/meals', color: '#729f98'},
      {url: '/api/bills', color: '#aa863a'}
    ]
    eventRender: (event, element) ->
      element.qtip({
        content: {
          text: event.description
        },
        position: {
          my: 'bottom center',
          at: 'top center'
        }
      }) if event.description
      return
  )
