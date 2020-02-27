class RoomsController < ApplicationController
	before_action :user_login?

	def show
		@company = Company.find(params[:company_id])
		@room = current_user.rooms.find_by(company_id: @company.id)
		@message = Message.new
		@messages = @room.messages
		
	end
=begin
	def create
		if current_user.authority_status == "admin"
			@user = User.find(params[:user_id])
			@company = current_user.company
			@room = @company.rooms.new(user_id: @user.id)
			@room.save
			redirect_to admin_candidate_show_path(@company, @user)
		else
			@company = Company.find(params[company_id])
			@room = current_user.rooms.new(company_id: @company.id)
			@room.save
			redirect_to company_room_path(@company, @room)
		end 
	end
=end
	private

end
