# == Schema Information
# Schema version: 20160202150722
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  community_id              :integer
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_meals_on_community_id  (community_id)
#
# Foreign Keys
#
#  fk_rails_0336f048cd  (community_id => communities.id)
#

class MealsController < ApplicationController
  before_action :authenticate
  before_action :authorize, only: [:destroy]
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  def index
    @meals = Meal.order(date: :desc).all.page(params[:page])
  end

  # GET /meals/1
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # GET /meals/1/edit
  def edit
  end

  # POST /meals
  def create
    @meal = Meal.new(meal_params)
    @meal.community_id = Community.first.id

    if @meal.save
      redirect_to meals_url, notice: 'Meal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.update(meal_params)
      # Hack b/c counter_cache won't update this automatically
      MealResident.counter_culture_fix_counts
      redirect_to meals_url, notice: 'Meal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /meals/1
  def destroy
    @meal.destroy
    redirect_to meals_url, notice: 'Meal was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:date, :community_id, :resident_ids => [], guests_attributes: [:id, :meal_id, :resident_id, :multiplier, :name, :_destroy])
    end
end
