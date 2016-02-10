var ReconciliationButton = React.createClass({
  getInitialState: function() {
    return {
      fetching: false,
      token: ''
    }
  },

  disableButton: function() {
    this.setState({
      fetching: true
    })
  },

  componentDidMount: function(e) {
    this.setState({
      token: $('meta[name=csrf-token]').attr('content')
    })
  },

  render: function() {
    return (
      <form
        onSubmit={this.disableButton}
        acceptCharset="UTF-8"
        action="/reconciliations"
        method="post"
        className="col-xs-6 well">
        <input
          name="authenticity_token"
          type="hidden"
          value={this.state.token} />
        <button
          type="submit"
          className="btn btn-primary"
          disabled={this.state.fetching || this.props.unreconciled_meal_count == 0}>
            Reconcile {this.props.unreconciled_meal_count} Meals
        </button>
      </form>
    )
  }
})
