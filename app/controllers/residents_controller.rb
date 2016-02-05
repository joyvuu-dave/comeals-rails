# == Schema Information
# Schema version: 20160202150722
#
# Table name: residents
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  multiplier :integer          default(2), not null
#  unit_id    :integer
#  bill_costs :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_residents_on_name     (name) UNIQUE
#  index_residents_on_unit_id  (unit_id)
#
# Foreign Keys
#
#  fk_rails_8ddf6a82d6  (unit_id => units.id)
#

class ResidentsController < ApplicationController
  before_action :authenticate
  before_action :authorize, except: [:index, :show]
  before_action :set_resident, only: [:show, :edit, :update, :destroy]

  # GET /residents
  def index
    @residents = Resident.order("units.name").includes({ :bills => :meal }, { :guests => :meal }, { :meal_residents => :meal }, :unit).all.page(params[:page])
  end

  # GET /residents/1
  def show
  end

  # GET /residents/new
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents
  def create
    @resident = Resident.new(resident_params)
    if @resident.save
      redirect_to residents_url, notice: 'Resident was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /residents/1
  def update
    if @resident.update(resident_params)
      redirect_to residents_url, notice: 'Resident was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /residents/1
  def destroy
    @resident.destroy
    redirect_to residents_url, notice: 'Resident was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resident
      @resident = Resident.includes({ :bills => :meal }, { :meal_residents => :meal }, { :guests => :meal }, :unit).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resident_params
      params.require(:resident).permit(:name, :multiplier, :unit_id)
    end
end
