module Api
  class MealsController < ApplicationController
    before_action :signed_in?

    def index
      meals = Meal.all
      render json: meals
    end
  end
end
