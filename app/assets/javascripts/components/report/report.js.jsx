var Report = React.createClass({
  getInitialState: function() {

    return {
      start_date: '',
      end_date: '',
      meals_count: '',
      ave_number_of_attendees: '',
      ave_cost: '',
      residents: [{
        name: 'generating...',
        balance: '',
        meals_attended: ''
      }],
      units: [{
        name: 'generating...',
        balance: '',
        meals_cooked: ''
      }],
      fetching_residents: true,
      fetching_units: true
    }
  },

  componentDidMount: function() {
    // Start Spinners
    var residents = document.getElementById('residents-spinner')
    var residents_spinner = new Spinner().spin(residents)

    var units = document.getElementById('units-spinner')
    var units_spinner = new Spinner().spin(units)

    // Fetch report data
    this.reportRequest = $.get('/api/report', function (data) {
      this.setState({
        start_date: data.start_date,
        end_date: data.end_date,
        meals_count: data.meals_count,
        ave_number_of_attendees: data.ave_number_of_attendees,
        ave_cost: data.ave_cost
      });
    }.bind(this));

    // Fetch Resident data
    this.residentsRequest = $.get('/api/residents', function (data) {
      this.setState({
        residents: data,
        fetching_residents: false
      });

      residents_spinner.stop()
    }.bind(this));

    // Fetch Unit data
    this.unitsRequest = $.get('/api/units', function (data) {
      this.setState({
        units: data,
        fetching_units: false
      });

      units_spinner.stop()
    }.bind(this));
  },

  componentWillUnmount() {
    this.reportRequest.abort()
    this.residentsRequest.abort()
    this.unitsRequest.abort()
  },

  render: function() {
    const spinnerStyle = {
      width: "100px",
      height: "100px",
      position: "relative",
      display: "inline-block"
    }

    return (
      <div>
        <h1>{this.state.start_date} - {this.state.end_date}</h1>

        <ul>
          <li>Number of Meals: {this.state.meals_count}</li>
          <li>Ave. number of attendees: {this.state.ave_number_of_attendees}</li>
          <li>Ave. cost: {this.state.ave_cost}</li>
        </ul>

        <br/>

        <h2>Residents</h2>{this.state.fetching_residents ? <div id="residents-spinner" style={spinnerStyle}></div> : null}
        <table className="table table-striped">
          <thead>
            <tr>
              <th>Name</th>
              <th>Balance</th>
              <th>Number of Meals Attended</th>
            </tr>
          </thead>
          <tbody>
            {this.state.residents.map(function(resident) {
              return (
                <tr key={resident.name}>
                  <td>{resident.name}</td>
                  <td>{resident.balance}</td>
                  <td>{resident.meals_attended}</td>
                </tr>
              )
            })}
          </tbody>
        </table>

        <br/>

        <h2>Units</h2>{this.state.fetching_units ? <div id="units-spinner" style={spinnerStyle}></div> : null}
        <table className="table table-striped">
          <thead>
            <tr>
              <th>Name</th>
              <th>Balance</th>
              <th>Number of Meals Cooked</th>
            </tr>
          </thead>
          <tbody>
            {this.state.units.map(function(unit) {
              return (
                <tr key={unit.name}>
                  <td>{unit.name}</td>
                  <td>{unit.balance}</td>
                  <td>{unit.meals_cooked}</td>
                </tr>
              )
            })}
          </tbody>
        </table>
      </div>
    )
  }
})
