class Admin::UsersController < Admin::BaseController
	
		def index
			@users = User.customers.order("id ASC")
		end

		def show
			@user = User.find(params[:id])
			@user_state = User.states[@user.state]
		end

		def change_user_state
			@user = User.find(params[:state].split('-').last)
			state = params[:state].split('-')[1].to_i
			@user.update_attributes(state: state)
			respond_to do |format|
				format.js {}
			end
		end
end 