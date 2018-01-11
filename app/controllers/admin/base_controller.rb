class Admin::BaseController < ApplicationController
	layout 'admin'
	
	before_action :authenticate_user!
	before_action :require_admin
  
  def method_name
  	
  end

  def require_admin
    unless current_user.admin?
    	flash[:error] = t('no_permission')
      redirect_to root_path
    end
  end

end