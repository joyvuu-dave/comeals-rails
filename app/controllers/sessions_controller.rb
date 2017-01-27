class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    error_message = nil

    # Scenario #1: Error - missing resident param
    if params[:resident_id].blank?
      error_message = 'Select a resident'
    end

    resident = Resident.find_by(id: params[:resident_id])

    # Scenario #2: Error - No resident with that id
    if params[:resident_id].present? && resident.nil?
      error_message = 'Resident not found'
    end

    # Scenario #3: Success - Resident doesn't have a password
    if resident.present? && resident.password_digest.nil?
      flash[:notice] = "#{resident.name} signed in without a password"
    end

    # Scenario #4: Error - No password passed in
    if resident.present? && resident.password_digest.present? && params[:password].blank?
      error_message = 'Password required'
    end

    # Scenario #5: Error - Incorrect password
    if resident.present? && resident.password_digest.present? && params[:password].present? && !resident.try(:authenticate, params[:password])
      error_message = 'Incorrect password'
    end

    # Scenario #6: Success - Correct password
    if resident.present? && resident.password_digest.present? && params[:password].present? && resident.try(:authenticate, params[:password]).present?
      flash[:notice] = "#{resident.name} signed in with a password"
    end

    # ########
    # RESPONSE
    ##########
    respond_to do |format|
      if error_message.present?
        # Scenario #1: Error
        flash.now[:alert] = error_message
        cookies.delete(:resident_id)
        cookies.delete(:signed_in)
        cookies.delete(:admin)
        format.html { render 'new' }
        format.json { render json: { error: error_message }, status: :bad_request }
      else
        # Scenario #2: Success
        cookies.permanent.signed[:resident_id] = resident.id
        cookies.permanent.signed[:signed_in] = true
        cookies.permanent.signed[:admin] = resident.admin
        format.html { redirect_to :root }
        format.json { render json: resident }
      end
    end
  end

  # DELETE /logout
  def delete
    cookies.delete(:resident_id)
    cookies.delete(:signed_in)
    cookies.delete(:admin)
    redirect_to :root
  end
end
