class HouseholdsController < ApplicationController

  before_filter :require_auth

  def show
    @household = Household.find(params[:id])
  end

  def create
    @household = Household.new(name: params[:name]) unless params[:name].blank?
    if @household.valid? && @household.save
      @user.households << @household
      render "households/show", status: :created
    else
      render json: { error: @household.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  def add_members
    #expect to receive an array of emails here
    @household = Household.find(params[:id])
    emails = params[:emails]
    users = User.where :email => emails  #refactor for single additions. move to household model
    users.each do |user|
      @household.users << user
    end
    render "households/show", status: :created
  end


end
