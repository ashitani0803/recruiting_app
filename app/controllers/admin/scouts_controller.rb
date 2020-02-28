class Admin::ScoutsController < ApplicationController
	before_action :admin_user?

	 def search
		@candidates = User.scout_search(params[:search])
  	end

	def create
		@scout = @company.scouts.new(user_id: params[:user_id])
		@scout.save
		@user = @scout.user
		@company = current_user.company
		@room = @company.rooms.new(user_id: @user.id)
		@room.save
		flash[:success] = "スカウトに成功しました。"
		redirect_to admin_company_candidate_show_path(@company, @user)
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
