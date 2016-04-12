
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  description               :text
#  max                       :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  reconciliation_id         :integer
#  closed                    :boolean          default(FALSE), not null
#  time_zone                 :string
#  auto_close                :boolean          default(FALSE), not null
#
# Indexes
#
#  index_meals_on_reconciliation_id  (reconciliation_id)
#
# Foreign Keys
#
#  fk_rails_4ac0d4ffd3  (reconciliation_id => reconciliations.id)
#

class MealsController < ApplicationController
  before_action :signed_in?
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  # GET /meals
  def index
    show_current and return if params[:q] == 'current'

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
    @meal = @meal.next if params[:q] == 'next' && @meal.next?
    @meal = @meal.prev if params[:q] == 'prev' && @meal.prev?
  end

  # POST /meals
  def create
    create_meals and return if params[:q] == 'templates'

    @meal = Meal.new(meal_params)
    @meal.cap = Community.first&.cap

    if @meal.save
      redirect_to meals_url, notice: 'Meal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /meals/1
  def update
    if @meal.reconciled?
      # FIXME: add error to meal
      flash[:error] = 'Reconciled meals cannot be updated.'
      render edit_meal_path(@meal)
    end

    if @meal.update(meal_params)
      # Workaround for counter_cache not updating this automatically
      MealResident.counter_culture_fix_counts
      redirect_to calendar_path, notice: "#{@meal.date.inspect} meal was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /meals/1
  def destroy
    admin?

    if @meal.destroy
      redirect_to meals_url, notice: 'Meal was successfully destroyed.'
    else
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:date, :cap, :description, :extras, :max, :closed, meal_residents_attributes: [:id, :meal_id, :resident_id, :multiplier, :vegetarian, :late, :_destroy], guests_attributes: [:id, :meal_id, :resident_id, :multiplier, :vegetarian, :late, :name, :_destroy], bills_attributes: [:id, :meal_id, :resident_id, :amount, :amount_cents, :_destroy])
    end

    ################
    # Helper Methods
    ################
    def create_meals
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

    def show_current
      if Meal.count == 0
        redirect_to(new_meal_path, notice: 'No meals currently exist. Create one.') and return
      end

      current_date = Time.now
      if Meal.where("date >= ?", current_date).count > 0
        @meal = Meal.order(:date).where("date >= ?", current_date).first
      else
        @meal = Meal.order(:date).where("date < ?", current_date).last
      end

      redirect_to edit_meal_path(@meal)
    end
end
