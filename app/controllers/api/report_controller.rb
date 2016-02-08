module Api
  class ReportController < ApplicationController
    before_action :signed_in?

    def show
      data = {
        start_date: Meal.order(:date).first.date.inspect,
        end_date: Meal.order(:date).last.date.inspect,
        meals_count: Meal.count,
        ave_number_of_attendees: Meal.ave_number_of_attendees,
        ave_cost: Meal.ave_cost
      }

      render json: data.to_json
    end
  end
end
