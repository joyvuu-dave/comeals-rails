# == Schema Information
# Schema version: 20160131201418
#
# Table name: bills
#
#  id          :integer          not null, primary key
#  meal_id     :integer
#  resident_id :integer
#  amount      :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
  before_action :authenticate
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.order("meals.date desc").includes(:resident, :meal).all.page(params[:page])
  end

  # GET /bills/new
  def new
    @bill = Bill.new(meal_id: params[:meal])
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to bills_url, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to bills_url, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    redirect_to bills_url, notice: 'Bill was successfully destroyed.'
    # respond_to do |format|
    #   format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.includes(:resident, :meal).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:meal_id, :resident_id, :amount)
    end
end
