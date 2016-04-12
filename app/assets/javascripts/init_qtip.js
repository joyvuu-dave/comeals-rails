$(function() {
  $('a').qtip()
  return $('#calendar').fullCalendar({
    eventSources: [
      {
        url: '/api/meals',
        color: '#729f98'
      }, {
        url: '/api/bills',
        color: '#aa863a'
      }
    ],
    eventRender: function(event, element) {
      if (event.description) {
        element.qtip({
          content: {
            text: event.description
          },
          position: {
            my: 'bottom center',
            at: 'top center'
          }
        })
      }
    }
  })
})
