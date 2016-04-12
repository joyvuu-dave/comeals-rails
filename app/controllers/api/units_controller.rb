module Api
  class UnitsController < ApplicationController
    #before_action :signed_in?

    def index
      units = Unit.order(:name).includes({ :residents => { :bills => :meal }}, { :residents => { :meal_residents => :meal }}, { :residents => { :guests => :meal }})
      render json: units
    end
  end
end
