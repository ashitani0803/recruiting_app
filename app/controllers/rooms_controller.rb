class RoomsController < ApplicationController
	before_action :user_login?

	def show
		@company = Company.find(params[:company_id])
		@room = current_user.rooms.find_by(company_id: @company.id)
		@message = Message.new
		@messages = @room.messages
		
	end

	private

	def prevent_admin
		if current_user.authority_status == "admin"
			redirect_to admin_path(current_user.company)
		end
	end

end
