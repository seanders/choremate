class UsersController < ApplicationController

   def login
    if !(@user = User.find_by_email(params[:email]))
      render json: {error: "Unable to find account.", email_is_registered: false}
    elsif !@user.authenticate(params[:password])
      render json: {error: "Password is incorrect.", email_is_registered: true}
    else
      @user
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def create
    person_params = {
      email:        params[:email],
      display_name: params[:display_name],
      first_name:   params[:first_name],
      last_name:    params[:last_name],
      password:     params[:password],
      password_confirmation: params[:password]
    }
    @user = User.create!(person_params)
  end

end
