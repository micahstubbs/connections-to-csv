class SessionsController < ApplicationController
  def create
  	#raise request.env["omniauth.auth"].to_yaml
  	user = User.from_omniauth(env["omniauth.auth"])
  	session[:user_id] = user.id
  	redirect_to root_url, notice: "Authorized with LinkedIn!"
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "Signed out!"
  end


    

end