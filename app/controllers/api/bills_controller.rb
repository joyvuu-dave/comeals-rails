module Api
  class BillsController < ApplicationController
    def index
      bills = Bill.includes(:meal, { :resident => :unit }).all
      render json: bills
    end
  end
end
