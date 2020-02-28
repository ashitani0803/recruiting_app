class SupportsController < ApplicationController
	before_action :user_login?
	before_action :twitter_client, only: [:create]

	def create
		@recruit = Recruit.find(params[:recruit_id])
		@support = current_user.supports.new(recruit_id: params[:recruit_id])
		@support.save
		@client.update("#{@recruit.title}\n#{url_for(@recruit)}")
		flash[:success] = "募集を応援しました。"
		redirect_to recruit_path(@recruit)
	end

	private

	def twitter_client
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key = ENV["CONSUMER_KEY"]
			config.consumer_secret = ENV["CONSUMER_SECRET"]
			config.access_token = ENV["ACCESS_TOKEN"]
			config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
		end
	end
end
