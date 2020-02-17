class Admin::CompaniesController < ApplicationController
	before_action :my_company

	def home
	end

	def edit
	end

	def update
	end

	def destroy
	end

	def add_employee
	end

	def remove_employee
	end

	private

	def my_company
		@company = current_user.company
	end
end
