class SessionsController < ApplicationController
  before_action :redirect_user_to_cats_if_already_signed_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      user_params[:username],
      user_params[:password]
    )

    if @user.nil? # incorrect login
      flash.now[:errors] = "INCORRECT LOGIN"
      render :new
    else # correct login
      @user.reset_session_token!
      login!(@user)
      redirect_to cats_url
    end
  end

  def destroy
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
