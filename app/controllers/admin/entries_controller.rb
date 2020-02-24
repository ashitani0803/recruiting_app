class Admin::EntriesController < ApplicationController
	before_action :admin_user?

  def candidate_list
  end

  def candidate_show
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
