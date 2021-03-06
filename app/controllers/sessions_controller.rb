class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash.now[:error] = 'Your email or password was incorrect!'
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = 'You have successfully logged out!'
    redirect_to welcome_index_path
  end
end
