class SessionsController < ApplicationController
  skip_before_action :auth_required

  def create
    session[:user_email] = auth_hash['info']['email']
    session[:user_image] = auth_hash['info']['image']

    if !authenticated?
      flash[:notice] = 'Debes ingresar con una cuenta de CIMAV'
    end
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to '/login'
  end

  def failure
    render :plain => '403 Auth method has failed', :status => 403
  end

  protected
  def auth_hash
    request.env['omniauth.auth']
  end
end