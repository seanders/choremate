class HouseholdInvitesController < ApplicationController
  before_filter :require_auth
  before_filter :require_household
  before_filter :require_invite, except: [:create]

  def create
    @invite = @household.invites.new(email: params[:email]) if params.has_key?(:email)
    @invite.save!
    HouseholdInviteMailer.send_invite(@household, @invite).deliver
    render "household_invites/create", status: :ok
  end

  def accept
    if @invite.accept!(@user)
      render json: { status: "ok" }, status: :ok
    else
      render json: {status: "Error"}, stauts: :unprocessable_entity
    end
  end

  def reject
    @invite.reject!
    render json: {status: "OK"}, status: :ok
  end

  private

  def require_household
    #user where vs. find to return NIL value if nothing found
    unless @household = Household.where(id: params[:household_id]).first
      render json: {error: "Household not found"}, status: :not_found
    end
  end

  def require_invite
    require_household unless @household
    @invite = @household.invites.where(token: params[:token]).first
    unless @invite && HouseholdInvite.token_valid?(params[:token])
      render json: { error: "Not allowed" }, status: :forbidden
    end
  end

end
