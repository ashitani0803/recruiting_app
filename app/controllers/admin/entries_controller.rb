class Admin::EntriesController < ApplicationController
	before_action :admin_user?

  def candidate_list
	@recruits = @company.recruits
  end

  def candidate_show
	@candidate = User.find(params[:id])
	@room = @company.rooms.find_by(user_id: @candidate.id)
	@message = Message.new
	@messages = @room.messages
  end

  private

  def admin_user?
  	if current_user.authority_status == "admin"
		@admin = current_user
		@company = @admin.company
	elsif user_signed_in?
		redirect_to recruits_path
	else
		redirect_to root_path
	end
  end
end
