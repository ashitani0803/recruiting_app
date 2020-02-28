class BookmarksController < ApplicationController
	before_action :user_login?

  	def index
  		@bookmarks = current_user.bookmarks
  	end

	def create
		@bookmark = current_user.bookmarks.new(recruit_id: params[:recruit_id])
		@bookmark.save
		@recruit = Recruit.find(params[:recruit_id])
		flash.now[:suucess] = "あとで見るに追加しました"
		render 'index.js.erb'
	end

	def destroy
		@bookmark = Bookmark.find_by(user_id: current_user.id, recruit_id: params[:recruit_id])
		@bookmark.destroy
		@recruit = Recruit.find(params[:recruit_id])
		render 'index.js.erb'
	end
end
