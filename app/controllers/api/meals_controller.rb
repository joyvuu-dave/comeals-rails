module Api
  class MealsController < ApplicationController
    before_action :signed_in?
    before_action :admin?, only: [:generate_meal_templates]

    def index
      meals = Meal.all
      render json: meals
    end

    def generate_meal_templates
      unless Community.count > 0
        flash[:error] = "You must have a Community to generate meal templates."
        redirect_to admin_path and return
      end

      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      alternating_dinner_day = params[:first_week_common_dinner].to_i

      count = Meal.create_templates(start_date, end_date, alternating_dinner_day, 0)
      syntax = count == 1 ? 'template was' : 'templates were'

      redirect_to calendar_path, notice: "#{count} meal #{syntax} successfully created."
    end
  end
end
