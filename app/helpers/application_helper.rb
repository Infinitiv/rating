module ApplicationHelper
  def current_user
    User.find_by_id(session[:user_id])
  end
  
  def current_user_editor?
    current_user.group.editor unless current_user.nil?
  end
end
