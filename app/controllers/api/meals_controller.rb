module Api
  class MealsController < ApplicationController
    before_action :authenticate

    def index
      @meals = Meal.all
      render json: @meals
    end
  end
end
