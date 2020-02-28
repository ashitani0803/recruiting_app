class Admin::CompaniesController < ApplicationController
	before_action :admin_user?

	def home
	end

	def edit
	    @company.addresses.build
	end

	def update
		if @company.update(company_params)
			flash[:success] = "会社情報を更新しました。"
			redirect_to admin_path(@admin)
		else
			flash.now[:alert] = "更新に失敗しました。"
			render :edit
		end
	end

	def destroy
		@company = Company.find(params[:id])
		@company.destroy
		flash[:info] = "会社アカウントを削除しました。"
		redirect_to recruits_path
	end

	def employee_index
		@members = @company.users
	end

	def invite_new
	end

	def invite
		if params[:email]
			user = User.find_by(email: params[:email])
			if user.company_id == nil || user.company_id != @company.id
				CompanyMailer.send_mail(user, @company).deliver
				redirect_to admin_employee_index_path
				flash[:info] = "招待メールを送りました。"
			else
				flash.now[:alert] = "すでに社員登録されています。"
				render :invite_new
			end
		end
	end

	def add_employee
		user = User.find(params[:id])
		user.company_id = @company.id
		user.authority_status = "general"
		user.save
		flash[:success] = "社員登録に成功しました。"
		redirect_to recruits_path
	end

	def remove_employee
		member = User.find(params[:id])
		member.company_id = nil
		member.save
		flash[:info] = "社員登録を解除しました。"
		redirect_to admin_employee_index_path
	end

	def add_authority
		member = User.find(params[:id])
		member.authority_status = "admin"
		member.save
		flash[:success] = "管理者権限を付与しました。"
		redirect_to admin_path(member.company)
	end

	def remove_authority
		@admin.authority_status = "general"
		@admin.save
		flash[:info] = "管理者権限を削除しました。"
		redirect_to admin_path(current_user.company)
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

	def company_params
		params.require(:company).permit(:logo, :establish_year, :establish_month, :link, :mission_title, :mission_body, :value, :what, :why, :how, addresses_attributes: [:id, :head_status, :postal_code, :prefecture, :municipality, :building, :_destroy])
	end
end
