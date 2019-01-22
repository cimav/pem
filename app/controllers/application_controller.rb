class ApplicationController < ActionController::Base
  before_action :auth_required

  def authenticated?
    if session[:user_auth].blank?
      session[:user_auth] = session[:user_email].split("@").last == "cimav.edu.mx" if session[:user_email]
    else
      session[:user_auth]
    end
  end

  def auth_required
    redirect_to '/login' unless authenticated?
  end

end
