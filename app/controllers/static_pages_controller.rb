class StaticPagesController < ApplicationController
  def index
    redirect_to calendar_path and return if @signed_in
  end
end
