class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :has_been_banned?
  protected
  
  def after_sign_in_path_for(resource)
  	current_user.admin? ? '/admin/users': '/account'
  end


  def has_been_banned?
    if current_user && current_user.state == 4
      sign_out current_user
      flash[:error] = t("banned")
      root_path
    end
  end
end
