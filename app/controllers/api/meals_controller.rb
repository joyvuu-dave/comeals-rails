module Api
  class MealsController < ApplicationController
    def index
      meals = Meal.all
      render json: meals
    end
  end
end
