class AdminController < ApplicationController
  before_action :admin?

  def show
    @unreconciled_meal_count = Meal.unreconciled.count
  end
end
