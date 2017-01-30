# == Schema Information
# Schema version: 20160301173036
#
# Table name: bills
#
#  id              :integer          not null, primary key
#  meal_id         :integer
#  resident_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("USD"), not null
#
# Indexes
#
#  index_bills_on_meal_id      (meal_id)
#  index_bills_on_resident_id  (resident_id)
#
# Foreign Keys
#
#  fk_rails_a4b9083e79  (meal_id => meals.id)
#  fk_rails_d7e3fd1337  (resident_id => residents.id)
#

class BillsController < ApplicationController
  before_action :signed_in?
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  def index
    @bills = Bill.order("meals.date desc").includes(:resident, :meal).all.page(params[:page])
  end

  # GET /bills/1
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new(meal_id: params[:meal])
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills/new
  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      redirect_to root_path, notice: 'Bill was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /bills/1
  def update
    if @bill.update(bill_params)
      redirect_to root_path, notice: 'Bill was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /bills/1
  def destroy
    if @bill.destroy
      redirect_to bills_url, notice: 'Bill was successfully destroyed.'
    else
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.includes(:resident, :meal).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:meal_id, :resident_id, :amount_cents)
    end
end
