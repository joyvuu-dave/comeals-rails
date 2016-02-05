# == Schema Information
# Schema version: 20160202150722
#
# Table name: units
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_units_on_name  (name) UNIQUE
#

class UnitsController < ApplicationController
  before_action :authenticate
  before_action :authorize, except: [:index]
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  # GET /units
  def index
    @units = Unit.order(:name).includes({ :residents => { :bills => :meal }}, { :residents => { :meal_residents => :meal }}, { :residents => { :guests => :meal }}).all.page(params[:page])
  end

  # GET /units/new
  def new
    @unit = Unit.new
  end

  # GET /units/1/edit
  def edit
  end

  # POST /units
  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to units_url, notice: 'Unit was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /units/1
  def update
    if @unit.update(unit_params)
      redirect_to units_url, notice: 'Unit was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /units/1
  def destroy
    @unit.destroy
    redirect_to units_url, notice: 'Unit was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:name)
    end
end
