class LoginController < ApplicationController
  def new
   
  end
  
  def create
    @user = Authenticator.authenticate(params[:email], params[:password])
    if @user
      reset_session
      session[:user_id] = @user.id
      redirect_to root_path
    else
      #flash.now[:alert] = t("flash.login.create.alert")
      render :new
    end
  end
end