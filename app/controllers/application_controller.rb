class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :current_user
  layout :user_layout

  def current_user
    @current_user = User.find_by_id(session[:user_id])
    @current_user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def require_login
    unless logged_in?
      flash[:error] = "You mast be logged in"
      redirect_to login_path
    end
  end
  
  def require_viewer
    unless current_user_viewer?
      flash[:error] = "You mast have viewer`s permissions"
      redirect_to :back
    end
  end
  
  def require_editor
    unless current_user_editor?
      flash[:error] = "You mast have editor`s permissions"
      redirect_to :back
    end
  end
  
  def require_administrator
    unless current_user_administrator?
      flash[:error] = "You mast have administrator`s permissions"
      redirect_to :back
    end
  end 
  
  def current_user_viewer?
    current_user.group.viewer unless current_user.nil?
  end
  
  def current_user_editor?
    current_user.group.editor unless current_user.nil?
  end

  def current_user_administrator?
    current_user.group.administrator unless current_user.nil?
  end
  
  def user_layout
    if current_user_administrator?
      "admin"
    else
      "application"
    end
  end
end
