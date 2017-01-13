class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  def authenticate
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

  def signed_in?
    unless @signed_in == true
      respond_to do |format|
        format.html { redirect_to :root }
        format.json { render json: { error: 'Unauthorized request.' }, status: :unauthorized }
      end
    end
  end

  def admin?
    unless @admin
      begin
        redirect_to(:back)
      rescue
        redirect_to(:root)
      end
    end
  end
end
