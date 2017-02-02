module Api
  class MealsController < ApplicationController
    def index
      meals = Meal.where("date >= ?", params[:start]).where("date <= ?", params[:end])
      render json: meals
    end
  end
end
