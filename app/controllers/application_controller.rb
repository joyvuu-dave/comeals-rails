class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_controller_variables

  def set_controller_variables
    if cookies[:user] == 'admin'
      @signed_in = true
      @admin = true
    elsif cookies[:user] == 'user'
      @signed_in = true
      @admin = false
    else
      @signed_in = false
      @admin = false
    end
  end

  def authenticate
    redirect_to :root unless @signed_in == true
  end

  def authorize
    unless @admin
      begin
        redirect_to(:back)
      rescue
        redirect_to(:root)
      end
    end
  end
end
