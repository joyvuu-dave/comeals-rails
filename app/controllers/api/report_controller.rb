module Api
  class ReportController < ApplicationController
    #before_action :signed_in?

    def show
      data = {
        start_date: Meal.unreconciled.order(:date).first&.date.inspect,
        end_date: Meal.unreconciled.order(:date).last&.date.inspect,
        meals_count: Meal.unreconciled.count,
        ave_number_of_attendees: Meal.unreconciled_ave_number_of_attendees,
        ave_cost: Meal.unreconciled_ave_cost
      }

      render json: data.to_json
    end
  end
end
