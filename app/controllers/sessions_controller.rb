class SessionsController < ApplicationController
  def new
    unless session[:current_user_id].nil?
      flash[:warn] = "You are already logged in"
      redirect_to :back
    end
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    respond_to do |format|
      if user
        session[:current_user_id] = user.id
        format.html { redirect_to projects_path }
      else
        flash[:error] = "Incorrect username or password"
        format.html { render :new }
      end
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to :action => :new
  end

end
