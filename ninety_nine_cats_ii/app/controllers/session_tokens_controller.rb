class SessionTokensController < ApplicationController
  def destroy
    token = SessionToken.find_by(id: params[:id])
    if token.session_token == session[:session_token]
      token.delete
      redirect_to '/'
    else
      token.delete
      redirect_to user_url(current_user)
    end
  end
end
