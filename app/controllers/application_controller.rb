class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login


  protected

  def current_user
    @current_user = session[:current_user_id] && User.find(session[:current_user_id])
  end

  def require_login
    unless session[:current_user_id]
      flash[:error] = "Please login first"
      redirect_to :controller => :sessions, :action => :new
    end
  end
end
