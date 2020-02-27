class MessagesController < ApplicationController
	before_action :user_login?

	def create
		@room = Room.find(params[:room_id])
		@message = Message.new(message_params)
		if current_user.authority_status == "admin"
			@message.is_user = false
		else
			@message.is_user = true
		end
		@message.room_id = @room.id
		@message.save
		if current_user.authority_status == "admin"
			redirect_to admin_company_candidate_show_path(current_user.company, @room.user)
		else
			redirect_to company_room_path(@room.company, @room)
		end
	end

	private

	def message_params
		params.require(:message).permit(:content)
	end
end
