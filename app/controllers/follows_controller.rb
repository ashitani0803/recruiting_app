class FollowsController < ApplicationController
	before_action :user_login?

  	def index
  		@follows = current_user.follows
  	end

	def create
		@follow = current_user.follows.new(company_id: params[:company_id])
		@follow.save
		@company = Company.find(params[:company_id])
		render 'index.js.erb'
	end

	def destroy
		@follow = Follow.find_by(user_id: current_user.id, company_id: params[:company_id])
		@follow.destroy
		@company = Company.find(params[:company_id])
		render 'index.js.erb'
	end
end
