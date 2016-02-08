module Api
  class BillsController < ApplicationController
    before_action :signed_in?

    def index
      bills = Bill.includes(:resident, :meal).all
      render json: bills
    end
  end
end
