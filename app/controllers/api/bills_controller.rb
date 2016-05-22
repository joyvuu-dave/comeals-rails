module Api
  class BillsController < ApplicationController
    before_action :signed_in?

    def index
      bills = Bill.includes(:meal, { :resident => :unit }).all
      render json: bills
    end
  end
end
