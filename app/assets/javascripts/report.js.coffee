# DOM manipulation
addReportData = (data) ->
  $('#dates').append("#{data.start_date} - #{data.end_date}")
  $('#meals_count').append("Number of Meals: #{data.meals_count}")
  $('#ave_number_of_attendees').append("Ave. number of attendees: #{data.ave_number_of_attendees}")
  $('#ave_cost').append("Ave. cost: #{data.ave_cost}")

addResidentData = (residents) ->
  for r in residents
    do (r) ->
      $('#residents_body').append("<tr><td>#{r.name}</td><td>#{r.balance}</td><td>#{r.meals_attended}</td></tr>")

addUnitData = (units) ->
  for u in units
    do (u) ->
      $('#units_body').append("<tr><td>#{u.name}</td><td>#{u.balance}</td><td>#{u.meals_cooked}</td></tr>")


# Ajax
getReport = () ->
  return $.get('/api/report').done((data) ->
    addReportData(data)
  )

getResidents = () ->
  return $.get('/api/residents').done((data) ->
    addResidentData(data)
  )

getUnits = () ->
  return $.get('/api/units').done((data) ->
    addUnitData(data)
  )

$ ->
  # show spinner
  showSpinner()


  # fetch data / stop spinner when done
  $.when(getReport(), getResidents(), getUnits()).done( ->
    hideSpinner()
  )




