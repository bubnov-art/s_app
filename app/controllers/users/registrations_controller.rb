class Users::RegistrationsController < Devise::RegistrationsController

	def create
    ActiveRecord::Base.transaction do
      params[:user][:state] = 2
      super
    end
  end
	
	private

  def sign_up_params
    params.require(:user).permit(
      :first_name, :last_name, :second_name, :city, :email, :phone, :password, :password_confirmation, :state, :pass_file
    )
  end

  def account_update_params
    params.require(:user).permit(
      :first_name, :last_name, :second_name, :city, :email, :phone, :password, :password_confirmation, :current_password
    )
  end

  protected

  def after_sign_up_path_for(resource)
    '/account'
  end
end
