module Api
  class ResidentsController < ApplicationController
    before_action :signed_in?

    def index
      residents = Resident.order(:name).includes({ :bills => :meal }, { :meal_residents => :meal }, { :guests => :meal })
      render json: residents
    end
  end
end
