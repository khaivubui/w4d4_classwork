class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :login!

  def login!(user)
    @current_user = user
    new_token = SessionToken.create(user_id: @current_user.id,
                                    device_info: request.env["HTTP_USER_AGENT"])
    session[:session_token] = new_token.session_token
  end

  def current_user
    return nil if session[:session_token].nil?
    token = SessionToken.find_by(session_token: session[:session_token])
    if token.nil?
      session[:session_token] = nil
      return nil
    end
    @current_user ||= User.find_by(id: token.user_id)
  end

  def redirect_user_to_cats_if_already_signed_in
    if current_user
      redirect_to cats_url
    end
  end

  def ensure_correct_user
    id = params[:id] if self.class == CatsController
    id = current_cat_rental_request.cat_id if self.class == CatRentalRequestsController
    redirect_to "/" if current_user.cats.where(id: id).empty?
  end
end
