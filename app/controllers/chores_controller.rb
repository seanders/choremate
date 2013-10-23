class ChoresController < ApplicationController
  before_filter :require_household
  before_filter :require_auth

  def index
    @chores = @household.chores
  end

  def create
    @chore = @household.chores.new(title: params[:title]) if params.has_key?(:title)
    @chore.description = params[:description] if params.has_key?(:description)
    @chore.point_value = params[:point_value] if params.has_key?(:point_value)
    @chore.save!
  end

  def update

  end


  def destroy

  end


 protected

  def require_household
    unless @household = Household.includes(:chores).where(id: params[:household_id]).first
      render json: {error: "Household not found"}, status: :not_found
    end
  end
end
