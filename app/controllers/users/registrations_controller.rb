class Users::RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "You successfully signed up"
      redirect_to dashboard_controller
    else
      render :new
    end
  end

  def new
    @user = User.new
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
