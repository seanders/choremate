class SuggestionsController < ApplicationController
  before_filter :require_household

  def create
    @suggestion = @household.suggestions.new(title: params[:title]) if params.has_key? :title
    @suggestion.description = params[:description] if params.has_key? :description
    @suggestion.point_value = params[:point_value] if params.has_key? :point_value
    @user.suggestions << @suggestion
    @suggestion.save!
  end

  protected

  def require_household
    unless @household = Household.includes(:chores).where(id: params[:household_id]).first
      render json: {error: "Household not found"}, status: :not_found
    end
  end
end
