class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  before_action :set_status

  def set_status
    @resident_id = cookies.signed[:resident_id]
    @signed_in = true if cookies.signed[:signed_in]
    @admin = true if cookies.signed[:admin]
  end

  def signed_in?
    unless @signed_in
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
