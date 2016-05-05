module Api
  class MealsController < ApplicationController
    #before_action :signed_in?
    before_action :set_meal, only: [:update]

    # GET /meals
    def index
      meals = Meal.all
      render json: meals
    end

    # GET /meals/:id
    def show
      meal = Meal.where(id: params[:id]).first
      render json: meal, serializer: ReactMealSerializer
    end

    # PATCH /meal/:id
    def update
      if @meal.update(meal_params)
        # Workaround for counter_cache not updating this automatically
        MealResident.counter_culture_fix_counts
      end

      render json: @meal, serializer: ReactMealSerializer
    end

    private
      def set_meal
        @meal = Meal.find(params[:id])
      end

      def meal_params
        params.require(:meal).permit(:id, :description, :max, :auto_close, :closed, meal_residents_attributes: [:id, :meal_id, :resident_id, :multiplier, :vegetarian, :late, :_destroy], guests_attributes: [:id, :meal_id, :resident_id, :multiplier, :vegetarian, :_destroy], bills_attributes: [:id, :meal_id, :resident_id, :amount, :_destroy])
      end
  end
end
