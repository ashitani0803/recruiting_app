class EntriesController < ApplicationController
	before_action :user_login?
	before_action :prevent_admin
	
	def index
		@entries = current_user.entries
		@features = Feature.all
  	end

	def create
		@recruit = Recruit.find(params[:recruit_id])
		@entry = current_user.entries.new(recruit_id: params[:recruit_id])
		@entry.save
		@company = @recruit.company
		@room = current_user.rooms.new(company_id: @company.id)
		@room.save
		flash[:success] = "募集にエントリーしました。"
		redirect_to company_room_path(@company, @room)
	end

	private

	def prevent_admin
		if current_user.authority_status == "admin"
			redirect_to admin_path(current_user.company)
		end
	end

end
