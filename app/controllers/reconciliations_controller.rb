# == Schema Information
# Schema version: 20160210160946
#
# Table name: reconciliations
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReconciliationsController < ApplicationController
  before_action :admin?

  # POST /reconciliations
  def create
    @reconciliation = Reconciliation.new

    if @reconciliation.save
      redirect_to meals_path, notice: 'All outstanding meals have been reconciled.'
    else
      flash.now[:error] = 'Reconciliation could not be created.'
      redirect_to admin_path
    end
  end
end
