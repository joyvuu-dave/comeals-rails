# == Schema Information
# Schema version: 20160324173111
#
# Table name: communities
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cap             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rotation_length :integer
#  time_zone       :string           default("UTC"), not null
#
# Indexes
#
#  index_communities_on_name  (name) UNIQUE
#

class CommunitiesController < ApplicationController
  before_action :signed_in?
  before_action :admin?, except: [:index]
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  # GET /communities
  def index
    @communities = Community.all
  end

  # GET /communities/1
  def show
  end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities/new
  def create
    @community = Community.new(community_params)
    if @community.save
      redirect_to communities_url, notice: 'Community was successfully created.'
    else
      render :new
    end
  end

  # PATCH /communities/1/edit
  def update
    if @community.update(community_params)
      redirect_to communities_url, notice: 'Community was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /communities/1
  def destroy
    if @community.destroy
      redirect_to communities_url, notice: 'Community was successfully destroyed.'
    else
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:name, :cap, :rotation_length)
    end
end
