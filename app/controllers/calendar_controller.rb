class CalendarController < ApplicationController
  before_action :signed_in?
  layout 'calendar'

  def index
  end
end
