class FavoritesController < ApplicationController
	before_action :user_login?
	
	def create
		@like = current_user.favorites.new(feed_id: params[:feed_id])
		@like.save
		@feed = Feed.find(params[:feed_id])
		render 'index.js.erb'
	end

	def destroy
		@like = Favorite.find_by(user_id: current_user.id, feed_id: params[:feed_id])
		@like.destroy
		@feed = Feed.find(params[:feed_id])
		render 'index.js.erb'
	end
end
