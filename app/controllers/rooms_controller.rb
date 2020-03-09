class RoomsController < ApplicationController
	before_action :user_login?

	def show
		@company = Company.find(params[:company_id])
		@room = current_user.rooms.find_by(company_id: @company.id)
		@message = Message.new
		@messages = @room.messages
		
	end

	private

end
