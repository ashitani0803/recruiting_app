class BookmarksController < ApplicationController
	before_action :user_login?

  	def index
  		@bookmarks = current_user.bookmarks
  	end

	def create
		@recruit = Recruit.find(params[:recruit_id])
		@bookmark = current_user.bookmarks.new(recruit_id: params[:recruit_id])
		@bookmark.save
		flash.now[:success] = "あとで見るに追加しました"
		render 'index.js.erb'
	end

	def destroy
		@recruit = Recruit.find(params[:recruit_id])
		@bookmark = Bookmark.find_by(user_id: current_user.id, recruit_id: params[:recruit_id])
		@bookmark.destroy
		render 'index.js.erb'
	end
end
