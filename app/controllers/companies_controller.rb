class CompaniesController < ApplicationController

  def top
  end

  def about
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def member
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
    @members = @company.users
  end

  def show
    @company = Company.find(params[:id])
    @headquarters = @company.addresses.find_by(head_status: "head")
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if User.find_by(email: @company.email)
      admin = User.find_by(email: @company.email)
      if admin.company_id.present?
        flash.now[:alert] = "会社の登録に失敗しました。"
        render :new
      else
        admin.name = @company.person_name
        admin.phone_number = @company.phone_number
        admin.authority_status = "admin"
        if @company.save
          admin.company_id = @company.id
          if admin.save
            sign_in(admin)
            flash[:success] = "会社を登録しました。"
            redirect_to edit_admin_company_path(@company)
          else
            @company.really_destroy!
            flash.now[:alert] = "会社の登録に失敗しました。"
            render :new
          end
        else
          flash.now[:alert] = "会社の登録に失敗しました。"
          render :new
        end
      end
    else
      admin = User.new
      admin.name = @company.person_name
      admin.email = @company.email
      admin.phone_number = @company.phone_number
      admin.authority_status = "admin"
      generated_password = Devise.friendly_token.first(12)
      admin.password = generated_password
      if @company.save
        admin.company_id = @company.id
        if admin.save(validate: false)
          sign_in(admin)
          PasswordMailer.send_password(admin, generated_password).deliver
          flash[:success] = "会社を登録しました。"
          redirect_to edit_admin_company_path(@company)
        else
          @company.really_destroy!
          flash.now[:alert] = "会社の登録に失敗しました。"
          render :new
        end
      else
        flash.now[:alert] = "会社の登録に失敗しました。"
        render :new
      end
    end

    
  end

  private

  def company_params
    params.require(:company).permit(:company_name, :person_name, :email, :phone_number)
  end

end
