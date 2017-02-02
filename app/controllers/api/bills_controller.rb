module Api
  class BillsController < ApplicationController
    def index
      bills = Bill.includes(:meal, { :resident => :unit }).joins(:meal).where("meals.date >= ?", params[:start]).where("meals.date <= ?", params[:end])
      render json: bills
    end
  end
end
