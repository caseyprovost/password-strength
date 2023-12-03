class Users::RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.turbo_stream {
          flash[:notice] = "You successfully signed up"
          redirect_to dashboard_controller, status: :see_other
        }
      else
        format.turbo_stream {}
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
