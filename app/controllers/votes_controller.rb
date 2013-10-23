class VotesController < ApplicationController
  before_filter :require_suggestion
  before_filter :require_household
  before_filter :require_auth

  def create
    @vote = @user.votes.new(approve: params[:approve]) if params[:approve]
    @vote.suggestion = @suggestion
    @vote.household = @household
    unless @vote.save
      render json: {error: @vote.errors.full_messages.to_sentence}, status: :unprocessable_entity
    end
  end

  protected

  def require_suggestion
    unless @suggestion = Suggestion.includes(:votes).where(id: params[:suggestion_id]).first
      render json: {error: "Suggestion not found"}, status: :not_found
    end
  end

  def require_household
    unless @household = Household.includes(:chores).where(id: params[:household_id]).first
      render json: {error: "Household not found"}, status: :not_found
    end
  end

end
